<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<link href="/resources/css/dropdown.css" rel="stylesheet">
</head>
<%String pagenum = request.getParameter("pagenum"); %>
<%String keyword = request.getParameter("keyword"); %>
<%String searchmember = request.getParameter("searchmember"); %>
<body>
	<%@ include file="../include/Header.jsp"%>

<div class="main">
<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub"><div class="out"><div class="in">
		<h3>회원정보</h3><br>
		<table class="table_style" style="width: 100%;">
			<thead>
				<tr align="center">
					<td width="100">Id</td>
					<td width="80">Name</td>
					<td width="200">Email</td>
					<td width="80">Tel</td>
					<td width="130">Address</td>
					<td width="80">
						<div class="dropdown">
							<button class="dropbtn">&nbsp;경고횟수&nbsp;
							<span class="glyphicon glyphicon-menu-down" aria-hidden="true" style="font-size:13px;"></span></button>
							<div class="dropdown-content">
								<a href="javascript:max(1)">많은순</a> 
								<a href="javascript:max(0)">적은순</a>
							</div>
						</div>
					</td>
					<td width="80">탈퇴여부</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr class="td_style"><td colspan="8">리스트가 존재하지 않습니다.</td></tr>
				</c:if>
				<c:forEach var="list" items="${list}">
					<tr align="center" class="td_style">
						<td><a style="color: blue" href="memberView?id=${list.id}&pagenum=<%=pagenum%>&level=11">${list.id}</a>
						</td>
						<td>${list.name }</td>
						<td>${list.email }</td>
						<td>${list.tel }</td>
						<td style="font-size: 13px;">
							<c:choose>
								<c:when test="${fn:length(list.address_1) > 12}">
									<c:out value="${fn:substring(list.address_1,0,11)}" />...
    							      </c:when>
								<c:otherwise>
									<c:out value="${list.address_1}" />
								</c:otherwise>
							</c:choose>
						</td>
						<td>${list.warcnt }</td>
						<td><c:set var="secession" value="${list.secession }" /> <c:if
								test="${secession eq 0 }">
								<c:out value="사용중" />
							</c:if> <c:if test="${secession ne 0 }">
								<c:out value="탈퇴" />
							</c:if></td>
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
		<c:forEach begin="${page.getStartpage() }" end="${page.getEndpage()}" var="idx">
		<li><a href="javascript:page(${idx});">${idx}</a></li>
  			</c:forEach>
		<li>
  			<c:if test="${page.next }">	
		      <a href="javascript:page(${page.getEndpage()+1 });" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </c:if>
		</li>
  			  </ul>
				</nav>
			<!-- 검색내용 입력 -->
		<form id="form" method="get" action="${ContextPath }/admin/search">
			<table style="margin: 0 auto;">
				<tr>
					<td><select name="searchmember" class="selectpicker"
						style="height: 35px">
							<option value="searchall">ID+이름+주소</option>
							<option value="searchid">ID 검색</option>
							<option value="searchname">이름 검색</option>
							<option value="searchaddress">주소 검색</option>
					</select></td>
					<td>
					<input type="text" name="keyword" placeholder=" 검색" style="height: 35px;">
					<input type="hidden" name="pagenum" value="<%=pagenum%>">
					</td>
					<td>
						<!-- 검색버튼 -->
						<button type="button" class="searchbutton"
							aria-label="Left Align" onclick="submit()">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button>
					</td>
				</tr>
			</table>
		</form>
	</div></div></div>
</div>
<script>
	function submit() {
		$("#form").submit();
	}
	function page(idx){
		var pagenum = idx;
		var keyword = "<%=keyword%>";
		var searchmember = "<%=searchmember%>";
		if(keyword != "" || keyword != null){
			location.replace("${ContextPath }/admin/search?pagenum="
					+pagenum+"&level=11&keyword="+keyword+"&searchmember="+searchmember);
		}
		else{
			location.replace("${ContextPath }/admin/search?pagenum="+pagenum+"&level=11");	
		}
		
	}
	function max(idx){
		var pagenum = "<%=pagenum%>";
		var keyword = "<%=keyword%>";
		var searchmember = "<%=searchmember%>";
		if(!(keyword == "" || keyword == null || keyword == "null")){
			location.replace("${ContextPath }/admin/search?pagenum="
			+pagenum+"&level=11&keyword="+keyword+"&searchmember="+searchmember+"&max="+idx);
		}
		else{
			location.replace("${ContextPath}/admin/memberList?pagenum="+pagenum+"&max="+idx+
					"&level=11");
		}
	}
</script>
</body>
</html>
