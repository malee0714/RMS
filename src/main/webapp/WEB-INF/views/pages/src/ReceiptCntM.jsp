<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">

<tiles:putAttribute name="script">
<script>
var receiptCntList = "receiptCntList";
var receiptCntChart;
$(document).ready(function(){
	getAuth();
	
	//초기세팅
	init();
	
	//콤보 박스 초기화
	setCombo();
	
	//차트 생성
	createChart();
	
	//담당 팁별 접수 건수 그리드 세팅
	setReceiptListGrid();
	
	//버튼 이벤트 선언
	setButtonEvent();
	
	
});
//초기세팅
function init(){
	//달력 의뢰일자
	datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["DD",-7], ["MM",0]);
}

//콤보 박스 초기화
function setCombo(){
	//부서
	//담당팀
	ajaxJsonComboBox('/com/getAnalsTeamCombo.lims','shrAnalsTeam', {deptCode : "3992"}, true, null);
	
	ajaxJsonComboBox('/com/getDeptCombo.lims','shrReqestDeptCode',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"==전체==");
	
	//담당 그룹 IP
	ajaxJsonComboBox('/wrk/getChrgTeamIpList.lims','shrAnalsTeamIp', {"chrgTeamSeqno" : getEl("shrAnalsTeam").value}, true, null);
}

