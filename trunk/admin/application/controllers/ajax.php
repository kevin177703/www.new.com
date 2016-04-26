<?php if (!defined('BASEPATH'))exit('No direct script access allowed');
/**
 * 后台ajax 2015.6.1
 *
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Ajax extends Base_Controller {
	public function __construct() {
		parent::__construct ();
		$url2=$this->uri->segment(2);
		if ($this->input->is_ajax_request()==false &&  $url2!="upload") {
			//show_404 ();
		}
		if ($url2!= "login" && $this->init->uid<1) {
			json_error("登录超时，请重新登录!");
		}
		//权限判断
		if(!in_array($url2,array('login','pass','logout'))){
			$this->init->auth();
		}
	}
	function login(){//登录
	}
	function upload(){//上传文件
		$upload = library("dupload","default");
		$upload->save();
	}
	function pass() {//修改密码
	}
	function logout(){//退出
	}
	function opmoney() {//接受，拒绝，审核，冲正负
	}
	function setting($ajax){//系统设置
	}
	function user($ajax) {//会员列表
	}
	function log($ajax) {//日志记录
	}
	function money($ajax) {//资金相关
	}
	function url($ajax) {//url设置相关
	}
	function agent($ajax){//代理相关
	}
	function game($ajax){//游戏相关
	}
	function message($ajax){//信息管理
	}
	function extend($ajax){//代理推广相关
	}
	function pay($ajax){//支付管理相关
	}
}