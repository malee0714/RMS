<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent" id="top_wrap">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000149} </h2> <!-- 게시판 목록 -->
		<div class="btnWrap">
			<button id="addRowBtn" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
			<button id="removeRowBtn" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
			<button id="saveBtn" class="save">${msg.C100000760}</button> <!-- 저장 -->
			<button id="searchBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
	 
		<!-- Main content -->
		<form action="javascript:;" id="noticeForm" name="noticeForm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col> 
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:65%"></col>
				</colgroup>
				<tr>
					<th>${msg.C100000148}</th> <!-- 게시판명 -->
					<td><input type="text"  id="bbsNm" name="bbsNm"></td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align:left;">
						<input name="useAt" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
						<input name="useAt" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
				        <input name="useAt" value="N" type="radio">${msg.C100000449} <!-- 사용안함 -->
				    </td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="noticeGrid" style="width:100%; height:400px; margin:0 auto;"></div>
		</div>
	</div>
</div>
    </tiles:putAttribute>
    <tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var noticeGrid = 'noticeGrid';
var noticeMList = "<c:url value='/sys/getNoticeMList.lims'/>";
var saveUrl = "<c:url value='/sys/saveNoticeM.lims'/>";
var noticeForm = 'noticeForm';
var searchRowCount;
var thisRowCrud;
var thisRowItems;
/*******OnLoad*********/
$(function() {

	getAuth(); //권한 체크
	
	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setNoticeGrid();
	
	// 버튼 이벤트
	setButtonEvent();
	
	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setNoticeGridEvent();

	// 그리드 리사이즈
	gridResize([noticeGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	
}); // OnLoad 끝;


// 그리드 생성
function setNoticeGrid(){
		//그리드 컬럼 담을 배열 정의
		var noticeCol = [];
		auigridCol(noticeCol);

		//컬럼 속성 정의
		var noticeGridColPros = {
			style : "my-require-style",
			headerTooltip : { // 헤더 툴팁 표시 일반 스트링
				show : true,
				tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
			}
			//styleFunction : cellStyleFunction
		};

		//컬럼 셋팅
		//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
		if( !!!getLocalStorageValue(getPageGridName(noticeGrid)) ){
			noticeCol.addColumnCustom("bbsCode","게시판 코드",null,true,false); /* 게시판 코드 */
			noticeCol.addColumnCustom("bbsNm","${msg.C100000148}",null,true,true,noticeGridColPros); /* 게시판명 */
			noticeCol.addColumnCustom("userSntncwriteAt","${msg.C100000677}",null,true,true,noticeGridColPros); /* 이용자 글쓰기 여부 */
			noticeCol.addColumnCustom("atchmnflAt","${msg.C100000862}",null,true,true,noticeGridColPros); /* 첨부파일 여부 */
			noticeCol.addColumnCustom("popupAt","${msg.C100000925}",null,true,true,noticeGridColPros); /* 팝업여부 */
			noticeCol.addColumnCustom("answerAt","${msg.C100000273}",null,true,true,noticeGridColPros); /* 답변여부 */
			noticeCol.addColumnCustom("useAt","${msg.C100000443}",null,true,true,noticeGridColPros); /* 사용여부 */
			noticeCol.addColumnCustom("rm","${msg.C100000425}",null,true,true); /* 비고 */
			noticeCol.addColumnCustom("gridCrud","CRUD구분",null,false,false);
			noticeCol.addColumnCustom("_$uid","_$uid구분",null,false,false);
			noticeCol.dropDownListRenderer(["userSntncwriteAt"],["N","Y"],null);
			noticeCol.dropDownListRenderer(["atchmnflAt"],["N","Y"],null);
			noticeCol.dropDownListRenderer(["popupAt"],["N","Y"],null);
			noticeCol.dropDownListRenderer(["answerAt"],["N","Y"],null);
			noticeCol.dropDownListRenderer(["useAt"],["Y","N"],null);
			// 그리드 생성
			noticeGrid = createAUIGrid(noticeCol, noticeGrid);
		} else {
			noticeGrid = createAUIGrid( getLocalStorageValue(getPageGridName(noticeGrid)) ,noticeGrid);
		}
		
};

// 그리드 이벤트
function setNoticeGridEvent(){
	// 각자 필요한 이벤트 구현
	
	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(noticeGrid, "ready", function(event) {
		gridColResize(noticeGrid, "2");
	});
	
	//CRUD 체크
	AUIGrid.bind(noticeGrid, "cellEditEnd", function(event){
		
		var myValue = AUIGrid.getCellValue(noticeGrid, event.rowIndex, "gridCrud")

		if(myValue != "C"){
			item = { gridCrud : "U" };
   			AUIGrid.updateRow(noticeGrid, item, "selectedIndex");
		}

 		return event.value;
 	});
	
	/* 그리드 행 삭제 변수값 할당*/
	AUIGrid.bind(noticeGrid, "selectionChange", function( event ) {
		thisRowCrud = AUIGrid.getCellValue(noticeGrid, event.primeCell.rowIndex, "gridCrud"); // 행삭제 구분값
		thisRowItems = event.primeCell.rowIdValue== undefined ? event.primeCell.null : event.primeCell.rowIdValue; // 현재 선택._$uid 
	});

	// 그리드 행삭제 이벤트
	function gridRmRowEvent(noticeGrid, thisRowItems, addedRowItems){ // 그리드ID, 현재선택._$uid
		
		for(var i in addedRowItems){
			switch (thisRowItems){
			case addedRowItems[i]._$uid :
				AUIGrid.removeRow(noticeGrid, "selectedIndex"); // 행 삭제
				return true;
			case addedRowItems[i].null : // 조회를 안하고 행추가시 초기 _$uid 구분 컬럼이 null로 생성될 때
				AUIGrid.removeRow(noticeGrid, "selectedIndex"); // 행 삭제
				return true;
			default :

	  		}

		}
	}
	
	// 그리드 행 삭제 버튼
	$('#removeRowBtn').click(function(){ // 행삭제 클릭시

		var addedRowItems = AUIGrid.getAddedRowItems(noticeGrid); // 추가된._$uid
		 if(thisRowCrud == 'C'){ // 새로 만들어진 행이라면
			gridRmRowEvent(noticeGrid, thisRowItems, addedRowItems);	//행 삭제 함수 호출

		}else if(thisRowCrud == null && thisRowCrud != "C") {
			warn('${msg.C100000444}'); /* 사용여부를 N으로 저장해주세요 */
			return thisRowCrud = "";
		}
	});
	
}

// 버튼 이벤트
function setButtonEvent(){
	
	// 조회
	$('#searchBtn').click(function(){
		searchNoticeGridorForm();
	})
	
	// 행추가
	$('#addRowBtn').click(function(){
		addRow();
	})
	
	// 저장 (그리드 벨리데이션 체크)
	$('#saveBtn').click(function(){
		var saveRowCount = AUIGrid.getRowCount(noticeGrid);
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var noticeGridData = AUIGrid.getGridData(noticeGrid);
		var item;
		var invalid = false;
		var invalidRowIndex = -1;
		var colIndex;
		
		for(var i=0, len=noticeGridData.length; i<len; i++) {
			item = noticeGridData[i];
		
			if(typeof item["bbsNm"] == "undefined" || String(item["bbsNm"]).trim() == "" || item["bbsNm"] == null ){ // 게시판 명 데이터 체크
				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(noticeGrid, "bbsNm");
				
				/* if(saveRowCount == searchRowCount){
					alert('저장할 항목이 없습니다.')
				}else{
					invalid = true;
				} */
				
				break;
			}
			
		}
		
		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(noticeGrid, invalidRowIndex, colIndex);
		} else {
			// 실질적인 저장 로직 처리
			saveNoticeGridorForm();
		}
		
	})
	
};

/*############ 조회, 저장, 삭제 함수 ############*/

/* 조회 */
function searchNoticeGridorForm(rowVal){
	//getGridDataForm(url, 폼이름, 그리드id);
	//getGridDataForm(noticeMList, noticeForm, noticeGrid);
	getGridDataForm(noticeMList, noticeForm, noticeGrid, function() {
		if (!!rowVal)
			gridSelectRow(noticeGrid, "bbsCode", rowVal);
	});
	
	searchRowCount = AUIGrid.getRowCount(noticeGrid);
}

/* 저장 */
function saveNoticeGridorForm(){
	
	var addedRowItems = AUIGrid.getGridData(noticeGrid);
	
	if(addedRowItems != null){
		customAjax({"url":saveUrl,"data":addedRowItems,"successFunc":function(data){
// 		ajaxJsonParam(saveUrl, addedRowItems, function(data) {
			if (data != 1){
				err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
			} else {
				success("${msg.C100000762}"); /* 저장 되었습니다. */
				searchNoticeGridorForm(addedRowItems[0].bbsCode);
			}
			}
		});
	}
}


/*############ 기타이벤트 함수 ############*/


/* 그리드 행 추가 */
function addRow(){
	var item = new Object();
	
	item.bbsNm = "",
	item.popupAt = "N",
	item.answerAt = "N",
	item.userSntncwriteAt = "N",
	item.atchmnflAt = "N",
	item.rm = "",
	item.useAt = "Y"
	item.gridCrud = "C"; // CRUD 구분값 [C: insert]
	
	AUIGrid.addRow(noticeGrid, item, "last");
}


//엔터키 이벤트
$("input").keypress(function (e) {
    if (e.which == 13){
    	searchNoticeGridorForm();
    }
});

    
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>
