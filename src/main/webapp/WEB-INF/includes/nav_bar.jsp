<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-default" style="color: black;">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="${ctp}/main.jsp" style="font-size: 32px;">智能泊车</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
			<c:if test="${empty loginUser }">
				<li><a href="${ctp}/#">注册</a></li>
				<li><a href="${ctp}/#">登录</a></li>
				
				
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"  >个人中心 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="${ctp}/member/carcenter.html">个人中心</a></li>
						<li><a href="${ctp}/#">退出</a></li>
						
					</ul></li>
			</c:if>
			
			<c:if test="${!empty loginUser }">
				<li class="dropdown"><a href="${ctp}/#" class="dropdown-toggle"
					data-toggle="dropdown" >个人中心 <span class="caret"></span></a>
					<!-- role="button" aria-haspopup="true"
					aria-expanded="false" -->
					<ul class="dropdown-menu">
						<li><a href="${ctp}/member/carcenter.html">个人中心</a></li>
						<li><a href="${ctp}/#">退出</a></li>
						
					</ul></li>
			</c:if>	
				
			</ul>
		</div>
	</div>
</nav>