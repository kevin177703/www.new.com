<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 后台 2015.07.12
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Main extends Base_Controller {
	public function __construct() {
		parent::__construct ();
		if ($this->uri->segment(1)!="login" && $this->init->uid<1) {
			skip("/login");
		}
		$data = array (
				'is_one'=>$this->init->is_one,
				'is_add' => $this->init->is_add,
				'is_edit' => $this->init->is_edit,
				'is_del' => $this->init->is_del,
				'is_undo' => $this->init->is_undo,
				'is_exam' => $this->init->is_exam,
				'is_conf' => $this->init->is_conf,
				'third'=>$this->init->third_url,
				'css'=>'/public/'.$this->init->version.'/css/',
				'js'=>'/public/'.$this->init->version.'/js/',
				'images'=>'/public/'.$this->init->version.'/images/',
				'web_title'=>$this->init->title,
		);
		$this->init->assign($data);
		$header = $this->init->fetch('header');
		$this->init->assign(array('header'=>$header));
	}
	public function index(){//首页
		$this->init->display("index");
	}
	function login(){//登录界面
		$this->init->display('login');
	}
	function setting($html){//系统设置
		$this->init->display('setting_'.$html);
	}
	function user($html){//用户
		$this->init->display('user_'.$html);
	}
	function money($html){//资金管理
		$this->init->display('money_'.$html);
	}
	function log($html){//日志操作
		$this->display('log_'.$html);
	}
	function message($html){//信息管理
		$this->init->display('message_'.$html);
	}
	function activity($html){//活动管理
		$this->init->display('activity_'.$html);
	}
	function extend($html){//推广代理管理
		$this->init->display('extend_'.$html);
	}
	function game($html){//游戏记录
		$this->init->display('game_'.$html);
	}
	function agent($html){//总代理
		$this->init->display('agent_'.$html);
	}
	function url($html){//url设置
		$this->init->display('url_'.$html);
	}
	function pay($html){//支付管理
		$this->init->display('pay_'.$html);
	}
}