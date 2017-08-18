<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet" href="${ctp}/bootstrap-3.3.7//css/bootstrap.min.css">
<link rel="stylesheet" href="${ctp}/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctp}/css/main.css">
<style>
.tree li {
	list-style-type: none;
	cursor: pointer;
}

table tbody tr:nth-child(odd) {
	background: #F4F4F4;
}

table tbody td:nth-child(even) {
	color: #C00;
}
</style>
</head>

<body>
	<div class="container-fluid">
      <div class="row">
      	<!-- 引入菜单管理 -->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">我的车库</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">车库信息
              <div style="float:right;cursor:pointer;" 
              data-toggle="modal" data-target="#myModal">
              <i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
			  
				<form role="form" method="post" id="editForm">
					<div class="form-group">
						<input type="hidden" class="form-control" id="hiddenInput" 
						name="id" value="${carport.id}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputPassword1">车库名称</label>
						<input type="text" class="form-control" id="editLoginacct" 
						name="name" value="${carport.name}"/>
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">地址</label>
						<input type="text" class="form-control" id="editUsername" 
						name="address" value="${carport.address}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputEmail1">总车库</label>
						<input type="email" class="form-control" id="editEmail" 
						name="totalPlace" value="${carport.totalPlace}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputEmail1">剩余车库</label>
						<input type="email" class="form-control" id="editEmail" 
						name="remainingPlace" value="${carport.remainingPlace}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputEmail1">价格（元/小时）</label>
						<input type="email" class="form-control" id="editEmail" 
						name="hourPrice" value="${carport.hourPrice}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputEmail1">价格（元/日）</label>
						<input type="email" class="form-control" id="editEmail" 
						name="dayPrice" value="${carport.dayPrice}"/>
				  	</div>
				  	<div class="form-group">
						<label for="exampleInputEmail1">价格（元/月）</label>
						<input type="email" class="form-control" id="editEmail" 
						name="monthPrice" value="${carport.monthPrice}"/>
				  	</div>
				  		<button uId="${carport.id}" type="button" class="btn btn-success" id="editOkBtn"> 
				  		<i class="glyphicon glyphicon-edit"></i> 确定修改</button>
				 		<button cancelId="${carport.id}" type="button" class="btn btn-success" id="cancelBtn"> 
				  		<i class="glyphicon glyphicon-edit"></i> 取消</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>

	<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
	<script src="${ctp}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script src="${ctp}/script/docs.min.js"></script>
	<script type="text/javascript">
    	$(function(){
    		
    		//给确定修改按钮绑定单击事件
    		$("#editOkBtn").click(function(){
//     			alert("AA");
				var id = $("#hiddenInput").val();
// 				alert(id);
				var fd = $("#editForm").serialize();
				$.ajax({
					url:"http://localhost:8081/car-restapi/carport/editCarport",
					data:fd,
					type:"post",
					processData:false,
					dataType:"json",
					success:function(result){
						layer.msg("修改成功");
					},
					error:function(){
						layer.msg("车库修改失败");
					}
				});
			 window.location.reload();

//     			var fd = $("#editForm").serialize();
//     			$.ajax({
//     				url:"http://localhost:8081/car-restapi/carport/editCarport",
//     				data:fd,
//     				processData:false,
//     				contentType:false,
//     				dataType:"jsonp",
//     				jsonp:"callback",
//     				jsonpCallback:"jsonpCallback",
//     				success:function(result){
//     					layer.msg("修改成功");
//     				},
//     				error:function(){
//     					layer.msg("修改失败");
//     				}
//     			});
    		});
    		
    		
    		//给取消按钮绑定单击事件
    		$("#cancelBtn").click(function(){
    			var carportId = $(this).attr("cancelId");
    			location.href="${ctp}/carport/toCarport?carportId="+carportId
    		});
    	});       
    </script>
</body>
</html>
