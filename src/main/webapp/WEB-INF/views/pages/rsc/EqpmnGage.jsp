<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
   <tiles:putAttribute name="title">장비 Gage R&R</tiles:putAttribute>
   <tiles:putAttribute name="body">

      <div class="subContent">
         <div class="subCon1">
            <h2><i class="fi-rr-apps"></i>장비 Gage R&R 목록</h2> <!-- 장비 Gage R&R 목록 -->
            <div class="btnWrap">
               <button type="button" id="btnSearch" class="search btn3">${msg.C100000767}</button> <!-- 조회 -->
            </div>

            <form id="SearchForm">
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
                     <th>장비 분류</th> <!-- 장비 분류 -->
                     <td><select id="schEqpmnClCode" name="schEqpmnClCode"></select></td>

                     <th>장비 관리 번호</th> <!-- 장비 관리 번호 -->
                     <td><select id="schEqpmnManageNo" name="schEqpmnManageNo" style="width: 100%"></select></td>

                     <th>${msg.C100000742}</th> <!-- 장비 명 -->
                     <td><input type="text" id="schEqpmnNm" name="schEqpmnNm" class="schClass" maxlength="200"></td>

                     <th>${msg.C100000292}</th> <!-- 등록 일자 -->
                     <td>
                        <input type="text" id="schRegistBeginDte" name="schRegistBeginDte" class="dateChk wd6p schClass" style="min-width: 6em;">
                        ~
                        <input type="text" id="schRegistEndDte" name="schRegistEndDte" class="dateChk wd6p schClass" style="min-width: 6em;">
                     </td>
                  </tr>
               </table>
            </form>
         </div>
         <div class="subCon2">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="EqpmnGageGrid" class="mgT15" style="height:300px"></div>
         </div>

         <form id="EqpmnGageForm">
            <div class="subCon1 mgT20" id="detail">
               <h2><i class="fi-rr-apps"></i>장비 Gage R&R 정보</h2> <!-- 장비 Gage R&R 정보 -->
               <div class="btnWrap">
                  <button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                  <button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                  <button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
               </div>
               <table cellpadding="0" cellspacing="0" width="100%" class="subTable1 mgT5">
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
                     <td><input type="text" id="eqpmnClNm" readonly></td>

                     <th>${msg.C100000739}</th> <!-- 장비 관리 번호 -->
                     <td><input type="text" id="eqpmnManageNo" readonly></td>

                     <th class="necessary">${msg.C100000742}</th> <!-- 장비 명 -->
                     <td>
                        <input type="text" id="eqpmnNm" class="wd80p" required readonly>
                        <button type="button" id="btnEqpmnPopOpen" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                     </td>

                     <th class="necessary">${msg.C100000129}</th> <!-- 검교정 주기 -->
                     <td>
                        <input type="text" id="inspctCrrctCycle" name="inspctCrrctCycle" class="numChk wd56p" required readonly>
                        <select id="cycleCode" name="cycleCode" style="min-width:4em; width:40%" required disabled></select>
                     </td>
                  </tr>

                  <tr>
                     <th class="necessary">${msg.C100000295}</th>  <!-- 등록자 -->
                     <td>
                        <input type="text" id="registerNm" class="wd62p" value="${UserMVo.userNm}" readonly required>
                        <button type="button" id="btnRegisterSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                        <button type="button" id="btnRegisterReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
                     </td>

                     <th class="necessary">등록 일자</th> <!-- 등록 일자 -->
                     <td><input type="text" id="registDte" name="registDte" class="wd100p dateChk" required></td>
                     <td colspan="4"></td>
                  </tr>

                  <tr>
                     <th>${msg.C100000425}</th> <!-- 비고 -->
                     <td colspan="13">
                        <textarea id="rm" name="rm" rows="1" maxlength="4000" class="wd100p"></textarea>
                     </td>
                  </tr>

                  <tr>
                     <th>${msg.C100000860}</th> <!-- 첨부파일 -->
                     <td colspan="13">
                        <!-- 파일첨부영역 -->
                        <div id="dropZoneArea"></div>
                        <input type="text" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width: 10em; display: none">
                        <button type="button" id="btnFileSave" style="display: none"></button>
                     </td>
                  </tr>
               </table>

               <input type="text" id="eqpmnGageRegistSeqno" name="eqpmnGageRegistSeqno" style="display: none">
               <input type="text" id="eqpmnSeqno" name="eqpmnSeqno" style="display: none">
               <input type="text" id="registerId" name="registerId" value="${UserMVo.userId}" style="display: none">
               <input type="text" id="cycleUpdAt" name="cycleUpdAt" style="display:none">
               <input type="text" id="deleteAt" name="deleteAt" value="N" style="display: none">
               <input type="text" id="nextInspctCrrctDte" name="nextInspctCrrctDte" style="display: none">
            </div>
         </form>

         <div style="display: flex">
            <div class="subCon2 wd50p fL mgT25 mgR20">
               <div class="subCon1">
                  <h3>의뢰 목록</h3> <!-- 의뢰 목록 -->
                  <div class="btnWrap">
                     <button id="btnGageReqPop" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행 추가 -->
                     <button id="btnDelGageReq" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행 삭제 -->
                  </div>
               </div>
               <div id="EqpmnGageReqGrid" class="mgT10" style="height:300px;"></div>
            </div>

            <div class="subCon2 wd50p mgT25">
               <div class="subCon1">
                  <h3>시험항목 목록</h3> <!-- 시험항목 목록 -->
               </div>
               <div id="EqpmnGageReqExprGrid" class="mgT10" style="height:300px;"></div>
            </div>
         </div>

         <div class="subCon1 mgT20">
            <h3>Gage R&R 정보입력</h3> <!-- Gage R&R 정보입력 -->
         </div>
         <div class="subCon2">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="EqpmnGageResultGrid" class="mgT10" style="height:300px"></div>
         </div>
      </div>

   </tiles:putAttribute>
   <tiles:putAttribute name="script">

      <script>

         var eqpmnGageGrid = "EqpmnGageGrid";
         var eqpmnGageResultGrid = "EqpmnGageResultGrid";
         var eqpmnGageReqGrid = "EqpmnGageReqGrid";
         var eqpmnGageReqExprGrid = "EqpmnGageReqExprGrid";

         var dropZoneArea;
         var lang = ${msg};
         var sessionObj = {
            bplcCode : "${UserMVo.bestInspctInsttCode}",
            deptCode : "${UserMVo.deptCode}"
         };

         var searchForm = document.getElementById('SearchForm').id;
         var inputForm = document.getElementById('EqpmnGageForm').id;
         var getEl = function(id) {
            return document.getElementById(id);
         }
         var getVal = function(id) {
            return document.getElementById(id).value;
         }
         var setVal = function(id, value) {
            document.getElementById(id).value = value;
         }

         $(function() {
            init();
            setCombo();
            buildGrid();
            auiGridEvent();
            buttonEvent();
         });


         function init() {

            dialogEqpmn("btnEqpmnPopOpen", "eqpmnDialog", function(item) {
               /* GageR&R 신규등록 진행 중 의뢰를 추가한 후에 장비를 변경하는 경우에 대비
                * 의뢰와 장비가 정상매칭 되지 않은 채로 저장되는 것을 방지.
                */
               AUIGrid.clearGridData(eqpmnGageReqGrid);
               AUIGrid.clearGridData(eqpmnGageReqExprGrid);
               AUIGrid.clearGridData(eqpmnGageResultGrid);

               //검교정주기정보 존재유무 검증
               chkExistCrrctCycle(item);
            });

            dialogUser("btnRegisterSearch", "", "registerNmDialog", function(item) {
               getEl('registerNm').value = item.userNm;
               getEl('registerId').value = item.userId;
            });

            dialogReqest("btnGageReqPop", "gageReqDialog", eqpmnGageReqGrid, sessionObj, function(items) {
               for (var item of items) {
                  item.addedAt = 'Y'
               }
               AUIGrid.addRow(eqpmnGageReqGrid, items, "last");

               var seqArr = items.map(function(item) {
                  return item.reqestSeqno;
               });
               loadGageReqExpr(seqArr, "add"); //추가한 의뢰의 시험항목 조회
            });

            datePickerCalendar(["schRegistBeginDte", "schRegistEndDte"], true, ["MM",-1], ["DD",0]);
            datePickerCalendar(["registDte"], false, ["DD",0]);
            dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btnFileSave", maxFiles : 10, lang : lang.C100000867 } );
         }


         function setCombo() {
            ajaxJsonComboBox("/com/getCmmnCode.lims", "schEqpmnClCode", { upperCmmnCode : "RS02" }, true);
            ajaxJsonComboBox("/com/getCmmnCode.lims", "cycleCode", { upperCmmnCode : "SY14" }, true);
            ajaxSelect2Box({
               ajaxUrl: "/com/getEqpManageNoCombo.lims",
               elementId: "schEqpmnManageNo",
               topMsg: true
            });
         }


         function buildGrid() {

            var col = {
               eqpmnGageCol: [],
               eqpmnGageReqCol: [],
               eqpmnGageReqExprCol: [],
               eqpmnResultCol: []
            };

            var eqpmnGageProp = {
               editable : false,
               selectionMode : "multipleCells"
            };

            /********************** Gage R&R 목록 **********************/
            auigridCol(col.eqpmnGageCol);

            col.eqpmnGageCol
            .addColumnCustom("eqpmnClNm", "${msg.C100000745}", "*", true)
            .addColumnCustom("eqpmnGageRegistSeqno", "장비 GAGE 등록 일련번호", "*", false)
            .addColumnCustom("eqpmnSeqno", "${msg.C000001396}", "*", false)
            .addColumnCustom("eqpmnManageNo", "${msg.C100000739}", "*", true)
            .addColumnCustom("eqpmnNm", "${msg.C100000742}", "*", true)
            .addColumnCustom("modlNm", "모델 명", "*", true)
            .addColumnCustom("registerId", "${msg.C100000295}", "*", false)
            .addColumnCustom("registerNm", "${msg.C100000295}", "*", true)
            .addColumnCustom("registDte", "${msg.C100000292}", "*", true)
            .addColumnCustom("rm", "${msg.C100000425}", "*", true)
            .addColumnCustom("deleteAt", "${msg.C000000843}", "*", false)
            .addColumnCustom("atchmnflSeqno", "${msg.C100000860}", "*", false)
            .addColumnCustom("inspctCrrctCycle", "${msg.C100000860}", "*", false)
            .addColumnCustom("cycleCode", "${msg.C100000860}", "*", false);

            eqpmnGageGrid = createAUIGrid(col.eqpmnGageCol, eqpmnGageGrid, eqpmnGageProp);


            /********************** 의뢰 목록 **********************/
            auigridCol(col.eqpmnGageReqCol);

            col.eqpmnGageReqCol
            .addColumnCustom("reqestSeqno", "의뢰 일련번호", "*", false)
            .addColumnCustom("eqpmnGageReqestSeqno", "Gage 의뢰 일련번호", "*", false)
            .addColumnCustom("eqpmnGageRegistSeqno", "Gage 일련번호", "*", false)
            .addColumnCustom("reqestNo", "의뢰 번호", "*", true)
            .addColumnCustom("reqestDte", "의뢰 일자", "*", true)
            .addColumnCustom("deleteAt", "삭제 여부", "*", false);

            var eqpmnGageReqProp = {
               editable: false,
               selectionMode: "multipleCells",
               showRowCheckColumn: true,
               showRowAllCheckBox: true
            };

            eqpmnGageReqGrid = createAUIGrid(col.eqpmnGageReqCol, eqpmnGageReqGrid, eqpmnGageReqProp);


            /********************** 시험항목 목록 **********************/
            auigridCol(col.eqpmnGageReqExprCol);

            col.eqpmnGageReqExprCol
            .addColumnCustom("reqestSeqno", "의뢰 일렬번호", "*", false)
            .addColumnCustom("reqestNo", "의뢰 번호", "*", true)
            .addColumnCustom("expriemSeqno", "시험항목 일렬번호", "*", false)
            .addColumnCustom("expriemNm", "시험항목 명", "*", true)
            .addColumnCustom("resultRegister", "분석자", "*", true)
            .addColumnCustom("resultValue", "결과값", "*", true);

            eqpmnGageReqExprGrid = createAUIGrid(col.eqpmnGageReqExprCol, eqpmnGageReqExprGrid, eqpmnGageProp);


            /********************** Gage R&R 정보입력 **********************/
            var valueDrop = ["Aceeptable", "Condition Acceptance", "UnAceeptable"];
            var jdgmntDrop = [
               { key: "선택", value: "" },
               { key: "합격", value: "RS06000001" },
               { key: "조건합격", value: "RS06000002" },
               { key: "불합격", value: "RS06000003" }
            ];

            auigridCol(col.eqpmnResultCol);

            col.eqpmnResultCol
            .addColumnCustom("eqpmnGageResultSeqno", "장비 GAGE 결과 일련번호", "*", false)
            .addColumnCustom("eqpmnGageRegistSeqno", "장비 GAGE 등록 일련번호", "*", false)
            .addColumnCustom("expriemSeqno", "시험항목 일렬번호", "*", false)
            .addColumnCustom("expriemNm", "시험항목 명", "*", true, false)
            .addColumnCustom("cntrbtdgValue", "%Contribution", "*", true, true)
            .addColumnCustom("rsrchChngeValue", "%Study Variation", "*", true, true)
            .addColumnCustom("guacctoCtgryValue", "Distinct Categories", "*", true, true)
            .addColumnCustom("gageJdgmntCode", "판정", "*", true, false)
            .dropDownListRenderer(["cntrbtdgValue", "rsrchChngeValue", "guacctoCtgryValue"], valueDrop, false)
            .dropDownListRenderer(["gageJdgmntCode"], jdgmntDrop, true);

            var eqpmnGageResultProp = {
               editable: true,
               selectionMode: "multipleCells"
            };

            eqpmnGageResultGrid = createAUIGrid(col.eqpmnResultCol, eqpmnGageResultGrid, eqpmnGageResultProp);

            gridResize([
               eqpmnGageGrid,
               eqpmnGageReqGrid,
               eqpmnGageReqExprGrid,
               eqpmnGageResultGrid
            ]);
         }


         function auiGridEvent() {
            AUIGrid.bind(eqpmnGageGrid, "cellDoubleClick", function(event) {
               getEl('btnDelete').style.display = '';
               detailAutoSet({
                  item : event.item,
                  targetFormArr : [inputForm],
                  ignoreFormArr : [searchForm],
                  successFunc : function() {
                     getEl('btnEqpmnPopOpen').style.display = 'none';
                     nextCrrctDteEvent(
                        getVal('registDte')
                        , Number(getVal('inspctCrrctCycle'))
                        , getVal('cycleCode')
                        , "nextInspctCrrctDte"
                     );
                     dropZoneArea.getFiles(event.item.atchmnflSeqno);

                     //Gage의뢰 조회 -> Gage결과 조회
                     loadGageReq(event.item.eqpmnGageRegistSeqno);
                  }
               });
            });

            AUIGrid.bind(eqpmnGageResultGrid, "cellEditBegin", function(event) {
               if (event.dataField == "gageJdgmntCode")
                  return false;
            });

            AUIGrid.bind(eqpmnGageResultGrid, "cellEditEnd", function(event) {

               var item = AUIGrid.getItemByRowIndex(eqpmnGageResultGrid, event.rowIndex);
               var cntrbtdg = item.cntrbtdgValue;
               var rsrchChnge = item.rsrchChngeValue;
               var guacctoCtgry = item.guacctoCtgryValue;

               //세가지 셀값으로 결과 자동판정
               if (!!cntrbtdg && !!rsrchChnge && !!guacctoCtgry) {
                  resultAutoJdgmnt(event.rowIndex, [cntrbtdg, rsrchChnge, guacctoCtgry]);
               } else {
                  AUIGrid.setCellValue(eqpmnGageResultGrid, event.rowIndex, "gageJdgmntCode", "");
               }
            });
         }


         function buttonEvent() {

            document.querySelector('#btnSearch').addEventListener("click", function() {
               searchEqpmnGage();
            });

            document.querySelector('#btnReset').addEventListener("click", function() {
               reset();
            });

            document.querySelector('#btnSave').addEventListener("click", function() {
               saveValid();
            });

            document.querySelector('#btnDelete').addEventListener("click", function() {
               if (confirm(lang.C100000461)) {
                  setVal('deleteAt', 'Y');
                  saveEqpmnGage();
               }
            });

            document.querySelector('#btnDelGageReq').addEventListener("click", function() {
               var chkedItems = AUIGrid.getCheckedRowItemsAll(eqpmnGageReqGrid);
               if (chkedItems.length == 0)
                  return;
               delGageReq(chkedItems);
            });

            document.querySelector('#btnRegisterReset').addEventListener("click", function() {
               setVal('registerNm','');
               setVal('registerId','');
            });

            document.querySelector('#schEqpmnClCode').addEventListener("change", function() {
               ajaxSelect2Box({
                  ajaxUrl: "/com/getEqpManageNoCombo.lims",
                  elementId: "schEqpmnManageNo",
                  ajaxParam: { schEqpmnClCode : this.value },
                  topMsg: true
               });
            });

            document.querySelector('#registDte').addEventListener("change", function() {
               nextCrrctDteEvent(
                  getVal('registDte')
                  , Number(getVal('inspctCrrctCycle'))
                  , getVal('cycleCode')
                  , "nextInspctCrrctDte"
               );
            });
         }


         function resultAutoJdgmnt(rowIndex, arr) {
            if (arr.indexOf("UnAceeptable") >= 0) {
               AUIGrid.setCellValue(eqpmnGageResultGrid, rowIndex, "gageJdgmntCode", "RS06000003");
            } else if (arr.indexOf("Condition Acceptance") >= 0) {
               AUIGrid.setCellValue(eqpmnGageResultGrid, rowIndex, "gageJdgmntCode", "RS06000002");
            } else {
               AUIGrid.setCellValue(eqpmnGageResultGrid, rowIndex, "gageJdgmntCode", "RS06000001");
            }
         }


         function chkExistCrrctCycle(item) {
            var param = { eqpmnSeqno: item.eqpmnSeqno, inspctCrrctSeCode: "RS24000002" };
            customAjax({
               url: "/rsc/chkExistAtInspctCycle.lims",
               data: param,
               successFunc: function(data) {
                  if (!data) {
                     warn(lang.C100001241); //해당 장비에 등록된 검교정 주기정보가 없습니다. 등록 후 다시 진행해주세요.
                  } else {
                     setVal('inspctCrrctCycle', data.inspctCrrctCycle);
                     setVal('cycleCode', data.cycleCode);
                     setVal('eqpmnSeqno', data.eqpmnSeqno);
                     setVal('eqpmnClNm', data.eqpmnClNm);
                     setVal('eqpmnManageNo', data.eqpmnManageNo);
                     setVal('eqpmnNm', data.eqpmnNm);
                     nextCrrctDteEvent(
                        getVal('registDte')
                        , Number(getVal('inspctCrrctCycle'))
                        , getVal('cycleCode')
                        , "nextInspctCrrctDte"
                     );
                  }
               }
            });
         }


         function delGageReq(items) {
            //DB에 저장된 의뢰를 포함한 삭제 이벤트 -> 데이터 삭제 후 행 제거
            var notAdded = items.filter(function(item) {
               return item.addedAt == undefined
            });
            if (notAdded.length > 0) {
               if (confirm(lang.C100000461)) {
                  customAjax({
                     url: "/rsc/delEqpGageReq.lims",
                     data: notAdded,
                     successFunc: function(data) {
                        if (data == 1) {
                           removeRowReqAndExpr(items);
                           delGageReqResult();
                        } else {
                           err(lang.C100000597);
                        }
                     }
                  });
               }
            //새로 행 추가한 의뢰만 삭제할시 화면에서 행만 제거
            } else {
               removeRowReqAndExpr(items);
               var obj = getResultRowToRemove();
               AUIGrid.removeRow(eqpmnGageResultGrid, obj.index);
            }
         }


         function delGageReqResult() {
            var obj = getResultRowToRemove();
            customAjax({
               url: "/rsc/delEqpGageResult.lims",
               data: obj.item,
               successFunc: function(data) {
                  if (data == 1) {
                     AUIGrid.removeRow(eqpmnGageResultGrid, obj.index);
                     success(lang.C100000462); //삭제되었습니다.
                  } else {
                     err(lang.C100000597);
                  }
               }
            });
         }


         //Gage 의뢰&시험항목 행 제거
         function removeRowReqAndExpr(rows) {
            AUIGrid.removeCheckedRows(eqpmnGageReqGrid);

            //삭제된 의뢰의 시험항목들도 행 삭제
            var seqArr = [];
            for (var row of rows) {
               seqArr.push(row.reqestSeqno);
            }
            var exprRowIndexArr = AUIGrid.getRowIndexesByValue(eqpmnGageReqExprGrid, "reqestSeqno", seqArr);
            AUIGrid.removeRow(eqpmnGageReqExprGrid, exprRowIndexArr);
         }


         //Gage 의뢰결과에서 제거할 행 아이템과 인덱스를 반환
         function getResultRowToRemove() {
            var returnObj = {};
            var itemArr = [];
            var indexArr = [];
            var exprList = AUIGrid.getGridData(eqpmnGageReqExprGrid);
            var resultList = AUIGrid.getGridData(eqpmnGageResultGrid);

            for (var i = 0; i < resultList.length; i++) {
               var cnt = 0;
               for (var j = 0; j < exprList.length; j++) {
                  if (resultList[i].expriemSeqno == exprList[j].expriemSeqno) {
                     cnt++;
                     break;
                  }
               }

               if (cnt == 0) {
                  itemArr.push(resultList[i]);
                  indexArr.push(i);
               }
            }
            returnObj.item = itemArr;
            returnObj.index = indexArr;

            return returnObj;
         }


         function saveValid() {
            if (!saveValidation(inputForm))
               return;

            customAjax({
               url: "/rsc/chkDuplicateRegistDte.lims",
               data: $("#EqpmnGageForm").serializeObject(),
               successFunc: function(data) {
                  if (data > 0) {
                     warn(lang.C100001237); //해당 일자에 동일한 등록 기록이 존재합니다.
                  } else {
                     fileSave();
                  }
               }
            });

         }


         function fileSave() {
            var fileLength = dropZoneArea.getNewFiles().length;
            if (fileLength > 0) {
               getEl('btnFileSave').click();
               dropZoneArea.on("uploadComplete", function(event, fileIdx) {
                  setVal('atchmnflSeqno', fileIdx);
                  saveEqpmnGage();
               });

            } else {
               saveEqpmnGage();
            }
         }


         function saveEqpmnGage() {
            //오늘날짜보와 등록하려는 등록일자를 비교해 주기정보 업데이트 가능여부 구분값을 세팅
            var strToday = new Date().toISOString().substring(0,10);
            if (strToday <= getVal('registDte')) {
               setVal('cycleUpdAt', 'Y');
            } else {
               setVal('cycleUpdAt', 'N');
            }

            var param = getEl(inputForm).toObject(true);
            param.reqList = AUIGrid.getGridData(eqpmnGageReqGrid);
            param.newReqList = AUIGrid.getAddedRowItems(eqpmnGageReqGrid);
            param.resultList = AUIGrid.getGridData(eqpmnGageResultGrid);
            param.newResultList = AUIGrid.getAddedRowItems(eqpmnGageResultGrid);
            param.editedResultList = AUIGrid.getEditedRowItems(eqpmnGageResultGrid);

            customAjax({
               url: "/rsc/saveEqpmnGage.lims",
               data: param,
               successFunc: function(data) {
                  if (data > 0 && param.deleteAt == "N") {
                     success(lang.C100000762); //저장되었습니다.
                  } else if (data > 0 && param.deleteAt == "Y") {
                     success(lang.C100000462); //삭제되었습니다.
                  } else {
                     err(lang.C100000597); //오류가 발생했습니다.
                  }
                  searchEqpmnGage(data);
                  reset();
               }
            });
         }


         function loadGageReqExpr(paramArr, loadGbn) {
            //Gage 결과에 행추가할 아이템 객체 생성
            var item = {
               eqpmnGageResultSeqno: '',
               eqpmnGageRegistSeqno: '',
               expriemSeqno: '',
               expriemNm: '',
               cntrbtdgValue: '',
               rsrchChngeValue: '',
               guacctoCtgryValue: '',
               gageJdgmntCode: ''
            };

            customAjax({
               url: "/rsc/getEqpInspctCrrctReqExpr.lims",
               data: paramArr,
               successFunc: function(list) {
                  AUIGrid.addRow(eqpmnGageReqExprGrid, list);

                  //DB에 등록된 결과는 DB에서 조회
                  if (loadGbn == "load") {
                     getEqpGageResult(getVal('eqpmnGageRegistSeqno'));

                  //DB등록 이전의 결과는 중복된 시험항목 제외하고 결과그리드에 행추가
                  } else {
                     for (var row of list) {
                        var distinctRow = AUIGrid.getRowsByValue(eqpmnGageResultGrid, "expriemSeqno", row.expriemSeqno);
                        if (distinctRow.length == 0) {
                           item.expriemSeqno = row.expriemSeqno;
                           item.expriemNm = row.expriemNm;
                           AUIGrid.addRow(eqpmnGageResultGrid, item);
                        }
                     }
                  }
               }
            });
         }


         function getEqpGageResult(seqNo) {
            getGridDataParam("/rsc/getEqpGageResult.lims", { eqpmnGageRegistSeqno : seqNo }, eqpmnGageResultGrid);
         }


         function loadGageReq(seqNo) {
            getGridDataParam("/rsc/getEqpGageReq.lims", { eqpmnGageRegistSeqno: seqNo }, eqpmnGageReqGrid)
            .then(function() {
               AUIGrid.clearGridData(eqpmnGageReqExprGrid);
               AUIGrid.clearGridData(eqpmnGageResultGrid);

               //의뢰시험항목 조회
               var reqList = AUIGrid.getGridData(eqpmnGageReqGrid);
               if (reqList.length > 0) {
                  var seqArr = reqList.map(function(item) {
                     return item.reqestSeqno;
                  });
                  loadGageReqExpr(seqArr, "load");
               }
            });
         }


         function searchEqpmnGage(returnSeq) {
            getGridDataForm("/rsc/getEqpmnGageList.lims", searchForm, eqpmnGageGrid, function() {
               if (returnSeq)
                  gridSelectRow(eqpmnGageGrid, "eqpmnGageRegistSeqno", returnSeq);
            });
         }


         function reset() {
            pageReset([inputForm], [eqpmnGageReqGrid, eqpmnGageReqExprGrid, eqpmnGageResultGrid], [dropZoneArea],
               function() {
                  getEl('btnEqpmnPopOpen').style.display = '';
                  getEl('btnDelete').style.display = 'none';
               }
            );
         }


         function doSearch() {
            searchEqpmnGage();
         }


      </script>

   </tiles:putAttribute>
</tiles:insertDefinition>
