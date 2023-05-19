<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
/**
 * @Class Name : sensorControlDetail.jsp
 * @Description : 센서설정 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @
 */
%>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>센서 설정관리 상세조회</title>
    
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
    
	<script src="/static/js/filtering.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script type="text/javascript">
	
	// 센서정보 상세조회 모달에서 취소 버튼 클릭시
	function fnCloseDetailModal() {
		//$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
		
		document.detailForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
		
	};
	
	// 센서정보 수정 모달에서 저장 버튼 클릭시
	function fnMod() {
		var sensorId = $("#sensorIdParam").val();
		var alarmYn;
		if($("input[type=radio][id=alarmY]:checked").is(':checked')) { // 알람 여부 라디오 버큰 체크 여부 확인
			alarmYn = "Y";
		} else {
			alarmYn = "N";
		}
		
		var batteryMin = $("#batteryMin").val();
		var batteryMax = $("#batteryMax").val();
		var temperatureMin = $("#temperatureMin").val();
		var temperatureMax = $("#temperatureMax").val();
		var humidityMin = $("#humidityMin").val();
		var humidityMax = $("#humidityMax").val();
		var pHMin = $("#pHMin").val();
		var pHMax = $("#pHMax").val();
		var ECMin = $("#ECMin").val();
		var ECMax = $("#ECMax").val();
		var NMin = $("#NMin").val();
		var NMax = $("#NMax").val();
		var PMin = $("#PMin").val();
		var PMax = $("#PMax").val();
		var KMin = $("#KMin").val();
		var KMax = $("#KMax").val();
		
		$.ajax({
		    url: "/sensorControl/sensorControlMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	sensorId : sensorId,
		    	alarmYn : alarmYn,	    	
		    	batteryMin : batteryMin,
		    	batteryMax : batteryMax,
		    	temperatureMin : temperatureMin,
		    	temperatureMax : temperatureMax,
		    	humidityMin : humidityMin,
		    	humidityMax : humidityMax,
		    	pHMin : pHMin,
		    	pHMax : pHMax,
		    	ECMin : ECMin,
		    	ECMax : ECMax,
		    	NMin : NMin,
		    	NMax : NMax,
		    	PMin : PMin,
		    	PMax : PMax,
		    	KMin : KMin,
		    	KMax : KMax
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
				alert("수정완료 하였습니다.");
				//$("#modalMod").attr("style", "display:none"); // 센서정보 수정조회 모달 닫기
				//location.reload(); // 페이지 새로고침
				document.detailForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			    $("#detailForm").submit();
				
			} else {
				alert("수정실패 하였습니다.");
			}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			alert(JSON.stringify(arg));
		    }
		});
		
	};
	
	</script>
	
</head>
<body>
<%@ include file="/WEB-INF/views/menu.jsp" %>

<div class="sh-main">
    

       <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">센서 설정관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">센서 설정관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">설정</span> 
              <span class="depth-menu body-1-bold">센서 설정관리</span>
            </p>
        </div>
      </div>

