<%@page import="lims.util.Util"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
<tiles:putAttribute name="body">
	<div class="subContent">
		<div class="subCon1">
			<h2>${msg.C100001212}</h2><%--ROW DATA LIST--%>
			<div class="btnWrap" style="top:-1px;">
				<button id="popUpbtn" style="display:none;"></button>
				<button id="btnChkGridShowPdfViewer" class="btn5">${msg.C100001213}</button><%--병합문서보기--%>
				<button id="btnPdfViewerGridDataDel" class="delete">${msg.C100000458}</button><%--삭제--%>
			</div>
		</div><br />
		<div>
			<div id="pdfViewerGrid" style="width:100%; height:200px; margin:0 auto;"></div>
		</div><br />
		<div>
			<iframe id="blob_to_pdf_iframe_pop" width="100%" height="1200px"></iframe>
		</div>
	</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>

var pdfViewerGrid = "pdfViewerGrid"; // 시험항목 정보 그리드
var param = '${param.param}';
var bplcCode = '${param.bplcCode}';
var type = '${param.type}';
var reason;

$(function() {

	setPDFViewerGrid();//그리드 생성

	setButtonEvent();//버튼 이벤트

	setPDFViewerGridEvent();//그리드이벤트

	getPdfViewerGridData();//시험항목정보에서 체크된 항목중 최상위 그리드형태로 재생성
	
	popUpEv();

});


//그리드 생성
function setPDFViewerGrid() {
	var pdfViewerDialogColumnLayout = [];
	auigridCol(pdfViewerDialogColumnLayout);

	pdfViewerDialogColumnLayout.addColumn("binderitemvalueId", '${msg.C100001214}', null, true); /*ID*/
	pdfViewerDialogColumnLayout.addColumn("B01", '${msg.C100001215}', null, true); /*문서명*/
	pdfViewerDialogColumnLayout.addColumn("B02", '${msg.C100001216}', null, true); /*출력한어플리케이션*/
	pdfViewerDialogColumnLayout.addColumn("B03", '${msg.C100001217}', null, true); /*컴퓨터명*/
	pdfViewerDialogColumnLayout.addColumn("B04", '${msg.C100001218}', null, true); /*LoginID*/
	pdfViewerDialogColumnLayout.addColumn("B05", '${msg.C100001219}', null, true); /*생성일*/
	pdfViewerDialogColumnLayout.addColumn("B06", '${msg.C100001220}', null, true); /*문서페이지수*/

	pdfViewerGrid = createAUIGrid(pdfViewerDialogColumnLayout,pdfViewerGrid,{ showRowCheckColumn : true, showRowAllCheckBox : true });
}

//그리드 이벤트
function setPDFViewerGridEvent() {
	AUIGrid.bind(pdfViewerGrid, "ready", function(event) {
		gridColResize(pdfViewerGrid, "2");
	});

	AUIGrid.bind(pdfViewerGrid, "cellDoubleClick", function(event){
		//PDF Viewer 생성
		var gridItem = event.item;
		getblobPdfViewer(gridItem);
	});
}

//버튼 이벤트
function setButtonEvent() {
	//병합문서보기
	$("#btnChkGridShowPdfViewer").click(function() {
		var chkGridItem = AUIGrid.getCheckedRowItemsAll(pdfViewerGrid);
		getCheckBlobPdfViewer(chkGridItem);
	});

	//삭제
	$("#btnPdfViewerGridDataDel").click(function() {
		if (AUIGrid.getCheckedRowItemsAll(pdfViewerGrid).length){
			$("#popUpbtn")[0].click();
		} else {
			alert("${msg.C100000490}");
		}
	});	
}
function popUpEv(){
	dialogtext('popUpbtn','test',reason,function(reason){
		var datas=AUIGrid.getCheckedRowItemsAll(pdfViewerGrid);	
		var userId = '${UserMVo.userId}';
		var loginIp = '${UserMVo.loginIp}';

		for (var i=0; i<datas.length;i++)
			Object.assign(datas[i],{userId:userId},{loginIp:loginIp},{reason:reason},{bplcCode:bplcCode}, {type : type});
		
		customAjax({
			'url' : '/com/delRdmsResultData.lims',
			'data' : datas,
			'successFunc' : function(result) {
				getPdfViewerGridData();
			}
		});
	});	
}

