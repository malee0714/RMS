<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title"></tiles:putAttribute>
    <tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000551}</h2> <!-- 시험방법 목록 -->
				<div class="btnWrap">
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
							<th >${msg.C100000550}</th> <!-- 시험방법 명 -->
							<td><input type="text" id="exprMthNmSearch" name="exprMthNmSearch" class="schClass" maxlength="100"></td>
							<th >${msg.C100000443}</th> <!-- 사용여부 -->
							<td colspan="3" style="text-align:left;">
								<label><input type="radio" name="useAtSearch" value="">${msg.C100000779}</label> <!-- 전체 -->
						    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="mgT15">
				<div id="exprMthGrid" style="height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100000552}</h2> <!-- 시험방법 상세 정보 -->
				<div class="btnWrap">
					<button id="btnReset_Tab1" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button id="btnSave_Tab1" class="save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<form id="exprMthFrm" name="exprMthFrm" onSubmit="return false;">
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
							<th class="necessary">${msg.C100000550}</th> <!-- 시험방법 명 -->
							<td><input type="text" name="exprMthNm" id="exprMthNm" required maxlength="200"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
									<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
									<label><input type="radio" name="useAt" id="useN" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th> <!-- 비고 -->
							<td colspan="7">
								<textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" maxlength="4000"></textarea>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000479}</th> <!-- 서명 첨부 파일 -->
							<td colspan="7">
								<div id="dropZoneArea" style="text-align: left;"></div>
								<input type="button" id="btnSave_file" name="btnSave_file" style="display:none;"/>
								<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" />
							</td>
						</tr>
					</table>
					<input type="text" name="exprMthSeqno" id="exprMthSeqno" style="display:none"/>
					<input type="text" name="newExprMthSeqno" id="newExprMthSeqno" style="display:none"/>
				</form>
			</div>
		</div>
    </tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var lang = ${msg}; //기본언어
			var searchFrm = 'searchFrm'; //검색폼
			var exprMthFrm = 'exprMthFrm'; //입력폼
			var exprMthGrid = 'exprMthGrid'; //시험방법그리드
			var dropZoneArea; //첨부파일
			var putStatus_Tab1 = 'C'; //C : insert, U : update
			var saveKey = "";

			$(function(){
				getAuth();

				setButtonEvent();

				setExprMthGrid();

				setExprMthGridEvent();

				gridResize([exprMthGrid]);

			});

			// 그리드 생성
			function setExprMthGrid(){
				var exprMthCol = [];
				auigridCol(exprMthCol);

				exprMthCol.addColumnCustom("exprMthNm","${msg.C100000550}",null,true) //시험방법 명
				.addColumnCustom("rm","${msg.C100000425}",null,true) //비고
				.addColumnCustom("useAt","${msg.C100000443}",null,true); //사용여부

				exprMthGrid = createAUIGrid(exprMthCol, exprMthGrid, { wordWrap : true });

				dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnSave_file", maxFiles : 5, lang : "${msg.C100000867}" /* 첨부할 파일을 이 곳에 드래그하세요. */});
			}

			function setButtonEvent(){
				// 조회
				$('#btnSearch').click(function(){
					saveKey = '';
					//searchExprMth();
				});

				// 저장
				$('#btnSave_Tab1').click(function(){
					//atchmnflSave();
				});

				// 초기화
				$('#btnReset_Tab1').click(function(){
					frmReset_Tab1('초기화');
				});
			};

			//그리드 이벤트
			function setExprMthGridEvent(){
				AUIGrid.bind(exprMthGrid, 'cellDoubleClick', function(event) {
					$('#exprMthSeqno').val(event.item.exprMthSeqno);
					$('#exprMthNm').val(event.item.exprMthNm);
					$('#atchmnflSeqno').val(event.item.atchmnflSeqno);
					$('#rm').val(event.item.rm);
					$('#newExprMthSeqno').val(event.item.exprMthSeqno); // 새로저장 key값
					if(event.item.useAt == 'Y')
						$('#' + exprMthFrm + ' ' + '#useY').val(event.item.useAt).prop('checked', true);
					else
						$('#' + exprMthFrm + ' ' + '#useN').val(event.item.useAt).prop('checked', true);

					dropZoneArea.getFiles(event.item.atchmnflSeqno);

					frmReset_Tab1('선택');
				});

				// ready는 화면에 필수로 구현 할 것
				AUIGrid.bind(exprMthGrid, 'ready', function(event) {
					gridColResize(exprMthGrid, '2');	// 1, 2가 있으니 화면에 맞게 적용
					if(saveKey != null && saveKey != '')
						gridSelectRow(exprMthGrid, 'exprMthSeqno', [saveKey]);
				});
			};

			//조회
			// function searchExprMth(){
			// 	getGridDataForm('/wrk/getExprMthMList.lims', searchFrm, exprMthGrid);
			// 	frmReset_Tab1('초기화');
			// }

			//첨부 파일 저장
			function atchmnflSave() {
 				var files = dropZoneArea.getNewFiles();
 				var files_cnt = files.length;

 				var $saveBtn = $('#btnSave_file');

				if (files_cnt > 0) {
					$saveBtn.click();
					dropZoneArea.on('uploadComplete', function(event, fileIdx) {
						$('#atchmnflSeqno').val(fileIdx);
						saveExprMth();
					});
				} else { //첨부파일이 없을 시
					saveExprMth();
				}
			}

			//저장
			function saveExprMth() {

				if(!saveValidation('exprMthFrm'))
					return false;

				var param = $('#exprMthFrm').serializeObject();
				if(putStatus_Tab1 == 'C'){
					ajaxJsonForm('<c:url value="/wrk/insExprMthM.lims"/>', exprMthFrm, function (data) {
						if(!!data)
							success('${msg.C100000762}'); /* 저장 되었습니다. */

						$('#' + exprMthFrm + ' ' + '#exprMthSeqno').val(data);
						saveKey = data;

						frmReset_Tab1('저장완료');
					}, function (request,status,error) {
						err('${msg.C100000597}'); /* 오류가 발생했습니다. log를 참조해주세요. */
					});
				} else if(putStatus_Tab1 == 'U'){
					customAjax({
						url : '<c:url value="/wrk/updExprMthM.lims"/>',
						data : param
					}).then(function(data) {
						if(!!data)
							success('${msg.C100000528}'); /* 수정되었습니다. */
						$('#' + exprMthFrm + ' ' + '#exprMthSeqno').val(data);
						saveKey = data;

						frmReset_Tab1('저장완료');
					}, function(request, status, error) {
						err('${msg.C100000597}'); /* 오류가 발생했습니다. log를 참조해주세요. */
					});
				}
			}

			function frmReset_Tab1(sOption){
				if (sOption == '저장완료'){
					pageReset([exprMthFrm], null, null, function(){
						putStatus_Tab1 = 'C';
						searchExprMth();
					});
				}else if (sOption == '초기화'){
					pageReset([exprMthFrm], null, null, function(){
						putStatus_Tab1 = 'C';
					});
					putStatus_Tab1 = 'C';

					dropZoneArea.clear(); // 드랍존 클리어
				}else if (sOption == '선택'){
					putStatus_Tab1 = 'U';
				}
			}

			function doSearch(e){
				searchExprMth();
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
