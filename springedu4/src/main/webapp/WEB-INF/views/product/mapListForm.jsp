<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<title>지도로보기</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<style>
	* {
		/*  outline: 1px solid red;  */
		box-sizing: border-box;
	}
	
	main{display:flex;
	
	justify-content: space-between;}
	
	
	
	
	.clist-w>ul{text-align:center;margin:10px;}
	
	.clist-w>ul>li{display:inline-block; padding:10px;font-size:11px; text-decoration:none;}
	
		.clist-w>ul>li a{text-decoration:none;}
		.clist-w>ul>li a:hover{font-weight:bold; cursor: pointer;
								color:black;
								text-shadow:1px 2px 1px lightgray;
								text-decoration:none;}	
	.mlist>ul{text-align:center;margin:10px;border-top: 1px solid lightgray;border-bottom: 1px solid lightgray;}
	
	.mlist>ul>li{display:inline-block; padding:10px;}
		.mlist>ul>li:hover{font-weight:bold; cursor: pointer;
		text-shadow:1px 2px 1px lightgray;
}
	.bodyline{
	width:85%;
	padding:50px;
	padding-top:0px;	}
	 
	.cimage{width:100%; height:350px;
    margin: auto;
	text-align:center;} 
	 .cbox{  display: grid;
	  grid-template-columns: 20% 20% 20% 20% 20%;
	  }
	.box {display:inline-block; margin-top:40px;text-align:center;
	margin:20px;
	}
	
	
	.fas {padding-left:10px;}
	
	
	
	.mtitle{
	font-size : 24px;
	text-align : center;
	margin-top : 30px;
	}
	
	
	
	.MS_prod_img_s{width:100%; height:100%;
	}
	
	.like-container{filter: url('#filter');}
	.like-cnt{  
	  position: absolute; 
	  cursor: pointer;
	  left: 50%; 
	  top: 50%; 
	  transform: translate(-50%, -50%);     background: rgba(255,255,255,0.3);     width: 60px; 
	  height: 60px;  
	  border-radius: 50%;
	  text-align: center;
	  line-height: 75px;
	  z-index: 10;
	}
	.like-btn{
	  color: #fff;
	}
	
	.gp-header{font-family: georgia; font-size: 40px; color: #ddca7e; font-style: italic; text-align: center; margin-top: 31px;}
	.gp-footer{position: fixed; color: #fff; bottom: 10px; left: 50%; font-family: georgia; font-style: italic; transform: translateX(-50%);}
	.gp-footer .soc_icons{display: inline-block; color: #ddca7e; margin: 0px 0px;}
	
	
	::-moz-selection { background: transparent;}
	::selection {background: transparent;}
	
	/* 페이징 */
	#boardList .paging {
	  display: flex;
	  justify-content: center;
	}
	#boardList .paging div{
		padding:2px;
	}
	#boardList .paging div.active{
		background-color:#ffcc80;
	}
	/*
	#boardList .paging div.active a{
		color:white;
	}
	*/
	
	/* 검색 */
	#boardList .find {
	  display: flex;
	  justify-content: center;
	  margin:10px;
	}
	
	#boardList .find #findBtn{
		padding: 2px 6px;
	}
	
	#boardList #findCriteria * {
		vertical-align: middle;
	}
	.cname,.cprice,.seller-name{
	font-weight:bold;
	margin:5px;
	text-align:right;
	}
	
#map{
margin:0 auto;
width:85%; height:60%;float:canter;
}

