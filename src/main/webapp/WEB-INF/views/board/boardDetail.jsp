<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : boardDetail.jsp
 * @Description : Q&A 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.10  이창호      최초생성
 * @ 2023.05.04  이준영      전반적인 css수정 추가,메뉴, 푸터 추가
 * @ 2023.05.17  이준영      기능 구현 ,css통합
 */
%>
<html>
<head>
<meta charset="UTF-8">
	<title>Q&A 상세조회</title>
	<script src="/js/filtering.js"></script>
	<link rel="stylesheet"
		  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script type="text/javascript" src="/static/assets/js/common.js"></script>
	<style>
	
		th, td {
			text-align: center;
		}
		
		textarea {
			width: 95%;
			height: 6.25em;
			resize: none;
		}
		/*.main-content{height:auto !important;}*/
		/*.sh-content-detail{height:auto !important;}*/
	
	</style>
	<script type="text/javascript">
	
	// 목록 버튼 클릭시
	function fnCloseDetailModal() {
		
		document.detailForm.action = '<c:url value="/board/boardList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 저장버튼 클릭시
	function fnReplySave(){
		var writerId = $("#writerIdRegist").text();	
		//var content = $("#contentRegist").val();
		var content = $("#boardDetailRegist").val();
		var boardId = $("#boardId").val();

		if(content == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}

		$.ajax({
			url: "/board/boardReplySave.do",
		    type: "POST",
		    async: false,
		    //dataType: "json",
		    data: {
		    	writerId : writerId,
		    	content : content,
		    	boardId : boardId
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				if(data.saveResult) {
					alert("댓글 저장완료 하였습니다.");
					//document.detailForm.action = '<c:url value="/board/boardDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
				    //$("#detailForm").submit();
					location.reload();
					
				} else {
					alert("댓글 저장실패 하였습니다.");
				}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			alert(JSON.stringify(arg));
		    }
		});
	};
	
	// Q&A 상세에서 삭제 버튼 클릭시
	function fnDel() {
		
		if(confirm("선택한 Q&A를 삭제 하시겠습니까?")) {
			$.ajax({
			    url: "/board/boardDel.do",
			    type: "POST",
			    async: false,
			    //dataType: "json",
			    data: {
			    	boardId : $("#boardIdParam").val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	if(data.delResult) {
			    		alert("삭제완료 하였습니다.");
			    		document.detailForm.action = '<c:url value="/board/boardList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					    $("#detailForm").submit();
			    	} else {
			    		alert("삭제실패 하였습니다.");
			    		return false;
			    	}
			    	
			    }, 
			    error : function(arg){
				alert("Q&A정보 삭제 실패");
				
			    }
			});		
		}

	};
	
	// Q&A정보 상세조회에서 수정 버튼 클릭시
	function fnShowModModal() {
		// $("#boardIdMod").val($("#boardIdDetail").text());
		var boardId = $("#boardId").val();
		$.ajax({
			url: "/board/boardModDetail.do",
			type: "POST",
			async: false,
			//dataType: "json",
			data: {
				boardId : boardId
			},
			//contentType: "application/json",
			success : function(data) {
				//alert("통신성공시에만 실행");
				if(data.saveResult) {
					// alert("댓글 저장완료 하였습니다.");
					//document.detailForm.action = '<c:url value="/board/boardDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					//$("#detailForm").submit();
					// location.reload();
					document.detailForm.action = '<c:url value="/board/boardModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					$("#detailForm").submit();

				} else {
					// alert("댓글 저장실패 하였습니다.");
				}

			},
			error : function(arg){
				// alert("통신실패시에만 실행");
				// alert(JSON.stringify(arg));
			}
		});

		
	};
	
	// 페이지 로드시 댓글등록 폼 안보이게
	window.onload = function(){
		$("#modalReply").attr("style", "display:none");
		
		//$(".divSelect").attr("style", "display:none");
		$(".divMod").attr("style", "display:none");
		$(".locationDetailRegist").attr("style", "display:none");
		$(".divTextCount").attr("style", "display:none");
		$(".fileUpload").attr("style", "display:none");
		
	};
	
	// 댓글등록 버튼시 
	function fnShowReplyRegistForm() {
		$("#modalReply").attr("style", "display:block");
	};
	
	// 댓글등록 폼에서 취소버튼 클릭시 
	function fnCancel() {
		$("#modalReply").attr("style", "display:none");
	}
	
	//댓글등록시 textarea 바이트 수 체크하는 함수
	function fnCheckByteReply(event, obj){
		
		fnTextAreaPressSpecial(event, obj); // 특수문자 제거
		
	    const maxByte = 100; //최대 100바이트
	    const text_val = obj.value; //입력한 문자
	    const text_len = text_val.length; //입력한 문자수
	    var count = 0;
	    let totalByte=0;
	    for(let i=0; i<text_len; i++){
	    	const each_char = text_val.charAt(i);
	        const uni_char = escape(each_char); //유니코드 형식으로 변환
	        if(uni_char.length>4){
	        	// 한글 : 2Byte
	            totalByte += 2;
	        	count += 1;
	        }else{
	        	// 영문,숫자,특수문자 : 1Byte
	            totalByte += 1;
	        	count += 1;
	        }
	        
	        if(totalByte >= maxByte) {
	        	break;
	        }
	    }
	    
	    obj.value = obj.value.substr(0, count);
    	if(totalByte > maxByte){
    		fnCheckByteReply(event, obj);
			document.getElementById("textareaByteCnt").innerText = totalByte;
            document.getElementById("textareaByteCnt").style.color = "red";
            alert('최대 100Byte까지만 입력가능합니다.');
        }else{
        	document.getElementById("textareaByteCnt").innerText = totalByte;
            document.getElementById("textareaByteCnt").style.color = "green";
        }
    	
	};
	
	//댓글수정시 textarea 바이트 수 체크하는 함수
	function fnCheckByteMod(event, obj, cnt){
		
		fnTextAreaPressSpecial(event, obj); // 특수문자 제거
		
	    const maxByte = 100; //최대 100바이트
	    const text_val = obj.value; //입력한 문자
	    const text_len = text_val.length; //입력한 문자수
	    var count = 0;
	    let totalByte=0;
	    for(let i=0; i<text_len; i++){
	    	const each_char = text_val.charAt(i);
	        const uni_char = escape(each_char); //유니코드 형식으로 변환
	        if(uni_char.length>4){
	        	// 한글 : 2Byte
	            totalByte += 2;
	        	count += 1;
	        }else{
	        	// 영문,숫자,특수문자 : 1Byte
	            totalByte += 1;
	        	count += 1;
	        }
	        
	        if(totalByte >= maxByte) {
	        	break;
	        }
	    }
	    
	    obj.value = obj.value.substr(0, count);
    	if(totalByte > maxByte){
    		fnCheckByteMod(event, obj);
			document.getElementById("textareaByteCnt"+cnt).innerText = totalByte;
            document.getElementById("textareaByteCnt"+cnt).style.color = "red";
            alert('최대 100Byte까지만 입력가능합니다.');
        }else{
        	document.getElementById("textareaByteCnt"+cnt).innerText = totalByte;
            document.getElementById("textareaByteCnt"+cnt).style.color = "green";
        }
    	
	};
	
	// 댓글 수정 버튼(폼 변경) 클릭시
	function fnReplyModFormChange(count) {
		$("#titleDetail"+count).attr("style", "display:none");
		document.getElementById("contentMod"+count).type = "text";
		$("#contentMod"+count).val($("#contentMod"+count).text());
		$("#contentMod"+count).attr("style", "display:block");
		
		$("#divSelect"+count).attr("style", "display:none"); // 댓글수정 버튼, 댓글삭제버튼 안보이게
		$("#divMod"+count).attr("style", "display:block"); // 수정버튼, 취소버튼 보이게
		$("#divTextCount"+count).attr("style", "display:block"); // 바이트수 보이게
				   	
		//var event = document.createEvent("Events");
		//event.initEvent('keydown', true, true);
		//event.keyCode = 13;
		//document.getElementById('locationDetailRegist'+count).dispatchEvent(event);

		$("#modalReplyList"+count).focus(); // 해당 폼으로 포커스 이동
	};
	
	// 댓글 수정 폼에서 수정버튼 클릭시  
	function fnReplyMod(count) {
		
		var replyId = $("#replyIdMod"+count).val();	
		var writerId = $("#writerIdDetail"+count).val();
		var content = $("#contentMod"+count).val();
		var locationDetail = $("#locationDetailRegist"+count).val();
		
		if(content == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		
		$.ajax({
		    url: "/board/boardReplyMod.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	replyId : replyId,
		    	writerId : writerId,
		    	content : content,
		    	locatoinDetail : locationDetail
		    },
		    //contentType: "application/json",
		    success : function(data) {
		    	if(data) {
		    		alert("수정완료 하였습니다.");
		    		location.reload();
		    	} else {
		    		alert("수정실패 하였습니다.");
		    		return false;
		    	}
		    	
		    }, 
		    error : function(arg){
			alert("댓글 수정 실패");
			
		    }
		});		
		
	};
	
	// 댓글 삭제 버튼 클릭시
	function fnDelReply(count) {
		if(confirm("댓글을 삭제 하시겠습니까?")) {
			$.ajax({
			    url: "/board/boardReplyDel.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	replyId : $("#replyIdMod" + count).val()
			    },
			    //contentType: "application/json",
			    success : function(data) {
			    	if(data.delResult) {
			    		alert("삭제완료 하였습니다.");
			    		location.reload();
			    	} else {
			    		alert("삭제실패 하였습니다.");
			    		return false;
			    	}
			    	
			    }, 
			    error : function(arg){
				alert("댓글 삭제 실패");
				
			    }
			});		
		}
	};
	
	// 댓글 수정 취소 버튼 클릭시
	function fnModCancel(count) {
		$("#titleDetail"+count).attr("style", "display:block");
		//document.getElementById("titleMod"+count).type = "hidden";
		//$("#titleMod"+count).val("");
		//$("#titleMod"+count).attr("style", "display:none");		
		$("#divSelect"+count).attr("style", "display:display");
		$("#divMod"+count).attr("style", "display:none");
		$("#divTextCount"+count).attr("style", "display:none"); // 바이트수 안보이게
	};
	
	</script>
