<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">이슈관리</tiles:putAttribute>
<tiles:putAttribute name="script">

<style>
#chartDivFrame{
	border-width: 0px;
    border-top-width: 0px;
    border-right-width: 0px;
    border-bottom-width: 0px;
    border-left-width: 0px;
}
</style>

<script type="text/javascript">
var issueList;
var lang = ${msg}; // 기본언어

$(document).ready(function(){
	//권한
	getAuth();

	//초기 세팅
	init();

	//콤보박스 세팅
	setCombo();

	//그리드 세팅
	setIssueListGrid();

	//버튼 이벤트
	setButtonEvent();

	//그리드 이벤트
	setGridEvent();

	$("[name='shrInnerIssueAt']").trigger('change');
});

//초기세팅
function init(){
	datePickerCalendar(["shrIssueRegistBeginDt", "shrIssueRegistEndDt"], true, ["DD",-14], ["DD",0]);

	//이슈구분 선택이벤트
	issueSeCodeCombo($("[name='innerIssueAt']").val());

	//의뢰 팝업
	requestDialog("btn_pop_request", "requestDialog", {}, function(data){

		$("#lotIdText").val(data["lotId"]);
		$("#reqestSeqno").val(data["reqestSeqno"]);

		$("[name='innerIssueAt']:radio[value='N']").prop("checked", true);
		issueSeCodeCombo("N");
		$("[name='innerIssueAt']").prop("disabled", true);
	});

	dialogUser("btn_pop_user", null, "userDialog", function(data){
		$("#issueConfmerNm").val(data["userNm"]);
		$("#issueConfmerId").val(data["userId"]);
	});
}

