<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">미등록 알림</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">
var dlivyGrid;
var dlivyEmailGrid;
var lang = ${msg}; // 기본언어

$(function(){
	getAuth();

	//초기화
	init();

	//콤보박스 세팅
	setCombo();

	//데이터 미등록 알림 그리드 생성
	setDlivyGrid();

	//알림대상자 지정 그리드 생성
	setDlivyEmailGrid();

	//버튼 이벤트
	setButtonEvent();

	//그리드 이벤트
	setGridEvent();
});

function init(){
	datePickerCalendar(["shrDlivyDteBeginDte", "shrDlivyDteEndDte"], true, ["DD",0], ["DD",0]);

	var params = {
			gridId : "dlivyEmailGrid"
	}

	//사용자 팝업
	dialogUser("btn_user_add", params, "dlivyEmailUserDialog", function(data){

		var array = new Array();
		for(var i=0; i<data.length; i++){
			var resultParam = {};
			resultParam.userId = data[i]["item"]["userId"];
			resultParam.loginId = data[i]["item"]["loginId"];
			resultParam.email = data[i]["item"]["email"];
			resultParam.userNm = data[i]["item"]["userNm"];
			array.push(resultParam);
		}
		AUIGrid.addRow(dlivyEmailGrid, array);
	}, function(){}, null, 'Y');

	changePointDialog("btn_dlivyNoty", {ntcnSeCode : "SY18000003"}, "dlivyNoty", function(data){}, null);

}

//콤보박스 세팅
function setCombo(){

	var dept = [
		{"value" : "", "name" : "선택"},
		{"value" : "3975", "name" : "제조2팀"},
		{"value" : "3980", "name" : "훽트제조팀"}
	];

	var str = "";

	for(var i=0; i<dept.length; i++){
		str += "<option value='"+dept[i]["value"]+"'>"+dept[i]["name"]+"</option>";
	}

	$("#shrDeptCode").append(str);
	$("#inspctInsttCode").append(str);

}

