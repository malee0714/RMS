<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="lims.sys.vo.UserMVo"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent" id="middle_wrap">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100001102}</h2> <!-- 그룹코드 목록 -->
			<div class="btnWrap">
				<button  id="addrowGroupCode" class="btn5" style="display:<c:if test = "${UserMVo.authorSeCode != 'SY09000001'}">none</c:if>"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
				<button  id="removeRowGroupCode" class="delete" style="display:<c:if test = "${UserMVo.authorSeCode != 'SY09000001'}">none</c:if>"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
				<button  id="saveButton" class="save" style="display:<c:if test = "${UserMVo.authorSeCode != 'SY09000001'}">none</c:if>">${msg.C100000760}</button> <!-- 저장 -->
				<button  id="selectGroupCode" class="search" >${msg.C100000767}</button> <!-- 조회 -->
			</div>
		<form action="javascript:;" id="cmmnForm" name="cmmnForm">
			<input type="hidden" name="cmmnCode" id="cmmnCode"/>
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:40%"></col>
				</colgroup>
				<tr>
					<th >${msg.C100000221}</th> <!-- 그룹 코드 -->
					<td ><input type="text"  id="searchCode" name="searchCode" class="schClass"></td>
					<th >${msg.C100000222}</th> <!-- 그룹 코드명 -->
					<td ><input type="text"  id="searchNm" name="searchNm" class="schClass"></td>
					<th >${msg.C100000443}</th> <!-- 사용여부 -->
					<td ><input name="schUseAt" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
					<input name="schUseAt" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
			        <input name="schUseAt" value="N" type="radio">${msg.C100000449}</td> <!-- 사용안함 -->
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2" >
		<div id="groupCode"></div>
	</div>
	<br>
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100001103}</h2> <!-- 그룹상세코드 목록 -->
		<div class="btnWrap">
			<button  id="addrowDetailCode" class="btn5" ><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
			<button  id="removeRowDetailCode" class="delete" ><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
			<button  id="insertDetailCode" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
	</div>
	<div class="subCon2">
		<div id="detailCode"></div>
	</div>
</div>

    </tiles:putAttribute>

    <tiles:putAttribute name="script">
<script>



/*******전역변수*********/
var groupCode = document.getElementById("groupCode").id;
var detailCode = document.getElementById("detailCode").id;
var groupGridID;
var detailGridID;
var cmmnCode;//groupCode의 Pk키를 담을 변수
var thisRowCrud;
var thisRowItems;
var thisDetailRowCrud;
var thisDetailRowItems;


/*******OnLoad*********/
$(document).ready(function(){

	// 그리드 세팅
	setGrid();

	//AUI 그리드 이벤트
	auiGridEvent();

	// 버튼 이벤트
	setButtonEvent();

	hideDetailBtn();

	//그리드 사이즈 조절
	gridResize([groupGridID, detailGridID]);
});

