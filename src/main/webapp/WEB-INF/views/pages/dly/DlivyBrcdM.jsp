<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">바코드 생성</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">
var lang = ${msg}; // 기본언어
var brcdList; //바코드 리스트 그리드
var brcdListDetail; //바코드 리스트의 바코드 조회
var printList; //엑셀 출력할 그리드
var printList3; //엑셀 물류양식 출력 그리드
var printList4; //엑셀 품질양식 출력 그리드
$(function(){
	getAuth();
	
	init();
	
	//콤보박스
	setCombo();
	
	//바코드 리스트 그리드 생성
	setBrcdListGrid();
	
	//바코드 리스트의 바코드 조회 그리드 생성
	setBrcdListDetailGrid();
	
	//출력 바코드 정보 그리드
	setPrintListGrid();
	
	//출력(물류양식) 정보 그리드
	setPrintList3Grid();
	
	//출력(품질양식) 정보 그리드
	setPrintList4Grid();
	
	//버튼 이벤트
	setButtonEvent();
	
	//그리드 이벤트
	setGridEvent();
});

//초기 세팅
function init(){
	//생성일
	datePickerCalendar(["shrDlivyDteBeginDte", "shrDlivyDteEndDte"], true, ["DD",-1], ["DD",0]);
	//검증일
	datePickerCalendar(["validateDteBeginDte", "validateDteEndDte"], false, ["DD",0], ["DD",0]);
	
	changePointDialog("btn_changePoint", {ntcnSeCode : "SY18000001"}, "changePoint", function(data){}, null);
}

//콤보박스 세팅
function setCombo(){
	var bestParams = {"analsAt" : "Y", "deptAt" : "Y", "mmnySeCode" : "SY01000001"};
	//부서
	ajaxJsonComboBox('/com/getDeptCombo.lims','inspctInsttCode', bestParams, false, "${msg.C000000079}");
	//제조
	ajaxJsonComboBox('/com/getDeptCombo.lims','shrDeptCode', bestParams, false, "${msg.C000000079}");
	//검증결과	
	ajaxJsonComboBox('/com/getCmmnCode.lims','shrDlivyBrcdSttusCode',{"upperCmmnCode" : "IM16"}, true);
}


//바코드 리스트 그리드 생성
function setBrcdListGrid(){
	var col = [];	
	var filterOp = {
			filter : true		
		};
	auigridCol(col);	
	
	col.addColumnCustom("dlivyBrcdSeqno", "${msg.C000001180}", "*" ,false); /* 출고 바코드 일련번호 */
	col.addColumnCustom("reqestDeptNm", "${msg.C000000080}", "*" ,true); /* 부서 */
	col.addColumnCustom("dvyfgEntrpsNm", "${msg.C000000293}", "*" ,true,true,filterOp); /* 고객사 */
	col.addColumnCustom("lotId", "${msg.C000000575}", "*", true); /* LOT ID */
	col.addColumnCustom("poNo", "PO", "*", true); /* PO */
	col.addColumnCustom("dlivyDte", "${msg.C000000730}", "*", true,true,filterOp); /* 출하일 */
	col.addColumnCustom("mtrilNm", "${msg.C000000319}", "*", true); /* 제품 */
	col.addColumnCustom("dlivyBrcdSttusNm", "${msg.C000001181}", "*", true); /* 검증 결과 */
	col.addColumnCustom("dlivyQy", "${msg.C000001182}", "*", true, true); /* 수량 */
	col.addColumnCustom("topRepr", "${msg.C000001183}", "*", true, true); /* 용기 개수 */	
	col.addColumnCustom("lastChangeDt", "${msg.C000000747}", "*", true); /* 생성일 */
	col.addColumnCustom("lastChangerNm", "${msg.C000001184}", "*", true); /* 생성자 */
	col.addColumnCustom("vrifyAt", "${msg.C000001185}", "*", true); /* 중복 검증 여부 */
	col.addColumnCustom("reqestSeqno", "${msg.C000000724}", "*", false); /* 의뢰일련번호 */
	//20-04-22 추가
	col.addColumnCustom("frstCrtrId", "${msg.C000001362}", "*", true); /* 최초 생성자 */
	col.addColumnCustom("frstCreatDt", "${msg.C000001363}", "*", true); /* 최초 생성일시 */
	col.addColumnCustom("relcoDlivyDocNm", "${msg.C000001364}", "*", false); /* 관계사 출고문서 */
	col.addColumnCustom("relcoDlivyQy", "${msg.C000001365}", "*", false); /* 관계사 출하량 */
	col.addColumnCustom("unprogrsRequstDc", "${msg.C000001366}", "*", false); /* 미진행 요청 */
	col.addColumnCustom("shipmntLcCode", "출하처", "*", true); /* 출하처 */
	col.addColumnCustom("invoice", "${msg.C000001367}", "*", false); /* INVOICE NO */
	col.addColumnCustom("invoiceNo", "${msg.C000001367}", "*", true); /* full INVOICE NO */
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 	
 			showRowCheckColumn : false,
 	 		showRowAllCheckBox : false,
 	 		enableFilter : true
 	}	
	
	
	//auiGrid 생성
	brcdList = createAUIGrid(col, "brcdList", cusPros);
}

