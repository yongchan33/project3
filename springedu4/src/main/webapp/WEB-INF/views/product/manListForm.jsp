<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<title>남성의류 카테고리</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
<link rel="stylesheet" href="${contextPath }/css/paging.css">
<style>
	* {
		/*  outline: 1px solid red;  */
		box-sizing: border-box;
	}
	
	main{display:flex;
	
	justify-content: space-between; }
	

	
	
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
		/* 관심상품 표시 */
	.bastisBtn{
    display: flex;
    justify-content: space-between;

    height: 20px;
    size: 10px;
   
    }
   .productlist{
   height:1000px;}

	</style>

<script defer src="${contextPath }/js/product/manlist.js"></script>
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
	  	<div class="mtitle">남성의류</div>
	<div class="clist-w">

		<ul>
			<li><a name="listCategory" value="21" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/21/${findCriteria.searchType}/${findCriteria.keyword}">아우터</a></li>
			<li><a name="listCategory" value="22" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/22/${findCriteria.searchType}/${findCriteria.keyword}">반팔/긴팔/민소매</a></li>
			<li><a name="listCategory" value="23" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/23/${findCriteria.searchType}/${findCriteria.keyword}">니트/가디건</a></li>
			<li><a name="listCategory" value="24" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/24/${findCriteria.searchType}/${findCriteria.keyword}">셔츠</a></li>
			<li><a name="listCategory" value="25" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/25/${findCriteria.searchType}/${findCriteria.keyword}">후드/맨투맨</a></li>
			<li><a name="listCategory" value="26" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/26/${findCriteria.searchType}/${findCriteria.keyword}">팬츠</a></li>
			<li><a name="listCategory" value="27" href="${contextPath }/product/manlist/${requestScope.reqPagecategory }/${requestScope.reqmlist }/27/${findCriteria.searchType}/${findCriteria.keyword}">수트</a></li>
			 
<!-- 			<li><a name="listCategory" value="11">아우터</a></li>
			<li><a name="listCategory" value="12">반팔/긴팔/민소매</a></li>
			<li><a name="listCategory" value="13">원피스</a></li>
			<li><a name="listCategory" value="14">블라우스/셔츠</a></li>
			<li><a name="listCategory" value="15">니트/가디건</a></li>
			<li><a name="listCategory" value="16">후드/맨투맨</a></li>
			<li><a name="listCategory" value="17">팬츠</a></li>
			<li><a name="listCategory" value="18">스커트</a></li>
			<li><a name="listCategory" value="19">수트</a></li> -->
			
			
		
			
		</ul>
	
	</div>
	
	<div class="mlist">
		<ul>
			<li><a id="1">최신순</a></li>
			<li><a id="2">관심상품</a></li>
			<li><a id="3">추천상품</a></li>
			<li><a id="4">낮은가격순</a></li>
			<li><a id="5">높은가격순</a></li>
		</ul>
	</div>
	
	</div>
	<!-- 상품리스트 -->
	<div class="productlist">
	 <div class="cbox"> 
	
	  <c:forEach var="rec" items="${requestScope.list }">
		<div class = "box"> 	
		<div class="seller-name">
		<c:set var="checkheart" value='0' />
		 <!-- 관심상품체크 -->
		 <c:forEach var="rec2" items="${requestScope.basketchecklist }">
		 <c:if test="${rec2.p_number eq  rec.p_number}">
		 <c:set var="checkheart" value='1' />
		 </c:if>
		 </c:forEach>
		 <c:if test="${checkheart eq '1' }">
		  <span class="bastisBtn"><a href="${contextpath }/portfolio/member/userInfo/${rec.memberVO.id}">${rec.memberVO.id }</a><i class="far fa-heart fa-1x" id="heartBtn" style="color:red"></i></span>
		 </c:if>
		 <c:if test="${checkheart ne '1' }">
		  <span class="bastisBtn"><a href="${contextpath }/portfolio/member/userInfo/${rec.memberVO.id}">${rec.memberVO.id }</a><i class="far fa-heart fa-1x" id="heartBtn"></i></span>
		 </c:if>
		</div>
		<a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform"></a>
		<div class="cimage">
	   <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}"> <img alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec.p_img_path }"  ></a>
		</div>
		<div class="cname"><a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}">${rec.p_name }</a></div>
		<div class="cprice"><fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원</div>   
	</div>
	 </c:forEach>
	</div>
	</div>
	 <!-- 보드리스트시작 -->
			<div id="boardList">
	 <!-- 페이지  -->
	  <div class="paging">
	        <c:if test="${findCriteria.pageCriteria.prev}">
		        <div>
		        	<a href="${contextPath }/product/manlist/1/${requestScope.reqmlist }/${requestScope.listCategory }/${findCriteria.searchType}/${findCriteria.keyword}"><i class="fas fa-angle-double-left"></i></a>
		        </div>
		        <div>
		        	<a href="${contextPath }/product/manlist/${findCriteria.pageCriteria.startPage-1}/${requestScope.reqmlist }/${requestScope.listCategory }/${findCriteria.searchType}/${findCriteria.keyword}"><i class="fas fa-angle-left"></i></a>
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
		        	<a href="${contextPath }/product/manlist/${pageNum }/${requestScope.reqmlist }/${requestScope.listCategory }/${findCriteria.searchType}/${findCriteria.keyword}">${pageNum }</a>
		        </div>

		        </c:forEach>
		         <c:if test="${findCriteria.pageCriteria.next}">
		        <div>
		        	<a href="${contextPath }/product/manlist/${findCriteria.pageCriteria.endPage+1}/${requestScope.reqmlist }/${requestScope.listCategory }/${findCriteria.searchType}/${findCriteria.keyword}"><i class="fas fa-angle-right"></i></a>
		        </div>
		        <div>
		        	<a href="${contextPath }/product/manlist/${findCriteria.pageCriteria.finalEndPage}/${requestScope.reqmlist }/${requestScope.listCategory }/${findCriteria.searchType}/${findCriteria.keyword}"><i class="fas fa-angle-double-right"></i></a>
		        </div>
		        </c:if>
		        </div>
 <div class="find">
	   <form:form modelAttribute="findCriteria">
		          <form:select path="searchType">
   							<form:options items="${codeDecodeList}" 
  														itemLabel="decode" 
  														itemValue="code" />	          
		          </form:select>
		          <form:input type="text" path="keyword" id="keyword" onKeyDown="pressEnter()"/>
		          <button id="findBtn" type="button"  class="btn btn-outline-secondary" >검색</button>
		        </form:form>		        
 </div>
	
	
	
	
	

	</main>
	
	
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>