//그리드 세팅 이벤트
function setGrid(){

	//그리드 레이아웃 정의
	var columnLayout = {
		groupCode : [],
		detailCode : []
	};

	//공통코드 그리드 정의
	auigridCol(columnLayout.groupCode);
	//컬럼 속성 정의
	var groupGridColPros = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
		}
	};
	columnLayout.groupCode.addColumnCustom("cmmnCodeNm","${msg.C100000222}","20%",true,true,groupGridColPros); /* 그룹 코드명 */
	columnLayout.groupCode.addColumnCustom("cmmnCode","${msg.C100000221}", "15%", true,true); /* 그룹 코드 */
	columnLayout.groupCode.addColumnCustom("cmmnCodeRm","${msg.C100000904}","30%",true,true); /* 코드설명 */
	columnLayout.groupCode.addColumnCustom("updtPosblAt","${msg.C100001104}","10%",true,true,groupGridColPros); /* 수정 가능 여부 */
	columnLayout.groupCode.addColumnCustom("useAt","${msg.C100000443}","10%",true,true,groupGridColPros); /* 사용여부 */
	columnLayout.groupCode.addColumnCustom("scrinUseAt","${msg.C000000389}","15%",false,true,groupGridColPros); /* 화면사용여부 */
	columnLayout.groupCode.addColumnCustom("sortOrdr","${msg.C100000797}","10%",true,true,groupGridColPros); /* 정렬순서 */
	columnLayout.groupCode.addColumnCustom("tmprField1Nm","${msg.C100000689}1", "15%", true, true); /* 임시필드값1 */
	columnLayout.groupCode.addColumnCustom("tmprField2Nm","${msg.C100000689}2", "15%", true, true);	/* 임시필드값2 */
	columnLayout.groupCode.addColumnCustom("tmprField3Nm","${msg.C100000689}3", "15%", true, true); /* 임시필드값3 */
	columnLayout.groupCode.addColumnCustom("tmprField4Nm","${msg.C100000689}4", "15%", true, true); /* 임시필드값4 */
	columnLayout.groupCode.addColumnCustom("tmprField5Nm","${msg.C100000689}5", "15%", true, true);	/* 임시필드값5 */
	columnLayout.groupCode.addColumnCustom("lastChangerId","${msg.C000000834}","15%",false); /* 변경자ID */
	columnLayout.groupCode.addColumnCustom("lastChangeDt","${msg.C000000232}","17%",false); /* 최종변경일 */
	columnLayout.groupCode.addColumnCustom("gbnCrud","CRUD 구분","8%",false,false);
	columnLayout.groupCode.dropDownListRenderer(["updtPosblAt"],["Y","N"],null);
	columnLayout.groupCode.dropDownListRenderer(["useAt"],["Y","N"],null);
	columnLayout.groupCode.dropDownListRenderer(["scrinUseAt"],["Y","N"],null);
	columnLayout.groupCode.inputEditRenderer(["cmmnCode","cmmnCodeNm","cmmnCodeRm","tmprField1Nm"]);
	columnLayout.groupCode.addValidator(["cmmnCode","cmmnCodeNm","sortOrdr"], "NotEmpty");
	columnLayout.groupCode.addValidator(["gbnCrud", "cmmnCode"], "NotChange");
	columnLayout.groupCode.addValidator(["cmmnCode"], "Length", 4);
	columnLayout.groupCode.addValidator(["cmmnCode"], "UpperCase");

	//상세코드 그리드 정의
	auigridCol(columnLayout.detailCode);
	//컬럼 속성 정의
	var detailGridColPros = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
		}
	};
	columnLayout.detailCode.addColumnCustom("cmmnCodeNm","${msg.C100000469}","10%",true,true,detailGridColPros); /* 상세 코드명 */
	columnLayout.detailCode.addColumnCustom("upperCmmnCode","${msg.C000000393}", "10%", false, false); /* 상위코드 */
	columnLayout.detailCode.addColumnCustom("cmmnCode","${msg.C100000470}", "10%", true, false); /* 상세코드 */
	columnLayout.detailCode.addColumnCustom("cmmnCodeRm","${msg.C100000904}","10%",true,true); /* 코드설명 */
	columnLayout.detailCode.addColumnCustom("uodtPosblAt","${msg.C100001104}","5%",false); /* 수정가능여부 */
	columnLayout.detailCode.addColumnCustom("useAt","${msg.C100000443}","5%",true,detailGridColPros); /* 사용여부 */
	columnLayout.detailCode.addColumnCustom("scrinUseAt","${msg.C000000389}","10%",false,true,detailGridColPros); /* 화면사용여부 */
	columnLayout.detailCode.addColumnCustom("sortOrdr","${msg.C100000797}","5%",true,true,detailGridColPros); /* 정렬순서 */
	columnLayout.detailCode.addColumnCustom("tmprField1Value","${msg.C100000689}1", "15%", true, true); /* 임시필드값1 */
	columnLayout.detailCode.addColumnCustom("tmprField2Value","${msg.C100000689}2", "15%", true, true); /* 임시필드값2 */
	columnLayout.detailCode.addColumnCustom("tmprField3Value","${msg.C100000689}3", "15%", true, true); /* 임시필드값3 */
	columnLayout.detailCode.addColumnCustom("tmprField4Value","${msg.C100000689}4", "15%", true, true); /* 임시필드값4 */
	columnLayout.detailCode.addColumnCustom("tmprField5Value","${msg.C100000689}5", "15%", true, true); /* 임시필드값5 */
	columnLayout.detailCode.addColumnCustom("lastChangerId","${msg.C000000834}","10%",false); /* 변경자ID */
	columnLayout.detailCode.addColumnCustom("lastChangeDt","${msg.C000000232}","12%",false); /* 최종변경일 */
	columnLayout.detailCode.addColumnCustom("upperCmmnCode","상위코드","8%",false,false);
	columnLayout.detailCode.addColumnCustom("gbnCrud","CRUD 구분","8%",false,false);
	columnLayout.detailCode.dropDownListRenderer(["useAt"],["Y","N"],null);
	columnLayout.detailCode.dropDownListRenderer(["scrinUseAt"],["Y","N"],null);
	columnLayout.detailCode.inputEditRenderer(["cmmnCodeNm","cmmnCodeRm","tmprField1Value","sortOrdr"]);
	columnLayout.detailCode.addValidator(["cmmnCodeNm","sortOrdr"], "NotEmpty");
	columnLayout.detailCode.addValidator(["gbnCrud", "cmmnCode"], "NotChange");

	groupGridID = createAUIGrid(columnLayout.groupCode,groupCode);//그리드 생성
	detailGridID = createAUIGrid(columnLayout.detailCode,detailCode);
}


