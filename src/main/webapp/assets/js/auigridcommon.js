/* AUIGrid 를 생성합니다. */
/**
 * @param prosCustom
 *            :Item
 * @param editable :
 *            편집 가능 여부 (기본값 : false)
 * @param enterKeyColumnBase :
 *            엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
 * @param selectionMode :
 *            셀 선택모드 (기본값: singleCell)
 * @param useContextMenu :
 *            컨텍스트 메뉴 사용 여부 (기본값 : false)
 * @param enableFilter :
 *            필터 사용 여부 (기본값 : false)
 * @param useGroupingPanel :
 *            그룹핑 패널 사용 (기본값 : false)
 * @param showStateColumn :
 *            상태 칼럼 사용 (기본값 : false)
 * @param rowNumHeaderText :
 *            칼럼 헤더 부분 디폴트 값 (No. 제거)
 * @param softRemoveRowMode :
 *            행 삭제시 그리드에서 제거 (기본값 : false)
 * @param displayTreeOpen :
 *            그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
 * @param noDataMessage :
 *            "데이터 없을때 표시할 메시지.",
 * @param showFooter :
 *            푸터 사용 여부
 * @param showBranchOnGrouping :
 *            그룹핑, 셀머지 사용 시 브랜치에 해당되는 행 표시 안함
 * @param enableCellMerge :
 *            그룹핑 후 셀 병함 실행
 * @param rowStyleFunction :
 *            그리드 ROW 스타일 함수 정의(ex : 합계 행에 스타일 적용)
 * @param useSummaryExpData :
 *            그룹핑 합계필드(groupingSummary)를 사용할 때 합계 필드에 사용되는 데이터가 칼럼의 expFunction
 *            에 의해 생성된 데이터를 사용할지 여부
 * @param isGenNewRowsOnPaste :
 *            다수의 행을 클립 보드 붙여넣기(Ctrl+V) 할 때 그리드의 마지막 하단 행보다 클립보드 양이 많은 경우, 새 행을
 *            만들고 붙여넣기 할지 여부를 지정
 * @param enableClipboard :
 *            그리드 데이터 복사하기(Ctrl+C), 붙여넣기(Ctrl+V) 활성화 여부를 지정
 * @param gridPro.showEditedCellMarker :
 *            수정 여부 마킹 출력 여부
 * @param fixedColumnCount :
 *            틀 고정할 칼럼의 개수 (기본값 0)
 * @param wordWrap :
 *            wordWrap
 * @param usePaging :
 *            페이징 여부
 * @param enableMovingColumn :
 *            컬럼 이동(기본값 : false)
 * 
 * KeyDown 이벤트를 따로 사용하는 경우에는 생성시 useKeyDown = false 추가 후 화면에서 KeyDown 이벤트 구현
 */
