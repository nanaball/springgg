<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/common.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		 <ul>
		 	<% String path = request.getContextPath(); %>
		 	<li><a href="<%=path %>">HOME</a></li>
			<!-- 로그인 상태 -->
			<li><a href="<%=path %>/info.jsp"> <!-- 회원이름 --> </a>님 반갑습니다.</li>
			<li><a href="<%=path %>/logOut.jsp">로그아웃</a></li>
			
			<!-- 비 로그인 상태 -->
		 	<li><a href="<%=path %>/login.jsp">로그인</a></li>
		 	<li><a href="<%=path %>/join.jsp">회원가입</a></li>
		 </ul>
 </header>
 
 
 
 
 
 