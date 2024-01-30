<%@page import="vo.MemberVO"%>
<%@page import="util.JDBCUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!-- 로그인 요청 처리 페이지 - loginCheck.jsp -->


<%
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");


	String resultMsg = "";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

		
	try{
		conn = JDBCUtil.getConnection();
		
		// id pass 확인
		String checkLogin = "SELECT * FROM test_member where id=? and pass=?";
		pstmt = conn.prepareStatement(checkLogin);
		pstmt.setString(1,id);
		pstmt.setString(2, pass);
		rs = pstmt.executeQuery();
		
		
		if(rs.next()){
			int count = rs.getInt(1);
			if(count > 0){
				// 로그인 성공
%>

				<script>
					alert('로그인 성공');
					location.href="index.jsp";

				</script>
				
<%
				String login = request.getParameter("login");
				System.out.println("login : " + login);
				
				// 로그인 정보 저장 
				if(login != null){
					Cookie cookie = new Cookie("id", id);
					cookie.setMaxAge(60*60*24*15);
					response.addCookie(cookie);
				}
			}else {
%>
				<!--  로그인 실패 -->
				<script>
					alert('아이디와 비밀번호가 다릅니다.');
					history.go(-1);
				</script>
<%			
			} // end else 
			
		} // end if
	}catch(Exception e){
		resultMsg = "로그인 실패 "+e.toString();
	}finally{
		JDBCUtil.close(pstmt,conn);
	}
	
	String path = request.getContextPath();
%>


	



