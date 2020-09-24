<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 공통 모듈 -->
<%@ include file="/WEB-INF/views/include/common.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title>회원정보수정</title>
<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/member/joinForm.css">


<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<style>
#id, #name, #birth, #email, #men , #women {
	color: LightGray;
}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let check = '';
	let certificationcheck = true;
	let emailDomain = 'self';
	let doublecheckid = false;
	window.addEventListener("load", init);
	function init() {
		let modifyBtn = document.getElementById('modifyBtn');
		
		const certificationBtn = document.getElementById("certificationBtn");
		const doublecheckBtn = document.getElementById("doublecheck");

		modifyBtn.addEventListener("click", modifyF);

	}


	function modifyF(e) {
		e.preventDefault(); //기본이벤트 막기
		console.log(e.target);
		let modifyForm = document.getElementById('modifyForm');

		let idTag = document.getElementById('id');
		let pwTag = document.getElementById('pw');
		let pwchkTag = document.getElementById('pwchk');
		let emailTag = document.getElementById('email');
		let telTag = document.getElementById('tel');
		let nameTag = document.getElementById('name');
		let genderTags = document.querySelectorAll("input[name='gender']");
		let detailAddressTag = document.getElementById('detailAddress');
		let addressTag = document.getElementById('postcode');
		let birthTag = document.getElementById('birth');
		let heightTag = document.getElementById('height');
		let weightTag = document.getElementById('weight');
		let certification = document.getElementById('certification');

		//정규표현식 
		let idExpReg = /^[a-zA-z][a-zA-z0-9]{5,15}$/;

		//전화번호
		let telExpReg = /^01(?:0|1|[6-9])-(?:\d{3}|d{4}-\d{4}$)/;

		//비밀번호
		let pwExpReg = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;

		//한글
		let nameExpReg = /^[가-힣]{2,5}/;

		document.getElementById('err_name').textContent = '';
		//전화번호체크
		if (telTag.value.trim().length == 0) {
			document.getElementById('err_tel').textContent = '전화번호를 입력하세요.';
			telTag.select();
			return;
		}
		document.getElementById('err_tel').textContent = '';
		if (!telExpReg.test(telTag.value)) {
			document.getElementById('err_tel').textContent = '전화번호 형식에 맞지 않습니다. ex)010-1234-5678';
			telTag.select();
			return;
		}
		document.getElementById('err_tel').textContent = '';

		//지역

		if (addressTag.value.trim().length == 0) {
			document.getElementById('err_address').textContent = '주소를 입력하세요.';
			nameTag.select();
			return;
		}
		document.getElementById('err_address').textContent = '';

		if (detailAddress.value.trim().length == 0) {
			document.getElementById('err_address').textContent = '상세주소를 입력하세요.';
			nameTag.select();
			return;
		}
		document.getElementById('err_address').textContent = '';

		//성별체크
		let genderArray = Array.from(genderTags);
		if ((genderArray[0].checked || genderArray[1].checked) != true) {
			document.getElementById('err_gender').textContent = '성별을 선택하세요.';
			genderTags[0].select();
			return;
		}
		document.getElementById('err_gender').textContent = '';

		//키 몸무게 체크
		if (height.selectedIndex == 0) {
			document.getElementById('err_body').textContent = '키를 선택하세요.';
			region.select();
			return;
		}
		document.getElementById('err_body').textContent = '';

		if (weight.selectedIndex == 0) {
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
		modifyForm.method = 'post';
		if (certificationcheck == false) {
			//이메일
			if (email.value.trim().length == 0) {
				document.getElementById('err_certification').textContent = '이메일을 입력하세요';
				email.select();
				return;
			}
			document.getElementById('err_certification').textContent = '';

			if (certification.value.trim().length == 0) {
				document.getElementById('err_certification').textContent = '인증코드를 입력하세요';
				certification.select();
				return;
			}
			document.getElementById('err_certification').textContent = '';
			document.getElementById('err_certification').textContent = '이메일 인증 확인해주세요';
			email.select();
			return;
		}
		if (certificationcheck == true) {
			modifyForm.submit();
			alert("회원님의 정보가 수정완료 되었습니다.");
		}

	}
	//3개만 체크되게 하기

	function count_ck(obj) {

		let chkbox = document.getElementsByClassName("check_cate");

		let chkCnt = 0;

		for (let i = 0; i < chkbox.length; i++) {

			if (chkbox[i].checked) {

				chkCnt++;

			}

		}

		if (chkCnt > 3) {

			alert("3개 이상 선택할 수 없습니다.");

			obj.checked = false;

			return false;

		}

	}
	//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	function execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						let roadAddr = data.roadAddress; // 도로명 주소 변수
						let extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('postcode').value = data.zonecode;
						document.getElementById("roadAddress").value = roadAddr;
						document.getElementById("jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("extraAddress").value = '';
						}

						let guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							let expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							let expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
	//아이디 찾기 버튼 클릭시
	function doublecheck_f(event) {

		event.preventDefault(); //<button>의 기본 이벤트 차단
		console.log("doublecheck call!!");
		const idTag = document.getElementById("id");
		const err_id = document.getElementById("err_id");

		var checkid = idTag.value;
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

				switch (jsonObj.rtcode) {
				case "00":
					err_id.textContent = jsonObj.result;
					doublecheckid = true;
					break;
				case "01":
					err_id.textContent = jsonObj.result;
					doublecheckid = false;
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
		xhttp
				.open("POST",
						"http://localhost:9080${contextPath}/member/checkid");

		//post form 요청시 필요
		/* xhttp.setRequestHeader(
		  "Content-Type",
		  "application/x-www-form-urlencoded"
		); */

		//post json 요청시 필요
		xhttp
				.setRequestHeader("Content-Type",
						"application/json;charset=utf-8");

		//querystring 전송 필요시(get방식)
		// xhttp.send("result=" + result);

		//qeuryString 불필요시
		xhttp.send(checkid); //요청시 보내야할 파라미터
	}
</script>
</head>
<body>
	<!-- 최상위메뉴 -->
	<%@ include file="/WEB-INF/views/include/uppermost.jsp"%>

 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

	<!-- 메뉴 -->
	<%@ include file="/WEB-INF/views/member/modimenu.jsp"%>

	<main>
		<div class="container">
			<div class="content">
				<section>
					<form id="modifyForm" method="post"
						action="${contextPath}/member/modify">
						<h1>회원정보수정</h1>
						<hr>
						<h2>기본정보</h2>
				
				<table class="table table-bordered">

  <tbody>
    <tr>
      <th scope="row"><label for="id" class="menu_name">아이디</label></th>
      <td><input type="text" name="id" id="id" value='${sessionScope.member.id }' readonly="readonly" /></td>

    </tr>
   
      <tr>
 		<th scope="row"><label for="name" class="menu_name">이름</label></th>
      <td><input type="text" name="name" id="name" value='${sessionScope.member.name }' readonly="readonly" />
      <span class="err err_name" id="err_name"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="tel" class="menu_name">전화번호</label></th>
      <td><input type="tel" name="tel" id="tel" value='${sessionScope.member.tel }' />
		  <span class="err err_tel" id="err_tel"></span></td>
    </tr>
      <tr>
 		<th scope="row"><label for="birth" class="menu_name">생년월일</label></th>
      <td><input type="date" name="birth" id="birth" value='${sessionScope.member.birth }' readonly="readonly" />
		  <span class="err err_birth" id="err_birth"></span></td>
    </tr>
    
    <c:set var="fulladdress" value='${sessionScope.member.address }' />
							<c:set var="address" value="${fn:split(fulladdress,',')}" />
      <tr>
 		<th scope="row"><label for="address" class="menu_name">지역</label></th>
      <td class="address"> 
                           <input type="text" id="postcode"
								class="address" name="address" placeholder="우편번호"
								value='${address[0]}'> <input type="button"
								onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark"> <br>
								<input type="text" id="roadAddress" class="address"
								name="address" placeholder="도로명주소" value='${address[1]}'>
								<input type="text" id="jibunAddress" class="address"
								name="address" placeholder="지번주소" value='${address[2]}'>
								<span id="guide" style="color: #999; display: none"></span><br>
								<input type="text" id="detailAddress" class="address"
								name="address" placeholder="상세주소를 입력해 주세요."
								value='${address[3]}'> <input type="text"
								id="extraAddress" class="address" name="address"
								placeholder="참고항목" value='${address[4]}'>
							<span class="err err_address" id="err_address"></span>
    </tr>
     <tr>
 		<th scope="row"><label for="email" class="menu_name">이메일</label><span id="emailcheck"></span></th>
      <td class="member_email">
                   <div class="member_warning">
									<input type="text" name="email" id="email" tabindex="-1"
										value='${sessionScope.member.email }' readonly="readonly" />
					
                        
                      
					
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
      <td><input type="radio" name="gender" value="남" id="men"
								${sessionScope.member.gender == "남" ? 'checked="checked"' : '' } onclick="return false;" />
								<label for="men" id="men">남자</label> <input type="radio" name="gender"
								value="여" id="women"
								${sessionScope.member.gender == "여" ? 'checked="checked"' : '' } onclick="return false;"  />
								<label for="women" id="women">여자</label></li>
							<span class="err err_gender" id="err_gender"></span></td>
     
    </tr>
    <tr>
      <th scope="row" class="menu_name"><div>신체사이즈</div></th>
      <td><label for="height">키</label> <select class="height"
								id="height" name="height">
									<option value="0">키선택
									<option value="140"
										${sessionScope.member.height == "140" ? 'selected="selected"' : '' }>140cm이하
									
									<option value="141"
										${sessionScope.member.height == "141" ? 'selected="selected"' : '' }>141cm
									
									<option value="142"
										${sessionScope.member.height == "142" ? 'selected="selected"' : '' }>142cm
									
									<option value="143"
										${sessionScope.member.height == "143" ? 'selected="selected"' : '' }>143cm
									
									<option value="144"
										${sessionScope.member.height == "144" ? 'selected="selected"' : '' }>144cm
									
									<option value="145"
										${sessionScope.member.height == "145" ? 'selected="selected"' : '' }>145cm
									
									<option value="146"
										${sessionScope.member.height == "146" ? 'selected="selected"' : '' }>146cm
									
									<option value="147"
										${sessionScope.member.height == "147" ? 'selected="selected"' : '' }>147cm
									
									<option value="148"
										${sessionScope.member.height == "148" ? 'selected="selected"' : '' }>148cm
									
									<option value="149"
										${sessionScope.member.height == "149" ? 'selected="selected"' : '' }>149cm
									
									<option value="150"
										${sessionScope.member.height == "150" ? 'selected="selected"' : '' }>150cm
									
									<option value="151"
										${sessionScope.member.height == "151" ? 'selected="selected"' : '' }>151cm
									
									<option value="152"
										${sessionScope.member.height == "152" ? 'selected="selected"' : '' }>152cm
									
									<option value="153"
										${sessionScope.member.height == "153" ? 'selected="selected"' : '' }>153cm
									
									<option value="154"
										${sessionScope.member.height == "154" ? 'selected="selected"' : '' }>154cm
									
									<option value="155"
										${sessionScope.member.height == "155" ? 'selected="selected"' : '' }>155cm
									
									<option value="156"
										${sessionScope.member.height == "156" ? 'selected="selected"' : '' }>156cm
									
									<option value="157"
										${sessionScope.member.height == "157" ? 'selected="selected"' : '' }>157cm
									
									<option value="158"
										${sessionScope.member.height == "158" ? 'selected="selected"' : '' }>158cm
									
									<option value="159"
										${sessionScope.member.height == "159" ? 'selected="selected"' : '' }>159cm
									
									<option value="160"
										${sessionScope.member.height == "160" ? 'selected="selected"' : '' }>160cm
									
									<option value="161"
										${sessionScope.member.height == "161" ? 'selected="selected"' : '' }>161cm
									
									<option value="162"
										${sessionScope.member.height == "162" ? 'selected="selected"' : '' }>162cm
									
									<option value="163"
										${sessionScope.member.height == "163" ? 'selected="selected"' : '' }>163cm
									
									<option value="164"
										${sessionScope.member.height == "164" ? 'selected="selected"' : '' }>164cm
									
									<option value="165"
										${sessionScope.member.height == "165" ? 'selected="selected"' : '' }>165cm
									
									<option value="166"
										${sessionScope.member.height == "166" ? 'selected="selected"' : '' }>166cm
									
									<option value="167"
										${sessionScope.member.height == "167" ? 'selected="selected"' : '' }>167cm
									
									<option value="168"
										${sessionScope.member.height == "168" ? 'selected="selected"' : '' }>168cm
									
									<option value="169"
										${sessionScope.member.height == "169" ? 'selected="selected"' : '' }>169cm
									
									<option value="170"
										${sessionScope.member.height == "170" ? 'selected="selected"' : '' }>170cm
									
									<option value="171"
										${sessionScope.member.height == "171" ? 'selected="selected"' : '' }>171cm
									
									<option value="172"
										${sessionScope.member.height == "172" ? 'selected="selected"' : '' }>172cm
									
									<option value="173"
										${sessionScope.member.height == "173" ? 'selected="selected"' : '' }>173cm
									
									<option value="174"
										${sessionScope.member.height == "174" ? 'selected="selected"' : '' }>174cm
									
									<option value="175"
										${sessionScope.member.height == "175" ? 'selected="selected"' : '' }>175cm
									
									<option value="176"
										${sessionScope.member.height == "176" ? 'selected="selected"' : '' }>176cm
									
									<option value="177"
										${sessionScope.member.height == "177" ? 'selected="selected"' : '' }>177cm
									
									<option value="178"
										${sessionScope.member.height == "178" ? 'selected="selected"' : '' }>178cm
									
									<option value="179"
										${sessionScope.member.height == "179" ? 'selected="selected"' : '' }>179cm
									
									<option value="180"
										${sessionScope.member.height == "180" ? 'selected="selected"' : '' }>180cm
									
									<option value="181"
										${sessionScope.member.height == "181" ? 'selected="selected"' : '' }>181cm
									
									<option value="182"
										${sessionScope.member.height == "182" ? 'selected="selected"' : '' }>182cm
									
									<option value="183"
										${sessionScope.member.height == "183" ? 'selected="selected"' : '' }>183cm
									
									<option value="184"
										${sessionScope.member.height == "184" ? 'selected="selected"' : '' }>184cm
									
									<option value="185"
										${sessionScope.member.height == "185" ? 'selected="selected"' : '' }>185cm
									
									<option value="186"
										${sessionScope.member.height == "186" ? 'selected="selected"' : '' }>186cm
									
									<option value="187"
										${sessionScope.member.height == "187" ? 'selected="selected"' : '' }>187cm
									
									<option value="188"
										${sessionScope.member.height == "188" ? 'selected="selected"' : '' }>188cm
									
									<option value="189"
										${sessionScope.member.height == "189" ? 'selected="selected"' : '' }>189cm
									
									<option value="190"
										${sessionScope.member.height == "190" ? 'selected="selected"' : '' }>190cm이상


									
							</select> <label for="weight">몸무게</label> <select class="weight"
								id="weight" name="weight">
									<option value="0">몸무게선택
									<option value="40"
										${sessionScope.member.weight == "40" ? 'selected="selected"' : '' }>40kg이하
									
									<option value="41"
										${sessionScope.member.weight == "41" ? 'selected="selected"' : '' }>41kg
									
									<option value="42"
										${sessionScope.member.weight == "42" ? 'selected="selected"' : '' }>42kg
									
									<option value="43"
										${sessionScope.member.weight == "43" ? 'selected="selected"' : '' }>43kg
									
									<option value="44"
										${sessionScope.member.weight == "44" ? 'selected="selected"' : '' }>44kg
									
									<option value="45"
										${sessionScope.member.weight == "45" ? 'selected="selected"' : '' }>45kg
									
									<option value="46"
										${sessionScope.member.weight == "46" ? 'selected="selected"' : '' }>46kg
									
									<option value="47"
										${sessionScope.member.weight == "47" ? 'selected="selected"' : '' }>47kg
									
									<option value="48"
										${sessionScope.member.weight == "48" ? 'selected="selected"' : '' }>48kg
									
									<option value="49"
										${sessionScope.member.weight == "49" ? 'selected="selected"' : '' }>49kg
									
									<option value="50"
										${sessionScope.member.weight == "50" ? 'selected="selected"' : '' }>50kg
									
									<option value="51"
										${sessionScope.member.weight == "51" ? 'selected="selected"' : '' }>51kg
									
									<option value="52"
										${sessionScope.member.weight == "52" ? 'selected="selected"' : '' }>52kg
									
									<option value="53"
										${sessionScope.member.weight == "53" ? 'selected="selected"' : '' }>53kg
									
									<option value="54"
										${sessionScope.member.weight == "54" ? 'selected="selected"' : '' }>54kg
									
									<option value="55"
										${sessionScope.member.weight == "55" ? 'selected="selected"' : '' }>55kg
									
									<option value="56"
										${sessionScope.member.weight == "56" ? 'selected="selected"' : '' }>56kg
									
									<option value="57"
										${sessionScope.member.weight == "57" ? 'selected="selected"' : '' }>57kg
									
									<option value="58"
										${sessionScope.member.weight == "58" ? 'selected="selected"' : '' }>58kg
									
									<option value="59"
										${sessionScope.member.weight == "59" ? 'selected="selected"' : '' }>59kg
									
									<option value="60"
										${sessionScope.member.weight == "60" ? 'selected="selected"' : '' }>60kg
									
									<option value="61"
										${sessionScope.member.weight == "61" ? 'selected="selected"' : '' }>61kg
									
									<option value="62"
										${sessionScope.member.weight == "62" ? 'selected="selected"' : '' }>62kg
									
									<option value="63"
										${sessionScope.member.weight == "63" ? 'selected="selected"' : '' }>63kg
									
									<option value="64"
										${sessionScope.member.weight == "64" ? 'selected="selected"' : '' }>64kg
									
									<option value="65"
										${sessionScope.member.weight == "65" ? 'selected="selected"' : '' }>65kg
									
									<option value="66"
										${sessionScope.member.weight == "66" ? 'selected="selected"' : '' }>66kg
									
									<option value="67"
										${sessionScope.member.weight == "67" ? 'selected="selected"' : '' }>67kg
									
									<option value="68"
										${sessionScope.member.weight == "68" ? 'selected="selected"' : '' }>68kg
									
									<option value="69"
										${sessionScope.member.weight == "69" ? 'selected="selected"' : '' }>69kg
									
									<option value="70"
										${sessionScope.member.weight == "70" ? 'selected="selected"' : '' }>70kg
									
									<option value="71"
										${sessionScope.member.weight == "71" ? 'selected="selected"' : '' }>71kg
									
									<option value="72"
										${sessionScope.member.weight == "72" ? 'selected="selected"' : '' }>72kg
									
									<option value="73"
										${sessionScope.member.weight == "73" ? 'selected="selected"' : '' }>73kg
									
									<option value="74"
										${sessionScope.member.weight == "74" ? 'selected="selected"' : '' }>74kg
									
									<option value="75"
										${sessionScope.member.weight == "75" ? 'selected="selected"' : '' }>75kg
									
									<option value="76"
										${sessionScope.member.weight == "76" ? 'selected="selected"' : '' }>76kg
									
									<option value="77"
										${sessionScope.member.weight == "77" ? 'selected="selected"' : '' }>77kg
									
									<option value="78"
										${sessionScope.member.weight == "78" ? 'selected="selected"' : '' }>78kg
									
									<option value="79"
										${sessionScope.member.weight == "79" ? 'selected="selected"' : '' }>79kg
									
									<option value="80"
										${sessionScope.member.weight == "80" ? 'selected="selected"' : '' }>80kg
									
									<option value="81"
										${sessionScope.member.weight == "81" ? 'selected="selected"' : '' }>81kg
									
									<option value="82"
										${sessionScope.member.weight == "82" ? 'selected="selected"' : '' }>82kg
									
									<option value="83"
										${sessionScope.member.weight == "83" ? 'selected="selected"' : '' }>83kg
									
									<option value="84"
										${sessionScope.member.weight == "84" ? 'selected="selected"' : '' }>84kg
									
									<option value="85"
										${sessionScope.member.weight == "85" ? 'selected="selected"' : '' }>85kg
									
									<option value="86"
										${sessionScope.member.weight == "86" ? 'selected="selected"' : '' }>86kg
									
									<option value="87"
										${sessionScope.member.weight == "87" ? 'selected="selected"' : '' }>87kg
									
									<option value="88"
										${sessionScope.member.weight == "88" ? 'selected="selected"' : '' }>88kg
									
									<option value="89"
										${sessionScope.member.weight == "89" ? 'selected="selected"' : '' }>89kg
									
									<option value="90"
										${sessionScope.member.weight == "90" ? 'selected="selected"' : '' }>90kg
									
									<option value="91"
										${sessionScope.member.weight == "91" ? 'selected="selected"' : '' }>91kg
									
									<option value="92"
										${sessionScope.member.weight == "92" ? 'selected="selected"' : '' }>92kg
									
									<option value="93"
										${sessionScope.member.weight == "93" ? 'selected="selected"' : '' }>93kg
									
									<option value="94"
										${sessionScope.member.weight == "94" ? 'selected="selected"' : '' }>94kg
									
									<option value="95"
										${sessionScope.member.weight == "95" ? 'selected="selected"' : '' }>95kg
									
									<option value="96"
										${sessionScope.member.weight == "96" ? 'selected="selected"' : '' }>96kg
									
									<option value="97"
										${sessionScope.member.weight == "97" ? 'selected="selected"' : '' }>97kg
									
									<option value="98"
										${sessionScope.member.weight == "98" ? 'selected="selected"' : '' }>98kg
									
									<option value="99"
										${sessionScope.member.weight == "99" ? 'selected="selected"' : '' }>99kg
									
									<option value="100"
										${sessionScope.member.weight == "100" ? 'selected="selected"' : '' }>100kg
									
									<option value="101"
										${sessionScope.member.weight == "101" ? 'selected="selected"' : '' }>101kg
									
									<option value="102"
										${sessionScope.member.weight == "102" ? 'selected="selected"' : '' }>102kg
									
									<option value="103"
										${sessionScope.member.weight == "103" ? 'selected="selected"' : '' }>103kg
									
									<option value="104"
										${sessionScope.member.weight == "104" ? 'selected="selected"' : '' }>104kg
									
									<option value="105"
										${sessionScope.member.weight == "105" ? 'selected="selected"' : '' }>105kg
									
									<option value="106"
										${sessionScope.member.weight == "106" ? 'selected="selected"' : '' }>106kg
									
									<option value="107"
										${sessionScope.member.weight == "107" ? 'selected="selected"' : '' }>107kg
									
									<option value="108"
										${sessionScope.member.weight == "108" ? 'selected="selected"' : '' }>108kg
									
									<option value="109"
										${sessionScope.member.weight == "109" ? 'selected="selected"' : '' }>109kg
									
									<option value="110"
										${sessionScope.member.weight == "110" ? 'selected="selected"' : '' }>110kg이상

									
							</select>
							<span class="err err_height" id="err_body"></span>

    </tr>
   <tr>
      <th scope="row" class="menu_name"><div>관심카테고리</div></th>
      <td> 
                            <!-- 여성의류 시작 -->
                            <div class="menu_name2">여성의류</div>
                                <div id="w_clothes">
                                  
                                    <input id="cate11" name="MemberCategoryVO.c_number"
										value="11" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '11'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '11'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '11'}">checked</c:if> />
										<label for="cate11" class="check_c"> 아우터</label>>
									<input id="cate12" name="MemberCategoryVO.c_number"
										value="12" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '12'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '12'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '12'}">checked</c:if> />
										<label for="cate12" class="check_c"> 반팔/긴팔/민소매</label>
									<input id="cate13" name="MemberCategoryVO.c_number"
										value="13" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '13'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '13'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '13'}">checked</c:if> />
										<label for="cate13" class="check_c"> 원피스</label>
									<input id="cate14" name="MemberCategoryVO.c_number"
										value="14" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '14'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '14'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '14'}">checked</c:if> />
										<label for="cate14" class="check_c"> 블라우스/셔츠</label> 
									<input id="cate15" name="MemberCategoryVO.c_number"
										value="15" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '15'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '15'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '15'}">checked</c:if> />
										<label for="cate15" class="check_c"> 니트/가디건</label>
									<input id="cate16" name="MemberCategoryVO.c_number"
										value="16" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '16'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '16'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '16'}">checked</c:if> />
										<label for="cate16" class="check_c"> 후드/맨투맨</label>
									<input id="cate17" name="MemberCategoryVO.c_number"
										value="17" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '17'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '17'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '17'}">checked</c:if> />
										<label for="cate17" class="check_c"> 팬츠</label>
									<input id="cate18" name="MemberCategoryVO.c_number"
										value="18" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '18'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '18'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '18'}">checked</c:if> />
										<label for="cate18" class="check_c"> 스커트</label>
								<input id="cate19" name="MemberCategoryVO.c_number"
										value="19" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '19'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '19'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '19'}">checked</c:if> />
										<label for="cate19" class="check_c"> 수트</label>
                                </div>
                                 <!-- 여성의류 끝 -->
                                  <!-- 남성의류 시작 -->
                                 
                                  <div class="menu_name2">남성의류</div>
                                <div id="m_clothes">
                                 
                                     
                                    <input id="cate21" name="MemberCategoryVO.c_number"
										value="21" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '21'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '21'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '21'}">checked</c:if> />
										<label for="cate21" class="check_c"> 아우터</label>
									<input id="cate22" name="MemberCategoryVO.c_number"
										value="22" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '22'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '22'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '22'}">checked</c:if> />
										<label for="cate22" class="check_c"> 반팔/긴팔/민소매</label>

									<input id="cate23" name="MemberCategoryVO.c_number"
										value="23" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '23'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '23'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '23'}">checked</c:if> />
										<label for="cate23" class="check_c"> 니트/가디건</label></li>
									<input id="cate24" name="MemberCategoryVO.c_number"
										value="24" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '24'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '24'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '24'}">checked</c:if> />
										<label for="cate24" class="check_c"> 셔츠</label>
									<input id="cate25" name="MemberCategoryVO.c_number"
										value="25" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '25'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '25'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '25'}">checked</c:if> />
										<label for="cate25" class="check_c"> 후드/맨투맨</label>

									<input id="cate26" name="MemberCategoryVO.c_number"
										value="26" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '26'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '26'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '26'}">checked</c:if> />
										<label for="cate26" class="check_c"> 팬츠</label>

									<input id="cate27" name="MemberCategoryVO.c_number"
										value="27" onClick="count_ck(this);" type="checkbox"
										class="check_cate"
										<c:if test="${sessionScope.member.category1 eq '27'}">checked</c:if>
										<c:if test="${sessionScope.member.category2 eq '27'}">checked</c:if>
										<c:if test="${sessionScope.member.category3 eq '27'}">checked</c:if> />
										<label for="cate27" class="check_c"> 수트</label>
							
								<br>
								<span class="err err_check_cate" id="err_check_cate"></span>
								<span id="cate_msg">※카테고리는 최대3개 까지 선택할 수 있습니다.</span>
                                <!-- 남성의류 끝 -->
                         
                            </td>
    
    </tr>
   
  </tbody>
</table>
         
       


							<div>&nbsp;</div>
							<div class="btnli"><input class="btn btn-outline-dark insertBtn"
								id='modifyBtn' type="submit" value="회원수정" /> <input
								class="btn btn-outline-dark insertBtn" id='cancelBtn' type="submit"
								value="취소" /></div>
					</form>
				</section>

			</div>
		</div>
	</main>
	<!-- 푸터 -->
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
