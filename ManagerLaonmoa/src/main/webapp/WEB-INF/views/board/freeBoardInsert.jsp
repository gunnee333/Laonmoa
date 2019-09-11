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
</style>
</head>
<body>
	<%@ include file="../include/Header.jsp"%>

	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">

			<h3 class="title_h3">자유게시글 작성</h3>
			<div style="margin: 0 auto;">
				<a href="${ContextPath }/admin/board/freeBoardList?del=0&num=1"
					class="btn laonmoabtn btn_list">목록</a>
				<!-- Main content -->
				<section class="content container-fluid">


					<form method="post" action="${ContextPath }/admin/board/freeBoardInsert"
						name="insertfrm">
						<input type="hidden" name="id"
							value="<%=session.getAttribute("id")%>">
						<table class="board_table">
							<tr>
								<td><input class="title_style" type="text" name="title"
									placeholder="글 제목" /></td>
							</tr>
							<tr>
								<td><textarea class="board_textarea" placeholder="글 내용"
										name="content"></textarea></td>
							</tr>
						</table>
						<div class="btn_two">
							<button type="button" onclick="insert();"
								class="btn laonmoabtn submit_cancle">작성</button>
							<button type="button" class="btn laonmoabtn submit_cancle"
								onclick="goBack();">취소</button>
						</div>
					</form>

				</section>
			</div>
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
		
		//취소 버튼
		function goBack() {
			window.history.back();
		}
	</script>
</body>
</html>