function createAUIGrid(columnLayout, gridid, prosCustom, useKeyDown) {
	
	gridid = gridid.replace('#','');
	
	var myGridID = null; // AUIGrid 생성 후 반환 ID
	var arrCurrentDataField = [];
	var downLoadName = gridid.replace('#','').split(',') + "_" + AUIGrid.formatDate(new Date(), "yyyymmdd"); // 파일 이름 설정
    
	// 컨텍스트 메뉴에 보일 아이템 리스트
	var myContextMenus = [
        {label : "모든 필터링 초기화", callback : contextItemHandler},
        {label : "_$line"}, // label 에 _$line 을 설정하면 라인을 긋는 아이템으로 인식합니다.
        {label : "그룹핑 보이기",  callback : contextItemHandler},
        {label : "그룹핑 숨기기",  callback : contextItemHandler},
        {label : "필터 보이기", callback : contextItemHandler},
        {label : "필터 숨기기", callback : contextItemHandler},
        {label : "_$line"},
        {label : "Export To Excel", callback : contextItemHandler},
        {label : "Export To PDF", callback : contextItemHandler},
        {label : "_$line"},
        {label : "현재 컬럼 숨기기" , callback : contextItemHandler},
        {label : "모든 컬럼 보이기" , callback : contextItemHandler},
        {label : "_$line"},
        {label : "행 개수" , callback : contextItemHandler},
        {label : "_$line"},
        {label : "그리드 상태 저장" , callback : contextItemHandler},
        {label : "그리드 상태 초기화" , callback : contextItemHandler}
    ];
	
	// 컨텍스트 메뉴 아이템 핸들러
	function contextItemHandler(event) {
        switch(this.label) {
			case "모든 필터링 초기화":
				AUIGrid.clearFilterAll(myGridID); //  필터링 모두 해제
				break;
            case "그룹핑 보이기":
                AUIGrid.setProp(myGridID, "useGroupingPanel" , true); // 그룹핑 생성
                AUIGrid.refresh(myGridID); // 리프레시
                break;
            case "그룹핑 숨기기":
                AUIGrid.setProp(myGridID, "useGroupingPanel" , false); // 그룹핑 해제
                AUIGrid.refresh(myGridID); // 리프레시
                break;
			case "필터 보이기": // 필터 보이기
				setFilter(myGridID);
				break;
			case "필터 숨기기": // 필터 숨기기
				removeFilter(myGridID);
				break;
            case "현재 컬럼 숨기기":
                AUIGrid.hideColumnByDataField(myGridID, event.dataField);
                arrCurrentDataField.push(event.dataField);
                break;
            case "모든 컬럼 보이기":
                AUIGrid.showColumnByDataField(myGridID, arrCurrentDataField)
                gridResize(myGridID);
                gridColResize(myGridID, "2");
                arrCurrentDataField = [];
                break;
			case "Export To Excel":
				exportToXlsx(myGridID, downLoadName); // 엑셀 출력
				break;
			case "Export To PDF": // PDF 출력
				if(!AUIGrid.isAvailabePdf(myGridID)) {
					alert("PDF 저장은 HTML5를 지원하는 최신 브라우저에서 가능합니다.(IE는 10부터 가능)");
					return;
				}else{
					exportToPdf(myGridID, downLoadName);
				}
				break;
			case "행 개수":
				var gridRowCount = AUIGrid.getRowCount(myGridID);
				if(gridRowCount){
					alert("행 개수: "+gridRowCount);
				}
			    break;
			case "그리드 상태 저장":
				saveColumnLayout(myGridID);  //그리드 현재상태 저장
			    break;
			case "그리드 상태 초기화":
				resetColumnLayout(myGridID); //그리드 상태 해제
			    break;
        }
	}
	
	// 그리드 속성 설정
	var gridPros = {};
	gridPros.editable = true, // 편집 가능 여부 (기본값 : false)
	gridPros.enterKeyColumnBase =false,// 엔터키가 다음 행이 아닌 다음 칼럼으로 이동할지 여부 (기본값 : false)
	gridPros.selectionMode = "multipleCells",// 셀 선택모드 (기본값: singleCell) // singleRow
	gridPros.enableFilter  = true,// 필터 사용 여부 (기본값 : false)
	gridPros.useGroupingPanel = false,// 그룹핑 패널 사용
	gridPros.showStateColumn = false,// 상태 칼럼 사용
	gridPros.rowNumHeaderText = "",// 칼럼 헤더 부분 디폴트 값 (No. 제거)
	gridPros.softRemoveRowMode = false,// 행 삭제시 그리드에서 제거
	gridPros.displayTreeOpen = false,// 그룹핑 또는 트리로 만들었을 때 펼쳐지게 할지 여부 (기본값 : false)
	gridPros.noDataMessage = "출력할 데이터가 없습니다.",					
	gridPros.showBranchOnGrouping = false,// 그룹핑, 셀머지 사용 시 브랜치에 해당되는 행 표시 안함.
	gridPros.enableCellMerge = false,// 그룹핑 후 셀 병함 실행
	gridPros.showFooter = false, // 푸터 사용 여부
	gridPros.rowStyleFunction = null, // 그리드 ROW 스타일 함수 정의
	gridPros.useSummaryExpData = false, // 그룹핑 합계필드(groupingSummary)를 사용할 때 합계 필드에 사용되는 데이터가 칼럼의 expFunction 에 의해 생성된 데이터를 사용할지 여부
	gridPros.isGenNewRowsOnPaste = false,
	gridPros.wrapSelectionMove = true; // 칼럼 끝에서 오른쪽 이동 시 다음 행, 처음 칼럼으로 이동할지 여부
	gridPros.enableClipboard = true;
	gridPros.showEditedCellMarker = false;// 수정 여부 마킹 출력 여부
	gridPros.fixedColumnCount = 0;// 틀 고정할 칼럼의 개수
	gridPros.wordWrap = false;	// 워드랩
	gridPros.usePaging = false; // 페이징 사용
	gridPros.pagingMode = "simple"; // 페이징을 간단한 유형으로 나오도록 설정
	gridPros.pageRowCount = 20; // 한 화면에 출력되는 행 개수 기본 20개로 지정
	gridPros.groupingFields = []; 
	gridPros.groupingSummary = null; 
	gridPros.treeIconFunction = null; // 트리 그리드에서 트리를 출력하는 칼럼에 표시되는 아이콘을 동적으로 변경 할 수 있는 함수
	gridPros.enableCellMerge = true; // 셀 병합 실행
	gridPros.cellMergePolicy = "withNull"; // "withNull" : null 도 하나의 값으로 간주하여 다수의 null 을 병합된 하나의 공백으로 출력 시킵니다.
	gridPros.rowSelectionWithMerge = true; // 셀머지된 경우, 행 선택자(selectionMode : singleRow, multipleRows) 로 지정했을 때 병합 셀도 행 선택자에 의해 선택되도록 할지 여부
	gridPros.flat2tree = false; // 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
	gridPros.rowIdField = null; // 행의 고유 필드명
	gridPros.treeIdField = null; // 트리의 고유 필드명
	gridPros.treeIdRefField = null; // 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
	gridPros.useContextMenu = true; // 컨텍스트 메뉴 사용 여부 (기본값 : false) - 이 기능을 사용하려면 'enableFilter = true' 설정도 함께 해주어야 한다.
	gridPros.enableRightDownFocus = true; // 컨텍스트 메뉴를 보기 위해 오른쪽 클릭을 한 경우 클릭 지점이 왼쪽 클릭과 같이 셀 선택을 할지 여부 (기본값 : false)
	gridPros.contextMenuItems = myContextMenus; // 컨텍스트 메뉴 아이템들
	gridPros.enableFocus = true;
	gridPros.headerRenderer = null; // 헤더의 체크박스가 상호 의존적인 역할을 할지 여부(기본값:false)
	gridPros.headerHeight  = 26;
	gridPros.enableMovingColumn = true;	
	gridPros.enableDrag  = false; // 드래깅 행 이동 가능 여부 (기본값 : false)
	gridPros.enableMultipleDrag  = false; // 다수의 행을 한번에 이동 가능 여부(기본값 : false)
	gridPros.enableDragByCellDrag  = false; // 셀에서 바로 드래깅 해 이동 가능 여부 (기본값 : false) - enableDrag=true 설정이 선행
	gridPros.enableDrop   = false;
	gridPros.dropToOthers  = false;  // 그리드 간의 행 이동 가능 여부 (기본값 : false)
	gridPros.copySingleCellOnRowMode = false; // true면 row선택모드여도 셀단위복사가능
	gridPros.autoGridHeight = false; // true면 데이터길이에 따라 그리드 길이가 맞춰짐
    gridPros.enableRowCheckShiftKey = true;
	gridPros.showRowCheckColumn = false;
	gridPros.showRowAllCheckBox - false;

    // custom 속성을 gridProps에 재정의 or 추가
    for (var key in prosCustom) {
        gridPros[key] = prosCustom[key];
    }

	//트리형 그리드 속성인 경우 컨텍스트메뉴에서 그룹핑메뉴 제외
	if (gridPros.flat2tree) {
		myContextMenus = myContextMenus.filter(function (contextMenu) {
			return contextMenu.label !== '그룹핑 보이기' && contextMenu.label !== '그룹핑 숨기기';
		});
	}

    // localStorage에 저장된 컬럼
    var localStorageCol = getLocalStorageValue(getPageGridName("#" + gridid));
    //저장된 로컬스토리지가 없으면 기본 그리드 세팅 출력
	myGridID = AUIGrid.create("#" + gridid, (!!localStorageCol) ? localStorageCol : columnLayout, gridPros);

	gridResize(["#" + gridid]);

    // grid div 사이즈 변경, auigrid resize
    gridReSizeEvent(myGridID);

	$($(myGridID).find(".aui-grid").children("div")[12]).css( "zIndex", -1 );// 임시 (그리드 우측하단의 AUIGrid 링크 숨기기
	if("#"+"rgntCmpdsMaster" == myGridID){
		// 그리드 상태저장/초기화 메뉴 제외 출력
		myContextMenus = myContextMenus.filter(function (contextMenu) {
			return contextMenu.label !== '그리드 상태 저장' && contextMenu.label !== '그리드 상태 초기화';
		});
	}
	
	// 컨텍스트 메뉴 동적 스타일 적용 - 팝업창 뒤에 컨텍스트 메뉴 생기는 오류 수정
	AUIGrid.bind(myGridID, "contextMenu", function( event ) {
		 var style = document.createElement('style');
		 style.type = 'text/css';
		 style.innerHTML = ".aui-grid-context-popup-layer{z-index:1999!important;}";
		 document.body.appendChild(style);
	});
	
	// Insert Key 방지(사용하지 않으려면 false)
	if(useKeyDown == undefined || useKeyDown == null || useKeyDown == true) {
		AUIGrid.bind(myGridID, "keyDown",	function(event) {
			if(event.keyCode == 45) { // Insert  키
				return false; // 기본 행위 안함.
			}
			return true; // 기본 행위 유지
		});
	}
	
	return myGridID;
}

// 헤더 필터 생성 함수
function setFilter(myGridID){
	var selectedItems = AUIGrid.getSelectedItems(myGridID);
	if(selectedItems.length <= 0) return;
	var first = selectedItems[0];
	
	AUIGrid.setColumnProp(myGridID, first.columnIndex, {
		filter : {showIcon : true, displayFormatValues : true}
	});
	AUIGrid.refresh(myGridID); // 리프레시
}

function removeFilter(myGridID){
	var selectedItems = AUIGrid.getSelectedItems(myGridID);
	if(selectedItems.length <= 0) return;
	var first = selectedItems[0];
	AUIGrid.setColumnProp(myGridID, first.columnIndex, {
		filter : {showIcon : false}
	});
	AUIGrid.refresh(myGridID); // 리프레시
}

/**
 * Excel 내보내기
 * @param myGridID grid id
 * @param downLoadName download file name
 */
function exportToXlsx(myGridID, downLoadName) {
	
	if(!AUIGrid.isAvailableLocalDownload(myGridID)) {
		AUIGrid.setProp(myGridID, "exportURL", "./server_script/export.php");
	} else {
		// 내보내기 실행
		AUIGrid.exportToXlsx(myGridID, {
			// 저장하기 파일명
			fileName : downLoadName
		});
	}
}

/**
 * PDF 내보내기(Export)
 * @param myGridID
 * @param downLoadName
 */
function exportToPdf(myGridID, downLoadName) { // IE10 버전부터 지원
	
	if(!AUIGrid.isAvailableLocalDownload(myGridID)) {
		AUIGrid.setProp(myGridID, "exportURL", "./server_script/export.php");
	} else {
		AUIGrid.exportToPdf(myGridID, {
			// 폰트 경로 지정 (반드시 지정해야 함)
			// ttf 파일 브라우저 지원 현황: IE9 / Chrome 4 / FireFox 3.5 / Opera 10.1
			// / Safari 3.1
			fontPath : "../assets/font/Nanumgothic-light.ttf", 

			// 저장하기 파일명
			fileName : downLoadName
		});
	}
}

function getGridDataParam(url, param, divID){
    showLoader(divID);
	return customAjax({
		url : url,
		data : param,
		showLoading : false,
		successFunc : function(data) {
			divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
			AUIGrid.setGridData(divID, data);
            hideLoader(divID);
		}
	});
}

