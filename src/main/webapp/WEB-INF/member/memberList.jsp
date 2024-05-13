<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberList.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	$(function(){
  		$("#userDisplay").hide();
  		$("#userInfor").on("click",function(){
  			if($("#userInfor").is(':checked')){
  				$("#tatalList").hide();
  				$("#userDisplay").show();
  			}
  			else {
  				$("#tatalList").show();
  				$("#userDisplay").hide();
  			}
  		});
  	});
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
<c:if test="${sLevel == 0}">
	<input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> 비공개회원 보기/가리기
<!-- 		<div class="custom-control custom-checkbox">
	    <input type="checkbox" class="custom-control-input" id="userInfor" name="userInfor" onclick="userCheck()"/>
	    <label class="custom-control-label" for="customCheck">비공개 회원 같이 보기</label>
 	 	</div> -->
</c:if>
<div id="tatalList">
	<h3 class="text-center">전체 회원 리스트</h3>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>이름</th>
			<th>생일</th>
			<th>성별</th>
			<th>최종방문일</th>
			<c:if test="${sLevel == 0}">
				<th>오늘방문횟수</th>
				<th>탈퇴신청여부</th>
			</c:if>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
				<c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"></c:set> </c:if>
				<c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"></c:set> </c:if>
				<tr>
					<td>${vo.idx}</td>
					<td><a href="MemberSearch.mem?mid=${vo.mid}">${vo.mid}</a></td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>${fn:substring(vo.birthday,0,10)}</td>
					<td>${vo.gender}</td>
					<td>${fn:substring(vo.lastDate,0,10)}</td>
					<c:if test="${sLevel == 0}">
						<td>${vo.todayCnt}</td>
						<td>
							<c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if> 
							<c:if test="${vo.userDel != 'OK'}">${active}</c:if> 
						</td>
					</c:if>
				</tr>
			</c:if>
		</c:forEach>
		<tr><td colspan="9" class="m-0 p-0"></td></tr>
	</table>
</div>
	<div id="userDisplay">
		<c:if test="${sLevel == 0}">
			<hr/>
			<h3 class="text-center">비공개 회원 리스트</h3>
			<table class="table table-hover">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이름</th>
				<th>생일</th>
				<th>성별</th>
				<th>최종방문일</th>
			<c:if test="${sLevel == 0}">
				<th>오늘방문횟수</th>
				<th>탈퇴신청여부</th>
			</c:if>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<c:if test="${vo.userInfor == '비공개'}">
					<tr>
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.nickName}</td>
						<td>${vo.name}</td>
						<td>${fn:substring(vo.birthday,0,10)}</td>
						<td>${vo.gender}</td>
						<td>${fn:substring(vo.lastDate,0,10)}</td>
						<c:if test="${sLevel == 0}">
							<td>${vo.todayCnt}</td>
							<td>${vo.userDel}</td>
						</c:if>
					</tr>
				</c:if>
			</c:forEach>
			<tr><td colspan="9" class="m-0 p-0"></td></tr>
			</table>
		</c:if>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>