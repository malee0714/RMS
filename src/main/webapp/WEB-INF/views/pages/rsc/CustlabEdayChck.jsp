<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
<tiles:putAttribute name="body">
    <!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>분석실 일상점검 목록</h2>
        <div class="btnWrap">
            <button id="btnSearch" class="search">조회</button>
        </div>
        <!-- Main content -->
        <form id="searchForm" name="searchForm" onsubmit="return false">
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
                    <th>분석실 명</th>
                    <td><select name="custlabSeqno"></select></td>
                    
                    <th>점검자</th>
                    <td><select id="insctrId" name="insctrId"></select></td>
                
                    <th>${msg.C100000785}</th>
                    <td style="text-align:left;" colspan="3">
                        <input type="text" id="startChckDte" name="startChckDte" class="dateChk wd6p schClass" style="min-width:6em;" required> 
                        ~ 
                        <input type="text" id="endChckDte" name="endChckDte" class="dateChk wd6p schClass" style="min-width:6em;" required>
                    </td>      
                </tr>
            </table>
        </form>
    </div>
    
    <div class="subCon2">
        <div id="custlabDayGrid"></div>
    </div>
    
    <div class="subCon1 mgT20">
        <h2><i class="fi-rr-apps"></i>분석실 일상점검 정보</h2>
        <div class="btnWrap">
            <button id="btnNew" class="btn4">신규</button> <!-- 신규 -->
            <button id="btnDelete" class="delete" style="display: none">삭제</button> <!-- 삭제 -->
            <button id="btnSave" class="save">저장</button>
        </div>
        
        <form id="saveForm" name="saveForm" onsubmit="return false">

            <input type="text" name="custlabEdayChckRegistSeqno" value='' style="display: none">

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
                    <th class="necessary">분석실 명</th>
                    <td><select name="custlabSeqno" required></select></td>
                    
                    <th>분석 제품</th>
                    <td><input type="text" name="mtrilNm" readonly></td>
                    
                    <th>관리 책임자 (정)</th>
                    <td><input type="text" name="manageRspnberJungNm" readonly></td>
                    
                    <th>관리 책임자 (부)</th>
                    <td><input type="text" name="manageRspnberBuNm" readonly></td>
                </tr>
                <tr>
                    <th class="necessary">점검자</th>
                    <td>
                        <input type="text" id="insctrNm" name="insctrNm" class="wd60p" value="${UserMVo.userNm}" readonly required>
                        <input type="text" name="insctrId" value="${UserMVo.userId}" style="display: none;">
                        <button type="button" id="btninsctrSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                        <button type="button" id="insctrReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 --> 
                    </td>
                    
                    <th class="necessary">점검일자</th>
                    <td><input type="text" id="chckDte" name="chckDte" class="dateChk" required></td>
                    
                    <th class="necessary">점검 항목 수</th>
                    <td><input type="text" name="exprCount" readonly required></td>
                    
                    <th class="necessary">점검 결과</th>
                    <td>
                        <input type="text" name="jdgmntWordCodeNm" readonly required>
                        <input type="text" name="jdgmntWordCode" readonly style="display: none" required>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100000425}</th>
                    <td colspan="7"><textarea name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength="4000"></textarea></td>
                </tr>
            </table>
        </form>
    </div>
    
    <div class="subCon2">
        <div id="dayExprGrid"></div>
    </div>
</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">
    
<style>
   .text-red {
        color: red;
    }
</style>

