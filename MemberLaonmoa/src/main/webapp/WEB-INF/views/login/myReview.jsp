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
<style>
select {
	border: 1px solid #ccc;
	height: 35px;
	width: 120px;
	color: #555;
}
.searchbutton {
	width: 35px;
	height: 35px;
	background-color: #FF7B22;
	border: none;
}
.in_maymoa{
    display: inline-block;
    width: 100%;
    padding-top: 40px;
}
</style>
</head>
<%String pagenum = request.getParameter("pagenum"); %>
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
				<li role="presentation"><a href="${ContextPath}/mypage/myinfo">내정보</a></li>
				<li role="presentation" class="active"><a href="${ContextPath}/mypage/myReview?pagenum=1">내가 쓴 게시글</a></li>
				<li role="presentation"><a href="${ContextPath}/mypage/mynote">쪽지보관함</a></li>
			</ul>
	</div>
	<div class="out">
		<div class="in_maymoa">
			<!-- 정보보기 -->
			<!-- 셀렉트박스 -->
			<div style="position: relative; margin-bottom: 50px;">
				<div style="position: absolute; right: 20px;">
					<select id="boardType">
						<option value="${boardType }" selected disabled hidden="">${korboardType }</option>
						<option value="all">전체</option>
						<option value="freeboard">자유게시판</option>
						<option value="reviewboard">리뷰게시판</option>
					</select>
				</div>
			</div>
			<!-- 리스트 -->
			<table class="table table-hover">
				<thead>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>작성일자</td>
						<td>조회수</td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="5">게시글이 존재하지 않습니다.</td>
							</tr>
						</c:when>
					</c:choose>
					<c:forEach var="list" items="${list }">
						<tr>
							<td>
								<c:choose>
									<c:when test="${list.level == 3 }">
										[자유게시판]
									</c:when>
									<c:when test="${list.level == 4 }">
										[리뷰게시판]
									</c:when>
								</c:choose>
							</td>
							<td>
								<!-- 페이지 상세보기로 이동 -->
								<c:choose>
									<c:when test="${list.level == 3 }">
										<a href="${ContextPath}/board/freeBoardDetail?bnum=${list.bnum}&pagenum=1">${list.title }</a>
									</c:when>
									<c:when test="${list.level == 4 }">
										<a href="${ContextPath}/board/reviewBoardDetail?bnum=${list.bnum}&pagenum=1">${list.title }</a>
									</c:when>
								</c:choose>
							</td>
							<td>${list.id }</td>
							<td>
								<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd HH:mm" />
								${date }
							</td>
							<td>${list.hit }</td>
						</tr>
					</c:forEach>
				</tbody>
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
			<!-- 검색영역 -->
			<table>
				<tr>
					<td><select name="searchType">
							<option value="">검색조건</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
					</select></td>
					<td><input type="text" class="form-control" name="value"
						placeholder="검색내용을 입력해주세요." maxlength="30"
						style="height: 35px; width: 200px; border-radius: 0%"></td>
					<td>
						<button type="button" class="searchbutton" onclick="search();">
							<span class="fa fa-search" aria-hidden="true"
								style="color: #fff;"></span>
						</button>
					</td>
				</tr>
				<tr>
					<td colspan="3" hidden="" id="hiddentd">
						<span class="checkspan" id="checkspan"></span>
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
	<script>
		$(document).ready(function(){
			$("#boardType").on("change", function(){
				var boardType = $("#boardType option:selected").val();
				var type = "<%=request.getParameter("type") %>";
				var value = "<%=request.getParameter("value") %>";
				
				// 게시판타입 선택시, 전체선택이 아닌경우 url에 값담아주고 1페이지로 이동
				url = "${ContextPath}/mypage/myReview?pagenum=1";
				if(boardType != 'all'){
					url += "&boardType=" + boardType;
				}
				if(!(type == null || type == ""  || type == "null")){
					url += "&type=" + type + "&value=" + value;
				}
				location.replace(url);
			});
		});
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var boardType = $("#boardType option:selected").val();
			var type = "<%=request.getParameter("type") %>";
			var value = "<%=request.getParameter("value") %>";
			
			var url = "${ContextPath}/mypage/myReview?pagenum=" + pagenum;
			// 보려고자하는 게시판타입이 전체가 아닌경우 url에 값담아줌
			if(boardType != 'all'){
				url += "&boardType=" + boardType;
			}
			if(!(type == null || type == "" || type == "null")){
				url += "&type=" + type + "&value=" + value;
			}
			location.replace(url);
		}
		
		// 검색버튼 클릭시
		var check = true;
		function search(){
			checkit();
			var type = $('select[name=searchType]').val();
			var value = $('input[name=value]').val();
			var url = "${ContextPath}/mypage/myReview?pagenum=1";
			
			if(check){
				url += "&type=" + type + "&value=" + value;
				location.replace(url);
			}
		}
		
		// 검색값 잘 들어왔는지 확인
		function checkit(){
			check = true;
			var type = $('select[name=searchType]').val();
			var value = $('input[name=value]').val();
			
			if(type == null || type == ""){
				$("#hiddentd").attr("hidden",false);
				$("#checkspan").text("검색조건을 선택해주세요.").show();
				check = false;
				return false;
			} else if(value == null || value.trim() == ""){
				$("#hiddentd").attr("hidden",false);
				$("#checkspan").text("검색내용을 입력해주세요.").show();
				check = false;
				return false;
			} else {
				$("#hiddentd").attr("hidden",true);
				$("#checkspan").text("").hide();
			}
		}
	</script>
</body>
</html>
