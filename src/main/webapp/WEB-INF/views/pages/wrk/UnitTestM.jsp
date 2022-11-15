<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
	<h2><i class="fi-rr-apps"></i>단위 테스트 목록</h2><!-- 단위 테스트 목록 -->
		<div class="btnWrap">
			<button type="button" id="btnMenuSave" class="save">메뉴별 담당자 관리</button> <!-- 메뉴별 담당자 관리 -->
			<input type="hidden" id="btnDialogMenuCharger" class="save" value="dialogButton">	<!-- 메뉴별 담당자 관리 다이어로그 -->
			<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm">							
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
					<th>메뉴</th> <!-- 메뉴 -->
					<td><select id="srcMenuSeqno" name="srcMenuSeqno" style="width: 100%;"></select></td>		
					<th>메뉴명</th> <!-- 사용여부 -->
					<td><input type="text" id="srcMenuNm" name="srcMenuNm" class="enterKeypress"></td>	
					
					<th>담당자</th> <!-- 담당자 -->
					<td><input type="text" id="srcChargetNm" name="srcChargetNm" class="enterKeypress"></td>
					
					<th>처리여부</th> <!-- 처리여부 -->
					<td>
						<select id="srcProcessAt" name="srcProcessAt">
							<option value="" selected>선택</option>
							<option value="N">미완료</option>
							<option value="Y">완료</option>
							<option value="W">보류</option>
						</select>
					</td>
					
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="unitTestGrid" style="width:100%; height:250px; margin:0 auto;"></div>
		</div>
		<div class="mapkey">
        	<label class="scarce">공통 수정시 메뉴 "공통" 선택해야 함.</label><!-- 반려 -->
    	</div>
	</div>
	<form id="saveFrm" onsubmit="return false;">
		<div class="subCon1 mgT14" id="detail">
			<h2>
			<!-- 단위테스트 상세 정보 -->
			<i class="fi-rr-apps"></i>단위테스트 상세 정보</h2>
			<div class="btnWrap">
				<!-- 신규 -->
				<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button>
				<!-- 삭제 -->
				<button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button>
				<!-- 저장 -->
				<button type="button" id="btnSave" class="save" >저장</button>
			</div>

			<table cellpadding="0" cellspacing="0" width="100%"class="subTable1" id="subTable1">
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
					<!-- 메뉴 -->
					<th class="taCt vaMd necessary">메뉴</th>
					<td><select id="menuSeqno" name="menuSeqno" required onchange="chageMenu()" style="width: 100%;"></select></td>

					<!-- 담당자 -->
					<th class="necessary">담당자</th>
					<td><input type="text" id="chargerNm" name="chargerNm" class="wd100p" disabled></td>
					
					<!-- 테스터 -->
					<th class="necessary">테스터</th>
					<td><input type="text" id="testerNm" name="testerNm" required></td>
					
					<!-- 처리여부 -->
					<th class="necessary">처리 여부</th>
					<td>
						<select id="processAt" name="processAt" required>
							<option value="N" selected>미완료</option>
							<option value="Y">완료</option>
							<option value="W">보류</option>
						</select>
					</td>
				</tr>
				<tr>
					<!-- 테스트 일시 -->
					<th>테스트 일시</th>
					<td><input type="text" id="testDte" name="testDte" class="dateChk"></td>
					
					<td></td>
					<td></td>
					<td></td>
					<td></td>
					
					<!-- 처리 일시 -->
					<th>처리 일시</th>
					<td><input type="text" id="processDte" name="processDte" class="dateChk"></td>					
				</tr>
				<tr>
					<!-- 테스트 내용-->
					<th>테스트 내용</th>
					<td colspan="7"><textarea rows="2" id="testCn" name="testCn"></textarea></td>
				</tr>
				<tr>
					<!-- 처리 내용 -->
					<th>처리 내용</th>
					<td colspan="7"><textarea rows="2" id="processCn" name="processCn"></textarea></td>			
				</tr>
				<tr>
					<!-- 비고-->
					<th>비고</th>
					<td colspan="7"><textarea rows="2" id="rm" name="rm"></textarea></td>			
				</tr>
			</table>
			<input type="text" id="unitTestSeqno" name="unitTestSeqno" style="display:none">
			<input type="hidden" id="crud" value="C">
		</div>
	</form>
