<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : irrigationList.jsp
 * @Description : 관수 정보 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.09  유성우      최초생성
 * @ 2023.05.05  이준영
 */
%>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>관수 정보관리</title>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<script type="text/javascript" src="/static/assets/js/common.js"></script>
	<style>
		.link {cursor: pointer;}
		.main-content{height:auto !important;}
		.sh-content-detail{height:auto !important;}

		.page-item:first-child .page-link {
			margin-left:8px !important;
		}
		.ARight {
			float:right;
		}
		.width-auto{
			width:auto!important;
		}
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
		
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
		
    </style>
	<script type="text/javascript">
		
		var globalUserId = "";
		var globalUserCnt = "";
		var globalIrrigationeCnt = "";
		var globalValvCnt = "";
	
		/*
		$(document).ready(function() {
			
			
			
		});
		*/
		
		$(document).keydown(function(e){
			//keyCode 구 브라우저, which 현재 브라우저
		    var code = e.keyCode || e.which;
		 
		    if (e.ctrlKey==true && (e.which == '118' || e.which == '86')) {
		    	fnCheckByte($("#textArea_byteLimit"));
             }
			
		    if (code == 27) { // 27은 ESC 키번호
		    	$("#modalRegist").attr("style", "display:none"); // 사용자관리 등록 모달 팝업		    	
		    	$("#modalDetail").attr("style", "display:none"); // 사용자관리 상세조회 모달 닫기
		    	$("#modalMod").attr("style", "display:none"); // 사용자관리 수정 모달 팝업
		    }
		});
		
		
		// 등록버튼 클릭시
		function fnShowRegModal() {
			document.searchForm.action = '<c:url value="/irrigation/irrigationRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
		};
	   
		// 사용자관리 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
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
		    document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>'; // 전송 url
		    $("#searchForm").submit(); // 서버로 전송
			
		};
	
		// 관수정보관리 검색
		function fnDetailSearch(pageNo){
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>'; // 전송 url
			document.searchForm.submit(); // 서버로 전송
			
		};
		
		
				
		// 센서명 콤보박스 변경시
		function fnOrgNmRegistChange(e){
			$.ajax({
			    url: "/orgInfo/localNmList.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	searchingOrgId : $("#orgNmRegist").val(), // 콤보박스에서 선택된 항목의 센서ID
			    	searchingLocalId : $("#localNmRegist").val() // 컴보박스에서 선택된 항목의 지역ID
			    },
			    //contentType: "application/json",
			    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#localNmRegist").empty(); // 기존에 있던 항목은 지우고
				$("#localNmRegist").append("<option value='select' selected>지역명</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNmRegist").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
				}

			    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
				
			    }
			})
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
			    	searchingLocalId : $("#localNm").val() // 컴보박스에서 선택된 항목의 지역ID
			    },
			    //contentType: "application/json",
			    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#localNm").empty(); // 기존에 있던 항목은 지우고
				$("#localNm").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNm").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
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
			var email = $("#emailHead").val() + "@" + $("#emailBody").val(); // 이메일
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
			}
			
			if(globalUserId != $("#inputUserId").val()) {
				alert("아이디 중복체크를 다시 해주세요.");
				$("#dupResult").val("dupCheckNo");
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
					alert("저장실패 하였습니다..");
				}

			    }, 
			    error : function(arg){
				alert("저장 실패");
				
			    }
			});

		};
		
		// 사용자관리 리스트에서 row 클릭시
		function fnShowDetailModal(irrigationId) {
			
			$("#irrigationIdParam").val(irrigationId);
			
			document.searchForm.action = '<c:url value="/irrigation/irrigationDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
				    $("#userIdMod").text(data.userMngModDetail.username);
				    $("#userLevelMod").val(data.userMngModDetail.role);
				    $("#userNmMod").val(data.userMngModDetail.name);
				    var telNoMiddle = "";
				    var telNoEnd = "";
				    if(data.userMngModDetail.telNo != null) {
				    	telNoMiddle = data.userMngModDetail.telNo.substr(3,4);
				    	telNoEnd = data.userMngModDetail.telNo.substr(7,4);
				    }
				    $("#telNoMiddleMod").val(telNoMiddle);
				    $("#telNoEndMod").val(telNoEnd);
				    var emailHeader = "";
				    var emailBody = "";
				    if(data.userMngModDetail.email != null) {
				    	var temp = data.userMngModDetail.email.split("@");
				    	emailHeader = temp[0];
				    	emailBody = temp[1];
				    }
				    $("#emailHeaderMod").val(emailHeader);
				    $("#emailBodyMod").val(emailBody);
				    $("#orgIdMod").val(data.userMngModDetail.organizationId);
				    $("#roleLocalMod").val(data.userMngModDetail.locals);
				    $("#roleLocalIdMod").val(data.userMngModDetail.localIds);
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
						
			var telNo = "010" + $("#telNoMiddleMod").val() + $("#telNoEndMod").val();
			var email = $("#emailHeaderMod").val() + "@" + $("#emailBodyMod").val();
			
			$.ajax({
			    url: "/userMng/userMngMod.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	userId : $("#userIdMod").text(),
			    	userNm : $("#userNmMod").val(),
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
				/*
				
				이 부분은 패스워드 암복호화랑 같이 진행해야 함.
				
				*/
			}
		};
		
		//등록시 textarea 바이트 수 체크하는 함수
		function fnCheckByte(obj){
		    var maxByte = 100; //최대 100바이트
		    var text_val = obj.value; //입력한 문자
		    var text_len = text_val.length; //입력한 문자수
		    
		    let totalByte=0;
		    for(let i=0; i<text_len; i++){
		    	var each_char = text_val.charAt(i);
		       	var uni_char = escape(each_char); //유니코드 형식으로 변환
		        if(uni_char.length>4){
		        	// 한글 : 2Byte
		            totalByte += 2;
		        }else{
		        	// 영문,숫자,특수문자 : 1Byte
		            totalByte += 1;
		        }
		    }
		    
            if(getByteLength(obj.value) > 100) {
            	alert("최대 100Byte까지만 입력가능합니다.!");
            	obj.value = cutStr(obj.value, 100);
	    		totalByte = getByteLength(obj.value);
	        	document.getElementById("textareaByteCnt").innerText = totalByte;
	            document.getElementById("textareaByteCnt").style.color = "red";	
            } else {
            	document.getElementById("textareaByteCnt").innerText = totalByte;
	            document.getElementById("textareaByteCnt").style.color = "green";
            }
		};
		
		function sliceByByte(s, len) {
			if (s == null || s.length == 0) {
				return 0;
			}
			var size = 0;
			var rIndex = s.length;

			for ( var i = 0; i < s.length; i++) {
				size += charByteSize(s.charAt(i));
				if( size == len ) {
					rIndex = i + 1;
					break;
				} else if( size > len ) {
					rIndex = i;
					break;
				}
			}
			return s.substring(0, rIndex);
		};
		
		function cutStr(str, limit){
			 
            var strLength = 0;
            var strTitle = "";
            var strPiece = "";

            for (i = 0; i < str.length; i++){
                var code = str.charCodeAt(i);
                var ch = str.substr(i,1).toUpperCase();
                //체크 하는 문자를 저장
                strPiece = str.substr(i,1)
                code = parseInt(code);

                if ((ch < "0" || ch > "9") && (ch < "A" || ch > "Z") && ((code > 255) || (code < 0))){
                    strLength = strLength + 3; //UTF-8 3byte 로 계산
                }else{
                    strLength = strLength + 1;
                }

                if(strLength>limit){ //제한 길이 확인
                    break;
                }else{
                    strTitle = strTitle+strPiece; //제한길이 보다 작으면 자른 문자를 붙여준다.
                }
            }
            
           return strTitle;

        }
		
		function getByteLength(s) {
			if (s == null || s.length == 0) {
				return 0;
			}
			var size = 0;
			for ( var i = 0; i < s.length; i++) {
				size += charByteSize(s.charAt(i));
			}
			return size;
		};
		
		function charByteSize(ch) {

			if (ch == null || ch.length == 0) {
				return 0;
			}

			var charCode = ch.charCodeAt(0);

			if (charCode <= 0x00007F) {
				return 1;
			} else if (charCode <= 0x0007FF) {
				return 2;
			} else if (charCode <= 0x00FFFF) {
				return 3;
			} else {
				return 4;
			}
		};
		
		
		var timerId = [];
		// ON OFF 버튼 클릭시 상태 변경
		function fnStateChange(irrigationId, count) {
			var state = "";
			var streamTime = 0;
			
			if($("#stateOn" + count).css("display") == "none") { // 상태값 ON으로 변경시
				$("#stateOn" + count).attr("style", "display:block");
				$("#stateOff" + count).attr("style", "display:none");
				
				var dateObj = new Date();
				var flowInputTime = $("#timeSelect" + count).val();
				dateObj.setMinutes(dateObj.getMinutes() + Number(flowInputTime));
				
				timerId[count] = countDownTimer('flowInputTime' + count, dateObj, irrigationId, count); // 입력한 분만큼 카운트 다운
				//countDownTimer('flowInputTime', '04/01/2024 00:00 AM'); // 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다.
				
				state = "ON";
				
				$.ajax({
				    url: "/irrigation/irrigationStateChange.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	irrigationId : irrigationId,
				    	streamTime : flowInputTime,
				    	state : state,
				    	userId : "macross",
				    	irrigationDetail : $("#irrigationDetail" + count).text()
				    },
				    //contentType: "application/json",
				    success : function(data) {
				    	
				    }, 
				    error : function(arg){
					alert("관수상태 변경 실패");
					
				    }
				});

				
			} else {  // 상태값 OFF로 변경시
				$("#stateOn" + count).attr("style", "display:none");
				$("#stateOff" + count).attr("style", "display:block");
				clearInterval(timerId[count]);
				var flowInputTime = 0;
				$("#flowInputTime" + count).val("0");
				state = "OFF";
				
				$.ajax({
				    url: "/irrigation/irrigationStateChange.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	irrigationId : irrigationId,
				    	streamTime : flowInputTime,
				    	state : state,
				    	userId : "macross",
				    	irrigationDetail : $("#irrigationDetail" + count).text()
				    },
				    //contentType: "application/json",
				    success : function(data) {
				    	
				    }, 
				    error : function(arg){
					alert("관수상태 변경 실패");
					
				    }
				});
				
				alert(irrigationId + "의 유량튜입시간이 종료되었습니다.");
				
			}
			
			
			
		};
		
		// 유량투입시간 카운트 다운
		const countDownTimer = function (id, date, irrigationId, count) {
			var _vDate = new Date(date); // 전달 받은 일자
			var _second = 1000;
			var _minute = _second * 60;
			var _hour = _minute * 60;
			var _day = _hour * 24;
			var timer;

			function showRemaining() {
				var now = new Date();
				var distDt = _vDate - now;

				if (distDt < 0) {
					clearInterval(timer);							
					document.getElementById(id).value = '0';
					document.getElementById(id).addEventListener('click',fnStateChange(irrigationId, count));
					return timer;
				}

				var days = Math.floor(distDt / _day);
				var hours = Math.floor((distDt % _day) / _hour);
				var minutes = Math.floor((distDt % _hour) / _minute);
				var seconds = Math.floor((distDt % _minute) / _second);
				
				document.getElementById(id).value = "";
				document.getElementById(id).value += minutes + '분 ';
				document.getElementById(id).value += seconds + '초';
			}

			timer = setInterval(showRemaining, 1000);
			return timer;
		};

		// 엑셀 다운로드 버튼 클릭시
		function fnIrrigationExcelDown(form) {
			form.action = '<c:url value="/irrigation/excel.do"/>';
			form.submit();
		};
		
		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		}
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		}
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		}
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		}
		
		// 관수ID 중복체크
		function fnDupCheck() {
			var inputIrrigationId = $('#inputIrrigationId').val();
			
			if(inputIrrigationId.indexOf(' ') > -1) {
				alert('관수ID에 공백이 포함되어 있습니다.');
				return false;
			} else if(inputIrrigationId == '') {
				alert('관수ID를 입력해주세요.');
				return false;
			} else if(inputIrrigationId.length < 4 ) {
				alert("관수ID는 영문, 숫자 4자리까지 허용입니다.");
				return false;
			}
			
			$.ajax({
			    url: "/irrigation/dupCheck.do",
			    type: "POST",
			    async: true,
			    data: {
			    	irrigationId : $("#inputIrrigationId").val()
			    },
			    success : function(data) {
					if(data.dupCheckResult == true) {
						alert("중복된 아이디입니다.");					
					} else {
						alert("사용가능한 아이디 입니다.");
						$("#dupResult").val("dupCheckYes");
					}
			    }, 
			    error : function(arg){
					alert("통신실패시에만 실행");
					alert(JSON.stringify(arg));
			    }
			})
		};
	</script>
