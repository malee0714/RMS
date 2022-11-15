<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
    	<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000026}</h2><!-- COA 양식 목록 -->
				<div class="btnWrap">
					<button type="button" id="searchBtn" class="search">${msg.C100000767}</button><!-- 조회 -->
				</div>
				<form action="javascript:;" id="searchFrmPrintng" name="searchFrmPrintng">
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
							<th>${msg.C100000892}</th><!-- 출력물 구분 -->
							<td><select id="printngSeCodeSch" name="printngSeCodeSch" disabled="disabled"></select></td>
							<th>${msg.C100000893}</th><!-- 출력물 명 -->
							<td><input type="text" id="printngNmSch" name="printngNmSch" class="schClass"></td>
							<th>${msg.C100000896}</th><!-- 출력물 파일 명 -->
							<td><input type="text" id="printngUploadFileNmSch" name="printngUploadFileNmSch" class="schClass"></td>
							<th>${msg.C100000587}</th><!-- 업체명 -->
							<td><input type="text" id="entrpsNmSch" name="entrpsNmSch" class="schClass"></td>
						</tr>
						<tr>
							<%--<th>${msg.C100000435}</th> <!-- 사업장 명 -->
							<td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>--%>
							<th>${msg.C100000717}</th><!-- 자재명 -->
							<td><input type="text" id="mtrilNmSch" name="mtrilNmSch" class="schClass"></td>
							<th>${msg.C100000443}</th><!-- 사용여부 -->
							<td style="text-align:left;" colspan="3">
								<label><input type="radio" name="useAtSch" value="all" >${msg.C100000779}</label><!-- 전체 -->
								<label><input type="radio" name="useAtSch" value="Y" checked >${msg.C100000439}</label><!-- 사용 -->
								<label><input type="radio" name="useAtSch" value="N">${msg.C100000449}</label><!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="mgT15">
				<div id="printngGrid" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100000027}</h2><!-- COA 양식 목록 상세 -->
				<div class="btnWrap">
					<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button><!-- 신규 -->
					<button type="button" id="btn_delete" class="delete" style="display:none">${msg.C100000458}</button><!-- 삭제 -->
					<button type="button" id="btn_save" class="save">${msg.C100000760}</button><!-- 저장 -->
				</div>
				<form id="frmPrintng" name="frmPrintng">
					<table class="subTable1" style="width: 100%">
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
							<th class="necessary">${msg.C100000892}</th><!-- 출력물 구분 -->
							<td><select id="printngSeCode" name="printngSeCode" disabled="disabled"></select></td>

							<th class="necessary">${msg.C100000893}</th><!-- 출력물 명 -->
							<td><input type="text" id="printngNm" name="printngNm" max="200" /></td>

							<th class="necessary">${msg.C100000896}</th><!-- 출력물 파일명 -->
							<td><input type="text" id="printngUploadFileNm" name="printngUploadFileNm" maxlength="200" /></td>

							<th class="necessary">${msg.C100000587}</th><!-- 업체명 -->
							<td>
								<input type="text" id="entrpsSeqnoNm" name="entrpsSeqnoNm" class="wd63p" disabled  />
								<input type="hidden" id="entrpsSeqno" name="entrpsSeqno" required />
								<button type="button" id="btnEntrpsSeqno" class="search inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button><!-- 찾기 -->
								<button type="button" id="entrpsReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000717}</th> <!-- 제품명 -->
							<td>
								<input type="text" id="mtrilSeqnoNm" name="mtrilSeqnoNm" class="wd63p" disabled />
								<input type="hidden" id="mtrilSeqno" name="mtrilSeqno" required />
								<button type="button" id="btnMtrilSeqno" class="search inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button><!-- 찾기 -->
								<button type="button" id="mtrilReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
							</td>

							<th>${msg.C100001364}</th> <!-- 고객사 자재 코드 -->
							<td><input type="text" id="ctmmnyMtrilCode" name="ctmmnyMtrilCode" class="wd100p" maxlength="20"></td>

							<th>평균 적용 여부</th> <!-- 평균 적용 여부 -->
							<td style="text-align:left;">
								<label><input type="radio" id="avrgApplcAtY" name="avrgApplcAt" value="Y"/>Y</label>
								<label><input type="radio" id="avrgApplcAtN" name="avrgApplcAt" value="N" checked/>N</label>
							</td>

							<th>확장자</th><!-- 확장자 -->
							<td style="text-align:left;">
								<label><input type="radio" id="exExt" name="dwldFileSeCode" value="SY17000001" checked/>EXCEL</label>
								<label><input type="radio" id="csExt" name="dwldFileSeCode" value="SY17000002"/>CSV</label>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000443}</th><!-- 사용여부 -->
							<td style="text-align:left;" colspan="6">
								<label><input type="radio" id="useAtY" name="useAt" value="Y" checked/>${msg.C100000439}</label><!-- 사용 -->
								<label><input type="radio" id="useAtN" name="useAt" value="N"/>${msg.C100000449}</label><!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th><!-- 비고 -->
							<td colspan="6">
								<textarea id="rm" name="rm" class="wd100p" rows="2" maxlength="4000"></textarea>
								<input type="hidden" id="printngSeqno" name="printngSeqno" />
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000860}</th><!-- 첨부파일 -->
							<td colspan="7">
								<input type="file" id="printingFile" />
								<input type="hidden" id="histVer" name="histVer" />
								<a id="coaDownload" style="cursor:pointer; margin-left:20px;"></a>
								<p style="color:red; float:right;">${msg.C100000917}</p>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var lang = ${msg};
			var printngGrid = 'printngGrid';
			var sessionObj = {
				bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
				deptCode : '${UserMVo.deptCode}'
			};

			$(function() {
				getAuth();

				setGrid();

				setGridEvent();

				setButtonEvent();

				setCombo();

				gridResize([printngGrid]);

				dialogEntrps('btnEntrpsSeqno', null, 'entrpsDialog', function(data){
					$('#entrpsSeqnoNm').val(data['entrpsNm']);
					$('#entrpsSeqno').val(data['entrpsSeqno']);
				}, null);

				/*var mtrilData = {
						bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
						authorSeCode : '${UserMVo.authorSeCode}'
				};*/

				dialogMtril('btnMtrilSeqno', 'CoaFormM', 'Product', null, function(item){
					var item = item[0];
					$('#mtrilSeqno').val(item.mtrilSeqno);
					$('#mtrilSeqnoNm').val(item.mtrilNm);
				}, sessionObj);

			});

			function setGrid(){
				printngGridCol = [];
				auigridCol(printngGridCol);

				printngGridCol.addColumnCustom('printngSeCodeNm','${msg.C100000892}',null,true,false) //출력물 구분
				.addColumnCustom('printngSeqno','출력물 일렬번호',null,false,false) //출력물 일렬번호
				.addColumnCustom('printngNm','${msg.C100000893}',null,true,false) //출력물 명
				.addColumnCustom('printngUploadFileNm','${msg.C100000896}',null,true,false) //출력물 파일명
				.addColumnCustom('entrpsSeqnoNm','${msg.C100000587}',null,true,false) //업체명
				//.addColumnCustom('bplcCodeNm','${msg.C100000435}',null,true,false) //사업장명
				.addColumnCustom('mtrilSeqnoNm','${msg.C100000717}',null,true,false) //자재명
				.addColumnCustom('ctmmnyMtrilCode','${msg.C100001364}',null,true,false) //고객사 자재 코드
				.addColumnCustom('avrgApplcAt','평균 적용 여부',null,true,false) //평균 적용 여부
				.addColumnCustom('useAt','${msg.C100000443}',null,true,false) //사용여부
				.addColumnCustom('rm','${msg.C100000425}',null,true,false) //비고
				.addColumnCustom('atchmnflSeqno','atchmnflSeqno',null,false,false); //첨부파일

				printngGrid = createAUIGrid(printngGridCol, printngGrid, { selectionMode : 'multipleCells' });

			};

			// 그리드 이벤트
			function setGridEvent(){

				AUIGrid.bind(printngGrid, 'ready', function(event) {
					gridColResize(printngGrid, '2');
				});

				AUIGrid.bind(printngGrid, 'cellDoubleClick', function(event) {

					resetFrm();
					$("#btn_delete").show();

					var item = event.item;

					$('#printngSeqno').val(item.printngSeqno);
					$('#histVer').val(item.histVer);
					$('#printngSeCode').val(item.printngSeCode);
					$('#printngNm').val(item.printngNm);
					$('#printngUploadFileNm').val(item.printngUploadFileNm);
					$('#entrpsSeqno').val(item.entrpsSeqno);
					$('#entrpsSeqnoNm').val(item.entrpsSeqnoNm);
					//$('#bplcCode').val(item.bplcCode);
					$('#mtrilSeqno').val(item.mtrilSeqno);
					$('#mtrilSeqnoNm').val(item.mtrilSeqnoNm);
					$('#ctmmnyMtrilCode').val(item.ctmmnyMtrilCode);
					$('#rm').val(item.rm);
					if('Y' == item.avrgApplcAt) {
						$('input:radio[id="avrgApplcAtY"]').prop('checked', true);
					} else if('N' == item.useAt) {
						$('input:radio[id="avrgApplcAtN"]').prop('checked', true);
					}
					if('Y' == item.useAt) {
						$('input:radio[id="useY"]').prop('checked', true);
					} else if('N' == item.useAt) {
						$('input:radio[id="useN"]').prop('checked', true);
					}
					if('SY17000001' == item.dwldFileSeCode) {
						$('input:radio[id="exExt"]').prop('checked', true);
					} else if('SY17000002' == item.dwldFileSeCode) {
						$('input:radio[id="csExt"]').prop('checked', true);
					}
					$('#coaDownload').html(item.printngOrginlFileNm);

				});
			}

			// 버튼 이벤트
			function setButtonEvent(){

				// 조회
				$('#searchBtn').click(function(){
					AUIGrid.clearGridData(printngGrid);
					searchPrintngGrid();
				});

				// 저장
				$('#btn_save').click(function(){
					savePrintngGrid();
				});

				// 신규
				$('#btn_new').click(function(){
					resetFrm();
				})

			    //삭제
			    $('#btn_delete').click(function(e){
			    	if($('#printngSeqno').val() == '' || $('#printngSeqno').val() == null || $('#printngSeqno').val() == 'undifined') {
			    		alert('${msg.C100000496}'); /* 선택된 출력물이 없습니다. */
			    	} else {
				    	if(confirm('${msg.C100000461}')){ /* 삭제 하시겠습니까? */
				        	ajaxJsonForm('<c:url value="/wrk/deleteCoaFormM.lims"/>', 'frmPrintng', function (data) {
				        		if(data == 0){
				        			err('${msg.C100000464}') /* 삭제에 실패하였습니다. */
				        		} else {
				        			success('${msg.C100000460}'); /* 삭제 되었습니다. */
				        			resetFrm();
				        			searchPrintngGrid();
				        		}
				        	});
				    	}
			    	}
			    });

				//RD 다운로드
				$('#coaDownload').click(function(){

					var rdData = AUIGrid.getSelectedItems(printngGrid);
					if(rdData.length > 0) {
						var printngSeqno = rdData[0].item.printngSeqno;
						var histVer = rdData[0].item.histVer;
						location.href = '/wrk/getCoaDownload.lims?printngSeqno=' + printngSeqno + '&histVer=' + histVer;
					}
				});

				// $('#bplcCode').change(function() {
				// 	$('#mtrilSeqno').val('');
				// 	$('#mtrilSeqnoNm').val('');
				// 	$('#Product_popBestInspctInsttCode').val(this.value);
				// });

				//업체 초기화 버튼
				$('#entrpsReset').click(function() {
					$('#entrpsSeqno').val('');
					$('#entrpsSeqnoNm').val('');
				});

				//자재 초기화 버튼
				$('#mtrilReset').click(function() {
					$('#mtrilSeqno').val('');
					$('#mtrilSeqnoNm').val('');
				});
			};

			function setCombo(){
				/*ajaxJsonComboBox('/wrk/getBestComboList.lims', '#bplcCode', null, null, null, '${UserMVo.bestInspctInsttCode}', null, function(e) {
					var sysAuth = '${UserMVo.authorSeCode}';
					if(sysAuth == 'SY09000001')
						$( '#bplcCode' ).prop( 'disabled', false );
					else
						$( '#bplcCode' ).prop( 'disabled', true );
				});*/
				ajaxJsonComboBox('/com/getCmmnCode.lims','printngSeCodeSch',{'upperCmmnCode' : 'SY15'}, true, null, 'SY15000002');
				ajaxJsonComboBox('/com/getCmmnCode.lims','printngSeCode',{'upperCmmnCode' : 'SY15'}, true, null, 'SY15000002');
			};

			 //조회
			function searchPrintngGrid(returnSeq){
				getGridDataForm('<c:url value="/wrk/getCoaFormMList.lims"/>', 'searchFrmPrintng', printngGrid, function() {
					if (returnSeq)
						gridSelectRow(printngGrid, "printngSeqno", returnSeq);
				});
			}

			//저장
			function savePrintngGrid(){

				if(!saveValidation('frmPrintng')){ return false; }

				var printngSeqno = $('#printngSeqno').val();
				var newfileCheck = $('#printingFile').val();
				if(printngSeqno == '' && newfileCheck == '') {
					warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
					return;
				}else {
					dataSave();
				}
			}

			//저장
			function dataSave(){

				var printngSeqno = $('#printngSeqno').val();
				var newfileCheck = $('#printingFile').val();

				var formData = new FormData();

				if(printngSeqno == '' || (printngSeqno != '' && newfileCheck != '')) {

					var file = $('#printingFile')[0];
					var fileName = file.files[0].name;
					var fileExt1 = fileName.substring(fileName.length, fileName.length-4);
					var fileExt2 = fileName.substring(fileName.length, fileName.length-3);

					if(fileExt1.toUpperCase() != "XLSX" && fileExt2.toUpperCase() != "XLS"){
						warn('XLSX, XLS ' + '${msg.C100000066}'); /* mrd 확장자만 업로드 할 수 있습니다. */
						return;
					}

					formData.append('formFile', $('#printingFile')[0].files[0]);
				}

				formData.append('printngSeqno', $('#printngSeqno').val());
				if(newfileCheck != '')
					formData.append('histVer', $('#histVer').val());
				else
					formData.append('histVer', '');
				formData.append('printngNm', $('#printngNm').val());
				formData.append('printngUploadFileNm', $('#printngUploadFileNm').val());
				formData.append('entrpsSeqno', $('#entrpsSeqno').val());
				formData.append('mtrilSeqno', $('#mtrilSeqno').val());
				formData.append('ctmmnyMtrilCode', $('#ctmmnyMtrilCode').val());
				formData.append('avrgApplcAt', $('input[name="avrgApplcAt"]:checked').val());
				formData.append('useAt', $('input[name="useAt"]:checked').val());
				formData.append('dwldFileSeCode', $('input[name="dwldFileSeCode"]:checked').val());
				formData.append('rm', $('#rm').val());
				//formData.append('bplcCode', $('#bplcCode').val());

				showLoadingbar();

				ajaxJsonFormFile('/wrk/saveCoaFormM.lims', formData, function(data) {
					success('${msg.C100000765}'); /* 저장되었습니다. */
					resetFrm();
					searchPrintngGrid(data);
					hideLoadingbar();
				}, function() {
					err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					hideLoadingbar();
				}, null);
			}

			function resetFrm(){
				$("#btn_delete").hide();
				$('#frmPrintng')[0].reset();
				$('#printngSeqno').val('');
				$('#histVer').val('');
				$('#entrpsSeqno').val('');
				$('#mtrilSeqno').val('');
				$('#printngSeCode').val('SY15000002');
				$('#coaDownload').text('');
			}

	        function doSearch() {
	        	searchPrintngGrid();
	        }

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
