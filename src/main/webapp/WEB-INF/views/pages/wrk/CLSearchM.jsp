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
		<h2><i class="fi-rr-apps"></i>${msg.C100000718}</h2> <!-- 자재 목록 -->
		<div class="btnWrap">
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
					<th>제품 구분</th>
					<td>
						<select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
							<option value="">${msg.C100000480}</option> <!-- 선택 -->
						</select>
						<input type="hidden" id="bplcCodeSch" name="bplcCodeSch" value="1000">
					</td>
					<!-- 자재명 -->
					<th>${msg.C100000717}</th>
					<td><label><input type="text" class="schClass" name="mtrilNmSch"></label></td>

					<!-- 자재코드 -->
					<th>${msg.C100000725}</th>
					<td><label><input type="text" class="schClass" name="mtrilCodeSch"></label></td>

					<!-- 사용여부 -->
					<th>${msg.C100000443}</th>
					<td style="text-align: left;">
						<label><input type="radio" name="useAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
						<label><input type="radio" name="useAtSch" value="Y">${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" name="useAtSch" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="subCon2">
        <!-- 자재 그리드 -->
		<div id="mtrilGrid" class="wd100p" style="height: 300px;"></div>
	</div>
	
    <div style="display: flex;">
        <div class="wd24p mgT30">
            <div class="subCon1">
                <h3>${msg.C100000366}</h3> <!-- 버전 상세 정보 -->
            </div>
            <div class="subCon2">
                <!-- 버전 그리드 -->
                <div id="versionGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>
        
        <div class="wd5p mgT30"></div>

        <div class="wd71p mgT30">
            <div class="subCon1 wd100p">
                <h3>${msg.C100000367}</h3> <!-- 버전별 CL 상세 정보 -->
                <div class="btnWrap">
                    <button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
                </div>
            </div>
            <div class="subCon2 wd100p">
                <!-- 버전별 결과 그리드 -->
                <div id="versionResultGrid" class="grid wd100p" style="height: 300px;"></div>
            </div>
        </div>
    </div>
</div>
<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>

    /**
     * 자재별 버전별, CL 결과 관리
     * @author shs
     */

    // AUIGrid 생성 후 반환 ID
    var mtrilGrid = "mtrilGrid"; // 자재 목록 그리드
    var versionGrid = "versionGrid"; // 버전 상세 정보 그리드
    var versionResultGrid = "versionResultGrid"; // 버전별 CL 상세 정보 그리드
    
    var lang = ${msg};
    var saveKey = "";
    var versionSaveKey = "";
    window.onload = function() {
        renderGrid();
        gridEvent();
        buttonEvent();
        combo();
    };
	
	//콤보박스 생성
	function combo() {
        ajaxJsonComboBox('/com/getCmmnCode.lims', "cntnrSeCodeSch",{ "upperCmmnCode" : "SY10", "deptCode" : "${UserMVo.deptCode}" }, true); // 용기 타입
        ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSeCodeSch",{ "upperCmmnCode" : "SY20", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형

	}
	
	//그리드 생성
	function renderGrid(){

        //칼럼 설정
        var columnLayout = {
            mtrilGrid : [],
            versionGrid : [],
            versionResultGrid : []
        }

		
		auigridCol(columnLayout.mtrilGrid); //제품목록 그리드
        auigridCol(columnLayout.versionGrid); //버전 상세 정보 그리드
		auigridCol(columnLayout.versionResultGrid); //버전별 CL 상세 정보 그리드

        columnLayout.mtrilGrid
        .addColumnCustom("mmnySeCodeNm" , "${msg.C000000055}"   ,"*",false) /* 자사 구분 */
        .addColumnCustom("mmnySeCode"   , "${msg.C000000055}"   ,"*",false)
		.addColumnCustom("prductSeCode" , "제품 구분"   ,"*",false) /* 제품 구분*/
		.addColumnCustom("prductSeCodeNm" , "제품 구분"   ,"*",true) /* 제품 구분*/
        .addColumnCustom("inspctInsttNm", "${msg.C100000432}"   ,"*",false) /* 사업장 */
        .addColumnCustom("mtrilTyCodeNm", "${msg.C100000727}"   ,"*",false) /* 자재유형타입 */
        .addColumnCustom("mtrilNm"      , "${msg.C100000717}"   ,"*",true) /* 자재 명 */
        .addColumnCustom("mtrilCode"    , "${msg.C100000725}"   ,"*",true) /* 자재 코드 */
        .addColumnCustom("useAt"      , "${msg.C100000443}"   ,"*",true) /* 사용 여부*/
        .addColumnCustom("lastExecutDte" , "${msg.C100001367}"   ,"*",true) /* 마지막 산정일 */
        ;

		columnLayout.versionGrid
        .addColumn("ver", "${msg.C100000365}","*",true) /* 버전 */
        .addColumn("mtrilClVerSeqno", "mtrilClVerSeqno","*",false) /* 제품 CL버전 일렬번호 */
        ;
		
		columnLayout.versionResultGrid
        .addColumnCustom("mtrilClVerSeqno"   ,"mtrilClVerSeqno","*",false) /* CL버전 일렬번호 */
        .addColumnCustom("expriemSeqno"     , "expriemSeqno","*",false) /* 시험항목 일렬번호 */
        .addColumnCustom("expriemNm"        , "${msg.C100000560}","*",true) /* 시험항목 명 */
        .addColumnCustom("uclValue"         , "${msg.C100000094}","*",true,true) /* UCL */
        .addColumnCustom("clValue"          , "${msg.C100000018}","*",true,true) /* CL */
        .addColumnCustom("lclValue"         , "${msg.C100000051}","*",true,true) /* LCL */
        .inputEditRenderer(
            ["uclValue","clValue","lclValue"]
            ,{
                onlyNumeric : true, // 0~9만 입력가능
                allowPoint : true, // 소수점( . ) 도 허용할지 여부
                allowNegative : true, // 마이너스 부호(-) 허용 여부
                textAlign : "right", // 오른쪽 정렬로 입력되도록 설정
                autoThousandSeparator : true // 천단위 구분자 삽입 여부
            }
        );

        mtrilGrid = createAUIGrid(columnLayout.mtrilGrid, mtrilGrid);
        versionGrid = createAUIGrid(columnLayout.versionGrid, versionGrid);
		versionResultGrid = createAUIGrid(columnLayout.versionResultGrid, versionResultGrid);
		gridResize([mtrilGrid, versionGrid, versionResultGrid]);
	}

	// 자재 목록 조회
	function getMtrils(callBack) {
        clearGrids([versionGrid,versionResultGrid]);
        getGridDataForm("<c:url value='/wrk/getMtrilList.lims'/>", "frmSearch", mtrilGrid).then(function(){
            if( typeof callBack == "function" ){
                callBack();
            }
        });
	}

	// 자재별 version 목록 조회
	function getCLVersions(mtrilSeqno, callBack) {
        getGridDataParam("<c:url value='/wrk/getCLVersions.lims'/>", {mtrilSeqno:mtrilSeqno}, versionGrid).then(function(){
            if( typeof callBack == "function" ){
                callBack(versionSaveKey);
            }
        });
	}
	 
	// 버전별 CL 결과 조회
	function getCLVersionResults(mtrilClVerSeqno) {
        getGridDataParam("<c:url value='/wrk/getCLVersionResults.lims'/>", {mtrilClVerSeqno:mtrilClVerSeqno}, versionResultGrid);
	}

	function gridEvent() {

		AUIGrid.bind(mtrilGrid, "ready", function(event) {
            gridColResize(mtrilGrid, "2");
            if ( !!saveKey ){
               gridSelectRow(mtrilGrid, "mtrilSeqno", [saveKey]);
           }
        });

		AUIGrid.bind(versionGrid, "ready", function(event) {
             gridColResize(versionGrid, "2"); 
             if ( !!versionSaveKey ){
                gridSelectRow(versionGrid, "mtrilClVerSeqno", [versionSaveKey]);
            }
        });
		AUIGrid.bind(versionResultGrid, "ready", function(event) { gridColResize(versionResultGrid, "2"); });

        // 자재 grid double click
		AUIGrid.bind(mtrilGrid, "cellDoubleClick", function(event) {
            saveKey = event.item.mtrilSeqno;

            clearGrids([versionResultGrid]);
            getCLVersions(saveKey); // 자재별 version 목록
        });

        // version grid double click
		AUIGrid.bind(versionGrid, "cellDoubleClick", function(event) {
			btnStatus(event.item.lastVerAt);
            versionSaveKey = event.item.mtrilClVerSeqno;
			getCLVersionResults(versionSaveKey); //version별 결과목록
		});
	}

    function buttonEvent(){

		//조회
		document.getElementById("btnSearch").addEventListener("click", function() {

            saveKey = "";
            versionSaveKey = "";

            getMtrils();
        });

        //수정된 셀 데이터 저장 함수
        document.getElementById("btnSave").addEventListener("click", function(event) {
            var list = AUIGrid.getEditedRowItems(versionResultGrid);
            (list.length > 0) ? updateClVersionResult(list) : alert(lang.C000000328); /* 추가/수정/삭제된 행이 없습니다. */
        });
    }

    function updateClVersionResult(list){
        var ajax = customAjax({"url": "<c:url value='/wrk/updateClVersionResult.lims'/>",data : list});
            ajax.then(function(res, msg, status){
                if (status.status === 200) {
                    success(lang.C100000762); /* 저장 되었습니다. */

                    //version조회 -> version별 결과 조회
                    getCLVersions(saveKey,getCLVersionResults);
                } else {
                    err(lang.C100000597); /* 저장에 실패하였습니다. */
                }
            });
    }
	
    //조회이벤트
    function doSearch(e){
        saveKey = "";
        versionSaveKey = "";

        getMtrils();
    }

	function btnStatus(lastVerAt) {
		var saveBtn = document.querySelector('#btnSave');
		lastVerAt === 'Y' ? saveBtn.style.display = 'block' : saveBtn.style.display = 'none';
	}
	
</script>
</tiles:putAttribute>
</tiles:insertDefinition>