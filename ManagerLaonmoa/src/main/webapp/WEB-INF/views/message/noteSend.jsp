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
<link rel="stylesheet" href="/resources/css/style2.css">
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub"><div class="out"><div class="in">
			<h3>쪽지보내기</h3><br>
			<form action="${ContextPath}/admin/insert" method="post" name="mfrm">
				<table style="width: 500px; display: inline-block;">
					<tr>
						<td style="width: 70px;">
							수신인 :
						</td>
						<td>
							<input type="text" id="id" name="recid" class="form-control"
							style="width: 390px; height: 35px; background-color: #fff;" readonly="readonly" onclick="idfindopen()" />
						</td>
						<td>
							<!-- 검색버튼 -->
							<button type="button" class="searchbutton" aria-label="Left Align" onclick="idfindopen()">
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<br><input type="text" name="mtitle" class="form-control" placeholder="쪽지제목을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<textarea name="mcontent" class="form-control" style="height: 300px;" placeholder="쪽지내용을 입력해주세요."></textarea>
						</td>
					</tr>
				</table>
				<br>
				<button id="msubmit" class="btn laonmoabtn">전송</button>
			</form>
		</div></div></div>
	</div>
	<!-- 전송시 입력값 체크하는 js -->
	<script src="/resources/js/submitCheck.js"></script>
	<script>
		// 아이디찾기 새창 띄우기
		function idfindopen() {
			window.open("${ContextPath}/idfind", "_blank",
					"width=350, height=450, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
		};
	</script>
</body>
</html>