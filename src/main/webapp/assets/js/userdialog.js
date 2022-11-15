function createDialog(width, height) {

    var heightText = "";

    if (!!!width) {
        width = 500;
    }

    var html = "<!-- 팝업 배경 시작 -->"
        + "<div class=\"popupBg\" id=\"popupBg_#dialogId#\"></div>"
        + "<!-- 팝업 배경 끝 -->"
        + "<!-- 팝업 세로는 자동지정이지만, 가로는 지정해준다.-->"
        + "<!-- 팝업 시작 -->"
        + "<section class=\"popup popup1\" id=\"popup_#dialogId#\" style=\"width:" + width + "px; " + heightText + " \"> "
        + "<img class=\"popupClose\" src=\"/assets/image/popupClose.png\"  id=\"popupClose_#dialogId#\" alt=\"\"> <!-- 팝업 X 끄기 -->"
        + "<!-- 팝업 내부 컨텐츠 시작 -->"
        + "<article class=\"ctsInnerArea\">"
        + "<div class=\"ctsInnerAreaTop\">"
        + "<div class=\"ctsInnerAreaTopLft\">"
        + "#flexbox#"
        + "<h2 class='addstyle'><i class='fi-rr-apps'></i>#title#</h2>"
        + "#sameline#"
        + "</div>"
        + "<div style=\"text-align:right;\">"
        + "#topright#"
        + "</div>"
        + "</div>"
        + "<div>"
        + "#body#"
        + "</div>"
        + "</article>"
        + "<!-- 팝업 내부 컨텐츠 끝 -->"
        + "</section>"
        + "<!-- 팝업 끝 -->";
    return html;
}

function loginCreateDialog() {

    var html = ""
        + "<div class=\"popupBg\" id=\"popupBg_#dialogId#\"></div>"
        + "<section class=\"popup popup1\" id=\"popup_#dialogId#\" style=\"width:650px;\">"
        + "<img class=\"popupClose\" src=\"/assets/image/popupClose.png\"  id=\"popupClose_#dialogId#\" alt=\"\">"
        + "<article class=\"ctsInnerArea\">"
        + "<div class=\"ctsInnerAreaTop\">"
        + "<span>"
        + "<img src='/assets/image/logo.png'>"
        + "</span>"
        + "<div class=\"ctsInnerAreaTopLft\" style=\"float:left;\">"
        + "<h2></h2>"
        + "</div>"
        + "<div  style=\"text-align:right; margin-top:10px;\">"
        + "#topright#"
        + "</div>"
        + "</div>"
        + "#body#"
        + "</article>"
        + "</section>";
    return html;
}

/**
 * @param openFunc 팝업창이 열린 후 실행되는 함수
 * @param preOpenFunc 팝업창이 열리기 전 실행되는 함수
 */
function popupInit(btnId, dialogId, openFunc, preOpenFunc) {
    //열기 버튼 클릭 이벤트
    $("#" + btnId).click(function () {


        if (preOpenFunc != undefined) {
            var check = preOpenFunc();
            if (check == false)
                return false;
        }

        $("#popupBg_" + dialogId + ", #popup_" + dialogId).fadeIn(500);
        $('#popup_' + dialogId + '').addClass("on");
        popupCenter(dialogId); // 첫 팝업 띄울때 center 정렬

        if (openFunc != undefined && openFunc != null)
            openFunc();

    });

    //닫기 버튼 클릭 이벤트
    //$("#popupClose_" + dialogId + ", #popupBg_" + dialogId).click(function() {
    $("#popupClose_" + dialogId).click(function () {
        $("#popup_" + dialogId).fadeOut(500).removeClass("on");
        $("#popupBg_" + dialogId).fadeOut(500);
    });

    $(window).resize(function () {
        popupCenter(dialogId);
    }); // 브라우저 창 사이즈 조절할 때도 항상 중앙 정렬
}

function popupCenter(dialogId) { // 팝업 center 정렬 함수
    $("#popup_" + dialogId).css({
        'left': ($(window).width() - $("#popup_" + dialogId).width()) / 2 + "px",
        'top': ($(window).height() - $("#popup_" + dialogId).height()) / 2 + "px"
    }); // 팝업 중앙 위치 계산 끝
} // 팝업 center 정렬 함수 끝

/**
 * 사용자 목록 팝업
 * @param btnId
 * @param data
 * @param dialogId
 * @param selectFunc
 * @param preOpenFunc
 * @param filterSet : object(화면에서 보여줘야 할 사용자 목록 그리드가 다를경우 세팅하기위함)
 * @param checkboxCode : 체크박스그리드 / 기본그리드 구분값
 * @param workPlaceGubun : 특정화면에서 사용할 사업장 선택박스
 */
function dialogUser(btnId, data, dialogId, selectFunc, preOpenFunc, filterSet, checkboxCode, workPlaceGubun) {

    var UserDialogColumnLayout = [];
    auigridCol(UserDialogColumnLayout);

    //특정화면에서 사용자목록 팝업에 보여줘야 할 컬럼이 더 있거나 줄여야 할 경우 분기처리하여 사용
    if (!!filterSet) {
        if (filterSet.loginId == 'Y')
            UserDialogColumnLayout.addColumn("loginId", lang.C100000298, null, true); /*로그인 ID*/
        else
            UserDialogColumnLayout.addColumn("loginId", lang.C100000298, null, false); /*로그인 ID*/
    }

    UserDialogColumnLayout.addColumn("userId", lang.C100000971, null, false); /*사용자ID*/
    UserDialogColumnLayout.addColumn("deptCode", lang.C000000749, null, false); /*부서 코드*/
    UserDialogColumnLayout.addColumn("inspctInsttNm", lang.C100000401, null, true); /*부서명*/
    UserDialogColumnLayout.addColumn("userNm", lang.C100000451, null, true); /*사용자*/
    UserDialogColumnLayout.addColumn("email", lang.C100000669, null, false); /*이메일*/

    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(700, 415);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000453); /*사용자 목록*/
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    var topright = "<span class=\"iArea mgR10\"></span>";
    if (workPlaceGubun == 'Y')
        topright += "<select id=\"bestInspctInsttCodePopSch\" name=\"bestInspctInsttCodePopSch\" style=\"margin-right:5px;\"></select>";
    topright += ""
        + "<input type=\"text\" id=\"inspctInsttNmSch\" name=\"inspctInsttNmSch\" class=\"searchClass\" placeholder=\"" + lang.C100000401 + "\">" /*부서명*/
        + "<input type=\"text\" id=\"userNmSch\" name=\"userNmSch\" class=\"searchClass\" placeholder=\"" + lang.C100000451 + "\">" /*사용자*/
        + "</span>"
        + "<div class=\"btnWrap\" style=\"margin-top:10px; position: inherit;\">"
        + "<button type=\"button\" id=\"btnUserAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /*추가*/
        + "<button type=\"button\" id=\"btnUserPopSearch\" class=\"btn1 search\">" + lang.C100000767 + "</button>" /*조회*/
        + "</div>";
    var body = ""
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.clearGridData(dialogGridID);
        AUIGrid.resize(dialogGridID);

        if (workPlaceGubun == 'Y') {
            ajaxJsonComboBox('/wrk/getBestComboList.lims', 'bestInspctInsttCodePopSch', null, null, null, data.bestInspctInsttCode); /* 사업장코드 */
            if (data.authorSeCode == 'SY09000001')
                $("#bestInspctInsttCodePopSch").prop("disabled", false);
            else
                $("#bestInspctInsttCodePopSch").prop("disabled", true);
        }

    }, preOpenFunc);

    //체크박스 구분값으로 그리드를 체크박스형태로 생성

    if (checkboxCode == 'Y') {
        var prop = { showRowCheckColumn: true, showRowAllCheckBox: true };
        dialogGridID = createAUIGrid(UserDialogColumnLayout, dialogGridID, prop);
    } else {
        var prop = { selectionMode: 'singleRow' };
        dialogGridID = createAUIGrid(UserDialogColumnLayout, dialogGridID, prop);
    }

    $("#popup_" + dialogId + " #btnUserPopSearch").click(function () {
        getUserList();
    });

    $("#popup_" + dialogId + " #btnUserAdd").click(function () {

        if (checkboxCode == 'Y') {

            var checkedRow = AUIGrid.getCheckedRowItems(dialogGridID);
            var array = new Array();
            var returnParam = {};
            var returnItem = {};

            returnParam.userId = e["item"]["userId"];
            returnParam.loginId = e["item"]["loginId"];
            returnParam.email = e["item"]["email"];
            returnParam.userNm = e["item"]["userNm"];
            returnParam.inspctInsttNm = e["item"]["inspctInsttNm"];
            returnItem.item = returnParam;
            array.push(returnItem);

            if (selectFunc != undefined && selectFunc != null)
                selectFunc(array);
            $("#popup_" + dialogId + " #inspctInsttNm").val('');
            $("#popupClose_" + dialogId).trigger("click");

        } else {

            var selectedRow = AUIGrid.getSelectedRows(dialogGridID);
            if (selectedRow.length > 0) {
                var gridItem = selectedRow[0];
                if (selectFunc != undefined && selectFunc != null)
                    selectFunc(gridItem);
                $("#popup_" + dialogId + " #inspctInsttNm").val('');

                $("#popupClose_" + dialogId).trigger("click");
            } else {
                alert(lang.C100000492); /*선택된 사용자가 없습니다.*/
            }

        }
    });

    //그리드 더블클릭으로 추가
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (e) {

        var gridItem = e.item;
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);
        $("#popup_" + dialogId + " #inspctInsttNm").val('');

        $("#popupClose_" + dialogId).trigger("click");
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    function getUserList() {

        var params = {
            bestInspctInsttCodeSch: $("#bplcCode").val(),
            inspctInsttNmSch: $("#popup_" + dialogId + " #inspctInsttNmSch").val(),
            userNmSch: $("#popup_" + dialogId + " #userNmSch").val()
        };

        if (!!data) {
            var gridData = AUIGrid.getGridData("#" + data.gridId);
            var array = new Array();

            for (var i = 0; i < gridData.length; i++) {
                array[i] = gridData[i]["userId"];
            }

            params.userIdList = array;
        }

        getGridDataParam("/com/getPopUpRqesterNmList.lims", params, dialogGridID);
    }

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13)
            getUserList();
    });
}

function dialogMtril(btnId, data, dialogId, gridId, selectFunc, sessionObj, partners, partners2, qaBplc) {

    var gridId = "#" + gridId;
    var productDialogColumnLayout = [];

    auigridCol(productDialogColumnLayout);
    productDialogColumnLayout.addColumn("deptNm", lang.C100000821, null, true);         /* 조직 명 */
    productDialogColumnLayout.addColumn("prductSeCodeNm", lang.C100000807, null, true); /* 제품 구분 */
    productDialogColumnLayout.addColumn("prductSeCode", lang.C100000807, null, false);  /* 제품 구분 */
    productDialogColumnLayout.addColumn("mtrilNm", lang.C100000717, null, true);        /* 자재 명 */
    productDialogColumnLayout.addColumn('mtrilCode', lang.C100000725, null, true);      /* 자재 코드 */
    productDialogColumnLayout.addColumn("disGubun", "disGubun", null, false);           /* disabled 상태 구분값 */

    var gridProperties = {
        showRowCheckColumn: true,
        independentAllCheckBox: true,
        // 엑스트라 행 체크박스의 비활성화(disabled) 여부 지정하는 함수
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            if (item.disGubun == 'disabled') { // 본 화면에 추가되어 있는 항목
                return false;
            }
            return true;
        }
    };

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000718); /*자재 목록*/
    var topright = "<span class=\"iArea\"></span>";
    var body = ''
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnPrductPopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnPrductPopSearch\" class=\"search\" >" + lang.C100000767 + "</button>" /*조회*/
        + "</div><br>"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C100000821 + "</th>" /*조직 명*/
        + "<td><select id=\"" + dialogId + "_deptCode\" name=\"deptCode\"></select></td>"
        + "<th>" + lang.C100000807 + "</th>" /*제품 구분*/
        + "<td colspan=\"5\"><select id=\"" + dialogId + "_prductSeCode\" name=\"prductSeCode\"></select></td>"
        + "</tr>"
        + "<tr>"
        + "<th>" + lang.C100000725 + "</th>" /*자재코드*/
        + "<td><input type=\"text\" id=\"" + dialogId + "_popMtrilCode\" class='searchClass' name=\"" + dialogId + "_popMtrilCode\"></td>"
        + "<th>" + lang.C100000717 + "</th>" /*자재명*/
        + "<td colspan=\"5\"><input type=\"text\" id=\"" + dialogId + "_popMtrilNm\" class='searchClass' name=\"popMtrilNm\"></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>"
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    });

    dialogGridID = createAUIGrid(productDialogColumnLayout, dialogGridID, gridProperties);

    ajaxJsonComboBox('/wrk/getDeptComboList.lims', dialogId + '_deptCode', {'bestInspctInsttCode' : sessionObj.bestInspctInsttCode}, false, lang.C100000480, sessionObj.deptCode);
    ajaxJsonComboBox('/com/getCmmnCode.lims', dialogId + '_prductSeCode', {'upperCmmnCode': 'SY20'}, false, lang.C100000480);

    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        var condition = $('#inspctTyCode').val() == "SY07000005" || $('#inspctTyCode').val() == "SY07000006" ? true : false;
        if (data == 'RequestM' && condition) {
            $('#'+dialogId + '_prductSeCode').val('SY20000005');
            $('#'+dialogId + '_prductSeCode').not(':selected').prop('disabled', true);
        } else {
            $('#'+dialogId + '_prductSeCode').val('');
            $('#'+dialogId + '_prductSeCode').not(':selected').prop('disabled', false);
        }
        gridColResize(dialogGridID, '2');
    });

    // 더블클릭한 row는 바로 추가해줌
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            selectFunc(arr);

            $('#' + dialogId + '_popMtrilNm').val('');
            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 전체 체크박스 클릭 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        // 비활성화가 안된 체크박스에 한해 전체 체크/해제
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        }

        if (data == 'RequestM' || data == 'CoaFormM')
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
    });

    if (data == 'RequestM' || data == 'CoaFormM') {
        AUIGrid.bind(dialogGridID, "rowCheckClick", function (event) {
            AUIGrid.setCheckedRowsByValue(dialogGridID, 'mtrilSeqno', event.item.mtrilSeqno);
        });
    }
    
    // 추가버튼 클릭 이벤트
    $('#' + dialogId + '_btnPrductPopAdd').click(function () {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000720);  /* 자재 선택 후 추가가 가능합니다. */
            return false;
        }

        // 체크된 row의 데이터를 본 화면에 보여줌
        selectFunc(checkedItems);
        $("#popupClose_" + dialogId).trigger("click");
    });

    // 조회버튼 클릭 이벤트
    $('#' + dialogId + '_btnPrductPopSearch').click(function () {
        getPrductPopList();
    });

    function getPrductPopList() {

        var popupPrduParams = {
            deptCode: $('#' + dialogId + '_deptCode').val(),
            mtrilNm: $('#' + dialogId + '_popMtrilNm').val(),
            mtrilTyCode: $('#' + dialogId + '_prductSeCode option:selected').val(),
            mtrilCode: $('#' + dialogId + '_popMtrilCode').val()
        };

        customAjax({
            url: "/wrk/getMtrilPopList.lims",
            data: popupPrduParams,
            successFunc: function(list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].mtrilSeqno == masterGridData[j].mtrilSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    $('.searchClass').keypress(function (e) {
        if (e.which == 13)
            getPrductPopList();
    });
}

function dialogEqpmn(btnId, dialogId, selectFunc) {

    var productDialogColumnLayout = [];
    auigridCol(productDialogColumnLayout);
    productDialogColumnLayout.addColumn("eqpmnSeqno", "장비 일련번호", null, false);
    productDialogColumnLayout.addColumn("eqpmnClNm", "장비 분류", null, true);
    productDialogColumnLayout.addColumn("custlabNm", "분석실", null, true);
    productDialogColumnLayout.addColumn("chrgDeptNm", "관리 부서", null, true);
    productDialogColumnLayout.addColumn("eqpmnManageNo", "관리 번호", null, true);
    productDialogColumnLayout.addColumn("eqpmnNm", "장비 명", null, true);

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "장비 목록");
    var topright = "<span class=\"iArea\"></span>";
    var body = ''
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnSchEqpmnOnPop\" class=\"search\" >" + lang.C100000767 + "</button>" /* 조회 */
        + "</div><br>"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + "장비 분류" + "</th>" /* 장비 분류 */
        + "<td><select id=\"" + dialogId + "_schEqpmnClOnPop\" name=\"schEqpmnClOnPop\"></select></td>"
        + "<th>" + "분석실" + "</th>" /* 분석실 */
        + "<td><select id=\"" + dialogId + "_schCustlabOnPop\" name=\"schCustlabOnPop\"></select></td>"
        + "<th>" + "장비 명" + "</th>" /* 장비 명 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schEqpmnNmOnPop\" class='searchClass' name=\"schEqpmnNmOnPop\"></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>"
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function() {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
    });

    dialogGridID = createAUIGrid(productDialogColumnLayout, dialogGridID);

    ajaxJsonComboBox("/com/getCmmnCode.lims", dialogId + "_schEqpmnClOnPop", { upperCmmnCode : "RS02" }, true);
    ajaxJsonComboBox("/com/getCustLabCombo.lims", dialogId + "_schCustlabOnPop", null, true);

    AUIGrid.bind(dialogGridID, 'ready', function(event) {
        gridColResize(dialogGridID, '2');
    });

    AUIGrid.bind(dialogGridID, 'cellDoubleClick', function(event) {
        var gridItem = event.item;
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);

        $("#" + dialogId + "_schEqpmnNmOnPop").val("");
        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#" + dialogId + "_btnSchEqpmnOnPop").click(function() {
        getEqpmnListOnPop();
    });

    function getEqpmnListOnPop() {
        var param = {
            schEqpmnClCode: $("#" + dialogId + "_schEqpmnClOnPop option:selected").val(),
            schCustlabSeqno: $("#" + dialogId + "_schCustlabOnPop option:selected").val(),
            schEqpmnNm: $("#" + dialogId + "_schEqpmnNmOnPop").val()
        };

        getGridDataParam("/rsc/getEqpmnListOnPop.lims", param, dialogGridID);
    }

    $('.searchClass').keypress(function(e) {
        if (e.which == 13)
            getEqpmnListOnPop();
    });
}

/**
 * 자재 분류 팝업2 (고객사 규격관리에서 사용)
 */
function dialogProductPop2(btnId, data, dialogId, selectFunc, bplcCtrlVal) {

    var productDialogColumnLayout = [];
    auigridCol(productDialogColumnLayout);
    productDialogColumnLayout.addColumn('bplcCode', '', null, false);				//사업장코드
    productDialogColumnLayout.addColumn('mtrilSeqno', '', null, false);				//자재 일련번호
    productDialogColumnLayout.addColumn('prductSeCode', '', null, false);    			//자재 유형 
    productDialogColumnLayout.addColumn('prductSeCodeNm', "제품 구분", null, true); 	//자재 유형 명
    productDialogColumnLayout.addColumn('mtrilNm', lang.C000000228, null, true);	//자재명
    productDialogColumnLayout.addColumn('mtrilCode', lang.C000000214, null, true);	//자재코드
    productDialogColumnLayout.addColumn('bplcCode', '사업장', null, false);			//사업장
    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C100000718); /* 자재 목록 */
    var topright = "";

    var body = ''
        + "<div class=\"subContent\" style=\"padding: 30px 0px;\">"
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"" + dialogId + "btnPrductPopSelected\" class=\"btn5\" >" + lang.C000000079 + "</button>" /*선택*/
        + "<button type=\"button\" id=\"" + dialogId + "_btnPrductPopSearch\" class=\"search\" >" + lang.C000000002 + "</button>" /*조회*/
        + "</div>"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C000001722 + "</th>" /*자재 유형*/
        + "<td><select id=\"" + dialogId + "_prductSeCode\" name=\"prductSeCode\"></select></td>"
        + "<th>" + lang.C000000214 + "</th>" /*자재코드*/
        + "<td><input type=\"text\" id=\"" + dialogId + "_popMtrilCode\" class='searchClass' name=\"" + dialogId + "_popMtrilCode\"></td>"
        + "<th>" + lang.C000000228 + "</th>" /*자재명*/
        + "<td><input type=\"text\" id=\"" + dialogId + "_popMtrilNm\" class='searchClass' name=\"popMtrilNm\"></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
        if (bplcCtrlVal && data.authorSeCode == 'SY09000001') {
            $('#' + dialogId + '_popBestInspctInsttCode').prop('disabled', false);
        } else {
            $('#' + dialogId + '_popBestInspctInsttCode').prop('disabled', true);
        }
    });

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getPrductPopList();
        }
    });

    var dialogCusPros = {
        editable: false, // 편집 가능 여부 (기본값 : false)
        selectionMode: "multipleCells",// 셀 선택모드 (기본값: singleCell)
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
    }

    dialogGridID = createAUIGrid(productDialogColumnLayout, dialogGridID, dialogCusPros);

    //자재 유형 콤보박스
    ajaxJsonComboBox('/com/getCmmnCode.lims', dialogId + '_prductSeCode', { 'upperCmmnCode': 'SY20' }, false, lang.C000000079); /*선택*/
    //시스템권한 아닐 경우 사업장 사용불가
    if ('SY09000001' == data.authorSeCode)
        $('[name=popBestInspctInsttCode]:not(:selected)').prop('disabled', true);

    function getPrductPopList() {

        var gridData = AUIGrid.getGridData("#" + data.girdId);
        var gridDataArray = [];

        for (var i = 0; i < gridData.length; i++) {
            gridDataArray[i] = gridData[i]["mtrilSeqno"];
        }
        var popupPrduParams = {
            mtrilNm: $('#' + dialogId + '_popMtrilNm').val(),
            prductSeCode: $('#' + dialogId + '_prductSeCode option:selected').val(),
            mtrilCode: $('#' + dialogId + '_popMtrilCode').val(),
            mmnySeCode: $('[name="popMmnySeCode"]:checked').val(),
            shrMtrilSdspcArray: gridDataArray
        }
        getGridDataParam("/wrk/getProductPopList.lims", popupPrduParams, dialogGridID);
    }

    //조회
    $('#' + dialogId + '_btnPrductPopSearch').click(function () {
        getPrductPopList();
    });

    //선택
    $('#' + dialogId + 'btnPrductPopSelected').click(function () {
        var gridItem = AUIGrid.getCheckedRowItemsAll(dialogGridID);

        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);
        $("#popup_" + dialogId + " #prductNm").val('');
        $("#popupClose_" + dialogId).trigger("click");
    });

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        var item = event.item, rowIdField, rowId;

        rowIdField = AUIGrid.getProp(event.pid, "rowIdField"); // rowIdField 얻기
        rowId = item[rowIdField];

        if (!AUIGrid.isCheckedRowById(event.pid, rowId)) {
            AUIGrid.addCheckedRowsByIds(event.pid, rowId);
        } else {
            AUIGrid.addUncheckedRowsByIds(event.pid, rowId);
        }
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });
}

/**
 * 출고, 폐기 페이지 제품등록 팝업
 */
function dialogRelease(btnId, data, dialogId, gridId, selectFunc) {
    var releaseDialogColumnLayout = [];
    var releaseDialogDetailColumnLayout = [];
    var nowWrhsdlvrQy;
    var invalidConunt = 0;
    var dialogGridID = "grid_" + dialogId;
    var dialogGridIDDetail = "grid_" + dialogId + "Detail";
    var checkEventProps = {
        // 엑스트라체크박스 표시
        showRowCheckColumn: true,

        // 전체 체크박스 표시 설정
        independentAllCheckBox: true,

        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지
            // 마스터
            // 그리드
            var nowDt = currentDate();

            for (var i = 0; i < getMasterGridData.length; i++) {
                // 1. 페이지 마스터 그리드의 바코드와 같은게 선택되었다면 선택 x
                if (item.brcd == getMasterGridData[i].brcd && item.bplcCode == getMasterGridData[i].bplcCode) {
                    return false; // false 반환하면 disabled 처리됨

                }
            }
            // 폐기페이지는 선택o
            if (gridId === "releaseMGrid") {
                // 2. 유효기한 지난 바코드 선택 x
                if (item.validTmlmtTrgetAt == 'N') {
                    return true
                }
                else if (nowDt > item.validDte) {
                    return false
                }
                else {
                    return true;
                }
            } else {
                return true;
            }
        }
    };
    var validProp ={
        styleFunction: function (rowIndex, columnIndex, value, headerText, item, dataField) {
            //판정코드가 부적합이면 적색으로 표시
            if(gridId === "releaseMGrid") {
                if (dataField == "validDte") {
                    if (item["validTmlmtTrgetAt"] == 'N')
                        return null;
                    if (item["validTmlmtMthdCode"] == "RS15000002" && item["validDte"] == null)
                        return null;
                    if (new Date(item["validDte"]) - new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate()) < 30 * 24 * 60 * 60 * 1000)
                        return "grid-red";
                }
            }
            //return null;
        }
    }

    var html = createDialog(960);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C100001159);
    var topright =
        "<div class=\"btnWrap\" style=\"top:10px !important; position: inherit;\">"
        + "<button type=\"button\" id=\"btnReleasePopSelect\" class=\"btn5\">" + lang.C100000880 + "</button>"
        + "<button type=\"button\" id=\"btnReleasePopSearch\" class=\"search\">" + lang.C100000767 + "</button>"
        + "</div>"
        + "<div class=\"subContent\" style=\"padding : 0;\">"
        + "<div class=\"subCon1\" style=\"margin-top: 10px;\">"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:23%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:23%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:23%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>분석실 명 </th>" /*분석실 명*/
        + "<td><select id=\"" + dialogId + "custlabSeqno\" name=\"custlabSeqno\" class=\"searchClass\" placeholder=\"분석실명\"> </select></td>"
        + "<input type='hidden' id=\"" + dialogId + "bplcCodeSch\" name=\"bplcCodeSch\" class=\"searchClass\" value='1000' >"
        + "<th>" + lang.C100000811 + "</th>" /*분류*/
        + "<td><select id=\"" + dialogId + "prductClCodesch\" name=\"" + dialogId + "prductClCodesch\" class=\"searchClass\" placeholder=\"제품 분류명\"> </select></td>"
        + "<th>" + lang.C100000809 + "</th>" /*품명*/
        + "<td><input type=\"text\" id=\"" + dialogId + "prductNmSch\" name=\"" + dialogId + "prductNmSch\" class=\"searchClass\" placeholder=\"제품명\"></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:200px; margin:0 auto;'>"
        + "</div>"
        + "</div>"
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridIDDetail + "' style='width:100%; height:200px; margin:0 auto;'>"
        + "</div>"
        + "</div>"
        + "</div>";
    var body = "<div class='mgT15'>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);
    ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
    ajaxJsonComboBox('/com/getCmmnCode.lims', dialogId + 'prductClCodesch', { "upperCmmnCode": "RS01" }, true); /*선택*/
    //		ajaxJsonComboBox("/com/getDeptCombo.lims", dialogId+"bplcCodeSch",{ "bestInspctInsttAt" : "Y"}, true).then(function(){

    //			$('#'+dialogId+'bplcCodeSch option').not(':selected').prop('disabled', ( $("#userAuthorDiv #layoutUserAuthorSeCode").val() != "SY09000001" ));
    //		});

    popupInit(btnId, dialogId, function () {
        $("#" + dialogId + "bplcCodeSch").val($("#userAuthorDiv #layoutUserBplcCode").val());
        AUIGrid.resize(dialogGridID);
        AUIGrid.resize(dialogGridIDDetail);
        AUIGrid.clearGridData(dialogGridIDDetail);
        AUIGrid.setAllCheckedRows(dialogGridIDDetail, false);
    });
    auigridCol(releaseDialogColumnLayout);
    releaseDialogColumnLayout.addColumnCustom("prductSeqno", lang.C100000812, null, false, false);// 제품 일련번호
    releaseDialogColumnLayout.addColumnCustom("bplcCode", lang.C100000435, null, false, false);	//사업장명
    releaseDialogColumnLayout.addColumnCustom("bplcCodeNm", lang.C100000435, null, false, false); // 사업장 명
    releaseDialogColumnLayout.addColumnCustom("custlabSeqno", lang.C100000435, null, false, false); // 사업장 명
    releaseDialogColumnLayout.addColumnCustom("custlabNm","분석실 명", null, true, false); // 사업장 명
    releaseDialogColumnLayout.addColumnCustom("prductClCodeNm", lang.C100000811, null, true, false);// 분류
    releaseDialogColumnLayout.addColumnCustom("prductClCode", lang.C100000811, null, false, false); // 분류
    releaseDialogColumnLayout.addColumnCustom("prductNm", "품명", null, true, false);   // 품명
    releaseDialogColumnLayout.addColumnCustom("prductPrpos", lang.C100000621, null, true, false);   //용도
    releaseDialogColumnLayout.addColumnCustom("proprtInvntryQy", "적정 재고량", null, true, false);   // 품명
    releaseDialogColumnLayout.addColumnCustom("nowInvntryQy", "현재고량", null, true, false);   //용도

    dialogGridID = createAUIGrid(releaseDialogColumnLayout, dialogGridID);

    auigridCol(releaseDialogDetailColumnLayout);
    releaseDialogDetailColumnLayout.addColumnCustom("custlabSeqno", "분석실 명", null, false, false);//바코드
    releaseDialogDetailColumnLayout.addColumnCustom("custlabNm", "분석실 명", null, true, false);//바코드
    releaseDialogDetailColumnLayout.addColumnCustom("brcd", lang.C100000336, null, true, false);						//바코드
    releaseDialogDetailColumnLayout.addColumnCustom("wrhsdlvrSeCodeNm", lang.C100000701, null, true, false); 			//입출고
    releaseDialogDetailColumnLayout.addColumnCustom("wrhsdlvrSeCode", lang.C100000701, null, false, false);
    releaseDialogDetailColumnLayout.addColumnCustom("wrhsdlvrDt", lang.C100000700, null, true, false); 					// 입출고 일자
    releaseDialogDetailColumnLayout.addColumnCustom("validDte", lang.C100000641, null, true, false,validProp);					// 유효일자
    releaseDialogDetailColumnLayout.addColumnCustom("lastChangerId", lang.C100000703, null, false, false); 				// 입출고자
    releaseDialogDetailColumnLayout.addColumnCustom("userId", lang.C100000703, null, true, false);						// 입출고자
    releaseDialogDetailColumnLayout.addColumnCustom("prductClCode", lang.C100000807, null, false, false);				//제품 구분
    releaseDialogDetailColumnLayout.addColumnCustom("prductNm", lang.C100000809, null, false, false);					//품명
    releaseDialogDetailColumnLayout.addColumnCustom("prductPrpos", lang.C100000621, null, false, false);				//용도
    releaseDialogDetailColumnLayout.addColumnCustom("packngSttus", lang.C100000393, null, false, false);				//보관 상태
    releaseDialogDetailColumnLayout.addColumnCustom("nowInvntryQy", lang.C100000957, null, false, false);				//현재 재고량
    releaseDialogDetailColumnLayout.addColumnCustom("wrhsdlvrQy", lang.C100000886, null, false, false);					//출고 수량
    releaseDialogDetailColumnLayout.addColumnCustom("cpcty", lang.C100000622, null, false, false);					//용량
    releaseDialogDetailColumnLayout.addColumnCustom("validDate", lang.C100000642, null, false, false); 				// 유효기간
    releaseDialogDetailColumnLayout.addColumnCustom("rm", lang.C100000425, null, false, true);							//비고
    releaseDialogDetailColumnLayout.addColumnCustom("rgntProgrsSittnCode", lang.C100000846, null, false, false);		//진행 상황
    releaseDialogDetailColumnLayout.addColumnCustom("validTmlmtMthdCode", "", null, false, false);						//유효기한 방식
    releaseDialogDetailColumnLayout.addColumnCustom("validTmlmtTrgetAt", "", null, false, false);						//유효기한 방식
    releaseDialogDetailColumnLayout.addColumnCustom("unsealAfterTmlmt", "", null, false, false);						//기한
    releaseDialogDetailColumnLayout.addColumnCustom("cycleCode", "", null, false, false);
    releaseDialogDetailColumnLayout.addColumnCustom("bplcCode", "${msg.C100000432}", null, false, false);
    dialogGridIDDetail = createAUIGrid(releaseDialogDetailColumnLayout, dialogGridIDDetail, checkEventProps);

    //dialogGridID = createAUIGrid(releaseDialogColumnLayout, dialogGridID);
    //dialogGridIDDetail = createAUIGrid(releaseDialogDetailColumnLayout, dialogGridIDDetail, checkEventProps);

    // 검색 함수
    function getReleasetList() {
        var gridUrl = "/rsc/getRgntMList.lims";
        getGridDataParam(gridUrl
            , { prductClSeqno: data,custlabSeqno:$('#' + dialogId + 'custlabSeqno').val() , bplcCodeSch: $('#' + dialogId + 'bplcCodeSch').val(), prductClCodesch: $("#" + dialogId + "prductClCodesch").val(), prductNmSch: $("#" + dialogId + "prductNmSch").val(), popupSch: gridId,useAtSch:'Y'}
            , dialogGridID);
    }

    $("#popup_" + dialogId + " #btnReleasePopSearch").click(function () {
        getReleasetList();
    });

    $("#popup_" + dialogId + " #btnReleasePopSelect").click(function () { // 선택 클릭 이벤트
        //var gridItem = AUIGrid.getItemsByValue(dialogGridID, "checkBox", true);
        var checkedItems = AUIGrid.getCheckedRowItems(dialogGridIDDetail);

        if (checkedItems != undefined && checkedItems != null) {
            gridId = (gridId.indexOf('#') == -1) ? '#' + gridId : gridId;
            popUpAddRow(checkedItems, gridId);
        }

        /*if(invalidConunt > 0){
            $("#popup_"+dialogId+" #relPrductClNm").val('');
            $("#popupClose_" + dialogId).trigger("click");
        }*/

    });

    function popUpAddRow(data, gridId) {
        var masterData = AUIGrid.getGridData(gridId)// 페이지 마스터 그리드
        var addRowArr = new Array();

        if (masterData) {
            addRowArr = masterData;
        }

        for (var k = 0; k < data.length; k++) {

            var item = new Object();
            item.custlabSeqno = data[k].item.custlabSeqno // 용기량
            item.brcd = data[k].item.brcd // 바코드
            item.purchsNm = data[k].item.purchsNm// 입고명
            item.prductSeNm = data[k].item.prductSeNm// 제품 구분
            item.prductClNm = data[k].item.prductClNm// 제품 분류명
            item.prductNm = data[k].item.prductNm // 제품명
            item.prductClCode = data[k].item.prductClCode
            item.prductPrpos = data[k].item.prductPrpos // 용도
            item.packngSttus = data[k].item.packngSttus //보관 상태
            item.unitNm = data[k].item.unitNm // 제품 단위
            item.cpcty = data[k].item.cpcty // 용량
            item.prductSeqno = data[k].item.prductSeqno
            item.wrhsdlvrSeCodeNm = data[k].item.wrhsdlvrSeCodeNm
            item.purchsNm = data[k].item.purchsNm // 입고명
            item.validDte = data[k].item.validDte // 유효일자
            item.validDate = data[k].item.validDate // 유효일자
            if (data[k].item.validDte != null) {
                item.validDate = data[k].item.validDte
            }
            item.acptncComptDte = data[k].item.acptncComptDte // 검수 완료일자
            item.wrhsdlvrQy = "1" // 출고 수량
            item.pc = data[k].item.pc;
            item.nowInvntryQy = data[k].item.nowInvntryQy // 현재 재고량
            item.useQySeCode = data[k].item.useQySeCode
            item.useQySeNm = data[k].item.useQySeNm
            item.rm = data[k].item.rm
            item.validTmlmtMthdCode = data[k].item.validTmlmtMthdCode
            item.wrhsdlvrSeBeforeCode = data[k].item.wrhsdlvrSeCode
            item.unsealAfterTmlmt = data[k].item.unsealAfterTmlmt
            item.validTmlmtTrgetAt = data[k].item.validTmlmtTrgetAt
            item.cycleCode = data[k].item.cycleCode
            item.bplcCode = data[k].item.bplcCode
            if (gridId == "dsuseMGrid") {
                item.wrhsdlvrSeCode = "RS08000003"
            } else if (data[k].item.wrhsdlvrSeCode == "RS08000001") {
                item.wrhsdlvrSeCode = "RS08000002"
            }

            addRowArr.push(item)
            //AUIGrid.addRow(gridId, item, "last");
        }

        // 데이터 셋
        AUIGrid.setGridData(gridId, addRowArr);

        if (data.length > 0) {
            AUIGrid.clearGridData(dialogGridIDDetail);
            AUIGrid.setAllCheckedRows(dialogGridIDDetail, false);
            $("#popup_" + dialogId + " #relPrductClNm").val('');
            $("#popupClose_" + dialogId).trigger("click");

        } else {
            alert('선택한 항목이 없습니다. 항목을 선택해주세요.')

            return;
        }

    }

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridIDDetail, "ready", function (event) {
        gridColResize(dialogGridIDDetail, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        var param = {
            wrhsdlvrSeCode: "",
            prductSeqno: event.item.prductSeqno
        };

        // 현재 재고량 데이터 할당
        nowWrhsdlvrQy = event.item.nowReleaseQy

        // 바코드 조회 url
        var getPopupBrcd = "/rsc/getPopupBrcd.lims";

        if (gridId === "releaseMGrid") { // 출고 페이지
            param.wrhsdlvrSeCode = "1";
        } else if (gridId === "dsuseMGrid") { // 폐기 페이지
            param.wrhsdlvrSeCode = "2";
        }
        // 바코드 조회
        getGridDataParam(getPopupBrcd, param, dialogGridIDDetail);
    });

    AUIGrid.bind(dialogGridIDDetail, "rowAllChkClick", function (event) {
        AUIGrid.clearSortingAll(dialogGridIDDetail);
        var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지 마스터 그리드
        var getItem = AUIGrid.getGridData(dialogGridIDDetail);
        var nowDt = currentDate();
        var checkArray = new Array();
        // 팝업 바코드 유효일자, 페이지 중복 데이터 체크 함수
        function getBacodeUniqueArray(array1, array2) {
            var nowDt = currentDate();
            var tempArray = new Array();
            var resultArray = new Array();

            for (var i = 0; i < array1.length; i++) { // 팝업창 바코드 리스트
                if (gridId == "releaseMGrid") {
                    // 2. 유효기한이 안지난 바코드 선택
                    if (nowDt <= array1[i].validDte || !array1[i].validDte) {
                        tempArray.push({ brcd: array1[i].brcd, bplcCode: array1[i].bplcCode });
                    }
                    else if (array1[i].validTmlmtTrgetAt == 'N') {
                        tempArray.push({ brcd: array1[i].brcd, bplcCode: array1[i].bplcCode });
                    }

                } else {
                    tempArray.push({ brcd: array1[i].brcd, bplcCode: array1[i].bplcCode });
                }
            }

            for (var k = 0; k < tempArray.length; k++) {
                if (array2.length > 0) {
                    for (var j = 0; j < array2.length; j++) {  // 페이지에서 선택한 바코드 리스트
                        // 1. 페이지에서 선택하지 않은 바코드만 선택
                        if (tempArray[k].brcd == array2[j].brcd && tempArray[k].bplcCode == array2[j].bplcCode) {
                            //tempArray[k] = tempArray.splice(tempArray[k].length-1, 1);
                            tempArray.splice(k, 1);
                        }
                    }

                    // 최종 바코드 결과값 할당
                    resultArray = tempArray;
                } else {
                    if (tempArray.length > 0) {
                        for (var i = 0; i < tempArray.length; i++) {
                            resultArray.push({ brcd: tempArray[i].brcd, bplcCode: tempArray[i].bplcCode })
                        }
                    }
                }
            }

            return resultArray;
        }

        // 변수에 바코드 결과값 할당
        checkArray = getBacodeUniqueArray(getItem, getMasterGridData)

        // 바코드 결과값 전체 체크여부
        for (var h = 0; h < checkArray.length; h++) {
            if (event.checked) {
                AUIGrid.addCheckedRowsByValue(dialogGridIDDetail, "brcd", checkArray[h].brcd);
            } else {
                AUIGrid.addUncheckedRowsByValue(dialogGridIDDetail, "brcd", checkArray[h].brcd);
            }
        }

    });

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getReleasetList();
        }
    });
}


