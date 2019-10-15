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
</head>
<style>
join_img {
	text-align: center;
}

.intro-single-logo {
	padding: 11vw 44vw 0vw;
}

.form-a .form-control {
	border-radius: 0;
	font-size: 1.1rem;
	font-weight: 300;
}

post {
	width: 50%;
	text-align: center;
}

checkspan {
	text-align: center;
}

.join_start {
	padding: 1rem 2rem 1rem 27rem;
}

input, textarea:focus {
	outline: none;
}

.form-control {
	border-radius: 0px !important;
}

.form-control:focus {
	border-color: #FF7B22;
	box-shadow: none;
}
</style>

<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

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
	<!--/ 회원가입 폼 /-->
	<section class="news-single nav-arrow-b">
		<div class="container">
			<div class="row">
				<div class="col-md-11 offset-md-4 col-lg-8 offset-lg-4">

					<!-- 회원가입폼 -->
					<!-- 온키업은 공백 삭제 용도 -->
					<div class="post" style="width: 50%;">
						<br> <br>
						<form action="${ContextPath }/join" method="post" id="joinfrm">
							<div align="left">아이디</div>
							<input type="text" class="form-control" id="id" name="id"
								placeholder="아이디를 입력해주세요." maxlength="20" onkeyup="blank(this);">
							<span id="idcheck" class="checkspan"></span><br>

							<div align="left">비밀번호</div>
							<input type="password" maxlength="20" class="form-control"
								name="password" id="password" style="font-family: NanumGothic;"
								placeholder="비밀번호를 입력해주세요." onkeyup="blank(this);" /> <span
								id="pwcheck" class="checkspan"></span><br>

							<div align="left">비밀번호 확인</div>
							<input type="password" maxlength="20" class="form-control"
								name="password2" id="password2"
								style="font-family: NanumGothic;" placeholder="비밀번호를 재입력해주세요."
								onkeyup="blank(this);"> <span id="pwcheck2"
								class="checkspan"></span><br>

							<div align="left">이름</div>
							<input type="text" maxlength="10" class="form-control"
								name="name" placeholder="이름을 입력해주세요." onkeyup="blank(this);"
								id="name"> <span id="namecheck" class="checkspan"></span><br>

							<div align="left">생년월일</div>
							<input type="text" maxlength="10" class="form-control" name="age"
								placeholder="생년월일을 입력해주세요." onkeyup="blank(this);" id="age"
								readonly="readonly" style="background-color: #fff;"> <span
								id="agecheck" class="checkspan"></span><br>

							<div align="left">전화번호</div>
							<input type="text" maxlength="11" class="form-control" name="tel"
								placeholder="전화번호를 입력해주세요." onkeyup="blank(this);" id="tel">
							<span id="telcheck" class="checkspan"></span><br>

							<div align="left">주소</div>
							<input type="text" name="zipcode" id="zipcode"
								class="form-control" placeholder="우편번호를 검색해주세요."
								readonly="readonly" onClick="sample6_execDaumPostcode()"
								placeholder="우편번호"
								style="width: 30%; background-color: #fff; position: absolute;" />
							<div align="right">
								<input type="button" value="우편번호 찾기&nbsp;"
									onClick="sample6_execDaumPostcode()" class="form-control"
									style="width: 37%;">
							</div>
							<input type="text" name="address_1" id="address_1"
								onkeyup="blank(this);" placeholder="도로명주소" class="form-control" />
							<input type="text" class="form-control" name="address_2"
								id="address_2" placeholder="상세주소" /> <span id="addcheck"
								class="checkspan"></span><br> <span id="joinok"
								class="checkspan"></span>

							<div align="left">이메일</div>
							<input type="text" class="form-control" name="email" id="email"
								placeholder="이메일을 정확히 입력해주세요." value=""
								style="width: 30%; background-color: #fff; position: absolute;"
								onkeyup="blank(this);" />
							<input type="hidden" id="joinemail" name="joinemail"/>
							<div align="right">
								<input type="button" value="이메일 인증&nbsp;" class="form-control"
									style="width: 37%;" onClick="emailbutton()"
									id="email_checkcheck" /> <input type="hidden"
									id="email_checkcheck_input" value=""> <input
									type="button" value="이메일 재인증&nbsp;" class="form-control"
									style="width: 37%; display: none;"
									onClick="emailbutton_again()" id="again_email_checkcheck" />
							</div>
							<span id="emailcheck" class="checkspan"></span><br> <span
								id="emailcheck2" class="checkspan"></span>
							<div>
								<input type="hidden" id="emailok" class="form-control"
									style="width: 30%; background-color: #fff; position: absolute; padding-top: 10px;"
									onkeyup="blank(this);" />
								<div align="right">
									<input type="hidden" id="emailbutton2" class="form-control"
										value="인증" onClick="emailbutton3()" style="width: 37%;" />
								</div>
								<span id="emailok2" class="checkspan"></span> <br> <span
									id="timerTxt" class="checkspan"></span>
							</div>
							<br>

							<!-- 아이디 중복값 받는 용도 -->
							<input type="hidden" id="idoverlap" value="">
							<!-- 이메일 중복값 받는 용도 -->
							<input type="hidden" id="emailoverlap" value="">
							<button style="width: 365px;" type="button"
								class="btn laonmoabtn" id="joinbtn">회원가입</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!--/ 회원가입 폼 끝 /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>

	<script>
		// 전체 유효성 검사(1 = 중복 / 0 != 중복)
		var idReg = /[A-Za-z0-9]{6,20}/;//아이디
		var telReg = /[0-9]{8,12}/;//전화번호
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일
		var zipReg = /[0-9]{5,7}/;//우편번호
		var ageReg = /[0-9]{8}/;//생년월일
		var text = $('#id').val().replace(/ /gi, '');

		$(document).ready(
				function() {
					$("#id").blur(function() {
						checkme();
					});

					$("#email").blur(function() {
						checkme2();
						/* if(!emailReg.test(email)){
						checkit();
						} */
					});

					$("#joinbtn").click(function() {
						//alert("회원가입!");
						checkit();
						//alert("check == " + check);
						if (check) {
							if (confirm("회원가입을 하시겠습니까?") == true) {
								//alert($("#email").val());
								alert("완료되었습니다.");
								$("#joinfrm").submit();
							} else {
								return;
							}
						}
					});

					//datepicker
					$(function() {
						$("input[name=age]").datepicker(
								{
									dateFormat : 'yymmdd',
									changeMonth : true, //월변경가능
									changeYear : true, //년변경가능
									nextText : '다음 달',
									prevText : '이전 달',
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									showAnim : "slideDown", //애니메이션을 적용한다
									// 연도 셀렉트 박스 범위(현재연도의 - 100연도)
									maxDate : "D", //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
									yearRange : "-100:+0" //보여줄 년도 지정
								});
					});

				});

		//---------------------------이메일-----------------------------------------	

		//타이머
		function timer() {
			var min = Math.floor(timerSec / 60)
			var sec = timerSec % 60;
			var msg = (min < 10 ? "0" + min : min) + ":"
					+ (sec < 10 ? "0" + sec : sec);
			timerSec--;
			$('#email').prop('readOnly',true);
			$('#emailbutton2').show();
			$("#emailcheck2").hide();
			$("#emailok").attr("type", "text");
			$("#emailbutton2").attr("type", "button");
			$("#timerTxt").show();	
			document.getElementById("timerTxt").innerHTML = msg;
			if (timerSec < 0) { /* time End*/
				//msg += "인증시간을 초과하였습니다. 재인증을 받아 주세요."
				clearInterval(timerId);
				//일정 시간뒤 변화
				$('#email').val(null);
				$('#emailok').hide();
				$('#emailok2').hide();
				$('#emailbutton2').hide();
				//$('#email_checkcheck').hide();
				$("#timerTxt").hide();
				$("#emailcheck").text(
				"인증키의 유효시간이 초과되었습니다.다시 인증번호를 받아주세요.").show();
				$('#email').prop('readonly',false);
				$('#email_checkcheck').prop('disabled',false);	
				//$('#email').val(null);
				
				//$('#again_email_checkcheck').show();
				timerSec = 180;
			}

		}

		/*  function process() {
			    // 실제 작업 처리
			    console.log('버튼값을 중복하지 말아보자');
			    ts1 = new Date().getTime() + 10000;
			    do { ts2 = new Date().getTime(); } while (ts2 < ts1);
			    // 버튼 활성화
			    $('#email_checkcheck').prop('disabled', false);
			  }
		 */
