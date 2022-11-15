<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">${msg.C100001342}</tiles:putAttribute> <!-- 고객불만-8D보고서 목록 -->
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>${msg.C100001342}</h2> <!-- 고객불만-8D보고서 목록 -->
        <div class="btnWrap">
            <button type="button" id="btnPrintReport" class="print">보고서 출력</button> <!-- 보고서 출력 -->
            <button type="button" id="btn_select" class="search" onclick="doSearch()">${msg.C100000767}</button> <!-- 조회 -->
        </div>

        <!-- Main content -->
        <form id="searchFrm">
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
                    <th>${msg.C100001309}</th> <!-- 고객불만번호 -->
                    <td>
                        <input type="text" id="cstmrDscnttNoSch" name="cstmrDscnttNo" class="wd100p schClass"  style="min-width:10em;">
                    </td>

                    <th>${msg.C100000187}</th> <!-- 고객사 -->
                    <td>
                        <input type="text" id="entrpsNmSch" name="entrpsNm" class="schClass" style="width:100%;  min-width: 0">
                    </td>

                    <th>${msg.C100001310}</th> <!-- 고객불만제목 -->
                    <td>
                        <input type="text" id="cstmrDscnttSjSch" name="cstmrDscnttSj" class="wd100p schClass"style="min-width:10em;">
                    </td>

                    <th>${msg.C100000806}</th> <!-- 제품 -->
                    <td>
                        <input type="text" id="mtrilNmSch" name="mtrilNm" class="schClass" style="width:100%;  min-width: 0" >
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100000056}</th> <!-- Lot No -->
                    <td>
                        <input type="text" id="lotNoSch" name="lotNo" class="wd100p schClass">

                    </td>

                    <th>${msg.C100000729}</th> <!-- 작성부서 -->
                    <td>
                        <select name="writngDeptCode" id="writngDeptCodeSch">
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>

                    <th>${msg.C100000730}</th> <!-- 작성자 -->
                    <td>
                        <select id="wrterIdNmSch" name="wrterIdNm" class="wd100p"></select>
                    </td>

                    <th>${msg.C100000728}</th> <!-- 작성 일자 -->
                    <td>
                        <input type="text" id="writngDteSt" name="writngDteSt" class="wd43p dateChk schClass"style="min-width:6em;">
                        ~
                        <input type="text" id="writngDteEn" name="writngDteEn" class="wd43p dateChk schClass"style="min-width:6em;">
                    </td>
                </tr>
            </table>
        </form>
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
    </div>
    <div class="subCon2">
        <div id="D8ReprtMGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
    </div>
    <div class="mapkey">
        <label class="scarce">${msg.C100000343}</label><!-- 반려 -->
    </div>
    <form id="D8ReprtMForm">

        <div class="subCon1 mgT15" id="detail">
            <h2><i class="fi-rr-apps"></i>${msg.C100001343}</h2> <!-- 8D 보고서 정보 -->
            <div class="btnWrap">
                <button type="button" id="btn_new" class="btn4" data-visible-code=["","CM01000001","CM01000002","CM01000004","CM01000005"]>${msg.C100000569}</button> <!-- 신규 -->
                <button type="button" id="btn_delete" class="delete" data-visible-code=["CM01000001","CM01000005"] style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"] style="display: none">회수</button>
                <button type="button" id="btn_save" class="save" data-visible-code=["","CM01000001","CM01000004","CM01000005"]>${msg.C100000760}</button> <!-- 저장 -->
                <button type="button" id="btn_Exmnt" class="save" data-visible-code=["CM01000005"] style="display: none">${msg.C100001325}</button> <!-- 검토 -->
                <button type="button" id="btn_sanctn" class="save" data-visible-code=["","CM01000001","CM01000004"]>${msg.C100000158}</button> <!-- 결재 상신 -->
            </div>
            <table style=" width:100%;" class="subTable1">
                <colgroup>
                    <col style="width:10%" />
                    <col style="width:15%" />
                    <col style="width:10%" />
                    <col style="width:15%" />
                    <col style="width:10%" />
                    <col style="width:15%" />
                    <col style="width:10%" />
                    <col style="width:15%" />
                </colgroup>
                <tr>
                    <th class="necessary">${msg.C100001309}</th> <!-- 고객 불만번호 -->
                    <td>
                        <input type="text" id="cstmrDscnttNo" name="cstmrDscnttNo" style="width: calc( 100% - 45px ); min-width: 0" readonly required>
                        <button type="button" id="btnFindCstmr" class="search inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button><!-- 팝업 -->
                    </td>

                    <th class="necessary">${msg.C100000187}</th> <!-- 고객사 -->
                    <td>
                        <input type="text" id="entrpsNm" name="entrpsNm" class="wd100p" readonly required>
                        <input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
                    </td>

                    <th class="necessary">${msg.C100001310}</th> <!-- 고객불만제목 -->
                    <td colspan="3">
                        <input type="text" id="cstmrDscnttSj" name="cstmrDscnttSj" class="wd100p"readonly required>
                    </td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100000806}</th> <!-- 제품 -->
                    <td>
                        <input type="text" id="mtrilNm" name="mtrilNm" class="wd100p" readonly required>
                    </td>

                    <th>${msg.C100000056}</th> <!-- LOT NO -->
                    <td><input type="text" id="lotNo" name="lotNo" class="wd100p" readonly></td>

                    <td colspan="4"></td>

                </tr>
                <tr>
                    <th>${msg.C100000729}</th> <!-- 작성 부서 -->
                    <td>
                        <select name="writngDeptCode"  id="writngDeptCode">
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>

                    <th>${msg.C100000730}</th> <!-- 작성자 -->
                    <td>
                        <select name="wrterId"  id="wrterId">
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>

                    <th class="necessary">${msg.C100000728}</th> <!-- 작성 일자 -->
                    <td>
                        <input type="text" id="writngDte" name="writngDte" class="wd100p dateChk" required>
                    </td>
                    <td colspan="2">
                        <input type="hidden" id="cstmrDscnttSeqno" name="cstmrDscnttSeqno"/>
                        <input type="hidden" id="d8ReprtSeqno" name="d8ReprtSeqno"/>
                        <input type="hidden" id="writngDeptCodeNm" name="writngDeptCodeNm"/>
                        <input type="hidden" id="wrterIdNm" name="wrterIdNm"/>
                        <input type="hidden" id="deleteAt" name="deleteAt" value="N"/>
                        <input type="hidden" id="exmntSeqno" name="exmntSeqno">
                    </td>

                </tr>
                <tr>
                    <th>${msg.C100001321}</th> <!-- 원인 분석 -->
                    <td colspan="7">
                        <textarea type="text" id="causeAnalsCn" name="causeAnalsCn" class="wd100p"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001345}</th> <!-- 시정 조치 -->
                    <td colspan="7">
                        <textarea type="text" id="corecManagtCn" name="corecManagtCn" class="wd100p"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001346}</th> <!-- 효과성 파악 -->
                    <td colspan="7">
                        <textarea type="text" id="effectfmnmUndstnCn" name="effectfmnmUndstnCn" class="wd100p"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001347}</th> <!-- 재발방지대책 -->
                    <td colspan="7">
                        <textarea type="text" id="recrPrvnCntrplnCn" name="recrPrvnCntrplnCn" class="wd100p" ></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001348}</th> <!-- 시정조치 완료 -->
                    <td colspan="7">
                        <textarea type="text" id="corecManagtComptCn" name="corecManagtComptCn" class="wd100p" ></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100000159}</th> <!-- 결제 정보 -->
                    <td colspan="7">
                        <select id="sanctnLineSeqno" name="sanctnLineSeqno"style="width: 25%;"></select>
                        <input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 51%;" readonly>
                        <input type="hidden" id="sanctnSeqno" name="sanctnSeqno">
                        <input type="hidden" id="sanctnProgrsSittnCode" name="sanctnProgrsSittnCode">
                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn" data-visible-code=["","CM01000001","CM01000004"]>${msg.C100000165}</button>
                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["","CM01000001","CM01000004"]><img src="/assets/image/close14.png"></button> <!-- 찾기 -->

                        <input type="text" name="sanctnInfoList" style="display: none;">
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <div class="accordion_wrap mgT17">
        <div class="accordion">${msg.C100001350}</div><!-- 8D 보고서 이력 -->
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>${msg.C100001350}</h3><!-- 8D 보고서 이력 -->
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div class="subCon2">
                <div id="d8ReprtHistGrid" class="mgT15" style="width: 100%; height: 300px; margin: 0 auto;"></div>
            </div>
        </div>
    </div>
