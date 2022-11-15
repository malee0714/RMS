
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
                            <td><input type="text" name="schEdcSj" class="schClass edcSch"></td>

                            <th>교육 일자</th> <!-- 교육 일자 -->
                            <td>
                                <input type="text" name="schEdcBeginDte" class="dateChk wd6p schClass edcSch" style="min-width:6em;">
                                ~
                                <input type="text" name="schEdcEndDte" class="dateChk wd6p schClass edcSch" style="min-width:6em;">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="subCon2">
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div id="EdcGrid" class="mgT15" style="height: 300px"></div>
            </div>

            <form id="EdcForm" onsubmit="return false;">
                <div class="subCon1 mgT20" id="detail">
                    <h2><i class="fi-rr-apps"></i>교육 정보</h2> <!-- 교육 정보 -->
                    <div class="btnWrap">
                        <button type="button" id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                        <button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                        <button type="button" id="btnSave" class="save">저장</button> <!-- 저장 -->
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="subTable1">
                        <colgroup>
                            <col style="width:10%">
                            <col style="width:15%">
                            <col style="width:10%">
                            <col style="width:15%">
                            <col style="width:10%">
                            <col style="width:15%">
                            <col style="width:10%">
                            <col style="width:15%">
                        </colgroup>
                        <tr>
                            <th class="necessary">교육 구분</th> <!-- 교육 구분 -->
                            <td><select id="edcSeCode" name="edcSeCode" class="wd100p" required></select></td>

                            <th class="necessary">교육 구분 상세</th> <!-- 교육 구분 상세 -->
                            <td><select id="edcSeDetailCode" name="edcSeDetailCode" class="wd100p" required></select></td>

                            <th class="necessary">교육 제목</th> <!-- 교육 제목 -->
                            <td><input type="text" id="edcSj" name="edcSj" maxlength="1000" required></td>

                            <th>평가 기준</th> <!-- 평가 기준 -->
                            <td><select id="edcEvlStdrCode" name="edcEvlStdrCode"></select></td>
                        </tr>

                        <tr>
                            <th class="necessary">교육 기관 명</th> <!-- 교육 기관 명 -->
                            <td><input type="text" id="edcInsttNm" name="edcInsttNm" maxlength="200" required></td>

                            <th class="necessary">교육 시작 일자</th> <!-- 교육 시작 일자 -->
                            <td><input type="text" id="edcBeginDte" name="edcBeginDte" class="dateChk" required></td>

                            <th class="necessary">교육 종료 일자</th> <!-- 교육 종료 일자 -->
                            <td><input type="text" id="edcEndDte" name="edcEndDte" class="dateChk" required></td>

                            <th id="nxttrmEdcDteTh">차기 교육 대상</th> <!-- 차기 교육 대상 -->
                            <td>
                                <input type="checkbox" id="nxttrmEdcTrgetAt" name="nxttrmEdcTrgetAt">
                                <input type="text" id="nxttrmEdcDte" name="nxttrmEdcDte" class="mgL5 wd85p dateChk" disabled>
                            </td>
                        </tr>

                        <tr>
                            <th>평가자 구분</th> <!-- 평가자 구분 -->
                            <td>
                                <label><input type="radio" id="innerEvlerAt_Y" name="innerEvlerAt" value="Y">내부</label> <!-- 내부 -->
                                <label><input type="radio" id="innerEvlerAt_N" name="innerEvlerAt" value="N" checked>외부</label> <!-- 외부 -->
                            </td>

                            <th>평가자</th> <!-- 평가자 -->
                            <td id="evlerParentEl"><input type="text" id="evlerNm" name="evlerNm" maxlength="200"></td>
                            <td colspan="4"></td>
                        </tr>

                        <tr>
                            <th>평가 내용</th> <!-- 평가 내용 -->
                            <td colspan="12"><textarea id="evlCn" name="evlCn" rows="1" class="wd100p" maxlength="4000"></textarea></td>
                        </tr>

                        <tr>
                            <th>비고</th> <!-- 비고 -->
                            <td colspan="12"><textarea id="rm" name="rm" rows="2" class="wd100p" maxlength="4000"></textarea></td>
                        </tr>

                        <tr>
                            <th>${msg.C100000860}</th> <!-- 첨부 파일 -->
                            <td colspan="8">
                                <!-- 파일첨부영역 -->
                                <div id="dropZoneArea"></div>
                                <input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno">
                                <input type="hidden" id="btnFileSave">
                            </td>
                        </tr>
                    </table>
                    <input type="text" id="edcSeqno" name="edcSeqno" style="display: none">
                    <input type="text" id="deleteAt" name="deleteAt" value="N" style="display: none">
                </div>
            </form>

            <div style="display: flex" class="mgT15">
                <div class="subCon2 wd60p fL">
                    <div class="subCon1">
                        <h3>전체 사용자</h3> <!-- 전체 사용자 -->
                        <div class="btnWrap">
                            <button type="button" id="btnUserSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
                        </div>
                        <table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="subTable2">
                            <colgroup>
                                <col style="width: 20%">
                                <col style="width: 30%">
                                <col style="width: 20%">
                                <col style="width: 30%">
                            </colgroup>
                            <tr>
                                <th>부서 명</th> <!-- 부서 명 -->
                                <td><select id="deptCodeSch" name="deptCodeSch"></select></td>

                                <th>사용자 명</th> <!-- 사용자 명 -->
                                <td><input type="text" id="userNmSch" name="userNmSch" class="schClass"></td>
                           </tr>
                        </table>
                    </div>
                    <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                    <div id="AllUserGrid" class="mgT10" style="height: 256px"></div>
                </div>

                <div class="arrowWrap wd10p mgT25" style="float: left;">
                    <div>
                        <button type="button" id="btnRightArrow"><i class="fi-rr-angle-right"></i></button>
                    </div>
                    <div class="mgT20">
                        <button type="button" id="btnLeftArrow"><i class="fi-rr-angle-left"></i></button>
                    </div>
                </div>

                <div class="subCon2 wd100p">
                    <div class="subCon1">
                        <h3>교육 대상자</h3> <!-- 교육 대상자 -->
                    </div>
                    <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                    <div id="EdcUserGrid" class="mgT10" style="height: 300px"></div>
                </div>
            </div>

            <div class="accordion_wrap mgT17">
                <div class="accordion">교육 이력</div> <!-- 교육 이력 -->
                <div id="acc1" class="acco_top mgT15" style="display: none">
                    <h3>교육 이력</h3> <!-- 교육 이력 -->
                    <div class="subCon2">
                        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                        <div id="EdcDocHistGrid" class="mgT15" style="height: 300px"></div>
                    </div>
                </div>
            </div>
        </div>

    </tiles:putAttribute>
    <tiles:putAttribute name="script">

        <script>

            var edcGrid = "EdcGrid";
            var allUserGrid = "AllUserGrid";
            var edcUserGrid = "EdcUserGrid";
            var edcDocHistGrid = "EdcDocHistGrid";
            var lang = ${msg};
            var dropZoneArea;

            var searchForm = document.getElementById("SearchForm").id;
            var edcForm = document.getElementById("EdcForm").id;


            $(function() {

                init();

                setCombo();

                buildGrid();

                auiGridEvent();

                buttonEvent();

            });


            function init() {
                datePickerCalendar(["schEdcBeginDte", "schEdcEndDte"], true, ["YY",-1], ["DD",0]);
                datePickerCalendar(["edcBeginDte", "edcEndDte", "nxttrmEdcDte"], false);
                dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnFileSave", maxFiles : 10, lang : lang.C100000867 });
            }


            function setCombo() {
                ajaxJsonComboBox("/com/getCmmnCode.lims", "schedcSeCode", { upperCmmnCode : "RS07" }, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "schEdcSeDetailCode", { upperCmmnCode : "RS33" }, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "edcSeCode", { upperCmmnCode : "RS07" }, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "edcSeDetailCode", { upperCmmnCode : "RS33" }, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "edcEvlStdrCode", { upperCmmnCode : "RS09" }, true);
                ajaxJsonComboBox("/wrk/getDeptComboList.lims", "deptCodeSch", { bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}" }, true, null, ${UserMVo.deptCode});
            }


            function buildGrid() {

                var col = {
                    edcCol: [],
                    allUserCol: [],
                    edcUserCol: [],
                    edcDocHistCol: []
                };

                /********************** 교육 목록 **********************/
                var edcProp = {
                    editable: false,
                    selectionMode: "multipleCells"
                };

                auigridCol(col.edcCol);

                col.edcCol
                .addColumnCustom("edcSeNm", "교육 구분", "*", true)
                .addColumnCustom("edcSeqno", "교육 일련번호", "*", false)
                .addColumnCustom("edcSeCode", "교육 구분 코드", "*", false)
                .addColumnCustom("edcSeDetailCode", "교육 구분 상세 코드", "*", false)
                .addColumnCustom("edcSeDetailNm", "교육 구분 상세", "*", true)
                .addColumnCustom("edcSj", "교육 제목", "*", true)
                .addColumnCustom("edcBeginDte", "교육 시작 일자", "*", true)
                .addColumnCustom("edcEndDte", "교육 종료 일자", "*", true)
                .addColumnCustom("edcUser", "대상자", "*", true)
                .addColumnCustom("innerEvlerAt", "평가자 구분", "*", false)
                .addColumnCustom("innerEvler", "평가자 구분", "*", true)
                .addColumnCustom("evlerNm", "평가자", "*", true)
                .addColumnCustom("edcEvlStdrCode", "교육 평가 기준 코드", "*", false)
                .addColumnCustom("evlStdrNm", "평가 기준", "*", true)
                .addColumnCustom("nxttrmEdcTrgetAt", "차기 교육 대상 여부", "*", false)
                .addColumnCustom("nxtEdcTrget", "차기 교육", "*", true)
                .addColumnCustom("nxttrmEdcDte", "차기 교육 일자", "*", true)
                .addColumnCustom("edcInsttNm", "교육 기관 명", "*", true)
                .addColumnCustom("evlCn", "평가 내용", "*", true)
                .addColumnCustom("rm", "비고", "*", true)
                .addColumnCustom("atchmnflSeqno", "첨부파일 일련번호", "*", false)
                .addColumnCustom("useAt", "사용 여부", "*", false);

                edcGrid = createAUIGrid(col.edcCol, edcGrid, edcProp);


                /********************** 전체 사용자 **********************/
                var allUserProp = {
                    editable: false,
                    selectionMode: "multipleCells",
                    enableCellMerge: true,
                    showRowCheckColumn: true,
                    showRowAllCheckBox: true
                };

                auigridCol(col.allUserCol);

                col.allUserCol
                .addColumnCustom("inspctInsttNm", "부서 명", "*", true)
                .addColumnCustom("userId", "사용자 ID", "*", false)
                .addColumnCustom("userNm", "사용자 명", "*", true);

                allUserGrid = createAUIGrid(col.allUserCol, allUserGrid, allUserProp);


                /********************** 교육 대상자 **********************/
                var edcUserProp = {
                    editable: true,
                    selectionMode: "multipleCells",
                    showRowCheckColumn: true,
                    showRowAllCheckBox: true
                };

                var headerTooltipProp = {
                    style : "my-require-style",
                    headerTooltip : {
                        show : true,
                        tooltipHtml : lang.C100000114 /* 값을 입력 또는 선택하세요. */
                    }
                };

                var dropList = [
                    { key : "선택", value : "" },
                    { key : "획득", value : "RS10000001" },
                    { key : "재교육", value : "RS10000002" },
                    { key : "보륲", value : "RS10000003" },
                    { key : "탈락", value : "RS10000004" }
                ];

                auigridCol(col.edcUserCol);

                col.edcUserCol
                .addColumnCustom("edcUserSeqno", "교육대상자 일렬번호", "*", false)
                .addColumnCustom("edcSeqno", "교육대상자 일렬번호", "*", false)
                .addColumnCustom("inspctInsttNm", "부서 명", "*", true, false)
                .addColumnCustom("userId", "사용자 ID", "*", false)
                .addColumnCustom("userNm", "사용자 명", "*", true, false)
                .addColumnCustom("evlResultValue", "평가 결과", "*", true, true, headerTooltipProp)
                .addColumnCustom("edcQualfAlwncCode", "자격 부여", "*", true)
                .addColumnCustom("deleteAt", "삭제 여부", "*", false)
                .dropDownListRenderer(["edcQualfAlwncCode"], dropList, true);

                edcUserGrid = createAUIGrid(col.edcUserCol, edcUserGrid, edcUserProp);


                /********************** 교육 이력 **********************/
                auigridCol(col.edcDocHistCol);

                col.edcDocHistCol
                .addColumnCustom("qlityDocHistSeqno", "이력 일렬번호", "*", false, false)
                .addColumnCustom("tableNm", lang.C100000973, "*", true, false)
                .addColumnCustom("tableCmNm", lang.C100000974, "*", true, false)
                .addColumnCustom("columnNm", lang.C100000975, "*", true, false)
                .addColumnCustom("columnCmNm", lang.C100000976, "*", true, false)
                .addColumnCustom("seqno", "일련번호", "*", false, false)
                .addColumnCustom("changeBfeCn", lang.C100000382, "*", true, false)
                .addColumnCustom("changeAfterCn", lang.C100000384, "*", true, false)
                .addColumnCustom("changerNm", "최종 변경자", "*", true, false)
                .addColumnCustom("lastChangeDt", "최종 변경일시", "*", true, false);

                edcDocHistGrid = createAUIGrid(col.edcDocHistCol, edcDocHistGrid, edcProp);

                gridResize([edcGrid, allUserGrid, edcUserGrid]);
            }


            function auiGridEvent() {

                AUIGrid.bind(edcGrid, "cellDoubleClick", function(event) {
                    $("#nxttrmEdcDte").prop("disabled", false);
                    $("#btnDelete").show();

                    detailAutoSet({
                        item: event.item
                        ,targetFormArr: [edcForm]
                        ,ignoreFormArr: [searchForm]
                        ,successFunc: function() {
                            // 차기교육 대상여부 체크상태 auto set
                            if (event.item.nxttrmEdcTrgetAt == "Y") {
                                $("#nxttrmEdcTrgetAt").prop("checked", true);
                            } else {
                                $("#nxttrmEdcTrgetAt").prop("checked", false);
                            }

                            nxttrmEdcTrgetAtEvent(); // 차기교육대상 체크여부에 따른 이벤트 발생
                            innerEvlerAtEvent(event.item.evlerNm); // 평가자구분에 따른 평가자 element 변경 및 데이터 바인딩
                            dropZoneArea.getFiles(event.item.atchmnflSeqno);
                            loadEdcUser(event.item.edcSeqno); // 교육대상자 조회
                            loadEdcDocHist(event.item); // 교육이력 조회
                            AUIGrid.clearGridData(allUserGrid);
                        }
                    });
                });
            }


            function buttonEvent() {

                $("#btnSearch").click(function() {
                    searchEdc();
                });

                $("#btnNew").click(function() {
                    reset();
                });

                $("#btnDelete").click(function() {
                    if (!$("#edcSeqno").val()) return;

                    if (confirm(lang.C100000461)) { /* 삭제 하시겠습니까? */
                        $("#deleteAt").val("Y");
                        saveEdc();
                    }
                });

                $("#btnSave").click(function() {
                    fileSave();
                });

                $("#btnUserSearch").click(function() {
                    loadAllUser(AUIGrid.getGridData(edcUserGrid));
                });

                $(".arrowWrap").click(function(e) {
                    if (e.target.tagName == "DIV")
                        return;

                    arrowCtrl(e);
                });

                $("#nxttrmEdcTrgetAt").change(function() {
                    nxttrmEdcTrgetAtEvent();
                });

                $("[name=innerEvlerAt]").change(function() {
                    innerEvlerAtEvent();
                });

            }


            function innerEvlerAtEvent(val) {

                if ($("[name=innerEvlerAt]:checked").val() == "Y") {
                    $("#evlerParentEl").empty();

                    // select 태그를 자식노드로 추가
                    var $select = $("<select id='evlerNm' name='evlerNm' style='width: 100%'>");
                    $("#evlerParentEl").append($select);

                    // select2box 바인딩 (셀 더블클릭한 경우 event값을 기본값으로 세팅)
                    ajaxSelect2Box({ajaxUrl: "/com/getUserNmCombo.lims", elementId: "evlerNm", defaultVal: val});
                } else {
                    $("#evlerParentEl").empty();

                    // input 태그를 자식노드로 추가
                    var $input = $("<input type='text' id='evlerNm' name='evlerNm' maxlength='200'>");
                    $("#evlerParentEl").append($input);
                    $("#evlerNm").val(val);
                }
            }


            function nxttrmEdcTrgetAtEvent() {
                var chckVal = $("#nxttrmEdcTrgetAt").is(":checked");
                if (chckVal) {
                    $("#nxttrmEdcDte").prop("disabled", false);
                    $("#nxttrmEdcDte").prop("required", true);
                    $("#nxttrmEdcDteTh").addClass("necessary");
                } else {
                    $("#nxttrmEdcDte").prop("disabled", true);
                    $("#nxttrmEdcDte").prop("required", false);
                    $("#nxttrmEdcDteTh").removeClass("necessary");
                }
            }


            function arrowCtrl(e) {

                var source = allUserGrid;
                var target = edcUserGrid;
                var eventObj = e.target.id || e.target.className;
                var btnId = (eventObj == "btnRightArrow" || eventObj == "fi-rr-angle-right") ? "btnRightArrow" : "btnLeftArrow";

                if (btnId == "btnLeftArrow") {
                    if (!confirm(lang.C100000461))
                        return;

                    source = edcUserGrid;
                    target = allUserGrid;
                }

                var chkedItem = AUIGrid.getCheckedRowItemsAll(source); // 체크한 행 아이템
                var chkedItemIndex = AUIGrid.getCheckedRowItems(source); // 체크한 행 아이템과 rowIndex

                if (chkedItem.length > 0) {
                    var indexArr = [];
                    for (var item of chkedItemIndex) {
                        indexArr.push(item.rowIndex); // 옮기려는 사용자의 rowIndex를 배열에 담음
                    }
                    AUIGrid.removeRow(source, indexArr);

                    for (var item of chkedItem) {
                        item.edcQualfAlwncCode = "";
                    }
                    AUIGrid.addRow(target, chkedItem, "last");
                }
            }


            function fileSave() {

                if (!saveValidation(edcForm)) {
                    return;
                }

                var bool = gridRequire({
                    requireColumns: ["evlResultValue"]
                    ,gridId : edcUserGrid
                    ,list: AUIGrid.getGridData(edcUserGrid)
                    ,msg: "평가결과 값을 입력해주세요."
                });
                if (!bool) {
                    return;
                }

                var fileCnt = dropZoneArea.getNewFiles().length;
                if (fileCnt > 0) {
                    $("#btnFileSave").click();

                    dropZoneArea.on("uploadComplete", function(event, fileIdx) {
                        if (fileIdx == -1) {
                            err(lang.C100000864) /* 첨부파일 저장에 실패하였습니다. */
                            return;
                        }
                        $("#atchmnflSeqno").val(fileIdx);
                        saveEdc();
                    });

                } else {
                    saveEdc();
                }
            }


            function saveEdc() {

                var param = $("#EdcForm").serializeObject();
                param.nxttrmEdcTrgetAt = $("#nxttrmEdcTrgetAt").prop("checked") == true ? "Y" : "N";
                param.gridData = AUIGrid.getGridData(edcUserGrid);
                param.addedRow = AUIGrid.getAddedRowItems(edcUserGrid);
                param.editedRow = AUIGrid.getEditedRowItems(edcUserGrid);
                param.removedRow = AUIGrid.getRemovedItems(edcUserGrid);

                customAjax({
                    url: "/qa/saveEdc.lims",
                    data: param,
                    successFunc: function(str) {
                        if (str == "save") {
                            success(lang.C100000762); /* 저장되었습니다. */
                        } else if (str == "delete") {
                            success(lang.C100000462); /* 삭제되었습니다. */
                        }

                        reset();
                        searchEdc(param.edcSj);
                    }
                });
            }


            function loadEdcUser(seqNo) {
                customAjax({
                    url: "/qa/getEdcUserList.lims",
                    data: { edcSeqno: seqNo },
                    successFunc: function(list) {
                        var edcUsers = list;
                        for (var row of edcUsers) {
                            row.edcQualfAlwncCode = "";
                        }
                        AUIGrid.setGridData(edcUserGrid, edcUsers);
                    }
                });
            }


            function loadAllUser() {

                var param = {
                    deptCodeSch: $("#deptCodeSch").val(),
                    userNmSch: $("#userNmSch").val(),
                    useAtSch : "Y"
                };

                getGridDataParam("/wrk/getUserMList.lims", param, allUserGrid).then(function() {
                    var source = AUIGrid.getGridData(edcUserGrid);
                    if (source.length > 0) {
                        var duplicateUsers = [];
                        for (var s of source) {
                            duplicateUsers.push(s.userId);
                        }

                        // 교육대상자에 등록된 사용자 제거
                        var removeIndex = AUIGrid.getRowIndexesByValue(allUserGrid, "userId", duplicateUsers);
                        AUIGrid.removeRow(allUserGrid, removeIndex);
                    }
                });
            }


            function loadEdcDocHist(item) {
                var param = {
                    tableNm : "RS_EDC",
                    seqno : item.edcSeqno
                };

                getGridDataParam('/com//getQlityDocHistList.lims', param, edcDocHistGrid);
            }


            function searchEdc(rowVal) {
                getGridDataForm("/qa/getEdcList.lims", searchForm, edcGrid, function() {
                    if (rowVal)
                        gridSelectRow(edcGrid, "edcSj", rowVal);
                });
            }


            function reset() {
                pageReset([edcForm], [allUserGrid, edcUserGrid], [dropZoneArea],
                    function() {
                        innerEvlerAtEvent();
                        $("#btnDelete").hide();
                    }
                );
            }


            function doSearch(e) {
                if (e.target.className.indexOf("edcSch") > 0) {
                    searchEdc();
                } else {
                    loadAllUser(AUIGrid.getGridData(edcUserGrid));
                }
            }


        </script>

    </tiles:putAttribute>
</tiles:insertDefinition>
