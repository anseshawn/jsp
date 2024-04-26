<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = request.getParameter("mid");
	String pwd = request.getParameter("pwd");
	
	pageContext.setAttribute("mid", mid);
	pageContext.setAttribute("pwd", pwd);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t03Ok.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
</head>
<body>
<%-- <%@ include file = "/include/header.jsp" %> --%>
<jsp:include page="/include/header.jsp" /> <!-- jsp의 함수를 사용 -->
<%-- <%@ include file = "/include/nav.jsp" %> --%>
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 정보(t03Ok.jsp)</h2>
	<hr/>
	<p>아이디 : ${mid}</p>
	<p>비밀번호 : ${pwd}</p>
	<hr/>
	<p><a href="t03.jsp" class="btn btn-warning">돌아가기</a></p>
	
	 <%-- jsp: - dispatcher 표현과 같은 표현, jsp에서는 이렇게 쓰인다 --%><%-- 넘길값, 넘어가서 사용할 변수명 순서 --%>
<% if(mid.substring(mid.length()-1).equals("I")) { %>
	<jsp:forward page="t03ResI.jsp">
		<jsp:param value="${mid}" name="mid"/> 
		<jsp:param value="${pwd}" name="pwd"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("J")) { %>
	<jsp:forward page="t03ResJ.jsp">
		<jsp:param value="${mid}" name="mid"/>
		<jsp:param value="${pwd}" name="pwd"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("C")) { %>
	<jsp:forward page="t03ResC.jsp">
		<jsp:param value="${mid}" name="mid"/>
		<jsp:param value="${pwd}" name="pwd"/>
	</jsp:forward>
<%} else if(mid.substring(mid.length()-1).equals("S")) { %>
	<jsp:forward page="t03ResS.jsp">
		<jsp:param value="${mid}" name="mid"/>
		<jsp:param value="${pwd}" name="pwd"/>
	</jsp:forward>
<%} %>

</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>