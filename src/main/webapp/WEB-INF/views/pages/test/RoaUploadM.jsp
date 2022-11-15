<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000718}</h2> <!-- 자재 목록 -->
				<div class="btnWrap">
					<button id="btnSearch" class="btn3 search" >${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="frmSearch" onsubmit="return false">
					<table class="subTable1">
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
							<th>${msg.C100000714}</th> <!-- 자사구분 -->
							<td style="text-align: left;">
								<label><input type="radio" name="mmnySeCode" value="" style="display:none;"></label> <!-- 전체${msg.C100000779} -->
								<label><input type="radio" name="mmnySeCode" value="SY01000001" checked>${msg.C100000713}</label> <!-- 자사 -->
								<label><input type="radio" name="mmnySeCode" value="SY01000002">${msg.C100000958}</label> <!-- 협력사 -->
							</td>
							<th>${msg.C100000432}</th> <!-- 사업장 -->
							<td>
								<select class="schClass" name="bplcCodeSch" id="bplcCodeSch">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
								</select>
							</td>
							<th>${msg.C100000722}</th> <!-- 자재유형 -->
							<td>
								<select class="schClass" name="mtrilTyCodeSch" id="mtrilTyCodeSch">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
								</select>
							</td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td>
								<label><input type="radio" name="useAt" value="">${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" value="N">${msg.C100000449}</label>	<!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000725}</th> <!-- 자재코드 -->
							<td><label><input type="text" class="schClass" name="mtrilCode"></label></td>
							<th>${msg.C100000717}</th> <!-- 자재명 -->
							<td><label><input type="text" class="schClass" name="mtrilNm"></label></td>
							<th>${msg.C100000618}</th> <!-- 용기타입 -->
							<td><select class="schClass" id="cntnrSeCodeSch" name=cntnrSeCodeSch></select></td>
						</tr>
					</table>
					<input type="hidden" id="mtrilSeqno" name="mtrilSeqno" />
				</form>
			</div>
			<div class="subCon2">
				<div id="mtrilGrid" style="height: 300px;"></div>
			</div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100001171}</h2> <!-- ROA 업로드 -->
				<div class="btnWrap">
					<button type="button" id="btnSave" class="save" style="margin-top: 4px;">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<table class="subTable1" style="width:100%;">
					<colgroup>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:25%"></col>
						<col style="width:40%"></col>
					</colgroup>
					<tr>
						<th>${msg.C100000717}</th> <!-- 자재 명 -->
						<td style="text-align: left;"><label><input type="text" id="clickMtrilNm" name="clickMtrilNm" readonly></label></td>
						<th>${msg.C100001172}</th> <!-- ROA 업로드 파일 -->
						<td style="text-align: left;">
							<input type="file" id="formFile" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"/>
						</td>
						<td>
							<a id="sampleRoaDownload" style="cursor:pointer; margin-left:20px; float:right; font-size: 15px;">${msg.C100001285}</a> <!-- 샘플 파일 다운로드(링크) -->
						</td>
					</tr>
				</table>
			</div>
			<div class="accordion_wrap mgT17">
				<div class="accordion">${msg.C100001173}</div> <!-- ROA 업로드 조회 -->
				<div id="acc1" class="acco_top" style="display: none">
					<div class="subCon1 wd100p mgT15">
						<div class="btnWrap" style="width: 100%; position: relative; display: inline-block; top: 0;">
							<button type="button" id="btnUploadSearch" name="btnUploadSearch" class="search fR">${msg.C100000767}</button> <!-- 조회 -->
						</div>
					</div>
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div class="subCon2">
						<div id="uploadGrid" class="wd100p" style="width: 100%; height: 300px; margin: 0px auto; position: relative;"></div>
						<div class="mapkey"><label class="roaupload">${msg.C100000439}</label><!-- 사용 --></div>
					</div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<style>
			.rowStyle-red {
				background-color : #9a9b9b;
				color : black;
			}
		</style>
		<script type="text/javascript">

			var lang = ${msg}; // 기본언어
			var frmSearch = 'frmSearch';
			var mtrilGrid = 'mtrilGrid'; // 자재 목록 그리드
			var uploadGrid = 'uploadGrid';

			$(document).ready(function(){

				setCombo();

				setButtonEvent();

				setEtcEvent();

				setGrid();

				setGridEvent();

			});

			function setCombo() {
				ajaxJsonComboBox('/com/getCmmnCode.lims', "cntnrSeCodeSch",{ "upperCmmnCode" : "SY10", "deptCode" : "${UserMVo.deptCode}" }, true); // 용기 타입
				ajaxJsonComboBox('/com/getCmmnCode.lims', "mtrilTyCodeSch",{ "upperCmmnCode" : "SY02", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
			}

			function setButtonEvent() {
				$('#btnSearch').click(function() {
					$('#mtrilSeqno').val(null);
					$('#clickMtrilNm').val(null);
					getMtrils();
					AUIGrid.clearGridData(uploadGrid); //ROA 업로드 그리드 초기화
				});

				//저장
				$('#btnSave').click(function() {
					var mtrilSeqno = $('#mtrilSeqno').val();
					if(!!mtrilSeqno)
						save();
					else
						alert('${msg.C100001174}'); /* 자재를 선택해 주세요. */
				});

				$('#btnUploadSearch').click(function() {
					//조회버튼 클릭 시 자재에 등록된 ROA업로드 데이터가 있으면 기존에 생성된 그리드 destroy 후 다시 create\
					var mtrilSeqno = $('#mtrilSeqno').val();
					if(!!mtrilSeqno) {
						setRoaUploadGrid();
					} else {
						alert('${msg.C100001174}'); /* 자재를 선택해 주세요. */
					}
				});

				//아코디언 click event
				var acc = document.getElementsByClassName("accordion");
				var i;

				for (i = 0; i < acc.length; i++) {
					acc[i].addEventListener("click", function() {
						this.classList.toggle("active");
						var panel = this.nextElementSibling;

						if (panel.style.display === "block") {
							panel.style.display = "none";
						}else {
							panel.style.display = "block";
							AUIGrid.resize(uploadGrid);
						}

						if (panel.style.maxHeight) {
							panel.style.maxHeight = null;
						}else {
							panel.style.maxHeight = null;
						}
					});
				}

				//ROA SAMPLE 다운로드
				$('#sampleRoaDownload').click(function(){
					if(!confirm("${msg.C000000306}")) return false;
					location.href = '/test/getSampleRoaDownload.lims';
				});
			}

			function setEtcEvent() {
				$('#formFile').change(function() {
					var file = $("#formFile")[0];
					if(file.files.length != 0) {
						var mtrilSeqno = $('#mtrilSeqno').val();
						if(!!mtrilSeqno) {
							availability();
						} else {
							$('#formFile').val(null);
							alert('${msg.C100001175}'); /* 자재 클릭 후 첨부파일을 선택해주세요. */
						}
					}
				});
			}

			function setGrid() {
				var columnLayout = { mtrilGrid : [], uploadGrid : [] };

				auigridCol(columnLayout.mtrilGrid); //제품목록 그리드
				auigridCol(columnLayout.uploadGrid); //ROA 업로드 조회

				columnLayout.mtrilGrid
						.addColumnCustom("mmnySeCodeNm" , "${msg.C100000714}"   ,"*",true)  /* 자사 구분 */
						.addColumnCustom("mmnySeCode"   , "mmnySeCode"          ,"*",false)
						.addColumnCustom("inspctInsttNm", "${msg.C100000432}"   ,"*",true)  /* 사업장 */
						.addColumnCustom("mtrilTyCodeNm", "${msg.C100000727}"   ,"*",true)  /* 자재유형타입 */
						.addColumnCustom("mtrilNm"      , "${msg.C100000717}"   ,"*",true)  /* 자재 명 */
						.addColumnCustom("mtrilCode"    , "${msg.C100000725}"   ,"*",true)  /* 자재 코드 */
						.addColumnCustom("lotCode"      , "${msg.C100000056}"   ,"*",true)  /* LOT 코드 */
						.addColumnCustom("lotNoCphr"    , "${msg.C100000473}"   ,"*",true)  /* 상위 LOT 자리수 */
						.addColumnCustom("lotMxtrRule"  , "${msg.C100000055}"   ,"*",true)  /* LOT ID 조합규칙 */
						.addColumnCustom("cntnrTyNm"    , "${msg.C100000618}"   ,"*",true); /* 용기 타입 */

				columnLayout.uploadGrid.addColumnCustom("defaultText", lang.C100001176); /* ROA 업로드 엑셀파일을 저장한 형태 그대로 그리드에 제공합니다. */

				mtrilGrid = createAUIGrid(columnLayout.mtrilGrid, mtrilGrid);

				var rowStyle = {
					rowStyleFunction : function(rowIndex, item) {
						if(item.useAt == 'N')
							return "rowStyle-red";

						return null;
					}
				}

				uploadGrid = createAUIGrid(columnLayout.uploadGrid, uploadGrid, rowStyle);

				gridResize([ mtrilGrid, uploadGrid ]);
				gridColResize([ mtrilGrid, uploadGrid ], "2");

			}

			function setGridEvent() {
				AUIGrid.bind(mtrilGrid, 'cellDoubleClick', function(event) {
					$('#mtrilSeqno').val(event.item.mtrilSeqno);
					$('#clickMtrilNm').val(event.item.mtrilNm);
					AUIGrid.clearGridData(uploadGrid); //ROA 업로드 그리드 초기화
				});
			}

			// 자재 목록 조회
			function getMtrils() {
				getGridDataForm('<c:url value="/wrk/getMtrilList.lims"/>', 'frmSearch', mtrilGrid).then(function(){
					gridResize([ mtrilGrid, uploadGrid ]);
					gridColResize([ mtrilGrid, uploadGrid ], "2");
				});
			}

			//ROA 엑셀파일 벨리데이션 체크
			function availability() {
				if(!!$("#formFile")[0].files[0]) {
					if(fileExtensionChk()) {
						var formData = new FormData();
						formData.append('formFile', $('#formFile')[0].files[0]);
						formData.append('mtrilSeqno', $('#mtrilSeqno').val());
						showLoadingbar();
						ajaxJsonFormFile('/test/getUploadAvailability.lims', formData, function(data){
							if(data.gbnMsg == 'notMatch') {
								alert("${msg.C100001177}");  /* 그리드에서 선택한 자재와 엑셀의 자재가 다릅니다. */
								$('#formFile').val(null);
							}else if(data.gbnMsg == 'cntDifference') {
								alert("${msg.C100001178}");  /* 자재 마스터 시험항목 수와 엑셀에 시험항목 수가 다릅니다. */
								$('#formFile').val(null);
							}else {
								alert("${msg.C100001179}");  /* 저장 가능합니다. */
							}
							hideLoadingbar();
						});
					}
				} else {
					alert('${msg.C100001180}'); /* 엑셀파일을 등록해 주세요. */
				}
			}

			//저장
			function save() {
				if(!!$("#formFile")[0].files[0]) {
					if(fileExtensionChk()) {
						var formData = new FormData();
						formData.append('formFile', $('#formFile')[0].files[0]);
						formData.append('mtrilSeqno', $('#mtrilSeqno').val());
						showLoadingbar();
						ajaxJsonFormFile('/test/insRoaUpload.lims', formData, function(data){
							alert('${msg.C100000762}');
							hideLoadingbar();
						});
					}
				} else {
					alert('${msg.C100001180}'); /* 엑셀파일을 등록해 주세요. */
				}
			}

			//저장 후 ROA 업로드 그리드 생성
			function setRoaUploadGrid() {
				customAjax({
					'url':'/test/getSavedData.lims',
					'data':{'mtrilSeqno' : $('#mtrilSeqno').val()},
					'successFunc':function(data) {
						console.log(data);
						if(!!data.expriemNmMap) {
							var expriemNmKeys = Object.keys(data.expriemNmMap);
							var expriemNmValues = Object.values(data.expriemNmMap);
							var columnLayout = { uploadGrid : [] };
							auigridCol(columnLayout.uploadGrid);
							for(var i = 0; i < expriemNmKeys.length; i++) {
								columnLayout.uploadGrid.addColumnCustom(expriemNmKeys[i],expriemNmValues[i],"*",true);
							}

							//ROA 업로드 조회 그리드에서 사용한 row 구분하기 위한 셀 추가
							columnLayout.uploadGrid.addColumnCustom('useAt', 'useAt', "*", false);
							//동적으로 변경되는 레이아웃을 그리드에 반영
							AUIGrid.changeColumnLayout(uploadGrid, columnLayout.uploadGrid);

							for(var i = 0; i < data.expriemResultList.length; i++) {
								data.expriemResultList[i]['useAt'] = data.usedRoaUploadChkList[i].useAt;
							}

							//ROA업로드로 저장된 데이터 그려줌
							AUIGrid.setGridData(uploadGrid, data.expriemResultList);
							gridResize([ uploadGrid, mtrilGrid ]);
							gridColResize([uploadGrid, mtrilGrid ], "2");
						}
					}
				});
			}

			//확장자 체크
			function fileExtensionChk() {
				var file = $("#formFile")[0];
				var fileName = file.files[0].name;
				var fileExt1 = fileName.substring(fileName.length, fileName.length-4);
				var fileExt2 = fileName.substring(fileName.length, fileName.length-3);
				if(fileExt1.toUpperCase() == "XLSX" || fileExt2.toUpperCase() == "XLS") {
					return true;
				} else {
					alert('${msg.C100001181}'); /* 엑셀파일이 아니면 저장할 수 없습니다. */
					return;
				}
			}

			//조회이벤트
			function doSearch(e){
				getMtrils();
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>