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
<body>
	<%@ include file="../include/Header.jsp"%>
<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub"><div class="out"><div class="in">
		<h3>댓글 관리</h3><br>
		<!-- 리스트 테이블 -->
		<table class="list_table">
			<thead>
				<tr>
					<td>게시판 타입</td>
					<td>댓글 내용</td>
					<td>작성자ID</td>
					<td>작성일</td>
					<td>삭제여부</td>
				</tr>
			</thead>

			<tbody>
				<c:choose>
					<c:when test="${empty list }">
						<tr class="td_style">
							<td colspan="5">해당사항이 존재하지 않습니다.</td>
						</tr>
					</c:when>
				</c:choose>
				<c:forEach items="${list }" var="list">
					<tr class="td_style">
						<td>
							<!-- 댓글 게시판 유형 --> <c:if test="${list.level == 5}">
								<c:out value="자유게시판" />
							</c:if> <c:if test="${list.level == 6}">
								<c:out value="리뷰게시판" />
							</c:if>
						</td>
						<td style="max-width: 150px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
							<a
							href="${ContextPath }/admin/replyView?bnum=${list.bnum }&level=${list.level}&num=1">
								<c:out value="${list.rcontent}" />
						</a>
						</td>

						<td>${list.id}</td>
						<td>
							<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd" />
							${date}</td>
						<!-- 삭제여부 -->
						<td><c:if test="${list.del == 1}">
								<c:out value="삭제" />
							</c:if></td>

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
		<!-- 검색 조건 -->
		<table style="margin: 0 auto;">
			<tr>
				<td>
					<!-- 검색조건 -->
					<select id="type" name="type" class="selectpicker" style="height: 35px;">
						<option value="">검색조건</option>
						<option value="id">작성자ID</option>
						<option value="rcontent">댓글 내용</option>
					</select>
				</td>
				<td>
					<!-- 검색내용 입력 -->
					<input type="text" id="value" name="value" style="height: 35px;">
				</td>
				<td>
					<!--- --검색버튼 ---->
					<button id="submit" class="searchbutton"
						aria-label="Left Align">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</td>
			</tr>
		</table>
		</div></div>
	</div>
</div>
<script>
	$(document).ready(function() {
		$("#submit").click(function() {
			if ($("#type").val() == "" || $("#type").val() == null) {
				alert("검색조건을 선택하세요.");
				return false;
			}
			if ($("#value").val() == "" || $("#value").val() == null) {
				alert("검색할 내용을 입력하세요.");
				return false;
			}
			
			var url = "${ContextPath}/admin/replyList";
			url += "?num=" + "<%=request.getParameter("num") %>";
			url += "&type=" + $("#type").val();
			url += "&value=" + $("#value").val();
			
			location.href = url;
		});
	});
	
	// 페이징을 위한 스크립트
	function page(idx){
		var pagenum = idx;
		var type = "<%=request.getParameter("type") %>";
		var value = "<%=request.getParameter("value") %>";
		
		var url = "${ContextPath}/admin/replyList?num=" + pagenum;
		
		// 검색조건이 있을 시 검색조건 담아줌
		if(!(type == "" || type == null || type == "null")){
			url += "&type=" + type;
			url += "&value=" + value;
		}
		
		location.replace(url);
	}
</script>
</body>

</html>