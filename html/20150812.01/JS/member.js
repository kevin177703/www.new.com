//会员心JS

//展开左侧菜单 0/1/2
function switchM(tabs_i,li_id){
	if(isEmptyVal(tabs_i)) tabs_i=0;
	$('.vcon').slideUp().eq(tabs_i).slideDown();
	if(!isEmptyVal(li_id)){
		$('.vconlist li'). removeClass('on');
		$('#'+li_id).addClass('on');
	}
}




//手工存款提交
function hPaySubmit(){
	
	var nMoney = $("#nmoney").val();
	var nBankid = parseInt($("#bankid").val());
	var strBankname = $("#bankname").val();
	var strBankcard = $("#bankcard").val();
	var strBankowner = $("#bankowner").val();
	var strBanktype = $("#banktype").val();
	var strCardtime = $("#cardtime").val();
	var strRemarks = $("#remarks").val();
	var strRemarks = $("#aemarks").val();

	if(isEmptyVal(nMoney)) {
		msg_box_show('存款金额不能为空!',5,'','warning','nmoney');
		return;
	}
	
	if(nMoney < 100){
			$("#nmoney").val("");
			msg_box_show('银行转账必须100元起!',5,'','warning','nmoney');
			return;
	}
	
	if(isEmptyVal(nBankid) || nBankid==0){ 
			msg_box_show('请选择收款人信息!',5,'','warning',''); 
			return;
	}

	if(isEmptyVal(strBankname)){
			msg_box_show('请选择您银行卡所属银行!',5,'','warning',''); 
			return;
	}	
	
	if(isEmptyVal(strBankcard)){
			msg_box_show('请输入您好转帐的卡号!',5,'','warning','bankcard');
			return;
	}
	
	if(isEmptyVal(strBankowner)){
			msg_box_show('请输入持卡人姓名!',5,'','warning','bankowner');
			return;
	}	

	if(isEmptyVal(strBanktype)){
			msg_box_show('请选择付款方式!',5,'','warning','');
			return;
	}
	
	
	if(isEmptyVal(strCardtime)){
			msg_box_show('请输入正确的存款时间，以便我们能快速核对您的存款信息!',5,'','warning','');
			return;
	}
	
	
	if(isEmptyVal(strRemarks) || strRemarks=='注明您的存款地点,存款时间,存款方式'){
		
			msg_box_show('请在备注信息上简单注明您的存款地点,存款时间,存款方式，以便我们能快速核对您的存款信息!',5,'','warning','');
			return;
	}	

			//开始提交表单
			
				   $.ajax({   
			              type: "POST",   
			              url: "/member/handsavemoney",   
			              data: "bankid="+nBankid+"&bankname="+strBankname+"&banktype="+strBanktype+"&bankcard="+strBankcard+"&bankowner="+strBankowner+"&nmoney="+nMoney+"&cardtime="+strCardtime+"&remarks="+strRemarks,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('提交成功,请稍候查询订单审核状态!',5,'/member/k2','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','warning');
							
							}else if(data.code == -6){
							
								msg_box_show('您还有未处理的存款申请订单，请等待财务处理后再提交新订单!',5,'/member/k2','warning');

							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}


//银行资料绑定提交
function ubankSubmit(){
	
	var strBanktype = $("#banktype2").val();
	var strBankcard = $("#cardnum").val();
	var strBankowner = $("#cardowner").val();
	var strProvince = $("#selProvince").val();
	var strCity = $("#selCity").val();
	
	if(strBanktype == '请选择') {
		msg_box_show('请选择您银行卡的开户银行!',5,'','warning','');
		return;
	}
	
	if(isEmptyVal(strBankcard)){ 
			msg_box_show('请输入银行帐号!',5,'','warning','cardnum'); 
			return;
	}

	if(isEmptyVal(strBankowner)){
			msg_box_show('请输入持卡人姓名!',5,'','warning','cardowner'); 
			return;
	}	
	
	if(strProvince == '请选择省份'){
			msg_box_show('请选择你帐号的开户省份!',5,'','warning','');
			return;
	}
	
	if(isEmptyVal(strCity)){
			msg_box_show('请选择开户城市!',5,'','warning','');
			return;
	}	


			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/bindbank",   
			              data: "cardowner="+strBankowner+"&banktype2="+strBanktype+"&cardnum="+strBankcard+"&selProvince="+strProvince+"&selCity="+strCity,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('绑定成功!',5,'/member/onlineget','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}


//支付密码提交
function uPayPwdSubmit(){
	
	var strPaypwd = $("#paypwd").val();
	var strPaypwd1 = $("#paypwd1").val();
	var strPaypwd2 = $("#paypwd2").val();
	
	if(isEmptyVal(strPaypwd1)){ 
			msg_box_show('请输入新密码!',5,'','warning','paypwd1'); 
			return;
	}

	if(isEmptyVal(strPaypwd2)){ 
			msg_box_show('请再次输入新密码!',5,'','warning','paypwd2'); 
			return;
	}


	if(strPaypwd1 != strPaypwd2){ 
			$("#paypwd1").val('');
			$("#paypwd2").val('');
			msg_box_show('两次输入的新密码不一致,请重新输入!',5,'','warning','paypwd1'); 
			return;
	}



			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/chpaypwd",   
			              data: "paypwd="+strPaypwd+"&paypwd1="+strPaypwd1+"&paypwd2="+strPaypwd2,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('修改成功!',5,'/member/onlineget','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}



//在线取款提交
function uGetSubmit(){
	
	var strMoney = $("#nmoney").val();
	var strPaypwd = $("#paypwd").val();
	var strRemarks = $("#remarks").val();
	
	if(isEmptyVal(strMoney)) {
		msg_box_show('金额不能为空!',5,'','warning','nmoney');
		return;
	}
	
	if(strMoney < 100){
			$("#nmoney").val("");
			msg_box_show('取款必须一百元起!',5,'','warning','nmoney');
			return;
	}

	
	if(isEmptyVal(strPaypwd)){ 
			msg_box_show('请输入支付密码!',5,'','warning','paypwd'); 
			return;
	}

			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/getmoney",   
			              data: "money="+strMoney+"&paypwd="+strPaypwd+"&marks="+strRemarks,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('提交成功,请稍候查询结果!',5,'/member/k1','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}


//游戏转帐提交
function uTranSubmit(){
	
	var strSource = $('#Gsource').val();
	var strTarget= $("#Gtarget").val();
	var strMoney = $("#nmoney").val();
	var strPaypwd = $("#paypwd").val();
	var strRemarks = $("#remarks").val();
	
	if(isEmptyVal(strMoney)) {
		msg_box_show('金额不能为空!',5,'','warning','nmoney');
		return;
	}
	
	if(strMoney <= 0){
			$("#nmoney").val("");
			msg_box_show('金额必须大于0!',5,'','warning','nmoney');
			return;
	}

	
	if(isEmptyVal(strPaypwd)){ 
			msg_box_show('请输入支付密码!',5,'','warning','paypwd'); 
			return;
	}
	
	if(strSource==0 || strTarget==0){
			msg_box_show('请选择需要转出和转入对象!',5,'','warning',''); 
			return;
	}
	
	if(strSource == strTarget){
			msg_box_show('转出和转入对象不能为同一个!',5,'','warning',''); 
			return;
	}

			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/transmoney",   
			              data: "money="+strMoney+"&source="+strSource+"&target="+strTarget+"&paypwd="+strPaypwd+"&marks="+strRemarks,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('提交成功,请稍候查询结果!',5,'/member/k4','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}


//登陆密码提交
function uPwdSubmit(){
	
	var strPaypwd = $("#pwd").val();
	var strPaypwd1 = $("#pwd1").val();
	var strPaypwd2 = $("#pwd2").val();
	
	if(isEmptyVal(strPaypwd)){ 
			msg_box_show('请输入原密码!',5,'','warning','pwd'); 
			return;
	}

	if(isEmptyVal(strPaypwd1)){ 
			msg_box_show('请输入新密码!',5,'','warning','pwd1'); 
			return;
	}

	if(isEmptyVal(strPaypwd2)){ 
			msg_box_show('请再次输入新密码!',5,'','warning','pwd2'); 
			return;
	}


	if(strPaypwd1 != strPaypwd2){ 
			$("#pwd1").val('');
			$("#pwd2").val('');
			msg_box_show('两次输入的新密码不一致,请重新输入!',5,'','warning','pwd1'); 
			return;
	}

	if(strPaypwd == strPaypwd1){ 
			$("#pwd1").val('');
			$("#pwd2").val('');
			msg_box_show('新密码与原密码相同,不需要修改!',5,'','warning','pwd1'); 
			return;
	}

			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/chpwd",   
			              data: "pwd="+strPaypwd+"&pwd1="+strPaypwd1+"&pwd2="+strPaypwd2,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('修改成功!',5,'/member/index#u','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}


//个人资料提交
function ubaseSubmit(){
	
	var strUname = $("#uname").val();
	var strUsex = $('input[name="sex"]:checked').val();
	var strPhone = $("#phone").val();
	var strBirth = $("#birth").val();
	
	if(isEmptyVal(strUname)){ 
			msg_box_show('请输入真实姓名!',5,'','warning','uname'); 
			return;
	}

	if(isEmptyVal(strPhone)){ 
			msg_box_show('请输入手机号码!',5,'','warning','phone'); 
			return;
	}

			//开始提交表单
			
					$.ajax({   
			              type: "POST",   
			              url: "/member/profile",   
			              data: "uname="+strUname+"&usex="+strUsex+"&phone="+strPhone+"&birth="+strBirth,   
			              dataType:'json',
			              contentType: "application/x-www-form-urlencoded; charset=utf-8", 
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
								//提交成功,进入报表	
								msg_box_show('修改成功!',5,'/member/index#u','succeed');
								
							}else if(data.code == 0){
							
								//未登陆，退出登陆
								
								msg_box_show('未登陆或登陆已超时,请重新登陆!',5,'/index.html','succeed');
							
							} else {
								
								msg_box_show(data.msg,8,'','error','');

							}
			    
			                                  
						}   
			       });  
			
			
			//提交表单结束

}
