<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <div>${msg }</div> --%>
<%-- <c:remove var="${request.msg }" /> --%>
<%-- <div>${msg }</div> --%>
<form class="infoForm" role="form" style="margin-top: 20px;"
	url="${ctp}/portownerApprove/apply.html">
	<div class="form-group">
		<label for="exampleInputEmail1">停车厂名</label> <input type="text" 
			class="form-control" name="name"  value="${cartPort.name }" placeholder="请输入停车厂名">
	</div>

	<div class="form-group">
		<label for="exampleInputPassword1">停车厂地址</label> <input name="address"
			type="text" class="form-control" id="exampleInputPassword1" value="${cartPort.address }" 
			placeholder="请输入停车厂地址">
	</div>

	<div class="form-group">
		<label for="exampleInputPassword1">停车厂总车位</label> <input
			name="totalPlace" type="text" class="form-control" value="${cartPort.totalPlace }" 
			id="exampleInputPassword1" placeholder="请输入停车厂总车位">
	</div>

	<div class="form-group">
		<label for="exampleInputPassword1">小时停车价格</label> <input name="price" value="${cartPort.price }" 
			type="text" class="form-control" id="exampleInputPassword1"
			placeholder="请输入小时停车价格">
	</div>

	<div class="form-group">
		<label for="exampleInputPassword1">所在城市</label> <input
			name="addressCity" type="text" class="form-control" value="${cartPort.addressCity }" 
			id="exampleInputPassword1" placeholder="请输入所在城市">
	</div>



	<!-- 上一步是来到账户选择页面 -->
	<button type="button" url="${ctp}/portownerApprove/apply.html"
		class="btn btn-default unusebtn">上一步</button>
	<!-- 下一步是来到资质文件上传页面 -->
	<button type="button" style="display: none"
		url="${ctp}/portownerApprove/apply1.html"
		class="btn btn-success unusebtn"></button>

	<button type="button" url="${ctp}/portownerApprove/apply2.html"
		class="btn btn-success unusebtn">下一步</button>
</form>