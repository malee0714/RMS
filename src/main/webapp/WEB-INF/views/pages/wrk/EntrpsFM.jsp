<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">업체관리</tiles:putAttribute>
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000482}</h2> <!-- 업체 목록 -->
		<div class="btnWrap">
			<button type="button" id="srchBtn" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<form id="srchForm" action="javascript:;">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:40%"></col>
				</colgroup>
				<tr>
					<th>${msg.C000000303}</th> <!-- 업체명 -->
						<td>
							<input type="text" id ="srchentrpsNm" name ="srchentrpsNm" >
						</td>
					<th>${msg.C000000420}</th> <!-- 대표자 명 -->
						<td>
							<input type="text" id ="srchrprsntvNm" name="srchrprsntvNm" >
						</td>
					<th>${msg.C000000421}</th> <!-- 사업자등록번호 -->
						<td style="text-align:left;">
							<input type="text" id ="srchbsnmRegistNo" name ="srchbsnmRegistNo" class="wd33p">
						</td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="entrpsMListGrid" class="wd100p" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
	</div>
	<br>
	<div id="tabCtsLst">
	   	<div id="tabCts1" class="tabCts">
	   		<div class="subCon1">
				<h2>${msg.C000000489}</h2> <!-- 업체 상세 정보 -->
				<div class="btnWrap">
					<button type="button" id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
					<button type="button" id="btn_delete" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
					<button type="button" id="btn_save" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
				</div>
				<form id="entrpsMFrm" name ="entrpsMFrm">
					<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="userInfotbl">
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
							<th class="necessary" style="min-width:150px;">${msg.C000000303}</th> <!-- 업체명 -->
								<td>
									<input type="text" id="entrpsNm" name="entrpsNm" >
								</td>
							 <th>${msg.C000000483}</th> <!-- 업체 영문명 -->
								<td>
									<input type="text" id="entrpsEngNm" name="entrpsEngNm"  onkeydown="SetAlphaNum(this)">
								</td>
							 <th>${msg.C000000484}</th> <!-- 업태명 -->
								<td>
									<input type="text" id="bizcndNm" name="bizcndNm" >
								</td>
							 <th>${msg.C000000486}</th> <!-- 업종명 -->
								<td>
									<input type="text" id="indutyNm" name="indutyNm" >
								</td>
						</tr>
						<tr>
							 <th>${msg.C000000421}</th> <!-- 사업자등록번호 -->
								<td>
									<input type="text" id="bsnmRegistNo" name="bsnmRegistNo"  onkeydown="onlyNumber(this)">
								</td>
							 <th>${msg.C000000485}</th> <!-- 종목명 -->
								<td>
									<input type="text" id="itemNm" name="itemNm" >
								</td>
							 <th>${msg.C000000420}</th> <!-- 대표자 명 -->
								<td>
									<input type="text" id="rprsntvNm" name="rprsntvNm" >
								</td>
							 <th>${msg.C000000487}</th> <!-- 대표자 영문명 -->
								<td>
									<input type="text" id="rprsntvEngNm" name="rprsntvEngNm"  onkeydown="SetAlphaNum(this)">
							   </td>
						</tr>
						<tr>
							 <th>${msg.C000000159}</th> <!-- E-MAIL -->
								<td>
									<input type="text" id="email" name="email" >
								</td>
							<th>${msg.C000000414}</th> <!-- 전화번호 -->
								<td>
									<input type="text" id="telno" name="telno"  onkeydown="onlyNumber(this)">
								</td>
							<th>${msg.C000000415}</th> <!-- 팩스번호 -->
								<td>
									<input type="text" id="fxnum" name="fxnum"  onkeydown="onlyNumber(this)">
								</td>
							<th class="necessary">${msg.C000000065}</th> <!-- 사용여부 -->
								<td style="text-align:left;">
									<label><input type="radio" id="use_y" name="useAt" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
									<label><input type="radio" id="use_n" name="useAt" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
								</td>
						</tr>
					</table>
					<input type="hidden" id="crud" name="crud" value="C"/>
					<input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
				</form>
			</div>
		</div>
		<br>
		<div id="tabCts2" class="tabCts">
			<div class="subCon1">
				<h2>${msg.C000000488}</h2>  <!-- 업체담당자 정보 -->
				<div class="btnWrap">
					<button type="button" id="btnAddRow" class="btn4">${msg.C000000111}</button> <!-- 행추가 -->
					<button type="button" id="btnRemoveRow" class="delete btn5">${msg.C000000112}</button> <!-- 행삭제 -->
				</div>
				<div class="mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="entrpscMListIdGrid" style="width:100%; height:150px; margin:0 auto;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--  body 끝 -->
    </tiles:putAttribute>
   <tiles:putAttribute name="script">
