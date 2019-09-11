<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="include/head.jsp"%>
<style>
td {
	border: 1px solid #444444;
	background-color: #EAEAEA;
	padding: 40px;
}

.d {
	border-spacing: 20px 30px;
	text-align: center;
}

.cursor_test {
	cursor: pointer;
}
.main_img{
	/* background-image: url("/resources/img/mainpic.png"); */
	background-image: url("/resources/img/mainpic.PNG");
	width: 1200px;
	height: 700px;
	margin-left: -50px;
	margin-top: 50px;
	background-size: cover;
    background-repeat: no-repeat;
    /* border: 1px solid red; */
}
</style>
</head>
<body>
	<%@ include file="include/Header.jsp"%>
	<div class="main">
		<div class="main_menu_in"><%@ include file="include/adminMenu.jsp"%></div>
		<div class="sub">
			<div style="display: inline-flex;">
				<div class="main_img"></div>
			</div>
		</div>
	</div>
</body>
</html>