<script>
    var lang = ${msg}; // 기본언어
        
    $(function () {
        init();
        setSelectBox();
        buildGrid();
        setButtonEvent();
        renderingDialog();
    });
    
    var custlabDayGrid = "#custlabDayGrid";
    var dayExprGrid = "#dayExprGrid";
    var saveKey = "";
    var jdgmntWordCodeList = getGridComboList('/com/getCmmnCode.lims', {"upperCmmnCode" : "IM05"}, true);
    var custlabControll = new SelectBoxControll(document.querySelector('#saveForm').querySelector('select[name=custlabSeqno]'));
    function buildGrid() {
        var custlabCol = [];
        var dayExprCol = [];
        
        auigridCol(custlabCol);
        auigridCol(dayExprCol);
        
        custlabCol
                .addColumnCustom("custlabNm", "분석실 명")
                .addColumnCustom("mtrilNm", "분석 제품명")
                .addColumnCustom("manageRspnberJungNm", "관리 책임자(정)")
                .addColumnCustom("manageRspnberBuNm", "관리 책임자(부)")
                .addColumnCustom("insctrNm", "점검자")
                .addColumnCustom("chckDte", "점검일자")
                .addColumnCustom("jdgmntWordCodeNm", "점검 결과")
                .addColumnCustom("rm", "비고");
        
        // 부적합 판정 텍스트 색상 적용할 컬럼속성
        var colorPros = {
           styleFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
              if(value === "IM05000002") {
                 return "text-red";
              }
           }
        };
        
        // 판정구분이 최대/최소인 경우 적용할 컬럼속성
        var numericPros = {
           type : "InputEditRenderer",
           onlyNumeric : true, // 0~9 까지만 허용
           allowPoint : true, // 소수점 허용 여부 (onlyNumeric : true 선행)
           allowNegative : true // 음수값 허용 여부 (onlyNumeric : true 선행)
        };
        
        var cusPros = {
            editable : true, // 편집 가능 여부 (기본값 : false)
            selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
            enableCellMerge : true
        };
     
        // 특정 조건에 따라 미리 정의한 editRenderer 반환.
        var conditionPros = {
            dataField : "resultValue",
            editable : true,
            selectionMode : "multipleCells",
            enableCellMerge : true,
            style : "my-require-style",
            headerTooltip : {
                show : true,
                tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
            },
            editRenderer : {
                type : "ConditionRenderer", 
                conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {
                    // 판정형식이 최대/최소인 경우에 numericPros 반환
                    if(item.jdgmntFomCode === "IM06000001") {
                        return numericPros;
                    }else if(item.jdgmntFomCode === "IM06000001") {
                        return cusPros;
                    }
                }
            }
        };
        
        dayExprCol
                .addColumnCustom("expriemNm", "${msg.C100000560}") // 시험항목명
                .addColumnCustom("unitNm", "${msg.C100000268}") // 단위
                .addColumnCustom("jdgmntFomCodeNm", "${msg.C100000920}") // 판정기준
                .addColumnCustom("expriemSdspc", "기준규격")
                .addColumnCustom("resultValue", "결과값", null, true, true, conditionPros)
                .addColumnCustom("jdgmntWordCode", "판정", null, true, false, colorPros)
                .addColumnCustom("partclrMatter", "특이사항", null, true, true)
                .dropDownListRenderer(["jdgmntWordCode"], jdgmntWordCodeList, true);
                
        
        createAUIGrid(custlabCol, custlabDayGrid);
        createAUIGrid(dayExprCol, dayExprGrid);
        
        bindGridEvent();
    }

    function bindGridEvent() {
        AUIGrid.bind(custlabDayGrid, "ready", function(event) {
            gridColResize(custlabDayGrid, "2");
            if ( !!saveKey ){
                gridSelectRow(custlabDayGrid, "custlabEdayChckRegistSeqno", [saveKey]);
            }
        }); 
        
        AUIGrid.bind(custlabDayGrid, "cellDoubleClick", function(event) {
            $('#btnDelete').show();
            detailAutoSet({targetFormArr : ["saveForm"], item : event.item});
            getCustlabEdayCheckResultList(event.item.custlabEdayChckRegistSeqno);
            custlabControll.notSelectedOptionDisable(true);
        });
        
        // 판정결과 수정 방지
        AUIGrid.bind(dayExprGrid, "cellEditBegin", function(event) {
           if(event.dataField === "jdgmntWordCode") {
              return false;
           }
        });
     
        // 결과값에 따른 판정결과 도출 
        AUIGrid.bind(dayExprGrid, "cellEditEnd", function(event) {
            if(event.dataField === "resultValue") {
                chkSdspcValue(event.item, event.rowIndex, event.value);
                setPresentJdgmntWordCode();
            }
        });
    }

    //버튼 클릭 이벤트 
    function setButtonEvent() {
        
        // 점검자 초기화 button event
        document.querySelector('#insctrReset').addEventListener('click', function (e) {
            document.querySelector('#insctrNm').value = '';
            document.querySelector('#insctrId').value = '';
        });
        
        document.querySelector('#btnSearch').addEventListener('click', function (e) {
            getCustlabEdayCheckList();
        });
        
        document.querySelector('#btnNew').addEventListener('click', function (e) {
            init();
        });
        
        document.querySelector('#btnSave').addEventListener('click', function (e) {
            custlabEdayCheckRegist();
        });
        
        document.querySelector('#btnDelete').addEventListener('click', function (e) {
            custlabEdayCheckDelete();
        });

        document.querySelector('#saveForm')
                .querySelector('select[name=custlabSeqno]').addEventListener('change', function (e) {

            if (!!!e.target.value) {
                document.querySelector('#saveForm').reset();
                return false;
            }
            
            customAjax({
                url: '/rsc/getCustlab.lims'
                , data: {useAt: 'Y', custlabSeqno: e.target.value}
            }).then(function (list) {
                if (list.length > 0) {
                    getCustlabDayExpriems(list[0].custlabSeqno);
                    detailAutoSet({targetFormArr: ["saveForm"], item: list[0], ignoreElementArr: ["rm"]});
                } else {
                    warn('분석실 정보를 로드하지 못했습니다.');
                }
            });
        });
    }

    function renderingDialog(){
        dialogUser("btninsctrSearch", {bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}', authorSeCode : '${UserMVo.authorSeCode}'}, "insctrNmDialog", function(item) {
            var element = document.querySelector('#saveForm');
            element.querySelector('#insctrNm').value = item.userNm;
            element.querySelector('input[name=insctrId]').value = item.userId; 
        });
        
        // Calednar 생성
        datePickerCalendar(["startChckDte", "endChckDte"], true, ["MM",-1], ["DD",0]);
        datePickerCalendar(["chckDte"], false, ["DD",0]);
    }

    function setSelectBox() {
        ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'insctrId', null, true);
        ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
    }
    
    function init() {
        $('#btnDelete').hide();
        custlabControll.optionDisableClear();
        document.querySelector('#saveForm').reset();
        clearGrids([dayExprGrid]);
    }

    function getCustlabEdayCheckList() {
        getGridDataParam('/rsc/getCustlabEdayCheckList.lims', document.querySelector('#searchForm').toObject(), custlabDayGrid);
    }
    
    function getCustlabEdayCheckResultList(custlabEdayChckRegistSeqno) {
        getGridDataParam('/rsc/getCustlabEdayCheckResultList.lims', {custlabEdayChckRegistSeqno : custlabEdayChckRegistSeqno}, dayExprGrid);
    }
    
    function getCustlabDayExpriems(custlabSeqno) {
        getGridDataParam('/rsc/getCustlabDayExpriems.lims', {custlabSeqno : custlabSeqno}, dayExprGrid);
    }

    function custlabEdayCheckRegist() {
        
        if (!saveValidation('saveForm')) return false;
        
        var gridValid = AUIGrid.validateGridData(dayExprGrid, ["resultValue"], "결과값을 입력해 주세요.");
        if (!gridValid) return false;
        
        var param = document.querySelector('#saveForm').toObject();
            param.everyDayExprResultList = AUIGrid.getEditedRowItems(dayExprGrid)
        
        customAjax({
            url: "/rsc/saveEveryDayCheckRegist.lims",
            data: param,
            elementIds: ['btnSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert("저장 되었습니다.");
                saveKey = res.custlabEdayChckRegistSeqno;
                init();
                getCustlabEdayCheckList();
            };
        });
    }

    function custlabEdayCheckDelete() {
        
        customAjax({
            url: "/rsc/deleteEveryDayCheckRegist.lims",
            data: document.querySelector('#saveForm').toObject(),
            elementIds: ['btnSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert("삭제 되었습니다.");
                saveKey = "";
                init();
                getCustlabEdayCheckList();
            };
        });
    }
    
    // 결과값에 대해 기준규격으로 판정 함수 (event.item, event.rowIndex, event.value)
    function chkSdspcValue(rowItem, rowIndex, sResult) {
        var sResultValue = rowItem.resultValue; //입력 결과값
        var selJdgmntFomCode = rowItem.jdgmntFomCode; //판정구분
        var sMxmmValue = rowItem.mxmmValue; //UCL
        var sMxmmValueSeCode = rowItem.mxmmValueSeCode; //이하,민만
        var sMummValue = rowItem.mummValue; //LCL
        var sMummValueSeCode = rowItem.mummValueSeCode; //이상,초과
        var sTextStdr = rowItem.textStdr; //텍스트기준
        var sJdgCls;
    
        sMarkValue = sResult;

        if (!!!sMarkValue) {
            AUIGrid.setCellValue(dayExprGrid, rowIndex, "jdgmntWordCode", '');
            return false;
        }
    
       // 판정구분이 최대/최소인 경우
        if(selJdgmntFomCode == "IM06000001") {
    
            // 1. 최대값과 최소값 둘다 있는 경우
            if(!(sMxmmValue == "" || sMxmmValue == null) && !(sMummValue == "" || sMummValue == null)) { 
                
             // 1 - (1). 이상 / 이하
                if(sMummValueSeCode == "IM08000001" && sMxmmValueSeCode == "IM07000001") {   
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue) && parseFloat(sMarkValue) <= parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                
             // 1 - (2). 이상 / 미만
                }else if(sMummValueSeCode == "IM08000001" && sMxmmValueSeCode == "IM07000002") {
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue) && parseFloat(sMarkValue) < parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                
             // 1 - (3). 초과 / 이하	
                }else if(sMummValueSeCode == "IM08000002" && sMxmmValueSeCode == "IM07000001") {
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue) && parseFloat(sMarkValue) <= parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
    
                // 1 - (4). 초과 / 미만	
                }else if(sMummValueSeCode == "IM08000002" && sMxmmValueSeCode == "IM07000002") {
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue) && parseFloat(sMarkValue) < parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                }
    
            // 2. 최대값만 있는경우
            }else if(!(sMxmmValue == "" || sMxmmValue == null) && (sMummValue == "" || sMummValue == null)) {
                
             if(sMxmmValueSeCode == "IM07000001") { //이하
                    if(parseFloat(sMarkValue) <= parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                }else if(sMxmmValueSeCode == "IM07000002") { //미만
                    if(parseFloat(sMarkValue) < parseFloat(sMxmmValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                }
    
            // 3. 최소값만 있는경우
            }else if(!(sMummValue == "" || sMummValue == null) && (sMxmmValue == "" || sMxmmValue == null)) { 
                
             // 이상
             if(sMummValueSeCode == "IM08000001"){ 
                    if(parseFloat(sMarkValue) >= parseFloat(sMummValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
    
             // 초과
                }else if(sMummValueSeCode == "IM08000002"){ 
                    if(parseFloat(sMarkValue) > parseFloat(sMummValue)) {
                        sJdgCls = "IM05000001";
                    }else {
                        sJdgCls = "IM05000002";
                    }
                }
            }
    
       // 판정구분이 텍스트인 경우
       }else if(selJdgmntFomCode == "IM06000003") {	
    
            if(!(sTextStdr =="" || sTextStdr == null)) {
    
             // 기준규격값과 입력한 결과값이 같을 경우, 적합 판정
                if(sTextStdr.toUpperCase() == sMarkValue.toUpperCase()) {
                    sJdgCls = "IM05000001";
                }else {
                    sJdgCls = "IM05000002";
                }
            }
    
       // 판정구분이 기준없음인 경우
        }else if(selJdgmntFomCode == "IM06000004") {
            sJdgCls = "IM05000003";
        }
        
        // 판정값 set
        AUIGrid.setCellValue(dayExprGrid, rowIndex, "jdgmntWordCode", sJdgCls);
    } 

    // form에 점검 결과 set
    function setPresentJdgmntWordCode() {
        
        var list = AUIGrid.getGridData(dayExprGrid);
        var arrCode01 = list.filter(function (expr) {
            return expr.jdgmntWordCode === 'IM05000001';
        });
        var arrCode02 = list.filter(function (expr) {
            return expr.jdgmntWordCode === 'IM05000002';
        });
        var arrCode03 = list.filter(function (expr) {
            return expr.jdgmntWordCode === 'IM05000003';
        });

        /**
         * 우선순위에 따라 대표 판정 용어코드 set.
         * 
         * 우선순위 :   1. 부적합  IM05000002
         *             2. 확인함  IM05000003
         *             3. 적합    IM05000001
         */
        var presentJdgmntWordCode = ''; 
        if (arrCode02.length > 0) {
            presentJdgmntWordCode = 'IM05000002'
        }else if (arrCode01.length > 0 && arrCode03.length > 0) {
            presentJdgmntWordCode = 'IM05000003'
        }else if (arrCode01.length > 0) {
            presentJdgmntWordCode = 'IM05000001'
        }else if (arrCode03.length > 0) {
            presentJdgmntWordCode = 'IM05000003'
        }
        
        var presentJdgmntWordCodeNm = jdgmntWordCodeList.filter(function (code) {
            return code.value === presentJdgmntWordCode;
        }).map(function (code) {
            return code.key;
        });
        
        document.querySelector('#saveForm').querySelector('input[name=jdgmntWordCode]').value = presentJdgmntWordCode;
        document.querySelector('#saveForm').querySelector('input[name=jdgmntWordCodeNm]').value = presentJdgmntWordCodeNm.length > 0 ? presentJdgmntWordCodeNm[0] : '';
    }
    
    //엔터키 이벤트
    function doSearch(e) {
        getCustlabEdayCheckList();
        saveKey = '';
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
