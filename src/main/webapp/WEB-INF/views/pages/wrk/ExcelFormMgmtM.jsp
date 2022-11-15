<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title"></tiles:putAttribute>
    <tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000599}</h2> <!-- 엑셀 양식 목록 -->
				<div class="btnWrap">
					<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm" name="searchFrm" onsubmit="return false" >
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
							<th>${msg.C100000601}</th> <!-- 엑셀 파일 명 -->
							<td><input type="text" id="excelFileNmSch" name="excelFileNmSch" class="schClass"></td>
							<th>${msg.C100000598}</th> <!-- 엑셀 양식 명 -->
							<td><input type="text" id="excelFormNmSch" name="excelFormNmSch" class="schClass"></td>
							<th>${msg.C100000443}</th> <!-- 사용 여부 -->
							<td colspan="1" style="text-align:left;">
								<label><input type="radio" id="use_a" name="useAtSch" value="" >${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" id="use_y" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="use_n" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="mgT15">
		        <div id="ExcelFormMgmtGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
		    </div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>엑셀 양식 상세 정보</h2>
				<div class="btnWrap">
					<button id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		 		</div>
				<form id="excelForm">
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
		 					<th class="necessary">${msg.C100000601}</th> <!-- 엑셀 파일 명 -->
							<td style="text-align:left;">
								<input type="hidden" id="excelSeqno" name="excelSeqno" />
								<input type="file" id="formFile" class="wd100p" style="min-width: 10em;"><br>
								<a id="exDownload" style="cursor: pointer; margin-left: 20px;" ></a>
							</td>
							<th class="necessary">${msg.C100000581}</th> <!-- 양식명 -->
							<td><input type="text" id="excelFormNm" name="excelFormNm" maxlength="200" required></td>
		 					<th class="necessary">${msg.C100000731}</th> <!-- 작업 Sheet 명  -->
							<td style="text-align:left;"><input type="text" id="sheetChoiseNm" name="sheetChoiseNm" maxlength="200" required></td>
							<th class="necessary">${msg.C100000681}</th> <!-- 인쇄 Sheet 명 -->
							<td><input type="text" id="sheetPrntngNm" name="sheetPrntngNm" maxlength="200" required></td>
						</tr>
						<tr>
							<th>${msg.C100000443}</th> <!-- 사용 여부 -->
							<td colspan="1" style="text-align:left;">
								<label><input type="radio" id="useY" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="useN" name="useAt" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th> <!-- 비고 -->
				            <td colspan="13"><textarea id="rm" name="rm" rows="2" style="width:100%; vertical-align:bottom;" ></textarea></td>
						</tr>
					</table>
					<!-- input text가 양식명 1개여서 엔터키 누르면 폼값이 넘어가서 그냥 감추고 하나더 만들어서 막아둠>  -->
					<input type="text" style="display:none;"/>
					<input type="hidden" id="registerId" name="registerId" value="${UserMVo.userId}">
				</form>
			</div>
			<div class="subCon1 mgT20">
				<h3>${msg.C100001222}</h3> <!-- 엑셀 좌표 상세 정보 -->
				<div class="btnWrap">
		             <button type="button" id="btn_add" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
					 <button type="button" id="btn_remove" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
				</div>
	        </div>
	        <div class="mgT15">
				<div id="ExcelFormMgmtInfoGrid"  class="grid" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
		</div>
    </tiles:putAttribute>
    <tiles:putAttribute name="script">
		<!--  script 끝 -->
		<script>
			var ExcelFormMgmtGrid ='ExcelFormMgmtGrid';
			var ExcelFormMgmtInfoGrid = 'ExcelFormMgmtInfoGrid';

			$(function() {
				getAuth();

				setExcelFormMgmtGrid();

				setExcelFormMgmtGridEvent();

				setButtonEvent();

				gridResize([ExcelFormMgmtGrid, ExcelFormMgmtInfoGrid]);
			});

			function setExcelFormMgmtGrid() {

				var ExcelFormMgmtCol = [];
				auigridCol(ExcelFormMgmtCol);

				var ExcelFormMgmtInfoCol = [];
				auigridCol(ExcelFormMgmtInfoCol);

				//그리드 속성  중복값  및 유효성체크 영문대문자 시작 번호 끝
				var ExcelFormMgmtInfoPros = {
					editRenderer : {
						type : 'InputEditRenderer',
						validator : function(oldValue, newValue, item, dataField) {
							if(newValue != ''){
								if(oldValue != newValue) {
									// dataField 에서 newValue 값이 유일한 값인지 조사
									var isValid = AUIGrid.isUniqueValue(ExcelFormMgmtInfoGrid, dataField, newValue);
									if(isValid == false){
										return { 'validate' : isValid, 'message'  : '${msg.C100000838}' }; /!* 중복값이 존재 합니다. 다시 입력해 주세요 *!/
									} else {
										//유효성체크 영문대문자 시작 번호 끝
										var isValid = false;
										var matcher = /^[A-Z]+[0-9]+$/; // 시작 알파벳 대문자 끝 숫자

										if(matcher.test(newValue)) {
											isValid = true;
										}
										// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
										return { 'validate' : isValid, 'message'  : '${msg.C100000832}' }; /!* 좌표 입력은 (영문)대문자,숫자만 가능합니다 다시 입력해 주세요 *!/
									}
								}
							}
						}
					}
				};

				ExcelFormMgmtCol.addColumnCustom('excelSeqno', 'excelSeqno', null, false, false);	/* 파일 번호 */
				ExcelFormMgmtCol.addColumnCustom('excelFileNm', '${msg.C100000601}', null, true, false);	/* 엑셀 파일 명 */
				ExcelFormMgmtCol.addColumnCustom('excelFormNm', '${msg.C100000581}', null, true, false);	/* 양식 명 */
				ExcelFormMgmtCol.addColumnCustom('sheetChoiseNm', '${msg.C100000731}', null, true, false);	/* 작업 Sheet 명 */
				ExcelFormMgmtCol.addColumnCustom('sheetPrntngNm', '${msg.C100000681}', null, true, false);	/* 인쇄 Sheet 명 */
				ExcelFormMgmtCol.addColumnCustom('histVer', '${msg.C100000365}', null, true, false); /* 버전 */
				ExcelFormMgmtCol.addColumnCustom('rm', '${msg.C100000425}', null, true, false); /* 비고 */
				ExcelFormMgmtCol.addColumnCustom('useAt', '${msg.C100000443}', null, true, false); /* 사용 여부 */

				ExcelFormMgmtInfoCol.addColumnCustom('excelSeqno', 'excelSeqno', null, false, false); /* 파일 번호 */
				ExcelFormMgmtInfoCol.addColumnCustom('celSeqno', 'celSeqno', null, false, false); /* 셀 번호 */
				ExcelFormMgmtInfoCol.addColumnCustom('celDc', '${msg.C100000500}', null, true, true);  /* 설명 */
				ExcelFormMgmtInfoCol.addColumnCustom('celCrdnt', '${msg.C100000831}', null, true, true, ExcelFormMgmtInfoPros); /* 좌표 */
				ExcelFormMgmtInfoCol.addColumnCustom('celBassValue', '${msg.C100000230}', null, true, true); /* 기본 값 */

				ExcelFormMgmtGrid = createAUIGrid(ExcelFormMgmtCol, ExcelFormMgmtGrid); // 양식관리 그리드
				ExcelFormMgmtInfoGrid = createAUIGrid(ExcelFormMgmtInfoCol, ExcelFormMgmtInfoGrid); // 양식정보 그리드
			};

			function setExcelFormMgmtGridEvent() {
				// 그리드 리사이즈.
				gridResize([ExcelFormMgmtGrid]);

				// 그리드 칼럼 리사이즈
				AUIGrid.bind(ExcelFormMgmtGrid, 'ready', function(event) {
					gridColResize([ExcelFormMgmtGrid ],'2');	// 1, 2가 있으니 화면에 맞게 적용
				});

				AUIGrid.bind(ExcelFormMgmtGrid, 'cellDoubleClick', function(event) {
					$('#excelSeqno').val(event.item.excelSeqno);
					$('#excelFileNm').val(event.item.excelFileNm);
					$('#rm').val(event.item.rm);
					$('#useAt').val(event.item.useAt);
					$('#histVer').val(event.item.histVer);
					$('#excelFormNm').val(event.item.excelFormNm);
					$('#sheetChoiseNm').val(event.item.sheetChoiseNm);
					$('#sheetPrntngNm').val(event.item.sheetPrntngNm);
					// 셀 더블클릭할때 이미 저장된 파일 이름 불러와서 넣어줌
					$('#exDownload').html(event.item.excelFileNm);

					if(event.item.useAt == 'Y'){
						$('#useY').val(event.item.useAt).prop('checked', true);
					}else{
						$('#useN').val(event.item.useAt).prop('checked', true);
					}

					searchExinfo(event.item.excelSeqno); //엑셀 좌표 조회
				});

			}

			function setButtonEvent() {
				//엑셀 다운로드
				$('#exDownload').click(function() {
					var excelSeqno = $('#excelSeqno').val();
					if(!!excelSeqno) {
						location.href = '/wrk/getExDownload.lims?params=' + excelSeqno;
					} else {
						alert('${msg.C000000266}'); /* 다운로드할 엑셀 양식을 선택해주세요. */
					}
				});

				//신규
				$('#btn_new').click(function() {
					//폼 초기화
					reset();
					AUIGrid.clearSelection(ExcelFormMgmtGrid);
					AUIGrid.clearGridData(ExcelFormMgmtInfoGrid);
				});

				//행추가
				$('#btn_add').click(function() {
					addExForm();
				});

				//행삭제
				$('#btn_remove').click(function() {
					delCelForm();
				});

				//조회
				$('#btnSearch').click(function() {
					searchEx();
				});

				//저장 버튼 클릭 이벤트
				$('#btnSave').click(function() {
					//첨부파일 체크 : 선택된 파일, 저장된 파일이 모두 없을경우
					if(($('#exDownload').text() == '' || $('#exDownload').text() == null) &&
							($('#formFile').val() == '' || $('#formFile').val() == null)) {
						warn('${msg.C100000861}'); //첨부파일은 반드시 등록해주세요.
						return false;
					}

					//required null 값 체크
					if(!saveValidation('excelForm'))
						return false;

					save();
				});
			}

			// 메인 조회 함수
			function searchEx() {
				reset();
				getGridDataForm('<c:url value="/wrk/getExcelForm.lims"/>', 'searchFrm', ExcelFormMgmtGrid, function(data) {
					AUIGrid.clearGridData(ExcelFormMgmtInfoGrid);
				});
			}

			// 양식정보 조회
			function searchExinfo(excelSeqnoVal) {
				getGridDataParam('<c:url value="/wrk/getExcelInfo.lims"/>', { excelSeqno : excelSeqnoVal }, ExcelFormMgmtInfoGrid);
			}

			//저장
			function save() {
				//엑셀 좌표 그리드에 추가 및 수정된 값을 하나로 합침
				var concatAddEditRowItems = AUIGrid.getAddedRowItems(ExcelFormMgmtInfoGrid).concat(AUIGrid.getEditedRowItems(ExcelFormMgmtInfoGrid));
				//신규가 아니며 엑셀좌표그리드에 추가 및 수정의 경우 시퀀스 SET
				if(concatAddEditRowItems.length > 0 && !!$('#excelSeqno').val()) {
					for(var i = 0; i < concatAddEditRowItems.length; i++) {
						concatAddEditRowItems[i].excelSeqno = $('#excelSeqno').val();
					}
				}

				var formData = new FormData();
				var file = $('#formFile')[0];
				if(!$('#excelSeqno').val() || file.files.length == 1) {
					//신규 & 파일 수정
					var fileName = file.files[0].name;
					if(!(fileName.substring(fileName.length, fileName.length-4).toUpperCase() == 'XLSX' ||
							fileName.substring(fileName.length, fileName.length-3).toUpperCase() == 'XLS')) {
						warn('xlsx, xls ' + '${msg.C100000066}'); /* xlsx, xls 확장자만 업로드 할 수 있습니다. */
						return;
					}
					formData.append('formFile', file.files[0]);
					//파일 수정
					if(!!$('#excelSeqno').val()) {
						var idxArr = AUIGrid.getRowIndexesByValue(ExcelFormMgmtGrid, 'excelSeqno', [$('#excelSeqno').val()]);
						var sameIdxGridData = AUIGrid.getItemByRowIndex(ExcelFormMgmtGrid, idxArr[0]);
						formData.append('histVer', sameIdxGridData.histVer);
					}
				}

				if(!!$('#excelSeqno').val())
					formData.append('excelSeqno', $('#excelSeqno').val());

				formData.append('useAt', $('input[name="useAt"]:checked').val()); //사용여부
				formData.append('param', JSON.stringify(concatAddEditRowItems, ['celCrdnt','celBassValue','celDc','excelSeqno','celSeqno'])); //엑셀좌표 그리드
				formData.append('rm', $('#rm').val()); //비고
				formData.append('sheetChoiseNm', $('#sheetChoiseNm').val()); //작업Sheet명
				formData.append('sheetPrntngNm', $('#sheetPrntngNm').val()); //인쇄Sheet명
				formData.append('excelFormNm',$('#excelFormNm').val()); //양식명

				showLoadingbar();

				ajaxJsonFormFile('/wrk/exUpload.lims', formData, function(data){
					success('${msg.C100000765}'); /* 저장되었습니다. */
					reset();
					searchEx();
					AUIGrid.clearGridData(ExcelFormMgmtInfoGrid);
				}, function(){
					err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
				});

				hideLoadingbar();
			}

			//셀 추가
			function addExForm() {
				AUIGrid.addRow(ExcelFormMgmtInfoGrid, {}, 'last');
			};

			//셀 삭제
			function delCelForm() {
				var selected = AUIGrid.getSelectedItems(ExcelFormMgmtInfoGrid);
				if(selected.length > 0) {
					AUIGrid.removeRow(ExcelFormMgmtInfoGrid, 'selectedIndex');
					var delItem = AUIGrid.getRemovedItems(ExcelFormMgmtInfoGrid);
					var deFilNo = delItem[0].excelSeqno;
					customAjax({ url : '/wrk/delCelForm.lims', data : delItem, 'successFunc' : function(data) {
							if(data > 0) {
								success('${msg.C100000462}'); /* 삭제되었습니다. */
								searchExinfo(deFilNo);
							}
						}
					});
				}
			}

			//초기화
			function reset(){
				pageReset(['excelForm'], null, null, function(){ $('#exDownload').text(''); });
			}

			//엔터키 이벤트
			function doSearch(e) {
				searchEx();
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
