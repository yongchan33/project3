<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>내상품보기</title>
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
	
	.list_view{
	    border-collapse: collapse;
    border-spacing: 0;
    margin: auto;
    width: 100%;}
	


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
	 

.list>td{padding:20px 40px 20px 40px; width:200px;}

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
		#line{
	color:lightgray;}
</style>

<script defer src="${contextPath }/js/product/myproduct.js"></script>
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/member/myproductmenu.jsp" %>
  <!-- 본문 -->
  <main>
			<!-- side bar -->
 <%@ include file="/WEB-INF/views/product/msidebar.jsp" %>
			
			
	  <div class="container">
	 <div class="mainName" >내상품 관리페이지</div>
	 <hr>
	<!-- 이미지 출력 -->
	<!-- <div class="cbox"> -->
	 
	<div class = "box"> 	
		<div class="seller-name">
      <div class="headline">
        <div class="list">
          <ul>
            <li><a id="allmyproduct">전체보기</a></li><span>|</span>
            <li><a id="product">판매 중 상품</a></li><span>|</span>
            <li><a id="trsproduct">거래 중 상품</a></li><span>|</span>
            <li><a id="finiproduct">판매완료 상품</a></li>
        
          </ul>
        </div>
      </div>
     
      <div class="bodyline">
        <table class="list_view">
          <thead align=center>
            <tr class="list">
              <td >사진</td>
              <td >상품명</td>
              <td>진행상태</td>
              <td>정보</td>
              <td></td>
            </tr>
          </thead>	
           <c:forEach var="rec" items="${requestScope.myproduct }">
           <c:set var="i" value="${rec.p_sale_condition}" />
          <tbody align=center>
          <c:if test="${i == 1}">
            <tr class="product">
            <td class= "c_image">
              <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform" id="${rec.p_number}">
              <img  width="175" height="115" alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec.p_img_path }" >
         </a>
            </td>
            <td ><div class="cname"><a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}">${rec.p_name }</a></div></td>
            
              <td >판매중 </td>
                   <td><div class="cprice"><fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원</div>
              	<div class="cprice"><fmt:formatDate value="${rec.p_time }" type="both" dateStyle="medium" timeStyle="short" />
</div>
              </td>
              <td>
              <input class="check-box btn btn-warning" type="button" value="수정" name="modifyproduct">
              <div display="none" value="${rec.p_number}"></div></input>
              	<form id="deleteform" method="post">
              	 <input class="check-box btn btn-warning" type="button" value="등록취소" name="deleteproduct">
              	 <input type="hidden" name="delproductnum">
              	 </form>
              	 
              </td>
             
            </tr>
    		</c:if>	
    		
    		<c:if test="${i == 2}">
            <tr class="product">
            <td class= "c_image">
              <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform">
              <img  width="175" height="115" alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec.p_img_path }" >
         </a>
            </td>
            <td ><div class="cname"><a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}">${rec.p_name }</a></div></td>
            
              <td >거래중 </td>
                   <td><div class="cprice"><fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원</div>
              	<div class="cprice">
<fmt:formatDate value="${rec.p_time }" type="both" dateStyle="medium" timeStyle="short" />
</div>
              </td>
              <td>
              </td>
            </tr>
    		</c:if>	
    			<c:if test="${i == 3}">
            <tr class="product">
            <td class= "c_image">
              <a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}" class="cinform">
              <img  width="175" height="115" alt="이미지 오류" class="MS_prod_img_s" src="/portfolio/${rec.p_img_path }" >
         </a>
            </td>
            <td ><div class="cname"><a href="${contextpath }/portfolio/product/productInfo?p_number=${rec.p_number}">${rec.p_name }</a></div></td>
            
              <td>판매완료</td>
                   <td><div class="cprice"><fmt:formatNumber value="${rec.p_sale_price }" pattern="###,###,###" />원</div>
              	<div class="cprice">
<fmt:formatDate value="${rec.p_time }" type="both" dateStyle="medium" timeStyle="short" />
</div>
              </td>
                 <td>
        </td>
            </tr>
    		</c:if>	
          </tbody>
    	 </c:forEach>
        </table>
      </div>
   
      
   
	</div>
</div><!-- 보드리스트시작 -->
			<div id="boardList">
	<!-- 페이지  -->
			<div class="paging">
				<c:if test="${myfindCriteria.pageCriteria.prev}">
					<div>
						<a	href="${contextPath }/product/myproduct/1/${requestScope.trsstate }"><i
							class="fas fa-angle-double-left"></i></a>
					</div>
					<div>
						<a	href="${contextPath }/product/myproduct/${myfindCriteria.pageCriteria.startPage-1}/${requestScope.trsstate }"><i
							class="fas fa-angle-left"></i></a>
					</div>
				</c:if>
					<c:forEach var="pageNum"
					begin="${myfindCriteria.pageCriteria.startPage }"	end="${myfindCriteria.pageCriteria.endPage }">
					<!-- 현재페이지와 요청페이지가 같으면 -->
					<c:if test="${pageNum == myfindCriteria.pageCriteria.rc.reqPage}">
					<div class="active">
					</c:if>
					<!-- 현재페이지와 요청페이지가 다르면 -->
					<c:if test="${pageNum != myfindCriteria.pageCriteria.rc.reqPage}">
					<div>
					</c:if>
					<a href="${contextPath }/product/myproduct/${pageNum }/${requestScope.trsstate }">${pageNum }</a>
					</div>
					
			
				</c:forEach>
	

			<c:if test="${myfindCriteria.pageCriteria.next}">
				<div>
					<a	href="${contextPath }/product/myproduct/${myfindCriteria.pageCriteria.endPage+1}/${requestScope.trsstate }">
					<i class="fas fa-angle-right"></i></a>
				</div>
				<div>
					<a	href="${contextPath }/product/myproduct/${myfindCriteria.pageCriteria.finalEndPage}/${requestScope.trsstate }">
					<i	class="fas fa-angle-double-right"></i></a>
				</div>
			</c:if>
		</div>
   </div>	<!-- 보드리스트종료 -->
 

	</main>
	
	
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>