//시험항목정보에서 체크된 항목중 최상위 그리드형태로 재생성
function getPdfViewerGridData() {
	var paramObj = { 'binderitemvalueIdStr' : param, 'bplcCode' : bplcCode };
	customAjax({
		'url' : '/com/getPdfViewerRowData.lims',
		'data' : paramObj,
		'successFunc' : function(result) {
			if(!!result&&result.length!=0) {
				//그리드컬럼 세팅 정보
				var columnInfoList = result[0].columnInfoList;
				//동적 그리드 값 세팅하기 위한 빈배열
				var gridData = [];
				for(var i = 0; i < result.length; i++) {
					//동적 그리드 레이아웃 변경 세팅값
					var changeColumnCol = []
					auigridCol(changeColumnCol);
					//동적 그리드 빈배열에 들어갈 컬럼객체
					var dynamicGridObj = {};
					for(var j = 0; j < columnInfoList.length; j++) {
						//각 코드들의 명칭이 고정값이 아니기 때문에 주석을 생략
						changeColumnCol.addColumnCustom('binderitemvalueId','binderitemvalueId',null,false,false); //RDMS 구분값
						dynamicGridObj.binderitemvalueId = result[i].binderitemvalueId;
						//R01, R02, R03은 컨버터에서 확인 가능하며 일반그리드화면에서 확인불가하여 팝업창에서도 동일하게 분기 및 주석처리
						if(columnInfoList[j].itemName != 'R01' && columnInfoList[j].itemName != 'R02' && columnInfoList[j].itemName != 'R03') {
							switch(columnInfoList[j].itemName) {
							  case 'B01':
								  changeColumnCol.addColumnCustom('B01',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B01 = result[i].b01;break;
							  case 'B02':
								  changeColumnCol.addColumnCustom('B02',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B02 = result[i].b02;break;
							  case 'B03':
								  changeColumnCol.addColumnCustom('B03',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B03 = result[i].b03;break;
							  case 'B04':
								  changeColumnCol.addColumnCustom('B04',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B04 = result[i].b04;break;
							  case 'B05':
								  changeColumnCol.addColumnCustom('B05',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B05 = result[i].b05;break;
							  case 'B06':
								  changeColumnCol.addColumnCustom('B06',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.B06 = result[i].b06;break;
//							  case 'R01':
//								  changeColumnCol.addColumnCustom('R01',columnInfoList[j].itemLabelname,null,true,false);
//								  dynamicGridObj.R01 = result[i].r01;break;
//							  case 'R02':
//								  changeColumnCol.addColumnCustom('R02',columnInfoList[j].itemLabelname,null,true,false);
//								  dynamicGridObj.R02 = result[i].r02;break;
//							  case 'R03':
//								  changeColumnCol.addColumnCustom('R03',columnInfoList[j].itemLabelname,null,true,false);
//								  dynamicGridObj.R03 = result[i].r03;break;
							  case 'U01':
								  changeColumnCol.addColumnCustom('U01',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U01 = result[i].u01;break;
							  case 'U02':
								  changeColumnCol.addColumnCustom('U02',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U02 = result[i].u02;break;
							  case 'U03':
								  changeColumnCol.addColumnCustom('U03',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U03 = result[i].u03;break;
							  case 'U04':
								  changeColumnCol.addColumnCustom('U04',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U04 = result[i].u04;break;
							  case 'U05':
								  changeColumnCol.addColumnCustom('U05',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U05 = result[i].u05;break;
							  case 'U06':
								  changeColumnCol.addColumnCustom('U06',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U06 = result[i].u06;break;
							  case 'U07':
								  changeColumnCol.addColumnCustom('U07',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U07 = result[i].u07;break;
							  case 'U08':
								  changeColumnCol.addColumnCustom('U08',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U08 = result[i].u08;break;
							  case 'U09':
								  changeColumnCol.addColumnCustom('U09',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U09 = result[i].u09;break;
							  case 'U10':
								  changeColumnCol.addColumnCustom('U10',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U10 = result[i].u10;break;
							  case 'U11':
								  changeColumnCol.addColumnCustom('U11',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U11 = result[i].u11;break;
							  case 'U12':
								  changeColumnCol.addColumnCustom('U12',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U12 = result[i].u12;break;
							  case 'U13':
								  changeColumnCol.addColumnCustom('U13',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U13 = result[i].u13;break;
							  case 'U14':
								  changeColumnCol.addColumnCustom('U14',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U14 = result[i].u14;break;
							  case 'U15':
								  changeColumnCol.addColumnCustom('U15',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U15 = result[i].u15;break;
							  case 'U16':
								  changeColumnCol.addColumnCustom('U16',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U16 = result[i].u16;break;
							  case 'U17':
								  changeColumnCol.addColumnCustom('U17',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U17 = result[i].u17;break;
							  case 'U18':
								  changeColumnCol.addColumnCustom('U18',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U18 = result[i].u18;break;
							  case 'U19':
								  changeColumnCol.addColumnCustom('U19',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U19 = result[i].u19;break;
							  case 'U20':
								  changeColumnCol.addColumnCustom('U20',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U20 = result[i].u20;break;
							  case 'U21':
								  changeColumnCol.addColumnCustom('U21',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U21 = result[i].u21;break;
							  case 'U22':
								  changeColumnCol.addColumnCustom('U22',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U22 = result[i].u22;break;
							  case 'U23':
								  changeColumnCol.addColumnCustom('U23',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U23 = result[i].u23;break;
							  case 'U24':
								  changeColumnCol.addColumnCustom('U24',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U24 = result[i].u24;break;
							  case 'U25':
								  changeColumnCol.addColumnCustom('U25',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U25 = result[i].u25;break;
							  case 'U26':
								  changeColumnCol.addColumnCustom('U26',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U26 = result[i].u26;break;
							  case 'U27':
								  changeColumnCol.addColumnCustom('U27',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U27 = result[i].u27;break;
							  case 'U28':
								  changeColumnCol.addColumnCustom('U28',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U28 = result[i].u28;break;
							  case 'U29':
								  changeColumnCol.addColumnCustom('U29',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U29 = result[i].u29;break;
							  case 'U30':
								  changeColumnCol.addColumnCustom('U30',columnInfoList[j].itemLabelname,null,true,false);
								  dynamicGridObj.U30 = result[i].u30;break;
							}
						}
					}
					gridData[i] = dynamicGridObj;
				}
				//동적 그리드 생성을 위한 기존 그리드 제거
				AUIGrid.changeColumnLayout(pdfViewerGrid, changeColumnCol);
				//동적 그리드 주입
				AUIGrid.setGridData(pdfViewerGrid, gridData);

				getblobPdfViewer(gridData[0]);
			} else {
				window.close();
			}
		}
	});
}

//문서보기
function getblobPdfViewer(selectedItem) {
	selectedItem['bplcCode'] = bplcCode;
	customAjax({
		'url':'/com/getblobPdfViewer.lims',
		'data':selectedItem,
		'successFunc':function(result) {
			if(!!result)
				blobToPDFViewer(result);
		}
	});
}

//병합문서보기
function getCheckBlobPdfViewer(checkedItemList) {
	checkedItemList[0]['bplcCode'] = bplcCode;
	customAjax({
		'url' : '/com/getCheckBlobPdfViewer.lims',
		'data' : checkedItemList,
		'successFunc' : function(result) {
			if(!!result)
				blobToPDFViewer(result);
		}
	});
}

//blob to PDF Viewer
function blobToPDFViewer(blobData) {
	var base64str = blobData.fileData;
	var binary = atob(base64str.replace(/\s/g, ''));
	var len = binary.length;
	var buffer = new ArrayBuffer(len);
	var view = new Uint8Array(buffer);
	for(var i = 0; i < len; i++)
		view[i] = binary.charCodeAt(i);
	var blob = new Blob([view], {type:'application/pdf'});
	var url = URL.createObjectURL(blob);
	document.getElementById('blob_to_pdf_iframe_pop').src = url;
}

</script>
</tiles:putAttribute>
</tiles:insertDefinition>