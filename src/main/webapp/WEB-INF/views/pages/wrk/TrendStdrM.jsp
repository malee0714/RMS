<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">Trend 기준관리</tiles:putAttribute>
	<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000718}</h2> <!-- 자재 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="frmSearch" onsubmit="return false">
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
                    <th>제품 구분</th>
                    <td>
                        <select class="schClass" name="prductSeCodeSch" id="prductSeCodeSch">
                            <option value="">${msg.C100000480}</option> <!-- 선택 -->
                        </select>
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
		<div id="mtrilGrid" style="height: 200px;"></div>
	</div>

    <div class="subCon1 mgT15">
        <h3>${msg.C100000238}</h3> <!-- 기준 그룹 -->
        <div class="btnWrap">
            <button id="btnAddSpcManage" class="btn5"><img src="${pageContext.request.contextPath}/assets/image/plusBtn.png"></button> <!-- 추가 -->
            <button id="btnDelSpcManage" class="delete"><img src="${pageContext.request.contextPath}/assets/image/minusBtn.png"></button> <!-- 삭제 -->
            <button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
        </div>
    </div>

    <div class="subCon2">

        <!-- 자재정보 form -->
        <form id="mtrilForm" onsubmit="return false;" style="display: none;">
            <input type="text" name="mtrilSeqno" style=" display:none;"/>   <!-- 자재 seqno -->
            <input type="text" name="mtrilNm" style="display: none;">       <!-- 자재 명 -->
            <input type="text" name="mtrilCode" style="display: none;">     <!-- 자재코드 -->
        </form>

        <!-- 기준그룹 double Click시 form -->
        <form id="spcManageForm" onsubmit="return false;">
            <!-- spc기준관리 seqno -->
            <input type="text" name="spcManageSeqno" style=" display:none; "/>
            <button id="btnEntrpsSch" style="display: none;"></button> <!-- 기준그룹 목록 그리드 검색 버튼 -->
        </form>

        <!-- 기준관리 목록 -->
        <div id="spcManageGrid" class="grid" style="height: 300px;"></div>
    </div>

    <div style="display: flex;">
        <div class="wd50p mgT15">
            <div class="subCon1">
                <h3>SPC Rule</h3>
                <div class="btnWrap">
                    <button id="btnOrdr" class="btn5 sortEnable"><img src="/assets/image/updownBtn.png"></button> <!-- 순서 변경 -->
                </div>
            </div>
            <div class="subCon2">
                <div id="spcRuleGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>
        <div class="wd5p mgT15"></div>
        <div class="wd45p mgT15">
            <div class="subCon1">
                <h3>${msg.C100000239}</h3> <!-- 기준 그룹 시험항목 목록 -->
                <div class="btnWrap">
                    <button id="btnAddSpcGroup" class="btn5"><img src="${pageContext.request.contextPath}/assets/image/plusBtn.png"></button> <!-- 추가 -->
                    <button id="btnDelSpcGroup" class="delete"><img src="${pageContext.request.contextPath}/assets/image/minusBtn.png"></button> <!-- 삭제 -->
                </div>
            </div>
            <div class="subCon2">
                <div id="exprIemsOfSpcGroupGrid" class="grid" style="height: 300px;"></div>
            </div>
        </div>
    </div>