/**
 *기기관리 화면
*/
function dialogMhrls(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var mhrlsDialogColumnLayout = [];
    auigridCol(mhrlsDialogColumnLayout);

    mhrlsDialogColumnLayout.addColumn("eqpmnSeqno", lang.C000001041, null, false); /*기기 일련번호*/
    mhrlsDialogColumnLayout.addColumn("eqpmnClCode", lang.C000001217, null, false); /*기기 분류코드*/
    mhrlsDialogColumnLayout.addColumn("eqpmnClNm", lang.C000000007, null, true); /*기기분류*/
    mhrlsDialogColumnLayout.addColumn("eqpmnManageNo", lang.C000000008, null, true); /*기기관리번호*/
    mhrlsDialogColumnLayout.addColumn("eqpmnNm", lang.C000000011, null, true); /*기기명*/
    mhrlsDialogColumnLayout.addColumn("manageDeptCode", lang.C000001042, null, false); /*관리부서 코드*/

    mhrlsDialogColumnLayout.addColumn("inspctCrrctCycleNm", lang.C000000525, null, false); /*검교정 주기*/
    mhrlsDialogColumnLayout.addColumn("inspctCrrctCycle", lang.C000000525, null, false); /*검교정 주기*/
    mhrlsDialogColumnLayout.addColumn("inspctCrrctCycleCode", lang.C000001065, null, false); /*검교정 주기 코드*/
    mhrlsDialogColumnLayout.addColumn("inspctCrrctPrearngeDte", lang.C000000586, null, false); /*검교정 계획 일자*/

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(700);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000000654); /*■ 기기 목록*/
    var topright = "<span class=\"iArea mgR10\">"
        + "<select id=\"" + dialogId + "popManageDeptCode\" name=\"" + dialogId + "popManageDeptCode\"></select>"
        + "<select id=\"" + dialogId + "popChrgTeamSeCode\" name=\"" + dialogId + "popChrgTeamSeCode\" style=\"margin-left:5px;\"></select>"
        + "<input type=\"text\" id=\"" + dialogId + "popShrEqpmnNm\" name=\"" + dialogId + "popShrEqpmnNm\" style=\"margin-left:5px;\" placeholder=\"" + lang.C000000011 + "\">"  /*기기명*/
        + "</span>"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "btnMhrlsPopSearch\" style=\"margin-left:5px;\" class=\"btn1\">" + lang.C000000002 + "</button>" /*조회*/
        + "</div>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    ajaxJsonComboBox('/com/getDeptCombo.lims', dialogId + 'popManageDeptCode', null, false, lang.C000000079); /*선택*/
    //		 {"analsAt" : "Y", "mmnySeCode" : "SY01000001"}
    //		ajaxJsonComboBox('/com/getCmmnCode.lims', dialogId+'popChrgTeamSeCode', {'upperCmmnCode': 'RS19'}, true); /* 선택 */

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);

        if (data) {
            $("#" + dialogId + "popManageDeptCode").prop("disabled", true);
            $("#" + dialogId + "popManageDeptCode").val($("#" + data.manageDeptCodeId + " option:selected").val()).prop("selected", true);
        }

        getmhrlsList();
    }, preOpenFunc);

    dialogGridID = createAUIGrid(mhrlsDialogColumnLayout, dialogGridID);

    function getmhrlsList() {
        getGridDataParam("/com/getEqpmnList.lims", { shrEqpmnNm: $("#" + dialogId + "popShrEqpmnNm").val(), manageDeptCode: $("#" + dialogId + "popManageDeptCode option:selected").val(), chrgTeamSeCode: $("#" + dialogId + "popChrgTeamSeCode").val() }, dialogGridID);
    }
    $("#" + dialogId + "btnMhrlsPopSearch").click(function () {
        getmhrlsList();
    });

    $("#" + dialogId + "popShrMhrlsNm").keypress(function (e) {
        if (e.which == 13) {
            getmhrlsList();
            return false;
        }
    });

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        var gridItem = event.item;
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);
        $("#popupClose_" + dialogId).trigger("click");
    });
    //	selectionChangeAUIGrid(dialogGridID, function(rowInfo) {
    //
    //	});

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

}

/**
 * 업체 관리 팝업 (유지보수 업체, 납품 업체 팝업)
 */
function dialogEntrps(btnId, data, dialogId, selectFunc, preOpenFunc) {

    var mhrlsDialogColumnLayout = [];
    auigridCol(mhrlsDialogColumnLayout);

    mhrlsDialogColumnLayout
        .addColumn("entrpsSeCode", "업체 구분코드", null, false) //업체 구분코드
        .addColumn("entrpsSeNm", "업체 구분코드", null, false)   //업체 구분
        .addColumn("entrpsNm", lang.C100000587, null, true)    //업체명
        .addColumn("entrpsSeqno", "업체 일련번호", null, false); //업체 일련번호

    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(500);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000588); /* 업체 목록 */
    var topright = "<input type=\"text\" id=\"entrpsNm\" class=\"searchClass\" placeholder=\"" + lang.C100000587 + "\">" /* 업체명 */
        + "<div class=\"btnWrap\" style=\"position: inherit\">"
        + "<button type=\"button\" id=\"btnEntrpsPopSearch\" class=\"search\">" + lang.C100000767 + "</button>" /* 조회 */
        + "</div>";
    var body = "<div class='mgT10'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
    }, preOpenFunc);

    dialogGridID = createAUIGrid(mhrlsDialogColumnLayout, dialogGridID);

    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2');	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, 'cellDoubleClick', function (event) {
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(event.item);
        $('#popup_' + dialogId + ' #entrpsNm').val('');
        $('#popupClose_' + dialogId).trigger('click');
    });

    function getEntrpsList() {

        var params = {};
        if (dialogId == 'coaPrduct') {
            params.entrpsNm = $('#popup_' + dialogId + ' #entrpsNm').val();
            getGridDataParam('/test/getEntrpsListHasPrint.lims', params, dialogGridID);
        } else {
            params.entrpsSeCode = data;
            params.entrpsNm = $('#popup_' + dialogId + ' #entrpsNm').val();
            getGridDataParam('/com/getEntrpsFclty.lims', params, dialogGridID);
        }
    }

    $('#popup_' + dialogId + ' #btnEntrpsPopSearch').click(function () {
        getEntrpsList();
    });

    $('.searchClass').keypress(function (e) {
        if (e.which == 13) {
            getEntrpsList();
        }
    });
}
function dialogCmmnCodeM(btnId, data, dialogId, gridId, selectFunc, prePopupOpenFunc, flag) {
    var cmmnDialogColumnLayout = [];

    var gridId = "#" + gridId;
    var Prop = {
        showRowCheckColumn: true,
        independentAllCheckBox: true,
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지 마스터 그리드
            var bool = true;

            if (getMasterGridData.length == 0) {
                item.disGubun = "undisabled";
                return bool;
            } else {
                for (var i = 0; i < getMasterGridData.length; i++) {
                    //페이지 검교정 그리드의 검교정구분코드가 같은게 선택되었다면 선택X
                    if (item.value == getMasterGridData[i].eqpmnClCode) {
                        bool = false; // false 반환하면 disabled 처리됨
                        item.disGubun = "disabled";
                        break;
                    } else {
                        bool = true;
                        item.disGubun = "undisabled";
                    }

                }
                return bool;
            }
        }
    }

    auigridCol(cmmnDialogColumnLayout);
    cmmnDialogColumnLayout.addColumn("key", "공통코드", "*", true); /* 검교정 구분 */
    cmmnDialogColumnLayout.addColumn("value", 'value', "*", false);
    cmmnDialogColumnLayout.addColumn("disGubun", 'disGubun', "*", false); /* disabled 구분컬럼 */

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(500);

    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, "공통코드");
    var body = "<div>"
        + "<div class=\"btnWrap fR\" style=\"position: inherit; margin-bottom: 5px;\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnCrrctSeCodePopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:70%; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);
    var param = {
        "upperCmmnCode": "RS24"
    };
    popupInit(btnId, dialogId, function () {
        var mmnySeCode = $('input:radio[name=mmnySelect]:checked').val();
        var flag = true;
        param["inCode"] = "";
        flag = false;
        AUIGrid.resize(dialogGridID);
        getCrrctSeNmList();

    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(cmmnDialogColumnLayout, dialogGridID, Prop);

    //검교정 구분 목록 조회
    function getCrrctSeNmList() {
        getGridDataParam("/com/getCmmnCode.lims", data, dialogGridID);
    }

    //추가버튼 클릭 이벤트
    $("#" + dialogId + "_btnCrrctSeCodePopAdd").click(function () {
        // 그리드 데이터에서 isActive 필드의 값이 Active 인 행 아이템 모두 반환
        var activeItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);

        if (activeItems.length == 0) {
            alert(lang.C100000497); /* 선택된 행이 없습니다 */
            return false;
        }

        selectFunc(activeItems);

        var removeList = AUIGrid.getCheckedRowItems(dialogGridID);
        var indexArr = new Array();
        for (var i = 0; i < removeList.length; i++) {
            indexArr.push(removeList[i].rowIndex);
        }

        AUIGrid.removeRow(dialogGridID, indexArr);

        //팝업창 닫기
        $("#popupClose_" + dialogId).trigger("click");
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        // 엑스트라 체크박스 체크 추가
        var item = event.item, rowIdField, rowId;

        rowIdField = AUIGrid.getProp(event.pid, "rowIdField"); // rowIdField 얻기
        rowId = item[rowIdField];

        //disabled가 아닌 체크박스에 한해
        if (item.disGubun == "undisabled") {
            //체크가 안된 상태면 체크
            if (!AUIGrid.isCheckedRowById(event.pid, rowId)) {
                AUIGrid.addCheckedRowsByIds(event.pid, rowId);
                //이미 체크된 상태면 체크해제
            } else {
                AUIGrid.addUncheckedRowsByIds(event.pid, rowId);
            }
        }

        //더블클릭 시 자동 추가(더블클릭 후 체크된 상태만)
        if (AUIGrid.isCheckedRowById(event.pid, rowId)) {
            $("#" + dialogId + "_btnCrrctSeCodePopAdd").trigger("click");
        }
    });

    //체크박스 전체선택/해제 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        var dialList = AUIGrid.getGridData(dialogGridID);

        //전체 체크박스 check
        if (event.checked) {
            for (var i = 0; i < dialList.length; i++) {
                //disabled 아닌 것들만 체크
                if (dialList[i].disGubun == "undisabled") {
                    AUIGrid.addCheckedRowsByValue(dialogGridID, "key", dialList[i].key);
                }
            }
            //전체 체크박스 check해제
        } else {
            for (var i = 0; i < dialList.length; i++) {
                //disabled 아닌 것들만 체크해제
                if (dialList[i].disGubun == "undisabled") {
                    AUIGrid.addUncheckedRowsByValue(dialogGridID, "key", dialList[i].key);
                }
            }
        }

    });

}

// 검교정 구분 목록 팝업
function dialogInspctCrrctM(btnId, data, dialogId, gridId, selectFunc, prePopupOpenFunc, flag) {
    var crrctDialogColumnLayout = [];
    var gridId = "#" + gridId;

    var gridProperties = {
        showRowCheckColumn: true,  // 엑스트라 행 체크박스 출력 여부
        independentAllCheckBox: true, // 전체 체크박스의 독립적인 행위 여부 (체크/해제가 행 개별적으로 이루어짐)
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var bool = true;
            var masterGridData = AUIGrid.getGridData(gridId);

            if (masterGridData.length == 0) {
                item.disGubun = "undisabled";
                return bool;
            } else {
                for (var i = 0; i < masterGridData.length; i++) {
                    // 본 화면에 추가되어 있는 검교정구분은 체크상태 변경 불가
                    if (item.value == masterGridData[i].inspctCrrctSeCode) {
                        bool = false;
                        item.disGubun = "disabled";
                        break;
                    } else {
                        bool = true;
                        item.disGubun = "undisabled";
                    }
                }
                return bool;
            }
        }
    };

    auigridCol(crrctDialogColumnLayout);
    crrctDialogColumnLayout.addColumn("key", lang.C100000125, "*", true);  // 검교정 구분 키
    crrctDialogColumnLayout.addColumn("value", 'value', "*", false);       // 검교정 구분 코드값
    crrctDialogColumnLayout.addColumn("disGubun", 'disGubun', "*", false); // disabled 상태 구분 값

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(500);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000126);  /* 검교정 목록 */

    var body = "<div class='mgT10'>"
        + "<div class=\"btnWrap fR\" style=\"top: 5px !important;\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnCrrctSeCodePopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:158px; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    var param = {
        "upperCmmnCode": "RS24"
    };

    // 팝업창 열릴 때 초기 세팅
    popupInit(btnId, dialogId, function () {
        param["inCode"] = "";
        AUIGrid.resize(dialogGridID);
        getCrrctSeNmList();
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(crrctDialogColumnLayout, dialogGridID, gridProperties);

    // 검교정구분 목록 조회
    function getCrrctSeNmList() {
        getGridDataParam("/com/getCmmnCode.lims", { "upperCmmnCode": "RS24" }, dialogGridID);
    }

    // 추가버튼 클릭 이벤트
    $("#" + dialogId + "_btnCrrctSeCodePopAdd").click(function () {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000488);  /* 선택된 검교정 구분이 없습니다. */
            return;
        }

        // 체크된 row의 데이터를 본 화면에 보여줌 
        selectFunc(checkedItems);
        $("#popupClose_" + dialogId).trigger("click");
    });

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");
    });

    // 더블클릭한 row는 바로 추가해줌
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            selectFunc(arr);
            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 전체 체크박스 클릭 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        // 비활성화가 안된 체크박스에 한해 전체 체크/해제
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        }
    });
}


function dialogReqest(btnId, dialogId, gridId, sessionObj, selectFunc) {

    var dialogGridID = "grid_" + dialogId;
    var gridId = "#" + gridId;
    var html = createDialog(1200)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000655); /* 의뢰 목록 */

    var body = ''
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnAddReqOnPop\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnSearchReqOnPop\" class=\"search\" >" + lang.C100000767 + "</button>" /* 조회 */
        + "</div><br>"
        + "<form id=\"" + dialogId + "ReqSearchOnPopFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>"+lang.C100000986+"</th>" /* 의뢰 부서 */
        + "<td><select id=\"" + dialogId + "_schReqDeptOnPop\" name=\"schReqDeptOnPop\"></select></td>"
        + "<th>"+"분석실"+"</th>" /* 분석실 */
        + "<td><select id=\"" + dialogId + "_schCustlabOnPop\" name=\"schCustlabOnPop\"></select></td>"
        + "<th>"+lang.C100000659+"</th>" /* 의뢰 일자 */
        + "<td>"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqBeginDteOnPop\" class='searchClass wd6p' name=\"schReqBeginDteOnPop\" style=\"min-width: 6em\">"
        + "~" + "&nbsp"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqEndDteOnPop\" class='searchClass wd6p' name=\"schReqEndDteOnPop\" style=\"min-width: 6em\">"
        + "</td>"
        + "<th>"+lang.C100000139+"</th>" /* 검사 유형 */
        + "<td><select id=\"" + dialogId + "_schInspctTyCodeOnPop\" name=\"schInspctTyCodeOnPop\"></select></td>"
        + "</tr>"
        + "<tr>"
        + "<th>"+lang.C100000657+"</th>" /* 의뢰 번호 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schReqNoOnPop\" class='searchClass' name=\"schReqNoOnPop\"></td>"
        + "<th>"+"시료 정보"+"</th>" /* 시료 정보 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schSploreNmOnPop\" class='searchClass' name=\"schSploreNmOnPop\"></td>"
        + "<th>"+lang.C100000809+"</th>" /* 제품 명 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schMtrilNmOnPop\" class='searchClass' name=\"schMtrilNmOnPop\"></td>"
        + "<th>"+"제품구분"+"</th>" /* 제품구분 */
        + "<td><select id=\"" + dialogId + "_schPrductTyCodeOnPop\" name=\"schPrductTyCodeOnPop\"></select></td>"
        + "</tr>"
        + "</table>"
        + "<input type='text' name='ncrChk' value='' style='display: none'>"
        + "<input type='text' id='eqpmnSeqnoPop' name='eqpmnSeqnoPop' value='' style='display: none'>"
        + "<input type='text' id='pageGbn' name='pageGbn' value='' style='display: none'>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>"
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    // 그리드 생성
    var reqestCol = [];

    auigridCol(reqestCol);
    reqestCol
    .addColumnCustom("reqestSeqno", "의뢰 일렬번호", "*", false)
    .addColumnCustom("reqestDeptNm", lang.C100000986, "*", true)
    .addColumnCustom("reqestNo", lang.C100000657, "*", true)
    .addColumnCustom("custlabNm", "분석실", "*", true)
    .addColumnCustom("inspctTyNm", lang.C100000139, "*", true)
    .addColumnCustom("mtrilNm", lang.C100000716, "*", true)
    .addColumnCustom("clientNm", lang.C100000665, "*", true)
    .addColumnCustom("reqestDte", lang.C100000659, "*", false)
    .addColumnCustom("disabledGbn", "disabledGbn", "*", false)
    .addColumnCustom("prductTyNm", "제품구분", "*", true);

    var reqestGridProp = {
        editable: false,
        selectionMode: "multipleRows",
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
        rowCheckDisabledFunction: function(rowIndex, isChecked, item) {
            if (item.disabledGbn == "disabled") {
                return false;
            }

            return true;
        }
    };

    // 화면별 그리드 엑스트라 체크박스 설정
    if (dialogId == "ncrReqDialog" || dialogId == "ncrReqSchDialog")
        dialogGridID = createAUIGrid(reqestCol, dialogGridID);
    else
        dialogGridID = createAUIGrid(reqestCol, dialogGridID, reqestGridProp);

    popupInit(btnId, dialogId, function() {

        // 장비 일렵번호 본 화면에서 받아옴
        var eqpmnSeqnoPop = (!!$("#eqpmnSeqno").val()) ? $("#eqpmnSeqno").val() : null;
        if (!!eqpmnSeqnoPop) {
            $("#eqpmnSeqnoPop").val(eqpmnSeqnoPop);
            $("#pageGbn").val("Eqpmn");
        }

        getReqestList();
        AUIGrid.resize(dialogGridID);
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    });

    // 화면별로 검사유형 selectbox 기본값 세팅 (필요하면 각자 중첩으로 추가 요망)
    var selectVal = (dialogId == "inspctReqDialog" || dialogId == "gageReqDialog") ? "SY07000005" : null;

    if (dialogId == "ncrReqDialog"){
        $('input[name=ncrChk]').attr('value','IM05000002');
    }

    ajaxJsonComboBox("/wrk/getDeptComboList.lims", dialogId+"_schReqDeptOnPop", { bestInspctInsttCode : sessionObj.bplcCode }, true, null, sessionObj.deptCode);
    ajaxJsonComboBox("/com/getCustLabCombo.lims", dialogId+"_schCustlabOnPop", null, true);
    ajaxJsonComboBox("/com/getCmmnCode.lims",dialogId+"_schInspctTyCodeOnPop",{ upperCmmnCode : "SY07" }, true, null, selectVal);
    ajaxJsonComboBox("/com/getCmmnCode.lims",dialogId+"_schPrductTyCodeOnPop",{ upperCmmnCode : "SY20" }, true, null, selectVal);
    datePickerCalendar([dialogId+"_schReqBeginDteOnPop", dialogId+"_schReqEndDteOnPop"], true, ["MM",-1], ["DD",0]);

    // 고정값 세팅 후 selectbox disabled
    (selectVal != null) ? $("#"+dialogId+"_schInspctTyCodeOnPop").prop("disabled", true)
        : $("#"+dialogId+"_schInspctTyCodeOnPop").prop("disabled", false);

    // 의뢰목록 조회
    function getReqestList() {

        customAjax({
            url: "/com/getReqestListPop.lims",
            data: $("#"+dialogId+"ReqSearchOnPopFrm")[0].toObject(true),
            successFunc: function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].reqestSeqno == masterGridData[j].reqestSeqno) {
                                list[i].disabledGbn = "disabled";
                                break;
                            }
                        }

                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disabledGbn) {
                            list[i].disabledGbn = "undisabled";
                        }
                    }

                    // 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disabledGbn = "undisabled";
                    }
                }

                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    $("#"+dialogId+"_btnAddReqOnPop").click(function() {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        var selectedItem = AUIGrid.getSelectedItems(dialogGridID);
        if(dialogId != "ncrReqDialog"){
            if (checkedItems.length == 0) {
                alert(lang.C100000497);  /* 선택된 행이 없습니다. */
                return false;
            }
            selectFunc(checkedItems);
        } else {
            selectFunc(selectedItem[0].item);
        }
        // 본 화면 그리드에 뿌려줌
        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#"+dialogId+"_btnSearchReqOnPop").click(function() {
        getReqestList();
    });

    AUIGrid.bind(dialogGridID, "ready", function(event) {
        gridColResize(dialogGridID, "2");
    });

    // row 더블클릭 시, 단일 행 즉시 추가
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function(event) {
        if (event.item.disabledGbn != 'disabled') {
            var arr = new Array(event.item);
            if(dialogId != "ncrReqDialog"){
                selectFunc(arr);
            } else {
                selectFunc(event.item);
            }

            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 비활성화가 안된 체크박스에 한해 전체체크 컨트롤
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function(event) {
        if (event.checked)
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disabledGbn", "undisabled");
        else
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disabledGbn", "undisabled");
    });

    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getReqestList();
        }
    });
}

// 시험항목 분류별 시험항목 팝업
function dialogAddExpriemList(btnId, data, dialogId, gridId, selectFunc, prePopupOpenFunc) {
    var exprIemDialogColumnLayout = [];
    var gridId = "#" + gridId;

    auigridCol(exprIemDialogColumnLayout);
    exprIemDialogColumnLayout.addColumn("expriemCl", lang.C100000141, "*", true); 	  // 검사항목 그룹 명
    exprIemDialogColumnLayout.addColumn("expriemNm", lang.C100000560, "*", true); 	  // 시험항목 명
    exprIemDialogColumnLayout.addColumn("koreanNm", lang.C100000945, "*", true);  	  // 한글 명
    exprIemDialogColumnLayout.addColumn("engNm", lang.C100000608, "*", true); 	  	  // 영문 명
    exprIemDialogColumnLayout.addColumn("abrv", lang.C100000580, "*", true);      	  // 약어
    exprIemDialogColumnLayout.addColumn("sortOrdr", lang.C100000580, "*", false);     // 정렬순서
    exprIemDialogColumnLayout.addColumn("disGubun", 'disGubun', "*", false); 	      // disabled 상태 구분값
    exprIemDialogColumnLayout.addColumn("expriemSeqno", lang.C000000838, "*", false); // 시험항목 일련번호

    var gridProperties = {
        showRowCheckColumn: true,     // 엑스트라 행 체크박스 출력 여부
        independentAllCheckBox: true, // 전체 체크박스의 독립적인 행위 여부 (체크/해제가 행 개별적으로 이루어짐)

        // 엑스트라 행 체크박스의 비활성화(disabled) 여부 지정하는 함수
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            if (item.disGubun == 'disabled') { // 본 화면에 추가되어 있는 항목
                return false;
            }
            return true;
        }
    };

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1200)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000561);  /* 시험항목 목록 */

    var body = "<div class='mgT15'>"
        + "<div class=\"btnWrap fR mgB5\" style=\"position: inherit\">"
        //+"<td><select id = \""+dialogId+"_testCodeSch\" name=\"testCodeSch\" style=\"margin-right:15px\"></select></td>"
        + "<input type=\"text\" id=\"" + dialogId + "_expriemNmSearch\" class=\"searchClass\"  placeholder=\"" + lang.C100000560 + "\">" /* 시험항목 명 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopSearch\" class=\"search\">" + lang.C100000767 + "</button>" /* 조회 */
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    var clCodeGubun = {};  // 조회쿼리에 넘겨줄 Object 생성

    // 팝업창 열릴 때 초기 세팅
    popupInit(btnId, dialogId, function () {
        //$("#"+dialogId+"_testCodeSch").val("");
        $("#" + dialogId + "_expriemNmSearch").val("");

        if (data.pageNm == "EqpmnE") {
            clCodeGubun["inCode"] = "SY05000002";
            clCodeGubun["notInCode"] = "SY05000001";
        } else if (data.pageNm == "EqpmnR") {
            clCodeGubun["inCode"] = "SY05000001";
            clCodeGubun["notInCode"] = "SY05000002";
        } else if (data.pageNm == "Prduct") {
            clCodeGubun["inCode"] = "SY05000001";
            clCodeGubun["notInCode"] = "SY05000002";
        } else if (data.pageNm == "Request") {
            clCodeGubun["inCode"] = "SY05000001";
            clCodeGubun["notInCode"] = "SY05000002";
        }

        AUIGrid.resize(dialogGridID);
        getExprIemList();
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, gridProperties);

    // 시험항목 분류별 시험항목 조회
    function getExprIemList() {

        var param = {
            "expriemNmSearch": $("#" + dialogId + "_expriemNmSearch").val(),
            "inClCode": clCodeGubun.inCode,
            "notInClCode": clCodeGubun.notInCode
        };

        customAjax({
            "url": "/com/getAddExprIemListM.lims",
            "data": param,
            "successFunc": function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].expriemSeqno == masterGridData[j].expriemSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                    // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    // 추가버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopAdd").click(function () {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000493);  /* 선택된 시험항목이 없습니다. */
            return false;
        }

        // 체크된 row의 데이터를 본 화면에 보여줌 
        selectFunc(checkedItems);
        $("#popupClose_" + dialogId).trigger("click");
    });

    // 조회버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopSearch").click(function () {
        getExprIemList();
    });

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");
    });

    // 더블클릭한 row는 바로 추가해줌
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            selectFunc(arr);
            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 전체 체크박스 클릭 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        // 비활성화가 안된 체크박스에 한해 전체 체크/해제
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        }
    });

    // 엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}
function dialogAddRgntExpriemList(btnId,  dialogId, gridId, selectFunc, prePopupOpenFunc, flag) {
    var exprIemDialogColumnLayout = [];
    var gridId = "#" + gridId;

    auigridCol(exprIemDialogColumnLayout);
    exprIemDialogColumnLayout.addColumn("expriemCl", lang.C100000141, "*", true); 	  // 검사항목 그룹 명
    exprIemDialogColumnLayout.addColumn("expriemNm", lang.C100000560, "*", true); 	  // 시험항목 명
    exprIemDialogColumnLayout.addColumn("koreanNm", lang.C100000945, "*", true);  	  // 한글 명
    exprIemDialogColumnLayout.addColumn("engNm", lang.C100000608, "*", true); 	  	  // 영문 명
    exprIemDialogColumnLayout.addColumn("abrv", lang.C100000580, "*", true);      	  // 약어
    exprIemDialogColumnLayout.addColumn("sortOrdr", lang.C100000580, "*", false);      // 정렬순서
    exprIemDialogColumnLayout.addColumn("disGubun", 'disGubun', "*", false); 	      // disabled 상태 구분값
    exprIemDialogColumnLayout.addColumn("expriemSeqno", lang.C000000838, "*", false); // 시험항목 일련번호

    var gridProperties = {

        showRowCheckColumn: true,     // 엑스트라 행 체크박스 출력 여부
        independentAllCheckBox: true, // 전체 체크박스의 독립적인 행위 여부 (체크/해제가 행 개별적으로 이루어짐)

        // 엑스트라 행 체크박스의 비활성화(disabled) 여부 지정하는 함수
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지
            for (var i = 0; i < getMasterGridData.length; i++) {
                if (item.expriemSeqno == getMasterGridData[i].expriemSeqno) {
                    count++;
                    return false; // false 반환하면 disabled 처리됨
                }
            }
            return true;
        }
    };

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1200)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000561);  /* 시험항목 목록 */

    var body = "<div class='mgT15'>"
        + "<div class=\"btnWrap fR\" style=\"padding-bottom:5px; position: inherit;\">"
        //+"<td><select id = \""+dialogId+"_testCodeSch\" name=\"testCodeSch\" style=\"margin-right:15px\"></select></td>"
        + "<input type=\"text\" id=\"" + dialogId + "_expriemNmSearch\" class=\"searchClass\"  placeholder=\"" + lang.C100000560 + "\">" /* 시험항목 명 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopSearch\" class=\"search\">" + lang.C100000767 + "</button>" /* 조회 */
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    var clCodeGubun = {};  // 조회쿼리에 넘겨줄 Object 생성

    // 팝업창 열릴 때 초기 세팅
    popupInit(btnId, dialogId, function () {
        //$("#"+dialogId+"_testCodeSch").val("");
        $("#" + dialogId + "_expriemNmSearch").val("");

            clCodeGubun["inCode"] = "SY05000001";
            clCodeGubun["notInCode"] = "SY05000002";
        AUIGrid.resize(dialogGridID);
        getExprIemList();
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, gridProperties);

    // 시험항목 분류별 시험항목 조회
    function getExprIemList() {
        var param = {
            "expriemNmSearch": $("#" + dialogId + "_expriemNmSearch").val(),
            "inClCode": clCodeGubun.inCode,
            "notInClCode": clCodeGubun.notInCode
        };

        customAjax({
            "url": "/com/getAddExprIemListM.lims",
            "data": param,
            "successFunc": function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].expriemSeqno == masterGridData[j].expriemSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                    // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    // 추가버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopAdd").click(function () {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000493);  /* 선택된 시험항목이 없습니다. */
            return false;
        }

        // 체크된 row의 데이터를 본 화면에 보여줌
        selectFunc(checkedItems);
        $("#popupClose_" + dialogId).trigger("click");
    });

    // 조회버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopSearch").click(function () {
        getExprIemList();
    });

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");
    });

    // 더블클릭한 row는 바로 추가해줌
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            selectFunc(arr);
            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 전체 체크박스 클릭 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        // 비활성화가 안된 체크박스에 한해 전체 체크/해제
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        }
    });

    // 엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}

function dialogAddWrhousngExpriemList(btnId,page, datafrom, dialogId, gridId, selectFunc, prePopupOpenFunc, flag) {
    var exprIemDialogColumnLayout = [];
    var gridId = "#" + gridId;

    auigridCol(exprIemDialogColumnLayout);

    exprIemDialogColumnLayout.addColumn("expriemNm", lang.C100000560, "*", true); 	  // 시험항목 명
    exprIemDialogColumnLayout.addColumn("sortOrdr", lang.C100000580, "*", false);      // 정렬순서
    exprIemDialogColumnLayout.addColumn("disGubun", 'disGubun', "*", false); 	      // disabled 상태 구분값
    exprIemDialogColumnLayout.addColumn("expriemSeqno", lang.C000000838, "*", false); // 시험항목 일련번호

    var gridProperties = {

        showRowCheckColumn: true,     // 엑스트라 행 체크박스 출력 여부
        independentAllCheckBox: true, // 전체 체크박스의 독립적인 행위 여부 (체크/해제가 행 개별적으로 이루어짐)

        // 엑스트라 행 체크박스의 비활성화(disabled) 여부 지정하는 함수
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지
            for (var i = 0; i < getMasterGridData.length; i++) {
                if(page =='TrendStdrM'){
                    if (item.mtrilSdspcSeqno == getMasterGridData[i].mtrilSdspcSeqno) {
                        count++;
                        return false; // false 반환하면 disabled 처리됨
                    }
                }else if(page =="WrhousngM") {
                    if (item.expriemSeqno == getMasterGridData[i].expriemSeqno) {
                        count++;
                        return false; // false 반환하면 disabled 처리됨
                    }
                }
            }
            return true;
        }
    };

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(600)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000561);  /* 시험항목 목록 */

    var body = "<div>"
        + "<div class=\"btnWrap fR\" style=\"margin-bottom: 5px; position: inherit;\">"
        //+"<td><select id = \""+dialogId+"_testCodeSch\" name=\"testCodeSch\" style=\"margin-right:15px\"></select></td>"
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopAdd\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    var clCodeGubun = {};  // 조회쿼리에 넘겨줄 Object 생성

    // 팝업창 열릴 때 초기 세팅
    popupInit(btnId, dialogId, function () {
        //$("#"+dialogId+"_testCodeSch").val("");
        $("#" + dialogId + "_expriemNmSearch").val("");

        clCodeGubun["inCode"] = "SY05000001";
        AUIGrid.resize(dialogGridID);
        if(page == "TrendStdrM"){
            getScpExprList();
        }
            else if(page == "WrhousngM"){
            getExprIemList();
        }
        AUIGrid.setAllCheckedRows(dialogGridID, false);
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, gridProperties);

    // 시험항목 분류별 시험항목 조회
    function getExprIemList() {
        data=$("#"+datafrom).serializeObject();
        var param = {
            "prductSeqno": data.prductSeqno,
            "inClCode": clCodeGubun.inCode
        };

        customAjax({
            "url": "/com/getprductAddExprIemListM.lims",
            "data": param,
            "successFunc": function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].expriemSeqno == masterGridData[j].expriemSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                    // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    function getScpExprList(){
        data=$("#"+datafrom).serializeObject();

        customAjax({
            "url": "/com/getScpExprList.lims",
            "data": data,
            "successFunc": function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].mtrilSspcSeqno == masterGridData[j].mtrilSspcSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                    // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridID, list);
            }
        });

    }
    // 추가버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopAdd").click(function () {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000493);  /* 선택된 시험항목이 없습니다. */
            return false;
        }

        // 체크된 row의 데이터를 본 화면에 보여줌
        selectFunc(checkedItems);
        $("#popupClose_" + dialogId).trigger("click");
    });

    // 조회버튼 클릭 이벤트
    $("#" + dialogId + "_btnExprIemPopSearch").click(function () {
        getExprIemList();
    });

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");
    });

    // 더블클릭한 row는 바로 추가해줌
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            selectFunc(arr);
            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 전체 체크박스 클릭 이벤트
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function (event) {
        // 비활성화가 안된 체크박스에 한해 전체 체크/해제
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", 'undisabled');
        }
    });

    // 엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}


function dialogRoaEditHist(btnId, data, dialogId, selectFunc, prePopupOpenFunc, flag) {
    var exprIemDialogColumnLayout = [];
    auigridCol(exprIemDialogColumnLayout);

    exprIemDialogColumnLayout.addColumn("processNm", lang.C100000859, "35%", true); /* before*/
    exprIemDialogColumnLayout.addColumn("changeAfterCn", "After", "35%", true); /* before*/
    exprIemDialogColumnLayout.addColumn("histPblicteDt", lang.C000000786, "*", true); /* before*/
    exprIemDialogColumnLayout.addColumn("changerId", lang.C000000272, "*", true); /* before*/

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1200)

    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000000717);
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);

        getExprIemList();
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID);

    function getExprIemList() {
        getGridDataParam("/test/getRoaEditHistList.lims", { "reqestSeqno": selectReq.reqestSeqno }, dialogGridID);
    }

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

}

