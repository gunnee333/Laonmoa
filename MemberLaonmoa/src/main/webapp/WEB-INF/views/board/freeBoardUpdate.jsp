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
<%String pagenum = request.getParameter("pagenum"); %>
<%String bnum = request.getParameter("bnum"); %>
<body> 
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Carousel Star /-->
	<div class="mainbody"><div class="out"><div class="in">
	<form method="post" action="${ContextPath}/board/freeBoardUpdate">
				<table class="table"
					style="text-align: center;">
					<thead>
						<tr>
							<th colspan="2" style="text-align:center; font-size:20px;">
								자유게시판 글 수정</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="${list.title }" name="title" maxlength="50"/></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="${list.content }" name="content" maxlength="2048" style="height: 500px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<button type="button" class="btn laonmoabtn pull-right" onclick="cencel()">취소</button>
				<button class="btn laonmoabtn pull-right" onclick="send()">수정</button>
				<input type="hidden" name="bnum" value="<%=bnum %>">
			</form>
	</div></div></div>
	
	<script>
	function cencel(){
		if(confirm("페이지를 벗어나시겠습니까?")==true){
			location.replace("${ContextPath}/board/freeBoardDetail?bnum=<%=bnum%>&pagenum=<%=pagenum%>")
		}
	}
	</script>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
<script>
function viewupdate(idx){
		$("#viewupdate"+idx).hide();
		$("#repledelete"+idx).hide();
		$("#repleupdatehide"+idx).show();
	}
	
	function updatecencel(idx){
		$("#repleupdatehide"+idx).hide();
		$("#repledelete"+idx).show();
		$("#viewupdate"+idx).show();
		$("#rcontentupdate"+idx).val("");
		$("#hidetr"+idx).hide();
		$("#updatespan"+idx).hide();
	}
</script>
</body>
</html>
