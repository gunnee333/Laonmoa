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
<link href="/resources/css/nav-tabs.css" rel="stylesheet">
<style>
.searchbutton {
	width: 38px;
	height: 38px;
	background-color: #FF7B22;
	border: none;
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
			<li role="presentation"><a href="${ContextPath}/mypage/myinfo">내정보</a></li>
			<li role="presentation"><a href="${ContextPath}/mypage/myReview?pagenum=1">내가 쓴 게시글</a></li>
			<li role="presentation" class="active"><a href="${ContextPath}/mypage/mynote">쪽지보관함</a></li>
		</ul>
	</div>
	<div class="out">
		<div class="in">
			<!-- 본문 -->
			<form action="${ContextPath }/mypage/noteSend" method="post" name="mfrm">
				<table class="table" style="text-align: center; width: 500px">
					<thead>
						<tr>
							<th colspan="2" style="text-align: center; font-size: 20px;">
								쪽지보내기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="수신인" name="recid" value="${recid }"
								id="recid" style="width: 430px; display: inline-block; background-color: #fff;"
								readonly="readonly" onclick="searchMemberOpen();" />
								<button type="button" class="searchbutton" onclick="searchMemberOpen();">
									<span class="fa fa-search" aria-hidden="true" style="color: #fff;"></span>
								</button>
						</tr>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="쪽지제목" name="mtitle" maxlength="20" /></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="mcontent" maxlength="2048" style="height: 300px;"></textarea></td>
						</tr>
						<tr>
							<td id="hidetd" hidden="">
								<span class="checkspan" id="checkspan"></span>
							</td>
						</tr>
						<tr>
							<td>
								<br>
								<button type="button" class="btn laonmoabtn" onclick="noteSend();">보내기</button>
								<button type="button" class="btn laonmoabtn" onclick="location.replace('${ContextPath}/mypage/mynote')">취소</button>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
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
		// 수신인 찾는 새창오픈
		function searchMemberOpen(){
			window.open("${ContextPath}/mypage/searchMember", "_blank",
			"width=350, height=400, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
		}
		
		// 쪽지보내기버튼 클릭시 폼 submit
		var check = true;
		function noteSend(){
			checkit();
			if(check){
				document.mfrm.submit();
			}
		}
		
		// 쪽지보내기 전 입력값 다 있는지 확인
		function checkit(){
			check = true;
			var recid = $('input[name=recid]').val();
			var mtitle = $('input[name=mtitle]').val();
			var mcontent = $('textarea[name=mcontent]').val();
			
			if(recid == null || recid == ""){
				$("#hidetd").attr("hidden", false);
				$("#checkspan").text("수신인을 입력해주세요.");
				check = false;
				return false;
			} else if(mtitle == null || mtitle == ""){
				$("#hidetd").attr("hidden", false);
				$("#checkspan").text("제목을 입력해주세요.");
				check = false;
				return false;
			} else if(mcontent == null || mcontent == ""){
				$("#hidetd").attr("hidden", false);
				$("#checkspan").text("내용을 입력해주세요.");
				check = false;
				return false;
			} else{
				$("#hidetd").attr("hidden", true);
				$("#checkspan").text("").hide();
			}
		}
	</script>
</body>
</html>
