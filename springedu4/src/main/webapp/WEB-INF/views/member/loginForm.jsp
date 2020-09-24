<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp" %>

<title>로그인</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<style>
* {
	/*  outline: 1px solid red; */
	box-sizing: border-box;
}

  #loginForm { margin-bottom: 40px;} 

.container .content {
	display: flex;
	justify-content: center;
	margin-top: 40px;
}

.container .content form {
	display: flex;
	flex-direction: column;
	width: 320px;
	border: 1px solid lightgray;
}

.container .content form .item:nth-child(1) {
	margin-top: 20px;
	margin-bottom: 10px;
	padding: 5px;
}

 .container .content form .item:nth-child(1) img {
	width: 100%;
	height: 100%;
} 

 .container .content form .item {
	margin: 10px 0px;
	padding: 5px;
} 
 .container .content form .item .loginbanner {
	font-size : 28px;
	text-align : center;
	font-weight : bold;
} 
.container .content form #id, .container .content form #pw {
	width: 100%;
	height: 100%;
	padding: 15px;
	text-align:left;
}

.far.fa-envelope, .fas.fa-key {
	font-size: 1.5em;
}

.container .content form #loginBtn {
	width: 100%;
 	padding: 10px;
	border: none;
	outline: none;
	background-color:#272833;
	color: white;
	text-align: center;
	
}

.container .content form #loginBtn:hover {
	background-color: black;
	transition: all 0.7s;
}

.container .content form .find_info {
	text-align: center;
	font-size: 0.7em;
	padding: 10px;
	border-top: 1px solid rgba(0, 0, 0, 0.05);
}

.container .content form #login_chk {
	font-size: 0.9em;
	margin-left: 3px;
}

.container .content form #login_save {
	font-size: 0.9em;
	margin-right: 3px;
}

#login_sc { text-align: center;}
.container .content form .errmsg {
	color: red;
	font-weight: bold;
	font-size: 0.7em;
	padding-left:10px;
}

</style>
<script>
	window.addEventListener("load",init);
	function init() {
		let loginBtn = document.querySelector('#loginBtn');

		
		loginBtn.addEventListener("click",loginF);

	}
	function loginF(e){
		e.preventDefault();//<button>요서의 서버전송 기본 이벤트 중단
		let loginForm = document.querySelector('#loginForm');
		let idTag 		= document.querySelector('#id');
		let pwTag 		= document.querySelector('#pw');
		let errmsg_id = document.querySelector('#errmsg_id');
		let errmsg_pw = document.querySelector('#errmsg_pw');
		
		//아이디체크
		if(!idTag.value.trim()){
			errmsg_id.textContent='아이디를 입력해주세요.';
			idTag.select();
			return false;
		}

		errmsg_pw.textContent='';
		
		//비밀번호체크
		if(!pwTag.value.trim()){
			errmsg_pw.textContent='비밀번호를 입력해주세요.';
			pwTag.select();
			return false;			
		}
		errmsg_pw.textContent='';
	
		//서버전송
		loginForm.submit();
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
  <main>
	<div class="container">
		<div class="content">
			<form id="loginForm" method="post" action="${contextPath }/login?reqURI=${reqURI}">
				<div class="item">
				<div class="loginbanner">로그인</div>
				</div>
				<div class="item">
					<input type="text" name="id" id="id" placeholder="아이디" />
				</div>
				<span class="errmsg" id="errmsg_id"></span>
				<div class="item">
					<input type="password" name="pw" id="pw" placeholder="비밀번호" />
				</div>
							<span class="errmsg" id="errmsg_pw"></span>
				<div class="item" id="login_sc">
					<input type="checkbox" name="login_chk" id="login_chk" /> <label
					
						for="login_chk" id="login_chk">로그인상태유지</label>
				</div>

				<div class="item">
		<span class="errmsg" id="errmsg">${requestScope.svr_msg }</span>
					
				</div>
				
				<div class="item">
					<button id="loginBtn">로그인</button>
				</div>
			
				
				<div class="item find_info">
					<a href="${contextPath }/member/findIDForm">아이디 찾기</a> <span>|</span> 
					<a href="${contextPath }/member/findPWForm">비밀번호 찾기</a> <span>|</span>
					<a href="${contextPath }/member/joinForm">회원 가입</a>
				</div>
			</form>
		</div>
	</div>
	</main>
	  <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>  
</body>
</html>