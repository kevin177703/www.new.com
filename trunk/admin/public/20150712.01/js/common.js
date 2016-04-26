/**
 * 公共函数
 * @author kevin email:kevin177703@gmail.com
 * @version 0.0.1
 */
//判断是否为空
function isEmptyVal(B) {
    switch (typeof B) {
        case "undefined":
            return true;
        case "string":
            if (B.replace(/(^[ \t\n\r]*)|([ \t\n\r]*$)/g, "").length == 0) {
                return true
            }
            break;
        case "boolean":
            if (!B) {
                return true
            }
            break;
        case "number":
            if (isNaN(B)) {
                return true
            }
            break;
        case "object":
            if (null === B || B.length === 0) {
                return true
            }
            for (var A in B) {
                return false
            }
            return true
    }
    return false
}
//打开新窗口
function openWindow(B, E, A) {
    var C;
    if (window.screen.width == 800 && window.screen.height == 600) {
        C = "yes"
    } else {
        C = "no"
    }
    var D = "height=" + A + ", width=" + E + ", scrollbars= " + C + ",resizable=yes,toolbar=no,directories=no,menubar=no,locationbar=no,personalbar=no,statusbar=no";
    window.open(B, "_blank", D)
}
function showloading() {
    $.blockUI({message: '<p class="preload"><img src="/public/images/loading3.gif" /> 正在处理中,请稍候...</p>',css: {border: "none",padding: "15px",backgroundColor: "#000","-webkit-border-radius": "10px","-moz-border-radius": "10px",opacity: 0.8,color: "#fff"},fadeIn: 700,fadeOut: 700})
}
function msg_box_show(E, B, A, F, D) {
    var C;
    if (isEmptyVal(B) || B < 0) {
        B = 5
    }
    if (isEmptyVal(A)) {
        A = ""
    }
    if (isEmptyVal(F)) {
        F = "succeed"
    }
    if (isEmptyVal(D)) {
        D = ""
    }
    $.dialog({id: "KDf4315",lock: true,background: "#5F5C5C",opacity: 0.8,icon: F,content: E,init: function() {
            var H = this, G = B;
            var I = function() {
                H.title(G + "秒后关闭");
                !G && H.close();
                G--
            };
            C = setInterval(I, 1000);
            I()
        },close: function() {
            clearInterval(C);
            if (A !== "") {
                top.location.href = A
            }
            if (D !== "") {
                $("#" + D).focus()
            }
        }}).show()
}
var editIndex = undefined;
function endEditing(){
	if (editIndex == undefined){return true}
	if ($('#dg').datagrid('validateRow', editIndex)){
		$('#dg').datagrid('endEdit', editIndex);
		editIndex = undefined;
		return true;
	} else {
		return false;
	}
}
function onClickRow(index){
	if (editIndex != index){
		if (endEditing()){
			$('#dg').datagrid('selectRow', index)
					.datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#dg').datagrid('selectRow', editIndex);
		}
	}
}
function deleteRow(){
	$('#dg').datagrid('cancelEdit', editIndex)
	.datagrid('deleteRow', editIndex);
	editIndex = undefined;
}
function message(msg,type){
	if(type=='error'){
		$.messager.alert('提示信息',msg,'error');
	}else if(type=='info'){
		$.messager.alert('提示信息',msg,'info');
	}else if(type=='question'){
		$.messager.alert('提示信息',msg,'question');
	}else if(type=='warning'){
		$.messager.alert('提示信息',msg,'warning');
	}else{
		$.messager.alert('提示信息',msg);
	}
}
function wait_open(){
	$.messager.progress({
		title:'请稍等..',
		msg:'操作进行中..'
	});
}
function wait_close(){
	$.messager.progress('close');
}
