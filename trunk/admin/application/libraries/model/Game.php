<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 游戏相关处理 2015.07.29
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Game{
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//游戏管理,游戏类型
	function get_type(){}
	//游戏管理,游戏类型
	function ajax_type(){
		$this->init->lock("game_type");
		switch ($this->init->action){
			case "all":
				$page = post('page');
				$rows = post('rows');
				if ($page < 1)$page = 1;
				if ($rows < 1)$rows = 20;
				$offset = ($page - 1) * $rows;
				$data = $this->model->get_list($this->model->table_game_type,array("del"=>"N"),$rows,$offset,array('id'));
				if($data['total']>0){
					foreach ($data['rows'] as $k=>$v){
						$v['status_wz']=$v['status']=='Y'?color("正常","green"):color("禁用");
						$data['rows'][$k]=$v;
					}
				}
				echo json_encode($data);
				break;
			case "one":
				$id = post('id');
				$data = $this->model->get($this->model->table_game_type, array('id' =>$id,"del"=>"N"));
				if (isset($data['id']))json_ok($data);
				json_error("获取数据失败");
				break;
			case 'save' :
				$id = post('id');
				$data['name'] = post('name');
				$data['code'] = post('code');
				$data['code'] = strtoupper($data['code']);
				$data['status'] = post('status');
				if (empty($data['name']))json_error("请输入游戏名称");
				$info = $this->model->get($this->model->table_game_type, array('code' =>$data['code'],"del"=>"N"));
				if($id>0){
					if(isset($info['id']) && $info['id']!=$id){
						json_error("识别码不能重复");
					}
					if($this->model->edit($this->model->table_game_type, $data, array('id'=>$id))== false){
						$id = 0;
					}else{
						$this->init->d->log("编辑游戏类型id={$id}", 4);
					}
				}else{
					if(isset($info['id'])){
						json_error("识别码不能重复");
					}
					$id = $this->model->save($this->model->table_game_type,$data);
					if($id>0)$this->init->d->log("编辑游戏类型id={$id}",3);
				}
				if ($id>0){
					$data['id']=$id;
					$cache_key = $this->model->memcache->key_game_type;
					$this->model->memcache->setNo($cache_key);
					json_ok($data,"设置成功");
				}
				json_error("设置失败");
				break;
			case 'del' :
				$id = post('id');
				if ($this->model->del($this->model->table_game_type,array('id'=>$id))){
					$cache_key = $this->model->memcache->key_game_type;
					$this->model->memcache->setNo($cache_key);
					$this->init->d->log("删除游戏id={$id}", 2);
					json_ok();
				}
				json_error("删除失败");
				break;
		}
	}
}