<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="url_login" value="${contextPath }/loginForm"/>  
<c:set var="url_logout" value="${contextPath }/logout"/>  
<c:set var="url_myPage" value="${contextPath }/member/myInfo"/>   
<%-- ${sessionScope.member } --%>  
<style>
	.uppermost .container.container-upm{
		display:flex;
		justify-content:space-between;
	}
	.uppermost .container.container-upm #logo {
		font-size : 2.3em;
	}
</style>       
 <div class="uppermost">
    <fmt:bundle basename="resource.menu">
  	<!-- 로그인 전 -->
  	<c:if test="${empty sessionScope.member}">
    <div class="container container-upm">
    	<p><a href="${contextPath }"><i id="logo" class=""></i></a></p>
      <p><a href="${url_login }"><fmt:message key="menu.login"/></a><span> | </span><a href="${contextPath }/member/joinForm"><fmt:message key="menu.sign-in"/></a></p>
    </div>
    </c:if>
    <!-- 로그인 후  -->

    <c:if test="${!empty sessionScope.member}">
        <c:if test="${sessionScope.member.m_level == 0 }">
    <div class="container container-upm">
    	<p><a href="${contextPath }"><i id="logo" class=""></i></a></p>
    	
      <p> <a href="${contextPath}/transaction/request_notice">알림 ${sessionScope.alarmcount }건 </a><span> | </span>
   
           	 <a href="${url_myPage}">마이페이지</a><span> | </span>
      	 <span id="upname">${sessionScope.member.name }<fmt:message key="menu.nickname"/></span><span> | </span>
      	    <a href="${url_logout }"><fmt:message key="menu.logout"/></a>
   
      	
      </p>      
    </div>
    </c:if>
       <c:if test="${sessionScope.member.m_level == 100 }">
          <div class="container container-upm">
    	<p><a href="${contextPath }"><i id="logo" class=""></i></a></p>
    	
      <p> <a href="${contextPath}/transaction/request_notice">알림 ${sessionScope.alarmcount }건 </a><span> | </span>
   
           	 <a href="${contextPath}/member/adminPage">회원관리페이지</a><span> | </span>
      	 <span id="upname">${sessionScope.member.name }<fmt:message key="menu.nickname"/></span><span> | </span>
      	    <a href="${url_logout }"><fmt:message key="menu.logout"/></a>
      	   
      	
      </p>      
    </div>
    </c:if>
    </c:if>
    </fmt:bundle>
  </div>