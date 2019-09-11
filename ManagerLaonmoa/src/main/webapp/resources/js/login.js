var check = true;
var exp = /[A-Za-z0-9]{4,10}/;
$(document).ready(function() {
	$("#login").click(function() {
		checkit();
		if (!check) {
			return false;
		} else {
			$("form").submit();
		}
	});

	$("#id").blur(function() {
		if ($("#id").val() == null || $("#id").val().length == 0) {
			$("#idcheck").text("아이디를 입력하세요.").show();
			return false;
		} else if (!exp.test($("#id"))) {
			$("#idcheck").text("숫자 또는 영문자만 입력해주세요.").show();
			return false;
		} else {
			$("#idcheck").text("").hide();
			return false;
		}
	});

	$("#pw").blur(function() {
		if ($("#pw").val() == null || $("#pw").val().length == 0) {
			$("#pwcheck").text("패스워드를 입력하세요.").show();
			return false;
		} else if (!exp.test($("#pw"))) {
			$("#pwcheck").text("숫자 또는 영문자만 입력해주세요.").show();
			return false;
		} else {
			$("#pwcheck").text("").hide();
			return false;
		}
	});

});

function checkit() {
	check = true;

	if ($("#id").val() == null || $("#id").val().length == 0) {
		$("#idcheck").text("아이디를 입력하세요.").show();
		$("#id").focus();
		check = false;
		return false;
	}
	if (!exp.test($("#id"))) {
		$("#idcheck").text("숫자 또는 영문자만 입력해주세요.").show();
		$("#id").focus();
		check = false;
		return false;
	}
	if ($("#pw").val() == null || $("#pw").val().length == 0) {
		$("#pwcheck").text("패스워드를 입력하세요.").show();
		$("#pw").focus();
		check = false;
		return false;
	}
	if (!exp.test($("#pw"))) {
		$("#pwcheck").text("숫자 또는 영문자만 입력해주세요.").show();
		$("#pw").focus();
		check = false;
		return false;
	}
	return check;
}
