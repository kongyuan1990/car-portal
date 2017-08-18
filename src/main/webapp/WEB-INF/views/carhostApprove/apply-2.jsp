<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div style="font-size: 30px;color: blue;">

	<br/><br/>${msg}<br/><br/>
	<button id="backMain" type="button"  class="btn btn-success " >返回首页</button>
	<button style="display: none;" class="btn btn-default unusebtn"
		url="${ctp}/auth/apply2.html"></button>
</div>

<script>
	$(function(){
		$("#backMain").click(function(){
			location.href="${ctp}/main.jsp";
		});
	});

</script>