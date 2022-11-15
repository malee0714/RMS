<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기관리</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
var mhrlsUnInspctList = "mhrlsUnInspctList";
var monthMhrlsUnInspctList = "monthmhrlsUnInspctList";
var deptMhrlsUnInspctList = "deptMhrlsUnInspctList";
var dropZoneArea;
var lang = ${msg}; // 기본언어
$(function(){
 	getAuth();

	//초기화
	init();
	
	//콤보 박스 초기화
	setCombo();
	
	//검교정 목록 그리드 생성
	setMhrlsUnInspctGrid();
	
	//그리드 이벤트
	setMhrlsUnInspctGridEvent();
	
	//버튼 이벤트 선언
	setButtonEvent();
	
	$("#tab1").click();

});

var colorList = [
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
];

var ctx = document.getElementById('chValueChart').getContext('2d');
var ctx2 = document.getElementById('chDeptValueChart').getContext('2d');
var chValueChart = new Chart(ctx, {
    type: "bar",
    data: {
        //labels: ["농도\n시간"],
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
        zoom: {
	         enabled: true,
	         mode: 'y',
	      },
        tooltips: {
        	position: "nearest",
			mode: "index",
			intersect: false,
		}
		
    }
});
var chDeptValueChart = new Chart(ctx2, {
    type: "bar",
    data: {
        //labels: ["농도\n시간"],
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
        zoom: {
	         enabled: true,
	         mode: 'y',
	      },
        tooltips: {
        	position: "nearest",
			mode: "index",
			intersect: false,
		}
    }
});
var chValueList = 'chValueList';
var chDeptValueList = 'chDeptValueList';
var getEl = function(id){//id에 해당하는 선택자 가져오기.
	return document.getElementById(id);
};

//월별 조회
function getchkValueList(){
	   getGridDataForm("<c:url value='/rsc/getMonthMhrlsUnInspctM.lims'/>", "searchFrm", monthMhrlsUnInspctList, function(data) {
		   if (!!data) {
			   var type = $("[name=chartType]:checked").val();
			   renderChart(data, type);
	         }
		   
	    }); 

};

// 부서별조회
function getchkDeptValueList(){
	   getGridDataForm("<c:url value='/rsc/getdeptMhrlsUnInspctM.lims'/>", "searchFrm", deptMhrlsUnInspctList, function(data) {
		   if (!!data) {
			   var type = $("[name=deptChartType]:checked").val();
			   renderDeptChart(data, type);
	         }
	    }); 

};

function renderChart(data, chartType){

	//기초 데이터 생성용 변수 생성
	//얘는 데이터 목록
	var mhrlsUnInspct1ValueList = new Array();
	var mhrlsUnInspct2ValueList = new Array();

	
	// 얘는 맨밑에 날짜 라벨 목록
	var mesureDtList = new Array();
	var mesureDt2List = new Array();

	var valueList = [];
	var valueList2 =[];
	//반복문에 모조리넣음

	for(var i=0; i<data.length; i++){
		mhrlsUnInspct1ValueList.push(data[i].monthData); //계획
	 	mhrlsUnInspct2ValueList.push(data[i].implement); //실시
		mesureDtList.push(data[i].month); //월
	}
	

	var chkList = [{
		"list" : mhrlsUnInspct1ValueList,
		"label" : "${msg.C000001332}", /* 계획 */
		"fill" : false,
		"borderWidth" : 1
	},{
		"list" : mhrlsUnInspct2ValueList,
		"label" : "${msg.C000001331}", /* 실시 */
		"fill" : false,
		"borderWidth" : 1
	}]


	//config 접근도어렵다 하... 
	var config = chValueChart.config;

	if(chartType == "line"){

		//라인차트로 변경
		config.type = "line";
		
		//Y축의 scale을 0부터 시작하게한다.
		config.options.scales.yAxes[0].ticks.beginAtZero = true;
		config.options.responsive = true;
		config.options.zoom = {
				enabled : true,
				mode : 'y'
		}
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		chValueChart["data"] = {
				"labels" : mesureDtList,
				"datasets" : []
		};
		
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<chkList.length; i++){
			chValueChart.data.datasets[i] = {
				"label" : chkList[i].label,
				"data" : chkList[i].list,
				"fill" : chkList[i].fill,
				"borderColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
				lineTension: 0
			};
		
		}

	} else if(chartType == "bar"){

		// config의 타입을 bar 차트로.
 		config.type = "bar";

		//차트의 스케일을 잡는다
 		var scales = config.options.scales;

 		//스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
 		scales.xAxes[0].stacked = false;
 		scales.yAxes[0].stacked = false;


		//Y축의 틱은 0부터.
		
		scales.yAxes[0].ticks.beginAtZero = true;
		
		/*얘는 바 굵기 혹시 몰라 주석해둠*/
// 		scales.xAxes[0].maxBarThickness= "20";


		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		chValueChart["data"] = {
				"labels" : mesureDtList,
				"datasets" : []
		};
		
			
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<chkList.length; i++){
			chValueChart.data.datasets[i] = {
				"label" : chkList[i].label,
				"data" : chkList[i].list,
				"backgroundColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
			}
		}

	
		
	}

	console.log('chk : ', chValueChart);
	// 완성된 차트는 업데이트를 시켜주면된다.
	chValueChart.update();
}

