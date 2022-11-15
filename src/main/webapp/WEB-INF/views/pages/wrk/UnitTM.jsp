<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000324}</h2> <!-- 단위목록 -->
		<div class="btnWrap">
			<!-- <button type="button" id="btnAddRow" class="save btn4">${msg.C000000111}</button> <!-- 행추가 -->
			<!-- <button type="button" id="btnDeleteRow" class="delete btn5">${msg.C000000112}</button> <!-- 행삭제 -->
			<!-- <button type="button" id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
			<button type="button" id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form action="javascript:;" id="unitSearchFrm" name="unitSearchFrm">							
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>			
					<col style="width:15%"></col>
					<col style="width:10%"></col>		
					<col style="width:15%"></col>	
				</colgroup>
				<tr>
				<th>${msg.C000000326}</th> <!-- 단위명 -->
				<td><input type="text"  id="txtUnitNM" name="txtUnitNM" class="wd100p"></td>
				<th>단위 구분</th>
				<td>
					<select id="cboUnitSe" name="cboUnitSe" "></select>
				</td>	
				<th>${msg.C000000065}</th> <!-- 사용여부 -->
				<td style="text-align:left; width :100%;">
					<label><input type="radio" name="useAtSearch" value="">${msg.C000000062}</label> <!-- 전체 -->
			    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
			    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
				</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon1">
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="unitGrid" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="subCon1 mgT20" id="detail">
		<h2>${msg.C000000324}</h2> <!-- 단위목록 -->
	  	<div class="btnWrap">
	 		<button type="button" id="btnreset" class="btn4">신규</button> <!-- 수정 -->
			<button type="button" id="btnDeleteRow" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div> 
		<form id="editFrm" name ="editFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="userInfotbl">
				<colgroup>
					<col style="width:8%"></col> 
					<col style="width:17%"></col>
					<col style="width:8%"></col>
					<col style="width:17%"></col>
					<col style="width:8%"></col>			
					<col style="width:17%"></col>	
					<col style="width:8%"></col>			
					<col style="width:17%"></col>		
				</colgroup>
				<tr>
					<th class="necessary" style="min-width:100px;">${msg.C000000326}</th> <!-- 단위명 -->
					<td><input type="text" id=unitNm name="unitNm" class="wd100p" style="min-width:10em;"></td>
					<th>단위 구분</th>
					<td>
						<select id="unitSeCode" name="unitSeCode"  style="min-width:10em"></select>
					</td>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td style="text-align:left;">
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N">${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
					<td colspan="3"></td>
				</tr>
			</table>		
			<input type="text" id="unitSeqno" name="unitSeqno" style="display:none">
		</form>
	</div>
</div>
</tiles:putAttribute>
    
<tiles:putAttribute name="script">
<script>
var lang = ${msg}; // 기본언어
//AUIGrid 생성 후 반환 ID
var unitGrid = "unitGrid";

var searchUnitUrl = "<c:url value='/wrk/getUnitList.lims'/>";
var saveUnitUrl = "<c:url value='/wrk/saveUnit.lims'/>";
//추가한내용
var insUnitUrl = "<c:url value='/wrk/insUnitTM.lims'/>";
var updataUnitUrl = "<c:url value='/wrk/updateUnit.lims'/>";
var deleteUnitUrl = "<c:url value='/wrk/deleteUnit.lims'/>";
var overlapUnitUrl = "<c:url value='/wrk/overlapUnit.lims'/>";
var unitSearchFrm ='unitSearchFrm';
var unitInfoFrm = 'unitInfoFrm';
var editFrm = 'editFrm';
//출처구분 GridCombo
var unitSeList = getGridComboList("<c:url value='/com/getCmmnCode.lims'/>",{upperCmmnCode: "SY07"}, true);

	$(function() {	
		getAuth(); //권한 체크
		// 콤보 셋팅
		setCombo();
		
		// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
		setUnitGrid();
		
		// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
		setUnitGridEvent();
		
		// 버튼 이벤트
		setButtonEvent();
		
		// 기타 이벤트
		setEtcEvent();
		
		//그리드 사이즈 조절
		gridResize([unitGrid]);
		
		//폼 및 그리드 초기화
		frmReset();
	});
	//콤보로드
	function setCombo() {	
		ajaxJsonComboBox('/com/getCmmnCode.lims','cboUnitSe',{"upperCmmnCode" : "SY07"},false,"${msg.C000000079}"); /* 선택 */
		ajaxJsonComboBox('/com/getCmmnCode.lims','unitSeCode',{"upperCmmnCode" : "SY07"},false,"${msg.C000000079}"); /* 선택 */
	}


	//그리드 생성
	function setUnitGrid(){
		
	////그리드 정의 userGrid
		var unitCol = [];		
		auigridCol(unitCol);
		
		//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
		var unitGridColPros = {
			renderer : {
				type : "String",
				list : unitSeList, //key-value Object 로 구성된 리스트
				keyField : "value", // key 에 해당되는 필드명
				valueField : "key" // value 에 해당되는 필드명
			},
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) { 
				var retStr = "";
				for(var i=0,len=unitSeList.length; i<len; i++) {
					if(unitSeList[i]["value"] == value) {
						retStr = unitSeList[i]["key"];
						break;
					}
				}
				return retStr;
			}
		};
		

		
		var gridProp = {
				showStateColumn : true,
				selectionMode : "multipleCells",
				softRemovePolicy : "exceptNew",
				softRemoveRowMode:true
		}
		
		unitCol.addColumnCustom("unitrowIndex","unitrowIndex",null,false,true);  //행번호
		unitCol.addColumnCustom("unitSeqno","unitSeqno",null,false,null);
		unitCol.addColumnCustom("unitNm","${msg.C000000326}",null,true,true); /* 단위명 */
		unitCol.addColumnCustom("unitSeCode","${msg.C000000325}",null,true,true, unitGridColPros); /* 단위구분 */
		unitCol.addColumnCustom("useAt","${msg.C000000065}",null,true,true); /* 사용여부 */
		//unitCol.checkBoxRenderer(["useAt"],unitGrid, checkboxProp);
		//속성
		
		// 실제로 #grid_wrap 에 그리드 생성
		unitGrid = createAUIGrid(unitCol, unitGrid, gridProp);	
	};
