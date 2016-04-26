<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 信息管理 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Message{
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//信息管理，站内信息设置
	function get_type(){}
	//信息管理，站内信息设置
	function ajax_type(){
		$this->init->lock("message_type");
		$cache_key = $this->model->memcache->key_message_type;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_message_type,array(),$this->init->limit,$this->init->offset,array('id'));
				foreach ($data['rows'] as $k=>$v){
					$v['addtime_wz'] = date("Y-m-d H:i:s",$v['addtime']);
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post("id");
				$content = post("content");
				$title = post("title");
				if(empty($title))json_error("说明不能为空");
				if(empty($content))json_error("信息不能为空");
				$data = array("content"=>$content,"title"=>$title);
				if($id<1){
					$data['addtime']=time();
					if($this->model->save($this->model->table_message_type, $data)==false){
						json_error("添加失败");
					}
					$this->init->d->log("添加信息设置)", 3);
				}else{
					if($this->model->edit($this->model->table_message_type, $data, array("id"=>$id))==false){
						json_error("编辑失败");
					}
					$this->init->d->log("编辑信息设置id({$id})", 4);
				}
				$cache_no = $this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_message_type,true,false);
				break;
		}
	}
	//信息管理，站内信息列表
	function get_inside(){}
	//信息管理，站内信息列表
	function ajax_inside(){
	
	}
	//信息管理，短信记录
	function get_sms(){}
	//信息管理，短信记录
	function ajax_sms(){
		
	}
	//信息管理,滚动信息
	function get_nav(){}
	//信息管理,滚动信息
	function ajax_nav(){
		$this->_notice(1);
	}
	//信息管理,个人中心公告
	function get_center(){}
	//信息管理,个人中心公告
	function ajax_center(){
		$this->_notice(2);
	}
	//1滚动信息，2个人中心信息
	private function _notice($type){
		$cache_key = $this->model->memcache->key_message;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_message_notice,array("type"=>$type,"agent_id"=>$this->init->sel_agent_id),$this->init->limit,$this->init->offset,array('id'));
				foreach ($data['rows'] as $k=>$v){
					$v['addtime_wz'] = date("Y-m-d H:i:s",$v['addtime']);
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post("id");
				$content = post("content");
				$title = post("title");
				if(empty($content))json_error("信息不能为空");
				$data = array("content"=>$content,"type"=>$type,"addtime"=>time(),"agent_id"=>$this->init->sel_agent_id,"username"=>$this->init->username);
				if($id<1){
					if($this->model->save($this->model->table_message_notice, $data)==false){
						json_error("添加失败");
					}
					$this->init->d->log("添加信息type({$type})", 3);
				}else{
					if($this->model->edit($this->model->table_message_notice, $data, array("id"=>$id))==false){
						json_error("编辑失败");
					}
					$this->init->d->log("编辑信息type({$type});id({$id})", 4);
				}
				$cache_no = $this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_message_notice,true);
				break;
			case "del":
				$this->init->d->del($this->model->table_message_notice,$cache_key);
				break;
		}
	}
}