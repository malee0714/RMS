<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기 가동 시료</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">

</script>
<script>
//AUIGrid 생성 후 반환 ID
var mhrlsOprList = "mhrlsOprList";
var mhrlsRequestList = "mhrlsRequestList";

$(document).ready(function(){
	getAuth();

	//콤보 박스 초기화
	setCombo();

	//기기 가동 목록 그리드 세팅
	setMhrlsOprList();

	//의뢰정보 그리드 세팅
	setMhrlsRequestGrid();

	//그리드 이벤트 선언
	setMhrlsOprGridEvent();

	// 버튼 이벤트
	setButtonEvent();

	//초기화
	init();

	gridResize(['mhrlsOprList', 'mhrlsRequestList']);
});

function init(){
	//달력
	datePickerCalendar(["shrOprBeginDteDte", "shrOprEndDteDte"], true, ["MM",-1], ["DD",0]);
	datePickerCalendar(["oprDte"], false, ["DD",0], ["DD",0]);

	dateTimePickerCalendar(["beginDt", "endDt"], false, ["DD",0], ["DD",0]);
}



function setCombo(){
	//발생 원인
	ajaxJsonComboBox('/com/getCmmnCode.lims','occrrncCauseCode',{"upperCmmnCode" : "RS09"}, true);

}

