<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">감사 관리</tiles:putAttribute>
<tiles:putAttribute name="body">

<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>감사목록</h2>
        <div class="btnWrap">
            <button type="button" id="btnSearch" class="search" onclick="doSearch()">조회</button>
        </div>

        <form id="searchForm" onsubmit="return false;">
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
                    <th>감사구분</th>
                    <td><select name="auditSeCode" class="wd100p"></select></td>

                    <th>감사구분상세</th>
                    <td><select name="auditDetailSeCode" class="wd100p"></select></td>

                    <th>감사년도</th>
                    <td><input type="text" name="auditYear" class="wd100p schClass"></td>

                    <th>감사일자</th>
                    <td>
                        <input type="text" name="auditBeginDte" class="dateChk wd6p schClass" style="min-width:6em;"> 
                        ~ 
                        <input type="text" name="auditEndDte" class="dateChk wd6p schClass" style="min-width:6em;">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="subCon2">
        <div id="auditGrid" class="mgT15" style="height:300px;"></div>
    </div>
    <div class="mapkey">
        <label class="scarce">반려</label><!-- 반려 -->
    </div>

    <form id="saveForm" onsubmit="return false;">

        <input type="text" name="auditSeqno" style="display: none"/>
        <input type="text" name="exmntSeqno" style="display: none"/>
        
        <div class="subCon1 mgT15">
            <h2><i class="fi-rr-apps"></i>감사정보</h2>
            <div class="btnWrap">
                <button type="button" id="btnNew" class="btn4" onclick="init()">신규</button> 
                <button type="button" id="btnDelete" class="delete" data-visible-code=["CM01000001","CM01000005"] style="display: none">삭제</button> 
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"] style="display: none">회수</button>
                <button type="button" id="btnTempSave" class="save" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]>저장</button> 
                <button type="button" id="btnExmnt" class="save" data-visible-code=["CM01000005"] style="display: none">검토</button>
                <button type="button" id="btnApprovalRequest" class="save" data-visible-code=["CM01000001","CM01000004","init"]>결재상신</button> 
                
                <input type="hidden" id="btnDialogExmnt" class="save" value="검토">
            </div>
            <table class="subTable1">
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
                    <th class="necessary">감사구분</th> 
                    <td><select name="auditSeCode" class="wd100p" required></select></td>

                    <th class="necessary">감사구분상세</th> 
                    <td><select name="auditDetailSeCode" class="wd100p" required></select></td>

                    <th class="necessary">감사일자</th>
                    <td><input type="text" name="auditDte" class="wd100p dateChk" required></td>

                    <th>감사번호</th>
                    <td><input type="text" name="auditNo" class="wd100p" readonly></td>
                </tr>
                <tr>
                    <th class="necessary">감사제목</th>
                    <td colspan="7"><input type="text" name="auditSj" class="wd100p" maxlength="1000" required></td>
                </tr>
                <tr>
                    <th>감사대상부서</th>
                    <td><input type="text" name="auditTrgetDeptNm" class="wd100p" maxlength="200"></td>

                    <th class="necessary">감사대상자</th>
                    <td><input type="text" name="auditTrgterNm" class="wd100p" required maxlength="200"></td>

                    <th>업체명</th>
                    <td>
                        <input type="text" name="entrpsNm" class="wd63p" readonly>
                        <input type="text" name="entrpsSeqno" style="display: none">
                        <button type="button" id="entrpsSch" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="<c:url value="/assets/image/btnSearch.png"/>"></button>
                        <button type="button" id="entrpsReset" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="<c:url value="/assets/image/close14.png"/>"></button>
                    </td>

                    <th>감사자</th>
                    <td><input type="text" name="auditmanNm" class="wd100p" maxlength="200"></td>
                </tr>
                <tr>
                    <th class="necessary">감사시작일자</th>
                    <td><input type="text" name="auditBeginDte" class="wd100p" required></td>

                    <th class="necessary">감사종료일자</th>
                    <td><input type="text" name="auditEndDte" class="wd100p" required></td>

                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="7">
                        <textarea name="rm" class="wd100p" style="min-width:10em;" maxlength="4000"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="7">
                        <div id="dropZoneArea"></div>
                        <input type="text" name="atchmnflSeqno" style="display: none;">
                        <input type="hidden" id="dropzoneBtnSave">
                    </td>
                </tr>
                <tr>
                    <th>결재정보</th>
                    <td colspan="3">
                        <select name="sanctnLineSeqno" style="width: 25%;"></select>
                        <input type="text" name="sanctnerNm" style="width: 51%;" readonly>
                        <input type="text" name="sanctnSeqno" style="display: none;">
                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","init"]>결재자변경</button>
                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["CM01000001","CM01000004","init"]><img src="<c:url value="/assets/image/close14.png"/>"></button>
                        
                        <input type="text" name="sanctnInfoList" style="display: none;">
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <div class="subCon1 mgT15">
        <h3>CAR 정보</h3>
    </div>
    <div class="subCon2">
        <div id="carGrid" class="mgT15" style="height:150px;"></div>
    </div>
    
    <div class="accordion_wrap mgT17">
        <div class="accordion ">감사 이력</div>
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>감사 이력</h3>
            <div class="subCon2">
                <div id="qualityDocHistoryGrid" style="height: 300px;"></div>
            </div>
        </div>
    </div>
