<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">제품 관리</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent" style="height:1500px;">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>제품 목록</h2> <!-- 제품목록-->
				<div class="btnWrap">
					<button id="btnMtrilSearch" class="btn3 search" >${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="frmSearch">
					<input type="hidden" id="authorCode" name="authorCode" />
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
							<th>조직 명</th> <!-- 조직 명 -->
							<td>
								<select class="schClass" name="deptCodeSch" id="deptCodeSch">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
								</select>
							</td>

							<th>제품 구분</th> <!-- 제품 구분 -->
							<td>
								<select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
								</select>
							</td>

							<th>${msg.C100000717}</th> <!-- 제품명 -->
							<td><label><input type="text" class="schClass" name="mtrilNmSch"></label></td>

							<th>${msg.C100000725}</th> <!-- 제품코드 -->
							<td><label><input type="text" class="schClass" name="mtrilCodeSch"></label></td>
						</tr>
						<tr>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align: left;" colspan="7">
								<label><input type="radio" name="useAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useAtSch" value="Y">${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAtSch" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2"> <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="mtrilGrId" class="mgT15" style="width: 100%; height: 200px; margin: 0 auto;"></div>
			</div>
			<div class="subCon2">
				<div class="mapkey">
					<label class="scarce">${msg.C100001001}</label> <!-- 제품 기준 미등록 -->
				</div>
			</div>

			<div class="subCon1 mgT15">
				<h2><i class="fi-rr-apps"></i>${msg.C100000724}</h2> <!-- 제품 정보-->
				<div class="btnWrap btnDtl">
					<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button id="btnDelete" class="btn5 delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
					<button id="btnSave" class="btn1 save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<form id="frmProductDtl">
					<input type="text" name="mtrilSeqno" id="mtrilSeqno" style=" display:none; "/>
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
							<th class="necessary">${msg.C100000821}</th> <!-- 조직 명 -->
							<td><select id="deptCode" name="deptCode" required></select></td>

							<th class="necessary">제품 유형</th> <!-- 제품 유형 -->
							<td><select name="mtrilTyCode" id="mtrilTyCode" required></select></td>

							<th class="necessary">제품 구분</th> <!-- 제품 구분 -->
							<td><select name="prductSeCode" id="prductSeCode" required></select></td>

							<th class="necessary">제품 명</th> <!-- 제품 명 -->
							<td><input type="text" class="wd100p schClass" name="mtrilNm" id="mtrilNm" maxlength="200" required></td>
						</tr>
						<tr>
							<th>${msg.C100000725}</th> <!-- 제품 코드 -->
							<td><input type="text" class="wd100p schClass" name="mtrilCode" id="mtrilCode" maxlength="8"></td>

							<th>${msg.C100000443}</th> <!-- 사용 여부 -->
							<td style="text-align: left;">
								<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" id="useN" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
							<td colspan="4"></td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th> <!-- 비고 -->
							<td colspan="7"><textarea id="rm" name="rm"  class="wd100p" style="min-width:10em;" maxlength = "4000"></textarea></td>
						</tr>
						<tr id="eqpmnTr" style="display: none">
							<th class="necessary" >장비 분류</th> <!-- 장비 분류 -->
							<td><select name="eqpmnClCode" id="eqpmnClCode"></select></td>
						</tr>
					</table>
				</form>
			</div>

			<div class="subCon2 wd100p mgT20 fR">
				<div class="subCon1 ">
					<h3>${msg.C100000565}</h3> <!-- 시험항목 정보 -->
					<div class="btnWrap">
						<button id="btnAddExpriemAll" class="btn5" style="display: none;">${msg.C100000564}</button> <!-- 시험 항목 일괄추가 -->
						<button id="btnAddExpriem" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 시험항목 추가 -->
						<button id="btnDelExpriem" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 시험항목 삭제 -->
						<button id="btnChangeOrdr" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
					</div>
				</div>
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="testGrid" class="mgT15 grid" style="width: 100%; height: 400px; margin: 0 auto;"></div>
			</div>

			<div class="subCon2 wd48p fL mgT30" >
				<div class="subCon1 ">
					<h3>실린더No. 정보</h3> <!-- 실린더No. 정보 -->
					<div class="btnWrap">
						<button id="btnAddCylinder" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 시험항목 추가 -->
						<button id="btnDelCylinder" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 시험항목 삭제 -->
					</div>
				</div>
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="cylinderGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
			</div>

			<div class="subCon2 wd48p fR mgT30" style="margin-left:1%;">
				<div class="subCon1 ">
					<h3>아이템No. 정보</h3> <!-- 아이템No. 정보 -->
					<div class="btnWrap">
						<button id="btnAddItemNo" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
						<button id="btnDelItemNo" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
					</div>
				</div>
				<div id="itemNoGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.c-orange {
				background-color:#FEDBDE;
			}
		</style>
		<script>

			window.onload = function() {
				renderGrid().then(function(){
					gridEvent();
				});
				renderCombo();
				searchEvent();
				buttonEvent();
				initPopup();
			};

			var lang = ${msg};
			var clickCntByChangeOrdr = 1;

			//AUIGrid 생성 후 반환 ID
			var mtrilGrId = "mtrilGrId";
			var testGrid = "testGrid";
			var cylinderGrid ='cylinderGrid'
			var itemNoGrid = 'itemNoGrid'
			var getEl = function(id){
				return document.getElementById(id);
			};

			var columnLayout = {
				mtrilGrId: [],
				testGrid: [],
				itemNoGrid: [],
				cylinderGrid: []
			};
			var basicPros = {
				editable: true,
				enableDrag: true,
				enableMultipleDrag: true
			};
			var mtrilPros = {
				editable: true,
				rowIdField: "mtrilSeqno",
				showRowCheckColumn: true,
				showRowAllCheckBox: false,
				rowStyleFunction: function(rowIndex, item) {
					if (item.sdRegistAt == 'X') {
						return "c-orange";
					}
					return "";
				}
			};
			var testPros = {
				editable: true,
				showRowCheckColumn: true,
				enableDrag: true,
				enableMultipleDrag: true,
				enableDragByCellDrag: true,
				enableDrop: true
			};
			var NoPros = {
				editable: false,
				showRowCheckColumn: true
			};
			var itemPros = {
				editable: true,
				showRowCheckColumn: true
			};
			var numericPros = {
				type: "InputEditRenderer",
				onlyNumeric: true,
				allowPoint: true,
				allowNegative: true
			};
			var markCphrPros = {
				type: "InputEditRenderer",
				onlyNumeric: true,
				allowPoint: false,
				allowNegative: false
			};
			//특정 조건에 따라 미리 정의한 editRenderer 반환
			var conditionPros = {
				editable: true,
				selectionMode: "multipleCells",
				enableCellMerge: true,
				editRenderer: {
					type: "ConditionRenderer",
					conditionFunction: function(rowIndex, columnIndex, value, item, dataField) {
						if (dataField == 'lslValue' || dataField == 'lclValue' || dataField == 'uclValue' || dataField == 'uslValue'||dataField =='markCphr') {
							return numericPros;
						} else {
							return testPros;
						}
					}
				}
			};
			var groupGridColPros = {
				style: "my-require-style",
				headerTooltip: {
					show: true,
					tooltipHtml: '${msg.C100000114}' //값을 입력 또는 선택하세요.
				}
			};


			function renderGrid() {
				//제품목록
				auigridCol(columnLayout.mtrilGrId);
				columnLayout.mtrilGrId
				.addColumnCustom("mmnySeCode", lang.C100000714,"*",false) //자사구분
				.addColumnCustom("mmnySeCodeNm", lang.C100000714,"*",false) //자사구분
				.addColumnCustom("inspctInsttNm", lang.C100000432,"*",false) //사업장
				.addColumnCustom("deptCode", "조직 명","*",false) //조직 명
				.addColumnCustom("deptNm", "조직 명","*",true) //조직 명
				.addColumnCustom("mtrilTyCode", "제품 유형","*",false) //제품 유형
				.addColumnCustom("mtrilTyCodeNm", "제품 유형","*",true) //제품 유형
				.addColumnCustom("prductSeCode", "제품 구분","*",false) //제품 구분
				.addColumnCustom("prductSeCodeNm", "제품 구분","*",true) // 제품 구분명
				.addColumnCustom("mtrilNm", lang.C100000717,"*",true) //자재명
				.addColumnCustom("mtrilCode", lang.C100000725,"*",true) //자재코드
				.addColumnCustom("eqpmnClCode","장비 분류","*",false) //장비 분류
				.addColumnCustom("eqpmnClCodeNm","장비 분류","*",true) //장비 분류 명
				.addColumnCustom("mtrilSeqno", "자재 일련번호","*",false) //자재코드
				.addColumnCustom("useAt", "사용 여부","*", true) //사용 여부
				.addColumnCustom("sdRegistAt", "기준 등록 여부 ","*", false); //사용 여부
				mtrilGrId = createAUIGrid(columnLayout.mtrilGrId ,mtrilGrId ,mtrilPros);

				//실린더NO 정보
				auigridCol(columnLayout.cylinderGrid);
				columnLayout.cylinderGrid
				.addColumnCustom("sanctnSeqno", "","*",false)
				.addColumnCustom("cylndrNo", "실린더 NO","*",true)//실린더 NO
				.addColumnCustom("bplcCode", "사업장 명","*",false)//실린더 NO
				.addColumnCustom("mtrqltValue", "CYLINDER_SIZE","*",false)//실린더 NO
				.addColumnCustom("cylndrNm", "CYLINDER_M NO","*",false)//실린더 NO
				.addColumnCustom("mtrilCylndrSeqno", " ","*",false)//실린더 일련번호
				cylinderGrid = createAUIGrid(columnLayout.cylinderGrid ,cylinderGrid ,NoPros);

				//아이템NO 정보
				auigridCol(columnLayout.itemNoGrid);
				columnLayout.itemNoGrid
				.addColumnCustom("mtrilItmSeqno", "제품 아이템 일렬번호", "*", false, true)
				.addColumnCustom("itmNo", "아이템 NO", "*", true, true) //아이템 NO
				.addValidator(["itmNo"], "ByteCheck", 10);
				itemNoGrid = createAUIGrid(columnLayout.itemNoGrid ,itemNoGrid ,itemPros);

				//시험항목 그리드를 제일 마지막에 생성하고 얘를 뱉어낸다. 그리고 나서 그리드이벤트 바인딩을한다.
				return $.when(
					customAjax({"url": "/wrk/getMasterUnitList.lims","data": {"unitSeCode": "SY10000001"}}), //단위
					customAjax({"url": "/com/getCmmnCode.lims", "data": {"upperCmmnCode" : "IM06"}}), //판정 형식
					customAjax({"url": "/com/getCmmnCode.lims", "data": {"upperCmmnCode" : "IM08"}}), //최소 단위
					customAjax({"url": "/com/getCmmnCode.lims", "data": {"upperCmmnCode" : "IM07"}}), //최대 단위
					customAjax({"url": "/com/getCmmnCode.lims", "data": {"upperCmmnCode" : "RS02"}})  //측정 기기
				).then(function(unit, jdgUnit, underUnit, upperUnit, mesureUnit, teamList) {
					var unitList = [{"value" : "", "key" : lang.C100000480}]; //선택
					unitList = unitList.concat(unit[0]);

					//시험항목 정보
					auigridCol(columnLayout.testGrid);
					columnLayout.testGrid
					.addColumn("expriemSeqno", "시험항목","*",false) //시험항목 키
					.addColumn("mtrilSeqno", "제품키","*",false) //제품키
					.addColumn("useYn", lang.C100000443,"*",false) //사용여부
					.addColumn("expriemCl", lang.C100000141,"10%",false) //검사항목 그룹명
					.addColumn("expriemNm", lang.C100000560,"10%",true,false) //시험항목 명
					.addColumn("sdspcNm", lang.C100000241,"10%",false,true) //기준명
					.addColumn("unitSeqno", lang.C100000268,"6%",true,true) //단위
					.addColumn("jdgmntFomCode", lang.C100000920,"6%",true,true) //판정기준
					.addColumn("textStdr", lang.C100000909,"6%",true,true); //텍스트기준
					columnLayout.testGrid
					.addColumn("fstRoot", lang.C100001006,"*",true) //내부 관리선
					.addChildColumn("fstRoot","lclValue", lang.C100000051,"*",true,true, null, null, null, null, conditionPros) //LCL
					.addChildColumn("fstRoot","lclValueSeCode", lang.C100000268,"*",true,true) //단위
					.addChildColumn("fstRoot","uclValue", lang.C100000094,"*",true,true, null, null, null, null, conditionPros) //UCL
					.addChildColumn("fstRoot","uclValueSeCode", lang.C100000268,"*",true,true);//단위
					columnLayout.testGrid
					.addColumn("secRoot", lang.C100001007,"*",false,false) //고객 관리선
					.addChildColumn("secRoot","lslValue", lang.C100000062,"*",true,true, null, null, null, null, conditionPros) //LSL
					.addChildColumn("secRoot","lslValueSeCode", lang.C100000268,"*",true,true) //단위
					.addChildColumn("secRoot","uslValue", lang.C100000097,"*",true,true, null, null, null, null, conditionPros) //USL
					.addChildColumn("secRoot","uslValueSeCode", lang.C100000268,"*",true,true); //단위
					columnLayout.testGrid
					.addColumnCustom("markCphr", lang.C100000940,"*",true,true,conditionPros)
					.addColumn("exprNumot", "시험횟수","*",false,false) //시험횟수
					.addColumn("eqpmnClCode", lang.C100000574,"8%",false,true) //실제 측정기기 분류
					.addColumn("frstAnalsAt", lang.C100000870,"4%",false,true) //초
					.addColumn("middleAnalsAt", lang.C100000836,"4%",false,true)//중
					.addColumn("lastAnalsAt", lang.C100000301,"4%",false,true) //말
					.addColumn("coaUpdtPosblAt", lang.C100000025,"8%",false,true) //COA수정가능여부
					.addColumn("coaUseAt", lang.C100000032,"8%",false,true) //COA사용여부
					.addColumn("emailSndngAt", lang.C100000670,"12%",false,false) //이메일 전송여부
					.addColumn("chrctrSndngAt", lang.C100000328,"12%",false,false) //문자 전송여부
					.addColumn("useAt", lang.C100000443,"*",true,true) //사용여부
					.addColumn("updtResn", lang.C100000527,"15%",true,true)  //수정사유

					//드랍다운리스트 렌더링
					columnLayout.testGrid
					.dropDownListRenderer(["unitSeqno"], unit[0], true)
					.dropDownListRenderer(["jdgmntFomCode"], jdgUnit[0], true)
					.dropDownListRenderer(["lclValueSeCode"], underUnit[0], true)
					.dropDownListRenderer(["uclValueSeCode"], upperUnit[0], true)
					.dropDownListRenderer(["lslValueSeCode"], underUnit[0], true)
					.dropDownListRenderer(["uslValueSeCode"], upperUnit[0], true)
					.dropDownListRenderer(["eqpmnClCode"], mesureUnit[0], true)
					.checkBoxRenderer(["emailSndngAt","chrctrSndngAt","useAt", "frstAnalsAt", "middleAnalsAt", "lastAnalsAt", "coaUpdtPosblAt","coaUseAt"], testGrid, {check: "Y", unCheck: "N"});
					testGrid = createAUIGrid(columnLayout.testGrid ,testGrid ,testPros);

					//그리드 사이즈
					gridResize([mtrilGrId,testGrid,cylinderGrid,itemNoGrid]);
					AUIGrid.setFixedColumnCount(testGrid, 5);
					AUIGrid.setProp(testGrid, { editable : true, enableDrag : false, enableMultipleDrag : false, enableDragByCellDrag : false, enableDrop : false } );
				});
			}


			function getMtrilList(tager) {
				getGridDataForm("/wrk/getMtrilList.lims", "frmSearch", mtrilGrId, function() {
					if (tager != null) {
						AUIGrid.setSelectionBlock(mtrilGrId, AUIGrid.rowIdToIndex(mtrilGrId, tager), AUIGrid.rowIdToIndex(mtrilGrId, tager), 0, 10);
					}
				});
			}


			function searchEvent() {
				var frmInputList = getEl("frmSearch").querySelectorAll("input[type=text]");
				for (var i = 0; i < frmInputList.length; i++) {
					frmInputList[i].addEventListener("keypress", function(e) {
						if (e.keyCode == 13) {
							getMtrilList();
						}
					});
				}
			}


			function buttonEvent() {
				//조회버튼
				getEl("btnMtrilSearch").addEventListener("click",function() {
					getMtrilList();
				});

				//실린더No 정보 삭제버튼
				getEl("btnDelCylinder").addEventListener("click",function() {
					var checkedItems = AUIGrid.getCheckedRowItemsAll(cylinderGrid);
					if (checkedItems.length == 0)
						return;

					var originalItems = checkedItems.filter(function(item) {
						return !!item.mtrilCylndrSeqno;
					});
					if (originalItems.length > 0) {
						if (confirm(lang.C100000461)) {
							var delParam = { "removedCylinderList" : checkedItems };
							var param = Object.assign($("#frmProductDtl").serializeObject(), delParam);
							customAjax({
								url: '/wrk/deletCylinder.lims',
								data: param,
								showLoading: true,
								successFunc: function (data) {
									if (data == 0) {
										err(lang.C100000597); //오류가 발생했습니다.
									} else {
										AUIGrid.removeCheckedRows(cylinderGrid); //체크된 행을 전부 삭제
										success(lang.C100000462); //삭제되었습니다.
									}
								}
							});
						}
					} else {
						AUIGrid.removeCheckedRows(cylinderGrid); //체크된 행을 전부 삭제
					}
				});

				//아이템No 정보 행추가버튼
				getEl("btnAddItemNo").addEventListener("click",function() {
					AUIGrid.addRow(itemNoGrid, {}, 'last');
				});

				//아이템No 정보 삭제버튼
				getEl("btnDelItemNo").addEventListener("click",function() {
					var checkedItems = AUIGrid.getCheckedRowItemsAll(itemNoGrid);
					if (checkedItems.length == 0)
						return;

					//행 삭제한 데이터 중 DB에 저장되어 있던 데이터가 포함된 경우에만 DB에 삭제처리 요청
					var originalItems = checkedItems.filter(function(item) {
						return !!item.mtrilItmSeqno;
					});
					if (originalItems.length > 0) {
						if (confirm(lang.C100000461)) {
							var delParam = { "removedItemNoList" : checkedItems };
							var param = Object.assign($("#frmProductDtl").serializeObject(), delParam);
							customAjax({
								url: '/wrk/deletItemNo.lims',
								data: param,
								showLoading: true,
								successFunc: function(data) {
									if (data == 0) {
										err(lang.C100000597); //오류가 발생했습니다.
									} else {
										success(lang.C100000462); //삭제되었습니다.
										AUIGrid.removeCheckedRows(itemNoGrid); //체크된 행을 전부 삭제
									}
								}
							});
						}
					} else {
						AUIGrid.removeCheckedRows(itemNoGrid); //체크된 행을 전부 삭제
					}
				});

				var clickEvent = function(el, func) {
					return el.addEventListener("click", func);
				}

				//제품정보 입력폼 버튼
				var btnDtl = document.querySelector(".btnDtl").querySelectorAll("button");
				for (var i = 0; i < btnDtl.length; i++) {
					switch (btnDtl[i].id) {
						case "btnNew": //신규
							clickEvent(btnDtl[i], function() {
								$("#btnDelete").hide();
								getEl("frmProductDtl").reset();
								ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', {'bestInspctInsttCode': "${UserMVo.bestInspctInsttCode}"}, true);
								$("#prductSeCode").change();
								AUIGrid.clearGridData(testGrid);
								AUIGrid.clearGridData(cylinderGrid);
								AUIGrid.clearGridData(itemNoGrid);
							});
							break;
						case "btnDelete": //삭제
							clickEvent(btnDtl[i], function () {
								if (!confirm(lang.C100000461)) //삭제하시겠습니까?
									return false;

								var param = $("#frmProductDtl").serializeObject();
								customAjax({
									url: "/wrk/delMtril.lims",
									data: param
								}).then(function (data) {
									if (data == 1) {
										success(lang.C100000462); //삭제되었습니다.
										getEl("btnNew").click();
										getEl("btnMtrilSearch").click();
									} else if (data == 0) {
										warn('${msg.C100001258}'); //SAP와 연동된 데이터는 삭제할 수 없습니다.\n사용 여부를 "사용 안함"으로 변경 후 저장하세요.
									}
								});
							});
							break;
						case "btnSave": //저장
							clickEvent(btnDtl[i], function () {
								if (!saveValidation("frmProductDtl"))
									return;

								var gridValid = gridRequire({
									requireColumns: ["itmNo"],
									gridId: itemNoGrid,
									list: AUIGrid.getGridData(itemNoGrid)
								});
								if (!gridValid)
									return;

								var gridParam = {
									"addedExpriemGrid": AUIGrid.getAddedRowItems(testGrid),
									"editedExpriemGrid": AUIGrid.getGridData(testGrid),
									"removedExpriemGrid": AUIGrid.getRemovedItems(testGrid),
									"addedCylinderList": AUIGrid.getAddedRowItems(cylinderGrid),
									"editedCylinderList": AUIGrid.getGridData(cylinderGrid),
									"addedItemNoList": AUIGrid.getAddedRowItems(itemNoGrid),
									"editedItemNoList": AUIGrid.getGridData(itemNoGrid)
								};
								var param = Object.assign($("#frmProductDtl").serializeObject(), gridParam);
								customAjax({
									url: "/wrk/putMtrilSave.lims",
									data: param
								}).then(function(cnt) {
									if (cnt == 0) {
										warn(lang.C100001008); //동일한 자재코드가 존재합니다.
									} else {
										success(lang.C100000762); //저장되었습니다.
										getEl("btnNew").click();
										getMtrilList(param.mtrilSeqno);
									}
									hideLoadingbar();
								});
							});
							break;
					}
				}

				//시험항목 삭제
				clickEvent(getEl("btnDelExpriem"), function(e) {
					var selectedItems = AUIGrid.getCheckedRowItemsAll(testGrid);
					if (selectedItems.length == 0) {
						alert(lang.C100000467); //삭제할 데이터가 없습니다.
						return;
					}

					var tempArr = new Array();
					for (var i = 0; i < selectedItems.length; i++) {
						var rows = AUIGrid.getRowIndexesByValue(testGrid, 'mtrilSdspcSeqno', selectedItems[i].mtrilSdspcSeqno);
						tempArr.push(rows);
					}

					//해당 그리드에서 선택된 인덱스를 삭제
					AUIGrid.removeRow(testGrid, tempArr);
					var delParam = { "removedExpriemGrid" : AUIGrid.getRemovedItems(testGrid) } //시험항목 그리드 삭제
					var param = Object.assign($("#frmProductDtl").serializeObject(), delParam);
					if (delParam.removedExpriemGrid.length != 0) {
						customAjax({
							url: '/wrk/deletExpriem.lims',
							data: param,
							showLoading: true,
							successFunc: function (data) {
								if (data == 0) {
									err(lang.C100000597); //저장에 실패하였습니다.
								} else {
									success(lang.C100000762); //저장되었습니다.
								}
							}
						});
					}
				});

				//시험항목 순서변경
				clickEvent(getEl("btnChangeOrdr"), function(e) {
					clickCntByChangeOrdr++;
					if (clickCntByChangeOrdr % 2 == 0) {
						alert(lang.C000000827); //시험항목 순서변경 가능상태 입니다.
						AUIGrid.setProp(testGrid, {
							editable: true,
							enableDrag: true,
							enableMultipleDrag: true,
							enableDragByCellDrag: true,
							enableDrop: true
						});
					} else {
						alert(lang.C000000828); //시험항목 순서변경 불가능상태 입니다.
						AUIGrid.setProp(testGrid, {
							editable: true,
							enableDrag: false,
							enableMultipleDrag: false,
							enableDragByCellDrag: false,
							enableDrop: false
						});
					}
				});

				getEl('prductSeCode').addEventListener("change", function() {
					if ($("#prductSeCode").val()=='SY20000005') {
						document.getElementById("eqpmnTr").style = "";
					} else {
						$("#eqpmnClCode").val('');
						$("#eqpmnTr").css("display",'none');
					}
				});
			}


			function gridEvent(){
				//제품목록 그리드 셀더블클릭 이벤트
				AUIGrid.bind(mtrilGrId, "cellDoubleClick", function(event) {
					$("#btnDelete").show();
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', {'bestInspctInsttCode' : event.item.bplcCode}, true)
					.then(function() {
						detailAutoSet({
							item: event.item,
							targetFormArr: ["frmProductDtl"],
							successFunc: function() {
								$("#prductSeCode").change();
								event.item.useAt == "N" ? getEl("useN").checked = true  : getEl("useY").checked = true;
							}
						});
					});

					//제품 시헝항목 매핑
					getGridDataParam("/wrk/getMtrilExpriemList.lims", { "mtrilSeqno": event.item.mtrilSeqno }, testGrid)
					.then(function() {
						var cylndrParam = event.item;
						customAjax({
							url: "/wrk/getcylndrList.lims",
							data: cylndrParam,
							successFunc: function(data) {
								if (!!data) {
									AUIGrid.setGridData(cylinderGrid,data);
								}
							}
						});
						var itemNoParam = event.item;
						customAjax({
							url: "/wrk/getitemNoList.lims",
							data: itemNoParam,
							successFunc: function(data) {
								if (!!data) {
									AUIGrid.setGridData(itemNoGrid, data);
								}
							}
						});
					});
				});

				//시험항목 그리드 셀수정시작 이벤트
				AUIGrid.bind(testGrid, "cellEditBegin", function(event) {
					//판정기준이 최대 최소값이 아닐때 1차/2차내용 입력 못하게 막음
					if (event.item.jdgmntFomCode == "IM06000004") {
						if (event.columnIndex >= 8 && event.columnIndex <= 17)
							return false;
					} else if (event.item.jdgmntFomCode == "IM06000003") {
						if (event.columnIndex >= 9 && event.columnIndex <= 17)
							return false;
					} else if(event.item.jdgmntFomCode == "IM06000001") {
						if (event.columnIndex == 8)
							return false;
					} else if (event.item.jdgmntFomCode == "IM06000002") {
						return true;
					}
				});

				//시험항목 그리드 셀수정종료 이벤트
				AUIGrid.bind(testGrid, "cellEditEnd", function(event){
					//판정기준 드랍다운리스트 셀 변경시 최대/최소가 아니면 셀초기화시킴
					if (event.item.jdgmntFomCode == "IM06000004") {
						for (var i = 8; i <= 17; i++) {
							AUIGrid.setCellValue(testGrid, event.rowIndex, i, "");
						}
					} else if (event.item.jdgmntFomCode == "IM06000003") {
						for (var i = 9; i <= 17; i++) {
							AUIGrid.setCellValue(testGrid, event.rowIndex, i, "");
						}
					} else if (event.item.jdgmntFomCode == "IM06000001") {
						AUIGrid.setCellValue(testGrid, event.rowIndex, 8, "");
					} else if (event.item.jdgmntFomCode == "IM06000002") {
						for (var i = 8; i <= 17; i++) {
							AUIGrid.setCellValue(testGrid, event.rowIndex, 8, "");
						}
					}
				});
			}


			function renderCombo() {
				ajaxJsonComboBox('/com/getCmmnCode.lims',"mtrilTyCode", {"upperCmmnCode" : "SY02", "deptCode" : "${UserMVo.deptCode}"}, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSeCodeSch",{ "upperCmmnCode" : "SY20", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
				ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSeCode",{ "upperCmmnCode" : "SY20", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
				ajaxJsonComboBox('/com/getCmmnCode.lims', "eqpmnClCode",{ "upperCmmnCode" : "RS02", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, '${UserMVo.deptCode}');
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, '${UserMVo.deptCode}');
			}


			function initPopup() {
				//시험항목목록 팝업
				dialogAddExpriemList("btnAddExpriem", {"inspctInsttCode" : "${UserMVo.bestInspctInsttCode}", "pageNm" : "Prduct"}, "Expriem",testGrid ,function(item){
					var mtrilSeqno = getEl("mtrilSeqno").value; //제품 키
					//팝업에서 넘어온애 배열에추가
					for (var i = 0; i < item.length; i++) {
						item[i]["mtrilSeqno"] = mtrilSeqno;
						item[i]["useAt"] = "Y";
						item[i]["coaOutptAt"] = "Y";
						item[i]["exprNumot"] = "1";
						item[i]["jdgmntFomCode"] = "IM06000001";
						item[i]["expriemCl"] = item[i].expriemCl;
						item[i]["expriemSeqno"] = item[i].expriemSeqno;
						item[i]["expriemNm"] = item[i].expriemNm;
						item[i]["lclValueSeCode"] = "IM08000001";
						item[i]["uclValueSeCode"] = "IM07000001";
						item[i]["lslValueSeCode"] = "IM08000001";
						item[i]["uslValueSeCode"] = "IM07000001";
						item[i]["unitSeqno"] = "";
						item[i]["eqpmnClCode"] = "";
						item[i]["replcMesureMhrlsClCode"] = "";
					}

					 var selectedItems = AUIGrid.getSelectedItems(testGrid)[0];
					 if (!!selectedItems) {
						 AUIGrid.addRow(testGrid, item, "selectionDown");
					 } else {
						 AUIGrid.addRow(testGrid, item, "last");
					 }
				}, null, true);

				//실린더목록 팝업
				dialogCylinder('btnAddCylinder', 'test', cylinderGrid);
			}


			//선택한 조합규칙에 맞는 자릿수 input hidden에 박아줌
			function putLotNoDigits(param, hidInputId) {
				var cmmnParam = { "cmmnCode" : param };
				customAjax({
					url: "/wrk/getLotNoDigits.lims",
					data: cmmnParam,
					successFunc: function(data) {
						if (!!data) {
							$("#" + hidInputId).val(data);
							calcToatalLotNoDigits();
						}
					}
				});
			}


			//컨디션 렌더러로 드랍다운 리스트를 사용할 때 셀에 값 세팅을 설정함
			function conditionRendererSetValue(value, list) {
				var retStr = value;
				for (var i = 0, len = list.length; i < len; i++) {
					if (list[i]["value"] == value) {
						retStr = list[i]["key"];
						break;
					}
				}
				return retStr;
			}
	
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
