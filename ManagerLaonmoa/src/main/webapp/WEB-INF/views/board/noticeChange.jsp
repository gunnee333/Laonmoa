<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<!-- include summernote css/js-->
<script src="/resources/summernote/summernote-bs4.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
</head>
<style>
input, textarea {
	border: none;
}

.laonmoabtn:not (:disabled ):not (.disabled ){
	cursor: pointer;
}

.laonmoabtn {
	background-color: #FF7B22;
	color: #ffffff;
	border-radius: 0;
	letter-spacing: .05rem;
	transition: .5s ease;
}

.laonmoabtn:hover {
	background-color: #ffbb8e;
	color: #ffffff;
}
</style>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<h3 class="title_top">공지사항 수정하기</h3>

			<form method="post">

				<table class="board_table">
					<tr>
						<!-- <td>제목</td> -->
						<td class="td_style2" id="list_title">
							<input class="update_input" type="text" name="title" value="${view.title}" />
						</td>
						<td class="notice_kind td_style2"><c:if test="${view.level == 3 }">
								<c:out value="자유게시판" />
							</c:if> <c:if test="${view.level == 4 }">
								<c:out value="리뷰게시판" />
							</c:if></td>
					</tr>
					<tr>
						<td colspan="2">
							<c:choose>
								<c:when test="${view.level == 3 }">
									<!-- 자유게시판 -->
									<textarea class="board_textarea" name="content">${view.content}</textarea>
								</c:when>
								<c:when test="${view.level == 4 }">
									<!-- 리뷰게시판 -->
									<textarea class="board_textarea" name="content" id="summernote" placeholder="${view.content}">${view.content}</textarea>
								</c:when>
							</c:choose>
						</td>
					</tr>
				</table>

				<div class="btn_two">
					<button type="submit" class="btn laonmoabtn submit_cancle">수정</button>
					<button type="button" class="btn laonmoabtn submit_cancle"
						onclick="goBack();">취소</button>
				</div>
			</form>


		</div>
	</div>
	<script>
		$(document).ready(function(){
			//썸머노트 띄우기
			$('#summernote').summernote({
			        height: 500,                 // set editor height
			        callbacks: {	//썸머노트는 제출전에 이벤트를 기본적으로 막아두지만 콜백을 통하여 제출전에 이벤트 사용 가능
			        onImageUpload : function(files) { //파일 보내기 이벤트
			            for(var i in files){
			            	sendFile(files[i]);
			            }
			        }
			        },
			        lang: "ko-KR" //언어 세팅
			});
		});
		
		function sendFile(file) { //파일을 아작스로 전송하여 사진을 저장한 후 이미지 링크를 리턴
			console.log("file = "+file);
		    data = new FormData();
		    data.append("uploadFile", file);
		    $.ajax({
		        data : data,
		        type : "POST",
		        url : "${ContextPath}/admin/imageupload",
		        cache : false,
		        contentType : false,
		        enctype: 'multipart/form-data',
		        processData : false,
		        success : function(data) {
		        	if(data == "noimage"){
		        		alert("이미지 파일만 업로드 가능합니다.");
		        	}
		        	else{
		        	$("#summernote").summernote('insertImage',data);
		        	}
		        },
		        error : function(data){
		        	alert("실패"+data);
		        }
		    });
		}
		
		function goBack() {
			window.history.back();
		}
	</script>
</body>
</html>