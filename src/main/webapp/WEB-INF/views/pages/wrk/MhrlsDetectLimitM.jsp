<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">시험항목별 DL 관리</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000556}</h2> <!-- 시험항목 DL 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
        <!-- Main content -->
        <form id="searchFrm" onsubmit="return false;">
            <table class="subTable1" style="width:100%;">
               <colgroup>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
				</colgroup>
                <tr>
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td><select class="schClass" name="bplcCodeSch" id="bplcCodeSch" style="min-width:10em;">
							<option value="">${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>

					<th>${msg.C100000745}</th> <!-- 장비 분류 -->
					<td>
                        <select id="eqpmnClCodeSch" name="eqpmnClCodeSch" style="min-width:10em;"></select>
                    </td>

                    <th>${msg.C100000560}</th> <!-- 시험항목 명 -->
                    <td><input type="text" name="expriemNmSch" class="schClass"></td>

                    <th>${msg.C100000443}</th> <!-- 사용여부 -->
                    <td style="text-align:left;">
                        <label><input type="radio" name="useAtSch" value="">${msg.C100000779}</label> <!-- 전체 -->
                        <label><input type="radio" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                        <label><input type="radio" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용 안함 -->
                    </td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100000774}</th><!-- 적용일 -->
                    <td>
                        <input type="text" id="applcBeginDteSch" name="applcBeginDteSch"  class="wd6p schClass dateChk" style="min-width: 6em;" required>
                        <span>~</span>
                        <input type="text" id="applcEndDteSch" name="applcEndDteSch"  class="wd6p schClass dateChk" style="min-width: 6em;" required value="9999-12-31">
                    </td>

                    <th>${msg.C100000143}</th> <!-- 검출 한계 미만 값 -->
                    <td><input type="text" name="detectLimitBeloValueSch" class="schClass"></td>

                    <th>${msg.C100000030}</th> <!-- COA 표기 값 -->
                    <td><input type="text" name="coaMarkValueSch" class="schClass"></td>
                    <td colspan="2"></td>
                </tr>
            </table>
        </form>
	</div>

    <div class="subCon2">
         <div id="expriemGrid" style="height: 300px;"></div>
    </div>
	
	</br>
	<div class="subCon1" id="detail">
		<h2><i class="fi-rr-apps"></i>${msg.C100000557}</h2> <!-- 시험항목 DL 상세 정보 -->

		<div class="btnWrap">
			<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
        
		<form id="dlForm" onsubmit="return false;">

            <!-- 검출한계 seano -->
			<input type="text" id="detectLimitSeqno" name="detectLimitSeqno" style="display: none;">
			<input type="text" id="eqpmnInspctCrrctSeqno" name="eqpmnInspctCrrctSeqno" style="display: none;">
			<input type="text" id="bplcCode" name="bplcCode" style="display: none;">

			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
				</colgroup>
				<tr>
					<th class="necessary">${msg.C100000745}</th> <!-- 장비분류 -->
					<td><select id="eqpmnClCode" name="eqpmnClCode" readonly required></select></td>

					<th class="necessary">${msg.C100000560}</th> <!-- 시험항목 -->
					<td>
						<input type="text" id="expriemNm" name="expriemNm" style="width:calc( 100% - 56px )" readonly required>
						<input type="text" id="expriemSeqno" name="expriemSeqno" style="display: none">
						<button type="button" id="btnAddExpriemAllList" name="btnAddExpriemAllList" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
					</td>

                    <th class="necessary">${msg.C100000143}</th> <!-- 검출한계 미만값 -->
                    <td><input type="text" id="detectLimitBeloValue" name="detectLimitBeloValue" class="numChkPoint" maxlength="100" required></td>

                    <th class="necessary">${msg.C100000030}</th> <!-- COA 표기값 -->
                    <td><input type="text" id="coaMarkValue" name="coaMarkValue" class="numChkPoint" maxlength="100" required></td>
				</tr>

				<tr>
					<th class="necessary">${msg.C100000773}</th> <!-- 적용 시작 일자 -->
					<td><input type="text" id="applcBeginDte" name="applcBeginDte" class="dateChk" required></td>

					<th class="necessary">${msg.C100000775}</th> <!-- 적용 종료 일자 -->
					<td><input type="text" id="applcEndDte" name="applcEndDte" class="dateChk" required></td>

                    <th>${msg.C100000443}</th> <!-- 사용여부 -->
                    <td colspan="2">
                        <label><input type="radio" id="yuseAt" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                        <label><input type="radio" id="nuseAt" name="useAt" value="N" >${msg.C100000449}</label> <!-- 사용 안함 -->
                    </td>
				</tr>
		         <tr>
					<th>${msg.C100000425}</th> <!-- 비고 -->
		            <td colspan="7">
		              <textarea id="rm" name="rm" rows="4" style="width:100%; vertical-align:bottom;" maxlength="4000"></textarea>
		            </td>
				</tr>
			</table>
		</form>
	</div>