function dialogUpdRdmsDate(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var UserDialogColumnLayout = [];
    auigridCol(UserDialogColumnLayout);

    var prop = {
        showRowCheckColumn: false,
        showRowAllCheckBox: false
    };

    var groupGridColPros = {
        style: "my-require-style",
        headerTooltip: { // 헤더 툴팁 표시 일반 스트링
            show: true,
            tooltipHtml: '값을 입력 또는 선택하세요.' /* 값을 입력 또는 선택하세요. */
        }
    };


    UserDialogColumnLayout.addColumnCustom("lotNo", lang.C100000056, "*", true) /*Lot No.*/
        .addColumnCustom("mtrilNm", lang.C100000717, "*", true) /*자재 명*/
        .addColumnCustom("expriemNm", lang.C000000204, "*", true) /*시험항목 명*/
        .addColumnCustom("qcTmplatNm", "ID", "*", true) /*ID*/
        .addColumnCustom("qcResultValue", lang.C000000754, "*", true, true, groupGridColPros) /*결과 값*/
        .addColumnCustom("reqestExpriemSeqno", lang.C000000752, "*", false) /*의뢰 시험항목 일련번호*/
        .addColumnCustom("exprOdr", lang.C000001231, "*", false) /*차수*/
        .addColumnCustom("exprNumot", lang.C000000819, "*", false) /*횟수*/
        .addColumnCustom("no", lang.C000001232, "*", false) /*no*/
        .addColumnCustom("rdmsUuid", lang.C000001233, "*", false) /*UUID*/
        .addColumnCustom("updtRdmsDocNo", lang.C000001234, "*", false); /*doc number*/

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1200);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, "메타 데이터");
    var topright = "<span class=\"iArea mgR10\"></span>";
    var body = "<div class=\"btnWrap mgT15 fR\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnPopSave\" class=\"save\">" + lang.C000000015 + "</button>" /*저장*/
        + "</div>"
        + "<div class='mgT15 fL wd100p'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        getRdmsDateList();
    }, preOpenFunc);

    dialogGridID = createAUIGrid(UserDialogColumnLayout, dialogGridID, prop);

    function getRdmsDateList() {
        getGridDataParam("/test/getRdmsDateList.lims", { "reqestSeqno": getEl("srchReqestSeqno").value }, dialogGridID);
    }

    getEl(dialogId + "_btnPopSave").event("click", function () {

        if (getEl("hiddenProgrsSittnCode").value != "IM03000004") {
            alert("진행상황이 'ROA대기'가 아니면 저장을 할 수 없습니다.");
            return false;
        }

        showLoadingbar();
        var editedRdmsDateList = AUIGrid.getEditedRowItems(dialogGridID);

        customAjax({
            "url": "/test/updRdmsDate.lims",
            "data": editedRdmsDateList
        }).then(function (data) {
            if (data == -50) {
                alert("해당 의뢰건의 진행상황을 확인해주세요.");
                return false;
            }

            if (data.success > 0) {
                alert(data.msg); /*저장되었습니다.*/
            } else {
                alert(lang.C000001138); /*수정 내역이 없습니다.*/
            }

            hideLoadingbar();
        });
        //		alert("!!");
    });

    // ready는 화면에 필수로 구현 할 것

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        selectFunc(event.item);
    });

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            //	    	getUserList();
        }
    });
}

function dialogViewChart(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(1000, 700);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C100001235);
    var topright = "";
    var body = "<div style='width:100%; height:650px;'>"
        + "<div id='" + dialogId + "_canvasDiv' class='subCon1' style='clear:both; display:flex; flex-wrap:wrap;'>"
        //			+ "<canvas id=\""+ dialogId +"_chartCanvas\" class=\"wd100p hei550\"></canvas>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);


    var divId = "div_" + dialogId; // divId
    var canvasId = "canvas_" + dialogId; // canva 아이디값
    var div = document.createElement("div"); //div

    div.style.height = "400px";
    div.classList.add("wd100p"); //각 차트 사이즈
    div.style.marginLeft = "1%";
    div.style.marginRight = "1%";

    div.style.padding = "10px 0 10px 0";
    div.style.height = $("#chartHeight").val() + "px";
    div.id = divId;

    getEl(dialogId + "_canvasDiv").appendChild(div);
    var canvas = document.createElement("canvas");
    //canvas.setAttribute("height", "210px");

    var canHeight = (div.style.height / 5) + "px"; //div  높이

    canvas.setAttribute("height", canHeight);
    canvas.id = canvasId;
    getEl(divId).appendChild(canvas);

    var ctx = getEl("canvas_" + dialogId).getContext("2d");

    var roaChart = new Chart(ctx, {
        type: "line",

        data: {
            labels: ["수치 \n Lot"],
            datasets: []
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: false
                    }
                }]
            },
            responsive: true,
        }
    });

    popupInit(btnId, dialogId, function () {
        innerRenderChart({ "expriemSeqno": getEl("btnDialogViewChart").value, "mtrilCode": getEl("dialogMtrilCode").value, "mtrilSeqno": getEl("dialogMtrilSeqno").value });
    }, preOpenFunc);

    function innerRenderChart(myParam) {
        customAjax({
            "url": "/test/getLotChartList.lims",
            data: myParam
        }).then(function (data) {
            if (data.length != 0) {
                console.log(">> : ", data);
                //기초 데이터 생성용 변수 생성
                //얘는 데이터 목록
                var lotArr = new Array();
                var lclArr = new Array();
                var uclArr = new Array();
                var qcValueArr = new Array();

                var unitNm = "";

                //반복문에 모조리넣음
                for (var i = 0; i < data.length; i++) {
                    lotArr.push(data[i]["reqestNo"]);
                    if (data[i].lslValue != null || data[i].lslValue != undefined) {
                        lclArr.push(data[i]["lslValue"]);
                    }
                    if (data[i].uslValue != null || data[i].uslValue != undefined) {
                        uclArr.push(data[i]["uslValue"]);
                    }
                    qcValueArr.push(data[i]["qcResultValue"]);
                }

                for (var i = 0; i < data.length; i++) {
                    if (!!data[i]["unitNm"]) {
                        unitNm = data[i]["unitNm"];
                        break;
                    }
                }

                // 기초데이터를 object로 만들었음.
                var valueList = [
                    {
                        "list": qcValueArr,
                        "label": lang.C100000150, /*결과 값*/
                        "fill": false,
                        "borderWidth": 1,
                        "pointRadius": 5,
                        "borderColor": 'rgb(30, 200, 60)'
                    }
                ];
                if (lclArr.length > 0) {
                    valueList.push({
                        "list": lclArr,
                        "label": lang.C000001804, /*LSL*/
                        "fill": false,
                        "borderWidth": 1,
                        "pointRadius": 0,
                        "borderColor": 'rgb(255,100,100)'
                    })
                }
                if (!!uclArr.length > 0) {
                    valueList.push({
                        "list": uclArr,
                        "label": lang.C000001805, /*USL*/
                        "fill": false,
                        "borderWidth": 1,
                        "pointRadius": 0,
                        "borderColor": 'rgb(100,180,255)'
                    })
                }




                //config 접근도어렵다 하...
                var config = roaChart.config;

                // 전역설정. 타이틀, 반응형으로 설정.
                config.options.responsive = true;
                config.options["title"]["display"] = true;
                config.options["title"]["text"] = data[0].mtrilNm + " " + getEl("dialogExpriemNm").value
                config.type = "line";

                config.options["scales"]["yAxes"] = [{
                    ticks: {
                        //beginAtZero: true,
                        //suggestedMin: 50,
                        //suggestedMax: 100
                    },
                    scaleLabel: {
                        display: true,
                        labelString: unitNm
                    }
                }];


                //기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
                //datasets 라인별이라고 보면됨니다
                roaChart["data"] = {
                    "labels": lotArr,
                    "datasets": []
                };

                //라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
                for (var i = 0; i < valueList.length; i++) {
                    roaChart.data.datasets[i] = {
                        "label": valueList[i].label,
                        "data": valueList[i].list,
                        "fill": valueList[i].fill,
                        "borderColor": valueList[i].borderColor,
                        "pointRadius": valueList[i].pointRadius,
                        lineTension: 0
                    };
                }

                // 완성된 차트는 업데이트를 시켜주면된다.
                roaChart.update();
            }


        });
    }
}


function dialogAddExpriemEditList(btnId, data, dialogId, parentGrid, selectFunc, prePopupOpenFunc, flag) {

    var exprIemDialogColumnLayout = [];
    auigridCol(exprIemDialogColumnLayout);

    var gridProperties = {
        //엑스트라체크박스 표시
        showRowCheckColumn: true,
        //전체 체크박스 표시 설정
        independentAllCheckBox: true,
        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var parentGridData = AUIGrid.getGridData(parentGrid); // 페이지 마스터 그리드
            var bool = true;
            if (parentGridData.length == 0) {
                item.disGubun = "undisabled";
                return bool;
            } else {
                for (var i = 0; i < parentGridData.length; i++) {
                    //페이지 마스터 그리드의 시험항목pk 같은게 선택되었다면 선택 x
                    if (item.expriemSeqno == parentGridData[i].expriemSeqno) {
                        bool = false; // false 반환하면 disabled 처리됨
                        item.disGubun = "disabled";
                        break;
                    } else {
                        bool = true;
                        item.disGubun = "undisabled";
                    }
                }
                return bool;
            }
        }
    };

    exprIemDialogColumnLayout.addColumnCustom('expriemCl', lang.C000000938, '*', true) //시험항목분류명
        .addColumnCustom('koreanNm', lang.C000000205, '*', true) //한글명
        .addColumnCustom('engNm', lang.C000000206, '*', true) //영문명
        .addColumnCustom('expriemNm', lang.C000000204, '*', true) //시험항목 명
        .addColumnCustom('rm', lang.C100000425, '*', true) //비고
        .addColumnCustom('jdgmntFomCode', lang.C000000235, '*', false, false) //판정 기준
        .addColumnCustom('disGubun',"","*",false,false)
        .addColumnCustom('expriemSeqno', lang.C000000755, '*', false); //시험항목 키

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C000000664); /* 시험항목 목록 */
    var topright = "<span class=\"iArea mgR10\"></span>"
        + "<input type=\"text\" id=\"expriemNmSearch\" class=\"searchClass\"  placeholder=\"" + lang.C000000204 + "\">" /*시험항목명*/
        + "</span>"
        + "<div class=\"btnWrap\" style=\"position: inherit\">"
        + "<button type=\"button\" id=\"btnExprIemPopAdd\" class=\"btn5\">" + lang.C000000504 + "</button>" /*추가*/
        + "<button type=\"button\" id=\"btnExprIemPopSearch\" class=\"search\">" + lang.C000000002 + "</button>" /*조회*/
        + "</div>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        getExprIemList();
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, gridProperties);

    function getExprIemList() {
        var paramObj = { expriemNmSearch: $('#popup_' + dialogId + ' #expriemNmSearch').val(),notInClCode:'SY05000002' };
        getGridDataParam('/com/getAddExprIemListM.lims', paramObj, dialogGridID);
    }


    $('#popup_' + dialogId + ' #btnExprIemPopAdd').click(function () {
        // 그리드 데이터에서 isActive 필드의 값이 Active 인 행 아이템 모두 반환
        var activeItems = AUIGrid.getCheckedRowItems(dialogGridID);

        if(!flag){
            if(activeItems.length > 1){
                alert(lang.C100000568); /*시험항목은 한개만 선택 가능합니다.*/
                return false;
            }
        }else if (activeItems.length == 0) {
            alert(lang.C000000209); /*선택된 시험항목이 없습니다.*/
            return false;
        }

        //row index 기준으로 sort한다.
        activeItems.sort(function (a, b) {
            if (a.rowIndex > b.rowIndex)
                return 1;
            if (a.rowIndex < b.rowIndex)
                return -1;
            return 0;
        });

        var expriemMap = new Array();
        activeItems.forEach(function (v) {
            expriemMap.push(v.item);
        });

        selectFunc(expriemMap);

        $('#popupClose_' + dialogId).trigger('click');
    });

    $('#popup_' + dialogId + ' #btnExprIemPopSearch').click(function () {
        getExprIemList();
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2');	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, 'rowAllCheckClick', function (checked) {
        var list = AUIGrid.getGridData(dialogGridID);
        list.forEach(function (v) {
            if (v.disGubun == 'undisabled') {
                if (checked) {
                    AUIGrid.addCheckedRowsByValue(dialogGridID, 'expriemSeqno', v.expriemSeqno);
                } else {
                    AUIGrid.addUncheckedRowsByValue(dialogGridID, 'expriemSeqno', v.expriemSeqno);
                }
            }
        });
        for (var i = 0; i<list.length-1; i++) { //Ex에러로 인한 수정
            if (list[i].disGubun == 'undisabled') {
                if (checked) {
                    AUIGrid.addCheckedRowsByValue(dialogGridID, 'expriemSeqno', list[i].expriemSeqno);
                } else {
                    AUIGrid.addUncheckedRowsByValue(dialogGridID, 'expriemSeqno', list[i].expriemSeqno);
                }
            }
        }
    });

    //엔터키 이벤트
    $('.searchClass').keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}

function dialogReqestAddExpriemList(btnId, data, dialogId, selectFunc, prePopupOpenFunc, flag) {

    var exprIemDialogColumnLayout = [];
    auigridCol(exprIemDialogColumnLayout);

    exprIemDialogColumnLayout.addColumnCustom('expriemSeqno', lang.C000000755, '*', false) //시험항목순번
        .addColumnCustom('mtrilSeqno', lang.C000000756, '*', false) //자재순번
        .addColumnCustom('useYn', lang.C000000065, '*', false) //사용여부
        .addColumnCustom('expriemNm', lang.C000000204, '*', true) //시험항목명
        .addColumnCustom('sdspcNm', lang.C000000825, '*', true) //기준규격명
        .addColumnCustom('unitNm', lang.C000000234, '*', true) //단위명
        .addColumnCustom('jdgmntFomNm', lang.C000000235, '*', true) //판정기준명
        .addColumnCustom('textStdr', lang.C000000236, '*', true, true); //텍스트기준
    exprIemDialogColumnLayout.addColumn('fstRoot', lang.C000000237, '*', true) //1차
        .addChildColumn('fstRoot', 'lclValue', lang.C000000282, '*', true) //LCL
        .addChildColumn('fstRoot', 'lclValueSeCode', lang.C000000234, '*', false) //단위
        .addChildColumn('fstRoot', 'uclValue', lang.C000000283, '*', true) //UCL
        .addChildColumn('fstRoot', 'uclValueSeCode', lang.C000000234, '*', false); //단위
    exprIemDialogColumnLayout.addColumn('secRoot', lang.C000000238, '*', true) //2차
        .addChildColumn('secRoot', 'lslValue', lang.C000001804, '*', true) //LSL
        .addChildColumn('secRoot', 'lslValueSeCode', lang.C000000234, '*', false) //단위
        .addChildColumn('secRoot', 'uslValue', lang.C000001805, '*', true) //USL
        .addChildColumn('secRoot', 'uslValueSeCode', lang.C000000234, '*', false); //단위
    exprIemDialogColumnLayout.addColumn('markCphr', lang.C000000241, '*', true) //표기 자리수
        .addColumn('useAt', lang.C000000065, '*', true) //사용 여부
        .addColumn('updtResn', lang.C000000250, '*', true) //수정 사유
        .addColumn('unitSeqno', lang.C000000234, '*', false); //단위
    var useAtList = [{ 'value': 'Y', 'key': '예' }, { 'value': 'N', 'key': '아니오' }];
    exprIemDialogColumnLayout.dropDownListRenderer(['useAt'], useAtList, true);

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C000000664); //시험항목 목록
    var topright = "<span class=\"iArea mgR10\"></span>"
        + "<div class=\"btnWrap\" style=\"top: 0; position: inherit;\">"
        + "<button type=\"button\" id=\"btnExprIemPopAdd\" class=\"btn5\">" + lang.C000000504 + "</button>" //추가
        + "</div>";
    var body = "<div class='mgT10'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        getExprIemList();
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, { showRowCheckColumn: true, editable: false });

    function getExprIemList() {
        if (!!data) {
            data['mtrilSeqno'] = getEl('mtrilSeqno').value;
            data['deptCode'] = getEl('reqestDeptCode').value;
            getGridDataParam('/wrk/getPrductExpriemList.lims', data, dialogGridID);
        }
    }

    $('#popup_' + dialogId + ' #btnExprIemPopAdd').click(function () {
        var activeItems = AUIGrid.getCheckedRowItems(dialogGridID);

        if (activeItems.length == 0) {
            alert(lang.C000000209); /*선택된 시험항목이 없습니다.*/
            return false;
        }

        //row index 기준으로 sort한다.
        activeItems.sort(function (a, b) {
            if (a.rowIndex > b.rowIndex)
                return 1;
            if (a.rowIndex < b.rowIndex)
                return -1;
            return 0;
        });

        var expriemMap = new Array();
        activeItems.forEach(function (v) {
            expriemMap.push(v.item);
        });

        selectFunc(expriemMap);

        $('#popupClose_' + dialogId).trigger('click');
    });

    $('#popup_' + dialogId + ' #btnExprIemPopSearch').click(function () {
        getExprIemList();
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2');	// 1, 2가 있으니 화면에 맞게 적용
    });

    //엔터키 이벤트
    $('.searchClass').keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}

/**
 * 그리드 파일 다운로드
 * @param btnId
 * @param dialogId
 * @param fileGridId
 * @returns
 */
function dialogGridFileDownload(btnId, dialogId, fileGridId) {

    var gridFileDownloadCol = [];
    var url = "/sys/dragDropDownloadAction.lims";
    auigridCol(gridFileDownloadCol);

    gridFileDownloadCol.addColumnCustom("atchmnflSeqno", "첨부파일 일련번호", "*", false); /*첨부파일 일련번호*/
    gridFileDownloadCol.addColumnCustom("fileSeqno", "파일 일련번호", "*", false); /*파일 일련번호*/
    gridFileDownloadCol.addColumnCustom("orginlFileNm", lang.C100000915, "50%", true); /*파일명*/
    gridFileDownloadCol.addColumnCustom("formatFileMg", lang.C100000916, "25%", true); /*파일크기*/
    gridFileDownloadCol.addColumnCustom("downloadBtn", lang.C100000265, "25%", true); /*다운로드*/

    gridFileDownloadCol.buttonRenderer(["downloadBtn"],
        function (rowIndex, columnIndex, value, item, dataField) {
            var params = {
                atchmnflSeqno: item.atchmnflSeqno
                , fileSeqno: item.fileSeqno
            };

            location.href = url + "?atchmnflSeqno=" + params.atchmnflSeqno + "&fileSeqno=" + params.fileSeqno;
        }, false, lang.C100000265);


    var dialogGridId = "grid_" + dialogId;
    var html = createDialog(450);

    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000914); /*파일 다운로드*/

    var topright = "<span class=\"iArea mgR10\"></span>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridId + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function (e) {
        AUIGrid.resize(dialogGridId);

        var gridData = AUIGrid.getSelectedItems(fileGridId);
        var params = {
            atchmnflSeqno: gridData[0]["item"]["atchmnflSeqno"]
        }

        //			getGridDataParam("/sys/dragDropGetFileList.lims", params, dialogGridId);
        customAjax({
            url: "/sys/dragDropGetFileList.lims",
            data: params,
            showLoading: false,
            successFunc: function (data) {
                for (var i = 0; i < data.length; i++) {
                    data[i].formatFileMg = data[i].formatFileMg + "MB"
                }
                dialogGridId = typeof dialogGridId != "string" ? undefined : dialogGridId[0] == "#" ? dialogGridId : "#" + dialogGridId;
                AUIGrid.setGridData(dialogGridId, data);
            }
        });
    });

    //auiGrid 생성
    var cusPros = {
        editable: false, // 편집 가능 여부 (기본값 : false)
        selectionMode: "multipleCells",// 셀 선택모드 (기본값: singleCell)
        enableCellMerge: true
    }
    dialogGridId = createAUIGrid(gridFileDownloadCol, dialogGridId, cusPros);
}

/**
 * 결재라인 팝업 : 2021-08-19 박건우 수정
 *
 *
 */
