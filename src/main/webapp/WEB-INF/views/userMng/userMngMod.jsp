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
	
	// 관수정보 수정 모달에서 취소 버튼 클릭시
	function fnCloseModModal() {
		document.modForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#modForm").submit();
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
	
	// 사용자관리 수정 모달에서 저장 버튼 클릭시
	function fnMod() {
		var userId = $("#userIdMod").text();
		var userNm = $("#userNmMod").val();			
		var telNo = "010" + $("#telNoMiddleMod").val() + $("#telNoEndMod").val();
		var email = "";
		if(email = $("#emailHeaderMod").val() == "" && $("#emailBodyMod").val() == "") {
			email = "";
		} else {
			email = $("#emailHeaderMod").val() + "@" + $("#emailBodyMod").val(); // 이메일
		}
		var roleLocalIdMod = $("#roleLocalIdMod").val();
		
		if(userNm == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		$.ajax({
		    url: "/userMng/userMngMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	userId : userId,
		    	userNm : userNm,
		    	userLevel : $("#userLevelMod").val(),
		    	telNo : telNo,
		    	email : email,
		    	orgId : $("#orgIdMod").val(),
		    	roleLocalIdMod : $("#roleLocalIdMod").val()
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
				alert("수정완료 하였습니다.");
				//$("#modalMod").attr("style", "display:none"); // 사용자관리 수정조회 모달 닫기
				//location.reload(); // 페이지 새로고침
				document.modForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
	
	// 사용자관리 수정시 기관 콤보박스가 바뀔때마다
	function fnRegistOrgIdChangeMod() {
		$("#roleLocalIdMod").val(""); // 권한지역ID 초기화
		$("#roleLocalMod").val(""); // 권한지역명 초기화
	};
	
	</script>
	
</head>
<body>
<%@ include file="/WEB-INF/views/menu.jsp" %>

	<!-- 사용자정보 수정조회 시작 -->
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
            <div class="title-detail" ><p class="title-detail-txt-user">사용자 관리 수정</p>
            </div>
            <!-- table-->
            <div class="wrap-table-detail-user">
					<form id="modForm" name="modForm" action="/orgInfo/orgInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>사용자ID</th>
									<td>
										<span class="manage-txt-input" id="userIdMod" name="userIdMod"><c:out value="${userMngModDetail.username}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>사용자 레벨</th>
									<td>
										<select class="manage-txt-input" id="userLevelMod" name="userLevelMod">
											<c:forEach var="item" items="${userLevelList}" varStatus="status">
												<option value="${item.role}" <c:if test="${item.role eq userMngModDetail.roleName}">selected</c:if> >${item.roleName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>사용자명<span class="asterisk_input"></span></th>
									<td>
										<input type="text" class="manage-txt-input" id="userNmMod" maxlength="36" onkeyup="fnPressSpecial(event, this)" value="<c:out value="${userMngModDetail.name}" escapeXml="false"/>">
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td>
										010 - 
										<input type="text" class="manage-txt-input-small" id="telNoMiddleMod" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled" value="<c:out value="${userMngModDetail.telNoBody}" escapeXml="false"/>"> - 
										<input type="text" class="manage-txt-input-small" id="telNoEndMod" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled" value="<c:out value="${userMngModDetail.telNoEnd}" escapeXml="false"/>">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<input type="text" class="manage-txt-input-medium" id="emailHeaderMod" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled" value="<c:out value="${userMngModDetail.emailHead}" escapeXml="false"/>">@
										<input type="text" class="manage-txt-input-medium" id="emailBodyMod"  onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled" value="<c:out value="${userMngModDetail.emailBody}" escapeXml="false"/>">
										<select id="emailNmMod" class="manage-txt-input-medium2" name="emailNmMod" onchange="fnEmailModChange()">
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
										<select id="orgIdMod" class="manage-txt-input" name="orgIdMod" onchange="fnRegistOrgIdChangeMod()">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}" <c:if test="${item.organizationId eq userMngModDetail.organizationId}">selected</c:if> >${item.organization}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>권한지역<span class="asterisk_input"></span></th>
									<td>
										<input type="hidden" id="roleLocalIdMod" name="roleLocalIdMod">
										<input type="text" class="manage-txt-input" id="roleLocalMod" name="roleLocalMod" value="<c:out value="${userMngModDetail.locals}" escapeXml="false"/>" disabled>
										<button class="dup-chk-btn-reg" id="localSelectButton" onclick="fnPopLocalSelectMod()">지역선택</button>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
				          <!--button -->
				          <div class="btn-area-user">
				            <button type="button" class="list-btn-user" id="user-reg-btn" onclick="fnMod()">저장</button>
							<button type="button" class="del-btn-user" onclick="fnCloseModModal()">취소</button>
				          </div>
				            
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
					</form>		
					<div class="space-list">
				      <footer class="footer-list">
				          <p class="mb-1"><span class="footer-bold-txt">(주)성하  대표이사: 조정윤</span> | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
				      </footer>
				    </div>			
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- 사용자정보 수정조회 끝 -->

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