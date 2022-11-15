<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">부적합품관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent" style=height:auto;>
    <div class="subCon1">
            <h2><i class="fi-rr-apps"></i>부적합품목록</h2>
            <div class="btnWrap">
                <button type="button" id="btnSearch" class="search" onclick="doSearch()">${msg.C100000767}</button> <!-- 조회 -->
            </div>
        <form action="javascript:;" id="searchFrm" name="searchFrm">
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
                    <th>부적합 Part</th>
                    <td>
                        <select class="wd100p schClass" id="prductTyNmSch" name="prductTyNmSch"></select>
                    </td>

                    <th>부적합 제품</th>
                    <td colspan = '3'>
                        <input type="text" name="mtrilNmSch" id="mtrilNmSch" class="schClass">
                    </td>
                    <th>OCAP상태</th>
                    <td>
                        <select class="wd100p schClass" id="ocapSttusCodeSch" name="ocapSttusCodeSch"></select>
                    </td>

                </tr>
                <tr>
                    <th>담당부서</th>
                    <td>
                        <select class="wd100p schClass" id="chrgDeptCodeSch" name="chrgDeptCodeSch"></select>
                    </td>
                    <th>담당자</th>
                    <td>
                        <input type="text" name="chargerIdSch" id="chargerIdSch" class="schClass">
                    </td>
                    <th>검토부서</th>
                    <td>
                        <select class="wd100p schClass" id="exmntDeptCodeSch" name="exmntDeptCodeSch"></select>
                    </td>
                    <th>완료일자</th>
                    <td>
                        <input type="text" id="comptBeginDte" name="comptBeginDte" class="dateChk wd6p" style="min-width: 6em;" autocomplete="off">~
                        <input type="text" id="comptEndDte" name="comptEndDte" class="dateChk wd6p" style="min-width: 6em;"autocomplete="off">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="subCon2 mgT15">
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
        <div id="ncrGrid" style="width: 100%; height: 300px; margin: 0 auto;" class="mgT15 grid"></div>
    </div>

    <div class="mapkey">
        <label class="scarce">${msg.C100000343}</label><!-- 반려 -->
    </div>

    <div class="subCon1 mgT15">
        <form id="frmNcr" name="frmNcr" onsubmit="return false">
            <input type="text" name="exmntSeqno" style="display: none"/>
            <h2><i class="fi-rr-apps"></i>부적합품정보</h2>
            <div class="btnWrap">
                <button type="button" id="btnNew" class="btn4" onclick="init()">신규</button>
                <button id="btn_delete" class="delete" data-visible-code=["CM01000001","CM01000004","init"] style="display: none">삭제</button>
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"] style="display: none">회수</button>
                <button id="btnTempSave" class="save" data-visible-code=["CM01000001","CM01000004","init"]>저장</button>
                <button type="button" id="btnExmnt" class="save" data-visible-code=["CM01000005"] style="display: none">검토</button>
                <button id="btnApprovalRequest" class="save" data-visible-code=["CM01000001","CM01000004","init"]>결재상신</button>
                <input type="hidden" id="btnDialogExmnt" class="save" value="검토">
            </div>

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
                    <th class="necessary">부적합 제품</th>
                    <td colspan = '3'>
                        <input type="text" name="mtrilNm" id="mtrilNm" class="wd80p" required readonly />
                        <button type="button" id="btnNcrMtrilSearch" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","init"]><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                        <button type="button" id="btnNcrMtrilReset" class="inTableBtn inputBtn btn5" data-visible-code=["CM01000001","CM01000004","init"]><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
                    </td>
                    <th class="necessary">부적합 Part</th>
                    <td>
                        <input type="text" name="prductTyNm" id="prductTyNm" required readonly>
                    </td>
                    <th>발생일자</th>
                    <td>
                        <input type="text" id="occrrncDte" name="occrrncDte" class="dateChk"></td>
                    </td>
                </tr>
                <tr>
                    <th class="necessary">담당부서</th>
                    <td>
                        <select class="wd100p schClass" id="chrgDeptCode" name="chrgDeptCode" required></select>
                    </td>
                    <th class="necessary">담당자</th>
                    <td>
                        <select class="wd100p schClass" id="chargerId" name="chargerId" required></select>
                    </td>
                    <th>검토부서</th>
                    <td>
                        <select class="wd100p schClass" id="exmntDeptCode" name="exmntDeptCode"></select>
                    </td>
                    <th>OCAP상태</th>
                    <td>
                        <select class="wd100p schClass" id="ocapSttusCode" name="ocapSttusCode"></select>
                    </td>
                </tr>
                <tr>
                    <th class="necessary">부적합내용</th>
                    <td colspan = '7'><input type="text" name="improptCn" id="improptCn" required></td>
                </tr>
                <tr>
                    <th>원인분석</th>
                    <td colspan = '3'><input type="text" name="causeAnalsCn" id="causeAnalsCn"></td>
                    <th>개선대책</th>
                    <td colspan = '3'><input type="text" name="imprvmCntrplnCn" id="imprvmCntrplnCn"></td>
                </tr>
                <tr>
                    <th>부적합정도</th>
                    <td>
                        <select class="wd100p schClass" id="improptDgreeCode" name="improptDgreeCode"></select>
                    </td>
                    <th>처리형태</th>
                    <td>
                        <select class="wd100p schClass" id="improptProcessStleCode" name="improptProcessStleCode"></select>
                    </td>
                    <th>완료일자</th>
                    <td>
                        <input type="text" id="comptDte" name="comptDte" class="dateChk"></td>
                    </td>
                    <th>유효성평가</th>
                    <td>
                        <select class="wd100p schClass" id="improptValidfmnmEvlCode" name="improptValidfmnmEvlCode"></select>
                    </td>
                </tr>
                <tr>
                    <th>유효성평가일자</th>
                    <td>
                        <input type="text" id="validfmnmEvlDte" name="validfmnmEvlDte" class="dateChk"></td>
                    </td>
                    <th>처리결과</th>
                    <td>
                    <select class="wd100p schClass" id="improptProcessResultCode" name="improptProcessResultCode"></select>
                    </td>
                    <th></th>
                    <td></td>
                    <th></th>
                    <td></td>
                </tr>
                <tr>
                    <th>재발방지대책</th>
                    <td colspan = '7'><input type="text" name="recrPrvnCntrplnCn" id="recrPrvnCntrplnCn"></td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="7">
                        <div id="dropZoneArea"></div>
                        <input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" />
                        <input type="hidden" id="dropzoneBtnSave">
                    </td>
                </tr>
                <tr>
                    <th>결재정보</th>
                    <td colspan="4">
                        <select id="sanctnLineSeqno" name="sanctnLineSeqno"style="width: 25%;"></select>
                        <input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 51%;" readonly>
                        <input type="hidden" id="sanctnerId" name="sanctnerId">
                        <input type="hidden" id="sanctnSeqno" name="sanctnSeqno">
                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn"  data-visible-code=["CM01000001","CM01000004","init"]>${msg.C100000165}</button>
                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["CM01000001","CM01000004","init"]><img src="/assets/image/close14.png"></button>
                        <input type="text" name="sanctnInfoList" style="display: none;">
                    </td>
                </tr>
            </table>
            <input type="hidden" id="reqestSeqno" name="reqestSeqno">
            <input type="hidden" id="reqestExpriemSeqno" name="reqestExpriemSeqno">
            <input type="hidden" id="ncrSeqno" name="ncrSeqno">
        </form>
    </div>

    <div style="display: flex;">
        <div class="wd50p mgT15">
            <div class="subCon1">
                <h3>전체 시험항목</h3>
            </div>
            <div class="subCon2">
                <div id="exprGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>

        <div class="arrowWrap wd10p mgT30">
            <div>
                <button type="button" id="arrow3"><i class="fi-rr-angle-right"></i></button>
            </div>
            <div class="mgT20">
                <button type="button" id="arrow4"><i class="fi-rr-angle-left"></i></button>
            </div>
        </div>

        <div class="wd50p mgT15">
            <div class="subCon1">
                <h3>부적합 시험항목</h3>
            </div>
            <div class="subCon2">
                <div id="ncrExpriemGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>
    </div>

    <div class="accordion_wrap mgT15">
        <div class="accordion">부적합품 이력</div>
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>부적합품 이력</h3>
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div class="subCon2">
                <div id="ncrAccordionGrid" class="mgT10" style="width: 100%; height: 300px; margin: 0 auto;"></div>
            </div>
        </div>
    </div>
