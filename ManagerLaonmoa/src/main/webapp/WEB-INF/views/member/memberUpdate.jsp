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
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- jQuery UI 라이브러리 js파일 -->
<script src="/resources/jQuery/jquery-ui.min.js"></script>
<!-- jQuery UI CSS파일  -->
<link rel="stylesheet" href="/resources/jQuery/jquery-ui.css" type="text/css" />
<style>
.none{
	display:none;
	color:red;
}
.buttonleft{
	text-align:left;
}
</style>
</head>
<%String id = request.getParameter("id");%>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub"><div class="out"><div class="in">
			<h3>회원정보수정</h3><br>
			<div>
				<table class="table_style">
					<tr class="td_style">
						<td width="200px">아이디</td>
						<td>${info.id }<input type="hidden" id="id"
							value="${info.id }">
						</td>
						<td width="200px"></td>
					</tr>
					<tr class="td_style">
						<td>비밀번호</td>
						<td><input type="button" id="password" value="비밀번호 변경"
							onclick="winopen();" class="btn laonmoabtn"></td>
						<td><span id="pspan" style="color: red;"></span></td>
					</tr>
					<tr class="td_style">
						<td>이름</td>
						<td><input type="text" id="name" value="${info.name}" class="form-control">
						</td>
						<td style="text-align: right"><span
							class="none" id="sname">이름을 입력해주세요.</span></td>
					</tr>
					<tr class="td_style">
						<td>생년월일</td>
						<td><input type="text" id="age" value="${info.age}" class="form-control"
							readonly="readonly" style="background-color: #fff;">
						</td>
						<td style="text-align: right"><span
							class="none" id="sage"></span></td>
					</tr>
					<tr class="td_style">
						<td>이메일</td>
						<td><input type="email" id="email" value="${info.email}" class="form-control"><br>
						<span class="none" id="semail"></span>
						</td>
						<td class="buttonleft">
							<button type="button" onclick="emailcheck();" class="btn laonmoabtn">중복체크</button> <input
							type="hidden" value="check" id="check">
						</td>
					</tr>
					<tr>
						<td colspan="3" style="text-align: right"><span
							class="none" id="semail"></span></td>
					</tr>
					<tr class="td_style">
						<td>전화번호</td>
						<td><input type="text" id="tel" value="${info.tel}" class="form-control">
						</td>
						<td style="text-align: right"><span
							class="none" id="stel"></span></td>
					</tr>
					<tr class="td_style">
						<td>주소</td>
						<td>
							<input type="text" id="address_1" value="${info.address_1}" readonly="readonly" 
							class="form-control" style="background-color: #fff;">
							<input type="text" id="address_2" value="${info.address_2}" class="form-control">
							<input type="hidden" id="zipcode">
						</td>
						<td style="text-align: right"><span
							class="none" id="saddress"></span></td>
					</tr>
					<tr class="td_style">
						<td>블랙리스트</td>
						<td><span id="blackspan"></span></td>
						<td class="buttonleft">
							<button value="${info.level}" id="bbtn" class="btn laonmoabtn">변경</button>
						</td>
					</tr>
					<tr class="td_style">
						<td>탈퇴여부</td>
						<td><span id="secessionspan"></span></td>
						<td class="buttonleft">
							<button value="${info.secession }" id="sbtn" class="btn laonmoabtn">변경</button>
						</td>
					</tr>
					<tr class="td_style">
						<td>관리자여부</td>
						<td><span id="adminspan"></span></td>
						<td class="buttonleft">
							<button value="${info.level }" id="abtn" class="btn laonmoabtn">변경</button>
						</td>
					</tr>
					<tr class="td_style">
						<td colspan="3"><span id="war" style="color: red;"></span></td>
					</tr>
				</table>
				<br>
				<input type="button" value="회원정보 수정" id="send" class="btn laonmoabtn"> 
				<input type="button" value="취소" onclick="back()" class="btn laonmoabtn">
				<input type="hidden" value=<%=request.getParameter("pagenum") %> id="pagenum">
				<input type="hidden" value=<%=request.getParameter("max") %> id="max">
				<input type="hidden" value=<%=request.getParameter("level") %> id="level">
				<input type="hidden" value="" id="success">
			</div>
		</div>
	</div></div></div>
	
