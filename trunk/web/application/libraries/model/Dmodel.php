<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 公共数据调用类 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Dmodel {
	private $ci;
	private $model;                          //默认model
	private $init;                           //默认类
	
	function __construct(){
		$this->ci = ci();
		$this->model = model("dmodel");	
	}
	function init($init){
		$this->init=$init;
		$this->model->set_openno($this->init->sql_open_no);
	}
	/**
	 * 获取代理信息,基于域名
	 */
	function host(){
		$cache_key = $this->model->memcache->key_host;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = $this->init->token.$this->model->memcache->key_host.$cache_no;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$data = $this->model->get($this->model->table_agent_host_more, array("web_host"=>HOST,'status'=>'Y'));
			$host = $this->model->table($this->model->table_agent_host);
			$version = $this->model->table($this->model->table_agent_version);
			if(isset($data['agent_id'])){
				$sql = "select h.*,v.version from {$host} h, {$version} v where h.version_id=v.id and h.isadmin='N' "
					  ."and h.del='N' and v.del='N' and v.isadmin='N' and h.agent_id='".$data['agent_id']."'";
				$info = $this->model->one($sql);
				if(isset($info['agent_id']))$info['web_host']=$data['web_host'];
			}else{
				$sql = "select h.*,v.version from {$host} h, {$version} v where h.version_id=v.id and h.isadmin='N' "
					  ."and h.del='N' and v.del='N' and v.isadmin='N' and h.web_host='".HOST."'";
				$info = $this->model->one($sql);
			}
			if(isset($info['agent_id']) && $info['agent_id']>0){
				$cache = $info;
				$this->model->memcache->set($cache_key, $info);
			}
		}
		return $cache;
	}
	/**
	 * 操作session
	 * @param $type 操作类型
	 * @param $data 数据
	 */
	function session($type="get",$data=null){
		if(empty($this->init->token))return false;
		$cache_key = $this->init->token.$this->model->memcache->key_session;
		switch ($type){
			case "get":
				$cache = $this->model->memcache->get($cache_key);
				if(empty($cache) || $this->model->memcache->status==false){
					$cache = null;
					//删除超出时间的session记录，减少数据库负荷
					$time = time() - $this->init->session_time*3600;
					$this->model->tdel($this->model->table_session, array("updatetime <" => $time));
					$info = null;
					$session = $this->model->get($this->model->table_session, array("token"=>$this->init->token,"host"=>HOST,"isadmin"=>"N"));
					if(isset($session['session'])){
						$info = json_decode($session['session'],true);
						//添加缓存
						$this->model->memcache->set($cache_key, $info);
						//修改session最后活动时间
						$this->session("edit");
					}
					$cache = $info;
				}
				return $cache;
				break;
			case "del":
				$this->model->del($this->model->table_session, array("token"=>$this->init->token));
				break;
			case "edit":
				//修改最后session时间
				if(empty($data))$data=array("updatetime"=>time());
				$this->model->edit($this->model->table_session, $data, array("token"=>$this->init->token));
				break;
			case "save":
				$session = $this->model->get($this->model->table_session, array("token"=>$this->init->token,"isadmin"=>"N","host"=>HOST));
				$bol = false;
				if(isset($session['session'])){  //若已有记录，更新
					if($this->model->edit($this->model->table_session, array("session"=>json_encode($data)), array("token"=>$this->init->token))){
						$bol = true;
					}
				}else{ //若没有session记录，添加
					$info = array(
							"token"=>$this->init->token,
							"session"=>json_encode($data),
							"isadmin"=>"N",
							"host"=>HOST,
							"ip"=>$this->init->ip ,
							"updatetime"=>time(),
							"addtime"=>time()
					);
					$this->model->save($this->model->table_session, $info);
					$bol = true;
				}
				if($bol){//删除现有缓存
					$this->model->memcache->delete($cache_key);
				}
				return $bol;
		}
		return false;
	}
	/**
	 * 获取配置信息
	 */
	function setting(){
		$cache_key = $this->model->memcache->key_setting.$this->init->agent_id;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "setting".$cache_key.$cache_no;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = array();
			$data1 = $this->model->get_list( $this->model->table_setting, array('agent_id'=>0),1000);
			foreach($data1['rows'] as $v){
				$info[$v['type']][$v['skey']]=$v['svalue'];
			}
			$data2 = $this->model->get_list( $this->model->table_setting, array('agent_id'=>$this->init->agent_id),1000);
			foreach($data2['rows'] as $v){
				$info[$v['type']][$v['skey']]=$v['svalue'];
			}
			if(!empty($info) && count($info)>0){
				$cache = $info;
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
	/**
	 * 访问页面记录
	 */
	function view(){
		if($this->init->uid<1)return false;
		$param['post']=$_POST;
		$param['get']=$_GET;
		$param = json_encode($param);
		$data = array(
				"url"=>$this->init->url,
				"param"=>$param,
				"username"=>$this->init->username,
				"uid"=>$this->init->uid,
				"ip"=>$this->init->ip,
				"agent_id"=>$this->init->agent_id,
				"addtime"=>time()
		);
		$this->model->save($this->model->table_admin_view,$data);
	}
	/**
	 * 获取唯一编号，插入数据库不重复
	 * @param $len 长度
	 * @param $title 前缀
	 * @param $t 生成的次数
	 */
	function get_only_no($len=18,$title="",$t=1){
		$no = get_rand($len,$title);
		$data = $this->model->get($this->model->table_only_no, array("no"=>$no));
		$t  = $t+1;
		if($t>10){
			$no = $title.date('ymdHis').rand(10000, 99999);
			write_log("唯一编号生成次数异常，停止生成，防止死循环,时间生成{$no}");
			return $no;
		}
		if(isset($data['no'])){
			return $this->get_only_no($len,$title);
		}
		if($this->model->save($this->model->table_only_no,array("no"=>$no),"true")== false){
			return $this->get_only_no($len,$title);
		}
		return $no;
	}
	/**
	 * 获取游戏类型,默认返回所有游戏类型，包括没激活游戏
	 */
	function get_game_type_list($type="list"){
		$cache_key = $this->model->memcache->key_game_type;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = $this->init->token.$cache_key.$cache_no;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = $this->model->get_list($this->model->table_game_type, array("del"=>"N"), 1000);
			if(!empty($info['rows']) && count($info['rows'])>0 && $info['total']>0){
				$cache = $info;
				$this->model->memcache->set($cache_key, $cache);
			}
		}
		if(empty($cache) || (isset($cache['total']) && $cache['total']<1))return $cache;
		$info = null;
		switch ($type){
			case 'status':  //所有激活的游戏
				$cache = $cache['rows'];
				foreach ($cache as $k=>$v){
					if($v['status']=='N')continue;
					$info[$v['code']]=$v['name'];
				}
				return $info;
				break;
			case 'agent':  //根据代理id获取代理游戏
				$agent = $this->model->get($this->model->table_agent,array("id"=>$this->init->sel_agent_id));
				$agent = isset($agent['id'])?ex($agent['game_type']):array();
				foreach ($cache['rows'] as $k=>$v){
					$info[$v['code']]=0;
					if($this->init->sel_agent_id==$this->init->default_admin_agent_id){
						$info[$v['code']]=1;
						continue;
					}
					foreach($agent as $vv){
						if(!empty($vv) && $v['code']==$vv)$info[$v['code']]=1;
					}
				}
				return $info;
				break;
			default:
				break;
		}
		return $cache;
	}
	/**
	 * 获取信息
	 * @param $type 1滚动信息，2个人中心信息
	 */
	function get_message_notice($type,$limit=1){
		$cache_key = $this->model->memcache->key_message;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = $this->init->token.$cache_key.$cache_no."_".$type."_".$limit;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$data = $this->model->get_list($this->model->table_message_notice, array("agent_id"=>$this->init->agent_id,"type"=>$type),$limit,0,array("addtime"));
			if($data['total']>0 && count($data['rows']>0)){
				$cache = $data['rows'];
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
	/**
	 * 获取用户银行类别
	 */
	function get_user_banktype(){
		$cache_key = $this->model->memcache->key_user_banktype."_".$this->init->agent_id;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = $this->init->token.$cache_key.$cache_no;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$data = $this->model->get_list($this->model->table_users_banktype, array("agent_id"=>$this->init->agent_id),1000);
			if($data['total']>0 && count($data['rows']>0)){
				$cache = $data['rows'];
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
	/**
	 * 获取用户的用户组信息
	 */
	function get_user_group(){
		$cache_key = $this->init->token."_get_user_group".$this->init->uid;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$data = $this->model->get($this->model->table_users_group, array("id"=>$this->init->group_id));
			if(isset($data['id'])){
				$cache = $data;
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
}