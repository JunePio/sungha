<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : roleLocal.jsp
 * @Description : 권한지역 선택 팝업
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
    <title>권한지역 선택</title>
  
  	<link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" href="/static/assets/css/user/list.css">
	<link rel="stylesheet" href="/static/assets/css/user/fonts.css">
	<link rel="stylesheet" href="/static/assets/css/user/style.css">
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.7/css/all.css">
  
	<script src="/static/js/filtering.js"></script>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    
	<script type="text/javascript">
	var localIdArray = new Array(); // 전역변수 지역ID 저장
	var localArray = new Array(); // 전역변수 지역명 저장
	
	// 검색 버튼을 누른 경우
	function fnSearchingLocal() {
		$("#searchForm").submit(); // 서버로 전송
		
	}
	
	// 모두 체크를 체크한 경우
	function fnTotalCheckChange(selectAll) {
		const checkboxes = document.getElementsByName('eachCheck'); // 이름을 다 가져온다.
	  	
	  	checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked; // 모두체크를 체크하면 각각 체크되게 한다.
			if(checkbox.id != "totalCheck") { // forEach돌 때 전체체크가 아닌 항목을 만날시
				fnCheckChange(checkbox.id, checkbox.value); //  체크박스 각각 체크에 따른 변경 처리
			}
	    })
		
	};
	
	// 체크박스 체크에 따른 변경 처리
	function fnCheckChange(localId, local) {
		if($('#'+localId).is(":checked")) { // 체크되었을 경우
			localIdArray.push(localId); // 지역ID 저장
			localArray.push(local); // 지역명 저장
		} else { // 체크해제 되었을 경우
			
			for(var i = 0; i < localIdArray.length; i++) {
				if(localIdArray[i] == localId) {
					localIdArray.splice(i, 1); // 체크 해제된 지역ID 제거
					localArray.splice(i, 1); // 체크 해제된 지역명 제거
					break;
				}
			}
		}
		
	};
	
	// 확인 버튼 클릭시
	function fnSend() {
		var roleLocalId = window.opener.document.getElementById("roleLocalId"); // 부모창에 지역ID 넘겨주기
		var roleLocal = window.opener.document.getElementById("roleLocal"); // 부모창에 지역명 넘겨주기
		roleLocalId.value = localIdArray;
		roleLocal.value = localArray;
		localIdArray = new Array();
		localArray = new Array();
		window.close();
		
	};
	
	// 취소 버튼 클릭시
	function fnClose() {
		localIdArray = new Array();
		localArray = new Array();
		window.close();
	}

</script>
</head>
<body>
	<form id="searchForm" action="/userMng/roleLocalSearchList.do" method="post">
	<input type="text" class="manage-txt-input" name="searchingContent" value="${searchingContent}" />
	<button type="button" id="modal_opne_btn" class="dup-chk-btn-reg" onclick="fnSearchingLocal()">검색</button>
	<input type="hidden" id="registOrgId" name="registOrgId" value="${registOrgId}" />
	<p>
	<table id="orgList" class="detail-table1">
	<c:choose>
	<c:when test="${empty roleLocalList}">
		<tbody id="tbody">
			<tr>
				<th>
					조회된 결과가 없습니다.
				</th>
			</tr>
		</tbody>
	</c:when>
	<c:otherwise>
		<input type="checkbox" id="totalCheck" name="eachCheck" onclick="fnTotalCheckChange(this)"><span class="manage-txt-input">모두선택</span>
		<c:forEach var="item" items="${roleLocalList}" varStatus="status">
		<tbody id="tbody">
			<tr>
				<td id="check"><input type="checkbox" id="${item.localId}" name="eachCheck" value="${item.local}" onchange="fnCheckChange('${item.localId}', '${item.local}')"><span class="manage-txt-input" id="${item.localId}">${item.local}</span></td>
			</tr>
		</tbody>
		</c:forEach>
	</c:otherwise>
	</c:choose>
	</table>
	<input type="button" class="list-btn-user" id="confirm" name="confirm" value="확인" onclick="fnSend()"><input type="button" class="del-btn-user" id="cancel" name="cancel" value="취소" onclick="fnClose()">
	</form>
</body>
</html>