<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">감사 CAR 관리</tiles:putAttribute>
<tiles:putAttribute name="body">

<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>감사-CAR목록</h2>
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
                    <td><select name="auditSeCode"></select></td>

                    <th>감사구분상세</th>
                    <td><select name="auditDetailSeCode"></select></td>

                    <th>감사년도</th>
                    <td><input type="text" name="auditYear" class="schClass"></td>

                    <th>감사일자</th>
                    <td>
                        <input type="text" id="auditBeginDte" name="auditBeginDte" class="dateChk wd6p schClass" style="min-width:6em;"> 
                        ~ 
                        <input type="text" id="auditEndDte" name="auditEndDte" class="dateChk wd6p schClass" style="min-width:6em;">
                    </td>
                </tr>
                <tr>
                    <th>CAR 제목</th>
                    <td><input type="text" name="carSj" class="schClass"></td>

                    <th>CAR 부서</th>
                    <td><input type="text" name="chrgDeptNm" class="schClass"></td>

                    <th>CAR NO.</th>
                    <td><input type="text" name="carNo" class="schClass"></td>
                    
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>

    <div class="subCon2">
        <div id="carGrid" class="mgT15" style="height:300px;"></div>
    </div>
    <div class="mapkey">
        <label class="scarce">반려</label>
    </div>

    <form id="auditForm" onsubmit="return false;">
        <div class="subCon1 mgT15">
            <h2><i class="fi-rr-apps"></i>감사정보</h2>
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
                    <th>감사제목</th>
                    <td>
                        <input type="text" name="auditSj" class="wd63p" readonly>
                        <input type="text" name="auditSeqno" style="display: none" required>
                        <button type="button" id="auditSch" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="<c:url value="/assets/image/btnSearch.png"/>"></button>
                        <button type="button" id="auditReset" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="<c:url value="/assets/image/close14.png"/>"></button>
                    </td>

                    <th>감사구분</th> 
                    <td><input type="text" name="auditSeCodeNm" readonly></td>
                    
                    <th>감사년도</th>
                    <td><input type="text" name="auditYear" readonly></td>
                    
                    <th>감사대상부서</th>
                    <td><input type="text" name="auditTrgetDeptNm" readonly></td>
                </tr>
                <tr>
                    <th>감사시작일자</th>
                    <td><input type="text" name="auditBeginDte" readonly></td>

                    <th>감사종료일자</th>
                    <td><input type="text" name="auditEndDte" readonly></td>

                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="7">
                        <textarea name="rm" style="min-width:10em;" readonly></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td colspan="7">
                        <div id="auditDropZoneArea"></div>
                        <input type="text" id="auditAtchmnflSeqno" name="atchmnflSeqno" style="display: none;">
                    </td>
                </tr>
            </table>
        </div>
    </form>
    
    <form id="saveForm" onsubmit="return false;">
        
        <input type="text" name="auditCarSeqno" style="display: none">
        <input type="text" name="exmntSeqno" style="display: none">
        
        <div class="subCon1 mgT15">
            <h2><i class="fi-rr-apps"></i>CAR 정보</h2>
            <div class="btnWrap">
                <button type="button" id="btnNew" class="btn4" onclick="init()">신규</button> 
                <button type="button" id="btnDelete" class="delete" data-visible-code=["CM01000001","CM01000005"] style="display: none">삭제</button>
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"] style="display: none">회수</button>
                <button type="button" id="btnTempSave" class="save" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]>저장</button>
                
                <button type="button" id="btnExmnt" class="save" data-visible-code=["CM01000005"] style="display: none">검토</button>
                <input type="hidden" id="btnDialogExmnt" class="save" value="검토">
                
                <button type="button" id="btnApprovalRequest" class="save" data-visible-code=["CM01000001","CM01000004","init"]>결재상신</button> 
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
                    <th>CAR NO.</th>
                    <td><input type="text" name="carNo" readonly></td>

                    <th class="necessary">CAR 제목</th> 
                    <td><input type="text" name="carSj" required></td>
                    
                    <th class="necessary">CAR 부서</th>
                    <td><input type="text" name="chrgDeptNm" required></td>
                    
                    <th class="necessary">CAR 현황</th>
                    <td><select name="carSttuCode" required></select></td>
                </tr>
                <tr>
                    <th class="necessary">중요도</th>
                    <td><select name="carIpcrCode" required></select></td>

                    <th>5M1E</th>
                    <td><select name="m5e1Code"></select></td>
                    
                    <th>담당자</th>
                    <td><input type="text" name="chargerNm" ></td>
                    
                    <th>완료일자</th>
                    <td><input type="text" name="comptDte" class="dateChk"></td>
                </tr>
                <tr>
                    <th>효과검토일자</th>
                    <td><input type="text" name="effectExmntDte" class="dateChk"></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th>효과검토내용</th>
                    <td colspan="7">
                        <textarea name="effectExmntCn"></textarea>
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
    
    <div class="accordion_wrap mgT17">
        <div class="accordion ">CAR 이력</div>
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>CAR 이력</h3>
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
    var auditFormEl = document.querySelector('#auditForm');
    var saveFormEl = document.querySelector('#saveForm');
    var searchFormEl = document.querySelector('#searchForm');
    var saveKey = '';
    var carGrid = '#carGrid';
    var qualityDocHistoryGrid = '#qualityDocHistoryGrid';
    var auditDropZoneArea = DDFC.bind().EventHandler("auditDropZoneArea", {'readOnly': true, maxFiles: 20, lang: " " });
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
        saveFormReset();
        auditFormReset();
        progrsControll('init');
        AUIGrid.clearGridData(qualityDocHistoryGrid);
    }
    
    function saveFormReset(){
        saveFormEl.reset();
        dropZoneArea.clear();
        saveFormEl.querySelector('[name=comptDte]').value = getYYMMDD(0,"DD");
        saveFormEl.querySelector('[name=effectExmntDte]').value = getYYMMDD(0,"DD");
    }

    function auditFormReset() {
        auditFormEl.reset();
        auditDropZoneArea.clear();
    }

    function buildGrid(){
        
        var carCol = [];
        var qualityDocCol = [];
        auigridCol(qualityDocCol);
        auigridCol(carCol);
        
        carCol
                .addColumnCustom("auditSeCodeNm", "감사구분")
                .addColumnCustom("auditDetailSeCodeNm", "감사구분상세")
                .addColumnCustom("auditYear", "감사년도")
                .addColumnCustom("auditSj", "감사제목")
                .addColumnCustom("auditBeginDte", "감사시작일자")
                .addColumnCustom("auditEndDte", "감사종료일자")
                .addColumnCustom("auditTrgetDeptNm", "감사대상부서")
                .addColumnCustom("carNo", "CAR NO.")
                .addColumnCustom("carSj", "CAR 제목")
                .addColumnCustom("chrgDeptNm", "CAR 부서")
                .addColumnCustom("carSttuCodeNm", "CAR 현황")
                .addColumnCustom("carIpcrCodeNm", "중요도")
                .addColumnCustom("m5e1CodeNm", "5M1E")
                .addColumnCustom("chargerNm", "담당자")
                .addColumnCustom("comptDte", "완료일자")
                .addColumnCustom("effectExmntDte", "효과검토일자")
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
        createAUIGrid(carCol, carGrid, {
            rowStyleFunction: function (rowIndex, item) {
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "grid-scarce" : "";
            }
        });
        createAUIGrid(qualityDocCol, qualityDocHistoryGrid);
        gridBindEvent();
    }

    function gridBindEvent(){
        AUIGrid.bind(carGrid, "ready", function() {
            gridColResize(carGrid, "2");
            if ( !!saveKey ){
                gridSelectRow(carGrid, "auditCarSeqno", [saveKey]);
            }
        });
        
        AUIGrid.bind(carGrid, "cellDoubleClick", function(event) {
            getQualityDocList(event.item.auditCarSeqno)
            detailAutoSet({targetFormArr : [saveFormEl.id, auditFormEl.id], item : event.item});
            auditDropZoneArea.getFiles(auditFormEl.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
            progrsControll(event.item.sanctnProgrsSittnCode);
        });
    }

    function setSelectBox(){
        
        datePickerCalendar(["auditBeginDte", "auditEndDte"], true, ["YY",-1], ["DD",0]);
        datePickerCalendar(["comptDte"], true, ["DD",0]);
        datePickerCalendar(["effectExmntDte"], true, ["DD",0]);
        
        ajaxJsonComboTrgetName({
            url : '/qa/getDocSanctnLineCombo.lims',
            name : 'sanctnLineSeqno',
            queryParam : { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000007" },
            selectFlag : true
        });
        
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'auditSeCode', queryParam : { 'upperCmmnCode': 'RS13' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'auditDetailSeCode', queryParam : { 'upperCmmnCode': 'RS14' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'carSttuCode', queryParam : { 'upperCmmnCode': 'RS25' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'carIpcrCode', queryParam : { 'upperCmmnCode': 'RS26' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'm5e1Code', queryParam : { 'upperCmmnCode': 'RS27' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'carEffectfmnmCode', queryParam : { 'upperCmmnCode': 'RS28' }, selectFlag : true});
    }

    function getCarList(){
        getGridDataForm('/qa/getAuditCar.lims', searchFormEl.id, carGrid);
    }
    
    function getQualityDocList(auditCarSeqno){
        getGridDataParam('/com/getQlityDocHistList.lims', {seqno : auditCarSeqno, tableNm : "RS_AUDIT_CAR"}, qualityDocHistoryGrid);
    }

    function renderingDialog(){
        
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
        }, null, "CM05000007"); //결재종류 감사 car 


        dialogExmnt({
            btnId: 'btnDialogExmnt',
            functions: {
                getExmntSeqno : getExmntSeqno,
                getOtherKey : getOtherKey,
                init: function () {
                    init();
                    getCarList();
                }
            },
            dialogId: 'auditDialogExmnt',
            url: '/qa/auditCarManageSaveExmnt.lims'
        });
        
        dialogAuditManage({
            btnId : 'auditSch',
            dialogId : 'auditManageDialog',
            functions : {
                callback : function (item) {
                    detailAutoSet({item: item, targetFormArr: [auditFormEl.id]});
                    auditDropZoneArea.getFiles(item.atchmnflSeqno, null, 'N');
                } 
            }
        })
    }

    function setButtonEvent() {

        auditFormEl.querySelector('#auditReset').addEventListener('click', function () {
            auditFormEl.reset();
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
            var seqno = saveFormEl.querySelector('[name=auditCarSeqno]').value;
            if (!!seqno) {
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
    
    function auditCarSave(e){
        
        var url = e.target.id === "btnTempSave" ? "/qa/saveAuditCar.lims" : "/qa/auditCarApprovalRequest.lims";
        var successMsg = e.target.id === "btnTempSave" ? "저장 되었습니다." : "결재상신 되었습니다.";
        var sanctnInfoList = saveFormEl.querySelector('input[name=sanctnInfoList]').value;
            sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];

        var param = saveFormEl.toObject();
            param.auditSeqno = auditFormEl.querySelector('[name=auditSeqno]').value;
            param.sanctnKndCode = 'CM05000007'; // 결재종류 감사로 고정
            param.sanctnInfoList = sanctnInfoList;
            
        // 결재상신시 sj, cn 데이터를 만들기위해 parameter 추가
	    if (e.target.id === 'btnApprovalRequest') {
		    param.carSttuCodeNm = getSeletedOptionText(saveFormEl.querySelector('[name=carSttuCode]'));
		    param.carIpcrCodeNm = getSeletedOptionText(saveFormEl.querySelector('[name=carIpcrCode]'));
		    param.m5e1CodeNm = getSeletedOptionText(saveFormEl.querySelector('[name=m5e1Code]'));
	    }
        
        customAjax({
            url: url,
            data: param,
            elementIds: ['btnTempSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert(successMsg);
                init();
                saveKey = res.auditCarSeqno;
                getCarList();
            }
        });
    }
    
    function sanctnValid() {
        return !!saveFormEl.querySelector('[name=sanctnerNm]').value
    }

    // 첨부 파일 저장
    function atchmnflSave(e) {
        
        // 결재 상신시에만 필수값 체크
        if (e.target.id === 'btnApprovalRequest') {
            if(!saveValidation(auditFormEl.id)) return false;
            if(!saveValidation(saveFormEl.id)) return false;
            
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
                    auditCarSave(e);
                }
            });
        } else { // 첨부파일이 없을 시
            auditCarSave(e);
        }
    }

    function deleteAudit(){

        if (!confirm('삭제 하시겠습니까 ?')) {
            return;
        }

        var param = saveFormEl.toObject();
            param.sanctnInfoList = [];

        customAjax({
            url: '/qa/deleteAuditCar.lims',
            data: param,
            elementIds: ['btnTempSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert('삭제 되었습니다.');
                init();
                getCarList();
            }
        });
    }
    
    function revert() {
        
        var param = saveFormEl.toObject();
            param.sanctnInfoList = [];

        customAjax({
            url: '/qa/revertAuditCarManage.lims',
            data: param,
            elementIds: ['btnTempSave', 'btnDelete', 'btnApprovalRequest', 'btnRevert']
        }).then(function (res, status) {
            if (status === 'success') {
                saveKey = res.auditCarSeqno;
                alert('회수 되었습니다.');
                init();
                getCarList();
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
        return saveFormEl.querySelector('[name=auditCarSeqno]').value;
    }

    function doSearch(){
        getCarList();
        saveKey = '';
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
