<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>

<title>FAQ</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<style>
* {
	/* outline: 1px solid red;   */
	box-sizing: border-box;
}

main{display:flex;
	
	justify-content: space-between;}


.headline{width:100%; height:20%;float:right;}

.title{text-align:center;margin:10px;font-size:2em;padding:20px;}

.search{text-align:right;margin-right:60px;}


.bodyline {
	width: 100%;
	float: right;
	margin-top:30px;
	text-align:center;
	height:500px;
}

.table ul{display:flex; margin-right:100px;border-bottom: 1px solid gray;}

.list{padding:10px; 
 	
	border-top: 2px solid gray;
	border-bottom: 1px solid gray;
	width: 100%;}
  input[id*="faqanswer"] {
        display: none;
      }
      input[id*="faqanswer"] + label {
        display: block;
        padding: 20px;
        border: 1px soild lightgray;
        border-bottom: 0;
        color: black;
        font-weight: 900;
        background-color: lightgray;
        cursor: pointer;
        position: relative;
            text-align: left;
      }
      input[id*="faqanswer"] + label em {
        position: absolute;
        top: 50%;
        right: 10px;
        width: 30px;
        height: 30px;
        margin-top: -15px;
        display: inline-block;
        background: url("${contextPath }/img/arrow.png") 0 0 no-repeat;
      }
      input[id*="faqanswer"] + label + div {
        max-height: 0;
        transition: all 0.35s;
        overflow: hidden;
    text-align: left;
        font-size: 11px;
      }
      input[id*="faqanswer"] + label + div p {
        display: inline-block;
        padding: 20px;
        
      }
      input[id*="faqanswer"]:checked + label + div {
        max-height: 100px;
      }
      input[id*="faqanswer"]:checked + label em {
        background-position: 0 -30px;
      }
.content{
width:85%;
	padding:50px;
	padding-top:0px;	
}
	.nav>ul>li {
	width:200px;}
/* .num {display:inline-block; width:50px;height:40px;}*/
 
main .container .mainName{
font-size : 24px;
margin : 20px;
margin-top : 30px;
text-align : LEFT;
}
</style>
<script>
	
</script>
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp"%>

	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- 메뉴 -->
	<%@ include file="/WEB-INF/views/include/bmenu.jsp"%>
	<!-- 본문 -->
	<main>
		<!-- side bar -->
 <%@ include file="/WEB-INF/views/product/bsidebar.jsp" %>
	<div class="container">	
	 <div class="content">
	<div class="headline">	
	<div class="mainName" >FAQ</div>
	 <hr>
	

	<!-- <div class="search">
		<input type="text"> <input type="button" value="검색"/>
	</div> -->
	
	</div>

			<div class="bodyline">

			 <div class="accordion">
      <input type="radio" name="accordion" id="faqanswer01" />
      <label for="faqanswer01">Q1 . 구매 요청했는데 판매자가 응답을 안 했어요.<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 7일간 응답이 없으면 상품등록이 취소됩니다.</p></div>
      <input type="radio" name="accordion" id="faqanswer02" />
      <label for="faqanswer02">Q2 . 등록한 상품이 삭제가 안됩니다.<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 거래중인 물품은 삭제할 수 없습니다. 다시한번 확인하시기바랍니다.</p></div>
      <input type="radio" name="accordion" id="faqanswer03" />
      <label for="faqanswer03">Q3 . 홈페이지 접속이 안됩니다.<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 홈페이지 접속이 안되시거나, 이용에 문제가 있으신 경우
1:1 문의 또는 고객센터(1234-5678)로 연락주시면 도와드리겠습니다.</p></div>
      <input type="radio" name="accordion" id="faqanswer04" />
      <label for="faqanswer04">Q4 . 구매 요청했는데 판매자가 응답을 안 했어요<em></em></label>
      <div><p><i class="far fa-comment-dots"></i>회원정보 수정은 로그인 하신 후,
									메인페이지 우측 상단 '이름'을 클릭하여 내정보 수정페이지에서 가능합니다.</p></div>
      <input type="radio" name="accordion" id="faqanswer05" />
      <label for="faqanswer05">Q5 . 아이디를 변경하고 싶어요.<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 아이디 변경은 어렵습니다.</p></div>
	<input type="radio" name="accordion" id="faqanswer06" />
      <label for="faqanswer06">Q6 . 비밀번호를 잊으셨나요?<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 니옷내옷 로그인 페이지에서 비밀번호 찾기 링크를 클릭하세요.
아이디를 입력하신 후 이메일 인증을 받으신 후 새 비밀번호를 입력하시면 됩니다.
비밀번호를 찾는 과정에서 오류가 나거나 궁금증이 있으시면 쿠돈 고객센터(1234-5678)로 연락주세요.</p></div>
	 <input type="radio" name="accordion" id="faqanswer07" />
      <label for="faqanswer07">Q7 . 아이디가 정지된 것 같아요.<em></em></label>
      <div><p><i class="far fa-comment-dots"></i> 니옷내옷은 이용약관에 따라 회원님의 계정을 정지할 수 있습니다.
				이와 관련해 문의사항이 있으시다면 고객센터(1234-5678)로 연락주시면 도와드리겠습니다.</p></div>
    	</div>
			</div>

</div>
</div>
		</main>


		<!-- 푸터 -->
		<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>