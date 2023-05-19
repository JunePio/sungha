<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : sensorRegist.jsp
 * @Description : 센서정보 등록 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @ 2023.05.09  이준영
 */
%>
<html>
<head>
<meta charset="UTF-8">
	<title>센서 정보관리 등록</title>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="/static/assets/js/common.js"></script>
	<style>
		.btn-area-reg{padding-bottom: 10px; float: right;display:block!important}

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
	
	// 아이디 중복체크
	function fnDupCheck() {
		var sensorId_check = $('#inputSensorId').val().trim(); // 아이디 양쪽의 공백을 제거
		if(sensorId_check.indexOf(' ') > -1) { // 아이디 중간에 공백이 있는지 체크
			alert('아이디에 공백이 포함되어 있습니다.');
			return false;
		} else if(sensorId_check == '') { // 아이디 입력 안할 시
			alert('아이디를 입력해주세요.');
			return false;
		} else if(sensorId_check.length < 4 || sensorId_check.length > 10) { // 아이디는 4~10자리 까지 허용
			alert("아이디는 영문, 숫자 4~10자리까지 허용입니다.");
			return false;
		}
		
		$.ajax({
		    url: "/sensor/dupCheck.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	sensorId : $('#inputSensorId').val().trim()
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.dupCheckResult) { // 서버에서 확인한 결과가 중복된 아이디라면 경고창
				alert("중복된 아이디입니다.");					
			} else {
				alert("사용가능한 아이디 입니다.");
				//$("#dupResult").val("dupCheckYes"); // 저장하기 전에 체크하기 위해서 미리 중복체크 정보를 저장해둔다.
			}

		    }, 
		    error : function(arg){
			alert("중복확인 실패 하였습니다.");
			
		    }
		})
	};
	
	// 센서ID가 변경되었을 경우 중복확인 다시 체크
	function fnSensorIdChange() {
		$("#dupResult").val("dupCheckNo");
	};
	
	// 등록 모달에서 기관명 콤보박스 변경시
	function fnOrgNmRegistChange(e){
		$.ajax({
		    url: "/orgInfo/localNmList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	searchingOrgId : $("#orgNmRegist").val(), // 콤보박스에서 선택된 항목의 기관ID
		    	searchingLocalId : $("#localNmRegist").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#localNmRegist").empty(); // 기존에 있던 항목은 지우고
				//$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNmRegist").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
				}
				
				// 관수ID, 관수명 콤보박스 변경
				$.ajax({
				    url: "/sensor/irrigationComboList.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	localId : $("#localNmRegist").val() // 콤보박스에서 선택된 항목의 지역ID
				    },
				    //contentType: "application/json",
				    success : function(data) {
						//alert("통신성공시에만 실행");
						$("#irrigationId").empty(); // 기존에 있던 항목은 지우고
						//$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
						for(var i = 0; i < data.irrigationComboListSize ; i++) {
							$("#irrigationId").append("<option value=" + data.irrigationComboList[i].irrigationId + ">" + data.irrigationComboList[i].irrigationId + "</option>"); // 각 항목 추가
						}
						
						$("#irrigationNm").empty(); // 기존에 있던 항목은 지우고
						//$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
						for(var i = 0; i < data.irrigationComboListSize ; i++) {
							$("#irrigationNm").append("<option value=" + data.irrigationComboList[i].irrigationId + ">" + data.irrigationComboList[i].irrigationName + "</option>"); // 각 항목 추가
						}

				    }, 
				    error : function(arg){
					alert("통신실패시에만 실행");
					
				    }
				});
				
		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			
		    }
		});
	};
	
	function fnlocalNmChange() {
		$.ajax({
		    url: "/sensor/irrigationComboList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	localId : $("#localNmRegist").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#irrigationId").empty(); // 기존에 있던 항목은 지우고
				//$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.irrigationComboListSize ; i++) {
					$("#irrigationId").append("<option value=" + data.irrigationComboList[i].irrigationId + ">" + data.irrigationComboList[i].irrigationId + "</option>"); // 각 항목 추가

				}
				
				$("#irrigationNm").empty(); // 기존에 있던 항목은 지우고
				//$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.irrigationComboListSize ; i++) {
					$("#irrigationNm").append("<option value=" + data.irrigationComboList[i].irrigationId + ">" + data.irrigationComboList[i].irrigationName + "</option>"); // 각 항목 추가
				}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			
		    }
		});
	};
	
	// 저장버튼 클릭시
	function fnSave(){
		var sensorId = $("#inputSensorId").val();
		var sensor = $("#inputSensorNm").val();
		var usimId = $("#inputUsimId").val();
		var organizationId = $("#orgNmRegist").val();
		var localId = $("#localNmRegist").val();
		var outYn = $("#inputOutYn").val();
		var sensorDetail = $("#textArea_byteLimit").val();
		var irrigationId = $("#irrigationId").val();
		var dupResult = $("#dupResult").val();
		 
		if(sensorId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(sensor == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(usimId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(dupResult == "dupCheckNo") {  // 저장시 아이디 중복체크를 했는지 다시 체크
			alert("아이디 중복확인을 해주세요.");
			return false;
		}
		
		$.ajax({
		    url: "/sensor/sensorSave.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	sensorId : sensorId,
		    	sensor : sensor,
		    	usimId : usimId,
		    	organizationId : organizationId,
		    	localId : localId,
		    	outYn : outYn,
		    	sensorDetail : sensorDetail,
		    	irrigationId : irrigationId
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.saveResult) {
				alert("저장완료 하였습니다.");
				document.regForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			    $("#regForm").submit();
				
			} else {
				alert("저장실패 하였습니다.");
			}

		    }, 
		    error : function(arg){
			alert("저장 실패");
			
		    }
		});

	};
	
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
	
	// 취소 버튼 클릭시
	function fnCloseRegModal() {
		document.regForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#regForm").submit();
	};
	
	// 관수ID 콤보박스 변경시
	function fnIrrigationIdChange() {
		$("#irrigationNm").val($("#irrigationId").val()).prop("selected", true);
	};
	
	// 관수명 콤보박스 변경시
	function fnIrrigationNmChange() {
		$("#irrigationId").val($("#irrigationNm").val()).prop("selected", true);
	};
	
	</script>
</head>
<body>
	<!-- layer popup 1 -->
	<div class="sh-app">
		<%@ include file="/WEB-INF/views/menu.jsp" %>
		<div class="sh-main">
			<div id="backdrop_on" class="res-backdrop fade"></div>
			<div class="sh-header">
				<!-- reponsive header -->
				<div class="responsive-title">
					<h2 class="responsive-title-txt h4-bold">센서 정보관리</h2>
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
				<div class="main-content" headline="Stats">
					<form id="regForm" name="regForm" action="/sensor/sensorSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>센서ID(시리얼 넘버) <span class="required">*</span></th>
									<td class="res-title-td">센서ID<span class="required">*</span></td>
									<td class="reg-select-td">
										<div class="res-reg-td">
											<input type="hidden" value="dupCheckNo" id="dupResult">
											<input type="text" value="" id="inputSensorId" class="img-input-res"  placeholder="내용을 입력해주세요." name="inputSensorId" maxlength="30" onchange="fnSensorIdChange()" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled;    float: left;
    margin-left: 8px;">
											<button type="button" id="dupCheck" class="reg-btn-irr-loc" onclick="fnDupCheck()">중복확인</button>
										</div>
									</td>
									<th>센서명<span class="required">*</span></th>
									<td class="res-title-td">센서명<span class="required">*</span></td>
									<td class="reg-input1">
										<div class="res-reg-td">
											<input type="text" value=""class="input-reg-irr" placeholder="내용을 입력해주세요." id="inputSensorNm" name="inputSensorNm" maxlength="50" onkeyup="fnPressSpecial(event, this)">
										</div>
									</td>
								</tr>
								<tr>
									<th>기관명</th>
									<td class="reg-select-td">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
											<div class="res-sel-two">


										<select id="orgNmRegist" name="orgNmRegist" class="dropdown-sel reg-select res-sel-regi" onchange="fnOrgNmRegistChange(this)">
											<c:choose>
												<c:when test="${'total' eq orgNm}">
													<c:forEach var="item" items="${orgNmList}" varStatus="status">
														<option value="${item.organizationId}">${item.organization}</option>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="item" items="${orgNmList}" varStatus="status">
														<option value="${item.organizationId}" <c:if test="${item.organizationId eq orgNm}">selected</c:if> >${item.organization}</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
												<button class="reg-btn-irr-loc">위치선택</button>
											</div>
										</div>
									</td>
									<th>지역명</th>
									<td class="reg-select-td">
										<p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
										<div class="res-reg-td ">
											<p class="pc-title-td body-3-bold">지역명</p>
										<select class="dropdown-sel reg-select res-sel" id="localNmRegist" name="localNmRegist" onchange="fnlocalNmChange()">
											<c:choose>
												<c:when test="${'total' eq localNm}">
													<c:forEach var="item" items="${localNmList}" varStatus="status">
														<option value="${item.localId}">${item.local}</option>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="item" items="${localNmList}" varStatus="status">
														<option value="${item.localId}" <c:if test="${item.localId eq localNm}">selected</c:if> >${item.local}</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
										</div>
									</td>
								</tr>
								<tr>
									<th>유심코드</th>
									<td class="reg-input1">
										<p class="pc-title-td body-3-bold">유심코드</p>
										<div class="res-reg-td reg-input1">
											<p class="pc-title-td body-3-bold">유심코드</p>
											<input type="text" value=""class="input-reg-irr" placeholder="내용을 입력해주세요." id="inputUsimId" name="inputUsimId" maxlength="12" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
										</div>
									</td>
									<th>반출여부</th>
									<td class="reg-select-td">
										<p class="pc-title-td body-3-bold"><div class="div-require">반출여부</div></p>
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold">반출여부</p>
											<select class="dropdown-sel reg-select res-sel" id="inputOutYn" name="inputOutYn">
												<option value="Y">반출</option>
												<option value="N">미반출</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th class="th-res-sensor-loc">
										센서위치 설명
									</th>
									<td colspan="3" class="reg-input1">
										<p class="pc-title-td body-3-bold">센서위치 설명</p>
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold">관수 설정 상태</p>
											<textarea class="textarea-reg" id="textArea_byteLimit" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"></textarea>
											<p></p>
											<span  style="text-align: left;padding-left: 10px;"><span id="textareaByteCnt"></span> byte / 100 byte</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>관수ID</th>
									<td class="reg-select-td">
										<select id="irrigationId" name="irrigationId" class="dropdown-sel reg-select res-sel" onchange="fnIrrigationIdChange()">
											<c:forEach var="item" items="${irrigationComboList}" varStatus="status">
												<option value="${item.irrigationId}">${item.irrigationId}</option>
											</c:forEach>
										</select>
									</td>
									<th>관수명</th>
									<td class="reg-select-td">
										<select id="irrigationNm" name="irrigationNm" class="dropdown-sel reg-select res-sel" onchange="fnIrrigationNmChange()">
											<c:forEach var="item" items="${irrigationComboList}" varStatus="status">
												<option value="${item.irrigationId}">${item.irrigationName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<div class="btn-area-reg">
											<button type="button" class="modify-btn" id="user-reg-btn" onclick="fnSave()">저장</button>
											<button type="button" id="modal_close_btn" class="cancel-btn" onclick="fnCloseRegModal()">취소</button>
											<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
											<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
											<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
											<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
											<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
											<input type="hidden" id="sortType" name="sortType" value="${sortType}">
											<input type="hidden" id="page" name="page" value="${page}">
											<input type="hidden" id="range" name="range" value="${range}">
											<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
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
	<!-- //layer popup 1 -->
</body>
</html>
