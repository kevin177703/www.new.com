var ck_html = 	'<div class="botton_clear"></div>'+
				'<div class="bottom" id="bt_xx3659_1">'+
				'	<a href="javascript(0);" class="bottom_close" title="关闭"><img src="images/index/close.png"></a>'+
				'	<div class="w990" id="cklogin">'+
				'		<div class="login"> <form id="loginform" action="#" method="POST">'+
				'			<input type="text" name="u" id="username" style="width:155px; padding-left:10px; border-style:none;" value="用户名" onfocus="if(this.value==\'用户名\'){this.value=\'\';}"  onblur="if(this.value==\'\'){this.value=\'用户名\';}" />'+
	        	'			<input type="text" style="width:155px; margin-left:20px; border-style:none; " value="&nbsp;密码" onfocus="$(this).hide();$(\'#password\').show();$(\'#password\').focus();" />'+
				'			<input type="password" name="p" id="password" style="width:155px; margin-left:20px;display: none; border-style:none;" value="" onfocus="if(this.value==\'******\'){this.value=\'\';}"  onblur="if(this.value==\'\'){this.value=\'******\';}" />'+
				'			<input type="text" name="c" id="vcode"  style="width:50px; margin-left:20px;border-style:none;" value="验证码" onfocus="if(this.value==\'验证码\'){this.value=\'\';}"  onblur="if(this.value==\'\'){this.value=\'验证码\';}" />'+
				'			<img id="imgcode" src="" style="width: 45px;height: 23px;margin-left:20px; float:left;display: none;cursor:pointer;" onclick="RefreshCode(this);">'+
				'			 <input id="cksubmit" type="submit"  style="background:url(images/loginbt.png) no-repeat; width:64px; height:25px; margin-left:10px;cursor:pointer;" value=""/>'+
				'		</form></div>'+
				'		<div class="bright"><a href="Reg.html"><img src="images/kaihu.png"></a> <a href="javascript:showTry();"><img src="images/shiwan.png"></a></div>'+
				'    </div>'+
				'</div>';

document.write(ck_html);

$(function(){
	
	$("a.bottom_close").click(function(){
		$(this).parent().hide();
		$(".botton_clear").hide();
		return false;
	});


	//绑定验证码焦点事件
	$("#vcode").focus(function(){
		  $("#imgcode").attr("src","/index/loginimg/?"+Math.random());
		  $("#imgcode").show();
	});

	//提交登陆表单
	$('#loginform').submit(function(){
			var check_user = true;
		var username_str = $('#username').val();
			var check_pass = true;
		var password_str = $('#password').val();
			var check_code = true;
		var code_str = $('#vcode').val();
			var check_d = true;
		
			if (username_str=='用户名' || isEmptyVal(username_str)) check_user = false;
			if (password_str=='******' || isEmptyVal(password_str)) check_pass = false;
			if (code_str=='验证码' || isEmptyVal(code_str)) check_code = false;
			
		if (check_user == false || check_pass == false || check_code == false){
			if (check_user == false) {
				msg_box_show('请输入您的用户名',5,'','warning','username');
				return false;
			}else if (check_pass == false) {
				msg_box_show('请输入您的密码',5,'','warning','password');
				return false;
			}else if (check_code == false) {
				msg_box_show('请输入验证码',5,'','warning','vcode');
				return false;
			}
			
		}else{

			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "index/login",   
			              data: "c="+code_str+"&u="+username_str+"&p="+password_str,   
			              dataType:'json',   
			              async: false, 
			              beforeSend:function(){   
								showloading();    
			               },
											    
			              complete: function() {   
			                   $.unblockUI();   
			               } ,   
			               success: function(data){ 
											  
							//开始处理
							if(data.code == 1){
								//登陆成功,刷新当前页面	
								msg_box_show('登陆成功,3秒后将进入会员中心!',3,'member/index','succeed');
								return false;
								
							} else if(data.code == -2){
							
								//验证码错误
								$("#vcode").val('');
								msg_box_show(data.msg,8,'','error','vcode');
								return false;
								

							}else{
								msg_box_show(data.msg,8,'','error','username');
								
								return false;
								
							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束
			
		}
		
		return false;
		
	});
	
	
	
	
	//开始检测当前用户是否已经登陆或者试玩
	
	$.getJSON("index/islogin",function(data){
		
		if(data.code == 1){
			
			//正式用户已登陆
			
			var login_lines = 	'<div class="login">'+
								'<div class="wenzi">账号：<span>'+data.msg+'</span>　　　　电子钱包余额：<span id="money">查询中</span>　　　锁定余额：<span id="lockmoney">查询中</span>　　　<a href="member/dpay">存款</a>&nbsp;|&nbsp;<a href="member/onlineget">取款</a>&nbsp;&nbsp;</div>'+
						        '<input type="submit"  style="background:url(images/exit.png) no-repeat; width:64px; height:25px; float:right; margin-right:10px;cursor:pointer;" value="" onclick="Userlogout();" />'+
								'</div>'+
    							'<div class="bright">'+
    							'<a href="member/index"><img src="images/member.png"></a> <a href="game/play@gid=4" target="_blank"><img src="images/jinru.png"></a>'+
    							'</div>';

    		$("#bt_xx3659_1").css("backgroundImage","url(images/bottombglogin.png)"); ;
    		$("#cklogin").empty().html(login_lines);

			//开始获取余额等
			
			getmoney();

		}else if(data.code == 2){
			
			//试玩用户
			
			var logins_lines = 	'<div class="login">'+
								'<div class="wenzi">账号：<span>游客</span>　　　　电子钱包余额：<span id="money">1000</span>　　　锁定余额：<span id="lockmoney">0.00</span>　　　<a href="member/dpay">存款</a>&nbsp;|&nbsp;<a href="member/onlineget">取款</a>&nbsp;&nbsp;</div>'+
						        '<input type="submit"  style="background:url(images/exit.png) no-repeat; width:64px; height:25px; float:right; margin-right:10px;cursor:pointer;" value="" onclick="Userlogout();" />'+
								'</div>'+
    							'<div class="bright">'+
    							'<a href="reg.html"><img src="images/kaihu.png"></a> <a href="game/play@gid=4" target="_blank"><img src="images/jinru.png"></a>'+
    							'</div>';

    		$("#bt_xx3659_1").css("backgroundImage","url(images/bottombglogin.png)"); ;
    		$("#cklogin").empty().html(logins_lines);
			
		}
			
	});
	

});


document.writeln("<!-- Live800默认跟踪代码: 开始-->");
document.writeln("<script language=\"javascript\" src=\"http://chat7.livechatvalue.com/chat/chatClient/monitor.js?jid=2168602248&companyID=350839&configID=42929&codeType=custom\"></script>");
document.writeln("<!-- Live800默认跟踪代码: 结束-->");


document.writeln("<div style=\"display: none;\">");
document.writeln("<script type=\"text/javascript\">var cnzz_protocol = ((\"https:\" == document.location.protocol) ? \" https://\" : \" http://\");document.write(unescape(\"%3Cspan id=\'cnzz_stat_icon_1000289920\'%3E%3C/span%3E%3Cscript src=\'\" + cnzz_protocol + \"s23.cnzz.com/z_stat.php%3Fid%3D1000289920\' type=\'text/javascript\'%3E%3C/script%3E\"));</script>");
document.writeln("</div>");


