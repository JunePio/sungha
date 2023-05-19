<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>전체화면git</title>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/static/assets/css/common.css">
	<link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
		  integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

</head>
<body>
<div>
	<div class="table100 ver1" style="width: 100%">
		<div class="wrap-table100-nextcols js-pscroll">
			<div class="table100-nextcols">
				<table class="detail-table1" style="border:1px solid #A2CDC1;">
					<thead>
					<tr class="row100 head body-2-bold ">
						<th class="column2-user">목록</th>
						<th class="column1-user">기능</th>
						<th class="column1-user">퍼블</th>
						<th class="column1-user">test</th>
					</tr>
					</thead>
					<tbody class="body-2-regular tbody-table">
						<tr>
							<td><a href="/dashboard/main">대시보드</a></td>
							<td>○</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/board/boardList.do">Q&A</a></td>
							<td>○</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/notice/noticeList.do">공지사항</a></td>
							<td>○</td>
							<td>△</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/login">로그인</a></td>
							<td>○</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/findId">아이디찾기</a></td>
							<td>X</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/findPw">PW찾기</a></td>
							<td>X</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/signUp">회원가입</a></td>
							<td>X</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/orgInfo/orgInfoList.do">기관정보 리스트</a></td>
							<td>○</td>
							<td>○</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/local/localList.do">지역 리스트</a></td>
							<td>○</td>
							<td>○ </td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/userMng/userMngList.do">사용자관리 리스트</a></td>
							<td>○</td>
							<td>○ (수정필요)</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensor/sensorList.do">센서정보 리스트</a></td>
							<td>○</td>
							<td>△(수정,등록,댓글 퍼블적용필요)</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/irrigation/irrigationInfoList.do">관수제어 현장정보 리스트</a></td>
							<td>○</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorInfo/sensorInfoList.do">계측 데이터 리스트</a></td>
							<td>○</td>
							<td>△</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorInfo/sensorInfoSearchData.do">항목별 계측 데이터</a></td>
							<td>○</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorControl/mail">센서 설정 메일 발송</a></td>
							<td>○</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/logout">로그아웃</a></td>
							<td>○</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="#"> 권한</a></td>
							<td>X</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<%--
						<tr>
							<td><a href="/mqtt/pump">[펌프제어]</a> : <a href="/mqtt/senser/DI00000001/7.6/0.2">[센서정보전송]</a></td>
							<td></td>
						</tr>
						--%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

</body>
</html>
