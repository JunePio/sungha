<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : sensorList.jsp
 * @Description : 센서정보 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @ 2023.05.08  이준영
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

	<script type="text/javascript" src="/static/assets/js/common.js"></script>
	<style>
		.link {cursor: pointer;}
	</style>
	<script type="text/javascript">

		/*
		$(document).ready(function() {

		});
		*/

		$(document).keydown(function(e){
			//keyCode 구 브라우저, which 현재 브라우저
			var code = e.keyCode || e.which;
			/*
           if (e.ctrlKey==true && (e.which == '118' || e.which == '86')) {
               e.preventDefault();
            }
           */
			if (code == 27) { // 27은 ESC 키번호
				fnCloseRegModal();
				$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
				$("#modalMod").attr("style", "display:none"); // 센서정보 수정조회 모달 닫기
			}
		});

		// 등록버튼 클릭시
		function fnShowRegModal(e) {

			//fnOrgNmRegistChange(e);
			//$("#modalRegist").attr("style", "display:block"); // 센서정보 등록 모달 팝업

			document.searchForm.action = '<c:url value="/sensor/sensorRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#searchForm").submit();

		};

		// 센서정보 등록 모달창에서 취소 버튼 클릭시
		function fnCloseRegModal() {
			$("#inputSensorId").val("");
			$("#inputSensorNm").val("");
			$("#inputChipId").val("");
			$("#inputOutYn option:eq(0)").prop("selected", true); // 콤보박스 첫번째 항목 선택
			$("#orgNmRegist option:eq(0)").prop("selected", true); // 콤보박스 첫번째 항목 선택
			$("#localNmRegist option:eq(0)").prop("selected", true); // 콤보박스 첫번째 항목 선택
			$("#textArea_byteLimit").val("");
			$("#textareaByteCnt").text("");

			$("#modalRegist").attr("style", "display:none"); // 센서정보 등록 모달 닫기
		};

		// 게시판 헤더 클릭시 정렬
		function fnHeaderClick(column) {
			if($("#sortType").val() == "desc") { // 정렬방식이 내림차순일 경우
				$("#sortType").val("asc"); // 정렬방식을 오름차순으로 변경
			} else {
				$("#sortType").val("desc"); // 정렬방식을 내림차순으로 변경
			}
			$("#sortColumn").val(column); // 컬럼 정보 저장
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#searchForm").submit();

		};

		// 센서정보 검색
		function fnDetailSearch(form){

			form.action = '<c:url value="/sensor/sensorList.do"/>'; // 전송 url
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
					searchingOrgId : $("#searchingOrgId").val(), // 콤보박스에서 선택된 항목의 센서ID
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
					//$("#localNmMod").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
					for(var i = 0; i < data.listSize ; i++) {
						$("#localNmMod").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
					}

				},
				error : function(arg){
					alert("통신실패시에만 실행");

				}
			})
		};

		// 센서정보 등록에서 이메일 콤보박스 변경시
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

		// 센서정보 리스트에서 row 클릭시
		function fnShowDetailModal(sensorId) {

			$("#sensorIdParam").val(sensorId);

			document.searchForm.action = '<c:url value="/sensor/sensorDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#searchForm").submit();
		};


		// 엑셀 다운로드 버튼 클릭시
		function fnSensorInfoExcelDown(form) {
			form.action = '<c:url value="/sensor/excel.do"/>';
			form.submit();
		};


		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("1");
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>';
			document.searchForm.submit();
		}

		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>';
			document.searchForm.submit();
		}

		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>';
			document.searchForm.submit();
		}

		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/sensor/sensorList.do"/>';
			document.searchForm.submit();
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
				<h2 class="responsive-title-txt h4-bold">센서 정보관리</h2>
			</div>

			<div class="title">
				<h2 class="title-txt h2-bold">센서 정보관리</h2>
				<p class="title-menu">
					<span class="home"></span>
					<span class="depth-menu body-1-bold">센서</span>
					<span class="depth-menu body-1-bold">센서 정보관리</span>
				</p>
			</div>
		</div>

		<div class="sh-content">

			<form id="searchForm" name="searchForm" action="/sensor/sensorList.do" method="post">
				<div class="condition-search">
					<div class="list-box">
						<div class="search-first-condition">

							<div class="con-title">
								<span class="con-title-span">센서</span>
								<select id="searchingType" name="searchingType"  class="dropdown-sel search-sel ml-2" style="position:relative;">
									<option value="sensorNm" <c:if test="${searchingType eq 'sensorNm'}">selected</c:if> >센서 명</option>
									<option value="sensorId" <c:if test="${searchingType eq 'sensorId'}">selected</c:if> >센서 ID</option>
								</select>
								<%--<select class="dropdown-sel search-sel ml-2" style="position:relative;">
									<option>센서ID</option>
									<option>센서ID1</option>
								</select>--%>

							</div>
							<%--<input type="text"  class="search-sel input-search-two" placeholder="내용을 입력하세요.">--%>
							<input type="text" name="searchingContent" value="${searchingContent}"  class="search-sel input-search-two" placeholder="내용을 입력하세요."/>
						</div>
						<div class="search-second-condition con-title">
							<span style="position:relative;"  >기관명</span>
							<select id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)" class="dropdown-sel search-sel ml-2" style="position:relative;">
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
							<%--<select class="dropdown-sel search-sel ml-2" style="position:relative;">
								<option>전체</option>
								<option>기관명1</option>
							</select>--%>
						</div>
						<div class="search-third-condition con-title">
							<span >지역명</span>
							<select id="searchingLocalId" name="searchingLocalId">
								<option value="total">전체</option>
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
							<%--<select class="dropdown-sel search-sel ml-2"  style="position:relative;">
								<option>전체</option>
								<option>지역명1</option>
							</select>--%>
						</div>
						<div class="search-forth-condition">
							<button class="icon-primary-small btn-search" type="button" id="search" onclick="javascript:fnDetailSearch(this.form)">검색</button>
						</div>

					</div>
				</div>


				<div class="main-content" headline="Stats">
					<div class="res-main-top no-txt">
						<button class="actibody-2-bold  excel-btn" type="button" onclick="fnSensorInfoExcelDown(this.form)">엑셀 다운로드</button>
					</div>

					<!-- table -->
					<div class="wrap-table">
						<div class="table100 ver1">

							<div class="wrap-table100-nextcols js-pscroll">
								<div class="table100-nextcols">
									<table>
										<thead>
										<tr class="row100 head body-2-bold ">
											<th onclick="fnHeaderClick(1)" class="column1-sensor">번호</th>
											<th onclick="fnHeaderClick(2)" class="column2-sensor column-arrow-up">센서ID</th>
											<th onclick="fnHeaderClick(3)" class="column3-sensor column-arrow-down">센서명</th>
											<th onclick="fnHeaderClick(4)" class="column4-sensor column-arrow-up">기관명</th>
											<th onclick="fnHeaderClick(5)" class="column5-sensor column-arrow-up">지역명</th>
											<th onclick="fnHeaderClick(6)" class="column6-sensor">베터리 잔량</th>
											<th class="column7-sensor">센서 상태</th>
											<th onclick="fnHeaderClick(7)" class="column8-sensor">유심코드</th>
											<th onclick="fnHeaderClick(8)" class="column9-sensor">반출여부</th>
											<th onclick="fnHeaderClick(9)" class="column10-sensor">등록일시(수정일시)</th>
											<th onclick="fnHeaderClick(10)" class="column11-sensor">센서위치 설명</th>
											<th onclick="fnHeaderClick(11)" class="column11-sensor">관수ID</th>
											<th onclick="fnHeaderClick(12)" class="column11-sensor">관수명</th>
										</tr>
										</thead>
										<c:choose>
											<c:when test="${empty sensorInfoList}">
												<tbody id="tbody">
												<tr>
													<th colspan="12">
														조회된 결과가 없습니다.
													</th>
												</tr>
												</tbody>
											</c:when>
											<c:otherwise>
												<c:forEach var="item" items="${sensorInfoList}" varStatus="status">
													<tbody id="tbody" class="body-2-regular tbody-table ">
													<tr class="row100 body odd">
														<td id="rownum"><c:out value="${item.rownum}" /></td>
														<td id="sensorId"><span class="link" onclick="fnShowDetailModal('${item.sensorId}')" ><c:out value="${item.sensorId}" escapeXml="false" /></span></td>
														<td id="sensor"><span class="link" onclick="fnShowDetailModal('${item.sensorId}')" ><c:out value="${item.sensor}" escapeXml="false" /></span></td>
														<td id="organization"><c:out value="${item.organization}" escapeXml="false" /></td>
														<td id="local"><c:out value="${item.local}" escapeXml="false" /></td>
														<td id="batcaprema"><c:out value="${item.batcaprema}%" escapeXml="false" /></td>
														<td id="">ON</td>
														<td id="usimId"><c:out value="${item.usimId}" escapeXml="false" /></td>
														<td id="outYn"><c:out value="${item.outYn}" escapeXml="false" /></td>
														<td id="regDate"><c:out value="${item.regDate}" escapeXml="false" /></td>
														<td id="sensorDetail"><c:out value="${item.sensorDetail}" escapeXml="false" /></td>
														<td id="irrigationIdDetail"><c:out value="${item.irrigationId}" escapeXml="false" /></td>
														<td id="irrigationNmDetail"><c:out value="${item.irrigationName}" escapeXml="false" /></td>
													</tr>
													</tbody>
													<input type="hidden" id="sensorIdParam" name="sensorIdParam"/>
												</c:forEach>
											</c:otherwise>
										</c:choose>
										<%--<tbody class="body-2-regular tbody-table">
										<tr class="row100 body odd">
											<td class="column1"><span class="res-td body-3-bold">번호</span><span class="res-table-content">1</span></td>
											<td class="column2"><span class="res-td body-3-bold">센서ID</span><span class="res-table-content"><a href="sensor_info_detail.html" class="detail-link">DEV_01</a></span></td>
											<td class="column3"><span class="res-td body-3-bold">센서명</span><span class="res-table-content">지앤_01</span></td>
											<td class="column4"><span class="res-td body-3-bold">기관명</span><span class="res-table-content">지앤</span></td>
											<td class="column5"><span class="res-td body-3-bold">지역명</span><span class="res-table-content">가산동</span></td>
											<td class="column6"><span class="res-td body-3-bold">베터리 잔량</span><span class="res-table-content">58%</span></td>
											<td class="column7"><span class="res-td body-3-bold">센서 상태</span><span class="res-table-content"><span class="body-2-bold label-on">ON</span></span></td>
											<td class="column8  irr-hide-column" ><span class="res-td body-3-bold">유심코드</span><span class="res-table-content">DKJFIK023</span></td>
											<td class="column9"><span class="res-td body-3-bold">반출여부</span><span class="res-table-content">반출</span></td>
											<td class="column10"><span class="res-td body-3-bold">등록일시(수정일시)</span><span class="res-table-content">2022.12.06 13:17:11</span></td>
											<td class="colum11"><span class="res-td body-3-bold">센서위치 설명</span><span class="res-table-content">지앤 아파트 101동 앞 정원</span></td>
										</tr>--%>
									</table>
									<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn }">
									<input type="hidden" id="sortType" name="sortType" value="${sortType}">
									<input type="hidden" id="pageType" name="pageType" value="">
									<input type="hidden" id="page" name="page" value="${pagination.page}">
									<input type="hidden" id="range" name="range" value="${pagination.range}">
									<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
									<input type="hidden" id="idx" name="idx" value="${idx}">
									<input type="hidden" id="page" name="page" value="${pagination.page}">
									<input type="hidden" id="range" name="range" value="${pagination.range}">
									<input type="hidden" id="rangeSize" name="rangeSize" value="${pagination.rangeSize}">
								</div>
							</div>
							<div>
								<div class="paging">
									<ul class="pagination">
										<li class="page-item paging-prev"><a class="page-link" href="#" onClick="fnFirst(1, 1, 10)"><i class="fa-sharp fa-solid fa-angles-right paging-prev-i"></i></a></li>
										<c:if test="${pagination.prev}">
										<li class="page-item paging-prev"><a class="page-link" href="#" onClick="fnPrev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')"><i class="fa-solid fa-angle-right paging-prev-i"></i></a></li>
										</c:if>
										<%--<li class="page-item paging-prev"><a class="page-link" href="#"><i class="fa-solid fa-angle-right paging-prev-i"></i></a></li>--%>
										<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
											<li class="page-item <c:out value="${pagination.page == idx ? 'pagination-active' : ''}"/> "><a class="page-link" href="#" onClick="fnPagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>
										</c:forEach>
										<%--<li class="page-item pagination-active"><a class="page-link" href="#">1</a></li>
										<li class="page-item"><a class="page-link" href="#">2</a></li>
										<li class="page-item"><a class="page-link" href="#">3</a></li>
										<li class="page-item"><a class="page-link" href="#">4</a></li>
										<li class="page-item"><a class="page-link" href="#">5</a></li>
										<li class="page-item res-page"><a class="page-link" href="#">6</a></li>
										<li class="page-item res-page"><a class="page-link" href="#">7</a></li>
										<li class="page-item res-page"><a class="page-link" href="#">8</a></li>
										<li class="page-item res-page"><a class="page-link" href="#">9</a></li>
										<li class="page-item res-page"><a class="page-link" href="#">10</a></li>--%>
										<li class="page-item ">
											<c:if test="${pagination.next}">
												<a class="page-link" href="#" onClick="fnNext('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" ><i class="fa-solid fa-angle-right paging-next-i"></i></a>
											</c:if>
										</li>
										<li class="page-item paging-next"><a class="page-link" href="#" onClick="fnLast('${pagination.lastPage}', '${pagination.lastRange}', '${pagination.rangeSize}')" ><i class="fa-sharp fa-solid fa-angles-right paging-next-i"></i></a></li>
									</ul>
								</div>
								<div class="btn-area-type1">
									<button class="reg-btn icon-primary-small" type="button" onclick="fnShowRegModal(this)">등록</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>

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
	</div>
</div>
</body>
</html>