</head>
<body>
<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	<div class="sh-main">
		<div id="backdrop_on" class="res-backdrop fade"></div>
		<div class="sh-header">
			<!-- reponsive header -->
			<div class="responsive-title">
				<h2 class="responsive-title-txt h4-bold">관수 정보관리</h2>
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
			<div class="main-content" headline="Stats">
	<form id="searchForm" name="searchForm" action="/irrigation/irrigationList.do" method="post">
		<span class="con-title-span">관수</span>
		<select id="searchingType" name="searchingType">
			<option value="irrigation" <c:if test="${searchingType eq 'irrigation'}">selected</c:if> >관수명</option>
			<option value="irrigationId" <c:if test="${searchingType eq 'irrigationId'}">selected</c:if> >관수ID</option>
		</select>
		<input type="text" name="searchingContent" value="${searchingContent}"  placeholder="내용을 입력하세요."/>
		<span class="con-title-span">기관명</span>
	<select id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)">
		<option value="total">전체</option>
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
		<span class="con-title-span">지역명</span>
	<select id="localNm" name="localNm">
		<option value="total" selected>전체</option>
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


		<button type="button" id="search" class="icon-primary-small btn-search" onclick="javascript:fnDetailSearch(1)">검색</button>

			</div>
			<div class="main-content" headline="Stats">

	<button type="button"  class="icon-primary-middle ARight" onclick="fnIrrigationExcelDown(this.form)">엑셀다운로드</button>

				<!-- table -->

					<div class="wrap-table">
						<div class="table100 ver1">

							<div class="wrap-table100-nextcols js-pscroll">
							<span class="table100-nextcols">
								<table>
									<thead>
									<tr class="row100 head body-2-bold ">
										<th class="column1">번호</th>
										<th class="column2 column-arrow-up">관수ID</th>
										<th class="column3 column-arrow-down">관수명</th>
										<th class="column4 column-arrow-up">기관명</th>
										<th class="column5 column-arrow-up">지역명</th>
										<th class="column6">유량투입시간</th>
										<th class="column7">관수 설정 상태</th>
										<th class="column8">관수 위치 설명</th>
									</tr>
									</thead>
	<c:choose>
	<c:when test="${empty irrigationList}">
		<tbody class="body-2-regular tbody-table" id="tbody">
			<tr class="row100 head body-2-bold ">
				<th colspan="8">
					조회된 결과가 없습니다.
				</th>
			</tr>
		</tbody>
	</c:when>
	<c:otherwise>

		<tbody  class="body-2-regular tbody-table" id="tbody">
