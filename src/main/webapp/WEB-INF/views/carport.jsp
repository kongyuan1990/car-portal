<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<link rel="stylesheet"
	href="${ctp}/bootstrap-3.3.7//css/bootstrap.min.css">
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
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					<i class="glyphicon glyphicon-th"></i>我的车库信息
				</h3>
			</div>
			<div class="panel-body">
				<hr style="clear: both;">
				<div class="table-responsive">
					<table class="table  table-bordered">
						<thead>
							<tr>
								<th width="30">#</th>
								<th width="30"><input type="checkbox"></th>
								<th>车库名称</th>
								<th>地址</th>
								<th>总车库</th>
								<th>剩余车库</th>
								<th>价格（元/小时）</th>
								<th>价格（元/日）</th>
								<th>价格（元/月）</th>
								<th width="100">操作</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>${carport.id}</td>
								<td><input type="checkbox"></td>
								<td>${carport.name}</td>
								<td>${carport.address}</td>
								<td>${carport.totalPlace}</td>
								<td>${carport.remainingPlace}</td>
								<td>${carport.hourPrice}</td>
								<td>${carport.dayPrice}</td>
								<td>${carport.monthPrice}</td>
								<td>
									<button uId="${carport.id}" type="button"
										class="btn btn-success btn-xs updateBtn">修改</button>
								</td>
							</tr>
						</tbody>
						<a href="${ctp}/personage/toPersonage.html">返回</a>
					</table>
				</div>
			</div>


			<!-- 车库照片 -->
			<div class="modal-body" id="divId">
				<form id="carportUploadForm" enctype="multipart/form-data" method="post">
					<div class="form-group">
						<label>车库照片</label> <input type="file" name="file"
							id="uploadInput">
					</div>
					<div class="form-group">
						<!--选择的文件展示位  -->
						<div class="row">
							<div class="col-md-12 imgdiv">
								<img src="${ctp}/${carport.picturepath}">
							</div>
						</div>
					</div>
					<input type="hidden" id="carportUploadId" name="carportId" value="${carport.id}" />
					<button type="button" id="carportUploadOkBtn">确定</button>
				</form>
			</div>
		</div>
	</div>

	<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
	<script src="${ctp}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
	<script src="${ctp}/script/docs.min.js"></script>
	<script src="${ctp}/layer/layer.js"></script>
	
	<script type="text/javascript">
		$(function() {
			
			//给我的车库照片绑事件 执行文件上传
			$("#carportUploadOkBtn").click(function(){
				var fd = new FormData($("#carportUploadForm")[0]);
				$.ajax({
					url:"${ctp}/carport/uploadCarportPhone",
					data:fd,
					type:"post",
					dataType:"json",
					contentType:false,
					processData:false,
					success:function(data){
						layer.msg("上传成功");
//  					alert("BB");
						window.location.reload();
					},
					error:function(dates){
						layer.msg("上传失败");
// 						alert("AA");
					}
				});
				
			});
			
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

			//给修改按钮绑定单击事件
			$(".updateBtn").click(
				function(data) {
					//获取button按钮的自定义属性
					var carportId = $(this).attr("uId");

					location.href = "${ctp}/carport/updateCarport?carportId="
							+ carportId;
			});

		});
	</script>
</body>
</html>
