<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<!-- 절대경로 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>
<!-- 상대경로 -->
<%--@ include file="../include/common.jsp" --%>
<title>회원가입</title>

<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/member/joinForm.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
let check='';
let certificationcheck=false;
let emailDomain='self';
var fullemail = '';
let doublecheckid=false;
	window.addEventListener("load",init);
	function init() {
		let joinBtn = document.getElementById('joinBtn');
	const emailcheckBtn = document.getElementById("emailcheckBtn");
	const certificationBtn = document.getElementById("certificationBtn");
	const doublecheckBtn = document.getElementById("doublecheck");
	const cancelBtn = document.getElementById("cancelBtn");

	let emailDomain = document.getElementById("emailDomain");
	emailDomain.addEventListener("change",emailDomain_F);
	joinBtn.addEventListener("click", joinF);
	emailcheckBtn.addEventListener("click", emailcheck_F);
	certificationBtn.addEventListener("click", certification_F);
	doublecheckBtn.addEventListener("click", doublecheck_f);
	

	cancelBtn.addEventListener("click", cancelBtn_f);
	}
	
    function cancelBtn_f(event){
  	
  		const url = `/portfolio/loginForm`;
  		window.location.href = url; 
  	}
	//이메일도메인 선택시
function emailDomain_F(event){
	emailDomain = document.getElementById("emailDomain").options[document.getElementById("emailDomain").selectedIndex].value;
	
}
	function cancel_f(event){
		console.log("클릭");
		window.location.href = "http://localhost:9080/portfolio/";
		}
