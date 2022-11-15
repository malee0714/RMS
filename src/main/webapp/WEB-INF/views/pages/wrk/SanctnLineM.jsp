<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
    <tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000162}</h2> <!-- 결재라인 목록 -->
				<div class="btnWrap">
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form action="javascript:;" id="sanctnLineSearchFrm" name="sanctnLineSearchFrm">
					<table class="subTable1" style="width:100%;">
						<colgroup>
                            <col style="width:10%"/>
                            <col style="width:15%"/>
                            <col style="width:10%"/>
                            <col style="width:15%"/>
                            <col style="width:10%"/>
                            <col style="width:15%"/>
                            <col style="width:10%"/>
                            <col style="width:15%"/>
						</colgroup>
						<tr>
							<th>${msg.C100000401}</th> <!-- 부서 명-->
							<td>
								<select name="cboDeptS" id="cboDeptS" class="wd100p schClass"></select>
							</td>

							<th class="taCt vaMd">${msg.C100000160}</th> <!-- 결재 종류 -->
							<td>
								<select name="cboSanctnKndS" id="cboSanctnKndS" class="wd100p schClass"></select>
							</td>

							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" name="useYnS" value="">${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useYnS" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						    	<label><input type="radio" name="useYnS" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
							</td>

							<th>${msg.C100000167}</th> <!-- 결재자 -->
							<td>
								<input type="text"  id="cboSanctnerNm" name="cboSanctnerNm" class="schClass">
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<div id="sanctnLineGrid"></div>
			</div>
			<div class="subCon1 mgT20" id="detail">
				<h2><i class="fi-rr-apps"></i>${msg.C100000163}</h2> <!-- 결재라인 상세 정보 -->
				<div class="btnWrap">
					<button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
				</div>
				<form id="sanctnLineInfoFrm" name ="sanctnLineInfoFrm">
					<table class="subTable1" id="userInfotbl" style="width:100%;">
						<colgroup>
							<col style="width:10%"/>
							<col style="width:15%"/>
							<col style="width:10%"/>
							<col style="width:15%"/>
							<col style="width:10%"/>
							<col style="width:15%"/>
							<col style="width:10%"/>
							<col style="width:15%"/>
						</colgroup>
						<tr>
							<th class="taCt vaMd necessary">${msg.C100000401}</th> <!-- 부서 명 -->
							<td><select name="deptCode" id="deptCode" class="wd100p"></select></td>

							<th class="taCt vaMd necessary">${msg.C100000160}</th> <!-- 결재 종류 -->
							<td><select name="sanctnKndCode" id="sanctnKndCode" class="wd100p"></select></td>

							<th class="taCt vaMd necessary">${msg.C100000164}</th> <!-- 결재라인명 -->
							<td><input type="text" id=sanctnLineNm name="sanctnLineNm" class="wd100p" style="min-width:10em;"></td>

							<th>${msg.C100000443}</th> <!-- 사용여부 -->
							<td style="text-align:left;">
								<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" id="useN" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
					<input type="text" id="frmSanctnLineSeqno" name="sanctnLineSeqno" style="display:none">
				</form>
			</div>
            <div class="wd45p mgT25 fL">
                <div class="subCon1">
                    <h3>${msg.C100000782}</h3> <!-- 전체 사용자 목록 -->
                    <div class="btnWrap">
                        <button type="button" id="btnSearch_user" class="seacrh btn3">${msg.C100000767}</button> <!-- 조회 -->
                    </div>
                    <form action="javascript:;" id="userSearchFrm" name="userSearchFrm">
                        <table class="subTable1" style="width:100%;">
                            <colgroup>
								<col style="width: 20%"></col>
								<col style="width: 30%"></col>
								<col style="width: 20%"></col>
								<col style="width: 30%"></col>
							</colgroup>
                            <tr>
                                <th>${msg.C100000401}</th> <!-- 부서 명 -->
                                <td><select name="userDeptCode" id="userDeptCode" class="wd100p"></select></td>

                                <th>${msg.C100000452}</th> <!-- 사용자 명 -->
                                <td><input type="text"  id="userNmS" name="userNmS"></td>
                            </tr>
                        </table>
                        <input type="text" id="sanctnLineSeqno" name="sanctnLineSeqno" style="display:none">
                        <input type="text" id="limsUseAtSch" name="limsUseAtSch" value="Y" style="display:none">
                    </form>
                </div>
                <div class="subCon2">
                    <div class="mgT10">
                        <div id="userAGrid" style="width:100%; height:230px; margin:0 auto;"></div>
                    </div>
                </div>
            </div>
			<div class="arrowWrap wd10p mgT10" style="float: left;">
			    <div>
			        <button type="button" id="btnaddProbe"><i class="fi-rr-angle-right"></i></button>
			    </div>
			    <div class="mgT20">
			        <button type="button" id="btndelProbe"><i class="fi-rr-angle-left"></i></button>
			    </div>
			</div>
			<div class="wd45p mgT20"  style="display:inline-block;">
				<h3>${msg.C100000481}</h3> <!-- 선택 결재자 목록 -->
				<div class="mgT10">
					<div id="sanctnerGrid" style="width:100%; height:270px; margin:0 auto;"></div>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			var lang = ${msg}; // 기본언어
			var sanctnSeCode;

			var sanctnLineGrid = 'sanctnLineGrid';
			var userAGrid = 'userAGrid';
			var sanctnerGrid = 'sanctnerGrid';

			var sanctnLineInfoFrm = 'sanctnLineInfoFrm';
			var sanctnLineSearchFrm = 'sanctnLineSearchFrm';
			var userSearchFrm = 'userSearchFrm';

			$(function() {
				getAuth();

			 	setCombo();

			 	setGrid();

			 	setGridEvent();

				setButtonEvent();

				setEtcEvent();

				gridResize([sanctnLineGrid, sanctnerGrid, userAGrid]);
			});

			function setCombo() {
				var data = { upperCmmnCode: 'SY05' };
				ajaxJsonComboBox('/com/getCmmnCode.lims','cboSanctnKndS',{'upperCmmnCode' : 'CM05'},false,'${msg.C100000480}'); /* 선택 */
				ajaxJsonComboBox('/com/getCmmnCode.lims','sanctnKndCode',{'upperCmmnCode' : 'CM05'},false,'${msg.C100000480}');  /* 선택 */
				sanctnSeCode = getGridComboList('/com/getCmmnCode.lims',{'upperCmmnCode' : 'CM02'},true);

				var deptParams = { bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}' };
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','cboDeptS',deptParams,false, '${msg.C100000480}', '${UserMVo.deptCode}');
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','deptCode',deptParams,false, '${msg.C100000480}', '${UserMVo.deptCode}');
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','userDeptCode',deptParams,false, '${msg.C100000480}', '${UserMVo.deptCode}');
			};

			function setGrid() {

				var sanctnLineCol = [];
				auigridCol(sanctnLineCol);

				var userACol = [];
				auigridCol(userACol);

				var sanctnerCol = [];
				auigridCol(sanctnerCol);

				var sanctnerGridColPros = {
					selectionMode : 'multipleCells',
					// 드래깅 행 이동 가능 여부 (기본값 : false)
					enableDrag : true,
					// 다수의 행을 한번에 이동 가능 여부(기본값 : true)
					enableMultipleDrag : true,
					// 셀에서 바로  드래깅 해 이동 가능 여부 (기본값 : false) - enableDrag=true 설정이 선행
					enableDragByCellDrag : true,
					// 드랍 가능 여부 (기본값 : true)
					enableDrop : true,
					editable : true
				};

				//결재라인 그리드
				sanctnLineCol.addColumnCustom('deptNm','${msg.C100000401}',null,true) /* 부서명 */
				.addColumnCustom('sanctnLineSeqno','sanctnLineSeqno',null,false) /* 결재라인 일련번호 */
				.addColumnCustom('deptCode','deptCode',null,false) /* 부서코드 */
				.addColumnCustom('sanctnKndCode','sanctnKndCode',null,false) /* 결재종류코드 */
				.addColumnCustom('sanctnKndNm','${msg.C100000160}',null,true) /* 결재 종류 */
				.addColumnCustom('sanctnLineNm','${msg.C100000164}',null,true) /* 결재라인명 */
				.addColumnCustom('useAt','${msg.C100000443}',null,true); /* 사용여부 */

				//사용자목록 그리드
				userACol.addColumnCustom('sanctnLineSeqno','sanctnLineSeqno',null,false) /* 결재라인 일련번호 */
				.addColumnCustom('sanctnerId','sanctnerId',null,false) /* 사용자ID */
				.addColumnCustom('inspctInsttNm','${msg.C100000401}',null,true) /* 부서명 */
				.addColumnCustom('userNm','${msg.C100000452}',null,true) /* 사용자 명 */
				.addColumnCustom('sanctnOrdr','sanctnOrdr',null,false); /* 결재순서 */

				//결재자목록 그리드
				sanctnerCol.addColumnCustom('sanctnLineSeqno','sanctnLineSeqno',null,false,null,sanctnerGridColPros) /* 결재라인 일련번호 */
				.addColumnCustom('sanctnerId','sanctnerId',null,false,null,sanctnerGridColPros) /* 결재자ID */
				.addColumnCustom('inspctInsttNm','${msg.C100000401}',null,true,null,sanctnerGridColPros) /* 부서 명 */
				.addColumnCustom('userNm','${msg.C100000452}',null,true,null,sanctnerGridColPros) /* 사용자 명 */
				.addColumnCustom('sanctnSeCode','${msg.C100000153}',null,true,null,sanctnerGridColPros) /* 결재구분 */
				.addColumnCustom('sanctnOrdr','${msg.C100000166}',null,true,null,sanctnerGridColPros) /* 결재순서 */
				.dropDownListRenderer(['sanctnSeCode'],sanctnSeCode,true);

				var gridProps = {
						selectionMode : 'singleCell',
						editable : false,
						showRowCheckColumn : true,
						showRowAllCheckBox : true
				};

				sanctnLineGrid = createAUIGrid(sanctnLineCol, sanctnLineGrid);

				userAGrid = createAUIGrid(userACol, userAGrid, gridProps);

				sanctnerGrid = createAUIGrid(sanctnerCol, sanctnerGrid, gridProps);

			}

			function setGridEvent() {

				AUIGrid.bind(sanctnLineGrid, 'ready', function(event) {
					gridColResize(sanctnLineGrid, '2');	// 1, 2가 있으니 화면에 맞게 적용
				});

				AUIGrid.bind(userAGrid, 'ready', function(event) {
					gridColResize(userAGrid, '2');	// 1, 2가 있으니 화면에 맞게 적용
				});

				AUIGrid.bind(sanctnerGrid, 'ready', function(event) {
					gridColResize(sanctnerGrid, '2');	// 1, 2가 있으니 화면에 맞게 적용
				});

				AUIGrid.bind(sanctnLineGrid, "cellDoubleClick", function(event) {
					$('#sanctnLineSeqno').val(event.item.sanctnLineSeqno);
					$('#deptCode').val(event.item.deptCode).prop("selected",true);
					$('#sanctnLineNm').val(event.item.sanctnLineNm);
					$('#sanctnKndCode').val(event.item.sanctnKndCode);
					$('#frmSanctnLineSeqno').val(event.item.sanctnLineSeqno);

					if(event.item.useAt == 'Y')
						$("#useY").val(event.item.useAt).prop("checked", true);
					else
						$("#useN").val(event.item.useAt).prop("checked", true);

					//사용자조회
					searchUserAGrid();
					//결재자목록 그리드 호출
					searchSanctnerGrid();
				});

			}

			function setButtonEvent(){

				//결재라인 조회버튼
				$('#btnSearch').click(function(){
					searchSanctnLineGrid();
				});

				//초기화
				$("#btnReset").click(function (){
					frmReset();
				})

				//결재라인 저장
				$("#btnSave").click(function (){
					saveSanctnLineGrid();
				})

				//사용자목록조회
				$('#btnSearch_user').click(function(){
					searchUserAGrid();
				});

				//오른쪽이동
				$('#btnaddProbe').click(function(){
					moveGridData(userAGrid, sanctnerGrid);
				});

				//왼쪽이동
				$('#btndelProbe').click(function(){
					moveGridData(sanctnerGrid, userAGrid);
				});

				//위로이동
				$('#btnUp').click(function(){
					moveUpGrid();
				});

				//아래로이동
				$('#btnDown').click(function(){
					moveDownGrid();
				});

				//전체사용자목록 엔터버튼
				$('#userNmS').keypress(function(e){
					if (e.which == 13){
			        	searchUserAGrid();
			        }
				});
			};

			//기타이벤트
			function setEtcEvent(){
				$(".schClass").keypress(function (e) {
			        if (e.which == 13){
			        	searchSanctnLineGrid();
			        }
				});
			}

			//위로이동
			function moveUpGrid(){
				AUIGrid.moveRowsToUp(sanctnerGrid);
			};

			//아래로이동
			function moveDownGrid(){
				AUIGrid.moveRowsToDown(sanctnerGrid);
			};

			//결재라인조회
			function searchSanctnLineGrid(returnSeq){
				getGridDataForm('<c:url value="/wrk/getSanctnLineList.lims"/>', sanctnLineSearchFrm, sanctnLineGrid, function() {
					if (returnSeq)
						gridSelectRow(sanctnLineGrid, "sanctnLineSeqno", returnSeq);
				});
			};

			//사용자목록 조회
			function searchUserAGrid(){
				getGridDataForm('<c:url value="/wrk/getUserAList.lims"/>', userSearchFrm, userAGrid, function(data) {
					console.log(data);
					var sanctnerGridData = AUIGrid.getGridData(sanctnerGrid);
					if(sanctnerGridData.length > 0) {
						for(var i = 0; i < data.length; i++) {
							 for(var j = 0; j < sanctnerGridData.length; j++) {
								 if(sanctnerGridData[j].userId == data[i].userId) {
									 var getIndex = AUIGrid.getRowIndexesByValue(userAGrid, 'userId', [data[i].userId]);
									 //PK값으로 사용되는 키로 해당 인덱스를 조회해서 removeRow에 순서값으로 세팅해주면 해결이 된다~~
									 AUIGrid.removeRow(userAGrid, getIndex);
								 }
							 }
						}
					}
				});
			};

			//결재자목록조회
			function searchSanctnerGrid(){
				getGridDataForm('<c:url value="/wrk/getSanctnerList.lims"/>', userSearchFrm, sanctnerGrid);
			};

			//결재라인저장
			function saveSanctnLineGrid(){
				// 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승
				var count = 0;

				$('#' + sanctnLineInfoFrm).find('input, select').each(function(){
					var nm = $(this).attr("name");
				   	if( nm == "sanctnLineNm" || nm == "deptCode" || nm == "sanctnKndCode"){
					    if(!$(this).prop('required')){
							if($(this).val() == ''){
					 			count++;
					 			$(this).focus();
					 			warn('${msg.C100000695}'); /* 입력값이 누락된 사항이 있습니다. */
					 			return false;
							}
						}
			    	}
				});

				if(count > 0) {
					return;
				}

				var sanctnerGridData = AUIGrid.getGridData(sanctnerGrid);

				if(sanctnerGridData.length==0){
					warn("${msg.C100000169}"); /* 결재자목록이 1명이상 있어야합니다. */
					return;
				}

				var data = {
					sanctnLineVo : getFormParam(sanctnLineInfoFrm),
					sanctnLineList : sanctnerGridData
				};

				customAjax({
					url : '<c:url value="/wrk/saveSanctnLine.lims"/>',
					data : data
				}).then(function(data) {
					if (data < 1) {
						err("${msg.C100000597}"); /* 오류가 발생했습니다. log를 참조해주세요. */
					} else {
						success("${msg.C100000762}");	/* 저장 되었습니다. */
						frmReset();
						searchSanctnLineGrid(data);
					}
				});
			};

			//폼 초기화시 이벤트별로 셋팅할 것 들
			function frmReset(){
				$('#sanctnLineInfoFrm')[0].reset();
				AUIGrid.clearGridData(userAGrid);
				AUIGrid.clearGridData(sanctnerGrid);
			}

		</script>
	</tiles:putAttribute>
	</tiles:insertDefinition>
