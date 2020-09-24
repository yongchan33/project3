<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>구매요청페이지</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<link rel="stylesheet" href="${contextPath }/css/paging.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<style>
* {
	/*  outline: 1px solid red;  */
	box-sizing: border-box;
}

	main{display:flex;
	
	justify-content: space-between;}
main .container{
	display:flex;
	flex-direction : column;
	
	
}
main .container .content {
    display: flex;
    border-bottom: 1px solid lightgray;
    margin: auto;
    width: 90%;
    margin-top : 0px;
   
    }
  main .container .content2 {
    width: 100%;
    padding: 20px;
}
main .container .content #r_content {
  padding: 10px;
    outline: 1px solid lightgray;
    /* margin: auto; */
    overflow: auto;
    word-break: break-all;
    /* margin: 10px; */
    /* margin-bottom: 30px; */
    height: 80px;
}
main .container .content .sname{
color:#808080;
}

main .container .content #r_cname {
  margin-bottom: 2px; */
    /* margin-top: 20px; */
    width: 80%;
    /* margin: auto; */
    margin-bottom: 5px;
    margin-left: 3px;
}
main .container .content #r_p_number{
margin-top : 20px;}
main .container .content .btngrp {
    display: flex;
    flex-direction: column;
    justify-content: center;
    /* align-self: flex-end; */
    margin: 10px auto;
    /* width: 80%; */
}
main .container .content .btngrp .btn{
    margin-left: 10px;
    margin-bottom: 10px;
    width: 100px;
    background-color: tan;}

main .container .mainName{
font-size : 24px;
margin : 20px;
margin-top : 30px;
text-align : LEFT;
}
textarea.form-control{    height: 250px;}

.modal-content{
display:flex;
justify-content:center;}

.modal-footer{
justify-content: center;
}
  .modal-footer .btn{
  margin: 10px;
  width: 200px;

}
.c_image{
        margin: auto;}
        .MS_prod_img_s{
           width: 150px;
    height: 180px;}
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
</style>
<script>
var requestnumber="";
window.addEventListener("load",init);
function init() {
var requestBtn = document.getElementById('requestBtn');

	//거절
	var canclerequest = document.getElementsByName("canclerequest");
	for (var i = 0; i < canclerequest.length; i++) {
		
		canclerequest[i].addEventListener('click', canclerequest_f);
		}

	//수락
	var okbtn = document.getElementsByName("okbtn");
	for (var i = 0; i< okbtn.length; i++){
		okbtn[i].addEventListener('click', okbtn_f);
		}
	requestBtn.addEventListener('click', request_f);
}
//요청거절
function canclerequest_f(event){
	console.log('요청거절');
	event.preventDefault(); //기본이벤트 막기
	let canclerequestform = document.getElementById('canclerequestform');
	
	
	var requestnumber2= event.target.parentNode.childNodes[1].value;
	console.log('요청거절클릭'+requestnumber2+"/"+ event.target.parentNode.childNodes[1].value+"/"+ event.target.parentNode.parentNode.childNodes[1].id);
	const url = `/portfolio/transaction/canclerequest/`+requestnumber2;

	console.log('url='+url);
	var canclecon = confirm('구매요청을 거절하시겠습니까?');
	if(canclecon ==true){
	//서버에 전송
	canclerequestform.method = 'post';
	canclerequestform.action = url;
	canclerequestform.submit();
	}
}

//요청수락
function okbtn_f(event){
	console.log('요청수락');
	event.preventDefault(); 
	
	t_content = document.getElementById('t_content').value;
	let okbtnform = document.getElementById('okbtnform');
	requestnumber= event.target.parentNode.childNodes[1].value;
	console.log('요청수락클릭'+requestnumber+"/"+ event.target.parentNode.childNodes[1].value+"/"+ event.target.parentNode.parentNode.childNodes[1].id);


}
//거래전송
function request_f(event){
	console.log('거래전송');
	event.preventDefault(); 
	//거래요청 글자수
	var transactionForm = document.getElementById('transactionForm');
	var t_content = document.getElementById('t_content');
	var transactionExpReg =  /^.{10,100}$/     
	
if(!transactionExpReg.test(t_content.value)){
	
	alert("거래요청은 10글자 이상 100글자 미만으로 입력해주세요.");
	
	return
}else{
	
	//requestnumber
	console.log('요청번호'+requestnumber);
	const url = `/portfolio/transaction/transaction/`+requestnumber;
	console.log('url'+url);
 	transactionForm.method = 'post';
	transactionForm.action = url;
	transactionForm.submit(); 
	alert("거래요청이 완료되었습니다.");

}
}
/* $(document).ready(function(){

	   $('#requestBtn').click(()=>{
		   $.ajax({
	type:"post",
	/* url: "${contextPath }/transaction/transaction?r_number=${requestnumber}", */
/* 	url: "${contextPath }/transaction/transaction/${requestnumber}/${t_content}",
		data: $("#transactionForm").serialize() ,
		
	success:	
		(log)=>{alert("전송완료"),window.close()}

		
			   })

			   });
	   }); */ 