function renderDeptChart(data, chartType){
	//기초 데이터 생성용 변수 생성
	//얘는 데이터 목록
	var deptMhrlsUnInspct1ValueList = new Array();
	var deptMhrlsUnInspct2ValueList = new Array();

	
	// 얘는 맨밑에 날짜 라벨 목록
	var mesureDeptDtList = new Array();
	var mesureDeptDt2List = new Array();

	var deptValueList = [];
	var deptValueList2 =[];
	//반복문에 모조리넣음

	for(var i=0; i<data.length; i++){
		deptMhrlsUnInspct1ValueList.push(data[i].deptMonthData); //부서 계획	
		deptMhrlsUnInspct2ValueList.push(data[i].deptImplement); //부서 실시
		mesureDeptDtList.push(data[i].deptNm); //부서명
	}

	deptValueList.push({
		"list" : deptMhrlsUnInspct1ValueList,
 		"label" : "${msg.C000001332}", /* 계획 */
		"fill" : false,
		"borderWidth" : 1
	});
	
	deptValueList.push({
		"list" : deptMhrlsUnInspct2ValueList,
 		"label" : "${msg.C000001331}", /* 실시 */
		"fill" : false,
		"borderWidth" : 1
	});
	

	//config 접근도어렵다 하... 
	var config = chDeptValueChart.config;

	if(chartType == "line"){
		
		//라인차트로 변경
		config.type = "line";
		//Y축의 scale을 0부터 시작하게한다.
		config.options.scales.yAxes[0].ticks.beginAtZero = true;
		
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		chDeptValueChart["data"] = {
				"labels" : mesureDeptDtList,
				"datasets" : []
		};
	
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<deptValueList.length; i++){
			chDeptValueChart.data.datasets[i] = {
				"label" : deptValueList[i].label,
				"data" : deptValueList[i].list,
				"fill" : deptValueList[i].fill,
				"borderColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
				lineTension: 0
			};
			
		}
	
		
	} else if(chartType == "bar"){
		// config의 타입을 bar 차트로.
 		config.type = "bar";
		//차트의 스케일을 잡는다
 		var scales = config.options.scales;
		
 		//스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
 		scales.xAxes[0].stacked = false;
 		scales.yAxes[0].stacked = false;
		
		//Y축의 틱은 0부터.
		scales.yAxes[0].ticks.beginAtZero = true;
		
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		chDeptValueChart["data"] = {
				"labels" : mesureDeptDtList,
				"datasets" : []
		};
		
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<deptValueList.length; i++){
			chDeptValueChart.data.datasets[i] = {
				"label" : deptValueList[i].label,
				"data" : deptValueList[i].list,
				"backgroundColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
			};
		}
	}
	

	// 완성된 차트는 업데이트를 시켜주면된다.
	chDeptValueChart.update();
}

function init(){
}

//콤보박스 세팅
function setCombo(){
	//부서
	ajaxJsonComboBox('/com/getDeptCombo.lims','shrDeptCode', {analsAt : "Y", deptAt : "Y", mmnySeCode : "SY01000001"}, false,"${msg.C000000079}"); /* 선택 */
	//검색 검교정 방법	
	ajaxJsonComboBoxCommon("RS12", "shrInspctCrrctMthCode", false,"${msg.C000000079}"); /* 선택 */
	
	datePickerCalendar(["shrInspctCrrctBeginDte", "shrInspctCrrctEndDte"], true, ["MM",-6], ["DD",0]);
	
	//검교정 알림 설정 다이얼로그
	changePointDialog("btn_changePoint", {ntcnSeCode : "SY18000002"}, "changePoint", function(data){}, null);
}

