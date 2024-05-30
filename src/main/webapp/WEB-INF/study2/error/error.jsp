<%@page import="member.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	MemberVO vo = new MemberVO();
	vo.setMid("hkd1234");
	pageContext.setAttribute("vo", vo);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>error.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>Error 페이지 연습</h2>
	<hr/>
	<div><a href="ErrorJSP.st" class="btn btn-primary mb-2">JSP에러 발생</a></div>
	<div><a href="Error400.st?vo=${vo}" class="btn btn-success mb-2">400에러 발생(x)</a></div>
	<div><a href="Error404.st" class="btn btn-success mb-2">404에러 발생</a></div>
	<div><a href="Error500.st" class="btn btn-info">500에러 발생</a></div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>