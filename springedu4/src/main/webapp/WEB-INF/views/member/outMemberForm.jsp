<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<title>회원탈퇴</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/member/joinForm.css">
<style>
.menu_name{
width:200px;}
</style>
<!-- <script>
window.addEventListener("load", init);
function init() {
const outBtn = document.getElementById("outBtn");
outBtn.addEventListener("click", outBtn_f);
}

function outBtn_f(event){
	
	alert('회원탈퇴가 완료되었습니다.');
	
}

</script> -->
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>

 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴 -->
  <%@ include file="/WEB-INF/views/member/outmenu.jsp" %>
	  
	<main>
		<div class="container">
			<div class="content">
				<section>
					<form method="post" action="${contextPath}/member/outMember">
						<h1>회원탈퇴</h1>
					<hr>
					<table class="table">

  <tbody>
    <tr>
      <th scope="row"><label for="id" class="menu_name">아이디</label></th>
      <td><input type="text" name="id" readonly="readonly" value="${sessionScope.member.id}"></td>
  
    </tr>
    <tr>
      <th scope="row"><label for="pw" class="menu_name">비밀번호</label></th>
      <td><input type="password" name="pw" placeholder="비밀번호를 입력하세요">
						<span class="errmsg">${requestScope.svr_msg }</span>
						</td>
    </tr>

  </tbody>
</table>
					 
								<!-- Button trigger modal -->
<div class="btnli"><button type="button" class="btn btn-outline-dark insertBtn" data-toggle="modal" data-target="#exampleModal">
회원탈퇴
</button></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원탈퇴</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>정말로 탈퇴하시겠습니까?</p>
      </div>
      <div class="modal-footer">
            	<input class="btn btn-outline-dark insertBtn" id="outBtn" type="submit" value="탈퇴" />
              <input type="button" class="btn btn-outline-dark insertBtn" data-dismiss="modal" value="취소">
      </div>
    </div>
  </div>
</div>	
					</form>	
				</section>
			</div>
		</div>
	</main>

  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>  