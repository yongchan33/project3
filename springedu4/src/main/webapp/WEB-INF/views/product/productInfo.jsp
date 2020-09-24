<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->

<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>판매상품 상세페이지</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/page.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
let basketincheck='false';
var arlet='';
var checkheart = ${requestScope.checkheart}+"";
var requestoverlap="${requestScope.requestoverlap}";
var isRun = false;	//중복요청 방지
window.addEventListener("load",init);
function init() {
/* 	const nextBtn = document.getElementById("nextBtn"); */
	const requestBtn2 = document.getElementById("requestBtn2");
	const womanlistBtn = document.getElementById("womanlistBtn");
	const manlistBtn = document.getElementById("manlistBtn");
	const heartBtn = document.getElementById("heartBtn");
	var requestBtn = document.getElementById('requestBtn');
	

/* 	nextBtn.addEventListener("click", nextBtn_f); */
	requestBtn2.addEventListener("click",requestBtn_f);
	womanlistBtn.addEventListener("click",womanlistBtn_f);
	manlistBtn.addEventListener("click",manlistBtn_f);
	heartBtn.addEventListener("click",heartBtn_f);
	requestBtn.addEventListener('click', request_f);	

}

/* function nextBtn_f(e){
e.preventDefault();
console.log("등록");
let productInfo = document.querySelector('#productInfo');

productInfo.submit();
} */
//관심상품등록
function heartBtn_f(e){
	 if(isRun == true)
	  { return; }
  isRun = true;
	console.log("관심상풍등록");
	

	console.log("checkheart"+checkheart.length+"/"+checkheart);
	 //관심상품등록
	 if(checkheart!='1'){
		
			 
		//event.preventDefault();
		if("${sessionScope.member.id}" =="${productVO.memberVO.id }"){
			alert('본인상품입니다.');
			return;
			}
		var basketproduct = ${productVO.p_number}+'/${sessionScope.member.m_number}';
		console.log("체크박스하트버튼 클릭"+${productVO.p_number});
		
		
		//AJAX 사용
	    //1)XMLHTTPRequest 객체생성
	    const xhttp = new XMLHttpRequest();

	    //2)서버응답처리
	    //readyState
	    // 0 : open()가호출되지않은상태
	    // 1 : open()가실행된상태server 연결됨
	    // 2 : send()가실행된상태,  서버가클라이언트요청을받았음.
	    // 3 : 서버가클라이언트요청처리중. 응답헤더는수신했으나바디가수신중인상태
	    // 4 : 서버가클라이언트의요청을완료했고서버도응답이완료된상태
	    xhttp.addEventListener("readystatechange", ajaxCall);
	    
	    function ajaxCall(event) {
	      if (this.readyState == 4 && this.status == 200) {
	        console.log(this.responseText);

	        //json포맷문자열=> 자바스크립트ojb
	        const jsonObj = JSON.parse(this.responseText);
	        
	        switch(jsonObj.rtcode){
	        case "00" ://성공
	        	arlet = jsonObj.result;	//관심상품등록 완료
	        	alert( arlet );
	        	e.target.style.color="red";
	        	
	        basketincheck =true;
	        break;
	        case "01" ://실패

	        basketincheck=false; 
	        break;
	        } 
	      }
	    }

	    //3)요청파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
	    //js객체를json포맷문자열로변환JSON.stringify()
	    //json포맷문자열을js객체로변환JSON.parse()
	     
	    //4)서비스요청
	    xhttp.open(
	      "POST",
	      "http://localhost:9080/${contextPath}/product/basketin"
	    );
	    xhttp.setRequestHeader(
	            "Content-Type",
	            "application/json;charset=utf-8"
	  ); 
	    checkheart='1';
		xhttp.send(basketproduct);
		
		 }
	

	//관심상품해제
	else if(checkheart=='1'){
		 
		var basketproduct = ${productVO.p_number}+'/${sessionScope.member.m_number}';
		console.log("체크박스하트버튼 클릭"+${productVO.p_number});
		
		
		//AJAX 사용
	    //1)XMLHTTPRequest 객체생성
	    const xhttp = new XMLHttpRequest();

	    //2)서버응답처리
	    //readyState
	    // 0 : open()가호출되지않은상태
	    // 1 : open()가실행된상태server 연결됨
	    // 2 : send()가실행된상태,  서버가클라이언트요청을받았음.
	    // 3 : 서버가클라이언트요청처리중. 응답헤더는수신했으나바디가수신중인상태
	    // 4 : 서버가클라이언트의요청을완료했고서버도응답이완료된상태
	    xhttp.addEventListener("readystatechange", ajaxCall);
	    
	    function ajaxCall(event) {
	      if (this.readyState == 4 && this.status == 200) {
	        console.log(this.responseText);

	        //json포맷문자열=> 자바스크립트ojb
	        const jsonObj = JSON.parse(this.responseText);
	        
	        switch(jsonObj.rtcode){
	        case "00" ://성공
	        	arlet = jsonObj.result;	//관심상품해제 완료
	        	alert( arlet );
	        	e.target.style.color="black";
	        	
	        basketincheck =false;
	        break;
	       
	        } 
	      }
	    }

	    //3)요청파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
	    //js객체를json포맷문자열로변환JSON.stringify()
	    //json포맷문자열을js객체로변환JSON.parse()
	     
	    //4)서비스요청
	    xhttp.open(
	      "POST",
	      "http://localhost:9080/${contextPath}/product/basketout"
	    );
	    xhttp.setRequestHeader(
	            "Content-Type",
	            "application/json;charset=utf-8"
	  ); 
	    checkheart='0';
		xhttp.send(basketproduct);
		
		}

	isRun  = false;
		
	
}

