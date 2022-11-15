<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">문서 관리</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <h2><i class="fi-rr-apps"></i>${msg.C100000321}</h2> <!-- 문서 목록 -->
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
                    <th>${msg.C100000316}</th> <!-- 문서 구분 -->
                    <td><select id="docSeCodeSch" name="docSeCodeSch" class="wd100p"
                            style="min-width:10em;"></select></td>

                    <th>${msg.C100000802}</th> <!-- 제목 -->
                    <td><input type="text" id="sjSch" name="sjSch" class="wd100p schClass" style="min-width:10em;"></td>

                    <th>문서번호</th>
                    <td><input type="text" id="docNoSch" name="docNoSch" class="wd100p schClass"
                            style="min-width:10em;"></td>

                    <th>결재진행상태</th>
                    <td><select id="sanctnProgrsSittnCodeSch" name="sanctnProgrsSittnCodeSch" style="width: 100%;"></select></td>
                </tr>
            </table>
        </form>
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
    </div>
    <div class="subCon2">
        <div id="docMList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
    </div>
    <div class="mapkey">
        <label class="scarce">${msg.C100000343}</label><!-- 반려 -->
    </div>
    <form id="DocForm">
        <input type="text" id="crud" name="crud" value="C" style="display: none">
        <!-- 문서정보 시작 -->
        <div class="subCon1 mgT15" id="detail">
            <h2><i class="fi-rr-apps"></i>${msg.C100000323}</h2> <!-- 문서 정보 -->
            <div class="btnWrap">
                <button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
                <button type="button" id="btn_delete" class="delete" data-visible-code=["CM01000001","CM01000005"] style="display: none">삭제</button> 
                <button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"] style="display: none">회수</button>
                <button type="button" id="btn_save" class="save" data-visible-code=["CM01000001","CM01000004","CM01000005","init"]>저장</button> 
                <button type="button" id="btnExmnt" class="save" data-visible-code=["CM01000005"] style="display: none">검토</button>
                <button type="button" id="btn_save2" class="save" data-visible-code=["CM01000001","CM01000004","init"]>결재상신</button>
                
                <input type="hidden" id="btnDialogExmnt" class="save" value="검토">
            </div>
            <table style=" wkdth:100%;" class="subTable1">
                
                <input type="text" name="exmntSeqno" style="display: none"/> <%-- 검토 seqno --%>
                
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
                    <th class="necessary">${msg.C100000316}</th> <!-- 문서 구분 -->
                    <td><select id="docSeCode" name="docSeCode" class="wd100p" style="min-width:10em;" required></select></td>

                    <th class="necessary">문서 제목</th> <!-- 제목 -->
                    <td colspan="3">
                        <input type="text" id="sj" name="sj" class="wd100p" style="min-width:10em;" maxlength=500; required>
                        <input type="text" id="docSeqno" name="docSeqno" style="display: none">
                    </td>

                    <th class="necessary">문서번호</th>
                    <td><input type="text" id="docNo" name="docNo" class="wd100p" style="min-width:10em;" maxlength="20" required></td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100000728}</th> <!-- 작성일자 -->
                    <td><input type="text" id="writngDte" name="writngDte" class="wd100p dateChk" style="min-width:10em;" required></td>

                    <th class="necessary">제.개정일자</th> <!-- 제 * 개정 일자 -->
                    <td><input type="text" id="reformDte" name="reformDte" class="wd100p dateChk" style="min-width:10em;" required></td>

                    <th>제.개정번호</th> <!-- 제 * 개정 번호 -->
                    <td><input type="text" id="reformNo" name="reformNo" value="0" class="wd100p numChk" style="min-width:10em;" maxlength="4"readonly></td>

                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th>담당부서</th>
                    <td><select id="chrgDeptCode" name="chrgDeptCode" class="wd100p" style="min-width:10em;"></select></td>

                    <th>담당자</th>
                    <td><select id="chargerId" name="chargerId" class="wd100p" style="min-width:10em;"></select></td>

                    <th>${msg.C100000443}</th> <!-- 사용여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="useAt_Y" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                        <label><input type="radio" id="useAt_N" name="useAt" value="N">${msg.C100000442}</label> <!-- 사용안함 -->
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <th class="necessary">제.개정사유</th> <!-- 제 * 개정 사유 -->
                    <td colspan="8">
                        <textarea id="revnResn" name="revnResn" class="wd100p" rows="3" style="min-width:10em;" maxlength="4000" required></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th> <!-- 문서 파일 -->
                    <td colspan="8">
                        <div id="dropZoneArea"></div>
                        <input type="text" id="atchmnflSeqno" name="atchmnflSeqno" value="" style="display: none">
                        <input type="hidden" id="btnSave_file">
                    </td>
                </tr>
                <tr>
                    <th>결재정보</th>
                    <td colspan="3">
                        <select id="sanctnLineSeqno" name="sanctnLineSeqno"style="width: 25%;"></select>
                        <input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 51%;" readonly>
                        <input type="text" id="sanctnSeqno" name="sanctnSeqno" style="display: none">
                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn" data-visible-code=["CM01000001","CM01000004","init"]>결재라인 변경</button>
                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["CM01000001","CM01000004","init"]><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
                        
                        <input type="text" name="sanctnInfoList" style="display: none;">
                    </td>

                </tr> <!-- 히든 그리드 -->
                <tr id="dsUseTr" style="display:none">
                    <th>${msg.C100000938}</th> <!-- 폐기자 -->
                    <td colspan="3">
                        <input type="text" id="duspsnNm" name="duspsnNm" class="wd100p" style="min-width:10em;" disabled>
                        <input type="text" id="duspsnId" name="duspsnId" style="display: none">
                    </td>

                    <th id="thDsuseDte">${msg.C100000933}</th> <!-- 폐기일자 -->
                    <td colspan="3">
                        <input type="text" id="dsuseDte" name="dsuseDte" class="wd100p dateChk" style="min-width:10em;">
                    </td>
                </tr>
                <tr id="dsUseTr2" style="display:none">
                    <th id="thDsuseResn">${msg.C100000931}</th> <!-- 폐기 사유 -->
                    <td colspan="7">
                        <textarea id="dsuseResn" name="dsuseResn" class="wd100p" style="min-width:10em;" maxlength="4000"></textarea>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <!-- 문서 정보 종료 -->
    <div class="subCon1 mgT15" id="detail2">
        <h3>문서 제.개정 이력</h3>
        <div class="btnWrap">
            <button type="button" id="btn_choice_sub" class="search">${msg.C100000327}</button>	<!-- 문서파일보기 -->
        </div>
    </div>
    <div class="subCon2">
        <div id="docHistList" class="mgT15" style="width:100%; height:150px; margin:0 auto;"></div>
    </div>
    
    <div class="accordion_wrap mgT17">
        <div class="accordion ">문서 이력</div>
        <div id="acc1" class="acco_top mgT15" style="display: none">
            <h3>문서 이력</h3>
            <div class="subCon2">
                <div id="qualityDocHistoryGrid" style="height: 300px;"></div>
            </div>
        </div>
    </div>
