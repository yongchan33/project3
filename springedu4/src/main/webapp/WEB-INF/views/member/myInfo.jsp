<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>
<title>내정보</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<style>
/* 메뉴 영역 */
nav {
	
}

.infotable thead th, .infotable  td {
text-align:left;}

.nametable thead th{
text-align:left;}

nav>.container-n {
	height: 50px;
	background-color: #9e00c5;
}

nav>.container-n>ul {
	display: flex;
	list-style-type: none;
	height: 50px;
	width: 500px;
	margin: 0px auto;
	line-height: 50px;
}

nav>.container-n>ul>li {
	width: 100px;
	text-align: center;
	font-size: 0.8rem;
}

nav>.container-n>ul>li>a {
	color: white;
	text-decoration: none;
	font-weight: bold;
}

nav>.container-n>ul>li>a:hover {
	text-decoration: underline;
}

.content {
	padding: 40px;
}

.bodyline {
	width: 100%;
	float: right;
}

.cimage {
	width: 220px;
	height: 340px;
}

.box {
	display: inline-block;
	padding: 20px;
	text-align: center;
}

.fas {
	padding-left: 10px;
}

.MS_prod_img_s {
	width: 100%;
	height: 100%;
}

main .container .mainName {
	font-size: 22px;
	margin: 20px;
	margin-top: 50px;
	text-align: center;
}

HTML CSSResult
EDIT ON /* reset & normalize */ 
* {
	box-sizing: border-box;
}

caption {
	position: absolute;
	left: -9999px;
	font-size: 0;
}

tr {
	border-bottom: 1px solid #dedede;
}

tr:last-child {
	border-bottom: 0;
}

th, td {
	height: 42px;
	font: 500 14px 'spoqa han sans';
	text-align: center;
}

/* css */
.tb_wrap {
	position: relative;
	width: 1000px;
	margin: 20px auto;
	padding-top: 43px;
}

.tb_box {
	max-height: 210px;
	overflow-y: scroll;
	border-bottom: 1px solid #dedede;
}

.tb {
	border-collapse: collapse;
	border-spacing: 0;
	width: 100%;
}
.cell1, .col1 {
      width: 100px;
}
.cell2 ,.col2 {
    width: 250px;
}
.cell2{
text-align:left;
}
.cell2 a{

margin-left: 50px;}
.cell3 ,.col3{
  width: 200px;
}
.cell4 ,.col4{
    width: 200px;
}
.cell5,.col5 {
  width: 200px;
}


.cell2_1, .col2_1 {
      width: 100px;
}
.cell2_2 ,.col2_2 {
    width: 200px;
}

.cell2_3 ,.col2_3{
  width: 150px;
}
.cell2_4 ,.col2_4{
    width: 150px;
}
.cell2_5,.col2_5 {
  width: 150px;
}

.cell2_6, .col2_6 {
  width:200px;
}


.fixed_top {
  display:inline-table;
  position:absolute;
  top:0;
  width:calc(100% - 17px);
  background:#eef7ff;
}
.fixed_top th {
  border-top:1px solid #dedede;
  border-bottom:1px solid #dedede;
}
.fas {
	padding: 0px;
}

.fa-star:before, .fa-star-half-alt {
	content: "\f005";
	color: #FFA542;
}
.nametag{
    margin-top: 50px;
    font-size: 1.3em;}
    
.table a:hover {
    text-decoration: none;
    font-weight: bold;
    cursor: pointer;
    color: black;
    text-shadow: 1px 2px 1px lightgrey;
    text-decoration: none;
}
</style>

</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp"%>


	<!-- header -->
	<%@ include file="/WEB-INF/views/include/header.jsp"%>

	<!-- 메뉴 -->
	<%@ include file="/WEB-INF/views/member/menu.jsp"%>

	<main>
		<div class="container">
			<div class="content">

				<div class="info">
					<table class="table table-striped nametable">
						<thead>
							<tr>
								<th scope="col" colspan="4">${requestScope.member.name }님의
									정보</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row"><i class="far fa-user-circle"></i>아이디 :
									${requestScope.member.id }</th>