//그리드 생성
function setMhrlsUnInspctGrid(){
	
	var col = [],
	monthCol =[],
	deptCol=[];
	var codeDataArray = [];
	var mthArray = [];
	
	auigridCol(col);	
	auigridCol(monthCol);
	auigridCol(deptCol);
	var gridColRequire = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '${msg.C000000263}' /* 값을 입력 또는 선택하세요. */ 
		}
		//styleFunction : cellStyleFunction
	};
	
	var gridDate = {
		dataType : "date",
		dateInputFormat : "yyyy-mm-dd",
		formatString : "yyyy-mm-dd",
		editRenderer : {
			type : "JQCalendarRenderer",
			defaultFormat : "yyyy-mm-dd",
			openDirectly : true,
			onlyCalendar : false,
			jqOpts : {
				changeMonth: true,
				changeYear: true,
				selectOtherMonths : true,
				showOtherMonths: true
			},
			validator : function(oldValue, newValue, rowItem){
				var date, isValid = true;
				if(isNaN(Number(newValue)) ) { //20190201 형태 또는 그냥 1, 2 로 입력한 경우는 허락함.
					if(isNaN(Date.parse(newValue))) { // 그냥 막 입력한 경우 인지 조사. 즉, JS 가 Date 로 파싱할 수 있는 형식인지 조사
						isValid = false;
					} else {
						isValid = true;
					}
				}
				// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
				return { "validate" : isValid, "message"  : "${msg.C000000601}" }; /* yyyy-mm-dd 형식으로 입력해주세요. */
			}
	
		}
	};
	
	col.addColumnCustom("unregistEqpSeqno", "${msg.C000001067}", "*", false, false); /* 미등록 설비 일련번호 */
	col.addColumnCustom("deptCode", "${msg.C000000106}", "*" ,true, false); /* 부서명 */
	col.addColumnCustom("mhrlsNm", "${msg.C000000597}", "*" ,true, true, gridColRequire); /* 설비명 */
	col.addColumnCustom("mhrlsManageNo", "${msg.C000000598}", "*" ,true, true);  /* PM 설비번호 */
	col.addColumnCustom("inspctCrrctPlanDte", "${msg.C000000586}", "*", true, true, gridDate); /* 검교정 계획 일자 */
	col.addColumnCustom("sanctnDrftDte", "${msg.C000000589}", "*", true, true, gridDate); /* 결재 기안 일자 */
	col.addColumnCustom("inspctCrrctOpertnAt", "${msg.C000000599}", "*", true, false, gridColRequire); /* 검교정 시행 여부 */
	col.addColumnCustom("inspctCrrctCycle", "${msg.C000000525}", "*", true, true); /* 검교정 주기 */ 
	col.addColumnCustom("inspctCrrctMthCode", "${msg.C000000584}", "*", true, false); /* 검교정 방법 */ 
	col.addColumnCustom("inspctCrrctChargerNm", "${msg.C000000588}", "*", true, true); /* 검교정 검사자 */ 
	col.addColumnCustom("nextInspctCrrctDte", "${msg.C000000587}", "*", true, true, gridDate);	 /* 차기 검교정 일자 */
	col.addColumnCustom("inspctCrrctDte", "${msg.C000000585}", "*", true, true, gridDate); /* 검교정 일자 */
	
	//월별
	monthCol.addColumnCustom("month", "${msg.C000000016}", "*", true, false); /* 구분 */
	monthCol.addColumnCustom("monthData", "${msg.C000001332}", "*", true, false); /* 계획 */
	monthCol.addColumnCustom("implement", "${msg.C000001331}", "*", true, true);  /* 실시 */
	
	//부서별
	deptCol.addColumnCustom("deptNm", "${msg.C000000016}", "*", true, false); /* 구분 */
	deptCol.addColumnCustom("deptMonthData", "${msg.C000001332}", "*", true, false); /* 계획 */
	deptCol.addColumnCustom("deptImplement", "${msg.C000001331}", "*", true, false); /* 실시 */

	
	
	var deptCodeParams = {
			analsAt	   : "Y"
		   ,mmnySeCode : "${UserMVo.mmnySeCode}"
	};
	
	var useYnLst = [
		 {key : "${msg.C000000264}", value : "Y"} /* 예 */
		,{key : "${msg.C000000265}", value : "N"} /* 아니오 */
	];
	
	
	//부서명 그리드 콤보박스 설정	
	comboAjaxJsonParam('/com/getDeptCombo.lims', {analsAt : "Y", deptAt : "Y", mmnySeCode : "SY01000001"}, function(data){		
		codeDataArray = setGridComboBox(data);
		
	}, null, false);
	
	//검교정 방법 그리드 콤보박스 설정	
	comboAjaxJsonParam('/com/getCmmnCode.lims', {upperCmmnCode : "RS12"}, function(data){		
		mthArray = setGridComboBox(data);
		
	}, null, false);
	
	col.dropDownListRenderer(["deptCode"], codeDataArray, true, null);
	col.dropDownListRenderer(["inspctCrrctMthCode"], mthArray, true, null);
	col.dropDownListRenderer(["inspctCrrctOpertnAt"], useYnLst, true, null);	
	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		showEditedCellMarker : true,
			showStateColumn : true,
			softRemoveRowMode : true
 	}	
	
	
	//auiGrid 생성
	mhrlsUnInspctList = createAUIGrid(col, "mhrlsUnInspctList", cusPros);
	monthMhrlsUnInspctList = createAUIGrid(monthCol, "monthMhrlsUnInspctList");
	deptMhrlsUnInspctList = createAUIGrid(deptCol, "deptMhrlsUnInspctList");
	
	// 그리드 리사이즈.
	gridResize([mhrlsUnInspctList,monthMhrlsUnInspctList,deptMhrlsUnInspctList]);
	// 그리드 칼럼 리사이즈
	
	AUIGrid.bind(mhrlsUnInspctList, "ready", function(event) {
		gridColResize([mhrlsUnInspctList],"2");	// 1, 2가 있으니 화면에 맞게 적용
		gridColResize([monthMhrlsUnInspctList],"2");	// 1, 2가 있으니 화면에 맞게 적용
		gridColResize([deptMhrlsUnInspctList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

function setMhrlsUnInspctGridEvent(){
	
}

//버튼 이벤트
function setButtonEvent(){
	//양식 다운로드
	$("#btn_form_download").click(function(){
		location.href = ${formFilePath} + "/assets/formFile/test_plan_upload_form.xlsx";
	});
	
	//행 추가
	$("#btn_add_row").click(function(){
		var item = {
				 "deptCode"	: ""
				,"deptNm"	: ""
				,"mhrlsNm"	: ""
				,"mhrlsManageNo"	: ""
				,"inspctCrrctPlanDte"	: ""
				,"sanctnDrftDte"			: ""
				,"inspctCrrctOpertnAt"	: ""
				,"inspctCrrctCycle"		: "" 
				,"inspctCrrctMthCode"	: ""
				,"inspctCrrctChargerNm"	: ""
				,"nextInspctCrrctDte"	: ""
				,"inspctCrrctDte"		: ""
		};
		
		AUIGrid.addRow(mhrlsUnInspctList, item, 0);
	});
	
	//행 삭제
	$("#btn_remove_row").click(function(){
		var gridData = AUIGrid.getCheckedRowItems(mhrlsUnInspctList);
		var array = [];
		
		for(var i=0; i<gridData.length; i++){
			array[i] = gridData[i]["rowIndex"];
		}
		
		AUIGrid.removeRow(mhrlsUnInspctList, array); 
		
	});
	
	//저장
	$("#btn_save").click(function(){
		//행 추가 데이터
		var addGridData = AUIGrid.getAddedRowItems(mhrlsUnInspctList);
		//행 수정 데이터
		var editGridData = AUIGrid.getEditedRowItems(mhrlsUnInspctList);
		//행 삭제 데이터
		var removeGridData = AUIGrid.getRemovedItems(mhrlsUnInspctList);
		//그리드 데이터
		var gridData = AUIGrid.getGridData(mhrlsUnInspctList);
		//에러 메시지 문구
		var str = "";
		
		if(addGridData.length == 0 && editGridData.length == 0 && removeGridData.length == 0){
			alert("${msg.C000000602}"); /* 저장할 미등록 설비 검교정 정보가 없습니다. */ 
			return;
		}
		
		
		if(formNecessaryValidationCheck("", [mhrlsUnInspctList])){
			
			if(confirm("${msg.C000000306}")){ /* 저장 하시겠습니까? */ 
				showLoadingbar();
				var params = {};			
				params.addGridData = addGridData;
				params.editGridData = editGridData;
				params.removeGridData = removeGridData;
				
				ajaxJsonParam("<c:url value='/rsc/saveMhrlsUnInspctM.lims'/>", params, function(data){
					if(data > 0){
						alert("${msg.C000000071}"); /* 저장 되었습니다. */
						searchMhrls();
						hideLoadingbar();
					}
				});
			}
			
		}
	});
	
	//조회 버튼
	$("#btn_search").click(function(){
		searchMhrls();
	});
	
	//양식 업로드
	$("#btn_form_upload").click(function(){
		
		if(confirm("${msg.C000000718}")){ /* 업로드 하시겠습니까?? */ 
			showLoadingbar();
		
			var file = $("#formFile")[0]
			var fileName = file.files[0].name;
			var fileExt = fileName.substring(fileName.length, fileName.length-3);
					
			var formData = new FormData();
			formData.append("formFile", $("#formFile")[0].files[0]);
			
			ajaxJsonFormFile("/rsc/applyFormFile.lims", formData, function(data){	
				//AUIGrid.addRow(mhrlsUnInspctList, data, 0);
				if(data > 0){
					alert("${msg.C000000071}"); /* 저장 되었습니다. */
					searchMhrls();
				}
				else if(data == -2){
					alert("${msg.C000001068}") /* 팀코드를 확인해 주세요. */
				}
				else{
					alert("${msg.C000000170}") /* 저장에 실패하였습니다. */
				}
				
				hideLoadingbar();
			}, null, null);
		}
		
	});
	
	//필증 다운로드
	$("#btn_Proof_download").click(function(){
		
		var imgeUrl = ${formFilePath}+ "/assets/formFile/test_plan.png";
		var gridData = AUIGrid.getCheckedRowItemsAll(mhrlsUnInspctList);
		
		if(gridData.length == 0){
			alert("${msg.C000000720}") /* 미등록 설비 검교정 목록을 선택해 주세요. */
			return;
		}
		
		var str = "[";
		
		for(var i=0; i<gridData.length; i++){			
			if(i == 0){
				str += gridData[i]["unregistEqpSeqno"];
			}
			else{
				str += "," + gridData[i]["unregistEqpSeqno"];
			}
		}
		
		str += "]"; 
		str += "[" + imgeUrl + "]";
		
		html5Viewer2("/test_plan_rd.mrd", str);
		
	});
	
	$("[name=chartType]").change(function(){	
		getchkValueList();
	

	});
	$("[name=deptChartType]").change(function(){	
		getchkDeptValueList();
	});
	
}

//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13){
		searchMhrls();
	}		
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/rsc/getMhrlsUnInspctM.lims'/>", "searchFrm",  mhrlsUnInspctList);
			getGridDataForm("<c:url value='/rsc/getMonthMhrlsUnInspctM.lims'/>", "searchFrm",  monthMhrlsUnInspctList);
			getGridDataForm("<c:url value='/rsc/getdeptMhrlsUnInspctM.lims'/>", "searchFrm",  deptMhrlsUnInspctList);
			getchkValueList();
			getchkDeptValueList();
		}
	}
}