//바코드 리스트의 바코드 조회 그리드 생성
function setBrcdListDetailGrid(){
	var col = [];	
	
	auigridCol(col);
	
	
	col.addColumnCustom("dlivyBrcdSeqno", "${msg.C000001180}", "*" ,false); /* 출고 바코드 일련번호 */
	col.addColumnCustom("ordr", "${msg.C000000440}", "*" ,false); /* 순서 */
	col.addColumnCustom("repr", "${msg.C000001186}", "*" ,true); //개수
	col.addColumnCustom("brcd", "${msg.C000000627}", "*" ,true); /* 바코드 */
	col.addColumnCustom("dlivyBrcdSttusCode", "${msg.C000001187}", "*" ,false); /* 출고 바코드 상태 */
	col.addColumnCustom("dlivyBrcdSttusNm", "${msg.C000001187}", "*" ,true); /* 출고 바코드 상태 */
	col.addColumnCustom("deleteAt", "${msg.C000000843}", "*" ,false); /* 삭제여부 */
	col.addColumnCustom("vrifyDt", "${msg.C000001355}", "*" ,true); /*검증일시*/
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 	
 			showRowCheckColumn : false,
 	 		showRowAllCheckBox : false
 	}	
	
	
	//auiGrid 생성
	brcdListDetail = createAUIGrid(col, "brcdListDetail", cusPros);
}

//출력용 그리드 생성
function setPrintListGrid(){
	var col = [];	
	

	auigridCol(col);	
	
	col.addColumnCustom("reqestDeptNm", "${msg.C000000080}", "*" ,true); /* 부서 */
 	col.addColumnCustom("dvyfgEntrpsNm", "${msg.C000000293}", "*" ,true); /* 고객사 */
	col.addColumnCustom("dlivyBrcdSeqno", "${msg.C000001180}", "*" ,true); /* 출고 바코드 일련번호 */
	col.addColumnCustom("lotId", "${msg.C000000575}", "*", true); /* LOT ID */
	col.addColumnCustom("dlivyBrcdSttusNm", "${msg.C000001181}", "*", true); /* 검증결과 */
	col.addColumnCustom("dlivyQy", "${msg.C000001182}", "*", true, true); /* 수량 */
	col.addColumnCustom("topRepr", "${msg.C000001183}", "*", true, true); /* 용기개수 */
	col.addColumnCustom("lastChangeDt", "${msg.C000000747}", "*", true); /* 생성일 */
	col.addColumnCustom("ordr", "${msg.C000000440}", "*" ,true); /* 순서 */
	col.addColumnCustom("repr", "${msg.C000001186}", "*" ,true); /* 개수 */
	col.addColumnCustom("brcd1", "${msg.C000001188}", "*" ,true); /* 바코드1 */
	col.addColumnCustom("brcd2", "${msg.C000001189}", "*" ,true); /* 바코드2 */
	col.addColumnCustom("brcd3", "${msg.C000001190}", "*" ,true); /* 바코드3 */
	col.addColumnCustom("brcd4", "${msg.C000001191}", "*" ,true); /* 바코드4 */
	col.addColumnCustom("brcd5", "${msg.C000001192}", "*" ,true); /* 바코드5 */
	col.addColumnCustom("vrifyDt", "${msg.C000001355}", "*" ,true); /* 검증일시 */

	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 	
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		useGroupingPanel : true,
//  	 		groupingFields : ["reqestDeptNm", "dvyfgEntrpsNm", "dlivyBrcdSeqno", "lotId", "dlivyBrcdSttusNm", "dlivyQy", "topRepr"],
 	 		enableCellMerge : false
 	}	
	
	
	//auiGrid 생성
	printList = createAUIGrid(col, "printList", cusPros);
}

