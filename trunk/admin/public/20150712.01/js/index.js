/**
 * 首页专用
 */
//实时显示系统时间  需要修改
function ShowTime(now){
	var time = new Date(parseInt(now) * 1000).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
	document.getElementById("showtime").innerHTML = "北京时间:"+time;
	now = now+1;
	window.setTimeout("ShowTime("+now+")",1000);
}