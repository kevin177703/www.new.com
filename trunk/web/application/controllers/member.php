<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 用户中心 2015.08.12
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Member extends Base_Controller {
	public function __construct() {
		parent::__construct ();
		$this->init->assign(
			array(
				'message_center'=>$this->init->d->get_message_notice(2,5),
			)
		);
	}
	function index(){
		$this->init->display("member_index");
	}
	function money($html){
		$this->init->display("member_{$html}");
	}
	function extend($html){
		$this->init->display("member_{$html}");
	}
	function basic($html){
		$this->init->display("member_{$html}");
	}
}