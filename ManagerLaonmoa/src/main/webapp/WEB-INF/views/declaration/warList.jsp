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
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub">
		<div class="out"><div class="in">
			<!-- 메인 -->
			<h3>신고내역보기</h3><br>
			<table class="table_style" style="width: 100%;">
				<thead>
					<tr>
						<td style="width: 135px;">신고자 ID</td>
						<td style="width: 135px;">신고당한 ID</td>
						<td style="width: 146px;">
							<div class="dropdown">
								<button class="dropbtn" style="margin-left: 0;">종류&nbsp;
								<span class="glyphicon glyphicon-menu-down" aria-hidden="true" style="font-size:13px;"></span></button>
								<div class="dropdown-content" style="margin-left: 0;">
									<a onclick="level(-1);">전체보기</a>
									<a onclick="level(3);">자유게시판</a>
									<a onclick="level(4);">리뷰게시판</a>
									<a onclick="level(5);">자유댓글</a>
									<a onclick="level(6);">리뷰댓글</a>
								</div>
							</div>
						</td>
						<td style="width: 124px;">신고당한글</td>
						<td style="width: 360px;">신고내용</td>
						<td style="width: 100px;">
							<div class="dropdown">
								<button class="dropbtn" style="margin-left: 0;">처리여부&nbsp;
								<span class="glyphicon glyphicon-menu-down" aria-hidden="true" style="font-size:13px;"></span></button>
								<div class="dropdown-content" style="margin-left: 0;">
									<a onclick="process(-1);">전체</a>
									<a onclick="process(1);">처리</a>
									<a onclick="process(0);">미처리</a>
								</div>
							</div>
						</td>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr class="td_style">
								<td colspan="6">신고된 내용이 없습니다.</td>
							</tr>
						</c:when>
					</c:choose>
					<c:forEach items="${list }" var="list">
						
						<tr class="td_style">
							<td>${list.whoid}</td>
							<td>${list.warid}</td>
							<td><c:choose>
									<c:when test="${list.level == 3}">
										자유게시판
									</c:when>
									<c:when test="${list.level == 4}">
										리뷰게시판
									</c:when>
									<c:when test="${list.level == 5 || list.level == 6}">
										댓글
									</c:when>
								</c:choose></td>
							<!-- 신고당한 글이 게시글이면 게시글번호, 댓글이면 댓글번호 표기 -->
							<td><c:choose>
									<c:when test="${list.level == 3 || list.level == 4}">
										${list.bnum }
									</c:when>
									<c:when test="${list.level == 5 || list.level == 6}">
										${list.rnum }
									</c:when>
								</c:choose></td>
							<td style="text-align: left;">
								<a href="${ContextPath }/admin/warView?wnum=${list.wnum}">${list.wcontent} </a>
							</td>
							<td><c:if test="${list.process == 0 }">
									<c:out value="미처리" />
								</c:if> <c:if test="${list.process == 1 }">
									<c:out value="처리완료" />
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 페이징 -->
			<div>
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
			<div>
			<table style="margin: 0 auto;">
					<tr>
						<td>
							<!-- 검색조건 -->
							<select name="type" class="selectpicker" style="height: 35px;">
								<option value="">검색조건</option>
								<option value="warid">신고당한ID</option>
								<option value="whoid">신고한ID</option>
								<option value="wcontent">신고내용</option>
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
			</div>
			<!-- 메인 끝 -->
		</div></div></div>
	</div>
	</div>
	
	<script>
		var check = true;
		$(document).ready(function(){
			$("#submit").click(function() {
				var type = $('select[name=type]').val();
				var value = $('input[name=value]').val();
				var level = "<%=request.getParameter("level") %>";
				var process = "<%=request.getParameter("process") %>";
				var url = "${ContextPath}/admin/warList?pagenum=1";
				
				checkit();
				if(check){
					url += "&type=" + type;
					url += "&value=" + value;
					
					// 게시판타입 선택했을 시 담아줌
					if(!(level == "" || level == null || level == "null")){
						url += "&level=" + level;
					}
					//열람여부 선택한 상태일 시 담아줌
					if(!(process == "" || process == null || process == "null" || process == "-1" || process == -1)){
						url += "&process=" + process;
					}
					
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
			var level = "<%=request.getParameter("level") %>";
			var process = "<%=request.getParameter("process") %>";
			
			var url = "${ContextPath}/admin/warList?pagenum=" + pagenum;
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(type == "" || type == null || type == "null")){
				url += "&type=" + type;
				url += "&value=" + value;
			}
			
			// 게시판타입 선택했을 시 담아줌
			if(!(level == "" || level == null || level == "null")){
				url += "&level=" + level;
			}
			//열람여부 선택한 상태일 시 담아줌
			if(!(process == "" || process == null || process == "null" || process == "-1" || process == -1)){
				url += "&process=" + process;
			}
			
			location.replace(url);
		}
		
		function level(levelnum){
			var level = levelnum;
			var type = "<%=request.getParameter("type") %>";
			var value = "<%=request.getParameter("value") %>";
			var process = "<%=request.getParameter("process") %>";
			
			var url = "${ContextPath}/admin/warList?pagenum=1";
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(type == "" || type == null || type == "null")){
				url += "&type=" + type;
				url += "&value=" + value;
			}
			
			// 게시판타입 선택했을 시 담아줌
			if(!(level == "" || level == null || level == "null")){
				url += "&level=" + level;
			}
			//열람여부 선택한 상태일 시 담아줌
			if(!(process == "" || process == null || process == "null" || process == "-1" || process == -1)){
				url += "&process=" + process;
			}
			
			location.replace(url);
		}
		
		function process(processnum){
			var process = processnum;
			var type = "<%=request.getParameter("type") %>";
			var value = "<%=request.getParameter("value") %>";
			var level = "<%=request.getParameter("level") %>";
			
			var url = "${ContextPath}/admin/warList?pagenum=1";
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(type == "" || type == null || type == "null")){
				url += "&type=" + type;
				url += "&value=" + value;
			}
			// 게시판타입 선택했을 시 담아줌
			if(!(level == "" || level == null || level == "null")){
				url += "&level=" + level;
			}
			//열람여부 선택한 상태일 시 담아줌
			if(process == 1 || process == 0){
				url += "&process=" + process;
			}
			
			location.replace(url);
		}
	</script>
</body>
</html>