</div>

<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<style>
    .rowstyle-companion{
        background-color: #FEDBDE;
    }
</style>
<script>


    //결재 정보 INSERT시켜줄 데이터
    var lang = ${ msg }; // 기본언어
    var D8ReprtMGrid = "D8ReprtMGrid";
    var d8ReprtHistGridId = "d8ReprtHistGrid";
    var D8ReprtMForm = document.querySelector('#D8ReprtMForm');
    var visibleSupport = new VisibleSupport('data-visible-code');
    var seqno = {};

    $(document).ready(function () {
        // 버튼 이벤트
        setButtonEvent();

        //문서 목록 그리드 세팅
        setD8ReprtMListGrid();

        //그리드 이벤트 선언
        setD8ReprtGridEvent();

        setDialogForm();

        //초기화
        init();

        gridResize([D8ReprtMGrid, d8ReprtHistGridId]);
    });

    //문서 목록 그리드 세팅
    function setD8ReprtMListGrid() {
        var col = [];
        auigridCol(col);
        col.addColumnCustom("cstmrDscnttNo", "${msg.C100001309}");/* 고객 불만 번호 */
        col.addColumnCustom("cstmrDscnttSj", "${msg.C100001310}");/* 고객 불만 제목 */
        col.addColumnCustom("entrpsNm", "${msg.C100000187}"); 				/* 고객사 명 */
        col.addColumnCustom("mtrilNm", "${msg.C100000806}"); 		/* 제품 명 */
        col.addColumnCustom("lotNo", "${msg.C100000056}"); 		/* Lot No */
        //col.addColumnCustom("mtrilNm", "${msg.C100000806}"); 		/* 조치팀 */
        //col.addColumnCustom("mtrilNm", "${msg.C100000806}"); 		/* 8D문서번호 */
        col.addColumnCustom("writngDeptCodeNm", "${msg.C100000729}");  	/* 작성 부서 */
        col.addColumnCustom("wrterIdNm", "${msg.C100000730}"); 		/* 작성자 */
        col.addColumnCustom("writngDte", "${msg.C100000728}");  		/* 작성일자 */
        col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100001351}");  		/* 결재진행상황 */

        //auiGrid 생성
        D8ReprtMGrid = createAUIGrid(col, D8ReprtMGrid, {
            "showRowCheckColumn": true,
            "showRowAllCheckBox": true,
            "rowStyleFunction" : function(rowIndex, item){
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "rowstyle-companion" : null;
            }
        });

        var d8ReprtHistGrid = [];
        auigridCol(d8ReprtHistGrid);

        d8ReprtHistGrid.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)		// 품질문서이력 일렬번호
            .addColumnCustom('tableNm',lang.C100000973,'*',true,false)                				// 테이블명
            .addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              				// 테이블 주석명
            .addColumnCustom('columnNm',lang.C100000975,'*',true,false)               				// 컬럼명
            .addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             				// 컬럼 주석명
            .addColumnCustom('seqno','일련번호','*',false,false)										// 일련번호
            .addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            				// 변경 전
            .addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)         				// 변경 후
            .addColumnCustom('lastChangerId',"최종변경자",'*',true,false)              					// 최종 변경자
            .addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false);          					// 최종 변경 일시

        d8ReprtHistGridId = createAUIGrid(d8ReprtHistGrid, d8ReprtHistGridId);

        gridResize([D8ReprtMGrid, d8ReprtHistGridId]);

        AUIGrid.bind(D8ReprtMGrid, "ready", function(event) {
            if ( Object.keys(seqno).length > 0 ){
                gridSelectRow(D8ReprtMGrid, "d8ReprtSeqno", [seqno.d8ReprtSeqno]);
            }
        });
    }



    //그리드 이벤트 선언
    function setD8ReprtGridEvent() {
        AUIGrid.bind(D8ReprtMGrid, "cellDoubleClick", function(event){
            seqno = event.item;
            bindUserSelectbox(event.item.writngDeptCode, "wrterId", function(){
                detailAutoSet({
                    "item" : event.item
                    ,"targetFormArr" : ["D8ReprtMForm"]
                });
            });

            progrsControl(event.item.sanctnProgrsSittnCode);

            getQlityHistList(event.item);
        })
    }

    function progrsControl(sanctnProgrsSittnCode){
        visibleSupport.displayOfCode((!!sanctnProgrsSittnCode) ? sanctnProgrsSittnCode : '')
    }

    //버튼 이벤트
    function setButtonEvent() {

        $("#btnPrintReport").click(function() {
           print8dReport();
        });

        $("#btn_new").click(function(){
            reset();
        });

        $("#btn_delete").click(function(){
            dataSave('삭제');
        });

        $("#btn_save").click(function(){

            if (!saveValidation("D8ReprtMForm"))
                return false;

            dataSave('임시');
        });

        $("#btn_sanctn").click(function(){

            if (!saveValidation("D8ReprtMForm"))
                return false;

            if(!$("#sanctnerNm").val()){
                warn("${msg.C100001359}");//결재 정보 선택 또는 결재 라인을 설정해주세요
                return false;
            }

            dataSave('상신');
        });

        $("#btnEntrpsResetSch,#btnMtrilResetSch").click(function(){
            dialogReset(this.id);
        });

        $("#sanctnLineSeqno").change(function (e) {
            customAjax({
                url: '/wrk/getSanctnerList.lims',
                data: {sanctnLineSeqno: e.target.value},
            }).then(function (res) {
                if (res.length > 0) {
                    var sanctnerNm = getSanctnerNm(res);
                    $("input[name=sanctnInfoList]").val(JSON.stringify(res));
                    $("input[name=sanctnerNm]").val(sanctnerNm);
                } else {
                    warn('선택된 결재자가 없습니다.');
                }
            });
        })

        $("select").change(function(e){
            var trgetId = e.target.id;
            $("#"+trgetId+"Nm").val($("#"+ e.target.id+" option:checked").text().replace("└", "").trim());
        })

        $("#btnRevert").click(function(e){
            revert();
        })
    }


    //초기화
    function init() {

        //달력 세팅
        datePickerCalendar(["writngDteSt", "writngDteEn"], true, ["YY", -1], ["DD", 0]);
        datePickerCalendar(["writngDte"], true);

        //콤보 세팅
        ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims', 'sanctnLineSeqno', { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000008" }, false, "${msg.C100000480}"); /* 선택 */
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'ocapSttusCode', queryParam : { 'upperCmmnCode': 'RS20' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'writngDeptCode', queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'writngDeptCodeSch', queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" }, selectFlag : true});

        bindUserSelectbox('${UserMVo.deptCode}', 'wrterIdNmSch');
        bindUserSelectbox('${UserMVo.deptCode}', 'wrterId');

        $("select[name=writngDeptCode]").on("change", function(e){
            bindUserSelectbox(e.target.value, $("#"+e.target.id).parent().next().next().children()[0].id);
        })

    }

    //저장
    function dataSave(saveGbn) {

        //권한으로 제어하기로함
        /*if( "${UserMVo.deptCode}" == $("#writngDeptCode").val()){
            alert("${msg.C100001340}"); //담당부서만 저장 가능합니다.
            return false;
        }*/

        var saveUrl = "";
        var message = "";
        if (saveGbn == '임시') {
            saveUrl = '/qa/insD8ReprtInfo.lims';
            message = "${msg.C100000762}"; //저장되었습니다.
        }else if (saveGbn == '상신') {
            saveUrl = '/qa/insD8ReprtApprovalM.lims';
            message = "${msg.C100001050}"; //저장 후 상신 하였습니다.
        }else if(saveGbn == '삭제'){
            $("#deleteAt").val("Y");
            saveUrl = '/qa/insD8ReprtInfo.lims';
            message = '${msg.C100000462}'; // 삭제되었습니다.
        }

        var param = $("#D8ReprtMForm").serializeObject();
        param.sanctnKndCode = 'CM05000008';
        var sanctnInfoList = $("input[name=sanctnInfoList]").val();
        param.sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];

        customAjax({
            "url": saveUrl, "data": param, "successFunc": function (result, status) {
                    if (status == "success") {
                        success(message); /* 삭제되었습니다. */
                        reset();
                    }
                doSearch();
            }
        });
    }

    // 8D 보고서 출력
    function print8dReport() {

        var chkedItems = AUIGrid.getCheckedRowItemsAll(D8ReprtMGrid);
        if (chkedItems.length == 0) {
            alert("선택된 8D 보고서가 없습니다."); /* 선택된 8D보고서가 없습니다. */
            return;
        }

        var RdUrl = "";
        var seqArr = [];
        var param = {
            printngSeCode: "SY15000001", // 출력물 구분
            printngOrginlFileNm: "8D REPORT.mrd" // 출력물 원본 파일 명
        };

        customAjax({
            url: "/com/printCours.lims",
            data: param,
            successFunc: function(data) {
                if (data.length == 1) {
                    RdUrl = data[0].printngOrginlFileNm; // Local Server
//					RdUrl = data[0].printngCours; // 운영&테스트 Server

                    chkedItems.forEach(function (item) {
                        seqArr.push(item.d8ReprtSeqno);
                    });

                    html5Viewer([RdUrl], seqArr);

                } else {
                    err(lang.C100000597); /* 오류가 발생했습니다. */
                }
            }
        });
    }

    //문서 목록 조회
    function doSearch() {
        customAjax({
            "url" : "/qa/d8ReprtMList.lims",
            "data" : $("#searchFrm").serializeObject(),
            "successFunc" : function(result){
                reset()
                AUIGrid.setGridData(D8ReprtMGrid, result);
            }
        })
    }

    //reset
    function reset() {
        pageReset(["D8ReprtMForm"], [d8ReprtHistGridId], null);
        progrsControl('');
        $("#deleteAt").val("N");
        $("#writngDte").val(getFormatDate());
    }


    function setDialogForm(){

        //고객불만 팝업
        dialogFindCstmr('btnFindCstmr', '${UserMVo.bplcCode}', 'cstrmrFindDialog', function(data){
            detailAutoSet({
                item: data
                ,targetFormArr: ["D8ReprtMForm"]
                ,ignoreElementArr : ["causeAnalsCn","sanctnLineSeqno","sanctnerNm","sanctnSeqno","sanctnProgrsSittnCode","sanctnLineChg","sanctnReset"]
                ,successFunc: function() {
                }
            })
        });

        dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {

            var list = res.gridData;
            if (list.length > 0) {
                var sanctnerNm = getSanctnerNm(list);
                D8ReprtMForm.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
                D8ReprtMForm.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }
        }, null, "CM05000008");

        dialogExmnt({
            btnId: 'btn_Exmnt',
            functions: {
                getExmntSeqno : getExmntSeqno,
                getOtherKey : getOtherKey,
                init : reset
            },
            dialogId: 'd8reprtDialogExmnt',
            url: '/qa/d8SaveExmnt.lims'
        });
    }

    function getExmntSeqno(){
        return $("#exmntSeqno").val();
    }

    function getOtherKey(){
        return $("#d8ReprtSeqno").val();
    }

    function bindUserSelectbox(deptCode, trgetId, callback) {
        $.when(
            ajaxJsonComboBox('/com/getDeptToUserLsit.lims', trgetId, { "deptCode": deptCode }, false, "${msg.C100000480}")
        ).then(callback);
    }

    function revert() {

        var param = $("#D8ReprtMForm").serializeObject();
        param.sanctnInfoList = [];

        customAjax({
            url: '/qa/revertD8Reprt.lims',
            data: param,
            elementIds: ['btn_save', 'btn_Exmnt', 'btn_sanctn', 'btn_new', 'btn_delete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert('회수 되었습니다.');
                init();
                doSearch();
            }
        });
    }

    function getQlityHistList(item){
        var param = {
            "tableNm" : "RS_8D_REPRT"
            , "seqno" : item.d8ReprtSeqno
        }
        getGridDataParam('/com//getQlityDocHistList.lims', param, d8ReprtHistGridId);
    }

</script>
</tiles:putAttribute>
</tiles:insertDefinition>