</div>
<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>

    /**
     * 자재별 Spc8대룰 기준관리
     * @author shs
     */

    // AUIGrid 생성 후 반환 ID
    var mtrilGrid = "mtrilGrid";
    var spcManageGrid = "spcManageGrid";
    var spcRuleGrid = "spcRuleGrid";
    var exprIemsOfSpcGroupGrid = "exprIemsOfSpcGroupGrid";
    
    var lang = ${msg};
    var saveKey = "";
    var spcManageSaveKey = "";

    window.onload = function() {
        renderGrid();
        gridEvent();
        buttonEvent();
        combo();
        renderingDialog();
    };

	//콤보박스 생성
	function combo() {
        ajaxJsonComboBox('/com/getCmmnCode.lims', "cntnrSeCodeSch",{ "upperCmmnCode" : "SY10", "deptCode" : "${UserMVo.deptCode}" }, true); // 용기 타입
        ajaxJsonComboBox('/com/getCmmnCode.lims', "mtrilTyCodeSch",{ "upperCmmnCode" : "SY02", "deptCode" : "${UserMVo.deptCode}" }, true); //자재 유형
	}
	
	//그리드 생성
	function renderGrid(){

        //칼럼 설정
        var columnLayout = {
            mtrilGrid : []
            ,spcManageGrid : []
            ,spcRuleGrid : []
            ,exprIemsOfSpcGroupGrid : []
        }
		
		auigridCol(columnLayout.mtrilGrid); //제품목록 그리드
        auigridCol(columnLayout.spcManageGrid); //Spc 기준관리 grid
		auigridCol(columnLayout.spcRuleGrid); //Spc rule 그리드
		auigridCol(columnLayout.exprIemsOfSpcGroupGrid); //선택된 시험항목 목록 그리드

        columnLayout.mtrilGrid
        .addColumnCustom("prductSeCode" , "제품 구분"   ,"*",false) /* 제품 구분 */
        .addColumnCustom("prductSeCodeNm" , "제품 구분"   ,"*",true) /* 제품 구분 */
        .addColumnCustom("inspctInsttNm", "${msg.C100000432}"   ,"*",false) /* 사업장 */
        .addColumnCustom("mtrilTyCodeNm", "${msg.C100000727}"   ,"*",false) /* 자재유형타입 */
        .addColumnCustom("mtrilNm"      , "${msg.C100000717}"   ,"*",true) /* 자재 명 */
        .addColumnCustom("mtrilCode"    , "${msg.C100000725}"   ,"*",true) /* 자재 코드 */
        .addColumnCustom("useAt"      , "${msg.C100000443}"   ,"*",true) /* LOT 코드 */
        ;

        var tooltip = {
            style : "my-require-style",
            headerTooltip : { // 헤더 툴팁 표시 일반 스트링
                show : true
                ,tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
            }
        };

		columnLayout.spcManageGrid
        .addColumnCustom("mtrilNm"          , "${msg.C100000717}"   ,null,true) /* 자재명 */
        .addColumnCustom("entrpsNm"         , "${msg.C100000251}"   ,null,true,false,{colSpan:2}) //납품업체 명
        .addColumnCustom("entrpsNmSch"      , " "                   ,"80",true,false)
        .addColumnCustom("stdrNm"           , "${msg.C100000241}"   ,null,true,true,tooltip) //기준 명
        .addColumnCustom("inspctTyCode"     , "${msg.C100000139}"   ,null,true) //검사 유형 코드
        .addColumnCustom("spcManageSeqno"   ,"spc 관리 seqno"       ,null,false)
        .comboBoxRenderer([ "inspctTyCode" ], getGridComboList('/com/getCmmnCode.lims',{ 'upperCmmnCode' : 'SY07' }, false), true, null)
        .buttonRenderer(["entrpsNmSch"], function(rowIndex, columnIndex, value, item){
            $("#btnEntrpsSch").click();
        },false,"검색")
        ;

		columnLayout.spcRuleGrid
        .addColumnCustom("spcRuleCodeNm"    , "${msg.C100000092}"   ,null,true) //spc규칙
        .addColumnCustom("nvalue"           , "${msg.C100000068}"   ,null,true,true,tooltip) //n값
        .addColumnCustom("ordr"             , "${msg.C100000531}"   ,null,true,false) // ordr 순서
        .inputEditRenderer(["nvalue"],{onlyNumeric : true, textAlign : "right", autoThousandSeparator : true})
        ;

		columnLayout.exprIemsOfSpcGroupGrid
        .addColumnCustom('mtrilSdspcSeqno','',null,false)
        .addColumnCustom('expriemNm','${msg.C100000560}',null,true,null) //시험항목 명
        ;

        
        mtrilGrid = createAUIGrid(columnLayout.mtrilGrid, mtrilGrid);
        spcManageGrid = createAUIGrid(columnLayout.spcManageGrid, spcManageGrid, {showStateColumn : true});
		spcRuleGrid = createAUIGrid(columnLayout.spcRuleGrid, spcRuleGrid, {
            //셀에서 바로 행이동 가능하도록. 미리선언 setProp으로 나중에 선언시 작동되지않아서
            enableDragByCellDrag : true,
            enableMultipleDrag : true,
            enableDrag : false,
            enableDrop : false,
            editable: true
        });

		exprIemsOfSpcGroupGrid = createAUIGrid(columnLayout.exprIemsOfSpcGroupGrid, exprIemsOfSpcGroupGrid);

		gridResize([mtrilGrid, spcManageGrid, spcRuleGrid,  exprIemsOfSpcGroupGrid]);
	}

	// 자재 목록 조회
	function getMtrils(callBack) {
        clearGrids([spcManageGrid,spcRuleGrid,exprIemsOfSpcGroupGrid]);
        getGridDataForm("${pageContext.request.contextPath}/wrk/getMtrilList.lims", "frmSearch", mtrilGrid).then(function(){
            if( typeof callBack == "function" ){
                callBack();
            }
        });
	}
    
	// 자재별 spc기준관리 목록 조회
	function getSpcManageList(mtrilSeqno, callBack) {
        clearGrids([spcRuleGrid,exprIemsOfSpcGroupGrid]);
        getGridDataParam("${pageContext.request.contextPath}/wrk/getSpcManageList.lims", {mtrilSeqno:mtrilSeqno}, spcManageGrid).then(function(){
            if( typeof callBack == "function" ){
                callBack();
            }
        });
	}
	// spc기준관리별 spc rule 목록
	function getSpcRules(spcManageSeqno) {
        getGridDataParam("${pageContext.request.contextPath}/wrk/getSpcRules.lims", {spcManageSeqno:spcManageSeqno}, spcRuleGrid);
    }
	// 자재 시험항목 목록 조회
	function getMtrilExpriemList(mtrilSeqno) {
        getGridDataParam("${pageContext.request.contextPath}/wrk/getMtrilExpriemList.lims", {"mtrilSeqno" : mtrilSeqno}, exprGrid);
    }
	// 기준그룹별 시험항목 목록 조회.
	function getExprIemsOfSpcGroup(spcManageSeqno) {
        getGridDataParam("${pageContext.request.contextPath}/wrk/getExprIemsOfSpcGroup.lims", {spcManageSeqno:spcManageSeqno}, exprIemsOfSpcGroupGrid);
    }
	function gridEvent() {

		AUIGrid.bind(mtrilGrid, "ready", function(event) {
            gridColResize(mtrilGrid, "2");
            if ( !!saveKey ){
               gridSelectRow(mtrilGrid, "mtrilSeqno", [saveKey]);
           }
        });

		AUIGrid.bind(spcManageGrid, "ready", function(event) {
             if ( !!spcManageSaveKey ){
                gridSelectRow(spcManageGrid, "spcManageSeqno", [spcManageSaveKey]);
            }
        });

		AUIGrid.bind(spcRuleGrid, "ready", function(event) { gridColResize(spcRuleGrid, "2"); });
		
		AUIGrid.bind(exprIemsOfSpcGroupGrid, "ready", function(event) { gridColResize(exprIemsOfSpcGroupGrid, "2"); });

        // 자재 grid double click
		AUIGrid.bind(mtrilGrid, "cellDoubleClick", function(event) {
            var item = event.item;
            saveKey = item.mtrilSeqno;
            spcManageSaveKey = "";
            detailAutoSet({item : item, targetFormArr : ["mtrilForm"]});
            clearGrids([spcRuleGrid]);
            getSpcManageList(saveKey); // 자재별 version 목록
        });

        // version grid double click
		AUIGrid.bind(spcManageGrid, "cellDoubleClick", function(event) {

            var spcManageSeqno = event.item.spcManageSeqno;
            spcManageSaveKey = spcManageSeqno;

            //기준관리 seqno set value
            detailAutoSet({targetFormArr : ["spcManageForm"], item : event.item});

            //spc rule 목록 조회
			getSpcRules(spcManageSeqno);

            //자재 시험항목 조회
           // getMtrilExpriemList(event.item.mtrilSeqno);

            // spc 시험항목 조회
            getExprIemsOfSpcGroup(spcManageSeqno);
		});

        // drag and drop으로 순서 이동시
		AUIGrid.bind(spcRuleGrid, "dropEnd", function(event) {
            //순서 update
            sortSpcRule();
		});

		AUIGrid.bind(spcRuleGrid, "cellEditEnd", function (event) {

			if (event.item.spcRuleCode === 'SY04000004' && event.value < 2) {
				warn('해당 규칙은 n 값이 2 이상이어야 합니다.');
				AUIGrid.updateRow(event.pid, {nvalue: event.oldValue}, event.rowIndex);
			}
		});
	}

    function buttonEvent(){
        dialogAddWrhousngExpriemList("btnAddSpcGroup",'TrendStdrM','mtrilForm',"prevntPop", "exprIemsOfSpcGroupGrid", function(item){
            var check = AUIGrid.getGridData(exprIemsOfSpcGroupGrid);
            if(check.length > 0){
                for(var i=0; i<check.length; i++){
                    for(var j=0; j<item.length; j++){
                        if(item[j].expriemSeqno === check[i].expriemSeqno){
                            check[i].cmmnCode = "";
                            warn("${msg.C100001164}") /*동일한 사용자가 등록되어 있습니다. */
                            return false;
                        }
                    }
                }
            }
            //헤당 그리드에 데이터 입력
            AUIGrid.addRow(exprIemsOfSpcGroupGrid,item,"last"); // 최하단에 1행 추가
            AUIGrid.setSorting(exprIemsOfSpcGroupGrid,  { dataField : "expriemSeqno", sortType : 1 });
        },function(){

        },true);

        //조회
        document.getElementById("btnDelSpcGroup").addEventListener("click", function() {
            var list = AUIGrid.getSelectedRows(exprIemsOfSpcGroupGrid);
            ( list.length > 0 ) ? delSpcGroup(list) : alert("${msg.C100000467}"); //삭제할 데이터가 없습니다.
        });

        //조회
		document.getElementById("btnSearch").addEventListener("click", function() {

            saveKey = "";
            spcManageSaveKey = "";

            getMtrils();
        });

        // 행 추가
        document.getElementById('btnAddSpcManage').addEventListener('click',function(){

            var len = AUIGrid.getAddedRowItems(spcManageGrid).length;
            if( len > 0 ){
                warn("${msg.C100000675}"); //이미 추가된 행이 있습니다. 저장 후 추가해 주세요.
                return false;
            }

            var formObj = document.querySelector('#mtrilForm').toObject();
            if(!!!formObj.mtrilSeqno){
                alert(lang.C100000720); //자재 선택후 추가가 가능합니다.
                return false;
            }

            //기준그룹 form초기화
            document.querySelector('#spcManageForm').reset();

            //자재 시험항목 조회
           // getMtrilExpriemList(formObj.mtrilSeqno);

            //그리드 초기화
            getSpcRules('');
            clearGrids([exprIemsOfSpcGroupGrid]);

            // 기준그룹 seqno key값 초기화
            formObj.spcManageSeqno = '';
            AUIGrid.addRow(spcManageGrid,formObj,"last");
        });

        // 행 삭제
        document.getElementById('btnDelSpcManage').addEventListener('click',function(){
            var list = AUIGrid.getSelectedRows(spcManageGrid);
            ( list.length > 0 ) ? delSpcManage(list) : alert("${msg.C100000467}"); //삭제할 데이터가 없습니다.
        });

        //저장
        document.getElementById("btnSave").addEventListener("click", function(event) {
            //저장
            var isValid = AUIGrid.validateGridData(spcRuleGrid, "nvalue");
            if(!isValid) {
                warn("n값을 입력해야 합니다.");  /* 유효일자 값을 입력해야 합니다. */
                return false;
            }
            saveAllData();
        });
        


        // 순서변경 event
        document.querySelector('#btnOrdr').addEventListener('click',function(e){

            var hasClass = this.classList.contains('sortEnable');
            if(hasClass){
                this.classList.remove("sortEnable");
                alert("${msg.C100000090}"); /* Spc Rule 순서변경 가능상태 입니다. */
            }else{
                this.classList.add("sortEnable");
                alert("${msg.C100000091}"); /* Spc Rule 순서변경 불가능상태 입니다. */
            }
            var prop = {
                enableDrag : hasClass,
                enableMultipleDrag : hasClass,
                enableDragByCellDrag : hasClass,
                enableDrop : hasClass,
                editable: hasClass
            }
            AUIGrid.setProp(spcRuleGrid, prop);
		});
    }

    function renderingDialog(){

        //업체 찾기 dialog
        dialogEntrps("btnEntrpsSch", "SY08000002", "entrpsDialog",function(data){
            var updItem = {
                entrpsSeqno : data.entrpsSeqno,
                entrpsNm    : data.entrpsNm
            }
            AUIGrid.updateRow(spcManageGrid, updItem, "selectedIndex");
        });
    }

    //저장
    function saveAllData(){
        
        var spcManageSeqno = document.querySelector('#spcManageForm').spcManageSeqno.value; // 기준 그룹 seqno (그리드 double click으로 setting된 값임)
        var addedRows = AUIGrid.getAddedRowItems(spcManageGrid);    // 추가된 행
        var editedRows = AUIGrid.getEditedRowItems(spcManageGrid);  // 수정된 행
        var saveTargetRows = addedRows.concat(editedRows);

        //수정,추가된 행도 없고 spcManageSeqno 없으면
        if( saveTargetRows.length === 0 &&  !!!spcManageSeqno){
            alert(lang.C000001113); //저장할 데이터가 없습니다.
            return false;
        }

        // 기준그룹 목록을 doubleclick후 수정하지 않았더라도 하위 그리드 저장을 위해 saveTargetRows에 추가되야 하기 때문에 key값 매칭시 array에 push해줌.
        var mappingRow = AUIGrid.getGridData(spcManageGrid)
                                .filter(function(row){
                                    //기준그룹 seqno가 있을 때에만 추가함 ! 기준그룹 seqno가 없는경우 이미 addedRows에 포함 되어있다. 중복방지.
                                    return row.spcManageSeqno === spcManageSeqno && (!!spcManageSeqno);
                                }).map(function(row) {
                                    return row;
                                });

        if(mappingRow.length > 0){
            saveTargetRows.push(mappingRow[0]);
        }

        //그리드 필수값 체크
        var test = gridRequire({
            list : saveTargetRows
            , gridId : spcManageGrid
            , requireColumns : ["stdrNm"]
            , msg : lang.C100000240 /* 기준 그룹을 추가하거나 선택해 주세요. */
        });
        if(!test){
            return false;
        }

        /**
         * 기준그룹 목록에서 double click당시의 하위 그리드들을 mapping.
         * 이렇게 따로 하위 그리드의 data mapping시켜주는 이유는 기준그룹 목록 전체가 수정 가능하기 때문 입니다.
         */
        saveTargetRows
            .filter(function(row){
                return row.spcManageSeqno === spcManageSeqno
            }).map(function(row) {
                row.spcRules = AUIGrid.getGridData(spcRuleGrid);                            //spc rules
                row.addSpcExprIems = AUIGrid.getAddedRowItems(exprIemsOfSpcGroupGrid);      // 추가된 spc 시험항목들
                row.deleteSpcExprIems =  AUIGrid.getRemovedItems(exprIemsOfSpcGroupGrid);   // 삭제된 spc 시험항목들
            });

        var ajax = customAjax({
            "url": "${pageContext.request.contextPath}/wrk/saveSpcManage.lims"
            ,data : saveTargetRows
            ,elementIds : ["btnSave"]
        });
        ajax.then(function(data){

            spcManageSaveKey = "";
            
            //spc기준 목록 조회 -> spc rule, spc기준 별 시험항목 조회 조회
            getSpcManageList(saveKey);

            success(lang.C100000762); /* 저장 되었습니다. */
        });
    }

    // spc 기준 관리 삭제
    function delSpcManage(list){

        if(!confirm(lang.C100000461)) return false; //삭제 하시겠습니까 ?

        var ajax = customAjax({
            url : "${pageContext.request.contextPath}/wrk/delSpcManage.lims"
            ,data : list
            ,elementIds : ["btnDelSpcManage"]
        });

        ajax.then(function(res){

            spcManageSaveKey = "";

            //spc기준 목록 조회 -> spc rule, spc기준 별 시험항목 조회 조회
            getSpcManageList(saveKey,function(){
                clearGrids([spcRuleGrid,exprIemsOfSpcGroupGrid]);
            });
            success(lang.C100000460); //삭제 되었습니다.
        });
    }

    // spc 기준 시험항목 삭제
    function delSpcGroup(list){

        if(!confirm(lang.C100000461)) return false; //삭제 하시겠습니까 ?

        var ajax = customAjax({
            url : "${pageContext.request.contextPath}/wrk/delSpcGroup.lims"
            ,data : list
            ,elementIds : ["btnDelSpcGroup"]
        });

        ajax.then(function(res){
            getExprIemsOfSpcGroup(saveKey);
            success(lang.C100000460); //삭제 되었습니다.
        });
    }
    function moveExpr(gridId, targetGridId){

        //기준그룹
        var spcMangeItems = AUIGrid.getSelectedRows(spcManageGrid);
        if( spcMangeItems.length === 0 ){
            alert(lang.C100000240);
            return false;
        }

        //선택한 행 객체들을 가져옵니다.
        var selectedItems = AUIGrid.getSelectedRows(gridId);
        if( selectedItems.length === 0 ){
            alert(lang.C100000497); //선택된 행이 없습니다.
            return false;
        }

        // 기준규격 seqno만 모아서
        var mtrilSdspcSequences = selectedItems.map(function(element){
            return element.mtrilSdspcSeqno;
        });

        // target grid에서 row삭제
        var indexArr = AUIGrid.getRowIndexesByValue(gridId, "mtrilSdspcSeqno", mtrilSdspcSequences);
        AUIGrid.removeRow(gridId,indexArr); // 기존 그리드에서 행 삭제

        //중복제거 후 target grid로 row추가
        var result = arrayDropDuplicates({
            targetArr   : AUIGrid.getGridData(targetGridId)
            , testArr   : selectedItems
            , key       : "mtrilSdspcSeqno"
        });

        // 중복 제거된 array 이동할 그리드에 행 추가
        result.resultArray.forEach(function(el){
            AUIGrid.addRow(targetGridId, el, "last");
        });
    }

    //시험항목 그리드 순번 update
    function sortSpcRule(){
        var spcRules =  AUIGrid.getGridData(spcRuleGrid);
        var len = spcRules.length;
        for(var i=0; i<len; i++){
            AUIGrid.updateRow(spcRuleGrid,{ordr:i+1},i);
        }
        AUIGrid.update(spcRuleGrid);
    }

    //조회이벤트
    function doSearch(e){
        saveKey = "";
        spcManageSaveKey = "";
        getMtrils();
    }
</script>
</tiles:putAttribute>
</tiles:insertDefinition>