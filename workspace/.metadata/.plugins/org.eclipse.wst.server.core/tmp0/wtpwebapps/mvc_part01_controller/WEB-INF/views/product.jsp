<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>product.jsp</h2>
	<h3>product name : ${product.name }</h2>
	<h3>product price : ${product.price }</h2>
	
	<!-- 첫글자가 소문자면 변수로 생각함 -->
	<h3>${productVO }</h3>
	<h3>${productVO.name }</h3>
	<h3>${productVO.price }</h3>
</body>
</html>