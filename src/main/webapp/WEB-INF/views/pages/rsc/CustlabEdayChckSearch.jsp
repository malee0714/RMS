<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
<tiles:putAttribute name="body">
    <!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>분석실 목록</h2>
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
                    <th>분석실</th>
                    <td><select name="custlabSeqno"></select></td>
                    
                    <th>점검기간</th>
                    <td style="text-align:left;">
                        <input type="text" id="startChckDte" name="startChckDte" class="dateChk wd6p schClass" style="min-width:6em;" required> 
                        ~ 
                        <input type="text" id="endChckDte" name="endChckDte" class="dateChk wd6p schClass" style="min-width:6em;" required>
                    </td>
                    
                    <th>점검결과</th>
                    <td><select name="jdgmntWordCode"></select></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </form>
    </div>
    
    <div class="subCon2">
        <div id="searchGrid" style="height: 600px"></div>
    </div>
</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
    var lang = ${msg}; // 기본언어
        
    $(function () {
        setSelectBox();
        buildGrid();
        setButtonEvent();
    });
    
    var searchGrid = "#searchGrid";
    function buildGrid() {
        var col = [];
        
        auigridCol(col);
        
        col
        .addColumnCustom("chckDte", "점검일자")
        .addColumnCustom("expriemNm", "${msg.C100000560}") // 시험항목명
        .addColumnCustom("resultValue", "결과값")
        .addColumnCustom("jdgmntWordCodeNm", "판정")
        .addColumnCustom("rm", "비고")
        
        createAUIGrid(col, searchGrid);
    }

    //버튼 클릭 이벤트 
    function setButtonEvent() {
        document.querySelector('#btnSearch').addEventListener('click', function (e) {
            search();
        });
    }

    function setSelectBox() {
        datePickerCalendar(["startChckDte", "endChckDte"], true, ["MM",-1], ["DD",0]);
        ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', queryParam : {"upperCmmnCode" : "IM05"}, name : 'jdgmntWordCode', selectFlag : true});
    }
    
    function search() {
        getGridDataParam('/rsc/getCustlabEdayCheckResultSearchList.lims', document.querySelector('#searchForm').toObject(), searchGrid);
    }
    
    //엔터키 이벤트
    function doSearch(e) {
        search();
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>