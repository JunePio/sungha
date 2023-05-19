<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
/**
 * @Class Name : sensorInfoData.jsp
 * @Description : 센서 항목별 계측정보 꺽은선 그래프 조회 화면
 * @Modification Information
 * @ 수정일                  수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2023.02.06  이창호      최초생성
 * @ 2023.05.10  이준영
 */
%>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>계측데이터 > 센서항목별 계측정보</title>
	
	<!-- <script src="/js/common/Chart.js"></script> -->
	<!-- <script src="/js/common/chartjs-plugin-annotation.js"></script> -->
	<script src="https://cdn2.hubspot.net/hubfs/476360/Chart.js"></script>
	<script src="https://cdn2.hubspot.net/hubfs/476360/utils.js"></script>
	
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    
    <script type="text/javascript">
    
    // 정보 검색
	function fnDetailSearch(){
		document.SearchForm.action = '<c:url value="/sensorInfo/sensorInfoSearchData.do"/>'; // 전송 url
		 $("#SearchForm").submit(); // 서버로 전송		
	}
    
    // 기관명 콤보박스 변경시
	function fnOrgNmChange(e){
		$.ajax({
		    url: "/sensorInfo/localNmList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	searchingOrgId : $("#orgNm").val(), // 콤보박스에서 선택된 항목의 기관ID
		    	searchingLocalId : $("#localNm").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
			//alert("통신성공시에만 실행");
			$("#localNm").empty(); // 기존에 있던 항목은 지우고
			//$("#localNm").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
			for(var i = 0; i < data.listSize ; i++) {
				$("#localNm").append("<option value=" + data.list[i].localId + ">" + data.list[i].local + "</option>"); // 각 항목 추가
			}

				$.ajax({
				    url: "/sensorInfo/sensorNmList.do",
				    type: "POST",
				    async: true,
				    //dataType: "json",
				    data: {
				    	searchingLocalId : $("#localNm").val() // 컴보박스에서 선택된 항목의 지역ID
				    },
				    //contentType: "application/json",
				    success : function(data) {
						//alert("통신성공시에만 실행");
						$("#sensorNm").empty(); // 기존에 있던 항목은 지우고
						//$("#sensorNm").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
						for(var i = 0; i < data.sensorNmListSize ; i++) {
							$("#sensorNm").append("<option value=" + data.sensorNmList[i].sensorId + ">" + data.sensorNmList[i].sensor + "</option>"); // 각 항목 추가
						}
				    }, 
					    error : function(arg){
						alert("통신실패시에만 실행");
				    }
				});
			
		    }, 
		    error : function(arg){
			alert("통신실패시에만 실행");
			
		    }
		});
	};
	
	function fnLocalNmChange(e) {
		$.ajax({
		    url: "/sensorInfo/sensorNmList.do",
		    type: "POST",
		    async: true,
		    //dataType: "json",
		    data: {
		    	searchingLocalId : $("#localNm").val() // 컴보박스에서 선택된 항목의 지역ID
		    },
		    //contentType: "application/json",
		    success : function(data) {
				//alert("통신성공시에만 실행");
				$("#sensorNm").empty(); // 기존에 있던 항목은 지우고
				//$("#sensorNm").append("<option value='total' selected>전체</option>"); // 전체 항목 추가
				for(var i = 0; i < data.sensorNmListSize ; i++) {
					$("#sensorNm").append("<option value=" + data.sensorNmList[i].sensorId + ">" + data.sensorNmList[i].sensor + "</option>"); // 각 항목 추가
				}
		    }, 
			    error : function(arg){
				alert("통신실패시에만 실행");
		    }
		});
	};

	// 엑셀 다운로드
	function fnExcelDown(){
	   	document.SearchForm.action = "<c:url value='/sensorInfo/point.do?excelDownload=true'/>";
       	document.SearchForm.submit();
	};
	
	// 항목별 계측데이터 가져오기
	window.onload = function() {
		//var now = "2023-02-06 11:07";		
		var now = " ";
		var ctx = document.getElementById("canvas").getContext("2d");
	    var chart = new Chart(ctx, {
	        type: "line",
	        data: chartData,	        
	        options: {
	          annotation: {
	            annotations: [
	              {
	                type: "line",
	                mode: "vertical",
	                scaleID: "x-axis-0",
	                value: now,
	                borderColor: "red",
	                label: {
	                  content: "TODAY",
	                  enabled: true,
	                  position: "top"
	                }
	              }
	            ]
	          }
	        }
	      });
		var count = $("#count").val();
		var id = $("#searchingSensorGubun").val();
		console.log(chartData);
		console.log(chartData.datasets[0]._meta[0].controller.chart.options.title);
		
		for(var i = 0; i < count; i++) {
			
			chartData.datasets[0].data[i] = $("#"+id+i).val();
			chartData.labels[i] = $("#regDate"+i).val();
		}
		// 선택한 계측항목 레이블 한글처리
		var label = "";
		if(id == "temp") {
			label = "온도";
		} else if(id == "humi") {
			label = "수분함량";
		} else if(id == "ph") {
			label = "산도";
		} else if(id == "conduc") {
			label = "전도도";
		} else if(id == "nitro") {
			label = "질소";
		} else if(id == "phos") {
			label = "인";
		} else if(id == "pota") {
			label = "칼륨";
		} else if(id == "batcaprema") {
			label = "배터리";
		}
			
		
		chartData.datasets[0].label = label;
		chart.update();

	}
	
	// 차트그리기	
	var chartData = {
	          //labels: ["일", "월", "화", "수", "목", "금", "토"],
	          labels: [""],
	          datasets: [
	            {
	              label : 'temp',
	              backgroundColor: '#16A571',
				  borderColor: '#16A571',
	          	  tension: 0,
	          	  fill: false,
	                //data: [0, 0, 0, 0, 0, 0, 0]
	          		data: [ ]
	            }
	          ]
	        };

	// 차트 화면출력	
	function fnPrint() {
		window.print();
	};
	
	</script>
    