</div>
    
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
    
    var AUIGrid = AUIGrid;
    var lang = ${msg}; // 기본언어
    var saveFormEl = document.querySelector('#saveForm');
    var searchFormEl = document.querySelector('#searchForm');
    var saveKey = '';
    var auditGrid = '#auditGrid';
    var carGrid = '#carGrid';
    var qualityDocHistoryGrid = '#qualityDocHistoryGrid';
    var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId: "#dropzoneBtnSave", maxFiles: 20, lang: "${msg.C100000867}" }); /* 첨부할 파일을 이 곳에 드래그하세요. */
    var visibleSupport = new VisibleSupport('data-visible-code');
    var sanctnLineControll = new SelectBoxControll(saveFormEl.querySelector('[name=sanctnLineSeqno]'));
    $(document).ready(function () {
        setSelectBox();
        buildGrid();
        renderingDialog();
        setButtonEvent();
    });

    function init(){
        saveKey = '';
        AUIGrid.clearGridData(carGrid);
        AUIGrid.clearGridData(qualityDocHistoryGrid);
        saveFormReset();
        progrsControll('init');
    }
    
    function saveFormReset(){
        saveFormEl.reset();
        dropZoneArea.clear();
        saveFormEl.querySelector('[name=auditDte]').value = getYYMMDD(0,"DD");
        saveFormEl.querySelector('[name=auditBeginDte]').value = getYYMMDD(-1,"MM");
        saveFormEl.querySelector('[name=auditEndDte]').value = getYYMMDD(0,"DD");
    }

    function buildGrid(){
        
        var auditCol = [];
        var carCol = [];
        var qualityDocCol = [];
        auigridCol(qualityDocCol);
        auigridCol(auditCol);
        auigridCol(carCol);
        
        auditCol
                .addColumnCustom("auditSeCodeNm", "감사구분")
                .addColumnCustom("auditDetailSeCodeNm", "감사구분상세")
                .addColumnCustom("auditDte", "감사일자")
                .addColumnCustom("auditNo", "감사번호")
                .addColumnCustom("auditSj", "감사제목")
                .addColumnCustom("auditBeginDte", "감사시작일자")
                .addColumnCustom("auditEndDte", "감사종료일자")
                .addColumnCustom("auditTrgetDeptNm", "감사대상부서")
                .addColumnCustom("auditTrgterNm", "감사대상자")
                .addColumnCustom("auditmanNm", "감사자")
                .addColumnCustom("entrpsNm", "업체명")
                .addColumnCustom("carCount", "CAR건수")
                .addColumnCustom("sanctnProgrsSittnCodeNm", "결재진행상태");

        carCol
                .addColumnCustom("carNo", "CAR NO.")
                .addColumnCustom("carSj", "CAR 제목")
                .addColumnCustom("chrgDeptNm", "CAR 부서")
                .addColumnCustom("carSttuCodeNm", "CAR 현황")
                .addColumnCustom("carIpcrCodeNm", "중요도")
                .addColumnCustom("m5e1CodeNm", "5M1E")
                .addColumnCustom("chargerNm", "담당자")
                .addColumnCustom("comptDte", "완료일")
                .addColumnCustom("effectExmntDte", "효과검토일")
                .addColumnCustom("effectExmntCn", "효과검토내용")
                .addColumnCustom("sanctnProgrsSittnCodeNm", "결재진행상태");
        
        qualityDocCol
                .addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)		// 품질문서이력 일렬번호
                .addColumnCustom('tableNm',lang.C100000973,'*',true,false)              // 테이블명
                .addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)            // 테이블 주석명
                .addColumnCustom('columnNm',lang.C100000975,'*',true,false)             // 컬럼명
                .addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)           // 컬럼 주석명
                .addColumnCustom('seqno','일련번호','*',false,false)						// 일련번호
                .addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)          // 변경 전
                .addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)        // 변경 후
                .addColumnCustom('changerNm',"최종변경자",'*',true,false)              	// 최종 변경자
                .addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false);          // 최종 변경 일시
        
        createAUIGrid(auditCol, auditGrid, {
            rowStyleFunction: function (rowIndex, item) {
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "grid-scarce" : "";
            }
        });
        createAUIGrid(carCol, carGrid);
        createAUIGrid(qualityDocCol, qualityDocHistoryGrid);

        gridBindEvent();
    }

    function gridBindEvent(){
        AUIGrid.bind(auditGrid, "ready", function() {
            gridColResize(auditGrid, "2");
            if ( !!saveKey ){
                gridSelectRow(auditGrid, "auditSeqno", [saveKey]);
            }
        });
        
        AUIGrid.bind(auditGrid, "cellDoubleClick", function(event) {

            detailAutoSet({targetFormArr : ["saveForm"], item : event.item});
	        getCarList(event.item.auditSeqno);
            getQualityDocList(event.item.auditSeqno);
            
            progrsControll(event.item.sanctnProgrsSittnCode);
        });
    }

    function setSelectBox(){
        
        datePickerCalendar(["auditBeginDte", "auditEndDte"], true, ["YY",-1], ["DD",0]);
        datePickerCalendar(["auditDte"], true, ["DD",0]);
        
        ajaxJsonComboTrgetName({
            url : '/qa/getDocSanctnLineCombo.lims',
            name : 'sanctnLineSeqno',
            queryParam : { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000002" },
            selectFlag : true
        });
        
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'auditSeCode', queryParam : { 'upperCmmnCode': 'RS13' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'auditDetailSeCode', queryParam : { 'upperCmmnCode': 'RS14' }, selectFlag : true});
    }

    function getAuditList(){
        getGridDataForm('/qa/getAudit.lims', searchFormEl.id, auditGrid);
    }

    function getCarList(auditSeqno){
        getGridDataParam('/qa/getAuditCar.lims', {auditSeqno : auditSeqno}, carGrid);
    }
    
    function getQualityDocList(auditSeqno){
        getGridDataParam('/com/getQlityDocHistList.lims', {seqno : auditSeqno, tableNm : "RS_AUDIT"}, qualityDocHistoryGrid);
    }

    function renderingDialog(){
        
        dialogEntrps("entrpsSch", "SY08000002", "entrpsDialog", function(data){
            saveFormEl.querySelector('input[name=entrpsNm]').value = data.entrpsNm; 
            saveFormEl.querySelector('input[name=entrpsSeqno]').value = data.entrpsSeqno; 
        }, null);
        
        // 결재 팝업
        dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {

            var list = res.gridData;
            if (list.length > 0) {
                var sanctnerNm = getSanctnerNm(list);
                saveFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
                saveFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }
        }, null, "CM05000002"); //결재종류 감사

        dialogExmnt({
            btnId: 'btnDialogExmnt',
            functions: {
                getExmntSeqno : getExmntSeqno,
                getOtherKey : getOtherKey,
                init : function() {
                    init();
                    getAuditList();
                }
            },
            dialogId: 'auditDialogExmnt',
            url: '/qa/auditManageSaveExmnt.lims'
        });
    }

    function setButtonEvent() {
        
        saveFormEl.querySelector('#entrpsReset').addEventListener('click', function () {
            saveFormEl.querySelector('[name=entrpsNm]').value = '';
            saveFormEl.querySelector('[name=entrpsSeqno]').value = '';
        });

        saveFormEl.querySelector('#sanctnReset').addEventListener('click', function () {
            saveFormEl.querySelector('[name=sanctnerNm]').value = '';
            saveFormEl.querySelector('[name=sanctnSeqno]').value = '';
        });
        
        saveFormEl.querySelector('[name=sanctnLineSeqno]').addEventListener('change', function (e) {
            customAjax({
                url: '/wrk/getSanctnerList.lims',
                data: {sanctnLineSeqno: e.target.value},
            }).then(function (res) {
                if (res.length > 0) {
                    var sanctnerNm = getSanctnerNm(res);
                    saveFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(res);
                    saveFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
                } else {
                    warn('선택된 결재자가 없습니다.');
                }
            });
        });

        saveFormEl.querySelector('#btnExmnt').addEventListener('click', function () {
            var auditSeqnoValue = saveFormEl.querySelector('[name=auditSeqno]').value;
            if (!!auditSeqnoValue) {
                saveFormEl.querySelector('#btnDialogExmnt').click();
            } else {
                warn('감사 정보 저장 후 검토할 수 있습니다.');
            }
        });

        saveFormEl.querySelector('#btnDelete').addEventListener('click', function () {
            deleteAudit();
        });
        
        saveFormEl.querySelector('#btnRevert').addEventListener('click', function (e) {
            revert();
        });
        
        saveFormEl.querySelector('#btnTempSave').addEventListener('click', function (e) {
            atchmnflSave(e);
        });
        
        saveFormEl.querySelector('#btnApprovalRequest').addEventListener('click', function (e) {
            atchmnflSave(e);
        });
    }
    
    function auditSave(e){

        var url = e.target.id === "btnTempSave" ? "/qa/saveAuditManage.lims" : "/qa/approvalRequestAuditManage.lims";
        var successMsg = e.target.id === "btnTempSave" ? "저장 되었습니다." : "결재상신 되었습니다.";
        
        var sanctnInfoList = saveFormEl.querySelector('input[name=sanctnInfoList]').value;
            sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];

        var param = saveFormEl.toObject();
            param.sanctnKndCode = 'CM05000002'; // 결재종류 감사로 고정
            param.sanctnInfoList = sanctnInfoList;

        // 결재상신시 sj, cn 데이터를 만들기위해 parameter 추가
	    if (e.target.id === 'btnApprovalRequest') {
		    param.auditSeCodeNm = getSeletedOptionText(saveFormEl.querySelector('[name=auditSeCode]'));
		    param.auditDetailSeCodeNm = getSeletedOptionText(saveFormEl.querySelector('[name=auditDetailSeCode]'));
	    }

        customAjax({
            url: url,
            data: param,
            elementIds: ['btnTempSave', 'btnDelete', 'btnApprovalRequest', 'btnRevert']
        }).then(function (res, status) {
            if (status === 'success') {
                alert(successMsg);
                init();
                saveKey = res.auditSeqno;
                getAuditList();
            }
        });
    }

    function sanctnValid() {
        return !!saveFormEl.querySelector('[name=sanctnerNm]').value
    }

    // 첨부 파일 저장
    function atchmnflSave(e) {

        var auditSeCode = saveFormEl.querySelector('[name=auditSeCode]');
        var auditDetailSeCode = saveFormEl.querySelector('[name=auditDetailSeCode]');
        var auditSj = saveFormEl.querySelector('[name=auditSj]');
        if (!!!auditSeCode.value) {
            warn("감사구분 (은)는 필수 입력 항목입니다.");
            return;
        }
        if (!!!auditDetailSeCode.value) {
            warn("감사구분상세 (은)는 필수 입력 항목입니다.");
            return;
        }
        if (!!!auditSj.value) {
            warn("감사제목 (은)는 필수 입력 항목입니다.");
            auditSj.focus();
            return;
        }

        // 결재 상신시에만 필수값 체크
        if (e.target.id === 'btnApprovalRequest') {
            if(!saveValidation(saveFormEl.id)) return;
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
                    saveFormEl.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
                    auditSave(e);
                }
            });
        } else { // 첨부파일이 없을 시
            auditSave(e);
        }
    }

    function deleteAudit(){
        
        if (!confirm('삭제 하시겠습니까 ?')) {
            return;
        }

        var param = saveFormEl.toObject();
            param.sanctnInfoList = [];

        customAjax({
            url: '/qa/deleteAuditManage.lims',
            data: param,
            elementIds: ['btnTempSave', 'btnDelete', 'btnApprovalRequest', 'btnRevert']
        }).then(function (res, status) {
            if (status === 'success') {
                alert('삭제 되었습니다.');
                init();
                getAuditList();
            }
        });
    }

    function revert() {
        
        var param = saveFormEl.toObject();
            param.sanctnInfoList = [];

        customAjax({
            url: '/qa/revertAuditManage.lims',
            data: param,
            elementIds: ['btnTempSave', 'btnDelete', 'btnApprovalRequest', 'btnRevert']
        }).then(function (res, status) {
            if (status === 'success') {
                saveKey = res.auditSeqno;
                alert('회수 되었습니다.');
                init();
                getAuditList();
            }
        });
    }

    function progrsControll(sanctnProgrsSittnCode){

        if (sanctnProgrsSittnCode === 'CM01000001' || sanctnProgrsSittnCode === 'CM01000004' || sanctnProgrsSittnCode === 'init') {
            // 작성중, 반려, 초기화
            dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControll.optionDisableClear();
            
        } else if (sanctnProgrsSittnCode === 'CM01000005') {
            //결재 완료
            dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControll.notSelectedOptionDisable(true);
            
        } else {
            // 결재 대기, 대기예정
            dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
            dropZoneArea.readOnly(true);
            sanctnLineControll.notSelectedOptionDisable(true);
        }

        visibleSupport.displayOfCode(sanctnProgrsSittnCode);
    }
    
    // dialog parameter function
    function getExmntSeqno() {
        return saveFormEl.querySelector('[name=exmntSeqno]').value;
    }
    
    // dialog parameter function
    function getOtherKey() {
        return saveFormEl.querySelector('[name=auditSeqno]').value;
    }

    function doSearch(){
        getAuditList();
        saveKey = '';
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
