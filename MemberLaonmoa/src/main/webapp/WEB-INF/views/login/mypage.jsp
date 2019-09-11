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
<link href="/resources/css/nav-tabs.css" rel="stylesheet">
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
	width: 300px;
	height: 190px;
}
.form-control {
	border-radius: 0px !important;
}

.form-control:focus {
	border-color: #FF7B22;
	box-shadow: none;
}
.in_maymoa{
    display: inline-block;
    width: 100%;
    padding-top: 40px;
}
</style>
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
</head>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<%@ include file="mypageMenu.jsp"%>
	
	<!--/ Carousel Star /-->
	<div class="out">
		<!-- 메뉴 네비게이션 -->
		<ul class="nav nav-tabs">
			<li role="presentation" class="active"><a href="${ContextPath }/mypage/myinfo">내정보</a></li>
			<li role="presentation"><a href="${ContextPath }/mypage/myReview?pagenum=1">내가 쓴 게시글</a></li>
			<li role="presentation"><a href="${ContextPath }/mypage/mynote">쪽지보관함</a></li>
		</ul>
	</div>
	<div class="out">
		<div class="in_maymoa">
			<!-- 정보보기 -->
			<form>
				<table>
					<tr>
						<td width="100px">아이디</td>
						<td width="300px"><input type="text" class="form-control"
							value="${vo.id }" name="id" id="id" disabled="disabled"></td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td align="left">
							<button type="button" class="btn laonmoabtn" id="changePw"
								style="color: #fff; background-color: #ff7b22 !important;"
								onclick="changePWopen();">비밀번호 변경</button>
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" class="form-control" name="name"
							value="${vo.name }" disabled="disabled" maxlength="8" onkeyup="blank(this);"></td>
					</tr>
					<tr>
						<td colspan="2"><span class="checkspan" id="namecheck"></span></td>
					</tr>
					<tr>
						<td>생년월일</td>
						<td><input type="text" class="form-control" name="age" value="${vo.age }" 
						disabled="disabled" maxlength="10" readonly="readonly" onkeyup="blank(this);"></td>
					</tr>
					<tr>
						<td colspan="2"><span class="checkspan" id="agecheck"></span></td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td><input type="text" class="form-control" name="tel" placeholder="숫자로만 입력해주세요."
							value="${vo.tel }" disabled="disabled" maxlength="11" onkeyup="blank(this);"></td>
					</tr>
					<tr>
						<td colspan="2"><span class="checkspan" id="telcheck"></span></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="text" class="form-control" name="email"
							value="${vo.email }" disabled="disabled" maxlength="40" onkeyup="blank(this);"></td>
					</tr>
					<tr>
						<td colspan="2">
							<span id="timerTxt" class="checkspan"></span>
							<span class="checkspan" id="emailcheck"></span>
						</td>
					</tr>
					<tr id="hiddenEmailtr" style="display: none;">
						<td></td>
						<td style="text-align: right;">
							<!-- 이메일 인증키 받을 input name=emailtestcode -->
							<input type="text" class="form-control" name="emailtestcode" 
							style="display: none; width: 240px;" placeholder="인증키를 입력해주세요." onkeyup="blank(this);">
							<!-- 이메일 인증버튼 (클릭시 인증으로 변경) -->
							<input type="button" class="btn laonmoabtn" id="emailtest" value="이메일인증">
						</td>
					</tr>
					<tr>
						<td>주소</td>
						<td><input type="hidden" value="${vo.zipcode }" name="zipcode">
							<input type="text" class="form-control" name="address1"
							value="${vo.address_1 }" readonly="readonly" disabled="disabled"></td>
					</tr>
					<tr>
						<td colspan="2"><span class="checkspan" id="zipcodecheck"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span class="checkspan" id="address1check"></span></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="text" class="form-control" name="address2"
							value="${vo.address_2 }" disabled="disabled" maxlength="60"></td>
					</tr>
					<tr>
						<td colspan="2" align="right"><br> <input type="button"
							class="btn laonmoabtn" id="update" value="정보수정"> <input
							type="button" class="btn laonmoabtn" id="youout" value="회원탈퇴">
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!--/ Carousel end /-->
	
	<!-- 비밀번호 확인 모달창 -->
	<div id="modal">
		<h3>비밀번호 확인</h3><br>
		<input type="password" name="password" class="form-control" style="font-family:NanumGothic;" /><br>
		<button id="confirm_button" class="btn laonmoabtn">확인</button>
		<button class="btn laonmoabtn" onclick="modalclose();">닫기</button>
	</div>
	<!-- 모달 end -->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
	<!-- 모달 스크립트 -->
	<script type="text/javascript" src="/resources/js/Example.Modal.js" ></script>
	<!-- 마이페이지 스크립트 -->
	<script>
		var check = true;
		var emailReg = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
		var numReg = /^[0-9]*$/;
		var telReg = /[0-9]{8,12}/;//전화번호
		var emailCheck = true;	// 이메일정규식체크
		var emailOverlap = false;	// 이메일중복체크
		var emailtestOK = true;	// 이메일 인증체크
		var userEmail = "${vo.email}";
		var emailtestcode;
		// 타이머변수
		var timerSec = 180;
		var timerId;
		
		$(document).ready(function() {
			// 모달창의 확인버튼 누르면 회원탈퇴하기.
			$("#confirm_button").click(function() {
				//비밀번호 입력안되어 있을 때
				if($('input[name=password]').val() == "" || $('input[name=password]').val() == null){
					alert("비밀번호를 입력해주세요.");
				} else{	// 비밀번호 입력되었을 때
					if (confirm("정말 탈퇴하시겠습니까?") == true) {
						var query = {
							"id" : $('input[name=id]').val(),
							"password" : $('input[name=password]').val()
						}
			
						$.ajax({
							type : "get",
							url : "${ContextPath }/mypage/memberout",
							data : query,
							success : function(data) {
								if(data == "1"){	// 탈퇴성공
									alert("탈퇴되었습니다.");
									location.replace("/");
								} else if(data == "0"){	// 아이디 또는 패스워드 불일치
									alert("패스워드가 일치하지 않습니다.");
								} else {
									alert("에러");
								}
							},
							error : function(data) {
								alert("알 수 없는 에러가 발생하였습니다.");
							}
						});
					}
					myModal.hide(); // 모달창 감추기
				}
			});
			
			//datepicker
			$(function() {
				$("input[name=age]").datepicker({
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
			
			$("#update").click(function() {
				if ($("#update").val() == "정보수정") {
					// 수정버튼 눌렀을 때 수정가능하게 변경
					$("#update").val("수정완료");
					$("#youout").val("수정취소");
					$('input[name=name]').attr("disabled", false);
					$('input[name=age]').attr("disabled", false);
					$('input[name=age]').css("background-color","#fff");
					$('input[name=tel]').attr("disabled", false);
					$('input[name=email]').attr("disabled",false);
					$('input[name=address1]').attr("disabled",false);
					$('input[name=address1]').css("background-color","#fff");
					$('input[name=address2]').attr("disabled",false);
					$('input[name=email]').css("background-color","#fff");
	
				} else if ($("#update").val() == "수정완료") {
					// 수정완료버튼 눌렀을 때 데이터 수정처리 후 수정불가능하게 변경
					checkit();
					if (check) {
						if(confirm("수정하시겠습니까?") == true){
							var query = {
								"id" : $('input[name=id]').val(),
								"name" : $('input[name=name]').val(),
								"age" : $('input[name=age]').val(),
								"tel" : $('input[name=tel]').val(),
								"email" : $('input[name=email]').val(),
								"zipcode" : $('input[name=zipcode]').val(),
								"address_1" : $('input[name=address1]').val(),
								"address_2" : $('input[name=address2]').val()
							}
		
							$.ajax({
								type : "get",
								url : "${ContextPath }/mypage/myinfoUpdate",
								data : query,
								success : function(data) {
									$("#update").val("정보수정");
									$("#youout").val("회원탈퇴");
									$('#emailcheck').hide();
									$('input[name=name]').attr("disabled",true);
									$('input[name=age]').attr("disabled",true);
									$('input[name=age]').css("background-color","#e9ecef");
									$('input[name=tel]').attr("disabled",true);
									$('input[name=email]').attr("disabled",true);
									$('input[name=email]').css("background-color","#e9ecef");
									$('input[name=address1]').attr("disabled",true);
									$('input[name=address1]').css("background-color","#e9ecef");
									$('input[name=address2]').attr("disabled",true);
									$('#hiddenEmailtr').hide();
								},
								error : function(data) {
									alert("에러");
								}
							});
						}
					}
				}
			});
	
			$('input[name=address1]').click(function() {
				sample6_execDaumPostcode();
			});
	
			$("#youout").click(function() {
				if ($("#update").val() == "정보수정") {
					// youout 버튼이 회원탈퇴일 때
					modalopen();
				} else if ($("#update").val() == "수정완료") {
					//youout 버튼이 수정취소일 때
					location.reload();
				}
			});
			
			// 이메일체크
			$("input[name=email]").blur(function(){
				// 기존에 입력되어있던 이메일과 다른 경우
				if($("input[name=email]").val() != userEmail){
					emailOverlap = false;
					emailtestOK = false;
					emailAble();
				} else{	// 이메일 수정안한경우
					$('#hiddenEmailtr').hide();
					$("#emailcheck").hide();
					emailOverlap = true;
					emailtestOK = true;
				}
			});
			
			// 이메일 인증키 클릭시
			$('#emailtest').click(function(){
				if(this.value == "이메일인증"){	// 버튼의 text가 '이메일 인증' 일 시
					$('#emailcheck').text('인증키를 입력해주세요.').show();
					// 이메일 정규식/중복값 체크
					emailAble();
					if(emailCheck == true){
						// 이메일 전송
						emailsend($("input[name=email]"));
					}
					
				} else if (this.value == "인증") {	// 버튼의 text가 '인증' 일 시
					// 이메일 인증키 확인
					var emailtest = $("input[name=emailtestcode]");
					if(emailtest.val() == 'null' || emailtest.val() == "" || emailtest.val() == null){
						$('#emailcheck').text('인증키를 입력해주세요.').show();
						emailCheck = false;
						emailtestOK = false;
					} else if(emailtest.val() != emailtestcode){
						$('#emailcheck').text('인증키가 일치하지 않습니다.').show();
						emailCheck = false;
						emailtestOK = false;
					} else{
						$('#emailcheck').text('인증되었습니다.').show();
						emailtestOK = true;
						clearInterval(timerId);
						$("#timerTxt").hide();
						$('input[name=emailtestcode]').css("display", "none");
						$('input[name=emailtestcode]').val(null);
						this.value = "재인증";
					}
					
				} else if (this.value == "재인증"){
					$('#emailcheck').hide();
					$('input[name=email]').attr('disabled', false);
					$('input[name=email]').val(null);
					this.value = "이메일인증";
					emailCheck = false;
					emailtestOK = false;
				}
			});
	
		});
		
		//--------------------------------------------------------------
		// 이메일 정규식/ 중복값 체크
		function emailAble(){
			emailcheckit();
			if(emailCheck == true){
				emailOverLap();
			}
		}
		
		// 이메일 정규식 체크
		function emailcheckit(){
			emailCheck = true;
			if ($('input[name=email]').val() == "" || $('input[name=email]').val() == null) {
				$('#hiddenEmailtr').hide();
				$("#emailcheck").text("이메일을 입력해주세요.").show();
				emailCheck = false;
				check = false;
			} else if(!emailReg.test($('input[name=email]').val())){
				$('#hiddenEmailtr').hide();
				$("#emailcheck").text("이메일형식에 맞게 재입력해주세요.").show();
				emailCheck = false;
				check = false;
			} else {
				$("#emailcheck").hide();
			}
		}
		
		//이메일 중복값ajax
		function emailOverLap() {
			var email = $('input[name=email]').val();
			
			$.ajax({
				url : "${ContextPath }/emailCheck?email=" + email,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : " + data);
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#emailcheck").text("이미 사용중인 이메일입니다.").show();
						$('#hiddenEmailtr').hide();
						emailCheck = false;
						emailOverlap = false;
						check = false;
					} else if (data == 0) {
						$("#emailcheck").text("이메일 인증을 받아주세요.").show();
						$('#hiddenEmailtr').show();
						emailOverlap = true;
					}
				},
				error : function() {
					$("#emailcheck").text("중복체크 실패하였습니다.").show();
					$('#hiddenEmailtr').hide();
					console.log("이메일중복체크실패");
					emailCheck = false;
					emailOverlap = false;
					check = false;
				}
			});
		}
		
		// 이메일 보내기
		function emailsend(email){
			if(emailCheck == true && emailOverlap == true){
				$('#emailtest').val("인증");
				$('input[name=email]').attr('disabled', true);
				$('input[name=email]').css('background-color', "#fff");
				$('input[name=emailtestcode]').css("display", "inline-block");
				
				$.ajax({
					type : "get",
					url : "${ContextPath}/emailsend",
					data : { "email" : email.val() },
					success : function(data) {
						//기준 시간(1000=1sec)타이머
						//setInterval 기준시간마다 실행하는 것 =1초마다 타이머가 실행되어 보여지도록하는 부분
						timerId = setInterval('timer()', 1000);
						
						// 이메일인증코드 저장
						emailtestcode = data;
					},
					error : function(data) {
						alert("메일전송에 실패하였습니다.");
					}
				});	
			}
		}
		
		//타이머
		function timer() {
			var min = Math.floor(timerSec / 60)
			var sec = timerSec % 60;
			var msg = (min < 10 ? "0" + min : min) + ":"
					+ (sec < 10 ? "0" + sec : sec);
			timerSec--;

			document.getElementById("timerTxt").innerHTML = msg;

			if (timerSec < 0) { /* time End*/
				//msg += "인증시간을 초과하였습니다. 재인증을 받아 주세요."
				clearInterval(timerId);
				//인증유효 시간뒤 변화
				$('#hiddenEmailtr').hide();
				$("input[name=email]").attr("disabled", false);
				$("#emailcheck").text("인증시간이 초과되었습니다.").show();
				$("#timerTxt").hide();
				$('#emailtest').val("이메일인증");
				$('input[name=emailtestcode]').css("display", "none");
				timerSec = 30;
			}

		}
		//--------------------------------------------------------------
	
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
		
		// 비밀번호 변경 팝업 띄우기
		function changePWopen() {
			window.open("${ContextPath }/mypage/changePw","_blank",
					"width=380, height=460, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
		}
	
		// 변경 클릭시 입력값 확인
		function checkit() {
			check = true;
			// 이메일 수정 했을 시 이메일 체크
			if(emailtestOK == false){
				check = false;
			}
			if ($('input[name=name]').val() == ""
					|| $('input[name=name]').val() == null) {
				$("#namecheck").text("이름을 입력해주세요.").show();
				check = false;
			} else {
				$("#namecheck").text("").hide();
			}
			if ($('input[name=age]').val() == ""
					|| $('input[name=age]').val() == null) {
				$("#agecheck").text("생년월일을 입력해주세요.").show();
				check = false;
			} else if(!numReg.test($('input[name=age]').val())) {
				$("#agecheck").text("숫자만 입력해주세요.").show();
				check = false;
			} else {
				$("#agecheck").text("").hide();
			}
			if ($('input[name=tel]').val() == ""
					|| $('input[name=tel]').val() == null) {
				$("#telcheck").text("전화번호를 입력해주세요.").show();
				check = false;
			} else if(!telReg.test($('input[name=tel]').val())) {
				$("#telcheck").text("숫자만 입력해주세요.").show();
				check = false;
			} else {
				$("#telcheck").text("").hide();
			}
			if ($('input[name=address1]').val() == ""
					|| $('input[name=address1]').val() == null) {
				$("#address1check").text("주소을 입력해주세요.").show();
				check = false;
			} else {
				$("#address1check").text("").hide();
			}
			if ($('input[name=zipcode]').val() == ""
					|| $('input[name=zipcode]').val() == null) {
				$("#zipcodecheck").text("주소를 다시입력해주세요.").show();
				check = false;
			} else {
				$("#zipcodecheck").text("").hide();
			}
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
					$('input[name=address1]').val(fullAddr);
					$('input[name=zipcode]').val(zonecode);
					window.close();
				}
			}).open();
		}
		
		// 공백제거
		function blank(obj){
			obj.value = obj.value.replace(/ /gi,'');
		}
	</script>
</body>
</html>
