<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">${msg.C100000959}</tiles:putAttribute>
<tiles:putAttribute name="body">
	<div class="subContent">
		<div id="tabMenuLst" class="tabMenuLst round skin-peter-river">
			<ul id="tabs">
				  <li id="tab1" class="on tabMenu">${msg.C100000660}</li><!-- 의뢰 정보 -->
				  <li id="tab2" class="tabMenu">${msg.C100000655}</li><!-- 의뢰 목록 -->
			</ul>
		</div>
		<div id="tabCtsLst">
			<div id="tabCts1" class="tabCts">
				<div class="subCon1 wd100p">
				
				</div>
				<div class="mgT15 ">
					<div class="subCon1">
						<h2><i class="fi-rr-apps"></i>${msg.C100000660}</h2><!-- 의뢰 정보 -->
						<div class="btnWrap">
							<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button><!-- 신규 -->
							<button type="button" id="btnUpdate" class="save" style="display:none;">${msg.C100000798}</button><!-- 정보 수정 -->
							<button type="button" id="btnDelete" class="delete" style="display:none;">${msg.C100000658}</button><!-- 의뢰 삭제 -->
							<button type="button" id="btnSave" class="save">${msg.C100000760}</button><!-- 저장 -->
						</div>
						<form id="reqestFrm">
							<table class="subTable1" style="width:100%;">
								<colgroup>
									<col style="width:9%"></col>
									<col style="width:15%"></col>
									<col style="width:9%"></col>
									<col style="width:15%"></col>
									<col style="width:9%"></col>
									<col style="width:17%"></col>
									<col style="width:9%"></col>
									<col style="width:17%"></col>
								</colgroup>
								<tr>
									<th class="necessary">의뢰 부서</th> <!-- 의뢰팀 -->
									<td><select id="reqestDeptCode" name="reqestDeptCode"  required></select></td>

									<th class="necessary">${msg.C100000657}</th> <!-- 의뢰번호 -->
									<td><input type="text" name="reqestNo" id="reqestNo"  readonly></td>

									<th class="necessary">${msg.C100000962}</th> <!-- 협력업체명 -->
									<td>
										<input type="text" name="entrpsNm" id="entrpsNm" class="wd70p fL" readonly>
										<input type="hidden" name="entrpsSeqno" id="entrpsSeqno" required>
										<button id="btnEntrpsSearch" type="button" class="inTableBtn inputBtn fL"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
										<button type="button" id = "btnEntrpsReset" class="inTableBtn inputBtn fL btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
									</td>

									<th class="necessary">${msg.C100000717}</th> <!-- 제품명 -->
									<td>
										<input type="text" name="mtrilNm" id="mtrilNm" class="wd70p fL" readonly>
										<input type="hidden" name="mtrilSeqno" id="mtrilSeqno" required>
										<button id="btnPrductSearch" type="button" class="inTableBtn inputBtn fL"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
										<button type="button" id = "btnPrductReset" class="inTableBtn inputBtn fL btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
									</td>
								</tr>
								<tr>
									<th class="necessary">${msg.C100000139}</th> <!-- 검사유형 -->
									<td><select class="wd100p" name="inspctTyCode" id="inspctTyCode" required> </select></td>

									<th>${msg.C100000692}</th> <!-- 입고 일자 -->
									<td><input type="text" class="wd100p" name="mnfcturDte" id="mnfcturDte" readonly required></td>

									<th>${msg.C100000056}</th> <!-- 벤더 Lot No. -->
									<td><input type="text" class="wd100p" id="vendorLotNo" name="vendorLotNo" maxlength="20"></td>

									<td colspan="2"></td>
								</tr>
								<tr>
									<th>${msg.C100000425}</th><!-- 비고 -->
									<td colspan="7">
										<textarea id="rm" name="rm" class="wd100p" style="min-width:10em; height:77px;" maxlength="4000"></textarea>
									</td>
									<input type="hidden" name="reqestSeqno" id="reqestSeqno"/>
								</tr>
							</table>
						</form>
					</div>
				</div>
				<div class="wd100p mgT20"  style="display:inline-block;">
					<div class="subCon1 wd100p">
						<h2><i class="fi-rr-apps"></i>${msg.C100000561}</h2> <!-- 시험항목 목록 -->
						<!-- <div class="btnWrap">
							<button type="button" id="btnAddExpriemAllList" class="btn4">${msg.C000000892}</button>   전체 시험 항목 추가
							<button type="button" id="btnAddMtrilExpriemList" class="btn4">${msg.C000000226}</button>   시험 항목 추가
							<button type="button" id="btnRemove" class="btn4"><img src="/assets/image/minusBtn.png"></button>  행 삭제
						</div> -->
					</div>
						<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
						<div class="mgT15">
						<div id="expriemGrid" class="grid" style="width:100%; height:280px; margin:0 auto;"></div>
					</div>
				</div>
			</div>

			<div id="tabCts2" class="tabCts" style="display:none;">
				<div class="subCon1 wd100p">
					<form id="searchFrm" class="mgT15">
						<h2><i class="fi-rr-apps"></i>${msg.C100000655}</h2><!-- 의뢰 목록 -->
						<div class="btnWrap">
							<button type="button" id="btnRequestSearch" class="search">${msg.C100000767}</button><!-- 조회 -->
						</div>
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
                                <th>의뢰 부서</th><!-- 의뢰 부서 -->
                                <td><select id="reqestDeptCodeSch" name="reqestDeptCodeSch" class="wd100p"></select></td>

								<th>${msg.C100000717}</th><!-- 자재명 -->
								<td><input type="text" id="mtrilNmSch" name="mtrilNmSch" class="wd100p schClass" /><input type="hidden" name="vendorCoaAT" id="vendorCoaAT" value="Y"/></td>

								<th>${msg.C100000657}</th> <!-- 의뢰번호 -->
								<td><input type="text" id="reqestNoSch" name="reqestNoSch" class="wd100p schClass" /></td>

								<th>${msg.C100000139}</th><!-- 검사유형 -->
								<td><select class="wd100p" name="inspctTyCodeSch" id="inspctTyCodeSch"></select></td>
                            </tr>
                            <tr>
								<th class="necessary">${msg.C100000803}</th><!-- 제조 일자 -->
								<td style="text-align: left;">
									<input type="text" id="stMnfcturDteSch" name="stMnfcturDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" required> ~
									<input type="text" id="enMnfcturDteSch" name="enMnfcturDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" required>
								</td>

								<td colspan="6"></td>
                            </tr>
						</table>
					</form>
				 </div>
				<div class="mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="reqestGrid" class="grid" style="width:100%; height:285px; margin:0 auto;"></div>
				</div>
			</div>
		</div>
	</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">
	<style>
		.rowStyle-red{
			background-color : #FEDBDE
		}
		.rowStyle-sky{
			background-color : #A1D0FF
		}
	</style>
	<script>

		var clickStatus = '';
		var lang = ${msg}; //팝업에서 사용하는 기본언어
		var expriemGrid = 'expriemGrid';
		var reqestGrid = 'reqestGrid';
		var reqestFrm = 'reqestFrm';
		var searchFrm = 'searchFrm';

		var createLotNogubunArr = [];
		var sessionObj = {
			bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}",
			deptCode : "${UserMVo.deptCode}"
		};

		$(function(){

			setGrid();

			setGridEvent();

			setButtonEvent();

			setEtcEvent();

			setCombo();

			tabGridResize();

			var mtrilData = {
					bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
					authorSeCode : '${UserMVo.authorSeCode}'
			};


			var expriemData = {
					inspctInsttCode : '${UserMVo.bestInspctInsttCode}'
					, pageNm : 'ReqestM'
			};


		});

		dialogEntrps('btnEntrpsSearch','SY08000002','Products',function(item){
			$('#entrpsNm').val(item.entrpsNm)
			$('#entrpsSeqno').val(item.entrpsSeqno)
		});
		//자재 찾기 팝업
		dialogMtril('btnPrductSearch',"RequestM", 'Product',null, function(data){
			item = data[0]
			$('#mtrilSeqno').val(item.mtrilSeqno);
			$('#mtrilNm').val(item.mtrilNm);
			$('#mtrilNm').change();
			$('#bplcCode').val(item.bplcCode);
			/* 자재에 따른 설비구분콤보 생성 */
			if(!!item.mtrilSeqno) {
				$('#lotCode').val(item.lotCode);

				createLotNogubunArr = [
					item.lotMxtrRule1Code
					, item.lotMxtrRule2Code
					, item.lotMxtrRule3Code
					, item.lotMxtrRule4Code
				];

//					console.log(createLotNogubunArr);
			}
		},sessionObj);

		function setGrid() {

			var expriemCol = [];
			auigridCol(expriemCol);

			var reqestCol = [];
			auigridCol(reqestCol);

			var defaultColPros = {
					showStateColumn : true
			};

			//필수
			var requireProps = {
				style : 'my-require-style',
				headerTooltip : { // 헤더 툴팁 표시 일반 스트링
					show : true,
					tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
				}
			};
			
			var numberProp =  {
				labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
					if (item.jdgmntFomCode == 'IM06000001'){
						if(isNaN(value) == true)
						return null;
					}
   				return value;
				} ,
				styleFunction: function (rowIndex, columnIndex, value, headerText, item, dataField) {

					if (dataField == "resultValue") {

						//판정코드가 부적합이면 적색으로 표시
						if (item["jdgmntWordCode"] == "IM05000002") {
							return "rowStyle-red";
						}


							return "rowStyle-sky";

					}

					return null;
				},
				editRenderer : {
				maxlength  : 15
				}
			};
			expriemCol.addColumnCustom('expriemSeqno','expriemSeqno',null,false)		//시험항목일련번호
			.addColumnCustom('expriemNm','${msg.C100000560}','*',true,false)			//시험항목명
			.addColumnCustom("mtrilSeqno", "",null,false) 			/* 제품키 */
			.addColumnCustom("expriemCl", "",null,false) 			/* 검사항목 그룹명 */
			.addColumnCustom("sdspcNm", "",null,false,false) 		/* 기준명 */
			.addColumnCustom("unitSeqno", "",null,false,false) 		/* 단위 */
			.addColumnCustom("rangeValue", "LCL~UCL",null,true,false)		/* LCL */
			.addColumnCustom("jdgmntFomCode", "",null,false,false) 	/* 판정기준 */
			.addColumnCustom("textStdr", "",null,false,false) 		/* 텍스트기준 */
			.addColumnCustom("lclValue", "",null,false,false)		/* LCL */
			.addColumnCustom("lclValueSeCode", "",null,false,false) /* 단위 */
			.addColumnCustom("uclValue", "",null,false,false) 		/* UCL */
			.addColumnCustom("uclValueSeCode", "",null,false,false)
			.addColumnCustom("lslValue", "",null,false,false) 		/* LSL */
			.addColumnCustom("lslValueSeCode","",null,false,false)
			.addColumnCustom("uslValue", "",null,false,false) 		/* USL */
			.addColumnCustom("uslValueSeCode", "",null,false,false)
			.addColumnCustom('resultValue','${msg.C100000150}','*',true,true,numberProp) 	//결과값
			.addColumnCustom("markCphr", "",null,false,false) 		/* 표기 자리수 */
			.addColumnCustom("exprNumot", "",null,false,false) 		/* 시험횟수 */
			.addColumnCustom("eqpmnClCode", "",null,false,false) 	/* 실제 측정기기 분류 */
			.addColumnCustom("coaUpdtPosblAt", "",null,false,false) /* COA수정가능여부 */
			.addColumnCustom("coaUseAt", "","",false,false) 		/* COA사용여부 */
			.addColumnCustom("emailSndngAt","",null,false,false) 	/* 이메일 발송여부 */
			.addColumnCustom("chrctrSndngAt","",null,false,false) 	/* 문자 발송여부 */
			.addColumnCustom("useAt", "",null,false,false) 			/* 사용여부 */
			.addColumnCustom("updtResn", "",null,false,false);  	// 수정 사유
			

			reqestCol.addColumnCustom('reqestSeqno','reqestSeqno',null,false)	  //의뢰 일련번호
			.addColumnCustom('bplcCode','${msg.C100000432}','*',false,false) 	  //사업장
			.addColumnCustom('bplcNm','${msg.C100000432}','*',false,false) 		  //사업장
			.addColumnCustom('reqestNo','${msg.C100000657}','*',true,false) 	  //의뢰번호
			.addColumnCustom('mtrilNm','${msg.C100000717}','*',true,false) 		  //자재명
			.addColumnCustom('vendorLotNo','${msg.C100000056}','*',true,false)    //벤더LotNo
			.addColumnCustom('entrpsNm','${msg.C100000962}','*',true,false) 	  //협력업체명
			.addColumnCustom('entrpsSeqno','${msg.C100000962}','*',false,false)   //협력업체 일련번호
			.addColumnCustom('inspctTyCode','','*',false,false) 				  //검사유형
			.addColumnCustom('inspctTyCodeNm','${msg.C100000139}','*',true,false) //검사유형명
			.addColumnCustom('mnfcturDte','${msg.C100000692}','*',true,false) 	  //입고일자
			.addColumnCustom('reqestDeptCode','의뢰 부서','*',false,false) 		  //의뢰 부서
			.addColumnCustom('rm','${msg.C100000425}','*',true,false);		      //비고

			expriemGrid = createAUIGrid(expriemCol, expriemGrid);
			reqestGrid = createAUIGrid(reqestCol, reqestGrid);
		}

		function setGridEvent() {

			AUIGrid.bind(expriemGrid, "ready", function(event) {
			});
			AUIGrid.bind(reqestGrid, "ready", function(event) {
			});
			AUIGrid.bind(reqestGrid, 'cellDoubleClick', function(event) {

				clickStatus = 'click';

				btnStyle(false); //버튼 스타일

				$('#tab1').click(); //탭 1 이동#
				var item = event.item;
				$('#reqestSeqno').val(item.reqestSeqno);
				$('#bplcCode').val(item.bplcCode);
				$('#reqestNo').val(item.reqestNo);
				$('#entrpsSeqno').val(item.entrpsSeqno);
				$('#entrpsNm').val(item.entrpsNm);
				$('#entrpsNm').val(item.entrpsNm);
				$('#mtrilNm').val(item.mtrilNm);
				$('#inspctTyCode').val(item.inspctTyCode);
				$('#mnfcturDte').val(item.mnfcturDte);
				$('#vendorLotNo').val(item.vendorLotNo);
				$('#mtrilSeqno').val(item.mtrilSeqno);
				$('#reqestDeptCode').val(item.reqestDeptCode);
				$('#rm').val(item.rm);
				$("#btnPrductSearch").prop("disabled",true);
				$("#btnEntrpsSearch").prop("disabled",true);
				$("#btnPrductReset").prop("disabled",true);
				$("#btnEntrpsReset").prop("disabled",true);
				$('#inspctTyCode option').prop('disabled', false);
				$('#inspctTyCode option').not(':selected').prop('disabled', true);
				customAjax({url:'<c:url value="/req/getExpriemCoaList.lims"/>', data:item,successFunc:function(data){
					if(data != null&&data != "")
					AUIGrid.setGridData(expriemGrid,data);
					
				}})
			});
			AUIGrid.bind(expriemGrid, "cellEditEnd", function(event){
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
					AUIGrid.setCellValue(expriemGrid, event.rowIndex, "jdgmntWordCode", result);
					if(!event.item.resultRegistDte){
						AUIGrid.setCellValue(expriemGrid, event.rowIndex, "resultRegistDte", currentDate());
					}
				});
			});

			AUIGrid.bind(expriemGrid, 'cellEditBegin', function(event) {
				if(event.dataField =="frstAnals"){
				if(event.item.frstAnalsAt=='N'){
					if(event.item.middleAnalsAt=='N'){
						if(event.item.lastAnalsAt=='N'){
						return false;}}}}	
			});
		}

		function setButtonEvent() {

			$('#btnNew').click(function() {
				frmReset();
			});

			$('#btnSave').click(function() {
				reqestSave();
			});

			$('#btnUpdate').click(function() {
				requestUpdate();
			});

			$('#btnRequestSearch').click(function() {
				requestSearch();
			});

			$('#btnDelete').click(function() {
				requestDelete();
			});
			$("#btnEntrpsReset").click(function(){
				$("#entrpsSeqno").val("");
				$("#entrpsNm").val("");
			});
			$("#btnPrductReset").click(function(){
				$("#mtrilSeqno").val("");
				$("#mtrilNm").val("");
				clearGridData(expriemGrid);
			});
			
		}

		function setEtcEvent() {
			$("#mtrilNm").change(function(){
				
			var paramObj = {
				prductMtrilSeqno : $("#mtrilSeqno").val()
			};
				getGridDataParam('/req/getExpriem.lims',paramObj,expriemGrid);
				// .then(function(data){
				// 	$("#reqestSeqno").val('');
				// 	$("#vendorLotNo").val('');
				// 	$("#reqestNo").val('');
				// 	btnStyle(true); //버튼 스타일
				// });	
				
				// 시험항목 목록 불러오기 
			});

			$("#vendorLotNo").change(function(event){
				
				params = {vendorLotNo:event.target.value,reqestSeqno:$("#reqestSeqno").val()};
				customAjax({url:"/req/getVenderLotNo.lims",data:params,showLoading:false,successFunc:function(data){
					if(data !=0){
						warn("${msg.C100000288}");  //동일한 Lot No 가 있습니다.
						$("#vendorLotNo").val('');
					}else{

					}}
				} )
			});
		}

		function setCombo() {
			datePickerCalendar(["stMnfcturDteSch","enMnfcturDteSch"],true,["YY",-1]);
			datePickerCalendar(["mnfcturDte"],true);
			ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCode',{'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'},true).then(function(){
				$('#reqestDeptCode').val(item.reqestDeptCode);
				$('#reqestDeptCode option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
			});
			ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'},true).then(function(){
				$('#reqestDeptCodeSch').val('${UserMVo.deptCode}');
				$('#reqestDeptCodeSch option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
			});
			ajaxJsonComboBox('/com/getCmmnCode.lims','inspctTyCode',{'upperCmmnCode' : 'SY07'},true,null); /* 검사유형 */
 			ajaxJsonComboBox('/com/getCmmnCode.lims','inspctTyCodeSch',{'upperCmmnCode' : 'SY07'},true,null); /* 검색 검사유형 */

		}

		//저장(신규)
		function reqestSave() {

			if(!saveValidation('reqestFrm')){ return false; }

			if($('#emrgncyAt').is(':checked')){
				 $('#emrgncyAt').val('Y');
			} else {
				$('#emrgncyAt').val('N');
			}

			//신규저장이므로 시험항목이 없거나 새로추가된 건만 생성될 수 있음.
			$('#bplcCode').prop('disabled', false); //저장할 때 변수에 폼데이터 넣을 때 disabled 해제
				var formData = $('#reqestFrm').serializeObject();
				var reqestExpriemGrid = AUIGrid.getGridData(expriemGrid);
		
			formData.reqestExpriemGrid= reqestExpriemGrid;
			  customAjax({
				url : '/req/insPartnersCoaM.lims'
				, data : formData
			}).then(function(data) {
				if(data == '0') {
					err('${msg.C100000597}');//저장에 실패하였습니다.
				} else if(data == '99') {
					warn('${msg.C100000288}');//동일한 Lot No 가 있습니다.
				} else {
					success('${msg.C100000762}');//저장 되었습니다.
					$('#bplcCode').prop('disabled', true); //저장할 때 변수에 폼데이터 넣을 때 disabled 추가
					$('#reqestSeqno').val(data);
					btnStyle(false); //버튼스타일
					requestSearch();
				}
			});

		}

		//정보수정
		function requestUpdate() {

			if(!saveValidation('reqestFrm')){ return false; }

			if($('#emrgncyAt').is(':checked')){
				$('#emrgncyAt').val('Y');
			} else {
				$('#emrgncyAt').val('N');
			}

			$('#expriemCoChk').val(AUIGrid.getGridData(expriemGrid).length);
			$('#bplcCode').prop('disabled', false); //저장할 때 변수에 폼데이터 넣을 때 disabled 해제
			var params = $('#reqestFrm').serializeObject();
			var reqestExpriemGrid = AUIGrid.getGridData(expriemGrid);
			params.reqestExpriemGrid= reqestExpriemGrid;
			  customAjax({
				url : '/req/updPartnersCoaM.lims'
				, data : params
			}).then(function(data) {
				if(data == '0') {
					err('${msg.C100000597}');//저장에 실패하였습니다.
				} else if(data == '99') {
					warn('${msg.C100000288}');//동일한 Lot No 가 있습니다.
				} else {
					success('${msg.C100000762}');//저장 되었습니다.
					$('#bplcCode').prop('disabled', true); //저장할 때 변수에 폼데이터 넣을 때 disabled 해제
					btnStyle(false); //버튼스타일
					AUIGrid.clearGridData(expriemGrid);
					requestSearch();
				}
			});

		}

		//삭제
		function requestDelete() {
			  customAjax({	
				url : '/req/delPartnersCoaM.lims'
				, data : $('#reqestFrm').serializeObject()
			}).then(function(data) {
				if(data == '0') {
					err('${msg.C100000597}');//삭제를 실패 하였습니다.
					AUIGrid.clearGridData(expriemGrid);
					frmReset();
					btnStyle(true); //버튼스타일
				} else {
					success('${msg.C100000462}');//삭제되었 
					frmReset();
					btnStyle(true); //버튼스타일
					requestSearch();
				}
			});
		}

		//조회
		function requestSearch() {
			if(!saveValidation('searchFrm')){ return false; }
			
			AUIGrid.clearGridData(expriemGrid);
			frmReset();
			btnStyle(true);
			getGridDataForm('<c:url value="/req/getPartnersCoaList.lims"/>', searchFrm, reqestGrid);
		}

		//초기화
		function frmReset() {

			clickStatus = '';

			createLotNogubunArr = []; //Lot No. 생성 규칙 배열

			btnStyle(true); //버튼 스타일

			$('#reqestNo').val('');
			$('#entrpsNm').val('');
			$('#entrpsSeqno').val('');
			$('#reqestSeqno').val(''); //의뢰번호
			$('#mtrilSeqno').val(''); //자재 일련번호
			$('#mtrilNm').val(''); //자재명
			$('#inspctTyCode').val(''); //검사유형
			datePickerCalendar(["mnfcturDte"],true); //제조일자
			$('#emrgncyAt').prop('checked', false); //긴급여부
			$('#lotCode').val(''); //Lot 코드
			$('#ordr').val(''); //배치수
			$('#vendorLotNo').val(''); //Lot No.
			/*
				협력업체 Lot No. 초기화 생성필요
				comboReset(['vendorLotNo'], false, '선택'); //납품처
			*/
			
			
			$("#btnPrductSearch").prop("disabled",false);
			$("#btnEntrpsSearch").prop("disabled",false);
			$("#btnPrductReset").prop("disabled",false);
			$("#btnEntrpsReset").prop("disabled",false);
			$('#inspctTyCode option').not(':selected').prop('disabled', false);
			$('#rm').val(''); //비고
			AUIGrid.clearGridData(expriemGrid);		
		}

		//상황에 따른 버튼 스타일
		function btnStyle(gubun) {
			// true : 신규기준 , false : 수정기준
			if(gubun) {
				$('#btnSave').css('display', 'inline-block');
				$('#btnUpdate').css('display', 'none');
				$('#btnDelete').css('display', 'none');
			} else {
				$('#btnSave').css('display', 'none');
				$('#btnUpdate').css('display', 'inline-block');
				$('#btnDelete').css('display', 'inline-block');
			}
		}
        function doSearch() {
        	requestSearch();
        }


	</script>
</tiles:putAttribute>
</tiles:insertDefinition>
