<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- elForm.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Expression Language(EL) - 표현언어</h1>
	
	<h3>pageContext &lt; request &lt; session &lt; application (4대 영역객체)</h3>
	<h2>
		4대 영역 객체의 속성값을 jsp page 내에서 쉽게 연산하고 읽어서 출력 할 수 있도록 구성 된 언어 
		<!-- 사칙, 삼항, 비교 연산 등 가능 -->
	</h2>
<%
	pageContext.setAttribute("scopeName", "pageContext 영역")	;
	request.setAttribute("scopeName", "request 영역")	;
	session.setAttribute("scopeName", "session 영역")	;
	application.setAttribute("scopeName", "application 영역")	;
%>
<hr/>

	page 영역 : <%= pageContext.getAttribute("scopeName") %> 	<br/>
	request 영역 : <%= request.getAttribute("scopeName") %>	<br/>
	session 영역 : <%= session.getAttribute("scopeName") %>	<br/>
	application 영역 : <%= application.getAttribute("scopeName") %>	<br/>

	<h3>EL 표현식 - \${영역객체.속성 key}</h3>
	page EL : ${pageScope.scopeName}<br/>
	request EL : ${requestScope.scopeName}<br/>
	session EL : ${sessionScope.scopeName}<br/>
	application EL : ${applicationScope.scopeName}<br/>
<hr/>	
<% pageContext.removeAttribute("scopeName"); %>
<!-- pageContext는 현재 페이지의 모든걸 삭제  -->
	session EL : ${sessionScope.scopeName}<br/>
	EL scopeName : ${scopeName}
	<br/>
<% session.setAttribute("member", "최기근"); %>
	EL member : ${member}
	<br/>
	findAttribute : <%= pageContext.findAttribute("member") %>
	<br/>
	<hr/>
	
	<form action = "elTest.jsp">
		<input type = "text" name="id" />
		<button type = "submit"> 확인 </button>
	</form>
</body>
</html>