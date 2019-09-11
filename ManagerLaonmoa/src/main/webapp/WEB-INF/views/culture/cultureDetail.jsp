<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ContextPath" value="${pageContext.request.contextPath}" />
<%@ page session="true"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/head.jsp"%>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3e8350184be98ede2f330e0815975e14&libraries=services"></script>
<!-- <script src="../resources/jQuery/jquery-3.4.1.js"></script> 이런건 없어-->
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<div class="out">
				<div class="in">
					<h3>${infovo.fname }상세보기</h3>
					<br>
					<form action="${ContextPath}/admin/cultureupdate?fno=${infovo.fno}"
						enctype="multipart/form-data" method="POST" id="form">
						<table class="table_style" style="text-align: left; border-spacing: 5px; border-collapse: separate;">
							<tr class="td_style">
								<input type="hidden" name="fno" value="${infovo.fno }" class="form-control" />
								<td>축제이름</td>
								<td><input type="text" id="fname" name="fname"
									value="${infovo.fname }" disabled="true" class="form-control" /></td>
								<%-- <td rowspan="4" style="text-align: center;" width="250px"><img name="user_photo"
									src="/resources/image/${infovo.image }" width="200"
									height="200">
									</td> --%>
									<td rowspan="4" style="text-align: center; border:1px solid black" width="250px" height="250px">
								<div id = "image"><img src="/resources/image/${infovo.image }" width="250"
									height="250" onerror="this.src='../resources/img/Noimg.png'"></div></td>
									
							</tr>
							<tr class="td_style">
								<td>축제타입</td>
								<td><c:choose>
										<c:when test="${infovo.level == 7}">
											<select id="ftype" name="level" disabled="true"
												style="height: 30px">
												<option value="7">축제</option>
												<option value="8">연극</option>
												<option value="9">뮤지컬</option>
												<option value="10">전시회</option>
											</select>
										</c:when>
										<c:when test="${infovo.level ==8}">
											<select id="ftype" name="level" disabled="true"
												style="height: 30px">
												<option value="8">연극</option>
												<option value="7">축제</option>
												<option value="9">뮤지컬</option>
												<option value="10">전시회</option>
											</select>
										</c:when>
										<c:when test="${infovo.level ==9}">
											<select id="ftype" name="level" disabled="true"
												style="height: 30px">
												<option value="9">뮤지컬</option>
												<option value="7">축제</option>
												<option value="8">연극</option>
												<option value="10">전시회</option>
											</select>
										</c:when>
										<c:when test="${infovo.level ==10}">
											<select id="ftype" name="level" disabled="true"
												style="height: 30px">
												<option value="10">전시회</option>
												<option value="7">축제</option>
												<option value="8">연극</option>
												<option value="9">뮤지컬</option>
											</select>
										</c:when>
									</c:choose></td>
							</tr>
							<tr class="td_style">
								<td>시작일</td>
								<td><input id="sdate" name="sdate" type="text"
									value="${infovo.sdate }" disabled="true" class="form-control"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="sdatecheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>종료일</td>
								<td><input id="edate" name="edate" type="text"
									value="${infovo.edate }" disabled="true" class="form-control"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="edatecheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>지역</td>
								<td><input type="text" value="${infovo.location_1 }"
									disabled="true" onclick="sample6_execDaumPostcode()"
									id="sample6_address" name="location_1" class="form-control"></td>
								<td><input type="hidden" value="이미지 업로드" id="imageupdate"
									onclick="Fileopen();" name="file1" class="form-control" /> <input
									type="file" id="ajaxFile" onChange="ajaxFileChange();"
									style="display: none;" /></td>
								<!-- <td><input type="hidden" id="imageupdate" name="file1" class="form-control" /></td> -->
							</tr>
							<tr class="td_style">
								<td>상세 지역</td>
								<td><input id="loaction_2" name="location_2" type="text"
									value="${infovo.location_2 }" disabled="true" class="form-control"></td>
								<td><input type="hidden" value="이미지 삭제" name="imageDelete"
									id="imageDelete" class="form-control" /></td>
							</tr>
							<tr class="td_style">
								<td>전화번호</td>
								<td colspan="2"><input id="tel" name="tel" type="text"
									value="${infovo.tel }" disabled="true" class="form-control"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="telcheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>홈페이지(선택)</td>
								<td colspan="2"><input id="homepage" name="homepage" type="text"
									value="${infovo.homepage }" disabled="true" class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td>주최(선택)</td>
								<td colspan="2"><input id="host" name="host" type="text"
									value="${infovo.host }" disabled="true" class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td>연령</td>
								<td colspan="2"><input id="kind" name="kind" type="text"
									value="${infovo.kind }" disabled="true" class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td>축제내용</td>
								<td colspan="2"><textarea id="fcontent" name="fcontent" rows="10"
										cols="40" disabled="true" class="form-control">${infovo.fcontent }</textarea></td>
							</tr>
							<tr class="td_style" style="text-align: center;">
								<td colspan="3"><input type="button" value="정보 수정"
									Onclick="cultureupdate()" id="update" class="btn laonmoabtn" /> <input type="hidden"
									value="수정완료" Onclick="cultureupdateok()" id="updateok" class="btn laonmoabtn" /> <input
									type="button" value="삭제" Onclick="cluturedelete()"
									id="updateok" class="btn laonmoabtn" />
							</tr>
						</table>
						<input type="hidden" name="filenull" id="filenull" />
							<input type="hidden" id="order_start_lat" name="order_start_lat"/> 
						<input type="hidden" id="order_start_lon" name="order_start_lon"/>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#imageDelete").click(function() {
				location.href = "${ContextPath}/admin/imagedelete?fno=${infovo.fno}"
			});

		});
		
		var imageFind = document.getElementById("imageupdate");
		function cultureupdate() {
			var f = document.getElementById("update");
			f.type = "hidden";
			var fi = document.getElementById("updateok");
			fi.type = "button";

			var imageDelete = document.getElementById("imageDelete");
			imageFind.type = "button";
			imageDelete.type = "button";
			fname.disabled = false;
			ftype.disabled = false;
			sdate.disabled = false;
			edate.disabled = false;
			sample6_address.disabled = false;
			loaction_2.disabled = false;
			fcontent.disabled = false;
			tel.disabled=false;
			homepage.disabled=false;
			host.disabled=false;
			kind.disabled=false;

			//location.href="${ContextPath}/admin/cultureudate?fno=${infovo.fno}";
		}
		//이미지 업로드버튼을 눌렀을 때 숨겨져 있는 파일업로드창을 띄우게 됨
		function Fileopen(){
			jQuery("#ajaxFile").click();
		}
		//파일이 선택되면 업로드를 실행함
	    function ajaxFileChange() {
	        ajaxFileTransmit();
	    }

	    function ajaxFileTransmit() {
	        var form = jQuery("ajaxFrom")[0];
	        var formData = new FormData(form);
	        formData.append("file", jQuery("#ajaxFile")[0].files[0]);
	        jQuery.ajax({
	              url : "${ContextPath}/admin/ThumbNail"
	            , type : "POST"
	            , processData : false
	            , contentType : false
	            , enctype: 'multipart/form-data'
	            , data : formData
	            , success:function(data) {
	            	var url = "<img src="+data+" width='250px' height='250px'>";
	                $("#image").html(url);
	            }
	        });
	    }
		function cultureupdateok() {
		  
			var telReg = /^\d{2,3}-?(\d{3,4})-?(\d{4})$/;
			var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
			var sdate = $('input[name=sdate]').val();
			var edate = $('input[name=edate]').val();
			var tel = $('input[name=tel]').val();
			var ctrlSelect = document.getElementById("name");
			var fname = document.getElementById("fname");
			var sdatevalue = document.getElementById("sdate");
			var edatevalue = document.getElementById("edate");
			var addressvalue = document.getElementById("sample6_address");
			var content = document.getElementById("content");
			var kind = document.getElementById("kind");

			if (imageFind.value == "") {
				$("#filenull").val('null');
			}

			 if (addressvalue.value == 0) {
				alert("지역을 입력해주세요");
				addressvalue.focus();
			} else if (fname.value == 0) {
				alert("행사 이름을 입력해주세요");
				fname.focus();
			} else if (!dayRegExp.test(sdate)) {
				$("#sdatecheck").text("날짜 형식을 확인해주세요").show();
				sdatevalue.focus();
			} else if (!dayRegExp.test(edate)) {
				$("#edatecheck").text("날짜 형식을 확인해주세요").show();
				edatevalue.focus();
			} else if (sdatevalue.value == 0) {
				alert("시작일을 입력해주세요");
				sdatevalue.focus();
			} else if (edatevalue.value == 0) {
				alert("종료일을 입력해주세요");
				edatevalue.focus();
			} else if (kind.selectedIndex == "") {
				alert("연령을 선택해주세요");
				kind.focus();
			} else if (!telReg.test(tel)) {
				$("#telcheck").text("전화번호를 확인해주세요.").show();
				document.getElementById("tel").focus();	
				} else {
				document.getElementById("form").submit();
				alert("수정완료 ")
			}
			/* location.href="${ContextPath}/admin/cultureupdate?fno=${infovo.fno}" */

		}

		function cluturedelete() {
			location.href = "${ContextPath}/admin/culturedelete?fno=${infovo.fno}&pagenum=1&contentnum=10"
			alert("삭제가 완료되었습니다")
		}

		$(function() {
			$("#sdate").datepicker({
				dateFormat : 'yy-mm-dd'
			});
			$("#edate").datepicker({
				dateFormat : 'yy-mm-dd'
			});
		});

		function sample6_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var fullAddr = ''; // 최종 주소 변수
							var extraAddr = ''; // 조합형 주소 변수

							// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								fullAddr = data.roadAddress;

							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								fullAddr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
							if (data.userSelectedType === 'R') {
								//법정동명이 있을 경우 추가한다.
								if (data.bname !== '') {
									extraAddr += data.bname;
								}
								// 건물명이 있을 경우 추가한다.
								if (data.buildingName !== '') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
								fullAddr += (extraAddr !== '' ? ' ('
										+ extraAddr + ')' : '');
							}

							//  주소 정보를 해당 필드에 넣는다.

							document.getElementById('sample6_address').value = fullAddr;
							window.close;
							// 주소-좌표 변환 객체를 생성합니다
							var geocoder = new kakao.maps.services.Geocoder();
							// 주소로 좌표를 검색합니다
							geocoder
									.addressSearch(
											document
													.getElementById('sample6_address').value,
											function(result, status) {
												// 정상적으로 검색이 완료됐으면 
												if (status === kakao.maps.services.Status.OK) {
													var coords = new kakao.maps.LatLng(
															result[0].y,
															result[0].x);
													console.log("1.다음지도====="
															+ result[0].y); /// 위도
													console.log("2.다음지도====="
															+ result[0].x); /// 경도

													$("#order_start_lat").val(
															result[0].y); //order_start_lat 필드에 위도 값 저장
													$("#order_start_lon").val(
															result[0].x); //order_start_lon 필드에 경도 값 저장
													// 결과값으로 받은 위치를 마커로 표시합니다
													var marker = new kakao.maps.Marker(
															{
																map : map,
																position : coords
															});

													// 인포윈도우로 장소에 대한 설명을 표시합니다
													var infowindow = new kakao.maps.InfoWindow(
															{
																content : '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
															});
													infowindow
															.open(map, marker);
													// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
													map.setCenter(coords);
												}
											});
						}
					}).open();
		}
	</script>
</body>
</html>