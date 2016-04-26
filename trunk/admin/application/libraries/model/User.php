<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 用户相关  2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class User {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//会员管理，会员银行卡
	function get_bank(){}
	//会员管理，会员银行卡
	function ajax_bank(){
		switch ($this->init->action){
			case "all":
				$users_bank = $this->model->table($this->model->table_users_bank);
				$users = $this->model->table($this->model->table_users);
				$sql = "select ub.*,u.username from {$users_bank} ub,{$users} u where ub.uid=u.id and ub.del='N' and u.del='N' "
						."and ub.agent_id='{$this->init->sel_agent_id}' and u.agent_id='{$this->init->sel_agent_id}' order by ub.id desc";
				$data = $this->model->query($sql, $this->init->limit,$this->init->offset);
				$banktype = $this->model->get_list($this->model->table_users_banktype, array("agent_id"=>$this->init->sel_agent_id),1000);
				foreach ($data['rows'] as $k=>$v){
					$v['bank_name']=color("会员银行类别已不可用");
					foreach ($banktype['rows'] as $vv){
						if($vv['id']==$v['banktype_id'])$v['bank_name']=$vv['name'];
					}
					$data["rows"][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post('id');
				if($id<1)json_error("参数错误");
				$data["banktype_id"] = post('banktype_id');
				$data["card"] = post('card');
				$data["province"] = post('province');
				$data["city"] = post('city');
				$data["address"] = post('address');
				if($data["banktype_id"]<1)json_error("请选择开户银行");
				if(empty($data["card"]))json_error("请输入银行帐号");
				if(empty($data["province"]))json_error("请输入银行省份");
				if(empty($data["city"]))json_error("请输入开户城市");
				if(empty($data["address"]))json_error("请输入开户网点");
				$this->init->d->legal($this->model->table_users_bank, $id);
				if($this->model->edit($this->model->table_users_bank, $data,array('id'=>$id))==false) {
					json_error("编辑失败");
				}
				json_ok("编辑成功");
				break;
			case "one":
				$id = post("id");
				if($id<1)json_error("参数错误");
				$this->init->d->legal($this->model->table_users_bank,$id);
				$users_bank = $this->model->table($this->model->table_users_bank);
				$users = $this->model->table($this->model->table_users);
				$sql = "select ub.*,u.username from {$users_bank} ub,{$users} u where ub.uid=u.id and ub.del='N' and u.del='N' "
				."and ub.agent_id='{$this->init->sel_agent_id}' and u.agent_id='{$this->init->sel_agent_id}' and ub.id='{$id}'";
				$data = $this->model->one($sql);
				if(!isset($data['id']))json_error("获取失败");
				json_ok($data);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_users_bank);
				break;
			case 'type':
				$data = $this->model->get_list($this->model->table_users_banktype, array("agent_id"=>$this->init->sel_agent_id),1000);
				$data = merge(array(array('id'=>0,'name'=>'请选择银行类别')),$data['rows']);
				echo json_encode($data);
				break;
		}
	}
	//会员管理，会员银行类别
	function get_banktype(){}
	//会员管理，会员银行类别
	function ajax_banktype(){
		$cache_key = $this->model->memcache->key_user_banktype."_".$this->init->sel_agent_id;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_users_banktype, array("agent_id"=>$this->init->sel_agent_id),$this->init->limit,$this->init->offset);
				echo json_encode($data);
				break;
			case "save":
				$id = post('id');
				$data["name"] = post('name');
				$data["intro"] = post('intro');
				if(empty($data["name"]))json_error("请输入银行名称");
				if(empty($data["intro"]))json_error("请输入银行说明");
				if($id>0){
					$this->init->d->legal($this->model->table_users_banktype, $id);
					if($this->model->edit($this->model->table_users_banktype, $data,array('id'=>$id))==false) {
						json_error("编辑失败");
					}
				}else{
					$data['agent_id'] = $this->init->sel_agent_id;
					if($this->model->save($this->model->table_users_banktype,$data)==0){
						json_error("添加失败");
					}
				}
				$this->model->memcache->setNo($cache_key);
				json_ok("设置成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_users_banktype,true);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_users_banktype,$cache_key);
				break;
		}
	}
	//会员管理，会员级别
	function get_group(){}
	//会员管理，会员级别
	function ajax_group(){
		$cache_key = $this->model->memcache->key_user_group_agent.$this->init->sel_agent_id;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_users_group, array("agent_id"=>$this->init->sel_agent_id),$this->init->limit,$this->init->offset);
				echo json_encode($data);
				break;
			case "save":
				$id = post('id');
				$data["name"] = post('name');
				$data["rebate"] = post('rebate');
				$data["mindeposit"] = post('mindeposit');
				$data["maxdeposit"] = post('maxdeposit');
				$data["mindraw"] = post('mindraw');
				$data["maxdraw"] = post('maxdraw');
				$data["banknum"] = post('banknum');
				$data["upmoney"] = post('upmoney');
				if(empty($data["name"]))json_error("请级别名称");
				if($data["mindeposit"]>$data["maxdeposit"])json_error("最小取款不能大于最大存款");
				if($data["mindraw"]>$data["maxdraw"])json_error("最小存款不能大于最大存款");
				if($id>0){
					$this->init->d->legal($this->model->table_users_group, $id);
					if($this->model->edit($this->model->table_users_group, $data,array('id'=>$id))==false) {
						json_error("编辑会员级别失败");
					}
				}else{
					if(empty($password))json_error("密码不能为空");
					$data['agent_id'] = $this->init->sel_agent_id;
		     		if($this->model->save($this->model->table_users_group,$data)==0){
						json_error("添加会员级别失败");
					}
				}
				$this->model->memcache->setNo($cache_key);
				json_ok("设置成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_users_group,true);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_users_group,$cache_key);
				break;
		}
	}
	//会员管理，会员列表
	function get_list(){}
	//会员管理，会员列表
	function ajax_list(){
		switch ($this->init->action){
			case "all":
				$search = post('search');
				$where = "";
				if (!empty($search))$where = " and username like '%{$search}%' ";
				$user = $this->model->table($this->model->table_users);
				$sql = "select * from {$user}  where del='N' and agent_id='{$this->init->sel_agent_id}' {$where} order by id desc";
				$data = $this->model->query($sql,$this->init->limit,$this->init->offset);
				$group = $this->model->get_list($this->model->table_users_group, array("agent_id"=>$this->init->sel_agent_id,"del"=>"N"), 1000);
				$group = $group['rows'];
				foreach ($data['rows'] as $k=>$v){
					$v['group_name']=color("未知级别");
					foreach ($group as $vv){
						if($vv['id']==$v['group_id'])$v['group_name']=$vv['name'];
					}
					$v['status_wz'] = $v['status']=='Y'?color("正常","green"):color("冻结");
					$v['registertime']=$v['registertime']>0?date("Y-m-d H:i:s",$v['registertime']):"";
					$v['firsttime']=$v['firsttime']>0?date("Y-m-d H:i:s",$v['firsttime']):"";
					$v['logintime']=$v['logintime']>0?date("Y-m-d H:i:s",$v['logintime']):"";
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case "save":
				$id = post('id');
				$data["username"] = post('username');
				$password = post('password');
				$cpassword = post('cpassword');
				$data["truname"] = post('truname');
				$data["phone"] = post('phone');
				$data["email"] = post('email');
				$data["phone"] = post('phone');
				$data["group_id"] = post('group_id');
				$data["status"] = post('status');
				if(empty($data["username"]))json_error("请输入用户名");
				if(!empty($password) && $password!=$cpassword)json_error("两次密码输入不一致");
				if(empty($data["phone"]))json_error("手机号码不能为空");
				if($data["group_id"]<1)json_error("请选择会员级别");
				if(!empty($password))$data['password']=set_user_pass($data["username"], $password);
				if($id>0){
					$this->init->d->legal($this->model->table_users, $id);
					unset($data['username']);
					if($this->model->edit($this->model->table_users, $data,array('id'=>$id))==false) {
						json_error("编辑会员失败");
					}
				}else{
					if(empty($password))json_error("密码不能为空");
					$data['agent_id'] = $this->init->sel_agent_id;
					$info = $this->model->get($this->model->table_users, array("username"=>$data['username'],"agent_id"=>$this->init->sel_agent_id));
		     		if(isset($info['id']))json_error("登录帐号重复");
		     		if($this->model->save($this->model->table_users,$data)==0){
						json_error("添加会员失败");
					}
					
				}
				json_ok("设置成功");
				break;
			case "one":
				$this->init->d->one($this->model->table_users,true);
				break;
			case "group":
				$where = array("agent_id"=>$this->init->sel_agent_id,"del"=>"N");
				$data = $this->model->get_list($this->model->table_users_group,$where,1000,0);
				$data = merge(array(array('id'=>0,'name'=>'请选择用户组')),$data['rows']);
				echo json_encode($data);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_users);
				break;
			default :
				break;
		}
	}
}