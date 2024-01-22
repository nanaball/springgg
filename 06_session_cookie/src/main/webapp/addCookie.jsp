<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file = "check.jsp" %>
	<hr></hr>
	<h1>ADD COOKIE</h1>
	<%
		// 쿠키 등록 1번 방법
		// Set-Cookie
		// JSESSIONID=95A640056B2B9DF6399D3DF20A4DDDA4; Path=/06_session_cookie;
		// 60 * 60 * 24 * 30 == 초단위
		response.addHeader("Set-Cookie","id=id001; Max-Age=2592000; path=/");
		
		// 2번방법
 		Cookie cookie = new Cookie("PM_NAME","최기근");
		cookie.setMaxAge(25920000);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		%>
	<a href = "index.jsp">메인으로 </a>
</body>
</html>