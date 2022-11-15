<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000706}</h2> <!-- 자격기준 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" name="searchFrm" onsubmit="return false" >
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
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
					<th>${msg.C100000712}</th> <!-- 자격자 적격성 구분 -->
					<td><select id="qualfElgblSeCodeSch" name="qualfElgblSeCodeSch"></select></td>
					<th>${msg.C100000241}</th> <!-- 기준명 -->
					<td><input type="text" id="stdrNmSch" name="stdrNmSch" class="schClass"></td>
					<th class="taCt vaMd" style="min-width: 100px;">${msg.C100000443}</th>
					<td>
					<label><input type="radio" name="useAtSch" value="all">${msg.C100000779}</label>
					<label><input type="radio"	name="useAtSch" value="Y" checked="checked">${msg.C100000439}</label>
					<label><input type="radio" name="useAtSch" value="N">${msg.C100000442}</label></td>
				</tr>
			</table>
		</form>
		</div>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
	    <div class="subCon2">
            <div id="QualfStdrGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div> 
        </div>  
	
	
		<div class="subCon1 mgT20">
			<h2><i class="fi-rr-apps"></i>${msg.C100000707}</h2> <!-- 자격기준 정보 -->
			<div class="btnWrap">
				<button id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
				<button id="btndel" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
				<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
			</div>
			<form id="QualfStdrMForm">
				<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
					<colgroup>
						<col style="width:10%"></col> 
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
						<col style="width:10%"></col>			
					</colgroup>
					<tr>			
						<th>${msg.C100000432}</th> <!-- 사업장 -->
						<td>
						<select id="bplcCode" name="bplcCode"  class="wd100p" style="min-width:10em;"></select>
						</td>
					
						<th class="necessary">${msg.C100000712}</th> <!-- 자격자 적격성 구분 -->
						<td><select id="qualfElgblSeCode" name="qualfElgblSeCode" required></select></td>
	
						<th class="necessary">${msg.C100000241}</th> <!-- 기준명 -->
						<td><input type="text" id="stdrNm" name="stdrNm" maxlength = "200"></td>
						
						<th>${msg.C100000443}</th>
						<td>
						<label><input type="radio" id="useAtY" name="useAt" value="Y" checked>${msg.C100000439}</label>
						<label><input type="radio" id="useAtN" name="useAt" value="N">${msg.C100000442}</label></td>
					</tr>
			         <tr>    				
						<th>${msg.C100000425}</th> <!-- 비고 -->
			            <td colspan="7"><textarea id="rm" name="rm" rows="2" style="width:100%;" maxlength = "4000"></textarea></td>				
					</tr>
					<tr>
						<th>${msg.C100000860}</th> <!-- 첨부파일 -->
						<td colspan="8">
							<!-- 파일첨부영역 -->
							<div id="dropZoneArea"></div>
							<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;">
							<input type="hidden" id="btnSave_atchmnflSeqno" value="첨부파일">
						</td>
					</tr>
				</table>
				<input type="text" id="qualfStdrSeqno" name="qualfStdrSeqno" style="display:none">
			</form>
		</div>
		<div style="display:flex">
			<div class=" wd50p mgT20" style=display:inline;>
				<div class="subCon1">
					<h3>${msg.C100000361}</h3> <!-- 배점 기준 목록 -->
					<div class="btnWrap">
						<button type="button" id="btnAdd1" class="btn5"><img src="/assets/image/plusBtn.png"></button><!-- 행 추가 -->
						<button type="button" id="btnRemove1" class="delete"><img src="/assets/image/minusBtn.png"></button><!-- 행 삭제 -->
					</div>
				</div>
				<div class="subCon2">
					<div id="ScoringGrid" class="mgT5 grid wd99p" style="height: 200px;"></div>
				</div>
			</div>
			<div class = "wd50p mgT20" style="margin-left:2%; display:inline-block;">
				<div class="subCon1">
					<h3>${msg.C100000235}</h3> <!-- 기준 결과 목록 -->
					<div class="btnWrap">			
						<button type="button" id="btnAdd2" class="btn5"><img src="/assets/image/plusBtn.png"></button><!-- 행 추가 -->
						<button type="button" id="btnRemove2" class="delete"><img src="/assets/image/minusBtn.png"></button><!-- 행 삭제 -->
					</div>
				</div>
				<div class = "subCon2">
					<div id="BaseLineGrid" class="mgT5 grid wd99p" style=" height: 200px;"></div>
				</div>
			</div>
		</div>	