/* function nextBtn_f(e){
e.preventDefault();
console.log("등록");
let productInfo = document.querySelector('#productInfo');

productInfo.submit();
} */

</script> 
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
<%@ include file="/WEB-INF/views/member/myproductmenu.jsp"%>

  <!-- 본문 -->
<main id="main">

					<!-- side bar -->
 <%@ include file="/WEB-INF/views/product/msidebar.jsp" %>
			
			
	  <div class="container">
	  
	 <div class="mainName" >구매요청 관리페이지</div>
	 <hr>
	  <c:forEach var="rec2" items="${requestScope.rlist }"> 
	 	   			<div class="content">
	 	   <div class= "c_image">
              <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform">
              <img  width="175" height="115" alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec2.productVO.p_img_path }" >
         </a>
            </div>
<div class="content2">
		
			<table class="table table-striped">
			
  <tbody>
    <tr>
      <td style="
    width: 200px;
">상품명</td>
      <td>구매자</td>
      <td>요청시간</td>
    </tr>
    <tr>
      <td> ${rec2.productVO.p_name}</td>
      <td>	<i class="far fa-user-circle"></i> <span><a
								href="${contextpath }/portfolio/member/userInfo/${rec2.memberVO.id}">${rec2.memberVO.id  }</a>
							</span>
       </td>
      <td>
<fmt:formatDate value="${rec2.r_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>
    </tr>
  </tbody>
</table>
			 	<input type="hidden" name="r_number"  value="${rec2.r_number }"/>
	 
	    		
	    		    	
	    	<div id="r_cname"><span class="sname">요청내용</span></div>
	  	<div id="r_content"> ${rec2.r_content } </div>
	  	 	</div>
	  	<div class="btngrp">
	  	
	  	 	<form id="okbtnform" method="get">
	  		<input type="hidden" id="${rec2.r_number }" value="${rec2.r_number }">
	  		
	  		<!-- 수락시 모달동작 -->
	   		<input type="button"class="btn btn-light okBtn" name="okbtn" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap" value="수락">
	  		</form>

<!-- 모달사용 시작 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  
   <form role="form" method="post" autocomplete="off"  id="transactionForm" >
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">거래확인서 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
   
   <div class="container">
   <div class="content2">

 	
 
    <input type="hidden" name="requestVO.r_number"  value="${rec2.r_number}"/> 
     
      <div>
    
          <label for="message-text" class="col-form-label">Message:</label>
          <textarea class="form-control"  name="t_content" id="t_content" placeholder="상대방이 본인에게 연락할 수 있도록 전화번호,주소등을 남겨주세요!"></textarea> </div>
      
      </div>
    </div>
  
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-light okBtn"  id="requestBtn">요청</button>
        <button type="button" class="btn btn-light okBtn" data-dismiss="modal">취소</button>
      
      </div>
    </div>
      </form>
  </div>
</div>
<!-- 모달 끝 -->
	  	<form id="canclerequestform" method="post">
	  	<input type="hidden" id="${rec2.r_number }" value="${rec2.r_number }">
	  	<input class="btn btn-light cancelBtn" type="button" value="거절" name="canclerequest">
	  	</form>
		</div>
	 
	  	</div>
	 </c:forEach>
	 

		
		<!-- 보드리스트시작 -->
			<div id="boardList">
	<!-- 페이지  -->
			<div class="paging">
				<c:if test="${reqfindCriteria.pageCriteria.prev}">
					<div>
						<a	href="${contextPath }/transaction/request_notice/1"><i
							class="fas fa-angle-double-left"></i></a>
					</div>
					<div>
						<a	href="${contextPath }/transaction/request_notice/${reqfindCriteria.pageCriteria.startPage}">
						<i	class="fas fa-angle-left"></i></a>
					</div>
				</c:if>

				
					<c:forEach var="pageNum" begin="${reqfindCriteria.pageCriteria.startPage }"	end="${reqfindCriteria.pageCriteria.endPage }">
					<!-- 현재페이지와 요청페이지가 같으면 -->
					<c:if test="${pageNum == reqfindCriteria.pageCriteria.rc.reqPage}">
					<div class="active">
					</c:if>
					<!-- 현재페이지와 요청페이지가 다르면 -->
					<c:if test="${pageNum != reqfindCriteria.pageCriteria.rc.reqPage}">
					<div>
					</c:if>
					<a href="${contextPath }/transaction/request_notice/${pageNum }">${pageNum }</a>
					</div>
					</c:forEach>
					
			
					

			
			<c:if test="${reqfindCriteria.pageCriteria.next}">
				<div>
					<a	href="${contextPath }/transaction/request_notice/${reqfindCriteria.pageCriteria.endPage+1}">
					<i class="fas fa-angle-right"></i></a>
				</div>
				<div>
					<a	href="${contextPath }/transaction/request_notice/${reqfindCriteria.pageCriteria.finalEndPage}">
					<i	class="fas fa-angle-double-right"></i></a>
				</div>
			</c:if>
		</div><!-- 보드리스트종료 -->
		</div>
	 </main>
	 
  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  

</body>
</html>




