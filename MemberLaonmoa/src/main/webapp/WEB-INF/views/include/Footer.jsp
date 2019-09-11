<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<style>
footer{
	margin-top: 150px;
}
.grid-container {
/* border: 1px solid blue; */
  display: grid;
  grid-template-columns: 30% 70%;
  padding: 10px;
  width: 800px;
  margin: 0 auto;
}

.grid-item {
  padding: 20px;
  /* border: 1px solid red; */
}
.footer_img{
	width: 150px;
	padding-top: 20px;
	
}
</style>

<c:set var="ContextPath" value="${pageContext.request.contextPath}" />

<footer>
	<div class="grid-container">
		<div class="grid-item">
			<img src="http://hoohee0331.cdn3.cafe24.com/img/laonmoa_black.png" class="footer_img">
		</div>
		
		<div class="grid-item">
			<a href="${ContextPath }/laonmoa">&copy; 라온모아프로젝트 <span
				class="color-a">유민웅 신지혜 이건희 김현성 추수아</span> "즐거움을 모으다."
			</a>
			<ul class="list-unstyled">
				<li class="color-a"><span class="color-text-a">Email .</span>
					laonmoa@gmail.com</li>
			</ul>
			<p class="copyright color-text-a">
					&copy; Copyright <span class="color-a">Laonmoa</span> 
					All Rights Reserved.
			</p>
		</div>
		
	</div>
</footer>
