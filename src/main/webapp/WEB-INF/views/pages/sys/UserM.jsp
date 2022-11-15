<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000453}</h2> <!-- 사용자 목록 -->
				<div class="btnWrap">
					<c:if test = "${UserMVo.authorSeCode == 'SY09000001'}">
						<button type="button" id="btn_changeAuth" class="save">${msg.C100000218}</button> <!-- 권한변경 -->
						<button type="button" id="btn_notUse" class="save">${msg.C100000442}</button> <!-- 사용 안함 -->
						<button type="button" id="btn_notLoginSixMnth_select" class="search">${msg.C100001255}</button> <!-- 6개월 이상 미접속자 조회 -->
						<button type="button" id="btn_sbscrb_confm" class="save" style=" display: none;">${msg.C100000109}</button> <!-- 가입승인 -->
						<button type="button" id="btn_sbscrb_confm_select" class="search" style=" display: none;">${msg.C100000110}</button> <!-- 가입승인대기조회 -->
						<button type="button" id="btn_reset_password" class="save">${msg.C100000429}</button> <!-- 비밀번호초기화 -->
					</c:if>
					<button type="button" id="btn_select" value="조회" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm" onsubmit="return false;">
					<table class="subTable1" style="width:100%">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<%--<th>${msg.C100000435}</th> <!-- 사업장 명 -->
							<td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>--%>
							<th>${msg.C100000821}</th> <!-- 조직명 -->
							<td><select id="deptCodeSch" name="deptCodeSch" ></select></td>
							<th>${msg.C100000452}</th> <!-- 사용자 명 -->
							<td><input type="text" id="userNmSch" name="userNmSch"></td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" id="use_allsch" name="useAtSch" value="all" >${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" id="use_ysch" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="use_nsch" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
							<td colspan="2"></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<div id="userGrid"></div>
			</div>

			<div class="subCon1 mgT20">
				<h2><i class="fi-rr-apps"></i>${msg.C100000454}</h2> <!-- 사용자 상세 정보 -->
				<div class="btnWrap">
					<button id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<c:if test = "${UserMVo.authorSeCode == 'SY09000001' || UserMVo.authorSeCode == 'SY09000002'}">
						<button id="btn_delete" class="delete" style="display:none">${msg.C100000458}</button> <!-- 삭제 -->
					</c:if>
					<button id="btn_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
					<input type="hidden" id="btnSave_sign" value="서명파일">
				</div>
				<form id="userInfoFrm" autocomplete="off" onsubmit="return false;">
					<table class="subTable1" style="width:100%">
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
							<%--<th class="taCt vaMd necessary">${msg.C100000435}</th> <!-- 사업장 명 -->
							<td><select id="bplcCode" name="bplcCode" class="GuBunUser" disabled></select></td>--%>
							<th class="taCt vaMd necessary">${msg.C100000821}</th> <!-- 조직명 -->
							<td>
								<select id="deptCode" name="deptCode" ></select>
								<input type="hidden" id="rdmsGroupId" name="rdmsGroupId" />
								<input type="hidden" id=inspctInsttCode name="inspctInsttCode" />
							</td>
							<th class="taCt vaMd necessary">${msg.C100000452}</th> <!-- 사용자 명 -->
							<td><input type="text" id="userNm" name="userNm" class="GuBunUser" autocomplete="off" maxlength="200"></td>
							<th class="taCt vaMd necessary">${msg.C100000298}</th> <!-- 로그인ID -->
							<td><input type="text" id="loginId" name="loginId" class="GuBunUser" autocomplete="off" maxlength="32"></td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<th class="taCt vaMd necessary">${msg.C100000426}</th> <!-- 비밀번호 -->
							<td><input type="password" id="userPassword" name="password" class="GuBunUser wd100p" autocomplete="new-password" maxlength="100"></td>
							<th class="necessary">${msg.C100000668}</th> <!-- 이동전화 -->
							<td><input type="text" id="moblphon" name="moblphon" class="GuBunUser" placeholder="${msg.C100001017}" maxlength="20" /></td>
							<th>${msg.C100000042}</th> <!-- E-MAIL -->
							<td><input type="text" id="email" name="email" class="GuBunUser" placeholder="${msg.C100001018}" maxlength="100" /></td>
							<th class="taCt vaMd necessary">${msg.C100000212}</th> <!-- 권한 -->
							<td>
								<select id="authorSeCode" name="authorSeCode"></select>
								<input type="hidden" id="authorCode" name="authorCode" />
							</td>
						</tr>
						<tr>
							<th>${msg.C100000843}</th> <!-- 직위 -->
							<td><select id="ofcpsCode" name="ofcpsCode" class="GuBunUser"></select></td>
							<th>${msg.C100000844}</th> <!-- 직급 -->
							<td><select id="clsfCode" name="clsfCode" class="GuBunUser"></select></td>
							<th>${msg.C100000697}</th> <!-- 입사일자 -->
							<td><input type="text" id="encpn" name="encpn" class="GuBunUser dateChk" maxlength="10"></td>
							<th>${msg.C100000912}</th> <!-- 퇴사일자 -->
							<td><input type="text" id="resigndte" name="resigndte" class="GuBunUser dateChk" maxlength="10"></td>
						</tr>
						<tr>
							<th>${msg.C100000913}</th> <!-- 팀장여부 -->
							<td style="text-align: left;"><input type="checkbox" id="timhderAt" name="timhderAt" style="width:15px;"></td>
							<th>${msg.C100000111}</th> <!-- 가입승인여부 -->
							<td style="text-align: left;">
								<label><input type="radio" id="sbscrbConfmAtY" name="sbscrbConfmAt" value="Y" checked>${msg.C100000533}</label> <!-- 승인 -->
								<label><input type="radio" id="sbscrbConfmAtN" name="sbscrbConfmAt" value="N">${msg.C100000981}</label> <!-- 미승인 -->
							</td>
							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;" colspan="3">
								<label><input type="radio" id="useAtY" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="useAtN" name="useAt" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000735}</th> <!-- 잠금여부 -->
							<td style="text-align: left;">
								<label><input type="radio" id="lockAtN" name="lockAt" value="N" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="lockAtY" name="lockAt" value="Y">${msg.C100001019}</label></td> <!-- 잠금 -->
							<th>${msg.C100000734}</th> <!-- 잠금사유 -->
							<td colspan="5">
								<input type="text" id="lockResn" name="lockResn" maxlength="4000">
							</td>
						</tr>
						<tr>
							<th>${msg.C100000479}</th> <!-- 서명 첨부 파일 -->
							<td colspan="7">
								<div id="dropzoneArea_sign" style="text-align: left;"></div>
								<input type="hidden" id="signAtchmnflSeqno" name="signAtchmnflSeqno">
								<input type="hidden" id="userIdInfo" name="userId" />
							</td>
						</tr>
					</table>

					<input type="hidden" id="authorTrgterSeqno" name="authorTrgterSeqno">
				</form>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var auth = '${UserMVo.authorSeCode}';
			var userGrid = 'userGrid';
			var searchFrm = 'searchFrm';
			var dropzoneArea_sign; // 서명첨부파일
			var lang = ${msg};  //팝업에서 사용하는 기본언어
			var sLoginId;
			var sUserId;
			var sUserNm;
			var crqfcListEvent;

			$(function() {
				setUserGrid();

				setCombo();

				setAuiGridEvent();

				setButtonEvent();

				validationChk();

				datePickerCalendar(["encpn"], false); //입사일자
				datePickerCalendar(["resigndte"], false); //퇴사일자

				// 권한설정 다이얼로그
				changeAuthDialog("btn_changeAuth", {ntcnSeCode : "SY18000002", auth : "SY09000003"}, "changeAuth", function(data){}, null);

				gridResize([ userGrid ]);
			});

			// 그리드 세팅
			function setUserGrid() {
				//그리드 레이아웃 정의
				var columnLayout = { userGrid : [] };
				auigridCol(columnLayout.userGrid);

				var useAtPros = { showStateColumn : true };

				// 사용자 관리 그리드
				columnLayout.userGrid
				.addColumnCustom('inspctInsttNm', '${msg.C100000821}', '*', true, false) /* 조직 명 */
				.addColumnCustom('userId', 'userId', '*', false, false) /* 유저ID */
				.addColumnCustom('userNm', '${msg.C100000452}', '*', true, false) /* 사용자 명 */
				.addColumnCustom('loginId', '${msg.C100000298}', '*' , true , false) /* 로그인ID */
				.addColumnCustom('moblphon', '${msg.C100000668}', '*', true, false) /* 이동전화 */
				.addColumnCustom('email', '${msg.C100000042}', '*', true, false) /* E-MAIL */
				.addColumnCustom('authorSeNm', '${msg.C100001028}', '*', true, false) /* 권한구분명 */
				.addColumnCustom('timhderAt', '${msg.C100000913}', '*', true, false) /* 팀장여부 */
				.addColumnCustom('sbscrbConfmAt', '${msg.C100000111}', '*', true, false) /* 가입승인여부 */
				.addColumnCustom('useAt', '${msg.C100000443}', '*', true, false) /* 사용여부 */
				.addColumnCustom('authorSeCode', 'authorSeCode', '*', false, false) /* 권한구분코드 */
				.addColumnCustom('inspctInsttCode', 'inspctInsttCode', '*', false, false); /* 부서코드 */

				var userGridProps = {
						selectionMode : 'multipleCells',
						editable : false,
						showRowCheckColumn : true,
						showRowAllCheckBox : true
				};

				userGrid = createAUIGrid(columnLayout.userGrid, userGrid, userGridProps);

				//파일 드랍존 생성 - maxfile: 파일 최대 갯수
				dropzoneArea_sign = DDFC.bind().EventHandler("dropzoneArea_sign", { btnId : "#btnSave_sign", maxFiles : 1, lang : "${msg.C100000867}" /* 첨부할 파일을 이 곳에 드래그하세요. */});
			}

			// 콤보박스 바인딩
			function setCombo() {
				//ajaxJsonComboBox('/wrk/getBestComboList.lims', '#bplcCode', null, null, null, '${UserMVo.bestInspctInsttCode}');
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', { 'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}' }, true, null, '${UserMVo.deptCode}');
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', { 'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}' }, true, null, '${UserMVo.deptCode}');
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'authorSeCode', { 'upperCmmnCode' : 'SY09' }, null, null, '${UserMVo.authorSeCode}', null, function(e) {
					//일반사용자인 경우 권한 선택 안되도록
					if('SY09000003' == '${UserMVo.authorSeCode}' || 'SY09000004' == '${UserMVo.authorSeCode}')
						$('#authorSeCode').prop('disabled', true);
				});
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'ofcpsCode', { 'upperCmmnCode' : 'SY18' }, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'clsfCode', { 'upperCmmnCode' : 'SY19' }, true);
			}

			// auigrid 이벤트 세팅
			function setAuiGridEvent() {

				// ready는 화면에 필수로 구현 할 것
				AUIGrid.bind(userGrid, 'ready', function(event) {
					gridColResize(userGrid, '2');
				});

				// userGrid 그리드 셀 클릭 이벤트
				AUIGrid.bind(userGrid, 'cellDoubleClick', function(event) {

					$("#btn_delete").show();

					crqfcListEvent = event
					sLoginId = event.item.loginId;
					sUserId = event.item.userId;
					sUserNm = event.item.userNm;

					// flag : update로 설정
					$('#gbnCrud').val('U'); // 사용자 정보 crud
					$('#userInfoFrm').find('#userIdInfo').val(event.item.userId); // 사용자정보 사용자 ID code
					$('#loginId').val(event.item.loginId).prop('readonly', true); // 로그인 ID
					$('#userInfoFrm').find('#userPassword').val(event.item.password); // 비밀번호
					$('#userNm').val(event.item.userNm); // 사용자 명
					$('#email').val(event.item.email); //이메일
					$('#moblphon').val(event.item.moblphon); //휴대폰 번호
					$('#ofcpsCode').val(event.item.ofcpsCode); //직위명
					$('#clsfCode').val(event.item.clsfCode); //직급명
					$('#telno').val(event.item.telno); //전화번호
					//$('#bplcCode').val(event.item.bplcCode); //사업장명
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', { 'bestInspctInsttCode' : event.item.bplcCode }, false, null, event.item.deptCode);
					$('#inspctInsttNm').val(event.item.inspctInsttNm); //부서
					//$('#deptCode').val(event.item.deptCode); //부서명
					$('#lockResn').val(event.item.lockResn); //잠금사유
					$('#signAtchmnflSeqno').val(event.item.signAtchmnflSeqno) //서명 첨부파일 일련번호
					$('#authorSeCode').val(event.item.authorSeCode); //권한코드
					$('#authorCode').val(event.item.authorSeCode); //권한이 변경되었는지 서비스단에서  확인하기위한 컬럼
					$('#rdmsGroupId').val(event.item.rdmsGroupId); //RDMS
					$('#encpn').val(event.item.encpn); //입사일자
					$('#resigndte').val(event.item.resigndte); //퇴사일자

					if(event.item.sbscrbConfmAt == 'Y') { // 가입 승인 여부
						$('#sbscrbConfmAtY').val(event.item.sbscrbConfmAt).prop('checked', true);
					} else {
						$('#sbscrbConfmAtN').val(event.item.sbscrbConfmAt).prop('checked', true);
					}

					if(event.item.useAt == 'Y') { // 사용여부
						$('#useAtY').val(event.item.useAt).prop('checked', true);
					} else {
						$('#useAtN').val(event.item.useAt).prop('checked', true);
					}

					if(event.item.lockAt == 'Y') { // 잠금 여부
						$('#lockAtY').val(event.item.lockAt).prop('checked', true);
					} else {
						$('#lockAtN').val(event.item.lockAt).prop('checked', true);
					}

					if(event.item.timhderAt == 'Y') {
						$('#timhderAt').prop('checked', true);
					} else {
						$('#timhderAt').prop('checked', false);
					}

					dropzoneArea_sign.getFiles($('#signAtchmnflSeqno').val());

					if (event.item.ifEmpnum) {
						$('.GuBunUser').prop('disabled', true);
					} else {
						$('.GuBunUser').prop('disabled', false);
					}

					if ('${UserMVo.authorSeCode}' != 'SY09000001') {
						//$('#bplcCode').prop('disabled', true);
						$('#authorSeCode').prop('disabled', true);
					}
				});

				// 사용여부 수정시 사용자 정보 input 바로 적용
				AUIGrid.bind(userGrid, 'cellEditEnd', function(event) {
					//체크박스
					if (event.item.useAt == 'Y') { // 사용여부
						$('#useAtY').val(event.item.useYn).prop('checked', true);
					} else {
						$('#useAtN').val(event.item.useYn).prop('checked', true);
					}
				});
			}

			function setButtonEvent() {

				//시스템권한 사업장 selecbox open
				/*if('${UserMVo.authorSeCode}' == 'SY09000001') {
					$('[name=bplcCode]:not(:selected)').attr('disabled',false);
				}*/

				//사용자 조회
				$('#btn_select').click(function() {
					selectList();
				});

				//사용안함
				$('#btn_notUse').click(function() {
					notUsingUser();
				});

				//6개월 이상 미접속자 조회
				$('#btn_notLoginSixMnth_select').click(function() {
					selectNotLoginSixMonth();
				});

				//가입승인
				$('#btn_sbscrb_confm').click(function() {
					sbscrbConfm();
				});

				//가입승대기 조회
				$('#btn_sbscrb_confm_select').click(function() {
					sbscrbConfmSelectList();
				});

				//비밀번호 초기화
				$('#btn_reset_password').click(function() {
					resetPassword();
				});

				//사용자 정보 신규
				$('#btn_new').click(function() {
					setClear(); // 초기화 함수 호출
					// 폼 초기화
					pageReset(['userInfoFrm'], null, null, function(){
						$("#btn_delete").hide();
					});

					//$('#bplcCode').val('${UserMVo.bestInspctInsttCode}');
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', { 'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}' }, false, null, '${UserMVo.deptCode}');
				});

				//사용자 정보 삭제
				$('#btn_delete').click(function() {
					deleteUserInfo(); // 초기화 함수 호출
				});

				//사용자 정보 저장
				$('#btn_save').click(function() {
					var count = 0;
					$('#userInfoFrm').find('input').each(function() {
						var nm = $(this).attr('name');
						if (nm == 'userNm' || nm == 'loginId'|| nm == 'password'|| nm == 'moblphon') {
							if (!$(this).prop('required')) {
								if ($(this).val() == '') {
									count++;
									$(this).focus();
									return;
								}
							}
						}
					});

					if('' == $('#deptCode option:selected').val() || undefined == $('#deptCode option:selected').val()) count++;

					if (count > 0) {
						warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
						return false;
					} else {
						atchmnflSave();
					}
				});

				/*$('#bplcCodeSch').change(function() {
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', { 'bestInspctInsttCode' : this.value }, true, null, "${UserMVo.deptCode}");
				});

				$('#bplcCode').change(function() {
					ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCode', { 'bestInspctInsttCode' : this.value }, true, null, "${UserMVo.deptCode}");
				});*/
			}

			//사용자 조회
			function selectList(rowVal) {
				getGridDataForm('<c:url value="/wrk/getUserMList.lims"/>', searchFrm, userGrid, function() {
					if (rowVal)
						gridSelectRow(userGrid, "loginId", rowVal);
				});
			}

			//사용안함
			function notUsingUser() {
				var checkedUser = AUIGrid.getCheckedRowItemsAll(userGrid);

				if(checkedUser <= 0) {
					alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
					return;
				}

				customAjax({
					"url": "/wrk/updNotUse.lims",
					"data": checkedUser,
					"successFunc": function(data) {
						if(data == 1) {
							success('${msg.C100000762}'); /* 저장 되었습니다. */
							setClear(); //초기화 함수 호출
							selectList(); //그리드 초기화
						}else {
							err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
						}
					}
				});
			}

			//6개월 이상 미접속자 조회
			function selectNotLoginSixMonth() {
				getGridDataParam("/wrk/getNotLoginSixMonth.lims", null, userGrid);
			}

			//가입승인
			function sbscrbConfm() {

				var checkGridData = AUIGrid.getCheckedRowItemsAll(userGrid);

				if(checkGridData <= 0) {
					alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
					return;
				} else {
					for(var i = 0; i < checkGridData.length; i++) {
						if(checkGridData[i].sbscrbConfmAt == 'Y') {
							alert('${msg.C100001155}'); /* 이미 승인된 사용자입니다. */
							return;
						}
					}
				}

				customAjax({
					url: '<c:url value="/wrk/updSbscrbConfm.lims"/>',
					data : checkGridData
				}).then(function(data) {
					if(data == 1) {
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						setClear(); //초기화 함수 호출
						selectList(); //그리드 초기화
					} else {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					}
				});

			}

			//가입승인대기 조회
			function sbscrbConfmSelectList() {
				getGridDataForm('<c:url value="/wrk/getSbscrbConfmUserList.lims"/>', searchFrm, userGrid, function(e) {});
			}

			//비밀번호 초기화
			function resetPassword() {

				var checkGridData = AUIGrid.getCheckedRowItemsAll(userGrid);

				if(checkGridData <= 0) {
					alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
					return;
				}

				customAjax({
					url: '<c:url value="/wrk/updResetPassword.lims"/>',
					data : checkGridData
				}).then(function(data) {
					if(data == 1) {
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						setClear(); //초기화 함수 호출
						selectList(); //그리드 초기화
					} else {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					}
				});
			}

			// 비밀번호 형식에 부합하는지 체크
			function passwordPolicyChk() {
				var param = $("#userInfoFrm").serializeObject().password;

				customAjax({
					"url": "/com/passwordPolicyCheck.lims",
					"data": param,
					"successFunc": function(data) {
						if(data == 100) {
							warn('${msg.C100001132}'); /* 허용 가능한 비밀번호 최대 자릿수를 초과하였습니다. */
						}else if(data == 101) {
							warn('${msg.C100001133}'); /* 비밀번호는 특수문자를 반드시 포함해야 합니다. */
						}else if(data == 102) {
							warn('${msg.C100001134}'); /* 비밀번호는 숫자를 반드시 포함해야 합니다. */
						}else if(data == 103) {
							warn('${msg.C100001135}'); /* 비밀번호는 영문 대문자를 반드시 포함해야 합니다. */
						}else {
							userInfoSave();
						}
					}
				});
			}

			function userInfoSave() {
				$(".GuBunUser").prop("disabled", false);
				$("#authorSeCode").prop("disabled", false);

				var loginId = document.getElementById('loginId').value;
				ajaxJsonForm('<c:url value="/wrk/putUserM.lims"/>', 'userInfoFrm', function(data) {
					if (data == 0) {
						err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
					} else if (data == 99) {
						err('${msg.C100000456}'); /* 사용자를 추가할 수 있는 권한이 없습니다 */
					} else {
						success('${msg.C100000762}'); /* 저장 되었습니다. */
						setClear(); //초기화 함수 호출
						selectList(loginId); //그리드 초기화
					}
				});
				$(".GuBunUser").prop("disable", true);
				//일반사용자인 경우 권한 선택 안되도록
				if('SY09000003' == '${UserMVo.authorSeCode}' || 'SY09000004' == '${UserMVo.authorSeCode}')
					$('#authorSeCode').prop('disabled', true);
			}

			// 첨부 파일 저장 함수
			function atchmnflSave() {
				var files_sign = dropzoneArea_sign.getNewFiles();
				var files_sign_cnt = files_sign.length;

				if (files_sign_cnt > 0) {
					$("#btnSave_sign").click();
					dropzoneArea_sign.on("uploadComplete", function(event,
							fileIdx) {
						if (fileIdx == -1) {
							err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
						} else {
							$("#signAtchmnflSeqno").val(fileIdx);
							passwordPolicyChk();
						}
					});
				} else { // 첨부파일이 없을 시
					passwordPolicyChk();
				}
			}

			//벨리데이션 체크
			function validationChk() {
				//ID 중복 체크
				$('#loginId').change(function() {

					var loginId = $('#loginId').val()
					if (loginId == 'admin') {
						warn('${msg.C100000008}') /* 'admin'은 아이디로 사용할 수 없습니다. 다른 아이디를 입력 해주세요. */
						$("#loginId").val('')
						$("#loginId").focus();
					} else {
						loginIdChk('#loginId');
					}

				});

				//이메일 체크
				$('#email').change(function() {

					var emailVal = $('#email').val();
					var regExp = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
					if (!emailVal.match(regExp)) {
						warn('${msg.C100000673}'); /* 이메일형식이 올바르지 않습니다. */
						$('#email').val('');
					}

				});

				//핸드폰 체크
				$('#moblphon').change(function() {

					var mobiNum = $('#moblphon').val();
					var putHyphen = mobiNum.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
					var mobiRegExp = /^\d{3}-\d{3,4}-\d{4}$/;
					if (!putHyphen.match(mobiRegExp)) {
						warn('${msg.C100000953}'); /* 핸드폰번호가 올바르지 않습니다. */
						$('#moblphon').val('');
					} else {
						//하이픈 넣은상태로 값 세팅
						$('#moblphon').val(putHyphen);
					}

				});

				//로그인ID 엔터키 이벤트
				$("#loginIdSch").keypress(function(e) {
					if (e.which == 13) {
						selectList();
					}
				});

				//사용자명 엔터키 이벤트
				$("#userNmSch").keypress(function(e) {
					if (e.which == 13) {
						selectList();
					}
				});
			}

			// ID 중복 체크 함수
			function loginIdChk() {
				var loginId = $('#loginId').val();
				var loginIdChkUrl = '<c:url value="/wrk/getLoginIdChk.lims"/>';
				if (loginId != '') {
					ajaxJsonForm(loginIdChkUrl, 'userInfoFrm', function(data) {

						if (data != 0) {
							warn('${msg.C100000838}'); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
							$('#loginId').val('');
						}
					});
				}
			}

			//사용자 삭제
			function deleteUserInfo() {
				var param = {
					"userId" : $('#userIdInfo').val(),
					"loginId" : $("#loginId").val()
					//"bplcCode" : $("#bplcCode").val()
				};

				if(!param["userId"]) {
					alert('${msg.C100000492}'); /* 선택된 사용자가 없습니다. */
					return false;
				}

				if(!confirm('${msg.C100000461}')) { /* 삭제하시겠습니까? */
					return false;
				}

				customAjax({
					url : '/wrk/deleteUserInfo.lims',
					data : param
				}).then(function(data) {
					if (data == 'Y')
						success('${msg.C100000462}'); /* 삭제되었습니다. */
					else if (data == 'N')
						err('${msg.C100000575}'); /* 실패하였습니다. */

					setClear(); // 초기화 함수 호출
					selectList(); // 그리드 초기화
				});
			}

			//초기화
			function setClear() {
				$('#loginId').prop("readonly", false) // 아이디 수정 가능
				$('#userIdInfo').val('');
				$('#userId').val('');
				$('#userInfoFrm')[0].reset(); // 폼 초기화
				$("input:radio[id='lockAtN']").prop("checked", true);
				$(".GuBunUser").prop("disabled", false);
				dropzoneArea_sign.clear(); // 드랍존 클리어
			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
