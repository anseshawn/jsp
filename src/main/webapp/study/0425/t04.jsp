<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>t04.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>값 전송 연습(Get/Post)</h2>
	<!-- <form name="myform" method="post" action="/javaclass/j0425/T04Ok"> --> <!-- javaclass: 컨텍스트 경로 / j0425: 중간경로 -->
	<form name="myform" method="post" action="<%=request.getContextPath() %>/j0425/T04Ok"> <!-- 수정이 번거롭거나 잘 모를 수 있기 때문에 서버로부터 받아옴 -->
		<div>성명
		 <input type="text" name="name" value="홍길동" class="form-control mb-3" autofocus required />
		</div>
		<div>나이
		 <input type="text" name="age" value="20" class="form-control mb-3" required />
		</div>
		<div>
		 <input type="submit" value="전송(submit)" class="btn btn-success"/>
		</div>
	</form>
</div>
<p><br/></p>
</body>
</html>