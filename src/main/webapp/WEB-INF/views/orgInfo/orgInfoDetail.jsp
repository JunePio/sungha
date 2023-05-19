<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
/**
 * @Class Name : sensorDetail.jsp
 * @Description : 센서정보 상세 조회 화면
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
    <title>지역 관리</title>

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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>       
	<style>

		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
	
	</style>
	<script type="text/javascript">
	
	// 목록 버튼 클릭시
	function fnCloseDetailModal() {
		
		document.detailForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 기관정보 상세 모달에서 삭제 버튼 클릭시
	function fnDel() {
		
		$.ajax({
		    url: "/orgInfo/orgInfoDelIsOk.do",
		    type: "POST",
		    async: false,
		    //dataType: "json",
		    data: {
		    	orgId : $("#orgInfoIdMod").val()
		    },
		    //contentType: "application/json",
		    success : function(data) {
		    	if(!data.checkResult) {
					alert("포함된 사용자, 센서 및 관수가 있습니다.\n삭제 후 다시 시도하세요.");
					return false;
		    	} else {
		    		if(confirm("선택한 기관을 삭제 하시겠습니까?")) {
						$.ajax({
						    url: "/orgInfo/orgInfoDel.do",
						    type: "POST",
						    async: false,
						    //dataType: "json",
						    data: {
						    	orgId : $("#orgInfoIdMod").val()
						    },
						    //contentType: "application/json",
						    success : function(data) {
						    	alert("삭제완료 하였습니다.")
						    	document.detailForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
							    $("#detailForm").submit();
						    }, 
						    error : function(arg){
							alert("기관정보 삭제 실패");
							
						    }
						});		
					}
		    	}
		    }, 
		    error : function(arg){
			alert("기관정보 삭제 실패");
			
		    }
		});	
	};
	
	// 기관정보 상세조회에서 수정 버튼 클릭시
	function fnShowModModal() {
		
		document.detailForm.action = '<c:url value="/orgInfo/orgInfoModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
		
	};
	
	// 기관정보 상세보기에서 사용자 수 클릭 시 사용자 관리 페이지로 이동
	function fnJumpToUserMng() {
		document.location.href="/userMng/userMngList.do";
	};
	
	// 기관정보 상세보기에서 사용자 수 클릭 시 센서 페이지로 이동
	function fnJumpToSensor() {
		document.location.href="/sensor/sensorList.do";
	};
	
	// 기관정보 상세보기에서 사용자 수 클릭 시 센서 페이지로 이동
	function fnJumpToIrrigation() {
		document.location.href="/irrigation/irrigationList.do";
	};
	
	</script>
	
</head>
<body>
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	
	<!-- 기관정보상세 조회 시작 -->
	<div class="sh-main main-reg-type2">
     <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">지역관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">지역관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">지역</span> 
              <span class="depth-menu body-1-bold">지역관리</span>
            </p>
        </div>
      </div>

	<form id="detailForm" name="detailForm" action="/orgInfo/orgInfoList.do" method="post">
	<div class="sh-content-detail">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">지역 정보관리 상세조회</p>
              <p class=""></p>
            </div>
            <div class="res-require-title"></div>

            <!-- table-->
            <div class="wrap-table-detail-agency">
					
					<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>기관ID</th>
									<td class="res-title-td">기관ID</td>
									<td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">기관ID</div></p>
			                            
			                            <div class="regi-dup-area-txt">
											<span id="orgIdDetail"><c:out value="${orgInfoDetail.organizationId}" escapeXml="false" /></span>
											<input type="hidden" id="orgInfoIdMod" name="orgInfoIdMod" value="${orgInfoDetail.organizationId}"/>
										</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>기관명</th>
									<td class="reg-select-td">
				                        <div class="res-reg-td res-detail-agency">
				                          <p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
				                        	<div class="agency-dup-area-txt">  
												<span id="orgNmDetail"><c:out value="${orgInfoDetail.organization}" escapeXml="false" /></span>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>지역명</th>
									<td class="res-title-td">지역명</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">                     
				                          <p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
				                          	<div class="agency-dup-area-txt">
												<span id="localsDetail"><c:out value="${orgInfoDetail.locals}" escapeXml="false" /></span>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>사용자 수</th>
									<td class="res-title-td">사용자 수</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">사용자 수</div></p>
				                            	<div class="agency-dup-area-txt">
													<span id="userCntDetail" onclick="fnJumpToUserMng()"><c:out value="${orgInfoDetail.userCnt}" escapeXml="false" />(명)</span>
												</div>
											</div>
									</td>
								</tr>
								<tr>
									<th>센서 수(사용/보유)</th>
									<td class="res-title-td">센서 수(사용/보유)</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">센서 수(사용/보유)</div></p>
				                            	<div class="agency-dup-area-txt">
													<span id="sensorCntDetail" onclick="fnJumpToSensor()"><c:out value="${orgInfoDetail.sensorCnt}" escapeXml="false" /></span>
												</div>
											</div>
									</td>
								</tr>
								<tr>
									<th>관수 수</th>
									<td class="res-title-td">관수 수</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">관수 수</div></p>
				                            	<div class="agency-dup-area-txt">
													<span id="deviceCntDetail" onclick="fnJumpToIrrigation()"><c:out value="${orgInfoDetail.deviceCnt}" escapeXml="false" /></span>
												</div>
											</div>
									</td>
								</tr>	
								<tr>
									<th>담당자명</th>
									<td class="res-title-td">담당자명</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">담당자명</div></p>
				                            	<div class="agency-dup-area-txt">
													<span id="personInChargeDetail"><c:out value="${orgInfoDetail.personInCharge}" escapeXml="false" /></span>
												</div>
											</div>
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">연락처</div></p>
			                            	<div class="agency-dup-area-txt">
												<span id="telNoDetail"><c:out value="${orgInfoDetail.telNo}" escapeXml="false" /></span>
											</div>
										</div>
									</td>
								</tr>								
								<tr>
									<th>이메일</th>
									<td class="res-title-td">이메일</td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td res-detail-agency">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">이메일</div></p>
				                            	<div class="agency-dup-area-txt">
													<span id="emailDetail"><c:out value="${orgInfoDetail.email}" escapeXml="false" /></span>
												</div>
											</div>
									</td>
								</tr>														
							</tbody>
						</table>												
				            <!--button -->
				            <div class="btn-area-reg-detail">
				              <button class="list-btn-agency-type2" onclick="fnCloseDetailModal()"><a>목록</a></button>
				              <button class="list-btn-agency-type2" onclick="fnShowModModal()"><a>수정</a></button>
				              <button class="cancel-btn-agency-type2" data-toggle="modal" data-target="#delagency" onclick="fnDel()">삭제</button>
				            </div>
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
				    </form>
				</div>
	<!-- 기관정보 상세조회 끝 -->
</body>
</html>