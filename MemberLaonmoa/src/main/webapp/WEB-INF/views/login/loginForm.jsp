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
join_img {
	text-align: center;
}
.intro-single-logo {
	padding: 11vw 44vw 0vw;
}
laonbtn {
	margin-left: auto;
	margin-right: auto;
}
.offset-md-4{
margin-left: 37.333333% !important;
}
.form-control {
	border-radius: 0px !important;
}
.form-control:focus {
	border-color: #FF7B22;
	box-shadow: none;
}

</style>
</head>
<body>
	<!--/ Intro Single star /-->
	<section class="intro-single-logo">
		<div class="container">
			<div class="row">
				<div class="join_img">
					<img src="http://hoohee0331.cdn3.cafe24.com/img/LOGOFONT.png" width="200px">
				</div>

			</div>
		</div>
	</section>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Carousel Star /-->
	<section class="news-single nav-arrow-b">
		<div class="container">
			<div class="row">
				<div class="col-md-11 offset-md-4 col-lg-8 offset-lg-4">
					<br>
					<br>
					<!-- 로그인폼 -->
					<div
						style="width: 250px; display: inline-block; padding-top: 10px;">
						<div align="left">아이디</div>
						<input type="text" class="form-control" name="id" id="id"
							placeholder="아이디를 입력해주세요." onkeyup="blank(this);"> <span id="idcheck"
							class="checkspan"></span> <br>
						<div align="left">패스워드</div>
						<input type="password" class="form-control" name="password"
							id="password" style="font-family: NanumGothic;"
							placeholder="비밀번호를 입력해주세요." onkeyup="blank(this);"> 
							<span id="pwcheck" class="checkspan"></span> <br>
						<span id="logincheck" class="checkspan"></span><br><br>
						<div class="laonbtn">
							<button type="button" class="btn laonmoabtn" id="loginbtn" style="width: 120px;margin-right: 3px;">로그인</button>
							<button type="button" class="btn laonmoabtn" id="findIdPwbtn" style="width:120px;">ID/PW찾기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
	<script>

		var check = true;
		var idReg = /[A-Za-z0-9]/;
		var text = $('#id').val().replace(/ /gi, '');

		$(document).ready(function() {
			 
			$("#loginbtn").click(function() {
				checkit();
				if (check) {
					var query = {
							"id": $("input[name=id]").val(),
							"password": $("input[name=password]").val()
					}
					
					$.ajax({
						type: "POST",
						url: "${ContextPath}/login",
						data: query,
						success: function(data){
							if(data == "success"){
								location.replace("${ContextPath}/");
							} else{
								$("#logincheck").text("아이디 또는 비밀번호가 일치하지 않습니다.").show();
							}
						},
						error: function(data){
							alert("알 수 없는 오류가 발생했습니다.");
						}
					});
					
					document.loginfrm.action = "${ContextPath}/login";
					document.loginfrm.submit();
				}
			});

			$("#findIdPwbtn").click(function() {
				location.replace("${ContextPath}/findIdPw");
			});
	     
		});
		 $("#password").keydown(function(key) {
             if (key.keyCode == 13) {
            	 var query = {
							"id": $("input[name=id]").val(),
							"password": $("input[name=password]").val()
					}
					
					$.ajax({
						type: "POST",
						url: "${ContextPath}/login",
						data: query,
						success: function(data){
							if(data == "success"){
								location.replace("/");
							} else{
								$("#logincheck").text("아이디 또는 비밀번호가 일치하지 않습니다.").show();
							}
						},
						error: function(data){
							alert("알 수 없는 오류가 발생했습니다.");
						}
					});
					
					document.loginfrm.action = "/login";
					document.loginfrm.submit();
             }})
			

		//띄어쓰기 막음
		function blank(obj){
	        var a = $('#id').val().replace(/ /gi, '');
	        $('#id').val(a);
	        var a = $('#password').val().replace(/ /gi, '');
	        $('#password').val(a);
	       	    }
		function checkit() {
			check = true;
			var loginid = $('input[name=id]').val();
			var loginpw = $('input[name=password]').val();
			var text = $('#id').val().replace(/ /gi, '');
			$("#logincheck").hide();
			
			if (loginid == null || loginid == "") {
				$("#idcheck").text("아이디를 입력해주세요.").show();
				check = false;
			} else if (!idReg.test(loginid)) {
				$("#idcheck").text("아이디는 영문자와 숫자로만 입력해주세요.").show();
				check = false;
			} else {
				$("#idcheck").text("").hide();
			} if (loginpw == null || loginpw == "") {
				$("#pwcheck").text("패스워드를 입력해주세요.").show();
				check = false;
			} else if (!idReg.test(loginpw)) {
				$("#pwcheck").text("패스워드는 영문자와 숫자로만 입력해주세요.").show();
				check = false;
			} else {
				$("#pwcheck").text("").hide();
			}
		}
	

	</script>
</body>
</html>
