<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000894}</h2><!-- 출력물 목록 -->
				<div class="btnWrap">
					<button type="button" id="searchBtn" class="search">${msg.C100000767}</button><!-- 조회 -->
				</div>
				<form action="javascript:;" id="searchFrmPrintng" name="searchFrmPrintng">
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
							<th>${msg.C100000892}</th><!-- 출력물 구분 -->
							<td><select id="printngSeCodeSch" name="printngSeCodeSch" disabled="disabled"></select></td>
							<th>${msg.C100000893}</th><!-- 출력물 명 -->
							<td><input type="text" id="printngNmSch" name="printngNmSch" class="schClass"></td>
							<th>${msg.C100000896}</th><!-- 출력물 파일 명 -->
							<td><input type="text" id="printngUploadFileNmSch" name="printngUploadFileNmSch" class="schClass"></td>
							<th>${msg.C100000443}</th><!-- 사용여부 -->
							<td style="text-align:left;">
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
				<h2><i class="fi-rr-apps"></i>${msg.C100000895}</h2><!-- 출력물 목록 상세 -->
				<div class="btnWrap">
					<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button><!-- 신규 -->
					<button type="button" id="btn_delete" class="delete" style="display: none">${msg.C100000458}</button><!-- 삭제 -->
					<button type="button" id="btn_save" class="save">${msg.C100000760}</button><!-- 저장 -->
				</div>
				<form id="frmPrintng" name="frmPrintng">
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
							<th class="necessary">${msg.C100000892}</th><!-- 출력물 구분 -->
							<td><select id="printngSeCode" name="printngSeCode" disabled="disabled"></select></td>
							<th class="necessary">${msg.C100000893}</th><!-- 출력물 명 -->
							<td><input type="text" id="printngNm" name="printngNm" max="200" required/></td>
							<th class="necessary">${msg.C100000896}</th><!-- 출력물 파일명 -->
							<td><input type="text" id="printngUploadFileNm" name="printngUploadFileNm" maxlength="200" required/></td>
							<th>${msg.C100000443}</th><!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" id="useAtY" name="useAt" value="Y" checked />${msg.C100000439}</label><!-- 사용 -->
								<label><input type="radio" id="useAtN" name="useAt" value="N" />${msg.C100000449}</label><!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th><!-- 비고 -->
							<td colspan="7">
								<textarea id="rm" name="rm" class="wd100p" rows="2" maxlength="4000"></textarea>
								<input type="hidden" id="printngSeqno" name="printngSeqno" />
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000860}</th><!-- 첨부파일 -->
							<td colspan="7">
								<input type="file" id="printingFile" />
								<input type="hidden" id="histVer" name="histVer" />
								<a id="rdDownload" style="cursor:pointer; margin-left:20px;"></a>
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

			$(function() {
				getAuth();

				setGrid();

				setGridEvent();

				setButtonEvent();

				setCombo();

				gridResize([printngGrid]);
			});

			function setGrid(){
				printngGridCol = [];
				auigridCol(printngGridCol);

				printngGridCol.addColumnCustom('printngSeCodeNm','${msg.C100000892}',null,true,false) //출력물 구분
				.addColumnCustom('printngNm','${msg.C100000893}',null,true,false) //출력물 명
				.addColumnCustom('printngUploadFileNm','${msg.C100000896}',null,true,false) //출력물 파일명
				.addColumnCustom('useAt','${msg.C100000443}',null,true,false) //사용여부
				.addColumnCustom('rm','${msg.C100000425}',null,true,false) //비고
				.addColumnCustom('atchmnflSeqno','atchmnflSeqno',null,false,false); //첨부파일

				printngGrid = createAUIGrid(printngGridCol, printngGrid, { selectionMode : 'singleRow' });
			};

			// 그리드 이벤트
			function setGridEvent(){
				AUIGrid.bind(printngGrid, "ready", function(event) {
					gridColResize(printngGrid, "2");
				});

				AUIGrid.bind(printngGrid, "cellDoubleClick", function(event) {

					resetFrm();
					$("#btn_delete").show();
					var item = event.item;

					$('#printngSeqno').val(item.printngSeqno);
					$('#histVer').val(item.histVer);
					$('#printngSeCode').val(item.printngSeCode);
					$('#printngNm').val(item.printngNm);
					$('#printngUploadFileNm').val(item.printngUploadFileNm);
					$('#rm').val(item.rm);
					if('Y' == item.useAt) {
						$("input:radio[id='useY']").prop("checked", true);
					} else if('N' == item.useAt) {
						$("input:radio[id='useN']").prop("checked", true);
					}
					$('#rdDownload').html(item.printngOrginlFileNm);
					$('#printngNm').prop('readonly', true);
					$("#printngUploadFileNm").prop('readonly',true);

				});
			}

			// 버튼 이벤트
			function setButtonEvent(){
				// 조회
				$("#searchBtn").click(function(){
					AUIGrid.clearGridData(printngGrid);
					searchPrintngGrid();
				});

				// 저장
				$("#btn_save").click(function(){
					savePrintngGrid();
				});

				// 신규
				$("#btn_new").click(function(){
					resetFrm();
				})

			    //삭제
			    $("#btn_delete").click(function(e){
			    	if($('#printngSeqno').val() == '' || $('#printngSeqno').val() == null || $('#printngSeqno').val() == 'undifined') {
			    		alert('${msg.C100000496}'); /* 선택된 출력물이 없습니다. */
			    	} else {
				    	if(confirm("${msg.C100000461}")){ /* 삭제 하시겠습니까? */
				        	ajaxJsonForm('<c:url value="/wrk/deletePrintngM.lims"/>', 'frmPrintng', function (data) {
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
				$('#rdDownload').click(function(){
					var rdData = AUIGrid.getSelectedItems(printngGrid);
					if(rdData.length > 0) {
						var printngSeqno = rdData[0].item.printngSeqno;
						var histVer = rdData[0].item.histVer;
						location.href = '/wrk/getRdDownload.lims?printngSeqno=' + printngSeqno + '&histVer=' + histVer;
					}
				});

				// 첨부파일 change event
				document.getElementById('printingFile').addEventListener('change', function() {
					var stIndex = $("#printingFile").val().indexOf("\\",4) + 1;
					var newUploadFileNm = $("#printingFile").val().substr(stIndex);
					$("#printngUploadFileNm").val(newUploadFileNm);
				});
			};

			function setCombo(){
				ajaxJsonComboBox('/com/getCmmnCode.lims','printngSeCodeSch',{'upperCmmnCode' : 'SY15'}, true, null, 'SY15000001');
				ajaxJsonComboBox('/com/getCmmnCode.lims','printngSeCode',{'upperCmmnCode' : 'SY15'}, true, null, 'SY15000001');
			};

			 //조회
			function searchPrintngGrid(rowVal){
				getGridDataForm('<c:url value="/wrk/getPrintngMList.lims"/>', 'searchFrmPrintng', printngGrid, function() {
					if (rowVal)
						gridSelectRow(printngGrid, "printngUploadFileNm", rowVal);
				});
			}

			//저장
			function savePrintngGrid(){

				// 필수값 체크
				if(!saveValidation("frmPrintng")){ return false; }

				var printngSeqno = $('#printngSeqno').val();
				var newfileCheck = $('#printingFile').val();

				// 신규 등록에만 해당됨
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

				// 신규 저장 or 내용,첨부파일 수정
				if(printngSeqno == '' || (printngSeqno != '' && newfileCheck != '')) {

					var file = $('#printingFile')[0];
					var fileName = file.files[0].name;
					var fileExt1 = fileName.substring(fileName.length, fileName.length-3);

					if(fileExt1.toUpperCase() != 'MRD') {
						warn('mrd ' + '${msg.C100000066}'); /* mrd 확장자만 업로드 할 수 있습니다. */
						return;
					}

					formData.append('formFile', $('#printingFile')[0].files[0]);
				}
				formData.append('printngSeqno', $('#printngSeqno').val());

				/* 첨부파일 수정 -> 이력값 담아서 보냄
				   첨부파일 미수정 -> 빈 값 보냄 */
				if(newfileCheck != '') 
					formData.append('histVer', $('#histVer').val());
				else
					formData.append('histVer', '');
				formData.append('printngNm', $('#printngNm').val());
				formData.append('printngUploadFileNm', $('#printngUploadFileNm').val());
				formData.append('useAt', $('input[name="useAt"]:checked').val());
				formData.append('rm', $('#rm').val());

				showLoadingbar();

				var upldfileNm = document.getElementById('printngUploadFileNm').value;
				ajaxJsonFormFile('/wrk/savePrintngM.lims', formData, function(data) {
					if(data == 1) {
						success('${msg.C100000765}'); /* 저장되었습니다. */
						resetFrm();
						searchPrintngGrid(upldfileNm);
						hideLoadingbar();
					}else {
						warn("${msg.C100001163}");  /* 중복되는 출력물 파일 명이 존재합니다. 파일을 다시 등록해주세요. */
						hideLoadingbar();
						return;
					}
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
				$('#printngSeCode').val('SY15000001');
				$('#rdDownload').text('');
				$('#printngNm').prop('readonly', false);
				$("#printngUploadFileNm").prop('readonly',false);
			}

	        function doSearch() {
	        	searchPrintngGrid();
	        }

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
