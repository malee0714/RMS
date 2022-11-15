<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">${msg.C100000433}</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!--  body 시작 -->
		<div class="subContent" style="height: 900px;">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000433}</h2><!-- 사업장 관리 -->
				<div class="btnWrap">
					<button id="btn_save" class="save">${msg.C100000760}</button><!-- 저장 -->
					<button id="btn_plnatSelect" class="search">${msg.C100000767}</button><!-- 조회 -->
				</div>
				<form id="searchForm" action="javascript:;">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
							<colgroup>
								<col style="width:10%"></col> 
								<col style="width:15%"></col>
								<col style="width:10%"></col>
								<col style="width:65%"></col>
							</colgroup>
						<tr>
							<th>${msg.C100000435}</th> <!-- 사업자명 -->
							<td><input type="text" id ="inspctInsttNm" name ="inspctInsttNm" class="schClass" maxlength="100"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" name="useAt" value="all">${msg.C100000779}</label> <!-- 전체 -->
						    	<label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						    	<label><input type="radio" name="useAt" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>

			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="plnatGridId" class="mgT15" style="width:100%; height:250px; margin:0 auto;"></div>
			</div>

		
			<div class="subCon1 mgT15">
			<h2><i class="fi-rr-apps"></i>${msg.C100001238}</h2><!-- 사업장 관리 -->
			<form id="LbcstForm" action="javascript:;">
				<table class="subTable1" style="width:100%">
					<div class="btnWrap">
					<button id="btn_qlity_ct_am_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
					<colgroup>
						<col style="width:10%"></col> 
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
					</colgroup>
					<tr>
						<th>${msg.C100000264}</th> <!-- 년도 -->
						<td><select id ="yy" name ="yy"></select></td>
						<th class="necessary">${msg.C100000678}</th> <!-- 인건비  -->
						<td style="text-align:left;">
							<input type="text" id ="lbcstAm" name="lbcstAm" value='' class="comma" maxlength="15" required>
						</td>
						<td colspan="4"></td>
					</tr>
				</table>
				<input type="hidden" id="inspctInsttCode" name="inspctInsttCode">
				<input type="hidden" id="inspctInsttLbcstSeqno" name="inspctInsttLbcstSeqno">
				<input type="hidden" id="lbcstAmHidden" name="lbcstAmHidden">
			</form>
		</div>
			<div class="subCon1 mgT20">
				<h3>${msg.C100000436}</h3> <!-- 사업장 품질 비 -->
				<div class="btnWrap">
					<button id="btn_qlity_ct_am_add" class="btn5"><img src="/assets/image/plusBtn.png"></button><!-- 행추가 -->
					<button id="btn_qlity_ct_am_remove" class="delete"><img src="/assets/image/minusBtn.png"></button><!-- 행삭제 -->
				</div>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="plnatQlityCtAmGrid" style="width:100%; height:250px; margin:0 auto;"></div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>

		var searchForm = 'searchForm';

		var plnatGridId = 'plnatGridId';

		var plnatQlityCtAmGrid = 'plnatQlityCtAmGrid';

		var plnatGrid;

		var columnLayout = { plnatGrid : [], plnatQlityCtAmGrid : [] };
		var lang = ${msg}; // 기본언어

		$(function() {

			getAuth();
			setComboBox();
			setGrid();
			Dialog();

			setGridEvent();

			setButtonEvent();

		});
		function setComboBox() {
			setYear('yy',"2021", 2019, 10);
		}
		function setGrid() {

			// ip주소 형식 validate colPros
			// var rdServerIpPros = {
			// 	editable: true,
			// 	editRenderer: {
			// 		type: "InputEditRenderer",
			// 		validator: function(oldValue, newValue, item, dataField, fromClipboard) {
			// 			var isValid = false;
			// 			var ipVal = newValue;
			// 			var regExp = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
						
			// 			if(regExp.test(ipVal)) {
			// 				isValid = true;
			// 			}

			// 			return {"validate" : isValid, "message" : "IP주소 형식이 아닙니다."};
			// 		}
			// 	}
			// };

			var requireColPros = {
				style : 'my-require-style',
				headerTooltip : { // 헤더 툴팁 표시 일반 스트링
					show : true,
					tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
				}
			};

		    var useAtPros = { showStateColumn : true 
			};

			//권한 사용자
			auigridCol(columnLayout.plnatGrid);
			columnLayout.plnatGrid
			.addColumnCustom('inspctInsttNm','${msg.C100000435}', '*', true, true, requireColPros) /* 사업장명 */
			.addColumnCustom('inspctInsttCode', '', '*', false, false) /* 사업장코드 */
			.addColumnCustom('engAdres','${msg.C100000609}', '*', true, true) /* 영문 주소 */
			.addColumnCustom('koreanAdres','${msg.C100000946}', '*', true, true ) /* 한글 주소 */
			.addColumnCustom('outnatnTelNo','${msg.C100000209}', '*', true, true ) /* 국외 전화번호 */
			.addColumnCustom('dmstcTelno','${msg.C100000208}', '*', true, true ) /* 국내 전화번호 */
			.addColumnCustom('rdmsServerIp','${msg.C100000079}', '*', true, true) /* RDMS Server IP */
			.addColumnCustom('dc', '${msg.C100000500}', '*', true, true) /* 설명 */
			.addColumnCustom('deleteAt', 'deleteAt', '*', false, false) /* 삭제여부 */
			.addColumnCustom('useAt','${msg.C100000443}', '*', true, true) /* 사용여부 */
			.checkBoxRenderer(['useAt'], plnatGrid, {check: 'Y', unCheck: 'N'}, useAtPros);

			var numberColPros = {
				style : 'my-require-style',
				dataType : "numeric",
				headerTooltip : { // 헤더 툴팁 표시 일반 스트링
					show : true
				},
				editRenderer : {
				    type : "InputEditRenderer",
				    onlyNumeric : true,
				    allowPoint : true,
				    maxlength : 15
				}
			};
			//사업장 품질비
			auigridCol(columnLayout.plnatQlityCtAmGrid);
			columnLayout.plnatQlityCtAmGrid.addColumnCustom('inspctInsttLbcstSeqno', 'inspctInsttLbcstSeqno', '*', false, false)
			.addColumnCustom('value', '', '*', false, true) /* 공통코드 */
			.addColumnCustom('eqpmnClCode', '', '*', false, false) /* 장비 분류 */
			.addColumnCustom('eqpmnClCodeNm', '${msg.C100000745}', '*', true, false) /* 장비 분류 */
			.addColumnCustom('analsctAm', '${msg.C100000409}', '*', true, true,numberColPros) /* 분석 비용 (Utility) */
			.addColumnCustom('cmpdsAnalsctAm', '${msg.C100000410}', '*', true, true,numberColPros) /* 분석 비용 (소모품) */
			.addColumnCustom('mntncMendngCntrctAm', '${msg.C100000637}', '*', true, true, numberColPros) /* 유지 보수 계약 액 */
			.addColumnCustom('rpairsMntncMendngAm', '${msg.C100000522}', '*', true, true, numberColPros) /* 수선 유지 보수 액 */
			.addColumnCustom('lbcstRate', '${msg.C100000680}', '*', true, true,numberColPros) /* 인건비 비율 */
			.addColumnCustom('dailAnalsPosblTime', '${msg.C100000687}', '*', true, true,numberColPros) /* 일일 분석 가능 시간 */
			.addColumnCustom('analsReqreTime', '${msg.C100000418}', '*', true, true,numberColPros); /* 분석항목 당 분석 시간(1건당) */
			// 그리드생성
			plnatGrid = createAUIGrid(columnLayout.plnatGrid, plnatGridId, { selectionMode : "multipleCells" });

			plnatQlityCtAmGrid = createAUIGrid(columnLayout.plnatQlityCtAmGrid, plnatQlityCtAmGrid, { selectionMode : "multipleCells" });

			//그리드 사이즈 조절
			gridResize([ plnatGridId, plnatQlityCtAmGrid ]);

			AUIGrid.bind(plnatGrid, "ready", function(event) {
				gridColResize(plnatGrid, "2"); // 1, 2가 있으니 화면에 맞게 적용
			});

			AUIGrid.bind(plnatQlityCtAmGrid, "ready", function(event) {
				gridColResize(plnatQlityCtAmGrid, "2"); // 1, 2가 있으니 화면에 맞게 적용
			});

		}

		function setGridEvent() {

			AUIGrid.bind(plnatGrid, 'cellEditEnd', function(event) {

				if(event.dataField == 'inspctInsttNm' && event.value.length > 100) {
					AUIGrid.setCellValue(plnatGrid, event.rowIndex, event.columnIndex, null);
					warn('${msg.C100000956}'); /* 허용 가능한 글자 수를 초과하였습니다. */
					return;
				}

				if(event.dataField == 'dc' && event.value.length > 2000) {
					AUIGrid.setCellValue(plnatGrid, event.rowIndex, event.columnIndex, null);
					warn('${msg.C100000956}'); /* 허용 가능한 글자 수를 초과하였습니다. */
					return;
				}

				if(event.dataField == 'rdmsServerIp') {
					var regExp = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;

					if(!regExp.test(event.value)) {
						AUIGrid.setCellValue(plnatGrid, event.rowIndex, event.columnIndex, null);
						warn("${msg.C100000047}");  /* IP주소 형식이 아닙니다. */
						return;
					}
				}
			});

			AUIGrid.bind(plnatGrid, 'cellDoubleClick', function(event) {
				$("#inspctInsttCode").val(event.item.inspctInsttCode);
				$("#yy").change();
			});

			AUIGrid.bind(plnatQlityCtAmGrid, 'cellEditEnd', function(event) {

				if(event.dataField == 'lbcstRate') {
					var regex = /^(100(\.0{1,2})?|[1-9]?\d(\.\d{1,2})?)$/g;
					var yyVal = event.value;
					if(!regex.test(yyVal)) {
						warn('${msg.C100000004}'); 
						AUIGrid.updateRow(plnatQlityCtAmGrid, { lbcstRate : '' }, 'selectedIndex');
					}
				}
				if(event.dataField == 'dailAnalsPosblTime'||event.dataField ==  'analsReqreTime') {
					var yyVal = event.value;
					var dataField = event.dataField;
					if(yyVal > 24) {
						warn('${msg.C100000005}'); 
						if(event.dataField == 'dailAnalsPosblTime')
						AUIGrid.updateRow(plnatQlityCtAmGrid, { dailAnalsPosblTime : '' }, 'selectedIndex');
						else if(event.dataField == 'analsReqreTime')
						AUIGrid.updateRow(plnatQlityCtAmGrid, { analsReqreTime : '' }, 'selectedIndex');
					}
				}
			});
		}

		function Dialog(){
			//검교정구분 팝업
			dialogCmmnCodeM("btn_qlity_ct_am_add",{"upperCmmnCode" : "RS02"}, "inspctCrrct", 'plnatQlityCtAmGrid', function(item){
				//제품 키
				//var eqpmnClCode = getEl("eqpmnClCode").value;

				//팝업에서 넘어온애 배열에추가
				for(var i =0; i< item.length; i++){
		 			//item[i]["value"] = item[i].value; //검교정 구분코드에 code값 set
					item[i]["eqpmnClCode"] = item[i].value; //검교정 구분코드에 code값 set
					item[i]["eqpmnClCodeNm"] = item[i].key; //검교정 구분명에 key값 set
				}
				
				var selectedItems = AUIGrid.getSelectedItems(plnatQlityCtAmGrid)[0];

				if(!!selectedItems){
					AUIGrid.addRow(plnatQlityCtAmGrid, item, "selectionDown");
				} else {
					AUIGrid.addRow(plnatQlityCtAmGrid, item, "last");
				}
				 
			},null,true,'eqpmnClCode');
		}
		function setButtonEvent() {

			//(사업장관리)행추가
			$('#btn_add').click(function() {
				var item = {'inspctInsttNm' : '', 'dc' : '', 'useAt' : 'Y'};
				AUIGrid.addRow(plnatGrid, item, "last");
			});

			//(사업장관리)행삭제
			$('#btn_remove').click(function() {
				//새로 추가된 행임. 추가된것만 삭제
				if (!AUIGrid.getSelectedItems(plnatGrid)[0]['item']['authorCode']) {
					AUIGrid.removeRow(plnatGrid, 'selectedIndex');
				}
			});

			//(사업장관리)저장(저장버튼으로 저장, 수정, 사용안함 모든 DML 발생)
			$('#btn_save').click(function() {
				if(AUIGrid.getEditedRowItems(plnatGrid).length + AUIGrid.getAddedRowItems(plnatGrid).length <= 0) {
					alert('${msg.C100000883}'); /* 추가/수정/삭제된 행이 없습니다. */
					return;
				}

				savePlnat();
			});

			//(사업장관리)조회
			$('#btn_plnatSelect').click(function() {
				searchPlnat();
			});

			//(사업장품질비)행삭제
			$('#btn_qlity_ct_am_remove').click(function() {
				//새로 추가된 행임. 추가된것만 삭제
				AUIGrid.removeRow(plnatQlityCtAmGrid, 'selectedIndex');
			});

			//(사업장품질비)저장
			// $('#btn_qlity_ct_am_save').click(function() {
			// 	unComma(["lbcstAm"]);
			// 	if(!saveValidation('LbcstForm'))
			// 		return false;
			//
			// 	savePlnatQlityCtAm();
			// });

			$("#yy").change(function(e){
				$("#lbcstAmHidden").val('');
				searchPlnatQlityCtAm(e);
				//getRgntHist() 조회 태우기
			});
			$('#lbcstAm').change(function(e){
				$("#lbcstAmHidden").val('change');
			});
		
		}


		function searchPlnat(rowVal) {
			getGridDataForm('<c:url value="/sys/getPlnatMList.lims"/>', searchForm, plnatGrid, function() {
				if (!!rowVal)
					gridSelectRow(plnatGrid, "inspctInsttNm", rowVal);
			});
			AUIGrid.clearGridData(plnatQlityCtAmGrid);
			$("#lbcstAm").val('');
		}

		function savePlnat() {

			var data = AUIGrid.getGridData(plnatGrid);
			var item;
			var invalid = false;

			for(var i = 0, len = data.length; i < len; i++) {

				item = data[i];		
				if(typeof item['inspctInsttNm'] == 'undefined' || String(item['inspctInsttNm']).trim() == "" || item['inspctInsttNm'] == null ){
					invalid = true;
					break;
				}
				
			}

			if(invalid) {
				warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
				return;
			}

			customAjax({
				'url' : '<c:url value="/sys/insPlnat.lims"/>',
				'data' : data,
				'successFunc' : function(result) {
					if (result == 1) {
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						searchPlnat(data[0].inspctInsttNm);
					} else if(result == 99) {
						warn('${msg.C100000434}'); /* 사업장 등록 허용 수를 초과하였습니다. */
					}
				}
			});
		}

		function searchPlnatQlityCtAm(clickItem) {
			var params = { inspctInsttCode : $("#inspctInsttCode").val(),yy: $("#yy").val()};
			
		
			/*customAjax({'url' :'<c:url value="/sys/getlbcstList.lims"/>','data':params,'successFunc' :function(data) {
				if(data != ''){
					setYear('yy',data[0].yy);
					data[0].lbcstAm=data[0].lbcstAm.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');data[0].lbcstAm.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
					$("#lbcstAm").val(data[0].lbcstAm);
					$('#inspctInsttLbcstSeqno').val(data[0].inspctInsttLbcstSeqno);

					customAjax({'url' :'<c:url value="/sys/getPlnatQlityCtAmMList.lims"/>','data':params,'successFunc' :function(data) {
						AUIGrid.setGridData(plnatQlityCtAmGrid,data);
						}});
					}else{
					$("#lbcstAm").val('');
					$('#inspctInsttLbcstSeqno').val('');
					AUIGrid.clearGridData(plnatQlityCtAmGrid);
					}
			
			}});*/

		//	getGridDataParam('<c:url value="/sys/getPlnatQlityCtAmMList.lims"/>', params, plnatQlityCtAmGrid);
		}

		function savePlnatQlityCtAm() {
			
			var editGridData = AUIGrid.getEditedRowItems(plnatQlityCtAmGrid);
			var addGridData = AUIGrid.getAddedRowItems(plnatQlityCtAmGrid);
			var removeGridData = AUIGrid.getRemovedItems(plnatQlityCtAmGrid);
			var formData = [$("#LbcstForm").serializeObject()];

			if((editGridData.length + addGridData.length + removeGridData.length+formData[0].lbcstAmHidden.length) <= 0) {
				alert('${msg.C100000883}'); /* 추가/수정/삭제된 행이 없습니다. */
				return;
			}

			if(editGridData.length > 0 || addGridData.length > 0) {

				var data = AUIGrid.getGridData(plnatQlityCtAmGrid);
				var item;
				var invalid = false;

				for(var i = 0, len = data.length; i < len; i++) {

					item = data[i];

					if(typeof item["analsctAm"] == "undefined" || String(item["analsctAm"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "analsctAm");

						break;
					}
					else if(typeof item["cmpdsAnalsctAm"] == "undefined" || String(item["cmpdsAnalsctAm"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "cmpdsAnalsctAm");

						break;
					} 
					else if(typeof item["mntncMendngCntrctAm"] == "undefined" || String(item["mntncMendngCntrctAm"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "mntncMendngCntrctAm");

						break;
					} 
					else if(typeof item["rpairsMntncMendngAm"] == "undefined" || String(item["rpairsMntncMendngAm"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "rpairsMntncMendngAm");

						break;
					} 
					else if(typeof item["lbcstRate"] == "undefined" || String(item["lbcstRate"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "lbcstRate");

						break;
					} 
					else if(typeof item["dailAnalsPosblTime"] == "undefined" || String(item["dailAnalsPosblTime"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "dailAnalsPosblTime");

						break;
					} 
					else if(typeof item["analsReqreTime"] == "undefined" || String(item["analsReqreTime"]).trim() == ""){
						invalidRowIndex = i;
						invalid = true;
						colIndex = AUIGrid.getColumnIndexByDataField(plnatQlityCtAmGrid, "analsReqreTime");

						break;
					} 
				}

		
				if(invalid) {
					warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
					AUIGrid.setSelectionByIndex(plnatQlityCtAmGrid, invalidRowIndex, colIndex);
					return;
				}
			}

			var obj = {
				addedRowItems : addGridData,
				editedRowItems : editGridData,
				removedItems : removeGridData,
				formData : formData
			};

			console.log(obj);

			customAjax({
				'url' : '<c:url value="/sys/putPlnatQlityCtAm.lims"/>',
				'data' : obj,
				'successFunc' : function(data) {
					if (data > 0){
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						searchPlnat();
					} else {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
						return;
					}
				}
		    });
		}

		function doSearch(e){
			searchPlnat();
		};

		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