</div>

<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript"></script>
<script>
    var docFormEl = document.querySelector('#DocForm');
    var visibleSupport = new VisibleSupport('data-visible-code');
    var sanctnLineControll = new SelectBoxControll(docFormEl.querySelector('[name=sanctnLineSeqno]'));
    var DocForm = 'docForm';
    var docMList = "docMList";
    var docHistList = 'docHistList';
    var qualityDocHistoryGrid = '#qualityDocHistoryGrid';
    //문서파일 세팅
    var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId: "#btnSave_file", maxFiles: 20, lang: "${msg.C100000867}" }); /* 첨부할 파일을 이 곳에 드래그하세요. */ 
    var saveKey = '';
    
    //결재 정보 INSERT시켜줄 데이터
    var lang = ${ msg }; // 기본언어
    $(document).ready(function () {
        setCombo();
        popUp();
        setButtonEvent();
        buildGrid();
        bindGridEvent();
    });

    //콤보 박스 초기화
    function setCombo() {

        ajaxJsonComboTrgetName({
            url : '/wrk/getDeptComboList.lims',
            name : 'chrgDeptCode',
            queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" },
            selectFlag : true
        });
        bindUserSelectbox('');
        ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims', 'sanctnLineSeqno', { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000001" }, false, "${msg.C100000480}"); /* 선택 */
        ajaxJsonComboBox('/com/getCmmnCode.lims', 'sanctnProgrsSittnCodeSch', { 'upperCmmnCode': 'CM01' }, true, null); /* 선택 */
        ajaxJsonComboBox('/com/getCmmnCode.lims', 'docSeCode', { 'upperCmmnCode': 'RS17' }, true, null); /* 선택 */
        ajaxJsonComboBox('/com/getCmmnCode.lims', 'docSeCodeSch', { 'upperCmmnCode': 'RS17' }, true, null); /* 선택 */
        
        //달력 세팅
        datePickerCalendar(["writngDte"], true, ["DD", 0]);
        datePickerCalendar(["reformDte"], false, ["DD", 0]);
    }
    function bindUserSelectbox(deptCode, callback) {
        ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', name : 'chargerId', queryParam : { "deptCode": deptCode }, selectFlag : true})
        .then(callback);
    }

    function popUp() {
        // 결재 팝업
        dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {
            var list = res.gridData;
            if (list.length > 0) {
                var sanctnerNm = getSanctnerNm(list);
                docFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
                docFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }

        }, null, "CM05000001"); //결재종류 문서
        
        dialogExmnt({
            btnId: 'btnDialogExmnt',
            functions: {
                getExmntSeqno: function () {
                    return docFormEl.querySelector('[name=exmntSeqno]').value;
                },
                getOtherKey: function () {
                    return docFormEl.querySelector('[name=docSeqno]').value;
                },
                init : function() {
                    docReset();
                }
            },
            dialogId: 'docDialogExmnt',
            url: '/qa/docSaveExmnt.lims'
        });
        
        // 문서미리보기 팝업
        dialogGridFileDownload("btn_choice_sub", "fileDownload","#docHistList");
    }

    //문서 목록 그리드 세팅
    function buildGrid() {
        var col = [];
        var col2 = [];
        var qualityDocCol = [];
        
        auigridCol(col2);
        auigridCol(col);
        auigridCol(qualityDocCol);
        
        var cusPros = {
            editable: false, // 편집 가능 여부 (기본값 : false)
            selectionMode: "multipleCells",// 셀 선택모드 (기본값: singleCell)
            enableCellMerge: true,
            rowStyleFunction: function (rowIndex, item) {
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "grid-scarce" : "";
            }
        }

        col.addColumnCustom("docSeCodeNm", "문서구분");/* 문서 구분 */
        col.addColumnCustom("sj", "제목"); 				/* 제목 */
        col.addColumnCustom("reformDte", "제.개정일자"); 		/* 제 * 개정 일자 */
        col.addColumnCustom("reformNo", "제.개정번호"); 		/* 제 * 개정 번호 */
        col.addColumnCustom("revnResn", "제.개정사유");		/* 제 * 개정 사유 */
        col.addColumnCustom("chrgDeptCodeNm", "담당부서");		/* 제 * 개정 사유 */
        col.addColumnCustom("chargerNm", "담당자");		/* 제 * 개정 사유 */
        col.addColumnCustom("duspsnNm", "폐기자"); 		/* 폐기자 */
        col.addColumnCustom("dsuseDte", "${msg.C100000933}"); 		/* 폐기 일자 */
        col.addColumnCustom("dsuseResn", "${msg.C100000931}");		/* 폐기 사유 */
        col.addColumnCustom("docNo", "${msg.C100000315}");  	/* 문서 관리번호 */
        col.addColumnCustom("updVer", "${msg.C100000118}");  		/* 개정 버튼 */
        col.addColumnCustom("dsUse", "${msg.C100000929}");  			/* 폐기 버튼*/
        col.addColumnCustom("sanctnProgrsSittnCodeNm", "결재진행상태");  			/* 폐기 버튼*/
        col.buttonRenderer(["updVer"], function reformEvent(rowIndex, columnIndex, value, item, dataField) {
                var gridData = AUIGrid.getSelectedItems(docMList);
                if (gridData.length > 0) {
                    alert("데이터 수정 후 저장 또는 결재 상신 버튼을 눌러야 완료됩니다.");
                } else {
                    return;
                }

                    docMListEvent(gridData[0], function () {
                        $("#crud").val("R");
                        //작성 일자, 제 * 개정 일자, 제 * 개정 번호 비활성화
                        disabledEvent();
                        $("#dsUseTr").css("display", "none");
                        $("#dsUseTr2").css("display", "none");
                        $("#btn_save").css("display", "");
                        $("#btn_save2").css("display", "");
                        $("#btnExmnt").css("display", "");
                        $("#sanctnLineChg").css("display", "");
                        $("#sanctnReset").css("display", "");

                        save2btnEv("${msg.C100000118}");
                        var reformNo = Number($("#reformNo").val());
                        reformNo = reformNo + 1;
                        //제 개정 번호 컬럼은 4자리
                        if (reformNo > 9999) {
                            reformNo = reformNo - 1;
                        } else {
                            $("#reformNo").val(reformNo);
                        }
                        //드랍존 새로고침
                        dropZoneArea.clear();
                        $("#atchmnflSeqno").val("");
                        $("#reformDte").val("");
                        $("#sanctnReset").click();
                    }, function () {
                        sanctnLineControll.optionDisableClear();
                    });
                
            }, false, "${msg.C100000118}", null,
            function (rowIndex, columnIndex, value, item, dataField) {
                if (item.sanctnProgrsSittnCode == 'CM01000001' || item.sanctnProgrsSittnCode == 'CM01000002'
                    || item.sanctnProgrsSittnCode == 'CM01000003' || item.sanctnProgrsSittnCode == 'CM01000004'
                    || item.sanctnProgrsSittnCode == '' || item.sanctnProgrsSittnCode == null) {
                    return true;
                }
                else if (item.sanctnProgrsSittnCode == 'CM01000005' && (item.duspsnId != null && item.duspsnId != "")) {
                    return true;
                }
                else {
                    return false;
                }
            });
        //폐기버튼
        col.buttonRenderer(["dsUse"],
            function dsUseEvent() {
                var gridData = AUIGrid.getSelectedItems(docMList);
                if (gridData.length > 0) {
                    alert("데이터 수정 후 저장 또는 결재 상신 버튼을 눌러야 완료됩니다.");
                } else {
                    return;
                }

                docMListEvent(gridData[0], function () {
                    $("#crud").val("N");
                    disabledEvent();
                    dropZoneArea.getFiles(gridData[0].item.atchmnflSeqno);
                    $("#dsUseTr").css("display", "revert");
                    $("#dsUseTr2").css("display", "revert");
                    $("#duspsnNm").prop("disabled", true);
                    $("#thDsuseResn").addClass("necessary")
                    $("#thDsuseDte").addClass("necessary")
                    $("#dsuseResn").prop("required", true);
                    $("#dsuseDte").prop("required", true);

                    $("#duspsnNm").val("${UserMVo.userNm}");
                    $("#duspsnId").val("${UserMVo.userId}");
                    $("#btn_save").css("display", "");
                    $("#btn_save2").css("display", "");
                    $("#btnExmnt").css("display", "");
                    $("#sanctnLineChg").css("display", "");
                    $("#sanctnReset").css("display", "");

                    save2btnEv("${msg.C100000929}");
                    datePickerCalendar(["dsuseDte"], true, ["DD", 0]);
                    $("#sanctnReset").click();
                }, function () {
                    sanctnLineControll.optionDisableClear();
                });
                
            }, false, "${msg.C100000929}", null,
            function (rowIndex, columnIndex, value, item, dataField) {
                if (item.sanctnProgrsSittnCode == 'CM01000001' || item.sanctnProgrsSittnCode == 'CM01000002'
                    || item.sanctnProgrsSittnCode == 'CM01000003' || item.sanctnProgrsSittnCode == 'CM01000004'
                    || item.sanctnProgrsSittnCode == '' || item.sanctnProgrsSittnCode == null) {
                    return true;
                }
                else if (item.sanctnProgrsSittnCode == 'CM01000005' && (item.duspsnId != null && item.duspsnId != "")) {
                    return true;
                }
                else {
                    return false;
                }
            });


        col2.addColumnCustom("docSeqno", "문서 일련번호", "*", false); 				/* 문서 일련번호  */
        col2.addColumnCustom("docSeCode", "문서 구분 코드", "*", false); 			/* 문서 구분 코드 */
        col2.addColumnCustom("docSeCodeNm", "${msg.C100000316}"); 		/* 문서 구분 */
        col2.addColumnCustom("reformNo", "${msg.C100000799}"); 		/* 제 * 개정 번호 */
        col2.addColumnCustom("sj", "${msg.C100000802}"); 			/* 제목 */
        col2.addColumnCustom("docNo", "${msg.C100000315}"); 	/* 문서 관리번호 */
        col2.addColumnCustom("writngDte", "${msg.C100000728}"); 		/* 작성일자 */
        col2.addColumnCustom("reformDte", "${msg.C100000801}"); 		/* 제 * 개정 일자 */
        col2.addColumnCustom("atchmnflSeqno", "첨부파일 일련번호", "*", false); /* 첨부파일 일련번호 */
        col2.addColumnCustom("revnResn", "${msg.C100000800}"); 		/* 제 * 개정 사유 */

        var cusPros2 = {
            editable: false, // 편집 가능 여부 (기본값 : false)
            selectionMode: "singleCell"// 셀 선택모드 (기본값: singleCell)
        }
        qualityDocCol
                .addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)		// 품질문서이력 일렬번호
                .addColumnCustom('tableNm',lang.C100000973,'*',true,false)              // 테이블명
                .addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)            // 테이블 주석명
                .addColumnCustom('columnNm',lang.C100000975,'*',true,false)             // 컬럼명
                .addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)           // 컬럼 주석명
                .addColumnCustom('seqno','일련번호','*',false,false)						// 일련번호
                .addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)          // 변경 전
                .addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)        // 변경 후
                .addColumnCustom('changerNm',"최종변경자",'*',true,false)              	// 최종 변경자
                .addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false);          // 최종 변경 일시
        
        docMList = createAUIGrid(col, docMList, cusPros);
        docHistList = createAUIGrid(col2, "docHistList", cusPros2);
        createAUIGrid(qualityDocCol, qualityDocHistoryGrid);
        
        gridResize([docMList, docHistList, qualityDocHistoryGrid]);
    }

    //그리드 이벤트 선언
    function bindGridEvent() {
        //문서목록 그리드 더블클릭
        AUIGrid.bind(docMList, "ready", function() {
            gridColResize(docMList, "2");
            if ( !!saveKey ){
                gridSelectRow(docMList, "docSeqno", [saveKey]);
            }
        });
        AUIGrid.bind(docMList, "cellDoubleClick", function (event) {

            if (event.item.duspsnId != null && event.item.duspsnId != "") {
                $("#dsUseTr").css("display", "revert");
                $("#dsUseTr2").css("display", "revert");
                $("#thDsuseResn").addClass("necessary")
                $("#thDsuseDte").addClass("necessary")
                $("#dsuseResn").prop("required", true);
                $("#dsuseDte").prop("required", true);
                save2btnEv("${msg.C100000929}");
            }
            else {
                $("#dsUseTr").css("display", "none");
                $("#dsUseTr2").css("display", "none");
                $("#dsuseResn").prop("required", false);
                $("#dsuseDte").prop("required", false);
                save2btnEv(" ");
            }

            docMListEvent(event);
        });
    }

    //버튼 이벤트
    function setButtonEvent() {

        docFormEl.querySelector('select[name=chrgDeptCode]').addEventListener('change', function (e) {
            bindUserSelectbox(e.target.value);
        });

        $("#sanctnLineSeqno").change(function (e) {
            customAjax({
                url: '/wrk/getSanctnerList.lims',
                data: {sanctnLineSeqno: e.target.value},
            }).then(function (res) {
                if (res.length > 0) {
                    var sanctnerNm = getSanctnerNm(res);
                    docFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(res);
                    docFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
                } else {
                    warn('선택된 결재자가 없습니다.');
                }
            });
        })
        
        docFormEl.querySelector('#btnExmnt').addEventListener('click', function () {
            var docSeqnoValue = docFormEl.querySelector('[name=docSeqno]').value;
            if (!!docSeqnoValue) {
                docFormEl.querySelector('#btnDialogExmnt').click();
            } else {
                warn('감사 정보 저장 후 검토할 수 있습니다.');
            }
        });

        //저장
        $("#btn_save").on("click", function () {

            var docSeCode = docFormEl.querySelector('#docSeCode');
            var sj = docFormEl.querySelector('#sj');
            var docNo = docFormEl.querySelector('#docNo');
            if (!!!docSeCode.value) {
                docSeCode.focus();
                warn("문서 구분 (은)는 필수 입력 항목입니다.");
                return false;
            }
            if (!!!sj.value) {
                sj.focus();
                warn("문서 제목 (은)는 필수 입력 항목입니다.");
                return false;
            }
            if (!!!docNo.value) {
                docNo.focus();
                warn("문서 번호 (은)는 필수 입력 항목입니다.");
                return false;
            }
            
            saveValid('임시');
        });
        
        //상신
        $("#btn_save2").on("click", function () {
            //필수 값 체크
            if (!saveValidation(docFormEl.id)) return false;
            if (!sanctnValid()) {
                warn('결재 정보 선택 또는 결재 라인을 설정해주세요.')
                return;
            }
            saveValid('상신');
        });

        //신규 버튼
        $("#btn_new").click(function () {
            init();
        });

        //삭제 버튼
        $("#btn_delete").click(function () {
            var gridData = AUIGrid.getSelectedItems(docMList);

            if (gridData.length == 0) {
                alert("${msg.C100000491}"); /* 선택된 문서 목록이 없습니다. */
                return;
            }
            if (confirm("${msg.C100000461}")) { /* 삭제하시겠습니까? */
                $("#crud").val("D");
                dataSave('임시');
            }
        });
        
        docFormEl.querySelector('#btnRevert').addEventListener('click', function (e) {
            revert();
        });

        $("#sanctnReset").click(function () {
            dialogReset(this.id);
        })
    }

    function progrsControll(sanctnProgrsSittnCode){

        if (sanctnProgrsSittnCode === 'CM01000001' || sanctnProgrsSittnCode === 'CM01000004' || sanctnProgrsSittnCode === 'init') {
            // 작성중, 반려, 초기화
            dropZoneArea.getFiles(docFormEl.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControll.optionDisableClear();
            
        } else if (sanctnProgrsSittnCode === 'CM01000005') {
            //결재 완료
            dropZoneArea.getFiles(docFormEl.querySelector('input[name=atchmnflSeqno]').value);
            dropZoneArea.readOnly(false);
            sanctnLineControll.notSelectedOptionDisable(true);
            
        } else {
            // 결재 대기, 대기예정
            dropZoneArea.getFiles(docFormEl.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
            dropZoneArea.readOnly(true);
            sanctnLineControll.notSelectedOptionDisable(true);
        }

        visibleSupport.displayOfCode(sanctnProgrsSittnCode);
    }

    function save2btnEv(flag) {
        $("#btn_save2").text(flag + " ${msg.C100000158}");
    }
    //초기화
    function init() {
        saveKey = '';
        AUIGrid.clearGridData(docHistList);
        AUIGrid.clearGridData(qualityDocHistoryGrid);
        disabledClear();
        docFormEl.reset();
        docReset();
        progrsControll('init');
    }

    function disabledClear() {
        var elements = docFormEl.elements;
        for (var i = 0; i < elements.length; i++) {
            var el = elements[i];
            el.disabled = false;
        }
    }

    //저장 이벤트
    function saveDoc(saveGbn) {
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
        
        var saveUrl = (saveGbn === '임시') ? "<c:url value='/qa/insDocM.lims'/>" : "<c:url value='/qa/insConfirmM.lims'/>";

        var sanctnInfoList = docFormEl.querySelector('input[name=sanctnInfoList]').value;
            sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];

        var param = docFormEl.toObject(true);
            param.sanctnKndCode = 'CM05000001'; // 결재종류 문서
            param.sanctnInfoList = sanctnInfoList;
            
        if (saveGbn === '상신') {
		    param.docSeCodeNm = getSeletedOptionText(docFormEl.querySelector('[name=docSeCode]'));
		    param.chrgDeptCodeNm = getSeletedOptionText(docFormEl.querySelector('[name=chrgDeptCode]'));
		    param.chargerNm = getSeletedOptionText(docFormEl.querySelector('[name=chargerId]'));
        }

        customAjax({
            url: saveUrl,
            data: param,
            elementIds: ['btn_delete', 'btnRevert', 'btn_save', 'btn_save2']
        }).then(function (res, status) {
            if (status === 'success') {
                saveKey = res.docSeqno;
                if ($("#crud").val() == "D") {
                    success('${msg.C100000462}'); /* 삭제되었습니다. */
                } else {
                    success("${msg.C100000762}"); /* 저장 되었습니다. */
                }
                searchDoc();
                docReset();
                save2btnEv("");

            } else {
                err('${msg.C100000597}'); /* 에러가 발생하였습니다. */
                docReset();
                save2btnEv("");
            }
        });
    }
    
    function revert() {
        
        var param = docFormEl.toObject(true);
            param.sanctnInfoList = [];

        customAjax({
            url: '/qa/revertDoc.lims',
            data: param,
            elementIds: ['btn_delete', 'btnRevert', 'btn_save', 'btn_save2']
        }).then(function (res, status) {
            if (status === 'success') {
                saveKey = res.docSeqno;
                alert('회수 되었습니다.');
                docReset();
                searchDoc();
            }
        });
    }
    
    function sanctnValid() {
        return !!docFormEl.querySelector('[name=sanctnerNm]').value
    }

    //문서 목록 조회
    function searchDoc() {
        //재 * 개정번호, 문서 관리 번호, 문서명 활성화
        disabledEvent();
        //문서 목록 조회
        getGridDataForm("/qa/getDocList.lims", "searchFrm", docMList);
    }
    
    function getQualityDocList(docSeqno){
        getGridDataParam('/com/getQlityDocHistList.lims', {seqno : docSeqno, tableNm : "RS_DOC"}, qualityDocHistoryGrid);
    }

    function doSearch(e) {
        saveKey = '';
        searchDoc();
    }

    function docMListEvent(event, func, gridCallback) {
        $("#docNo").val(event.item.docNo);
        
        var histParams = { docNo: $("#docNo").val() };
        
        bindUserSelectbox(event.item.chrgDeptCode, function () {
            detailAutoSet({
                item: event.item,
                targetFormArr: [docFormEl.id],
                successFunc: function () {
                    $("#crud").val("U");
                    progrsControll(event.item.sanctnProgrsSittnCode);

                    if (typeof gridCallback === 'function') {
                        gridCallback();
                    }
                }
            });
            
            getGridDataParam("<c:url value='/qa/getDocHistList.lims'/>", histParams, docHistList);
            if (func != null && typeof func == "function") {
                func();
            }

            getQualityDocList(event.item.docSeqno);
            
            disabledEvent();
        });
    }

    //문서 관리번호 중복 체크
    function saveValid(gbn) {
        var paramUrl = "<c:url value='/qa/docNoChk.lims'/>";
        var crud = $("#crud").val();
        if (crud != "C" && crud != "U") {
            saveDoc(gbn);
        } else {
            customAjax({
                "url": paramUrl,
                "data": {
                    docNo: $("#docNo").val(),
                    docSeqno: $("#docSeqno").val(),
                    crud: crud
                },
                "successFunc": function (data) {
                    if (data > 0) {
                        warn("${msg.C100000200}");
                        return false;
                    }
                    else {
                        saveDoc(gbn)
                    }
                }
            })
        }
    }
    
    //개정 버튼 눌렀을때 이벤트
    //crud 에 따라서 disabled 유무
    function disabledEvent() {
        if ($("#crud").val() == "C") {
            $("#reformNo").prop("disabled", false);
            $("#sj").prop("disabled", false);
            $("#docNo").prop("disabled", false);
            $("#docSeCode").prop("disabled", false);
        } else if ($("#crud").val() == "U") {

            $("#sj").prop("disabled", true);
            $("#docNo").prop("disabled", true);
            $("#docSeCode").prop("disabled", true);

            var gridData = AUIGrid.getGridData(docHistList);

            if (gridData.length > 0) {
                $("#reformNo").prop("disabled", true);
            }
            else {
                $("#reformNo").prop("disabled", false);
            }
        } else if ($("#crud").val() == "R") {
            $("#reformNo").prop("disabled", true);
            $("#sj").prop("disabled", true);
            $("#docNo").prop("disabled", true);
            $("#docSeCode").prop("disabled", true);
        } else {
            $("#reformNo").prop("disabled", false);
            $("#sj").prop("disabled", false);
            $("#docNo").prop("disabled", false);
            $("#docSeCode").prop("disabled", false);
        }
    }

    //reset
    function docReset() {
        //form 리셋
        docFormEl.reset();
        $("#btn_save").css("display", "inline-block");
        $("#btn_save2").css("display", "inline-block");
        save2btnEv("");
        $("#btn_delete").css("display", "inline-block");
        $("#dsUseTr").css("display", "none");
        $("#dsUseTr2").css("display", "none");
        $("#thDsuseResn").removeClass("necessary")
        $("#thDsuseDte").removeClass("necessary")
        $("#dsuseResn").prop("required", false);
        $("#dsuseDte").prop("required", false);
        $("#duspsnNm").prop("disabled", true);
        
        searchDoc();
        //재 * 개정번호, 문서 관리 번호, 문서명 활성화
        disabledEvent();
        progrsControll('init');
        //이력 그리드 초기화
        AUIGrid.clearGridData(docHistList);
        AUIGrid.clearGridData(qualityDocHistoryGrid);

        //파일 리셋
        dropZoneArea.clear();
        dropZoneArea.setFileIdx("");
    }

</script>
</tiles:putAttribute>
</tiles:insertDefinition>