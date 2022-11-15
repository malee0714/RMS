<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">자재 관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
        <!--  body 시작 -->
        <div class="subContent">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>실린더 목록</h2> <!-- 실린더 목록 -->
                <div class="btnWrap">
                    <button id="btnBatchEditValveMaker" class="save">${msg.C100001365}</button> <!-- VALVE_MAKER 일괄 수정 -->
                    <button id="btnSearch" class="btn3 search" >${msg.C100000767}</button> <!-- 조회 -->
                </div>
                <!-- Main content -->
                <form id="frmSearch" onsubmit="return false">
                    <table class="subTable1">
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
                            <th>CYLINDER No</th> <!-- CYLINDER No -->
                            <td>
                                <input type="text" id="cylinderNoSch" name="cylinderNoSch">
                            </td>
                            <th class="necessary">CYLINDER_M</th> <!--CYLINDER_M-->
                            <td>
                                <input type="text" name="mtrqltValueSch" id="cylinderMSch" required>
                            </td>
                            <th class="necessary">CYLINDER_MAKER</th> <!--CYLINDER_MAKER -->
                            <td>
                                <input type="text" name="mnfcturprofsNmSch" id="cylinderMakerSch" required>
                            </td>

                            </td>

                            <th>${msg.C100000443}</th> <!-- 사용여부 -->
                            <td>
                                <label><input type="radio" name="useAt" value="">${msg.C100000779}</label> <!-- 전체 -->
                                <label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                                <label><input type="radio" name="useAt" value="N">${msg.C100000449}</label>	<!-- 사용안함 -->
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="subCon2">
                <!-- 자재 그리드 -->
                <div id="cylinderGrid" class="wd100p" style="height: 450px;"></div>
            </div>
            <div class="subCon1 mgT20">
                <h2><i class="fi-rr-apps"></i>실린더 정보</h2> <!-- 실린더 정보  -->
                <div class="btnWrap">
                    <button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                    <button id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                    <button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
                </div>
                <!-- Main content -->
                <form id="cylinderFrm" name="cylinderFrm" onsubmit="return false">
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
                            <th class="necessary">CYLINDER No</th>
                            <td>
                                <input type="text" name="cylndrNo" id="cylinderNo" required>
                            </td>
                            <th >CYLINDER_SIZE</th> <!--CYLINDER_SIZE -->
                            <td>
                                <input type="text" name="cylndrMgValue" id="cylinderSize">
                            </td>
                            <th>CYLINDER DATE</th> <!--CYLINDER DATE -->
                                <td><input type="text" id="cylinderDate" name="elctcDte" ></td>
                            <th>${msg.C100000443}</th> <!-- 사용 여부 -->
                            <td>
                                <label><input type="radio" id="use_y" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                                <label><input type="radio" id="use_n" name="useAt" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
                            </td>
                        </tr>
                        <tr>
                            <th class="necessary">CYLINDER_M</th> <!--CYLINDER_M-->
                            <td>
                                <input type="text" name="mtrqltValue" id="cylinderM" required>
                            </td>
                            <th class="necessary">CYLINDER_MAKER</th> <!--CYLINDER_MAKER -->
                            <td>
                                <input type="text" name="mnfcturprofsNm" id="cylinderMaker" required>
                            </td>
                            <th>VALVE_SIZE</th> <!--VALVE_SIZE -->
                            <td><input type="text" id="valveSeiz" name="valveMgValue" ></td>
                            <th>VALVE_M</th> <!--VALVE_M -->
                            <td><input type="text" id="valveM" name="valveMtrqltValue" ></td>
                        </tr>
                        <tr>
                            <th>VALVE_MAKER</th>
                            <td>
                                <input type="text" name="valveMnfcturprofsNm" id="valveMaker" >
                            </td>
                            <th >VALVE_TYPE</th> <!--VALVE_TYPE -->
                            <td>
                                <input type="text" name="valveStleValue" id="valveType">
                            </td>
                            <th>CONTENTS</th> <!--CONTENTS -->
                            <td><input type="text" id="contentsinput" name="cn" ></td>
                            <th>CPRESSURE</th> <!--CPRESSURE -->
                            <td><input type="text" id="cpressure" name="pressrValue" ></td>
                            <input type="hidden" id="sanctnSeqno" name="sanctnSeqno">
                        </tr>
                        <tr>
                            <th>${msg.C100000425}</th> <!-- 비고 -->
                            <td colspan="7"><textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength="4000"></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
            </div>

        </div>

        <!--  body 끝 -->
    </tiles:putAttribute>
    <tiles:putAttribute name="script">
        <script>
            var lang = ${msg}; // 기본언어

            $(function(){

                init();//기본 세팅

                setrgntCmpdsMGrid();  //그리드 생성
                setrgntCmpdsMGridEvent(); //그리드 이벤트

                setButtonEvent();//버튼 이벤트

            });
        </script>
        <script>
