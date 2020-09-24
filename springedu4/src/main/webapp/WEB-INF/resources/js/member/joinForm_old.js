
	window.addEventListener("load",init);
	function init() {
		let joinBtn = document.getElementById('joinBtn');
		
		joinBtn.addEventListener("click", joinF);
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
		
		
		//서버에 전송
		joinForm.method = 'post';
		joinForm.submit();
		

	}
//2개만 체크되게 하기

function count_ck(obj){

	let chkbox = document.getElementsByName("check_cate");

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




	