<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 默认处理方法  2015.07.20
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
/**
 * @property Dmodel $d
 * @property Dsmarty $smarty
 */
class Dinit{
	//模型类
	public $smarty = null;                   //smarty类
	public $d = null;                        //公共数据类
	
	//登录用户信息
	public $group = null;                    //用户组信息
	public $agent = null;                    //总代信息
	public $user = null;                     //用户信息
	public $agent_id = 0;                    //一级代理id   
	public $uid = 0;                         //用户uid
	public $username = null;                 //用户登录名
	public $group_id = 0;                    //用户分组id
	
	//推广信息
	public $e_parentid = 0;                  //推广父id
	public $e_parenttree = "";               //推广父类树
	
	//网站信息
	public $web_host = "";                   //网站域名
	public $title = "";                      //网站名称
	public $logo = "";                       //网站logo
	public $version = "";                    //域名对应模版编号
	public $web = "";                        //网站设置
	
	//设置信息
	public $setting = null;                  //设置类
	public $third_url = "/";              	 //第三方文件路径
	public $logo_url = "/";                  //logo路径
	
	public $ip = "";                         //ip地址
	public $token=null;                      //令牌
	public $session_time = 24;               //session有效时间,单位小时,n时间内没有活动，删除数据库中session,时间请大于memcache缓存时间;
	public $url = "";                        //当前访问url  
	public $pcno = null;                     //保存同电脑id 
	
	public $sql_open_no = null;              //数据库执行编号
	public $ci = null;
	
	private $token_id = null;                //令牌id
	private $pc_id = null;                   //pc保存id

	//构造函数
	function __construct(){
		$this->ci = ci();
		$this->d = library("dmodel");
		$this->smarty = library("dsmarty","default");
		$this->sql_open_no = get_rand(10);
		$this->init();
	}
	//起始
	function init(){
		$this->d->init($this);
		$this->url = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		//操作ip
		$this->ip=$this->ci->input->ip_address();
		//获取令牌id,使用域名md5,只本地cookie使用
		$this->token_id=md5(HOST.KEY);
		//获取令牌
		$this->getToken();
		//若令牌为空侧设置令牌
		$this->setToken();
		//获取同电脑
		$this->getPcno();
		//根据域名获取代理信息
		$host = $this->d->host();
		//判断绑定的页面版本,版本不存在404
		if(!isset($host['version']) || empty($host['version'])){
			write_404("版本获取失败,请检查版本设置(".HOST.")");
			echo "网站版本设置错误，请联系客服";
			exit();
		}
		foreach ($host as $k=>$v){
			$this->$k=$v;
		}
		//设置smarty模版路径
		$this->smarty->set_template(PUB.$this->version.'/html/');
		//获取配置的信息
		$setting = $this->d->setting();
		if(isset($_GET['pppp'])){
			print_r($setting);
			exit();
		}
		$this->third_url = isset($setting['server']['server_third_url']) && !empty($setting['server']['server_third_url'])?$setting['server']['server_third_url']:"/";
		$this->logo_url = isset($setting['server']['server_logo_url']) && !empty($setting['server']['server_logo_url'])?$setting['server']['server_logo_url']:"/";
		$ip_web_blacklist = isset($setting['ip']['ip_web_blacklist'])?trim($setting['ip']['ip_web_blacklist']):"";
		$ip_web_whitelist = isset($setting['ip']['ip_web_whitelist'])?trim($setting['ip']['ip_web_whitelist']):"";
		if(!check_ip($this->ip, $ip_web_whitelist)){
			if(check_ip($this->ip, $ip_web_blacklist)){
				write_404("IP受限{$this->ip}");
				echo "您所在的IP访问受限，请联系客服";
				exit();
			}
		}
		$this->web = isset($setting['web'])?$setting['web']:"";
		if(!isset($this->web['web_setting_status']) || empty($this->web['web_setting_status'])){
			write_404("网站配置错误");
			echo "网站正在建设中,请稍等...";
			exit();
		}
		if($this->web['web_setting_status']==2){
			echo "网站正在维护中，请稍等...";
			exit();
		}
		if($this->web['web_setting_status']==3){
			echo "网站已暂时关闭，请等待...";
			exit();
		}
		//获取sessing表信息
		$session = $this->d->session();
		//登录以后才进行
		if(isset($session['id']) && $session['id']>0){
			$this->user = $session;
			$this->uid = $session['id'];
			foreach ($this->user as $k=>$v){
				$this->$k=$v;
			}
			$this->group = $this->d->get_user_group();
			$this->group_id = isset($this->group['id'])?$this->group['id']:0;
		}
		//没登录状态
		if($this->uid<1){
			$url1=$this->ci->uri->segment(1);
			//符合推广定义
			if(preg_match("/^e-([0-9a-z]+)/", $url1)){
				$info = ex($url1,'-');
			 	set_cookieI("extend", $info[1]);
			}
		}
	}
	//获取pc编号
	function getPcno(){
		$this->pc_id = md5('pc_'.HOST.KEY);
		$this->pcno = get_cookieI($this->pc_id);
		if(empty($this->pcno)){
			$pcno = get_rand(20).microtime(true);
			$this->pcno = md5($pcno);
			set_cookieI($this->pc_id, $this->pcno,time()+3600*730);
		}
		return $this->pcno;
	}
	//获取登录令牌
	function getToken() {
		$this->token = get_cookieI($this->token_id);
		$this->token = strtolower($this->token);
		return $this->token;
	}
	//设置登录令牌
	function setToken() {
		if (empty($this->token)){
			//随机生成20位数据
			$token=get_rand(30)." ".microtime(true);
			$this->token = md5($token.KEY);
			set_cookieI($this->token_id,$this->token);
			$this->token=strtolower($this->token);
		}
	}
	//引入smarty模版，带参数
	function display($html, $data = array()) {
		$this->smarty->assign($data);
		$this->smarty->display($html.'.html');
	}
	//引入smarty模版参数
	function assign($data){
		$this->smarty->assign($data);
	}
	//直接返回smarty模版数据,带参数
	function fetch($html, $data = array()) {
		$this->smarty->assign($data);
		return $this->smarty->fetch($html.'.html');
	}
	//设置头文件
	function set_header($data){
		$info = array (
				'title'=>$data['title'],
				'web'=>$this->web,
				'logo'=>$this->logo,
		);
		$this->assign($info);
		$header = $this->fetch('header');
		$footer = $this->fetch('footer');
		$this->assign(array('header'=>$header,'footer'=>$footer));
	}
}