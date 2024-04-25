<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String fileName = request.getParameter("img")==null ? "" : request.getParameter("img");
	String[] files = request.getParameterValues("img2");
	String img = "";
	
	if(!fileName.equals("")) {
		img = "<img src='"+path+"/images/"+fileName+".jpg' width='400px' /><br/>";
	}
	String imgSrcs = "";
	if(files != null) {
		for(int i=0; i<files.length; i++) {
			imgSrcs += "<img src='"+path+"/images/"+files[i]+".jpg' width='400px' /><br/>";
		}
	}
	else imgSrcs = "";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t08Ok.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>선택한 그림파일</h2>
	<p>그림파일 이름: <%=fileName %>.jpg</p>
	<hr/>
	<p><%=img %></p>
	<hr/>
	<p><%=imgSrcs %></p>
	<p><a href="t08_이미지숙제.jsp" class="btn btn-primary">돌아가기</a></p>
</div>
<p><br/></p>
</body>
</html>