function certification_F(event){
	let certification = document.getElementById("certification");
	
	event.preventDefault(); //<button>의 기본 이벤트 차단
	if(certification.value.trim().length == 0){
		document.getElementById('err_certification').textContent = '인증코드를 입력하세요';
		certification.select();
		return;
	}
	document.getElementById('err_certification').textContent = '';
	
 if(check==certification.value){
		console.log('인증번호일치');
		certificationcheck=true;
		document.getElementById('err_certification').textContent = '"이메일 인증이 완료되었습니다"';
		}
	else{
		console.log('인증번호불일치');
		certificationcheck=false;
		document.getElementById('err_certification').textContent = '"이메일 인증번호를 확인해주세요"';
		}

	//받아온 check값과 인증번호 값을 비교하면됨.
}
//이메일 인증 클릭시 
function emailcheck_F(event){
event.preventDefault(); //<button>의 기본 이벤트 차단
const emailTag 		= document.getElementById("email");

if(emailTag.value.trim().length == 0){
	document.getElementById('err_certification').textContent = '이메일을 입력해주세요';
	emailTag.select();
	return;
}
document.getElementById('err_certification').textContent = '';

if(emailDomain=='self'){
	fullemail=emailTag.value;
	document.getElementById('err_certification').textContent = '이메일 인증코드가 전송되었습니다';
}else{
	fullemail=emailTag.value+'@'+emailDomain;
	document.getElementById('err_certification').textContent = '이메일 인증코드가 전송되었습니다';	
}
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
        case "00" :	//성공
        	check = jsonObj.result; 
        	break;
        case "01" :	//실패
        	check=0; 
        	document.getElementById('err_certification').textContent = jsonObj.result;   	
        	break;
        } 
      }
    }

    //3)요청 파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
    //js객체를 json포맷 문자열로 변환JSON.stringify()
    //json포맷 문자열을 js객체로 변환JSON.parse()
     
    //4)서비스요청
    xhttp.open(
      "POST",
      "http://localhost:9080/${contextPath}/member/checkmail"
    );
    xhttp.setRequestHeader(
            "Content-Type",
            "application/json;charset=utf-8"
  	); 
    xhttp.send(fullemail);
}
	function joinF(e) {
		e.preventDefault(); //기본이벤트 막기
		console.log(e.target);
		let joinForm = document.getElementById('joinForm');
		
		let idTag 			= document.getElementById('id');
		let pwTag 			= document.getElementById('pw');
		let pwchkTag 		= document.getElementById('pwchk');
		let emailTag 		= document.getElementById('email');
		let telTag 			= document.getElementById('tel');
		let nameTag 		= document.getElementById('name');
		let genderTags 		= document.querySelectorAll("input[name='gender']");
		let detailAddressTag 		= document.getElementById('detailAddress');
		let addressTag 		= document.getElementById('postcode');
		let birthTag    	= document.getElementById('birth');
		let heightTag   	=document.getElementById('height');
		let weightTag   	=document.getElementById('weight');
		let certification    = document.getElementById('certification');

		//이메일 도메인 선택시 값변경
		emailTag.value=fullemail;
		
		//정규표현식 
		let idExpReg =  /^[a-zA-z][a-zA-z0-9]{5,15}$/;
		
		//전화번호
		let telExpReg = /^01(?:0|1|[6-9])-(?:\d{3}|d{4}-\d{4}$)/;
		
		//비밀번호
		 let pwExpReg = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
		
		//한글
		let nameExpReg = /^[가-힣]{2,5}/;
		
		//아이디 체크
		if(idTag.value.trim().length == 0){
			document.getElementById('err_id').textContent = '아이디를 입력하세요';
			
			idTag.select();
			return;
		}
		document.getElementById('err_id').textContent = '';
		
		if(!idExpReg.test(idTag.value)){
				document.getElementById('err_id').textContent = '"ID는 영문자로 시작하여 숫자를 포함할 수 있으며(한글 및 특수문자 제외), 6자리 이상 16자리 이하입니다."';
			idTag.select();
			return;
		}
		document.getElementById('err_id').textContent = '';


		//비밀번호체크
		if(pwTag.value.trim().length == 0){
				document.getElementById('err_pw').textContent = '비밀번호를 입력하세요';
			pwTag.select();
			return;
		}
		document.getElementById('err_pw').textContent = '';
		
		if(!pwExpReg.test(pwTag.value)){
			document.getElementById('err_pw').textContent = '"비밀번호는 영문과 숫자를 혼합하여 6자리 이상 20글자 미만으로 설정해주세요';
			pwTag.select();
			return
		}		
		document.getElementById('err_pw').textContent = '';
		
		if(pwchkTag.value.trim().length == 0){
			document.getElementById('err_pwchk').textContent = '비밀번호를 입력하세요';
			pwchkTag.select();
			return
		}
				document.getElementById('err_pwchk').textContent = '';
		if(pwTag.value.trim() != pwchkTag.value.trim()) {
			document.getElementById('err_pwchk').textContent = '비밀번호가 일치하지않습니다.';
			pwchkTag.select();
			return			
		}
		//이름체크
		if(nameTag.value.trim().length == 0){
			document.getElementById('err_name').textContent = '이름을 입력하세요';
			nameTag.select();
			return;		
		}
	document.getElementById('err_name').textContent = '';
	
		if(!nameExpReg.test(nameTag.value)){
				document.getElementById('err_name').textContent = '"이름은 한글로 시작하여 숫자를 포함할 수 없으며(영어 및 특수문자 포함), 2자리 이상 5자리 이하입니다."';
			nameTag.select();
			return;
		}
		document.getElementById('err_name').textContent = '';
		//전화번호체크
		if(telTag.value.trim().length == 0){
			document.getElementById('err_tel').textContent = '전화번호를 입력하세요.';
			telTag.select();
			return;
		}	
		document.getElementById('err_tel').textContent = '';	
		if(!telExpReg.test(telTag.value)){
				document.getElementById('err_tel').textContent = '전화번호 형식에 맞지 않습니다. ex)010-1234-5678';
			telTag.select();
			return;			
		}
				document.getElementById('err_tel').textContent = '';
			//생년월일
		if(!birth.value){
		document.getElementById('err_birth').textContent = '생년월일을 선택하세요.';
			birth.select();
			return;
		}
		document.getElementById('err_birth').textContent = '';
		
		//지역
	
		if(addressTag.value.trim().length == 0){
			document.getElementById('err_address').textContent = '주소를 입력하세요.';
			nameTag.select();
			return;		
		}
			document.getElementById('err_address').textContent = '';
			
	if(detailAddress.value.trim().length == 0){
			document.getElementById('err_address').textContent = '상세주소를 입력하세요.';
			nameTag.select();
			return;		
		}
			document.getElementById('err_address').textContent = '';
		
		//성별체크
		let genderArray = Array.from(genderTags);		
		if((genderArray[0].checked || genderArray[1].checked) != true) {
				document.getElementById('err_gender').textContent = '성별을 선택하세요.';
			genderTags[0].select();
			return;
		}
	document.getElementById('err_gender').textContent = '';
		
		//키 몸무게 체크
		if(height.selectedIndex == 0) {
			document.getElementById('err_body').textContent = '키를 선택하세요.';
			region.select();
			return;
		}
		document.getElementById('err_body').textContent = '';
	
		if(weight.selectedIndex == 0) {
			document.getElementById('err_body').textContent = '몸무게를 선택하세요.';
			region.select();
			return;
		}
		document.getElementById('err_body').textContent = '';
		

		
	/*  if(check==certification.value){
			console.log('인증번호일치');
			certificationcheck='true';
			document.getElementById('err_certification').textContent = '"이메일 인증이 완료되었습니다"';
			return;
			}
		else{
			console.log('인증번호불일치');
			certificationcheck='false';
			document.getElementById('err_certification').textContent = '"이메일 인증번호를 확인해주세요"';
			submitcheck=true;
			return;
			} */
		
		//서버에 전송
		joinForm.method = 'post';
		if(certificationcheck==false){
			//이메일
			if(email.value.trim().length == 0){
					document.getElementById('err_certification').textContent = '이메일을 입력하세요';
					email.select();
					return;
					}
					document.getElementById('err_certification').textContent = '';
				if(certification.value.trim().length == 0){
						document.getElementById('err_certification').textContent = '인증코드를 입력하세요';
						certification.select();
						return;
					}
					document.getElementById('err_certification').textContent = '';
			document.getElementById('err_certification').textContent = '이메일 인증 확인해주세요';
			email.select();
			return;
			}
		if(doublecheckid==false){
			document.getElementById('err_id').textContent = '아이디 중복 확인해주세요';
			idTag.select();
			return;
			}
		if(certificationcheck==true && doublecheckid==true){
			joinForm.submit();
			}


	}
