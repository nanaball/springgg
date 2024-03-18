<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user/login.jsp</title>
</head>
<body>
	<h1>Login</h1>
	<form action="${pageContext.request.contextPath}/login" method="Post">
		<input type="text" name="u_id" /><br/>
		<input type="password" name="u_pw" /><br/>
		<div>
			<label>
				<input type="checkbox" name="rememberMe" />
				Remember...Me...
			</label>
		</div>
		<input type="submit" value="로그인" />
		
		<!-- 시큐리티는 csrf라서 get이랑 post에서 token으로 받아야함  -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</body>
</html>