</head>
<body>	
	<!-- Q&A 상세 조회 시작 -->
	<div class="sh-app">
		<%@ include file="/WEB-INF/views/menu.jsp" %>
		<div class="sh-main">
			<div class="sh-header">
				<div class="title">
					<p class="title-txt">상세조회
						<span class="title-menu"> < 1:1 문의 < 상세조회</span>
					</p>
				</div>
			</div>
			<div id="modalDetail" class="modal-overlay">
			<div class="sh-content">
				<div class="main-content" headline="Stats">
					<form id="detailForm" name="detailForm" action="/board/boardList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="sh-content-detail">
							<div class="reg-info-agency" >
								<div class="reg-title  require-pc-show"><p class="body-1-bold">상세조회</p>
								</div>
								<table class="detail-table1">
									<tbody>
									<tr>
										<th>제목 </th>
										<td class="res-title-td">제목</td>
										<td class="reg-input1">
											<div class="res-reg-td res-detail-agency">
												<p class="pc-title-td body-3-bold"><div class="div-require">제목</div></p>

												<div class="agency-dup-area-txt"><c:out value="${boardDetail.title}" escapeXml="false" />
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td class="reg-select-td">
											<div class="res-reg-td res-detail-agency">
												<p class="pc-title-td body-3-bold"><div class="div-require">작성자</div></p>
												<div class="agency-dup-area-txt"><c:out value="${boardDetail.writerId}" escapeXml="false" />
												</div>
											</div>
										</td>
									</tr>

									<tr>
										<th>문의종류</th>
										<td class="reg-select-td">
											<div class="res-reg-td res-detail-agency">
												<p class="pc-title-td body-3-bold"><div class="div-require">문의종류</div></p>
												<div  id="qaGubunDetail" name="qaGubunDetail" class="agency-dup-area-txt">
													<c:if test="${boardDetail.qaGubun eq '1'}">센서</c:if>
													<c:if test="${boardDetail.qaGubun eq '2'}">관수</c:if>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<th>내용 </th>
										<td class="res-title-td">내용</td>
										<td class="reg-input1">
											<div class="res-reg-td">
												<p class="pc-title-td body-3-bold"><div class="div-require">내용</div></p>
												<div class="agency-dup-area-txt">
													<c:out value="${boardDetail.content}" escapeXml="false" />
												</div>
											</div>
										</td>
									</tr>

								<tr>
									<td colspan="2" align="center">
										<div  float="center">
											<button type="button" class="list-btn-agency-type2" id="reply-reg-btn" ><span onclick="fnShowReplyRegistForm()">댓글등록</span></button>
											<button type="button" class="list-btn-agency-type2" id="user-reg-btn"> <span onclick="fnShowModModal()">수정</span></button>
											<button type="button" class="list-btn-agency-type2" ><span onclick="fnCloseDetailModal()">목록</span></button>
											<button type="button" class="list-btn-agency-type2" ><span onclick="fnDel()">삭제</span></button>
											<input type="hidden" id="boardIdParam" name="boardIdParam" value="${boardDetail.boardId}"/>
											<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
											<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
											<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
											<input type="hidden" id="sortType" name="sortType" value="${sortType}">
										</div>
									</td>
								</tr>
							</tbody>
						</table>
							</div>
						</div>
					</form>
				</div>
			</div>
	<!-- Q&A 상세 조회 끝 -->

				<div id="modalDetail" class="modal-overlay">
			<div class="sh-content"id="modalReply" >
				<div class="main-content" headline="Stats">
					<form id="replyForm" name="replyForm" action="/board/boardReplyList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="sh-content-detail">
							<div class="reg-info-agency" >
								<div class="reg-title  require-pc-show"><p class="body-1-bold"id="modal-title">댓글등록</p>
								</div>
								<table class="detail-table1">
									<tbody>
									<tr>
										<th>작성자ID </th>
										<td class="res-title-td">작성자ID</td>
										<td class="reg-input1">
											<div class="agency-dup-area-txt"><c:out value="${boardDetail.writerId}" escapeXml="false" />
											</div>
										</td>
									</tr>
									<tr>
										<th>내용 </th>
										<td class="res-title-td">내용</td>
										<td class="reg-input1">
											<div class="res-reg-td">
												<p class="pc-title-td body-3-bold"><div class="div-require">내용</div></p>
												<textarea id="boardDetailRegist" name="boardDetailRegist" onkeydown="fnCheckByteReply(event, this)" onkeyup="fnCheckByteReply(event, this)"></textarea>
												<p>
													<span id="textareaByteCnt"></span> byte / 100 byte
												<p>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="4" name="tdAlign">
											<div class="modal-button">
												<button type="button" class="list-btn-agency-type2"><span onclick="fnReplySave()">댓글등록</span></button>
												<button type="button" class="list-btn-agency-type2"><span onclick="fnCancel()">취소</span></button>
												<input type="hidden" id="boardId" name="boardId" value="${boardDetail.boardId}"/>
												<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
												<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
											</div>
										</td>
									</tr>
	<!-- Q&A 댓글 등록 시작 -->
							</tbody>
						</table>
							</div>
						</div>
					</form>
				</div>
			</div>

	<!-- Q&A 댓글 등록 끝 -->

	
	<c:choose>
	<c:when test="${empty boardReplyList}">
		
	</c:when>
	<c:otherwise>
		<c:forEach var="item" items="${boardReplyList}" varStatus="status">
		<!-- Q&A 댓글 리스트 시작 -->
		<div id="modalReplyList${status.count}" class="modal-overlay">
			<div class="sh-content">
				<div class="main-content" headline="Stats">
					<div class="sh-content-detail">
					<div class="reg-info-agency" >
						<div class="reg-title  require-pc-show"><p class="body-1-bold">댓글<c:out value="${status.count}" escapeXml="false" /></p>
						</div>
					</div>
						<form id="replyListForm${status.count}" name="replyListForm" action="/board/boardReplyList.do" method="post">
							<input type="hidden" value="I" id="type" name="type">
							<table class="detail-table1">
								<tbody>
									<tr>
										<th>작성자ID</th>
										<td class="res-title-td">작성자ID</td>
										<td>
											<span id="writerIdDetail${status.count}" name="writerIdDetail${status.count}"><c:out value="${item.writerId}" escapeXml="false" /></span>
											<input type="hidden" id="replyIdMod${status.count}" name="replyIdMod${status.count}" value="<c:out value="${item.replyId}" escapeXml="false" />"/>
										</td>
									</tr>
									<tr>
										<th>내용</th>
										<td class="res-title-td">내용</td>
										<td>
											<span id="contentDetail${status.count}" name="contentDetail${status.count}"><c:out value="${item.content}" escapeXml="false" /></span>
											<input type="hidden" id="contentMod${status.count}" name="contentMod${status.count}" value="<c:out value="${item.content}" escapeXml="false" />"/>
										</td>
									</tr>
									<tr>
										<th>등록일시</th>
										<td class="res-title-td">등록일시</td>
										<td>
											<span id="regDateTimeDetail${status.count}" name="regDateTimeDetail${status.count}"><c:out value="${item.regDateTime}" escapeXml="false" /></span>
										</td>
									</tr>
									
									<tr>
										<td colspan="2" align="center">
											<div  float="center">
											<div id="divSelect${status.count}" class="divSelect" align="center">
												<button type="button" id="modChangeForm${status.count}" class="list-btn-agency-type2"><span onclick="fnReplyModFormChange('${status.count}')">댓글수정</span></button>
												<button type="button" id="modDel${status.count}" class="list-btn-agency-type2"><span onclick="fnDelReply('${status.count}')">댓글삭제</span></button>
											</div>
											<div id="divMod${status.count}" class="divMod" align="center">
												<button type="button" id="mod${status.count}" class="list-btn-agency-type2"><span onclick="fnReplyMod('${status.count}')">수정</span></button>
												<button type="button" id="modCancel${status.count}" class="list-btn-agency-type2"><span onclick="fnModCancel('${status.count}')">취소</span></button>
											</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
			</c:forEach>
			</c:otherwise>
			</c:choose>
			<%@ include file="/WEB-INF/views/footer.jsp" %>
		</div>
		<!-- Q&A 댓글 리스트 끝 -->
		

</body>
</html>