function womanlistBtn_f(e){
	e.preventDefault();
	const url = `/portfolio/product/womanlist`;
	window.location.href = url; 
}

function manlistBtn_f(e){
	e.preventDefault();
	const url = `/portfolio/product/manlist`;
	window.location.href = url; 
}
function requestBtn_f(e){

	e.preventDefault();
	console.log("requestoverlap/"+requestoverlap);

	 if("${sessionScope.member.id}" =="${productVO.memberVO.id }"){
		alert('본인상품입니다.');
		e.stopPropagation();
		}else if(${sessionScope.member.id eq null}){
			alert('로그인을 해주세요.');
			e.stopPropagation();
			}
		else if(requestoverlap=="F"){
			
			alert('이미 요청한 상품입니다.');
			e.stopPropagation();
			}
				}
//거래전송
function request_f(event){
	event.preventDefault(); 
	console.log('거래전송');

	//구매요청 글자수
		var requestForm = document.getElementById('requestForm');
	var r_content = document.getElementById('r_content');
 	var requestExpReg =  /^.{10,100}$/     
 	
	if(!requestExpReg.test(r_content.value)){
		
		alert("구매요청은 10글자 이상 100글자 미만으로 입력해주세요.");
		
		return
	}else{
	

	//requestnumber
	console.log('상품번호'+${productVO.p_number });
	const url = `/portfolio/transaction/request`;
	console.log('url'+url);
	requestForm.method = 'post';
	requestForm.action = url;
	requestForm.submit();
	alert("구매요청이 완료되었습니다.");
	}

}
//요청유무 확인



/* 
$(document).ready(function(){

	   $('#requestBtn').click(()=>{
		   $.ajax({
	type:"post",
	url: "${contextPath }/transaction/request?p_number=${productVO.p_number}",
		data: $("#requestForm").serialize() ,
		
	success:	
		(log)=>{alert("요청완료"),window.close()}

		
			   })

			   });
	   }); */
	    
</script> 
</head>
<style>
/* * {outline : 1px red solid ; } */
td{padding:10px;}
span{font-size: 1.2em;}
.image{width:300px;height:300px;border:1px solid black;}
.list{vertical-align: middle;}
.list>input{padding:5px;padding-right:0px; margin:5px;}
</style>

 <style>
main{

    font-family: 'Nanum Gothic Coding', monospace;
    font-family: 'Noto Sans KR', sans-serif;
    position: relative;
    padding-bottom: 100px;
    margin: 0px;
    min-height: 100%;
    margin-left: 0px;
    margin-bottom: 50px;}
   main .container {
          display: flex;
          flex-direction: column;
       
        align-items: center;
      }
    main .content{
       display: flex;
    flex-direction: row;
    border-bottom: 1px solid lightgray;
        margin-bottom: 30px;
         
      }
     

      .infobox {
        
      padding: 50px;
    padding-left: 50px;
    padding-right: 50px;
    width: 600px;
    text-align: left;
    display: flex;
    flex-flow: column;
      }

      .imgbox {

        padding: 50px;

padding-left: 50px;

padding-right: 50px;



      }

      #infoname {
        padding-top: 50px;
        font-size: 24px;

      }

    
    .content  .name{
        display: flex;
        justify-content:flex-start;
       
        width: 350px;
        margin: 10px;
          
      }
    .content  .pname{
          width: 150px;
          margin-left: 5px;
          color: gray;
              font-size: 1em;
      }
  .content .pname2{
          width: 100px;
          margin-left: 5px;
          color: gray;
      }
      .pinfo{
         width: 250px;
    border: none;
    border-bottom: 1px lightgray solid;
    margin-bottom: 3px;
    padding-bottom: 0.2em;
      }
 
      .btnG1, .btnG2{
          display: flex;
    /* flex-direction: row; */
    /* justify-content: flex-end; */
    /* align-items: flex-end; */
    width: 370px;
    margin-top: auto;
        
      }
      .btn{
  margin: 10px;
  width: 200px;
    margin-bottom: 0px;
}

