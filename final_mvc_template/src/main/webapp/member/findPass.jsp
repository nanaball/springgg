<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- findPass -->
<%@ include file = "/common/header.jsp" %>

<!-- 
	비밀번호 찾기 -> findPass.mc -> email, 이름 -> 랜덤코드와 함께 메일 발송 
		-> 비밀번호 변경 페이지 -> 새 비밀번호 -> 비밀번호 변경 요청처리
 -->
<section>
	<form action="findPass.mc" method="POST">
		<table>
			<tr>
				<th colspan="2">
					<h1>비밀번호 찾기</h1>
				</th>
			</tr>
			<tr>
				<th colspan="2">
					<h3>회원 가입 시 등록한 아이디(이메일)과 이름을 입력해주세요</h3>
				</th>
			</tr>
			<tr>
				<td>아이디(이메일)</td>
				<td>
					<input type="email" name="id" required />
				</td>
			</tr>
			<tr>
				<td>이름</td>
				<td>
					<input type="text" name="name" required />
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="확인"/>
				</th>
			</tr>
		</table>
	</form>
</section>

<%@ include file = "/common/footer.jsp" %>