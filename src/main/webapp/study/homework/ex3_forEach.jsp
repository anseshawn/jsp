<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "/include/certification.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ex3_forEach.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>jstl2 forEach 과제</h2>
	<p>사용법 2</p>
<%
	String[] cards = {"국민","BC","LG","현대","삼성","농협","비자"};
	pageContext.setAttribute("cards", cards);
%>
	<c:forEach var="card" items="${cards}">
		${card} /
	</c:forEach>
	<br/><br/>
	
	<h5>9. 앞의 사용법2번에 저장한 cards의 내용 중, '국민카드'는 파란색, '삼성카드'는 빨간색, 첫번째 카드의 배경색은 노란색, 마지막 카드의 배경색은 하늘색</h5>
	<c:forEach var="card" items="${cards}" varStatus="st">
		<c:if test="${st.first}">
			<span style="background-color:yellow">
				<c:if test="${st.current == '국민'}"><span style="color:blue;">${card}</span></c:if>
				<c:if test="${st.current == '삼성'}"><span style="color:red">${card}</span></c:if>
				<c:if test="${st.current != '국민' && st.current != '삼성'}"><span style="color:black">${card}</span></c:if>
			</span>/
		</c:if>
		<c:if test="${st.last}">
			<span style="background-color:skyblue">
				<c:if test="${st.current == '국민'}"><span style="color:blue">${card}</span></c:if>
				<c:if test="${st.current == '삼성'}"><span style="color:red">${card}</span></c:if>
				<c:if test="${st.current != '국민' && st.current != '삼성'}"><span style="color:black">${card}</span></c:if>
			</span>/
		</c:if>
		<c:if test="${!st.first && !st.last}">${card} /</c:if>
		<c:if test="${!st.first && !st.last && st.current == '국민'}"><span style="color:blue">${card}</span></c:if>
		<c:if test="${!st.first && !st.last && st.current == '삼성'}"><span style="color:red">${card}</span></c:if>
	</c:forEach>
	
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>