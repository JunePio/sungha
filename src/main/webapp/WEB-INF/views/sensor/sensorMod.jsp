<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : sensorMod.jsp
 * @Description : 센서정보 수정 조회 화면
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
	<title>센서 정보관리 수정</title>
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
		.btn-area-reg{padding-bottom: 10px; float: right;display:block!important;}
		.heightauto{height:auto !important;}
		.ALeft{
			float:left;
			margin: 0 10px 10px 10px;
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
	
	var globalCount = 0;
	
	// 센서정보 수정 모달에서 취소 버튼 클릭시
	function fnCloseModModal() {
		document.modForm.action = '<c:url value="/sensor/sensorDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#modForm").submit();
	};
	
	//수정시 textarea 바이트 수 체크하는 함수
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
	
	// 센서명 콤보박스 변경시
	function fnOrgNmModChange(e){
		$.ajax({
		    url: "/orgInfo/localNmList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	searchingOrgId : $("#orgNmMod").val(), // 콤보박스에서 선택된 항목의 센서ID
		    	searchingLocalId : $("#localNmMod").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#localNmMod").empty(); // 기존에 있던 항목은 지우고
				//$("#localNmMod").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNmMod").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
				}
				
				// 관수ID, 관수명 콤보박스 변경
				$.ajax({
				    url: "/sensor/irrigationComboList.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	localId : $("#localNmMod").val() // 콤보박스에서 선택된 항목의 지역ID
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
		})
	};
	
	// 센서정보 수정 모달에서 저장 버튼 클릭시
	function fnMod() {
		
		var sensorId = $("#sensorIdMod").text();
		var sensor = $("#sensorNmMod").val();
		var usimId = $("#usimIdMod").val();
		var orgId = $("#orgNmMod").val();
		var localId = $("#localNmMod").val();
		var outYn = $("#outYnMod").val();
		var sensorDetail = $("#textArea_byteLimitMod").val();
		var irrigationId = $("#irrigationId").val();
		
		if(sensorId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(sensor == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(usimId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		$.ajax({
		    url: "/sensor/sensorMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	sensorId : sensorId,
		    	sensor : sensor,
		    	usimId : usimId,
		    	orgId : orgId,
		    	localId : localId,
		    	sensorDetail : sensorDetail,
		    	outYn : outYn,
		    	irrigationId : irrigationId
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
				alert("수정완료 하였습니다.");
				document.modForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			    $("#modForm").submit();
				
			} else {
				alert("수정실패 하였습니다.");
				return false;
			}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			alert(JSON.stringify(arg));
		    }
		});
		
	};
	
	// 로딩시 textarea에서 글자 byte수를 세기 위해서 일부러 엔터 이벤트 발생
	window.onload = function(){
	   $("#textArea_byteLimitMod").focus();
	   	
	   var event = document.createEvent("Events");
	   event.initEvent('keydown', true, true);
	   event.keyCode = 13;
	   document.getElementById('textArea_byteLimitMod').dispatchEvent(event);
	   	   	  
	};
	
	// 관수ID 콤보박스 변경시
	function fnIrrigationIdChange() {
		$("#irrigationNm").val($("#irrigationId").val()).prop("selected", true);
	};
	
	// 관수명 콤보박스 변경시
	function fnIrrigationNmChange() {
		$("#irrigationId").val($("#irrigationNm").val()).prop("selected", true);
	};
	
	function fnlocalNmChange() {
		$.ajax({
		    url: "/sensor/irrigationComboList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	localId : $("#localNmMod").val() // 컴보박스에서 선택된 항목의 지역ID
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
	
	</script>
</head>
<body>
<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	<div class="sh-main">
		<div class="sh-header"><div class="responsive-title">
			<h2 class="responsive-title-txt h4-bold">센서 수정조회</h2>
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
				<div class="reg-title"><p class="body-1-bold">센서 정보관리 수정</p></div>
					<form id="modForm" name="modForm" action="/sensor/sensorMod.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="wrap-table-reg">
							<table class="detail-table1">
								<tbody>
								<tr>
									<th>센서ID </th>
									<td class="res-title-td">센서ID</td>
									<td class="reg-input1">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold">
											<span id="sensorIdMod"><c:out value="${sensorInfoModDetail.sensorId}" escapeXml="false" /></span></p>
											<input type="text" class="input-reg-irr input-dis" id="sensorIdParam" name="sensorIdParam" placeholder="ID"value="${sensorInfoModDetail.sensorId}"/>
										</div>
									</td>

									<th>센서명</th>
									<td class="res-title-td">센서명</td>
									<td class="reg-input1">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">센서명</div></p>
											<input type="text" class="input-reg-irr" placeholder="내용을 입력해주세요." id="sensorNmMod" maxlength="50" onkeyup="fnPressSpecial(event, this)" value="${sensorInfoModDetail.sensor}">
										</div>
									</td>
								</tr>
								<tr>
									<th>기관명</th>
									<td class="reg-select-td">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>


											<div class="res-sel-two">
												<select class="dropdown-sel reg-select res-sel-regi" id="orgNmMod" name="orgNmMod" onchange="fnOrgNmModChange(this)">
													<c:choose>
														<c:when test="${'total' eq orgNm}">
															<c:forEach var="item" items="${orgNmList}" varStatus="status">
																<option value="${item.organizationId}">${item.organization}</option>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<c:forEach var="item" items="${orgNmList}" varStatus="status">
																<option value="${item.organizationId}" <c:if test="${item.organizationId eq sensorInfoModDetail.organizationId}">selected</c:if> >${item.organization}</option>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</select>
												<button class="reg-btn-irr-loc">위치선택</button>
											</div>
									</td>
									<th>지역명</th>
									<td class="reg-select-td">
										<p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
										<div class="res-reg-td ">
											<p class="pc-title-td body-3-bold">지역명</p>
											<select  class="dropdown-sel reg-select res-sel" id="localNmMod" name="localNmMod" onchange="fnlocalNmChange()">
												<c:choose>
													<c:when test="${'total' eq localNm}">
														<c:forEach var="item" items="${localNmList}" varStatus="status">
															<option value="${item.localId}">${item.local}</option>
														</c:forEach>
													</c:when>
													<c:otherwise>
														<c:forEach var="item" items="${localNmList}" varStatus="status">
															<option value="${item.localId}" <c:if test="${item.localId eq sensorInfoModDetail.localId}">selected</c:if> >${item.local}</option>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th>유심코드</th>
									<td class="reg-select-td">
										<p class="pc-title-td body-3-bold">유심코드</p>
										<div class="res-reg-td reg-input1">
											<p class="pc-title-td body-3-bold">유심코드</p>
											<input type="text" class="input-reg-irr" placeholder="내용을 입력해주세요."id="usimIdMod" maxlength="12" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled" value="${sensorInfoModDetail.usimId}">
										</div>
									</td>
									<th>반출여부</th>
									<td class="reg-select-td">
										<p class="pc-title-td body-3-bold"><div class="div-require">반출여부</div></p>
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold">반출여부</p>
											<select class="dropdown-sel reg-select res-sel" id="outYnMod" name="outYnMod">
												<option value="Y" <c:if test="${'Y' eq sensorInfoModDetail.outYn}">selected</c:if>>반출</option>
												<option value="N" <c:if test="${'N' eq sensorInfoModDetail.outYn}">selected</c:if>>미반출</option>
											</select>
										</div>
									</td>
								</tr>

								<tr>
									<th>센서 위치 설명</th>
									<td colspan="3" class="reg-select-td">
										<p class="pc-title-td body-3-bold">센서위치 설명</p>
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold">관수 설정 상태</p>
											<textarea  class="textarea-reg" id="textArea_byteLimitMod" name="textArea_byteLimitMod" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"><c:out value="${sensorInfoModDetail.sensorDetail}" escapeXml="false" /></textarea>

											<span class="ALeft" ><span id="textareaByteCnt"></span> byte / 100 byte</span>
										</div>
									</td>
								</tr>
								<tr>
									<th>관수ID</th>
									<td>
										<select id="irrigationId" name="irrigationId" onchange="fnIrrigationIdChange()">
											<c:forEach var="item" items="${irrigationComboList}" varStatus="status">
												<option value="${item.irrigationId}" <c:if test="${item.irrigationId eq sensorInfoModDetail.irrigationId}">selected</c:if> >${item.irrigationId}</option>
											</c:forEach>
										</select>
									</td>
									<th>관수명</th>
									<td>
										<select id="irrigationNm" name="irrigationNm" onchange="fnIrrigationNmChange()">
											<c:forEach var="item" items="${irrigationComboList}" varStatus="status">
												<option value="${item.irrigationId}" <c:if test="${item.irrigationId eq sensorInfoModDetail.irrigationId}">selected</c:if> >${item.irrigationName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						<div class="btn-area-reg">
							<button type="button" class="modify-btn" id="user-reg-btn" onclick="fnMod()">저장</button>
							<button type="button" class="cancel-btn" onclick="fnCloseModModal()">취소</button>
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
					</form>
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- //layer popup 3 -->
	
</body>
</html>
