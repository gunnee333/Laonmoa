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
<style>
.table_laonmoa tr, .table_laonmoa td {
	border-bottom: 1px solid #dee2e6;
	padding: .75rem;
}

.title-single-box2 {
	padding: 1rem 0 1rem 30rem;
}

.title-single1 {
	font-weight: 600 !important;
	font-size: 2.5rem;
	color: #FF7B22 !important;
}

.title-single2 {
	font-weight: 600 !important;
	font-size: 2.5rem;
	color: #000 !important;
}

.mainbody {
	width: 1200px;
	margin: -16px auto 100px auto;
}

.introimg {
	background-image: url('http://hoohee0331.cdn3.cafe24.com/img/introlaonmoa.jpg');
	width: 60%;
}

.introcontent {
	color: #fff;
}

.intro-single_laon {
	padding: 6rem 0 3rem;
}
section.wrapper.style1, article.wrapper.style1 {
    background: #5385c1;
    color: #bacee6;
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
	<!--/ Intro Single star /-->
	<section class="intro-single_laon"></section>
	<!--/ Intro Single End /-->

	<!--/ Carousel Star /-->
	<div class="mainbody">
		<div class="out">
			<div class="in">
				<table style="width: 1000px">
					<tr>
						<td><img src="http://hoohee0331.cdn3.cafe24.com/img/LOGOALL.jpg" width="30%">
							<br>
						<br>
						<br></td>
					</tr>

					<tr>
						<td align="center" class="introimg" style="color: #fff;"><br>
							<br> <span class="introcontent"
							style="font-size: 23px; font-weight: 600;">라온모아.'즐거움을 한데
								모으다.'</span><br>
						<br>
						<br> 축제 / 뮤지컬 / 공연 / 전시회의 문화정보를 모아 정보 제공을 취지로 시작되었습니다.<br>
							라온은 '즐거움' , 모아는 '모으다' 의 순 우리말을 합쳐 '즐거움을 한데 모으다'라는 의미를 가지고 공공의 목적을
							가지고 있습니다.<br> 라온모아는자신이 가고싶은 문화 생활을 한눈에 보고 찜하여 담아 놓을 수 있는 기능을
							가지고 있습니다.<br> 국내의 문화의 증진에 기여하고자 이 '라온모아' 프로젝트는 제작 되었습니다. <br>
						<br>
						<br></td>
					</tr>
				</table>
				<br> <br> <br> <br>
		
				<!-- 개발자소개 -->
				<table class="table_laonmoa" style="width: 100%;">
					<tr>
						<td colspan="3" style="font-size: 20px;">라온모아 개발자들<br></td>
					</tr>
					<tr>
						<td>이름</td>
						<td>이메일</td>
					</tr>
					<tr>
						<td>유민웅</td>
						<td>dbalsdnd12@naver.com</td>
					</tr>
					<tr>
						<td>신지혜</td>
						<td>wmwwm888@naver.com</td>
					</tr>
					<tr>
						<td>이건희</td>
						<td>hoohee0331@naver.com</td>
					</tr>
					<tr>
						<td>김현성</td>
						<td>rlagustjd56@naver.com</td>
					</tr>
					<tr>
						<td>추수아</td>
						<td>suu0616@naver.com</td>
					</tr>
				</table>
			</div>
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
