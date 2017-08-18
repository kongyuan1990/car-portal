<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<form class="infoForm" role="form" style="margin-top: 20px;" url="${ctp}/auth/apply.html">
	
	<span style="font-size: 25px;color:red;">${msg}</span>
	<div class="form-group">
		<label for="exampleInputEmail1">真实名称</label> <input type="text"
			class="form-control"  name="name" value="${baseinfo.name }"
			placeholder="请输入真实名称">
	</div>
	
	<div class="form-group">
		<label for="exampleInputEmail1">性别</label>
		<select name="gender" > 
			<option value="1" ${baseinfo.gender==1?"selected='selected'":""}>男</option> 
			<option value="0" ${baseinfo.gender==0?"selected='selected'":""}>女</option> 
		</select>
	</div>
	
	<div class="form-group">
		<label for="exampleInputPassword1">身份证号码</label> <input name="idCardNumber" value="${baseinfo.idCardNumber }"
			type="text" class="form-control" id="exampleInputPassword1"
			placeholder="请输入身份证号码">
	</div>
	
	<div class="form-group">
		<label for="exampleInputPassword1">手机号码</label> <input name="phoneNumber" value="${baseinfo.phoneNumber }"
			type="text" class="form-control" id="exampleInputPassword1"
			placeholder="请输入手机号码">
	</div>
	
	<div class="form-group">
		<label for="exampleInputPassword1">车牌号</label> <input name="carNumber" value="${baseinfo.carNumber }"
			type="text" class="form-control" id="exampleInputPassword1"
			placeholder="请输入车牌号">
	</div>
	<!-- 上一步是来到账户选择页面 -->
	<button type="button"
<%-- 		url="${ctp}/member/auth.html" --%>
		class="btn btn-default unusebtn">上一步</button>
	<!-- 下一步是来到资质文件上传页面 -->
	<button type="button" style="display: none"
		url="${ctp}/auth/apply.html"
		class="btn btn-success unusebtn"></button>
		
	<button type="button"
		url="${ctp}/auth/apply1.html"
		class="btn btn-success unusebtn">下一步</button>
</form>