</div>
<!--  body 끝 -->
    </tiles:putAttribute>
    <tiles:putAttribute name="script">
<!--  script 시작 -->
<script>
$(function(){
    //그리드 생성
    setNcrGrid();

    //팝업
    popUp();

    //콤보 생성
    setCombo();

    //버튼 이벤트
    setButtonEvent();

});
var ncrGrid = '#ncrGrid'; //부적합품목록 그리드
var exprGrid = 'exprGrid'; // 시험항목 그리드
var ncrExpriemGrid = 'ncrExpriemGrid'; // 부적합 시험항목 그리드
var ncrAccordionGrid = 'ncrAccordionGrid'; //부적합 이력 그리드
var searchFormEl = document.querySelector('#searchFrm');
var ncrFormEl = document.querySelector('#frmNcr');
var lang = ${ msg }; // 기본언어
var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId: "#dropzoneBtnSave", maxFiles: 20, lang: "${msg.C100000867}" }); /* 첨부할 파일을 이 곳에 드래그하세요. */
var visibleSupport = new VisibleSupport('data-visible-code');
var sessionObj = {
    bplcCode : "${UserMVo.bestInspctInsttCode}",
    deptCode : "${UserMVo.deptCode}"
};
var sanctnLineControll = new SelectBoxControll(ncrFormEl.querySelector('[name=sanctnLineSeqno]'));
var saveKey = '';

