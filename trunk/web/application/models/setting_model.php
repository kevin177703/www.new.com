<?php if(!defined('BASEPATH')) exit('No direct script access allowed');
/**
 * 配置类 2015.07.27
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
class Setting_model extends Base_Model{
	function __construct(){
		parent::__construct();
	}
	//编辑setting表
	function setting_edit($data,$type,$agent_id){
		$this->db->trans_begin();
		$info = array();
		$i=0;
		foreach ($data as $k=>$v){
			$info[$i]['skey']=$k;
			$info[$i]['svalue']=$v;
			$info[$i]['type']=$type;
			$info[$i]['agent_id']=$agent_id;
			$i++;
		}
		if($this->db->delete($this->table_setting,array('type'=>$type,'agent_id'=>$agent_id))==false 
				|| $this->db->insert_batch($this->table_setting,$info)==false){
			$this->db->trans_rollback();
			return false;
		}
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			return false;
		}
		$this->db->trans_commit();
		return true;
	}
	//获取setting数据
	function setting_get($type=null){
		if(!empty($type))$this->db->where("type",$type);
		$query = $this->db->get($this->table_setting);
		$info = array ();
		if($query->num_rows ()>0){
			$data = $query->result_array();
			foreach ( $data as $k => $v) {
				$info [$v ['kvkey']] = $v;
			}
		}
		return $info;
	}
}