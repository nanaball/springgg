<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>

	<h3><a href="request_test/requestTest.jsp">request method 확인</a></h3>
	<hr/>
	<!-- 
		속성 영역 객체 
		pageContext		<		request		<		session		<		application		
		 하나의 jsp page			하나의 요청에 대한 응답	  브라우저가 종료 			  서버 종료 	
	-->
	<a href = "attrForm.jsp">속성- 영역 객체 테스트</a>
	<hr/>
	<!-- 어플리케이션 종료해야 정보 삭제 / 서버 완전 종료  -->
	<h3>application id : <%=application.getAttribute("appId") %></h3>
	<!-- 요청이 들어왓을떄 생성 후 삭제  -->
	<h3>pageContext id : <%=pageContext.getAttribute("pageId") %></h3>
	<!-- 요청처리가 완료되면 응답 후 사라짐 -->
	<h3>request email : <%=request.getAttribute("requestEmail") %></h3>
	<!-- 브라우저가 종료되면 정보 삭제 -->
	<h3>session email : <%=session.getAttribute("sessionEmail") %></h3>
	
</body>
</html>