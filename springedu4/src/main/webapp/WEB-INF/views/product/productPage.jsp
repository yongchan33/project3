<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>

<title>판매하기</title>


    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css" />
    <link
      rel="stylesheet"
      href="https://unpkg.com/swiper/swiper-bundle.min.css"
    />
    <link rel="stylesheet" href="${contextPath }/css/main.css">
	<link rel="stylesheet" href="${contextPath }/css/product/page.css">


    <script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
 
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>    
    <script type="module">
  import Swiper from 'https://unpkg.com/swiper/swiper-bundle.esm.browser.min.js'


</script>
   <style>
   
    main{ margin-left:50px;
    margin-right:50px;}
    </style>

<script>
window.addEventListener("load",init);
var movemarker=0;
var gendercheck=0;
var imgcheck=0;
var p_conditioncheck=0;
var p_sizecheck=0;
var p_transactioncheck=0;
var mapcheck=0;
function init() {
	const insertBtn = document.getElementById("insertBtn");
	insertBtn.addEventListener("click", insertBtn_f);
	var rad = document.getElementsByName("gender");
	var p_condition = document.getElementsByName("p_condition");
	var p_size = document.getElementsByName("p_size");
	var p_transaction = document.getElementsByName("p_transaction");
	
	

	for (var i = 0; i < rad.length; i++) {
		
	    rad[i].addEventListener('change', changegender_f);
	}
//라디오버튼 유효성검사
for (var i = 0; i < p_condition.length; i++) {
		
	p_condition[i].addEventListener('change', p_condition_f);
	}
for (var i = 0; i < p_size.length; i++) {
	
	p_size[i].addEventListener('change', p_size_f);
}
for (var i = 0; i < p_transaction.length; i++) {
	
	p_transaction[i].addEventListener('change', p_transaction_f);
}

}

function p_condition_f(event){
	event.preventDefault(); //<button>의기본이벤트차단
	p_conditioncheck=1;
}
function p_size_f(event){
	event.preventDefault(); //<button>의기본이벤트차단
	p_sizecheck=1;
}
function p_transaction_f(event){
	event.preventDefault(); //<button>의기본이벤트차단
	p_transactioncheck=1;
}

//성별변경
function changegender_f(event) {
	event.preventDefault(); //<button>의기본이벤트차단
	var Mclothes = document.getElementById("mcategory");
	var Fclothes = document.getElementById("wcategory");

	var mcategory = document.getElementById("Mclothes");
	var fcategory = document.getElementById("Fclothes");


if(event.target.value==0){

		Mclothes.style.display='none';
		Fclothes.style.display='block';
		mcategory.options[mcategory.selectedIndex].value='';
		gendercheck=1;

		
}
else{

		Fclothes.style.display='none';
		Mclothes.style.display='block';
		fcategory.options[fcategory.selectedIndex].value='';
		gendercheck=1;
}
	  
console.log(event.target.value+"체인지");

}


function insertBtn_f(e){
e.preventDefault();
if(!chkValidation()) return
console.log("등록");
let productPage = document.getElementById("productPage");

productPage.submit();
}

//유효성검사
function chkValidation(){
	let p_nameTag = document.getElementById("p_name");
	let gdsImgTag = document.getElementById("gdsImg");
	let p_purchase_priceTag = document.getElementById("p_purchase_price");
	let p_brandTag = document.getElementById("p_brand");
	let p_sale_priceTag = document.getElementById("p_sale_price");
	let p_condition = document.getElementsByName("p_condition");
	let p_size = document.getElementsByName("p_size");
	let p_transaction = document.getElementsByName("p_transaction");
	let p_contentTag = document.getElementById("p_content");
	
	
	
	//카테고리
	if(gendercheck==0){
		alert('카테고리를 선택해주세요.');
		return false;
	}
	//제품이름
	if(!p_nameTag.value){
		alert('제품이름을 입력해주세요.');
		return false;
		}
	//이미지첨부
	if(imgcheck==0){
		alert('제품이미지를 첨부해주세요.');
		return false;
		}
	//브랜드이름
	if(!p_brandTag.value){
		alert('브랜드이름을 입력해주세요.');
		return false;
		}
	//구매가격
	if(!p_purchase_priceTag.value){
		alert('구매가격을 입력해주세요.');
		return false;
		}
	
	//판매가격
	if(!p_sale_priceTag.value){
		alert('판매가격을 입력해주세요.');
		return false;
		}
	//제품상태

     if(p_conditioncheck==0){
    	 alert('제품상태를 확인해주세요.');
 		return false;
     }
   //제품사이즈

     if(p_sizecheck==0){
    	 alert('제품사이즈를 확인해주세요.');
 		return false;
         }
   //거래방식

     if(p_transactioncheck==0){
    	 alert('거래방식을 확인해주세요.');
 		return false;
         }
	//판매위치 확인
 	if(mapcheck==0){
 		alert('판매위치를 확인해주세요.');
 		return false;
 	 	}
	//내용
	if(!p_contentTag.value){
		alert('판매내용을 확인해주세요.');
 		return false;
		}
	return true;
}
</script>


