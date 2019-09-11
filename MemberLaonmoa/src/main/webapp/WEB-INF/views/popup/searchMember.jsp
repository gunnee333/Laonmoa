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
<link rel="stylesheet" href="/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/bootstrap/css/bootstrap-theme.min.css">
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
	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
</head>
<body>
	<input type="hidden" id="type" value="${type }">
	<input type="hidden" id="value" value="${value }">
	<div style="margin: 0 auto; text-align: center;">
		<table>
			<tr valign="top" style="border-top: 1px solid #ccc">
				<td><select name="type">
						<option value = "all">전체선택</option>
						<option value = "id">아이디</option>
						<option value = "name">이름</option>
						<option value = "email">이메일</option>
				</select></td>
				<td><input type="text" class="form-control" name="value"
					placeholder="검색내용을 입력해주세요." style="height: 35px; width: 200px; border-radius: 0%">
				</td>
				<td>
					<button type="button" class="searchbutton" onclick="search();">
						<span class="fa fa-search" aria-hidden="true" style="color: #fff;"></span>
					</button>
				</td>
			</tr>
		</table>
		<br>
		<table style="width: 350px;">
			<thead>
				<tr>
					<td>아이디</td>
					<td>이름</td>
					<td>이메일</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty list }">
						<tr>
							<td colspan="3">회원이 존재하지 않습니다.</td>
						</tr>
					</c:when>
				</c:choose>
				<c:forEach var="list" items="${list }">
					<tr>
						<td><a onclick="choiceId('${list.id }');">${list.id }</a></td>
						<td><a onclick="choiceId('${list.id }');">${list.name }</a></td>
						<td><a onclick="choiceId('${list.id }');">${list.email }</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<br>
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
		// select 기본값 설정
		$(".selectBox02 select").change(function() {
			var changeTxt = $(this).find("option:selected").text();
			$(this).parent().find(".txt").text(changeTxt);
		});
		$(".selectBox02 select").focus(function() {
			$(this).parent().addClass("focus");
		});
		$(".selectBox02 select").blur(function() {
			$(this).parent().removeClass("focus");
		});
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			// input hidden에 담긴 검색조건 가져오기
			var type = $("#type").val();
			var value = $("#value").val();
			
			var url = "${ContextPath}/mypage/searchMember?pagenum=" + pagenum;
			
			// 검색조건 없을 때 검색조건,검색값 안보내기
			if(type != "null"){
				url += "&type=" + type + "&value=" + value;
			}
			location.href = url;
		}
		
		// 검색버튼 onclick
		function search(){
			// 주소에 실어보낼 검색조건
			var type = $('select[name=type]').val();
			var value = $('input[name=value]').val();
			
			var url = "${ContextPath}/mypage/searchMember?pagenum=1";
			
			// 검색조건 없을 때 검색조건,검색값 안보내기
			if(type != "null"){
				url += "&type=" + type + "&value=" + value;
			}
			location.href = url;
		}
		
		// 아이디 선택시 오픈한 창에 저장 후 새창종료
		function choiceId(choiceId){
			window.opener.document.getElementById("recid").value = choiceId;
			window.close();
		}
	</script>
</body>
</html>