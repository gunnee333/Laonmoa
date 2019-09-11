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
<%
	String pagenum = request.getParameter("pagenum");
%>

 <%String levelname=request.getParameter("level");
String name=null;%>
<%
	if(levelname.equals("7")){
		name = "축제 모아";
	}else if(levelname.equals("8")){
		name = "연극모아";
	}else if(levelname.equals("9")){
		name = "뮤지컬모아";
	}else if(levelname.equals("10")){
		name = "전시회모아";
	}
	%> 
</head>
<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans:400,300);
.tagcloud01 .tag_list li button {
	padding: 5px 10px;
	border-top-left-radius: 35px;
	border-top-right-radius: 35px;
	border-bottom-left-radius: 35px;
	border-bottom-right-radius: 35px;
}
.tagcloud01 div {
	width: 480px;
	margin: 5em auto 2.5em;
}
.tagcloud01 div:first-child {
	margin-top: 3em;
}
.tagcloud01 ul {
	margin-top: 10px;
	padding: 0;
	list-style: none;
}
.tagcloud01 ul li {
	display: inline-block;
	padding: 0;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	padding-inline-start: 20px;
}
.tagcloud01 ul li a {
	display: inline-block;
	margin-right: 0px;
	height: 28px;
	line-height: 28px;
	text-align: center;
	width: 60px;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	font-size: 15px;
	text-decoration: none;
	-webkit-transition: .2s;
	transition: .2s;
	cursor: pointer;
	
}
.tagcloud01 ul li a:hover {
	background-color: #FF7B22;
	border-radius: 30px;
	text-align: center;
	color: #fff !important;
}
.test {
	background-color: #FF7B22;
	border-radius: 30px;
	text-align: center;
	color: #fff !important;
}


.testcss {
	background-color: #FF7B22;
	border-radius: 30px;
	text-align: center;
	color: #fff !important;
}
.area_tagList {
	width: 350px;
	padding: 36px 0 20px;
	background-color: #f7f7f7;
	margin-left: 50px;
}
table, tr, td {
	border-top: 2px solid #D3D3D3;
	border-bottom: 2px solid #D3D3D3;
}
.festival_img {
	width: 150px;
	height: 100px;
	margin: 10px 20px;
}
.space_content {
	font-size: 13px;
	max-width: 600px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
.culture_th {
	font-size: 20px;
}
#culture_th1 {
	text-align: center;
	width: 150px;
}
#culture_th2 {
	text-align: right;
}
.culture_style {
	border-left: 0.5px solid gray;
	height: 15px;
}
table, tr, td {
	border-top: 2px solid #D3D3D3;
	border-bottom: 2px solid #D3D3D3 !important;
	border-bottom: none;
}
.festival_img {
	width: 150px;
	height: 100px;
	margin: 10px 20px;
}
.space_content {
	font-size: 13px;
	max-width: 600px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}
.hashtag {
	border: 1px solid red;
	height: 500px;
	width: 320px;
}
.pagination {
	margin: 60px 350px;
}
.page-link {
	display: block;
	padding: .5rem .75rem;
	margin-left: -1px;
	line-height: 1.25;
	color: #000;
	background-color: #fff;
	border: 1px solid #dee2e6;
}
.page-link:hover {
	background-color: #FF7B22;
	color: #fff;
}
.festival_font{
color: #000;
font-size: 18px;
font-weight: 600;
}

</style>
<script src="../resources/jQuery/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready(function() {
		$(".mouseoverin").mouseover(function(){
			//alert("모야 이해안감")
		})
		/* $(".mouseoverin").each(function() {
			$(this).click(function() {
				alert(request.getParameter("month"))
				$(this).css('background-color','#FF7B22');
				
				
			});
		}); */
	});
	function callFunction(){
		location.href="${ContextPath }/culture/date?month=1"
		//alert("들어오나");
		var query = 
		$.ajax({
			type : "get",
			url:"${ContextPath }/culture/date?month=1",
			success:function(data){
				//alert(data)
				if (data==0) {
					//alert("이런 성공에서 if");
					("#1month").css(".testcss");
				}
					
			},error:function(data){
				alert("알 수 없는 오류가 발생했습니다.")
			}
		})
		
	}
