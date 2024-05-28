<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMain.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	// 채팅 내용을 DB에 저장하기
  	function chatInput(){
  		let chat = $("#chat").val();
  		if(chat.trim() != "") {
  			$.ajax({
  				url: "MemberChatInput.mem",
  				type: "post",
  				data: {chat : chat},
  				success: function(){},
  				error: function(){
  					alert("전송오류");
  				}
  			});
  		}
  	}
  	
  	// 채팅 대화 입력 후 엔터키를 누르면 자동으로 메세지 DB에 저장시키기...chatInput()함수 호출
  	$(function(){
  		$("#chat").on("keydown",function(e){
  			if(e.keyCode == 13) chatInput(); // 13: 엔터키
  		});
  	});
  	
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 전용방</h2>
	<hr/>
	<!-- 실시간 채팅방(DB) -->
  e<div class="row">
    <div class="col" style="width:420px">
	    <form name="chatForm">
	      <label for="chat"><b>실시간 대화방</b></label>
	      <iframe src="${ctp}/include/memberMessage.jsp" width="100%" height="200px" class="border"></iframe>
	      <div class="input-group mt-1">
	        <input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요" autofocus />
	        <div class="input-group-append">
	          <input type="button" value="글등록" onclick="chatInput()" class="btn btn-success"/>
	        </div>
	      </div>
	    </form>
	  </div>
	<!-- 실시간 채팅방 끝 -->
		  <div class="col text-center">
	    <b>신규 메세지(<font color='red'><b>${wmCnt}</b></font>건)</b>
	    <span style="font-size:11px">...<a href="WebMessage.wm">more</a></span>
      <c:if test="${wmCnt != 0}">
		    <table class="table table-bordered table-hover text-center">
		      <tr class="table-dark text-dark">
		        <th>번호</th>
		        <th>아이디</th>
		        <th>보낸날짜</th>
		      </tr>
			    <c:forEach var="vo" items="${wmVos}" varStatus="st">
			      <c:if test="${st.count <= 3}">
				      <tr>
				        <td>${st.count}</td>
				        <td>${vo.sendId}</td>
				        <td>${fn:substring(vo.sendDate,0,16)}</td>
				      </tr>
			      </c:if>
			    </c:forEach>
			    <tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </table>
      </c:if>
      <hr/>
      <div>
        오늘의 일정이 <font color='blue'><b><a href="ScheduleMenu.sc?ymd=${ymd}">${scheduleCnt}</a></b></font>건 있습니다.
      </div>
	  </div>
	</div>
  <hr/>
  <div class="row" id="visitCount">
    <div class="col">
	  	<p>현재 <b><font color="blue">${sNickName}</font>(<font color="red">${strLevel}</font>)</b> 님이 로그인 중이십니다.</p>
	  	<p>총 방문횟수 : <b>${mVo.visitCnt}</b> 회</p>
	  	<p>오늘 방문횟수 : <b>${mVo.todayCnt}</b> 회</p>
	  	<p>총 보유 포인트 : <b>${mVo.point}</b> 점</p>
  	</div>
  	
		<div class="col">
			<p><img src="${ctp}/images/member/${mVo.photo}" width="200px"/></p>
		</div>
	</div>
	<hr/>
	<div>
		<h5>활동내역</h5>
		<p>방명록에 올린 글 수 : <b>${guestCnt}</b>건</p>
		<p>게시판에 올린 글 수 : __건</p>
		<p>자료실에 올린 글 수 : __건</p>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>