//출력용(물류양식) 그리드 생성
function setPrintList3Grid(){
	var col3 = [];	
	

	auigridCol(col3);	
	
	col3.addColumnCustom("shipmntLcCode", "Plant", "*" ,true); 
	col3.addColumnCustom("ctmmnyMtrilCode", "MaterialNumber", "*", true); 
	col3.addColumnCustom("subMaterialType", "SubMaterialtype", "*", true); 
	col3.addColumnCustom("batchNo", "LotNumber", "*", true); 
	col3.addColumnCustom("brcd1", "CylinderNumber", "*", true); 
	
// 	col3.addColumnCustom("brcd1", "${msg.C000001188}", "*" ,true); /* 바코드1 */
// 	col3.addColumnCustom("brcd2", "${msg.C000001189}", "*" ,true); /* 바코드2 */
// 	col3.addColumnCustom("brcd3", "${msg.C000001190}", "*" ,true); /* 바코드3 */
// 	col3.addColumnCustom("brcd4", "${msg.C000001191}", "*" ,true); /* 바코드4 */
// 	col3.addColumnCustom("brcd5", "${msg.C000001192}", "*" ,true); /* 바코드5 */
	
	col3.addColumnCustom("valuationType", "ValuationType", "*", true); 
	col3.addColumnCustom("storageLocation", "storageLocation", "*" ,true); 
	col3.addColumnCustom("", "SpecialStockIndicator", "*" ,true); 
	col3.addColumnCustom("", "StockType", "*" ,true); 
	
	col3.addColumnCustom("lotQuantity", "LotQuantity", "*" ,true); 
	col3.addColumnCustom("", "BlNo", "*" ,true); 
	
	col3.addColumnCustom("invoiceNo", "Invoice No", "*" ,true); 
	col3.addColumnCustom("vender", "Vender", "*" ,true); 
	col3.addColumnCustom("", "ExprireDate", "*" ,true); 
	col3.addColumnCustom("", "CreateDate", "*" ,true); 
	col3.addColumnCustom("poNo", "PoNo", "*" ,true); 
	col3.addColumnCustom("", "PoItems", "*" ,true); 

	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 	
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		useGroupingPanel : true,
//  	 		groupingFields : ["reqestDeptNm", "dvyfgEntrpsNm", "dlivyBrcdSeqno", "lotId", "dlivyBrcdSttusNm", "dlivyQy", "topRepr"],
 	 		enableCellMerge : false,
 	 		showRowNumColumn : false
 	}	
	
	
	//auiGrid 생성
	printList3 = createAUIGrid(col3, "printList3", cusPros);
}

