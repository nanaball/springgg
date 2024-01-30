<%@page import="java.util.List"%>
<%@page import="vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	
 	String id = request.getParameter("id");

	
	
	MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
	
	Cookie[] cookies = request.getCookies();
	if(loginMember == null && cookies != null){
		for (Cookie c : cookies){
			String name = c.getName();
			String value = c.getValue();
			if(name.equals("longin")){
			//	List<MemberVO> memberList = (List<MemberVo>)application.getAttribute("memberList");
			//	int index = memberList.indexOf(new MemberVO(value));
			//	if(index >= 0){
			//		loginMember = memberList.get(index);
					session.setAttribute("loginMember", loginMember);
					break;
				}
			}
		}
//	}

%>
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
<%-- 	<%@ page import="java.sql.*" %>
	<%
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/develop_jsp";
		String username = "developer";
		String password = "12345";
		Connection conn = null;
		
		try{
			Class.forName(driver);
			System.out.println("Driver Class가 존재합ㄴㅣ다");
			conn = DriverManager.getConnection( url, username, password);
			System.out.println("DB 연결 완료 : ");
			System.out.println(conn);
		}catch(ClassNotFoundException e){
			System.out.println("Driver class를 찾을 수 없습니다.");			
		}catch(SQLException e){
			System.out.println("연결요청 정보 오류 : " +e.toString());
		}finally{
			if(conn!= null){
				conn.close();
			}
		}	
	%>  --%>


	<header>
		<div>
			<ul>
				<li><a href="index.jsp">home</a></li>
				<!-- 비 로그인시용자 -->
				<li><a href="login.jsp">로그인</a></li>
				<li><a href="join.jsp">회원가입</a></li>
				
				<!-- 로그인 된 사용자 -->
<				<%if(loginMember != null){ %> 
				<li><a href="info.jsp"> 
				<%=id %>
				</a>님 방가방가</li>
				<li><a href="logout.jsp">로그아웃</a></li>
				<% } else if(loginMember == null) { %> 
				<!-- 관리자 로그인일 경우 -->
				<li><a href="memberList.jsp">회원관리</a></li>
				<%} %>
			</ul>
		</div>
		<div>
			<ul>
				<li><a href="#">공지사항</a></li>
				<li><a href="#">질문과답변</a></li>
			</ul>
		</div>
	</header>