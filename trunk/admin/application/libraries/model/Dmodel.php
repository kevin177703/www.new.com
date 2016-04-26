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
	}
	/**
	 * 获取代理信息,基于域名
	 */
	function host(){
		$cache_key = $this->model->memcache->key_host;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_host_{$cache_key}_{$cache_no}_".HOST;
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$host = $this->model->table($this->model->table_agent_host);
			$version = $this->model->table($this->model->table_agent_version);
			$sql = "select h.*,v.version from {$host} h, {$version} v where h.version_id=v.id "
			."and h.isadmin='Y' and h.del='N' and v.del='N' and v.isadmin='Y' and h.web_host='".HOST."'";
			$info = $this->model->one($sql);
			if(isset($info['agent_id'])){
				$this->model->memcache->set($cache_key, $info);
			}
			$cache = $info;
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
					$session = $this->model->get($this->model->table_session, array("token"=>$this->init->token,"host"=>HOST,"isadmin"=>"Y"));
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
			case "edit":
				//修改最后session时间
				if(empty($data))$data=array("updatetime"=>time());
				$this->model->edit($this->model->table_session, $data, array("token"=>$this->init->token));
				break;
			case "save":
				$session = $this->model->get($this->model->table_session, array("token"=>$this->init->token,"isadmin"=>"Y","host"=>HOST));
				$bol = false;
				if(isset($session['session'])){  //若已有记录，更新
					if($this->model->edit($this->model->table_session, array("session"=>json_encode($data)), array("token"=>$this->init->token))){
						$bol = true;
					}
				}else{ //若没有session记录，添加
					$info = array(
							"token"=>$this->init->token,
							"session"=>json_encode($data),
							"isadmin"=>"Y",
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
	//获取配置信息
	function setting(){
		$cache_key = $this->model->memcache->key_agent_setting_agent.$this->init->sel_agent_id;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_setting_{$cache_key}_{$cache_no}_{$this->init->sel_agent_id}";
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
				"sel_agent_id"=>$this->init->sel_agent_id,
				"addtime"=>time()
		);
		$this->model->save($this->model->table_admin_view,$data);
	}
	/**
	 * 获取菜单
	 */
	function menu(){
		$cache_key = $this->model->memcache->key_menu;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_menu_{$cache_key}_{$cache_no}_{$this->init->token}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$sucess = false;
			$where = array('status'=>'Y','del'=>'N');
			$data = $this->model->get_list($this->model->table_admin_menu,$where,1000,0,array ('o' => 'sort'));
			$data = $data ['rows'];
			$info=array ();
			$rsort=array ();
			$group=ex($this->init->group['menus_list']);
			foreach ( $data as $v ) {
				if ($v ['parent_id'] == 0) {
					$info[$v['id']]['sort']=$v['sort'];
					$info[$v['id']]['menuid']=$v['id'];
					$info[$v['id']]['menuname']=$v['name'];
				} else {
					//正常用户权限
					if(!in_array($v['id'],$group) && $this->init->group_id> $this->init->default_admin_group_id)continue;
					//管理员操作其他代理权限
					if(!in_array($v['id'],$group) && $this->init->group_id == $this->init->default_admin_group_id && $this->init->op_agent_id>0)continue;
					$menus = array('menuid'=>$v['id'],'menuname'=>$v['name'],'url'=>$v['url']);
					$info[$v['parent_id']]['menus'][] = $menus;
				}
			}
			foreach($info as $k=>$v){
				if(!isset($v['menus']))unset($info[$k]);    //不显示无子菜单的菜单项
				if(!isset($v['menuname']))unset($info[$k]); //不显示无父菜单的菜单项
			}
			if(count($info)>0 && !empty($info))$sucess=true;
			$info = array2sort ($info, 'sort');
			$data = '{"menus":[';
			foreach ( $info as $v ){
				$data .= '{';
				$data .= '"menuid":"'.$v['menuid'].'",';
				$data .= '"menuname":"'.$v['menuname'].'",';
				$data .= '"menus":[';
				foreach ( $v ['menus'] as $vv) {
					$data .='{"menuid":"'.$vv['menuid'].'","menuname":"'.$vv['menuname'].'","url":"'.$vv ['url'].'"},';
				}
				$data .= ']},';
			}
			$data .= ']}';
			if($sucess){
				$cache = $data;
				$this->model->memcache->set($cache_key, $cache);
			}
		}
		return $cache;
	}
	/**
	 * 获取代理的权限组
	 */
	function get_group(){
		//若操作代理id大于0，测获取总代理权限
		$group_id = $this->init->op_agent_id>0?$this->init->default_agent_group_id:$this->init->group_id;
		$cache_key = $this->model->memcache->key_menu;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_get_group_{$cache_key}_{$cache_no}_{$group_id}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$group = $this->model->get($this->model->table_admin_group,array('id'=>$group_id));
			if(is_array($group) && count($group)>0){
				unset($group['agent_id']);
				$cache = $group;
				$this->model->memcache->set($cache_key, $cache);
			}
		}
		return $cache;
	}
	/**
	 * 日志写入
	 * @param $content 日志内容
	 * @param $type 参考$this->init->operate
	 * @param $username
	 * @param $uid
	 */
	function log($content,$type,$username=null,$uid=0){
		if(!isset($this->init->operate[$type])){
			write_log("后台日志操作类型不存在{$type}=>{$content}");
			return false;
		}
		$username = empty($username)?$this->init->username:$username;
		$uid = $uid<1?$this->init->uid:$uid;
		$data = array(
				"content"=>$content,
				"type"=>$type,
				"username"=>$username,
				"uid"=>$uid,
				"ip"=>$this->init->ip,
				"agent_id"=>$this->init->agent_id,
				"op_agent_id"=>$this->init->op_agent_id>0?$this->init->op_agent_id : $this->init->agent_id,
				"addtime"=>time()
		);
		$this->model->save($this->model->table_admin_log, $data);
	}
	/**
	 * 获取所有代理
	 */
	function agent_list(){
		$cache_key = $this->model->memcache->key_agent;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_agent_list_{$cache_key}_{$cache_no}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = $this->model->get_list( $this->model->table_agent, array("id >"=>$this->init->default_admin_agent_id),1000);
			if(!empty($info['rows']) && count($info['rows'])>0){
				$cache = $info['rows'];
				$this->model->memcache->set($cache_key, $info['rows']);
			}
		}
		return $cache;
	}
	/**
	 * 获取代理用户组列表
	 */
	function get_agent_user_group_list(){
		$cache_key = $this->model->memcache->key_user_group_agent.$this->init->sel_agent_id;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_get_agent_user_group_list_{$cache_key}_{$cache_no}_{$this->init->sel_agent_id}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = $this->model->get_list($this->model->table_users_group, array("agent_id"=>$this->init->sel_agent_id),1000);
			if(!empty($info['rows']) && count($info['rows'])>0){
				foreach ($info['rows'] as $v){
					$cache[$v['id']]=$v;
				}
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
	/**
	 * 获取资金类型
	 */
	function get_money_type_list(){
		$cache_key = $this->model->memcache->key_money_type;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_get_money_type_list_{$cache_key}_{$cache_no}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = $this->model->get_list($this->model->table_money_type, array(),1000);
			if(!empty($info['rows']) && count($info['rows'])>0){
				foreach ($info['rows'] as $v){
					$cache[$v['id']]=$v;
				}
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
	}
	/**
	 * 获取资金状态
	 */
	function get_money_status_list(){
		$cache_key = $this->model->memcache->key_money_status;
		$cache_no = $this->model->memcache->getNo($cache_key);
		$cache_key = "dmodel_get_money_status_list_{$cache_key}_{$cache_no}";
		$cache = $this->model->memcache->get($cache_key);
		if(empty($cache) || $this->model->memcache->status==false){
			$cache = null;
			$info = $this->model->get_list($this->model->table_money_status, array(),1000);
			if(!empty($info['rows']) && count($info['rows'])>0){
				foreach ($info['rows'] as $v){
					$cache[$v['id']]=$v;
				}
				$this->model->memcache->set($cache_key,$cache);
			}
		}
		return $cache;
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
		if($this->model->save($this->model->table_only_no, array("no"=>$no)) == false){
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
		$cache_key = "dmodel_get_game_type_list_{$cache_key}_{$cache_no}";
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
	 * 判断是否有权限操作
	 * @param  $table 表名
	 * @param  $id 传递的主键参数
	 * @param  $pid 字段，默认id
	 */
	function legal($table,$id,$pid="id"){
		$data = $this->model->get($table, array($pid=>$id));
		if(!isset($data[$pid])){
			$this->log("检查到到数据不存在，表:{$table};{$pid}={$id}",7);
			json_error("数据不存在");
		}
		if($data['agent_id'] != $this->init->sel_agent_id){
			$this->log("检查到非法操作数据，表:{$table};{$pid}={$id}",6);
			json_error("你没有操作权限");
		}
		return true;
	}
	/**
	 * 删除
	 * @param $table 表名
	 * @param $cache_key 缓存id
	 * @param $legal 是否判断权限
	 */
	function del($table,$cache_key=null,$legal=true){
		$id=post("id");
		//判断是否有权限操作
		if($legal)$this->legal($table,$id);
		if($this->model->del($table, array("id"=>$id))){
			//成功后，更新缓存
			if(!empty($cache_key))$this->model->memcache->setNo($cache_key);
			$this->log("删除表{$table}id={$id}", 2);
			json_ok("删除成功");
		}
		json_error("删除失败");
	}
	/**
	 * 获取单条数据,根据id
	 * @param $table 表名
	 * @param $echo 是否直接打印
	 * @param $legal 是否判断权限
	 */
	function one($table,$echo=false,$legal=true){
		$id = post("id");
		//判断是否有权限操作
		if($legal)$this->legal($table,$id);
		$data = $this->model->get($table, array("id"=>$id));
		if(!isset($data['id']))json_error("获取数据失败");
		if($echo)json_ok($data);
		return $data;
	}
}