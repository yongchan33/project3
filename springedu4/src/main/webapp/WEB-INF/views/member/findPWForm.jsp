<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!-- 공통모듈-->
<!-- 절대경로-->
<%@ include file="/WEB-INF/views/include/common.jsp"%>
<!-- 상대경로-->
<%--@ include file="../include/common.jsp" --%>
<title>비밀번호찾기 페이지</title>

<link rel="stylesheet" href="${contextPath }/css/main.css">
<link rel="stylesheet" href="${contextPath }/css/member/joinForm.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
let certificationcheck=false
let emailDomain='self'
var fullemail = ''
      window.addEventListener("load", init);
      function init() {
        const findPWBtn = document.getElementById("findPWBtn");
    const certificationBtn = document.getElementById("certificationBtn");
    const emailcheckBtn = document.getElementById("emailcheckBtn");
	const cancelBtn = document.getElementById("cancelBtn");
    

    let emailDomain = document.getElementById("emailDomain");
    emailDomain.addEventListener("change",emailDomain_F);

    
    findPWBtn.addEventListener("click", findPW_f);
        certificationBtn.addEventListener("click", certification_F);
        emailcheckBtn.addEventListener("click", emailcheck_F);
        cancelBtn.addEventListener("click", cancelBtn_f);
      }

      function cancelBtn_f(event){
    	
    		const url = `/portfolio/loginForm`;
    		window.location.href = url; 
    	}
    //이메일도메인선택시
      function emailDomain_F(event){
    emailDomain = document.getElementById("emailDomain").options[document.getElementById("emailDomain").selectedIndex].value;
    
    }
      //인증번호받기
//이메일인증클릭시
function emailcheck_F(event){
event.preventDefault(); //<button>의기본이벤트차단

const emailTag = document.getElementById("email");

if(emailTag.value.trim().length == 0){
document.getElementById('err_certification').textContent = '이메일을입력해주세요'
emailTag.select();
return
}
document.getElementById('err_certification').textContent = ''

if(emailDomain=='self'){
fullemail=emailTag.value;
document.getElementById('err_certification').textContent = '이메일인증코드가전송되었습니다'
}else{
fullemail=emailTag.value+'@'+emailDomain;

}
//AJAX 사용
    //1)XMLHTTPRequest 객체생성
    const xhttp = new XMLHttpRequest();

    //2)서버응답처리
    //readyState
    // 0 : open()가호출되지않은상태
    // 1 : open()가실행된상태server 연결됨
    // 2 : send()가실행된상태,  서버가클라이언트요청을받았음.
    // 3 : 서버가클라이언트요청처리중. 응답헤더는수신했으나바디가수신중인상태
    // 4 : 서버가클라이언트의요청을완료했고서버도응답이완료된상태
    xhttp.addEventListener("readystatechange", ajaxCall);
    
    function ajaxCall(event) {
      if (this.readyState == 4 && this.status == 200) {
        console.log(this.responseText);

        //json포맷문자열=> 자바스크립트ojb
        const jsonObj = JSON.parse(this.responseText);
        
        switch(jsonObj.rtcode){
        case "00" ://성공
        check = jsonObj.result; 
        break
        case "01" ://실패
        check=0;  
        err_certification.textContent = jsonObj.result    
        break
        } 
      }
    }

    //3)요청파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
    //js객체를json포맷문자열로변환JSON.stringify()
    //json포맷문자열을js객체로변환JSON.parse()
     
    //4)서비스요청
    xhttp.open(
      "POST",
      "http://localhost:9080/${contextPath}/member/findcheckmail"
    );
    xhttp.setRequestHeader(
            "Content-Type",
            "application/json;charset=utf-8"
  ); 
    xhttp.send(fullemail);
}


