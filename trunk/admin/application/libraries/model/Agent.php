<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 代理管理类 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Agent{
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//总代管理，网站版本
	function get_version(){}
	//总代管理，网站版本
	function ajax_version(){
		$this->init->lock("agent_version");
		$cache_key = $this->model->memcache->key_host;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_agent_version,array(),$this->init->limit,$this->init->offset,array('id'));
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
					if($this->model->save($this->model->table_agent_version, array("version"=>$version,"isadmin"=>$isadmin))==false){
						json_error("添加失败");
					}
				}else{
					if($this->model->edit($this->model->table_agent_version, array("version"=>$version,"isadmin"=>$isadmin), array("id"=>$id))==false){
						json_error("编辑失败");
					}
				}
				$this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_agent_host,true);
				break;
			case "del":
				$this->init->d->del($this->model->table_agent_version,$cache_key);
				break;
		}
	}
	//总代管理，总代设置
	function get_host(){}
	//总代管理，总代设置
	function ajax_host(){
		$this->init->lock("agent_host");
		$cache_key = $this->model->memcache->key_host;
		switch ($this->init->action){
			case "all":
				$search= post('search');
				
				$host = $this->model->table($this->model->table_agent_host);
				$agent = $this->model->table($this->model->table_agent);
				$sql = "SELECT a.*,b.username FROM {$host} a, {$agent} b where a.agent_id=b.id"
					." and a.del='N' and b.del='N' and a.agent_id>{$this->init->default_admin_agent_id}";
				if(!empty($search))$sql .= " and b.username like '%{$search}%'";
				$sql .= " order by a.id desc";
				$data = $this->model->query($sql,$this->init->limit,$this->init->offset);
				$version = $this->model->get_list($this->model->table_agent_version,array(),1000);
				foreach ($data['rows'] as $k=>$v){
					$v['isadmin_wz'] = $v['isadmin']=='Y'?"后端":"前端";
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
				$id = post("id");
				$data['agent_id'] = post("agent_id");
				$data['web_host'] = post("web_host");
				$data['title'] = post("title");
				$data['logo'] = post("logo");
				$data['version_id'] = post("version_id");
				$data['isadmin'] = post("isadmin");
				if(empty($data['agent_id']))json_error("请选择代理帐号");
				if($id<1){
					$info = $this->model->get($this->model->table_agent_host, array("web_host"=>$data['web_host']));
					if(isset($info['id']))json_error("网站域名已存在");
					$info = $this->model->get($this->model->table_agent_host, array("agent_id"=>$data['agent_id'],"isadmin"=>$data['isadmin']));
					if(isset($info['id']))json_error("网站主域名只能绑定一个,分域名请去网站管理设置");
					$data['addtime']=time();
					if(!$this->model->save($this->model->table_agent_host, $data)){
						json_error("添加失败");
					}
				}else{
					$this->init->d->legal($this->model->table_agent_host, $id);
					$info = $this->model->get($this->model->table_agent_host, array("id"=>$id));
					if($info['isadmin']!=$data['isadmin'])json_error("不能改变域名类型");
					if($this->model->edit($this->model->table_agent_host, $data, array("id"=>$id))==false){
						json_error("编辑失败");
					}
					$this->init->d->log("编辑代理设置id={$id}", 4);
				}
				$this->model->memcache->setNo($cache_key);
				json_ok("成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_agent_host,true,false);
				break;
			case "del":
				$this->init->d->del($this->model->table_agent_host,$cache_key,false);
				break;
			case "agent":
				$data = $this->init->d->agent_list();
				$data = merge(array(array('id' =>0,'username' =>'请选择代理帐号')),$data);
				echo json_encode($data);
				break;
			case "version":
				$isadmin = get("isadmin");
				$data = array(array('id' =>"0",'version' =>'请选择页面版本'));
				if(in_array($isadmin, array("Y","N"))){
					$data = $this->model->get_list( $this->model->table_agent_version, array("isadmin"=>$isadmin),1000,0);
					$data = merge(array(array('id' =>"0",'version' =>'请选择页面版本')),$data ['rows']);
				}
				echo json_encode($data);
				break;
		}
	}
	//总代管理，总代列表
	function get_list(){
		$game_type = $this->init->d->get_game_type_list("status");
		$this->init->assign(array("game_type"=>$game_type));
	}
	//总代管理，总代列表
	function ajax_list(){
		$this->init->lock("agent_list");
		$cache_key = $this->model->memcache->key_agent;
		switch ($this->init->action){
			case "all":
				$search= post('search');
				$where=" del='N' and id>{$this->init->default_admin_agent_id}";
				if(!empty($search))$where .= " and username like '%{$search}%'";
				$data = $this->model->get_list($this->model->table_agent,$where,$this->init->limit,$this->init->offset,array('id'));
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
				$data = $this->init->d->one($this->model->table_agent,false,false);
				$data['game_type_d'] = ex($data['game_type']);
				json_ok($data);
				break;
			case "del":
				$this->init->d->del($this->model->table_agent,$cache_key,false);
				break;
		}
	}
}