</script>
<body>
	<%
		int month;
	%>
	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Intro Single star /-->
	<section class="intro-single">
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-lg-8">
					<div class="title-single-box">
						<h1 class="title-single">
							 <%=name %> 
						</h1>
						<!-- <span class="color-text-a">#전체</span> -->
					</div>
				</div>
			 <div class="col-md-12 col-lg-4">
					<nav aria-label="breadcrumb"
						class="breadcrumb-box d-flex justify-content-lg-end">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/">메인으로</a></li>
							<li class="breadcrumb-item"><a href="#">라온모아</a></li>
							<li class="breadcrumb-item active" aria-current="page">축제모아</li>
						</ol>
					</nav>
				</div> 
			</div>
		</div>
	</section>
	<!--/ Intro Single End /-->

	<!--/ Agent Single Star /-->
	<section class="agent-single">
		<div class="container">
			<div class="row">
				<div class="col-sm-12">
					<div class="row">
						<div class="col-md-8">
							<div class="agent-avatar-box">
								<div id="festivallist">
									<table style="width:785px">
										<th class="culture_th" id="culture_th1">총${count}건</th>
										<th class="culture_th" id="culture_th2">
										<div class="dropdown">
												<button class="dropbtn" >
													<h5>진행여부</h5>
												</button>
												<div class="dropdown-content">
													<a href="${ContextPath }/culture/festivalList?pagenum=1&&level=<%=request.getParameter("level")%>&&month=0&value=">전체</a> 
													<a href="${ContextPath }/culture/startfestival?pagenum=1&level=<%=request.getParameter("level")%>&num=5">진행</a>
													<a href="${ContextPath }/culture/schedule?pagenum=1&level=<%=request.getParameter("level")%>&num=6">예정</a>
													<a href="${ContextPath }/culture/endfestival?pagenum=1&level=<%=request.getParameter("level")%>&num=7">마감</a>
												</div>
											</div> 
