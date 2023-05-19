<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : irrigationDetail.jsp
 * @Description : 관수정보 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @ 2023.05.08  이준영
 */
%>
<html>
<head>
<meta charset="UTF-8">
	<title>관수 상세조회</title>
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
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script type="text/javascript" src="http://dapi.kakao.com/v2/maps/sdk.js?appkey=fbfe7816953095f8e8b87ef1e7967ffc&libraries=services,clusterer&charset=utf-8"></script>
	<script type="text/javascript" src="/static/js/map.js"></script>
	<link href="/static/css/map.css" rel="stylesheet">
	<style>
		.btn-area-reg{padding-bottom: 10px;}
		.heightauto{height:auto !important;}
		.main-content{height:auto !important;}
		.sh-content-detail{height:auto !important;}
		.ALeft {
			text-align:left!important;
			padding-left: 10px;
		}
		.detail-info-h {
			height:auto!important;
		}
		th, td {
			text-align: center;
		}
		
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
	
	</style>
	<script type="text/javascript">
		let map;
		let irrMarkers = []
		$(function(e){
			// 지도 정보를 가져온다
			fnInitMap();
			fnGetIrrigationInfo();
		});
		// 센서 정보를 가져온다
		function fnGetIrrigationInfo() {
			let iId = '<c:out value="${irrigationInfoDetail.irrigationId}" />';
			//센서정보를 초기화 한다
			// 마커 초기화
			removeMarker('irr');
			// 마커인포 초기화
			closeMarkerInfo();
			let data = JSON.stringify({ irrigationId :iId})
			let url ="<c:url value='/dashboard/dashIrrigationList.ajax'/>"
			$.ajax({
				url: url,
				data: data,
				dataType:'json',
				processData:false,
				contentType:'application/json; charset=UTF-8',
				type:'POST',
				traditional :true,
				success: function(data){
					createIrrigationMarkersByData(data);
					setIrrMarkers(map);
					// 마커 인포스타일을 변경한다
					fnSetMarkerInfoStyle();
				}
			});
			return false;
		}
	
	// 목록 버튼 클릭시
	function fnCloseDetailModal() {
		
		document.detailForm.action = '<c:url value="/irrigation/irrigationList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 저장버튼 클릭시
	function fnReplySave(){
		var writerId = $("#writerIdRegist").text();	
		var title = $("#titleRegist").val();
		var locationDetail = $("#locationDetailRegist").val();
		var irrigationIdParam = $("#irrigationIdParam").val();
		
		if(title == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		var data = new FormData($("#replyForm")[0]); // 업로드할 파일
		data.append("writerId", writerId); // 작성자ID
		data.append("title", title); // 제목
		data.append("locationDetail", locationDetail); // 관수위치설명
		data.append("irrigationIdParam", irrigationIdParam); // 관수ID
		
		$.ajax({
		    url: "/irrigation/irrigationReplySave.do",
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
				document.replyForm.action = '<c:url value="/irrigation/irrigationDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
	
	// 관수정보 상세 모달에서 삭제 버튼 클릭시
	function fnDel() {
		
		if(confirm("선택한 관수를 삭제 하시겠습니까?")) {
			$.ajax({
			    url: "/irrigation/irrigationDel.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	irrigationId : $("#irrigationIdMod").val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	if(data.delResult) {
			    		alert("삭제완료 하였습니다.");
			    		document.detailForm.action = '<c:url value="/irrigation/irrigationList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					    $("#detailForm").submit();
			    	} else {
			    		alert("삭제실패 하였습니다.");
			    		return false;
			    	}
			    	
			    }, 
			    error : function(arg){
				alert("관수정보 삭제 실패");
				
			    }
			});		
		}

	};
	
	// 관수정보 상세조회에서 수정 버튼 클릭시
	function fnShowModModal() {
		$("#irrigationIdMod").val($("#irrigationIdDetail").text());
		
		document.detailForm.action = '<c:url value="/irrigation/irrigationModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
		$("#modalReply").focus();
	};
	
	// 댓글등록 폼에서 취소버튼 클릭시 
	function fnCancel() {
		$("#modalReply").attr("style", "display:none");
	}
	
	//등록시 textarea 바이트 수 체크하는 함수
	function fnCheckByte(event, obj){
		
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
    		fnCheckByte(event, obj);
			document.getElementById("textareaByteCnt").innerText = totalByte;
            document.getElementById("textareaByteCnt").style.color = "red";
            alert('최대 100Byte까지만 입력가능합니다.');
        }else{
        	document.getElementById("textareaByteCnt").innerText = totalByte;
            document.getElementById("textareaByteCnt").style.color = "green";
        }
    	
	};
	
	//등록시 textarea 바이트 수 체크하는 함수
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
		$("#irrigationDetailDetail"+count).attr("style", "display:none"); // 상세위치설명 안보이게
		$("#fileDetail"+count).attr("style", "display:none"); // 파일이름, 사이즈 안보이게
		$("#locationDetailRegist"+count).attr("style", "display:block"); // 상세위치설명 textarea 보이게
		$("#locationDetailRegist"+count).val($("#irrigationDetailDetail"+count).text());
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
		data.append("locationDetail", locationDetail); // 관수위치설명
		data.append("fileUpload", fileUploadMod); // 업로드 파일
		
		$.ajax({
		    url: "/irrigation/irrigationReplyMod.do",
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
				document.replyForm.action = '<c:url value="/irrigation/irrigationDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
			    url: "/irrigation/irrigationReplyDel.do",
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
		
		$("#realPicture"+count).attr("style", "display:block"); // 실사진 안보이게
		$("#irrigationDetailDetail"+count).attr("style", "display:block"); // 상세위치설명 안보이게
		$("#fileDetail"+count).attr("style", "display:block"); // 파일이름, 사이즈 안보이게
		$("#locationDetailRegist"+count).attr("style", "display:none"); // 상세위치설명 textarea 보이게
		//$("#locationDetailRegist"+count).val($("#irrigationDetailDetail"+none).text());
		$("#divTextCount"+count).attr("style", "display:none"); // 바이트수 보이게
		$("#fileUpload"+count).attr("style", "display:none"); // 파일 업로드 보이게
		
	};
	
	</script>
</head>
<body>
<div class="sh-app">
<%@ include file="/WEB-INF/views/menu.jsp" %>
<div class="sh-main">
	<div class="sh-header">
		<!-- reponsive header -->
		<div class="responsive-title">
			<h2 class="responsive-title-txt h4-bold">관수 정보관리 상세조회</h2>
		</div>

		<div class="title">
			<h2 class="title-txt h2-bold">관수 정보관리</h2>
			<p class="title-menu">
				<span class="home"></span>
				<span class="depth-menu body-1-bold">관수</span>
				<span class="depth-menu body-1-bold">관수 정보관리</span>
			</p>
		</div>
	</div>

	<div class="sh-content">
		<div class="reg-info heightauto" >
			<div class="reg-title"><p class="body-1-bold">관수 정보관리 상세조회</p></div>
					<form id="detailForm" name="detailForm" action="/irrigation/irrigationList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="wrap-table-reg">
							<table class="detail-table1">
								<tbody>
								<tr>
									<th>관수ID</th>
									<td class="res-title-td">관수ID</td>
									<td class="reg-input1 detail-bottom">
										<div class=" res-detail-td">
											<span id="irrigationIdDetail" name="irrigationIdDetail"><c:out value="${irrigationInfoDetail.irrigationId}" escapeXml="false" /></span>
											<input type="hidden" id="irrigationIdMod" name="irrigationIdMod" value="${irrigationInfoDetail.irrigationId}"/>
										</div>
									</td>

									<th>관수명</th>
									<td class="res-title-td">관수명</td>
									<td class="reg-input1 detail-bottom">
										<div class="res-detail-td">
											<span id="irrigationNmDetail" name="irrigationNmDetail"><c:out value="${irrigationInfoDetail.irrigationName}" escapeXml="false" /></span>
										</div>
									</td>
								</tr>

								<tr>
									<th>기관명</th>
									<td class="reg-select-td">
										<div class="res-detail-td detail-bottom">
											<p class="pc-title-td body-3-bold">기관명</p>
											<span id="orgNmDetail" name="orgNmDetail"><c:out value="${irrigationInfoDetail.organization}" escapeXml="false" /></span>
										</div>
									</td>
									<th>지역명</th>
									<td class="reg-select-td">
										<div class="res-detail-td detail-bottom">
											<p class="pc-title-td body-3-bold">지역명</p>
											<span id="localNmDetail" name="localNmDetail"><c:out value="${irrigationInfoDetail.local}" escapeXml="false" /></span>
										</div>

									</td>
								</tr>
								<tr>
									<th>
										관수 위치 설명
									</th>

									<td colspan="3" class="ALeft">
										<div id="map" style="width: 850px; height: 550px"></div>
										<p>
											<span id="irrigationDetailDetail" name="irrigationDetailDetail"><c:out value="${irrigationInfoDetail.irrigationDetail}" escapeXml="false" /></span>
									</td>

								</tr>
							</tbody>
						</table>
						</div>
							<div class="btn-area-reg" float="center">
								<button type="button" class="modify-btn" id="reply-reg-btn" onclick="fnShowReplyRegistForm()">댓글등록</button>
								<button type="button" class="list-btn" onclick="fnCloseDetailModal()">목록</button>
								<button type="button" class="modify-btn" id="user-reg-btn" onclick="fnShowModModal()">수정</button>
								<button type="button" class="cancel-btn" onclick="fnDel()">삭제</button>
								<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
								<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
								<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
								<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
								<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
								<input type="hidden" id="sortType" name="sortType" value="${sortType}">
							</div>

					</form>
				</div>
	</div>

	<!-- 관수 상세 조회 끝 -->
	


		
	<!-- 관수 수정 히스토리 조회 시작 -->

						<c:choose>
						<c:when test="${empty irrigationHistoryList}">
		
						</c:when>
						<c:otherwise>
	<div class="sh-content">
		<div class="main-content" headline="Stats">
							<div class="modal-head">
								<h3 id="modal-title">관수 수정 이력</h3>
								<!-- <a class="modal-close" title="닫기">닫기</a>  -->
							</div>
							<div class="modal-body">
								<form id="historyForm" name="historyForm" action="/irrigation/irrigationList.do" method="post">
								<input type="hidden" value="I" id="type" name="type">
								<table class="tb-default" border="1">
									<tbody>
										<tr align="center">
											<th>수정자ID</th>
											<th>수정자</th>
											<th>유량투입시간</th>
											<th>관수상태</th>
											<th>수정일시</th>
											<th>관수 위치 설명</th>
										</tr>
								<c:forEach var="item" items="${irrigationHistoryList}" varStatus="status">							
								<tr>
									<td>
										<span id="modUserId" name="modUserId"><c:out value="${item.userId}" escapeXml="false" /></span>
									</td>	
									<td>
										<span id="modName" name="modName"><c:out value="${item.name}" escapeXml="false" /></span>
									</td>
									<td>
										<span id="inputFlowStream" name="inputFlowStream"><c:out value="${item.streamTime}" escapeXml="false" /></span>
									</td>
									<td>
										<span id="irrigationState" name="irrigationState"><c:out value="${item.irrigationState}" escapeXml="false" /></span>
									</td>
									<td>
										<span id="dateTime" name="dateTime"><c:out value="${item.dateTime}" escapeXml="false" /></span>
									</td>
									<td colspan="3">
										<span id="irrigationLocationDetail" name="irrigationLocationDetail"><c:out value="${item.irrigationDetail}" escapeXml="false" /></span>
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</form>
					</div>
		</div>
	</div>

				</c:otherwise>
				</c:choose>

	<!-- 관수 수정 히스토리 조회 끝 -->
	
	
	
	<!-- 관수 댓글 등록 시작 -->
	<div id="modalReply" class="modal-overlay">
		<div class="sh-content">
			<div class="main-content" headline="Stats">
				<div class="modal-head">
					<h3 id="modal-title">댓글등록</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="replyForm" name="replyForm" action="/irrigation/irrigationReplyList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th width="100">작성자ID</th>
									<td>
										<span id="writerIdRegist" name="writerIdRegist">check</span>
										<input type="hidden" id="irrigationIdParam" name="irrigationIdParam" value="<c:out value="${irrigationInfoDetail.irrigationId}" escapeXml="false" />"/>
									</td>
									<th>작성자명</th>
									<td>
										<span id="writerNmRegist" name="writerNmRegist">유성우</span>
									</td>
								</tr>
								<tr>
									<th>제목(*)</th>
									<td colspan="3">
										<input type="text" id="titleRegist" name="titleRegist"  onkeydown="fnPressSpecial(event, this)" onkeyup="fnPressSpecial(event, this)"/>
									</td>
								</tr>
								<tr>
									<th>관수 위치 설명</th>
									<td colspan="3">
										<!-- 
										<img id="viewMap" widht="250" height="250" alt="조감도" onerror="this.style.display='none'"></img>
										 -->
										<textarea id="locationDetailRegist" name="locationDetailRegist" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"></textarea>
										<p>
										<span id="textareaByteCnt"></span> byte / 100 byte
										<p>
										<input type="file" value="" id="fileUpload" name="fileUpload" enctype="multipart/form-data" accept="image/*" onchange="fnCheckFileName(this)">
									</td>
								</tr>
							</tbody>
						</table>
						<div class="btn-area-reg">
							<button type="button" class="modify-btn" onclick="fnReplySave()">댓글등록</button>
							<button type="button" class="cancel-btn" onclick="fnCancel()">취소</button>
							<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
							<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
							<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
							<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
							<input type="hidden" id="page" name="page" value="${page}">
							<input type="hidden" id="range" name="range" value="${range}">
							<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- 관수 댓글 등록 끝 -->

	
	<c:choose>
	<c:when test="${empty irrigationReplyList}">
		
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${irrigationReplyList}" varStatus="status">
		<!-- 관수 댓글 리스트 시작 -->
		<div id="modalReplyList${status.count}" class="modal-overlay">
			<div class="sh-content">
				<div class="main-content" headline="Stats">
					<div class="sh-content-detail">
						<div class="reg-info-agency" >
							<div class="reg-title  require-pc-show"><p class="body-1-bold">댓글<c:out value="${status.count}" escapeXml="false" /></p>
					</div>
					</div>
						<form id="replyListForm${status.count}" name="replyListForm" action="/irrigation/irrigationReplyList.do" method="post">
							<input type="hidden" value="I" id="type" name="type">
							<table class="detail-table1">
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
										<td>
											<span id="titleDetail${status.count}" name="titleDetail${status.count}"><c:out value="${item.title}" escapeXml="false" /></span>
											<input type="hidden" id="titleMod${status.count}" name="titleMod${status.count}" />
										</td>
										<th>등록일시</th>
										<td>
											<span id="regDateTimeDetail${status.count}" name="regDateTimeDetail${status.count}"><c:out value="${item.regDateTime}" escapeXml="false" /></span>
										</td>
									</tr>
									<tr>
										<th>관수 위치 설명</th>
										<td colspan="3">
											<c:if test="${not empty item.uuidName }">
											<img id="realPicture${status.count}" name="realPicture${status.count}" width="250" height="250" src="/irrigation/display.do?filename=${item.uuidName}" onerror="this.style.display='none'"></img>
											</c:if>
											<p>
											<span id="irrigationDetailDetail${status.count}" name="irrigationDetailDetail${status.count}"><c:out value="${item.irrigationDetail}" escapeXml="false" /></span>
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
												<button type="button" id="modChangeForm${status.count}" class="modify-btn" onclick="fnReplyModFormChange('${status.count}')">댓글수정</button>
												<button type="button" id="modDel${status.count}" class="cancel-btn" onclick="fnDelReply('${status.count}')">댓글삭제</button>
											</div>
											<div id="divMod${status.count}" class="divMod" align="center">
												<button type="button" id="mod${status.count}" class="modify-btn" onclick="fnReplyMod('${status.count}')">수정</button>
												<button type="button" id="modCancel${status.count}" class="cancel-btn" onclick="fnModCancel('${status.count}')">취소</button>
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
		<!-- 관수 댓글 리스트 끝 -->
		
		</c:forEach>
	</c:otherwise>
	</c:choose>

</div>

</body>
</html>
