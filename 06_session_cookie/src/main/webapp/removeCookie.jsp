<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>removeCookie.jsp</title>
</head>
<body>
	<h1>REMOVE COOKIE</h1>
	<%
		// cookie 정보는 사용자 컴퓨터의 브라우저 정보로 물리적으로 존재하기 때문에 임의로 삭제 할 수 없음
		// 음수는 무한대 
		response.addHeader("Set-Cookie","id=; Max-Age=0; path=/");
	
		Cookie cookie = new Cookie("PM_NAME","");
		// path 지정하지 않으면 contextPath
		// path가 틀리면 서로 다른 cookie로 인식
		cookie.setPath("/");
		response.addCookie(cookie);
	%>
	<a href="index.jsp">메인으로 </a>
</body>
</html>