<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>거래요청페이지</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<link rel="stylesheet" href="${contextPath }/css/paging.css">
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
    margin: auto;
    border-bottom: 1px solid lightgray;
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
.star-input1>.input,
.star-input1>.input>label:hover,
.star-input1>.input>input:focus+label,
.star-input1>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('${contextPath}/img/grade_img.png')no-repeat;}
.star-input1{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}
.star-input1>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input1>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input1>.input.focus{outline:1px dotted #ddd;}
.star-input1>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input1>.input>label:hover,
.star-input1>.input>input:focus+label,
.star-input1>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input1>.input>label:hover~label{background-image: none;}
.star-input1>.input>label[for="p1"]{width:30px;z-index:5;}
.star-input1>.input>label[for="p2"]{width:60px;z-index:4;}
.star-input1>.input>label[for="p3"]{width:90px;z-index:3;}
.star-input1>.input>label[for="p4"]{width:120px;z-index:2;}
.star-input1>.input>label[for="p5"]{width:150px;z-index:1;}
.star-input1>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}

      .star-input2>.input,
.star-input2>.input>label:hover,
.star-input2>.input>input:focus+label,
.star-input2>.input>input:checked+label{display: inline-block;vertical-align:middle;background:url('${contextPath}/img/grade_img.png')no-repeat;}
.star-input2{display:inline-block; white-space:nowrap;width:225px;height:40px;padding:25px;line-height:30px;}
.star-input2>.input{display:inline-block;width:150px;background-size:150px;height:28px;white-space:nowrap;overflow:hidden;position: relative;}
.star-input2>.input>input{position:absolute;width:1px;height:1px;opacity:0;}
.star-input2>.input.focus{outline:1px dotted #ddd;}
.star-input2>.input>label{width:30px;height:0;padding:28px 0 0 0;overflow: hidden;float:left;cursor: pointer;position: absolute;top: 0;left: 0;}
.star-input2>.input>label:hover,
.star-input2>.input>input:focus+label,
.star-input2>.input>input:checked+label{background-size: 150px;background-position: 0 bottom;}
.star-input2>.input>label:hover~label{background-image: none;}
.star-input2>.input>label[for="p6"]{width:30px;z-index:5;}
.star-input2>.input>label[for="p7"]{width:60px;z-index:4;}
.star-input2>.input>label[for="p8"]{width:90px;z-index:3;}
.star-input2>.input>label[for="p9"]{width:120px;z-index:2;}
.star-input2>.input>label[for="p0"]{width:150px;z-index:1;}
.star-input2>output{display:inline-block;width:60px; font-size:18px;text-align:right; vertical-align:middle;}
#text{margin:20px}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://c	dn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script>
var requestnumber="";
window.addEventListener("load",init);
function init() {
var writeBtn = document.getElementById('writeBtn');
var requestfinishBtn = document.getElementById('requestfinishBtn');

	//수락
	var okbtn = document.getElementsByName("okbtn");
	for (var i = 0; i< okbtn.length; i++){
		okbtn[i].addEventListener('click', okbtn_f);
		}
	writeBtn.addEventListener('click', writeBtn_f);
	requestfinishBtn.addEventListener('click', requestfinishBtn_f);
}

//후기작성버튼클릭
function okbtn_f(event){
	console.log('후기작성');
	event.preventDefault(); 
	
	re_content = document.getElementById('re_content').value;
	let okbtnform = document.getElementById('okbtnform');
	requestnumber= event.target.parentNode.childNodes[1].value;
	console.log('후기작성클릭'+requestnumber+"/"+ event.target.parentNode.childNodes[1].value+"/"+ event.target.parentNode.parentNode.childNodes[1].id);

}

//거래완료
function requestfinishBtn_f(event){
	console.log('작성');
	event.preventDefault(); 
	var transfinishform = document.getElementById('transfinishform');
	//requestnumber
	console.log('요청번호'+requestnumber);
	const url = `/portfolio/transaction/transactionfinish`;
	console.log('url'+url);
	transfinishform.method = 'post';
	transfinishform.action = url;
	transfinishform.submit(); 
	alert("거래가 완료되었습니다.");

}
//후기작성
function writeBtn_f(event){
	console.log('작성');
	event.preventDefault(); 

	//후기 글자수
	var reviewForm = document.getElementById('reviewForm');
	var re_content = document.getElementById('re_content');
	var reviewExpReg =  /^.{20,100}$/     
	
if(!reviewExpReg.test(re_content.value)){
	
	alert("후기는 20글자 이상 500글자 미만으로 입력해주세요.");
	
	return
}else{
	
	//requestnumber
	console.log('요청번호'+requestnumber);
	const url = `/portfolio/transaction/review`;
	console.log('url'+url);
	reviewForm.method = 'post';
	reviewForm.action = url;
	reviewForm.submit(); 
	alert("후기작성이 완료되었습니다.");
}
	
}

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
	 <div class="mainName" >거래요청 관리페이지</div>
	 <hr>
	  <c:forEach var="rec2" items="${requestScope.tlist }"> 
		
			<div class="content">
			<div class= "c_image">
              <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform">
              <img  alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec2.productVO.p_img_path }" >
         </a>
            </div>
            <div class="content2">
		
			<table class="table table-striped">
			
  <tbody>
    <tr>
      <td>판매자 번호</td>
      <td>상품이름</td>
      <td>요청시간</td>
    </tr>
    <tr>
      <td> <i class="far fa-user-circle"></i> <span><a
								href="${contextpath }/portfolio/member/userInfo/${rec2.memberVO.id}">${rec2.memberVO.id  }</a>
							</span></td>
      <td> ${rec2.productVO.p_name }</td>
      <td>
