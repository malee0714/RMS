<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">SPEC</tiles:putAttribute>
<tiles:putAttribute name="script">
<style>
	.c-orange {
		background-color:#FFA64C;
	}
</style>
<script>
var entrpsSpecFormEl = document.querySelector('#entrpsSpecForm');
var entrpsSpecList = "entrpsSpecList"; //제품목록 그리드
var requestList = "requestList"; //시험항목 정보 그리드
var materialList = "materialList"; //자재 그리드
var entrpsSpecHistList = "entrpsSpecHistList"
var dropZoneArea;
var lang = ${msg}; // 기본언어
$(function(){
	getAuth();

	//초기화
	init();

	//콤보 박스 초기화
	setCombo();

	//검교정 목록 그리드 생성
	setentrpsSpecGrid();

	//시험항목 정보 그리드 생성
	setRequestGrid();

	//자재 그리드
	setMaterialGrid();


	
	//고객사 규격 이력 그리드
	setEntrpsSpecHistGrid();

	//그리드 이벤트
	setentrpsSpecGridEvent();

	//버튼 이벤트 선언
	setButtonEvent();

	// 그리드 리사이즈
	gridResize(["entrpsSpecList", "requestList", "materialList", entrpsSpecHistList]);



});

function init(){
	//드랍존
	dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnSave_file", maxFiles : 5, lang : "${msg.C000000118}" } );

	
	var mtrilData = {
		bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
		authorSeCode : '${UserMVo.authorSeCode}',
		girdId : "materialList"
	};
	
	//자재 팝업
	dialogProductPop2("btnPrductSeqno", mtrilData, "Product", function(item){
		AUIGrid.addRow(materialList, item);

		var gridData = AUIGrid.getGridData(materialList);
		var exprGridData = AUIGrid.getGridData(requestList);
		var gridDataArray = [];
		var gridDataExpriemArray = [];
		
		for(var i=0; i<gridData.length; i++){
			gridDataArray[i] = gridData[i]["mtrilSeqno"];
		}
		
		for(var i=0; i<exprGridData.length; i++){
			gridDataExpriemArray[i] = exprGridData[i]["mtrilSdspcSeqno"];
		}
		var params = {
				mtrilSeqno : item.mtrilSeqno
			   ,shrPrductSdspcArray : gridDataArray
			   ,gridDataExpriemArray : []
		};
		AUIGrid.clearGridData(requestList);
		AUIGrid.bind(requestList, "ready", function(event) {
			gridColResize(requestList, "2");	// 1, 2가 있으니 화면에 맞게 적용
		});
		getGridDataParam("<c:url value='/wrk/getPrductExpriemList.lims'/>", params, requestList).then(function(data){
			console.log(data);
		});
		// ready는 화면에 필수로 구현 할 것
		
	},true);
	

	var prductParams = {
			mtrilSeqno : "mtrilSeqno",
			mtrilNm : "mtrilNm",
			girdId : "materialList",
			requestList : "requestList"
	};
	
	// 시험항목 팝업
	/*dialogMtrilSdspc("btnExpriemSearch", prductParams, "exprDialog",  function(data){
		AUIGrid.addRow(requestList, data, 0);
	}, null,function(){
		var gridData = AUIGrid.getGridData("#materialList");

		if(gridData == null || gridData == "" ){
			alert("${msg.C100001034}"); /!* 자재정보를 추가해주세요. *!/
			return false;
		}
	});*/

	//업체 팝업
	dialogEntrps("btnEntrpsSeqno", "SY08000002", "entrpsDialog", function(data){
		$("#entrpsNm").val(data["entrpsNm"]);
		$("#entrpsSeqno").val(data["entrpsSeqno"]);

	}, null);

	//시작일
	datePickerCalendar(["beginDte"], false, ["DD",0], ["DD",0]);
	
	dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {
		var list = res.gridData;
		if (list.length > 0) {
			var sanctnerNm = getSanctnerNm(list);
			docFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
			docFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
		} else {
			warn('선택된 결재자가 없습니다.');
		}

	}, null, "CM05000006"); //결재종류 문서

}

function setCombo(){
	ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims','sanctnLineSeqno',{"deptCode" : "${UserMVo.deptCode}", "sanctnKndCode" :"CM05000002"}, true); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims',"prductSeCodeSch", {"upperCmmnCode" : "SY20", "deptCode" : "${UserMVo.deptCode}"}, true);
	//자사 구분에 따라서 부서 콤보박스 변경
	mmnySeCodeChange();
}

