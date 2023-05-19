<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지역 정보관리</title>

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
        
	<script type="text/javascript">
		
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
		    	fnCloseRegModal(); // 센서정보 등록 모달 닫기
		    	$("#modalMod").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
		    }
		});
		
		// 등록버튼 클릭시
		function fnShowRegModal() {
			//$("#modalRegist").attr("style", "display:block"); // 지역 등록 모달 팝업
			
			document.searchForm.action = '<c:url value="/local/localRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
		};
	   
		// 지역 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
			$("#registOrgId option:eq(0)").prop("selected", true);
			$("#inputLocalNm").val(""); // 지역명 초기화
			$("#inputLocalAddressMain").val(""); // 지역주소 메인 초기화
			$("#inputLocalAddressSub").val(""); // 지역주소 서브 초기화
			$("#localNxRegist").text(""); // X좌표 초기화
			$("#localNyRegist").text(""); // Y좌표 초기화
			$("input[name=fileUpload]").val(""); // 파일 업로드 초기화
			
			$("#modalRegist").attr("style", "display:none"); // 지역 등록 모달 닫기
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
			document.searchForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url
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
			    	orgId : $("#inputOrgId").val()
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
		
		// 지역 등록 모달에서 주소 검색 버튼 클릭시
		function fnAddressSearchingRegist() {
			new daum.Postcode({
		        oncomplete: function(data) {
		            $("#inputLocalAddressMain").val(data.address); // 가져온 주소 정보를 입력한다.
		            $("#inputLocalAddressSub").focus(); // 상세 주소로 커서 이동
		            
		            var query = $("#inputLocalAddressMain").val();
		            
		            // 검색한 주소를 이용해서 경도, 위도를 가져온다.
		            $.ajax({
		                url:'https://dapi.kakao.com/v2/local/search/address.json?query='+query,
		                type:'GET',
		                headers: {'Authorization' : 'KakaoAK 7922354c3406784c5fd1f738a9ceecd4'},
				        success:function(data){
				        	$("#localNxRegist").text(data.documents[0].road_address.x); // 경도
				        	$("#localNyRegist").text(data.documents[0].road_address.y); // 위도
				        },
				        error : function(e){
				            alert("경도, 위도 가져오기 실패")
				        }
				     });
		            
		            
		        }
		    }).open();
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
			var localNm = $("#inputLocalNm").val();
			var registOrgID = $("#registOrgId").val();
			var localAddressMain = $("#inputLocalAddressMain").val();
			var localAddressSub = $("#inputLocalAddressSub").val();
			var localNx = $("#localNxRegist").text();
			var localNy = $("#localNyRegist").text();
			
			if(localNm == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(localAddressMain == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(localAddressSub == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			}
			
			var data = new FormData($("#regForm")[0]); // 업로드할 파일
			data.append("localNm", localNm); // 지역명
			data.append("registOrgId", registOrgId); // 기관ID
			data.append("localAddressMain", localAddressMain); // 지역주소 메인
			data.append("localAddressSub", localAddressSub); // 지역주소 서브
			data.append("localNx", localNx); // X좌표
			data.append("localNy", localNy); // Y좌표
			
			
			$.ajax({
			    url: "/local/localSave.do",
			    type: "POST",
			    enctype: 'multipart/form-data',
			    async: true,
			    processData:false,
		        contentType:false,
			    //dataType: "json",
			    data:data,
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
		
		// 지역리스트에서 row 클릭시
		function fnShowModModal(localId) {
			
			$("#localIdParam").val(localId);
			
			document.searchForm.action = '<c:url value="/local/localDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
			
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
		
		// 지역 수정 모달에서 주소 검색 버튼 클릭시
		function fnAddressSearchingMod() {
			new daum.Postcode({
		        oncomplete: function(data) {
		            $("#localAddressMainMod").val(data.address); // 가져온 주소 정보를 입력한다.
		            $("#localAddressSubMod").focus(); // 상세 주소로 커서 이동
		            
					var query = $("#localAddressMainMod").val();
		            
		            // 검색한 주소를 이용해서 경도, 위도를 가져온다.
		            $.ajax({
		                url:'https://dapi.kakao.com/v2/local/search/address.json?query='+query,
		                type:'GET',
		                headers: {'Authorization' : 'KakaoAK 7922354c3406784c5fd1f738a9ceecd4'},
				        success:function(data){
				        	$("#localNxMod").text(data.documents[0].road_address.x); // 경도
				        	$("#localNyMod").text(data.documents[0].road_address.y); // 위도
				        },
				        error : function(e){
				            alert("경도, 위도 가져오기 실패")
				        }
				     });
		            
		        }
		    }).open();
		};
		
		function fnCheckBoxChange() {
			if($("#deleteViewMap").is(":checked")) { // 체크되었다면
				$("#deleteViewMapIsChecked").val("YES"); // 히든 객체에 YES 값을 저장
			} else {
				$("#deleteViewMapIsChecked").val("NO"); // 히든 객체에 NO 값을 저장
			}
		};
		
		// 지역 수정 모달에서 저장 버튼 클릭시
		function fnMod() {
			
			//console($('#fileUploadMod').get(0).files[0]); 파일이 여러개일 경우
			//console($('#fileUploadMod').get(0).files[1]); 파일이 여러개일 경우
			
			var orgIdMod = $("#orgIdMod").val();  // 기관ID
			var localIdMod = $("#localIdMod").val(); // 지역ID
			var localNmMod = $("#localNmMod").val(); // 지역명
			var localAddressMainMod = $("#localAddressMainMod").val(); // 지역주소 메인
			var localAddressSubMod = $("#localAddressSubMod").val(); // 지역주소 서브
			var localNxMod = $("#localNxMod").text(); // X좌표
			var localNyMod = $("#localNyMod").text(); // Y좌표
			var fileUploadMod = $("#fileUploadMod").val(); // 파일 값
			var deleteViewMapIsChecked = $("#deleteViewMapIsChecked").val(); // 히든 객체에 저장해둔 등록된 조감도 삭제 여부 값을 가져온다.
			
					
			
			var data = new FormData($("#modForm")[0]); // 업로드할 파일 저장
			data.append("orgIdMod", orgIdMod); // 기관ID
			data.append("localIdMod", localIdMod); // 지역ID
			data.append("localNmMod", localNmMod); // 지역명
			data.append("localAddressMainMod", localAddressMainMod); // 지역주소 메인
			data.append("localAddressSubMod", localAddressSubMod); // 지역주소 서브
			data.append("localNxMod", localNxMod); // X좌표
			data.append("localNyMod", localNyMod); // Y좌표
			data.append("fileUploadMod", fileUploadMod); // 업로드할 파일
			data.append("deleteViewMapIsChecked", deleteViewMapIsChecked); // 등록된 조감도 삭제 여부 값
			
			$.ajax({
			    url: "/local/localMod.do",
			    type: "POST",
			    enctype: 'multipart/form-data',
			    async: true,
			    processData:false,
		        contentType:false,
			    //dataType: "json",
			    data:data,
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
		
		// 지역 수정 모달에서 삭제 버튼 클릭시
		function fnDel() {			
			$.ajax({
			    url: "/local/localDelValidationCheck.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	localIdVal : $("#localIdMod").val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
					
			    	$("#localDelValidationCheck").val(data.localDelValidationCheck); // 서버에서 받아올 결과를 히든 객체에 넣어준다.
			    		
					if($("#localDelValidationCheck").val() == "false") { // 포함된 사용자, 센서 및 관수가 1개라도 있는 경우
			    		alert("포함된 사용자, 센서 및 관수가 있습니다.\n삭제 후 다시 시도하세요.");
			    		return false;
			    	} else {
			    		
			    		if(confirm("선택한 지역을 삭제 하시겠습니까?")) {
			    			
			    			// 예 버튼 클릭시 삭제 처리
			    			$.ajax({
							    url: "/local/localDel.do",
							    type: "POST",
							    async: true,
							    //dataType: "json",
							    data: {
							    	localIdDel : $("#localIdMod").val()
							    },
							    //contentType: "application/json",
							    success : function(data) {
						    		alert("삭제완료 하였습니다.");
							    	location.reload();
							    }, 
							    error : function(arg){
									alert("지역 삭제 실패");
								
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
		
		// 이미지 파일이 아닌 경우 경고창
		function fnFileChange(obj) {
			var fileExtension = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
		      if ($.inArray($(obj).val().split('.').pop().toLowerCase(), fileExtension) == -1) {
			        alert("이미지 파일만 업로드 가능합니다. (" + fileExtension.join(", ") + ")");
			        $("input[name=fileUpload]").val("");
		      }
		};
		
		// 위치확인 버튼 클릭시
		function fnDisplayViewMap(localId, count) {
			
			$("#viewMapLocalId").val(localId);
			
			const openWindow = window.open('/local/viewMap.do','viewMapPopUp','scrollbars=yes, resizable=no, width=900, height=800, left=0, top=0');
			
			/*
			$.ajax({
			    url: "/local/viewMap",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	localId : localId
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	const openWindow = window.open('/local/viewMap.do','viewMapPopUp','scrollbars=yes, resizable=no, width=900, height=800, left=0, top=0');
			    	$("#viewMap").val(data);
			    }, 
			    error : function(arg){
				alert("조감도 위치확인 실패");
				
			    }
			});	
			*/
			
			
		};
		
		// 업로드할 파일 선택시 
		function fnCheckFileName(obj){
			var str = obj.value;
		    //1. 확장자 체크
		    var ext =  str.split('.').pop().toLowerCase();
		    if($.inArray(ext, ['jpg', 'jpeg', 'png', 'bmp', 'html', 'htm']) == -1) {
		        //alert(ext);
		        alert(ext+'파일은 업로드 하실 수 없습니다.');
		        obj.value = "";
		        return false;
		    }
			
		    /*
		    //2. 파일명에 특수문자 체크
		    var pattern =   /[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi;
		    if(pattern.test(str) ){
		        //alert("파일명에 허용된 특수문자는 '-', '_', '(', ')', '[', ']', '.' 입니다.");
		        //alert('파일명에 특수문자를 제거해주세요.');
		        //obj.value = "";
		        obj.value = obj.value.replaceAll(/[\{\}\/?,;:|*~`!^\+<>@\#$%&\\\=\'\"]/gi, '');
		        return false;
		    }
		    */
		};
		
		// 엑셀 다운로드 버튼 클릭시
		function fnLocalExcelDown(form) {
			form.action = '<c:url value="/local/excel.do"/>';
			form.submit();
		};
		
		
		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/local/localList.do"/>';
			document.searchForm.submit();
		}
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/local/localList.do"/>';
			document.searchForm.submit();
		}
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/local/localList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/local/localList.do"/>';
			document.searchForm.submit();
		}
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/local/localList.do"/>';
			document.searchForm.submit();
		}
		
	</script>
</head>
<body>

<%@ include file="/WEB-INF/views/menu.jsp" %>

<div class="sh-main">
      <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">지역 관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">지역 관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">지역</span> 
              <span class="depth-menu body-1-bold">지역 관리</span>
            </p>
        </div>
      </div>
      
    
	<form id="searchForm" name="searchForm" action="/local/localList.do" method="post">
	<div class="sh-content">
		<div class="condition-search">
	    <div class="list-box">
		<div class="search-second-condition con-title">
	    <span style="position:relative;"  >기관명</span>
		<select class="dropdown-sel search-sel ml-2" style="position:relative;" id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)">
			<option value="total">전체</option>
			<c:choose>
			<c:when test="${'total' eq searchingOrgId}">
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
	    <span >지역명</span>
		<select class="dropdown-sel search-sel ml-2"  style="position:relative;" id="searchingLocalId" name="searchingLocalId">
			<option value="total" selected>전체</option>
			<c:choose>
			<c:when test="${'total' eq searchingLocalId}">
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
		<div class="search-forth-condition">
			<button class="icon-primary-small btn-search" id="search" onclick="javascript:fnDetailSearch(1)">검색</button>
		</div>
		</div>
	</div>
	    <div class="main-content" headline="Stats">
	          <div class="res-main-top no-txt">
				<button class="actibody-2-bold  excel-btn" onclick="fnLocalExcelDown(this.form)">엑셀다운로드</button>
			  </div>
	
	<!-- table -->
    <div class="wrap-table">
    	<div class="table100 ver1">
                
        <div class="wrap-table100-nextcols js-pscroll">
        <div class="table100-nextcols">
		<table id="orgList">
		<thead>
			<tr class="row100 head body-2-bold ">
				<th class="column1" onclick="fnHeaderClick(1)">번호</th>
				<th class="column2" onclick="fnHeaderClick(2)">기관명</th>
				<th class="column3" onclick="fnHeaderClick(3)">지역명</th>
				<th class="column4" onclick="fnHeaderClick(4)">주소</th>
				<th class="column5" onclick="fnHeaderClick(5)">경도</th>
				<th class="column6" onclick="fnHeaderClick(6)">위도</th>
				<th class="column7" >위치확인</th>
				<th class="column8" onclick="fnHeaderClick(7)">등록일(수정일)</th>
			</tr>
		</thead>
		<c:choose>
		<c:when test="${empty localList}">
			<tbody id="tbody">
				<tr>
					<th colspan="7">
						조회된 결과가 없습니다.
					</th>
				</tr>
			</tbody>
		</c:when>
		<c:otherwise>
			<tbody id="tbody">
			<c:forEach var="item" items="${localList}" varStatus="status">
				<tr <c:if test="${status.count%2 ne 0}">class="row100 body odd"</c:if> <c:if test="${status.count%2 eq 0}">class="row100 body even"</c:if>>
					<td class="column1" id="rownum" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.rownum}" /></td>
					<td class="column2" id="organization" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.organization}" escapeXml="false" /></td>
					<td class="column3" id="local" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.local}" escapeXml="false" /></td>
					<td class="column4" id="localAddress" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.localAddress}" escapeXml="false" /></td>
					<td class="column5" id="localNx" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.localNx}" escapeXml="false" /></td>
					<td class="column6" id="localNy" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.localNy}" escapeXml="false" /></td>
					<td class="column7" id="locationConfirm"><span class="off-btn" id="locationConfirmBtn" onclick="fnDisplayViewMap('${item.localId}')">위치확인</span></td>
					<td class="column8" id="regDateTime" onclick="fnShowModModal('${item.localId}')"><c:out value="${item.regDate}" escapeXml="false" /></td>
				</tr>		
			</c:forEach>
			</tbody>
		</c:otherwise>
		</c:choose>
			<input type="hidden" id="localIdParam" name="localIdParam"/>
		</table>		
	<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn }">
	<input type="hidden" id="sortType" name="sortType" value="${sortType}">
	<input type="hidden" id="pageType" name="pageType" value="${pageType}">
	<input type="hidden" id="page" name="page" value="${pagination.page}">
	<input type="hidden" id="range" name="range" value="${pagination.range}">
	<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
	<input type="hidden" id="startPage" name="startPage" value="${pagination.startPage}">
	<input type="hidden" id="endPage" name="endPage" value="${pagination.endPage}">
	<input type="hidden" id="lastPage" name="lastPage" value="${pagination.lastPage}">
	<input type="hidden" id="lastRange" name="lastRange" value="${pagination.lastRange}">
	<input type="hidden" id="idx" name="idx" value="${idx}">
	<input type="hidden" id="pagination" name="pagination" value="${pagination}">
	
	<input type="hidden" id="viewMapLocalId" name="viewMapLocalId">
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
		<button class="reg-btn icon-primary-small" id="modal_opne_btn" onclick="fnShowRegModal()">등록</button>
    </div>
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
