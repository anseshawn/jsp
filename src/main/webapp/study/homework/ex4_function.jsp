<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file = "/include/certification.jsp" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
  <%@ include file = "/include/bs4.jsp" %>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
<%
	String str = "Welcome to My Homepage!!!";
	pageContext.setAttribute("str", str);
%>

	4-4. str변수의 'o'문자의 2번째 위치값만 출력하시오?<br/>
	- (1) str 변수에 기억된 문자중 'o'의 위치를 찾아서 변수에 기억시켜둔다. :
  <c:set var="position1" value="${fn:indexOf(str,'o')}"/> <font color='red'><b>${position1}</b></font><br/>
  - (2) substring()을 사용한, 첫번째로 만나는 'o'의 문자 뒤의 모든값을 변수에 담는다 :
  <c:set var="str1" value="${fn:substring(str,fn:indexOf(str,'o')+1,fn:length(str))}"/>
  <font color='red'><b>${str1}</b></font><br/>
  - (3) 이어서 저장되어 있는 값중에서 'o'문자의 위치를 변수에 담는다. : 
  <c:set var="position2" value="${fn:indexOf(str1,'o')}"/><font color='red'><b>${position2}</b></font><br/>
  - (4) 처음에 저장된 위치와 2번째 저장된 위치를 더하고 +1 시키면 2번째 'o'의 위치가 된다. : 
  <font color='red'><b>${position1 + position2 + 1}</b></font><br/>
  4-4-2. 4-4의 두번째방법(문법5의 방법사용 : substringAfter()) : 
  <font color='red'><b>${fn:indexOf(str,fn:substringAfter(fn:substringAfter(str,'o'),'o'))-1}</b></font><br/><br/>
  <br/>
	<br/>
	
	4-5. str변수의 'o'문자의 마지막 위치값을 출력하시오?<br/>
  split()함수 사용하기 : <br/>
  <c:set var="strTemps" value="${fn:split(str,'o')}"/>
  <c:set var="strTempsLength" value="${fn:length(strTemps)}"/>
  마지막 'o'문자뒤의 모든 문자열? ${strTemps[strTempsLength-1]}<br/>
  마지막 'o'문자의 위치? <font color='red'><b>${(fn:length(str)-1) - (fn:length(strTemps[strTempsLength-1]))}</b></font>
		
	<br/>
	<hr/>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>