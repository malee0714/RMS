<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">일정 관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
	<div class=subContent>
	<div class="subCon1">
		<h2>${msg.C000000500}</h2> <!-- 일정관리 -->
		<div class="btnWrap">
			<button id="btn_select" class="btn4">${msg.C000000079}</button> <!-- 선택 -->
			<button id="btn_search" class="btn3 search">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" onsubmit="return false;">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:65%"></col>
				</colgroup>
				<tr>
					<th>${msg.C000000501}</th> <!-- 일정 구분 -->
					<td colspan="1" style="text-align:left;">
						<select id="schdulSeCodeSch" name="schdulSeCodeSch"></select>
					</td>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td colspan="1" style="text-align:left;">
						<label><input type="radio" id="use_asch" name="useAtSch" value="" >${msg.C000000062}</label> <!-- 전체 -->
						<label><input type="radio" id="use_ysch" name="useAtSch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" id="use_nsch" name="useAtSch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
				</tr>
			</table>

		</form>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="schdulMList" class="mgT15" style="width:100%; height:200px; margin:0 auto;"></div>
	</div>

	<div class="subCon1 wd47p mgT20 fL" style="display:inline-block; height:226px;">
		<h2>${msg.C000000502}</h2> <!-- 일정 정보 -->
		<form id="schdulForm" onsubmit="return false;">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
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
					<th class="necessary">${msg.C000000501}</th> <!-- 일정 구분 -->
					<td style="text-align:left;">
						<input type="hidden" id="schdulSeqno" name="schdulSeqno">
						<select id="schdulSeCode" name="schdulSeCode"></select>
					</td>
					<th>${msg.C000000506}</th> <!-- 문자 알림 -->
					<td  style="text-align:left;border-right: 1px solid #ccc;">
						<label><input type="checkbox" id="chrctrNtcnAt" name="chrctrNtcnAt"></label>
					</td>

<%-- 					<th>${msg.C000000503}</th> <!-- 팀장 알림 --> --%>
<!-- 					<td style="border-right: 1px solid #ccc;"> -->
<!-- 						<input type="checkbox" id="timhderNtcnAt" name="timhderNtcnAt"> -->
<!-- 					</td> -->


				</tr>

<!-- 				<tr> -->
<%-- 					<th>${msg.C000000505}</th> <!-- 개인 알림 --> --%>
<!-- 					<td  style="text-align:left;"> -->
<!-- 						<label><input type="checkbox" id="indvdlNtcnAt" name="indvdlNtcnAt"></label> -->
<!-- 					</td>		 -->

<!-- 				</tr>	 -->

				<tr>
					<th>${msg.C000000502}</th> <!-- 일정 정보 -->
					<td colspan="3"  style="border-right: 1px solid #ccc;">
						<input type="text" name="schdulCn" id="schdulCn">
					</td>

				</tr>
				<tr>
					<th>${msg.C000000507}</th> <!-- 문자 내용 -->
					<td  colspan="3" style="border-right: 1px solid #ccc;">
						<textarea name="chrctrCn" id="chrctrCn" style="width:100%;" rows="6"></textarea>
					</td>

				</tr>

				<tr>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td  colspan="3" style="text-align:left; border-right: 1px solid #ccc;">
						<label><input type="radio" id="use_y" name="useAt" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" id="use_n" name="useAt" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
				</tr>


			</table>
		</form>
	</div>

	<div class="subCon1 wd1p fL" style="display:inline-block; height:220px;">
	</div>

	<div class="subCon1 wd47p mgT20 fR" style="display:inline-block;">
		<div class="btnWrap">
			<button id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button id="btn_delete" class="btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>

		<div class="mgT30 fL" style="display:inline-block;">
			<h3>${msg.C000000187}</h3> <!-- 선택 담당자 목록 -->
		</div>
		<div class="btnWrap mgT30">
			<button id="btn_addUser" name="btn_addUser" class="btn4">${msg.C000000682}</button> <!-- 사용자 추가 -->
		</div>
		<div id="schdulUserGrid" style="width:100%; height:215px; margin-top:60px;">
		</div>
	</div>
</div>

<!--  body 끝 -->
    </tiles:putAttribute>
    <tiles:putAttribute name="script">
