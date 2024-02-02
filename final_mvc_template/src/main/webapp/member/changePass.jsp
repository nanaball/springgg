<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!-- changePass -->
<%@ include file = "/common/header.jsp" %>

<!-- 
	비밀번호 찾기 -> findPass.mc -> email, 이름 -> 랜덤코드와 함께 메일 발송 
		-> 비밀번호 변경 페이지 -> 새 비밀번호 -> 비밀번호 변경 요청처리
 -->
<section>
	<form action="changePass.mc" method="POST">
		<input type="hidden" name = "id" value="${id}"/>
		<table>
			<tr>
				<th colspan="2">
					<h1>비밀번호 변경</h1>
				</th>
			</tr>
			<tr>
				<th colspan="2">
					<h3>새롭게 사용하실 비밀번호를 입력해주세요 입력해주세요</h3>
				</th>
			</tr>
			<tr>
				<td>새 비밀번호 </td>
				<td>
					<input type="password" name="pass" required />
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<input type="submit" value="변경하러 가기"/>
				</th>
			</tr>
		</table>
	</form>
</section>

<%@ include file = "/common/footer.jsp" %>