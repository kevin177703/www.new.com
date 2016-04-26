<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 无权限组  2015.09.03
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Minit {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//首页
	function get_index(){
		$data = array(
				"date"=>date('Y-m-d'),
				"now"=>time(),
				'menu'=>$this->init->d->menu(),
				'is_admin'=>$this->init->agent_id==$this->init->default_admin_agent_id?1:0,
				'agent_list'=>$this->init->d->agent_list(),
				'sel_agent_id'=>$this->init->sel_agent_id,
				'op_agent_id'=>$this->init->op_agent_id,
				'username'=>$this->init->username,
				'group'=>$this->init->group
		);
		$this->init->assign($data);
	}
	//登录
	function get_login(){
		if($this->init->uid>0){
			skip();
		}
	}
	//登录
	function ajax_login(){
		if($this->init->uid>0)json_ok(array(),"已经登录");
		$username = post("username");
		$password = post('password');
		if (empty($username) || empty($password))json_error("请输入帐号和密码");
		$data = $this->model->get($this->model->table_admin, array("username" => $username,"agent_id"=>$this->init->agent_id));
		if (isset($data ['errorcount']) && $data ['errorcount'] >= 5 && $data ['errortime'] + 24 * 3600 > time ()) {
			json_error("密码错误超过5次，请24小时后再试");
		}
		if(isset($data ['id']) && $data['password']== set_user_pass($username, $password)){
			if ($data ['status'] == "N"){
				json_error("帐号已禁用");
			}
			unset($data["password"]);
			$info = array();
			$info["user"] = $data;
			//判断率属总代
			$agent = $this->model->get($this->model->table_agent,array('id'=>$this->init->agent_id));
			if(!isset($agent['id']))json_error("代理不存在或已删除");
			//获取率属总代管理组信息
			$agent_group = $this->model->get($this->model->table_admin,array("id"=>$agent['id']));
			if(!isset($agent_group['id']))json_error("代理设置错误,请联系管理员");
			$agent['agent_group_id']=$agent_group['group_id'];
			$info['agent']=$agent;
			//写入session
			if($this->init->d->session("save",$info)==false){
				$this->init->d->log("登录失败,session写入失败", 1,$data['username'],$data['id']);
				json_error("登录失败");
			}
			$this->model->edit($this->model->table_admin,array('errorcount' =>0,'errortime'=>0,'logintime'=>time()),array("id"=>$data['id']));
			
			$this->init->d->log("登录成功", 1,$data['username'],$data['id']);
			json_ok (array(),"登录成功");
		}
		//记录失败日志
		$username=isset($data['username'])?$data['username']:"";
		$id=isset ($data['id'])? $data['id']:'';
		$_username = post("username");
		$this->init->d->log("{$_username}登录失败", 1,$username,$id);
		
		if(isset($data['id'])){
			$data ['errorcount']=($data ['errortime']+24*3600<time())?0:$data['errorcount'];
			$count=isset($data['errorcount'])?$data['errorcount']+1:1;
			$this->model->edit($this->model->table_admin,array('errorcount'=>$count,'errortime'=>time()),array("id" =>$data['id']));
			$ocount=5-$count;
			json_error("登录失败,此帐号24小时内还有{$ocount}次登录机会");
		}
		
		json_error("登录失败,帐号已删除或不存在");
	}
	//退出
	function ajax_logout(){
		$cache_key = $this->init->token.$this->model->memcache->key_session;
		$this->model->memcache->delete($cache_key);
		del_all_cookie();
		json_ok();
	}
	//修改密码
	function ajax_pass(){
		if($this->init->uid<1)json_error("登录超时，请重新登录");
		$password = post('password');
		$new_password = post('new_password');
		$c_new_password = post('c_new_password');
		if(empty($password))json_error("请填写原始密码");
		if(empty($new_password))json_error("请填写新密码");
		if($password==$new_password)json_error("新密码不能和原始密码一样");
		if($new_password != $c_new_password) json_error("新密码两次不一致");
		$user = $this->model->get($this->model->table_admin, array("id"=>$this->init->uid));
		if(!isset($user['password']) || $user['password']!=set_user_pass($this->init->username, $password)){
			json_error("原始密码错误");
		}
		$_password = set_user_pass($this->init->username, $new_password);
		if($this->model->edit($this->model->table_admin, array("password"=>$_password), array("id"=>$this->init->uid))){
			json_ok();
		}
		json_error("密码修改失败");
	}
	//资金操作,
	function ajax_opmoney(){
		//冲正负
		if($this->init->action=='undo'){
			$this->_undo();
			return true;
		}
		$id = post("id","int");
		$type = post("type","int");
		$note = post("note");
		$note_other = post("note_other");
		//判断必须参数
		if($id<1 || $type<1)json_error("参数错误001");
		//判断数据是否存在
		$data = $this->model->get($this->model->table_money_note, array("agent_id"=>$this->init->sel_agent_id,"id"=>$id));
		if(!isset($data['id']))json_error("数据不存在");
		//判断资金类型
		$money_type = $this->init->d->get_money_type_list();
		if(!isset($money_type[$data['money_type']]['id']))json_error("资金类型错误");
		$money_type = $money_type[$data['money_type']];
		//判断资金状态
		$money_status = $this->init->d->get_money_status_list();
		if(!isset($money_status[$data['status']]['id']))json_error("资金状态错误");
		$money_status = $money_status[$data['status']];
		
		$username = $this->init->username;
		$date = date("Y-m-d H:i:s");
		$message = array("data"=>"数据错误","money"=>"资金不足","max"=>"超过每日最大资金操作额度","error"=>"操作失败");
		switch ($this->init->action){
			case "exam"://审核通过/拒绝
				if($this->init->is_exam=='N')json_error("你没有审核权限");
				if(!in_array($type, array(3,4)))json_error("参数错误002");
				//判断是否需要审核
				if($money_type['isexam']=='N' || $data['status'] != MONEY_STATUS_EXAM)json_error("订单【{$data['orderid']}】不需要审核");
				$note = empty($note)?$note_other:"{$note},{$note_other}";
				$status = $type==3?MONEY_STATUS_CONFIRM:MONEY_STATUS_REJECT;
				$opnote = $type==3?"{$date} {$username} 通过审核":"{$date} {$username} 拒绝审核<br/>原因:{$note}";
				$log_type = $type==3?"审核通过":"审核拒绝";
				$info = $this->model->op_money_note($data['money'],$id,$this->init->uid,$status,$opnote,$log_type);
				if($info=="success")json_ok("审核成功");
				json_error($message[$info]);
				break;
			case "conf"://资金接受/拒绝
				if($this->init->is_conf=='N')json_error("你没有资金确认权限");
				if(!in_array($type, array(1,2)))json_error("参数错误002");
				//判断是否需要前置审核
				if($money_type['isexam']=='Y' && $data['status'] == MONEY_STATUS_EXAM)json_error("订单【{$data['orderid']}】还没有审核，无法操作");
				if($data['status'] != MONEY_STATUS_CONFIRM)json_error("订单【{$data['orderid']}】无接受或拒绝操作");
				$note = empty($note)?$note_other:"{$note},{$note_other}";
				$status = $type==1?MONEY_STATUS_SUCCESS:MONEY_STATUS_REJECT;
				$opnote = empty($data['opnote'])?"":"{$data['opnote']}<br/>";
				$opnote = $type==1?"{$opnote}{$date} {$username} 资金接受":"{$opnote}{$date} {$username} 资金拒绝<br/>原因:{$note}";
				$log_type = $type==1?"资金确认":"资金拒绝";
				$info = $this->model->op_money_note($data['money'],$id,$this->init->uid,$status,$opnote,$log_type);
				if($info=="success")json_ok("操作成功");
				json_error($message[$info]);
		}
		json_error("操作错误");
	}
	//冲正负
	private function _undo(){
		$uid = post("uid","int");
		$money = post("money");
		$note = post("note");
		if($uid<1)json_error("参数错误");
		if(!is_numeric($money))json_error("请输入正确的金额");
		if(empty($note))json_error("请输入冲正负说明");
		if($money<0){
			//取出平台的资金金额.然后才是后续操作
			/**
			 * get_all_money
			 */
		}
		$result = $this->model->undo($uid, $this->init->sel_agent_id, $money, $note, $this->init->uid);
		$message = array("data"=>"数据错误","money"=>"资金不足","max"=>"超过每日最大资金操作额度","error"=>"操作失败");
		if($result == 'success')json_ok();
		json_error($message[$result]);
	}
}