<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${ctp}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctp}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${ctp}/css/login.css">
	<link rel="stylesheet" href="${ctp}/themes/icon.css">
	
	<link rel="stylesheet" href="${ctp}/easyui/themes/default/easyui.css">
	<link rel="stylesheet" href="${ctp}/easyui/themes/icon.css">
	<script src="${ctp}/easyui/jquery.min.js"></script>
	<script src="${ctp}/easyui/jquery.easyui.min.js"></script>
    <script src="${ctp}/bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
 	
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <div><a class="navbar-brand" href="index.html" style="font-size:32px;">智能泊车-泊车预约平台</a></div>
        </div>
      </div>
    </nav>
	
	<br/>
	<br/>
	

	<br/>
	 <%request.setAttribute("username","张三"); %>
	<br/>
	

		<div style="text-align:center;font-size:50px;color:#F00">
        <span class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i>网上预约</span>
        </div>
		<br/>
		<br/>
		
		
		<div style="text-align:center;font-size:25px;color:#F00">
			<span class="form-signin-heading"><%= request.getAttribute("username")%>，请在以下时间内完成泊车</span>
		</div>
		<br/>
		<br/>
        <DIV id="CountMsg" class="HotDate" style="text-align:center;font-size:23px" border:3px solid #ccc"> 
			<span id="t_d">00天</span> 
			<span id="t_h">00时</span> 
			<span id="t_m">00分</span> 
			<span id="t_s">00秒</span> 
		</DIV> 
        
        <br/>
        
     <div style="text-align:center;font-size:18px">
      <table align="center" cellspacing="0" cellpadding="0"  width = "30%" border="1" style="text-align: center;">  
        <tr>  
            <td>停车场名称</td>  
            <td>${cartPort.name}</td>  
        </tr>  
        <tr>  
            <td>停车场地址</td>  
            <td>${cartPort.address}</td>  
        </tr>  
        <tr>  
            <td>停车场每小时停车价格</td>  
            <td>${cartPort.price}</td>  
        </tr>  
        
   	 </table> 
    </div>       
		<br/>
		
		
	

    <body>
	<div style="text-align:center;font-size:23px;"margin:20px 0;"">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('open')">泊车成功</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#w').window('close')">取消泊车</a>
	</div>
	<div id="w" class="easyui-window" title="Window Layout" data-options="iconCls:'icon-save'" style="width:500px;height:200px;padding:5px;">
		<div class="easyui-layout" data-options="fit:true">
			
			<div data-options="region:'center'" style="padding:10px;">
				你确认已经泊车成功了吗？
			</div>
			<div data-options="region:'south',border:false" style="text-align:right;padding:5px 0 0;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-ok'" href="javascript:void(0)" onclick="javascript:succPort()" style="width:80px">确定</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" href="javascript:void(0)" onclick="javascript:backPort()" style="width:80px">取消</a>
			</div>
		</div>
	</div>
 
</body>
    
    <script>
	function succPort(){
		$.get("${ctp}/getAjax");
		
		//location.href="${ctp}/car-portal/preorder/time?id=1";//重定向需要的页面中
	}
	function backPort(){
		$('#w').window('close');  // close a window  

	}
  
    
    function getRTime(){ 
    	var EndTime= new Date('${time}'); //截止时间 
    	var NowTime = new Date(); 
    	var t =EndTime.getTime() - NowTime.getTime(); 
    	/*var d=Math.floor(t/1000/60/60/24); 
    	t-=d*(1000*60*60*24); 
    	var h=Math.floor(t/1000/60/60); 
    	t-=h*60*60*1000; 
    	var m=Math.floor(t/1000/60); 
    	t-=m*60*1000; 
    	var s=Math.floor(t/1000);*/
    	 
    	var d=Math.floor(t/1000/60/60/24); 
    	var h=Math.floor(t/1000/60/60%24); 
    	var m=Math.floor(t/1000/60%60); 
    	var s=Math.floor(t/1000%60); 
    	 
    	document.getElementById("t_d").innerHTML = d + "天"; 
    	document.getElementById("t_h").innerHTML = h + "时"; 
    	document.getElementById("t_m").innerHTML = m + "分"; 
    	document.getElementById("t_s").innerHTML = s + "秒"; 
	    	if(EndTime.getTime()-NowTime.getTime()<0){
	    		//填转发页面
	    	}
    	} 
    
    	setInterval(getRTime,1000); 
    	

    </script>
  </body>
</html>