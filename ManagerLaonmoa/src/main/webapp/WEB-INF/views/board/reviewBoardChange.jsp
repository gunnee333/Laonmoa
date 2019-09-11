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
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<h3 class="title_h3">리뷰게시글 수정</h3>
			<a href="${ContextPath }/admin/board/reviewBoardList?del=-1&num=1"
				class="btn laonmoabtn btn_list">목록</a>
			<form method="post">
				<input type="hidden" name="bnum" value="${view.bnum}">
				<table class="board_table">
					<tr>
						<td><input class="title_style" type="text" name="fname"	value="[${view.fname}]"  readonly="readonly"/></td>
					</tr>
					<tr>
						<td><input class="title_style" type="text" name="title"	value="${view.title}" /></td>
					</tr>
					<tr>
						<td><textarea class="board_textarea" name="content" id="summernote" placeholder="${view.content}">${view.content}</textarea></td>
					</tr>
				</table>
				<div>
					<button type="submit" class="btn laonmoabtn board_submit">수정</button>
				</div>
			</form>
		
		</div>
	</div>
</body>
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
	        url : "${ContextPath }/admin/imageupload",
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
</script>
</html>