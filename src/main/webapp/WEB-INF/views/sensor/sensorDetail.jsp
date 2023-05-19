<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
/**
 * @Class Name : sensorDetail.jsp
 * @Description : 센서정보 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @ 2023.05.11  이준영
 */
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>센서 정보관리 상세조회</title>

	<link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="/static/assets/js/common.js"></script>

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="/static/js/filtering.js"></script>
	<script src="/static/js/common/utils.js"></script>
	<script type="text/javascript" src="/static/js/common/moment.min.js"></script>
	<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=fbfe7816953095f8e8b87ef1e7967ffc&libraries=services,clusterer&charset=utf-8"></script>
	<script type="text/javascript" src="/static/js/map.js"></script>
	<style>
		.btn-area-reg{padding-bottom: 10px;}
		.heightauto{height:auto !important;}
	</style>
	<script type="text/javascript">
		let map;
		let sensorMarkers = []
		$(()=>{
			// 지도 정보를 가져온다
			fnInitMap();
			fnGetSensorInfo();
		});
		// 센서 정보를 가져온다
		function fnGetSensorInfo() {
			let sId = '<c:out value="${sensorInfoDetail.sensorId}"/>';
			//센서정보를 초기화 한다
			// 마커 초기화
			removeMarker();
			// 마커인포 초기화
			closeMarkerInfo();
			let data = JSON.stringify({ sensorId :sId})
			let url ="<c:url value='/dashboard/dashSensorList.ajax'/>"
			$.ajax({
				url: url,
				data: data,
				dataType:'json',
				processData:false,
				contentType:'application/json; charset=UTF-8',
				type:'POST',
				traditional :true,
				success: function(data){
					createSensorMarkersByData(data);
					changeMarker(map);
					// 마커 인포스타일을 변경한다
					fnSetMarkerInfoStyle();
				}
			});
			return false;
		}
		// 목록 버튼 클릭시
		function fnCloseDetailModal() {
			document.detailForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#detailForm").submit();
		};

		// 저장버튼 클릭시
		function fnReplySave(){
			var writerId = $("#writerIdRegist").text();
			var title = $("#titleRegist").val();
			var locationDetail = $("#locationDetailRegist").val();
			var sensorIdParam = $("#sensorIdParam").val();

			if(title == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			}

			var data = new FormData($("#replyForm")[0]); // 업로드할 파일
			data.append("writerId", writerId); // 작성자ID
			data.append("title", title); // 제목
			data.append("locationDetail", locationDetail); // 센서위치설명
			data.append("sensorIdParam", sensorIdParam); // 센서ID

			$.ajax({
				url: "/sensor/sensorReplySave.do",
				type: "POST",
				enctype: 'multipart/form-data',
				async: true,
				processData:false,
				contentType:false,
				//dataType: "json",
				data:data,
				//contentType: "application/json",
				success : function(data) {
					//alert("통신성공시에만 실행");
					if(data.saveResult) {
						alert("댓글 저장완료 하였습니다.");
						document.replyForm.action = '<c:url value="/sensor/sensorDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
						$("#replyForm").submit();

					} else {
						alert("댓글 저장실패 하였습니다.");
					}

				},
				error : function(arg){
					alert("저장 실패");

				}
			});

		};

		// 센서정보 상세 모달에서 삭제 버튼 클릭시
		function fnDel() {

			if(confirm("선택한 센서을 삭제 하시겠습니까?")) {
				$.ajax({
					url: "/sensor/sensorDel.do",
					type: "POST",
					async: true,
					//dataType: "json",
					data: {
						sensorId : $("#sensorIdMod").val()
					},
					//contentType: "application/json",
					success : function(data) {
						if(data.delResult) {
							alert("삭제완료 하였습니다.");
							document.detailForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
							$("#detailForm").submit();
						} else {
							alert("삭제실패 하였습니다.");
							return false;
						}

					},
					error : function(arg){
						alert("센서정보 삭제 실패");

					}
				});
			}

		};

		// 센서정보 상세조회에서 수정 버튼 클릭시
		function fnShowModModal() {
			$("#sensorIdMod").val($("#sensorIdDetail").text());

			document.detailForm.action = '<c:url value="/sensor/sensorModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#detailForm").submit();

		};

		// 페이지 로드시 댓글등록 폼 안보이게
		window.onload = function(){
			$("#modalReply").attr("style", "display:none");

			//$(".divSelect").attr("style", "display:none");
			$(".divMod").attr("style", "display:none");
			$(".locationDetailRegist").attr("style", "display:none");
			$(".divTextCount").attr("style", "display:none");
			$(".fileUpload").attr("style", "display:none");

		};

		// 댓글등록 버튼시
		function fnShowReplyRegistForm() {
			$("#modalReply").attr("style", "display:block");
		};

		// 댓글등록 폼에서 취소버튼 클릭시
		function fnCancel() {
			$("#modalReply").attr("style", "display:none");
		}

		//댓글등록시 textarea 바이트 수 체크하는 함수
		function fnCheckByteReply(event, obj){

			fnTextAreaPressSpecial(event, obj); // 특수문자 제거

			const maxByte = 100; //최대 100바이트
			const text_val = obj.value; //입력한 문자
			const text_len = text_val.length; //입력한 문자수
			var count = 0;
			let totalByte=0;
			for(let i=0; i<text_len; i++){
				const each_char = text_val.charAt(i);
				const uni_char = escape(each_char); //유니코드 형식으로 변환
				if(uni_char.length>4){
					// 한글 : 2Byte
					totalByte += 2;
					count += 1;
				}else{
					// 영문,숫자,특수문자 : 1Byte
					totalByte += 1;
					count += 1;
				}

				if(totalByte >= maxByte) {
					break;
				}
			}

			obj.value = obj.value.substr(0, count);
			if(totalByte > maxByte){
				fnCheckByteReply(event, obj);
				document.getElementById("textareaByteCnt").innerText = totalByte;
				document.getElementById("textareaByteCnt").style.color = "red";
				alert('최대 100Byte까지만 입력가능합니다.');
			}else{
				document.getElementById("textareaByteCnt").innerText = totalByte;
				document.getElementById("textareaByteCnt").style.color = "green";
			}

		};

		//댓글수정시 textarea 바이트 수 체크하는 함수
		function fnCheckByteMod(event, obj, cnt){

			fnTextAreaPressSpecial(event, obj); // 특수문자 제거

			const maxByte = 100; //최대 100바이트
			const text_val = obj.value; //입력한 문자
			const text_len = text_val.length; //입력한 문자수
			var count = 0;
			let totalByte=0;
			for(let i=0; i<text_len; i++){
				const each_char = text_val.charAt(i);
				const uni_char = escape(each_char); //유니코드 형식으로 변환
				if(uni_char.length>4){
					// 한글 : 2Byte
					totalByte += 2;
					count += 1;
				}else{
					// 영문,숫자,특수문자 : 1Byte
					totalByte += 1;
					count += 1;
				}

				if(totalByte >= maxByte) {
					break;
				}
			}

			obj.value = obj.value.substr(0, count);
			if(totalByte > maxByte){
				fnCheckByteMod(event, obj);
				document.getElementById("textareaByteCnt"+cnt).innerText = totalByte;
				document.getElementById("textareaByteCnt"+cnt).style.color = "red";
				alert('최대 100Byte까지만 입력가능합니다.');
			}else{
				document.getElementById("textareaByteCnt"+cnt).innerText = totalByte;
				document.getElementById("textareaByteCnt"+cnt).style.color = "green";
			}

		};

		// 업로드할 파일 선택시
		function fnCheckFileName(obj){
			var str = obj.value;
			//1. 확장자 체크
			var ext =  str.split('.').pop().toLowerCase();
			if($.inArray(ext, ['jpg', 'jpeg', 'png', 'bmp']) == -1) {
				//alert(ext);
				alert(ext+'파일은 업로드 하실 수 없습니다.');
				obj.value = "";
				return false;
			}

			/*
            //2. 파일명에 특수문자 체크
            var pattern =   /[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi;
            if(pattern.test(str) ){
                //alert("파일명에 허용된 특수문자는 '-', '_', '(', ')', '[', ']', '.' 입니다.");
                //alert('파일명에 특수문자를 제거해주세요.');
                //obj.value = "";
                obj.value = obj.value.replaceAll(/[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi, '');
                return false;
            }
            */
		};

		// 댓글 수정 버튼(폼 변경) 클릭시
		function fnReplyModFormChange(count) {
			$("#titleDetail"+count).attr("style", "display:none");
			document.getElementById("titleMod"+count).type = "text";
			$("#titleMod"+count).val($("#titleDetail"+count).text());
			$("#titleMod"+count).attr("style", "display:block");

			$("#divSelect"+count).attr("style", "display:none"); // 댓글수정 버튼, 댓글삭제버튼 안보이게
			$("#divMod"+count).attr("style", "display:block"); // 수정버튼, 취소버튼 보이게

			$("#realPicture"+count).attr("style", "display:none"); // 실사진 안보이게
			$("#sensorDetailDetail"+count).attr("style", "display:none"); // 상세위치설명 안보이게
			$("#fileDetail"+count).attr("style", "display:none"); // 파일이름, 사이즈 안보이게
			$("#locationDetailRegist"+count).attr("style", "display:block"); // 상세위치설명 textarea 보이게
			$("#locationDetailRegist"+count).val($("#sensorDetailDetail"+count).text());
			$("#divTextCount"+count).attr("style", "display:block"); // 바이트수 보이게

			$("#locationDetailRegist"+count).focus();

			var event = document.createEvent("Events");
			event.initEvent('keydown', true, true);
			event.keyCode = 13;
			document.getElementById('locationDetailRegist'+count).dispatchEvent(event);

			$("#fileUpload"+count).attr("style", "display:block"); // 파일 업로드 보이게

			$("#modalReplyList"+count).focus(); // 해당 폼으로 포커스 이동
		};

		// 댓글 수정 폼에서 수정버튼 클릭시
		function fnReplyMod(count) {

			var replyId = $("#replyIdMod"+count).val();
			var title = $("#titleMod"+count).val();
			var locationDetail = $("#locationDetailRegist"+count).val();
			var fileUploadMod = $("#fileUpload"+count).val();

			if(title == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			}

			var data = new FormData($("#replyListForm"+count)[0]); // 업로드할 파일
			data.append("replyId", replyId); // 작성자ID
			data.append("title", title); // 제목
			data.append("locationDetail", locationDetail); // 센서위치설명
			data.append("fileUpload", fileUploadMod); // 업로드 파일

			$.ajax({
				url: "/sensor/sensorReplyMod.do",
				type: "POST",
				enctype: 'multipart/form-data',
				async: true,
				processData:false,
				contentType:false,
				//dataType: "json",
				data:data,
				//contentType: "application/json",
				success : function(data) {
					//alert("통신성공시에만 실행");
					if(data.modResult) {
						alert("댓글 저장완료 하였습니다.");
						document.replyForm.action = '<c:url value="/sensor/sensorDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
						$("#replyForm").submit();

					} else {
						alert("댓글 저장실패 하였습니다.");
					}

				},
				error : function(arg){
					alert("저장 실패");

				}
			});

		};

		// 댓글 삭제 버튼 클릭시
		function fnDelReply(count) {
			if(confirm("댓글을 삭제 하시겠습니까?")) {
				$.ajax({
					url: "/sensor/sensorReplyDel.do",
					type: "POST",
					async: true,
					//dataType: "json",
					data: {
						replyId : $("#replyIdMod" + count).val()
					},
					//contentType: "application/json",
					success : function(data) {
						if(data.delResult) {
							alert("삭제완료 하였습니다.");
							location.reload();
						} else {
							alert("삭제실패 하였습니다.");
							return false;
						}

					},
					error : function(arg){
						alert("댓글 삭제 실패");

					}
				});
			}
		};

		// 댓글 수정 취소 버튼 클릭시
		function fnModCancel(count) {
			$("#titleDetail"+count).attr("style", "display:block");
			document.getElementById("titleMod"+count).type = "hidden";
			$("#titleMod"+count).val("");
			$("#titleMod"+count).attr("style", "display:none");

			$("#divSelect"+count).attr("style", "display:display");
			$("#divMod"+count).attr("style", "display:none");
			//$("#modChangeForm"+count).attr("style", "display:block");
			//$("#modDel"+count).attr("style", "display:block");
			//$("#mod"+count).attr("style", "display:none");
			//$("#modCancel"+count).attr("style", "display:none");

			$("#realPicture"+count).attr("style", "display:block"); // 실사진 보이게
			$("#sensorDetailDetail"+count).attr("style", "display:block"); // 상세위치설명 보이게
			$("#fileDetail"+count).attr("style", "display:block"); // 파일이름, 사이즈 보이게
			$("#locationDetailRegist"+count).attr("style", "display:none"); // 상세위치설명 textarea 안보이게
			//$("#locationDetailRegist"+count).val($("#sensorDetailDetail"+none).text());
			$("#divTextCount"+count).attr("style", "display:none"); // 바이트수 안보이게
			$("#fileUpload"+count).attr("style", "display:none"); // 파일 업로드 안보이게

		};

	</script>
