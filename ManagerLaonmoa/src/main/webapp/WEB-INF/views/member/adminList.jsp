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
<%String pagenum = request.getParameter("pagenum");%>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
		<div class="sub"><div class="out"><div class="in">
			<h3>관리자정보</h3><br>
			<table class="table_style" style="width: 100%;">
				<thead>
					<tr>
						<td>Id</td>
						<td>Name</td>
						<td>Email</td>
						<td>Tel</td>
						<td>Address</td>
					</tr>
				</thead>
					<tbody>
						<c:if test="${empty list }">
							<tr class="td_style"><td colspan="5">리스트가 존재하지 않습니다.</td></tr>
						</c:if>
						<c:forEach var="list" items="${list}">
							<tr class="td_style">
								<td><a style="color: blue" href="memberView?id=${list.id}&pagenum=<%=pagenum%>&level=1">${list.id }</a></td>
								<td>${list.name }</td>
								<td>${list.email }</td>
								<td>${list.tel }</td>
								<td>${list.address_1 }</td>
							</tr>
						</c:forEach>
					</tbody>
			</table>
			<nav>
 		 <ul class="pagination">
 		 <li>
 		 	<c:if test="${page.prev}">
		      <a href="javascript:page(${page.getStartpage()-1 });" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </c:if>
  		 </li>
		<c:forEach begin="${page.getStartpage()}" end="${page.getEndpage()}" var="idx">
		<li><a href="javascript:page(${idx});">${idx}</a></li>
  			</c:forEach>
		<li>
  			<c:if test="${page.next }">	
		      <a href="javascript:page(${page.getEndpage()+1});" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </c:if>
		</li>
  			  </ul>
				</nav>
		</div></div></div>
	</div>
<script>
function page(idx){
	location.replace("${ContextPath}/admin/adminList?pagenum="+idx);
}
</script>
</body>
</html>