<?php defined('BASEPATH') OR exit('No direct script access allowed');
$config = array();
/**
 * 常量配置
 */
//第三方支付
define("MONEY_THIRD_YEEPAY", "1");              //易宝支付

//资金状态
define("MONEY_STATUS_SUCCESS", "1");            //已完成
define("MONEY_STATUS_REJECT", "2");             //已拒绝
define("MONEY_STATUS_ING", "3");             	//处理中
define("MONEY_STATUS_EXAM", "4");             	//审核中
define("MONEY_STATUS_CONFIRM", "5");            //确认中
define("MONEY_STATUS_EXPIRE", "6");             //已过期

//设置资金类型常量
define("MONEY_TYPE_DRAW","1");					//取款
define("MONEY_TYPE_BANK","2");					//银行转账
define("MONEY_TYPE_UNDO","3");					//冲正负
define("MONEY_TYPE_FIRST","4");					//首存
define("MONEY_TYPE_FIRST_BONUS","5");			//首存红利
define("MONEY_TYPE_BANK_BONUS","6");			//银行转账手续费
define("MONEY_TYPE_YEEPAY","7");				//易宝支付
define("MONEY_TYPE_IPS","8");					//宝付支付

//设置信息类型常量
define("MESSAGE_TYPE_SMS",1);					//短信验证
define("MESSAGE_TYPE_DEPOSIT",2);				//存款到账
define("MESSAGE_TYPE_DEPOSIT_DOWN",3);			//存款拒绝
define("MESSAGE_TYPE_DRAW",4);					//取款到账
define("MESSAGE_TYPE_DRAW_DOWN",5);				//取款拒绝
define("MESSAGE_TYPE_PASS_LOGIN",6);			//登录密码更改
define("MESSAGE_TYPE_PASS_PAY",7);				//取款密码更改
define("MESSAGE_TYPE_PASS_LOGIN_FIND",8);		//登录密码找回
define("MESSAGE_TYPE_BANK_BONUS",9);			//银行转账手续费
define("MESSAGE_TYPE_UNDO",10);					//冲正负
define("MESSAGE_TYPE_FIRST_BONUS",11);			//首存红利
define("MESSAGE_TYPE_VIP",12);					//会员升级
define("MESSAGE_TYPE_BONUS",13);				//洗码发放