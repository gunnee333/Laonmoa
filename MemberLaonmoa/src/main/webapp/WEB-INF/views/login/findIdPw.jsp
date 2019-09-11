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
td {
	width: 25rem;
}

.tdright {
	margin-right: 5rem;
	padding-right: 5rem;
}

.tdleft {
	border-left: 1px solid #b8babb;;
	margin-left: 5rem;
	padding-left: 5rem;
}

.form-control {
	border-radius: 0px !important;
}

.form-control:focus {
	border-color: #FF7B22;
	box-shadow: none;
}

</style>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->


	<!--/ Carousel Star /-->
	<div class="mainbody">
		<div class="out">
			<div class="in">
				<table>
					<tr style="text-align: left;">
						<td class="tdright">
							<section class="intro-single" style="padding-top: 10px;">
								<div class="container">
									<div class="row">
										<div class="title-single-box">
											<h1 class="title-single" style="font-size: 30px;">아이디찾기</h1>
										</div>
									</div>
								</div>
							</section>
						</td>
						<td class="tdleft">
							<section class="intro-single" style="padding-top: 10px;">
								<div class="container">
									<div class="row">
										<div class="title-single-box">
											<h1 class="title-single" style="font-size: 30px;">비밀번호찾기</h1>
										</div>
									</div>
								</div>
							</section>
						</td>
					</tr>
					<tr>
						<td class="tdright">
							<div>
								<form method="post" name="frm1">
									<div align="left">이름</div>
									<input type="text" class="form-control" name="name" id="name"
										placeholder="이름를 입력해주세요." onkeyup="blank(this);" /> <span
										id="namecheck" class="checkspan"></span><br>
									<div align="left">전화번호</div>
									<input type="text" class="form-control" name="tel" id="tel"
										placeholder="전화번호를 입력해주세요." onkeyup="blank(this);" /> 
										<div>
										<span id="telcheck" class="checkspan"></span><br> 
										<span id="findid" class="checkspan"></span><br>
										</div>
									<!-- 이름 중복값 받는 용도 -->
									<input type="hidden" id="nameoverlap" value="">
									<!-- 번호 중복값 받는 용도 -->
									<input type="hidden" id="teloverlap" value="">
									<br>
									<div align="right">
										<button type="button" class="btn laonmoabtn" id="idfindbtn">아이디찾기</button>
									</div>
								</form>
							</div>
						</td>
						<td class="tdleft">
							<div>
								<form method="post" name="frm2" id="frm2">
									<div align="left">아이디</div>
									<input type="text" class="form-control" name="id" id="id"
										placeholder="아이디를 입력해주세요." onkeyup="blank(this);" /> <span
										id="idcheck" class="checkspan"></span><br>
									<div align="left">이메일</div>
									<input type="text" class="form-control" name="email" id="email"
										placeholder="이메일을 입력해주세요." onkeyup="blank(this);" /> <span
										id="emailcheck" class="checkspan"></span><br>
									<div>
										<span id="findpw" class="checkspan"></span><br> <span
											id="findpw3" class="checkspan"></span> <input type="hidden"
											id="findpw2" value="" /> <br>
									</div>

									<div align="right">
										<button type="button" class="btn laonmoabtn" id="pwfindbtn">비밀번호찾기</button>
										<input type="hidden" id="passfind" value="" />
									</div>
								</form>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
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
		var telReg = /[0-9]{8,12}/;
		var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		//버튼 클릭
		$(document).ready(function() {
			$("#idfindbtn").click(function() {
				checkitid();
				if (check) {
					findingid();
				}
			});
			$("#pwfindbtn").click(function(){
				checkitpw();
				if(check){
				findingPassword();
				}
			});

		});
		// 수신인 찾는 새창오픈
		var email;
		var check = true;
		var emailcheck = 0;
		function newPassword() {
			//alert($("#email").val());

			if ($("#findpw2").val() == "") {
				//alert("ds");
				$.ajax({
					type : "get",
					url : "${ContextPath}/newPassword",
					data : {
						email : $("#email").val(),
						id : $("#id").val()
					},
					success : function(data) {
						//alert(data);
						$("#findpw").text("메일로 임시비밀번호를 발송하였습니다.").show();
						$("#findpw3").text("로그인하여 비밀번호를 수정하세요.").show();
						email = data;
					},
					error : function(data) {
						alert("실패");
					}
				});
				return true;
			}
		}
		//아이디 찾디ajax
		function findingid() {
			// id = "id_reg" / name = "id"
			var name = $('#name').val();
			var tel = $('#tel').val();
			$.ajax({
				url : "${ContextPath }/findingId",
				type : 'get',
				data : {
					"name" : name,
					"tel" : tel
				},
				success : function(data) {
					//alert(data);
					if (data != "") {
						$("#findid").text("당신의 아이디는[" + data + "]입니다.");
					} else {
						$("#findid").text("이름 또는 전화번호를 다시 확인하세요.");
					}
				},
				error : function() {
					console.log("실패");
				}
			});
		}
		//비번 찾기ajax(한번에 확인용)
		function findingPassword() {
			// id = "id_reg" / name = "id"
		
			
				var id = $('#id').val();
				var email = $('#email').val();
				$.ajax({
					url : "${ContextPath }/findingPassword",
					type : 'get',
					data : {
						"id" : id,
						"email" : email
					},
					success : function(data) {
						//alert("data ="+data);
						if (data == "2") {
							newPassword();
						} else {
							$("#findpw").text("아이디 또는 이메일을 다시 확인하세요.");
						}
					},
					error : function() {
						console.log("실패");
					}
				});
		}

		//띄어쓰기 막음
		function blank(obj) {
			var a = $('#name').val().replace(/ /gi, '');
			$('#name').val(a);
			var a = $('#tel').val().replace(/ /gi, '');
			$('#tel').val(a);
			var a = $('#id').val().replace(/ /gi, '');
			$('#id').val(a);
			var a = $('#email').val().replace(/ /gi, '');
			$('#email').val(a);
		}
		function checkitid() {
			check = true;
			var name = $('input[name=name]').val();
			var tel = $('input[name=tel]').val();

			if (name == null || name == "") {
				$("#namecheck").text("이름을 입력해주세요.").show();
				check = false;
			} else {
				$("#namecheck").text("").hide();
			}
			if (tel == null || tel == "") {
				$("#telcheck").text("전화번호를 입력해주세요.").show();
				check = false;
			} else if (!telReg.test(tel)) {
				$("#telcheck").text("전화번호를 확인해주세요.").show();
				check = false;
			} else {
				$("#telcheck").text("").hide();
			}

		}
		function checkitpw() {
			check = true;
			var id = $('input[name=id]').val();
			var email = $('input[name=email]').val();

			if (id == null || id == "") {
				$("#idcheck").text("아이디를 입력해주세요.").show();
				check = false;
			} else if (!idReg.test(id)) {
				$("#idcheck").text("아이디는 영문자와 숫자로만 입력해주세요.").show();
				check = false;
			} else {
				$("#idcheck").text("").hide();
			}
			if (email == null || email == "") {
				$("#emailcheck").text("이메일을 입력해주세요.").show();
				check = false;
			} else if (!emailReg.test(email)) {
				$("#emailcheck").text("이메일 주소를 확인해주세요.").show();
				check = false;
			} else {
				$("#emailcheck").text("").hide();
			}
			return true;
		}
	</script>
</body>
</html>
