<%@page import="javax.swing.text.Document"%>
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
<style>
.form-control {
	width: 300px;
	font-family: NanumGothic;
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
	height: 150px;
}
</style>
</head>
<!-- JavaScript Libraries -->
<%@ include file="../include/plugin_js.jsp"%>
<body>

	<!--/ Carousel Star /-->
	<section class="intro-single" style="padding-top: 10px; padding-bottom: 2rem;">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-8">
					<div class="title-single-box">
						<h1 class="title-single">비밀번호변경</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Carousel end /-->
	<div style="width: 300px; margin: 0 auto; text-align: center;">
		<input type="hidden" name = "id">
		<div align="left">현재 비밀번호</div>
		<input type="password" class="form-control" name="password" placeholder="비밀번호를 입력해주세요." onkeyup="blank(this);">
		<span id="passcheck" class="checkspan"></span><br>
		<div align="left">비밀번호</div>
		<input type="password" class="form-control" name="newPassword" placeholder="비밀번호를 입력해주세요." onkeyup="blank(this);">
		<span id="pass1check" class="checkspan"></span><br>
		<div align="left">비밀번호 확인</div>
		<input type="password" class="form-control" name="newPassword2" placeholder="비밀번호를 재입력해주세요." onkeyup="blank(this);">
		<span id="pass2check" class="checkspan"></span><br><br>
		<button type="button" class="btn laonmoabtn" id="submit">확인</button>
		<button type="button" class="btn laonmoabtn" onclick="window.close();">취소</button>
	</div>

	<!-- 비밀번호변경성공 모달창 -->
	<div id="modal">
		<br><h5>비밀번호가 변경되었습니다.</h5><br>
		<button class="btn laonmoabtn" onclick="window.close();">닫기</button>
	</div>
	<!-- 모달 end -->

	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js" ></script>
	<script>
		var check = true;
		$(document).ready(function() {
			// 부모창의 아이디값 받아오기
			$('input[name=id]').val(opener.document.getElementById("id").value);
			
			// 전송버튼 클릭 시
			$("#submit").click(function() {
				checkit();
				if (check) {
					var query = {
							"id": $('input[name=id]').val(),
							"password": $('input[name=password]').val(),
							"newpassword": $('input[name=newPassword]').val()
					}
					
					$.ajax({
						type: "post",
						url: "${ContextPath}/mypage/changePw",
						data: query,
						success: function(data){
							if(data == 1){
								// 비밀번호 변경 성공
								$("#passcheck").text("").hide();
								modalopen();
							} else{
								$("#passcheck").text("비밀번호가 일치하지 않습니다.").show();
							}
						},
						error: function(data){
							alert("알 수 없는 오류가 발생했습니다.")
						}
					});	// ajax end
				}
			});
		});

		function checkit() {
			check = true;
			var password = $('input[name=password]').val();
			var newPassword = $('input[name=newPassword]').val();
			var newPassword2 = $('input[name=newPassword2]').val();
			if (password == "" || password == null) {
				$("#passcheck").text("비밀번호를 입력해주세요.").show();
				check = false;
			} else {
				$("#passcheck").text("").show();
			}
			if (newPassword == "" || newPassword == null) {
				$("#pass1check").text("비밀번호를 입력해주세요.").show();
				check = false;
			} else if(password == newPassword){
				$("#pass1check").text("동일한 비밀번호로는 변경이 불가능합니다.").show();
				$("#pass2check").text("").show();
				check = false;
			} else {
				$("#pass1check").text("").show();
			}
			if (newPassword != newPassword2) {
				$("#pass2check").text("비밀번호가 일치하지 않습니다.").show();
				check = false;
			} else {
				$("#pass2check").text("").show();
			}
		}
		
		//모달창 인스턴트 생성
		var myModal = new newModal({
			id : "modal" // 모달창 아이디 지정
		});

		// 모달 창 열기
		function modalopen(){
			$('input[name=password]').val("");
			myModal.show();
		}

		// 모달 창 닫기
		function modalclose(){
			myModal.hide();
		}
		
		// 공백제거
		function blank(obj){
			obj.value = obj.value.replace(/ /gi,'');
		}
	</script>
</body>
</html>