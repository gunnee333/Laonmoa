<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<link href="/resources/css/weather-icons.min.css" rel="stylesheet">
<style>
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
	color: #fff;
}

.area_tagList {
	width: 350px;
	padding: 10px 0 10px;
	background-color: #f7f7f7;
	margin-left: 50px;
	display: inline-block;
}

.ion-ios-arrow-forward:before {
	content: "\f3d1";
}

.balloon {
	display: inline-block;
	position: relative;
	background-color: #FF7B22 !important;
	height: 30px;
	width: 50px;
	margin: 0 auto 5px;
}

.balloon:after {
	content: '';
	position: absolute;
	border-right: 5px solid transparent;
	border-left: 5px solid transparent;
	bottom: -9px;
	left: 5px;
	border-top: 10px solid #FF7B22 !important;
}

.balloon1 {
	display: inline-block;
	position: relative;
	background-color: #7F7F7F !important;
	height: 30px;
	width: 50px;
	margin: 0 auto 5px;
}

.balloon1:after {
	content: '';
	position: absolute;
	border-right: 5px solid transparent;
	border-left: 5px solid transparent;
	bottom: -9px;
	left: 5px;
	border-top: 10px solid #7F7F7F !important;
}

.balloon2 {
	display: inline-block;
	position: relative;
	background-color: #0062cc !important;
	height: 30px;
	width: 50px;
	margin: 0 auto 5px;
}

.balloon2:after {
	content: '';
	position: absolute;
	border-right: 5px solid transparent;
	border-left: 5px solid transparent;
	bottom: -9px;
	left: 5px;
	border-top: 10px solid #0062cc !important;
}

.ing_font {
	text-align: center;
	margin-top: 5px;
	color: #fff;
}

/* ### ### ### 09 */
.price-a {
	color: #000000;
	border: #000000 solid 1px;
	padding: 10px;
	transition: all 0.1s ease;
	-webkit-transition: all 0.1s ease;
	-moz-transition: all 0.1s ease;
	font-weight: 400;
}

.price-a:hover {
	color: #ffffff;
	background-color: #FF7B22;
	animation: b09_electric_blinkIn 0.1s step-end 0 2;
	-webkit-animation: b09_electric_blinkIn 0.1s step-end 0 2;
	-moz-animation: b09_electric_blinkIn 0.1s step-end 0 2;
	transition: all 0.2s ease 0.2s;
	-webkit-transition: all 0.2s ease 0.2s;
	-moz-transition: all 0.2s ease 0.2s;
	font-weight: 600;
}
.youtube {

   position: relative;
   padding-bottom: 56.25%;
   padding-top: 35px;
   height: 0;
   overflow: hidden;

}

