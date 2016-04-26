<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 公共处理方法  2015.07.17
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
if(!function_exists('ci')){
	/**
	 * 获取ci对象
	 */
	function ci(){
		$CI =& get_instance();
		return $CI;
	}
}
if(!function_exists('post')){
	/**
	 * 获取post数据
	 * @param $name 参数
	 */
	function post($name){
		$data = ci()->input->post($name,true);
		$data = trim($data);
		return $data;
	}
}
if(!function_exists('get')){
	/**
	 * 获取get数据
	 * @param $name 参数
	 */
	function get($name){
		$data = ci()->input->get($name,true);
		$data = trim($data);
		return $data;
	}
}
if(!function_exists('get_data')){
	/**
	 * 获取post或get数据
	 * @param $name 参数
	 */
	function get_data($name){
		if(isset($_POST[$name]))return post($name);
		if(isset($_GET[$name]))return get($name);
		return null;
	}
}
if(!function_exists('library')){
	/**
	 * 加载library
	 * @param $library library文件名
	 * @param $file library目录
	 */
	function library($library,$file='model') {
		$ci = ci();
		$library = strtolower($library);
		$path = ucfirst($library);
		if(!empty($file)){
			$path = strtolower($file)."/".$path;
		}
		$ci->load->library($path,$library);
		return $ci->$library;
	}
}
if(!function_exists('model')){
	/**
	 * 加载model
	 * @param $model model文件名
	 */
	function model($model){
		$ci = ci();
		$model = strtolower($model)."_model";
		$ci->load->model($model);
		return $ci->$model;
	}
}
if(!function_exists('ip')){
	/**
	 * 获取ip
	 */
	function ip(){
		if (isset($HTTP_SERVER_VARS["HTTP_X_FORWARDED_FOR"])){
			$ip = $HTTP_SERVER_VARS["HTTP_X_FORWARDED_FOR"];
		}elseif (isset($HTTP_SERVER_VARS["HTTP_CLIENT_IP"])){
			$ip = $HTTP_SERVER_VARS["HTTP_CLIENT_IP"];
		}elseif (isset($HTTP_SERVER_VARS["REMOTE_ADDR"])){
			$ip = $HTTP_SERVER_VARS["REMOTE_ADDR"];
		}elseif (getenv("HTTP_X_FORWARDED_FOR")){
			$ip = getenv("HTTP_X_FORWARDED_FOR");
		}elseif (getenv("HTTP_CLIENT_IP")){
			$ip = getenv("HTTP_CLIENT_IP");
		}elseif (getenv("REMOTE_ADDR")){
			$ip = getenv("REMOTE_ADDR");
		}elseif(isset($_SERVER['REMOTE_ADDR'])){
			$ip = $_SERVER['REMOTE_ADDR'];
		}else{
			$ip = "";
		}
		preg_match("/[\d\.]{7,15}/", $ip, $cips);
		$ip = isset($cips[0]) ? $cips[0] : 'unknown';
		unset($cips);
		return $ip;
	}
}
if(!function_exists('ex')){
	/**
	 * 分割字符串为数组
	 * @param  $data 需要分割的字符串
	 * @param  $l    分割符
	 */
	function ex($data,$l=','){
		if(empty($data))return array();
		$data = explode($l, $data);
		return $data;
	}
}
if(!function_exists('array2sort')){
	/**
	 * 按指定字段排序
	 * @param $data 要排序的数组
	 * @param $sort 要排序的字段
	 * @param $desc 是否倒序
	 */
	function array2sort($data,$sort,$desc=true){
		$info = array();
		$_key = "array2sort_desc_key";
		foreach ($data as $k=>$v){
			$v[$_key]=$k;
			$info[]=$v;
		}
		$num=count($info);
		if(!$desc){
			for($i=0;$i<$num;$i++){
				for($j=0;$j<$num-1;$j++){
					if($info[$j][$sort] > $info[$j+1][$sort]){
						foreach ($info[$j] as $key=>$temp){
							$t=$info[$j+1][$key];
							$info[$j+1][$key]=$info[$j][$key];
							$info[$j][$key]=$t;
						}
					}
				}
			}
		}
		else{
			for($i=0;$i<$num;$i++){
				for($j=0;$j<$num-1;$j++){
					if($info[$j][$sort] < $info[$j+1][$sort]){
						foreach ($info[$j] as $key=>$temp){
							$t=$info[$j+1][$key];
							$info[$j+1][$key]=$info[$j][$key];
							$info[$j][$key]=$t;
						}
					}
				}
			}
		}
		$data = array();
		foreach ($info as $v){
			$data[$v[$_key]]=$v;
			unset($data[$v[$_key]][$_key]);
		}
		return $data;
	}
}
if(!function_exists('merge')){
	/**
	 * 合并两个数组
	 * @param  $one
	 * @param  $two
	 */
	function merge($one,$two){
		if(empty($one) || count($one)<1)return $two;
		if(empty($two) || count($two)<1)return $one;
		$info = array();
		$i = 0;
		foreach ($one as $v){
			$info[$i]=$v;
			$i++;
		}
		foreach ($two as $v){
			$info[$i]=$v;
			$i++;
		}
		return $info;
	}
}
if(!function_exists('json_error')){
	/**
	 * 失败
	 * @param $data 参数
	 * @param $msg 提示
	 */
	function json_error($msg="error",$data=array()){
		$data=array("result"=>false,"msg"=>$msg,"data"=>$data);
		echo json_encode($data);
		exit();
	}
}
if(!function_exists('json_ok')){
	/**
	 * 成功
	 * @param $data 参数
	 * @param $msg 提示
	 */
	function json_ok($data=array(),$msg="success"){
		$data=array("result"=>true,"msg"=>$msg,"data"=>$data);
		echo json_encode($data);
		exit();
	}
}
if(!function_exists('skip')){
	/**
	 * 跳转
	 * @param $url
	 * @param $param
	 */
	function skip($url="/",$message=""){
		$message = empty($message)?"":"alert('{$message}');";
		$url = url($url);
		$skip = '页面跳转中...若没跳转，请<a href="'.$url.'">点击这里</a><script>window.location= "'.$url.'";'.$message.'</script>';
		echo $skip;
		exit();
	}
}
if(!function_exists('url')){
	/**
	 * 生成url
	 * @param $url
	 * @param $param
	 */
	function url($url,$param=null){
		if(is_array($param)){
			$str = "";
			foreach ($param as $k=>$v){
				$str .= "&{$k}={$v}";
			}
			$param = ltrim($str,'&');
		}
		$param = empty($param)?"":"?".$param;
		$url = ($url=="/" || empty($url))?"/":$url.".html";
		$url = $url.$param;
		return $url;
	}
}
if(!function_exists('ex_string')){
	/**
	 * 截取字符串为数组
	 * @param $string  字符串  
	 * @param $delimiter  截取的符号
	 */
	function ex_string($string,$delimiter){
		$str = explode($delimiter, $string);
		$len = count($str);
		if(empty($str[$len-1]) && $len-1>0){
			unset($str[$len-1]);
		}
		return $str;
	}
}
if(!function_exists('check_ip')){
	/**
	 * 检查ip
	 * @param $ip     要检测的ip
	 * @param $data   ip库
	 */
	function check_ip($ip,$data){
		return preg_match("/^(".str_replace(array(",", ' '), array('|', ''), preg_quote($data, '/')).")/", $ip);
	}
}
if(!function_exists('get_rand')){
	/**
	 * 创建随机字符
	 * @param  $len 长度
	 * @param  $title 首字符
	 * @param  $istoupper 是否大写
	 */
	function get_rand($len,$title='',$istoupper=false){
		$rand = get_rand_chr(18).microtime().get_rand_num(18);
		$rand = get_rand_chr(32,1).md5($rand).get_rand_num(32);
		$rand = str_shuffle($rand);
		$max = strlen($rand)-$len;
		$min = $max-rand(1, $max);
		$rand = $title.substr($rand,$min,$len);
		if($istoupper)$rand=strtoupper($rand);
		return $rand;
	}
}
if(!function_exists('get_rand_num')){
	/**
	 * 创建随机数字串
	 * @param $len 长度
	 */
	function get_rand_num($len){
		$a = mt_rand(100000000,999999999);
		$b = mt_rand(100000000,999999999);
		$c = mt_rand(100000000,999999999);
		$d = mt_rand(100000000,999999999);
		$e = mt_rand(100000000,999999999);
		$f = mt_rand(1,9);
		$rand = $a.$b.$c.$d.$e;
		$rand = str_shuffle($rand);
		$max = strlen($rand)-$len;
		$min = $max-rand(1, $max);
		$rand = $f.substr($rand,$min,$len-1);
		return $rand;
	}
}
if(!function_exists('get_rand_chr')){
	/**
	 * 创建随机字符串
	 * @param  $len 长度
	 * @param  $min 0大小写混合，1全小写，2全大写
	 */
	function get_rand_chr($len,$min=0){
		$rand = array_merge(range('a','z'),range('A','Z'));
		shuffle($rand);
		$rand = implode('',array_slice($rand,0,$len));
		if($min==1)$rand=strtolower($rand); //全部小写
		if($min==2)$rand=strtoupper($rand); //全部大写
		return $rand;
	}
}
if(!function_exists('set_user_pass')){
	/**
	 * 设置用户的密码
	 * @param $username  用户名
	 * @param $password  密码
	 */
	function set_user_pass($username,$password){
		$password = strtolower($username).'|'.strtolower($password);
		$password = md5($password);
		$password = strtolower($password);
		return $password;
	}
}
if(!function_exists('safe_sql')){
	/**
	 * 安全检查sql语句
	 * @param $data  要检查的数据
	 */
	function safe_sql($data,$need="[被屏蔽的字符]"){
		if(is_array($data)){
			$info = array();
			foreach ($data as $k=>$v){
				$k = safe_sql($k);
				$info[$k]=safe_sql($v);
			}
			return $info;
		}
		$sql = array("select","delete","insert","update","union","into","load_file","outfile");
		foreach ($sql as $v){
			$v = " {$v} ";
			$data = str_replace($v,$need,$data);
		}
		return $data;
	}
}
if(!function_exists('color')){
	/**
	 * 设置字体颜色
	 * @param $data 需要设置的文字
	 * @param $color 颜色css
	 */
	function color($data,$color='red'){
		$html = "<span class='{$color}'>{$data}</span>";
		return $html;
	}
}
if(!function_exists('check_email')){
	/**
	 * 检查email
	 * @param $email
	 */
	function check_email($email){
		if(!preg_match("/^([0-9A-Za-z\\-_\\.]+)@([0-9a-z]+\\.[a-z]{2,3}(\\.[a-z]{2})?)$/i",$email)){
			return false;
		}
		return true;
	}
}