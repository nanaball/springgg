<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>attrForm.jsp</title>
</head>
<body>
				<!-- /implict/attrForm.jsp -->
	<a href = "<%=request.getContextPath() %>/index.jsp">메인으로</a><br/>

	<form action="attrTest1.jsp" method="POST">
		아이디 : <input type = "text" name ="id" required />
		<button>확인</button>
	</form>
</body>
</html>