</div>
</tiles:putAttribute>
<tiles:putAttribute name="script">

<script>

    /**
     * 자재별 버전별, CL 결과 관리
     * @author shs
     */

	var expriemGrid = 'expriemGrid';
	var lang = ${msg}; // 기본언어
	$(function() {
	    renderGrid();
        gridEvent();
        buttonEvent();
        setSelect();
		dialogSetting();
	});
	
	function setSelect(){

        //조회조건 날짜
        datePickerCalendar(["applcBeginDteSch"],true,["YY",-1]);
        datePickerCalendar(["applcEndDteSch"],true);
        datePickerCalendar(["applcBeginDte","applcEndDte"],false);

        
        ajaxJsonComboBox('/com/getCmmnCode.lims','eqpmnClCodeSch',{"upperCmmnCode" : "RS02"}, false,"${msg.C100000480}"); //장비분류
        ajaxJsonComboBox('/com/getCmmnCode.lims','eqpmnClCode',{"upperCmmnCode" : "RS02"}, false,"${msg.C100000480}"); //장비분류
	}
	
 	// 그리드 생성
	function renderGrid() {
	    //그리드 컬럼 담을 배열 정의
	    var expriemGridCol = [];
	    auigridCol(expriemGridCol);

	    expriemGridCol.addColumnCustom("detectLimitSeqno"       , "detectLimitSeqno"    , null, false, false) /* 검출한계 일련번호  */
	                    .addColumnCustom("eqpmnClCode"          , "eqpmnClCode"         , null, false, false) /* RS02 장비분류코드 */
	                    .addColumnCustom("eqpmnClCodeNm"        , "${msg.C100000745}"   , null, true, false) /* 장비 분류 */
	                    .addColumnCustom("expriemNm"            , "${msg.C100000555}"   , null, true, false) /* 시험항목 */
	                    .addColumnCustom("detectLimitBeloValue" , "${msg.C100000143}"   , null, true, false) /* 검출한계 미만값 */
	                    .addColumnCustom("coaMarkValue"         , "${msg.C100000030}"   , null, true, false) /* COA표기값 */
	                    .addColumnCustom("applcBeginDte"        , "${msg.C100000773}"   , null, true, false) /* 적용시작일자 */
	                    .addColumnCustom("applcEndDte"          , "${msg.C100000775}"   , null, true, false) /* 적용종료일자 */
	                    .addColumnCustom("useAt"                , "${msg.C100000443}"   , null, true, false) /* 사용여부 */
                        ;
	    
	    //그리드 생성
	    expriemGrid = createAUIGrid(expriemGridCol, expriemGrid);

        // 그리드 리사이즈.
		gridResize([expriemGrid]);
 	}

    //조회
    function getDLExpriems(){
        getGridDataForm('<c:url value="/wrk/getDLExpriems.lims"/>', "searchFrm", expriemGrid);
        // form 초기화
        document.getElementById('dlForm').reset();
    }
    
    // enter key event
    function doSearch(){

        if(!saveValidation('searchFrm')) return false;
        getDLExpriems();
    }
	
	function buttonEvent(){
	    //조회
	    $('#btnSearch').click(function() {
		    if(!saveValidation('searchFrm')) return false;
		    getDLExpriems();
		})
	    
	    //저장
		$('#btnSave').click(function(){
			saveExprDl();
	    })

		$('#btnNew').click(function(){
			pageReset(['dlForm']);
	    });
	}

	function gridEvent() {
		// 그리드 칼럼 리사이즈
		AUIGrid.bind(expriemGrid, "ready", function(event) {
			gridColResize([expriemGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
		});
		
	    AUIGrid.bind(expriemGrid, "cellDoubleClick", function(event) {
            detailAutoSet({item : event.item,targetFormArr : ["dlForm"]});
	    });
	}

	function saveExprDl() {

		//필수값 체크
		if(!saveValidation("dlForm")){
			return false;
		}

		var ajax = customAjax({
			url : '/wrk/saveExprDl.lims'
			,data : $("#dlForm").serializeObject()
			,showLoading : true
			,elementIds : ["btnSave"]
		});

		ajax.then(function(data){
			if (data > 0) {
				getDLExpriems();
				success("${msg.C100000762}"); /* 저장 되었습니다. */
				document.getElementById('dlForm').reset();
			}else {
				err("${msg.C100000597}");  /* 오류가 발생했습니다. */
			}
		});
	}

	function dialogSetting(){
		dialogAddExpriemEditList('btnAddExpriemAllList', { pageNm: 'Request' }, 'Expriem', '#' + expriemGrid, function(item) {
			if (item){
				$("#expriemNm").val(item[0].expriemNm);
				$("#expriemSeqno").val(item[0].expriemSeqno);
			}
		}, null, false);
	}
</script>
<!--  script 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>
