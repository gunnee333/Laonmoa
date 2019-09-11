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
<link href="../../resources/css/border_css.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="../include/Header.jsp"%>

	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<h3 class="title_h3">자유게시글 수정하기</h3>
			<a href="${ContextPath }/admin/board/freeBoardList?del=-1&num=1"
				class="btn laonmoabtn btn_list">목록</a>
			<form method="post">

				<table class="board_table">
					<input type="hidden" name="bnum" value="${view.bnum}">
					<tr>
						<td><input class="title_style" type="text" name="title" value="${view.title}"
							 /></td>
					</tr>
					<tr style="margin-top: 10px;">
						<td><textarea class="board_textarea" name="content">${view.content}</textarea></td>
					</tr>

				</table>
				<div class="btn_two">
					<button type="submit" class="btn laonmoabtn submit_cancle">수정</button>
					<button type="button" class="btn laonmoabtn submit_cancle" onclick="goBack();">취소</button>
				</div>
			</form>

		</div>
	</div>
<script>
	function goBack() {
	  window.history.back();
	}
</script>
</body>
</html>