</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/include/pmenu.jsp" %>
  <!-- 본문 -->
  <main>
  	<form id="productPage" method="post" action="${contextPath }/product/product" enctype="multipart/form-data">
 <!-- Swiper -->
    <div class="swiper-container">
    
      <div class="swiper-wrapper">
      
        <div class="swiper-slide">
        <div class="slide">

 	<div class="context">
 
 	 <p> &nbsp;&nbsp;
 	     <input type="radio" name="gender" id="m_gender"  value="1"/><label for="m_gender">남성의류 &nbsp;&nbsp;</label>
 	     <input type="radio" name="gender" id="w_gender" value="0"><label for="w_gender">여성의류</label>
 	 </p>
 	
 	</div> 

 	<div class="context" >
		<div  id="wcategory"  style="display:none">
		<span>여성의류 카테고리 선택</span>
          <select id="Fclothes" name="MemberCategoryVO.c_number" class="cate" >
           <option value="">==선택==</option>
            <option value="11" >아우터</option>
            <option value="12">반팔/긴팔/민소매</option>
            <option value="13">원피스</option>
            <option value="14">블라우스/셔츠</option>
            <option value="15">니트/가디건</option>
            <option value="16">후드/맨투맨</option>
            <option value="17">팬츠</option>
            <option value="18">스커트</option>
            <option value="19">수트</option>
           
          </select>
		</div>
		<div  id="mcategory"  style="display:none">
		<span>남성의류 카테고리선택</span>
          <select id="Mclothes" name="MemberCategoryVO.c_number" class="cate" >
          <option value="">==선택==</option>
            <option value="21">아우터</option>
            <option value="22">반팔/긴팔/민소매</option>
            <option value="23">니트/가디건</option>
            <option value="24">셔츠</option>
            <option value="25">후드/맨투맨</option>
            <option value="26">팬츠</option>
            <option value="27">슈트</option>   
          </select>
		</div>
 	</div>	


 	<div class="context">
          제품이름 <input type="text" class="p_name" name="p_name" placeholder="write" id="p_name" >
        </div>
 
  </div>

 <div class="bottom">
  <input type="button" name="next" value="다음" class="btn btn-warning " id="nextBtn">
          <span class="next"></span>
 
  <ul class="process">
          <li id="thispage">제품이름 ></li><li>사진 ></li><li>가격정보 ></li><li>제품정보 ></li><li>판매지역 ></li><li>내용 ></li><li>판매등록</li>
        </ul>
 
 </div>

        </div>
        
        <div class="swiper-slide">
         <div class="slide imgslide">
 	<div class="context imgcon">
    <table class="table imgtable">
  <thead class="thead-dark">
    <tr>
      <th scope="col" >제품이미지</th>
    </tr>
  </thead>
  <tbody>
    <tr>
    <th scope="row" class="select_img"><img src="" id="imgin"/></th>
    </tr>
    <tr>
      <th scope="row" id="imgrow">
        <label for="gdsImg" style="cursor:hand" class="btn btn-light">등록</label>
       <input type="file" id="gdsImg" name="file"  /></th>
    </tr>
  
  </tbody>
</table>

