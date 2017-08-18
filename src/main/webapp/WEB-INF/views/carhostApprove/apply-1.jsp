<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form class="infoForm"  role="form" style="margin-top: 20px;" 
		enctype="multipart/form-data">
	<input type="hidden" name="memberId" value="${auto_info.id }" />
	<c:forEach items="${certs}" var="cert">
		<div class="form-group">
		<input type="hidden" name="certId" value="${cert.id}" />
		<label for="exampleInputEmail1">${cert.name }</label> <input type="file" name="file"
			class="form-control"> <br> <div class="imgShow"></div>
		</div>
	</c:forEach>
	
	<button type="button" url="${ctp}/auth/apply.html"
		class="btn btn-default unusebtn">上一步</button>
		
	<!-- 提交文件上传表单。提交成功以后来到下一页 -->
	<button type="button" url="${ctp}/auth/apply2.html"
		class="btn btn-success unusebtn" form="true">完成</button>
	<button style="display: none;" class="btn btn-default unusebtn"
		url="${ctp}/auth/apply1.html"></button>
</form>
<script>
	$(function() {
		//为文件选择项绑定事件；
		$("input[type='file']")
				.change(
						function(event) {
							console.log(event);
							//拿到图片项。进行显示
							//1、回调函数需要获取到事件对象
							//2、可以用事件对象得到很多信息
							var files = event.target.files; //this.files[0]
							var file;
							if (files && files.length > 0) {
								file = files[0];
							}
							var reg = /image*/;
							if (!reg.test(file.type)) {
								alert("请选择一个图片");
								//不是图片将val置空
								$(this).val("");
								return false;
							};

							var URL = window.URL || window.webkitURL;
							//创建一个临时的url地址
							var imgURL = URL.createObjectURL(file);
							$(this).nextAll("div.imgShow").append("<img src='"+imgURL+"' style='width:300px;height:350px;'/>");
							//console.log(file);
						});
	});
	
	
</script>