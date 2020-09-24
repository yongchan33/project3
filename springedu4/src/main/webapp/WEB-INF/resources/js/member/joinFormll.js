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
		let nicknameTag = document.getElementById('nickname');
		let genderTags 	= document.querySelectorAll("input[name='gender']");
		let regionTag 	= document.getElementById('region');
		let birthTag    = document.getElementById('birth');
		
		//정규표현식 
		let idExpReg = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-A]{2,3}$/i;
		//전화번호
		let telExpReg = /^01(?:0|1|[6-9])-(?:\d{3}|d{4}-\d{4}$)/;
		
		
		//아이디 체크
		if(idTag.value.trim().length == 0){
			//alert('아이디를 입력하세요');
			document.getElementById('err_id').textContent = '아이디를 입력하세요';
			idTag.select();
			return;
		}
		document.getElementById('err_id').textContent = '';
		
		if(idTag.value.trim().length > 40){
			alert('아이디는 40자 이하로 작성바랍니다.');
			idTag.select();
			return;
		}	
		if(!idExpReg.test(idTag.value)){
			alert('이메일 형식에 맞지 않습니다 ex)aaa@bbb.com');
			idTag.select();
			return;
		}
		
		//비밀번호체크
		if(pwTag.value.trim().length == 0){
			alert('비밀번호를 입력하세요');
			pwTag.select();
			return
		}
		if(pwTag.value.trim().length > 10){
			alert('비밀번호는 10자 이하로 작성바랍니다');
			pwTag.select();
			return
		}		
		if(pwchkTag.value.trim().length == 0){
			alert('비밀번호를 입력하세요');
			pwchkTag.select();
			return
		}
		if(pwTag.value.trim() != pwchkTag.value.trim()) {
			alert('비밀번호가 일치하지 않습니다');
			pwchkTag.select();
			return			
		}
	
		//전화번호체크
		if(telTag.value.trim().length == 0){
			alert('전화번호를 입력하세요');
			telTag.select();
			return;
		}		
		if(!telExpReg.test(telTag.value)){
			alert('전화번호 형식에 맞지 않습니다. ex)010-123-456')
			telTag.select();
			return;			
		}
		
		//별칭체크
		if(nicknameTag.value.trim().length == 0){
			alert('별칭을 입력하세요');
			nicknameTag.select();
			return;		
		}
		//성별체크
		let genderArray = Array.from(genderTags);		
		if((genderArray[0].checked || genderArray[1].checked) != true) {
			alert('성별을 체크하세요');
			genderTags[0].select();
			return;
		}
		//지역
		if(region.selectedIndex == 0) {
			alert('지역을 선택하세요');
			region.select();
			return;
		}
		//생년월일
		if(!birth.value){
			alert('생년월일을 입력하세요');
			birth.select();
			return;
		}
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
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

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
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }


	