<%@page import="lims.sys.vo.UserMVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<h2>부재자 목록 </h2>
		<div class="btnWrap">
			<button type="button" id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<form action="javascript:;" id="absnceSearch" name="absnceSearch">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
				</colgroup>
				<tr>
					<th>부재자 명</th>
					<td>
						<input type="text" name="txtabsntNm" id="txtabsntNm" class="wd100p schClass">
					</td>
					<th>부재상태</th>
					<td>
						<select id="absnceSttusCodee" name="absnceSttusCodee"></select>
					</td>
					<th>부재여부</th>
					<td style="text-align:left;">
						<label><input type="radio" name="absnceSttus" value="" checked>${msg.C000000062}</label> <!-- 전체 -->
				    	<label><input type="radio" name="absnceSttus" value="A" >부재</label>
				    	<label><input type="radio" name="absnceSttus" value="C" >복귀</label>
					<td colspan="2"></td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="AbsnceGrid" style="width:100%; height:220px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="subCon1 mgT20" id="detail">
		<h2>부재자 상세정보</h2>
		<div class="btnWrap">
			<button type="button" id="btnNew" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button type="button" id="btnDelete" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<form id="absnceFrm" name ="absnceFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="userInfotbl">
				<colgroup>
					<col style="width:8%"></col>
					<col style="width:17%"></col>
					<col style="width:8%"></col>
					<col style="width:17%"></col>
					<col style="width:8%"></col>
					<col style="width:17%"></col>
					<col style="width:8%"></col>
					<col style="width:17%"></col>
				</colgroup>
				<tr>
					<th class="necessary" style="min-width:100px;">부재자(부서/명)</th>
					<td style="text-align: left;">
						<input type="hidden" id="absntId" name="absntId"  class="wd60p" value="${UserMVo.userId}">
						<input type="text" id="absntDeptNm" name="absntDeptNm"  class="wd60p" value="${UserMVo.inspctInsttNm}">
						<input type="text" id="absntNm" name="absntNm"  class="wd60p" value="${UserMVo.userNm}">
						<button type="button" id="btnManagerNmOSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->
					</td>
					<th class="necessary" style="min-width:100px;">대리자(부서/명)</th>
					<td style="text-align: left;">
						<input type="hidden" id="agncymanId" name="agncymanId"  class="wd60p">
						<input type="text" id="agncymanDeptNm" name="agncymanDeptNm"  class="wd60p">
						<input type="text" id="agncymanNm" name="agncymanNm"  class="wd60p" >
						<button type="button" id="btnManagerNmTSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->

					</td>
					<th class="necessary">부재상태</th>
					<td>
						<select id="absnceSttusCode" name="absnceSttusCode"></select>
					</td>
					<td colspan="2"></td>
				<tr>
					<th class="necessary">부재시작일</th>
					<td><input type="text" name="absnceBeginDt" id="absnceBeginDt"></td>
					<th class="necessary">부재 종료일</th>
					<td><input type="text" name="absnceEndDt" id="absnceEndDt"></td>

				<tr>
					<th>부재사유</th>
					<td colspan="7"><textarea id="absnceResn" name="absnceResn" class="wd100p" rows="2" style="min-width:10em;"></textarea></td>
				</tr>
			</table>
				<input type="hidden" id="absnceSeqno" name="absnceSeqno">

		</form>
	</div>

</div>

</tiles:putAttribute>

<tiles:putAttribute name="script">
<script>

var lang = ${msg}; // 기본언어
var absnceFrm = "absnceFrm";
var AbsnceGrid = "AbsnceGrid";
// var saveUnitUrl = "<c:url value='/wrk/saveAbsnceM.lims'/>";
var putStatus = 'C';	//  C: insert / U : update

$(document).ready(function(){

		getAuth(); //권한 체크

		init();//기본 세팅

		setMhrlsCmpdsMGrid();  //그리드 생성

		setAbsnceMGridEvent(); //그리드 이벤트

		setButtonEvent();//버튼 이벤트

		setAbsnceMEvent();

		popup();

// 		document.getElementById("wrhousngDte").value = currentDate();

	});

</script>
<script>