.overlaybox {position:relative;width:200px;height:140px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px; overflow: visible;}
/*  .overlaybox {position:relative;width:360px;height:350px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/box_movie.png') no-repeat;padding:15px 10px;}*/
.overlaybox div, ul {margin:0;padding:0;}
.overlaybox li {list-style: none;}
.overlaybox .boxtitle {color:#fff;font-size:0.8em;font-weight:bold;margin-bottom:4px;}
.overlaybox .first {position:relative;width:100%px;height:100px;margin-bottom:8px;}
/* .overlaybox .first {position:relative;width:247px;height:136px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/thumb.png') no-repeat;margin-bottom:8px;} */
.first .text {color:#fff;font-weight:bold;}
.first .triangle {position:absolute;width:40px;height:24px;top:0;left:0;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/triangle.png') no-repeat; padding:4px;font-size:0.7em;}
.first .movietitle {position:absolute;height:20px;width:100%;bottom:0;background:rgba(0,0,0,0.4);padding:7px 15px;font-size:14px;}
.overlaybox ul {width:247px;}
.overlaybox li {position:relative;margin-bottom:2px;background:#2b2d36;padding:5px 10px;color:#aaabaf;line-height: 1;}
.overlaybox li span {display:inline-block;}
.overlaybox li .number {font-size:16px;font-weight:bold;}
.overlaybox li .title {font-size:13px;}
.overlaybox ul .arrow {position:absolute;margin-top:8px;right:25px;width:5px;height:3px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/updown.png') no-repeat;} 
.overlaybox li .up {background-position:0 -40px;}
.overlaybox li .down {background-position:0 -60px;}
.overlaybox li .count {position:absolute;margin-top:5px;right:15px;font-size:10px;}
.overlaybox li:hover {color:#fff;background:#d24545;}
.overlaybox li:hover .up {background-position:0 0px;}
.overlaybox li:hover .down {background-position:0 -20px;}  

 

</style>


</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/include/rmenu.jsp" %>
  <!-- 본문 -->
  <main>
<!-- side bar -->
 <%@ include file="/WEB-INF/views/product/sidebar.jsp" %>
 

	
	<div class="bodyline">
		  <div class="headline">	
	  	<div class="mtitle">지도로보기</div>
	  	<hr>
	  	<div id="map" style="width:800px;height:600px;"></div>
	  	</div>
	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c282ee30fda14f7fd4ba6dc02a3955c&libraries=services"></script>
	<script>
	
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};

		
		var map = new kakao.maps.Map(container, options);  //지도 생성 및 객체 리턴

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
		        
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		            message = '<div style="padding:5px; text-align:center;">현재 위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
		        // 마커와 인포윈도우를 표시합니다
		        displayMarker(locPosition, message);
		            
		      });
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할수 없어요..'
		        
		    displayMarker(locPosition, message);
		}

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {

		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({  
		        map: map, 
		        position: locPosition
		    }); 
		    
		    var iwContent = message, // 인포윈도우에 표시할 내용
		        iwRemoveable = false;

		    // 인포윈도우를 생성합니다
		    var infowindow = new kakao.maps.InfoWindow({
		        content : iwContent,
		        removable : iwRemoveable
		    });
		    
		    // 인포윈도우를 마커위에 표시합니다 
		    infowindow.open(map, marker);
		    
		    // 지도 중심좌표를 접속위치로 변경합니다
		    map.setCenter(locPosition);      
		}






/* 상품마커!! */
		 <fmt:requestEncoding value="UTF-8"/>
		var positions=[];
		var imgs = [];
		var iwContent=[];
		var miniiwContent=[];
		var producturls=[];
		
		<c:forEach items="${maplist}" var="info" varStatus="status">
		var producturl=${info.p_number};
		
		
		var position = 
		    {
		        title: '${info.p_name}',
		        latlng: new kakao.maps.LatLng(${info.p_xrow}, ${info.p_ycol})
		    }
		;
		//var piwContent = '<div style="padding:5px; width:150px; height:80px; font-size:0.5em;" ><a href="http://localhost:9080/portfolio/product/productInfo?p_number=${info.p_number}">${info.p_name}/${info.p_sale_price}/${info.p_brand}</a><br><img src="/portfolio${info.p_img_path}" alt="이미지 오류" id="productImg" style="width:100%; height:60px;"> </div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		var piwContent =
			'<div class="overlaybox">' +
		    ' <a href="http://localhost:9080/portfolio/product/productInfo?p_number=${info.p_number}"> '+  
		    ' <div class="boxtitle">${info.p_name}</div>' +
		    '    <div class="first">' +
		    '		 <img src="/portfolio${info.p_img_path}" alt="이미지 오류" id="productImg" style="width:100%; height:80px;">									' +
		    '        <div class="movietitle text">가격:${info.p_sale_price}</div>' +
		    '    </div>' +
		    '</a>'+
		    '</div>';
		    var miwContent = '<div style="font-size:0.7em; height:">${info.p_name}/${info.p_brand}/${info.p_sale_price}</div>';
		//var img = ${info.p_img_path};  
		positions.push(position);
		iwContent.push(piwContent);
		miniiwContent.push(miwContent);
		producturls.push(producturl);
		</c:forEach>
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		    
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker2 = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });  
		 // 마우스 호버 인포윈도우를 생성합니다
		    var infowindow2 = new kakao.maps.InfoWindow({
		    	  position: positions[i].latlng, 
		        content : iwContent[i],
		    xAnchor: 0.3,
		    yAnchor: 0.51
		    });

			//상품url 정의
			
			url = `/portfolio/product/productInfo?p_number=`+producturls[i];
		    //기본 인포윈도우를 생성합니다
		    var infowindow3 = new kakao.maps.InfoWindow({
		    	  position: positions[i].latlng, 
		        content : miniiwContent[i],
		    xAnchor: 0.3,
		    yAnchor: 0.51
		    });
		    kakao.maps.event.addListener(marker2, 'mouseover', makeOverListener(map, marker2, infowindow2));
		    kakao.maps.event.addListener(marker2, 'mouseout', makeOutListener(infowindow2,infowindow3,map,marker2));
		    kakao.maps.event.addListener(marker2, 'click', mapClickListener(url));
		 // 인포윈도우를 마커위에 표시합니다 
		    infowindow3.open(map, marker2);
		//	  infowindow2.setMap(map)
		}  

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker2, infowindow2) {
		    return function() {
		        infowindow2.open(map, marker2);
		        infowindow3.close();
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow2,infowindow3,map,marker2) {
		    return function() {
		        infowindow2.close();
		        infowindow3.open(map, marker2);
		    };
		}
		function mapClickListener(url) {
		    return function() {
		    	event.preventDefault(); //기본이벤트 막기
		    	console.log(url);
		    	window.location.href = url;
		    	
		    };
		}
		
	</script>
	

	
	
	</div>
	

	</main>
	
	
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>