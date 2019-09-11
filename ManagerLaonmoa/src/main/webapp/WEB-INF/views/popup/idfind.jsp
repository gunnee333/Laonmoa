<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<!-- 부트스트랩적용 -->
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
<script src="/resources/jQuery/jquery-3.4.1.min.js"></script>
<script src="/resources/bootstrap/js/bootstrap.min.js"></script>
<!-- JavaScript Libraries -->
<script src="/resources/lib/popper/popper.min.js"></script>
<script src="/resources/lib/bootstrap/js/bootstrap.min.js"></script>
<script src="/resources/lib/easing/easing.min.js"></script>
<script src="/resources/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/resources/lib/scrollreveal/scrollreveal.min.js"></script>
<!-- Contact Form JavaScript File -->
<script src="/resources/contactform/contactform.js"></script>
<!-- Template Main Javascript File -->
<script src="/resources/js/main.js"></script>
<link rel="stylesheet" href="/resources/css/style.css">
<link rel="stylesheet" href="/resources/css/style2.css">
<style>
td {
	border-bottom: 1px solid #ccc;
}

select {
	border: 1px solid #ccc;
	height: 35px;
	width: 115px;
	color: #555;
}
.searchbutton {
	width: 35px;
	height: 35px;
	background-color: #FF7B22;
	border: none;
}
</style>
</head>
<body>
	<div style="margin: 0 auto; text-align: center;">
		<!-- 검색 테이블 -->
		<table>
			<tr valign="top" style="border-top: 1px solid #ccc">
				<td><input type="text" value="아이디" readonly="readonly" style="width: 115px; height: 35px;" /></td>
				<td><input type="text" class="form-control" id="recid" name="recid"
					placeholder="아이디를 입력해주세요." style="height: 35px; width: 200px; border-radius: 0%">
				</td>
				<td>
					<button type="button" class="searchbutton" id="idsubmit">
						<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
				</td>
			</tr>
		</table>
		<span id="checkspan" style="color: red;"></span><br>
		<br>
		<table style="width: 350px;">
			<thead>
				<tr>
					<td>아이디</td>
					<td>이름</td>
					<td>회원종류</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan="6">회원이 존재하지 않습니다</td>
						</tr>
					</c:when>
				</c:choose>
				<c:forEach var="list" items="${list }">
					<tr>
						<td><a onclick="idchoice('${list.id}')" id="listid">${list.id}</a></td>
						<td>${list.name }</td>
						<td>
							<c:if test="${list.level == 11 }">
								<c:out value="일반회원" />
							</c:if>
							<c:if test="${list.level == 2 }">
								<c:out value="블랙회원" />
							</c:if>
							<c:if test="${list.level == 1 }">
								<c:out value="관리자" />
							</c:if>
						</td>
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
				<c:forEach begin="${page.getStartpage()}" end="${page.getEndpage()}"
					var="idx">
					<li><a href="javascript:page(${idx})">${idx}</a></li>
				</c:forEach>
				<c:if test="${page.next }">
					<li><a href="javascript:page(${page.getEndpage()+1})"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>
		<button type="button" class="btn laonmoabtn" onclick="window.close();">닫기</button>
	</div>
	
	<script>
		$(document).ready(function(){
			$("#idsubmit").click(function() {
				if ($("#recid").val() == "" || $("#recid").val() == null) {
					$("#checkspan").text("검색하실 id를 입력해주세요.").show();
					return false;
				} else{
					$("#checkspan").hide();
					url = "${ContextPath}/idfind?value=" + $("#recid").val();
					location.replace(url);
				}
			});
		});
		
		// 아이디 선택시 부모창에 id="id" 의 value 를 선택한 아이디로 바꿔줌
		function idchoice(idvalue){
			window.opener.document.getElementById("id").value = idvalue;
			window.close();
		}
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var value = "<%=request.getParameter("value") %>";
			
			var url = "${ContextPath}/idfind?pagenum=" + pagenum;
			
			// 검색조건이 있을 시 검색조건 담아줌
			if(!(value == "" || value == null || value == "null")){
				url += "&value=" + value;
			}
			
			location.replace(url);
		}
	</script>
</body>
</html>