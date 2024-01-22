<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
	<%@ include file = "check.jsp" %>
	<h1>Main Index</h1>
	<a href="addCookie.jsp">쿠키 추가</a>
	<a href="removeCookie.jsp">쿠키 삭제</a>
	<a href="addSession.jsp">session 값 추가</a>
	<a href="checkSession.jsp">session 속성 확인</a>
	<!-- 
		속성 영역 객체
		pageContext      <      request      <      session     <      application
		하나의 jsp page    	하나의 요청에 대한 응답	   브라우저가 종료            서버 종료	
	 -->
	 <%
	 	// pageContext 각 영역 객체에서 범위가 넓은 영역 객체 정보 호출
	 	// ServletRequest == request객체가 구현해야할 기능을 정의한 interface
	 	ServletRequest req = pageContext.getRequest();
	 	HttpSession ses = pageContext.getSession();
	 	ServletContext app = pageContext.getServletContext();
	 	
	 	// request
	 	ses = request.getSession();
	 	app = request.getServletContext();
	 	
	 	// session
	 	app = session.getServletContext();
	 	
	 %>
</body>
</html>