function dialogSanctn(btnId, data, dialogId, selectFunc, preOpenFunc, sanctnKndCode) {
    var btnSearch = "btnSearch_" + dialogId
    var btnSelect = "btnSelect_" + dialogId
    var btnUp = "btnUp_" + dialogId
    var btnDown = "btnDown_" + dialogId
    var btnLeft = "btnLeft_" + dialogId
    var btnRight = "btnRight_" + dialogId
    var dialogGridID = "grid_" + dialogId;
    var userDialogGridID = "grid2_" + dialogId;
    var customerDialogGridID = "grid3_" + dialogId;
    var sanctnSeCode = [];
    var btnUserSearch = "btnUserSearch" + dialogId
    var userNmSch = "userNmSch" + dialogId

    var cboDeptS = "cboDeptS_" + dialogId;
    var bplcCodeSearch = "bplcCodeSearch_" + dialogId;
    var bplcCodeName = "bplcCodeName_" + dialogId;
    var userBplcCode = "userBplcCode_" + dialogId;
    var userDeptCode = "userDeptCode_" + dialogId;
    var cboSanctnKndS = "cboSanctnKndS_" + dialogId;
    var cboSanctnLineNmS = "cboSanctnLineNmS_" + dialogId;

    var dialogColumnLayout = [];
    auigridCol(dialogColumnLayout);

    var gridPros = {
        showRowCheckColumn: true,
        // 전체 체크박스 표시 설정
        showRowAllCheckBox: true
    }

    var dropDragPros = {
        showRowCheckColumn: true,
        // 전체 체크박스 표시 설정
        showRowAllCheckBox: true,
        selectionMode: "multipleCells",
        enableDrag: true,
        enableMultipleDrag: true,
        // 셀에서 바로  드래깅 해 이동 가능 여부
        enableDragByCellDrag: true,
        // 드랍 가능 여부
        enableDrop: true
    }

    dialogColumnLayout.addColumn("sanctnLineSeqno", "결재라인일련번호", null, false); /*결재라인일련번호*/
    dialogColumnLayout.addColumn("deptCode", "부서코드", null, false); /*부서코드*/
    dialogColumnLayout.addColumn("deptNm", lang.C100000401, null, true); /*부서명*/
    dialogColumnLayout.addColumn("sanctnKndCode", "결재종류코드", null, false); /*결재종류코드*/
    dialogColumnLayout.addColumn("sanctnKndNm", lang.C100000160, null, true); /*결재종류*/
    dialogColumnLayout.addColumn("sanctnLineNm", lang.C100000164, null, true); /*결재라인명*/

    var dialogColumnLayout2 = [];
    auigridCol(dialogColumnLayout2);

    dialogColumnLayout2.addColumn("sanctnLineSeqno", "결재라인일련번호", null, false); /*결재라인일련번호*/
    dialogColumnLayout2.addColumn("deptNm", lang.C100000401, null, true);	/*부서명*/
    dialogColumnLayout2.addColumn("sanctnerId", "사용자ID", null, false); /*사용자ID*/
    dialogColumnLayout2.addColumn("userNm", lang.C100000452, null, true); /*사용자명*/

    var dialogColumnLayout3 = [];
    auigridCol(dialogColumnLayout3);

    dialogColumnLayout3.addColumn("sanctnLineSeqno", "결재라인일련번호", null, false); /*결재라인일련번호*/
    dialogColumnLayout3.addColumn("inspctInsttNm", lang.C100000401, null, true); /*부서명*/
    dialogColumnLayout3.addColumn("sanctnerId", "사용자ID", null, false); /*사용자ID*/
    dialogColumnLayout3.addColumn("userNm", lang.C100000452, null, true); /*사용자명*/
    dialogColumnLayout3.addColumn("sanctnSeCode", lang.C100000153, null, false); /*결재구분*/
    dialogColumnLayout3.addColumn("sanctnOrdr", lang.C100000166, null, false); /*결재순서*/
    sanctnSeCode = getGridComboList('/com/getCmmnCode.lims', { 'upperCmmnCode': 'CM02' }, true);
    dialogColumnLayout3.dropDownListRenderer(["sanctnSeCode"], sanctnSeCode, true);

    var html = createDialog(1300);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000156);
    var topright = "<span class=\"iArea\"></span>"
    var body = ""
        + "<div class='subCon1'>"
        + "<div class='btnWrap'>"
        + "<button type='button' id='" + btnSelect + "' class='btn5' >" + lang.C100000880 + "</button>" /*추가 */
        + "<button type='button' id='" + btnSearch + "' class='search btn1' >" + lang.C100000767 + "</button>&nbsp;" /*조회*/
        + "</div> <br>"
        + "<form id='sanctnLineSearchFrm' name='sanctnLineSearchFrm' onSubmit='return false;'>"
        + "<table cellpadding='0' cellspacing='0' width='100%' class='subTable1'>"
        + "<colgroup>"
        + "<col style='width:10%'/>"
        + "<col style='width:15%'/>"
        + "<col style='width:10%'/>"
        + "<col style='width:15%'/>"
        + "<col style='width:10%'/>"
        + "<col style='width:15%'/>"
        + "<col style='width:10%'/>"
        + "<col style='width:15%'/>"
        + "<tr>"
            + "<th class='taCt vaMd'>" + lang.C100000400 + "</th>" /*부서*/
            + "<td>"
                + "<select  id='" + cboDeptS + "'  name = '" + cboDeptS + "'  class='wd100p'>"
            + "</td>"
            + "<th class='taCt vaMd'>" + lang.C100000160 + "</th>" /*결재 종류*/
            + "<td>"
                + "<select name='" + cboSanctnKndS + "' id='" + cboSanctnKndS + "' class='wd100p'></select>"
            + "</td>"
            + "<th class='taCt vaMd'>" + lang.C100000155 + "</th>" /*결재 라인명*/
            + "<td>"
                + "<input type='text' name='" + cboSanctnLineNmS + "' id='" + cboSanctnLineNmS + "' class='searchClass wd100p'>"
            + "</td>"
            + "<td></td>"
            + "<td></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div class='subCon2'>"
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:150px; margin:0 auto;'></div>"
        + "</div>"
        + "<div>"
        + "<div class='wd45p' style='float:left; margin-top:30px;'>"
        + "<div class='subCon1'>"
        + "<h3 style='margin-bottom: 10px; width: 200px; display: inline-block'>" + lang.C100000782 + "</h3>" /*전체사용자 목록*/
        + "<div class='btnWrap' style='display: inline-block; width: 30%'>"
        + "<button type=\"button\" id='" + btnUserSearch + "'  style=\"margin-left:5px; float: right\"  class=\"search\">" + lang.C100000767 + "</button>" /*조회*/
        + "</div>"
        + "<table class=\"subTable1\" style=\"width:100%;\">"
        + "<colgroup>"
        + "<col style=\"width: 7%\"></col>"
        + "<col style=\"width: 10%\"></col>"
        + "<col style=\"width: 7%\"></col>"
        + "<col style=\"width: 10%\"></col>"
        + "<col style=\"width: 7%\"></col>"
        + "<col style=\"width: 10%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C100000401 + "</th> <!-- 부서 명 -->"
        + "<td><select id=\"" + userDeptCode + "\" class=\"wd100p\"></select></td>"
        + "<th>" + lang.C100000452 + "</th> <!-- 사용자 명 -->"
        + "<td><input type=\"text\"  id=\"" + userNmSch + "\" name=\"" + userNmSch + "\"></td>"
        + "</tr>"
        + "</table>"
        + "</div>"
        + "<div class='subCon2'>"
        + "<div class='content'>"
        + "<div id='main_wrap'>"
        + "<div id='top_wrap'>"
        + "<div class='mgT15'>"
        + "<div id='" + userDialogGridID + "' style='width:100%; height:150px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "<div class='arrowWrap wd10p mgT10' style='float: left;'>"
        + "<div>"
        + "<button type='button' id='" + btnRight + "'><i class='fi-rr-angle-right'></i></button>"
        + "</div>"
        + "<div style='margin-top:10%;'>"
        + "<button type='button' id='" + btnLeft + "'><i class='fi-rr-angle-left'></i></button>"
        + "</div>"
        + "</div>"
        + "<div class='wd45p' style='float:left; margin-top:30px;'>"
        + "<div class='subCon1'>"
        + "<h3>" + lang.C100000481 + "</h3>"  /* 선택 결재자 목록 */
        + "<div class='btnWrap'>"
        //						+ "<button type='button' id='"+btnUp+"' class='btn1'>"+lang.C000000668+"</button>&nbsp;" /*UP*/
        //						+ "<button type='button' id='"+btnDown+"' class='btn1'>"+lang.C000000669+"</button>" /*DOWN*/
        + "</div>"
        + "</div>"
        + "<div class='subCon2'>"
        + "<div class='content'>"
        + "<div id='main_wrap'>"
        + "<div id='top_wrap'>"
        + "<div class='mgT15'>"
        + "<div id='" + customerDialogGridID + "' style='width:100%; height:202px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {

        // session bplc code
        var bplcCode = document.querySelector('#layoutUserBplcCode').value;

        // 부서
        ajaxJsonComboBox('/wrk/getDeptComboList.lims', cboDeptS, { 'bestInspctInsttCode': bplcCode }, true, null, data.dept);
        ajaxJsonComboBox('/wrk/getDeptComboList.lims', userDeptCode, { 'bestInspctInsttCode': bplcCode }, true, null, data.dept);
        // 결재종류
        ajaxJsonComboBox('/com/getCmmnCode.lims', cboSanctnKndS, { 'upperCmmnCode': 'CM05' }, false, null, sanctnKndCode);

        AUIGrid.resize(dialogGridID);
        AUIGrid.resize(userDialogGridID);
        AUIGrid.resize(customerDialogGridID);

    }, preOpenFunc);

    dialogGridID = createAUIGrid(dialogColumnLayout, dialogGridID);
    userDialogGridID = createAUIGrid(dialogColumnLayout2, userDialogGridID, gridPros);
    customerDialogGridID = createAUIGrid(dialogColumnLayout3, customerDialogGridID, dropDragPros);

    // 결재라인 조회 함수
    function getSanctnList() {
        var param = {
            cboDeptS: $("#sanctnLineSearchFrm #cboDeptS_" + dialogId).val(),
            cboSanctnKndS: $("#sanctnLineSearchFrm #cboSanctnKndS_" + dialogId).val(),
            useYnS: "Y",
            sanctnLineNmSch: $("#sanctnLineSearchFrm #cboSanctnLineNmS_" + dialogId).val(),
        }

        getGridDataParam("/wrk/getSanctnLineList.lims", param, dialogGridID);
    }

    // 사용자 조회 함수
    function getUserNmList() {
        var selectedItem = AUIGrid.getSelectedItems(dialogGridID);
        // Question..
        var selectedSeq = selectedItem.length == 0 ? null : selectedItem[0].item.sanctnLineSeqno;

        return $.when(
            getGridDataParam("/wrk/getUserAList.lims", {
                userNmS: $("#userNmSch" + dialogId).val(),
                sanctnLineSeqno: selectedSeq,
                userDeptCode: document.querySelector('#' + userDeptCode).value,
            }, userDialogGridID)

        ).then(function (data) {
            var compareData = AUIGrid.getGridData(customerDialogGridID);

            if (compareData.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    for (var j = 0; j < compareData.length; j++) {
                        if (data[i].userId == compareData[j].userId) {

                            // 특정 컬럼의 값과 일치하는 값이 있는 행을 모두 찾아 rowIndex를 반환
                            var getIndex = AUIGrid.getRowIndexesByValue(userDialogGridID, "userId", [compareData[j].userId]);

                            /*
                             * 행이 삭제될 때마다 rowIndex는 하나씩 당겨지므로
                             * rowIndex로, i가 아닌 직접 찾은 행 인덱스 값을 넣어줘야함.
                             *
                             * 잘못된 예 : AUIGrid.removeRow(userDialogGridID, i);
                             * */
                            AUIGrid.removeRow(userDialogGridID, getIndex);
                        }
                    }
                }
            }
        });
    }

    // 결재라인 조회btn click event
    $("#" + btnSearch).click(function () {
        getSanctnList();
    });

    // 사용자 조회btn click event
    $("#" + btnUserSearch).click(function () {
        getUserNmList();
    })

    // enter key event
    $("#cboSanctnLineNmS_sanctnDialog").keyup(function (e) {
        if (e.keyCode == 13) {
            getSanctnList();
        }
    });

    // enter key event
    $("#userNmSchsanctnDialog").keyup(function (e) {
        if (e.keyCode == 13) {
            getUserNmList();
        }
    });

    // 선택btn click event
    $("#" + btnSelect).click(function () {
        if (selectFunc != undefined && selectFunc != null) {
            var gridData = AUIGrid.getGridData(customerDialogGridID);
            var gridSelectedData = AUIGrid.getSelectedItems(dialogGridID);
            var bool = true;

            for (var i = 0; i < gridData.length; i++) {
                if (!gridData[i]["sanctnSeCode"]) {
                    bool = false;
                    break;
                }
                gridData[i].sanctnOrdr = (i + 1);
            }

            if (bool == false) {
                alert(lang.C100000161);  /* 결재구분을 입력해주세요. */
                return;
            }

            var params = {
                gridData: gridData,
                gridSelectedData: gridSelectedData
            };

            selectFunc(params);
        }

        $("#popupClose_" + dialogId).trigger("click");
    });

    // 전체사용자 => 결재자
    $("#" + btnRight).click(function () {
        moveGridData(userDialogGridID, customerDialogGridID, null, null, function (data) {
            // 임시적으로 주석합니다. 추후 기능 변경이 발생할수도 있음.
            // if (data.length > 1) {
            //     for (var i = 0; i < data.length; i++) {
            //
            //         // 최초결재자 : "검토"
            //         if (i === 0) {
            //             data[i].sanctnSeCode = "CM02000001";
            //
            //             // 최종결재자 : "승인"
            //         } else if (i == data.length - 1) {
            //             data[i].sanctnSeCode = "CM02000003";
            //         }
            //     }
            //
            //     // 결재자가 한명일 경우 : "승인"
            // } else if (data.length == 1) {
            //     data[0].sanctnSeCode = "CM02000003";
            // }
        });
    });

    // 결재자 => 전체사용자
    $("#" + btnLeft).click(function () {
        moveGridData(customerDialogGridID, userDialogGridID);
    });

    // $("#"+btnUp).click(function() {
    // 	AUIGrid.moveRowsToUp(customerDialogGridID);
    // });

    // $("#"+btnDown).click(function() {
    // 	AUIGrid.moveRowsToDown(customerDialogGridID);
    // });

    // 결재라인 cellClick event
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        getGridDataParam("/wrk/getUserAList.lims", {
            userNmS: $("#userNmSch" + dialogId).val(),
            sanctnLineSeqno: event.item.sanctnLineSeqno,
            userDeptCode: document.querySelector('#' + userDeptCode).value,
        }, userDialogGridID);

        /* 결재자 조회 후, 최초/최종 결재 구분 지정 */
        $.when(
            getGridDataParam("/wrk/getSanctnerList.lims", { sanctnLineSeqno: event.item.sanctnLineSeqno }, customerDialogGridID)

        ).then(function (data) {
            var colIndex = AUIGrid.getColumnIndexByDataField(customerDialogGridID, "sanctnSeCode");
            var len = data.length;

            if (len > 1) {
                for (var i = 0; i < len; i++) {

                    // 최초결재자 : "검토"
                    if (i == 0) {
                        AUIGrid.setCellValue(customerDialogGridID, i, colIndex, "CM02000001");

                        // 최종결재자 : "승인"
                    } else if (i == len - 1) {
                        AUIGrid.setCellValue(customerDialogGridID, i, colIndex, "CM02000003");
                    }
                }

                // 결재자가 한명일 경우 : "승인"
            } else if (len == 1) {
                AUIGrid.setCellValue(customerDialogGridID, 0, colIndex, "CM02000003");
            }
        });

    });

    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(userDialogGridID, "ready", function (event) {
        gridColResize(userDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

}

/**
 * 베포처 팝업
 * gbn : Y -> 팝업에서 바로 발송
 *		 N -> selectFunc 후 저장
 *
 * view : audit
 *        voc
 * 서비스에서 분기를 태워 각 테이블에 배포시퀀스를 저장해주기 위함.
 *
 * gridId : 본 화면의 gridId
 * 본 화면 그리드에서 선택된 행의 배포seqno를 들고와 배포대상자를 보여주기 위함.
 */
function dialogWdtb(btnId, data, gbn, view, gridId, dialogId, selectFunc, preOpenFunc) {
    var btnSearch = "btnSearch_" + dialogId
    var btnSelect = "btnSelect_" + dialogId
    var btnSave = "btnSave_" + dialogId
    var btnDelete = "btnDelete_" + dialogId
    var btnLeft = "btnLeft_" + dialogId
    var btnRight = "btnRight_" + dialogId
    var userDialogGridID = "grid2_" + dialogId;
    var customerDialogGridID = "grid3_" + dialogId;
    var wdtbTrgterDialogGridID = "grid4_" + dialogId;
    var btnUserSearch = "btnUserSearch" + dialogId
    var userNmSch = "userNmSch" + dialogId
    var cboDeptS = "cboDeptS_" + dialogId;

    $(document).ready(function () {
        createUserGrid();

        createCustomerGrid();

        createWdtbTrgterGrid();
    });

    function createUserGrid() {
        var dialogColumnLayout2 = [];
        auigridCol(dialogColumnLayout2);

        var gridPros = {
            showRowCheckColumn: true,
            // 전체 체크박스 표시 설정
            showRowAllCheckBox: true
        }

        // 전체 사용자 목록
        dialogColumnLayout2.addColumn("bplcCodeNm", lang.C100000432, null, true);  /* 사업장명 */
        dialogColumnLayout2.addColumn("deptCode", lang.C000000807, null, false); /*결재라인일련번호*/
        dialogColumnLayout2.addColumn("inspctInsttNm", lang.C100000401, null, true);	/*부서명*/
        dialogColumnLayout2.addColumn("userId", lang.C000000808, null, false); /*사용자ID*/
        dialogColumnLayout2.addColumn("userNm", lang.C100000451, null, true); /*사용자명*/
        dialogColumnLayout2.addColumn("email", null, null, false); /*이메일*/
        dialogColumnLayout2.addColumn("moblphon", null, null, false); /*이동전화*/

        userDialogGridID = createAUIGrid(dialogColumnLayout2, userDialogGridID, gridPros);
    }

    function createCustomerGrid() {
        var dialogColumnLayout3 = [];
        auigridCol(dialogColumnLayout3);

        var gridPros = {
            showRowCheckColumn: true,
            // 전체 체크박스 표시 설정
            showRowAllCheckBox: true
        }

        // 선택 배포지
        dialogColumnLayout3.addColumn("deptCode", lang.C000000807, null, false); /*결재라인일련번호*/
        dialogColumnLayout3.addColumn("inspctInsttNm", lang.C100000401, null, true); /*부서명*/
        dialogColumnLayout3.addColumn("userId", lang.C100000971, null, false); /*사용자ID*/
        dialogColumnLayout3.addColumn("userNm", lang.C100000451, null, true); /*사용자명*/
        dialogColumnLayout3.addColumn("email", lang.C100000669, null, true); /*이메일*/
        dialogColumnLayout3.addColumn("moblphon", lang.C100000668, null, true); /*이동전화*/
        dialogColumnLayout3.addColumn("emailTrnsmisAt", lang.C100000670, null, true); /*이메일 전송 여부*/
        dialogColumnLayout3.addColumn("chrctrTrnsmisAt", lang.C100000328, null, true); /*문자 전송 여부*/
        dialogColumnLayout3.checkBoxRenderer(["emailTrnsmisAt"], customerDialogGridID, { check: "Y", unCheck: "N" })
        dialogColumnLayout3.checkBoxRenderer(["chrctrTrnsmisAt"], customerDialogGridID, { check: "Y", unCheck: "N" })

        customerDialogGridID = createAUIGrid(dialogColumnLayout3, customerDialogGridID, gridPros);
    }

    function createWdtbTrgterGrid() {
        var wdtbTrgterColumnLayout = [];
        auigridCol(wdtbTrgterColumnLayout);

        var gridPros = {
            showRowCheckColumn: true,
            showRowAllCheckBox: true
        };

        // 배포대상자 이력
        wdtbTrgterColumnLayout.addColumn("userId", lang.C000000808, null, false); /* 사용자ID */
        wdtbTrgterColumnLayout.addColumn("userNm", lang.C100000451, null, true);  /* 사용자명 */
        wdtbTrgterColumnLayout.addColumn("chrctrTrnsmisAt", lang.C100000328, null, true); /* 문자 전송 여부 */
        wdtbTrgterColumnLayout.addColumn("chrctrTrnsmisComptAt", lang.C100000329, null, true); /* 문자 전송 완료 여부 */
        wdtbTrgterColumnLayout.addColumn("emailTrnsmisAt", lang.C100000670, null, true); /* 이메일 전송 여부 */
        wdtbTrgterColumnLayout.addColumn("emailTrnsmisComptAt", lang.C100000672, null, true); /* 이메일 전송 완료 여부 */

        wdtbTrgterDialogGridID = createAUIGrid(wdtbTrgterColumnLayout, wdtbTrgterDialogGridID, gridPros);
    }

    var html = createDialog(1200);
    html = html.replace(/#dialogId#/g, dialogId);

    var title = lang.C100000362; /* 배포 */

    html = html.replace(/#title#/g, title);
    var topright = "<span class=\"iArea\"></span>"
    var body =
        "<div class='btnWrap'  style='float: right';>"
        + "</div> <br>"
        + "<div style='display:inline-block;' class='wd100p'>"
        + "<div class='wd45p fL'>"
        + "<div class='subCon1'>"
        + "<h3 style='margin-bottom: 10px;'>" + lang.C100000782 + "</h3>" /*전체사용자 목록*/
        + "<span class=\"iArea\"></span>"
        + "<input type=\"text\" id=\"inspctInsttNmSch\" name=\"inspctInsttNmSch\" class=\"searchClass wd44p\" placeholder=\"" + lang.C100000401 + "\">"
        + "<input type=\"text\" id=\"userNmSch\" name=\"userNmSch\" class=\"searchClass wd44p\" placeholder=\"" + lang.C100000452 + "\">"
        + "</span>"
        + "<div class='btnWrap'>"
        + "<button type=\"button\" id='" + btnUserSearch + "'  style=\"margin-left:5px;  margin-top:31px;\"  class=\"search\">" + lang.C100000767 + "</button>" /*조회*/
        + "</div>"
        + "</div>"
        + "<div class='subCon2'>"
        + "<div class='mgT15'>"
        + "<div id='" + userDialogGridID + "' style='width:100%; height:285px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"

        + "<div class='arrowWrap wd10p mgT60' style='float: left;'>"
        + "<div>"
        + "<button type='button' id='" + btnRight + "'><i class='fi-rr-angle-right'></i></button>"
        + "</div>"
        + "<div style='margin-top:10%;'>"
        + "<button type='button' id='" + btnLeft + "'><i class='fi-rr-angle-left'></i></button>"
        + "</div>"
        + "</div>"

        + "<div class='wd45p fL'>"
        + "<div class='subCon1'>"
        + "<h3>" + lang.C100000482 + "</h3>" /* 선택 배포처 */
        + "<div class='btnWrap'>"
        + "<button type='button' id='" + btnSelect + "' class='btn5' >" + lang.C100000480 + "</button>" /*선택*/
        + "<button type='button' id='" + btnSave + "' class='save' >" + lang.C100000352 + "</button>" /*발송*/
        + "</div>"
        + "</div>"
        + "<div class='subcon2'>"
        + "<div class='mgT15'>"
        + "<div id='" + customerDialogGridID + "' style='width:100%; height:315px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "<div class='subCon1' style='display: none;'>"
        + "	<table class='subTable1' style='width:100%;'>"
        + "		<tr>"
        + "			<th>" + lang.C100000802 + "</th>" /* 제목 */
        + "			<td >"
        + "				<textarea id='" + dialogId + "sj' class='wd100p' name = '" + dialogId + "sj'></textarea>"
        + "			</td>"
        + "			<th>" + lang.C100000259 + "</th>" /* 내용 */
        + "			<td >"
        + "				<textarea id='" + dialogId + "cn' class='wd100p' name = '" + dialogId + "cn'></textarea>"
        + "			</td>"
        + "		</tr>"
        + "	</table>"
        + "</div>"
        + "<div class='subCon1 mgT10'>"
        + "<h3>" + lang.C100000363 + "</h3>" /* 배포 대상자 이력 */
        + "<div class='btnWrap'>"
        + "<button type='button' id='" + btnDelete + "' class='delete' >" + lang.C100000458 + "</button>" /* 삭제 */
        + "</div>"
        + "</div>"
        + "<div class='subcon2'>"
        + "<div class='mgT15'>"
        + "<div id='" + wdtbTrgterDialogGridID + "' style='width:100%; margin:0 auto;'></div>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        $("#" + dialogId + "cn").val($("#wdtbCn").val());
        $("#" + dialogId + "sj").val($("#wdtbSj").val());
        AUIGrid.clearGridData(customerDialogGridID);
        AUIGrid.resize(userDialogGridID);
        AUIGrid.resize(customerDialogGridID);
        AUIGrid.resize(wdtbTrgterDialogGridID);

        getUserList();
        getWdtbTrgterList();
        btnController();

    }, preOpenFunc);

    // 전체사용자 조회
    function getUserList() {
        var params = {
            bestInspctInsttCodeSch: $("#popup_" + dialogId + " #bestInspctInsttCodePopSch").val(),
            inspctInsttNmSch: $("#popup_" + dialogId + " #inspctInsttNmSch").val(),
            userNmSch: $("#popup_" + dialogId + " #userNmSch").val()
        };

        if (!!data) {
            /*
             *  수정자 : 박건우
             *  전체사용자 조회 시, 배포처에 추가한 사용자는 제외하고 조회..
             */
            var gridData = AUIGrid.getGridData(customerDialogGridID);
            var array = new Array();

            for (var i = 0; i < gridData.length; i++) {
                array[i] = gridData[i]["userId"];
            }

            params.userIdList = array;
        }

        getGridDataParam("/com/getPopUpRqesterNmList.lims", params, userDialogGridID);
    }

    // 배포대상자 이력 조회
    function getWdtbTrgterList() {
        var url = "/com/getWdtbTrgterList.lims";

        if (view == "vocCntrplnFoundng") {
            wdtbSeqno = $("#cntrplnFoundngWdtbSeqno").val();
        } else if (view == "vocValidVrify") {
            wdtbSeqno = $("#validVrifyWdtbSeqno").val();
        } else {
            wdtbSeqno = $("#wdtbSeqno").val();  // 본 화면 그리드 선택 cell의 배포일렬번호
        }

        var param = {
            wdtbSeqno: wdtbSeqno
        };

        getGridDataParam(url, param, wdtbTrgterDialogGridID);
    }

    // 팝업에서 바로 저장할지 여부에 따른 버튼 showing
    function btnController() {
        if (gbn == "Y") {
            $("#" + btnSave).show();
            $("#" + btnSelect).hide();
        } else {
            $("#" + btnSave).hide();
            $("#" + btnSelect).show();
        }
    }

    // enter key event
    $(".searchClass").keypress(function (e) {
        if (e.which == 13)
            getUserList();
    });

    // 전체사용자목록 조회btn click event
    $("#" + btnUserSearch).click(function () {
        getUserList();
    })

    // 배포처 선택btn click event (selectFunc후 저장 시..)
    $("#" + btnSelect).click(function () {
        var gridData = AUIGrid.getGridData(customerDialogGridID);
        if (gridData.length < 1) {
            alert(lang.C100000984); /* 사용자를 선택해주십시오. */
            return false;
        }

        var params = {
            gridData: gridData
        };
        for (var i = 0; i < gridData.length; i++) {
            if (gridData[i].emailTrnsmisAt == 'N' && gridData[i].chrctrTrnsmisAt == 'N') {
                alert(lang.C100000671);  /* 이메일 전송 여부/문자 전송 여부 중 한가지를 체크해 주십시오. */
                return false;
            }
        }

        if (selectFunc != undefined && selectFunc != null) {
            selectFunc(params);
        }
        $("#popupClose_" + dialogId).trigger("click");
    });

    // 발송btn click 함수 (팝업에서 바로 발송 처리 시..)
    $("#" + btnSave).click(function () {

        /* 발송 버튼 클릭 시 메일 발송기능 추가해야함 */
        var url = "/com/insWdtb.lims";
        var gridData = AUIGrid.getGridData(customerDialogGridID);  // 배포처 grid data
        var seqNo = "";
        var wdtbSeqno = $("#wdtbSeqno").val();  // 이제부터 배포 일렬번호는 각 화면 hidden값으로 가져옴

        if (gridData.length < 1) {
            alert(lang.C100000984); /* 사용자를 선택해주십시오. */
            return false;
        }

        for (var i = 0; i < gridData.length; i++) {
            if (gridData[i].emailTrnsmisAt == 'N' && gridData[i].chrctrTrnsmisAt == 'N') {
                alert(lang.C100000671);  /* 이메일 전송 여부/문자 전송 여부 중 한가지를 체크해 주십시오. */
                return false;
            }
        }

        // 각 화면 pk값도 화면의 hidden 값으로 가져옴
        if (view == "audit") {
            seqNo = $("#auditSeqno").val();
        } else if (view == "vocRegist") {
            seqNo = $("#vocRegistSeqno").val();
        } else if (view == "vocCntrplnFoundng") {
            seqNo = $("#vocCntrplnFoundngSeqno").val();
            wdtbSeqno = $("#cntrplnFoundngWdtbSeqno").val()
        } else if (view == "vocValidVrify") {
            seqNo = $("#vocValidVrifySeqno").val();
            wdtbSeqno = $("#validVrifyWdtbSeqno").val()
        } else if (view == "pcn") {
            seqNo = $("#pcnSeqno").val();
        }

        var data = {
            customerList: gridData
            , view: view
            , seqNo: seqNo
            , cn: $("#" + dialogId + "cn").val()
            , sj: $("#" + dialogId + "sj").val()
            , wdtbSeqno: wdtbSeqno
        }

        customAjax({
            "url": url,
            "data": data,
            "successFunc": function (data) {
                if (data != 0) {
                    alert(lang.C100000762);  /* 저장 되었습니다. */
                    selectFunc();
                    $('#popupClose_' + dialogId).trigger('click');
                } else {
                    alert(lang.C100000597);  /* 저장에 실패하였습니다. */
                }
            }
        });

        $("#popupClose_" + dialogId).trigger("click");

    });

    // 배포대상자이력 삭제btn click event
    $("#" + btnDelete).click(function () {
        var url = "/com/delTrgterList.lims";
        var chkTrgterData = AUIGrid.getCheckedRowItemsAll(wdtbTrgterDialogGridID);  // checked dataList

        var data = {
            chkTrgterData: chkTrgterData
        }

        if (chkTrgterData.length == 0) {
            alert(lang.C100000467);  /* 삭제할 데이터가 없습니다. */
            return false;
        }

        // 문자/이메일 전송완료한 이력은 삭제방지
        for (var i = 0; i < chkTrgterData.length; i++) {
            if (chkTrgterData[i].chrctrTrnsmisComptAt == "Y" || chkTrgterData[i].emailTrnsmisComptAt == "Y") {
                alert(lang.C100000330);  /* 문자 혹은 메일이 전송된 이력은 삭제할 수 없습니다. */
                return false;
            }
        }

        customAjax({
            "url": url,
            "data": data,
            "successFunc": function (data) {
                if (data != 0) {
                    alert(lang.C100000462);  /* 삭제 되었습니다. */
                    getWdtbTrgterList();
                } else {
                    alert(lang.C100000464);  /* 삭제에 실패하였습니다. */
                }
            }
        });
    });

    // 사용자 => 배포처
    $("#" + btnRight).click(function () {
        moveGridData(userDialogGridID, customerDialogGridID, null, null, function (dataArray) {
            console.log(dataArray);
            for (var i = 0; i < dataArray.length; i++) {
                // default check value 지정
                dataArray[i].emailTrnsmisAt = "Y";
                dataArray[i].chrctrTrnsmisAt = "N";
            }
        });
    });

    // 배포처 => 사용자
    $("#" + btnLeft).click(function () {
        moveGridData(customerDialogGridID, userDialogGridID);
    });


    AUIGrid.bind(userDialogGridID, "ready", function (event) {
        //			gridColResize(userDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(customerDialogGridID, "ready", function (event) {
        //			gridColResize(customerDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });
}

/**
 * 
 * 반려 사유 공통 dialog
 * 
 * [params 구조] 
 * params {
 *     btnId : dialog click button id
 *     functions : {
 *         getExmntSeqno() : 검토 일련번호를 return하는 function
 *         getOtherKey() : 품질보증 및 검토를 이용하는 모든메뉴의 primary key seqno를 return하는 function
 *         init() : 검토처리 후 main page초기화 하는 function 
 *     }
 *     dialogId : dialog 고유 id
 *     parentGridId : main page grid 
 *     functions : {
 *         getSanctnSeqno : 결재 seqno를 return하는 function. type parameter가 form일때 사용
 *         ,callback : 반려사유 정보를 return받을 function 
 *     }
 *     type - 
 *          1. grid에서 체크된 항목들을 반려하는가 ? 'grid'
 *          2. 입력 form의 data를 반려하는가 ? 'form'
 * }
 * 
 * @param params params
 * @author shs
 */
function dialogRtnSanctn(params) {
    
    var btnId = params.btnId;
    var parentGridId = params.parentGridId;
    var functions = params.functions;
    var dialogId = params.dialogId;
    var type = params.type;
    var dialogFormId = dialogId +"Form";
    var dialogBtnResetId = dialogId +"BtnReset";
    var dialogBtnReturnId = dialogId +"BtnReturn";
    var dialogGridId = "grid_" + dialogId;

    initialDialog();
    var dialogSaveFormEl = document.querySelector('#' + dialogFormId);

    function initialDialog() {
        createHtml();
        buildGrid();
        setButtonEvent();
    }
    
    popupInit(btnId, dialogId, function () {
        dialogSaveFormEl.reset();
        AUIGrid.resize(dialogGridId);

        var param;
        if (type === 'grid') {
            var gridData = AUIGrid.getCheckedRowItemsAll(parentGridId);
            if (dialogId == "reqRtnDialog") {
                param = {
                    reqestSeqnoList: gridData.map(function (obj) {
                        return obj.reqestSeqno;
                    })
                };
            } else {
                param = {
                    sanctnSeqnoList: gridData.map(function (obj) {
                        return obj.sanctnSeqno;
                    })
                };
            }
        } else if (type === 'form') {
            param = {
                sanctnSeqno: functions.getSanctnSeqno()
            };
        } else {
            throw 'dialog type이 정확하지 않습니다.';
        }

        if (dialogId == "reqRtnDialog")
            customAjax({
                url: "/req/getReqRtnInfo.lims",
                data: param,
                successFunc: function(data) {
                    if (data)
                        AUIGrid.setGridData(dialogGridId, data);
                }
            });
        else
            getGridDataParam("/qa/getRtn.lims", param, dialogGridId);
    });

    function buildGrid() {
        
        var gridRtnRecCol = [];
        auigridCol(gridRtnRecCol);
    
        gridRtnRecCol.addColumnCustom("rtnResn", "반려사유");
        gridRtnRecCol.addColumnCustom("returnerNm", "반려자");
        
        dialogGridId = createAUIGrid(gridRtnRecCol, dialogGridId);
    
        AUIGrid.bind(dialogGridId, "cellDoubleClick", function (event) {
            dialogSaveFormEl.querySelector('[name=rtnResn]').value = event.item.rtnResn;
            btnControll('none');
        });
    }

    function btnControll(display) {
        document.querySelector('#' + dialogBtnReturnId).style.display = display;
    }

    function setButtonEvent() {

        document.querySelector('#' + dialogBtnResetId).addEventListener('click', function () {
            btnControll('');
            dialogSaveFormEl.reset();
        });
        
        document.querySelector('#' + dialogBtnReturnId).addEventListener('click', function () {

            if (!saveValidation(dialogSaveFormEl.id)) return; 
            
            if (confirm('반려 하시겠습니까 ?')) {
                functions.callback(dialogSaveFormEl.toObject());
                $("#popupClose_" + dialogId).trigger("click");
            }
        });
    }
    
    function createHtml() {
        var html = createDialog(600);
            html = html.replace(/#dialogId#/g, dialogId);
            html = html.replace(/#title#/g, '반려');
            html = html.replace(/#flexbox#/g, "");
            html = html.replace(/#sameline#/g, "");
            
        var topright = 
            "<div class=\"btnWrap\" style=\"position: inherit\">" +
                "<button type=\"button\" id='"+ dialogBtnResetId +"' class=\"btn4\">" + "초기화" + "</button>" +
                "<button type=\"button\" id='"+ dialogBtnReturnId +"' class=\"save\">" + "반려" + "</button>" +
            "</div>";
        
        var body = 
                "<div class='subCon1 mgT5'>" +
                    "<form id='"+ dialogFormId +"' onsubmit='return false;'>" +
                    "<table class='subTable1'>" +
                        "<colgroup>" +
                            "<col style='width:15%'/>" +
                            "<col style='width:85%'/>" +
                        "</colgroup>" +
                        "<tr>" +
                            "<th class='necessary' style='text-align:center;'>" + "반려사유" + "</th>" +
                            "<td colspan='5'>" +
                                "<textarea cols='100' rows='10' name='rtnResn' class='wd100p' style='min-width:10em;' required></textarea>" +
                            "</td>" +
                        "</tr>" +
                    "</table>" +
                    "</form>" +
                "</div>" +
                "<div class='subCon2'>" +
                    "<div id='" + dialogGridId + "' style='height:270px;'></div>" +
                "</div>";
        
        html = html.replace(/#topright#/g, topright);
        html = html.replace(/#body#/g, body);
        $("#sub_wrap").append(html);
    }
}

/**
 * 의뢰 팝업
 * @param btnId
 * @param dialogId
 * @param selectFunc
 * @param prePopupOpenFunc
 * @param flag
 * @returns
 */
function requestDialog(btnId, dialogId, data, selectFunc) {
    var gridProperties = {
        "showRowCheckColumn": false
    };

    var requestDialogColumnLayout = [];
    auigridCol(requestDialogColumnLayout);


    requestDialogColumnLayout.addColumn("reqestSeqno", lang.C000000724, "*", false); /*의뢰 일련번호*/
    requestDialogColumnLayout.addColumn("lotId", lang.C000000575, "*", true); /*Lot ID*/
    requestDialogColumnLayout.addColumn("reqestDte", lang.C000000576, "*", true); /*의뢰 일자*/
    requestDialogColumnLayout.addColumn("reqestDeptCode", lang.C000000080, "*", false); /*부서*/
    requestDialogColumnLayout.addColumn("reqestDeptNm", lang.C000000080, "*", true); /*부서*/
    requestDialogColumnLayout.addColumn("prductSeqno", lang.C000000726, "*", false); /*제품 일련번호*/
    requestDialogColumnLayout.addColumn("prdlstNm", lang.C000000211, "*", true); /*제품 명*/

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(500);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, ""); /*■ ROHS 목록*/
    var topright = "";
    var body = "";
    body += '<form id="requestPopForm">';
    body += '<div class="subCon1 mgT15" id="detail">';
    body += '<h2>' + lang.C000000735 + '</h2>'; /*의뢰 목록*/
    body += '<div class="btnWrap">';
    body += '<button type="button" id="btn_PopRequestSearch"  class=\"btn1\">' + lang.C000000002 + '</button>'; /*조회*/
    body += '</div>';
    body += '<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">';
    body += '<colgroup>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '</colgroup>';
    body += '<tr>';
    body += '<th>' + lang.C000000575 + '</th>'; /*Lot ID*/
    body += '<td>';
    body += '<input type="text" id="popShrLotID" name="popShrLotID"  class="wd100p" style="min-width:10em;">';
    body += '</td>';
    body += '<th>' + lang.C000000319 + '</th>'; /*제품*/
    body += '<td>';
    body += '<input type="text" id="popShrPrductNm" name="popShrPrductNm" class="wd100p" style="min-width:10em;">';
    body += '</td>';
    body += '</tr>';
    body += '</table>';
    body += '</div>';
    body += '</div>';
    body += '<div class="subCon1 mgT15" id="detail2">';
    body += '<div id="grid_' + dialogId + '" class="mgT15" style="width:100%; margin:0 auto;"></div>';
    body += '</div>';
    body += '</form>';

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        //		getRequestList();
    });

    dialogGridID = createAUIGrid(requestDialogColumnLayout, dialogGridID, gridProperties);

    function getRequestList() {
        if (!$("#popShrLotID").val() && !$("#popShrPrductNm").val()) {
            alert("LOT ID나 제품명을 입력해 주세요.");
            return;
        }
        getGridDataParam("/req/getReqList.lims", { lotId: $("#popShrLotID").val(), prdlstNm: $("#popShrPrductNm").val() }, dialogGridID);
    }

    $("#popup_" + dialogId + " #btn_PopRequestSearch").click(function () {
        getRequestList();
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    //엔터키 이벤트
    $("#requestPopForm [type=text]").keypress(function (e) {
        if (e.which == 13) {
            getRequestList();
        }
    });

    //그리드 더블클릭
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        if (selectFunc != undefined && selectFunc != null) {
            selectFunc(event.item);
            $("#popupClose_" + dialogId).trigger("click");
        }

    });
}

/**
 * 이슈 목록 팝업
 * @param btnId
 * @param dialogId
 * @param selectFunc
 * @param prePopupOpenFunc
 * @param flag
 * @returns
 */
function dialogIssueList(btnId, dialogId, data, selectFunc) {
    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(700);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000001275); /*■ 이슈 목록*/
    var topright = "";
    var body = "";
    body += '<div class="subCon1 mgT15" id="detail2">';
    body += '<div id="grid_' + dialogId + '" class="mgT15" style="width:100%; margin:0 auto;"></div>';
    body += '</div>';

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    var columnLayout = {
        pedigeePGridCol: []
    };

    // 사용량 그리드
    auigridCol(columnLayout.pedigeePGridCol);
    columnLayout.pedigeePGridCol.addColumnCustom("issueSeqno", lang.C000000697, "*", true); //이슈번호
    columnLayout.pedigeePGridCol.addColumnCustom("innerIssueNm", lang.C000000701, "*", true); //내부 이슈 여부
    columnLayout.pedigeePGridCol.addColumnCustom("improptTyNm", lang.C000000702, "*", true); //부적합 유형
    columnLayout.pedigeePGridCol.addColumnCustom("issueSeNm", lang.C000000704, "*", true); //이슈 구분
    columnLayout.pedigeePGridCol.addColumnCustom("issueSj", lang.C000000463, "*", true); //제목
    columnLayout.pedigeePGridCol.addColumnCustom("reqestDeptCode", "reqestDeptCode", "*", false); //제조
    columnLayout.pedigeePGridCol.addColumnCustom("reqestDeptNm", lang.C000000080, "*", true); //제조
    columnLayout.pedigeePGridCol.addColumnCustom("processTyCode", lang.C000000213, "*", false); //프로세스 타입
    columnLayout.pedigeePGridCol.addColumnCustom("processTyNm", lang.C000000213, "*", true); //프로세스 타입
    columnLayout.pedigeePGridCol.addColumnCustom("prductSeqno", lang.C000000319, "*", false); //제품
    columnLayout.pedigeePGridCol.addColumnCustom("prductNm", lang.C000000319, "*", true); //제품
    columnLayout.pedigeePGridCol.addColumnCustom("expriemCn", lang.C000000320, "*", true); //시험항목
    columnLayout.pedigeePGridCol.addColumnCustom("sanctnSeqno", "sanctnSeqno", "*", false); //상태
    columnLayout.pedigeePGridCol.addColumnCustom("jdgmntWordCode", "jdgmntWordCode", "*", false); //이슈유형
    columnLayout.pedigeePGridCol.addColumnCustom("jdgmntWordNm", lang.C000000699, "*", false); //이슈유형
    columnLayout.pedigeePGridCol.addColumnCustom("lastChangerId", "lastChangerI", "*", false); //등록자
    columnLayout.pedigeePGridCol.addColumnCustom("lastChangerNm", "lastChangerN", "*", false); //등록자
    columnLayout.pedigeePGridCol.addColumnCustom("issueRegistDt", lang.C000000114, "*", true); //등록일
    columnLayout.pedigeePGridCol.addColumnCustom("innerIssueAt", lang.C000000701, "*", false); //내부 이슈 여부
    columnLayout.pedigeePGridCol.addColumnCustom("improptTyCode", "improptTyCode", "*", false); //부적합 유형
    columnLayout.pedigeePGridCol.addColumnCustom("issueSeCode", "issueSeCode", "*", false); //이슈 구분
    columnLayout.pedigeePGridCol.addColumnCustom("lotId", lang.C000000575, "*", false); //LOT ID
    columnLayout.pedigeePGridCol.addColumnCustom("reqestSeqno", lang.C000000715, "*", false); //의뢰 일련번호
    columnLayout.pedigeePGridCol.addColumnCustom("issueCn", lang.C000000715, "*", false); //이슈 처리 내용
    columnLayout.pedigeePGridCol.addColumnCustom("issueRegisterId", "issueRegisterId", "*", false); //이슈 등록자
    columnLayout.pedigeePGridCol.addColumnCustom("issueRegisterNm", lang.C000000703, "*", false); //이슈 등록자

    dialogGridID = createAUIGrid(columnLayout.pedigeePGridCol, dialogGridID);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        getExprDiaryInfo();
    });

    function getExprDiaryInfo() {
        var reqestSeqno = $("#reqestSeqno").val();
        if (!!reqestSeqno) {
            customAjax({
                "url": "/test/getIssueMList.lims",
                "data": { "reqestSeqno": reqestSeqno }
            }).then(function (data) {
                AUIGrid.setGridData(dialogGridID, data);
            });

            /*
            ajaxJsonParam3("/test/getIssueMList.lims", {"reqestSeqno" : reqestSeqno}, function(data){
                AUIGrid.setGridData(dialogGridID, data);
            });
            */
        }
    }

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "1");	// 1, 2가 있으니 화면에 맞게 적용
    });
}

//기기 일상점검 의뢰 추가 팝업
function mrlsChkRequestDialog(btnId, dialogId, data, selectFunc) {
    var gridProperties = {
        "showRowCheckColumn": true
    };

    var requestDialogColumnLayout = [];
    auigridCol(requestDialogColumnLayout);

    requestDialogColumnLayout.addColumn("reqestSeqno", lang.C000000724, "*", false); /*의뢰 일련번호*/
    requestDialogColumnLayout.addColumn("lotId", lang.C000000575, "*", true); /*Lot ID*/
    requestDialogColumnLayout.addColumn("prductUpperNm", lang.C000000211, "*", true); /*제품 명*/
    requestDialogColumnLayout.addColumn("prductNm", lang.C000000228, "*", true); /*자재 명*/
    requestDialogColumnLayout.addColumn("reqestDte", lang.C000000576, "*", true); /*의뢰 일자*/
    requestDialogColumnLayout.addColumn("reqestDeptCode", lang.C000000080, "*", false); /*부서*/
    requestDialogColumnLayout.addColumn("reqestDeptNm", lang.C000000080, "*", true); /*부서*/
    requestDialogColumnLayout.addColumn("prductSeqno", lang.C000000726, "*", false); /*제품 일련번호*/
    requestDialogColumnLayout.addColumn("inspctCrrctSeCodeNm", lang.C000000885, "*", true); /*검사교정 구분*/

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, ""); /*■ ROHS 목록*/
    var topright = "";
    var body = "";
    body += '<form id="requestPopForm">';
    body += '<div class="subCon1 mgT15" id="detail">';
    body += '<h2>' + lang.C000000735 + '</h2>'; /*의뢰 목록*/
    body += '<div class="btnWrap">';
    body += '<button type="button" id="btn_PopRequestAdd"  class=\"btn4\">' + lang.C000000504 + '</button>'; /*추가*/
    body += '<button type="button" id="btn_PopRequestSearch"  class=\"btn3\">' + lang.C000000002 + '</button>'; /*조회*/
    body += '</div>';
    body += '<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">';
    body += '<colgroup>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '<col style="width:10%"></col>';
    body += '<col style="width:15%"></col>';
    body += '</colgroup>';
    body += '<tr>';
    body += '<th>' + lang.C000000080 + '</th>'; /*부서*/
    body += '<td>';
    body += '<select id="popShrDeptCode" name="popShrDeptCode"  class="wd100p" style="min-width:10em;"></select>';
    body += '</td>';
    body += '<th>' + lang.C000000734 + '</th>'; /*타입*/
    body += '<td>';
    body += '<select id="popShrProcessTyCode" name="popShrProcessTyCode"  class="wd100p" style="min-width:10em;"></select>';
    body += '</td>';
    body += '<th>' + lang.C000000319 + '</th>'; /*제품*/
    body += '<td>';
    body += '<select id="popShrPrductUpperSeqno" name="popShrPrductUpperSeqno"  class="wd100p" style="min-width:10em;"></select>';
    body += '</td>';
    body += '<th>' + lang.C000000214 + '</th>'; /*자재코드*/
    body += '<td>';
    body += '<select id="popShrMtrilCode" name="popShrMtrilCode"  class="wd100p" style="min-width:10em;"></select>';
    body += '</td>';
    body += '</tr>';
    body += '<tr>';
    body += '<th>' + lang.C000000575 + '</th>'; /*Lot ID*/
    body += '<td>';
    body += '<input type="text" id="popShrLotID" name="popShrLotID"  class="wd100p" style="min-width:10em;">';
    body += '</td>';
    /*body += '<th>'+lang.C000000885+'</th>'; 검사교정 구분
    body += '<td>';
    body += '<select name="popInspctCrrctSeCode"  id="popInspctCrrctSeCode" class="wd100p">';
    body += '</select>';
    body += '</td>';*/
    body += '<th>' + lang.C000000576 + '</th>'; /*의뢰일자*/
    body += '<td colspan="2">';
    body += '<input type="text" id="popReqestDteSch" name="popReqestDteSch"  class="wd45p" style="min-width:5em;">~';
    body += '<input type="text" id="popReqestDteFinish" name="popReqestDteFinish"  class="wd45p" style="min-width:5em;">';
    body += '</td>';
    body += '<td colspan="3"></td>';
    body += '</tr>';
    body += '</table>';
    body += '</div>';
    body += '</div>';
    body += '<div class="subCon1 mgT15" id="detail2">';
    body += '<div id="grid_' + dialogId + '" class="mgT15" style="width:100%; margin:0 auto;"></div>';
    body += '</div>';
    body += '</form>';

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        //		ajaxJsonComboBox('/com/getCmmnCode.lims', 'popInspctCrrctSeCode', {'upperCmmnCode': 'IM10'}, false,null, (getEl("inspctCrrctSeCode").value == "")?"IM10000001":getEl("inspctCrrctSeCode").value);
        $.when(
            ajaxJsonComboBox('/com/getDeptCombo.lims', 'popShrDeptCode', { "analsAt": "Y", "mmnySeCode": "SY01000001" }, true, null, data.deptCode, true),
            ajaxJsonComboBox("/com/getCmmnCode.lims", "popShrProcessTyCode", { "upperCmmnCode": "SY02" }, true, null, "SY02000007", true),
            ajaxJsonComboBox("/wrk/getPrductMtrilComboList.lims", "popShrMtrilCode", null, false)
        ).then(function (a, b) {
            var param = {
                "deptCode": data.deptCode,
                "processTyCode": "SY02000007"
            }
            console.log(param);
            ajaxJsonComboBox("/wrk/getSrchPrductList.lims", "popShrPrductUpperSeqno", param, true);
        });
        datePickerCalendar(["popReqestDteSch", "popReqestDteFinish"], true, ["DD", -30], ["DD", 30]);
    });

    dialogGridID = createAUIGrid(requestDialogColumnLayout, dialogGridID, gridProperties);

    function getRequestList() {
        getGridDataParam("/req/getReqList.lims", {
            lotId: $("#popShrLotID").val(), prdlstNm: $("#popShrPrductNm").val(),
            prductSeqno: $("#popShrPrductUpperSeqno").val(),
            popProgrsSittnCode: "IM03000006",
            processTyCode: $("#popShrProcessTyCode").val(),
            mtrilCode: $("#popShrMtrilCode").val(),
            deptCode: $("#popShrDeptCode").val(),
            rsMhSeqno: getEl("mhrlsSeqnon").value,
            popReqestDteSch: $("#requestPopForm #popReqestDteSch").val(), popReqestDteFinish: $("#requestPopForm #popReqestDteFinish").val()
        }, dialogGridID);
    }



    $("#popup_" + dialogId + " #btn_PopRequestSearch").click(function () {
        getRequestList();
    });

    $("#popShrPrductUpperSeqno").change(function () {
        var data = {
            "deptCode": getEl("popShrDeptCode").value,
            "prductSeqno": getEl("popShrPrductUpperSeqno").value,
            "processTyCode": getEl("popShrProcessTyCode").value
        }
        ajaxJsonComboBox("/wrk/getPrductMtrilComboList.lims", "popShrMtrilCode", data, true);
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    //엔터키 이벤트
    $("#requestPopForm [type=text]").keypress(function (e) {
        if (e.which == 13) {
            getRequestList();
        }
    });

    $("#popup_" + dialogId + " #btn_PopRequestAdd").click(function () {
        // 그리드 데이터에서 isActive 필드의 값이 Active 인 행 아이템 모두 반환
        var activeItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        for (var i = 0; i < activeItems.length; i++) {
            if (!activeItems[i].mhrlsSeqno) {
                alert(activeItems[i].lotId + "의 장비가 지정되어 있지 않습니다. \n 장비가 지정되지 않은 의뢰는 선택 불가능합니다.");
                return false;
            }
        }

        if (activeItems.length == 0) {
            alert(lang.C000001156); /*의뢰 체크항목이 없습니다.*/
            return false;
        }

        selectFunc(activeItems);
        AUIGrid.clearGridData(dialogGridID);

        $('#reqestSeqno').val(activeItems[0].reqestSeqno)
        $('#calcDate').val(activeItems[0].calcDate)
        $('#mhrlsSeqno').val(activeItems[0].mhrlsSeqno)


        $("#popupClose_" + dialogId).trigger("click");
    });
}


// 기기 일상점검 차트
function dialogViewMecChart(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(1200);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000001244); /*■ 기기 중간 점검*/
    var topright = "<span class=\"iArea mgR10\">"
        + "</span>"
    var body =
        "<div class='mgT15' style='width:100%; height:550px;'>"
        + "<label><input type='radio' name='chartGbn' id='chartGbnA' value='gbnA' checked/>&nbsp;해당 기기&nbsp;</label>"
        + "<label><input type='radio' name='chartGbn' id='chartGbnB' value='gbnB'/>&nbsp;모든 기기</label>"
        + "<div id='" + "canvasDiv" + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "<canvas id=\"" + dialogId + "_chartCanvas\" class=\"wd100p hei550\"></canvas>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    var ctx = getEl(dialogId + "_chartCanvas").getContext("2d");

    var mecChart = new Chart(ctx, {
        type: "line",
        data: {
            labels: [lang.C000001072, lang.C000001073, lang.C000001074, lang.C000001075], /*1분기, 2분기, 3분기, 4분기*/
            datasets: [
            ],

        },
        options: {
            responsive: true,
            title: {
                display: true,
            },
            zoom: {
                enabled: true,
                mode: 'y',
            },
            onClick: function (c, i) {
                e = i[0];
                console.log(e._index)
                var x_value = this.data.labels[e._index]; //x축 값 : 1분기 년도
                var y_value = this.data.datasets[0].data[e._index];//y축 값 : 데이터  ex)45.123
                console.log(x_value);
                console.log(y_value);
                if (x_value == "2020년 1분기") window.open("http://www.naver.com", null, "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
                if (x_value == "2020년 2분기") window.open("http://www.daum.com", null, "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
                if (x_value == "2020년 3분기") window.open("http://www.google.com", null, "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");

            }
        }
    });

    popupInit(btnId, dialogId, function () {
        searchChart();
    }, preOpenFunc);

    function searchChart() {
        var chartGbn = $('input[name="chartGbn"]:checked').val();
        var url = "/rsc/MecChartList.lims";
        var param = {
            "reqestSeqno": getEl("clickDialogChart").value,
            "reqestExpriemSeqno": getEl("reqestExSeqno").value,
            "mhEdayChckSeq": getEl("popMhrlsEdayChckSeqno").value,
            "mhrlsSeqno": getEl("chartMhrlsSeqno").value,
            "mhrlsClCode": getEl("mhrlsClCode").value,
            "chartGbn": chartGbn
        }
        customAjax({
            "url": url,
            "data": param,
            "successFunc": function (data) {
                mecChart.resetZoom();   // 줌 초기화
                console.log(">> data : ", data);
                //				//기초 데이터 생성용 변수 생성
                //				//얘는 데이터 목록
                var mhrlsNmArr = new Array();
                var resultValueAvgArr = new Array();
                var labelsArr = new Array();
                if (chartGbn == "gbnA") {
                    //				//반복문에 모조리넣음
                    for (var i = 0; i < data.length; i++) {
                        resultValueAvgArr.push(data[i]["resultValueAvg"]);
                        labelsArr.push(data[i].year);
                        mhrlsNmArr.push(data[i].mhrlsNm);
                    }
                    var pointBackgroundColors = [];


                    var valueList = [
                        {
                            "list": resultValueAvgArr,
                            "label": data[0].expriemNm,
                            "fill": false,
                            "borderWidth": 1,
                            "borderColor": 'rgb(255,100,100)',
                        }
                    ];
                    //config 접근도어렵다 하...
                    var config = mecChart.config;

                    // 전역설정. 타이틀, 반응형으로 설정.
                    config.options.responsive = true;
                    config.options["title"]["display"] = true;
                    config.options["title"]["text"];
                    config.type = "line";

                    //기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
                    //datasets 라인별이라고 보면됨니다
                    var pointBackgroundColors = new Array();

                    mecChart["data"] = {
                        "labels": labelsArr,
                        "datasets": []
                    };
                    console.log(">> : ", valueList);
                    //라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다

                    for (var i = 0; i < valueList.length; i++) {
                        mecChart.data.datasets[0] = {
                            "label": valueList[0].label,
                            "data": valueList[0].list,
                            "fill": valueList[0].fill,
                            "borderColor": valueList[0].borderColor,
                            "pointRadius": 4,
                            pointBackgroundColor: function (context) { //색깔 테스트
                                var index = context.dataIndex;
                                var value = parseFloat(context.dataset.data[index]);

                                if (parseFloat("0") < value && value < parseFloat("20")) return 'green'
                                if (parseFloat("19") < value && value < parseFloat("40")) return 'red'
                                if (parseFloat("39") < value && value < parseFloat("60")) return 'blue'
                            },
                            lineTension: 0
                        };
                    }
                }



                if (chartGbn == "gbnB") {
                    //라벨 중복비교해서 빼고 리스트에
                    var cnt = 0;
                    var labelNames = [];
                    var dateArr = [];
                    for (var i = 0; i < data.length; i++) {
                        labelsArr.push(data[i].year);
                        mhrlsNmArr[i] = data[i]["mhrlsNm"];
                    }
                    $.each(mhrlsNmArr, function (i, el) {
                        if ($.inArray(el, labelNames) === -1) {
                            labelNames.push(el);
                        }
                    });
                    $.each(labelsArr, function (i, el) {
                        if ($.inArray(el, dateArr) === -1) {
                            dateArr.push(el);
                        }
                    });
                    mecChart.data.labels = dateArr;
                    for (var i = 0; i < labelNames.length; i++) {
                        if (labelNames[i]) {
                            var mhrlsNm = "";
                            var resultValueAvgArr = new Array();
                            for (var j = 0; j < data.length; j++) {
                                if (labelNames[i] == data[j]["mhrlsNm"]) {
                                    resultValueAvgArr.push({ value: data[j]["year"], data: data[j]["resultValueAvg"] });
                                    mhrlsNm = data[j]["mhrlsNm"];
                                }
                            }
                        }

                        resultValueAvgArr = chkNullDate(resultValueAvgArr, dateArr);

                        //config 접근도어렵다 하...
                        var config = mecChart.config;

                        // 전역설정. 타이틀, 반응형으로 설정.
                        config.options.responsive = true;
                        config.options["title"]["display"] = true;
                        config.options["title"]["text"];
                        config.type = "line";

                        //기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
                        //datasets 라인별이라고 보면됨니다

                        mecChart.data.datasets[cnt] = {
                            label: mhrlsNm,
                            data: resultValueAvgArr,
                            fill: false,
                            borderColor: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
                            lineTension: 0

                        }

                        cnt++;
                    }
                }
                // 완성된 차트는 업데이트를 시켜주면된다.
                mecChart.update();
            }
        })
    }

    $("#chartGbnA").click(function () {
        searchChart();
    });
    $("#chartGbnB").click(function () {
        searchChart();
    });

    /*
     * 데이터 추가 시 해당 데이터 날짜 없을경우 해당 날짜 null처리
     * */

    function chkNullDate(list, dateArrChk) {
        console.log("list : ", list);
        console.log("dateArr : ", dateArrChk);
        var result = [];
        var cnt = 0;
        for (var i = 0; i < dateArrChk.length; i++) {
            if (cnt > (list.length - 1))
                cnt -= 1;
            if (list[cnt].value == dateArrChk[i]) {
                result.push(list[cnt].data);
                cnt++;
            } else {
                result.push(null);
            }
        }

        return result;
    }
}


/*
*메인페이지 공지사항 팝업 (다음에디터 미사용)
*/
function dialogMainBbsNew(btnId, data, dialogId, gridId, selectFunc, preOpenFunc) {

    var getGridData;
    var html = createDialog(930);
    var dropzoneArea_noticeMain;
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000194);
    var topright = "";
    var body = "<div class='subCon1 mgT15'>"
        + "<section class='content mt20'>"
        + "<div id='main_wrap_save'>"
        + "<form id='dialogFrm" + dialogId + "' name='dialogFrm" + dialogId + "'>"
        + "<table class='tb3'>"
        + "<tr>"
        + "<th class='taCt vaMd' style='min-width:10px; text-align: center;'>" + lang.C100000802 + "</th>"
        + "<td class='wd20p'>"
        + "<input type='text' name='popSj' id='popSj' class='wd100p' readonly  style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"
        + "</td>"
        + "<th class='taCt vaMd' style='min-width:10px; text-align: center;'>" + lang.C100000730 + "</th>"
        + "<td class='wd20p'>"
        + "<input type='text' name='popWrterNm' id='popWrterNm' class='wd100p' readonly style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"
        + "</td>"
        + "<th class='taCt vaMd' style='min-width:10px; text-align: center;'>" + lang.C100000728 + "</th>"
        + "<td class='wd20p'>"
        + "<input type='text' name='popWritngDe' id='popWritngDe' class='wd100p' readonly style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th class='taCt vaMd' style='min-width:10px; text-align: center;'>" + lang.C100000669 + "</th>"
        + "<td class='wd20p' colspan='1'>"
        + "<input type='text' name='popEmail' id='popEmail' readonly style='border:none; float: left; border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"
        + "</td>"
        + "<th class='taCt vaMd' style='min-width:10px; text-align: center;'>" + lang.C100000923 + "</th>"
        + "<td class='wd30p' style='text-align: left;'>"
        + "<input type='text' name='popupBeginDe' id='popupBeginDe' class='wd6p' readonly style='border:none;border-right:0px;  border-top:0px; boder-left:0px; boder-bottom:0px; min-width: 6em;'>"
        + " ~ <input type='text' name='popupEndDe' id='popupEndDe' class='wd6p' readonly style='border:none;border-right:0px;  border-top:0px; boder-left:0px; boder-bottom:0px; min-width: 6em; '>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th class='taCt vaMd' style='min-width:150px; height:300px; text-align: center;'>" + lang.C100000259 + "</th>"
        + "<td class='wd33p' colspan='5'><div id='cn' name='cn' class='wd100p' style='min-width: 10em; border: 1px solid #dcdcdc; overflow:scroll; height:300px; text-align:left;'></div>"
        //		 + "<td>"
        //		 + "<input type='text' name='cn' id='cn' class='wd100p' readonly style='border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;'>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th class='taCt vaMd' style='min-width:150px; text-align: ;'>" + lang.C100000860 + "</th>"
        + "<td colspan='7'>"
        + "<div id='dropzoneArea_noticeMain'></div>"
        + "<input type='hidden' id='atchmnflSeqno' name='atchmnflSeqno' class='wd33p' style='min-width:10em;'>"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</Form>"
        + "</div>"
        + "</section>"
        + "</div>"
        + "<style>"
        + " #cn img{max-width: 650px; height : auto;}"
        + "</style>"
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#header").append(html);

    // 공지사항 팝업 오픈
    popupInit(btnId, dialogId, function () {

    }, preOpenFunc);

    $("#popupBg_mainBbs").click(function () {
        $("#popupClose_mainBbs").click();
    });

    //파일 드랍존 생성
    dropzoneArea_noticeMain = DDFC.bind().EventHandler("dropzoneArea_noticeMain", { 'readOnly': true, lang: lang.C000000118 });

    $("#" + btnId).click(function () {
        getGridData = AUIGrid.getGridData("#" + gridId);
        var getRowIndex = AUIGrid.getSelectedItems("#" + gridId)[0].rowIndex;
        var countUrl = '/sys/countNoticeWriteM.lims'; // 게시글 조회 카운트 url
        var param = {
            bbsCode: getGridData[getRowIndex].bbsCode // 게시판 코드
            , sntncSeqno: getGridData[getRowIndex].sntncSeqno
        }; // 게시글 코드
        $("#popSj").val(getGridData[getRowIndex].sj);
        $("#popWrterNm").val(getGridData[getRowIndex].wrterNm);
        $("#popWritngDe").val(getGridData[getRowIndex].writngDe);
        $("#popEmail").val(getGridData[getRowIndex].email);
        $("#popupBeginDe").val(getGridData[getRowIndex].popupBeginDe);
        $("#popupEndDe").val(getGridData[getRowIndex].popupEndDe);
        // $("#cn").val(getGridData[getRowIndex].cn.replace(/[<][^>]*[>]/gi, ""));
        $("#cn").html(getGridData[getRowIndex].cn);
        $("#atchmnflSeqno").val(getGridData[getRowIndex].atchmnflSeqno);

        // 공지사항 조회수 증가
        customAjax({ url: countUrl, data: param });

        dropzoneArea_noticeMain.getFiles($("#atchmnflSeqno").val(), null, 'N'); // 첨부파일

    });
}

function dislogPrductStndrd(btnId, data, dialogId, gridId, selectFunc, preOpenFunc) {
    var prductStndrdDialogColumnLayout = [];
    auigridCol(prductStndrdDialogColumnLayout);

    prductStndrdDialogColumnLayout.addColumnCustom("prductStndrdSeCodeNm", lang.C000001036, "*", true); /*제품 규격 구분*/
    prductStndrdDialogColumnLayout.addColumnCustom("stdMttrSeCodeNm", lang.C000001037, "*", true); /*제품 규격 상세*/
    prductStndrdDialogColumnLayout.addColumnCustom("prductStndrdNm", lang.C000001038, "*", true); /*제품 규격명*/
    prductStndrdDialogColumnLayout.addColumnCustom("wrhousngDte", lang.C000000524, "*", false); /*입고 일자*/
    prductStndrdDialogColumnLayout.addColumnCustom("validDte", lang.C000000096, "*", false); /*비고*/
    prductStndrdDialogColumnLayout.addColumnCustom("rm", lang.C000000749, "*", true); /*부서 코드*/

    var getGridData;
    var dialogGridID = "grid_" + dialogId;
    var html = createDialog("930");
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C000001239); /*■ 제품 규격 목록*/

    var topright = "<div class=\"subCon1 mgT15\">"
        + "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"btnPrductPopSearch\" class=\"btn3\" >" + lang.C000000002 + "</button>" /*조회*/
        + "</div>"
        + "<form id=\"prductPopSearchFrm\" onSubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:12%\"></col>"
        + "<col style=\"width:18%\"></col>"
        + "<col style=\"width:12%\"></col>"
        + "<col style=\"width:18%\"></col>"
        + "<col style=\"width:12%\"></col>"
        + "<col style=\"width:18%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C000001036 + "</th>" /*제품 규격 구분*/
        + "<td>"
        + "<select name='schPrductStndrdSeCode' id='schPrductStndrdSeCode'></select>"
        + "</td>"
        + "<th>" + lang.C000001037 + "</th>" /*제품 규격 상세*/
        + "<td>"
        + "<select name='schStdMttrSeCode' id='schStdMttrSeCode'></select>"
        + "</td>"
        + "<th>" + lang.C000001038 + "</th>" /*제품 규격 명*/
        + "<td>"
        + "<input type='text' name='schPrductStndrdNm' id='schPrductStndrdNm'>"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>";


    var body = "<div class='mgT15' style='width:100%; height:400px;'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;' class='grid'>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    var prductStndrdDialogGridID = createAUIGrid(prductStndrdDialogColumnLayout, dialogGridID);

    $("#btnPrductPopSearch").click(function () {
        searchGridData();
    });

    AUIGrid.bind(prductStndrdDialogGridID, "ready", function (event) {
        AUIGrid.resize(prductStndrdDialogGridID, "900", "450");
    });

    AUIGrid.bind(prductStndrdDialogGridID, "cellDoubleClick", function (event) {
        selectFunc(event.item);
        $("#popupClose_" + dialogId).trigger("click");
    });

    function searchGridData() {
        ajaxJsonForm("/rsc/getMhrlsStndrdUseMList.lims", "prductPopSearchFrm", function (data) {
            AUIGrid.setGridData(prductStndrdDialogGridID, data);
        });
    }

    ajaxJsonComboBox('/com/getCmmnCode.lims', 'schPrductStndrdSeCode', { 'upperCmmnCode': 'RS20' }, true);
    ajaxJsonComboBox('/com/getCmmnCode.lims', 'schStdMttrSeCode', { "upperCmmnCode": "RS21" }, true);

    // 공지사항 팝업 오픈
    popupInit(btnId, dialogId, function () {
        searchGridData();
    }, preOpenFunc);
}

