<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
</head>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Carousel Star /-->
	<div class="mainbody"><div class="intro intro-carousel"><div class="carousel-item-a intro-item bg-image">
	<div class="intro-content display-table"><div class="table-cell"><div class="container">
	<div class="row"><div class="col-lg-8"><div class="intro-body">
		<h1 class="intro-title mb-4">
			<div class="logo">
				<img src="http://hoohee0331.cdn3.cafe24.com/img/LOGOALL.jpg" width="300px"height="300px">
			</div>
			<span class="color" style="color: rgb(255, 123, 34);">404
			</span> <span class="color" style="color: rgb(255, 123, 34);">ERROR
			</span> <br>
			<h5>페이지를 찾을 수 없습니다.</h5>
			<p class="intro-subtitle intro-price"></p>
		</h1>
	</div></div></div></div></div></div></div></div></div>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>

</body>
</html>
