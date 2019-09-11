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
<style>
.where {
	display: block;
	margin: 25px 15px;
	font-size: 11px;
	color: #000;
	text-decoration: none;
	font-family: verdana;
	font-style: italic;
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

/* imaged preview */
.filebox .upload-display {
	margin-bottom: 5px;
}

@media ( min-width : 768px) {
	.filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap {
	display: inline-block;
	width: 54px;
	padding: 2px;
	vertical-align: middle;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
}

.filebox .upload-display img {
	display: block;
	max-width: 100%;
	width: 100% \9;
	height: auto;
}

.filebox.bs3-primary label {
	color: #fff;
	background-color: #337ab7;
	border-color: #2e6da4;
}

table {
	border-spacing: 4px;
	border-collapse: separate;
}
</style>
</head>
<body>
	<%@ include file="../include/Header.jsp"%>
	<div class="main">
		<div class="main_menu_in"><%@ include
				file="../include/adminMenu.jsp"%></div>
		<div class="sub">
			<div class="out">
				<div class="in">
					<h3>문화정보추가</h3>
					<br>
					<form action="${ContextPath }/admin/cultureInsert?pagenum=1&contentnum=10"
						method="post" id="form" enctype="multipart/form-data">
						<table class="table_style" style="text-align: left; border-spacing: 5px; border-collapse: separate;">
							<tr class="td_style">
								<td width="200px">축제이름:</td>
								<td><select id="name" name="level"
									style="width: 200px; height: 30px">
										<option value="">- 선택 -</option>
										<option value="7">축제</option>
										<option value="8">연극</option>
										<option value="9">뮤지컬</option>
										<option value="10">전시회</option>
								</select></td>
							</tr>
							<tr class="td_style">
								<td>행사 이름:</td>
								<td><input type="text" name="fname" id="fname"  class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td>축제 시작일:</td>
								<td><input type="text" id="sdate" name="sdate"
									autocomplete="off" class="form-control"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="sdatecheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>축제 종료일:</td>
								<td><input type="text" id="edate" name="edate"
									autocomplete="off" class="form-control"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="edatecheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>지역:</td>
								<td><input type="text" onclick="sample6_execDaumPostcode()"
									id="sample6_address" name="location_1" class="form-control" /></td>
							</tr>
							<tr class="td_style">
								<td>상세주소 :</td>
								<td><input type="text" name="location_2" class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td>전화번호:</td>
								<td><input type="text" name="tel" class="form-control" id ="tel"></td>
							</tr>
							<tr>
							<td></td>
							<td><span id="telcheck" class="checkspan"></span></td>
							</tr>
							<tr class="td_style">
								<td>홈페이지:(선택)</td>
								<td><input type="text" name="homepage"
									 class="form-control" /></td>
							</tr>
							<tr class="td_style">
								<td>주최:(선택)</td>
								<td><input type="text" name="host" class="form-control" /></td>
							</tr>
							<tr class="td_style">
								<td>연령:</td>
								<td><select id="kind" name="kind"
									style="width: 200px; height: 30px">
										<option value="">- 선택 -</option>
										<option value="제한없음">제한없음</option>
										<option value="만7세이상">만7세이상</option>
										<option value="만15세이상">만15세이상</option>
										<option value="만19세이상">만19세이상</option>
								</select></td>
							</tr>
							<tr class="td_style">
								<td>축제 내용:</td>
								<td><input type="textarea" id="content" name="content"
									 class="form-control"></td>
							</tr>
							<tr class="td_style">
								<td colspan="2"><input type="file" name="file1" id="file1"></td>
							</tr>
							<tr class="td_style">
								<td colspan="2" align="right"><input class="btn laonmoabtn"
									height="100" type="button" value="확인" onclick="CheckSelect();" />
									<button class="btn laonmoabtn">취소</button></td>
							</tr>
						</table>
						<input type="hidden" id="filenull" name="filenull"/> 
						<input type="hidden" id="order_start_lat" name="order_start_lat"/> 
						<input type="hidden" id="order_start_lon" name="order_start_lon"/>
					</form>
					<div id="map" style="width: 100%; height: 350px;"></div>
					
				</div>
			</div>
		</div>
	</div>
	<script>
	
	$(document).ready(function() {
		var fileTarget = $('.filebox .upload-hidden');
		
		fileTarget.on('change', function() {
		   if (window.FileReader) {
		      // 파일명 추출
		      var filename = $(this)[0].files[0].name;
		   } else {
		      // Old IE 파일명 추출
		      var filename = $(this).val().split('/')
		            .pop().split('\\').pop();
		   }
		
		   $(this).siblings('.upload-name').val(filename);
		});
		
		//preview image 
		var imgTarget = $('.preview-image .upload-hidden');
		
		imgTarget.on('change',function() {
			var parent = $(this).parent();
			parent.children('.upload-display').remove();
			
			if (window.FileReader) {
				//image 파일만
				if (!$(this)[0].files[0].type.match(/image\//))
				return;
				
				var reader = new FileReader();
				reader.onload = function(e) {
					var src = e.target.result;
					parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>');
				}
				reader.readAsDataURL($(this)[0].files[0]);
			} else {
				$(this)[0].select();
				$(this)[0].blur();
				var imgSrc = document.selection.createRange().text;
				parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');
				
				var img = $(this).siblings('.upload-display').find('img');
				img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""
									+ imgSrc + "\")";
			}
		});          
	});
	
	function CheckSelect() { 
		var telReg = /^\d{2,3}-?(\d{3,4})-?(\d{4})$/;
		var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		var sdate = $('input[name=sdate]').val();
		var edate = $('input[name=edate]').val();
		var tel= $('input[name=tel]').val();
		var ctrlSelect = document.getElementById("name");
		var fname = document.getElementById("fname");
		var sdatevalue = document.getElementById("sdate");
		var edatevalue = document.getElementById("edate");
		var addressvalue = document.getElementById("sample6_address");
		var content = document.getElementById("content");
		var image = document.getElementById("file1");
		var kind =  document.getElementById("kind");
		if (image.value == "") {
        	 $("input[name=filenull]").val("in");
        	 /* document.getElementById("filenull").value = 'in' */
            //$("#filenull").val("in");
         } 
         
         if (ctrlSelect.selectedIndex == "") {
            alert("축제 분류를 선택하세요");
            ctrlSelect.focus();
         } else if (addressvalue.value == 0) {
            alert("지역을 입력해주세요");
            addressvalue.focus();
         } else if (fname.value == 0) {
            alert("행사 이름을 입력해주세요");
            fname.focus();
         } else if (!dayRegExp.test(sdate)){
        	 $("#sdatecheck").text("날짜 형식을 확인해주세요").show();
        	 sdatevalue.focus();
         } else if (!dayRegExp.test(edate)){
        	 $("#edatecheck").text("날짜 형식을 확인해주세요").show();
        	 edatevalue.focus();
         }
         else if (sdatevalue.value == 0) {
            alert("시작일을 입력해주세요");
            sdatevalue.focus();
         } else if (edatevalue.value == 0) {
            alert("종료일을 입력해주세요");
            edatevalue.focus();
         } else if (kind.selectedIndex==""){
            alert("연령을 선택해주세요");
            kind.focus();
         } else if (!telReg.test(tel)) {
				$("#telcheck").text("전화번호를 확인해주세요.").show();
				document.getElementById("tel").focus();	
		}  else {
            document.getElementById("form").submit();
            /* document.getElementById("imagesubmit").submit(); */
         }
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
                     geocoder.addressSearch( document.getElementById('sample6_address').value, function(result, status) {
                         // 정상적으로 검색이 완료됐으면 
                          if (status === kakao.maps.services.Status.OK) {
                            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                             console.log("1.다음지도====="+result[0].y); /// 위도
                             console.log("2.다음지도====="+result[0].x); /// 경도
                             $("#order_start_lat").val(result[0].y);  //order_start_lat 필드에 위도 값 저장
                             $("#order_start_lon").val(result[0].x);  //order_start_lon 필드에 경도 값 저장
                         } 
                     });   
                    
                  }
               }).open();
      }
   </script>
</body>
</html>