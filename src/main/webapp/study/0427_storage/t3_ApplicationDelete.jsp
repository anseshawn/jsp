<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t3_ApplicationDelete.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function applicationDelete() {
  		let applicationSW = document.getElementById("applicationSW").value;
  		
  		if(applicationSW == ""){
  			alert("삭제할 값을 선택하세요.");
  			return false;
  		}
  		// 뷰 페이지는 실행될 때 서버 프로그램이 먼저 수행되기 때문에 < % 가 먼저 실행이 됨 따라서 중간에 자바함수를 넣을 수 없음
  		location.href = "t3_ApplicationDeleteOk.jsp?applicationSW="+applicationSW;
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>어플리케이션 삭제</h2>
	<select name="applicationSW" id="applicationSW" onclick="applicationDelete()">
		<option value="">선택</option>
		<option value="aMid">아이디</option>
		<option value="aNickName">닉네임</option>
		<option value="aName">성명</option>
	</select>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>