//출력용(품질관리) 그리드 생성
function setPrintList4Grid(){
	var col4 = [];	
	

	auigridCol(col4);
// 	col4.addColumnCustom("reqestSeqno", "${msg.C000000724}", "*", false);
col4.addColumnCustom("0", "", "*", false)
.addChildColumn("0","gbm", "GBM", "*" ,true); 
// 	col4.addColumnCustom("gbm", "GBM", "*" ,true); 
col4.addColumnCustom("1", "", "*", false)
	.addChildColumn("1","buyer", "Buyer", "*" ,true); 
col4.addColumnCustom("2", "", "*", false)
.addChildColumn("2","shipmntLcCode", "Plant", "*" ,true); 
col4.addColumnCustom("3", "", "*", false)
	.addChildColumn("3","plantName", "Plant Name", "*" ,true); 
col4.addColumnCustom("4", "", "*", false)	
	.addChildColumn("4","vender", "Vender Code", "*" ,true); 
col4.addColumnCustom("5", "", "*", false)		
	.addChildColumn("5","sellerName", "Seller Name", "*" ,true); 
col4.addColumnCustom("6", "", "*", false)	
	.addChildColumn("6","invoiceNo", "Invoice", "*" ,true); 
col4.addColumnCustom("7", "", "*", false)		
	.addChildColumn("7","poNo", "PO No.", "*" ,true); 
col4.addColumnCustom("8", "", "*", false)		
	.addChildColumn("8","poSeq", "Po Seq", "*" ,true); 
col4.addColumnCustom("9", "", "*", false)	
	.addChildColumn("9","batchNo", "Lot", "*" ,true);
col4.addColumnCustom("10", "", "*", false)	
	.addChildColumn("10","ctmmnyMtrilCode", "Material Code", "*", true); 
	

col4.addColumnCustom("11", "", "*", false)	
	.addChildColumn("11","brcd1", "Barcode", "*" ,true); /* 바코드1 */
// 	col4.addColumnCustom("brcd2", "${msg.C000001189}", "*" ,false); /* 바코드2 */
// 	col4.addColumnCustom("brcd3", "${msg.C000001190}", "*" ,false); /* 바코드3 */
// 	col4.addColumnCustom("brcd4", "${msg.C000001191}", "*" ,false); /* 바코드4 */
// 	col4.addColumnCustom("brcd5", "${msg.C000001192}", "*" ,false); /* 바코드5 */
	
col4.addColumnCustom("12", "", "*", false)	
	.addChildColumn("12","fillingMg", "Filling Size", "*", true); 
col4.addColumnCustom("13", "", "*", false)	
	.addChildColumn("13","fillingMgUnitSeqno", "Unit", "*", true); 
col4.addColumnCustom("14", "", "*", false)	
	.addChildColumn("14","bottleWt", "Bottle Size", "*", true); 
col4.addColumnCustom("15", "", "*", false)	
	.addChildColumn("15","bottleWtUnitSeqno", "Unit", "*", true); 
col4.addColumnCustom("16", "", "*", false)	
	.addChildColumn("16","vrifyDt", "GR date", "*", true); 
col4.addColumnCustom("17", "", "*", false)	
	.addChildColumn("17","customsClearance", "Customs Clearance", "*", true);
	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 	
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		useGroupingPanel : true,
//  	 		groupingFields : ["reqestDeptNm", "dvyfgEntrpsNm", "dlivyBrcdSeqno", "lotId", "dlivyBrcdSttusNm", "dlivyQy", "topRepr"],
 	 		enableCellMerge : false,
 	 		showRowNumColumn : false
 	}	
	
	
	//auiGrid 생성
	printList4 = createAUIGrid(col4, "printList4", cusPros);
}