////AUI 그리드 이벤트 함수////
function auiGridEvent(){

	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(groupGridID, "ready", function(event) {
		gridColResize(groupGridID, "2");
	});

	AUIGrid.bind(detailGridID, "ready", function(event) {
		gridColResize(detailGridID, "2");
	});

   	//그룹코드 그리드 셀 클릭 이벤트
   	AUIGrid.bind(groupGridID, "cellDoubleClick", function(event) {
		cmmnCode = event.item.cmmnCode;

		$("#cmmnCode").val(cmmnCode);

		//행 추가시에는 실행 X
		if($("#cmmnCode").val() != null && $.trim($("#cmmnCode").val()) != ""){
	 		ajaxJsonForm('<c:url value="/sys/getCmmnCodeMDetailList.lims"/>', "cmmnForm", function(data){
				AUIGrid.setGridData('#'+detailCode, data);
		   	});

	 		showDetailBtn();
	    }
   	});

    //그룹코드 에디트모드 진입가능 여부 처리
	AUIGrid.bind(groupGridID, "cellEditBegin", function(event) {

		// 그룹코드 수정 방지
		if(event.dataField == "cmmnCode") {
		  var sCrud = AUIGrid.getCellValue(groupGridID, event.rowIndex, "gbnCrud");

		  if(sCrud == "C") {
		        return true;
		    } else {
		        return false;
		    }
		}

		if(event.item.updtPosblAt == "Y") {  // 수정가능여부 'Y' => 모든 사용자가 데이터 수정 가능
			return true;
		}else {
			// 수정가능여부 'N' => 시스템 관리자가 아니면 데이터 수정 방지
			if('${UserMVo.authorSeCode}' != 'SY09000001') {
				return false;
			}else {
				return true;
			}
		}
		
	});

	//상세코드 에디트모드 진입가능 여부 처리
	AUIGrid.bind(detailGridID, "cellEditBegin", function(event) {
		if(event.dataField == "cmmnCode") {
		  var sCrud = AUIGrid.getCellValue(detailGridID, event.rowIndex, "gbnCrud");

		  if(sCrud == "C") {
		        return false; // 상세코드 자동생성 수정 불가 설정
		    } else {
		        return false;
		    }
		}
		
		if('${UserMVo.authorSeCode}' != 'SY09000001') {
			var groupGridData = AUIGrid.getGridData(groupGridID);

			for(var i=0; i < groupGridData.length; i++) {
				// event 발생한 상세코드의 상위코드로 그룹코드 그리드의 수정가능여부 판단
				if(groupGridData[i].cmmnCode == event.item.upperCmmnCode) {
					if(groupGridData[i].updtPosblAt == 'N') {
						return false;
					}else {
						return true;
					}
				}
			}
		}else {
			return true;
		}

	});

 	//그룹코드 CRUD 체크, 중복체크
	AUIGrid.bind(groupGridID, "cellEditEnd", function(event){
		var myValue = AUIGrid.getCellValue(groupGridID, event.rowIndex, "gbnCrud");
		var columnValue = AUIGrid.getCellValue(groupGridID, event.rowIndex, "cmmnCode");
			if(myValue != "C"){
				item = { gbnCrud : "U" };
	   			AUIGrid.updateRow(groupGridID, item, "selectedIndex");
			}

			if(myValue == "C"){
				confirmCodeMGbnList(columnValue, event.rowIndex); // 중복체크 함수 호출
			}


 		return event.value;
 	});

 	//상세코드 CRUD 체크
	AUIGrid.bind(detailGridID, "cellEditEnd", function(event){

		var myValue = AUIGrid.getCellValue(detailGridID, event.rowIndex, "gbnCrud")

		if(myValue != "C"){
			item = { gbnCrud : "U" };
   			AUIGrid.updateRow(detailGridID, item, "selectedIndex");
   			AUIGrid.setCellValue(detailGridID, event.rowIndex, "gbnCrud", "U");
		}

 		return event.value;
 	});

	function toggleEditMode() {
		var editBeginMode = AUIGrid.getProp(groupGridID, "editBeginMode");

		if(editBeginMode == "doubleClick") {
			AUIGrid.setProp(groupGridID, "editBeginMode", "click");
		}
		else {
			AUIGrid.setProp(groupGridID, "editBeginMode", "doubleClick");
		}
	};

	/*  그룹코드 그리드 행 삭제 변수값 할당 */
	AUIGrid.bind(groupGridID, "selectionChange", function( event ) {
		thisRowCrud = AUIGrid.getCellValue(groupGridID, event.primeCell.rowIndex, "gbnCrud");  /* 행삭제 구분값 */
		thisRowItems = event.primeCell.rowIdValue== undefined ? event.primeCell.null : event.primeCell.rowIdValue; /* 현재 선택._$uid */
	});

	/* 상세코드 그리드 행 삭제 변수값 할당*/
	AUIGrid.bind(detailGridID, "selectionChange", function( event ) {
		thisDetailRowCrud = AUIGrid.getCellValue(detailGridID, event.primeCell.rowIndex, "gbnCrud");  /* 행삭제 구분값 */
		thisDetailRowItems = event.primeCell.rowIdValue== undefined ? event.primeCell.null : event.primeCell.rowIdValue; /* 현재 선택._$uid */

	});

	// 그리드 행삭제 이벤트 (그룹, 상세 그리드 공통 삭제 이벤트)
	function gridRmRowEvent(gridID, rowItems, addedItems){ // 그리드ID, 현재선택._$uid
		for(var i in addedItems){
			switch (rowItems){
			case addedItems[i]._$uid :
				AUIGrid.removeRow(gridID, "selectedIndex"); // 행 삭제
				return true;
			case addedItems[i].null : /* 조회를 안하고 행추가시 초기 _$uid 구분 컬럼이 null로 생성될 때 */
				AUIGrid.removeRow(gridID, "selectedIndex"); // 행 삭제
				return true;
			default :

	  		}

		}
	}

	// 그룹코드 그리드 행 삭제 버튼 클릭 이벤트
	$('#removeRowGroupCode').click(function(){ // 행삭제 클릭시
		var addedRowItems = AUIGrid.getAddedRowItems(groupGridID); // 추가된._$uid
		 if(thisRowCrud == 'C'){ // 새로 만들어진 행이라면
			gridRmRowEvent(groupGridID, thisRowItems, addedRowItems);	//행 삭제 함수 호출

		}else if(thisRowCrud == null && thisRowCrud != "C") {
			warn('${msg.C100000444}'); /* 사용여부를 N으로 저장해주세요 */
			return thisRowCrud = "";
		}
	});

	// 상세코드 행삭제 버튼 클릭 이벤트
	$('#removeRowDetailCode').click(function(){
		if('${UserMVo.authorSeCode}' != 'SY09000001') {
			var upperCode = AUIGrid.getOrgGridData(detailGridID)[0].upperCmmnCode;
			var groupGridData = AUIGrid.getGridData(groupGridID);
			var updtPosblAt;

			for(var i=0; i < groupGridData.length; i++) {
				if(groupGridData[i].cmmnCode == upperCode) {
					updtPosblAt = groupGridData[i].updtPosblAt;
					break;
				}
			}

			if(updtPosblAt == "N") {
				warn("${msg.C100001105}")  /* 수정 권한이 없습니다. 관리자에게 문의하세요. */
				return;
			}
		}

		var addedRowItems = AUIGrid.getAddedRowItems(detailGridID); // 추가된._$uid

		if(thisDetailRowCrud == 'C'){ // 새로 만들어진 행이라면
			 gridRmRowEvent(detailGridID, thisDetailRowItems, addedRowItems);	//행 삭제 함수 호출
		}else if(thisDetailRowCrud == null || thisDetailRowCrud != "C") {
			warn('${msg.C100000444}'); /* 사용여부를 N으로 저장해주세요 */
			return thisDetailRowCrud = '';
		}
	});
}

