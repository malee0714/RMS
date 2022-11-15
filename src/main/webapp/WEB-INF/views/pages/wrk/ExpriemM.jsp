<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000561}</h2> <!-- 시험항목 목록 -->
				<div class="btnWrap">
					<%--<button type="button" id="btnSortOrdrSave" class="save">${msg.C100001256}</button>--%> <!-- 정렬순서 저장 -->
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm" name="searchFrm">
					<table class="subTable1" style="width:100%;">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 40%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000562}</th> <!-- 시험항목 분류 -->
							<td><select id="expriemClCodeSch" name="expriemClCodeSch" required="required"></select></td>
							<th>${msg.C100000560}</th> <!-- 시험항목 명 -->
							<td><input type="text" id="expriemNmSearch" name="expriemNmSearch" class="wd100p" maxlength="100" required="required"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" name="useAtSearch" value="">${msg.C100000779}</label> <!-- 전체 -->
						    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<div id="expriemGrid" class="wd100p" style="height:300px; margin:0 auto;"></div>
			</div>
			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100000563}</h2> <!-- 시험항목 상세 정보 -->
				<div class="btnWrap">
					<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
					<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<form id="expriemFrm" name="expriemFrm">
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
							<th class="necessary">${msg.C100000562}</th> <!-- 시험항목 분류 -->
							<td style="text-align:left;"><select id="expriemClCode" name="expriemClCode"></select></td>
							<th class="necessary">${msg.C100000560}</th> <!-- 시험항목 명 -->
							<td><input type="text" name=expriemNm id="expriemNm" class="wd100p" maxlength="200"></td>
							<th>${msg.C100000945}</th> <!-- 한글명 -->
							<td><input type="text" name=koreanNm id="koreanNm" class="wd100p" maxlength="200"></td>
							<th>${msg.C100000608}</th> <!-- 영문명 -->
							<td><input type="text" name="engNm" id="engNm" class="wd100p" maxlength="200"></td>
						</tr>
						<tr>
							<th>${msg.C100000580}</th> <!-- 약어 -->
							<td><input type="text" name="abrv" id="abrv" class="wd100p" maxlength="200"></td>
							<th>${msg.C100000082}</th> <!-- RDMS명 -->
							<td><input type="text" id="rdmsNm" name="rdmsNm" maxlength="200"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td colspan="3" style="text-align:left;">
								<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" id="useN" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000425}</th> <!-- 비고 -->
							<td colspan="7"><textarea id="rm" name="rm" class="wd100p" rows="3" style="min-width:10em;" maxlength="4000"></textarea></td>
						</tr>
					</table>
					<input type="text" name="expriemSeqno" id="expriemSeqno" style="display:none"/>
				</form>
			</div>
		</div>
    </tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var expriemGrid = 'expriemGrid';
			var searchFrm = 'searchFrm';
			var expriemFrm = 'expriemFrm';
			var putStatus = 'C';
			var saveKey = ''; // 포커스이동을 위함 변수

			$(function(){
				getAuth();

				setCombo();

				setExpriemGrid();

				setExpriemGridEvent();

				setButtonEvent();

				gridResize([ expriemGrid ]);
			});

			function setCombo(){
				ajaxJsonComboBox('/com/getCmmnCode.lims','expriemClCodeSch',{'upperCmmnCode' : 'SY05'},false,'${msg.C100000480}'); //선택
				ajaxJsonComboBox('/com/getCmmnCode.lims','expriemClCode',{'upperCmmnCode' : 'SY05'},false,'${msg.C100000480}'); //선택
			};

			function setExpriemGrid(){

				var expriemCol = [];
				auigridCol(expriemCol);

				var numericPros = {
					editRenderer : {
						type : "InputEditRenderer",
						onlyNumeric : true, // 0~9 까지만 허용
						allowPoint : false, // 소수점 허용 여부 (onlyNumeric : true 선행)
						allowNegative : false, // 음수값 허용 여부 (onlyNumeric : true 선행)
						blankNumericToNullOnEditing : true //"" 의 기본값 0을 null 로 적용
					}
				};

				expriemCol.addColumnCustom('expriemClCode','expriemClCode',null,false,null) //시험항목 분류코드
				.addColumnCustom('expriemClCodeNm','${msg.C100000562}',null,true,null) //시험항목 분류
				.addColumnCustom('expriemNm','${msg.C100000560}',null,true,null) //시험항목 명
				.addColumnCustom('koreanNm','${msg.C100000945}',null,true,null) //한글명
				.addColumnCustom('engNm','${msg.C100000608}',null,true,null) //영문명
				.addColumnCustom('abrv','${msg.C100000580}',null,true,null)	 //약어
				.addColumnCustom('rdmsNm','${msg.C100000082}',null,true,null) //RDMS명
				.addColumnCustom('sortOrdr','${msg.C100000797}',null,true,true,numericPros) //정렬순서
				.addColumnCustom('useAt','${msg.C100000443}',null,true,null) //사용여부
				.addColumnCustom('rm','${msg.C100000425}',null,true,null) //비고
				.addColumnCustom('expriemSeqno','expriemSeqno',null,false,null);

				var expriemGridPros = {
					displayTreeOpen : true,
					// 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
					selectionMode : 'multipleCells',
				};

				// 그리드 생성
				expriemGrid = createAUIGrid(expriemCol, expriemGrid, expriemGridPros);
			};

			function setExpriemGridEvent(){

				AUIGrid.bind(expriemGrid, 'cellDoubleClick', function(event) {

					$("#btnDelete").show();
					$('#koreanNm').val(event.item.koreanNm);
					$('#engNm').val(event.item.engNm);
					$('#expriemClCode').val(event.item.expriemClCode);
					$('#expriemSeqno').val(event.item.expriemSeqno);
					$('#abrv').val(event.item.abrv);
					$('#rm').val(event.item.rm);
					$('#rdmsNm').val(event.item.rdmsNm);
					$('#expriemNm').val(event.item.expriemNm);

					if(event.item.useAt == 'Y')
						$('#useY').val(event.item.useAt).prop('checked', true);
					else
						$('#useN').val(event.item.useAt).prop('checked', true);

					// flag : update로 설정
					putStatus = 'U';
				});

				// ready는 화면에 필수로 구현 할 것
				AUIGrid.bind(expriemGrid, 'ready', function(event) {
					gridColResize(expriemGrid, '2');	// 1, 2가 있으니 화면에 맞게 적용
					if(saveKey != null && saveKey != '') gridSelectRow(expriemGrid, 'expriemSeqno', [saveKey]);
				});
			};

			// 버튼 이벤트
			function setButtonEvent(){

				$('#btnSearch').click(function(){
					saveKey = '';
					searchExpriem();
				});

				$('#btnSave').click(function(){
					chkExpriemNm(true);
				});

				$('#btnDelete').click(function(){
					deleteExpriem();
				});

				$('#btnNew').click(function(){
					frmReset();
				})

				$('#expriemNmSearch').keypress(function (e) {
			        if (e.which == 13){
			        	searchExpriem();
			        	return false;
			        }
				});

				//정렬순서 저장
				/*$('#btnSortOrdrSave').click(function() {
					var editList = AUIGrid.getEditedRowItems(expriemGrid);
					if (editList.length > 0) {
						customAjax({
							'url' : '/wrk/updExpriemSortOrdr.lims',
							'data' : editList,
							'successFunc' : function(data){
								if (data == 1) {
									success("${msg.C100000762}"); /!* 저장되었습니다. *!/
									frmReset();
									searchExpriem();
								} else {
									err('${msg.C100000597}'); /!* 오류가 발생했습니다. log를 참조해주세요. *!/
								}
							}
						});
					} else {
						alert('${msg.C100001106}'); //수정된 내역이 없습니다.
					}
				});*/
			};

			//조회
			function searchExpriem(keyCode){
				if(keyCode != undefined && keyCode == 13)
					searchExpriem();
				else {
					if(keyCode == undefined) {
						getGridDataForm('<c:url value="/wrk/getExpriemMList.lims"/>', searchFrm, expriemGrid);
					}
				}
			}

			//저장
			function saveExprIem(){

				if(!saveValidation('expriemFrm')){ return false; }

				if(putStatus == 'C') {
					ajaxJsonForm('<c:url value="/wrk/insExpriemM.lims"/>', expriemFrm, function (data) {
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						frmReset();
						saveKey = data;
						searchExpriem();
					}, function (request,status,error) {
						err('${msg.C100000597}'); /* 오류가 발생했습니다. log를 참조해주세요. */
					});
				} else if(putStatus == 'U') {
					ajaxJsonForm('<c:url value="/wrk/updExpriemM.lims"/>', expriemFrm, function (data) {
						if(!!data)
							success('${msg.C100000762}'); /* 저장 되었습니다. */
						frmReset();
						saveKey = data;
						searchExpriem();
					}, function (request,status,error) {
						err('${msg.C100000597}'); /* 오류가 발생했습니다. log를 참조해주세요. */
					});
				}
			}

			function frmReset(sOption){
				$("#btnDelete").hide();
				$('#expriemFrm')[0].reset();
				putStatus = 'C';
			}

			//시험항목명 중복체크
			function chkExpriemNm(bSave){

				var expriemNm = $('#expriemNm').val();
				var expriemClCode = $('#expriemClCode').val();
				if(!!expriemNm&&!!expriemClCode){
					ajaxJsonForm('<c:url value="/wrk/getExpriemNmCnt.lims"/>', expriemFrm, function (data) {
						if(data != 0 ){
							if(bSave)
								warn('${msg.C100000838}'); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
							$('#expriemNm').val('');
							$('#expriemNm').focus();
						} else {
							if(bSave)
								saveExprIem();
						}
					});
				} else {
					warn('${msg.C100000943}'); /* 필수사항을 모두 입력해주세요. */
				}
			}

			function deleteExpriem(){

				var expriemSeqno = $('#expriemSeqno').val();

				if(!expriemSeqno){
					alert('${msg.C100000493}'); /* 선택된 시험항목이 없습니다. */
					return false;
				}

				if(!confirm('${msg.C100000461}')){ /* 삭제하시겠습니까? */
					return false;
				}

				customAjax({
					url : '/wrk/deleteExpriem.lims',
					data : { expriemSeqno : expriemSeqno }
				}).then(function(data) {
					if(data){
						success('${msg.C100000462}'); /* 삭제되었습니다. */
						frmReset();
						searchExpriem();
					}
				});

			}

		</script>
	</tiles:putAttribute>
	</tiles:insertDefinition>
