<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">기기관리</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>장비 검교정 목록</h2> <!-- 장비 검교정 목록 -->
				<div class="btnWrap">
					<button type="button" id="btnSelect" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="SearchFrm">
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
							<th>장비 분류</th> <!-- 장비 분류 -->
							<td><select id="schEqpmnClCode" name="schEqpmnClCode" class="wd100p"></select></td>

							<th>분석실</th> <!-- 분석실 -->
							<td><select id="schCustlabSeqno" name="schCustlabSeqno" ></select></td>

							<th>${msg.C100000742}</th> <!-- 장비명 -->
							<td><input type = "text" id="schEqpmnNm" name="schEqpmnNm" class="wd100p schClass"></td>

							<th>${msg.C100000127}</th> <!-- 검교정 일자 -->
							<td>
								<input type="text" id="schInspctCrrctBeginDte" name="schInspctCrrctBeginDte" class="wd6p schClass dateChk" style="min-width: 6em">
								~
								<input type="text" id="schInspctCrrctEndDte" name="schInspctCrrctEndDte" class="wd6p schClass dateChk" style="min-width: 6em">
							</td>
						</tr>
					</table>
				</form>
			</div>

			<div class="subCon2 mgT15">
				<div id="EqpmnInspctCrrctGrid" style="width:100%; height:300px; margin:0 auto"></div>
			</div>

			<div class="subCon1 mgT15" id="detail">
				<form id="EqpmnInspctForm">
					<h2><i class="fi-rr-apps"></i>${msg.C100000128}</h2> <!-- 검교정 정보 -->
					<div class="btnWrap">
						<button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
						<button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
						<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
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
							<th>장비 분류</th> <!-- 장비 분류 -->
							<td><input type="text" id="eqpmnClNm" name="eqpmnClNm" class="wd100p" readonly></td>

							<th >${msg.C100000739}</th> <!-- 장비 관리 번호 -->
							<td><input type="text" id="eqpmnManageNo" name="eqpmnManageNo" class="wd100p" readonly></td>

							<th class="necessary">${msg.C100000742}</th> <!-- 장비 명 -->
							<td>
								<input type="text" id="eqpmnNm" name="eqpmnNm" class="wd80p" readonly required>
								<button type="button" id="btnEqpmnPop" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
							</td>

							<th class="necessary">${msg.C100000129}</th> <!-- 검교정 주기 -->
							<td style="text-align:left;">
								<input type="text" id="inspctCrrctCycle" name="inspctCrrctCycle" class="wd56p" readonly required>
								<select id="cycleCode" name="cycleCode" class="wd40p" style="min-width:4em" required disabled></select>
							</td>
						</tr>

						<tr>
							<th class="necessary">${msg.C100000123}</th> <!-- 검교정 검사자 -->
							<td>
								<input type="text" id="inspctCrrctChargerNm" name="inspctCrrctChargerNm" class="wd62p" value="${UserMVo.userNm}" readonly required>
								<button type="button" id="btnUserPop"  class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
								<button type="button" id="btnUserReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button>
							</td>

							<th class="necessary">${msg.C100000127}</th> <!-- 검교정 일자 -->
							<td><input type="text" id="inspctCrrctDte" name="inspctCrrctDte" class="dateChk" required></td>

							<th>${msg.C100000124}</th> <!-- 검교정 계획 일자 -->
							<td><input type="text" id="inspctCrrctPlanDte" name="inspctCrrctPlanDte" class="dateChk" readonly></td>

							<th>${msg.C100000850}</th> <!-- 차기 검교정 일자 -->
							<td><input type="text" id="nextInspctCrrctDte" name="nextInspctCrrctDte" class="dateChk"></td>
						</tr>

						<tr>
							<th>검교정 결과</th> <!-- 검교정 결과 -->
							<td><select id="inspctCrrctResultCode" name="inspctCrrctResultCode" class="wd100p" style="min-width:10em;"></select></td>
						</tr>

						<tr>
							<th>비고</th> <!-- 비고 -->
							<td colspan="7">
								<textarea id="rm" name="rm" rows="2" class="wd100p" maxlength="4000"></textarea>
							</td>
						</tr>

						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부파일 -->
							<td colspan="7">
								<div id="dropZoneArea"></div>
								<input type="text" id="atchmnflSeqno" name="atchmnflSeqno" style="display: none">
								<input type="hidden" id="btnFileSave">
							</td>
						</tr>
					</table>

					<input type="text" id="eqpmnInspctCrrctSeqno" name="eqpmnInspctCrrctSeqno" style="display:none">
					<input type="text" id="eqpmnSeqno" name="eqpmnSeqno" style="display:none">
					<input type="text" id="inspctCrrctChargerId" name="inspctCrrctChargerId" value="${UserMVo.userId}" style="display:none">
					<input type="text" id="cycleUpdAt" name="cycleUpdAt" style="display:none">
					<input type="text" id="deleteAt" name="deleteAt" value="N" style="display:none">
				</form>
			</div>

			<div style="display: flex">
				<div class="subCon2 wd50p fL mgT25 mgR20">
					<div class="subCon1">
						<h3>의뢰 목록</h3> <!-- 의뢰 목록 -->
						<div class="btnWrap">
							<button id="btnInscptCrrctReqPop" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행 추가 -->
							<button id="btnDelInscptCrrctReq" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
						</div>
					</div>
					<div id="InspctCrrctReqGrid" class="mgT10" style="height:300px;"></div>
				</div>

				<div class="subCon2 wd50p mgT25">
					<div class="subCon1">
						<h3>시험항목 목록</h3> <!-- 시험항목 목록 -->
					</div>
					<div id="InspctCrrctReqExprGrid" class="mgT10" style="height:300px;"></div>
				</div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<script>

			var eqpmnInspctCrrctGrid = "EqpmnInspctCrrctGrid";
			var inspctCrrctReqGrid = "InspctCrrctReqGrid";
			var inspctCrrctReqExprGrid = "InspctCrrctReqExprGrid";

			var lang = ${msg};
			var dropZoneArea;
			var sessionObj = {
				bplcCode : "${UserMVo.bestInspctInsttCode}",
				deptCode : "${UserMVo.deptCode}"
			};

			var searchFrm = document.getElementById("SearchFrm").id;
			var inspctFrm = document.getElementById("EqpmnInspctForm").id;
			var getEl = function(id) {
				return document.getElementById(id);
			}
			var getVal = function(id) {
				return document.getElementById(id).value;
			}
			var setVal = function(id, val) {
				document.getElementById(id).value = val;
			}

			$(function() {
				init();
				setCombo();
				buildGrid();
				auiGridEvent();
				buttonEvent();
			});


			function init() {
				dialogEqpmn("btnEqpmnPop", "eqpmnDialog", function(item) {
					chkExistCrrctCycle(item); //검교정주기정보 등록 검증
				});

				dialogUser("btnUserPop", "", "inspctCrrctDialog", function(item){
					setVal('inspctCrrctChargerNm', item.userNm);
					setVal('inspctCrrctChargerId', item.userId);
				});

				dialogReqest("btnInscptCrrctReqPop", "inspctReqDialog", inspctCrrctReqGrid, sessionObj, function(items) {
					for (var item of items) {
						item.addedAt = 'Y';
					}
					AUIGrid.addRow(inspctCrrctReqGrid, items, "last");

					//추가한 의뢰의 시험항목 조회
					var seqArr = items.map(function(item) {
						return item.reqestSeqno;
					});
					loadInspctReqExpr(seqArr);
				});

				datePickerCalendar(["inspctCrrctDte"], false, ["DD",0], ["DD",0]);
				datePickerCalendar(["nextInspctCrrctDte"], false, ["DD",0], ["DD",0]);
				datePickerCalendar(["schInspctCrrctBeginDte", "schInspctCrrctEndDte"], true, ["MM",-1], ["DD",0]);

				dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnFileSave", maxFiles : 5, lang : lang.C100000867 });
			}


			function setCombo() {
				ajaxJsonComboBox("/com/getCmmnCode.lims", "schEqpmnClCode", { upperCmmnCode : "RS02" }, true);
				ajaxJsonComboBox("/com/getCustLabCombo.lims", "schCustlabSeqno", null, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "cycleCode", { upperCmmnCode : "SY14" }, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctCrrctResultCode", { upperCmmnCode : "RS12" }, true);
			}


			function buildGrid() {
				var col = {
					inspctCrrctCol: [],
					inspctCrrctReqCol: [],
					inspctCrrctReqExprCol: []
				};

				/********************** 검교정 목록 **********************/
				auigridCol(col.inspctCrrctCol);

				col.inspctCrrctCol
				.addColumnCustom("eqpmnClNm", "장비 분류", "*", true)
				.addColumnCustom("eqpmnInspctCrrctSeqno", "검교정 일련번호", "*", false)
				.addColumnCustom("eqpmnSeqno", "장비 일렬번호", "*", false)
				.addColumnCustom("eqpmnManageNo", "${msg.C100000739}", "*", true)
				.addColumnCustom("eqpmnNm", "${msg.C100000742}", "*", true)
				.addColumnCustom("serialNo", "Serial No", "*", true)
				.addColumnCustom("modlNm", "모델 명", "*", true)
				.addColumnCustom("inspctCrrctChargerId", "${msg.C100000123}", "*", false)
				.addColumnCustom("inspctCrrctChargerNm", "${msg.C100000123}", "*", true)
				.addColumnCustom("inspctCrrctResultCode", "검교정 결과", "*", false)
				.addColumnCustom("inspctCrrctResultNm", "검교정 결과", "*", true)
				.addColumnCustom("inspctCrrctDte", "${msg.C100000127}", "*", true)
				.addColumnCustom("inspctCrrctCycle", "검교정 주기", "*", false)
				.addColumnCustom("cycleCode", "주기 코드", "*", false)
				.addColumnCustom("rm", "비고", "*", true)
				.addColumnCustom("atchmnflSeqno", "첨부 파일", "*", false)
				.addColumnCustom("deleteAt", "삭제 여부", "*", false)
				.addColumnCustom("inspctCrrctPlanDte", "${msg.C100000124}", "*", false)
				.addColumnCustom("nextInspctCrrctDte", "${msg.C100000850}", "*", false);

				var eqpmnInspctProp = {
					editable: false,
					selectionMode: "multipleCells"
				};

				eqpmnInspctCrrctGrid = createAUIGrid(col.inspctCrrctCol, eqpmnInspctCrrctGrid, eqpmnInspctProp);



				/********************** 의뢰 목록 **********************/
				auigridCol(col.inspctCrrctReqCol);

				col.inspctCrrctReqCol
				.addColumnCustom("reqestSeqno", "의뢰 일련번호", "*", false)
				.addColumnCustom("eqpmnInspctCrrctReqestSeqn", "검교정 의뢰 일련번호", "*", false)
				.addColumnCustom("eqpmnInspctCrrctSeqno", "검교정 일련번호", "*", false)
				.addColumnCustom("reqestNo", "의뢰 번호", "*", true)
				.addColumnCustom("reqestDte", "의뢰 일자", "*", true)
				.addColumnCustom("deleteAt", "삭제 여부", "*", false);

				var eqpmnInspctReqProp = {
					editable: false,
					selectionMode: "multipleCells",
					showRowCheckColumn: true,
					showRowAllCheckBox: true
				};

				inspctCrrctReqGrid = createAUIGrid(col.inspctCrrctReqCol, inspctCrrctReqGrid, eqpmnInspctReqProp);



				/********************** 시험항목 목록 **********************/
				auigridCol(col.inspctCrrctReqExprCol);

				col.inspctCrrctReqExprCol
				.addColumnCustom("reqestSeqno", "의뢰 일렬번호", "*", false)
				.addColumnCustom("reqestNo", "의뢰 번호", "*", true)
				.addColumnCustom("expriemNm", "시험항목 명", "*", true)
				.addColumnCustom("resultRegister", "분석자", "*", true)
				.addColumnCustom("resultValue", "결과값", "*", true)
				.addColumnCustom("jdgmntWordNm", "판정", "*", true);

				inspctCrrctReqExprGrid = createAUIGrid(col.inspctCrrctReqExprCol, inspctCrrctReqExprGrid, eqpmnInspctProp);

				gridResize([eqpmnInspctCrrctGrid, inspctCrrctReqGrid, inspctCrrctReqExprGrid]);
			}


			function auiGridEvent() {
				AUIGrid.bind(eqpmnInspctCrrctGrid, "ready", function(event) {
					gridColResize([eqpmnInspctCrrctGrid], "2");
				});

				AUIGrid.bind(eqpmnInspctCrrctGrid, "cellDoubleClick", function(event) {
					getEl('btnDelete').style.display = '';
					detailAutoSet({
						item: event.item
						, targetFormArr: [inspctFrm]
						, successFunc: function() {
							getEl('btnEqpmnPop').style.display = 'none';
							dropZoneArea.getFiles(event.item.atchmnflSeqno);
							loadInspctReq(event.item.eqpmnInspctCrrctSeqno); //검교정의뢰 조회 -> 의뢰서함항목 조회
						}
					});
				});
			}


			function buttonEvent() {

				getEl('btnSelect').addEventListener("click", function() {
					searchEqpInspct();
				});

				getEl('btnReset').addEventListener("click", function() {
					reset();
				});

				getEl('btnSave').addEventListener("click", function() {
					saveValid();
				});

				getEl('btnDelete').addEventListener("click", function() {
					if (confirm(lang.C100000461)) { //삭제하시겠습니까?
						setVal('deleteAt', 'Y');
						saveEqpInspctCrrct();
					}
				});

				getEl('btnDelInscptCrrctReq').addEventListener("click", function() {
					var chkedItems = AUIGrid.getCheckedRowItemsAll(inspctCrrctReqGrid);
					if (chkedItems.length == 0)
						return;
					delInscptCrrctReq(chkedItems);
				});

				getEl('btnUserReset').addEventListener("click", function() {
					setVal('inspctCrrctChargerNm', '');
					setVal('inspctCrrctChargerId', '');
				});

				getEl('inspctCrrctDte').addEventListener("change", function() {
					nextCrrctDteEvent(
						getVal('inspctCrrctDte')
						, Number(getVal('inspctCrrctCycle'))
						, getVal('cycleCode')
						, "inspctCrrctPlanDte"
					);
					setVal('nextInspctCrrctDte', getVal('inspctCrrctPlanDte'));
				});
			}


			function delInscptCrrctReq(items) {
				var notAdded = items.filter(function(item) {
					return item.addedAt == undefined
				});
				if (notAdded.length > 0) {
					if (confirm(lang.C100000461)) {
						customAjax({
							url: "/rsc/delEqpInspctCrrctReq.lims",
							data: notAdded,
							successFunc: function(data) {
								if (data > 0) {
									removeRowReqAndExprm(items);
									success(lang.C100000462); //삭제되었습니다.
								} else {
									err(lang.C100000597);
								}
							}
						});
					}
				} else {
					removeRowReqAndExprm(items);
				}
			}


			function removeRowReqAndExprm(rows) {
				AUIGrid.removeCheckedRows(inspctCrrctReqGrid);

				//삭제된 검교정의뢰의 시험항목도 행 제거
				var seqArr = [];
				for (var row of rows) {
					seqArr.push(row.reqestSeqno);
				}
				var removedExpr = AUIGrid.getRowIndexesByValue(inspctCrrctReqExprGrid, "reqestSeqno", seqArr);
				AUIGrid.removeRow(inspctCrrctReqExprGrid, removedExpr);
			}


			function chkExistCrrctCycle(item) {
				var param = { eqpmnSeqno: item.eqpmnSeqno, inspctCrrctSeCode: "RS24000001"};
				customAjax({
					url: "/rsc/chkExistAtInspctCycle.lims",
					data: param,
					successFunc: function(data) {
						if (!data) {
							warn(lang.C100001241);  //해당 장비에 등록된 검교정 주기정보가 없습니다. 등록 후 다시 진행해주세요.
						} else {
							/* 검교정 신규등록 진행 중 의뢰를 추가한 후에 장비를 변경하는 경우에 대비
							 * 의뢰와 장비가 정상매칭 되지 않은 채로 저장되는 것을 방지.
							 */
							AUIGrid.clearGridData(inspctCrrctReqGrid);
							AUIGrid.clearGridData(inspctCrrctReqExprGrid);

							setVal('inspctCrrctCycle',data.inspctCrrctCycle);
							setVal('cycleCode', data.cycleCode);
							setVal('eqpmnSeqno', item.eqpmnSeqno);
							setVal('eqpmnClNm', item.eqpmnClNm);
							setVal('eqpmnManageNo', item.eqpmnManageNo);
							setVal('eqpmnNm', item.eqpmnNm);
							nextCrrctDteEvent(
								getVal('inspctCrrctDte')
								, Number(getVal('inspctCrrctCycle'))
								, getVal('cycleCode')
								, "inspctCrrctPlanDte"
							);
							setVal('nextInspctCrrctDte', getVal('inspctCrrctPlanDte'));
						}
					}
				});
			}


			function saveValid() {
				if (!saveValidation(inspctFrm))
					return;

				if (AUIGrid.getGridData(inspctCrrctReqGrid).length == 0) {
					warn("의뢰목록을 추가해주세요."); //의뢰목록을 추가해주세요.
					return;
				}

				customAjax({
					url: "/rsc/chkDuplicateInspctDte.lims",
					data: $("#EqpmnInspctForm").serializeObject(),
					successFunc: function(data) {
						if (data > 0) {
							warn(lang.C100000950) //해당 일자에 동일한 검교정 기록이 존재합니다.
						} else {
							fileSave();
						}
					}
				});
			}


			function fileSave() {
				var fileLength = dropZoneArea.getNewFiles().length;
				if (fileLength > 0) {
					getEl('btnFileSave').click();
					dropZoneArea.on("uploadComplete", function(event, fileIdx) {
						setVal('atchmnflSeqno', fileIdx);
						saveEqpInspctCrrct();
					});
				} else {
					saveEqpInspctCrrct();
				}
			}


			function saveEqpInspctCrrct() {
				//오늘날짜보와 등록하려는 검교정일자를 비교해 주기정보 업데이트 가능여부 구분값을 세팅
				var strToday = new Date().toISOString().substring(0,10);
				if (strToday <= getVal('inspctCrrctDte')) {
					setVal('cycleUpdAt', 'Y');
				} else {
					setVal('cycleUpdAt', 'N');
				}

				var param = getEl(inspctFrm).toObject(true);
				param.existReqList = AUIGrid.getGridData(inspctCrrctReqGrid);
				param.addedReqList = AUIGrid.getAddedRowItems(inspctCrrctReqGrid);

				customAjax({
					url: "/rsc/saveEqpmnInspctCrrct.lims",
					data: param,
					successFunc: function(data) {
						if (data > 0 && param.deleteAt == "N") {
							success(lang.C100000762); //저장되었습니다.
						} else if (data > 0 && param.deleteAt == "Y") {
							success(lang.C100000462); //삭제되었습니다.
						} else {
							err(lang.C100000597);
						}
						searchEqpInspct(data);
						reset();
					}
				});
			}


			function loadInspctReqExpr(paramArr) {
				customAjax({
					url: "/rsc/getEqpInspctCrrctReqExpr.lims",
					data: paramArr,
					successFunc: function(list) {
						AUIGrid.addRow(inspctCrrctReqExprGrid, list);
					}
				});
			}


			function loadInspctReq(seqNo) {
				getGridDataParam("/rsc/getEqpInspctCrrctReq.lims", { eqpmnInspctCrrctSeqno : seqNo }, inspctCrrctReqGrid)
				.then(function() {
					AUIGrid.clearGridData(inspctCrrctReqExprGrid);

					//의뢰시험항목 조회
					var reqList = AUIGrid.getGridData(inspctCrrctReqGrid);
					if (reqList.length > 0) {
						var seqArr = reqList.map(function(item) {
							return item.reqestSeqno
						});
						loadInspctReqExpr(seqArr);
					}
				});
			}


			function searchEqpInspct(returnSeq) {
				getGridDataForm("/rsc/getEqpmnInspctList.lims", searchFrm, eqpmnInspctCrrctGrid, function() {
					if (returnSeq)
						gridSelectRow(eqpmnInspctCrrctGrid, "eqpmnInspctCrrctSeqno", returnSeq);
				});
			}


			function reset() {
				pageReset([inspctFrm], [inspctCrrctReqGrid, inspctCrrctReqExprGrid], [dropZoneArea],
					function() {
						getEl('btnEqpmnPop').style.display = '';
						getEl('btnDelete').style.display = 'none';
					}
				);
			}


			function doSearch() {
				searchEqpInspct();
			}


		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