.youtube iframe {

  position: absolute;
     top:0;
     left: 0;
     width: 100%;
     height: 100%;

}
.selectWeather {
	background-color: #FF7B22;
	border-radius: 30px;
	text-align: center;
	color: #fff !important;
}
</style>
</head>
<body>

	<div class="click-closed"></div>
	<!--/ Form Search Star /-->
	<%@ include file="../include/search.jsp"%>
	<!--/ Form Search End /-->

	<!--/ Nav Star /-->
	<%@ include file="../include/Header.jsp"%>
	<!--/ Nav End /-->

	<!--/ Carousel Star /-->
	<div class="intro intro-carousel">
		<div id="carousel" class="owl-carousel owl-theme">
			<div class="carousel-item-a intro-item bg-image"
				style="background-image: url(http://hoohee0331.cdn3.cafe24.com/img/water.jpg);">
				<div class="overlay overlay-a"></div>
				<div class="intro-content display-table">
					<div class="table-cell2">
						<div class="container">
							<div class="row">
								<div class="col-lg-8">
									<div class="intro-body">
										<p class="intro-title-top" style="font-family: Nanum Gothic;">
											인천 중구 영종해안남로321번길 186  <br> (운서동)
										</p>
										<h1 class="intro-title mb-4">
											<span class="color-b"
												style="font-style: b; color: rgb(255, 123, 34);">2019
											</span> 워터밤 <br> 페스티벌
										</h1>
										<p class="intro-subtitle intro-price">
											<a href="${ContextPath }/culture/cultureDetailView?fno=16384"><span
												class="price-a">지금 당장 궁금하다면? </span></a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="carousel-item-a intro-item bg-image"
				style="background-image: url(http://hoohee0331.cdn3.cafe24.com/img/slide-2.jpg)">
				<div class="overlay overlay-a"></div>
				<div class="intro-content display-table">
					<div class="table-cell2">
						<div class="container">
							<div class="row">
								<div class="col-lg-8">
									<div class="intro-body">
										<p class="intro-title-top">
											서울특별시 송파구 올림픽로 240 <br> 석촌호수
										</p>
										<h1 class="intro-title mb-4">
											<span class="color-b"
												style="font-family: Nanum Gothic; color: rgb(255, 123, 34);">석촌호수
											</span> 재능기부 <br> 음악회
										</h1>
										<p class="intro-subtitle intro-price">
											<a href="${ContextPath }/culture/cultureDetailView?fno=666"><span
												class="price-a">지금 당장 궁금하다면? </span></a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="carousel-item-a intro-item bg-image"
				style="background-image: url(http://hoohee0331.cdn3.cafe24.com/img/slide-3.jpg)">
				<div class="overlay overlay-a"></div>
				<div class="intro-content display-table">
					<div class="table-cell2">
						<div class="container">
							<div class="row">
								<div class="col-lg-8">
									<div class="intro-body">
										<p class="intro-title-top">
											서울특별시 동대문구 천호대로405 <br> 장한로
										</p>
										<h1 class="intro-title mb-4">
											<span class="color-b"
												style="font-family: Nanum Gothic; color: rgb(255, 123, 34);">세계
											</span> 거리 <br> 춤축제
										</h1>
										<p class="intro-subtitle intro-price"
											style="color: rgb(255, 123, 34);">
											<a href="${ContextPath }/culture/cultureDetailView?fno=684"><span
												class="price-a">지금 당장 보고싶다면?</span></a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--/ Carousel end /-->

	<!--/ Services Star /-->
	<section class="section-news section-t8">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title-wrap d-flex justify-content-between">
						<div class="title-box">
							<span class="title-a" style="color: rgb(255, 123, 34);">#
								모두가 </span> <span class="title-a">반한 문화</span>
						</div>
						<div class="title-link">
							<a
								href="${ContextPath }/main/searchMain?keyword=&type=search_allF&city=전체&month=all">모든문화보러가기
								<span class="ion-ios-arrow-forward"></span>
							</a>
						</div>
					</div>
				</div>
			</div>
			<div id="new-carousel" class="owl-carousel owl-theme">
				<c:forEach var="bestCultureList" items="${bestCultureList }">
					<div class="carousel-item-c"
						onclick='location.href="${ContextPath }/culture/cultureDetailView?fno=${bestCultureList.fno}"'>
						<div class="card-box-b card-shadow news-box">
							<!-- 배경이미지 -->
							<div class="img-box-b">
								<c:choose>
									<c:when test="${empty bestCultureList.image }">
										<img src="http://hoohee0331.cdn3.cafe24.com/img/non.jpg" alt=""
											class="img-b img-fluid" style="height: 300px !important;"></img>
									</c:when>
									<c:otherwise>
										<img src="http://hoohee0331.cdn3.cafe24.com/resource/${bestCultureList.image }" alt=""
											class="img-b img-fluid" style="height: 300px !important;" />
									</c:otherwise>
								</c:choose>
							</div>
							<!-- 내용 -->
							<div class="card-overlay">
								<div class="card-header-b">
									<div class="card-category-b">
										<a class="category-b"> <c:choose>
												<c:when test="${bestCultureList.level eq 7 }">
													축제
												</c:when>
												<c:when test="${bestCultureList.level eq 8 }">
													연극
												</c:when>
												<c:when test="${bestCultureList.level eq 9 }">
													뮤지컬
												</c:when>
												<c:when test="${bestCultureList.level eq 10 }">
													전시회
												</c:when>
												<c:otherwise>
													기타
												</c:otherwise>
											</c:choose>
										</a>
									</div>
									<div class="card-title-b">
										<h2 class="title-2" style="color: #fff;">
											<c:choose>
												<c:when test="${fn:length(bestCultureList.fname) > 15}">
													<c:out value="${fn:substring(bestCultureList.fname,0,14)}" />...
	  							      			</c:when>
												<c:otherwise>
													<c:out value="${bestCultureList.fname }" />
												</c:otherwise>
											</c:choose>
										</h2>
									</div>
									<div class="card-body-c">
										<p class="content-c">
											<c:choose>
												<c:when test="${fn:length(bestCultureList.fcontent) > 60}">
													<c:out
														value="${fn:substring(bestCultureList.fcontent,0,59)}" />...
	  							      			</c:when>
												<c:otherwise>
													<c:out value="${bestCultureList.fcontent }" />
												</c:otherwise>
											</c:choose>
										</p>
									</div>
									<div class="card-date">
										<span class="date-b">
										<fmt:formatDate var="sdate" value="${bestCultureList.sdate}" pattern="yyyy-MM-dd" />
										<fmt:formatDate var="edate" value="${bestCultureList.edate}" pattern="yyyy-MM-dd" />
										${sdate} ~ ${edate}<br/></span>
									</div>
									<div>
										<span class="date-b">${bestCultureList.location_1 }</span>
									</div>
									<div class="card-footer-c">
										<a
											href="${ContextPath }/culture/cultureDetailView?fno=${bestCultureList.fno}"
											class="link-c link-icon">Read more <span
											class="ion-ios-arrow-forward"></span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
	<!--/ Services End /-->



	<!--/ 베스트리뷰 /-->
	<section class="section-testimonials section-t8 nav-arrow-a">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title-wrap d-flex justify-content-between">
						<div class="title-box">
							<span class="title-a" style="color: rgb(255, 123, 34);">#
								베스트</span> <span class="title-a">리뷰</span>
						</div>
					</div>
				</div>
			</div>
			<div id="testimonial-carousel" class="owl-carousel owl-arrow">
				<c:forEach var="list" items="${bestReviewList }">
					<div class="carousel-item-a">
						<div class="testimonials-box">
							<div class="row">
								<div class="col-sm-12 col-md-6">
									<div class="testimonial-img">
										<a
											href="${ContextPath }/culture/cultureDetailView?fno=${list.fno}">
											<c:choose>
												<c:when test="${empty list.image }">
													<img src="http://hoohee0331.cdn3.cafe24.com/img/Noimg.png" class="img-fluid">
												</c:when>
												<c:otherwise>
													<img src="http://hoohee0331.cdn3.cafe24.com/resource/${list.image }"
														class="img-fluid">
												</c:otherwise>
											</c:choose>
										</a>
									</div>
								</div>
								<div class="col-sm-12 col-md-6">
									<div class="testimonials-content">
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"
											var="today" />
										<c:choose>
											<c:when test="${list.sdate <= today && list.edate >= today}">
												<div class="balloon2">
													<p class="ing_font">진행중</p>
												</div>
											</c:when>
											<c:when test="${list.sdate < today && list.edate < today}">
												<div class="balloon1">
													<p class="ing_font">마감</p>
												</div>
											</c:when>
											<c:when test="${list.sdate > today && list.edate > today}">
												<div class="balloon">
													<p class="ing_font">예정</p>
												</div>
											</c:when>
										</c:choose>
										<p class="testimonial-text">
											<a
												href="${ContextPath }/culture/cultureDetailView?fno=${list.fno}"
												class="link-c link-icon">${list.fname}</a> <br> <br>
											<b>${list.title }</b><br> <a style="width: 20px;"> <c:choose>
													<c:when test="${fn:length(list.content) > 60}">
														<script>
															var content = '${list.content}'.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig,"");
															content = content.substring(0,60);
															document.write(content);
														</script>
														...
			     							      </c:when>
													<c:otherwise>
														<link rel="import" href="${list.content}">
													</c:otherwise>
												</c:choose>
											</a> <br> <br> <a
												href="${ContextPath }/board/reviewBoardDetail?bnum=${list.bnum}"
												class="link-c link-icon">Read more <span
												class="ion-ios-arrow-forward"></span></a> <br>
										</p>
									</div>
									<div class="testimonial-author-box">
										<img src="http://hoohee0331.cdn3.cafe24.com/img/userimg.png"
											class="testimonial-avatar">
										<h5 class="testimonial-author">${list.id}</h5>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
	<!--/ 베스트리뷰 /-->
	<section class="section-services section-t8">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title-wrap d-flex justify-content-between">
						<div class="title-box">
							<span class="title-a" style="color: rgb(255, 123, 34);">#
								지금! 주목할 </span> <span class="title-a">문화</span>
								<div class="youtube" style="width: 1100px; height: 400px; padding-top: 30px; margin-top: 50px;" >
							<iframe  src="https://www.youtube.com/embed/Eh_2zYkYYUI" frameborder="0" allowfullscreen></iframe>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ 날씨 API 구간 /-->
	<section class="section-services section-t8">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title-wrap d-flex justify-content-between">
						<div class="title-box">
							<span class="title-a" style="color: rgb(255, 123, 34);">#
								지금</span> <span class="title-a">날씨는?</span>
						</div>
					</div>
				</div>
				<div style="margin: 0 auto;">
					<div class="col-md-4" style="display: inline-block;">
						<table style="text-align: center;">
							<tr style="border: 5px solid #FF7B22;">
								<td colspan="2" width="200px"><img name="weathericon"
									class=""><br> <b><span id="cityStr"
										style="font-size: 20px;"></span></b></td>
							</tr>
							<tr>
								<td colspan="2"><br></td>
							</tr>
							<tr>
								<td style="text-align: right;" width="100px;">현재온도 :</td>
								<td><span id="nowTemp"></span>도</td>
							</tr>
							<tr>
								<td style="text-align: right;">습도 :</td>
								<td><span id="nowhumidity"></span></td>
							</tr>
							<tr>
								<td style="text-align: right;">구름량 :</td>
								<td><span id="clouds"></span></td>
							</tr>
							<tr id="dust" style="display: none;">
								<td style="text-align: right;">미세먼지 :</td>
								<td><span id="dusts"></span></td>
							</tr>
						</table>
					</div>
					<div class="col-md-4" style="display: inline-block;">
						<div class="card-box-c foo">
							<div class="card-header-c d-flex">
								<div class="col-md-12 col-lg-4">
									<div class="area_tagList">
										<div class="tagcloud01">
											<ul>
												<li><a onclick='weather("Seoul","서울");' name="weatherTag" id="Seoul">#서울</a></li>
												<li><a onclick='weather("Busan","부산");' name="weatherTag" id="Busan">#부산</a></li>
												<li><a onclick='weather("Daegu","대구");' name="weatherTag" id="Daegu">#대구</a></li>
												<li><a onclick='weather("Incheon","인천");' name="weatherTag" id="Incheon">#인천</a></li>
												<li><a onclick='weather("Gwangju","광주");' name="weatherTag" id="Gwangju">#광주</a></li>
												<li><a onclick='weather("Daejeon","대전");' name="weatherTag" id="Daejeon">#대전</a></li>
												<li><a onclick='weather("Ulsan","울산");' name="weatherTag" id="Ulsan">#울산</a></li>
												<li><a onclick='weather("Kangwŏn-do","강원");' name="weatherTag" id="Kangwŏn-do">#강원</a></li>
												<li><a onclick='weather("Ch’ungch’ŏng-bukto","충청북도");' name="weatherTag" id="Ch’ungch’ŏng-bukto">#충북</a></li>
												<li><a onclick='weather("Ch’ungch’ŏng-namdo","충청남도");' name="weatherTag" id="Ch’ungch’ŏng-namdo">#충남</a></li>
												<li><a onclick='weather("Chŏlla-bukto","전라북도");' name="weatherTag" id="Chŏlla-bukto">#전북</a></li>
												<li><a onclick='weather("Chŏlla-namdo","전라남도");' name="weatherTag" id="Chŏlla-namdo">#전남</a></li>
												<li><a onclick='weather("Kyŏngsang-bukto","경상북도");' name="weatherTag" id="Kyŏngsang-bukto">#경북</a></li>
												<li><a onclick='weather("Kyŏngsang-namdo","경상남도");' name="weatherTag" id="Kyŏngsang-namdo">#경남</a></li>
												<li><a onclick='weather("Cheju-do","제주");' name="weatherTag" id="Cheju-do">#제주</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ 날씨 API 구간 끝 /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>

	<script>
		$(document).ready(function() {
			// 기본 날씨 한국으로 설정
			weather("Republic of Korea", "한국");
		});

		// OpenWeatherMap 현재날씨 가져오기
		function weather(cityStr, cityStrkor) {
			var city = cityStr;
			var cityKor = cityStrkor;
			
			// 태그 주황바탕 만들어주기
			$('a[name="weatherTag"]').removeClass('selectWeather');
			$("#" + city).addClass("selectWeather");

			// 미세먼지 데이터 가져오기
			weatherDust(city);

			apikey = "b576afc5fb468825f43d1c191deef169"
			var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="
					+ city + "&appid=" + apikey;
			var imgURL = "http://openweathermap.org/img/w/";
			$.ajax({
				type : "GET",
				url : apiURI,
				dataType : "json",
				async : "false",
				success : function(resp) {
					imgURL += resp.weather[0].icon + ".png";
					$('img[name=weathericon]').attr("src", imgURL);
					$('img[name=weathericon]').attr("width", "80");
					$("#cityStr").text(cityKor).show();
					$('#nowTemp').text(Math.ceil(resp.main.temp - 273.15))
							.show();
					$('#nowhumidity').text(resp.main.humidity).show();
					$('#clouds').text(resp.clouds.all + "%").show();
				}
			}); // ajax end
		}

		function weatherDust(location) {
			var city = location;
			var url = "https://api.waqi.info/feed/" + city + "/?token=";
			var serviceKey = "4b9b2f9e6d889043fff360018d6a5649c780de6c";
			var aqi;
			var dustStatus = "";

			url += serviceKey;

			$.ajax({
				type : "GET",
				url : url,
				dataType : "json",
				async : "false",
				success : function(resp) {
					if (resp.status == "ok") {
						aqi = resp.data.aqi
						if (aqi <= 50) {
							dustStatus = "좋음";
						} else if (aqi <= 100) {
							dustStatus = "보통";
						} else if (aqi <= 150) {
							dustStatus = "민감군영향";
						} else if (aqi <= 200) {
							dustStatus = "나쁨";
						} else if (aqi <= 300) {
							dustStatus = "매우나쁨";
						} else if (aqi > 300) {
							dustStatus = "위험";
						}

						$("#dust").css("display", "");
						$("#dusts").text(dustStatus).show();
					} else {
						$("#dust").css("display", "none");
						$("#dusts").hide();
					}
				},
				error : function(resp) {
					console.log("오류!");
					$("#dust").css("display", "none");
					$("#dusts").hide();
				}
			}); // ajax end
		}
	</script>
</body>
</html>