<!--  script 시작 -->
		<script>
			$(function() {
				getAuth(); //권한 체크

				//콤보 박스 초기화
				setCombo();

				//그리드 세팅
				setSchdulGrid();

				//그리드 이벤트 선언
				setSchdulGridEvent();

				//버튼 이벤트 선언
				setButtonEvent();

				//팝업 이벤트
				dialogUser("btn_addUser", null, "schdulUserDialog", function(item){
					for(var i =0; i<item.length; i++){
						AUIGrid.addRow(schdulUserGrid, item[i].item, "last");
					}
				}, function(){}, null, 'Y');

				getEl("chrctrCn").disabled = true;

			});
		</script>
		<script>
			var schdulUserGrid = "schdulUserGrid";
			var schdulMList = "schdulMList";
			var lang = ${msg}; /* 기본언어 */

			function setCombo(){
				ajaxJsonComboBoxCommon("SY16", "schdulSeCodeSch", false,"${msg.C000000079}");  /* 선택 */
				ajaxJsonComboBoxCommon("SY16", "schdulSeCode", false,"${msg.C000000079}");  /* 선택 */
			}

			//그리드 함수
			function setSchdulGrid(){
				var col = {
					schdulMList : [],
					schdulUserGrid : []
				};
				auigridCol(col.schdulMList);
				auigridCol(col.schdulUserGrid);

				col.schdulMList.addColumnCustom("schdulSeCodeNm","${msg.C000000501}","*",true) /* 일정 구분 */
				.addColumnCustom("timhderNtcnAt","${msg.C000000503}","*",false,false) /* 팀장 알림 */
				.addColumnCustom("indvdlNtcnAt","${msg.C000000505}","*",false,false) /* 개인 알림 */
				.addColumnCustom("chrctrNtcnAt","${msg.C000000506}","*",true,false) /* 문자 알림 */
				.addColumnCustom("schdulCn","${msg.C000000502}","*",true,false) /* 일정 정보 */
				.addColumnCustom("chrctrCn","${msg.C000000507}","*",false,false) /* 문자 내용 */
				.addColumnCustom("useAt","${msg.C000000065}","*",true); /* 사용여부 */

				col.schdulUserGrid.addColumnCustom("inspctInsttNm","${msg.C000000080}","*",true,false) /* 부서 */
				.addColumnCustom("userNm", "${msg.C000000442}","*",true,false); /* 사용자 */

				//auiGrid 생성
				schdulMList = createAUIGrid(col.schdulMList, schdulMList);
				schdulUserGrid = createAUIGrid(col.schdulUserGrid, schdulUserGrid);
				// 그리드 리사이즈.
				gridResize([schdulMList, schdulUserGrid]);

			}

			function setSchdulGridEvent(){

				AUIGrid.bind(schdulMList,"cellDoubleClick", function(event){
					gridDataSet("schdulForm", "input, select, textarea", event.item, function(){
						var check = !getEl("chrctrNtcnAt").checked;
						ajaxJsonParam3("/sys/getSchdulUserList.lims",{"schdulSeqno" : event.item.schdulSeqno}, function(data){
							 AUIGrid.setGridData(schdulUserGrid, data);
						});

						getEl("chrctrCn").disabled = check;
					});
				})
			}

			function setButtonEvent(){
				getEl("btn_search").addEventListener("click", function(){
					searchSchdulList();
				});

				getEl("btnSave").addEventListener("click", function(){
					saveSchdulInfo();
				})

				getEl("btn_new").addEventListener("click", function(){
					reset();
				})

				getEl("btn_select").addEventListener("click", function(){
					var row = AUIGrid.getSelectedItems(schdulMList);
					if(row.length > 0){
						var item = row[0].item
						gridDataSet("schdulForm", "input, select, textarea", item, function(){
							var check = !getEl("chrctrNtcnAt").checked;
							ajaxJsonParam3("/sys/getSchdulUserList.lims",{"schdulSeqno" : item.schdulSeqno}, function(data){
								 AUIGrid.setGridData(schdulUserGrid, data);
							});

							getEl("chrctrCn").disabled = check;
						});
					}else{
						alert("${msg.C000000509}"); /* 선택된 데이터가 없습니다. */
					}
				});

				getEl("btn_delete").addEventListener("click", function(){
					var schdulSeqno = getEl("schdulSeqno").value;
					if(schdulSeqno){
						schdulDelete(schdulSeqno);
					}else{
						alert("${msg.C000000510}") /* 삭제할 데이터가 없습니다. */
					}
				})

				getEl("chrctrNtcnAt").addEventListener("change", function(){
					var check = !getEl("chrctrNtcnAt").checked;

					getEl("chrctrCn").disabled = check;
				});
			};

			function searchSchdulList(){
				var param = $("#searchFrm").serializeObject();
				ajaxJsonParam3("/sys/getSchdulMList.lims", param, function(data){
					AUIGrid.setGridData(schdulMList, data);
					reset();
				});
			}

			function saveSchdulInfo(){
				var chrctrNtcnAt = getEl("chrctrNtcnAt").checked, chrctrCn = getEl("chrctrCn").value,
				gridData = {"userList" : AUIGrid.getGridData(schdulUserGrid)};

				if(!formNecessaryValidationCheck("schdulForm")){
					return false;
				}

				if(chrctrNtcnAt){
					if(!chrctrCn){
						alert("${msg.C000000511}"); /* 문자 내용을 입력하세요. */
						return false;
					}
				}
				getEl("chrctrCn").disabled = false;
				var param = $("#schdulForm").serializeObject();
				param = Object.assign(param, gridData);
				ajaxJsonParam3("/sys/saveSchdulInfo.lims", param, function(result){
					if(result){
						reset();
						searchSchdulList();
						alert("${msg.C000000071}");	/* 저장 되었습니다. */
					}
				});
			}

			function reset(){
				pageReset(["schdulForm"], [schdulUserGrid], null, function(){
				});

			}

			function schdulDelete(schdulSeqno){
				ajaxJsonParam3("/sys/delSchdule.lims", {"schdulSeqno" : schdulSeqno}, function(data){
					alert("${msg.C000000179}"); /* 삭제되었습니다. */
					searchSchdulList();
				})
			}
		</script>
<!--  script 끝 -->
	</tiles:putAttribute>

</tiles:insertDefinition>