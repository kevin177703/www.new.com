<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 文件上传接收
 * @author Administrator
 *
 */
class Upload extends CI_Controller {
	public function index(){
		$this->load->view('welcome_message');
	}
}