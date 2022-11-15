<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title"></tiles:putAttribute>
    <tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000173}</h2> <!-- 계산식 목록 -->
				<div class="btnWrap">
					<button id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm" name="searchFrm" onSubmit="return false;">
					<table class="subTable1" style="width:100%;">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000722}</th> <!-- 자재 유형 -->
							<td><select name="mtrilTyCodeSch" id="mtrilTyCodeSch"></select></td>
							<th>${msg.C100000717}</th> <!-- 자재 명 -->
							<td><input type="text" name="mtrilNmSch" id="mtrilNmSch" class="schClass" ></td>
							<th>${msg.C100000725}</th> <!-- 자재코드 -->
							<td><input type="text" name="mtrilCodeSch" id="mtrilCodeSch" class="schClass" ></td>
							<th>${msg.C100000172}</th> <!-- 계산식 명 -->
							<td><input type="text" id="calcLawNmSch" name="calcLawNmSch" class="schClass"></td>
						</tr>
						<tr>
							<th>${msg.C100000560}</th> <!-- 시험항목 명 -->
							<td><input type="text" name="expriemNmSch" id="expriemNmSch" class="schClass"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;" colspan="3">
								<label><input type="radio" name="useSch" id="useSchAll" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useSch" id="useSchY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useSch" id="useSchN" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="mgT15">
				<div id="calcLawMGrid" style="height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100000176}</h2> <!-- 계산식 상세 정보 -->
				<div class="btnWrap">
					<button id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
					<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<form id="calcLawFrm" name="calcLawFrm" onSubmit="return false;" style="margin-top: 10px;">
					<table class="subTable1" style="width:100%;">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<th class="necessary">${msg.C100000716}</th> <!-- 자재 -->
							<td>
								<input type="text" name="mtrilNm" id="mtrilNm" class="wd63p" readonly>
								<input type="hidden" name="mtrilSeqno" id="mtrilSeqno">
								<button id="btnPrductSearch" type="button" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
								<button type="button" id="prductReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
							</td>
							<th class="necessary">${msg.C100000555}</th> <!-- 시험항목 -->
							<td>
								<select id="expriemSeqno" name="expriemSeqno" required>
									<option value=''>${msg.C100000480}</option> <!-- 선택 -->
								</select> 
							</td>
							<th class="necessary">${msg.C100000172}</th> <!-- 계산식 명 -->
							<td><input type="text" name="calcLawNm" id="calcLawNm" maxlength="200"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" id="useN" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000524}</th> <!-- 수식 -->
							<td colspan="3"><input type="text" name="nomfrmCn"  id="nomfrmCn" class="wd100p" maxlength="4000"></td>
							<th>${msg.C100000940}</th> <!-- 표기자리수 -->
							<td><input type="text" name="markCphr" id="markCphr" maxlength="10"></td>
							<th>${msg.C100000525}</th> <!-- 수식결과 -->
							<td><input type="text" name="calcResult" id="calcResult" readonly></td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100001036}</th> <!--역산 변수 명 -->
							<td><input type="text" name="vriablId" id="vriablId" style="text-transform: uppercase;" maxlength="32"></td>
							<th>${msg.C100000603}</th> <!-- 역산 -->
							<td><input type="text" name="rvsopCn"  id="rvsopCn" class="wd100p" maxlength="4000"></td>
							<th>${msg.C100000606}</th> <!-- 역산결과(A00) -->
							<td><input type="text" name="rvsopCalcResult" id="rvsopCalcResult"></td>
							<th>${msg.C100000511}</th> <!-- 소수점 자동생성 여부 -->
							<td><input type="checkbox" name="rvsopCphrRandomCreatAt" id="rvsopCphrRandomCreatAt" value="N"></td>
						</tr>
					</table>
					<input type="text" name="calcLawSeqno" id="calcLawSeqno" style="display:none"/>
				</form>
			</div>
			<div class="subCon1 mgT20">
				<h3>${msg.C100000174}</h3> <!-- 계산식 변수 상세정보 -->
				<div class="btnWrap">
					<button id="btnAddRow" type="button" class="btn5"><img src="/assets/image/plusBtn.png"></button>
					<button id="btnRemoveRow" class="delete"><img src="/assets/image/minusBtn.png"></button>
				</div>
			</div>
			<div class="mgT15">
				<div id="calcNomfrmVriablGrid" style="width:100%; height:285px; margin:0 auto;"></div>
			</div>
		</div>
    </tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var lang = ${msg}; // 기본언어
			var searchFrm = 'searchFrm';
			var calcLawFrm = 'calcLawFrm';
			var calcLawMGrid = 'calcLawMGrid';
			var calcNomfrmVriablGrid = 'calcNomfrmVriablGrid';
			var sessionObj = {
				bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}",
				deptCode : "${UserMVo.deptCode}"
			};

			$(function(){

				setGrid();

				setGridEvent();

				setButtonEvent();

				setCombo();

				var mtrilData = {
						bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
						authorSeCode : '${UserMVo.authorSeCode}'
				};

				//자재 찾기 팝업창 세팅
				dialogMtril("btnPrductSearch", "RequestM", "Product", null, function(item){
					$("#mtrilSeqno").val(item[0].mtrilSeqno);
					$("#mtrilNm").val(item[0].mtrilNm);
					$("#mtrilSeqno").change();
					$("#expriemSeqno").val('');
					expriemCombo();

					
				},sessionObj);

				gridResize([ calcLawMGrid, calcNomfrmVriablGrid ]);

			});

			function setGrid(){

				var calcLawCol = [];
				auigridCol(calcLawCol);

				var exprMthCalcCol = [];
				auigridCol(exprMthCalcCol);

				//필수 헤더
				var exprMthCalcGridColRequirePros = {
					style : "my-require-style",
					headerTooltip : { // 헤더 툴팁 표시 일반 스트링
						show : true,
						tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
					}
				};

				var resultValueColPros = {
					style : "my-require-style",
					headerTooltip : { // 헤더 툴팁 표시 일반 스트링
						show : true,
						tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
					},
					editRenderer : {
						type : "ConditionRenderer", // 조건에 따라 editRenderer 사용하기. conditionFunction 정의 필수
						// 컨디션함수는 자주 호출됩니다. 따라서 여기서 DOM 탐색 또는 jQuery 객체 만들기 등은 하지 마십시오.
						conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {
							// 특정 조건에 따라 미리 정의한 editRenderer 반환.
							if(!isNaN(item.markCphr)) {
								return {
									type : "InputEditRenderer",
									onlyNumeric : true, // 0~9만 입력가능
									allowPoint : true, // 소수점( . ) 도 허용할지 여부
									allowNegative : true, // 마이너스 부호(-) 허용 여부
									textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
									autoThousandSeparator : true // 천단위 구분자 삽입 여부
								};
							}
						}
					}
				}

				var checkboxprop = {
					renderer : {
						type : "CheckBoxEditRenderer",
						editable : true, 	// 체크박스 편집 활성화 여부(기본값 : false)
						checkValue : "Y", // true, false 인 경우가 기본
						unCheckValue : "N",
						//사용자가 체크 상태를 변경하고자 할 때 변경을 허락할지 여부를 지정할 수 있는 함수 입니다.
						checkableFunction :  function(rowIndex, columnIndex, value, isChecked, item, dataField ) {
							var rowCount = AUIGrid.getRowCount(calcNomfrmVriablGrid);
							AUIGrid.updateRowBlockToValue(calcNomfrmVriablGrid, 0, rowCount-1, "dataChangeAt", "N");
							return true;
						}
					}
				}

				calcLawCol.addColumnCustom("calcLawNm","${msg.C100000172}",null,true) //계산식명
				.addColumnCustom("mtrilNm","${msg.C100000717}",null,true) //자재명
				.addColumnCustom("mtrilCode","${msg.C100000725}",null,true) //자재코드
				.addColumnCustom("expriemNm","${msg.C100000560}",null,true) //시험항목 명
				.addColumnCustom("nomfrmCn","${msg.C100000524}",null,true) //수식
				.addColumnCustom("rvsopCn","${msg.C100000603}",null,true); //역산

				exprMthCalcCol.addColumnCustom("vriablId","${msg.C100000391}",null,true,false,null) //변수ID
				.addColumnCustom("vriablNm","${msg.C100000389}",null,true,true,exprMthCalcGridColRequirePros) //변수명
				.addColumnCustom("vriablUnitNm","${msg.C100000388}",null,true,true) //변수 단위명
				.addColumnCustom("bassValue","${msg.C100000230}",null,true,true) //기본값
				.addColumnCustom("vriablDc","${msg.C100000390}",null,true,true) //변수설명
				.addColumnCustom("markCphr","${msg.C100000940}",null,true,true,resultValueColPros) //표기 자리수
				.addColumnCustom("calcResult","${msg.C100000908}",null,true,true,resultValueColPros) //테스트 값
				.addColumnCustom("calcResultRs","${msg.C100000605}",null,true,false,resultValueColPros) //역산 테스트 값
				.addColumnCustom("rdmsCntcAt","rdmsCntcAt",null,false,true) //RDMS 연계여부
				.addColumnCustom("dataChangeAt","dataChangeAt",null,false,true, checkboxprop) //데이터 변경여부
				.addColumnCustom("lasCntcAt","lasCntcAt",null,false,true) //LAS 연계여부
				.addColumnCustom("calcLawSeqno","calcLawSeqno",null,false,null,null)
				.addColumnCustom("vriablSeqno","vriablSeqno",null,false,null,null)
				.checkBoxRenderer(["rdmsCntcAt","lasCntcAt"], calcNomfrmVriablGrid, { check : 'Y', unCheck : 'N' });

				var exprMthCalcGridPros = {
					showStateColumn : true,
					// 칼럼 끝에서 오른쪽 이동 시 다음 행, 처음 칼럼으로 이동할지 여부
					wrapSelectionMove : true,
					useContextMenu : false,
					softRemovePolicy : "exceptNew",
					softRemoveRowMode:false 
				};

				calcLawMGrid = createAUIGrid(calcLawCol, calcLawMGrid, { wordWrap : true });

				calcNomfrmVriablGrid = createAUIGrid(exprMthCalcCol, calcNomfrmVriablGrid, exprMthCalcGridPros);

			};

			function setGridEvent(){

				AUIGrid.bind(calcLawMGrid, "cellDoubleClick", function(event){
					var item = event.item;
					console.log(item);

					$("#btnDelete").show();
					$("#calcLawSeqno").val(item.calcLawSeqno);
					$("#calcLawNm").val(item.calcLawNm);
					$("#expriemSeqno").val(item.expriemSeqno);
					$("#mtrilNm").val(item.mtrilNm);
					$("#mtrilSeqno").val(item.mtrilSeqno);
					expriemCombo(item.expriemSeqno);
					$("#nomfrmCn").val(item.nomfrmCn);
					$("#rvsopCn").val(item.rvsopCn);
					$("#vriablId").val(event.item.vriablId);
					$("#markCphr").val(event.item.markCphr);
					$("#calcResult").val('');

					if(item.rvsopCphrRandomCreatAt == 'Y') {
						$("input:checkbox[id='rvsopCphrRandomCreatAt']").prop("checked", true);
					}

					if(item.useAt == "Y") {
						$("input:radio[id='useY']").prop("checked", true);
					} else if(item.useAt == "N") {
						$("input:radio[id='useN']").prop("checked", true);
					}

					if(item.rvsopCphrRandomCreatAt == "Y") {
						$("input:checkbox[id='rvsopCphrRandomCreatAt']").prop("checked", true);
					} else {
						$("input:checkbox[id='rvsopCphrRandomCreatAt']").prop("checked", false);
					}

					searchCalcNomfrmVriabl();
				})

				AUIGrid.bind(calcNomfrmVriablGrid, "headerClick", function(event) {
					return false; // name 외의 칼럼은 정렬 시킴.
				});

				// ready는 화면에 필수로 구현 할 것
				AUIGrid.bind(calcNomfrmVriablGrid, "ready", function(event) {
					gridColResize(calcNomfrmVriablGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
				});

				//상세코드 CRUD 체크
				AUIGrid.bind(calcNomfrmVriablGrid, "cellEditEnd", null);

				// 행 추가 이벤트 바인딩
				AUIGrid.bind(calcNomfrmVriablGrid, "addRow", null);

				// 행 삭제 이벤트 바인딩
				AUIGrid.bind(calcNomfrmVriablGrid, "removeRow", null);

				AUIGrid.bind(calcNomfrmVriablGrid, "cellEditEndBefore", function( event ) {
					var rowItem = event.item;
					if(event.dataField == "calcResult" && !(rowItem.bassValue == "" || rowItem.bassValue == null)) {
						return event.oldValue;
					}
				});

				AUIGrid.bind(calcNomfrmVriablGrid, "cellEditEnd", function( event ) {
					var rowItem = event.item;
					if(event.dataField == "calcResult" || event.dataField == "markCphr" || event.dataField == "bassValue") {
						if(event.dataField == "bassValue") {
							AUIGrid.setCellValue(calcNomfrmVriablGrid, event.rowIndex, "calcResult", rowItem.bassValue);
						}

						var iSubNomfrmCn = 0;
						var iNonCn = 0;
						var calcNomfrmVriablGridData = AUIGrid.getGridData(calcNomfrmVriablGrid);
						var iGridDataLength = calcNomfrmVriablGridData.length;
						// 결과값이 다 들어가 있는 경우 계산식 호출
						for(i=0; i<iGridDataLength;i++) {
							var myItem = AUIGrid.getItemByRowIndex(calcNomfrmVriablGrid, i);
							var sBassValue = $.trim(myItem["bassValue"]);
							var sCalcResult = $.trim(myItem["calcResult"]);
							var iMarkCphr = $.trim(myItem["markCphr"]);
							if(sBassValue == "") {
								if(sCalcResult != "") {
									AUIGrid.setCellValue(calcNomfrmVriablGrid, i, "calcResult", parseFloat(sCalcResult).toFixed(iMarkCphr));
									iNonCn++;
								}
							} else {
								iSubNomfrmCn++;
							}
						}

						if((iNonCn + iSubNomfrmCn) == iGridDataLength)
							calc(calcNomfrmVriablGrid, $.trim($("#" + calcLawFrm + " " + "#nomfrmCn").val()));
					}
				});

			}

			function setButtonEvent() {

				// 조회
				$('#btnSearch').click(function(){
					searchExprMth();
				});

				// 저장
				$('#btnSave').click(function(){
					saveCalcLaw();
				});

				// 초기화
				$('#btnReset').click(function(){
					frmReset();
				});

				// 행추가
				$('#btnAddRow').click(function(){
					addRow();
				});

				// 행삭제
				$('#btnRemoveRow').click(function(){
		
					removeRow();
				});

				$("#rvsopCphrRandomCreatAt").click(function() {
					calc(calcNomfrmVriablGrid, $.trim($("#" + calcLawFrm + " " + "#rvsopCn").val()), "rvsopCn");
				});

				$("#" + calcLawFrm + " " + "#nomfrmCn").blur(function() {
					calc(calcNomfrmVriablGrid, $.trim($("#" + calcLawFrm + " " + "#nomfrmCn").val()));
				});

				$("#" + calcLawFrm + " " + "#rvsopCalcResult").blur(function() {
					calc(calcNomfrmVriablGrid, $.trim($("#" + calcLawFrm + " " + "#rvsopCn").val()), "rvsopCn");
				});

				$("#rvsopCn").change(function() {
					var rvsopCn = $("#rvsopCn").val();
					var vriablId = $("#vriablId").val();
					if(rvsopCn.indexOf(vriablId) != -1){
						warn("${msg.C100000604}"); /* 역산 수식이 잘못 되었거나 역산 변수 명 값이 지정되지 않았습니다. */
						$("#rvsopCn").val('');
					}
				})

				$("#expriemSeqno").change(function(){
					if(!!$("#mtrilSeqno").val()){
						if(!$("#calcLawNm").val())
						$("#calcLawNm").val($("#mtrilNm").val()+'-'+$("#expriemSeqno option:selected").text());
					}
				});
				$("#mtrilSeqno").change(function(){
					if(!!$("#expriemSeqno").val()){
						if(!$("#calcLawNm").val())
						$("#calcLawNm").val($("#mtrilNm").val()+'-'+$("#expriemSeqno option:selected").text());
						
					}
				});
				$("#vriablId").change(function() {
					var vriablId = $(this).val();
					var gridRow = AUIGrid.getGridData(calcNomfrmVriablGrid);
					for(var i = 0; i<gridRow.length; i++){
						if(gridRow[i].vriablId == vriablId.toUpperCase()){
							return ;
						}
					}
					warn("${msg.C100000392}"); /* 변수를 찾을 수 없습니다. */
					$(this).val('');
				});

				$("#btnDelete").click(function(){
					if(!confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */
						return false;
					}
					var calcLawSeqno = $("#calcLawSeqno").val();

					if(!!calcLawSeqno){
						var param = {"calcLawSeqno" : $("#calcLawSeqno").val()}

						customAjax({
							"url":"/wrk/delCalcLawInfo.lims",
							"data":param,
							"successFunc" : function(data){
								success("${msg.C100000462}"); /* 삭제되었습니다. */
								searchExprMth();
								AUIGrid.clearGridData(calcNomfrmVriablGrid);
								frmReset();
							}
						});
					}else{
						alert("${msg.C100000489}"); /* 선택된 계산식이 없습니다. */
					}
				});
				//자재 초기화 버튼
				$('#prductReset').click(function() {
					$('#mtrilNm').val('');
					$('#mtrilSeqno').val('');
					//자재가 비워지면 시험항목도 같이 초기화

				});
			};

			function setCombo(){
				ajaxJsonComboBox('/com/getCmmnCode.lims',"mtrilTyCodeSch", {"upperCmmnCode" : "SY02", "deptCode" : "${UserMVo.deptCode}"}, true);
			}
			function expriemCombo(value){
			ajaxJsonComboBox('/wrk/getCLMtrilExpriemList.lims','expriemSeqno',{ "mtrilSeqno" : $("#mtrilSeqno").val()},true).then(function(){
				$("#expriemSeqno").val(value);
			});
			}
			//행추가
			function addRow(){
				var calcNomfrmVriablGridData = AUIGrid.getGridData(calcNomfrmVriablGrid);
				var sVriablId = "";
				//A01부터 + 1 순차 생성
				if(calcNomfrmVriablGridData.length == 0) {
					sVriablId = "A01";
				} else {
					var lastRow = AUIGrid.getItemByRowIndex(calcNomfrmVriablGrid, calcNomfrmVriablGridData.length-1);
					sVriablId = lastRow.vriablId;
					if (sVriablId == "A99"){
						warn("${msg.C100000387}"); /* 변수 ID A99 이상은 추가할 수 없습니다. */
						return;
					}
					sVriablId = "A" + LPAD((parseInt(sVriablId.replaceAll("A", "")) + 1).toString(), '0', 2);
				}

				var item = {
						vriablId : sVriablId,
						vriablNm : '',
						nomfrmCn : '',
						vriablDc : '',
						markCphr : 5,
						calcResult : '',
						testrgUseAt : 'Y'
				};
				AUIGrid.addRow(calcNomfrmVriablGrid, item, "last");
			}

			//행삭제
			function removeRow() {
				var addedRowItems = AUIGrid.getAddedRowItems(calcNomfrmVriablGrid);
				// 수정된 행 아이템들(배열)

				var items = AUIGrid.getGridData(calcNomfrmVriablGrid);
				
				AUIGrid.removeRow(calcNomfrmVriablGrid, items.length-1);
			}

			//조회
			function searchExprMth(){
				AUIGrid.clearGridData(calcNomfrmVriablGrid);
				frmReset();
				getGridDataForm('<c:url value="/wrk/getCalcLawMList.lims"/>', searchFrm, calcLawMGrid);
			}

			//조회
			function searchCalcNomfrmVriabl(){
				ajaxJsonForm('<c:url value="/wrk/getCalcNomfrm.lims"/>', calcLawFrm, function (data) {
					AUIGrid.setGridData(calcNomfrmVriablGrid, data);

					// 기본값이 있는경우 테스트에 기본값 할당
					for(var i=0; i<data.length; i++){
						if(data[i].bassValue != null){
							AUIGrid.setCellValue(calcNomfrmVriablGrid, i, "calcResult", data[i].bassValue);
						}
					}
				});
			}

			//저장
			function saveCalcLaw(){

				var inputCount = 0;

				$('#calcLawFrm').find('input').each(function() {
					var nm = $(this).attr('name');
					if (nm == 'calcLawNm' || nm == 'mtrilSeqno' || nm == 'nomfrmCn' || nm == 'vriablId') {
						if (!!$(this).prop('required')) {
							if ($(this).val() == '') {
								inputCount++;
							}
						}
					}
				});
				
				$('#calcLawFrm').find('select').each(function() {
					var nm = $(this).attr('name');
					if (nm == 'expriemSeqno') {
						if (!!$(this).prop('required')) {
							if ($(this).val() == '') {
								inputCount++;
							}
						}
					}
				});
				if(inputCount > 0) {
					warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
					return;
				}

				//checkBox는 serializeObject로 값을 넘겨받을 수 없음.
				if($('#rvsopCphrRandomCreatAt').is(':checked')){
				     $('#rvsopCphrRandomCreatAt').val('Y');
				}

				var param = $('#'+calcLawFrm).serializeObject();
				console.log(param);
				customAjax({
					'url' : '/wrk/chkCalcInfo.lims',
					'data' : param,
					'showLoading' : true,
					'successFunc' : function(data){
						if(data > 0) {
							warn('${msg.C100000178}'); /* 계산식이 존재합니다. */
							return false;
						} else {
							var exprMthCalcGridData = AUIGrid.getGridData(calcNomfrmVriablGrid);

							if(exprMthCalcGridData.length==0){
								warn('${msg.C100000175}'); /* 계산식 변수는 1개이상 있어야합니다. */
								return;
							}

							// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
							var gridData = AUIGrid.getGridData(calcNomfrmVriablGrid);
							var item;
							var invalid = false;
							var invalidRowIndex = -1;
							for(var i=0, len=gridData.length; i<len; i++) {

								item = gridData[i];

								if(typeof item['vriablNm'] == 'undefined' || String(item['vriablNm']).trim() == '' || String(item['vriablUnitNm']).trim() == '') {
									warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
									return;
								}
							}

							// 추가된 행 아이템들(배열)
							var addedRowItems = AUIGrid.getAddedRowItems(calcNomfrmVriablGrid);
							// 수정된 행 아이템들(배열)
							var editedRowItems = AUIGrid.getEditedRowItems(calcNomfrmVriablGrid);
							// 삭제된 행 아이템들(배열)
							var removedRowItems = AUIGrid.getRemovedItems(calcNomfrmVriablGrid);

							var gridData = {'list' : AUIGrid.getGridData(calcNomfrmVriablGrid),'removelist':AUIGrid.getRemovedItems(calcNomfrmVriablGrid)};

							var saveData = Object.assign(getFormParam(calcLawFrm),gridData);

							customAjax({
								'url' : '<c:url value="/wrk/saveExprMthExpriemM.lims"/>',
								'data' : saveData,
								'showLoading' : true,
								'successFunc' : function(data) {
									if (data == ''){
										err('${msg.C100000597}'); /* 오류가 발생했습니다. log를 참조해주세요. */
									} else{
										success('${msg.C100000762}'); /* 저장 되었습니다. */
										searchExprMth();
										$('#calcLawSeqno').val('');
									}
								}
							});
						}
					}
				});
			}

			//type : 수식 계산인지 역산 계산인지 구별 변수
			function calc(gridObj, nomfrmCn, type){
				type = (!type) ? 'nomfrmCn' : type; //기본값은 수식 계산
				var sNomfrmCn = nomfrmCn;
				if(sNomfrmCn == '') { //주어진 식이 없으면 리턴
					return '';
				}

				//계산식 변수 상세정보 그리드
				var calcNomfrmVriablGridData = AUIGrid.getGridData(gridObj);
				var iGridDataLength = calcNomfrmVriablGridData.length;
				if(calcNomfrmVriablGridData.length == 0)
					return false;

				var iNomfrmCn = 0;
				var iVriablId = $('#vriablId').val(); //변수 명
				var rMarkCphr = $('#markCphr').val(); //실제 계산 결과값에 사용할 표기자리수(상세 변수명의 자리수를 구하기)
				var randomAt = $('#rvsopCphrRandomCreatAt').val(); //소수점 자동생성 여부
				var iCalcResult = $('#rvsopCalcResult').val(); //계산 결과값
				var markValue;

				// 계산식을 변수ID별로 테스트값으로 치환. 테스트값이 공백인 경우 임의로 1 셋팅
				for(i=0; i<iGridDataLength;i++) {
					var myItem = AUIGrid.getItemByRowIndex(gridObj, i); //계산식 변수 정보
					var sSubVriablId = myItem['vriablId']; //변수아이디
					var sSubCalcResult = $.trim(myItem['calcResult']); //테스트값
					var sSubNomfrmCn = $.trim(myItem['nomfrmCn']); //수식?
					var iMarkCphr = $.trim(myItem['markCphr']); //표기자리수

					//표기 자리수 값이 있으면 표기자리수 + 1자리수의 값을 반올림하여 테스트값 세팅
					if(iMarkCphr!= null && iMarkCphr != '' & sSubCalcResult!= null && sSubCalcResult != '') {
						sSubCalcResult = Number(sSubCalcResult).toFixed(iMarkCphr);
					}

					//테스트값 그리드에 주입
					if(sSubCalcResult != '') {
						AUIGrid.setCellValue(gridObj, i, 'calcResult', sSubCalcResult);
					}

					//역산 변수명과 변수id가 같을때
					if(sSubVriablId == iVriablId) {
						//
						markValue = iMarkCphr;
						//소수점 자동생성 여부가 y이면 random함수를 추가해줌.
						sSubCalcResult = ((randomAt == 'Y')? randomCalcDigits(sSubCalcResult) : sSubCalcResult);
					}

					//변수명 Id와 같은것이 잇으면 계산식에 변수명 id대신 결과를 바꿔치기함.()
					sNomfrmCn = sNomfrmCn.replaceAll(sSubVriablId, '(' +sSubCalcResult+ ')');

					//상세에 변수명과 그리드 행에 같은 변수명이 있으면 자리수 구하기.
					if(!rMarkCphr && iVriablId == sSubVriablId) {
						rMarkCphr = ((iMarkCphr) ? iMarkCphr : '4');
					}

					iNomfrmCn++;
				}

				//역산결과값(A00)을 괄호로 묶음.
				sNomfrmCn = sNomfrmCn.replaceAll('A00', '(' +((randomAt == 'Y') ? randomCalcDigits(iCalcResult) : iCalcResult) + ')');

				if(iGridDataLength == iNomfrmCn) {

					var rsltData = nomfrmFnCal(sNomfrmCn, (type == 'rvsopCn' && markValue) ? markValue : rMarkCphr);
					if (rsltData != 'fail'){
						if(type == 'rvsopCn'){//역산일경우
							//변수 명으로 지정해준 변수의 로우 인덱스값 구하기.
							var rowIndex = AUIGrid.getRowIndexesByValue(gridObj, 'vriablId', iVriablId);
						 	//역산 결과값
							var rvsopCalcResult = Number($('#rvsopCalcResult').val());
						 	// 역산 결과값 - 계산식 결과 값
							rsltData = rsltData;
							AUIGrid.setCellValue(gridObj, rowIndex, 'calcResultRs', rsltData);
							calc(gridObj, $('#nomfrmCn').val());
						}else{
							//수식 계산일 경우 수식 결과에 값 넣기
							$('#' + calcLawFrm + ' ' + '#calcResult').val(rsltData);
						}

						bSave = true;
					} else {
						$('#' + calcLawFrm + ' ' + '#calcResult').val('');
						bSave = false;
					}

					return bSave;
				}
			}

			function frmReset(){
				pageReset(['calcLawFrm'], [calcNomfrmVriablGrid]);
				$('#expriemSeqno').children('option:not(:first)').remove();
				$("#btnDelete").hide();
			}

			function doSearch(e){
				searchExprMth();
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