//배열생성
function setGridComboBox(data){
	var array = [];
	
	for(var i=0; i<data.length; i++){
		var dataParams = {};
		dataParams.value = data[i]["value"];
		dataParams.key = data[i]["key"];
		
		array.push(dataParams);
	}
	
	return array;
}
</script>

</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000593}</h2> <!-- 미등록 설비 검교정 목록 -->
		<div class="btnWrap"> 
			<button type="button" id="btn_changePoint" class="btn3 search">${msg.C000001307}</button><!-- 검교정 알림설정 -->
			<button type="button" id="btn_save" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->			
			<button type="button" id="btn_add_row" class="save btn4">${msg.C000000111}</button> <!-- 행추가 -->
			<button type="button" id="btn_remove_row" class="save btn5">${msg.C000000112}</button> <!-- 행삭제 -->
			<button type="button" id="btn_form_download" class="search btn3">${msg.C000000594}</button> <!-- 양식 다운 -->
			<button type="button" id="btn_Proof_download" class="search btn3">${msg.C000000719}</button> <!-- 필증 다운로드 -->			
			<button type="button" id="btn_search" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->			
		</div>
		<form id="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">	
				<colgroup>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
				</colgroup>				
				<tr>
					<th>${msg.C000000080}</th> <!-- 부서 -->
					<td><select id="shrDeptCode" name="shrDeptCode" class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000584}</th> <!-- 검교정 방법 -->
					<td><select id="shrInspctCrrctMthCode" name="shrInspctCrrctMthCode" class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000599}</th> <!-- 검교정 시행 여부 -->
					<td style="text-align: left;">
						<select id="shrInspctCrrctOpertnAt" name="shrInspctCrrctOpertnAt" class="wd36p" style="min-width:10em;">
							<option value="">${msg.C000000079}</option> <!-- 선택 -->
							<option value="Y">${msg.C000000264}</option> <!-- 예 -->
							<option value="N">${msg.C000000265}</option> <!-- 아니오 -->
						</select>
					</td>
					<th>${msg.C000000525}</th> <!-- 검교정 주기 -->
					<td style="text-align:left;">
						<input type="text" id="shrInspctCrrctBeginDte" name="shrInspctCrrctBeginDte" class="wd40p" style="min-width: 6em;"> 
						~ 
						<input type="text" id="shrInspctCrrctEndDte" name="shrInspctCrrctEndDte" class="wd40p" style="min-width: 6em;">
					</td>
				</tr>				
			</table>
			<div id="tabMenuLst" class="tabMenuLst round skin-peter-river mgT20">
				<ul id="tabs">
				      <li id="tab1" class="tabMenu on">${msg.C000001333}</li> <!-- 목록 -->
			          <li id="tab2" class="tabMenu">${msg.C000001334}</li> <!-- 월별 -->
			          <li id="tab3" class="tabMenu">${msg.C000001335}</li> <!-- 부서별 -->
			    </ul>
			</div>
		</form>		
	</div>
	
 	<!-- 미등록 설비 검교정 그리드 --> 
