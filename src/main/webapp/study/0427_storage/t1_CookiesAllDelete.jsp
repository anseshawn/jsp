<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesAllDelete.jsp -->
<%
	Cookie[] cookies = request.getCookies(); // 모두 지우려면 배열에 담아서 확인
	
	for(int i=0; i<cookies.length; i++){
		cookies[i].setMaxAge(0); // 쿠키의 만료시간 조절로 삭제
		response.addCookie(cookies[i]);
	}
%>
<script>
	alert("모든 쿠키가 삭제 되었습니다.");
	location.href = "t1_Cookies.jsp";
</script>