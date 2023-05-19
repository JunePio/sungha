<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : userMngList.jsp
 * @Description : 사용자관리 리스트 조회 화면
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
    <title>사용자 정보관리</title>
    
    <link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet" href="/static/assets/css/user/list.css">
	<link rel="stylesheet" href="/static/assets/css/user/fonts.css">
	<link rel="stylesheet" href="/static/assets/css/user/style.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
    
	<script src="/static/js/filtering.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<style>
        #modalRegist {
          display:none;
		  position:fixed;
		  top:25%;
		  left:25%;
		  z-index:1;		 		  
		}
		
		#modalRegist h2 {
		  margin:0;   
		}
		
		#modalRegist button {
		  display:inline-block;
		  width:100px;
		  margin-left:calc(100% - 100px - 10px);
		}
		
		#modalRegist .modal-content {
		  width:600px;
		  margin:100px auto;
		  padding:20px 10px;
		  background:#fff;
		  border:2px solid #666;
		}
		
		#modalRegist .modal-layer {
		  position:fixed;
		  top:0;
		  left:0;
		  width:100%;
		  height:100%;
		  background:rgba(0, 0, 0, 0.5);
		  z-index:-1;
		}   
		
		#modalDetail {
          display:none;
		  position:fixed;
		  top:25%;
		  left:25%;
		  z-index:1;		 		  
		}
		
		#modalDetail h2 {
		  margin:0;   
		}
		
		#modalDetail button {
		  display:inline-block;
		  width:100px;
		  margin-left:calc(100% - 100px - 10px);
		}
		
		#modalDetail .modal-content {
		  width:600px;
		  margin:100px auto;
		  padding:20px 10px;
		  background:#fff;
		  border:2px solid #666;
		}
		
		#modalDetail .modal-layer {
		  position:fixed;
		  top:0;
		  left:0;
		  width:100%;
		  height:100%;
		  background:rgba(0, 0, 0, 0.5);
		  z-index:-1;
		}    
		
		#modalMod {
          display:none;
		  position:fixed;
		  top:25%;
		  left:25%;
		  z-index:1;		 		  
		}
		
		#modalMod h2 {
		  margin:0;   
		}
		
		#modalMod button {
		  display:inline-block;
		  width:100px;
		  margin-left:calc(100% - 100px - 10px);
		}
		
		#modalMod .modal-content {
		  width:900px;
		  margin:100px auto;
		  padding:20px 10px;
		  background:#fff;
		  border:2px solid #666;
		}
		
		#modalMod .modal-layer {
		  position:fixed;
		  top:0;
		  left:0;
		  width:100%;
		  height:100%;
		  background:rgba(0, 0, 0, 0.5);
		  z-index:-1;
		}
		
		th, td {
			text-align: center;
		}
    </style>
	<script type="text/javascript">
		
		var globalUserId = "";
		var globalUserCnt = "";
		var globalDeviceCnt = "";
		var globalValvCnt = "";
	
		/*
		$(document).ready(function() {
			
			
			
		});
		*/
		
		$(document).keydown(function(e){
			//keyCode 구 브라우저, which 현재 브라우저
		    var code = e.keyCode || e.which;
		 
		    if (code == 27) { // 27은 ESC 키번호
		    	fnCloseRegModal();    	
		    	$("#modalDetail").attr("style", "display:none"); // 사용자관리 상세조회 모달 닫기
		    	$("#modalMod").attr("style", "display:none"); // 사용자관리 수정 모달 팝업
		    }
		});
		
		
		// 등록버튼 클릭시
		function fnShowRegModal() {
			//$("#modalRegist").attr("style", "display:block"); // 사용자관리 등록 모달 팝업
			
			document.searchForm.action = '<c:url value="/userMng/userMngRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
			
		};
	   
		// 사용자관리 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
			$("#inputUserId").val(""); // 지역명 초기화
			$("#userLevelRegist option:eq(0)").prop("selected", true);
			$("#inputUserNm").val(""); // 지역명 초기화
			$("#telNoMiddle").val(""); // 지역주소 메인 초기화
			$("#telNoEnd").val(""); // 지역주소 서브 초기화
			$("#emailHead").val(""); // X좌표 초기화
			$("#emailBody").val(""); // Y좌표 초기화
			$("#emailBody").attr("disabled", false); // 이메일 초기화
			$("#emailNm option:eq(0)").prop("selected", true); // 콤보박스 첫번째 항목 선택
			$("#registOrgId option:eq(0)").prop("selected", true);
			$("#roleLocalId").val(""); // X좌표 초기화
			$("#roleLocal").val(""); // Y좌표 초기화
			
			$("#modalRegist").attr("style", "display:none"); // 사용자관리 등록 모달 닫기
		};
		
		// 게시판 헤더 클릭시 정렬
		function fnHeaderClick(column) {
			if($("#sortType").val() == "desc") { // 정렬방식이 내림차순일 경우
		    	$("#sortType").val("asc"); // 정렬방식을 오름차순으로 변경
		    } else {
		    	$("#sortType").val("desc"); // 정렬방식을 내림차순으로 변경
		    }
		    $("#sortColumn").val(column); // 컬럼 정보 저장
		    $("#searchForm").submit(); // 서버로 전송
			
		};
	
		// 사용자관리 검색
		function fnDetailSearch(pageNo){
			$("#page").val("1");
			$("#range").val("1");
			$("#rangeSize").val("10");
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url
			document.searchForm.submit(); // 서버로 전송
			
		};
				
		// 기관명 콤보박스 변경시
		function fnOrgNmChange(e){
			$.ajax({
			    url: "/orgInfo/localNmList.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	searchingOrgId : $("#searchingOrgId").val(), // 콤보박스에서 선택된 항목의 기관ID
			    	searchingLocalId : $("#searchingLocalId").val() // 컴보박스에서 선택된 항목의 지역ID
			    },
			    //contentType: "application/json",
			    success : function(data) {
					//alert("통신성공시에만 실행");
					$("#searchingLocalId").empty(); // 기존에 있던 항목은 지우고
					$("#searchingLocalId").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
					for(var i = 0; i < data.listSize ; i++) {
						$("#searchingLocalId").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
					}

			    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
				
			    }
			})
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
		
		// 사용자관리 등록에서 이메일 콤보박스 변경시
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
					location.reload(); // 페이지 새로고침
					
				} else {
					alert("저장실패 하였습니다.");
				}

			    }, 
			    error : function(arg){
				alert("저장 실패");
				
			    }
			});

		};
		
		// 사용자관리 리스트에서 row 클릭시
		function fnShowDetailModal(userId) {
			/*
			$.ajax({
			    url: "/userMng/userMngDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	userId : userId
			    },
			    //contentType: "application/json",
			    success : function(data) {
				    
			    	$("#modalDetail").attr("style", "display:block"); // 사용자관리 상세조회 모달 팝업
			    	
			    	// 각 항목 초기화
		    	 	$("#userIdDetail").text("");
				    $("#userLevelDetail").text("");
				    $("#userNmDetail").text("");
				    $("#telNoDetail").text("");
				    $("#orgNmDetail").text("");
				    $("#emailDetail").text("");
				    $("#roleLocalDetail").text("");
				    
				    // 위에서 초기화한 이후 값을 넣어준다.
				    $("#userIdDetail").text(onGetUnescapeXSS(data.userMngDetail.username));
				    $("#userLevelDetail").text(onGetUnescapeXSS(data.userMngDetail.roleName));
				    $("#userNmDetail").text(onGetUnescapeXSS(data.userMngDetail.name));
				    var telNo = "";
				    if(data.userMngDetail.telNo != null)
				    	telNo = data.userMngDetail.telNo.substr(0,3) + " - " + data.userMngDetail.telNo.substr(3,4) + " - " + data.userMngDetail.telNo.substr(7,4);
				    $("#telNoDetail").text(onGetUnescapeXSS(telNo));
				    $("#orgNmDetail").text(onGetUnescapeXSS(data.userMngDetail.organization));
				    var email = "";
				    if(data.userMngDetail.email != null)
				    	email = data.userMngDetail.email;
				    $("#emailDetail").text(onGetUnescapeXSS(email));
				    var locals = "";
				    if(data.userMngDetail.locals != null)
				    	locals = data.userMngDetail.locals;
				    $("#roleLocalDetail").text(onGetUnescapeXSS(locals));
				    
			    }, 
			    error : function(arg){
				alert("사용자관리 상세조회 실패");
				
			    }
			});
			*/
			
			$("#userIdParam").val(userId);
			
			document.searchForm.action = '<c:url value="/userMng/userMngDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
		};
		
		// 사용자관리 상세조회 모달에서 취소 버튼 클릭시
		function fnCloseDetailModal() {
			$("#modalDetail").attr("style", "display:none"); // 사용자관리 상세조회 모달 닫기
		};
		
		// 사용자관리 상세조회에서 수정 버튼 클릭시
		function fnShowModModal() {
			
			$.ajax({
			    url: "/userMng/userMngModDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	userId : $("#userIdDetail").text()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    
			   		$("#modalDetail").attr("style", "display:none"); // 사용자관리 상세조회 모달 닫기
			   		$("#modalMod").attr("style", "display:block"); // 사용자관리 수정조회 모달 팝업
			   		
			   		// 값을 초기화 해준다.
			   		$("#userIdMod").text("");
			   		$("#userLevelMod").val("");
			   		$("#userNmMod").val("");
			   		$("#telNoMiddleMod").val("");
				    $("#telNoEndMod").val("");
				    $("#emailHeaderMod").val("");
				    $("#emailBodyMod").val("");
				    //$("#orgIdMod").val(""); // 이 부분 일부러 초기화 안해준 겁니다. 수정 말아주세요.
				    $("#roleLocalMod").val("");
				    $("#roleLocalIdMod").val("");
				    
				    // 위에서 초기화후 값을 넣어준다.
				    $("#userIdMod").text(onGetUnescapeXSS(data.userMngModDetail.username));
				    $("#userLevelMod").val(onGetUnescapeXSS(data.userMngModDetail.role));
				    $("#userNmMod").val(onGetUnescapeXSS(data.userMngModDetail.name));
				    var telNoMiddle = "";
				    var telNoEnd = "";
				    if(data.userMngModDetail.telNo != null) {
				    	telNoMiddle = data.userMngModDetail.telNo.substr(3,4);
				    	telNoEnd = data.userMngModDetail.telNo.substr(7,4);
				    }
				    $("#telNoMiddleMod").val(onGetUnescapeXSS(telNoMiddle));
				    $("#telNoEndMod").val(onGetUnescapeXSS(telNoEnd));
				    var emailHeader = "";
				    var emailBody = "";
				    if(data.userMngModDetail.email != null) {
				    	var temp = data.userMngModDetail.email.split("@");
				    	emailHeader = temp[0];
				    	emailBody = temp[1];
				    }
				    $("#emailHeaderMod").val(onGetUnescapeXSS(emailHeader));
				    $("#emailBodyMod").val(onGetUnescapeXSS(emailBody));
				    $("#orgIdMod").val(onGetUnescapeXSS(data.userMngModDetail.organizationId));
				    $("#roleLocalMod").val(onGetUnescapeXSS(data.userMngModDetail.locals));
				    $("#roleLocalIdMod").val(onGetUnescapeXSS(data.userMngModDetail.localIds));
			    }, 
			    error : function(arg){
				alert("사용자관리 수정조회 실패");
				
			    }
			});
			
		};
		
		// 사용자관리 수정에서 이메일 콤보박스 변경시
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
			} else if(roleLocalIdMod == "") {
				alert("권한지역을 선택해주세요.");
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
					$("#modalMod").attr("style", "display:none"); // 사용자관리 수정조회 모달 닫기
					location.reload(); // 페이지 새로고침
					
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
		
		// 비밀번호 수정 체크박스 변경시
		function fnCheckBoxChange() {
			
			if($("passwordCheckBox").is(":checked")) { // 체크되었다면
				$("#passwordMod").attr("disabled", false); // 비밀번호 입력 못하게 막기
				$("#passwordConfirmMod").attr("disabled", false); // 비밀번호 확인 입력 못하게 막기
			} else {
				$("#passwordMod").attr("disabled", true); // 비밀번호 입력하게 허용
				$("#passwordConfirmMod").attr("disabled", true); // 비밀번호 확인 입력 하게 허용
			}
			
		};
		
		// 사용자관리 수정 모달에서 취소 버튼 클릭시
		function fnCloseModModal() {
			$("#modalMod").attr("style", "display:none"); // 사용자관리 수정 모달 닫기
		};
		
		// 사용자관리 상세 모달에서 삭제 버튼 클릭시
		function fnDel() {
			
			if(confirm("선택한 사용자를 삭제 하시겠습니까?")) { // '예'를 선택한 경우
				$.ajax({
				    url: "/userMng/userMngDel.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	userId : $("#userIdDetail").text()
				    },
				    //contentType: "application/json",
				    success : function(data) {
				    	if(data.delResult) {
				    		alert("삭제완료 하였습니다.")
					    	fnCloseDetailModal(); // 사용자관리 상세 모달 닫기
					    	location.reload(); // 페이지 새로고침	
				    	} else {
				    		alert("삭제실패 하였습니다.")
				    	}
				    	
				    }, 
				    error : function(arg){
					alert("사용자 삭제 실패");
					
				    }
				});
			}
			
			
			
		};
		
		// 승인 관련 버튼 클릭시
		function fnConfirmButtonChange(hiddenId, username, buttonId, confirmDate, cancelDate) {
			var confirmStateMod = "";
			
			if($('#'+hiddenId).val() == "complete") { // 히든객체에 담긴 승인여부 정보가 cancel일 경우
				$('#'+hiddenId).val("cancel"); // 승인취소를 의미하는 cancel로 수정
				confirmStateMod = "cancel"; // DB에는 cancel로 수정
			} else { // 그 이외의 경우
				$('#'+hiddenId).val("complete"); // 승인완료를 의미하는 complete로 수정
				confirmStateMod = "complete"; // DB에는 complete로 수정
			}
			
			
			$.ajax({
			    url: "/userMng/userMngConfirm.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	userId : username,
			    	confirmStateMod : confirmStateMod
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	if(data.confirmResult == false) {
			    		alert("승인변경 실패했습니다.");
			    		return false;
			    	}
			    	
			    	if($('#'+hiddenId).val() == "cancel") { // 히든객체에 담긴 승인여부 정보가 cancel일 경우
			    		
			    		$('#'+hiddenId).val("cancel"); // 승인이 변경되었으니 히든객체에 담긴 승인 여부 정보도 변경
						$('#'+hiddenId+'Span').text("승인 취소"); // 승인여부를 취소로 바꾼다.
						$('#'+cancelDate).text(data.cancelDate); // 취소일을 입력한다.
						$('#'+buttonId).css('display','none');  // 버튼은 보이지 않게 한다.
						alert("승인변경(승인완료 -> 승인취소) 하였습니다.");
					} else if($('#'+hiddenId).val() == "complete") { // 히든객체에 담긴 승인여부 정보가 complete일 경우
						
						$('#'+hiddenId).val("complete"); // 승인이 변경되었으니 해든객체에 담긴 승인 여부 정보도 변경
						$('#'+hiddenId+'Span').text("승인 완료"); // 승인여부를 완료로 바꾼다.
						$('#'+confirmDate).text(data.confirmDate); // 승인일을 입력한다.
						$('#'+buttonId).val("승인 취소"); // 버튼 이름을 취소로 바꾼다.
						alert("승인변경(미승인 -> 승인완료  하였습니다.");
					} else { // 그 이외의 경우
						
						$('#'+hiddenId).val("complete"); // 승인이 변경되었으니 히든객체에 담긴 승인 여부 정보도 변경
						$('#'+hiddenId+'Span').text("승인 완료"); // 승인여부를 완료로 바꾼다.
						
						$('#'+buttonId).val("승인 취소"); // 버튼 이름을 완료로 바꾼다.
					}
			    	
			    }, 
			    error : function(arg){
				alert("승인 변경 실패");
				
			    }
			});	
			
			
			
		};
		
		// 사용자관리 등록시 기관 콤보박스가 바뀔때마다
		function fnRegistOrgIdChange() {
			$("#roleLocalId").val(""); // 권한지역ID 초기화
			$("#roleLocal").val(""); // 권한지역명 초기화
		};
		
		// 사용자관리 수정시 기관 콤보박스가 바뀔때마다
		function fnRegistOrgIdChangeMod() {
			$("#roleLocalIdMod").val(""); // 권한지역ID 초기화
			$("#roleLocalMod").val(""); // 권한지역명 초기화
		};
		
		function fnPasswordReset() {
			if(confirm("비밀번호 초기화 하겠습니까?")) { // "예"를 선택한 경우
				
				var username = $("#userIdMod").text();
				
				$.ajax({
				    url: "/userMng/userMngPasswordChange.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	userId : username
				    },
				    //contentType: "application/json",
				    success : function(data) {
				    	if(data.changeResult) {
				    		alert("비밀번호 초기화 완료하였습니다.");
				    		location.reload(); // 페이지 새로고침	
				    	} else {
				    		alert("비밀번호 초기화 실패하였습니다.");
				    		return false;
				    	}
				    	
				    }, 
				    error : function(arg){
					alert("비밀번호 변경 실패");
					
				    }
				});	
							
			}
		};
		
		// DB에 있는 데이터를 다시 태그로 변환
		function onGetUnescapeXSS(inputText) {
		    var plainText = inputText;
		    if (plainText != '') {
		        var source = ["&amp;","&lt;","&gt;","&quot;","&#39;","&#47;","&#40;","&#41;","&#37;","&#45;"];
		        var target = ["&", "<", ">", "\"", "'", "/", "(", ")", "%", "-"];

		        for(var  i = 0; i < source.length; i++) {
		            if(plainText.indexOf(source[i]) > -1) {
		                plainText = plainText.replaceAll(source[i], target[i]);
		            }
		        }
		    }
		    return plainText;
		};
		
		// 한글 및 특수문자 입력 제한
		function fnPressHanSpecial(event, obj) {
			if(event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {
				alert("영문, 숫자만 입력 가능합니다.");
				return false;
			}
			obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
		};
		
		// 특수문자 입력 제한
		function fnPressSpecial(event, obj) {
			if(event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {
				alert("한글, 영문, 숫자만 입력 가능합니다.");
				return false;
			}
			obj.value = obj.value.replaceAll(/[\{\}\[\]\/?.,;:|\*~`!^\-_+┼<>@\#$%&\'\"\\\\=]/g, '');
		};
		
		// 숫자만 입력받기
		function fnPress(event, obj) {
			if(event.keyCode < 48 || event.keyCode > 57) {
				obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|a-z|A-Z|\{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
				alert("숫자만 입력가능합니다.");			
				return false;
			}
			
		};
		
		// 이메일 입력 제한 .는 허용
		function fnPressEmail(event, obj) {
			if(event.keyCode == 9 || event.keyCode == 37 || event.keyCode == 39 || event.keyCode == 46) {
				alert("영문, 숫자만 입력 가능합니다.");
				return false;
			}
			obj.value = obj.value.replaceAll(/[\ㄱ-하-ㅣ가-힣|\{\}\[\]\/?,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/g, '');
		};
		
		// 기관ID가 변경되었을 경우 중복확인 다시 체크
		function fnUserIdChange() {
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
				
		// 엑셀 다운로드 버튼 클릭시
		function fnUserMngExcelDown(form) {
			form.action = '<c:url value="/userMng/excel.do"/>';
			form.submit();
		};
		
		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>';
			document.searchForm.submit();
		}
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>';
			document.searchForm.submit();
		}
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>';
			document.searchForm.submit();
		}
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/userMng/userMngList.do"/>';
			document.searchForm.submit();
		}
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/menu.jsp" %>

 <div class="sh-main">
      <div class="sh-header">
        <div class="title">
          <p class="title-txt">사용자정보 관리
            <span class="title-menu"> < 사용자 < 사용자정보 관리</span>
          </p>
        </div>
      </div>
	<form id="searchForm" name="searchForm" action="/userMng/userMngList.do" method="post">
      <div class="sh-content">
          <div class="condition-search">
            <p class="list-box">

			<span class="srch-txt ml20" >기관명</span>
			<select class="select-srch" id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)">
				<option value="total">전체</option>
				<c:choose>
				<c:when test="${'total' eq searchingOrgId}">
					<c:forEach var="item" items="${orgNmList}" varStatus="status">
						<option value="${item.organizationId}" <c:if test="${item.organizationId eq searchingOrgId}">selected</c:if> >${item.organization}</option>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${orgNmList}" varStatus="status">
						<option value="${item.organizationId}" <c:if test="${item.organizationId eq searchingOrgId}">selected</c:if> >${item.organization}</option>
					</c:forEach>
				</c:otherwise>
				</c:choose>
			</select>
			<span class="srch-txt ml20">지역명</span>
			<select class="select-srch" id="searchingLocalId" name="searchingLocalId">
				<option value="total" selected>전체</option>
				<c:choose>
				<c:when test="${'total' eq searchingLocalId}">
					<c:forEach var="item" items="${localNmList}" varStatus="status">
						<option value="${item.localId}" <c:if test="${item.localId eq searchingLocalId}">selected</c:if> >${item.local}</option>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="item" items="${localNmList}" varStatus="status">
						<option value="${item.localId}" <c:if test="${item.localId eq searchingLocalId}">selected</c:if> >${item.local}</option>
					</c:forEach>
				</c:otherwise>
				</c:choose>
			</select>
			<span class="srch-txt ml360 mt10" >사용자</span>
			<select class="select-srch" id="searchingType" name="searchingType">
				<option value="name" <c:if test="${searchingType eq 'name'}">selected</c:if> >사용자 이름</option>
				<option value="username" <c:if test="${searchingType eq 'username'}">selected</c:if> >사용자 ID</option>
				<option value="role" <c:if test="${searchingType eq 'role'}">selected</c:if> >사용자 레벨</option>
			</select>
			<input type="text" name="searchingContent" value="${searchingContent}"/>
			<button class="srch-btn" id="search" onclick="javascript:fnDetailSearch(1)">검색</button>			
	</p>
    </div>
    <div class="main-content" headline="Stats">
		<button class="excel-btn" onclick="fnUserMngExcelDown(this.form)">엑셀다운로드</button>
	
	<!-- table -->
    <div class="wrap-table">
        <div class="table100 ver1">
        
        <div class="wrap-table100-nextcols js-pscroll">
        <div class="table100-nextcols">
                
	<table>
	<thead>
		<tr class="row100 head">
			<th class="cell100 column1" onclick="fnHeaderClick(1)">번호</th>
			<th class="cell100 column2" onclick="fnHeaderClick(2)">사용자ID</th>
			<th class="cell100 column3" onclick="fnHeaderClick(3)">사용자이름</th>
			<th class="cell100 column4" onclick="fnHeaderClick(4)">사용자레벨</th>
			<th class="cell100 column5" onclick="fnHeaderClick(5)">연락처</th>
			<th class="cell100 column6" onclick="fnHeaderClick(6)">이메일</th>
			<th class="cell100 column7" onclick="fnHeaderClick(7)">기관명</th>
			<th class="cell100 column8" onclick="fnHeaderClick(8)">권한지역</th>
			<th class="cell100 column9" onclick="fnHeaderClick(9)">등록일(수정일)</th>
			<th class="cell100 column10" onclick="fnHeaderClick(10)">승인일 (취소일)</th>
			<th colspan="2" class="cell100 column11" onclick="fnHeaderClick(11)">승인여부</th>
		</tr>
	</thead>
	<c:choose>
	<c:when test="${empty userMngList}">
		<tbody id="tbody">
			<tr>
				<th colspan="11">
					조회된 결과가 없습니다.
				</th>
			</tr>
		</tbody>
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${userMngList}" varStatus="status">
		<tbody id="tbody">
			<tr <c:if test="${status.count%2 ne 0}">class="row100 body odd"</c:if> <c:if test="${status.count%2 eq 0}">class="row100 body even"</c:if>>
				<td class="cell100 column1" id="rownum" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.rownum}" escapeXml="false" /></td>
				<td class="cell100 column2" id="username" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.username}" escapeXml="false" /></td>
				<td class="cell100 column3" id="name" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.name}" escapeXml="false" /></td>
				<td class="cell100 column4" id="roleName" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.roleName}" escapeXml="false" /></td>
				<td class="cell100 column5" id="telNo" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.telNo}" escapeXml="false" /></td>
				<td class="cell100 column6" id="email" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.email}" escapeXml="false" /></td>
				<td class="cell100 column7" id="organization" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.organization}" escapeXml="false" /></td>
				<td class="cell100 column8" id="locals" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.locals}" escapeXml="false" /></td>
				<td class="cell100 column9" id="regDate" onclick="fnShowDetailModal('${item.username}')"><c:out value="${item.regDate}" escapeXml="false" /></td>
				<td class="cell100 column10" id="confirmDate" onclick="fnShowDetailModal('${item.username}')"><span id="confirmDate${status.count}">${item.confirmDate}</span><c:if test="${not empty item.cancelDate or item.cancelDate ne ''}"><span id="confirmDate2${status.count}">${item.cancelDate}</span></p></c:if></td>
				<td class="cell100 column11" id="confirmState" onclick="fnShowDetailModal('${item.username}')">
					<span id="confirmHidden${status.count}Span">
						<c:if test="${item.confirmState eq 'complete'}">승인완료</c:if>
						<c:if test="${item.confirmState eq 'cancel' or item.confirmState eq 'done'}">승인취소</c:if>
					</span>
				</td>
				<td id="confirmButton">
					<input type="hidden" id="confirmHidden${status.count}" value="${item.confirmState}">
					<c:if test="${item.confirmState ne 'cancel' and item.confirmState ne 'done'}">
						<span class="on-btn"
						id="<c:out value="confirmButton${status.count}"/>"
						onclick="fnConfirmButtonChange('confirmHidden${status.count}','${item.username}', 'confirmButton${status.count}', 'confirmDate${status.count}', 'confirmDate2${status.count}') ">
						<c:if test="${item.confirmState eq 'complete'}">승인취소</c:if>
						<c:if test="${item.confirmState eq '' or empty item.confirmState}">승인</c:if>
						</span>
					</c:if>
				</td>
			</tr>
		</tbody>
		</c:forEach>
	</c:otherwise>
	</c:choose>
		<input type="hidden" id="userIdParam" name="userIdParam"/>
	</table>
	<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
	<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
	<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
	<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
	<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn }">
	<input type="hidden" id="sortType" name="sortType" value="${sortType}">
	<input type="hidden" id="pageType" name="pageType" value="">
	<input type="hidden" id="page" name="page" value="${pagination.page}">
	<input type="hidden" id="range" name="range" value="${pagination.range}">
	<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
	<input type="hidden" id="idx" name="idx" value="${idx}">
</form>

<!-- 페이징 시작 -->

	<div style="align-items: center;margin-top: 10px;">
      <ul class="pagination">
        <li class="page-item"><a class="page-link" href="#" onClick="fnFirst(1, 1, 10)"><<</a></li>
        <c:if test="${pagination.prev}">
        	<li class="page-item"><a class="page-link" href="#" onClick="fnPrev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')"><</a></li>
        </c:if>
        
        <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
        	<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fnPagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>
        </c:forEach>
        
        <c:if test="${pagination.next}">
        	<li class="page-item"><a class="page-link" href="#" onClick="fnNext('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')">></a></li>
        </c:if>
        <li class="page-item"><a class="page-link" href="#" onClick="fnLast('${pagination.lastPage}', '${pagination.lastRange}', '${pagination.rangeSize}')">>></a></li>
      </ul>
    </div>
    <button type="button" id="modal_opne_btn" class="reg-btn" onclick="fnShowRegModal()">등록</button>
    </div>
	<!--
	<div id="paginationBox">
		<table>
			<tr>
				<td>
					<a class="page-link" href="#" onClick="fnFirst(1, 1, 10)">처음</a>
				</td>
				<td>
					<c:if test="${pagination.prev}">
						<span><a class="page-link" href="#" onClick="fnPrev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">이전</a></span>
					</c:if>
				</td>
				<td>
					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<span class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fnPagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></span>
					</c:forEach>
				</td>
				<td>
					<c:if test="${pagination.next}">
						<a class="page-link" href="#" onClick="fnNext('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" >다음</a>
					</c:if>
				</td>
				<td>
					<span><a class="page-link" href="#" onClick="fnLast('${pagination.lastPage}', '${pagination.lastRange}', '${pagination.rangeSize}')" >마지막</a></span>
				</td>
			</tr>
		</table>
		</div>
	</div>
	-->
	<!-- 페이징 끝 -->

	<div class="space-list">
      <footer class="footer-list">
          <p class="mb-1"><span class="footer-bold-txt">(주)성하  대표이사: 조정윤</span> | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
      </footer>
    </div>

<!-- layer popup 1 -->
	<div id="modalRegist" class="modal">
		<div class="modal-wrap">
			<div class="modal-content">
				<div class="modal-head">
					<h3 id="modal-title">사용자등록</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="regForm" action="/userMng/userMngSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr>
									<th width="100px" height="10px">사용자ID(*)</th>
									<td>
										<input type="hidden" value="dupCheckNo" id="dupResult">
										<input type="text" value="" id="inputUserId" name="inputUserId" maxlength="30" onchange="fnUserIdChange()" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
										<button type="button" id="dupCheck" onclick="fnUserMngDupCheck()">중복확인</button>
									</td>
									<th width="100px" height="10px">사용자 레벨</th>
									<td>
										<select id="userLevelRegist" name="userLevelRegist">
											<c:forEach var="item" items="${userLevelList}" varStatus="status">
												<option value="${item.role}">${item.roleName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row" rowspan="2">사용자명(*)</th>
									<td rowspan="2">
										<input type="text" value="" id="inputUserNm" name="inputUserNm" maxlength="50"  onkeyup="fnPressSpecial(event, this)" style="ime-mode:disabled">
									</td>
									<th scope="row">연락처</th>
									<td >
										010 - <input type="text" value="" id="telNoMiddle" name="telNoMiddle" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
										-
										<input type="text" value="" id="telNoEnd" name="telNoEnd" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
									</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td>
										<input type="text" value="" id="emailHead" name="emailHead" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">
										@
										<input type="text" value="" id="emailBody" name="emailBody" onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled">
										<select id="emailNm" name="emailNm" onchange="fnEmailChange()">
											<option value="selfInput">직접입력</option>
											<option value="naver">naver.com</option>
											<option value="daum">kakao.com</option>
											<option value="google">gmail.com</option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">기관(*)</th>
									<td>
										<select id="registOrgId" name="registOrgId" onchange="fnRegistOrgIdChange()">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}">${item.organization}</option>
											</c:forEach>
										</select>
									</td>
									<th scope="row">권한지역</th>
									<td>
										<input type="hidden" id="roleLocalId" value="">
										<input type="text" value="" id="roleLocal" name="roleLocal" value="" disabled><input type="button" value="지역선택" id="localSelectButton" onclick="fnPopLocalSelect()">
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnSave()">저장</button>
						<button type="button" id="modal_close_btn" class="modal-close" onclick="fnCloseRegModal()">취소</button>
					</div>
				</div>
			</div>
		</div>
		 <div class="modal-layer"></div>
	</div>
	<!-- //layer popup 1 -->
	
	<!-- layer popup 2 -->
	<div id="modalDetail" class="modal-overlay">
		<div class="modal-wrap">
			<div class="modal-content">
				<div class="modal-head">
					<h3 id="modal-title">상세조회</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="detailForm" action="/orgInfo/orgInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th width="100">사용자ID</th>
									<td>
										<span id="userIdDetail"></span>
									</td>
									<th>사용자 레벨</th>
									<td>
										<span id="userLevelDetail"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">사용자</th>
									<td>
										<span id="userNmDetail"></span>
									</td>
									<th scope="row">연락처</th>
									<td>
										<span id="telNoDetail"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">기관</th>
									<td>
										<span id="orgNmDetail"></span>
									</td>
									<th scope="row">이메일</th>
									<td>
										<span id="emailDetail"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">권한지역</th>
									<td colspan="3">
										<span id="roleLocalDetail"></span>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnShowModModal()">수정</button>
						<button type="button" class="modal-close" onclick="fnCloseDetailModal()">목록</button>
						<button type="button" class="btn-del" onclick="fnDel()">삭제</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- //layer popup 2 -->
	
	<!-- layer popup 3 -->
	<div id="modalMod" class="modal-overlay">
		<div class="modal-wrap">
			<div class="modal-content">
				<div class="modal-head">
					<h3 id="modal-title">수정조회</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="modForm" action="/orgInfo/orgInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th width="100">사용자ID(*)</th>
									<td>
										<span id="userIdMod"></span>
									</td>
									<th>사용자 레벨</th>
									<td>
										<select id="userLevelMod" name="userLevelMod">
											<c:forEach var="item" items="${userLevelList}" varStatus="status">
												<option value="${item.role}">${item.roleName}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr align="center">
									<th width="100" rowspan="2">사용자명(*)</th>
									<td rowspan="2">
										<input type="text" id="userNmMod" maxlength="36" onkeyup="fnPressSpecial(event, this)">
									</td>
									<th>연락처</th>
									<td>
										010 - 
										<input type="text" id="telNoMiddleMod" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled"> - 
										<input type="text" id="telNoEndMod" maxlength="4" onkeyup="fnPress(event, this)" style="ime-mode:disabled">
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td colspan="3">
										<input type="text" id="emailHeaderMod" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled">@
										<input type="text" id="emailBodyMod"  onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled">
										<select id="emailNmMod" name="emailNmMod" onchange="fnEmailModChange()">
											<option value="selfInput">직접입력</option>
											<option value="naver">naver.com</option>
											<option value="daum">kakao.com</option>
											<option value="google">gmail.com</option>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">기관(*)</th>
									<td>
										<select id="orgIdMod" name="orgIdMod" onchange="fnRegistOrgIdChangeMod()">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}">${item.organization}</option>
											</c:forEach>
										</select>
									</td>
									<th scope="row">권한지역(*)</th>
									<td>
										<input type="hidden" id="roleLocalIdMod" value="">
										<input type="text" id="roleLocalMod" disabled><input type="button" value="지역선택" id="localSelectButton" onclick="fnPopLocalSelectMod()">
									</td>
								</tr>
								<tr>
									
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="button" class="btn-reset" id="passwordReset" onclick="fnPasswordReset()">비밀번호 초기화</button>
						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnMod()">저장</button>
						<button type="button" class="modal-close" onclick="fnCloseModModal()">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //layer popup 3 -->
	
</body>
</html>