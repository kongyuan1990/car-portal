<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="zh">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="${ctp}/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctp}/css/bootstrap-theme.min.css" />
<link href="${ctp}/css/forward_201503262210.css" type="text/css"
	rel="stylesheet" />
<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
<script src="${ctp}/js/bootstrap.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/includes/nav_bar.jsp"%>


	<div class="wash-paper clearfix" id="profile">
		<%@include file="/WEB-INF/includes/side_bar.jsp" %>
		<div class="main-content">
			<div class="content-header">
				<h2>修改密码</h2>
			</div>
			<div class="content-inner profile-changepwd">
				<form class="form-horizontal" method="post" id="changepwd_form">
					<fieldset>
						<div class="control-group clear-fix">
							<label class="control-label" for=""><span
								class="required">*</span>原密码</label>
							<div class="controls">
								<input name="old_password" id="sf_guard_user_old_pwd"
									type="password" />
								<p class="help-block">(请输入现在正在使用的密码)</p>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for=""><span
								class="required">*</span>新密码</label>
							<div class="controls">
								<input name="new_password" id="sf_guard_user_new_pwd"
									type="password" />
								<p class="help-block">（请输入新密码）</p>
							</div>
						</div>
						<div class="control-group clear-fix">
							<label class="control-label" for=""><span
								class="required">*</span>重复新密码</label>
							<div class="controls">
								<input name="repeat_new_password"
									id="sf_guard_user_repeat_pwd" type="password" />
								<p class="help-block">(请再输入一次新密码)</p>
							</div>
							<!--end input-->
						</div>
						<!--end clearfix-->
						<div class="form-actions">
							<button type="button" class="btn btn-yellow"
								id="sf_guard_user_changepwd_submit">提交更改</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
<script type="text/javascript">
	$("#sf_guard_user_changepwd_submit").click(function(){
		/* if($("#sf_guard_user_old_pwd").val().trim()==$("#sf_guard_user_new_pwd").val().trim()){
			alert("新密码不能与原密码相同");
		}else if($("#sf_guard_user_repeat_pwd").val().trim()!=$("#sf_guard_user_new_pwd").val().trim()){
			alert("两次新密码输入不相同");
		}else{ */
			var params = $("#changepwd_form").serialize();
			$.post(
					"${ctp}/member/forgetpassword",
					params,
					function(data){
						alert(data.msg);
					}
				);
		//}
		
			
		
	});
</script>
</body>
</html>