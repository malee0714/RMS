<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">제품 규격</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">

</script>
<script>
//AUIGrid 생성 후 반환 ID
var MhrlsStndrdUseMList = 'MhrlsStndrdUseMList';

$(document).ready(function(){
	getAuth();
	
	//초기 세팅
	init();
	
	//콤보 박스 초기화
	setCombo();
	
	//그리드 세팅
	setMhrlsStndrdUseGrid();
	
	//그리드 이벤트 선언
	setMhrlsGridEvent();
	
	//버튼 이벤트
	setButtonEvent();
	
	
	
});

//초기 세팅
function init(){
	//달력
	datePickerCalendar(["validDte","wrhousngDte"], false, ["DD",0]);
}

//콤보박스 초기화
function setCombo(){

	ajaxJsonComboBox('/com/getCmmnCode.lims', 'schPrductStndrdSeCode', {'upperCmmnCode': 'RS20'}, true); 
	ajaxJsonComboBox('/com/getCmmnCode.lims','schStdMttrSeCode',null, true);
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'prductStndrdSeCode', {'upperCmmnCode': 'RS20'}, true); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims','stdMttrSeCode',null, true); /* 선택 */
}


//그리드 세팅 함수
function setMhrlsStndrdUseGrid(){
	var col = [];	
	
	auigridCol(col);
	 
	
	col.addColumnCustom("prductStndrdSeCodeNm", "${msg.C000001036}", "*" ,true); /* 제품 규격 구분 */  
	col.addColumnCustom("stdMttrSeCodeNm", "${msg.C000001037}", "*", true); /* 제품 규격 상세 */
	col.addColumnCustom("prductStndrdNm", "${msg.C000001038}", "*", true); /* 제품 규격 명 */ 
	col.addColumnCustom("stdMttrSeCode", "${msg.C000001037}", "*", false); /* 제품 규격 상세 */
	col.addColumnCustom("wrhousngDte", "${msg.C000000524}", "*", false); /* 입고일자 */
	col.addColumnCustom("validDte", "${msg.C000000631}", "*", false); /* 유효일자 */
	col.addColumnCustom("rm", "${msg.C000000096}", "*", true); /* 비고 */
	col.addColumnCustom("useAt", "${msg.C000000065}", "*", true); /* 사용여부 */
	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}	
	
	
	//auiGrid 생성
	MhrlsStndrdUseMList = createAUIGrid(col, "MhrlsStndrdUseMList", cusPros);
	// 그리드 리사이즈.
	gridResize([MhrlsStndrdUseMList]);
	// 그리드 칼럼 리사이즈
	
	AUIGrid.bind(MhrlsStndrdUseMList, "ready", function(event) {
		gridColResize([MhrlsStndrdUseMList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//그리드 이벤트
function setMhrlsGridEvent(){
	AUIGrid.bind(MhrlsStndrdUseMList, "cellDoubleClick", function(event) {
		var item = event.item.prductStndrdSeCode;
	
 		ajaxJsonComboBox('/com/getCmmnCode.lims','stdMttrSeCode',{"upperCmmnCode" : "RS21", "tmprField1Value" : item}, true).then(function(){
 			detailAutoSet({"item":event["item"],"targetFormArr":["MhrlsStndrdUseMForm"], "successFunc": function(){
// 			detailAutoSet(event["item"], "MhrlsStndrdUseMForm", function(){
 	 		}
			});
		});
	});
}

//버튼 이벤트 함수
function setButtonEvent(){
	//조회 버튼 이벤트
	$("#btn_select").click(function(){
		searchMhrls();
	});
	
	
	//저장 버튼 이벤트
	$("#btn_save").click(function(){
		if(!saveValidation ("MhrlsStndrdUseMForm")){
			return;
		}
		
		var prductStndrdSeCode = getEl("prductStndrdSeCode").value;
		var stdMttrSeCode = getEl("stdMttrSeCode").value;
		
		if(confirm("${msg.C000000306}")){ /* 저장 하시겠습니까? */
			saveMhrls();			
		}
	});
	
	//검색 엔터 이벤트
	$("[id^=shr]").keyup(function(e){
		searchMhrls(e.keyCode);
	});
	
	//신규버튼
	$("#btn_new").click(function(){
		pageReset(["MhrlsStndrdUseMForm"], null, null, function(){
			getEl("deleteAt").value = "N";
		});
	});
	

	$("#prductStndrdSeCode").click(function(e){
		ajaxJsonComboBox('/com/getCmmnCode.lims','stdMttrSeCode',{"upperCmmnCode" : "RS21", "tmprField1Value" : e.target.value}, true); 
	});
	
	$("#schPrductStndrdSeCode").click(function(e){
		ajaxJsonComboBox('/com/getCmmnCode.lims','schStdMttrSeCode',{"upperCmmnCode" : "RS21", "tmprField1Value" : e.target.value}, true);
	});
}

//저장함수
function saveMhrls(){
	ajaxJsonForm("<c:url value='/rsc/instMhrlsStndrdUseM.lims'/>", 'MhrlsStndrdUseMForm', function (data) {
		if(data > 0){
			alert("${msg.C000000071}"); /* 저장되었습니다. */
			searchMhrls();
			$("#btn_new").click();
		}else{
			alert("${msg.C000000170}") /* 저장에 실패하였습니다. */
		}
	});
}
//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchMhrls();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/rsc/getMhrlsStndrdUseMList.lims'/>", "searchFrm", MhrlsStndrdUseMList);
			$("#btn_new").click();
		}
	}
}

function deleteData(){
	getEl("deleteAt").value = "Y";
	saveMhrls();
}
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001039}</h2> <!-- 제품 규격 목록 -->
		<div class="btnWrap">			
			<button type="button" id="btn_select" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		
		<!-- Main content -->
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
					<th>${msg.C000001036}</th> <!-- 제품 규격 구분 -->
					<td><select id="schPrductStndrdSeCode" name="schPrductStndrdSeCode"></select></td>
					<th>${msg.C000001037}</th> <!-- 제품 규격 상세 -->
					<td><select id="schStdMttrSeCode" name="schStdMttrSeCode"></select></td>
					<th>${msg.C000001038}</th> <!-- 제품 규격 명 --> 
					<td><input type="text" id="schPrductStndrdNm" name="schPrductStndrdNm"></td>	
					<th>${msg.C000000065}</th> <!-- 사용 여부 -->
					<td>
						<label><input type="radio" id="use_asch" name="useAtSch" value="" >${msg.C000000062}</label> <!-- 전체 -->
						<label><input type="radio" id="use_ysch" name="useAtSch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" id="use_nsch" name="useAtSch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>		
				</tr>
			</table>
		</form>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
	</div>	
	<div id="MhrlsStndrdUseMList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
	<form id="MhrlsStndrdUseMForm">
	
	<div class="subCon1 mgT15" id="detail">
		<h2>${msg.C000001040}</h2> <!-- 제품 규격 상세 정보 -->
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button type="button" id="btn_delete" class="btn5 delete" onclick="deleteData()">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btn_save" class="btn1 save">${msg.C000000015}</button> <!-- 저장 -->
					
		</div>		
		<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
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
				<th class="necessary">${msg.C000001036}</th> <!-- 제품 규격 구분 --> 
				<td><select id="prductStndrdSeCode" name="prductStndrdSeCode"></select></td>
				<th class="necessary">${msg.C000001037}</th> <!-- 제품 규격 상세 -->
				<td><select id="stdMttrSeCode" name="stdMttrSeCode"></select></td>
				<th class="necessary">${msg.C000001038}</th> <!-- 제품 규격 명 -->
				<td colspan="3"><input type="text" id="prductStndrdNm" name="prductStndrdNm"></td>	
							
			</tr>
			<tr>
				<th  style="display:none;">${msg.C000000524}</th> <!-- 입고일자 -->
				<td  style="display:none;">
					<input type="text" id="wrhousngDte" name="wrhousngDte">
				</td>	
				<th  style="display:none;">${msg.C000000631}</th> <!-- 유효일자 --> 
				<td  style="display:none;">
					<input type="text" id="validDte" name="validDte" style="display:none;">
				</td>
				<th>${msg.C000000065}</th> <!-- 사용 여부 -->
				<td>
					<label><input type="radio" id="use_y" name="useAt" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
					<label><input type="radio" id="use_n" name="useAt" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
				</td>				
				<td colspan="6">
					<input type="hidden" id="prductStndrdSeqno" name="prductStndrdSeqno">
					<input type="hidden" id="deleteAt" name="deleteAt" value="N">
				</td>				
			</tr>
			<tr>
				<th>${msg.C000000096}</th> <!-- 비고 -->
				<td colspan="7"><textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="2" onkeyup="fnChkByte(this, '4000')"></textarea></td>
			</tr>
		</table>
	</div>
	</form>
</div>

<!--  body 끝 -->
</tiles:putAttribute>

	    
</tiles:insertDefinition>