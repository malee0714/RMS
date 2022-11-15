<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">품질보증 결재</tiles:putAttribute>
<tiles:putAttribute name="body">

<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>결재목록</h2>
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
                    <th>결재종류</th>
                    <td><select name="sanctnKndCode"></select></td>

                    <th>제목</th>
                    <td><input type="text" name="sj" class="schClass"></td>

                    <th>결재상신자</th>
                    <td><input type="text" name="sanctnRecommanNm" class="schClass"></td>

                    <th>결재상신일자</th>
                    <td>
                        <input type="text" name="sanctnRecomBeginDte" class="dateChk wd6p schClass" style="min-width:6em;"> 
                        ~
                        <input type="text" name="sanctnRecomEndDte" class="dateChk wd6p schClass" style="min-width:6em;">
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <div class="subCon1">
        <div style="height: 26px; display: inline-block;">
            <div class="btnWrap mgT15">
                <button id="btnSanctn" class="save">결재</button>
                <button id="btnReturn" class="save">반려</button>
                
                <button id="btnDialogReturn" style="display: none">반려</button>
                <button id="btnDialogSanctn" style="display: none">결재</button>
            </div>
        </div>
    </div>
    <div class="subCon2">
        <div id="sanctnGrid" style="height:600px;"></div>
    </div>
</div>
    
</tiles:putAttribute>
<tiles:putAttribute name="script">

<script>
    
    var AUIGrid = AUIGrid;
    var lang = ${msg}; // 기본언어
    var searchFormEl = document.querySelector('#searchForm');
    var sanctnGrid = '#sanctnGrid';
    $(document).ready(function () {
        setSelectBox();
        buildGrid();
        renderingDialog();
        setButtonEvent();
    });

    function buildGrid(){
        
        var col = [];
        auigridCol(col);
        
        col
                .addColumnCustom("sanctnKndCodeNm", "결재종류")
                .addColumnCustom("sj", "제목")
                .addColumnCustom("sanctnRecomDte", "결재상신일")
                .addColumnCustom("sanctnRecommanNm", "결재상신자")
        
        createAUIGrid(col, sanctnGrid, {showRowAllCheckBox: true, showRowCheckColumn : true});
        gridBindEvent();
    }

    function gridBindEvent(){
        AUIGrid.bind(sanctnGrid, "cellDoubleClick", function(event) {
            
            if (!!!event.item.cn) {
                warn('결재 상세 내용이 없습니다.');
                return;
            }
            
            document.querySelector('#btnDialogSanctn').click();
        });
    }

    function setSelectBox(){
        datePickerCalendar(["sanctnRecomBeginDte", "sanctnRecomEndDte"], true, ["YY",-1], ["DD",0]);
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'sanctnKndCode', queryParam : { 'upperCmmnCode': 'CM05' }, selectFlag : true});
    }

    function getSanctnList(){
        getGridDataForm('/qa/getSanctn.lims', searchFormEl.id, sanctnGrid);
    }
    
    function renderingDialog(){
        dialogQaSanctn({
            btnId : 'btnDialogSanctn',
            dialogId : 'sanctnConfirmDialog',
            parentGridId : sanctnGrid,
            functions : {
                init : getSanctnList
            }
        });

        dialogRtnSanctn({
            btnId : 'btnDialogReturn',
            dialogId : 'sanctnReturnDialog',
            parentGridId : sanctnGrid,
            type : 'grid',
            functions : {
                callback: function (res) {
                    
                    var checkedList = AUIGrid.getCheckedRowItemsAll(sanctnGrid).map(function (item) {
                        item.rtnResn = res.rtnResn
                        return item;
                    });
                    
                    customAjax({
                        url : '/qa/return/list.lims',
                        data : checkedList
                    }).then(function (res, status) {
                        if (status === 'success') {
                            alert('반려 되었습니다.');
                            getSanctnList();
                        }
                    });
                }
            }
        });
    }
    
    function setButtonEvent() {
        document.querySelector('#btnSanctn').addEventListener('click', function () {
            var checkedList = AUIGrid.getCheckedRowItemsAll(sanctnGrid);
            if (checkedList.length === 0) {
                warn('결재할 목록을 체크해 주세요.');
                return false;
            }

            customAjax({
                url: '/qa/confirm/list.lims',
                data: checkedList
            }).then(function (res, status) {
                if (status === 'success') {
                    alert('결재 되었습니다.');
                    getSanctnList();
                }
            });
        });
        
        document.querySelector('#btnReturn').addEventListener('click', function () {
            var checkedList = AUIGrid.getCheckedRowItemsAll(sanctnGrid);
            if (checkedList.length === 0) {
                warn('반려할 목록을 체크해 주세요.');
                return false;
            }
            
            document.querySelector('#btnDialogReturn').click();
        });
    }
    
    function doSearch(){
        getSanctnList();
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>