//상위 표준물질 팝업
function dialogUpperStdMttr(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var stdMttrMaster = [];
    auigridCol(stdMttrMaster);
    stdMttrMaster.addColumnCustom("brcd", lang.C000000627, null, true, false) /* 바코드 */

        .addColumnCustom("stdMttrSeqno", lang.C000001035, null, false, false) /* 표준 물질 일련번호 */
        .addColumnCustom("chrgTeamSeqno", lang.C000000624, null, false, false) /* 담당 팀  */
        .addColumnCustom("chrgTeamSeCodeNm", lang.C000000624, null, true, false) /* 담당 팀 */
        .addColumnCustom("prductStndrdNm", lang.C000001026, null, true, false) /*제품 규격*/
        .addColumnCustom("prductStndrdCnt", lang.C000001030, null, true, false) /*재고*/
        .addColumnCustom("rgntNm", lang.C000000649, null, true, false) /* 시약 명 */
        .addColumnCustom("rgntKndCodeNm", lang.C000000647, null, true, false) /* 시약 종류 */
        .addColumnCustom("rgntSeCodeNm", lang.C000000648, null, true, false) /* 시약 구분 */
        .addColumnCustom("wrhousngDte", lang.C000000524, null, true, false) /* 입고일자 */
        .addColumnCustom("validDte", lang.C000000631, null, true, false) /* 유효일자 */
        .addColumnCustom("manageRspnberJNm", lang.C000001034, null, true, false) /* 관리책임자(정,제조자) */
        .addColumnCustom("manageRspnberBNm", lang.C000000519, null, true, false) /* 관리책임자(부)*/
        .addColumnCustom("dsuseAt", lang.C000000632, null, true, false) /* 폐기여부 */
        .addColumnCustom("dsuseDte", lang.C000000543, null, true, false); /* 폐기일자 */

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000001240); /* ■ 표준 물질 목록*/
    var topright = "<div class=\"subCon1 mgT15\">"
        + "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"btnStdMttrPopSearch\" class=\"btn3\" >" + lang.C000000002 + "</button>"
        + "</div>"
        + "<form id=\"StdMttrPopSearchFrm\" onSubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C000000624 + "</th>" /*담당 팀*/
        + "<td>"
        + "<select id=\"chrgTeamSeCodePopSch\" name=\"chrgTeamSeCodeSch\"></select>"
        + "</td>"
        + "<th>" + lang.C000000647 + "</th>" /*시약 종류*/
        + "<td>"
        + "<select id=\"rgntKndCodePopSch\" name=\"rgntKndCodeSch\"></select>"
        + "</td>"
        + "<th>" + lang.C000000648 + "</th>" /*시약 구분*/
        + "<td>"
        + "<select id=\"rgntSeCodePopSch\" name=\"rgntSeCodeSch\"></select>"
        + "</td>"
        + "<th>" + lang.C000000649 + "</th>" /*시약 명*/
        + "<td>"
        + "<input type=\"text\" id=\"rgntNmPopSch\" name=\"rgntNmSch\" class=\"schClass\">"
        + "<input type=\"hidden\" id=\"validDteSch\" name=\"validDteSch\" value=\"Y\" class=\"schClass\">"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        init();
        AUIGrid.resize(dialogGridID);
        getStdMttrPopList();
    }, preOpenFunc);

    dialogGridID = createAUIGrid(stdMttrMaster, dialogGridID);

    function getStdMttrPopList() {
        ajaxJsonForm3("/rsc/getStdMttrList.lims", "StdMttrPopSearchFrm", function (data) {
            AUIGrid.setGridData(dialogGridID, data);
        });
    }

    function init() {
        ajaxJsonComboBox("RS15", "rgntSeCodePopSch", true);
        ajaxJsonComboBox("RS16", "rgntKndCodePopSch", true);
        ajaxJsonComboBox("RS19", "chrgTeamSeCodePopSch", true);
    }

    $("#popup_" + dialogId + " #btnStdMttrPopSearch").click(function () {
        getStdMttrPopList();
    });

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        var gridItem = event.item;
        if (selectFunc != undefined && selectFunc != null) {
            selectFunc(gridItem);
        }


    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getStdMttrPopList();
        }
    });
}

//메인화면 이상발생 팝업
function IssDialog(btnId, data, dialogId, gridId, selectFunc, preOpenFunc) {
    var prductStndrdDialogColumnLayout = [];
    auigridCol(prductStndrdDialogColumnLayout);
    prductStndrdDialogColumnLayout.addColumnCustom("lotId", "LOT ID", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("issueSeCode", "이슈구분", "*", false);
    prductStndrdDialogColumnLayout.addColumnCustom("issueSeNm", "이슈구분", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("issueSj", "제목", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("reqestDeptNm", "부서", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("processTyCode", "프로세스 타입", "*", false);
    prductStndrdDialogColumnLayout.addColumnCustom("processTyNm", "프로세스 타입", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("expriemCn", "시험항목", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("issueProgrsSittnNm", "상태", "*", true);
    prductStndrdDialogColumnLayout.addColumnCustom("issueProgrsSittnCode", "상태코드", "*", false); //상태 코드
    prductStndrdDialogColumnLayout.addColumnCustom("lockAt", "잠금여부", "*", true);


    var getGridData;
    var deptSchCode;
    var monthChk;
    var dialogGridID = "grid_" + dialogId;
    var html = createDialog("915");
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "■ 이상 발생 목록");

    var topright = "<br>";


    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#header").append(html);

    var prductStndrdDialogGridID = createAUIGrid(prductStndrdDialogColumnLayout, dialogGridID);


    AUIGrid.bind(prductStndrdDialogGridID, "ready", function (event) {
        AUIGrid.resize(prductStndrdDialogGridID, "880", "490");
    });

    AUIGrid.bind(prductStndrdDialogGridID, "cellDoubleClick", function (event) {
        $("#popupClose_" + dialogId).trigger("click");
    });

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(prductStndrdDialogGridID, "900", "450");
        monthChk = $("#monthChk").val();

        if (monthChk == "lcount") {
            deptSchCode = $("#deptSchCode").val();
            customAjax({
                "url": "/test/mainLcountList.lims",
                "data": { "deptSchCode": deptSchCode }
            }).then(function (data) {
                AUIGrid.setGridData(prductStndrdDialogGridID, data);
            });

            /*
            ajaxJsonParam3("/test/mainLcountList.lims", {"deptSchCode" : deptSchCode}, function(data){
                AUIGrid.setGridData(prductStndrdDialogGridID, data);
            });
            */

        } else if (monthChk == "ccount") {
            deptSchCode = $("#deptSchCode").val();
            customAjax({
                "url": "/test/mainCcountList.lims",
                "data": { "deptSchCode": deptSchCode }
            }).then(function (data) {
                AUIGrid.setGridData(prductStndrdDialogGridID, data);
            });

            /*
            ajaxJsonParam3("/test/mainCcountList.lims", {"deptSchCode" : deptSchCode}, function(data){
                AUIGrid.setGridData(prductStndrdDialogGridID, data);
            });
            */
        }


    }, preOpenFunc);
}

//변경점 알림설정
function changePointDialog(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var btnSearch = "btnSearch_" + dialogId;
    var btnSelect = "btnSelect_" + dialogId;
    var btnSelect2 = "btnSelect2_" + dialogId;
    var btnSave = "btnSave_" + dialogId;
    var btnLeft = "btnLeft_" + dialogId;
    var btnRight = "btnRight_" + dialogId;
    var dialogGridID = "grid_" + dialogId;
    var userDialogGridID = "grid2_" + dialogId;
    var customerDialogGridID = "grid3_" + dialogId;
    var sanctnSeCode;
    var btnUserSearch = "btnUserSearch" + dialogId;
    var userNmSch = "userNmSch" + dialogId;

    var cboDeptS = "cboDeptS_" + dialogId;
    var cboDeptS2 = "cboDeptS2_" + dialogId;

    var dialogColumnLayout2 = [];
    auigridCol(dialogColumnLayout2);

    dialogColumnLayout2.addColumn("deptCode", lang.C000000106, null, false);	/*부서명*/
    dialogColumnLayout2.addColumn("deptNm", lang.C000000106, null, true);	/*부서명*/
    dialogColumnLayout2.addColumn("userId", lang.C000000808, null, false); /*사용자ID*/
    dialogColumnLayout2.addColumn("userNm", lang.C000000100, null, true); /*사용자명*/

    var dialogColumnLayout3 = [];
    auigridCol(dialogColumnLayout3);


    dialogColumnLayout3.addColumn("deptCode", lang.C000000106, null, false); /*부서명*/
    dialogColumnLayout3.addColumn("deptNm", lang.C000000106, null, true);	/*부서명*/
    dialogColumnLayout3.addColumn("userId", lang.C000000808, null, false); /*사용자ID*/
    dialogColumnLayout3.addColumn("userNm", lang.C000000100, null, true); /*사용자명*/
    dialogColumnLayout3.addColumn("ntcnSeCode", lang.C000001236, false, false); /*알림 구분 코드*/
    dialogColumnLayout3.addColumn("schdulSeqno", lang.C000001237, false, false); /*일정 일련번호*/
    dialogColumnLayout3.addColumn("chrctrRecptnAt", lang.C000001314, "*", true); /* 문자 전송 여부 */
    dialogColumnLayout3.addColumn("emailRecptnAt", lang.C000001315, "*", true) /* 메일 전송 여부 */
    dialogColumnLayout3.checkBoxRenderer(["emailRecptnAt", "chrctrRecptnAt"], customerDialogGridID, { check: "Y", unCheck: "N" });
    //.checkBoxRenderer(["emailRecptnAt", "chrctrRecptnAt"], warnGrid, {check: "Y", unCheck: "N"});

    var html = createDialog(1050);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "");
    var topright = "<span></span>"
    var body = ""

        + "<div class='subCon1 wd45p' style='float: left;'>"
        + "<h2 style='margin-bottom: 10px;'>" + lang.C000000186 + "</h2>" /*전체사용자 목록*/

        + "<span class=\"iArea mgR10\"></span>"
        + "<select name='" + cboDeptS + "' id='" + cboDeptS + "' class='wd40p' style='float:left;'></select>"
        + "<input type=\"text\" id='" + userNmSch + "' name='" + userNmSch + "' class=\"searchClass\" style='width:35%;'  placeholder=\"" + lang.C000000100 + "\">" /*사용자명*/
        + "</span>"

        + "<div class='btnWrap' style='top : 10px;'>"
        + "<button type=\"button\" id='" + btnUserSearch + "' style=\"margin-left:5px;  margin-top:26px;\"  class=\"btn1\">" + lang.C000000002 + "</button>" /*조회*/

        + "</div>"

        + "<div class='content'>"
        + "<div id='main_wrap'>"
        + "<div id='top_wrap'>"
        + "<div class='mgT15'>"
        + "<div id='" + userDialogGridID + "' style='width:100%; height:300px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "<div class='subCon1 wd10p' style='float: left;'>"
        + "<div class='content'>"
        + "<div id='middle_wrap' style='margin-top:100px;'>"
        + "<div id='top_wrap'>"
        + "<div id='" + btnLeft + "' class='arrowBtn' style='cursor:pointer; margin-left:10px; width:20px;'></div>"
        + "</div>"
        + "<div id='middle_wrap' style='margin-top:50%;'>"
        + "<div id='" + btnRight + "' class='arrowBtn fR' style='cursor:pointer; margin-right:10px; width:20px; transform: rotate(180deg);'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "<div class='subCon1 wd45p' style='float: left;'>"
        + "<h2 style='height:60px;'>" + lang.C000001330 + "</h2>" /*알림 사용자 목록*/
        + "<div class='btnWrap' style='top : 37px; right:-10px; width:100%'>"
        + "<select name='" + cboDeptS2 + "' id='" + cboDeptS2 + "' style='float: left;' class='wd40p'></select>"
        + "<button type='button' id='" + btnSave + "' class='btn1' style='float: right'>" + lang.C000000015 + "</button>&nbsp;" /* 저장 */
        + "<button type='button' id='" + btnSelect2 + "' class='btn1' style='float: right'>" + lang.C000000002 + "</button>&nbsp;" /* 조회 */

        + "</div>"
        + "<div class='content'>"
        + "<div id='main_wrap'>"
        + "<div id='top_wrap'>"
        + "<div class='mgT15'>"
        + "<div id='" + customerDialogGridID + "' style='width:100%; height:300px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        var bestParams = { "analsAt": "Y", "deptAt": "Y", "mmnySeCode": "SY01000001", "qualfmanManageAtOr": "Y" };
        ajaxJsonComboBox('/com/getDeptCombo.lims', cboDeptS, bestParams, false, lang.C000000062);

        bestParams = { "analsAt": "Y", "deptAt": "Y", "mmnySeCode": "SY01000001" };
        ajaxJsonComboBox('/com/getDeptCombo.lims', cboDeptS2, bestParams, false);

        AUIGrid.resize(userDialogGridID);
        AUIGrid.resize(customerDialogGridID);
        //getSanctnList();
    }, preOpenFunc);

    var popCusPros = {
        editable: true, // 편집 가능 여부 (기본값 : false)
        selectionMode: "multipleCells",// 셀 선택모드 (기본값: singleCell)
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
        showEditedCellMarker: true,
        showStateColumn: true
    }

    userDialogGridID = createAUIGrid(dialogColumnLayout2, userDialogGridID, popCusPros);
    customerDialogGridID = createAUIGrid(dialogColumnLayout3, customerDialogGridID, popCusPros);

    function getUserNmList() {
        var sanctnLineUserGrid = AUIGrid.getGridData(customerDialogGridID);
        var sanctnLineUserArray = [];

        for (var i = 0; i < sanctnLineUserGrid.length; i++) {
            sanctnLineUserArray[i] = sanctnLineUserGrid[i]["userId"];
        }

        var userNmParams = {
            userDeptCode: $("#" + cboDeptS).val()
            , userNmSch: $("#" + userNmSch).val()
            , sanctnLineUser: sanctnLineUserArray
        };

        getGridDataParam("/wrk/getUserNtncList.lims", userNmParams, userDialogGridID);
    }

    $("#" + cboDeptS2).change(function () {
        var userNmParams = {
            deptCode: $("#" + cboDeptS2).val()
            , ntcnSeCode: data.ntcnSeCode
        };

        getGridDataParam("/com/getSyDeptAcctoNtcnTrgter.lims", userNmParams, customerDialogGridID);
    });

    //문자알림 저장
    $("#" + btnSave).click(function () {

        if (confirm(lang.C000000306)) { //저장 하시겠습니까?
            var params = {
                listGridData: AUIGrid.getGridData(customerDialogGridID)
                , addListGridData: AUIGrid.getAddedRowItems(customerDialogGridID)
                , removeListGridData: AUIGrid.getRemovedItems(customerDialogGridID)
                , ntcnSeCode: data.ntcnSeCode
                , deptCode: $("#" + cboDeptS2).val()
            };
            console.log(">>> : ", params);

            customAjax({
                "url": "/com/insSyDeptAcctoNtcnTrgter.lims",
                data: params
            }).then(function (data) {
                if (data > 0) {
                    alert(lang.C000000071);  //저장 되었습니다.
                    AUIGrid.clearGridData(userDialogGridID);
                    AUIGrid.clearGridData(customerDialogGridID);
                    $("#popupClose_" + dialogId).trigger("click");
                }
                else {
                    alert(lang.C000000170);  //저장에 실패하였습니다.
                }
            });

            /*
            ajaxJsonParam3("/com/insSyDeptAcctoNtcnTrgter.lims", params, function(data){
                if(data > 0){
                    alert(lang.C000000071);  //저장 되었습니다.
                    AUIGrid.clearGridData(userDialogGridID);
                    AUIGrid.clearGridData(customerDialogGridID);
                    $("#popupClose_" + dialogId).trigger("click");
                }
                else{
                    alert(lang.C000000170);  //저장에 실패하였습니다.
                }
            });
            */
        }

    });

    //사용자목록 조회
    $("#" + btnSearch).click(function () {
        getSanctnList();
    });


    //전체 사용자 목록 조회
    $("#" + btnUserSearch).click(function () {
        getUserNmList();
    })

    //엔터키 이벤트
    $("#" + userNmSch).keyup(function (e) {
        if (e.keyCode == 13) {
            getUserNmList()
        }
    });

    //부서별 알림대상자 조회
    $("#" + btnSelect2).click(function () {
        var userNmParams = {
            deptCode: $("#" + cboDeptS2).val()
            , ntcnSeCode: data.ntcnSeCode
        };

        getGridDataParam("/com/getSyDeptAcctoNtcnTrgter.lims", userNmParams, customerDialogGridID);
    });


    $("#" + btnSelect).click(function () {
        if (selectFunc != undefined && selectFunc != null) {
            var gridData = AUIGrid.getGridData(customerDialogGridID);

            var bool = true;

            for (var i = 0; i < gridData.length; i++) {
                if (!gridData[i]["sanctnSeCode"]) {
                    bool = false;
                    break;
                }
                gridData[i].sanctnOrdr = (i + 1);
            }

            if (bool == false) {
                alert(lang.C000000667); /*결재구분을 입력해주세요.*/
                return;
            }
            var params = {
                gridData: gridData
                , gridSelectedData: gridSelectedData
            };

            selectFunc(params);
        }

        $("#popupClose_" + dialogId).trigger("click");
    });

    //오른쪽 버튼 클릭
    $("#" + btnLeft).click(function () {

        var gridItem = AUIGrid.getCheckedRowItemsAll(userDialogGridID);
        var cnt = 0;
        var str = "";
        for (var i = 0; i < gridItem.length; i++) {
            if (!AUIGrid.isUniqueValue(customerDialogGridID, "userId", gridItem[i]["userId"])) {
                str += "[" + gridItem[i]["deptNm"] + " " + gridItem[i]["userNm"] + "] ";
                cnt++;
            }
        }

        if (cnt == 0) {
            moveGridData(userDialogGridID, customerDialogGridID);
        }
        else {
            alert(lang.C000001238 + str); /*중복 된 사용자가 있습니다.*/
        }

    });

    //왼쪽 버튼 클릭
    $("#" + btnRight).click(function () {
        moveGridData(customerDialogGridID, userDialogGridID);
    });

    //왼쪽 그리드 더블클릭 이벤트
    AUIGrid.bind(userDialogGridID, "cellDoubleClick", function (event) {

        var gridItem = AUIGrid.getSelectedItems(userDialogGridID);
        console.log(gridItem);
        var cnt = 0;
        var str = "";

        if (!AUIGrid.isUniqueValue(customerDialogGridID, "userId", gridItem[0]["item"]["userId"])) {
            str += "[" + gridItem[0]["item"]["deptNm"] + " " + gridItem[0]["item"]["userNm"] + "] ";
            cnt++;
        }

        if (cnt == 0) {
            doubleClicMoveGridData(userDialogGridID, customerDialogGridID);
        }
        else {
            alert(lang.C000001238 + str); /*중복 된 사용자가 있습니다.*/
        }

    });

    //오른쪽 그리드 더블클릭 이벤트
    AUIGrid.bind(customerDialogGridID, "cellDoubleClick", function (event) {
        doubleClicMoveGridData(customerDialogGridID, userDialogGridID);
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(userDialogGridID, "ready", function (event) {
        gridColResize(userDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });
    AUIGrid.bind(customerDialogGridID, "ready", function (event) {
        gridColResize(customerDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });
}

//권한 변경
function changeAuthDialog(btnId, data, dialogId, selectFunc, preOpenFunc) {

    var userColLayout = [];
    auigridCol(userColLayout);

    userColLayout.addColumn('bplcCode', 'bplcCode', null, false) //사업장코드
        .addColumn('deptCode', 'deptCode', null, false) //부서코드
        .addColumn('inspctInsttNm', lang.C100000401, null, true) //부서명
        .addColumn('userId', 'userId', null, false) //사용자ID
        .addColumn('userNm', lang.C100000452, null, true) //사용자명
        .addColumn('authorSeCode', 'authorSeCode', null, false); //권한코드

    var customerColLayout = [];
    auigridCol(customerColLayout);

    customerColLayout.addColumn('bplcCode', 'bplcCode', null, false) //사업장코드
        .addColumn('deptCode', 'deptCode', null, false) //부서코드
        .addColumn('deptNm', lang.C100000401, null, true) //부서명
        .addColumn('inspctInsttNm', lang.C000000106, null, false) //사업장명
        .addColumn('userId', 'userId', null, false) //사용자ID
        .addColumn('userNm', lang.C100000452, null, true) //사용자명
        .addColumn('authorSeCode', 'authorSeCode', null, false) //권한코드
        .addColumn('useAt', '권한 적용여부', null, true) //권한적용여부
        .checkBoxRenderer(['useAt'], customerDialogGridID, {check: 'Y', unCheck: 'N'});

    var userDialogGridID = 'grid2_' + dialogId;
    var customerDialogGridID = 'grid3_' + dialogId;

    var html = createDialog(1200);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000218); /* 권한변경 */

    var topright = "";
    var body = ""
        + "<div class='wd45p' style='float:left; margin-top:30px;'>"
        + "<div class='subCon1'>"
        + "<h3>" + lang.C100000682 + "</h3>" /* 일반사용자 목록 */
        + "<div class='btnWrap' style='width:60%'>"
        + "<select id='cboDeptS_" + dialogId + "' name='cboDeptS_" + dialogId + "' style='float:left; margin-right : 6px;' class='wd40p'></select>"
        + "<input type=\"text\" id='userNmSch" + dialogId + "' name='userNmSch" + dialogId + "' style='float:left;' class='wd40p' placeholder=\"" + lang.C100000452 + "\">" /*사용자명*/
        + "<button type=\"button\" id='btnUserSearch" + dialogId + "' style=\"float:right;\" class=\"search\">" + lang.C100000767 + "</button>" /*조회*/
        + "</div>"
        + "</div>"
        + "<div class='subCon2 mgT15'>"
        + "<div id='" + userDialogGridID + "' style='width:100%; height:300px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>"
        + "<div class='arrowWrap wd10p mgT40' style='float: left;'>"
        + "<div>"
        + "<button type='button' id='btnLeft_" + dialogId + "'><i class='fi-rr-angle-right'></i></button>"
        + "</div>"
        + "<div style='margin-top:10%;'>"
        + "<button type='button' id='btnRight_" + dialogId + "'><i class='fi-rr-angle-left'></i></button>"
        + "</div>"
        + "</div>"
        + "<div class='wd45p' style='float:left; margin-top:30px;'>"
        + "<div class='subCon1'>"
        + "<h3>" + lang.C100000190 + "</h3>" /* 고객사 권한 사용자 목록*/
        + "<div class='btnWrap' style=' width:35%; float:right;'>"
        + "<select id='cboDeptS2_" + dialogId + "' name='cboDeptS2_" + dialogId + "' style='float: left; margin-right : 5px;' class='wd68p'></select>"
        + "<button type='button' id='btnSave_" + dialogId + "' class='save' style='float: right'>" + lang.C100000760 + "</button>&nbsp;" /* 저장 */
        + "</div>"
        + "</div>"
        + "<div class='subCon2 mgT15'>"
        + "<div id='" + customerDialogGridID + "' style='width:100%; height:300px; margin:0 auto;'></div>"
        + "</div>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        ajaxJsonComboBox('/com/getDeptCombo.lims', '#cboDeptS_' + dialogId, null, false);
        ajaxJsonComboBox('/wrk/getBestComboList.lims', '#cboDeptS2_' + dialogId, null, false);
        getGridDataParam('/wrk/getUserAuthList.lims', null, customerDialogGridID);
        AUIGrid.resize(userDialogGridID);
        AUIGrid.resize(customerDialogGridID);

        getCustomerAuthList();
    });

    var popProps = {
        editable: true, // 편집 가능 여부 (기본값 : false)
        selectionMode: 'multipleCells',// 셀 선택모드 (기본값: singleCell)
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
        showEditedCellMarker: true,
        showStateColumn: true
    };

    userDialogGridID = createAUIGrid(userColLayout, userDialogGridID, popProps);
    customerDialogGridID = createAUIGrid(customerColLayout, customerDialogGridID, popProps);

    AUIGrid.bind(userDialogGridID, "ready", function (event) {
        gridColResize(userDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(customerDialogGridID, "ready", function (event) {
        gridColResize(customerDialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    //왼쪽 그리드 더블클릭 이벤트
    AUIGrid.bind(userDialogGridID, "cellDoubleClick", function (event) {

        var gridItem = AUIGrid.getSelectedItems(userDialogGridID);
        if (!AUIGrid.isUniqueValue(customerDialogGridID, "userId", gridItem[0]["item"]["userId"])) {
            alert(lang.C100000837 + "[" + gridItem[0]["item"]["deptNm"] + " " + gridItem[0]["item"]["userNm"] + "]"); /* 중복 된 사용자가 있습니다. */
        } else {
            doubleClicMoveGridData(userDialogGridID, customerDialogGridID);
        }

    });

    //오른쪽 그리드 더블클릭 이벤트
    AUIGrid.bind(customerDialogGridID, "cellDoubleClick", function (event) {
        doubleClicMoveGridData(customerDialogGridID, userDialogGridID);
    });

    //오른쪽 버튼 클릭
    $('#btnLeft_' + dialogId).click(function () {

        var gridItem = AUIGrid.getCheckedRowItemsAll(userDialogGridID);
        var cnt = 0;
        var str = "";

        if (gridItem.length > 0) {
            for (var i = 0; i < gridItem.length; i++) {
                if (!AUIGrid.isUniqueValue(customerDialogGridID, "userId", gridItem[i]["userId"])) {
                    str += "[" + gridItem[i]["deptNm"] + " " + gridItem[i]["userNm"] + " " + "]";
                    cnt++;
                }
            }
        }

        if (cnt == 0) {

            moveGridData(userDialogGridID, customerDialogGridID);

            var getAddedData = AUIGrid.getAddedRowItems(customerDialogGridID);

            if (getAddedData.length > 0) {
                for (var i = 0; i < getAddedData.length; i++) {
                    getAddedData[i].useAt = 'Y';
                    AUIGrid.updateRowsById(customerDialogGridID, getAddedData[i]);
                }
            }
        } else {
            alert(lang.C100000837 + str); /*중복 된 사용자가 있습니다.*/
        }

    });

    //왼쪽 버튼 클릭
    $('#btnRight_' + dialogId).click(function () {
        moveGridData(customerDialogGridID, userDialogGridID);
    });

    //고객사 권한 사용자 목록 선택박스 변경
    $('#cboDeptS2_' + dialogId).change(function () {
        getCustomerAuthList();
    });

    //저장
    $('#btnSave_' + dialogId).click(function () {
        if (confirm(lang.C100000764)) { //저장 하시겠습니까?
            var params = {
                listGridData: AUIGrid.getEditedRowItems(customerDialogGridID) //고객사 리스트에 있는 목록
                , addListGridData: AUIGrid.getAddedRowItems(customerDialogGridID) // 일반사용자에서 고객사리스트 목록에 추가한 목록
                , removeListGridData: AUIGrid.getRemovedItems(customerDialogGridID) // 고객사 리스트에 삭제한목록(일반사용자로 간 목록)
                , deptCode: $('#cboDeptS2_' + dialogId).val()
            };

            customAjax({
                url: '/wrk/updCustomerResult.lims',
                data: params
            }).then(function (data) {
                if (data > 0) {
                    alert(lang.C100000762); /* 저장되었습니다. */
                    AUIGrid.clearGridData(userDialogGridID);
                    AUIGrid.clearGridData(customerDialogGridID);
                    var userNmParams = {
                        bplcCode: $('#cboDeptS2_' + dialogId).val()
                    };

                    getGridDataParam("/wrk/getUserAuthList.lims", userNmParams, customerDialogGridID);
                }
                else {
                    alert(lang.C100000597); /* 저장에 실패하였습니다. */
                }
            });
        }

    });

    //전체 사용자 목록 조회
    $('#btnUserSearch' + dialogId).click(function () {
        var userNmParams = {
            deptCodeSch: $('#cboDeptS_' + dialogId).val()
            , userNmSch: $('#userNmSch' + dialogId).val()
            , useAtSch: 'Y'
        };
        getGridDataParam("/wrk/getUserMList.lims", userNmParams, userDialogGridID);
    });

    //엔터키 이벤트
    $('#userNmSch' + dialogId).keyup(function (e) {
        if (e.keyCode == 13) {
            getUserNmList()
        }
    });

    function getCustomerAuthList() {
        var userNmParams = {
            bplcCode: $('#cboDeptS2_' + dialogId).val()
        };

        getGridDataParam("/wrk/getUserAuthList.lims", userNmParams, customerDialogGridID);
    }

}

function dialogMhrlsUseAllDel(btnId, data, dialogId, selectFunc, prePopupOpenFunc, flag) {
    var html = createDialog(400);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, "■ 전체삭제 범위 확인");
    var topright = "<span class=\"iArea mgR10\"></span>";
    var body = "<div class='mgT15'>"
        + "<div class=\"btnWrap\" style='float:right;'>"
        + "<button type=\"button\" id=\"" + dialogId + "_btnAllDel\" class=\"btn1\">전체삭제</button>"
        + "</div>"
        + "<div class='subCon1' id='" + dialogId + "_innerDiv' style='width:100%; height:100%; margin:0 auto; float:left;'>"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "	<colgroup>"
        + "		<col style=\"width:30%\"></col>"
        + "		<col style=\"width:70%\"></col>"
        + "	</colgroup>"
        + "	<tr>"
        + "		<th style=\"height:30px;\">담당 팀</th>"
        + "		<td>"
        + "			<div class=\"wd100p schClass\" id=\"" + dialogId + "_chrgTeamSeCode\"></div>"
        + "		</td>"
        + "	</tr>"
        + "	<tr>"
        + "		<th style=\"height:30px;\">기기 명</th>"
        + "		<td>"
        + "			<div class=\"wd100p schClass\" id=\"" + dialogId + "_mhrlsSeqno\"></div>"
        + "		</td>"
        + "	</tr>"
        + "	<tr>"
        + "		<th style=\"height:30px;\">사용 일자</th>"
        + "		<td>"
        + "			<div class=\"wd100p schClass\" id=\"" + dialogId + "_oprDte\" style=\"\"/></div>"
        + "		</td>"
        + "	</tr>"

    body += "</table>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        //전체 삭제시에는 조회조건 기기명, 날짜가 필수로 있어야 함.
        var schChrgTeamSeCode = $("#schChrgTeamSeCode").val();
        var shrMhrlsSeqno = $("#shrMhrlsSeqno").val();
        var shrUseBeginDte = $("#shrUseBeginDte").val();
        var shrUseEndDte = $("#shrUseEndDte").val();

        if (!!schChrgTeamSeCode) {
            $("#" + dialogId + "_chrgTeamSeCode").html($("#schChrgTeamSeCode option:selected").text());
        } else {
            $("#" + dialogId + "_chrgTeamSeCode").html("전체");
        }

        if (!!shrMhrlsSeqno) {
            $("#" + dialogId + "_mhrlsSeqno").html($("#shrMhrlsNm").val());
        } else {
            $("#" + dialogId + "_mhrlsSeqno").html("전체");
        }

        if (!!shrUseBeginDte && !!shrUseEndDte) {
            $("#" + dialogId + "_oprDte").html(shrUseBeginDte + " ~ " + shrUseEndDte);
        } else if (!!shrUseBeginDte && !shrUseEndDte) {
            $("#" + dialogId + "_oprDte").html(shrUseBeginDte + " 이후 날짜 전체");
        } else if (!shrUseBeginDte && !!shrUseEndDte) {
            $("#" + dialogId + "_oprDte").html(shrUseEndDte + " 이전 날짜 전체 ");
        } else {
            $("#" + dialogId + "_oprDte").val("전체");
        }

    }, prePopupOpenFunc);


    $("#" + dialogId + "_btnAllDel").click(function () {

        selectFunc(null);

        $("#popupClose_" + dialogId).trigger("click");
    });

}

/**
 * 사용자 신규 등록
 * @author 박상훈
 */
function dialogUserJoin(lang, btnId, data, dialogId, selectFunc) {

    var html = loginCreateDialog();
    html = html.replace(/#dialogId#/g, dialogId);

    var topright = "</span>"
        + "<div class=\"btnWrap\" style=\"margin-top: 23px; border: none\">"
        + "<button type=\"button\" id=\"btnFormReset\" style=\"width:60px; height:26px;\" class=\"btn5\">" + lang.C100000871 + "</button>" /*초기화*/
        + "<button type=\"button\" id=\"btnNewUserSave\" style=\"width:50px; height:26px;\" class=\"btn1 save\">" + lang.C100000760 + "</button>" /*저장*/
        + "</div>";

    var body = ""
        + "<div class='subCon1 mgT10'>"
        + "<form id='dialogFrm" + dialogId + "' name='dialogFrm" + dialogId + "' onsubmit='return false;'>"
        + "<table class='tb3'>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000401 + "</th>" /*부서 명*/
        + "<td>"
        + "<select id='deptCode' name='deptCode'></select>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000452 + "</th>" /*사용자 명*/
        + "<td>"
        + "<input type='text' id='userNm' name='userNm' maxlength='100' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000298 + "</th>" /*로그인 ID*/
        + "<td>"
        + "<input type='text' id='loginId' name='loginId' maxlength='32' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000426 + "</th>" /*비밀번호*/
        + "<td>"
        + "<input type='password' id='password' name='password' class='wd100p' autocomplete='new-password' maxlength='50' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000668 + "</th>" /*이동 전화*/
        + "<td>"
        + "<input type='text' id='moblphon' name='moblphon' maxlength='20' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;'>" + lang.C100000042 + "</th>" /*E-MAIL*/
        + "<td>"
        + "<input type='text' id='email' name='email' maxlength='80' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;'>" + lang.C100000843 + "</th>" /*직위*/
        + "<td>"
        + "<select id='ofcpsCode' name='ofcpsCode'></select>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;'>" + lang.C100000844 + "</th>" /*직책*/
        + "<td>"
        + "<select id='clsfCode' name='clsfCode'></select>"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;'>" + lang.C100000913 + "</th>" /*팀장여부*/
        + "<td style='text-align:left;'>"
        + "<input type='checkbox' id='timhderAt' name='timhderAt' style='width:15px;' />"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th style='text-align:center;' class='necessary'>" + lang.C100000697 + "</th>" /*입사 일자*/
        + "<td style='text-align:left;'>"
        + "<input type='text' id='encpn' name='encpn' readonly />"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#frmLogin").append(html);
    $("#moblphon").prop('placeholder', " ' - ' 표시 제외 ");

    popupInit(btnId, dialogId, function () {
        $('#dialogFrm' + dialogId)[0].reset();
        getPasswordPolicyString();
    });

    //ajaxJsonComboBox('/isu/getBplcCode.lims', 'bplcCode', { 'deptYn': 'N' }, true);
    ajaxJsonComboBox('/isu/getDeptCode.lims', 'deptCode', { 'bestInspctInsttCode': '1000' }, true);
    ajaxJsonComboBox('/isu/getOfcpsAndClsfCode.lims', 'ofcpsCode', { 'upperCmmnCode': 'SY18' }, true);
    ajaxJsonComboBox('/isu/getOfcpsAndClsfCode.lims', 'clsfCode', { 'upperCmmnCode': 'SY19' }, true);
    datePickerCalendar(["encpn"]);

    //초기화
    $("#btnFormReset").click(function () {
        $('#dialogFrm' + dialogId)[0].reset();
    });

    //입력값 체크 후 저장실행
    $('#btnNewUserSave').click(function () {
        var count = 0;
        $('#dialogFrm' + dialogId).find('input').each(function () {
            var nm = $(this).attr("name");
            if (nm == "loginId" || nm == "userNm" || nm == "password"
                || nm == "moblphon" || nm == "encpn") {
                if (!$(this).prop('required')) {
                    if ($(this).val() == '') {
                        count++;
                        $(this).focus();
                        return;
                    }
                }
            }
        }
        );

        var selectDeptCode = $('#dialogFrm' + dialogId + ' #deptCode').val();
        if (selectDeptCode == '')
            count++;

        if (count > 0) {
            alert(lang.C100000943); //필수 사항을 모두 입력해 주세요.
            return false;
        } else {
            userJoinSave();
        }
    });

    //핸드폰 체크
    $('#moblphon').change(function () {
        var mobiNum = $('#moblphon').val();
        var putHyphen = mobiNum.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
        var mobiRegExp = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!putHyphen.match(mobiRegExp)) {
            alert(lang.C100000953); //핸드폰 번호가 올바르지 않습니다.
            $('#moblphon').val('');
        } else {
            //하이픈 넣은상태로 값 세팅
            $('#moblphon').val(putHyphen);
        }
    });

    //사업장 변경
    // $('#bplcCode').change(function (e) {
    //     var bplcCode = $('#bplcCode').val();
    //     if (!!bplcCode) {
    //         ajaxJsonComboBox('/isu/getDeptCode.lims', 'deptCode', { 'deptYn': 'Y', 'bestInspctInsttCode': bplcCode }, true);
    //     } else {
    //         $("select#deptCode option").remove();
    //     }
    // });

    //이메일 체크
    $('#email').change(function () {
        var emailVal = $('#email').val();
        var regExp = /^([\w\.\_\-])*[a-zA-Z0-9]+([\w\.\_\-])*([a-zA-Z0-9])+([\w\.\_\-])+@([a-zA-Z0-9]+\.)+[a-zA-Z0-9]{2,8}$/i;
        if (!emailVal.match(regExp)) {
            alert(lang.C100000673); //이메일 형식이 올바르지 않습니다.
            $('#email').val('');
        }
    });

    //비밀번호 정책에 맞는 placeholder 설정 필요없다고하셔서 주석처리
    function getPasswordPolicyString() {
        // customAjax({'url':'/isu/getPasswordPolicyString.lims','successFunc':function(data) {
        // 		if (data.txt != 'N') {
        // 			$('#password').attr('placeholder',data.txt);
        // 		} else {
        // 			$('#password').attr('placeholder',lang.C100001016);
        // 		}
        // 	}
        // });
    }

    function userJoinSave() {
        ajaxJsonForm('/isu/insUserJoin.lims', 'dialogFrm' + dialogId, function (data) {
            if (data == 1) {
                alert(lang.C100000765); //저장되었습니다
                $('#dialogFrm' + dialogId)[0].reset();
            } else if (data == 99) {
                alert(lang.C100000289); //로그인 ID가 중복되었습니다.
            } else if (data == 100) {
                alert(lang.C100000427); //비밀번호 정책에 맞는 패스워드를 사용해 주세요.
            } else {
                alert(lang.C100000294); //등록실패
            }
        });
    }

    $("#btnPopApp").click(function () {
        $("#popupClose_" + dialogId).trigger("click"); //close popup
    });
}

/**
 * 원료사 Audit 지적사항 - 찾기 dialog
 * @author 박기윤
 */
function dialogVendorAudit(btnId, data, dialogId, gbn, selectFunc) {

    var col = [];

    auigridCol(col);

    col.addColumnCustom("entrpsNm", lang.C100000629, "*", true); /* 원료사명 */
    col.addColumnCustom("sj", lang.C100000802, "*", true); /* 제목 */
    col.addColumnCustom("auditRceptNo", lang.C100000793, "*", true); /* 접수번호 */
    col.addColumnCustom("writngDte", lang.C100000728, "7%", true); /* 작성일자 */
    col.addColumnCustom("fdrmGubun", lang.C100000205, "5%", true); /* 구분 */
    col.addColumnCustom("mtrilNm", lang.C100000276, "*", true); /* 대상원료 */
    col.addColumnCustom("lgstrMatterNum", lang.C100000840, "*", true); /* 지적사항(Critical) */
    col.addColumnCustom("lgstrMatterSemiNum", lang.C100000841, "*", true);	/* 지적사항(Semi-Critical) */
    col.addColumnCustom("rcmndMatterNum", lang.C100000210, "8%", true);  /* 권고사항 */
    col.addColumnCustom("lgstrMatterSum", lang.C100000842, "*", true); /* 지적사항합계 */

    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(1300);
    html = html.replace(/#dialogId#/g, dialogId);

    var title = "";
    if (gbn == "S") {
        title = lang.C100001013;
    } else {
        title = lang.C100001014;
    }

    html = html.replace(/#title#/g, title);
    var topright = "";

    var body = ""
        + "<div class='btnWrap' style='margin-top: 10px; display: block; text-align: right;'>"
        + "<button type='button' id='btn_select" + dialogId + "' class='search'>" + lang.C100000767 + "</button>"
        + "</div>"
        + "<div class='subCon1 mgT10'>"
        + "<form id='dialogFrm" + dialogId + "' name='dialogFrm" + dialogId + "' onsubmit='return false;'>"
        + "<table cellpadding='0' cellspacing='0' width='100%' class='subTable1'>"
        + "<colgroup>"
        + "<col style='width:10%'></col>"
        + "<col style='width:15%'></col>"
        + "<col style='width:10%'></col>"
        + "<col style='width:15%'></col>"
        + "<col style='width:10%'></col>"
        + "<col style='width:15%'></col>"
        + "<col style='width:10%'></col>"
        + "<col style='width:15%'></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th style='text-align:center;'>" + lang.C100000793 + "</th>"
        + "<td>"
        + "<input type='text' id='schAuditRceptNo' name='schAuditRceptNo' class='wd100p searchClass'>"
        + "</td>"
        + "<th style='text-align:center;'>" + lang.C100000728 + "</th>"
        + "<td>"
        + "<input type='text' class='searchClass wd6p' name='schWritngStDte' id='schWritngStDte' style='min-width: 6em;'> ~ "
        + "<input type='text' class='searchClass wd6p' name='schWritngEndDte' id='schWritngEndDte' style='margin-left:5px; min-width: 6em;'>"
        + "</td>"
        + "<th style='text-align:center;'>" + lang.C100000629 + "</th>"
        + "<td>"
        + "<input type='text' id='schEntrpsNm' name='schEntrpsNm' class='wd100p searchClass'>"
        + "</td>"
        + "<th style='text-align:center;'>" + lang.C100000276 + "</th>"
        + "<td>"
        + "<input type='text' id='schMtrilNm' name='schMtrilNm' class='wd100p searchClass'>"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "<input type='hidden' id='selectParam'>"
        + "</form>"
        + "</div>"
        + "<div class='subCon2'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        $('#dialogFrm' + dialogId)[0].reset();
        $("#selectParam").val(gbn);
        AUIGrid.resize(dialogGridID);
        datePickerCalendar(["schWritngStDte", "schWritngEndDte"], true, ["MM", -1]);
    });

    dialogGridID = createAUIGrid(col, dialogGridID);

    function getAuditMList() {
        if ($("#selectParam").val() == "S") {
            var url = "/qa/getVendorAuditMList.lims"
        } else {
            var url = "/qa/getCstmrAuditMList.lims"
        }
        getGridDataForm(url, "dialogFrm" + dialogId, dialogGridID);
    }

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        var gridItem = event.item;

        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);
        $("#popupClose_" + dialogId).trigger("click");
    })

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getAuditMList();
        }
    });

    $("#btn_select" + dialogId).click(function () {
        getAuditMList();
    })


    //close popup
    $("#btnPopApp").click(function () {
        $("#popupClose_" + dialogId).trigger("click");
    });
}

