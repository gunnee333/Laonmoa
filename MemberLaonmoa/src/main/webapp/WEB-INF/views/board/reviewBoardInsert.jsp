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
<!-- include summernote css/js-->
<script src="/resources/summernote/summernote-bs4.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
</head>
<%	String pagenum = request.getParameter("pagenum"); 
	String level = request.getParameter("level");
%>
<body>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Carousel Star /-->
	<div class="mainbody"><div class="out"><div class="in">
			<form method="post" name="insert" action="${ContextPath}/board/reviewBoardInsert">
				<table class="table"
					style="text-align: center;">
					<thead>
						<tr>
							<th colspan="2" style="text-align:center; font-size:25px; padding-top: 50px;">
								리뷰게시판 글쓰기
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
						<td align="left">
						행사분류 : <input type="text" id="event" readonly>
						<!-- 검색전에 분류를 미리 하기 -->
						<!--  <select id="select" style="height: 30px">
							<option value="-1">전체 선택</option>
							<option value="7">축제</option>
							<option value="8">연극</option>
							<option value="9">뮤지컬</option>
							<option value="10">전시회</option>
						</select> -->
						</td>
						</tr>
						<tr>
						<td align="left"><input type="text" style="width:300px" readonly id="eventname">
						<button type="button" id="search">축제검색</button>
						<input type="hidden" name ="fno" id="fno">
						</td>
						</tr>
						<tr style="display:none" id="nofno">
						<td style="text-align:left;" colspan="2">
						<span style="color:red;">축제정보를 입력해주세요.</span>
						</td>
						</tr>
						<tr>
						<td><input type="text" placeholder="제목" class="form-control" name = "title" maxlength="50" /></td>
						</tr>
						<tr style="display:none" id="notitle">
						<td style="text-align:left;" colspan="2">
						<span style="color:red;">제목을 입력해주세요.</span>
						</td>
						</tr>
						<tr>
							<td><textarea name="content" id="summernote"></textarea></td>
						</tr>
					</tbody>
				</table>
				<a>
				<button type="button" id="cencel" class="btn laonmoabtn pull-right" onclick="back()">취소</button>
				</a>
				<button type="button" class="btn laonmoabtn pull-right" onclick="send()">글 쓰기</button>
				<input type="hidden" name = "id" value="${id}">
				<input type="hidden" name = "level" value="<%=level%>">
			</form>
		
	</div></div></div>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
<script>
$(document).ready(function() {
	//썸머노트 띄우기
    $('#summernote').summernote({
            height: 300,                 // set editor height
            callbacks: {	//썸머노트는 제출전에 이벤트를 기본적으로 막아두지만 콜백을 통하여 제출전에 이벤트 사용 가능
            onImageUpload : function(files) { //파일 보내기 이벤트
                for(var i in files){
                	sendFile(files[i]);
                }
            }
            },
            lang: "ko-KR" //언어 세팅
    });
    //축제 검색 창 띄우기
    $("#event").add("#eventname").add("#search").on("click",function(){
    	window.open("${ContextPath}/board/searchCulture","_blank",
		"width=500, height=570, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
    });
    $("input[name=title]").click(function(){
    	$(this).blur(function(){
    		if($(this).val() != "" || $(this).val() != null){
    			$("#notitle").hide();	
    		}
    	});
    });
    
});
function sendFile(file) { //파일을 아작스로 전송하여 사진을 저장한 후 이미지 링크를 리턴
	console.log("file = "+file);
    data = new FormData();
    data.append("uploadFile", file);
    $.ajax({
        data : data,
        type : "POST",
        url : "${ContextPath}/board/imageupload",
        cache : false,
        contentType : false,
        /* enctype: 'multipart/form-data', */
        processData : false,
        success : function(data) {
        	if(data == "noimage"){
        		alert("이미지 파일만 업로드 가능합니다.");
        	}
        	else{
        	$("#summernote").summernote('insertImage',data);
        	}
        },
        error : function(data){
        	alert("10MB까지의 파일만 업로드 가능합니다.");
        }
    });
}
function send(){
	if(checkit()){
		document.insert.submit();
	}
}
function back(){
	location.replace("${ContextPath}/board/reviewBoardMain?pagenum=<%=pagenum%>")
}
function DeleteLine(idx){
	if(idx == "1"){
		$("#nofno").hide();	
	}
}
function checkit(){
	var status = true;
	var level = "<%=level%>";
	if(level != "1"){
		if($("#eventname").val() == "" || $("#eventname").val() == null ){
			$("#nofno").show();
			status = false;
			return status;
		}
		else{
			$("#nofno").hide();
		}
	}
	if($("input[name=title]").val() == "" || $("input[name=title]").val() == null){
		$("#notitle").show();
		status = false;
		return status;
	}
	else{
		$("#notitle").hide();
	}
	return status;
}
/*function select(){
	검색전에 미리 행사분류하기
	var type=$("#select option:selected").val();
		window.open("${ContextPath}/culture/searchCulture?type="+type, "_blank",
		"width=500, height=650, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
}*/
</script>

</body>
</html>
