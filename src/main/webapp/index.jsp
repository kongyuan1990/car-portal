<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智能泊车</title>
<link rel="stylesheet"
	href="${ctp}/plugin/bootstrap-3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="${ctp}/plugin/bootstrap-3.3.7/css/bootstrap.min.css" />
<script src="${ctp}/plugin/jquery-2.1.1.min.js"></script>
<script src="${ctp}/plugin/bootstrap-3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=40GWXiduhOft266lK4N1dopL">
</script>

<style type="text/css">
	a{color:black; text-decoration: none;}
	a:hover{ color:#03C; text-decoration:none;} 
	.icon-bar{border: 1px solid #fff;}
	/* .navbar{background:#1D89E1;} */
	.navbar .navbar-brand,.navbar .navbar-brand:hover{color:black;}
	.navbar li a{color: #fff;}
	/* .navbar li.active a{background:#fff;color: #d9534f;font-weight: bold} */
	.navbar li.dropdown .dropdown-toggle{background: #1D89E1;}
	.navbar li.dropdown .dropdown-menu{background: #1D89E1;}
	.navbar li.dropdown .dropdown-menu li a:hover{background:red;}
	.anchorBL{display:none;}
</style>
 

</head>
<body style="background-color: #F7F7F7">
	<nav class="navbar navbar-default">  
        <div class="container-fluid">  
            <div class="navbar-header">  
                <a class="navbar-brand" href="#">智能泊车</a> 
                <span class="navbar-brand" style="color: green;">美好生活 泊车无忧</span>   
            </div>  
            <div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right" style="margin-right: 10px;">
					<li><a href="#" class="navbar-link">注册</a></li>
					<li><a href="#">登录</a></li>
					<li><a href="#">车场入驻</a></li>
				</ul>
			</div> 
        </div>  
    </nav>  
   
    <div class="row">
		<div class="col-md-12 glyphicon glyphicon-hand-right" style="text-align: center;margin-top: 20px;margin-bottom: 25px;">
			<a href="${ctp}/carport/list"><span style="font-size: 24px;color:black;">我 要 停 车</span></a>
		</div>
	</div>
	<a href="${ctp }/order/orderdetails?orderId=1">toOrderDetails</a>
	<h3>${msg}</h3>
	
	
	<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
			
				<div class="navbar-form navbar-left" role="search">
					<div class="form-group">
					<input type="text" id="searchId" name="searchPlaceName" size="20" value="百度" style="width:150px;" placeholder="请输入停车位置"/>
					</form>
					</div>
					
					
					<div id="searchResultId" style="border:1px solid #C0C0C0;width:150px;height:auto; display:none;"></div>
					<input type="text" readonly="readonly"  id="pointInput"
				style="display: inline-block; background: #EBEBE4; border: #7F9DB9 solid 1px; color: #555; width: 160px; height: 30px; line-height: 30px; font-size: 14px; font-weight: 700">
				</div>
				
				
			<div class="col-md-3">
				<p class="text-center">当前位置:
			<span id="currentCityId"  class="icon-bar">${currentCity == null?"北京市":currentCity}</span><br/>
			<span id="myAdressId"  class="icon-bar">${myAdress == null?"北京市东城区东长安街":myAdress} </span>
			</p>
			</div><button id="changePlace">更改位置</button>
			</div>
	</div>

	<!-- 地图展示 -->
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<div id="allmap"
				style="width: 800px; height: 400px; border: #ccc solid 1px; font-size: 12px">
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>
	
	<!-- 页尾 -->
	<div class="row" style="text-align: center;margin-top: 10px;">
		<div class="col-md-12"><a href="#">智能停车 copyritht2016-2018</a></div>
	</div>
		
</body>
	<!-- 地图功能需要Start------------------------------------------------------------------- -->
	<!-- 模态框（Modal） -->  
	<div class="modal fade" id="changePlaceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">  
	    <div class="modal-dialog">  
	        <div class="modal-content">  
	            <div class="modal-header">  
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>  
	                <h4 class="modal-title" id="myModalLabel">修改当前地址</h4>  
	            </div>  
	            <div class="form-group">
	            <form  id="changePlaceForm" method="post">
	            	当前城市：<input type="text" name="currentCity" id="currentCity_input"/>  
	            	具体地址：<input type="text" name="myAdress" id="myAdress_input"/>   
	            </form>
	            </div>
	            <div class="modal-footer">  
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
	                <button type="button" class="btn btn-primary" onclick="update()">提交更改</button>  
	            </div>  
	        </div>  
	        <!-- /.modal-content -->  
	    </div>  
	    <!-- /.modal -->  
	</div>  
	<!-- 模态框（Modal）end -->  
	<!-- 引入我的地图js -->
	<script type="text/javascript" src="${ctp}/map/mymap.js"></script>
	<script type="text/javascript">
	// 	initMap(mapId,level,myAdress,currentCity)
	//参数：地图的id(String),,地图显示级别(int),当前地址(String),当前城市设置(String);
	initMap("allmap",11, $("#myAdressId").html(), $("#currentCityId").html());
	scaleControl();//添加标尺
	mapTypeControl();//添加三维图
	//marker(116.468534,39.922194,8);//创建标注(方法已经舍弃)
	getlongitudelatitude($("#pointInput"));//获取经纬度
	searchPoint("searchId","searchResultId");//搜搜索栏
	
	
	
	//新增标注点因该是商家提交车库信息时，调用此函数并且存入数据库
// 	geocoder(myAdress,myCity,parkingNumber);
//	geocoder("北京市朝阳区东三环中路9号富尔大厦","北京市",18);//正向地址解析,新增的标注点
//	geocoder("深圳宝安国际机场4层","深圳市",9);//正向地址解析,新增的标注点
//	geocoder("宝安区草围社区宝安大道5010号","深圳市",10);//正向地址解析,新增的标注点
//	geocoder("湖北省武汉市硚口区中山大道215号","武汉市",14);//正向地址解析,新增的标注点
	
	
	$(function() {
		$.ajax({
			   type: "post",
			   url: "${ctp}/map/getAllMapsData",
			   success: function(mapList){
				   $.each(mapList, function(index,value){  
					 	//geocoder("地址","城市",剩余车位数,车库号);
					   geocoder(value.address,value.addressCity,value.remainingPlace,value.id);
					 }); 
				   
			   }
		});
		

	});
	
	
	
	</script>
	<script type="text/javascript">
	$("#changePlace").click(function(){
		
		$("#changePlaceModal").modal('show');
		
	});
	
	function update() {
		$("#changePlaceModal").modal('hide');
		var mydata=$("#changePlaceForm").serialize();
		console.log(mydata)
		$.ajax({
			   type: "post",
			   url: "${ctp}/map/getChangePlace",
			   data: mydata,
			   success: function(msg){
				//console.log(msg);
				$("#currentCityId").html(msg.currentCity);
				$("#myAdressId").html(msg.myAdress);
				location.reload();
			   }
		});
	}

	</script>
	<!-- 地图功能需要End------------------------------------------------------------------- -->
</html>