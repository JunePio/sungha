<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : noticeDetail.jsp
 * @Description : 공지사항 상세 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.13  이창호      최초생성
 * @ 2023.05.03   이준영     전반적인 css추가,수정 ,메뉴, 푸터 추가
 */
%>
<html>
<head>
<meta charset="UTF-8">
	<title>공지사항 상세조회</title>
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
	
	</style>
	<script type="text/javascript">
	
	// 목록 버튼 클릭시
	function fnCloseDetailModal() {
		
		document.detailForm.action = '<c:url value="/notice/noticeList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 저장버튼 클릭시
	function fnSave(){
		var writerId = $("#writerIdRegist").text();	
		//var content = $("#contentRegist").val();
		var content = $("#noticeDetailRegist").val();
		var boardId = $("#boardId").val();

		if(content == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}

		$.ajax({
			url: "/notice/noticeSave.do",
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
					alert("저장완료 하였습니다.");
					//document.detailForm.action = '<c:url value="/notice/noticeDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
				    //$("#detailForm").submit();
					location.reload();
					
				} else {
					alert("저장실패 하였습니다.");
				}

		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			alert(JSON.stringify(arg));
		    }
		});
	};
	
	// 공지사항 상세에서 삭제 버튼 클릭시
	function fnDel() {
		
		if(confirm("선택한 공지사항를 삭제 하시겠습니까?")) {
			$.ajax({
			    url: "/notice/noticeDel.do",
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
			    		document.detailForm.action = '<c:url value="/notice/noticeList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					    $("#detailForm").submit();
			    	} else {
			    		alert("삭제실패 하였습니다.");
			    		return false;
			    	}
			    	
			    }, 
			    error : function(arg){
				alert("공지사항정보 삭제 실패");
				
			    }
			});		
		}

	};
	
	// 공지사항정보 상세조회에서 수정 버튼 클릭시
	function fnShowModModal() {
		//$("#boardIdMod").val($("#boardIdDetail").text());
		
		document.detailForm.action = '<c:url value="/notice/noticeModDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
		
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
		
	// 수정 폼에서 수정버튼 클릭시  
	function fnMod(count) {

		var writerId = $("#writerIdDetail"+count).val();
		var content = $("#contentMod"+count).val();
		var locationDetail = $("#locationDetailRegist"+count).val();
		
		if(content == "") {
			alert("필수 입력사항 확인이 필요합니다.");
			return false;
		}
		
		
		$.ajax({
		    url: "/notice/noticeMod.do",
		    type: "POST",
		    async: false,
		    //dataType: "json",
		    data: {
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
	
	
	// 수정 취소 버튼 클릭시
	function fnModCancel(count) {
		$("#titleDetail"+count).attr("style", "display:block");	
		$("#divSelect"+count).attr("style", "display:display");
		$("#divMod"+count).attr("style", "display:none");
		$("#divTextCount"+count).attr("style", "display:none"); // 바이트수 안보이게
	};
	
	</script>
</head>
<body>	
	<!-- 공지사항 상세 조회 시작 -->
	<div class="sh-app">
		<%@ include file="/WEB-INF/views/menu.jsp" %>
		<div class="sh-main">
			<div class="sh-header">
				<div class="title">
					<p class="title-txt">상세조회
						<span class="title-menu"> < 공지사항 < 상세조회</span>
					</p>
				</div>
			</div>

			<div class="sh-content">
				<div class="main-content" headline="Stats">
					<form id="detailForm" name="detailForm" action="/notice/noticeList.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="sh-content-detail">
							<div class="reg-info-agency" >
								<div class="reg-title  require-pc-show"><p class="body-1-bold">상세조회</p>

								</div>
								<div class="wrap-table-detail-agency">
									<table class="detail-table1">
										<tbody>
										<tr>
											<th>제목 </th>
											<td class="res-title-td">제목</td>
											<td class="reg-input1">
												<div class="res-reg-td res-detail-agency">
													<p class="pc-title-td body-3-bold"><div class="div-require">제목</div></p>

													<div class="agency-dup-area-txt"><c:out value="${noticeDetail.title}" escapeXml="false" />
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>분류</th>
											<td class="reg-select-td">
												<div class="res-reg-td res-detail-agency">
													<p class="pc-title-td body-3-bold"><div class="div-require">분류</div></p>
													<div class="agency-dup-area-txt">
														<c:if test="${noticeDetail.noticeGubun eq '1'}">공지</c:if>
														<c:if test="${noticeDetail.noticeGubun eq '2'}">보도자료</c:if>
													</div>
												</div>
											</td>
										</tr>


										<tr>
											<th class="textarea-1q-area">내용 </th>
											<td class="res-title-td">내용</td>
											<td class="reg-input1 textarea-1q-detail">
												<div class="res-reg-td">
													<p class="pc-title-td body-3-bold"><div class="div-require">내용</div></p>
													<div class="agency-dup-area-txt">
														<c:out value="${noticeDetail.content}" escapeXml="false" />
<%--														<c:set var="contentWithBr" value="${fn:replace(noticeDetail.content, '\\n', '<br/>')}"/>--%>
<%--														<c:out value="contentWithBr"  escapeXml="false" ></c:out>--%>
													</div>
												</div>
											</td>
										</tr>


								
								<tr>
									<td colspan="4" align="center">
										<div class="btn-area-reg-detail" float="center">
											<button type="button" class="list-btn-agency-type2" id="user-reg-btn"><span  onclick="fnShowModModal()">수정</span></button>
											<button type="button" class="list-btn-agency-type2"><span onclick="fnCloseDetailModal()">목록</span></button>
											<button type="button" class="list-btn-agency-type2"><span onclick="fnDel()">삭제</span></button>
											<input type="hidden" id="boardIdParam" name="boardIdParam" value="${noticeDetail.boardId}"/>
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
						</div>
					</form>
				</div>
			</div><%@ include file="/WEB-INF/views/footer.jsp" %>
		</div>
	</div>


	<!-- 공지사항 상세 조회 끝 -->


</body>
</html>
