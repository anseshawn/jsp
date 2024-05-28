<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>scrollStudy.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <style>
  	.sample .box {
  		margin: 20px auto;
  		padding: 20px;
  		width: 400px;
  		height: 200px;
  		background-color: #def;
  		border: 2px solid #492;
  		overflow: auto;
  	}
  	.sample .small-box {
  		width: 500px;
  		height: 300px;
  		background-color: #eee;
  		border: 1px dashed #492;
  		display: flex;
  		align-items: center; 			/* flex의 수직 가운데 정렬 */
  		justify-content: center;	/* flex의 수평 가운데 정렬 */
  	}
  </style>
  <script>
  	'use strict';
  	
  	$(function(){
  		const box = document.querySelector(".sample .box"); // box의 정보를 가져오기
  		
  		// box에서 스크롤 시킬 때 정보 수집
  		box.addEventListener("scroll",()=>{
				let x = box.scrollLeft; // 스크롤바의 x축(왼쪽)시작좌표
				let y = box.scrollTop; // 스크롤바의 y축(위쪽)시작좌표
  			
  			document.querySelector("#disp .h").innerHTML = x;
  			document.querySelector("#disp .v").innerHTML = y;
  		});
  		
  		/* 스크롤바 제어하기 */
  		// 초기화버튼
  		document.querySelector(".sampleBtn .btn1").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollLeft = 0;
  			document.querySelector(".sample .box").scrollTop = 0;
  			
  		});
  		// 오른쪽 이동 버튼
  		document.querySelector(".sampleBtn .btn2").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollLeft = 150;
  			
  		});
  		// 아래쪽 이동 버튼
  		document.querySelector(".sampleBtn .btn3").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollTop = 150;
  			
  		});
  		// x축으로 10 증가/감소
  		document.querySelector(".sampleBtn .btn4").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollLeft += 10;
  			
  		});
  		document.querySelector(".sampleBtn .btn5").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollLeft -= 10;
  			
  		});
  		// y축으로 10 증가/감소
  		document.querySelector(".sampleBtn .btn6").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollTop += 10;
  			
  		});
  		document.querySelector(".sampleBtn .btn7").addEventListener("click",(e)=>{
  			e.preventDefault(); // 처음값으로
  			document.querySelector(".sample .box").scrollTop -= 10;
  			
  		});
  	})
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<jsp:include page="/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<h3>스크롤 학습하기</h3>
	<div class="sample text-center">
		<div class="box">
			<div class="small-box">
				<span class="text-success">박스 안에서 스크롤바를 '상/하/좌/우'로 이동해 보세요</span>
			</div>
		</div>
	</div>
	<div class="text-danger text-center" id="disp">
		<strong>
			<span class="h">0</span>px /
			<span class="v">0</span>px
		</strong>		
	</div>
	<hr/>
	<div class="sampleBtn">
		<div>
			<input type="button" value="초기화" class="btn btn-success mb-2 btn1" />
		</div>
		<div>
			<input type="button" value="x축으로 +150px" class="btn btn-primary mb-2 btn2" />
			<input type="button" value="y축으로 +150px" class="btn btn-outline-primary mb-2 btn3" />
		</div>
		<div>
			<input type="button" value="x축으로 10px증가" class="btn btn-primary mb-2 btn4" />
			<input type="button" value="x축으로 10px감소" class="btn btn-outline-primary mb-2 btn5" />
		</div>
		<div>
			<input type="button" value="y축으로 10px증가" class="btn btn-primary mb-2 btn6" />
			<input type="button" value="y축으로 10px감소" class="btn btn-outline-primary mb-2 btn7" />
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>