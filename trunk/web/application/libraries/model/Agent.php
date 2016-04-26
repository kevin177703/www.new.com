<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 代理管理类 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Agent_model $model
 * @property Dinit $init
 */
class Agent {
	private $ci;
	private $model;                         //默认model
	private $init;                          //默认类
	
	function __construct() {
		$this->ci = ci();
		$this->model = model("agent");
	}
	function ajax($ajax,$init) {
		$this->init = $init;
		$this->init->lock("agent");   //强制锁定
		$this->model->set_openno($this->init->sql_open_no); 
		switch ($ajax) {
			case 'host' :
				$this->_host();
				break;
			case 'version' :
				$this->_version();
				break;
			case 'list' :
				$this->_list();
				break;
		}
	}
	private function _version(){
		$this->init->lock("agent_version");
		$action = get_data("action");
		$cache_key = $this->model->memcache->key_host;
		switch ($action){
			case "all":
				$this->init->is_auth('sel'); // ajax权限
				$page = post('page');
				$rows = post('rows');
				if ($page < 1)$page = 1;
				if ($rows < 1)$rows = 20;
				$offset=($page - 1) * $rows;
				$data = $this->model->get_list($this->model->table_agent_version,array("del"=>"N"),$rows,$offset,array('id'));
				foreach ($data['rows'] as $k=>$v){
					$v['isadmin_wz'] = $v['isadmin']=='Y'?"后端":"前端";
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post("id");
				$version = post("version");
				$isadmin = post("isadmin");
				if(empty($version))json_error("版本号不能为空");
				if(!in_array($isadmin, array("Y","N")))json_error("错误，错误");
				if($id<1){
					$this->init->is_auth('add'); // ajax权限
					if($this->model->save($this->model->table_agent_version, array("version"=>$version,"isadmin"=>$isadmin))==false){
						json_error("添加失败");
					}
				}else{
					$this->init->is_auth('edit'); // ajax权限
					if($this->model->edit($this->model->table_agent_version, array("version"=>$version,"isadmin"=>$isadmin), array("id"=>$id))==false){
						json_error("编辑失败");
					}
				}
				$cache_no = $this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->is_auth('sel'); // ajax权限
				$id = post("id");
				if($id<1)json_error("参数错误");
				$data = $this->model->get($this->model->table_agent_version, array("id"=>$id));
				json_ok($data);
				break;
			case "del":
				$this->init->is_auth('del'); // ajax权限
				$id=post("id");
				if($id<1)json_error("参数错误");
				if($this->model->del($this->model->table_agent_version, array("id"=>$id))){
					$cache_no = $this->model->memcache->setNo($cache_key);
					json_ok("删除成功");
				}
				json_error("删除失败");
				break;
		}
	}
	private function _host(){
		$this->init->lock("agent_host");
		$action = get_data("action");
		$cache_key = $this->model->memcache->key_host;
		switch ($action){
			case "all":
				$this->init->is_auth('list'); // ajax权限
				$page = post('page');
				$rows = post('rows');
				if ($page < 1)$page = 1;
				if ($rows < 1)$rows = 20;
				$offset=($page - 1) * $rows;
				$search= post('search');
				
				$host = $this->model->table($this->model->table_agent_host);
				$agent = $this->model->table($this->model->table_agent);
				$sql = "SELECT a.*,b.username FROM {$host} a, {$agent} b where a.agent_id=b.id and a.del='N' and b.del='N' and a.agent_id>{$this->init->default_admin_agent_id}";
				if(!empty($search))$sql .= " and b.username like '%{$search}%'";
				$sql .= " order by a.id desc";
				$data = $this->model->query($sql,$rows,$offset);
				$version = $this->model->get_list($this->model->table_agent_version, array('del'=>'N'), 1000);
				foreach ($data['rows'] as $k=>$v){
					$v['isadmin_wz'] = $v['isadmin']=='Y'?"后端":"前端";
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$v['addtime']=empty($v['addtime'])?"":date("Y-m-d H:i:s",$v['addtime']);
					$v['version'] = color("版本号错误");
					foreach ($version['rows'] as $vv){
						if($v['version_id']==$vv['id'] && $v['isadmin']==$vv['isadmin']){
							$v['version']=$vv['version'];
							break;
						}
					}
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$this->init->is_auth('one'); //ajax权限
				$id = post("id");
				$data['agent_id'] = post("agent_id");
				$data['web_host'] = post("web_host");
				$data['title'] = post("title");
				$data['logo'] = post("logo");
				$data['version_id'] = post("version_id");
				$data['isadmin'] = post("isadmin");
				$data['status'] = post("status");
				if(empty($data['agent_id']))json_error("请选择代理帐号");
				if($id<1){
					$this->init->is_auth('add'); // ajax权限
					$info = $this->model->get($this->model->table_agent_host, array("web_host"=>$data['web_host']));
					if(isset($info['id']))json_error("网站域名已存在");
					$info = $this->model->get($this->model->table_agent_host, array("agent_id"=>$data['agent_id'],"isadmin"=>$data['isadmin']));
					if(isset($info['id']))json_error("网站主域名只能绑定一个,分域名请去网站管理设置");
					$data['addtime']=time();
					if(!$this->model->save($this->model->table_agent_host, $data)){
						json_error("添加失败");
					}
				}else{
					$this->init->is_auth('edit'); //ajax权限
					$this->init->d->legal($this->model->table_agent_host, $id);
					$info = $this->model->get($this->model->table_agent_host, array("id"=>$id));
					if($info['isadmin']!=$data['isadmin'])json_error("不能改变域名类型");
					if($this->model->edit($this->model->table_agent_host, $data, array("id"=>$id))==false){
						json_error("编辑失败");
					}
					$this->init->d->log("编辑代理设置id={$id}", 4);
				}
				$cache_no = $this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->is_auth('one'); // ajax权限
				$id = post("id");
				if($id<1)json_error("参数错误");
				$data = $this->model->get($this->model->table_agent_host, array("id"=>$id));
				json_ok($data);
				break;
			case "del":
				$this->init->is_auth('del'); // ajax权限
				$id=post("id");
				if($id<1)json_error("参数错误");
				if($this->model->del($this->model->table_agent_host, array("id"=>$id))){
					$this->init->d->log("删除代理设置id={$id}", 2);
					$cache_no = $this->model->memcache->setNo($cache_key);
					json_ok("删除成功");
				}
				json_error("删除失败");
				break;
			case "agent":
				$this->init->is_auth('one'); //ajax权限
				$data = $this->init->d->agent_list();
				$data = merge(array(array('id' =>0,'username' =>'请选择代理帐号')),$data);
				echo json_encode($data);
				break;
			case "version":
				$this->init->is_auth('one'); //ajax权限
				$isadmin = get("isadmin");
				$data = array(array('id' =>"0",'version' =>'请选择页面版本'));
				if(in_array($isadmin, array("Y","N"))){
					$data = $this->model->get_list( $this->model->table_agent_version, array("del"=>"N","isadmin"=>$isadmin),1000,0);
					$data = merge(array(array('id' =>"0",'version' =>'请选择页面版本')),$data ['rows']);
				}
				echo json_encode($data);
				break;
		}
	}
	private function _list(){
		$this->init->lock("agent_list");
		$action = get_data("action");
		$cache_key = $this->model->memcache->key_agent;
		switch ($action){
			case "all":
				$this->init->is_auth('list'); // ajax权限
				$page = post('page');
				$rows = post('rows');
				if ($page < 1)$page = 1;
				if ($rows < 1)$rows = 20;
				$offset=($page - 1) * $rows;
				$search= post('search');
				$where=" del='N' and id>{$this->init->default_admin_agent_id}";
				if(!empty($search))$where .= " and username like '%{$search}%'";
				$data = $this->model->get_list($this->model->table_agent,$where,$rows,$offset,array('id'));
				$game_type = $this->init->d->get_game_type_list("status");
				foreach ($data['rows'] as $k=>$v){
					$_game_type = color("无游戏设置");
					$_g = array();
					if(!empty($v['game_type']) && !empty($game_type)){
						$_game_type = '';
						$_g = ex($v['game_type']);
						foreach ($_g as $_v){
							if(empty($_v))continue;
							$_game_type .= isset($game_type[$_v])?$game_type[$_v]:color("[{$_v}禁用]");
							$_game_type .= ",";
						}
					}
					$v['game_type_wz']=$_game_type;
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$v['addtime']=empty($v['addtime'])?"":date("Y-m-d H:i:s",$v['addtime']);
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$this->init->is_auth('one'); // ajax权限
				$id = post("id");
				$username = post("username");
				$code = post("code");
				$game_type = post("game_type");
				$password = post("password");
				$cppassword = post("cppassword");
				$phone = post("phone");
				$email = post("email");
				$status = post("status");
				if(empty($username))json_error("代理帐号不能为空");
				if($password != $cppassword)json_error("两次密码输入不一致");
				if($id<1){
					$this->init->is_auth('add'); // ajax权限
					$code = strtolower($code);
					if(!preg_match("/^[a-z]{1}[a-z0-9]{2}$/",$code)){
						json_error("代理编码错误");
					}
					$info = $this->model->get($this->model->table_agent, array("code"=>$code));
					if(isset($info['id']))json_error("代理编码重复");
					if(empty($password))json_error("密码不能为空");
					$data = array(
							"username"=>$username,
							"code"=>$code,
							"game_type"=>$game_type,
							"password"=>$password,
							"phone"=>$phone,
							"email"=>$email,
							"group_id"=>$this->init->default_agent_group_id
					);
					$res = $this->model->addAgent($data);
					if($res=="same")json_error("代理帐号重复");
					if($res !="success")json_error("添加失败");
					
				}else{
					$this->init->is_auth('edit'); // ajax权限
					if(!empty($password)){
						$_password = set_user_pass($username, $password);
						if($this->model->edit($this->model->table_admin, array("password"=>$_password), array("username"=>$username,"del"=>"N"))==false){
							json_error("编辑失败");
						}
					}
					if($this->model->edit($this->model->table_agent, array("phone"=>$phone,"game_type"=>$game_type,"email"=>$email), array("id"=>$id))==false){
						json_error("编辑失败");
					}
					$this->init->d->log("编辑代理id={$id}", 4);
				}
				//成功后，更新缓存
				$this->model->memcache->setNo($cache_key);
				json_ok();
				break;
			case "one":
				$this->init->is_auth('one'); //ajax权限
				$id = post("id");
				$data = $this->model->get($this->model->table_agent, array("id"=>$id));
				if(!isset($data['id']))json_error("获取数据失败");
				$data['game_type_d'] = ex($data['game_type']);
				json_ok($data);
				break;
			case "del":
				$this->init->is_auth('del'); //ajax权限
				$id=post("id");
				if($this->model->del($this->model->table_agent, array("id"=>$id))){
					//成功后，更新缓存
					$this->model->memcache->setNo($cache_key);
					$this->init->d->log("删除代理id={$id}", 2);
					json_ok("删除成功");
				}
				json_error("删除失败");
				break;
		}
	}
}