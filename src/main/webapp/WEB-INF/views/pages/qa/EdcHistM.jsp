
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">PCN 관리</tiles:putAttribute>
<tiles:putAttribute name="body">
    <div class="subContent">
        <div class="subCon1">
            <h2><i class="fi-rr-apps"></i>교육 목록</h2> <!-- 교육 목록 -->
            <div class="btnWrap">
                <button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
            </div>

            <form id="SearchForm" onsubmit="return false;">
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
                        <th>교육 구분</th> <!-- 교육 구분 -->
                        <td><select id="schedcSeCode" name="schedcSeCode"></select></td>

                        <th>교육 구분 상세</th> <!-- 교육 구분 상세 -->
                        <td><select id="schEdcSeDetailCode" name="schEdcSeDetailCode"></select></td>

                        <th>제목</th> <!-- 제목 -->
                        <td><input type="text" id="schEdcSj" name="schEdcSj" class="searchOption edcSch"></td>

                        <th>교육 일자</th> <!-- 교육 일자 -->
                        <td>
                            <input type="text" id="schEdcBeginDte" name="schEdcBeginDte" class="dateChk wd6p" style="min-width:6em;">
                            ~
                            <input type="text" id="schEdcEndDte" name="schEdcEndDte" class="dateChk wd6p" style="min-width:6em;">
                        </td>
                    </tr>
                    <tr>
                    	<th>부서</th> <!-- 부서 -->
                        <td><select id="schDeptCode" name="schDeptCode"></select></td>
                        
                        <th>사용자 명</th> <!-- 사용자 명 -->
                        <td><input type="text" id="schUserNm" name="schUserNm" class="searchOption"></td>
                    </tr>
                </table>
            </form>
        </div>
        <div class="subCon2">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="EdcGrid" class="mgT15" style="height: 300px"></div>
        </div>
    </div>
</tiles:putAttribute>
<tiles:putAttribute name="script">

<script>

var edcGrid = "EdcGrid";
var allUserGrid = "AllUserGrid";
var edcUserGrid = "EdcUserGrid";
var lang = ${msg};

var searchForm = document.getElementById("SearchForm").id;

$(function() {

    init();

    setCombo();

    buildGrid();

    buttonEvent();

});


function init() {

    datePickerCalendar(["schEdcBeginDte", "schEdcEndDte"], true, ["YY",-1], ["DD",0]);
    datePickerCalendar(["edcBeginDte", "edcEndDte", "nxttrmEdcDte"], false);

}


function setCombo() {
    ajaxJsonComboBox("/com/getCmmnCode.lims", "schedcSeCode", { upperCmmnCode : "RS07" }, true);
    ajaxJsonComboBox("/com/getCmmnCode.lims", "schEdcSeDetailCode", { upperCmmnCode : "RS33" }, true);
    
    ajaxJsonComboTrgetName({
        url : '/wrk/getDeptComboList.lims',
        name : 'schDeptCode',
        queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" },
        selectFlag : true
    });
	
}


function buildGrid() {
    var col = {
        edcCol: [],
        allUserCol: [],
        edcUserCol: []
    };

    /********************** 교육 목록 **********************/
    var edcProp = {
        editable: false,
        selectionMode: "multipleCells"
    };

    auigridCol(col.edcCol);

    col.edcCol
    .addColumnCustom("inspctInsttNm", "부서명", "*", true)
    .addColumnCustom("userNm", "사용자 명", "*", true)
    .addColumnCustom("edcSeNm", "교육 구분", "*", true)
    .addColumnCustom("edcSeDetailNm", "교육 구분 상세", "*", true)
    .addColumnCustom("edcSj", "교육 제목", "*", true)
    .addColumnCustom("edcBeginDte", "교육 시작 일자", "*", true)
    .addColumnCustom("edcEndDte", "교육 종료 일자", "*", true)
    .addColumnCustom("edcUser", "대상자", "*", true)
    .addColumnCustom("evlerNm", "평가자", "*", true)
    .addColumnCustom("evlCn", "평가 내용", "*", true)
    .addColumnCustom("evlResultValue", "평가 결과", "*", true)
    .addColumnCustom("edcQualfAlwncCodeNm", "자격 부여", "*", true)
    .addColumnCustom("nxtEdcTrgetAtNm", "차기 교육", "*", true);

    edcGrid = createAUIGrid(col.edcCol, edcGrid, edcProp);

}

function buttonEvent() {
	
	// 엔터키 이벤트.
	$(".searchOption").keypress(function(e) {
		setTimeout(function() {
			if(e.which == 13) {
				searchEdc();
			}
		}, 100);
	});

	// 조회 이벤트.
    $("#btnSearch").click(function() {
        searchEdc();
    });


}

function searchEdc() {
    getGridDataForm("/qa/getEdcAllList.lims", searchForm, edcGrid);
}

</script>
</tiles:putAttribute>
</tiles:insertDefinition>