//버튼 이벤트
function setButtonEvent(){
	// 그룹코드 그리드값 유효성 검사
	$("#saveButton").click(function() {
		groupSaveEvntValid();
	});

	//상세코드 그리드값 유효성 검사
	$('#insertDetailCode').click(function(){
		if('${UserMVo.authorSeCode}' != 'SY09000001') {
			var upperCode = AUIGrid.getOrgGridData(detailGridID)[0].upperCmmnCode;
			var groupGridData = AUIGrid.getGridData(groupGridID);
			var updtPosblAt;

			for(var i=0; i < groupGridData.length; i++) {
				if(groupGridData[i].cmmnCode == upperCode) {
					updtPosblAt = groupGridData[i].updtPosblAt;
					break;
				}
			}

			if(updtPosblAt == "N") {
				warn("${msg.C100001105}")  /* 수정 권한이 없습니다. 관리자에게 문의하세요. */
				return;
			}
		}
		
		detailSaveEvntValid();
	});

	$("#selectGroupCode").bind("click",function(){
		getGroupCodeList();
		hideDetailBtn();
	});

	// 행추가 - 그룹코드
	$("#addrowGroupCode").click(function(){
		addRow(groupCode);
		hideDetailBtn();
		AUIGrid.clearGridData(detailGridID);
	});

	// 행추가 - 상세코드
	$("#addrowDetailCode").click(function(){
		if('${UserMVo.authorSeCode}' != 'SY09000001') {
			var upperCode = AUIGrid.getOrgGridData(detailGridID)[0].upperCmmnCode;
			var groupGridData = AUIGrid.getGridData(groupGridID);
			var updtPosblAt;

			for(var i=0; i < groupGridData.length; i++) {
				if(groupGridData[i].cmmnCode == upperCode) {
					updtPosblAt = groupGridData[i].updtPosblAt;
					break;
				}
			}

			if(updtPosblAt == "N") {
				warn("${msg.C100001105}")  /* 수정 권한이 없습니다. 관리자에게 문의하세요. */
				return;
			}
		}

		addRow(detailCode);
	});
}