</div>

<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var QualfStdrGrid = 'QualfStdrGrid';	//자격기준 그리드
	var ScoringGrid = 'ScoringGrid';		//배점기준 그리드
	var BaseLineGrid = 'BaseLineGrid';		//기준결과 그리드
	var dropZoneArea;
	var authorSeCode = "${UserMVo.authorSeCode}";
	$(function() {
		//권한체크
		getAuth();
		
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setQualfStdrGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setQualfStdrGridEvent();

	    // 그리드 리사이즈
	    gridResize([QualfStdrGrid,ScoringGrid,BaseLineGrid]); 

	    // 콤보 데이터 세팅
	    setCombo();
	    
	    
	    dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnSave_atchmnflSeqno" ,lang : "${msg.C100000867}"} );
	});
	
	function setCombo(){
	    ajaxJsonComboBox('/com/getCmmnCode.lims', 'qualfElgblSeCodeSch', {'upperCmmnCode': 'RS13'}, false,"${msg.C100000480}"); /* 선택 */
	    ajaxJsonComboBox('/com/getCmmnCode.lims', 'qualfElgblSeCode', {'upperCmmnCode': 'RS13'}, false,"${msg.C100000480}"); /* 선택 */
		ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{"bestInspctInsttAt" : "Y", isRdmsIp : true},true,null,'${UserMVo.bestInspctInsttCode}');
	}
	
 	// 그리드 생성
	function setQualfStdrGrid() {
		
 		/* 자격기준 그리드 세팅 */
	    //그리드 컬럼 담을 배열 정의	
	    var QualfStdrCol = [];
	    var ScoringCol = [];
	    var BaseLineCol = [];
	    
	    var gridColPros = {
	    		style : "my-require-style",
	    		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
	    			show : true,
	    			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
	    		}
    	};
	    var testPros = { 
	    		editable:true,
	    		enableDrag : true,
	    		enableMultipleDrag : true,
	    		enableDragByCellDrag : true,
	    		enableDrop : true
	    }
	    
	    
	    auigridCol(QualfStdrCol);
	    auigridCol(ScoringCol);
	    auigridCol(BaseLineCol);
	    
		    QualfStdrCol.addColumnCustom("bplcCode", "사업장", null, false, false ); /* 사업장 */
		    QualfStdrCol.addColumnCustom("bplcCodeNm", "${msg.C100000432}", null, true, false ); /* 사업장 */
		    QualfStdrCol.addColumnCustom("qualfElgblSeCode", "자격 적격성 구분", null, false, false); /* 자격 적격성 구분 */
		    QualfStdrCol.addColumnCustom("qualfElgblSeCodeNm", "${msg.C100000712}", null, true, false); /* 자격 적격성 구분 */
		    QualfStdrCol.addColumnCustom("stdrNm", "${msg.C100000241}", null, true, false); /* 기준명 */
		    QualfStdrCol.addColumnCustom("rm", "${msg.C100000425}", null, true, false); /* 비고 */
		    QualfStdrCol.addColumnCustom("qualfStdrSeqno", "일련번호", null, false, false ); /* 일련번호 */ 
		    QualfStdrGrid = createAUIGrid(QualfStdrCol, QualfStdrGrid);
		    
		    ScoringCol.addColumnCustom("qualfStdrSeSeqno", "일련번호", null, false, true); /*배점 기준 일련번호 */
		    ScoringCol.addColumnCustom("qualfStdrSeqno", "일련번호", null, false, true); /*자격 기준 일련번호 */
		    ScoringCol.addColumnCustom("stdrSeCode", "코드", null, false, true); /*기준 코드 */
		    ScoringCol.addColumnCustom("stdrSeNm", "${msg.C100000359}", null, true, true,gridColPros); /*배점 기준 명 */
		    ScoringCol.addColumnCustom("sortOrdr", "${msg.C100000797}", null, true, true); /* 정렬순서 */
		    ScoringCol.inputEditRenderer(["sortOrdr"],{onlyNumeric : true})
		    ScoringGrid = createAUIGrid(ScoringCol, ScoringGrid,testPros);
	
		    BaseLineCol.addColumnCustom("qualfStdrSeSeqno", "일련번호", null, false, true); /*기준 결과 일련번호 */
		    BaseLineCol.addColumnCustom("qualfStdrSeqno", "일련번호", null, false, true); /*자격 기준 일련번호*/
		    BaseLineCol.addColumnCustom("stdrSeCode", "코드", null, false, true); /*기준 결과 코드*/
		    BaseLineCol.addColumnCustom("stdrSeNm", "${msg.C100000233}", null, true, true, gridColPros); /* 기준 결과 명 */
		    BaseLineCol.addColumnCustom("sortOrdr", "${msg.C100000797}", null, true, true); /* 정렬순서 */
		    BaseLineCol.inputEditRenderer(["sortOrdr"],{onlyNumeric : true})
		    BaseLineGrid = createAUIGrid(BaseLineCol, BaseLineGrid, testPros);
	    
	}; 
	
	//그리드 이벤트
	function setQualfStdrGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(QualfStdrGrid, "ready", function(event) {
	        gridColResize(QualfStdrGrid, "2");
	    });

	    AUIGrid.bind(QualfStdrGrid, "cellDoubleClick", function(event) {
			detailAutoSet({
				"item" : event["item"],
				"targetFormArr" : ["QualfStdrMForm"],
				"successFunc": function(){
					dropZoneArea.getFiles($("#atchmnflSeqno").val());
					if(event.item.useAt == 'Y'){ // 사용여부
						$("#useAtY").prop("checked", true);
					}else{
						$("#useAtN").prop("checked", true);
					}
					searchScoring();
					searchBaseLine();
				}
			})
	    });
	    
	    
	   	//그리드 드래그 순서 변경
	    AUIGrid.bind(ScoringGrid, "dropEnd", function(event) {
	    	var gridLen = AUIGrid.getGridData(ScoringGrid).length;
	    	for(var i=0; i<gridLen; i++){
	    		AUIGrid.setCellValue(ScoringGrid, i, "sortOrdr",i+1);	
	    	}
	    })
	    
	    //그리드 드래그 순서 변경
	    AUIGrid.bind(BaseLineGrid, "dropEnd", function(event) {
	    	var gridLen = AUIGrid.getGridData(BaseLineGrid).length;
	    	for(var i=0; i<gridLen; i++){
	    		AUIGrid.setCellValue(BaseLineGrid, i, "sortOrdr",i+1);	
	    	}
	    })
	    
	}
	
	function setButtonEvent() {
		
	    //조회
	    $('#btnSearch').click(function() {
	        searchQualfStdr();
	    })
	    
		// 신규 클릭 이벤트
		$('#btn_new').click(function(){
			// 폼 초기화
			reset();
		});
	    
	    //유효성 검사 및 저장
		$('#btnSave').click(function(){
 	 		if ($('#stdrNm').val() == null || $('#stdrNm').val() == ""){
 				warn("${msg.C100000242}");  /* 기준 명을 입력해 주십시오. */
 				return;
 			} 
 	 		
 	 		atchmnflSave();
 	 		
	    });
		
		//삭제
		$('#btndel').click(function(){
			if(confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */
				delQualfStdr();
			}
	    });
		

		$('#btnAdd1').click(function(){
			addRow (ScoringGrid, 'RS14000001')
		});
		
		$('#btnAdd2').click(function(){
			addRow (BaseLineGrid, 'RS14000002')
		});
		
		$('#btnRemove1').click(function(){
			AUIGrid.removeRow(ScoringGrid, "selectedIndex");
		});
		
		$('#btnRemove2').click(function(){
			AUIGrid.removeRow(BaseLineGrid, "selectedIndex");
		});
		
		
		function addRow (gridId, stdrSeCode){
			var gridLength = AUIGrid.getGridData(gridId).length;
			if ($('#stdrNm').val() == null || $('#stdrNm').val() == ""){
 				warn("${msg.C100000242}");  /* 기준 명을 입력해 주십시오. */
 				return;
 			} 
			var item = new Object();
			item.qualfStdrSeqno = $("#qualfStdrSeqno").val();
			item.stdrSeCode = stdrSeCode,
			item.sortOrdr = gridLength + 1,
			AUIGrid.addRow(gridId, item, "last");
		}
		
	    //엔터키 이벤트
		$(".schClass").keypress(function (e) {
		    if (e.which == 13){
		    	searchQualfStdr()
		    }
		});
	}
		
	// 조회 함수
	function searchQualfStdr() {
	    getGridDataForm("<c:url value='/rsc/getQualfStdr.lims'/>", "searchFrm", QualfStdrGrid);
	}
	function searchScoring(){
		getGridDataForm("<c:url value='/rsc/getScoreList.lims'/>", "QualfStdrMForm", ScoringGrid);
	}
	function searchBaseLine(){
		getGridDataForm("<c:url value='/rsc/getBaseLineList.lims'/>", "QualfStdrMForm", BaseLineGrid);
	}
	
	
	//첨부파일 저장
	function atchmnflSave(){
		var files = dropZoneArea.getNewFiles();
		var files_cnt = files.length;

		if (files_cnt > 0){
			$("#btnSave_atchmnflSeqno").click();
			dropZoneArea.on("uploadComplete", function(event, fileIdx){
				if(fileIdx == -1){
					err('${msg.C100000864}'); // 첨부파일 저장에 실패하였습니다.
				}else{
					$("#atchmnflSeqno").val(fileIdx);
					saveQualfStdr(); // 사용자 정보 저장함수 호출
				}
			});
		} else { // 첨부파일이 없을 시
			saveQualfStdr(); // 사용자 정보 저장함수 호출
		}
	}
	// 저장 함수
	function saveQualfStdr() {
		var saveUrl ='/rsc/saveQualfStdr.lims';
	    var param = getFormParam("QualfStdrMForm");
	    
	    var scoreGridData = AUIGrid.getGridData(ScoringGrid);
	    var baseLineGridData = AUIGrid.getGridData(BaseLineGrid);
	   var item;
	    
	    
	    
	    
		var scoreAddList = AUIGrid.getAddedRowItems(ScoringGrid);//행 추가 데이터
		var scoreEditList = AUIGrid.getEditedRowItems(ScoringGrid);//행 수정 데이터
		var scoreRemoveList = AUIGrid.getRemovedItems(ScoringGrid);//행 삭제 데이터
		var baseLineAddList = AUIGrid.getAddedRowItems(BaseLineGrid);//행 추가 데이터
		var baseLineEditList = AUIGrid.getEditedRowItems(BaseLineGrid);//행 수정 데이터
		var baseLineRemoveList = AUIGrid.getRemovedItems(BaseLineGrid);//행 삭제 데이터
		
		var addedRowList = scoreAddList.concat(baseLineAddList);
		var editedRowList = scoreEditList.concat(baseLineEditList);
		var removedRowList = scoreRemoveList.concat(baseLineRemoveList);
		
		param.addedRowList = addedRowList;
		param.editedRowList = editedRowList;
		param.removedRowList = removedRowList;
		
		if(scoreGridData.length>0){
			for(var i=0;i<scoreGridData.length; i++){
			item = scoreGridData[i];
				if(typeof item["stdrSeNm"] == "undefined" || String(item["stdrSeNm"]).trim() == "") {
					var invalidRowIndex = i;
					var colIndex = AUIGrid.getColumnIndexByDataField(ScoringGrid, "stdrSeNm");
					AUIGrid.setSelectionByIndex(ScoringGrid, invalidRowIndex, colIndex);
					warn("${msg.C100000360}");  /* 배점 기준 명은 필수값입니다. */
					return false;
					break;
				}
			}
		}
		if(baseLineGridData.length>0){
			for(var i=0;i<baseLineGridData.length; i++){
				item = baseLineGridData[i];
					if(typeof item["stdrSeNm"] == "undefined" || String(item["stdrSeNm"]).trim() == "") {
						var invalidRowIndex = i;
						var colIndex = AUIGrid.getColumnIndexByDataField(BaseLineGrid, "stdrSeNm");
						AUIGrid.setSelectionByIndex(BaseLineGrid, invalidRowIndex, colIndex);
						warn("${msg.C100000234}");  /* 기준 결과 명은 필수값입니다. */
						return false;
						break;
					}
				}
		}
	    
			customAjax({"url":saveUrl,"data":param,"successFunc":function(data) {
	        	if (data > 0) {
		        	searchQualfStdr();
		        	reset();
		            success("${msg.C100000762}"); /* 저장 되었습니다. */
	        	}
			}
		});    
	}
	// 삭제 함수
	function delQualfStdr() {
	    var delUrl = "<c:url value='/rsc/delQualfStdr.lims'/>";
	    var param = getFormParam('QualfStdrMForm');
	    customAjax({"url":delUrl,"data":param,"successFunc":function(data) {
		        if (data > 0) {
		        	searchQualfStdr();
		        	reset();
		            success("${msg.C100000462}"); /* 삭제되었습니다. */
		        }
			}
	    });
	}
	
	function reset(){
		$('#QualfStdrMForm')[0].reset();
		dropZoneArea.clear();
		AUIGrid.clearGridData(ScoringGrid)
		AUIGrid.clearGridData(BaseLineGrid)
	}
		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>