<%-- 											<a href="${ContextPath }/culture/Newest?pagenum=1&level=<%=request.getParameter("level")%>&num=3"
											class="culture_style" style="padding: 0 5px;">최신순</a>
										
 --%>										 <a href="${ContextPath }/culture/orderlove?pagenum=1&level=<%=request.getParameter("level")%>&num=4"
											class="culture_style" style="padding: 0 5px;">인기순</a></th>
										<c:if test="${empty list }">
											<tr><td colspan="2">리스트가 없습니다.</td></tr>
										</c:if>
										<c:forEach var="list" items="${list}">
											<tr>
												<td>
													<c:choose>
														<c:when test="${empty list.image }">
															<img src="http://hoohee0331.cdn3.cafe24.com/img/Noimg.png" class="festival_img" />
														</c:when>
														<c:otherwise>
															<img src="http://hoohee0331.cdn3.cafe24.com/resource/${list.image }" class="festival_img" />
														</c:otherwise>
													</c:choose>
												</td>
												<td><a
													href="${ContextPath }/culture/cultureDetailView?fno=${list.fno}"
													class="festival_font">${list.fname }</a><br>
													<fmt:formatDate var="sdate" value="${list.sdate}" pattern="yyyy-MM-dd" />
													<fmt:formatDate var="edate" value="${list.edate}" pattern="yyyy-MM-dd" />
													${sdate} ~ ${edate}<br />
													<p class="space_content">${list.fcontent }</p></td>
											</tr>
										</c:forEach>
									</table>
									<input type ="hidden" value="${id }" name="id" id="id"/>
								</div>
								
							</div>
						</div>


						<div class="col-md-12 col-lg-4">
							<div class="area_tagList">
								<div class="tagcloud01">
								
										<ul id="month">
											<li><a href="${ContextPath }/culture/festivalList?pagenum=1&&level=<%=request.getParameter("level") %>&&month=0&value=">#전체</a></li>
											<br>
											<li ><a  value="1" name="month" onclick="datefind(1)" id="1month">#1월</a></li>
											<li><a value="2" name="month" onclick="datefind(2)" id="2month">#2월</a></li>
											<li><a value="3" name="month" onclick="datefind(3)" id="3month">#3월</a></li>
											<li><a value="4" name="month" onclick="datefind(4)" id="4month">#4월</a></li>
											<br>
											<li><a value="5" name="month" onclick="datefind(5)" id="5month">#5월</a></li>
											<li><a value="6" name="month"onclick="datefind(6)" id="6month">#6월</a></li>
											<li><a value="7" name="month"onclick="datefind(7)" id="7month">#7월</a></li>
											<li><a value="8" name="month" onclick="datefind(8)" id="8month">#8월</a></li>
											<br>
											<li><a value="9" name="month" onclick="datefind(9)" id="9month">#9월</a></li>
											<li><a value="10" name="month" onclick="datefind(10)" id="10month">#10월</a></li>
											<li><a value="11" name="month" onclick="datefind(11)" id="11month">#11월</a></li>
											<li><a value="12" name="month" onclick="datefind(12)" id="12month">#12월</a></li>
										</ul>
								
									<hr width="300px">
									<ul>
										<li><a href="${ContextPath }/culture/festivalList?pagenum=1&&level=<%=request.getParameter("level") %>&&month=0&value=">#전체</a></li>
										<br>
										
										<li><a value="서울" name="lo" onclick="locationfind('서울')" id="seoul">#서울</a></li>
										<li ><a value="부산" name="lo" onclick="locationfind('부산')" id="busan">#부산</a></li> 
										<li><a value="대구" name="lo" onclick="locationfind('대구')" id="Daegu">#대구</a></li>
										<li><a value="인천" name="lo" onclick="locationfind('인천')" id="incheon">#인천</a></li>
										<br>
										<li><a value="광주" name="lo" onclick="locationfind('광주')" id="gwangju">#광주</a></li>
										<li><a value="대전" name="lo" onclick="locationfind('대전')" id="daejeon">#대전</a></li>
										<li><a value="울산" name="lo" onclick="locationfind('울산')" id="ulsan">#울산</a></li>
										<li><a value="충남" name="lo" onclick="locationfind('충청남도')" id="chungnam">#충남</a></li>
										<br>
										<li><a value="전북" name="lo" onclick="locationfind('전라북도')" id="jeonbuk">#전북</a></li>
										<li><a value="전남" name="lo" onclick="locationfind('전라남도')" id="jeonnam">#전남</a></li>
										<li><a value="경북" name="lo" onclick="locationfind('경상북도')" id="gyeongbuk">#경북</a></li>
										<li><a value="경남" name="lo" onclick="locationfind('경상남도')" id="gyeongnam">#경남</a></li>
										<br />										
										<li><a value="강원" name="lo" onclick="locationfind('강원도')" id="gangwon">#강원</a></li>
										<li><a value="충북" name="lo" onclick="locationfind('충청북도')" id="chungcheong">#충북</a></li>
										<li><a value="제주" name="lo" onclick="locationfind('제주')" id="jeju">#제주</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
	
				<!-- 페이징 -->
				
				<nav id="paging" style="display: none;">
					<div id="pagenum">
					<ul class="pagination">
						<c:if test="${page.prev }" >
							<li><a href="javascript:page(${page.getStartpage()-1})"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach begin="${page.getStartpage()}"
							end="${page.getEndpage()}" var="idx">
							<li><a href="javascript:page(${idx})">${idx}</a></li>
						</c:forEach>
						<c:if test="${page.next }">
							<li><a href="javascript:page(${page.getEndpage()+1})"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</ul>
					</div>
				</nav>
				<!-- 페이징 끝 -->
			</div>
		</div>
	</section>
	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->
	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>
	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>
</body>
<script>
	$(document).ready(function(){
		$("#paging").show();
	});
	var test;
	var monthcheck;
	var locationdate;
	var cancle;	
	
