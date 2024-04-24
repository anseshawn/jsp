<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String su1 = request.getParameter("su1");
	String su2 = request.getParameter("su2");
	String tot = request.getParameter("tot");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>test11Ok.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<p>수1: <%=su1 %> 부터 수2: <%=su2 %>까지의 합
	<p>연산결과 : <%=tot %></p>
	<p><a href="test11.jsp" class="btn btn-success">돌아가기</a></p>
	<!-- 같은 경로 안에 있으면 파일명만 적어줄 수 있음 -->
</div>
<p><br/></p>
</body>
</html>