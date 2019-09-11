<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<body>
	<%@ include file="../include/Header.jsp"%>
<% String bnum = request.getParameter("bnum"); %>
<% String level = request.getParameter("level"); %>
<% String num = request.getParameter("num"); %>
<% String max = request.getParameter("max"); %>
<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub"><div class="out"><div class="in">
		<h3>댓글 상세보기</h3>
		<br>
		<div>
			<table class="board_table">
				<tr>
					<td class="td_style td1_style">${boardDetail.title}</td>
					<td class="td_style td2_style">
						<c:choose>
							<c:when test="${boardDetail.level == 3 }">
								자유게시판
							</c:when>
							<c:when test="${boardDetail.level == 4 }">
								리뷰게시판
							</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td class="td_style td1_style">${boardDetail.id}</td>
					<td class="td_style td2_style"><fmt:formatDate var="date" value="${boardDetail.date}" pattern="yyyy-MM-dd" />
								${date }</td>
				</tr>
				<tr>
					<td colspan="2"style="height: 500px; vertical-align: top; text-align: left; padding: 20px;" class="td_style td2_style">
						<c:choose>
							<c:when test="${fn:length(boardDetail.content) > 100}">
								${fn:substring(boardDetail.content,0,99)}...
					      			</c:when>
							<c:otherwise>
								${boardDetail.content }
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</table>
		</div>
		<br>
		<table class="table" style="text-align: center;">
			<thead>
				<tr>
					<td><input type='checkbox' id="allCheck" onclick="check(this)" /></td>
					<td width="700px">댓글 내용</td>
					<td>작성자ID</td>
					<td>작성일</td>
					<td>삭제여부</td>
				</tr>
			</thead>

			<!-- 해당 게시판에 있는  댓글리스트 불러오기 -->
			<c:forEach items="${replyDetail }" var="list">
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="5">쪽지가 없습니다.</td>
							</tr>
						</c:when>
					</c:choose>
					<tr>
						<td><input type='checkbox' name="checkRow" id="checkbox"
							onclick="check(this)" value="${list.rnum}" /></td>
						<td>${list.rcontent}</td>
						<td>${list.id}</td>
						<td>
							<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd" />
							${date}</td>
						<td><span id="del"><c:if test="${list.del ==0}">
									<c:out value="" />
								</c:if> <c:if test="${list.del ==1}">
									<c:out value="삭제됨" />
								</c:if></span></td>

					</tr>
			</c:forEach>
		</table>
		
		<!-- 페이징... -->
		<c:forEach begin="1" end="${pageNum }" var="num">
			<a href="${ContextPath }/admin/replyList?num=${num }&max=${max}">[${num }]</a>
		</c:forEach>
		<br>
		
		<button type="button" id="replydelete" class="btn laonmoabtn">삭제처리</button>
		<input type="button" id="replyCom" value="삭제 취소" class="btn laonmoabtn">
		<button class="btn laonmoabtn" onclick="back();">취소</button>
	</div></div></div>
</div>

<script>
//검색 조건 입력안했을때
$(document).ready(function() {
	// 체크박스 전체 클릭시
	$("#allCheck").click(function() {
		//만약 전체 선택 체크박스가 체크된상태일경우 
		if ($("#allCheck").prop("checked")) {
			//해당화면에 전체 checkbox들을 체크해준다 
			$("input[type=checkbox]").prop("checked", true);
			// 전체선택 체크박스가 해제된 경우 
		} else {
			//해당화면에 모든 checkbox들의 체크를해제시킨다.
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
	
	$("#replyCom").click(function(){
		$("input[name=checkRow]:checked").each(function() {
			var tr_value = $(this).val();
			if (tr_value != null) {
				$.ajax({
					type:"get",
					url:"${ContextPath}/admin/replyCencle?rnum=" + tr_value,	
					success: function(data){
						location.reload();
					},error:function(request,status,error){
						 alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					}
				});
			}
		});
	});
	
	$("#replydelete").click(function() {
		if($("input:checkbox[name=checkRow]").is(":checked") == true){
			$("input[name=checkRow]:checked").each(function() {
				var tr_value = $(this).val();
				console.log("before:"+tr_value);
				var data ={}
				if (tr_value != null) {
					$.ajax({
						type : "get",
						url : "${ContextPath}/admin/replyCom?rnum=" + tr_value,							
						data : data,
						success : function(data) {
							location.reload();
						},
					});
				}
			});
		} else {
			alert("삭제할 댓글을 선택해주세요.");
		}

		
	});
});

	//테이블 색표시
	function check(it) {
		tr = it.parentNode.parentNode;
		tr.style.backgroundColor = (it.checked) ? "#F5D0A9" : "white";
	}
	
	function back(){
		var referrerUrl = document.referrer;
		var cut = referrerUrl.match("warView");
		
		if(cut == "warView"){
			location.href = "${ContextPath}/admin/replyList?num=1";
		} else{
			location.href = "${ContextPath}/admin/replyList?&num=<%=num%>&max=<%=max%>";
		}
	}
</script>
<input type="hidden" id="bnum" value="<%=bnum%>">
<input type="hidden" id="level" value="<%=level%>">
<input type="hidden" id="num" value="<%=num%>">
<input type="hidden" id="max" value="<%=max%>">
</body>



</html>