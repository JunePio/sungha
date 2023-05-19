<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : userMngDetail.jsp
 * @Description : 사용자관리 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.09  유성우      최초생성
 * @
 */
%>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 관리 상세조회</title>
    
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="/static/assets/css/user/list.css">
    <link rel="stylesheet" href="/static/assets/css/user/fonts.css">
    <link rel="stylesheet" href="/static/assets/css/user/style.css">
    <link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
	<script src="/static/js/filtering.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<script type="text/javascript">
	
	// 사용자관리 상세조회 모달에서 취소 버튼 클릭시
	function fnCloseDetailModal() {
		//$("#modalDetail").attr("style", "display:none"); // 사용자관리 상세조회 모달 닫기
		
		document.detailForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
		
	};
	
	// 관수정보 상세 모달에서 삭제 버튼 클릭시
	function fnDel() {
		
		if(confirm("선택한 사용자를 삭제 하시겠습니까?")) {
			$.ajax({
			    url: "/userMng/userMngDel.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	userId : $("#userIdParam").val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	if(data.delResult) {
			    		alert("삭제완료 하였습니다.");
			    		document.detailForm.action = '<c:url value="/userMng/userMngList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					    $("#detailForm").submit();
			    	} else {
			    		alert("삭제실패 하였습니다.");
			    		return false;
			    	}
			    	
			    }, 
			    error : function(arg){
				alert("관수정보 삭제 실패");
				
			    }
			});		
		}

	};
	
	function fnShowModModal() {	
		document.detailForm.action = '<c:url value="/userMng/userMngModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
		
	};
	
	</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/menu.jsp" %>

	<!-- 사용자관리 상세조회 시작 -->
	<div class="sh-main-detail">
      <div class="sh-header">
        <div class="title">
          <p class="title-txt">사용자 관리
            <span class="title-menu"> < 사용자 < 사용자 관리</span>
          </p>
        </div>
      </div>

      <div class="sh-content-detail">


          <div class="detail-info-user" >
            <div class="title-detail"><p class="title-detail-txt-user">사용자 관리 상세조회</p></div>
            <!-- table-->
            <div class="wrap-table-detail-user">
					<form id="detailForm" name="detailForm" action="/orgInfo/orgInfoDetail.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="detail-table1">
							<tbody>
								<tr>
									<th>사용자ID</th>
									<td>
										<span id="userIdDetail"><c:out value="${userMngDetail.username}" escapeXml="false"/></span>
										<input type="hidden" id="userIdParam" name="userIdParam" value="<c:out value="${userMngDetail.username}" escapeXml="false"/>"/>
									</td>
								</tr>
								<tr>
									<th>사용자 레벨</th>
									<td>
										<span id="userLevelDetail"><c:out value="${userMngDetail.roleName}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>사용자</th>
									<td>
										<span id="userNmDetail"><c:out value="${userMngDetail.name}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>연락처</th>
									<td>
										<span id="telNoDetail">010-<c:out value="${userMngDetail.telNoBody}" escapeXml="false"/>-<c:out value="${userMngDetail.telNoEnd}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>기관</th>
									<td>
										<span id="orgNmDetail"><c:out value="${userMngDetail.organization}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>
										<span id="emailDetail"><c:out value="${userMngDetail.emailHead}" escapeXml="false"/>@<c:out value="${userMngDetail.emailBody}" escapeXml="false"/></span>
									</td>
								</tr>
								<tr>
									<th>권한지역</th>
									<td>
										<span id="roleLocalDetail"><c:out value="${userMngDetail.locals}" escapeXml="false"/></span>
									</td>
								</tr>
							</tbody>
						</table>
						</div>
				          <!--button -->
				          <div class="btn-area-user">
				          	<button type="button" class="list-btn-user" onclick="fnCloseDetailModal()">목록</button>
				            <button type="button" class="list-btn-user" id="user-reg-btn" onclick="fnShowModModal()">수정</button>							
							<button type="button" class="del-btn-user" onclick="fnDel()">삭제</button>
				          </div>				         
				        </div>
				        <input type="hidden" id="searchingOrgId" name="searchingOrgId" value="${searchingOrgId}"/>
						<input type="hidden" id="searchingLocalId" name="searchingLocalId" value="${searchingLocalId}"/>
						<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
						<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
						<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
						<input type="hidden" id="sortType" name="sortType" value="${sortType}">
						<input type="hidden" id="page" name="page" value="${page}">
						<input type="hidden" id="range" name="range" value="${range}">
						<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
					</form>		
					
					<div class="space-list">
				      <footer class="footer-list">
				          <p class="mb-1"><span class="footer-bold-txt">(주)성하  대표이사: 조정윤</span> | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
				      </footer>
				    </div>
								
				</div>
			</div>
		</div>
		
	</div>
	<!-- 사용자관리 상세조회 끝 -->

	<!-- <script src="/static/assets/js/main.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script> 

</body>
</html>

<!-- Modal -->
<div class="modal fade" id="deluser" tabindex="-1" role="dialog" aria-labelledby="deluserLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-fix-del" role="document">
    <div class="modal-content modal-content-fix-del">
      <div class="modal-header" style="border-bottom: 0px;">
        <h5 class="modal-title-del" id="exampleModalLabel">삭제</h5>
          <span aria-hidden="true" class="close-modal-del"  data-dismiss="modal" aria-label="Close" style="visibility: show;">&times;</span>
      </div>
      <div class="msg"></div>
      <div class="modal-body modal-body-content-del">
        선택한 사용자를 삭제 하시겠습니까?
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