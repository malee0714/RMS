<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">SPEC</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
var entrpsSpecList = "entrpsSpecList"; //제품목록 그리드
var requestList = "requestList"; //시험항목 정보 그리드
var materialList = "materialList"; //자재 그리드
var sanctnInfoList = "sanctnInfoList"; //결재 그리드
var dropZoneArea;
var lang = ${msg}; // 기본언어
$(function(){

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

	//결재 그리드
	setSanctnInfoGrid();

	//그리드 이벤트
	setentrpsSpecGridEvent();

	//버튼 이벤트 선언
	setButtonEvent();

	// 그리드 리사이즈
	gridResize(["entrpsSpecList", "requestList", "materialList", "sanctnInfoList"]);
	$('input[name=beginDte]').datepicker('disable').removeAttr('disabled');
});

function init(){
	//드랍존
	dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", {'readOnly': true, 'deleteButtonYn': 'N', lang : "${msg.C000000118}"} );

	//시작일
	datePickerCalendar(["beginDte"], false, ["DD",0], ["DD",0]);
	
	/**
	 * 반려 dialog의 사용법이 바뀌었음 수정필요
	 */
	dialogRtnSanctn("btn_rtn_hidden", null,"rtnDialog","#entrpsSpecList", function(data){
		var param = data;
		var selectedItems = AUIGrid.getCheckedRowItemsAll(entrpsSpecList);
		var rtnList = [];
		for(var i=0; i<selectedItems.length;i++){
			rtnList.push(selectedItems[i]);
		}
		param.rtnList = rtnList;
		customAjax({
			"url" :	"<c:url value='/qa/insRtnSanctn.lims'/>",
			"data" : param,
			"successFunc" : function(data){
				if(data>0){
					success("${msg.C100000344}");/* 반려되었습니다. */
					searchMhrls();
				}
				else{
					err("${msg.C100000597}");
				}
			}
		})
	});

}

