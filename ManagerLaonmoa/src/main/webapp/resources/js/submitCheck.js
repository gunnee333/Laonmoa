$(document).ready(function() {
	$("#submit").click(function() {
		if ($("#type").val() == "" || $("#type").val() == null) {
			alert("검색조건을 선택하세요.");
			return false;
		}
		if ($("#value").val() == "" || $("#value").val() == null) {
			alert("검색할 내용을 입력하세요.");
			return false;
		}
	});

	$("#msubmit").click(function() {
		var check = true;
		var recid = $('input[name=recid]').val();
		var mtitle = $('input[name=mtitle]').val();
		var mcontent = $('textarea[name=mcontent]').val();

		if (recid == "" || recid == null) {
			check = false;
			alert("수신인을 입력해주세요." + recid);
			return false;
		}
		if (mtitle == "" || mtitle == null) {
			check = false;
			alert("쪽지 제목을 입력해주세요.");
			return false;
		}
		if (mcontent == "" || mcontent == null) {
			check = false;
			alert("쪽지 내용을 입력해주세요." + mcontent);
			return false;
		}

		if (check == true) {
			$('textarea[name=mfrm]').submit();
		}

	});

});
