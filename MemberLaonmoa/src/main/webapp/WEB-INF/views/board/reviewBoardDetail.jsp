<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<%
	String bnum = request.getParameter("bnum");
%>
<%
	String id = (String) session.getAttribute("id");
%>
</head>
<style>
textarea {
	border-radius: 0px !important;
	width: 900px;
	height: 100px;
	float: left;
}

textarea:focus {
	border-color: #FF7B22 !important;
	box-shadow: none !important;
}
.mainboard {
	width: 1200px;
	margin: 0 auto 100px auto;
}
#replyList{
	border-bottom: 1px solid #dedede;
}
</style>
<body id="fdsafdsa">
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
							<a href="${ContextPath}/board/reviewBoardMain?pagenum=1">리뷰게시판</a>
						</h1>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/ Intro Single End /-->

	<!--/ Carousel Star /-->
	<div class="mainboard">
		<div class="out">
			<div class="in">
				<table class="table">
					<thead>
						<tr>
							<td style="text-align: left;">제목 : ${detail.title}</td>
							<td style="width: 200px;">작성자 : ${detail.id}</td>
							<td style="width: 100px;">조회수 : ${detail.hit}</td>
						</tr>
						<tr>
							<td style="text-align: left"><c:if
									test="${detail.flevel eq 7}">
									<c:out value="[축제]" />
								</c:if> <c:if test="${detail.flevel eq 8}">
									<c:out value="[연극]" />
								</c:if> <c:if test="${detail.flevel eq 9}">
									<c:out value="[뮤지컬]" />
								</c:if> <c:if test="${detail.flevel eq 10}">
									<c:out value="[전시회]" />
								</c:if> ${detail.fname}</td>
							<td colspan="2"><fmt:formatDate var="date"
									value="${detail.date}" pattern="yyyy-MM-dd HH:mm" /> 작성일자
								:${date}</td>
						</tr>
					</thead>
					<tbody>
						<tr style="height: 500px">
							<td colspan="3" style="text-align: left;">${detail.content}
							</td>
						</tr>
						<tr>
						</tr>
						<tr>
							<td colspan="3" align="right"><c:if test="${id ne null}">
									<button type="button" id="f_warning" class="btn laonmoabtn_war"
										onclick='warningOpen("${detail.bnum}","${detail.level}");'>신고</button>
								</c:if> <a
								href="${ContextPatn}/board/reviewBoardUpdate?bnum=<%=bnum %>&pagenum=<%=pagenum %>">
									<button type="button" id="update" class="btn laonmoabtn"
										style="display: none">수정</button>
							</a>
								<button type="button" id="delete" class="btn laonmoabtn"
									style="display: none" onclick="select();">삭제</button>
								<button type="button" id="cencel" class="btn laonmoabtn"
									onclick="back();">목록</button></td>
						</tr>
						<!-- 댓글 입력 -->
						<tr>
							<td colspan="3"><textarea id="rcontent"
									placeholder="댓글을 입력해주세요."></textarea>
								<button class="btn laonmoabtn" style="margin-right: 15px"
									onclick="replysend()">댓글 입력</button> <input type="hidden"
								name="history" value="${history}"></td>
						</tr>
						<tr style="display: none;" id=sreply>
							<td style="text-align: left"><span style="color: red;">댓글을
									입력해주세요.</span></td>
						</tr>
					</tbody>
				</table>
				<!-- 댓글 -->
				<div id="replyList"></div>
			</div>
		</div>
	</div>
	<!--/ Carousel end /-->

	<!--/ footer Star /-->
	<%@ include file="../include/Footer.jsp"%>
	<!--/ Footer End /-->

	<a href="#" class="back-to-top"><i class="fa fa-chevron-up"></i></a>
	<div id="preloader"></div>

	<!-- JavaScript Libraries -->
	<%@ include file="../include/plugin_js.jsp"%>

	<script>
	$(document).ready(function(){
		replyList();
		if("${detail.id}" == "${id}"){
			$("#update").show();
			$("#delete").show();
		}
		else{
			$("#update").hide();
			$("#delete").hide();
		}
		
	});
	//수정텍스트 보여주기
	function replyview(idx){
		$("#show"+idx).hide();
		$("#hidden"+idx).show();
	}
	//수정텍스트 취소
	function updatecencel(idx){
		$("#hidden"+idx).hide();
		$("#show"+idx).show();
		$("#rcontentupdate"+idx).val("");
	}
	
	//블랙리스트 회원
	 function replysend(){
		 var id = "<%=id%>";
		 if(id == "null" || id == null){
				location.replace("${ContextPath}/loginpage");
			}
		 $.ajax({
			type:"get",
			url:"${ContextPath}/board/blacklist",
			data:{id:id},
			success:function(data){
				if(data==2){
					alert("이용이 제한된 사용자입니다.");
					$("#rcontent").val("");
				}
				else{
					replyregister();
				}
			}
		 });
	 }
	
	//댓글 쓰기
	function replyregister(){
		if($("#rcontent").val() == ""){
			$("#sreply").show();
		}
		else{
			var query = {
					bnum : "${detail.bnum}",
					rcontent : $("#rcontent").val(),
			}
			$.ajax({
				type:"get",
				url:"${ContextPath}/board/reviewReplyInsert",
				data:query,
				success:function(data){
					if(data == 1){
						replyList();
						$("#rcontent").val("");
					}
				},
				error:function(data){
					alert("실패");
				}
			});
		}
	}
	
	//댓글 list
	function replyList(){
		var bnum = "${detail.bnum}";
		$.ajax({
			type:"get",
			url:"${ContextPath}/board/reviewreplyList",
			data:{"bnum":bnum},
			success:function(data){
				console.log(data);
				var output = "<table class='table'>";
				for(var i in data){
					output += "<tr align = 'left'>";
					output += "<td><div><b>" + data[i].id + "</b> ";
					output += date_to_str(data[i].date) + "</div>";
					output += "<div><span id='replycontent"+i+"'>" + data[i].rcontent + "</span>";
					output += "</div></td>";
					if(${id ne null}){
						output += "<td align = 'right' width='200px'>";
					}
					else{
						output += "<td>"
					}
					/* output += "<tr align ='left' colspan = '2'><td style='border-top: none !important;'></td>"; */
					if("${id}" == data[i].id){
						output += "<div style='display: inline-block;' id = 'show" + i + "'>";
						output += "<button type='button' onclick='replyview(" + i + ")' class = 'btn laonmoabtn_board'>";
						output += "수정</button>";
						output += "<button type='button' onclick='replydelete(" + data[i].rnum + ")' class = 'btn laonmoabtn_board'>";
						output += "삭제</button></div>";
					}
					else if(${id eq null}){}
					else{
						output += "<button type='button' class = 'btn laonmoabtn_board' onclick='warningOpen(" + data[i].rnum + ", " + data[i].level + ");'>신고</button>";
					}
					output += "</td></tr>";
					output += "<tr id = 'hidden" + i + "'"+"style='display:none'>";
					output += "<td>";
					output += "<textarea id = 'rcontentupdate"+i+"'>";
					output += data[i].rcontent + "</textarea>";
					output += "</td>";
					output += "<td align='right'>";
					output += "<button type = 'button' onclick = 'replyupdate(" + data[i].rnum + "," + i + ")' class = 'btn laonmoabtn_board'>";
					output += "수정</button> ";
					output += "<button type = 'button' onclick = 'updatecencel(" + i + ")' class = 'btn laonmoabtn_board'>";
					output += "취소</button></td></tr>";
				}
				output += "</table>";
				$("#replyList").html(output);
			},
			error:function(data){
				alert("실패");
			}
		});
	}
	
	//댓글 수정
	function replyupdate(idx,index){
		var rnum = idx;
		var query={
					"rnum" : rnum,
					"rcontent" : $("#rcontentupdate"+index).val(),
		}
		$.ajax({
			type:"post",
			url:"${ContextPath}/board/reviewReplyUpdate",
			data:query,
			success:function(data){
				if(data == 1){
					replyList();
				}
				else{
					alert("알 수 없는 오류");
				}
			},
			error:function(data){
				alert("에러 실패")
			}
		});
	}
	
	//댓글 삭제
	function replydelete(idx){
		if(confirm("정말 삭제하시겠습니까?")==true){
			var rnum = idx;
			$.ajax({
				type:"post",
				url:"${ContextPath}/board/reviewReplyDelete",
				data:{rnum:rnum},
				success:function(data){
					replyList();
				},
				error:function(data){
					alert("실패");
				}
			});
		}
	}
	
	//뒤로가기
	function back(){
		var pagenum = document.location.href.split("pagenum=")[1];
		if(pagenum == null){
			pagenum = 1;
		}
		var referrer = document.referrer;
		var cut = referrer.split("/");
		var url = referrer.match("myReview");
		var url1 = referrer.match("reviewBoardSearch");
		if(url == "myReview" || url1 == "reviewBoardSearch" || cut.length < 5){
			history.back();
		}
		else{
			location.replace("${ContextPath}/board/reviewBoardMain?pagenum="+pagenum);
		}
	}
	//게시글 삭제 ajax
	function select(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			var query={
					"id" : "${id}",
					"bnum" : "${detail.bnum}"
				}
				$.ajax({
					type:"get",
					url:"${ContextPath}/board/reviewDelete",
					data:query,
					success:function(data){
						location.replace("${ContextPath}/board/reviewBoardMain?pagenum=1");
					},
					error:function(data){
						alert("실패"); 
					}
				});
		}
	}
	//신고 버튼
	function warningOpen(num, level){
		var url = "${ContextPath}/board/warning";
		url += "?level=" + level;
		url += "&num=" + num;
		window.open(url , "_blank",
		"width=380, height=400, left=700px, top=200px, location=no, menubar=no, status=no, toolbar=no, resizable=no, fullscreen=no, scrollbars=no");
	}
	 // 날짜 포맷
	 function date_to_str(format){
	  var rDate = new Date(format);
	  console.log(format);
	  console.log(rDate);
	     var year = rDate.getFullYear();
	     var month = rDate.getMonth() + 1;
	     if(month<10) month = '0' + month;
	     var date = rDate.getDate();
	     if(date<10) date = '0' + date;
	     var hour = rDate.getHours();
	     if(hour<10) hour = '0' + hour;
	     var min = rDate.getMinutes();
	     if(min<10) min = '0' + min;
	     return year + "-" + month + "-" + date + " " + hour + ":" + min;
	 } 
	 
</script>
</body>
</html>
