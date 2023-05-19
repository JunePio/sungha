<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/static/assets/css/reg_pc.css" />
    <link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
<header class="header-reg">
    <div class="head-reg"></div>
    <a class="logo-reg" id="logo_reg" href="/"></a>
</header>

<div class="main-reg">
    <div class="container-reg" id="wrap">
        <div class="input-form-reg col-md-12 mx-auto">
            <div style='width:600px;'>
                <p class="reg-title-findid">비밀번호 찾기</p>
            </div>
            <div class="line-620"></div>
            <section class="">
                <div class="space1"></div>
                <div class="container-reg">
                    <div class="row space1">
                        <div class="col form-outline-reg">
                            <label class="form-label" for="form3Example1m">아이디 </label>
                            <input type="text" class="findpw-id" placeholder="아이디를 입력해주세요." />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col form-outline-reg">
                            <label class="form-label" for="form3Example1m">사용자명</label>
                            <input type="text" class="findpw-id" placeholder="이름을 입력해 주세요."  />
                        </div>
                    </div>
                    <div class="space1"></div>
                    <div class="row">
                        <div class="col form-outline-reg">
                            <label class="form-label" for="form3Example1m">이메일</label>
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
                    <div class="" style="margin-top: 20px;"></div>
                    <div class="btn-last">
                        <button type="button" class="btn-confirm">확인</button>
                        <button type="button" class="btn-cancel" onclick="location.href='/';">취소</button>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
<div class="space-reg">
    <footer class="footer-reg">
        <p class="mb-1">(주)성하  대표이사: 조정윤 | 사업자등록번호: 705-86-01108 | 대표번호: 02-596-2200 | 팩스번호: 02-512-5161 | 이메일: sungha0405@hanmail.net</p>
    </footer>
</div>
<script src="/static/assets/js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>



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