/* 		  var emailcheck ;
		$(function() { 
			/* var email */
	/* 		 $('#email_checkcheck').click(function() {
				// 버튼 비활성화
				//인증버튼용
				document.getElementById("email_checkcheck_input").value = '1';
				email_checkcheck_input= $('#email_checkcheck_input').val();
				if (!emailReg.test(email_checkcheck_input)) {
					$("#emailcheck").text("이메일을 확인해주세요.");
					document.getElementById("email_checkcheck_input").value = '0';
				}
				else if ($('#email_checkcheck_input').val() == 1) {
					$('#email_checkcheck').prop('readonly', true);
					$('#email').prop('readonly', true);
				}
			});
			$('#again_email_checkcheck').click(function() {
				// 버튼 비활성화
				//재인증버튼용
					document.getElementById("email_checkcheck_input").value = '1';
					email_checkcheck_input = $('#email_checkcheck_input').val();
					 if (emailcheck == 0) {
							$("#emailcheck").text("이메일을 확인해주세요.");
							document.getElementById("email_checkcheck_input").value = '0';	
					}
					 else{
					 if ($('#email_checkcheck_input').val() == 1) {
						$('#email').prop('readonly', true);
						$('#again_email_checkcheck').prop('readonly', true);
					 }
				}
				
			}); */ 
		// 인증키를 발송
		//시간 제한용 변수
		//var email;
		var check = true;
		var emailcheck = 0;
		var timerId;
		var timerSec = 180;
		var t;
		
		function emailbutton() {
			//alert($("#email").val());
			
			checkme2();
			//alert(emailcheck);
			if (emailcheck != 0) {
				if (emailcheck !=1) {
					$('#email_checkcheck').prop('disabled',true);	
					$('#email').prop('readonly',true);	
				}	
			}		
			//	$("#email_checkcheck_input").val()=1;
			if ($("#emailoverlap").val() == "0") {
				$.ajax({
					type : "get",
					url : "${ContextPath}/emailsend",
					data : {
						email : $("#email").val()
					},
					success : function(data) {
						//기준 시간(1000=1sec)타이머
						//setInterval 기준시간마다 실행하는 것 =1초마다 타이머가 실행되어 보여지도록하는 부분
						
						timerId = setInterval('timer()', 1000);
						
						$("#emailcheck").text(
								"메일로 인증키를 발송하였습니다.아래의 창에 인증키를 입력하세요.").show();
						$('#emailok').show();
						//alert("emailbutton + 첫번째 나와야함 = "+data);
						$("#email_checkcheck_input").val(data);
						
					},
					error : function(data) {
											
						alert("전송할 메일이 존재하지 않습니다.");
					}
				});
			}
		}
		/* //이메일 재인증키 발송
		function emailbutton_again() {
			checkme2();
			if ($("#emailoverlap").val() == "0") {
				$.ajax({
					type : "get",
					url : "${ContextPath}/emailsend",
					data : {
						email : $("#email").val()
					},
					success : function(data) {
						//기준 시간(1000=1sec)타이머
						//setInterval 기준시간마다 실행하는 것 =1초마다 타이머가 실행되어 보여지도록하는 부분
						if (emailcheck != 0) {
							timerId = setInterval('timer()', 1000);
							
							$("#emailcheck").text("인증키를 재발송하였습니다. 다시 입력해주세요.")
									.show();
							$('#emailok').show();
							$('#emailbutton2').show();
							$("#emailok2").hide();
							$("#email_checkcheck_input").val(data);
						}
					
						
					},
					error : function(data) {
						alert("전송할 메일이 존재하지 않습니다.");
					}
				});
			}
		}
		 */
		//이메일 중복값ajax
		function checkme2() {
			// id = "id_reg" / name = "userId"
			 email = $('#email').val();
			if (!emailReg.test(email)) {
				$("#emailcheck").text("이메일을 확인해주세요.");
				emailcheck=0;
			} else {
				
				$.ajax({
					url : "${ContextPath }/emailCheck?email=" + email,
					type : 'get',
					success : function(data) {
						console.log("1 = 중복o / 0 = 중복x : " + data);
						if (data == 1) {
							// 1 : 아이디가 중복되는 문구
							$("#emailcheck").text("사용중인 메일입니다. ");
							$("#emailcheck2").val("false");
							$("#emailcheck").css("color", "red");
							$("#emailoverlap").val("1");
							emailcheck =1;
							//$("#joinbtn").attr("disabled", true);
						} else if (data == 0) {
							$("#emailoverlap").val("0"); //이메일 중복인지 확인
							$("#emailcheck").text("사용가능한 메일입니다. ");
							$("#emailcheck2").text(
									"이메일 인증버튼을 클릭하세요.인증창은 약5초후 나타납니다.");
							emailcheck=2;
						}
					},
					error : function() {
						console.log("실패");
					}
				});
			}
		}
		//이메일 인증 키 확인
		function emailbutton3() {
			var emailcheckinput = $("#email_checkcheck_input").val();		
			var emilcheck = $("#emailok").val();
			//인증성공
			if (emailcheckinput == emilcheck) {
				clearInterval(timerId);
				$('#emailcheck').hide();
				$("#emailok2").text("인증되었습니다.").show();
				$('#email').prop('readonly', true);
				$('#email_checkcheck').prop('disabled', true);
				$('#emailbutton2').prop('disabled', true);
				$('#emailok').prop('readonly', true);
				$('#email_checkcheck').show();
				$('#timerTxt').hide();
				$('#again_email_checkcheck').hide();
				emailcheck = 1;
			} else {
				//$('#emailok').val(null);
				$("#emailok2").text("인증번호가 일치 하지 않습니다. 다시 입력해주세요.").show();
			}
		}
		//-------------------------------------------이메일 끝------------------------------------------------
		//주소 api
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
							extraAddr += (extraAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
						fullAddr += (extraAddr !== '' ? ' (' + extraAddr + ')'
								: '');
					}

					//  주소 정보를 해당 필드에 넣는다.
					$('input[name=address_1]').val(fullAddr);
					$('input[name=zipcode]').val(zonecode);

				}
			}).open();
		}
		//------------------------------주소 api끝-------------------------

		//------------------------------아이디 중복값 확인-------------------------
		//아이디 중복값ajax
		function checkme() {
			// id = "id_reg" / name = "userId"
			var id = $('#id').val();
			var idReg = /[A-Za-z0-9]{6,20}/;//아이디
			$.ajax({
				url : "${ContextPath }/idCheck?id=" + id,
				type : 'get',
				success : function(data) {
					console.log("1 = 중복o / 0 = 중복x : " + data);
					if (data == 1) {
						// 1 : 아이디가 중복되는 문구
						$("#idcheck").text("사용중인 아이디입니다. ");
						$("#idcheck").css("color", "red");
						$("#idoverlap").val("1");

						//$("#joinbtn").attr("disabled", true);

					} else if (data == 0) {
						$("#idcheck").text("사용가능한 아이디입니다");
						$("#idoverlap").val("0");
						if (!idReg.test(id) || id == null || id == "") {
							$("#idcheck").text("아이디를 확인해주세요.");
						}
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		}
		//----------------------------------------아이디 중복확인 끝-----------------------
		//띄어쓰기 막음
		function blank(obj) {
			var a = $('#id').val().replace(/ /gi, '');
			$('#id').val(a);
			var a = $('#password').val().replace(/ /gi, '');
			$('#password').val(a);
			var a = $('#password2').val().replace(/ /gi, '');
			$('#password2').val(a);
			var a = $('#name').val().replace(/ /gi, '');
			$('#name').val(a);
			var a = $('#age').val().replace(/ /gi, '');
			$('#age').val(a);
			var a = $('#tel').val().replace(/ /gi, '');
			$('#tel').val(a);
			var a = $('#email').val().replace(/ /gi, '');
			$('#email').val(a);
			var a = $('#emailok').val().replace(/ /gi, '');
			$('#emailok').val(a);
		}

		//--------------------------------------------유효성 검사----------------------------------		
		function checkit() {
			check = true;
			var id = $('input[name=id]').val();
			var password = $('input[name=password]').val();
			var password2 = $('input[name=password2]').val();
			var name = $('input[name=name]').val();
			var age = $('input[name=age]').val();
			var tel = $('input[name=tel]').val();
			var email = $('#email').val();
			var zipcode = $('input[name=zipcode]').val();
			var address_1 = $('input[name=address_1]').val();

			if (id == null || id == "") {
				$("#idcheck").text("아이디를 입력해주세요.").show();
				$("#id").focus();
				check = false;
			} else if (!idReg.test(id)) {
				$("#idcheck").text("아이디는 6~20자 영문자/숫자로만 입력가능합니다. ").show();
				$("#id").focus();
				check = false;
			}
			if (password == null || password == "") {
				$("#pwcheck").text("비밀번호를 입력해주세요.").show();
				$("#password").focus();
				check = false;
			} else if (!idReg.test(password)) {
				$("#pwcheck").text("비밀번호는 6~20자 영문자/숫자로만 입력가능합니다.").show();
				$("#password").focus();
				check = false;
			} else if (password == id) {
				$("#pwcheck").text("아이디와 동일한 비밀번호는 사용할 수 없습니다.").show();
				$("#password").focus();
				check = false;
			} else {
				$("#pwcheck").text("").hide();
			}
			if (password != password2) {
				$("#pwcheck2").text("비밀번호가 일치하지 않습니다.").show();
				$("#password2").focus();
				check = false;
			} else {
				$("#pwcheck2").text("").hide();
			}
			if (name == null || name == "") {
				$("#namecheck").text("이름을 입력해주세요.").show();
				$("#name").focus();
				check = false;
			} else {
				$("#namecheck").text("").hide();
			}
			if (age == null || age == "") {
				$("#agecheck").text("생년월일을 입력해주세요.").show();
				$("#age").focus();
			} else if (!ageReg.test(age)) {
				$("#agecheck").text("생년월일은 연월일로 8자리 숫자만 입력가능합니다.").show();
				$("#age").focus();
			} else {
				$("#agecheck").text("").hide();
			}
			if (tel == null || tel == "") {
				$("#telcheck").text("전화번호를 입력해주세요.").show();
				$("#tel").focus();
				check = false;
			} else if (!telReg.test(tel)) {
				$("#telcheck").text("전화번호를 확인해주세요.").show();
				$("#tel").focus();
				check = false;
			} else {
				$("#telcheck").text("").hide();
			}
			if (email == null || email == "") {
				$("#emailcheck").text("이메일을 입력해주세요.").show();
				$("#email").focus();
				$("#emailcheck2").value = false;
				check = false;
			} else if (!emailReg.test(email)) {
				$("#emailcheck").text("이메일을 확인해주세요.").show();
				$("#email").focus();
				$("#emailcheck2").value = false;
				check = false;
			} else if (emailcheck != 1) {
				$("#emailcheck").text("인증번호를 받아 주세요.").show();
				check = false;
			} else {
				$("#emailcheck").text("").hide();
				$("#emailcheck2").value = "";
			}
			if (address_1 == null || address_1 == "" || zipcode == null
					|| zipcode == "" || !zipReg.test(zipcode)) {
				$("#addcheck").text("주소를 검색해주세요.").show();
				$("#address_1").focus();
				check = false;
			} else {
				$("#addcheck").text("").hide();
			}
			if ($("#emailoverlap").val() == "1"
					|| $("#emailoverlap").val() == 1) {
				$("#emailcheck").text("이메일을 다시 입력해주세요.").show();
				$("#email").focus();
				$("#emailcheck2").value = false;
				check = false;
			}
			if ($("#idoverlap").val() == "1" || $("#idoverlap").val() == 1) {
				$("#idcheck").text("아이디를 다시 입력해주세요.").show();
				$("#email").focus();
				check = false;
			}
		}
	</script>
</body>
</html>
