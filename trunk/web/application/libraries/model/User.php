<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 用户相关  2015.08.13
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class User {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model) {
		$this->model = $model;
		$this->init = $init;
	}
	//退出
	function ajax_logout(){
		$cache_key = $this->init->token.$this->model->memcache->key_session;
		$this->init->d->session("del");
		$this->model->memcache->delete($cache_key);
		del_all_cookie();
		json_ok();
	}
	//登录
	function ajax_login(){
		$username = post("username");
		$password = post("password");
		$code = post("code");
		if(empty($username))json_error("请输入用户名");
		if(empty($password))json_error("请输入密码");
		if(empty($code))json_error("请输入验证码");
		if($code != $_SESSION['login_code']){
			json_error("验证码不正确");
		}
		$user = $this->model->get($this->model->table_users, array("username"=>$username,"agent_id"=>$this->init->agent_id));
		if(!isset($user['id']))json_error("帐号不存在");
		if($user['status']!='Y')json_error("帐号被冻结，请联系客服");
		$where = array("id"=>$user['id'],"agent_id"=>$user['agent_id']);
		if($user['loginecount']>4){
			if($user['loginetime']+12*3600 > time()){
				json_error("密码错误超过5次，请12小时后再试");
			}else{
				//超过12小时，密码错误次数清0
				$this->model->edit($this->model->table_users, array("loginecount"=>0,"loginetime"=>time()), $where);
			}
		}
		//当密码错误时
		if(set_user_pass($username, $password) != $user['password']){
			$this->model->edit($this->model->table_users, array("loginecount"=>$user['loginecount']+1,"loginetime"=>time()), $where);
			json_error("密码错误");
		}
		//若登录错误大于0，数据归0
		if($user['loginecount']>0){
			$this->model->edit($this->model->table_users, array("loginecount"=>0,"loginetime"=>time()), $where);
		}
		//登录次数加1
		$data = array("logincount"=>$user['logincount']+1,"logintime"=>time());
		$this->model->edit($this->model->table_users, $data, $where);
		unset($user['password'],$user['transpassword']);
		$this->init->d->session("save",$user);
		json_ok();
	}
	//注册
	function ajax_reg(){
		$web = $this->init->web;
		if(!isset($web['web_user_register']) || $web['web_user_register']!=1)json_error("注册已关闭");
		$username = post("username");
		$password = post("password");
		$cpassword = post("cpassword");
		$code = post("code");
		$name = post("name");
		$phone = post("phone");
		$phone_code = post("phone_code");
		$transpassword = post("transpassword");
		$qq= post("qq");
		
		if(empty($username)) json_error("帐号不能为空");
		if(empty($password)) json_error("密码不能为空");
		if($password != $cpassword) json_error("两次密码输入不一致");
		if(empty($code)) json_error("验证不能为空");
		if(empty($name)) json_error("姓名不能为空");
		if(empty($phone)) json_error("手机号码不能为空");
		if(empty($transpassword)) json_error("支付密码不能为空");
		
		if(!isset($_SESSION['reg_code'])){
			json_error("验证码过期，请重新生成验证码");
		}
		if($code != $_SESSION['reg_code']){
			json_error("验证码不正确");
		}
		//是否验证手机号
		if(isset($web['web_user_phone']) && $web['web_user_phone']==1){
			if(empty($phone_code))json_error("请输入手机验证码");
			//验证过程
			/**
			 * 需要补充
			 */
		}
		$password = set_user_pass($username, $password);
		//同电脑
		$info = $this->model->get($this->model->table_users_same_pc,array("no"=>$this->init->pcno,"agent_id"=>$this->init->agent_id));
		$pc_u = "";
		if(isset($info['no'])){
			$pc_u = $info['username'];
			$u = ex($info['username']);
			$time = isset($web['web_user_pc_time'])?intval($web['web_user_pc_time']):0;
			$total = isset($web['web_user_pc_total'])?intval($web['web_user_pc_total']):0;
			$last = $time<1?time()+3000:$time*24*3600 + $info['lasttime'];
			if(count($u)>$total && $total>0 && $last>time())json_error("一台电脑只能注册{$total}个帐号");
		}
		//同ip
		$info = $this->model->get($this->model->table_users_same_ip,array("ip"=>$this->init->ip,"agent_id"=>$this->init->agent_id));
		$ip_u = "";
		if(isset($info['ip'])){
			$ip_u = $info['username'];
			$u = ex($info['username']);
			$time = isset($web['web_user_pc_time'])?intval($web['web_user_pc_time']):0;
			$total = isset($web['web_user_pc_total'])?intval($web['web_user_pc_total']):0;
			$last = $time<1?time()+3000:$time*24*3600 + $info['lasttime'];
			if(count($u)>$total && $total>0 && $last>time())json_error("一个ip只能注册{$total}个帐号");
		}
		//判断帐号是否已经被注册
		$info = $this->model->get($this->model->table_users, array("username"=>$username,"agent_id"=>$this->init->agent_id));
		if(isset($info['id']))json_error("您注册的帐号已经被注册,请更换帐号");
		//验证手机号是否唯一性
		if(isset($web['web_user_phone_only']) && $web['web_user_phone_only']==1){
			$info = $this->model->get($this->model->table_users, array("phone"=>$phone,"agent_id"=>$this->init->agent_id));
			if(isset($info['id']))json_error("您注册的手机号码已经被注册,请更换手机号码，或者直接找回帐号");
		}
		$status = isset($web['web_user_activate'])&& $web['web_user_activate']==1?'Y':'N';
		
		//获取推广
		$extend = get_cookieI("extend");
		$bonus = "";
		$parentid = 0;
		$parenttree = "";
		if(!empty($extend)){
			$table_extend = $this->model->table($this->model->table_users_extend);
			$sql = "select * from {$table_group} where (uid='{$extend}' or extend_id='{$extend}') and agent_id={$this->init->agent_id}";
			$info = $this->model->query($sql, 1);
			//若推广存在
			if(isset($info['uid'])){
				$user = $this->model->get($this->model->table_users,array("id"=>$info['uid']));
				if(isset($user['id'])){
					$bonus = $info['bonus'];
					$parentid = $user['id'];
					$parenttree = $user['parenttree'].$parentid.",";
				}
			}
		}
		//获取最低级的会员级别组
		$table_group = $this->model->table($this->model->table_users_group);
		$sql = "select id from {$table_group} where agent_id={$this->init->agent_id} and del='N' order by upmoney";
		$info = $this->model->query($sql, 1);
		$group_id = isset($info['rows'][0]['id'])?$info['rows'][0]['id']:0;
		$data = array(
				"username"=>$username,
				"password"=>$password,
				"group_id"=>$group_id,
				"agent_id"=>$this->init->agent_id,
				"transpassword"=>md5($transpassword),
				"status"=>$status,
				"truname"=>$name,
				"phone"=>$phone,
				"registertime"=>time(),
				"registerip"=>$this->init->ip,
				"parentid"=>$parentid,
				"parenttree"=>$parenttree,
		);
		if($this->model->save($this->model->table_users, $data)){
			//注册成功发送短信,需激活状态
			if(isset($web['web_sms_register']) && $web['web_sms_register']==1 && $data['status']=='Y'){
				/**
				 * 需要补充
				 */
			}
			//激活状态，直接登录
			if($data['status']=='Y'){
				$user = $this->model->get($this->model->table_users, array("username"=>$username,"agent_id"=>$this->init->agent_id));
				unset($user['password'],$user['transpassword']);
				$this->init->d->session("save",$user);
			}
			//添加同电脑
			$data = array("no"=>$this->init->pcno,"agent_id"=>$this->init->agent_id,"username"=>$pc_u.$username.",","lasttime"=>time());
			if(empty($pc_u)){
				$this->model->save($this->model->table_users_same_pc,$data);
			}else{
				unset($data['no']);
				$this->model->edit($this->model->table_users_same_pc,$data,array("no"=>$this->init->pcno));
			}
			//添加同ip
			$data = array("ip"=>$this->init->ip,"agent_id"=>$this->init->agent_id,"username"=>$ip_u.$username.",","lasttime"=>time());
			if(empty($ip_u)){
				$this->model->save($this->model->table_users_same_ip,$data);
			}else{
				unset($data['ip']);
				$this->model->edit($this->model->table_users_same_ip,$data,array("ip"=>$this->init->ip));
			}	
			json_ok();
		}
		json_error("注册失败");
	}
}