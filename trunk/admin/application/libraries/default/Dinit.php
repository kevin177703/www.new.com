<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 默认处理方法  2015.07.20
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
/**
 * @property Setting_model $model
 * @property Dmodel $d
 */
class Dinit{
	//模型类
	private $model = null;
	public $smarty = null;             		//smarty类
	
	//公共方法
	public $d = null;
	
	//权限
	public $is_del = 'N'; 					 //删除权限
	public $is_list = 'N'; 			         //查看列表权限
	public $is_one = 'N'; 			         //查看查看权限
	public $is_add = 'N'; 					 //添加权限
	public $is_edit = 'N'; 					 //编辑权限
	public $is_undo = 'N'; 					 //冲正负权限
	public $is_exam = 'N'; 					 //资金审核
	public $is_conf = 'N'; 					 //资金确认
	
	//设置
	public $default_admin_agent_id = 1;      //总管理代理号
	public $default_admin_group_id = 1;      //总管理组
	public $default_agent_group_id = 2;      //总代理组
	
	//登录用户信息
	public $group = null;                    //用户组信息
	public $agent = null;                    //总代信息
	public $user = null;                     //用户信息
	public $agent_id = 0;                    //一级代理id   //代理id为default_admin_agent_id，表示为总管理
	public $uid = 0;                         //用户uid
	public $username = null;                 //用户登录名
	public $group_id = 0;                    //用户分组id
	
	//网站信息
	public $web_host = "";                   //网站域名
	public $title = "";                      //网站名称
	public $logo = "";                       //网站logo
	public $version = "";                    //域名对应模版编号
	
	//设置信息
	public $setting = null;                  //设置类
	public $third_url = "/";              	 //第三方文件路径
	public $logo_url = "/";                  //logo路径
	
	//其他
	public $operate = array();               //操作类型
	public $ip = "";                         //ip地址
	public $token=null;                      //令牌
	public $sel_agent_id = 0;                //总管理组管理其他代理的数据判断，只有编辑或删除使用
	public $op_agent_id = 0;                 //总管理操作其他代理的被操作代理id
	public $session_time = 24;               //session有效时间,单位小时,n时间内没有活动，删除数据库中session,时间请大于memcache缓存时间;
	public $url = "";                        //当前访问url   
	public $action = "";                     //操作action
	
	private $ci = null;
	private $token_id = null;                //令牌id
	
	public $limit = 1000;                    //分页，每页条数
	public $offset = 0;                      //分页，起始数据

