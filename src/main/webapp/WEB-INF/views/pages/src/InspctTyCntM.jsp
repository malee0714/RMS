<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="body">
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>${msg.C100001276}</h2> <!-- 검사유형별 의뢰건수 조회 -->
        <div class="btnWrap">
            <button id="btnSelect" type="button" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
        </div>
        <form id="searchFrm">
            <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
                <colgroup>
                    <col style="width:9%"></col>
                    <col style="width:15%"></col>
                    <col style="width:9%"></col>
                    <col style="width:15%"></col>
                    <col style="width:9%"></col>
                    <col style="width:15%"></col>
                    <col style="width:9%"></col>
                    <col style="width:19%"></col>
                </colgroup>
                <tr>				
                    <th>${msg.C100000432}</th> <!-- 사업장 -->
                    <td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
                    <th>${msg.C100000986}</th> <!-- 의뢰 부서 -->
                    <td><select id="deptCodeSch" name="deptCodeSch"></select></td>
                    <th>${msg.C100000139}</th> <!-- 검사 유형 -->
                    <td><select id="inspctTyCodeSch" name="inspctTyCodeSch"></select></td>
                    <th>${msg.C100000607}</th> <!-- 연도 -->
                    <td><select id="yearSch" name="yearSch"></select></td>
                </tr>
            </table>
        </form>
    </div>
    
    <div class="subCon2 mgT20"s>
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
        <div class="wd100p mgT10" style="display:inline-block; order:1;">
            <div id="inspctTyCntGrid" class="wd100p" style="height:505px;"></div>
        </div>
    </div>
</div>
</tiles:putAttribute>

<tiles:putAttribute name="script">
<script>

var inspctTyCntGrid = 'inspctTyCntGrid';

$(document).ready(function() {
    setGrid();

    setCombo().then(function() {
        $("#bplcCodeSch").children('option:first').remove();
    });

    buttonEvent();
});

function setGrid() {
	var col = [];

	var rowProp = {
		enableCellMerge : true,
		cellMerge : true,
		cellMergePolicy : "withNull",
		rowSelectionWithMerge : true
	}
	
	auigridCol(col);
	col.addColumnCustom("reqestDeptNm","${msg.C100000986}",null,true,false,rowProp) // 의뢰 부서
	.addColumnCustom("inspctTyNm","${msg.C100000139}",null,true,false,rowProp) // 검사 유형
	.addColumnCustom("jan","1${msg.C100000006}",null,true,false) /* 1월 */
	.addChildColumn("jan", "janCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("feb","2${msg.C100000006}",null,true,false) /* 2월 */
	.addChildColumn("feb", "febCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("mar","3${msg.C100000006}",null,true,false) /* 3월 */
	.addChildColumn("mar", "marCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("apr","4${msg.C100000006}",null,true,false) /* 4월 */
	.addChildColumn("apr", "aprCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("may","5${msg.C100000006}",null,true,false) /* 5월 */
	.addChildColumn("may", "mayCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("jun","6${msg.C100000006}",null,true,false) /* 6월 */
	.addChildColumn("jun", "junCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("jul","7${msg.C100000006}",null,true,false) /* 7월 */
	.addChildColumn("jul", "julCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("aug","8${msg.C100000006}",null,true,false) /* 8월 */
	.addChildColumn("aug", "augCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("sep","9${msg.C100000006}",null,true,false) /* 9월 */
	.addChildColumn("sep", "sepCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("oct","10${msg.C100000006}",null,true,false) /* 10월 */
	.addChildColumn("oct", "octCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("nov","11${msg.C100000006}",null,true,false) /* 11월 */
	.addChildColumn("nov", "novCnt","${msg.C100000121}",null,true,false,null,null,null,null)
	.addColumnCustom("dec","12${msg.C100000006}",null,true,false) /* 12월 */
	.addChildColumn("dec", "decCnt","${msg.C100000121}",null,true,false,null,null,null,null);
	
	inspctTyCntGrid = createAUIGrid(col, inspctTyCntGrid);
}

function setCombo() {
    setYear('yearSch', new Date().getFullYear(), 2019, 10);
    ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, '${UserMVo.deptCode}');
    return ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctTyCodeSch', {'upperCmmnCode' : 'SY07'}, true);
}

function buttonEvent() {
    // 사업장 change
    $("#bplcCodeSch").change(function() {
        ajaxJsonComboBox('/com/getDeptCombo.lims', 'deptCodeSch', { 'bestInspctInsttCode' : $("#bplcCodeSch").val() }, true);
    });

    // 조회 버튼
    $("#btnSelect").click(function() {
        getReqCntByInspctTyList();
    });
}

// 조회
function getReqCntByInspctTyList() {
    getGridDataForm('/src/getReqCntByInspctTyAndMnth.lims', 'searchFrm', inspctTyCntGrid);
}

</script>
</tiles:putAttribute>
</tiles:insertDefinition>