//3개만 체크되게 하기

function count_ck(obj){

	let chkbox = document.getElementsByClassName("check_cate");

	let chkCnt = 0;

	for(let i=0;i<chkbox.length; i++){

		if(chkbox[i].checked){

			chkCnt++;

		}

	}

	if(chkCnt>3){

		alert("3개 이상 선택할 수 없습니다.");

		obj.checked = false;

		return false;

	}

}
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                 let roadAddr = data.roadAddress; // 도로명 주소 변수
                 let extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                 let guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                     let expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                     let expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
  //아이디 중복
    function doublecheck_f(event) {
  	  
      event.preventDefault(); //<button>의 기본 이벤트 차단
      console.log("doublecheck call!!");
      const err_id		= document.getElementById("err_id");
		let idTag 			= document.getElementById('id');
		let idExpReg =  /^[a-zA-z][a-zA-z0-9]{5,15}$/;
		//아이디 체크
		if(idTag.value.trim().length == 0){
			document.getElementById('err_id').textContent = '아이디를 입력하세요';
			idTag.select();
			return;
		}
		document.getElementById('err_id').textContent = '';
		
		if(!idExpReg.test(idTag.value)){
				document.getElementById('err_id').textContent = '"ID는 영문자로 시작하여 숫자를 포함할 수 있으며(한글 및 특수문자 제외), 6자리 이상 16자리 이하입니다."';
			idTag.select();
			return;
		}
		document.getElementById('err_id').textContent = '';
		
      var checkid=idTag.value;
      console.log(checkid);
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
          case "00" :
        	  err_id.textContent = jsonObj.result;
        	  doublecheckid=true;
          	break;
          case "01" :
        	  err_id.textContent = jsonObj.result;   
        	  doublecheckid=false;         	
          	break;
          }          
        }
      }
