<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String hostIP = request.getRemoteAddr();
	// 서버 저장소(Server Storage): request, pageContext, Session, Application
	// request.setAttribute("hostIP", hostIP); // request: 요청해서 값을 받았을 때 전송되어있는 저장소에 있음(새로고침 하면 없어짐)
	pageContext.setAttribute("hostIP", hostIP); // pageContext: 현재페이지에 받아옴 (생명주기가 사라짐)
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t01.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
<body>
<%@ include file = "/include/header.jsp" %>
<%@ include file = "/include/nav.jsp" %>
<p><br/></p>
<div class="container">
	<h2>서버의 환경변수값 확인하기</h2>
	<hr/>
	<div>호스트IP1 : <%=request.getRemoteAddr() %></div> <!-- 접속 컴퓨터 아이피 확인 가능 -->
	<div>호스트IP2 : ${hostIP}</div>
	<div>전송방식 : <%=request.getMethod() %></div>
	<div>접속프로토콜 : <%=request.getProtocol() %></div>
	<div>접속(서버)포트 : <%=request.getServerPort() %></div>
	<div>접속(서버)이름 : <%=request.getServerName() %></div>
	<div>접속 Context이름 : <%=request.getContextPath() %></div>
	<div>접속 URL : <%=request.getRequestURL() %></div> <!-- 접속주소 전체 다 -->
	<div>접속 URI : <%=request.getRequestURI() %></div> <!-- 식별자 -->
</div>
<p><br/></p>
<%@ include file = "/include/footer.jsp" %>
</body>
</html>