.inputtext1{


    width: 150px;

    color: gray;
    font-size: 1.1em;
}

svg {
  cursor: pointer;
  overflow: visible;
  width: 60px;
}
svg #heart {
  transform-origin: center;
  animation: animateHeartOut .3s linear forwards;
}

#checkbox {
  display: none;
}

#checkbox:checked + label svg #heart {
  transform: scale(0.8);
  fill: #E2264D;
  animation: animateHeart .3s linear forwards .25s;
}



@keyframes animateHeart {

  100% {
    transform: scale(1);
  }
}

.bastisBtn{
    display: flex;
    justify-content: space-between;
    /* width: 300px; */
    height: 20px;
    size: 10px;
    padding: 0px 5px 5px 5px;
    }
    #infotext{
    height:82px;
    width:334px;
    text-align:top;
    }
.bastisBtn .memberID{
width:200px;
font-size: 20px;
 line-height:70px;}
.inputtext{

height:350px;
margin-top: 10px;
    padding: 5px;
}
#productImg{
border:1px solid black;
       width: 380px;
    height: 420px;
}

.modal-content{
display:flex;
justify-content:center;}

.modal-footer{
justify-content: center;
}

textarea{
margin-top : 20px;}

td{font-size:0.8em;}

.fa-user-circle:before {
    content: "\f2bd";
    font-size: 0.8em;
}
.productInfo{
    WIDTH: 100%;
    }
.btn-warning {
    color: #212529;
    border-color: black;
        background-color: white;
}
#username{
font-size:0.8em;
color :black;}

#username:hover{
text-decoration: none;
    text-shadow: 0 0 black;
    cursor: pointer;
    transition: 0.5s;
}
.btn-warning:hover {
    color: #212529;
    background-color: gainsboro;
    border-color: black;
    
}
.fa-heart:hover {
    content: "\f004";
    color : red;
    transition : 1s;
    cursor: pointer;
}

.condition{
text-align: center;
    width: 100%;
    font-size: 1.2em;
    color: gray;}
    </style>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/include/rmenu.jsp" %>
  <!-- 본문 -->
  
  	
  <main>

<form role="form" method="post" autocomplete="off" id="requestForm">

<div class="container">
    <div id="infoname">판매상품 상세페이지</div>

    <div class="content">
  <div class="imgbox">
     <c:set var="checkheart" value="${requestScope.checkheart}" />
       
           <span class="bastisBtn">
            <a id="username" href="${contextpath }/portfolio/member/userInfo/${productVO.memberVO.id}"> <i class="far fa-user-circle"></i> ${productVO.memberVO.id }</a>  
 		 <c:if test="${checkheart ne '1' }">
 			<i class="far fa-heart fa-1x" id="heartBtn"></i>
		</c:if>
 		<c:if test="${checkheart eq '1' }">
			<i class="far fa-heart fa-1x" id="heartBtn"  style="color:red"></i>
		</c:if> 
       
        </span>

    <img  src="..${productVO.p_img_path }" alt="" id="productImg" name="p_img_path" />
 
  </div>
 
  <div class="infobox">

 	<input type="hidden" name="p_number"  value="${productVO.p_number }"/>

    <div class="name"><span class="pname">카테고리</span><div class="pinfo">${productVO.memberCategoryVO.c_number }</div></div>

    <div class="name"><span class="pname">제품명 </span><div class="pinfo">${productVO.p_name }</div></div>

    <div class="name"><span class="pname">브랜드 </span><div class="pinfo">${productVO.p_brand }</div></div>

    <div class="name"><span class="pname">구매당시가격</span><div class="pinfo"><fmt:formatNumber value="${productVO.p_purchase_price }" pattern="###,###,###" />원</div></div>

    <div class="name"><span class="pname">판매가격</span><div class="pinfo"><fmt:formatNumber value="${productVO.p_sale_price }" pattern="###,###,###" />원</div></div>

    <div class="name"><span class="pname">제품상태</span><div class="pinfo">${productVO.p_condition }</div></div>

    <div class="name"><span class="pname">사이즈 </span> <div class="pinfo">${productVO.p_size }</div></div>

    <div class="name"><span class="pname">거래방식</span><div class="pinfo">${productVO.p_transaction }</div></div>
    <div class="name"><span class="pname">주소 </span><div class="pinfo">${productVO.p_address }</div></div>
   

    <div class="btnG1">


      

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">구매요청서 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

   <input type="hidden" name="memberVO.m_number"  value="${sessionScope.member.m_number }"/>

   <input type="hidden" name="productVO.p_number"  value="${productVO.p_number }"/>
  
  <table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">판매자</th>
      <th scope="col">카테고리</th>
      <th scope="col">상품명</th>
      <th scope="col">상품가격</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      
      <td>${productVO.memberVO.id }</td>
      <td>${productVO.memberCategoryVO.c_number }</td>

      <td>${productVO.p_name }</td>
      <td><fmt:formatNumber value="${productVO.p_sale_price }" pattern="###,###,###" />원</td>
    </tr>

  </tbody>
