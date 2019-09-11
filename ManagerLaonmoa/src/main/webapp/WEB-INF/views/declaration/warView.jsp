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
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub"><div class="out"><div class="in">
		<!-- 메인 시작 -->
			<h3>신고내역상세보기</h3><br>
		 	<table class="table_style">
		 		<tr class="td_style">
		 			<td align="right" width="130px">신고자 ID : </td>
		 			<td>${warDetail.whoid }</td>
		 		</tr>
		 		<tr class="td_style">
		 			<td align="right">신고당한 ID : </td>
		 			<td>${warDetail.warid }</td>
		 		</tr>
		 		<c:choose>
		 			<c:when test="${warDetail.level == 3 }"> <!-- 신고당한 글이 자유게시판 글일때 -->
		 				<tr class="td_style">
		 					<td align="right">게시글 제목 : </td>
		 					<td><a href="${ContextPath }/admin/board/freeBoardDetail?bnum=${boardDetail.bnum }">${boardDetail.title }</a></td>
		 				</tr>
		 				<tr class="td_style">
		 					<td align="right">게시글 내용 : </td>
		 					<td>
		 						<c:choose>
									<c:when test="${fn:length(boardDetail.content) > 50}">
										${fn:substring(boardDetail.content,0,49)}...
					      			</c:when>
									<c:otherwise>
										${boardDetail.content }
									</c:otherwise>
								</c:choose>
		 					</td>
		 				</tr>
		 			</c:when>
		 			<c:when test="${warDetail.level == 4 }"> <!-- 신고당한 글이 리뷰게시판 글일때 -->
		 				<tr class="td_style">
		 					<td align="right">게시글 제목 : </td>
		 					<td><a href="${ContextPath }/admin/board/reviewBoardDetail?bnum=${boardDetail.bnum }">${boardDetail.title }</a></td>
		 				</tr>
		 				<tr class="td_style">
		 					<td align="right">게시글 내용 : </td>
		 					<td>
		 						<c:choose>
									<c:when test="${fn:length(boardDetail.content) > 50}">
										<script>
											var content = '${boardDetail.content}'.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig,"");
											content = content.substring(0,49);
											document.write(content);
										</script>
										...
					      			</c:when>
									<c:otherwise>
										${boardDetail.content}
									</c:otherwise>
								</c:choose>
		 					</td>
		 				</tr>
		 			</c:when>
		 			<c:when test="${warDetail.level == 5 || warDetail.level == 6 }"> <!-- 신고당한 글이 댓글일때 -->
		 				<tr class="td_style">
		 					<td colspan="2" align="center">
		 					<a href="${ContextPath }/admin/replyView?bnum=${replyDetail.bnum}&level=${warDetail.level}">게시글보러가기</a></td>
		 				</tr>
		 				<tr class="td_style">
		 					<td align="right">댓글내용 : </td>
		 					<td>${replyDetail.rcontent }</td>
		 				</tr>
		 			</c:when>
		 		</c:choose>
		 		<tr class="td_style">
		 			<td align="right">신고내용 : </td>
		 			<td>${warDetail.wcontent }</td>
		 		</tr>
		 		<tr class="td_style">
		 			<td align="right">신고일 : </td>
		 			<td>
		 				<fmt:formatDate var="date" value="${warDetail.wdate}" pattern="yyyy-MM-dd" />
		 				${date }
		 			</td>
		 		</tr>
		 		<tr class="td_style">
		 			<td align="right">처리여부 : </td>
		 			<td><span id="process"></span></td>
		 		</tr>
		 	</table>
		 	<br><br>
			 <div>
			 	<button type="button" id="warRec" style="display:none;" class="btn laonmoabtn">신고접수</button>
			 	<a href="${ContextPath }/admin/warDis?wnum=${warDetail.wnum }"><button id="warDis" style="display:none;" class="btn laonmoabtn">신고기각</button></a>
			 	<button type="button" onclick="location.href = document.referrer;" class="btn laonmoabtn">목록으로</button>
			 </div>
		<!-- 메인 끝 -->
		</div></div></div>
	</div>
	<script>
		$(document).ready(function(){
			if("${warDetail.process }" == 1){
				$("#process").text("처리").show();
			} else{
				$("#process").text("미처리").show();
				$("#warRec").show();
				$("#warDis").show();
			}
			
			
			$("#warRec").click(function(){
				var query = {
						"wnum": "${warDetail.wnum }",
						"warid": "${warDetail.warid }"
				}
				$.ajax({
					type: "post",
					url: "${ContextPath}/admin/warRec",
					data: query,
					success: function(data){
						if(data > 0){
							$("#process").text("처리").show();
							$("#warRec").hide();
							$("#warDis").hide();
						} else{
							alert("처리실패");
						}
					},
					error: function(data){
						alert("알 수 없는 오류가 발생했습니다.");
					}
				});
			});
		});
	</script>
</body>
</html>