<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<nav
	class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
	<div class="container">
		<button class="navbar-toggler collapsed" type="button"
			data-toggle="collapse" data-target="#navbarDefault"
			aria-controls="navbarDefault" aria-expanded="false"
			aria-label="Toggle navigation">
			<span></span> <span></span> <span></span>
		</button>
		<a href="/"> <img src="http://hoohee0331.cdn3.cafe24.com/img/LOGOFONT.png" width="130px"
			height="55px"></a>
		<button type="button"
			class="btn btn-link nav-search navbar-toggle-box-collapse d-md-none"
			data-toggle="collapse" data-target="#navbarTogglerDemo01"
			aria-expanded="false">
			<span class="fa fa-search" aria-hidden="true"></span>
		</button>

		<div class="navbar-collapse collapse justify-content-center"
			id="navbarDefault">
			<ul class="navbar-nav">

				<li class="nav-item"><a class="nav-link" href="${ContextPath }/laonmoa">우리는</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					href="${ContextPath }/culture/festivalList?pagenum=1&&level=7&&month=0&value=">축제모아</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle"
					id="navbarDropdown" role="button" data-toggle="dropdown" style="cursor: pointer;"
					aria-haspopup="true" aria-expanded="false"> 공연모아 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="${ContextPath }/culture/festivalList?pagenum=1&&level=8&&month=0&value=">연극</a> <a
							class="dropdown-item" href="${ContextPath }/culture/festivalList?pagenum=1&&level=9&&month=0&value=">뮤지컬</a> <a
							class="dropdown-item" href="${ContextPath }/culture/festivalList?pagenum=1&&level=10&&month=0&value=">전시회</a>
					</div></li>
				<li class="nav-item"><a class="nav-link"
					href="${ContextPath }/culture/mymoamain?level=12&pagenum=1">내꺼모아</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="${ContextPath }/board/reviewBoardMain"
					id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> 소통모아 </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="${ContextPath }/board/reviewBoardMain?pagenum=1">리뷰 게시판</a>
						<a class="dropdown-item"
							href="${ContextPath}/board/freeBoardMain?pagenum=1">자유
							게시판</a>
					</div></li>

			</ul>

		</div>

		<button type="button"
			class="btn btn-b-n navbar-toggle-box-collapse d-none d-md-block"
			data-toggle="collapse" data-target="#navbarTogglerDemo01"
			aria-expanded="false">
			<span class="fa fa-search" aria-hidden="true"></span>
		</button>

		<!-- 로그인 -->
		<c:if test="${id==null }">
			<div style="position: relative;">
				<div class="navbar navbar-expand-lg"
					style="position: absolute; top: -55px; right: 0; margin: 0 auto; width: 200px;">
					<a class="nav-link2" href="${ContextPath }/loginpage" id="login"><font
						size="2">로그인&nbsp;&nbsp;</font></a> <a class="nav-link2" href="${ContextPath }/joinpage"
						id="join"><font size="2">&nbsp;&nbsp;회원가입</font></a>
				</div>
			</div>
		</c:if>

		<!-- 회원 -->
		<c:if test="${id!=null }">
			<div style="position: relative;">
				<div class="navbar navbar-expand-lg" 
					style="position: absolute; right: 0; top: -55px; width: 340px; margin: 0 auto;">
					<a href="${ContextPath }/mypage/myinfo" style="font-weight: bold;">${name }</a>님 환영합니다. 
					<a href="${ContextPath }/mypage/myinfo" class="nav-link2" id="myPage" style="margin:0 15px;">
						<font size="2">마이페이지<span id="noteCnt" href="${ContextPath }/mypage/noteList?pagenum=1&num=0&readType=notread"></span></font>
					</a>
					<a class="nav-link2" href="${ContextPath }/logout">
						<font size="2">로그아웃</font>
					</a> 
				</div>
			</div>
		</c:if>
		<!-- 로그인 끝 -->
	</div>
	<script>
		$(document).ready(function(){
			if("${id!=null}"){
				$.ajax({
					type: "POST",
					url: "${ContextPath}/noteCnt",
					success: function(data){
						$("#noteCnt").text("(" + data + ")").show();
					}
				});
			}
		});
	</script>
</nav>