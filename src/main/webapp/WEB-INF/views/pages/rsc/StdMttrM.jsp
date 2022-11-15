<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<style>
	.c-red {
		background-color : #FEDBDE
	}
</style>
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000646}</h2> <!-- 표준 물질 조회 -->
		<div class="btnWrap">
			<button id="btnSelect" class="btn4">${msg.C000000079}</button> <!-- 선택 -->
			<button id="btnPrint" class="print btn2">${msg.C000000623}</button> <!-- 바코드 출력 -->
			<button id="btnSearch" class="search btn3" style="margin-left:3px;" >${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" name="searchFrm" onsubmit="return false" >
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
<%-- 					<th>${msg.C000000080}</th> <!-- 부서 --> --%>
<!-- 					<td><select id="deptCodeSch" name="deptCodeSch"></select></td> -->
					<th>${msg.C000000624}</th> <!-- 담당 팀 -->
					<td>
						<select id="chrgTeamSeCodeSch" name="chrgTeamSeCodeSch">
							<option value=''>${msg.C000000079}</option>	<!-- 선택 -->
						</select>
					</td>
					<th>${msg.C000000647}</th> <!-- 시약 종류 -->
					<td><select id="rgntKndCodeSch" name="rgntKndCodeSch"></select></td>
					<th>${msg.C000000648}</th> <!-- 시약 구분 -->
					<td><select id="rgntSeCodeSch" name="rgntSeCodeSch"></select></td>
					<th>${msg.C000000649}</th> <!-- 시약 명 -->
					<td><input type="text" id="rgntNmSch" name="rgntNmSch" class="schClass"></td>
				</tr>
				<tr>
					<th>${msg.C000000065}</th>
					<td style="text-align:left;">
						<label><input type="radio" id="validDteA" name="validDteSch" value="" >${msg.C000000062}</label> <!-- 전체 -->
						<label><input type="radio" id="validDteB" name="validDteSch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" id="validDteC" name="validDteSch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
					<th>${msg.C000001033}</th> <!-- 상위 표준 물질 -->
					<td><input type="text" id="upperStdMttrSch" name="upperStdMttrSch"></td>
					<th></th>
					<td></td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div>
			<div id="stdMttrMaster"></div>
		</div>
	</div>
	<div class="subCon1 mgT20">
		<h2>${msg.C000000650}</h2> <!-- 표준 물질 정보 -->
		<div class="btnWrap">
			<button id="btnNew" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button id="btnDelete" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="stdMttrFrm" name="stdMttrFrm" onsubmit="return false">
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
<%-- 					<th class="necessary">${msg.C000000080}</th> <!-- 부서 --> --%>
<!-- 					<td><select class="wd100p" id="inspctInsttCode" name="inspctInsttCode"></select> -->
					<th class="necessary">${msg.C000000624}</th> <!-- 담당 팀 -->
					<td>
						<select class="wd100p" id="chrgTeamSeCode" name="chrgTeamSeCode">
							<option>${msg.C000000079}</option> <!-- 선택 -->
						</select>
					</td>
					<th class="necessary">${msg.C000000649}</th> <!-- 시약 명 -->
					<td><input type="text" id="rgntNm" name="rgntNm">
					<th class="necessary">${msg.C000001026}</th> <!-- 제품 규격 -->
					<td>
						<input type="text" id="prductStndrdNm" name="prductStndrdNm" class="wd60p" disabled>
						<input type="hidden" id="prductStndrdSeqno" name="prductStndrdSeqno" class="wd60p" style="min-width:10em;">
						<button type="button" id="btnStndrdSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->
					</td>
					<th class="necessary">${msg.C000000647}</th> <!-- 시약 종류 -->
					<td>
						<select id="rgntKndCode" name="rgntKndCode">
						</select>
					</td>
				</tr>
				<tr>
					<th class="necessary">${msg.C000000648}</th> <!-- 시약 구분 -->
					<td><select name="rgntSeCode" id="rgntSeCode"></select></td>
					<th class="necessary">${msg.C000000524}</th> <!-- 입고일자 -->
					<td><input type="text" name="wrhousngDte" id="wrhousngDte"></td>
					<th id="thValidDte" class="necessary">${msg.C000000631}</th> <!-- 유효일자 -->
					<td style="text-align: left;" colspan="3">
						<input type="checkbox" id="dataCAt" name="dataCAt"  style="width: 12%"/>
						<input type="text" name="cycle" id="cycle"  style="width: 33%">
						<select id="inspctCrrctCycleCode" name="inspctCrrctCycleCode" style="width: 12%"></select>
						<input type="text" name="validDte" id="validDte"  style="width: 35%" disabled>
					</td>
				</tr>
				<tr>
					<th>${msg.C000001034}</th> <!-- 관리책임자(정,제조자) -->
					<td style="text-align: left;">
						<input type="text" id="manageRspnberJNm" name="manageRspnberJNm"  class="wd70p" style="min-width:10em;"onkeyup="fnChkByte(this, '200')">
						<button type="button" id="btnManagerNmJSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->

					</td>
					<th>${msg.C000000519}</th> <!-- 관리책임자(부) -->
					<td style="text-align: left;">
						<input type="text" id="manageRspnberBNm" name="manageRspnberBNm"  class="wd70p" style="min-width:10em;"onkeyup="fnChkByte(this, '200')">
						<button type="button" id="btnManagerNmBSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->

					</td>
					<th>${msg.C000000632}</th> <!-- 폐기여부 -->
					<td style="text-align:left;">
						<input type="checkbox" id="dsuseAt" name="dsuseAt" style="width:12%;" />
						<input type="text" name="dsuseDte" id="dsuseDte" style="width:80%;" disabled/>
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
			<input type="hidden" id="stdMttrSeqno" name="stdMttrSeqno">
			<input type="hidden" id="manageRspnberJId" name="manageRspnberJId">
			<input type="hidden" id="manageRspnberBId" name="manageRspnberBId">
		</form>
	</div>

	<div class="subCon1 mgT20">
		<h2>${msg.C000001033}</h2> <!-- 상위 표준 물질 -->
		<div class="btnWrap">
			<button id="btnAddUpperMttr" class="save btn1">${msg.C000000504}</button> <!-- 추가 -->
			<button id="btnRemoveUpperMttr" class="save btn1">${msg.C000000097}</button> <!-- 삭제 -->
		</div>
		<!-- Main content -->
		<form id="upperStdMttrFrm" name="upperStdMttrFrm" onsubmit="return false">
			<div id="upperMttrGrid" class="mgT15"></div>
		</form>
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
<script>
var lang = ${msg}; // 기본언어
	$(function(){

		getAuth(); //권한 체크

		init();//기본 세팅

		setStdMttrMGrid();  //그리드 생성

		setStdMttrMGridEvent(); //그리드 이벤트

		setUpperMttrGrid(); //상위 표준 물질 그리드 생성

		setButtonEvent();//버튼 이벤트

		document.getElementById("wrhousngDte").value = currentDate();

		popup();
	});
var stdMttrMaster = "stdMttrMaster";
var upperMttrGrid;

function init(){
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'rgntKndCode', {'upperCmmnCode': 'RS16'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'rgntSeCode', {'upperCmmnCode': 'RS15'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'rgntSeCodeSch', {'upperCmmnCode': 'RS15'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'rgntKndCodeSch', {'upperCmmnCode': 'RS16'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'chrgTeamSeCodeSch', {'upperCmmnCode': 'RS19'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'chrgTeamSeCode', {'upperCmmnCode': 'RS19'}, false, "${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnDteFileCombo.lims','inspctCrrctCycleCode',{"upperCmmnCode" : "SY14"},true); /* 선택 */
// 	ajaxJsonComboBox3("/wrk/getDeptList.lims","inspctInsttCode",{"analsAt" : "Y", "limsUseAt" : "Y", "mmnySeCode": "SY01000001"}, true);
	//부서
// 	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch', {analsAt : "Y", deptAt:"Y", mmnySeCode :"SY01000001"}, false, "${msg.C000000079}"); /* 선택 */
// 	ajaxJsonComboBox3("/wrk/getDeptList.lims","chrgTeamSeCodeSch",{"analsAt" : "Y", "limsUseAt" : "Y", "mmnySeCode": "SY01000001"}, true);

// 	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCode',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"${msg.C000000079}"); /* 선택 */
// 	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"${msg.C000000079}"); /* 선택 */
	datePickerCalendar(["wrhousngDte", "validDte", "dsuseDte"]);
}

function setStdMttrMGrid(){
	var columnLayout = {
			stdMttrMaster : []
	};

	var reqPros = {
		//엑스트라체크박스 표시
		showRowCheckColumn : true,
		// 전체 체크박스 표시 설정
		showRowAllCheckBox : true,
		rowStyleFunction : function(rowIndex, item) {
			if(!getCompareDate(getFormatDate(),item.validDte)){
				return "c-red";
			}
			return "";
		}
	};

	auigridCol(columnLayout.stdMttrMaster);
	columnLayout.stdMttrMaster.addColumnCustom("brcd","${msg.C000000627}",null,true,false) /* 바코드 */
	.addColumnCustom("chrgTeamSeqno","${msg.C000000080}",null,false,false) /* 부서 */
	.addColumnCustom("chrgTeamSeCode","${msg.C000000080}",null,false,false) /* 부서 */
	.addColumnCustom("chrgTeamSeCodeNm","${msg.C000000624}",null,true,false) /* 담당 팀 */
	.addColumnCustom("prductStndrdNm","${msg.C000001026}",null,true,false) /* 제품규격 */
	.addColumnCustom("prductStndrdCnt","${msg.C000001030}",null,true,false) /* 재고 */
	.addColumnCustom("rgntNm","${msg.C000000649}",null,true,false) /* 시약 명 */
	.addColumnCustom("rgntKndCodeNm","${msg.C000000647}",null,true,false) /* 시약 종류 */
	.addColumnCustom("rgntSeCodeNm","${msg.C000000648}",null,true,false) /* 시약 구분 */
	.addColumnCustom("wrhousngDte","${msg.C000000524}",null,true,false) /* 입고일자 */
	.addColumnCustom("validDte","${msg.C000000631}",null,true,false) /* 유효일자 */
	.addColumnCustom("manageRspnberJNm","${msg.C000001034}",null,true,false) /* 관리책임자(정,제조자) */
	.addColumnCustom("manageRspnberBNm","${msg.C000000519}",null,true,false) /* 관리책임자(부)*/
	.addColumnCustom("dsuseAt","${msg.C000000632}",null,true,false) /* 폐기여부 */
	.addColumnCustom("dsuseDte","${msg.C000000543}",null,true,false) /* 폐기일자 */
	.addColumnCustom("prductStndrdSeqno","${msg.C000001026}",null,true,false); /* 제품규격 */

	stdMttrMaster = createAUIGrid(columnLayout.stdMttrMaster, stdMttrMaster, reqPros);
	gridResize([stdMttrMaster]);
}

function setStdMttrMGridEvent(){
	AUIGrid.bind(stdMttrMaster, "cellDoubleClick", function(event){
		var item = event.item;
		detailAutoSet({'item':event["item"],'targetFormArr':["stdMttrFrm"],'successFunc':function(){
			if(!!item.validDte){
				$("#thValidDte").removeClass("necessary");
			}

			$("#chrgTeamSeCode").prop("disabled", true);
			$("#chrgTeamSeqno").prop("disabled", true);
			$("#rgntKndCode").prop("disabled", true);
			$("#rgntSeCode").prop("disabled", true);

			var param = $("#searchFrm").serializeObject();
			customAjax("/rsc/getUpperStdMttr.lims",{stdMttrSeqno : $("#stdMttrSeqno").val()}).then(function(data){
				AUIGrid.setGridData(upperMttrGrid, data);
			});
		}
		});
	});
}

function setUpperMttrGrid(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("stdMttrSeqno","${msg.C000001035}",null,false,false) /* 표준 물질 일련번호 */
	col.addColumnCustom("brcd","${msg.C000000627}",null,true,false) /* 바코드 */
	col.addColumnCustom("chrgTeamSeqno","${msg.C000000080}",null,false,false) /* 부서 */
	col.addColumnCustom("chrgTeamSeCodeNm","${msg.C000000624}",null,true,false) /* 담당 팀 */
	col.addColumnCustom("prductStndrdNm","${msg.C000001026}",null,true,false) /* 제품규격 */
	col.addColumnCustom("prductStndrdCnt","${msg.C000001030}",null,true,false) /* 재고 */
	col.addColumnCustom("rgntNm","${msg.C000000649}",null,true,false) /* 시약 명 */
	col.addColumnCustom("rgntKndCodeNm","${msg.C000000647}",null,true,false) /* 시약 종류 */
	col.addColumnCustom("rgntSeCodeNm","${msg.C000000648}",null,true,false) /* 시약 구분 */
	col.addColumnCustom("wrhousngDte","${msg.C000000524}",null,true,false) /* 입고일자 */
	col.addColumnCustom("validDte","${msg.C000000631}",null,true,false) /* 유효일자 */
	col.addColumnCustom("manageRspnberJNm","${msg.C000001034}",null,true,false) /* 관리책임자(정,제조자) */
	col.addColumnCustom("manageRspnberBNm","${msg.C000000519}",null,true,false) /* 관리책임자(부)*/
	col.addColumnCustom("dsuseAt","${msg.C000000632}",null,true,false) /* 폐기여부 */
	col.addColumnCustom("dsuseDte","${msg.C000000543}",null,true,false) /* 폐기일자 */
	col.addColumnCustom("prductStndrdSeqno","${msg.C000001026}",null,true,false); /* 제품규격 */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true,
 			rowStyleFunction : function(rowIndex, item) {
 				if(item["coaCnt"] > 0){
 					return "coa-row-style";
 				}
 				else{
 					return "";
 				}
 			}
 	}


	//auiGrid 생성
	upperMttrGrid = createAUIGrid(col, "upperMttrGrid", cusPros);

	// 그리드 칼럼 리사이즈
	AUIGrid.bind(upperMttrGrid, "ready", function(event) {
		gridColResize([upperMttrGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//버튼 클릭 이벤트
function setButtonEvent(){

	//상위 표준물질 삭제 이벤트
	$("#btnRemoveUpperMttr").click(function(e){
		AUIGrid.removeRow(upperMttrGrid, "selectedIndex");
	});

	//저장
	document.getElementById("btnSave").addEventListener("click",function(e){
		saveStdMttr();
	});

	//폐기여부
	document.getElementById("dsuseAt").addEventListener("click",function(e){
		var flag = e.target.checked;
		flag = !flag;
		document.getElementById("dsuseDte").disabled = flag;

		if(flag)
			document.getElementById("dsuseDte").value = "";
	});

	//유효일자
	document.getElementById("dataCAt").addEventListener("click",function(e){
		var flag = e.target.checked;
		document.getElementById("inspctCrrctCycleCode").disabled = flag;
		document.getElementById("cycle").disabled = flag;
		document.getElementById("validDte").disabled = !flag;
		if(flag){
			document.getElementById("inspctCrrctCycleCode").value = "";
			document.getElementById("cycle").value = "";
			document.getElementById("validDte").value = "";
			$("#thValidDte").removeClass("necessary");
		}else{
			document.getElementById("validDte").value = "";
			$("#thValidDte").addClass("necessary");
		}


	});

	//선택
	document.getElementById("btnSelect").addEventListener("click",function(e){
		var row = AUIGrid.getSelectedItems(stdMttrMaster);
		if(row.length == 0)
			alert("${msg.C000000509}"); /* 선택된 데이터가 없습니다. */
		else{
			detailAutoSet({"item":row[0].item,"targetFormArr":["stdMttrFrm"],"successFunc":function(){
//  			detailAutoSet({'item':event["item"],'targetFormArr':["stdMttrFrm"],'successFunc':function(){

			}
			});
		}


			//gridDataSet("stdMttrFrm", "input, select", row[0].item);
	});

	//신규
	document.getElementById("btnNew").addEventListener("click",function(e){
		reset();
	});


	//삭제
	document.getElementById("btnDelete").addEventListener("click",function(e){
		saveStdMttr("del");
	});

	//검색
	document.getElementById("btnSearch").addEventListener("click",function(e){
		getSearchMhrls();
	});

	//바코드 출력
	document.getElementById("btnPrint").addEventListener("click", function(e){
		var checkRow = AUIGrid.getCheckedRowItemsAll(stdMttrMaster);
		var arrRow = [];
		var arr2Row = [];
		for(var i = 0; i<checkRow.length; i++){
			if(checkRow[i].rgntSeCode == "RS15000001"){
				arrRow.push("["+checkRow[i].brcd+"]");
			} else {
				arr2Row.push("["+checkRow[i].brcd+"]");

			}

		}

 		openBacode(arrRow,arr2Row);
	})

	$("#wrhousngDte").change(function(e){
		calcValidDte();
	});

	$("#cycle").change(function(e){
		calcValidDte();
	});

	$("#inspctCrrctCycleCode").change(function(e){
		calcValidDte();
	});

	$(".schClass").keypress(function(e){
		if (e.which == 13){
			getSearchMhrls();
	    }
	});

}

function popup(){
	//관리책임자(정)
	dialogUser("btnManagerNmJSearch", null, "ManagerNmJDialog", function(item){
		$("#manageRspnberJNm").val(item.userNm);
		$("#manageRspnberJId").val(item.userId);
	});
	//관리책임자(부)
	dialogUser("btnManagerNmBSearch", null, "ManagerNmBDialog", function(item){
		$("#manageRspnberBNm").val(item.userNm);
		$("#manageRspnberBId").val(item.userId);
	});
	//표준물질 팝업
	dialogUpperStdMttr("btnAddUpperMttr", null, "UpperStdMttrDialog", function(item){
		console.log(item);
		AUIGrid.addRow(upperMttrGrid, item, 0);
	});
	//제품 규격 팝업
	dislogPrductStndrd("btnStndrdSearch", null, "prductStndrdDialog",null, function(item){

		getEl("prductStndrdNm").value = item.prductStndrdNm;
		getEl("prductStndrdSeqno").value = item.prductStndrdSeqno;
	},function(){
		$("#schPrductStndrdSeCode").val("RS20000002");
	});

}


function saveStdMttr(type){
	document.getElementById("validDte").disabled = false;
	document.getElementById("dsuseDte").disabled = false;

	var data = $("#stdMttrFrm").serializeObject();
	data.addGridListData = AUIGrid.getAddedRowItems(upperMttrGrid);
	data.removeGridListData = AUIGrid.getRemovedItems(upperMttrGrid);
	data.gridListData = AUIGrid.getGridData(upperMttrGrid);

	var msg = (type == "del") ? "${msg.C000000097}" : "${msg.C000000015}"; /* 삭제, 저장 */
	if(type)
		data["deleteAt"] = "Y";

	if(!saveValidation ("stdMttrFrm"))
		return false;

	if(document.getElementById("dsuseAt").checked){
		bool = (document.getElementById("dsuseDte").value != "") ? true : false;
		if(!bool){
			alert("${msg.C000000636}"); /* 폐기 여부가 체크되어 폐기 일자를 입력 해야 합니다. */
			return false;
		}
	}

	var url = "/rsc/saveStdMttrM.lims";
	customAjax({'url':url,"data":data}).then(function(result){
		if(result){
			getSearchMhrls();
			AUIGrid.clearGridData(upperMttrGrid);
			reset();
			alert("${msg.C000000637} "+ msg +" ${msg.C000000638}"); /* 성공적으로 삭제, 저장 되었습니다 */
		}
		else
			alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
	});

}

function chkValidDte(){
	var selector = document.querySelectorAll("#wrhousngDte, #cycle, #inspctCrrctCycleCode");
	var check = 0;
	for(var i = 0; i<selector.length; i++){
		var value = document.getElementById(selector[i].id).value;
		if(!value){
			check++;
		}
	}

	return check;
}

function calcValidDte(){
	if(chkValidDte() > 0)
		return false;

	var dt = document.getElementById("wrhousngDte").value,
	cycle = document.getElementById("cycle").value;
	inspctCrrctCycleCode = document.getElementById("inspctCrrctCycleCode").value;


	document.getElementById("validDte").value = date_add(dt, (cycle * inspctCrrctCycleCode));
}

function reset(){
	// 폼 초기화
	pageReset(["stdMttrFrm"], null, null, function(){

		document.getElementById("wrhousngDte").value = currentDate();

		$("#chrgTeamSeCode").prop("disabled", false);
		$("#chrgTeamSeqno").prop("disabled", false);
		$("#rgntKndCode").prop("disabled", false);
		$("#rgntSeCode").prop("disabled", false);
		$("#thValidDte").addClass("necessary");
	});
// 	$("#inspctInsttCode").prop("disabled", false);
}

function getSearchMhrls(){
	var param = $("#searchFrm").serializeObject();
	customAjax({"url":"/rsc/getStdMttrList.lims","data":param}).then(function(data){
		AUIGrid.setGridData(stdMttrMaster, data);
	});
}

//바코드 출력 확인 함수
function openBacode(data,data2){
	if(!confirm("${msg.C000000639}")) /* 바코드를 출력하시겠습니까? */
		return false;
	bacodeList(data,data2);
}

//바코드 - 크로닉스 리포트 연동
function bacodeList(data,data2){
	html5Viewerte(["/BacodeTest.mrd"],["/BacodeTest_Working.mrd"], data,data2);

}
function html5Viewerte(fileNm,fileNm2, arrayData,arrayData2){

	var viewerParam = {};
	customAjax("/com/html5Viewer.lims",viewerParam).then(function(data){
		var serverUrl = data.reportingServerPath;
		var filePath = data.rdPath;
		var openParam = {};
		var openArray = [];
		var forInt = 0;

		for(var i=0; i<arrayData.length; i++){

			openParam = {};
			openParam.mrdPath = filePath + fileNm;
			openParam.mrdParam = data.loginParameter + " /rp " + arrayData[i];
			openArray[forInt] =  openParam;
			forInt ++;
		}
		for(var i=0; i<arrayData2.length; i++){

			openParam = {};
			openParam.mrdPath = filePath + fileNm2;
			openParam.mrdParam = data.loginParameter + " /rp " + arrayData2[i];
			openArray[forInt] =  openParam;
			forInt ++;
		}
		viewerFunc(serverUrl, openArray);
	});
}
</script>
<!--  script 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>

