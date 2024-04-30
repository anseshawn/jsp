<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file = "/include/certification.jsp" %>
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
	<!-- 시작단과 끝단을 입력받아서(항상 시작단이 작은 숫자가 오도록 처리)
				한 행에 처리할 단의 수를 입력받은 후,
				조건에 맞도록 구구단을 출력하시오. -->
	<form name="myform" action="ex2_gugudan.jsp">
	  <div class="input-group mb-3">
	    <div class="input-group-prepend">
	      <span class="input-group-text">시작단</span>
	    </div>
	    <input type="number" name="startDan" id="endDan" class="form-control">
	  </div>
	  <div class="input-group mb-3">
	    <div class="input-group-prepend">
	      <span class="input-group-text">끝단</span>
	    </div>
	    <input type="number" name="endDan" id="endDan" class="form-control">
	  </div>
	  <div class="input-group mb-3">
	    <div class="input-group-prepend">
	      <span class="input-group-text">출력할 단</span>
	    </div>
	    <input type="number" name="danSu" id="danSu" class="form-control">
	  </div>
	  <div>
	  	<input type="submit" value="출력하기" class="btn btn-success form-control" />	  
	  </div>
	</form>
	<hr/>
	<c:set var="startDan" value="${param.startDan}"/>
	<c:set var="endDan" value="${param.endDan}"/>
	<c:if test="${startDan+0 > endDan+0 }">
		<c:set var="temp" value="${param.startDan}"/>
		<c:set var="startDan" value="${param.endDan}"/>
		<c:set var="endDan" value="${temp}"/>
	</c:if>
	<c:set var="danSu" value="${param.danSu}"/>
	<table class="table table-bordered">
		<c:set var="cnt" value="0"/>
		<c:forEach var="i" begin="${startDan}" end="${endDan}">
			<c:if test="${cnt % danSu+0 != 0 }">
				<tr>
					<c:set var="cnt" value="${cnt+1}"/>
					<td>* * ${i}단 * *<br/>
					<c:forEach var="j" begin="1" end="9">
						${i} * ${j} = ${i*j}<br/>
					</c:forEach>
					</td>			
				</tr>
			</c:if>
			<c:if test="${cnt % danSu == 0 }">
				<tr></tr>
			</c:if>
		</c:forEach>
	</table>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>