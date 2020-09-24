<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>

<title>후기 게시판</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<link rel="stylesheet" href="${contextPath }/css/paging.css">
<style>
* {
	/*  outline: 1px solid red;  */
	box-sizing: border-box;
}

main {
	display: flex;
	justify-content: space-between;
}

.bodyline {
	width: 85%;
	padding: 50px;
	padding-top: 0px;
}

.cimage {
	width: 100%;
	height: 350px;
	margin: auto;
	text-align: center;
}

.box {
	display: inline-block;
	margin-top: 40px;
	text-align: left;
	margin: 20px;
}

.box:hover {
	box-shadow: 1px 1px 20px #ddd;
}

.cbox {
	display: grid;
	grid-template-columns: 20% 20% 20% 20% 20%;
}

.fas {
	padding-left: 10px;
}

.MS_prod_img_s {
	width: 100%;
	height: 100%;
}

.mainName {
	font-size: 24px;
	margin: 20px;
	margin-top: 30px;
	text-align: LEFT;
}

.fas {
	padding: 0px;
}
.fa-star:before {
	content: "\f005";
	color: #FFA542;
}

.good {
	margin: 5px;
}

.productName {
	font-size: 1.2em;
}


.seller-name {
	margin: 5px;
	margin-top: 10px;
	text-align: left;
}

.productName {
	margin: 5px;
	text-align: right;
}

</style>
<script>
	/* 만약 마우스를 올리면 별표 나오기
	 1. 빈별표 <i class="far fa-star"></i>
	 2. 반별표 <i class="fas fa-star-half-alt"></i>
	 3. 색별표 <i class="fas fa-star"></i>
	 */
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
		<%@ include file="/WEB-INF/views/product/bsidebar.jsp"%>
		<div class="bodyline">


			<div class="mainName">후기</div>
			<hr>


			<div class="cbox">
				<c:forEach var="rec" items="${requestScope.relist}"
					varStatus="status">

					<div class="box">
						<div class="seller-name">
							<i class="far fa-user-circle"></i> <span><a
								href="${contextpath }/portfolio/member/userInfo/${rec.memberVO.id}">${rec.memberVO.id  }</a>
							</span>
						</div>

						<a href="#" class="cinform">
							<div class="cimage">
								<img class="MS_prod_img_s" src="/portfolio/${rec.p_img_path }"
									data-toggle="modal"
									data-target="#staticBackdrop${status.index}">
							</div>
						</a>
						<div class="g-good good">


							상품만족
							<c:set var="i" value="${rec.reviewVO.grade1 }" />
							<c:if test="${i == 1}">
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 2}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 3}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 4}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 5}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</c:if>
						</div>
						<div class="p-good good">
							구매만족
							<c:set var="i" value="${rec.reviewVO.grade2 }" />
							<c:if test="${i == 1}">
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 2}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 3}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 4}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="far fa-star"></i>
							</c:if>
							<c:if test="${i == 5}">
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
							</c:if>
						</div>


						<div class="productName">
							<a>${rec.p_name}</a>
						</div>
						<!-- Modal -->
						<div class="modal fade" id="staticBackdrop${status.index}"
							data-backdrop="static" data-keyboard="false" tabindex="-1"
							aria-labelledby="staticBackdropLabel" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="staticBackdropLabel">
											<sapn style="font-size:0.7em;">가격 :
											<fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원  / 브랜드 : ${rec.p_brand } / 작성일 :
											<fmt:parseDate value='${rec.reviewVO.re_time }' var='trading_day' pattern='yyyymmdd'/>
											<fmt:formatDate value="${trading_day}" type="both" dateStyle="medium" timeStyle="short" /></sapn>
											
										</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">${rec.reviewVO.re_content }</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">확인</button>
									</div>
								</div>
							</div>
						</div>
						<%-- 	판매자:<a href="#">${rec.memberVO.id  }</a> <br> 상품명:<a data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">${rec.p_name}</a> --%>

						<%-- <div class="collapse" id="collapseExample">
  <div class="card card-body">
   ${rec.reviewVO.re_content }
  </div>
</div> --%>

					</div>
				</c:forEach>

			</div>

			<!-- 보드리스트시작 -->
			<div id="boardList">
	 <!-- 페이지  -->
	  <div class="paging">
	        <c:if test="${findCriteria.pageCriteria.prev}">
		        <div>
		        	<a href="${contextPath }/board/reviewList/1"><i class="fas fa-angle-double-left"></i></a>
		        </div>
		        <div>
		        	<a href="${contextPath }/board/reviewList/${findCriteria.pageCriteria.startPage-1}"><i class="fas fa-angle-left"></i></a>
		        </div>
	        	</c:if>
<c:forEach var="pageNum" begin="${findCriteria.pageCriteria.startPage }"
		        												 end="${findCriteria.pageCriteria.endPage }" >
		        <!-- 현재페이지와 요청페이지가 같으면 -->
		         <c:if test="${pageNum == findCriteria.pageCriteria.rc.reqPage}">												 
		        <div class="active">
		        </c:if>
		        <!-- 현재페이지와 요청페이지가 다르면 -->
		        <c:if test="${pageNum != findCriteria.pageCriteria.rc.reqPage}">
		        <div>
		         </c:if>	
		        <a href="${contextPath }/board/reviewList/${pageNum }">${pageNum }</a>
		        </div>		        
				
		        </c:forEach>
		        		
		         <c:if test="${findCriteria.pageCriteria.next}">
		        <div>
		        	<a href="${contextPath }/board/reviewList"><i class="fas fa-angle-right"></i></a>
		        </div>
		        <div>
		        	<a href="${contextPath }/board/reviewList"><i class="fas fa-angle-double-right"></i></a>
		        </div>
		        </c:if>
		        </div>
			
		</div>
	</main>

	<!-- 푸터 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>