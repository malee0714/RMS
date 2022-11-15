<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">장비 관리</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000743}</h2> <!-- 장비 목록 -->
				<div class="btnWrap">
					<button type="button" class="print" onClick="printBrcd()">시험장비이력서</button> <!-- 시험장비이력서 -->
					<button type="button" id="btnSelect" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>

				<form id="SearchForm" onsubmit="return false;">
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
							<th>${msg.C100000745}</th> <!-- 장비 분류 -->
							<td><select id=schEqpmnClCode name="schEqpmnClCode" class="wd100p" style="min-width:10em;"></select></td>

							<th>분석실</th> <!-- 분석실 -->
							<td><select id="schCustLab" name="schCustLab" class="wd100p" style="width: 100%;"></select></td>

							<th>${msg.C100000742}</th> <!-- 장비 명 -->
							<td><input type="text" id="schEqpmnNm" name="schEqpmnNm" class="wd100p schClass" maxlength="200" style="width: 100%;"></td>

							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td>
								<label><input type="radio" id="useAt_A" name="schUseAt" value="">${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" id="useAt_Y" name="schUseAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="useAt_N" name="schUseAt" value="N" >${msg.C100000442}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="EqpmnGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>

			<form id="EqpmnForm" onsubmit="return false;">
				<div class="subCon1 mgT20" id="detail">
					<h2><i class="fi-rr-apps"></i>${msg.C100000747}</h2> <!-- 장비 상세 정보 -->
					<div class="btnWrap">
						<button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
						<button type="button" id="btnDelete" class="delete" style="display: none">삭제</button> <!-- 삭제 -->
						<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
					</div>
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
						<colgroup>
							<col style="width:10%"></col>
							<col style="width:13%"></col>
							<col style="width:10%"></col>
							<col style="width:14%"></col>
							<col style="width:10%"></col>
							<col style="width:14%"></col>
							<col style="width:10%"></col>
							<col style="width:14%"></col>
						</colgroup>
						<tr>
							<th class="necessary" style="min-width:120px;">${msg.C100000745}</th> <!-- 장비 분류 -->
							<td><select id="eqpmnClCode" name="eqpmnClCode" class="wd100p" style="min-width:10em;" required></select></td>

							<th class="necessary">${msg.C100000739}</th> <!-- 장비 관리 번호 -->
							<td><input type="text" id="eqpmnManageNo" name="eqpmnManageNo"  class="wd100p" style="min-width:10em;" maxlength="10" readonly></td>

							<th class="necessary">${msg.C100000742}</th> <!-- 장비 명 -->
							<td>
								<input type="text" id="eqpmnNm" name="eqpmnNm" class="wd100p" style="min-width:10em;" maxlength="200" required>
							</td>

							<th>${msg.C100000443}</th> <!-- 사용 여부 -->
							<td style="text-align: left;">
								<label><input type="radio" id="useAt_Y" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="useAt_N" name="useAt" value="N" >${msg.C100000442}</label> <!-- 사용 안함 -->
							</td>
						</tr>

						<tr>
							<th class="necessary">${msg.C100000089}</th> <!-- Serial No -->
							<td><input type="text" id="serialNo" name="serialNo" class="wd100p" style="min-width:10em;" maxlength="100" required></td>

							<th class="necessary">모델 명</th> <!-- 모델 명 -->
							<td><input type="text" id="modlNm" name="modlNm" class="wd100p" style="min-width:10em;" maxlength="200" required></td>

							<th class="necessary">제조원</th> <!-- 제조원 -->
							<td><input type="text" id="mnfcturCmpnyNm" name="mnfcturCmpnyNm"  class="wd100p" style="min-width:10em;" maxlength="200" required></td>

							<th class="necessary">납품처</th> <!-- 납품처 -->
							<td><input type="text" id="dvyfgofficNm" name="dvyfgofficNm" class="wd100p" style="min-width:10em;" maxlength="200" required></td>
						</tr>

						<tr>
							<th class="necessary">구입 일자</th> <!-- 구입 일자 -->
							<td ><input type="text" id="purchsDte" name="purchsDte" class="dateChk" required></td>

							<th>용도</th> <!-- 용도 -->
							<td ><input type="text" id="prpos" name="prpos" class="wd100p" style="min-width:10em;" maxlength="200"></td>

							<th class="necessary">분석실</th> <!-- 분석실 -->
							<td ><select id="custlabSeqno" name="custlabSeqno" class="wd100p" style="min-width:10em;" required></select></td>

							<th>Back up</th> <!-- Back up -->
							<td><select id="replcEqpmnNm" name="replcEqpmnNm" style="width: 100%;"></select></td>
						</tr>

						<tr>
							<th>${msg.C100000411}</th> <!-- 분석 소요 시간 -->
							<td><input type="text" id="analsReqreTime" name="analsReqreTime" class="wd85p numChk comma" style="min-width:8.5em;"><span style="margin-left: 3px;">분</span></td>

							<th>담당 부서</th> <!-- 담당 부서 -->
							<td><select id="chrgDeptCode" name="chrgDeptCode" class="wd100p" style="min-width:10em;"></select></td>

							<th>${msg.C100000202}</th> <!-- 관리책임자(정) -->
							<td><select id="manageRspnberJId" name="manageRspnberJId" class="wd100p" style="min-width:10em;"></select></td>

							<th>${msg.C100000201}</th> <!-- 관리책임자(부) -->
							<td><select id="manageRspnberBId" name="manageRspnberBId" class="wd100p" style="min-width:10em;"></select></td>
						</tr>

						<tr>
							<th>${msg.C100000901}</th> <!-- 취득 상태 -->
							<td><select id="acqsSttusCode" name="acqsSttusCode" class="wd100p" style="min-width:10em;"></select></td>

							<th>${msg.C100000900}</th> <!-- 취득 금액 -->
							<td><input type="text" id="acqsAmount" name="acqsAmount" class="wd100p numChk comma" style="min-width:10em;" maxlength="15"></td>

							<th>내용 년수</th> <!-- 내용 년수 -->
							<td ><input type="text" id="cnYycnt" name="cnYycnt" class="wd100p numChk" style="min-width:10em;" maxlength="2"></td>

							<th>${msg.C100000692}</th> <!-- 입고일자 -->
							<td ><input type="text" id="wrhousngDte" name="wrhousngDte" class="dateChk"></td>
						</tr>

						<tr>
							<th>${msg.C100000748}</th> <!-- 장비 상태 -->
							<td><select id="mhrlsSttusCode" name="mhrlsSttusCode" class="wd100p" style="min-width:10em;"></select></td>

							<th id="thDsuseDte">${msg.C100000933}</th> <!-- 폐기 일자 -->
							<td ><input type="text" id="dsuseDte" name="dsuseDte" class="dateChk" required></td>

							<th id="thDsuseResn">${msg.C100000931}</th> <!-- 폐기 사유 -->
							<td class="wd33p" colspan="5"><textarea id="dsuseResn" name="dsuseResn" rows="2" class="wd100p" style="min-width:10em;" maxlength="4000" required></textarea></td>
						</tr>

						<tr>
							<th>${msg.C100000106}</th> <!-- 가동 여부 -->
							<td style="text-align: left;">
								<label><input type="radio" id="oprAt_Y" name="oprAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="oprAt_N" name="oprAt" value="N" >${msg.C100000442}</label> <!-- 사용 안함 -->
							</td>
						</tr>

						<tr>
							<th>${msg.C100000746}</th> <!-- 장비 사진 -->
							<td colspan="8">
								<div id="dropZoneArea"></div>
								<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;">
								<input type="hidden" id="btnFileSave">
							</td>
						</tr>
					</table>

					<input type="text" id="crud" name="crud" value="C" style="display: none"/>
					<input type="text" id="eqpmnSeqno" name="eqpmnSeqno" style="display: none"/>
					<input type="text" id="deleteAt" name="deleteAt" value="N" style="display: none">
				</div>
			</form>

			<div style="display: flex;" class="mgT25">
				<div class="subCon2 wd100p fL mgR20">
					<div class="subCon1">
						<h3>관련 제품</h3>  <!-- 관련 제품 -->
						<div class="btnWrap">
							<button id="btnAddMtril" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 자재 팝업 -->
							<button id="btnDelMtril" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
							<button id="btnChangeOrdrP" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
						</div>
					</div>
					<div id="RelateMtrilGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto; z-index: 0;"></div>
				</div>

				<div class="subCon2 wd100p fL">
					<div class="subCon1">
						<h3>관련 시험항목</h3>  <!-- 관련 시험항목 -->
						<div class="btnWrap">
							<button id="btnAddExpr" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행 추가 -->
							<button id="btnDelExpr" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
							<button id="btnChangeOrdrE" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
						</div>
					</div>
					<div id="RelateExprGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto; z-index: 0;"></div>
				</div>
			</div>

			<div style="display: flex;" class="mgT25">
				<div class="subCon2 wd100p fL mgR20">
					<div class="subCon1">
						<h3>${msg.C100000130}</h3> <!-- 검교정 주기 정보 -->
						<div class="btnWrap">
							<button id="btnAddInspctCrrct" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행 추가 -->
							<button id="btnDelInspctCrrct" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
						</div>
					</div>
					<div id="EqpmnInspctCrrctGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
				</div>

				<div class="subCon2 wd100p">
					<div class="subCon1">
						<h3>${msg.C100000685}</h3>  <!-- 일상점검 시험항목 -->
						<div class="btnWrap">
							<button id="btnAddChckExpr" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행 추가 -->
							<button id="btnDelChckExpr" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
							<button id="btnChangeOrdrC" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
						</div>
					</div>
					<div id="EqpmnEdayChckGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
				</div>
			</div>

			<div class="subCon1 wd100p mgT25">
				<form id="LasForm" onsubmit="return false;">
					<div class="accordion_wrap">
						<div class="subCon1 wd100p mgT20" id="detail2">
							<div class="accordion">${msg.C100000050} <!-- LAS 정보 --></div>
							<div id=acc3 class="acco_top" style="display: none">
								<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlastbl">
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
										<th class="taCt vaMd necessary" style="min-width:150px;">${msg.C100000049}</th> <!-- LAS 여부 -->
										<td style="text-align: left;">
											<label><input type="radio" id="lasUseAt_Y" name="lasUseAt" value="Y" >${msg.C100000439}</label> <!-- 사용 -->
											<label><input type="radio" id="lasUseAt_N" name="lasUseAt" value="N" checked>${msg.C100000442}</label> <!-- 사용 안함 -->
										</td>

										<th id="thMhrlsPcIp">${msg.C100000737}</th> <!-- 장비 PC IP -->
										<td><input type="text" id="mhrlsPcIp" name="mhrlsPcIp"  class="wd100p" style="min-width:10em;" maxlength="32" disabled></td>

										<th id="thComPortNo">${msg.C100000034}</th> <!-- COM Port -->
										<td><input type="text" id="comPortNo" name="comPortNo" class="wd100p" style="min-width:10em;" maxlength="100" disabled></td>

										<th id="thCommnVeValue">${msg.C100000911}</th> <!-- 통신 속도 -->
										<td><input type="text" id="commnVeValue" name="commnVeValue"  class="wd100p" style="min-width:10em;" maxlength="100" disabled></td>
									</tr>

									<tr>
										<th id="thDataBitValue" style="min-width:150px;">${msg.C100000286}</th> <!-- 데이터 비트 -->
										<td><input type="text" id="dataBitValue" name="dataBitValue"  class="wd100p" style="min-width:10em;" maxlength="100" disabled></td>

										<th id="thParityValue">${msg.C100000071}</th> <!-- Parity -->
										<td style="text-align: left;"><input type="text" id="parityValue" name="parityValue"  class="wd100p" style="min-width:10em;" maxlength="100" disabled></td>

										<th id="thDtrWireValue" style="min-width:150px;">${msg.C100000040}</th> <!-- DTR 회선 -->
										<td><input type="text" id="dtrWireValue" name="dtrWireValue"  class="wd100p" style="min-width:10em;" maxlength="100" disabled></td>

										<th id="thLasResultSeCode" style="min-width:150px;">${msg.C100000048}</th> <!-- LAS 결과 -->
										<td><select id="lasResultSeCode" name="lasResultSeCode" class="wd100p" style="min-width:10em;"></select></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<script>

			var eqpmnGrid = "EqpmnGrid";
			var relateMtrilGrid = "RelateMtrilGrid";
			var relateExprGrid = "RelateExprGrid";
			var eqpmnInspctCrrctGrid = "EqpmnInspctCrrctGrid";
			var eqpmnEdayChckGrid = "EqpmnEdayChckGrid";

			var dropZoneArea;
			var lang = ${msg};

			//그리드 별 순서변경버튼 클릭 카운트
			var clickCntByChangeOrdrP = 1;
			var clickCntByChangeOrdrE = 1;
			var clickCntByChangeOrdrR = 1;
			var clickCntByChangeOrdrC = 1;

			var commonGridProp = {
				editable : false,
				enableDrag : false,
				enableMultipleDrag : true,
				enableDragByCellDrag : true,
				enableDrop : true
			};
			var enableDropProp = {
				editable : false,
				enableDrag : true,
				enableMultipleDrag : true,
				enableDragByCellDrag : true,
				enableDrop : true
			};
			var sessionObj = {
				bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}",
				deptCode : "${UserMVo.deptCode}"
			};

			var searchForm = document.getElementById('SearchForm').id;
			var eqpmnForm = document.getElementById('EqpmnForm').id;
			var lasForm = document.getElementById('LasForm').id;
			var getEl = function(id) {
				return document.getElementById(id);
			};
			var getVal = function(id) {
				return document.getElementById(id).value;
			};
			var setVal = function(id, val) {
				document.getElementById(id).value = val;
			};

			$(function() {
				buildGrid().then(function() {
					auiGridEvent();
				});
				buttonEvent();
				setCombo();
				renderDialog();
			});


			function renderDialog() {
				//제품 팝업
				dialogMtril("btnAddMtril", "EqpmnM", "relateEqpmnMtril", relateMtrilGrid, function(item) {
					for (var i = 0; i < item.length; i++) {
						item[i].gbnCrud = "C";
					}
					AUIGrid.addRow(relateMtrilGrid, item, "last");
				}, sessionObj);

				//일반 시험항목 팝업
				dialogAddExpriemList("btnAddExpr", { pageNm : "EqpmnR" }, "RelateExpr", relateExprGrid, function(item) {
					for (var i = 0; i < item.length; i++) {
						item[i].expriemSeqno = item[i].expriemSeqno;
						item[i].expriemNm = item[i].expriemNm;
						item[i].gbnCrud = "C";
					}
					AUIGrid.addRow(relateExprGrid, item, "last");
				});

				//검교정구분 팝업
				dialogInspctCrrctM("btnAddInspctCrrct", null, "inspctCrrct", eqpmnInspctCrrctGrid, function(item) {
					for (var i = 0; i < item.length; i++) {
						item[i].inspctCrrctSeCode = item[i].value;
						item[i].inspctCrrctSeNm = item[i].key;
						item[i].gbnCrud = "C";
					}
					AUIGrid.addRow(eqpmnInspctCrrctGrid, item, "last");
				});

				//일상점검 시험항목 팝업
				dialogAddExpriemList("btnAddChckExpr", { pageNm : "EqpmnE" }, "ExpriemE", eqpmnEdayChckGrid, function(item) {
					for (var i = 0; i < item.length; i++) {
						item[i].expriemSeqno = item[i].expriemSeqno;
						item[i].expriemNm = item[i].expriemNm;
						item[i].jdgmntFomCode = "IM06000001";
						item[i].mummValueSeCode = "IM08000001";
						item[i].mxmmValueSeCode = "IM07000001";
						item[i].gbnCrud = "C";
					}
					AUIGrid.addRow(eqpmnEdayChckGrid, item, "last");
				});

				eqpmnStateCtrl();
				lasUseCtrl();
				dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnFileSave", maxFiles : 10, lang : lang.C100000867 });
				datePickerCalendar(["purchsDte", "wrhousngDte", "dsuseDte"]);
			}


			//폐기장비에 대한 입력폼 컴트롤
			function eqpmnStateCtrl() {
				if (getVal('mhrlsSttusCode') == "RS04000006") {
					formLeastElAttrCtrl({
						formId: eqpmnForm
						, targetElName: ['dsuseDte', 'dsuseResn']
						, disableSet: false
						, requireSet: true
					});
				} else {
					formLeastElAttrCtrl({
						formId: eqpmnForm
						, targetElName: ['dsuseDte', 'dsuseResn']
						, disableSet: true
						, requireSet: false
						, callback: function() {
							setVal('dsuseDte', '');
							setVal('dsuseResn', '');
						}
					});
				}
			}


			//LAS 사용여부에 따른 입력폼 컨트롤
			function lasUseCtrl() {
				if (getEl('lasUseAt_Y').checked == true) {
					formMostElAttrCtrl({
						formId: lasForm
						, ignoreElName: ['lasUseAt']
						, disableSet: false
						, requireSet: true
						, callback: function() {
							getEl('acc3').setAttribute("style", "display: block");
						}
					});
				} else {
					formMostElAttrCtrl({
						formId: lasForm
						, ignoreElName: ['lasUseAt']
						, disableSet: true
						, requireSet: false
						, callback: function() {
							getEl(lasForm).reset();
						}
					});
				}
			}


			function setCombo() {
				ajaxSelect2Box({ ajaxUrl : "/com/getEqpmnNmCombo.lims", elementId : "replcEqpmnNm" });
				ajaxJsonComboBox("/com/getCmmnCode.lims", "schEqpmnClCode", { upperCmmnCode : "RS02" }, true);
				ajaxJsonComboBox("/com/getCustLabCombo.lims", "schCustLab", null, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "eqpmnClCode", { upperCmmnCode : "RS02" }, true);
				ajaxJsonComboBox("/com/getCustLabCombo.lims", "custlabSeqno", null, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "acqsSttusCode",{ upperCmmnCode : "RS03" }, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "mhrlsSttusCode", { upperCmmnCode : "RS04" }, true);
				ajaxJsonComboBox("/wrk/getDeptComboList.lims", "chrgDeptCode", { bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}" }, true);
				ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberBId", null, true);
				ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberJId", null, true);
				return ajaxJsonComboBox("/com/getCmmnCode.lims", "lasResultSeCode", { upperCmmnCode : "RS18" }, true);
			}


			function buildGrid() {
				var eqpmnGridProp = {
					editable : false,
					selectionMode : "multipleCells",
					showRowCheckColumn : true,
					showRowAllCheckBox : true
				};

				var col = [];
				auigridCol(col);
				col.addColumn("eqpmnClNm", lang.C100000745, "*", true)
				.addColumn("eqpmnSeqno", lang.C000001396, "*" ,false)
				.addColumn("bplcCode", lang.C100000432, "*", false)
				.addColumn("chrgDeptCode", lang.C100000198, "*", false)
				.addColumn("eqpmnClCode", lang.C100000745, "*", false)
				.addColumn("eqpmnManageNo", lang.C100000739, "*", true)
				.addColumn("eqpmnNm", lang.C100000742, "*", true)
				.addColumn("serialNo", lang.C100000089, "*", true)
				.addColumn("modlNm", "모델 명", "*", true)
				.addColumn("mnfcturCmpnyNm", "제조원", "*", true)
				.addColumn("dvyfgofficNm", "납품처", "*", true)
				.addColumn("purchsDte", "구입 일자", "*", true)
				.addColumn("prpos", "용도", "*", true)
				.addColumn("custlabSeqno", "분석실", "*", false)
				.addColumn("custlabNm", "분석실", "*", true)
				.addColumn("mtrilNm", "분석 제품", "*", true)
				.addColumn("replcEqpmnNm", "Back Up", "*", false)
				.addColumn("replcEqpmn", "Back Up", "*", true)
				.addColumn("analsReqreTime", lang.C100000411, "*", true, false, null, null, "#,###", "numeric")
				.addColumn("chrgDeptNm", lang.C100001313, "*", true)
				.addColumn("manageRspnberJId", lang.C100000202, "*", false)
				.addColumn("manageRspnberBId", lang.C100000201, "*", false)
				.addColumn("manageRspnberJ", lang.C100000202, "*", true)
				.addColumn("manageRspnberB", lang.C100000201, "*", true)
				.addColumn("acqsSttusCode", lang.C100000901, "*", false)
				.addColumn("acqsSttus", lang.C100000901, "*", true)
				.addColumn("acqsAmount", lang.C100000900, "*", true, false, null, null, "#,###", "numeric")
				.addColumn("cnYycnt", "내용 년수", "*", true)
				.addColumn("wrhousngDte", lang.C100000692, "*", true)
				.addColumn("mhrlsSttusCode", lang.C100000748, "*", false)
				.addColumn("mhrlsSttus", lang.C100000748, "*", true)
				.addColumn("dsuseDte", lang.C100000933, "*", true)
				.addColumn("dsuseResn", lang.C100000931, "*", false)
				.addColumn("oprAt", lang.C100000106, "*", true)
				.addColumn("detectLimitApplcAt", lang.C100000038, "*", false)
				.addColumn("atchmnflSeqno", lang.C100000746, "*", false)
				.addColumn("lasUseAt", lang.C100000049, "*", true)
				.addColumn("mhrlsPcIp", lang.C100000737, "*", true)
				.addColumn("comPortNo", lang.C100000034, "*", true)
				.addColumn("commnVeValue", lang.C100000911, "*", true)
				.addColumn("dataBitValue", lang.C100000286, "*", true)
				.addColumn("parityValue", lang.C100000071, "*", true)
				.addColumn("dtrWireValue", lang.C100000040, "*", true)
				.addColumn("lasResultSeCode", lang.C100000048, "*", false)
				.addColumn("lasResult", lang.C100000048, "*", true)
				.addColumn("useAt", lang.C100000443, "*", false);

				eqpmnGrid = createAUIGrid(col, eqpmnGrid, eqpmnGridProp);


				//드랍다운리스트에 사용될 리스트를 먼저 받아와 렌더링해줌
				return $.when(
					customAjax({"url": "/com/getCmmnCode.lims", "data": { upperCmmnCode: "RS24" }}),
					customAjax({"url": "/com/getCmmnCode.lims", "data": { upperCmmnCode: "SY14" }}),
					customAjax({"url": "/wrk/getMasterUnitList.lims", "data": { unitSeCode: "SY10000001" }}),
					customAjax({"url": "/com/getCmmnCode.lims", "data": { upperCmmnCode: "IM06", notInCode: "IM06000002" }}),
					customAjax({"url": "/com/getCmmnCode.lims", "data": { upperCmmnCode: "IM08" }}),
					customAjax({"url": "/com/getCmmnCode.lims", "data": { upperCmmnCode: "IM07" }})

				).then(function(inspctUnit, cycleUnit, unitList, jdgUnit, underUnit, upperUnit) {
					var colObj = {
						relateMtrilGrid : [],
						relateExprGrid : [],
						eqpmnInspctCrrctGrid : [],
						eqpmnEdayChckGrid : []
					};

					var headerTooltipPros = {
						style : "my-require-style",
						headerTooltip : {
							show : true,
							tooltipHtml : lang.C100000114
						}
					};

					/*************************** 관련 제품 **************************/
					auigridCol(colObj.relateMtrilGrid);
					colObj.relateMtrilGrid
					.addColumn("eqpmnAnalsPrductSeqno", lang.C100000722, "*", false)
					.addColumn("eqpmnSeqno", lang.C100000722, "*", false)
					.addColumn("mtrilSeqno", lang.C100000722, "*", false)
					.addColumn("deptNm", lang.C100000198, "*", true)
					.addColumn("prductSeCodeNm", "제품 구분", "*", true)
					.addColumn("mtrilCode", lang.C100000725, "*", true)
					.addColumn("mtrilNm", lang.C100000717, "*", true)
					.addColumn("sortOrdr", lang.C000000390, "*", false)
					.addColumn("gbnCrud", "gbnCrud", "*", false);

					relateMtrilGrid = createAUIGrid(colObj.relateMtrilGrid, relateMtrilGrid, commonGridProp);



					/*************************** 관련 시험항목 **************************/
					auigridCol(colObj.relateExprGrid);
					colObj.relateExprGrid
					.addColumn("eqpmnAnalsIemSeqno", lang.C100000560, "*", false)
					.addColumn("eqpmnSeqno", lang.C100000560, "*", false)
					.addColumn("expriemSeqno", lang.C100000560, "*", false)
					.addColumn("expriemNm", lang.C100000560, "*", true)
					.addColumn("sortOrdr", lang.C000000390, "*", false)
					.addColumn("gbnCrud", "gbnCrud", "*", false);

					relateExprGrid = createAUIGrid(colObj.relateExprGrid, relateExprGrid, commonGridProp);



					/*************************** 검교정 주기정보 **************************/
					var inspctCrrctGridProp = {
						editable : true,
						enableDrag : true,
						enableMultipleDrag : true
					};

					auigridCol(colObj.eqpmnInspctCrrctGrid);
					colObj.eqpmnInspctCrrctGrid
					.addColumnCustom("eqpmnSeqno", lang.C000001396, "*", false)
					.addColumnCustom("bplcCode", lang.C100000432, "*", false)
					.addColumnCustom("inspctCrrctSeCode", lang.C100000138, "*", false)
					.addColumnCustom("inspctCrrctSeNm", lang.C100000138, "*", true, false, headerTooltipPros)
					.addColumnCustom("inspctCrrctCycle", lang.C100000136, "*", true, true, headerTooltipPros)
					.addColumnCustom("cycleCode", lang.C100000137, "*", true, true, headerTooltipPros)
					.addColumnCustom("inspctCrrctPrearngeDte", lang.C100000135, "*", true, false)
					.addColumnCustom("recentInspctCrrctDte", lang.C100000873, "*", true, false)
					.addColumnCustom("gbnCrud", "gbnCrud", "*", false)
					.addValidator(["inspctCrrctCycle"], "OnlyNum", null, lang.C100001306)
					.dropDownListRenderer(["cycleCode"], cycleUnit[0], true);

					eqpmnInspctCrrctGrid = createAUIGrid(colObj.eqpmnInspctCrrctGrid, eqpmnInspctCrrctGrid, inspctCrrctGridProp);



					/*************************** 일상점검 시험항목 **************************/
					var edayChckGridProp = {
						editable : true,
						enableDrag : false,
						enableMultipleDrag : true,
						enableDragByCellDrag : true,
						enableDrop : true
					};

					auigridCol(colObj.eqpmnEdayChckGrid);
					colObj.eqpmnEdayChckGrid
					.addColumnCustom("eqpmnChckExpriemSeqno", lang.C000001403, "*", false)
					.addColumnCustom("bplcCode", lang.C100000432, "*", false)
					.addColumnCustom("eqpmnSeqno", lang.C000001396, "*", false)
					.addColumnCustom("expriemSeqno", lang.C000000755, "*", false)
					.addColumnCustom("expriemNm", lang.C100000560, "*", true, false)
					.addColumnCustom("unitSeqno", lang.C100000268, "*", true, true)
					.addColumnCustom("jdgmntFomCode", lang.C100000920, "*", true, true, headerTooltipPros)
					.addColumnCustom("textStdr", lang.C100000909, "*", true, true, headerTooltipPros)
					.addColumnCustom("mummValue", lang.C100000051, "*", true, true, headerTooltipPros)
					.addColumnCustom("mummValueSeCode", lang.C100000052, "*", true, true, headerTooltipPros)
					.addColumnCustom("mxmmValue", lang.C100000094, "*", true, true, headerTooltipPros)
					.addColumnCustom("mxmmValueSeCode", lang.C100000095, "*", true, true, headerTooltipPros)
					.addColumnCustom("sortOrdr", lang.C000000390, "*", false)
					.addColumnCustom("gbnCrud", "gbnCrud", "*", false)
					.addValidator(["mummValue", "mxmmValue"], "OnlyNum", null, lang.C100001306)
					.dropDownListRenderer(["unitSeqno"], unitList[0], true)
					.dropDownListRenderer(["jdgmntFomCode"], jdgUnit[0], true)
					.dropDownListRenderer(["mummValueSeCode"], underUnit[0], true)
					.dropDownListRenderer(["mxmmValueSeCode"], upperUnit[0], true);

					eqpmnEdayChckGrid = createAUIGrid(colObj.eqpmnEdayChckGrid, eqpmnEdayChckGrid, edayChckGridProp);

					gridResize([
						eqpmnGrid,
						relateMtrilGrid,
						relateExprGrid,
						eqpmnInspctCrrctGrid,
						eqpmnEdayChckGrid
					]);
				});
			}


			function loadEqpmnDetailGrid(seqNo) {
				getGridDataParam("/rsc/getAnalsMtrilList.lims", { eqpmnSeqno : seqNo }, relateMtrilGrid);
				getGridDataParam("/rsc/getAnalsItemList.lims", { eqpmnSeqno : seqNo }, relateExprGrid);
				getGridDataParam("/rsc/getCrrctCycleList.lims", { eqpmnSeqno : seqNo }, eqpmnInspctCrrctGrid);
				getGridDataParam("/rsc/getEqpmnChckExpr.lims", { eqpmnSeqno : seqNo }, eqpmnEdayChckGrid);
			}


			function auiGridEvent() {
				AUIGrid.bind(eqpmnGrid, "cellDoubleClick", function(event) {
					getEl('btnDelete').style.display = '';
					var item = event.item;
					ajaxJsonComboBox("/wrk/getDeptComboList.lims","chrgDeptCode", { bestInspctInsttCode: item.bplcCode }, true)
					.then(function() {
						return ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberJId", { deptCode: item.chrgDeptCode }, true)
					})
					.then(function() {
						return ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberBId", { deptCode: item.chrgDeptCode }, true, null, item.manageRspnberBId)
					})
					.then(function() {
						detailAutoSet({
							item: item
							,targetFormArr: [eqpmnForm, lasForm]
							,ignoreFormArr: [searchForm]
							,successFunc: function() {
								//detailAutoSet에 putComma 기능이 있지만 적용되지 않아 직접 comma 적용
								if (!!item.acqsAmount)
									setVal('acqsAmount', new Intl.NumberFormat().format(item.acqsAmount));
								else
									setVal('acqsAmount', '');

								if (item.lasUseAt == "Y")
									getEl('lasUseAt_Y').checked = true;

								eqpmnStateCtrl();
								lasUseCtrl();
								setVal('crud', 'U');
								dropZoneArea.getFiles(item.atchmnflSeqno);
							}
						});
					});

					loadEqpmnDetailGrid(item.eqpmnSeqno);
				});

				//검교정예정일자 계산
				AUIGrid.bind(eqpmnInspctCrrctGrid, "cellEditEnd", function(event) {
					var cycleVal = event.item.inspctCrrctCycle;
					var cycleCode = event.item.cycleCode;
					var recentCrrctDte = event.item.recentInspctCrrctDte;

					if (!!cycleVal && !!cycleCode && !!recentCrrctDte) {
						if (event.dataField == "inspctCrrctCycle" || event.dataField == "cycleCode") {
							var date = new Date(recentCrrctDte);
							if (cycleCode == "SY14000001") {
								date.setFullYear(date.getFullYear() + Number(cycleVal));
							} else if (cycleCode == "SY14000002") {
								date.setMonth((date.getMonth()) + (Number(cycleVal) * 6));
							} else if (cycleCode == "SY14000003") {
								date.setMonth((date.getMonth()) + (Number(cycleVal) * 3));
							} else if (cycleCode == "SY14000004") {
								date.setMonth((date.getMonth()) + Number(cycleVal));
							} else if (cycleCode == "SY14000005") {
								date.setDate(date.getDate() + Number(cycleVal));
							}

							AUIGrid.setCellValue(eqpmnInspctCrrctGrid, event.rowIndex, "inspctCrrctPrearngeDte", setFormatDate(date));
						}
					}

					AUIGrid.updateRow(eqpmnInspctCrrctGrid, { gbnCrud: "U" }, event.rowIndex);
				});

				//판정기준 없는 시험항목 수정 방지
				AUIGrid.bind(eqpmnEdayChckGrid, "cellEditBegin", function(event) {
					if (event.item.jdgmntFomCode == "IM06000004" && event.dataField != "jdgmntFomCode")
						return false;
				});

				//판정기준별 컬럼값 초기화
				AUIGrid.bind(eqpmnEdayChckGrid, "cellEditEnd", function(event) {
					if (event.item.jdgmntFomCode == "IM06000003") {
						AUIGrid.updateRow(eqpmnEdayChckGrid, {
							mummValue: "",
							mummValueSeCode: "",
							mxmmValue: "",
							mxmmValueSeCode: ""
						}, event.rowIndex);

					} else if (event.item.jdgmntFomCode == "IM06000001") {
						AUIGrid.updateRow(eqpmnEdayChckGrid,{ textStdr: "" }, event.rowIndex);

					} else if (event.item.jdgmntFomCode == "IM06000004") {
						AUIGrid.updateRow(eqpmnEdayChckGrid,{
							textStdr: "",
							mummValue: "",
							mummValueSeCode: "",
							mxmmValue: "",
							mxmmValueSeCode: ""
						}, event.rowIndex);
					}

					AUIGrid.updateRow(eqpmnEdayChckGrid, { gbnCrud: "U" }, event.rowIndex);
				});


				/*************************** gbnCrud 업데이트 위한 이벤트 ***************************/
				AUIGrid.bind(relateMtrilGrid, "dropEnd", function(event) {
					AUIGrid.updateRow(relateMtrilGrid, { gbnCrud : "U" }, event.toRowIndex);
				});

				AUIGrid.bind(relateExprGrid, "dropEnd", function(event) {
					AUIGrid.updateRow(relateExprGrid, { gbnCrud : "U" }, event.toRowIndex);
				});

				AUIGrid.bind(eqpmnEdayChckGrid, "dropEnd", function(event) {
					AUIGrid.updateRow(eqpmnEdayChckGrid, { gbnCrud : "U" }, event.toRowIndex);
				});
			}


			//일상점검시험항목 Validation 체크
			function validChkEdayGrid() {
				var isValid = true;
				var data = AUIGrid.getGridData(eqpmnEdayChckGrid);

				if (data.length == 0)
					return isValid;

				for (var i = 0; i < data.length; i++) {
					var rowIndex;      //선택할 행 index
					var colIndex;      //선택할 컬럼 index
					var startColIndex; //선택할 컬럼 시작 index
					var endColIndex;   //선택할 컬럼 끝 index

					switch (data[i].jdgmntFomCode) {
						case "IM06000001":
							isValid = ((!!data[i].mummValue && !!data[i].mummValueSeCode) || (!!data[i].mxmmValue && !!data[i].mxmmValueSeCode));
							rowIndex = i;
							startColIndex = AUIGrid.getColumnIndexByDataField(eqpmnEdayChckGrid, "mummValue");
							endColIndex = AUIGrid.getColumnIndexByDataField(eqpmnEdayChckGrid, "mxmmValueSeCode");
							AUIGrid.setSelectionBlock(eqpmnEdayChckGrid,rowIndex,rowIndex,startColIndex,endColIndex);
							break;
						case "IM06000003":
							isValid = !!data[i].textStdr;
							rowIndex = i;
							colIndex = AUIGrid.getColumnIndexByDataField(eqpmnEdayChckGrid, "textStdr");
							AUIGrid.setSelectionBlock(eqpmnEdayChckGrid,rowIndex,rowIndex,colIndex,colIndex);
							break;
						case "":
						case null:
							isValid = false;
							rowIndex = i;
							colIndex = AUIGrid.getColumnIndexByDataField(eqpmnEdayChckGrid, "jdgmntFomCode");
							AUIGrid.setSelectionBlock(eqpmnEdayChckGrid,rowIndex,rowIndex,colIndex,colIndex);
							break;
						default:
							isValid = true;
							break;
					}
				}

				return isValid;
			}


			function buttonEvent() {
				getEl('btnSelect').addEventListener("click", function() {
					searchEqpmn();
				});

				getEl('btnReset').addEventListener("click", function() {
					pageReset([eqpmnForm], [relateMtrilGrid, relateExprGrid, eqpmnInspctCrrctGrid, eqpmnEdayChckGrid], [dropZoneArea],
						function() {
							$("#replcEqpmnNm").change();
						}
					);
					getEl('btnDelete').style.display = 'none';
					getEl('lasUseAt_N').checked = true;
					lasUseCtrl();
				});

				getEl('btnDelete').addEventListener("click", function() {
					if (confirm(lang.C100000461))
						delEqpmn();
				});

				getEl('btnSave').addEventListener("click", function() {
					saveValid();
				});

				getEl('mhrlsSttusCode').addEventListener("change", function() {
					eqpmnStateCtrl();
				});

				document.getElementsByName('lasUseAt').forEach(function(el) {
					el.addEventListener("change", function() {
						lasUseCtrl();
					});
				});

				getEl('chrgDeptCode').addEventListener("change", function() {
					ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberJId", { deptCode : getVal('chrgDeptCode') }, true, null, null, null, function(item) {
						ajaxJsonComboBox("/com/getDeptToUserLsit.lims", "manageRspnberBId", { deptCode : getVal('chrgDeptCode') }, true, null, null, null);
					});
				});

				getEl('btnDelMtril').addEventListener("click", function() {
					var selected = AUIGrid.getSelectedRows(relateMtrilGrid);
					if (selected.length == 0)
						return;

					if (confirm(lang.C100000461))
						delRelateMtril(selected);
				});

				getEl('btnDelExpr').addEventListener("click", function() {
					var selected = AUIGrid.getSelectedRows(relateExprGrid);
					if (selected.length == 0)
						return;

					if (confirm(lang.C100000461))
						delRelateItem(selected);
				});

				getEl('btnDelInspctCrrct').addEventListener("click", function() {
					var selected = AUIGrid.getSelectedRows(eqpmnInspctCrrctGrid);
					if (selected.length == 0)
						return;

					if (confirm(lang.C100000461))
						delInspctCrrct(selected);
				});

				getEl('btnDelChckExpr').addEventListener("click", function() {
					var selected = AUIGrid.getSelectedRows(eqpmnEdayChckGrid);
					if (selected.length == 0)
						return;

					if (confirm(lang.C100000461))
						delEdayExpriem(selected);
				});

				getEl('btnChangeOrdrP').addEventListener("click", function() {
					clickCntByChangeOrdrP++;
					if (clickCntByChangeOrdrP % 2 == 0) {
						AUIGrid.setProp(relateMtrilGrid, enableDropProp);
						alert(lang.C100000548); //순서변경 가능상태 입니다.
					} else {
						AUIGrid.setProp(relateMtrilGrid, commonGridProp);
						alert(lang.C100000549); //순서변경 불가능상태 입니다.
					}
				});

				getEl('btnChangeOrdrE').addEventListener("click", function() {
					clickCntByChangeOrdrE++;
					if (clickCntByChangeOrdrE % 2 == 0) {
						AUIGrid.setProp(relateExprGrid, enableDropProp);
						alert(lang.C100000548); //순서변경 가능상태 입니다.
					} else {
						AUIGrid.setProp(relateExprGrid, commonGridProp);
						alert(lang.C100000549); //순서변경 불가능상태 입니다.
					}
				});

				getEl('btnChangeOrdrC').addEventListener("click", function() {
					clickCntByChangeOrdrC++;
					if (clickCntByChangeOrdrC % 2 == 0) {
						AUIGrid.setProp(eqpmnEdayChckGrid, {
							editable : true,
							enableDrag : true,
							enableMultipleDrag : true,
							enableDragByCellDrag : true,
							enableDrop : true
						});
						alert(lang.C100000548); //순서변경 가능상태 입니다.

					} else {
						AUIGrid.setProp(eqpmnEdayChckGrid, {
							editable : true,
							enableDrag : false,
							enableMultipleDrag : true,
							enableDragByCellDrag : true,
							enableDrop : true
						});
						alert(lang.C100000549); //순서변경 불가능상태 입니다.
					}
				});
			}


			//데이터 저장 전 Validation 체크
			function saveValid() {
				if (!(saveValidation(eqpmnForm) && saveValidation(lasForm)))
					return;

				var validChk = gridRequire({
					requireColumns: ["inspctCrrctSeCode", "inspctCrrctCycle", "cycleCode"],
					gridId: eqpmnInspctCrrctGrid,
					list: AUIGrid.getGridData(eqpmnInspctCrrctGrid),
					zeroCheck: true,
					msg: lang.C100000133 //검교정주기정보 필수 입력값을 확인해주세요.
				});
				if (!validChk) {
					return;
				}

				//일상점검시험항목 Validation 체크
				if (!validChkEdayGrid()) {
					warn(lang.C100000686); //일상점검 시험항목 필수 입력값을 확인해주세요.
					return;
				}

				//데이터 추가,수정이 없는 그리드는 저장에 필요한 parameter에서 제외
				var gbnObj = ["C", "U"];
				var editMtril = AUIGrid.getRowsByValue(relateMtrilGrid, "gbnCrud", gbnObj).length;
				var editExpr = AUIGrid.getRowsByValue(relateExprGrid, "gbnCrud", gbnObj).length;
				var editInspct = AUIGrid.getRowsByValue(eqpmnInspctCrrctGrid, "gbnCrud", gbnObj).length;
				var editChkExpr = AUIGrid.getRowsByValue(eqpmnEdayChckGrid, "gbnCrud", gbnObj).length;

				var gridParam = {};
				if (editMtril > 0)
					gridParam.relateMtrilGrid = AUIGrid.getGridData(relateMtrilGrid);
				if (editExpr > 0)
					gridParam.relateExprGrid = AUIGrid.getGridData(relateExprGrid);
				if (editInspct > 0)
					gridParam.inspctCrrctGrid = AUIGrid.getGridData(eqpmnInspctCrrctGrid);
				if (editChkExpr > 0)
					gridParam.edayExpriemGrid = AUIGrid.getGridData(eqpmnEdayChckGrid);

				var fileCnt = dropZoneArea.getNewFiles().length;
				if (fileCnt > 0) {
					getEl('btnFileSave').click();
					dropZoneArea.on("uploadComplete", function(event, fileIdx) {
						if (fileIdx === -1) {
							err(lang.C100000864); //첨부파일 저장에 실패하였습니다.
						} else {
							setVal('atchmnflSeqno', fileIdx);
							saveEqpmn(gridParam);
						}
					});
				} else {
					saveEqpmn(gridParam);
				}
			}


			function saveEqpmn(gridParam) {
				//저장 직전에 콤마제거
				setVal('acqsAmount', getVal('acqsAmount').replace(/,/gi, ""));
				setVal('analsReqreTime', getVal('analsReqreTime').replace(/,/gi, ""));

				var param =  Object.assign(getEl(eqpmnForm).toObject(), getEl(lasForm).toObject());
				param = Object.assign(param, gridParam);
				//신규등록
				if (getVal('crud') == "C") {
					customAjax({
						"url": "/rsc/insEqpmn.lims",
						"data": param,
						"elementIds": ["btnSave"],
						"successFunc": function(data) {
							if (data > 0) {
								success(lang.C100000762); //저장되었습니다.
								getEl('btnReset').click();
								eqpmnStateCtrl();
								searchEqpmn(data);
							} else {
								err(lang.C100000597); //저장에 실패하였습니다.
							}
						}
					});
				//데이터수정
				} else {
					customAjax({
						"url": "/rsc/updEqpmn.lims",
						"data": param,
						"elementIds": ["btnSave"],
						"successFunc": function(data) {
							if (data > 0) {
								success(lang.C100000762); //저장되었습니다.
								getEl('btnReset').click();
								eqpmnStateCtrl();
								searchEqpmn(data);
							} else {
								err(lang.C100000597); //저장에 실패하였습니다.
							}
						}
					});
				}
			}


			function searchEqpmn(returnSeq) {
				getGridDataForm("/rsc/getEqpmnMList.lims", searchForm, eqpmnGrid, function() {
					if (returnSeq)
						gridSelectRow(eqpmnGrid, "eqpmnSeqno", returnSeq);
				});
			}


			function delEqpmn() {
				if (getVal('crud') != "U")
					return;

				setVal('deleteAt', 'Y');
				setVal('acqsAmount', getVal('acqsAmount').replace(/,/gi, ""));
				var param = Object.assign(getEl(eqpmnForm).toObject(), getEl(lasForm).toObject());
				customAjax({
					"url": "/rsc/updEqpmn.lims",
					"data": param,
					"elementIds": ["btnSave"],
					"successFunc": function(data) {
						if (data == 0) {
							err(lang.C100000464); //삭제에 실패하였습니다.
						} else {
							success(lang.C100000462); //저장되었습니다.
							getEl('btnReset').click();
							eqpmnStateCtrl();
							searchEqpmn();
						}
					}
				});
			}


			function delRelateMtril(list) {
				customAjax({
					"url": "/rsc/delAnalsMtril.lims",
					"data": list,
					"successFunc": function(data) {
						if (data > 0) {
							AUIGrid.removeRow(relateMtrilGrid, "selectedIndex");
							success(lang.C100000462); //삭제되었습니다.
						}
					}
				});
			}


			function delRelateItem(list) {
				customAjax({
					"url": "/rsc/delAnalsItem.lims",
					"data": list,
					"successFunc": function(data) {
						if (data > 0) {
							AUIGrid.removeRow(relateExprGrid, "selectedIndex");
							success(lang.C100000462); //삭제되었습니다.
						}
					}
				});
			}


			function delInspctCrrct(list) {
				customAjax({
					"url": "/rsc/delCrrctCycle.lims",
					"data": list,
					"successFunc": function(data) {
						if (data > 0) {
							AUIGrid.removeRow(eqpmnInspctCrrctGrid, "selectedIndex");
							success(lang.C100000462); //삭제되었습니다.
						}
					}
				});
			}


			function delEdayExpriem(list) {
				customAjax({
					"url": "/rsc/delChckExpr.lims",
					"data": list,
					"successFunc": function(data) {
						if (data > 0) {
							AUIGrid.removeRow(eqpmnEdayChckGrid, "selectedIndex");
							success(lang.C100000462); //삭제되었습니다.
						}
					}
				});
			}


			function printBrcd() {
				var gridData = AUIGrid.getCheckedRowItemsAll(eqpmnGrid);
				if (gridData.length == 0)
					return;

				var RdUrl = "";
				var param = {
					printngSeCode: "SY15000001",
					printngOrginlFileNm: "EqpmnLabel.mrd"
				};

				customAjax({
					url: "/com/printCours.lims",
					data: param,
					successFunc: function(data) {
						if (data.length == 1) {
							RdUrl = data[0].printngOrginlFileNm; //로컬서버
							//RdUrl = data[0].printngCours; //운영서버

							var seqArr = gridData.map(function(item) {
								return item.eqpmnSeqno;
							});
							html5Viewer([RdUrl], seqArr);
						} else {
							err(lang.C100000597);
						}
					}
				});
			}


			function doSearch() {
				searchEqpmn();
			}


		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
