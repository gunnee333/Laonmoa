<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<div class="box-collapse">
	<div class="title-box-d">
		<h3 class="title-d">라온모아 검색</h3>
	</div>
	<span class="close-box-collapse right-boxed ion-ios-close"></span>
	<div class="box-collapse-wrap form">
		<form class="form-a" name="searchfrm" method="get">
			<div class="row">
				
				<div class="col-md-12 mb-2">
					<div class="form-group">
						<label for="keyword">키워드</label> <input type="text"
							class="form-control form-control-lg form-control-a"
							placeholder="Keyword" name="keyword">
					</div>
				</div>
				
				<div class="col-md-6 mb-2">
					<div class="form-group">
						<label for="type">공연 종류</label> 
						<select class="form-control form-control-lg form-control-a" id="type" name="type">
							<option value="search_allF">전체</option>
							<option value="search_festival">축제</option>
							<option value="search_play">연극</option>
							<option value="search_musical">뮤지컬</option>
							<option value="search_exhibition">전시회</option>
						</select>
					</div>
				</div>
				<div class="col-md-6 mb-2">
					<div class="form-group">
						<label for="city">도시</label> <select
							class="form-control form-control-lg form-control-a" id="city" name="city">
							<option value="전체">전체 지역</option>
							<option value="서울">서울</option>
							<option value="부산">부산</option>
							<option value="대구">대구</option>
							<option value="인천">인천</option>
							<option value="광주">광주</option>
							<option value="대전">대전</option>
							<option value="울산">울산</option>
							<option value="강원도">강원도</option>
							<option value="충청남도">충청남도</option>
							<option value="충청북도">충청북도</option>
							<option value="전라남도">전라남도</option>
							<option value="전라북도">전라북도</option>
							<option value="경상북도">경상북도</option>
							<option value="경상남도">경상남도</option>
							<option value="제주">제주도</option>
						</select>
					</div>
				</div>
				<div class="col-md-6 mb-2">
					<div class="form-group">
						<label for="month">날짜</label> <select
							class="form-control form-control-lg form-control-a" id="month" name="month">
							<option value="all">전체</option>
							<option value="01">1월</option>
							<option value="02">2월</option>
							<option value="03">3월</option>
							<option value="04">4월</option>
							<option value="05">5월</option>
							<option value="06">6월</option>
							<option value="07">7월</option>
							<option value="08">8월</option>
							<option value="09">9월</option>
							<option value="10">10월</option>
							<option value="11">11월</option>
							<option value="12">12월</option>
						</select>
					</div>
				</div>

				<div class="col-md-12">
					<button type="submit" class="btn btn-b" id="btnSearch">검색</button>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	var checkSearch = true;
	$(document).ready(function(){
		$("#btnSearch").click(function() {
			var keyword = $('input[name=keyword]').val();
			var searchurl = "${ContextPath}/main/searchMain?pagenum=1";
			/* alert(searchurl); */
			if(checkSearch){
				searchurl += "&keyword=" + keyword;
				document.searchfrm.action = searchurl;
				/* alert("주소 :: " + document.searchfrm.action); */
				document.searchfrm.submit();
			}
		});
	});
</script>