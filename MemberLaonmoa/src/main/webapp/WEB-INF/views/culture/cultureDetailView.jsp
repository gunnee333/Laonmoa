
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>

<html>

<head>

<%@ include file="../include/head.jsp"%>
<style>

#link {
	text-align:left;
}
.searchbutton {
	width: 30px;
	height: 30px;
	background-color: #FF7B22;
	border: none;
}
.board_table{
	width: 1100px; 
	border-top: 2px solid #343434; 
	border-bottom: 2px solid #343434;
}
h1.line:after {
	content: "";
	display: block;
	width: 50px;
	border-bottom: 1px solid #bcbcbc;
	margin: 20px 0px;
}

h1.contect_line:after {
	content: "";
	display: block;
	width: 450px;
	border-bottom: 1px solid #bcbcbc;
	margin: 20px 0px;
}

h1.b {
	text-align: center;
}

h1.b:after {
	content: "";
	display: block;
	width: 60px;
	border-bottom: 1px solid #bcbcbc;
	margin: 20px auto;
}

ul.list li, ol.list li {
	padding: 5px 0px 5px 5px;
	margin-bottom: 5px;
	border-bottom: 1px solid #efefef;
	font-size: 12px;
}

#table {
	margin: 0 auto;
	width: 680px;
	font-family: arial;
	font-size: 12px;
	color: #333;
}

#table .row {
	margin: 15px 0 5px 0;
	border-bottom: 1px dotted #c4c4c4;
}

#table .img {
	width: 160px;
	height: 100px;
	float: left;
}

#table .img img {
	width: 160px;
	height: 100px;
	border: 2px solid #333;
}

#table .desc {
	width: 500px;
	height: 120px;
	float: right;
}

#table .desc a {
	color: #2a8cba;
	text-decoration: none;
}

#table .desc span {
	width: 50px;
}

#table h2 {
	font-size: 20px;
	margin: 0 0 5px 0;
	padding: 0;
}

#table h2 a {
	text-decoration: none;
}

.clear {
	clear: both
}

.down {
	border: solid black;
	border-width: 0 3px 3px 0;
	display: inline-block;
	padding: 3px;
	transform: rotate(45deg);
	-webkit-transform: rotate(45deg);
}

