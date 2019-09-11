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
.searchbutton {
	width: 35px;
	height: 35px;
	background-color: #FF7B22;
	border: none;
}
select {
	border: 1px solid #ccc;
	height: 35px;
	width: 115px;
	color: #555;
}
.table td{
	vertical-align: inherit;
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
	<div class="out"><div class="in">
	<!-- 본문 -->
	<div style="margin: 2rem auto;">
		<h3>
			<!-- 받은쪽지함 -->
			<c:if test="${ifsend eq 0 }">
				<c:out value="받은쪽지함" />
			</c:if>
			<!-- 보낸쪽지함 -->
			<c:if test="${ifsend eq 1 }">
				<c:out value="보낸쪽지함" />
			</c:if>
		</h3>
	</div>
	<table class="table table-hover">
				<thead>
					<tr>
						<td>제목</td>
						<td>
							<!-- 받은쪽지함 -->
							<c:if test="${ifsend eq 0 }">
								<c:out value="발송인" />
							</c:if>
							<!-- 보낸쪽지함 -->
							<c:if test="${ifsend eq 1 }">
								<c:out value="수신인" />
							</c:if>
						</td>
						<td>작성일자</td>
						<td>
							<div class="dropdown" style="padding: 0;">
								<button class="dropbtn">
									<div class="nav-link dropdown-toggle"
									id="navbarDropdown" role="button" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"> 열람여부 </div>
								</button>
								<div class="dropdown-content">
									<a onclick='ifread("all");'>전체보기</a>
									<a onclick='ifread("read");'>열람</a>
									<a onclick='ifread("notread");'>미열람</a>
								</div>
							</div>
						</td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="4">쪽지가 존재하지 않습니다.</td>
							</tr>
						</c:when>
					</c:choose>
					<c:forEach var="list" items="${list }">
						<tr>
							<td><a href="${ContextPath }/mypage/notedetail?mnum=${list.mnum }">${list.mtitle }</a></td>
							<td>
								<!-- 받은쪽지함 -->
								<c:if test="${ifsend eq 0 }">
									<c:out value="${list.sendid }" />
								</c:if>
								<!-- 보낸쪽지함 -->
								<c:if test="${ifsend eq 1 }">
									<c:out value="${list.recid }" />
								</c:if>
							</td>
							<td>
								<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd HH:mm" />
								${date }
							</td>
							<td>
								<c:if test="${list.ifread == 0 }">
									<c:out value="미열람" />
								</c:if>
								<c:if test="${list.ifread == 1 }">
									<c:out value="열람" />
								</c:if>
							</td>
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
							<option value="mtitle">제목</option>
							<option value="titleAndContent">제목+내용</option>
							<c:choose>
								<c:when test="${ifsend eq 0 }">
									<option value="sendid">발송인</option>
								</c:when>
								<c:when test="${ifsend eq 1 }">
									<option value="recid">수신인</option>
								</c:when>
							</c:choose>
					</select></td>
					<td><input type="text" class="form-control" name="searchValue"
						placeholder="검색내용을 입력해주세요." maxlength="40"
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
		// 열람여부 선택시
		function ifread(read){
			var readType = read;
			var searchType = "<%=request.getParameter("searchType") %>";
			
			// 열람여부 선택시, 전체선택이 아닌경우 url에 값담아주고 1페이지로 이동
			var url = "${ContextPath }/mypage/noteList?pagenum=1&num=<%=request.getParameter("num") %>";
			if(readType != 'all'){
				url += "&readType=" + readType;
			}
			if(!(searchType == "" || searchType == null || searchType == 'null')){
				url += "&searchType=" + searchType + "&searchValue=<%=request.getParameter("searchValue") %>"
			}
			location.replace(url);
		}
		
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var readType = $('input[name=readType]').val();
			var searchType = "<%=request.getParameter("searchType") %>";
			
			var url = "${ContextPath}/mypage/noteList?pagenum="+pagenum+"&num=<%=request.getParameter("num") %>"
			// 열람여부 선택되어 있을 시 유지
			if(readType != "all"){
				url += "&readType=" + readType;
			}
			// 검색조건있을 시 검색조건도 같이 넘겨줌
			if(!(searchType == "" || searchType == null || searchType == 'null')){
				url += "&searchType=" + searchType + "&searchValue=<%=request.getParameter("searchValue") %>"
			}
			
			location.replace(url);
		}
		
		var check = true;
		// 검색버튼 클릭시
		function search(){
			var searchType = $('select[name=searchType]').val();
			var searchValue = $('input[name=searchValue]').val();
			var url = "";
			
			checkit();	// 검색조건/값 잘 입력됐는지 확인 후 이동
			if(check){
				url += "${ContextPath}/mypage/noteList?pagenum=1";
				url += "&num=<%=request.getParameter("num") %>";
				url += "&searchType=" + searchType + "&searchValue=" + searchValue;
				location.replace(url);
			}
		}
		
		function checkit(){
			check = true;
			var searchType = $('select[name=searchType]').val();
			var searchValue = $('input[name=searchValue]').val();
			
			if(searchType == null || searchType ==""){
				$("#hiddentd").attr("hidden",false);
				$("#checkspan").text("검색조건을 선택해주세요.").show();
				check = false;
				return false;
			} else if(searchValue == null || searchValue.trim() == ""){
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
