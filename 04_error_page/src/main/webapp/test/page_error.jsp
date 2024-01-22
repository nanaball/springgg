<!-- page.error.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="../error/error.jsp" %>
    <!-- errorPage="../error/error.jsp" 쓴게 우선순위가 더 높아서 500에러가 떠도 error.jsp가 실행됨 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String s = request.getParameter("aa");
		out.println(Integer.parseInt(s));		
	%>
</body>
</html>