//데이터 미등록 알림 그리드 생성
function setDlivyGrid(){

	var col = [];

	auigridCol(col);

	col.addColumnCustom("reqestDeptCode", "${msg.C000000080}", "*" ,false); /* 부서 */
	col.addColumnCustom("reqestDeptNm", "${msg.C000000080}", "*" ,true); /* 부서 */
	col.addColumnCustom("dlivyOrdeSeqno", "${msg.C000001167}", "*" ,false); /* 출고 지시서 일련번호 */
	col.addColumnCustom("dlivyDte", "${msg.C000001168}", "*" ,true); /* 날짜 */
	col.addColumnCustom("lotId", "${msg.C000001169}", "*", true, true); /* LOT */
	col.addColumnCustom("reqAt", "${msg.C000001354}", "*", true); /* 의뢰여부 */
	col.addColumnCustom("dlivyHm", "${msg.C000001170}", "*", true, true);	/* 출고시간 */
	col.addColumnCustom("emailSndngTm", "${msg.C000001171}", "*", true, true); /* 시간(분) */
	col.addColumnCustom("emailSendDate", "${msg.C000001172}", "*", true); /* 메일 발송 날짜 */
	col.addColumnCustom("emailSendTime", "${msg.C000001173}", "*", true); /* 메일 발송 시간 */
	col.addColumnCustom("mtrilNm", "${msg.C000000228}", "*", true); /* 자재명 */
	col.addColumnCustom("rm", "${msg.C000000096}", "*", true); /* 비고 */
	col.addColumnCustom("dvyfgEntrpsNm", "${msg.C000000856}", "*", true); /* 납품업체 명 */
	col.addColumnCustom("mtrilCode", "${msg.C000000214}", "*", false); /* 자재코드 */
	col.addColumnCustom("reqestSeqno", "의뢰 일련번호", "*", false);





	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true,
 	 		showStateColumn : true
 	}


	//auiGrid 생성
	dlivyGrid = createAUIGrid(col, "dlivyGrid", cusPros);
	// 그리드 리사이즈.
	gridResize([dlivyGrid]);
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(dlivyGrid, "ready", function(event) {
		gridColResize([dlivyGrid],"1");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//알림대상자 지정 그리드 생성
function setDlivyEmailGrid(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("userId", "${msg.C000000808}", "*", false); /* 사용자 ID */
	col.addColumnCustom("loginId", "${msg.C000001174}", "*", true); /* 대상자 ID */
	col.addColumnCustom("userNm", "${msg.C000001175}", "*", true); /* 대상자 명 */
	col.addColumnCustom("email", "${msg.C000001176}", "*", false); /* 이메일 */

	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true
 	}


	//auiGrid 생성
	dlivyEmailGrid = createAUIGrid(col, "dlivyEmailGrid", cusPros);
	// 그리드 리사이즈.
	gridResize([dlivyEmailGrid]);
	// 그리드 칼럼 리사이즈
	AUIGrid.bind(dlivyEmailGrid, "ready", function(event) {
		gridColResize([dlivyEmailGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});

	if("${auditAt}" == "Y"){
		//고객사일때 의뢰여부 컬럼 숨김
		AUIGrid.hideColumnByDataField(dlivyGrid, "reqAt");
	}
}



//버튼 이벤트
function setButtonEvent(){

	//조회 이벤트
	$("#btn_select").click(function(){
		searchDlivy();
	});

	//출고지시서 업로드
	$("#btn_form_upload").click(function(){

		if(!formNecessaryValidationCheck("dlivyForm")){
			return;
		}

		var file = $("#formFile")[0];
		//파일 없으면 리턴
		if(!file.files[0]){
			alert("${msg.C000000434}"); //파일을 선택해주세요.
			return;
		}

		showLoadingbar();

		var fileName = file.files[0].name;
		var fileExt = fileName.substring(fileName.length, fileName.length-4);


		var formData = new FormData();
		formData.append("formFile", $("#formFile")[0].files[0]);
		formData.append("formType", $("#inspctInsttCode").val());

		ajaxJsonFormFile("/dly/dlivyAllamExcelUpload.lims", formData, function(data){

			if(data["result"] == true){
				alert(data["msg"]); /* 저장 되었습니다. */

				for(var i=0; i<data["params"].length; i++){
					var dateTime = getEmailSendDateTime(data["params"][i]["emailSndngTm"], data["params"][i]["dlivyDte"], data["params"][i]["dlivyHm"], "old").split(" ");

					data["params"][i]["emailSendDate"] = dateTime[0];
					data["params"][i]["emailSendTime"] = dateTime[1];

					data["params"][i]["reqestDeptCode"] = $("#inspctInsttCode").val();
					data["params"][i]["reqestDeptNm"] = $("#inspctInsttCode option:checked").text();

				}

				for(var i=data["params"].length; i >= 0; i--){
					AUIGrid.addRow(dlivyGrid, data["params"][i], 0);
				}
			}
			else{
				alert(data["msg"]);  /* 저장에 실패하였습니다. */
			}

			hideLoadingbar();
		}, null, null);
	});

	//저장버튼 클릭 이벤트
	$("#btn_save").click(function(){

		var listGridData = AUIGrid.getEditedRowItems(dlivyGrid);
		var addListGridData = AUIGrid.getAddedRowItems(dlivyGrid);
		var removeListGridData = AUIGrid.getRemovedItems(dlivyGrid);

		//저장할 데이터가 없으면 리턴
		if(listGridData.length == 0 && addListGridData.length == 0 && removeListGridData.length == 0){
			alert("${msg.C000001113}"); /* 저장할 데이터가 없습니다. */
			return;
		}

		var addLotBool = true;
		var editLotBool = true;

		var gridAddData = AUIGrid.getAddedRowItems(dlivyGrid);
		var gridEditData = AUIGrid.getEditedRowItems(dlivyGrid);

		if(gridAddData.length > 0){
			addLotBool = getCheckLotId(gridAddData);
		}

		if(gridEditData.length > 0){
			editLotBool = getCheckLotId(gridEditData);
		}

		//잘못된 lot가 있으면 저장못함
		if(addLotBool == false){
			return;
		}

		//잘못된 lot가 있으면 저장못함
		if(editLotBool == false){
			return;
		}

		listGridData = AUIGrid.getEditedRowItems(dlivyGrid);
		addListGridData = AUIGrid.getAddedRowItems(dlivyGrid);
		removeListGridData = AUIGrid.getRemovedItems(dlivyGrid);

		if(confirm("${msg.C000000306}")){ //저장하시겠습니까?

			showLoadingbar();

			var params = {};

			params.listGridData = listGridData;
			params.addListGridData = addListGridData;
			params.removeListGridData = removeListGridData;

			ajaxJsonParam("<c:url value='/dly/insDlivyInfo.lims'/>", params, function(data){
				if(data > 0){
					alert("${msg.C000000071}"); /* 저장 되었습니다. */
					searchDlivy();

					//알림대상자 초기화
					dlivyEmailGridReset();
				}
				else{
					alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
				}
				hideLoadingbar();
			});
		}

	});


	//대상자 이메일 저장 버튼 클릭 이벤트
	$("#btn_user_save").click(function(){

		if(!$("#dlivyOrdeSeqno").val()){
			alert("${msg.C000001177}"); /*출고지시서 정보를 선택해주세요.*/
			return;
		}

		if(confirm("${msg.C000000306}")){ //저장하시겠습니까?
			showLoadingbar();
			var params = {};
			params.dlivyOrdeSeqno = $("#dlivyOrdeSeqno").val();
			params.listGridData = AUIGrid.getGridData(dlivyEmailGrid);

			ajaxJsonParam("<c:url value='/dly/insAddDlivyEmail.lims'/>", params, function(data){
				if(data > 0){
					alert("${msg.C000000071}"); /* 저장 되었습니다. */
					var params = {dlivyOrdeSeqno : $("#dlivyOrdeSeqno").val()};
					getGridDataParam("<c:url value='/dly/getEmailDlivyList.lims'/>", params, dlivyEmailGrid);
				}
				else{
					alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
				}
				hideLoadingbar();
			});
		}

	});

	//대상자 삭제
	$("#btn_user_del").click(function(e){
		AUIGrid.removeCheckedRows(dlivyEmailGrid);
	});

	//미등록 알림 목록 행삭제
	$("#btn_del").click(function(e){
		AUIGrid.removeCheckedRows(dlivyGrid);
	});

	//양식 다운로드
	$("#btn_form_download").click(function(){
		location.href = ${formFilePath} + "/assets/formFile/출고지시서.xlsx";
	});
}

//그리드 이벤트 선언
function setGridEvent(){

	//데이터 미등록 알림 그리드 셀 변경시 숫자, 2자리 이하로만 입력
	AUIGrid.bind(dlivyGrid, "cellEditEndBefore", function( e ) {
		var dlivyHmBool = true;

		if(e.dataField == "dlivyHm"){
			var timeRegExp = /^([1-9]|[01][0-9]|2[0-3]):([0-5][0-9])$/;
			dlivyHmBool = timeRegExp.test(e.value);

		}

		if(dlivyHmBool == false){
			alert("${msg.C000001309}"); /* HH:MM 형식으로 입력해 주세요. */
			return "";
		}

		if(e.dataField == "emailSndngTm"){
			//2자리 이하만
		    if(e.value.length > 2){
		    	return e.oldValue;
		    }

		    var regexp = /^[0-9]*$/;
		    //숫자만
		    if( !regexp.test(e.value) ) {
		    	return e.oldValue;
		    }
		}

	    return e.value;
	});

	//데이터 미등록 알림 그리드 셀 변경 종료 이벤트
	AUIGrid.bind(dlivyGrid, "cellEditEnd", function(e){

		if(e.dataField == "emailSndngTm" || e.dataField == "dlivyHm"){
			var emailSndngTm = e["item"]["emailSndngTm"];
			var dlivyDte = e["item"]["dlivyDte"];
			var dlivyHm = e["item"]["dlivyHm"];

			//시간(분) 을 변경하면 메일 발송 시간을 변경한다.
			var dateTime = getEmailSendDateTime(emailSndngTm, dlivyDte, dlivyHm, "new").split(" ");

			AUIGrid.setCellValue(dlivyGrid, e.rowIndex, "emailSendDate", dateTime[0]);
			AUIGrid.setCellValue(dlivyGrid, e.rowIndex, "emailSendTime", dateTime[1]);
		}
 	});

	//데이터 미등록 알림 그리드 셀 더블클릭 이벤트
	AUIGrid.bind(dlivyGrid, "cellDoubleClick", function(e){
		var params = {dlivyOrdeSeqno : e["item"]["dlivyOrdeSeqno"]};
		getGridDataParam("<c:url value='/dly/getEmailDlivyList.lims'/>", params, dlivyEmailGrid);
		$("#dlivyOrdeSeqno").val(e["item"]["dlivyOrdeSeqno"]);
 	});

}

//미등록 알리 리스트 조회
function searchDlivy(keyCode){
	if(keyCode != undefined && keyCode == 13)
		searchDlivy();
	else {
		if(keyCode == undefined) {
			ajaxJsonForm("<c:url value='/dly/getDlivyList.lims'/>", 'searchFrm', function (data) {

				for(var i=0; i<data.length; i++){
					var dateTime = getEmailSendDateTime(data[i]["emailSndngTm"], data[i]["dlivyDte"], data[i]["dlivyHm"], "old").split(" ");

					data[i]["emailSendDate"] = dateTime[0];
					data[i]["emailSendTime"] = dateTime[1];
				}

				AUIGrid.setGridData(dlivyGrid, data);
				AUIGrid.setColumnPropByDataField( dlivyGrid, "lotIdDummy", { width : 50 } );
			});
		}
	}
}

//저장할때 유효한 lot인지 조회
function getCheckLotId(gridData){

	var result = true;

	//lot 유효성 검사
	for(var i=0; i<gridData.length; i++){

		if(gridData[i]["lotId"]){
			ajaxJsonParam("<c:url value='/dly/getLotValidation.lims'/>", {lotId : gridData[i]["lotId"]}, function(data){
				if(data <= 0){
					alert("${msg.C000001310}"); /* 잘못된 lot가 있습니다. */
					AUIGrid.setSelectionByIndex(dlivyGrid, i, 4);
					result = false;
				}
			});
		}
		else{
			AUIGrid.setCellValue(dlivyGrid,  i, "reqestSeqno", "");
		}

		if(result == false){
			break;
		}
	}

	return result;
}

/**
 * 메일 발송 날짜, 메일 발송 시간을 계산하여 리턴해줌
 * 0시부터 9시까지(취약시간) 전날 23:20 분 메일발송 시간이고 9시 부터 0시 까지는 -40분
 */
function getEmailSendDateTime(emailSndngTm, dlivyDte, dlivyHm, type){
	if(!dlivyHm){
		return "";
	}
	var dateTime = "";
	var a = dlivyHm;
	var b = a.split(":");
	var getDateTime;

	if(b[0] < 9 && type == "old"){
		var d1 = new Date(dlivyDte);
		d1.setDate(d1.getDate() -1);
		getDateTime = getTimeStamp(d1).split(" ");

		dateTime = getDateTime[0] +" "+ "23:20";
	}
	else{
		if(b[0] < 9 && !emailSndngTm){
			if(!emailSndngTm){
				var d1 = new Date(dlivyDte);
				d1.setDate(d1.getDate() -1);
				getDateTime = getTimeStamp(d1).split(" ");

				dateTime = getDateTime[0] +" "+ "23:20";
			}
		}else{
			var _time = dlivyDte + "T" + dlivyHm;
			var d1 = new Date(_time);
			d1.setMinutes(d1.getMinutes() - emailSndngTm);
			getDateTime = getTimeStamp(d1).split(" ");

			var time = getDateTime[1].split(":");

			dateTime = getDateTime[0] +" "+ getDateTime[1];
		}
	}
	return dateTime;
}

/**
 * javascript 시간 포멧 변경해줌 yyyy-MM-dd hh:mm
 */
function getTimeStamp(d) {
	var s =
    leadingZeros(d.getFullYear(), 4) + '-' +
    leadingZeros(d.getMonth() + 1, 2) + '-' +
    leadingZeros(d.getDate(), 2) + ' ' +

    leadingZeros(d.getHours(), 2) + ':' +
    leadingZeros(d.getMinutes(), 2);

	return s;
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
    	for (i = 0; i < digits - n.length; i++){
    		zero += '0';
    	}
	}
	return zero + n;
}

//알림대상자 초기화
function dlivyEmailGridReset(){
	$("#dlivyOrdeSeqno").val("");
	AUIGrid.clearGridData(dlivyEmailGrid);
}



</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000684}</h2> <!-- 미등록 알림 -->
		<div class="btnWrap">
			<button type="button" id="btn_dlivyNoty" class="btn3 search">${msg.C000001353}</button><!-- 미등록 알림설정 -->
			<button type="button" id="btn_select" class="btn3 search">${msg.C000000002}</button><!-- 조회 -->
		</div>

		<form id="searchFrm">
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
					<th>${msg.C000000080}</th><!-- 부서 -->
					<td><select id="shrDeptCode" name="shrDeptCode" class="wd100p" style="min-width:10em;"></select></select></td>
					<th>${msg.C000000712}</th><!-- 날짜 -->
					<td colspan="5" style="text-align:left;">
						<input type="text" id="shrDlivyDteBeginDte" name="shrDlivyDteBeginDte" class="wd10p" style="min-width: 10em;">
						~
						<input type="text" id="shrDlivyDteEndDte" name="shrDlivyDteEndDte" class="wd10p" style="min-width: 10em;">
					</td>
			</table>
		</form>
	</div>

	<div class="subCon1 wd70p mgT15 fL">
		<h3>${msg.C000000711}</h3><!-- 미등록 알림 목록 -->
		<label style="color:red;" class="fR">${msg.C000001311}</label> <!-- *메일 발송 시간 추가나 수정시 발송시간 기준 20분전 까지는 입력해주세요. -->
		<div class="btnWrap">
			<button type="button" id="btn_del" class="btn5 save">${msg.C000000112}</button><!-- 행삭제 -->
			<button type="button" id="btn_save" class="btn1 save">${msg.C000000015}</button><!-- 저장 -->
		</div>
		<div id="dlivyGrid" class="mgT15" style="width:100%; height:370px; margin:0 auto;"></div>
	</div>
	<div class="subCon1 wd1p mgT15 fL">
	</div>
	<div class="subCon1 wd25p mgT15 fR">
		<h3>${msg.C000001178}</h3><!-- 알림 대상자 -->
		<!-- 저장버튼 -->
		<div class="btnWrap">
			<button type="button" id="btn_user_add" class="old_btn old_btn4 save">${msg.C000000682}</button><!-- 사용자 추가 -->
			<button type="button" id="btn_user_del" class="old_btn old_btn5 save">${msg.C000000112}</button><!-- 행삭제 -->
			<button type="button" id="btn_user_save" class="old_btn old_btn1 save">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<div id="dlivyEmailGrid" class="mgT15" style="width:100%; height:370px; margin:0 auto;"></div>
	</div>

	<form id="dlivyForm">
	<div class="subCon1 wd100p mgT15 fL">
		<input type="hidden" id="dlivyOrdeSeqno" value="">
		<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
			<colgroup>
				<col style="width:10%"></col>
				<col style="width:90%"></col>
			</colgroup>
			<tr>
				<th class="necessary">${msg.C000000080}</th> <!-- 부서 -->
				<td style="text-align:left;">
					<select id="inspctInsttCode" name="inspctInsttCode" class="wd20p"></select>
					<label style="color:red;">${msg.C000001179} </label> <!-- *출고지시서 업로드 후 저장버튼을 눌러야 저장이 됩니다. -->
				</td>
				</tr>
			<tr>
				<th>${msg.C000000600}</th><!-- 양식 업로드 -->
				<td style="text-align:left;">
					<!-- 파일첨부영역 -->
					<input type="file" id="formFile" name="formFile" class="wd30p" style="min-width:10em;">
					<button type="button" id="btn_form_upload" class="old_btn old_btn1 save">${msg.C000000713}</button><!-- 출고지시서 업로드 -->
				</td>
			</tr>
		</table>
	</div>
	</form>

</div>
<!--  body 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>