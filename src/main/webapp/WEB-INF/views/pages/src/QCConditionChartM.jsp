<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
    <tiles:putAttribute name="body">

        <div class="subContent">
            <form id="Qcconditionfrom" name="Qcconditionfrom"  onsubmit="return false">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>통계 기간</h2> <!-- 공조기 - 수치 차트-->
            </div>
            </form>

            <div class="subCon2 mgT30">
                <h2>${msg.C000000022}</h2> <!-- 차트 상세 정보 -->
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div class="fL wd100p mgT15" style="height:150px;">
                    <div id="chValueList" class="fL wd100p" style="height:100%;"></div>
                </div>
                <h2>${msg.C000000022}</h2> <!-- 차트 상세 정보 -->
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div class="fL wd100p mgT15" style="height:150px;">
                    <div id="chValueList2" class="fL wd100p" style="height:100%;"></div>
                </div>
                <h2>${msg.C000000022}</h2> <!-- 차트 상세 정보 -->
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div class="fL wd100p mgT15" style="height:150px;">
                    <div id="chValueList3" class="fL wd100p" style="height:100%;"></div>
                </div>
            </div>

        </div>

    </tiles:putAttribute>
    <tiles:putAttribute name="script">
        <script>
            const url= new URL(window.location.href);
            const urlParams = url.searchParams;
            var date = urlParams.get('date');
            var dateType = urlParams.get('dateType');
            var chValueList = "chValueList";
            var chValueList2 = "chValueList2";
            var chValueList3 = "chValueList3";
            $(function() {
                init();
                setReceiptListGrid();
                searchInspctList();
            });
            function init()
            {
                $("#Qcconditionfrom h2").html("<i class='fi-rr-apps'></i>" + date);
            }
            function setReceiptListGrid(){
                var col = [];

                auigridCol(col);

                col.addColumnCustom("prop", "구분", "*" ,true); /* 구분 */

                var cusPros = {
                    editable : false, // 편집 가능 여부 (기본값 : false)
                    selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
                    enableCellMerge : true,
                    showRowNumColumn : false
                }

                //auiGrid 생성
                chValueList = createAUIGrid(col, "chValueList", cusPros);
                chValueList2 = createAUIGrid(col, "chValueList2", cusPros);
                chValueList3 = createAUIGrid(col, "chValueList3", cusPros);


                // 그리드 칼럼 리사이즈
                AUIGrid.bind(chValueList, "ready", function(event) {
                    gridColResize([chValueList],"2");	// 1, 2가 있으니 화면에 맞게 적용
                });
            }
            function searchInspctList(){
                customAjax({url:"/src/getQcconditionInspctList.lims", data:{shrReqestBetweenDte:date,mnfcturDteSch:dateType}, successFunc :function(inspct){
                    if(inspct.length > 0){
                        setGridData(chValueList, inspct,2)
                    }
                }});
                customAjax({url:"/src/getQcconditionPrductList.lims", data:{shrReqestBetweenDte:date,mnfcturDteSch:dateType}, successFunc :function(prduct) {

                        if (prduct.length > 0) {
                            setGridData(chValueList2, prduct,3)
                        }
                    }
                });
                    customAjax({url:"/src/getQcconditionMtrilList.lims", data:{shrReqestBetweenDte:date,mnfcturDteSch:dateType}, successFunc :function(mtril) {
                            if (mtril.length > 0) {
                                setGridData(chValueList3, mtril,4)
                            }
                    }
                });
            }
            function setGridData(grid,data,type) {
                AUIGrid.destroy(grid);
                setReceiptListGrid();
                AUIGrid.addRow(grid, { "prop" : "분석 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "부적합 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "부적합 률%"}, "last");
                //AUIGrid.addRow(grid, { "prop" : "부적합 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "재분석 률%"}, "last");

                var itemCnt = {};
                var itemUncnt = {};
                var itemUncntp = {};
                var itemRereqestNum = {};
                var itemRereqestNumP = {};
                for(var i=0;i<data.length;i++) {
                    switch (type) {
                        case 1:
                            var dataFieldData = data[i].resultRegistDte;
                            break;
                        case 2:
                            var dataFieldData = data[i].cmmnCodeNm;
                            break;
                        case 3:dataFieldData = data[i].cmmnCodeNm;
                            break;
                        case 4:dataFieldData = data[i].mtrilNm;
                            break;
                        default :
                            break;
                    }
                    AUIGrid.addColumn(grid, {dataField: dataFieldData}, "last");
                    itemCnt[dataFieldData]= data[i].cnt;
                    itemUncnt[dataFieldData]= data[i].uncnt;
                    itemUncntp[dataFieldData]= ((data[i].uncnt/data[i].cnt)*100).toFixed(2);
                    itemRereqestNum[dataFieldData]= data[i].rereqestNum;
                    itemRereqestNumP[dataFieldData]= ((data[i].rereqestNum/data[i].cnt)*100).toFixed(2);
                }


                AUIGrid.updateRow(grid, itemCnt, 0);
                AUIGrid.updateRow(grid, itemUncnt, 1);
                AUIGrid.updateRow(grid, itemUncntp, 2);
                //AUIGrid.updateRow(grid, itemRereqestNum, 3);
                AUIGrid.updateRow(grid, itemRereqestNumP, 3);
            }

        </script>

    </tiles:putAttribute>
</tiles:insertDefinition>
