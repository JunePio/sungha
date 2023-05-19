<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : irrigationInfoList.jsp
 * @Description : 관수제어 현장정보 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  이창호      최초생성
 * @ 2023.05.08  이준영
 */
%>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>관수제어 > 현장정보</title>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="/static/assets/js/common.js"></script>
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
		
		/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
		.ui-datepicker-trigger{cursor: pointer;}
		/*datepicer input 롤오버 시 손가락 모양 표시*/
		.hasDatepicker{cursor: pointer;}
    </style>
	<script type="text/javascript">
	
	// 등록버튼 클릭시
	function fnShowRegModal() {
		$("#modalRegist").attr("style", "display:block"); // 기관정보 등록 모달 팝업
	};
	
	// 관수정보 등록 모달창에서 취소 버튼 클릭시
	function fnCloseRegModal() {
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
	    $("#SearchForm").submit(); // 서버로 전송
		
	};
	
	//  관수정보 검색
	function fnDetailSearch(pageNo){
		document.SearchForm.action = '<c:url value="/irrigation/irrigationInfoList.do"/>';
		document.SearchForm.submit();  // 서버로 전송
	};
	
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
	
	// 저장버튼 클릭시
	function fnSave(){
		var irrigationId = $("#inputIrrigationId").val();
		var irrigation = $("#inputIrrigation").val();
		var streamTime = $("#inputStreamTime").val();
		var streamFlow = $("#inputStreamFlow").val();
		var nutrientTime = $("#inputNutrientTime").val();
		var nutrientSolution = $("#inputNutrientSolution").val();
		var organizationId = $("#inputOrganizationId").val();
		var dupResult = $("#dupResult").val();
		
		if(irrigationId == "") {
			alert("관수ID는 필수 입력사항입니다.");
			return false;
		} else if(irrigation == "") {
			alert("관수명은 필수 입력사항입니다.");
			return false;
		} else if(organizationId == "") {
			alert("현장ID는 필수 입력사항입니다.");
			return false;
		} else if(dupResult == "dupCheckNo") {
			alert("관수ID 중복확인을 해주세요.");
			return false;			
		}

		$.ajax({
		    url: "/irrigation/irrigationInfoSave.do",
		    type: "POST",
		    async: true,
		    data: {	    	
		    	irrigationId : irrigationId,
				irrigation : irrigation,
				streamTime : streamTime,
				streamFlow : streamFlow,
				nutrientTime : nutrientTime,
				nutrientSolution : nutrientSolution,
				organizationId : organizationId
		    },
		    success : function(data) {
				if(data.saveResult) {
					alert("저장완료 하였습니다.")
					location.reload();		
				} else {
					alert("저장실패 하였습니다..")
				}
		    }, 
		    error : function(arg){
				alert("통신실패시에만 실행");
				alert(JSON.stringify(arg));
		    }
		})
	};
	
	// 관수정보 리스트에서 row 클릭시
	function fnShowDetailModal(irrigationId) {
		
			
			$.ajax({
			    url: "/irrigation/irrigationInfoDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	irrigationId : irrigationId
			    },
			    //contentType: "application/json",
			    success : function(data) {
				    
			    	$("#modalDetail").attr("style", "display:block"); // 관수정보 상세조회 모달 팝업
			    	
			    	// 각 항목 초기화
		    	 	$("#irrigationIdDetail").text("");
				    $("#irrigationNmDetail").text("");
				    $("#streamTimeDetail").text("");
				    $("#streamFlowDetail").text("");
				    $("#nutrientTimeDetail").text("");
				    $("#nutrientSolutionDetail").text("");
				    $("#organizationIdDetail").text("");
				    
				    // 위에서 초기화한 이후 값을 넣어준다.			    
				    /* $("#irrigationIdDetail").text(data.irrigationInfoDetail.irrigationId);
				    $("#irrigationDetail").text(data.irrigationInfoDetail.irrigation);
				    $("#streamTimeDetail").text(data.irrigationInfoDetail.streamTime);
				    $("#streamFlowDetail").text(data.irrigationInfoDetail.streamFlow);
				    $("#nutrientTimeDetail").text(data.irrigationInfoDetail.nutrientTime);
				    $("#nutrientSolutionDetail").text(data.irrigationInfoDetail.nutrientSolution);
				    $("#organizationIdDetail").text(data.irrigationInfoDetail.organizationId); */
				    
				    $("#irrigationIdDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.irrigationId));
				    $("#irrigationDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.irrigation));
				    $("#streamTimeDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.streamTime));
				    $("#streamFlowDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.streamFlow));
				    $("#nutrientTimeDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.nutrientTime));
				    $("#nutrientSolutionDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.nutrientSolution));
				    $("#organizationIdDetail").text(onGetUnescapeXSS(data.irrigationInfoDetail.organizationId));
			    }, 
			    error : function(arg){
				alert("관수정보 상세조회 실패");
				
			    }
			    
			});
			
		};
				
		// 관수정보 상세조회 모달에서 취소 버튼 클릭시
		function fnCloseDetailModal() {
			$("#modalDetail").attr("style", "display:none"); // 관수정보 상세조회 모달 닫기
		};
		
		// 관수정보 상세조회에서 수정 버튼 클릭시
		
		function fnShowModModal() {
			
			$.ajax({
			    url: "/irrigation/irrigationInfoModDetail.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	irrigationId : $("#irrigationIdDetail").text()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    
			   		$("#modalDetail").attr("style", "display:none"); // 관수정보 상세조회 모달 닫기
			   		$("#modalMod").attr("style", "display:block"); // 관수정보 수정조회 모달 팝업
			
			   		// 값을 초기화 해준다.
			   		$("#irrigationIdMod").val("");
			   		$("#irrigationNmMod").val("");
			   		$("#streamTimeMod").val("");
			   		$("#streamFlowMod").val("");
				    $("#nutrientTimeMod").val("");
				    $("#nutrientSolutionMod").val("");
				    $("#organizationIdMod").val("");
				    
				    // 위에서 초기화후 값을 넣어준다.
				    /* $("#irrigationIdMod").val(data.irrigationInfoModDetail.irrigationId);
				    $("#irrigationMod").val(data.irrigationInfoModDetail.irrigation);
				    $("#streamTimeMod").val(data.irrigationInfoModDetail.streamTime);
				    $("#streamFlowMod").val(data.irrigationInfoModDetail.streamFlow);
				    $("#nutrientTimeMod").val(data.irrigationInfoModDetail.nutrientTime);
				    $("#nutrientSolutionMod").val(data.irrigationInfoModDetail.nutrientSolution);
				    $("#organizationIdMod").val(data.irrigationInfoModDetail.organizationId); */
				    
				    $("#irrigationIdMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.irrigationId));
				    $("#irrigationMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.irrigation));
				    $("#streamTimeMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.streamTime));
				    $("#streamFlowMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.streamFlow));
				    $("#nutrientTimeMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.nutrientTime));
				    $("#nutrientSolutionMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.nutrientSolution));
				    $("#organizationIdMod").val(onGetUnescapeXSS(data.irrigationInfoModDetail.organizationIdMod));
				    
			    }, 
			    error : function(arg){
				alert("관수정보 수정조회 실패");
			    }
			});	
		}; 


		// 관수정보 수정 모달에서 저장 버튼 클릭시
		function fnMod() {
			
			$.ajax({
			    url: "/irrigation/irrigationInfoMod.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	irrigationIdDetail : $("#irrigationIdDetail").text(),
			    	irrigationId : $("#irrigationIdMod").val(),
			    	irrigation : $("#irrigationMod").val(),
			    	streamTime : $("#streamTimeMod").val(),
			    	streamFlow : $("#streamFlowMod").val(),
			    	nutrientTime : $("#nutrientTimeMod").val(),
			    	nutrientSolution : $("#nutrientSolutionMod").val(),
			    	organizationId : $("#organizationIdMod").val()
			    },
			    success : function(data) {
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
		
		// 관수정보 수정 모달에서 취소 버튼 클릭시
		function fnCloseModModal() {
			$("#modalMod").attr("style", "display:none"); // 기관정보 수정 모달 닫기
		};
		
		// 관수정보 상세 모달에서 삭제 버튼 클릭시
		function fnDel() {

			if(confirm("선택한 관수정보를 삭제 하시겠습니까?")) {
				$.ajax({
				    url: "/irrigation/irrigationInfoDel.do",
				    type: "POST",
				    async: true,
				    data: {
				    	irrigationId : $("#irrigationIdDetail").text()
				    },
				    success : function(data) {
				    	alert("삭제완료 하였습니다.")
				    	fnCloseDetailModal(); // 기관정보 상세 모달 닫기
				    	location.reload(); // 페이지 새로고침
				    }, 
				    error : function(arg){
						alert("관수정보 삭제 실패");
				    }
				});		
			}
		};

		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		};
		
		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		};
	
		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		};
	
		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		};
		
		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/irrigation/irrigationList.do"/>';
			document.searchForm.submit();
		};
		
		// 엑셀 다운로드
		function fnExcelDown(){
		   	document.SearchForm.action = "<c:url value='/irrigation/point.do?excelDownload=true'/>";
	       	document.SearchForm.submit();
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
						<span class="depth-menu body-1-bold">관수정보</span>
					</p>
				</div>
			</div>
			<div class="sh-content">
				<div class="main-content" headline="Stats">
<form id="SearchForm" name="SearchForm" action="/irrigation/irrigationInfoList.do" method="post">
	<input type="text" id="irrigationId" placeholder="관수ID" name="irrigationId" value="${irrigationId}"/>
	<input type="text" id="irrigation" placeholder="관수명" name="irrigation" value="${irrigation}"/>
	<input type="text" id="organizationId" placeholder="현장ID" name="organizationId" value="${organizationId}"/>
	<input type="button" id="search" onclick="javascript:fnDetailSearch(1)" valbutton"/>
	<button type="button" id="modal_opne_btn" class="btn-regist" onclick="fnShowRegModal()">등록</button>
	<input type="button" id="excelDn" onclick="javascript:fnExcelDown()" value="엑셀다운로드"/>
</form>
	<table id="irrigationList" border="1">
	
		<th onclick="fnHeaderClick(1)">순번</th>
		<th onclick="fnHeaderClick(2)">관수ID</th>
		<th onclick="fnHeaderClick(3)">관수명</th>
		<th onclick="fnHeaderClick(4)">유량투입시간(분)</th>
		<th onclick="fnHeaderClick(5)">유량투입량(L)</th>
		<th onclick="fnHeaderClick(6)">양액투입시간(분)</th>
		<th onclick="fnHeaderClick(7)">양액투입량(L)</th>
		<th onclick="fnHeaderClick(8)">현장ID</th>
		<th onclick="fnHeaderClick(9)">등록일자</th>

	<c:choose>
		<c:when test="${empty list}">
			<tbody id="tbody">
				<tr>
					<th colspan="9">
						조회된 결과가 없습니다.
					</th>
				</tr>
			</tbody>
		</c:when>
		<c:otherwise>
			<c:forEach var="item" items="${list}" varStatus="status">
			<tbody id="tbody">
				<tr align="center" onclick="fnShowDetailModal('${item.irrigationId}')">
					<td align="center" id="rownum"><c:out value="${item.rownum}" /></td>
					<td align="center" id="irrigationId"><c:out value="${item.irrigationId}" /></td>
					<td align="center" id="irrigation"><c:out value="${item.irrigation}" /></td>
					<td align="right" id="streamTime"><c:out value="${item.streamTime}" /></td>
					<td align="right" id="streamFlow"><c:out value="${item.streamFlow}" /></td>
					<td align="right" id="nutrientTime"><c:out value="${item.nutrientTime}" /></td>
					<td align="right" id="nutrientSolution"><c:out value="${item.nutrientSolution}" /></td>
					<td align="right" id="organizationId"><c:out value="${item.organizationId}" /></td>
					<td align="center" id="regDate"><c:out value="${item.regDate}" /></td>
				</tr>
			</tbody>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</table>
	<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
	<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
	<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
	<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
	<input type="hidden" id="sortType" name="sortType" value="${sortType}">
	<input type="hidden" id="pageType" name="pageType" value="">
	<input type="hidden" id="page" name="page" value="${pagination.page}">
	<input type="hidden" id="range" name="range" value="${pagination.range}">
	<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
	<input type="hidden" id="idx" name="idx" value="${idx}">
<P>

<!-- 페이징 시작 -->
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
						<a class="page-link" href="#" onClick="fnNext('${pagination.range}', 
														'${pagination.range}', '${pagination.rangeSize}')" >다음</a>
					</c:if>
				</td>
				<td>
					
						<span><a class="page-link" href="#" onClick="fnLast('${pagination.pageCnt}', 
													'${pagination.pageCnt}', '${pagination.rangeSize}')" >마지막</a></span>
					
				</td>
			</tr>
		</table>
	</div>
<!-- 페이징 끝 -->

<!-- layer popup 1 -->
	<div id="modalRegist" class="modal">
		<div class="modal-wrap">
			<div class="modal-content">
				<div class="modal-head">
					<h3 id="modal-title">관수등록</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="regForm" action="/irrigation/irrigationInfoSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default">
							<tbody>
								<tr>
									<th scope="row">관수ID(*)</th>
									<td align="center">
										<input type="hidden" value="dupCheckNo" id="dupResult">
										<input type="text" value="" id="inputIrrigationId" name="inputIrrigationId" maxlength="4">
										<button type="button" id="dupCheck" onclick="fnDupCheck()">중복확인</button>
									</td>
								</tr>
								<tr>
									<th scope="row">관수명(*)</th>
									<td align="center"><input type="text" value="" id="inputIrrigation" name="inputIrrigation"></td>
								</tr>
								<tr>
									<th scope="row">유량투입시간</th>
									<td align="right"><input type="text" value="" id="inputStreamTime" name="inputStreamTime" maxlength="2"> (분)</td>
								</tr>
								<tr>
									<th scope="row">유량투입량</th>
									<td align="right"><input type="text" value="" id="inputStreamFlow" name="inputStreamFlow" maxlength="2"> (L)</td>
								</tr>
								<tr>
									<th scope="row">양액투입시간</th>
									<td align="right"><input type="text" value="" id="inputNutrientTime" name="inputNutrientTime" maxlength="2"> (분)</td>
								</tr>
								<tr>
									<th scope="row">양액투입량</th>
									<td align="right"><input type="text" value="" id="inputNutrientSolution" name="inputNutrientSolution" maxlength="2"> (L)</td>
								</tr>
								
								<tr>
									<th scope="row">현장ID(*)</th>
									<td align="center"><input type="text" value="" id="inputOrganizationId" name="inputOrganizationId"></td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnSave()">저장</button>
						<button type="button" class="modal-close" onclick="fnCloseRegModal()">취소</button>
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
					<h3 id="modal-title">관수제어 > 현장정보 상세조회</h3>
					<!-- <a class="modal-close" title="닫기">닫기</a>  -->
				</div>
				<div class="modal-body">
					<form id="regForm" action="/irrigation/irrigationInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th width="100">관수ID</th>
									<td align="center">
										<span id="irrigationIdDetail"></span>
									</td>
									<th>관수명</th>
									<td align="center">
										<span id="irrigationNmDetail"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">유량투입시간</th>
									<td align="right">
										<span id="streamTimeDetail"></span>
									</td>
									<th scope="row">유량투입량</th>
									<td align="right">
										<span id="streamFlowDetail"></span>
									</td>
								</tr>
								<tr>
									<th scope="row">양액투입시간</th>
									<td align="right">
										<span id="nutrientTimeDetail"></span>
									</td>
									<th scope="row">양액투입량</th>
									<td align="right">
										<span id="nutrientSolutionDetail"></span>
									</td>
								</tr>
								<tr>
									<th>현장ID</th>
									<td align="center" colspan="3">
										<span id="organizationIdDetail"></span>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="button" class="btn-confirm" id="user-reg-btn" onclick="fnShowModModal()">수정</button>
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
					<h3 id="modal-title">관수제어 > 현장정보 수정</h3>
				</div>
				<div class="modal-body">
					<form id="regForm" action="/irrigation/irrigationInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th scope="row">관수ID</th>
									<td align="center">
										<input type="text" id="irrigationIdMod" maxlength="4">
									</td>
									<th scope="row">관수명</th>
									<td align="center">
										<input type="text" id="irrigationNmMod">
									</td>
								</tr>
								<tr>
									<th scope="row">유량투입시간</th>
									<td align="right">
										<input type="text" id="streamTimeMod" maxlength="2">
									</td align="right">
									<th scope="row">유량투입량</th>
									<td>
										<input type="text" id="streamFlowMod" maxlength="2"> 
									</td>
								</tr>
								<tr>
									<th scope="row">양액투입시간</th>
									<td align="right">
										<input type="text" id="nutrientTimeMod" maxlength="2">
									</td>
									<th scope="row">양액투입량</th>
									<td align="right">
										<input type="text" id="nutrientSolutionMod" maxlength="2"> 
									</td>
								</tr>
								<tr>
									<th>현장ID</th>
									<td align="center" colspan="3">
										<input type="text" id="organizationIdMod"> 
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="modal-button">
						<button type="submit" class="btn-confirm" id="user-reg-btn" onclick="fnMod()">저장</button>
						<button type="button" class="modal-close" onclick="fnCloseModModal()">취소</button>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- //layer popup 3 -->

</body>
</html>
