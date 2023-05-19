<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
/**
 * @Class Name : boardRegist.jsp
 * @Description : Q&A 등록 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.10  이창호      최초생성
 * @ 2023.05.17  이준영     전반적인 수정 ,css 통합,기능 구현
 */
%>

<html>
<head>
	<meta charset="UTF-8">
	<title>Q&A 등록</title>
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

	// 저장버튼 클릭시
	function fnSave(callback){
		var writerId = $("#writerId").val();
		var title = $("#title").val();
		var content = $("#textArea_byteLimit").val();
		var qaGubun = $("#qaGubun").val();
				 
		if(writerId == "") {
			alert("작성자ID 입력사항 확인이 필요합니다.");
			return false;
		} else if(title == "") {
			alert("제목 입력사항 확인이 필요합니다.");
			return false;
		} else if(content == "") {
			alert("내용을 입력사항 확인이 필요합니다.");
			return false;
		} else if(qaGubun == " ") {  // 저장시 아이디 중복체크를 했는지 다시 체크
			alert("문의종류 확인 해주세요.");
			return false;
		}
		
		$.ajax({
		    url: "/board/boardSave.do",
		    type: "POST",
			async: false, // 동기 방식으로 처리
		    //dataType: "json",
		    data: {
		    	writerId : writerId,
		    	title : title,
		    	content : content,
		    	qaGubun : qaGubun,
		    },
		    success : function(data) {
				if(data.saveResult){
					alert("저장완료 하였습니다.");
					document.regForm.action = '<c:url value="/board/boardList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
					$("#regForm").submit();
				} else {
					alert("저장 실패 하였습니다.");
				}
		    }, 
		    error : function(error){
			alert("저장 실패");
		    }
		});

	};

	//등록시 textarea 바이트 수 체크하는 함수
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
	
	// 취소 버튼 클릭시
	function fnCloseRegModal() {
		document.regForm.action = '<c:url value="/board/boardList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#regForm").submit();
	};
	
	</script>

</head>
<body>

<!-- layer popup 1 -->
<div class="sh-app">
	<%@ include file="/WEB-INF/views/menu.jsp" %>
	<div class="sh-main">
		<div class="sh-header">
			<div class="title">
				<p class="title-txt">Q&A 등록
					<span class="title-menu"> < Q&A < 등록</span>
<%--				</p>--%>
			</div>
		</div>
		<div class="sh-content">
			<div class="main-content" headline="Stats">
					<form id="regForm" name="regForm" action="/board/boardSave.do" method="post">
						<input type="hidden" value="I" id="type" name="type">
						<div class="sh-content-detail">
							<div class="reg-info-agency" >
								<div class="wrap-table-detail-agency">
									<table class="detail-table1">
										<tbody>
										<tr>
											<th>제목 <span class="required">*</span></th>
											<td class="reg-input1">
												<div class="agency-dup-area">
													<input class="input-reg-irr" type="text" value="" id="title" name="title" maxlength="50" >
												</div>
											</td>
										</tr>
								<tr>
									<th>작성자</th>
										<td class="reg-input1">
											<div class="agency-dup-area">
												<input class="input-reg-irr" type="text" id="writerId" name="writerId" maxlength="50" readonly value="${writerId}">
											</div>
										</td>
								</tr>
								<tr>
									<th>문의종류</th>
									<td class="reg-select-td">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">문의종류</div></p>
											<select id="qaGubun" name="qaGubun" class="dropdown-sel reg-select res-sel">
												<option value="1">센서</option>
												<option value="2">관수</option>
											</select>
										</div>
									</td>
								</tr>
								<tr>
									<th>내용 <span class="required">*</span></th>
									<td class="res-title-td">내용<span class="required">*</span></td>
									<td class="reg-input1">
										<div class="res-reg-td">
											<p class="pc-title-td body-3-bold"><div class="div-require">내용</div></p>
											<div class="agency-loc-area">
												<textarea  class="textarea-reg-1q"  id="textArea_byteLimit" name="content" onkeydown="fnCheckByte(event, this)" onkeyup="fnCheckByte(event, this)"></textarea>
											</div>
											<span id="textareaByteCnt"></span> byte / 100 byte
										</div>
									</td>
								</tr>
							</tbody>
						</table>
									<div class="btn-area-reg-detail" float="center">
										<button type="submit" class="modify-btn" id="user-reg-btn"> <span onclick="fnSave()">저장</span></button>
										<button type="button" id="modal_close_btn" class="cancel-btn"><span onclick="fnCloseRegModal()">취소</span></button>

										<input type="hidden" id="searchingType" name="searchingType" value="${searchingType}"/>
										<input type="hidden" id="searchingContent" name="searchingContent" value="${searchingContent}"/>
										<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
										<input type="hidden" id="sortType" name="sortType" value="${sortType}">
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		 <div class="modal-layer"></div>
	</div>
	<!-- //layer popup 1 -->

</body>
</html>
