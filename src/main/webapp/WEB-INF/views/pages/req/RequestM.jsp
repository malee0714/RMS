<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div id="tabMenuLst" class="tabMenuLst round skin-peter-river">
				<ul id="tabs">
			          <li id="tab1" class="on tabMenu">${msg.C100000660}</li> <!-- 의뢰 정보 -->
			          <li id="tab2" class="tabMenu">${msg.C100000655}</li> <!-- 의뢰 목록 -->
			    </ul>
			</div>
			<div id="tabCtsLst">
				<div id="tabCts1" class="tabCts">
					<div class="wd100p">
						<div class="subCon1">
							<h2><i class="fi-rr-apps"></i>${msg.C100000660}</h2> <!-- 의뢰 정보 -->
							<div class="btnWrap">
								<button type="button" id="btnBeforeRabelPrint" hidden></button> <!-- 바코드 출력 버튼 클릭 전 실행 함수 -->
								<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
								<button type="button" id="btnRabelPrint" class="print" style="display:none;" hidden>${msg.C100000339}</button> <!-- 바코드 출력 -->
								<button type="button" id="btnUpdate" class="save" style="display:none;">${msg.C100000798}</button> <!-- 정보 수정 -->
								<button type="button" id="btnDelete" class="delete" style="display:none;">${msg.C100000658}</button> <!-- 의뢰 삭제 -->
								<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
							</div>
							<form id="reqestFrm">
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
										<th class="necessary">의뢰 부서</th> <!-- 의뢰 부서 -->
										<td><select id="reqestDeptCode" name="reqestDeptCode"  required></select></td>

										<th class="necessary">${msg.C100000665}</th> <!-- 의뢰자 -->
										<td><select class="wd100p" id="clientId" name="clientId" required></select></td>

										<th class="necessary">${msg.C100000659}</th> <!-- 의뢰 일자 -->
										<td><input type="text" class="dateChk wd6p" style="min-width: 6em;" name="reqestDte" id="reqestDte" required/></td>

										<th class="necessary">${msg.C100000657}</th> <!-- 의뢰번호 -->
										<td><input type="text" name="reqestNo" id="reqestNo" readonly /></td>
									</tr>
									<tr>
										<th class="necessary">${msg.C100000139}</th> <!-- 검사유형 -->
										<td><select class="wd100p" name="inspctTyCode" id="inspctTyCode" required></select></td>

										<th class="necessary">분석실</th> <!-- 분석실 -->
										<td>
											<select class="wd100P" name="custlabSeqno" id="custlabSeqno" required>
												<option>${msg.C100000480}</option>
											</select>
										</td>

										<th class="necessary">${msg.C100000717}</th> <!-- 제품 명 -->
										<td >
											<input type="text" name="mtrilNm" id="mtrilNm" class="wd62p"/>
											<input type="text" name="mtrilSeqno" id="mtrilSeqno" style="display: none" required>
											<input type="text" name="mtrilCode" id="mtrilCode" style="display: none">
											<input type="text" name="lblDcOutptAt" id="lblDcOutptAt" style="display: none">
											<button type="button" id="btnPrductSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
											<button type="button" id="btnPrductReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
										</td>

										<th class="necessary">${msg.C100000803}</th><!-- 제조일자 -->
										<td><input type="text" class="dateChk wd6p" style="min-width: 6em;" name="mnfcturDte" id="mnfcturDte" required></td>
									</tr>
									<tr id="eqpmnTr" style="display: none">
										<th class="necessary" >장비 분류</th>
										<td><select name="eqpmnSeqno" id="eqpmnSeqno"></select></td>
									</tr>
									<tr>
										<th>시료 정보</th> <!-- 시료 정보 -->
										<td>
											<select class="wd100p" name="sploreNm" id="sploreItemselectNm" style="display:none;width: 100%;" disabled> <!-- 자재 아이템 -->
												<option>${msg.C100000480}</option>
											</select>
											<select class="wd100p" name="sploreNm" id="sploreCylndrselectNm" style="display:none;width: 100%;" disabled> <!-- 자재 실린더 -->
												<option>${msg.C100000480}</option>
											</select>
											<input type="text" class="wd100p" name="sploreNm" id="sploreNm"/> <!-- 시료 명 -->
										</td>

										<th>충전량</th> <!-- 충전량 -->
										<td><input type="text" class="wd100p" name="elctcQy" id="elctcQy"></td>

										<th class="necessary">충전 정보</th> <!-- 충전 정보 -->
										<td><input type="text" class="wd100p" name="elctcCn" id="elctcCn" required></td>

										<th>충전 일렬번호</th> <!-- 충전 일렬번호 -->
										<td><input type="text" class="numChk wd20p" id="elctcSeqno" name="elctcSeqno" onblur="numFormat(this); createLotNo();" maxlength="2" style="min-width: 2em"></td>
									</tr>
									<tr>
										<th>고객사</th> <!-- 고객사 -->
										<td>
											<input type="text" id="entrpsNm" name="entrpsNm" class="wd60p fL"/>
											<input type="hidden" id="entrpsSeqno" name="entrpsSeqno" class="wd62p fL"/>
											<button id="btnEntrpsSearch" type="button" class="inTableBtn inputBtn fL"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
											<button type="button" id="btnEntrpsReset" class="inTableBtn inputBtn fL btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
										</td>

										<th>협력사 Lot No</th> <!-- 협력사 Lot No. -->
										<td>
											<input type="text" id="vendorLotNo" name="vendorLotNo" class="wd62p fL" maxlength="20">
											<input type="text" id="vendorCoaReqestSeqno" name="vendorCoaReqestSeqno" style="display: none">
											<button type="button" id="btnPartnerCoaSch" class="inTableBtn inputBtn fL"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
											<button type="button" id="btnPartnerCoaReset" class="inTableBtn inputBtn fL"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
										</td>

										<th>Lot No.</th> <!-- Lot No. -->
										<td>
											<input type="text" class="wd100p" id="lotNo" name="lotNo" maxlength="20" readonly>
											<input type="text" class="wd100p" id="lotNoSeqno" name="lotNoSeqno" style="display: none">
										</td>

										<td colspan="2"></td>
									</tr>
									<tr>
										<th>${msg.C100001356}</th> <!-- 제품 설명 -->
										<td colspan="7"><textarea type="text" id="prductDc" name="prductDc" style="width:100%;" rows="1" maxlength="4000"></textarea></td>
									</tr>
									<tr>
										<th>${msg.C100001270}</th> <!-- 비고 -->
										<td colspan="7">
											<textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="1" maxlength="4000"></textarea>
											<input type="hidden" id="expriemCoChk" name="expriemCoChk"/>
											<input type="hidden" id="reqestSeqno" name="reqestSeqno"/>

											<!-- 바코드 구분 : 저장(S), 의뢰 정보(I), 의뢰 목록(L) -->
											<input type="hidden" id="barcodeGubun" name="barcodeGubun"/>
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
					<div class="wd100p mgT20"  style="display:inline-block;">
						<div class="subCon1 wd100p">
							<h2><i class="fi-rr-apps"></i>${msg.C100000561}</h2> <!-- 시험항목 목록 -->
							<div class="btnWrap">
								<button type="button" id="btnAddExpriemAllList" class="btn4">${msg.C100000784}</button> <!-- 전체 시험 항목 추가 -->
								<button type="button" id="btnAddMtrilExpriemList" class="btn4">${msg.C100000721}</button> <!-- 자재 시험 항목 추가 -->
								<button type="button" id="btnRemove" class="btn4"><img src="/assets/image/minusBtn.png"></button><!-- 행 삭제 -->
							</div>
						</div>
						<div class="mgT7">
							<!-- AUIGrid가 이 곳에 생성됩니다. -->
							<div id="expriemGrid" class="grid" style="width:100%; height:400px; margin:0 auto;"></div>
						</div>
					</div>
				</div>

				<div id="tabCts2" class="tabCts" style="display:none;">
					<div class="subCon1 wd100p">
						<form id="searchFrm" class="mgT15">
							<h2><i class="fi-rr-align-left"></i>${msg.C100000655}</h2> <!-- 의뢰 목록 -->
							<div class="btnWrap">
								<button type="button" id="btnRequestRabelPrint" class="print" hidden>${msg.C100000339}</button> <!-- 바코드 출력 -->
								<button type="button" id="btnRequestSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
									<th>의뢰 부서</th> <!-- 의뢰 부서 -->
									<td><select id="reqestDeptCodeSch" name="reqestDeptCodeSch" class="wd100p"></select></td>

									<th>분석실</th> <!-- 분석실 -->
									<td><select id="custlabSeqnoSch" name="custlabSeqnoSch" class="wd100p"></select></td>

									<th>${msg.C100000659}</th> <!-- 의뢰 일자 -->
									<td style="text-align: left;">
										<input type="text" id="stReqestDteSch" name="stReqestDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" > ~
										<input type="text" id="enReqestDteSch" name="enReqestDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" >
									</td>

									<th class="necessary">${msg.C100000803}</th> <!-- 제조 일자 -->
									<td style="text-align: left;">
										<input type="text" id="stMnfcturDteSch" name="stMnfcturDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" required> ~
										<input type="text" id="enMnfcturDteSch" name="enMnfcturDteSch" class="dateChk wd6p schClass" style="min-width: 6em;" required>
									</td>
								</tr>
								<tr>
									<th>${msg.C100000139}</th> <!-- 검사유형 -->
									<td><select class="wd100p" name="inspctTyCodeSch" id="inspctTyCodeSch"></select></td>

									<th>${msg.C100000657}</th> <!-- 의뢰번호 -->
									<td><input type="text" id="reqestNoSch" name="reqestNoSch" class="wd100p schClass" /></td>

									<th>시료 정보</th> <!-- 시료 정보 -->
									<td><input type="text" id="sploreNmSch" name="sploreNmSch" class="wd100p schClass" /></td>

									<th>${msg.C100000717}</th> <!-- 자재명 -->
									<td><input type="text" id="mtrilNmSch" name="mtrilNmSch" class="wd100p schClass" /></td>
								</tr>
							</table>
						</form>
				 	</div>
					<div class="mgT15">
						<!-- AUIGrid가 이 곳에 생성됩니다. -->
						<div id="reqestGrid" class="grid" style="width:100%; height:285px; margin:0 auto;"></div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.c-orange { background-color:#FFA64C; }
			.c-blue { background-color: #b6e7ff; }
			.unmatched-color { background-color : #fcc2c7; }
			.default-color { background-color : #fafafa; }
		</style>
	</tiles:putAttribute>
	</tiles:insertDefinition>

		<script>

			var clickStatus = '';
			var lang = ${msg};

			var expriemGrid = 'expriemGrid';
			var reqestGrid = 'reqestGrid';
			var upperLotIdGrid = 'upperLotIdGrid';
			var upperRealLotIdGrid = 'upperRealLotIdGrid';
			var reqestFrm = 'reqestFrm';
			var searchFrm = 'searchFrm';

			var tempInspctArray = [];
			var printingCoursArr = [];
			var sessionObj = {
				bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
				deptCode : '${UserMVo.deptCode}',
			};

			$(function() {
				setGrid();

				setGridEvent();

				setButtonEvent();

				setEtcEvent();

				setCombo();

				tabGridResize();
			});

			//의뢰에서 사용하는 mrd 리스트 셋업
			// customAjax({
			// 	url: "/com/printCours.lims",
			// 	data: { lblDcOutptAtVal : 'Y', printngSeCode : 'SY15000001' },
			// 	successFunc: function(data) {
			// 		printingCoursArr = data;
			// 	}
			// });

			var mtrilData = {
				bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
				authorSeCode : '${UserMVo.authorSeCode}'
			};

			//협력사 의뢰 팝업
			dialogVendorLotNo('btnPartnerCoaSch', null, 'PartnerCoa');

			//고객사 팝업
			dialogEntrps('btnEntrpsSearch','SY08000001','Products',function(item) {
				$('#entrpsNm').val(item.entrpsNm);
				$('#entrpsSeqno').val(item.entrpsSeqno);
			});

			//제품 팝업
			dialogMtril('btnPrductSearch', "RequestM", 'Product', null, function(data) {
				var item = data[0];
				$('#mtrilSeqno').val(item.mtrilSeqno);
				$('#mtrilCode').val(item.mtrilCode);
				$('#mtrilNm').val(item.prductSeCodeNm+" / "+item.mtrilNm);
				$('#prductSeCode').val(item.prductSeCode);
				createLotNo(); //자재코드값 바인딩된 후에 라트넘버 생성

				//자재에 따른 시료정보콤보 생성
				if(!!item.mtrilSeqno) {
					ajaxSelect2Box({
						ajaxUrl : '/req/getsploreItemList.lims',
						elementId : 'sploreItemselectNm',
						ajaxParam : { mtrilSeqno: item.mtrilSeqno },
						//콤보가 완전히 생성되고 난 시점에 메서드를 호출해야 정상적인 시료정보 element 동적 컨트롤이 가능함
						callback: function() {
							sploreSelect();
						}
					});
					ajaxSelect2Box({
						ajaxUrl : '/req/getsploreCylndrList.lims',
						elementId : 'sploreCylndrselectNm',
						ajaxParam :{ mtrilSeqno: item.mtrilSeqno },
						callback: function() {
							sploreSelect();
						}
					});

					//자재에 등록되어있는 시험항목 조회
					showLoader(divID);
					var divID = expriemGrid;
					customAjax({
						url: '/req/getRequestMtrilExpriemList.lims',
						data: {
							mtrilSeqno : item.mtrilSeqno,
							deptCode : '${UserMVo.deptCode}',
							reqestAt : 'Y'
						},
						showLoading : false,
						successFunc : function(data) {
							divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
							AUIGrid.setGridData(divID, data);
							hideLoader(divID);
						}
					});
				}
			}, sessionObj, false, true);

			//기준규격없이 사용되는 시험항목 팝업
			dialogAddExpriemEditList('btnAddExpriemAllList', { pageNm: 'Request' }, 'Expriem', '#' + expriemGrid, function(item) {
				if (item)
					AUIGrid.addRow(expriemGrid, item, 'last');
			}, function() {
				if (!$('#mtrilNm').val()) {
					alert('${msg.C100000726}'); /* 자재를 먼저 선택해주세요. */
					return false;
				}
			}, true);

			var innerParam = {
				'mtrilSeqno' : $('#mtrilSeqno').val()
				, 'deptCode' : $('#reqestDeptCode').val()
				, 'reqestAt' : 'Y'
			};

			//자재 시험항목 팝업
			dialogReqestAddExpriemList('btnAddMtrilExpriemList', innerParam, 'reqExpriem', function(items) {
				//자재기준규격, 시험항목 시퀀스가 동일하면 추가안되도록 막음
				var parentItems = AUIGrid.getGridData(expriemGrid);
				if (parentItems != null && parentItems.length > 0) {
					for (var i = 0; i < items.length; i++) {
						for (j = 0; j < parentItems.length; j++) {
							if (items[i].mtrilSdspcSeqno == parentItems[j].mtrilSdspcSeqno
									&& items[i].expriemSeqno == parentItems[j].expriemSeqno) {
								warn('${msg.C100001071}'); /* 기준규격이 동일한 시험항목이 있습니다. */
								return false;
							}
						}
					}
				}
				AUIGrid.addRow(expriemGrid, items, 'last');

			}, function() {
				if (!$('#mtrilNm').val()) {
					alert('${msg.C100000726}'); /* 자재를 먼저 선택해주세요. */
					return false;
				}
			}, true);


			function setGrid() {

				var expriemCol = [];
				auigridCol(expriemCol);

				var reqestCol = [];
				auigridCol(reqestCol);

				var customPros = {
					selectionMode : "multipleCells"
				};

				reqestCol
						.addColumnCustom('reqestSeqno','reqestSeqno',null,false)
						.addColumnCustom('bplcCode','bplcCode','*',false,false)
						.addColumnCustom('mtrilNm','${msg.C100000717}','*',true,false)
						.addColumnCustom('reqestNo','${msg.C100000657}','*',true,false)
						.addColumnCustom('inspctTyCode','inspctTyCode','*',false,false)
						.addColumnCustom('inspctTyCodeNm','${msg.C100000140}','*',true,false)
						.addColumnCustom('reqestDte','${msg.C100000659}','*',true,false)
						.addColumnCustom('mnfcturDte','${msg.C100000803}','*',true,false)
						.addColumnCustom('sploreNm','시료정보','*',true,false)
						.addColumnCustom('lotNo','${msg.C100000056}','*',true,false)
						.addColumnCustom('reqestDeptCode','reqestDeptCode','*',false,false)
						.addColumnCustom('reqestDeptNm','${msg.C100000666}','*',true,false)
						.addColumnCustom('clientNm','${msg.C100000665}','*',true,false)
						.addColumnCustom('rereqestNum','${msg.C100000757}','*',true,false)
						.addColumnCustom('progrsSittnCode','progrsSittnCode','*',false,false)
						.addColumnCustom('progrsSittnCodeNm','${msg.C100000846}','*',true,false)
						.addColumnCustom('eqpmnNm','장비 분류',"*",true,false)
						.addColumnCustom('eqpmnSeqno','장비일련번호',"*",false,false)
						.addColumnCustom('rtnResn','${msg.C100000345}','*',false,false)
						.addColumnCustom('lblDcOutptAt','lblDcOutptAt','*',false,false)
						.addColumnCustom('lotTraceAtmcReqestAt','lotTraceAtmcReqestAt','*',false,false)
						.addColumnCustom('vendorLotNo','협력사 Lot No.','*',true,false)
						.addColumnCustom('vendorCoaReqestSeqno','협력사 Lot No.','*',false,false)
						.addColumnCustom('prductDc','${msg.C100001356}','*',true,false)
						.addColumnCustom('rm','${msg.C100001270}','*',true,false);

				reqestGrid = createAUIGrid(reqestCol, reqestGrid, customPros);

				expriemCol
						.addColumnCustom('expriemSeqno','expriemSeqno',null,false)
						.addColumnCustom('reqestExpriemSeqno','reqestExpriemSeqno',null,false)
						.addColumnCustom('reqestSeqno','reqestSeqno',null,false)
						.addColumnCustom('expriemNm','${msg.C100000560}','*',true,false)
						.addColumnCustom('mtrilSeqno','mtrilSeqno','*',false)
						.addColumnCustom('useYn','useYn','*',false)
						.addColumnCustom('sdspcNm','sdspcNm','*',false)
						.addColumnCustom('jdgmntFomNm','jdgmntFomNm','*',false)
						.addColumnCustom('textStdr','textStdr','*',false, false)
						.addColumnCustom('sortOrdr','sortOrdr','*',false, false)
						.addColumnCustom("unitSeqno", "${msg.C100000268}","*",false,false)
						.addColumnCustom("unitNm", "${msg.C100000268}","*",true,false)
						.addColumnCustom("fstRoot", "${msg.C100001006}","*",true)
						.addColumnCustom('lclValue','lclValue','*',false)
						.addColumnCustom('lclValueSeCode','lclValueSeCode','*',false)
						.addColumnCustom('uclValue','uclValue','*',false)
						.addColumnCustom('uclValueSeCode','uclValueSeCode','*',false)
						.addColumnCustom("secRoot", "${msg.C100001007}","*",true)
						.addColumnCustom('lslValue','lslValue','*',false)
						.addColumnCustom('lslValueSeCode','lslValueSeCode','*',false)
						.addColumnCustom('uslValue','uslValue','*',false)
						.addColumnCustom('uslValueSeCode','uslValueSeCode','*',false)
						.addColumnCustom('markCphr','markCphr','*',false)
						.addColumnCustom('useAt','useAt','*',false)
						.addColumnCustom('updtResn','updtResn','*',false);

				expriemGrid = createAUIGrid(expriemCol, expriemGrid, { showRowCheckColumn: true, showRowAllCheckBox: true });

				gridColResize([expriemGrid, reqestGrid], "2");
			}

			function setGridEvent() {

				AUIGrid.bind(expriemGrid, "ready", function(event) {
				});
				AUIGrid.bind(reqestGrid, "ready", function(event) {
				});

				AUIGrid.bind(reqestGrid, 'cellDoubleClick', function(event) {
					clickStatus = 'click';
					btnStyle(false); //버튼 스타일
					$('#tab1').click(); //탭1 이동

					//시료정보 콤보 재생성하고, 동적컨트롤 메서드 호출까지
					var item = event.item;
					ajaxSelect2Box({
						ajaxUrl : '/req/getsploreItemList.lims',
						elementId : 'sploreItemselectNm',
						ajaxParam : { mtrilSeqno: item.mtrilSeqno },
						//콤보가 완전히 생성되고 난 시점에 메서드를 호출해야 정상적인 시료정보 element 동적 컨트롤이 가능함
						callback: function() {
							sploreSelect(item.eqpmnSeqno);
							//저장된 데이터 바인딩
							$('#sploreItemselectNm').val(item.mtrilItmSeqno);
							$('#sploreItemselectNm').change();
						}
					});
					ajaxSelect2Box({
						ajaxUrl : '/req/getsploreCylndrList.lims',
						elementId : 'sploreCylndrselectNm',
						ajaxParam :{ mtrilSeqno: item.mtrilSeqno },
						callback: function() {
							sploreSelect(item.eqpmnSeqno);
							//저장된 데이터 바인딩
							$('#sploreCylndrselectNm').val(item.mtrilCylndrSeqno);
							$('#sploreCylndrselectNm').change();
						}
					});

					$('#reqestSeqno').val(item.reqestSeqno);
					$('#reqestNo').val(item.reqestNo);
					$('#progrsSittnCode').val(item.progrsSittnCode);
					$('#inspctTyCode').val(item.inspctTyCode);
					$('#rm').val(item.rm);

					//자재관련
					$('#mtrilSeqno').val(item.mtrilSeqno);
					$('#mtrilCode').val(item.mtrilCode);
					$('#mtrilNm').val(item.mtrilNm);

					//시료정보
					$('#sploreNm').val(item.sploreNm);
					$('#sploreCylndrselectNm').val(item.sploreNm);
					$('#sploreItemselectNm').val(item.sploreNm);

					//Lot관련
					$('#vendorLotNo').val(item.vendorLotNo);
					$('#vendorCoaReqestSeqno').val(item.vendorCoaReqestSeqno);
					$('#lotNo').val(item.lotNo);
					$('#lotNoSeqno').val(item.lotNoSeqno);
					$('#elctcSeqno').val(item.elctcSeqno);
					numFormat($('#elctcSeqno')[0]); //데이터 바인딩 후 충전일렬번호 포매팅

					$('#prdictDc').val(item.prdictDc);
					$('#elctcCn').val(item.elctcCn);
					$('#elctcQy').val(item.elctcQy);
					$('#entrpsSeqno').val(item.entrpsSeqno);
					$('#entrpsNm').val(item.entrpsNm);
					$('#prductDc').val(item.prductDc);
					$('#reqestDte').val(item.reqestDte);
					$('#mnfcturDte').val(item.mnfcturDte);

					//의뢰팀
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'reqestDeptCode', { bestInspctInsttCode : item.bplcCode }, true).then(function() {
						$('#reqestDeptCode').val(item.reqestDeptCode);
						$('#reqestDeptCode option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
					});
					//의뢰자
					ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'clientId', { deptCode: item.reqestDeptCode }, true).then(function() {
						$('#clientId').val(item.clientId);
						$('#clientId option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
					});
					//분석실
					ajaxJsonComboBox('/rsc/getCustlabCombo.lims', 'custlabSeqno', null, true).then(function() {
						$('#custlabSeqno').val(item.custlabSeqno);
						$('#custlabSeqno option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
					});
					//제품구분
					ajaxJsonComboBox('/com/getCmmnCode.lims', 'prductSeCode', { upperCmmnCode: 'SY20' }, true).then(function() {
						$('#prductSeCode').val(item.prductSeCode);
						$('#prductSeCode option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
					});
					reInquire(item.reqestSeqno);
				});

			}

			function setButtonEvent() {

				//협력 업체 Lot No. 값 초기화
				$('#btnEntrpsReset').click(function() {
					$('#entrpsNm').val(null);
					$('#entrpsSeqno').val(null);
				});

				$('#btnRemove').click(function() {
					var nullCountChk = AUIGrid.getCheckedRowItems(expriemGrid);
					if (nullCountChk.length > 0) {
						AUIGrid.removeCheckedRows(expriemGrid);
					} else {
						alert('${msg.C100000868}'); //체크된 시험항목이 없습니다.
					}
				});

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

				// $('#btnChangeOrdr').click(function() {
				// 	changeOrdrFun('1');
				// });
				//
				// $('#btnChangeRealOrdr').click(function() {
				// 	changeOrdrFun('2');
				// });

				//의뢰 정보 - 바코드 출력
				/*$('#btnRabelPrint').click(function() {
					if (!!$('#reqestSeqno').val()) {
						$('#barcodeGubun').val('I');
						document.getElementById('btnBeforeRabelPrint').click();
					} else {
						alert('${msg.C100000664}'); //의뢰를 먼저 선택해 주세요.
					}
				});*/

				//의뢰 목록 - 바코드 출력
				/*$('#btnRequestRabelPrint').click(function() {
					if (AUIGrid.getCheckedRowItemsAll(reqestGrid).length > 0) {
						$('#barcodeGubun').val('L'); //바코드 구분
						document.getElementById('btnBeforeRabelPrint').click(); //바코드 출력 샘플 값 설정 팝업 호출
					} else {
						alert('${msg.C100000664}'); //의뢰를 먼저 선택해 주세요.
					}
				});*/

				//자재 값 초기화
				$('#btnPrductReset').click(function() {
					$('#mtrilSeqno').val('');
					$('#mtrilCode').val('');
					$('#mtrilNm').val('');
					$('#lblDcOutptAt').val('');
					AUIGrid.clearGridData(expriemGrid);
				});

				//협력사 Lot No. 초기화
				$('#btnPartnerCoaReset').click(function() {
					$('#vendorLotNo').val('');
					$('#vendorCoaReqestSeqno').val('');
				});
			}

			function setEtcEvent() {

				$('#reqestDeptCode').change(function() {
					var selectDeptCode = this.value;
					ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'clientId', { deptCode: selectDeptCode }, true).then(function() {
						if ('${UserMVo.deptCode}' == selectDeptCode)
							$('#clientId').val('${UserMVo.userId}');
						$('#clientId option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
					});
				});

				$('#inspctTyCode').change(function() {
					sploreSelect();
					//검사유형의 TMPR_FIELD2_VALUE 필드값이 'Y'로 결재정보의 필요 유무
					var temp = $('#inspctTyCode').val();
					var chkBool = true; //버튼 Disabled의 default true 설정
					for (var i = 0; i < tempInspctArray.length; i++) {
						if (temp === tempInspctArray[i].value && 'Y' === tempInspctArray[i].gubun)
							chkBool = false; //검사유형의 필드값이 'Y'일 경우 결재라인변경 버튼 Disabled 해제
					}
				});
			}

			function setCombo() {
				datePickerCalendar(['stReqestDteSch', 'enReqestDteSch']);
				datePickerCalendar(['stMnfcturDteSch', 'enMnfcturDteSch'], true, ['DD',-7]);
				datePickerCalendar(['reqestDte'], true);
				datePickerCalendar(['mnfcturDte'], true, null, null, null, function() {
					createLotNo();
				});
				//자재 아이템
				ajaxSelect2Box({ajaxUrl: '/req/getsploreItemList.lims', elementId: 'sploreItemselectNm', ajaxParam: ''}).then(function() {
					sploreSelect();
				});
				//자재 실린더
				ajaxSelect2Box({ajaxUrl: '/req/getsploreCylndrList.lims', elementId : 'sploreCylndrselectNm', ajaxParam: ''}).then(function() {
					sploreSelect();
				});

				//의뢰팀
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'reqestDeptCode', { bestInspctInsttCode: '${UserMVo.bestInspctInsttCode}' }, true).then(function() {
					$('#reqestDeptCode').val('${UserMVo.deptCode}');
					$('#reqestDeptCode option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
				});
				//의뢰자
				ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'clientId', { deptCode: '${UserMVo.deptCode}' }, true).then(function() {
					$('#clientId').val('${UserMVo.userId}');
					$('#clientId option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
				});
				//의뢰팀(검색)
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'reqestDeptCodeSch', { bestInspctInsttCode: '${UserMVo.bestInspctInsttCode}' }, true).then(function() {
					$('#reqestDeptCodeSch').val('${UserMVo.deptCode}');
					$('#reqestDeptCodeSch option').not(':selected').prop('disabled', !('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
				});
				ajaxJsonComboTrgetName({url: '/rsc/getCustlabCombo.lims', name: 'custlabSeqno', selectFlag: true});
				ajaxJsonComboTrgetName({url: '/rsc/getCustlabCombo.lims', name: 'custlabSeqnoSch', selectFlag: true});
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'prductSeCode', { upperCmmnCode: 'SY20' }, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctTyCode', { upperCmmnCode: 'SY07' }, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctTyCodeSch', { upperCmmnCode: 'SY07' }, true);
			}

			//disabled column 색상 변경
			function cellStyleFunction(rowIndex, columnIndex, value, headerText, item, dataField) {
				if (!!item) {
					if (dataField == "matchingLotNo") {
						if (item.matchingLotNo === 'X')
							return "unmatched-color";
						else
							return "default-color";
					}
					return null;
				}
			}

			//숫자 두자리 형태로 포매팅
			function numFormat(el) {
				if (Number(el.value) < 10 && el.value.length == 1)
					el.value = "0" + el.value;
			}

			//라트넘버 생성
			function createLotNo() {
				var lotNo = '';
				var lotNoRule1 = $('#mtrilCode').val();
				var lotNoRule2 = $('#mnfcturDte').val();
				var lotNoRule3 = $('#elctcSeqno').val();
				if (lotNoRule1 && lotNoRule2 && lotNoRule3) {
					var splitDateArr = lotNoRule2.split("-");
					lotNoRule2 = splitDateArr[0].substring(2) + splitDateArr[1] + splitDateArr[2];
					lotNo = lotNoRule1 + lotNoRule2 + lotNoRule3;
					$('#lotNo').val(lotNo);
				}
			}

			//신규 의뢰
			function reqestSave() {

				if (!saveValidation('reqestFrm'))
					return;

				var params = {};
				var formData = setMtrilData();
				params.formData = formData; //폼 데이터
				params.addedRequestDtlList = AUIGrid.getGridData(expriemGrid); //추가된 시험항목

				customAjax({
					url : '/req/insReqest.lims',
					data : params
				}).then(function(data) {
					var resultCode = data.resultCode;
					if (resultCode == '0') {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					} else if (resultCode == '99') {
						warn('${msg.C100000288}'); /* Lot No.가 중복되었습니다. */
					} else {
						success('${msg.C100000762}'); /* 저장되었습니다. */
						frmReset();

						//$('#reqestSeqno').val(data.reqestSeqno); //바코드 출력에서 사용하기 위한 설정
						//$('#barcodeGubun').val('S'); //바코드 구분
						//document.getElementById('btnBeforeRabelPrint').click(); //바코드 출력 샘플 값 설정 팝업 호출
					}
				});

			}

			//검사유형에 따른 시료관련 데이터 세팅
			function setMtrilData() {
				var inspctTyCode = $('#inspctTyCode').val();
				var formObj = $('#reqestFrm').serializeObject();

				if (inspctTyCode == 'SY07000002') {
					formObj.sploreNm = !!$('#sploreItemselectNm').val() ? $('#sploreItemselectNm option:checked').text() : '';
					formObj.mtrilItmSeqno = $('#sploreItemselectNm').val();
				} else if (inspctTyCode == 'SY07000003') {
					formObj.sploreNm = !!$('#sploreCylndrselectNm').val() ? $('#sploreCylndrselectNm option:checked').text() : '';
					formObj.mtrilCylndrSeqno = $('#sploreCylndrselectNm').val();
				} else {
					formObj.sploreNm = $('#sploreNm').val();
				}

				return formObj;
			}

			//검사유형에 따라 보여질 콤보박스 동적 컨트롤
			function sploreSelect(item) {
				document.getElementsByName("sploreNm").forEach(function (e) {
					e.disabled = true;
					e.style.display="none";
					$('#sploreItemselectNm').next(".select2-container").hide();
					$('#sploreCylndrselectNm').next(".select2-container").hide();
				});

				switch($("#inspctTyCode").val()) {
					case "SY07000002": //공정 -> 제품아이템콤보
						$('#sploreItemselectNm').next(".select2-container").show();
						$("#sploreItemselectNm").prop("disabled",false);
						break;
					case "SY07000003": //제품 -> 제품실린더콤보
						$('#sploreCylndrselectNm').next(".select2-container").show();
						$("#sploreCylndrselectNm").prop("disabled",false);
						break;
					default: //나머지 -> 텍스트 입력
						$("#sploreNm").css("display",'block');
						$("#sploreNm").prop("disabled",false);
						break;
				}

				//장비검교정,장비신뢰성평가 -> 장비콤보 생성 후 장비일렬번호 바인딩
				switch($("#inspctTyCode").val()) {
					case "SY07000005":
					case "SY07000006":
						$("#hiddenPrductSeCode").val("SY20000005");
						ajaxJsonComboBox('/req/getmtrilSeqno.lims', 'eqpmnSeqno', { mtrilSeqno: $("#mtrilSeqno").val() }, true, null, null, null, function() {
							$("#eqpmnSeqno").val(item);
						});
						document.getElementById("eqpmnTr").style = "";
						break;
					default:
						$("#hiddenPrductSeCode").val('');
						$("#eqpmnSeqno").val('');
						$("#eqpmnTr").css("display", 'none');
						break;
				}
			}

			//의뢰 정보수정
			function requestUpdate() {

				if (!saveValidation('reqestFrm'))
					return;

				var params = {};
				$('#expriemCoChk').val(AUIGrid.getGridData(expriemGrid).length);

				var formData = setMtrilData();
				params.formData = formData;
				params.addedRequestDtlList = AUIGrid.getAddedRowItems(expriemGrid);   //추가된 시험항목
				params.editedRequestDtlList = AUIGrid.getEditedRowItems(expriemGrid); //수정된 시험항목
				params.removedRequestDtlList = AUIGrid.getRemovedItems(expriemGrid);  //삭제된 시험항목

				customAjax({
					url: '/req/updReqest.lims',
					data: params
				}).then(function(data) {
					if (data == '0') {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					} else if(data == '98') {
						warn('${msg.C100001248}'); /* 진행 상황 COA 완료 는 수정하실 수 없습니다 */
					} else if(data == '99') {
						warn('${msg.C100000288}'); /* Lot No.가 중복되었습니다. */
					} else {
						success('${msg.C100000762}'); /* 저장되었습니다. */
						btnStyle(false);
						requestSearch('U');
					}
				});

			}

			//의뢰 삭제
			function requestDelete() {

				if (!confirm('${msg.C100000461}'))
					return;

				customAjax({
					url: '/req/delReqest.lims',
					data: $('#reqestFrm').serializeObject()
				}).then(function(data) {
					if (data == '0') {
						err('${msg.C100000464}');//삭제를 실패 하였습니다.
					} else {
						success('${msg.C100000462}');//삭제되었습니다.
						frmReset();
						btnStyle(true); //버튼스타일
						requestSearch();
					}
				});
			}

			//조회
			function requestSearch(gubun) {
				if (!saveValidation("searchFrm"))
					return;

				//정보수정인 경우 폼 초기화 진행하지 않음
				if (gubun !== 'U') {
					frmReset();
					btnStyle(true);
				}
				getGridDataForm('<c:url value="/req/getRequestList.lims"/>', searchFrm, reqestGrid);
			}

			//의뢰시험항목 재조회
			function reInquire(reqestSeqno) {
				getGridDataParam('/req/getExpriemList.lims', { reqestSeqno: reqestSeqno }, expriemGrid);
			}

			//입력폼 초기화
			function frmReset() {

				AUIGrid.clearGridData(expriemGrid);
				clickStatus = '';

				btnStyle(true); //버튼 스타일
				$('#reqestSeqno').val('');
				$('#progrsSittnCode').val('');
				$('#reqestNo').val('');
				$('#mtrilSeqno').val('');
				$('#mtrilCode').val('');
				$('#mtrilNm').val('');
				$('#inspctTyCode').val('');
				datePickerCalendar(['reqestDte'],true);
				datePickerCalendar(['mnfcturDte'],true);
				$("#eqpmnTr").css("display", 'none');
				$("#prductSeCode").val('');
				$('#rm').val('');
				$('#custlabSeqno').val('');
				$('#lblDcOutptAt').val('');
				$('#sploreNm').val('');
				$('#elctcQy').val('');
				$('#elctcCn').val('');
				$('#prductDc').val('');
				$('#entrpsNm').val('');
				$('#entrpsSeqno').val('');
				$('#vendorLotNo').val('');
				$('#vendorCoaReqestSeqno').val('');
				$('#lotNo').val('');
				$('#lotNoSeqno').val('');
				$('#elctcSeqno').val('');

				//시료정보 element 초기상태로 되돌림
				$('#sploreNm').css("display", 'block');
				$('#sploreNm').prop("disabled", false);
				$('#sploreItemselectNm').children('option:not(:first)').remove();
				$('#sploreCylndrselectNm').children('option:not(:first)').remove();
				$('#sploreItemselectNm').next(".select2-container").hide();
				$('#sploreCylndrselectNm').next(".select2-container").hide();
			}

			//등록상태에 따른 버튼 스타일
			function btnStyle(gubun) {
				if (gubun) {
					$('#btnSave').css('display', 'inline-block');
					$('#btnUpdate').css('display', 'none');
					$('#btnDelete').css('display', 'none');
				} else {
					$('#btnSave').css('display', 'none');
					$('#btnUpdate').css('display', 'inline-block');
					$('#btnDelete').css('display', 'inline-block');
				}
			}

			function copyObj(obj) {
				var result = {};
				for (var key in obj) {
					if (typeof obj[key] === 'object')
						result[key] = copyObj(obj[key]);
					else
						result[key] = obj[key];
				}
				return result;
			}

			function doSearch() {
				requestSearch();
			}

		</script>
