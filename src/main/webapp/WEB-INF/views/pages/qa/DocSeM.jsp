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
		<h2><i class="fi-rr-apps"></i>${msg.C100000997}</h2> <!-- 문서구분 목록 -->
			<div class="btnWrap">
				<button  id="addrowGroupCode" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
				<button  id="removeRowGroupCode" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
				<button  id="saveButton" class="save">${msg.C100000760}</button> <!-- 저장 -->
				<button  id="selectGroupCode" class="search" >${msg.C100000767}</button> <!-- 조회 -->
			</div>
		<form action="javascript:;" id="docSeForm" name="docSeForm">
			<input type="hidden" name="docSeSeqno" id="docSeSeqno"/>
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:65%"></col>
				</colgroup>
				<tr>
					<th >${msg.C100000319}</th> <!-- 문서 구분 코드 명 -->
					<td ><input type="text"  id="docSeNmSch" name="docSeNmSch" class="schClass"></td>
					<th >${msg.C100000443}</th> <!-- 사용여부 -->
					<td ><input name="useAtSch" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
					<input name="useAtSch" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
			        <input name="useAtSch" value="N" type="radio">${msg.C100000442}</td> <!-- 사용안함 -->
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2" >
		<div id="groupCode"></div>
	</div>
	<br>
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000318}</h2> <!-- 그룹상세코드 목록 -->
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
var docSeSeqno;//groupCode의 Pk키를 담을 변수
var docSeForm = "docSeForm";
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
		columnLayout.groupCode.addColumnCustom("docSeNm","${msg.C100000319}","*",true,true,groupGridColPros); /* 그룹 코드명 */
		columnLayout.groupCode.addColumnCustom("docSeCode","문서 구분 코드", "*", false,true); /* 그룹 코드 */
		columnLayout.groupCode.addColumnCustom("sortOrdr","${msg.C100000797}", "*", true,true); /* 정렬 순서 */
		columnLayout.groupCode.addColumnCustom("useAt","${msg.C100000443}","*",true,true); /* 사용여부 */
		columnLayout.groupCode.addColumnCustom("deleteAt","삭제여부","*",false,true,groupGridColPros); /* 삭제여부 */
		columnLayout.groupCode.addColumnCustom("docSeqno","일련번호","*",false,true); /* 문서 일련번호 */
		columnLayout.groupCode.addColumnCustom("gbnCrud","CRUD 구분","*",false,false);
