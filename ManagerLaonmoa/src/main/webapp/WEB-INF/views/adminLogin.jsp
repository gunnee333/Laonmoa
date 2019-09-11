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
<%@ include file="include/head.jsp"%>
</head>
<!-- 로그인 안될 때 주석 풀기 로그인 후 다시 주석 달아주세요. -->

<script src='{% static "js/jquery-1.11.3.min.js" %}'></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> 

 
<body>
	<%@ include file="include/Header.jsp"%>
	<div class="main">
		<div class="main_menu_in"><%@ include
				file="include/adminMenu.jsp"%></div>
		<div class="sub">
			<div style="display: inline-flex;">

				<!-- 로그인폼 -->
				<div class="box_login">
					<div class="box_in">
						<img src="/resources/img/LOGOFONT.png" class="main_img" width="200px" style="margin-bottom: 20px;">
						<div align="left">아이디</div>
						<input type="text" class="form-control" name="id" id="id"
							placeholder="아이디를 입력해주세요." onkeyup="blank(this);"> 
							<span id="idcheck" class="checkspan"></span> <br>
						<div align="left">패스워드</div>
						<input type="password" class="form-control" name="password"
							id="password" style="font-family: NanumGothic;"
							placeholder="비밀번호를 입력해주세요." onkeyup="blank(this);">
							<span id="pwcheck"
							class="checkspan"></span> <br> <span id="logincheck"
							class="checkspan"></span><br>
						<br>
						<div class="laonbtn">
							<input id="login" class="btn laonmoabtn log_in" type="submit" value="로그인" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script>
	$(document).ready(function(){
		var check = true;
		$("#login").click(function(){
			checkit();
			if(check){
				var query = {
						"id": $("input[name=id]").val(),
						"password": $("input[name=password]").val()
				};
				
				$.ajax({
					async:false,
					type: "POST",
					url: "${ContextPath}/login",
					data: query,
					success: function(data){
						if(data > 0){
							location.replace("${ContextPath}/");
						} else {
							$("#logincheck").text("아이디 또는 비밀번호가 일치하지 않습니다.").show();
						}
					}, error: function(data){
						alert("오류발생");
					}
				});
			}
		});
	});
		function checkit(){
			check = true;
			var id = $("input[name=id]").val();
			var password = $("input[name=password]").val();
			
			if(id == ""){
				$("#idcheck").text("아이디를 입력해주세요.").show();
				check = false;
			} 
			if(password == ""){
				$("#logincheck").text("비밀번호를 입력해주세요.").show();
				check = false;
			}
		};
	
</script>
</html>