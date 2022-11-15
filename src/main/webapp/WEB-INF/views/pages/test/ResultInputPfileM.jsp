<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="script">
<script>

var resultGrid;

$(function(){
	//권한
	getAuth();
	
	//콤보 박스 초기화
	setCombo();
	

	
	//결과 여부 그리드 설정
	setresultGrid();
	
	//버튼 이벤트
	setButtonEvent();
	
	gridResize([resultGrid]);
});

//콤보 박스 초기화
function setCombo(){

	
}



//성공 여부 그리드 설정
function setresultGrid(){
	var col = [];	
	
	auigridCol(col);
	
	col.addColumnCustom("lotId", "LOT ID", "*", true);
	col.addColumnCustom("testNm", "시험항목 명", "*", true);
	col.addColumnCustom("resultValue", "결과 값", "*", true);
	col.addColumnCustom("msg", "결과", "*", true);

	
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
		var file = $("#formFile")

		//파일 없으면 리턴
		if(file[0].files.length == 0){
			alert("등록파일을 선택해 주세요.");
			return;
		}		
		
		var fileName = file[0].files[0].name;
		var fileTxt = fileName.substring(fileName.length, fileName.length-3);
		
		if(fileTxt.toUpperCase() == "TXT"){
			if(!confirm("저장 하시겠습니까?")){ //저장 하시겠습니까?
				return;
			}
			
			var formData = new FormData();
			formData.append("formFile", $("#formFile")[0].files[0]);

			ajaxJsonFormFile("/test/fileTxtUpload.lims", formData, function(data){
				
				if(data.readList.length != 0){
					AUIGrid.setGridData(resultGrid, data["readList"]); // 성공값
				}
				if(data.resultList.length != 0){
					AUIGrid.setGridData(resultGrid, data["resultList"]); //실패값
				}
		

			}, null, null);
			
		} else {
			alert("txt 확장자만 업로드 할 수 있습니다."); 
			return;
		}

	});
}


</script>
</tiles:putAttribute>   
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
	<h2>결과 입력(파일)</h2>
	<form id="pscForm">
		<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col> 
					<col style="width:90%"></col>				
				</colgroup>
				<tr>
					<th>등록 파일</th>
					<td style="text-align:left;">
						<input type="file" id="formFile" class="wd50p" style="min-width: 10em;">
						<div class="btnWrap">
						<button type="button" id="btnSave" class="btn1">저장</button>
						</div>
					</td>
				</tr>

			</table>
		</form>
	</div>


	<div class="subCon1 mgT15">
		<h2>업로드 LOT</h2>
		<div id="resultGrid" class="mgT15 grid" style="width: 100%; height: 300px;"></div>
	</div>
</div>
</tiles:putAttribute> 
</tiles:insertDefinition>