</head>
<body>
<form id="SearchForm" name="SearchForm" action="/sensorInfo/sensorInfoData.do" method="post">
	<p>데이터 > 전체현장</p>
		기관명
		<select id="orgNm" name="orgNm" onchange="fnOrgNmChange(this)">
			<c:forEach var="item" items="${orgNmList}" varStatus="status">
				<option value="${item.organizationId}" <c:if test="${item.organizationId eq orgNm}">selected</c:if> >${item.organization}</option>
			</c:forEach>
		</select>
		지역명
		<select id="localNm" name="localNm"  onchange="fnLocalNmChange(this)">
			<c:forEach var="item" items="${localNmList}" varStatus="status">
				<option value="${item.localId}" <c:if test="${item.localId eq localNm}">selected</c:if> >${item.local}</option>
			</c:forEach>
		</select>
		센서명
		<select id="sensorNm" name="sensorNm">
			<c:forEach var="item" items="${sensorNmList}" varStatus="status">
				<option value="${item.sensorId}" <c:if test="${item.sensorId eq searchingSensorId}">selected</c:if> >${item.sensor}</option>
			</c:forEach>
		</select>
		계측항목		
		<select id="searchingSensorGubun" name="searchingSensorGubun">
            <option value="temp" <c:if test="${'temp' eq searchingSensorGubun}">selected</c:if> >온도</option>
            <option value="humi" <c:if test="${'humi' eq searchingSensorGubun}">selected</c:if> >수분함량</option>
            <option value="ph" <c:if test="${'ph' eq searchingSensorGubun}">selected</c:if> >산도</option>
            <option value="conduc" <c:if test="${'conduc' eq searchingSensorGubun}">selected</c:if> >전도도</option>
            <option value="nitro" <c:if test="${'nitro' eq searchingSensorGubun}">selected</c:if> >질소</option>
            <option value="phos" <c:if test="${'phos' eq searchingSensorGubun}">selected</c:if> >인</option>
            <option value="pota" <c:if test="${'pota' eq searchingSensorGubun}">selected</c:if> >칼륨</option>
            <option value="batcaprema" <c:if test="${'batcaprema' eq searchingSensorGubun}">selected</c:if> >배터리</option>
        </select>
	<input type="button" id="search" onclick="javascript:fnDetailSearch()" value="검색"/>
	<button type="button" class="btn-close" onclick="fnPrint();">화면출력</button>
	<br>* 검색조건(기관명,지역명,센서명,계측항목,계측주기)을 반드시 선택후 조회 가능<b>(현재일기준 일주일전 계측데이터 조회)</b>
</form>

<!-- 센서 항목별 계측데이터 꺽은선 그래프 -->
<div style="width: 75%"> 
	<canvas id="canvas"></canvas> 
</div>
	<c:forEach var="item" items="${list}" varStatus="status">
		<input type="hidden" id="temp${status.index}" name="temp${status.index}" value="${item.temp}"/>
		<input type="hidden" id="humi${status.index}" name="humi${status.index}" value="${item.humi}"/>
		<input type="hidden" id="ph${status.index}" name="ph${status.index}" value="${item.ph}"/>
		<input type="hidden" id="conduc${status.index}" name="conduc${status.index}" value="${item.conduc}"/>
		<input type="hidden" id="nitro${status.index}" name="nitro${status.index}" value="${item.nitro}"/>
		<input type="hidden" id="phos${status.index}" name="phos${status.index}" value="${item.phos}"/>
		<input type="hidden" id="pota${status.index}" name="pota${status.index}" value="${item.pota}"/>
		<input type="hidden" id="regDate${status.index}" name="pota${status.index}" value="${item.regDate}"/>
		<input type="hidden" id="batcaprema${status.index}" name="batcaprema${status.index}" value="${item.batcaprema}"/>
	</c:forEach>
		<input type="hidden" id="count" name="count" value="${listSize}"/>
</body>
</html>
