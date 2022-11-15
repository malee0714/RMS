<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">장비 일상점검 결과조회</tiles:putAttribute>
    <tiles:putAttribute name="body">

        <div class="subContent">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>장비 목록</h2> <!-- 장비 목록 -->
                <div class="btnWrap">
                    <button type="button" id="btnSelect" class="search btn3">${msg.C100000767}</button> <!-- 조회 -->
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
                            <th>분석실</th> <!-- 분석실 -->
                            <td><select id="schCustlabSeqno" name="schCustlabSeqno"></select></td>

                            <th>${msg.C100000742}</th> <!-- 장비 명 -->
                            <td><input type="text" id="schEqpmnNm" name="schEqpmnNm" class="wd100p schClass" maxlength="200"></td>

                            <th>점검 기간</th> <!-- 점검 기간 -->
                            <td>
                                <input type="text" id="schChckBeginDte" name="schChckBeginDte" class="dateChk wd6p schClass" style="min-width:6em;">
                                ~
                                <input type="text" id="schChckEndDte" name="schChckEndDte" class="dateChk wd6p schClass" style="min-width:6em;">
                            </td>

                            <th>점검 결과 </th> <!-- 점검 결과 -->
                            <td><select id="schJdgmntWordCode" name="schJdgmntWordCode"></select></td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="subCon2">
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div id="EqpmnEdayChckResultGrid" class="mgT15 mgB15" style="width:100%; height:300px; margin:0 auto;"></div>
            </div>
        </div>

    </tiles:putAttribute>
    <tiles:putAttribute name="script">

        <script>

            var eqpmnEdayChckResultGrid = "EqpmnEdayChckResultGrid";


            $(function () {

                setCombo();

                buildGrid();

                buttonEvent();

            });


            function setCombo() {
                ajaxJsonComboBox("/com/getCustLabCombo.lims", "schCustlabSeqno", null, true);
                ajaxJsonComboBox("/com/getCmmnCode.lims", "schJdgmntWordCode", { upperCmmnCode : "IM05" }, true);
                datePickerCalendar(["schChckBeginDte", "schChckEndDte"], true, ["MM",-1], ["DD",0]);
            }


            function buildGrid() {

                var col = [];
                auigridCol(col);

                col
                .addColumnCustom("chckDte", "${msg.C100000785}", "*", true)
                .addColumnCustom("expriemNm", "${msg.C100000560}", "*", true)
                .addColumnCustom("resultValue", "${msg.C100000150}", "*", true)
                .addColumnCustom("jdgmntWordNm", "${msg.C100000918}", "*", true)
                .addColumnCustom("rm", "${msg.C100000425}", "*", true);

                var eqpEdayChkResultProp = {
                    editable: false,
                    selectionMode : "multipleCells"
                };

                eqpmnEdayChckResultGrid = createAUIGrid(col, eqpmnEdayChckResultGrid, eqpEdayChkResultProp);
            }


            function buttonEvent() {
                $("#btnSelect").click(function () {
                    searchEqpEdayChkResult();
                });
            }


            function searchEqpEdayChkResult() {
                getGridDataForm("/rsc/getEqpEdayChckResult.lims", "SearchFrm", eqpmnEdayChckResultGrid);
            }


            function doSearch(e) {
                searchEqpEdayChkResult();
            }


        </script>

    </tiles:putAttribute>
</tiles:insertDefinition>
