<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
/**
 * @Class Name : sensorControlList.jsp
 * @Description : 센서설정 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @
 */
%>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>센서 설정관리</title>
 
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
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
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<style>
		
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
		
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
		    	$("#modalRegist").attr("style", "display:none"); // 센서정보 등록 모달 팝업
		    	$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
		    	$("#modalMod").attr("style", "display:none"); // 센서정보 수정조회 모달 닫기
		    }
		});
		
		// 등록버튼 클릭시
		function fnShowRegModal() {
			$("#modalRegist").attr("style", "display:block"); // 센서정보 등록 모달 팝업
		};
	   
		// 센서정보 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
			$("#modalRegist").attr("style", "display:none"); // 센서정보 등록 모달 닫기
		};
		
		// 게시판 헤더 클릭시 정렬
		function fnHeaderClick(column) {
			if($("#sortType").val() == "desc") { // 정렬방식이 내림차순일 경우
		    	$("#sortType").val("asc"); // 정렬방식을 오름차순으로 변경(""))
		    } else {
		    	$("#sortType").val("desc"); // 정렬방식을 내림차순으로 변경
		    }
		    $("#sortColumn").val(column); // 컬럼 정보 저장
		    $("#searchForm").submit(); // 서버로 전송
			
		};
	
		// 센서정보 검색
		function fnDetailSearch(form){
			form.action = '<c:url value="/sensorControl/sensorControlList.do"/>'; // 전송 url
			form.submit(); // 서버로 전송
			
		};
				
		// 센서명 콤보박스 변경시
		function fnOrgNmChange(e){
			$.ajax({
			    url: "/orgInfo/localNmList.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	searchingOrgId : $("#orgNm").val(), // 콤보박스에서 선택된 항목의 센서ID
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
				$("#localNmRegist").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNmRegist").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
				}

			    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
				
			    }
			})
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
				$("#localNmMod").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.listSize ; i++) {
					$("#localNmMod").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
				}

			    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
				
			    }
			})
		};
		
		// 센서정보 리스트에서 row 클릭시
		function fnShowDetailModal(sensorId) {
			
			
			/*
			$.ajax({
			    url: "/sensorControl/sensorControlDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	sensorId : sensorId,
			    	num : num
			    },
			    //contentType: "application/json",
			    success : function(data) {
				    
			    	$("#modalDetail").attr("style", "display:block"); // 센서정보 상세조회 모달 팝업
			    	
			    	// 각 항목 초기화
		    	 	$("#sensorIdDetail").text("");
				    $("#sensorNmDetail").text("");
				    $("#batteryMin").val("");
				    $("#batteryMax").val("");
				    $("#tempeeratureMin").val("");
				    $("#tempeeratureMax").val("");
				    $("#humidityMin").val("");
				    $("#humidityMax").val("");
				    $("#pHMin").val("");
				    $("#pHMax").val("");
				    $("#ECMin").val("");
				    $("#ECMax").val("");
				    $("#NMin").val("");
				    $("#NMax").val("");
				    $("#PMin").val("");
				    $("#PMax").val("");
				    $("#KMin").val("");
				    $("#KMax").val("");
				    $("#num").val("");
				    
				    
				    // 위에서 초기화한 이후 값을 넣어준다.
				    $("#sensorIdDetail").text(data.sensorControlDetail.sensorId);
				    $("#sensorNmDetail").text(data.sensorControlDetail.sensor);
				    $("#batteryMin").val(data.sensorControlDetail.batcapremaValueMin);
				    $("#batteryMax").val(data.sensorControlDetail.batcapremaValueMax);
				    $("#temperatureMin").val(data.sensorControlDetail.tempValueMin);
				    $("#temperatureMax").val(data.sensorControlDetail.tempValueMax);
				    $("#humidityMin").val(data.sensorControlDetail.humiValueMin);
				    $("#humidityMax").val(data.sensorControlDetail.humiValueMax);
				    $("#pHMin").val(data.sensorControlDetail.conducValueMin);
				    $("#pHMax").val(data.sensorControlDetail.conducValueMax);
				    $("#ECMin").val(data.sensorControlDetail.phValueMin);
				    $("#ECMax").val(data.sensorControlDetail.phValueMax);
				    $("#NMin").val(data.sensorControlDetail.nitroValueMin);
				    $("#NMax").val(data.sensorControlDetail.nitroValueMax);
				    $("#PMin").val(data.sensorControlDetail.phosValueMin);
				    $("#PMax").val(data.sensorControlDetail.phosValueMax);
				    $("#KMin").val(data.sensorControlDetail.potaValueMin);
				    $("#KMax").val(data.sensorControlDetail.potaValueMax);
				    $("#num").val(data.sensorControlDetail.num);
				    if(data.sensorControlDetail.alarmYn == "Y") {
				    	$("input:radio[name='alarmYn']:radio[value='ON']").prop('checked', true); // 선택하기
					    $("input:radio[name='alarmYn']:radio[value='OFF']").prop('checked', false); // 해제하기	
				    } else {
				    	$("input:radio[name='alarmYn']:radio[value='ON']").prop('checked', false); // 해제하기
					    $("input:radio[name='alarmYn']:radio[value='OFF']").prop('checked', true); // 선택하기
				    }
				    
				    
			    }, 
			    error : function(arg){
				alert("센서정보 상세조회 실패");
				
			    }
			});
			*/
			
			$("#sensorIdParam").val(sensorId);
			
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
			
		};
		
		// 센서정보 상세조회 모달에서 취소 버튼 클릭시
		function fnCloseDetailModal() {
			$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
		};
		
		// 센서정보 상세조회에서 수정 버튼 클릭시
		function fnShowModModal() {
			
			$.ajax({
			    url: "/sensorInfo/sensorInfoModDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	sensorId : $("#sensorIdDetail").text(),
			    	num : $("#num").val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    
			   		$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
			   		$("#modalMod").attr("style", "display:block"); // 센서정보 수정조회 모달 팝업
			   		
			   		// 값을 초기화 해준다.
			   		$("#sensorIdMod").text("");
			   		$("#sensorNmMod").val("");
			   		$("#chipIdMod").val("");
			   		$("#textArea_byteLimitMod").val("");
				    
				    // 위에서 초기화후 값을 넣어준다.
				    $("#sensorIdMod").text(data.sensorInfoModDetail.sensorId);
			   		$("#sensorNmMod").val(data.sensorInfoModDetail.sensor);
			   		$("#chipIdMod").val(data.sensorInfoModDetail.chipId);
				    $("#orgNmMod").val(data.sensorInfoModDetail.organizationId);
				    $("#localNmMod").val(data.sensorInfoModDetail.localId);
				    $("#textArea_byteLimitMod").val(data.sensorInfoModDetail.sensorDetail);
				    
			    }, 
			    error : function(arg){
				alert("센서정보 수정조회 실패");
				
			    }
			});
			
		};
		
		// 센서정보 수정에서 이메일 콤보박스 변경시
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
		
		// 센서정보 수정 모달에서 저장 버튼 클릭시
		function fnMod() {
			var sensorId = $("#sensorIdDetail").text();
			var alarmYn;
			if($("input[type=radio][id=alarmY]:checked").is(':checked')) { // 알람 여부 라디오 버큰 체크 여부 확인
				alarmYn = "Y";
			} else {
				alarmYn = "N";
			}
			var num = $("#num").val();
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
			    	num : num,
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
					$("#modalMod").attr("style", "display:none"); // 센서정보 수정조회 모달 닫기
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
		
		// 센서정보 수정 모달에서 취소 버튼 클릭시
		function fnCloseModModal() {
			$("#modalMod").attr("style", "display:none"); // 센서정보 수정 모달 닫기
		};
		
		// 센서정보 상세 모달에서 삭제 버튼 클릭시
		function fnDel() {
			
			if(confirm("선택한 센서을 삭제 하시겠습니까?")) {
				$.ajax({
				    url: "/sensorInfo/sensorInfoDel.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	sensorId : $("#sensorIdDetail").text()
				    },
				    //contentType: "application/json",
				    success : function(data) {
				    	if(data.delResult) {
				    		alert("삭제완료 하였습니다.");
					    	fnCloseDetailModal(); // 센서정보 상세 모달 닫기
					    	location.reload(); // 페이지 새로고침	
				    	} else {
				    		alert("삭제실패 하였습니다.");
				    		return false;
				    	}
				    	
				    }, 
				    error : function(arg){
					alert("센서정보 삭제 실패");
					
				    }
				});		
			}
			
			
			
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
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
            });                    
            
            //초기값을 오늘 날짜로 설정
            $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
        });
		
		//등록시 textarea 바이트 수 체크하는 함수
		function fnCheckByte(obj){
		    const maxByte = 100; //최대 100바이트
		    const text_val = obj.value; //입력한 문자
		    const text_len = text_val.length; //입력한 문자수
		    
		    let totalByte=0;
		    for(let i=0; i<text_len; i++){
		    	const each_char = text_val.charAt(i);
		        const uni_char = escape(each_char); //유니코드 형식으로 변환
		        if(uni_char.length>4){
		        	// 한글 : 2Byte
		            totalByte += 2;
		        }else{
		        	// 영문,숫자,특수문자 : 1Byte
		            totalByte += 1;
		        }
		    }
		    
	    	if(totalByte>maxByte){
	    		alert('최대 100Byte까지만 입력가능합니다.');
	    		obj.value = obj.value.substr(0, obj.value.length-2);
	    		text_val = text_val.substr(0, text_len-2);
	        	document.getElementById("textareaByteCnt").innerText = totalByte;
	            document.getElementById("textareaByteCnt").style.color = "red";
	        }else{
	        	document.getElementById("textareaByteCnt").innerText = totalByte;
	            document.getElementById("textareaByteCnt").style.color = "green";
	        }
		}
		
		//수정조회시 textarea 바이트 수 체크하는 함수
		function fnCheckByteMod(obj){
		    const maxByte = 100; //최대 100바이트
		    const text_val = obj.value; //입력한 문자
		    const text_len = text_val.length; //입력한 문자수
		    
		    let totalByte=0;
		    for(let i=0; i<text_len; i++){
		    	const each_char = text_val.charAt(i);
		        const uni_char = escape(each_char); //유니코드 형식으로 변환
		        if(uni_char.length>4){
		        	// 한글 : 2Byte
		            totalByte += 2;
		        }else{
		        	// 영문,숫자,특수문자 : 1Byte
		            totalByte += 1;
		        }
		    }
		    
	    	if(totalByte>maxByte){
	    		alert('최대 100Byte까지만 입력가능합니다.');
	    		obj.value = obj.value.substr(0, obj.value.length-2);
	    		text_val = text_val.substr(0, text_len-2);
	        	document.getElementById("textareaByteCntMod").innerText = totalByte;
	            document.getElementById("textareaByteCntMod").style.color = "red";
	        }else{
	        	document.getElementById("textareaByteCntMod").innerText = totalByte;
	            document.getElementById("textareaByteCntMod").style.color = "green";
	        }
		}
		
		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>';
			document.searchForm.submit();
		}
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>';
			document.searchForm.submit();
		}
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>';
			document.searchForm.submit();
		}
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensorControl/sensorControlList.do"/>';
			document.searchForm.submit();
		}
		
	
		// 엑셀 다운로드 버튼 클릭시
		function fnSensorControlExcelDown(form) {
			form.action = '<c:url value="/sensorControl/excel.do"/>';
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
          <h2 class="responsive-title-txt h4-bold">센서 설정관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">센서 설정관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">센서</span> 
              <span class="depth-menu body-1-bold">센서 설정관리</span>
            </p>
        </div>
      </div>  
		
	<div class="sh-content">
	<form id="searchForm" name="searchForm" action="/sensorControl/sensorControlList.do" method="post">
	<div class="condition-search-with-txt">
	    <div class="list-box-with-txt">
    <div class="search-first-condition-one con-title">
    <div class="con-title">
		<span style="position:relative;">기관명</span>
		<select class="dropdown-sel search-sel ml-2" style="position:relative;" id="orgNm" name="orgNm" onchange="fnOrgNmChange(this)">
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
	</div>
	</div>
	<div class="search-second-condition con-title">
		<span style="position:relative;">지역명</span>
		<select class="dropdown-sel search-sel ml-2"  style="position:relative;" id="localNm" name="localNm">
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
	</div>
	<div class="search-third-condition-date con-title">
		<select class="select-srch" id="searchingType" name="searchingType">
			<option value="sensorNm" <c:if test="${searchingType eq 'sensorNm'}">selected</c:if> >센서 명</option>
			<option value="sensorId" <c:if test="${searchingType eq 'sensorId'}">selected</c:if> >센서 ID</option>
			<option value="chipId" <c:if test="${searchingType eq 'chipId'}">selected</c:if> >유심코드</option>
		</select>
		<input type="text" class="search-sel input-search-two" placeholder="내용을 입력하세요." name="searchingContent" value="${searchingContent}"/>
	</div>
	<div class="search-forth-condition">
		<button class="icon-primary-small btn-search" id="search" onclick="javascript:fnDetailSearch(this.form)">검색</button>
	</div>
    </div>
    </div>
	<div class="main-content" headline="Stats">
          <div class="res-main-top no-txt">
			<button type="button" class="actibody-2-bold excel-btn" onclick="fnSensorControlExcelDown(this.form)">엑셀다운로드</button>
          </div>
    <!-- table -->
    <div class="wrap-table">
    <div class="table100 ver1">     
    <div class="wrap-table100-nextcols js-pscroll">
    <div class="table100-nextcols">
	<table>
	<thead>
	<tr class="row100 head body-2-bold ">
		<th class="column1-sensor" id="1" onclick="fnHeaderClick(1)">번호</th>
		<th class="column2-sensor" id="2" onclick="fnHeaderClick(2)">센서ID</th>
		<th class="column3-sensor" id="3" onclick="fnHeaderClick(3)">센서명</th>
		<th class="column4-sensor" id="4" onclick="fnHeaderClick(4)">관수ID</th>
		<th class="column5-sensor" id="5" onclick="fnHeaderClick(5)">관수명</th>
		<th class="column6-sensor" id="6" onclick="fnHeaderClick(6)">유심번호</th>
		<th class="column7-sensor" id="7" onclick="fnHeaderClick(7)">지역명</th>
		<th class="column8-sensor" id="8" onclick="fnHeaderClick(8)">기관명</th>
		<th class="column9-sensor" id="9" onclick="fnHeaderClick(9)">배터리(%)</th>
		<th class="column10-sensor" id="10" onclick="fnHeaderClick(10)">온도(℃)</th>
		<th class="column11-sensor" id="11" onclick="fnHeaderClick(11)">습도(%)</th>
		<th class="column12-sensor" id="12" onclick="fnHeaderClick(12)">산도(PH)</th>
		<th class="column13-sensor" id="13" onclick="fnHeaderClick(13)">전도도(ds/m)</th>
		<th class="column14-sensor" id="14" onclick="fnHeaderClick(14)">질소(mg/kg)</th>
		<th class="column15-sensor" id="15" onclick="fnHeaderClick(15)">인(mg/kg)</th>
		<th class="column16-sensor" id="16" onclick="fnHeaderClick(16)">칼륨(cmol/kg)</th>
		<th class="column17-sensor" id="17" onclick="fnHeaderClick(17)">알림설정</th>
	</tr>
	</thead>
	<c:choose>
	<c:when test="${empty sensorControlList}">
		<tbody id="tbody">
			<tr class="row100 body odd">
				<th colspan="8">
					조회된 결과가 없습니다.
				</th>
			</tr>
		</tbody>
	</c:when>
	<c:otherwise>
		<tbody>
		<c:forEach var="item" items="${sensorControlList}" varStatus="status">
			<tr align="center" <c:if test="${status.count%2 ne 0}">class="row100 body odd"</c:if> <c:if test="${status.count%2 eq 0}">class="row100 body even"</c:if> onclick="fnShowDetailModal('${item.sensorId}', '${item.num}')">
				<td class="column1" id="rownum"><span class="res-td body-3-bold">번호</span><span class="res-table-content"><c:out value="${item.rownum}" escapeXml="false"/></span></td>
				<td class="column2" id="sensorId"><span class="res-td body-3-bold">센서ID</span><span class="res-table-content"><c:out value="${item.sensorId}" escapeXml="false"/></span></td>
				<td class="column3" id="sensor"><span class="res-td body-3-bold">센서명</span><span class="res-table-content"><c:out value="${item.sensor}" escapeXml="false" /></span></td>
				<td class="column4" id="irrigationId"><span class="res-td body-3-bold">관수ID</span><span class="res-table-content"><c:out value="${item.irrigationId}" escapeXml="false" /></span></td>
				<td class="column5" id="irrigationName"><span class="res-td body-3-bold">관수명</span><span class="res-table-content"><c:out value="${item.irrigationName}" escapeXml="false" /></span></td>
				<td class="column6" id="usimId"><span class="res-td body-3-bold">유심코드</span><span class="res-table-content"><c:out value="${item.usimId}" escapeXml="false" /></span></td>
				<td class="column7" id="local"><span class="res-td body-3-bold">지역명</span><span class="res-table-content"><c:out value="${item.local}" escapeXml="false" /></span></td>
				<td class="column8" id="organization"><span class="res-td body-3-bold">기관명</span><span class="res-table-content"><c:out value="${item.organization}" escapeXml="false" /></span></td>
				<td class="column9" id="batcaprema"><span class="res-td body-3-bold">베터리(%)</span><span class="res-table-content"><c:out value="${item.batcaprema}%" escapeXml="false" /></span></td>
				<td class="column10" id="temp"><span class="res-td body-3-bold">온도(℃)</span><span class="res-table-content"><c:out value="${item.temp}˚C" escapeXml="false" /></span></td>
				<td class="column11" id="humi"><span class="res-td body-3-bold">습도(%)</span><span class="res-table-content"><c:out value="${item.humi}%" escapeXml="false" /></span></td>
				<td class="column12" id="ph"><span class="res-td body-3-bold">산도(PH)</span><span class="res-table-content"><c:out value="${item.ph}PH" escapeXml="false" /></span></td>
				<td class="column13" id="conduc"><span class="res-td body-3-bold">전도도(ds/m)</span><span class="res-table-content"><c:out value="${item.conduc}ds/m" escapeXml="false" /></span></td>
				<td class="column14" id="nitro"><span class="res-td body-3-bold">질소(mg/kg)</span><span class="res-table-content"><c:out value="${item.nitro}mg/kg" escapeXml="false" /></span></td>
				<td class="column15" id="phos"><span class="res-td body-3-bold">인(mg/kg)</span><span class="res-table-content"><c:out value="${item.phos}mg/kg" escapeXml="false" /></span></td>
				<td class="column16" id="pota"><span class="res-td body-3-bold">칼륨(cmol/kg)</span><span class="res-table-content"><c:out value="${item.pota}cmol/kg" escapeXml="false" /></span></td>
				<td class="column17" id="alarmYn"><span class="res-td body-3-bold">알림 설정</span><span class="res-table-content"><span class="on-btn"><c:out value="${item.alarmYn}" escapeXml="false" /></span></span></td>
			</tr>	
		</c:forEach>
		</tbody>
	</c:otherwise>
	</c:choose>
	</table>
	<input type="hidden" id="sensorIdParam" name="sensorIdParam"/>
	<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn }">
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
    </div>
    </div>
    </div>
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
-->
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
</div>

