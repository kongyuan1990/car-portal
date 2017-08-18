<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<link rel="stylesheet"
	href="${ctp}/plugin/bootstrap-3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="${ctp}/plugin/bootstrap-3.3.7/css/bootstrap.min.css" />
<script src="${ctp}/plugin/jquery-2.1.1.min.js"></script>
<script src="${ctp}/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
	td{width:80px;}
</style>

</head><!--  style="background-color: #F7F7F7" -->
<body>
	<nav class="navbar navbar-default" style="color: black;">
		<div class="container-fluid">
			<div class="navbar-header">
				<a href="${ctp}/#"> <span class="navbar-brand"
					style="margin: 0px 20px 0px 15px;">智能泊车</span> <!-- <img src="${ctp}/img/log.png" class="img-responsive" alt="泊车网" style=" margin:5px 30px 5px 20px"> -->
				</a>
			</div>
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li class="active"><a href="${ctp}/#">首页<span class="sr-only">(current)</span></a></li>
					<li><a href="${ctp}/#">我的订单</a></li>
					<li><a href="${ctp}/#">停车场入驻</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right" style="margin-right: 10px;">
					<li><a href="${ctp}/#">注册</a></li>
					<li><a href="${ctp}/#">登录</a></li>
					<li class="dropdown"><a href="${ctp}/#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">张三<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/#">会员中心</a></li>
							<li><a href="${ctp}/#">消息</a></li>
							<li><a href="${ctp}/#">退出</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<form class="navbar-form navbar-left" role="search" style="float: left;">
				<span>
				当前位置:<span class="icon-bar">${myAdress==null?"北京市长安街":myAdress}</span><a href="${ctp}/index.jsp">[切换位置]</a>
				</span>&nbsp;
				<input type="text" class="form-control" placeholder="搜索停车场">
				<button id="searchBtn" type="button" class="btn btn-default">搜索</button>
			</form>
			<script type="text/javascript">
					$("#searchBtn").click(function(){
						var name = $(this).prev().val();
						var path = "${ctp}/carport/carportByCond?cond=name&name="+name;
						console.log(path);
						$.ajax({
								type: "get",
							  	url: path,
							  	success: function(data){
							  		console.log(data);
							  		if(data.length!=0){
							  			createTable(data);//创建表格 
							  		}else{
							  			createErrorDiv();
							  		}
							  		
								  	
							  	},
							  	dataType:"json"
						});
						return false;
					});
			
			</script>
			<div class="row" style="margin-bottom: 10px;">
				<div class="col-md-12">
				<ul class="nav nav-pills" style="float: left;" id="cond">
					<li role="presentation" class="active" ><a href="${ctp}/carport/carportByCond" cond="distance">距离最近</a></li>
					<li role="presentation"><a href="${ctp}/carport/carportByCond" cond="price">价格最平</a></li>
				</ul>
				<script type="text/javascript">
					$(function(){
						$("#cond li").click(function(){
							$("#cond li").removeClass("active");
							$(this).addClass("active");
							
							var aElement = $(this).children(":first");
							cond = aElement.attr("cond");
							var url = aElement[0].href+"?cond="+cond;
							console.log(url);
							$.post(
								url, 
								function(data){
									createTable(data);
								}, "json");
							return false;
						});
					});
				
					function createErrorDiv(){
						$(".table").find("tbody").empty();
						$(".table").removeClass("table-bordered");
						$("#more").empty();
						var div = $("<div style='font-size: 15px;margin-top:15px;'>系统没有找到您搜索的停车场！</div>");
						$(".table").find("tbody").append(div);
					}
					
					//创建表格
					function createTable(data){
						$(".table").find("tbody").empty();
						 var ctp = $(".table").attr('ctp');
						 $.each(data,
							function(i, n){
						 		var tr = $("<tr></tr>");
								 $.each(n,function(i,nn){
									 tr.append(
										"<td>"
											+"<div class='thumbnail'>"
											+"<img style='width:247px;float:left;margin:0px 20px 15px 0px;' src='"+ctp+"/"+nn.picturepath+"' alt='"+nn.name+"'>"
											+"<div class='caption'>"
											+"<h3>"+nn.name+"</h3>"
												+"<p>距离：10米</p>"
												+"<p>共有车位："+nn.totalPlace+"个，可选车位："+nn.remainingPlace+"个 </p>"
												+"<p>价格："+nn.price+"元/小时</p>"
												+"<p>可月租，可时租</p>"
												+"<p>"
												+"<a href='${ctp}/parking.jsp' class='btn btn-default' role='button' "+"carportid="+nn.id+">立即预约</a>"
												+"</p>"
											+"</div>"
											+"</div>"
										+"</td>");
								 });
								$(".table").find("tbody").append(tr);	
							});
					}
					
				</script>
				</div>
			</div>
			<table class="table table-bordered table-responsive" ctp='${ctp }'>
					<tbody>
					<c:forEach items="${cartportsList}" var="carports">
					<tr>
						<c:forEach items="${carports }" var="carp"> 
							<td>
								<div class="thumbnail">
									<img src="${ctp}/${carp.picturepath}" alt="${carp.name }">
									<div class="caption">
										<h3>${carp.name }</h3>
										<p>距离：${carp.absDistance }米</p>
										<p>共有车位：${carp.totalPlace }个，可选车位：${carp.remainingPlace }个 </p>
										<p>价格：${carp.price }元/小时</p>
										<p>可月租，可时租</p>
										<p>
											<a href="${ctp}/parking.jsp" class="btn btn-default" role="button" carportid=${carp.id }>立即预约</a>
										</p>
									</div>
								</div>
							</td>
						</c:forEach>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<p class="text-left" id="more">
						<a href="${ctp}/#">更多停车场  ...</a>
				</p>
		</div>
		<div class="col-md-1"></div>
	</div>
	
	
	<!-- 页尾 -->
	<div class="row" style="text-align: center; margin: 5px 10px">
		<div class="col-md-12">
			<a href="${ctp}/#">智能停车 copyritht2016-2018</a>
		</div>
	</div>
</body>
</html>