<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home.jsp</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	#comments li{
		list-style:none;
		padding:10px;
		border:1px solid #ccc;
		height:150px;
		margin:5px 0;
	}
	
	#modDiv{
		border:1px solid black;
		background-color:#BBE309;
		padding:10px;
		display:none;
	}
	
	#comments span{
		border:1px solid black;
		padding:5px 10px;
	}
	
	#comments span:hover{
		border:1px solid gray;
		color:gray;
		cursor:pointer;
	}
</style>
</head>
<body>
	
	<!-- 댓글 수정 화면 -->
	<div id="modDiv">
		<!-- 수정할 댓글 번호 출력 -->
		<div id="modCno"></div>
		<div>
			<!-- 댓글 내용 수정 -->
			댓글 내용 - <input type = "text" id = "modText" />
 		</div>
 		<div>
			<!-- 댓글 작성자 수정 -->
			댓글 작성자 - <input type = "text" id = "modAuth" />
 		</div>
 		<div>
 			<button id = "modBtn">MODIFY</button>
			<button id = "delBtn">DELETE</button>
 		</div>
	</div>


	<h2>AJAX - REST COMMENT TEST</h2>
	<h3>2번 게시글 댓글 정보</h3>
	<div>
		<div>
			comment author : <input type="text" id="cAuth" />
		</div>
		<div>
			comment content : <input type="text" id="cText" />
		</div>
		<button id="addBtn">ADD COMMENT</button>
	</div>
	<div>
		<!-- 댓글 목록 -->
		<ul id="comments"></ul>
	</div>
	
	<script>
		var bno = 2;
		
		var page = 1;
		
		var perPageNum = 5;
		
		listPage(page);
		
		function listPage(page){
			$("#modDiv").css("display", "none");
			$("body").prepend($("modDiv"));
			let url = "comment/"+bno+"/"+page+"/"+perPageNum;
			$.getJSON(url, function(data){
				// Map == data : {list : List<CommnetVO>, pm : PageMaker}
				console.log(data);
				printPage(data);
			});
		}
		
		function printPage(data){
			let list = data.list;
			let pm = data.pm;
			console.log(list);
			console.log(pm);
			
			let str = "";
			for(let i = 0; i < list.length; i++){
				let comment = list [i];
				let cno = list[i].cno;
				let content = list[i].content;
				let auth = list[i].author;
				console.log(comment, cno, content, auth);
				str += `<li>\${cno}-\${auth} - <span onclick='modifyPage(this, "\${cno}","\${content}","\${auth}");'>MODIFY</span><br/><hr/>\${content}</li>`;
			}
			
			// 새로운 댓글 작성 시 위치 조정
			if(page == 1){
				$("#comments").html(str);
			}else{
				$("#comments").append(str);
			}
			
			// 스크롤 시 더버기 버튼 삭제
			// 댓글 더보기 만들기
		/* 	if(page < pm.maxPage){
				let str = `<button onclick='nextPage(this);' style='width:100%; text-align:center; padding:10px; background-color:#bbe309'>더보기</button>`;
				$("#comments").append(str);
			} */
		} 	// 페이징 처리된 댓글 목록 출력
		
		
		// 더보기 버튼 이벤트 
		function nextPage(btn){
			$(btn).remove();
			page++;
			listPage(page);
		}
		
		
		// 수정 창 호출 - modify버튼 이벤트 
		function modifyPage(span, cno, content, auth){
			console.log(cno, content, auth);
			
			$("#modCno").text(cno);
			$("#modText").val(content);
			$("#modAuth").val(auth);
			
			$(span).parent().after($("#modDiv"));
			
			$("#modDiv").toggle("slow");
		}
		
		
		
		// getCommentList();
		
		// 전체 댓글 목록 호출
		function getCommentList(){
			// #modDiv를 body의 가장 앞으로 이동
			$("#modDiv").css("display","none");
			$("body").prepend($("#modDiv"));
			
			// 경로상의 고유한 데이터(자원) == path variable
			let url = "comment/"+bno+"/list";
			
			// type == get
			// dataType == json
			$.getJSON(url, function(data){
				// alert(data);
				console.log(data)
				printList(data);
			});
		}	// 전체 댓글 목록 호출
		
		
		// 서버에서 전달 받은 댓글 목록을 페이지에 출력
		function printList(list){
			// #commnets에 li 추가
			let str = "";
			// list[commnetVO, commentVO...]
			for(var i = 0; i < list.length; i++){
				console.log("===================================");
				console.log(list[i].cno);
				console.log(list[i].author);
				console.log(list[i].content);
				console.log("===================================");
				str += `<li>
							\${list[i].cno} - \${list[i].author}
							- <button data-cno='\${list[i].cno}' 
										data-author='\${list[i].author}'
										data-content='\${list[i].content}'>MODIFY</button>
							<br/><hr/>
							\${list[i].content}
						</li>`;
			}
			$("#comments").html(str);
/* 			
  				$(list).each(function(){
				console.log(this);	
			});
 */		
		}		
		
		
		
		// 댓글 삽입 요청처리
		$("#addBtn").click(function(){
			
			let auth = $("#cAuth").val();
			let text = $("#cText").val();
			
			$.ajax({
				type : "post",
				url : "comment",
				data : {
					bno : bno, 
					content : text,
					author : auth
				},
				dataType : "text",
				success : function(result){
					alert(result);
					$("#cAuth").val("");
					$("#cText").val("");
					// getCommentList();
					page = 1;
					listPage(page);
				},
				error : function(res){
					console.log(res);
					if(res.status === 400){
						alert("잘못된 데이터로 요청 ~(ㅇㅅㅇ~)");
						alert(res.responseText);
					}else if(res.status === 404){
						alert("요청 경로를 확인하세요 (~ㅇㅅㅇ)~");
					}
				}
			});		
		});	// 댓글 추가 완료
		
		
		
		// 댓글 수정-삭제 화면 출력
		$("#comments").on("click","li button",function(){
			// this == event가 발생한 요소
			console.log(this);
			let cno = $(this).attr("data-cno");
			let auth = $(this).attr("data-author");
			let content = $(this).attr("data-content");
			
			// 수정할 댓글 창에서 이전 댓글 내용 가져오기
			$("#modCno").text(cno);
			$("#modText").val(content);
			$("#modAuth").val(auth);

			// 수정할 댓글의 버튼 선택시 그 밑에 댓글 수정창 만들기
			// 클릭된 button의 부모요소 == li
			$(this).parent().after($("#modDiv"));
			
// 			$("#modDiv").slideDown("slow");
//			$("#modDiv").slideUp("slow");
 
 			$("#modDiv").toggle("slow");
 		});
		
		
		// 댓글 수정 요청 처리 
		$("#modBtn").click(function(){
			let cno = $("#modCno").text();
			let content = $("#modText").val();
			let auth = $("#modAuth").val();
			console.log(cno, content, auth);
			
			$.ajax({
				type : "PATCH", // put은 전체 데이터 수정, PATCH는 부분 데이터 수정, 
						// put, patch, delete는 jsone 형식으로 전달
				// url : "comment", 	PUT 방식일때
				url : "comment/"+cno,
				headers : {
					"Content-Type" : "application/json" 
				},
				data : JSON.stringify({ 	// json 형식으로 전달하기에 형식 맞춰줌
					// cno : cno,	// PUT 방식 일때 
					author : auth,
					content : content
				}),
				dataType : "text",
				success : function(result){
					alert(result);
					// getCommentList();
					page = 1;
					listPage(page);
				},
				error : function(res){
					alert(res.responseText);					
				},
			});
		});
		
		
		
		// 댓글 삭제 요청 처리
		$("#delBtn").click(function(){
			let cno = $("#modCno").text();
			
			$.ajax({
				type : "DELETE",
				url : "comment/"+cno,
				dataType : "text",
				success : function(result){
					alert(result);
					// getCommentList();
					page = 1;
					listPage(page);
				},
				error : function(res){
					console.log(res);
				}
			});
		});
		
		// 마우스 스크롤 또는 문서의 스크롤이벤트로 처리
		$(window).scroll(function(){
			let dh = $(document).height();	// 문서 높이
			let wh = $(window).height();	// 창 높이
			let wt = $(window).scrollTop();
			
			console.log(dh , wh, wt);

			if((wh + wt) >= (dh)){
				console.log("조건에 만족");
				page++;
				listPage(page);
			}
		});
		
	</script>
</body>
</html>