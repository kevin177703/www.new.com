<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 资金相关  2015.09.02
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Money {
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model) {
		$this->model = $model;
		$this->init = $init;
	}
	//个人中心-财务中心-在线取款
	function get_draw(){
		$this->init->set_header(array("title"=>"个人中心-财务中心-在线取款"));
	}
	//个人中心-财务中心-在线取款
	function ajax_draw(){
		
	}
	//个人中心-财务中心-在线支付/易宝支付
	function get_pay(){
		$this->init->set_header(array("title"=>"个人中心-财务中心-在线支付"));
		$data['mindeposit']=isset($this->init->group['mindeposit'])?$this->init->group['mindeposit']:100;
		$data['maxdeposit']=isset($this->init->group['maxdeposit'])?$this->init->group['maxdeposit']:10000;
		$this->init->assign(array("data"=>$data));
	}
	//个人中心-财务中心-在线支付/易宝支付
	function ajax_pay(){
		$paymoney = post("paymoney");
		$paybank = post("paybank");
		if(empty($paymoney) || !is_numeric($paymoney))json_error("请输入正确的存款金额");
		if(empty($paybank))json_error("请选择银行");
		$mindeposit=isset($this->init->group['mindeposit'])?$this->init->group['mindeposit']:100;
		$maxdeposit=isset($this->init->group['maxdeposit'])?$this->init->group['maxdeposit']:10000;
		if($paymoney<$mindeposit || $paymoney>$maxdeposit)json_error("存款金额范围为{$mindeposit}~{$maxdeposit}");
		$orderid = $this->init->d->get_only_no(17,"yee");
		$paymd5 = md5("{yee#{$this->init->uid}#{$orderid}#{$paymoney}#{$paybank}#pay}");
		if($this->_add_money($paymoney, MONEY_TYPE_YEEPAY,"易宝支付","在线支付-{$paybank}",$orderid,MONEY_STATUS_ING,$paymd5)){
			$data['payorderid']=$orderid;
			$data['paymd5'] = $paymd5;
			json_ok($data);
		}
		json_error("支付申请失败，请重新再试");
	}
	//个人中心-财务中心-银行转账
	function get_bank(){
		$this->init->set_header(array("title"=>"个人中心-财务中心-银行转账"));
		$where = array("agent_id"=>$this->init->agent_id,"group_id"=>$this->init->group_id,"status"=>"Y");
		$money_bank = $this->model->get_list($this->model->table_money_bank, $where,1000);
		$data['money_bank'] = $money_bank['rows'];
		$data['money_bank_json'] = json_encode($money_bank['rows']);
		$data['user_bank_type'] = $this->init->d->get_user_banktype();  //获取用户银行类别
		$data['mindeposit']=isset($this->init->group['mindeposit'])?$this->init->group['mindeposit']:100;
		$data['maxdeposit']=isset($this->init->group['maxdeposit'])?$this->init->group['maxdeposit']:10000;
		$this->init->assign(array("data"=>$data));
	}
	//个人中心-财务中心-银行转账
	function ajax_bank(){
		$money_bank_id = post('money_bank_id');
		$bankname = post('bankname');
		$bankcard = post('bankcard');
		$bankowner = post('bankowner');
		$bankaddress = post('bankaddress');
		$banktype = post('banktype');
		$bankmoney = post('bankmoney');
		$remarks =post('remarks');
		if($money_bank_id<1)json_error("请选择收款账户");
		if(empty($bankname))json_error("请选择存款银行");
		if(empty($bankcard))json_error("请输入银行卡号后4位");
		if(empty($bankowner))json_error("请输入存款户名");
		if(empty($bankaddress))json_error("请输入开户地址");
		if(empty($banktype))json_error("请选择付款方式");
		if(empty($bankmoney) || !is_numeric($bankmoney))json_error("请输入正确的存款金额");
		$where = array("agent_id"=>$this->init->agent_id,"group_id"=>$this->init->group_id,"status"=>'Y',"id"=>$money_bank_id);
		$bank = $this->model->get($this->model->table_money_bank, $where);
		if(!isset($bank['id']))json_error("请选择正确的收款账户");
		$mindeposit=isset($this->init->group['mindeposit'])?$this->init->group['mindeposit']:100;
		$maxdeposit=isset($this->init->group['maxdeposit'])?$this->init->group['maxdeposit']:10000;
		if($bankmoney<$mindeposit || $bankmoney>$maxdeposit)json_error("存款金额范围为{$mindeposit}~{$maxdeposit}");
		$note = "{$bankname},{$bankaddress},{$banktype}<br/>{$bankowner},{$bankcard}<br/>{$remarks}";
		$orderid = get_rand(16,"bank");
		if($this->_add_money($bankmoney, MONEY_TYPE_BANK,$bank['name']."({$bank['card']})",$note,$orderid,MONEY_STATUS_EXAM)){
			json_ok();
		}
		json_error("支付申请失败，请重新再试");
	}
	//添加存款报表
	private function _add_money($money,$money_type,$bank,$note,$orderid,$status,$paymd5=""){
		$info = array();
		$info['orderid'] = $orderid;
		$info['uid']=$this->init->uid;
		$info['agent_id']=$this->init->agent_id;
		$info['money']=$money;
		$info['money_type']=$money_type;
		$info['status']=$status;
		$info['bank']=$bank;
		$info['note']=$note;
		$info['paymd5']=$paymd5;
		$info['addtime']=time();
		$id = $this->model->save($this->model->table_money_note, $info);
		if($id>0)return true;
		return false;
	}
}