var cylinderGrid = "cylinderGrid";

function init(){
    datePickerCalendar(["cylinderDate"],true,["DD",0]);
    dialogBatchUpdCylnder('btnBatchEditValveMaker', 'cylnderDialog', 'cylinderGrid');
}

function setrgntCmpdsMGrid(){
    var columnLayout = {
        cylinderGrid : []
    };

    var reqProp = {
        showRowCheckColumn: true,
        showRowAllCheckBox: true
    };

    auigridCol(columnLayout.cylinderGrid);
    columnLayout.cylinderGrid.addColumnCustom("cylndrNo","CYLINDER No.",null,true,false) // CYLINDER No
     .addColumnCustom("cylndrMgValue","CYLINDER_SIZE",null,true,false)// CYLINDER_SIZE
     .addColumnCustom("elctcDte","CYLINDER DATE",null,true,false) /* CYLINDER DATE  */
     .addColumnCustom("mtrqltValue","CYLINDER_M",null,true,false) /* CYLINDER_M */
     .addColumnCustom("rm", "${msg.C100000425}", "*", true,false) // 비고
     .addColumnCustom("sanctnSeqno","" ,"*", false,false)
     .addColumnCustom("bplcCode","" ,"*", false,false)
     .addColumnCustom("mnfcturprofsNm","CYLINDER_MAKER" ,"*", true,false)
     .addColumnCustom("valveMgValue","VALVE_SIZE" ,"*", true,false)
     .addColumnCustom("valveMtrqltValue","VALVE_M" ,"*", true,false)
     .addColumnCustom("valveMnfcturprofsNm","VALVE_MAKER" ,"*", true,false)
     .addColumnCustom("beforeValveMnfcturprofsNm","BEFORE_VALVE_MAKER","140", true,false)
     .addColumnCustom("valveStleValue","VALVE_TYPE" ,"*", true,false)
     .addColumnCustom("cn","CONTENTS" ,"*", true,false)
     .addColumnCustom("pressrValue","CPRESSURE " ,"*", true,false)
     .addColumnCustom("bplcCode","" ,"*", false,false)
    //columnLayout.rgntCmpdsMaster.dropDownListRenderer([], bplcCodeArray, true, null);
    cylinderGrid = createAUIGrid(columnLayout.cylinderGrid, cylinderGrid, reqProp);
}

function setrgntCmpdsMGridEvent() {
    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(cylinderGrid, "ready", function (event) {

    });
    AUIGrid.bind(cylinderGrid, "cellDoubleClick", function (e) {
        $("#btnDelete").show();
        detailAutoSet({item:e.item,targetFormArr:["cylinderFrm"]});
    });
}


function setButtonEvent() {

    document.getElementById("btnSearch").addEventListener("click", function() {
        getCylinder();
    });

    document.getElementById("btnSave").addEventListener("click",function(){
        saveCylinder();
    });

    document.getElementById("btnDelete").addEventListener("click",function(){
        deleteCylinder();
    });

    document.getElementById("btnNew").addEventListener("click",function(){
        reset()
    });
}


function getCylinder(saveKey){
    let param=$("#frmSearch").serializeObject();
    customAjax({url:"/wrk/getcylinderList.lims",data:param,successFunc:function (data){
                AUIGrid.setGridData("#cylinderGrid", data)
            if(saveKey != null && saveKey != '') gridSelectRow(cylinderGrid, 'cylndrNo', [saveKey]);
        }});
}
function saveCylinder(){
    if(!saveValidation('cylinderFrm'))
        return false;
    let param=$("#cylinderFrm").serializeObject();
    customAjax({url:"/wrk/savecylinder.lims",data:param,successFunc:function (data){
            if(data == 0 ){
                alert('${msg.C000000170}'); /* 저장에 실패하였습니다. */
            }else{
                alert('${msg.C000000071}'); /* 저장 되었습니다. */
                reset();
                getCylinder(param.cylndrNo);
            }
        }});
}
function deleteCylinder(){
    let param=$("#cylinderFrm").serializeObject();
    customAjax({url:"/wrk/deletecylinder.lims",data:param,successFunc:function (data){
            if(data == 0 ){
                alert('${msg.C000000170}'); /* 저장에 실패하였습니다. */
            }else{
                alert('${msg.C000000071}'); /* 저장 되었습니다. */
                reset();
                getCylinder(param.cylndrNo);
            }
        }});
}
function reset(){
    pageReset(["cylinderFrm"], null, null, function(){
        $("#btnDelete").hide();
    });
}
        </script>
    </tiles:putAttribute>
</tiles:insertDefinition>
