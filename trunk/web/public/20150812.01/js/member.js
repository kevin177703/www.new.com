//展开左侧菜单 
function switchM(tabs_i,li_id){
	if(isEmptyVal(tabs_i)) tabs_i=0;
	$('.vcon').slideUp().eq(tabs_i).slideDown();
	if(!isEmptyVal(li_id)){
		$('.vconlist li'). removeClass('on');
		$('#'+li_id).addClass('on');
	}
}
//在线支付
function moneyPaySumbit(){
	var paymoney=$("#paymoney").val();
	var paybank = $("#paybank").val();
	$.ajax({   
        type: "POST",   
        url: "/member/ajax/money-pay.html",   
        data: {
        	paymoney:paymoney,
        	paybank:paybank,
        },   
        dataType:'json',
        beforeSend:function(){   
      	  showloading();    
        },			    
        complete: function() {   
      	  //$.unblockUI();   
        },   
        success: function(data){
        	$.unblockUI();
      	  	if(data.result==true){
      	  		var info = data.data;
      		 // $("#payorderid").val(info.payorderid);
      		  //$("#paymd5").val(info.paymd5);
      		  $.blockUI({ message: $('#toPayTip') });
      	  	}else{
      	  		if(data.data=='login'){
      	  			msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
      	  		}else{
      			  msg_box_show(data.msg,3,'','error','');
      		  }
      	  }               
	   }   
   });  
}
//银行转账提交
function moneyBankSumbit(){
	var money_bank_id = $("#money_bank_id").val();
	var bankname = $("#bankname").val();
	var bankcard = $("#bankcard").val();
	var bankowner = $("#bankowner").val();
	var bankaddress = $("#bankaddress").val();
	var banktype = $("#banktype").val();
	var bankmoney = $("#bankmoney").val();
	var remarks = $("#remarks").val();
	
	if(money_bank_id<1) {
		msg_box_show('请选择收款账户!',3,'','warning','money_bank_id');
		return;
	}
	if(isEmptyVal(bankname)){
		msg_box_show('请选择您银行卡所属银行!',3,'','warning','bankname'); 
		return;
	}	
	if(isEmptyVal(bankcard)){
		msg_box_show('请输入转帐的卡号后4位!',3,'','warning','bankcard');
		return;
	}
	if(isEmptyVal(bankowner)){
		msg_box_show('请输入存款户名!',3,'','warning','bankowner');
		return;
	}
	if(isEmptyVal(bankaddress)){
		msg_box_show('请输入开户地址!',3,'','warning','bankaddress');
		return;
	}
	if(isEmptyVal(banktype)){
		msg_box_show('请选择付款方式!',3,'','warning','banktype');
		return;
	}
	$.ajax({   
        type: "POST",   
        url: "/member/ajax/money-bank.html",   
        data: {
        	money_bank_id:money_bank_id,
        	bankname:bankname,
        	bankcard:bankcard,
        	bankowner:bankowner,
        	bankaddress:bankaddress,
        	banktype:banktype,
        	bankmoney:bankmoney,
        	remarks:remarks
        },   
        dataType:'json',
        beforeSend:function(){   
      	  showloading();    
        },			    
        complete: function() {   
      	  $.unblockUI();   
        },   
        success: function(data){
      	  if(data.result==true){
      		  msg_box_show('添加成功!',3,'/member-money-bank.html','succeed');
      	  }else{
      		  if(data.data=='login'){
      			  msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
      		  }else{
      			  msg_box_show(data.msg,3,'','error','');
      		  }
			  }               
		 }   
  });  
}
//银行资料绑定提交
function basicBankSubmit(){
	var banktype_id = $("#banktype_id").val();
	var card = $("#card").val();
	var province = $("#province").val();
	var city = $("#city").val();
	var address = $("#address").val();
	if(banktype_id<1){ 
		msg_box_show('请选择开户银行!',3,'','warning','sex'); 
		return;
	}
	if(isEmptyVal(card)){ 
		msg_box_show('请输入银行卡号!',3,'','warning','birth'); 
		return;
	}
	if(isEmptyVal(province) || province=="请选择省份"){ 
		msg_box_show('请选择开户省份!',3,'','warning','email'); 
		return;
	}
	if(isEmptyVal(city) || city=="请先选择省份"){ 
		msg_box_show('请选择开户城市!',3,'','warning','email'); 
		return;
	}
	if(isEmptyVal(address)){ 
		msg_box_show('请输入开户网点!',3,'','warning','email'); 
		return;
	}
	$.ajax({   
          type: "POST",   
          url: "/member/ajax/basic-bankedit.html",   
          data: {banktype_id:banktype_id,card:card,province:province,city:city,address:address},   
          dataType:'json',
          beforeSend:function(){   
        	  showloading();    
          },			    
          complete: function() {   
        	  $.unblockUI();   
          },   
          success: function(data){
        	  if(data.result==true){
        		  msg_box_show('添加成功!',3,'/member-basic-bank.html','succeed');
        	  }else{
        		  if(data.data=='login'){
        			  msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
        		  }else{
        			  msg_box_show(data.msg,3,'','error','');
        		  }
			  }               
		 }   
    });  
}
//修改登陆密码
function basicPassSubmit(){
	var password = $("#password").val();
	var new_password = $("#new_password").val();
	var c_new_password = $("#c_new_password").val();
	if(isEmptyVal(password)){ 
		msg_box_show('请输入原密码!',3,'','warning','password'); 
		return;
	}
	if(isEmptyVal(new_password)){ 
		msg_box_show('请输入新密码!',3,'','warning','new_password'); 
		return;
	}
	if(new_password != c_new_password){ 
		msg_box_show('两次新密码不一致!',3,'','warning','c_new_password'); 
		return;
	}
	$.ajax({   
        type: "POST",   
        url: "/member/ajax/basic-pass.html",   
        data: {password:password,new_password:new_password,c_new_password:c_new_password},   
        dataType:'json',
        beforeSend:function(){   
      	  showloading();    
        },			    
        complete: function() {   
      	  $.unblockUI();   
        },   
        success: function(data){
      	  if(data.result==true){
      		  msg_box_show('修改成功!',3,'/member-basic-pass.html','succeed');
      	  }else{
      		  if(data.data=='login'){
      			  msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
      		  }else{
      			  msg_box_show(data.msg,3,'','error','');
      		  }
      	  }               
	   }   
  });  
}
//修改支付密码
function basicPayPassSubmit(){
	var password = $("#password").val();
	var new_password = $("#new_password").val();
	var c_new_password = $("#c_new_password").val();
	if(isEmptyVal(password)){ 
		msg_box_show('请输入原密码!',3,'','warning','password'); 
		return;
	}
	if(isEmptyVal(new_password)){ 
		msg_box_show('请输入新密码!',3,'','warning','new_password'); 
		return;
	}
	if(new_password != c_new_password){ 
		msg_box_show('两次新密码不一致!',3,'','warning','c_new_password'); 
		return;
	}
	$.ajax({   
        type: "POST",   
        url: "/member/ajax/basic-paypass.html",   
        data: {password:password,new_password:new_password,c_new_password:c_new_password},   
        dataType:'json',
        beforeSend:function(){   
      	  showloading();    
        },			    
        complete: function() {   
      	  $.unblockUI();   
        },   
        success: function(data){
      	  if(data.result==true){
      		  msg_box_show('修改成功!',3,'/member-basic-paypass.html','succeed');
      	  }else{
      		  if(data.data=='login'){
      			  msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
      		  }else{
      			  msg_box_show(data.msg,3,'','error','');
      		  }
      	  }               
	   }   
  });  
}
//个人资料提交
function basicIndexSubmit(){
	var sex = $('input[name="sex"]:checked').val();
	var email = $("#email").val();
	var birth = $("#birth").val();
	if(isEmptyVal(sex)){ 
		msg_box_show('请选择性别!',3,'','warning','sex'); 
		return;
	}
	if(isEmptyVal(birth)){ 
		msg_box_show('请选择生日!',3,'','warning','birth'); 
		return;
	}
	if(isEmptyVal(email)){ 
		msg_box_show('请输入邮箱!',3,'','warning','email'); 
		return;
	}
	$.ajax({   
          type: "POST",   
          url: "/member/ajax/basic-index.html",   
          data: {sex:sex,email:email,birth:birth},   
          dataType:'json',
          beforeSend:function(){   
        	  showloading();    
          },			    
          complete: function() {   
        	  $.unblockUI();   
          },   
          success: function(data){
        	  if(data.result==true){
        		  msg_box_show('修改成功!',3,'/member-basic-index.html','succeed');
        	  }else{
        		  if(data.data=='login'){
        			  msg_box_show('未登陆或登陆已超时,请重新登陆!',3,'/','succeed');
        		  }else{
        			  msg_box_show(data.msg,3,'','error','');
        		  }
			  }               
		 }   
    });  
}