// 		columnLayout.groupCode.dropDownListRenderer(["useAt"],["Y","N"],null);
		columnLayout.groupCode.checkBoxRenderer([ "useAt" ], groupCode,{ check : "Y", unCheck : "N"})
		
		groupGridID = createAUIGrid(columnLayout.groupCode,groupCode);//그리드 생성
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
		columnLayout.detailCode.addColumnCustom("docSeDetailNm","${msg.C100000317}","*",true,true,detailGridColPros); /* 상세 코드명 */
		columnLayout.detailCode.addColumnCustom("wdtbEstbsAt","${msg.C100000369}","*",true,true); /* 배포설정여부 */
		columnLayout.detailCode.addColumnCustom("mtrilChoiseEssntlAt","${msg.C100000719}","*",true,true); /* 자재선택필수여부 */
		columnLayout.detailCode.addColumnCustom("entrpsChoiseEssntlAt","${msg.C100000590}","*",true,true); /* 업체선택필수여부 */
		columnLayout.detailCode.addColumnCustom("sortOrdr","${msg.C100000797}", "*", true,true); /* 정렬 순서 */
		columnLayout.detailCode.addColumnCustom("useAt","${msg.C100000443}","*",true,true); /* 사용여부 */
		columnLayout.detailCode.addColumnCustom("docSeDetailSeqno","상위코드","*",false,false);
		columnLayout.detailCode.addColumnCustom("gbnCrud","CRUD 구분","*",false,false);
		columnLayout.detailCode.checkBoxRenderer([ "useAt" ], detailCode,{ check : "Y", unCheck : "N"})
		columnLayout.detailCode.checkBoxRenderer([ "wdtbEstbsAt" ], detailCode,{ check : "Y", unCheck : "N"})
		columnLayout.detailCode.checkBoxRenderer([ "mtrilChoiseEssntlAt" ], detailCode,{ check : "Y", unCheck : "N"})
		columnLayout.detailCode.checkBoxRenderer([ "entrpsChoiseEssntlAt" ], detailCode,{ check : "Y", unCheck : "N"})
	// 	columnLayout.detailCode.inputEditRenderer(["cmmnCodeNm","cmmnCodeRm","tmprField1Value","sortOrdr"]);
	// 	columnLayout.detailCode.addValidator(["cmmnCodeNm","sortOrdr"], "NotEmpty");
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
   		docSeSeqno = event.item.docSeSeqno;
   		
		detailAutoSet({
			item : event.item,
			targetFormArr:["docSeForm"]
		});
		$("#docSeSeqno").val(event.item.docSeSeqno)
		if(!!docSeSeqno){
			//행 추가시에는 실행 X
	 		ajaxJsonForm('<c:url value="/qa/getDocSeMDetailList.lims"/>', "docSeForm", function(data){
				AUIGrid.setGridData('#'+detailCode, data);
		   	});	
		}
   	});

    //그룹코드 에디트모드 진입가능 여부 처리
	AUIGrid.bind(groupGridID, "cellEditBegin", function(event) {
		if(event.dataField == "cmmnCode") {
		  // 추가여부 확인
		  var sCrud = AUIGrid.getCellValue(groupGridID, event.rowIndex, "gbnCrud");
		  if(sCrud == "C") {
		        return true;
		    } else {
		        return false;
		    }
		}
		return true; // 다른 필드들은 편집 허용
	});

	//상세코드 에디트모드 진입가능 여부 처리
	AUIGrid.bind(detailGridID, "cellEditBegin", function(event) {
		if(event.dataField == "cmmnCode") {
		  // 추가여부 확인
		  var sCrud = AUIGrid.getCellValue(detailGridID, event.rowIndex, "gbnCrud");
		  if(sCrud == "C") {
		        return false; // 상세코드 자동생성 수정 불가 설정
		    } else {
		        return false;
		    }
		}
		return true; // 다른 필드들은 편집 허용
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
// 				confirmCodeMGbnList(columnValue, event.rowIndex); // 중복체크 함수 호출
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
}

//버튼 이벤트
function setButtonEvent(){
	// 그룹코드 그리드값 유효성 검사
	$("#saveButton").click(function() {
		saveValidation();
	});

	//상세코드 그리드값 유효성 검사
	$('#insertDetailCode').click(function(){
		saveDetailValidation();
	});

	// 조회 event
	$("#selectGroupCode").bind("click",function(){
		getGroupCodeList();
	});

	// 행추가 - 그룹코드
	$("#addrowGroupCode").click(function(){
		addRow(groupCode);
	});

	// 행추가 - 상세코드
	$("#addrowDetailCode").click(function(){
		addRow(detailCode);
	});
	
	// 그룹코드 그리드 행 삭제 버튼 클릭 이벤트
	$('#removeRowGroupCode').click(function(){ 
		AUIGrid.removeRow(groupGridID, "selectedIndex");
	});

	// 상세코드 행삭제 버튼 클릭 이벤트
	$('#removeRowDetailCode').click(function(){
		AUIGrid.removeRow(detailGridID, "selectedIndex");
	});
}


/*############ 조회, 저장, 삭제 함수 ############*/

//상세코드 목록
function getDetailCodeList(){
	getGridDataForm("<c:url value='/qa/getDocSeMDetailList.lims'/>", "docSeForm", detailCode);
}

//그룹코드 목록
function getGroupCodeList(){
	getGridDataForm("<c:url value='/qa/getDocSeMList.lims'/>" ,"docSeForm", groupCode );
}

//그룹 코드 중복확인
function confirmCodeMGbnList(columnValue, rowIndex){
	var confirmUrl = "<c:url value='/qa/confirmCmmnCodeMGbnList.lims'/>";
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
	var insertUrl = "<c:url value='/qa/putDocSeM.lims'/>";
	var obj = getFormParam(docSeForm);
	var addedRowList= AUIGrid.getGridData('#groupCode');
	obj.addedRowList = addedRowList
	obj.removedRowList = AUIGrid.getRemovedItems('#groupCode');

	if (addedRowList != null) {
	// 추가된 데이터 체크해서 전송
		customAjax({"url":insertUrl, "data":obj, "successFunc":function(data){
				if (data != 1){
					err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
				} else {
					success("${msg.C100000762}"); /* 저장 되었습니다. */
					getGroupCodeList()
				}
			}
		});
	}
};

//상세 코드 저장 및 수정
function saveDetailData() {
	var insertUrl = "<c:url value='/qa/putDocSeMDetail.lims'/>";
	var obj = getFormParam(docSeForm);
	var addedRowList= AUIGrid.getGridData(detailGridID);
	obj.addedRowList = addedRowList
	obj.removedRowList = AUIGrid.getRemovedItems(detailGridID);
	// 추가된 데이터 체크해서 전송
	if (addedRowList != null) {
		customAjax({"url":insertUrl,"data":obj,"successFunc":function(data){
				if (data != 1){
					err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
				} else {
					success("${msg.C100000762}"); /* 저장 되었습니다. */
					getDetailCodeList();
				}
			}
		});
	}
}

/*############ 기타이벤트 함수 ############*/

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
		if(typeof item["docSeNm"] == "undefined" || String(item["docSeNm"]).trim() == ""){
			invalidRowIndex = i;
			invalid = true;
			colIndex = AUIGrid.getColumnIndexByDataField(groupGridID, "docSeNm");

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
			if(typeof item["docSeDetailNm"] == "undefined" || String(item["docSeDetailNm"]).trim() == ""){
				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(detailGridID, "docSeDetailNm");
				break;
			}
		}

		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(detailGridID, invalidRowIndex, colIndex);
		} else {
			// 실질적인 저장 로직 처리
			saveDetailData();
		}
}

//그룹 및 상세 코드 그리드 '신규'버튼 클릭 시 가장 아래 행 밑에 새로운 입력 행 추가
function addRow(gridId){
	var item = new Object();
	var topLength = AUIGrid.getGridData("#"+gridId).length;

	if("groupCode" == gridId){
    	item.docSeCode = "RS17000001",
    	item.useAt = "Y",
    	item.deleteAt = "N",
    	item.gbnCrud = "C"
    	item.sortOrdr = topLength+1;
	 	AUIGrid.addRow(groupGridID, item, "last");

   	}else if("detailCode" == gridId){
   		if(!$("#docSeSeqno").val()){
   			warn("${msg.C100000998}");  /* 문서구분코드를 먼저 저장해 주세요. */
   			return false;
   		}else{
   			item.useAt = "Y",
   	   		item.docSeSeqno = $("#docSeSeqno").val();
   	    	item.deleteAt = "N",
   	    	item.gbnCrud = "C",
			item.wdtbEstbsAt = "N",
			item.mtrilChoiseEssntlAt = "N",
			item.entrpsChoiseEssntlAt = "N",
			item.sortOrdr = topLength+1;
   	 	 	AUIGrid.addRow(detailGridID, item, "last");	
   		}
   	}
}

//엔터키 이벤트
function doSearch(e){
	getGroupCodeList();
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>