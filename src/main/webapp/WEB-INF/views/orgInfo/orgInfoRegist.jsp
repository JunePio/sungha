<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
/**
 * @Class Name : sensorRegist.jsp
 * @Description : 센서정보 등록 화면
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
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
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
		
	  function check(obj){
        //정규식으로 특수문자 판별
        var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;
        
        //배열에서 하나씩 값을 비교
        if( regExp.test(obj.value) ){
           //값이 일치하면 문자를 삭제
           obj.value = obj.value.substring( 0 , obj.value.length - 1 ); 
        }
      };
	
		// 취소 버튼 클릭시
		function fnCloseRegModal() {
			document.regForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#regForm").submit();
		};
	
		// 아이디 중복체크
		function fnDupCheck() {
			var orgId = $('#inputOrgId').val().trim(); // 아이디 양쪽의 공백을 제거
			if(orgId.indexOf(' ') > -1) { // 아이디 중간에 공백이 있는지 체크
				alert('아이디에 공백이 포함되어 있습니다.');
				return false;
			} else if(orgId == '') { // 아이디 입력 안할 시
				alert('아이디를 입력해주세요.');
				return false;
			} else if(orgId.length < 4 || orgId.length > 10) { // 아이디는 4~10자리 까지 허용
				alert("아이디는 영문, 숫자 4~10자리까지 허용입니다.");
				return false;
			}
			
			$.ajax({
			    url: "/orgInfo/dupCheck.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	orgId : orgId
			    },
			    //contentType: "application/json",
			    success : function(data) {
				//alert("통신성공시에만 실행");
				if(data.dupCheckResult == true) { // 서버에서 확인한 결과가 중복된 아이디라면 경고창
					alert("중복된 아이디입니다.");					
				} else {
					alert("사용가능한 아이디 입니다.");
					$("#dupResult").val("dupCheckYes"); // 저장하기 전에 체크하기 위해서 미리 중복체크 정보를 저장해둔다.
				}

			    }, 
			    error : function(arg){
				alert("중복확인 실패 하였습니다.");
				
			    }
			})
		};
		
		// 기관ID가 변경되었을 경우 중복확인 다시 체크
		function fnOrgIdChange() {
			$("#dupResult").val("dupCheckNo");
		};
		
		// 기관정보 등록에서 이메일 콤보박스 변경시
		function fnEmailChange() {
			var emailNm = $("#emailNm").val();
			if(emailNm == "naver") { // 네이버 선택시
				$("#emailBody").val("naver.com"); // 네이버 이메일로 자동입력
				$("#emailBody").attr("disabled", true); // 수정못하게 막기
			} else if (emailNm == "daum") { // 다음 선택시
				$("#emailBody").val("kakao.com"); // 카카오 이메일로 자동입력
				$("#emailBody").attr("disabled", true); // 수정못하게 막기
			}  else if (emailNm == "google") { // 구글 선택시
				$("#emailBody").val("gmail.com"); // 지메일로 자동 입력
				$("#emailBody").attr("disabled", true); // 수정못하게 막기
			} else {
				$("#emailBody").attr("disabled", false); // 수정 허용
				$("#emailBody").val(""); // 입력칸을 초기화
				$("#emailBody").focus(); // 커서 깜박이 이동
			}
		};
		
		// 저장버튼 클릭시
		function fnSave(){
			var orgId = $("#inputOrgId").val();
			var orgNm = $("#inputOrgNm").val();
			var personInCharge = $("#inputPersonInCharge").val();
			var telNo = "010" + $("#telNoMiddle").val() + $("#telNoEnd").val();
			var email = $("#emailHead").val() + "@" + $("#emailBody").val();
			var dupResult = $("#dupResult").val(); 
			if(orgId == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(orgNm == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(personInCharge == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(dupResult == "dupCheckNo") {  // 저장시 아이디 중복체크를 했는지 다시 체크
				alert("아이디 중복확인을 해주세요.");
				return false;
			} else if(email.length > 50) {
				alert("이메일 길이는 총 50byte를 넘지 못합니다.");
				return false;
			}
			
			$.ajax({
			    url: "/orgInfo/orgInfoSave.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	orgId : orgId,
			    	orgNm : orgNm,
			    	personInCharge : personInCharge,
			    	telNo : telNo,
			    	email : email
			    },
			    //contentType: "application/json",
			    success : function(data) {
				//alert("통신성공시에만 실행");
				if(data.saveResult) {
					alert("저장완료 하였습니다.");
					document.regForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
		
	</script>

</head>
<body>

	<%@ include file="/WEB-INF/views/menu.jsp" %>

	<!-- 기관정보 등록 시작 -->
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

      <div class="sh-content-detail">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">기관 정보관리 등록</p>
              <p class="require-p"><span class="required">*</span>필수입력</p>
            </div>
            <div class="res-require-title"><span class="required">*</span>필수입력</div>
            <!-- table-->
           		<div class="wrap-table-detail-agency">
					<form id="regForm" name="regForm" action="/orgInfo/orgInfoSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>기관ID<span class="required">*</span></th>
									<td class="res-title-td">기관ID<span class="required">*</span></td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">기관ID<span class="required">*</span></div></p>
				                            	<div class="agency-dup-area">
													<input type="hidden" value="dupCheckNo" id="dupResult">
													<input type="text" value="" class="input-reg-irr input-dup" placeholder="" id="inputOrgId" name="inputOrgId" maxlength="36" onchange="fnOrgIdChange()" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
													<button type="button" class="reg-btn-irr-loc" id="dupCheck" onclick="fnDupCheck()">중복확인</button>
												</div>
										  </div>
										</td>
								</tr>
								<tr>
									<th>기관명<span class="required">*</span></th> 
									<td class="reg-select-td">
				                        <div class="res-reg-td">
				                          <p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
											<input type="text" class="input-reg-irr input-dup" value="" id="inputOrgNm" name="inputOrgNm" maxlength="50" onkeyup="fnPressOrgNm(event, this)">
										</div>
									</td>
								</tr>
								<tr>
									<th>담당자명<span class="required">*</span></th> 
				                        <td class="res-title-td">담당자명<span class="required">*</span></td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">담당자명<span class="required">*</span></div></p>
												<input type="text" class="input-reg-irr input-dup" value="" id="inputPersonInCharge" name="inputPersonInCharge" maxlength="36" onkeyup="fnPressSpecial(event, this)">
											</div>
										</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td class="res-title-td">연락처<span class="required">*</span></td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">연락처<span class="required">*</span></div></p>
				                            	<div class="phone-area">
													010-
													<input type="text" value="" class="manage-txt-input-small input-phone" id="telNoMiddle" name="telNoMiddle" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
													-
													<input type="text" value="" class="manage-txt-input-small input-phone" id="telNoEnd" name="telNoEnd" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
												</div>
										  </div>
										</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td class="res-title-td">이메일<span class="required">*</span></td>
				                        <td class="reg-input1">
				                          <div class="res-reg-td">
				                            <p class="pc-title-td body-3-bold"><div class="div-require">이메일<span class="required">*</span></div></p>
				                            <div class="email-area">
												<input type="text" class="manage-txt-input-medium email-input res-email-input1" value="" id="emailHead" name="emailHead" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
												@
												<input type="text" class="manage-txt-input-medium email-input res-email-sel" value="" id="emailBody" name="emailBody" onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled">
												<select class=" reg-select  email-sel" id="emailNm" name="emailNm" onchange="fnEmailChange()">
													<option value="selfInput">직접입력</option>
													<option value="naver">naver.com</option>
													<option value="daum">kakao.com</option>
													<option value="google">gmail.com</option>
												</select>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
						<div class="btn-area-reg">
							<button class="list-btn agency-btn-loc" id="user-reg-btn" onclick="fnSave()"><a>저장</a></button>
							<button class="cancel-btn agency-btn-loc-c" id="modal_close_btn" onclick="fnCloseRegModal()">취소</button>
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
	<!-- 기관정보 등록 끝 -->
	
</body>
</html>

<!-- Modal -->
<div class="modal fade" id="delagency" tabindex="-1" role="dialog" aria-labelledby="delagencyLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-fix-del" role="document">
    <div class="modal-content modal-content-fix-del">
      <div class="modal-header" style="border-bottom: 0px;">
        <h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
          <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
      </div>
      <div class="msg"></div>
      <div class="modal-body modal-body-content-del">
        선택한 기관를 삭제 하시겠습니까?
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