<!--  script 시작 -->
<script>
//각 그리드 영역의 Id값 저장
var entrpsMListId = 'entrpsMListGrid';
var entrpscMListIdGrid = 'entrpscMListIdGrid';

var entrpsMFrm = 'entrpsMFrm';
var searchentrpscMListIdGridUrl = "<c:url value='/wrk/getEntrpscFMList.lims'/>";
// var saveentrpscMListIdGridUrl = "<c:url value='/wrk/insEntrpscFM.lims'/>";

//그리드 객체를 담을 변수
var entrpsMListGrid;

//pk변수
var entrpsSeqno;
var entrpsSeqno0=$("#entrpsSeqno").val();
var item= AUIGrid.getSelectedIndex(entrpscMListIdGrid);

	//최초 그리드 생성
	 $(function() {
		 getAuth(); //권한 체크

		 entrpsMListGrid = createAUIGrid(columnLayout.entrpsMListGrid,entrpsMListId,{selectionMode : "multipleCells"});

		 gridResize([entrpsMListGrid, entrpscMListIdGrid]);

		 datePickerCalendar(["delngBgnde"], true, ["DD",0]); //거래시작일

		//버튼 이벤트
		setButtonEvent();

		setentrpscMListIdGrid();
		setentrpscMListIdGridEvent();

		auiGridEvent();//AUI 이벤트
// 		$("#tab1").click();//탭클릭
	 });

	var gidID;
	var param;
	var url;

	//그리드 정의
	var columnLayout = {
			entrpsMListGrid : [],
	}

	//업체관리 그리드
	auigridCol(columnLayout.entrpsMListGrid);
	columnLayout.entrpsMListGrid.addColumnCustom("entrpsSeqno","entrpsSeqno","8%",false);
	columnLayout.entrpsMListGrid.addColumnCustom("entrpsNm","${msg.C000000303}","20%",true); /* 업체명 */
	columnLayout.entrpsMListGrid.addColumnCustom("entrpsEngNm","${msg.C000000483}","8%",true); /* 업체 영문명 */
	columnLayout.entrpsMListGrid.addColumnCustom("bizcndNm","${msg.C000000484}","8%",true); /* 업태명 */
	columnLayout.entrpsMListGrid.addColumnCustom("itemNm","${msg.C000000485}","8%",true); /* 종목명 */
	columnLayout.entrpsMListGrid.addColumnCustom("bsnmRegistNo","${msg.C000000421}","8%",true); /* 사업자등록번호 */
	columnLayout.entrpsMListGrid.addColumnCustom("indutyNm","${msg.C000000486}","8%",true); /* 업종명 */
	columnLayout.entrpsMListGrid.addColumnCustom("rprsntvNm","${msg.C000000420}","8%",true); /* 대표자 명 */
	columnLayout.entrpsMListGrid.addColumnCustom("rprsntvEngNm","${msg.C000000487}","8%",true); /* 대표자 영문명 */
	columnLayout.entrpsMListGrid.addColumnCustom("email","${msg.C000000159}","8%",true); /* E-MAIL */
	columnLayout.entrpsMListGrid.addColumnCustom("telno","${msg.C000000414}","8%",true); /* 전화번호 */
	columnLayout.entrpsMListGrid.addColumnCustom("useAt","${msg.C000000065}","8%",true,false); /* 사용여부 */


	//AUI 그리드 이벤트 함수//
	function auiGridEvent(){

	    //업체담당자 정보 그리드 셀 클릭 이벤트
	 	AUIGrid.bind(entrpscMListIdGrid, "cellDoubleClick", function(event){
	   		btnRmRowEvent(entrpscMListIdGrid, event, "#removeRowDetailCode");
	   	});

	 	//기본담당자 여부 중복체크
		AUIGrid.bind(entrpscMListIdGrid, "cellEditEnd", function(event){
			var myValue = AUIGrid.getCellValue(entrpscMListIdGrid, event.rowIndex, "gbnCrud");
			var columnValue = AUIGrid.getCellValue(entrpsMListGrid, event.rowIndex, "entrpsSeqno");

			confirmCodeMGbnList(columnValue, event.rowIndex); // 중복체크 함수 호출

	 		return event.value;
	 	})

	 	//업체담당자 정보 입력, 수정 구분값
	   AUIGrid.bind(entrpscMListIdGrid, "cellEditBegin", function(event){ // 수정 구분
		   editEvent(entrpscMListIdGrid,event, "gbnCrud");
		 	function editEvent(entrpscMListIdGrid, event, selector ){
				item = {
	  	        			gbnCrud : "U"
	  	        		};

		  	    AUIGrid.updateRow(entrpscMListIdGrid, item, "selectedIndex");
		  		var addedRowItems = AUIGrid.getAddedRowItems(entrpscMListIdGrid);
		 		//새로 추가된 행을 편집할때 추가된 행인지 아닌지 구분

		 		for(var i in addedRowItems){
		 			if(editFlag(event, addedRowItems, i)){
		 				return editFlag;
		 			}
		 		}
		 	}

		 	//추가된 행에만 수정
		 	function editFlag(event, addedRowItems, i){
		 		var eventUid = event.item._$uid == undefined ? event.item.null : event.item._$uid;
		 		var addedUid = addedRowItems[i]._$uid == undefined ? addedRowItems[i].null : addedRowItems[i]._$uid;
		 		switch (event.item._$uid){
		 			case addedRowItems[i]._$uid :
		 				item = {
	  	        			gbnCrud : "C"
	  	        		};

		  	       		AUIGrid.updateRow(entrpscMListIdGrid, item, "selectedIndex");
		 				return true;
		 	  	}
		 	}
	   })

	}

	//업체담당자정보 생성
	function setentrpscMListIdGrid(){

	////그리드 정의 userGrid
		var entrpscMListIdGridCol = [];
		auigridCol(entrpscMListIdGridCol);
		//컬럼 속성 정의
		var entrpscMListIdGridColPros = {
			style : "my-require-style",
			headerTooltip : { // 헤더 툴팁 표시 일반 스트링
				show : true,
				tooltipHtml : '${msg.C000000263}' /* 값을 입력 또는 선택하세요. */
			}
			//styleFunction : cellStyleFunction
		};
		entrpscMListIdGridCol.addColumnCustom("entrpsSeqno","entrpsSeqno",null,false,null);
		entrpscMListIdGridCol.addColumnCustom("chargerNm", "${msg.C000000183}",null,true,true,entrpscMListIdGridColPros); /* 담당자 명 */
		entrpscMListIdGridCol.addColumnCustom("chargerDeptNm", "${msg.C000000490}",null,true,true,entrpscMListIdGridColPros); /* 담당자 부서명 */
		entrpscMListIdGridCol.addColumnCustom("chargerMoblphon", "${msg.C000000491}",null,true,true,entrpscMListIdGridColPros); /* 담당자 이동전화 */
		entrpscMListIdGridCol.addColumnCustom("chargerTelno", "${msg.C000000492}",null,true,true,entrpscMListIdGridColPros); /* 담당자 전화번호 */
		entrpscMListIdGridCol.addColumnCustom("chargerFxnum", "${msg.C000000493}",null,true,true,entrpscMListIdGridColPros); /* 담당자 팩스번호 */
		entrpscMListIdGridCol.addColumnCustom("chargerEmail", "${msg.C000000494}",null,true,true,entrpscMListIdGridColPros); /* 담당자 이메일 */
		entrpscMListIdGridCol.addColumnCustom("bassChargerAt", "${msg.C000000495}",null,true,true,entrpscMListIdGridColPros); /* 기본 담당자 여부 */
		entrpscMListIdGridCol.addColumnCustom("rm","${msg.C000000096}",null,true,true,entrpscMListIdGridColPros); /* 비고 */
		entrpscMListIdGridCol.addColumnCustom("useAt","${msg.C000000065}",null,true,true,entrpscMListIdGridColPros); /* 사용여부 */
		entrpscMListIdGridCol.addColumnCustom("gbnCrud", "gbnCrud","10%",false,true);
		entrpscMListIdGridCol.addColumnCustom("chargerSeqno", "chargerSeqno","10%",false,true);
		entrpscMListIdGridCol.dropDownListRenderer(["bassChargerAt"],["Y","N"],null);
		entrpscMListIdGridCol.dropDownListRenderer(["useAt"], ["Y","N"],null);

		//속성
		var entrpscMListIdGridPros = {
			showStateColumn : true,
			// 칼럼 끝에서 오른쪽 이동 시 다음 행, 처음 칼럼으로 이동할지 여부
			wrapSelectionMove : true,

			// 사용자가 추가한 새행은 softRemoveRowMode 적용 안함.
			// 즉, 바로 삭제함.
			softRemoveRowMode : true,
			softRemovePolicy : "exceptNew"
		};

		// 실제로 #grid_wrap 에 그리드 생성
		entrpscMListIdGrid = createAUIGrid(entrpscMListIdGridCol, entrpscMListIdGrid, entrpscMListIdGridPros);
	};



	function setentrpscMListIdGridEvent(){
		AUIGrid.bind(entrpscMListIdGrid, "ready", function(event) {
			gridColResize(entrpscMListIdGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
		});

		// CRUD 체크
		AUIGrid.bind(entrpscMListIdGrid, "cellEditEnd", null);
		// 행 추가 이벤트 바인딩
		AUIGrid.bind(entrpscMListIdGrid, "addRow", null);
		// 행 삭제 이벤트 바인딩
		AUIGrid.bind(entrpscMListIdGrid, "removeRow", null);

		// soft 삭제로 설정된 행들 진짜로 그리드에서 제거 이벤트 바인드
		AUIGrid.bind(entrpscMListIdGrid, "removeSoftRows", function(event) {
			alert(event.type + "${msg.C000000496}" + event.items.length);  /* , 총 삭제 행 수 : */
		});
	};

	// 업체담당자 정보 그리드 행추가 이벤트
	$('#btn_add').click(function(){
		if($("#entrpsSeqno").val() != null && $.trim($("#entrpsSeqno").val()) != ""){
			addRow();
		} else {
			alert('${msg.C000000497}'); /* 담당자를 추가할 업체를 선택해주세요. */
		}
	});

	/*############ 조회, 저장, 삭제 함수 ############*/

	function setButtonEvent(){
		$("#srchBtn").click(function(){
			searchEntrpsM();
		});

		$('#btn_save').click(function(){
			saveEntrpsM();
		});

		$("#btn_delete").click(function(){
			deleteEntrpsM();
		})

		//행추가
		$("#btnAddRow").click(function (){
			addRow();
		});

		//행삭제
		$("#btnRemoveRow").click(function (){
			var seletedRowIndex = AUIGrid.getSelectedItems(entrpscMListIdGrid)[0].rowIndex
			AUIGrid.setCellValue(entrpscMListIdGrid, seletedRowIndex, "gbnCrud", 'D');
			removeRow();
		});

	}

	//업체관리 조회
	function searchEntrpsM(srch){
		url="<c:url value='/wrk/getEntrpsFMList.lims'/>";
		divID="entrpsMListGrid";
		formId=$("#srchForm").attr('id');

		getGridDataForm(url, formId, divID);

		AUIGrid.bind(entrpsMListGrid, "cellDoubleClick", function(event) {
			$('#entrpsSeqno').val(event.item.entrpsSeqno);
			$('#entrpsNm').val(event.item.entrpsNm);
			$('#entrpsEngNm').val(event.item.entrpsEngNm);
			if(event.item.useAt == 'Y')
				$("#use_y").val(event.item.useAt).prop("checked", true);
			else
				$("#use_n").val(event.item.useAt).prop("checked", true);
			$('#bizcndNm').val(event.item.bizcndNm);
			$('#itemNm').val(event.item.itemNm);
			$('#bsnmRegistNo').val(event.item.bsnmRegistNo);
			$('#indutyNm').val(event.item.indutyNm);
			$('#rprsntvNm').val(event.item.rprsntvNm);
			$('#rprsntvEngNm').val(event.item.rprsntvEngNm);
			$('#sttemntOrPrmisnNo').val(event.item.sttemntOrPrmisnNo);
			$('#delngBgnde').val(event.item.delngBgnde);
			$('#email').val(event.item.email);
			$('#zip').val(event.item.zip);
			$('#adres').val(event.item.adres);
			$('#detailAdres').val(event.item.detailAdres);
			$('#telno').val(event.item.telno);
			$('#fxnum').val(event.item.fxnum);
			$('#crud').val("U");
			searchentrpscMListIdGrid(event.item.entrpsSeqno);//업체담당자정보 그리드 호출
		});
	}

	//업체정보 저장 및 수정
	function saveEntrpsM(){
		console.log("crud : ",$('#entrpsMFrm').serialize());
		var saveUrl = "<c:url value='/wrk/insEntrpsFM.lims'/>";
		var count = 0;
		// 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승
		$('#entrpsMFrm').find('input').each(function(){
			var nm = $(this).attr("name");
		    if( nm == "entrpsNm" || nm == "useAt"){
				if(!$(this).prop('required')){
			    	if($(this).val() == '') {
			    		count ++;
			    		return;
			    }
		 	}
	 	}
	});
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var entrpscMListData = AUIGrid.getGridData(entrpscMListIdGrid);
		var item;
		var invalid = false;
		var invalidRowIndex = -1;
		var colIndex;
		var entrpsSeqno = $("#entrpsSeqno").val();
		var saveValiColumn ;

		console.log("entrpsSeqno : " , $("#entrpsSeqno").val());

		for(var i=0, len=entrpscMListData.length; i<len; i++) {
			var item = entrpscMListData[i];

			// 칼럼의 값이 입력 안됐는지 체크
			if(typeof item["chargerNm"] == "undefined" || String(item["chargerNm"]).trim() == ""){
				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(entrpscMListIdGrid, "chargerNm");
				break;
			}
		}

		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			alert("${msg.C000000499}"); /* 담당자명을 입력해주세요. */
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(entrpscMListIdGrid, invalidRowIndex, colIndex);

			return false;
		}

		var entrpsMFrm = $("#entrpsMFrm").serializeObject();
			entrpsMFrm.chargerList = entrpscMListData;

		// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
		if(count > 0) {
			alert('${msg.C000000169}'); /* 필수 사항을 모두 입력해 주십시오 */
			return;
		} else {
			ajaxJsonGridParam(saveUrl, entrpsMFrm, function (data) {
				if(data == 0 ){
					alert('${msg.C000000170}'); /* 저장에 실패하였습니다. */
				}else{
	 				alert('${msg.C000000071}'); /* 저장 되었습니다. */
						$('#entrpsMFrm')[0].reset(); // 폼 초기화
						searchEntrpsM(); // 그리드 초기화
						AUIGrid.clearGridData(entrpscMListIdGrid);
				}
			});
		}
	}

	function deleteEntrpsM (){
		ajaxJsonParam("/wrk/deleteEntrpsFM.lims",{"entrpsSeqno":$("#entrpsSeqno").val()},function(data){
			if(data){
				alert("${msg.C000000179}"); /* 삭제되었습니다. */
				searchEntrpsM();
				$("#entrpsMFrm")[0].reset();
				AUIGrid.clearGridData(entrpscMListIdGrid);
			}
		});
	}

	//업체관리 클릭 시 업체담당자 정보
	function searchentrpscMListIdGrid(entrpsSeqno){
		getGridDataForm(searchentrpscMListIdGridUrl, entrpsMFrm, entrpscMListIdGrid);
	};

	/*############ 기타이벤트 함수 ############*/

	// 기본 담당자 중복확인
	function confirmCodeMGbnList(columnValue, rowIndex){
		var rows = AUIGrid.getRowIndexesByValue(entrpscMListIdGrid, "bassChargerAt", "Y");
		if (rows.length > 1){
			alert("${msg.C000000137}"); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
			AUIGrid.setCellValue(entrpscMListIdGrid, rowIndex, "bassChargerAt","N");
		}
	}

	//행추가
	 function addRow() {
		var item = new Object();
		var entrpsSeqno0=$("#entrpsSeqno").val();
		item.entrpsSeqno = entrpsSeqno0
		item.bassChargerAt = "N"
		item.useAt = "Y"
	    item.gbnCrud = "C" // insert 구분값
		AUIGrid.addRow(entrpscMListIdGrid, item, "last");

	};

	//행삭제
	function removeRow() {
		AUIGrid.removeRow(entrpscMListIdGrid, "selectedIndex");
	}

	function onlyNumber(obj) {
	    $(obj).keyup(function(){
	         $(this).val($(this).val().replace(/[^0-9]/g,""));
	    });
	}

	//우편번호 찾기
	$("#btnDptSearch").click(function(){
		dialogAddress('zip', 'adres');
	})

	// 신규 클릭 이벤트
	$('#btn_new').click(function(){
	 // flag : create 변경
		$('#gbnCrud').val('C');
		$('#crud').val('C');
		// 폼 초기화
		$('#entrpsMFrm')[0].reset();
		AUIGrid.clearGridData(entrpscMListIdGrid);
	});

	$( '#email' ).change(function(){
		emailChk(this);
	});

	// 업체명 중복 체크 함수
	function entrpsChk(){
		var entrps = $('#entrpsNm').val();
		var chkUrl = "<c:url value='/wrk/userValidationF.lims'/>";
		if(entrps != ''){
			ajaxJsonForm(chkUrl, 'entrpsMFrm', function (data) {

				if(data != 0 ){
					alert('${msg.C000000137}'); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
					$('#entrpsNm').val('');
				}
			});
		}
	}

	// 업체명 중복 체크
	$( '#entrpsNm' ).change(function(){
		//var loginId = $("#entrpsNm").val()
			entrpsChk();
	});


	//영문만 입력
	function SetAlphaNum(obj){
		val=obj.value;
		re=/[^a-zA-Z]/gi;
		obj.value=val.replace(re,"");
	}

	//이메일 체크
	function emailChk(obj){
		var emailVal = $(obj).val();
		var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		if(!emailVal.match(regExp)){
			alert("${msg.C000000173}"); /* 이메일형식이 올바르지 않습니다. */
			$(obj).val('');
		}
	}

	//조회 조건 엔터키 이벤트
	$("#srchentrpsNm, #srchrprsntvNm, #srchbsnmRegistNo").on("keydown", function(key){
		if(key.keyCode==13){
			$("#srchBtn").click();
		}
	});



</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>

