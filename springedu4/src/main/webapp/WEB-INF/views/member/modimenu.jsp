<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <c:set var="url_myInfo" value="${contextPath }/member/myInfo"/>      
<c:set var="url_modifyForm" value="${contextPath }/member/modifyForm"/>
<c:set var="url_changePWForm" value="${contextPath }/member/changePWForm" /> 
<c:set var="url_outMember" value="${contextPath }/member/outMemberForm"/>   
<c:set var="url_myproduct" value="${contextPath }/product/myproduct"/>      
				<div id="header">

				
	<nav id="nav">

      <ul>
      <li ><a href="${url_myInfo }">내정보관리</a></li>
       <li ><a href="${url_myproduct }">내상품관리</a></li>
        <li class="current"><a href="${url_modifyForm }">회원정보수정</a></li>
        <li><a href="${url_changePWForm}">비밀번호변경</a></li>
        <li ><a href="${url_outMember }">회원탈퇴</a></li>
       
      </ul>

  </nav>
  				</div>