<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">접수</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000663}</h2> <!-- 의뢰 결재 -->
				<div class="btnWrap">
					<button type="button" id="btnRtn" class="save">${msg.C100000343}</button> <!-- 반려 -->
					<button type="button" id="btnRtnHidden" style="display: none"></button>
					<button type="button" id="btnSanctn" class="save">${msg.C100000533}</button> <!-- 승인 -->
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm">
					<table style="width:100%" class="subTable1">
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
							<td>
								<select class="wd100p" id="bplcCodeSch" name="bplcCodeSch"></select>
							</td>
							<th>${msg.C100000717}</th> <!-- 자재 명 -->
							<td>
								<input type="text" class="wd100p schClass" name="mtrilNmSch" id="mtrilNmSch" maxLength="200"/>
							</td>
							<th>${msg.C100000056}</th> <!-- Lot No. -->
							<td>
								<input type="text" class="wd100p schClass" name="lotNoSch" id="lotNoSch" maxLength="20">
							</td>
							<th>${msg.C100000657}</th> <!-- 의뢰 번호 -->
							<td>
								<input type="text" class="wd100p schClass" name="reqestNoSch" id="reqestNoSch" maxLength="11">
							</td>
						</tr>
						<tr>
							<th>${msg.C100000139}</th> <!-- 검사 유형 -->
							<td>
								<select class="wd100p" id="inspctTyCodeSch" name="inspctTyCodeSch">
									<option>${msg.C100000480}</option> <!-- 선택 -->
								</select>
							</td>
							<th class="necessary">${msg.C100000659}</th><!-- 의뢰 일자 -->
							<td>
								<input type="text" id="stReqestDteSch" name="stReqestDteSch" class="wd6p schClass" style="min-width: 6em;" required> ~
								<input type="text" id="enReqestDteSch" name="enReqestDteSch" class="wd6p schClass" style="min-width: 6em; margin-left: 3px;" required>
							</td>
							<th>${msg.C100000803}</th><!-- 제조 일자 -->
							<td>
								<input type="text" id="stMnfcturDteSch" name="stMnfcturDteSch" class="wd6p schClass" style="min-width: 6em;"> ~
								<input type="text" id="enMnfcturDteSch" name="enMnfcturDteSch" class="wd6p schClass" style="min-width: 6em; margin-left: 3px;">
							</td>
							<th>${msg.C100000666}</th><!-- 의뢰팀 -->
							<td>
								<select id="reqestBplcCodeSch" name="reqestBplcCodeSch" class="wd6p" style="min-width: 6em"></select>
								<select id="reqestDeptCodeSch" name="reqestDeptCodeSch" class="wd13p" style="min-width: 13em"></select>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<div id="requestSanctnGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT15">
				<h3>${msg.C100000555}</h3>  <!-- 시험항목 -->
			</div>
			<div class="subCon2">
				<div id="expriemGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>

			var requestSanctnGrid = 'requestSanctnGrid';
			var expriemGrid = 'expriemGrid';
			var searchFrm = 'searchFrm';
			var lang = ${msg};

			$(document).ready(function() {
				setCombo();

				setGrid();

				setGridEvent();

				setButtonEvent();

				setEtcEvent();

				gridColResize([requestSanctnGrid, expriemGrid], '1');

				datePickerCalendar(['stReqestDteSch','enReqestDteSch'], true, ['DD',-7], ['DD',0]);
				datePickerCalendar(['stMnfcturDteSch','enMnfcturDteSch']);

				/**
				 * 반려 dialog의 사용법이 바뀌었음 수정필요
				 */
				dialogRtnSanctn("btnRtnHidden",null,"rtnDialog",requestSanctnGrid,function(data){
					var rtnGridData = AUIGrid.getCheckedRowItemsAll(requestSanctnGrid);
					
					
					for(var i=0; i<rtnGridData.length; i++){
						rtnGridData[i].rtnResn = data.rtnResn;
					}

					customAjax({
						'url' :	'<c:url value="/req/updRtn.lims"/>',
						'data' : rtnGridData,
						'successFunc' : function(data){
							if(data == 1) {
								success('${msg.C100000344}'); //반려되었습니다.
								searchRequestSanctnList();
							} else if(data == 99) {
								err('${msg.C100000575}'); //실패하였습니다.
							}
						}
					});
				});
			});

			function setCombo() {
				//검사 유형
			 	ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctTyCodeSch', {'upperCmmnCode' : 'SY07'}, true, '${msg.C100000480}'); //선택

				//진행 상황
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'progrsSittnCodeSch', {'upperCmmnCode' : 'IM03'}, true, '${msg.C100000480}'); //선택

				//검색폼 : 의뢰팀 사업장
				ajaxJsonComboBox('/com/getDeptCombo.lims','reqestBplcCodeSch',{ 'bestInspctInsttAt' : 'Y' }, true).then(function(){
					$('#reqestBplcCodeSch').val('${UserMVo.bestInspctInsttCode}');
					$('#reqestBplcCodeSch option').not(':selected').prop('disabled',('${UserMVo.authorSeCode}' != 'SY09000001'));
				});

				//검색폼 : 의뢰팀
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'},true).then(function(){
					$('#reqestDeptCodeSch').val('${UserMVo.deptCode}');
					$('#reqestDeptCodeSch option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
				});
			}

			function setGrid() {
				var requestSanctnCol = [];
				auigridCol(requestSanctnCol);

				var expriemCol = [];
				auigridCol(expriemCol);

				var rowProp = {
					enableCellMerge : true,
					cellMerge : true,
					rowSelectionWithMerge : true
				};

				requestSanctnCol.addColumnCustom('reqestSeqno','reqestSeqno',null,false) // 의뢰일렬번호
				.addColumnCustom('bplcCode','bplcCode','*',false,false) //사업장
				.addColumnCustom('bplcNm','${msg.C100000432}','*',true,false) //사업장
				.addColumnCustom('mtrilNm','${msg.C100000717}','*',true,false) //자재명
				.addColumnCustom('reqestNo','${msg.C100000657}','*',true,false) //의뢰번호
				.addColumnCustom('inspctTyCode','inspctTyCode','*',false,false) //검사유형
				.addColumnCustom('inspctTyCodeNm','${msg.C100000139}','*',true,false) //검사유형명
				.addColumnCustom('reqestDte','${msg.C100000659}','*',true,false) //의뢰일자
				.addColumnCustom('mnfcturDte','${msg.C100000803}','*',true,false) //제조일자
				.addColumnCustom('emrgncyAt','${msg.C100000247}','*',true,false) //긴급여부
				.addColumnCustom('lotNo','${msg.C100000056}','*',true,false) //Lot No.
				.addColumnCustom('vendorLotNo','${msg.C100000961}','*',true,false) //협력업체 Lot No.
				.addColumnCustom('reqestDeptNm','${msg.C100000666}','*',true,false) //의뢰팀
				.addColumnCustom('clientNm','${msg.C100000665}','*',true,false) //의뢰자
				.addColumnCustom('rereqestNum','${msg.C100000757}','*',true,false) //재의뢰 건수
				.addColumnCustom('progrsSittnCode','progrsSittnCode','*',false,false) //진행상황코드
				.addColumnCustom('progrsSittnCodeNm','${msg.C100000846}','*',true,false) //진행상황
				.addColumnCustom('rm','${msg.C100000425}','*',true,false); //비고

				expriemCol.addColumnCustom('reqestExpriemSeqno','reqestExpriemSeqno',null,false) //의뢰시험항목일련번호
				.addColumnCustom('expriemSeqno','expriemSeqno',null,false) //시험항목일련번호
				.addColumnCustom('expriemNm','${msg.C100000560}','*',true,false) //시험항목 명
				.addColumnCustom('frstAnalsAt','${msg.C100000870}','*',true,false) //초
				.addColumnCustom('middleAnalsAt','${msg.C100000836}','*',true,false) //중
				.addColumnCustom('lastAnalsAt','${msg.C100000301}','*',true,false) //말
				.addColumnCustom('rm','${msg.C100000425}','*',true,false,rowProp) //비고
				.checkBoxRenderer(['frstAnalsAt'],expriemGrid,{check:'Y',unCheck:'N'})
				.checkBoxRenderer(['middleAnalsAt'],expriemGrid,{check:'Y',unCheck:'N'})
				.checkBoxRenderer(['lastAnalsAt'],expriemGrid,{check:'Y',unCheck:'N'});

				var requestSanctnProp = {
					editable : false,
					selectionMode : 'multipleCells',
					showRowCheckColumn : true,
				};

				requestSanctnGrid = createAUIGrid(requestSanctnCol, 'requestSanctnGrid', requestSanctnProp);

				expriemGrid = createAUIGrid(expriemCol, 'expriemGrid', { editable : false, selectionMode : 'multipleCells'});

				gridResize([requestSanctnGrid, expriemGrid]);
			}

			function setGridEvent() {
				AUIGrid.bind(requestSanctnGrid, 'cellDoubleClick', function(event) {
					searchExpriemList(event.item);
				});
			}

			function setButtonEvent() {
				// 조회폼 enter key event
				$(".schClass").keypress(function(e) {
					setTimeout(function() {
						if(e.which == 13) {
							if(typeof(searchRequestSanctnList) != "undefined") {
								searchRequestSanctnList();
							}
						}
					}, 100);
				})
				//의뢰결재 조회
				$('#btnSearch').click(function() {
					searchRequestSanctnList();
				});

				//의뢰결재 승인
				$('#btnSanctn').click(function() {
					var approvalGridData = AUIGrid.getCheckedRowItemsAll(requestSanctnGrid);
					if(approvalGridData.length <= 0) {
						alert('${msg.C100000869}'); //체크된 행이 없습니다.
						return;
					}
					requestSanctnSave(approvalGridData);
				});

				//의뢰결재 반려
				$('#btnRtn').click(function() {
					var rtnGridData = AUIGrid.getCheckedRowItemsAll(requestSanctnGrid);
					if(rtnGridData.length <= 0) {
						alert('${msg.C100000869}'); //체크된 행이 없습니다.
						return;
					}
					$('#btnRtnHidden').trigger('click');
				});
			}

			function setEtcEvent() {
				//검색폼 의뢰팀 사업장 변경 시 의뢰팀 리로드
				$('#reqestBplcCodeSch').change(function() {
					var selectBplcCode = this.value;
					if (!!selectBplcCode) {
						ajaxJsonComboBox('/wrk/getDeptComboList.lims','reqestDeptCodeSch',{'bestInspctInsttCode':selectBplcCode},true).then(function(){
							if ('${UserMVo.bestInspctInsttCode}' == selectBplcCode)
								$('#reqestDeptCodeSch').val('${UserMVo.deptCode}');
							$('#reqestDeptCodeSch option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
						});
					}
				});
			}

			//의뢰결재 조회
			function searchRequestSanctnList() {
				if(!saveValidation("searchFrm")) {
					return;
				}
				AUIGrid.clearGridData(requestSanctnGrid);
				AUIGrid.clearGridData(expriemGrid);
				getGridDataForm('<c:url value="/req/getRequestSanctnList.lims"/>', searchFrm, requestSanctnGrid, function() {
					getSanctnCnt();
				});
			}

			//의뢰결재 시험항목 조회
			function searchExpriemList(item) {
				AUIGrid.clearGridData(expriemGrid);
				getGridDataParam('<c:url value="/req/getExpriemSanctnList.lims"/>', item, expriemGrid);
			}

			//승인
			function requestSanctnSave(approvalGridData) {
				customAjax({
					'url' : '<c:url value="/req/updApproval.lims"/>',
					'data' : approvalGridData,
					'successFunc' : function(data) {
						if(data == 1) {
							success('${msg.C100000534}'); //승인되었습니다.
							searchRequestSanctnList();
						} else if(data == 99) {
							err('${msg.C100000575}'); //실패하였습니다.
						}
					}
				});
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>