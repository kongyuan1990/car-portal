<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="portownerApproveor" content="">
<%@include file="/WEB-INF/common/common-css.jsp"%>
<style>
#footer {
	padding: 15px 0;
	background: #fff;
	border-top: 1px solid #ddd;
	text-align: center;
}
</style>
</head>
<body>
	<div class="navbar-wrapper">
		<div class="container">
		<!-- 头部问件 -->
<%-- 			<%@ include file="/WEB-INF/include/nav.jsp"%> --%>

		</div>
	</div>
	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1>实名认证 - 申请</h1>
		</div>

		<%@ include file="/WEB-INF/common/portowner_li.jsp"%>

		<div class="addHtml"></div>
		<hr>
	</div>
	<!-- /container -->
	<div class="container" style="margin-top: 20px;">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<div id="footer">
					<div class="footerNav">
						<a rel="nofollow" href="http://www.atguigu.com">关于我们</a> | <a
							rel="nofollow" href="http://www.atguigu.com">服务条款</a> | <a
							rel="nofollow" href="http://www.atguigu.com">免责声明</a> | <a
							rel="nofollow" href="http://www.atguigu.com">网站地图</a> | <a
							rel="nofollow" href="http://www.atguigu.com">联系我们</a>
					</div>
					<div class="copyRight">Copyright ?2017-2017 atguigu.com 版权所有
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/common/common-js.jsp"%>
	<script>
		$(function(){
			$("li[role='presentation']").click(function(){
				$(this).siblings().removeClass("active");
				$(this).addClass("active");
				var url = $(this).children("a").attr("url");
				$.get(url,function(data){
					$(".addHtml").empty().append(data);
				});
			});
// 			$.get("${ctp}/portownerApprove/apply.html",function(data){
				
// 				$(".addHtml").empty().append(data);
// 			});
			
			$.ajax({
				url : "${ctp}/portownerApprove/apply.html",
				type : "get",
				beforeSend : function() {
					index = layer.load();
				},
				success : function(data) {
					$(".addHtml").empty().append(data);
					layer.close(index);
				}
			});
			
			$("body").on(
					"click",
					".unusebtn",
					function() {
// 						alert($(this).attr("url"));
						//var thisEle = $(this);
						//本页会有一个隐藏button带了本页的 
						var url = $(this).attr("url");
						//这个请求不是ajax，需要跳转
						if (url == '${ctp}/member/portownerApprove.html') {
							location.href = url;
							return false;
							
						}else if($(this).attr("form")=="true"){
// 							alert($(this).attr("form"));
							//这是一个资质文件上传的页面
							//发送文件上传资质文件请求；
							var fd = new FormData($(".infoForm")[0]);
							console.log(fd);
							$.ajax({
								url:"http://localhost:8081/car-restapi/PortOwnerAppove/upload",
								data:fd,
								type:"post",
								contentType:false,
								dataType:"json",
								processData:false,
								beforeSend : function() {
									index = layer.load();
								},
								success:function(result){
									//来到邮箱填写页面
									var url = "${ctp}/portownerApprove/apply3.html";
									//发ajax来到下一步的；
									$.post(url,function(data) {
										//服务器返回的页面
										//1、填充数据
										$(".addHtml").empty().append(data);
										//2、某些li置为active  btn按钮的url和a的url是一样的；所以我们直接判断是否 当前的url
										//本页地址的按钮
										var hiddentUrl = $("button:hidden.unusebtn").attr("url");
										//2.1)、先找到拥有这个href的a标签
										var aEle = $("a[url='" + hiddentUrl + "']");
										//2.2)、找到父 的li
										var p = aEle.parents("li[role='presentation']");
										//2.3)、改样式
										p.addClass("active")
												.siblings("li[role='presentation']")
												.removeClass("active");
										layer.close(index);
									});
								},
								error:function(e){
									layer.msg("上传失败:"+e);
								}
							});
							
							return false;
							
						} else {
							//ajax请求
							//序列化当前页面的表单数据；把这个数据提交过去
							var params = $(".infoForm").serialize();
							$.ajax({
								url:url,
								data:params,
								type:"post",
								dataType:"html",
								beforeSend : function() {
									index = layer.load();
								},
								success:function(data){
									//来到邮箱填写页面
									$(".addHtml").empty().append(data);
									//2、某些li置为active  btn按钮的url和a的url是一样的；所以我们直接判断是否 当前的url
									//本页地址的按钮
									var hiddentUrl = $("button:hidden.unusebtn").attr("url");
									//2.1)、先找到拥有这个href的a标签
									var aEle = $("a[url='" + hiddentUrl + "']");
									//2.2)、找到父 的li
									var p = aEle.parents("li[role='presentation']");
									//2.3)、改样式
									p.addClass("active")
											.siblings("li[role='presentation']")
											.removeClass("active");
									
									layer.close(index);
								},
								error:function(e){
									layer.msg("上传失败:"+e);
								}
							});
							
// 							$.post(url, params ,function(data) {
// 								//服务器返回的页面
// 								//1、填充数据
// 								$(".addHtml").empty().append(data);
// 								//2、某些li置为active  btn按钮的url和a的url是一样的；所以我们直接判断是否 当前的url
// 								//本页地址的按钮
// 								var hiddentUrl = $("button:hidden.unusebtn").attr("url");
// 								alert(hiddentUrl);
// 								//2.1)、先找到拥有这个href的a标签
// 								var aEle = $("a[url='" + hiddentUrl + "']");
// 								//2.2)、找到父 的li
// 								var p = aEle.parents("li[role='presentation']");
// 								//2.3)、改样式
// 								p.addClass("active")
// 										.siblings("li[role='presentation']")
// 										.removeClass("active");
// 							});
						}
						
						return false;
					});
			
		});
		
	</script>
</body>
</html>