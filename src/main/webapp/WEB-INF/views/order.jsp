<%@page import="com.smartparking.car.manager.bean.TOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="utf-8">
  <head>
    <meta charset="utf-8"">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${ctp }/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctp}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${ctp}/css/main.css">
	<link rel="stylesheet" href="${ctp}/css/doc.min.css">
	<style>
	.tree li {list-style-type: none;cursor:pointer;}
	</style>
	<style type="text/css">
		td { text-align:center;}
	</style>
  </head>

  <body>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="">智能泊车</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<div class="btn-group">
				  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i> 张三 <span class="caret"></span>
				  </button>
					  <ul class="dropdown-menu" role="menu">
						<li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
						<li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
						<li class="divider"></li>
						<li><a href="login.html"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
					  </ul>
			    </div>
			</li>
            <li style="margin-left:10px;padding-top:8px;">
				<button type="button" class="btn btn-default btn-danger">
				  <span class="glyphicon glyphicon-question-sign"></span> 帮助
				</button>
			</li>
          </ul>
          <form class="navbar-form navbar-right">
            <input type="text" class="form-control" placeholder="Search...">
          </form>
        </div>
      </div>
    </nav>
    
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据</div>
			  <div class="panel-body">
			  	<form action="${ctp }/order/pay" method="post">
			  		<c:if test="${not empty msg }">
			  			<div class="form-group">
					    	<input type="text" class="form-control" disabled="disabled" value="${msg }" style="text-align:center;color:red;">
					  	</div>
					  	<%session.removeAttribute("msg"); %>
			  		</c:if>
					<div class="table-responsive">
			            <table class="table  table-bordered">
		              		<tr>
		              		  <td style="width:15%;">订单状态</td>
			                  <td>${order.status }</td>
			                </tr>
			                <tr>
		              		  <td>订单编号</td>
			                  <td>${order.id }</td>
			                </tr>
			                <tr>
		              		  <td>会员名称</td>
			                  <td>${order.memberId }</td>
			                </tr>
			                <tr>
		              		  <td>停车开始时间</td>
			                  <td><fmt:formatDate value="${order.parkingTime }" pattern="yyyy年MM月dd hh:mm:ss" type="date" dateStyle="long"/></td>
			                </tr>
			                <tr>
		              		  <td>离开停车场时间</td>
			                  <td><fmt:formatDate value="${order.leavingTime}" pattern="yyyy年MM月dd hh:mm:ss" type="date" dateStyle="long"/></td>
			                </tr>
			                <tr>
		              		  <td>总时间</td>
			                  <td><fmt:formatDate value="${order.totalTime }" pattern="yyyy年MM月dd hh:mm:ss" type="date" dateStyle="long"/></td>
			                </tr>
			                <tr>
		              		  <td>停车价格（元/时）</td>
			                  <td>${order.price }</td>
			                </tr>
			                <tr>
		              		  <td>停车场名称</td>
			                  <td>${order.cartportId }</td>
			                </tr>
			                <tr>
		              		  <td>商家名称</td>
			                  <td>${order.portownerId }</td>
			                </tr>
			                <tr>
		              		  <td>总金额</td>
			                  <td>${order.totalPrice }</td>
			                </tr>
			            </table>
		          </div>
		          <input disabled="disabled" class="btn btn-default"  style="float:right;margin-left:10px;" type="submit" value="投诉">
				  <input type="submit" class="btn btn-default"  style="float:right;margin-left:10px;" value="确认结算">
				</form>
				
			  </div>
			</div>
        </div>
      </div>
    </div>
	
    <script src="${ctp }/jquery/jquery-2.1.1.min.js"></script>
    <script src="${ctp }/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script src="${ctp }/script/docs.min.js"></script>
        <script type="text/javascript">
            $(function () {
			   
            });
        </script>
  </body>
</html>
