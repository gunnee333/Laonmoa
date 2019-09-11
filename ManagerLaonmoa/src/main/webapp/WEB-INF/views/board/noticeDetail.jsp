<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
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
			<h3 class="title_h3">공지사항 상세보기</h3>
			<a onclick="back();" class="list_style btn laonmoabtn btn_list">목록</a>
			<form method="post" action="${ContextPath }/admin/board/noticeDetail">

				<table class="board_table">
					<tr>
						<td class="td_style td1_style">${view.title}</td>
						<td class="td_style td2_style">
									<c:if test="${view.level == 3 }">
										<c:out value="자유게시판" />
									</c:if> 
									<c:if test="${view.level == 4 }">
										<c:out value="리뷰게시판" />
									</c:if>
						</td>
					</tr>
					<tr>
						<td class="td_style td1_style">${view.id}</td>
						<td class="td_style td2_style">
							<fmt:formatDate var="date" value="${view.date}" pattern="yyyy-MM-dd" />
									${date }</td>
					</tr>
					<tr>
						<td colspan="2" class="board_textarea" style="border-top: 0.5px solid #f0f0f0; vertical-align: top;">${view.content}
						</td>
					</tr>
				</table>



				<div class="btn_two">
					<a href="${ContextPath }/admin/board/noticeChange?bnum=${view.bnum}" class="btn laonmoabtn">수정</a> 
					<a onclick="modalopen();" class="btn laonmoabtn">삭제</a> 
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
					url : "${ContextPath }/admin/board/noticeDelete",
					data : query,
					success : function(data) {
						location.href = document.referrer;
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
		
		function back(){
			var referrerURL = document.referrer;
			var cut = referrerURL.match("noticeChange");
			
			if(cut != "noticeChange"){
				location.href = referrerURL;
			} else{
				location.href = "${ContextPath }/admin/board/noticeList?del=-1&num=1&level=${view.level}";
			}
		}
	</script>
</body>
</html>