//제품 목록 그리드 생성
function setentrpsSpecGrid(){

	var col = [];

	auigridCol(col);

	var gridData = {
		renderer : { // 템플릿 렌더러 사용
			type : "TemplateRenderer"
		}
	};

	
	
	col.addColumnCustom("entrpsNm", "${msg.C100000587}", "10%", true, false); 				//업체명
	col.addColumnCustom("stdrNm", "${msg.C100000241}", "10%", true, false); 					//기준명
	col.addColumnCustom("ver", "${msg.C100000365}", "4%", true, false); 					//버전
	col.addColumnCustom("updVer", "${msg.C100000118}", "5%", true);  						/*개정 버튼 */
	col.addColumnCustom("beginDte", "${msg.C100000541}", "6%", true, false); 				/*시작일자 */
	col.addColumnCustom("endDte", "${msg.C100000830}", "6%", true, false); 					/*종료일자 */
	col.addColumnCustom("changeDte", "${msg.C100000292}", "6%", true, false); 				//등록일자()
	col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100000846}", "7%", true, false); 	//진행상황
	col.addColumnCustom("changerNm", "${msg.C100000385}", "7%", true, false); 				//변경자
	col.addColumnCustom("confmerSumry", "${msg.C100000878}", "7%", true, false); 			//최종결재자
	col.addColumnCustom("sanctnDte", "${msg.C100000877}", "6%", true, false); 				//최종결재일
	col.addColumnCustom("rtnResn", "${msg.C100000345}", "*", true, false); 					//반려사유
	col.addColumnCustom("bplcCode", "${msg.C100000432}", "*", false, false); 				/*사업장 */
	col.addColumnCustom("sanctnSeqno", "${msg.C100000166}", "*", false, false); 			/*결재순서 */
	col.addColumnCustom("prductUpperSeqno", "제품일련번호", "*", false, false); 					/*제품일련번호 */
	col.addColumnCustom("sanctnProgrsSittnCode", "${msg.C100000846}", "*", false, false); 	/*진행상황 */
	col.addColumnCustom("sanctnSeCode", "ZCM02 결재 구분 코드", "*", false, false);
	col.addColumnCustom("changerId", "${msg.C100000385}", "*", false, false); 				/*변경자ID */
	col.addColumnCustom("updtResn", "${msg.C100000378}", "*", false, false); 				/*변경사유 */
	col.addColumnCustom("atchmnflSeqno", "${msg.C100000863}", "*", false, false); 			/*첨부파일번호 */
	col.addColumnCustom("sanctnProgrsAt", "결재진행여부", "*", false, false); 					/*결재진행여부 */
	col.addColumnCustom("entrpsSeqno", "업체일련번호", "*", false, false); 						/*업체일련번호 */
	col.addColumnCustom("prductSeqno", "${msg.C100000723}", "*", false, false); 			/*자재일련번호 */
	col.addColumnCustom("lastVerAt", "${msg.C100000879}", "*", false, false); 				//최종버전여부
	col.buttonRenderer(["updVer"],

			function reformEvent(rowIndex, columnIndex, value, item, dataField ){
				var gridData = AUIGrid.getSelectedItems(entrpsSpecList);
				if (gridData.length > 0){
					alert("${msg.C100000287}"); /* 데이터 수정 후 저장버튼을 눌러야 개정이 완료됩니다. */
					$("#drClear").val("Y");
				} else {
					return;
				}
				specGridDoubleClick(gridData[0], function(){
					$("#crud").val("R");
					$("#sanctnProgrsAt").val("N");
                    $("#sanctnSeqno").val(null);
					$("#ver").val(parseInt($("#ver").val())+1);
					$("#btn_save").show();
					$("#btn_save2").show();
					
				});
				},false,"${msg.C100000118}",null,
				 function (rowIndex, columnIndex, value, item, dataField){
					console.log(item);
					if(item.sanctnProgrsSittnCode == 'CM01000001'||item.sanctnProgrsSittnCode == 'CM01000002'
						||item.sanctnProgrsSittnCode == 'CM01000003'||item.sanctnProgrsSittnCode == 'CM01000004'
						||item.sanctnProgrsSittnCode == '' || item.sanctnProgrsSittnCode == null) {
						return true;
			        } else {
						return false;
			       	}
				});
	
	

// 	var verAt = [
// 		{key : "${msg.C100000610}", value : "Y"}, /* 예 */
// 		{key : "${msg.C100000578}", value : "N"}, /* 아니오 */
// 	];