//담당 팁별 접수 건수 그리드 세팅
function setReceiptListGrid(){
	var col = [];	
	
	auigridCol(col);
		
	col.addColumnCustom("analsTeamSeqno", "${msg.C000000954}", "*" ,false); /* 분석 팀 일련번호 */
	col.addColumnCustom("analsTeamNm", "${msg.C000000624}", "*" ,true); /* 담당 팀 */	
	col.addColumnCustom("hour", "${msg.C000000958}", "*", true); /* 시간(Hour) */
	col.addColumnCustom("rceptCnt", "${msg.C000000961}", "*", true); /* 건수 */
	
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}	
	
	
	//auiGrid 생성
	receiptCntList = createAUIGrid(col, "receiptCntList", cusPros);
	
	// 그리드 칼럼 리사이즈	
	AUIGrid.bind(receiptCntList, "ready", function(event) {
		gridColResize([receiptCntList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//버튼 이벤트 선언
function setButtonEvent(){
	//조회버튼 클릭
	$("#btnSearch").click(function(){
		searchReceipt();
	});
	
	//부서 셀렉트박스 이벤트
	$("#shrDeptCode").change(function(){
		//담당팀 (의뢰 접수 기준)
		ajaxJsonComboBox('/com/getAnalsTeamCombo.lims','shrAnalsTeam', {deptCode : $("#shrDeptCode option:selected").val()}, true, null);
	});
	
	//line, bar 변경 이벤트
	$("[name=chartType]").change(function(){
		//문서 목록 조회			
		searchReceipt();
	});
	
	//차트 엑셀 다운로드
	$("#btnChartExcelDown").click(function(){		
		$("#chartImg").val($("#receiptCntChart")[0].toDataURL("image/png"));
		$("#frmChartData").submit();
	});
	
	//담당팀 수정시
	$("#shrAnalsTeam").change(function(){
		ajaxJsonComboBox('/wrk/getChrgTeamIpComboList.lims','shrAnalsTeamIp', {"chrgTeamSeqno" : getEl("shrAnalsTeam").value}, true, null);
	})
}

//문서 목록 조회
function searchReceipt(keyCode){
	if(keyCode != undefined && keyCode == 13)
		searchDoc();
	else {
		if(keyCode == undefined) {
			
			//문서 목록 조회			
			ajaxJsonForm("/src/getReceiptCntList.lims", "searchFrm", function(data){
				if(data.length > 0){
					var type = $("[name=chartType]:checked").val();			
					renderChart(data, type);
					AUIGrid.setGridData(receiptCntList, data);
				}
			});
		}
	}
}

//차트 생성
function createChart(){
	var chValueChartDoc = document.getElementById('chValueChartDiv');
	chValueChartDoc.innerHTML = '&nbsp;';
	$('#chValueChartDiv').append('<canvas id="receiptCntChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>');
	var ctx = document.getElementById("receiptCntChart").getContext("2d");
	
	receiptCntChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	    	labels: ['${msg.C000000966}','${msg.C000000900}','${msg.C000000902}','${msg.C000000905}','${msg.C000000907}','${msg.C000000967}','${msg.C000000968}','${msg.C000000969}'
	    		,'${msg.C000000970}','${msg.C000000971}','${msg.C000000972}','${msg.C000000973}','${msg.C000000974}','${msg.C000000975}','${msg.C000000976}','${msg.C000000977}'
	    		,'${msg.C000000978}','${msg.C000000979}','${msg.C000000980}','${msg.C000000981}','${msg.C000000982}','${msg.C000000983}','${msg.C000000984}','${msg.C000000985}'], 
// 	    	'시간 0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23'
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
		  	scales: {
		    	yAxes: [{
		      		gridLines: {
		        		color: "black",
		        		borderDash: [2, 5]
		      		},
		      		scaleLabel: {
		        		display: true,
		        		labelString: "${msg.C000000961}", /* 건수 */
		        		fontColor: "green"
		      		}
		    	}]
		 	 },
		 	 zoom : {
		 		 enabled : true,
		 		 mode : 'y'
		 	 }
		}
	});
}

//불러온 데이터로 차트 생성
function renderChart(data, chartType){
// 	receiptCntChart.destroy();
	createChart();
	
	var chrgTeamIpSeqno ="";
	 
	var receptCnt = new Array();
	var deptNm = "";
	var valueList = [];
	
	//data 에 넣어줄 건수 배열에 넣기
	for(var j=0; j<data.length; j++){
		console.log(data[j]["chrgTeamIpSeqno"])
		if(chrgTeamIpSeqno == data[j]["chrgTeamIpSeqno"]) {					
			receptCnt.push(data[j]["rceptCnt"]);
			deptNm = data[j]["analsTeamNm"];
		}else{
			if(j != 0){
				valueList.push({
					"list" : receptCnt,	
					"label" : deptNm,
					"fill" : false,
					"borderWidth" : 1
				});
			}
			
			
			receptCnt = [];
			deptNm = "";
			receptCnt.push(data[j]["rceptCnt"]);
			deptNm = data[j]["analsTeamNm"];
		}
		
		chrgTeamIpSeqno = data[j]["chrgTeamIpSeqno"];
		
		//포문 마지막에데이터 밀어 넣기.
	 	if(j == (data.length-1)){
			valueList.push({
				"list" : receptCnt,	
				"label" :deptNm,
				"fill" : false,
				"borderWidth" : 1
			});
		}
	}
	
	//config
	var config = receiptCntChart.config;
	
	if(chartType == "line"){
		var cnt = 0;
		//라인차트로 변경
		config.type = "line";
		
		for(var i=0; i<valueList.length; i++){
			//차트 옵션 생성
			receiptCntChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"fill" : valueList[i].fill,
			    borderColor: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
			    lineTension: 0
			}
		}
	} else if(chartType == "bar"){
		var cnt = 0;
		// config의 타입을 bar 차트로.
		config.type = "bar";
		
		//차트의 스케일을 잡는다
		var scales = config.options.scales;
		
		//스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
		scales.xAxes[0].stacked = true;
		scales.yAxes[0].stacked = true;
		
		//Y축의 틱은 0부터.
		scales.yAxes[0].ticks.beginAtZero = true;
		
		for(var i=0; i<valueList.length; i++){
			//차트 옵션 생성
			receiptCntChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"fill" : valueList[i].fill,
			    backgroundColor: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
			    lineTension: 0
			}
		}
	}
	// 완성된 차트는 업데이트를 시켜주면된다.
	receiptCntChart.update();
}
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000991}</h2> <!-- 담당 팀별 접수 건수 조회 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<form id="searchFrm">
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
					<th>${msg.C000000624}</th> <!-- 담당팀 -->
					<td><select id="shrAnalsTeam" name="shrAnalsTeam"></select></td>
					<th>${msg.C000000993}</th> <!-- 담당그룹 IP -->
					<td><select id="shrAnalsTeamIp" name="shrAnalsTeamIp"></select></td>
					<th>${msg.C000000080}</th> <!-- 부서 -->
					<td><select id="shrReqestDeptCode" name="shrReqestDeptCode" ></select></td>
					<th>
						<select class="wd100p schClass" name=srchType id="srchType">
							<option value="rceptDte">${msg.C000000994}</option> <!-- 접수 일자 -->
							<option value="reqestDte">${msg.C000000576}</option> <!-- 의뢰 일자 -->
						</select>
					</th>
					<td style="text-align:left;">
						<input type="text" id="shrReqestBeginDte" name="shrReqestBeginDte" class="wd10p" style="min-width: 6em;"> 
						~ 
						<input type="text" id="shrReqestEndDte" name="shrReqestEndDte" class="wd10p" style="min-width: 6em;">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon1 mgT15">
		<h2>${msg.C000000995}</h2> <!-- 담당 팀별 접수 건수 정보 -->
		<div style="display:flex">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div class="wd25p mgT15" style="display:inline-block; order:1;" >
				<div id="receiptCntList" class="wd100p" style="height:450px;"></div>
			</div>
			<div class="wd73p" style="display:inline-block; order:2;" >
				<div class="mgT5" style="text-align: right;">
					<label><input type="radio" name="chartType" id="line" value="line" checked/>${msg.C000000024}</label> <!-- LINE -->
					<label><input type="radio" name="chartType" id="bar" value="bar" />${msg.C000000025}</label> <!-- BAR -->
				</div>
				<div class="mgT15" id="chValueChartDiv">
					<canvas id="receiptCntChart" class="wd100p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>
				</div>
				<div class="mgT15">
					<div style="text-align:center;" class="mgT5">
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
</tiles:putAttribute>
</tiles:insertDefinition>