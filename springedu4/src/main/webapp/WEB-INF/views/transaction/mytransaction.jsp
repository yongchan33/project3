<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title>내거래보기</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<link rel="stylesheet" href="${contextPath }/css/paging.css">
<style>

* {
		/*  outline: 1px solid red;  */
		box-sizing: border-box;
	}
	
	main{display:flex;
	
	justify-content: space-around;}
	
	


.title {
	font-size : 24px;
	text-align : center;
	margin-top : 30px;
}

.headline {
	
	height: 80px;
	
}

.list>ul {
	text-align: center;
	margin: 10px;
	border-top: 1px solid lightgray;
	border-bottom: 1px solid lightgray;
}

.list>ul>li {
	display: inline-block;
	padding: 10px;
}
.list>ul>li a{text-decoration:none;}
.list>ul>li a:hover{font-weight:bold; cursor: pointer;
								color:black;
								text-shadow:1px 2px 1px lightgray;
								text-decoration:none;}	
}


.content {
	text-align: center;
	padding-top: 40px;
}

.content>li {
	padding-top: 20px;
}

	.bodyline{
	
	padding:50px;
	padding-top:0px;	}
	
	.list_view{
	    border-collapse: collapse;
    border-spacing: 0;
    margin: auto;
    width: 100%;}
	 

.list>td {
    padding: 20px;
    }
.product {border: solid 1px lightgray; margin:10px;}

.product>td{height:120px; padding:10px; vertical-align:middle;}

input[type="button"]{width:100px; height:30px;margin:10px; padding:0em;font-weight:300;
		line-height:30px; text-align:center; font-size: 14px;}


main .container .mainName{
font-size : 24px;
margin : 20px;
margin-top : 30px;
text-align : LEFT;
}

	
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
</style>