function certification_F(event){
let certification = document.getElementById("certification");

event.preventDefault(); //<button>의기본이벤트차단
if(certification.value.trim().length == 0){
document.getElementById('err_certification').textContent = '인증코드를입력하세요'
certification.select();
return
}
document.getElementById('err_certification').textContent = ''

 if(check==certification.value){
console.log('인증번호일치');
certificationcheck=true
document.getElementById('err_certification').textContent = '"이메일인증이완료되었습니다"'
}
else{
console.log('인증번호불일치');
certificationcheck=false
document.getElementById('err_certification').textContent = '"이메일인증번호를확인해주세요"'
}

//받아온check값과인증번호값을비교하면됨.
}
    
      //유효성체크
      function chkValidation(){
    //전화번호체크
    
    if(!document.getElementById('id').value) {
    document.getElementById('errmsg').textContent = '아이디을입력바랍니다!'
    document.getElementById('id').select();
    return false
    }
    document.getElementById('errmsg').textContent = ''
    console.log(document.getElementById('email').value);
    //이메일
    if(!document.getElementById('email').value) {
    document.getElementById('err_certification').textContent = '이메일을입력바랍니다!'
    document.getElementById('email').select();
    return false    
    }
    document.getElementById('err_certification').textContent = ''
    return true
      }
           
      //아이디찾기버튼클릭시
      function findPW_f(event) {
        event.preventDefault(); //<button>의기본이벤트차단

        if(!chkValidation()) return

  if(certificationcheck==false){
document.getElementById('err_certification').textContent = '"이메일인증번호를확인해주세요"'
document.getElementById('err_certification').select();
return
    }

        const idTag = document.getElementById("id");
        const emailTag = document.getElementById("email");
        
        const findedPWTag = document.getElementById("findedPW");
        const errmsgTag = document.getElementById("errmsg");
        
        //AJAX 사용
        //1)XMLHTTPRequest 객체생성
        const xhttp = new XMLHttpRequest();

        //2)서버응답처리
        //readyState
        // 0 : open()가호출되지않은상태
        // 1 : open()가실행된상태server 연결됨
        // 2 : send()가실행된상태,  서버가클라이언트요청을받았음.
        // 3 : 서버가클라이언트요청처리중. 응답헤더는수신했으나바디가수신중인상태
        // 4 : 서버가클라이언트의요청을완료했고서버도응답이완료된상태
        xhttp.addEventListener("readystatechange", ajaxCall);
        function ajaxCall(event) {
          if (this.readyState == 4 && this.status == 200) {
            console.log(this.responseText);

            //json포맷문자열=> 자바스크립트ojb
            const jsonObj = JSON.parse(this.responseText);
            
            switch(jsonObj.rtcode){
            case "00" :
            findedPWTag.textContent = jsonObj.result ;
            errmsgTag.textContent = ''
            break
            case "01" :
            errmsgTag.textContent = jsonObj.result;            
            break
            }          
          }
        }

        //3)요청파라미터만들기(json포맷) { "tel": "010-1234-5678", "birth":"2020-07-01" }
        const reqParam = {};
        reqParam.id = idTag.value; 
        reqParam.email = fullemail; 
        //js객체를json포맷문자열로변환JSON.stringify()
        //json포맷문자열을js객체로변환JSON.parse()
        const result = JSON.stringify(reqParam);

        //4)서비스요청
        xhttp.open(
          "POST",
          "http://localhost:9080${contextPath}/member/pwmail"
        );
        //post form 요청시필요
/*         xhttp.setRequestHeader(
          "Content-Type",
          "application/x-www-form-urlencoded"
        ); */
        
        //post json 요청시필요
        xhttp.setRequestHeader(
                  "Content-Type",
                  "application/json;charset=utf-8"
        );    
        //querystring 전송필요시
        //xhttp.send("result=" + result);
        //queryString 불필요시
        xhttp.send(result);
      }
    </script>
</head>





<body>
<!-- 최상위메뉴-->
<%@ include file="/WEB-INF/views/include/uppermost.jsp" %>
 
  <!-- header -->
  <%@ include file="/WEB-INF/views/include/header.jsp" %> 

  <!-- 메뉴-->
  <%@ include file="/WEB-INF/views/include/menu.jsp" %>

  
  <!-- 본문-->
<main>
<div class="container">
<div class="content">
<section>
<form id="joinForm" method="post" action="${contextPath }/findID">
<h1>비밀번호찾기</h1>
<hr>
<table class="table">

  <tbody>
    <tr>
      <th scope="row"><label for="id" class="menu_name">아이디</label></th>
      <td><input type="text" name="id" id="id" placeholder="아이디를입력하세요"/>
			<span class="errmsg" id="errmsg"></span></td>
     
    </tr>
    <tr>
      <th scope="row" class="member_email"><label for="email" class="menu_name">이메일</label><span id="emailcheck"></span></th>
      <td>   <div class="member_warning">
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
                        <button id="emailcheckBtn" class="btn btn-dark">인증번호발송</button><br>
                        <input type="text" name="certification" id="certification" value="" tabindex="-1">
                              <button id="certificationBtn" class="btn btn-dark">인증번호확인</button>
                    </div>
                    <div>

</div></td>
   
    </tr>

  </tbody>
</table>

<div>
<span class="errmsg" id="errmsg"></span>
</div>
<div class="member_warning js_email"></div>
                    <div class="form_element"> 
                        </div>
                       
                         <span class="err err_certification" id="err_certification"></span>
                         <span id="memberfindID"></span>
                         <span id="findedPW"></span>
                   <div class="btnli"><input class="btn btn-outline-dark insertBtn" id='findPWBtn' type="submit" value="비밀번호찾기" /> 
                   <input class="btn btn-outline-dark insertBtn" id='cancelBtn' type="button" value="취소" /></div>

         

</form>
</section>

</div>
</div>
</main>

 <!-- 푸터-->
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>    

</body>
</html>  