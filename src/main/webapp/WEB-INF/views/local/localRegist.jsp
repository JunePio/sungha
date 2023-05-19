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
	<style>

		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
	
	</style>

	<script type="text/javascript">
	
	// 등록버튼 클릭시
	function fnShowRegModal() {
		
	};
	
	// 취소 버튼 클릭시
	function fnCloseRegModal() {
		document.regForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#regForm").submit();
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
			            alert("경도, 위도 가져오기 실패");
			        }
			     });
	            
	            
	        }
	    }).open();
	};
	
	// 저장버튼 클릭시
	function fnSave(){
		var localNm = $("#inputLocalNm").val();
		var registOrgId = $("#registOrgId").val();
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
		
		$.ajax({
		    url: "/local/localSave.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	localNm : localNm,
		    	registOrgId : registOrgId,
		    	localAddressMain : localAddressMain,
		    	localAddressSub : localAddressSub,
		    	localNx : localNx,
		    	localNy : localNy
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				if(data.saveResult) {
					alert("저장완료 하였습니다.");
					document.regForm.action = '<c:url value="/local/localList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
				    $("#regForm").submit();
					
				} else {
					alert("저장실패 하였습니다.");
				}

		    }, 
		    error : function(arg){
			alert("저장 실패");
			
		    }
		});

	};
	
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/menu.jsp" %>

<!-- 지역등록 시작 -->
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

	<form id="regForm" name="regForm" action="/local/localSave.do" method="post" enctype=”multipart/form-data”>
      <div class="sh-content-detail">
          <div class="reg-info-agency" >
            <div class="reg-title  require-pc-show"><p class="body-1-bold">지역 정보관리 등록</p>
              <p class=""><span class="required">*</span>필수입력</p>
            </div>
            <div class="res-require-title"><span class="required">*</span>필수입력</div>
            <!-- table-->
            <div class="wrap-table-detail-regi">
				
					<input type="hidden" value="I" id="type" name="type">
					<table class="detail-table1">
						<tbody>
							<tr>
								<th>기관명 <span class="required">*</span></th> 
			                        <td class="res-title-td">기관명<span class="required">*</span></td>
			                        <td class="reg-input1">
			                         <div class="res-reg-td">
			                          <p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
										<select class="dropdown-sel reg-select res-sel" id="registOrgId" name="registOrgId">
											<c:forEach var="item" items="${orgNmList}" varStatus="status">
												<option value="${item.organizationId}">${item.organization}</option>
											</c:forEach>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<th>지역명<span class="required">*</span></th> 
								<td class="reg-input1">
		                          <div class="res-reg-td">
		                            <p class="pc-title-td body-3-bold"><div class="div-require">지역명</div></p>
										<input type="text" class="input-reg-irr" value="" id="inputLocalNm" name="inputLocalNm" maxlength="30" onkeyup="fnPressSpecial(event, this)">
								</td>
							</tr>
							<tr>
								<th>주소 <span class="required">*</span></th> 
		                        <td class="res-title-td">주소<span class="required">*</span></td>
		                        <td class="reg-input1">
		                          <div class="res-reg-td">                     
		                          <p class="pc-title-td body-3-bold"><div class="div-require">주소</div></p>
		                            <div class="regi-loc-area">
		                                <div class="addr-type1">
									<input class="input-reg-irr addr1" type="text" value="" id="inputLocalAddressMain" name="inputLocalAddressMain" maxlength="50" disabled>
									<button class="reg-btn-irr-loc" id="addressSearchingBtn" onclick="fnAddressSearchingRegist()">검색</button>
									<input class="input-reg-irr addr2" type="text" value="" id="inputLocalAddressSub" name="inputLocalAddressSub" maxlength="50" onkeyup="fnPressAddress(event, this)">
								</td>
							</tr>
							<tr>
								<th>경도</th>
								<td class="res-title-td">경도</td>
		                        <td class="reg-input1">
		                          <div class="res-reg-td">
		                            <p class="pc-title-td body-3-bold"><div class="div-require">경도</div></p>
		                            	<div class="agency-two-user">
											<span id="localNxRegist"></span>
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
											<span id="localNyRegist"></span>
										</div>
								</div>
								</td>
							</tr>
						</tbody>
					</table>
					</div>
		           <!--button -->
		           <div class="btn-area-reg">
		             <button class="list-btn agency-btn-loc" id="user-reg-btn" onclick="fnSave()"><a>저장</a></button>
					 <button class="cancel-btn agency-btn-loc-c" id="modal_close_btn" class="modal-close" onclick="fnCloseRegModal()">취소</button>
		           </div>
			        
			        <input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
					<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
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
		</form>
<!-- 지역등록 끝 -->

</body>
</html>