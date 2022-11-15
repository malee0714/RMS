<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
   <tiles:putAttribute name="title">장비 일상점검</tiles:putAttribute>
   <tiles:putAttribute name="body">

      <div class="subContent">
         <div class="subCon1">
            <h2><i class="fi-rr-apps"></i>장비 일상점검 목록</h2> <!-- 장비 일상점검 목록 -->
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
                     <th>장비 분류 </th> <!-- 장비 분류 -->
                     <td><select id="schEqpmnClCode" name="schEqpmnClCode"></select></td>

                     <th>분석실</th> <!-- 분석실 -->
                     <td><select id="schCustlabSeqno" name="schCustlabSeqno"></select></td>

                     <th>${msg.C100000742}</th> <!-- 장비 명 -->
                     <td><input type="text" id="schEqpmnNm" name="schEqpmnNm" class="wd100p schClass" maxlength="200"></td>

                     <th>일상점검 일자</th> <!-- 일상점검 일자 -->
                     <td>
                        <input type="text" id="schChckBeginDte" name="schChckBeginDte" class="dateChk wd6p schClass" style="min-width:6em;">
                        ~
                        <input type="text" id="schChckEndDte" name="schChckEndDte" class="dateChk wd6p schClass" style="min-width:6em;">
                     </td>
                  </tr>
               </table>
            </form>
         </div>
         <div class="subCon2">
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div id="EqpmnEdayChckGrid" class="mgT15 mgB15" style="width:100%; height:300px; margin:0 auto;"></div>
         </div>

         <form id="EqpmnEdayChckForm">
            <div class="subCon1 mgT10" id="detail">
               <h2><i class="fi-rr-apps"></i>장비 일상점검 정보</h2> <!-- 장비 일상점검 정보 -->
               <div class="btnWrap">
                  <button type="button" id="btnReset" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                  <button type="button" id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                  <button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
               </div>
               <table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
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

                     <th>${msg.C100000739}</th> <!-- 관리 번호 -->
                     <td><input type="text" id="eqpmnManageNo" name="eqpmnManageNo" readonly></td>

                     <th class="necessary">${msg.C100000742}</th> <!-- 장비 명 -->
                     <td>
                        <input type="text" id="eqpmnNm" name="eqpmnNm" class="wd80p" required readonly>
                        <button type="button" id="btnEqpmnPopOpen" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                     </td>

                     <th>분석실</th> <!-- 분석실 -->
                     <td><input type="text" id="custlabNm" name="eqpmnNm" readonly></td>
                  </tr>

                  <tr>
                     <th class="necessary">${msg.C100000786}</th>  <!-- 점검자 -->
                     <td>
                        <input type="text" id="insctrNm" name="insctrNm" class="wd62p" value="${UserMVo.userNm}" readonly required>
                        <input type="text" id="insctrId" name="insctrId" value="${UserMVo.userId}" style="display: none">
                        <button type="button" id="btninsctrSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                        <button type="button" id="insctrReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->
                     </td>

                     <th class="necessary">${msg.C100000785}</th> <!-- 점검 일자 -->
                     <td><input type="text" id="chckDte" name="chckDte" class="dateChk" required></td>

                     <th class="necessary">점검 항목 수 </th> <!-- 점검 항목 수 -->
                     <td><input type="text" id="chckExprCnt" name="chckExprCnt" required readonly></td>

                     <th class="necessary">점검 결과 </th> <!-- 점검 결과 -->
                     <td><input type="text" id="jdgmntWordCode" name="jdgmntWordCode" required readonly></td>
                  </tr>

                  <tr>
                     <th>${msg.C100000425}</th> <!-- 비고 -->
                     <td colspan="13">
                        <textarea id="rm" name="rm" rows="2" maxlength="4000" style="width:100%;"></textarea>
                     </td>
                  </tr>
               </table>

               <input type="text" id="eqpmnEdayChckRegistSeqno" name="eqpmnEdayChckRegistSeqno" style="display: none">
               <input type="text" id="eqpmnSeqno" name="eqpmnSeqno" style="display: none">
               <input type="text" id="deleteAt" name="deleteAt" value="N" style="display: none">
            </div>
         </form>

         <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
         <div id="EqpmnEdayChckExprGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
      </div>

   </tiles:putAttribute>
   <tiles:putAttribute name="script">

      <style>
         .text-red { color: red; }
      </style>

      <script>

         var eqpmnEdayChckGrid = 'EqpmnEdayChckGrid';
         var eqpmnEdayChckExprGrid = 'EqpmnEdayChckExprGrid';
         var jdgmntWordList = [];
         var lang = ${msg};

         $(function() {

            setCombo();

            buildGrid();

            auiGridEvent();

            buttonEvent();

            renderDialog();

            gridResize([eqpmnEdayChckGrid, eqpmnEdayChckExprGrid]);

         });

         function renderDialog() {

            // 장비
            dialogEqpmn("btnEqpmnPopOpen", "eqpmnDialog", function(item) {
               $("#eqpmnSeqno").val(item.eqpmnSeqno);
               $("#eqpmnClNm").val(item.eqpmnClNm);
               $("#eqpmnManageNo").val(item.eqpmnManageNo);
               $("#eqpmnNm").val(item.eqpmnNm);
               $("#custlabNm").val(item.custlabNm);

               // 마스터에 등록된 일상점검시험항목 조회
               getEqpmnEdayChkExprM(item.eqpmnSeqno);
            });

            // 사용자
            dialogUser("btninsctrSearch", { bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}", authorSeCode : "${UserMVo.authorSeCode}" }, "insctrNmDialog", function(item) {
               $("#insctrNm").val(item.userNm);
               $("#insctrId").val(item.userId);
            });

            datePickerCalendar(["schChckBeginDte", "schChckEndDte"], true, ["MM",-1], ["DD",0]);
            datePickerCalendar(["chckDte"], false, ["DD",0]);
         }

         function setCombo() {
            ajaxJsonComboBox("/com/getCustLabCombo.lims", "schCustlabSeqno", null, true);
            ajaxJsonComboBox("/com/getCmmnCode.lims", "schEqpmnClCode", { upperCmmnCode : "RS02" }, true);
            jdgmntWordList = getGridComboList('/com/getCmmnCode.lims', { upperCmmnCode : "IM05" }, false);
         }

         function buildGrid() {

            var col = {
               eqpmnEdayChckCol: [],
               eqpmnEdayChckExprCol: []
            };

            var edayChckProp = {
               editable : false,
               selectionMode : "multipleCells"
            };

            auigridCol(col.eqpmnEdayChckCol);
            col.eqpmnEdayChckCol
            .addColumnCustom("eqpmnClNm", "${msg.C100000745}", "*", true)
            .addColumnCustom("eqpmnEdayChckRegistSeqno", "등록 일렬번호", "*", false)
            .addColumnCustom("eqpmnSeqno", "${msg.C000001396}", "*", false)
            .addColumnCustom("custlabNm", "분석실", "*", true)
            .addColumnCustom("eqpmnManageNo", "${msg.C100000739}", "*", true)
            .addColumnCustom("eqpmnNm", "${msg.C100000742}", "*", true)
            .addColumnCustom("serialNo", "Serial No", "*", true)
            .addColumnCustom("modlNm", "모델 명", "*", true)
            .addColumnCustom("insctrId", "${msg.C100000786}", "*", false)
            .addColumnCustom("insctrNm", "${msg.C100000786}", "*", true)
            .addColumnCustom("chckDte", "${msg.C100000785}", "*", true)
            .addColumnCustom("rm", "${msg.C100000425}", "*", true);

            eqpmnEdayChckGrid = createAUIGrid(col.eqpmnEdayChckCol, eqpmnEdayChckGrid, edayChckProp);



            var edayChckExprProp = {
               editable : true,
               selectionMode : "multipleCells"
            };

            var nonConformityColor = {
               styleFunction : function(rowIndex, columnIndex, value, headerText, item, dataField) {
                  if (value == "IM05000002") {
                     return "text-red";
                  }
               }
            };

            var numericProp = {
               type : "InputEditRenderer",
               onlyNumeric : true,
               allowPoint : true,
               allowNegative : true
            };

            // 특조건에 따라 미리 정의한 editRenderer 반환
            var conditionProp = {
               dataField : "resultValue",
               editable : true,
               selectionMode : "multipleCells",
               enableCellMerge : true,
               style : "my-require-style",
               headerTooltip : {
                  show : true,
                  tooltipHtml : "${msg.C100000114}" /* 값을 입력 또는 선택하세요. */
               },
               editRenderer : {
                  type : "ConditionRenderer",
                  conditionFunction : function(rowIndex, columnIndex, value, item) {
                     // 판정형식이 최대/최소인 경우에 numericProp 적용
                     if (item.jdgmntFomCode == "IM06000001") {
                        return numericProp;
                     } else if (item.jdgmntFomCode == "IM06000001") {
                        return edayChckExprProp;
                     }
                  }
               }
            };

            auigridCol(col.eqpmnEdayChckExprCol);
            col.eqpmnEdayChckExprCol
            .addColumnCustom("eqpmnEdayChckRegistSeqno", "${msg.C000001838}", "*", false)
            .addColumnCustom("eqpmnSeqno", "${msg.C000001396}", "*", false)
            .addColumnCustom("expriemSeqno", "${msg.C000000838}", "*", false)
            .addColumnCustom("expriemNm", "${msg.C100000560}", "*", true, false)
            .addColumnCustom("unitSeqno", "단위", "*", false)
            .addColumnCustom("unitNm", "단위", "*", true, false)
            .addColumnCustom("jdgmntFomCode", "${msg.C100000919}", "*", false)
            .addColumnCustom("jdgmntFomNm", "${msg.C100000919}", "*", true, false)
            .addColumnCustom("textStdr", "텍스트 기준", "*", false)
            .addColumnCustom("mummValue", "${msg.C100000919}", "*", false)
            .addColumnCustom("mummValueSeCode", "${msg.C100000919}", "*", false)
            .addColumnCustom("mxmmValue", "${msg.C100000919}", "*", false)
            .addColumnCustom("mxmmValueSeCode", "${msg.C100000919}", "*", false)
            .addColumnCustom("expriemSdspcCn", "${msg.C100000237}", "*", true, false)
            .addColumnCustom("resultValue", "${msg.C100000150}", "*", true, true, conditionProp)
            .addColumnCustom("jdgmntWordCode", "${msg.C100000918}", "*", true, false, nonConformityColor)
            .addColumnCustom("partclrMatter", "특이사항", "*", true, true)
            .addColumnCustom("sortOrdr", "정렬 순서", "*", false)
            .dropDownListRenderer(["jdgmntWordCode"], jdgmntWordList, true);

            eqpmnEdayChckExprGrid = createAUIGrid(col.eqpmnEdayChckExprCol, eqpmnEdayChckExprGrid, edayChckExprProp);
         }


         function auiGridEvent() {

            AUIGrid.bind(eqpmnEdayChckGrid, "cellDoubleClick", function(event) {
               $("#btnDelete").show();

               var item = event.item;
               detailAutoSet({
                  item : item,
                  targetFormArr : ["EqpmnEdayChckForm"],
                  ignoreFormArr : ["SearchFrm"],
                  successFunc : function() {
                     $("#btnEqpmnPopOpen").hide();
                     if (item.jdgmntWordCode == "IM05000001")
                        $("#jdgmntWordCode").val("적합");
                     else
                        $("#jdgmntWordCode").val("부적합");

                     // 등록된 일상점검결과 조회
                     getEqpmnEdayChkResult(item.eqpmnEdayChckRegistSeqno);
                  }
               });
            });

            // 판정값 직접수정 방지
            AUIGrid.bind(eqpmnEdayChckExprGrid, "cellEditBegin", function(event) {
               if (event.dataField == "jdgmntWordCode")
                  return false;
            });

            // 결과값 입력에 따른 자동판정
            AUIGrid.bind(eqpmnEdayChckExprGrid, "cellEditEnd", function(event) {
               if (event.dataField == "resultValue" && !!event.value) {
                  chkSdspcValue(event.item, event.rowIndex, event.value);

                  var unSuitable = AUIGrid.getRowsByValue(eqpmnEdayChckExprGrid, "jdgmntWordCode", "IM05000002");
                  if (unSuitable.length > 0) {
                     $("#jdgmntWordCode").val("부적합");
                  } else {
                     $("#jdgmntWordCode").val("적합");
                  }
               }
            });
         }


         function buttonEvent() {

            $("#btnSelect").click(function() {
               searchEqpEdayChk();
            });

            $('#btnReset').click(function() {
               reset();
            });

            $("#btnSave").click(function() {
               saveValid();
            });

            $("#btnDelete").click(function() {
               if (!$("#eqpmnEdayChckRegistSeqno").val()) {
                  alert("${msg.C100000467}");  /* 삭제할 데이터가 없습니다. */
                  return;
               }

               if (confirm("${msg.C100000461}")) {  /* 삭제하시겠습니까? */
                  $("#deleteAt").val("Y");
                  saveEqpEdayChck();
               }
            });

            $("#insctrReset").click(function() {
               $("#insctrNm").val("");
               $("#insctrId").val("");
            });
         }


         function getEqpmnEdayChkExprM(seqNo) {
            getGridDataParam("/rsc/getEqpEdayChckExprM.lims", { eqpmnSeqno : seqNo }, eqpmnEdayChckExprGrid)
            .then(function(data) {
               $("#chckExprCnt").val(data.length);
            });
         }


         function getEqpmnEdayChkResult(seqNo) {
            getGridDataParam("/rsc/getEqpEdayChckResult.lims", { eqpmnEdayChckRegistSeqno : seqNo }, eqpmnEdayChckExprGrid)
            .then(function(data) {
               $("#chckExprCnt").val(data.length);
            });
         }


         function saveValid() {

            if (!saveValidation("EqpmnEdayChckForm")) {
               return;
            }

            var gridData = AUIGrid.getGridData(eqpmnEdayChckExprGrid);
            if (gridData.length == 0) {
               warn("${msg.C100001236}");  /* 해당 장비에 등록된 일상점검 시험항목이 없습니다. 등록 후 다시 진행해주세요. */
               reset();
               return;
            }

            var valid = gridRequire({
               requireColumns: ["resultValue"]
               ,gridId: eqpmnEdayChckExprGrid
               ,list: gridData
               ,msg: "결과값은 필수 입력값입니다." /* 결과값은 필수 입력값입니다. */
            });
            if (!valid) {
               return;
            }

            // 신규등록일 때 장비별 점검일자 중복검증
            if (!$("#eqpmnEdayChckRegistSeqno").val()) {
               ajaxJsonForm("/rsc/chkDuplicateChckDte.lims", "EqpmnEdayChckForm", function(data) {
                  if (data > 0) {
                     warn("해당 장비로 동일한 점검일자에 점검기록이 존재합니다."); /* 해당 장비로 동일한 점검일자에 점검기록이 존재합니다. */
                  } else {
                     saveEqpEdayChck();
                  }
               });
            } else {
               saveEqpEdayChck();
            }

         }


         function saveEqpEdayChck() {

            var param = $("#EqpmnEdayChckForm").serializeObject();
            param.edayChckExprList = AUIGrid.getGridData(eqpmnEdayChckExprGrid);

            if (param.jdgmntWordCode == "적합")
               param.jdgmntWordCode = "IM05000001";
            else
               param.jdgmntWordCode = "IM05000002";

            customAjax({
               "url": "/rsc/saveEqpEdayChkResult.lims",
               "data": param,
               "successFunc": function(data) {
                  if (data > 0) {
                     if ($("#deleteAt").val() == "N") {
                        success("${msg.C100000762}"); /* 저장되었습니다. */
                     } else {
                        success("${msg.C100000462}"); /* 삭제되었습니다. */
                     }
                     reset();
                     searchEqpEdayChk(data);

                  } else {
                     err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
                  }
               }
            });
         }


         function searchEqpEdayChk(returnSeq) {
            getGridDataForm("/rsc/getEqpmnEdayChkList.lims", "SearchFrm", eqpmnEdayChckGrid, function() {
               if (returnSeq)
                  gridSelectRow(eqpmnEdayChckGrid, "eqpmnEdayChckRegistSeqno", returnSeq);
            });
         }


         function reset() {
             pageReset(["EqpmnEdayChckForm"], [eqpmnEdayChckExprGrid], null, function() {
                $("#btnDelete").hide();
                $("#btnEqpmnPopOpen").show();
             });
         }


         // 기준규격에 대한 결과값에 따른 자동판정
         function chkSdspcValue(rowItem, rowIndex, resultVal) {

            var jdgmntFomCode = rowItem.jdgmntFomCode;
            var mxmmValue = rowItem.mxmmValue;
            var mxmmSeCode = rowItem.mxmmValueSeCode;
            var mummValue = rowItem.mummValue;
            var mummSeCode = rowItem.mummValueSeCode;
            var textStdr = rowItem.textStdr;
            var jdgmntWord;

            // 최대/최소
            if (jdgmntFomCode == "IM06000001") {

               // 최대,최소값 둘 다 있는 케이스
               if (!!mummValue && !!mxmmValue) {

                  // 이상,이하
                  if (mummSeCode == "IM08000001" && mxmmSeCode == "IM07000001") {
                     if (parseFloat(resultVal) >= parseFloat(mummValue) && parseFloat(resultVal) <= parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }

                  // 이상,미만
                  } else if (mummSeCode == "IM08000001" && mxmmSeCode == "IM07000002") {
                     if (parseFloat(resultVal) >= parseFloat(mummValue) && parseFloat(resultVal) < parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }

                  // 초과,이하
                  } else if (mummSeCode == "IM08000002" && mxmmSeCode == "IM07000001") {
                     if (parseFloat(resultVal) > parseFloat(mummValue) && parseFloat(resultVal) <= parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }

                  // 초과,미만
                  } else if (mummSeCode == "IM08000002" && mxmmSeCode == "IM07000002") {
                     if (parseFloat(resultVal) > parseFloat(mummValue) && parseFloat(resultVal) < parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }
                  }

               // 최댓값만 있는 케이스
               } else if (!mummValue && !!mxmmValue) {

                  // 이하
                  if (mxmmSeCode == "IM07000001") {
                     if (parseFloat(resultVal) <= parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }

                  // 미만
                  } else if (mxmmSeCode == "IM07000002") {
                     if (parseFloat(resultVal) < parseFloat(mxmmValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }
                  }

               // 최솟값만 있는 케이스
               } else if (!!mummValue && !mxmmValue) {

                  // 이상
                  if (mummSeCode == "IM08000001") {
                     if (parseFloat(resultVal) >= parseFloat(mummValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }

                  // 초과
                  } else if (mummSeCode == "IM08000002") {
                     if (parseFloat(resultVal) > parseFloat(mummValue)) {
                        jdgmntWord = "IM05000001";
                     } else {
                        jdgmntWord = "IM05000002";
                     }
                  }
               }

            // 텍스트기준
            } else if (jdgmntFomCode == "IM06000003") {

               if (!!textStdr) {
                  if (textStdr.toUpperCase() == resultVal.toUpperCase()) {
                     jdgmntWord = "IM05000001";
                  } else {
                     jdgmntWord = "IM05000002";
                  }
               }

            // 기준없음
            } else if (jdgmntFomCode == "IM06000004") {
               jdgmntWord = "IM05000003";
            }

            AUIGrid.setCellValue(eqpmnEdayChckExprGrid, rowIndex, "jdgmntWordCode", jdgmntWord);
         }


         function doSearch(e) {
            searchEqpEdayChk();
         }


      </script>

   </tiles:putAttribute>
</tiles:insertDefinition>