</head>
<body>
<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	<div class="sh-main">


		<div id="backdrop_on" class="res-backdrop fade"></div>
		<div class="sh-header">
			<!-- reponsive header -->
			<div class="responsive-title">
				<h2 class="responsive-title-txt h4-bold">센서 정보관리 상세조회</h2>
			</div>

			<div class="title">
				<h2 class="title-txt h2-bold">센서 정보관리</h2>
				<p class="title-menu">
					<span class="home"></span>
					<span class="depth-menu body-1-bold">센서</span>
					<span class="depth-menu body-1-bold">센서 정보관리</span>
				</p>
			</div>
		</div>

		<div class="sh-content">
			<div class="reg-info heightauto" >
				<div class="reg-title"><p class="body-1-bold">센서 정보관리 상세조회</p></div>

				<!-- table-->
				<form id="detailForm" name="detailForm" action="/sensor/sensorList.do" method="post">
					<input type="hidden" value="I" id="type" name="type">
				<div class="wrap-table-reg detail-table-m">
					<table class="detail-table1">

						<tbody>
						<tr>
							<th>센서ID</th>
							<td class="res-title-td">센서ID</td>
							<td class="reg-input1 detail-bottom">
								<div class=" res-detail-td">
									<p class="pc-title-td body-3-bold">센서ID</p>
									<span class="detail-desc-txt"id="sensorIdDetail" name="sensorIdDetail"><c:out value="${sensorInfoDetail.sensorId}" escapeXml="false" /></span>
									<input type="hidden" id="sensorIdMod" name="sensorIdMod" value="${sensorInfoDetail.sensorId}"/>
								</div>
							</td>

							<th>센서명</th>
							<td class="res-title-td">센서명</td>
							<td class="reg-input1 detail-bottom">
								<div class="res-detail-td">
									<p class="pc-title-td body-3-bold">센서명</p>
									<span class="detail-desc-txt" id="sensorNmDetail" name="sensorNmDetail"><c:out value="${sensorInfoDetail.sensor}" escapeXml="false" /></span>
								</div>
							</td>
						</tr>
						<tr class="detail-height-td">
							<th>관수ID</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">관수ID</p>
									<span class="detail-desc-txt" id="irrigationIdDetail" name="irrigationIdDetail"><c:out value="${sensorInfoDetail.irrigationId}" escapeXml="false" /></span>
								</div>

							</td>
							<th>관수명</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">관수ID</p>
									<span class="detail-desc-txt" id="irrigationNmDetail" name="irrigationNmDetail"><c:out value="${sensorInfoDetail.irrigationName}" escapeXml="false" /></span>
								</div>
							</td>
						</tr>
						<tr class="detail-height-td" >
							<th>기관명</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">기관명</p>
									<span class="detail-desc-txt" id="orgNmDetail" name="orgNmDetail"><c:out value="${sensorInfoDetail.organization}" escapeXml="false" /></span>
								</div>
							</td>
							<th>지역명</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">지역명</p>
									<span class="detail-desc-txt" id="localNmDetail" name="localNmDetail"><c:out value="${sensorInfoDetail.local}" escapeXml="false" /></span>
								</div>
							</td>
						</tr>
						<tr class="detail-height-td" >
							<th>배터리 잔량</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">배터리 잔량</p>
									<span class="detail-desc-txt">-</span>
								</div>
							</td>
							</td>
							<th>센서 상태</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">센서 상태</p>
									<span class="detail-desc-txt"><span class="body-2-bold label-on">ON</span></span>
								</div>
							</td>
						</tr>
						<tr class="detail-height-td" >
							<th>유심코드</th>

							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">유심코드</p>
									<span class="detail-desc-txt">-</span>
								</div>
							</td>
							</td>
							<th>반출 여부</th>
							<td class="reg-select-td">
								<div class="res-detail-td detail-bottom">
									<p class="pc-title-td body-3-bold">반출 여부</p>
									<span class="detail-desc-txt">-</span>
								</div>
							</td>
						</tr>
						<tr class="detail-height-td" >
							<th>
								센서 위치 설명
							</th>

							<td colspan="3" class="reg-select-td">
								<div class="res-detail-td detail-bottom sensor-loc-table">
									<p class="pc-title-td body-3-bold">센서 위치 설명</p>

										<!-- GIS 배경지도 -->
										<div id="map" style="width: 100%; height: 250px"></div>
										<span class="detail-desc-txt" id="sensorDetailDetail" name="sensorDetailDetail"><c:out value="${sensorInfoDetail.sensorDetail}" escapeXml="false" /></span>

								</div>
							</td>

						</tr>
						</tbody>
					</table>
				</div>
				</form>

				<!--button -->
				<div class="btn-area-reg">
					<%--<button class="list-btn" ><a href="sensor_info_list.html">목록</a></button>
					<button class="modify-btn"><a href="sensor_info_modify.html">수정</a></button>
					<button class="cancel-btn" data-toggle="modal" data-target="#delIrr" >삭제</button>--%>

					<button class="list-btn" type="button" onclick="fnCloseDetailModal()"><a>목록</a></button>
						<button class="modify-btn" type="button" onclick="fnShowReplyRegistForm()"><a>댓글등록</a></button>
					<button class="modify-btn" type="button" onclick="fnShowModModal()"><a>수정</a></button>
					<button class="cancel-btn" type="button" data-toggle="modal" data-target="#delIrr" onclick="fnDel()"><a>삭제</a></button>


					<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
					<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
					<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
					<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
					<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
					<input type="hidden" id="sortType" name="sortType" value="${sortType}">
					<input type="hidden" id="page" name="page" value="${page}">
					<input type="hidden" id="range" name="range" value="${range}">
					<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
				</div>
			</div>


			<!-- 센서 댓글 등록 시작 -->
			<div id="modalReply" class="modal-overlay">
				<div class="modal-wrap">
					<div class="modal-content">
						<div class="modal-head">
							<h3 id="modal-title">댓글등록</h3>
							<!-- <a class="modal-close" title="닫기">닫기</a>  -->
						</div>
						<div class="modal-body">
							<form id="replyForm" name="replyForm" action="/sensor/sensorReplyList.do" method="post">
								<input type="hidden" value="I" id="type" name="type">
								<table class="tb-default" border="1">
									<tbody>
									<tr align="center">
										<th width="100">작성자ID</th>
										<td>
											<span id="writerIdRegist" name="writerIdRegist">check</span>
											<input type="hidden" id="sensorIdParam" name="sensorIdParam" value="<c:out value="${sensorInfoDetail.sensorId}" escapeXml="false" />"/>
										</td>
										<th>작성자명</th>
										<td>
											<span id="writerNmRegist" name="writerNmRegist">유성우</span>
										</td>
									</tr>
									<tr>
										<th>제목(*)</th>
										<td colspan="3">
											<input type="text" id="titleRegist" name="titleRegist"  onkeydown="onkeyup="fnPressSpecial(event, this)" onkeyup="fnPressSpecial(event, this)"/>
										</td>
									</tr>
									<tr>
										<th>센서 위치 설명</th>
										<td colspan="3">
											<!--
                                            <img id="viewMap" widht="250" height="250" alt="조감도" onerror="this.style.display='none'"></img>
                                             -->
											<textarea id="locationDetailRegist" name="locationDetailRegist" onkeydown="fnCheckByteReply(event, this)" onkeyup="fnCheckByteReply(event, this)"></textarea>
											<p>
												<span id="textareaByteCnt"></span> byte / 100 byte
											<p>
												<input type="file" value="" id="fileUpload" name="fileUpload" enctype="multipart/form-data" accept="image/*" onchange="fnCheckFileName(this)">
										</td>
									</tr>
									<tr>
										<td colspan="4" name="tdAlign">
											<div class="modal-button">
												<button type="button" class="modal-regist" onclick="fnReplySave()">댓글등록</button>
												<button type="button" class="btn-cancel" onclick="fnCancel()">취소</button>
												<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
												<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
												<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
												<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
											</div>
										</td>
									</tr>
									</tbody>
								</table>
							</form>
						</div>
					</div>
				</div>
				<div class="modal-layer"></div>
			</div>
			<!-- 센서 댓글 등록 끝 -->

			<!-- 센서 댓글 리스트 시작 -->
			<c:choose>
				<c:when test="${empty sensorReplyList}">
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${sensorReplyList}" varStatus="status">

						<div id="modalReplyList${status.count}" class="modal-overlay">
							<div class="modal-wrap">
								<div class="modal-content">
									<div class="modal-head">
										<h3 id="modal-title">댓글<c:out value="${status.count}" escapeXml="false" /></h3>
										<!-- <a class="modal-close" title="닫기">닫기</a>  -->
									</div>
									<div class="modal-body">
										<form id="replyListForm${status.count}" name="replyListForm" action="/sensor/sensorReplyList.do" method="post">
											<input type="hidden" value="I" id="type" name="type">
											<table class="tb-default" border="1">
												<tbody>
												<tr align="center">
													<th width="100">작성자ID</th>
													<td>
														<span id="writerIdDetail${status.count}" name="writerIdDetail${status.count}"><c:out value="${item.writerId}" escapeXml="false" /></span>
														<input type="hidden" id="replyIdMod${status.count}" name="replyIdMod${status.count}" value="<c:out value="${item.replyId}" escapeXml="false" />"/>
													</td>
													<th>작성자명</th>
													<td>
														<span id="writerNmDetail${status.count}" name="writerNmDetail${status.count}"><c:out value="${item.name}" escapeXml="false" /></span>
													</td>
												</tr>
												<tr>
													<th>제목</th>
													<th>
														<span id="titleDetail${status.count}" name="titleDetail${status.count}"><c:out value="${item.title}" escapeXml="false" /></span>
														<input type="hidden" id="titleMod${status.count}" name="titleMod${status.count}" />
													</td>
													<th>등록일시</th>
													<td>
														<span id="regDateTimeDetail${status.count}" name="regDateTimeDetail${status.count}"><c:out value="${item.regDateTime}" escapeXml="false" /></span>
													</td>
												</tr>
												<tr>
													<th>센서 위치 설명</th>
													<td colspan="3">
														<c:if test="${not empty item.uuidName}">
															<img id="realPicture${status.count}" width="250" height="250" src="/sensor/display.do?filename=${item.uuidName}" onerror="this.style.display='none'"></img>
														</c:if>
														<p>
															<span id="sensorDetailDetail${status.count}" name="sensorDetailDetail${status.count}"><c:out value="${item.sensorDetail}" escapeXml="false" /></span>
														<p>
															<c:if test="${not empty item.uuidName }">
															<span id="fileDetail${status.count}" name="fileDetail${status.count}"><c:out value="${item.oriFileName}" escapeXml="false" />  <c:out value="${item.fileSize}" escapeXml="false" />KB</span>
															</c:if>
															<textarea id="locationDetailRegist${status.count}" name="locationDetailRegist${status.count}" class="locationDetailRegist" maxlength="100" onkeydown="fnCheckByteMod(event, this, '${status.count}')" onkeyup="fnCheckByteMod(event, this, '${status.count}')"></textarea>
														<p>
														<div id="divTextCount${status.count}" class="divTextCount">
															<span id="textareaByteCnt${status.count}" name="textareaByteCnt${status.count}" class="textareaByteCnt"></span><span id="textareaByteCntText${status.count}" name="textareaByteCntText${status.count}" class="textareaByteCnt"> byte / 100 byte</span>
														</div>
														<p>
															<input type="file" id="fileUpload${status.count}" name="fileUpload${status.count}" class="fileUpload" enctype="multipart/form-data" accept="image/*" onchange="fnCheckFileName(this)">
													</td>
												</tr>
												<tr>
													<td colspan="4" align="center">
														<div id="divSelect${status.count}" class="divSelect" align="center">
															<button type="button" id="modChangeForm${status.count}" class="modal-regist" onclick="fnReplyModFormChange('${status.count}')">댓글수정</button>
															<button type="button" id="modDel${status.count}" class="btn-cancel" onclick="fnDelReply('${status.count}')">댓글삭제</button>
														</div>
														<div id="divMod${status.count}" class="divMod" align="center">
															<button type="button" id="mod${status.count}" class="modName" onclick="fnReplyMod('${status.count}')">수정</button>
															<button type="button" id="modCancel${status.count}" class="modCancelName" onclick="fnModCancel('${status.count}')">취소</button>
														</div>
													</td>
												</tr>
												</tbody>
											</table>
										</form>
									</div>
								</div>
							</div>
							<div class="modal-layer"></div>
						</div>
						<!-- 센서 댓글 리스트 끝 -->

					</c:forEach>
				</c:otherwise>
			</c:choose>
			<!--

               <div class="detail-info2" >
                  <div class="title-detail2"><p class="title-detail-txt2">센서ID 수정 히스토리</p></div>

                  <div class="wrap-table100-nextcols js-pscroll table101 ver1">
                    <div class="table100-nextcols">
                      <table>
                      <thead>
                      <tr class="row100 head">
                        <th class="cell100 column1">번호</th>
                        <th class="cell100 column2">센서 위치</th>
                        <th class="cell100 column3">수정자</th>
                        <th class="cell100 column4">등록일시(수정일시)</th>
                        <th class="cell100 column5">센서 위치 설명</th>
                        <th class="cell100 column6">첨부이미지</th>
                      </tr>
                      </thead>
                      <tbody>
                      <tr class="row100 body odd">
                          <td class="cell100 column1">1</td>
                          <td class="cell100 column2">대성디폴리스 A동 430호</td>
                          <td class="cell100 column3">홍길동</td>
                          <td class="cell100 column4">2022.12.06 13:17:11</td>
                          <td class="cell100 column5">지앤 아파트 101동 앞 정원</td>
                          <td class="cell100 column6"></td>
                      </tr>
                    </tbody>
                  </table>
                  </div>
                </div>
              </div>

            -->
		</div>

		<div class="space-list">
			<footer class="footer-list">
				<div class="mb-1 footer-column">
					<span class="body-3-bold footer-content">(주)성하  대표이사: 조정윤</span>
					<span class="footer-bar">|</span> <span class="body-3-regular footer-content">사업자등록번호: 705-86-01108</span>
					<span class="footer-bar">|</span>
					<span class="body-3-regular footer-content">대표번호: 02-596-2200</span> <span class="footer-bar">|</span> <span class="body-3-regular footer-content">팩스번호: 02-512-5161</span> <span class="footer-bar">|</span>
					<span class="body-3-regular footer-content">이메일: sungha0405@hanmail.net</span>
				</div>
			</footer>
		</div>
	</div>
