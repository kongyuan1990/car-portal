<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />  
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 	
		<title></title>
		<link rel="stylesheet" href="${ctp}/bootstrap-3.3.7/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${ctp}/bootstrap-3.3.7/css/bootstrap-theme.min.css" />
		<script src="${ctp}/js/jquery-2.1.1.min.js"></script>
		<script src="${ctp}/bootstrap-3.3.7/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=ldtzoSSSCO7TPae0qTHYbRQs38OOBe7m"></script>
	</head>

	<body>
		<nav class="navbar navbar-default" style="color: black;">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
					<span class="navbar-brand" href="#">智能泊车</span>
				</div>

				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#">注册</a></li>
						<li><a href="#">登录</a></li>
						<li class="dropdown">
							<a href="${ctp}/#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">个人中心 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="${ctp}/personage/toPersonagePage">个人资料</a></li>
								<li><a href="#">Another action</a></li>
								<li><a href="#">Something else here</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="#">Separated link</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-5">
				<form class="navbar-form navbar-left" role="search">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="输入停车位置">
					</div>
					<button type="submit" class="btn btn-default">提交</button>
				</form>
			</div>
			<div class="col-md-5">
				<p class="text-center">当前位置:<span class="icon-bar">北京市</span><a>[切换位置]</a></p>
			</div>
			<div class="col-md-1"></div>
		</div>

		<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-5">
			<div style="width:700px;height:550px;border:#ccc solid 1px;font-size:12px" id="map"></div>
		</div>
		<div class="col-md-5">
	
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-8">
			<div class="thumbnail">
			<ul class="nav nav-pills">
				<li role="presentation" class="active"><a href="#">距离最近</a></li>
				<li role="presentation"><a href="#">价格最低</a></li>
				<li role="presentation"><a href="#">服务最好</a></li>
			</ul>
			</div>
		</div>
		<div class="col-md-1"></div>
	</div>

	<div class="row">
		<div class="col-sm-6 col-md-3">
		</div>
		<div class="col-sm-5 col-md-8">
			<div class="thumbnail">
				<img src="img/a.jpg" alt="...">
				<div class="caption">
					<h3>西部硅谷</h3>
					<p>距离：10米  车位：10个  价格：5元/小时</p>
					<p>可月租，可时租</p>
					<p><a href="#" class="btn btn-default" role="button">预约</a></p>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-1"></div>
	</div>
	<div class="row">
		<div class="col-sm-6 col-md-3">
		</div>
		<div class="col-sm-5 col-md-8">
			<div class="thumbnail">
				<img src="img/a.jpg" alt="...">
				<div class="caption">
					<h3>西部硅谷</h3>
					<p>距离：10米  车位：10个  价格：5元/小时</p>
					<p>可月租，可时租</p>
					<p><a href="#" class="btn btn-default" role="button">预约</a></p>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-1"></div>
	</div>
	<div class="row">
		<div class="col-sm-6 col-md-3">
		</div>
		<div class="col-sm-5 col-md-8">
			<div class="thumbnail">
				<img src="img/a.jpg" alt="...">
				<div class="caption">
					<h3>西部硅谷</h3>
					<p>距离：10米  车位：10个  价格：5元/小时</p>
					<p>可月租，可时租</p>
					<p><a href="#" class="btn btn-default" role="button">预约</a></p>
				</div>
			</div>
		</div>
		<div class="col-sm-6 col-md-1"></div>
	</div>

	

	<div class="row">
		<div class="col-md-1"></div>
		<div class="col-md-10">
			<p class="text-left"><a>更多信息</a></p>
		</div>
		<div class="col-md-1"></div>
	</div>
		</div>
		<div class="col-md-1"></div>
	</div>
		
		
	</body>
	<script type="text/javascript">
	window.onload=function(){
		 //创建和初始化地图函数：
	    function initMap(){
	      createMap();//创建地图
	      setMapEvent();//设置地图事件
	      addMapControl();//向地图添加控件
	      addMapOverlay();//向地图添加覆盖物
	    }
	    function createMap(){ 
	      map = new BMap.Map("map"); 
	      map.centerAndZoom(new BMap.Point(113.844503,22.632012),15);
	    }
	    function setMapEvent(){
	      map.enableScrollWheelZoom();
	      map.enableKeyboard();
	      map.enableDragging();
	      map.enableDoubleClickZoom()
	    }
	    function addClickHandler(target,window){
	      target.addEventListener("click",function(){
	        target.openInfoWindow(window);
	      });
	    }
	    function addMapOverlay(){
	      var markers = [
	        {content:"我的备注",title:"我的标记",imageOffset: {width:0,height:3},position:{lat:22.63448,lng:113.841557}}
	      ];
	      for(var index = 0; index < markers.length; index++ ){
	        var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
	        var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap/images/icon.png",new BMap.Size(20,25),{
	          imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
	        })});
	        var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(25,5)});
	        var opts = {
	          width: 200,
	          title: markers[index].title,
	          enableMessage: false
	        };
	        var infoWindow = new BMap.InfoWindow(markers[index].content,opts);
	        marker.setLabel(label);
	        addClickHandler(marker,infoWindow);
	        map.addOverlay(marker);
	      };
	    }
	    //向地图添加控件
	    function addMapControl(){
	      var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
	      scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
	      map.addControl(scaleControl);
	      var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
	      map.addControl(navControl);
	      var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
	      map.addControl(overviewControl);
	    }
	    var map;
	      initMap();
	}
   
  </script>
</html>