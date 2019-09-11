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
<link href="/resources/css/nav-tabs.css" rel="stylesheet">
<style>
.sendM {
	width: 200px;
	height: 200px;
	
	line-height: 200px;
	margin-bottom: 30px;
}
.sendM2 {
	margin:auto;
}
.sendIcon{
	margin-top:-54px;
	font-size: 18px;

}
.in_maymoa{
    display: inline-block;
    width: 100%;
    padding-top: 40px;
}

</style>
</head>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<%@ include file="mypageMenu.jsp"%>
	
	<!--/ Carousel Star /-->
	<div class="out">
		<!-- 메뉴 네비게이션 -->
		<ul class="nav nav-tabs">
			<li role="presentation"><a href="${ContextPath }/mypage/myinfo">내정보</a></li>
			<li role="presentation"><a href="${ContextPath }/mypage/myReview?pagenum=1">내가 쓴 게시글</a></li>
			<li role="presentation" class="active"><a href="${ContextPath }/mypage/mynote">쪽지보관함</a></li>
		</ul>
	</div>
	<div class="out">
		<div class="in_maymoa">
			<!-- 정보보기 -->
			<table style="width: 1000px; height: 100px;">
				<tr align="center">
					<td>
						<div class="sendM" >
							<div class="sendM2">
								<a href="${ContextPath }/mypage/noteList?pagenum=1&num=0" >
								<img src="http://hoohee0331.cdn3.cafe24.com/img/recM.png" width="50px" /> </a>
							</div>
						</div>
							<div class="sendIcon"><a href="${ContextPath }/mypage/noteList?pagenum=1&num=0">받은쪽지함</a></div>
					</td>
					<td  style="border-left: 1px solid #848484;height: 80px;">
						<div class="sendM"  >
							<div class="sendM2">
							<a href="${ContextPath }/mypage/noteList?pagenum=1&num=1"><img src="http://hoohee0331.cdn3.cafe24.com/img/sendM.png" width="50px" /></a></div>
							</div>
							<div class="sendIcon" ><a href="${ContextPath }/mypage/noteList?pagenum=1&num=1">보낸쪽지함</a></div>
					</td>
					<td style="border-left: 1px solid #848484;height: 80px;">
						<div class="sendM">
							<div class="sendM2">
							<a href="${ContextPath }/mypage/noteSend"><img src="http://hoohee0331.cdn3.cafe24.com/img/penM.png" width="50px" /></a>
							</div>
							</div>
							<div class="sendIcon" ><a href="${ContextPath }/mypage/noteSend">쪽지보내기</a></div>
					</td>
				</tr>
			</table>
		</div>
	</div>

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