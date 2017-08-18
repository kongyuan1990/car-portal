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
<title>Login and Registration Form with HTML5 and CSS3</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Login and Registration Form with HTML5 and CSS3" />
<meta name="keywords"
	content="html5, css3, form, switch, animation, :target, pseudo-class" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href=".${ctp}/favicon.ico">
<link rel="stylesheet" type="text/css" href="css/demo.css" />
<link rel="stylesheet" type="text/css" href="css/style3.css" />
<link rel="stylesheet" type="text/css" href="css/animate-custom.css" />
<script src="${ctp}/js/jquery.min.js"></script>
<script src="${ctp}/js/bootstrap.min.js"></script>
<script src="${ctp}/jquery-validation-1.13.1/dist/jquery.validate.min.js"></script>
</head>

<body>
	<div class="container">

		<header>
			<h1>
				请输入注册时的邮箱
			</h1>

		</header>
		<br />
		<br />

		<section>
			<div id="container_demo">
				<!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->
				<a class="hiddenanchor" id="toregister"></a> <a class="hiddenanchor"
					id="tologin"></a>
				<div id="wrapper">
					<div   class="animate form">
						<form action="${ctp }/sendEmail" id="forgetpwd"  method="post">
							<input type="hidden" name="userType" value="${param.type}">
							<p>
								<label for="emailsignup" class="youmail" data-icon="e">邮箱</label>
								<input id="emailsignup" name="email" required="required" type="email"  />
								<span class="errorinfo" style="color: red"></span>
							</p>
							<br />
							<p class="signin button">
								<input type="submit" value="确定" />
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

		$("#forgetpwd").validate({
			rules : {
				email : {
					required : true,
					email : true
				}
			},
			messages : {
				email:"请按邮箱格式填写"
			}
		});
</script>

</html>