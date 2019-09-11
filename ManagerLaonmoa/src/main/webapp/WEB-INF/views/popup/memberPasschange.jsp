<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../../resources/jQuery/jquery-3.4.1.min.js"></script>
<style>
	span{
		color:red;
	}
</style>
</head>
<body>
<h3>비밀번호 변경</h3>
<div>
	<input type="hidden" id = "hidden" value="<%=request.getParameter("id") %>">
	<table>
		<tr>
		<td>비밀번호 변경</td>
		<td><input type="password" id=pass placeholder="비밀번호를 변경해주세요."></td>
		</tr>
		<tr>
		<td colspan="2"><span id="pass1"></span></td>
		</tr>
		<tr>
		<td>비밀번호 재확인</td>
		<td><input type="password" id=repass placeholder="비밀번호를 변경해주세요."></td>
		</tr>
		<tr>
		<td colspan="2"><span id="pass2"></span></td>
		</tr>
		<tr>
		<td><input type="button" id=send value="변경">
		<input type="button" id=cencel value="취소">
		<input type="hidden" id="success" value="change">
		</td>
		</tr>
	</table>
</div>
<script>
$(document).ready(function(){
	$("#cencel").click(function(){
		window.close();
	});
	$("#pass").click(function(){
		$(this).blur(function(){
			if($("#pass").val()==""){
				$("#pass1").text("비밀번호를 입력해주세요.").show();
			}
		});
	});
	$("#repass").click(function(){
		$(this).blur(function(){
			if($("#repass").val()==""){
				$("#pass2").text("비밀번호를 입력해주세요.").show();
			}
		});
	});
	$("#send").click(function(){
		if($("#pass").val() != $("#repass").val()){
			$("#pass2").text("비밀번호가 일치하지않습니다.").show();
		}
		else{
		var query={
					"id":$("#hidden").val(),
					"password":$("#pass").val()
		}
		$.ajax({
			type:"post",
			url:"${ContextPath}/admin/memberPasschange",
			data: query,
			success:function(data){
				opener.document.getElementById("success").value=document.getElementById("success").value;
				window.close();
			},
			error:function(data){
				alert("비밀번호 수정에 실패하였습니다.");
			}
		});
		}
	});
});
</script>
</body>
</html>