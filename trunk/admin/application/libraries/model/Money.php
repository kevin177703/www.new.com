<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 资金管理 2015.07.20
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Money {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->init = $init;
		$this->model = $model;
	}
	//第三方支付
	function get_third(){}
	//第三方支付
	function ajax_third(){
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_money_third,array("agent_id"=>$this->init->sel_agent_id),$this->init->limit,$this->init->offset,array('id'));
				$pay = array("1"=>"易宝支付");
				foreach ($data['rows'] as $k=>$v){
					$v['type_wz'] = isset($pay[$v['type']])?$pay[$v['type']]:color("支付方式错误");
					$v['status_wz'] = $v['status']=='Y'?"启用":"关闭";
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case 'save' :
				$id = post('id');
				$type = post("type");
				$username=post('username');
				$pass = post("pass");
				$code = post("code");
				$url = post("url");
				$money = post("money"); 
				$skey = post("skey");
				if(!in_array($type, array(1,2)))json_error("请选择正确的支付方式");
				if(empty($username))json_error("请输入支付帐号");
				if(empty($pass))json_error("请输入支付密码");
				if(empty($code))json_error("请输入商户号");
				if(empty($skey))json_error("请输入密钥");
				if(empty($url))json_error("请绑定支付域名");
				$data = array("type"=>$type,"username"=>$username,"pass"=>$pass,"code"=>$code,"money"=>$money,"skey"=>$skey,"url"=>$url);
				if($id>0){
					if($this->model->edit($this->model->table_money_third,$data, array('id'=>$id))==false) {
						$id = 0;
					}else{
						$this->init->d->log("编辑第三方支付id={$id}", 4);
					}
				}else{
					$data['agent_id']=$this->init->sel_agent_id;
					$id = $this->model->save($this->model->table_money_third, $data);
					if($id>0){
						$this->init->d->log("添加第三方支付id={$id}",3);
					}
				}
				if ($id>0){
					json_ok();
				}
				$this->model->memcache->setNo($cache_key);
				json_error("设置失败");
				break;
			case 'one' :
				$this->init->d->one($this->model->table_money_third,true);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_money_third);
				break;
		}
	}
	//资金记录
	function get_note(){
		$data['money_status'] = $this->init->d->get_money_status_list();
		$data['users_group']=$this->init->d->get_agent_user_group_list();
		$data['money_type']=$this->init->d->get_money_type_list();
		$data['note_message']=array("金额不正确"=>"金额不正确","资金没到账"=>"资金没到账","电话无人接听"=>"电话无人接听","电话无法打通"=>"电话无法打通",""=>"其他原因",);
		$this->init->assign(array("data"=>$data));
	}
	//资金记录
	function ajax_note(){
		switch ($this->init->action){
			case "all":
				$username = post("username");
				$orderid = post("orderid");
				$begin = post("begin");
				$end = post("end");
				$groupid = post("groupid");
				$type = post("type");
				$status = post("status");
				$operator = post("operator");
				$min_money = post("min_money");
				$max_money = post("max_money");
				$where = "";
				if(!empty($username))$where .=" and u.username like '%{$username}%'";
				if(!empty($orderid))$where .=" and n.orderid='{$orderid}'";
				if(!empty($begin))$where .=" and n.addtime >= '".strtotime($begin." 00:00:00")."'";
				if(!empty($end))$where .=" and n.addtime <= '".strtotime($end." 23:59:59")."'";
				if($type>0)$where .=" and n.money_type='{$type}'";
				if($groupid>0)$where .=" and u.group_id='{$groupid}'";
				if($status>0)$where .=" and n.status='{$status}'";
				if(!empty($operator))$where .=" and n.opnote like '%{$operator}%'";
				if($min_money>0)$where .=" and n.money >= '{$min_money}'";
				if($max_money>0)$where .=" and n.money <= '{$max_money}'";
				$note = $this->model->table($this->model->table_money_note);
				$user = $this->model->table($this->model->table_users);
				$sql = "select n.*,u.username,u.truname,u.group_id from {$note} n,{$user} u where n.uid=u.id and n.del='N' and "
					."n.agent_id='{$this->init->sel_agent_id}' and u.agent_id='{$this->init->sel_agent_id}' and u.del='N' {$where} ";
				$data = $this->model->query($sql, $this->init->limit,$this->init->offset,"n.addtime");
				if($data['total']>0){
					$user_group = $this->init->d->get_agent_user_group_list();
					$money_status = $this->init->d->get_money_status_list();
					$money_type=$this->init->d->get_money_type_list();
					foreach ($data['rows'] as $k=>$v){
						$v['group_name']=isset($user_group[$v['group_id']]['name'])?$user_group[$v['group_id']]['name']:color("级别错误");
						$v['type_name']=isset($money_type[$v['money_type']]['name'])?$money_type[$v['money_type']]['name']:color("类型错误");
						$v['status_name']=isset($money_status[$v['status']]['name'])?$money_status[$v['status']]['name']:color("状态错误");
						$v['addtime_wz']=time_red($v['addtime']);
						$data['rows'][$k]=$v;
					}
				}
				echo json_encode($data);
				break;
		}
	}
	//资金状态
	function get_status(){}
	//资金状态
	function ajax_status(){
		$this->init->lock("money_status");
		$cache_key = $this->model->memcache->key_money_status;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_money_status,array(),$this->init->limit,$this->init->offset,array('id'));
				echo json_encode($data);
				break;
			case 'save' :
				$id = post('id');
				$name=post('name');
				if(empty($name))json_error("请输入资金状态");
				if($id>0){
					if($this->model->edit($this->model->table_money_status,array("name"=>$name), array('id'=>$id))==false) {
						$id = 0;
					}else{
						$this->init->d->log("编辑资金状态id={$id}", 4);
					}
				}else{
					$id = $this->model->save($this->model->table_money_status, array("name"=>$name));
					if($id>0){
						$this->init->d->log("添加资金状态id={$id}",3);
					}
				}
				if ($id>0){
					json_ok();
				}
				$this->model->memcache->setNo($cache_key);
				json_error("设置失败");
				break;
			case 'one' :
				$this->init->d->one($this->model->table_money_status,true,false);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_money_status,$cache_key,false);
				break;
		}
	}
	//收款银行
	function get_bank(){}
	//收款银行
	function ajax_bank(){
		$cache_key = $this->model->memcache->key_money_bank;
		switch ($this->init->action){
			case 'save' :
				$id = post('id');
				$data['name']=post('name');
				$data['intro']=post('intro');
				$data['card']=post('card');
				$data['truname']=post('truname');
				$data['address']=post('address');
				$data['status']=post('status');
				$data['group_id']=post('group_id');
				if(empty($data['name']))json_error("请输入银行名称");
				if(empty($data['card']))json_error("请输入银行卡号");
				if(empty($data['truname']))json_error("请输入开户名");
				if(empty($data['address']))json_error("请输入开户地址");
				if($data['group_id']<1)json_error("请选择会员级别");
				if ($id>0){
					//判断是否是合法操作
					$this->init->d->legal($this->model->table_money_bank,$id);
					if($this->model->edit($this->model->table_money_bank, $data, array('id'=>$id))==false) {
						$id = 0;
					}else{
						$this->init->d->log("编辑转账银行id={$id}", 4);
					}
				} else {
					$data['agent_id']=$this->init->sel_agent_id;
					$id = $this->model->save($this->model->table_money_bank, $data);
					if($id>0){
						$this->init->d->log("添加转账银行id={$id}",3);
					}
				}
				if ($id>0){
					$data['id']=$id;
					json_ok();
				}
				$this->model->memcache->setNo($cache_key);
				json_error("设置失败");
				break;
			case 'all' :
				$data = $this->model->get_list($this->model->table_money_bank,array("agent_id"=>$this->init->sel_agent_id),$this->init->limit,$this->init->offset,array('id'));
				$user_group = $this->model->get_list($this->model->table_users_group, array("agent_id"=>$this->init->sel_agent_id),1000);
				$user_group = $user_group['rows'];
				foreach ($data['rows'] as $k=>$v){
					$v['group_name'] = color("级别错误");
					foreach ($user_group as $vv){
						if($vv['id']==$v['group_id'])$v['group_name']=$vv['name'];
					}
					$v['status_wz'] = $v['status']=='Y'?color("启用","green"):color("禁用");
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case 'one' :
				$this->init->d->one($this->model->table_money_bank,true);
				break;
			case 'group' :
				$data = $this->model->get_list($this->model->table_users_group, array("agent_id"=>$this->init->sel_agent_id),1000);
				$data = merge(array(array('id'=>0,'name' =>'请选择会员级别')), $data['rows']);
				echo json_encode($data);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_money_bank,$cache_key);
				break;
		}
	}
	//资金管理，资金类型
	function get_type(){}
	//资金管理，资金类型
	function ajax_type(){
		$this->init->lock("money_type");
		$cache_key = $this->model->memcache->key_money_type;
		switch ($this->init->action){
			case "all":
				$data = $this->model->get_list($this->model->table_money_type,array(),$this->init->limit,$this->init->offset,array('id'));
				foreach ($data['rows'] as $k=>$v){
					$v['isbonus_wz']=$v['isbonus']=='Y'?"有返水":"无返水";
					$v['isexam_wz']=$v['isexam']=='Y'?"需审核":"不需审核";
					$data['rows'][$k]=$v;
				}
				echo json_encode($data);
				break;
			case 'save' :
				$id = post('id');
				$name=post('name');
				$isbonus=post('isbonus');
				$isexam=post('isexam');
				if(empty($name))json_error("请输入资金类型");
				if(!in_array($isbonus, array("Y","N")))json_error("返水设置错误");
				if(!in_array($isexam, array("Y","N")))json_error("审核设置错误");
				$code = strtolower($code);
				$data = array("name"=>$name,"isbonus"=>$isbonus,"isexam"=>$isexam);
				$info = $this->model->get($this->model->table_money_type, array("code"=>$code));
				if($id>0){
					if(isset($info['id']) && $info['id']!=$id)json_error("类型编码必须唯一");
					if($this->model->edit($this->model->table_money_type,$data, array('id'=>$id))==false) {
						$id = 0;
					}else{
						$this->init->d->log("编辑资金类型id={$id}", 4);
					}
				}else{
					if(isset($info['id']))json_error("类型编码必须唯一");
					$id = $this->model->save($this->model->table_money_type, $data);
					if($id>0){
						$this->init->d->log("添加资金类型id={$id}",3);
					}
				}
				if ($id>0){
					json_ok();
				}
				$this->model->memcache->setNo($cache_key);
				json_error("设置失败");
				break;
			case 'one' :
				$this->init->d->one($this->model->table_money_type,true,false);
				break;
			case 'del' :
				$this->init->d->del($this->model->table_money_type,$cache_key,false);
				break;
		}
	}
}