</table>
  
      <div>
        <textarea
          placeholder="상대방에게 요구하고싶은 사항을 작성하세요!"
          cols="40"
          rows="5" name="r_content" id="r_content"
        ></textarea>
      </div>

      </div>
      <div class="modal-footer">
             <input type="button" value="요청" id="requestBtn"  class="btn btn-warning"/>
             <button type="button" class="btn btn-warning" data-dismiss="modal">취소</button>
               
      </div>
    </div>
  </div>
</div>

<c:if test="${productVO.memberCategoryVO.c_number eq '(여)아우터' ||
productVO.memberCategoryVO.c_number eq '(여)반팔/긴팔/민소매' ||
productVO.memberCategoryVO.c_number eq '(여)원피스' ||
productVO.memberCategoryVO.c_number eq '(여)블라우스/셔츠' ||
productVO.memberCategoryVO.c_number eq '(여)니트/가디건' ||
productVO.memberCategoryVO.c_number eq '(여)후드/맨투맨' ||
productVO.memberCategoryVO.c_number eq '(여)팬츠' ||
productVO.memberCategoryVO.c_number eq '(여)스커트' ||
productVO.memberCategoryVO.c_number eq '(여)수트'

 }" >
 <c:if test="${productVO.p_sale_condition == 3}"><div class="condition">판매완료 상품</div></c:if>
 <c:if test="${productVO.p_sale_condition == 2}"><div class="condition">거래중인 상품</div></c:if>
 <c:if test="${productVO.p_sale_condition == 1}">
   <button type="button" id="requestBtn2" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">구매요청</button>
        <input type="button" value="목록" class="btn btn-warning"  id="womanlistBtn" />
        <input type="hidden" value="목록" class="btn btn-warning"  id="manlistBtn"/>
        </c:if>
       </c:if>
       
    <c:if test="${productVO.memberCategoryVO.c_number eq '(남)아우트' ||
productVO.memberCategoryVO.c_number eq '(남)반팔/긴소매/민소매' ||
productVO.memberCategoryVO.c_number eq '(남)니트/가디건' ||
productVO.memberCategoryVO.c_number eq '(남)셔츠' ||
productVO.memberCategoryVO.c_number eq '(남)후드/맨투맨' ||
productVO.memberCategoryVO.c_number eq '(남)셔츠' ||
productVO.memberCategoryVO.c_number eq '(남)수트' 

 }" >
 <c:if test="${productVO.p_sale_condition == 3}"><div class="condition">판매완료 상품</div></c:if>
 <c:if test="${productVO.p_sale_condition == 2}"><div class="condition">거래중인 상품</div></c:if>
 <c:if test="${productVO.p_sale_condition == 1}">
   <button type="button" id="requestBtn2" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap">구매요청</button>
        <input type="hidden" value="목록" class="btn btn-warning"  id="womanlistBtn"/>
        <input type="button" value="목록" class="btn btn-warning"  id="manlistBtn"/>
        </c:if>
       </c:if>
    </div>


     
    </div>

  </div>
  <div class="productInfo">

        <div class="name"><span class="pname inputtext1">상세설명</span></div>

   <div class="name"><div class="inputtext">${productVO.p_content }</div>

   </div>  
</div>
</div>

</form>
	</main>
	
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>