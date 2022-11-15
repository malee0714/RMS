<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">장비 신뢰성평가</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!--  body 시작 -->
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000751}</h2> <!-- 장비 신뢰성평가 -->
				<div class="btnWrap">
					<button type="button" id="btn_select" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
							<th>${msg.C100000432}</th> <!-- 사업장 -->
							<td><select id="bplcCodeSch" name="bplcCodeSch" class="wd100p" style="min-width:10em;"></select></td>
							<th><c:out value="${msg.C100000742}"/></th> <!-- 장비명 -->
							<td><select id="eqpmnNmSch" name="eqpmnNmSch" style="width: 100%;"></select></td>
							<th><c:out value="${msg.C100000927}"/></th> <!-- 평가자 -->
							<td><input type="text" id="evlerNmSch" name="evlerNmSch"  class="wd100p" style="min-width:10em;"></td>
							<th><c:out value="${msg.C100000134}"/></th> <!-- 검사 교정 구분 -->
							<td><select id="inspctCrrctSeCodeSch" name="inspctCrrctSeCodeSch" style="margin-left:5px;"></select></td>
						</tr>
						<tr>
							<th class="necessary"><c:out value="${msg.C100000926}"/></th>  <!-- 평가일자 -->
							<td>
								<input type="text" id="evlBeginDteSch" name="evlBeginDteSch" class="wd6p dateChk" style="min-width: 6em;" required>
								~
								<input type="text" id="evlEndDteSch" name="evlEndDteSch" class="wd6p dateChk" style="min-width: 6em;" required>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div id="EqpmnRlabltyEvlRegstList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			<form id="EqpmnRlabltyEvlRegstListForm">
				<div class="subCon1 mgT15" id="detail">
					<h2><i class="fi-rr-apps"></i>${msg.C100000987}</h2> <!-- 신뢰성평가 정보 -->
					<div class="btnWrap">
						<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
						<button type="button" id="btn_delete" class="delete" onclick="deleteData()">${msg.C100000458}</button> <!-- 삭제 -->
						<button type="button" id="btn_Save" class="save">${msg.C100000760}</button> <!-- 저장 -->
					</div>
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="eqpmntbl">
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
							<th class="necessary">${msg.C100000432}</th> <!-- 사업장 -->
							<td><select id="bplcCode" name="bplcCode" class="wd100p" style="min-width:10em;"></select></td>

							<th class="necessary">${msg.C100000742}</th> <!-- 장비명 -->
							<td><select id="eqpmnSeqno" name="eqpmnSeqno" class="wd100p" style="min-width:10em;  width:100%" required ></select></td>
							<th>${msg.C100000739}</th> <!-- 장비관리번호 -->
							<td><input type="text" id="eqpmnManageNo" name="eqpmnManageNo"  class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '10')"></td>
							<th class="necessary">${msg.C100000134}</th> <!-- 검사 교정 구분 -->
							<td><select id="inspctCrrctSeCode" name="inspctCrrctSeCode" class="wd100p" style="min-width:10em;" required></select></td>
						</tr>
						<tr>
							<th class = "necessary">${msg.C100000927}</th> <!-- 평가자 -->
							<td>
								<input type="text" id="evlerNm" name="evlerNm"  class="wd62p" value="${UserMVo.userNm}" readonly required>
								<input type="hidden" id="evlerId" name="evlerId" value="${UserMVo.userId}" >
								<button type="button" id="evlerNmSearch" class="inTableBtn inputBtn btn5"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
								<button type="button" id="evlerNmReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
							</td>
							<th class="necessary" >${msg.C100000926}</th> <!-- 평가일자 -->
							<td style="text-align: left;">
								<input type="text" id="evlDte" name="evlDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')" autocomplete=off required>
							</td>
							<th class="necessary" >${msg.C100001263}</th> <!-- 평가계획일자-->
							<td style="text-align: left;">
								<input type="text" id="inspctCrrctPlanDte" name="inspctCrrctPlanDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')" autocomplete=off readonly>
							</td>
							<th class="necessary" >${msg.C100001264}</th> <!-- 차기평가일자 -->
							<td style="text-align: left;">
								<input type="text" id="nextInspctCrrctDte" name="nextInspctCrrctDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')" autocomplete=off required>
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000129}</th> <!-- 검교정 주기 -->
							<td style="text-align:left;">
								<input type="text" id="inspctCrrctCycle" name="inspctCrrctCycle" class="numChk wd56p" required readonly>
								<select id="cycleCode" name="cycleCode" style="min-width:4em; width:40%" required disabled></select>
							</td>
							<th id="thRepairCn">${msg.C100000425}</th> <!-- 비고 -->
							<td class="wd33p" colspan = "5">
								<textarea id="rm" name="rm" rows="1" class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '4000')"></textarea>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부파일 -->
							<td colspan="7">
								<!-- 파일첨부영역 -->
								<div id="dropZoneArea"></div>
								<input type = "hidden" id = "btn_fileSave">
								<input type="text" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;display:none;">
							</td>
						</tr>
					</table>

					<div id="layer_addr" style="display:none; ;position:fixed; top : -100px;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
						<img src="/daumeditor/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDialogAddress()" alt="닫기 버튼">
					</div>

					<input type="hidden" id="crud" name="crud" value="C"/>
					<input type="hidden" id="eqpmnRlabltyEvlRegistSeqno" name="eqpmnRlabltyEvlRegistSeqno">
					<input type="hidden" id="detectLimitApplcAt" name="detectLimitApplcAt">
					<input type="hidden" id="eqpmnClCode" name="eqpmnClCode">
					<input type="hidden" id="deleteAt" name="deleteAt" value="N">

				</div>
			</form>
			<div id="EqpmnRlabltyEvlRegstSubList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>

		<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script type="text/javascript">

		</script>
		<script>
			//AUIGrid 생성 후 반환 ID
			var EqpmnRlabltyEvlRegstList = 'EqpmnRlabltyEvlRegstList';
			var EqpmnRlabltyEvlRegstSubList = 'EqpmnRlabltyEvlRegstSubList';
			var lang = ${msg}; // 기본언어
			$(document).ready(function(){
				getAuth();

				//콤보 박스 초기화
				setCombo();

				//그리드 세팅
				setEqpmnRlabltyEvlRegstGrid();

				//그리드 세팅
				setEqpmnRlabltyEvlRegstSubGrid();

				//그리드 이벤트 선언
				setEqpmnRlabltyEvlRegstGridEvent();

				//버튼 이벤트
				setButtonEvent();

				gridResize([EqpmnRlabltyEvlRegstSubList,EqpmnRlabltyEvlRegstList])
				//초기세팅
				init();

			});

			function init(){

				$("#eqpmnManageNo").focus();
				//드랍존
				dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btn_fileSave", maxFiles : 5, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */
				datePickerCalendar(["evlDte"], false, ["DD",0], ["DD",0]);   //평가일자
				datePickerCalendar(["inspctCrrctPlanDte"], false, ["DD",0], ["DD",0]);   //평가일자
				datePickerCalendar(["nextInspctCrrctDte"], false, ["DD",0], ["DD",0]);   //평가일자
				datePickerCalendar(["evlBeginDteSch", "evlEndDteSch"], true, ["MM",-1], ["DD",0]);//평가일자
				dialogUser("evlerNmSearch", "", "inspctCrrctDialog", function(item){
					$('#evlerNm').val(item.userNm);
					$('#evlerId').val(item.userId);
				});
			}


			function setCombo(){
				ajaxJsonComboBox('/rsc/getCmmnInspctCode.lims','inspctCrrctSeCode',null, false,"${msg.C100000480}"); /* 선택 */
				ajaxJsonComboBox('/rsc/getCmmnInspctCode.lims','inspctCrrctSeCodeSch',null , false,"${msg.C100000480}"); /*선택*///{"analsAt" : "Y", "mmnySeCode" : "SY01000001"}
				ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{"bestInspctInsttAt" : "Y", isRdmsIp : true},false,null,'${UserMVo.bestInspctInsttCode}');
				ajaxJsonComboBox('/com/getCmmnCode.lims','cycleCode', {"upperCmmnCode" : "SY14"}, false,"${msg.C100000480}"); /* 선택 */
				ajaxSelect2Box({ajaxUrl:'/com/getEqpmnNmCombo.lims',elementId:'eqpmnNmSch',ajaxParam: {'bplcCode':'${UserMVo.bestInspctInsttCode}'} ,asyncType:false});
				ajaxSelect2Box({ajaxUrl:'/com/getEqpmnNmCombo.lims',elementId:'eqpmnSeqno',ajaxParam : {'bplcCode':'${UserMVo.bestInspctInsttCode}'} ,asyncType : false});
			}

			//그리드 함수
			function setEqpmnRlabltyEvlRegstGrid(){

				var col = [];

				var cusPros = {
					editable : false, // 편집 가능 여부 (기본값 : false)
					selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
					enableCellMerge : true
				}

				auigridCol(col);

				col.addColumnCustom("eqpmnClNm", "${msg.C100000745}", "*" ,true); /* 장비분류 */
				col.addColumnCustom("eqpmnClCode", "eqpmnClCode", "*" ,false); /* 장비분류코드 */
				col.addColumnCustom("eqpmnManageNo", "${msg.C100000739}", "*", true); /* 장비관리번호 */
				col.addColumnCustom("eqpmnNm", "${msg.C100000742}", "*", true); /* 장비명 */
				col.addColumnCustom("inspctCrrctSeNm", "${msg.C100000134}", "*", true); /* 검사교정구분 */
				col.addColumnCustom("inspctCrrctSeCode", "inspctCrrctSeCode", "*", false); /* 검사교정구분 코드*/
				col.addColumnCustom("evlerNm", "${msg.C100000927}", "*", true); /* 평가자 */
				col.addColumnCustom("evlerId", "evlerId", "*", false); /* 평가자ID */
				col.addColumnCustom("evlDte", "${msg.C100000926}", "*", true); /* 평가일자 */
				col.addColumnCustom("eqpmnSeqno", "eqpmnSeqno", "*", false); /* 장비일련번호 */
				col.addColumnCustom("eqpmnRlabltyEvlRegistSeqno", "eqpmnRlabltyEvlRegistSeqno", "*", false); /* 장비 신뢰성 평가 등록 일련번호 */
				col.addColumnCustom("rm", "rm", "*", false); /* 비교 */
				col.addColumnCustom("atchmnflSeqno", "atchmnflSeqno", "*", false); /* 첨부파일번호 */
				col.addColumnCustom("bplcCode", "bplcCode", "*", false); /* 사업장코드 */
				col.addColumnCustom("detectLimitApplcAt", "detectLimitApplcAt", "*", false); /* 검출 한계 적용 여부 */

				//auiGrid 생성
				EqpmnRlabltyEvlRegstList = createAUIGrid(col, "EqpmnRlabltyEvlRegstList", cusPros);
				// 그리드 리사이즈.
				// 그리드 칼럼 리사이즈
				AUIGrid.bind(EqpmnRlabltyEvlRegstList, "ready", function(event) {
					gridColResize([EqpmnRlabltyEvlRegstList],"2");   // 1, 2가 있으니 화면에 맞게 적용
				});

			}

			//그리드 이벤트 함수
			function setEqpmnRlabltyEvlRegstGridEvent(){
				AUIGrid.bind(EqpmnRlabltyEvlRegstList, "cellDoubleClick", function(event) {
					$("#crud").val("U");

					detailAutoSet({
						item : event.item,
						targetFormArr : ["EqpmnRlabltyEvlRegstListForm"],
						ignoreFormArr : ["searchFrm"],
						successFunc : function(){
							$("#deleteAt").val("N");
							$("#eqpmnManageNo").val(event.item.eqpmnManageNo);//장비관리번호
							$("#eqpmnRlabltyEvlRegistSeqno").val(event.item.eqpmnRlabltyEvlRegistSeqno);//장비 신뢰성 평가 등록 일련번호
							$("#eqpmnNm").val(event.item.eqpmnNm);//장비명
							$("#eqpmnSeqno").val(event.item.eqpmnSeqno);//장비일련번호
							$("#evlerNm").val(event.item.evlerNm);//평가자
							$("#evlerId").val(event.item.evlerId);//평가자ID
							$("#evlDte").val(event.item.evlDte);//평가일자
							$("#rm").val(event.item.rm);//비고
							$("#detectLimitApplcAt").val(event.item.detectLimitApplcAt);//비교
							$("#eqpmnClCode").val(event.item.eqpmnClCode);//장비분류코드
							$("#nextInspctCrrctDte").val(event.item.nextInspctCrrctDte);
							$("#inspctCrrctPlanDte").val(event.item.inspctCrrctPlanDte);

							disabledCtrl(true);
							dropZoneArea.getFiles(event.item.atchmnflSeqno);
							//신뢰성평가항목 조회
							searchEqpmnRlabltyEvlRegstSub();
						}
					});
				});
			}

			//입력폼 disabled 처리 함수 (셀 더블 클릭 시)
			function disabledCtrl(boolVal) {
				$("#bplcCode").prop("disabled", boolVal);
				$("#eqpmnSeqno").prop("disabled", boolVal);
				$("#eqpmnManageNo").prop("readonly", boolVal);
			}

			//그리드 함수
			function setEqpmnRlabltyEvlRegstSubGrid(){

				var col = [];
				var cusPros = {
					editable : true, // 편집 가능 여부 (기본값 : false)
					selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
					enableCellMerge : true
				}
				var numericPros = {
					type : "InputEditRenderer",
					onlyNumeric : true, // 0~9 까지만 허용
					allowPoint : true, // 소수점 허용 여부 (onlyNumeric : true 선행)
					allowNegative : true // 음수값 허용 여부 (onlyNumeric : true 선행)
				};

				// 특정 조건에 따라 미리 정의한 editRenderer 반환.
				var conditionPros = {
					editable : true,
					selectionMode : "multipleCells",
					enableCellMerge : true,
					editRenderer : {
						type : "ConditionRenderer",
						conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {
							// LSL/USL 셀에만 numericPros 적용
							if(dataField == 'resultValue') {
								return numericPros;
							}else {
								return cusPros;
							}
						}
					}
				};

				auigridCol(col);

				col.addColumnCustom("expriemNm", "${msg.C100000560}", "*" ,true); /* 시험항목명 */
				col.addColumnCustom("eqpmnClCode", "시험항목코드", "*" ,false); /* 시험항목명 */
				col.addColumnCustom("resultValue", "${msg.C100000150}", "*", true,true,conditionPros); /* 결과값 */
				col.addColumnCustom("sortOrdr", "sortOrdr", "*", false); /* 순서*/
				col.addColumnCustom("eqpmnRlabltyEvlRegistSeqno", "eqpmnRlabltyEvlRegistSeqno", "*", false); /* 장비 신뢰성 평가 등록 일련번호*/
				col.addColumnCustom("detectLimitSeqno", "detectLimitSeqno", "*", false); /* 검출한계 일련번호*/
				col.addColumnCustom("bplcCode", "bplcCode", "*", false); /* 사업장코드 */
				col.addColumnCustom("expriemSeqno", "expriemSeqno", "*", false); /* 시험항목일련번호 */
				col.addColumnCustom("eqpmnSeqno", "eqpmnSeqno", "*", false); /* 장비 일련번호 */


				//auiGrid 생성
				EqpmnRlabltyEvlRegstSubList = createAUIGrid(col, "EqpmnRlabltyEvlRegstSubList", cusPros);
				// 그리드 리사이즈.
				// 그리드 칼럼 리사이즈

				AUIGrid.bind(EqpmnRlabltyEvlRegstSubList, "ready", function(event) {
					gridColResize([EqpmnRlabltyEvlRegstSubList],"2");   // 1, 2가 있으니 화면에 맞게 적용
				});
			}

			//버튼 이벤트
			function setButtonEvent(){

				//엔터로 검색
				$("#eqpmnNmSch,#evlerNmSch,#inspctCrrctSeCodeSch,#evlBeginDteSch,#evlEndDteSch").keyup(function(e){
					searchEqpmnRlabltyEvlRegst(e.keyCode);
				});

				// 신규 클릭 이벤트
				$('#btn_new').click(function(){
					eqpmnRlabltyEvlRegstReset();

				});

				//조회 버튼 이벤트
				$("#btn_select").click(function(){
					searchEqpmnRlabltyEvlRegst();
				});

				//저장 버튼 이벤트
				$("#btn_Save").click(function(){
					validation();
				});

				// 평가자 input reset 버튼
				$("#evlerNmReset").click(function(){
					dialogReset(this.id);
				})

				//사업장 변경 이벤트
				$("#bplcCode").change(function() {
					ajaxSelect2Box({ajaxUrl:'/com/getEqpmnNmCombo.lims',elementId:'eqpmnSeqno',ajaxParam : {'bplcCode':$("#bplcCode").val()} ,asyncType : false});
				});

				//장비 변경 이벹트
				$("#eqpmnSeqno").change(function() {
					var crud = $("#crud").val();
					if(crud == 'C') {
						var eqpmnSeqno = $("#eqpmnSeqno").val();
						if(!!eqpmnSeqno){
							// 장비관리번호 세팅 후, 시험항목 가져옴
							customAjax({
								"url":"/rsc/getSelectEqpmnManageNo.lims",
								"data":{eqpmnSeqno : $("#eqpmnSeqno").val(), bplcCode : $("#bplcCode").val()},
								"successFunc":function(data){
									$('#eqpmnManageNo').val(data.eqpmnManageNo);
									$("#eqpmnClCode").val(data.eqpmnClCode);
									disabledCtrl(true);
								}
							}).then(function() {
								customAjax({
									"url": "/rsc/getRsEqpmnRlabltyEvlExpriem.lims",
									"data": {eqpmnSeqno : $("#eqpmnSeqno").val()},
									"successFunc": function(data) {
										if(data.length > 0) {
											AUIGrid.setGridData(EqpmnRlabltyEvlRegstSubList, data);
										}
									}
								});
							});
						}else{
							eqpmnRlabltyEvlRegstReset();
						}
					}
				});



				//장비명 변경 이벤트
				$("#inspctCrrctSeCode").change(function() {
					var crud = $("#crud").val();
					$("#evlDte").val("");
					$("#inspctCrrctPlanDte").val("");
					$("#nextInspctCrrctDte").val("");
					if(crud == 'C') {
						var eqpmnSeqno = $("#eqpmnSeqno").val();
						customAjax({
							"url": "/rsc/getEqpmnNmInspctList.lims",
							"data": {eqpmnSeqno : $("#eqpmnSeqno").val(),inspctCrrctSeCode:$("#inspctCrrctSeCode").val()},

							"successFunc": function(data) {
								if(data.length > 0) {
									$("#eqpmnManageNo").val(data[0].eqpmnManageNo);
									$("#inspctCrrctCycle").val(data[0].inspctCrrctCycle);
									$("#cycleCode").val(data[0].cycleCode).prop("selected", true);
								}else {
									warn("${msg.C100001241}");  /* 해당 장비에 등록된 검교정 주기정보가 없습니다. 등록 후 다시 진행해주세요. */
									eqpmnRlabltyEvlRegstReset();
								}
							}
						});
					}
				});





				//검교정 일 변경 이벤트
				$("#evlDte").change(function(){
					var inspctCrrctSeCode = $("#inspctCrrctSeCode").val();
					var crrDte = $("#evlDte").val();


					var crrCycle = Number($("#inspctCrrctCycle").val());
					var crrCycleCode = $("#cycleCode").val();
					var colId = "inspctCrrctPlanDte";


					if(!!inspctCrrctSeCode && !!crrDte){
						nextCrrctDteEvent(crrDte,crrCycle,crrCycleCode,colId);
						$("#nextInspctCrrctDte").val($("#inspctCrrctPlanDte").val())
					}
				});


				//바코드 번호 ENTER
				$("#eqpmnManageNo").keyup(function(e){
					if(e.keyCode == 13){
						eqpmnManageNoEvent();
					}
				});


			}

			// 장비관리번호 event 함수
			function eqpmnManageNoEvent(){

				if(!$("#eqpmnManageNo").val()){
					alert("${msg.C100000970}"); /* 장비관리번호를 입력해 주세요. */
					return;
				}

				customAjax({
					"url": "/rsc/getSelectEqpmnManageNo.lims",
					"data": {eqpmnManageNo : $("#eqpmnManageNo").val(), bplcCode : $("#bplcCode").val()},
					"successFunc": function(data) {
						if(!!data) {
							$('#eqpmnSeqno').val(data.eqpmnSeqno);
							$("#eqpmnSeqno").change();

						}else {
							warn("${msg.C100000596}");  /* 없는 관리번호입니다. */
							$("#eqpmnManageNo").val("");
							$("#eqpmnManageNo").focus();
						}
					}
				});
			}


			/* 저장 유효성 검사 */
			function validation(){
				if(!saveValidation("EqpmnRlabltyEvlRegstListForm")){
					return false;
				}

				var exprGridData = AUIGrid.getGridData(EqpmnRlabltyEvlRegstSubList);
				if(exprGridData.length == 0) {
					warn("${msg.C100001240}");  /* 해당 장비에 등록된 신뢰성평가 시험항목이 없습니다. 등록 후 다시 진행해주세요. */
					return false;
				}

				customAjax({
					"url": "/rsc/getChkRegistDate.lims",
					"data": {
						eqpmnSeqno : $("#eqpmnSeqno").val(),
						inspctCrrctSeCode : $("#inspctCrrctSeCode").val(),
						evlDte : $("#evlDte").val(),
						eqpmnRlabltyEvlRegistSeqno : $("#eqpmnRlabltyEvlRegistSeqno").val()
					},
					"successFunc":function(data) {
						if(data == 0) {
							fileSave();
						}else {
							warn("${msg.C100000950}");  /* 해당 일자에 동일한 점검 기록이 존재합니다. */
						}
					}
				});
			}

			/* 첨부파일 저장*/
			function fileSave() {
				var dropZone = dropZoneArea.getNewFiles();
				var dropZone_cnt = dropZone.length;
				if(dropZone_cnt > 0) {
					$("#btn_fileSave").click();
					dropZoneArea.on("uploadComplete", function(event, fileIdx){
						$("#atchmnflSeqno").val(fileIdx);
						saveEqpmnRlabltyEvlRegst();
					});
				}else {
					saveEqpmnRlabltyEvlRegst();
				}
			}


			//저장 함수
			function saveEqpmnRlabltyEvlRegst() {
				disabledCtrl(false);
				var param = $("#EqpmnRlabltyEvlRegstListForm").serializeObject();
				var gridData = {
					"list" : AUIGrid.getGridData(EqpmnRlabltyEvlRegstSubList)
					,"bestInspctInsttCode":$('#bestInspctInsttCode').val()
				};

				param = Object.assign(param, gridData);
				showLoadingbar();
				customAjax({"url":"/rsc/saveEqpmnRlabltyEvlRegstDate.lims",
					"data":param ,
					"successFunc":function(data){
						if(data == 0) {
							var inspctCrrctSeCode = $("#inspctCrrctSeCode").val();
							if(inspctCrrctSeCode == 'RS24000003') {
								warn("${msg.C100001243}");  /* 해당 장비에 등록된 DL 주기정보가 없습니다. 등록 후 다시 진행해주세요. */
							}else if(inspctCrrctSeCode == 'RS24000004') {
								warn("${msg.C100001244}");  /* 해당 장비에 등록된 회수율 주기정보가 없습니다. 등록 후 다시 진행해주세요. */
							}else {
								warn("${msg.C100001245}");  /* 해당 장비에 등록된 재현성 주기정보가 없습니다. 등록 후 다시 진행해주세요. */
							}
							eqpmnRlabltyEvlRegstReset();
						}else {
							success("${msg.C100000762}");  /* 저장되었습니다. */
							eqpmnRlabltyEvlRegstReset();
							searchEqpmnRlabltyEvlRegst();
						}
					},"completeFunc":function(){
						hideLoadingbar();
					},"errorFunc":function(){
						hideLoadingbar();
					}
				});
			}

			//조회 함수
			function searchEqpmnRlabltyEvlRegst(keyCode) {
				if(!saveValidation('searchFrm')) {
					return false;
				}
				if(keyCode != undefined && keyCode == 13)
					searchEqpmnRlabltyEvlRegst();
				else {
					if(keyCode == undefined) {
						getGridDataForm("<c:url value='/rsc/searchEqpmnRlabltyEvlRegst.lims'/>", "searchFrm", EqpmnRlabltyEvlRegstList);
					}
				}
			}

			//신회성 시험 항목 조회 함수
			function searchEqpmnRlabltyEvlRegstSub() {
				var param = {
					"eqpmnSeqno" : $("#eqpmnSeqno").val(),
					"eqpmnRlabltyEvlRegistSeqno" : $("#eqpmnRlabltyEvlRegistSeqno").val()
				};
				customAjax({"url":"/rsc/searchEqpmnRlabltyEvlRegstSub.lims",
					"data":param,
					"successFunc":function(data){
						AUIGrid.setGridData(EqpmnRlabltyEvlRegstSubList, data);
					}
				});
			}

			//삭제 함수
			function deleteData(){
				if(confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */
					var params = {
						eqpmnRlabltyEvlRegistSeqno : $("#eqpmnRlabltyEvlRegistSeqno").val()
						,deleteAt : "Y"
					}
					customAjax({"url":"<c:url value='/rsc/updateEqpmnRlabltyEvlRegstDel.lims'/>",
						"data":params,
						"successFunc":function(data){
							success("${msg.C100000462}"); /* 삭제되었습니다. */
							eqpmnRlabltyEvlRegstReset();
							searchEqpmnRlabltyEvlRegst();
						}
					});
				}
				else{
					return;
				}
			}


			//리셋
			function eqpmnRlabltyEvlRegstReset(){
				$("#EqpmnRlabltyEvlRegstListForm")[0].reset();
				var hidden = $("#EqpmnRlabltyEvlRegstListForm input[type=hidden]");

				for(var i=0; i<hidden.length; i++){
					hidden[0].value = "";
				}

				disabledCtrl(false);
				$("#eqpmnManageNo").prop("readonly",false);
				$("#eqpmnBrcdNm").val("");
				$("#crud").val("C");
				$("#eqpmnManageNo").val("");
				$("#deleteAt").val("N");
				$("#eqpmnSeqno").val("");
				$("#evlerNm").val("${UserMVo.userNm}");
				$("#evlerId").val("${UserMVo.userId}");
				$("#evlDte").val("");
				$("#rm").val("");
				$("#eqpmnRlabltyEvlRegistSeqno").val("");
				$("#detectLimitApplcAt").val("");
				$("#eqpmnClCode").val("");
				$("#bplcCode").val('${UserMVo.bestInspctInsttCode}');
				ajaxSelect2Box({ajaxUrl:'/com/getEqpmnNmCombo.lims',elementId:'eqpmnSeqno',ajaxParam : {'bplcCode':'${UserMVo.bestInspctInsttCode}'} ,asyncType : false});
				dropZoneArea.clear();
				AUIGrid.clearGridData(EqpmnRlabltyEvlRegstSubList);
			}


		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