</div>    
 <script>
  $("#gdsImg").change(function(){
	  if(!chkfile()) return
   if(this.files && this.files[0]) {
    var reader = new FileReader;
    reader.onload = function(data) {
     $(".select_img img").attr("src", data.target.result).width(300);        
    }
    reader.readAsDataURL(this.files[0]);
    imgcheck=1;
   }
  });

  function chkfile(){
	var fileext = document.getElementById('gdsImg').value;
	fileext = fileext.slice(fileext.indexOf(".")+1).toLowerCase();

	if(fileext !="jpg" &&fileext !="png" && fileext !="gif" &&fileext !="bmp"){
		alert('이미지파일(jpg,png,gif,bmp)만 등록 가능합니다.');
		 imgcheck=0;
		return false;}
	return true;
	  }
 </script>
 	</div>
  
 <div class="bottom">
  <input type="button" name="next" value="다음" class="btn btn-warning "   id="nextBtn">
          <span class="next"></span>
 
  <ul class="process">
          <li>제품이름 ></li><li id="thispage">사진 ></li><li>가격정보 ></li><li>제품정보 ></li><li>판매지역 ></li><li>내용 ></li><li>판매등록</li>
        </ul>

 </div>
		</div>
        <div class="swiper-slide">
        <div class="slide">
 	<table class="table table-borderless slaetable">
  <thead>
    <tr>
      <th scope="col" class="ptag"><label for="p_brand">브랜드</label></th>
 		<td class="saletd"><input type="text" class="p_name" name="p_brand" placeholder="write" id="p_brand"/></td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row" class="ptag"><label for="p_purchase_price">구매당시가격</label></th>
      <td class="saletd"><input type="text" class="p_name" name="p_purchase_price" placeholder="write" id="p_purchase_price" 
 	onkeydown=' Number(event)' onkeyup='removeChar(event)'/> <span>원</span></td>
    
    </tr>
    <tr>
      <th scope="row" class="ptag"><label for="p_sale_price">판매가격</label></th>
      <td class="saletd"> <input type="text" class="p_name" name="p_sale_price" placeholder="write" id="p_sale_price"
 	   onkeydown=' Number(event)' onkeyup='removeChar(event)' pattern="###,###,###"/> <span>원</span></td>
      
    </tr>
  
  </tbody>
</table>
 
  
 	<!-- 숫자만 입력가능 -->
<script>
function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}
 
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        event.target.value = event.target.value.replace(/[^0-9]/g, "");
}
</script>


 </div>
 
 <div class="bottom">
  <input type="button" name="next" value="다음" class="btn btn-warning "   id="nextBtn">
          <span class="next"></span>
 
  <ul class="process">
          <li>제품이름 ></li><li>사진 ></li><li id="thispage">가격정보 ></li><li>제품정보 ></li><li>판매지역 ></li><li>내용 ></li><li>판매등록</li>
        </ul>
 
 </div>
        </div>
        
        
        <div class="swiper-slide" >
         <div class="slide" id="sizep">
 	<div class="context">
        제품상태&nbsp;
        <input type="radio" name="p_condition" id="p_condition_C"value="5" ><label for="p_condition_C">C &nbsp;</label>
        <input type="radio" name="p_condition" id="p_condition_B" value="4"><label for="p_condition_B">B &nbsp;</label>
        <input type="radio"name="p_condition" id="p_condition_A"value="3"><label for="p_condition_A">A &nbsp;</label>
        <input type="radio"name="p_condition" id="p_condition_S" value="2"><label for="p_condition_S">S &nbsp;</label>
        <input type="radio"name="p_condition" id="p_condition_SS"value="1"><label for="p_condition_SS">SS &nbsp;</label>
 	</div> 

 	<div class="context">
 	
        제품사이즈&nbsp;
        <input type="radio" name="p_size" id="p_size_S" value="1"><label for="p_size_S">S &nbsp;</label>
        <input type="radio" name="p_size" id="p_size_M" value="2"><label for="p_size_M">M &nbsp;</label>
        <input type="radio"name="p_size" id="p_size_L" value="3"><label for="p_size_L">L &nbsp;</label>
        <input type="radio"name="p_size" id="p_size_XL" value="4"><label for="p_size_XL">XL &nbsp;</label>
        <input type="radio"name="p_size" id="p_size_XXL" value="5"><label for="p_size_XXL">XXL &nbsp;</label>
      
 	</div>
 	  
 	  <br><br>
 	<div class="context" id="cgrade">
 	
 	<table class="table cgrade" >
  <thead  class="thead-dark">
    <tr>
    
       <th scope="col">SS</th>
      <th scope="col">S</th>
      <th scope="col">A</th>
      <th scope="col">B</th>
      <th scope="col">C</th>
    </tr>
  </thead>
  <tbody>
    <tr>
   
      <td>새 상품 또는 개봉된 새 상품으로, 일부 부속품이 없을 수 있음</td>
      <td>사용 횟수 적은 편으로 새 상품에 가까운 상태, 중고 등급 중 최상</td>
      <td>자연스러운 사용감이 있으며, 전체적으로 상태가 양호한 상품 1년 이상  소지하며 입었다</td>
	  <td>사용한 느낌이 있는 편으로, 스크래치나 때 등 사용 흔적이 있음</td>
	  <td>스크래치, 구김, 때, 변색 등 사용 흔적이 많아 확연한 중고 느낌의 상품</td>
    </tr>
 
  </tbody>