<script>
	window.addEventListener("load", init);
	function init() {
		var allmyproduct = document.getElementById("allmyproduct");
		var requestList = document.getElementById("requestList");
		var transactionList = document.getElementById("transactionList");
		var buyproduct = document.getElementById("buyproduct");

		/* 	var requestCheckBtn = document.getElementsByName("requestCheckBtn");
			var transactionCheckBtn = document.getElementsByName("transactionCheckBtn"); */


		allmyproduct.addEventListener("click", allmyproduct_f);
		requestList.addEventListener("click", requestList_f);
		transactionList.addEventListener("click", transactionList_f);
		buyproduct.addEventListener("click", buyproduct_f);

		/* 	for (var i = 0; i < requestCheckBtn.length; i++) {
		
				requestCheckBtn[i].addEventListener('click', requestCheckBtn_f);
		 }
		
		 for (var i = 0; i < transactionCheckBtn.length; i++) {
		
			 transactionCheckBtn[i].addEventListener('click', transactionCheckBtn_f);
		 }  */
	}

	//전체보기
	function allmyproduct_f(event) {
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/transaction/mytransaction/1/1`;
		window.location.href = url;
	}

	//판매 중 상품
	function requestList_f(event) {
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/transaction/mytransaction/1/2`;
		window.location.href = url;
	}

	//거래 중 상품
	function transactionList_f(event) {
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/transaction/mytransaction/1/3`;
		window.location.href = url;
	}

	//판매완료상품
	function buyproduct_f(event) {
		event.preventDefault(); //기본이벤트 막기
		console.log("전체보기 선택함.");
		const url = `/portfolio/transaction/mytransaction/1/4`;
		window.location.href = url;
	}
/* 	//구매요청확인
	function requestCheckBtn_f(event){
		console.log('요청수락');
		event.preventDefault(); 

		let requestCheckform = document.getElementById('requestCheckform');
		requestnumber= event.target.parentNode.childNodes[1].value;
		console.log('요청수락클릭'+requestnumber+"/"+ event.target.parentNode.childNodes[1].value+"/"+ event.target.parentNode.parentNode.childNodes[1].id);

	
	}
	//거래요청확인
	function transactionCheckBtn_f(event){
		console.log('요청수락');
		event.preventDefault(); 
		let transactionCheckform = document.getElementById('transactionCheckform');
		requestnumber= event.target.parentNode.childNodes[1].value;
		console.log('요청수락클릭'+requestnumber+"/"+ event.target.parentNode.childNodes[1].value+"/"+ event.target.parentNode.parentNode.childNodes[1].id);

	} */
</script>
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp"%>

	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- 메뉴 -->
	<%@ include file="/WEB-INF/views/member/myproductmenu.jsp"%>
	<!-- 본문 -->
	<main>
		<!-- side bar -->
		<%@ include file="/WEB-INF/views/product/msidebar.jsp"%>


			<div class="container">
			<div class="mainName">내거래 관리페이지</div>
			<hr>
			<!-- 이미지 출력 -->
			<!-- <div class="cbox"> -->

			<div class="box">
				<div class="seller-name">
					<div class="headline">
						<div class="list">
							<ul>
								<li><a id="allmyproduct">전체보기</a></li>
								<span id="line">|</span>
								<li><a id="requestList">구매요청 상품</a></li>
								<span id="line">|</span>
								<li><a id="transactionList">거래중</a></li>
								<span id="line">|</span>
								<li><a id="buyproduct">구매완료 상품</a></li>
							</ul>
						</div>
					</div>

					<div class="bodyline">
						<table class="list_view">
							<thead align=center>
								<tr class="list">
									<td>사진</td>
									<td>상품명</td>
									<td>요청상태</td>
									<td>진행상태</td>
									<td>요청시간</td>
									<td>내용</td>


								</tr>
							</thead>
							<c:forEach var="rec" items="${requestScope.mytransaction }"
								varStatus="vs">
								<c:set var="i" value="${rec.productVO.p_sale_condition}" />
								<c:set var="rc" value="${rec.r_condition}" />
								<tbody align=center>
									<c:if test="${i == 1}">
										<tr class="product">
											<td class="c_image"><a
												href="${contextpath }/portfolio/product/productInfo?p_number=${rec.productVO.p_number}"
												class="cinform" id="${rec.productVO.p_number}"> <img
													width="175" height="115" alt="이미지 오류" class="MS_prod_img_s"
													src="/portfolio/${rec.productVO.p_img_path }">
											</a></td>
											<td>${rec.productVO.p_name }</td>

											<td><c:if test="${rc == 1}">구매요청</c:if> <c:if
													test="${rc == 2}">수락</c:if> <c:if test="${rc == 3}">거절</c:if>
											</td>

											<td><c:if test="${i == 1}">판매중</c:if> <c:if
													test="${i == 2}">거래중</c:if> <c:if test="${i == 3}">판매완료</c:if>
											</td>
											<td>
<fmt:formatDate value="${rec.r_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>

											<td>
												<form id="requestCheckform" method="post">
													<!-- Button trigger modal -->
													<input type="button" class="btn btn-warning"
														name="requestCheckBtn" data-toggle="modal"
														data-target="#exampleModalCenter${vs.index}"
														value="요청내용확인">

												</form>
											</td>

										</tr>

									</c:if>
								</tbody>
								<tbody align=center>
									<c:if test="${i == 2}">
										<tr class="product">

											<td class="c_image"><a
												href="${contextpath }/portfolio/product/productInfo?p_number=${rec.productVO.p_number}"
												class="cinform" id="${rec.productVO.p_number}"> <img
													width="175" height="115" alt="이미지 오류" class="MS_prod_img_s"
													src="/portfolio/${rec.productVO.p_img_path }">
											</a></td>
											<td>${rec.productVO.p_name }</td>

											<td><c:if test="${rc == 1}">구매요청</c:if> <c:if
													test="${rc == 2}">수락</c:if> <c:if test="${rc == 3}">거절</c:if>
											</td>

											<td><c:if test="${i == 1}">판매중</c:if> <c:if
													test="${i == 2}">거래중</c:if> <c:if test="${i == 3}">판매완료</c:if>
											</td>
											<td>
<fmt:formatDate value="${rec.r_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>
											<td>
												<form id="requestCheckform" method="post">
													<!-- Button trigger modal -->
													<input type="button" class="btn btn-warning"
														name="requestCheckBtn" data-toggle="modal"
														data-target="#exampleModalCenter${vs.index}"
														value="요청내용확인">

												</form>
												<form id="transactionCheckform" method="post">
													<!-- Button trigger modal -->
													<input type="button" class="btn btn-warning"
														name="transactionCheckBtn" data-toggle="modal"
														data-target="#exampleModalCenter2${vs.index}"
														value="거래내용확인">
												</form>
											</td>

										</tr>

									</c:if>
								</tbody>
								<tbody align=center>
									<c:if test="${i == 3}">
										<tr class="product">

											<td class="c_image"><a
												href="${contextpath }/portfolio/product/productInfo?p_number=${rec.productVO.p_number}"
												class="cinform" id="${rec.productVO.p_number}"> <img
													width="175" height="115" alt="이미지 오류" class="MS_prod_img_s"
													src="/portfolio/${rec.productVO.p_img_path }">
											</a></td>
											<td>${rec.productVO.p_name }</td>

											<td><c:if test="${rc == 1}">구매요청</c:if> <c:if
													test="${rc == 2}">수락</c:if> <c:if test="${rc == 3}">거절</c:if>
											</td>

											<td><c:if test="${i == 1}">판매중</c:if> <c:if
													test="${i == 2}">거래중</c:if> <c:if test="${i == 3}">판매완료</c:if>
											</td>
											<td>
<fmt:formatDate value="${rec.r_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>
											<td>
												<form id="requestCheckform" method="post">
													<!-- Button trigger modal -->
													<input type="button" class="btn btn-warning"
														name="requestCheckBtn" data-toggle="modal"
														data-target="#exampleModalCenter${vs.index}"
														value="요청내용확인">

												</form>
												<form id="transactionCheckform" method="post">
													<!-- Button trigger modal -->
													<input type="button" class="btn btn-warning"
														name="transactionCheckBtn" data-toggle="modal"
														data-target="#exampleModalCenter2${vs.index}"
														value="거래내용확인">
												</form>
											</td>
										</tr>

									</c:if>
								</tbody>



								<!-- Modal -->
								<div class="modal fade" id="exampleModalCenter${vs.index}"
									tabindex="-1" role="dialog"
									aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLongTitle">구매요청내용확인</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body"> ${rec.r_content }</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>

								<!-- Modal -->
								<div class="modal fade" id="exampleModalCenter2${vs.index}"
									tabindex="-1" role="dialog"
									aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLongTitle">거래요청내용확인</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												${rec.transactionVO.t_content }</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
								</div>

							</c:forEach>
						</table>
					</div>


				</div>
			</div>
			<!-- 보드리스트시작 -->
			<div id="boardList">
				<!-- 페이지  -->
				<div class="paging">
					<c:if test="${mytransfindCriteria.pageCriteria.prev}">
						<div>
							<a	href="${contextPath }/transaction/mytransaction/1/${requestScope.trsstate }"><i
								class="fas fa-angle-double-left"></i></a>
						</div>
						<div>
							<a	href="${contextPath }/transaction/mytransaction/${mytransfindCriteria.pageCriteria.startPage-1}/${requestScope.trsstate }"><i
								class="fas fa-angle-left"></i></a>
						</div>
					</c:if>
					<c:forEach var="pageNum"
						begin="${mytransfindCriteria.pageCriteria.startPage }"	end="${mytransfindCriteria.pageCriteria.endPage }">
						<!-- 현재페이지와 요청페이지가 같으면 -->
						<c:if test="${pageNum == mytransfindCriteria.pageCriteria.rc.reqPage}">
							<div class="active">
						</c:if>
						<!-- 현재페이지와 요청페이지가 다르면 -->
						<c:if test="${pageNum != mytransfindCriteria.pageCriteria.rc.reqPage}">
							<div>
							</c:if>
								<a	href="${contextPath }/transaction/mytransaction/${pageNum }/${requestScope.trsstate }">${pageNum }</a>
							</div>
						

					</c:forEach>


					<c:if test="${mytransfindCriteria.pageCriteria.next}">
						<div>
							<a	href="${contextPath }/transaction/mytransaction/${mytransfindCriteria.pageCriteria.endPage+1}/${requestScope.trsstate }">
								<i class="fas fa-angle-right"></i>
							</a>
						</div>
						<div>
							<a	href="${contextPath }/transaction/mytransaction/${mytransfindCriteria.pageCriteria.finalEndPage}/${requestScope.trsstate }">
								<i class="fas fa-angle-double-right"></i></a>
						</div>
					</c:if>
				</div>
			</div>
			<!-- 보드리스트종료 -->
	</main>


	<!-- 푸터 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>