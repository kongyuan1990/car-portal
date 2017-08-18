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
				<h2>待开发</h2>
			</div>
			<div class="content-inner profile-changepwd">
				<form class="form-horizontal" method="post" id="changepwd_form">
					<fieldset>
						
						<div class="control-group clear-fix">
							<label class="control-label" for=""><span
								class="required">*</span>身份证</label>
							<div class="controls">
								<input name="user[repeat_new_password]"
									id="sf_guard_user_repeat_pwd" type="password" />
							</div>
							<!--end input-->
						</div>
						<!--end clearfix-->
						<div class="form-actions">
							<button type="button" class="btn btn-yellow"
								id="sf_guard_user_changepwd_submit">下一步</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>

</body>
</html>