//그리드 이벤트
	function setUnitGridEvent(){	
	AUIGrid.bind(unitGrid, "ready", function(event) {
		gridColResize(unitGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
	});	
	 //편집 불가
	AUIGrid.bind(unitGrid, "cellEditBegin",function(event) {
		return false;
	});
	AUIGrid.bind(unitGrid, "cellDoubleClick", function(event) {
		$('#unitSeqno').val(event.item.unitSeqno);
		$('#unitNm').val(event.item.unitNm);
		$('#useAt').val(event.item.useAt);
		$('#unitSeCode').val(event.item.unitSeCode);
		if(event.item.useAt == 'Y')
			$("#useY").val(event.item.useAt).prop("checked", true);
		else 
			$("#useN").val(event.item.useAt).prop("checked", true);
	});
};

//버튼 이벤트
function setButtonEvent(){
	//조회버튼
	$('#btnSearch').click(function(){
		searchUnitGrid();
	});
	//
	$('#btnreset').click(function(){
		$('#editFrm')[0].reset();
	});
	//삭제
	$("#btnDeleteRow").click(function (){
		deleteUnitGrid();
	});
	//저장
	$("#btnSave").click(function (){
		if ($('#unitNm').val() == null || $('#unitNm').val() == ""){
			alert("단위명을 입력해 주십시오."); 
			return;
		} 
		if (($("#editFrm").serializeObject()).unitSeqno == ""){
			overlapUnitGrid();
		}else{
			updataUnitGrid();
		}
		

	});
	//초기화 저장
	$("#btnReset").click(function (){
		frmReset();
	});
};

//기타이벤트
function setEtcEvent(){
	$("#txtUnitNM").keypress(function (e) {
      if (e.which == 13){
    	  searchUnitGrid();
      }
	});
}
/*############ 조회, 저장, 삭제 함수 ############*/
//조회
function searchUnitGrid(){	
	//getGridDataForm(searchUnitUrl, unitSearchFrm, unitGrid);
	getGridDataForm(searchUnitUrl, unitSearchFrm, unitGrid);
};
//삭제
function deleteUnitGrid(){
	customAjax({
		"url": deleteUnitUrl,
		"data" : $('#editFrm').serializeObject(),
		"showLoading" : true,
		"successFunc" : function(data){
		if(!!data)
			alert("${msg.C000000179}"); /* 삭제 되었습니다. */
			frmReset();
			searchUnitGrid();
	}, function (request,status,error) {
		alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
		}
	});
	
}

//수정
function updataUnitGrid(){
	customAjax({
		"url": updataUnitUrl,
		"data" : $('#editFrm').serializeObject(),
		"showLoading" : true,
		"successFunc" : function(data){
		if(!!data)
			alert("${msg.C000000323}"); /* 수정 되었습니다. */
			frmReset();
			searchUnitGrid();
	}, function (request,status,error) {
		alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
	}
	});
	
};

//저장
function saveUnitGrid(){			
	customAjax({
		"url": insUnitUrl,
		"data" : $('#editFrm').serializeObject(),
		"successFunc" : function(data){
		if(!!data)
			alert("${msg.C000000071}"); /* 저장 되었습니다. */
			frmReset();
			searchUnitGrid();
	}, function (request,status,error) {
		alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
	}
	});
	
};

//중복 방지
function overlapUnitGrid(){
	customAjax({
		"url": overlapUnitUrl,
		"data" : $('#editFrm').serializeObject(),
		"showLoading" : true,
		"successFunc" : function(data){
			if(data>0)
				alert("중복데이터가 있습니다.");
			else 
				saveUnitGrid();
		}
	});
}
//폼 초기화시 이벤트별로 셋팅할 것 들
function frmReset(){
	AUIGrid.clearGridData(unitGrid);
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>
