<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
/**
 * @Class Name : sensorMod.jsp
 * @Description : 센서정보 수정 조회 화면
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
    <title>기관 관리</title>

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
	
	// 센서정보 수정 모달에서 취소 버튼 클릭시
	function fnCloseModModal() {
		document.modForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#modForm").submit();
	};
	
	// 기관정보 수정 모달에서 저장 버튼 클릭시
	function fnMod() {
		
		var orgNm = $("#orgNmMod").val();
		var personInCharge = $("#personInChargeMod").val();
		var telNo = "010" + $("#telNoMiddleMod").val() + $("#telNoEndMod").val();
		var email = $("#emailHeaderMod").val() + "@" + $("#emailBodyMod").val();
		var dupResult = $("#dupResult").val();
		
		
		if(orgNm == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(personInCharge == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(email.length > 50) {
			alert("이메일 길이는 총 50byte를 넘지 못합니다.");
			return false;
		}
		
		$.ajax({
		    url: "/orgInfo/orgInfoMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	orgId : $("#orgIdMod").text(),
		    	orgNm : $("#orgNmMod").val(),
		    	
		    	personInCharge : $("#personInChargeMod").val(),
		    	telNo : telNo,
		    	email : email
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
				alert("수정완료 하였습니다.");
				document.modForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			    $("#modForm").submit();
				
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
	
	// 기관정보 수정에서 이메일 콤보박스 변경시
	function fnEmailModChange() {
		var emailNm = $("#emailNmMod").val();
		if(emailNm == "naver") { // 네이버 선택시
			$("#emailBodyMod").val("naver.com"); // 네이버 이메일로 변경
			$("#emailBodyMod").attr("disabled", true); // 수정 못하게 막기
		} else if (emailNm == "daum") { // 다음 선택시
			$("#emailBodyMod").val("kakao.com"); // 카카오 이메일로 변경
			$("#emailBodyMod").attr("disabled", true); // 수정 못하게 막기
		}  else if (emailNm == "google") { // 구글 선택시
			$("#emailBodyMod").val("gmail.com"); // 지메일로 변경
			$("#emailBodyMod").attr("disabled", true); // 수정 못하게 막기
		} else {
			$("#emailBodyMod").attr("disabled", false); // 수정 허용
			$("#emailBodyMod").val(""); // 값 초기화
			$("#emailBodyMod").focus(); // 입력 커서 이동
		}
	};
	
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/menu.jsp" %>

	<!-- 기관정보 수정조회 -->
	<div class="sh-main main-reg-type2">
     <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">기관관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">기관관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">기관</span> 
              <span class="depth-menu body-1-bold">기관관리</span>
            </p>
        </div>
      </div>

      <div class="sh-content-detail sh-content-detail-modify">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">기관 정보관리 수정</p>
            </div>
            <!-- table-->
            <div class="wrap-table-detail-agency">
					<form id="modForm" name="modForm" action="/orgInfo/orgInfoList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>기관ID</th>
									<td class="res-title-td">기관ID</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">기관ID</div></p>
			                            	<div class="agency-dup-area">
												<span id="orgIdMod">&nbsp;<c:out value="${orgInfoModDetail.organizationId}" escapeXml="false" /></span>
											</div>
									  </div>
									</td>
								</tr>
								<tr>
									<th>기관명(*)</th>
									<td class="reg-select-td">
				                        <div class="res-reg-td">
				                          <p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
				                          	<div class="agency-dup-area">
												<input type="text" id="orgNmMod" maxlength="50" class="input-reg-irr input-dup" onkeyup="fnPressOrgNm(event, this)"  value="${orgInfoModDetail.organization}">
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>담당자(*)</th>
									<td class="res-title-td">담당자명</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">담당자명</div></p>
											<input type="text" id="personInChargeMod" maxlength="36" class="input-reg-irr input-dup" onkeyup="fnPressSpecial(event, this)"  value="${orgInfoModDetail.personInCharge}">
									  </div>
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td class="res-title-td">연락처</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">연락처</div></p>
											010 - 
											<input type="text" id="telNoMiddleMod" maxlength="4" class="manage-txt-input-small input-phone" onkeyup="fnPress(event, this)" style="ime-mode:disabled" value="${orgInfoModDetail.telNoMiddle}"> - 
											<input type="text" id="telNoEndMod" maxlength="4" class="manage-txt-input-small input-phone" onkeyup="fnPress(event, this)" style="ime-mode:disabled" value="${orgInfoModDetail.telNoEnd}">
									  </div>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td class="res-title-td">이메일</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">이메일</div></p>
			                            <div class="email-area">
											<input type="text" id="emailHeaderMod" class="manage-txt-input-medium email-input res-email-input1" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled" value="${orgInfoModDetail.emailHead}">@
											<input type="text" id="emailBodyMod" class="manage-txt-input-medium email-input res-email-sel" onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled" value="${orgInfoModDetail.emailBody}" 
											  <c:if test="${(orgInfoModDetail.emailBody eq 'naver.com') or (orgInfoModDetail.emailBody eq 'kakao.com') or (orgInfoModDetail.emailBody eq 'gmail.com')}">disabled</c:if>>
											<select id="emailNmMod" name="emailNmMod" class=" reg-select  email-sel" onchange="fnEmailModChange()">
												<option value="selfInput">직접입력</option>
												<option value="naver" <c:if test="${orgInfoModDetail.emailBody eq 'naver.com'}">selected</c:if> >naver.com</option>
												<option value="daum" <c:if test="${orgInfoModDetail.emailBody eq 'kakao.com'}">selected</c:if> >kakao.com</option>
												<option value="google" <c:if test="${orgInfoModDetail.emailBody eq 'gmail.com'}">selected</c:if> >gmail.com</option>
											</select>
										</div>
									  </div>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
			            <!--button -->
			            <div class="btn-area-reg">
			              <button class="list-btn agency-btn-loc" onclick="fnMod()"><a>수정</a></button>
			              <button class="cancel-btn agency-btn-loc-c" onclick="fnCloseModModal()">취소</button>
			            </div>
			            
			          </div>	
				        <input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
						<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
						<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
						<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
						<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
						<input type="hidden" id="sortType" name="sortType" value="${sortType}">
						<input type="hidden" id="page" name="page" value="${page}">
						<input type="hidden" id="range" name="range" value="${range}">
						<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">					
					</form>
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
			</div>
		</div>
	</div>
	<!-- 기관정보 수정조회 -->

	<!-- <script src="/static/assets/js/main.js"></script> -->      
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 

</body>
</html>