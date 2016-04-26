<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 日志类 2015.08.11
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Log_model $model
 * @property Dinit $init
 */
class Log{
	private $ci;
	private $model;                         //默认model
	private $init;                          //默认类
	
	function __construct() {
		$this->ci = ci();
		$this->model = model("agent");
	}
	function ajax($ajax,$init) {
		$this->init = $init;
		switch ($ajax) {
			case 'operate' :
				$this->_operate();
				break;
		}
	}
	private function _operate(){
		$action = get_data("action");
		$cache_key = $this->model->memcache->key_host;
		switch ($action){
			case "all":
				$this->init->is_auth('list'); //ajax权限
				$page = post('page');
				$rows = post('rows');
				if ($page < 1)$page = 1;
				if ($rows < 1)$rows = 20;
				$offset=($page - 1) * $rows;
				$search= post('search');
				
				$host = $this->model->table($this->model->table_agent_host_more);
				$agent = $this->model->table($this->model->table_agent);
				$sql = "SELECT a.*,b.username FROM {$host} a, {$agent} b where a.agent_id=b.id and a.del='N' and b.del='N' and a.agent_id={$this->init->sel_agent_id}";
				if(!empty($search))$sql .= " and b.username like '%{$search}%'";
				$sql .= " order by a.id desc";
				$data = $this->model->query($sql,$rows,$offset);
				foreach ($data['rows'] as $k=>$v){
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$v['addtime']=empty($v['addtime'])?"":date("Y-m-d H:i:s",$v['addtime']);
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
		}
	}
}