/*############ 조회, 저장, 삭제 함수 ############*/

//상세코드 목록
function getDetailCodeList(){
	getGridDataForm("<c:url value='/sys/getCmmnCodeMDetailList.lims'/>", "cmmnForm", detailCode);
}

//그룹코드 목록
function getGroupCodeList(){
	getGridDataForm("<c:url value='/sys/getCmmnCodeMList.lims'/>" ,"cmmnForm", groupCode );
}

//그룹 코드 중복확인
function confirmCodeMGbnList(columnValue, rowIndex){
	var confirmUrl = "<c:url value='/sys/confirmCmmnCodeMGbnList.lims'/>";
	var addedRowItems = {
			"cmmnCode" : columnValue
	}

	if (addedRowItems != null) {
		customAjax({"url":confirmUrl,"data":addedRowItems,"successFunc":function(data){
			if (data != 0){
				warn("${msg.C100000838}"); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
				AUIGrid.setCellValue(groupGridID, rowIndex, "cmmnCode");
			}
		}
	    });
	}
}

//그룹 코드 저장 및 수정
function saveGroupData() {
	var insertUrl = "<c:url value='/sys/putCmmnCodeM.lims'/>";
	var addedRowItems = AUIGrid.getGridData(groupGridID);

	// 추가된 데이터 체크해서 전송
	if (addedRowItems != null) {
		customAjax({"url":insertUrl,"data":addedRowItems,"successFunc":function(data){
				if(data > 0) {
					success("${msg.C100000765}"); /* 저장 되었습니다. */
					getGroupCodeList();
					hideDetailBtn();
				}else {
					err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
				}
			}
		});
	}
};

//상세 코드 저장 및 수정
function saveDetailData() {
	var insertUrl = "<c:url value='/sys/putCmmnCodeMDetail.lims'/>";
	var addedRowItems = AUIGrid.getGridData(detailGridID);

	// 추가된 데이터 체크해서 전송
	if (addedRowItems != null) {
		customAjax({
			"url":insertUrl,
			"data":addedRowItems,
			"successFunc":function(data){
				if(data > 0) {
					success("${msg.C100000765}"); /* 저장 되었습니다. */
					getDetailCodeList();
				}else {
					err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
				}
			}
		});
	}
}

/*############ 기타이벤트 함수 ############*/

