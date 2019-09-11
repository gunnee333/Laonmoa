<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<%
	String num = request.getParameter("num");
	String level = request.getParameter("level");
%>
<body>
	<%@ include file="../include/Header.jsp"%>

	<!-- 전송시 입력값 체크하는 js -->
	<script src="/resources/js/submitCheck.js"></script>
	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<div class="out">
				<div class="in">
					<div>
						<h3 class="title_top">공지사항 관리</h3>
						<br>
						<table>
							<tr>
								<td>
									<div class="dropdown dropdown_free">
										<button class="dropbtn">
											게시판<span class="glyphicon glyphicon-menu-down"
												aria-hidden="true" style="font-size: 13px;"></span>
										</button>
										<div class="dropdown-content">
											<a href="${ContextPath }/admin/board/noticeList?del=-1&num=1&level=3">자유게시판</a>
											<a href="${ContextPath }/admin/board/noticeList?del=-1&num=1&level=4">리뷰게시판</a>
										</div>
									</div>
								</td>
							</tr>
						</table>
						<table class="list_table">
							<thead>
								<tr class="th_style">
									<td id="board_bnum"></td>
									<td id="board_type">게시판</td>
									<td id="board_title">공지사항 제목</td>
									<td id="board_id">작성자</td>
									<td id="board_date">작성일</td>
									<td id="board_hit">조회수</td>
									<td id="board_del">
										<div class="dropdown">
											<button class="dropbtn del_button">
												삭제여부<span class="glyphicon glyphicon-menu-down"
													aria-hidden="true" style="font-size: 13px;"></span>
											</button>
											<div class="dropdown-content del_drop">
												<a
													href="${ContextPath }/admin/board/noticeList?del=0&num=1&level=<%=request.getParameter("level")%>">게시중</a>
												<a
													href="${ContextPath }/admin/board/noticeList?del=1&num=1&level=<%=request.getParameter("level")%>">삭제</a>
											</div>
										</div>
									</td>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty list }">
									<tr class="td_style">
										<td colspan="6">리스트가 존재하지 않습니다.</td>
									</tr>
								</c:if>
								<c:forEach items="${list}" var="list">
									<tr class="td_style">
										<td>${list.bnum}</td>
										<td><c:if test="${list.level == 3 }">
												<c:out value="자유게시판" />
											</c:if> <c:if test="${list.level ==  4}">
												<c:out value="리뷰게시판" />
											</c:if></td>
										<td id="list_title"><a
											href="${ContextPath }/admin/board/noticeDetail?bnum=${list.bnum}">${list.title}</a></td>
										<td>${list.id}</td>
										<td><fmt:formatDate var="date" value="${list.date}"
												pattern="yyyy-MM-dd" /> ${date }</td>
										<td>${list.hit}</td>
										<td><c:if test="${list.del == 0 }">
												<c:out value="게시중" />
											</c:if> <c:if test="${list.del == 1 }">
												<c:out value="삭제" />
											</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<br>
						<div style="float: right;">
							<a href="${ContextPath }/admin/board/reviewBoardInsert?level=1" class="btn laonmoabtn">리뷰공지쓰기</a>
							<a href="${ContextPath }/admin/board/freeBoardInsert" class="btn laonmoabtn">자유공지쓰기</a>
						</div>
						<!-- 페이징 -->
						<div>
							<nav id="paging" style="width: 300px; margin: 20px auto 0 auto;">
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

						<!-- 검색내용 입력 -->
						<form id="form" method="get" name="searchfrm" action="${ContextPath}/admin/board/noticeSearch">
							<table>
								<tr>
									<td><select name="search" class="selectpicker"
										style="height: 35px;">
											<!-- <option value="searchtitlecontent">제목+내용</option> -->
											<option value="searchtitle">제목</option>
											<option value="searchid">작성자</option>
									</select></td>
									<td><input type="text" name="keyword" placeholder="검색"
										style="height: 35px;"> <input type="hidden" name="num"
										value="<%=num%>"><input type="hidden" name="level"
										value="<%=level%>"></td>

									<td>
										<!-- 검색버튼 -->
										<button type="button" id="btnSearch" class="searchbutton">
											<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
										</button>
									</td>
								</tr>
							</table>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
	function page(idx){
		var num = idx;
		var level = "<%=request.getParameter("level")%>";
		var del = "<%=request.getParameter("del")%>";
		var search = "<%=request.getParameter("search")%>";
		var keyword = "<%=request.getParameter("keyword")%>";
		
		var url = "${ContextPath}/admin/board/noticeSearch?num=" + num;
		url += "&level=" + level;
		
		if(!(del == "null" || del == null)){
			url += "&del=" + del;
		} if(!(search == "null" || search == null)){
			url += "&search=" + search;
			url += "&keyword=" + keyword;
		}
			location.href = url;
		}
	
	var checkSearch = true;
	$(document).ready(function(){
		$("#btnSearch").click(function(){
			checkit();
			if(checkSearch){
				document.searchfrm.submit();
			}
		});
	});
	
	function checkit(){
		checkSearch = true;
	}
	
	</script>

</body>
</html>