<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>

<title>관리자페이지</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<style>
/* reset & normalize */
* {
  box-sizing:border-box;
}
caption {
  position:absolute;
  left:-9999px;
  font-size:0;
}
tr {
  border-bottom:1px solid #dedede;
}
tr:last-child {
  border-bottom:0;
}
th, td {
  height:42px;
  font:500 14px 'spoqa han sans';
  text-align:center;
}

td{
padding:20px;}
/* css */
.tb_wrap {
  position:relative;
  width:1000px;
  margin:20px auto;
  padding-top:43px;
}
.tb_box {
  max-height:210px;
  overflow-y:scroll;
  border-bottom:1px solid #dedede;
}
.tb {
  border-collapse:collapse;
  border-spacing:0;
  width:100%;
}
.cell1 {
  width:10%;
}
.cell2 {
  width:10%;
}
.cell3 {
  width:10%;
}
.cell4 {
  width:15%;
}
.cell5 {
  width:15%;
}

.cell6 {
  width:10%;
}
.cell7 {
  width:10%;
}
.cell8 {
  width:10%;
}
.cell9 {
  width:10%;
}
.fixed_top {
  display:inline-table;
  position:absolute;
  top:0;
  width:calc(100% - 17px);
  background:lightgray;

}
.fixed_top th {
  border-top:1px solid #dedede;
  border-bottom:1px solid #dedede;
  padding: 10px;
}
.tb tr.end {
  color:#999;
}
</style>
 <script>
window.addEventListener("load", init);
function init() {

var m_lock = document.getElementsByName("m_lock");
for (var i = 0; i < m_lock.length; i++) {
	
	m_lock[i].addEventListener('change', m_lock_f);
	}


}

//계정상태 변경
function m_lock_f(event){
    event.preventDefault(); 

    var m_lock = event.target.value;

    
    var id = event.target.parentNode.childNodes[1].value;
    console.log("m_lock="+m_lock+"id="+id);
//AJAX 사용
  //1)XMLHTTPRequest 객체 생성
  const xhttp = new XMLHttpRequest();

  //2)서버응답 처리
  //readyState
  // 0 : open()가 호출되지 않은 상태
  // 1 : open()가 실행된 상태 server 연결됨
  // 2 : send()가 실행된 상태,  서버가 클라이언트 요청을 받았음.
  // 3 : 서버가 클라이언트 요청 처리중. 응답헤더는 수신했으나 바디가 수신중인 상태
  // 4 : 서버가 클라이언트의 요청을 완료했고 서버도 응답이 완료된상태
  xhttp.addEventListener("readystatechange", ajaxCall);
  
  function ajaxCall(event) {
    if (this.readyState == 4 && this.status == 200) {
      console.log(this.responseText);

      //json포맷 문자열 => 자바스크립트 ojb
      const jsonObj = JSON.parse(this.responseText);
      switch(jsonObj.rtcode){
      case "01" :
    	  alert(jsonObj.result);
      break;
      case "00" :
    	  alert(jsonObj.result);          
      break;
      }   

    }
  }

  //3)요청 파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
  //js객체를 json포맷 문자열로 변환JSON.stringify()
  //json포맷 문자열을 js객체로 변환JSON.parse()
   	 const reqParam = {};	//빈객체생성
		 reqParam.m_lock = m_lock;
		 reqParam.id = id;

	const  result = JSON.stringify(reqParam);
   
   
   
  //4)서비스요청
  xhttp.open(
    "POST",
    "http://localhost:9080/${contextPath}/member/changestatus"
  );
  xhttp.setRequestHeader(
          "Content-Type",
          "application/json;charset=utf-8"
	); 
  xhttp.send(result);
}


</script> 
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/include/menu.jsp" %>

  <!-- 본문 -->
  <div class="tb_wrap">
  <div class="tb_box">
    <table class="tb">
      <caption>교육센터 강좌 목록</caption>
      <tr class="fixed_top">
        <th class="cell1" scope="col">회원번호</th>
        <th class="cell2" scope="col">아이디</th>
        <th class="cell4" scope="col">이메일</th>
        <th class="cell5" scope="col">전화번호</th>
        <th class="cell6" scope="col">상품 평점</th>
        <th class="cell7" scope="col">거래 평점</th>
        <th class="cell8" scope="col">판매횟수</th>
        <th class="cell9" scope="col">계정잠금</th>
      </tr>
      <c:forEach var="rec" items="${requestScope.memberlist }"  varStatus="vs">
      <c:set var="num1" value="${rec.m_grade1}" />
		<c:set var="num2" value="${rec.m_grade2}" />
      <tr>
        <th class="cell1" scope="row">${rec.m_number }</th>
        <td class="cell2">${rec.id }</td>
        <td class="cell4">${rec.email}</td>
        <td class="cell5">${rec.tel }</td>
        <td class="cell6"><fmt:formatNumber type="number"  pattern="0.0" value="${ ((num1*10) - ((num1*10)%1)) * (1/10)   } " />점</td>
        <td class="cell7"><fmt:formatNumber type="number"  pattern="0.0" value="${ ((num2*10) - ((num2*10)%1)) * (1/10)   } " />점</td>
        <td class="cell8">${rec.quantitiy }</td>
       
        <td class="cell9"> <form id="m_lockform" method="post">
       						<input type="hidden" name="id" id="id" value="${rec.id }"/>
        					<select name="m_lock" id="m_lock">
        					<c:if test="${rec.m_lock eq 'U'}">
        					<option value="U" selected="selected">U</option>
        					<option value="L">L</option>
        			</c:if> 
        				<c:if test="${rec.m_lock eq 'L'}"> 
        					<option value="U" >U</option>
        					<option value="L" selected="selected">L</option>
        					</c:if>
<%--         					<option value="">${rec.m_lock }</option>
        					<option value="U">U</option>
        					<option value="L">L</option> --%>
      						</select>
      						</form>
      	</td>
      
      </tr>
   </c:forEach>
    </table>
  </div>
</div>

  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  

</body>
</html>