</table>
 	</div>
 	
 	<div class="context">

    <table class="table csize">
  <thead class="thead-dark ">
    <tr>
      <th scope="col"></th>
      <th scope="col">S</th>
      <th scope="col">M</th>
      <th scope="col">L</th>
      <th scope="col">XL</th>
      <th scope="col">XXL</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">여자</th>
      <td>키 : 165 cm 이하<br> 몸무게 : 60kg 이하 </</td>
      <td>키 : 165~170 cm<br> 몸무게 : 60~65kg </td>
      <td>키 : 170~175 cm<br> 몸무게 : 65~70kg </td>
      <td>키 : 175~180 cm<br> 몸무게 : 70~90kg  </td>
 	  <td>키 : 180 cm 이상<br> 몸무게 : 90kg 이상 </td>
    </tr>
    <tr>
      <th scope="row">남자</th>
  	   <td>키 : 150 cm 이하<br>몸무게 : 40kg 이하   </td>
       <td>키 : 150~160 cm<br>몸무게 : 40~45kg   </td>
       <td>키 : 160~165 cm<br>몸무게 : 45~60kg  </td>
       <td>키 : 165~170 cm<br>몸무게 : 60~70kg  </td>
       <td>키 : 170 cm 이상<br>몸무게 : 70kg 이상  </td>
    </tr>
   
  </tbody>
</table>
 	</div>
 	
 </div>
 
 <div class="bottom">
  <input type="button" name="next" value="다음" class="btn btn-warning "  id="nextBtn">
          <span class="next"></span>
 
  <ul class="process">
          <li>제품이름 ></li><li>사진 ></li><li>가격정보 ></li><li id="thispage">제품정보 ></li><li>판매지역 ></li><li>내용 ></li><li>판매등록</li>
        </ul>
 
 </div>
        </div>
        <div class="swiper-slide">
         <div class="slide mslide">
 
 	<div class="context mcontext">
 	<input type="text"  name="p_xrow"  id="p_xrow" style="display:none"/>
 	<input type="text"name="p_ycol" id="p_ycol"  style="display:none"/>
 	<input type="text"name="p_address" id="p_address"  style="display:none"/>
 	 <span class="choose">거래방식&nbsp;</span>
 	 	 <input type="radio" name="p_transaction" value="1" id="Direct"><label for="Direct">직거래 &nbsp;</label>
    <input type="radio" name="p_transaction" value="2" id="
Delivery" ><label for="
Delivery">택배 &nbsp;</label>
 	</div> 
 	 <div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div class="hAddr">
        <span class="title">현재위치</span>
        <span id="centerAddr"></span>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8c282ee30fda14f7fd4ba6dc02a3955c&libraries=services"></script>
<script>


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
    
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표

        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

