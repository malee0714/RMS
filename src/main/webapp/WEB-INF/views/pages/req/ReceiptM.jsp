<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">접수</tiles:putAttribute>
	<tiles:putAttribute name="body">

		<div class="subContent">
			<div class="subCon1 mgT10">
				<h2><i class="fi-rr-apps"></i>${msg.C100000789}</h2> <!-- 접수 목록 -->
				<div class="btnWrap">
					<button type="button" id="btnDialReject" class="save" style="display: none">${msg.C100000343}</button> <!-- 반려 팝업 -->
					<button type="button" id="btnReject" class="save">${msg.C100000343}</button> <!-- 반려 -->
					<button type="button" id="btnReceipt" class="save">${msg.C100000788}</button> <!-- 접수 -->
					<button type="button" id="btnCancel" class="save">${msg.C100001360}</button> <!-- 접수 취소 -->
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
							<th>${msg.C100000986}</th> <!-- 의뢰 부서 -->
							<td>
								<select class="wd100p" id="reqestDeptCodeSch" name="reqestDeptCodeSch"></select>
							</td>
							<th>분석실</th> <!-- 분석실 -->
							<td>
								<select class="wd100p schClass" name="custlabSeqnoSch" id="custlabSeqnoSch"></select>
							</td>
							<th>${msg.C100000659}</th> <!-- 의뢰일자 -->
							<td>
								<input type="text" id="reqBeginDte" name="reqBeginDte" class="wd6p dateChk schClass" style="min-width:6em;">
								~
								<input type="text" id="reqEndDte" name="reqEndDte" class="wd6p dateChk schClass" style="min-width:6em;">
							</td>
							<th>${msg.C100000803}</th> <!-- 제조일자 -->
							<td>
								<input type="text" id="mnfBeginDte" name="mnfBeginDte" class="wd6p dateChk schClass" style="min-width:6em;">
								~
								<input type="text" id="mnfEndDte" name="mnfEndDte" class="wd6p dateChk schClass" style="min-width:6em;">
							</td>
						</tr>
						<tr>
							<th>${msg.C100000139}</th> <!-- 검사 유형 -->
							<td>
								<select class="wd100p" id="inspctTyCodeSch" name="inspctTyCodeSch">
									<option>${msg.C100000480}</option>
								</select>
							</td>
							<th>${msg.C100000657}</th> <!-- 의뢰번호-->
							<td>
								<input type="text" class="wd100p schClass" name="reqestNoSch" id="reqestNoSch" maxLength="13">
							</td>
							<th>시료정보</th> <!-- 시료정보 -->
							<td>
								<input type="text" class="wd100p schClass" name="sploreNmSch" id="sploreNmSch" maxLength="13">
							</td>
							<th>${msg.C100000846}</th> <!-- 진행 상황 -->
							<td>
								<select id="progrsSittnCodeSch" name="progrsSittnCodeSch" style="width: 99.5%;">
									<option>${msg.C100000480}</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="ReceiptGrid" class="mgT15" style="height:420px"></div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<style>
			.c-blue { background-color: #b6e7ff; }
		</style>

		<script>

			var lang = ${msg};
			var receiptGrid = "#ReceiptGrid";

			$(document).ready(function() {

				init();

				setCombo();

				buildGrid();

				buttonEvent();

			});


			function init() {

				dialogRtnSanctn({
					btnId: 'btnDialReject',
					parentGridId: receiptGrid,
					dialogId: 'reqRtnDialog',
					type: 'grid',
					functions: {
						callback: function(res) {
							// 체크된 행 아이템에 각각 반려사유를 세팅
							var chkedItems = AUIGrid.getCheckedRowItemsAll(receiptGrid).map(function(item) {
								item.rtnResn = res.rtnResn;
								return item;
							});

							customAjax({
								url: "/req/reqestReturn.lims",
								data: chkedItems,
								successFunc: function(data) {
									if (data == 1) {
										success(lang.C100000344); /* 반려되었습니다. */
										getRceptList();
									} else {
										err(lang.C100000597);
									}
								}
							});
						}
					}
				});

				datePickerCalendar(["mnfBeginDte","mnfEndDte"], true, ["DD",-7], ["DD",0]);
				datePickerCalendar(["reqBeginDte","reqEndDte"], false);
			}


			function setCombo() {
				ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", { upperCmmnCode : "SY07" }, true, "${msg.C100000480}");
				ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", { upperCmmnCode : "IM03" }, true, null, "IM03000002");
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{ bestInspctInsttCode : ${UserMVo.bplcCode} }, true);
				ajaxJsonComboBox("/com/getCustlabCombo.lims",'custlabSeqnoSch',{ bplcCode : ${UserMVo.bplcCode} }, true);
			}


			function buildGrid() {

				var col = [];

				auigridCol(col);
				col
				.addColumnCustom('reqestSeqno','${msg.C000000724}',null,false)        // 의뢰일렬번호
				.addColumnCustom('bplcCode','${msg.C100000432}','*',false,false)      // 사업장
				.addColumnCustom('reqestDeptNm','${msg.C100000666}','*',true,false)   // 의뢰팀
				.addColumnCustom('clientNm','${msg.C100000665}','*',true,false)       // 의뢰자
				.addColumnCustom('reqestDte','${msg.C100000659}','*',true,false)      // 의뢰일자
				.addColumnCustom('reqestNo','${msg.C100000657}','*',true,false)       // 의뢰번호
				.addColumnCustom('inspctTyCode','${msg.C100000139}','*',false,false)  // 검사유형
				.addColumnCustom('inspctTyCodeNm','${msg.C100000139}','*',true,false) // 검사유형명
				.addColumnCustom('custlabNm','분석실','*',true,false)              	  // 자재코드
				.addColumnCustom('mtrilCode','${msg.C100000725}','*',true,false)      // 자재코드
				.addColumnCustom('mtrilNm','${msg.C100000717}','*',true,false)        // 자재명
				.addColumnCustom('mnfcturDte','${msg.C100000803}','*',true,false)     // 제조일자
				.addColumnCustom('sploreNm','시료명','*',true,false)              	  // 시료명
				.addColumnCustom('elctcQy','충전량','*',true,false)                    // 충전량
				.addColumnCustom('elctcCn','충전정보','*',true,false)                  // 충전정보
				.addColumnCustom('rcepterNm','${msg.C100000794}','*',true,false)      // 접수자
				.addColumnCustom('rceptDt','${msg.C100000791}','*',true,false)        // 접수일자
				.addColumnCustom('progrsSittnCodeNm','${msg.C100000846}','*',true,false)        // 진행상황

				var cusProp = {
					editable : false,
					selectionMode : "multipleCells",
					showRowCheckColumn : true,
					showRowAllCheckBox : true,
					rowStyleFunction : function(rowIndex, item) {
						if (item.sanctnProgrsSittnCode == "CM01000002") {
							return "c-blue";
						}

						return "";
					}
				};

				createAUIGrid(col, receiptGrid, cusProp);

				gridResize([receiptGrid]);
			}


			function buttonEvent() {

				document.getElementById('btnSearch').addEventListener("click", function() {
					getRceptList();
				});

				document.getElementById('btnReceipt').addEventListener("click", function(e) {
					validChk(e);
				});

				document.getElementById('btnCancel').addEventListener("click", function(e) {
					validChk(e);
				});

				document.getElementById('btnReject').addEventListener("click", function(e) {
					validChk(e);
				});
			}


			function validChk(event) {
				var validCnt = 0;
				var checkedItems = AUIGrid.getCheckedRowItemsAll(receiptGrid);
				var progrsSittnCode = "";
				var btnId = event.target.id;

				if (checkedItems.length == 0) {
					warn(lang.C100001363); /* 선택된 의뢰가 없습니다. */
					return;
				}

				if (btnId == "btnCancel")
					progrsSittnCode = "IM03000003"; // 분석중
				else
					progrsSittnCode = "IM03000002"; // 접수대기

				for (var i = 0; i < checkedItems.length; i++) {
					if (checkedItems[i].progrsSittnCode != progrsSittnCode) {
						validCnt++;
						break;
					}
				}

				if (progrsSittnCode == "IM03000002") {
					if (validCnt > 0) {
						warn(lang.C100001295); /* 접수대기 상태가 아닌 의뢰가 포함되어 있습니다. 다시 선택해주세요. */
					} else {
						if (btnId == "btnReceipt")
							reqestMultiReceipt(checkedItems);
						else
							document.getElementById('btnDialReject').click(); // 반려팝업 오픈
					}
				} else {
					if (validCnt > 0)
						warn(lang.C100001361); /* 진행상황이 분석중인 의뢰만 접수취소가 가능합니다. */
					else
						cancelReceipt(checkedItems);
				}
			}


			function cancelReceipt(items) {
				customAjax({
					url: "/req/cancelReceipt.lims",
					data: items,
					successFunc: function(data) {
						if (data == 1) {
							success(lang.C100001362); /* 접수 취소되었습니다. */
							getRceptList();
						} else {
							err(lang.C100000597);
						}
					}
				});
			}


			function reqestMultiReceipt(items) {
				customAjax({
					url: "/req/insMultiRecept.lims",
					data: items,
					successFunc: function (data) {
						if (data == 1) {
							success(lang.C100000662); /* 의뢰가 접수되었습니다. */
							getRceptList();
						} else {
							err(lang.C100000597);
						}
					}
				});
			}


			function getRceptList() {
				getGridDataForm("/req/getRequestRceptList.lims", "searchFrm", receiptGrid);
			}


			function doSearch() {
				getRceptList();
			}

		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
