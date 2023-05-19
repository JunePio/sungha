<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<%
/**
 * @Class Name : orgInfoList.jsp
 * @Description : 기관정보 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.09  유성우      최초생성
 * @
 */
%>


<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>기관 정보관리</title>
	<script src="/static/js/filtering.js"></script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

    <link rel="shortcut icon" href="favicon.ico">
	<link rel="stylesheet" href="/static/assets/css/agency/list.css">
	<link rel="stylesheet" href="/static/assets/css/agency/fonts.css">
	<link rel="stylesheet" href="/static/assets/css/agency/style.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	
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
	
	
	<style>
		/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
		.ui-datepicker-trigger{cursor: pointer;}
		/*datepicer input 롤오버 시 손가락 모양 표시*/
		.hasDatepicker{cursor: pointer;}
    </style>
	<script type="text/javascript">
	
		$(document).ready(function() {
			var column = $("#sortColumn").val();
			if($("#sortType").val() == "desc") { // 정렬방식이 내림차순일 경우
		    	$("#"+column).removeClass("column"+ column +"-sensor column-arrow-down");
		    	$("#"+column).addClass("column"+ column +"-sensor column-arrow-up");
		    } else {
		    	$("#"+column).removeClass("column"+ column +"-sensor");
		    	$("#"+column).addClass("column"+ column +"-sensor column-arrow-down");
		    }
		});
		
		$(document).keydown(function(e){
			//keyCode 구 브라우저, which 현재 브라우저
		    var code = e.keyCode || e.which;
		 
		    if (code == 27) { // 27은 ESC 키번호
		    	fnCloseRegModal();
		    	$("#modalDetail").attr("style", "display:none"); // 기관정보 상세조회 모달 닫기
		    	$("#modalMod").attr("style", "display:none"); // 기관정보 수정조회 모달 닫기
		    }
		});
		
		// 등록버튼 클릭시
		function fnShowRegModal() {
			//$("#modalRegist").attr("style", "display:block"); // 기관정보 등록 모달 팝업
			
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
		};
	   
		// 기관정보 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
			$("#inputOrgId").val(""); // 기관ID 초기화
			$("#inputOrgNm").val(""); // 기관명 초기화
			$("#inputPersonInCharge").val(""); // 담당자 초기화
			$("#telNoMiddle").val(""); // 연락처 초기화
			$("#telNoEnd").val(""); // 연락처 초기화
			$("#emailHead").val(""); // 이메일 초기화
			$("#emailBody").val(""); // 이메일 초기화
			$("#emailBody").attr("disabled", false); // 이메일 초기화
			$("#emailNm option:eq(0)").prop("selected", true); // 콤보박스 첫번째 항목 선택
			
			$("#modalRegist").attr("style", "display:none"); // 기관정보 등록 모달 닫기
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
	
		// 기관정보 검색
		function fnDetailSearch(pageNo){
			$("#page").val("1");
			$("#range").val("1");
			$("#pageSize").val("10");
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>'; // 전송 url
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
		
		// 기관정보 리스트에서 row 클릭시
		function fnShowDetailModal(organizationId) {
			
			$("#orgIdParam").val(organizationId);
			
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
			
		};
		
		// 기관정보 상세조회 모달에서 취소 버튼 클릭시
		function fnCloseDetailModal() {
			$("#modalDetail").attr("style", "display:none"); // 기관정보 상세조회 모달 닫기
		};
		
		// 기관정보 상세조회에서 수정 버튼 클릭시
		function fnShowModModal() {
			
			$.ajax({
			    url: "/orgInfo/orgInfoModDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	orgId : $("#orgIdDetail").text()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    
			   		$("#modalDetail").attr("style", "display:none"); // 기관정보 상세조회 모달 닫기
			   		$("#modalMod").attr("style", "display:block"); // 기관정보 수정조회 모달 팝업
			   		
			   		// 값을 초기화 해준다.
			   		$("#orgIdMod").text("");
			   		$("#orgNmMod").val("");
			   		$("#personInChargeMod").val("");
			   		$("#telNoMiddleMod").val("");
				    $("#telNoEndMod").val("");
				    $("#emailHeaderMod").val("");
				    $("#emailBodyMod").val("");
				    
				    // 위에서 초기화후 값을 넣어준다.
				    $("#orgIdMod").text(onGetUnescapeXSS(data.orgInfoModDetail.organizationId));
				    $("#orgNmMod").val(onGetUnescapeXSS(data.orgInfoModDetail.organization));
				    $("#personInChargeMod").val(onGetUnescapeXSS(data.orgInfoModDetail.personInCharge));
				    var telNoMiddle = "";
				    var telNoEnd = "";
				    if(data.orgInfoModDetail.telNo != null) {
				    	telNoMiddle = data.orgInfoModDetail.telNo.substr(3,4);
				    	telNoEnd = data.orgInfoModDetail.telNo.substr(7,4);
				    }
				    $("#telNoMiddleMod").val(onGetUnescapeXSS(telNoMiddle));
				    $("#telNoEndMod").val(onGetUnescapeXSS(telNoEnd));
				    var emailHeader = "";
				    var emailBody = "";
				    if(data.orgInfoModDetail.email != null) {
				    	var temp = data.orgInfoModDetail.email.split("@");
				    	emailHeader = temp[0];
				    	emailBody = temp[1];
				    }
				    $("#emailHeaderMod").val(onGetUnescapeXSS(emailHeader));
				    $("#emailBodyMod").val(onGetUnescapeXSS(emailBody));
				    
				    // 이메일 수정입력
				    if(emailBody == "naver.com") { // 네이버 이메일이었다면
				    	$('#emailNmMod').val('naver').prop("selected",true); // 네이버를 선택
				    	$("#emailBodyMod").attr("disabled", true); // 이메일 변경못하게 막기
			    	} else if(emailBody == "kakao.com") { // 카카오 이메일이었다면
			    		$('#emailNmMod').val('daum').prop("selected",true); // 다음을 선택
			    		$("#emailBodyMod").attr("disabled", true); // 이메일 변경못하게 막기
			    	} else if(emailBody == "gmail.com") { // 지메일 이었다면
			    		$('#emailNmMod').val('google').prop("selected",true); // 구글을 선택
			    		$("#emailBodyMod").attr("disabled", true); // 이메일 변경못하게 막기
			    	} else {
			    		$('#emailNmMod').val('selfInput').prop("selected",true); // 직접입력 선택
			    	}
				    
				    
				    
			    }, 
			    error : function(arg){
				alert("기관정보 수정조회 실패");
				
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
					$("#modalMod").attr("style", "display:none"); // 기관정보 수정조회 모달 닫기
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
				
		// 기관정보 수정 모달에서 취소 버튼 클릭시
		function fnCloseModModal() {
			$("#modalMod").attr("style", "display:none"); // 기관정보 수정 모달 닫기
		};
		
		// 기관정보 상세 모달에서 삭제 버튼 클릭시
		function fnDel() {
			
			$.ajax({
			    url: "/orgInfo/orgInfoDelIsOk.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	orgId : $("#orgIdDetail").text()
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
							    async: true,
							    //dataType: "json",
							    data: {
							    	orgId : $("#orgIdDetail").text()
							    },
							    //contentType: "application/json",
							    success : function(data) {
							    	alert("삭제완료 하였습니다.")
							    	fnCloseDetailModal(); // 기관정보 상세 모달 닫기
							    	location.reload(); // 페이지 새로고침
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
		 
		$("#datepicker").datepicker();
		
		$(function() {
            //input을 datepicker로 선언
            $("#datepicker").datepicker({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthSuffix: "월"
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: "" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
            });                    
            
            if($("#date").val() != "") {
            	//초기값을 오늘 날짜로 설정
                $('#datepicker').datepicker('setDate', $("#date").val());
            } else {
            	//초기값을 오늘 날짜로 설정
                $('#datepicker').datepicker('setDate', 'today');
            }
                        
        });
		
		
		
		// 기관ID가 변경되었을 경우 중복확인 다시 체크
		function fnOrgIdChange() {
			$("#dupResult").val("dupCheckNo");
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
		
		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>';
			document.searchForm.submit();
		}
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>';
			document.searchForm.submit();
		}
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>';
			document.searchForm.submit();
		}
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/orgInfo/orgInfoList.do"/>';
			document.searchForm.submit();
		}
	
		// 엑셀 다운로드 버튼 클릭시
		function fnOrgInfoExcelDown(form) {
			form.action = '<c:url value="/orgInfo/excel.do"/>';
			form.submit();
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
          <h2 class="responsive-title-txt h4-bold">기관관리</h2>          
        </div>

        <div class="title">
        <h2 class="title-txt h2-bold">기관관리</h2>
        <p class="title-menu">
          <span class="title-menu"> < 기관 < 기관 관리</span>
        </p>
      </div>
    </div>
	<form id="searchForm" name="searchForm" action="/orgInfo/orgInfoList.do" method="post">
	 <div class="sh-content">
          <div class="condition-search">
            <div class="list-box">
    <div class="search-second-condition con-title">
	<span style="position:relative;"  >기관명</span>
	<select id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)" class="dropdown-sel search-sel ml-2" style="position:relative;">
		<option value="total">전체</option>
		<c:choose>
		<c:when test="${'total' eq orgNm}">
			<c:forEach var="item" items="${orgNmList}" varStatus="status">
				<option value="${item.organizationId}">${item.organization}</option>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach var="item" items="${orgNmList}" varStatus="status">
				<option value="${item.organizationId}" <c:if test="${item.organizationId eq searchingOrgId}">selected</c:if> >${item.organization}</option>
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</select>
	</div>
	<div class="search-third-condition con-title">
	<span>지역명</span>
	<select id="searchingLocalId" name="searchingLocalId" class="dropdown-sel search-sel ml-2"  style="position:relative;">
		<option value="total" selected>전체</option>
		<c:choose>
		<c:when test="${'total' eq localNm}">
			<c:forEach var="item" items="${localNmList}" varStatus="status">
				<option value="${item.localId}">${item.local}</option>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach var="item" items="${localNmList}" varStatus="status">
				<option value="${item.localId}" <c:if test="${item.localId eq searchingLocalId}">selected</c:if> >${item.local}</option>
			</c:forEach>
		</c:otherwise>
		</c:choose>
	</select>
	</div>
	<div class="search-first-condition agency-condition-name">
	<span>담당자명</span>
	<input type="text" class="search-sel input-search input-name-search" placeholder="이름을 입력하세요." id="personInCharge" name="personInCharge" value="${personInCharge}"/>
	</div>
	<div class="search-forth-condition">
	<input type="button" id="search" class="icon-primary-small btn-search" onclick="javascript:fnDetailSearch(1)" value="검색"/>
	</p>
	</div>
	</div>
	</div>
	<div class="main-content" headline="Stats">
	<div class="res-main-top">
			<!-- 
             <p class="time-txt">
               2022.12.09.시간경과 12:00        
             </p>
            -->
		<button type="button" onclick="fnOrgInfoExcelDown(this.form)" class="actibody-2-bold  excel-btn">엑셀다운로드</button>
	</div>
	
	<!-- table -->
    <div class="wrap-table">
        <div class="table100 ver1">
        
        <div class="wrap-table100-nextcols js-pscroll">
        <div class="table100-nextcols">
    
	<table id="orgList">
	<thead>
		<tr class="row100 head body-2-bold">
			<th class="column1-agency" id="1" onclick="fnHeaderClick(1)">번호</th>
			<th class="column2-agency" id="2" onclick="fnHeaderClick(2)">기관ID</th>
			<th class="column3-agency" id="3" onclick="fnHeaderClick(3)">기관명</th>
			<th class="column4-agency" id="4" onclick="fnHeaderClick(4)">지역명</th>
			<th class="column5-agency" id="5" onclick="fnHeaderClick(5)">사용자 수</th>
			<th class="column6-agency" id="6" onclick="fnHeaderClick(6)">센서 수 (사용/보유)</th>
			<th class="column7-agency" id="7" onclick="fnHeaderClick(7)">관수 수</th>
			<th class="column8-agency" id="8" onclick="fnHeaderClick(8)">담당자명</th>
			<th class="column9-agency" id="9" onclick="fnHeaderClick(9)">연락처</th>
			<th class="column10-agency" id="10" onclick="fnHeaderClick(10)">이메일</th>
			<th class="column11-agency" id="11" onclick="fnHeaderClick(11)">등록일 (수정일)</th>
		</tr>
	</thead>
	<c:choose>
	<c:when test="${empty orgInfoList}">
		<tbody id="tbody">
			<tr>
				<th colspan="11">
					조회된 결과가 없습니다.
				</th>
			</tr>
		</tbody>
	</c:when>
	<c:otherwise>
	<tbody id="tbody">
		<c:forEach var="item" items="${orgInfoList}" varStatus="status">
			<tr <c:if test="${status.count%2 ne 0}">class="row100 body odd"</c:if> <c:if test="${status.count%2 eq 0}">class="row100 body even"</c:if> onclick="fnShowDetailModal('${item.organizationId}')">
				<td id="rownum" class="cell100 column1"><c:out value="${item.rownum}" escapeXml="false" /></td>
				<td id="organizationId" class="cell100 column2"><c:out value="${item.organizationId}" escapeXml="false" /></td>
				<td id="organization" class="cell100 column3"><c:out value="${item.organization}" escapeXml="false" /></td>
				<td id="locals" class="cell100 column4"><c:out value="${item.locals}" escapeXml="false" /></td>
				<td id="userCnt" class="cell100 column5"><c:out value="${item.userCnt}" escapeXml="false" /></td>
				<td id="sensorCnt" class="cell100 column6"><c:out value="${item.sensorCnt}" escapeXml="false" /></td>
				<td id="deviceCnt" class="cell100 column7"><c:out value="${item.deviceCnt}" escapeXml="false" /></td>
				<td id="personInCharge" class="cell100 column8"><c:out value="${item.personInCharge}" escapeXml="false" /></td>
				<td id="telNo" class="cell100 column9"><c:out value="${item.telNo}" escapeXml="false" /></td>
				<td id="email" class="cell100 column10"><c:out value="${item.email}" escapeXml="false" /></td>
				<td id="regDate" class="cell100 column11"><c:out value="${item.regDate}" escapeXml="false" /></td>
			</tr>	
				<input type="hidden" id="orgIdParam" name="orgIdParam"/>
		</c:forEach>
		</tbody>
	</c:otherwise>
	</c:choose>
	</table>	
	<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
	<input type="hidden" id="sortType" name="sortType" value="${sortType}">
	<input type="hidden" id="pageType" name="pageType" value="">
	<input type="hidden" id="page" name="page" value="${pagination.page}">
	<input type="hidden" id="range" name="range" value="${pagination.range}">
	<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
	<input type="hidden" id="idx" name="idx" value="${idx}">
</div>
</div>
    
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
    <div class="btn-area-type1">
    	<button type="button" id="modal_opne_btn" class="reg-btn icon-primary-small" onclick="fnShowRegModal()">등록</button>
    </div>
    </div>
    </div>
    </div>   
	<!-- 페이징 끝 -->
	
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
</body>
</html>
