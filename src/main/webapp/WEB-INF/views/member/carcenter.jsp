<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>个人中心</title>
<link rel="stylesheet" href="${ctp}/css/bootstrap.min.css" />
<link href="${ctp}/css/forward_201503262210.css" type="text/css"
	rel="stylesheet" />
<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
<script src="${ctp}/layer/layer.js"></script>
<script src="${ctp}/js/bootstrap.min.js"></script>


</head>
<body>
	<%@include file="/WEB-INF/includes/nav_bar.jsp" %>
	<div class="wash-paper clearfix" id="profile">
		<%@include file="/WEB-INF/includes/side_bar.jsp" %>
		<div class="main-content">
			<div class="content-header">
				<h2>个人中心</h2>
			</div>
			<div class="content-inner profile-index">
				<div class="account-status clearfix">
					<div class="clearfix">
						<div class="col-left">
							<div class="avatar" >
								<a href="${ctp}/member/portrait.html">上传<br />头像
								</a><img src="${ctp}/${user.iconpath}" />
							</div>
							<div class="safety-level-wrapper">
								<h2>${user.name }</h2>
								<h5><button type="button" style="background:orange" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
								  编辑资料
								</button></h5>
							</div>
						</div>
						<div class="col-right">
							<p >账户余额：</p>
							<c:if test="${wallet.balance<10 }" >
								<p class="textgray" style="color:red;font-size:16px;">您的余额已不足10元，请及时充值！！！</p>
							</c:if>
							
							<div class="account-balance clearfix">
								<div class="balance">
									<strong class=walletmoney>${wallet.balance }</strong> 元
								</div>
								<div class="relative">
									<div id="tool-kit-step1" class="toolkit-charge hide">
										<span id="step1_cancel" class="toolkit-close">&times;</span>
									</div>
									<button type="button" style="background:yellow" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#addModal">
									 充值
									</button>
									<button type="button" style="background:yellow" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#delModal">
									 提现
									</button>
								</div>
							</div>
						</div>
					</div>
					<ul class="related-info clearfix "> 
			         <li class="setedit"> <i class="icon-point"></i>性别： ${user.gender eq 1?"男":"女" }</li> 
			         <li class="setedit"> <i class="icon-point"></i>昵称：  ${user.account } </li> 
			         <li class="setedit"> <i class="icon-point"></i>手机号：${user.phoneNumber }</li> 
			         <li class="setedit"> <i class="icon-point"></i>我的车辆： ${user.carNumber }</li> 
			        </ul> 
				</div>
				<div class="latest-orders tab_wrapper">
					<ul class="tab_header">
						<li role="presentation" class="active">我的停车卡</li>
						<li role="presentation" >历史订位单<span class="tip">${cards.size() }</span></li>
					</ul>
					<div class="tab_body">
						<div class="food-orders">
							<table>
								<thead>
									<tr>
										<th>订单号号</th>
										<th>下单时间</th>
										<th>车库名</th>
										<th>车卡类型</th>
										<th>订单状态</th>
									</tr>
								</thead>
								<tbody>
								
									
									<c:forEach items="${ cards}" var="card">
									
										<c:if test="${card.leavingTime==null }">
											<tr>
												<td class="sn"><a
													href="#"
													target="_blank">${card.id }</a></td>
													
												<td class="time"><fmt:formatDate value="${card.parkingTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
												<td class="restaurant">${card.carportName  }</td>
												<td>时卡</td>
												<td class="status"><span class=" gray">有效</span>
												</td>
											</tr>
										</c:if>
										
									</c:forEach>
									
								</tbody>
							</table>
						</div>
						<div class="deal-orders hide">
							<a class="more" href="${ctp}/member_schedule.html">更多历史订单&gt;&gt;</a>
							<table>
								<thead>
									<tr>
										<th>订单号</th>
										<th>创建时间</th>
										<th>结束时间</th>
										<th>交易金额</th>
										<th>停车场</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${ cards}" var="card">
										
										<tr>
											<td >${card.id }</td>
											<td class="type"><fmt:formatDate value="${card.parkingTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td class="time"><fmt:formatDate value="${ card.leavingTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											<td class="price amount"><span class="green">${ card.price}</span></td>
											<td class="status readable-status"><span>${card.carportName }</span> <br />
											</td>
										</tr>
									</c:forEach>
								
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" style="width:500px" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">编辑资料</h4>
	      </div>
	      <div class="modal-body">
				
				<form class="form-horizontal" method="post" id="change_edit">
					<fieldset>
						<div class="control-group clear-fix">
							<label class="control-label" for=""><span
								class="required">*</span>昵称</label>
							<div class="controls">
								<input name="account" value="${user.account }"
									type="text" />
							</div>
						</div>
						
						<div class="control-group">
							<label class="control-label" for=""><span
								class="required">*</span>性别</label>
							<div class="controls">
								<select name="gender"> 
									<option value="1">男</option> 
									<option value="0">女</option> 
								</select>
							</div>
						</div>
						<div class="control-group">
							<label class="control-label" for=""><span
								class="required">*</span>手机号</label>
							<div class="controls">
								<input name="phoneNumber" value="${user.phoneNumber }"
									type="text" />
							</div>
						</div>
						<div class="control-group clear-fix">
							<label class="control-label" for=""><span
								class="required">*</span>车辆信息</label>
							<div class="controls">
								<input name="carNumber"
									value="${user.carNumber }" type="text" />
							</div>
						</div>
					</fieldset>
				</form>
				
					     
   
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	        <button type="button" class="btn btn-primary savebtn">保存</button>
	      </div>
	    </div>
	  </div>
	</div> 
	
	
	
	<div class="modal" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" style="width:500px" role="document">
	    <div class="modal-content">
	      <div class="modal-body">
				
				<div class="main-content">
				<div class="content-header">
					<h2>充值详情</h2>
				</div>
				<div class="content-inner">
					
					<form id="charge_add_form" name="alipayment" action="${ctp}/member/toaddmoney" method="post"
						target="_blank">
						<div class="charge-panel clearfix">
						<h5 class="title">输入金额：</h5>
						<div class="charge_value">
							<span ><input type="text" id="addmoney" name="money"> 元</span>
						</div>
					</div>
						<div id="body">
							<input name="total_fee" id="charge_fee" type="hidden" value="300" />
							<input name="csrf_token" id="csrf_token" type="hidden"
								value="f8fad6e4510afe5fbd48dc5206d213175bf57c1f" />
							<p>第三方支付：</p>
							<div class="common_charge">
								<label><input type="radio" name="pay_bank"
									value="directPay"  /><img
									src="${ctp}/img/alipay.gif" /></label><!-- checked="" -->
							</div>
							<div class="common_charge">
								<label><input type="radio" name="weixin_bank"
									value="directPay" /><img
									src="${ctp}/img/weixin.gif" /></label><!-- checked=""  -->
							</div>

						</div>
						<div class="form-actions clearfix">
							<button class="btn btn-yellow toaddmoney" data-toggle="modal"
								type="button" id="charge_add_btn">确认付款</button>
						</div>
					</form>

				</div>
			</div>	     
   
	      </div>
	    </div>
	  </div>
	</div> 
	
	
	<div class="modal" id="delModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" style="width:500px" role="document">
	    <div class="modal-content">
	      <div class="modal-body">
				
				<div class="main-content">
				<div class="content-header">
					<h2>提现详情</h2>
				</div>
				<div class="content-inner">
					
					<form id="charge_del_form" name="alipayment" action="${ctp}/member/todelmoney" method="post"
						target="_blank">
						<div class="charge-panel clearfix">
						<h5 class="title">提现金额：</h5>
						<div class="charge_value">
							<span ><input type="text" id="delmoney" name="money"> 元</span>
							<span  style="color:#F00"> ${ error } </span>
						</div>
					</div>
						<div id="body">
							<input name="total_fee" id="charge_fee" type="hidden" value="300" />
							<input name="csrf_token" id="csrf_token" type="hidden"
								value="f8fad6e4510afe5fbd48dc5206d213175bf57c1f" />
							<p>提现账户类型：</p>
							<div class="common_charge">
								<label><input type="radio" name="pay_bank" 
									value="directPay"  /><img
									src="${ctp}/img/alipay.gif" /></label>
							</div>
							<div class="common_charge">
								<label><input type="radio" name="weixin_bank"
									value="directPay" /><img
									src="${ctp}/img/weixin.gif" /></label>
							</div>

						</div>
						<div class="form-actions clearfix">
							<button class="btn btn-yellow toaddmoney" data-toggle="modal"
								type="button" id="charge_del_btn">确认提现</button>
						</div>
					</form>

				</div>
			</div>
   
	      </div>
	    </div>
	  </div>
	</div> 
	
	
	<script type="text/javascript">
		$(function(){
			$("#charge_del_btn").click(function(){
				if($("#delmoney").val().trim()!=""&&$("#delmoney").val().trim()>0){
					var params = $("#charge_del_form").serialize();
					$.ajax({
						url:"${ctp}/member/todelmoney",
						type:"post",
						data:params,
						success:function(result){
							if(result.msg==""&&result.content.balance<10){
								$(".textgray").empty().append("<p style='color:red;font-size:16px;'>您的余额已不足10元，请及时充值！！！</p>");
								$(".walletmoney").empty().append(result.content.balance);
								$("#delModal").modal("hide");
								layer.msg("提现成功");
							}else if(result.msg==""&&result.content.balance>=10){
								$(".walletmoney").empty().append(result.content.balance);
								$("#delModal").modal("hide");
								layer.msg("提现成功");
							}else{
								layer.msg(result.msg);
							}
						},
						error:function(e){
							layer.msg("提现失败");
						}
					});
					
				}else{
					layer.msg("请输入正确的提现金额");
					//alert("请输入正确的提现金额");
				}
			});
			
			$("#charge_add_btn").click(function(){
				if($("#addmoney").val().trim()!=""&&$("#addmoney").val().trim()>0){
					var params = $("#charge_add_form").serialize();
					$.ajax({
						url:"${ctp}/member/toaddmoney",
						type:"post",
						data:params,
						success:function(result){
							if(result.content.balance>=10){
								$(".textgray").empty()
							}
							$(".walletmoney").empty().append(result.content.balance);
							$("#addModal").modal("hide");
							layer.msg("充值成功");
						},
						error:function(e){
							layer.msg("充值失败");
						}
					});
				}else{
					layer.msg("请输入正确的充值金额");
				}
			});
			
			
			$("body").on("click",".savebtn",function(){
				var params = $("#change_edit").serialize();
				$.post(
					"${ctp}/member/editinformation",
					params,
					function(data){
						$(".setedit:eq(0)").empty().append("<i class='icon-point'></i>性别："+ (data.gender==1?"男":"女"));
						$(".setedit:eq(1)").empty().append("<i class='icon-point'></i>昵称："+ data.account);
						$(".setedit:eq(2)").empty().append("<i class='icon-point'></i>手机号："+ data.phoneNumber);
						$(".setedit:eq(3)").empty().append("<i class='icon-point'></i>我的车辆："+ data.carNumber);
					}
				);				
				$("#myModal").modal("hide");
			});
			
			
			$("li[role='presentation']").first().click(function(){
				$(this).addClass("active").siblings("li[role='presentation']").removeClass("active");
				$(".food-orders").removeClass("hide")
				$(".deal-orders").addClass("hide");
			});
			$("li[role='presentation']").last().click(function(){
				$(this).addClass("active").siblings("li[role='presentation']").removeClass("active");
				$(".deal-orders").removeClass("hide");
				$(".food-orders").addClass("hide");
				
			});
		});
	</script>
	<%@include file="/WEB-INF/includes/footer.jsp"%>
	
</body>
</html>