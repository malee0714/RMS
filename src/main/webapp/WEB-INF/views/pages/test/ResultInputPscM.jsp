<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="script">
<script>
var roaGrid;
var resultGrid;

$(function(){
	//권한
	getAuth();
	
	//콤보 박스 초기화
	setCombo();
	
	//roa 여부 그리드 설정
	setRoaGrid();
	
	//결과 여부 그리드 설정
	setResultGrid();
	
	//버튼 이벤트
	setButtonEvent();
	
	
	gridResize([roaGrid, resultGrid]);
	
});

//콤보 박스 초기화
function setCombo(){
	//프로세스 타입
	ajaxJsonComboBox('/com/getCmmnCode.lims','paraType',{"upperCmmnCode" : "IM15"}, false, "${msg.C000000079}"); /* 선택 */	
	
}

//roa 여부 그리드 설정
function setRoaGrid(){
	
	var col = [];	
	
	auigridCol(col);
	
	col.addColumnCustom("lotId", "${msg.C000000575}", "*", true); /* LOT ID */
	col.addColumnCustom("msg", "${msg.C000001115}", "*", true); /* Error Msg */
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}	
	
	//auiGrid 생성
	roaGrid = createAUIGrid(col, "roaGrid", cusPros);
	
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(roaGrid, "ready", function(event) {
		gridColResize([roaGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//결과 여부 그리드 설정
function setResultGrid(){
	var col = [];	
	
	auigridCol(col);
	
	col.addColumnCustom("lotId", "${msg.C000000575}", "*", true); /* LOT ID */
	col.addColumnCustom("expriemNm", "${msg.C000000320}", "*", true); /* 시험항목 */
	col.addColumnCustom("Date", "${msg.C000000943}", "*", true); /* Date */
	col.addColumnCustom("result", "${msg.C000001116}", "*", true); /* Result */
	col.addColumnCustom("ErrorMsg", "${msg.C000001115}", "*", true); /* Error Msg */	
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}
	
	//auiGrid 생성
	resultGrid = createAUIGrid(col, "resultGrid", cusPros);
	
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(resultGrid, "ready", function(event) {
		gridColResize([resultGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//버튼 클릭 이벤트
function setButtonEvent(){
	//저장 버튼 클릭 이벤트
	$("#btnSave").click(function(){
		var file = $("#formFile")[0];
		
		if(!$("#paraType").val()){
			alert("${msg.C000001117}"); /* 분류를 선택해 주세요. */
			return;
		}
		
		//파일 없으면 리턴
		if(file.files.length == 0){
			alert("${msg.C000000434}"); /* 파일을 선택해주세요. */
			return;
		}		
		
		var fileName = file.files[0].name;
		var fileExt1 = fileName.substring(fileName.length, fileName.length-4);
		var fileExt2 = fileName.substring(fileName.length, fileName.length-3);
		
		if(fileExt1.toUpperCase() == "XLSX" || fileExt2.toUpperCase() == "XLS"){
			if(!confirm("${msg.C000000306}")){ //저장 하시겠습니까?
				return;
			}
			
			var formData = new FormData();
			formData.append("formFile", $("#formFile")[0].files[0]);
			formData.append("paraType", $("#paraType").val());
			
			showLoadingbar();
			ajaxJsonFormFile("/test/paraUpload.lims", formData, function(data){
				
				AUIGrid.setGridData(roaGrid, data["resultRoaList"]);
				AUIGrid.setGridData(resultGrid, data["resultValueList"]);
				alert("${msg.C000000071}"); /* 저장되었습니다. */
				hideLoadingbar();
			}, function(){
				alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
				hideLoadingbar();
			}, null);
		}
		else{
			alert("${msg.C000001022}"); /* xlsx, xls 확장자만 업로드 할 수 있습니다. */ 
			return;
		}
		
		
	});
	
	//취소 버튼
	$("#btnCancle").click(function(){		
		pageReset(["pscForm"], [roaGrid, resultGrid], null);
	});
}
</script>
</tiles:putAttribute>   
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		
		<h2>${msg.C000001118}</h2> <!-- 결과 입력(공정 Para) -->
		<form id="pscForm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col> 
					<col style="width:90%"></col>				
				</colgroup>
				<tr>
					<th>${msg.C000001119}</th> <!-- 분류 -->
					<td style="text-align:left;">
						<select id="paraType" name="paraType" class="wd50p"></select>						
					</td>
				</tr>
				<tr>
					<th>${msg.C000001120}</th> <!-- 등록 파일 -->
					<td style="text-align:left;">
						<input type="file" id="formFile" class="wd50p" style="min-width: 10em;">
						
					</td>
				</tr>
				<tr>
					<td></td>
					<td style="text-align:left;">
						<button type="button" id="btnSave" class="inTableBtn inputBtn">${msg.C000000015}</button> <!-- 저장 -->
						<button type="button" id="btnCancle" class="inTableBtn inputBtn">${msg.C000001121}</button> <!-- 취소 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="subCon1 mgT15">
		<h2>${msg.C000001122}</h2> <!-- 유효하지 않은 LOT -->
		<div id="roaGrid" class="mgT15 grid" style="width: 100%; height: 300px;"></div>
	</div>
	
	<div class="subCon1 mgT15">
		<h2>${msg.C000001123}</h2> <!-- 업로드 LOT -->
		<div id="resultGrid" class="mgT15 grid" style="width: 100%; height: 300px;"></div>
	</div>
	
</div>
</tiles:putAttribute> 
</tiles:insertDefinition>