<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Lot Trace 입력</tiles:putAttribute>
    <tiles:putAttribute name="body">
    <div class="subContent" style=height:auto;>
        <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>의뢰 목록</h2>
                <div class="btnWrap">
                    <button id="btnReqSave" class="save">저장</button>
                    <button type="button" id="btnSearch" class="search" onclick="doSearch()">${msg.C100000767}</button> <!-- 조회 -->
                </div>
            <form action="javascript:;" id="searchFrm" name="searchFrm">
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
                        <th>의뢰번호</th>
                        <td>
                            <input type="text" name="reqestNoSch" id="reqestNoSch" class="schClass">
                        </td>
                        <th>의뢰부서</th>
                        <td>
                            <select class="wd100p schClass" id="reqestDeptCodeSch" name="reqestDeptCodeSch"></select>
                        </td>
                        <th>검사유형</th>
                        <td>
                            <select class="wd100p schClass" id="inspctTyCodeSch" name="inspctTyCodeSch">
                               <option value="SY07000003"> 제품 </option>
                            </select>
                        </td>
                        <th>의뢰일자</th>
                        <td>
                            <input type="text" id="reqBeginDte" name="reqBeginDte" class="dateChk wd6p" style="min-width: 6em;" autocomplete="off">~
                            <input type="text" id="reqEndDte" name="reqEndDte" class="dateChk wd6p" style="min-width: 6em;"autocomplete="off">
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <div class="subCon2 mgT15">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="reqTraceGrid" style="width: 100%; height: 300px; margin: 0 auto;" class="mgT15 grid"></div>
        </div>

        <div class="subCon1 mgT15">
            <h2><i class="fi-rr-apps"></i>Lot Trace</h2>
                <div class="btnWrap">
                    <button id="btnCreateExcelSample" class="save">Excel Sample 출력</button> <!-- Excel Sample 출력 -->
                    <button id="lotTraceAdd" class="btn5"><img src="/assets/image/plusBtn.png"></button>
                    <button id="lotTraceDel" class="delete"><img src="/assets/image/minusBtn.png"></button>
                    <button id="lotTraceOrdr" class="btn5"><img src="/assets/image/updownBtn.png"></button>
                    <button id="btnTraceSave" class="save">저장</button> <!-- 저장 -->
                </div>
        </div>

        <div class="subCon2 mgT15">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="lotTraceGrid" style="width: 100%; height: 300px; margin: 0 auto;" class="mgT15 grid"></div>
        </div>
        <input type="hidden" id="lotNoSeqno" name="lotNoSeqno">
        <input type="hidden" id="reqestSeqno" name="reqestSeqno">
    </div>
    </tiles:putAttribute>
    <tiles:putAttribute name="script">