/*       //3)요청 파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
      const reqParam = {};	//빈객체생성
      reqParam.id = idTag.value;
      //js객체를 json포맷 문자열로 변환JSON.stringify()
      //json포맷 문자열을 js객체로 변환JSON.parse()
      const result = JSON.stringify(reqParam); */
      //4)서비스요청
      xhttp.open(
        "POST",
        "http://localhost:9080${contextPath}/member/checkid"
      );


    //post form 요청시 필요
      /* xhttp.setRequestHeader(
        "Content-Type",
        "application/x-www-form-urlencoded"
      ); */
      
      //post json 요청시 필요
      xhttp.setRequestHeader(
        "Content-Type",
        "application/json;charset=utf-8"
      );

      //querystring 전송 필요시(get방식)
      // xhttp.send("result=" + result);

      //qeuryString 불필요시
      xhttp.send(checkid);	//요청시 보내야할 파라미터
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
			<section>
				<form id="joinForm" method="post" action="${contextPath}/member/join">
				<h1>회원가입</h1>
				<hr>
				<br>
				<br>
				<h2>기본정보</h2><span id="h3">&#9632;표시는 반드시 입력하셔야 하는 항목입니다.</span> 
				
				<table class="table table-bordered">

  <tbody>
    <tr>
      <th scope="row"><label for="id" class="menu_name"><span id="h4">&#9632;</span>아이디</label></th>
      <td><input type="text" name="id" id="id" value="" />
      	 <input type="button" id="doublecheck" value="중복확인" class="btn btn-dark">
      	 <span class="err err_id" id="err_id"></span></td>

    </tr>
    <tr>
      <th scope="row"><label for="pw" class="menu_name"><span id="h4">&#9632;</span>비밀번호</label></th>
      <td><input type="password" name="pw" id="pw" />
      		<span class="err err_pw" id="err_pw"></span></td>
   
    </tr>
    <tr>
 		<th scope="row"><label for="pwchk" class="menu_name"><span id="h4">&#9632;</span>비밀번호확인</label></th>
      <td><input type="password" name="pwchk" id="pwchk" />
      	<span class="err err_pwchk" id="err_pwchk"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="name" class="menu_name"><span id="h4">&#9632;</span>이름</label></th>
      <td><input type="text" name="name" id="name" />
      	<span class="err err_name" id="err_name"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="tel" class="menu_name"><span id="h4">&#9632;</span>전화번호</label></th>
      <td><input type="tel" name="tel" id="tel" />
      	<span class="err err_tel" id="err_tel"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="birth" class="menu_name"><span id="h4">&#9632;</span>생년월일</label></th>
      <td><input type="date" name="birth" id="birth" />
      	<span class="err err_birth" id="err_birth"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="address" class="menu_name"><span id="h4">&#9632;</span>지역</label></th>
      <td class="address"> 
                            <input type="text" id="postcode" class="address" name="address" placeholder="우편번호">
							<input type="button" onclick="execDaumPostcode()"  value="우편번호 찾기" class="btn btn-dark">
							<br>
							<input type="text" id="roadAddress" class="address" name="address" placeholder="도로명주소">
							<input type="text" id="jibunAddress"  class="address" name="address" placeholder="지번주소">
							<span id="guide" style="color:#999;display:none"></span><br>
							<input type="text" id="detailAddress" class="address" name="address" placeholder="상세주소를 입력해 주세요.">
							<input type="text" id="extraAddress" class="address" name="address" placeholder="참고항목">
                            
                             <span class="err err_address" id="err_address"></span></td>
    </tr>
     <tr>
 		<th scope="row"><label for="email" class="menu_name"><span id="h4">&#9632;</span>이메일</label><span id="emailcheck"></span></th>
      <td class="member_email">
                    <div class="member_warning">
                        <input type="text" name="email" id="email" value="" tabindex="-1"/>
                        <select id="emailDomain" name="emailDomain" class="chosen-select" style="height :25px">
                            <option value="self">직접입력</option>
                            <option value="naver.com">@naver.com</option>
                            <option value="hanmail.net">@hanmail.net</option>
                            <option value="daum.net">@daum.net</option>
                            <option value="nate.com">@nate.com</option>
                            <option value="hotmail.com">@hotmail.com</option>
                            <option value="gmail.com">@gmail.com</option>
                            <option value="icloud.com">@icloud.com</option>
                        </select>
                        
                        <button id="emailcheckBtn" class="btn btn-dark">인증번호 발송</button></br>
                        <input type="text" name="certification" id="certification" value="" tabindex="-1">
                              <button id="certificationBtn" class="btn btn-dark">인증번호 확인</button>
                    </div>
					<div class="member_warning js_email"></div>
                    <div class="form_element"> 
                        </div>

                        <span class="err err_certification" id="err_certification"></span></td>
    </tr>
   
  </tbody>
