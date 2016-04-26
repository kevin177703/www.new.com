<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * Base_Model  2015.07.27
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
/**
 * 实现代码提示功能
 * @property CI_Loader $load
 * @property CI_DB_mysql_driver $db
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
 * @property Dmemcache $memcache
 */
class Base_Model extends CI_Model {
	public $openNo = null;          //数据库操作编号
	public $memcache = null;        //memcache

	public $table_money_note = "money_note";                //资金记录表
	public $table_money_type = "money_type";                //资金类型表
	public $table_money_bank = "money_bank";                //银行卡
	public $table_money_status = "money_status";        	//资金状态
	public $table_money_third = "money_third";        		//第三方支付
	public $table_money_log = "money_log";                  //资金日志
	
	public $table_pay_setting = "pay_online";               //在线支付取款设置表
	public $table_pay_list = "pay_list";                    //支付取款记录表
	public $table_pay_bank = "pay_bank";                    //银行转账设置表
	
	public $table_session = "session";                      //session记录
	
	public $table_agent = "agent";                          //总代关系表
	public $table_agent_host = "agent_host";                //网站域名 -主域名
	public $table_agent_version = "agent_version";          //网站版本号
	public $table_agent_host_more = "agent_host_more";      //网站域名列表-分域名
	public $table_agent_extend = "agent_extend";            //代理设置的游戏推广
	
	public $table_admin = "admin";                          //用户表
	public $table_admin_group = "admin_group";              //用户组
	public $table_admin_menu = "admin_menu";                //菜单
	public $table_admin_log = "admin_log";                  //管理日志
	public $table_admin_view = "admin_view";                //用户浏览记录
	 
	public $table_users = "users";                          //用户表
	public $table_users_same_ip = "users_same_ip";          //用户ip记录表
	public $table_users_same_pc = "users_same_pc";          //用户电脑记录表
	public $table_users_group = "users_group";              //用户级别表
	public $table_users_log = "users_log";                  //用户日志表
	public $table_users_bank = "users_bank";                //用户开户银行
	public $table_users_banktype = "users_banktype";        //会员银行类别
	                                                   
	public $table_setting = "setting";                      //设置
	
	public $table_game_type = "game_type";                  //游戏类型
	
	public $table_only_no = "only_no";                      //编号唯一表
	
	public $table_message_notice = "message_notice";        //信息公告表
	public $table_message_type = "message_type";            //信息类型
	
	
	function __construct() {
		parent::__construct ();
		$this->load->database ();
		$this->memcache = library('dmemcache','default');
		$this->openNo = get_rand(18);
	}
	// 获取带前缀的表名
	function table($table) {
		return $this->db->protect_identifiers($table,TRUE);
	}
	//获取数据总条数
	function total($table,$where = array()){
		if(is_array($where)){
			$where['del']='N';
		}
		$query = $this->db->get_where($table,$where);
		$total = $query->num_rows();
		$this->last_sql();
		return $total;
	}
	//获取数据总条数-sql
	function total_sql($sql){
		$query = $this->db->query($sql);
		$total = $query->num_rows();
		$this->last_sql();
		return $total;
	}
	//sql查询
	function query($sql, $limit, $offset = 0,$order="") {
		$data = array('total'=>0,'rows'=>array());
		$data['total'] = $this->total_sql($sql);
		if ($data['total']<1){
			return $data;
		}
		if(!empty($order))$order = " order by {$order} desc";
		$sql .=" {$order} limit {$offset},{$limit}";
		$query=$this->db->query($sql);
		$data['rows']=$query->result_array();
		$this->last_sql();
		return $data;
	}
	// 获取一条数据的sql查询
	function one($sql) {
		$query = $this->db->query($sql);
		$info = array();
		if ($query->num_rows()> 0) {
			$info = $query->row_array();
		}
		$this->last_sql();
		return $info;
	}
	//保存批量数据
	function insert($table,$data){
		$bol = $this->db->insert_batch($table,$data);
		$this->last_sql();
		return $bol;
	}
	//保存数据
	function save($table, $data) {
		$id = 0;
		if ($this->db->insert($table,$data)) {
			$id = $this->db->insert_id();
		}
		$this->last_sql();
		return $id;
	}
	//修改
	function edit($table, $data, $where) {
		$bol = $this->db->update($table, $data, $where);
		$this->last_sql();
		return $bol;
	}
	//删除
	function del($table, $where) {
		$bol = $this->db->update($table,array('del'=>'Y'),$where);
		$this->last_sql();
		return $bol;
	}
	//真实删除
	function tdel($table, $where) {
		$bol = $this->db->delete($table, $where);
		$this->last_sql();
		return $bol;
	}
	//清空
	function del_all($table) {
		$bol = $this->db->empty_table($table);
		$this->last_sql();
		return $bol;
	}
	//查询单条数据
	function get($table, $where,$select="*") {
		if(is_array($where))$where['del']='N';
		$this->db->select($select);
		$query = $this->db->get_where($table,$where);
		$info = array();
		if($query->num_rows()> 0) {
			$info = $query->row_array();
		}
		$this->last_sql();
		return $info;
	}
	//列表
	function get_list($table, $where, $limit, $offset = 0, $order = array()) {
		if(is_array($where)){
			$where['del']='N';
		}
		$data = array('total'=>0,'rows'=>array());
		$data['total'] = $this->total($table,$where);
		if($data['total']<1){
			return $data;
		}
		if(isset($order[0]) && !empty($order[0])){
			$order[1]= isset($order[1])?$order[1]:'desc';
			$this->db->order_by($order[0],$order[1]);
		}
		$query = $this->db->get_where($table,$where,$limit,$offset );
		$data['rows']=$query->result_array();
		$this->last_sql();
		return $data;
	}
	//自定义操作
	function db() {
		return $this->db;
	}
	//获取sql语句
	function last_sql(){
		$sql = $this->db->last_query();
		$sql = str_replace("\n"," ",$sql);
		write_sql("[".$this->openNo."]".$sql);
		return $sql;
	}
}