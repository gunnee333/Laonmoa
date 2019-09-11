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
select {
	border: 1px solid #ccc;
	height: 35px;
	width: 250px;
	color: #555;
	border-radius: .25rem;
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
	width: 250px;
	height: 117px;
}
#modalClose {
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
</head>
<!-- JavaScript Libraries -->
<%@ include file="../include/plugin_js.jsp"%>
<body>

	<!--/ Carousel Star /-->
	<section class="intro-single" style="padding-top: 10px;">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-8">
					<div class="title-single-box">
						<h1 class="title-single">신고하기</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Carousel end /-->

	<table style="margin: 0 auto;">
		<tr valign="top">
			<td width="80px">신고할 글</td>
			<td width="250px"><input type="text" readonly="readonly"
				value="${title}" class="form-control"
				style="background-color: #ffffff"></td>
		</tr>
		<tr valign="top">
			<td>신고 사유</td>
			<td>
				<div class="selectBox02">
					<select name="search_warn">
						<option value="">사유를 선택해주세요</option>
						<option value="비속어">비속어</option>
						<option value="광고">광고</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</td>
		</tr>
		<tr valign="top">
			<td>상세내용</td>
			<td><textarea class="form-control" style="height: 100px;"
					maxlength="100" id="wcontent" name="wcontent"></textarea></td>
		</tr>
		<tr align="center">
			<td colspan="2"><br>
				<button type="button" class="btn laonmoabtn" id="go_warn"
					onclick="start();">신고하기</button>
				<button type="button" class="btn laonmoabtn"
					onclick="window.close();">취소</button></td>
		</tr>
	</table>
	<input type="hidden" name="warid" value="${warid }">
	<input type="hidden" name="whoid"
		value="<%=request.getParameter("whoid")%>">
	<input type="hidden" name="wlevel"
		value="<%=request.getParameter("level")%>">
	<input type="hidden" name="ww_num"
		value="<%=request.getParameter("num")%>">
	<input type="hidden" name="wcontent"
		value="<%=request.getParameter("wcontent")%>">


	<!-- 모달창 -->
	<div id="modal">
		<h5><span name="modalspan"></span></h5><br>
		<button class="btn laonmoabtn" name="modalclose" onclick="modalclose();">닫기</button>
		<button class="btn laonmoabtn" name="windowclose" onclick="window.close();" style="display: none;">닫기</button>
	</div>
	<!-- 모달 end -->

	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js" ></script>
	<script>
		function start(){
			if(checkit()){
				var query = {
					"warid" : $('input[name=warid]').val(),
					"whoid" : $('input[name=whoid]').val(),
					"search" : $('select[name=search_warn]').val(),
					"level" : $('input[name=wlevel]').val(),
					"num" : $('input[name=ww_num]').val(),
					"wcontent" : $('textarea[name=wcontent]').val()
				}
				$.ajax({
					type : "get",
					data : query,
					url : "${ContextPath}/board/war",
					success : function(data){
						if(data >= 1){
							$('span[name=modalspan]').text("신고되었습니다.").show();
							$("button[name=modalclose]").hide();
							$("button[name=windowclose]").show();
							modalopen();
						}else{
							alert("실패");
						}
					}
				});
			}
		}
		
		function checkit(){
			var search = $('select[name=search_warn]').val();
			var wcontent = $('textarea[name=wcontent]').val();
			
			if(search == "" || search == null || search == "null"){
				$('span[name=modalspan]').text("신고 사유을 선택해주세요.").show();
				modalopen();
				return false;
			} if(wcontent == "" || wcontent == null || wcontent == "null"){
				$('span[name=modalspan]').text("신고 내용을 입력해주세요.").show();
				modalopen();
				return false;
			}
			return true;
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
	</script>

</body>
</html>

