<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberList.jsp</title>
  <%@ include file = "/include/bs4.jsp" %>
  <script>
  	'use strict';
  	
  	$(function(){
  		$("#userDisplay").hide();
  		$("#userInfor").on("click",function(){
  			if($("#userInfor").is(':checked')){
  				$("#tatalList").hide();
  				$("#userDisplay").show();
  			}
  			else {
  				$("#tatalList").show();
  				$("#userDisplay").hide();
  			}
  		});
  	});
  	
  	// 각 레벨 별 회원 보기
  	function levelItemCheck() {
  		let level = $("#levelItem").val();
  		location.href="MemberList.ad?level="+level;
  	}
  	
  	// 회원별 각각의 등급 변경 처리(AJAX처리)
  	function levelChange(e) {
  		let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
  		if(!ans) {
  			location.reload();
  			return false;
  		}
  		
  		let items = e.value.split("/");
  		let query = {
  				level : items[0],
  				idx : items[1]
  		}
  		$.ajax({
  			url: "MemberLevelChange.ad",
  			type: "get",
  			data: query,
  			success: function(res){
  				if(res != "0") {
  					alert("등급 수정이 완료되었습니다.");
  					location.reload();
  				}
  				else alert("등급 수정 실패");
  			},
  			error: function(){
  				alert("전송오류");
  			}
  		});
  	}
  	
  	// 탈퇴 신청 후 30일 경과 회원 삭제처리
  	function memberDeleteOk(idx) {
  		// 원래는 탈퇴할 때 자료실에서 사진도 삭제해야 함(기본 이미지 제외)
  		let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
  		if(ans) {
  			$.ajax({
  				url: "MemberDeleteOk.ad",
  				type: "post",
  				data: {idx : idx},
  				success: function(res){
  					if(res != "0") {
  						alert("영구 삭제가 완료되었습니다.");
  						location.reload();
  					}
  					else alert("삭제 실패~");
  				},
  				error: function(){
  					alert("전송 오류");
  				}
  			});
  		}
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
<div class="row">
	<div class="col">
		<input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> 비공개회원 보기/가리기
	<!-- 		<div class="custom-control custom-checkbox">
		    <input type="checkbox" class="custom-control-input" id="userInfor" name="userInfor" onclick="userCheck()"/>
		    <label class="custom-control-label" for="customCheck">비공개 회원 같이 보기</label>
	 	 	</div> -->
 	</div>
	<div class="col text-right">
		<select name="levelItem" id="levelItem" onchange="levelItemCheck()">
			<option value="999" selected>전체보기</option>
			<option value="1" ${level == 1 ? "selected" : "" }>준회원</option>
			<option value="2" ${level == 2 ? "selected" : "" }>정회원</option>
			<option value="3"  ${level == 3 ? "selected" : "" }>우수회원</option>
			<option value="99"  ${level == 99 ? "selected" : "" }>탈퇴신청회원</option>
			<option value="0"  ${level == 0 ? "selected" : "" }>관리자</option>
		</select>
	</div>
</div>
<hr/>
<div id="tatalList">
	<h3 class="text-center">전체 회원 리스트</h3>
	<table class="table table-hover text-center">
		<tr>
			<td></td>
		</tr>
		<tr class="table-dark text-dark">
			<th></th>
			<th>번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>이름</th>
			<th>생일</th>
			<th>성별</th>
			<th>최종방문일</th>
			<th>오늘방문횟수</th>
			<th>활동여부</th>
			<th>현재레벨</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
				<c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"></c:set> </c:if>
				<c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"></c:set> </c:if>
				<tr>
					<td><input type="checkbox" name="selectUser" id="selectUser" /> </td>
					<td>${vo.idx}</td>
					<td><a href="MemberSearch.mem?mid=${vo.mid}">${vo.mid}</a></td>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
					<td>${fn:substring(vo.birthday,0,10)}</td>
					<td>${vo.gender}</td>
					<td>${fn:substring(vo.lastDate,0,10)}</td>
					<td>${vo.todayCnt}</td>
					<td>
						<c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if> 
						<c:if test="${vo.userDel != 'OK'}">${active}</c:if>
						<c:if test="${vo.deleteDiff >= 30}"><br/>
							(<a href="javascript:memberDeleteOk(${vo.idx})">30일경과</a>)
						</c:if>
					</td>
					<td>
						<form name="levelForm">
							<select name="level" onchange="levelChange(this)">
								<option value="1/${vo.idx}" ${vo.level == 1 ? 'selected' : ""}>준회원</option>
								<option value="2/${vo.idx}" ${vo.level == 2 ? 'selected' : ""}>정회원</option>
								<option value="3/${vo.idx}" ${vo.level == 3 ? 'selected' : ""}>우수회원</option>
								<option value="0/${vo.idx}" ${vo.level == 0 ? 'selected' : ""}>관리자</option>
								<option value="99/${vo.idx}" ${vo.level == 99 ? 'selected' : ""}>탈퇴신청회원</option>
							</select>
						</form>
					</td>
				</tr>
			</c:if>
		</c:forEach>
		<tr><td colspan="11" class="m-0 p-0"></td></tr>
	</table>
</div>
	<div id="userDisplay">
		<c:if test="${sLevel == 0}">
			<hr/>
			<h3 class="text-center">비공개 회원 리스트</h3>
			<table class="table table-hover">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이름</th>
				<th>생일</th>
				<th>성별</th>
				<th>최종방문일</th>
				<th>오늘방문횟수</th>
				<th>활동여부</th>
				<th>현재레벨</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<c:if test="${vo.userInfor == '비공개'}">
					<tr>
						<td>${vo.idx}</td>
						<td>${vo.mid}</td>
						<td>${vo.nickName}</td>
						<td>${vo.name}</td>
						<td>${fn:substring(vo.birthday,0,10)}</td>
						<td>${vo.gender}</td>
						<td>${fn:substring(vo.lastDate,0,10)}</td>
						<td>${vo.todayCnt}</td>
						<td>${vo.userDel}</td>
						<td>${vo.level}</td>
					</tr>
				</c:if>
			</c:forEach>
			<tr><td colspan="11" class="m-0 p-0"></td></tr>
			</table>
		</c:if>
	</div>
</div>
<p><br/></p>
</body>
</html>