function setNcrGrid(){
    var ncrGridCol = [];
    auigridCol(ncrGridCol);
        ncrGridCol.addColumnCustom("mtrilNm", "부적합 제품","*",true)
        ncrGridCol.addColumnCustom("prductTyNm", "부적합 Part","*",true)
        ncrGridCol.addColumnCustom("occrrncDte", "발생일자","*",true)
        ncrGridCol.addColumnCustom("chrgDeptCode", "담당부서","*",false)
        ncrGridCol.addColumnCustom("chrgDeptCodeNm", "담당부서","*",true)
        ncrGridCol.addColumnCustom("chargerId", "담당자","*",false)
        ncrGridCol.addColumnCustom("chargerIdNm", "담당자","*",true)
        ncrGridCol.addColumnCustom("exmntDeptCode", "검토부서","*",false)
        ncrGridCol.addColumnCustom("exmntDeptCodeNm", "검토부서","*",true)
        ncrGridCol.addColumnCustom("ocapSttusCode", "OCAP상태","*",false)
        ncrGridCol.addColumnCustom("ocapSttusCodeNm", "OCAP상태","*",true)
        ncrGridCol.addColumnCustom("improptDgreeCode", "부적합정도","*",false)
        ncrGridCol.addColumnCustom("improptDgreeCodeNm", "부적합정도","*",true)
        ncrGridCol.addColumnCustom("improptValidfmnmEvlCode", "유효성평가","*",false)
        ncrGridCol.addColumnCustom("improptValidfmnmEvlCodeNm", "유효성평가","*",false)
        ncrGridCol.addColumnCustom("improptProcessStleCode", "처리형태","*",false)
        ncrGridCol.addColumnCustom("improptProcessStleCodeNm", "처리형태","*",true)
        ncrGridCol.addColumnCustom("comptDte", "완료일자","*",true)
        ncrGridCol.addColumnCustom("sanctnProgrsSittnCodeNm", "결재진행상태")
        ncrGridCol.addColumnCustom("improptProcessResultCode", "처리결과","*",false)
        ncrGridCol.addColumnCustom("improptProcessResultCodeNm", "처리결과","*",false)
        ncrGridCol.addColumnCustom("improptCn", "부적합내용","*",true)
        ncrGridCol.addColumnCustom("causeAnalsCn", "원인분석","*",true)
        ncrGridCol.addColumnCustom("imprvmCntrplnCn", "개선대책","*",true)
        ncrGridCol.addColumnCustom("improptValidfmnmEvlCodeNm", "유효성평가","*",true)
        ncrGridCol.addColumnCustom("recrPrvnCntrplnCn", "재발방지대책","*",true)
    // ncrGrid = createAUIGrid(ncrGridCol, ncrGrid);
    createAUIGrid(ncrGridCol, ncrGrid, {
        rowStyleFunction: function (rowIndex, item) {
            return (item.sanctnProgrsSittnCode === "CM01000004") ? "grid-scarce" : "";
        }
    });


    //전체메뉴, 권한메뉴 속성
    var ncrGridPros = {
        editable : false, // 편집 가능 여부 (기본값 : false)
        selectionMode : "multipleCells", // 셀 선택모드 (기본값: singleCell)
        softRemovePolicy : "exceptNew",
        softRemoveRowMode : true,
        showStateColumn : true,
        //엑스트라체크박스 표시
        showRowCheckColumn : true,
        // 전체 체크박스 표시 설정
        showRowAllCheckBox : true
    };

    var exprGridCol = [];
    auigridCol(exprGridCol);
    exprGridCol.addColumnCustom("seqCount", "seqCount","*",false)
    exprGridCol.addColumnCustom("reqestExpriemSeqno", "시험항목","*",false)
    exprGridCol.addColumnCustom("expriemNm", "시험항목","*",true)
    exprGridCol.addColumnCustom("exprOdr", "차수","*",true)
    exprGridCol.addColumnCustom("qcResultValue", "적합 Data","*",true)
    exprGrid = createAUIGrid(exprGridCol, exprGrid, ncrGridPros);

    var ncrExpriemGridCol = [];
    auigridCol(ncrExpriemGridCol);
    ncrExpriemGridCol.addColumnCustom("seqCount", "seqCount","*",false)
    ncrExpriemGridCol.addColumnCustom("reqestExpriemSeqno", "시험항목","*",false)
    ncrExpriemGridCol.addColumnCustom("expriemNm", "시험항목","*",true)
    ncrExpriemGridCol.addColumnCustom("exprOdr", "차수","*",true)
    ncrExpriemGridCol.addColumnCustom("qcResultValue", "부적합 Data","*",true)
    ncrExpriemGrid = createAUIGrid(ncrExpriemGridCol, ncrExpriemGrid, ncrGridPros);

    var ncrAccordionCol = [];
    auigridCol(ncrAccordionCol);
    ncrAccordionCol.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)
    ncrAccordionCol.addColumnCustom('tableNm',lang.C100000973,'*',true,false)
    ncrAccordionCol.addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)
    ncrAccordionCol.addColumnCustom('columnNm',lang.C100000975,'*',true,false)
    ncrAccordionCol.addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)
    ncrAccordionCol.addColumnCustom('seqno','일련번호','*',false,false)
    ncrAccordionCol.addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)
    ncrAccordionCol.addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)
    ncrAccordionCol.addColumnCustom('lastChangerId',"최종변경자",'*',false,false)
    ncrAccordionCol.addColumnCustom('changerNm',"최종변경자",'*',true,false)
    ncrAccordionCol.addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false)
    ncrAccordionGrid = createAUIGrid(ncrAccordionCol, ncrAccordionGrid);
    AUIGrid.setFixedColumnCount(ncrGrid, 15);

    gridBindEvent();
}

