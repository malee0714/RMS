<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">고객불만관리</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>${msg.C100001308}</h2> <!-- 고객불만관리 -->
        <div class="btnWrap">
            <button type="button" id="btn_select" class="search"
                onclick="doSearch()">${msg.C100000767}</button> <!-- 조회 -->
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
                        <input type="text" id="entrpsNmSch" name="entrpsNm" class="schClass" style="width: 100%;  min-width: 0">
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
                    <th>${msg.C100001312}</th> <!-- 요청일자 -->
                    <td>
                        <input type="text" id="requstDteSt" name="requstDteSt" class="wd43p dateChk schClass" style="min-width:6em;">
                        ~
                        <input type="text" id="requstDteEn" name="requstDteEn" class="wd43p dateChk schClass" style="min-width:6em;">
                    </td>

                    <th>${msg.C100001313}</th> <!-- 담당부서 -->
                    <td>
                        <select name="chrgDeptCode" id="chrgDeptCodeSch">
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>

                    <th>${msg.C100000271}</th> <!-- 담당자 -->
                    <td>
                        <select id="chargerIdSch" name="chargerId" class="wd100p" required></select>
                    </td>

                    <th>${msg.C100001314}</th> <!-- 완료일자 -->
                    <td>
                        <input type="text" id="comptDteSt" name="comptDteSt" class="wd43p dateChk schClass"style="min-width:6em;">
                        ~
                        <input type="text" id="comptDteEn" name="comptDteEn" class="wd43p dateChk schClass"style="min-width:6em;">
                    </td>
                </tr>
            </table>
        </form>
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
    </div>
    <div class="subCon2">
        <div id="cstrmrMGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
    </div>
    <div class="mapkey">
        <label class="scarce">${msg.C100000343}</label><!-- 반려 -->
    </div>
    <form id="CstrmrMForm">

        <div class="subCon1 mgT15" id="detail">
            <h2><i class="fi-rr-apps"></i>${msg.C100001324}</h2> <!-- 고객불만 정보 -->
            <div class="btnWrap">
                <button type="button" id="btn_new" class="btn4" data-visible-code=["init","CM01000001","CM01000002","CM01000004","CM01000005"]>${msg.C100000569}</button> <!-- 신규 -->
                <button type="button" id="btn_delete" class="delete" data-visible-code=["CM01000001","CM01000005"]>${msg.C100000458}</button> <!-- 삭제 -->
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"]>회수</button>
                <button type="button" id="btn_save" class="save" data-visible-code=["init","CM01000001","CM01000004","CM01000005"]>${msg.C100000760}</button> <!-- 저장 -->
                <button type="button" id="btn_Exmnt" class="save" data-visible-code=["CM01000005"]>${msg.C100001325}</button> <!-- 검토 -->
                <button type="button" id="btn_sanctn" class="save" data-visible-code=["init","CM01000001","CM01000004"]>${msg.C100000158}</button> <!-- 결재 상신 -->
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
                    <th>${msg.C100001309}</th> <!-- 고객 불만번호 -->
                    <td>
                        <input type="text" id="cstmrDscnttNo" name="cstmrDscnttNo" class="wd100p" readonly style="min-width:10em;">

                    </td>

                    <th class="necessary">${msg.C100000187}</th> <!-- 고객사 -->
                    <td>
                        <input type="text" id="entrpsNm" name="entrpsNm" style="width:calc(100% - 88px);  min-width: 0;" readonly required>
                        <input type="hidden" id="entrpsSeqno" name="entrpsSeqno" required>
                        <button type="button" id="btnEntrpsSeqno" class="search inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="/assets/image/btnSearch.png"></button><!-- 찾기 -->
                        <button type="button" id="btnEntrpsReset" class="inTableBtn inputBtn btn5" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
                    </td>

                    <th class="necessary">${msg.C100001310}</th> <!-- 고객불만제목 -->
                    <td colspan="3">
                        <input type="text" id="cstmrDscnttSj" name="cstmrDscnttSj" class="wd100p" style="min-width:10em;" required>
                    </td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100000806}</th> <!-- 제품 -->
                    <td>
                        <select id="mtrilSeqno" name="mtrilSeqno"  style="width: 100%;" required></select>
                    </td>

                    <th>${msg.C100000056}</th> <!-- LOT NO -->
                    <td><input type="text" id="lotNo" name="lotNo" class="wd100p" style="min-width:10em;"></td>

                    <th>${msg.C100001315}</th> <!-- 발생 일자 -->
                    <td>
                        <input type="text" id="occrrncDte" name="occrrncDte" class="wd100p dateChk">
                    </td>

                    <th>${msg.C100001316}</th> <!-- 발생 수량 -->
                    <td>
                        <input type="text" id="occrrncQtt" name="occrrncQtt" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" class="wd100p" style="min-width:10em;">
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001317}</th> <!-- 8D보고서유무 -->
                    <td>
                        <input type="checkbox" id="reprtAt" name="reprtAt" class="chk" value="N">
                    </td>

                    <th class="necessary">${msg.C100001312}</th> <!-- 요청 일자 -->
                    <td>
                        <input type="text" id="requstDte" name="requstDte" class="wd100p dateChk" required>
                    </td>

                    <th class="necessary">${msg.C100001313}</th> <!-- 담당 부서 -->
                    <td>
                        <select name="chrgDeptCode"  id="chrgDeptCode" class="ignoreElement" required>
                            <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                        </select>
                    </td>

                    <th class="necessary">${msg.C100000271}</th> <!-- 담당자 -->
                    <td><select id="chargerId" name="chargerId" class="wd100p ignoreElement" required></select></td>
                </tr>
                <tr>
                    <th>${msg.C100001320}</th> <!-- 중요도 -->
                    <td>
                        <select id="cstmrDscnttIpcrCode" name="cstmrDscnttIpcrCode" class="wd100p"></select>
                    </td>
                    <th>${msg.C100001319}</th> <!-- OCAP 상태 -->
                    <td>
                        <select id="ocapSttusCode" name="ocapSttusCode" class="wd100p"></select>
                    </td>
                    <th>5M1E</th> <!-- 5M1E -->
                    <td>
                        <select id="m5e1Code" name="m5e1Code" class="wd100p"></select>
                    </td>
                    <th>${msg.C100001318}</th> <!-- 피해규모 -->
                    <td><input type="text" id="dmgeScaleCn" name="dmgeScaleCn" class="wd100p" style="min-width:10em;"></td>
                </tr>
                <tr>
                    <th>${msg.C100001314}</th> <!-- 완료일자 -->
                    <td>
                        <input type="text" id="comptDte" name="comptDte" class="wd100p dateChk" style="min-width:10em;">
                    </td>
                    <td colspan="6">
                        <input type="hidden" id="deleteAt" name="deleteAt" value="N">
                        <input type="hidden" id="cstmrDscnttSeqno" name="cstmrDscnttSeqno">
                        <input type="hidden" id="cstmrDscnttIpcrCodeNm" name="cstmrDscnttIpcrCodeNm">
                        <input type="hidden" id="chargerIdNm" name="chargerIdNm">
                        <input type="hidden" id="chrgDeptCodeNm" name="chrgDeptCodeNm">
                        <input type="hidden" id="ocapSttusCodeNm" name="ocapSttusCodeNm">
                        <input type="hidden" id="m5e1CodeNm" name="m5e1CodeNm">
                        <input type="hidden" id="exmntSeqno" name="exmntSeqno">
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001321}</th> <!-- 원인 분석 -->
                    <td colspan="3">
                        <textarea type="text" id="causeAnalsCn" name="causeAnalsCn" class="wd100p" style="min-width:10em;"></textarea>
                    </td>
                    <th>${msg.C100001322}</th> <!-- 개선대책 -->
                    <td colspan="3">
                        <textarea type="text" id="imprvmCntrplnCn" name="imprvmCntrplnCn" class="wd100p" style="min-width:10em;"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100001323}</th> <!-- 불만 내용 -->
                    <td colspan="7">
                        <textarea type="text" id="dscnttCn" name="dscnttCn" class="wd100p" style="min-width:10em;"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100000860}</th> <!-- 첨부파일 -->
                    <td colspan="7">
                        <div id="dropZoneArea"></div>
                        <input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" value="">
                        <input type="hidden" id="btnSave_file">
                    </td>
                </tr>
                <tr>
                    <th>${msg.C100000159}</th> <!-- 결제 정보 -->
                    <td colspan="3">
                        <select id="sanctnLineSeqno" name="sanctnLineSeqno"style="width: 25%;"></select>
                        <input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 51%;" readonly>
                        <input type="hidden" id="sanctnSeqno" name="sanctnSeqno">
                        <input type="hidden" id="sanctnProgrsSittnCode" name="sanctnProgrsSittnCode">
                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn" data-visible-code=["init","CM01000001","CM01000004"]>${msg.C100000165}</button> <!-- 찾기 -->
                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["init","CM01000001","CM01000004"]> <img src="/assets/image/close14.png"></button>  <!-- 초기화 -->

                        <input type="text" name="sanctnInfoList" style="display: none;">
                    </td>
                    <td colspan="4"></td>
                </tr>
            </table>
        </div>
    </form>
    <div style="display: flex;" class="mgT20">
        <div class="wd45p fL">
            <div class="subCon1" >
                <h3>${msg.C100000781}</h3> <!-- 전체사용자 -->
                <div class="btnWrap">
                    <button id="sAllUserBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
                </div>
                <table cellpadding="0" cellspacing="0" width="100%" class="subTable1  mgT15">
                    <colgroup>
                        <col style="width: 10%"></col>
                        <col style="width: 15%"></col>
                        <col style="width: 10%"></col>
                        <col style="width: 15%"></col>
                    </colgroup>
                    <tr>
                        <th>${msg.C100000401}</th>  <!-- 부서 -->
                        <td><select id="pDeptCode" name="pDeptCode"></select></td>
                        <th>${msg.C100000452}</th> <!-- 사용자 명 -->
                        <td><input type="text" id="pUserNm" name="pUserNm" placeholder="${msg.C100000452}" /></td>
                    </tr>
                </table>
            </div>
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div class = "subcon2">
                <div id="allUserGridId" class="mgT15"	style="height: 300px;"></div>
            </div>
        </div>

        <div class="arrowWrap wd10p mgT10" style="float: left;">
            <div>
                <button type="button" id="arrow3"><i class="fi-rr-angle-right"></i></button>
            </div>
            <div class="mgT20">
                <button type="button" id="arrow4"><i class="fi-rr-angle-left"></i></button>
            </div>
        </div>
        <div class="wd45p fL">
            <div class="subCon1">
                <h3>${msg.C100001326}</h3> <!--문제해결 구성원 -->
            </div>
            <div id="subCon2">
                <div id="athUserGridId" class="mgT15" style="width: 100%; height: 355px; margin: 0 auto;"></div>
            </div>
        </div>
    </div>

    <div class="accordion_wrap mgT17">
        <div class="accordion">${msg.C100001349}</div><!-- 고객불만 이력 -->
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>${msg.C100001349}</h3><!-- 고객불만 이력 -->
            <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
            <div class="subCon2">
                <div id="cstrmrHistGrid" class="mgT15" style="width: 100%; height: 300px; margin: 0 auto;"></div>
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
    var bplcCode = "${UserMVo.bplcCode}";
    var allUserGridId = "allUserGridId";
    var athUserGridId = "athUserGridId";
    var cstrmrMGrid = "cstrmrMGrid";
    var cstrmrHistGridId = "cstrmrHistGrid";
    var dropZoneArea;
    var seqno = {};
    var CstrmrMForm = document.querySelector('#CstrmrMForm');
    var visibleSupport = new VisibleSupport('data-visible-code');
    var sanctnLineControl = new SelectBoxControll(CstrmrMForm.querySelector('[name=sanctnLineSeqno]'));
    var sessionObj = {
        bplcCode : "${UserMVo.bestInspctInsttCode}",
        deptCode : "${UserMVo.deptCode}"
    };

    $(document).ready(function () {
        // 버튼 이벤트
        setButtonEvent();

        //문서 목록 그리드 세팅
        setCstrmrMListGrid();

        //그리드 이벤트 선언
        setCstrmrGridEvent();

        setDialogForm();

        //초기화
        init();


    });

    //문서 목록 그리드 세팅
    function setCstrmrMListGrid() {
        var col = [];
        auigridCol(col);
        col.addColumnCustom("cstmrDscnttNo", "${msg.C100001309}");/* 고객 불만 번호 */
        col.addColumnCustom("cstmrDscnttSj", "${msg.C100001310}");/* 고객 불만 제목 */
        col.addColumnCustom("entrpsNm", "${msg.C100000187}"); 				/* 고객사 명 */
        col.addColumnCustom("mtrilNm", "${msg.C100000806}"); 		/* 제품 명 */
        col.addColumnCustom("dscnttCn", "${msg.C100001323}"); 		/* 불만 내용 */
        col.addColumnCustom("requstDte", "${msg.C100001312}");		/* 요청 일자 */
        col.addColumnCustom("chrgDeptCodeNm", "${msg.C100001313}");  	/* 담당 부서 */
        col.addColumnCustom("chargerIdNm", "${msg.C100000271}"); 		/* 담당자 */
        col.addColumnCustom("ocapSttusCodeNm", "${msg.C100001319}");		/* OCAP상태 */
        col.addColumnCustom("cstmrDscnttIpcrCodeNm", "${msg.C100001320}");  	/* 중요도 */
        col.addColumnCustom("comptDte", "${msg.C100001314}");  		/* 완료일자 */
        col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100001351}");  		/* 결제 진행 상태 */
        col.addColumnCustom("lotNo", "${msg.C100000056}");  		/* Lot No. */
        col.addColumnCustom("occrrncDte", "${msg.C100001315}");  		/* 발생 일자 */
        col.addColumnCustom("occrrncQtt", "${msg.C100001316}");  		/* 발생 수량 */
        col.addColumnCustom("reprtAt", "${msg.C100001317}");  		/* 8D 보고서 유무 */
        col.addColumnCustom("m5e1CodeNm", "${msg.C100001333}");  		/* M5E1 */
        col.addColumnCustom("dmgeScaleCn", "${msg.C100001318}");  		/* 피해규모 */

        //auiGrid 생성
        cstrmrMGrid = createAUIGrid(col, cstrmrMGrid, {
            "rowStyleFunction" : function(rowIndex, item){
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "rowstyle-companion" : null;
            }
        });

        //전체메뉴, 권한메뉴 속성
        var userGridPros = {
            editable : false, // 편집 가능 여부 (기본값 : false)
            selectionMode : "multipleCells", // 셀 선택모드 (기본값: singleCell)
            softRemovePolicy : "exceptNew",
            softRemoveRowMode : true,
            showStateColumn : true,
            //엑스트라체크박스 표시
            showRowCheckColumn : true,
            // 전체 체크박스 표시 설정
            showRowAllCheckBox : true
        };

        var allUserGrid = [];
        auigridCol(allUserGrid);

        //전체사용자
        auigridCol(allUserGrid);
        allUserGrid.addColumnCustom("deptNm","${msg.C100000401}", "*", true, false); /* 부서명 */
        allUserGrid.addColumnCustom("userNm","${msg.C100000452}", "*", true, false); /* 사용자 명 */

        allUserGridId = createAUIGrid(allUserGrid,allUserGridId, userGridPros);

        var athUserGrid = [];
        auigridCol(athUserGrid);

        //권한 사용자
        auigridCol(athUserGrid);
        athUserGrid.addColumnCustom("deptNm","${msg.C100000401}", "*", true, false); /* 부서명 */
        athUserGrid.addColumnCustom("userNm","${msg.C100000452}", "*", true, false); /* 사용자 명 */

        athUserGridId = createAUIGrid(athUserGrid,athUserGridId, userGridPros);

        var cstrmrHistGrid = [];
        auigridCol(cstrmrHistGrid);

        cstrmrHistGrid.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)		// 품질문서이력 일렬번호
            .addColumnCustom('tableNm',lang.C100000973,'*',true,false)                				// 테이블명
            .addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              				// 테이블 주석명
            .addColumnCustom('columnNm',lang.C100000975,'*',true,false)               				// 컬럼명
            .addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             				// 컬럼 주석명
            .addColumnCustom('seqno','일련번호','*',false,false)										// 일련번호
            .addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            				// 변경 전
            .addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)         				// 변경 후
            .addColumnCustom('lastChangerId',"최종변경자",'*',true,false)              					// 최종 변경자
            .addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false);          					// 최종 변경 일시

        cstrmrHistGridId = createAUIGrid(cstrmrHistGrid,cstrmrHistGridId);

        AUIGrid.bind(cstrmrMGrid, "ready", function(event) {
            if ( Object.keys(seqno).length > 0 ){
                gridSelectRow(cstrmrMGrid, "cstmrDscnttSeqno", [seqno.cstmrDscnttSeqno]);
            }
        });

        gridResize([cstrmrMGrid, allUserGridId, athUserGridId, cstrmrHistGridId]);
    }



    //그리드 이벤트 선언
    function setCstrmrGridEvent() {
        AUIGrid.bind(cstrmrMGrid, "cellDoubleClick", function(event){

            seqno = event.item;

            bindUserSelectbox(event.item.chrgDeptCode, "chargerId", function () {
                detailAutoSet({
                    "item" : event.item,
                    "targetFormArr" : ["CstrmrMForm"],
                    "successFunc" : function(){
                        $("#reprtAt").val(event.item.reprtAt);
                        $("#reprtAt").prop("checked",event.item.reprtAt == 'Y' ? true : false);
                        getCstmrUserList(event.item.cstmrDscnttSeqno);
                        getQlityHistList(event.item);
                    }
                });
            });
            progrsControll(event.item.sanctnProgrsSittnCode);
        })
    }



    function progrsControll(sanctnProgrsSittnCode){

        if (sanctnProgrsSittnCode === 'CM01000001' || sanctnProgrsSittnCode === 'CM01000004' || sanctnProgrsSittnCode === 'init') {
            //작성중, 반려, 초기화
            dropZoneArea.getFiles(CstrmrMForm.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControl.optionDisableClear();

        } else if (sanctnProgrsSittnCode === 'CM01000005') {
            //결재 완료
            dropZoneArea.getFiles(CstrmrMForm.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControl.notSelectedOptionDisable(true);

        } else {
            //결재 대기, 대기예정
            dropZoneArea.getFiles(CstrmrMForm.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
            dropZoneArea.readOnly(true);
            sanctnLineControl.notSelectedOptionDisable(true);
        }

        visibleSupport.displayOfCode(sanctnProgrsSittnCode);
    }

    //버튼 이벤트
    function setButtonEvent() {
        $("#btn_new").click(function(){
            reset();
        });

        $("#btn_delete").click(function(){
            if(!$("#cstmrDscnttSeqno").val()){
                alert("${msg.C100000490}") //선택된 데이터가 없습니다.
                return false;
            }

            if(!confirm("${msg.C100000461}")){//삭제 하시겠습니까?
                return false;
            }

            dataSave('삭제');
        });

        $("#btn_save").click(function(){

            if (!saveValidation("CstrmrMForm", true) )
                return false;

            saveFile('임시');
        });

        $("#btn_sanctn").click(function(){
            if(!$("#sanctnerNm").val()){
                warn("${msg.C100001359}");//결재 정보 선택 또는 결재 라인을 설정해주세요
                return false;
            }

            if (!saveValidation("CstrmrMForm") )
                return false;

            saveFile('상신');
        });

        $("#btnEntrpsResetSch, #btnEntrpsReset, #btnMtrilReset, #btnMtrilResetSch, #sanctnReset").click(function(){
            dialogReset(this.id);
        });

        $("#sAllUserBtn").click(function(){
            allUserData(function(allData) {
                AUIGrid.setGridData(allUserGridId, allData);
            });
        });

        $("#arrow3").click(function(){
            rightBtnClick();
        });

        $("#arrow4").click(function(){


            leftBtnClick();
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

        $("#btnRevert").click(function (e) {
            revert();
        });
    }

    function revert() {

        var param = $("#CstrmrMForm").serializeObject();
        param.sanctnInfoList = [];

        customAjax({
            url: '/qa/revertCstrmrDscntt.lims',
            data: param,
            elementIds: ['btn_save', 'btn_Exmnt', 'btn_sanctn', 'btn_new', 'btn_delete']
        }).then(function (res, status) {
            if (status === 'success') {
                alert('회수 되었습니다.');
                reset();
                doSearch();
            }
        });
    }


    //초기화
    function init() {

        //달력 세팅
        datePickerCalendar(["requstDteSt", "requstDteEn"], true, ["DD", -365],["DD",0]);
        datePickerCalendar(["comptDteSt", "comptDteEn"], true, ["DD", -365],["DD",0]);
        datePickerCalendar(["comptDte"], true, ["DD", 0]);
        datePickerCalendar(["requstDte"], true, ["DD", 0]);
        datePickerCalendar(["occrrncDte"], true, ["DD", 0]);

        //콤보 세팅

        ajaxSelect2Box({ajaxUrl: '/qa/getMtrilNmCombo.lims', elementId : 'mtrilSeqno', ajaxParam : {"bplcCode" : "${UserMVo.deptCode}"}})
        ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims', 'sanctnLineSeqno', { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000003" }, false, "${msg.C100000480}"); /* 선택 */
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'cstmrDscnttIpcrCode', queryParam : { 'upperCmmnCode': 'RS11' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'ocapSttusCode', queryParam : { 'upperCmmnCode': 'RS20' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/com/getCmmnCode.lims', name : 'm5e1Code', queryParam : { 'upperCmmnCode': 'RS27' }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'pDeptCode', queryParam : { 'bestInspctInsttCode': "${UserMVo.bplcCode}", "selectVal" : "${UserMVo.deptCode}" }, selectFlag : true});
        ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'chrgDeptCode', queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" }, selectFlag : true, "selectVal" : "${UserMVo.deptCode}"});
        ajaxJsonComboTrgetName({url : '/wrk/getDeptComboList.lims', name : 'chrgDeptCodeSch', queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" }, selectFlag : true, "selectVal" : "${UserMVo.deptCode}"});
        bindUserSelectbox('${UserMVo.deptCode}', 'chargerIdSch');
        bindUserSelectbox('${UserMVo.deptCode}', 'chargerId');

        $("select[name=chrgDeptCode]").on("change", function(e){
            bindUserSelectbox(e.target.value, $("#"+e.target.id).parent().next().next().children()[0].id);
        })

        //문서파일 세팅
        dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId: "#btnSave_file", maxFiles: 20, lang: "${msg.C100000867}" }); /* 첨부할 파일을 이 곳에 드래그하세요. */

        gridResize([cstrmrMGrid, allUserGridId, athUserGridId, cstrmrHistGrid]);

        progrsControll('init');
    }

    //저장 이벤트
    function saveFile(saveGbn) {

        //권한으로 제어 하기로함.
        /*if( "${UserMVo.deptCode}" != $("#chrgDeptCode").val()){
            alert("${msg.C100001340}"); //담당부서만 저장 가능합니다.
            return false;
        }*/

        var dropZone = dropZoneArea.getNewFiles();
        var dropZone_cnt = dropZone.length;

        if (dropZone_cnt > 0) {
            $("#btnSave_file").click();
            dropZoneArea.on("uploadComplete", function (event, fileIdx) {
                $("#atchmnflSeqno").val(fileIdx);
                dataSave(saveGbn);
            });
        } else {
            dataSave(saveGbn);
        }

    }

    //저장
    function dataSave(saveGbn) {
        var saveUrl = "";
        var message = "";
        if (saveGbn == '임시') {
            saveUrl = '/qa/insCstrmrInfo.lims';
            message = "${msg.C100000762}"; //저장되었습니다.
        }else if (saveGbn == '상신') {
            saveUrl = '/qa/insCstrmrApprovalM.lims';
            message = "${msg.C100001050}"; //저장 후 상신 하였습니다.
        }else if(saveGbn == '삭제'){
            $("#deleteAt").val("Y");
            saveUrl = '/qa/insCstrmrInfo.lims';
            message = '${msg.C100000462}'; // 삭제되었습니다.
        }

        var param = $("#CstrmrMForm").serializeObject();
        param.sanctnKndCode = 'CM05000003';
        var sanctnInfoList = $("input[name=sanctnInfoList]").val();
        param.sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];
        param = Object.assign(param, {
            "removeUserList" : AUIGrid.getRemovedItems(athUserGridId),
            "addUserList" : AUIGrid.getAddedRowItems(athUserGridId)
        });

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

    //문서 목록 조회
    function doSearch() {
        customAjax({
            "url" : "/qa/CstrmrDscnTTMList.lims",
            "data" : $("#searchFrm").serializeObject(),
            "successFunc" : function(result){
                reset()
                AUIGrid.setGridData(cstrmrMGrid, result);
            }
        })
    }

    //reset
    function reset() {
        pageReset(["CstrmrMForm"], [allUserGridId, athUserGridId, cstrmrHistGridId], [dropZoneArea]);
        progrsControll('init');
        $("#deleteAt").val("N");
        $("#comptDte").val(getFormatDate());
        $("#requstDte").val(getFormatDate());
        $("#occrrncDte").val(getFormatDate());
    }


    function setDialogForm(){
        //업체 팝업 (상세폼)
        dialogEntrps("btnEntrpsSeqno", null, "entrpsDialog", function(data){
            $("#entrpsNm").val(data["entrpsNm"]);
            $("#entrpsSeqno").val(data["entrpsSeqno"]);
        }, null);

        //제품 팝업(상세폼)
        dialogMtril("btnMtrilNm", null, "cstmrDMtril", function(item){
            $("#mtrilSeqno").val(item.mtrilSeqno);
            $("#mtrilNm").val(item.mtrilNm);
        },null,sessionObj,null,'Y');

        dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {

            var list = res.gridData;
            if (list.length > 0) {
                var sanctnerNm = getSanctnerNm(list);
                CstrmrMForm.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
                CstrmrMForm.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }
        }, null, "CM05000003");

        dialogExmnt({
            btnId: 'btn_Exmnt',
            functions: {
                getExmntSeqno : getExmntSeqno,
                getOtherKey : getOtherKey,
                init : reset
            },
            dialogId: 'cstmrDialogExmnt',
            url: '/qa/cstrmrSaveExmnt.lims'
        });
    }

    function getExmntSeqno(){
        return $("#exmntSeqno").val();
    }

    function getOtherKey(){
        return $("#cstmrDscnttSeqno").val();
    }

    function bindUserSelectbox(deptCode, trgetId, callback) {
        $.when(
            ajaxJsonComboBox('/com/getDeptToUserLsit.lims', trgetId, { "deptCode": deptCode }, true, "${msg.C100000480}", "${UserMVo.userId}")
        ).then(callback);
    }

    //전체사용자
    function allUserData(etcFunc) {
        var param = {
            "pUserNm" : $("#pUserNm").val(),
            "deptCode" : $("#pDeptCode").val(),
            "authorCode" : $("#authorCode").val(),
            "notInSeqno" : $("#cstmrDscnttSeqno").val()
        }
        getGridDataParam("<c:url value='/sys/getAllUserList.lims'/>",param, allUserGridId).then(function(data){
            if (etcFunc != undefined && typeof etcFunc == "function")
                etcFunc(data);
        });
    }

    // 체크 행 오른쪽 이동 버턴 클릭
    function rightBtnClick() {
        // 왼쪽 그리드의 체크된 행들 얻기
        var rows = AUIGrid.getCheckedRowItemsAll(allUserGridId);
        if (rows.length <= 0) {
            alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
            return false;
        }

        //중복 제거
        var existList = AUIGrid.getGridData(athUserGridId);
        for (var i = 0; i < existList.length; i++) {
            for (var j = 0; j < rows.length; j++) {
                if (existList[i].userId == rows[j].userId) {
                    rows.splice(j, 1);
                    AUIGrid.resetUpdatedItemById(athUserGridId, existList[i]._$uid, "d");
                }
            }
        }

        // 얻은 행을 오른쪽 그리드에 추가하기
        AUIGrid.addRow(athUserGridId, rows, "last");

        // 선택한 왼쪽 그리드 행들 삭제
        AUIGrid.removeCheckedRows(allUserGridId);
    };

    // 체크 행 아래로 이동 버턴 클릭
    function leftBtnClick() {
        // 상단 그리드의 체크된 행들 얻기
        var rows = AUIGrid.getCheckedRowItemsAll(athUserGridId);

        if (rows.length <= 0) {
            alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
            return;
        }

        if(!confirm("${msg.C100000461}")){//삭제 하시겠습니까?
            return false;
        }

        for (var i = 0; i < rows.length; i++) {
            var stat = getItemState(rows[i], athUserGridId);
            if (stat == "Added") { //추가된 상태의 행을 클릭시 전체 사용자의 삭제된 상태를 초기화하고 권한 사용자에서 로우 삭제.
                var clickindex = AUIGrid.getRowIndexesByValue(allUserGridId, "userId", rows[i]["userId"]);
                AUIGrid.restoreSoftRows(allUserGridId, clickindex);
            }
        }

        AUIGrid.removeCheckedRows(athUserGridId);

        AUIGrid.restoreSoftRows(allUserGridId, rows);


        removeAthUser();
    };

    function removeAthUser() {
        customAjax({
            "url" : "/qa/removeCstmrUser.lims",
            "data" : Object.assign({
                "removeUserList" : AUIGrid.getRemovedItems(athUserGridId),
                "cstmrDscnttSeqno" : $("#cstmrDscnttSeqno").val()
            }),
            "successFunc" :function(data,status,request){
                getCstmrUserList($("#cstmrDscnttSeqno").val());
            }

        })
    }

    function getCstmrUserList(param){
        getGridDataParam("/qa/getCstmrUserList.lims", {"cstmrDscnttSeqno" : param}, athUserGridId);
    }

    function getQlityHistList(item){
        var param = {
            "tableNm" : "RS_CSTMR_DSCNTT"
            , "seqno" : item.cstmrDscnttSeqno
        }
        getGridDataParam('/com//getQlityDocHistList.lims', param, cstrmrHistGridId);
    }







</script>
</tiles:putAttribute>
</tiles:insertDefinition>