<script src="https://cpwebassets.codepen.io/assets/common/stopExecutionOnTimeout-2c7831bb44f98c1391d6a4ffda0e1fd302503391ca806e7fcc7b9b87197aec26.js"></script>

  
      <script id="rendered-js" >
// dropdown Menu
  var res_dropdown = document.querySelectorAll('.dropdown');
  var res_dropdownArray = Array.prototype.slice.call(res_dropdown, 0);
res_dropdownArray.forEach(function (el) {
  var button = el.querySelector('a[data-toggle="dropdown"]'),
  menu = el.querySelector('.dropdown-menu'),
  //arrow = button.querySelector('i.icon-arrow');

  button.onclick = function (event) {
    if (!menu.hasClass('show')) {

      menu.classList.add('show');
      menu.classList.remove('hide');

     // arrow.classList.add('open');
     // arrow.classList.remove('close');
      event.preventDefault();
    } else
    {
    // 

      menu.classList.remove('show');
      menu.classList.add('hide');
     // arrow.classList.remove('open');
      //arrow.classList.add('close');
      // $("#aaa").trigger("click");
       
event.preventDefault();
    }
  };

  
});

Element.prototype.hasClass = function (className) {
  return this.className && new RegExp("(^|\\s)" + className + "(\\s|$)").test(this.className);
};
//# sourceURL=pen.js
    </script>

 
</body>
</html>