<script type="text/javascript">
 var reqTraceGrid = 'reqTraceGrid'; // lotTraceGrid
 var lotTraceGrid = 'lotTraceGrid'; // lotTraceGrid
 var saveKey = '';
 var sessionObj = {
     bplcCode : "${UserMVo.bestInspctInsttCode}",
     deptCode : "${UserMVo.deptCode}"
 };
 var lang = ${ msg }; // 기본언어
 var clickCntByChangeOrdrE = 1;
 var commonGridProp = {
     editable : false,
     enableDrag : false,
     enableMultipleDrag : true,
     enableDragByCellDrag : true,
     enableDrop : true
 };

 var enableDropProp = {
     editable : false,
     enableDrag : true,
     enableMultipleDrag : true,
     enableDragByCellDrag : true,
     enableDrop : true
 };

 $(function(){
     //그리드 생성
     setLotTraceGrid();

     //팝업
     popUp();

     //콤보 생성
     setCombo();

     //버튼 이벤트
     setButtonEvent();

 });


 function setLotTraceGrid(){
     var reqTraceGridCol = [];
     auigridCol(reqTraceGridCol);
     reqTraceGridCol.addColumnCustom("reqestNo", "의뢰번호","*",true)
     reqTraceGridCol.addColumnCustom("lotNo", "Lot No","*",true,true)
     reqTraceGridCol.addColumnCustom("sploreNm", "시료정보","*",true)
     reqTraceGridCol.addColumnCustom("reqestDeptCode", "의뢰부서","*",false)
     reqTraceGridCol.addColumnCustom("reqestDeptNm", "의뢰부서","*",true)
     reqTraceGridCol.addColumnCustom("clientId", "의뢰자","*",false)
     reqTraceGridCol.addColumnCustom("clientNm", "의뢰자","*",true)
     reqTraceGridCol.addColumnCustom("reqestDte", "의뢰일자","*",true)
     reqTraceGridCol.addColumnCustom("inspctTyCode", "검사유형","*",false)
     reqTraceGridCol.addColumnCustom("inspctTyCodeNm", "검사유형","*",true)
     reqTraceGridCol.addColumnCustom("custlabSeqno", "분석실","*",false)
     reqTraceGridCol.addColumnCustom("custlabNm", "분석실","*",true)
     reqTraceGridCol.addColumnCustom("prductSeCode", "제품구분","*",false)
     reqTraceGridCol.addColumnCustom("prductSeCodeNm", "제품구분","*",true)
     reqTraceGridCol.addColumnCustom("mtrilNm", "제품명","*",true)
     reqTraceGridCol.addColumnCustom("mnfcturDte", "제조일자","*",true)
     reqTraceGridCol.addColumnCustom("rm", "특이사항","*",true)
     reqTraceGrid = createAUIGrid(reqTraceGridCol, reqTraceGrid);

     var lotTraceGridCol = [];
     auigridCol(lotTraceGridCol);
     lotTraceGridCol.addColumnCustom("reqestNo", "의뢰번호","*",true)
     lotTraceGridCol.addColumnCustom("reqestDeptNm", "의뢰부서","*",true)
     lotTraceGridCol.addColumnCustom("clientNm", "의뢰자","*",true)
     lotTraceGridCol.addColumnCustom("reqestDte", "의뢰일자","*",true)
     lotTraceGridCol.addColumnCustom("inspctTyNm", "검사유형","*",true)
     lotTraceGridCol.addColumnCustom("custlabNm", "분석실","*",true)
     lotTraceGridCol.addColumnCustom("prductTyNm", "제품구분","*",true)
     lotTraceGridCol.addColumnCustom("mtrilNm", "제품명","*",true)
     lotTraceGridCol.addColumnCustom("mnfcturDte", "제조일자","*",true)
     lotTraceGridCol.addColumnCustom("sploreNm", "시료정보","*",true)
     lotTraceGridCol.addColumnCustom("rm", "특이사항","*",true)
     lotTraceGrid = createAUIGrid(lotTraceGridCol, lotTraceGrid,commonGridProp);

     gridBindEvent();
 }

 function gridBindEvent(){
     AUIGrid.bind(reqTraceGrid, "ready", function() {
         gridColResize(reqTraceGrid, "2");
         if ( !!saveKey ){
             gridSelectRow(reqTraceGrid, "reqestSeqno", [saveKey]);
         }
     });

     AUIGrid.bind(reqTraceGrid, "cellDoubleClick", function(event) {
         $('#lotNoSeqno').val(event.item.lotNoSeqno);
         $('#reqestSeqno').val(event.item.reqestSeqno);
         $('#mtrilSeqno').val(event.item.mtrilSeqno);
         traceDetail(event.item);
         init();
     });

     AUIGrid.bind(lotTraceGrid, "cellClick", function(event) {
         init();
     });
 }

 function setCombo(){
     ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'reqestDeptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true, null, null);

     datePickerCalendar(["reqBeginDte", "reqEndDte"], true, ["MM",-1], ["DD",0]);
 }

 function popUp() {
     lotTracedialog('lotTraceAdd',"requestLotTraceDialog", 'reqTraceGrid', sessionObj,function(item){
         if(item)
             AUIGrid.addRow(lotTraceGrid, item, 'last');
     },function() {
         var selectedItems = AUIGrid.getSelectedItems(reqTraceGrid);

         if(selectedItems.length == 0){
             alert('의뢰목록을 선택해주세요.');
             return false;
         }
         if(!$('#lotNoSeqno').val()){
             alert('Lot No를 입력해주세요.');
             return false;
         }

     },true);
 }

 function setButtonEvent() {
     //조회
     $('#btnSearch').click(function() {
         searchLotTraceList();
     })

     //샘플 엑셀파일 생성
     $('#btnCreateExcelSample').click(function() {
         var lotTraceList = AUIGrid.getGridData(lotTraceGrid);
         if (lotTraceList.length == 0)
             return;

         var prdctLotItem = AUIGrid.getRowsByValue(reqTraceGrid, "reqestSeqno", lotTraceList[0].mainReqestSeqno);
         prdctLotItem[0].upperSortOrdr = 1;
         prdctLotItem[0].lwprtSortOrdr = 0;

         for (var i = 0; i < lotTraceList.length; i++) {
             lotTraceList[i].upperSortOrdr = 1;
             lotTraceList[i].lwprtSortOrdr = i+1;
         }

         customAjax({
             url: "/test/createExcelSample.lims",
             data: prdctLotItem.concat(lotTraceList),
             successFunc: function(data) {
                 if (data) {
                     //생성된 성적서 파일정보를 리턴받아 json형태의 문자열로 담아서 엑셀 다운로드 요청에 파라미터로 날려줌
                     var filePath = data.filePath.replaceAll("\\", "/");
                     var params = "{\"fileName\" : \""+data.fileName+"\", \"fileType\" : \""+data.fileType+"\", \"filePath\" : \""+filePath+"\"}";
                     window.location.href = "/test/excelDownload.lims?params="+encodeURIComponent(params);
                 }
             }
         });
     });

     // 의뢰목록 저장
     $("#btnReqSave").click(function() {
         var reqTraceUpdedRowItems = AUIGrid.getEditedRowItems(reqTraceGrid); // 수정(LOT NO입력)한 아이템
         if(reqTraceUpdedRowItems.length > 0){
             saveReqTrace(reqTraceUpdedRowItems);
         } else {
             alert('Lot No를 입력 후 저장해주세요.')
         }
     })

     // 행삭제
     $("#lotTraceDel").click(function() {
         var selectedItems = AUIGrid.getSelectedItems(lotTraceGrid);
         if(selectedItems.length > 0){
             AUIGrid.removeRow(lotTraceGrid, "selectedIndex");
             delLotTrace();
         } else {
             alert('Lot Trace를 선택해주세요.')
         }

     })

     //정렬
     $("#lotTraceOrdr").click(function() {
         clickCntByChangeOrdrE++;
         if (clickCntByChangeOrdrE % 2 == 0) {
             AUIGrid.setProp(lotTraceGrid, enableDropProp);
             alert("${msg.C100000548}"); /* 순서변경 가능상태 입니다. */
         } else {
             AUIGrid.setProp(lotTraceGrid, commonGridProp);
             alert("${msg.C100000549}"); /* 순서변경 불가능상태 입니다. */
         }
     });

     // LotTrace 저장
     $("#btnTraceSave").click(function() {
         var lotTraceGridRowItems = AUIGrid.getGridData(lotTraceGrid); // 수정(LOT NO입력)한 아이템
         if(lotTraceGridRowItems.length > 0){
             saveTrace(lotTraceGridRowItems);
         } else {
             alert('Lot Trace를 선택해주세요.')
         }
     })
 }


 //의뢰 목록 조회
 function searchLotTraceList() {
     getGridDataForm('/test/getLotTraceList.lims', "searchFrm", reqTraceGrid);
 }
 //의뢰 LotNo저장
 function saveReqTrace(reqTraceUpdedRowItems) {
     var url = "<c:url value='/test/saveReqTrace.lims'/>";
     var param = reqTraceUpdedRowItems;
     customAjax({"url":url,"data":param,"successFunc":function(data){
             if (!!data) {
                 success("${msg.C100000762}"); /* 저장 되었습니다. */
                 saveKey = data;
                 searchLotTraceList();
             }
         }
     });
 }
 //lot Trace 조회
 function lotTraceList() {
     getGridDataForm('/test/getLotTraceList.lims', "searchFrm", reqTraceGrid);
 }

 //lotTrace 저장
 function saveTrace(lotTraceGridRowItems) {
     customAjax({
         url: "/test/saveTrace.lims",
         data: lotTraceGridRowItems,
         successFunc: function(data) {
             if (!!data) {
                 success("${msg.C100000762}"); /* 저장되었습니다. */
                 reset();
                 searchLotTraceList();
             }
         }
     });
 }

 //trace 조회
 function traceDetail(item) {
     getGridDataParam("/test/getTraceDetail.lims", {reqestSeqno : item.reqestSeqno}, lotTraceGrid);
 }

//trace 삭제
 function delLotTrace() {
     var url = "<c:url value='/test/delLotTrace.lims'/>";
     var del = AUIGrid.getRemovedItems(lotTraceGrid)
     customAjax({"url":url,"data":del,"successFunc":function(data){
             if (data > 0) {
                 success("${msg.C100000462}"); /* 삭제되었습니다. */
                 reset();
                 lotTraceList();
             }
         }
     });
 }
 function reset() {
     AUIGrid.clearGridData(lotTraceGrid);
 }
 function init() {
     saveKey = '';
 }

function doSearch(){
    searchLotTraceList();
    saveKey = '';
}

</script>
    </tiles:putAttribute>
</tiles:insertDefinition>
