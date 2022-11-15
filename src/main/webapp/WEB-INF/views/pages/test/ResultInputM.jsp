<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">결과입력</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<form action="javascript:;" id="searchFrm" name="searchFrm">
					<h2><i class="fi-rr-apps"></i>${msg.C100000655} <!-- 의뢰 목록 -->
					</h2>
					<div class="btnWrap">
							<%--				<button type="button" id="btnSel" class="btn5">${msg.C100000480}</button> <!-- 선택 -->--%>
						<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
							<th  <c:if test="${UserMVo.auditAt == 'Y'}">style="display:none;" </c:if>>${msg.C100001118}</th> <!-- 최종 차수 조회 -->
							<td id="lastExprOdrTd" colspan="5" style="text-align: left;">
								<input type="radio" id="showExpriemAll" name="showExpriemSch" value="Y">${msg.C100000779} <!-- 전체 -->
								<input type="radio" id="showExpriemLast" name="showExpriemSch" value="N" checked>${msg.C100001119} <!-- 최종 -->
							</td>
						</tr>
					</table>
				</form>
			</div>

			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="resultInputMGrid_Master" style="width:100%; height:130px; margin:0 auto;" class="grid"></div>
			</div>

			<div style="display: flex;">
				<div class="wd60p subCon2 mgT20">
					<h2><i class="fi-rr-apps"></i>${msg.C100000561}</h2> <!-- 시험항목 목록 -->
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="resultInputMGrid_Detail" class="grid mgT10" style="height:385px;"> </div>
				</div>
				<div class="wd40p mgL20 mgT20">
					<div class="subCon1">
						<div class="btnWrap">
							<button type="button" id="btnRdmsExpriemOrg" name="btnRdmsExpriemOrg" onClick="callRDMSViwer(resultInputMGrid_Detail,'O');" class="print"<c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>RDMS</button> <!-- RDMSo -->
