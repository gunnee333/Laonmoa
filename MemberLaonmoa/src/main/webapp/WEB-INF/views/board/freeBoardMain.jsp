<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<%@ include file="/resources/css/dropdown.css"%>

</head>
<style>
#link {
	text-align:left !important; 
}
.searchbutton {
	width: 30px;
	height: 30px;
	background-color: #FF7B22;
	border: none;
}
.board_table{
	width: 1100px; 
	border-top: 2px solid #343434; 
	border-bottom: 2px solid #343434;
}
</style>
<%String pagenum = request.getParameter("pagenum"); %>
<%String id = (String)session.getAttribute("id"); %>
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
							 <a href="${ContextPath}/board/freeBoardMain?pagenum=1">자유게시판</a>
						</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Intro Single End /-->

	<!--/ Carousel Star /-->
	<div class="out"><div class="in">
		<table class="table table-hover board_table">
			<thead>
				<tr>
					<td style="width: 120px;">번호</td>
					<td>제목</td>
					<td style="width: 120px;">작성자</td>
					<td style="width: 130px;">작성일자</td>
					<td style="width: 100px;">
					<select id="hit" class="selectpicker" style="height: 30px">
						<option selected disabled hidden="">${hit}</option>
						<option value="null">조회 수</option>
						<option value="hitdesc">많은 순</option>					
						<option value="hitasc">적은 순</option>
					</select>
					</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan="6">검색 결과가 없습니다.</td>
						</tr>
					</c:when>
				</c:choose>
				<c:forEach var="adminlist" items="${adminlist}">
				<tr>
					<td>[공지사항]</td>
					<td id="link">
					<a href="${ContextPath}/board/freeBoardDetail?bnum=${adminlist.bnum}&pagenum=<%=pagenum%>">
					<!-- 오늘 날짜 -->
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
					<!-- 가져온 게시글의 날짜 -->
					<fmt:formatDate value="${adminlist.date}" pattern="yyyyMMdd" var="todayreview" />
					${adminlist.title }<c:if test="${today == todayreview}"></c:if>
					<c:if test="${adminlist.replycnt ne 0}">
					(${adminlist.replycnt})
					</c:if>
					<c:if test="${today == todayreview}">&nbsp;&nbsp;<img src="http://hoohee0331.cdn3.cafe24.com/img/new.png" style="width: 30px;"></img></c:if>
					</a></td>
					<td>${adminlist.id }</td>
					<td>
					<fmt:formatDate var="date" value="${adminlist.date}" pattern="yyyy-MM-dd" />
					${date}
					</td>
					<td>${adminlist.hit }</td>
				</tr>
				</c:forEach>
				<c:choose>
					<c:when test="${empty list }">
					</c:when>
					<c:otherwise>
						<c:forEach var="list" items="${list}" varStatus="Status">
							<tr>
								<td>
									${page.getTotalcount()-Status.index-page.getPagenum()*10}
								</td>
								<td id = "link" >
								<!-- 오늘 날짜 -->
								<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
								<!-- 가져온 게시글의 날짜 -->
								<fmt:formatDate value="${list.date}" pattern="yyyyMMdd" var="todayreview" />
								<a href="${ContextPath}/board/freeBoardDetail?bnum=${list.bnum}&pagenum=<%=pagenum%>">
								${list.title }<c:if test="${today == todayreview}"></c:if>
								<c:if test="${list.replycnt ne 0}">
								(${list.replycnt})
								</c:if>
								<c:if test="${today == todayreview}">&nbsp;&nbsp;<img src="http://hoohee0331.cdn3.cafe24.com/img/new.png" style="width: 30px;"></img></c:if>
								</a></td>
								<td>${list.id }</td>
								<td>
								<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd" />
								${date}
								</td>
								<td>${list.hit }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<a onclick="login()" class="btn laonmoabtn pull-right">글쓰기</a>
		<div class="text-center">
				<nav>
			  		<ul class="pagination">
			  	<c:if test="${page.prev }">
			    <li>
			      <a href="javascript:page(${page.getStartpage()-1})" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    </c:if>
			    <c:forEach begin="${page.getStartpage()}" end="${page.getEndpage()}" var="idx">
			    <li>
			    	<a href="javascript:page(${idx})">${idx}</a></li>
			    </c:forEach>
			    <c:if test="${page.next }">
			    <li>
			      <a href="javascript:page(${page.getEndpage()+1})" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
			    </c:if>
			  </ul>
			</nav>
				<!-- 검색내용 입력 -->
		<form id="form" method="get" action="${ContextPath }/board/freeBoardSearch?pagenum=1">
			<table>
				<tr>
					<td>
					<select name="search" class="selectpicker"
						style="height: 30px">
							<option value="searchid">ID 검색</option>
							<option value="searchtitle">제목+내용 검색</option>
					</select>
					</td>
					<td>
					<input type="text" name="keyword" placeholder="검색">
					<input type="hidden" name = "pagenum" value="<%=pagenum%>">
					</td>
					
					<td>
						<!-- 검색버튼 -->
						<button type="button" class="searchbutton" onclick="submit()">
						<span class="fa fa-search" aria-hidden="true" style="color: #fff;"></span>
					</button>
					</td>
				</tr>
			</table>
		</form>
	</div></div></div>
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
	$("#hit").on("change",function(){
		var hit =  $("#hit option:selected").val();
		var search = "<%=request.getParameter("search")%>";
		var keyword = "<%=request.getParameter("keyword")%>";
		var pagenum = "<%=request.getParameter("pagenum")%>";
		if(keyword != "null"){
			location.replace("${ContextPath}/board/freeBoardSearch?hit="+hit+"&search="+search+"&keyword="+keyword+"&pagenum="+pagenum);
		}
		else{
			location.replace("${ContextPath}/board/freeBoardMain?hit="+hit+"&pagenum=1");
		}
	});
	
});
	function page(idx){
		var pagenum = idx;
		location.href="${ContextPath}/board/freeBoardMain?pagenum="+pagenum;
	}
	function submit(){
		$("#form").submit();
	}
	function login(){
		var id = "<%=id%>";
		if(id == "null"){
			location.replace("${ContextPath}/loginpage");
		}
		else{
			$.ajax({
				type:"get",
				url:"${ContextPath}/board/blacklist",
				data:{"id":id},
				success:function(data){
					if(data == 2){
						alert("이용이 제한된 회원입니다.");
					}
					else{
						location.replace("${ContextPath}/board/freeBoardInsert?pagenum=<%=pagenum%>");
					}
				}
				
			});
		}
	}
	
</script>
</body>
</html>
