<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 公共lib 2015.09.04
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 * 
 * @property Dmodel_model $model
 * @property Dinit $init
 */
class Minit{
	private $model;                          //默认model
	private $init;                           //默认类
	function __construct($init,$model){
		$this->model = $model;
		$this->init = $init;
	}
	//网站首页
	function get_index(){
		$this->init->set_header(array("title"=>"首页"));
	}
	//注册
	function get_reg(){
		if($this->init->uid>0)skip("/member-index","您已经登录,准备进入个人中心.");
		$this->init->set_header(array("title"=>"注册"));
	}
	//个人中心首页
	function get_member(){
		$this->init->set_header(array("title"=>"个人中心-首页"));
	}
	//验证码
	function ajax_code(){
		$action = get("action");
		$x = get("x");
		$y=get("y");
		if(empty($action))$action="kv";
		if($x<50)$x=50;
		if($y<20)$y=20;
		$path = DATA."code/";
		del_dir($path);
		mk_dir($path);
		if(!file_exists($path.'index.html')){
			$content = '<!DOCTYPE html><html><head><title>403 Forbidden</title><meta charset="UTF-8">'
					.'</head><body><h1>Directory access is forbidden.</h1></body></html>';
			write($path.'index.html',$content,'w+');
		}
		$this->init->ci->load->helper('captcha');
		$vals = array(
				'word' => rand(1000, 9999),
				'img_path' => $path,
				'img_url' => '/data/code/',
				'img_width' => $x,
				'img_height' => $y,
				'word_length'   => 8,
				'expiration' => 7200,
		);
		$cap = create_captcha($vals);
		$_SESSION[$action.'_code'] = $cap['word'];
		echo "/data/code/".$cap['filename'];
		exit();
	}
}