<div class="sh-content">
         <div class="reg-info detail-info-h-type2" >
            <div class="reg-title"><p class="body-1-bold">센서 정보관리 상세조회</p></div>
             <!-- table-->
            <div class="wrap-table-reg detail-table-m">
                <table class="detail-table1">

                  <tbody>
                    <tr>
                      <th>센서ID</th> 
                        <td class="res-title-td">센서ID</td>
                        <td class="reg-input1 detail-bottom">
                          <div class="res-detail-td res-detail-td-type1">
                            <p class="pc-title-td body-3-bold">센서ID</p>
                            <span id="sensorIdDetail" class="detail-desc-txt" name="sensorIdDetail"><c:out value="${sensorControlDetail.sensorId}" escapeXml="false"/></span>
							<input type="hidden" id="sensorIdParam" name="sensorIdParam" value="${sensorControlDetail.sensorId}" />
                          </div>
                        </td>

                      <th>센서명</th>
                        <td class="res-title-td">센서명</td>
                        <td class="reg-input1 detail-bottom">
                          <div class="res-detail-td">
                              <p class="pc-title-td body-3-bold">센서명</p>
                              <span id="sensorNmDetail" class="detail-desc-txt" name="sensorNmDetail"><c:out value="${sensorControlDetail.sensor}" escapeXml="false"/></span>
                          </div>
                        </td>
                      </tr>

                    <tr class="detail-height-td" >
                      <th>관수ID</th>   
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">관수ID</p>
                          <span id="sensorIdDetail" class="detail-desc-txt" name="sensorIdDetail"><c:out value="${sensorControlDetail.irrigationId}" escapeXml="false"/></span>
                        </div>
                      </td>
                      <th>관수명</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                           <p class="pc-title-td body-3-bold">관수명</p>  
                           <span id="sensorNmDetail" class="detail-desc-txt" name="sensorNmDetail"><c:out value="${sensorControlDetail.irrigationName}" escapeXml="false"/></span>
                        </div>
                       
                      </td>
                    </tr>
                    <tr class="detail-height-td" >
                      <th>사용자</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">사용자</p> 
                          <span id="userNmDetail" class="detail-desc-txt" name="userNmDetail"></span>
                        </div>
                      </td>
                      <th>연락처</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">연락처</p>
                          <span id="telNoDetail" class="detail-desc-txt" name="telNoDetail"></span>
                        </div> 
                      </td>
                    </tr>
                    <tr class="detail-height-td" >
                      <th>
                      알림 설정
                      </th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">센서 위치 설명</p> 
                           <input type="radio" id="alarmY" name="alarmYn" value="ON" <c:if test="${sensorControlDetail.alarmYn eq 'Y'}">checked</c:if> />ON<input type="radio" id="alarmN" name="alarmYn" value="OFF" <c:if test="${sensorControlDetail.alarmYn eq 'N'}">checked</c:if> />OFF                           
                        </div>
                      </td>
                     <th>이메일</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">이메일</p>
                          <span id="emailDetail" class="detail-desc-txt" name="emailDetail"></span>
                        </div> 
                      </td>
                    </tr>
                    <tr class="detail-height-td" >
                      <th colspan="4">센서 알림 설정</th>    
                    </tr>
                    <tr class="detail-height-td" >
                      <th>배터리(%)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">배터리(%)</p> 
                          <input type="text" id="batteryMin" name="batteryMin" value="<c:out value="${sensorControlDetail.batcapremaValueMin}" escapeXml="false"/>"/> ~ <input type="text" id="batteryMax" name="batteryMax" value="<c:out value="${sensorControlDetail.batcapremaValueMax}" escapeXml="false"/>"/>
                        </div>
                      </td>
                      </td>
                      <th>온도(℃)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">온도(℃)</p>                          
                          <input type="text" id="temperatureMin" name="temperatureMin" value="<c:out value="${sensorControlDetail.tempValueMin}" escapeXml="false"/>"/> ~ <input type="text" id="temperatureMax" name="temperatureMax" value="<c:out value="${sensorControlDetail.tempValueMax}" escapeXml="false"/>"/>
                        </div> 
                      </td>
                    </tr>                 
                    <tr class="detail-height-td" >
                      <th>수분합량(%)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">수분합량(%)</p> 
                          <input type="text" id="humidityMin" name="humidityMin" value="<c:out value="${sensorControlDetail.humiValueMin}" escapeXml="false"/>"/> ~ <input type="text" id="humidityMax" name="humidityMax" value="<c:out value="${sensorControlDetail.humiValueMax}" escapeXml="false"/>"/>
                        </div>
                      </td>
                      </td>
                      <th>산도(PH)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">산도(PH)</p> 
                          <input type="text" id="pHMin" name="pHMin" value="<c:out value="${sensorControlDetail.phValueMin}" escapeXml="false"/>" /> ~ <input type="text" id="pHMax" name="pHMax" value="<c:out value="${sensorControlDetail.phValueMax}" escapeXml="false"/>" />
                        </div> 
                      </td>
                    </tr>
                    <tr class="detail-height-td" >
                      <th>전도도(ds/m)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">전도도(ds/m)</p>                          
                          <input type="text" id="ECMin" name="ECMin" value="<c:out value="${sensorControlDetail.conducValueMin}" escapeXml="false"/>" /> ~ <input type="text" id="ECMax" name="ECMax" value="<c:out value="${sensorControlDetail.conducValueMax}" escapeXml="false"/>" />
                        </div>
                      </td>
                      </td>
                      <th>질소(mg/kg)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">질소(mg/kg)</p> 
                          <input type="text" id="NMin" name="NMin" value="<c:out value="${sensorControlDetail.nitroValueMin}" escapeXml="false"/>" /> ~ <input type="text" id="NMax" name="NMax" value="<c:out value="${sensorControlDetail.nitroValueMax}" escapeXml="false"/>" />
                        </div> 
                      </td>
                    </tr>
                     <tr class="detail-height-td" >
                      <th>인(mg/kg)</th>                     
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">인(mg/kg)</p> 
                          <input type="text" id="PMin" name="PMin" value="<c:out value="${sensorControlDetail.phosValueMin}" escapeXml="false"/>" /> ~ <input type="text" id="PMax" name="PMax" value="<c:out value="${sensorControlDetail.phosValueMax}" escapeXml="false"/>" />
                        </div>
                      </td>
                      </td>
                      <th>칼륨(cmol/kg)</th>
                      <td class="reg-select-td">
                        <div class="res-detail-td detail-bottom">
                          <p class="pc-title-td body-3-bold">질소(mg/kg)</p> 
                          <input type="text" id="KMin" name="KMin" value="<c:out value="${sensorControlDetail.potaValueMin}" escapeXml="false"/>" /> ~ <input type="text" id="KMax" name="KMax" value="<c:out value="${sensorControlDetail.potaValueMax}" escapeXml="false"/>" />
                        </div> 
                      </td>
                    </tr>
                </tbody>
              </table>
            </div>
           
            <!--button -->
            <div class="btn-area-reg">
	        	<button type="button" class="modify-btn" id="user-reg-btn" onclick="fnMod()">저장</button>
				<button type="button" class="cancel-btn" onclick="fnCloseDetailModal()">취소</button>
				<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
				<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
				<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
				<input type="hidden" id="sortType" name="sortType" value="${sortType}">
				<input type="hidden" id="page" name="page" value="${page}">
				<input type="hidden" id="range" name="range" value="${range}">
				<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
            </div>     
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