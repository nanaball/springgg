<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>uploadAjax</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style>
	.fileDrop{
		width : 100%;
		height:200px;
		background-color:#ccc;
		border:1px solid black;
	}
</style>
</head>
<body>
	<h2>File drag &amp; drop</h2>

	<!-- upload할 파일을 drop할 박스 -->
	<div class="fileDrop"></div>
	
	<!-- upload된 파일 목록 출력 -->
	<div id="uploadedList"></div>
	
	
	<script>
		// drag drop 이벤트 시 파일을 인식하려는 브라우저의 기본 이벤트 무시
		$(".fileDrop").on("dragenter dragover", function(e){
			// 발생한 이벤트 객체를 매개변수로 전달
			e.preventDefault(); // event 객체의 기본 이벤트 무시
		});
		
		$(".fileDrop").on("drop",function(e){
			e.preventDefault();
			
			// 발생한 drag drop 이벤트 객체에서 사용자가 드랍한 파일 정보를 읽어옴
			let files = e.originalEvent.dataTransfer.files;
			console.log(files);
			
			let formData = new FormData();
			for(let i = 0; i < files.length; i++){
				let file = files[i];
				let maxSize = 10485760;	// 10MB
				if(maxSize < file.size){
					alert("업로드 할 수 없는 크기의 파일입니다.");
					return false;
				}
				formData.append("files", file);
			}
			$.ajax({
				type : "POST",
				url : "uploadFiles",
				data : formData,
				contentType: false,
				processData : false,
				dataType : "json",
				success : function(result){
					console.log(result);
					let str = "";
					for(let i = 0; i < result.length; i++){
						str += "<div>";
						if(checkImageType(result[i])){
							console.log("이미지 파일");
							str += "<div>";
							// str += "<img src='${path}/upload"+result[i]+"' />";
							str += "<img src='displayFile?fileName="+result[i]+"' />";
							str += "</div>";
							let original = result[i].replace("s_","");
							str += "<a href='displayFile?fileName="+result[i]+"' target='_blank'>";
							str += getOriginalName(result[i]);
							str += "</a>";
						}else{
							console.log("일반 파일");
							str += "<div>";
							str += "<img src='${path}/resources/img/file.png' />";
							str += "</div>";
							str += "<a href='displayFile?fileName="+result[i]+"'>";
							str += getOriginalName(result[i]);
							str += "</a>";
						}
						
						/* 파일 삭제 */
						str += "&nbsp;&nbsp;&nbsp;&nbsp;"
						str += "<span data-giguen='"+result[i]+"'>&times;</span>";	// times : x 표시
						str += "</div>";
						
						
					}	// end for
					
					$("#uploadedList").append(str);
					
				}	// end success
			});	// end ajax
		});	// end drop event
		
		// 2024/02/20/46774d01482d4d34839ba5fc9fb0477e_pu.jpg
		function getOriginalName(fileName){
			let index = fileName.lastIndexOf("_") + 1;
			// pu.jpg
			return fileName.substr(index);
		}
		
		// upload된 파일이 이미지 파일인지 확인
		function checkImageType(fileName){
			let pattern=	/jpg|jpeg|gif|png/i;
			let result = pattern.test(fileName);
			console.log(result);
//			return result;
			
  			let img = ['jpg', 'jpeg', 'png', 'gif'];
			for(let i = 0; i < img.length; i++){
				if(fileName.toLowerCase().endsWith(img[i])){	// endsWith : 해당되는 문자열로 끝이 나는지
					return true;
				}
			}
			return false; 	// 이미지 확장자가 아님   
		}
		
		// span tag click 시 file 삭제 요청처리
		$("#uploadedList").on("click","span",function(){
			// 이벤트가 발생한 span 태그요소 - 엑스 버튼 눌렀을때
			let target = $(this); 	
			// 요소의 속성 중 사용자 정의형 속성에 저장된 파일 이름 호출
			let fileName = target.attr("data-giguen");
			console.log(fileName);
			$.ajax({
				type : "DELETE",
				url : "deleteFile",
				data : fileName,
				dataType : "text",
				success : function(result){
					alert(result);
					target.parent("div").remove();
				}
			});
		});
	</script>
</body>
</html>