<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="${ctp }/jquery/jquery-2.1.1.min.js" type="text/javascript" charset="utf-8"></script>
<script src="${ctp}/plugin/jquery-validation-1.13.1/dist/jquery.validate.min.js"></script>
<script src="${ctp}/plugin/layer/layer.js"></script>
<script src="${ctp}/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<%@include file="/WEB-INF/common/common-css.jsp"%>
</head>
<body style="background-image: url('https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502810116332&di=0901998cfa545437abd638e546748d08&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Fd439b6003af33a87e88c673ccc5c10385343b536.jpg'); ">
	<center>
		<div class="panel panel-default" style="width: 360px;">
			<div class="panel-heading"><h3>智能泊车注册</h3></div>
			<div class="panel-body">
				<ul class="nav nav-tabs" role="tablist">
				    <li role="presentation" ${active=="商家注册"?"":"class='active'"}><a href="#home" aria-controls="home" role="tab" data-toggle="tab">车主注册</a></li>
				    <li role="presentation" ${active=="商家注册"?"class='active'":""}><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">商家注册</a></li>
			  	</ul>
				<span id="error" style="font-size: 15px;color: red">${msg}</span>
  			<!-- Tab panes -->
			  <div class="tab-content">
			    <div role="tabpanel" class="tab-pane ${ active =='商家注册'?'':'active'}" id="home">
			    	 <form id="carhostRegForm" class="form-signin" role="form" method="post" action="${ctp}/carhost/carhostRegist">
						  <div class="form-group">
							<input type="text" class="form-control" name="account" id="carhost_account_id" value="${account }" placeholder="请输入注册账号" autofocus>
							<span class="glyphicon glyphicon-user form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
						  <div class="form-group">
							<input type="text" class="form-control" name="password" id="carhost_password_id" placeholder="请输入注册密码" style="margin-top:10px;">
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
						  <div class="form-group">
							<input type="text" class="form-control" name="email" id="carhost_email_id" placeholder="请输入邮箱地址" style="margin-top:10px;">
							<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
				        <div class="checkbox">
				          <label>
				          </label>
				          <label style="float:right">
				            <a href="${ctp}/login.jsp">我有账号</a>
				          </label>
			       		</div>
       		 			<a id="carhost_reg" class="btn btn-lg btn-block btn btn-default" href="#" > 注册</a>
      				</form>
			    </div>
			    <div role="tabpanel" class="tab-pane ${active=='商家注册'?'active':''}" id="profile">
			    	 <form id="portownerRegForm" class="form-signin" role="form" method="post" action="${ctp}/portowner/portownerRegist">
						  <div class="form-group">
							<input type="text" class="form-control" name="account" id="carhost_account_id" value="${account }" placeholder="请输入注册账号" autofocus>
							<span class="glyphicon glyphicon-user form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
						  <div class="form-group">
							<input type="text" class="form-control" name="password" id="carhost_password_id" placeholder="请输入注册密码" style="margin-top:10px;">
							<span class="glyphicon glyphicon-lock form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
						  <div class="form-group">
							<input type="text" class="form-control" name="email" id="carhost_email_id" placeholder="请输入邮箱地址" style="margin-top:10px;">
							<span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
							<span class="errInfo" style="font-size: 15px;color: red"></span>
						  </div>
				        <div class="checkbox">
				          <label>
				          </label>
				          <label style="float:right">
				            <a href="${ctp}/login.jsp">我有账号</a>
				          </label>
			       		</div>
       		 			<a id="portowner_reg" class="btn btn-lg btn-block btn btn-default" href="#" > 注册</a>
      				</form>
			    </div>
			    </div>
			  </div>
			</div>
	</center>
</body>
<script type="text/javascript">
	$.validator.setDefaults({
		showErrors : function(map, list) {
			$.each(list, function() {
				$(this.element).nextAll(".errInfo").text(this.message);
				$(this.element).parent("div.form-group").removeClass("has-error");
			});
		}
	});	
	
	$().ready(function() {
		$("#carhostRegForm").validate({
			rules : {
				account : {
					required : true,
					minlength : 5
				},
				password : {
					required : true,
					minlength : 6
				},
				email : {
					required : true,
					email: true
				}
			},
			messages : {
				account : {
					required : "请输入用户名！",
					minlength : "用户名长度不小于5个字符"
				},
				password : {
					required : "请输入密码！",
					minlength : "密码长度不小于6个字符"
				},
				email : {
					required : "请输入邮箱！",
					email : "请输入正确的邮箱格式"
				}
			}
			
		});
		
		
		$("#portownerRegForm").validate({
			rules : {
				account : {
					required : true,
					minlength : 5
				},
				password : {
					required : true,
					minlength : 6
				},
				email : {
					required : true,
					email: true
				}
			},
			messages : {
				account : {
					required : "请输入用户名！",
					minlength : "用户名长度不小于5个字符"
				},
				password : {
					required : "请输入密码！",
					minlength : "密码长度不小于6个字符"
				},
				email : {
					required : "请输入邮箱！",
					email : "请输入正确的邮箱格式"
				}
			}
			
		});
		
		$(".form-group").change(function(){
			$(this).children(".errInfo").empty();
			$("div.form-group").removeClass("has-error");
			$("#error").html("");
		});
		
		$("#carhost_reg").click(function(){
			$("#carhostRegForm").submit();
			return false;
		});
		
		$("#portowner_reg").click(function(){
			$("#portownerRegForm").submit();
			return false;
		});
		
		
	});
	
</script>
</html>