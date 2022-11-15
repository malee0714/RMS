<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">SPEC</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
var dvyfgEntrpsList; //납품업체 그리드
var lang = ${msg}; // 기본언어

$(function(){
	getAuth();
	
	//초기화
	init();
	
	//콤보 박스 초기화
	setCombo();
	
	//검교정 목록 그리드 생성
	setDvyfgEntrpsGrid();
	
	//그리드 이벤트
	setGridEvent();
	
	//버튼 이벤트 선언
	setButtonEvent();
});

function init(){
	
}

function setCombo(){
	//납품 업체 구분 코드
	ajaxJsonComboBox('/com/getCmmnCode.lims','dvyfgEntrpsSeCode',{"upperCmmnCode" : "SY17"}, false,"${msg.C000000079}"); /* 선택 */
	
}

//제품 목록 그리드 생성
function setDvyfgEntrpsGrid(){
	
	var col = [];
	
	auigridCol(col);
	
	col.addColumnCustom("dlivyDvyfgEntrpsSeqno", "${msg.C000000852}", "*", false, false); /* 출고납품업체 일련번호 */
	col.addColumnCustom("dvyfgEntrpsSeCode", "${msg.C000000853}", "*", true, false); /* 납품업체 구분코드 */
	col.addColumnCustom("dvyfgEntrpsSeNm", "${msg.C000000854}", "*", true, false); /* 납품업체 구분코드명 */
	col.addColumnCustom("dvyfgEntrpsCode", "${msg.C000000855}", "*", true, false); //업체 자재코드
	col.addColumnCustom("dvyfgEntrpsNm", "${msg.C000000856}", "*", true, false); /* 납품업체명 */
	col.addColumnCustom("deleteAt", "${msg.C000000065}", "*", false, false); /* 사용여부 */
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			wordWrap : true
 	}	
	
	
	//auiGrid 생성
	dvyfgEntrpsList = createAUIGrid(col, "dvyfgEntrpsList", cusPros);
	// 그리드 리사이즈.
	gridResize([dvyfgEntrpsList]);
	// 그리드 칼럼 리사이즈
	
	AUIGrid.bind(dvyfgEntrpsList, "ready", function(event) {
		gridColResize([dvyfgEntrpsList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//그리드 이벤트
function setGridEvent(){
	AUIGrid.bind(dvyfgEntrpsList, "cellDoubleClick", function(event) {		
		gridDataSet("dvyfgEntrpsForm", "input, select, textarea", event["item"],function(){});
		$("#crud").val("U");
	});
}

//버튼 이벤트
function setButtonEvent(){
	
	//신규버튼 클릭
	$("#btn_new").click(function(){
		$("#crud").val("C");
		
		$("#dvyfgEntrpsForm")[0].reset();
		$("#dlivyDvyfgEntrpsSeqno").val("");
		
	});
	
	//저장버튼 클릭 이벤트
	$("#btn_save").click(function(){
		
		if(!formNecessaryValidationCheck("dvyfgEntrpsForm")){
			return false;
		}
				
		ajaxJsonForm("<c:url value='/sys/saveDvyfgEntrpsM.lims'/>", "dvyfgEntrpsForm", function (data) {
			if(data > 0){				
				alert("${msg.C000000071}"); /* 저장되었습니다. */
				$("#crud").val("C");
				$("#dvyfgEntrpsForm")[0].reset();
				$("#dlivyDvyfgEntrpsSeqno").val("");
				searchDvyfgEntrpsList();
			}
			else{
				alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
			}
		});
	});
	
	
	//조회 버튼 클릭 이벤트
	$("#btn_select").click(function(){
		searchDvyfgEntrpsList();
	});
	
	$("[id^=shr]").keyup(function(e){
		searchDvyfgEntrpsList(e.keyCode);
	});
	
	//삭제 버튼 클릭 이벤트
	$("#btn_delete").click(function(){
		$("#crud").val("D");
		ajaxJsonForm("<c:url value='/sys/saveDvyfgEntrpsM.lims'/>", "dvyfgEntrpsForm", function (data) {
			if(data > 0){				
				alert("${msg.C000000179}"); /* 삭제되었습니다. */
				$("#crud").val("C");				
				$("#dvyfgEntrpsForm")[0].reset();
				$("#dlivyDvyfgEntrpsSeqno").val("");
				searchDvyfgEntrpsList();
			}
			else{
				alert("${msg.C000000769}"); /* 삭제를 실패 하였습니다. */
			}
		});
	});
	
	//업로드
	$("#btn_form_upload").click(function(){
		
		var file = $("#formFile")[0];
		
		//파일 없으면 리턴
		if(!file.files[0].name){
			return;
		}
		
		
		if(!confirm("${msg.C000000718}")){ //업로드 하시겠습니까?
			return;
		}
		
		var fileName = file.files[0].name;
		var fileExt = fileName.substring(fileName.length, fileName.length-4);
		
				
		var formData = new FormData();
		formData.append("formFile", $("#formFile")[0].files[0]);
		formData.append("formType", $("#formType").val());
		
		ajaxJsonFormFile("/sys/uploadDvyfgEntrpsExcel.lims", formData, function(data){
			//AUIGrid.addRow(mhrlsUnInspctList, data, 0);
			if(data["result"] == true){
				alert(data["msg"]); /* 저장 되었습니다. */
				searchBarcodeList();
				AUIGrid.clearGridData(brcdListDetail);
			}
			else{
				alert(data["msg"]);  /* 저장에 실패하였습니다. */
			}
		}, null, null);
	});
}

//조회 함수
function searchDvyfgEntrpsList(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchDvyfgEntrpsList();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/sys/getDvyfgEntrpsM.lims'/>", "searchFrm", dvyfgEntrpsList);
		}
	}
}



</script>

</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000857}</h2> <!-- 납품업체목록-->
		<div class="btnWrap">		
			<button type="button" id="btn_select" class="search btn3">${msg.C000000002}</button><!-- 조회 -->
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
					<th>${msg.C000000855}</th> <!-- 업체자재코드 -->
					<td><input type="text" id="shrDvyfgEntrpsCode" name="shrDvyfgEntrpsCode"></td>
					<th>${msg.C000000856}</th> <!-- 납품업체명 -->
					<td><input type="text" id="shrDvyfgEntrpsNm" name="shrDvyfgEntrpsNm"></td>
				</tr>				
			</table>
		</form>
		<!-- 납품업체 그리드 -->
		<div id="dvyfgEntrpsList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
	</div>
	
	<form id="dvyfgEntrpsForm">		
		<div class="subCon1 mgT15">
			<input type="hidden" id="dlivyDvyfgEntrpsSeqno" name="dlivyDvyfgEntrpsSeqno">
			<input type="hidden" id="crud" name="crud" value="C">
			
			<h2 >${msg.C000000858}</h2><!-- 납품업체 정보 -->	
			<div class="btnWrap">
				<button type="button" id="btn_new" class="save btn3">${msg.C000000014}</button><!-- 신규 -->
				<button type="button" id="btn_delete" class="save btn1">${msg.C000000097}</button><!-- 삭제 -->			
				<button type="button" id="btn_save" class="save btn1">${msg.C000000015}</button><!-- 저장 -->
			</div>		
			<table style="width:100%;" class="mgT15">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:20%"></col>
					<col style="width:10%"></col>
					<col style="width:20%"></col>
					<col style="width:10%"></col>
					<col style="width:20%"></col>
				</colgroup>
				<tr>
					<th class="necessary">${msg.C000000853}</th> <!-- 납품업체 구분코드 -->
					<td><select id="dvyfgEntrpsSeCode" name="dvyfgEntrpsSeCode" class="wd100p"></select></td>
					<th class="necessary">${msg.C000000855}</th><!-- 업체 자재코드 -->
					<td><input type="text" id="dvyfgEntrpsCode" name="dvyfgEntrpsCode" class="wd100p" onkeyup="fnChkByte(this, '10')"></td>
					<th class="necessary">${msg.C000000856}</th> <!-- 납품업체명 -->
					<td><input type="text" id="dvyfgEntrpsNm" name="dvyfgEntrpsNm" class="wd100p" onkeyup="fnChkByte(this, '200')"></td>
				</tr>
				<tr>
					<th>${msg.C000000595}</th> <!-- 파일업로드 -->
					<td colspan="5" style="text-align:left;">
						<input type="file" id="formFile" name="formFile" class="wd30p" style="min-width:10em;">
						<button type="button" id="btn_form_upload" class="old_btn old_btn1 save">${msg.C000000859}</button> <!-- 업로드 -->
					</td>
				</tr>
			</table>
		</div>

		
	</form>
</div>
</tiles:putAttribute>
</tiles:insertDefinition>