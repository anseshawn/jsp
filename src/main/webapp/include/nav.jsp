<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	int level = session.getAttribute("sLevel")==null ? 999 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-expand-sm navbar-dark" style="background-color:#135589">
  <%-- <a class="navbar-brand" href="<%=request.getContextPath()%>/">HOME</a> --%>
  <a class="navbar-brand" href="http://192.168.50.58:9090/javaclass/Main">HOME</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/GuestList">Guest</a>
      </li>
			<c:if test="${level <= 4}">
	      <li class="nav-item">
	        <a class="nav-link" href="#">Board</a>
	      </li>
	      
	      <!-- 로그인 후 등급제로 구별할 장소 -->
	      
	      <li class="nav-item">
	        <a class="nav-link" href="#">PDS</a>
	      </li>    
	      <li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Study1</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t01.jsp">서버환경</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0426/t02.jsp">성적계산</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t1_Cookies.jsp">쿠키연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t2_Session.jsp">세션연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t3_Application.jsp">어플리케이션연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0427_storage/t4_StorageTest.jsp">Storage연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/homework/ex1_Login.jsp">아이디저장연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0429_JSTL/el1.jsp">EL연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0429_JSTL/jstl1.jsp?jumsu=85&code=K">jstl연습</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/filter/t1_Filter.jsp">Filter한글연습</a>
			      <%--<a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/filter/t2_Certification.jsp">인증코드발행(관리자)</a>--%>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/init/t03_init.jsp">초기값확인</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/0430_web_xml/lifeCycle/lifeCycle2.jsp">서블릿생명주기</a>
			      <a class="dropdown-item" href="<%=request.getContextPath()%>/study/database/LoginList">데이터베이스연습</a>
			      <a class="dropdown-item" href="#">Link 3</a>
			      <div class="dropdown-divider"></div>
			      <a class="dropdown-item" href="#">Another link</a>
			    </div>
	      </li>
	      <li class="nav-item dropdown mr-5">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Study2</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="${ctp}/study/password/passCheck.jsp">비밀번호암호화</a>
			      <a class="dropdown-item" href="${ctp}/mapping/test1">디렉토리매핑연습</a>
			      <a class="dropdown-item" href="${ctp}/mapping/test2.do">확장자매핑연습</a>
			      <!-- 디렉토리 매핑, 확장자 매핑 둘 다 url패턴 -->
			      <a class="dropdown-item" href="${ctp}/mapping/test3.do3">확장자매핑연습3</a>
			      <a class="dropdown-item" href="${ctp}/mapping/test4.do4">확장자매핑연습4</a>
			      <a class="dropdown-item" href="${ctp}/mapping/test5.do5">확장자매핑숙제</a>
			      <a class="dropdown-item" href="${ctp}/ajaxTest1.st">AJAX연습(일반)</a>
			      <a class="dropdown-item" href="${ctp}/ajaxTest2.st">AJAX연습(응용)</a>
			      <a class="dropdown-item" href="${ctp}/ajaxTest3.st">AJAX연습(회원관리)</a>
			      <a class="dropdown-item" href="${ctp}/uuidForm.st">UUID연습</a>
			      <a class="dropdown-item" href="${ctp}/study/database/login.jsp">로그인연습</a>
			    </div>
	      </li>
			</c:if>
     </ul>
		<ul class="navbar-nav ml-auto">
		<c:if test="${level <= 4}">    
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/MemberLogout.mem">Logout</a>
      </li>
		</c:if>
		<c:if test="${level > 4}">
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/MemberLogin.mem">Login</a>
      </li>      
		</c:if>
		<c:if test="${level > 4}">
      <li class="nav-item">
        <a class="nav-link" href="${ctp}/MemberJoin.mem">Join</a>
      </li>
    </c:if>
    </ul>
  </div>  
</nav>