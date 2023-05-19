<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<script src="/static/js/filtering.js"></script>
	<script src="/static/js/common/utils.js"></script>
	<!-- <script src="http://code.jquery.com/jquery-latest.js"></script> -->
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/static/assets/css/reg_pc.css" />
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"> -->
	<script>
		$( document ).ready(function() {


		});
		
		// 기관명 콤보박스 변경시
		function fnOrgNmChange(e){
			$.ajax({
			    url: "/orgInfo/localNmList.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	searchingOrgId : $("#searchingOrgId").val() // 콤보박스에서 선택된 항목의 기관ID
			    },
			    //contentType: "application/json",
			    success : function(data) {
					//alert("통신성공시에만 실행");
					$("#searchingLocalId").empty(); // 기존에 있던 항목은 지우고
					//$("#searchingLocalId").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
					for(var i = 0; i < data.listSize ; i++) {
						$("#searchingLocalId").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
					}

			    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
				
			    }
			});
		};
		
		// 아이디 중복체크
		function fnIdDupCheck() {
			var signUpId = $('#signUpId').val().trim(); // 아이디 양쪽의 공백을 제거
			if(signUpId.indexOf(' ') > -1) { // 아이디 중간에 공백이 있는지 체크
				alert('아이디에 공백이 포함되어 있습니다.');
				return false;
			} else if(signUpId == '') { // 아이디 입력 안할 시
				alert('아이디를 입력해주세요.');
				return false;
			} else if(signUpId.length < 6 || signUpId.length > 10) { // 아이디는 4~10자리 까지 허용
				alert("아이디는 영문, 숫자 6~10자리까지 허용입니다.");
				return false;
			}
			
			$.ajax({
			    url: "/auth/idDupCheck.do",
			    type: "POST",
			    async: true,
			    //dataType: "json",
			    data: {
			    	signUpId : signUpId
			    },
			    //contentType: "application/json",
			    success : function(data) {
					//alert("통신성공시에만 실행");
					if(data.dupResult == true) { // 서버에서 확인한 결과가 중복된 아이디라면 경고창
						alert("중복된 아이디입니다.");					
					} else {
						alert("사용가능한 아이디 입니다.");
						$("#dupResult").val("dupCheckYes"); // 저장하기 전에 체크하기 위해서 미리 중복체크 정보를 저장해둔다.
					}

			    }, 
			    error : function(arg){
					alert("중복확인 실패 하였습니다.");
				
			    }
			});
		};
		
		// 회원가입 ID가 변경되었을 경우 중복확인 다시 체크
		function fnIdChange() {
			$("#dupResult").val("dupCheckNo");
		};
		
	</script>
</head>
<body>
<%--<div class="wrapper">
	<h1>회원가입</h1>
	<form action="/auth/signUp" method="post" id="userFormData">
		<div class="form-group">
			<label>소속 기관</label>
			<select name="organizationId" id="orgList" placeholder="소속기관" onchange="fnGetLocalInfo(this)">
				<option value="">전체</option>
			</select>
		</div>
		<div class="form-group">
			<label>지역</label>
			<select name="localId" id="localList" placeholder="지역">
				<option value="">전체</option>
			</select>
		</div>
		<div class="form-group">
			<label>아이디</label>
			<input type="text" name="username" class="form-control" placeholder="아이디 입력해주세요">
		</div>
		<div class="form-group">
			<label>비밀번호</label>
			<input type="password" class="form-control" name="password" placeholder="비밀번호 입력해주세요">
		</div>
		<div class="form-group">
			<label>비밀번호 확인</label>
			<input type="password" class="form-control" name="password_comf" placeholder="비밀번호 입력해주세요">
		</div>
		<div class="form-group">
			<label>사용자명</label>
			<input type="text" name="name" class="form-control" placeholder="사용자명을 입력해주세요">
		</div>
		<div class="form-group">
			<label>연락처</label>
			010-<input type="text" name="tel01" class="form-control" placeholder="앞자리">-<input type="text" name="tel02" class="form-control" placeholder="뒷자리">
		</div>
		<div class="form-group">
			<label>이메일</label>
			<input type="text" id="emailHeaderMod" onkeyup="fnPressHanSpecial(event, this)" >@
			<input type="text" id="emailBodyMod" onkeyup="fnPressEmail(event, this)" onchange="fnPressEmail(event, this)" style="ime-mode:disabled">
			<select id="emailNmMod" name="emailNmMod" onchange="fnEmailModChange()">
				<option value="selfInput">직접입력</option>
				<option value="naver">naver.com</option>
				<option value="daum">kakao.com</option>
				<option value="google">gmail.com</option>
			</select>
		</div>
		<button type="submit" class="btn">등록</button>
		<button type="type" class="btn">취소</button>
	</form>
</div>--%>
<header class="header-reg">
	<div class="head-reg"></div>
	<a class="logo-reg" id="logo_reg" href="/"></a>
