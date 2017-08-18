<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>头像上传</title>
<link rel="stylesheet" href="${ctp}/css/bootstrap.min.css" />
<link rel="stylesheet" href="${ctp}/css/bootstrap-theme.min.css" />
<link href="${ctp}/css/forward_201503262210.css" type="text/css"
	rel="stylesheet" />
<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
<script src="${ctp}/js/bootstrap.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/includes/nav_bar.jsp"%>
	<form action="${ctp}/member/toportrait" id="photoForm" enctype="multipart/form-data"
		style="margin-top: 20px;" method="post">
		<div class="form-group">
			<input type="file" name="file" class="form-control"> <br>
			<div class="imgShow"></div>
		</div>
		<button type="button" class="btn btn-success">确定</button>
	</form>
	<script type="text/javascript">
		$(function() {
			$(".btn-success").click(function(){
				$("#photoForm").submit();
			});
			
			$("input[type='file']")
					.change(
							function() {
								var files = event.target.files;
								var file;
								if (files && files.length > 0) {
									file = files[0];
								}
								var reg = /image*/;
								if (!reg.test(file.type)) {
									alert("请选择一个图片");
									$(this).val("");
									return false;
								}
								var URL = window.URL || window.webkitURL;
								var imgURL = URL.createObjectURL(file);
								$(this)
										.nextAll("div.imgShow")
										.empty()
										.append(
												"<img src='"+imgURL+"' style='width:400px;height:240px;'/>");
							});
			;
		});
	</script>
</body>
</html>