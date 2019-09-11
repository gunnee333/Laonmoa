<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
</head>
<%String pagenum = request.getParameter("pagenum"); %>
<%String level = request.getParameter("level"); %>
<%String max = request.getParameter("max"); %>
<body>
	<%@ include file="../include/Header.jsp"%>

	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub"><div class="out"><div class="in">
			<h3>상세회원정보</h3><br>
			<div>
			<table class="table_style" style="border-spacing: 5px; border-collapse: separate;">
				<tr class="td_style">
					<td width="150px">아이디</td>
					<td>${detail.id }</td>
					<td style="display:none"><input type="text" value=${detail.id } id="id"></td>
				</tr>
				<tr class="td_style">
					<td>이름</td>
					<td>${detail.name }</td>
				</tr>
				<tr class="td_style">
					<td>이메일</td>
					<td>${detail.email }</td>
				</tr>
				<tr class="td_style">
					<td>전화번호</td>
					<td>${detail.tel }</td>
				</tr>
				<tr class="td_style">
					<td>주소</td>
					<td>${detail.address_1 }<br>${detail.address_2}</td>
				</tr>
				<tr class="td_style">
					<td>블랙리스트</td>
					<td>
						<c:set var="blacklist" value="${detail.level }" />
						<c:if test="${blacklist eq 2 }">
							<c:out value="블랙리스트" />
						</c:if>
						<c:if test="${blacklist eq 11 }">
							<c:out value="일반회원" />
						</c:if>
						<c:if test="${blacklist eq 1 }">
							<c:out value="관리자" />
						</c:if>
					</td>
				</tr>
				<tr class="td_style">
					<td>탈퇴여부</td>
					<td>
						<c:set var="secession" value="${detail.secession }" />
						<c:if test="${secession eq 0}">
							<c:out value="사용중인 회원" />
						</c:if>
						<c:if test="${secession ne 0}">
							<c:out value="탈퇴한 회원" />
						</c:if>
					</td>
				</tr>
				<tr class="td_style">
					<td>경고횟수</td>
					<td>${detail.warcnt }</td>
				</tr>
			</table>
		</div>
		<br><br>
		<div>
			<table style="border-spacing: 5px; border-collapse: separate;">
				<tr>
					<td><input type="button" value="회원정보 수정" onclick="update()" class="btn laonmoabtn"></td>
					<td><input type="button" value="회원 삭제" onclick="deletemember()" class="btn laonmoabtn"></td>
					<td><input type="button" value="목록" onclick="Cencel()" class="btn laonmoabtn"></td>
				</tr>
			</table>
		</div></div></div>
	</div></div>
<script>
	function update(){
		var id = "${detail.id}";
		var level = "${detail.level}";
		var pagenum = "<%=pagenum%>";
		location.replace("${ContextPath}/admin/memberUpdate?id="+id+"&level="+level+"&pagenum="+pagenum);
	}
	function deletemember(){
			var query={
				id:$("#id").val()
			};
		$.ajax({
			type:"get",
			url:"/admin/recmemberView",
			data:query,
			success:function(data){
				location.reload();
			}
		});
}
	function Cencel(){
		var level = "<%=level%>";
		if(level == "11"){
			location.replace("${ContextPath}/admin/memberList?pagenum=<%=pagenum%>&level=11");
		}
		else if(level == "1"){
			location.replace("${ContextPath}/admin/adminList?pagenum=<%=pagenum%>&level=1");
		}
		else{
			location.replace("${ContextPath}/admin/blackList?pagenum=<%=pagenum%>&level=2");
		}
	}
</script>
</body>
</html>