function getGridDataForm(url, formId, divID, func){

    showLoader(divID);

	if($("input:text[numberOnly]").length != 0)
		$("input:text[numberOnly]").val($("input:text[numberOnly]").val().replaceAll(',',''));
	
	formId = typeof formId != "string" ? undefined : formId[0] == "#" ? formId : "#"+formId;
	var param = $(formId).serializeObject();

    return customAjax({
        url : url
        ,data : param
        ,showLoading : false
        ,successFunc : function(data) {
            divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
            AUIGrid.setGridData(divID, data);
            hideLoader(divID);
            
            if(func != undefined && typeof func == "function"){
                func(data);
            }
        }
    })
}

function showLoader(gridID) {
	if(typeof(gridID) == "string" ) {
		if(gridID[0] == "#")
			AUIGrid.showAjaxLoader(''+gridID);
		else
			AUIGrid.showAjaxLoader('#'+gridID);
	} else
		AUIGrid.showAjaxLoader(gridID);
}

function hideLoader(gridID) {
	if(typeof(gridID) == "string" ) {
		if(gridID[0] == "#")
			AUIGrid.removeAjaxLoader(''+gridID);
		else
			AUIGrid.removeAjaxLoader('#'+gridID);
	} else
		AUIGrid.removeAjaxLoader(gridID);
}

/**
 * @param gridId
 *            전체 체크박스를 컨트롤할 그리드 checkBoxName 전체 체크박스 정의할 때 지정한 id 값 ex)
 *            columnLayout.sampleList.addColumn("checkBox",'<br/><input
 *            type="checkbox" id="checksampleList"); checkBoxName =
 *            checksampleList
 */
// 헤더 체크박스 클릭시 전체 체크 , 스크롤이 발생했을 때 체크한 행의 스타일 유지
function checkBoxGridEvent(gridId,checkBoxId){
	AUIGrid.bind(gridId, "vScrollChange", function( event ) {// 수직 스크롤 시
																// 체크박스가 체크된 행들은
																// 색상 변경 처리
		checkBoxStyle(event.pid, "scroll");
	});
	AUIGrid.bind(gridId, "hScrollChange", function( event ) {// 수평 스크롤 시
																// 체크박스가 체크된 행들은
																// 색상 변경 처리
		checkBoxStyle(event.pid, "scroll");
	});
	// 헤더클릭 이벤트(체크박스 전체 선택/해제)
	AUIGrid.bind(gridId, "headerClick", function(event){
		// checkBox 칼럼 클릭 한 경우
		if(event.dataField == "checkBox") {
			if(event.orgEvent.target.id == checkBoxId) { // 정확히 체크박스 클릭 한 경우만
															// 적용 시킴.
				var  isChecked = document.getElementById(checkBoxId).checked;
				allCheckBox(isChecked,gridId,checkBoxId);
			}
		return false;
		}
	});
}
/**
 * 체크박스 전체 체크 설정, 전체 체크 해제 하기
 */
function allCheckBox(isChecked,gridId,checkBoxName) {
	// 전체 체크박스 클릭 시 색상 처리
	if(isChecked) {
		AUIGrid.updateAllToValue(gridId, "checkBox", true);
		allCheckBoxStyle(gridId, true);
	} else {
		AUIGrid.updateAllToValue(gridId, "checkBox", false);
		allCheckBoxStyle(gridId, false);
	}
	document.getElementById(checkBoxName).checked = isChecked;
};

/**
 * 개별 체크박스 행 색상 설정
 */
function checkBoxStyle(gridId, flag, isChecked, rowIndex){
	if($.trim(gridId).substring(0,1) != "#")
		gridId = "#" + gridId;

	var gridTable = $(gridId).find(".aui-grid-table");
	var gridNumCol = $(gridTable[3]).find("tr").find(".aui-grid-row-num-column").find(".aui-grid-renderer-base");// 그리드의
																													// 번호칼럼
																													// 객체를
																													// 가져옴
	var gridNumRow = $(gridTable[1]).find("tr");
	var gridColumnRow = $(gridTable[1]).find("tr");// 그리드 칼럼들의 행 객체를 가져옴
													// console.log(gridColumnRow[0]);
	var fixColumnCheckObj = $(gridTable[1]).find("tr").find(".aui-checkbox")[0];// 체크박스가
																				// 고정
																				// 칼럼이
																				// 아니라면
																				// undefined

	gridEmptyRowCheck(gridNumCol);  // 그리드 첫번째 행에 빈 행이 존재한다면 체크박스 제어 배열에서 제거
	gridEmptyRowCheck(gridColumnRow);
	gridEmptyRowCheck(gridNumRow);

	switch(flag){
		case "scroll" : // 스크롤 시 체크된 행들의 색상 설정
			for(var i=0; i<gridColumnRow.length; i++){
				if(fixColumnCheckObj != undefined )// 고정 칼럼 속성을 적용했을 때와 아닐 때로
													// 나누어 체크박스 객체를 가져옴
					var checkBox = $(gridNumRow[i]).find(".aui-checkbox");
				else
					var checkBox = $($(gridColumnRow[i]).find("td")[0]).find(".aui-checkbox");
				
				if($(checkBox).prop("checked") == true){
					$(gridNumCol[i]).closest("tr").addClass("aui-grid-extra-checked-row");
					$(gridColumnRow[i]).addClass("aui-grid-extra-checked-row");
				}
			}
			break;
		case "click" : // 체크박스 개별 클릭 시 색상 변경
			for(var i in gridNumCol){
				if(isChecked == false && rowIndex+1 == gridNumCol[i].textContent){
					$(gridNumCol[i]).closest("tr").addClass("aui-grid-extra-checked-row");
					$(gridColumnRow[i]).addClass("aui-grid-extra-checked-row");
					break;
				}else if(isChecked == true && rowIndex+1 == gridNumCol[i].textContent){
					$(gridNumCol[i]).closest("tr").removeClass("aui-grid-extra-checked-row"); 
					$(gridColumnRow[i]).removeClass("aui-grid-extra-checked-row");
					break;
				}
			}
			break;
	}
}

// 그리드 첫번째 행에 빈 행이 존재한다면 체크박스 제어 배열에서 제거
function gridEmptyRowCheck(obj){ 
	for(var i=0; i<obj.length; i++){
		if($(obj[i]).closest("tr").find("td").length == 0) 
			obj.splice(i,1);
		else 
			break;
	}
};

/**
 * 전체 체크박스 클릭 시 색상 변경
 */
function allCheckBoxStyle(gridId, flag){
	var rowObj = $(gridId).children(".aui-grid").find(".aui-grid-row-background,.aui-grid-alternative-row-background");
	switch(flag){
		case true :
			for(var i=0; i<rowObj.length; i++){
				$(rowObj[i]).addClass("aui-grid-extra-checked-row");
			}
			break;
		case false :
			for(var i=0; i<rowObj.length; i++){
				$(rowObj[i]).removeClass("aui-grid-extra-checked-row");
			}
			break;
	}
}

/**
 * @param gridId
 *            옮기고 싶은 데이터가 있는 그리드
 * @param target
 *            데이터가 옮겨질 그리드
 */
