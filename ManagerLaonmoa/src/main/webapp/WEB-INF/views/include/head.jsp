<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<meta charset="UTF-8">
<title>라온모아</title>
<!-- 메인 포지션 및 스타일적용 -->
<%@ include file="/resources/css/adminmain.css"%>
<!-- Favicons -->
<link href="/resources/img/favicon.png" rel="icon">
<link href="/resources/img/apple-touch-icon.png" rel="apple-touch-icon">
<!-- SummerNote -->
<link href="/resources/summernote/summernote-bs4.css" rel="stylesheet">
<!-- 부트스트랩적용 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/style2.css">
<link href="/resources/css/board_css.css" rel="stylesheet"
	type="text/css">
<%@ include file="/resources/css/dropdown.css"%>
<style>
* {
	color: black;
	font-size: 17px;
	text-decoration: none;
}
</style>