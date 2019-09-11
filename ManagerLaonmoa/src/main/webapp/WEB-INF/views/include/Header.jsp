<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
 	<div class="header_edit">
		<c:if test="${id!=null }">
			<div style="text-align: right; padding-right: 30px;">
				<div style="display: inline-block; margin-right: 10px;">${id}님 환영합니다.</div>
				<a href="/logout">
					<button class="btn laonmoabtn" type="button" style="color: white; display: inline-block;">로그아웃</button>
				</a>
			</div>
		</c:if>
	</div>
