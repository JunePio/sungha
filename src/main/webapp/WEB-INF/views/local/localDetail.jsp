<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>지역 관리</title>

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
	
	// 목록 버튼 클릭시
	function fnCloseDetailModal() {
		
		document.detailForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 기관정보 상세 모달에서 삭제 버튼 클릭시
	function fnDel() {
		
		
		
		$.ajax({
		    url: "/local/localDelIsOk.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	localId : $("#localIdMod").val()
		    },
		    //contentType: "application/json",
		    success : function(data) {
		    	if(!data.checkResult) {
					alert("포함된 사용자, 센서 및 관수가 있습니다.\n삭제 후 다시 시도하세요.");
					return false;
		    	} else {
		    		if(confirm("선택한 지역을 삭제 하시겠습니까?")) {
						$.ajax({
						    url: "/local/localDel.do",
						    type: "POST",
						    async: true,
						    //dataType: "json",
						    data: {
						    	localId : $("#localIdMod").val()
						    },
						    //contentType: "application/json",
						    success : function(data) {
						    	alert("삭제완료 하였습니다.")
						    	document.detailForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
							    $("#detailForm").submit();
						    }, 
						    error : function(arg){
							alert("지역정보 삭제 실패");
							
						    }
						});
					}
		    	}
		    }, 
		    error : function(arg){
			alert("지역정보 삭제 실패");
			
		    }
		});	
	};
	
	// 수정 버튼 클릭시 수정 상세조회 페이지로 이동
	function fnShowModModal(localId) {
		document.detailForm.action = '<c:url value="/local/localModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/menu.jsp" %>

	<!-- 기관 상세조회 시작 -->
	<div class="sh-main main-reg-type2">
     <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">지역관리</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">지역관리</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">지역</span> 
              <span class="depth-menu body-1-bold">지역관리</span>
            </p>
        </div>
      </div>

	  <form id="detailForm" name="detailForm" action="/local/localMod.do" method="post" enctype=”multipart/form-data”>
      <div class="sh-content-detail">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">지역 정보관리 상세조회</p>
              <p class=""></p>
            </div>
            <div class="res-require-title"></div>
            	<!-- table-->
            	<div class="wrap-table-detail-regi">
					
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>기관명</th>
									<td class="res-title-td">기관명</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
			                            	<div class="regi-dup-area-txt">
												<input type="hidden" id="localIdParam" name="localIdParam" value="<c:out value="${localModDetail.localId}" escapeXml="false" />"/>
												<span id="orgIdMod" name="orgIdMod"><c:out value="${localModDetail.local}" escapeXml="false" /></span>
											</div>
									</td>
								</tr>
								<tr>
									<th>지역명</th>
									<td class="res-title-td">지역명</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
			                            	<div class="regi-dup-area-txt">
												<input type="hidden" id="localIdMod" value="${localModDetail.localId}">
												<span id="localNmMod"><c:out value="${localModDetail.local}" escapeXml="false" /></span>
											</div>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td class="res-title-td">주소</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">주소</div></p>
			                            	 <div class="regi-dup-area-txt">
												<span id="localAddressMainMod"><c:out value="${localModDetail.localAddressMain}" escapeXml="false" /></span>
												<span id="localAddressSubMod"><c:out value="${localModDetail.localAddressSub}" escapeXml="false" /></span>
											</div>
									</td>
								</tr>
								<tr>
									<th>경도</th>
									<td class="res-title-td">경도</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">경도</div></p>
			                            	<div class="regi-dup-area-txt">
												<span id="localNxMod"><c:out value="${localModDetail.localNx}" escapeXml="false" /></span>
											</div>
									</td>
								</tr>
								<tr>
									<th>위도</th>
									<td class="res-title-td">위도</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td res-detail-agency">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">위도</div></p>
			                            	<div class="regi-dup-area-txt">
												<span id="localNyMod"><c:out value="${localModDetail.localNy}" escapeXml="false" /></span>
											</div>
									</td>
								</tr>
							</tbody>
						</table>				
				</div>
				<div class="btn-area-reg-detail">
				  <button type="button" class="list-btn-agency-type2" onclick="fnCloseDetailModal()"><a>목록</a></button>
	              <button type="button" class="list-btn-agency-type2" id="user-reg-btn" onclick="fnShowModModal()"><a>수정</a></button>				  
				  <button type="button" class="cancel-btn-agency-type2" onclick="fnDel()">삭제</button>
	            </div>
	            <input type="hidden" id="localDelValidationCheck" value="false">
				<input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
				<input type="hidden" id=searchingLocalId name="searchingLocalId" value="${searchingLocalId}"/>
				<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
				<input type="hidden" id="sortType" name="sortType" value="${sortType}">
				<input type="hidden" id="page" name="page" value="${page}">
				<input type="hidden" id="range" name="range" value="${range}">
				<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
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
		</div>  
	<!-- 기관 상세조회 끝 -->
	
	
 </form>   
    
</body>
</html>

<!-- Modal -->
<div class="modal fade" id="delregi" tabindex="-1" role="dialog" aria-labelledby="delregiLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-fix-del" role="document">
    <div class="modal-content modal-content-fix-del">
      <div class="modal-header" style="border-bottom: 0px;">
        <h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
          <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
      </div>
      <div class="msg"></div>
      <div class="modal-body modal-body-content-del">
        선택한 지역을 삭제 하시겠습니까?
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