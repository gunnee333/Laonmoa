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
#modal {
	display: none;
	background-color: #FFFFFF;
	position: absolute;
	top: 300px;
	left: 200px;
	padding: 10px;
	border: 2px solid #FF7B22;
	border-radius: 0.5rem;
	z-Index: 9999;
	text-align: center;
	width: 250px;
	height: 117px;
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

.btn_margin {
	margin-left: 800px;
	margin-top: 10px;
}

.btn_board {
	margin-bottom: 10px;
}

.write {
	margin-left: 850px;
}
</style>
<body>
	<%@ include file="../include/Header.jsp"%>
	<!-- 전송시 입력값 체크하는 js -->
	<script src="/resources/js/submitCheck.js"></script>

	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<h3 class="title_h3">리뷰게시글 글작성</h3>
			<a href="${ContextPath }/admin/board/reviewBoardList?del=-1&num=1"
				class="btn laonmoabtn review_list">목록</a>
			<!-- Main content -->
			<section class="content container-fluid">

				<form method="post" action="${ContextPath }/admin/board/reviewBoardInsert"
					name="insertfrm">
					<input type="hidden" name="id" value="<%=session.getAttribute("id")%>" readonly="readonly">
					<table>
						<tr>
							<td><input type="text" name="title" placeholder="리뷰 제목" class="review_title" autocomplete="off" /></td>
						</tr>
						<tr>
							<td><input type="hidden" name="id"
								value="<%=session.getAttribute("id")%>" readonly="readonly"
								style="width: 923px;"></td>
						</tr>
						<tr>
							<td><textarea name="content" id="summernote"></textarea></td>
						</tr>
					</table>
					<button type="button" onclick="insert();"
						class="btn laonmoabtn submit_btn">작성</button>
				</form>

			</section>

		</div>
	</div>
	<!-- 모달창 -->
	<div id="modal">
		<h5>
			<span name="modalspan"></span>
		</h5>
		<br>
		<button class="btn laonmoabtn" onclick="modalclose();">닫기</button>
	</div>
	<!-- 모달 end -->

	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js"></script>
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
	
		function insert() {
			var title = $('input[name=title]').val();
			var content = $('textarea[name=content]').val();

			if (title == "" || title == null || title == "null") {
				$('span[name=modalspan]').text("제목을 입력해주세요.").show();
				modalopen();
				return false;
			}
			if (content == "" || content == null || content == "null") {
				$('span[name=modalspan]').text("내용을 입력해주세요.").show();
				modalopen();
				return false;
			}
			document.insertfrm.submit();
		}

		//모달창 인스턴트 생성
		var myModal = new newModal({
			id : "modal" // 모달창 아이디 지정
		});

		// 모달 창 열기
		function modalopen() {
			$('input[name=password]').val("");
			myModal.show();
		}

		// 모달 창 닫기
		function modalclose() {
			myModal.hide();
		}

		//축제 검색 창 띄우기
	    $("#event").add("#eventname").add("#search").on("click",function(){
	    	 window.open("${ContextPath}/admin/board/searchCulture","_blank",
			"width=580, height=580, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no"); 
	    	
	    });    
		$("input[name=title]").click(function(){
	    	$(this).blur(function(){
	    		if($(this).val() != "" || $(this).val() != null){
	    			$("#notitle").hide();	
	    		}
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
		
		function send(){
			if(checkit()){
				document.insert.submit();
			}
		}
		
		function checkit(){
			var status = true;
			if($("#eventname").val() == "" || $("#eventname").val() == null ){
				$("#nofno").show();
				status = false;
				return status;
			}
			else{
				$("#nofno").hide();
			}
			if($("input[name=title]").val() == "" || $("input[name=title]").val() == null){
				$("#notitle").show();
				status = false;
				return status;
			}
			else{
				$("#notitle").hide();
			}
			return status;
		}
	</script>
</body>
</html>