<%--		<c:set var="num" value="2"/>--%>
		<c:forEach var="item" items="${irrigationList}" varStatus="status">
			<c:choose>
			<c:when test="${status.count %2 == 0}">
			<tr class="row100 body odd">
				<td class="column1" id="rownum" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.rownum}" escapeXml="false" /></span></td>
				<td class="column2" id="irrigationId" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationId}" escapeXml="false" /></span></td>
				<td class="column3" id="irrigation" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationName}" escapeXml="false" /></span></td>
				<td class="column4" id="local" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.local}" escapeXml="false" /></span></td>
				<td class="column5" id="organization" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.organization}" escapeXml="false" /></span></td>
				<td class="column6" >
					<select class="width-auto"  id="timeSelect${status.count}">
						<option value="5">5분  &nbsp;&nbsp;</option>
						<option value="10">10분 &nbsp;&nbsp;</option>
						<option value="15">15분 &nbsp;&nbsp;</option>
						<option value="20">20분 &nbsp;&nbsp;</option>
					</select>
					<input type="text"class="width-auto"  id="flowInputTime${status.count}" disabled/>
				</td>
				<td class="column7">
					<div align="center" >
						<c:if test="${item.state eq 'ON'}"><input type="button" class="width-auto"  id="stateOn${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:block;" value=" ON "></button></c:if>
						<c:if test="${item.state eq 'OFF'}"><input type="button" class="width-auto"  id="stateOn${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:none;" value=" ON "></button></c:if>
						<c:if test="${item.state eq 'ON'}"><input type="button" class="width-auto"  id="stateOff${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:none;" value="OFF"></button></c:if>
						<c:if test="${item.state eq 'OFF'}"><input type="button" class="width-auto"  id="stateOff${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:block;" value="OFF"></button></c:if>
					</div>
				</td>
				<td class="column8" id="irrigationDetail${status.count}"><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationDetail}" escapeXml="false" /></span></td>
			</tr>
			</c:when>
			<c:otherwise>
				<tr class="row100 body even">
					<td class="column1" id="rownum" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.rownum}" escapeXml="false" /></span></td>
					<td class="column2" id="irrigationId" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationId}" escapeXml="false" /></span></td>
					<td class="column3" id="irrigation" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationName}" escapeXml="false" /></span></td>
					<td class="column4" id="local" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.local}" escapeXml="false" /></span></td>
					<td class="column5" id="organization" ><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.organization}" escapeXml="false" /></span></td>
					<td class="column6" ><select  class="width-auto" id="timeSelect${status.count}">
						<option value="5">5분 &nbsp;&nbsp;</option>
						<option value="10">10분 &nbsp;&nbsp;</option>
						<option value="15">15분 &nbsp;&nbsp;</option>
						<option value="20">20분 &nbsp;&nbsp;</option>
					</select>
						<input type="text"  class="width-auto" id="flowInputTime${status.count}" disabled/>
					</td>
					<td class="column7">
						<div align="center">
							<c:if test="${item.state eq 'ON'}"><input type="button"  class="width-auto" id="stateOn${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:block;" value=" ON "></button></c:if>
							<c:if test="${item.state eq 'OFF'}"><input type="button" class="width-auto" id="stateOn${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:none;" value=" ON "></button></c:if>
							<c:if test="${item.state eq 'ON'}"><input type="button" class="width-auto" id="stateOff${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:none;" value="OFF"></button></c:if>
							<c:if test="${item.state eq 'OFF'}"><input type="button" class="width-auto" id="stateOff${status.count}" onclick="fnStateChange('${item.irrigationId}', '${status.count}')" style="display:block;" value="OFF"></button></c:if>
						</div>
					</td>
					<td class="column8" id="irrigationDetail${status.count}"><span class="link" onclick="fnShowDetailModal('${item.irrigationId}', '${status.count}')"><c:out value="${item.irrigationDetail}" escapeXml="false" /></span></td>
				</tr>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		</tbody>

	</c:otherwise>
	</c:choose>
	</table>
	<input type="hidden" id="irrigationIdParam" name="irrigationIdParam"/>
	<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn }">
	<input type="hidden" id="sortType" name="sortType" value="${sortType}">
	<input type="hidden" id="pageType" name="pageType" value="">
	<input type="hidden" id="page" name="page" value="${pagination.page}">
	<input type="hidden" id="range" name="range" value="${pagination.range}">
	<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
	<input type="hidden" id="idx" name="idx" value="${idx}">