// 화살표 클릭 시 선택한 행의 정보를 원하는 그리드로 이동
function moveGridData(gridId, target, keyDataField, rowIndex, etcFunc){
	
	// 선택한 행 객체들을 가져옵니다.
	var selectedItems;
	var checkbox = false;	
	
	// Extracheck인 경우
	if(AUIGrid.getColumnIndexByDataField(gridId, "checkBox") == -1){
		selectedItems = AUIGrid.getCheckedRowItems(gridId);
		checkbox = false;
	}else{
		selectedItems = AUIGrid.getItemsByValue(gridId, "checkBox", true);
		checkbox = true;
	}
	
	// selectionMode가 MultipleCells 일 때 행 하나 이상을 선택했을 시 체크박스가 체크된 행보다 우선하여 인식
	// if(selectedItems == undefined || selectedItems == "" ||
	// selectedItems.length <= 1){
	// selectedItems = AUIGrid.getItemsByValue(gridId, "checkBox", true);
	// checkbox = true;
	// }
	if(selectedItems.length != 0){
		// 행 객체들의 데이터를 담을 배열을 선언합니다.
		var dataArray = new Array();
		// 선택한 모든 행들의 데이터를 배열에 담습니다.
		for(var i in selectedItems) {
			switch(checkbox){
				case true:
					Item= selectedItems[i];      // 개별선택된 item들
					break;
				case false:
					Item= selectedItems[i].item; // 전체선택된 item들
					break;
			}
			
			var rows = AUIGrid.getItemsByValue(target, keyDataField, Item[keyDataField]);
			
			if(rows == undefined || rows.length == 0){
				dataArray.push(Item);  // dateArray[]에 선택된 item push
			}
		}
		
		if(etcFunc != undefined)
			etcFunc(dataArray);
		
		// 데이터를 해당 그리드에 세팅합니다.
		addDataRow(target,dataArray, rowIndex);
		removeDataRow(gridId,checkbox, rowIndex);
	}else{
		return false;
	}
}

//그리드 더블클릭했을때 데이터 옮김
function doubleClicMoveGridData(gridId, target, rowIndex, etcFunc){
	var selectedItems = AUIGrid.getSelectedItems(gridId);
	
	if(selectedItems.length != 0){
		// 행 객체들의 데이터를 담을 배열을 선언합니다.
		var dataArray = new Array();
		// 선택한 모든 행들의 데이터를 배열에 담습니다.
		for(var i in selectedItems) {
			dataArray.push(selectedItems[i].item);
		}
		
		if(etcFunc != undefined)
			etcFunc(dataArray);
		
		// 데이터를 해당 그리드에 세팅합니다.
		addDataRow(target, dataArray, selectedItems[0]["rowIndex"]);		
		AUIGrid.removeRow(gridId, selectedItems[0]["rowIndex"]);
	}
}

/**
 * 선택한 행들의 데이터를 원하는 그리드로 이동
 */
function addDataRow(gridId, items, rowIndex) {
	if(rowIndex == undefined)
		rowIndex = "last";
	
	for(var i in items){
		AUIGrid.addRow(gridId, items[i], rowIndex);
	}
	// 옮겨진 행들의 checkBox를 전부 해제
	AUIGrid.updateAllToValue(gridId,"checkBox",false);
}
/**
 * 다른 그리드로 옮겨진 행들을 원래 존재하던 그리드에서 삭제
 */
function removeDataRow(gridId, checkbox, rowIndex) {
	// Extracheck인 경우
	if(AUIGrid.getColumnIndexByDataField(gridId, "checkBox") == -1){
		AUIGrid.removeCheckedRows(gridId);	
	}else{
		if(rowIndex == undefined)
			rowIndex = "selectedIndex";
		
		if(checkbox == true){
			var rows = AUIGrid.getRowIndexesByValue(gridId, "checkBox", true);
			AUIGrid.removeRow(gridId, rows);
			
			if(rows.length == 0){
				AUIGrid.removeCheckedRows(gridId);
			}
		}else{		
			AUIGrid.removeRow(gridId, rowIndex);		
		}
	}
} 

/**
 * @param gridId
 *            옮기고 싶은 데이터가 있는 그리드
 * @param target
 *            데이터가 옮겨질 그리드 ######################## 그리드 속성값으로 체크박스 추가시 사용
 *            showRowCheckColumn : true showRowAllCheckBox : true
 *            ########################
 */
// 화살표 클릭 시 선택한 행의 정보를 원하는 그리드로 이동
function moveCheckedGridData(gridId, target, rowIndex, etcFunc){
	// 선택한 행 객체들을 가져옵니다.
	var checkedItems = AUIGrid.getCheckedRowItems(gridId);

	if(checkedItems){ // 체크된 아이템이 있다면
		AUIGrid.removeCheckedRows(gridId); // 기존 그리드에서 행 삭제
		
		for(var i=0; i<checkedItems.length; i++){ // 이동할 그리드에 행 추가
			AUIGrid.addRow(target, checkedItems[i].item, "last");
		}
	}
}

/**
 * AUIgrid 컬럼추가 (속성값)
 */
