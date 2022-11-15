<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000988}</h2> <!-- 부서별 의뢰 건수 조회 -->
				<div class="btnWrap">
					<button id="btnSearch" type="button" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:9%"></col>
							<col style="width:15%"></col>
							<col style="width:9%"></col>
							<col style="width:15%"></col>
							<col style="width:9%"></col>
							<col style="width:15%"></col>
							<col style="width:9%"></col>
							<col style="width:19%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000986}</th> <!-- 의뢰 부서 -->
							<td><select id="shrDeptCode" name="shrDeptCode"></select></td>

							<th>${msg.C100000139}</th> <!-- 검사 유형 -->
							<td><select id="shrInspctTyCode" name="shrInspctTyCode"></select></td>

							<th>제품 구분</th> <!-- 제품 구분 -->
							<td><input type="text" id="shrMtrilNm" name="shrMtrilNm" class="schClass"></td>

							<th class="necessary">${msg.C100000659}</th> <!-- 의뢰 일자 -->
							<td>
								<input type="text" class="wd6p dateChk schClass" id="shrReqestBeginDte" name="shrReqestBeginDte" style="min-width:6em;" required>
								~
								<input type="text" class="wd6p dateChk schClass" id="shrReqestEndDte" name="shrReqestEndDte" style="min-width:6em;" required>
							</td>
						</tr>
					</table>
				</form>
			</div>

			<div class="subCon2 mgT20"s>
				<h2><i class="fi-rr-apps"></i>${msg.C100000989}</h2> <!-- 부서별 의뢰 건수 정보 -->
				<div style="display:flex;">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div class="wd25p mgT10" style="display:inline-block; order:1;">
						<div id="requestCntList" class="wd100p" style="height:505px;"></div>
					</div>
					<div class="wd73p" style="display:inline-block; order:2;" >
						<div style="text-align: right; margin-top: -1px;">
							<label><input class="chartType" type="radio" name="chartType" id="line" value="line" checked/>${msg.C100000053}</label> <!-- LINE -->
							<label><input class="chartType" type="radio" name="chartType" id="bar" value="bar"/>${msg.C100000012}</label> <!-- BAR -->
						</div>
						<!-- 차트가 이곳에 생성됩니다. -->
						<div id="chValueChartDiv">
							<canvas id="requestCntChart" class="wd100p" style="margin-left:30px; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>
						</div>
					</div>
				</div>
			</div>
			<div class="btnWrap mgT15">
				<div style="text-align:center;" class="mgT20">
					<button type="button" id="btnChartExcelDown" class="inTableBtn inputBtn save mgL330" style="display:none">${msg.C100000990}</button> <!-- 차트 출력 -->
				</div>
			</div>

			<form id="frmChartData" method="post" action="/com/chartImgDown.lims">
				<input type="text" name="chartImg" id="chartImg" style="display:none;"/>
			</form>
		</div>
		
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
	
		<script>

			var requestCntList = "requestCntList";
			var requestCntChart;

			$(document).ready(function() {

				init();

				createChart();

				buildGrid();

				buttonEvent();

			});


			function init() {
				datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["DD",-7], ["DD",0]);
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'shrDeptCode', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'shrInspctTyCode', {'upperCmmnCode' : 'SY07'}, true);
			}


			function buildGrid() {

				var col = [];
				auigridCol(col);
				col.addColumnCustom("reqestDeptCode", "${msg.C000000997}", "*" ,false)  // 의뢰부서코드
				col.addColumnCustom("reqestDeptNm", "${msg.C100000986}", "*" ,true)     // 의뢰 부서
				col.addColumnCustom("reqestDte", "${msg.C100000006}", "*" ,true)        // 의뢰 월
				col.addColumnCustom("reqestCnt", "${msg.C100000121}", "*", true);       // 건수

				var cusProp = {
					editable : false,
					selectionMode : "multipleCells",
					enableCellMerge : true
				};

				requestCntList = createAUIGrid(col, 'requestCntList', cusProp);
				gridResize([requestCntList]);

				AUIGrid.bind(requestCntList, "ready", function(event) {
					gridColResize([requestCntList],"2");
				});
			}


			function buttonEvent() {

				$(".schClass").keypress(function(e) {
					setTimeout(function() {
						if(e.which == 13) {
							if(typeof(searchReceipt) != "undefined") {
								searchReceipt();
							}
						}
					}, 100);
				});

				document.getElementById("btnSearch").addEventListener('click', function() {
					searchReceipt();
				});

				// 차트 저장btn click event
				// document.getElementById("btnChartExcelDown").addEventListener('click', function() {
				// 	$("#chartImg").val($("#requestCntChart")[0].toDataURL("image/png"));
				// 	$("#frmChartData").submit();
				// });

				$("input[name='chartType']").change(function() {
					searchReceipt();
				});
			}


			function searchReceipt() {

				if (!saveValidation("searchFrm"))
					return;

				var formData = $("#searchFrm").serializeObject();
				customAjax({
					"url" : "/src/getRequestCntList.lims",
					"data" : formData,
					"successFunc" : function(data) {
						var chartType = $("[name=chartType]:checked").val();
						renderChart(data.list, chartType, data.listDate);

						AUIGrid.setGridData(requestCntList, data.list);
					}
				});
			}


			function createChart() {

				// 차트 div박스 내부 canvas를 지우고 재생성
				var chValueChartDoc = document.getElementById('chValueChartDiv');
				chValueChartDoc.innerHTML = '&nbsp;';
				$('#chValueChartDiv').append('<canvas id="requestCntChart" class="fL wd100p" style="margin-left:30px; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>');

				// canvas 드로잉 컨텍스트에 접근
				var ctx = document.getElementById("requestCntChart").getContext("2d");
				requestCntChart = new Chart(ctx, {
					type: 'line',
					data: {
						labels: [],
						datasets: [{}]
					},
					options: {
						legend: {
							display: true,
							position: 'top',
							labels: {
								boxWidth: 80,
								fontColor: 'black'
							}
						},
						zoom : {
							enabled : true,
							mode : 'y'
						},
						scales: {
							yAxes: [{
								gridLines: {
									color: "#1f296f",
									borderDash: [2, 5]
								},
								scaleLabel: {
									display: true,
									labelString: "${msg.C100000121}", /* 건수 */
									fontColor: "black",
									fontSize: 17
								},
								ticks: {
									fontColor : 'rgba(0, 0, 0, 1)',
									fontSize : 14
								}
							}],
							xAxes: [{
								gridLines: {
									color: "#1f296f"
								},
								ticks: {
									fontColor : 'rgba(0, 0, 0, 1)',
									fontSize : 14
								}
							}]
						},
					}
				});
			}


			// 불러온 데이터로 본격적인 차트 드로잉
			function renderChart(data, chartType, listDate) {

				createChart();

				var analsArr = [];
				var requestDteArr = [];
				var depts = [];

				// 의뢰부서
				for (var i = 0; i < data.length; i++) {
					analsArr[i] = data[i].reqestDeptCode;
				}

				// 의뢰일자
				for (var i = 0; i < listDate.length; i++) {
					requestDteArr[i] = listDate[i].reqestDte;
				}

				$.each(analsArr, function(i, el) {
					if($.inArray(el, depts) === -1) {
						depts.push(el); // 의뢰 부서코드 push
					}
				});

				var config = requestCntChart.config;
				var color = [
					 "rgba(0,0,255,1)"   // blue
					,"rgba(128,0,0,1)"   // maroon
					,"rgba(255,0,0,1)"   // red
					,"rgba(128,0,128,1)" // purple
					,"rgba(255,0,255,1)" // fuchsia
					,"rgba(0,128,0,1)"   // green
					,"rgba(0,255,0,1)"   // lime
					,"rgba(128,128,0,1)" // olive
					,"rgba(255,255,0,1)" // yellow
					,"rgba(0,0,128,1)"   // navy
					,"rgba(0,0,0,1)"     // black
					,"rgba(0,128,128,1)" // teal
					,"rgba(0,255,255,1)" // aqua
				];

				// 부서 수보다 color 수가 적으면 랜덤색상 추가
				if (depts.length > color.length) {
					var num = depts.length - color.length;
					var colorIndex = color.length;

					for (var i = 0; i < num; i++) {
						var str = "rgba(";

						for (var s = 0; s < 3; s++) {
							str += Math.floor(Math.random() * 255) + 1 + ",";
						}

						str += "1)";
						color[colorIndex + i] = str;
					}
				}

				requestCntChart.data.labels = requestDteArr; // xAxes label : 의뢰일자

				if (chartType == "line") {
					config.type = "line";  // 차트타입 변경

					var cnt = 0;
					for (var i = 0; i < depts.length; i++) {
						if (depts[i]) {
							var receptCnt = new Array();
							var deptNm = "";

							for (var j = 0; j < data.length; j++) {
								if (depts[i] == data[j].reqestDeptCode) {
									receptCnt.push({
										value: data[j].reqestCnt,
										date: data[j].reqestDte
									});
									deptNm = data[j].reqestDeptNm;
								}
							}
							receptCnt = chkNullDate(receptCnt, requestDteArr);

							// 차트옵션
							requestCntChart.data.datasets[cnt] = {
								data: receptCnt,
								label: deptNm,
								fill: false,
								borderColor: color[i],
								backgroundColor: color[i],
								pointBorderColor: color[i],
								pointBackgroundColor: color[i],
								pointRadius: 5,
								pointHoverRadius: 10,
								pointHitRadius: 30,
								pointStyle: 'rectRounded',
								lineTension: 0
							};

							cnt++;
						}
					}

				} else if (chartType == "bar") {
					config.type = "bar"; // 차트타입 변경

					// 스택형 Bar 차트로 설정
					var scales = config.options.scales;
					scales.xAxes[0].stacked = true;
					scales.yAxes[0].stacked = true;
					scales.yAxes[0].ticks.beginAtZero = true;

					var cnt = 0;
					for (var i = 0; i < depts.length; i++) {
						if (depts[i]) {
							var receptCnt = new Array();
							var deptNm = "";

							// 의뢰건수, 부서 dataSet에 넣어줌
							for (var j = 0; j < data.length; j++) {
								if (depts[i] == data[j].reqestDeptCode) {
									receptCnt.push(data[j].reqestCnt);
									deptNm = data[j].reqestDeptNm;
								}
							}

							// 차트옵션
							requestCntChart.data.datasets[cnt] = {
								data: receptCnt,
								label: deptNm,
								backgroundColor: color[i],
								strokeColor: color[i],
								borderColor: color[i],
								fillColor: color[i],
								highlightFill: color[i],
								highlightStroke: color[i]
							};

							cnt++;
						}
					}
				}

				requestCntChart.update(); // 완성된 차트로 업데이트
			}

			/**
			 * 차트 Array에 null공간 만들어 주기 위한 함수
			 * ex) [null, 12, null, null, 13]
			 * 차트에 배열 형식을 맞춰줘야 제대로 된 그래프 그리기 가능
			 */
			function chkNullDate(list, dateArr) {
				var result = [];
				var cnt = 0;

				for (var i = 0; i < dateArr.length; i++) {
					if (cnt > (list.length - 1))
						cnt -= 1;

					if (list[cnt].date == dateArr[i]) {
						result.push(list[cnt].value);
						cnt++;
					} else {
						result.push(null);
					}
				}

				return result;
			}

		</script>
	
	</tiles:putAttribute>
</tiles:insertDefinition>
