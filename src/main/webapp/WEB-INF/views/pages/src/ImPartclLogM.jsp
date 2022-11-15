<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001084}</h2> <!-- Air Online Particle 조회 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
		</div>
	
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col> 
					<col style="width:15%"></col>
					<col style="width:10%"></col> 
					<col style="width:65%"></col>
				</colgroup>
				<tr>
					<!-- <th>기기</th>
					<td><select id="mhrlsSeqno" name="mhrlsSeqno" class="wd100p">
							<option value="">선택</option>
						</select>
					</td> -->
					<th>${msg.C000001085}</th> <!-- 모니터링 장소 -->
					<td style="text-align: left;">
						<select type="text" id="stMesureP" name="stMesureP" class="schClass"></select> 
					</td>
					<th>${msg.C000001086}</th> <!-- 측정일자 -->
					<td style="text-align: left;">
						<input type="text" id="stMesureDt" name="stMesureDt" class="wd6p schClass" style="min-width: 6em;">~ 
						<input type="text" id="endMesureDt" name="endMesureDt" class="wd6p schClass" style="min-width: 6em;"> 
					</td>
				</tr>
			</table>
		</form>
		
		<div class="subCon1 mgT15">
			<h2>${msg.C000001087}</h2> <!-- Air Online Particle 수집 정보 -->
			<div style="display:flex">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div class="wd25p" style="display:inline-block; order:1;" >
					<div id="particleList" class="mgT15" style="height:500px;"></div>
				</div>
				<div class="wd73p" style="display:inline-block; order:2;">
					<div class="mgT5" style="text-align:right;">
						<label><input type="radio" name="type" id="line" value="line" checked/>&nbsp;${msg.C000000024}</label> <!-- LINE -->
						<label><input type="radio" name="type" id="bar" value="bar"/>&nbsp;${msg.C000000025}</label> <!-- BAR -->
					</div>
					<div class="mgT15">
						<canvas id="particleChart" class="wd100p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>
					</div>
					<div class="mgT5">
						<div style="text-align:center;">			
							<button type="button" id="btnChartExcelDown" class="inTableBtn inputBtn save">${msg.C000000996}</button> <!-- 차트저장 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<form id="frmChartData" method="post" action="/com/chartImgDown.lims">
			<input type="text" name="chartImg" id="chartImg" value="" style="display:none;"/>
		</form>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
$(function() {
	
	datePickerCalendar(["stMesureDt","endMesureDt"],true,["DD",-1]);
	
	//곰보빡스
	renderCombo();
	
	setParticleGrid();

	setButtonEvent();
	
	gridResize([particleList]);
});
</script>
<script>
//그냥이거 보기쉬우라고 여기다가 뻇음 알아서 만드십시요

var colorList = [
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
];

var ctx = document.getElementById("particleChart").getContext("2d");
var particleChart = new Chart(ctx, {
    type: "line",
    data: {
        labels: ["${msg.C000001246}"], /* 농도\n시간 */
        datasets: []
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero: true
                }
            }]
        },
        zoom : {
        	enabled : true,
        	mode : 'y'
        }
    }
});
</script>
<script>
var particleList = 'particleList';
var getEl = function(id){//id에 해당하는 선택자 가져오기.
	return document.getElementById(id);
};

//그리드 생성
function setParticleGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			particleLayout : []
	};
	
	// 사용량 그리드
	auigridCol(columnLayout.particleLayout);
	columnLayout.particleLayout.addColumnCustom("mesureDt","${msg.C000001088}","28%",true) /* 측정시간 */
	.addColumnCustom("mesure1Value","${msg.C000001089}","18%",true) /* 0.2u */
	.addColumnCustom("mesure2Value","${msg.C000001090}","18%",true) /* 0.3u */
	.addColumnCustom("mesure3Value","${msg.C000001091}","18%",true) /* 0.5u */
	.addColumnCustom("mesure4Value","${msg.C000001092}","18%",true); /* 1.0u */
	
	particleList = createAUIGrid(columnLayout.particleLayout, particleList);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getParticleList();//모든 바코드 리스트를 호출함.
	});
	
	//차트 엑셀다운 이벤트
	getEl("btnChartExcelDown").addEventListener("click",function(){
		//숨겨놓은 차트 폼에 데이터 박음
		getEl("chartImg").value = getEl("particleChart").toDataURL("image/png");
	    
		//다운로드한다
		getEl("frmChartData").submit();
	});
};