//그리드 이벤트
function setGridEvent(){
	AUIGrid.bind(brcdList, "cellDoubleClick", function(event) {
		$("#dlivyBrcdSeqno").val(event["item"]["dlivyBrcdSeqno"]);
		getGridDataParam("/dly/getBarcodeDetailList.lims", {dlivyBrcdSeqno : event["item"]["dlivyBrcdSeqno"]}, brcdListDetail)
	});
	
	// 그리드 리사이즈.
	gridResize([brcdList, brcdListDetail, printList]);
	
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(brcdList, "ready", function(event) {
		gridColResize([brcdList ],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
	
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(brcdListDetail, "ready", function(event) {
		gridColResize([brcdListDetail],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
	
	
	
}

//버튼 이벤트
function setButtonEvent(){
// 	$("#test1").click(function(){
// // 		exportTo();
// 	});
	//조회버튼 클릭 이벤트
	$("#btn_select").click(function(){
		searchBarcodeList();
	});
	
	$("[id^=shr]").keyup(function(e){
		searchBarcodeList(e.keyCode);
	});
		
	//엑셀 출력
	$("#btn_excelPrint").click(function(){
		//그리드에 보이는 데이터 값만 가져오기
		var gridData = AUIGrid.getGridData(brcdList)
		// 출고바코드 일련번호 담을 변수
		var excelArr = '';
		
		if(gridData.length > 0){	
			showLoadingbar();
		} else {
			//값이 없으면 
			return alert("${msg.C000001356}"); /* 출력할 데이터가 없습니다. */
		}		

		for(var i=0; i<gridData.length; i++){
			if(i == gridData.length-1) {
					//값이 없으면 0
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"'";
				} else {
					//값이 있으면 값 넣어줌
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"'";
				}
				
			} else {
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"',";
				} else {
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"',";
				}
			}
			
		}
		var validateDteBeginDte = document.getElementById("validateDteBeginDte").value;
		var validateDteEndDte = document.getElementById("validateDteEndDte").value;

		bacodeParam = {
				//실제 출고바코드 일련번호 값을 담아서 보냄
				dlivyBrcdSeqno : excelArr
				,validateDteBeginDte : validateDteBeginDte
				,validateDteEndDte : validateDteEndDte
		}
		getGridDataParam11("<c:url value='/dly/getBarcodePrintList.lims'/>", bacodeParam, printList, function(data){
 			excelExport(printList, "");
 			hideLoadingbar();
 		});
		
		
	});
	//엑셀 출력(물류)
	$("#logistics_excelPrint").click(function(){
		//그리드에 보이는 데이터 값만 가져오기
		var gridData = AUIGrid.getGridData(brcdList)
		var excelArr = '';
		
		if(gridData.length > 0){	
			showLoadingbar();
		} else {
			//값이 없으면 
			return alert("${msg.C000001356}"); /* 출력할 데이터가 없습니다. */
		}		

		for(var i=0; i<gridData.length; i++){
			if(i == gridData.length-1) {
					//값이 없으면 0
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"'";
				} else {
					//값이 있으면 값 넣어줌
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"'";
				}
				
			} else {
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"',";
				} else {
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"',";
				}
			}
			
		}
		var validateDteBeginDte = document.getElementById("validateDteBeginDte").value;
		var validateDteEndDte = document.getElementById("validateDteEndDte").value;

		bacodeParam = {
				//실제 출고바코드 일련번호 값을 담아서 보냄
				dlivyBrcdSeqno : excelArr
				,validateDteBeginDte : validateDteBeginDte
				,validateDteEndDte : validateDteEndDte
		}
		getGridDataParam11("<c:url value='/dly/getBarcodePrintList3.lims'/>", bacodeParam, printList3, function(data){
 			excelExport(printList3, "");
 			hideLoadingbar();
 		});
		
		
	});
	
	//엑셀 출력(품질)
	$("#quality_excelPrint").click(function(){
		//그리드에 보이는 데이터 값만 가져오기
		var gridData = AUIGrid.getGridData(brcdList)

		var excelArr = '';
		var excelReq = '';
		
		if(gridData.length > 0){	
			showLoadingbar();
		} else {
			//값이 없으면 
			return alert("${msg.C000001356}"); /* 출력할 데이터가 없습니다. */
		}		

		for(var i=0; i<gridData.length; i++){
			if(i == gridData.length-1) {
					//값이 없으면 0
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"'";	
				} else {
					//값이 있으면 값 넣어줌
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"'";
				}
				
			} else {
				if(!gridData[i].dlivyBrcdSeqno){
					excelArr += "'"+0+"',";
				} else {
					excelArr += "'"+gridData[i].dlivyBrcdSeqno+"',";
				}
			}
			
			
			if(i == gridData.length-1) {
				//값이 없으면 0
				if(!gridData[i].reqestSeqno){
					excelReq += "'"+0+"'";
				} else {
					//값이 있으면 값 넣어줌
					excelReq += "'"+gridData[i].reqestSeqno+"'";
				}
			
			} else {
				if(!gridData[i].reqestSeqno){
					excelReq += "'"+0+"',";
				} else {
					excelReq += "'"+gridData[i].reqestSeqno+"',";
				}
		}	
		
			
		}
		var validateDteBeginDte = document.getElementById("validateDteBeginDte").value;
		var validateDteEndDte = document.getElementById("validateDteEndDte").value;

		bacodeParam = {
				//실제 출고바코드 일련번호 값을 담아서 보냄
				dlivyBrcdSeqno : excelArr
				,reqestSeqno : excelReq
				,validateDteBeginDte : validateDteBeginDte
				,validateDteEndDte : validateDteEndDte
		}
		getGridDataParam11("<c:url value='/dly/getBarcodePrintList4.lims'/>", bacodeParam, printList4, function(data){
 			excelExport(printList4, "");
 			hideLoadingbar();
 		});
		
		
	});
	
	//출고지시서 업로드
	$("#btn_form_upload").click(function(){
		
		if(!formNecessaryValidationCheck("dlivyForm")){
			return;
		}
		else{
			
			var file = $("#formFile")[0];
			
			//파일 없으면 리턴
			if(!file.files[0].name){
				return;
			}
			
			ajaxJsonParam("<c:url value='/test/getLockAt.lims'/>", {}, function(data){
// 				alert(data["msg"]);
			});
			
			if(!confirm("${msg.C000000714}")){ //업로드 하시겠습니까?
				return;
			}
			showLoadingbar();
			var fileName = file.files[0].name;
			var fileExt = fileName.substring(fileName.length, fileName.length-4);
			
			
			
			if(fileExt.toUpperCase() != "XLSX"){
				alert("${msg.C000000696}"); /* xlsx 확장자만 업로드 할 수 있습니다. */ 
				return;
			}
			
			var formData = new FormData();
			formData.append("formFile", $("#formFile")[0].files[0]);
			formData.append("formType", $("#formType").val());
			formData.append("inspctInsttCode", $("#inspctInsttCode").val());

			ajaxJsonFormFile("/dly/applyFormFile.lims", formData, function(data){
				//AUIGrid.addRow(mhrlsUnInspctList, data, 0);
				if(data["result"] == true){
					alert(data["msg"]); /* 저장 되었습니다. */
					searchBarcodeList();
					AUIGrid.clearGridData(brcdListDetail);
					$("#formFile").val("");
				}
				else{
					alert(data["msg"]);  /* 저장에 실패하였습니다. */
				}
				
				hideLoadingbar();
				
			}, null, null);
			
			
		}
	});
	
	//배차지시서 업로드
	$("#btn_form_upload2").click(function(){

			
			var file = $("#formFile2")[0];
			
			//파일 없으면 리턴
			if(!file.files[0].name){
				return;
			}
			
			ajaxJsonParam("<c:url value='/test/getLockAt.lims'/>", {}, function(data){

			});
			
			if(!confirm("${msg.C000001368}")){ //INVOICE 생성을 하시 겠습니까??
				return;
			}
			showLoadingbar();
			var fileName = file.files[0].name;
			var fileExt = fileName.substring(fileName.length, fileName.length-4);
			
			
			
			if(fileExt.toUpperCase() != "XLSX"){
				alert("${msg.C000000696}"); /* xlsx 확장자만 업로드 할 수 있습니다. */ 
				return;
			}
			
			var formData = new FormData();
			formData.append("formFile2", $("#formFile2")[0].files[0]);
			formData.append("formType2", $("#formType2").val());
			
			ajaxJsonFormFile("/dly/applyFormFile2.lims", formData, function(data){
				//AUIGrid.addRow(mhrlsUnInspctList, data, 0);
				if(data["result"] == true){
					alert(data["msg"]); /* 저장 되었습니다. */
					searchBarcodeList();
					AUIGrid.clearGridData(brcdListDetail);
					$("#formFile2").val("");
				}
				else{
					alert(data["msg"]);  /* 저장에 실패하였습니다. */
				}
				
				hideLoadingbar();
				
			}, null, null);
	});
	
	//DO 업로드
	$("#btn_form_upload3").click(function(){

			
			var file = $("#formFile3")[0];
			
			//파일 없으면 리턴
			if(!file.files[0].name){
				return;
			}
			
			ajaxJsonParam("<c:url value='/test/getLockAt.lims'/>", {}, function(data){

			});
			
			if(!confirm("D/O No 생성을 하시겠습니까?")){ 
				return;
			}
			showLoadingbar();
			var fileName = file.files[0].name;
			var fileExt = fileName.substring(fileName.length, fileName.length-4);
			
			
			
			if(fileExt.toUpperCase() != "XLSX"){
				alert("${msg.C000000696}"); /* xlsx 확장자만 업로드 할 수 있습니다. */ 
				return;
			}
			
			var formData = new FormData();
			formData.append("formFile3", $("#formFile3")[0].files[0]);
			formData.append("formType3", $("#formType3").val());
			
			ajaxJsonFormFile("/dly/applyFormFile3.lims", formData, function(data){
				//AUIGrid.addRow(mhrlsUnInspctList, data, 0);
				if(data["result"] == true){
					alert(data["msg"]); /* 저장 되었습니다. */
					searchBarcodeList();
					AUIGrid.clearGridData(brcdListDetail);
					$("#formFile3").val("");
				}
				else{
					alert(data["msg"]);  /* 저장에 실패하였습니다. */
				}
				
				hideLoadingbar();
				
			}, null, null);
	});
	
	//바코드 메인정보 삭제
	$("#btn_delete1").click(function(){
		
		if(confirm("${msg.C000000178}")){ //삭제하시겠습니까?
			var gridData = AUIGrid.getSelectedItems(brcdList);
		
			if (gridData.length == 0){
				return;
			}
			
			var array = new Array();
			
			for(var i=0; i<gridData.length; i++){
				array[i] = gridData[i]["item"]["dlivyBrcdSeqno"];
			}
			
			var params = {};
			params.gubun = "1";
			params.barcodeList = array;
			ajaxJsonParam("<c:url value='/dly/insDeleteBarcd.lims'/>", params, function(data){
				if(data > 0){
					alert("${msg.C000000179}"); /* 삭제되었습니다. */
					searchBarcodeList();
					AUIGrid.clearGridData(brcdListDetail);
				}
				else{
					alert("${msg.C000000769}"); /* 삭제를 실패 하였습니다. */
				}
			});
		}
		
		
	});
	
	//바코드 상세정보 삭제
	$("#btn_delete2").click(function(){
		
		if(confirm("${msg.C000000178}")){ //삭제하시겠습니까?
			var gridData = AUIGrid.getSelectedItems(brcdListDetail);
			
			var array = [];
			
			for(var i=0; i<gridData.length; i++){
				array[i] = gridData[i]["item"];
			}
			
			var params = {dlivyBrcdSeqno : gridData[0]["item"]["dlivyBrcdSeqno"], gubun : "2"};
			params.listGridData = array
			
			ajaxJsonParam("<c:url value='/dly/insDeleteBarcd.lims'/>", params, function(data){
				if(data > 0){
					alert("${msg.C000000179}"); /* 삭제되었습니다. */
					getGridDataParam("/dly/getBarcodeDetailList.lims", {dlivyBrcdSeqno : $("#dlivyBrcdSeqno").val()}, brcdListDetail)
				}
				else{
					alert("${msg.C000000769}"); /* 삭제를 실패 하였습니다. */
				}
			});
		}
		
	});
	
	$("#btn_changePoint").click(function(){
		
	});
}


//조회 함수
function searchBarcodeList(keyCode) {
	if(keyCode == 13)
		searchBarcodeList();
	else {
		if(keyCode == undefined) {
			
			getGridDataForm("<c:url value='/dly/getBarcodeList.lims'/>", "searchFrm", brcdList);
			AUIGrid.clearGridData(brcdListDetail);
			
			
		}
	}
}

function getGridDataParam11(url, param, divID, func){
	showLoader(divID);
	return ajaxJsonGridParam(url, param, function(data) {
		divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
		AUIGrid.setGridData(divID, data);
		hideLoader(divID);
		
		if(func != undefined && typeof func == "function"){
			func(data);
		}
	});
}
//엑셀 내보내기(Export);
function exportTo() {
	// 내보내기 실행	
		AUIGrid.exportToXlsx(brcdList, {
		});
	
};	
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001193}</h2><!-- 바코드 생성 -->
		<div class="btnWrap">			
			<!-- <button type="button" id="btn_excel_download" class="btn1">출력</button> --><!-- 출력 -->
			<!-- <button type="button" id="btn_download" class="btn5">다운로드</button> --><!-- 다운로드 -->
			<button type="button" id="btn_changePoint" class="btn3 search">${msg.C000001194}</button><!-- 변경점 알림설정 -->
			<button type="button" id="btn_select" class="btn3 search">${msg.C000000002}</button><!-- 조회 -->
		</div>
		<form id="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">	
				<colgroup>
					<col style="width:8%"></col>
					<col style="width:18%"></col>
					<col style="width:10%"></col>
					<col style="width:14%"></col>
					<col style="width:10%"></col>
					<col style="width:13%"></col>
					<col style="width:10%"></col>
					<col style="width:20%"></col>
				</colgroup>				
				<tr>
					<th>${msg.C000000080}</th><!-- 부서 -->
					<td><select id="shrDeptCode" name="shrDeptCode" class="wd100p" style="min-width:10em;"></select></td>					
					<th>${msg.C000001181}</th><!-- 검증결과 -->
					<td><select id="shrDlivyBrcdSttusCode" name="shrDlivyBrcdSttusCode" class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000575}</th><!-- LOT ID -->
					<td><input type="text" id="shrLotId" name="shrLotId" class="wd100p objBacode"></td>			
					<th>${msg.C000000747}</th><!-- 생성일 -->
					<td style="text-align:left;">
						<input type="text" id="shrDlivyDteBeginDte" name="shrDlivyDteBeginDte" class="wd10p" style="min-width: 8em;"> 
						~ 
						<input type="text" id="shrDlivyDteEndDte" name="shrDlivyDteEndDte" class="wd10p" style="min-width: 8em;">
					</td>
					</tr>
					<tr>
						<th>${msg.C000001357}</th><!-- 검증일 -->
					<td style="text-align:left;">
						<input type="text" id="validateDteBeginDte" name="validateDteBeginDte" class="wd10p" style="min-width: 10em;"> 
						 ~
						<input type="text" id="validateDteEndDte" name="validateDteEndDte" class="wd10p" style="min-width: 10em;">
					</td>