function gridBindEvent(){
    AUIGrid.bind(ncrGrid, "ready", function() {
        AUIGrid.setFixedColumnCount(ncrGrid, 0);
        if ( !!saveKey ){
            gridSelectRow(ncrGrid, "ncrSeqno", [saveKey]);
        }
    });

    AUIGrid.bind(ncrGrid, "cellDoubleClick", function(event) {
        detailAutoSet({
            "item" : event.item,
            "targetFormArr" : ["frmNcr"],
            "successFunc" : function(){
                getExprGrid(event.item);
                getNcrExpriemGrid(event.item.ncrSeqno);
                progrsControll(event.item.sanctnProgrsSittnCode);
                getQlityHistList(event.item);
            }
        });

    });
}

function setCombo(){
    ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'chrgDeptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, null);
    ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'chrgDeptCode', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, null);
    ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'exmntDeptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null);
    ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'exmntDeptCode', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, '${UserMVo.deptCode}');
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'ocapSttusCodeSch', { 'upperCmmnCode': 'RS20' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'ocapSttusCode', { 'upperCmmnCode': 'RS20' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'improptDgreeCode', { 'upperCmmnCode': 'RS19' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'improptProcessStleCode', { 'upperCmmnCode': 'RS31' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'improptValidfmnmEvlCode', { 'upperCmmnCode': 'RS32' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'improptProcessResultCode', { 'upperCmmnCode': 'RS34' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'prductTyNmSch', { 'upperCmmnCode': 'SY20' }, true);
    ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'chargerId', {'deptCode' : null}, true);
    ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims', 'sanctnLineSeqno', { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000005" }, false, "${msg.C100000480}"); /* 선택 */
    datePickerCalendar(["comptBeginDte", "comptEndDte"], true, ["YY",-1], ["DD",0]);
    datePickerCalendar(["occrrncDte"], true, ["DD",0]);
    datePickerCalendar(["comptDte"], true, ["DD",0]);
    datePickerCalendar(["validfmnmEvlDte"], true, ["DD",0]);
}
function popUp() {
    //부적합 제품 팝업
    dialogReqest("btnNcrMtrilSearch", "ncrReqDialog", null, sessionObj, function(items) {
        detailAutoSet({"item" : items, "targetFormArr":["frmNcr"]});
        getExprGrid(items);
        getNcrExpriemGrid(items.ncrSeqno);
    });

    //결재 팝업
    dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {
        var list = res.gridData;

        if (list.length > 0) {
            var sanctnerNm = getSanctnerNm(list);
            ncrFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
            ncrFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
        } else {
            warn('선택된 결재자가 없습니다.');
        }
    }, null, "CM05000005"); //결재종류 부적합품

    //검토 팝업
    dialogExmnt({
        btnId: 'btnDialogExmnt',
        functions: {
            getExmntSeqno : getExmntSeqno,
            getOtherKey : getOtherKey,
            init : function() {
                reset();
                searchNcrM();
            }
        },
        dialogId: 'auditDialogExmnt',
        url: '/qa/ncrSaveExmnt.lims'
    });
}

//버튼 이벤트
function setButtonEvent() {
    document.getElementById('arrow3').addEventListener('click', function () {
        rightBtnClick();
    });

    document.getElementById('arrow4').addEventListener('click', function () {
        leftBtnClick();
    });

    searchFormEl.querySelector('select[name=chrgDeptCodeSch]').addEventListener('change', function (e) {
        bindUserSelectbox(e.target.value);
    });
    ncrFormEl.querySelector('select[name=chrgDeptCode]').addEventListener('change', function (e) {
        bindUserSelectbox(e.target.value);
    });

    ncrFormEl.querySelector('[name=sanctnLineSeqno]').addEventListener('change', function (e) {
        customAjax({
            url: '/wrk/getSanctnerList.lims',
            data: {sanctnLineSeqno: e.target.value},
        }).then(function (res) {
            if (res.length > 0) {
                var sanctnerNm = getSanctnerNm(res);
                ncrFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(res);
                ncrFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }
        });
    });

    ncrFormEl.querySelector('#btn_delete').addEventListener('click', function () {
        deleteNcr();
    });

    //임시저장
    ncrFormEl.querySelector('#btnTempSave').addEventListener('click', function (e) {
        saveAtEvent(e);
        atchmnflSave(e);
    });

    //결재상신
    ncrFormEl.querySelector('#btnApprovalRequest').addEventListener('click', function (e) {
        saveAtEvent(e);
        atchmnflSave(e);
    });

    // 결재팝업 input reset 버튼
    ncrFormEl.querySelector('#sanctnReset').addEventListener('click', function () {
        ncrFormEl.querySelector('[name=sanctnerNm]').value = '';
        ncrFormEl.querySelector('[name=sanctnSeqno]').value = '';
    });

    document.getElementById("btnNew").addEventListener('click', function(e) {
        reset();
    });

    document.getElementById("btnRevert").addEventListener('click', function(e) {
        revertNcr();
    });

    ncrFormEl.querySelector('#btnExmnt').addEventListener('click', function () {
        var ncrSeqnoValue = ncrFormEl.querySelector('[name=ncrSeqno]').value;
        if (!!ncrSeqnoValue) {
            ncrFormEl.querySelector('#btnDialogExmnt').click();
        } else {
            warn('감사 정보 저장 후 검토할 수 있습니다.');
        }
    });

    ncrFormEl.querySelector('#btnNcrMtrilReset').addEventListener('click', function () {
        ncrFormEl.querySelector('[name=mtrilNm]').value = '';
        ncrFormEl.querySelector('[name=prductTyNm]').value = '';
        AUIGrid.clearGridData(exprGrid);
    });

}
//전체 시험항목
function getExprGrid(item){
    // var param = {
    //     "reqestSeqno" : item.reqestSeqno,
    //     "ncrSeqno" : item.ncrSeqno
    // }
    // getGridDataParam('/qa/getExprGrid.lims', param, exprGrid);
    getGridDataParam('/qa/getExprGrid.lims', {reqestSeqno : item.reqestSeqno}, exprGrid);

}


//부적합 시험항목
function getNcrExpriemGrid(ncrSeqno){
    getGridDataParam('/qa/ncrExpriemGrid.lims', {ncrSeqno : ncrSeqno}, ncrExpriemGrid);
}

function bindUserSelectbox(deptCode, callback) {
    ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', name : 'chargerId', queryParam : { "deptCode": deptCode }, selectFlag : true})
        .then(callback);
}

// dialog parameter function
function getExmntSeqno() {
    return ncrFormEl.querySelector('[name=exmntSeqno]').value;
}

// dialog parameter function
function getOtherKey() {
    return ncrFormEl.querySelector('[name=ncrSeqno]').value;
}

// 조회 함수
function searchNcrM() {
    getGridDataForm('/qa/getNcrList.lims', "searchFrm", ncrGrid);
}

// 첨부 파일 저장
function atchmnflSave(e) {

    if(!saveValidation(ncrFormEl.id)) return;
    if (e.target.id === 'btnApprovalRequest') {
        if (!sanctnValid()) {
            warn('결재 정보 선택 또는 결재 라인을 설정해주세요.')
            return;
        }
    }

    var files = dropZoneArea.getNewFiles();
    var len = files.length;
    if (len > 0) {
        $("#dropzoneBtnSave").click();
        dropZoneArea.on("uploadComplete", function(event, fileIdx) {
            if (fileIdx === -1) {
                err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
            } else {
                ncrFormEl.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
                ncrSave(e);
            }
        });
    } else { // 첨부파일이 없을 시
        ncrSave(e);
    }
}
// 부적합 저장
function ncrSave(e){
    var url = e.target.id === "btnTempSave" ? "/qa/saveNcr.lims" : "/qa/approvalRequestNcr.lims";
    var successMsg = e.target.id === "btnTempSave" ? "저장 되었습니다." : "결재상신 되었습니다.";
    var sanctnInfoList = ncrFormEl.querySelector('input[name=sanctnInfoList]').value;
    sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];

    var param = ncrFormEl.toObject();
    param.sanctnKndCode = 'CM05000005'; // 결재종류 부적합품으로 고정
    param.sanctnInfoList = sanctnInfoList;
    param.gridData = AUIGrid.getGridData(ncrExpriemGrid);
    param.addedRow = AUIGrid.getAddedRowItems(ncrExpriemGrid);
    param.editedRow = AUIGrid.getEditedRowItems(ncrExpriemGrid);
    param.removedRow = AUIGrid.getRemovedItems(ncrExpriemGrid);

    // 결재상신시 sj, cn 데이터를 만들기위해 parameter 추가
    if (e.target.id === 'btnApprovalRequest') {
        param.chrgDeptCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=chrgDeptCode]'));
        param.chargerIdNm = getSeletedOptionText(ncrFormEl.querySelector('[name=chargerId]'));
        param.exmntDeptCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=exmntDeptCode]'));
        param.ocapSttusCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=ocapSttusCode]'));
        param.improptDgreeCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=improptDgreeCode]'));
        param.improptProcessStleCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=improptProcessStleCode]'));
        param.improptValidfmnmEvlCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=improptValidfmnmEvlCode]'));
        param.improptProcessResultCodeNm = getSeletedOptionText(ncrFormEl.querySelector('[name=improptProcessResultCode]'));
    }
    if (e.target.id === 'btnApprovalRequest') {
        if (!sanctnValid()){
            warn('결재자없이 결재상신을 할 수 없습니다.')
            return;
        }
    }

    customAjax({
        url: url,
        data: param,
        elementIds: ['btnTempSave','btnApprovalRequest']
    }).then(function (res, status) {
        if (status === 'success') {
            alert(successMsg);
            saveKey = res.ncrSeqno;
            reset();
            searchNcrM();
        }
    });
}

