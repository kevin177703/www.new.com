<?php if(! defined ('BASEPATH'))exit('No direct script access allowed');
require_once ROOT.'application/third_party/smarty/Smarty.class.php';
class Dsmarty extends Smarty {
	function __construct() {
		parent::__construct ();
		$this->left_delimiter = '{{';
		$this->right_delimiter = "}}";
		$this->template_dir = PUB;
		$this->compile_dir = DATA.'/smarty/templates_c';
		$this->cache_dir = DATA.'smarty/cache';
		$this->caching = false;
		if(!file_exists($this->compile_dir))mk_dir($this->compile_dir);
		if(!file_exists($this->cache_dir))mk_dir($this->cache_dir);
	}
	// assign($key,$value=null)
	// display($html)
}