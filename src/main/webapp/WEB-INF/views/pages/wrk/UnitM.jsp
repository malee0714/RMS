<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
	<h2><i class="fi-rr-apps"></i>${msg.C100000270}</h2><!-- 단위 목록 -->
		<div class="btnWrap">
			<button id="btnAddRow" class="btn5"><img src="/assets/image/plusBtn.png"></button>
			<button id="btnDeleteRow"  class="delete"><img src="/assets/image/minusBtn.png"></button>
			<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
			<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form action="javascript:;" id="unitSearchFrm" name="unitSearchFrm">							
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
				</colgroup>
				<tr>
				<th>단위 구분</th> <!-- 단위명 -->
					<td><select type="text"  id="unitSeCode" name="unitSeCode" class="wd100p">
					</select></td>
				<th>${msg.C100000269}</th> <!-- 단위명 -->
				<td><input type="text"  id="txtUnitNM" name="txtUnitNM" class="wd100p"></td>						
				<th>${msg.C100000443}</th> <!-- 사용여부 -->
				<td style="text-align:left;">
					<label><input type="radio" name="useAtSearch" value="">${msg.C100000779}</label> <!-- 전체 -->
			    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
			    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
				</td>	
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="unitGrid" style="width:100%; height:500px; margin:0 auto;"></div>
		</div>
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

var unitSearchFrm ='unitSearchFrm';
var unitInfoFrm = 'unitInfoFrm';

//출처구분 GridCombo
var unitSeList = getGridComboList("<c:url value='/com/getCmmnCode.lims'/>",{upperCmmnCode: "SY10"}, true);

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
		ajaxJsonComboBox('/com/getCmmnCode.lims', "unitSeCode",{ "upperCmmnCode" : "SY10" }, true); //단위 구분
	}


	//그리드 생성
	function setUnitGrid(){
		
	////그리드 정의 userGrid
		var unitCol = [];		
		auigridCol(unitCol);
		
		//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
		
		var checkboxProp = {
				check : "Y",
				unCheck : "N"
		}
		
		var gridProp = {
				showStateColumn : true,
				selectionMode : "multipleCells",
				softRemovePolicy : "exceptNew",
				softRemoveRowMode:true
		}
		
		var unitPros = {
	    		editRenderer : {
	    			type : "InputEditRenderer",
	    			
	    			validator : function(oldValue, newValue, item, dataField) {
	    				if(newValue != ""){
		    				if(oldValue != newValue) {
		    					// dataField 에서 newValue 값이 유일한 값인지 조사
		    					var isValid = AUIGrid.isUniqueValue(unitGrid, dataField, newValue);
								var rowItems = AUIGrid.getItemsByValue(unitGrid, dataField, newValue);
								if(rowItems.length ==1){
									if(rowItems[0].unitSeCode != item.unitSeCode && item.unitSeCode !='')
										isValid = true;
								}
		    					 if(isValid == false){
		    						 warn("이미 등록된 같은 단위 명이 존재합니다.")
		    						 return { "oldValue" : oldValue };
		    					 } 		
		    				}
	    				}
	    			}
	    		}
	    	
	    };

			unitCol.addColumnCustom("unitSeqno","unitSeqno",null,false,null);
			unitCol.addColumnCustom("unitSeCode","단위구분",null,true,true); /* 단위구분 */
			unitCol.addColumnCustom("unitNm","${msg.C100000269}",null,true,true, unitPros); /* 단위명 */
			unitCol.addColumnCustom("useAt","${msg.C100000443}",null,true,true); /* 사용여부 */
			unitCol.checkBoxRenderer(["useAt"],unitGrid, checkboxProp);
			unitCol.dropDownListRenderer(["unitSeCode"], unitSeList, true)

		unitGrid = createAUIGrid(unitCol, unitGrid, gridProp);

	};
	//그리드 이벤트
	function setUnitGridEvent(){
		

		// 단위명 체크 로직
		AUIGrid.bind(unitGrid, "cellEditEnd", function( event ) {
			if(event.headerText == "단위구분") {
				AUIGrid.setCellValue(unitGrid, event.rowIndex, "unitNm", "");
					//warn(event);
				}
			});


		AUIGrid.bind(unitGrid, "ready", function(event) {
			gridColResize(unitGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
		});	
		
	};

//버튼 이벤트
function setButtonEvent(){
	//조회버튼
	$('#btnSearch').click(function(){
		searchUnitGrid();
	});
	
	//저장
	$("#btnSave").click(function (){
		saveUnitGrid();
	});
	
	//초기화 저장
	$("#btnReset").click(function (){
		frmReset();
	});
	
	$("#btnAddRow").click(function(){
		var item = {
			unitSeqno : "",
			unitSeCode : '',
			useAt : "Y"
		}
		AUIGrid.addRow(unitGrid,item,'last');
	});
	
	$("#btnDeleteRow").click(function(){
		var selectedItems = AUIGrid.getSelectedItems(unitGrid);
		console.log(selectedItems);
		if(selectedItems.length == 0){
			alert("${msg.C100000497}"); /* 선택된 행이 없습니다. */
			return false;
		}
		AUIGrid.removeRow(unitGrid, "selectedIndex");
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

//저장
function saveUnitGrid(){		
	var addedRowItems = AUIGrid.getAddedRowItems(unitGrid);
	var editedRowItems = AUIGrid.getEditedRowItems(unitGrid);
	var removedRowItems = AUIGrid.getRemovedItems(unitGrid);

	var isValid = AUIGrid.validateGridData(unitGrid, "unitSeCode");
	if(!isValid) {
		warn("단위 구분을 입력해야 합니다.");  /* 단위 구분을 입력해야 합니다. */
		return false;
	}

	var param = {
		"addedRowItems" : addedRowItems,
		"editedRowItems" : editedRowItems,
		"removedRowItems" : removedRowItems
	}
	console.log(param);
	if(param.addedRowItems.length == 0 && param.editedRowItems.length == 0 && param.removedRowItems.length == 0){
		alert("${msg.C100000883}"); /* 추가/수정/삭제된 행이 없습니다. */
		return false;
	}
		customAjax({
		url: '/wrk/unitNmValidation.lims',
		data: param
	}).then(function(res,status){
		if(res >= 1){
			warn("이미 등록된 같은 단위 명이 존재합니다.");
			return;
		} else {
			customAjax({
				url: saveUnitUrl,
				data: param
			}).then(function(data) {
				if(!!data) {
					success("${msg.C100000765}"); /* 저장 되었습니다. */
					frmReset();
					searchUnitGrid();
				}	
			}, function(request, status, error) {
				err("${msg.C100000597}"); /* 오류가 발생했습니다.*/
			});
		}
	})
	
	
	/*
	ajaxJsonParam(saveUnitUrl, param, function (data) {
		if(!!data)
			alert("${msg.C000000071}"); 
			frmReset();
			searchUnitGrid();
	}, function (request,status,error) {
		alert("${msg.C000000190}"); 
	});
	*/
	
};

//폼 초기화시 이벤트별로 셋팅할 것 들
function frmReset(){
	AUIGrid.clearGridData(unitGrid);
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>