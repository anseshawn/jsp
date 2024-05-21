<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>fileUpload1.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let fName = document.getElementById("file").value;
  		let maxSize = 1024 * 1024 * 10; // 기본 단위 : Byte, 1024 * 1024: Mb, 1024*1024*10 = 10MByte 허용
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
  		
  		if(fName.trim() == "") {
  			alert("업로드할 파일을 선택하세요");
  			return false;
  		}
  		
  		let fileSize = document.getElementById("file").files[0].size;
  		if(fileSize > maxSize) {
  			alert("업로드할 파일의 최대용량은 10MByte입니다.");
  		}
  		else if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip' && ext != 'hwp' && ext != 'ppt' && ext != 'pptx' && ext != 'doc' && ext != 'pdf' && ext != 'xlsx' && ext != 'txt') {
  			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt' 입니다.");
  		}
  		else {
	  		demo.innerHTML = fName;
  			myform.submit();
  		}
  		
  	}
  	
  	// 선택된 그림 미리보기
  	function imgCheck(e) {
  		// 이벤트 발생시에 그림이 들어왔고 0번 화일이 차있을때
  		if(e.files && e.files[0]) {
  			let reader = new FileReader();
  			// 리더에 의해서 무언가가 들어오면 익명함수 실행
  			reader.onload = function(e) {
  				document.getElementById("demoImg").src = e.target.result;
  			}
  			reader.readAsDataURL(e.files[0]);
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 연습(싱글파일처리)</h2>
	<p>COS라이브러리를 이용한 파일 업로드</p>
	<div>(http://www.servlets.com/cos/)</div>
	<hr/>
	<form name="myform" method="post" action="FileUpload1Ok.st" enctype="multipart/form-data">
		파일명 : 
		<input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border mb-2"/>
		<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-primary form-control" />
		<!-- <input type="submit" value="파일전송" class="btn btn-primary form-control" /> -->
		<input type="hidden" name="nickName" value="${sNickName}" />	
	</form>
	<hr/>
	<div id="demo"></div>
	<img id="demoImg" width="200px" />
	<hr/>
	<div class="row">
		<div class="col"><a href="FileDownLoad.st" class="btn btn-success form-control">다운로드 폴더로 이동하기</a></div>
		<div class="col"><a href="FileUpload.st" class="btn btn-warning form-control">돌아가기</a></div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>