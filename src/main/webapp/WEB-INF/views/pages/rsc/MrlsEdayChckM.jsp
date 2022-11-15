<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001069}</h2> <!-- 검사 교정 목록 -->
		<div class="btnWrap">
			<button id="btn_delete" class="btn5">${msg.C000000097}</button><!-- 삭제 --> 
			<button id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
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
					<th class="necessary">${msg.C000000761}</th> <!-- 년도 -->
					<td>
						<select id="yearSch" name="yearSch"></select>
					</td>
					<th class="necessary">${msg.C000001071}</th> <!-- 분기 -->
					<td>
						<select id="quSch" name="quSch">
							<option value="" selected>${msg.C000000062}</option> <!-- 전체 -->
							<option value="1">${msg.C000001072}</option> <!-- 1분기 -->
							<option value="2">${msg.C000001073}</option> <!-- 2분기 -->
							<option value="3">${msg.C000001074}</option> <!-- 3분기 -->
							<option value="4">${msg.C000001075}</option> <!-- 4분기 -->
						</select></td>
						
					<th>기기명</th> <!-- 검사교정 명 --> 
					<td><input type="text" id="mhrlsNmSch" name="mhrlsNmSch"></td>	
						
					<th>${msg.C000000885}</th>  <!-- 검사교정 구분 --> 
					<td><select id="inspctCrrctSeCodeSch" name="inspctCrrctSeCodeSch"></select></td>
					
				</tr>
				
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. --> 
			<div id="mrlsEdayListGrid" style="width:100%; margin:0 auto;" class="grid"></div>
		</div>
	</div>
	<div class="subCon1">
		<h2 class="mgT15">${msg.C000001076}</h2> <!-- 검사 교정 목록 상세 -->
		<div class="btnWrap">
				<button id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
				<button id="btnSave" class="btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<form id="insttForm" action="javascript:;">
			<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1">
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
					<th class="necessary">${msg.C000000761}</th> <!-- 년도 -->
					<td><select id="year" name="year"></select></td>
			
					<th class="necessary">${msg.C000001071}</th> <!-- 분기 -->
					<td><select id="qu" name="qu">
						<option value="1">${msg.C000001072}</option> <!-- 1분기 -->
						<option value="2">${msg.C000001073}</option> <!-- 2분기 -->
						<option value="3">${msg.C000001074}</option> <!-- 3분기 -->
						<option value="4">${msg.C000001075}</option> <!-- 4분기 -->
					</select></td>

					<th class="necessary">${msg.C000000885}</th> <!-- 검사교정 구분 --> 
					<td><select id="inspctCrrctSeCode" name="inspctCrrctSeCode"></select></td>
					
					<th class="necessary">기기</th>
						<td>
							<input type="text" class="wd70p schClass" name="inMhrlsNm" id="inMhrlsNm" readonly>
							<input type="hidden" id="mhrlsSeqnon" name="mhrlsSeqnon">
							<button type="button" class="inTableBtn inputBtn GuBunUser" id="btnSrchInspctMhrls">찾기</button>
						</td>

				</tr>
				
				<tr>
					<th class="necessary">${msg.C000001070}</th> <!-- 검사교정 명 --> 
					<td><input type="text" id="inspctCrrctNm" name="inspctCrrctNm" class="schClass"></td>
					<td colspan="6"></td>
				</tr>

			</table>
			<input type="hidden" id="reqestSeqno" name="reqestSeqno">	
			<input type="hidden" id="calcDate" name="calcDate">
			<input type="hidden" id="registerId" name="registerId" value="${UserMVo.userId}">
			<input type="hidden" id="mhrlsEdayChckSeqno" name="mhrlsEdayChckSeqno">	
			<input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno">
			<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno">
			<input type="hidden" id="detectLimitApplcAt" name="detectLimitApplcAt">
			<input type="hidden" id="mhrlsClCode" name="mhrlsClCode">
		</form>
	</div>
	<div class="subCon1" style="display:flex;">
		<div class="subCon1 wd35p mgT20"  style="display:inline-block; order:1;">
			<div style="width:100%;">
				<div class="mgT15">
					<h3>${msg.C000000735}</h3> <!-- 의뢰 목록 -->
					<div class="btnWrap" style="margin-top: 0px;">
						<button id="btnRdms" class="search btn4" onClick="openRDMSViewer(requestAddGrid,1,1);">${msg.C000001316}</button> <!-- RDMS -->
						<button id="btnReqAdd" class="search btn4" style="margin-top: 10px;">${msg.C000001077}</button> <!-- 의뢰추가 -->
						<button id="btn_remove" class="search btn5" style="margin-top: 10px;">${msg.C000000097}</button> <!-- 삭제 -->
					</div>
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="requestAddGrid" class="grid" style="margin-top: 10px"> </div>
				</div>
			</div>
		</div>	
		
		<div class="subCon1 wd65p mgT20"  style="display:inline-block; padding-left:50px; order:2;">
			<div  style="width:100%">
				<div class="mgT15">
