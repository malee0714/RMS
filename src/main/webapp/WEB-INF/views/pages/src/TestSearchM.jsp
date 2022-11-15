<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		<div class="subContent" style=height:auto;>
			<div class="subCon1">
				<form action="javascript:;" id="searchFrm" name="searchFrm">
					<h2><i class="fi-rr-apps"></i>${msg.C100001117} <!-- 시험 현황 조회 -->
					</h2>
					<div class="btnWrap">
						<button type="button" id="btnBeforeRabelPrint" hidden></button> <%-- 바코드 출력 버튼 클릭 전 실행 함수 --%>
						<button type="button" id="btnRequestRabelPrint" class="print" style="display: none">${msg.C100000339}</button> <!-- 바코드 출력 -->
						<button id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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

			<div class="subCon2 mgT15">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="resultInputMGrid_Master" style="width: 100%; height: 300px; margin: 0 auto;" class="mgT15 grid"></div>
			</div>
			<!-- 	<div class="mapkey"> -->
				<%-- 		<label class="scarce">${msg.C100001128}</label> <!-- [부적합] --> --%>
			<!-- 	</div> -->
			<c:if test="${UserMVo.auditAt == 'N'}">

				<div class="subCon1 mgT10">
					<div class="mapkey">
						<label class="invalid">${msg.C100001128}</label> <!-- [부적합] -->
					</div>
				</div>

			</c:if>
			<div class="subCon1 mgT20">

				<form action="javascript:;" id="searchExpriemFrm" name="searchExpriemFrm">
					<div class="btnWrap" style="position: relative; float: right;">
						<button type="button" id="btnRdmsExpriemOrg" name="btnRdmsExpriemOrg" onClick="callRDMSViwer(requestDtlGrid,'O');" class="print"<c:if test="${UserMVo.auditAt == 'Y'}"> style="display:none;" </c:if>>RDMS</button> <!-- RDMSo -->