.balloon {
	display: inline-block;
	position: relative;
	background-color: #FF7B22 !important;
	height: 30px;
	width: 50px;
	margin: 0 auto 10px;
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
	margin: 0 auto 10px;
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
	margin: 0 auto 10px;
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

.culture_Detail_img {
	width: 530px;
}

.festival_img {
	width: 150px;
	height: 100px;
	margin: 10px 90px;
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
	border-bottom: 2px solid #D3D3D3;
	border-bottom: none;
	table-layout: fixed;
	width: 100%;
}

.button-like {
	border: 2px solid #969696;
	background-color: transparent;
	text-decoration: none;
	padding: 5px 20px !important;

		margin-left:1rem;
	position: relative;
	vertical-align: middle;
	text-align: center;
	display: inline-block;
	border-radius: 3rem;
	color: #969696;
	transition: all ease 0.4s;
}

.button-like span {
	margin-left: 0.5rem;
}

.button-like .fa, .button-like span {
	transition: all ease 0.4s;
}

.button-like:focus {
	background-color: transparent;
}

.button-like:focus .fa, .button-like:focus span {
	color: #ff499d;
}

.button-like:hover {
	border-color: #ff499d;
	background-color: transparent;
}

.button-like:hover .fa, .button-like:hover span {
	color: #ff499d;
}

.button-liked {
	border: 2px solid #ff499d;
	background-color: transparent;
	text-decoration: none;
	padding: 4px 19px !important;

		margin-left:1rem;
	padding-left: 8px;
	padding-right: 8px; position : relative;
	vertical-align: middle;
	text-align: center;
	display: inline-block;
	border-radius: 3rem;
	color: #ff499d;
	transition: all ease 0.4s;
	position: relative;
}

.button-liked span {
	margin-left: 0.5rem;
}

.button-liked .fa, .button-liked span {
	transition: all ease 0.4s;
}

.button-liked:focus {
	background-color: transparent;
}

.button-liked:focus .fa, .button-liked:focus span {
	color: #ff499d;
}

.button-liked:hover {
	border-color: #ff499d;
	background-color: transparent;
}

.button-liked:hover .fa, .button-liked:hover span {
	color: #ff499d;
}

.button-liked {
	background-color: #ff499d;
	border-color: #ff499d;
}

.button-liked.fa, .button-liked span {
	color: #fefefe;
}

.button-liked:focus {
	background-color: #fff;
}

.button-liked:focus .fa, .button-liked:focus span {
	color: #fefefe;
}

.button-liked:hover {
	background-color: #969696;
	border-color: #969696;
}

.button-liked:hover .fa, .button-liked:hover span {
	color: #fefefe;
}

.button-wishlist {
	border: 2px solid #969696;
	background-color: transparent;
	text-decoration: none;
	padding: 1rem;
	
	position: relative;
	vertical-align: middle;
	text-align: center;
	display: inline-block;
	border-radius: 3rem;
	color: #969696;
	transition: all ease 0.4s;
}

.button-wishlist span {
	margin-left: 0.5rem;
}

.button-wishlist .fa, .button-wishlist span {
	transition: all ease 0.4s;
}

.button-wishlist:focus {
	background-color: transparent;
}

.button-wishlist:focus .fa, .button-wishlist:focus span {
	color: #ff499d;
}

.button-wishlist:hover {
	border-color: #3b97f9;
	background-color: transparent;
}

.button-wishlist:hover .fa, .button-wishlist:hover span {
	color: #3b97f9;
}

.button-wish {
	border: 2px solid #3b97f9;
	background-color: transparent;
	text-decoration: none;
	padding: 1rem;
	
	position: relative;
	vertical-align: middle;
	text-align: center;
	display: inline-block;
	border-radius: 3rem;
	color: #ffff;
	transition: all ease 0.4s;
}

.button-wish span {
	margin-left: 0.5rem;
}

.button-wish .fa, .button-wish span {
	transition: all ease 0.4s;
}

.button-wish:focus {
	background-color: transparent;
}

.button-wish:focus .fa, .button-wish:focus span {
	color: #3b97f9;
}

.button-wish:hover {
	border-color: #3b97f9;
	background-color: transparent;
}

.button-wish:hover .fa, .button-wish:hover span {
	color: #3b97f9;
}

.button-wish {
	background-color: #3b97f9;
	border-color: #3b97f9;
}

.button-wish.fa, .button-wish span {
	color: #fefefe;
}

.button-wish:focus {
	background-color: #fff;
}

.button-wish:focus .fa, .button-wish:focus span {
	color: #fefefe;
}

.button-wish:hover {
	background-color: #969696;
	border-color: #969696;
}

.button-wish:hover .fa, .button-wish:hover span {
	color: #fefefe;
}
.button-map {
	border: 2px solid #969696;
	background-color: transparent;
	text-decoration: none;
	padding: 1rem;
	margin-left:1rem;
	position: relative;
	vertical-align: middle;
	text-align: center;
	display: inline-block;
	border-radius: 3rem;
	color: #969696;
	transition: all ease 0.4s;
}

.button-map span {
	margin-left: 0.5rem;
}

.button-map .fa, .button-map span {
	transition: all ease 0.4s;
}

.button-map:focus {
	background-color: transparent;
}

.button-map:focus .fa, .button-map:focus span {
	color: #ff499d;
}

.button-map:hover {
	border-color: #25b746;
	background-color: transparent;
}

.button-map:hover .fa, .button-map:hover span {
	color: #25b746;
}
</style>
<%String pagenum = request.getParameter("pagenum"); %>
<%String id = (String)session.getAttribute("id"); %>
</head>
<body>
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
						<h1 class="title-single">축제모아</h1>
						<span class="color-text-a">#전체</span>
					</div>
				</div>
				<div class="col-md-12 col-lg-4">
					<nav aria-label="breadcrumb"
						class="breadcrumb-box d-flex justify-content-lg-end">
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="${ContextPath}/">메인으로</a></li>
							<li class="breadcrumb-item active"><a href="#">라온모아</a></li>

							<li class="breadcrumb-item active" aria-current="page">축제모아
							</li>
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
						<div class="col-md-6">
							<div class="agent-avatar-box">
								<div class="culture_Detail_img">
									<img src="http://hoohee0331.cdn3.cafe24.com/resource/${info.image}" alt=""
										onerror="this.src='http://hoohee0331.cdn3.cafe24.com/img/Noimg.png'"
										class="agent-avatar img-fluid">
								</div>
								<!-- 버튼 구간 -->


								<div style="height: 100px;">
									<div style="margin: 20px auto; width: 400px;">

										<c:if test="${check==1}">
											<button class="button button-wish" style="cursor: pointer;" onclick="OKwishlist()">
												<i class="fa fa-bookmark" ></i> <span>찜취소</span>
											</button>
										</c:if>
										<c:if test="${check ==0}">
											<button class="button button-wishlist" style="cursor: pointer;" onclick="NOwishlist()">
												<i class="fa fa-bookmark"></i> <span>찜하기</span>
											</button>
										</c:if>

										<c:if test="${checklove==0}">
											<button class="button button-like" style="cursor: pointer;" onclick="Insertlove()">
												<span>
											
												${countlove}
												<br>
												<i class="fa fa-heart"></i>좋아요</span> 
												
											</button>

										</c:if>

										<c:if test="${checklove==1}">
											<button class="button button-liked" style="cursor: pointer;" onclick="Deletelove()">
												<span>
												${countlove}
												<br><i class="fa fa-heart"></i>좋아요</span>
											</button>

										</c:if>
										<button class="button button-map" style="cursor: pointer;" onclick="roadfind()">
											<i class="fa fa-map"></i> <span>길찾기</span>
										</button>
									</div>
								</div>
								<!-- 버튼 구간 끝 -->
							</div>
						</div>
						<div class="col-md-5 section-md-t3">
							<!-- 예정 표시 (진행중/ 마감/ 임박) -->
							<jsp:useBean id="now" class="java.util.Date" />
							<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today" />
							<%-- 			오늘 날짜 :
										<c:out value="${today}" /><!-- 오늘 날짜 --> --%>
							<fmt:formatDate value="${info.sdate}" pattern="yyyyMMdd"
								var="openDate" />
							<%-- 시작날짜 --%>
							<fmt:formatDate value="${info.edate}" pattern="yyyyMMdd"
								var="closeDate" />
							<%-- 마감날짜 --%>
							<c:if test="${openDate <= today && closeDate >= today}">
									<div class="balloon2">
									<p class="ing_font">진행중</p>
								</div>
							</c:if>
							<c:if test="${closeDate < today}">
								<!-- 마감 표시 -->
								<div class="balloon1">
									<p class="ing_font">마감</p>
								</div>
								<!-- 마감 끝-->
							</c:if>
							<c:if test="${openDate > today && closeDate > today}">
									<div class="balloon">
									<p class="ing_font">예정</p>
									</div>
							</c:if>
							<div class="agent-info-box">
								<div class="agent-title">
									<div class="title-box-d">
										<h3>${info.fname }</h3>
										<!-- <h1 class="line"></h1> -->
										<h1 class="contect_line"></h1>
									</div>
								</div>
								<div class="desc">
									<div class="clear"></div>
									<div class="info-agents color-a">
										<!-- <h1 class="contect_line"></h1> -->
										<fmt:formatDate var="sdate" value="${info.sdate}"
											pattern="yyyy-MM-dd" />
										<fmt:formatDate var="edate" value="${info.edate}"
											pattern="yyyy-MM-dd" />
										<p>
											<strong>시작일: </strong> <span class="color-text-a">
												${sdate} </span>
										</p>
										<p>
											<strong>종료일: </strong> <span class="color-text-a">
												${edate}</span>
										</p>
										<p>
											<strong>전화번호:</strong> <span class="color-text-a">
												${info.tel }</span>
										</p>
										<p>
											<strong>홈페이지: </strong> <span class="color-text-a"> <a
												href="#" onclick="homepage()">${info.homepage}</a></span>
												
										</p>
										<p>
											<strong>주소:</strong> <span class="color-text-a">${info.location_1 }</span>
										</p>
										<p>
											<strong>상세주소:</strong> <span class="color-text-a">
												${info.location_2 }</span>
										</p>
										<p>
											<strong>주최:</strong> <span class="color-text-a">${info.host}</span>
										</p>
										<p class="excerpt">${info.fcontent}</p>
						
									</div>
									<br>
								</div>
								<form action="${ContextPath }/culture/Wishlist" method="post"
									id="test">

									<input type="hidden" name="id" value="${id}"> <input
										type="hidden" name="fno" value="${info.fno}"> <input
										type="hidden" name="level" value="${info.level}">
								</form>
								<!-- ddjjdjd -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
		<!--/ Carousel Star /-->
		<div class="out"><div class="in">
		
			<h3 style="padding: 1rem;">리뷰</h3>

			<table class="table table-hover board_table" style="border-bottom: 2px solid #D3D3D3 !important;">
			<thead>
				<tr>
					<td>행사 종류</td>
					<td>행사 이름</td>
					<td>제목</td>
					<td style="width: 120px;">작성자</td>
					<td style="width: 130px;">작성일자</td>
					<td style="width: 100px;">조회수</td>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty Reviewlist }">
						<tr>
							<td colspan="6">아직 작성된 리뷰가 없습니다.</td>
						</tr>
					</c:when>
				</c:choose>
				<c:forEach var="Reviewlist" items="${Reviewlist}">
				<tr>
					<td style="width: 100px;">
					<c:if test="${info.level eq 7}">
					<c:out value="[축제]" />
					</c:if>
					<c:if test="${info.level eq 8}">
					<c:out value="[연극]" />
					</c:if>
					<c:if test="${info.level eq 9}">
					<c:out value="[뮤지컬]" />
					</c:if>
					<c:if test="${info.level eq 10}">
					<c:out value="[전시회]" />
					</c:if>
					</td>
					<td>${info.fname }</td>
					<td><a href="${ContextPath}/board/reviewBoardDetail?bnum=${Reviewlist.bnum}">${Reviewlist.title }</a></td>
					<td>${Reviewlist.id}</td>
	
					<fmt:formatDate var="date" value="${Reviewlist.date}" pattern="yyyy-MM-dd" />
					<td>${date}</td>
					<td>${Reviewlist.hit }</td>				
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<a  class="btn laonmoabtn pull-right" onclick="login()">글쓰기</a>
		</div></div>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->

	<%@ include file="../include/Footer.jsp"%>

	<!--/ Footer End /-->



	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>

	<div id="preloader"></div>



	<!-- JavaScript Libraries -->

	<%@ include file="../include/plugin_js.jsp"%>

	<script>
	//--------------------리뷰 보드 메인 제이쿼리--------------------------------------
	$(document).ready(function(){
	
	$("#hit").on("change",function(){
		var hit =  $("#hit option:selected").val();
		var search = "<%=request.getParameter("search")%>";
		var keyword = "<%=request.getParameter("keyword")%>";
		var eventkinds = $("input[name=hevent]").val();
		location.replace("${ContextPath}/board/reviewBoardMain?hit="+hit+"&pagenum=1"+"&eventkinds="+eventkinds);
	});
	$("#eventkinds").on("change",function(){
		var eventkinds = $("#eventkinds option:selected").val();
		location.replace("${ContextPath}/board/reviewBoardMain?eventkinds="+eventkinds+"&pagenum=1");
	});
	
	
	
});
	function submit(){
		$("#form").submit();
	}
	function login(){
		var id = "<%=id%>";
		if(id == null || id == "null"){
			location.replace("${ContextPath}/loginpage");
		}
		else{
			$.ajax({
				type:"get",
				url:"${ContextPath}/board/blacklist",
				data:{id:id},
				success:function(data){
					if(data == 2){
						alert("이용이 제한된 회원입니다.");
					}
					else{
						location.replace("${ContextPath}/board/reviewBoardInsert?pagenum=<%=pagenum%>&level="+data);
					}
				}
				
			});
		}
	}
	//====================================================

		var check_status = false;
		var like_cnt = $("#like-cnt");
		var like_parent = $(".like-container");

		var burst = new mojs.Burst({
			parent : like_parent,
			radius : {
				20 : 60
			},
			count : 15,
			angle : {
				0 : 30
			},
			children : {
				delay : 250,
				duration : 700,
				radius : {
					10 : 0
				},
				fill : [ '#ddca7e' ],
				easing : mojs.easing.bezier(.08, .69, .39, .97)
			}
		});

		$("#like-cnt").click(function() {
			var t1 = new TimelineLite();
			var t2 = new TimelineLite();
			if (!check_status) {
				t1.set(like_cnt, {
					scale : 0
				});
				t1.set('.like-btn', {
					scale : 0
				});
				t1.to(like_cnt, 0.6, {
					scale : 1,
					background : '#ddca7e',
					ease : Expo.easeOut
				});
				t2.to('.like-btn', 0.65, {
					scale : 1,
					ease : Elastic.easeOut.config(1, 0.3)
				}, '+=0.2');
				//	    t1.timeScale(5);
				check_status = true;
				//circleShape.replay();
				burst.replay();
			} else {
				t1.to(like_cnt, 1, {
					scale : 1
				}).to(like_cnt, 1, {
					scale : 1,
					background : 'rgba(255,255,255,0.3)',
					ease : Power4.easeOut
				});
				t1.timeScale(7);
				check_status = false;
			}

		})
		$(function() {
			$('.excerpt').each(function() {
				$(this).html(formatWords($(this).html(), 30));
				$(this).children('span').hide();
			}).click(function() {
				var more_text = $(this).children('span.more_text');
				var more_link = $(this).children('a.more_link');
				if (more_text.hasClass('hide')) {
					more_text.show();
					more_link.html(' &raquo; hide');
					more_text.removeClass('hide');
				} else {
					more_text.hide();
					more_link.html(' &laquo; more');
					more_text.addClass('hide');
				}
				return false;
			});
		});
		function formatWords(sentence, show) {
			var words = sentence.split(' ');
			var new_sentence = '';
			for (i = 0; i < words.length; i++) {
				if (i <= show) {
					new_sentence += words[i] + ' ';
				} else {
					if (i == (show + 1))
						new_sentence += '<br><span class="more_text hide">';
					new_sentence += words[i] + ' ';
					if (words[i + 1] == null)
						new_sentence += '</span><br><a href="#" class="more_link"> &raquo; more</a>';
				}
			}
			return new_sentence;

		}

		function Wishlist() {
			$("#test").submit();
		}

		function OKwishlist() {
			$
					.ajax({
						type : "post",
						url : "${ContextPath}/culture/Wishdelete",
						data : {
							"id" : "${id}",
							"fno" : "${info.fno}"
						},
						success : function(data) {
							if (data == 1) {
								location.href = "${ContextPath }/culture/cultureDetailView?fno=${info.fno}";
							} else {
								alert("정보 확인을 해주세요.")
							}
						},
						error : function(data) {
							alert("로그인을 해주세요!")
						}
					});
		}

		function NOwishlist() {
			$.ajax({
						type : "post",
						url : "${ContextPath }/culture/Wishlistinsert",
						data : {
							"id" : "${id}",
							"fno" : "${info.fno}"
						},
						success : function(data) {
							if (data == 1) {
								location.href = "${ContextPath }/culture/cultureDetailView?fno=${info.fno}";
							} else {
								alert("정보확인을 해주세요");
							}
						},
						error : function(data) {
							location.href = "${ContextPath}/loginpage";
						}
					});
		}

		function Insertlove() {
			$
					.ajax({
						type : "post",
						url : "${ContextPath}/culture/insertlove",
						data : {
							"id" : "${id}",
							"fno" : "${info.fno}"
						},
						success : function(data) {
							if (data == 1) {
								location.href = "${ContextPath }/culture/cultureDetailView?fno=${info.fno}";
							} else {
								alert("정보 확인을 해주세요.");
							}
						},
						error : function(data) {
							alert("로그인 해주세요!")
						}
					});
		}

		function Deletelove() {
			$
					.ajax({
						type : "post",
						url : "${ContextPath}/culture/deletelove",
						data : {
							"id" : "${id}",
							"fno" : "${info.fno}"
						},
						success : function(data) {
							if (data == 1) {
								location.href = "${ContextPath }/culture/cultureDetailView?fno=${info.fno}";
							} else {
								alert("정보 확인을")
							}
						},
						error : function(data) {
							alert("로그인을 해주세요!")
						}
					});
		}
		function homepage(){
			window.open("${ContextPath }/${ContextPath }/${info.homepage}");
		}
		function roadfind() {
			window.open("https://map.kakao.com/link/map/위치,${info.gps}");
		}
	</script>
</body>
</html>
