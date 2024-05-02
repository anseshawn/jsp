<%@page import="study.database.LoginVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="study.database.LoginDAO"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	int sCount = session.getAttribute("sCount")==null ? 0 : (int)session.getAttribute("sCount");
	sCount++;
	session.setAttribute("sCount", sCount);
%>
<%
  //Main main = new Main()
  LoginDAO dao = new LoginDAO();
	ArrayList<LoginVO> recentVos = dao.getRecentFiveMember();
	pageContext.setAttribute("recentVos", recentVos);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>index.jsp</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%@ include file="../../include/bs4.jsp" %>
  <style>
  .fakeimg {
    height: 200px;
    background: #aaa;
  }
  </style>
</head>
<body>
<!-- header -->
<%@ include file="../../include/header.jsp" %>

<!-- 메뉴바(Nav) -->
<%@ include file="../../include/nav.jsp" %>

<div class="container" style="margin-top:30px">
  <div class="row">
    <div class="col-sm-4">
    	<p>오늘 방문 횟수: ${sCount}</p>
      <h2>About Me(${sMid})</h2>
			<h5 class="mb-4">로그인 중인 회원 : ${sName}</h5>
      <h6 class="text-right">최근 가입한 회원</h6>
      <div class="fakeimg">
      	<table class="table table-striped table-hover text-center">
      	  <tr class="thead-dark">
      	    <th>아이디</th>
      	    <th>성명</th>
      	    <th>지역</th>
      	  </tr>
	        <c:forEach var="vo" items="${recentVos}">
	          <tr>
	            <td>${vo.mid}</td>
	            <td>${vo.name}</td>
	            <td>${vo.address}</td>
	          </tr>
	        </c:forEach>
        </table>
      </div>
      <br/>
      <h3>Some Links</h3>
      <p>Lorem ipsum dolor sit ame.</p>
      <ul class="nav nav-pills flex-column">
        <li class="nav-item">
          <a class="nav-link active" href="#">Active</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Link</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#">Disabled</a>
        </li>
      </ul>
      <hr class="d-sm-none">
    </div>
    <div class="col-sm-8">
      <h2>최근 가입 회원 목록</h2>
      <c:set var="today" value="${Date()}" /><br/> 
      <h5>Today : <fmt:formatDate value="${today}" pattern="MM dd, yyyy"/></h5>
      <p><input type="button" value="리스트보기" onclick="location.href='${ctp}/study/database/MainLoginList';" class="btn btn-primary" /></p>
      <table class="table table-hover text-center">
      	<tr>
      		<th>가입번호</th>
      		<th>아이디</th>
      		<th>이름</th>
      		<th>나이</th>
      	</tr>
      	<c:forEach var="vo" items="${vos}" varStatus="st">
	      	<tr>
	      		<td>${vo.idx}</td>
	      		<td>${vo.mid}</td>
	      		<td>${vo.name}</td>
	      		<td>${vo.age}</td>
	      	</tr>
      	</c:forEach>
      	<tr><td colspan="4" class="m-0 p-0"></td></tr>
      </table>
      <br>
      <h2>TITLE HEADING</h2>
      <h5>Title description, Sep 2, 2017</h5>
      <div class="fakeimg">Fake Image</div>
      <p>Some text..</p>
      <p>text sample.</p>
    </div>
  </div>
</div>

<!-- footer -->
<%@ include file="../../include/footer.jsp" %>

</body>
</html>