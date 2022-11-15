<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
<tiles:putAttribute name="body">
    <!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>분석실목록</h2>
        <div class="btnWrap">
            <button id="btnSearch" class="search">조회</button>
        </div>
        <!-- Main content -->
        <form id="searchFrm" name="searchFrm" onsubmit="return false">
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
                    <col style="width:10%"/>
                    <col style="width:15%"/>
                </colgroup>
                <tr>
                    <th>분석실 명</th>
                    <td><input type="text" name="custlabNm" class="schClass"></td>
                    <th>제품구분</th>
                    <td>
                        <select name="prductSeCode"></select>
                    </td>
                    <th>제품 명</th> <!-- 제품 명  -->
                    <td><input type="text" name="mtrilNm" class="schClass"></td>
                    <th>사용여부</th> <!-- 사용여부 -->
                    <td style="text-align:left;">
                        <label><input type="radio" name="useAt" value="">${msg.C100000779}</label> <!-- 전체 -->
                        <label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                        <label><input type="radio" name="useAt" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
                    </td>
                </tr>
            </table>
        </form>
    </div>
    
    <div class="subCon2">
        <div id="custlabGrid"></div>
    </div>
    
    <div class="subCon1 mgT20">
        <h2><i class="fi-rr-apps"></i>분석실정보</h2>
        <div class="btnWrap">
            <button id="btnNew" class="btn4">신규</button> <!-- 신규 -->
            <button id="btnDelete" class="delete" style="display: none">삭제</button> <!-- 삭제 -->
            <button id="btnSave" class="save">저장</button>
        </div>
        
        <form id="saveForm" name="saveForm" onsubmit="return false">
            
            <input type="text" name="custlabSeqno" style="display: none">
            
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
                    <td><input type="text" name="custlabNm" maxlength="200" required></td>
                    
                    <th>분석실생성년도</th>
                    <td><input type="text" name="creatYear" maxlength="4" class="numChk"></td>
                    
                    <th>담당부서</th>
                    <td>
                        <select name="chrgDeptCode">
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>
                    
                    <th>${msg.C100000443}</th> <!-- 사용 여부 -->
                    <td>
                        <label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                        <label><input type="radio" name="useAt" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
                    </td>
                </tr>
                <tr>
                    <th class="necessary">관리책임자(정)</th>
                    <td>
                        <select name="manageRspnberJId" required>
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>
                    <th class="necessary">관리책임자(부)</th>
                    <td>
                        <select name="manageRspnberBId" required>
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>
                    
                    <th>분석실 운용여부</th>
                    <td>
                        <label><input type="radio" name="opratnAt" value="Y" checked>Y</label>
                        <label><input type="radio" name="opratnAt" value="N">N</label>
                    </td>
                    
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th>${msg.C100000425}</th>
                    <td colspan="7"><textarea name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength="4000"></textarea></td>
                </tr>
                <tr>
                    <th>분석실사진</th>
                    <td colspan="7">
                        <div id="dropZoneArea" style="text-align:left;"></div>
                        <input type="text" name="atchmnflSeqno" value="" style="display: none">
                        <input type="hidden" id="dropzoneBtnSave" value="사진첨부파일">
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <div style="display: flex;">
        <div class="wd45p mgT20">
            <div class="subCon1 mgT10">
                <h3>전체사용자</h3>
                <div class="btnWrap">
                    <button type="button" id="btnUserSearch" class="seacrh btn3">${msg.C100000767}</button> <!-- 조회 -->
                </div>
                <form action="javascript:;" id="userSearchFrm" name="userSearchFrm">
    
                    <input type="hidden" name="useAtSch" value="Y"/>
                    
                    <table class="subTable1" style="width:100%;">
                        <colgroup>
                            <col style="width: 20%"/>
                            <col style="width: 30%"/>
                            <col style="width: 20%"/>
                            <col style="width: 30%"/>
                        </colgroup>
                        <tr>
                            <th>${msg.C100000401}</th> <!-- 부서 명 -->
                            <td><select name="deptCodeSch" class="wd100p"></select></td>
                            <th>${msg.C100000452}</th> <!-- 사용자 명 -->
                            <td><input type="text" name="userNmSch" class="schClass"></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="subCon2">
                <div id="userGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>

        <div class="arrowWrap wd10p mgT40">
            <div>
                <button type="button" id="btnRight"><i class="fi-rr-angle-right"></i></button>
            </div>
            <div class="mgT20">
                <button type="button" id="btnLeft"><i class="fi-rr-angle-left"></i></button>
            </div>
        </div>

        <div class="wd45p mgT20">
            <div class="subCon1 mgT10">
                <h3>근무자</h3>
            </div>
            <div class="subCon2">
                <div id="workerGrid" class="grid" style="height: 360px;"></div>
            </div>
        </div>
    </div>
    
    <div class="subCon1 mgT15">
        <h3>관련제품</h3>
        <div class="btnWrap">
            <button id="searchMtril" class="btn5">제품찾기</button>
            <button id="deleteMtril" class="delete"><img src="${pageContext.request.contextPath}/assets/image/minusBtn.png"></button> <!-- 삭제 -->
        </div>
    </div>
    <div class="subCon2">
        <div id="productGrid"></div>
    </div>
    
    <div class="subCon1 mgT15">
        <h3>일상점검 관리항목</h3>
        <div class="btnWrap">
            <button id="searchExpr" class="btn5">시험항목찾기</button>
            <button id="deleteExpr" class="delete"><img src="${pageContext.request.contextPath}/assets/image/minusBtn.png"></button> <!-- 삭제 -->
            <button id="changeExprOrdr" class="btn5"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
        </div>
    </div>
    <div class="subCon2">
        <div id="dayExprGrid"></div>
    </div>