<c:set var="num1" value="${requestScope.grade1}" />
<c:set var="num2" value="${requestScope.grade2}" />

								<c:if test="${requestScope.grade1 eq 0}">
									<td>상품 만족도 : <i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
								
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 0.5 && requestScope.grade1 lt 1}">
									<td>상품 만족도 : <i class="fas fa-star-half-alt"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 1 && requestScope.grade1 lt 1.5}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 1.5 && requestScope.grade1 lt 2}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 2 && requestScope.grade1 lt 2.5}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 2.5 && requestScope.grade1 lt 3}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 3 && requestScope.grade1 lt 3.5}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 3.5 && requestScope.grade1 lt 4}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 4 && requestScope.grade1 lt 4.5}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade1 ge 4.5 && requestScope.grade1 le 5}">
									<td>상품 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>

								<c:if test="${requestScope.grade2 eq 0}">
									<td>거래 만족도 : <i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
										<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 0.5 && requestScope.grade2 lt 1}">
									<td>거래 만족도 : <i class="fas fa-star-half-alt"></i><i
										class="far fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
												<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 1 && requestScope.grade2 lt 1.5}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
											<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
									<c:if
									test="${requestScope.grade2 ge 1.5 && requestScope.grade2 lt 2}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star-half-alt"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
											<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 2 && requestScope.grade2 lt 2.5}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="far fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
												<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 2.5 && requestScope.grade2 lt 3}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star-half-alt"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>		<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 3 && requestScope.grade2 lt 3.5}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="far fa-star"></i><i class="far fa-star"></i>
											<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 3.5 && requestScope.grade2 lt 4}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
												<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 4 && requestScope.grade2 lt 4.5}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star-half-alt"></i><i class="far fa-star"></i>
												<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>
								<c:if
									test="${requestScope.grade2 ge 4.5 && requestScope.grade2 le 5}">
									<td>거래 만족도 : <i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i><i
										class="fas fa-star"></i><i class="fas fa-star"></i>
												<fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점
									</td>
								</c:if>

							</tr>
						</tbody>
					</table>
					<table class="table table-striped infotable">
						<thead>
							<tr>
								<th scope="col" colspan="2">신상정보</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">연락처</th>
								<td>${requestScope.member.tel}</td>
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td>${requestScope.member.email}</td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td>${requestScope.member.address}</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="nametag">판매 내역</div>
				<hr />

				<!-- 내상품 리스트 -->
				<div class="tb_wrap">
					<div class="tb_box">
						<table class="table">
							<thead class="thead-dark">
								<tr class="fixed_top">
									<th scope="col" class="col1">상품번호</th>
									<th scope="col" class="col2">상품명</th>
									<th scope="col" class="col3">판매가격</th>
									<th scope="col" class="col4">등록일시</th>
									<th scope="col" class="col5">판매상태</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="rec" items="${requestScope.myproduct }">
									<tr>
										<th scope="row" class="cell1">${rec.p_number}</th>
										<td class="cell2"><a
											href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}">
												${rec.p_name}</a></td>
										<td class="cell3"><div class="cprice"><fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원</div>   </td>
										<td class="cell4">
<fmt:formatDate value="${rec.p_time }" type="both" dateStyle="medium" timeStyle="short" />
</td>
										<c:if test="${rec.p_sale_condition eq '1'}">
											<td class="cell5">판매중</td>
										</c:if>
										<c:if test="${rec.p_sale_condition eq '2'}">
											<td class="cell5">거래중</td>
										</c:if>
										<c:if test="${rec.p_sale_condition eq '3'}">
											<td class="cell5">판매완료</td>
										</c:if>



									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<div class="nametag">후기 내역</div>
				<hr />
				<div class="tb_wrap">
					<div class="tb_box">
						<table class="table">
							<thead class="thead-dark">
								<tr class="fixed_top">
									<th scope="col" class="col2_1">상품번호</th>
									<th scope="col" class="col2_2">상품명</th>
									<th scope="col" class="col2_3">판매금액</th>
									<th scope="col" class="col2_4">상품 만족도</th>
									<th scope="col" class="col2_5">거래 만족도</th>
									<th scope="col" class="col2_6">일시</th>

								</tr>
							</thead>
							<tbody>
								<c:forEach var="rec2" items="${requestScope.myrelist }">
									<tr>
										<th scope="row" class="cell2_1">${rec2.p_number}</th>
										<td class="cell2_2"><a
											href="${contextpath }/portfolio/product/productInfo?p_number=${rec2.p_number}">
												${rec2.p_name}</a></td>
										<td class="cell2_3"><div class="cprice" ><fmt:formatNumber value="${rec2.p_sale_price }" pattern="###,###,###" />원</div>   </td>
								
											<c:if test="${rec2.reviewVO.grade1 eq 0}">
											<td class="cell2_4"> <i class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i></td>
										</c:if>
										<c:if
											test="${rec2.reviewVO.grade1 eq 1 }">
											<td class="cell2_4"> <i class="fas fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i></td>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade1 eq 2 }">
											<td class="cell2_4"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
											 class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i></td>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade1 eq 3}">
											<td class="cell2_4"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
											 class="fas fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade1 eq 4 }">
											<td class="cell2_4"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="far fa-star"></i></td>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade1 eq 5 }">
											<td class="cell2_4"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i></td>
										</c:if>




										<c:if test="${rec2.reviewVO.grade2 eq 0}">
											<td class="cell2_5"> <i class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i></td>
										</c:if>
										
										
										<c:if
											test="${rec2.reviewVO.grade2 eq 1 }">
											<td class="cell2_5"><i class="fas fa-star"></i><i class="far fa-star"></i><i
											 class="far fa-star"></i><i
												class="far fa-star"></i><i class="far fa-star"></i></td>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade2 eq 2 }">
											<td class="cell2_5"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
											 class="far fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i>
										</c:if>
								
								<c:if
											test="${rec2.reviewVO.grade2 eq 3 }">
											<td class="cell2_5"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
											 class="fas fa-star"></i><i class="far fa-star"></i><i
												class="far fa-star"></i>
										</c:if>
										<c:if
											test="${rec2.reviewVO.grade2 eq 4}">
											<td class="cell2_5"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="far fa-star"></i></td>
										</c:if>
									
										<c:if
											test="${rec2.reviewVO.grade2 eq 5 }">
											<td class="cell2_5"><i class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i><i class="fas fa-star"></i><i
												class="fas fa-star"></i></td>
										</c:if>
										<td class="cell2_6"><fmt:formatDate value="${rec2.reviewVO.re_time}" type="both" dateStyle="medium" timeStyle="short" /></td>



									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>


			</div>
		</div>
	</main>

	<!-- 푸터 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