</div>
	
</tiles:putAttribute>
    
<tiles:putAttribute name="script">
<script>

	//AUIGrid 생성 후 반환 ID
	var unitTestGrid = "unitTestGrid";
	var searchFrm = document.getElementById('searchFrm');
	var saveFrm = document.getElementById('saveFrm');
	var saveKey = '';
	
	document.addEventListener("DOMContentLoaded", function() {
		// 초기설정.
		init();
		
		// 콤보 셋팅
		setCombo();

		// 그리드 생성
		setUnitGrid();
		
		// 그리드 이벤트
		setUnitGridEvent()
		
		// 버튼 이벤트
		setButtonEvent();
		
		// 기타 이벤트
		setEtcEvent();
		
		// 다이어로그 
		renderingDialog();
		
		//그리드 사이즈 조절
		gridResize([unitTestGrid]);
	});
	
	function init(){
		datePickerCalendar(["testDte"], false, ["DD",0]);
		datePickerCalendar(["processDte"], false, ["DD",0]);
	}
	
	//콤보로드
	function setCombo() {
		ajaxSelect2Box({
			ajaxUrl : '/sys/getAllMenuCharger.lims'
			,elementId : 'srcMenuSeqno'
		});
		ajaxSelect2Box({
			ajaxUrl : '/sys/getAllMenuCharger.lims'
			,elementId : 'menuSeqno'
		});
	}
	
	//그리드 생성
	function setUnitGrid(){
		
		////그리드 정의 userGrid
		var unitTestCol = [];		
		auigridCol(unitTestCol);
		
		var unitTestColPros = {
			wordWrap : true, 
			//rowHeight : 80,  // 고정할 행 높이
			enableCellMerge : true,
			editable : true,
			rowStyleFunction: function (rowIndex, item) {
                return (item.menuNm === "공통") ? "grid-scarce" : "";
            }
		};
        
		unitTestCol.addColumnCustom("menuNm","메뉴명");					/* 메뉴명 */
		unitTestCol.addColumnCustom("chargerNm","담당자"); 				/* 담당자 */
		unitTestCol.addColumnCustom("processAtNm","처리 여부");				/* 처리 여부 */
		unitTestCol.addColumnCustom("testDte","테스트 일자"); 				/* 테스트 일자 */
		unitTestCol.addColumnCustom("testerNm","테스터"); 				/* 테스터 */
		unitTestCol.addColumnCustom("testCn","테스트 내용", 500, true, true, {wrapText : true}); 				/* 테스트 내용 */
		unitTestCol.addColumnCustom("processCn","처리 내용", 500, true, true, {wrapText : true});				/* 처리 내용 */
		unitTestCol.addColumnCustom("rm","비고"); 						/* 비고 */
		
		unitTestGrid = createAUIGrid(unitTestCol, "unitTestGrid", unitTestColPros);
		setUnitGridEvent();
		
	};
	
	//그리드 이벤트
	function setUnitGridEvent(){
		
		// AUI 데이터 변경 후 선택 이벤트
        AUIGrid.bind(unitTestGrid, "ready", function() {
            if ( !!saveKey ){
                gridSelectRow(unitTestGrid, "unitTestSeqno", [saveKey]);
            }
            saveKey = '';
        });
		
		// 그리드 더블 클릭 이벤트
		AUIGrid.bind(unitTestGrid, "cellDoubleClick", function(event) {
			document.getElementById('btnDelete').style.display = '';
			document.getElementById("crud").value = 'U'
			detailAutoSet({targetFormArr : ["saveFrm"], item : event.item})
		});
	
	};

	//버튼 이벤트
	function setButtonEvent(){
		
		// 메뉴별 담당자 관리 버튼 클릭.
		document.getElementById("btnMenuSave").addEventListener('click', function(){
			document.getElementById('btnDialogMenuCharger').click();
		});
		
		// 조회 버튼 클릭.
		document.getElementById("btnSearch").addEventListener('click', function(){
			searchUnitTest()
		});
		
		// 신규
		document.getElementById("btnNew").addEventListener('click', function(){
			frmReset();
		});

		// 삭제
		document.getElementById("btnDelete").addEventListener('click', function(){
			if(!confirm("${msg.C100000461}")) {  /* 삭제하시겠습니까? */
				return;
			}else {
				deleteUnitTest();
			}
		});
		
		//저장
		document.getElementById("btnSave").addEventListener('click', function(){
			saveUnitTest()
		});
		
	};
	
	//기타이벤트
	function setEtcEvent(){
		
		// 엔터키 조회 이벤트.
		var keypressBox = document.getElementsByClassName("enterKeypress");
		for(var i=0; i<keypressBox.length; i++) {
			keypressBox[i].addEventListener('keypress', function(e){
				if(e.which == 13) {
					document.getElementById("btnSearch").click();
				}
			})
		}
		
	}
	
	function renderingDialog(){
		dialogUnitTest({
            btnId: 'btnDialogMenuCharger',
            dialogId: 'unitTestDialogExmnt',
            url: '/sys/getAllMenuCharger.lims'
        });
	}
	
	function searchUnitTest() {
		getGridDataForm("/sys/getUnitTestList.lims", "searchFrm", unitTestGrid);
	}
	
	function frmReset() {
		document.getElementById("btnDelete").style.display = 'none';
		document.getElementById("processDte").value = ""
		document.getElementById("testCn").value = ""
		document.getElementById("processCn").value = ""
		document.getElementById("rm").value = ""
		document.getElementById("crud").value = 'C'
	}
	
	function deleteUnitTest() {
		
		var crud = document.getElementById("crud").value;
		var param = document.getElementById("saveFrm").toObject();
		
		if(crud == "U") {
			var ajax = customAjax({
				'url': "/sys/deleteUnitTest.lims",
				'data': param,
				"successFunc": function() {
					success("단위테스트가 삭제되었습니다.");  /* 단위테스트가 삭제되었습니다. */
					frmReset();
					document.getElementById("btnSearch").click();
				}
			});
		} 

	}
	
	function saveUnitTest() {
		
		if(!saveValidation("saveFrm")) {
			return;
		}
		
		var crud = document.getElementById("crud").value;
		var param = document.getElementById("saveFrm").toObject();
		
		if(crud == "C") {
			var ajax = customAjax({
				'url': "/sys/saveUnitTest.lims",
				'data': param
			});
			ajax.then(function(res, status) {
				if(status === 'success') {
					success("단위테스트가 등록되었습니다.");  /* 단위테스트가 등록되었습니다. */
					saveKey = res.unitTestSeqno;
					frmReset();
					document.getElementById("btnSearch").click();
				}
			});
		} else {
			var ajax = customAjax({
				'url': "/sys/updateUnitTest.lims",
				'data': param
			});
			ajax.then(function(res, status) {
				if(status === 'success') {
					success("단위테스트가 수정되었습니다.");  /* 단위테스트가 수정되었습니다. */
					saveKey = res.unitTestSeqno;
					frmReset();
					document.getElementById("btnSearch").click();
				}
			});
		}
	
	}
	
	function chageMenu() {
		
		var menuSeqno = document.getElementById("menuSeqno").value;
		var chargerBox = document.getElementById("chargerNm");
		
		if(menuSeqno == "" || menuSeqno == null) {
			chargerBox.value = "";
		} else {
			
			var ajax = customAjax({
				'url': "/sys/changeInputChargerNm.lims",
				'data': menuSeqno,
				"successFunc": function(data) {
					chargerBox.value = data.chargerNm;
				}
			});
		}
	}
	
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>