//날짜 태그
	function datefind(idx){
		 test=1;
		//alert(idx);
		/* $("#1month").attr('value') */
		$.ajax({
			async : true,
			type:"POST",
			url:"${ContextPath }/culture/date",
			data:{"month":idx,
				"pagenum":1,
				"level":<%=request.getParameter("level")%>},
			success:function(data){
				//$("#festivallist").load(data);
				console.log(data);
				var a = $(data).find("#festivallist");
				$("#festivallist").html(a);
				var b = $(data).find("#pagenum");
				$("#pagenum").html(b);
				
				data +=data
				if (idx == 1) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#1month").addClass('test');		
					monthcheck=1;
				} else if (idx ==2) {	
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#2month").addClass('test');
					monthcheck=2;
				} else if (idx ==3) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#3month").addClass('test');
					monthcheck=3;
				} else if (idx ==4) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#4month").addClass('test');
					monthcheck=4;
				} else if (idx==5) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#5month").addClass('test');
					monthcheck=5;
				} else if (idx == 6) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#6month").addClass('test');
					monthcheck=6;
				} else if (idx == 7) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#7month").addClass('test');
					monthcheck=7;
				} else if (idx == 8) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#8month").addClass('test');
					monthcheck=8;
				} else if (idx == 9) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#9month").addClass('test');
					monthcheck=9;
				} else if (idx == 10) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#10month").addClass('test');
					monthcheck=10;
				} else if (idx == 11) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#11month").addClass('test');
					monthcheck=11;
				} else if (idx == 12) {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#12month").addClass('test');
					monthcheck=12;
				}
				/* $("#1month").addClass('test'); */
			} ,
			error:function(data){
				alert("실패");
			}
		});
	}
	//지역 태그
	function locationfind(idx){
		test = 2;
		
		 $.ajax({
			async : true,
			type:"POST",
			url:"${ContextPath }/culture/location",
			data:{"value":idx,
				"pagenum":1,
				"level":<%=request.getParameter("level")%>},
			success:function(data){
				var a = $(data).find("#festivallist");
				$("#festivallist").html(a);
				var b = $(data).find("#pagenum");
				$("#pagenum").html(b);
				if (idx == '서울') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#seoul").addClass('test');
					locationdate = '서울'
				}if (idx =='부산') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#busan").addClass('test');
					locationdate = '부산';
				}if (idx =='대구') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#Daegu").addClass('test');
					locationdate = '대구';
				}if (idx == '인천') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#incheon").addClass('test');
					locationdate = '인천';
				}if (idx =='광주') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#gwangju").addClass('test');
					locationdate = '광주';
				}if (idx =='대전') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#daejeon").addClass('test');
					locationdate = '대전';
				}if (idx == '울산') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#ulsan").addClass('test');
					locationdate = '울산';
				}if (idx =='충청남도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#chungnam").addClass('test');
					locationdate = '충청남도';
				}if (idx =='전라남도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#jeonnam").addClass('test');
					locationdate = '전라남도';
				}if (idx == '전라북도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#jeonbuk").addClass('test');
					locationdate = '전라북도';
				}if (idx =='경상북도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#gyeongbuk").addClass('test');
					locationdate = '경상북도';
				}if (idx =='경상남도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#gyeongnam").addClass('test');
					locationdate = '경상남도';
				}if (idx =='강원도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#gangwon").addClass('test');
					locationdate = '강원도';	
				}if (idx =='충청북도') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#chungcheong").addClass('test');
					locationdate = '충청북도';	
				}
				if (idx =='제주') {
					$('a[name="lo"]').removeClass('test');
					$('a[name="month"]').removeClass('test');
					$("#jeju").addClass('test');
					locationdate = '제주';	
				}	
		} ,
			error:function(data){
				alert("실패");
			}
		});
	}
	function page(idx){
		var pagenum = idx;
		var month=monthcheck;		
		if (test == 2) {
			//alert("test === 22")		
			//alert(location);
			location.href="${ContextPath}/culture/location?value="+locationdate+"&&level=<%=request.getParameter("level")%>&&pagenum="+pagenum+"&month=0";
		}	
		else if (test == 1) {
			//alert($('a[name="month"]').attr('value'));
			//alert(monthcheck);
			location.href="${ContextPath}/culture/datepage?month="+month+"&&level=<%=request.getParameter("level")%>&&pagenum="+pagenum;
		}else if (<%=request.getParameter("num")%>==3){
			location.href="${ContextPath }/culture/Newest?pagenum="+pagenum+"&level=<%=request.getParameter("level")%>&num=3";
		}else if(<%=request.getParameter("num")%>==4){
			location.href="${ContextPath }/culture/orderlove?pagenum="+pagenum+"&level=<%=request.getParameter("level")%>&num=4"
		}else if(<%=request.getParameter("num")%>==5){
			location.href="${ContextPath }/culture/startfestival?pagenum="+pagenum+"&level=<%=request.getParameter("level")%>&num=5"
		}else if(<%=request.getParameter("num")%>==6){
			location.href="${ContextPath }/culture/schedule?pagenum="+pagenum+"&level=<%=request.getParameter("level")%>&num=6"
		}else if(<%=request.getParameter("num")%>==7){
			location.href="${ContextPath }/culture/endfestival?pagenum="+pagenum+"&level=<%=request.getParameter("level")%>&num=7"
		}
		else{
			location.href="${ContextPath}/culture/festivalList?value=<%=request.getParameter("value")%>&month=<%=request.getParameter("month")%>&&level=<%=request.getParameter("level")%>&&pagenum="+pagenum;
		} 
	}
	</script>

</html>