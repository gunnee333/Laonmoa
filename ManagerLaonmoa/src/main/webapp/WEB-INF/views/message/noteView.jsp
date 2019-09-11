<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			<!-- 메인 -->
			<table style="display: inline-block;">
				<thead>
					<tr>
						<td><h3>쪽지내용보기</h3></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<table style="text-align: left; border-spacing: 20px 0px; border-collapse: separate; margin: 20px 0; display: inline-block;">
								<tr>
									<td style="text-align: right;">열람여부 :</td>
									<td>
										<c:if test="${list.ifread == 0 }">
											<c:out value="미열람" />
										</c:if>
										<c:if test="${list.ifread == 1 }">
											<c:out value="열람" />
										</c:if>
									</td>
									<td style="text-align: right;">작성일 :</td>
									<td>
										<fmt:formatDate var="date" value="${list.date}" pattern="yyyy-MM-dd HH:mm" />
										${date}</td>
								</tr>
								<tr>
									<td style="text-align: right;">발송인 :</td>
									<td>${list.sendid }</td>
									<td style="text-align: right;">수신인 :</td>
									<td>${list.recid }</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" class="form-control" value="${list.mtitle }" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>
							<textarea class="form-control" style="height: 300px;" readonly="readonly">${list.mcontent }</textarea>
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			<a href="${ContextPath }/admin/delete?mnum=${list.mnum }"><button class="btn laonmoabtn">쪽지삭제</button></a>
			<a onclick="back();"><button class="btn laonmoabtn">뒤로가기</button></a>
			<!-- 메인끝 -->
		</div></div></div>
	</div>
	<script>
		// 뒤로가기 (전페이지가 쪽지보내기이면 쪽지리스트로 이동)
		function back(){
			var referrerurl = document.referrer;
			var cut = referrerurl.match("noteSend");
			
			if(cut != "noteSend"){
				location.href = referrerurl;
			} else{
				location.href = "${ContextPath}/admin/mynoteList";
			}
		}
	</script>
</body>
</html>