<%--						<button type="button" id="btnRdmsExpriemCop" name="btnRdmsExpriemCop" onClick="callRDMSViwer(requestDtlGrid,'C');" class="print">${msg.C100000080}</button> <!-- RDMSc -->--%>
					</div>
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:10%"></col>
							<col style="width:15%"></col>
							<col style="width:10%"></col>
							<col style="width:15%"></col>
							<col style="width:10%"></col>
							<col style="width:45%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000187}</th> <!-- 고객사 -->
							<td>
								<select class="wd100p schClass" name="entrpsSeqno" id="srchEntrpsSeqno">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
								</select>
								<input type="hidden" id="reqestSeqno" name="reqestSeqno">
								<input type="hidden" id="ctmmnyOthbcAt" name="ctmmnyOthbcAt">

							</td>
							<th>${msg.C100000471}</th> <!-- 상위 Lot -->
							<td>
								<input type="checkbox" id="upperLotIdChk" name="upperLotIdChk" class="wd10p"/>
								<select id="reqestDeptCodeExpriemSch" name="reqestDeptCodeExpriemSch" class="wd80p" disabled>
									<option>${msg.C100000779}</option>
								</select>
							</td>
							<th id="lastExprOdrTr">${msg.C100001118}</th> <!-- 최종 차수 조회 -->
							<td id="lastExprOdrTd" colspan="3" style="text-align: left;">
								<label><input type="radio" id="showExpriemAll" name="showExpriemSch" value="Y">${msg.C100000779} </label><!-- 전체 -->
								<label><input type="radio" id="showExpriemLast" name="showExpriemSch" value="N" checked>${msg.C100001119} </label><!-- 최종 -->
							</td>
							<td id="lastExprOdrTd2" colspan="4"></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2 mgT20">
				<h2 style="display:inline-block"><i class="fi-rr-apps"></i>${msg.C100000565}</h2> <!-- 시험항목 정보 -->
				<div id="requestDtlGrid" class="mgT10 grid" style="min-height: 520px;"></div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.rowStyle-red{
				background-color : #FF9999;
			}

			.rowStyle-sky{
				background-color : #a1d0ff;
			}

			.rowStyle-lightGreen{
				background-color : #8fdf82;
			}

		</style>
		<script>


			$(function(){

				setCombo();//콤보박스 셋팅

				setResultInputMGrid();  //그리드 생성

				setResultInputMGridEvent(); //그리드 이벤트

				gridResize([resultInputMGrid_Master,requestDtlGrid]);

				setButtonEvent();//버튼 이벤트

				setEtcEvent();

				//의뢰에서 사용하는 mrd 리스트 셋업
				customAjax({
					'url': '/com/printCours.lims',
					'data': { lblDcOutptAtVal : 'Y', printngSeCode : 'SY15000001' },
					'successFunc': function(data) {
						printingCoursArr = data;
					}
				});

				//바코드 QR코드 아래에 들어가는 샘플 정보 값 설정
				dialogBarcodeSampleVal('btnBeforeRabelPrint', 'BarcodeSample', function(item) {
					var mrdArr = [];
					var paramArr = [];
					var chkRequestGridData = AUIGrid.getCheckedRowItemsAll(resultInputMGrid_Master);
					for(var i = 0; i < chkRequestGridData.length; i++) {
						mrdArr.push(printingCoursArr[1].printngCours);
						paramArr.push(chkRequestGridData[i].reqestSeqno);
						if(chkRequestGridData[i].lblDcOutptAt == 'Y') {
							mrdArr.push(printingCoursArr[0].printngCours);
							paramArr.push(chkRequestGridData[i].reqestSeqno);
						}
					}
					//item : 사용자가 설정한 item 값
					html5ViewerRequest(mrdArr, paramArr, item);
				});

			});
		</script>
		<script>
			//로그인 사용자의 고객사 여부
			var auditAt = "${UserMVo.auditAt}";
			var resultInputMGrid_Master = "resultInputMGrid_Master"; //의뢰목록 그리드
			var requestDtlGrid = "requestDtlGrid"; // 시험항목 정보 그리드
			var lang = ${msg}; //기본언어
			var printingCoursArr = []; //출력물 리스트

			function setCombo(){
				ajaxJsonComboBox('/com/getDeptCombo.lims',"processTyCodeSch",{"upperCmmnCode" : "SY02"},true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03"}, true, null);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true);
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{'bestInspctInsttCode':'${UserMVo.bestInspctInsttCode}'},true);
				ajaxJsonComboBox("/com/getCmmnCode.lims", "processTyElseCodeSch",{"upperCmmnCode" : "IM14"}, true, null);
				ajaxJsonComboBox('/com/getDeptCombo.lims',"reqestSeCodeSch",{"upperCmmnCode" : ($("#userAuthor").val() != "N" && $("#userAuthor").val() != "H")? "IM01" : null},true);
				ajaxJsonComboBox('/rsc/getCustlabCombo.lims','custlabSeqnoSch',null,true);
				ajaxJsonComboBox('/com/getDeptCombo.lims','reqestBplcCodeSch',{ 'bestInspctInsttAt' : 'Y' }, true).then(function(){
					$('#reqestBplcCodeSch').val('${UserMVo.bestInspctInsttCode}');
					$('#reqestBplcCodeSch option').not(':selected').prop('disabled',('${UserMVo.authorSeCode}' != 'SY09000001'));
				});
			}

			function setResultInputMGrid(){
				var columnLayout = {
					resultInputMasterCol : [],
					requestDtlGrid : []
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
						.addColumnCustom("vendorLotNo","협력사 Lot No.",null,true,false) /* 협력사 Lot No. */
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
					}
				}

				var colStyle2 = {
					styleFunction :  function(rowIndex, columnIndex, value, headerText, item, dataField) {
						if(item.exprOdr != "0"){
							return "rowStyle-lightGreen";
						}
						return null;
					}
				}


				auigridCol(columnLayout.requestDtlGrid);
				columnLayout.requestDtlGrid.addColumn("reqestSeqno", "reqestSeqno","*",false,false)
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
				.addColumnCustom("qcResultValue", "QC ${msg.C100000150}","*",true,true, colStyle) /* 결과값 */
				.addColumn("lastChangerNm", "${msg.C100000385}","*",true) /* 변경자 */
				.addColumn("progrsSittnCodeNm", "${msg.C100000846}","*",true); /* 진행 상황 */


				var rowStyle = {
					rowStyleFunction : function(rowIndex, item) {
						//부적합 색상
						if(item.jdgmntWordCode=="IM05000002"){
							return "rowStyle-red";
						}

						return "";
					},
					//엑스트라체크박스 표시
					showRowCheckColumn : true,
					// 전체 체크박스 표시 설정
					showRowAllCheckBox : false
				}

				var customPros = {
					"editable" : false,
					//엑스트라체크박스 표시
					showRowCheckColumn : true,
					// 전체 체크박스 표시 설정
					showRowAllCheckBox : true,
					autoGridHeight : true

				};

				resultInputMGrid_Master = createAUIGrid(columnLayout.resultInputMasterCol, resultInputMGrid_Master, rowStyle);
				requestDtlGrid = createAUIGrid(columnLayout.requestDtlGrid ,requestDtlGrid ,customPros);


				AUIGrid.bind(resultInputMGrid_Master, "ready", function(event) {
					gridColResize(resultInputMGrid_Master,"2");
				});

				AUIGrid.bind(requestDtlGrid, "ready", function(event) {
					gridColResize(requestDtlGrid,"2");
				});
			}

			function setResultInputMGridEvent(){
				//************의뢰 그리드 관련  그리드 이벤트************
				AUIGrid.bind(resultInputMGrid_Master, "cellDoubleClick", function(event){
					var item = event.item;

					getEl("reqestSeqno").value = item.reqestSeqno;
					getEl("ctmmnyOthbcAt").value = item.ctmmnyOthbcAt//CTMMNY_OTHBC_AT
					ajaxJsonComboBox("/test/getEntrpsList.lims","srchEntrpsSeqno", item, true);
					ajaxJsonComboBox('/src/getUpperLotId.lims','reqestDeptCodeExpriemSch',item,false,"${msg.C100000779}")
					.then(function(){
						innerSetGridData(item.reqestSeqno);
					});

				});
			}

			//버튼 클릭 이벤트
			function setButtonEvent(){
				//조회 버튼 이벤트
				document.getElementById("btnSearch").addEventListener("click",function(){
					getReqestListSch();
				});

				$('input[name*="showExpriemSch"]').change(function() {
					innerSetGridData(getEl("reqestSeqno").value);
				});

				getEl("upperLotIdChk").event("change", function(){
					var upperReqestSeqno = getEl("reqestDeptCodeExpriemSch").value;
					if(getEl("upperLotIdChk").checked){
						getEl("reqestDeptCodeExpriemSch").disabled = false;
						if(!upperReqestSeqno){
							var selectedItems = AUIGrid.getSelectedItems(resultInputMGrid_Master);
							getEl("reqestSeqno").value = selectedItems[0].item.reqestSeqno;
							innerSetGridData(getEl("reqestSeqno").value);
						}else{
							getEl("reqestSeqno").value = getEl("reqestDeptCodeExpriemSch").value;
						}
					}else{
						getEl("reqestDeptCodeExpriemSch").disabled = true;
						var selectedItems = AUIGrid.getSelectedItems(resultInputMGrid_Master);
						getEl("reqestSeqno").value = selectedItems[0].item.reqestSeqno;
						innerSetGridData(getEl("reqestSeqno").value);
					}
				});

				//시험항목 조회조건인 고객사 selectbox 이벤트
				$("#srchEntrpsSeqno").change(function(){
					getEl("upperLotIdChk").dispatchEvent(new Event("change"))
				});


				getEl("reqestDeptCodeExpriemSch").event("change", function(){
					var upperReqestSeqno = getEl("reqestDeptCodeExpriemSch").value;
					if(!upperReqestSeqno){
						var selectedItems = AUIGrid.getSelectedItems(resultInputMGrid_Master);
						getEl("reqestSeqno").value = selectedItems[0].item.reqestSeqno;
						innerSetGridData(getEl("reqestSeqno").value);
					}else{
						getEl("reqestSeqno").value = getEl("reqestDeptCodeExpriemSch").value;
						innerSetGridData(getEl("reqestSeqno").value);
					}

				});

				document.getElementById("btnRequestRabelPrint").addEventListener('click', function() {
					if (AUIGrid.getCheckedRowItemsAll(resultInputMGrid_Master).length > 0) {
						document.getElementById('btnBeforeRabelPrint').click();
					} else {
						alert('${msg.C100000664}'); //의뢰를 먼저 선택해 주세요.
					}
				});
			}

			//각종 이벤트 모음
			function setEtcEvent(){
				datePickerCalendar(["reqestBeginDte","reqestEndDte"],false);//의뢰일자 조회조건
				datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-30], ["DD",0]);//제조일자 조회조건
				if($("#userAuthor").val() == "N"){
					$("#lastExprOdrTr").css("display", "none");
					$("#lastExprOdrTd").css("display", "none");
					$("#lastExprOdrTd2").css("display", "table-cell");
				}
				else{
					$("#lastExprOdrTr").css("display", "table-cell");
					$("#lastExprOdrTd").css("display", "table-cell");
					$("#lastExprOdrTd2").css("display", "none");
				}
				//[검색폼] 의뢰팀 사업장 변경 시 의뢰팀 리로드
				$('#reqestBplcCodeSch').change(function() {
					var selectBplcCode = this.value;
					if (!!selectBplcCode) {
						ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{'bestInspctInsttCode':selectBplcCode},true);
					}
				});
			}

			//*************조회 / 저장*******************//
			function getReqestListSch(){//의뢰 목록 조회

				if(!saveValidation('searchFrm')){ return false; }
				ajaxJsonForm("/src/getReqestList.lims", "searchFrm", function(result){
					AUIGrid.setGridData(resultInputMGrid_Master, result);
				});
			}

			function reset(){
				AUIGrid.clearGridData(resultInputMGrid_Master);
			}

			//내부 그리드 세팅
			function innerSetGridData(reqestSeqno){
				var data = $("#searchFrm").serializeObject();//의뢰 조회 조건
				data["reqestSeqno"] = reqestSeqno;//조회할 의뢰 일련번호
				Object.assign(data, $("#searchExpriemFrm").serializeObject()); //시험항목 조회 조건
				var bool = getEl("upperLotIdChk").checked;

				customAjax({
					'url':'/src/getExpriemListSch.lims',
					'data':data,
					'successFunc':function(event) {
						AUIGrid.setGridData(requestDtlGrid, event);
					}
				});

			};
		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
