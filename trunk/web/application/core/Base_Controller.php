<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * Base_Controller  2015.07.27
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
/**
 * 实现代码提示功能
 * @property CI_Loader $load
 * @property CI_DB_active_record $db
 * @property CI_Calendar $calendar
 * @property Email $email
 * @property CI_Encrypt $encrypt
 * @property CI_Ftp $ftp
 * @property CI_Hooks $hooks
 * @property CI_Image_lib $image_lib
 * @property CI_Language $language
 * @property CI_Log $log
 * @property CI_Input $input
 * @property CI_Output $output
 * @property CI_Pagination $pagination
 * @property CI_Parser $parser
 * @property CI_Session $session
 * @property CI_Sha1 $sha1
 * @property CI_Table $table
 * @property CI_Trackback $trackback
 * @property CI_Unit_test $unit
 * @property CI_Upload $upload
 * @property CI_URI $uri
 * @property CI_User_agent $agent
 * @property CI_Validation $validation
 * @property CI_Xmlrpc $xmlrpc
 * @property CI_Zip $zip
 * @property CI_Form $form_validation
 * @property Dinit $init
 * @property Dmode_model $model
 */
class Base_Controller extends CI_Controller {
	public $init = null;               //起始类
	public $model = null;              //默认数据模型
	public function __construct() {
		parent::__construct ();
		$this->init();
	}
	private function init(){
		$this->model = model("dmodel");
		$this->init = library("dinit","default");
		$data = array(
				'third'=>$this->init->third_url,
				'css'=>'/public/'.$this->init->version.'/css/',
				'js'=>'/public/'.$this->init->version.'/js/',
				'images'=>'/public/'.$this->init->version.'/images/',
				'web_title'=>$this->init->title,
				'message_nav'=>$this->init->d->get_message_notice(1,5),
				'user'=>$this->init->user,
				'uid'=>$this->init->uid,
				'username'=>$this->init->username,
		);
		$this->init->assign($data);
		$this->lib();
	}
	private function lib(){
		//开始判断library类
		$url1 = $this->uri->segment(1);
		$url2 = $this->uri->segment(2);
		$url3 = $this->uri->segment(3);
		$url1 = strtolower($url1);
		$url2 = strtolower($url2);
		$url3 = strtolower($url3);
		//首页
		$url = empty($url1)?"index":$url1;
		$url = $url1=='ajax'?$url2:$url;
		$url = $url2=='ajax'?"member-$url3":$url;

		if(strpos($url,"-")==false)$url="minit-{$url}";
		$url = ex($url,"-");
		$class = $url[0];
		$method = $url[1];
		if($class=="member"){
			if($this->init->uid<1){
				skip("/","登录超时，请重新登录!");
			}
			$class = $url[1];
			$method = isset($url[2])?$url[2]:"";
			if($class=='index'){
				$class="minit";
				$method = "member";
			}
		}
		if(empty($class) || empty($method)){
			show_404();
		}
		//判断ajax是否已登录
		if(($url1=='member' && $url2=="ajax") && $this->init->uid<1){
			json_error("登录超时，请重新登录");
		}
		//判断类
		$class = ucfirst($class);
		$path = ROOT."application/libraries/model/{$class}.php";
		if(!file_exists($path)){
			show_404();
		}
		require_once $path;
		if(!class_exists($class)){
			show_404();
		}
		//判断类的方法
		$class = new $class($this->init,$this->model);
		$method = ($url1=="ajax" || ($url1=='member' && $url2=="ajax"))?"ajax_{$method}":"get_{$method}";
		if(!method_exists($class, $method)){
			show_404();
		}
		$class->$method();
	}
}