function getParticleList(){
	ajaxJsonForm3("/src/getParticleList.lims", "searchFrm", function(data){
		if(!!data){
			var type = $(":input:radio[name=type]:checked").val();

			renderChart(data, type);
			AUIGrid.setGridData(particleList, data);
		}
	});
};

//곰보박스
function renderCombo(){
	ajaxJsonComboBox3("/src/getMhrlsList.lims","mhrlsSeqno",null , true);
	//stMesureP
	ajaxJsonComboBox("/com/getCmmnCode.lims", "stMesureP", {"upperCmmnCode" : "RS22"}, false, null);
}

function renderChart(data, chartType){
	
	//기초 데이터 생성용 변수 생성
	//얘는 데이터 목록
	var mesure1ValueList = new Array();
	var mesure2ValueList = new Array();
	var mesure3ValueList = new Array();
	var mesure4ValueList = new Array();
	
	// 얘는 맨밑에 날짜 라벨 목록
	var mesureDtList = new Array();
	
	//반복문에 모조리넣음
	for(var i=0; i<data.length; i++){
		mesure1ValueList.push(data[i].mesure1Value);
		mesure2ValueList.push(data[i].mesure2Value);
		mesure3ValueList.push(data[i].mesure3Value);
		mesure4ValueList.push(data[i].mesure4Value);
		mesureDtList.push(data[i].mesureDt);
	}
	
	// 기초데이터를 object로 만들었음.
	var valueList = [
		{
			"list" : mesure1ValueList,
			"label" : "${msg.C000001089}", /* 0.2u */
			"fill" : false,
			"borderWidth" : 1
		}, {
			"list" : mesure2ValueList,
			"label" : "${msg.C000001090}", /* 0.3u */
			"fill" : false,
			"borderWidth" : 1
		}, {
			"list" : mesure3ValueList,
			"label" : "${msg.C000001091}", /* 0.5u */
			"fill" : false,
			"borderWidth" : 1
		}, {
			"list" : mesure4ValueList,
			"label" : "${msg.C000001092}", /* 1.0u */
			"fill" : false,
			"borderWidth" : 1
		}
	];
	//config 접근도어렵다 하... 
	var config = particleChart.config;
	
	// 전역설정. 타이틀, 반응형으로 설정.
	config.options.responsive = true;
	config.options["title"]["display"] = true;
	config.options["title"]["text"] = "${msg.C000001093}"; /* Particle 차트 */
	//타입별로 데이터 생성 / config 생성을 다르게한다.
	if(chartType == "line"){
		
		//라인차트로 변경
		config.type = "line";
		
		//Y축의 scale을 0부터 시작하게한다.
		config.options.scales.yAxes[0].ticks.beginAtZero = true;
		
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		particleChart["data"] = {
				"labels" : mesureDtList,
				"datasets" : []
		};
		console.log(valueList);
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<valueList.length; i++){
			console.log(valueList[i]);
			particleChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"fill" : valueList[i].fill,
				"borderColor" : colorList[i],
				lineTension: 0
			};
		}
		
	} else if(chartType == "bar"){
		
		// config의 타입을 bar 차트로.
		config.type = "bar";
		
		//차트의 스케일을 잡는다
		var scales = config.options.scales;
		
		//스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
		scales.xAxes[0].stacked = true;
		scales.yAxes[0].stacked = true;
		
		//Y축의 틱은 0부터.
		scales.yAxes[0].ticks.beginAtZero = true;
		
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		particleChart["data"] = {
				"labels" : mesureDtList,
				"datasets" : []
		};
		
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<valueList.length; i++){
			particleChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"backgroundColor" : colorList[i]
			};
		}
	}
	console.log(particleChart);
	// 완성된 차트는 업데이트를 시켜주면된다.
	particleChart.update();
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>