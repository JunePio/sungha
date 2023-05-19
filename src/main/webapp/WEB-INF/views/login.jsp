<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
	<title>관수시스템 시그널트리</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/static/assets/css/main.css" />
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
</head>
<%--<body>
<div class="wrapper">
	<form class="form-signin"  action="/login_proc" method="post">
		<h2 class="form-signin-heading">로그인</h2>
		<input type="text" class="form-control" name="userId" placeholder="ID" required="" autofocus="" value="gn" />
		<input type="password" class="form-control" name="userPw" placeholder="PW" required="" value="1234"/>
		<label class="checkbox">
			<input type="checkbox" value="remember-me" id="rememberMe" name="rememberMe"> 로그인 저장
		</label>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
		<button class="btn btn-lg btn-primary btn-block" type="button" onclick="location.href='/auth/signUp';">회원가입</button>
	</form>
	<span>
		<c:if test="${error}">
			<p id="valid" class="alert alert-danger">${exception}</p>
		</c:if>
	</span>
</div>
</body>--%>
<body class="is-preload">
<div class="header-line">
	<div class="Group"></div>
	<div class="Line-220"></div>
</div>

<!-- Header -->
<header id="header">
</header>
<div class="main">
	<section class="layout-main">
		<div class="main-left">
			<!-- slide -->
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				</ol>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img src="/static/assets/css/img_common/slide_img/tree.png" class="d-block w-100" alt="">
					</div>
					<div class="carousel-item">
						<img src="/static/assets/css/img_common/slide_img/tree.png" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img src="/static/assets/css/img_common/slide_img/tree.png" class="d-block w-100" alt="...">
					</div>
				</div>
				<button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</button>
			</div>
			<!-- end slide -->
		</div>
		<div class="main-right">
			<div class="txt1-div">
				<span class="txt1">
					수목은 필요 시 물을 줘야하는데 물을 편하게 공급할 수 있는 방법
				</span>
			</div>
			<div class="Line-218"></div>
			<div style="padding-left: 30px;"><h1 class="h1_pc">관수시스템 <span class="text-style-1">시그널트리</span></h1></div>
			<div class="Line-218" style="margin-bottom:10px;"></div>
			<!-- Signup Form -->
			<form id="signup-form" class="form-signin w-100 m-auto" action="/login_proc" method="post">
				<div><input type="text"   name="userId" id="email"  placeholder="&#xf007; ID(E-mil)" value="gn"/></div>
				<div><input type="password" name="userPw"  id="password" placeholder="&#xf023; PASSWORD" value="1234"/></div>
				<div><input type="submit" name="login" id="login" value="LOGIN" <%--data-toggle="modal" data-target="#exampleModal"--%>/></div>
				<div class="form-check">
					<input class="form-check-input form-control" type="checkbox" value="" id="flexCheckDefault">
					<label class="form-check-label" for="flexCheckDefault">
						아이디 저장
					</label>
				</div>
			</form>

			<div class="Line-234"></div>
			<ul class="ul-menu">
				<li class="li-menu dot"><a href="/auth/findId" class="lia"><span class="label txt-menu2 s30">아이디 찾기</span></a></li>
				<li class="li-menu dot"><a href="/auth/findPw" class="lia"><span class="label txt-menu2 s30">비밀번호 찾기</span></a></li>
				<li class="li-menu reg dot"><a href="#" onclick="location.href='/auth/signUp';" class="lia" style="padding-left: 10px"><span class="label txt-menu2"  >회원가입</span></a></li>
			</ul>
		</div>
	</section>
</div>

<!-- Footer -->
<footer id="footer">
</footer>

<!-- Scripts -->
<script src="/static/assets/js/main.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>

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
				아이디 또는 비밀번호를<br/>잘못 입력했습니다.
			</div>

			<div class="line-modal"></div>
			<div class=" modal-footer-fix">
				<button type="button" class="btn-confirm" data-dismiss="modal" style="display:block;">확인</button>
			</div>
		</div>
	</div>
</div>

</html>
