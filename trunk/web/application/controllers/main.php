<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 前端 2015.08.12
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Main extends Base_Controller {
	public function __construct() {
		parent::__construct ();
	}
	function index(){//首页
		$this->init->display("index");
	}
	function reg(){//注册
		$this->init->display("reg");
	}
	function game($html){//游戏页面
		$this->init->display("game");
	}
}