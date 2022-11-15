<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">${msg.C100001067} </tiles:putAttribute> <!-- ROA 보고서 -->
<tiles:putAttribute name="body">
<style>

	.rowStyle-red{
		background-color : #FF9999
	}

	.rowStyle-sky{
		background-color : #A1D0FFL
	}
</style>
<div class="subContent">
	<div class="subCon1 mgT10">
		<form id="frmSearch">
			<h2><i class="fi-rr-apps"></i>${msg.C100000655} <!-- 의뢰 목록 -->
			</h2>
			<div class="btnWrap">
				<button type="button" id="btnRoaRollback" class="save" <c:if test="${auditAt == 'Y'}"> style="display:none;" </c:if>>${msg.C100000084}</button> <!-- ROA 되돌리기 -->
				<button type="button" id="btnSelect" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
					<th>${msg.C100000717}</th> <!-- 자재 명 -->
					<td>
						<input type="text" class="wd100p schFunc" name="mtrilNm" id="mtrilSch" maxLength="200"/>
					</td>
					<th>${msg.C100001352}</th> <!-- 분석실 -->
					<td>
						<select class="wd100p schFunc" name="custlabSeqno" id="custlabSeqnoSch"></select>
					</td>
					<th>${msg.C100000657}</th> <!-- 의뢰 번호 -->
					<td>
						<input type="text" class="wd100p schFunc" name="reqestNo" id="reqestNoSch" maxLength="11">
					</td>
					<th>${msg.C100000139}</th> <!-- 검사 유형 -->
					<td>
						<select class="wd100p schFunc" id="inspctTyCodeSch" name="inspctTyCode">
							<option>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
				</tr>
				<tr>

					<th>${msg.C100000659}</th> <!-- 의뢰 일자 -->
					<td>
						<input type="text" id="reqestBeginDte" name="reqestBeginDte" class="dateChk schFunc wd6p" style="min-width: 6em;" autocomplete="off" >
						~
						<input type="text" id="reqestEndDte" name="reqestEndDte" class="dateChk schFunc wd6p" style="min-width: 6em;" autocomplete="off" >
					</td>
					<th class="necessary">${msg.C100000803}</th> <!-- 제조 일자 -->
					<td>
						<input type="text" id="mnfcturBeginDte" name="mnfcturBeginDte" class="dateChk schFunc wd6p" style="min-width: 6em;" autocomplete="off" required>
						~
						<input type="text" id="mnfcturEndDte" name="mnfcturEndDte" class="dateChk schFunc wd6p" style="min-width: 6em;" autocomplete="off" required>
					</td>
					<th>${msg.C100000846}</th> <!-- 진행상황 -->
					<td>
						<select id="progrsSittnCodeSch" name="progrsSittnCode" class="schFunc">
							<option>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div id="requestGrid" class="mgT15 grid" style="width: 100%; height: 200px; margin: 0 auto;"></div>
		<div class="mapkey">
			<label class="invalid">${msg.C100001128}</label> <!-- [부적합] -->
		</div>
	</div>

	<div class="subCon1 mgT30">
		<h2><i class="fi-rr-apps"></i>${msg.C100000558}</h2> <!-- 시험항목 결과 -->
		<div class="btnWrap">
			<button type="button" id="btnRdmsOrg" class="print"<c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>RDMS</button> <!-- RDMSo -->
<%--			<button type="button" id="btnRdmsCopy" class="print">${msg.C100000080}</button> <!-- RDMSc -->--%>
			<button type="button" id="btnRoaEditHist" class="search"<c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>${msg.C100000859}</button> <!-- 처리이력 -->
			<button type="button" id="btnChangeNowData" class="save progrsDisabled"<c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>${msg.C100000243}</button> <!-- 기준 규격 동기화 -->
