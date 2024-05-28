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
	        <a class="nav-link" href="BoardList.bo">Board</a>
	      </li>
	    </c:if>
      <c:if test="${level<=4 && (level>1 || level==0)}"> <!-- 로그인 후 게시판 권한 등급 조절 -->	      
	      <li class="nav-item">
	        <a class="nav-link" href="PdsList.pds">PDS</a>
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
			    </div>
	      </li>
	      <li class="nav-item dropdown">
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
			      <a class="dropdown-item" href="Modal1.st">모달연습1</a>
			      <a class="dropdown-item" href="Modal2.st">모달연습2</a>
			      <a class="dropdown-item" href="FileUpload.st">파일업로드</a>
			    </div>
	      </li>
	      <li class="nav-item dropdown">
			    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">Study3</a>
			    <div class="dropdown-menu">
			      <a class="dropdown-item" href="Calendar1.st">달력연습1</a>
			      <a class="dropdown-item" href="Calendar2.st">달력연습2</a>
			      <a class="dropdown-item" href="ScrollStudy.st">스크롤연습</a>
			      <a class="dropdown-item" href="ScrollBasic.st">무한스크롤</a>
			    </div>
	      </li>
			</c:if>
     </ul>
		<ul class="navbar-nav ml-auto">
		<c:if test="${level <= 4}">
      <li class="nav-item dropdown">
		    <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">MyPage</a>
		    <div class="dropdown-menu">
		      <a class="dropdown-item" href="MemberMain.mem">회원메인화면</a>
		      <c:if test="${level<=4 && (level > 1 || level==0)}">
			      <a class="dropdown-item" href="Schedule.sc">일정관리</a>
			      <a class="dropdown-item" href="WebMessage.wm">메세지관리</a>
			      <a class="dropdown-item" href="MemberList.mem">회원리스트</a>
		      </c:if>
		      <a class="dropdown-item" href="MemberPwdCheck.mem">내정보수정</a>
		    <div class="dropdown-divider"></div>
		      <a class="dropdown-item" href="MemberDelete.mem">회원탈퇴</a>
		      <c:if test="${level == 0}"><a class="dropdown-item" href="AdminMain.ad">관리자메뉴</a></c:if>
		    </div>
      </li>
    </c:if>
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