	//构造函数
	function __construct(){
		$this->ci = ci();
		$this->smarty = library("dsmarty","default");
		$this->model = model("dmodel");
		$this->d = library("dmodel");
		$this->init();
	}
	//起始
	function init(){
		$this->d->init($this);
		//日志操作类型
		$this->operate = array("1"=>"登录","2"=>"删除","3"=>"添加","4"=>"修改","5"=>"金额变动","6"=>"非法入侵","7"=>"错误日志","8"=>"管理员操作");
		$this->url = 'http://'.$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
		//操作ip
		$this->ip=$this->ci->input->ip_address();
		//获取令牌id,使用域名md5,只本地cookie使用
		$this->token_id=md5(HOST.KEY);
		//获取令牌
		$this->getToken();
		//若令牌为空侧设置令牌
		$this->setToken();
		//根据域名获取代理信息
		$host = $this->d->host();
		//判断绑定的页面版本,版本不存在404
		if(!isset($host['version']) || empty($host['version'])){
			write_404("版本获取失败,请检查版本设置(".HOST.")");
			show_404();
		}
		foreach ($host as $k=>$v){
			$this->$k=$v;
		}
		//获取配置的信息
		$setting = $this->d->setting();
		//开始检查安全配置
		if(!isset($setting['ip']['ip_admin_whitelist']) || empty($setting['ip']['ip_admin_whitelist']) || !check_ip($this->ip, $setting['ip']['ip_admin_whitelist'])){
			echo "您的IP不在访问列表，请联系客服";
			exit();
		}
		$this->third_url = isset($setting['server']['server_third_url']) && !empty($setting['server']['server_third_url'])?$setting['server']['server_third_url']:"/";
		$this->logo_url = isset($setting['server']['server_logo_url']) && !empty($setting['server']['server_logo_url'])?$setting['server']['server_logo_url']:"/";
		
		//获取sessing表信息
		$session = $this->d->session();
		//登录以后才进行
		if(isset($session['user'])){
			$this->user = $session['user'];
			$this->agent = $session['agent'];
			foreach ($this->agent as $k=>$v){
				$this->$k=$v;
			}
			foreach ($this->user as $k=>$v){
				$this->$k=$v;
			}
			$this->uid = $this->user['id'];
			
			$url1 = $this->ci->uri->segment(1);
			$url2 = $this->ci->uri->segment(2);
			
			//获取被操作人id
			$this->sel_agent_id = $this->agent_id;
			//若是管理权限组，可操作其他代理数据
			if($this->agent_id == $this->default_admin_agent_id){
				$this->op_agent_id = get('op_agent_id');
				if(empty($url1) || $url1=='index'){
					set_cookieI("op_agent_id",$this->op_agent_id);
				}else{
					$this->op_agent_id = get_cookieI("op_agent_id");
				}
				$this->op_agent_id = intval($this->op_agent_id);
				if($this->op_agent_id>0){
					//判断被操作的 代理是否存在
					$_group_list = $this->d->agent_list();
					$_group = array();
					foreach ($_group_list as $v){
						$_group[$v['id']]=$v['username'];
					}
					if(!isset($_group[$this->op_agent_id])){
						skip();
					}
					//转换为当前查询代理id
					$this->sel_agent_id = $this->op_agent_id;
				}
			}
			//获取管理组
			$this->group = $this->d->get_group();
			if(!isset($this->group['id'])){
				write_404("用户组不存在{$this->sel_agent_id}");
				echo "用户组不存在，请联系管理员";
				exit();
			}
			
			//判断权限,获取页面权限
			if(($url1!='ajax' && !in_array($url1, array("index")) && !empty($url1))
					||($url1=='ajax' && !in_array($url2, array("logout","pass")) && !empty($url2))){
				$this->auth();
			}
			//权限整体判断
			if($url1=='ajax' && !in_array($url2, array("logout","pass"))){
				$this->action = get_data("action");
				if($url2=='opmoney'){
					$action = "is_{$this->action}";
					if(!isset($this->$action) || $this->$action!="Y"){
						write_404("{$this->username}({$this->agent_id})无{$this->action}权限");
						show_404();
					}
				}else{
					$this->ajax_auth();
				}
			}
			
			//获取用户访问地址
			if(!in_array($url1, array("index"))){
				$this->d->view();
			}
			
			if(isset($_POST['rows'])){
				$this->limit = intval($_POST['rows']);
				$page = intval($_POST['page']);
				$this->offset = ($page-1)*$this->limit;
			}
		}
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
	//判断ajax权限
	function ajax_auth(){
		switch ($this->action){
			case "del":
				$this->is_auth("del");
				$id = post("id");
				if($id<1)json_error("参数错误");
				break;
			case "save":
				$id= get_data("id");
				if($id<1){
					$this->is_auth("add");
				}else{
					$this->is_auth("edit");
				}
				break;
			case "all":
				$this->is_auth('list');
				break;
			default:
				$this->is_auth('one');
				break;
		}
	}
	//权限初始化
	function auth(){
		if ($this->sel_agent_id == $this->default_admin_agent_id) {//admin帐号拥有超级权限
			$this->is_list = 'Y';
			$this->is_one = 'Y';
			$this->is_add = 'Y';
			$this->is_edit = 'Y';
			$this->is_del = 'Y';
			$this->is_undo = 'Y';
			$this->is_exam = 'Y';
			$this->is_conf = 'Y';
			return true;
		}
		$url1=$this->ci->uri->segment(1);
		$url2=$this->ci->uri->segment(2);
		//冲正负,资金审核,资金确认不判断页面
		if ($url1 == 'ajax' && $url2=='opmoney') {
			$this->is_undo=isset($this->group['menus_undo'])&&$this->group['menus_undo']=='Y'?'Y':'N';
			$this->is_exam=isset($this->group['menus_exam'])&&$this->group['menus_exam']=='Y'?'Y':'N';
			$this->is_conf=isset($this->group['menus_conf'])&&$this->group['menus_conf']=='Y'?'Y':'N';
			return true;
		}
		$url = $url1 =='ajax'?'/'.$url2.'.html':'/'.$url1.'.html';
		$data = $this->model->get($this->model->table_admin_menu," del ='N' and status ='Y' and url like '%{$url}%'");
		$sel = ex($this->group['menus_list']);
		if (!isset($data['id']) || !in_array($data['id'], $sel)) {
			write_404("权限获取失败，访问的链接不在权限表中({$url})");
			show_404();
		}
		$one = ex($this->group['menus_one']);
		$add = ex($this->group['menus_add']);
		$edit = ex($this->group['menus_edit']);
		$del = ex($this->group['menus_del']);
		$this->is_list = 'Y';
		$this->is_one = in_array($data['id'], $one) ? 'Y' : 'N';
		$this->is_add = in_array($data['id'], $add) ? 'Y' : 'N';
		$this->is_edit = in_array($data['id'], $edit) ? 'Y' : 'N';
		$this->is_del = in_array($data['id'], $del) ? 'Y' : 'N';
		$this->is_undo = isset($this->group['menus_undo']) && $this->group['menus_undo'] == 'Y' ? 'Y' : 'N';
		$this->is_exam = isset($this->group['menus_exam']) && $this->group['menus_exam'] == 'Y' ? 'Y' : 'N';
		$this->is_conf = isset($this->group['menus_conf']) && $this->group['menus_conf'] == 'Y' ? 'Y' : 'N';
		//没有查看单个权限，其他权限全否定
		if($this->is_one=='N'){
			$this->is_add = 'N';
			$this->is_edit = 'N';
			$this->is_del = 'N';
		}
	}
	//权限判断
	function is_auth($type) {
		$type = strtolower($type);
		if($this->is_list == 'N'){//没有查看权限，其他权限全部为空
			write_404("用户{$this->username}({$this->uid})没有列表访问权限");
			show_404();
		}
		if(in_array($type, array("add","edit")) && $this->is_one=='N'){
			write_404("用户{$this->username}({$this->uid})权限设置错误，无查看权限，无法添加和编辑");
			show_404();
		}
		if ((($type == "list" && $this->is_list == 'N') || ($type == "one" && $this->is_one == 'N') 
				|| ($type == "add" && $this->is_add == 'N') || ($type == "edit" && $this->is_edit == 'N') 
				|| ($type == "del" && $this->is_del == 'N') || ($type == "undo" && $this->is_undo == 'N'))) {
					write_404("用户{$this->username}({$this->uid})试图非法访问");
					show_404();
				}
	}
	/**
	 * 锁定操作管理,强制锁定，非总管理组不能操作
	 * @param $action 操作类型
	 */
	function lock($action=""){
		if($this->sel_agent_id != $this->default_admin_agent_id){
			$this->d->log("非总管理组操作,强制锁定({$action})", 6);
			write_404("非总管理组操作,强制锁定({$action})");
			show_404();
		}
	}
	//引入smarty模版，带参数
	function display($html, $data = array()) {
		$this->smarty->assign($data);
		$this->smarty->display($this->version.'/html/'.$html.'.html');
	}
	//引入smarty模版参数
	function assign($data){
		$this->smarty->assign($data);
	}
	//直接返回smarty模版数据,带参数
	function fetch($html, $data = array()) {
		$this->smarty->assign($data);
		return $this->smarty->fetch($this->version.'/html/'.$html.'.html');
	}
}