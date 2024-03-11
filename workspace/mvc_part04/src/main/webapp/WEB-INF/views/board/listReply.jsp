<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<h1>Board List</h1>
<!-- qnaList == 질문과 답변 게시글 목록 -->
<table border=1>
	<tr>
		<th>BNO</th>
		<th>TITLE</th>
		<th>WRITER</th>
		<th>REGDATE</th>
		<th>VIEWCNO</th>
	</tr>
	<c:choose>
		<c:when test="${!empty qnaList}">
			<c:forEach var="board" items="${qnaList}">
				<!-- empty : 일반객체면 NULL 확인 + 리스트면 내부에 데이터가 존재하는지도 확인 -->
				<c:choose>
					<c:when test="${board.showboard == 'y'}">
						<tr>
							<td>${board.bno}</td>
							<td><a href="${path}/board/readPage?bno=${board.bno}"> <!-- 답변글일 경우 -->
									<c:if test="${board.depth != 0}">
										<c:forEach var="i" begin="1" end="${board.depth}">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach>
								ㄴ>
							</c:if> 
							${board.title} 
							<c:if test="${!empty board.files}">
								[${board.files.size()}]
							</c:if>
							<c:if test="${board.regdate ne board.updatedate}">
								- [수정된 게시글]
							</c:if>
							</a>
							</td>
							<td>${board.writer}</td>
							<td>
								<f:formatDate pattern="yyyy-MM-dd HH:mm" value="${board.regdate}" /></td>
							<td>${board.viewcnt}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr>
							<td></td>
							<td>삭제된 게시물 입니다.</td>
							<td></td>
							<td>
								<!-- 게시글 삭제요청 처리 시간 --> 
								<f:formatDate value="${board.updatedate}" pattern="yyyy-MM-dd HH:mm" />
							</td>
							<td></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<tr>
				<td colspan="5">등록된 게시글이 없습니다.</td>
			</tr>
		</c:otherwise>
	</c:choose>
</table>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>