//삭제
function deleteNcr(){
    if(!$("#ncrSeqno").val()){
        alert("선택된 부적합품 정보가 없습니다.")
        return false;
    }

    var param = ncrFormEl.toObject();
    param.sanctnInfoList = [];

    if(confirm("${msg.C000000178}")) { //삭제하시겠습니까?
        customAjax({
            url: '/qa/deleteNcr.lims',
            data: param,
            elementIds: ['btn_delete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert('삭제 되었습니다.');
                reset();
                searchNcrM();
            }
        });
    }

}

function progrsControll(sanctnProgrsSittnCode){
    // 작성중, 반려가 아니면 버튼들 hide
    if (sanctnProgrsSittnCode !== 'CM01000001' && sanctnProgrsSittnCode !== 'CM01000004' && !!sanctnProgrsSittnCode) {
        dropZoneArea.getFiles(ncrFormEl.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
        dropZoneArea.readOnly(true);
        sanctnLineControll.notSelectedOptionDisable(true);
    } else {
        dropZoneArea.getFiles(ncrFormEl.querySelector('input[name=atchmnflSeqno]').value);
        dropZoneArea.readOnly(false);
        sanctnLineControll.notSelectedOptionDisable();
    }
    buttonHideAndShow(sanctnProgrsSittnCode);
}

function revertNcr(){
    var param = ncrFormEl.toObject();
    param.sanctnInfoList = [];
    customAjax({
        'url': "/qa/revertNcr.lims",
        data: param
    }).then(function (res, status) {
        if (status === 'success') {
            saveKey = res.ncrSeqno;
            alert('회수 되었습니다.');
            reset();
            searchNcrM();
        }
    });

}

function sanctnValid() {
    return !!ncrFormEl.querySelector('[name=sanctnerNm]').value
}
function buttonHideAndShow(sanctnProgrsSittnCode) {
    if(!!sanctnProgrsSittnCode) {
        visibleSupport.displayOfCode(sanctnProgrsSittnCode)
        if(sanctnProgrsSittnCode == 'CM01000005'){
            document.getElementById("btnTempSave").style.display = '';
            document.getElementById("btnExmnt").style.display = '';
            document.getElementById("btn_delete").style.display = '';
        }
    } else {
        visibleSupport.showAll();
        document.getElementById("btnRevert").style.display = "none";
        document.getElementById("btnExmnt").style.display = "none";
        document.getElementById("btn_delete").style.display = 'none';
    }
};
function init(){
    saveKey = '';
    AUIGrid.clearGridData(exprGrid);
    AUIGrid.clearGridData(ncrExpriemGrid);
    reset();
    progrsControll('init');
}

function reset() {
    pageReset(["frmNcr"], [exprGrid,ncrExpriemGrid,ncrAccordionGrid], [dropZoneArea]);
    progrsControll('');
    ncrFormEl.querySelector('[name=occrrncDte]').value = getYYMMDD(0,"DD");
    ncrFormEl.querySelector('[name=comptDte]').value = getYYMMDD(0,"DD");
    ncrFormEl.querySelector('[name=validfmnmEvlDte]').value = getYYMMDD(0,"DD");
}

// 체크 행 오른쪽 이동 버턴 클릭
function rightBtnClick() {
    // 왼쪽 그리드의 체크된 행들 얻기
    var rows = AUIGrid.getCheckedRowItemsAll(exprGrid);
    if (rows.length <= 0) {
        alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
        return false;
    }

    //중복 제거
    var existList = AUIGrid.getGridData(ncrExpriemGrid);
    for (var i = 0; i < existList.length; i++) {
        for (var j = 0; j < rows.length; j++) {
            if ((existList[i].reqestExpriemSeqno == rows[j].reqestExpriemSeqno) && (existList[i].exprOdr == rows[j].exprOdr)) {
                rows.splice(j, 1);
            }
        }
    }

    // 얻은 행을 오른쪽 그리드에 추가하기
    AUIGrid.addRow(ncrExpriemGrid, rows, "last");

    // 선택한 왼쪽 그리드 행들 삭제
    AUIGrid.removeCheckedRows(exprGrid);
};

// 체크 행 아래로 이동 버턴 클릭
function leftBtnClick() {
    // 상단 그리드의 체크된 행들 얻기
    var rows = AUIGrid.getCheckedRowItemsAll(ncrExpriemGrid);
    if (rows.length <= 0) {
        alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
        return;
    }

    for (var i = 0; i < rows.length; i++) {
        var stat = getItemState(rows[i], ncrExpriemGrid);
        if (stat == "Added") {
            var clickindex = AUIGrid.getRowIndexesByValue(exprGrid, "seqCount", rows[i]["seqCount"]);
            AUIGrid.restoreSoftRows(exprGrid, clickindex);
        }
    }

    AUIGrid.removeCheckedRows(ncrExpriemGrid);
    AUIGrid.restoreSoftRows(exprGrid, rows);
};

function saveAtEvent(e){
    if (e.target.id === 'btnTempSave') {
        $("[id=prductTyNm]").attr("required" , false);
        $("[id=chrgDeptCode]").attr("required" , false);
        $("[id=chargerId]").attr("required" , false);
        $("[id=improptCn]").attr("required" , false);
    } else {
        // required 속성 추가하기
        $("[id=mtrilNm]").attr("required" , true);
        $("[id=prductTyNm]").attr("required" , true);
        $("[id=chrgDeptCode]").attr("required" , true);
        $("[id=chargerId]").attr("required" , true);
        $("[id=improptCn]").attr("required" , true);
    }
}

function getQlityHistList(item){
    var param = {
        "tableNm" : "RS_NCR"
        , "seqno" : item.ncrSeqno
    }
    getGridDataParam('/com//getQlityDocHistList.lims', param, ncrAccordionGrid);
}

function doSearch(){
    searchNcrM();
    saveKey = '';
}

</script>
<!--  script 끝 -->
    </tiles:putAttribute>
</tiles:insertDefinition>
