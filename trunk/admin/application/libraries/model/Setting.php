<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 设置类 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Setting {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//系统设置，IP黑白名单
	function get_ip(){}
	//系统设置，IP黑白名单
	function ajax_ip(){
		$this->_list("ip");
	}
	//系统设置，API设置
	function get_api(){
		$game_type = $this->init->d->get_game_type_list('agent');
		$this->init->assign(array("game_type"=>$game_type));
	}
	//系统设置，API设置
	function ajax_api(){
		$this->_list("api");
	}
	//系统设置，网站设置
	function get_web(){}
	//系统设置，网站设置
	function ajax_web(){
		$this->_list("web");
	}
	//系统设置，IP黑白名单
	function get_server(){}
	//系统设置，IP黑白名单
	function ajax_server(){
		$this->_list("server");
	}
	//系统设置，优惠设置
	function get_sale(){}
	//系统设置，优惠设置
	function ajax_sale(){
		$this->_list("sale");
	}
	//系统设置，权限组操作
	function get_manager(){}
	//系统设置，权限组操作
	function ajax_manager(){
		switch ($this->init->action){
			case 'save' :
				$id = post('id');
				$username = post('username');
				$password = post('password');
				$cpassword = post('cpassword');
				$group_id = post('group_id');
				$maxmoney = post('maxmoney');
				$operatemoney = post('operatemoney');
				$status = post ('status');
				
				if (empty($password) && $id<1)json_error("请输入登录密码");
				if ($password != $cpassword)json_error("两次密码不一致");
				$data = array (
						"group_id" => $group_id,
						"maxmoney" => $maxmoney,
						"operatemoney" => $operatemoney,
						"status" => $status 
				);
				if(!empty($password))$data['password']=set_user_pass($username, $password);
				if ($id>0){
					//判断是否是合法操作
					$this->init->d->legal($this->model->table_admin,$id);
					if($this->model->edit($this->model->table_admin, $data, array('id'=>$id))==false) {
						$id = 0;
					}else{
						$this->init->d->log("编辑管理员id={$id}", 4);
					}
				} else {
					if(empty($username))json_error("请输入登录帐号");
					$data['username']=$username;
					$info = $this->model->get($this->model->table_admin, array('username' => $username,'agent_id'=>$this->init->sel_agent_id));
					if (isset($info['id']))json_error("已存在此管理员帐号");
					$data['agent_id']=$this->init->sel_agent_id;
					$id = $this->model->save($this->model->table_admin, $data);
					if($id>0){
						$this->init->d->log("添加管理员id={$id}",3);
					}
				}
				if ($id>0){
					$data['id']=$id;
					json_ok();
				}
				json_error("设置失败");
				break;
			case 'all' :
				$search = post('search');
				$where = " where  a.agent_id={$this->init->sel_agent_id} and a.del ='N' and b.del ='N' and "
						."a.group_id not in({$this->init->default_admin_group_id},{$this->init->default_agent_group_id})";
				if (!empty($search))$where .= " and a.username like '%{$search}%' ";
				$admin = $this->model->table($this->model->table_admin);
				$group = $this->model->table($this->model->table_admin_group);
				$sql = "select a.*,b.name as group_name from {$admin} a LEFT JOIN {$group} b on a.group_id=b.id " 
					  ."{$where} order by a.id desc";
				$data = $this->model->query($sql,$this->init->limit,$this->init->offset);
				foreach ($data['rows'] as $k=>$v){
					$v['status_wz']=$v['status']=='Y'?color("启用","green"):color("禁用");
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case 'one' :
				$this->init->d->one($this->model->table_admin,true);
				break;
			case 'group' :
				//总管理组和总代理组必须为最前面的组别
				$where = array('del' =>'N',"agent_id"=>$this->init->sel_agent_id,"id >"=>$this->init->default_agent_group_id);
				$data = $this->model->get_list($this->model->table_admin_group, $where,1000);
				$data = merge(array(array('id'=>0,'name' =>'请选择权限组')), $data['rows']);
				echo json_encode($data);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_admin);
				break;
		}
	}
	//系统设置，权限组操作
	function get_group(){}
	//系统设置，权限组操作
	function ajax_group() {
		$cache_key = $this->model->memcache->key_menu;
		switch ($this->init->action){
			case 'save' :
				$id = post('id');
				$data['name'] = post('name');
				$data['menus_list'] = post('menus_list');
				$data['menus_one'] = post('menus_one');
				$data['menus_add'] = post('menus_add');
				$data['menus_edit'] = post('menus_edit');
				$data['menus_del'] = post('menus_del');
				$data['menus_undo'] = post('menus_undo');
				$data['menus_exam'] = post('menus_exam');
				$data['menus_conf'] = post('menus_conf');
				if (empty($data['name']))json_error("请输入管理组名称");
				//若不为超级管理组，设置菜单权限不能超过当前自己的权限
				if($this->init->sel_agent_id!=$this->init->default_admin_agent_id){
					$bol = true;
					$list = ex($this->init->group['menus_list']);
					$mlist = ex($data['menus_list']);
					foreach ($mlist as $v){
						if(!in_array($v, $list)){
							$bol = false;
							break;
						}
					}
					if(!$bol){
						$this->init->d->log("警告,试图修改不属于其代理组的权限，name=>{$data['name']},id=>{$id}", 6);
						json_error("权限设置错误，请联系管理员");
					}
				}
				if($id>0){
					//判断是否是合法操作
					$this->init->d->legal($this->model->table_admin_group,$id);
					if($id == $this->init->default_agent_group_id && $this->init->agent_id != $this->init->default_admin_agent_id){
						json_error("总代理请联系管理员修改");
					}
					if($this->model->edit ( $this->model->table_admin_group,$data,array('id'=>$id)) == false){
						$id = 0;
					}
					if($id>0){
						$this->init->d->log("权限组{$id}修改", 4);
					}
				} else {
					$data['agent_id']=$this->init->sel_agent_id;
					$id = $this->model->save($this->model->table_admin_group,$data);
					if($id>0){
						$this->init->d->log("权限组{$id}添加", 3);
					}
				}
				if ($id>0){
					$data['id'] = $id;
					$this->model->memcache->setNo($cache_key);
					json_ok($data,"设置成功" );
				}
				json_error("设置失败");
				break;
			case 'all' :
				$search = post('search');
				$page = post('page');
				$rows = post('rows');
				if($page < 1)$page=1;
				if($rows < 1)$rows=20;
				$offset = ($page - 1) * $rows;
				$id = $this->init->sel_agent_id == $this->init->default_admin_agent_id?$this->init->default_admin_group_id:$this->init->default_agent_group_id;
				$where = "id >{$id} and del='N' and agent_id='{$this->init->sel_agent_id}'";
				if(!empty($search))$where .= " and name like '%{$search}%'";
				$data = $this->model->get_list($this->model->table_admin_group,$where,$rows,$offset,array('id'));
				echo json_encode($data);
				break;
			case 'html' :
				$id = post('id');
				$menus_list = $menus_one = $menus_add = $menus_edit = $menus_del = array ();
				$menus_undo = $menus_exam = $menus_conf = 'N';
				//用户可查看权限
				$sel = ex($this->init->group['menus_list']);
				if($id>0){
					$menus = $this->model->get( $this->model->table_admin_group, array ("id"=>$id,'del'=>'N'));
					$menus_list = isset($menus ['menus_list'] ) ? ex($menus ['menus_list'] ) : array();
					$menus_one = isset($menus ['menus_one'] ) ? ex($menus ['menus_one'] ) : array();
					$menus_add = isset($menus ['menus_add'] ) ? ex($menus ['menus_add'] ) : array();
					$menus_edit = isset($menus ['menus_edit'] ) ? ex($menus ['menus_edit'] ) : array();
					$menus_del = isset($menus ['menus_del'] ) ? ex($menus ['menus_del'] ) : array();
					$menus_undo = isset($menus ['menus_undo'] ) ? $menus ['menus_undo'] : 'N';
					$menus_exam = isset($menus ['menus_exam'] ) ? $menus ['menus_exam'] : 'N';
					$menus_conf = isset($menus ['menus_conf'] ) ? $menus ['menus_conf'] : 'N';
					$agent_id = isset($menus['agent_id'])?$menus['agent_id']:0;
					if($agent_id>$this->init->default_admin_agent_id){
						$info = $this->model->get($this->model->table_admin_group, array ("id"=>$this->init->default_agent_group_id,'del'=>'N'));
						$sel = ex($info['menus_list']);
					}
				}
				$_menu = $this->model->get_list($this->model->table_admin_menu, array('status'=>'Y','del'=>'N','level'=>'1'),1000);
				$_menu = $_menu['rows'];
				$pmenu = array(); // 所有父类
				$smenu = array(); // 所有子类
				//若是管理员修改代理下的管理权限则获取总代理的权限
				
				foreach($_menu as $v){
					//除超级管理员外排除超出当前自己权限的菜单选项,
					if($this->init->sel_agent_id!=$this->init->default_admin_agent_id){
						if(!in_array($v['id'], $sel) && $v['parent_id']!=0){
							continue;
						}
					}
					if($v['parent_id'] == 0) {
						$pmenu[$v['id']] = $v;
					}else{
						$smenu[$v['id']] = $v;
					}
				}
				$menu = array();
				foreach($pmenu as $k => $v){
					$menu [$k] = $v;
					foreach($smenu as $kk => $vv){
						if ($vv['parent_id'] == $k) {
							$vv['is_list'] = in_array ( $vv ['id'], $menus_list) ? 1 : 0;
							$vv['is_one'] = in_array ( $vv ['id'], $menus_one) && $vv['is_list'] == 1 ? 1 : 0;
							$vv['is_add'] = in_array ( $vv ['id'], $menus_add) && $vv['is_list'] == 1 ? 1 : 0;
							$vv['is_edit'] = in_array ( $vv ['id'], $menus_edit) && $vv['is_list'] == 1 ? 1 : 0;
							$vv['is_del'] = in_array ( $vv ['id'], $menus_del) && $vv['is_list'] == 1 ? 1 : 0;
							$vv['is_ck'] = $vv ['is_add'] == 1 && $vv ['is_edit'] == 1 && $vv ['is_del'] == 1 ? 1 : 0;
							$menu[$k]['menu'][$vv['id']] = $vv;
						}
					}
				}
				foreach($menu as $k => $v){
					if(!isset ($v['menu']))unset($menu[$k]);
				}
				$smarty = library("dsmarty","default");
				$smarty->assign(array("menus"=>$menu,'menus_undo'=>$menus_undo,'menus_exam'=>$menus_exam,'menus_conf'=>$menus_conf));
				$html = $smarty->fetch($this->init->version.'/html/ajax_group.html');
				json_ok($html);
				break;
			case 'del' :
				$id = post('id');
				if($id == $this->init->default_admin_group_id)json_error("超级管理员组无法删除");
				if($id == $this->init->default_agent_group_id)json_error("代理管理组无法删除");
				$this->init->d->del($this->model->table_admin_group,$cache_key);
				break;
		}
	}
	//系统设置,菜单操作
	function get_menu(){}
	function ajax_menu(){
		$this->init->lock("menu");
		$cache_key = $this->model->memcache->key_menu;
		switch($this->init->action){
			case 'save' :
				$id = post('id');
				$data['name'] = post('name');
				$data['url'] = post('url');
				$data['sort'] = post('sort');
				$data['status'] = post('status');
				$data['parent_id'] = post('parent_id');
				if (empty($data['name']))json_error("请输入菜单名称");
				if ($id>0){
					if ($this->model->edit($this->model->table_admin_menu, $data, array('id'=>$id))==false) {
						$id = 0;
					}
				} else {
					$id = $this->model->save($this->model->table_admin_menu,$data);
				}
				if ($id>0){
					$data['id']=$id;
					$this->model->memcache->setNo($cache_key);
					json_ok($data,"设置成功");
				}
				json_error("设置失败");
				break;
			case 'all' :
				$search= post('search');
				$where=" where a.del='N'";
				if (! empty($search))$where .= " and (a.name like '%{$search}%' or b.name like '%{$search}%') ";
				$table = $this->model->table($this->model->table_admin_menu );
				$sql = "select a.*,b.name as parent from {$table} a LEFT JOIN {$table} b on a.parent_id=b.id "."{$where} order by id desc ";
				$data = $this->model->query($sql,$this->init->limit,$this->init->offset);
				foreach ($data['rows'] as $k=>$v){
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case 'one' :
				$this->init->d->one($this->model->table_admin_menu,true,false);
				break;
			case 'parent' :
				$parent_id=get_data('parent_id');
				$where['parent_id'] = $parent_id;
				$where['del']='N';
				$data = $this->model->get_list($this->model->table_admin_menu,$where,1000,0);
				$data = merge(array(array('id'=>0,'name'=>'无父类')),$data['rows']);
				echo json_encode($data);
				break;
			case 'del' :
				$id = post('id');
				if($this->model->del($this->model->table_admin_menu,array('id'=>$id))
						&& $this->model->del($this->model->table_admin_menu, array('parent_id' =>$id))){
					$this->model->memcache->setNo($cache_key);
					json_ok();
				}
				json_error("删除失败");
				break;
			default :
				break;
		}
	}
	//设置表操作
	private function _list($type){
		switch ($this->init->action){
			case 'save':
				$data = $_POST;
				$def = post("def");
				unset($data['action'],$data['def'],$data['undefined']);
				$agent_id = $def == 1 ?0:$this->init->sel_agent_id;   //全局设置代理id为0
				//非管理员组无法操作默认项
				if($def==1 && $this->init->sel_agent_id != $this->init->default_admin_agent_id){
					$this->init->d->log("试图操作默认设置项", 6);
					json_error("权限错误，无法操作");
				}
				foreach ($data as $k=>$v){
					$k=safe_sql($k);
					$v=safe_sql($v);
					$data[$k]=$v;
				}
				if($this->model->edit_setting($data,$type,$agent_id)){
					$this->init->d->log("修改设置type={$type};agent_id={$this->init->sel_agent_id}", 4);
					$cache_key = $this->model->memcache->key_agent_setting_agent.$this->init->sel_agent_id;
					$this->model->memcache->setNo($cache_key);
					json_ok();
				}
				json_error();
				break;
			case 'one':
				$def = post("def");
				$agent_id = $def == 1 ?0:$this->init->sel_agent_id;   //全局设置代理id为0
				//非管理员组无法操作默认项
				if($def==1 && $this->init->sel_agent_id != $this->init->default_admin_agent_id){
					$this->init->d->log("试图获取默认设置项", 6);
					json_error("权限错误，无法操作");
				}
				$data = $this->model->get_list( $this->model->table_setting, array('type' =>$type,'agent_id'=>$agent_id),1000);
				$total = $data['total'];
				$data = $data['rows'];
				$info = array();
				foreach ($data as $k=>$v){
					$info[$k]['key']=$v['skey'];
					$info[$k]['value']=$v['svalue'];
				}
				json_ok($info,$total);
				break;
		}
	}
}