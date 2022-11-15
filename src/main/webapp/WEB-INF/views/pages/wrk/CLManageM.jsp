<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">UCL/LCL 산정기준관리</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!--  body 시작 -->
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000718}</h2> <!-- 자재목록 -->
				<!-- 제품목록 -->
				<div class="btnWrap">
					<button id="btnSave" class="btn1 save">${msg.C100000760}</button> <!-- 저장 -->
					<button id="btnPrductSearch" class="btn3 search">${msg.C100000767}</button> <!-- 조회 -->
				</div>                            
				<!-- Main content -->
				<form id="frmSearch">
					<input type="hidden" id="authorCode" name="authorCode" />
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
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
                            <!-- 사업장 -->
							<th>제품 구분</th>
							<td>
                                <select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
									<option value="">${msg.C100000480}</option> <!-- 선택 -->
							    </select>
								<input type="hidden" id="bplcCodeSch" name="bplcCodeSch" value="1000">
                            </td>
							<!-- 자재명 -->
							<th>${msg.C100000717}</th>
							<td><label><input type="text" class="schClass" name="mtrilNmSch"></label></td>

							<!-- 자재코드 -->
							<th>${msg.C100000725}</th>
							<td><label><input type="text" class="schClass" name="mtrilCodeSch"></label></td>

							<!-- 사용여부 -->
							<th>${msg.C100000443}</th>
							<td style="text-align: left;">
                                <label><input type="radio" name="useAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useAtSch" value="Y">${msg.C100000439}</label> <!-- 사용 --> 
                                <label><input type="radio" name="useAtSch" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="clManageGrid" style="height: 600px;"></div>
			</div>
		</div>
		<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
    <script>
        /**
         * 자재별 CL관리
         * @author shs
         */
        var lang = ${msg};
        window.onload = function() {
            setGrid();
            gridEvent();
            combo();
            buttonEvent();
            gridResize([clManageGrid]);
        };

        // AUIGrid 생성 후 반환 ID
        var clManageGrid = "clManageGrid"; // 제품 목록 그리드
        function setGrid() {

            //칼럼 설정
            var clManageGridcol = [];
            auigridCol(clManageGridcol);
            
            var tooltip = {
                style : "my-require-style",
                headerTooltip : { // 헤더 툴팁 표시 일반 스트링
                    show : true
                    ,tooltipHtml : '${msg.C000000263}' /* 값을 입력 또는 선택하세요. */
                }
            };
            
            //제품목록 그리드
            clManageGridcol.addColumnCustom("mtrilClManageSeqno"    , "자재관리seqno"       , "*", false, true)
                            .addColumnCustom("mtrilSeqno"           , "자재seqno"           , "*", false, true)
                            .addColumnCustom("prductSeCode"         , "제품 구분"   , "*", true,false) /* 자사구분 */
							.addColumnCustom("mtrilNm"              , "${msg.C100000717}"   , "*", true) /* 자재명 */
                            .addColumnCustom("mtrilCode"            , "${msg.C100000725}"   , "*", true)// 자재 코드
                            .addColumnCustom("lotNum"               , "${msg.C100000061}"   , "*", true, true, tooltip) /* LOT 건수 */
                            .addColumnCustom("sgmLevl"              , "${msg.C100000538}"   , "*", true, true, tooltip) /* 시그마 수준 */
                            .addColumnCustom("searchCycle"          , "${msg.C100000142}"   , "*", true, true, tooltip) /* 검색 주기 */
                            .addColumnCustom("executCycle"          , "${msg.C100000576}"   , "*", true, true, tooltip) /* 실행 주기 */
                            .addColumnCustom("cycleCode"            , "${msg.C100000577}"   , "*" , true, true, tooltip) /* 실행 주기 구분 */
                            .addColumnCustom("lastExecutDte"        , "${msg.C100000876}"   , "*" , true) /* 최종 실행 일자 */
                            .addColumnCustom("nextExecutDte"        , "${msg.C100000267}"   , "*" , true, true, tooltip) // 다음 실행 일자
                            .addColumnCustom("useAt"                , "${msg.C100000443}"   , "*", true, true) /* 사용 여부*/
                            .checkBoxRenderer([ "useAt" ], clManageGrid,{ check : "Y", unCheck : "N"}, {headerRenderer : { type : "CheckBoxHeaderRenderer",position: 'right', dependentMode : true}})
                            .calendarRenderer(["nextExecutDte"])
                            .inputEditRenderer(["lotNum","searchCycle","sgmLevl","executCycle"],{onlyNumeric : true, textAlign : "right", autoThousandSeparator : true})
                            .comboBoxRenderer([ "cycleCode" ], getGridComboList('/com/getCmmnCode.lims',{ 'upperCmmnCode' : 'SY14' }, false), true, null)
            clManageGrid = createAUIGrid(clManageGridcol, clManageGrid, {showStateColumn : true});
        }

        function getCLManageList() {
            getGridDataForm("<c:url value='/wrk/getCLManageList.lims'/>", "frmSearch", clManageGrid);
        }

        function gridEvent() {
            AUIGrid.bind(clManageGrid, "ready", function(event) {
                gridColResize(clManageGrid, "2");
            });
            AUIGrid.bind(clManageGrid, "cellEditEnd", function(event) {
                if(event.dataField != "useAt"){
                    var item = event.item;
                    item.useAt = "Y";
                    AUIGrid.updateRow(clManageGrid, item, event.rowIndex);
                }
            });
        }

        function combo() {
            ajaxJsonComboBox('/com/getCmmnCode.lims', "cntnrSeCodeSch",{ "upperCmmnCode" : "SY10", "deptCode" : "${UserMVo.deptCode}" }, true); // 용기 타입
            ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSeCodeSch",{ "upperCmmnCode" : "SY20", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
        }

        //버튼 이벤트
        function buttonEvent() {

            document.getElementById('btnPrductSearch').addEventListener('click',function(){
                getCLManageList();
            });

            document.getElementById('btnSave').addEventListener('click',function(){
            	var addRowItems = [];
                var list = addRowItems.concat(AUIGrid.getAddedRowItems(clManageGrid), AUIGrid.getEditedRowItems(clManageGrid));
                (list.length > 0) ? updateCLM(list) : alert(lang.C000000328); //추가/수정/삭제된 행이 없습니다.
            });
        }

        function updateCLM(list) {

            var test = gridRequire({
                list : list
                ,gridId : clManageGrid
                ,requireColumns : ["lotNum","sgmLevl","searchCycle","executCycle","cycleCode","nextExecutDte"]
                ,zeroCheck : true
            });

            if (test) {
                var ajax = customAjax({url : '/wrk/updateCLM.lims', data : list, elementIds : ["btnSave"]});
                    ajax.then(function(data) {
                        if (data > 0) {
                            success(lang.C000000071); /* 저장 되었습니다. */
                            getCLManageList();
                        }else {
                            err(lang.C000000170); /* 저장에 실패하였습니다. */
                        }
                    });
            }
        }

        //enter key event
        function doSearch() {
            getCLManageList();
        }
    </script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>


