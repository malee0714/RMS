<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000985}</h2> <!-- 장비 일상 점검 --> 
		<div class="btnWrap">
			<button id="btnSearch" class="search btn3">${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>						
				</colgroup>
				<tr>
					<th>${msg.C100000736}</th> <!-- 장비 -->
					<td><select id="eqpmnSeqnoSch" name="eqpmnSeqnoSch"></select></td> 
			
					<th class="necessary">${msg.C100000785}</th> <!-- 점검 일자 -->
					<td style="text-align:left;">
						<input type="text" id="writngDeStart" name="writngDeStart" class="wd35p schClass" style="min-width: 7.5em;" value="${param.shrcheckBeginDte}" required> 
						~ 
						<input type="text" id="writngDeFinish" name="writngDeFinish" class="wd35p schClass" style="min-width: 7.5em;" value="${param.shrcheckEndDte}" required>
					</td>
						
					<th>${msg.C100000220}</th> <!-- 그래프 타입 -->
					<td style="text-align: left;">
						<label><input type="radio" name="type" id="line" value="line" checked/>&nbsp;${msg.C100000053}</label> <!-- LINE -->
						<label><input type="radio" name="type" id="bar" value="bar"/>&nbsp;${msg.C100000012}</label> <!-- BAR -->
					</td>	
				</tr>
			</table>

			<!-- 일상시험항목 그리드에서 선택한 항목의 seqno를 value에 set(url로 넘어옴) -->
			<input type="hidden" id="expriemSeqno" name="expriemSeqno" value="${param.expriemSeqno}">
		</form>
	</div>

	<div class="subCon2 mgT20">
		<h2><i class="fi-rr-apps"></i>${msg.C100000855}</h2> <!-- 차트 상세 정보 -->
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div class="fL wd26p mgT10" style="height:700px;">
			<div id="chValueList" class="fL wd100p" style="height:100%;"></div>
		</div>
		<!-- 차트가 이곳에 생성됩니다. -->
		<div class="fL wd73p" id="chValueChartDiv" style="margin-top: -8px;">
			<canvas id="chValueChart" class="fL"></canvas>
		</div>
	</div>
</div>
</tiles:putAttribute>

<tiles:putAttribute name="script">
<script>

var chValueChart = null;
var chValueList = 'chValueList';
var getEl = function(id){  
	return document.getElementById(id);
};

$(function() {

	// grid rendering
	setGrid();

	// button event
	setButtonEvent();
	
	// selectbox bind -> 조회 함수 동작
	setCombo().then(function() {
		getchkValueList();
	});
	
	// Calendar setting
	setDatePickerCalendar();
	
	// grid resize
	gridResize([chValueList]);
	
	// chart initialization
	setChartObject();
});

function setDatePickerCalendar() {
	datePickerCalendar(["writngDeStart","writngDeFinish"], false);
}

// 차트 재생성 (초기화)
function setChartObject(callback) {

	// 차트 재생성 (재생성하지 않으면 이전 차트 기록이 남게 됨)
	var chValueChartDoc = document.getElementById('chValueChartDiv');
	chValueChartDoc.innerHTML = '&nbsp;';
	$('#chValueChartDiv').append('<canvas id="chValueChart" class="fL" height="156px" style="margin-left:1%; border:1px solid; border-color:#dbdbdb;"></canvas>');
	var ctx = document.getElementById('chValueChart').getContext('2d');

	chValueChart = new Chart(ctx, {
	    type: "line",
	    data: {
	        datasets: []
	    },
	    options: {
	    	responsive: true,	    		
	    	title: {
				display: true,
				fontSize: 20
			},
	        zoom: {
		        enabled: true,
		        mode: 'y',
		    },
			/* 
			 * 차트 옵션 중 tooltip callbacks를 이용하여
			 * 툴팁의 개별 항목에 대해 렌더링할 텍스트를 지정하여 반환
			 * (불필요한 label은 렌더링x)
			 * */
	        tooltips: {
				mode: "point",
				intersect: true,
				backgroundColor: 'rgb(56, 56, 56)',
				bodyFontColor: '#fff',
				callbacks: {
					label: function(tooltipItem, data) {

						// 결과값이 없는 point는 label 출력X
						if(tooltipItem.value == null) {
							return false;
						}else {
							var label = data.datasets[tooltipItem.datasetIndex].label || '';

							if(label) {
								label += ': ';
							}
							label += Math.round(tooltipItem.yLabel * 100) / 100;
							return label;
						}
					}
				}
			},
	    }
	});
}

function setCombo() {
	return ajaxJsonComboBox('/rsc/getEdayChkEqpCombo.lims', 'eqpmnSeqnoSch', $("#searchFrm").serializeObject(), true, null, "${param.eqpmnSeqno}");
}

function setGrid() {
	
	// 그리드 레이아웃 정의
	var columnLayout = {
			chValueLayout : []
	};
	
	// 차트상세정보 그리드
	auigridCol(columnLayout.chValueLayout);
	columnLayout.chValueLayout.addColumnCustom("eqpmnNm","${msg.C100000742}",null,true)  /* 장비 명 */
	.addColumnCustom("chckDte","${msg.C100000785}",null,true)                            /* 점검 일자 */
	.addColumnCustom("resultValue","${msg.C100000150}",null,true)                        /* 결과 값 */

	chValueList = createAUIGrid(columnLayout.chValueLayout, chValueList);
}

function setButtonEvent() {
	// enter key event
	$(".schClass").keypress(function(e) {
		setTimeout(function() {
			if(e.which == 13) {
				if(typeof(getchkValueList) != "undefined") {
					getchkValueList();
				}
			}
		}, 100);
	});

	// 조회 click event
	getEl("btnSearch").addEventListener("click",function() {
		getchkValueList();
	});
	
	// 장비명 change event
	getEl("eqpmnSeqnoSch").addEventListener("change", function() {
		getchkValueList();
	});

	// 그래프 타입 change event
	$("input[type='radio']").change(function() {
		getchkValueList();
	});
}

// 조회 함수
function getchkValueList() {
	if(!saveValidation("searchFrm")) {
		return;
	}
	
   	getGridDataForm("<c:url value='/rsc/getEdayChkList.lims'/>", "searchFrm", chValueList, function(data) {
		if(!!data) {
        	var type = $("#searchFrm").serializeObject().type; // 그래프 타입
        	
			// 차트 렌더링
 			renderChart(data.list, type, data.listDate);
			
			// 일상점검 정보 그리드에 세팅
 			AUIGrid.setGridData(chValueList, data.list);
    	}
	}); 
}

/* @data : 일상 점검 결과 dataList
 * @chartType : 그래프 타입 (Line / Bar)
 * @dateArr : 점검일자 리스트 
 */

// Chart Rendering Function
function renderChart(data, chartType, dateArr) {

	// 차트 렌더링 전, 항상 차트 재생성 (이전의 차트 정보 삭제하기 위함)
	setChartObject(); 
	
	// {value : 결과값, date : 점검일자} 형태로 담을 배열
	var mesure1ValueList = new Array();

	// Chart data 담을 배열
	var valueList = [];

	var mesureDtList = [];  // 점검일자
	var mesureLclList = []; // LCL
	var mesureUclList = []; // UCL
	
	var eqpmnSeqno = ""; // 장비 일련번호

	// 조회할 데이터 길이만큼 for문 반복
	for(var i=0; i < data.length; i++) {
		/* for문의 직전 바퀴 수에 data push한 장비와 같은 장비 data인지 체크
		   => 장비별로 Chart data push하기 위함 */
	 	if(data[i].eqpmnSeqno == eqpmnSeqno) {
			mesure1ValueList.push({"value" : data[i].resultValue, "date" : data[i].chckDte});	
		
		// 다른 장비의 data가 들어온 시점. 이전에 쌓아놓은 장비data 한꺼번에 Chart data로 push
		}else {
			if(i != 0) {  // 첫 바퀴엔 push할 data가 없으므로 제외
				mesure1ValueList = chkNullDate(mesure1ValueList, dateArr);
				valueList.push({
					"list" : mesure1ValueList,	
					"label" : data[i-1].eqpmnNm,
					"fill" : false,
					"borderWidth" : 1
				});
			}

			// 이전에 쌓인 장비data 초기화 후, 새로운 장비data 쌓기 시작
			mesure1ValueList = [];
			mesure1ValueList.push({"value" : data[i].resultValue, "date" : data[i].chckDte});	
		}
	 	
	 	eqpmnSeqno = data[i].eqpmnSeqno;  // 다음 바퀴 수에 비교할 장비 seqNo 담아줌
	 	
	 	// 마지막 바퀴에 쌓아놓은 마지막 장비data Chart data로 push
	 	if(i == (data.length-1)) {
	 		mesure1ValueList = chkNullDate(mesure1ValueList, dateArr);
			valueList.push({
				"list" : mesure1ValueList,	
				"label" : data[i].eqpmnNm,
				"fill" : false,
				"borderWidth" : 1
			});
		}
	}

	// 점검일자가 1개인 경우
	if(dateArr.length == 1) {
		for(var i = 0; i < 2; i++) {
			mesureDtList.push(dateArr[0].chckDte);
			mesureLclList.push(data[0].mummValue == null || data[0].mummValue == '' ? data[0].minResultValue : data[0].mummValue);
			mesureUclList.push(data[0].mxmmValue == null || data[0].mxmmValue == '' ? data[0].maxResultValue : data[0].mxmmValue);
		}
	// 점검일자가 여러 개인 경우
	}else {
		for(var i = 0; i < dateArr.length; i++) {
			mesureDtList.push(dateArr[i].chckDte);
			mesureLclList.push(data[i].mummValue == null || data[i].mummValue == '' ? data[i].minResultValue : data[i].mummValue);
			mesureUclList.push(data[i].mxmmValue == null || data[i].mxmmValue == '' ? data[i].maxResultValue : data[i].mxmmValue);
		}
	}

	// config 접근
	var config = chValueChart.config;
	config.options.title.text = data[0].expriemNm;
	
	// line형 차트
	if(chartType == "line") {
		config.type = "line";

		// 날짜라벨
		chValueChart["data"]["labels"] = mesureDtList;

		// valueList 갯수만큼 라인마다 데이터,스타일 넣어줌
		for(var i=0; i < valueList.length; i++) {
			chValueChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list.concat(valueList[i].list), // 날짜가 1개인 경우, dataLine 일직선으로 그려주기 위함
				"fill" : valueList[i].fill,
				"borderColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
				"pointRadius": 6,
				lineTension: 0.2
			};
		}
		valueList.push({
			"list" : mesureLclList,	
			"label" : "LCL",
			"fill" : false,
			"borderWidth" : 1
		});
		chValueChart.data.datasets[valueList.length-1] = {
			"label" : valueList[valueList.length-1].label,
			"data" : valueList[valueList.length-1].list,
			"fill" : valueList[valueList.length-1].fill,
			"borderColor" : 'rgb(255,0,100)',
			"pointRadius": 0
		};
		valueList.push({
			"list" : mesureUclList,	
			"label" : "UCL",
			"fill" : false,
			"borderWidth" : 1
		});
		chValueChart.data.datasets[valueList.length-1] = {
			"label" : valueList[valueList.length-1].label,
			"data" : valueList[valueList.length-1].list,
			"fill" : valueList[valueList.length-1].fill,
			"borderColor" : 'rgb(117,117,253)',
			"pointRadius": 0
		};
	
	// bar형 차트
	}else if(chartType == "bar") {
 		config.type = "bar";
		
		// 차트의 스케일을 잡는다
 		var scales = config.options.scales;
		
 		// 스택형 bar 차트로 생성. 축이 3개면 너무많아서 못그림
 		scales.xAxes[0].stacked = true;
 		scales.yAxes[0].stacked = true;
		
		// 날짜라벨
		chValueChart["data"]["labels"] = mesureDtList;

		// valueList 갯수만큼 라인마다 데이터,스타일 넣어줌
		for(var i=0; i < valueList.length; i++) {
			chValueChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"backgroundColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
			};
		}
	}

	// 완성된 차트는 업데이트 시켜줌
	chValueChart.update();
}

// 데이터 추가 시, 해당 데이터 날짜 없을경우 해당 날짜 "0" 처리
function chkNullDate(list, dateArr) {
	var result = [];
	var cnt = 0;
	
	for(var i= 0; i<dateArr.length; i++) {
		if(cnt > (list.length-1)) {
			cnt -= 1;
		}

		if(list[cnt].date == dateArr[i].chckDte) {
			result.push(list[cnt].value);
			cnt++;
		}else {
			result.push(null);
		}
	}
	
	return result;
}

</script>
</tiles:putAttribute>    
</tiles:insertDefinition>