</header>

<div class="main-reg">
	<div class="container-reg" id="wrap">
		<div class="input-form-reg col-md-12 mx-auto">
			<form id="signUpForm" action="/auth/signUpSave.do" method="post">
			<div style='width:600px;'>
				<p class="reg-title">회원가입<span class="require-star"></span><span class="require-txt">필수입력</span></p>
			</div>
			<div class="line-620"></div>
			<section class="">
				<div class="container-reg">
					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">소속 기관 <span class="asterisk_input">  </span> </label>
							<select id="searchingOrgId" name="searchingOrgId" onchange="fnOrgNmChange(this)">
								<!-- <option value="total">전체</option> -->
								<c:choose>
								<c:when test="${'total' eq orgNm}">
									<c:forEach var="item" items="${orgNmList}" varStatus="status">
										<option value="${item.organizationId}">${item.organization}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${orgNmList}" varStatus="status">
										<option value="${item.organizationId}" <c:if test="${item.organizationId eq searchingOrgId}">selected</c:if> >${item.organization}</option>
									</c:forEach>
								</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="space1"></div>
					<div class="row ">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">지역 <span class="asterisk_input">  </span> </label>
							<select id="searchingLocalId" name="searchingLocalId">
								<!-- <option value="total" selected>전체</option> -->
								<c:choose>
								<c:when test="${'total' eq localNm}">
									<c:forEach var="item" items="${localNmList}" varStatus="status">
										<option value="${item.localId}">${item.local}</option>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${localNmList}" varStatus="status">
										<option value="${item.localId}" <c:if test="${item.localId eq searchingLocalId}">selected</c:if> >${item.local}</option>
									</c:forEach>
								</c:otherwise>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="space1"></div>
					<div class="row space1">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">아이디 <span class="asterisk_input">  </span> </label>
							<input type="text"  id="signUpId" name="signUpId" placeholder="아이디를 입력해주세요." maxlength="10" onchange="fnIdChange()" onkeyup="fnPressHanSpecial(event, this)" style="ime-mode:disabled" />
							<button id="dup_chk_btn" onclick="fnIdDupCheck()">중복확인</button>
							<p class="reg-exp">아이디는 (6~10자리) 영문,숫자 입력만 가능합니다</p>
						</div>
					</div>
					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">비밀번호 <span class="asterisk_input">  </span> </label>
							<input type="text"  placeholder="비밀번호를 입력해 주세요." />
							<p class="reg-exp">10~20자 영문 대/소문자, 숫자, 특수문자 중 2가지 이상 조합</p>
						</div>
					</div>
					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">비밀번호 확인 <span class="asterisk_input">  </span> </label>
							<input type="text"  />
						</div>
					</div>
					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">사용자명 <span class="asterisk_input">  </span> </label>
							<input type="text"  placeholder="이름을 입력해 주세요."  />
						</div>
					</div>
					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">연락처 <span class="asterisk_input">  </span> </label>
							<span class="phone">010 <span id="phone-d">-</span>
                        <input type="text" id="phone1" class="phone1" /> <span id="phone-d2">-</span>
                        <input type="text" id="phone2" class="phone2" />
                      </span>
						</div>
					</div>

					<div class="space1"></div>
					<div class="row">
						<div class="col form-outline-reg">
							<label class="form-label" for="form3Example1m">이메일 <span class="asterisk_input">  </span> </label>
							<span class="email">
                        <input type="text" id="email1" class="email1" /><span id="email_">@</span>
                        <input type="text" id="email2" class="email2" />
                        <select id="email_sel">
                          <option>직접입력</option>
                          <option>naver.com</option>
                          <option>gmail.com</option>
                        </select>
                         <div><button id="num_cert" data-toggle="modal" data-target="#exampleModalCert">인증번호 요청</button></div>
                         <div id="email_num"><span id="email_num_txt">이메일 인증번호</span>
                            <input type="text" id="email_num_chk" class="email-num-chk" />
                            <button id="num_confirm">인증번호 확인</button>
                          </div>
                      </span>
						</div>
					</div>

					<div class="space1"></div>
					<div class="line-621"></div>
					<div class="row">
						<div id="agree_chk">
							<input class="form-check-input" type="checkbox" value="" id="agree_chk_input">
							<label class="form-check-label" for="flexCheckDefault">
								모든 약관에 동의합니다.
							</label>
						</div>
					</div>

					<div class="space1"></div>
					<div class="row" id="content_agree">

						<div id="agree_content1" >
							<input class="form-check-input agree-chk-input" type="checkbox" value="">
							<label class="form-label" for="form3Example1m">이용약관 동의 </label>
							<button class="show-agree" data-toggle="modal" data-target="#exampleModalAgree">보기</button>
						</div>

						<div id="agree_content2" >
							<input class="form-check-input agree-chk-input" type="checkbox" value="">
							<label class="form-label" for="form3Example1m">개인정보 수집 및 이용 동의</label>
							<button class="show-agree"  data-toggle="modal" data-target="#exampleModal">보기</button>
						</div>
					</div>

					<div class="line-620" style="margin-top: 20px;"></div>
					<div class="btn-last">
						<button type="button" class="btn-save">저장</button>
						<button type="button" class="btn-cancel" onclick="location.href='/';">취소</button>
					</div>
				</div>
			</section>
			</form>
		</div>
	</div>
