<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 基本资料 2015.09.04
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Basic{
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->model = $model;
		$this->init = $init;
	}
	//基本资料
	function get_index(){
		$this->init->set_header(array("title"=>"个人中心-基本资料-基本资料"));
		$data = $this->model->get($this->model->table_users, array("id"=>$this->init->uid));
		$data['no_empty']=0;
		if(isset($data['email']) && !empty($data['sex']))$data['no_empty']=1;
		$this->init->assign(array("data"=>$data));
	}
	//基本资料
	function ajax_index(){
		$sex = post("sex");
		$birth = post("birth");
		$email = post("email");
		if(empty($sex))json_error("请选择性别");
		if(empty($birth))json_error("请选择生日");
		if(empty($email))json_error("请输入邮箱");
		if(check_email($email)==false)json_error("邮箱格式不正确");
		$data = array("sex"=>$sex,"birth"=>$birth,"email"=>$email);
		if($this->model->edit($this->model->table_users, $data, array("id"=>$this->init->uid))){
			json_ok();
		}
		json_ok("修改失败");
	}
	//银行卡列表
	function get_bank(){
		$this->init->set_header(array("title"=>"个人中心-基本资料-银行卡列表"));
		$data['total']= $this->model->total($this->model->table_users_bank,array("uid"=>$this->init->uid));
		$data['banknum']= isset($this->init->group['banknum'])?$this->init->group['banknum']:0;
		$data['num']= $data['banknum']-$data['total']>0?($data['banknum']-$data['total']):0;
		$list=$this->model->get_list($this->model->table_users_bank, array("agent_id"=>$this->init->agent_id),100);
		$list=$list['rows'];
		$user_bank_type = $this->init->d->get_user_banktype();  //获取用户银行类别
		foreach($list as $k=>$v){
			$v['bank_name']="银行错误";
			foreach ($user_bank_type as $vv){
				if($v['banktype_id']==$vv['id'])$v['bank_name']=$vv['name'];
			}
			$data['user_bank'][$k]=$v;
		}
		$data['group_name']=isset($this->init->group['name'])?$this->init->group['name']:"未知会员";
		$this->init->assign(array("data"=>$data));
	}
	//银行卡资料
	function get_bankedit(){
		$id = get("id");
		$id = intval($id);
		$user_bank_type = $this->init->d->get_user_banktype();  //获取用户银行类别
		if($id>0){
			$this->init->set_header(array("title"=>"个人中心-基本资料-银行卡资料查看"));
			$data['is_sel']=1;
			$bank = $this->model->get($this->model->table_users_bank, array("id"=>$id,"uid"=>$this->init->uid));
			if(!isset($bank['id']))skip("/member-basic-bank","页面错误，请重试");
			$bank['bank_name'] = "银行错误";
			foreach ($user_bank_type as $v){
				if($bank['banktype_id']==$v['id'])$bank['bank_name']=$v['name'];
			}
			$data['bank']=$bank;
		}else{
			$this->init->set_header(array("title"=>"个人中心-基本资料-银行卡资料新增"));
			$data['is_sel']=0;
			$total = $this->model->total($this->model->table_users_bank,array("uid"=>$this->init->uid));
			$banknum = isset($this->init->group['banknum'])?$this->init->group['banknum']:0;
			if($total>=$banknum)skip("/member-basic-bank","您只能绑定{$total}张银行卡，已绑定{$banknum}张。");
			$data['user_bank_type']=$user_bank_type;
		}
		$this->init->assign(array("data"=>$data));
	}
	//银行资料-添加
	function ajax_bankedit(){
		$banktype_id = post("banktype_id");
		$card = post("card");
		$province = post("province");
		$city = post("city");
		$address = post("address");
		if($banktype_id<1)json_error("请选择开户银行");
		if(empty($card))json_error("请输入银行卡号");
		if(empty($province))json_error("请选择开户省份");
		if(empty($city))json_error("请选择开户城市");
		if(empty($address))json_error("请输入开户网点");
		$total = $this->model->total($this->model->table_users_bank,array("uid"=>$this->init->uid));
		$banknum = isset($this->init->group['banknum'])?$this->init->group['banknum']:0;
		if($total>=$banknum)json_error("您只能绑定{$total}张银行卡，已绑定{$banknum}张。");
		$data = $this->model->get($this->model->table_users_bank, array("card"=>$card));
		if(isset($data['id']))json_error("银行卡{$card}已绑定，请不要重复绑定");
		$data = array(
				"banktype_id"=>$banktype_id,
				"card"=>$card,
				"address"=>$address,
				"province"=>$province,
				"city"=>$city,
				"uid"=>$this->init->uid,
				"agent_id"=>$this->init->agent_id
		);
		if($this->model->save($this->model->table_users_bank, $data)>0){
			json_ok();
		}
		json_ok("添加失败");
	}
	//修改登录密码
	function get_pass(){
		$this->init->set_header(array("title"=>"个人中心-基本资料-修改登录密码"));
	}
	//修改登录密码
	function ajax_pass(){
		$password = post("password");
		$new_password = post("new_password");
		$c_new_password = post("c_new_password");
		if(empty($password))json_error("原始密码不能为空");
		if(empty($new_password))json_error("新密码不能为空");
		if($new_password != $c_new_password)json_error("两次密码不一致");
		$data = $this->model->get($this->model->table_users, array("id"=>$this->init->uid));
		if(!isset($data['password']) || $data['password'] != set_user_pass($data['username'], $password)){
			json_error("原始密码不正确");
		}
		$info['password']=set_user_pass($data['username'], $new_password);
		if($this->model->edit($this->model->table_users,$info, array("id"=>$this->init->uid))==false)json_error("密码修改失败");
		json_ok();
	}
	//修改取款密码
	function get_paypass(){
		$this->init->set_header(array("title"=>"个人中心-基本资料-修改取款密码"));
	}
	//修改取款密码
	function ajax_paypass(){
		$password = post("password");
		$new_password = post("new_password");
		$c_new_password = post("c_new_password");
		if(empty($password))json_error("原始密码不能为空");
		if(empty($new_password))json_error("新密码不能为空");
		if($new_password != $c_new_password)json_error("两次密码不一致");
		$data = $this->model->get($this->model->table_users, array("id"=>$this->init->uid));
		if(!isset($data['id']) || $data['transpassword'] != md5($password)){
			json_error("原始密码不正确");
		}
		$info['transpassword']=md5($new_password);
		if($this->model->edit($this->model->table_users,$info, array("id"=>$this->init->uid))==false)json_error("取款密码修改失败");
		json_ok();
	}
}