function auigridCol(obj) {
	
	obj.addColumn = function(dataField, headerText, width, visible, editable, colspan, style, formatString, dataType, cellMerge, cellColSpan, cellColMerge, lableFunction, showIcon, editRenderer) {
		
		var item = {
			dataField : dataField,
			headerText : headerText
		};
		
		if (width != undefined && width != null) {
			if (typeof width == "string") {
				if (width.indexOf("%") >= 0) {
					item["applyRestPercentWidth"] = true;
				}
			}
			item["width"] = width;
		}
		if (visible != undefined && visible != null) {
			item["visible"] = visible;
		}
		if( cellColMerge != undefined){
			item["cellColMerge"] = cellColMerge;
		}
		if( cellColSpan != undefined){
			item["cellColSpan"] = cellColSpan;
		}
		if (editable != undefined && editable !=null){
			if(editable == true){
				item["editable"] = editable;
				item["style"] = 'readonly';
			} else{
				item["editable"] = false;
			}
		} else {
			item["editable"] = false;
		}
		if(colspan != undefined && colspan != null){
			item["colSpan"] = colspan;
		}
		if(style != undefined && style != null){
			item["style"] = style;
		}
		if(dataType != undefined && dataType != null){
			item["dataType"] = dataType;
		} //
		if(formatString != undefined && formatString != null){
			item["formatString"] = formatString;
		} //
		if(cellMerge != undefined && cellMerge != null){
			item["cellMerge"] = cellMerge;
		} //
		if(lableFunction != undefined && lableFunction != null){
			item["lableFunction"] = function(rowIndex, columnIndex, value, headerText, item, dataField){};
		} //
		if(showIcon != undefined && showIcon != null){
			item["filter"] = {showIcon : showIcon};
		} //
		if(editRenderer != undefined && editRenderer != null){
			console.log(editRenderer);
			item["editRenderer"] = editRenderer;
		} //
		
		item["validHandler"] = []; // 임의로 만듦
		this.push(item);
		return this;
	};

	obj.addColumnCustom = function(dataField, headerText, width, visible, editable, prosCustom) {
		var item = {
			dataField : dataField,
			headerText : headerText
		};
		
		if (width != undefined && width != null) {
			if (typeof width == "string") {
				if (width.indexOf("%") >= 0) {
					item["applyRestPercentWidth"] = true;
				}
			}
			item["width"] = width;
		}
		if (visible != undefined && visible != null) {
			item["visible"] = visible;
		}
		if (editable != undefined && editable !=null){
			if(editable == true){
				item["editable"] = editable;
				item["style"] = 'readonly';
			} else{
				item["editable"] = false;
			}
		} else {
			item["editable"] = false;
		}
		
		// custom col 속성 설정
		if(prosCustom != undefined && prosCustom != null) {
			if(prosCustom.cellMerge != undefined && prosCustom.cellMerge != null){
				item["cellMerge"] = prosCustom.cellMerge;
			}
			if(prosCustom.cellColMerge != undefined && prosCustom.cellColMerge != null){
				item["cellColMerge"] = prosCustom.cellColMerge;
			}
			if (prosCustom.styleFunction != undefined && prosCustom.styleFunction != null){
				item["styleFunction"] = prosCustom.styleFunction;
			}
			if (prosCustom.dataType != undefined && prosCustom.dataType != null){
				item["dataType"] = prosCustom.dataType;
			}
			if (prosCustom.formatString != undefined && prosCustom.formatString != null){
				item["formatString"] = prosCustom.formatString;
			}
			if (prosCustom.style != undefined && prosCustom.style != null){
				item["style"] = prosCustom.style;
			}
			if (prosCustom.showEditorBtnOver != undefined && prosCustom.showEditorBtnOver != null){			
				item["showEditorBtnOver"] = prosCustom.showEditorBtnOver;
			}
			if (prosCustom.editRenderer != undefined && prosCustom.editRenderer != null){
				item["editRenderer"] = prosCustom.editRenderer;
			}
			if (prosCustom.headerTooltip != undefined && prosCustom.headerTooltip != null){
				item["headerTooltip"] = prosCustom.headerTooltip;
			}
			if (prosCustom.labelFunction != undefined && prosCustom.labelFunction != null){
				item["labelFunction"] = prosCustom.labelFunction;
			}
			if (prosCustom.colSpan != undefined && prosCustom.colSpan != null){
				item["colSpan"] = prosCustom.colSpan;
			}
			
			if (prosCustom.editable != undefined && prosCustom.editable != null){
				item["editable"] = prosCustom.editable;
				
				if(item["editable"] == true){
					item["editable"] = true;
					item["style"] = 'readonly';
				} else{
					item["editable"] = false;
				}
			}
			
			if (prosCustom.rowCheckableFunction != undefined && prosCustom.rowCheckableFunction != null){
				item["rowCheckableFunction"] = prosCustom.rowCheckableFunction;
			}
			
			if (prosCustom.rowCheckDisabledFunction != undefined && prosCustom.rowCheckDisabledFunction != null){
				item["rowCheckDisabledFunction"] = prosCustom.rowCheckDisabledFunction;
			}
			
			if (prosCustom.independentAllCheckBox != undefined && prosCustom.independentAllCheckBox != null){
				item["independentAllCheckBox"] = prosCustom.independentAllCheckBox;
			}
			
			if (prosCustom.renderer != undefined && prosCustom.renderer != null){
				item["renderer"] = prosCustom.renderer;
			}
			
			if (prosCustom.headerRenderer != undefined && prosCustom.headerRenderer != null){
				item["headerRenderer "] = prosCustom.headerRenderer;
			}
			
			if(prosCustom.filter != undefined && prosCustom.filter != null){
				item["filter"] = {showIcon : prosCustom.filter};
			}
			
			if(prosCustom.wrapText != undefined && prosCustom.wrapText != null){
				item["wrapText"] = prosCustom.wrapText;
			}

			if (prosCustom.enableMovingColumn != undefined && prosCustom.enableMovingColumn != null) {
				item["enableMovingColumn"] = prosCustom.enableMovingColumn;
			}

			if (prosCustom.disableMoving != undefined && prosCustom.disableMoving != null) {
				item["disableMoving"] = prosCustom.disableMoving;
			}
		}
		
		// item["validHandler"] = []; // 임의로 만듦.....
		this.push(item);
		return this;
	};
	
	obj.addChildColumn = function(parentDataField, dataField, headerText, width, visible, editable, colspan, dataType, cellColSpan, cellColMerge, prosCustom) {
		var item = {
			dataField : dataField,
			headerText : headerText
		};
		if (width != undefined && width != null) {
			if (typeof width == "string") {
				if (width.indexOf("%") >= 0) {
					item["applyRestPercentWidth"] = true;
				}
			}
			item["width"] = width;
		}
		if (visible != undefined && visible != null) {
			item["visible"] = visible;
		}
		if( cellColMerge != undefined){
			item["cellColMerge"] = cellColMerge;
		}
		if( cellColSpan != undefined){
			item["cellColSpan"] = cellColSpan;
		}
		if (dataType != undefined && dataType !=null){
			item["dataType"] = dataType;
		}
		if (editable != undefined && editable !=null){
			if(editable == true){
				item["editable"] = editable;
				item["style"] = 'readonly';
			} else
				item["editable"] = false;
		} else {
			item["editable"] = false;
		}
		if(colspan != undefined && colspan != null){
			item["colSpan"] = colspan;
		}
		
		if(prosCustom != undefined && prosCustom != null) {
			if(prosCustom.cellMerge != undefined && prosCustom.cellMerge != null){
				item["cellMerge"] = prosCustom.cellMerge;
			}
			if (prosCustom.styleFunction != undefined && prosCustom.styleFunction != null){
				item["styleFunction"] = prosCustom.styleFunction;
			}
			if(prosCustom.renderer != undefined && prosCustom.renderer != null){
				item["renderer"] = prosCustom.renderer;
			}
			if (prosCustom.editRenderer != undefined && prosCustom.editRenderer != null){
				item["editRenderer"] = prosCustom.editRenderer;
			}
		}
		
		
		item["validHandler"] = []; // 임의로 만듦
		
		var parentItem = this.getColumnByDataFieldWithChild(parentDataField)
   		if(parentItem != null) {
			if(parentItem.children == undefined || parentItem.children == null) {
				parentItem.children = [];
			}
			
			parentItem.children.push(item);
   		}
		
		
		return this;
	};

    obj.inputEditRenderer = function (dataFields, editProps) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != null) {
    			this.initEditRenderer(item);

                //자유롭게 작성한 inputEditRenderer props 추가 !
                if(!!editProps){
                    for(key in editProps){
                        item.editRenderer[key] = editProps[key];
                    }
                }
    		}
    	}
    	return this;
    };
    
    /**
	 * @param dataFields[{}]
	 *            드랍다운리스트를 생성할 컬럼명
	 * @param lists[]
	 *            리스트
	 * @param keyValue
	 *            true/false keyValue형식의 드랍다운리스트인지 여부
	 */
    obj.dropDownListRenderer = function (dataFields, lists, keyValue, multiple, listTemplateFunction) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			this.initEditRenderer(item);
    			item.editRenderer.type = "DropDownListRenderer";
    			item.editRenderer.showEditorBtnOver = true;
    			if(multiple == true)
    				item.editRenderer.multipleMode = true;
    				
    			if(typeof lists == "function"){
    				item.editRenderer.listFunction = function(rowIndex, columnIndex, item, dataField){
    					return lists(rowIndex, columnIndex, item, dataField);
    				}
    			}else{
    				item.editRenderer.list = lists;
    			}
    			// keyValue형태의 드랍다운리스트라면
    			if(keyValue == true){
    				item.labelFunction = function(  rowIndex, columnIndex, value, headerText, item ) {

                        var lists = this.editRenderer.list;

    					var retStr = value;
    					for(var i=0,len=lists.length; i<len; i++) {
    						if(lists[i]["value"] == value) {
    							retStr = lists[i]["key"];
    							break;
    						}
    					}
    					return retStr;
    				};
    				item.editRenderer.keyField = "value"; 
    				item.editRenderer.valueField = "key"; 
    			}
    			
    			if(listTemplateFunction != undefined && typeof listTemplateFunction == "function"){
    				item.editRenderer.listTemplateFunction = function(rowIndex, columnIndex, text, item, dataField, listItem) {
    					return listTemplateFunction(rowIndex, columnIndex, text, item, dataField, listItem);
    				}
    			}
    		}
    	}
    	return this;
    };

    /**
     * @author shs
     * @param dataFields[] 드랍다운리스트를 생성할 컬럼명
     * @param lists[] 리스트
     * @param keyValue true/false keyValue형식의 드랍다운리스트인지 여부
     * @param listFn 재정의할 listfunction
     * @param validFn 재정의할 validator funtion
     */
     obj.comboBoxRenderer = function (dataFields, lists, keyValue, listFn, validFn, listTemplateFunction) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			this.initEditRenderer(item);

                item.editRenderer.type = "ComboBoxRenderer";
                item.editRenderer.autoCompleteMode = true; // 자동완성 모드 설정
                item.editRenderer.showEditorBtnOver = true; // 마우스 오버 시 에디터버턴 보이기
                item.editRenderer.matchFromFirst = false; // false 설정시 앞에서 부터 일치가 아닌 단순 포함으로 리스트에 출력시킵니다.

                //listFunction 세팅
                if(!!listFn){
    				item.editRenderer.listFunction = function(rowIndex, columnIndex, item, dataField){
    					return listFn(rowIndex, columnIndex, item, dataField);
    				}
                }else {
                    item.editRenderer.list = lists;
                }

                //validator function 기본세팅
    			if( !!validFn ){
    				item.editRenderer.validator = function(oldValue, newValue, item, dataField) {return validFn(oldValue, newValue, item, dataField);}
    			}else{
    				item.editRenderer.validator = function(oldValue, newValue, item, dataField) {
                        var isValid = true;
                        //값이 있는지 검사
                        if( !isObjArrIncludes(lists,newValue) && newValue != "" ) {
                            isValid = false;
                        }
                        // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                        return { "validate" : isValid, "message"  : newValue + " (은)는 입력할 수 없는 값입니다." };
                    }
                }

    			//keyValue형태의 드랍다운리스트라면
    			if(keyValue){

    				item.editRenderer.keyField = "value";
    				item.editRenderer.valueField = "key";
    				item.labelFunction = function(  rowIndex, columnIndex, value, headerText, item ) {
						
    					var retStr = value;
    					for(var i = 0, len = lists.length; i < len; i++) {
    						if(lists[i]["value"] == value) {
    							retStr = lists[i]["key"];
    							break;
    						}
    					}
    					return retStr;
    				};
    			}

    			if(listTemplateFunction != undefined && typeof listTemplateFunction == "function"){
    				item.editRenderer.listTemplateFunction = function(rowIndex, columnIndex, text, item, dataField, listItem) {
    					return listTemplateFunction(rowIndex, columnIndex, text, item, dataField, listItem);
    				}
    			}
    		}
    	}
    	return this;
    };

    obj.numberStepRenderer = function(dataFields,numProps){

        //기본 설정
        var props = {
            type:"NumberStepRenderer",
            min : 0,
            step : 10
        }

        //자유롭게 작성한 NumberStepRenderer props 추가 !
        if(!!numProps){
            for(key in numProps){
                props[key] = numProps[key];
            }
        }

        for(var i = 0; i < dataFields.length; i++) {
            var item = this.getColumnByDataFieldWithChild(dataFields[i]);
            item.formatString = "#,##0";
            item.dataType = "numeric";
            item.editRenderer = props;
        }
        
        return this;
    }

    /**
	 * @param dataFields
	 *            정의할 데이터필드 배열
	 * @param func
	 *            정의한 editRenderer
	 * @param func2
	 *            labelFunction
	 */
    obj.conditionRenderer = function (dataFields, func, func2, template, rendererType) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		var curObj = item;
    		if(item != undefined) {
    			this.initEditRenderer(item);
    			item.type = "ConditionRenderer";
    			
    			item.iconWidth = 16; // icon 사이즈, 지정하지 않으면 rowHeight에 맞게 기본값
										// 적용됨
    			item.iconHeight = 16;
    			item.iconPosition = "aisleRight";
    			item.iconTableRef =  { // icon 값 참조할 테이블 레퍼런스
					"default" : "/AUIGrid/images/list-icon.png" // default
				};
    			
    			if(template == 'TemplateRenderer') {
    				item['renderer'] = {};
        			item.renderer.type = 'TemplateRenderer';
    			}
    			if(rendererType != undefined){
    				if(typeof rendererType == "function")
    					rendererType(curObj);
    				else
    					item[rendererType.name] = rendererType.obj;
    			}
    			if(func2 != undefined){
    				item.labelFunction = function(  rowIndex, columnIndex, value, headerText, item ) {
    					return func2(rowIndex, columnIndex, value, headerText, item);
    				}
    			}
    			
    			item.editRenderer.type = "ConditionRenderer";
    			
    			item.editRenderer.iconWidth = 16; // icon 사이즈, 지정하지 않으면
													// rowHeight에 맞게 기본값 적용됨
    			item.editRenderer.iconHeight = 16;
    			item.editRenderer.iconPosition = "aisleRight";
    			item.editRenderer.iconTableRef =  { // icon 값 참조할 테이블 레퍼런스
					"default" : "/AUIGrid/images/list-icon.png" // default
				};
    			
    			item.editRenderer.conditionFunction = function(rowIndex, columnIndex, value, item, dataField) {
    				if(func != undefined)
    					return func(rowIndex, columnIndex, value, item, dataField, this, curObj);
    			}
    		}
    	}
    	return this;
    };
    
    /**
	 * @param dataFields
	 *            정의할 데이터필드 배열
	 * @param func
	 *            정의한 TemplateRenderer
	 */
    obj.templateRenderer = function (dataFields, func) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			
    			item['renderer'] = {};
    			item.renderer.type = 'TemplateRenderer';
    			
    			item.labelFunction = function(  rowIndex, columnIndex, value, headerText, item ) {
					return func(rowIndex, columnIndex, value, headerText, item);
				}
    		}
    	}
    	return this;
    };
    
    /**
	 * @param dataFields
	 *            색상 정의할 데이터필드 배열
	 * @param gridId
	 *            그리드 div 영역 id
	 * @param value
	 *            체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"}
	 */
    // 체크박스 컬럼 정의 함수
    obj.checkBoxRenderer = function (dataFields,gridId, values, prosCustom, checkV) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var idx = this.getColumnByDataField(dataFields[cnt]);
    		if(idx != -1) {
    			this[idx]["renderer"] = {};
    			this[idx]["headerRenderer"] = {};
    			if(prosCustom != undefined && prosCustom != null) {
    				if(prosCustom.headerRenderer != undefined && prosCustom.headerRenderer != null){
    					this[idx].headerRenderer = prosCustom.headerRenderer;
    				} 
    			}

    			this[idx].editable = true;
    			this[idx].renderer.type = "CheckBoxEditRenderer";
    			this[idx].renderer.showLabel =  false; // 참, 거짓 텍스트 출력여부( 기본값
														// false )
    			this[idx].renderer.editable =  true; // 체크박스 편집 활성화 여부(기본값 :
														// false)
    			this[idx].renderer.checkValue =  values == undefined ? true : values.check; // true,
																							// false
																							// 인
																							// 경우가
																							// 기본
    			this[idx].renderer.unCheckValue =  values == undefined ? false : values.unCheck;
    			
    			

    			this[idx].renderer.checkableFunction = function(rowIndex, columnIndex, value, isChecked, item, dataField ) {
    				if(gridId != undefined && (value == undefined || value == "")){
    					AUIGrid.setCellValue("#"+gridId, rowIndex, columnIndex, false);
    				}
    				
    				// 체크 박스 클릭 시 색상 표시
    				if(gridId != undefined && isChecked != undefined)
    					checkBoxStyle(gridId, "click", isChecked, rowIndex);
    				// 값 줘서 체크 못하게 했음 
    				if(checkV == "T"){
    					return false;
    				} else {
    					return true;
    				}
    			 }

    			// 체크박스 Visible 함수
    			this[idx].renderer.visibleFunction = function(rowIndex, columnIndex, value, isChecked, item, dataField) {
    				// if(item.charge == "Anna")
    				// return false; // 책임자가 Anna 인 경우 체크박스 표시 안함.
    				return true;
    			};
    			// 체크박스 disabled 함수
    			disabledFunction = function(rowIndex, columnIndex, value, isChecked, item, dataField) {
    				// if(item.charge == "Kim")
    				// return true; // true 반환하면 disabled 시킴
    				return false;
    			};
    		}
    	}
    	return this;
    };
    
    /**
	 * @param dataFields
	 *            색상 정의할 데이터필드 배열
	 * @param standardText
	 *            case문 분기 조건
	 * @param style
	 *            적용할 스타일 함수명
	 * @param gridId
	 *            그리드 ID
	 * @param compareDataField
	 *            비교할 값을 가진 다른 데이터필드명 EX)
	 *            columnLayout.styleRenderer(["dataField"],"date","my-row-style(스타일
	 *            함수명)",columnLayout,"compareDataField");
	 */
    // 조건에 따른 셀의 색상 스타일 정의 함수
    obj.styleRenderer = function (dataFields,standardText,style,gridId,compareCoulmn){
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			item.styleFunction = function (rowIndex, columnIndex, value, headerText, item, dataField) {
    				// 동일 행의 다른 데이터필드의 값을 비교하여 해당 셀에 스타일을 주고 싶을 때
    	    		if((compareCoulmn !== undefined && compareCoulmn !== null) && (gridId !== undefined && gridId !== null)){
    	    			var index = AUIGrid.getColumnIndexByDataField("#"+gridId,compareCoulmn);
    	    			value = AUIGrid.getCellValue("#"+gridId,rowIndex,index);
    	    		}
	    			switch(standardText){
		    	    	case "date" :// 날짜
		    	    		var diff = dateToYYYYMMDD(value);// 일자값과 현재 날짜를
																// 비교
		    	    		if(diff <= 3){
		    	    			return style;
		    	    		}
		    	    		break;
		    	    	case "cns" :// 농도
		    	    		if(item.statusCheck == undefined)
		    					item.statusCheck = "true";// (농도 및 순도)정상 미달 여부
															// 구분 dataField
		    	    		value = parseInt(value);
		    	    		if(value < 5 || value == 0){
		    	    			if(item.statusCheck == "true")
		    	    				item.statusCheck = "false"; 
		    	    			return style;
		    	    		}
		    	    		break;
		    	    	case "pur" :// 순도
		    	    		if(item.statusCheck == undefined)
		    					item.statusCheck = "true";
		    	    		value = parseFloat(value);
		    	    		if(value > 2.5 || value < 1 || value == 0){
		    	    			if(item.statusCheck == "true") 
		    	    				item.statusCheck = "false"; 
		    	    			return style;
	    	    			}
		    	    		break;
		    	    	case "hmogCstYn" :// 인체유래물 동의서
		    	    		if(value == 'Y'){
		    	    			return style;
		    	    		}
		    	    		break;
		    	    	default : 
		    	    		return style;
		    	    		break;
	    			}
    			}
    		}
    	}
    	return this;
    };
    
    // AUIGrid 달력
    obj.calendarRenderer = function (dataFields) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			item["editRenderer"] = {};
    			item["editable"] = true;
    			item.dataType = "date";
    			item.editRenderer.type = "CalendarRenderer";
    			item.editRenderer.showEditorBtnOver = true;// 마우스 오버 시 에디터버턴 출력
    			item.editRenderer.onlyCalendar = true; // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
    			item.editRenderer.showExtraDays = true;  // 지난 달, 다음 달 여분의 날짜(days) 출력
    			item.editRenderer.defaultFormat = "yyyy-mm-dd";
                item.editRenderer.validator = function(oldValue, newValue, rowItem) { // 에디팅 유효성 검사

                    var isValid = true;
                    var pattern = /^[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
                    var isValid = (pattern.test(newValue)) ? true : false

                    // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                    return { "validate" : isValid, "message"  : getFormatDate() + " 형식으로 입력해주세요." };
                }
            };
        }
    	return this;
    };
    
    /**
	 * @param func
	 *            콜백함수
	 */
    obj.buttonRenderer = function (dataFields, func, editable, labelText, props, func2) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			item["renderer"] = {};
    			if(editable != undefined)
    				item["editable"] = editable;
    			else
    				item["editable"] = true;

    			item.renderer.type = "ButtonRenderer";
                
    			if(labelText != undefined)
    				item.renderer.labelText = labelText;
    			
    			item.renderer.onclick = func;
    			
    			if(func2 != undefined){
    				item.renderer.disabledFunction = func2;
    			}
    		};
    	}
    	return this;
    };
    
    /**
	 * @param imgRef
	 *            이미지 경로
	 * @param clickFunc
	 *            콜백함수
	 */
    obj.iconRenderer = function(dataFields, imgRef, clickFunc, imgWidth, imgHeight){
    	for(var cnt = 0; cnt < dataFields.length; cnt++){
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined){
    			item["renderer"] = {};
    			item.renderer.type = "IconRenderer";
    			if(imgWidth != undefined)
    				item.renderer.iconWidth = imgWidth;
    			if(imgHeight != undefined)
    				item.renderer.iconHeight = imgHeight;
    			if(imgRef != undefined)
    				item.renderer.iconTableRef = { "default" : imgRef }
    			if(clickFunc != undefined){
    				item.renderer.onclick = function(rowIndex, columnIndex, value,  item) {
    					return clickFunc(rowIndex, columnIndex, value, item);
    				}
    			}
    		}
    	}
    };
    
   
    obj.addValidator = function(dataFields, validatorName, etc1, etc2, etc3, etc4, gridId) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined) {
    			if(item.editRenderer == undefined || item.editRenderer == null) {
    				this.initEditRenderer(item);
    			}
    			var valFunc = null;
    			switch(validatorName) {
    				case "NotEmpty":
    					valFunc = this.validNotEmpty;
    					break;
    				case "Length":
    					item.validatorLength = etc1;
    					valFunc = this.validLength;
    					break;
    				case "NotChange":
    					valFunc = this.validNotChange;
    					break;
    				case "UpperCase":
    					valFunc = this.validUpperCase;
    					break;
    				case "Regex":
    					item.validatorRegexExpression = etc1;
    					item.validatorRegexFalseMsg = etc2;
    					valFunc = this.validRegex;
    					break;
    				case "OnlyNum":
    					item.validatorRegexFalseMsg = etc2;
    					valFunc = this.validOnlyNumber;
						break;
    				case "UniqueValue":
    					item.validatorUniqueValueMsg = etc1;
    					item.gridId = gridId;
    					valFunc = this.validatorUniqueValueCheck;
						break;
					case "ByteCheck":
						item.validatorByte = etc1;
						valFunc = this.validByte;
						break;
    				default :
    					break;
    			}
    			item.validHandler.push(valFunc);
    		}
    	}
    	return this;
    };

	obj.validByte = function(oldValue, newValue, item, dataField, columnInfo) {
		newValue = $.trim(newValue);
		var maxByte = columnInfo.validatorByte;
		var strLength = newValue.length;
		var rbyte = 0;
		var oneChar = "";

		for (var i = 0; i < strLength; i++) {
			oneChar = newValue.charAt(i);
			if (escape(oneChar).length > 4) {
				rbyte += 2; //한글은 2Byte
			} else {
				rbyte++; //나머지 1Byte
			}
		}

		if (rbyte > maxByte) {
			return { "validate" : false, "message" : "입력 가능한 범위를 초과하였습니다."};
		} else {
			return { "validate" : true };
		}
	}

    // 유일성 체크 함수 (중복값 체크)
    obj.validatorUniqueValueCheck = function(oldValue, newValue, item, dataField, columnInfo) {
    	var isValid = AUIGrid.isUniqueValue("#"+columnInfo.gridId, dataField, newValue);
    	if(!isValid){
    		return { "validate" : false, "message" : columnInfo.validatorUniqueValueMsg };
    	} else {
    		return { "validate" : true };
    	}
    };
    
    obj.addColumnProperty = function(dataFields, properties) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var idx = this.getColumnByDataField(dataFields[cnt]);
    		if(idx != -1) {
    			for(var item in properties) {
    				this[idx][item] = properties[item];
    				item["editRenderer"] = properties;
    			}
    		}
    	}
    	return this;
    };

    obj.addColumnProperty2 = function(dataFields, properties) {
    	for(var cnt = 0; cnt < dataFields.length; cnt++) {
    		var item = this.getColumnByDataFieldWithChild(dataFields[cnt]);
    		if(item != undefined){
    			for(var property in properties) {
    	    		item[property] = properties[property];
    	    		property["editRenderer"] = properties;
    			}    		
    		}
    	}
    	return this;
    };

    obj.validNotEmpty = function(oldValue, newValue, item, dataField, columnInfo) {
    	newValue = $.trim(newValue);
    	if(newValue == "" || newValue == null){
			return { "validate" : false, "message" : columnInfo.headerText +"을(를) 입력하세요"};
		} else {
			return { "validate" : true };
		}
    };
    
    obj.validLength = function(oldValue, newValue, item, dataField, columnInfo){
    	newValue = $.trim(newValue);
    	if(newValue.length != columnInfo.validatorLength){
			return { "validate" : false, "message" : columnInfo.headerText +"은(는) " + columnInfo.validatorLength + "자리여야 합니다"};
		} else {
			return { "validate" : true };
		}
    };
    
    obj.validNotChange = function(oldValue, newValue, item, dataField, columnInfo){
    	newValue = $.trim(newValue);
    	oldValue = $.trim(oldValue);
    	if(oldValue != newValue && oldValue != null && oldValue != ""){
    			return { "validate" : false, "message" : columnInfo.headerText +"은(는) 변경할 수 없습니다."};
		} else {
			return { "validate" : true };
		}
    };
    
    obj.validUpperCase = function(oldValue, newValue, item, dataField, columnInfo){
    	newValue = $.trim(newValue);
    	var arr = [];
    	for(var i=0; i<newValue.length; i++){
    			arr.push(newValue.substring(i,i+1));
    	}
    	
    	for(var i in arr){
    		if(arr[i].match(/[^A-Z]/) && isNaN(arr[i])){
    			return { "validate" : false, "message" : columnInfo.headerText +"의 영문은 대문자여야 합니다."};
    		}
    	}
		return { "validate" : true };
	};
	
	obj.validRegex = function(oldValue, newValue, item, dataField, columnInfo){
    	newValue = $.trim(newValue);
    	if(!newValue.match(columnInfo.validatorRegexExpression)){
			return { "validate" : false, "message" : columnInfo.validatorRegexFalseMsg };
		} else {
			return { "validate" : true };
		}
	};
	
	obj.validOnlyNumber = function(oldValue, newValue, item, dataField, columnInfo){
		newValue = $.trim(newValue);
		if(newValue != "" && !$.isNumeric(newValue)){
			return { "validate" : false, "message" : columnInfo.validatorRegexFalseMsg };
		} else {
			return { "validate" : true };
		}
	}
	
    obj.initEditRenderer = function (columnInfo) {
    	columnInfo.editRenderer = { type : "InputEditRenderer" };
    	columnInfo.editable = true;
    	columnInfo.validHandler = [];
		columnInfo.editRenderer.validator = function(oldValue, newValue, item, dataField){
			for(var cnt2 = 0; cnt2 < columnInfo.validHandler.length; cnt2++) {
				var result = columnInfo.validHandler[cnt2](oldValue, newValue, item, dataField, columnInfo);
				if(result.validate == false)
					return result;
			}
			return { "validate" : true };
		};
    };
    
    obj.getColumnByDataField = function (dataField) {
    	var idx = -1;
    	for(var cnt = 0; cnt < this.length; cnt++) {
    		if(this[cnt]["dataField"] == dataField) {
    			idx = cnt;
    		}
    	}
    	
    	if(idx == -1) {
    		warn(dataField + "를 찾을 수 없음.");
    	}
    	return idx;
    };

    obj.getColumnByDataFieldWithChild = function (dataField) {
    	var idx = -1;
    	for(var cnt = 0; cnt < this.length; cnt++) {
    		if(this[cnt]["dataField"] == dataField) {
    			return this[cnt];
    		}
    		var item = this.getColumnChild(this[cnt], dataField);
    		if(item != null)
    			return item;
    	}
		warn(dataField + "를 찾을 수 없음.");
    	return null;
    };
    
    obj.getColumnChild = function (columnParent, dataField) {
		if(columnParent.children != undefined && columnParent.children != null) {
	    	for(var cnt2 = 0; cnt2 < columnParent.children.length; cnt2++) {
	    		if(columnParent.children[cnt2]["dataField"] == dataField) {
	    			return columnParent.children[cnt2];
	    		}
	    		var item = this.getColumnChild(columnParent.children[cnt2], dataField); 
		    	if(item != null)
		    		return item;
	    	}
		}
		
		return null;
    }
    
	obj.addColumnInnerColspan = function(dataField) {
		var item = {
			dataField : dataField,
			colSpan : -1 
		};
		item["validHandler"] = []; // 임의로 만듦
		this.push(item);
		return this;
	}
}