function setCombo(){
	ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims','sanctnLineSeqno',{"deptCode" : "${UserMVo.deptCode}"}, false,"${msg.C100000480}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims',"mtrilTyCodeSch", {"upperCmmnCode" : "SY02", "deptCode" : "${UserMVo.deptCode}"}, true);
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
	
	col.addColumnCustom("entrpsSeqno", "업체일련번호", "*", false, false); /* 업체일련번호 */
	col.addColumnCustom("bplcCode", "${msg.C100000432}", "*", false, false); /* 사업장 */
	col.addColumnCustom("entrpsNm", "${msg.C100000587}", "*", true, false); //업체명
	col.addColumnCustom("sanctnSeqno", "${msg.C100000166}", "*", false, false); /* 결재순서 */
	col.addColumnCustom("prductUpperSeqno", "제품일련번호", "*", false, false); /* 제품일련번호 */
	col.addColumnCustom("stdrNm", "${msg.C100000241}", "*", true, false); //기준명
	col.addColumnCustom("ver", "${msg.C100000365}", "*", true, false); //버전
	col.addColumnCustom("lastVerAt", "${msg.C100000879}", "*", false, false); //최종버전여부
	col.addColumnCustom("beginDte", "${msg.C100000541}", "*", true, false); /* 시작일 */
	col.addColumnCustom("endDte", "${msg.C100000830}", "*", true, false); /* 종료일 */
	col.addColumnCustom("changeDte", "${msg.C100000292}", "*", true, false); //등록일자()
	col.addColumnCustom("sanctnProgrsSittnCode", "${msg.C100000846}", "*", false, false); /* 진행상황 */
	col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100000846}", "*", true, false); //진행상황
	col.addColumnCustom("sanctnSeCode", "ZCM02 결재 구분 코드", "*", false, false);
	col.addColumnCustom("changerId", "${msg.C100000385}", "*", false, false); /* 변경자ID */
	col.addColumnCustom("changerNm", "${msg.C100000385}", "*", true, false); //변경자
	col.addColumnCustom("confmerSumry", "${msg.C100000878}", "*", true, false); //최종결재자
	col.addColumnCustom("sanctnDte", "${msg.C100000877}", "*", false, false); //최종결재일
	col.addColumnCustom("updtResn", "${msg.C100000378}", "*", false, false); /* 변경사유 */
	col.addColumnCustom("atchmnflSeqno", "첨부파일번호", "*", false, false); /* 첨부파일번호 */
	col.addColumnCustom("sanctnProgrsAt", "결재진행여부", "*", false, false); /* 결재진행여부 */
	col.addColumnCustom("prductSeqno", "자재일련번호", "*", false, false); /* 자재일련번호 */


	var verAt = [
		{key : "${msg.C100000610}", value : "Y"}, /* 예 */
		{key : "${msg.C100000578}", value : "N"}, /* 아니오 */
	];

	col.dropDownListRenderer(["lastVerAt"], verAt, true, null);

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			showRowCheckColumn : true,
			showRowAllCheckBox : true,
			wordWrap : true
	};
	
	//auiGrid 생성
	entrpsSpecList = createAUIGrid(col, "entrpsSpecList",cusPros);
	// 그리드 리사이즈.
	gridResize([entrpsSpecList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(entrpsSpecList, "ready", function(event) {
		gridColResize([entrpsSpecList],"2");	// 1, 2가 있으니 화면에 맞게 적용
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
		//styleFunction : cellStyleFunction
	};
	
	var cusPros = {
		editable : true, // 편집 가능 여부 (기본값 : false)
		selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
		showRowCheckColumn : true,
		showRowAllCheckBox : true,
		showEditedCellMarker : true,
		showStateColumn : true
 	};
	
	col.addColumnCustom("mtrilCode", "${msg.C100000725}", "*", true, false); //자재 코드
	col.addColumnCustom("mtrilNm", "${msg.C100000717}", "*", true, false); //자재 명
    col.addColumnCustom("prductSdspcSeqno", "제품 기준규격 일련번호", "*", false, false); //제품 기준규격 일련번호
	col.addColumnCustom("expriemSeqno", "시험항목 일련번호 ", "*", false, false); /* 시험항목 일련번호 */
	col.addColumnCustom("expriemNm", "${msg.C100000560}", "*", true, false); //시험항목 명
	col.addColumnCustom("jdgmntFomNm", "${msg.C100000921}", "*", true, false); //판정형식
	col.addColumnCustom("resultRangef", "${msg.C100000258}", "*", true, false); //내부기준
	
	col.addColumnCustom ("extrlMummValue", "${msg.C100000062}", null, true, false); //LSL
	col.addColumnCustom ("extrlMummValueSeCode", "${msg.C100000063}", null, true, null); //LSL 단위

	
	col.addColumnCustom ("extrlMxmmValue", "${msg.C100000097}", null, true, false);	//USL
	col.addColumnCustom ("extrlMxmmValueSeCode", "${msg.C100000098}", null, true, null); //USL단위
	
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

	col.addColumnCustom("prductSeqno", "제품 고객사 자재 일련번호", "*", false, false); /* 제품 고객사 자재 일련번호 */
	col.addColumnCustom("ctmmnyMtrilAt", "제품 고객사 자재 일련번호 확인", "*", false, false); /* 제품 고객사 자재 일련번호 확인 */
	col.addColumnCustom("mtrilCode", "${msg.C100000725}", "*", true, false); /* 자재코드 */
	col.addColumnCustom("mtrilNm", "${msg.C100000717}", "*", true, false); /* 자재명 */
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

//결재 그리드 생성
function setSanctnInfoGrid(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("sanctnLineSeqno", "결재라인 일련번호", "*", true, false); /* 결재라인 일련번호 */
	col.addColumnCustom("sanctnOrdr", "결재순서", "*", true, false); /* 결재순서 */
	col.addColumnCustom("sanctnSeCode", "결재구분", "*", true, false); /* 결재구분 */
	col.addColumnCustom("sanctnerId", "결재자", "*", false, false); /* 결재자 */
	col.addColumnCustom("userNm", "결재자", "*", true, false); /* 결재자 */

	var setSanctnSeCode = [{key:"검토",value:"CM02000001"},{key:"협의",value:"CM02000002"},{key:"승인",value:"CM02000003"}];

	// customAjax('/com/getCmmnCode.lims', {"upperCmmnCode" : "CM02"},{succssFunc :function(data){
	// 	setSanctnSeCode = data;
	// }}, null, false);

	col.dropDownListRenderer(["sanctnSeCode"], setSanctnSeCode, true);

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 	}


	//auiGrid 생성
	sanctnInfoList = createAUIGrid(col, "sanctnInfoList", cusPros);
	// 그리드 리사이즈.
	gridResize([sanctnInfoList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(sanctnInfoList, "ready", function(event) {
		gridColResize([sanctnInfoList], "2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//그리드 이벤트
function setentrpsSpecGridEvent(){
	AUIGrid.bind(entrpsSpecList, "cellDoubleClick", function(event) {
		$("#lastVerAt").val("Y");
		specGridDoubleClick(event);
	});

	//LSL/USL단위 드랍다운 선택 방지
	AUIGrid.bind(requestList, "cellEditBegin", function(event) {
		if(event.dataField == 'extrlMummValueSeCode' || event.dataField == 'extrlMxmmValueSeCode') {
			return false;
		}
	});
}

//제품목록 그리드 더블클릭
function specGridDoubleClick(event, callback){

	detailAutoSet({"item" :event["item"], targetFormArr : ["entrpsSpecForm"], "successFunc": function(){
		//수정모드로 변경
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
		//AUIGrid.addCheckedRowsByValue(materialList, "deleteAt", "N");
		/******************자재 정보 그리드 조회 종료********************/



		/******************결재 순서 정보 그리드 조회 시작********************/
		var sanctnParams = {
				prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
				ver : event["item"]["ver"],
				sanctnLineSeqno : $("#sanctnLineSeqno").val()
		};
// 		getGridDataParam("<c:url value='/wrk/getCmSanctnList.lims'/>", sanctnParams, sanctnInfoList);

		var paramStr = '';
		var paramStrId = '';
		getGridDataParam("<c:url value='/wrk/getCmSanctnList.lims'/>", sanctnParams, sanctnInfoList).then(function(data){
			for(var i=0; i<data.length; i++){
				if(i==data.length-1)  paramStr +=  data[i].userNm;
				else paramStr += data[i].userNm+" > ";
			}
			$("#sanctnerNm").val(paramStr);
			$("#totSanctnerCo").val(data.length); //인포테이블에 각각저장해서 상관없음
		})
		
		var sanctnGrid = AUIGrid.getGridData(sanctnInfoList);
		//총 결재자 수
		$("#totSanctnerCo").val(sanctnGrid.length);


		/******************결재 순서 정보 그리드 조회 종료********************/



		/******************제품이력 그리드 조회 시작********************/
		var histParams = {
				prductCtmmnySeqno : event["item"]["prductCtmmnySeqno"],
				ver : event["item"]["ver"]
		};
		/******************제품이력 그리드 조회 종료********************/

		//첨부파일
		dropZoneArea.getFiles(event["item"]["atchmnflSeqno"],null,'N');
		
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

	//승인 버튼 클릭
	$("#btn_sanctn").click(function(){
		var gridDataChk = AUIGrid.getCheckedRowItemsAll(entrpsSpecList)
		
	    var gridData = new Array();
	    for(var i in gridDataChk){
	    	gridData[i] = gridDataChk[i]
	    }
	    if(gridData.length == 0){
			alert("${msg.C100001040}"); /* 선택된 제품 목록이 없습니다. */
			return false;
		}
		

		if(confirm("${msg.C100000536}")){ /* 승인 하시겠습니까? */
			var ajax = customAjax({
				"url" : '/wrk/insApprovalSanctn.lims',
				"data" : gridData,
				"successFunc" : function(data){
					if(data > 0){
						success("${msg.C100000534}"); /* 승인 되었습니다. */
						searchMhrls();
						var grids = [requestList, materialList, sanctnInfoList];
						pageReset(["entrpsSpecForm"], grids, [dropZoneArea], function(){
						}); 
					}
				}
			});
		}	
	});


	//선택 버튼 클릭
	$("#btn_selected").click(function(){
		var gridData = AUIGrid.getSelectedItems(entrpsSpecList);
		specGridDoubleClick(gridData[0]);
	});

	//검색 이벤트
	$("[id^=shr]").keyup(function(e){
		searchMhrls(e.keyCode);
	});
	
	$("#btn_rtn").click(function(){
		var gridDataChk = AUIGrid.getCheckedRowItemsAll(entrpsSpecList)
	    var gridData = new Array();
	    for(var i in gridDataChk){
	    	gridData[i] = gridDataChk[i]
	    }
		if(gridData.length == 0){
			alert("${msg.C100001058}"); /*반려할 제품을 선택해 주세요. */
			return;
		}
		else{
			$("#btn_rtn_hidden").click();
		}
	})
}

//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchMhrls();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/wrk/getPrductList.lims'/>", "searchFrm", entrpsSpecList, function() {
				getSanctnCnt();
			});
		}
	}
}

</script>

</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000810}</h2> <!-- 제품 목록 -->
		<div class="btnWrap">
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
					<th>${msg.C100000722}</th> <!-- 자재유형 -->
					<td>
						<select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
							<option value="">${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>

					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align: left;">
						<label><input type="radio" id="shrUseAt_A" name="shrUseAt" value="" >${msg.C100000779}</label><!-- 전체 -->
						<label><input type="radio" id="shrUseAt_Y" name="shrUseAt" value="Y" checked >${msg.C100000439}</label><!-- 사용 -->
						<label><input type="radio" id="shrUseAt_N" name="shrUseAt" value="N" >${msg.C100000449}</label><!-- 사용안함 -->
					</td>
				</tr>
				<tr>
					<th>${msg.C100000587}</th> <!-- 업체명 -->
					<td>
						<input type="text" id="shrEntrpsNm" name="shrEntrpsNm">
					</td>

					<th>${msg.C100000725}</th> <!-- 자재코드 -->
					<td>
						<input type="text" id="shrMtrilCode" name="shrMtrilCode">
					</td>

					<th>${msg.C100000717}</th> <!-- 자재명 -->
					<td>
						<label><input type="text" class="schClass" id="shrMtrilNm" name="shrMtrilNm"></label>
					</td>
					<td colspan="2"></td><!-- 나머지 여백맞추기위한 추가 explorer -->

				</tr>
			</table>
		</form>
	</div>
	
	<div class="subCon2">
<!-- 		에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="entrpsSpecList" class="mgT15" style="width: 100%; height: 300px; margin: 0 auto;"></div>
	</div>
	
	<form id="entrpsSpecForm">
		<input type="hidden" id="lastVerAt" name="lastVerAt" value="Y">
		<input type="hidden" id="sanctnKndCode" name="sanctnKndCode">
		<input type="hidden" id="totSanctnerCo" name="totSanctnerCo">
		<input type="hidden" id="sanctnProgrsAt" name="sanctnProgrsAt" value="N">
		<input type="hidden" id="crud" name="crud" value="C">
		<input type="hidden" id="ver" name="ver">
		<input type="hidden" id="prductCtmmnySeqno" name="prductCtmmnySeqno" value="">
		<input type="hidden" id="sanctnSeqno" name="sanctnSeqno" value="">
		<input type="hidden" id="prductSeqno" name="prductSeqno" value=""> 
		<input type="hidden" id="sanctnProgrsSittnCode" name="sanctnProgrsSittnCode" value=""> 
		<input type="hidden" id="rtnResn" name="rtnResn" value=""> 
		<input type="hidden" id="ordr" name="ordr" value=""> 

		<div class="subCon1 mgT15">
			<h2><i class="fi-rr-apps"></i>${msg.C100000724}</h2><!-- 제품 정보 -->
			<div class="btnWrap">
				<button type="button" id="btn_rtn"  class="save">${msg.C100000343}</button> <!-- 반려 -->
				<input type="hidden" id="btn_rtn_hidden"  class="save"><!-- 반려 -->
				<button type="button" id="btn_sanctn" class="save">${msg.C100000533}</button> <!-- 승인 -->
			</div>
			<table style="width:100%;" class="subTable1" >
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
					
					<th>${msg.C100000591}</th><!-- 업체정보 -->
					<td style="text-align:left;">
						<input type="text" id="entrpsNm" name="entrpsNm" disabled>
						<input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
<%-- 						<button type="button" id="btnEntrpsSeqno" class="search inTableBtn inputBtn">${msg.C000000164}</button><!-- 찾기 --> --%>
					</td>

					<th>${msg.C100000241}</th> <!-- 기준명 -->
					<td><input type="text" id="stdrNm" name="stdrNm" readonly></td>
					<th>${msg.C100000541}</th> <!-- 시작일 -->
					<td><input type="text" id="beginDte" name="beginDte" readonly></td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align: left;">	
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
				<tr>
					<th>${msg.C100000159}</th> <!-- 결재 정보 --> 
					<td colspan="3" style="text-align: left;">
						<select id="sanctnLineSeqno" name="sanctnLineSeqno" style="width: 30%; display: none;"></select>
						<input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 100%;" readonly>
						<input type="hidden" id="sanctnerId" name="sanctnerId" style="width: 50%;" readonly>
					</td>
				</tr>
				
				<tr>
					<th>${msg.C100000378}</th><!-- 변경사유 -->
					<td colspan="3">
						<textarea id="updtResn" name="updtResn" rows="3" class="wd100p" onkeyup="fnChkByte(this, '4000')" style="min-width:10em; height: 120px; margin-top: 5px;" readonly></textarea>
					</td>
					
					<th>${msg.C100000860}</th><!-- 첨부파일 -->
					<td colspan="3">
					<!-- 파일첨부영역 -->
						<div id="dropZoneArea"></div>
						<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;">
					</td>
				</tr>
			</table>
		</div>
				<input type="hidden" id="bplcCode" name="bplcCode">
	</form>
		<!-- 자재정보 & 시험항목  정보 -->
		<div class="subCon2 wd25p mgT20 fL" style="display:inline-block;">
			<div class="subCon1 ">
				<h3>${msg.C100000724}</h3><!-- 자재정보 -->
			</div>
			<div id="materialList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>	

		<div class="subCon1 wd2p fL" style="display:inline-block; height:240px;">

		</div>
		
		<div class="subCon2 wd73p mgT20" style="display:inline-block;">
			<div class="subCon1 ">
				<h3>${msg.C100000565}</h3><!-- 시험항목 정보 -->
			</div>
			<div id="requestList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>	

		<div id="sanctnInfoList" class="mgT35" style="width:100%; height:215px; margin:0 auto; display: none;"></div>
		
</div>	

</tiles:putAttribute>
</tiles:insertDefinition>