<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<title>데이터 > 전체현장</title>
<meta charset="UTF-8">
      <meta charset="UTF-8">
  	  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  	  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  	  <title>전체 데이터</title>
  	
   	  <link rel="stylesheet" 
	  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css">
<%--	  <link rel="stylesheet" href="/static/assets/css/data/list.css">--%>
	  <link rel="stylesheet" href="/static/assets/css/common.css">
	  <link rel="stylesheet" href="/static/assets/css/modal_pc.css" />
	  <link rel="stylesheet" href="/static/assets/css/data/chart_data.css" />


	
	<script src="/static/js/filtering.js"></script>
	<script src='https://www.chartjs.org/dist/2.7.3/Chart.bundle.js'></script>
	<!-- <script src="/js/chart.js"></script> -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<style>
		<%--.circle-foreground1 {--%>
		<%--	stroke-dasharray: ${batcaprema}px,100px;--%>
		<%--}--%>
		.sh-main {overflow-x: hidden!important;}
		.main-content {
			height:auto!important;
		}
	</style>
    <script type="text/javascript">
    
    $(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 	/*
	    if (e.ctrlKey==true && (e.which == '118' || e.which == '86')) {
            e.preventDefault();
         }
		*/
	    if (code == 27) { // 27은 ESC 키번호
	    	
	    	$("#modalDetail").attr("style", "display:none"); // 센서정보 상세조회 모달 닫기
	    	
	    }
	});    
	
	// 전헤현장 검색(목록 조회)
	function fnList(organizationId, localId){
		
		$("#orgNm").val(organizationId);
		$("#localNm").val(localId);
		
		document.detailForm.action = '<c:url value="/sensorInfo/sensorInfoSearchList.do"/>'; // 전송 url & 제이쿼리로 하면 action이 동작되지 않아서 DOM Script로 하였습니다.
	    $("#detailForm").submit();
	};
	
	// 상세정보 닫기
	function fnDetailClose() {
		$("#modalDetail").attr("style", "display:none"); // 계측데이터 상세조회 모달 닫기
	}
	
	// 화면인쇄
	function fnPrint(){
		//return $("#modalDetail").print();
		return window.print();
	};


	// 온도 
	var config = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [19.6, 80.4],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위-40~80 단위℃'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '100%',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		
		var config1 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~100 단위%'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '100%',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};

		var config2 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]	
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~14 단위pH'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '14',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		var config3 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~20 단위ds/m'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '2.0%',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		var config4 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~2000 단위mg/kg'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '2000',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		var config5 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~2000 단위mg/kg'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '2000',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		var config6 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [4.10, 95.9],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~10 단위cmol/kg'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '200',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
		
		
		var config7 = {
			type: 'doughnut',
			data: {
				labels: ['측정값', '잔여값'],
				datasets: [{
					data: [90, 10],
					position: 'top',
					backgroundColor: ["#49BA84"],
					hoverBackgroundColor: ["#A6E375" ],
					borderWidth: 0,
					borderColor: ['#49BA84','#A6E375'],
					borderAlign: 'inner',
					hoverBorderWidth: 2,
				}]
			},
			options: {
				maintainAspectRatio: true,
				responsive: false,
				legend: {
					position: 'top',
					reverse: true,
					labels: {
						padding: 25,
						fontSize: 0,
						fontColor: 'rgb(0, 0, 0)'
					}
				},
				tooltips: {
					enabled: true,
				},
				cutoutPercentage: 78,
				rotation: -0.5 * Math.PI,
				circumference: 2 * Math.PI,
				title: {
					display: true,
					position: 'bottom',
					text: '측정범위0~100 단위%'
				},
				animation: {
					animateScale: true,
					animateRotate: true
				},
				elements: {
					center: {
						// the longest text that could appear in the center  7,500,000 /10,000,000
						maxText: '100%',
						text: '',
						fontColor: '#000',
						fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
						fontStyle: 'bold',
						minFontSize: 1,
						maxFontSize: 256,
					}
				}
			}
		};
	
	
	var globalTemp; // 온도 범위초과
	var globalHumi; // 습도 범위초과
	var globalPh; // PH 범위초과
	var globalConduc; // EC 범위초과
	var globalNitro; // N 범위초과
	var globalPhos; // P 범위초과
	var globalPota; // K 범위초과
	var globalBatcaprema; // 배터리 범위초과
	
	
	window.onload = function() {

		var ctx = document.getElementById('myChart').getContext('2d');
		window.myDoughnut = new Chart(ctx, config);
		globalTemp = window.myDoughnut;
		
		ctx = document.getElementById('myChart1').getContext('2d');
		window.myDoughnut = new Chart(ctx, config1);
		globalHumi = window.myDoughnut;
		
		ctx = document.getElementById('myChart2').getContext('2d');
		window.myDoughnut = new Chart(ctx, config2);
		globalPh = window.myDoughnut;
		
		ctx = document.getElementById('myChart3').getContext('2d');
		window.myDoughnut = new Chart(ctx, config3);
		globalConduc = window.myDoughnut;
		
		ctx = document.getElementById('myChart4').getContext('2d');
		window.myDoughnut = new Chart(ctx, config4);
		globalNitro = window.myDoughnut;
		
		ctx = document.getElementById('myChart5').getContext('2d');
		window.myDoughnut = new Chart(ctx, config5);
		globalPhos = window.myDoughnut;
		
		ctx = document.getElementById('myChart6').getContext('2d');
		window.myDoughnut = new Chart(ctx, config6);
		globalPota = window.myDoughnut;
		
		ctx = document.getElementById('myChart7').getContext('2d');
		window.myDoughnut = new Chart(ctx, config7);
		globalBatcaprema = window.myDoughnut;
		
		
		// 도넛차트 - 온도(℃) : -40 ~ 80
		config.data.datasets[0].data[0] = Number($("#tempDetail").text());
		//config.data.datasets[0].data[1] = $("#tempDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.temp);
		config.data.datasets[0].data[1] = 80 - Number($("#tempDetail").text());
		
		if(config.data.datasets[0].data[0] >= $("tempMin").val() && config.data.datasets[0].data[0] <= $("#tempMax").val()) {
			config.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalTemp.update();
		}
		
		    	
		// 도넛차트 - 수분함량(%) : 0 ~ 100
		config1.data.datasets[0].data[0] = $("#humiDetail").text();
		//config1.data.datasets[0].data[1] = $("#humiDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.humi);
		config1.data.datasets[0].data[1] = 100 - $("#humiDetail").text();
		
		if(config1.data.datasets[0].data[0] >= $("#humiMin").text() && config1.data.datasets[0].data[0] <= $("#humiMax").text()) {
			config1.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config1.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalHumi.update();
		}
		

		// 도넛차트 - 산도(pH) : 0 ~ 14
		config2.data.datasets[0].data[0] = $("#phDetail").text();
		//config2.data.datasets[0].data[1] = $("#phDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.conduc);
		config2.data.datasets[0].data[1] = 14 - $("#phDetail").text();
		
		if(config2.data.datasets[0].data[0] >= $("#phMin").text() && config2.data.datasets[0].data[0] <= $("#phMax").text()) {
			config2.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config2.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalPh.update();
		}
		

		// 도넛차트 - 전도도(ds/m) : 0 ~ 20
		config3.data.datasets[0].data[0] = $("#conducDetail").text();
		//config3.data.datasets[0].data[1] = $("#conducDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.ph);
		config3.data.datasets[0].data[1] = 20 - $("#conducDetail").text();
		
		if(config3.data.datasets[0].data[0] >= $("#conducMin").text() && config3.data.datasets[0].data[0] <= $("#conducMax").text()) {
			config3.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config3.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalConduc.update();
		}
		
		// 도넛차트 - 질소(mg/kg) : 0 ~ 2000
		config4.data.datasets[0].data[0] = $("#nitroDetail").text();
		//config4.data.datasets[0].data[1] = $("#nitroDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.nitro);
		config4.data.datasets[0].data[1] = 2000 - $("#nitroDetail").text();
		
		if(config4.data.datasets[0].data[0] >= $("#nitroMin").text() && config4.data.datasets[0].data[0] <= $("#nitroMax").text()) {
			config4.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config4.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalNitro.update();
		}
		
		// 도넛차트 - 인(mg/kg) : 0 ~ 2000
		config5.data.datasets[0].data[0] = $("#phosDetail").text();
		//config5.data.datasets[0].data[1] = $("#phosDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.phos);
		config5.data.datasets[0].data[1] = 2000 - $("#phosDetail").text();
		
		if(config5.data.datasets[0].data[0] >= $("#phosMin").text() && config5.data.datasets[0].data[0] <= $("#phosMax").text()) {
			config5.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config5.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalPhos.update();
		}
		
		
		// 도넛차트 - 칼륨(cmol/kg) : 0 ~ 10
		config6.data.datasets[0].data[0] = $("#potaDetail").text();
		//config6.data.datasets[0].data[1] = $("#potaDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.pota);
		config6.data.datasets[0].data[1] = 10 - $("#potaDetail").text();
		
		if(config6.data.datasets[0].data[0] >= $("#potaMin").text() && config6.data.datasets[0].data[0] <= $("#potaMax").text()) {
			config6.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config6.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalPota.update();
		}
		
		// 도넛차트 - 배터리(%) : 0 ~ 100
		config7.data.datasets[0].data[0] = $("#batcapremaDetail").text();
		//config7.data.datasets[0].data[1] = $("#batcapremaDetailValueMax").text() - onGetUnescapeXSS(data.sensorInfoDetail.batcaprema);
		config7.data.datasets[0].data[1] = 100 - $("#batcapremaDetail").text();
		
		if(config7.data.datasets[0].data[0] >= $("#batcapremaMin").text() && config7.data.datasets[0].data[0] <= $("#batcapremaMax").text()) {
			config7.data.datasets[0].backgroundColor[0] = "#219C76";
		}else{
			config6.data.datasets[0].backgroundColor[0] = "#FF0000";
			globalBatcaprema.update();
		}


	};

	function fnPrint() {
		
		window.print();
	};
	
	</script>
    
