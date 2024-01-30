<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link href="css/header.css" rel="stylesheet" type="text/css" />
<link href="css/footer.css" rel="stylesheet" type="text/css" />
<link href="css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<header>
		<div>
			<ul>
				<li><a href="index.jsp">home</a></li>
				<!-- 비 로그인시용자 -->
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>

				<!-- 로그인 된 사용자 -->
				<li><a href="info.jsp"> <!-- 회원이름 -->
				</a>님 방가방가</li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<!-- 관리자 로그인일 경우 -->
				<li><a href="memberList.jsp">회원관리</a></li>
			</ul>
		</div>
		<div>
			<ul>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">질문과답변</a></li>
			</ul>
		</div>
	</header>