//고객사 시험항목 팝업
function dialogMtrilSdspc(btnId, data, dialogId, selectFunc, flag, preOpenFunc) {

    var exprIemDialogColumnLayout = [];
    auigridCol(exprIemDialogColumnLayout);

    exprIemDialogColumnLayout.addColumnCustom("mtrilCode", lang.C000000837, "*", true, false); /*자재 일련번호*/
    exprIemDialogColumnLayout.addColumnCustom("mtrilNm", lang.C000000228, "*", true, false); /*자재 명*/

    exprIemDialogColumnLayout.addColumnCustom("prductSdspcSeqno", lang.C000000279, "*", false, false); /*제품 기준규격 일련번호*/
    exprIemDialogColumnLayout.addColumnCustom("expriemSeqno", lang.C000000838, "*", false, false); /*시험항목 일련번호*/

    exprIemDialogColumnLayout.addColumnCustom("expriemClCode", lang.C000000813, "*", false, false); /*시험항목 그룹 코드*/
    exprIemDialogColumnLayout.addColumnCustom("expriemCl", lang.C000000938, "*", true, false); /*시험항목 그룹명*/
    exprIemDialogColumnLayout.addColumnCustom("expriemNm", lang.C000000204, "*", true, false); /*시험항목 명*/
    exprIemDialogColumnLayout.addColumnCustom("unitSeqno", lang.C000001263, "*", false, false); /*제품 단위 코드*/
    exprIemDialogColumnLayout.addColumnCustom("unitNm", lang.C000000280, "*", true, false); /*제품 단위*/
    exprIemDialogColumnLayout.addColumnCustom("jdgmntFomCode", lang.C000001264, "*", false, false); /*판정 형식 코드*/
    exprIemDialogColumnLayout.addColumnCustom("jdgmntFomNm", lang.C000000281, "*", true, false); /*판정 형식*/

    exprIemDialogColumnLayout.addColumnCustom("mummValue", lang.C000000282, "*", false, false); /*LCL*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "firstMummValue", lang.C000000284, null, false, null, 1); /*1차 LCL*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "firstMummValueSeCode", lang.C000000285, null, false, null, 1); /*1차 LCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "firstMummValueSeNm", lang.C000000285, null, false, null, 1); /*1차 LCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "scdMummValue", lang.C000000286, null, false, null, 1); /*2차 LCL*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "scdMummValueSeCode", lang.C000000287, null, false, null, 1); /*2차 LCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mummValue", "scdMummValueSeNm", lang.C000000287, null, false, null, 1); /*2차 LCL 단위*/

    exprIemDialogColumnLayout.addColumnCustom("mxmmValue", lang.C000000283, "*/*", false, false); /*UCL*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "firstMxmmValue", lang.C000000288, null, false, null, 1); /*1차 UCL*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "firstMxmmValueSeCode", lang.C000000289, null, false, null, 1); /*1차 UCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "firstMxmmValueSeNm", lang.C000000289, null, false, null, 1); /*1차 UCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "scdMxmmValue", lang.C000000290, null, false, null, 1); /*2차 UCL*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "scdMxmmValueSeCode", lang.C000000291, null, false, null, 1); /*2차 UCL 단위*/
    exprIemDialogColumnLayout.addChildColumn("mxmmValue", "scdMxmmValueSeNm", lang.C000000291, null, false, null, 1); /*2차 UCL 단위*/

    exprIemDialogColumnLayout.addColumnCustom("extrl", "SPEC", "*", false, false); //SPEC
    exprIemDialogColumnLayout.addChildColumn("extrl", "extrlMummValue", "LCL", "*", false, false); //LCL
    exprIemDialogColumnLayout.addChildColumn("extrl", "extrlMummValueSeCode", "LCL단위", "*", false, false); //LCL단위
    exprIemDialogColumnLayout.addChildColumn("extrl", "extrlMxmmValue", "UCL", "*", false, false); //UCL
    exprIemDialogColumnLayout.addChildColumn("extrl", "extrlMxmmValueSeCode", "UCL단위", "*", false, false); //UCL단위

    exprIemDialogColumnLayout.addColumnCustom("spsTextStdr", lang.C000000236, "*", false, false); /*텍스트 기준*/
    exprIemDialogColumnLayout.addColumnCustom("spsMarkCphr", lang.C000000292, "*", false, false); /*제품 표기 자리수*/

    var dialogPrductSdspcPros = {
        editable: false, // 편집 가능 여부 (기본값 : false)
        selectionMode: "multipleCells",// 셀 선택모드 (기본값: singleCell)
        showRowCheckColumn: true,
        showRowAllCheckBox: true
    }

    var dialogGridID = "grid_" + dialogId;
    var html = createDialog(700);

    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, lang.C000000664); /* 시험항목 목록 */
    var topright = "<span class=\"iArea mgR10\"></span>"
    var body = "<div class='mgT15'>"
        + "<div class=\"btnWrap fR\" style=\"margin-bottom: 10px;\">"
        + "<input type=\"text\" id=\"" + dialogId + "_shrPopPrductNm\" style=\"width:150px; margin-right:3px; float:left;\" disabled>"
        // + "<select id=\""+dialogId+"_shrExpriemClCode\" name=\"shrExpriemClCode\" class=\"searchClass\" style=\"width:100px; margin-right:3px; float:left;\" ></select>"
        + "<input type=\"text\" id=\"" + dialogId + "_shrExpriemNm\" name=\"shrExpriemNm\" class=\"searchClass fL\"  placeholder=\"" + lang.C000000204 + "\">" /*시험항목 명*/
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopAdd\" class=\"btn5 fL\">" + lang.C100000880 + "</button>"  /*추가*/
        + "<button type=\"button\" id=\"" + dialogId + "_btnExprIemPopSearch\" class=\"search fL\">" + lang.C100000767 + "</button>" /*조회*/
        + "</div>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:450px; margin:0 auto; clear:both;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
    }, preOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, dialogPrductSdspcPros);

    function getExprIemList() {
        var gridData = AUIGrid.getGridData("#" + data.girdId);
        var exprGridData = AUIGrid.getGridData("#" + data.requestList);
        var gridDataArray = [];
        var gridDataExpriemArray = [];
        var gridDataPrductSdspcArray = [];

        //			if(gridData == null || gridData == "" ){
        //				alert("자재정보를 추가해 주세요.");
        //				return;
        //			}

        for (var i = 0; i < gridData.length; i++) {
            gridDataArray[i] = gridData[i]["mtrilSeqno"];
        }

        for (var i = 0; i < exprGridData.length; i++) {
            gridDataExpriemArray[i] = exprGridData[i]["mtrilSdspcSeqno"];
        }

        var params = {
            mtrilSeqno: $("#" + data.mtrilSeqno).val()
            , shrExpriemNm: $("#" + dialogId + "_shrExpriemNm").val()
            , shrExpriemClCode: $("#" + dialogId + "_shrExpriemClCode").val()
            , shrPrductSdspcArray: gridDataArray
            , gridDataExpriemArray: gridDataExpriemArray
        };

        getGridDataParam("/wrk/getPrductExpriemList.lims", params, dialogGridID);
    }

    $("#" + dialogId + "_btnExprIemPopAdd").click(function () {
        // 그리드 데이터에서 isActive 필드의 값이 Active 인 행 아이템 모두 반환
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        console.log(checkedItems);
        if (checkedItems.length == 0)
            return false;

        if (flag) {
            if (checkedItems.length > 1) {
                alert(lang.C000000671); /*시험항목은 한개만 선택 가능합니다.*/
                return false;
            }
        } else if (checkedItems.length == 0) {
            alert(lang.C000000209); /*선택된 시험항목이 없습니다.*/
            return false;
        }

        selectFunc(checkedItems);

        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#" + dialogId + "_btnExprIemPopSearch").click(function () {
        getExprIemList();
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, "ready", function (event) {
        gridColResize(dialogGridID, "2");	// 1, 2가 있으니 화면에 맞게 적용
    });

    checkBoxGridEvent(dialogGridID, "checkExprIem");

    //엔터키 이벤트
    $("#" + dialogId + "_shrExpriemNm").keyup(function (e) {
        if (e.keyCode == 13) {
            getExprIemList();
        }
    });
}

//협력사 COA 팝업
function dialogVendorLotNo(btnId, data, dialogId, selectFunc) {

    var vendorLotNoColumnLayout = [];
    auigridCol(vendorLotNoColumnLayout);

    vendorLotNoColumnLayout
        .addColumnCustom('reqestSeqno', 'reqestSeqno', null, false)
        .addColumnCustom('reqestDeptNm', lang.C100000986, '*', true, false) //의뢰부서
        .addColumnCustom('reqestNo', lang.C000001802, '*', true, false) //의뢰번호
        .addColumnCustom('mtrilNm', lang.C000000228, '*', true, false) //제품명
        .addColumnCustom('custlabNm', lang.C100001352, '*', true, false) //분석실
        .addColumnCustom('inspctTyCode', '', '*', false, false) //검사유형
        .addColumnCustom('inspctTyCodeNm', lang.C000001794, '*', true, false) //검사유형명
        .addColumnCustom('mnfcturDte', lang.C000000524, '*', true, false) //제조일자
        .addColumnCustom('vendorLotNo', lang.C000001800, '*', true, false) //협력업체 Lot No.
        .addColumnCustom('rm', lang.C000000096, '*', true, false); //비고

    var vendorLotNoPros = {
        editable: false,
        selectionMode: 'singleRow'
    };

    var dialogGridID = 'grid_' + dialogId;
    var html = createDialog(1050);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C000001023); /* 협력사 COA 목록 */
    var topright = "";
    var body = ""
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap fR\" style=\"position: inherit\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnVendorLotNoSearch\" class=\"search\">" + lang.C000000002 + "</button>" /*조회*/
        + "</div>"
        + "<form id=\"" + dialogId + "_vendorLotNoFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:30%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>"+lang.C100000986+"</th>" /* 의뢰 부서 */
        + "<td><select id=\"" + dialogId + "_reqestDeptCodeSch\" name=\"reqestDeptCodeSch\"></select></td>"
        + "<th>"+lang.C100000717+"</th>" /* 제품 명 */
        + "<td style=\"text-align: left;\">"
        + "<input type=\"text\" id=\"" + dialogId + "_mtrilNmSch\" name=\"mtrilNmSch\">"
        + "</td>"
        + "<th>"+lang.C100000803+"</th>" /* 제조 일자 */
        + "<td>"
        + "<input type=\"text\" id=\"" + dialogId + "_stMnfcturDteSch\" name=\"stMnfcturDteSch\" class=\"dateChk wd6p\" readonly style=\"min-width: 6em;\"> ~"
        + "<input type=\"text\" id=\"" + dialogId + "_enMnfcturDteSch\" name=\"enMnfcturDteSch\" class=\"dateChk wd6p\" readonly style=\"min-width: 6em;\">"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
    });

    ajaxJsonComboBox('/wrk/getDeptComboList.lims',dialogId + "_reqestDeptCodeSch",{ bestInspctInsttCode: '1000' },true);
    datePickerCalendar([dialogId + '_stMnfcturDteSch', dialogId + '_enMnfcturDteSch'], true, ['MM', -1]);

    dialogGridID = createAUIGrid(vendorLotNoColumnLayout, dialogGridID, vendorLotNoPros);

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        $('#reqestFrm #vendorLotNo').val(event.item.vendorLotNo);
        $('#reqestFrm #vendorCoaReqestSeqno').val(event.item.reqestSeqno);
        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#" + dialogId + "_btnVendorLotNoSearch").click(function () {
        getVenderLotNoList();
    });

    function getVenderLotNoList() {
        var formData = $('#' + dialogId + '_vendorLotNoFrm').serializeObject();
        getGridDataParam("/req/getVendorLotNoList.lims", formData, dialogGridID);
    }

    $("#" + dialogId + "_mtrilNmSch").keyup(function (e) {
        if (e.keyCode == 13)
            getVenderLotNoList();
    });
}

// COA증적등록
function dialogEvidenceIns(btnId, dialogId, fileGridId) {
    var getGridData;
    var dialogGridId = "grid_" + dialogId;
    var btnSave = "btnSave_" + dialogId
    var html = createDialog(930);
    var dropzoneArea_evidence;
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001098); /*COA 증적등록  LAS 정보*/
    var topright = "";
    var body = "<div>"
        + "<div class='btnWrap' style='top :37px; margin-bottom:10px; right:-10px; width:100%'>"
        + "<button type='button' id='" + btnSave + "' class='save' style='float: right'>" + lang.C100000760 + "</button>&nbsp;" /* 저장 */
        + "</div>"
        + "<br>"
        + "<div id='main_wrap_save'>"
        + "<form id='dialogFrm" + dialogId + "' name='dialogFrm" + dialogId + "'>"
        + "<table class='tb3' style='border-top: 1px solid #ff7faa;'>"
        + "<tr>"
        + "<th class='taCt vaMd' style='min-width:150px; text-align: center;'>" + lang.C100000860 + "</th>" /* 첨부파일 */
        + "<td colspan='7'>"
        + "<div id='dropzoneArea_evidence'></div>"
        + "<input type='hidden' id='coaEvdncAtchmnflSeqno' name='coaEvdncAtchmnflSeqno' class='wd33p' style='min-width:10em;'>"
        + "<input type='button' id='btnSave_file' name='btnSave_file' style='display:none;'>"
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</Form>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function (e) {
        AUIGrid.resize(dialogGridId);
    });

    //파일 드랍존 생성
    dropzoneArea_evidence = DDFC.bind().EventHandler("dropzoneArea_evidence", { btnId: "#btnSave_file", maxFiles: 5 });

    // 첨부파일 클릭 이벤트
    $("#" + btnId).click(function () {
        getGridData = AUIGrid.getGridData(fileGridId);
        var getRowIndex = AUIGrid.getSelectedItems(fileGridId)[0].rowIndex;
        $("#coaEvdncAtchmnflSeqno").val(getGridData[getRowIndex].coaEvdncAtchmnflSeqno);
        dropzoneArea_evidence.getFiles($("#coaEvdncAtchmnflSeqno").val());
    });

    // 저장 클릭 이벤트
    $("#" + btnSave).click(function () {
        atchmnflSave();
    });

    //팝업창 닫을 때 발행목록 재조회 (모든 첨부파일 삭제 시, 증적완료등록 여부 "X"처리하기 위함)
    $("#popupClose_" + dialogId).click(function () {
        var gridData = AUIGrid.getSelectedItems(fileGridId);

        customAjax({
            "url": "/test/getCoaDetail.lims",
            data: { reqestSeqno: gridData[0]["item"]["reqestSeqno"] },
            "successFunc": function (data) {
                AUIGrid.setGridData(coaOccurrenceList, data["coaDetailInfo"]);
            }
        });
    });

    function atchmnflSave() {
        var gridData = AUIGrid.getSelectedItems(fileGridId);
        var fileLength = $(".uploaded-image").length;

        // 첨부파일이 있을 시
        if (fileLength > 0) {
            $("#btnSave_file").click();
            dropzoneArea_evidence.on("uploadComplete", function (event, fileIdx) {
                if (fileIdx == -1) {
                    alert(lang.C100000864) /* 첨부파일 저장에 실패하였습니다. */
                } else {
                    $("#coaEvdncAtchmnflSeqno").val(fileIdx);
                    var params = {
                        coaSeqno: gridData[0]["item"]["coaSeqno"],
                        coaEvdncAtchmnflSeqno: $("#coaEvdncAtchmnflSeqno").val()
                    };

                    customAjax({
                        "url": "/test/updfileCoa.lims",
                        "data": params,
                        "successFunc": function (data) {
                            $("#popupClose_" + dialogId).trigger("click");
                            alert(lang.C100000762); /*저장되었습니다.*/
                        }
                    });

                }
            });
        } else { // 첨부파일이 없을 시 
            alert(lang.C100001100) /*파일을 등록해주세요.*/
        }
    }
}

//차트 value
function dialogChartValue(btnId, dialogId) {
    var dialogGridId = "grid_" + dialogId;
    var columnLayout = {
        requestDtlGrid: []
    };

    auigridCol(columnLayout.requestDtlGrid);
    columnLayout.requestDtlGrid.addColumn("reqestSeqno", "reqestSeqno", "*", false, false)
                                .addColumn("reqestNo", '의뢰 번호')  
                                .addColumn("sploreNm", '시료 정보')  
                                .addColumn("resultRegisterId", lang.C100001094) // 결과입력자 
                                .addColumn("expriemNm", lang.C100000555) // 시험항목 
                                .addColumn("exprOdr", lang.C100001116) // 시험 차수 
                                .addColumn("lclUcl", lang.C100001096) // lcl ~ ucl 
                                .addColumn("unitNm", lang.C100000269) // 단위 명 
                                .addColumn("resultValue", lang.C100000150) // 결과 값 
                                .addColumn("resultRegistDte", lang.C100000151) // 결과 입력일자

    var html = createDialog(1400);
    
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "의뢰별 데이터");
    
    var topright = ""
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridId + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");


    $("#sub_wrap").append(html);


    dialogGridId = createAUIGrid(columnLayout.requestDtlGrid, dialogGridId);


    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridId);
        getGridDataParam("/src/getDialogClickList.lims", {reqestSeqno: selectReqSeqno}, dialogGridId);
    });

}

function dialogUserQualfRecDialog(btnId, dialogId, prentGridId) {

    var gridQualfRecCol = [];
    var dialogGridId = "grid_" + dialogId;
    var numberColPros_n = {
        dataType: "numeric",
        formatString: "#,##0",
        editRenderer: {
            onlyNumeric: true,
            maxlength: 10
        }
    };
    auigridCol(gridQualfRecCol);

    gridQualfRecCol.addColumnCustom("deptNm", lang.C000000106, null, true, false); /* 부서 */
    gridQualfRecCol.addColumnCustom("userNm", lang.C000000100, null, true, false); /* 사용자 명 */
    gridQualfRecCol.addColumnCustom("encpn", "입사일자", null, true, false); /* 입사일자 */
    gridQualfRecCol.addColumnCustom("diffYear", "입사연차", null, true, false); /* 입사연차 */
    gridQualfRecCol.addColumnCustom("reformDte", lang.C000000115, null, true, false); /* 갱신일자 */
    gridQualfRecCol.addColumnCustom("qualfTotScore", "자격인정 총점", null, true, false, numberColPros_n); /* 자격인정 총점 */
    gridQualfRecCol.addColumnCustom("qualfJdgmntNm", "자격인정 결과", null, true, false); /* 자격인정 결과 */
    gridQualfRecCol.addColumnCustom("elgblTotScore", "적격성평가 총점", null, true, false, numberColPros_n); /* 적격성평가 총점 */
    gridQualfRecCol.addColumnCustom("elgblJdgmntNm", "적격성평가 결과", null, true, false); /* 적격성평가 결과*/
    //그리드 생성





    var html = createDialog(850);

    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "평가 이력");
    var topright = "<span class=\"iArea mgR10\"></span>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridId + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function (e) {
        AUIGrid.resize(dialogGridId);

        var gridData = AUIGrid.getSelectedItems(prentGridId);
        var params = {
            userId: gridData[0]["item"]["userId"]
        }

        getGridDataParam("/rsc/getQualfRec.lims", params, dialogGridId);
    });

    dialogGridId = createAUIGrid(gridQualfRecCol, dialogGridId);
}