<%--			<button type="button" id="btnRdmsDate" class="save progrsDisabled" <c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>${msg.C100001221}</button> <!-- 메타 데이터 -->--%>
			<button type="button" id="btnSaveRoa" class="save progrsDisabled">${msg.C100000688}</button> <!-- 임시 저장 -->
			<button type="button" id="btnGenRoa" class="save progrsDisabled">${msg.C100001093}</button> <!-- ROA 생성 -->

		</div>
		<form id="frmRoaDtl" class="mgT15">
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
					<th>${msg.C100000187}</th> <!-- 고객사 -->
					<td>
						<select class="wd100p schClass" name="entrpsSeqno" id="srchEntrpsSeqno">
							<option value="">${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					<td style="text-align: left;" colspan="6"></td>
				</table>
			</form>
		<%-- 여긴 차트 열기용 --%>
		<input type="text" id="btnDialogViewChart" style="display:none;"/>
		<input type="text" id="dialogExpriemNm" style="display:none;"/>
		<input type="text" id="dialogMtrilCode" style="display:none;"/>
		<input type="text" id="dialogMtrilSeqno" style="display:none;"/>
	</div>
	<!-- 이곳에 AUIGrid가 생성됩니다. -->
	<div class="subCon2">
		<div id="roaGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
	</div>
</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">

<script type="text/javascript">
	var lang = ${msg};
	var requestGrid = "requestGrid"; // 자재 정보 그리드
	var roaGrid = "roaGrid"; // roa 그리드
	var selectReq = {};
	var editSaveData = []; //수정한 데이터 담아둘 전역 변수

	Element.prototype.addEvent = function(e, func){
		return this.addEventListener(e, func);
	};

	$(document).ready(function(){
		//권한
		getAuth();

		//그리드생성
		setGridSetting()

		setGridEvent();

		setCombo();

		setSearchEvent();

		setEventHandler();

		setDialogHandler();


	});



	function setGridSetting(){

		//칼럼 설정
		var columnLayout = {
			requestGrid : [],
			roaGrid : []
		}

		var customPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
			//엑스트라체크박스 표시
			showRowCheckColumn : true,
			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true
		};

		var reqPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
			//엑스트라체크박스 표시
			showRowCheckColumn : true,
			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true,
			rowStyleFunction : function(rowIndex, item) {
				//qc 1차값부터 ~5차값까지 있을때 전제조건하에 색칠
				if(item.jdgmntWordCode == "IM05000002")
					return "rowStyle-red"
				return "";
			}
		};

		//의뢰 그리드
		auigridCol(columnLayout.requestGrid);
		columnLayout.requestGrid.addColumn("reqestNo", "${msg.C100000657}","*",true) /* 의뢰번호 */
		.addColumn("reqestDeptCodeNm", "${msg.C100000986}","*",true) /* 부서 */
		.addColumn("clientNm", "${msg.C100000665}","*",true) /* 의뢰자 */
		.addColumn("inspctTyCodeNm", "${msg.C100000139}","*",true) /* 검사 유형 */
		.addColumnCustom("custlabNm","${msg.C100001352}",null,true,false) /* 분석실 */
		.addColumnCustom("prductSeCodeNm","${msg.C100000807}",null,true,false) /* 제품 구분 */
		.addColumnCustom("mtrilNm","${msg.C100000717}",null,true,false) /* 제품명 */
		.addColumnCustom("mnfcturDte","${msg.C100000803}",null,true,false) /* 제조 일자 */
		.addColumnCustom("sploreNm","${msg.C100001353}",null,true,false) /* 시료 정보 */
		.addColumnCustom("rm","${msg.C100001357}",null,true,false) // 특이사항
		.addColumnCustom("progrsSittnCodeNm","${msg.C100000846}",null,true,false); // 진행 상황


		var colStyle = {
			styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {

				if(dataField != "resultValue") return null;

				//판정코드가 부적합이면 적색으로 표시
				if(item["jdgmntWordCode"] == "IM05000002"){
					return "rowStyle-red";
				}

				//삭제여부가 N이고 최대차수이면 하늘색으로 표시
				if(item["deleteAt"] == "N"){
					return "rowStyle-sky";
				}

				return null;
			},
			editRenderer : {
				type : "InputEditRenderer",
				validator : function(oldValue, newValue, rowItem, dataField) {
					if(dataField == "resultValue"){

						//불검출일때는 문자가 들어가줘야함.
						if(newValue.toUpperCase() != "N.A." && rowItem["jdgmntFomCode"] == "IM06000001" && isNaN(newValue)){
							return { "validate" : false, "message" : "${msg.C100001127}"} //판정 구분이 '최대/최소'이면 숫자만 입력 가능합니다.
						}
					}
				}
			}
		}

		auigridCol(columnLayout.roaGrid);
		columnLayout.roaGrid.addColumn("reqestNo", "${msg.C100000657}","*",true) /* 의뢰번호 */
		.addColumnCustom("mnfcturDte","${msg.C100000803}",null,true,false) /* 제조 일자 */
		.addColumnCustom("sploreNm","${msg.C100001353}",null,true,false) /* 시료 정보 */
		.addColumn("expriemNm", "${msg.C100000555}","*",true, false, 2) /* 시험항목 */
		.addColumn("expriemNmDummy", "","2%",true, false,-1)
		.addColumn("unitNm", "${msg.C100000268}","*",true) /* 단위 명 */
		.addColumn("fstRoot", "${msg.C100001357}","10%",true) /* 기준 */
		.addChildColumn("fstRoot","lclUcl", "${msg.C100000255}","*",true,false) /* 내부 */
		.addChildColumn("fstRoot","lslUsl", "${msg.C100001275}","*",true,false) /* 고객 */
		.addColumn("ctmmnyLslUsl", "${msg.C100000187}","*",true) /* 고객사 */
		.addColumnCustom("resultValue", "${msg.C100000150}","*",true,true, colStyle) /* 결과값 */
		.addColumn("lastChangerNm", "${msg.C100000385}","*",true) /* 변경자 */
		.addColumn("progrsSittnCodeNm", "${msg.C100000846}","*",true); /* 진행 상황 */

		//시험항목 옆에 돋보기 이미지(시험항목 차트보기위한 이벤트)
		columnLayout.roaGrid.iconRenderer(["expriemNmDummy"], "/assets/image/reading_glasses.png",
				function(rowIndex, columnIndex, value, item){
			getEl("btnDialogViewChart").value = item.expriemSeqno;
			getEl("dialogExpriemNm").value = item.expriemNm;
			getEl("dialogMtrilCode").value = item.mtrilCode;
			getEl("dialogMtrilSeqno").value = item.mtrilSeqno;
			getEl("btnDialogViewChart").click();
		},19,19);

		// 그리드생성
		requestGrid = createAUIGrid(columnLayout.requestGrid ,requestGrid ,reqPros);

		roaGrid = createAUIGrid(columnLayout.roaGrid ,roaGrid, customPros);

		//그리드 사이즈 조절
		gridResize([requestGrid, roaGrid]);

		AUIGrid.bind(requestGrid, "ready", function(event) {
			gridColResize(requestGrid,"2");
			if ( Object.keys(selectReq).length > 0 && !!selectReq.reqestSeqno ){
				gridSelectRow(requestGrid, "reqestSeqno", [selectReq.reqestSeqno]);
			}
		});

		AUIGrid.bind(roaGrid, "ready", function(event) {
			gridColResize(roaGrid,"2");
		});

	}

	function setSearchEvent(){
		//조회버튼에 그리드 조회기능넣어줌
		getEl("btnSelect").addEvent("click",function(){
			doSearch();
		});
	}

	function setCombo(){
		datePickerCalendar(["reqestBeginDte","reqestEndDte"]);//의뢰일자 조회조건
		datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-7], ["DD",0]);//제조일자 조회조건

		ajaxJsonComboBox('/rsc/getCustlabCombo.lims','custlabSeqnoSch',null,true);
		ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03", "inCode" : "'IM03000004', 'IM03000005'"}, false, null, "IM03000004");
		ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true);
		ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'reqestDeptCode', queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" }, selectFlag : true});
	}


	function setGridEvent(){
		//자재 그리드 더블클릭 이벤트
		AUIGrid.bind(requestGrid, "cellDoubleClick", function(event) {
			reset("roa");
			editSaveData = [];
			selectReq = event.item;

			$.when(
					ajaxJsonComboBox("/test/getEntrpsList.lims","srchEntrpsSeqno",{"mtrilSeqno" : event.item.mtrilSeqno} , true)
			).then(function(first, second){
				roaGridList(true);

				// buttonDisabled(event.item.progrsSittnCode);
			});
		});

		AUIGrid.bind(roaGrid, "cellEditEnd", function(event){

			//고객사가 선택되어있으면 고객사 기준규격으로 판정을 냄.
			//고객사가 선택되어 있지 않으면 LSL 기준규격으로 판정을 냄.
			var item = event.item;
			var uslValue = ($("#srchEntrpsSeqno").val() != '') ? item.ctmmnyUslValue : item.uslValue;
			var uslValueSeCode = ($("#srchEntrpsSeqno").val() != '') ? item.ctmmnyUslValueSeCode : item.uslValueSeCode;
			var lslValue = ($("#srchEntrpsSeqno").val() != '') ? item.ctmmnyLslValue : item.lslValue;
			var lslValueSeCode = ($("#srchEntrpsSeqno").val() != '') ? item.ctmmnyLslValueSeCode : item.lslValueSeCode;
			var textStdr = ($("#srchEntrpsSeqno").val() != '') ? item.ctmmnyTextStdr : item.textStdr;

			chkSdspcValue({
				"dataField" : event.dataField
				, "sResult" : event.value
				, "jdgmntFomCode" : event.item.jdgmntFomCode
				, "uclValue" : uslValue
				, "uclValueSeCode" : uslValueSeCode
				, "lclValue" : lslValue
				, "lclValueSeCode" : lslValueSeCode
				, "textStdr" : textStdr
			}, function(result){
				//판정 값을 row에 넣어줘야 판정과 데이터 담을때 값에 이상 없음.
				event.item["jdgmntWordCode"] = result;

				AUIGrid.setCellValue(roaGrid, event.rowIndex, "jdgmntWordCode", result);

				editDataProxy(event);
			});
			
			
		});
	}

	function setEventHandler(){

		//RDMSO(RDMS 원본본 RAW DATA 보기 이벤트)
		getEl("btnRdmsOrg").event("click", function(e){
			callRDMSViwer(roaGrid, 'O');
		});

		//RDMSC(RDMS 복사본 RAW DATA 보기 이벤트)
		/*getEl("btnRdmsCopy").event("click", function(e){
			callRDMSViwer(roaGrid, 'C');
		});*/

		//시험항목 조회조건인 고객사 selectbox 이벤트
		getEl("srchEntrpsSeqno").addEvent("change", function(e){
			roaGridList(false);
		});

		//기준규격 동기화 이벤트
		getEl("btnChangeNowData").event("click", function(e){
			if(!selectReq){
				alert("${msg.C100000664}"); /* 의뢰를 먼저 선택해주세요. */
				return false;
			}

			if(selectReq == null || selectReq.progrsSittnCode == "IM03000006" || selectReq.progrsSittnCode == "IM03000005"){
				alert("${msg.C100000952}"); /* 해당건은 ROA 수정을 할 수 없습니다. */
				return false;
			}

			if(confirm("변경하시겠습니까? ")){
				customAjax({
					"url": "/test/setChangeNowData.lims",
					"data" : selectReq
				}).then(function(data){
					if(data.insPosition > 0){
						success("${msg.C100001069}"); // 시험항목이 추가되어 진행상황이 '분석중'으로 변경되었습니다.
						reset("roa");
						$("#btnSelect").click();
					}else {
						success("${msg.C100001209}"); /* 현재값으로 수정되었습니다. */
						roaGridList(false);
					}
				});

			}
		});
		
		
		//roa 생성
		getEl("btnGenRoa").addEvent("click", function(){
			if(!selectReq){
				alert("${msg.C100000664}"); /* 의뢰를 먼저 선택해주세요. */
				return false;
			}

			if(selectReq.progrsSittnCode != "IM03000004"){
				alert("${msg.C100001070}"); //진행상황이 'ROA대기'가 아니면 생성 할 수 없습니다.
				return false;
			}else if(selectReq.progrsSittnCode == "IM03000006"){
				alert("${msg.C100000951}"); /* 해당건은 ROA 발행을 할 수 없습니다. */
				return false;
			}

			if(!confirm("ROA 발행하시겠습니까?")){
				return false;
			}

			if(AUIGrid.getItemsByValue(roaGrid, "resultValue", null).length > 0){
				if(!confirm("${msg.C100000928}")) /* 평균값이 없는 항목이 있습니다. 계속 진행하시겠습니까? */
					return false;
			};

			if(AUIGrid.getItemsByValue(roaGrid, "jdgmntWordCode", "IM05000002").length > 0){
				alert("${msg.C100000424}"); /* 불합격 시험항목이 있으므로 ROA 발행이 불가합니다. */
				return false;
			}

			$.when((
				editSaveData.length > 0 ? saveRoaData(function(data, status, request){
					if(status == "success") {
						editSaveData = [];
					}
				},
				function(){
					reset("roa");
					doSearch();
				}) : ""
			))
			.then(function(data, status, request){

				if(status != undefined &&  status != "success") return false;

				customAjax({
					"url": "/test/resultOfAnalysisGenerator_aka_genRoa.lims",
					"data" : selectReq,
					"successFunc" : function(data, status, request){
						if(data["flag"] == "fail"){
							var html = "";

							html += data["failList"].map(function(item){
								return item.expriemNm + " : " + item.failRule;
							}).join("\n") + "\n";

							if(confirm(html + "위 항목들은 SPC RULE에 부적합한 것입니다. \n" + "그래도 발행하시겠습니까?")){ // 그래도 발행하시겠습니까?
								genRoa();
							} else{
								return false;
							}
						}

						if(status == "success"){
							success(lang.C100001358);  /* ROA가 발행되었습니다. */
							AUIGrid.setGridData(roaGrid,[]);
							getEl("btnSelect").click();
						}
					},
					"errorFunc" : function(){

					}
				});
			})


		});



		getEl("btnRoaRollback").addEvent("click", function(){

			var checkedReqestList = AUIGrid.getCheckedRowItemsAll(requestGrid);
			var selectedReq = AUIGrid.getSelectedItems(requestGrid);

			if(checkedReqestList.length == 0 && selectedReq.length > 0){
				checkedReqestList.push(selectedReq[0].item);
			}

			if(checkedReqestList.length == 0 ){
				alert("${msg.C100000664}"); /* 의뢰를 먼저 선택해주세요. */
				return false;
			}

			var msg = checkedReqestList.filter(function(item){return item.progrsSittnCode != "IM03000005"})
							 .map(function (item) {
								return item.reqestNo;
							 }).join(",");

			if(!!msg){
				alert(msg + "${msg.C100001079}"); //는 ROA로 되돌릴수 없습니다.
				return false;
			}

			if(!confirm("${msg.C100001109}")) //ROA 대기로 되돌리시겠습니까?
				return false;

			customAjax({
				"url": "/test/setRoaRollback.lims",
				"data" : checkedReqestList,
				"successFunc" : function(data, status, request){
					if(status == "success"){
						success(lang.C100000765); //저장되었습니다.
						doSearch();
						AUIGrid.clearGridData(roaGrid);
					}
				},
				"errorFunc" : function(){
					reset("roa");
					doSearch();
				}
			})
		});


		getEl("btnSaveRoa").addEvent("click", function(){

			if(!selectReq){
				alert("${msg.C100000664}"); /* 의뢰를 먼저 선택해주세요. */
				return false;
			}

			if(selectReq.progrsSittnCode != "IM03000004" && selectReq.progrsSittnCode != "IM03000005"){
				alert("${msg.C100001080}"); //진행상황이 'ROA대기' 또는 'COA대기'만 저장이 가능합니다.
				return false;
			}

			if(selectReq.progrsSittnCode == "IM03000006"){
				alert("COA완료 된 의뢰는 수정을 할 수 없습니다.");
				return false;
			}

			if(editSaveData.length == 0){
				alert("${msg.C100000526}"); //수정 내역이 없습니다.
				return false;
			}

			if(!confirm("${msg.C100000764}")) /* 저장하시겠습니까? */
				return false;

			saveRoaData(function(data, status, request){
				if(status == "success") {
					success("${msg.C100000762}");  /* 저장되었습니다. */
					editSaveData = [];
					getEl("btnSelect").click();
					roaGridList(true);
				}
			}, function(){
				reset("roa");
				doSearch();
			});
		});
	}

	function setDialogHandler() {

		dialogViewChart("btnDialogViewChart", null, "roaViewChart", function(item){

		},function(){
			if(!getEl("btnDialogViewChart").value){
				alert("${msg.C100001081}"); /* 해당 시험항목은 확인 할 수 없습니다. */
				return false;
			}
		},true);

		dialogRoaEditHist("btnRoaEditHist", null, "roaEditHistDialog", function(item){

		},function(){

			if(!selectReq){
				alert("${msg.C100000664}"); /* 의뢰를 먼저 선택해주세요. */
				return false;
			}

		},true);

		/*dialogUpdRdmsDate("btnRdmsDate", null, "rdmsDateDialog", function(item){
			//헤당 셀에 데이터 입력
			AUIGrid.setCellValue(roaGrid, rowIndex, "userNm", item.userNm);
			AUIGrid.setCellValue(roaGrid, rowIndex, "resultRegisterId", item.userId);
			
		},function(){
			if(!getEl("srchReqestSeqno").value) {
				alert("${msg.C100000664}"); /!* 의뢰를 먼저 선택해주세요. *!/
				return false;
			}
			
			if(getEl("hiddenProgrsSittnCode").value == "IM03000006"){
				alert("${msg.C100000952}"); /!* 해당건은 ROA 수정을 할 수 없습니다. *!/
				return false;
			}
			
		},true);*/
	}
	
	
	//------------------------------  함수들 모음  -------------------------------//
	
	//저장 함수
	function saveRoaData(successFunc, errorFunc){
		return customAjax({
			"url": "/test/updRoaData.lims",
			"data" : editSaveData,
			"successFunc" : successFunc,
			"errorFunc" : errorFunc
		});
	}

	//초기화 함수
	function reset(type){
		switch(type){
			case "roa":
				pageReset(["frmRoaDtl"], [roaGrid], null);
			break;
			case "reqest":
				pageReset(["frmRoaDtl"], [roaGrid, requestGrid], null);
			break;
			default : 
			break;
		}
	}

	function chkLclUclByValue(item, mummValue, mxmmValue){
		if(!!item.resultValue && item.resultValue.toUpperCase() == "N.A.")
			return "";

		if(!!mummValue && !!mxmmValue){
			//item.scdMummValue < item.firValue < item.scdMxmmValue
			if(!!item.resultValue && !(parseFloat(mummValue) <= parseFloat(item.resultValue)) || (parseFloat(mxmmValue) < parseFloat(item.resultValue))){
				return "rowStyle-red";
			}
		} else if(!!mummValue && !mxmmValue){
			if(!!item.resultValue && parseFloat(mummValue) > parseFloat(item.resultValue)){
				return "rowStyle-red";
			}
		} else if(!mummValue && !!mxmmValue){
			if(!!item.resultValue && parseFloat(mxmmValue) < parseFloat(item.resultValue)){
				return "rowStyle-red";
			}
		}
	}
	//진행상황이 COA대기인 의뢰는 저장 관련 버튼들을 막는다.
	/*function buttonDisabled(progrsSittnCode){
		var disabled = false;
		if(progrsSittnCode == "IM03000005"){
			disabled = true;
		}else{
			disabled = false;
		}

		$(".progrsDisabled").prop("disabled", disabled);
	}*/

	function genRoa(){
		//spc8대룰을 다시 체크하지 않고 바로 coa대기로 넘김.
		customAjax({
			"url" : "/test/genRoa.lims",
			"data" : $("#frmRoaDtl").serializeObject(),
			"successFunc" : function(data, status, request){
				if(status == "success"){
					success("${msg.C100001358}");  /* ROA가 발행되었습니다. */
					getEl("btnSelect").click();
					AUIGrid.clearGridData(roaGrid);
				}
			}
		});
	}

	function roaGridList(){
		getGridDataParam("/test/roaList.lims", Object.assign(selectReq, {"prductCtmmnySeqno" : $("#srchEntrpsSeqno").val()}), roaGrid);
	}

	function editDataProxy(event){
		//editSaveData에 아무값이 없으면 확인하지 않고 바로 넣어줌
		if(editSaveData.length == 0){
			editSaveData.push(event.item);
		}else{
			checkDataExistAt(event.item);
		}
	}

	function checkDataExistAt(compareRow){
		var state = false;
		editSaveData.some(function(row, index){

			if(row.reqestExpriemSeqno == compareRow.reqestExpriemSeqno){

				editSaveData[index] = compareRow;

				state = true;
				return true;
			}
		});

		if(!state){
			editSaveData.push(compareRow);
		}
	}

	function doSearch(){
		if(!saveValidation("frmSearch")) {
			return;
		}
		getGridDataForm("/test/getReqList.lims", "frmSearch", requestGrid);
	}
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
