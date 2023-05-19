// round corners
	Chart.pluginService.register({
		afterUpdate: function (chart) {
			for	(let i = 1; i < chart.config.data.labels.length; i++){
				var arc = chart.getDatasetMeta(0).data[i];
				arc.round = {
					x: (chart.chartArea.left + chart.chartArea.right) / 2,
					y: (chart.chartArea.top + chart.chartArea.top) / 2,
					radius: (chart.outerRadius + chart.innerRadius) / 2,
					thickness: (chart.outerRadius - chart.innerRadius) / 2 - 1,
					backgroundColor: arc._model.backgroundColor
				}	
			}
			// Draw rounded corners for first item
			var arc = chart.getDatasetMeta(0).data[0];
			arc.round = {
				x: (chart.chartArea.left + chart.chartArea.right) / 2,
				y: (chart.chartArea.top + chart.chartArea.top) / 2,
				radius: (chart.outerRadius + chart.innerRadius) / 2,
				thickness: (chart.outerRadius - chart.innerRadius) / 2 - 1,
				backgroundColor: arc._model.backgroundColor
			}	
		},

		afterDraw: function (chart) {
			for	(let i = 1; i < chart.config.data.labels.length; i++){
				var ctx = chart.chart.ctx; arc = chart.getDatasetMeta(0).data[i];
				var startAngle = Math.PI / 2 - arc._view.startAngle;
				var endAngle = Math.PI / 2 - arc._view.endAngle;
				ctx.save();
				ctx.translate(arc.round.x, arc.round.y);
				ctx.fillStyle = arc.round.backgroundColor;
				ctx.beginPath();
				ctx.arc(arc.round.radius * Math.sin(endAngle), arc.round.radius * Math.cos(endAngle), arc.round.thickness, 0, 2 * Math.PI);
				ctx.closePath(); ctx.fill(); ctx.restore();
			}
			// Draw rounded corners for first item
			var ctx = chart.chart.ctx; arc = chart.getDatasetMeta(0).data[0];
			var startAngle = Math.PI / 2 - arc._view.startAngle;
			var endAngle = Math.PI / 2 - arc._view.endAngle;
			ctx.save();
			ctx.translate(arc.round.x, arc.round.y);
			ctx.fillStyle = arc.round.backgroundColor;
			ctx.beginPath();
			// ctx.arc(arc.round.radius * Math.sin(startAngle), arc.round.radius * Math.cos(startAngle), arc.round.thickness, 0, 2 * Math.PI);
			ctx.arc(arc.round.radius * Math.sin(endAngle), arc.round.radius * Math.cos(endAngle), arc.round.thickness, 0, 2 * Math.PI);
			ctx.closePath(); ctx.fill(); ctx.restore();
		},
	});
	
	
	var config = {
		type: 'doughnut',
		data: {
			labels: ['측정값', '잔여값'],
			datasets: [{
				data: [19.6, 80.4],
				backgroundColor: ["#62C1C1"],
				hoverBackgroundColor: ["#BFE5E5" ],
				borderWidth: 0,
				borderColor: ['#9DCEFF','#F2F3F6'],
				borderAlign: 'inner',
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ['#9DCEFF','#F2F3F6'],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [0.1660],
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ["#92C348"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [7.14],
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ["#92C348"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [14],
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ["#92C348"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [19],
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ["#92C348"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [47],
				backgroundColor: ["#62C1C1" ],
				hoverBackgroundColor: ["#BFE5E5"],
				borderWidth: 0,
				borderColor: ["#92C348"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
				data: [90],
				backgroundColor: ["#BFE5E5"],
				hoverBackgroundColor: [ "#62C1C1"],
				borderWidth: 0,
				borderColor: ["#EC6362"],
				hoverBorderWidth: 2,
			}]
		},
		options: {
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
				display: false,
				text: ''
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
	

window.onload = function() {
	var ctx = document.getElementById('myChart').getContext('2d');
	window.myDoughnut = new Chart(ctx, config);
	
	ctx = document.getElementById('myChart1').getContext('2d');
	window.myDoughnut = new Chart(ctx, config1);
	
	ctx = document.getElementById('myChart2').getContext('2d');
	window.myDoughnut = new Chart(ctx, config2);
	
	ctx = document.getElementById('myChart3').getContext('2d');
	window.myDoughnut = new Chart(ctx, config3);
	
	ctx = document.getElementById('myChart4').getContext('2d');
	window.myDoughnut = new Chart(ctx, config4);
	
	ctx = document.getElementById('myChart5').getContext('2d');
	window.myDoughnut = new Chart(ctx, config5);
	
	ctx = document.getElementById('myChart6').getContext('2d');
	window.myDoughnut = new Chart(ctx, config6);
	
	ctx = document.getElementById('myChart7').getContext('2d');
	window.myDoughnut = new Chart(ctx, config7);
	
};