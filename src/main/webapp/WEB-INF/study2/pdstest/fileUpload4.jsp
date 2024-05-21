<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>fileUpload4.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		//let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
  		let fName = document.getElementById("file").value;
  		let fNames = "";
  		let ext = "";
  		let fileSize = 0;
  		let maxSize = 1024 * 1024 * 10; // 기본 단위 : Byte, 1024 * 1024: Mb, 1024*1024*10 = 10MByte 허용
  		
  		if(fName.trim() == "") {
  			alert("업로드할 파일을 선택하세요");
  			return false;
  		}
  		
  		let fileLength = document.getElementById("file").files.length; // 선택한 파일들의 개수
  		
  		for(let i=0; i<fileLength; i++) {
  			fName = document.getElementById("file").files[i].name; // 선택된 1개의 파일 이름 가져오기
  			ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	  		fileSize = document.getElementById("file").files[i].size;
	  		if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'zip' && ext != 'hwp' && ext != 'ppt' && ext != 'pptx' && ext != 'doc' && ext != 'pdf' && ext != 'xlsx' && ext != 'txt') {
	  			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt' 입니다.");
	  		}
	  		fNames += fName + "/";
  		}
  		
  		if(fileSize > maxSize) {
  			alert("업로드 파일의 최대용량은 10MByte입니다.");
  		}
  		else {
  			document.getElementById("fNames").value = fNames;
  			myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 연습4(멀티파일처리)</h2>
	<p>COS라이브러리를 이용한 파일 업로드</p>
	<div>(http://www.servlets.com/cos/)</div>
	<hr/>
	<form name="myform" method="post" action="FileUpload4Ok.st" enctype="multipart/form-data">
		파일명 : 
		<div>
			<input type="file" name="fName" id="file" multiple class="form-control-file border mb-2"/>
		</div>
		<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-primary form-control" />
		<input type="hidden" name="nickName" value="${sNickName}" />	
		<input type="hidden" name="fNames" id="fNames" />	
	</form>
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