<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : boardList.jsp
 * @Description : Q&A 리스트 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.10  이창호      최초생성
 * @ 2023.05.04  이준영     전반적인 css수정 추가
 * @ 2023.05.17  이준영     기능구현, CSS통합
 */
%>

<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Q&A 목록</title>
	<script src="/static/js/filtering.js"></script>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

	<link rel="stylesheet" href="/static/assets/css/common.css">
	<script type="text/javascript" src="/static/assets/js/common.js"></script>
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">

	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<style>
		.wrap-table {display:block!important;}
		.main-content {height:auto!important;}
		/*datepicer 버튼 롤오버 시 손가락 모양 표시*/
		.ui-datepicker-trigger{cursor: pointer;}
		/*datepicer input 롤오버 시 손가락 모양 표시*/
		.hasDatepicker{cursor: pointer;}
		.detail-link{cursor: pointer;}
		.reg-btn icon-primary-small{cursor: pointer;}
		.page-link {
			margin-left: 8px !important;}
		.select-srch{position: unset;
			float: unset;}

	</style>
	<script type="text/javascript">

		$(document).keydown(function(e){
			//keyCode 구 브라우저, which 현재 브라우저
			var code = e.keyCode || e.which;

			if (code == 27) { // 27은 ESC 키번호
				fnCloseRegModal();
				$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
				$("#modalMod").attr("style", "display:none"); // 센서정보 수정조회 모달 닫기
			}
		});
		
		// 등록버튼 클릭시
		function fnShowRegModal(e) {
					
			document.searchForm.action = '<c:url value="/board/boardRegist.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
		    $("#searchForm").submit();
			
		};

	
		// Q&A정보 검색
		function fnDetailSearch(pageNo){
			var searchingType = $("#searchingType").val();
			var searchingContent = $("#searchingContent").val();
			document.getElementById("searchForm").submit();
		};

		// Q&A 리스트에서 row 클릭시
		function fnShowDetailModal(boardId) {

			$("#boardIdParam").val(boardId);

			document.searchForm.action = '<c:url value="/board/boardDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#searchForm").submit();
		};

		//처음 버튼 이벤트
		function fnFirst(page, range, rangeSize) {
			$("#pageType").val("firstClick");
			//document.searchForm.pageIndex.value = pageNo;
			$("#page").val("1");
			$("#range").val("5");
			//document.searchForm.pageIndex.value = pageNo;
			document.searchForm.action = '<c:url value="/board/boardList.do"/>';
			document.searchForm.submit();
		}

		//이전 버튼 이벤트
		function fnPrev(page, range, rangeSize) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/board/boardList.do"/>';
			document.searchForm.submit();
		}

		//페이지 번호 클릭
		function fnPagination(page, range, rangeSize) {
			$("#idx").val(page);
			$("#page").val(page);
			$("#range").val(range);
			$("#pageType").val("numClick");
			document.searchForm.action = '<c:url value="/board/boardList.do"/>';
			document.searchForm.submit();
		}

		//다음 버튼 이벤트
		function fnNext(page, range, rangeSize) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/board/boardList.do"/>';
			document.searchForm.submit();
		}

		//마지막 버튼 이벤트
		function fnLast(page, range, rangeSize) {
			$("#page").val(page);
			$("#range").val(range);
			document.searchForm.action = '<c:url value="/board/boardList.do"/>';
			document.searchForm.submit();
		}
	
	</script>
</head>
<body>
<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	<div class="sh-main">
		<div class="sh-header">
			<div class="title">
				<p class="title-txt">1:1 문의
					<!--<span class="title-menu"> < 일대일문의 < 공지사항</span>-->
				</p>
			</div>
		</div>
		<div class="sh-content">
			<div class="main-content" headline="Stats">
				<form id="searchForm" name="searchForm" action="/board/boardList.do" method="post">
					검색조건
					<select id="searchingType" name="searchingType" class="select-srch">
						<option value="title" <c:if test="${searchingType eq 'title'}">selected</c:if> >제목</option>
						<option value="content" <c:if test="${searchingType eq 'content'}">selected</c:if> >내용</option>
					</select>
					<input type="text" name="searchingContent" id="searchingContent" value="${searchingContent}"/>
					<input type="button" id="search" onclick="javascript:fnDetailSearch(1)" value="검색"/>
					<!-- table -->
					<input type="hidden" name="writerId" id="writerId" value="관리자"/>
					<div class="wrap-table">
						<div class="table100 ver1">
							<div class="wrap-table100-nextcols js-pscroll">
								<div class="table100-nextcols">
									<table>
										<thead class="thead-1q">
										<tr class="row100 head body-2-bold ">
											<th class="column1 res-1q-hide">번호</th>
											<th class="column2-1q">분류</th>
											<th class="column3-1q">제목</th>
											<th class="column4 res-1q-hide">등록일시</th>
											<th class="column5">상태</th>
										</tr>
										</thead>
										<tbody class="body-2-regular tbody-table">
<%--										<c:set var="num" value="2"/>--%>
										<c:forEach var="item" items="${boardList}" varStatus="status">
											<c:choose>
												<c:when test="${status.count %2 == 0}">
													<tr class="row100 body odd">
														<td id="rownum" class="column1 res-1q-hide"><span ><c:out value="${item.rownum}" /></span></td>
														<td id="qaGubun" class="column2"><span ><c:out value="${item.qaGubun}" escapeXml="false" /></span></td>
														<td id="title" class="column3"><span class="detail-link"  onclick="fnShowDetailModal('${item.boardId}')" ><c:out value="${item.title}" escapeXml="false" /></span></td>
														<td id="regDate" class="column4 res-1q-hide"><span ><c:out value="${item.regDateTime}" escapeXml="false" /></span></td>
														<c:if test="${item.state eq '답변대기'}"><td id="state"><span ><p style="color:black">답변대기</p></span></td></c:if>
														<c:if test="${item.state eq '답변완료'}"><td id="state"><span ><p style="color:red">답변완료</p></span></td></c:if>
													</tr>
												</c:when>
												<c:otherwise>
													<tr class="row100 body even">
														<td id="rownum" class="column1 res-1q-hide"><span ><c:out value="${item.rownum}" /></span></td>
														<td id="qaGubun" class="column2"><span ><c:out value="${item.qaGubun}" escapeXml="false" /></span></td>
														<td id="title" class="column3"><span class="detail-link"  onclick="fnShowDetailModal('${item.boardId}')" ><c:out value="${item.title}" escapeXml="false" /></span></td>
														<td id="regDate" class="column4 res-1q-hide"><span ><c:out value="${item.regDateTime}" escapeXml="false" /></span></td>
														<c:if test="${item.state eq '답변대기'}"><td id="state"><span ><p style="color:black">답변대기</p></span></td></c:if>
														<c:if test="${item.state eq '답변완료'}"><td id="state"><span ><p style="color:red">답변완료</p></span></td></c:if>
													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										</tbody>
									</table>
									<input type="hidden" id="boardIdParam" name="boardIdParam"/>
								</div>
							</div>
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
				</form>
			</div>
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

	</div>
	<div class="btn-area-type1">
		<button class="reg-btn icon-primary-small"><span onclick="fnShowRegModal(this)">등록</span></button>
	</div>
</div>
</div>

	<%@ include file="/WEB-INF/views/footer.jsp" %>
</div>

</body>
</html>
