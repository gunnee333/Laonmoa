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
	<div class="out">
		<div class="in">
			<!-- 본문 -->
			<table class="table" style="text-align: center; width: 500px">
				<tr>
					<td><input type="text" class="form-control" value="${list.mtitle }"
						name="mtitle" disabled="disabled" style="background-color: #fff" /></td>
				</tr>
				<tr>
					<td align="left">
						<c:choose>
							<c:when test="${list.sendid eq sessionid}">
								<b>발송쪽지</b><br>
								수신인 : ${list.recid }
							</c:when>
							<c:otherwise>
								<b>수신쪽지</b>
								<br>발송인 : ${list.sendid }
							</c:otherwise>
						</c:choose>
						<br>
						열람여부 : 
						<c:if test="${list.ifread == 0 }">
							<c:out value="미열람" />
						</c:if>
						<c:if test="${list.ifread == 1 }">
							<c:out value="열람" />
						</c:if>
						<br>
						<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd HH:mm" />
						발송일 : ${date }
					</td>
				</tr>
				<tr>
					<td><textarea class="form-control" name="mcontent" maxlength="2048" 
					style="height: 300px;"  disabled="disabled" style="background-color: #fff">${list.mcontent }</textarea></td>
				</tr>
				<tr>
					<td>
						<br>
						<!-- 확인누르면 뒤로가기 후 새로고침 -->
						<button type="button" class="btn laonmoabtn" onclick="back();">확인</button>
						<c:choose>
							<c:when test="${list.sendid eq sessionid && list.ifread == 0}">
								<button type="button" class="btn laonmoabtn" onclick="notedelete();">발송취소</button>
							</c:when>
							<c:when test="${list.recid eq sessionid}">
								<button type="button" class="btn laonmoabtn" onclick="reSend();">답장</button>
							</c:when>
						</c:choose>
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
	 function notedelete(){
		 if(confirm("삭제하시겠습니까?") == true){
			 var query = {
					 "id": "${list.sendid }",
					 "mnum": "${list.mnum }"
			 }
			 
			 $.ajax({
				 type: "post",
				 url: "${ContextPath }/mypage/notedelete",
				 data: query,
				 success: function(data){
					 alert("삭제되었습니다.");
					 location.href = document.referrer;
				 },
				 error: function(data){
					 alert("알 수 없는 오류가 발생했습니다.");
				 }
			 }); //ajax end
		 }
	 }
	 
	 function back(){
		 var referrerUrl = document.referrer;
		 var cut = referrerUrl.match("noteSend");
		 
		 if(cut != "noteSend"){
			 location.href = referrerUrl;
		 } else {
			 location.href = "${ContextPath}/mypage/noteList?pagenum=1&num=1";
		 }
	 }
	 
	 function reSend(){
		 var recid = "${list.sendid }";
		 location.href="${ContextPath }/mypage/noteSend?recid=" + recid;
	 }
	</script>
</body>
</html>
