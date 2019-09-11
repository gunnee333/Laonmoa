<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<style>
/* Left column (menu) */
.left {
  width: 300px;
  height: 100vh;
  padding: 30px 0;
  background-color: #323E4D;
}

/* Style the navigation menu inside the left column */
#myMenu {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

#myMenu li a {
  padding: 10px;
  padding-left: 80px;
  text-decoration: none;
  color: white;
  display: block;
  font-size: 18px;
}

#myMenu li a:hover {
  background-color: #6988AF;
}
.menuStyle{
  font-size:23px; 
  padding: 5px;
  padding-left:50px;
  color: white;
  font-weight: bold;
  /* margin-top: 10px; */
}

.main_pic{
	width: 130px; 
	height: 55px;
	margin-left: 80px;
	margin-bottom: 10px; 
	margin-top: 20px;
}

#warCntAlarm, #noteAlarm{
	color: white;
}
#main-menu{
	position: fixed;
}
.menumargin{
	margin-top: 30px;
}
</style>

<div id="main-menu">

 <div class="left">
    <ul id="myMenu">
    	<a href="${ContextPath }/"><img src="/resources/img/LOGOFONT.png" class="main_pic"></a>
      	<div class="menuStyle menumargin">회원관리</div>
        <li><a href="${ContextPath }/admin/adminList?pagenum=1&level=1">관리자 보기</a></li>
        <li><a href="${ContextPath }/admin/memberList?pagenum=1&level=11">회원정보 보기</a></li>
     	<li><a href="${ContextPath }/admin/blackList?pagenum=1&level=2">블랙리스트 보기</a></li>
        
      <div class="menuStyle">문화 정보 관리</div>
      <li><a href="${ContextPath }/admin/cultureList?pagenum=1&contentnum=10">문화 정보 보기</a></li>
      <li><a href="${ContextPath }/admin/cultureInsert">문화 정보 추가</a></li>
      
      <div class="menuStyle">게시글 관리</div>
      <li><a href="${ContextPath }/admin/board/noticeList?del=-1&num=1&level=3">공지사항 관리</a></li>
      <li><a href="${ContextPath }/admin/board/freeBoardList?del=-1&num=1">게시글 관리</a></li>
      <li><a href="${ContextPath }/admin/replyList?num=1&contentnum=15">댓글 관리</a></li>
      
      <div class="menuStyle">신고 내역 관리</div>
      <li><a href="${ContextPath }/admin/warList">신고 내역 보기<span id="warCntAlarm"></span></a></li>
      
      <div class="menuStyle">쪽지 관리</div>
      <li><a href="${ContextPath }/admin/noteSend">쪽지 보내기</a></li>
      <li><a href="${ContextPath }/admin/mynoteList">쪽지 보관함<span id="noteAlarm"></span></a></li>
      <li><a href="${ContextPath }/admin/noteList">전체 쪽지 보기</a></li>
      
    </ul>
 </div>
</div>
<script>
	$(document).ready(function(){
		if(!("${id}" == null || "${id}" == "")){
			$.ajax({
				type: "POST",
				url: "${ContextPath}/admin/notealarm",
				success: function(data){
					$("#noteAlarm").text("(" + data + ")").show();
				}
			});
			
			$.ajax({
				type: "POST",
				url: "${ContextPath}/admin/waralarm",
				success: function(data){
					$("#warCntAlarm").text("(" + data + ")").show();
				}
			});
		}
	});
</script>
