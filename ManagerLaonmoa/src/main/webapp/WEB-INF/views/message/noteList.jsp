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
<link rel="stylesheet" href="/resources/css/style2.css">
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub"><div class="out"><div class="in">
			<h3>쪽지리스트보기</h3><br>
			<table class="table_style" style="width: 1000px;">
				<thead>
					<tr>
						<td style="width: 108px;">보낸사람 ID</td>
						<td style="width: 108px;">받은사람 ID</td>
						<td style="width: 168px;">쪽지제목</td>
						<td style="width: 387px;">쪽지내용</td>
						<td style="width: 106px;">작성일</td>
						<td style="width: 110px;">
							<div class="dropdown">
								<button class="dropbtn">&nbsp;열람여부&nbsp;
								<span class="glyphicon glyphicon-menu-down" aria-hidden="true" style="font-size:13px;"></span></button>
								<div class="dropdown-content">
									<a onclick="ifread(-1);">전체보기</a>
									<a onclick="ifread(1);">열람</a> 
									<a onclick="ifread(0);">미열람</a>
								</div>
							</div>
						</td>
					</tr>

				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr class="td_style">
								<td colspan="6">쪽지가 없습니다.</td>
							</tr>
						</c:when>
					</c:choose>
					<c:forEach items="${list}" var="list">
						<tr class="td_style">
							<td>${list.sendid }</td>
							<td>${list.recid }</td>
							<td><a href="${ContextPath }/admin/noteView?mnum=${list.mnum }">${list.mtitle }</a></td>
							<td>${list.mcontent }</td>
							<td>
								<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd" />
								${date }</td>
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
			<div>
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
				<table style="margin: 0 auto;">
					<tr>
						<td>
							<!-- 검색조건 -->
							<select name="type" class="selectpicker" style="height: 35px;">
								<option value="">검색조건</option>
								<option value="sendid">보낸사람 ID</option>
								<option value="recid" id="recid" hidden="">받은사람 ID</option>
								<option value="mtitle">쪽지제목</option>
							</select>
						</td>
						<td>
							<!-- 검색내용 입력 -->
							<input type="text" name="value" style="height: 35px;">
						</td>
						<td>
							<!-- 검색버튼 -->
							<button id="submit" class="searchbutton" aria-label="Left Align">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
						</td>
					</tr>
				</table>
				<span class="checkspan"></span>
			</div></div></div>
		</div>
	</div>
	<script>
		var check = true;
		var url = "${ContextPath}" + window.location.pathname;
		$(document).ready(function(){
			
			if(window.location.pathname == "/admin/noteList"){
				$("#recid").attr("hidden", false);
			}
			
			$("#submit").click(function() {
				var type = $('select[name=type]').val();
				var value = $('input[name=value]').val();
				var ifread = "<%=request.getParameter("ifread") %>";
				url += "?";
				
				checkit();
				if(check){
					url += "type=" + type;
					url += "&value=" + value;
					
					location.replace(url);
				}
			});
		});
		
		function checkit(){
			check = true;
			var type = $('select[name=type]').val();
			var value = $('input[name=value]').val();
			
			if (type == "" || type == null) {
				$(".checkspan").text("검색조건을 입력해주세요.").show();
				check = false;
			} else if (value == "" || value == null) {
				$(".checkspan").text("검색내용을 입력해주세요.").show();
				check = false;
			} else {
				$(".checkspan").text("").hide();
			}
		}
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var type = "<%=request.getParameter("type") %>";
			var value = "<%=request.getParameter("value") %>";
			var ifread = "<%=request.getParameter("ifread") %>";
			url += "?pagenum=" + pagenum;
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(type == "" || type == null || type == "null")){
				url += "&type=" + type;
				url += "&value=" + value;
			}
			//열람여부 선택한 상태일 시 담아줌
			if(!(ifread == "" || ifread == null || ifread == "null" || ifread == "-1" || ifread == -1)){
				url += "&ifread=" + ifread;
			}
			
			location.replace(url);
		}
		
		function ifread(ifreadnum){
			var ifread = ifreadnum;
			var type = "<%=request.getParameter("type") %>";
			var value = "<%=request.getParameter("value") %>";
			url += "?pagenum=1";
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(type == "" || type == null || type == "null")){
				url += "&type=" + type;
				url += "&value=" + value;
			}
			//전체선택이 아닐시 담아줌
			if(!(ifread == "-1" || ifread == -1)){
				url += "&ifread=" + ifread;
			}
			
			location.replace(url);
		}
	</script>
</body>
</html>