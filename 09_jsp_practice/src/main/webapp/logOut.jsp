<%@ page pageEncoding="UTF-8"%>
<!-- logOut.jsp -->

<%
	// 인증된 사용자 계정 정보 처리 삭제 - session.loginMember 속성
	// 		removeAttribute - 특정 속성만 삭제 
	session.removeAttribute("loginMember");
	// session 객체 무효화
	session.invalidate();
	
	// 로그아웃 요청 처리시 cookie 정보도 삭제
	Cookie cookie = new Cookie("rememberMe","");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	
%>
	<script>
		alert('로그아웃 처리 완료');
		location.href="index.jsp";
	</script>




