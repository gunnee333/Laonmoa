<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<link href="/resources/css/festivalcss.css" rel="stylesheet">
<style>
select {
	border: 1px solid #ccc;
	height: 35px;
	width: 120px;
	color: #555;
}
td {
	text-align: left;
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
	
	<!--/ Intro Single star /-->
	<section class="intro-single">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-8">
					<div class="title-single-box">
						<h1 class="title-single">
							 내꺼모아
						</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Intro Single End /-->
		
	<!--/ Carousel Star /-->
	<div class="out">
		<!-- 메뉴 네비게이션 -->
		<ul class="nav nav-tabs">
			<c:choose>
				<c:when test="${level == 12 }">
					<li role="presentation" class="active"><a href="${ContextPath }/culture/mymoamain?level=12&pagenum=1">나의 좋아요</a></li>
					<li role="presentation"><a href="${ContextPath }/culture/mymoamain?level=13&pagenum=1">나의 찜</a></li>
				</c:when>
				<c:when test="${level == 13 }">
					<li role="presentation"><a href="${ContextPath }/culture/mymoamain?level=12&pagenum=1">나의 좋아요</a></li>
					<li role="presentation" class="active"><a href="${ContextPath }/culture/mymoamain?level=13&pagenum=1">나의 찜</a></li>
				</c:when>
			</c:choose>
		</ul>
	</div>
	<div class="out">
		<div class="in_maymoa">
		<!-- 본문 -->
			<!-- 셀렉트박스 -->
			<div style="position: relative; margin-bottom: 50px;">
				<div style="position: absolute; right: 20px;">
					<select id="flevel">
						<option selected disabled hidden="">${korType }</option>
						<option value="-1">전체</option>
						<option value="7">축제</option>
						<option value="8">연극</option>
						<option value="9">뮤지컬</option>
						<option value="10">전시회</option>
					</select>
				</div>
			</div>
					<table style="width: 50rem;">
						<!-- 리스트가 없을 때 -->
						<c:if test="${empty list }">
							<tr>
								<td colspan="2">리스트가 존재하지 않습니다.</td>
							</tr>
						</c:if>
						<!-- 리스트 있을 때 -->
						<c:forEach var="list" items="${list}">
							<tr>
								<td style="width: 200px;">
									<!-- 이미지 있을때 출력/ 없을땐 없다고 안내 -->
									<c:choose>
										<c:when test="${empty list.image }">
											<img src="http://hoohee0331.cdn3.cafe24.com/img/Noimg.png" class="festival_img"/>
										</c:when>
										<c:otherwise>
											<img src="http://hoohee0331.cdn3.cafe24.com/resource/${list.image }" class="festival_img"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td><a href="${ContextPath }/culture/cultureDetailView?fno=${list.fno}" 
									class="festival_font">${list.fname }</a><br>
									<fmt:formatDate var="sdate" value="${list.sdate}" pattern="yyyy-MM-dd" />
									<fmt:formatDate var="edate" value="${list.edate}" pattern="yyyy-MM-dd" />
									${sdate}~${edate}<br/>
									<p class="space_content">${list.fcontent }</p></td>
							</tr>
						</c:forEach>
					</table>
			<!-- 페이징 -->
			<nav>
				<ul class="pagination">
					<c:if test="${page.prev }">
						<li><a href="javascript:page(${page.getStartpage()-1})"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach begin="${page.getStartpage()}"
						end="${page.getEndpage()}" var="idx">
						<li><a href="javascript:page(${idx})">${idx}</a></li>
					</c:forEach>
					<c:if test="${page.next }">
						<li><a href="javascript:page(${page.getEndpage()+1})"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
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
	
	<script>
		$(document).ready(function(){
			$("#flevel").on("change", function(){
				var flevel = $("#flevel option:selected").val();
				
				url = "${ContextPath}/culture/mymoamain?level=<%=request.getParameter("level") %>&pagenum=1";
				// 축제타입 선택시, 전체선택이 아닌경우 url에 값담아주고 1페이지로 이동
				if(flevel != '-1'){
					url += "&flevel=" + flevel;
				}
				location.replace(url);
			});
		});
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var flevel = <%=request.getParameter("flevel") %>;
			
			url = "${ContextPath}/culture/mymoamain?level=<%=request.getParameter("level") %>&pagenum=" + pagenum;
			// 보려고자하는 축제타입이 전체가 아닌경우 url에 값담아줌
			if(flevel != null){
				url += "&flevel=" + flevel;
			}
			location.replace(url);
		}
	</script>
</body>
</html>
