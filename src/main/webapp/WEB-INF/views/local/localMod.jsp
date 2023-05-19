<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%
/**
 * @Class Name : sensorRegist.jsp
 * @Description : 센서정보 등록 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.01.09  유성우      최초생성
 * @
 */
%>
<html lang="en" class="no-js">
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 정보관리</title>
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
	
	<style>
	
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
	
	</style>

	<script type="text/javascript">
	
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
	
	// 기관정보 수정 모달에서 취소 버튼 클릭시
	function fnCloseModModal() {
		//$("#modalMod").attr("style", "display:none"); // 기관정보 수정 모달 닫기
		
		document.modForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#modForm").submit();
		
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
		
		$.ajax({
		    url: "/local/localMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	orgIdMod : orgIdMod,
		    	localIdMod : localIdMod,
		    	localNmMod : localNmMod,
		    	localAddressMainMod : localAddressMainMod,
		    	localAddressSubMod : localAddressSubMod,
		    	localNxMod : localNxMod,
		    	localNyMod : localNyMod
		    },
		    //contentType: "application/json",
		    success : function(data) {
		    	if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
			    	alert("수정완료 하였습니다.")
			    	document.modForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
				    $("#modForm").submit();
		    	} else {
					alert("수정실패 하였습니다.");
				}
		    }, 
		    error : function(arg){
			alert("지역정보 삭제 실패");
			
		    }
		});
		
	};
	
	</script>
</head>
<body>	
<%@ include file="/WEB-INF/views/menu.jsp" %>
	<!-- 지역 수정조회 시작 -->
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

	<form id="modForm" name="modForm" action="/local/localMod.do" method="post" enctype=”multipart/form-data”>
      <div class="sh-content-detail">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">지역 정보관리 수정</p>
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
			                         <div class="res-reg-td">
			                          <p class="pc-title-td body-3-bold"><div class="div-require">기관명</div></p>
										<select class="dropdown-sel reg-select res-sel" id="orgIdMod" name="orgIdMod">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}">${item.organization}</option>
											</c:forEach>
										</select>
									</div>
									</td>
								</tr>
								<tr>
									<th>지역명</th>
									<td class="reg-select-td">
			                        <div class="res-reg-td">
			                          <p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
			                          <div class="regi-area-type1">
										<input type="hidden" id="localIdMod" name="localIdMod" value="${localModDetail.localId}">
										<input type="text" class="input-reg-irr" id="localNmMod" name="localNmMod" onkeyup="fnPressSpecial(event, this)" value="${localModDetail.local}">
									</div>
									</div>
									</td>
								</tr>
								<tr>
									<th>주소</th>
									<td class="res-title-td">주소</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">                     
			                          <p class="pc-title-td body-3-bold"><div class="div-require">주소</div></p>
			                            <div class="regi-loc-area">
			                                <div class="addr-type1">
												<input type="text" class="input-reg-irr addr1" id="localAddressMainMod" name="localAddressMainMod" value="${localModDetail.localAddressMain}" disabled>
												<button class="reg-btn-irr-loc" id="searchingAddressMod" value="검색" onclick="fnAddressSearchingMod()">주소검색</button><p>
												<input type="text" class="input-reg-irr addr2" id="localAddressSubMod" name="localAddressSubMod" onkeyup="fnPressAddress(event, this)" value="${localModDetail.localAddressSub}">
											</p>
										</div>
									  </div>
									</td>
								</tr>
								<tr>
									<th>경도</th>
									<td class="res-title-td">경도</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">경도</div></p>
			                            	<div class="agency-two-user">
												<span id="localNxMod" name="localNxMod"><c:out value="${localModDetail.localNx}" escapeXml="false" /></span>
											</div>
									</div>
									</td>
								</tr>
								<tr>
									<th>위도</th>
									<td class="res-title-td">위도</td>
			                        <td class="reg-input1">
			                          <div class="res-reg-td">
			                            <p class="pc-title-td body-3-bold"><div class="div-require">위도</div></p>
			                            	<div class="agency-two-user">
												<span id="localNyMod" name="localNyMod"><c:out value="${localModDetail.localNy}" escapeXml="false" /></span>
											</div>
									</div>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
				            <!--button -->
				            <div class="btn-area-reg">
				              <button class="list-btn agency-btn-loc" type="button" class="btn-confirm" id="user-reg-btn" onclick="fnMod()"><a>저장</a></button>
							  <button class="cancel-btn agency-btn-loc-c" type="button" class="modal-close" onclick="fnCloseModModal()">취소</button>
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
				    </form>
				</div>
			 
			
	
	<!-- 지역 수정조회 끝 -->
	
</body>
</html>

<!-- Modal -->
<div class="modal fade" id="delagency" tabindex="-1" role="dialog" aria-labelledby="delagencyLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-fix-del" role="document">
    <div class="modal-content modal-content-fix-del">
      <div class="modal-header" style="border-bottom: 0px;">
        <h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
          <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
      </div>
      <div class="msg"></div>
      <div class="modal-body modal-body-content-del">
        선택한 지역를 삭제 하시겠습니까?
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