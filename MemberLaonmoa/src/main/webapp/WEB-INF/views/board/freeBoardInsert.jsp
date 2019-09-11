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
			<form name = "form" method="post" action="${ContextPath}/board/freeBoardInsert">
				<table class="table"
					style="text-align: center;">
					<thead>
						<tr>
							<th colspan="2" style="text-align:center; font-size:25px; padding-top: 50px;">
								자유게시판 글쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="50"/></td>
						</tr>
						<tr style="display:none;" id = "stitle">
						<td style="text-align:left"><span style="color:red;">제목을 입력해주세요.</span></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" maxlength="2048" name="content" style="height: 500px;"></textarea></td>
						</tr>
						<tr style="display:none;" id = "scontent">
						<td style="text-align:left"><span style="color:red;">내용을 입력해주세요.</span></td>
						</tr>
					</tbody>
				</table>
				<a>
				<button type="button" id="cencel" class="btn laonmoabtn pull-right" onclick="back()">취소</button>
				</a>
				<button type="button" class="btn laonmoabtn pull-right" onclick="send()">글 쓰기</button>
				<input type="hidden" name = "id" value="${id}"> 
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
function send(){
	if(checkit()){
		document.form.submit();
	}
}
function back(){
		location.replace("${ContextPath}/board/freeBoardMain?pagenum=<%=pagenum%>")
}
function checkit(){
	var status = true;
	if($("input[name=title]").val() == ""){
		$("#stitle").show();
		return false;
	}
	else{
		$("#stitle").hide();
	}
	if($("textarea[name=content]").val() == ""){
		$("#scontent").show();
		return false;
	}
	else{
		$("#scontent").hide();
	}
	return status;	
}

</script>
</body>
</html>