//기기 가동 그리드 설정
function setMhrlsOprList(){

	var col = [];

	auigridCol(col);

	col.addColumnCustom("mhrlsSeqno", "기기 일련번호", "*", false);
	col.addColumnCustom("mhrlsBrcd", "바코드", "*", true); /* 기기관리번호 */
	col.addColumnCustom("mhrlsManageNo", "${msg.C000000008}", "*", true); /* 기기관리번호 */
	col.addColumnCustom("mhrlsNm", "${msg.C000000011}", "*", true); /* 기기명 */
	col.addColumnCustom("modlNo", "${msg.C000000567}", "*", true); /* 모델명 */
	col.addColumnCustom("oprDte", "${msg.C000000568}", "*", true); /* 가동일자 */

	col.addColumnCustom("beginDt", "${msg.C000000569}", "*", true); /* 시작 일시 */
	col.addColumnCustom("endDt", "${msg.C000000570}", "*", true); /* 종료 일시 */
	col.addColumnCustom("oprTime", "${msg.C000000571}", "*", true); /* 가동시간 */
	col.addColumnCustom("oprNum", "가동 건수", "*", true); /* 가동건수 */
	col.addColumnCustom("analsTeamSeqno", "analsTeamSeqno", "*", false); /* analsTeamSeqno */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells", // 셀 선택모드 (기본값: singleCell)
 			softRemoveRowMode : true
 	}

	//auiGrid 생성
	mhrlsOprList = createAUIGrid(col, "mhrlsOprList", cusPros);
	// 그리드 리사이즈.
	gridResize([mhrlsOprList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(mhrlsOprList, "ready", function(event) {
		gridColResize([mhrlsOprList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//의뢰정보 그리드 설정
function setMhrlsRequestGrid(){
	var col2 = [];

	auigridCol(col2);

	col2.addColumnCustom("reqestSeqno", "의뢰 일련번호", "*", false);
	col2.addColumnCustom("brcd", "${msg.C000000574}", "*", true); /* 의뢰 바코드 */
	col2.addColumnCustom("lotId", "${msg.C000000575}", "*", true); /* LOT ID */
	col2.addColumnCustom("chrgTeamNm", "접수 팀 명", "*", true); /* 접수 팀 명 */
	col2.addColumnCustom("reqestDeptNm", "${msg.C000000577}", "*", true); /* 의뢰부서 */
	col2.addColumnCustom("reqestDeptCode", "의뢰 부서 코드", "*", false);
	col2.addColumnCustom("reqestDte", "${msg.C000000576}", "*", true); /* 의뢰일자 */
	col2.addColumnCustom("mnfcturDte", "${msg.C000000578}", "*", true); /* 제조일자 */
	col2.addColumnCustom("prdlstNm", "${msg.C000000579}", "*", true); /* 품목명 */
	col2.addColumnCustom("mtrilNm", "${msg.C000000228}", "*", true); /* 자재명 */
	col2.addColumnCustom("tankNo", "${msg.C000000253}", "*", true); /* Tank No. */
	col2.addColumnCustom("mtrilCode", "${msg.C000000214}", "*", false); /* 자재코드 */
	col2.addColumnCustom("rm", "${msg.C000000096}", "*", true); /* 비고 */
	col2.addColumnCustom("ordr", "${msg.C000000440}", "*", false); /* 순서 */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			softRemoveRowMode : true
 	}

	//auiGrid 생성
	mhrlsRequestList = createAUIGrid(col2, "mhrlsRequestList", cusPros);
	// 그리드 리사이즈.
	gridResize([mhrlsRequestList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(mhrlsRequestList, "ready", function(event) {
		gridColResize([mhrlsRequestList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}


//그리드 이벤트 함수
function setMhrlsOprGridEvent(){
	//기기 가동 정보 그리드 클릭 이벤트
	AUIGrid.bind(mhrlsOprList, "cellDoubleClick", function(event) {
		gridInDataSet(event["item"], "mhrlstbl", function(){
			mhrlsManageNoEvnet(event["item"]);
		});
	});
}

//버튼 이벤트
function setButtonEvent(){
	//조회 버튼 이벤트
	$("#btn_select").click(function(){
		searchMhrls();
	});


	//기기 가동 목록 삭제버튼 이벤트
	$("#btn_delete").click(function(){
		var gridData = AUIGrid.getSelectedItems(mhrlsOprList);

		if(gridData.length == 0){
			alert("${msg.C000000581}"); //기기 가동 목록을 선택해 주세요.
			return;
		}

		if(confirm("${msg.C000000178}")){ //삭제하시겠습니까?
			var params = {
					mhrlsSeqno : gridData[0]["item"]["mhrlsSeqno"]
				   ,oprDte : gridData[0]["item"]["oprDte"]
			}

			ajaxJsonParam("<c:url value='/rsc/delMhrlsOprRequest.lims'/>", params, function(data){
				if(data.length > 0){
					alert("${msg.C000000179}"); /* 삭제되었습니다. */
					searchMhrls();
					return;
				}
			});
		}
	});

	//가동일자 변경 이벤트
	$("#oprDte").change(function(){
		ajaxJsonParam("<c:url value='/rsc/getMhrlsManageNoList.lims'/>", {mhrlsBrcd : $("#mhrlsBrcd").val(), oprDte : currentDate()}, function(data){
			if(data > 0){

			}
		});
	});

	//바코드 번호 엔터 이벤트
	$("#mhrlsBrcd").keyup(function(e){
		if(e.keyCode == 13){

			ajaxJsonParam("<c:url value='/rsc/getMhrlsManageNoList.lims'/>", {mhrlsBrcd : $("#mhrlsBrcd").val()}, function(data){
				console.log(data);
				if(data.length == 0){
					alert("없는 바코드 정보 입니다."); /* 없는 기기 관리 정보입니다. */
					return;
				}

				var cnt = 0;
				//기기 가동 정보 박스에 오늘 날짜 데이터 적용 없으면 신규
				for(var i=0; i<data.length; i++){
					if(data[i]["oprDte"] == currentDate()){
						cnt = i;
						break;
					}
				}
				gridInDataSet(data[cnt], "mhrlstbl", function(){

// 					mhrlsManageNoEvnet(data[cnt]);
				});
			});
		}
	});

	//의뢰 바코드 엔터 이벤트
	$("#brcd").keyup(function(e){
		if(e.keyCode == 13){
			if(!$("#mhrlsSeqno").val()){
				alert("${msg.C000000581}"); /* 기기 가동 목록을 선택해 주세요. */
				return;
			}
			ajaxJsonParam("<c:url value='/rsc/getImReqestBacdList.lims'/>", {brcd : $("#brcd").val()}, function(data){
				if(data.length == 0){
					alert("${msg.C000000582}"); /* 없는 의뢰 바코드 입니다. */
					return;
				}
				if(data[0]["progrsSittnCode"] != "IM03000003"){
					alert("분석중인 시료만 등록이 가능합니다."); /* 분석중인 시료만 등록이 가능합니다. */
					return;
				}
				//그리드 행 추가
				AUIGrid.addRow(mhrlsRequestList, data[0], 0);
				//조회되 의뢰 바코드 의뢰정보에 적용
				gridInDataSet(data[0], "mhrlstbl3", function(){
					//의뢰 바코드 빈값으로
					$("#brcd").val("");
					//의뢰 바코드에 포커스 주기
					$("#brcd").focus();
				});
			});
		}
	});

	//엔터로 검색
	$("#shrMhrlsManageNo,#shrMhrlsNm,#shrModlNo,#shrOprBeginDteDte,#shrOprEndDteDte").keyup(function(e){
		searchMhrls(e.keyCode);
	});

	//날짜 형식 체크
	$("#oprDte").focusout(function(e){
		dateTypeCheck("oprDte", "date");
	});

	//시작일시 날짜 형식 체크
	$("#beginDt, #endDt").change(function(e){
		if(dateTypeCheck(e.target.id, "dateTime")){
			//시작일시, 종료일시 두개에 값이 다 있으면 가동시간 계산하여 입력
			if($("#beginDt").val() && $("#endDt").val()){
				var startTime = $("#beginDt").val().replace(/-/gi,""); // 시작일시 ('20090101 12:30:00')
			    var endTime  = $("#endDt").val().replace(/-/gi,"");    // 종료일시 ('20091001 17:20:10')

			    // 시작일시
			    var startDate = new Date(parseInt(startTime.substring(0,4), 10),
			             parseInt(startTime.substring(4,6), 10)-1,
			             parseInt(startTime.substring(6,8), 10),
			             parseInt(startTime.substring(8,10), 10),
			             parseInt(startTime.substring(10,12), 10),
			             parseInt(startTime.substring(12,14), 10)
			    );

			    // 종료일시
			    var endDate   = new Date(parseInt(endTime.substring(0,4), 10),
			             parseInt(endTime.substring(4,6), 10)-1,
			             parseInt(endTime.substring(6,8), 10),
			             parseInt(endTime.substring(8,10), 10),
			             parseInt(endTime.substring(10,12), 10),
			             parseInt(endTime.substring(12,14), 10)
			    );

			    var timeGap = new Date(0, 0, 0, 0, 0, 0, endDate - startDate);

			    // 두 일자(startTime, endTime) 사이의 간격을 "일-시간-분"으로 표시한다.
		  		var diffDay  = Math.floor((endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24)); // 일수
		  	    var diffHour = timeGap.getHours();       // 시간
		  	    var diffMin  = timeGap.getMinutes();      // 분
		  	    var diffSec  = timeGap.getSeconds();      // 초

		  		var day = diffDay * 86400;  //일을 초로 변경
		  		var hour = diffHour * 3600; //시간을 초로 변경
		  		var min = diffMin * 60;     //분을 초로 변경
		  		var sum = (day+hour+min+diffSec) / 3600;  //초까지 모두 더하여 시간구하기

		  		$("#oprTime").val(sum.toFixed(1));
			}
			else{
				$("#oprTime").val(0);
			}
		}
	});


}

//기기가동목록 그리드 클릭이나 기기관리번호 바코드로 조회했을대 이벤트
function mhrlsManageNoEvnet(data){

	//기기관리번호 비활성화
	$("#mhrlsBrcd").prop("disabled", true);
	$("#brcd").val("");
	$("#brcd").focus();

	//조회된 데이터에서 가동일자가 없으면 오늘날짜로 기본 세팅
	if(!data["oprDte"]){
		$("#oprDte").val(getFormatDate());
		$("#beginDt").val(currentDate("time"));
	}
	else{
		$("#oprDte").val(data["oprDte"]);
	}

	var params = {
			oprDte : $("#oprDte").val()
		   ,mhrlsSeqno : $("#mhrlsSeqno").val()

	};
	//의뢰정보 그리드 초기화
	AUIGrid.clearGridData(mhrlsRequestList);
	//기기 가동정보에 연결된 의뢰정보를 조회하여 그리드에 세팅
	getGridDataParam("<c:url value='/rsc/getImReqestList.lims'/>", params, mhrlsRequestList);
}

//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13){
		searchMhrls();
	}
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/rsc/getMhrlsOprList.lims'/>", "searchFrm", mhrlsOprList);
		}
	}
}


//저장 함수
function saveMhrls(){

	//행 추가 데이터
	var addGridData = AUIGrid.getAddedRowItems(mhrlsRequestList);
	//행 삭제 데이터
	var removeGridData = AUIGrid.getRemovedItems(mhrlsRequestList);

	//if(addGridData.length == 0 && removeGridData.length == 0){
	//	alert("저장할 의뢰정보가 없습니다.");
	//	return;
	//}

	if(!formNecessaryValidationCheck("MhrlsOprHistMForm")){
		return;
	}



	if(confirm("${msg.C000000306}")){ /* 저장 하시겠습니까? */
		var params = getFormParam("MhrlsOprHistMForm");
		params.gridData1 = addGridData;
		params.gridData2 = removeGridData;

		ajaxJsonParam("<c:url value='/rsc/insMhrlsOprRequest.lims'/>", params, function(data){
			if(data > 0){
				alert("${msg.C000000071}"); /* 저장 되었습니다. */
				btnReset();
				searchMhrls();
			}
		});
	}
}

//초기화
function btnReset(){
	//기기 관리 번호 disabld false
	$("#mhrlsBrcd").prop("disabled", false);
	$("#mhrlsManageNo").prop("disabled", false);
	$("#mhrlsNm").prop("disabled", false);
	$("#modlNo").prop("disabled", false);
	//form 초기화
	$("#MhrlsOprHistMForm")[0].reset();
	$("#mhrlsSeqno").val("");

// 	$("#beginDt").val(currentDate("time"));
	//의뢰정보 그리드 초기화
	AUIGrid.clearGridData(mhrlsRequestList);
}

//행 삭제
function removeRow(){
	 AUIGrid.removeRow(mhrlsRequestList, "selectedIndex");
}


</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000566}</h2> <!-- 기기 가동 목록 -->
		<div class="btnWrap">
			<button type="button" id="btn_delete" class="search btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btn_select" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>

		<!-- Main content -->
		<form id="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
				</colgroup>
				<tr>
					<th>바코드</th> <!-- 바코드 -->
					<td><input type="text" id="mhrlsBrcdSch" name="mhrlsBrcdSch" class="wd100p" style="min-width:10em;"></td>
					<th>${msg.C000000008}</th> <!-- 기기관리번호 -->
					<td><input type="text" id="shrMhrlsManageNo" name="shrMhrlsManageNo" class="wd100p" style="min-width:10em;"></td>
					<th>${msg.C000000011}</th> <!-- 기기명 -->
					<td><input type="text" id="shrMhrlsNm" name="shrMhrlsNm"  class="wd100p" style="min-width:10em;"></td>
				</tr>
				<tr>
					<th>${msg.C000000567}</th> <!-- 모델명 -->
					<td><input type="text" id="shrModlNo" name="shrModlNo"  class="wd100p" style="min-width:10em;"></td>
					<th>${msg.C000000568}</th> <!-- 가동일자 -->
					<td colspan="3" style="text-align:left;">
						<input type="text" id="shrOprBeginDteDte" name="shrOprBeginDteDte" class="wd6p" style="min-width: 6em;">
						~
						<input type="text" id="shrOprEndDteDte" name="shrOprEndDteDte" class="wd6p" style="min-width: 6em;">
					</td>
				</tr>
			</table>
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="mhrlsOprList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</form>

	</div>

	<form id="MhrlsOprHistMForm" autocomplete="off">
		<!-- 기기 수리 정보 시작 -->
		<div class="subCon1 mgT15" id="detail">
			<h2>${msg.C000000572}</h2> <!-- 기기 가동 정보 -->
			<div class="btnWrap">
				<button type="button" id="btn_reset" onclick="btnReset()" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
				<button type="button" id="btn_save" onclick="saveMhrls()" class="btn1">${msg.C000000015}</button> <!-- 저장 -->
			</div>
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl">
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
					<th>바코드</th> <!-- 바코드 -->
					<td>
						<input type="text" id="mhrlsBrcd" name="mhrlsBrcd"  class="wd100p" style="min-width:10em;">
						<input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno" value="">
						<input type="hidden" id="analsTeamSeqno" name="analsTeamSeqno" value="">
					</td>

					<th>${msg.C000000008}</th> <!-- 기기관리번호 -->
					<td>
						<input type="text" id="mhrlsManageNo" name="mhrlsManageNo"  class="wd100p" style="min-width:10em;" disabled>
<!-- 						<input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno" value=""> -->
<!-- 						<input type="hidden" id="analsTeamSeqno" name="analsTeamSeqno" value="">							 -->
					</td>

					<th>${msg.C000000011}</th> <!-- 기기명 -->
					<td>
						<input type="text" id="mhrlsNm" name="mhrlsNm" class="wd100p" style="min-width:10em;" disabled>
					</td>
					<th>${msg.C000000567}</th> <!-- 모델명 -->
					<td>
						<input type="text" id="modlNo" name="modlNo" class="wd100p" style="min-width:10em;" disabled>
					</td>

				</tr>
				<tr>
					<th class="necessary">${msg.C000000568}</th> <!-- 가동일자 -->
					<td>
						<input type="text" id="oprDte" name="oprDte" class="wd100p" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')">
					</td>

					<th>${msg.C000000569}</th> <!-- 시작 일시 -->
					<td>
						<input type="text" id="beginDt" name="beginDt" class="wd100p" style="min-width:10em;">
					</td>
					<th>${msg.C000000570}</th> <!-- 종료 일시 -->
					<td>
						<input type="text" id="endDt" name="endDt" class="wd100p" style="min-width:10em;">
					</td>
					<th>${msg.C000000571}</th> <!-- 가동시간 -->
					<td colspan="3" style="text-align: left;">
						<input type="text" id="oprTime" name="oprTime" class="wd36p" style="min-width:10em;" numberOnly>
					</td>
				</tr>
			</table>
			<input type="hidden" id="crud" name="crud" value="C"/>
			<input type="hidden" id="mhrlsRepairHistSeqno" name="mhrlsRepairHistSeqno">
			<input type="hidden" id="oprAt" name="oprAt">
			<input type="hidden" id="deleteAt" name="deleteAt" value="N">
		</div>
		<!-- 기기 수리 정보 종료 -->

		<!-- 의뢰 정보 시작 -->
		<div class="subCon1 mgT15" id="detail2">
			<h3>${msg.C000000573}</h3> <!-- 의뢰 정보 -->
			<div class="btnWrap">
				<button type="button" id="btn_removeRow" onclick="removeRow()" class="print search btn5">${msg.C000000112}</button> <!-- 행삭제 -->
			</div>
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="mhrlstbl2">
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
					<th>${msg.C000000574}</th> <!-- 의뢰 바코드 -->
					<td colspan="3">
						<input type="text" id="brcd" name=brcd  class="wd100p" style="min-width:10em;">
					</td>
				</tr>
			</table>
			<div id="mhrlsRequestList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>

		<!-- 의뢰 정보 종료 -->
	</form>
</div>

<!--  body 끝 -->
</tiles:putAttribute>


</tiles:insertDefinition>