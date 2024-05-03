<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "/include/certification.jsp" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>loginMain.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function nameSearch() {
  		let name = document.getElementById("name").value;
  		if(name.trim() == "") {
  			alert("검색할 성명을 입력하세요.");
  			document.getElementById("name").focus();
  			return false;
  		}
  		else {
  			location.href="${ctp}/database/LoginSearch?name="+name;
  		}
  	}
  	
  	function loginList() {
  		location.href="${ctp}/study/database/LoginList";
  	}
  	
  	function orderList() {
  		let orderOption = document.getElementById("orderOption").value;
  		location.href="${ctp}/study/database/LoginList?option="+orderOption;
  	}

  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">회 원 메 인 방</h2>
	<hr/>
	<div class="text-right">
		<c:if test="${pag > 1}">
			<a href="${ctp}/study/database/LoginList?pag=1&pageSize=${pageSize}" title="처음"><i class="fa-solid fa-backward-fast" style="color:#2A93D5">&nbsp;</i></a>
			<a href="${ctp}/study/database/LoginList?pag=${pag-1}&pageSize=${pageSize}" title="이전페이지"><i class="fa-solid fa-backward-step" style="color:#2A93D5">&nbsp;</i></a>
		</c:if>
		${pag}/${totPage}
		<c:if test="${pag < totPage}">
			<a href="${ctp}/study/database/LoginList?pag=${pag+1}&pageSize=${pageSize}" title="다음페이지"><i class="fa-solid fa-forward-step" style="color:#2A93D5">&nbsp;</i></a>
			<a href="${ctp}/study/database/LoginList?pag=${totPage}&pageSize=${pageSize}" title="끝"><i class="fa-solid fa-forward-fast" style="color:#2A93D5"></i></a>
		</c:if>
	</div>
	<input type="button" value="전체조회" onclick="loginList()" class="btn btn-primary btn-sm mb-2 float-left" />
	<span style="width:150px" class="float-right">
		<select name="orderOption" id="orderOption" onchange="orderList()" class="custom-select custom-select-sm">
	    <%-- <option <c:if test="${orderOption == ''}">selected</c:if>>정렬</option> --%>
	    <option value="name" <c:if test="${orderOption == 'name'}">selected</c:if> >이름 오름차순</option>
	    <option value="name desc" <c:if test="${orderOption == 'name desc'}">selected</c:if>>이름 내림차순</option>
	    <option value="age" <c:if test="${orderOption == 'age'}">selected</c:if>>나이 오름차순</option>
	    <option value="age desc" <c:if test="${orderOption == 'age desc'}">selected</c:if>>나이 내림차순</option>
	    <option value="idx" <c:if test="${orderOption == 'idx'}">selected</c:if>>번호 오름차순</option>
	    <option value="idx desc"  <c:if test="${orderOption == 'idx desc'}">selected</c:if>>번호 내림차순</option>
  	</select>
	</span>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>나이</th>
			<th>성별</th>
			<th>주소</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td><a href="${ctp}/study/database/LoginView?idx=${vo.idx}&name=${vo.name}">${vo.name}</a></td>
				<td>${vo.age}</td>
				<td>${vo.gender}</td>
				<td>${vo.address}</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<hr/><br/>
	<div class="input-group">
		<div class="input-group-prepend"><span class="input-group-text">성명</span></div>
		<input type="text" name="name" id="name" class="form-control"/>
		<button type="button" onclick="nameSearch()" class="input-group-append btn btn-info">개별조회</button>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>