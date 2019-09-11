<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
</head>
<style>
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
	width: 250px;
	height: 117px;
}
</style>
<body>
	<%@ include file="../include/Header.jsp"%>

	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<h3 class="title_h3">자유게시글 상세보기</h3>
			<a onclick="back();"
				class="btn laonmoabtn btn_list">목록</a>
			<form method="post" action="/admin/board/freeBoardDetail">
				<table class="board_table">
					<tr>
						<td class="td_style td1_style">${view.title}</td>
						<td class="td_style td2_style">자유게시판</td>
					</tr>
					<tr>
						<td class="td_style td1_style">${view.id}</td>
						<td class="td_style td2_style"><fmt:formatDate var="date" value="${view.date}" pattern="yyyy-MM-dd" />
									${date }</td>
					</tr>
					<tr>
						<td colspan="2"><textarea class="board_textarea" name="content"
								readonly="readonly">${view.content}</textarea></td>
					</tr>
				</table>
				<div class="btn_margin">
					<a href="/admin/board/freeBoardChange?bnum=${view.bnum}"
						class="btn laonmoabtn">수정</a> 
						<a onclick="modalopen();" class="btn laonmoabtn">삭제</a> <a
						href="/admin/board/freeBoardInsert" class="btn laonmoabtn">글쓰기</a>
				</div>
			</form>
		</div>
	</div>
	
		<!-- 모달창 -->
	<div id="modal">
		<h5>
			<span name="modalspan">삭제하시겠습니까?</span>
		</h5>
		<br>
		<button class="btn laonmoabtn" id="confirm_button">확인</button>
		<button class="btn laonmoabtn" onclick="modalclose();">취소</button>
	</div>
	<!-- 모달 end -->
	
	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js"></script>
	<script>
		$(document).ready(function(){
			// 모달창의 확인버튼 누르면 글삭제.
			$("#confirm_button").click(function() {
				var query = {
					"bnum" : "${view.bnum}",
				}
	
				$.ajax({
					type : "POST",
					url : "/admin/board/freeBoardDelete",
					data : query,
					success : function(data) {
						location.replace("${ContextPath}/admin/board/noticeList?del=-1&num=1&level=3");
					},
					error : function(data) {
						alert("알 수 없는 에러가 발생하였습니다.");
					}
				});
				myModal.hide(); // 모달창 감추기     
			});
		});
	
		//모달창 인스턴트 생성
		var myModal = new newModal({
			id : "modal" // 모달창 아이디 지정
		});
	
		// 모달 창 열기
		function modalopen() {
			$('input[name=password]').val("");
			myModal.show();
		}
	
		// 모달 창 닫기
		function modalclose() {
			myModal.hide();
		}
		
		// 목록버튼 클릭시
		function back(){
			var referrerUrl = document.referrer;
			var cut = referrerUrl.match("freeBoardList");
			
			// 이전주소가 자유게시판 리스트였을 경우, 이전페이지로 이동/ 아닐경우 자유게시판 1페이지로 이동
			if(cut == "freeBoardList"){
				location.href = referrerUrl;
			} else{
				location.href = "/admin/board/freeBoardList?del=-1&num=1";
			}
		}
	</script>
	
</body>
</html>