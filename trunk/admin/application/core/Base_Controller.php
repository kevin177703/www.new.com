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
 * @property Dsmarty $smarty
 * @property Dinit $init
 * @property Dmodel_model $model
 */
class Base_Controller extends CI_Controller {
	public $init = null;               //起始类
	public $model = null;              //数据模型
	public function __construct() {
		parent::__construct ();
		$this->model = model("dmodel");
		$this->init = library("dinit","default");
		$this->init();
	}
	function init(){
		//开始判断library类
		$url1 = $this->uri->segment(1);
		$url2 = $this->uri->segment(2);
		$url1 = strtolower($url1);
		$url2 = strtolower($url2);
		//首页
		$url1 = empty($url1)?"index":$url1;
		$url = $url1;
		if($url1=="ajax"){
			$url = $url2;
		}
		if(strpos($url,"-")==false)$url="minit-{$url}";
		$url = ex($url,"-");
		if(count($url)!=2 || empty($url[0]) || empty($url[1])){
			write_404("链接为空{$url1}-{$url2}-{$url3}");
			show_404();
		}
		//判断类
		$class = strtolower($url[0]);
		$class = ucfirst($class);
		$path = ROOT."application/libraries/model/{$class}.php";
		if(!file_exists($path)){
			write_404("{$path}不存在");
			show_404();
		}
		require_once $path;
		if(!class_exists($class)){
			write_404("{$path}的类{$class}不存在");
			show_404();
		}
		//判断类的方法
		$class = new $class($this->init,$this->model);
		$method = strtolower($url[1]);
		$method = $url1=="ajax"?"ajax_{$method}":"get_{$method}";
		if(!method_exists($class, $method)){
			write_404("{$path}的类{$class}的方法{$method}不存在");
			show_404();
		}
		$class->$method();
	}
}