// 현재 날짜와 인자로 받은 yyyy-MM-dd형식의 날짜값 비교
function dateToYYYYMMDD(value){
	if(value != undefined && value != ""){
		var date = new Date();
		var crrDate = new Date(date.getFullYear(), Number(zeroPad(date.getMonth())), Number(zeroPad(date.getDate())));
		if(value.indexOf("-") != -1){
			var valueArray = value.split("-");
		}else if(value.indexOf("/") != -1){
			var valueArray = value.split("/");
		}

		value = new Date(valueArray[0],valueArray[1]-1,valueArray[2]);
	    var crrDay = 24 * 60 * 60 * 1000;
	    var diff = value - crrDate;
	    return parseInt(diff/crrDay);
	}
}

// 그리드 사이즈 조절
/**
 * @param gridIds =
 *            [];
 */
function gridResize(gridIds){
	
	window.addEventListener('resize', function (e) {
		// 크기가 변경되었을 때 AUIGrid.resize() 함수 호출
		gridIds.forEach(function (gridId) {
			if (!!gridId) {
				var grid = gridId.indexOf('#') === -1 ? '#' + gridId : gridId; 
				AUIGrid.resize(grid);
			}
		});
	});
}

// 그리드 사이즈 조절
/**
 * @param myGridID =
 *            "";
 * @param sMode =
 *            "1" Or "2"
 */