//콤보박스 세팅
function setCombo(){
	//제조
	var bestParams = {"mmnySeCode" : "SY01000001", "analsAt" : "Y"};
	ajaxJsonComboBox("/wrk/getDeptList.lims", "shrReqestDeptCode", bestParams, true, "${msg.C000000079}");

	//프로세스 타입
	ajaxJsonComboBox("/com/getCmmnCode.lims", "shrProcessTyCode", {upperCmmnCode : "SY02"}, true);

	//상태
	ajaxJsonComboBox("/com/getCmmnCode.lims", "shrIssueProgrsSittnCode", {upperCmmnCode : "IM11"}, true);
	ajaxJsonComboBox("/com/getCmmnCode.lims", "issueProgrsSittnCode", {upperCmmnCode : "IM11"}, true);

 	ajaxJsonComboBox("/wrk/getSrchPrductList.lims","shrPrductNm",$("#searchFrm").serializeObject() , true);

	//부적합 유형
	ajaxJsonComboBox("/com/getCmmnCode.lims", "shrImproptTyCode", {upperCmmnCode : "IM13"}, true);
	ajaxJsonComboBox("/com/getCmmnCode.lims", "improptTyCode", {upperCmmnCode : "IM13"}, true);

	//이슈구분
	ajaxJsonComboBox("/com/getCmmnCode.lims", "shrissueSeCode", {upperCmmnCode : "IM12", tmprField1Nm : "Y"}, true);

}
//그리드 세팅
function setIssueListGrid(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("issueSeqno", "${msg.C000000697}", "*" ,true); //이슈번호
	col.addColumnCustom("lotId", "${msg.C000000575}", "*", true); //LOT ID
	col.addColumnCustom("lotIdText", "${msg.C000000575}", "*", false); //LOT ID
	col.addColumnCustom("prductSeqno", "${msg.C000000319}", "*", false); //제품
	col.addColumnCustom("prductNm", "${msg.C000000319}", "*", true); //제품
	col.addColumnCustom("innerIssueNm", "${msg.C000000701}", "*", true); //내부 이슈 여부
	col.addColumnCustom("improptTyNm", "${msg.C000000702}", "*", true); //부적합 유형
	col.addColumnCustom("issueSeNm", "${msg.C000000704}", "*", true); //이슈 구분
	col.addColumnCustom("issueSj", "${msg.C000000463}", "*", true); //제목
	col.addColumnCustom("reqestDeptCode", "${msg.C000000080}", "*", false); //부서
	col.addColumnCustom("reqestDeptNm", "${msg.C000000080}", "*", true); //부서
	col.addColumnCustom("processTyCode", "${msg.C000000213}", "*", false); //프로세스 타입
	col.addColumnCustom("processTyNm", "${msg.C000000213}", "*", true); //프로세스 타입
	col.addColumnCustom("expriemCn", "${msg.C000000320}", "*", true); //시험항목
	col.addColumnCustom("issueProgrsSittnNm", "${msg.C000000715}", "*", true); //상태
	col.addColumnCustom("issueProgrsSittnCode", "${msg.C000000715}", "*", false); //상태 코드
	col.addColumnCustom("issueProgrsSittnCodeIns", "${msg.C000000715}", "*", false); //상태 코드
	col.addColumnCustom("jdgmntWordCode", "${msg.C000000699}", "*", false); //이슈유형
	col.addColumnCustom("jdgmntWordNm", "${msg.C000000699}", "*", false); //이슈유형
	col.addColumnCustom("lastChangerId", "${msg.C000000703}", "*", false); //이슈등록자
	col.addColumnCustom("lastChangerNm", "${msg.C000000703}", "*", false); //이슈등록자
	col.addColumnCustom("issueRegistDt", "${msg.C000000114}", "*", true); //등록일
	col.addColumnCustom("innerIssueAt", "${msg.C000000701}", "*", false); //내부 이슈 여부
	col.addColumnCustom("improptTyCode", "${msg.C000000702}", "*", false); //부적합 유형
	col.addColumnCustom("issueSeCode", "${msg.C000000704}", "*", false); //이슈 구분
	col.addColumnCustom("reqestSeqno", "${msg.C000000715}", "*", false); //의뢰 일련번호
	col.addColumnCustom("issueCn", "${msg.C000000715}", "*", false); //이슈 처리 내용
	col.addColumnCustom("issueCnHis", "${msg.C000000717}", "*", false); //이슈 처리 이력
	col.addColumnCustom("issueRegisterId", "${msg.C000000703}", "*", false); //이슈 등록자
	col.addColumnCustom("issueRegisterNm", "${msg.C000000703}", "*", false); //이슈 등록자
	col.addColumnCustom("issueConfmerId", "${msg.C000000716}", "*", false); //이슈 승인자 아이디
	col.addColumnCustom("issueConfmerNm", "${msg.C000000716}", "*", false); //이슈 승인자 명
	col.addColumnCustom("lockAt", "${msg.C000000165}", "*", false); //잠금여부
	col.addColumnCustom("appCnt", "${msg.C000001312}", "100", false); //승인버튼 여부


	col.addColumnCustom("c", "의뢰일련번호 암호화", "*", false);

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}


	//auiGrid 생성
	issueList = createAUIGrid(col, "issueList", cusPros);
	// 그리드 리사이즈.
	gridResize([issueList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(issueList, "ready", function(event) {
		gridColResize([issueList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//버튼 이벤트
function setButtonEvent(){
	//조회버튼
	$("#btn_select").click(function(){
		searchIssueList();
	});

	$("[id^=shr]").keyup(function(e){
		searchIssueList(e.keyCode);
	});

	//내부 이슈 여부 변경
	$("[name='innerIssueAt']").change(function(e){
		issueSeCodeCombo(e.target.value);
	});

	//검색의 이슈 여부 변경
	$("[name='shrInnerIssueAt']").change(function(e){
		ajaxJsonComboBox("/com/getCmmnCode.lims", "shrIssueSeCode", {upperCmmnCode : "IM12", tmprField1Nm : e.target.value}, true);
	});

	//결재자 수정
	$("#btn_ApprovedChng").click(function(e){
		if(confirm("${msg.C000001322}")){ //수정하시겠습니까?
			var params = getFormParam("issueForm");
			ajaxJsonParam("<c:url value='/test/approvedChange.lims'/>", params, function(data){
				if(data > 0){
					alert("${msg.C000000323}"); //수정되었습니다.
				}
			});
		}
	});

	//신규버튼 클릭 이벤트
	$("#btn_new").click(function(e){
		pageReset(["issueForm"], null, null, null);
		$("#crud").val("C");

		$("#issueForm :input").prop("disabled", false);

		$("[name='innerIssueAt']:radio[value='N']").prop("checked", true);
		issueSeCodeCombo("N");
		$("[name='innerIssueAt']").prop("disabled", true);
		$("#chartDivFrame").hide();
		$("#issueProgrsSittnCode").val("IM11000002"); //신규면 이슈 처리부터 시작
		$("#issueProgrsSittnCode").prop("disabled", true);
		$("#btn_Approved").hide();
		$("#btn_save").show();
		$("#issueCnHis").prop("disabled", true);

	});

	//저장버튼 클릭 이벤트
	$("#btn_save").click(function(){
		if(!$("#reqestSeqno").val()){
			alert("${msg.C000000722}"); //의뢰정보를 선택해 주세요.
			return;
		}

		if(formNecessaryValidationCheck("issueForm")){
			if(confirm("${msg.C000000306}")){ //저장 하시겠습니까?
				saveIssue();
			}
		}
	});

	//승인버튼
	$("#btn_Approved").click(function(){
		if(formNecessaryValidationCheck("issueForm")){
			if(confirm("${msg.C000000314}")){ //승인 하시겠습니까?
				approvedIssue();
			}
		}
	});

	//제품 곰보박스
	getEl("shrReqestDeptCode").event("change", function(e){

		var data = {
			"deptCode" : getEl("shrReqestDeptCode").value,
			"processTyCode" : getEl("shrProcessTyCode").value
		}
		ajaxJsonComboBox("/wrk/getSrchPrductList.lims","prductNmSch",data , true);
	});

	getEl("shrProcessTyCode").event("change", function(e){
		var data = {
			"deptCode" : getEl("shrReqestDeptCode").value,
			"processTyCode" : getEl("shrProcessTyCode").value
		}
		ajaxJsonComboBox("/wrk/getSrchPrductList.lims","prductNmSch",data, true);
	});
}

//그리드 이벤트
function setGridEvent(){
	//그리드 더블 클릭
	AUIGrid.bind(issueList, "cellDoubleClick", function( event ) {
		$("#issueCnHis").val("");
		//내부 이슈 여부에 따라서 이슈구분 콤보박스 생성 - Y:Warning Mail, N:내부, 외부
		issueSeCodeCombo(event["item"]["innerIssueAt"], function(){

			//더블클릭한 그리드 폼에 적용
			gridDataSet("issueForm", "input, select, textarea", event["item"], function(){
				$("#crud").val("U"); //그리드 더블클릭하면 수정모드

				//내부 이슈가 Y일때
		   	    if(event["item"]["innerIssueAt"] == "Y"){
		   	  		//이슈구분 Warning Mail로 고정
		   			$("#issueSeCode").val("IM12000001");

		   			//메일내용불러오기
		   			customAjax({'url':"<c:url value='/test/getIssueMailCn.lims'/>",'data': {issueSeqno : event["item"]["issueSeqno"]},'successFunc':function(data){
		   				$("#chartDivFrame").empty();
			   	 		$("#chartDivFrame").show();
		   	 			$("#chartDivFrame").append(data);
		   	 			$("#content4").hide();
		   			}
					});
		   	    }
		   		//내부 이슈가 N일때
		   	    else{
		   		    $("#issueForm :input").prop("disabled", false);
		   		    $("[name='innerIssueAt']").prop("disabled", true);
		   			$("#chartDivFrame").hide();
		   			$("#issueProgrsSittnCode").prop("disabled", true);
		   	    }

	   	 		//폼 수정여부
	 			formDisabled(true);
	 			$("#issueCnHis").prop("disabled", true);
	   	    	//신규버튼 disabled 풀기
	   	 	    $("#btn_new").prop("disabled", false);

	 			//승인자가 있으면
	 			if(event["item"]["issueConfmerId"] != null && event["item"]["issueConfmerId"] != "null"){
	 				if(event["item"]["issueConfmerId"] == "${loginId}"){
	 					$("#btn_save").show();
 				    	$("#btn_Approved").show();
	 				}
	 				else{
	 					$("#btn_save").hide();
	 				    $("#btn_Approved").hide();
	 				}
	 			}
	 			else{
	   	 			if(event["item"]["issueProgrsSittnCode"] == "IM11000001"){
	   	 				$("#btn_save").show();
	   	 			}
	 			}

	 			//진행상황 앞에걸로 변경 현재 진행상황은 ISSUE_PROGRS_SITTN_CODE_INS 이거임
	 			if(event["item"]["issueProgrsSittnCode"] == "IM11000001"){
	 				$("#issueProgrsSittnCode").val("IM11000002");
	 				$("#issueCn").prop("disabled", false);
	 				$("#btn_pop_user").prop("disabled", false);
	 				$("#btn_ApprovedChng").hide();
	 			}
	 			else if(event["item"]["issueProgrsSittnCode"] == "IM11000002"){
	 				$("#issueProgrsSittnCode").val("IM11000003");
	 			    $("#issueCn").prop("disabled", false);
	 				$("#btn_pop_user").prop("disabled", false);
	 				$("#btn_ApprovedChng").show();
	 			}
	 			else if(event["item"]["issueProgrsSittnCode"] == "IM11000003"){
	 				$("#issueConfmerNm").prop("disabled", true);

	 				$("#issueCn").prop("disabled", true);
	 				$("#btn_pop_user").prop("disabled", true);
	 				$("#btn_Approved").hide();
	 				$("#btn_ApprovedChng").hide();
	 			}

	 			$("#lockAt_Y").prop("disabled", false);
				$("#lockAt_N").prop("disabled", false);


		    });

		});

		//로그인 사용자와 결재자 아이디가 같으면 승인 버튼 보임
		if(event["item"]["appCnt"] == "Y"){
			$("#btn_Approved").show();
		}
		else{
			$("#btn_Approved").hide();
		}


	});
}

//폼 disabled 처리
function formDisabled(bool){
	$("#issueSj").prop("disabled", bool);
	$("#lotIdText").prop("disabled", bool);
	$("#btn_pop_request").prop("disabled", bool);
	$("#issueSeCode").prop("disabled", bool);
	$("#improptTyCode").prop("disabled", bool);
	$("#issueRegisterNm").prop("disabled", bool);
	$("#issueProgrsSittnCode").prop("disabled", bool);
	$("#innerIssueAt_Y").prop("disabled", bool);
	$("#innerIssueAt_N").prop("disabled", bool);
	$("#lockAt_Y").prop("disabled", bool);
	$("#lockAt_N").prop("disabled", bool);
}

//내부 이슈 여부에 따라서 이슈구분 콤보박스 생성
function issueSeCodeCombo(e, callback){
	ajaxJsonComboBox("/com/getCmmnCode.lims", "issueSeCode", {upperCmmnCode : "IM12", tmprField1Nm : e}, true, null, null, null).then(function(){
		if(callback != undefined){
			callback();
		}
	});


}

//저장이벤트
function saveIssue(){
	formDisabled(false);


	$("#issueProgrsSittnCodeIns").val($("#issueProgrsSittnCode").val());

	var params = getFormParam("issueForm");

	formDisabled(true);
	ajaxJsonParam("<c:url value='/test/saveIssueInfo.lims'/>", params, function(data){

		if(data > 0){
			alert("${msg.C000000071}"); //저장 되었습니다.
			$("#crud").val("C");
			searchIssueList();
			pageReset(["issueForm"], null, null, null);
			$("#chartDivFrame").empty();
		}
	});
}

//승인 이벤트
function approvedIssue(){
	formDisabled(false);

	$("#issueProgrsSittnCodeIns").val($("#issueProgrsSittnCode").val());
	$("#crud").val("A");

	var params = getFormParam("issueForm");

	formDisabled(true);
	ajaxJsonParam("<c:url value='/test/saveIssueInfo.lims'/>", params, function(data){

		if(data > 0){
			alert("${msg.C000000315}"); //승인 되었습니다.
			$("#crud").val("C");
			searchIssueList();
			pageReset(["issueForm"], null, null, null);
			$("#chartDivFrame").empty();
		}
	});
}

//조회 함수
function searchIssueList(keyCode) {

	if(keyCode != undefined && keyCode == 13)
		searchIssueList();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/test/getIssueMList.lims'/>", "searchFrm", issueList, function(){
			});
		}
	}
}

</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<form id="searchFrm">
			<h2>
				${msg.C000000707}<!-- 이슈목록 -->
				<span style="color: #444; font-size: 11px; font-weight: normal; margin-left: 4%;" class="necessary">${msg.C000000080}</span> <!-- 부서 -->
				<select class="wd12p schClass" style="margin-left:6px;" name="shrReqestDeptCode" id="shrReqestDeptCode">
					<option value="">${msg.C000000079}<!-- 선택 --></option>
				</select>
				<label for="shrConfmer" style="color: #444; font-size: 12px; font-weight: normal;">
					<input type="checkbox" id="shrConfmer" name="shrConfmer" value="Y" class="wd1p" style="position: relative; top: 1.5px;"> 승인
				</label>
			</h2>
			<div class="btnWrap">
				<button type="button" id="btn_select" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
			</div>

			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:20%"></col>
					<col style="width:10%"></col>
					<col style="width:14%"></col>
					<col style="width:9%"></col>
					<col style="width:14%"></col>
					<col style="width:9%"></col>
					<col style="width:14%"></col>
				</colgroup>
				<tr>
					<th>${msg.C000000213}</th> <!-- 프로세스 타입 -->
					<td><select id="shrProcessTyCode" name="shrProcessTyCode" class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000319}</th> <!-- 제품 -->
					<td><select id="shrPrductNm" name="shrPrductNm"  class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000575}</th> <!-- Lot ID -->
					<td><input type="text" id="shrLotId" name="shrLotId" class="wd100p objBacode" style="min-width:10em;"></td>
					<th>${msg.C000000715}</th> <!-- 상태 -->
					<td><select id="shrIssueProgrsSittnCode" name="shrIssueProgrsSittnCode"  class="wd100p" style="min-width:10em;"></select></td>
				</tr>
				<tr>
					<th>${msg.C000000706}</th><!-- 이슈 일자 -->
					<td style="text-align:left;">
						<input type="text" id="shrIssueRegistBeginDt" name="shrIssueRegistBeginDt" class="wd10p" style="min-width: 10em;">
						~
						<input type="text" id="shrIssueRegistEndDt" name="shrIssueRegistEndDt" class="wd10p" style="min-width: 10em;">
					</td>
					<th>${msg.C000000701}</th><!-- 내부 이슈 여부 -->
					<td style="text-align: left;">
						<label>
							<input type="radio"	id="shrInnerIssueAt_Y" class="popupAt" name="shrInnerIssueAt" value="Y" checked>
							${msg.C000000264} <!-- 예 -->
						</label>
						<label>
							<input type="radio" id="shrInnerIssueAt_N" class="popupAt" name="shrInnerIssueAt" value="N">
							${msg.C000000265} <!-- 아니오 -->
						</label>
					</td>
					<th>${msg.C000000704}</th><!-- 이슈 구분 -->
					<td><select id="shrIssueSeCode" name="shrIssueSeCode"  class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000702}</th><!-- 부적합 유형 -->
					<td><select id="shrImproptTyCode" name="shrImproptTyCode"  class="wd100p" style="min-width:10em;"></select></td>
				</tr>
			</table>
		</form>
		<div id="issueList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
	</div>
	<!-- chart -->
