<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${contextPath }/css/paging.css">

<title>추천순</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/product/sidebar.css">
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

<script defer src="${contextPath }/js/product/recommand.js"></script>
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
	
 
	</div>
		<div class="bodyline">
	  <div class="headline">	
	  	<div class="mtitle">추천의류</div>

	<div class="clist-w">

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
	<!-- 이미지 출력 -->
	 <div class="cbox"> 
	  <c:forEach var="rec" items="${requestScope.recommandlist }">
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
		  <span class="bastisBtn">${rec.memberVO.id }<i class="far fa-heart fa-1x" id="heartBtn" style="color:red"></i></span>
		 </c:if>
		 <c:if test="${checkheart ne '1' }">
		  <span class="bastisBtn">${rec.memberVO.id }<i class="far fa-heart fa-1x" id="heartBtn"></i></span>
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
	</main>
	
	
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>