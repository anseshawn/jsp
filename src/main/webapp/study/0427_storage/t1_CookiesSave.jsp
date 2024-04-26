<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesSave.jsp -->
<%
	String mid = "hkd1234";
	Cookie cookieMid = new Cookie("cMid", mid); // 쿠키만들기 (변수명,값)
	cookieMid.setMaxAge(60*60*24);	// 쿠키의 만료시간(초) : 1일 = 60 * 60 *24 = ?
	response.addCookie(cookieMid); // 쿠키 추가
			
	String pwd = "1234";
	Cookie cookiePwd = new Cookie("cPwd", pwd); // 쿠키만들기 (변수명,값)
	cookieMid.setMaxAge(60*60*24);	// 쿠키의 만료시간(초) : 1일 = 60 * 60 *24 = ?
	response.addCookie(cookiePwd); // 쿠키 추가
	
	String tel = "010-1234-5678";
	Cookie cookieTel = new Cookie("cTel", tel); 
	cookieMid.setMaxAge(60*60*24);	
	response.addCookie(cookieTel);
%>
<script>
	alert("쿠키가 생성/저장 되었습니다.");
	location.href = "t1_Cookies.jsp";
</script>