<P>

<!-- 페이징 시작 -->
	<div>
		<div>
			<ul class="pagination">
				<li class="page-item">
					<span><a class="page-link" href="#" onClick="fnFirst(1, 1, 5)"> << </a> </span>
				</li>
				<li class="page-item">
					<c:if test="${pagination.prev}">
						<span><a class="page-link" href="#" onClick="fnPrev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')"> < </a></span>
					</c:if>
				</li>
				<li class="page-item">
					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<span class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fnPagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></span>
					</c:forEach>
				</li>
				<li class="page-item">
					<c:if test="${pagination.next}">
						<a class="page-link" href="#" onClick="fnNext('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" > > </a>
					</c:if>
				</li>
				<li class="page-item">
					<span><a class="page-link" href="#" onClick="fnLast('${pagination.lastPage}', '${pagination.lastRange}', '${pagination.rangeSize}')" > >> </a></span>
				</li>
			</ul>
		</div>
	</div>
			<button type="button" id="modal_opne_btn" class="icon-primary-small ARight" onclick="fnShowRegModal()">등록</button>
</div>
	<!-- 페이징 끝 -->

<%--<!-- layer popup 1 -->--%>
<%--	<div id="modalRegist" class="modal">--%>
<%--		<div class="modal-wrap">--%>
<%--			<div class="modal-content">--%>
<%--				<div class="modal-head">--%>
<%--					<h3 id="modal-title">관수 정보관리</h3>--%>
<%--					<!-- <a class="modal-close" title="닫기">닫기</a>  -->--%>
<%--				</div>--%>
<%--				<div class="modal-body">--%>
<%--					<form id="regForm" action="/irrigation/irrigationSave.do" method="post">--%>
<%--						<input type="hidden" value="I" id="type" name="type">--%>
<%--						<table class="tb-default" border="1">--%>
<%--							<tbody>--%>
<%--								<tr>--%>
<%--									<th width="100px" height="10px">관수ID(*)</th>--%>
<%--									<td>--%>
<%--										<input type="text" value="" id="inputIrrigationId" name="inputUserId" maxlength="10">--%>
<%--										<button type="button" id="dupCheck" onclick="fnDupCheck()">중복확인</button>--%>
<%--									</td>--%>
<%--									<th width="100px" height="10px">관수명</th>--%>
<%--									<td>--%>
<%--										<input type="text" value="" id="inputIrrigation" name="inputUserId" maxlength="10">--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">관수 상태(*)</th>--%>
<%--									<td>--%>
<%--										<input type="radio" id="irrigationStateOn" name="irrigationState" checked />ON<input type="radio" id="irrigationStateOff" name="irrigationState" />OFF--%>
<%--									</td>--%>
<%--									<th scope="row">설정값</th>--%>
<%--									<td >--%>
<%--										최소<input type="text" value="" id="telNoMiddle" name="telNoMiddle" maxlength="2">% 최대<input type="text" value="" id="telNoEnd" name="telNoEnd" maxlength="3">%--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">기관명(*)</th>--%>
<%--									<td>--%>
<%--										<select id="orgNmRegist" name="orgNmRegist" onchange="fnOrgNmRegistChange(this)">--%>
<%--											<option value="select" selected>기관명</option>--%>
<%--											<c:choose>--%>
<%--											<c:when test="${'total' eq orgNm}">--%>
<%--												<c:forEach var="item" items="${orgNmList}" varStatus="status">--%>
<%--													<option value="${item.organizationId}">${item.organization}</option>--%>
<%--												</c:forEach>--%>
<%--											</c:when>--%>
<%--											<c:otherwise>--%>
<%--												<c:forEach var="item" items="${orgNmList}" varStatus="status">--%>
<%--													<option value="${item.organizationId}" <c:if test="${item.organizationId eq orgNm}">selected</c:if> >${item.organization}</option>--%>
<%--												</c:forEach>--%>
<%--											</c:otherwise>--%>
<%--											</c:choose>--%>
<%--										</select>--%>
<%--									</td>--%>
<%--									<th scope="row">지역명</th>--%>
<%--									<td>--%>
<%--										<select id="localNmRegist" name="localNmRegist">--%>
<%--											<option value="select" selected>지역명</option>--%>
<%--											<c:choose>--%>
<%--											<c:when test="${'total' eq localNm}">--%>
<%--												<c:forEach var="item" items="${localNmList}" varStatus="status">--%>
<%--													<option value="${item.localId}">${item.local}</option>--%>
<%--												</c:forEach>--%>
<%--											</c:when>--%>
<%--											<c:otherwise>--%>
<%--												<c:forEach var="item" items="${localNmList}" varStatus="status">--%>
<%--													<option value="${item.localId}" <c:if test="${item.localId eq localNm}">selected</c:if> >${item.local}</option>--%>
<%--												</c:forEach>--%>
<%--											</c:otherwise>--%>
<%--											</c:choose>--%>
<%--										</select>--%>
<%--										<button type="button" id="locationSelect" onclick="">위치선택</button>--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>									--%>
<%--									<th scope="row">관수 위치 설명</th>--%>
<%--									<td colspan="3">--%>
<%--										<textarea id="textArea_byteLimit" name="textArea_byteLimit" onkeydown="fnCheckByte(this)" onkeyup="fnCheckByte(this)"></textarea>--%>
<%--										<p>--%>
<%--										<span id="textareaByteCnt"></span> byte / 100 byte--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--							</tbody>--%>
<%--						</table>--%>
<%--					</form>--%>
<%--					<div class="modal-button">--%>
<%--						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnSave()">저장</button>--%>
<%--						<button type="button" id="modal_close_btn" class="modal-close" onclick="fnCloseRegModal()">취소</button>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		 <div class="modal-layer"></div>--%>
<%--	</div>--%>
<%--	<!-- //layer popup 1 -->--%>
<%--	--%>
<%--	<!-- layer popup 2 -->--%>
<%--	<div id="modalDetail" class="modal-overlay">--%>
<%--		<div class="modal-wrap">--%>
<%--			<div class="modal-content">--%>
<%--				<div class="modal-head">--%>
<%--					<h3 id="modal-title">상세조회</h3>--%>
<%--					<!-- <a class="modal-close" title="닫기">닫기</a>  -->--%>
<%--				</div>--%>
<%--				<div class="modal-body">--%>
<%--					<form id="detailForm" action="/irrigation/irrigationDetail.do" method="post">--%>
<%--						<input type="hidden" value="I" id="type" name="type">--%>
<%--						<table class="tb-default" border="1">--%>
<%--							<tbody>--%>
<%--								<tr align="center">--%>
<%--									<th width="100">관수ID<p>(시리얼 넘버)</th>--%>
<%--									<td>--%>
<%--										<span id="irrigationIdDetail"></span>--%>
<%--									</td>--%>
<%--									<th>관수명</th>--%>
<%--									<td>--%>
<%--										<span id="irrigationDetail"></span>--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">기관명</th>--%>
<%--									<td>--%>
<%--										<span id="orgNmDetail"></span>--%>
<%--									</td>--%>
<%--									<th scope="row">지역명</th>--%>
<%--									<!--<td>--%>
<%--										<span id="localNmDetail"></span>--%>
<%--										<button type="button" id="locationConfirm" onclick="">위치확인</button>--%>
<%--									</td>-->--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">관수 상태</th>--%>
<%--									<td>--%>
<%--										<span id="stateDetail"></span>--%>
<%--									</td>--%>
<%--									<th scope="row">펌프설정</th>--%>
<%--									<td>--%>
<%--										<span id="controlDetail"></span>--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">관수 위치 설명</th>--%>
<%--									<td colspan="3">--%>
<%--										<span id="irrigationContent"></span>--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--							</tbody>--%>
<%--						</table>--%>
<%--					</form>--%>
<%--					<div class="modal-button">--%>
<%--						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnShowModModal()">수정</button>--%>
<%--						<button type="button" class="modal-close" onclick="fnCloseDetailModal()">목록</button>--%>
<%--						<button type="button" class="btn-del" onclick="fnDel()">삭제</button>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="modal-layer"></div>--%>
<%--	</div>--%>
<%--	<!-- //layer popup 2 -->--%>
<%--	--%>
<%--	<!-- layer popup 3 -->--%>
<%--	<div id="modalMod" class="modal-overlay">--%>
<%--		<div class="modal-wrap">--%>
<%--			<div class="modal-content">--%>
<%--				<div class="modal-head">--%>
<%--					<h3 id="modal-title">수정조회</h3>--%>
<%--					<!-- <a class="modal-close" title="닫기">닫기</a>  -->--%>
<%--				</div>--%>
<%--				<div class="modal-body">--%>
<%--					<form id="modForm" action="/orgInfo/orgInfoDetail.do" method="post">--%>
<%--						<input type="hidden" value="I" id="type" name="type">--%>
<%--						<table class="tb-default" border="1">--%>
<%--							<tbody>--%>
<%--								<tr align="center">--%>
<%--									<th width="100">사용자ID</th>--%>
<%--									<td>--%>
<%--										<span id="userIdMod"></span>--%>
<%--									</td>--%>
<%--									<th>사용자 레벨</th>--%>
<%--									<td>--%>
<%--										<select id="userLevelMod" name="userLevelMod">--%>
<%--											<c:forEach var="item" items="${userLevelList}" varStatus="status">--%>
<%--												<option value="${item.role}">${item.roleName}</option>--%>
<%--											</c:forEach>--%>
<%--										</select>--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr align="center">--%>
<%--									<th width="100" rowspan="2">사용자명</th>--%>
<%--									<td rowspan="2">--%>
<%--										<input type="text" id="userNmMod">--%>
<%--									</td>--%>
<%--									<th>연락처</th>--%>
<%--									<td>--%>
<%--										010 - --%>
<%--										<input type="text" id="telNoMiddleMod"> - --%>
<%--										<input type="text" id="telNoEndMod">--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th>이메일</th>--%>
<%--									<td colspan="3">--%>
<%--										<input type="text" id="emailHeaderMod">@--%>
<%--										<input type="text" id="emailBodyMod">--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									<th scope="row">기관</th>--%>
<%--									<td>--%>
<%--										<select id="orgIdMod" name="orgIdMod" onchange="fnRegistOrgIdChangeMod()">--%>
<%--											<c:forEach var="item" items="${orgNmList}" varStatus="status">--%>
<%--												<option value="${item.organizationId}">${item.organization}</option>--%>
<%--											</c:forEach>--%>
<%--										</select>--%>
<%--									</td>--%>
<%--									<th scope="row">권한지역</th>--%>
<%--									<td>--%>
<%--										<input type="hidden" id="roleLocalIdMod" value="">--%>
<%--										<input type="text" id="roleLocalMod" disabled><input type="button" value="지역선택" id="localSelectButton" onclick="fnPopLocalSelectMod()">--%>
<%--									</td>--%>
<%--								</tr>--%>
<%--								<tr>--%>
<%--									--%>
<%--								</tr>--%>
<%--							</tbody>--%>
<%--						</table>--%>
<%--					</form>--%>
<%--					<div class="modal-button">--%>
<%--						<button type="button" class="btn-reset" id="passwordReset" onclick="fnPasswordReset()">비밀번호 초기화</button>--%>
<%--						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnMod()">저장</button>--%>
<%--						<button type="button" class="modal-close" onclick="fnCloseModModal()">취소</button>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</div>--%>
<%--		<div class="modal-layer"></div>--%>
<%--	</div>--%>
<%--	<!-- //layer popup 3 -->--%>
								</form>
						</div>
					</div>
				</div>
			</div><%@ include file="/WEB-INF/views/footer.jsp" %>
		</div>
</div>
</body>
</html>