function dialogtext(btnId, dialogId, reason, selectFunc) {
    var html = createDialog(840);
    html = html.replace(/#dialogId#/g, dialogId);

    html = html.replace(/#title#/g, " 삭제 사유");
    var topright =
        "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"btnReleasePopSelect\" class=\"btn5\">저장</button>"
        + "</div>"
        + "<div class=\"subContent\" style=\"padding : 0;\">"
        + "<div class=\"subCon1\" style=\"margin-top: 10px;\">"
        + "<textarea  id=\"" + dialogId + "reason\" name=\"" + dialogId + "reason\" class=\"wd100p hei200\"></textarea>"
        + "</div>"
        + "</div>";
    var body = "<div class='mgT15'>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        $("#" + dialogId + "reason")[0].value = '';

    });

    $("#popup_" + dialogId + " #btnReleasePopSelect").click(function () { // 선택 클릭 이벤트
        reason = $("#" + dialogId + "reason")[0].value;
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(reason);
        $('#popupClose_' + dialogId).trigger('click');
    });



}

/**
 * PO 관리 팝업
 */
function dialogShipmnt(btnId, data, dialogId, selectFunc, preOpenFunc) {
    var shipmntDialogColumnLayout = [];
    auigridCol(shipmntDialogColumnLayout);

    shipmntDialogColumnLayout.addColumn("infKey", lang.C100001186, null, false) //인터페이스 키
    shipmntDialogColumnLayout.addColumn("infTimeStr", lang.C100001187, null, false) //인터페이스 수신일시
    shipmntDialogColumnLayout.addColumn("werks", lang.C100001188, null, true) //플랜트
    shipmntDialogColumnLayout.addColumn("matnr", lang.C100001189, null, true) //자재 번호
    shipmntDialogColumnLayout.addColumn("kunnr", lang.C100001190, null, true) //고객 번호
    shipmntDialogColumnLayout.addColumn("vdatu", lang.C100001191, null, true) //납품요청일
    shipmntDialogColumnLayout.addColumn("prueflos", lang.C100001192, null, true) //검사 로트 번호
    shipmntDialogColumnLayout.addColumn("charg", lang.C100001193, null, true) //배치 번호
    shipmntDialogColumnLayout.addColumn("ebeln", lang.C100001194, null, true) //PO 번호
    shipmntDialogColumnLayout.addColumn("licenseNumber", lang.C100000851, null, true) //차량번호
    shipmntDialogColumnLayout.addColumn("kwmeng", lang.C100001195, null, true) //S/O수량
    shipmntDialogColumnLayout.addColumn("vrkme", lang.C100001196, null, true) //판매 단위
    shipmntDialogColumnLayout.addColumn("lfimg", lang.C100001197, null, true) //실제수량납품_판매단위
    shipmntDialogColumnLayout.addColumn("meins", lang.C100001198, null, true) //기본 단위
    shipmntDialogColumnLayout.addColumn("zbottle1", lang.C100001199, null, true) //용기 번호 1
    shipmntDialogColumnLayout.addColumn("zbottle2", lang.C100001200, null, true) //용기 번호 2
    shipmntDialogColumnLayout.addColumn("zbottle3", lang.C100001201, null, true) //용기 번호 3
    shipmntDialogColumnLayout.addColumn("vbeln", lang.C100001202, null, true) //판매 관리 문서 번호_SONO
    shipmntDialogColumnLayout.addColumn("vbeln2", lang.C100001202, null, true) //판매 관리 문서 번호_DONO
    shipmntDialogColumnLayout.addColumn("zstat", lang.C100001203, null, true) //상태
    shipmntDialogColumnLayout.addColumn("infResult", lang.C100001204, null, true) //처리 결과
    shipmntDialogColumnLayout.addColumn("infDatetime", lang.C100001205, null, true) //처리 시간
    shipmntDialogColumnLayout.addColumn("infErrMsg", lang.C100001206, null, true) //에러 메시지

    var dialogGridID = "grid_" + dialogId;

    var html = createDialog(900);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001207);
    var topright = "<span class=\"iArea mgR10\"></span>"

    var body = ''
        + "<div class=\"subContent\" style=\"padding: 30px 0px;\">"
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnPrductPopSearch\" class=\"search\" >" + lang.C000000002 + "</button>" /*조회*/
        + "</div>"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:30%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C100000716 + "</th>"
        + "<td><select id=\"" + dialogId + "_mtrilBox\" name=\"popMtrilBox\" style='width:100%;'>" +
        +					"</select></td>"
        + "<th>" + lang.C100001191 + "</th>" /*납품요청일*/
        + "<td style=\"text-align:left;\"><input class=\"wd45p\" type=\"text\" id=\"" + dialogId + "_dialogVdatuSt\" name=\"dialogVdatuSt\"/>~&nbsp;<input type=\"text\" class=\"wd45p\" id=\"" + dialogId + "_dialogVdatuEd\" name=\"dialogVdatuEd\"/></td>"
        + "<th>" + lang.C100001193 + "</th>" /*배치 번호*/
        + "<td><input type=\"text\" id=\"" + dialogId + "_popCharg\" name=\"popCharg\"></td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        var gridData = AUIGrid.getSelectedRows("#" + data.girdId);
        ajaxSelect2Box({ ajaxUrl: "/qa/getMtrilNmCombo.lims", elementId: dialogId + '_mtrilBox', ajaxParam: { "bplcCode": gridData[0].bplcCode }, defaultVal: gridData[0].mtrilSeqno });
        getShipmntList();
    }, preOpenFunc);

    dialogGridID = createAUIGrid(shipmntDialogColumnLayout, dialogGridID);

    datePickerCalendar([dialogId + "_dialogVdatuSt", dialogId + "_dialogVdatuEd"], true, ["MM", 0]);

    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2');	// 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, 'cellDoubleClick', function (event) {
        if (selectFunc != undefined && selectFunc != null) {
            // 더블클릭을 할때 mssql에서 삭제 여부 확인후 림스 테이블 삭제 해줌
            var params = {
                infKey: event.item.infKey,
                infTimeStr: event.item.infTimeStr
            };
            customAjax({
                "url": "/test/getDelAt.lims",
                "data": params
            }).then(function (data) {
                if (data == "D") {
                    alert(lang.C100001208) //이미 삭제된 항목 입니다.
                } else {
                    selectFunc(event.item);
                    $('#popupClose_' + dialogId).trigger('click');
                }
            });
        }
    });

    function getShipmntList() {
        var gridData = AUIGrid.getSelectedRows("#" + data.girdId);
        var popupParams = {}
        if ($('#' + dialogId + '_mtrilBox option:selected').val() == undefined) {
            popupParams = {
                popMtrilBox: gridData[0].mtrilSeqno,
                popCharg: $('#' + dialogId + '_popCharg').val(),
                dialogVdatuSt: $('#' + dialogId + '_dialogVdatuSt').val(),
                dialogVdatuEd: $('#' + dialogId + '_dialogVdatuEd').val(),
                bplcCode: gridData[0].bplcCode
            }
        } else {
            popupParams = {
                popMtrilBox: $('#' + dialogId + '_mtrilBox option:selected').val(),
                popCharg: $('#' + dialogId + '_popCharg').val(),
                dialogVdatuSt: $('#' + dialogId + '_dialogVdatuSt').val(),
                dialogVdatuEd: $('#' + dialogId + '_dialogVdatuEd').val(),
                bplcCode: gridData[0].bplcCode
            }
        }
        getGridDataParam('/test/getShipmntList.lims', popupParams, dialogGridID);
    }

    $('#' + dialogId + '_btnPrductPopSearch').click(function () {
        getShipmntList();
    });

    $('.searchClass').keypress(function (e) {
        if (e.which == 13) {
            getShipmntList();
        }
    });



}

// 예방 조치 문구 팝업
function dialogPrevnt(btnId, data, dialogId, gridId, selectFunc, preOpenFunc) {
    var gridId = "#" + gridId;
    var gridPrevntCol = [];
    var dialogGridId = "grid_" + dialogId;
    var gridProp = {
        "showRowCheckColumn": true,
        showRowAllCheckBox: false,

        rowCheckDisabledFunction: function (rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId); // 페이지
            var nowDt = currentDate();
            var count = 0;

            for (var i = 0; i < getMasterGridData.length; i++) {
                // 1. 페이지 마스터 그리드의 바코드와 같은게 선택되었다면 선택 x
                if (item.cmmnCode == getMasterGridData[i].cmmnCode) {
                    count++;
                    return false; // false 반환하면 disabled 처리됨
                }
            }

            var checkitem = AUIGrid.getCheckedRowItems(dialogGridId);
            varchecked = item.checked;
            for (var i = 0; i < checkitem.length; i++) {
                if (item.tmprField1Value == checkitem[i].item.tmprField1Value)
                    count++;
            }
            for (var i = 0; i < getMasterGridData.length; i++) {
                if (item.tmprField1Value == getMasterGridData[i].tmprField3Value) {
                    count++;
                }
            }

            if (count >= 2) {
                for (var i = 0; i < checkitem.length; i++) {
                    if (item.cmmnCode == checkitem[i].item.cmmnCode)
                        return true;
                }
                return false;
            } else {
                return true;
            }



        }
    };

    auigridCol(gridPrevntCol);
    gridPrevntCol.addColumnCustom("cmmnCodeNm", lang.C100001166, "60%", true, false); /* 상세 코드 명 */
    gridPrevntCol.addColumnCustom("cmmnCode", lang.C100001166, "0%", false, false); /* 상세 코드 */
    gridPrevntCol.addColumnCustom("cmmnCodeRm", lang.C100001166, "0%", false, false); /* 코드 설명 */
    gridPrevntCol.addColumnCustom("sortOrdr", lang.C100001166, "0%", false, false); /* 정렬 순서 */
    gridPrevntCol.addColumnCustom("tmprField1Value", lang.C100001167, "20%", true, false); /* 예방 조치 구분 */
    gridPrevntCol.addColumnCustom("tmprField2Value", lang.C100001168, "20%", true, false); /* 예방 조치 구분 코드 */
    gridPrevntCol.addColumnCustom("disGubun", 'disGubun', "*", false, false); 	      // disabled 상태 구분값

    var html = createDialog(1050);

    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001169);
    var flexbox = "<div style='display: flex;'>"
    var topright = "<div class=\"alignRight\" style='text-align:right; width:85%;'>"
        + "<select id=\"" + dialogId + "classification\" style='margin-right:5px;'></select>"
        + "</span>"
        + "<div class=\"btnWrap\" style=\"margin-top:10px;\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnadd\" class=\"btn5\">" + lang.C100000880 + "</button>" /*추가*/
        + "<button type=\"button\" id=\"" + dialogId + "_btnSearch\" class=\"search\">" + lang.C000000002 + "</button>" /*조회*/
        + "</div>";
    var body = ""
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridId + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#flexbox#/g, flexbox);
    html = html.replace(/#sameline#/g, topright);
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    $("#sub_wrap").append(html);
    $(".addstyle").css('margin-top', '13px');
    $(".addstyle").css('width', '25%');

    dialogGridId = createAUIGrid(gridPrevntCol, dialogGridId, gridProp);

    popupInit(btnId, dialogId, function (e) {
        // 팝업띄울 땐, 항상 그리드 데이터 재조회하기 위함.
        $.when(
            ajaxJsonComboBox('/com/getPrevntMsgGbnList.lims', 'prevntPopclassification', null, true)
        ).then(function () {
            getPreventMsgList()
        });
        AUIGrid.resize(dialogGridId);
    });

    AUIGrid.bind(dialogGridId, "rowCheckClick", function (event) {
        var item = event.item;
        var checkitem = AUIGrid.getCheckedRowItems(dialogGridId);
        var count = 0;
        varchecked = event.checked;

        for (var i = 0; i < checkitem.length; i++) {
            if (item.tmprField1Value == checkitem[i].item.tmprField1Value)
                count++;
        }

        MasterData = AUIGrid.getGridData(gridId);
        for (var i = 0; i < MasterData.length; i++) {
            if (item.tmprField1Value == MasterData[i].tmprField3Value) {
                count++;
            }
        }

        if (count > 2) {
            AUIGrid.addUncheckedRowsByValue(dialogGridId, "cmmnCode", item.cmmnCode);
            warn(lang.C100001165);  /* 예방조치구분 별로 최대 2개까지만 등록 가능합니다. */
        }
    });

    // 조회 이벤트
    $("#popup_" + dialogId + " #" + dialogId + "_btnSearch").click(function () {
        getPreventMsgList();
    });

    // 추가 이벤트
    $("#popup_" + dialogId + " #" + dialogId + "_btnadd").click(function () {
        var checkitem = AUIGrid.getCheckedRowItems(dialogGridId);

        if (checkitem.length > 0) {
            for (var a = 0; a < checkitem.length; a++) {
                popUpAddRow(checkitem[a].item);
            }
            AUIGrid.setAllCheckedRows(dialogGridId, false);
            $('#popupClose_' + dialogId).trigger('click');
        } else {
            alert(lang.C100000869);  /* 체크된 행이 없습니다. */
        }
    });

    //selectbox change될 때마다 조회
    $("#prevntPopclassification").change(function () {
        getPreventMsgList();
    });

    function popUpAddRow(data) {
        var item = new Object();
        item.cmmnCode = data.cmmnCode// 입고명
        item.cmmnCodeNm = data.cmmnCodeNm// 제품 구분
        item.cmmnCodeRm = data.cmmnCodeRm// 제품 분류명
        item.lastChangeDt = data.lastChangeDt // 제품명
        item.lastChangerId = data.lastChangerId
        item.scrinUseAt = data.scrinUseAt // 제품 가격
        item.tmprField3Value = data.tmprField1Value // 용도
        item.tmprField2Value = data.tmprField2Value// 보관 상태
        item.updtPosblAt = data.updtPosblAt // 제품 단위
        item.upperCmmnCode = data.upperCmmnCode
        item.sortOrdr = data.sortOrdr
        item.useAt = data.useAt;
        selectFunc(item);
    }

    // 조회
    function getPreventMsgList() {
        var params = { cmmnCode: "RS22", tmprField1Value: $("#" + dialogId + "classification").val() };

        customAjax({
            "url": '/sys/getCmmnCodeMDetailList.lims',
            "data": params,
            "successFunc": function (list) {
                var masterGridData = AUIGrid.getGridData(gridId);

                // 1. 추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].tmprField2Value == masterGridData[j].tmprField2Value) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        // 추가되지 않은 항목은 활성화 시킴
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                    // 2. 추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }
                AUIGrid.setGridData(dialogGridId, list);
            }
        });
    }
}


function dialogLotNo(btnId, data, dialogId, selectFunc) {

    var lotNoColumnLayout = [];
    auigridCol(lotNoColumnLayout);

    lotNoColumnLayout.addColumnCustom('reqestSeqno', 'reqestSeqno', null, false)
        .addColumnCustom('bplcCode', lang.C000001398, '*', false, false) //사업장
        .addColumnCustom('bplcNm', lang.C000001398, '*', true, false) //사업장
        .addColumnCustom('lotNo', lang.C100000056, '*', true, false) //Lot No.
        .addColumnCustom('reqestNo', lang.C000001802, '*', true, false) //의뢰번호
        .addColumnCustom('mtrilNm', lang.C000000228, '*', true, false) //자재명
        .addColumnCustom('inspctTyCode', '', '*', false, false) //검사유형
        .addColumnCustom('inspctTyNm', lang.C000001794, '*', true, false) //검사유형명
        .addColumnCustom('mnfcturDte', lang.C100000803, '*', true, false) //제조 일자
        .addColumnCustom('rm', lang.C000000096, '*', true, false); //비고

    var lotNoPros = {
        editable: false, // 편집 가능 여부 (기본값 : false)
        selectionMode: 'singleRow',
    };

    var dialogGridID = 'grid_' + dialogId;
    var html = createDialog(1050);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000660); /*의뢰 정보*/
    var topright = "";
    var body = ""
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\" style=\"top:-35px !important;\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnLotNoSearch\" class=\"search\">" + lang.C000000002 + "</button>" /*조회*/
        + "</div>"
        + "<form id=\"" + dialogId + "_lotNoFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:30%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>" + lang.C000001398 + "</th>" /*사업장*/
        + "<td><select id=\"bplcCode\" name=\"bplcCode\"></select></td>"
        + "<th>LotNo</th>"
        + "<td style=\"text-align: left;\">"
        + "<input type=\"text\" id=\"lotNoSch\" name=\"lotNo\">"
        + "</td>"
        + "<th>" + lang.C100000659 + "</th>" /* 의뢰일자 */
        + "<td style=\"text-align: left;\">"
        + '<input type="text" id="reqestBeginDte" name="reqestBeginDte" className="dateChk schClass" maxLength="10" style="min-width:0; width:42%;" required> ~'
        + '<input type="text" id="reqesteEndDte" name="reqestEndDte" className="dateChk schClass" maxLength="10" style="min-width: 0; width:42%;" required>'
        + "</td>"
        + "</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        $('#lotNo').val('');

        datePickerCalendar(["reqestBeginDte"], true, ["DD", -7]);
        datePickerCalendar(["reqesteEndDte"], true, ["DD", 0]);

        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);

        getLotNoList();
    });

    //사업장 콤보박스
    ajaxJsonComboBox('/com/getDeptCombo.lims', 'bplcCode', { 'bestInspctInsttAt': 'Y' }, true).then(function () {
        $("#bplcCode option").not(':selected').prop('disabled', ($("#userAuthorDiv #layoutUserAuthorSeCode").val() != "SY09000001"));
    });

    datePickerCalendar([dialogId + '_stMnfcturDteSch', dialogId + '_enMnfcturDteSch'], true, ['MM', -1]);

    dialogGridID = createAUIGrid(lotNoColumnLayout, dialogGridID, lotNoPros);

    AUIGrid.bind(dialogGridID, "cellDoubleClick", function (event) {
        selectFunc(event.item);
        $("#popupClose_" + dialogId).click();
    });

    $("#" + dialogId + "_btnLotNoSearch").click(function () {
        getLotNoList();
    });

    function getLotNoList() {
        var formData = $('#' + dialogId + '_lotNoFrm').serializeObject();
        getGridDataParam("/test/getReqList.lims", formData, dialogGridID);
    }

    //엔터키 이벤트
    $("#lotNoSch").keyup(function (e) {
        if (e.keyCode == 13) {
            getLotNoList();
        }
    });


}

function dialogReqestResultAddExpriemList(btnId, data, dialogId, selectFunc, prePopupOpenFunc, flag) {

    var exprIemDialogColumnLayout = [];
    auigridCol(exprIemDialogColumnLayout);

    exprIemDialogColumnLayout.addColumnCustom('expriemClNm', lang.C000000938, '*', true) //시험항목분류명
        .addColumnCustom('expriemNm', lang.C000000204, '*', true) //시험항목 명
        .addColumnCustom("lclUcl", lang.C100001096, "*", true, false) /* LCL / UCL */
        .addColumnCustom('rm', lang.C100000425, '*', true); //비고

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C000000664); //시험항목 목록
    var topright = "<span class=\"iArea mgR10\"></span>"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"btnExprIemPopAdd\" class=\"btn4\">" + lang.C000000504 + "</button>" //추가
        + "</div>";
    var body = "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:100%; margin:0 auto;'>"
        + "</div>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        getExprIemList();
    }, prePopupOpenFunc);

    dialogGridID = createAUIGrid(exprIemDialogColumnLayout, dialogGridID, { showRowCheckColumn: true, editable: false });

    function getExprIemList() {
        getGridDataParam('/qa/getRequestExpriemListSch.lims', { "reqestSeqno": $("#reqestSeqno").val() }, dialogGridID);
    }

    $('#popup_' + dialogId + ' #btnExprIemPopAdd').click(function () {
        var activeItems = AUIGrid.getCheckedRowItems(dialogGridID);

        if (activeItems.length == 0) {
            alert(lang.C000000209); /*선택된 시험항목이 없습니다.*/
            return false;
        }

        //row index 기준으로 sort한다.
        activeItems.sort(function (a, b) {
            if (a.rowIndex > b.rowIndex)
                return 1;
            if (a.rowIndex < b.rowIndex)
                return -1;
            return 0;
        });

        var expriemMap = new Array();
        activeItems.forEach(function (v) {
            expriemMap.push(v.item);
        });

        selectFunc(expriemMap);

        $('#popupClose_' + dialogId).trigger('click');
    });

    $('#popup_' + dialogId + ' #btnExprIemPopSearch').click(function () {
        getExprIemList();
    });

    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2');	// 1, 2가 있으니 화면에 맞게 적용
    });

    //엔터키 이벤트
    $('.searchClass').keypress(function (e) {
        if (e.which == 13) {
            getExprIemList();
        }
    });
}

