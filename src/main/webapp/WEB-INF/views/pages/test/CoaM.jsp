<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">COA</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>COA 발행목록</h2> <!-- COA 발행목록 -->
				<div class="btnWrap">
					<button type="button" id="btnSearch" class="search btn3">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchForm">
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
							<th>의뢰번호</th> <!-- 의뢰번호 -->
							<td><input type="text" class="wd100p schClass" name="reqestNoSch" id="reqestNoSch" maxLength="200"/></td>

							<th>Lot No.</th> <!-- Lot No. -->
							<td><input type="text" class="wd100p schClass" name="lotNoSch" id="lotNoSch" maxLength="20"></td>

							<th>출하일자</th> <!-- 출하일자 -->
							<td>
								<input type="text" id="shipmntBeginDte" name="shipmntBeginDte" class="dateChk wd6p" style="min-width: 6em">~
								<input type="text" id="shipmntEndDte" name="shipmntEndDte" class="dateChk wd6p" style="min-width: 6em">
							</td>

							<th>업체</th> <!-- 업체 -->
							<td><input type="text" class="wd100p schClass" name="entrpsSch" id="entrpsSch"></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2"> <!-- COA 발행목록 그리드 -->
				<div id="coaReportGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>

			<div style="display: flex">
				<div class="subCon1 wd30p mgT17">
					<form id="coaForm" autocomplete="off">
						<h2><i class="fi-rr-apps"></i>COA 발행 상세 정보</h2> <!-- COA 발행 상세 정보 -->
						<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" style="height: 255px">
							<colgroup>
								<col style="width:10%"></col>
								<col style="width:20%"></col>
							</colgroup>
							<tr>
								<th class="necessary">업체</th> <!-- 업체 -->
								<td>
									<input type="text" id="entrpsNm" name="entrpsNm" class="wd75p fL"/>
									<input type="text" id="entrpsSeqno" name="entrpsSeqno" class="wd60p fL" style="display: none" required/>
									<button id="btnEntrpsSearch" type="button" class="inTableBtn inputBtn fL"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
									<button type="button" id = "btnEntrpsReset" class="inTableBtn inputBtn fL btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
								</td>
							</tr>
							<tr>
								<th class="necessary">업체별 양식</th> <!-- 업체별 양식 -->
								<td>
									<select id="printngSeqno" name="printngSeqno" class="wd100p" style="min-width:10em" required></select>
									<input type="text" id="mtrilSeqno" name="mtrilSeqno" class="wd60p fL" style="display: none"/>
									<input type="text" id="ctmmnyMtrilCode" name="ctmmnyMtrilCode" class="wd60p fL" style="display: none"/>
								</td>
							</tr>
							<tr>
								<th>${msg.C100000899}</th><!-- 출하일자 -->
								<td><input type="text" id="shipmntDte" name="shipmntDte" class="wd100p dateChk" maxlength="10" style="min-width:10em"></td>
							</tr>
							<tr>
								<th>평균 적용</th> <!-- 평균 적용 -->
								<td>
									<label><input type="radio" id="avrgApp" name="avrgApplcAt" value="Y" style="margin: 5px">Y</label> <!-- 적용 -->
									<label><input type="radio" id="avrgNotApp" name="avrgApplcAt" value="N" style="margin: 5px" checked>N</label> <!-- 미적용 -->
								</td>
							</tr>
							<tr>
								<th>${msg.C100000037}</th> <!-- DL 적용 -->
								<td>
									<label><input type="radio" id="dlApp" name="detectLimitApplcAt" value="Y" style="margin: 5px">${msg.C100000772}</label> <!-- 적용 -->
									<label><input type="radio" id="dlNotApp" name="detectLimitApplcAt" value="N" style="margin: 5px" checked>${msg.C100000332}</label> <!-- 미적용 -->
								</td>
							</tr>
							<tr>
								<th>${msg.C100001183}</th> <!-- 확장자 -->
								<td>
									<label><input type="radio" id="excelChk" name="extAt" value="SY17000001" style="margin: 5px" checked>${msg.C100001184}</label> <!-- EXCEL -->
									<label><input type="radio" id="csvChk" name="extAt" value="SY17000002" style="margin: 5px">${msg.C100001185}</label> <!-- CSV -->
								</td>
							</tr>
						</table>
					</form>
				</div>

				<div class="wd70p mgT13 mgL17">
					<div class="subCon1">
						<div class="btnWrap" style="float: right;">
							<button type="button" id="btnNew" class="btn4" style="margin-right: 5px">${msg.C100000569}</button> <!-- 신규 -->
							<button type="button" id="btnCreateExcelSample" class="save" style="margin-right: 5px">Excel Sample 출력</button> <!-- Excel Sample 출력 -->
							<button type="button" id="btnPreviewDownload" class="save" style="margin-right: 5px">${msg.C100000021}</button> <!-- COA 미리보기 -->
							<button type="button" id="addRowBtn" class="btn5" style="margin-right: 5px"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
							<button type="button" id="btnSave" class="save">${msg.C100000024}</button> <!-- COA 생성 -->
						</div>
					</div>
					<div class="subCon2"> <!-- 상위 lot 그리드 -->
						<div id="upperLotGrid" class="mgT29 grid" style="width: 100%; height: 255px;"></div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.coa-row-style {
				background : #FEDBDE;
			}
			.coaend-row-style {
				background : #ffae5b;
			}
		</style>

		<script type="text/javascript">

			var coaReportGrid = 'coaReportGrid';
			var upperLotGrid = 'upperLotGrid';

			var lang = ${msg};
			var sessionObj = {
				bplcCode : "${UserMVo.bestInspctInsttCode}",
				deptCode : "${UserMVo.deptCode}"
			};

			var searchForm = document.getElementById('searchForm').id;
			var inputForm = document.getElementById('coaForm').id;
			var getEl = function(id) {
				return document.getElementById(id);
			}
			var getVal = function(id) {
				return document.getElementById(id).value;
			}
			var setVal = function(id, val) {
				document.getElementById(id).value = val;
			}


			$(document).ready(function() {
				init();
				buttonEvent();
				setCoaReportGrid();
				setUpperLotGrid();
				auiGridEvent();
			});


			function init() {
				comboReset('printngSeqno', true);
				datePickerCalendar(["shipmntDte"], false, ["DD",0], ["DD",0]);
				datePickerCalendar(['stReqestDteSch','enReqestDteSch']);
				datePickerCalendar(['stMnfcturDteSch','enMnfcturDteSch'],true,['DD',-7]);
				datePickerCalendar(["shipmntBeginDte", "shipmntEndDte"], true, ["YY",-1], ["DD",0]);

				dialogShipmnt('btnEntrpsSeqno', { girdId: "coaReportGrid" }, 'shipmntDialog', function(data) {
					setVal('po', data.ebeln);
					setVal('vhcleNo', data.licenseNumber);
				}, function() {
					if (!getVal('printngSeqno')) {
						alert(lang.C100001068); //업체를 선택해주세요.
						return;
					}
				});

				dialogEntrps('btnEntrpsSearch', null, 'coaPrduct', function(item) {
					if (item) {
						AUIGrid.clearGridData(upperLotGrid);
						setVal('entrpsSeqno', item.entrpsSeqno);
						setVal('entrpsNm', item.entrpsNm);

						//업체별양식 콤보 조회
						var param = { entrpsSeqno : item.entrpsSeqno };
						ajaxJsonComboBox("/test/getEntrpsPrintCombo.lims", "printngSeqno", param, true);
					}
				});

				coaPrductdialog('addRowBtn', "coaPrductdialog", "upperLotGrid", sessionObj, function(items) {
					if (items) {
						for (var i = 0; i < items.length; i++) {
							items[i].reqestSeqno = items[i].reqestSeqno;
						}

						var param = { list : items };
						customAjax({
							url: "/test/getReqUpperLotList.lims",
							data: param,
							showLoading: false
						}).then(function(data) {
							//기존 lot는 그대로 놔두고 추가할 lot만 addRow()로 추가하면 데이터가 계층형으로 보여지지 않음
							//그래서 기존 lot리스트 끝에 추가한 lot들을 붙여주는 방식으로 처리.
							var setData;
							var orgGridData = AUIGrid.getGridData(upperLotGrid);
							if (orgGridData.length > 0) {
								for (var i = 0; i < data.length; i++) {
									orgGridData.push(data[i]);
								}
								setData = orgGridData;
							} else {
								setData = data;
							}

							AUIGrid.setGridData(upperLotGrid, setData);
							AUIGrid.setAllCheckedRows(upperLotGrid, true);
							AUIGrid.collapseAll(upperLotGrid);
						});
					}

				}, function() {
					if (!getVal('entrpsSeqno')) {
						alert('업체를 선택해주세요.');
						return false;
					}
					if (!getVal('printngSeqno')) {
						alert('업체별 양식을 선택해주세요.');
						return false;
					}
				});
			}


			//COA 발행목록 그리드
			function setCoaReportGrid() {
				var col = [];
				auigridCol(col);
				col.addColumn("entrpsNm", "업체", "*", true) //업체
				.addColumn("coaSeqno", "coa일련번호", "*", false) //COA일련번호
				.addColumn("entrpsSeqno", "업체일련번호", "*", false) //업체일련번호
				.addColumn("shipmntDte", "출하 일자", "*", true) //출하일자
				.addColumn("userNm", "발행자", "*", true) //발행자
				.addColumn("detectLimitApplcAt", "DL 적용여부", "*", true) //DL적용여부
				.addColumn("extension", "확장자", "*", true) //확장자
				.addColumn("upperCnt", "건수", "*", true) //건수
				.addColumn("lastChangeDt", "발행 일자", "*", true) //발행일자
				.addColumn("printCoaReport", "성적서 출력", "*", true)
				.addColumn("printngSeqno", "재출력", "*", true)

				//성적서 출력(mrd)
				.buttonRenderer(['printCoaReport'], function(dataFields, func, editable, labelText, props) {
					var item = AUIGrid.getSelectedItems(coaReportGrid)[0].item;
					if (!item)
						return;

					var RdUrl = "";
					var seqArr = [];
					var param = {
						printngSeCode: "SY15000001",
						printngOrginlFileNm: "SKHynix COA_v02.mrd"
					};

					customAjax({
						url: "/com/printCours.lims",
						data: param,
						successFunc: function(data) {
							if (data.length == 1) {
								RdUrl = data[0].printngOrginlFileNm; //로컬서버
								//RdUrl = data[0].printngCours; //운영서버
								seqArr.push(item.coaSeqno); //COA 성적서 mrd파일은 단건출력
								html5Viewer([RdUrl], seqArr);
							} else {
								err(lang.C100000597);
							}
						}
					});
				}, false, "성적서 출력")

				//재출력
				.buttonRenderer(['printngSeqno'], function(dataFields, func, editable, labelText, props) {
					var item = AUIGrid.getSelectedItems(coaReportGrid)[0].item;
					if (!item.coaPblicteAtchmnflSeqno) {
						warn(lang.C100001063); //저장된 COA파일이 없습니다.
						return;
					}

					var param = "{\"atchmnflSeqno\" : \""+item.coaPblicteAtchmnflSeqno+"\"}";
					window.location.href = "/test/pblicateCoaExcelDownload.lims?param="+encodeURIComponent(param);
				}, false, lang.C100001065);

				var coaReprtProp = {
					editable : false,
					selectionMode : "multipleCells",
					enableCellMerge : true,
					enableFilter : true,
					rowStyleFunction : function(rowIndex, item) {
						if (item.jdgmntWordCode == "IM05000002") {
							return "coa-row-style";
						} else if (item.progrsSittnCode == "IM03000006") {
							return "coaend-row-style";
						} else {
							return "";
						}
					}
				};

				coaReportGrid = createAUIGrid(col, coaReportGrid, coaReprtProp);
				gridColResize([coaReportGrid], "2");
			}


			//상위lot 그리드
			function setUpperLotGrid() {
				var upperProp = {
					displayTreeOpen : false,
					flat2tree : true,
					selectionMode : "multipleCells",
					treeIdField : "lwprtReqestSeqno",
					treeIdRefField : "upperReqestSeqno",
					showRowCheckColumn : true,
					showRowAllCheckBox : true,
					enableDrag : true,
					enableDragByCellDrag : true,
					enableDrop : true
				};

				var col = [];
				auigridCol(col);
				col.addColumnCustom("reqestNo", "의뢰번호", "*", true) //의뢰번호
				.addColumnCustom("lotNo", "Lot No.", "*", true) //Lot No.
				.addColumnCustom("inspctTyNm", "검사유형", "*", true) //검사유형
				.addColumnCustom("mtrilNm", "제품명", "*", true) //제품명
				.addColumnCustom("sploreNm", "시료정보", "*", true) //시료정보
				.addColumnCustom("po", "PO No.", "*", true, true) //PO No.
				.addColumnCustom("shipmntQy", "출하량", "*", true, true) //출하량
				.addColumnCustom("upperReqestSeqno", "upperReqestSeqno", "*", false)
				.addColumnCustom("reqestSeqno", "reqestSeqno", "*", false) //의뢰일련번호
				.addColumnCustom("lwprtReqestSeqno", "lwprtReqestSeqno", "*", false) //의뢰일련번호
				.addColumnCustom("ordr", "ordr", "*", false) //순서
				.addColumnCustom("roaCreatAt", "ROA 생성여부", "*", false); //ROA 생성여부

				upperLotGrid = createAUIGrid(col, "upperLotGrid", upperProp);
				gridColResize([upperLotGrid], "2");
			}


			function buttonEvent() {
				document.getElementById('printngSeqno').addEventListener("change", function() {
					//업체양식 정보 조회
					var printngParams = { printngSeqno : this.value };
					comboAjaxJsonParam('/test/getEntrpsPrintInfo.lims', printngParams, function(data) {
						AUIGrid.clearGridData(upperLotGrid);
						setVal('mtrilSeqno', data.mtrilSeqno);
						setVal('ctmmnyMtrilCode', data.ctmmnyMtrilCode);
						//업체 선택할 때마다 마스터 확장자 값으로 설정
						data.dwldFileSeCode == "SY17000001" ? getEl('excelChk').checked = true  : getEl('csvChk').checked = true;
					}, null, false);
				});

				//샘플 엑셀파일 생성
				document.getElementById('btnCreateExcelSample').addEventListener("click", function() {
					//공통 밸리데이션 체크
					if (!cmmnValidChk("sample"))
						return;

					var sortingList = sortUpperLot("sample");
					var targetPrdct = new Array(sortingList[0]);
					var targetLwprt = [];

					for (var i = 1; i < sortingList.length; i++) {
						if (sortingList[i].upperSortOrdr == targetPrdct[0].upperSortOrdr)
							targetLwprt.push(sortingList[i]);
						else
							break;
					}

					var params = targetPrdct.concat(targetLwprt);
					customAjax({
						url: "/test/createExcelSample.lims",
						data: params,
						successFunc: function(data) {
							if (!!data.filePath) {
								//생성된 성적서 파일정보를 리턴받아 json형태의 문자열로 담아서 엑셀 다운로드 요청에 파라미터로 날려줌
								var filePath = data.filePath.replaceAll("\\", "/");
								var params = "{\"fileName\" : \"" + data.fileName + "\", \"fileType\" : \"" + data.fileType + "\", \"filePath\" : \"" + filePath + "\"}";
								window.location.href = "/test/excelDownload.lims?params=" + encodeURIComponent(params);
							} else if (!!data.excpMsg) {
								warn(data.excpMsg);
							} else {
								err(lang.C100000597);
							}
						}
					});
				});

				//COA 미리보기
				document.getElementById('btnPreviewDownload').addEventListener("click", function() {
					//공통 밸리데이션 체크
					if (!cmmnValidChk())
						return;

					var sortingList = sortUpperLot(); //순서대로 정렬된 상위lot 리스트
					var formObj = getEl(inputForm).toObject(); //서비스에 보낼 리스트 끝에 입력폼 데이터 붙여서 보냄
					formObj.coaType = 'preview'; //미리보기&생성 구분값
					sortingList.push(formObj);

					//성적서 출력 요청
					customAjax({
						url: "/test/getExpriemXls.lims",
						data: sortingList,
						successFunc: function(data) {
							if (!!data.filePath) {
								//생성된 성적서 파일정보를 리턴받아 json형태의 문자열로 담아서 엑셀 다운로드 요청에 파라미터로 날려줌
								var filePath = data.filePath.replaceAll("\\", "/");
								var params = "{\"fileName\" : \"" + data.fileName + "\", \"fileType\" : \"" + data.fileType + "\", \"filePath\" : \"" + filePath + "\"}";
								window.location.href = "/test/excelDownload.lims?params=" + encodeURIComponent(params);
							} else if (!!data.excpMsg) {
								warn(data.excpMsg);
							} else {
								err(lang.C100000597);
							}
						}
					});
				});


				//조회버튼
				document.getElementById('btnSearch').addEventListener("click", function() {
					searchCoa();
				});


				//COA생성버튼
				document.getElementById('btnSave').addEventListener("click", function() {
					//공통 밸리데이션 체크
					if (!cmmnValidChk())
						return;

					if (confirm(lang.C100000764))
						saveCoa();
				});

				//신규버튼
				document.getElementById('btnNew').addEventListener("click", function() {
					pageReset([inputForm], [upperLotGrid], null, function() {
						comboReset('printngSeqno', true);
					});
				});

				//업체 초기화 버튼
				document.getElementById('btnEntrpsReset').addEventListener("click", function() {
					dialogReset(this.id);
					ajaxJsonComboBox("/test/getEntrpsPrintCombo.lims", "printngSeqno", null, true);
					AUIGrid.clearGridData(upperLotGrid);
				});
			}


			function auiGridEvent() {
				//COA발행목록 더블클릭 이벤트
				AUIGrid.bind(coaReportGrid, "cellDoubleClick", function(event) {
					var params = { coaSeqno : event.item.coaSeqno };
					customAjax({
						url: "/test/getCoaUpperList.lims",
						data: params,
						showLoading: false
					}).then(function(data) {
						AUIGrid.setGridData(upperLotGrid, data);

						var param = {
							bplcCode : event.item.bplcCode,
							mtrilSeqno : event.item.mtrilSeqno,
							entrpsSeqno : event.item.entrpsSeqno
						};
						ajaxJsonComboBox("/test/getEntrpsPrintCombo.lims", "printngSeqno", param, null, null, null, null, function(data) {
							setVal('printngSeqno', event.item.printngSeqno);
							setVal('ctmmnyMtrilCode', event.item.ctmmnyMtrilCode);
							setVal('mtrilSeqno', event.item.mtrilSeqno);
						});

						//평균적용여부, DL적용여부, 확장자
						event.item.avrgApplcAt == "N" ? getEl("avrgNotApp").checked = true : getEl("avrgApp").checked = true;
						event.item.detectLimitApplcAt == "N" ? getEl("dlNotApp").checked = true : getEl("dlApp").checked = true;
						event.item.dwldFileSeCode == "SY17000001" ? getEl("excelChk").checked = true : getEl("csvChk").checked = true;

						setVal('entrpsSeqno', event.item.entrpsSeqno); //업체 일렬번호
						setVal('entrpsNm', event.item.entrpsNm); //업체명
						setVal('shipmntDte', event.item.shipmntDte); //출하일

						AUIGrid.setAllCheckedRows(upperLotGrid, true);
						AUIGrid.collapseAll(upperLotGrid);
					});
				});

				//상위lot는 PO, 출하량 데이터를 다루지 않으므로 수정 방지
				AUIGrid.bind(upperLotGrid, "cellEditBegin", function(event) {
					if (!!event.item.upperReqestSeqno && (event.dataField == "po" || event.dataField == "shipmntQy"))
						return false;
				});

				//상위lot 체크박스 클릭 이벤트
				AUIGrid.bind(upperLotGrid, "rowCheckClick", function(event) {
					var parentRow = AUIGrid.getParentItemByRowId(upperLotGrid, event.item._$uid); //부모 데이터
					var parentRowItem = AUIGrid.isCheckedRowById(upperLotGrid, event.item._$uid); //부모 데이터 체크
					var sumArray = new Array();

					if (parentRow != null) {
						for (var i = 0; i < parentRow.children.length; i++) {
							//자식 데이터체크
							rowItem = AUIGrid.isCheckedRowById(upperLotGrid, parentRow.children[i]._$uid);
							sumArray.push(rowItem);
						}

						//자식 데이터 합쳐서 하나라도있거나 없으면 구분가능
						var result = sumArray.join();
						if (result.indexOf(true) == -1) {
							AUIGrid.addUncheckedRowsByValue(upperLotGrid, "lwprtReqestSeqno", event.item.upperReqestSeqno);
						} else {
							AUIGrid.addCheckedRowsByValue(upperLotGrid, "lwprtReqestSeqno", event.item.upperReqestSeqno);
						}

					//상위lot는 해당 제품lot 체크상태를 따라감
					} else {
						if (parentRowItem == true) {
							AUIGrid.addCheckedRowsByValue(upperLotGrid, "upperReqestSeqno", event.item.lwprtReqestSeqno);
						} else {
							AUIGrid.addUncheckedRowsByValue(upperLotGrid, "upperReqestSeqno", event.item.lwprtReqestSeqno);
						}
					}
				});

				gridResize([coaReportGrid, upperLotGrid]);
			}

			//COA 발행목록 조회
			function searchCoa(saveKey) {
				getGridDataForm("/test/getCoaList.lims", searchForm, coaReportGrid, function() {
					if (saveKey)
						gridSelectRow(coaReportGrid, "coaSeqno", [saveKey]);
				});
			}

			function cmmnValidChk(gbnStr) {
				if (!saveValidation(inputForm))
					return false;

				var gridData = AUIGrid.getGridData(upperLotGrid);
				if (gridData.length == 0) {
					warn("의뢰 LOT를 추가해주세요."); //의뢰 LOT를 추가해주세요.
					return false;
				}

				var checkItems = AUIGrid.getCheckedRowItems(upperLotGrid);
				if (checkItems.length == 0 && gbnStr != 'sample') {
					warn("출력할 의뢰 LOT를 선택해주세요."); //출력할 의뢰 LOT를 선택해주세요.
					return false;
				}

				return true;
			}

			//상위lot 그리드 순서정렬
			function sortUpperLot(gbnStr) {
				//모든 노드 전체 펼치기해줘야 체크된 행아이템 얻을 때 rowIndex값이 정상적으로 잡힘
				AUIGrid.expandAll(upperLotGrid);

				if (gbnStr == 'sample')
					AUIGrid.setAllCheckedRows(upperLotGrid, true);

				//rowIndex 기준으로 sort해야 그리드에 보여지는 순서대로 리스트가 정렬됨
				var checkItems = AUIGrid.getCheckedRowItems(upperLotGrid);
				var sortingField = "rowIndex";
				checkItems.sort(function(a, b) {
					return a[sortingField] - b[sortingField];
				});

				var sumArray = new Array();
				var prdctOrdr = 0; //제품lot 정렬순서
				var lwprtOrdr = 0; //상위lot 정렬순서

				for (var i = 0; i < checkItems.length; i++) {
					var item = checkItems[i].item;
					var param = {};

					//제품lot와 상위lot 정렬순서는 별개로 구분되어 증가
					//제품lot는 lSortOrdr가 0값이고, 상위lot는 속한 제품lot의 uSortOrdr값을 따라감
					if (item.upperReqestSeqno) {
						lwprtOrdr++;
						item.uSortOrdr = prdctOrdr;
						item.lSortOrdr = lwprtOrdr;
					} else {
						lwprtOrdr = 0; //상위lot 순서값 초기화

						prdctOrdr++;
						item.uSortOrdr = prdctOrdr;
						item.lSortOrdr = 0;
					}

					param.reqestSeqno = item.lwprtReqestSeqno; //의뢰일렬번호
					param.upperReqestSeqno = item.upperReqestSeqno; //상위lot가 속한 제품lot의 의뢰일렬번호
					param.upperSortOrdr = item.uSortOrdr; //제품lot 정렬순서
					param.lwprtSortOrdr = item.lSortOrdr; //상위lot 정렬순서
					param.po = item.po; //PO No.
					param.shipmntQy = item.shipmntQy; //출하량

					sumArray.push(param);
				}

				AUIGrid.collapseAll(upperLotGrid); //최상위 브랜치 제외하고 모든 노드 닫기
				return sumArray;
			}


			//COA생성
			function saveCoa() {
				showLoadingbar();

				//순서대로 정렬된 상위lot 리스트
				var sortingList = sortUpperLot();
				var formObj = getEl(inputForm).toObject();
				formObj.coaType = 'coaview';
				sortingList.push(formObj);

				customAjax({
					url: "/test/insCoaInfo.lims",
					data: sortingList,
					successFunc: function (data) {
						if (!!data.filePath) {
							success(lang.C100000762); //저장 되었습니다.
							getEl('btnNew').click();
							searchCoa(data.coaSeqno);

							//생성된 성적서 파일정보를 리턴받아 json형태의 문자열로 담아서 엑셀 다운로드 요청에 파라미터로 날려줌
							var filePath = data.filePath.replaceAll("\\", "/");
							var params = "{\"fileName\" : \"" + data.fileName + "\", \"fileType\" : \"" + data.fileType + "\", \"filePath\" : \"" + filePath + "\"}";
							window.location.href = "/test/excelDownload.lims?params=" + encodeURIComponent(params);
						} else if (!!data.excpMsg) {
							warn(data.excpMsg);
						} else {
							err(lang.C100000597);
						}
					}
				});
			}


			function doSearch(e) {
				searchCoa();
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