<fmt:formatDate value="${rec2.t_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>
    </tr>
  </tbody>
</table>
			 	
	 
	    		
	    	<div id="r_cname"><span class="sname">요청내용</span></div>
	    
	  	<div id="r_content"> ${rec2.t_content } </div>
	  	</div>	
	  	<div class="btngrp">
	  		<form id="transfinishform" method="post">
	  		     <a class="btn btn-light okBtn" id="requestfinishBtn" href="">거래완료</a> 
	  		       <input type="hidden" name="p_number"  value="${rec2.productVO.p_number}"/>
	  		       </form>
	  		      	<form id="okbtnform" method="post">
	  		<input type="hidden" id="${rec2.t_number }" value="${rec2.t_number }">
	  		  		   		<input type="button"class="btn btn-light okBtn" name="okbtn" data-toggle="modal" data-target="#exampleModal" data-whatever="@getbootstrap" value="후기작성">
		</form>
		</div>
	  		    	

	  		<!-- 수락시 모달동작 -->

<!-- 모달사용 시작 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  
   <form role="form" method="post" autocomplete="off"  id="reviewForm" name="reviewForm">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">후기 작성</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
   
   <div class="container">
   <div class="content2">

    <input type="hidden" name="p_number"  value="${rec2.productVO.p_number}"/> 
	
     <div class="star-input1">상품에 대한 평점:
	<div class="input">
    	<input type="radio" name="grade1" value="1" id="p1">
    	<label for="p1">1</label>
    	<input type="radio" name="grade1" value="2" id="p2">
    	<label for="p2">2</label>
    	<input type="radio" name="grade1" value="3" id="p3">
    	<label for="p3">3</label>
    	<input type="radio" name="grade1" value="4" id="p4">
    	<label for="p4">4</label>
    	<input type="radio" name="grade1" value="5" id="p5">
    	<label for="p5">5</label>
  	</div>
  	<output for="star-input1"><b>0</b>점</output>						
</div>
     <div class="star-input2">거래에 대한 평점:
	<div class="input">
    	<input type="radio" name="grade2" value="1" id="p6">
    	<label for="p6">1</label>
    	<input type="radio" name="grade2" value="2" id="p7">
    	<label for="p7">2</label>
    	<input type="radio" name="grade2" value="3" id="p8">
    	<label for="p8">3</label>
    	<input type="radio" name="grade2" value="4" id="p9">
    	<label for="p9">4</label>
    	<input type="radio" name="grade2" value="5" id="p0">
    	<label for="p0">5</label>
  	</div>
  	<output for="star-input2"><b>0</b>점</output>						
</div>
      <div>

          <label for="message-text" class="col-form-label">Message:</label>
          <textarea class="form-control"  placeholder="거래 후기를 작성해 주세요"
          name="re_content" id="re_content"></textarea> </div>

      </div>
   </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning okBtn"  id="writeBtn">작성</button>
        <button type="button" class="btn btn-warning okBtn" data-dismiss="modal">취소</button>
      </div>
</div>
</div>
      </form>
     
<script src="${contextPath }/js/transaction/jquery-1.11.3.min.js"></script>
<script src="${contextPath }/js/transaction/star.js"></script>
  </div>
</div>
<!-- 모달 끝 -->
	 
		</div>
	 </c:forEach>
	  
	
<!-- 보드리스트시작 -->
			<div id="boardList">
	<!-- 페이지  -->
			<div class="paging">
				<c:if test="${transfindCriteria.pageCriteria.prev}">
					<div>
						<a	href="${contextPath }/transaction/transaction_notice/1"><i
							class="fas fa-angle-double-left"></i></a>
					</div>
					<div>
						<a	href="${contextPath }/transaction/transaction_notice/${transfindCriteria.pageCriteria.startPage}"><i
							class="fas fa-angle-left"></i></a>
					</div>
				</c:if>

				<c:forEach var="pageNum"
					begin="${transfindCriteria.pageCriteria.startPage }"	end="${transfindCriteria.pageCriteria.endPage }">
					<!-- 현재페이지와 요청페이지가 같으면 -->
					<c:if test="${pageNum == transfindCriteria.pageCriteria.rc.reqPage}">
					<div class="active">
					</c:if>
					<!-- 현재페이지와 요청페이지가 다르면 -->
					<c:if test="${pageNum != transfindCriteria.pageCriteria.rc.reqPage}">
					<div>
					</c:if>
					<a href="${contextPath }/transaction/transaction_notice/${pageNum }">${pageNum }</a>
					</div>
					

					</c:forEach>

			<c:if test="${reqfindCriteria.pageCriteria.next}">
				<div>
					<a	href="${contextPath }/transaction/transaction_notice/${transfindCriteria.pageCriteria.endPage+1}">
					<i class="fas fa-angle-right"></i></a>
				</div>
				<div>
					<a	href="${contextPath }/transaction/transaction_notice/${transfindCriteria.pageCriteria.finalEndPage}">
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




