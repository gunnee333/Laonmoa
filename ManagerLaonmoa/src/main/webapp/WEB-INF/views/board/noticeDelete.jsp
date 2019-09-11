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
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
<!-- 전송시 입력값 체크하는 js -->
<script src="/resources/js/submitCheck.js"></script>
<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub">
		공지사항 삭제
		<form method="post">
				<input type="hidden" name="bnum" value="${view.bnum}" />
				<div>
					<label>제목</label> <input type="text" name="title"
						value="${view.title}" readonly="readonly" />
				</div>
				<div>
					정말 삭제?
				</div>
				<div>
					<button type="submit">삭제</button>
					<a href="${ContextPath }/admin/board/noticeDetail?bnum=${view.bnum}">취소</a>
				</div>
			</form>
	</div>
</div>
</body>
</html>