<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : sensorInfoList.jsp
 * @Description : 센서 계측정보 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.28  이창호      최초생성
 * @
 */
%>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>센서 정보관리</title>

	<link rel="shortcut icon" href="favicon.ico">
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

    <script type="text/javascript">
    
    $(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 	/*
	    if (e.ctrlKey==true && (e.which == '118' || e.which == '86')) {
            e.preventDefault();
         }
		*/
	    if (code == 27) { // 27은 ESC 키번호
	    	
	    	$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
	    	
	    }
	});    
    
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

	// 기관정보 검색
	function fnDetailSearch(pageNo){
		$("#page").val("1");
		$("#range").val("1");
		var from = $("#datepicker").val();
		var to = $("#datepicker1").val();
		
		from = new Date(from);
		from = new Date(from.setMilliseconds(0));
		to = new Date(to);
		to = new Date(to.setMilliseconds(0));
		
		if(from > to) {
			alert("시작일이 종료일보다 클수 없습니다.");
			return false;
		}
			
		if((from - to) < -2678400000) {
			alert("30일 제한 범위를 초과하였습니다.!");
			return false;
		} else if((to - from) < -2678400000) {
			alert("30일 제한 범위를 초과하였습니다.!!");
			return false;
		} else {
			document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>'; // 전송 url
			document.SearchForm.submit(); // 서버로 전송
		}
		
	};
	
			
	// 기관명 콤보박스 변경시
	function fnOrgNmChange(e){
		$.ajax({
		    url: "/sensorInfo/localNmList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	searchingOrgId : $("#orgNm").val(), // 콤보박스에서 선택된 항목의 기관ID
		    	searchingLocalId : $("#localNm").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			$("#localNm").empty(); // 기존에 있던 항목은 지우고
			//$("#localNm").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
			for(var i = 0; i < data.listSize ; i++) {
				$("#localNm").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
			}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			
		    }
		})
	};
	
	$("#datepicker").datepicker();  // 검색기간 - FROM
	$("#datepicker1").datepicker(); // 검색기간 - TO
	
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
			,minDate: "" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
			,maxDate: "" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
		});
	    
		if($("#date").val() != "") {
			$('#datepicker').datepicker('setDate', $("#date").val());
		} else {
			//초기값을 오늘 날짜로 설정
			$('#datepicker').datepicker('setDate', '-1M');
		}
		
		$("#datepicker1").datepicker({
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
			,minDate: "" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
			,maxDate: "" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
		});
		if($("#date1").val() != "") {
			var month = $("#date1").val();
			$('#datepicker1').datepicker('setDate', $("#date1").val());
			$('#datepicker').datepicker('setDate', '-1M');
		} else {
			//초기값을 오늘 날짜로 설정
			$('#datepicker1').datepicker('setDate', 'today');
		}
		
		
	});
	
	//처음 버튼 이벤트
	function fnFirst(page, range, rangeSize) {
		$("#pageType").val("firstClick");
		//document.SearchForm.pageIndex.value = pageNo;
		$("#page").val("1");
		$("#range").val("1");
		//document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoList.do"/>';
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>';
		document.SearchForm.submit();
	}
	
	//이전 버튼 이벤트
	function fnPrev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		$("#page").val(page);
		$("#range").val(range);
		//document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoList.do"/>';
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>';
		document.SearchForm.submit();
	}

	//페이지 번호 클릭
	function fnPagination(page, range, rangeSize) {
		$("#idx").val(page);
		$("#page").val(page);
		$("#range").val(range);
		$("#pageType").val("numClick");
		//document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoList.do"/>';
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>';
		document.SearchForm.submit();
	}

	//다음 버튼 이벤트
	function fnNext(page, range, rangeSize) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		$("#page").val(page);
		$("#range").val(range);
		//document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoList.do"/>';
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>';
		document.SearchForm.submit();
	}
	
	//마지막 버튼 이벤트
	function fnLast(page, range, rangeSize) {
		$("#page").val(page);
		$("#range").val(range);
		//document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoList.do"/>';
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>';
		document.SearchForm.submit();
	}
	
	// 엑셀 다운로드
	function fnExcelDown(form){
	   	document.SearchForm.action = "<c:url value='/sensorInfo/point.do?excelDownload=true'/>";
       	document.SearchForm.submit();
	};
	
	// 계측데이터 리스트에 row 클릭시
	function fnShowDetailModal(organizationId, localId, sensorId, sensor, regDate, count, temp, humi, ph, conduc, nitro, phos, pota, batcaprema) {

		$("#organizationId").val(organizationId);
		$("#localId").val(localId);
		
		$("#sensorId").val(sensorId);
		$("#sensor").val(sensor);
		$("#regDate").val(regDate);
		$("#count").val(count);
		
		$("#temp").val(temp);
		$("#humi").val(humi);
		$("#ph").val(ph);
		$("#conduc").val(conduc);
		$("#nitro").val(nitro);
		$("#phos").val(phos);
		$("#pota").val(pota);
		$("#batcaprema").val(batcaprema);
		
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#SearchForm").submit();
	}
	</script>