<!-- 	<div id="mhrlsUnInspctList" class="mgT15" style="width:100%; height:420px; margin:0 auto;"></div> -->
	<form id="MhrlsUnInspctForm">		
		<div id="tabCtsLst">
			<div id="tabCts1" class="tabCts" style="padding-top: 0px;">
			<!-- 미등록 설비 검교정 그리드 -->
			<div id="mhrlsUnInspctList" class="mgT15" style="width:100%; height:420px; margin:0 auto;"></div>
				<div class="subCon1 mgT15" id="detail">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
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
							<th>${msg.C000000600}</th> <!-- 양식 업로드 -->
							<td colspan="7" style="text-align:left;">
								<!-- 파일첨부영역 -->
								<input type="file" id="formFile" name="formFile" class="wd70p" style="min-width:10em;">						
								<button type="button" id="btn_form_upload" class="inTableBtn inputBtn save btn1">${msg.C000000595}</button> <!-- 파일 업로드 -->
							</td>
							
						</tr>
					</table>
				</div>
			</div>
			
			<div id="tabCts2" class="tabCts" style="padding-top: 0px;">
				<div class="mgT5" style="text-align: right; margin-right:20px;">
					<label><input type="radio" name="chartType" id="bar" value="bar" checked/>${msg.C000000025}</label> <!-- BAR -->
					<label><input type="radio" name="chartType" id="line" value="line" />${msg.C000000024}</label> <!-- LINE -->
				</div>
				
				<div class="fL wd25p" style="height:460px;">
					<!-- 월별 미등록 설비 검교정 그리드 -->
					<div id="monthMhrlsUnInspctList" class="fL wd100p" style="width:100%; height:460px; margin:0 auto;"></div>
				</div>	

				<div class="fL wd73p" style="height:455px;" id="chValueChartDiv" >
					<canvas id="chValueChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:455px; border-color:#dbdbdb;"></canvas>
				</div>
			</div>
			
			<div id="tabCts3" class="tabCts" style="padding-top: 0px;">
				<div class="mgT5" style="text-align: right; margin-right:20px;">
					<label><input type="radio" name="deptChartType" id="bar" value="bar" checked />${msg.C000000025}</label> <!-- BAR -->
					<label><input type="radio" name="deptChartType" id="line" value="line" />${msg.C000000024}</label> <!-- LINE -->
				</div>
				
				<div class="fL wd25p" style="height:460px;">
					<!-- 부서별 미등록 설비 검교정 그리드 -->
					<div id="deptMhrlsUnInspctList" style="width:100%; height:460px; margin:0 auto;"></div>
				</div>
				
				<div class="fL wd73p" style="height:455px;" id="DeptChValueChartDiv" >
					<canvas id="chDeptValueChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:455px; border-color:#dbdbdb;"></canvas>
				</div>

			</div>
		</div>	
	</form>
	
</div>
</tiles:putAttribute>
</tiles:insertDefinition>