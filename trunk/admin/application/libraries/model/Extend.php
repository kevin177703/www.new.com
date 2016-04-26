<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 推广代理  2015.09.03
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Extend {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//代理管理,返水设置
	function get_rebate(){
		//获取代理的游戏
		$agent = $this->model->get($this->model->table_agent, array("id"=>$this->init->sel_agent_id));
		$game_type = $agent['game_type'];
		$game_type = ex($game_type);
		//获取所有激活的游戏
		$game = $this->init->d->get_game_type_list("status");
		//获取代理已经设置过返水的游戏
		$extend = $this->model->get_list($this->model->table_agent_extend,array("agent_id"=>$this->init->sel_agent_id),1000);
		$extend = $extend['rows'];
		$info = array();
		$i = 0;
		foreach ($game as $k=>$v){
			foreach ($game_type as $gt){
				if(empty($gt))continue;
				if($k==$gt){
					$info[$i]['name']=$v;
					$info[$i]['code']=$k;
					$info[$i]['max']=0.00;
					$info[$i]['min']=0.00;
					if(!empty($extend) && count($extend)>0){
						foreach ($extend as $e){
							if($e['game_type']==$k){
								$info[$i]['max']=$e['max'];
								$info[$i]['min']=$e['min'];
							}
						}
					}
					$i++;
				}
			}
		}
		$this->init->assign(array("data"=>$info));
	}
	//代理管理,返水设置
	function ajax_rebate(){
		$data = post("data");
		if(empty($data))json_error("提交数据为空");
		$data = ex($data,";");
		$post = array();
		foreach ($data as $v){
			if(empty($v) || $v<0)continue;
			$_d = ex($v,":");
			$post[$_d[0]]=$_d[1];
		}
		//获取代理的游戏
		$agent = $this->model->get($this->model->table_agent, array("id"=>$this->init->sel_agent_id));
		$game_type = $agent['game_type'];
		$game_type = ex($game_type);
		//获取所有激活的游戏
		$game = $this->init->d->get_game_type_list("status");
		//获取代理已经设置过返水的游戏
		$extend = $this->model->get_list($this->model->table_agent_extend,array("agent_id"=>$this->init->sel_agent_id),1000);
		$extend = $extend['rows'];
		$_extend = array();
		if(!empty($extend) && count($extend)>0){
			foreach ($extend as $e){
				$_extend[$e['game_type']]=$e['max'];
			}
		}
		$info = array();
		$i = 0;
		$bol = true;
		foreach ($game as $k=>$v){
			foreach ($game_type as $gt){
				if(empty($gt))continue;
				if($k==$gt){
					if(!isset($post[$k."_max"]) || !isset($post[$k."_min"])){
						json_error("{$v}没有设置正确的返水比");
						break;
					}
					if($post[$k."_max"]>20 || $post[$k."_min"]>20){
						json_error("{$v}返水比不能超过20%");
						break;
					}
					if($post[$k."_max"]<$post[$k."_min"]){
						json_error("{$v}最小返水比不能大于最大返水比");
						break;
					}
					if(isset($_extend[$k]) && $_extend[$k]>$post[$k."_max"]){
						json_error("{$v}最大返水比只能增加不能减少");
						break;
					}
					$info[$i]['max']=$post[$k."_max"];
					$info[$i]['game_type']=$k;
					$info[$i]['min']=$post[$k."_min"];
					$info[$i]['agent_id']=$this->init->sel_agent_id;
					$i++;
				}
			}
		}
		$bol = $this->model->add_extend($info, $this->init->sel_agent_id);
		if(!$bol)json_error("设置错误");
		$cache_key = $this->model->memcache->key_agent_extend;
		$this->model->memcache->setNo($cache_key);
		json_ok();
	}
	//推广管理-推广域名
	function get_host(){}
	//推广管理-推广域名
	function ajax_host(){
		$cache_key = $this->model->memcache->key_host;
		switch ($this->init->action){
			case "all":
				$search= post('search');
				$host = $this->model->table($this->model->table_agent_host_more);
				$agent = $this->model->table($this->model->table_agent);
				$sql = "SELECT a.*,b.username FROM {$host} a, {$agent} b where a.agent_id=b.id and a.del='N' and b.del='N' and a.agent_id={$this->init->sel_agent_id}";
				if(!empty($search))$sql .= " and b.username like '%{$search}%'";
				$sql .= " order by a.id desc";
				$data = $this->model->query($sql,$this->init->limit,$this->init->offset);
				foreach ($data['rows'] as $k=>$v){
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$v['addtime']=empty($v['addtime'])?"":date("Y-m-d H:i:s",$v['addtime']);
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post("id");
				$data['web_host'] = post("web_host");
				$data['status'] = post("status");
				if(empty($data['web_host']))json_error("请选输入域名");
				if($id<1){
					$data['agent_id'] = $this->init->sel_agent_id;
					$info = $this->model->get($this->model->table_agent_host, array("agent_id"=>$data['agent_id'],"isadmin"=>'N'));
					if(!isset($info['id']))json_error("需要先绑定主域名，请联系客服");
					$info = $this->model->get($this->model->table_agent_host_more, array("web_host"=>$data['web_host']));
					if(isset($info['id']))json_error("网站域名重复");
						
					$data['addtime']=time();
					if($this->model->save($this->model->table_agent_host_more, $data)==0){
						json_error("添加失败");
					}
				}else{
					$this->init->d->legal($this->model->table_agent_host_more, $id);
					if($this->model->edit($this->model->table_agent_host_more, $data, array("id"=>$id))==false){
						json_error("编辑失败");
					}
				}
				$cache_no = $this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_agent_host_more,true);
				break;
			case "del":
				$this->init->d->del($this->model->table_agent_host_more,$cache_key);
				break;
		}
	}
}