<!-- 						에이유아이 그리드가 이곳에 생성됩니다. -->
					<h3>${msg.C000001127}</h3> <!-- 시험항목 결과 -->
					<div id="requestValGrid" class="grid" style="margin-top: 10px"></div>
				</div>	
			</div>
		</div>
	</div>
	<div class="subCon1 mgT20"">
		<div  style="width:100%">
			<div class="mgT15">
<!-- 						에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="mhrlsEdayDropZone" name="mhrlsEdayDropZone"></div>
			</div>	
		</div>
	</div>
	<input type="text" id="clickDialogChart" style="display:none;"/>
	<input type="text" id="eventData" style="display:none;"/>
	<input type="text" id="reqestExSeqno" style="display:none;"/>
	<input type="text" id="popMhrlsEdayChckSeqno" style="display:none;"/>
	<input type="text" id="chartMhrlsSeqno" style="display:none;"/>
</div>
    </tiles:putAttribute>
<tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var mrlsEdayListGrid = 'mrlsEdayListGrid'; // 교정목록 그리드
	var requestAddGrid = 'requestAddGrid'; // 의뢰 추가 그리드
	var requestValGrid = 'requestValGrid'; // 결과값 그리드
	var mhrlsEdayDropZone = "mhrlsEdayDropZone" //드랍존(파일)
	var lang = ${msg};
	var showFlag = "";
	var reqestSeqno;
	var calcDate;
	var mhrlsSeqno;
	var mhrlsSeqnon;
	$(function() {
		//권한체크
		getAuth();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setmrlsEdayGrid();
		
	    popUpEvent();	
	    
	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setmrlsEdayGridEvent();

	    // 그리드 리사이즈
	    gridResize([mrlsEdayListGrid,requestAddGrid,requestValGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
	    
	    $("#btnSrchInspctMhrls").prop("disabled", true);

	
	});
	
	function setCombo(){
		mhrlsEdayDropZone = DDFC.bind().EventHandler("mhrlsEdayDropZone", { btnId : "btnSave", maxFiles : 10, lang : "${msg.C000000118}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */
		
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctCrrctSeCodeSch', {'upperCmmnCode': 'IM10'}, false,"${msg.C000000079}"); /* 선택 */
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'inspctCrrctSeCode', {'upperCmmnCode': 'IM10'}, false,"${msg.C000000079}"); /* 선택 */
		setYear('year', null, 2019, 10);
		setYear('yearSch', null, 2019, 10);
	}
	
 	// 그리드 생성
	function setmrlsEdayGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var mrlsEdayListCol = [];
	    var requestAddCol = [];
	    var requestValCol = [];
	    auigridCol(mrlsEdayListCol);
	    auigridCol(requestAddCol);
	    auigridCol(requestValCol);
	

	    //컬럼 속성 정의
	    var mrlsEdayListColPros = {

	    };
	    var requestAddColPros = {
	    		
	    };
	    var requestValColPros = {

	    };


		
	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom

	    mrlsEdayListCol.addColumnCustom("year", "${msg.C000000761}", null, true, false); /* 년도 */
	    mrlsEdayListCol.addColumnCustom("qu", "${msg.C000001071}", null, true, false);  /* 분기 */
	    mrlsEdayListCol.addColumnCustom("inMhrlsNm", "기기명", null, true, false);  
	    mrlsEdayListCol.addColumnCustom("inspctCrrctNm", "${msg.C000001070}", null, true, false); /* 검사교정명 */
	    mrlsEdayListCol.addColumnCustom("crrctCodeNm", "${msg.C000000885}", null, true, false); /* 검사교정 구분 */ 
	    mrlsEdayListCol.addColumnCustom("inspctCrrctSeCode", "${msg.C000001078}", null, false, false); /* 검사교정 구분키 */ 
	    
	    requestAddCol.addColumnCustom("lotId", "${msg.C000000575}", null, true, false); /* LotId */
	    requestAddCol.addColumnCustom("reqestDte", "${msg.C000000576}", null, true, false); /* 의뢰일자 */
	    requestAddCol.addColumnCustom("mhrlsNm", "${msg.C000000011}", null, true, false); /* 기기명 */
	    
	    requestValCol.addColumnCustom("lotId", "${msg.C000000575}", null, true, false); /* LotId */
	    requestValCol.addColumnCustom("resultRegisterNm", "${msg.C000001079}", null, true, false); /* 결과 입력자 */ 
	    
	    var rowStyle = {
			//엑스트라체크박스 표시
			showRowCheckColumn : true,
			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true
		}
	 
	    //그리드 생성
	    mrlsEdayListGrid = createAUIGrid(mrlsEdayListCol,mrlsEdayListGrid);
	    requestAddGrid = createAUIGrid(requestAddCol,requestAddGrid, rowStyle);
	    requestValGrid = createAUIGrid(requestValCol,requestValGrid);
	    
		
	}; 

	
	
	//그리드 이벤트
	function setmrlsEdayGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(mrlsEdayListGrid, "ready", function(event) {
	        gridColResize(mrlsEdayListGrid, "2");
	    });	    
	    AUIGrid.bind(requestAddGrid, "ready", function(event) {
	        gridColResize(requestAddGrid, "2");
	    });
	    AUIGrid.bind(requestValGrid, "ready", function(event) {
	        gridColResize(requestValGrid, "2");
	    });

	  
	    
	    AUIGrid.bind(mrlsEdayListGrid, "cellDoubleClick", function(event) {
	    	console.log('가',event)
	    	$("#mhrlsEdayChckSeqno").val(event.item.mhrlsEdayChckSeqno);
	    	$("#year").val(event.item.year);
	    	$("#qu").val(event.item.qu);
	    	$("#inspctCrrctNm").val(event.item.inspctCrrctNm);
	    	$("#inspctCrrctSeCode").val(event.item.inspctCrrctSeCode);
	    	$("#registerId").val(event.item.registerId);
	    	$("#deleteAt").val(event.item.deleteAt);
	    	$("#lastChangerId").val(event.item.lastChangerId);
	    	$("#lastChangeDt").val(event.item.lastChangeDt);
 	    	$("#reqestSeqno").val(event.item.reqestSeqno);
 	    	$("#atchmnflSeqno").val(event.item.atchmnflSeqno);
 	    	$("#inMhrlsNm").val(event.item.inMhrlsNm);
 	    	$("#mhrlsSeqnon").val(event.item.mhrlsSeqno);
 	    	$("#detectLimitApplcAt").val(event.item.detectLimitApplcAt);
 	    	$("#mhrlsClCode").val(event.item.mhrlsClCode);
 	    	getEl("chartMhrlsSeqno").value = event.item.mhrlsSeqno;
 	    	
 	    	AUIGrid.clearGridData(requestValGrid);
 	    	if(event.item.inspctCrrctSeCode == "IM10000002"){
 	    		$("#btnSrchInspctMhrls").prop("disabled", false); 	    		
 	    	} else {
 	    		$("#btnSrchInspctMhrls").prop("disabled", true); 	    
 	    	}
 	    	mhrlsEdayDropZone.getFiles(event.item.atchmnflSeqno);
 	    	
			var params = {"mhrlsEdayChckSeqno" : $('#mhrlsEdayChckSeqno').val()}
			
			getGridDataParam11("<c:url value='/reg/searchReqList.lims'/>", params, requestAddGrid, function(data) {
				var schList = new Array();
			   
			    for(var i=0; i<data.length; i++){
			    	schList.push(data[i].reqestSeqno);

			    }
			
			    searchValDetail(schList);
			   
		    });


			
	
	    });
	    
	    AUIGrid.bind(requestAddGrid, "cellDoubleClick", function(event) {
 	    	$("#reqestSeqno").val(event.item.reqestSeqno);
 	    	searchValDetail([event.item.reqestSeqno]);
 	    	

	    });
	    
	    AUIGrid.bind(requestValGrid, "cellDoubleClick", function(event) {
	    	var item = event.item;
			
	    	//얘로 값 확인해서 해당 시험항목 값 있는지 없는지 확인 후에 그래프 보여주려고
	    	getEl("reqestExSeqno").value = item[event.dataField];
	    	if(getEl("reqestExSeqno").value=="undefined"){
	    		alert("${msg.C000001080}") /* 해당하는 항목의 값이 없습니다. */
	    		return false;
	    	}

	    	if(event.dataField == "lotId" || event.dataField == "resultRegisterNm" || event.dataField == "sdspcNm" || event.dataField == "exprNumot"){
	    		alert('${msg.C000001081}') /* 차트확인은 시험항목을 클릭 해주세요. */
	    		return false;
	    	} else {
	    		console.log(item);
	    		getEl("popMhrlsEdayChckSeqno").value = $("#mhrlsEdayChckSeqno").val();
		    	getEl("reqestExSeqno").value = item[event.dataField+"1"];
		    	getEl("clickDialogChart").value = event.item.reqestSeqno;
	 	    	getEl("clickDialogChart").click();	
	    	}
	    });
	    
	 
	    
	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	        searchMrlsChk();
	    })
		// 신규 클릭 이벤트
		$('#btn_new').click(function(){
			// 폼 초기화
			reset();
		});
	    //저장
		$('#btnSave').click(function(){
			if(!saveValidation("insttForm")){
				return false;
			}
			var requestaddedRowItems = AUIGrid.getAddedRowItems(requestAddGrid);   //추가한 아이템
			var mhrlsEdayChckSeqno = $("#mhrlsEdayChckSeqno").val();
			
			if(requestaddedRowItems.length == 0 && !mhrlsEdayChckSeqno){
				alert("의뢰를 추가해 주세요.");
				return false;
			}
			

			atchmnflSave(mhrlsEdayDropZone, "atchmnflSeqno","btnSave", function(){
				saveMrlsChk(requestaddedRowItems);
			});
	    });
	    
		
	    //엔터키 이벤트
		$(".schClass").keypress(function (e) {
		    if (e.which == 13){
		    	searchMrlsChk()
		    }
		});
		});
		
	    /////////////////// 행 삭제 //////////////////
	    $("#btn_remove").click(function() {
	    	removeDetail();
	    });
	    
	    $("#btn_delete").click(function() {
	    	
	    	removeAllDetail();
	    });
	    
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchMrlsChk();
		    }
		});
	}
	
	 //팝업 이벤트
	function popUpEvent(){

		
		dialogMhrls("btnSrchInspctMhrls", null, "reqestMhrlsPop", function(data){
			getEl("mhrlsSeqnon").value = data.mhrlsSeqno;
			getEl("inMhrlsNm").value = data.mhrlsNm;
			getEl("inspctCrrctNm").value = data.mhrlsNm;

		});

		mrlsChkRequestDialog("btnReqAdd", "mrlsChkRequestDialog", {'deptCode' : "${UserMVo.deptCode}"}, function(data){
			$("#detectLimitApplcAt").val(data[0].detectLimitApplcAt);
			$("#mhrlsClCode").val(data[0].mhrlsClCode);

			 AUIGrid.addRow(requestAddGrid, data, 0);
			 var reqestSeqno = [];
			 var row = AUIGrid.getGridData(requestAddGrid);
			 for(var i = 0; i<row.length; i++){
				 reqestSeqno[i] = row[i].reqestSeqno;
			 }
			 calcDate = data[0].calcDate;
			 searchValDetail(reqestSeqno);
			$("#requestPopForm")[0].reset();
		 });

		dialogViewMecChart("clickDialogChart", null, "mecViewChart", function(item){
			
			
		},function(){
			
		},true);
		

		
	 }	
	 
	// 조회 함수
	function searchMrlsChk() {
	    getGridDataForm("<c:url value='/reg/searchMrlsChk.lims'/>", "searchFrm", mrlsEdayListGrid, function(data) {
	    });
		AUIGrid.clearGridData(requestAddGrid);
		AUIGrid.clearGridData(requestValGrid);
	}
	
	
	// 저장 함수(마스터)
	function saveMrlsChk(requestaddedRowItems) {
		
	    var savetUrl ='/reg/saveMrlsChk.lims';
	    
 	    var param = getFormParam("insttForm");
 		var tt = currentDate(true);
 		calcDate = $("#calcDate").val();
	  	var calD = date_add(tt, calcDate);
	  	var exprVal = AUIGrid.getGridData(requestValGrid);  
		param.calD = calD;
		param.requestaddedRowItems = requestaddedRowItems;
		customAjax({
			"url" : savetUrl,
			"data" : param,
			"successFunc" : function(data) {
				if (data > 0) {
					alert("${msg.C000000071}"); /* 저장 되었습니다. */
					searchMrlsChk();
					reset();
				}
			}
		})
	}
	
	function reset(){
		pageReset(["insttForm"], null, null, function(){
			$("#year").val(new Date().getFullYear());
		});
		AUIGrid.clearGridData(requestAddGrid);
		AUIGrid.clearGridData(requestValGrid);
		mhrlsEdayDropZone.clear();
	}
	

	 
	//의뢰 결과 조회
		function searchVal(data) {
			var savetUrl = '/reg/searchReqVal.lims';

			customAjax({
				"url" : savetUrl,
				"data" : data,
				"successFunc" : function(result) {
					console.log("result  : ", result);
		
					var reqValCol = [];
				    auigridCol(reqValCol);
				   
				    //컬럼 셋팅
				    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
				    reqValCol.addColumnCustom("lotId", "${msg.C000000575}", null, true, false); /* LotId */
				    reqValCol.addColumnCustom("resultRegisterNm", "${msg.C000001079}", null, true, false); /* 결과 입력자 */
				    if(showFlag == "sdspcNm"){
				    	console.log("1 : ", showFlag);
					    reqValCol.addColumnCustom("sdspcNm", "${msg.C000000825}", null, true, false); /* 기준 명 */
				    }else{
				    	console.log("2 : ", showFlag);
					    reqValCol.addColumnCustom("exprNumot", "${msg.C000000242}", null, true, false); /* 시험 횟수 */
				    }
				    var headerCol = new Array();
				  
				    for(var i = 0 ; i<result.length; i++){
				    	if(i == 0){
				    		headerCol.push({
			    				expriemSeqno : result[i].expriemSeqno,
			    				expriemNm : result[i].expriemNm,
			    			});
				    		continue;
				    	}
				    	
				    	for(var j = 0; j<headerCol.length; j++){
				    		var chk = 0;
				    		if((headerCol[j].expriemSeqno == result[i].expriemSeqno)){
								chk++;
				    		}
				    		if((j == headerCol.length-1) && (chk == 0)){
				    			headerCol.push({
				    				expriemSeqno : result[i].expriemSeqno,
				    				expriemNm : result[i].expriemNm,
				    			});
				    		}
				    	}
				    }
					for(var i = 0 ; i< headerCol.length; i++){
						reqValCol.addColumnCustom(headerCol[i].expriemSeqno, headerCol[i].expriemNm, null, true, false); 
					}
			
 		    		AUIGrid.changeColumnLayout(requestValGrid, reqValCol);
			     }
			})
		}
		// 의뢰 결과 값 조회
		function searchValDetail(data){
			var reqVal = {"reqestArr" :data};
			var url = "<c:url value='/reg/searchValDetail.lims'/>";


			customAjax({
				"url" : url,
				"data": reqVal,
				"successFunc" : function(data) {
					console.log("detail data : " , data);
					var arr = new Array();
					var newObj  = new Object();
					
					if(data.length != 0){
						var expriemSeqnoArr;
						var expriemNmArr;
						var resultValueArr;	 
						console.log("data list : " , data);
						if(!!data[0].sdspcNm){
							showFlag = "sdspcNm";
						}else{
							showFlag = "exprNumot";
						}
						for(var i = 0 ; i < data.length; i++){
							
							if(Array.isArray(data[i].expriemSeqnoArr)){
								expriemSeqnoArr = data[i].expriemSeqnoArr;
							} else {
								expriemSeqnoArr = new Array();
								expriemSeqnoArr.push(data[i].expriemSeqnoArr);
							}
							
							if(Array.isArray(data[i].reqestExpriemSeqnoArr)){
								reqestExpriemSeqnoArr = data[i].reqestExpriemSeqnoArr;
							} else {
								reqestExpriemSeqnoArr = new Array();
								reqestExpriemSeqnoArr.push(data[i].reqestExpriemSeqnoArr);
							}
							
							if(Array.isArray(data[i].expriemNmArr)){
								expriemNmArr = data[i].expriemNmArr;
							} else {
								expriemNmArr = new Array();
								expriemNmArr.push(data[i].expriemNmArr);
							}
							
							
							
							if(Array.isArray(data[i].resultValueArr)){
								resultValueArr = data[i].resultValueArr;
							} else {
								resultValueArr = new Array();
								resultValueArr.push(data[i].resultValueArr);
							}
							
							if(!!expriemNmArr){
								var obj = new Object();
								for(var j=0; j<expriemSeqnoArr.length; j++){
									obj[expriemSeqnoArr[j]] = resultValueArr[j];
									obj[expriemSeqnoArr[j]+'1'] = reqestExpriemSeqnoArr[j];
								}
								arr.push(Object.assign(data[i], obj));
							
							}
						}
						searchVal(reqVal);
						AUIGrid.setGridData(requestValGrid,arr);
		
						
					}
		    	 }
			})
		}
		
		//의뢰 목록 행삭제
		function removeDetail() {
			AUIGrid.removeCheckedRows(requestAddGrid); //삭제 처리
		    var del = AUIGrid.getRemovedItems(requestAddGrid);
		    if(del.length == 0){
		    	alert("선택된 의뢰가 없습니다.");
		    	return false;
		    }
		    
		    if(!confirm("삭제하시겠습니까?"))
	    		return false;
		    
		    var url = "<c:url value='/reg/delReqDetail.lims'/>";
		   ajaxJsonParam(url, del, function(data) {
		        if (data > 0) {
		        	alert("${msg.C000000179}"); /* 삭제되었습니다. */
		        	var row = AUIGrid.getGridData(requestAddGrid);
		        	var reqestSeqno = new Array();
		        	if(row.length > 0){
		        		for(var i = 0; i<row.length; i++){
							 reqestSeqno[i] = row[i].reqestSeqno;
						 }
			        	searchValDetail(reqestSeqno);	
		        	}else{
		        		AUIGrid.clearGridData(requestValGrid);
		        		AUIGrid.removeRow(mrlsEdayListGrid, "selectedIndex");
		        	}
		        	
		       } 
		   });    
		}
		
		function removeAllDetail() {
		    var del = AUIGrid.getSelectedItems(mrlsEdayListGrid);
		    if(del.length == 0){
		    	alert("선택된 교정이 없습니다.");
		    	return false;
		    }
		    
		    if(!confirm("삭제하시겠습니까?"))
	    		return false;
		    
		    var url = "<c:url value='/reg/delReqAll.lims'/>";
			customAjax({
				"url" : url,
				"data" : del[0].item,
				"successFunc" : function(data){
					if (data > 0) {
						alert("${msg.C000000179}"); /* 삭제되었습니다. */
						searchMrlsChk();
		     		} 	
				}
			})
		}
		
	function getGridDataParam11(url, param, divID, func){
			showLoader(divID);
			customAjax({
				"url" : url,
				"data" : param,
				"successFunc" : function(data){
					divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
					AUIGrid.setGridData(divID, data);
					hideLoader(divID);
				
					if(func != undefined && typeof func == "function"){
						func(data);
					}
				}
			})
		}
		

	//첨부 파일 저장 함수
	function atchmnflSave(dropzoneId, selector, btnId, aftFunc){ 
		var files = null, files_cnt = null;
		selector = typeof selector != "string" ? undefined : selector[0] == "#" ? selector : "#"+selector;
		files = dropzoneId.getNewFiles(); //새로 추가한 파일 데이터 가져오기
		files_cnt = files.length;	//업로드 파일 개수

		if (files_cnt > 0){
			dropzoneId.on("uploadComplete", function(event, fileIdx){
				$(selector).val(fileIdx);
				if(typeof aftFunc == "function"){
					aftFunc();
				}
			});	
		} else { // 첨부파일이 없을 시
			if(typeof aftFunc == "function"){
				aftFunc();
			}
		}
	}
	
	$("#inspctCrrctSeCode").change(function() {
		if($(this).val() == "IM10000002"){
		 $("#btnSrchInspctMhrls").prop("disabled", false);
		} else {
		 $("#btnSrchInspctMhrls").prop("disabled", true);
		}
	});


	

</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>