<!-- 	<iframe id="chartDivFrame" src="/chart/getChart.lims" width="100%" height="950px" style="display:none;"></iframe>	 -->
	<div id="chartDivFrame"></div>
	<div class="subCon1 mgT15">
		<form id="issueForm">

			<input type="hidden" id="crud" name="crud" value="C">
			<input type="hidden" id="issueSeqno" name="issueSeqno" value="">

			<h2>${msg.C000000708}</h2><!-- 이슈관리 정보 -->
			<div class="btnWrap">
				<button type="button" id="btn_new" class="btn4 save">${msg.C000000014}</button> <!-- 신규 -->
				<button type="button" id="btn_ApprovedChng" class="btn1 save" style="display:none;">${msg.C000001339}</button> <!-- 결재자 수정 -->
				<button type="button" id="btn_Approved" class="btn1 save" style="display:none;">${msg.C000001313}</button> <!-- 승인 -->
				<button type="button" id="btn_save" class="btn1 save" style="display:none;">${msg.C000000015}</button> <!-- 저장 -->

			</div>
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
					<th class="necessary">${msg.C000000463}</th><!-- 제목 -->
					<td ><input type="text" id="issueSj" name="issueSj" onkeyup="fnChkByte(this, '1000')"></td>
					<th class="necessary">${msg.C000000709}</th><!-- 의뢰 목록 조회 -->
					<td style="text-align:left;">
						<input type="text" id="lotIdText" name="lotIdText" class="wd70p" readonly>
						<input type="hidden" id="reqestSeqno" name="reqestSeqno">
						<button type="button" id="btn_pop_request" name="btn_pop_request" class="inTableBtn inputBtn search">
						${msg.C000000164}</button><!-- 찾기 -->
					</td>
					<th class="necessary">${msg.C000000701}</th><!-- 내부 이슈 여부 -->
					<td style="text-align:left;">
						<label>
							<input type="radio"	id="innerIssueAt_Y" class="popupAt" name="innerIssueAt" value="Y" checked>
							${msg.C000000264}<!-- 예 -->
						</label>
						<label>
							<input type="radio" id="innerIssueAt_N" class="popupAt" name="innerIssueAt" value="N">
							${msg.C000000265}<!-- 아니오 -->
						</label>
					</td>
					<th class="necessary">${msg.C000000704}</th><!-- 이슈 구분 -->
					<td><select id="issueSeCode" name="issueSeCode"  class="wd100p" style="min-width:10em;"></select></td>
				</tr>
				<tr>

					<th>${msg.C000000702}</th><!-- 부적합 유형 -->
					<td><select id="improptTyCode" name="improptTyCode"  class="wd100p" style="min-width:10em;"></select></td>
					<th>${msg.C000000703}</th><!-- 이슈 등록자 -->
					<td>
						<input type="text" id="issueRegisterNm" name="issueRegisterId" readonly>
						<input type="hidden" id="issueRegisterId" name="issueRegisterId" readonly>
					</td>
					<th>${msg.C000000715}</th><!-- 상태 -->
					<td>
						<select id="issueProgrsSittnCode" name="issueProgrsSittnCode"></select>
						<input type="hidden" id="issueProgrsSittnCodeIns" name="issueProgrsSittnCodeIns">

					</td>
					<th class="necessary">${msg.C000000301}</th><!-- 결재자 -->
					<td>
						<input type="text" id="issueConfmerNm" name="issueConfmerNm" class="wd70p" readonly>
						<input type="hidden" id="issueConfmerId" name="issueConfmerId">
						<button type="button" id="btn_pop_user" name="btn_pop_user" class="inTableBtn inputBtn search">
						${msg.C000000164}</button><!-- 찾기 -->
					</td>
				</tr>
				<tr>
					<th>${msg.C000001166}</th><!-- COA 발행 금지 -->
					<td style="text-align:left;">
						<label>
							<input type="radio"	id="lockAt_Y" name="lockAt" value="Y" checked>
							${msg.C000000264}<!-- 예 -->
						</label>
						<label>
							<input type="radio" id="lockAt_N" name="lockAt" value="N">
							${msg.C000000265}<!-- 아니오 -->
						</label>
					</td>
				</tr>
				<tr>
					<th>${msg.C000000717}</th><!-- 처리 이력 -->
					<td colspan="7"><textarea id="issueCnHis" name="issueCnHis" rows=5 class="wd100p" onkeyup="fnChkByte(this, '4000')" disabled></textarea></td>
				</tr>
				<tr>
					<th>${msg.C000000705}</th><!-- 이슈 처리 내용 -->
					<td colspan="7"><textarea id="issueCn" name="issueCn" rows=5 class="wd100p" onkeyup="fnChkByte(this, '4000')"></textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>

</tiles:putAttribute>


</tiles:insertDefinition>