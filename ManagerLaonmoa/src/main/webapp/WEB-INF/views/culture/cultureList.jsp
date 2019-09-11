<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<%@ include file="/resources/css/adminmain.css"%>
<%@ include file="/resources/css/dropdown.css"%>
<script src="/resources/js/submitCheck.js"></script>
<style>
.txt_post {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 1; /* 라인수 */
    -webkit-box-orient: vertical;
    word-wrap:break-word; 
  }
.dropbtn {
  min-width: 50px;
}
</style>
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
<div class="main">
	<div class="main_menu_in"><%@ include file="../include/adminMenu.jsp"%></div>
	<div class="sub"><div class="out"><div class="in">
	<h3>문화정보리스트보기</h3><br>
		<table class="table_style" style="width: 100%">
			<thead>
				<tr>
					<td><div class="dropdown">
							<button class="dropbtn">타입
							<span class="glyphicon glyphicon-menu-down" aria-hidden="true" style="font-size:13px;"></span>
							</button>
							<div class="dropdown-content">
								<a href="${ContextPath}/admin/festival?pagenum=1&contentnum=10" id="level" value="7">축제</a> <a
								
									href="${ContextPath}/admin/drama?pagenum=1&contentnum=10&level=8">연극</a> <a
									href="${ContextPath}/admin/musical?pagenum=1&contentnum=10&level=9">뮤지컬</a> <a
									href="${ContextPath}/admin/show?pagenum=1&contentnum=10&level=10">전시회</a>
							</div>
						</div></td>
					<td>행사 이름</td>
					<td>시작일~<br>종료일</td>
					<td>지역</td>
					<td>내용</td>
					<td>축제종류</td>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list }">
					<tr class="td_style"><td colspan="7">리스트가 존재하지 않습니다.</td></tr>
				</c:if>
				<c:forEach var="list" items="${list}">
					<tr class="td_style">
						<td><c:choose>
								<c:when test="${list.level == 7}">
											축제
										</c:when>
								<c:when test="${list.level ==8 }">
											연극
							</c:when>
								<c:when test="${list.level==9 }">
											뮤지컬
							</c:when>
								<c:when test="${list.level==10 }">
											전시회
							</c:when>
							</c:choose></td>
						<td><a
							href="${ContextPath}/admin/cultureDetail?fno=${list.fno }">
								<c:choose>
									<c:when test="${fn:length(list.fname) > 12}">
										<c:out value="${fn:substring(list.fname,0,11)}" />...
	    							      </c:when>
									<c:otherwise>
										<c:out value="${list.fname}" />
									</c:otherwise>
								</c:choose>
							</a></td>
						<td>${list.sdate }~<br>${list.edate }</td>
						<td>
							<c:choose>
								<c:when test="${fn:length(list.location_1) > 12}">
									<c:out value="${fn:substring(list.location_1,0,11)}" />...
    							      </c:when>
								<c:otherwise>
									<c:out value="${list.location_1}" />
								</c:otherwise>
							</c:choose>
							<br>${list.location_2 }
						</td>
						<td>
							<c:choose>
								<c:when test="${fn:length(list.fcontent) > 12}">
									<c:out value="${fn:substring(list.fcontent,0,11)}" />...
    							      </c:when>
								<c:otherwise>
									<c:out value="${list.fcontent}" />
								</c:otherwise>
							</c:choose>
						</td>
						<td>${list.kind }</td>
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
		<div>
			<form action="${ContextPath}/admin/cultureSearch?pagenum=1&contentnum=10" method="post" name="frm">
				<table style="margin: 0 auto;">
					<tr>
						<td>
							<!-- 검색조건 -->
							<select id="type" name="type" class="selectpicker"
								style="height: 35px">
								<option value="">검색조건</option>
								<option value="culturename">문화정보이름</option>
								<option value="location">지역</option>
							</select>
						</td>
						<td>
							<!-- 검색내용 입력 -->
							<input type="text" name="value" id="value" style="height: 35px;">
						</td>
						<td>
							<!-- 검색버튼 -->
							<button id="submit" class="searchbutton" aria-label="Left Align" >
								<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
							</button>
						</td>
					</tr>
				</table>
			</form>
		</div></div></div>
	</div>
</div>
<script>
var value ;
	$("#submit").click(function(){
		//value = $("#value").val();
		value = 1;
	})
	function page(idx){
		var pagenum = idx;
		var value = "<%=request.getParameter("value")%>"; 
		var type ="<%=request.getParameter("type")%>";
		var level ="<%=request.getParameter("level")%>";
		
		if ( value== "null" || type =="null"){
			location.href="${ContextPath }/admin/cultureList?pagenum="+pagenum+"&contentnum=10";
		}else if(value != "null" ){
			
			location.href="${ContextPath }/admin/cultureSearch?pagenum="+pagenum+"&contentnum=10&value="+value+"&type="+type;
		}
		if (level == 8){
			location.href="${ContextPath}/admin/drama?pagenum="+pagenum+"&contentnum=10&level=8";
		}else if (level ==9){
			location.href="${ContextPath}/admin/musical?pagenum="+pagenum+"&contentnum=10&level=9";
		}else if (level == 10){
			location.href="${ContextPath}/admin/show?pagenum="+pagenum+"&contentnum=10&level=10";
		}
	}
</script>
</body>
</html>