<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : noticeMod.jsp
 * @Description : 공지사항정보 수정 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.10  이창호      최초생성
 * @ 2023.05.03  이준영      전반적인 css추가,수정 ,메뉴,푸터 추가
 * @ 2023.05.15  이준영      수정시 textarea 글자 수 바이트 세기 수정
 */
%>
<html>
<head>
	<title>공지사항 수정</title>
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

		// 공지사항정보 수정 모달에서 취소 버튼 클릭시
		function fnCloseModModal() {
			document.modForm.action = '<c:url value="/notice/noticeDetail.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
			$("#modForm").submit();
		};

		//수정시 textarea 바이트 수 체크하는 함수
		function fnCheckByte(event, obj){
			// alert("fnCheckByte실행");
			// fnTextAreaPressSpecial(event, obj); // 특수문자 제거

			const maxByte = 100; //최대 100바이트
			var text_val = obj.value; //입력한 문자
			var utf8Bytes = new TextEncoder().encode(text_val);
			var text_length = utf8Bytes.length;
			// var count = 0;
			// var totalByte=0;
			// for(let i=0; i<text_len; i++){
			// 	if(text_val.charAt(i)>127){
			// 		// 한글 : 2Byte
			// 		totalByte += 2;
			// 		count += 1;
			// 		alert("2Byte");
			// 	}else{
			// 		// 영문,숫자,특수문자 : 1Byte
			// 		totalByte += 1;
			// 		count += 1;
			// 		alert("1Byte");
			// 	}
			//
			// 	if(totalByte >= maxByte) {
			// 		break;
			// 		alert("if문break");
			// 	}
			// }
			//
			// obj.value = obj.value.substr(0, count);
			if(text_length > maxByte){
				// fnCheckByte(event, obj);
				document.getElementById("textareaByteCnt").innerText = text_length;
				document.getElementById("textareaByteCnt").style.color = "red";
				alert('최대 100Byte까지만 입력가능합니다.');
			}else{
				document.getElementById("textareaByteCnt").innerText = text_length;
				document.getElementById("textareaByteCnt").style.color = "green";
			}

		};


		// 공지사항정보 수정 모달에서 저장 버튼 클릭시
		function fnMod() {

			var writerId = $("#writerIdMod").text();
			var title = $("#titleMod").val();
			var content = $("#textArea_byteLimitMod").val();
			var noticeGubun = $("#noticeGubunMod").val();
			var boardId = $("#boardIdParam").val();

			if(title == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(content == "") {
				alert("필수 입력사항 확인이 필요합니다.");
				return false;
			} else if(noticeGubun == "") {
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
					title : title,
					content : content,
					noticeGubun : noticeGubun,
					boardId : boardId
				},
				//contentType: "application/json",
				success : function(data) {
					//alert("통신성공시에만 실행");
					if(data.modResult) { // 서버로부터 수정 성공 메시지가 도착하였다면
						alert("수정완료 하였습니다.");
						document.modForm.action = '<c:url value="/notice/noticeList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
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
			// alert("뿅뿅");
			<%--var sic1 = ${noticeDetail.noticeGubun};--%>
			// alert("noticegubun:"+sic1);
			$("#textArea_byteLimitMod").focus();

			var event = document.createEvent("Events");
			event.initEvent('keydown', true, true);
			event.keyCode = 13;
			document.getElementById('textArea_byteLimitMod').dispatchEvent(event);

		};

	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/menu.jsp" %>
	<!-- layer popup 3 -->
<div class="sh-main">
	<div class="sh-header">
		<div class="title">
			<p class="title-txt">수정 조회
				<span class="title-menu"> < 공지사항 < 수정 </span>
			</p>
		</div>
	</div>

	<div class="sh-content">
		<div class="main-content" headline="Stats">
			<form id="modForm" name="modForm" action="/notice/noticeMod.do" method="post">
				<input type="hidden" value="I" id="type" name="type">
				<div class="sh-content-detail">
					<div class="reg-info-agency" >
						<div class="reg-title  require-pc-show"><p class="body-1-bold">상세조회</p>

						</div>
						<div class="wrap-table-detail-agency">
							<table class="detail-table1">
								<tbody>
								<tr>
									<th>제목 <span class="required">*</span></th>
									<td class="res-title-td">제목</td>
									<td class="reg-input1">
										<div class="agency-dup-area"> <input  class="input-reg-irr"  type="text" id="titleMod" value="<c:out value="${noticeDetail.title}" escapeXml="false" />"/>
											<input type="hidden" id="boardIdParam" name="boardIdParam" value="${noticeDetail.boardId}"/>
										</div>
									</td>
								</tr>
								<tr>
									<th>작성자 <span class="required">*</span></th>
									<td class="res-title-td">작성자</td>
									<td class="reg-input1">
										<div class="agency-dup-area"> <input  class="input-reg-irr" readonly type="text" id="writerIdMod" maxlength="20" onkeyup="fnPressHanSpecial(event, this)" value="${noticeDetail.writerId}">
										</div>
									</td>
								</tr>
								<tr>
									<th>분류<span class="required">*</span></th>
									<td class="reg-select-td">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">분류</div></p>
											<div class="agency-dup-area">
											<select id="noticeGubunMod" name="noticeGubunMod"  class="dropdown-sel reg-select res-sel">
												<option value="1" <c:if test="${noticeDetail.noticeGubun eq '1'}">selected</c:if> >공지</option>
												<option value="2" <c:if test="${noticeDetail.noticeGubun eq '2'}">selected</c:if> >보도자료</option>
											</select>
											</div>
										</div>
									</td>
								</tr>


								<tr>
									<th class="textarea-1q-area">내용 <span class="required">*</span></th>
									<td class="res-title-td">내용<span class="required">*</span></td>
									<td class="reg-input1">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">내용</div></p>
											<div class="agency-loc-area">
												<textarea class="textarea-reg-1q" id="textArea_byteLimitMod" name="textArea_byteLimitMod" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"><c:out value="${noticeDetail.content}" escapeXml="false" /></textarea>
											</div>
											<span id="textareaByteCnt"></span> byte / 100 byte
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
										<div class="btn-area-reg-detail" float="center">
											<button type="submit"  class="list-btn-agency-type2"><span  id="user-reg-btn" onclick="fnMod()">저장</span></button>
											<button type="button" id="modal_close_btn"  class="list-btn-agency-type2"><span onclick="fnCloseModModal()">취소</span></button>
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
	</div>
			<%@ include file="/WEB-INF/views/footer.jsp" %>
		</div>
	</div>
	<!-- //layer popup 3 -->
	
</body>
</html>
