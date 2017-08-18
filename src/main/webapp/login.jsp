<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6 lt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7 lt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8 lt8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->

<head>
<meta charset="UTF-8" />
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">  -->
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Login and Registration Form with HTML5 and CSS3" />
<meta name="keywords"
	content="html5, css3, form, switch, animation, :target, pseudo-class" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css" href="${ctp }/css/demo.css" />
<link rel="stylesheet" type="text/css" href="${ctp }/css/style3.css" />
<link rel="stylesheet" type="text/css" href="${ctp }/css/animate-custom.css" />
<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
<script src="${ctp}/js/bootstrap.min.js"></script>
<script
	src="${ctp}/jquery-validation-1.13.1/dist/jquery.validate.min.js"></script>

</head>
<body>
	<div class="container">

		<header>
			<h1>
				智能停车
			</h1>

		</header>
		<br /> <br />

		<section>
			<div id="container_demo">
				<!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
				<a class="hiddenanchor" id="toregister"></a> <a class="hiddenanchor"
					id="tologin"></a>
				<div id="wrapper">
					<div id="login" class="animate form">
						<form action="" id="loginForm" method="post">
							<p>
								<label for="errormsg" style="color: red">${msg }</label>
							</p>
							<p>
								<label for="username" class="uname" data-icon="u"> 用户名 </label>
								<input id="username" name="account" type="text" value="${wrongUserInfo.account }"
									placeholder="用户名" /><span class="errorinfo" style="color: red"></span>
							</p>
							<br />
							<p>
								<label for="password" class="youpasswd" data-icon="p">密码
								</label> <input id="password" name="password" type="password" value="${wrongUserInfo.password }"
									placeholder="密码" /><span class="errorinfo" style="color: red"></span>
							</p>
							<br />
							<p>
								<label for="userselect" class="userstyle"> 车主/车库管理员 </label>
								<select>
									<option  value="carowner">车主</option>
									<option  value="portowner">车库管理者</option>
								</select>
							</p>
							<p>
								<input type="checkbox" name="loginkeeping" id="loginkeeping"
									value="true" /> <label for="loginkeeping">自动登录</label>
								<br /> <label><a id="forgetpwd" href="${ctp }/forgetpwd">忘记密码</a></label>
							</p>

							<p class="login button">
								<input id="submitBtn" type="submit" value="登录" />
							</p>
							<p class="change_link">
								还不是会员 ? <a href="#toregister" class="to_register">注册会员</a>
							</p>
						</form>
					</div>
				</div>
			</div>
		</section>
	</div>
	
</body>

<script>

	$.validator.setDefaults({
		showErrors : function(map, list) {
			$(".errorinfo").empty();
			$.each(list, function() {
				$(this.element).nextAll(".errorinfo").text(this.message);
			});
		}
	});
	
	$("#loginForm").validate({
		rules : {
			username : {
				required : true,
				rangelength : [ 6, 18 ]
			},
			password : {
				required : true,
				rangelength : [ 6, 18 ]
			}

		},
		messages : {
			username : {
				required : "请填入账户名",
				rangelength : "账户名长度在{0}到{1}之间"
			},
			password : {
				required : "请填入密码",
				rangelength : "账户名长度在{0}到{1}之间"
			}

		},
		
	});
	
	var type = "";
	$("#forgetpwd").click(function(){
		type = $("select :selected").val();
		location.href="${ctp }/forgetpwd?type="+type;
		return false;
	})
	
	$("#submitBtn").click(function(){
		type = $("select :selected").val();
		if(type == "carowner"){
			$("#loginForm").attr("action","${ctp}/carownerLogin").submit();
			return false;
		}else{
			$("#loginForm").attr("action","${ctp}/portownerLogin").submit();
			return false;
		};
	});
	 
	
	
</script>
</html>