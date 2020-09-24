<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- 공통모듈-->
<%@ include file="/WEB-INF/views/include/common.jsp" %>
<title>비밀번호변경</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/member/joinForm.css">
 <script>
window.addEventListener("load", init);
function init() {
const changePwbtn = document.getElementById("changePwbtn");
changePwbtn.addEventListener("click", changePwbtn_f);
}

function changePwbtn_f(e){
	
	event.preventDefault(); 
	console.log('비밀번호변경');
	//비밀번호
	 let pwExpReg = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	var cangePWForm = document.getElementById('cangePWForm');
	let pwTag 			= document.getElementById('postpw');
	//비밀번호체크
	if(pwTag.value.trim().length == 0){
			
			alert("비밀번호를 입력하세요.");
		pwTag.select();
		e.stopPropagation();
		return;
	}

	
	if(!pwExpReg.test(pwTag.value)){
	
		alert("비밀번호는 영문과 숫자를 혼합하여 6자리 이상 20글자 미만으로 설정해주세요.");
		pwTag.select();
		e.stopPropagation();
		return
	}		

	
	const url = `/portfolio/member/changePW`;
	console.log('url'+url);
	cangePWForm.method = 'post';
	cangePWForm.action = url;
	cangePWForm.submit();
	alert("비밀번호변경이 완료되었습니다.");
	e.stopPropagation();
	}


</script> 
<style>
main .container .content form .insertBtn {
    width: 150px;
    padding: 3px;
    font-size: 15px;
    height: 50px;
    margin: 10px;
}
</style>
</head>
<body>
 
<!-- 최상위메뉴-->
<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>

  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %>

  <!-- 메뉴-->
  <%@ include file="/WEB-INF/views/member/changePWmenu.jsp" %>

<main>
<div class="container">
<div class="content">
<section>
<form method="post" action="${contextPath}/member/changePW" id="cangePWForm">
<h1>비밀번호수정</h1>
<hr>
<table class="table">

  <tbody>
    <tr>
      <th scope="row"><label for="id"  class="menu_name">아이디</label></th>
      <td><input type="text" name="id" readonly="readonly" value="${sessionScope.member.id}"></td>
      
    </tr>
    <tr>
      <th scope="row"><label for="prepw"  class="menu_name">현재비밀번호</label></th>
      <td><input type="password" name="prepw" id="prepw" placeholder="현재비밀번호입력" required="required">
<span class="errmsg">${requestScope.svr_msg }</span></td>
   
    </tr>
    <tr>
      <th scope="row"><label for="postpw" class="menu_name">변경할비밀번호</label></th>
      <td><input type="password" name="postpw" id="postpw" placeholder="변경할비밀번호입력" required="required">
<span class="errmsg"></span></td>
     
    </tr>
  </tbody>
</table>
<span class="errmsg">${requestScope.changemsg }</span>
		<!-- Button trigger modal -->
<div class="btnli"><button type="button" class="btn btn-outline-dark insertBtn" data-toggle="modal" data-target="#exampleModal">
 비밀번호 변경
</button></div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">비밀번호변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>비밀번호를 변경하시겠습니까?</p>
      </div>
      <div class="modal-footer">
            <input class="btn btn-outline-dark insertBtn" id="changePwbtn" type="submit" value="변경" />
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

</script>
  <!-- 푸터-->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  

</body>
</html>  