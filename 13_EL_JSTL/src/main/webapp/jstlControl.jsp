<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- jstlControl.jsp -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>Core Tag Control Condition</h3>
	
	
	<core:set var = "myCar" value="maserati"/>
	<!-- if/ else -->
	<core:if test="${myCar eq 'GV80'}">
		내차는 GV80
	</core:if>
	<core:if test="${myCar ne 'GV80'}">
		내차는 GV80이 아닙니다
	</core:if>
	<hr/>
	
	
	<core:set var="score" value="95"/>
	<!-- 여러 조건을 비교 -->
	<core:choose>
		<core:when test="${score >= 90 }">
			<h3>A학점</h3>
		</core:when>	
		<core:when test="${score >= 80 }">
			<h3>B학점</h3>
		</core:when>
		<core:when test="${score >= 70 }">
			<h3>C학점</h3>
		</core:when>
		<core:otherwise>
			<h6>조건에 만족하는 분기를 찾지 못함</h6>
			<h6>F학점</h6>
		</core:otherwise>
	</core:choose>
	<hr/>
	
	
	<!-- 반복문 / 증가만 가능, 감소하면 오류 -->
	<core:forEach var="i" begin = "1" end = "100" step="2">
		${i} &nbsp; &nbsp;
	</core:forEach>
	
	<%
		int [] nums = {10,9,8,7,6,5,4,3,2,1};
		request.setAttribute("nums", nums);
	%>
	<hr/>
	<h2>forEach items</h2>
	<core:forEach var="number" items="${nums}">
		${number} &nbsp; &nbsp;
	</core:forEach>
	
	<br/>
	<core:set var="datas" value="최기근, 김유신, 원빈, 아인슈타인, 테슬라, 페이커" />
	
	<core:forTokens var="name" items="${datas}" delims=",">
		${name} <br/>
	</core:forTokens>
	<%
		List<String> dogList = new ArrayList<>();
		request.setAttribute("dogList", dogList);
	%>
	${dogList.add("리트리버")}<br/>
	${dogList.add("시베리안 허스키")}<br/>
	${dogList.add("치와와")}<br/>
	${dogList.add("푸들")}<br/>
	${dogList.add("웰시코기")}<br/>
	${dogList.add("말티즈")}<br/>
	${dogList.add("사모예드")}<br/>
	${dogList.add("도베르만")}<br/>
	${dogList.add("시고르자브르종")}<br/>
	
	<core:choose>
		<core:when test="${!empty dogList}">
			<core:forEach var="dog" items="${dogList}">
				${dog} &nbsp;
				<core:if test="${dog eq '사모예드'}">
					-> 우리집 강아지 &nbsp;
				</core:if>
				<br/>
			</core:forEach>
		</core:when>
		<core:otherwise>
			<h4>목록이 존재하지 않습니다.</h4>
		</core:otherwise>
	</core:choose>
</body>
</html>