</table>
				

          <br>
          <br>
            <h2>부가정보</h2>
            <br>
            <table class="table table-bordered">

  <tbody>
    <tr>
      <th scope="row"><label class="menu_name">성별</label></th>
      <td><input type="radio" name="gender" value="남" id="men" /><label for="men"> 남자</label> &nbsp;&nbsp;
      		<input type="radio" name="gender" value="여" id="women" /><label for="women"> 여자</label>
              <span class="err err_gender" id="err_gender"></span></td>
     
    </tr>
    <tr>
      <th scope="row" class="menu_name"><div>신체사이즈</div></th>
      <td><label for="height">키</label>
						<select class="height" id="height" name="height">
						<option value="0">키선택
								<option value="140">140cm이하
						<option value="141">141cm
						<option value="142">142cm
						<option value="143">143cm
						<option value="144">144cm
						<option value="145">145cm
						<option value="146">146cm
						<option value="147">147cm
						<option value="148">148cm
						<option value="149">149cm
								<option value="150">150cm
						<option value="151">151cm
						<option value="152">152cm
						<option value="153">153cm
						<option value="154">154cm
						<option value="155">155cm
						<option value="156">156cm
						<option value="157">157cm
						<option value="158">158cm
						<option value="159">159cm
								<option value="160">160cm
						<option value="161">161cm
						<option value="162">162cm
						<option value="163">163cm
						<option value="164">164cm
						<option value="165">165cm
						<option value="166">166cm
						<option value="167">167cm
						<option value="168">168cm
						<option value="169">169cm
								<option value="170">170cm
						<option value="171">171cm
						<option value="172">172cm
						<option value="173">173cm
						<option value="174">174cm
						<option value="175">175cm
						<option value="176">176cm
						<option value="177">177cm
						<option value="178">178cm
						<option value="179">179cm
								<option value="180">180cm
						<option value="181">181cm
						<option value="182">182cm
						<option value="183">183cm
						<option value="184">184cm
						<option value="185">185cm
						<option value="186">186cm
						<option value="187">187cm
						<option value="188">188cm
						<option value="189">189cm
								<option value="190">190cm이상
						
					
						</select>
						&nbsp;&nbsp;
            	<label for="weight" >몸무게</label>
							<select class="weight" id="weight" name="weight">
							<option value="0">몸무게선택
								<option value="40">40kg이하
						<option value="41">41kg
						<option value="42">42kg
						<option value="43">43kg
						<option value="44">44kg
						<option value="45">45kg
						<option value="46">46kg
						<option value="47">47kg
						<option value="48">48kg
						<option value="49">49kg
								<option value="50">50kg
						<option value="51">51kg
						<option value="52">52kg
						<option value="53">53kg
						<option value="54">54kg
						<option value="55">55kg
						<option value="56">56kg
						<option value="57">57kg
						<option value="58">58kg
						<option value="59">59kg
								<option value="60">60kg
						<option value="61">61kg
						<option value="62">62kg
						<option value="63">63kg
						<option value="64">64kg
						<option value="65">65kg
						<option value="66">66kg
						<option value="67">67kg
						<option value="68">68kg
						<option value="69">69kg
								<option value="70">70kg
						<option value="71">71kg
						<option value="72">72kg
						<option value="73">73kg
						<option value="74">74kg
						<option value="75">75kg
						<option value="76">76kg
						<option value="77">77kg
						<option value="78">78kg
						<option value="79">79kg
								<option value="80">80kg
						<option value="81">81kg
						<option value="82">82kg
						<option value="83">83kg
						<option value="84">84kg
						<option value="85">85kg
						<option value="86">86kg
						<option value="87">87kg
						<option value="88">88kg
						<option value="89">89kg
								<option value="90">90kg
						<option value="91">91kg
						<option value="92">92kg
						<option value="93">93kg
						<option value="94">94kg
						<option value="95">95kg
						<option value="96">96kg
						<option value="97">97kg
						<option value="98">98kg
						<option value="99">99kg
								<option value="100">100kg
						<option value="101">101kg
						<option value="102">102kg
						<option value="103">103kg
						<option value="104">104kg
						<option value="105">105kg
						<option value="106">106kg
						<option value="107">107kg
						<option value="108">108kg
						<option value="109">109kg
								<option value="110">110kg이상
					
            </select>
            <span class="err err_height" id="err_body"></span></td>
    
    </tr>
   <tr>
      <th scope="row" class="menu_name"><div>관심카테고리</div></th>
      <td> 
                            <!-- 여성의류 시작 -->
                            <div class="menu_name2">여성의류</div>
                                <div id="w_clothes">
                                  
                                      <input id="cate11" name="MemberCategoryVO.c_number" value="11" onClick="count_ck(this);"type="checkbox" class="check_cate"/>
                                      <label for="cate11" class="check_c"> 아우터</label>
                               
                                      <input id="cate12" name="MemberCategoryVO.c_number" value="12" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate12" class="check_c"> 반팔/긴팔/민소매</label>
                                 
                                      <input id="cate13" name="MemberCategoryVO.c_number" value="13" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate13" class="check_c"> 원피스</label>
                                
                                      <input id="cate14" name="MemberCategoryVO.c_number" value="14" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate14" class="check_c"> 블라우스/셔츠</label>
                                 
                                      <input id="cate15" name="MemberCategoryVO.c_number" value="15" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate15" class="check_c"> 니트/가디건</label>
                                  <br>
                                      <input id="cate16" name="MemberCategoryVO.c_number" value="16" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate16" class="check_c"> 후드/맨투맨</label>
                                  
                                      <input id="cate17" name="MemberCategoryVO.c_number" value="17" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate17" class="check_c"> 팬츠</label>
                                 
                                      <input id="cate18" name="MemberCategoryVO.c_number" value="18" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate18" class="check_c"> 스커트</label>
                                 
                                      <input id="cate19" name="MemberCategoryVO.c_number" value="19" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate19" class="check_c"> 수트</label>
                                </div>
                                 <!-- 여성의류 끝 -->
                                  <!-- 남성의류 시작 -->
                                 
                                  <div class="menu_name2">남성의류</div>
                                <div id="m_clothes">
                                 
                                     
                                      <input id="cate21" name="MemberCategoryVO.c_number" value="20" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate21" class="check_c"> 아우터</label>
                                  
                                      <input id="cate22" name="MemberCategoryVO.c_number" value="21" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate22" class="check_c"> 반팔/긴팔/민소매</label>
                                
                                      <input id="cate23" name="MemberCategoryVO.c_number" value="22" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate23" class="check_c"> 니트/가디건</label>
                                 
                                      <input id="cate24" name="MemberCategoryVO.c_number" value="23" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate24" class="check_c"> 셔츠</label>
                                  
                                      <input id="cate25" name="MemberCategoryVO.c_number" value="24" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate25" class="check_c"> 후드/맨투맨</label>
                                 
                                      <input id="cate26" name="MemberCategoryVO.c_number" value="25" onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate26" class="check_c"> 팬츠</label>
                                 <br>
                                      <input id="cate27" name="MemberCategoryVO.c_number" value="26"  onClick="count_ck(this);" type="checkbox" class="check_cate"/>
                                      <label for="cate27" class="check_c"> 수트</label>
                                </div>
                                <br>
                                 <span class="err err_check_cate" id="err_check_cate"></span>
                                <span id="cate_msg">※카테고리는 최대3개 까지 선택할 수 있습니다.</span>
                                <!-- 남성의류 끝 -->
                         
                            </td>
    
    </tr>
   
  </tbody>
</table>
         
       
                           
                         
                      
						<div>&nbsp;</div>
						<div class="btnli"><input class="btn btn-outline-dark insertBtn" id='joinBtn' type="submit" value="회원가입" />
						 <input class="btn btn-outline-dark insertBtn" id='cancelBtn' type="button" value="취소"   /></div>
				</form>
			</section>
		
		</div>
	</div>
</main>

 <!-- 푸터 -->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>    

</body>
</html>  