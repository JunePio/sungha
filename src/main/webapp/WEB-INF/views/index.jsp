<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<html>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>��üȭ��git</title>

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
						<th class="column2-user">���</th>
						<th class="column1-user">���</th>
						<th class="column1-user">�ۺ�</th>
						<th class="column1-user">test</th>
					</tr>
					</thead>
					<tbody class="body-2-regular tbody-table">
						<tr>
							<td><a href="/dashboard/main">��ú���</a></td>
							<td>��</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/board/boardList.do">Q&A</a></td>
							<td>��</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/notice/noticeList.do">��������</a></td>
							<td>��</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/login">�α���</a></td>
							<td>��</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/findId">���̵�ã��</a></td>
							<td>X</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/findPw">PWã��</a></td>
							<td>X</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/auth/signUp">ȸ������</a></td>
							<td>X</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/orgInfo/orgInfoList.do">������� ����Ʈ</a></td>
							<td>��</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/local/localList.do">���� ����Ʈ</a></td>
							<td>��</td>
							<td>�� </td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/userMng/userMngList.do">����ڰ��� ����Ʈ</a></td>
							<td>��</td>
							<td>�� (�����ʿ�)</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensor/sensorList.do">�������� ����Ʈ</a></td>
							<td>��</td>
							<td>��(����,���,��� �ۺ������ʿ�)</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/irrigation/irrigationInfoList.do">�������� �������� ����Ʈ</a></td>
							<td>��</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorInfo/sensorInfoList.do">���� ������ ����Ʈ</a></td>
							<td>��</td>
							<td>��</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorInfo/sensorInfoSearchData.do">�׸� ���� ������</a></td>
							<td>��</td>
							<td>X</td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/sensorControl/mail">���� ���� ���� �߼�</a></td>
							<td>��</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="/logout">�α׾ƿ�</a></td>
							<td>��</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<tr>
							<td><a href="#"> ����</a></td>
							<td>X</td>
							<td style="background-color: #e6e6e6"></td>
							<td>X</td>
						</tr>
						<%--
						<tr>
							<td><a href="/mqtt/pump">[��������]</a> : <a href="/mqtt/senser/DI00000001/7.6/0.2">[������������]</a></td>
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
