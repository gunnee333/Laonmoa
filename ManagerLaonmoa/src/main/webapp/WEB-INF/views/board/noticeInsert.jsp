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
		공지사항 작성

		<section class="content container-fluid">

			<form method="post" action="${ContextPath }/admin/board/noticeInsert">
			<input type="hidden" name="id" value="<%=session.getAttribute("id")%>" readonly="readonly">
				<div>
					<label>제목</label> <input type="text" name="title"/>
				</div>

				<div>
					<label>작성자</label>	<input type="text" name="id" value="<%=session.getAttribute("id") %>" readonly="readonly">
				</div>

				<div>
					<label for="board">게시판</label> 
					<!-- <input type="text" name="level" /> 리뷰게시판 4 /자유게시판3 -->
					<select>
						<option value="4">리뷰게시판</option>
						<option value="3">자유게시판</option>
					</select>
				</div>

				<div>
					<label>내용</label>
					<textarea rows="5" cols="50" name="content"></textarea>
				</div>

				<div>
					<button type="submit">작성</button>
				</div>
				<a href="${ContextPath }/admin/board/noticeList">목록으로 돌아가기</a>
			</form>

		</section>


	</div>


</div>
</body>
</html>