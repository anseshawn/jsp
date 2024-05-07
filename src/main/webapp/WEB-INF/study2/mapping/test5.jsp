<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "/include/certification.jsp" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>test5.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function selectMenu() {
  		let selection = document.getElementById("menu").value;
  		if(selection == "input") location.href = "t5Input.do5"
  		else if(selection == "update") location.href = "t5Update.do5"
  		else if(selection == "delete") location.href = "t5Delete.do5"
  		else if(selection == "allList") location.href = "t5List.do5"
  	}
  	
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 메뉴</h2>
	<form name="myform">
		<select name="menu" id="menu" onchange="selectMenu()" class="custom-select mt-3">
	  	<option selected>선택</option>
	  	<option value="input">회원가입</option>
	    <option value="update">수정</option>
	    <option value="delete">삭제</option>
	    <option value="allList">전체리스트</option>
	  </select>
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>