</body>
</html>



<!-- Modal -->
<div class="modal fade" id="delIrr" tabindex="-1" role="dialog" aria-labelledby="delIrrLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-fix-del" role="document">
		<div class="modal-content modal-content-fix-del">
			<div class="modal-header" style="border-bottom: 0px;">
				<h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
				<span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
			</div>
			<div class="msg"></div>
			<div class="modal-body modal-body-content-del">
				선택한 센서를 삭제 하시겠습니까?
			</div>

			<div class="line-modal-del"></div>
			<div class="line-modal-del-bottom"></div>

			<div class=" modal-footer-fix-del">
				<button type="button" class="btn-confirm-modal" data-dismiss="modal" style="display:block;">예</button>
				<button type="button" class="btn-cancel-modal" data-dismiss="modal" style="display:block;">아니오</button>
			</div>
		</div>
	</div>
</div>




<!-- Modal -->
<div class="modal fade" id="delSensor" tabindex="-1" role="dialog" aria-labelledby="delIrrLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-fix-del" role="document">
		<div class="modal-content modal-content-fix-del">
			<div class="modal-header" style="border-bottom: 0px;">
				<h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
				<span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
			</div>
			<div class="msg"></div>
			<div class="modal-body modal-body-content-del">
				선택한 센서를 삭제 하시겠습니까?
			</div>

			<div class="line-modal-del"></div>
			<div class="line-modal-del-bottom"></div>

			<div class=" modal-footer-fix-del">
				<button type="button" class="btn-confirm-modal" data-dismiss="modal" style="display:block;">예</button>
				<button type="button" class="btn-cancel-modal" data-dismiss="modal" style="display:block;">아니오</button>
			</div>
		</div>
	</div>
</div>

