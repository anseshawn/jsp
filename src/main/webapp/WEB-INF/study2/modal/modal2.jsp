<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>modal2.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function fCheck1(name) {
  		//let name = myform.name.value;
  		$("#myModal2 #modalName1").text(name);
  	}
  	
  	// 내가 한거...
  	/* 
  	function fCheck2() {
  		let mid = myform.mid.value;
			$.ajax({
				url: "Modal2.st",
				type: "get",
				data: {mid:mid},
				success: function(){
		  		$("#myModal2 #modalName1").text("${mVo.name}");
		  		$("#myModal2 #modalName2").text(mid);					
				},
				error: function(){
					alert("전송오류");
				}
			});
  	}
  	*/
  	
  	// 값을 가지고 온 다음에 modal로 띄워줘야 한다
  	function modalCheck2() {
  		let mid = myform.mid.value;
  		location.href = "Modal2.st?mid="+mid;
  	}
  	function fCheck2() {
  		$("#myModal2 #modalName2").text('${mVo.name}');
  	}
  	
  	
  	function fCheck3(name,mid,nickName){
  		$("#myModal3 #modalName").text(name);  		
  		$("#myModal3 #modalMid").text(mid);  		
  		$("#myModal3 #modalNickName").text(nickName);  		
  	}
  	
  	// 모달 창 안에 form태그 만들기
  	function nameCheck() {
  		
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>Modal 연습2</h2>
	<hr/>
	<p>
		<input type="button" value="폼내용출력" class="btn btn-primary" data-toggle="modal" data-target="#myModal1"/>
		<!-- 버튼으로 출력 시 안되는 경우가 있기 때문에 a href 태그를 사용 -->
		<a href="#" onclick="fCheck1('홍길동')" class="btn btn-secondary" data-toggle="modal" data-target="#myModal2">폼내용출력2</a>
		<a href="#" onclick="fCheck2()" class="btn btn-warning" data-toggle="modal" data-target="#myModal2">폼내용출력3(DB)</a>
		<a href="#" onclick="fCheck3('${mVo.name}','${mVo.mid}','${mVo.nickName}')" class="btn btn-success" data-toggle="modal" data-target="#myModal3">모달폼내용출력(DB)</a>
		<!-- 모달을 호출할 때 이미 가지고 와 있는 값을 던져준다 -->
	</p>
	<hr/>
	<div>
    <form name="myform">
      <div class="input-group">
        <div class="input-group">아이디</div>
        <div class="input-group-prepend"><input type="text" name="mid" placeholder="아이디를 입력하세요" class="form-control"/></div>
        <div class="input-group-prepend"><input type="button" value="아이디검색" onclick="modalCheck2()" class="btn btn-success"/></div>
      </div>
    </form>
	</div>
</div>
<p><br/></p>

<!-- The Modal1 -->
<div class="modal fade" id="myModal1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        Modal body..
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<!-- The Modal2 -->
<div class="modal fade" id="myModal2">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">Modal Heading</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        성명1 : <span id="modalName1"></span>
        성명2 : <span id="modalName2"></span>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<!-- The Modal3 -->
<div class="modal fade" id="myModal3">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원 정보 찾기</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="midModalForm">
      		<!-- 
      		아이디 : 
      		<input type="text" name="mid" id="mid" placeholder="아이디를 입력하세요" class="form-control mb-2" required />
      		<input type="button" value="이름확인" onclick="nameCheck()" class="btn btn-success form-control" />
      		 -->
      		 아이디 : <span id="modalMid"></span><br/>
      		 성명 : <span id="modalName"></span><br/>
      		 닉네임 : <span id="modalNickName"></span><br/>
      	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
<jsp:include page="/include/footer.jsp" />
</body>
</html>