//[의뢰화면] - [바코드 출력 전 팝업] - 바코드 샘플 값 사용자가 정의
// 상위 체크 박스, 하위 체크 박스 서로 관계없이 선택하거나 하지않거나
// 재조정 체크 박스 체크한 경우 input 박스에 값 필수
function dialogBarcodeSampleVal(btnId, dialogId, selectFunc) {
    var html = createDialog(500);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001297); //샘플 목록
    var topright = "<span class=\"iArea\"></span>";
    var body = "";
    body += '<div class="subCon1" id="detail">';
    body += '<div class="btnWrap">';
    body += '<button type="button" id="btnBarcodeSample" class="btn4">' + lang.C100001299 + '</button>'; //확인
    body += '</div><br>';
    body += '<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">';
    body += '<colgroup>';
    body += '<col style="width:20%"></col>';
    body += '<col style="width:20%"></col>';
    body += '<col style="width:60%"></col>';
    body += '</colgroup>';
    body += '<tr>';
    body += '<td><input type="checkbox"  name="typeA" style="vertical-align: middle" value="재샘플"> ' + lang.C100001298 + '</td>'; //재샘플
    body += '<td><input type="checkbox"  name="typeA" style="vertical-align: middle" value="PREMIX"> PREMIX</td>'; //PREMIX
    body += '<td><input type="checkbox"  name="typeA" style="vertical-align: middle" value="재조정">  ' + lang.C100001129 + '( ' +
        '<input type="text" id="readjustmentNumber" style="width: 30%"> )' +
        '</td>'; //재조정
    body += '</tr>';
    body += '<tr>';
    body += '<td><input type="checkbox"  name="typeB" style="vertical-align: middle" value="초"> ' + lang.C100000870 + '</td>'; //초
    body += '<td><input type="checkbox"  name="typeB" style="vertical-align: middle" value="중"> ' + lang.C100000836 + '</td>'; //중
    body += '<td><input type="checkbox"  name="typeB" style="vertical-align: middle" value="말"> ' + lang.C100000301 + '</td>'; //말
    body += '</tr>';
    body += '</table>';
    body += "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function () { });

    //라트넘버생성 필수 값 체크
    $('#readjustmentNumber').blur(function (e) {
        var ordrInputString = e.target.value;
        if (ordrInputString.length > 2) {
            e.target.value = '';
            return;
        }
        var regType = /^[0-9+]*$/;
        if (!regType.test(ordrInputString)) {
            e.target.value = '';
            return;
        }
    });

    $('input[type="checkbox"][name="typeA"]').click(function () {
        if ($(this).prop('checked')) {
            $('input[type="checkbox"][name="typeA"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

    $('input[type="checkbox"][name="typeB"]').click(function () {
        if ($(this).prop('checked')) {
            $('input[type="checkbox"][name="typeB"]').prop('checked', false);
            $(this).prop('checked', true);
        }
    });

    $('#btnBarcodeSample').click(function () {
        var typeAString = '';
        var typeBString = '';
        for (var i = 0; i < 3; i++) {
            if ($('input:checkbox[name="typeA"]')[i].checked) {
                if ('재조정' === $('input:checkbox[name="typeA"]')[i].value &&
                    document.getElementById('readjustmentNumber').value === '') {
                    alert(lang.C100001300); //재조정 체크 시 값 입력은 필수입니다.
                    return false;
                }

                if ('재조정' === $('input:checkbox[name="typeA"]')[i].value) {
                    typeAString = $('input:checkbox[name="typeA"]')[i].value + '(' + document.getElementById('readjustmentNumber').value + ')';
                } else {
                    typeAString = $('input:checkbox[name="typeA"]')[i].value;
                }
            }

            if ($('input:checkbox[name="typeB"]')[i].checked)
                typeBString = $('input:checkbox[name="typeB"]')[i].value;
        }

        var sampleString = '';
        if (typeAString !== '' && typeBString !== '')
            sampleString = typeAString + ', ' + typeBString;
        else
            sampleString = typeAString + typeBString;

        if (selectFunc != undefined && selectFunc != null)
            selectFunc(sampleString);

        $('#popupClose_' + dialogId).trigger('click');
    });

    //팝업창 닫을 때 발행목록 재조회 (모든 첨부파일 삭제 시, 증적완료등록 여부 "X"처리하기 위함)
    $("#popupClose_" + dialogId).click(function (e) {
        if ($('#barcodeGubun').val() === 'S') {
            //RequestM.jsp 함수들
            requestSearch();
            frmReset();
        }
    });
}

/**
 * 
 * 검토 사유 공통 dialog
 * 
 * [params 구조] 
 * params {
 *     btnId : dialog click button id
 *     functions : {
 *         getExmntSeqno() : 검토 일련번호를 return하는 function
 *         getOtherKey() : 품질보증 및 검토를 이용하는 모든메뉴의 primary key seqno를 return하는 function
 *         init() : 검토처리 후 main page초기화 하는 function 
 *     }
 *     dialogId : dialog 고유 id
 *     url : 각 메뉴의 검토처리를 진행할 Controller request url 입니다.
 * }
 * 
 * @param params params
 * @author shs
 */
function dialogExmnt(params) {

    var btnId = params.btnId;
    var functions = params.functions;
    var dialogId = params.dialogId;
    var dialogGridId = "grid_" + dialogId;
    var url = params.url;
    var dialogFormId = dialogId +"Form";
    var dialogBtnNewId = dialogId +"BtnNew";
    var dialogBtnSaveId = dialogId +"BtnSave";
    
    createHtml(); // dialog html 생성
    
    var dialogSaveFormEl = document.querySelector('#' + dialogFormId);
    initialDialog();
    
    popupInit(btnId, dialogId, function () {
        loadDialog();
        getExmntHistory();
    });
    
    function buildGrid() {
        var col = [];
        
        auigridCol(col);
        
        col
            .addColumnCustom("ordr", "순번")
            .addColumnCustom("exmntDte", "검토일자")
            .addColumnCustom("exmntCn", "검토내용")
        
        dialogGridId = createAUIGrid(col, dialogGridId);
    }

    function getExmntHistory() {
        var exmntSeqno = functions.getExmntSeqno();
        if (!!exmntSeqno) {
            getGridDataParam('/com/getExmntHistory.lims', {exmntSeqno: exmntSeqno}, dialogGridId);
        } else {
            AUIGrid.setGridData(dialogGridId, []);
        }
    }

    // dialog 생성시 실행
    function initialDialog() {
        buildGrid();
        setButtonEvent();
    }
    
    // dialog 열때마다 실행
    function loadDialog() {
        dialogSaveFormEl.reset();
        AUIGrid.resize(dialogGridId);
        dialogSaveFormEl.querySelector('[name=exmntSeqno]').value = functions.getExmntSeqno();
        dialogSaveFormEl.querySelector('[name=otherKey]').value = functions.getOtherKey();
        getExmntHistory();
    }

    function setButtonEvent() {

        document.querySelector('#' + dialogBtnNewId).addEventListener('click', function () {
            loadDialog();
        });

        document.querySelector('#' + dialogBtnSaveId).addEventListener('click', function () {

            if (!saveValidation(dialogSaveFormEl.id)) return;
            
            customAjax({
                url: url,
                data: dialogSaveFormEl.toObject(),
                elementIds: [dialogBtnSaveId],
            }).then(function (res, status) {
                if (status === 'success') {
                    alert("검토 되었습니다.");
                    functions.init();
                    $('#popupClose_' + dialogId).click();
                }
            });
        });
    }


    function createHtml() {
        var html = createDialog(600);
            html = html.replace(/#dialogId#/g, dialogId);
            html = html.replace(/#title#/g, '검토');
            html = html.replace(/#flexbox#/g, "");
            html = html.replace(/#sameline#/g, "");
            
        var topright = 
            "<div class=\"btnWrap\" style=\"position: inherit\">" +
                "<button type=\"button\" id='"+ dialogBtnNewId +"' class=\"btn4\">" + "초기화" + "</button>" +
                "<button type=\"button\" id='"+ dialogBtnSaveId +"' class=\"save\">" + "검토" + "</button>" +
            "</div>";
        
        var body = 
                "<div class='subCon1'>" +
                    "<form id='"+ dialogFormId +"' onsubmit='return false;'>" +
                    "<table class='subTable1'>" +
            
                        "<colgroup>" +
                            "<col style='width:15%'/>" +
                            "<col style='width:85%'/>" +
                        "</colgroup>" +
            
                        "<input type='text' name='exmntSeqno' style='display: none'>" +
                        "<input type='text' name='otherKey' style='display: none'>" +
                        "<tr>" +
                            "<th class='necessary' style='text-align:center;'>" + "검토 내용" + "</th>" +
                            "<td colspan='5'>" +
                                "<textarea cols='100' rows='10' name='exmntCn' class='wd100p' style='min-width:10em;' required></textarea>" +
                            "</td>" +
                        "</tr>" +
                    "</table>" +
                    "</form>" +
                "</div>" +
            "<div class = 'subCon2'>" +
                "<div id='" + dialogGridId + "' style='height:200px;'></div>" +
            "</div>";
        
        html = html.replace(/#topright#/g, topright);
        html = html.replace(/#body#/g, body);
        $("#sub_wrap").append(html);
    }
}


function dialogCylinder(btnId, dialogId, gridId, selectFunc) {
    var releaseDialogColumnLayout = [];
    var dialogGridID = "grid_" + dialogId;
    var dialogGridIDDetail = "grid_" + dialogId + "Detail";
    var checkEventProps = {
        showRowCheckColumn: true,
        independentAllCheckBox: true,
        rowCheckDisabledFunction: function(rowIndex, isChecked, item) {
            var getMasterGridData = AUIGrid.getGridData(gridId);
            for (var i = 0; i < getMasterGridData.length; i++) {
                //화면에 추가된 실린더는 팝업에서 해당 실린더 체크박스 disable 처리
                if (item.sanctnSeqno == getMasterGridData[i].sanctnSeqno && item.bplcCode == getMasterGridData[i].bplcCode) {
                    return false; //false 반환하면 disabled 처리
                }
            }
            return true;
        }
    };

    var html = createDialog(960);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001159);
    var topright =
        "<div class=\"btnWrap\" style=\"top:6px !important; position: inherit;\">"
        + "<button type=\"button\" id=\"btnReleasePopSelect\" class=\"btn5\">" + lang.C100000880 + "</button>"
        + "<button type=\"button\" id=\"btnReleasePopSearch\" class=\"search\">" + lang.C100000767 + "</button>"
        + "</div>"
        + "<div class=\"subContent\" style=\"padding : 0;\">"
        + "<div class=\"subCon1\" style=\"margin-top: 10px;\">"
        + "<form id=\"" + dialogId + "prductPopSearchFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:30%\"></col>"
        + "<col style=\"width:20%\"></col>"
        + "<col style=\"width:30%\"></col>"
        + "</colgroup>"
        +"<tr>"
        +"<th>CYLINDER No</th>" //CYLINDER No.
        +"<td><input type=\"text\" id=\"cylinderNoSch\" name=\"cylinderNoSch\"></td>"
        +"<th>CYLINDER_M</th>" //CYLINDER_M
        +"<td><input type=\"text\" name=\"mtrqltValueSch\" id=\"cylinderMSch\"></td>"
        +"</tr>"
        +"<tr>"
        +"<th>CYLINDER_MAKER</th>" //CYLINDER_MAKER
        +"<td><input type=\"text\" name=\"mnfcturprofsNmSch\" id=\"cylinderMakerSch\"></td>"
        +"<th>"+lang.C100000443+"</th> "//사용여부
        +"<td><label><input type=\"radio\" name=\"useAt\" value=\"\">"+lang.C100000779+"</label>" //전체
        +"<label><input type=\"radio\" name=\"useAt\" value=\"Y\" checked>"+lang.C100000439+"</label>" //사용
        +"<label><input type=\"radio\" name=\"useAt\" value=\"N\">"+ lang.C100000449+"</label>" //사용안함
        +"</td>"
        +"</tr>"
        + "</table>"
        + "</form>"
        + "</div>"
        + "<div class='mgT15'>"
        + "<div id='" + dialogGridID + "' style='width:100%; height:200px; margin:0 auto;'>"
        + "</div>"
        + "</div>"
        + "</div>";
    var body = "<div class='mgT15'>"
        + "</div>";
    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $("#sub_wrap").append(html);

    ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
    ajaxJsonComboBox('/com/getCmmnCode.lims', dialogId + 'prductClCodesch', { "upperCmmnCode": "RS01" }, true);

    popupInit(btnId, dialogId, function () {
        $("#" + dialogId + "bplcCodeSch").val($("#userAuthorDiv #layoutUserBplcCode").val());
        AUIGrid.resize(dialogGridID);
        AUIGrid.resize(dialogGridIDDetail);
        AUIGrid.clearGridData(dialogGridIDDetail);
        AUIGrid.setAllCheckedRows(dialogGridIDDetail, false);
    });

    auigridCol(releaseDialogColumnLayout);
    releaseDialogColumnLayout.addColumnCustom("sanctnSeqno", "실린더 일련번호", null, false, false); //실린더 일련번호
    releaseDialogColumnLayout.addColumnCustom("bplcCode", lang.C100000435, null, false, false);//사업장코드
    releaseDialogColumnLayout.addColumnCustom("bplcCodeNm", lang.C100000435, null, false, false); //사업장 명
    releaseDialogColumnLayout.addColumnCustom("cylndrNo", "실린더 No.", null, true, false); //실린더 No.
    releaseDialogColumnLayout.addColumnCustom("mtrqltValue", "CYLINDER_SIZE", null, true, false); //CYLINDER_SIZE
    releaseDialogColumnLayout.addColumnCustom("mnfcturprofsNm", "CYLINDER_M", null, true, false); //CYLINDER_M
    dialogGridID = createAUIGrid(releaseDialogColumnLayout, dialogGridID,checkEventProps);

    function getCylnderList() {
        var param = $("#"+dialogId +"prductPopSearchFrm").serializeObject();
        customAjax({
            url: "/wrk/getcylinderList.lims",
            data: param,
            successFunc: function(data) {
                AUIGrid.setGridData(dialogGridID, data);
            }
        });
    }

    $("#popup_" + dialogId + " #btnReleasePopSearch").click(function () {
        getCylnderList();
    });

    $("#popup_" + dialogId + " #btnReleasePopSelect").click(function () {
        var checkedItems = AUIGrid.getCheckedRowItems(dialogGridID);
        if (checkedItems != undefined && checkedItems != null) {
            popUpAddRow(checkedItems, gridId);
        }
    });

    function popUpAddRow(data, gridId) {
        var addRowArr = new Array();
        for (var k = 0; k < data.length; k++) {
            var item = new Object();
            item.sanctnSeqno = data[k].item.sanctnSeqno; //실린더 일렬번호
            item.bplcCode = data[k].item.bplcCode; //사업장코드
            item.bplcCodeNm = data[k].item.bplcCodeNm; //사업장 명
            item.cylndrNo = data[k].item.cylndrNo; //실린더No.
            item.mtrqltValue = data[k].item.mtrqltValue; //재질 값
            item.cylndrNm = data[k].item.mnfcturprofsNm; //실린더 명
            addRowArr.push(item)
        }
        AUIGrid.addRow(gridId, addRowArr,'last');

        if (data.length > 0) {
            AUIGrid.clearGridData(dialogGridID);
            AUIGrid.setAllCheckedRows(dialogGridID, false);
            $("#popup_" + dialogId + " #relPrductClNm").val('');
            $("#popupClose_" + dialogId).trigger("click");
        } else {
            alert('선택한 항목이 없습니다. 항목을 선택해주세요.')
            return;
        }
    }
    
    AUIGrid.bind(dialogGridID, "ready", function(event) {
        gridColResize(dialogGridID, "2");
    });

    AUIGrid.bind(dialogGridID, "rowAllChkClick", function(event) {
        AUIGrid.clearSortingAll(dialogGridID);
        var getMasterGridData = AUIGrid.getGridData(gridId); //화면의 실린더 리스트
        var getItem = AUIGrid.getGridData(dialogGridID);
        var checkArray = new Array();
        
        function getCylnderUniqueArray(array1, array2) {
            var tempArray = new Array();
            var resultArray = new Array();
            for (var i = 0; i < array1.length; i++) { //팝업의 실린더 리스트
                tempArray.push({ sanctnSeqno: array1[i].sanctnSeqno, bplcCode: array1[i].bplcCode });
            }

            for (var k = 0; k < tempArray.length; k++) {
                if (array2.length > 0) {
                    for (var j = 0; j < array2.length; j++) {
                        //화면에 추가된 실린더 리스트와 팝업의 실린더 리스트를 비교해 일치하는 실린더는 배열에서 제거
                        if (tempArray[k].sanctnSeqno == array2[j].sanctnSeqno && tempArray[k].bplcCode == array2[j].bplcCode) {
                            tempArray.splice(k, 1);
                        }
                    }
                    resultArray = tempArray;
                } else {
                    if (tempArray.length > 0) {
                        for (var i = 0; i < tempArray.length; i++) {
                            resultArray.push({ sanctnSeqno: tempArray[i].sanctnSeqno, bplcCode: tempArray[i].bplcCode })
                        }
                    }
                }
            }

            return resultArray;
        }

        //중복을 제거한 실린더 리스트 할당
        checkArray = getCylnderUniqueArray(getItem, getMasterGridData)
        
        for (var h = 0; h < checkArray.length; h++) {
            if (event.checked) {
                AUIGrid.addCheckedRowsByValue(dialogGridID, "sanctnSeqno", checkArray[h].sanctnSeqno);
            } else {
                AUIGrid.addUncheckedRowsByValue(dialogGridID, "sanctnSeqno", checkArray[h].sanctnSeqno);
            }
        }
    });

    //엔터키 이벤트
    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getCylnderList();
        }
    });

}

/**
 * 
 * 검토 사유 공통 dialog
 * 
 * [params 구조] 
 * params {
 *     btnId : dialog click button id
 *     dialogId : dialog 고유 id
 *     functions : {
 *         callback() : data를 받을 callback function 
 *     }
 * }
 * 
 * @param params params
 * @author shs
 */
function dialogAuditManage(params) {

    var btnId = params.btnId;
    var dialogId = params.dialogId;
    var functions = params.functions;
    var dialogGridId = "grid_" + dialogId;
    var dialogSearchFormId = dialogId +"SearchForm";
    var dialogBtnSearchId = dialogId +"BtnSearch";
    
    createHtml(); // dialog html 생성
    
    var dialogSearchFormEl = document.querySelector('#' + dialogSearchFormId);
    initialDialog();
    
    popupInit(btnId, dialogId, function () {
        loadDialog();
    });
    
    function buildGrid() {
        var col = [];
        
        auigridCol(col);
        
        col
            .addColumnCustom("auditSeCodeNm", "감사구분")
            .addColumnCustom("auditDetailSeCodeNm", "감사구분상세")
            .addColumnCustom("auditDte", "감사일자")
            .addColumnCustom("auditNo", "감사번호")
            .addColumnCustom("auditSj", "감사제목")
            .addColumnCustom("auditBeginDte", "감사시작일자")
            .addColumnCustom("auditEndDte", "감사종료일자")
            .addColumnCustom("auditTrgetDeptNm", "감사대상부서")
            .addColumnCustom("entrpsNm", "업체명")
        
        dialogGridId = createAUIGrid(col, dialogGridId);
        
        AUIGrid.bind(dialogGridId, "cellDoubleClick", function(event) {
            functions.callback(event.item);
            $('#popupClose_' + dialogId).click();
        });
    }

    function getAuditList(){
        getGridDataForm('/qa/getAudit.lims', dialogSearchFormEl.id, dialogGridId);
    }

    // dialog 생성시 실행
    function initialDialog() {
        buildGrid();
        setButtonEvent();
        setDatePicker();
    }
    
    // dialog 열때마다 실행
    function loadDialog() {
        dialogSearchFormEl.reset();
        AUIGrid.resize(dialogGridId);
    }

    function setButtonEvent() {
        document.querySelector('#' + dialogBtnSearchId).addEventListener('click', function () {
            getAuditList();
        });

        dialogSearchFormEl.addEventListener('keypress', function (e) {
            if (e.key === 'Enter' && e.target.classList.contains('dialogSchClass')){
                getAuditList();
            }
        });
    }

    function setDatePicker(){
        datePickerCalendar(['auditBeginDte_'+ dialogId, 'auditEndDte_'+ dialogId], true, ["MM",-1], ["DD",0]);
    }


    function createHtml() {
        var html = createDialog(1200);
            html = html.replace(/#dialogId#/g, dialogId);
            html = html.replace(/#title#/g, '감사 목록');
            html = html.replace(/#flexbox#/g, "");
            html = html.replace(/#sameline#/g, "");

    var topright = 
        "<div class=\"btnWrap\" style='position: inherit'>" +
            "<button type=\"button\" id='"+ dialogBtnSearchId +"' class=\"search\">" + "조회" + "</button>" +
        "</div>";
    
    var body = 
            "<div class='subCon1'>" +
                "<form id='"+ dialogSearchFormId +"' onsubmit='return false;'>" +
                "<table class='subTable1'>" +
                    "<colgroup>" + 
                        "<col style='width:10%'/>" +
                        "<col style='width:15%'/>" +
                        "<col style='width:10%'/>" +
                        "<col style='width:15%'/>" +
                        "<col style='width:10%'/>" +
                        "<col style='width:15%'/>" +
                        "<col style='width:10%'/>" +
                        "<col style='width:15%'/>" +
                    "</colgroup>" +
                    "<tr>" +
                        "<th>감사구분</th>" + 
                        "<td><select name='auditSeCode' class='wd100p'></select></td>" +
                
                        "<th>감사구분상세</th>" +
                        "<td><select name='auditDetailSeCode' class='wd100p'></select></td>" +
                
                        "<th>감사년도</th>" +
                        "<td><input type='text' name='auditYear' class='wd100p dialogSchClass'></td>" +
                
                        "<th>감사일자</th>" +
                        "<td>" +
                            "<input type='text' id='auditBeginDte_"+ dialogId +"' name='auditBeginDte' class='dateChk wd40p dialogSchClass' style='min-width:1em;'> ~ " + 
                            "<input type='text' id='auditEndDte_"+ dialogId +"' name='auditEndDte' class='dateChk wd40p dialogSchClass' style='min-width:1em;'>" +
                        "</td>" +
                    "</tr>" +
                "</table>" +
                "</form>" +
            "</div>" +
            "<div class = 'subCon2'>" +
                "<div id='" + dialogGridId + "' style='height:200px;'></div>" +
            "</div>";
        
        html = html.replace(/#topright#/g, topright);
        html = html.replace(/#body#/g, body);
        $("#sub_wrap").append(html);
    }
}


/**
 * 
 * 메뉴별 담당자 관리 팝
 * 
 * [params 구조] 
 * params {
 *     btnId : dialog click button id
 *     dialogId : dialog 고유 id
 *     functions : {
 *         callback() : data를 받을 callback function 
 *     }
 * }
 * 
 * @param params params
 * @author jwwoo
 */
function dialogUnitTest(params) {

    var btnId = params.btnId;
    var dialogId = params.dialogId;
    var functions = params.functions;
    var dialogGridId = "grid_" + dialogId;
    var dialogBtnSaveId = dialogId + "BtnSave";
    var url = params.url;
    
    createHtml(); // dialog html 생성
    
    initialDialog();
    
    popupInit(btnId, dialogId, function () {
        loadDialog();
        getMenuChargerList()
    });
    
    function buildGrid() {
        var col = [];
        
        auigridCol(col);
        
        col
        	.addColumnCustom("menuSeqno", "메뉴시퀀스", false, false)
            .addColumnCustom("menuNm", "메뉴명")
            .addColumnCustom("chargerNm", "담당자", "*", true, true, "dataType")
            
        
        dialogGridId = createAUIGrid(col, dialogGridId);
    }

    function getMenuChargerList(){
    	getGridDataParam(url, '', dialogGridId);
    }

    // dialog 생성시 실행
    function initialDialog() {
        buildGrid();
        setButtonEvent();
    }
    
    // dialog 열때마다 실행
    function loadDialog() {
        AUIGrid.resize(dialogGridId);
    }

    function setButtonEvent() {
        document.querySelector('#' + dialogBtnSaveId).addEventListener('click', function () {
            saveMenuCharger();
        });
    }
    function createHtml() {
        var html = createDialog(600);
            html = html.replace(/#dialogId#/g, dialogId);
            html = html.replace(/#title#/g, '메뉴별 담당자 목록');
            html = html.replace(/#flexbox#/g, "");
            html = html.replace(/#sameline#/g, "");

    var topright = 
        "<div class=\"btnWrap\" style='position: inherit'>" +
            "<button type=\"button\" id='"+ dialogBtnSaveId +"' class=\"save\">" + "저장" + "</button>" +
        "</div>";
    
    var body = 
            "<div class='subCon1 mgT10'>" +
            "</div>" +
            "<div class = 'subCon2'>" +
                "<div id='" + dialogGridId + "' style='height:400px;'></div>" +
            "</div>";
        
        html = html.replace(/#topright#/g, topright);
        html = html.replace(/#body#/g, body);
        $("#sub_wrap").append(html);
    }
    
    function saveMenuCharger(){
    	var param = {};
    	var gridData = AUIGrid.getGridData(dialogGridId);
    	var arrData = [];
    	
    	// 담당자명이 null 또는 "" 일 경우 저장하지 않음. 
        for (var i = 0; i < gridData.length; i++) {
            var a = gridData[i];
    		if(a.chargerNm != null && a.chargerNm != "") {
    			arrData.push(a);
    		}
        }
        
    	param.gridData = arrData;
        customAjax({
            url: "/sys/saveMenuCharger.lims",
            data: param,
            successFunc: function(str) {
            	getMenuChargerList();
            	success("저장되었습니다.");
            }
        });
    	
    	
    }
}



/**
 * 
 * 품질보증 결재
 * 
 * [params 구조] 
 * params {
 *     btnId : dialog click button id
 *     dialogId : dialog unique id
 *     functions : {
 *         getCn() : this function return cn
 *         getSj() : this function return sj
 *     }
 * }
 * 
 * @param params params
 * @author shs
 */
function dialogQaSanctn(params) {

    var btnId = params.btnId;
    var parentGridId = params.parentGridId;
    var functions = params.functions;
    var dialogId = params.dialogId;
    var dialogFormId = dialogId +"Form";
    var dialogBtnConfirmId = dialogId +"BtnConfirm";
    var dialogBtnReturnId = dialogId +"BtnReturn";
    var hiddenDialogBtnReturnId = dialogId +"HiddenBtnReturn";
    var dialogDropzone;
    
    initialDialog();
    var dialogSaveFormEl = document.querySelector('#' + dialogFormId);
    
    popupInit(btnId, dialogId, function () {
        loadDialog();
    });
    
    // dialog 생성시 실행
    function initialDialog() {
        createHtml(); // dialog html 생성
        setButtonEvent()
        
        // 반려 dialog 생성
        dialogRtnSanctn({
            btnId : hiddenDialogBtnReturnId,
            dialogId : 'dialogQaSanctn_sanctnReturnDialog',
            type : 'form',
            functions : {
                callback: function (res) {
                    
                    var item = AUIGrid.getSelectedRows(parentGridId)[0];
                        item.rtnResn = res.rtnResn
                    
                    customAjax({
                        url : '/qa/return.lims',
                        data : item
                    }).then(function (res, status) {
                        if (status === 'success') {
                            alert('반려 되었습니다.');
                            functions.init();
                            $('#popupClose_' + dialogId).click();
                        }
                    });
                },
                getSanctnSeqno: function () {
                    return AUIGrid.getSelectedRows(parentGridId)[0].sanctnSeqno;
                }
            }
        });
    }

    function loadDialog() {
        saveFormReset();
        var item = AUIGrid.getSelectedRows(parentGridId)[0];
        dialogSaveFormEl.innerHTML += item.cn;
        renderingDropZone();
        
        popupCenter(dialogId); // 위치 재정렬
    }

    function saveFormReset() {
        dialogSaveFormEl.innerHTML = '';
    }

    function renderingDropZone() {
        dialogDropzone = DDFC.bind().EventHandler(dialogSaveFormEl.querySelector('.dropzoneSelector').id, {'readOnly': true, lang: " " });
        dialogDropzone.getFiles(dialogSaveFormEl.querySelector('[name=atchmnflSeqno]').value, null, 'N');
    }

    function setButtonEvent() {

        document.querySelector('#' + dialogBtnConfirmId).addEventListener('click', function () {

            var item = AUIGrid.getSelectedRows(parentGridId)[0];
            if (!!!item.sanctnSeqno || !!!item.ordr) {
                warn('선택된 결재상신 정보로는 결재할 수 없습니다. 관리자에게 문의하세요.');
                return false;
            }
            
            customAjax({
                url: '/qa/confirm.lims',
                data: item
            }).then(function (res, status) {
                if (status === 'success') {
                    alert('결재 되었습니다.');
                    functions.init();
                    $('#popupClose_' + dialogId).click();
                }
            });
        });
        document.querySelector('#' + dialogBtnReturnId).addEventListener('click', function () {

            var item = AUIGrid.getSelectedRows(parentGridId)[0];
            if (!!!item.sanctnSeqno || !!!item.ordr) {
                warn('선택된 결재상신 정보로는 반려할 수 없습니다. 관리자에게 문의하세요.');
                return false;
            }
           
            document.querySelector('#' + hiddenDialogBtnReturnId).click();
        });
    }


    function createHtml() {
        var html = createDialog(1100);
            html = html.replace(/#dialogId#/g, dialogId);
            html = html.replace(/#title#/g, '결재');
            html = html.replace(/#flexbox#/g, "");
            html = html.replace(/#sameline#/g, "");
            
        var topright = 
            "<div class=\"btnWrap\" style='top:5px !important;' >" +
                "<button type=\"button\" id='"+ dialogBtnConfirmId +"' class=\"save\">" + "결재" + "</button>" +
                "<button type=\"button\" id='"+ dialogBtnReturnId +"' class=\"btn4\">" + "반려" + "</button>" +
                "<button type=\"button\" id='"+ hiddenDialogBtnReturnId +"' style='display: none'>" + "반려" + "</button>" +
            "</div>";
        
        var body = 
                "<div class='subCon1 mgT10'>" +
                    "<form id='"+ dialogFormId +"' onsubmit='return false;'></form>" +
                "</div>";
        
        html = html.replace(/#topright#/g, topright);
        html = html.replace(/#body#/g, body);
        $("#sub_wrap").append(html);
    }
}

function dialogFindCstmr(btnId, data, dialogId, selectFunc) {

    var cstmrDialogColumnLayout = [];
    auigridCol(cstmrDialogColumnLayout);

    cstmrDialogColumnLayout
        .addColumnCustom("cstmrDscnttNo", lang.C100001309)
        .addColumnCustom("cstmrDscnttSj", lang.C100001310)
        .addColumnCustom("entrpsNm", lang.C100000187)
        .addColumnCustom("mtrilNm", lang.C100000806)
        .addColumnCustom("dscnttCn", lang.C100001323)
        .addColumnCustom("requstDte", lang.C100001312)
        .addColumnCustom("chrgDeptCodeNm", lang.C100001313)
        .addColumnCustom("chargerNm", lang.C100000271)
        .addColumnCustom("ocapSttusCodeNm", lang.C100001319)
        .addColumnCustom("cstmrDscnttIpcrCodeNm", lang.C100001320)
        .addColumnCustom("comptDte", lang.C100001314);

    var dialogGridID = 'grid_' + dialogId;

    var html = createDialog(1000);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100001308); /* 고객불만관리 */
    var topright = "<span class=\"iArea\"></span>";
    var body = ''

        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnPopSearch\" class=\"search\" >" + lang.C100000767 + "</button>" /*조회*/
        + "</div><br>"
        + "<form id=\"" + dialogId + "PopSearchFrm\" onsubmit=\"return false;\">"
        + "<table class=\"subTable1\" style=\"width:100%;\">"
        + "                <colgroup>"
        + "                    <col style=\"width:10%\"/>"
        + "                    <col style=\"width:15%\"/>"
        + "                    <col style=\"width:10%\"/>"
        + "                    <col style=\"width:15%\"/>"
        + "                    <col style=\"width:10%\"/>"
        + "                    <col style=\"width:15%\"/>"
        + "                    <col style=\"width:10%\"/>"
        + "                    <col style=\"width:15%\"/>"
        + "                </colgroup>"
        + "                <tr>"
        + "                    <th>"+lang.C100001309 +"</th>"
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "cstmrDscnttNoSch\" name=\"cstmrDscnttNo\" class=\"wd100p schClass\"  style=\"min-width:10em;\">"
        + "                        <input type=\"hidden\" id=\"" + dialogId + "reprtAt\" name=\"reprtAt\" class=\"wd100p schClass\"  value=\"Y\" style=\"min-width:10em;\">"
        + "                    </td>"
        + "                    <th>"+lang.C100000187 + "</th>"
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "entrpsNmSch\" name=\"entrpsNm\" class=\"schClass wd100p\" >"
        + "                    </td>"
        + ""
        + "                    <th>"+lang.C100001310 +"</th>"
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "cstmrDscnttSjSch\" name=\"cstmrDscnttSj\" class=\"wd100p schClass\"style=\"min-width:10em;\">"
        + "                    </td>"
        + ""
        + "                    <th>"+lang.C100000806 +"</th> "
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "mtrilNmSch\" name=\"mtrilNm\" class=\"schClass wd100p\"  >"
        + "                    </td>"
        + "                </tr>"
        + "                <tr>"
        + "                    <th>"+lang.C100001312 +"</th> "
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "requstDteSt\" name=\"requstDteSt\" class=\"wd43p dateChk schClass\" style=\"min-width:6em;\">"
        + "                        ~"
        + "                        <input type=\"text\" id=\"" + dialogId + "requstDteEn\" name=\"requstDteEn\" class=\"wd43p dateChk schClass\" style=\"min-width:6em;\">"
        + "                    </td>"
        + ""
        + "                    <th>"+lang.C100001313 +"</th>"
        + "                    <td>"
        + "                        <select name=\"chrgDeptCode\" id=\"" + dialogId + "chrgDeptCodeSch\">"
        + "                        </select>"
        + "                    </td>"
        + ""
        + "                    <th>"+lang.C100000271 +"</th>"
        + "                    <td>"
        + "                        <select id=\"" + dialogId + "chargerIdSch\" name=\"chargerId\" class=\"wd100p\" required></select>"
        + "                    </td>"
        + ""
        + "                    <th>"+lang.C100001314 +"</th> "
        + "                    <td>"
        + "                        <input type=\"text\" id=\"" + dialogId + "comptDteSt\" name=\"comptDteSt\" class=\"wd43p dateChk schClass\"style=\"min-width:6em;\">"
        + "                        ~"
        + "                        <input type=\"text\" id=\"" + dialogId + "comptDteEn\" name=\"comptDteEn\" class=\"wd43p dateChk schClass\"style=\"min-width:6em;\">"
        + "                    </td>"
        + "                </tr>"
        + "            </table>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>";

    html = html.replace(/#topright#/g, topright);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");
    $('#sub_wrap').append(html);

    popupInit(btnId, dialogId, function () {
        AUIGrid.resize(dialogGridID);
        AUIGrid.clearGridData(dialogGridID);
        dialogComboInit();
    });

    function dialogComboInit(){
        datePickerCalendar([dialogId + "comptDteSt", dialogId + "comptDteEn"], true, ["DD", -365], ["DD", 0]);
        datePickerCalendar([dialogId + "requstDteSt", dialogId + "requstDteEn"], true, ["DD", -365], ["DD", 0]);

        ajaxJsonComboBox('/wrk/getDeptComboList.lims', dialogId + "chrgDeptCodeSch" , { "bestInspctInsttCode": data }, false, lang.C100000480);

        $("select[name=chrgDeptCode]").on("change", function(e){
            bindUserSelectbox(e.target.value, $("#"+e.target.id).parent().next().next().children()[0].id);
        })
    }

    dialogGridID = createAUIGrid(cstmrDialogColumnLayout, dialogGridID);

    AUIGrid.bind(dialogGridID, 'ready', function (event) {
        gridColResize(dialogGridID, '2'); // 1, 2가 있으니 화면에 맞게 적용
    });

    AUIGrid.bind(dialogGridID, 'cellDoubleClick', function (event) {
        var gridItem = event.item;
        if (selectFunc != undefined && selectFunc != null)
            selectFunc(gridItem);
        $('#popupClose_' + dialogId).trigger('click');
    });

    $('#' + dialogId + '_btnPopSearch').click(function () {
        getPopList();
    });

    function getPopList() {

        var param = Object.assign($("#"+dialogId + "PopSearchFrm").serializeObject(), {"sanctnProgrsSittnCode" : "CM01000005"});

        getGridDataParam('/qa/CstrmrDscnTTMList.lims', param, dialogGridID);
    }

    $('.searchClass').keypress(function (e) {
        if (e.which == 13)
            getPopList();
    });
}

function lotTracedialog(btnId, dialogId, gridId, sessionObj, selectFunc, prePopupOpenFunc) {

    var dialogGridID = "grid_" + dialogId;
    var gridId = "#" + gridId;
    var html = createDialog(1200)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000655); /* 의뢰 목록 */

    var body = ''
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnAddReqOnPop\" class=\"btn5\">" + lang.C100000880 + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnSearchReqOnPop\" class=\"search\" >" + lang.C100000767 + "</button>" /* 조회 */
        + "</div><br>"
        + "<form id=\"" + dialogId + "ReqSearchOnPopFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>"+lang.C100000986+"</th>" /* 의뢰 부서 */
        + "<td><select id=\"" + dialogId + "_schReqDeptOnPop\" name=\"schReqDeptOnPop\"></select></td>"
        + "<th>"+"분석실"+"</th>" /* 분석실 */
        + "<td><select id=\"" + dialogId + "_schCustlabOnPop\" name=\"schCustlabOnPop\"></select></td>"
        + "<th>"+lang.C100000659+"</th>" /* 의뢰 일자 */
        + "<td>"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqBeginDteOnPop\" class='searchClass wd6p' name=\"schReqBeginDteOnPop\" style=\"min-width: 6em\">"
        + "~" + "&nbsp"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqEndDteOnPop\" class='searchClass wd6p' name=\"schReqEndDteOnPop\" style=\"min-width: 6em\">"
        + "</td>"
        + "<th>"+lang.C100000139+"</th>" /* 검사 유형 */
        + "<td><select id=\"" + dialogId + "_schInspctTyCodeOnPop\" name=\"schInspctTyCodeOnPop\"></select></td>"
        + "</tr>"
        + "<tr>"
        + "<th>"+lang.C100000657+"</th>" /* 의뢰 번호 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schReqNoOnPop\" class='searchClass' name=\"schReqNoOnPop\"></td>"
        + "<th>"+"시료 정보"+"</th>" /* 시료 정보 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schSploreNmOnPop\" class='searchClass' name=\"schSploreNmOnPop\"></td>"
        + "<th>"+lang.C100000809+"</th>" /* 제품 명 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schMtrilNmOnPop\" class='searchClass' name=\"schMtrilNmOnPop\"></td>"
        + "<th>"+"제품구분"+"</th>" /* 제품구분 */
        + "<td><select id=\"" + dialogId + "_schPrductTyCodeOnPop\" name=\"schPrductTyCodeOnPop\"></select></td>"
        + "</tr>"
        + "</table>"
        + "<input type='text' id='pageGbn' name='pageGbn' value='' style='display: none'>"
        + "<input type='text' id='mainReqestSeqno' name='mainReqestSeqno' value='' style='display: none'>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>"
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    // 그리드 생성
    var reqestCol = [];

    auigridCol(reqestCol);
    reqestCol
        .addColumnCustom("reqestSeqno", "의뢰 일렬번호", "*", false)
        .addColumnCustom("reqestDeptNm", lang.C100000986, "*", true)
        .addColumnCustom("reqestNo", lang.C100000657, "*", true)
        .addColumnCustom("custlabNm", "분석실", "*", true)
        .addColumnCustom("inspctTyNm", lang.C100000139, "*", true)
        .addColumnCustom("mtrilNm", lang.C100000716, "*", true)
        .addColumnCustom("clientNm", lang.C100000665, "*", true)
        .addColumnCustom("reqestDte", lang.C100000659, "*", false)
        .addColumnCustom("disabledGbn", "disabledGbn", "*", false)
        .addColumnCustom("prductTyNm", "제품구분", "*", true);

    var reqestGridProp = {
        editable: false,
        selectionMode: "multipleRows",
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
        rowCheckDisabledFunction: function(rowIndex, isChecked, item) {
            if (item.disabledGbn == "disabled") {
                return false;
            }

            return true;
        }
    };

    dialogGridID = createAUIGrid(reqestCol, dialogGridID, reqestGridProp);

    popupInit(btnId, dialogId, function() {
        var gridData = AUIGrid.getSelectedItems(gridId);
        if (gridData.length != 0)
            $('input[name=mainReqestSeqno]').attr('value', gridData[0]["item"]["reqestSeqno"]);

        AUIGrid.resize(dialogGridID);
        AUIGrid.setAllCheckedRows(dialogGridID, false);
        AUIGrid.clearGridData(dialogGridID);
    }, prePopupOpenFunc);

    ajaxJsonComboBox("/wrk/getDeptComboList.lims", dialogId+"_schReqDeptOnPop", { bestInspctInsttCode : sessionObj.bplcCode }, true, null, sessionObj.deptCode);
    ajaxJsonComboBox("/com/getCustLabCombo.lims", dialogId+"_schCustlabOnPop", null, true);
    ajaxJsonComboBox("/com/getCmmnCode.lims",dialogId+"_schInspctTyCodeOnPop",{ upperCmmnCode : "SY07", inCode : "'SY07000001','SY07000002'" }, false, null);
    ajaxJsonComboBox("/com/getCmmnCode.lims",dialogId+"_schPrductTyCodeOnPop",{ upperCmmnCode : "SY20" }, true, null);
    datePickerCalendar([dialogId+"_schReqBeginDteOnPop", dialogId+"_schReqEndDteOnPop"], true, ["MM",-1], ["DD",0]);

    // 의뢰목록 조회
    function getReqestList() {
        customAjax({
            url: "/com/getReqestListPop.lims",
            data: $("#"+dialogId+"ReqSearchOnPopFrm")[0].toObject(true),
            successFunc: function (list) {
                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    $("#"+dialogId+"_btnAddReqOnPop").click(function() {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        var selectedItem = AUIGrid.getSelectedItems(dialogGridID);
            if (checkedItems.length == 0) {
                alert(lang.C100000497);  /* 선택된 행이 없습니다. */
                return false;
            }
            selectFunc(checkedItems);

        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#"+dialogId+"_btnSearchReqOnPop").click(function() {
        getReqestList();
    });

    AUIGrid.bind(dialogGridID, "ready", function(event) {
        gridColResize(dialogGridID, "2");
    });

    // 셀 더블클릭 시 Lot Trace 단일행 추가
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function(event) {
        if (event.item.disabledGbn != 'disabled') {
            var arr = new Array(event.item);
            if (dialogId != "ncrReqDialog") {
                selectFunc(arr);
            } else {
                selectFunc(event.item);
            }

            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 비활성화가 안된 체크박스에 한해 전체체크 컨트롤
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function(event) {
        if (event.checked) {
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disabledGbn", "undisabled");
        } else {
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disabledGbn", "undisabled");
        }
    });

    $(".searchClass").keypress(function (e) {
        if (e.which == 13)
            getReqestList();
    });
}

function coaPrductdialog(btnId, dialogId, masterGridId, sessionObj, selectFunc, prePopupOpenFunc) {

    var dialogGridID = "grid_" + dialogId;
    var masterGridId = "#" + masterGridId;
    var html = createDialog(1200)
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, lang.C100000655); /* 의뢰 목록 */

    var body = ''
        + "<div class=\"subCon1\">"
        + "<div class=\"btnWrap\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnAddReqOnPop\" class=\"btn5\">" + "선택" + "</button>" /* 추가 */
        + "<button type=\"button\" id=\"" + dialogId + "_btnSearchReqOnPop\" class=\"search\" >" + lang.C100000767 + "</button>" /* 조회 */
        + "</div><br>"
        + "<form id=\"" + dialogId + "ReqSearchOnPopFrm\" onsubmit=\"return false;\">"
        + "<table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" class=\"subTable1\">"
        + "<colgroup>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "<col style=\"width:10%\"></col>"
        + "<col style=\"width:15%\"></col>"
        + "</colgroup>"
        + "<tr>"
        + "<th>"+lang.C100000657+"</th>" /* 의뢰 번호 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schReqNoOnPop\" class='searchClass' name=\"schReqNoOnPop\"></td>"
        + "<th>"+lang.C100000986+"</th>" /* 의뢰 부서 */
        + "<td><select id=\"" + dialogId + "_schReqDeptOnPop\" name=\"schReqDeptOnPop\"></select></td>"
        + "</tr>"
        + "<tr>"
        + "<th>"+lang.C100000139+"</th>" /* 검사 유형 */
        + "<td><select id=\"" + dialogId + "_schInspctTyCodeOnPop\" name=\"schInspctTyCodeOnPop\"></select></td>"
        + "<th>"+lang.C100000659+"</th>" /* 의뢰 일자 */
        + "<td>"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqBeginDteOnPop\" class='searchClass wd6p' name=\"schReqBeginDteOnPop\" style=\"min-width: 6em\">"
        + "~" + "&nbsp"
        + "<input type=\"text\" id=\"" + dialogId + "_schReqEndDteOnPop\" class='searchClass wd6p' name=\"schReqEndDteOnPop\" style=\"min-width: 6em\">"
        + "</td>"
        + "</tr>"
        + "<tr>"
        + "<th>"+"Lot No."+"</th>" /* Lot No. */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schReqNoOnPop\" class='searchClass' name=\"schReqNoOnPop\"></td>"
        + "<th>"+"제품명"+"</th>" /* 제품명 */
        + "<td><input type=\"text\" id=\"" + dialogId + "_schSploreNmOnPop\" class='searchClass' name=\"schSploreNmOnPop\"></td>"
        + "</tr>"
        + "</table>"
        + "<input type='text' id='`pageGbn`' name='pageGbn' value='' style='display: none'>"
        + "</form>"
        + "</div>"
        + "<div class = 'subCon2'>"
        + "<div id='" + dialogGridID + "' class=\"mgT15" + "\" style='width:100%;margin:0 auto;'>"
        + "</div>"
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");
    html = html.replace(/#sameline#/g, "");

    $("#sub_wrap").append(html);

    // 그리드 생성
    var reqestCol = [];

    auigridCol(reqestCol);
    reqestCol
        .addColumnCustom("reqestSeqno", "의뢰 일련번호", "*", false)
        .addColumnCustom("reqestNo", "의뢰번호", "*", true)
        .addColumnCustom("lotNo", "Lot No.", "*", true)
        .addColumnCustom("reqestDeptNm", lang.C100000986, "*", true)
        .addColumnCustom("clientNm", "의뢰자", "*", true)
        .addColumnCustom("reqestDte", "의뢰일자", "*", true)
        .addColumnCustom("inspctTyNm", "검사유형", "*", true)
        .addColumnCustom("custlabNm", "분석실", "*", true)
        .addColumnCustom("prductTyNm", "제품구분", "*", true)
        .addColumnCustom("mtrilNm", "제품명", "*", true)
        .addColumnCustom("mnfcturDte", "제조일자", "*", true)
        .addColumnCustom("sploreNm", "시료정보", "*", true)
        .addColumnCustom("rm", "특이사항", "*", true)
        .addColumnCustom("roaCreatAt", "ROA 생성여부", "*", false)
        .addColumnCustom("disGubun", 'disGubun', "*", false);
    

    var reqestGridProp = {
        editable: false,
        selectionMode: "multipleCells",
        showRowCheckColumn: true,
        showRowAllCheckBox: true,
        independentAllCheckBox: true,
        rowCheckDisabledFunction: function(rowIndex, isChecked, item) {
            if (item.disGubun == "disabled") {
                return false;
            }
            return true;
        }
    };

    dialogGridID = createAUIGrid(reqestCol, dialogGridID, reqestGridProp);

    popupInit(btnId, dialogId, function() {
        AUIGrid.resize(dialogGridID);
        AUIGrid.setAllCheckedRows(dialogGridID, false);
        AUIGrid.clearGridData(dialogGridID);
    }, prePopupOpenFunc);

    ajaxJsonComboBox("/wrk/getDeptComboList.lims", dialogId+"_schReqDeptOnPop", { bestInspctInsttCode : sessionObj.bplcCode }, true, null, sessionObj.deptCode);
    ajaxJsonComboBox("/com/getCustLabCombo.lims", dialogId+"_schCustlabOnPop", null, true);
    ajaxJsonComboBox("/com/getCmmnCode.lims", dialogId+"_schInspctTyCodeOnPop",{ upperCmmnCode : "SY07", inCode : "'SY07000003'" }, false, null, "SY07000003");
    ajaxJsonComboBox("/com/getCmmnCode.lims", dialogId+"_schPrductTyCodeOnPop",{ upperCmmnCode : "SY20" }, true, null);
    datePickerCalendar([dialogId+"_schReqBeginDteOnPop", dialogId+"_schReqEndDteOnPop"], true, ["MM", -1], ["DD", 0]);

    //의뢰목록 조회
    function getReqestList() {

        var formData = $('#'+dialogId+'ReqSearchOnPopFrm')[0].toObject(true);
        formData.mtrilSeqno = $('#mtrilSeqno').val();
        customAjax({
            url: "/com/getReqestListPop.lims",
            data: formData,
            successFunc: function (list) {
                var masterGridData = AUIGrid.getGridData(masterGridId);

                //추가한 항목이 있을 경우엔 해당 항목 찾아서 비활성화 처리
                if (masterGridData.length > 0) {
                    for (var i = 0; i < list.length; i++) {
                        for (var j = 0; j < masterGridData.length; j++) {
                            if (list[i].reqestSeqno == masterGridData[j].lwprtReqestSeqno) {
                                list[i].disGubun = 'disabled';
                                break;
                            }
                        }
                        //추가되지 않은 항목은 활성화
                        if (!list[i].disGubun) {
                            list[i].disGubun = 'undisabled';
                        }
                    }
                //추가한 항목이 없을 경우엔 모든 체크박스 활성화
                } else {
                    for (var i = 0; i < list.length; i++) {
                        list[i].disGubun = 'undisabled';
                    }
                }

                AUIGrid.setGridData(dialogGridID, list);
            }
        });
    }

    $("#"+dialogId+"_btnAddReqOnPop").click(function() {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(dialogGridID);
        if (checkedItems.length == 0) {
            alert(lang.C100000497);  /* 선택된 행이 없습니다. */
            return false;
        }
        selectFunc(checkedItems);

        // 본 화면 그리드에 뿌려줌
        $("#popupClose_" + dialogId).trigger("click");
    });

    $("#"+dialogId+"_btnSearchReqOnPop").click(function() {
        getReqestList();
    });

    AUIGrid.bind(dialogGridID, "ready", function(event) {
        gridColResize(dialogGridID, "2");
    });

    // row 더블클릭 시, 단일 행 즉시 추가
    AUIGrid.bind(dialogGridID, "cellDoubleClick", function(event) {
        if (event.item.disGubun != 'disabled') {
            var arr = new Array(event.item);
            if(dialogId != "ncrReqDialog"){
                selectFunc(arr);
            } else {
                selectFunc(event.item);
            }

            $("#popupClose_" + dialogId).trigger("click");
        }
    });

    // 비활성화가 안된 체크박스에 한해 전체체크 컨트롤
    AUIGrid.bind(dialogGridID, "rowAllChkClick", function(event) {
        if (event.checked)
            AUIGrid.addCheckedRowsByValue(dialogGridID, "disGubun", "undisabled");
        else
            AUIGrid.addUncheckedRowsByValue(dialogGridID, "disGubun", "undisabled");
    });

    $(".searchClass").keypress(function (e) {
        if (e.which == 13) {
            getReqestList();
        }
    });
}

function dialogBatchUpdCylnder(btnId, dialogId, gridId) {

    var gridId = '#' + gridId;

    var html = createDialog(450, 330);
    html = html.replace(/#dialogId#/g, dialogId);
    html = html.replace(/#title#/g, "일괄 수정"); /* 일괄 수정 */

    var sameLine = ""
        + "<div class=\"btnWrap mgT7 mgR9\">"
        + "<button type=\"button\" id=\"" + dialogId + "_btnBatchUpdate\" class=\"save\">"+lang.C100000760+"</button>" /* 저장 */
        + "</div>";

    var body = ""
        + "<div class=\"subCon1 mgT10\">"
        + "<input type=\"text\" class=\"wd98p\" id=\"" + dialogId + "_batchEditVal\" name=\"schReqNoOnPop\" maxlength=\"200\" placeholder=\"VALVE_MAKER 일괄 수정 값\">"
        + "</div>";
    html = html.replace(/#topright#/g, "");
    html = html.replace(/#sameline#/g, sameLine);
    html = html.replace(/#body#/g, body);
    html = html.replace(/#flexbox#/g, "");

    $("#sub_wrap").append(html);

    popupInit(btnId, dialogId, function() {
        $('#'+dialogId+'_batchEditVal').val('');
    });

    document.getElementById(dialogId + '_btnBatchUpdate').addEventListener('click', function() {
        var checkedItems = AUIGrid.getCheckedRowItemsAll(gridId);
        if (checkedItems.length == 0) {
            alert(lang.C100001366); /* 선택된 실린더가 없습니다. */
            return;
        }

        var editVal = $('#'+ dialogId+'_batchEditVal').val();
        if (!editVal) {
            alert(lang.C100000115); /* 값을 입력해야 합니다. */
            return;
        }

        // 일괄수정값을 수정할 item배열의 끝에 붙여서 넘김
        var paramObj = { valveMnfcturprofsNm: editVal };
        checkedItems.push(paramObj);
        customAjax({
            url: "/wrk/batchUpdValvMaker.lims",
            data: checkedItems,
            successFunc: function(data) {
                if (data == 1) {
                    success(lang.C100000765);
                    $('#popupClose_'+dialogId).click();
                    getCylinder();
                } else {
                    err(lang.C100000597);
                }
            }
        });
    });

}