</div>
<div class="space-reg">
	<footer class="footer-reg">
		<p class="mb-1">(주)성하  대표이사: 조정윤 | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
	</footer>
</div>
<script src="/static/assets/js/main.js"></script>
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script> -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

</body>
<script>
	// satrt
	$(function(e){
		// 기관정보를 가져온다
		fnGetOrgInfo();
	});
	// 기관정보를 가져온다
	function fnGetOrgInfo() {
		let url ="<c:url value='/auth/orgList.ajax'/>"
		let data = JSON.stringify({ organizationId : ""})
		$.ajax({
			url: url,
			data: data,
			dataType:'json',
			processData:false,
			contentType:'application/json; charset=UTF-8',
			type:'POST',
			traditional :true,
			success: function(data){
				$("#orgList option").remove();
				$("#orgList").append('<option value="">--선택--</option>');
				$.each(data, function(index, value){
					$("#orgList").append('<option value="'+value.organizationId+'">'+value.organization+'</option>');
				});
			}
		});
		return false;
	}
	// 지역정보를 가져온다
	function fnGetLocalInfo(o) {
		let orgId = "";
		$("#localList option").remove();
		$("#localList").append('<option value="">--선택--</option>');
		if(!isEmpty(o)&&!isEmpty(o.value)){
			orgId = o.value;

				let data = JSON.stringify({organizationId: orgId})
				let url = "<c:url value='/auth/localList.ajax'/>"
				$.ajax({
					url: url,
					data: data,
					dataType: 'json',
					processData: false,
					contentType: 'application/json; charset=UTF-8',
					type: 'POST',
					traditional: true,
					success: function (data) {

					}
				});
		}
		return false;
	}
	function fnSaveUser(){
		let form_data =	$('#userFormData').serializeArray();
		let data = JSON.stringify(objectifyForm(form_data));
		let url = "<c:url value='/auth/localList.ajax'/>"
		$.ajax({
			url: url,
			data: data,
			dataType: 'json',
			processData: false,
			contentType: 'application/json; charset=UTF-8',
			type: 'POST',
			traditional: true,
			success: function (data) {
				$.each(data, function (index, value) {
					$("#localList").append('<option value="' + value.localId + '">' + value.local + '</option>');
				});
			}
		});
	}
</script>
</html>

<!-- Modal -->
<div class="modal fade" id="exampleModalAgree" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-fix" role="document">
		<div class="modal-content modal-content-fix">
			<div class="modal-header" style="visibility: hidden;">
				<h5 class="modal-title" id="exampleModalLabel">Login</h5>
				<span aria-hidden="true" class="close-modal"  data-dismiss="modal" aria-label="Close">&times;</span>
			</div>
			<div class="msg"></div>
			<div class="modal-body modal-body-content">
				이용약관 동의
			</div>
			<div class="line-modal"></div>
			<div class=" modal-footer-fix">
				<button type="button" class="btn-confirm" data-dismiss="modal" style="display:block;">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-fix" role="document">
		<div class="modal-content modal-content-fix">
			<div class="modal-header" style="visibility: hidden;">
				<h5 class="modal-title" id="exampleModalLabel">Login</h5>
				<span aria-hidden="true" class="close-modal"  data-dismiss="modal" aria-label="Close">&times;</span>
			</div>
			<div class="msg"></div>
			<div class="modal-body modal-body-content">
				개인정보 수집 및 이용방침
			</div>
			<div class="line-modal"></div>
			<div class=" modal-footer-fix">
				<button type="button" class="btn-confirm" data-dismiss="modal" style="display:block;">확인</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCert" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-fix" role="document">
		<div class="modal-content modal-content-fix">
			<div class="modal-header" style="visibility: hidden;">
				<h5 class="modal-title" id="exampleModalLabel">이메일 인증코드</h5>
				<span aria-hidden="true" class="close-modal"  data-dismiss="modal" aria-label="Close">&times;</span>
			</div>
			<div class="line-modal" style="margin-top:-70px;"></div>
			<div class="modal-body modal-body-content">
				이메일 인증코드
			</div>
			<div class="modal-content-msg">회원가입하신 것을 환영합니다.</div>
			<div><p>인증코드
				<input type="text"  class="cert-num-input-modal" />
			</p></div>
			<div class=" modal-footer-fix">
				<button type="button" class="btn-confirm" data-dismiss="modal" style="display:block;">확인</button>
			</div>
		</div>
	</div>
</div>
