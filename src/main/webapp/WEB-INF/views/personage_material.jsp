<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet"
	href="${ctp}/bootstrap-3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctp}/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctp}/css/theme.css">
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
			<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
				<div class="container">
					<div class="navbar-header">
						<a class="navbar-brand" style="font-size: 32px;">个人信息
							-${user.name}的个人空间 - 智能停车</a>
					</div>
				</div>
			</nav>
		</div>
	</div>

	<div class="container theme-showcase" role="main">
		<div class="page-header">
			<h1>法人代表资料</h1>
		</div>

		<form role="form" id="carForm" style="margin-top: 20px;">
			<div class="form-group">
				<input type="hidden" name="id" value="${user.id}"/>
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">姓名</label> <input type="text"
					style="width: 400px" class="form-control" id="exampleInputEmail1"
					name="name" value="${user.name}">
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">昵称</label> <input type="text"
					style="width: 400px" class="form-control" id="exampleInputEmail1"
					name="account" value="${user.account}">
			</div>
			<div class="form-group">
				<label for="exampleInputEmail1">性别</label> <%-- <input type="text"
					style="width: 400px" class="form-control" id="exampleInputEmail1"
					name="gender" value="${user.gender eq 1? '男':'女'}"> --%>
					<input type="radio" name="gender" value="0" <c:if test="${user.gender == 0 }">checked="checked"</c:if>/>女
					
					<input type="radio" name="gender" value="1" <c:if test="${user.gender == 1 }">checked="checked"</c:if>/>男
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">邮箱</label> <input type="text"
					style="width: 400px" class="form-control"
					id="exampleInputPassword1" name="email" value="${user.email}">
			</div>
			<div class="form-group">
				<label for="exampleInputPassword1">电话号码</label> <input type="text"
					style="width: 400px" class="form-control"
					id="exampleInputPassword1" name="phoneNumber"
					value="${user.phoneNumber}">
			</div>
			<div class="form-group">
				<button id="updateBtn">保存修改</button>
			</div>
		</form>

		<hr />

		<div class="modal-body">
			<form id="uploadForm" enctype="multipart/form-data" method="post">
				<div class="form-group">
					<label>头像</label> 
					<input type="file" name="file" id="uploadInput">
				</div>
				<div class="form-group">
					<!--选择的文件展示位  -->
					<div class="row">
						<div class="col-md-12 imgdiv">
							<img src="${ctp}/${user.iconpath }">
						</div>
					</div>
				</div>
				<input type="hidden" id="uploadUId" name="id" value="${user.id}"/>
				<button type="button" id="uploadOkBtn">确定</button>
			</form>
		</div>

		<hr>

		<div class="col-right">
			<label for="exampleInputPassword1">我的钱包</label>
			<p class="text-gray">账户余额：${wallet.balance}元</p>
			<div class="account-balance clearfix">
				<div class="relative">
					充值:<input type="text" id="inputRechargeBtn" wId="${wallet.id}"
						style="width: 50px" />
					<button id="OKBtn">确定</button>
					<br /> 提现:<input type="text" id="inputDepositBtn"
						wId="${wallet.id}" style="width: 50px" />
					<button class="OKClass">确定</button>
				</div>
			</div>
		</div>
		
		<hr>
		
		<div>
			<button carportId="${user.carportId}" type="submit"
				class="btn btn-success carportBtn">我的车库</button>
		</div>


	</div>
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
	<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
	<script src="${ctp}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script src="${ctp}/js/docs.min.js"></script>
	<script src="${ctp}/layer/layer.js"></script>
	
	<script type="text/javascript">
	//页面加载完成之后
	$(function(){
		
		//给文件上传确定按钮绑定单击事件
		$("#uploadOkBtn").click(function(){
			var fd = new FormData($("#uploadForm")[0]);
			$.ajax({
				url:"${ctp}/personage/uploadFile",
				type:"post",
				dataType:"json",
				data:fd,
				processData:false,
				contentType:false,
				success:function(data){
					layer.msg("上传成功");
// 					console.log(data);
					var wqe = data.content.iconpath;
// 					alert(wqe);
					window.location.reload();	
						
				},
				errror:function(data){
					
					alert("BB");
				}
			});
			
		});
		
		//给文件选择项绑定单击事件
		$("#uploadInput").change(function(event){
			var files = event.target.files;
			var file;
			if(files && files.length > 0){
				file = files[0];
			}
			var reg = /image*/;
			if(!reg.test(file.type)){
				$(this).val("");
				return false;
			}
			var URL = window.URL || window.webkitURL;
			//创建一个临时的url地址
            var imgURL = URL.createObjectURL(file);
            
			$(this).parent(".form-group")
				.next(".form-group").find(".imgdiv")
				.append("<img src='"+imgURL+"' style='width:200px;height:200px;'/>");
		});
		
		
		//给保存修改按钮绑定单击事件
		$("#updateBtn").click(function(){
			var mydata=$("#carForm").serialize();
			$.ajax({
				url:"http://localhost:8081/car-restapi/persionage/updatePersonage",
				data:mydata,
				processData:false,
				type:"post",
				dataType:"json",
				success:function(result){
					console.log(result);
					layer.msg("修改成功");
					
				},
				error:function(){
					
					console.log(result);
					layer.msg("修改失败");
				}
			});
				
		});
		
		
		//给我的车库绑定单击事件
		$(".carportBtn").click(function(){
			var carportId = $(this).attr("carportId");
			location.href="${ctp}/carport/toCarport?carportId="+carportId;
		});
		
		
		//给提现按钮绑定单击事件
		$(".OKClass").click(function(){
			var value = $("#inputDepositBtn").val();
			var wId = $("#inputDepositBtn").attr("wId");
			$.get("${ctp}/personage/lessenMoney?value="+value+"&wId="+wId,
					function(msg){
				 layer.msg("提现成功");
				
				}
			);
			$("#inputDepositBtn").val("");
			 window.location.reload();
		});
		
		
		//给充值按钮绑定单击事件
		$("#OKBtn").click(function(){
			var value = $("#inputRechargeBtn").val();
			var wId = $("#inputRechargeBtn").attr("wId");
			$.ajax({
				url:"http://localhost:8081/car-restapi/wallet/addMoney?value="+value+"&wId="+wId,
				data:value,
				type:"get",
				processData:false,
				dataType:"json",
				success:function(jsonpCallback){
					layer.msg("充值成功",function(){
						
					window.location.reload();
					});
				},
				error:function(){
					layer.msg("充值失败");
				}
			});
		});
	});
	</script>
</body>
</html>