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
	width: 120px;
	color: #555;
}

.searchbutton {
	width: 35px;
	height: 35px;
	background-color: #FF7B22;
	border: none;
}

#modal {
	display: none;
	background-color: #FFFFFF;
	position: absolute;
	top: 300px;
	left: 200px;
	padding: 10px;
	border: 2px solid #FF7B22;
	border-radius: 0.5rem;
	z-Index: 9999;
	text-align: center;
	width: 300px;
	height: 190px;
}
</style>
</head>
<!-- JavaScript Libraries -->
<%@ include file="../include/plugin_js.jsp"%>
<body>
	<div style="margin: 0 auto; text-align: center;">
		<table>
			<tr valign="top" style="border-top: 1px solid #ccc">
				<td><select name="type">
						<option value="-1">전체선택</option>
						<option value="7">축제</option>
						<option value="8">연극</option>
						<option value="9">뮤지컬</option>
						<option value="10">전시회</option>
				</select></td>
				<td><input type="text" class="form-control" name="value"
					placeholder="축제를 검색해주세요." style="height: 35px; width: 345px; border-radius: 0%;">
				</td>
				<td>
					<button type="button" class="searchbutton"
						onclick="searchCulture();">
						<span class="fa fa-search" aria-hidden="true" style="color: #fff;"></span>
					</button>
				</td>
			</tr>
		</table>
		<br>
		<table style="width: 480px;">
			<thead>
				<tr>
					<td width="50">종류</td>
					<td>공연명</td>
					<td width="80">위치</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr>
						<td colspan="3">검색결과가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${list }" var="list">
					<tr>
						<td>
							<!-- 축제종류 --> <c:choose>
								<c:when test="${list.level eq 7 }">
									축제
								</c:when>
								<c:when test="${list.level eq 8 }">
									연극
								</c:when>
								<c:when test="${list.level eq 9 }">
									뮤지컬
								</c:when>
								<c:when test="${list.level eq 10 }">
									전시회
								</c:when>
								<c:when test="${list.level eq 15 }">
									기타
								</c:when>
							</c:choose>
						</td>
						<td><input type="hidden" name="fno" value="${list.fno}">
						<a href='javascript:festival("${list.fno}","${list.fname}","${list.level}")'>${list.fname}</a></td>
						<td>${list.location_1 }</td>
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
		<br>
		<button type="button" class="btn laonmoabtn" onclick="window.close();">닫기</button>
	</div>

	<!-- 검색내용없을 시 뜨는 모달창 -->
	<div id="modal">
		<h3>검색내용을 입력해주세요.</h3>
		<br>
		<button class="btn laonmoabtn" id="modalclosebutton">닫기</button>
	</div>
	<!-- 모달 end -->

	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js"></script>

	<script>
		var check = true;
		var url = "${ContextPath}" + window.location.pathname;	// 현재 주소(파라미터값 제외)
		
		function searchCulture(){
			var pagenum = "<%=request.getParameter("pagenum")%>";
			var type = $('select[name=type]').val();
			var value = $('input[name=value]').val();
			
			checkit();
			if(check){
				url += "?type=" + type;
				url += "&value=" + value;
				location.replace(url);
			}
		}
		
		// 검색버튼 클릭시 검색값 있는지 확인
		function checkit(){
			check = true;
			var value = $('input[name=value]').val();
			
			if(value == null || value == ""){
				modalopen();
				check = false;
			}
		}
		
		// 페이징을 위한 스크립트
		function page(idx){
			var pagenum = idx;
			var type = "<%=request.getParameter("type")%>";
			var value = "<%=request.getParameter("value")%>";
			url += "?pagenum=" + pagenum;

			// 검색조건이 있을 시 검색조건 담아줌
			if (!(type == "" || type == null || type == "null")) {
				url += "&type=" + type;
				url += "&value=" + value;
			}
			location.replace(url);
		}

		//모달창 인스턴트 생성
		var myModal = new newModal({
			id : "modal" // 모달창 아이디 지정
		});

		// 모달 창 열기
		function modalopen() {
			myModal.show();
		}

		// 모달 창 닫기
		function modalclose() {
			myModal.hide();
		}
		function festival(fno,fname,level){
			switch(level){
			case '7':
				level = "축제";
				break;
			case '8':
				level = "연극";
				break;
			case '9':
				level = "뮤지컬";
				break;
			case '10':
				level = "전시회";
				break;
			}
			$("#event", opener.document).val(level);
			$("#eventname",opener.document).val(fname);
			$("#fno",opener.document).val(fno);
			window.opener.DeleteLine("1");
			window.close();
		}
		$(document).ready(function() {
			/*부모창의 select option값 자식창에서 받기
			var selectvalue = $("#select", opener.document).val();
			$("select[name=type]").val(selectvalue);
			모달창 닫기*/
			$("#modalclosebutton").click(function() {
				modalclose();
			});
		});
	</script>
</body>
</html>