<%--							<button type="button" id="btnRdmsExpriemCop" name="btnRdmsExpriemCop" onClick="callRDMSViwer(resultInputMGrid_Detail,'C');" class="print">${msg.C100000080}</button> <!-- RDMSc -->--%>
							<button id="btnReReq" name="btnReReq" class="save">${msg.C100001099} </button> <!-- 재분석 -->
							<button id="btnReturn" name="btnReturn" class="save" <c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>${msg.C100000152} </button> <!-- 결과회수 -->
							<button type="button" id="btnSave" name="btnSave" class="save">${msg.C100000688}</button> <!-- 임시 저장 -->
							<button type="button" id="btnComplete" name="btnComplete" class="save">${msg.C100001261}</button> <!-- 결과입력 완료 -->
						</div>
					</div>
					<div class="subCon1 mgT30">
						<form id="calcLawMFrm" action="javascript:;">
							<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1">
								<colgroup>
									<col style="width:20%"></col>
									<col style="width:80%"></col>
								</colgroup>
								<tr>
									<th>${msg.C100000172}</th> <!-- 계산식 명 -->
									<td>
										<select id="calcLawSeqno" name="calcLawSeqno" class="wd100p">
											<option value="">${msg.C100000779}</option> <!-- 전체 -->
										</select>
									</td>
								</tr>
								<tr>
									<th>${msg.C100000524}</th> <!-- 수식 -->
									<td>
										<!-- 수식 -->
										<input type="text" id="nomfrmCn" name="nomfrmCn" class="wd100p" readonly/>

										<!-- 변수명  -->
										<input type="hidden" id="vriablId" name="vriablId">
										<!-- 수식 명 -->
										<input type="hidden" id="calcLawNm" name="calcLawNm">
										<!-- 역산 식 -->
										<input type="hidden" id="rvsopCn" name="rvsopCn" readonly>
										<!-- 표기자리수 -->
										<input type="hidden" id="markCphr" name="markCphr" readonly>
										<!-- 소수점 랜덤 계산 여부 -->
										<input type="hidden" id="rvsopCphrRandomCreatAt" name="rvsopCphrRandomCreatAt" readonly>
									</td>
								</tr>
							</table>
						</form>
					</div>
					<div class="subCon2">
						<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
						<div id="calcLawGrid" class="grid" style="height:300px;"></div>
					</div>
				</div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.rowStyle-red{
				background-color : #FF9999
			}
			.rowStyle-sky{
				background-color : #A1D0FF
			}
		</style>
		<script>
			$(function(){

				getAuth(); //권한 체크

				setCombo().then(function(){

					setResultInputMGrid();  //그리드 생성

					setResultInputMGridEvent(); //그리드 이벤트

					setButtonEvent();//버튼 이벤트

					setEtcEvent();
				});//콤보박스 셋팅


			});
		</script>
		<script>
			var resultInputMGrid_Master = "resultInputMGrid_Master", //의뢰목록 그리드
					resultInputMGrid_Detail = "resultInputMGrid_Detail", //시험항목 목록 그리드
					calcLawGrid = "calcLawGrid", //계산식 그리드
					selectReq = {}; //선택한 의뢰 정보
			var lang = ${msg}; //기본언어
			//시험항목 목록 그리드에 단위 콤보 리스트
			var unitList = new Array();
			//시험항목 목록 그리드에 장비 콤보 리스트
			var eqpmnList = new Array();
			//시험항목 목록에서 결과값,단위,기기명 수정시 계산식폼에 데이터와 결합하여 담아 놓는 변수
			var editSaveData = new Array();

			function setCombo(){

				ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03", "inCode" : "'IM03000003', 'IM03000004'"}, false, null, "IM03000003");
				ajaxJsonComboBox('/rsc/getCustlabCombo.lims','custlabSeqnoSch',null,true);

				customAjax({
					"url" : "/com/getUnitListCombo.lims",
					"successFunc" : function(data){
						unitList = 	data;
					}
				});

				return customAjax({
					"url" : "/com/getEqpmnNmCombo.lims",
					"successFunc" : function(data){
						eqpmnList = data;
					}
				});

			};

			function setResultInputMGrid(){
				var columnLayout = {
					resultInputMasterCol : [],
					resultInputDetailCol : [],
					calcLawGridCol : []
				};

				auigridCol(columnLayout.resultInputMasterCol);
				columnLayout.resultInputMasterCol.addColumnCustom("reqestDeptCodeNm","${msg.C100000986}",null,true,false) /* 의뢰 부서 */
				.addColumnCustom("clientNm","${msg.C100000665}",null,true,false) //의뢰자
				.addColumnCustom("reqestDte","${msg.C100000659}",null,true,false) /* 의뢰일자 */
				.addColumnCustom("reqestNo","${msg.C100000657}",null,true,false) /* 의뢰 번호 */
				.addColumnCustom("inspctTyCodeNm","${msg.C100000139}",null,true,false) /* 검사 유형 */
				.addColumnCustom("custlabNm","${msg.C100001352}",null,true,false) /* 분석실 */
				.addColumnCustom("prductSeCodeNm","${msg.C100000807}",null,true,false) /* 제품 구분 */
				.addColumnCustom("mtrilNm","${msg.C100000717}",null,true,false) /* 제품명 */
				.addColumnCustom("mnfcturDte","${msg.C100000803}",null,true,false) /* 제조 일자 */
				.addColumnCustom("sploreNm","${msg.C100001353}",null,true,false) /* 시료 정보 */
				.addColumnCustom("elctcQy","${msg.C100001354}",null,true,false) //충전량
				.addColumnCustom("elctcCn","${msg.C100001355}",null,true,false) // 충전정보
				.addColumnCustom("entrpsNm","${msg.C100000187}",null,false,true) // 고객사
				.addColumnCustom("prductDc","${msg.C100001356}",null,true,false) // 제품설명
				.addColumnCustom("rm","${msg.C100001357}",null,true,false); // 특이사항

				var colStyle = {
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {

						if(dataField == "resultValue" && item.lastExprOdrAt == "Y"){

							//판정코드가 부적합이면 적색으로 표시
							if(item["jdgmntWordCode"] == "IM05000002"){
								return "rowStyle-red";
							}

							//삭제여부가 N이고 최대차수이면 하늘색으로 표시
							if(item["deleteAt"] == "N"){
								return "rowStyle-sky";
							}
						}

						return null;
					},
					editRenderer : {
						type : "InputEditRenderer",
						validator : function(oldValue, newValue, rowItem, dataField) {
							if(dataField == "resultValue"){
								var deleteAt = rowItem["deleteAt"];
								var rdmsAt = rowItem["rdmsRegistAt"];
								var lasAt = rowItem["lasRegistAt"];

								if(!deleteAt || deleteAt == "Y"){
									return { "validate" : false, "message"  : "${msg.C100001062}" };	//값을 입력 할 수 없습니다.
								}

								if(lasAt && lasAt == "Y"){
									return { "validate" : false, "message" : "${msg.C100001125}"} //LAS로 등록된 결과는 수정할 수 없습니다.
								}

								if(rdmsAt && rdmsAt == "Y"){
									return { "validate" : false, "message" : "${msg.C100001125}"} //RDMS로 등록된 결과는 수정할 수 없습니다.
								}

								//불검출일때는 문자가 들어가줘야함.
								if(newValue.toUpperCase() != "N.A." && rowItem["jdgmntFomCode"] == "IM06000001" && isNaN(newValue)){
									return { "validate" : false, "message" : "${msg.C100001127}"} //판정 구분이 '최대/최소'이면 숫자만 입력 가능합니다.
								}
							}
						}
					}
				}

				var validator = {
					editRenderer : {
						type : "InputEditRenderer",
						validator : function(oldValue, newValue, rowItem, dataField) {
							var rdmsAt = rowItem["rdmsDocNo"];
							var lasAt = rowItem["lasRegistAt"];
							var bassValue = rowItem["bassValue"];

							if(rdmsAt){
								return { "validate" : false, "message" : "${msg.C100001125}"} //RDMS로 등록된 결과는 수정할 수 없습니다.
							}

							if(lasAt && lasAt == "Y"){
								return { "validate" : false, "message" : "${msg.C100001125}"} //LAS로 등록된 결과는 수정할 수 없습니다.
							}

							if(bassValue){
								return { "validate" : false, "message" : "기본값은 수정할 수 없습니다."}
							}
						}
					}
				}


				auigridCol(columnLayout.resultInputDetailCol);
				columnLayout.resultInputDetailCol.addColumn("reqestNo", "${msg.C100000657}","*",true,null,null,null,null,null,true) /* 의뢰번호 */
						.addColumn("expriemNm", "${msg.C100000560}","*",true, false) /* 시험항목 명 */
						.addColumn("exprOdr", "${msg.C100001116}","*",true, false) /* 차수 */
						.addColumn("lclUcl", "${msg.C100001096}","*",true,false) /* LCL / UCL */
						.addColumnCustom("resultValue", "${msg.C100000150}","*",true,true, colStyle) /* 결과값 */
						.addColumn("rdmsRegistAt", "${msg.C100001288}","*",false,true) /* RDMS등록여부 */
						.addColumn("unitSeqno", "${msg.C100000268}","*",true) /* 단위 */
						.addColumn("resultRegistDte", "${msg.C100000151}","*",true,true) /* 결과 입력일자 */
						.addColumn("eqpmnSeqno", "${msg.C100000736}","*",true) /* 장비 */
						.dropDownListRenderer(["unitSeqno"], unitList, true)
						.dropDownListRenderer(["eqpmnSeqno"], eqpmnList, true)
						.calendarRenderer(["resultRegistDte"]);

				//계산식 목록 그리드
				auigridCol(columnLayout.calcLawGridCol);
				columnLayout.calcLawGridCol.addColumnCustom("vriablId","${msg.C100000391}",null,true,false,null) /* 변수 ID */
						.addColumnCustom("vriablNm","${msg.C100000389}",null,true,false) /* 변수 명 */
						.addColumnCustom("vriablValue","${msg.C100000150}",null,true,true,validator) /* 결과 값 */
						.addColumnCustom("vriablUnitNm","${msg.C100000388}",null,true,false) /* 변수 단위 명 */
						.addColumnCustom("bassValue","${msg.C100000230}","*",null,true,false) /* 기본 값 */
						.addColumnCustom("markCphr","${msg.C100000940}",null,true,false) /* 표기 자리수 */
						.addColumnCustom("vriablDc","${msg.C100000390}",null,true,false); /* 변수 설명 */

				var rowStyle = {
					//엑스트라체크박스 표시
					showRowCheckColumn : true,
					// 전체 체크박스 표시 설정
					showRowAllCheckBox : true,
					autoGridHeight : true,
					rowCheckDisabledFunction : function(rowIndex, isChecked, item) {
						//최종차수가 아니면 체크불가
						if(item.lastExprOdrAt != "Y"){
							return false;
						}

						return true;
					}
				}

				//그리드 생성
				resultInputMGrid_Master = createAUIGrid(columnLayout.resultInputMasterCol, resultInputMGrid_Master);
				resultInputMGrid_Detail = createAUIGrid(columnLayout.resultInputDetailCol, resultInputMGrid_Detail, rowStyle);
				calcLawGrid = createAUIGrid(columnLayout.calcLawGridCol, calcLawGrid);

				//시험항목 목록 그리드 컬럼 3개 고정시킴
				AUIGrid.setFixedColumnCount(resultInputMGrid_Detail, 2);

				//브라우저 창 사이즈 조절시 자동 그리드 크기 조정하는 기능
				gridResize([resultInputMGrid_Master, resultInputMGrid_Detail, calcLawGrid]);

				//의뢰목록 그리드 컬럼 width 조정
				AUIGrid.bind(resultInputMGrid_Master, "ready", function(event) {
					gridColResize(resultInputMGrid_Master,"2");
					if ( Object.keys(selectReq).length > 0 && !!selectReq.reqestSeqno ){
						gridSelectRow(resultInputMGrid_Master, "reqestSeqno", [selectReq.reqestSeqno]);
					}
				});

				//시험항목목록 그리드 컬럼 width 조정
				AUIGrid.bind(resultInputMGrid_Detail, "ready", function(event) {
					gridColResize(resultInputMGrid_Detail,"2");
				});

				//계산식 그리드 컬럼 width 조정
				AUIGrid.bind(calcLawGrid, "ready", function(event) {
					gridColResize(calcLawGrid,"2");
				});
			}

			function setResultInputMGridEvent(){
				/*			의뢰목록 그리드 관련 이벤트			*/
				//의뢰 목록 그리드 더블클릭 이벤트
				AUIGrid.bind(resultInputMGrid_Master, "cellDoubleClick", function(event){
					reset("expriem");
					var item = event.item;

					//선택된 의뢰의 정보를 담아 놓는다.
					//그리드를 한번 클릭하면 선택된 정보가 바껴서 값이 변경되는걸 방지하기 위함.
					selectReq = item;

					//더블클릭한 의뢰일련번호로 시험항목 조회
					getExpriemListSch(item.reqestSeqno);

					$("#rm").val(item.rm);

					editSaveData = [];
				});

				/*			시험항목목록 그리드 관련 이벤트			*/

				AUIGrid.bind(resultInputMGrid_Detail, "rowCheckClick", function(event){
					//장비 일련번호가 같은 항목들은 체크박스 선택시 일괄 체크/체크해제 해준다.
					if(event.checked){
						AUIGrid.addCheckedRowsByValue(resultInputMGrid_Detail, "eqpmnSeqno", event.item.eqpmnSeqno)
						AUIGrid.addUncheckedRowsByValue(resultInputMGrid_Detail, "lastExprOdrAt", "N")
					}else{
						AUIGrid.addUncheckedRowsByValue(resultInputMGrid_Detail, "eqpmnSeqno", event.item.eqpmnSeqno)
					}
				});

				AUIGrid.bind(resultInputMGrid_Detail, "rowAllCheckClick", function(event){
					AUIGrid.addUncheckedRowsByValue(resultInputMGrid_Detail, "lastExprOdrAt", "N");
				});

				AUIGrid.bind(resultInputMGrid_Detail, "cellClick", function(event){

					reset("calcLaw");
				});

				AUIGrid.bind(resultInputMGrid_Detail, "cellDoubleClick", function(event){
					if(event.item.lastExprOdrAt == "Y"){
						//editSaveData에 이미 들어간 데이터인지 체크해서 이미 담긴 컬럼이면 변수안에 내용을 폼에 뿌려주고 없으면 마스터에서 조회시킨다.
						var bool = chckEditData(event);
						if(!bool){
							getCalcFormProxy(event);
						}
					}
				});

				AUIGrid.bind(resultInputMGrid_Detail, "cellEditBegin", function(event){
					var lastExprOdrAt = event.item.lastExprOdrAt;

					if(lastExprOdrAt == "N"){
						return false;
					}

				});

				AUIGrid.bind(resultInputMGrid_Detail, "cellEditEnd", function(event){
					if(!event.value)
						return false;

					chkSdspcValue({
						"sResult" : event.value
						, "jdgmntFomCode" : event.item.jdgmntFomCode
						, "uclValue" : event.item.uclValue
						, "uclValueSeCode" : event.item.uclValueSeCode
						, "lclValue" : event.item.lclValue
						, "lclValueSeCode" : event.item.lclValueSeCode
						, "textStdr" : event.item.textStdr
					}, function(result){
						//판정 값을 row에 넣어줘야 판정과 데이터 담을때 값에 이상 없음.
						event.item["jdgmntWordCode"] = result;
						AUIGrid.setCellValue(resultInputMGrid_Detail, event.rowIndex, "jdgmntWordCode", result);
						if(!event.item.resultRegistDte){
							AUIGrid.setCellValue(resultInputMGrid_Detail, event.rowIndex, "resultRegistDte", currentDate());
						}

						//editSaveData에 데이터 담아두기
						editDataProxy(event.item);
					});
				});

				AUIGrid.bind(resultInputMGrid_Detail, "selectionConstraint", function(event){
					if(event.columnIndex > -1 && (event.columnIndex != event.toColumnIndex || event.rowIndex != event.toRowIndex)){
						AUIGrid.forceEditingComplete(calcLawGrid);
						AUIGrid.forceEditingComplete(resultInputMGrid_Detail);
					}
				});


				/*			계산식 폼 그리드 관련 이벤트			*/

				AUIGrid.bind(calcLawGrid, "cellEditEnd", function(event){
					revCombindeForm();
				});


			}

			//버튼 클릭 이벤트
			function setButtonEvent(){
				//의뢰 목록 조회 이벤트
				document.getElementById("btnSearch").addEventListener("click", function(e){
					//의뢰 목록 그리드 조회
					getReqestListSch(this);
				});

				document.getElementById("calcLawSeqno").addEventListener("change", function(e){
					if(!e.target.value){
						reset("calcLaw");
						return false;
					}

					//마스터 계산식 조회
					getCalcFormMasterInfo();

				});

				document.getElementById("btnSave").addEventListener("click", function(e){

					if(Object.keys(selectReq).length == 0){
						alert("${msg.C100000664}"); //의뢰를 먼저 선택해주세요.
						return false;
					}

					if(selectReq.progrsSittnCode != "IM03000003"){
						alert("진행상황이 '분석중'인 의뢰만 진행가능합니다.");
						return false;
					}

					//저장 버튼 누르기전에 수정중이 끝나지 않은 컬럼 에디트 종료 시키고 로직 태우기 위함.
					AUIGrid.forceEditingComplete(resultInputMGrid_Detail);

					if(editSaveData.length == 0 ){
						alert("${msg.C100000526}"); //수정 내역이 없습니다.
						return false;
					}

					if(!confirm("${msg.C100000764}")){ //저장하시겠습니까?
						return false;
					}

					//저장 로직 실행
					saveResultData(function(data,status,request){
						if(status == "success"){
							success("${msg.C100000765}"); //저장되었습니다.
							reset("calcLaw");
							editSaveData = [];
						}
					}, function(){
						reset("reqest");
						$("#btnSearch").click();
					});

				});

				document.getElementById("btnComplete").addEventListener("click", function(e){

					if(Object.keys(selectReq).length == 0 || AUIGrid.getGridData(resultInputMGrid_Detail).length == 0) { alert("${msg.C100000664}"); return false; } //의뢰를 먼저 선택해주세요.

					if(selectReq.progrsSittnCode != "IM03000003"){ alert("진행상황이 '분석중'인 의뢰만 진행가능합니다."); return false; }

					if(!confirm("결과입력을 완료하시겠습니까?")){
						return false;
					}

					$.when(
							saveResultData()
					).then(function() {

						var rows = AUIGrid.getGridData(resultInputMGrid_Detail);

						selectReq["editSaveData"] = rows.filter(function(e) {return e.lastExprOdrAt == "Y"});

						//결과입력 완료 로직
						completeResultInput();
					});

				});



				document.getElementById("btnReturn").addEventListener("click", function(e){
					if(Object.keys(selectReq).length == 0){
						alert("${msg.C100000664}"); //의뢰를 먼저 선택해 주세요.
						return false;
					}

					if(Object.keys(selectReq).length > 0 && selectReq.progrsSittnCode != "IM03000004"){
						alert("진행상황이 'ROA대기'인 의뢰만 진행가능합니다.");
						return false;
					}

					if(!confirm("${msg.C100001064}")){ //결과 회수를 진행하시겠습니까?
						return false;
					}

					//결과 회수 이벤트
					returnValue();
				});

				//기준규격 동기화 이벤트
				/*
					getEl("btnChangeNowData").event("click", function(e){
					var innerReqestSeqno = selectReq.reqestSeqno;
					var innerBplcCode = selectReq.bplcCode;


					if(!innerReqestSeqno){
						warn("${msg.C100000664}"); // 의뢰를 먼저 선택해주세요.
						return false;
					}

					if(confirm("변경하시겠습니까? ")){
						customAjax({
							"url": "/test/setChangeNowData.lims",
							"data" : {"reqestSeqno" : innerReqestSeqno, "bplcCode" : innerBplcCode, "type" : "Result"}
						}).then(function(data){
							success("${msg.C100001209}"); //현재값으로 수정되었습니다.
							getExpriemListSch(innerReqestSeqno);
						});

					}
				});*/

				$('input[name*="showExpriemSch"]').change(function() {
					if(Object.keys(selectReq).length > 0){
						editSaveData = [];
						getExpriemListSch(selectReq.reqestSeqno);
					}
				});

				$("#btnReReq").click(function(e){

					var rowsList = AUIGrid.getCheckedRowItems(resultInputMGrid_Detail).map(function(item){
						return item.item;
					});
					if(Object.keys(selectReq).length > 0 && selectReq.progrsSittnCode != "IM03000003"){
						alert("진행상황이 '분석중'인 의뢰만 진행가능합니다.");
						return false;
					}

					if(rowsList.length == 0){
						alert("${msg.C100001042}"); //시험항목을 선택해주세요.
						return false;
					}

					//재분석 이벤트
					changeNextOdr(rowsList);
				})

			}

			//재분석 이벤트
			function changeNextOdr(rowsList){
				customAjax({
					"url" : "/test/changeToNextOdr.lims",
					"data" : {
						"editSaveData" : rowsList
					},
					"successFunc" : function(data,status, request){
						if(status == "success"){
							success("${msg.C100001061}"); // 재분석이 완료되었습니다.
							reset("expriem");

							$("#btnSearch").click();

							if(Object.keys(selectReq).length > 0)
								getExpriemListSch(selectReq.reqestSeqno)
						}
					},
					"errorFunc" : function(){
						reset("expriem");
						$("#btnSearch").click();
					}
				});
			}

			//각종 이벤트 모음
			function setEtcEvent(){
				datePickerCalendar(["reqestBeginDte","reqestEndDte"]);//의뢰일자 조회조건
				datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-7], ["DD",0]);//제조일자 조회조건

				$(".schFunc").keypress(function(e){
					if (e.which == 13){
						$("#btnSearch").click();
					}
				});
			}

			//의뢰 목록 조회 이벤트
			function getReqestListSch(obj){
				if(!saveValidation("searchFrm")) {
					return;
				}

				reset("reqest");

				customAjax({
					"url" : "/test/getReqestListSch.lims",
					"data" : $("#searchFrm").serializeObject(),
					"elementIds" : [obj.id]
				}).then(function(data){
					AUIGrid.setGridData(resultInputMGrid_Master, data);
				});
			}

			//시험항목 목록 조회 이벤트
			function getExpriemListSch(reqestSeqno){
				reset("expriem");
				var param = $("#searchFrm").serializeObject();
				param.reqestSeqno = reqestSeqno;

				return customAjax({
					"url" : "/test/getExpriemListSch.lims",
					"data" : param
				}).then(function(data){
					if(data.length > 0){
						AUIGrid.setGridData(resultInputMGrid_Detail, data);
					}else{
						reset("expriem");
						$("#btnSearch").click();
					}

				});
			}

			//editData변수를 상태 관리하는 메소드
			function editDataProxy(item){
				//입력한 시험항목 데이터와 계산식 폼을 합치는 함수
				item = combineForm(item);

				//이미 담아 놓은 데이터인지 체크
				editDataCheck(item);
			}

			//이미 담아 놓은 데이터인지 체크
			function editDataCheck(compareRow){
				var state = false;

				//초,중,말 결과값 수정했을때 탐
				/*
                    결과값 입력과 단위,장비 입력을 나눠놓은 이유는
                    - 결과입력일자, 단위, 장비는 IM_REQEST_EXPRIEM 테이블에 들어가기때문에 초, 중, 말 에 모두 같은 값이 들어가야함.
                    ex) 초 결과값 수정 후 단위 값 입력 후 중 결과값 수정시 현재 로직으로는 초의 단위 값과 중의 단위 값이 달라서 결과적으론 값이 안맞을 수가 있음
                */
				editSaveData.forEach(function(row, index){
					//(입력한 컬럼이 같고 and 같은 시험항목 일련번호 and 같은 시험 횟수 ) 모두 일치하면 덮어쓰기
					if(row.reqestExpriemSeqno == compareRow.reqestExpriemSeqno){
						//같은 값잇으면 추가하지않고 덮어쓴다.
						editSaveData[index] = compareRow;

						//같은게 있으면 true, 없으면 false로 포문이 다 돌고 난후 editSaveData에 없던 값으로 생각하고 추가로 넣기 위함.
						state = true;
					}
				});


				if(!state && compareRow["lastExprOdrAt"] == "Y"){
					editSaveData.push(compareRow);
				}
			}

			//입력한 시험항목 결과값과 계산식 폼을 하나로 합치기 위한 함수
			function combineForm(event){
				var calcLawSeqno = $("#calcLawSeqno").val();
				var gridData = AUIGrid.getGridData(calcLawGrid);
				if(!!calcLawSeqno && gridData.length > 0){
					//계산식 상세 폼 obj
					var formObject = $("#calcLawMFrm").serializeObject();

					for(var key in formObject){event[key] = $("#" + key).val();}

					//계산식 그리드 리스트
					var calcGridList = AUIGrid.getGridData(calcLawGrid);
					event["calcItem"] = Object.assign(formObject, {"calcGridList" : calcGridList});
				}else{
					event["calcItem"] = null;
				};
				return event;
			}

			//계산식 폼을 수정완료하였을때 수식을 계산하고 판정 내는 기능
			function revCombindeForm(){
				var row = AUIGrid.getSelectedItems(resultInputMGrid_Detail)[0];

				calc(resultInputMGrid_Detail, calcLawGrid, "calcLawMFrm", row, function(data){
					//결과 값을 row에 넣어줘야 판정과 데이터 담을때 값에 이상 없음.
					row.item["resultValue"] = data;
					//계산한 결과에 대한 판정 내기
					chkSdspcValue({
						"sResult" : data
						, "jdgmntFomCode" : row.item.jdgmntFomCode
						, "uclValue" : row.item.uclValue
						, "uclValueSeCode" : row.item.uclValueSeCode
						, "lclValue" : row.item.lclValue
						, "lclValueSeCode" : row.item.lclValueSeCode
						, "textStdr" : row.item.textStdr
					}, function(result){
						//판정 값을 row에 넣어줘야 판정과 데이터 담을때 값에 이상 없음.
						row.item["jdgmntWordCode"] = result;
						AUIGrid.setCellValue(resultInputMGrid_Detail, row.rowIndex, "jdgmntWordCode", result);
						if(!row.item.resultRegistDte) {
							AUIGrid.setCellValue(resultInputMGrid_Detail, row.rowIndex, "resultRegistDte", currentDate());
						}
						//editSaveData에 데이터 담아두기
						editDataProxy(row.item);
					});
				})
			}

			//더블클릭한 시험항목 정보로 마스터 계산식 폼 조회하기
			function getCalcFormProxy(event){
				reset("calcLaw");

				if(event.dataField == "resultValue"){
					ajaxJsonComboBox("/wrk/getCalcLawCombo.lims", "calcLawSeqno", event.item, false, "전체", "").then(function(){
						//입력된 계산식이 있는 경우(시험항목 계산식에서 저장된 데이터 조회해옴)
						if(!!event.item["calcLawSeqno"]){
							getCalcFormTestInfo(event);
						}else{//입력된 계싼식이 없는 경우 (마스터 계산식 있는지 불러옴)
							getCalcFormMasterInfo(event);
						}

					});
				}
			};

			//계산식이 없을때 마스터 데이터로 계산식 폼 뿌리기
			function getCalcFormMasterInfo(event){
				//마스터에서 조회된 계산식이 1개뿐이라면 자동으로 선택 시켜준다.
				if(!!$("#calcLawSeqno").val()){
					getCalcMasterInfo();
				}else if($("#calcLawSeqno option").length == 2){
					$($("#calcLawSeqno option:selected").next()).attr("selected", "selected");
					getCalcMasterInfo();
				}
			}

			//마스터에서 계산식 상세 정보와 변수 리스트를 조회해와서 뿌림
			function getCalcMasterInfo(){
				var expriemRow = AUIGrid.getSelectedItems(resultInputMGrid_Detail)[0];

				customAjax({
					"url" : "/wrk/getCalcMasterInfo.lims",
					"data" : {"calcLawSeqno" : $("#calcLawSeqno").val(), "bplcCode" : expriemRow.item.bplcCode}
				}).then(function(data){
					//마스터 디테일 정보 뿌리기
					detailAutoSet({
						"item" : data,
						"targetFormArr" : ["calcLawMFrm"]
					});

					getEl("calcLawNm").value = data.calcLawNm;

					//계산식 변수 리스트 뿌리기
					AUIGrid.setGridData(calcLawGrid, data.list);
				});
			}

			//계산식이 있을때 저장된 계산식 데이터로 폼에 뿌리기
			function getCalcFormTestInfo(event){
				var item = event.item;

				//데이터 폼에 뿌리기
				detailAutoSet({
					"item" : item,
					"targetFormArr" : ["calcLawMFrm"]
				});

				customAjax({
					"url" : "/test/getExpriemCalcNomfrm.lims",
					"data" : item
				}).then(function(data){
					AUIGrid.setGridData(calcLawGrid, data);
				});

			}

			//editSaveData에 담아 놓은 값이 있는지 체크하는 함수
			//담아 놓은 값이 있으면 디비에서 데이터를 호출해오는 것이 아니라 editSaveData에 있는 값을 계산식 폼에 뿌려줌
			//이미 수정햇다가 다시 수정하는 경우라 판단되는데 디비에서 새로 조회해오면 기존 수정한 값은 없다.
			function chckEditData(compareRow){
				var bool = false;
				if(editSaveData.length > 0){
					ajaxJsonComboBox("/wrk/getCalcLawCombo.lims", "calcLawSeqno", compareRow.item, false, "전체", "")
					.then(function(result){
						editSaveData.some(function(row, index){
							//(입력한 컬럼이 같고 and 같은 시험항목 일련번호) 모두 일치하면 editSaveData에서 계싼식 폼에 데이터 뿌려줌
							if(row.item.reqestExpriemSeqno == compareRow.item.reqestExpriemSeqno){
								if(!!row["calcItem"]){
									detailAutoSet({
										"item" : row["calcItem"],
										"targetFormArr" : ["calcLawMFrm"]
									});

									AUIGrid.setGridData(calcLawGrid, row.calcItem.calcGridList);
								}
								bool = true;
								return true;
							}
						});
					});

				}

				return bool;
			};

			function reset(type){
				switch(type){
					case "calcLaw":
						pageReset(["calcLawMFrm"], [calcLawGrid], null);
						break;
					case "expriem":
						pageReset(["calcLawMFrm"], [resultInputMGrid_Detail, calcLawGrid], null);
						break;
					case "reqest":
						pageReset(["calcLawMFrm"], [resultInputMGrid_Master, resultInputMGrid_Detail, calcLawGrid], null);
						break;
					default :
						break;
				}
			}

			//저장 이벤트
			function saveResultData(callBack, errorFunc){

				var param = new Object();

				Object.assign(param, selectReq, {"editSaveData" : editSaveData});

				return customAjax({
					"url" : "/test/saveExpriemResult.lims",
					"data" : param,
					"successFunc" : callBack,
					"errorFunc":errorFunc
				});
			}

			//결과회수 이벤트
			function returnValue(){
				customAjax({
					"url" : "/test/returnExpriem.lims",
					"data" : {"reqestSeqno" : selectReq.reqestSeqno},
					"successFunc" : function(data, status, request){
						if(status == "success"){
							success("${msg.C100000762}."); //저장되었습니다.

							getExpriemListSch((Object.keys(selectReq).length == 0) ? null : selectReq.reqestSeqno);
						}
					},
					"errorFunc" : function(){
						reset("expriem");

						$("#btnSearch").click();
					}
				});
			}

			function completeResultInput(){
				customAjax({
					"url" : "/test/completeResultInput.lims",
					"data" : selectReq,
					"successFunc" : function(data,status,request){

						if(status == "success"){
							success("${msg.C100000762}") //저장되었습니다.
							reset("expriem");

							selectReq = {};
							editSaveData = [];
							$("#btnSearch").click();
						}
					},
					"errorFunc" : function(){
						reset("reqest");
						$("#btnSearch").click();
					}
				})
			}
		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