<!-- 					<th></th> -->
					<td colspan="6"></td>
<!-- 					<th></th> -->
<!-- 					<td></td>					 -->
<!-- 					<th></th> -->
<!-- 					<td></td>					 -->
					</tr>
					
			</table>
		</form>
	</div>
	<div style="display:flex;">
		<div class="subCon1 wd70p mgT15"  style="order:1;">
			<h3>${msg.C000001195}</h3> <!-- 바코드 생성 목록 -->
			<div class="btnWrap">
				<button type="button" id="logistics_excelPrint" class="old_btn old_btn2 print">${msg.C000001371}</button><!-- 물류양식출력-->
				<button type="button" id="quality_excelPrint" class="old_btn old_btn2 print">${msg.C000001372}</button><!-- 품질관리양식출력-->
				<button type="button" id="btn_excelPrint" class="old_btn old_btn2 print">${msg.C000000261}</button><!-- 엑셀출력-->
				<button type="button" id="btn_delete1" class="old_btn old_btn1 save">${msg.C000000097}</button><!-- 삭제 -->				
			</div>
			<div id="brcdList" class="mgT15" style="width:100%; height:370px; margin:0 auto;"></div>
		</div>
		<div class="subCon1 wd25p mgT15 mgL60" style="order:2;">
			<h3>${msg.C000001196}</h3><!-- 바코드 상세 목록 -->
			<!-- 저장버튼 -->
			<div class="btnWrap">
				<button type="button" id="btn_delete2" class="old_btn old_btn1 save">${msg.C000000097}</button><!-- 삭제 -->
			</div>
			<div id="brcdListDetail" class="mgT15" style="width:100%; height:370px; margin:0 auto;"></div>
		</div>
	</div>
	
	<form id="dlivyForm">	
		<div class="subCon1 wd100p mgT15">
			<input type="hidden" id="dlivyOrdeSeqno" value="">
			<input type="hidden" id="dlivyBrcdSeqno" value="">
			<input type="hidden" id="formType" name="formType" value="dlivyBrcd">
			<input type="hidden" id="formType2" name="formType2" value="dlivyBrcd">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:90%"></col>
				</colgroup>
				<tr>
					<th class="necessary">${msg.C000000080}</th> <!-- 부서 -->
					<td style="text-align:left;">
						<select id="inspctInsttCode" name="inspctInsttCode" class="wd20p"></select>
					</td>
				</tr>
				<tr>
					<th>${msg.C000000713}</th><!-- 출고지시서 업로드 -->
					<td style="text-align:left;">
						<!-- 파일첨부영역 -->
						<input type="file" id="formFile" name="formFile" class="wd30p" style="min-width:10em;">
						<button type="button" id="btn_form_upload" class="old_btn old_btn1 save">${msg.C000001193}</button> <!-- 바코드 생성 -->	
					</td>
				</tr>
				<tr>
				<th>${msg.C000001369}</th><!-- 배차지시서 업로드 -->
				<td style="text-align:left;">
						<input type="file" id="formFile2" name="formFile2" class="wd30p" style="min-width:10em;">
						<button type="button" id="btn_form_upload2" class="old_btn old_btn1 save">${msg.C000001370}</button> <!-- INVOICE 생성 -->	
				</td>		
				</tr>
				
				<tr>
				<th>D/O No 업로드</th><!-- 배차지시서 업로드 -->
				<td style="text-align:left;">
						<input type="file" id="formFile3" name="formFile3" class="wd30p" style="min-width:10em;">
						<button type="button" id="btn_form_upload3" class="old_btn old_btn1 save">D/O No 생성</button> <!-- INVOICE 생성 -->	
				</td>		
				</tr>
		
			</table>
		</div>
	</form>	
	<div id="printList" class="mgT15" style="width:100%; height:370px; margin:0 auto; display: none;"></div>
	<div id="printList3" class="mgT15" style="width:100%; height:370px; margin:0 auto; display: none;"></div>
	<div id="printList4" class="mgT15" style="width:100%; height:370px; margin:0 auto; display: none;"></div>
	
</div>
<!--  body 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>