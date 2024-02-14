<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="testJSON">testJSON</a> <br/><Br/>
	<a href="sampleList">sampleList</a>
	<hr/>
	
<!-- 	<form action = "sample"  method = "get" enctype="application/x-www-form-urlencoded"> -->
	<form action = "sample"  method = "post" enctype="application/x-www-form-urlencoded">
		<input type="text" name = "name" /> <br/>
		<input type="number" name = "age" /> <br/>
		<button>전송</button>
 	</form>
</body>
</html>