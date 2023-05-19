<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : boardMod.jsp
 * @Description : Q&A정보 수정 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.10  이창호      최초생성
 * @ 2023.05.17  이준영      css통합,기능구현
 */
%>
<html>
<head>
<meta charset="UTF-8">
	<title>Q&A 수정</title>

	<script src="/js/filtering.js"></script>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<style>
		.res-reg-td span {
			display: inline!important;
		}

		th, td {
			text-align: center;
		}
		
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
	
	</style>
	<script type="text/javascript">
	
	var globalCount = 0;
	
	// Q&A정보 수정 모달에서 취소 버튼 클릭시
	function fnCloseModModal() {
		document.modForm.action = '<c:url value="/board/boardDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#modForm").submit();
	};

	//수정시 textarea 바이트 수 체크하는 함수
	function fnCheckByte(event, obj){
		const maxByte = 100; //최대 100바이트
		var text_val = obj.value; //입력한 문자
		var utf8Bytes = new TextEncoder().encode(text_val);
		var text_length = utf8Bytes.length;
		if(text_length > maxByte){
			document.getElementById("textareaByteCnt").innerText = text_length;
			document.getElementById("textareaByteCnt").style.color = "red";
			alert('최대 100Byte까지만 입력가능합니다.');
		}else{
			document.getElementById("textareaByteCnt").innerText = text_length;
			document.getElementById("textareaByteCnt").style.color = "green";
		}
	};
	
	
	// Q&A정보 수정 모달에서 저장 버튼 클릭시
	function fnMod() {
		
		var writerId = $("#writerIdMod").text();
		var title = $("#titleMod").val();
		var content = $("#textArea_byteLimitMod").val();
		var qaGubun = $("#qaGubunMod").val();
		var boardId = $("#boardIdParam").val();
		
		if(writerId == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(title == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(content == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		} else if(qaGubun == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		$.ajax({
		    url: "/board/boardMod.do",
		    type: "POST",
		    async: false,
		    data: {
		    	writerId : writerId,
		    	title : title,
		    	content : content,
		    	qaGubun : qaGubun,
				boardId : boardId
		    },
		    success : function(data) {
			if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
				alert("수정완료 하였습니다.");
				document.modForm.action = '<c:url value="/board/boardList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			    $("#modForm").submit();
				
			} else {
				alert("수정실패 하였습니다.");
				return false;
			}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			alert(JSON.stringify(arg));
		    }
		});
		
	};
	
	// 로딩시 textarea에서 글자 byte수를 세기 위해서 일부러 엔터 이벤트 발생
	window.onload = function(){
	   $("#textArea_byteLimitMod").focus();
	   	
	   var event = document.createEvent("Events");
	   event.initEvent('keydown', true, true);
	   event.keyCode = 13;
	   document.getElementById('textArea_byteLimitMod').dispatchEvent(event);
	   	   	  
	};

	</script>
</head>
<body>
	
	<!-- layer popup 3 -->
	<div id="modalMod" class="modal-overlay">
		<div class="modal-wrap">
			<div class="modal-content">
				<div class="modal-head">
					<h3 id="modal-title">수정조회</h3>
				</div>
				<div class="modal-body">
					<form id="modForm" name="modForm" action="/board/boardMod.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<table class="tb-default" border="1">
							<tbody>
								<tr align="center">
									<th width="100">제목</th>
									<td>
										<span id="titleMod"><c:out value="${boardModDetail.titleMod}" escapeXml="false" /></span>
										<input type="hidden" id="boardIdParam" name="boardIdParam" value="${boardModDetail.boardId}"/>
									</td>
								</tr>
								<tr align="center">
									<th width="100">작성자</th>
									<td>
										<input type="text" id="writerIdMod" maxlength="20" onkeyup="fnPressHanSpecial(event, this)" value="${boardModDetail.writerId}">
									</td>
								</tr>
								<tr align="center">
									<th width="100">문의종류</th>
									<td>
										<select id="qaGubunMod" name="qaGubunMod">
											<option value="${boardModDetail.writerId}">센서</option>
											<option value="${boardModDetail.writerId}">관수</option>
										</select>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td colspan="3">
										<textarea id="textArea_byteLimitMod" name="textArea_byteLimitMod" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"><c:out value="${sensorInfoModDetail.sensorDetail}" escapeXml="false" /></textarea>
										<p>
										<span id="textareaByteCnt"></span> byte / 100 byte
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<div class="modal-button">
											<button type="button" class="btn-confirm" id="user-reg-btn" onclick="fnMod()">저장</button>
											<button type="button" class="modal-close" onclick="fnCloseModModal()">취소</button>
											<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
											<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
											<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
											<input type="hidden" id="sortType" name="sortType" value="${sortType}">
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>					
				</div>
			</div>
		</div>
		<div class="modal-layer"></div>
	</div>
	<!-- //layer popup 3 -->
	
</body>
</html>
