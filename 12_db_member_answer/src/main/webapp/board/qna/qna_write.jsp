<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- qna_reply.jsp -->
<%@ include file="/common/header.jsp" %>

<section>
	<form action="qna_reply_submit.jsp" method="post">
		<table>
			<tr>
				<th colspan="2">
					<h1>답변글 작성</h1>
				</th>
			</tr>
			<tr>
				<td>작성자</td>
				<td>
					<input type="text" name="qns_name" value="<%=loginMember.getName()%>" readonly/>
				</td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td>
					<input type="text" name="qna_title" autofocus required/>
				</td>
			</tr>
			<tr>
				<td>글 내용</td>
				<td>
					<textarea name="qna_content" required cols="50" rows="10"></textarea>
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button>작성완료</button>
					<button type="reset">새로 작성</button>
				</th>
			</tr>
		</table>
	</form>
</section>
<%@ include file = "/common/footer.jsp" %>