function gridColResize(myGridID, sMode){
	var gridData =  AUIGrid.getGridData(myGridID);
	if (gridData.length == 0)
		return;
	
	var colSizeList;
	if (sMode == "1")	// 그리드 크기에 상관없이 최적의 컬럼 사이즈 자동 조절
		colSizeList = AUIGrid.getFitColumnSizeList(myGridID);
	else if(sMode == "2") // 그리드 크기에 맞게 최적의 컬럼 사이즈 자동 조절
		colSizeList = AUIGrid.getFitColumnSizeList(myGridID, true);
	else
		return;
	
	AUIGrid.setColumnSizeList(myGridID, colSizeList);
}

// 그리드 데이터 초기화
function clearGridData(myGridID){
	AUIGrid.clearGridData(myGridID);
}

/**
 * grid clear
 * @param {string[]} grids : grids ids
 * @author shs
 */
function clearGrids(grids){
    for(var i=0; i<grids.length; i++){
        AUIGrid.clearGridData(grids[i]);
    }
}

/**
 * 행 클릭시 AddRow로 추가된 행이라면 행삭제 버튼 보이게, 아니라면 안보이게
 * 
 * @param gridId
 *            그리드Id
 * @param selector
 *            행삭제 버튼의 id
 */
function btnRmRowEvent( gridId, event, selector ){
	selector = typeof selector == "string" ? selector[0] == "#" ? selector : "#"+selector : undefined;
  	
  	// 행삭제 버튼 클릭하면 해당 그리드의 선택되어 있는 행이 삭제
  	$(selector).off("click");
  	$(selector).on("click", function(e){
  		AUIGrid.removeRow(gridId, "selectedIndex");
			$(selector).hide();
  	});
  	
  	var addedRowItems = AUIGrid.getAddedRowItems(gridId);
	$(selector).hide();
	// 새로 추가된 행을 클릭 할 때 삭제 버튼 출력
	for(var i in addedRowItems){
		if(buttonFlag(event, addedRowItems, i, selector)){
			return buttonFlag;
		}
	}
}

// 추가된 행에만 삭제버튼 출력
function buttonFlag(event, addedRowItems, i, id){
	var eventUid = event.item._$uid == undefined ? event.item.null : event.item._$uid;
	var addedUid = addedRowItems[i]._$uid == undefined ? addedRowItems[i].null : addedRowItems[i]._$uid;
	switch (event.item._$uid){
		case addedRowItems[i]._$uid :
			$(id).show();// 행삭제 버튼 출력
			return true;
		default :
			$(id).hide();// 행삭제 버튼 제거
  			return false;
  	}
}

// 검색 후 해당 row로 이동(단, 검색이 여러개 되는 경우 첫번째 위치로)
function gridSelectRow(gridID, columnID, columnValue){
	// columnID 열에서 columnValue 와 같은 데이터가 있는 rowIndex를 찾음
	var rows = AUIGrid.getRowIndexesByValue(gridID, columnID, columnValue);
	// Uniq하다는 가정하에 해당행의 첫번째 컬럼에 포커스 이동
	if (rows.length == 0)
		return;
	AUIGrid.setSelectionByIndex(gridID, rows[0]);
}