// 그룹코드 그리드 수정된 값 없을 때 event 방지
function groupSaveEvntValid() {
	var gridData = AUIGrid.getGridData(groupGridID);
	var cnt = 0;

	if(gridData.length == 0) {
		return;
	}

	for(var i=0; i < gridData.length; i++) {
		if(gridData[i].gbnCrud == "C") {
			cnt++;
		}else if(gridData[i].gbnCrud == "U") {
			cnt++;
		}
	}

	if(cnt > 0) {
		saveValidation();
	}else {
		alert("${msg.C100001106}");  /* 수정된 내역이 없습니다. */
		return;
	}
}

// 그룹상세코드 그리드 수정된 값 없을 때 event 방지
function detailSaveEvntValid() {
	var gridData = AUIGrid.getGridData(detailGridID);
	var cnt = 0;

	if(gridData.length == 0) {
		return;
	}

	for(var i=0; i < gridData.length; i++) {
		if(gridData[i].gbnCrud == "C") {
			cnt++;
		}else if(gridData[i].gbnCrud == "U") {
			cnt++;
		}
	}

	if(cnt > 0) {
		saveDetailValidation();
	}else {
		alert("${msg.C100001106}");  /* 수정된 내역이 없습니다. */
		return;
	}
}

//그룹코드 그리드값 유효성 검사
function saveValidation(){
	// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
	var groupGridData = AUIGrid.getGridData(groupGridID);
	var item;
	var invalid = false;
	var invalidRowIndex = -1;
	var colIndex;

	for(var i=0, len=groupGridData.length; i<len; i++) {
		item = groupGridData[i];

		// 칼럼의 값이 입력 안됐는지 체크
		if(typeof item["cmmnCodeNm"] == "undefined" || String(item["cmmnCodeNm"]).trim() == ""){
			invalidRowIndex = i;
			invalid = true;
			colIndex = AUIGrid.getColumnIndexByDataField(groupGridID, "cmmnCodeNm");

			break;
		} else if(typeof item["cmmnCode"] == "undefined" || String(item["cmmnCode"]).trim() == "") {
			invalidRowIndex = i;
			invalid = true;
			colIndex = AUIGrid.getColumnIndexByDataField(groupGridID, "cmmnCode");

			break;
		}
	}

	if(invalid) {
		// 필수 칼럼의 값이 없어서 예외 처리하기
		warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
		// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
		AUIGrid.setSelectionByIndex(groupGridID, invalidRowIndex, colIndex);
	} else {
		// 실질적인 저장 로직 처리
		saveGroupData();
	}
}

//상세코드 그리드값 유효성 검사
function saveDetailValidation(){
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var detailGridData = AUIGrid.getGridData(detailGridID);
		var item;
		var invalid = false;
		var invalidRowIndex = -1;
		var colIndex;

		for(var i=0, len=detailGridData.length; i<len; i++) {
			item = detailGridData[i];

			// 칼럼의 값이 입력 안됐는지 체크
			if(typeof item["cmmnCodeNm"] == "undefined" || String(item["cmmnCodeNm"]).trim() == ""){
				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(detailGridID, "cmmnCodeNm");
				break;
			}
		}

		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(detailGridID, invalidRowIndex, colIndex);
		}else {
			// 실질적인 저장 로직 처리
			saveDetailData();
		}
}

//그룹 및 상세 코드 그리드 '신규'버튼 클릭 시 가장 아래 행 밑에 새로운 입력 행 추가
function addRow(gridId){
	var item = new Object();

	if("groupCode" == gridId){
    	item.searchCode = "",
    	item.cmmnCode = "",
    	item.useAt = "Y",
    	item.scrinUseAt = "Y",
    	item.sortOrdr = "0",
    	item.gbnCrud = "C" // insert 구분값
	 	AUIGrid.addRow(groupGridID, item, "last");

   	}else if("detailCode" == gridId){
   		item.searchUpCode = "",
   		item.cmmnCode = "",
   		item.useAt = "Y",
    	item.scrinUseAt = "Y",
    	item.sortOrdr = "0",
    	item.gbnCrud = "C" // insert 구분값
   		item.upperCmmnCode = cmmnCode, // 상위코드를 안보이는 컬럼에 저장 -> 저장 버튼 클릭시 vo에 값 할당.
 	 	AUIGrid.addRow(detailGridID, item, "last");

   	}
}

function hideDetailBtn(){
	$("#addrowDetailCode").hide();
	$("#removeRowDetailCode").hide();
	$("#insertDetailCode").hide();
}

function showDetailBtn(){
	$("#addrowDetailCode").show();
	$("#removeRowDetailCode").show();
	$("#insertDetailCode").show();
}

//엔터키 이벤트
function doSearch(e){
	getGroupCodeList();
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>