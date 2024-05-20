<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>fileUpload2.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let fName1 = document.getElementById("file1").value;
  		let fName2 = document.getElementById("file2").value;
  		let fName3 = document.getElementById("file3").value;
  		let maxSize = 1024 * 1024 * 10; // 기본 단위 : Byte, 1024 * 1024: Mb, 1024*1024*10 = 10MByte 허용
  		let ext1 = fName1.substring(fName1.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
  		let ext2 = fName2.substring(fName2.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
  		let ext3 = fName3.substring(fName3.lastIndexOf(".")+1).toLowerCase(); // 확장자 부분만 뽑아서 소문자로
  		
  		if(fName1.trim() == "" || fName2.trim() == "" || fName3.trim() == "") {
  			alert("업로드할 파일을 선택하세요");
  			return false;
  		}
  		
  		let fileSize1 = document.getElementById("file1").files[0].size;
  		let fileSize2 = document.getElementById("file2").files[0].size;
  		let fileSize3 = document.getElementById("file3").files[0].size;
  		if(fileSize1 > maxSize || fileSize2 > maxSize || fileSize3 > maxSize) {
  			alert("업로드할 파일의 최대용량은 10MByte입니다.");
  		}
  		else if(ext1 != 'jpg' && ext1 != 'gif' && ext1 != 'png' && ext1 != 'zip' && ext1 != 'hwp' && ext1 != 'ppt' && ext1 != 'pptx' && ext1 != 'doc' && ext1 != 'pdf' && ext1 != 'xlsx' && ext1 != 'txt') {
  			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt' 입니다.");
  		}
  		else if(ext2 != 'jpg' && ext2 != 'gif' && ext2 != 'png' && ext2 != 'zip' && ext2 != 'hwp' && ext2 != 'ppt' && ext2 != 'pptx' && ext2 != 'doc' && ext2 != 'pdf' && ext2 != 'xlsx' && ext2 != 'txt') {
  			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt' 입니다.");
  		}
  		else if(ext3 != 'jpg' && ext3 != 'gif' && ext3 != 'png' && ext3 != 'zip' && ext3 != 'hwp' && ext3 != 'ppt' && ext3 != 'pptx' && ext3 != 'doc' && ext3 != 'pdf' && ext3 != 'xlsx' && ext3 != 'txt') {
  			alert("업로드 가능한 파일은 'jpg/gif/png/zip/hwp/ppt/pptx/doc/pdf/xlsx/txt' 입니다.");
  		}
  		else {
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
	<h2>파일 업로드 연습2(멀티파일처리)</h2>
	<p>COS라이브러리를 이용한 파일 업로드</p>
	<div>(http://www.servlets.com/cos/)</div>
	<hr/>
	<form name="myform" method="post" action="FileUpload2Ok.st" enctype="multipart/form-data">
		파일명 : 
		<input type="file" name="fName1" id="file1" class="form-control-file border mb-2"/>
		<input type="file" name="fName2" id="file2" class="form-control-file border mb-2"/>
		<input type="file" name="fName3" id="file3" class="form-control-file border mb-2"/>
		<input type="button" value="파일전송" onclick="fCheck()" class="btn btn-primary form-control" />
		<!-- <input type="submit" value="파일전송" class="btn btn-primary form-control" /> -->
		<input type="hidden" name="nickName" value="${sNickName}" />	
	</form>
	<hr/>
	<div id="demo"></div>
	<img id="demoImg" width="200px" />
	<hr/>
	<div><a href="FileDownLoad.st" class="btn btn-warning form-control">다운로드 폴더로 이동하기</a></div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>