</head>
<body>
<div class="sh-app">
    <%@ include file="/WEB-INF/views/menu.jsp" %>
    <div class="sh-main">
      <div id="backdrop_on" class="res-backdrop fade"></div>
      <div class="sh-header">
        <!-- reponsive header -->
        <div class="responsive-title">
          <h2 class="responsive-title-txt h4-bold">전체 데이터</h2>
        </div>

        <div class="title">
          <h2 class="title-txt h2-bold">전체 데이터</h2>
            <p class="title-menu">
              <span class="home"></span>
              <span class="depth-menu body-1-bold">데이터</span> 
              <span class="depth-menu body-1-bold">전체 데이터</span>
            </p>
        </div>
      </div> 
      
	  <div class="sh-content">
		  <div class="main-content" headline="Stats">
                <span class="title-reg-txt-detail body-2-regular mt-2">
                  <strong class="ml-2"><span id="sensor">${sensor}</span>[<span id="regDate">${regDate}</span>]
                  <!-- <span class="title-chart-small-txt chart-desc ml-2">개별 그래프를 클릭하시면 자세한 정보를 볼 수 있습니다.</span> -->
                  <button class="print-btn">인쇄</button>
					  </span>
			  <div class="wrap-table">
				  <div class="table100 ver1">

					  <div class="wrap-table100-nextcols js-pscroll">
						<table>
							<tbody>
								<tr>
									<td>
										<canvas id="myChart" width="250" height="250"></canvas>
										<div class="donut-inner">
											<p class="price">온도</p>
											<p class="percent"><span id="tempDetail">${temp}</span><small>℃</small></p>
										</div>
									</td>
									<td>
										<canvas id="myChart1" width="250" height="250"></canvas>
										<div class="donut-inner">
											<p class="price">수분함량</p>
											<p class="percent"><span id="humiDetail">${humi}</span><small>%</small></p>
										</div>
									</td>
									<td>
										<canvas id="myChart2" width="250" height="250"></canvas>
										<div class="donut-inner">
											<p class="price">산도</p>
											<p class="percent"><span id="phDetail">${ph}</span><small>ph</small></p>
										</div>
									</td>
									<td>
										<canvas id="myChart3" width="250" height="250">${conduc}</canvas>
										<div class="donut-inner">
										    <p class="price">전도도</p>
											<p class="percent"><span id="conducDetail">${conduc}</span><small>ds/m</small></p>
										</div>
									</td>
								</tr>
							    <tr>
							    	<td></td>
							    </tr>
								<tr>
									<td>
										<canvas id="myChart4" width="250" height="250"></canvas>
										<div class="donut-inner">
										    <p class="price">질소</p>
											<p class="percent"><span id="nitroDetail">${nitro}</span><small>mg/kg</small></p>
											
										</div>
									</td>
									<td>
										<canvas id="myChart5" width="250" height="250" style="display:auto!important;"></canvas>
										<div class="donut-inner">
										    <p class="price">인</p>
											<p class="percent"><span id="phosDetail">${phos}</span><small>mg/kg</small></p>
										</div>
									</td>
									<td>
										<canvas id="myChart6"  width="250" height="250"></canvas>
										<div class="donut-inner">
											<p class="price">칼륨</p>
											<p class="percent"><span id="potaDetail">${pota}</span><small>cmol/kg</small></p>
										</div>
									</td>
									<td>
										<canvas id="myChart7" width="250" height="250"></canvas>
										<div class="donut-inner">
											<p class="price">배터리</p>
											<p class="percent"><span id="batcapremaDetail">${batcaprema}</span><small>%</small></p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
						<input type="hidden" id="sensorRangeValue" value="${sensorRangeValue}"/>
						<input type="hidden" id="tempMin" value="${tempMin}"/>
						<input type="hidden" id="tempMax" value="${tempMax}"/>
						
						<input type="hidden" id="orgNm" name="orgNm" value="${searchingOrgId}"/>
						<input type="hidden" id="localNm" name="localNm" value="${searchingLocalId}"/>
						<input type="hidden" id="sensorId" name="sensorId" value="${sensorId}"/>
						<input type="hidden" id="sensor" name="sensor" value="${sensor}"/>
						<input type="hidden" id="regDate" name="regDate" value="${regDate}"/>
						<input type="hidden" id="temp" name="temp" value="${temp}"/>
						<input type="hidden" id="humi" name="humi" value="${humi}"/>
						<input type="hidden" id="ph" name="ph" value="${ph}"/>
						<input type="hidden" id="conduc" name="conduc" value="${conduc}"/>
						<input type="hidden" id="nitro" name="nitro" value="${nitro}"/>
						<input type="hidden" id="phos" name="phos" value="${phos}"/>
						<input type="hidden" id="pota" name="pota" value="${pota}"/>
						<input type="hidden" id="batcaprema" name="batcaprema" value="${batcaprema}"/>
						<input type="hidden" id="sortColumn" name="sortColumn" value="${sortColumn}">
						<input type="hidden" id="sortType" name="sortType" value="${sortType}">
						<input type="hidden" id="page" name="page" value="${page}">
						<input type="hidden" id="range" name="range" value="${range}">
						<input type="hidden" id="rangeSize" name="rangeSize" value="${rangeSize}">
					</form>
				</div>
				  <div class="modal-button">
					  <button type="button" class="modify-btn" onclick="fnPrint();">화면출력</button>
					  <button type="button" class="modify-btn" onclick="fnList('${organizationId}','${localId}');">목록</button>
				  </div>
				  </div>


	  </div>

	</div>
		  <%@ include file="/WEB-INF/views/footer.jsp" %>
	</div>
	</div>
</body>
</html>

