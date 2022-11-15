<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
        <div class="subContent">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>${msg.C100001290}</h2> <!-- 장비분류별 의뢰건수 조회 -->
                <div class="btnWrap">
                    <button id="btnSelect" type="button" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
                </div>
                <form id="searchFrm">
                    <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
                        <colgroup>
                            <col style="width:9%"></col>
                            <col style="width:14%"></col>
                            <col style="width:9%"></col>
                            <col style="width:14%"></col>
                            <col style="width:9%"></col>
                            <col style="width:22%"></col>
                            <col style="width:9%"></col>
                            <col style="width:14%"></col>
                        </colgroup>
                        <tr>
                            <th>${msg.C100000432}</th> <!-- 사업장 -->
                            <td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
                            <th>${msg.C100000607}</th> <!-- 연도 -->
                            <td><select id="yearSch" name="yearSch"></select></td>
                            <th>${msg.C100001291}</th> <!-- 집계 대상 -->
                            <td>
                                <label><input type="radio" id="reAnalsAt_N" name="reAnalsAt" value="N" checked>${msg.C100001292}</label> <!-- 전체 의뢰 대상 -->
                                <label><input type="radio" id="reAnalsAt_Y" name="reAnalsAt" value="Y">${msg.C100001293}</label> <!-- 재분석 의뢰 대상 -->
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="subCon2 mgT20 wd100p"s>
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div class="wd100p mgT10" style="display:inline-block; order:1;">
                    <div id="eqpmnClCntGrid" class="wd100p" style="height:505px;"></div>
                </div>
            </div>
        </div>
    </tiles:putAttribute>

    <tiles:putAttribute name="script">
        <script>

            var eqpmnClCntGrid = 'eqpmnClCntGrid';

            $(document).ready(function() {
                setCombo();

                setGrid();

                buttonEvent();
            });

            function setCombo() {
                ajaxJsonComboBox('/wrk/getBestComboList.lims', 'bplcCodeSch', null, false, null, '${UserMVo.bestInspctInsttCode}');
                setYear('yearSch', new Date().getFullYear(), 2019, 10);
            }

            function setGrid() {
                var col = [];

                var rowProps = {
                    enableCellMerge : true,
                    cellMerge : true,
                    cellMergePolicy : "withNull",
                    rowSelectionWithMerge : true
                };

                var formatPros = {
                    dataType: "numeric",
                    formatString: "#,##0"
                };

                auigridCol(col);
                col.addColumnCustom("bplcNm", "${msg.C100000432}", "*", true, false, rowProps)
                col.addColumnCustom("eqpmnClNm", "${msg.C100000745}", "*", true)
                col.addColumnCustom("janCnt", "1${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("febCnt", "2${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("marCnt", "3${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("aprCnt", "4${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("mayCnt", "5${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("junCnt", "6${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("julCnt", "7${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("augCnt", "8${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("sepCnt", "9${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("octCnt", "10${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("novCnt", "11${msg.C100000006}", "*", true, false, formatPros)
                col.addColumnCustom("decCnt", "12${msg.C100000006}", "*", true, false, formatPros);

                eqpmnClCntGrid = createAUIGrid(col, eqpmnClCntGrid);
            }

            function buttonEvent() {
                $('#btnSelect').click(function () {
                    searchReqCntByEqpmnCl();
                });
            }

            function searchReqCntByEqpmnCl() {
                getGridDataForm('/src/getEqpClReqCntByMnth.lims', 'searchFrm', eqpmnClCntGrid);
            }

        </script>
    </tiles:putAttribute>
</tiles:insertDefinition>
