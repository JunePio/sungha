<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : userMngDetail.jsp
 * @Description : 사용자관리 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.09  유성우      최초생성
 * @
 */
%>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 관리</title>
  
  	<link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="/static/assets/css/user/list.css">
	<link rel="stylesheet" href="/static/assets/css/user/fonts.css">
	<link rel="stylesheet" href="/static/assets/css/user/style.css">
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
  
	<script src="/static/js/filtering.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<script type="text/javascript">
	
	// 사용자 등록에서 지역선택 버튼 클릭시
	function fnPopLocalSelect() {
		var registOrgId = $("#registOrgId").val(); // 기관ID
		var ret = window.open('roleLocal.do', 'roleLocalSelect', 'width = 500, height = 500, top = 100, left = 200');
		
		var form = document.getElementById("regForm"); // regForm ID 가져오기
		form.action = '<c:url value="/userMng/roleLocal.do"/>'; // url 세팅
		form.target = "roleLocalSelect"; // window.open 함수의 2번째 파라미터와 같아야 하며 필수입력이다.
		form.registOrgId.value = registOrgId; // 파라미터 세팅
		form.method = "post"; // 전송방식 세팅
		form.submit(); // 전송
					
	};
	
	// 사용자 수정에서 지역선택 버튼 클릭시
	function fnPopLocalSelectMod() {
		var orgIdMod = $("#orgIdMod").val(); // 기관ID
		var ret = window.open('roleLocalMod.do', 'roleLocalSelectMod', 'width = 500, height = 500, top = 100, left = 200');
		
		var form = document.getElementById("modForm"); // modForm ID 가져오기
		form.action = '<c:url value="/userMng/roleLocalMod.do"/>'; // url 세팅
		form.target = "roleLocalSelectMod"; // window.open 함수의 2번째 파라미터와 같아야 하며 필수입력이다.
		form.orgIdMod.value = orgIdMod; // 기관ID
		form.roleLocalIdMod.value = $("#roleLocalIdMod").val(); // 권한지역ID
		form.method = "post"; // 전송방식 세팅
		form.submit(); // 전송
					
	};
	
	// 아이디 중복체크
	function fnUserMngDupCheck() {
		var userId = $('#inputUserId').val().trim(); // 아이디 양쪽의 공백을 제거
		if(userId.indexOf(' ') > -1) { // 아이디 중간에 공백이 있는지 체크
			alert('아이디에 공백이 포함되어 있습니다.');
			return false;
		} else if(userId == '') { // 아이디 입력 안할 시
			alert('아이디를 입력해주세요.');
			return false;
		} else if(userId.length < 4 || userId.length > 10) { // 아이디는 4~10자리 까지 허용
			alert("아이디는 영문, 숫자 4~10자리까지 허용입니다.");
			return false;
		}
		
		$.ajax({
		    url: "/userMng/userMngDupCheck.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	userId : userId
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.dupCheckResult == true) { // 서버에서 확인한 결과가 중복된 아이디라면 경고창
				alert("중복된 아이디입니다.");					
			} else {
				alert("사용가능한 아이디 입니다.");
				$("#dupResult").val("dupCheckYes"); // 저장하기 전에 체크하기 위해서 미리 중복체크 정보를 저장해둔다.
				globalUserId = userId;
			}

		    }, 
		    error : function(arg){
			alert("중복확인 실패 하였습니다.");
			
		    }
		})
	};
	
	// 사용자관리 등록시 기관 콤보박스가 바뀔때마다
	function fnRegistOrgIdChange() {
		$("#roleLocalId").val(""); // 권한지역ID 초기화
		$("#roleLocal").val(""); // 권한지역명 초기화
	};
	
	// 취소 버튼 클릭시
	function fnCloseRegModal() {
		document.regForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#regForm").submit();
	};
	
	// 사용자 관리 등록에서 저장버튼 클릭시
	function fnSave(){
		var inputUserId = $("#inputUserId").val(); // 사용자ID
		var inputUserNm = $("#inputUserNm").val(); // 사용자명
		var userLevelRegist = $("#userLevelRegist").val(); // 사용자 레벨
		var registOrgId = $("#registOrgId").val(); // 기관ID
		var telNo = "010" + $("#telNoMiddle").val() + $("#telNoEnd").val(); // 연락처
		var email = "";
		if(email = $("#emailHead").val() == "" && $("#emailBody").val() == "") {
			email = "";
		} else {
			email = $("#emailHead").val() + "@" + $("#emailBody").val(); // 이메일
		}
		var dupResult = $("#dupResult").val();  // 중복체크 여부
		var roleLocalId = $("#roleLocalId").val();  // 권한지역
		
		if(inputUserId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(inputUserNm == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(registOrgId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(dupResult == "dupCheckNo") {  // 저장시 아이디 중복체크를 했는지 다시 체크
			alert("아이디 중복확인을 해주세요.");
			return false;
		} else if(roleLocalId == "") {
			alert("권한지역을 선택해주세요.");
			return false;
		}
		
		$.ajax({
		    url: "/userMng/userMngSave.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	inputUserId : inputUserId,
		    	inputUserNm : inputUserNm,
		    	registOrgId : registOrgId,
		    	userLevelRegist : userLevelRegist,
		    	telNo : telNo,
		    	email : email,
		    	roleLocalId : roleLocalId
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.saveResult) {
				alert("저장완료 하였습니다.");
				document.regForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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

	<!-- 사용자관리 등록 시작 -->
	<div class="sh-main-detail">
      <div class="sh-header">
        <div class="title">
          <p class="title-txt">사용자 관리
            <span class="title-menu"> < 사용자 < 사용자 정보관리</span>
          </p>
        </div>
      </div>

      <div class="sh-content-detail">


          <div class="detail-info-user" >
            <div class="title-detail" ><p class="title-detail-txt-user">사용자 관리 등록<span class="require-txt"><span style="color: green;">*</span> 필수입력</span></p>
            </div>
            <!-- table-->
            <div class="wrap-table-detail-user">
					<form id="regForm" name="regForm" action="/userMng/userMngSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>사용자ID<span class="asterisk_input"></span></th>
									<td>
										<input type="hidden" value="dupCheckNo" id="dupResult">
										<input type="text" class="manage-txt-input" value="" id="inputUserId" name="inputUserId" maxlength="10" onchange="fnUserIdChange()" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
										<button type="button" class="dup-chk-btn-reg" id="dupCheck" onclick="fnUserMngDupCheck()">중복확인</button>
									</td>
								</tr>
								<tr>
									<th>사용자 레벨</th>
									<td>
										<select class="manage-txt-input" id="userLevelRegist" name="userLevelRegist">
											<c:forEach var="item" items="${userLevelList}" varStatus="status">
												<option value="${item.role}">${item.roleName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>사용자명<span class="asterisk_input"></span></th>
									<td>
										<input type="text" class="manage-txt-input" value="" id="inputUserNm" name="inputUserNm" maxlength="50"  onkeyup="fnPressSpecial(event, this)" style="ime-mode:disabled">
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td >
										010 - <input type="text" class="manage-txt-input-small" value="" id="telNoMiddle" name="telNoMiddle" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
										-
										<input type="text" class="manage-txt-input-small" value="" id="telNoEnd" name="telNoEnd" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" class="manage-txt-input-medium" value="" id="emailHead" name="emailHead" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
										@
										<input type="text" class="manage-txt-input-medium" value="" id="emailBody" name="emailBody" onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled">
										<select class="manage-txt-input" id="emailNm" name="emailNm" onchange="fnEmailChange()">
											<option value="selfInput">직접입력</option>
											<option value="naver">naver.com</option>
											<option value="daum">kakao.com</option>
											<option value="google">gmail.com</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>기관<span class="asterisk_input"></span></th>
									<td>
										<select class="manage-txt-input" id="registOrgId" name="registOrgId" onchange="fnRegistOrgIdChange()">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}">${item.organization}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>권한지역</th>
									<td>
										<input type="hidden" id="roleLocalId" value="">
										<input type="text" class="manage-txt-input" value="" id="roleLocal" name="roleLocal" value="" disabled>
										<button class="dup-chk-btn-reg" id="localSelectButton" onclick="fnPopLocalSelect()">지역선택</button>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
				          <!--button -->
				          <div class="btn-area-user">
				            <button type="button" class="list-btn-user" id="user-reg-btn" onclick="fnSave()">저장</button>
							<button type="button" class="del-btn-user" id="modal_close_btn" class="modal-close" onclick="fnCloseRegModal()">취소</button>
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
					</form>					
				</div>
			</div>
		</div>
		<div class="space-list">
         <footer class="footer-list">
            <p class="mb-1"><span class="footer-bold-txt">(주)성하  대표이사: 조정윤</span> | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
         </footer>
        </div>		
	</div>
	<!-- 사용자관리 등록 끝 -->
	
	<!-- <script src="/static/assets/js/main.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 
	
</body>
</html>

<!-- Modal -->
<div class="modal fade" id="deluser" tabindex="-1" role="dialog" aria-labelledby="deluserLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-fix-del" role="document">
    <div class="modal-content modal-content-fix-del">
      <div class="modal-header" style="border-bottom: 0px;">
        <h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
          <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
      </div>
      <div class="msg"></div>
      <div class="modal-body modal-body-content-del">
        선택한 관수를 삭제 하시겠습니까?
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