</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">

<script>
    var lang = ${ msg }; // 기본언어
    var jdgmntFomCodeList = getGridComboList("/com/getCmmnCode.lims", {"upperCmmnCode" : "IM06", "notInCode" : "IM06000002"}, true); // 판정형식;
    var mummValueSeCodeList = getGridComboList('/com/getCmmnCode.lims', {"upperCmmnCode" : "IM08"}, true);  // 최소단위;
    var mxmmValueSeCodeList = getGridComboList('/com/getCmmnCode.lims', {"upperCmmnCode" : "IM07"}, true); // 최대단위;
    var unitList = getGridComboList("/wrk/getMasterUnitList.lims",null , true);
        
    $(function () {
        init();
        setSelectBox();
        buildGrid();
        setButtonEvent();
        renderingDialog();
    });
    
    var custlabGrid = "#custlabGrid";
    var userGrid = "#userGrid";
    var workerGrid = "#workerGrid";
    var productGrid = "#productGrid";
    var dayExprGrid = "#dayExprGrid";
    var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#dropzoneBtnSave", lang : "${msg.C000000118}" } );
    var saveKey = "";
    var sessionObj = {
        bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}",
        deptCode : "${UserMVo.deptCode}"
    };
    
    function buildGrid() {
        var custlabCol = [];
        var userCol = [];
        var productCol = [];
        var dayExprCol = [];
        
        auigridCol(custlabCol);
        auigridCol(userCol);
        auigridCol(productCol);
        auigridCol(dayExprCol);
        
        custlabCol
                .addColumnCustom("custlabNm", "분석실 명")
                .addColumnCustom("mtrilNm", "분석 제품명")
                .addColumnCustom("chrgDeptNm", "담당 부서")
                .addColumnCustom("manageRspnberJungNm", "관리 책임자(정)")
                .addColumnCustom("manageRspnberBuNm", "관리 책임자(부)")
                .addColumnCustom("workersNm", "근무자")
                .addColumnCustom("opratnAt", "분석실 운용 여부")
                .addColumnCustom("creatYear", "분석실 생성 년도")
                .addColumnCustom("yearCnt", "분석실 년수")
                .addColumnCustom("rm", "비고");
        
        userCol
                .addColumnCustom("inspctInsttNm", "부서명")
                .addColumnCustom("userNm", "사용자 명");
        
        productCol
                .addColumnCustom("prductSeCodeNm", "제품구분")
                .addColumnCustom("mtrilNm", "제품명")
                .addColumnCustom("prductSeCode", "제품구분", null, false)
                .addColumnCustom("mtrilSeqno", "제품명", null, false);
        
        var headerTooltipPros = {
       		style : "my-require-style",
       		headerTooltip : {
       			show : true,
       			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
       		}
       	};
        
        dayExprCol
                .addColumnCustom("custlabChckExpriemSeqno", "custlabChckExpriemSeqno", null, false)
                .addColumnCustom("custlabSeqno", "custlabSeqno", null, false)
                .addColumnCustom("expriemNm", "${msg.C100000560}") // 시험항목명
                .addColumnCustom("unitSeqno", "${msg.C100000268}") // 단위
                .addColumnCustom("jdgmntFomCode", "${msg.C100000920}", null, true, true, headerTooltipPros) // 판정기준
                .addColumnCustom("textStdr", "${msg.C100000909}", null, true, true, headerTooltipPros) // 텍스트기준
                .addColumnCustom("mummValue", "${msg.C100000051}", null, true, true, headerTooltipPros) // LCL
                .addColumnCustom("mummValueSeCode", "${msg.C100000052}", null, true, true, headerTooltipPros) // LCL단위
                .addColumnCustom("mxmmValue", "${msg.C100000094}", null, true, true, headerTooltipPros) // UCL
                .addColumnCustom("mxmmValueSeCode", "${msg.C100000095}", null, true, true, headerTooltipPros) // UCL단위
                .addColumnCustom("sortOrdr", "${msg.C000000390}", null, false) // 정렬 순서
                .inputEditRenderer(["mummValue"], {onlyNumeric : true, allowPoint : true})
                .inputEditRenderer(["mxmmValue"], {onlyNumeric : true, allowPoint : true})
                .dropDownListRenderer(["unitSeqno"], unitList, true)
                .dropDownListRenderer(["jdgmntFomCode"], jdgmntFomCodeList, true)
                .dropDownListRenderer(["mummValueSeCode"], mummValueSeCodeList, true)
                .dropDownListRenderer(["mxmmValueSeCode"], mxmmValueSeCodeList, true);

        
        createAUIGrid(custlabCol, custlabGrid);
        createAUIGrid(userCol, userGrid);
        createAUIGrid(userCol, workerGrid);
        createAUIGrid(productCol, productGrid);
        createAUIGrid(dayExprCol, dayExprGrid, {
            //셀에서 바로 행이동 가능하도록. 미리선언 setProp으로 나중에 선언시 작동되지않아서
            enableDragByCellDrag : true,
            enableMultipleDrag : true,
            enableDrag : false,
            enableDrop : false,
            editable: true
        });
        
        bindGridEvent();
    }

    function bindGridEvent() {
        AUIGrid.bind(custlabGrid, "ready", function(event) {
            gridColResize(custlabGrid, "2");
            if ( !!saveKey ){
                gridSelectRow(custlabGrid, "custlabSeqno", [saveKey]);
            }
        });
        
        AUIGrid.bind(custlabGrid, "cellDoubleClick", function(event) {
            bindUserSelectbox(event.item.chrgDeptCode, function () {
                $('#btnDelete').show();
                detailAutoSet({targetFormArr : ["saveForm"], item : event.item});
                dropZoneArea.getFiles(document.querySelector('input[name=atchmnflSeqno]').value);
            });
            getUsers();
	        getCustlabWorkers(event.item.custlabSeqno);
            getCustlabProducts(event.item.custlabSeqno);
            getCustlabDayExpriems(event.item.custlabSeqno);
        });
        
        // 판정기준 '기준없음'인 행은 셀값 수정 방지
        AUIGrid.bind(dayExprGrid, "cellEditBegin", function(event) {
            if(event.item.jdgmntFomCode === "IM06000004" && event.dataField !== "jdgmntFomCode") {
                return false;
            }
        });	
       
        AUIGrid.bind(dayExprGrid, "cellEditEnd", function(event) {
            // 텍스트기준 -> UCL/LCL 데이터 초기화
            if(event.item.jdgmntFomCode === "IM06000003") {
                AUIGrid.updateRow(dayExprGrid,{mummValue:"",mummValueSeCode:"",mxmmValue:"",mxmmValueSeCode:""}, event.rowIndex);
            
            // 최대/최소 -> 텍스트 기준 초기화
            }else if(event.item.jdgmntFomCode === "IM06000001") {  
                AUIGrid.updateRow(dayExprGrid,{textStdr : ""},event.rowIndex);
            
            // 기준없음 -> 텍스트기준, 최대/최소값 초기화
            }else if(event.item.jdgmntFomCode === "IM06000004") {
                AUIGrid.updateRow(dayExprGrid,{textStdr:"",mummValue:"",mummValueSeCode:"",mxmmValue:"",mxmmValueSeCode:""}, event.rowIndex);
            }

            AUIGrid.update(dayExprGrid);
        });
        
        // drag and drop으로 순서 이동시
		AUIGrid.bind(dayExprGrid, "dropEnd", function(event) {
            //순서 update
            sortExpr();
		});
    }

    //버튼 클릭 이벤트 
    function setButtonEvent() {

        document.querySelector('#btnSearch').addEventListener('click', function (e) {
            getCustlab();
        });
        
        document.querySelector('#btnNew').addEventListener('click', function (e) {
            init();
        });
        
        document.querySelector('#btnSave').addEventListener('click', function (e) {
            atchmnflSave();
        });
        
        document.querySelector('#btnDelete').addEventListener('click', function (e) {
            custDelete();
        });
        
        document.querySelector('#btnUserSearch').addEventListener('click', function (e) {
            getUsers();
        });
        
        document.querySelector('#deleteMtril').addEventListener('click', function (e) {
            AUIGrid.removeRow(productGrid, "selectedIndex");
        });
        
        document.querySelector('#deleteExpr').addEventListener('click', function (e) {
            AUIGrid.removeRow(dayExprGrid, "selectedIndex");
        });
        
        // 화살표
        document.querySelector('.arrowWrap').addEventListener('click',function(e){
            var tagName = e.target.tagName;
            if(tagName === "DIV") return false;

            var target = e.target.id || e.target.className;
            ( target === "btnRight" || target === "fi-rr-angle-right" ) ? moveUser(userGrid, workerGrid, 'userId') : moveUser(workerGrid, userGrid, 'userId');
        });
        
        // 순서변경 event
        document.querySelector('#changeExprOrdr').addEventListener('click',function(e){

            var hasClass = this.classList.contains('sortEnable');
            if(hasClass){
                this.classList.remove("sortEnable");
                alert("순서변경 불가능상태 입니다.");
            }else{
                this.classList.add("sortEnable");
                alert("순서변경 가능상태 입니다.");
            }
            
            var dropEnable = !hasClass;
            AUIGrid.setProp(dayExprGrid, {
                enableDrag : dropEnable,
                enableMultipleDrag : dropEnable,
                enableDragByCellDrag : dropEnable,
                enableDrop : dropEnable,
                editable: dropEnable
            });
		});

        document.querySelector('select[name=chrgDeptCode]').addEventListener('change', function (e) {
            bindUserSelectbox(e.target.value);
        });
    }

    function renderingDialog(){
        dialogMtril('searchMtril', null, 'mtrilDialog', 'productGrid', function(items){

            var mtrilItems = items.map(function (item) {
                return {
                    mtrilSeqno: item.mtrilSeqno,
                    mtrilNm: item.mtrilNm,
                    prductSeCode: item.prductSeCode,
                    prductSeCodeNm: item.prductSeCodeNm
                };
            });
            
            AUIGrid.addRow(productGrid, mtrilItems, 'last');
        }, sessionObj);
        
        dialogAddExpriemList('searchExpr', {"inspctInsttCode" : "${UserMVo.bestInspctInsttCode}", pageNm : "EqpmnE"}, 'exprDialog', dayExprGrid, function(items){

            var size = AUIGrid.getGridData(dayExprGrid).length;
            
            var addItems = items.map(function (item, i) {
                return {
                    expriemSeqno: item.expriemSeqno,
                    expriemNm: item.expriemNm,
                    jdgmntFomCode: 'IM06000001',
                    mummValueSeCode: 'IM08000001',
                    mxmmValueSeCode: 'IM07000001',
                    sortOrdr : size + (i + 1)
                }
            });
            
            AUIGrid.addRow(dayExprGrid, addItems, 'last');
        });
    }

    function setSelectBox() {
        
        ajaxJsonComboTrgetName({
            url : '/com/getCmmnCode.lims',
            name : 'prductSeCode',
            queryParam : {"upperCmmnCode": "SY20"},
            selectFlag : true
        });
        
        ajaxJsonComboTrgetName({
            url : '/wrk/getDeptComboList.lims',
            name : 'chrgDeptCode',
            queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" },
            selectFlag : true
        });
        bindUserSelectbox('');
        
        ajaxJsonComboTrgetName({
            url : '/wrk/getDeptComboList.lims',
            name : 'deptCodeSch',
            queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" },
            selectFlag : true
        });
    }
    
    function bindUserSelectbox(deptCode, callback) {
        $.when(
            ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', name : 'manageRspnberJId', queryParam : { "deptCode": deptCode }, selectFlag : true})
            ,ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', name : 'manageRspnberBId', queryParam : { "deptCode": deptCode }, selectFlag : true})
        ).then(callback);
    }
    
    function init() {
        $('#btnDelete').hide();
        document.querySelector('#saveForm').reset();
        clearGrids([userGrid, workerGrid, productGrid, dayExprGrid]);
        dropZoneArea.clear();
    }
    
    function getCustlab(){
        getGridDataForm('/rsc/getCustlab.lims', 'searchFrm', custlabGrid);
    }

    function getCustlabWorkers(custlabSeqno) {
		getGridDataParam('/rsc/getCustlabWorkers.lims', {custlabSeqno : custlabSeqno}, workerGrid);
    }

    function getUsers() {
        getGridDataForm('/wrk/getUserMList.lims', 'userSearchFrm', userGrid);
    }
    function getCustlabProducts(custlabSeqno) {
        getGridDataParam('/rsc/getCustlabProducts.lims', {custlabSeqno : custlabSeqno}, productGrid);
    }
    function getCustlabDayExpriems(custlabSeqno) {
        getGridDataParam('/rsc/getCustlabDayExpriems.lims', {custlabSeqno : custlabSeqno}, dayExprGrid);
    }

    function custSave() {
        
        if (!saveValidation('saveForm')) return false;
        if (!dayExprGridRequire()) return false;
        
        var param = document.querySelector('#saveForm').toObject();
            param.workers = AUIGrid.getAddedRowItems(workerGrid);
            param.removedWorkers = AUIGrid.getRemovedItems(workerGrid);
            param.products = AUIGrid.getAddedRowItems(productGrid);
            param.removedProducts = AUIGrid.getRemovedItems(productGrid);
            param.dayExpriems = AUIGrid.getAddedRowItems(dayExprGrid).concat(AUIGrid.getEditedRowItems(dayExprGrid));
            param.removedDayExpriems = AUIGrid.getRemovedItems(dayExprGrid);

        customAjax({
            url: "/rsc/saveCustlab.lims",
            data: param,
            elementIds: ['btnSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert("저장 되었습니다.");
                saveKey = res.custlabSeqno;
                init();
                getCustlab();
            };
        });
    }

    function custDelete() {
        
        customAjax({
            url: "/rsc/deleteCustlab.lims",
            data: document.querySelector('#saveForm').toObject(),
            elementIds: ['btnSave', 'btnDelete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert("삭제 되었습니다.");
                saveKey = "";
                init();
                getCustlab();
            };
        });
    }
    
    // 첨부 파일 저장 함수
    function atchmnflSave() {
        var files = dropZoneArea.getNewFiles();
        var len = files.length;
        if (len > 0) {
            $("#dropzoneBtnSave").click();
            dropZoneArea.on("uploadComplete", function(event, fileIdx) {
                if (fileIdx === -1) {
                    err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
                } else {
                    document.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
                    custSave();
                }
            });
        } else { // 첨부파일이 없을 시
            custSave();
        }
    }

    //판정 기준에 따른 필수값 체크
    function dayExprGridRequire(){

        var bool = true;
        var gridData = AUIGrid.getGridData(dayExprGrid);
        var len = gridData.length;

        var rowIndex = 0;
        var msg = [];

        for(var i=0; i<len; i++){
            var item = gridData[i];

            msg = [];
            rowIndex = i;

            if(!!!item.jdgmntFomCode){
                msg.push("판정 기준");
                bool = false;
            }

            var jdgmntFomCode = item.jdgmntFomCode; // 판정 기준
            switch (jdgmntFomCode) {
                //최대 최소
                case "IM06000001":
                    var lclUnit =  item.mummValueSeCode; // lcl 단위
                    var uclUnit =  item.mxmmValueSeCode; // ucl 단위
                    var lclValue =  item.mummValue; // lcl
                    var uclValue =  item.mxmmValue; // ucl
                        
                    //lcl 단위, ucl 단위 둘다 없으면
                    if(!!!lclUnit || !!!uclUnit){
                        msg.push("LCL 단위 또는 UCL 단위");
                        bool = false;

                    }else if(!!!lclValue){
                        //최솟값 구분은 있으나 최솟값이 없으면
                        msg.push("LCL");
                        bool = false;

                    }else if(!!!uclValue){
                        //최솟값 구분은 있으나 최솟값이 없으면
                        msg.push("UCL");
                        bool = false;
                    }

                    // validation check 당했으면 행 표시
                    if (!bool) {
                        AUIGrid.setSelectionBlock(dayExprGrid,
                                rowIndex,
                                rowIndex,
                                AUIGrid.getColumnIndexByDataField(dayExprGrid, "mummValue"),
                                AUIGrid.getColumnIndexByDataField(dayExprGrid, "mxmmValueSeCode"));
                    }
                break;

                // 텍스트
                case "IM06000003":
                    if(!!!item.textStdr){
                        msg.push("텍스트 기준");
                        bool = false;
                    }
                    
                    // validation check 당했으면 행 표시
                    if (!bool) {
                        var colIndex = AUIGrid.getColumnIndexByDataField(dayExprGrid, "textStdr");
                        AUIGrid.setSelectionBlock(dayExprGrid, rowIndex, rowIndex, colIndex, colIndex);
                    }
                    break;
            }
            
            // for break
            if(!bool){
                break;
            }
        }

        if(!bool){
            alert(msg.toString() + "은(는) 필수 입력값 입니다.");
            scrollToExpr();
        }

        return bool;
    }
    
    //시험항목 그리드로 스크롤
    function scrollToExpr(){
        document.querySelector('#changeExprOrdr').focus()
    }
    
    function moveUser(gridId, targetGridId, idField){

        //선택한 행 객체들을 가져옵니다.
        var selectedItems = AUIGrid.getSelectedRows(gridId);
        if( selectedItems.length === 0 ){
            alert(lang.C100000497); //선택된 행이 없습니다.
            return false;
        }

        // id만 모아서
        var ids = selectedItems.map(function(element){
            return element[idField];
        });

        // target grid에서 row삭제
        var indexArr = AUIGrid.getRowIndexesByValue(gridId, idField, ids);
        AUIGrid.removeRow(gridId, indexArr); // 기존 그리드에서 행 삭제

        //중복제거 후 target grid로 row추가
        var result = arrayDropDuplicates({
            targetArr   : AUIGrid.getGridData(targetGridId)
            , testArr   : selectedItems
            , key       : idField
        });

        // user 그리드로 넘길때에는 중복체크 없이 삭제만.
        if( result.isDuplicated && !(targetGridId == userGrid) ) {
            warn(lang.C100000839); // 중복된 데이터는 추가되지 않습니다.
        }

        // 중복 제거된 array 이동할 그리드에 행 추가
        result.resultArray.forEach(function(el){
            AUIGrid.addRow(targetGridId, el, "last");
        });
    }
    
    //시험항목 그리드 순번 update
    function sortExpr(){
        var exprs =  AUIGrid.getGridData(dayExprGrid);
        var len = exprs.length;
        for(var i=0; i<len; i++){
            AUIGrid.updateRow(dayExprGrid,{sortOrdr:i+1},i);
        }
        AUIGrid.update(dayExprGrid);
    }
    
    //엔터키 이벤트
    function doSearch(e) {
        if (e.target.id === 'btnUserSearch' || e.target.name === 'userNmSch') {
            getUsers();
        }else {
            getCustlab();
            saveKey = '';
        }
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
