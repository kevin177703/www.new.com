<?php defined('BASEPATH') OR exit('No direct script access allowed');
/**
 * 文件处理方法  2015.07.17
 * @version 1.0.0
 * @author kevin177703@gmail.com 
 */
if(!function_exists('set_md5')){
	/**
	 * 设置md5
	 * @param string $value 需要md5的数据
	 * @param string $is_name  是否是name值
	 * @param string $key  md5加密密钥
	 * @param string $is_ip  是否启用ip加密
	 * @return string
	 */
	function set_md5($value,$is_name=false,$is_ip=true){
		$ip = $is_ip?ip():"";
		$md5 = md5($value.$ip.KEY.HOST);
		$md5 = $is_name?substr($md5,11,20):substr($md5,2,23);
		return strtoupper($md5);
	}
}
if(!function_exists('set_cookieI')){
	/**
	 * 设置cookie
	 * @param $name key
	 * @param $value value
	 * @param $expire 时间，默认浏览器时间
	 */
	function set_cookieI($name,$value,$expire=0){
		setcookie($name,$value,$expire,'/');
		$value = set_md5($value.$name);
		$name = set_md5($name,true);
		setcookie($name,$value,$expire,'/');
	}
}
if(!function_exists('get_cookieI')){
	/**
	 * 获取cookie
	 * @param $name key
	 */
	function get_cookieI($name){
		$value = isset($_COOKIE[$name])?$_COOKIE[$name]:null;
		if(empty($value))return $value;
		$_name = set_md5($name,true);
		$_value = isset($_COOKIE[$_name])?$_COOKIE[$_name]:null;
		if($_value==set_md5($value.$name)){
			return $value;
		}
		return null;
	}
}
if(!function_exists('del_cookieI')){
	/**
	 * 删除cookie
	 * @param $name key
	 */
	function del_cookieI($name){
		$_name = set_md5($name,true);
		$time = time()-100;
		setcookie($name,null,$time,'/');
		setcookie($_name,null,$time,'/');
	}
}
if(!function_exists('del_all_cookie')){
	/**
	 * 删除所有的cookie
	 */
	function del_all_cookie(){
		if(!is_array($_COOKIE) || count($_COOKIE)<1)return false;
		$time = time()-100;
		foreach ($_COOKIE as $k=>$v){
			setcookie($k,null,$time,'/');
		}
	}
}
if(!function_exists('mk_dir')){
	/**
	 * 创建目录
	 * @param $path 写入地址
	 * @param $is_file 是否有文件
	 */
	function mk_dir($path,$is_file=false){
		$path = str_replace('\\','/',$path);
		$info = explode('/', $path);
		$_path = '';
		$len = count($info);
		for($i=0;$i<$len;$i++){
			$_path .= $info[$i];
			if($i==$len-1 && $is_file)continue;
			$_path .= '/';
			if(file_exists($_path))continue;
			@chmod($_path, 0777);
			@mkdir($_path);
			//每层添加index.html,防止目录读取
			if(!file_exists($_path.'index.html')){
				$content = '<!DOCTYPE html><html><head><title>403 Forbidden</title><meta charset="UTF-8">'
						.'</head><body><h1>Directory access is forbidden.</h1></body></html>';
				write($_path.'index.html',$content,'w+');
			}
		}
	}
}
if(!function_exists('del_dir')){
	/**
	 * 删除目录下的文件
	 * @param $path 写入地址
	 * @param $time 保留时长文件,默认一分钟
	 */
	function del_dir($path,$time=60) {
		$dh=opendir($path);
		while ($file=readdir($dh)) {
			if($file!="." && $file!="..") {
				$fullpath=$path."/".$file;
				if(!is_dir($fullpath)){
					if(filemtime($fullpath)>time()-$time)continue;
					unlink($fullpath);
				}else{
					del_dir($fullpath);
				}
			}
		}
		closedir($dh);
	}
	
}
if(!function_exists('write_cache')){
	/**
	 * 写缓存,缓存时间1个小时
	 * @param $data 缓存数组
	 * @param $title 缓存名称
	 * @param $edit 是否强制写入
	 */
	function write_cache($data,$title,$edit=false){
		$path = DATA.'cache/'.$title.'.txt';
		if($edit || file_exists($path) || filemtime($path)<time()-3600){
			$data = json_encode($data);
			write($path, $data,'w+');
		}
	}
}
if(!function_exists('read_cache')){
	/**
	 * 读取缓存
	 * @param $title 缓存名称
	 */
	function read_ache($title){
		$path = DATA.'cache/'.$title.'.txt';
		$data = read($path);
		$data = json_decode($data);
		return $data;
	}
}
if(!function_exists('write_log')){
	/**
	 * 写日志
	 * @param $content 内容
	 */
	function write_log($content){
		$h = date('H');
		$h = ceil($h/3);
		$path = DATA.'log/'.date('Y-m-d').'_'.$h.'.php';
		$info = "";
		if(!file_exists($path)){
			$info = "<?php exit('No direct script access allowed');\r\n";
		}
		$info .= "[".date('H:i:s')."]".$content."\r\n";
		write($path, $info);
	}
}
if(!function_exists('write_404')){
	/**
	 * 写404日志
	 * @param $content 内容
	 */
	function write_404($content){
		$path = DATA.'404/'.date('Y-m-d').'.php';
		$info = "";
		if(!file_exists($path)){
			$info = "<?php exit('No direct script access allowed');\r\n";
		}
		$info .= "[".date('H:i:s')."]".$content."\r\n";
		write($path, $info);
	}
}
if(!function_exists('write_sql')){
	/**
	 * 写sql,3小时轮换一个文件，防止文件太大
	 * @param $sql语句
	 */
	function write_sql($sql){
		$h = date('H');
		$h = ceil($h/3);
		$path = DATA.'sql/'.date('Y-m-d').'_'.$h.'.php';
		$info = "";
		if(!file_exists($path)){
			$info = "<?php exit('No direct script access allowed');\r\n";
		}
		$info .= "[".date('H:i:s')."]".$sql."\r\n";
		write($path, $info);
	}
}
if(!function_exists('write_error')){
	/**
	 * 记录curl请求
	 * @param $content 内容
	 */
	function write_error($content){
		$h = date('H');
		$h = ceil($h/3);
		$path = DATA.'error/'.date('Y-m-d').'_'.$h.'.php';
		$info = "";
		if(!file_exists($path)){
			$info = "<?php exit('No direct script access allowed');\r\n";
		}
		$info .= "[".date('H:i:s')."]".$content."\r\n";
		write($path, $info);
	}
}
if(!function_exists('write_x')){
	/**
	 * 记录自定义数据
	 * @param $content 内容
	 * @param $x 自定义类型
	 */
	function write_x($content,$x){
		$path = DATA.$x.'/'.date('Y-m-d').'.php';
		$info = "";
		if(!file_exists($path)){
			$info = "<?php exit('No direct script access allowed');\r\n";
		}
		$info .= "[".date('H:i:s')."]".$content."\r\n";
		write($path, $info);
	}
}
if(!function_exists('write')){
	/**
	 * 文件写入
	 * @param $path  文件路径
	 * @param $data  文件内容
	 * @param $mode  写入方式
	 */
	function write($path,$data,$mode="a+"){
		mk_dir($path,true);
		if ( ! $fp = @fopen($path, $mode)){
			return FALSE;
		}
		@flock($fp, LOCK_EX);
		@fwrite($fp, $data);
		@flock($fp, LOCK_UN);
		@fclose($fp);
		return TRUE;
	}
}
if(!function_exists('read')){
	/**
	 * 读取文件
	 * @param  $file 文件路径
	 */
	function read($file){
		if ( ! file_exists($file)){
			return FALSE;
		}
		if (function_exists('file_get_contents')){
			return file_get_contents($file);
		}
		if ( ! $fp = @fopen($file, FOPEN_READ)){
			return FALSE;
		}
		flock($fp, LOCK_SH);
		$data = '';
		if (filesize($file) > 0){
			$data =& fread($fp, filesize($file));
		}
		flock($fp, LOCK_UN);
		fclose($fp);
		return $data;
	}
}