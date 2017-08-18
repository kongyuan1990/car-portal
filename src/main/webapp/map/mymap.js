var map;
var pointA;
//初始化显示地图
function initMap(mapId,level,myAdress,currentCity) {
	map = new BMap.Map(mapId);  // 创建Map实例
	var myGeo = new BMap.Geocoder();
	// 将地址解析结果显示在地图上,并调整地图视野
	myGeo.getPoint(myAdress, function(point){
		if (point) {
			pointA=point;
			map.centerAndZoom(pointA, level);  // 初始化地图,设置中心点坐标和地图级别
			map.setCurrentCity(currentCity);          // 设置地图显示的城市 此项是必须设置的
			map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
			myIcon(point);//增加自定义图片
//			marker(longitude,latitude);//创建标注
		}
	}, currentCity);	
}
//添加标尺
function scaleControl() {
	var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	/*缩放控件type有四种类型:
	BMAP_NAVIGATION_CONTROL_SMALL：仅包含平移和缩放按钮；
	BMAP_NAVIGATION_CONTROL_PAN:仅包含平移按钮；
	BMAP_NAVIGATION_CONTROL_ZOOM：仅包含缩放按钮*/
	map.addControl(top_left_control);        
	map.addControl(top_left_navigation);  
}
   
//添加三维图
function mapTypeControl() {
	//添加三维图
	var mapType2 = new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_RIGHT});
	map.addControl(mapType2);          //默认地图控件
	map.addControl(new BMap.OverviewMapControl());//添加默认缩略地图控件  
	
}
//增加自定义图片
function myIcon(mPoint) {
	var point = mPoint;
	
	 var myIcon = new BMap.Icon("http://api.map.baidu.com/img/markers.png", new BMap.Size(23, 25), {  
         offset: new BMap.Size(10, 25), // 指定定位位置  
         imageOffset: new BMap.Size(0, 0 - 10 * 25) // 设置图片偏移  
     });  
	
	//创建小狐狸
//	var myIcon = new BMap.Icon("http://lbsyun.baidu.com/jsdemo/img/fox.gif", new BMap.Size(300,157));
	var marker2 = new BMap.Marker(point,{icon:myIcon});  // 创建标注
	marker2.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	map.addOverlay(marker2);              // 将标注添加到地图中
}

//创建标注
function marker(longitude, latitude,parkingNumber) {
	var value=parkingNumber;
//	var value = (prompt("请输入数字，10000以内")+"") || "2222";
	var point = new BMap.Point(longitude, latitude);
	var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	marker.setIcon(new BMap.Icon('http://map.baidu.com/newmap/static/common/images/mk_14e51b4.gif',new BMap.Size(34,24),{
	    imageOffset:new BMap.Size(0,(value.length-1)*-30) 
	  }))

	    var label = new BMap.Label(value,{offset:new BMap.Size(3,0)});
	  label.setStyle({
	    background:'none',color:'#fff',border:'none'
	  });
	marker.setLabel(label);
	revealGeocoder(point);
}	



//标注点信息
function message(point,marker,mytitle,myAdress) {
	var opts = {
	  width : 400,     // 信息窗口宽度
	  height: 100,     // 信息窗口高度
	  title : mytitle , // 信息窗口标题
	}
	var infoWindow = new BMap.InfoWindow(myAdress, opts);  // 创建信息窗口对象 
	marker.addEventListener("click", function(){          
		map.openInfoWindow(infoWindow,point); //开启信息窗口
	});
}

//获取经纬度
function getlongitudelatitude(pointInput) {
	map.addEventListener("click",function(e){
		pointInput.val(e.point.lng + "," + e.point.lat);
	});
}


//下拉框搜索
function searchPoint(searchIdStr,searchResultIdStr) {
	function G(id) {
		return document.getElementById(id);
	}
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : searchIdStr
		,"location" : map
	});

	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
	var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G(searchResultIdStr).innerHTML = str;
	});

	var myValue;
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G(searchResultIdStr).innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		
		setPlace();
	});

	
	function setPlace(){
		
		function myFun(){ 
			var point = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果	
			var marker = new BMap.Marker(point);  // 创建标注
			map.addOverlay(marker);              // 将标注添加到地图中
			map.centerAndZoom(point, 15);	
			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		}
		var local = new BMap.LocalSearch(map, { //智能搜索
		  onSearchComplete: myFun
		});
		local.search(myValue);
	}

}



//地址解析，将中文解析为ip
function geocoder(myAdress,myCity,parkingNumber,portId) {
	// 创建地址解析器实例
	var myGeo = new BMap.Geocoder();
	// 将地址解析结果显示在地图上,并调整地图视野
	myGeo.getPoint(myAdress, function(point){
		if (point) {
			var value=parkingNumber;
			var marker = new BMap.Marker(point);  // 创建标注
			map.addOverlay(marker);               // 将标注添加到地图中
			marker.setIcon(new BMap.Icon('http://map.baidu.com/newmap/static/common/images/mk_14e51b4.gif',new BMap.Size(34,24),{
			    imageOffset:new BMap.Size(0,(value.length-1)*-30) 
			  }))

			    var label = new BMap.Label(value,{offset:new BMap.Size(3,0)});
			  label.setStyle({
			    background:'none',color:'#fff',border:'none'
			  });
			marker.setLabel(label);
			var distance=(map.getDistance(pointA,point)).toFixed(2);
			var object=new myDisplayObject(myAdress,parkingNumber,distance);
			$.ajax({
					   type: "post",
					   url: "map/getAbsDistance",
					   data: "carportId="+portId+"&absDistance="+distance,
					   success: function(msg){
						console.log(msg);
					   }
			});
			var jsonresult=JSON.stringify(object); 
			console.log("经度为："+point.lng+"纬度为"+point.lat);
			console.log("车位数量是："+parkingNumber);
			console.log("显示的对象"+jsonresult);
			message(point,marker,"车位数量："+parkingNumber+";相对当前位置距离:"+distance+"米;地址:"+myAdress,"<button type='button'  onclick='order("+portId+")' >预定</button>");
			
		}
	}, myCity);
}


function order(portId) {
	location.href="map/order/"+portId;
}






////获取距离
//function getDistance(pointA,pointB) {
//	console.log('距离是：'+(map.getDistance(pointA,pointB)).toFixed(2)+' 米。');  //获取两点距离,保留小数点后两位
////	var polyline = new BMap.Polyline([pointA,pointB], {strokeColor:"blue", strokeWeight:6, strokeOpacity:0.5});  //定义折线
////	map.addOverlay(polyline);     //添加折线到地图上
//}


//逆向解析，由经纬度得到地址
function revealGeocoder(point) {
	// 百度地图API功能
	var geoc = new BMap.Geocoder();    
	geoc.getLocation(point, function(rs){
		var addComp = rs.addressComponents;
		console.log("逆向解析"+addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
	});        
}


//封装对象
function myDisplayObject(myAdress,parkingNumber,distance) {
	this.adress=myAdress;
	this.number=parkingNumber;
	this.distance=distance
}