// 	col.dropDownListRenderer(["lastVerAt"], verAt, true, null);
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			wordWrap : true,
			rowStyleFunction : function(rowIndex, item) {
 				if((item.sanctnProgrsSittnCode == "CM01000004")||
 						(item.sanctnProgrsSittnCode == "CM01000001" && item.rtnResn != null &&item.rtnResn != undefined))
 					return "c-orange";
 				return "";
			}
 	}


	//auiGrid 생성
	entrpsSpecList = createAUIGrid(col, "entrpsSpecList", cusPros);
	// 그리드 리사이즈.
	gridResize([entrpsSpecList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(entrpsSpecList, "ready", function(event) {
// 		gridColResize([entrpsSpecList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//시험항목 정보 그리드 생성
function setRequestGrid(){
	var col = [];

	auigridCol(col);

	//필수
	var gridColRequire = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
		}
	};
	
	var cusPros = {
		editable : true, // 편집 가능 여부 (기본값 : false)
		selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
		showRowCheckColumn : true,
		showRowAllCheckBox : true,
		showEditedCellMarker : true,
		showStateColumn : true
 	};

	//LSL/USL 셀 전용
	var numericPros = {
		type : "InputEditRenderer",
		onlyNumeric : true, // 0~9 까지만 허용
		allowPoint : true, // 소수점 허용 여부 (onlyNumeric : true 선행)
		allowNegative : true // 음수값 허용 여부 (onlyNumeric : true 선행)
   	};

   	// 특정 조건에 따라 미리 정의한 editRenderer 반환.
   	var conditionPros = {
		editable : true,
		selectionMode : "multipleCells",
		enableCellMerge : true,
		editRenderer : {
			type : "ConditionRenderer", 
			conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {
				// LSL/USL 셀에만 numericPros 적용
				if(dataField == 'extrlMummValue' || dataField == 'extrlMxmmValue') {
					return numericPros;
				}else {
					return cusPros;
				}
			}
		}
   	};

	col.addColumnCustom("mtrilCode", "${msg.C100000725}", "*", false, false); //자재 코드
	col.addColumnCustom("mtrilNm", "${msg.C100000717}", "*", true, false); //자재 명
    col.addColumnCustom("prductSdspcSeqno", "제품 기준규격 일련번호", "*", false, false); //제품 기준규격 일련번호
	col.addColumnCustom("expriemSeqno", "시험항목 일련번호", "*", false, false); /* 시험항목 일련번호 */
	col.addColumnCustom("expriemNm", "${msg.C100000560}", "*", true, false); //시험항목 명
	col.addColumnCustom("jdgmntFomNm", "${msg.C100000921}", "*", true, false); //판정형식
	col.addColumnCustom("resultRangef", "${msg.C100000258}", "*", true, false); //내부기준

	
	col.addColumnCustom ("extrlMummValue", "${msg.C100000062}", null, true, true,conditionPros); /*LSL*/
	col.addColumnCustom ("extrlMummValueSeCode", "${msg.C100000063}", null, true, null); /*LSL단위*/
	
 
	col.addColumnCustom ("extrlMxmmValue", "${msg.C100000097}", null, true, true,conditionPros);	/*USL*/
	col.addColumnCustom ("extrlMxmmValueSeCode", "${msg.C100000098}", null, true, true); /*USL단위*/
	
	col.addColumnCustom("spsTextStdr", "${msg.C100000909}", "*", false, false); //텍스트기준
	col.addColumnCustom("spsMarkCphr", "제품 표기 자리수", "*", false, false); //제품 표기 자리수

	col.addColumnCustom("ctmspcMarkCphr", "${msg.C100000940}", "*", true, false); //표기 자리수

	col.addColumnCustom("updtResn", "${msg.C100000378}", "*", true, true); //변경사유
	col.addColumnCustom ("ctmspcUnitSeqno", "${msg.C100000268}", "*", false, false); //단위


	//LSL, USL, 고객사 단위
	var lsl, usl, unit ;
	var lslArray = ["extrlMummValueSeCode"];
	var uslArray = ["extrlMxmmValueSeCode"];
	
	//LCL 단위 콤보박스를 만들기위해 공통코드 조회
	comboAjaxJsonParam('/com/getCmmnCode.lims', {"upperCmmnCode" : "IM08"}, function(data){
		lsl= data;
	}, null, false);
	
	//UCL 단위 콤보박스를 만들기위해 공통코드 조회
	comboAjaxJsonParam('/com/getCmmnCode.lims', {"upperCmmnCode" : "IM07"}, function(data){
		usl= data;
	}, null, false);
	
	//UCL 고객사 단위 콤보박스를 만들기위해 UNIT 조회
	comboAjaxJsonParam('/wrk/getMasterUnitList.lims', {}, function(data){
		unit = data;
	}, null, false);
	
	col.dropDownListRenderer(lslArray, lsl, true, null);
	col.dropDownListRenderer(uslArray, usl, true, null);
	col.dropDownListRenderer(["ctmspcUnitSeqno"], unit, true, null);
	
	//auiGrid 생성
	requestList = createAUIGrid(col, "requestList", cusPros);
	AUIGrid.setFixedColumnCount(requestList, 4);
	// 그리드 리사이즈.
	gridResize([requestList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(requestList, "ready", function(event) {
		gridColResize([requestList],"1");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//자재 그리드
function setMaterialGrid(){
 	var col = [];

	auigridCol(col);

	
	col.addColumnCustom("mtrilCode", "${msg.C100000725}", "*", false, false); /* 자재코드 */
	col.addColumnCustom("mtrilNm", "${msg.C100000717}", "*", true, false); /* 자재명 */
	
	col.addColumnCustom("prductSeqno", "${msg.C000000841}", "*", false, false); /* 제품 고객사 자재 일련번호 */
	col.addColumnCustom("ctmmnyMtrilAt", "${msg.C000000842}", "*", false, false); /* 제품 고객사 자재 일련번호 확인 */
	col.addColumnCustom("deleteAt", "${msg.C100000465}", "*", false, false); /* 삭제여부 */
	col.addColumnCustom("ver", "${msg.C100000365}", "*", false, false); /* 버전 */
	col.addColumnCustom("bplcCode", "${msg.C100000432}", "*", false, false); /* 사업장 */
	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		showEditedCellMarker : true,
			showStateColumn : true
 	}


	//auiGrid 생성
	materialList = createAUIGrid(col, "materialList", cusPros);
	// 그리드 리사이즈.
	gridResize([materialList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(materialList, "ready", function(event) {
		gridColResize([materialList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}



function setEntrpsSpecHistGrid(){
	
	var col = [];

	auigridCol(col);

	col.addColumnCustom("entrpsNm", "${msg.C100000587}", "*", true, false); 				//업체명
	col.addColumnCustom("stdrNm", "${msg.C100000241}", "*", true, false); 					//기준명
	col.addColumnCustom("ver", "${msg.C100000365}", "4%", true, false); 					//버전
	col.addColumnCustom("beginDte", "${msg.C100000541}", "*", true, false); 				/*시작일자 */
	col.addColumnCustom("endDte", "${msg.C100000830}", "*", true, false); 					/*종료일자 */
	col.addColumnCustom("changeDte", "${msg.C100000292}", "*", true, false); 				//등록일자()
	col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100000846}", "*", true, false); 	//진행상황
	col.addColumnCustom("changerNm", "${msg.C100000385}", "*", true, false); 				//변경자
	col.addColumnCustom("confmerSumry", "${msg.C100000878}", "*", true, false); 			//최종결재자
	col.addColumnCustom("sanctnDte", "${msg.C100000877}", "*", true, false); 				//최종결재일
	col.addColumnCustom("bplcCode", "${msg.C100000432}", "*", false, false); 				/*사업장 */
	col.addColumnCustom("sanctnSeqno", "${msg.C100000166}", "*", false, false); 			/*결재순서 */
	col.addColumnCustom("prductUpperSeqno", "제품일련번호", "*", false, false); 					/*제품일련번호 */
	col.addColumnCustom("sanctnProgrsSittnCode", "${msg.C100000846}", "*", false, false); 	/*진행상황 */
	col.addColumnCustom("sanctnSeCode", "ZCM02 결재 구분 코드", "*", false, false);
	col.addColumnCustom("changerId", "${msg.C100000385}", "*", false, false); 				/*변경자ID */
	col.addColumnCustom("updtResn", "${msg.C100000378}", "*", false, false); 				/*변경사유 */
	col.addColumnCustom("atchmnflSeqno", "${msg.C100000863}", "*", false, false); 			/*첨부파일번호 */
	col.addColumnCustom("sanctnProgrsAt", "결재진행여부", "*", false, false); 					/*결재진행여부 */
	col.addColumnCustom("entrpsSeqno", "업체일련번호", "*", false, false); 						/*업체일련번호 */
	col.addColumnCustom("prductSeqno", "${msg.C100000723}", "*", false, false); 			/*자재일련번호 */

	// auiGrid 생성
	entrpsSpecHistList = createAUIGrid(col, "entrpsSpecHistList");
	
	// 그리드 리사이즈.
	gridResize([entrpsSpecHistList]);
};
//그리드 이벤트
function setentrpsSpecGridEvent(){
	AUIGrid.bind(entrpsSpecList, "cellDoubleClick", function(event) {
		specGridDoubleClick(event);
		entrpsSpecHistSearch(event);
	});

	//제품 이력 cellDoubleClick
	AUIGrid.bind(entrpsSpecHistList, "cellDoubleClick", function(event){
		var prductCtmmnyParams = {
			prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
			ver : event["item"]["ver"]
		};

		getGridDataParam("<c:url value='/wrk/getPrductCtmmnySdspcList.lims'/>", prductCtmmnyParams, requestList);
		/******************시험항목 정보 그리드 조회 종료********************/
			$("#btn_save").hide();
			$("#btn_save2").hide();	
			$("#btn_delete").hide();
			$("#btn_col").hide(); 
		/******************자재 정보 그리드 조회 시작********************/
		//specGridDoubleClick(event);
	});
}

//제품목록 그리드 더블클릭
function specGridDoubleClick(event, callback){
	detailAutoSet({"item" :event["item"], targetFormArr : ["entrpsSpecForm"], "successFunc": function(){
		$("#crud").val("U");
		//버전 저장
		$("#ver").val(event["item"]["ver"]);
		//제품 고객사 일련번호 저장
		$("#prductCtmmnySeqno").val(event["item"]["prductCtmmnySeqno"]);
		//수정모드일때 제품 정보 수정 불가
		$("#btnPrductUpperSeqno").hide();
		//제품 번호
		$("#prductUpperSeqno").val(event["item"]["prductUpperSeqno"]);

		/******************시험항목 정보 그리드 조회 시작********************/
		var prductCtmmnyParams = {
				prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
				ver : event["item"]["ver"]
		};
		getGridDataParam("<c:url value='/wrk/getPrductCtmmnySdspcList.lims'/>", prductCtmmnyParams, requestList);
		/******************시험항목 정보 그리드 조회 종료********************/



		/******************자재 정보 그리드 조회 시작********************/
		var mtrilListParams = {
				prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
				ver : event["item"]["ver"]
		};

		getGridDataParam("<c:url value='/wrk/getPrductCtmmnyMtrilList.lims'/>", mtrilListParams, materialList);
		//고객사 자재정보가 있으면 자재정보 그리드에 체크
		/******************자재 정보 그리드 조회 종료********************/



		/******************결재 순서 정보 그리드 조회 시작********************/
		var sanctnParams = {
				prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
				ver : event["item"]["ver"],
				sanctnLineSeqno : $("#sanctnLineSeqno").val(null)
		};
		var paramStr = '';
		var paramStrId = '';
		
		//var sanctnGrid = AUIGrid.getGridData(sanctnInfoGrid);
		//총 결재자 수
		//$("#totSanctnerCo").val(sanctnGrid.length);


		/******************결재 순서 정보 그리드 조회 종료********************/

		// 개정일 경우 드랍존 초기화
		if($("#drClear").val() == "Y"){
			$("#atchmnflSeqno").val("");
			dropZoneArea.clear();
			dropZoneArea.setFileIdx("");
		}
		else if (event.pid=="#entrpsSpecHistList"){
			
			dropZoneArea.getFiles(event["item"]["atchmnflSeqno"],undefined,'N');
			dropZoneArea.readOnly(true);
		}

		 // 셀 더블 클릭한 경우 첨부파일 가져오기
		else {
			dropZoneArea.getFiles(event["item"]["atchmnflSeqno"]);
		}
	
		if(event["item"].sanctnProgrsSittnCode == "CM01000002"){
			$("#btn_save").hide();
			$("#btn_save2").hide();	
			$("#btn_delete").hide(); 
			$("#btn_col").show();
		} else if(event["item"].sanctnProgrsSittnCode == "CM01000005"){ 
			$("#btn_save").hide();
			$("#btn_save2").hide();	
			$("#btn_delete").hide();
			$("#btn_col").hide();
		}else {
			$("#btn_save").show();
			$("#btn_save2").show();
			$("#btn_delete").show();
			$("#btn_col").hide();
		}
		
		AUIGrid.bind(requestList, "ready", function(event) {
			gridColResize(requestList, "2");	// 1, 2가 있으니 화면에 맞게 적용
		});

		//시험항목 그리드 컬럼사이즈 조정
		gridColResize([requestList], "2");	// 1, 2가 있으니 화면에 맞게 적용
		if(callback){
			callback();
		}
	  }
	});
}

//버튼 이벤트
function setButtonEvent(){

	$("#btn_getPrductList").click(function(){
		searchMhrls();
	});


	//행 삭제
	$("#btn_remove_row").click(function(){
		var gridData = AUIGrid.getCheckedRowItems(requestList);
		var array = [];

		for(var i=0; i<gridData.length; i++){
			array[i] = gridData[i]["rowIndex"];
		}
		AUIGrid.removeRow(requestList, array);

	});

	//저장 버튼 클릭
	$("#btn_save").click(function(){

		



			var msg = "";
			var mtrilData = AUIGrid.getGridData(materialList);
			var reqData =  AUIGrid.getGridData(requestList);
			if(mtrilData.length <1){
				alert("${msg.C100001041}"); /*자재정보를 추가해주세요.*/
				return false;
			}
			
			if(reqData.length <1){
				alert("${msg.C100001038}"); /*시험항목을 추가해주세요.*/
				return false;
			}

			if($("#crud").val() == "R"){
				msg = "${msg.C100001039}"; //개정 하시겠습니까?
			}
			else{
				msg = "${msg.C100000764}"; //저장 하시겠습니까?
			}

			if(confirm(msg)){
				dropZoneArea.upload(true);
				var dropZone = dropZoneArea.getNewFiles();
				var dropZone_cnt = dropZone.length;

				if (dropZone_cnt > 0){
					$("#btnSave_file").click();
					if($("#crud").val() == "R"){
						dropZoneArea.setRevision(true);
					}
					else{
						dropZoneArea.setRevision(false);
					}

					dropZoneArea.on("uploadComplete", function(event, fileIdx){
						$("#atchmnflSeqno").val(fileIdx);
						dataSave();
					});
				}else{
					dataSave();
				}
			}

	});


	//신규버튼 이벤트
	$("#btn_new").click(function(){
		var grids = [requestList, materialList, entrpsSpecHistList];
		$("#btn_save").show();
		$("#btn_save2").show();
		$("#btn_delete").hide();
		$("#btn_col").hide();
		pageReset(["entrpsSpecForm"], grids, [dropZoneArea], function(){
			$("#btnPrductUpperSeqno").show();
			$("#crud").val("C");
			$("#lastVerAt").val("Y");
			$("#sanctnProgrsAt").val("N");
		});
		searchMhrls();

	});
	
	//삭제 버튼
	$("#btn_delete").click(function(){
		var gridData = AUIGrid.getSelectedItems(entrpsSpecList);

		if(gridData.length == 0){
			alert("${msg.C100001040}"); /* 선택된 제품 목록이 없습니다. */
			return;
		}
		if(confirm("${msg.C000000178}")){ /* 삭제하시겠습니까? */
			$("#crud").val("D");
			dataSave();
		}

	});

	//상신
	$("#btn_save2").on("click", function(){
		

		
		if(!$("#sanctnProgrsSittnCode").val()){
			// 입력폼에 입력후 바로 상신을 누를 경우 
			if(!required()){
				return false;
			} else {
				var mtrilData = AUIGrid.getGridData(materialList);
				var reqData =  AUIGrid.getGridData(requestList);

				if(mtrilData.length <1){
					alert("${msg.C100001041}"); /*자재 정보를 선택해주세요.*/
					return false;
				}
				if(reqData.length <1){
					alert("${msg.C100001042}"); /*시험항목을 선택해주세요.*/
					return false;
				}
				
				var dropZone = dropZoneArea.getNewFiles();
				var dropZone_cnt = dropZone.length;
				if (dropZone_cnt > 0){
					$("#btnSave_file").click();
					dropZoneArea.on("uploadComplete", function(event, fileIdx){
						$("#atchmnflSeqno").val(fileIdx);
						dataSave('insApp');
					});
				}else{ 
					dataSave('insApp');
				}
				
				
				
			}
		} else {
			if(!required()){
				return false;
			} else {
			var mtrilData = AUIGrid.getGridData(materialList);
			var reqData =  AUIGrid.getGridData(requestList);
			
			if(mtrilData.length <1){
				alert("${msg.C100001041}"); /*자재 정보를 선택해주세요.*/
				return false;
			}
			if(reqData.length <1){
				alert("${msg.C100001042}");C100001042 /*시험항목을 선택해주세요.*/
				return false;
			}
			var dropZone = dropZoneArea.getNewFiles();
			var dropZone_cnt = dropZone.length;
			if (dropZone_cnt > 0){
				$("#btnSave_file").click();
				dropZoneArea.on("uploadComplete", function(event, fileIdx){
					$("#atchmnflSeqno").val(fileIdx);
					
					dataSave('approval');
				});
			}else{ 
				
				dataSave('approval');
			}
			}
		
		}
		
	});

	
/*	$("#sanctnLineSeqno").change(function(){
		var url = '/wrk/getSanctnerList.lims';
		var param = {sanctnLineSeqno:$("#sanctnLineSeqno").val()};
		var paramStr = '';
		var paramStrId = '';
		getGridDataParam(url,param,sanctnInfoGrid).then(function(data){
			for(var i=0; i<data.length; i++){
				if(i==data.length-1)  paramStr +=  data[i].userNm;
				else paramStr += data[i].userNm+" > ";
			}
			$("#sanctnerNm").val(paramStr);
			$("#totSanctnerCo").val(data.length); //인포테이블에 각각저장해서 상관없음
		})
	})*/
	$("#sanctnLineSeqno").change(function (e) {
		customAjax({
			url: '/wrk/getSanctnerList.lims',
			data: {sanctnLineSeqno: e.target.value},
		}).then(function (res) {
			if (res.length > 0) {
				var sanctnerNm = getSanctnerNm(res);
				entrpsSpecFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(res);
				entrpsSpecFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
			} else {
				warn('결재 정보 선택 또는 결재 라인을 설정해주세요.');
			}
		});
	})
	//회수버튼
	$("#btn_col").click(function(){
		var gridData = AUIGrid.getSelectedItems(entrpsSpecList);
		var url = "<c:url value='/com/colSanctnM.lims'/>";
		var param = { 
				"sanctnSeqno" : gridData[0].item.sanctnSeqno
		}

		if(gridData.length == 0){
			alert("${msg.C100000490}"); /* 선택된 데이터가 없습니다.*/
			return;
		}
		else{
			customAjax({"url":url,"data":param,"successFunc":function(data) {
		       	if (data > 0) {
		       		success("${msg.C100001048}"); /*해당 제품에 대해서 회수처리되었습니다.*/
	        		searchMhrls();
					$("#btn_save").show();
					$("#btn_save2").show();
					$("#btn_delete").hide();
					$("#btn_col").hide();
	        		var grids = [requestList, materialList];
	    			pageReset(["entrpsSpecForm"], grids, [dropZoneArea], function(){

					}); 
		       	}
		       	else{
		       		err('${msg.C100000597}'); /* 오류가 발생했습니다. */
		       	}
			}
		})
	   }
	})

	//검색 이벤트
	$("[id^=shr]").keyup(function(e){
		searchMhrls(e.keyCode);
	});

	//자사구분 변경
	$("[name='shrMmnySeCode']").change(function(){
		//자사 구분에 따라서 콤보박스 변경
		mmnySeCodeChange();
	});

	//자재정보 삭제버튼 클릭 이벤트
	$("#btnPrductDel").click(function(){
		var gridData = AUIGrid.getCheckedRowItems(materialList);
		var array = [];
		var delArray = [];
		
		for(var i=0; i<gridData.length; i++){
			array[i] = gridData[i]["rowIndex"];
		}

		AUIGrid.removeRow(materialList, array);

		

		
		
		var gridMtrilData = AUIGrid.getGridData(materialList);
		var exprGridData = AUIGrid.getGridData(requestList);
		var gridMtrilDataArray = [];
	
		for(var i=0; i<gridMtrilData.length; i++){
			gridMtrilDataArray[i] = gridMtrilData[i]["mtrilSeqno"];
		}

		var params = {};
		
		if(gridMtrilData.length == 0){
			AUIGrid.clearGridData(requestList);
		} else {
			params = {
		 			 shrPrductSdspcArray : gridMtrilDataArray
		 			 ,gridDataExpriemArray : []
				}
			getGridDataParam("<c:url value='/wrk/getPrductExpriemList.lims'/>", params, requestList).then(function(data){
				AUIGrid.bind(requestList, "ready", function(event) {
					gridColResize(requestList, "2");	// 1, 2가 있으니 화면에 맞게 적용
				});
			});
		}


	});
	
	// 업체 팝업 input reset 버튼
	$("#btnEntrpsReset").click(function(){
		dialogReset(this.id);
	})
	
	
	// 업체 팝업 input reset 버튼
	 $("#resetSanctnLineChg").click(function(){
	 	dialogReset(this.id);
	 })
	
}

//저장
function dataSave(approval){
	$("#insApp").val(approval);
	//상신
	if(approval == 'approval'){
		//시험항목 그리드 변경 감지
		var requestRemove = AUIGrid.getRemovedItems(requestList);
		var requestEdite = AUIGrid.getEditedRowItems(requestList);
		var requestAdd = AUIGrid.getAddedRowItems(requestList);
		var requestListData = AUIGrid.getGridData(requestList);
		//자재정보 그리드 변경 감지
		var materialRemove = AUIGrid.getRemovedItems(materialList);
		var materialEdite = AUIGrid.getEditedRowItems(materialList);
		var materialAdd = AUIGrid.getAddedRowItems(materialList);

		var sanctnInfoList = entrpsSpecFormEl.querySelector('input[name=sanctnInfoList]').value;
		sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];
		var sanctnerList = new Array();
		var saveUrl = "<c:url value='/wrk/insConfirmM.lims'/>";
		var params = getFormParam("entrpsSpecForm");
		params.requestGridData = AUIGrid.getGridData(requestList);
		params.materialGridData = AUIGrid.getGridData(materialList);
		params.requestRemove = requestRemove;
		params.requestEdite = requestEdite;
		params.requestAdd = requestAdd;
		params.requestListData = requestListData;
		params.sanctnKndCode = 'CM05000006'; // 결재종류 문서
		params.sanctnInfoList = sanctnInfoList;
		//시험 항목
		if(requestRemove.length == 0 && requestEdite.length == 0 && requestAdd.length == 0){
			params.requestCnt = "N";
		}
		else{
			params.requestCnt = "Y";
		}
		//자재 정보 , 지금 안씀
		if(materialRemove.length == 0 && materialEdite.length == 0 && materialAdd.length == 0){
			params.materialCnt = "N";
		}
		else{
			params.materialCnt = "Y";
		}

		customAjax({"url":saveUrl,"data":params,"successFunc":function(data) {
        	if (data > 0) {
        		success("${msg.C100000762}"); /* 저장 되었습니다. */
        		searchMhrls();
        		var grids = [requestList, materialList];
    			pageReset(["entrpsSpecForm"], grids, [dropZoneArea], function(){

				}); 
        	}
        	else{
        		err('${msg.C100000597}'); /* 오류가 발생했습니다. */
        	}
		}
		});
	} else {
	//시험항목 그리드 변경 감지
	var requestRemove = AUIGrid.getRemovedItems(requestList);
	var requestEdite = AUIGrid.getEditedRowItems(requestList);
	var requestAdd = AUIGrid.getAddedRowItems(requestList);
	var requestListData = AUIGrid.getGridData(requestList);
	//자재정보 그리드 변경 감지
	var materialRemove = AUIGrid.getRemovedItems(materialList);
	var materialEdite = AUIGrid.getEditedRowItems(materialList);
	var materialAdd = AUIGrid.getAddedRowItems(materialList);

	var sanctnInfoList = entrpsSpecFormEl.querySelector('input[name=sanctnInfoList]').value;
	sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];
	var params = getFormParam("entrpsSpecForm");
	params.requestGridData = AUIGrid.getGridData(requestList);
	params.materialGridData = AUIGrid.getGridData(materialList);
	params.requestRemove = requestRemove;
	params.requestEdite = requestEdite;
	params.requestAdd = requestAdd;
	params.requestListData = requestListData;
	params.sanctnKndCode = 'CM05000006'; // 결재종류 문서
	params.sanctnInfoList = sanctnInfoList;
	//Y 수정 있음, N 수정 없음
	//시험 항목
	if(requestRemove.length == 0 && requestEdite.length == 0 && requestAdd.length == 0){
		params.requestCnt = "N";
	}
	else{
		params.requestCnt = "Y";
	}
	//자재 정보 , 지금 안씀
	if(materialRemove.length == 0 && materialEdite.length == 0 && materialAdd.length == 0){
		params.materialCnt = "N";
	}
	else{
		params.materialCnt = "Y";
	}
	
	params.sanctnInfoCnt = "Y";

	customAjax({"url":"<c:url value='/wrk/saveEntrpsSpecM.lims'/>","data":params,"successFunc":function(data){
		if(data > 0){
			var msg = "";

			if($("#crud").val() == "R"){
				msg = "${msg.C100001049}"; //개정 하였습니다.
			} else if($("#crud").val() == "D"){
				msg = "${msg.C100000462}"// 삭제되었습니다.
			}
			else{
				if(approval == "insApp"){
					msg = "${msg.C100001050}" //저장 후 상신 하였습니다.		
				} else {
					msg = "${msg.C100000765}"; //저장 되었습니다.
				}
			}
			success(msg);

			searchMhrls();

			var grids = [requestList, materialList];
			pageReset(["entrpsSpecForm"], grids, [dropZoneArea], function(){
				$("#btnPrductUpperSeqno").show();
				$("#crud").val("C");
				$("#lastVerAt").val("Y");
				$("#sanctnProgrsAt").val("N");
				}); 
			   }
			}
		});
	}
}	
//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchMhrls();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/wrk/getPrductListManage.lims'/>", "searchFrm", entrpsSpecList);
		}
	}
}

//제품 이력 조회
function entrpsSpecHistSearch(event){
	var params = {
		lastVerAt : 'N',
		prductCtmmnySeqno : event.item.prductCtmmnySeqno 
	};
	
	getGridDataParam("<c:url value='/wrk/getPrductListManage.lims'/>", params, entrpsSpecHistList);
}

//자사구분에 따라서 부서 콤보박스 조회
function mmnySeCodeChange(){
	var mmnySeCode = $("[name='shrMmnySeCode']:checked").val()
	var bestParams = {};

	if(mmnySeCode == "SY01000001"){ //자사일때
		bestParams = {"mmnySeCode" : mmnySeCode, "bestInspctInsttCode" : "${UserMVo.bestInspctInsttCode}", "analsAt" : "Y"};
	}
	else if(mmnySeCode == "SY01000002"){ //협력사 일때
		bestParams = {"mmnySeCode" : mmnySeCode};
	}

}

function required(){
	var returnVal = true;
	var required = document.querySelectorAll("[required]");
	for(var i=0; i<required.length; i++){
		if(!required[i].value){
			warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
			returnVal = false;
			return false;
		}
	}
	return returnVal;
}
</script>

</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000810}</h2> <!-- 제품 목록 -->
		<div class="btnWrap">
<%-- 			<button type="button" id="btn_revision" class="save">${msg.C100000118}</button><!-- 개정 --> --%>
			<button type="button" id="btn_getPrductList" class="search">${msg.C100000767}</button><!-- 조회 -->
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
					<th>제품 구분</th> <!-- 자재유형 -->
					<td>
						<select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
							<option value="">${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
								<th>${msg.C100000587}</th> <!-- 업체명 -->
					<td>
						<input type="text" id="shrEntrpsNm" name="shrEntrpsNm">
					</td>
					
					<th>${msg.C100000717}</th> <!-- 자재명 --> 
					<td>
						<label><input type="text" class="schClass" id="shrMtrilNm" name="shrMtrilNm"></label> 
					</td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align: left;">
						<label><input type="radio" id="shrUseAt_A" name="shrUseAt" value="" >${msg.C100000779}</label><!-- 전체 -->
						<label><input type="radio" id="shrUseAt_Y" name="shrUseAt" value="Y" checked >${msg.C100000439}</label><!-- 사용 -->
						<label><input type="radio" id="shrUseAt_N" name="shrUseAt" value="N" >${msg.C100000449}</label><!-- 사용안함 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 		에이유아이 그리드가 이곳에 생성됩니다. -->
	<div id="entrpsSpecList" class="mgT15" style="width: 100%; height: 300px; margin: 0 auto;"></div>
	<div class="mapkey">
				<label class="scarce">${msg.C100000343}</label><!-- 반려 -->
		</div>
	
	<form id="entrpsSpecForm">
		<input type="text" id="lastVerAt" name="lastVerAt" value="Y" style="display:none">
		<input type="hidden" id="sanctnKndCode" name="sanctnKndCode">
		<input type="hidden" id="totSanctnerCo" name="totSanctnerCo">
		<input type="hidden" id="sanctnProgrsAt" name="sanctnProgrsAt" value="N">
		<input type="hidden" id="crud" name="crud" value="C">
		<input type="hidden" id="ver" name="ver">
		<input type="hidden" id="prductCtmmnySeqno" name="prductCtmmnySeqno" value="">
		<input type="hidden" id="prductSeqno" name="prductSeqno" value="">
		<input type="hidden" id="sanctnProgrsSittnCode" name="sanctnProgrsSittnCode" value=""> 
		<input type="hidden" id="insApp" name="insApp" value="">
		<input type="text" id = "sanctnSj" name = "sanctnSj" style="display:none">
		<input type="text" id = "sanctnCn" name = "sanctnCn" style="display:none">
		<input type="text" id="drClear" name="drClear" value="N" style="display:none">

		<div class="subCon1 mgT15">
			<h2><i class="fi-rr-apps"></i>${msg.C100000724}</h2><!-- 제품 정보 -->
			<div class="btnWrap">
				<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button><!-- 신규 -->
				<button type="button" id="btn_delete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
				<button type="button" id="btn_col"  class="save" style="display:none">${msg.C100000963}</button> <!-- 회수 -->
				<button type="button" id="btn_save"  class="save">${msg.C100000688}</button> <!-- 임시 저장 -->
				<button type="button" id="btn_save2" class="save">${msg.C100000158}</button> <!-- 결재 상신 -->
				
			</div>
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
					<th class="necessary">${msg.C100000591}</th><!-- 업체정보 -->
					<td style="text-align:left;">
						<input type="text" id="entrpsNm" name="entrpsNm" class="wd63p" readonly required>
						<input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
						<button type="button" id="btnEntrpsSeqno" class="search inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button><!-- 찾기 -->
						<button type="button" id="btnEntrpsReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
					</td>

					<th class="necessary">${msg.C100000241}</th> <!-- 기준명 -->
					<td>
						<input type="text" id="stdrNm" name="stdrNm" required>
					</td>
					<th class="necessary">${msg.C100000541}</th> <!-- 시작일자 -->
					<td>
						<input type="text" id="beginDte" name="beginDte"  class="wd100p dateChk" required>
					</td>
				
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align: left;">	
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
				<tr>
					<th style="padding-right: 11px;">${msg.C100000159}</th> <!-- 결재 정보 -->
					<td colspan="3" style="text-align: left;">
						<select id="sanctnLineSeqno" name="sanctnLineSeqno" style="width: 27%;"></select>
						<input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 49%;" readonly required>
						<input type="hidden" id="sanctnSeqno" name="sanctnSeqno" style="width: 50%;" readonly>
						<button type="button" id= "sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn">${msg.C100000165}</button> <!-- 결재라인변경 -->
						<button type="button" id="resetSanctnLineChg" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
						<input type="text" name="sanctnInfoList" style="display: none;">
					</td>
				</tr>
				
				<tr>
					<th class="necessary">${msg.C100000378}</th><!-- 변경사유 -->
					<td colspan="3">
						<textarea id="updtResn" name="updtResn" rows="3" class="wd100p" onkeyup="fnChkByte(this, '4000')" style="min-width:10em; height: 120px; margin-top: 5px;" required></textarea>
					</td>

					<th>${msg.C100000860}</th><!-- 첨부파일 -->
					<td colspan="3">
					<!-- 파일첨부영역 -->
						<div id="dropZoneArea"></div>
						<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;">
						<input type="hidden" id="btnSave_file">
					</td>
				</tr>
			</table>
		</div>
	</form>
		<!-- 자재정보 & 시험항목  정보 -->
		<div class="subCon2 wd25p mgT20 fL" style="display:inline-block;">
			<div class="subCon1 ">
				<h3>${msg.C100000724}</h3><!-- 자재정보 -->
				<div class="btnWrap">
					<button id="btnPrductSeqno" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 추가 -->
					<button id="btnPrductDel" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 삭제 -->
				</div>
			</div>
			<div id="materialList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>	

		<div class="subCon1 wd2p fL" style="display:inline-block; height:240px;">

		</div>
		
		<div class="subCon2 wd73p mgT20" style="display:inline-block;">
			<div class="subCon1 ">
				<h3>${msg.C100000565}</h3><!-- 시험항목 정보 -->
				<div class="btnWrap">
					<button id="btnExpriemSearch" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 추가 -->
					<button id="btn_remove_row" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 삭제 -->
					<input type="hidden" name="mtrilSeqno" id="mtrilSeqno">
				</div>
			</div>
			<div id="requestList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
			<div class="subCon1 mgT15" >
				<h3>${msg.C100001083}</h3> <!-- 제품 이력 -->
			</div>
			<div id="entrpsSpecHistList" class="mgT15" style="width:100%; height:150px; margin:0 auto;"></div> <!--고객사 규격 이력 그리드  -->
		
</div>	

</tiles:putAttribute>
</tiles:insertDefinition>
