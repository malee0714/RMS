<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="lims.sys.vo.UserMVo"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">

		<div class="subContent" id="middle_wrap">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100001102}</h2> <!-- 그룹코드 목록 -->
					<div class="btnWrap">
						<button  id="addrowBestGroupCode" class="save" style="display:<c:if test = "${UserMVo.authorSeCode != 'SY09000001'}">none</c:if>">${msg.C100001277}</button> <!-- 최상위코드 추가 -->
						<button  id="addrowDetailCode" class="search">${msg.C100001278}</button> <!-- 하위코드 추가 -->
						<button  id="removeRowGroupCode" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
						<button  id="changeSortOdr" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 정렬 순서변경 -->
						<button  id="saveSortOrdr" class="save">${msg.C100001256}</button> <!-- 정렬순서 저장 -->
						<button  id="saveGroupCode" class="save">${msg.C100000760}</button> <!-- 저장 -->
						<button  id="selectGroupCode" class="search" >${msg.C100000767}</button> <!-- 조회 -->
					</div>
				<form id="SearchForm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:10%"></col>
							<col style="width:15%"></col>
							<col style="width:10%"></col>
							<col style="width:15%"></col>
							<col style="width:10%"></col>
							<col style="width:40%"></col>
						</colgroup>
						<tr>
							<th >${msg.C100000221}</th> <!-- 그룹 코드 -->
							<td ><input type="text" id="searchCode" name="searchCode" class="schClass"></td>
							<th >${msg.C100000222}</th> <!-- 그룹 코드명 -->
							<td ><input type="text" id="searchNm" name="searchNm" class="schClass"></td>
							<th >${msg.C100000443}</th> <!-- 사용여부 -->
							<td ><input name="schUseAt" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
							<input name="schUseAt" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
							<input name="schUseAt" value="N" type="radio">${msg.C100000449}</td> <!-- 사용안함 -->
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="CmmnCodeGrid" style="height: 440px;"></div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<script>

			var groupGridID = "CmmnCodeGrid";
			var authorCode = "${UserMVo.authorSeCode}";
			var ordrChangeBtnClickCnt = 0;


			$(document).ready(function() {

				setGrid();

				auiGridEvent();

				setButtonEvent();

			});


			function setGrid() {

				var col = [];

				var requireProp = {
					style: "my-require-style",
					headerTooltip: {
						show: true,
						tooltipHtml: '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
					}
				};

				var treeProp = {
					displayTreeOpen: true,
					flat2tree: true,
					treeIdField: "cmmnCode",
					treeIdRefField: "upperCmmnCode",
					selectionMode: "multipleCells",
					enableDrag: false,
					enableDragByCellDrag: true,
					enableDrop: true
				};

				auigridCol(col);

				col
				.addColumnCustom("cmmnCodeNm", "${msg.C100000222}", "20%", true, true, requireProp)
				.addColumnCustom("cmmnCode", "${msg.C100000221}", "8%", true, true, requireProp)
				.addColumnCustom("upperCmmnCode", "${msg.C100000221}", "*", false, false)
				.addColumnCustom("cmmnCodeRm", "${msg.C100000904}", "10%", true, true)
				.addColumnCustom("updtPosblAt", "${msg.C100001104}", "5%", true, true, requireProp)
				.addColumnCustom("useAt", "${msg.C100000443}", "5%", true, true, requireProp)
				.addColumnCustom("sortOrdr", "${msg.C100000797}", "5%", true, true, requireProp)
				.addColumnCustom("tmprField1Nm", "${msg.C100000689}1", "*", true, true)
				.addColumnCustom("tmprField2Nm", "${msg.C100000689}2", "*", true, true)
				.addColumnCustom("tmprField3Nm", "${msg.C100000689}3", "*", true, true)
				.addColumnCustom("tmprField4Nm", "${msg.C100000689}4", "*", true, true)
				.addColumnCustom("tmprField5Nm", "${msg.C100000689}5", "*", true, true)
				.addColumnCustom("lastChangerId", "${msg.C000000834}", "*", false)
				.addColumnCustom("lastChangeDt", "${msg.C000000232}", "*", false)
				.addColumnCustom("gbnCrud", "gbnCrud", "*", false)
				.addColumnCustom("ordrUpdAt", "정렬순서 수정여부", "*", false)
				.dropDownListRenderer(["updtPosblAt"], ["Y", "N"])
				.dropDownListRenderer(["useAt"], ["Y", "N"])
				.inputEditRenderer(["cmmnCode", "cmmnCodeNm", "cmmnCodeRm", "tmprField1Nm"])
				.addValidator(["cmmnCode", "cmmnCodeNm", "sortOrdr"], "NotEmpty")
				.addValidator(["cmmnCode"], "UpperCase")
				.addValidator(["cmmnCode"], "Length", 4)
				.addValidator(["sortOrdr"], "OnlyNum", null, "${msg.C100001306}");

				groupGridID = createAUIGrid(col, groupGridID, treeProp);
			}


			function auiGridEvent() {

				AUIGrid.bind(groupGridID, "cellEditBegin", function(event) {
					var sCrud = event.item.gbnCrud;
					var field = event.dataField;
					var updtPosblAt = event.item.updtPosblAt;

					// 기존그룹코드의 코드값은 수정불가
					if (field == "cmmnCode" && sCrud != "C") {
						return false;
					}

					if (field == "cmmnCode" && !!event.item.upperCmmnCode) {
						warn("${msg.C100001305}"); /* 하위코드의 코드값은 별도로 입력할 수 없습니다. */
						return false;
					}

					// 기존 그룹코드의 수정가능여부 'N'? 시스템관리자 권한 외 수정불가
					if (updtPosblAt == "N" && sCrud == null && authorCode != "SY09000001" ) {
						return false;
					}

					return true;
				});


				AUIGrid.bind(groupGridID, "cellEditEnd", function (event) {

					var item = event.item;
					var field = event.dataField;

					// 그룹코드 중복여부 체크
					if (item.gbnCrud == "C" && field == "cmmnCode" && !item.upperCmmnCode) {
						var addedRowItems = { "cmmnCode": item.cmmnCode };
						if (addedRowItems != null) {
							customAjax({
								"url": "/sys/confirmCmmnCodeMGbnList.lims",
								"data": addedRowItems,
								"successFunc": function (data) {
									if (data > 0) {
										warn("${msg.C100000838}"); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
										AUIGrid.setCellValue(groupGridID, event.rowIndex, "cmmnCode", "");
									}
								}
							});
						}
					}

					// 새로 추가한 아이템은 gbnCrud값 변경 불필요
					if (item.gbnCrud != "C")
						AUIGrid.updateRow(groupGridID, { gbnCrud: "U" }, "selectedIndex");

					// 정렬순서 변경 시, ordrUpdAt 값 업데이트
					if (field == "sortOrdr")
						AUIGrid.updateRow(groupGridID, { ordrUpdAt: "Y" }, "selectedIndex");

					// 하위코드는 최상위코드의 수정가능여부, 사용여부 값을 따라가도록 함
					if (field == "updtPosblAt" || field == "useAt") {
						var selectedRowId = AUIGrid.getSelectedItems(groupGridID)[0].rowIdValue;
						var descendants = AUIGrid.getDescendantsByRowId(groupGridID, selectedRowId); // 상위코드의 모든 하위코드를 가져옴

						if (descendants.length > 0) {
							for (var i = 0; i < descendants.length; i++) {
								var rowIndexArr = AUIGrid.getRowIndexesByValue(groupGridID, "upperCmmnCode", item.cmmnCode);

								if (field == "updtPosblAt") {
									if (descendants[i].gbnCrud == "C")
										AUIGrid.updateRow(groupGridID, { updtPosblAt: item.updtPosblAt }, rowIndexArr[i]);
									else
										AUIGrid.updateRow(groupGridID, { updtPosblAt: item.updtPosblAt, gbnCrud: "U" }, rowIndexArr[i]);
								} else {
									if (descendants[i].gbnCrud == "C")
										AUIGrid.updateRow(groupGridID, { useAt: item.useAt }, rowIndexArr[i]);
									else
										AUIGrid.updateRow(groupGridID, { useAt: item.useAt, gbnCrud: "U" }, rowIndexArr[i]);
								}
							}
						}
					}
				});


				// 드래그앤드랍 이벤트 종료 직전에 발생
				AUIGrid.bind(groupGridID, "dropEndBefore", function (event) {

					var selectedItem = AUIGrid.getSelectedItems(groupGridID);
					if (selectedItem.length > 0 && selectedItem[0].item.gbnCrud == "C") {
						warn("${msg.C100001281}"); /* 추가한 코드를 등록하고 다시 시도해주세요. */
						return false;
					}

					var fromDragItem = AUIGrid.getItemByRowIndex(groupGridID, event.fromRowIndex);
					var toDragUpItem = AUIGrid.getItemByRowIndex(groupGridID, event.toRowIndex);
					var toDragDownItem = AUIGrid.getItemByRowIndex(groupGridID, event.toRowIndex-1);

					/*
					*  최상위코드를 하위코드로 순서변경하는 것을 방지
					*  event.direction == false ? dragUp : dragDown
					* */
					if (event.direction == false) {
						if (!fromDragItem.upperCmmnCode && !!toDragUpItem.upperCmmnCode) {
							warn("${msg.C100001283}"); /* 최상위그룹코드는 하위그룹코드로 변경할 수 없습니다. */
							return false;
						}

					} else {
						if (!fromDragItem.upperCmmnCode && !!toDragUpItem.upperCmmnCode) {
							warn("${msg.C100001283}"); /* 최상위그룹코드는 하위그룹코드로 변경할 수 없습니다. */
							return false;
						}
					}

					// 하위코드 순서변경은 직속상위코드 내에서만 가능하게 함
					if (!!fromDragItem.upperCmmnCode) {
						if (event.direction == false) {
							if (fromDragItem.upperCmmnCode != toDragUpItem.upperCmmnCode) {
								warn("${msg.C100001284}"); /* 직속 상위그룹코드 내에서만 순서변경이 가능합니다. */
								return false;
							}
						} else {
							if (fromDragItem.upperCmmnCode != toDragDownItem.upperCmmnCode) {
								warn("${msg.C100001284}"); /* 직속 상위그룹코드 내에서만 순서변경이 가능합니다. */
								return false;
							}
						}
					}

					return true;
				});


				// 드래그앤드랍 이벤트가 종료되는 시점에 발생
				AUIGrid.bind(groupGridID, "dropEnd", function (event) {
					AUIGrid.updateRow(groupGridID, { ordrUpdAt : "Y" }, event.toRowIndex);
				});
			}


			function setButtonEvent() {

				$('#selectGroupCode').click(function () {
					getGroupCodeList();
				});

				$('#addrowBestGroupCode').click(function (e) {
					if (AUIGrid.getGridData(groupGridID).length > 0)
						addTreeRow(e.target.id);
				});

				$('#addrowDetailCode').click(function (e) {

					if (AUIGrid.getGridData(groupGridID).length > 0) {
						var selected = AUIGrid.getSelectedItems(groupGridID)[0].item;
						if (!!selected) {
							if (authorCode != "SY09000001") {
								var upperUpdtPosblAt = selected.updtPosblAt;
								if (upperUpdtPosblAt == "N") {
									warn("${msg.C100001105}")  /* 수정 권한이 없습니다. 관리자에게 문의하세요. */
									return;
								}
							}

							if (!!selected.upperCmmnCode) {
								warn('폴더 모양 아이콘을 선택 후 "하위코드 추가" 버튼을 클릭하세요.');  /* 폴더 모양 아이콘을 선택 후 "하위코드 추가" 버튼을 클릭하세요. */
								return;
							}
							addTreeRow(e.target.id);

						} else {
							warn("${msg.C100001280}");  /* 하위로 추가할 상위그룹코드를 선택해주세요. */
						}
					}
				});

				$('#removeRowGroupCode').click(function () {
					var gbnCrud = AUIGrid.getSelectedItems(groupGridID)[0].item.gbnCrud;
					if (gbnCrud != "C") {
						warn('${msg.C100000444}'); /* 사용여부를 N으로 저장해주세요 */
						return;
					}

					AUIGrid.removeRow(groupGridID, "selectedIndex");
				});

				$('#changeSortOdr').click(function () {

					var addedItems = AUIGrid.getAddedRowItems(groupGridID);
					if (addedItems.length > 0) {
						for (var i = 0; i < addedItems.length; i++) {
							if (!addedItems[i].cmmnCodeNm || !addedItems[i].cmmnCode) {
								warn("${msg.C100001281}"); /* 추가한 코드를 등록하고 다시 시도해주세요. */
								return;
							}
						}
					}

					ordrChangeBtnClickCnt++;
					if (ordrChangeBtnClickCnt % 2 == 0) {
						alert("${msg.C100000549}"); /* 순서변경 불가능상태 입니다. */
						AUIGrid.setProp(groupGridID, {
							enableDrag: false,
							enableDragByCellDrag: true,
							enableDrop: true
						});

					} else {
						alert("${msg.C100000548}"); /* 순서변경 가능상태 입니다. */
						AUIGrid.setProp(groupGridID, {
							enableDrag: true,
							enableDragByCellDrag: true,
							enableDrop: true
						});
					}
				});

				$('#saveSortOrdr').click(function (e) {
					groupSaveEvntValid(e.target.id);
				});

				$('#saveGroupCode').click(function (e) {
					groupSaveEvntValid(e.target.id);
				});
			}


			function getGroupCodeList(rowVal) {
				getGridDataForm("/sys/getCmmnCodeMTreeList.lims", "SearchForm", groupGridID, function() {
					if (!!rowVal)
						gridSelectRow(groupGridID, "cmmnCodeNm", rowVal);
				});
			}


			function addTreeRow(btnId) {

				var item = {};
				item.cmmnCode = "",
				item.updtPosblAt = "N",
				item.useAt = "Y",
				item.sortOrdr = 1,
				item.gbnCrud = "C",
				item.upperCmmnCode = "";

				// 최상위코드 추가
				if (btnId == "addrowBestGroupCode") {
					AUIGrid.addRow(groupGridID, item, "first");

				// 하위코드 추가
				} else {
					var selectedUpperItem = AUIGrid.getSelectedItems(groupGridID)[0].item;
					if (selectedUpperItem.cmmnCode == null || selectedUpperItem.cmmnCode == "") {
						warn("${msg.C100001282}"); /* 상위그룹코드의 그룹코드를 입력한 후 추가해주세요. */
						return;
					}

					// 선택행의 코드값을 추가할 자식코드의 상위코드값으로 세팅
					item.upperCmmnCode = selectedUpperItem.cmmnCode;
					// 수정가능여부 값은 부모코드와 동일하게 세팅
					item.updtPosblAt = selectedUpperItem.updtPosblAt;

					// 선택된 상위코드에 속한 하위코드 중 최대인덱스값을 가진 row의 정렬순서값에 +1한 값을 세팅
					var lowerRows = AUIGrid.getRowIndexesByValue(groupGridID, "upperCmmnCode", selectedUpperItem.cmmnCode);
					if (lowerRows.length > 0) {
						var maxIndex = lowerRows[lowerRows.length-1];
						var maxIndexItem = AUIGrid.getItemByRowIndex(groupGridID, maxIndex);
						item.sortOrdr = maxIndexItem.sortOrdr+1;
					}

					// 선택행의 자식코드로 행추가
					var parentRowId = selectedUpperItem._$uid;
					AUIGrid.addTreeRow(groupGridID, item, parentRowId, "last");
				}
			}


			function groupSaveEvntValid(btnId) {

				var gridData = AUIGrid.getGridData(groupGridID);
				var selected = AUIGrid.getSelectedItems(groupGridID);
				if (gridData.length == 0 || !selected) {
					return;
				}

				/* btnId 값으로 호출되는 메서드 구분 */
				if (btnId == "saveGroupCode") {
					var rows = AUIGrid.getRowsByValue(groupGridID, "gbnCrud", ["C", "U"]);
					if (rows.length > 0) {
						saveValidation(rows);
					}

				} else if (btnId == "saveSortOrdr") {
					var rows = AUIGrid.getRowsByValue(groupGridID, "ordrUpdAt", "Y");
					if (rows.length > 0) {
						saveOrdr();
					}
				}
			}


			function saveValidation(list) {

				var item;
				var invalid = false;
				var invalidRowIndex = -1;
				var colIndex;

				for (var i = 0; i < list.length; i++) {
					item = list[i];

					if (!item.upperCmmnCode) {
						if (typeof item["cmmnCodeNm"] == "undefined" || String(item["cmmnCodeNm"]).trim() == "") {
							invalidRowIndex = i;
							invalid = true;
							colIndex = AUIGrid.getColumnIndexByDataField(groupGridID, "cmmnCodeNm");
							break;
						} else if (typeof item["cmmnCode"] == "undefined" || String(item["cmmnCode"]).trim() == "") {
							invalidRowIndex = i;
							invalid = true;
							colIndex = AUIGrid.getColumnIndexByDataField(groupGridID, "cmmnCode");
							break;
						}
					}
				}

				if (invalid) {
					warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
					AUIGrid.setSelectionByIndex(groupGridID, invalidRowIndex, colIndex);
					return;
				}

				saveGroupCode(list);
			}


			function saveGroupCode(list) {
				customAjax({
					"url": "/sys/saveCmmnCodeM.lims",
					"data": list,
					"successFunc": function(data) {
						if (data > 0) {
							success("${msg.C100000765}"); /* 저장 되었습니다. */
							getGroupCodeList(list[0].cmmnCodeNm);

							ordrChangeBtnClickCnt = 0;
						} else {
							err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
						}
					}
				});
			}


			function saveOrdr() {
				customAjax({
					"url": "/sys/sortCmmnCodeOrdr.lims",
					"data": AUIGrid.getGridData(groupGridID),
					"successFunc": function (data) {
						if (data > 0) {
							success("${msg.C100000765}"); /* 저장 되었습니다. */
							getGroupCodeList();

							ordrChangeBtnClickCnt = 0;
						} else {
							err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
						}
					}
				});
			}


			function doSearch(e) {
				getGroupCodeList();
			}


		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