if (navigator.geolocation) {
	 // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	 navigator.geolocation.getCurrentPosition(function(position) {
	  var lat = position.coords.latitude, // 위도
	         lon = position.coords.longitude; // 경도
	    var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	        message = '<div style="padding:5px; font-size:8px;">판매할 지역을 선택하세요.</div>'; // 인포윈도우에 표시될 내용입니다
	     // 마커와 인포윈도우를 표시합니다
	     displayMarker(locPosition, message);    
	   });
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	     message = 'geolocation을 사용할수 없어요..'
	     	displayMarker(locPosition, message);
	}

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
searchAddrFromCoords(map.getCenter(), displayCenterInfo);

// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">선택한 위치</span>' + 
                            detailAddr + 
                        '</div>';

            // 마커를 클릭한 위치에 표시합니다 
            marker.setPosition(mouseEvent.latLng);
            marker.setMap(map);

            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
            infowindow.setContent(content);
            infowindow.open(map, marker);

             // 클릭한 위도, 경도 정보를 가져옵니다 
            var latlng = mouseEvent.latLng; 
            var xrow = document.getElementById('p_xrow'); 
            var ycol = document.getElementById('p_ycol');
            var p_address = document.getElementById('p_address');
            xrow.value=latlng.getLat();
            ycol.value=latlng.getLng();
            p_address.value=result[0].address.address_name;
            console.log("xrow="+xrow.value + "ycol.value="+ycol.value+"p_address="+p_address.value);
            mapcheck=1;
        }   
    });
});

// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}


//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 






function displayMarker(locPosition, message) {
	console.log("테스트2"+locPosition);
	  // 마커 이미지의 이미지 크기 입니다

 var imageSize = new kakao.maps.Size(24, 35); 
	  var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
 var marker = new kakao.maps.Marker({  
     map: map, 
     position: locPosition,
     image:markerImage

 }); 

 var iwContent = message, // 인포윈도우에 표시할 내용
     iwRemoveable = true;

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

</script>
 </div>
 <div class="bottom">
  <input type="button" name="next" value="다음" class="btn btn-warning " id="nextBtn">
          <span class="next"></span>
 
 
  <ul class="process">
          <li>제품이름 ></li><li>사진 ></li><li>가격정보 ></li><li>제품정보 ></li><li id="thispage">판매지역 ></li><li>내용 ></li><li>판매등록</li>
        </ul>
 
 </div>
        </div>
        
        <!-- 6.내용 -->
     <div class="swiper-slide">
        <div class="slide">

 	<div class="context">
 
 
 	<div class="col-12">
		<textarea id="p_content" name="p_content" placeholder="상품 정보를 상세하게 적어보세요.&#13;&#10;설명되지 않은 하자나 문제 발생시 책임은 판매자에게 있습니다.&#13;&#10;- 구매 정보(구매일시,구매방법 등)&#13;&#10;- 상품 정보(색상,세탁방법 등)&#13;&#10;- 상품 사용감(찢어짐,변색 등)&#13;&#10;"></textarea>
	</div>
 	
 	</div> 

 	<div class="context" >

 	</div>	



 
 </div>

 
 <div class="bottom">
  <input type="submit" name="insertBtn" value="판매 등록" class="btn btn-warning"  id="insertBtn">
          <span class="next"></span>
  <ul class="process">
          <li>제품이름 ></li><li>사진 ></li><li>가격정보 ></li><li>제품정보 ></li><li>판매지역 ></li><li id="thispage">내용 ></li><li>판매등록</li>
        </ul>
 
 </div>
        </div>     
   
      </div>
      <!-- Add Pagination -->
      <div class="swiper-pagination"></div>
      <!-- Add Arrows -->
      <div class="swiper-button-next"></div>
      <div class="swiper-button-prev"></div>
    </div>

  
    <!-- Initialize Swiper -->
     <script>
      var swiper = new Swiper(".swiper-container", {
    	  simulateTouch : false,
    	  grabCursor :true,
        pagination: {
        	 pagination: '.swiper-pagination',
             paginationClickable: true,
             touchRatio: 0,
        },
        navigation: {
          nextEl: ".swiper-button-next, #nextBtn",
          prevEl: ".swiper-button-prev",
        },

      });

    </script>
</form>
	</main>
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>