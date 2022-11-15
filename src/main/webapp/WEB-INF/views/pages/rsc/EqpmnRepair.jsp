<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">장비 수리이력</tiles:putAttribute>
    <tiles:putAttribute name="body">

        <div class="subContent">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>장비 수리 목록</h2> <!-- 장비 수리 목록 -->
                <div class="btnWrap">
                    <button type="button" id="btnSelect" class="search">${msg.C100000767}</button> <!-- 조회 -->
                </div>
                <form id="SearchFrm">
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
                            <th>장비 분류</th>  <!-- 장비 분류 -->
                            <td><select id="schEqpmnClCode" name="schEqpmnClCode"></select></td>

                            <th>분석실</th> <!-- 분석실 -->
                            <td><select id="schCustlabSeqno" name="schCustlabSeqno"></select></td>

                            <th>${msg.C100000742}</th> <!-- 장비 명 -->
                            <td><input type="text" id="schEqpmnNm" name="schEqpmnNm" class="wd100p schClass"></td>

                            <th>${msg.C100000518}</th> <!-- 수리 일자 -->
                            <td>
                            <input type="text" id="schRepairBeginDte" name="schRepairBeginDte" class="dateChk schClass wd6p" style="min-width: 6em;">
                            ~
                            <input type="text" id="schRepairEndDte" name="schRepairEndDte" class="dateChk schClass wd6p" style="min-width: 6em;">
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="subCon2">
                <div id="EqpmnRepairHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
            </div>

            <form id="EqpmnRepairMForm">
                <div class="subCon1 mgT15" id="detail">
                    <h2><i class="fi-rr-apps"></i>${msg.C100000750}</h2> <!-- 장비 수리 정보 -->
                    <div class="btnWrap">
                        <button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                        <button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                        <button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="eqpmntbl">
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
                            <th>장비 분류</th> <!-- 장비 분류 -->
                            <td><input type="text" id="eqpmnClNm" name="eqpmnClNm" readonly></td>

                            <th>장비 관리 번호</th> <!-- 장비 관리 번호 -->
                            <td><input type="text" id="eqpmnManageNo" name="eqpmnManageNo" readonly></td>

                            <th class="necessary">${msg.C100000742}</th> <!-- 장비 명 -->
                            <td>
                                <input type="text" id="eqpmnNm" name="eqpmnNm" class="wd80p" readonly required>
                                <button type="button" id="btnEqpmnPop" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                            </td>

                            <th class="necessary">${msg.C100000348}</th> <!-- 발생 원인 -->
                            <td><select id="occrrncCauseCode" name="occrrncCauseCode" class="wd100p" style="min-width:10em;" required></select></td>
                        </tr>

                        <tr>
                            <th class="necessary">${msg.C100000254}</th> <!-- 내/외부 수리 -->
                            <td style="text-align: left;">
                                <label><input type="radio" id="innerRepairAt_Y" name="innerRepairAt" value="Y" >${msg.C100000255}</label> <!-- 내부 -->
                                <label><input type="radio" id="innerRepairAt_N" name="innerRepairAt" value="N" checked>${msg.C100000613}</label> <!-- 외부 -->
                            </td>

                            <th>${msg.C100000520}</th> <!-- 수리자 -->
                            <td><input type="text" id="repairmanNm" name="repairmanNm"  class="wd100p" maxlength="200"></td>

                            <th class="necessary">${msg.C100000517}</th> <!-- 수리 시작일시 -->
                            <td><input type="text" id="repairBeginDt" name="repairBeginDt" class="wd100p dateTimeChk" style="min-width:10em;" required></td>

                            <th>${msg.C100000519}</th> <!-- 수리 종료일시 -->
                            <td><input type="text" id="repairEndDt" name="repairEndDt" class="wd100p dateTimeChk" style="min-width:10em;"></td>
                        </tr>

                        <tr>
                            <th>수리 결과</th> <!-- 수리 결과 -->
                            <td><select id="eqpmnRepairResultCode" name="eqpmnRepairResultCode" class="wd100p" style="min-width:10em;"></select></td>
                            <td colspan="6"></td>
                        </tr>

                        <tr>
                            <th>${msg.C100000515}</th> <!-- 수리 내용 -->
                            <td colspan="7"><textarea id="repairCn" name="repairCn" rows="3" class="wd100p" style="min-width:10em;" maxlength="4000"></textarea></td>
                        </tr>

                        <tr>
                            <th>${msg.C100000425}</th> <!-- 비고-->
                            <td colspan="7"><textarea id="rm" name="rm" rows="3" class="wd100p" style="min-width:10em;" maxlength="4000"></textarea></td>
                        </tr>

                        <tr>
                            <th>${msg.C100000860}</th> <!-- 첨부파일 -->
                            <td colspan="8">
                                <div id="dropZoneArea"></div>
                                <input type="text" id="atchmnflSeqno" name="atchmnflSeqno" style="display: none" >
                                <button type="button" id="btnFileSave" style="display: none">
                            </td>
                        </tr>
                    </table>
                </div>

                <input type="text" id="eqpmnRepairHistSeqno" name="eqpmnRepairHistSeqno" style="display: none">
                <input type="text" id="eqpmnSeqno" name="eqpmnSeqno" style="display: none">
                <input type="text" id="deleteAt" name="deleteAt" value="N" style="display: none">
            </form>
        </div>

    </tiles:putAttribute>
    <tiles:putAttribute name="script">

        <script>

            var eqpmnRepairHistGrid = "EqpmnRepairHistGrid";
            var lang = ${msg};

            $(function() {

                init();

                setCombo();

                buildGrid();

                auiGridEvent();

                buttonEvent();

            });


            function init() {

                dialogEqpmn("btnEqpmnPop", "eqpmnDialog", function(item) {
                    $("#eqpmnSeqno").val(item.eqpmnSeqno);
                    $("#eqpmnClNm").val(item.eqpmnClNm);
                    $("#eqpmnManageNo").val(item.eqpmnManageNo);
                    $("#eqpmnNm").val(item.eqpmnNm);
                });

                datePickerCalendar(["schRepairBeginDte", "schRepairEndDte"], true, ["MM",-1], ["DD",0]);
                dateTimePickerCalendar(["repairBeginDt"], true, ["DD",0], ["DD",0]);
                dateTimePickerCalendar(["repairEndDt"], false);
                dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnFileSave", lang : "${msg.C100000867}" });
            }


            function setCombo() {
                ajaxJsonComboBox("/com/getCmmnCode.lims", "schEqpmnClCode",{ upperCmmnCode : "RS02" }, true);
                ajaxJsonComboBox("/com/getCustLabCombo.lims", "schCustlabSeqno", null, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "occrrncCauseCode", { upperCmmnCode : "RS21" }, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "eqpmnRepairResultCode", { upperCmmnCode : "RS05" }, true);
            }


            function buildGrid() {

                var col = [];
                auigridCol(col);

                col
                .addColumnCustom("eqpmnClNm", "장비 분류", "*", true)
                .addColumnCustom("eqpmnRepairHistSeqno", "장비수리이력 일련번호", "*" ,false)
                .addColumnCustom("eqpmnSeqno", "기기 일련번호", "*", false)
                .addColumnCustom("eqpmnManageNo", "${msg.C100000739}", "*", true)
                .addColumnCustom("eqpmnNm", "${msg.C100000742}", "*", true)
                .addColumnCustom("occrrncCauseCode", "발생 원인 코드", "*", false)
                .addColumnCustom("serialNo", "Serial No", "*", true)
                .addColumnCustom("modlNm", "모델 명", "*", true)
                .addColumnCustom("innerRepairAt", "${msg.C100000257}", "*", false)
                .addColumnCustom("innerRepairNm", "수리 구분", "*", true)
                .addColumnCustom("repairmanNm", "${msg.C100000520} ", "*", false)
                .addColumnCustom("repairBeginDt", "${msg.C100000517}", "*", true)
                .addColumnCustom("repairEndDt", "${msg.C100000519}", "*", true)
                .addColumnCustom("repairCn", "${msg.C100000515}", "*", false)
                .addColumnCustom("rm", "${msg.C100000425}", "*", true)
                .addColumnCustom("oprAt", "가동여부", "*", false)
                .addColumnCustom("deleteAt", "삭제여부", "*", false)
                .addColumnProperty(["eqpmnManageNo"], { cellMerge : true });

                var eqpmnRepairProp = {
                    editable : false,
                    selectionMode : "multipleCells",
                    enableCellMerge : true
                };

                eqpmnRepairHistGrid = createAUIGrid(col, eqpmnRepairHistGrid, eqpmnRepairProp);
            }


            function auiGridEvent() {

                AUIGrid.bind(eqpmnRepairHistGrid, "cellDoubleClick", function(event) {
                    detailAutoSet({
                        item: event.item
                        ,targetFormArr: ["EqpmnRepairMForm"]
                        ,successFunc: function() {
                            dropZoneArea.getFiles($("#atchmnflSeqno").val());
                            $("#btnEqpmnPop").hide();
                            $("#btnDelete").show();
                        }
                    });
                });
            }


            function buttonEvent() {

                $("#btnSelect").click(function() {
                    searchRepairHist();
                });

                $('#btnReset').click(function() {
                    reset();
                });

                $("#btnDelete").click(function(e) {
                    if (!$("#eqpmnRepairHistSeqno").val()) {
                        alert("${msg.C100000467}"); /* 삭제할 데이터가 없습니다. */
                        return;
                    }

                    saveRepairHist(e.target.id);
                });

                $("#btnSave").click(function(e) {
                    fileSave(e.target.id);
                });
            }


            function fileSave(btnId) {

                if (!saveValidation("EqpmnRepairMForm")) {
                    return;
                }

                var fileLength = dropZoneArea.getNewFiles().length;
                if (fileLength > 0) {
                    $("#btnFileSave").click();

                    dropZoneArea.on("uploadComplete", function(event, fileIdx) {
                        if (fileIdx == -1) {
                            err("첨부파일 저장에 실패하였습니다."); /* 첨부파일 저장에 실패하였습니다. */
                            return;
                        }
                        $("#atchmnflSeqno").val(fileIdx);
                        saveRepairHist(btnId);
                    });

                } else {
                    saveRepairHist(btnId);
                }
            }


            function saveRepairHist(btnId) {

                if (btnId == "btnDelete")
                    $("#deleteAt").val("Y");

                var frmData = $("#EqpmnRepairMForm").serializeObject();
                customAjax({
                    "url": "/rsc/saveEqpRepairHist.lims",
                    "data": frmData,
                    "successFunc": function(data) {
                        if (data > 0 && frmData.deleteAt == "N") {
                            success("${msg.C100000762}"); /* 저장되었습니다. */
                        } else if (data > 0 && frmData.deleteAt == "Y") {
                            success("${msg.C100000462}"); /* 삭제되었습니다. */
                        } else {
                            err("${msg.C100000597}"); /* 오류가 발생했습니다. */
                        }

                        reset();
                        searchRepairHist(data);
                    }
                });
            }


            function searchRepairHist(returnSeq) {
                getGridDataForm("/rsc/getEqpRepairHist.lims", "SearchFrm", eqpmnRepairHistGrid, function() {
                    if (returnSeq)
                        gridSelectRow(eqpmnRepairHistGrid, "eqpmnRepairHistSeqno", returnSeq);
                });
            }


            function reset() {
                pageReset(["EqpmnRepairMForm"], null, [dropZoneArea],
                    function() {
                        dateTimePickerCalendar(["repairBeginDt"], true, ["DD",0], ["DD",0]);
                        $("#btnEqpmnPop").show();
                        $("#btnDelete").hide();
                    }
                );
            }


            function doSearch(e){
                searchRepairHist();
            }


        </script>

    </tiles:putAttribute>
</tiles:insertDefinition>