<script>
	$(document).ready(function(){
		if($("#bbtn").val()==2){
			$("#blackspan").text("블랙리스트").show();
			$("#adminspan").text("회원").show();
		}
		else if($("#bbtn").val()==11){
			$("#blackspan").text("일반회원").show();
			$("#adminspan").text("회원").show();
		}
		else if($("#bbtn").val()==1){
			$("#blackspan").hide();
			$("#adminspan").text("관리자").show();
		}
		if($("#sbtn").val()==0){
			$("#secessionspan").text("사용중인 회원").show();
		}
		else if($("#sbtn").val()==1){
			$("#secessionspan").text("탈퇴한 회원").show();
		}
		$("#bbtn").click(function(){
			if($("#bbtn").val()==2){
				$("#bbtn").val(11);
				$("#abtn").val(11);
				$("#blackspan").text("일반회원").show();
			}
			else if($("#bbtn").val()==11){
				$("#bbtn").val(2);
				$("#abtn").val(2);
				$("#blackspan").text("블랙리스트").show();
			}
			else if($("#bbtn").val()==1){
				$("#war").text("현재 관리자입니다. 관리자를 해제해주세요.").show();
			}
		});
		$("#sbtn").click(function(){
			if($("#sbtn").val()==0){
				$("#sbtn").val(1);
				$("#secessionspan").text("탈퇴한 회원").show();
			}
			else if($("#sbtn").val()==1){
				$("#sbtn").val(0);
				$("#secessionspan").text("사용중인 회원").show();
			}
		});
		$("#abtn").click(function(){
			if($("#abtn").val()==1){
				$("#abtn").val(11);
				$("#bbtn").val(11);
				$("#adminspan").text("회원").show();
				$("#blackspan").text("일반회원").show();
				$("#war").hide();
			}
			else if($("#abtn").val()==2){
				$("#abtn").val(1);
				$("#bbtn").val(1);
				$("#adminspan").text("관리자").show();
				$("#blackspan").hide();
			}
			else if($("#abtn").val()==11){
				$("#abtn").val(1);
				$("#bbtn").val(1);
				$("#adminspan").text("관리자").show();
				$("#blackspan").hide();
			}
		});
		
		//회원정보 수정
		$("#send").click(function(){
			if(checkit()){
				var query={
					"id":$("#id").val(),
					"name":$("#name").val(),
					"email":$("#email").val(),
					"tel":$("#tel").val(),
					"age":$("#age").val(),
					"address_1":$("#address_1").val(),
					"address_2":$("#address_2").val(),
					"zipcode":$("#zipcode").val(),
					"level":$("#bbtn").val(),
					"secession":$("#sbtn").val()
				}
				
				$.ajax({
					type:"get",
					url:"${ContextPath}/admin/memberUpdater",
					data:query,
					success:function(data){
						location.replace("${ContextPath}/admin/memberView?id="+$("#id").val()+"&pagenum="+$("#pagenum").val()
								+"&level="+$("#bbtn").val());
					},
					error:function(data){
						alert("에러");
					}
				});
			}
		});
		
		// 주소 클릭시 주소검색팝업띄우기
		$("#address_1").click(function(){
			sample6_execDaumPostcode();
		});
		
		// 생년월일 클릭시 데이터피커 띄우기
		$(function() {
			$("#age").datepicker({
				dateFormat: 'yymmdd',
				changeMonth: true,	//월변경가능
				changeYear: true,	//년변경가능
				nextText: '다음 달',
				prevText: '이전 달',
				monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				showAnim: "slideDown", //애니메이션을 적용한다
				// 연도 셀렉트 박스 범위(현재연도의 - 100연도)
				maxDate: "D", //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
				yearRange: "-100:+0"	//보여줄 년도 지정
			});
		});
	});

		e
	//이메일 중복체크
	function emailcheck(){
		var query={
				"email":$("#email").val()
		}
		$.ajax({
			type:"post",
			url:"/admin/emailcheck",
			data:query,
			success:function(data){
				//중복이 있는 경우
				if(data>0){
					$("#check").val("1");
					$("#semail").text("사용중인 이메일입니다.").show();
				}
				//중복이 없는 경우
				else{
					$("#check").val("0");
					$("#semail").text("사용가능한 이메일입니다.").show();
				}
			},
			error:function(data){
				alert("실패");
			}
		});
	}
		
	//팝업창 닫힘을 체크하는 함수
	function winopen(){
		var id = "${info.id}";
		//팝업창 열기
		var w = window.open("/admin/memberPasschange?id="+id, "_blank",
				"width=350,height=200,left=700px,top=200px,resizable=yes", true);
		//열린 팝업창 닫기를 체크함
		var watchClose = setInterval(function() {
		    if (w.closed) { //팝업창이 닫히면
		     clearTimeout(watchClose); //체크 종료
		     pspan(); //function 실행
		    }
		 }, 200); //0.2초마다 체크
	};
	
	//위 function에서 열린 팝업창에서 값을 받아와 처리하는 함수
	function pspan(){
		//팝업창이 닫히면 팝업창에서 id = success인 textbox에 change라는 value를 넣어줌
		if($("#success").val() != ""){ 
			$("#pspan").text("비밀번호가 변경되었습니다.").show();
		}
	}
	
	function back(){
		var id = "<%=id%>";
		var pagenum = $("#pagenum").val();
		var level = $("#level").val();
		location.replace("${ContextPath}/admin/memberView?id="+id+"&pagenum="+pagenum+"&level="+level);
	}

	function checkit() {
		var status = true;
		var emailreg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var telreg = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
		var ageReg = /^[0-9]{8}$/;

		// 이름확인
		if ($("#name").val() == "") {
			$("#sname").show();
			status = false;
		} else {
			$("#sname").hide();
		}
		// 생년월일 확인
		if($("#age").val() == ""){
			$("#sage").text("생년월일을 입력해주세요.").show();
			status = false;
		} else if(!ageReg.test($("#age").val())){
			$("#sage").text("생년월일은 특수문자없이 8자리 만 입력가능합니다.").show();
			status = false;
		} else {
			$("#sage").hide();
		}
		//주소확인
		if($("#address_1").val() == ""){
			$("#saddress").show();
			status = false;
		} else {
			$("#saddress").hide();
		}
		if ("${info.email}" != $("#email").val()) {
			if (!emailreg.test($("#email").val())) {
				$("#semail").text("정상적인 이메일을 입력해주세요.").show();
				status = false;
			} else if ($("#check").val() == "check") {
				$("#semail").text("이메일 중복검사를 해주세요.").show();
				status = false;
			}
		}
		if (!telreg.test($("#tel").val())) {
			$("#stel").text("전화번호는 하이푼(-)없이 입력해주세요.").show();
			status = false;
		} else {
			$("#stel").hide();
		}
		return status;
	}
	
	// 주소검색창 열기
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullAddr = ''; // 최종 주소 변수
				var extraAddr = ''; // 조합형 주소 변수
				var zonecode = data.zonecode;

				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					fullAddr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					fullAddr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
				if (data.userSelectedType === 'R') {
					//법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
								: data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')' : '');
				}

				//  주소 정보를 해당 필드에 넣는다.
				$('#address_1').val(fullAddr);
				$('#zipcode').val(zonecode);
				window.close();
			}
		}).open();
	}
</script>
</body>
</html>