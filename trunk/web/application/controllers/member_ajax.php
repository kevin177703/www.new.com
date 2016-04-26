<?php if (!defined('BASEPATH'))exit('No direct script access allowed');
/**
 * 登录后的 2015.9.1
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Member_ajax extends Base_Controller {
	public function __construct() {
		parent::__construct ();
		if($this->init->uid<1){
			json_error("您的登录已经超时，请重新登录","login");
		}
	}
	function basic($action){//基本资料
	}
	function money($action){//财务中心
	}
}