<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">${msg.C100001084}</tiles:putAttribute> <!-- NCRReport -->
	<tiles:putAttribute name="body">
	<!--  body 시작 -->
	<div class="subContent">
		<div class="subCon1">
			<h2><i class="fi-rr-apps"></i>${msg.C100001089}</h2> <!-- NCR 이력 -->
			<div class="btnWrap">
				<button type="button" id="btnDown" class="btn5" onclick="getNcrReportData()">${msg.C100000265}</button> <!-- 다운로드 -->
				<button type="button" id="btnSelect" class="search" onclick="getNcrReportList()">${msg.C100000767}</button> <!-- 조회 -->
			</div>

			<!-- Main content -->
			<form id="searchFrm">
				<table class="subTable1" style="width:100%;">
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
						<td><select id="bplcCodeSch" name="bplcCode"  class="wd100p"></select></td>
						<th>${msg.C100000942}</th> <!-- 프로세스 타입 -->
						<td><select id="processTyCodeSch" name="processTyCode" class="wd100p"></select></td>
						<th>${msg.C100000717}</th> <!-- 자재 명-->
						<td><select id="mtrilSeqnoSch" name="mtrilSeqno" style="width:100%;"></select></td>
						<th>${msg.C100000634}</th> <!-- 원인분류 -->
						<td><select id="causeClCodeSch" name="causeClCode" class="wd100p"></select>

					</tr>
					<tr>
						<th class="necessary">${msg.C100000229}</th> <!-- 기간 -->
						<td>
							<input type="text"id="pblicteBeginDte"name="pblicteBeginDte" class="dateChk wd42p schClass" maxlength="10" style="min-width:0;" required> ~
                            <input type="text"id="pblicteEndDte"name="pblicteEndDte" class="dateChk wd42p schClass" maxlength="10" style="min-width: 0;" required>
						</td>
						<th>${msg.C100000056}</th> <!-- LOT No. -->
						<td><input type="text" id="lotNoSch" name="lotNo" class="wd100p schClass" maxlength="20"/></td>
						<th>${msg.C100000477}</th> <!-- 상태 -->
						<td colspan="3">
							<input name="processType" value="" type="radio" checked>${msg.C100000779} <!-- 전체 -->
					        <input name="processType" value="Y" type="radio">${msg.C100000857}<!-- 처리 -->
							<input name="processType" value="N" type="radio">${msg.C100001090} <!-- 처리 전 -->
					    </td> <!-- 사용안함 -->
					</tr>
				</table>
			</form>
		</div>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div class="subCon2">
			<div id="ncrGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
		<form id="ncrForm">
			<!-- 문서정보 시작 -->
			<div class="subCon1 mgT15">
				<h2><i class="fi-rr-apps"></i>${msg.C100001085}</h2> <!-- NCR 정보 -->
				<div class="btnWrap">
					<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
					<input type="hidden" id="btnSave_ncr" value="${msg.C100001086} }"> <!-- 첨부파일 저장 -->
				</div>
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
						<th>${msg.C100000069}</th> <!-- NCR No -->
						<td>
							<input type="text" id="ncrNo" name="ncrNo" maxlength="15" readonly/>
							<input type="hidden" id="bplcCode" name="bplcCode">
						</td>
						<th>${msg.C100000354}</th> <!-- 발행일자 -->
						<td>
							<input type="text"id="pblicteDte"name="pblicteDte" class="dateChk wd100p" maxlength="10" readonly>
						</td>
						<th>${msg.C100000802}</th> <!-- 제목 -->
						<td>
							<input type="text" id="sj" name="sj" maxlength="1000" readonly/>
						</td>

						<th>${msg.C100000717}</th> <!-- 자재 명 -->
						<td>
							<input type="hidden" id="mtrilSeqno" name="mtrilSeqno">
							<input type="text" id="mtrilNm" name="mtrilNm" class="wd100p" style="min-width: 0px;" readonly>
						</td>
					</tr>
					<tr>
						<th class="necessary">${msg.C100000942}</th> <!-- 프로세스 타입 -->
						<td>
							<select id="processTyCode" name="processTyCode" required onChange="this.selectedIndex = this.initialSelect"></select>
						</td>
						<th class="necessary">${msg.C100000056}</th> <!-- Lot No -->
						<td>
							<input type="hidden" id="reqestSeqno" name="reqestSeqno">
							<input type="text" id="lotNo" name="lotNo" maxlength="20" class="wd70p" required style="min-width: 0px;" readonly>
							<button type="button" id="btnLotNoSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
						</td>
						<th>${msg.C100000184}</th> <!-- 고객/업체명 -->
						<td>
							<input type="text" id="entrpsNm" name="entrpsNm"  maxlength="200" readonly>
						</td>
						<th class="necessary">${msg.C100000405}</th> <!-- 부적합 유형 -->
						<td>
							<select id="improptTyCode" name="improptTyCode" required readonly></select>
						</td>
					</tr>
					<tr>
						<th class="necessary">${msg.C100000555}</th> <!-- 시험항목 -->
						<td colspan="7">
							<input type="text" id="expriemSumry" name="expriemSumry"  maxlength="300" style="min-width: 0;width:calc(100% - 80px);" required readonly>
							<button type="button" id="btnAddMtrilExpriemList" class="inTableBtn inputBtn">${msg.C100000555}</button>  <!-- 시험 항목 -->
						</td>
					</tr>
					<tr>
						<th>${msg.C100000402}</th> <!-- 부적합 내용 -->
						<td colspan="7">
							<textarea id="improptCn" name="improptCn" rows="5" class="wd100p"  maxlength="4000" readonly></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="subCon2">
				<h2><i class="fi-rr-apps"></i>${msg.C100000561}</h2> <!-- 시험항목 목록 -->
				<div id="ncrGridExpriem" name="ncrGridExpriem" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT15">
				<h2><i class="fi-rr-apps"></i>${msg.C100000857}</h2> <!-- 처리 -->
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
						<th class="necessary">${msg.C100000631}</th> <!-- 원인 분류 -->
						<td>
							<select id="causeClCode" name="causeClCode" class="wd100p" required></select>
						</td>
						<th class="necessary">${msg.C100000858}</th> <!-- 처리방안 -->
						<td>
							<select id="processMethodCode" name="processMethodCode" class="wd100p" required></select>
						</td>
						<th>${msg.C100000189}</th> <!-- 고객사 공개 여부 -->
						<td colspan="3" style="text-align:left;">
								<label><input type="radio" id="ctmmnyOthbcAt_Y" name="ctmmnyOthbcAt" value="Y" checked>${msg.C100001087}</label> <!-- 공개 -->
								<label><input type="radio" id="ctmmnyOthbcAt_N" name="ctmmnyOthbcAt" value="N" >${msg.C100001088}</label> <!-- 비공개 -->
						</td>
					</tr>

					<tr>
						<th class="necessary">${msg.C100000404}</th> <!-- 부적합 발생 원인 -->
						<td colspan="7">
							<textarea id="improptOccrrncCause" name="improptOccrrncCause" rows="5" class="wd100p"  maxlength="4000" required></textarea>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000632}</th> <!-- 원인 상세 -->
						<td colspan="7">
							<textarea id="causeDetailCn" name="causeDetailCn" rows="5" class="wd100p" maxlength="4000"></textarea>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000278}</th> <!-- 대책 -->
						<td colspan="7">
							<textarea id="cntrpln" name="cntrpln" rows="5" class="wd100p" maxlength="4000"></textarea>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000225}</th> <!-- 근거 -->
						<td colspan="7">
							<textarea id="basis" name="basis" rows="5" class="wd100p" maxlength="2000"></textarea>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000860}</th> <!-- 첨부파일 -->
						<td colspan="7">
							<div id="dropzoneArea_ncr" style="text-align: left;"></div>
							<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno">
							<input type="hidden" id="ncrSeqno" name="ncrSeqno">
						</td>
					</tr>
				</table>
			</div>
		</form>
		<div class="accordion_wrap mgT17">
			<div class="accordion ">${msg.C100001089}</div>  <!-- NCR 이력 -->
			<div id="acc1" class="acco_top mgT15" style="display: none">
				<h3>${msg.C100000983}</h3> <!-- 품질 문서 이력 -->
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div class="subCon2">
					<div id="ncrDocHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
				</div>
			</div>
		</div>

	</div>

	<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script type="text/javascript">
			var ncrGrid = "ncrGrid";
			var ncrGridExpriem = "ncrGridExpriem";
			var ncrDocHistGrid = 'ncrDocHistGrid';
			var dropzoneArea_ncr; // 서명첨부파일
			var lang = ${msg};

			window.onload = function(){
				// 그리드 세팅
				setGrid();

				//AUI 그리드 이벤트
				auiGridEvent();

				// 버튼 이벤트
				setButtonEvent();

				//select box bind
				setCombo();

				setDialog();

				//그리드 사이즈 조절
				gridResize([ncrGrid, ncrGridExpriem, ncrDocHistGrid]);
			}

			function setGrid(){
				//칼럼 설정
		        var columnLayout = {
		            ncrGrid : [],
					ncrGridExpriem : [],
					ncrDocHistGrid : []
		        }
		    	var ncrPros={
		 			showRowCheckColumn : true,
		 	 		showRowAllCheckBox : true
		 		};
				var cusPros = {
					editable : true,
					selectionMode : "multipleCells",
					enableCellMerge : true
				};

				//제품목록 그리드
				auigridCol(columnLayout.ncrGrid);
		        columnLayout.ncrGrid.addColumnCustom("ncrNo"   , "${msg.C100000069}"   ,"*",true) /* ncr no */
										.addColumnCustom("ncrSeqno"   , "NCR 일렬번호"   ,"*",false) /* NCR 일렬번호 */
		                                .addColumnCustom("mtrilNm" , "${msg.C100000717}"   ,"*",true) /* 자재 명 */
		                                .addColumnCustom("lotNo", "${msg.C100000056}","*",true) /* Lot No. */
		                                .addColumnCustom("improptTyCodeNm", "${msg.C100000405}"        ,"*",true) /* 부적합 유형 */
		                                .addColumnCustom("improptCn"      , "${msg.C100000402}"   ,"*",true) /* 부적합 내용 */
		                                .addColumnCustom("sj"    , "${msg.C100000802}"   ,"*",true) /* 제목 */
		                                .addColumnCustom("causeClCodeNm"  , "${msg.C100000634}"      ,"*",true) /* 원인분류 */
		                                .addColumnCustom("processMethodCodeNm"    , "${msg.C100000858}"   ,"*",true) /* 처리 방안 */
		                                .addColumnCustom("processTyCode"  , "${msg.C100000942}"   ,"*",true) /* 프로세스 타입 */
		                                .addColumnCustom("processType"  , "${msg.C100000477}"   ,"*",true) /* 상태 */
		                                .addColumnCustom("pblicteDte"    , "${msg.C100000354}"   ,"*",true) /* 발행일자 */
		                                ;
		        //저장된 로컬스토리지가 없으면 기본 그리드 세팅 출력
		        ncrGrid = createAUIGrid(columnLayout.ncrGrid, ncrGrid,ncrPros);

				auigridCol(columnLayout.ncrGridExpriem);
				columnLayout.ncrGridExpriem.addColumn("lotNo", "${msg.C100000056}","*",true,null,null,null,null,null,true); /* Lot No */
				columnLayout.ncrGridExpriem.addColumn("expriemNm", "${msg.C100000560}","*",true, false); /* 시험항목 명 */
				columnLayout.ncrGridExpriem.addColumn("lclUcl", "${msg.C100001096}","*",true,false) /* LCL / UCL */
				columnLayout.ncrGridExpriem.addColumn("resultValue", "${msg.C100000150}","*",true,false) /* 결과값 */
				columnLayout.ncrGridExpriem.addColumn("resultRegistDte", "${msg.C100000151}","*",true,false) /* 결과 입력일자 */
				columnLayout.ncrGridExpriem.addColumn("unitNm", "${msg.C100000268}","*",true) /* 단위 */
				columnLayout.ncrGridExpriem.addColumn("eqpmnNm", "${msg.C100000736}","*",true) /* 장비 */
				;
				//저장된 로컬스토리지가 없으면 기본 그리드 세팅 출력
				ncrGridExpriem = createAUIGrid(columnLayout.ncrGridExpriem, ncrGridExpriem);


				auigridCol(columnLayout.ncrDocHistGrid);
				columnLayout.ncrDocHistGrid.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)  // 품질문서이력 일렬번호
				.addColumnCustom('tableNm',lang.C100000973,'*',true,false)                						 // 테이블 명
				.addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              						 // 테이블 주석명
				.addColumnCustom('columnNm',lang.C100000975,'*',true,false)               						 // 컬럼 명
				.addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             						 // 컬럼 주석명
				.addColumnCustom('seqno','일련번호','*',false,false)                      						  // 일련번호
				.addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            						 // 변경 전
				.addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)          						 // 변경 후
				.addColumnCustom('changerNm',lang.C100000977,'*',true,false)              						 // 최종 변경자
				.addColumnCustom('lastChangeDt',lang.C100000978,'*',true,false);          						 // 최종 변경 일시

				ncrDocHistGrid = createAUIGrid(columnLayout.ncrDocHistGrid, "ncrDocHistGrid", cusPros);

				AUIGrid.bind(ncrDocHistGrid, "ready", function(event) {
// 					gridColResize([ncrDocHistGrid], "2");
				});

		        //드랍존 생성
		        dropzoneArea_ncr = DDFC.bind().EventHandler("dropzoneArea_ncr", { btnId : "#btnSave_ncr", maxFiles : 1, lang : "${msg.C100000867}" /* 첨부할 파일을 이 곳에 드래그하세요. */});
			}

			function auiGridEvent(){
				AUIGrid.bind(ncrGrid, "cellDoubleClick", function(event){
					detailAutoSet({
						"item" : event.item,
						"targetFormArr" : ["ncrForm"],
						"successFunc" : function() {
							getNcrHist(event.item.ncrSeqno);
						}
					});
					dropzoneArea_ncr.getFiles($('#atchmnflSeqno').val());
					getExpriemList(event.item);
				});
			}

			function setButtonEvent(){
				// enter key event
				$(".schClass").keypress(function(e) {
					setTimeout(function() {
						if(e.which == 13) {
							if(typeof(getNcrReportList) != "undefined") {
								getNcrReportList();
							}
						}
					}, 100);
				});

				$("#btnSave").click(function(e){
					atchmnflSave();
				});

				$("#btnNew").click(function(e){
					reset();
				});

				$("#bplcCodeSch").change(function(e){
					ajaxSelect2Box({
						"ajaxUrl" : "/com/getMtrilComboList.lims",
						"ajaxParam" : $("#searchFrm").serializeObject(),
						"elementId" : "mtrilSeqnoSch",
						"customTopMsg" : "${msg.C100000779}" //전체
					});
				});

				$("#processTyCodeSch").change(function(e){
					ajaxSelect2Box({
						"ajaxUrl" : "/com/getMtrilComboList.lims",
						"ajaxParam" : $("#searchFrm").serializeObject(),
						"elementId" : "mtrilSeqnoSch",
						"customTopMsg" : "${msg.C100000779}" //전체
					});
				});


				// 아코디언 click event
				var acc = document.getElementsByClassName("accordion");
				var i;

				for (i = 0; i < acc.length; i++) {
					acc[i].addEventListener("click", function() {
						this.classList.toggle("active");
						var panel = this.nextElementSibling;

						if (panel.style.display === "block") {
							panel.style.display = "none";
						}else {
							panel.style.display = "block";
							AUIGrid.resize(ncrGrid);
							AUIGrid.resize(ncrDocHistGrid);

							var seqno = $("#ncrSeqno").val() != '' ? $("#ncrSeqno").val() : null;
							getNcrHist(seqno);
						}

						if (panel.style.maxHeight) {
							panel.style.maxHeight = null;
						}else {
							panel.style.maxHeight = null;
						}
					});
				}

			}

			function setCombo(){
				ajaxJsonComboBox('/com/getCmmnCode.lims', "processTyCode",{ "upperCmmnCode" : "SY02"}, true); // 프로세스 타입
				ajaxJsonComboBox('/com/getCmmnCode.lims', "processTyCodeSch",{ "upperCmmnCode" : "SY02"}, true); // 프로세스 타입(조회조건)
				ajaxJsonComboBox('/com/getCmmnCode.lims', "improptTyCode",{ "upperCmmnCode" : "RS19"}, true); // 부적합 유형
				ajaxJsonComboBox('/com/getCmmnCode.lims', "causeClCode",{ "upperCmmnCode" : "RS09"}, true); // 원인분류
				ajaxJsonComboBox('/com/getCmmnCode.lims', "causeClCodeSch",{ "upperCmmnCode" : "RS09"}, true); // 원인분류(조회조건)
				ajaxJsonComboBox('/com/getCmmnCode.lims', "processMethodCode",{ "upperCmmnCode" : "RS10"}, true); // 처리 방안
				ajaxJsonComboBox('/com/getMtrilComboList.lims', "mtrilSeqnoSch",{ "upperCmmnCode" : ""}, true); // 제품(조회조건)
				ajaxSelect2Box({
					"ajaxUrl" : "/com/getMtrilComboList.lims",
					"ajaxParam" : "",
					"elementId" : "mtrilSeqnoSch",
					"customTopMsg" : "${msg.C100000779}" //전체
				});


				//캘린더
				datePickerCalendar(["pblicteBeginDte"], true, ["DD",-7]);
				datePickerCalendar(["pblicteEndDte"], true, ["DD",0]);
			}

			// 첨부 파일 저장 함수
			function atchmnflSave() {
				var files = dropzoneArea_ncr.getNewFiles();
				var files_cnt = files.length;

				if (files_cnt > 0) {
					$("#btnSave_ncr").click();
					dropzoneArea_ncr.on("uploadComplete", function(event, fileIdx) {
						if (fileIdx == -1) {
							err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
						} else {
							$("#atchmnflSeqno").val(fileIdx);
							saveNCRReport(); // 사용자 정보 저장함수 호출
						}
					});
				} else { // 첨부파일이 없을 시
					saveNCRReport(); // 사용자 정보 저장함수 호출
				}
			}

			function saveNCRReport(){
				//ncr 정보 폼 밸리데이션 체크
				if(!saveValidation("ncrForm")){
					return false;
				};
				customAjax({
					"url" : "/qa/saveNCRReport.lims",
					"data" : Object.assign($("#ncrForm").serializeObject(), {"expriemList" : AUIGrid.getGridData(ncrGridExpriem)}),
					"successFunc" : function(data){
						if(data > 0){
							success("${msg.C100000765}"); //저장되었습니다.
							//재조회
							getNcrReportList();
							AUIGrid.clearGridData(ncrDocHistGrid);
							//폼 초기화
							reset();
						}else{
							err("${msg.C100000597}"); //오류가 발생했습니다.
						}
					}
				});
			};

			function getNcrReportList(){
				if(!saveValidation("searchFrm")) {
					return;
				}
				getGridDataForm("/qa/getNCRReportList.lims", "searchFrm", "ncrGrid");
			}

			// NCR 품질문서이력 조회
			function getNcrHist(seqno) {
				var param = {
					"tableNm" : "RS_NCR"
				};

				if(!!seqno) {
					param.seqno = seqno;
					getGridDataParam('/com//getQlityDocHistList.lims', param, ncrDocHistGrid);
				}else {
					return;
				}
			}

			function getNcrReportData(){
				var selectedItems = AUIGrid.getCheckedRowItemsAll(ncrGrid);
				var seqnoList =[];
				for ( var i=0 ;  i< selectedItems.length ; i++){
					seqnoList.push(selectedItems[i].ncrSeqno)
				}
				openNcrRepor(seqnoList);

			}

			// 장비바코드 출력
			function openNcrRepor(seqno){
				var param = {
					printngSeCode : 'SY15000001',
					printngOrginlFileNm : 'NCR.mrd'
				};

				customAjax({
					"url": "/com/printCours.lims",
					"data": param,
					"successFunc": function(data) {
						if(data.length == 1) {
//			 				RdUrl = data[0].printngOrginlFileNm; // 로컬 rd서버 기준
							RdUrl = data[0].printngCours; // 실서버, 테스트용 서버 기준
							
							if(gridData.length == 0) {
								alert("${msg.C000001356}")  /* 출력할 데이터가 없습니다. */
								return;
							}
							html5Viewer([RdUrl], seqno);
						}else {
							err('${msg.C100000597}') /* 오류가 발생했습니다. */
							return;
						}
					}
				});
			}
			//폼 초기화
			function reset(){
				pageReset(['ncrForm'], ["#ncrGridExpriem", "#ncrDocHistGrid"], null);
				dropzoneArea_ncr.clear();
			}

			function getExpriemList(param){
				customAjax({
					"url" : "/qa/getExpriemListSch.lims",
					"data" : param
				}).then(function(data){
					if(data.length > 0){
						AUIGrid.setGridData(ncrGridExpriem, data);
					}
				});
			}

			function setDialog(){

				dialogLotNo('btnLotNoSearch', '', 'lotNo', function(item) {
					reset();

					$("#lotNo").val(item.lotNo);
					$("#reqestSeqno").val(item.reqestSeqno);
					$("#mtrilSeqno").val(item.mtrilSeqno);
					$("#mtrilNm").val(item.mtrilNm);
					$("#processTyCode").val(item.mtrilTyCode);
					$("#reqestDeptCode").val(item.reqestDeptCode);
					$("#entrpsNm").val(item.entrpsNm);
					$("#bplcCode").val(item.bplcCode);

					$("#expriemSumry").val('');
					AUIGrid.clearGridData(ncrGridExpriem);
				});

				dialogReqestResultAddExpriemList('btnAddMtrilExpriemList',null,'reqExpriem',function(items){
					var expriemStr = items.map(function(item) { return item.expriemNm; }).join(",");

					$("#expriemSumry").val(expriemStr);

					getGridDataParam('/qa/getRequestExpriemListSch.lims', {"reqestSeqno" : $("#reqestSeqno").val(), "list" : items, "flag" : "Y"}, ncrGridExpriem);

				}, function(){
					if(!!$("#ncrSeqno").val()){
						return false;
					}

					if(!$("#mtrilSeqno").val()){
						alert('${msg.C100001078}');//의뢰정보를 선택해 주세요.
						return false;
					}
				});
			}

</script>

</tiles:putAttribute>
</tiles:insertDefinition>