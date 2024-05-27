<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>webMessage.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use district';
  	
  	function wmDeleteAll(){
  		let ans = confirm("휴지통을 모두 비우시겠습니까?");
  		if(!ans) return false;
  		
  		$.ajax({
  			url: "WmDeleteAll.wm",
  			type: "post",
  			success: function(res){
  				if(res != "0") {
  					alert("휴지통의 모든 메세지가 삭제되었습니다.");
  					location.reload();
  				}
  				else alert("삭제 실패");
  			},
  			error: function(){
  				alert("전송오류");
  			}
  		});
  	}
  </script>
  <style>
  	#leftWindow {
  		float : left;
  		width : 25%;
  		height : 520px;
  		text-align: center;
  		background-color: #ddd;
  	}
  	#rightWindow {
  		float : left;
  		width : 75%;
  		height : 520px;
  		text-align: center;
  		background-color: #eee;
  		overflow: auto;
  	}
  	#footerTopMargin {
  		clear: both;
  		margin: 10px;
  	}
  	h3 {text-align: center}
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h3>메세지 관리</h3>
	<div>(현재 접속: <font color="blue">${sMid}</font>)</div>
</div>
<div id="leftWindow">
	<p><br/></p>
	<p><a href="WebMessage.wm?mSw=0">메세지작성</a></p>
	<p><a href="WebMessage.wm?mSw=1&mFlag=11">받은메세지</a></p>
	<p><a href="WebMessage.wm?mSw=2">새 메세지</a></p>
	<p><a href="WebMessage.wm?mSw=3&mFlag=13">보낸메세지</a></p>
	<p><a href="WebMessage.wm?mSw=4">수신확인</a></p>
	<p><a href="WebMessage.wm?mSw=5&mFlag=15">휴지통</a></p>
	<p><a href="javascript:wmDeleteAll()">휴지통비우기</a></p>
</div>
<div id="rightWindow"> <!-- 메뉴에 해당하는 화일이 화면에 뜨도록 필요한 부분을 include로 사용 -->
 <!-- web-inf 아래에 있는 파일은 컨트롤러를 통해야 들어갈 수 있지만 include는 본인 위치에 있으면 바로 불러올 수 있음 -->
	<p>
		<c:if test="${mSw==0}">
			<h3>메세지 작성</h3>
			<jsp:include page="wmInput.jsp"/>
		</c:if>
	</p>
	<p>
		<c:if test="${mSw==1}">
			<h3>받은메세지</h3>
			<jsp:include page="wmList.jsp"/>	
		</c:if>
		<c:if test="${mSw==2}">
			<h3>새 메세지</h3>
			<jsp:include page="wmList.jsp"/>	
		</c:if>
		<c:if test="${mSw==3}">
			<h3>보낸메세지</h3>
			<jsp:include page="wmList.jsp"/>	
		</c:if>
		<c:if test="${mSw==4}">
			<h3>수신확인</h3>
			<jsp:include page="wmList.jsp"/>	
		</c:if>
		<c:if test="${mSw==5}">
			<h3>휴지통</h3>
			<jsp:include page="wmList.jsp"/>	
		</c:if>
		<c:if test="${mSw==6}">
			<h3>메세지 내용보기</h3>
			<jsp:include page="wmContent.jsp"/>	
		</c:if>
	</p>
</div>
<br/>
<div id="footerTopMargin">&nbsp;</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>