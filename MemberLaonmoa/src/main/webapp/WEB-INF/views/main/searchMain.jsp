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
</head>
<style>
table, tr, td {
	border-top: 2px solid #D3D3D3;
	border-bottom: 2px solid #D3D3D3;
}
.culture_th {
	font-size: 20px;
}

#culture_th1 {
	text-align: center;
	width: 200px;
}
#culture_th2 {
	text-align: right;
	
}
.culture_style{
	margin-right: 8px;
}
.s_sort:hover{
	cursor: pointer;
	color: #ff7b22 !important;
}
.good_sort{
	padding-right: 13px;
	border-right: 1.5px solid #D3D3D3;
}
</style>
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
							 라온모아 검색 결과
						</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Intro Single End /-->
	
	<!--/ Carousel Star /-->
	<div class="out">
		<div class="in">
			<div class="col-md-8">
				<div class="agent-avatar-box">
					<table style="width: 1000px;">
						<thead>
							<th class="culture_th" id="culture_th1">총 ${totalcount}건</th>
							<th class="culture_th" id="culture_th2">
							<!-- <a class="culture_style s_sort" onclick='sort("New");'>최신순</a>  -->
							<a class="culture_style s_sort good_sort" onclick='sort("good");'>인기순</a> 
							<a class="culture_style s_sort" onclick='sort("-ing");'>진행중</a></th>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty list }">
									<tr>
										<td colspan="5" style="height: 70px;">검색 결과가 없습니다.</td>
									</tr>
								</c:when>
							</c:choose>

							<c:forEach var="list" items="${list }">
								<tr>
									<td>
										<c:choose>
											<c:when test="${empty list.image }">
												<img src="http://hoohee0331.cdn3.cafe24.com/img/Noimg.png" width="150px" height="100px" />
											</c:when>
											<c:otherwise>
												<img src="http://hoohee0331.cdn3.cafe24.com/resource/${list.image }" width="150px" height="100px" />
											</c:otherwise>
										</c:choose>
									</td>
									<td style="padding-top: 15px; padding-left:40px; text-align: left;"><a
										href="${ContextPath}/culture/cultureDetailView?fno=${list.fno}">
										<c:choose>
											<c:when test="${list.level == 7 }">[축제]</c:when>
											<c:when test="${list.level == 8 }">[연극]</c:when>
											<c:when test="${list.level == 9 }">[뮤지컬]</c:when>
											<c:when test="${list.level == 10 }">[전시회]</c:when>
										</c:choose>
										${list.fname }</a><br>
										<p class="space_content">
											<fmt:formatDate var="sdate" value="${list.sdate}" pattern="yyyy-MM-dd" />
											<fmt:formatDate var="edate" value="${list.edate}" pattern="yyyy-MM-dd" />
											${sdate} ~ ${edate} <br /> ${list.fcontent}
										</p></td>
								</tr>
							</c:forEach>
						<tbody>
					</table>
				</div>
			</div>
			<!-- 페이징 -->
			<div class="out"><div class="in">
				<nav id="paging">
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
			</div></div>
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
		function sort(sortStr){
			var sort = sortStr;
			var keyword = "<%=request.getParameter("keyword") %>";
			var type = "<%=request.getParameter("type") %>";
			var city = "<%=request.getParameter("city") %>";
			var month = "<%=request.getParameter("month") %>";
			
			var searchUrl = "${ContextPath}/main/searchMain?pagenum=1";
			
			if(!(keyword == "null" || keyword == "" || keyword == null)){
				searchUrl += "&keyword=" + keyword;
			}
			if(!(type == "null" || type == "" || type == null)){
				searchUrl += "&type=" + type;
			}
			if(!(city == "null" || city == "" || city == null)){
				searchUrl += "&city=" + city;
			}
			if(!(month == "null" || month == "" || month == null)){
				searchUrl += "&month=" + month;
			}
			
			searchUrl += "&sort=" + sort;
			
			location.href = searchUrl;
		}
			
		function page(idx) {
			var pagenum = idx;
			var keyword = "<%=request.getParameter("keyword") %>";
			var type = "<%=request.getParameter("type") %>";
			var city = "<%=request.getParameter("city") %>";
			var month = "<%=request.getParameter("month") %>";
			var sort = "<%=request.getParameter("sort") %>";
			
			var searchUrl = "${ContextPath}/main/searchMain?pagenum=" + pagenum;
			
			if(!(keyword == "null" || keyword == "" || keyword == null)){
				searchUrl += "&keyword=" + keyword;
			}
			if(!(type == "null" || type == "" || type == null)){
				searchUrl += "&type=" + type;
			}
			if(!(city == "null" || city == "" || city == null)){
				searchUrl += "&city=" + city;
			}
			if(!(month == "null" || month == "" || month == null)){
				searchUrl += "&month=" + month;
			}
			if(!(sort == "null" || sort == "" || sort == null)){
				searchUrl += "&sort=" + sort;
			}
			
			location.href = searchUrl;
		}
		
		$(document).ready(function(){
			$("#paging").show();
			if(${nocount == 0}){
				$("#paging").hide();
			}
		});
	</script>
</body>
</html>