</head>
<body>
	<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
		<div class="sh-main ">
			<div id="backdrop_on" class="res-backdrop fade"></div>
			<div class="sh-header">
				<!-- reponsive header -->
				<div class="responsive-title">
					<h2 class="responsive-title-txt h4-bold">전체현장</h2>
				</div>

				<div class="title">
					<h2 class="title-txt h2-bold">전체현장</h2>
					<p class="title-menu">
						<span class="home"></span>
						<span class="depth-menu body-1-bold">데이터</span>
						<span class="depth-menu body-1-bold">전체현장</span>
					</p>
				</div>
			</div>

			<div class="sh-content">
				<form id="SearchForm" name="SearchForm" action="/sensorInfo/sensorInfoList.do" method="post">
					<div class="condition-search-with-txt">
						<div class="list-box-with-txt">
							<div class="search-first-condition-one con-title">
								<div class="con-title">
									<span class="con-title-span">기관명</span>
									<select id="orgNm" name="orgNm" onchange="fnOrgNmChange(this)" class="dropdown-sel search-sel ml-2" style="position:relative;">
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
								<span style="width: 60px;"  >지역명</span>
								<select id="localNm" name="localNm" class="dropdown-sel  ml-2" style="position:relative;">
									<!-- <option value="total" selected>전체</option> -->
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
								<span >계측일자</span>
								<input type="date"  class="search-sel input-search calendar" placeholder="날짜 선택" style="position:relative;"  name="datepicker" >
								<span class="calendar-between">~</span>
								<input type="date"  class="search-sel input-search calendar" placeholder="날짜 선택" style="position:relative;" name="datepicker1" value="${datepicker1}">
							</div>
							<div class="search-forth-condition">
								<button class="icon-primary-small btn-search">검색</button>
							</div>
						</div>
						<div class="condition-desc">계측일시 기간검색은 현재월기준으로 전월까지만 조회 가능</div>
					</div>
				<div class="main-content" headline="Stats">
					<div class="res-main-top no-txt">
						<button class="actibody-2-bold  excel-btn" id="excelDn" onclick="javascript:fnExcelDown(this.form)" >엑셀 다운로드</button>
					</div>
					<!-- table -->
					<div class="wrap-table">
						<div class="table100 ver1">
							<div class="wrap-table100-nextcols js-pscroll">
								<div class="table100-nextcols">
									<table id="sensorList">
										<thead id="thead">
											<tr class="row100 head body-2-bold ">
												<th  class="column1-data" onclick="fnHeaderClick(1)" rowspan="2">번호</th>
												<th  class="column1-data" onclick="fnHeaderClick(2)" rowspan="2">기관명</th>
												<th  class="column1-data" onclick="fnHeaderClick(3)" rowspan="2">지역명</th>
												<th  class="column1-data" onclick="fnHeaderClick(4)" rowspan="2">센서명</th>
												<th  class="column1-data" onclick="fnHeaderClick(4)" rowspan="2">위도</th>
												<th  class="column1-data" onclick="fnHeaderClick(4)" rowspan="2">경도</th>
												<th  class="column1-data" colspan="8">계측데이터</th>
												<th  class="column1-data" onclick="fnHeaderClick(5)" rowspan="2">계측일시</th>
											</tr>
											<tr class="row100 head body-2-bold ">
												<th class="column1-data" onclick="fnHeaderClick(6)">온도(℃)</th>
												<th class="column1-data" onclick="fnHeaderClick(7)">수분함량(%)</th>
												<th class="column1-data" onclick="fnHeaderClick(8)">산도(pH)</th>
												<th class="column1-data" onclick="fnHeaderClick(9)">전도도(ds/m)</th>
												<th class="column1-data" onclick="fnHeaderClick(10)">질소(mg/kg)</th>
												<th class="column1-data" onclick="fnHeaderClick(11)">인(mg/kg)</th>
												<th class="column1-data" onclick="fnHeaderClick(12)">칼륨(cmol/kg)</th>
												<th class="column1-data" onclick="fnHeaderClick(13)">배터리(%)</th>
											</tr>
										</thead>
										<c:choose>
											<c:when test="${empty list}">
												<tbody id="tbody" class="body-2-regular tbody-table">
												<tr class="row100 body odd">
													<th colspan="14">
														조회된 결과가 없습니다.
													</th>
												</tr>
												</tbody>
											</c:when>
											<c:otherwise>
											<tbody id="tbody">
												<c:forEach var="item" items="${list}" varStatus="status">
													
													<tr class="row100 body odd" align="center" onclick="fnShowDetailModal('${item.organizationId}', '${item.localId}','${item.sensorId}','${item.sensor}','${item.regDateTime}', '${status.count}',
															'${item.temp}', '${item.humi}', '${item.ph}', '${item.conduc}', '${item.nitro}', '${item.phos}', '${item.pota}', '${item.batcaprema}')">
														<td class="column1" align="center" id="rownum${status.count}" name="rownum${status.count}"><c:out value="${item.rownum}" /></td>
														<td class="column2" align="center" id="organization${status.count}" name="organization${status.count}"><c:out value="${item.organization}" /></td>
														<td class="column3" align="center" id="local${status.count}" name="local${status.count}"><c:out value="${item.local}" /></td>
														<td class="column4" align="center" id="sensor${status.count}" name="sensor${status.count}"><c:out value="${item.sensor}" /></td>
														<td class="column4" align="center" id="sensor${status.count}" name="sensor${status.count}"><c:out value="${item.latitude}" /></td>
														<td class="column4" align="center" id="sensor${status.count}" name="sensor${status.count}"><c:out value="${item.longitude}" /></td>
														<td class="column5" align="right" id="temp${status.count}" name="temp${status.count}"><c:out value="${item.temp}" /></td>
														<td class="column6" align="right" id="humi${status.count}" name="humi${status.count}"><c:out value="${item.humi}" /></td>
														<td class="column7" align="right" id="ph${status.count}" name="ph${status.count}"><c:out value="${item.ph}" /></td>
														<td class="column8" align="right" id="conduc${status.count}" name="conduc${status.count}"><c:out value="${item.conduc}" /></td>
														<td class="column9" align="right" id="nitro${status.count}" name="nitro${status.count}"><c:out value="${item.nitro}" /></td>
														<td class="column10" align="right" id="phos${status.count}" name="phos${status.count}"><c:out value="${item.phos}" /></td>
														<td class="column11" align="right" id="pota${status.count}" name="pota${status.count}"><c:out value="${item.pota}" /></td>
														<td class="column12" align="right" id="batcaprema${status.count}" name="batcaprema${status.count}"><c:out value="${item.batcaprema}" /></td>
														<td class="column13" align="center" id="regDate${status.count}" name="regDate${status.count}"><c:out value="${item.regDate}" /></td>
													</tr>													
												</c:forEach>
											</tbody>
											</c:otherwise>
										</c:choose>
									</table>
									<input type="hidden" id="count" name="count" />
									<input type="hidden" id="organizationId" name="organizationId" />
									<input type="hidden" id="localId" name="localId" />
									<input type="hidden" id="sensorId" name="sensorId" />
									<input type="hidden" id="sensor" name="sensor" />
									<input type="hidden" id="regDate" name="regDate" />
									<input type="hidden" id="temp" name="temp" />
									<input type="hidden" id="humi" name="humi" />
									<input type="hidden" id="ph" name="ph" />
									<input type="hidden" id="conduc" name="conduc" />
									<input type="hidden" id="nitro" name="nitro" />
									<input type="hidden" id="phos" name="phos" />
									<input type="hidden" id="pota" name="pota" />
									<input type="hidden" id="batcaprema" name="batcaprema" />

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
							<!-- 
							<div>
								<div id="paginationBox" class="paging">
									<Ul class="pagination">
										<li class="page-item paging-prev">
											<a class="page-link" href="#" onClick="fnFirst(1, 1, 10)"><i class="fa-sharp fa-solid fa-angles-right paging-prev-i"></i></a>
										</li>
										<li  class="page-item paging-prev">
											<c:if test="${pagination.prev}">
												<span><a class="page-link" href="#" onClick="fnPrev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')"><i class="fa-solid fa-angle-right paging-prev-i"></i></a></span>
											</c:if>
										</li>
										<li>
											<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
												<span class="page-item <c:out value="${pagination.page == idx ? 'pagination-active' : ''}"/> "><a class="page-link" href="#" onClick="fnPagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></span>
											</c:forEach>
										</li>
										<li>
											<c:if test="${pagination.next}">
												<a class="page-link" href="#" onClick="fnNext('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" ><i class="fa-solid fa-angle-right paging-next-i"></i></a>
											</c:if>
										</li>
										<li>
											<span><a class="page-link" href="#" onClick="fnLast('${pagination.lastPage}', '${pagination.lastRange}', '${pagination.rangeSize}')" ><i class="fa-sharp fa-solid fa-angles-right paging-next-i"></i></a></span>
										</li>
									</Ul>
								</div>
							</div>
							 -->
						</div>
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
			</form>
		</div>
	</div>
</body>
</html>
