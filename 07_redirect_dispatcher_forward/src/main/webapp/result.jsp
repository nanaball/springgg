<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>result.jsp</title>
</head>
<body>
	<h1>result.jsp</h1>
	
	<!-- 정보 유지 영역이 같으나 request가 다른건 forward때문 -->
	<h3>pageContext : <%=pageContext.getAttribute("index") %></h3>
	<h3>request : <%=request.getAttribute("index") %></h3>
	
	<a href="redirect?id=chlrlrms">response send redirect</a><br/>
	<hr/>
	<a href="forward?id=hap0p9y">dispatcher forward</a>
	
</body>
</html>