function init(){
// 	ajaxJsonComboBoxCommon("RS14", "pMhrlsCmpdsSeCode", true);
// 	ajaxJsonComboBoxCommon("RS14", "mhrlsCmpdsSeCode", true);
	ajaxJsonComboBox('/com/getCmmnCode.lims','absnceSttusCode',{"upperCmmnCode" : "SY19"},false,"${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims','absnceSttusCodee',{"upperCmmnCode" : "SY19"},false,"${msg.C000000079}"); /* 선택 */
	datePickerCalendar(["absnceBeginDt", "absnceEndDt"]);


}
function setMhrlsCmpdsMGrid(){
	var columnLayout = {
		AbsnceGrid : []
	};

	var percentBar = {
		renderer : {
			type : "BarRenderer",
			max : 100,
			min : 0
		},
		styleFunction : function(rowIndex, columnIndex, value, headerText, dataField, item) {
			if(value >= 100)
				return "c-red";
			return "";
		}
	}

	var reqPros = {
		//엑스트라체크박스 표시
		showRowCheckColumn : true,
		// 전체 체크박스 표시 설정
		showRowAllCheckBox : true
	};


	auigridCol(columnLayout.AbsnceGrid);
	columnLayout.AbsnceGrid.addColumnCustom("absntDeptNm","부재자 부서",null,true,false)
	.addColumnCustom("absntNm","부재자명",null,true,false)
	.addColumnCustom("agncymanDeptNm","대리자부서",null,true,false)
	.addColumnCustom("agncymanNm","대리자명",null,true,false)
	.addColumnCustom("absnceSttusCode","부재상태코드",null,false,false)
	.addColumnCustom("absnceSttusNm","부재상태",null,true,false)
	.addColumnCustom("absnceBeginDt","부재시작일",null,true,false)
	.addColumnCustom("absnceEndDt","부재종료일",null,true,false)
	.addColumnCustom("absnceResn","부재사유",null,true,false)

	AbsnceGrid = createAUIGrid(columnLayout.AbsnceGrid, AbsnceGrid, reqPros);

	gridResize([AbsnceGrid]);
}
function setrepairHistoryGrid(){
	var col = [];

	auigridCol(col);

	var myEditRenderer3 = {
			type : "CalendarRenderer",
			onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
			showExtraDays : true, // 지난 달, 다음 달 여분의 날짜(days) 출력
			defaultFormat  : "yyyy-mm-dd" // 실제 데이터 형식을 어떻게 표시할지 지정
	};
	var repairProps= {
			editRenderer : {
				type : "ConditionRenderer", // 조건에 따라 editRenderer 사용하기. conditionFunction 정의 필수
				// 컨디션함수는 자주 호출됩니다. 따라서 여기서 DOM 탐색 또는 jQuery 객체 만들기 등은 하지 마십시오.
				conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {

					return myEditRenderer3;
			}
		}
	}

	col.addColumnCustom("repairCn", "${msg.C000000553}", "*" ,true,true); /* 수리내용 */
	col.addColumnCustom("repairDte", "${msg.C000000006}", "*", true,true,repairProps); /* 수리일자 */

	//auiGrid 생성
	repairHistory = createAUIGrid(col, "repairHistory");

	// 그리드 칼럼 리사이즈
	AUIGrid.bind(repairHistory, "ready", function(event) {
		gridColResize([repairHistory],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});

}
//그리드 이벤트
function setAbsnceMGridEvent(){


}
//버튼이벤트
function setButtonEvent(){

	$('#btnSave').click(function() {
		var count = 0;
		// 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승
		$('#absnceFrm').find('input').each(function() {
				var nm = $(this).attr("name");
				if (nm == "absntNm" || nm == "agncymanNm"|| nm == "absnceSttusCode"|| nm == "absnceBeginDt" || nm == "absnceEndDt" ) {
					if (!$(this).prop('required')) {
						if ($(this).val() == '') {
							count++;
							$(this).focus();
							return;
						}
					}
				}
			}
		);
		// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
		if (count > 0) {
			alert('${msg.C000000169}'); /* 필수 사항을 모두 입력해 주십시오 */
			return false;
		}
		// 부재자 날짜 중복 체크
		var inputAbsnName = $('#absntId').val();
		var confirmUrl = "<c:url value='/wrk/confirmAbsnceM.lims'/>";

		if (inputAbsnName != '') {
			customAjax({
				url: confirmUrl,
				"data": $("#absnceFrm").serializeObject()
			}).then(function(data) {
				if (data != 0) {
						alert('동일 부재명으로 같은 날짜가 이미 등록됨.');
						$('#absntId').val('');
						return false;
				} else {
					saveAbsnce(); //실질적으로 저장하는 함수
				}
			});
		}


	});

	document.getElementById("btnNew").addEventListener("click",function(e){
		reset();
	});

	document.getElementById("btnDelete").addEventListener("click",function(e){
 		delAbsnce();
	});

	document.getElementById("btnSearch").addEventListener("click",function(e){
		getSearchAbsn();
	});


}

function popup(){
	//부재자 찾기
	dialogUser("btnManagerNmOSearch", null, "ManagerNmODialog", function(item){
		$("#absntNm").val(item.userNm);
		$("#absntId").val(item.userId);
		$("#absntDeptNm").val(item.inspctInsttNm);
	});
	//대리자 찾기
	dialogUser("btnManagerNmTSearch", null, "ManagerNmTDialog", function(item){
		$("#agncymanNm").val(item.userNm);
		$("#agncymanId").val(item.userId);
		$("#agncymanDeptNm").val(item.inspctInsttNm);
	});

}

function reset(){
	// 폼 초기화
	pageReset(["absnceFrm"], null, null, function(){

	});
// 	document.getElementById("startDt").value = currentDate();

	putStatus = 'C'; // 삽입가능상태로 전환
// 	AUIGrid.clearGridData(repairHistory);
}
//삭제 함수
function delAbsnce() {
	var url = "/wrk/deleteAbsnM.lims";
	var data = $("#absnceFrm").serializeObject();
		customAjax({
			url: url,
			data: data
		}).then(function(data) {
			if (data > 0) {
	     	getSearchAbsn();
			reset();
           	alert("${msg.C000000179}"); /* 삭제되었습니다. */
        }
		});

}
function getSearchAbsn(){
	var param = getFormParam("absnceSearch");
	customAjax({
		"url": "/wrk/getAbsnceList.lims",
		data: param
	}).then(function(data) {
		AUIGrid.setGridData(AbsnceGrid, data);
	});
}
function saveAbsnce(){
	if (putStatus == 'C') {
		ajaxJsonForm("/wrk/insAbsnceM.lims", "absnceFrm", function(data) {
			if (!!data)
				alert("${msg.C000000071}"); /* 저장 되었습니다. */
			$('#absnceFrm')[0].reset();
			$('#btnNew').trigger('click');
			getSearchAbsn();
		}, function(request, status, error) {
			alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
		});

	} else if (putStatus == 'U') {
		ajaxJsonForm("/wrk/updAbsnceM.lims", absnceFrm, function(data) {
			if (!!data)
				alert("${msg.C000000071}");
			$('#absnceFrm')[0].reset();
			$('#btnNew').trigger('click');
			getSearchAbsn();
		}, function(request, status, error) {
			alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
		});
	}
}

function setAbsnceMEvent(){
	AUIGrid.bind(AbsnceGrid, "cellDoubleClick", function(event){
		var item = event.item;
		$("#absntDeptNm").val(item.absntDeptNm);
		$("#absntNm").val(item.absntNm);
		$("#agncymanDeptNm").val(item.agncymanDeptNm);
		$("#agncymanNm").val(item.agncymanNm);
		$("#absnceSttusCode").val(item.absnceSttusCode);
		$("#absnceBeginDt").val(item.absnceBeginDt);
		$("#absnceEndDt").val(item.absnceEndDt);
		$("#absnceResn").val(item.absnceResn);
		$("#absnceSeqno").val(item.absnceSeqno);
		$("#absntId").val(item.absntId);
		$("#agncymanId").val(item.agncymanId);
		putStatus = 'U';

	})
}
function deleteAbsnceM (){
	var data = {
		"absnceSeqno":$("#absnceSeqno").val()
	}

	customAjax({
		"url": "/wrk/deleteAbsnM.lims",
		data: data
	}).then(function(data) {
		if(data){
			alert("${msg.C000000179}"); /* 삭제되었습니다. */
// 			searchEntrpsM();
			$('#absnceFrm')[0].reset();
			AUIGrid.clearGridData(AbsnceGrid);
		}
	});
	/*
	ajaxJsonParam("/wrk/deleteAbsnM.lims",{"absnceSeqno":$("#absnceSeqno").val()},function(data){
		if(data){
			alert("${msg.C000000179}");
// 			searchEntrpsM();
			$('#absnceFrm')[0].reset();
			AUIGrid.clearGridData(AbsnceGrid);
		}
	});
	*/
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
