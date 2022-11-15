<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기 수리 이력</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">

</script>
<style>
	.c-red {
		background-color : #FEDBDE
	}
</style>
<script>
//AUIGrid 생성 후 반환 ID
var MhrlsCmpdsUseMList = 'MhrlsCmpdsUseMList';

$(document).ready(function(){
	getAuth();

	//초기 세팅
	init();

	//콤보 박스 초기화
	setCombo();

	//그리드 세팅
	setMhrlsCmpdsUseGrid();

	//그리드 이벤트 선언
	setMhrlsGridEvent();

	//버튼 이벤트
	setButtonEvent();



});

//초기 세팅
function init(){
	//달력
	dateTimePickerCalendar(["useBeginDt", "useEndDt"], false, ["DD",0], ["DD",0]);
}

//콤보박스 초기화
function setCombo(){

	//담당팀 조회
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'shrChrgTeamSeqno', {'upperCmmnCode': 'RS19'}, false, "${msg.C000000079}"); /* 선택 */

	//소모품
	ajaxJsonComboBox('/com/getCmmnCode.lims','shrMhrlsCmpdsSeCode',{"upperCmmnCode" : "RS14"}, false,"${msg.C000000079}"); /* 선택 */

	//기기(조회조건)
	ajaxJsonComboBox('/com/getCmmnCode.lims','shrMhrlsClCode',{"upperCmmnCode" : "RS02"}, true); /* 선택 */

	//장비명 (조회조건)
	ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','shrMhrlsNm',{"mhrlsClCode" : null}, true); /* 선택 */
	//장비명
	ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','mhrlsSeqno',{"mhrlsClCode" : null}, true); /* 선택 */
	//부서
	//ajaxJsonComboBox('/com/getDeptCombo.lims','shrDeptCode', {analsAt : "Y", deptAt:"Y", mmnySeCode :"SY01000001"}, false,"${msg.C000000079}"); /* 선택 */

}


//그리드 세팅 함수
function setMhrlsCmpdsUseGrid(){
	var col = [];

	auigridCol(col);

	var rowStyle = {
	}

	col.addColumnCustom("brcd", "${msg.C000000627}", "*" ,true); /* 바코드 */
	col.addColumnCustom("chrgTeamSeqno", "${msg.C000000624}", "*", false); /* 담당팀 */
	col.addColumnCustom("chrgTeamNm", "${msg.C000000624}", "*", true); /* 담당 팀 */
// 	col.addColumnCustom("deptNm", "${msg.C000000080}", "*", true); /* 부서 */
	col.addColumnCustom("mhrlsCmpdsSeCode", "${msg.C000000625}", "*", false); /* 소모품 구분 */
	col.addColumnCustom("mhrlsCmpdsSeNm", "${msg.C000000625}", "*", true); /* 소모품 구분 */
	col.addColumnCustom("mhrlsClCodeNm", "${msg.C000000007}", "*", true); /* 기기분류 */
	col.addColumnCustom("mhrlsSeqno", "${msg.C000000626}", "*", false); /* 장비명 */
	col.addColumnCustom("mhrlsNm", "${msg.C000000626}", "*", true); /* 장비 명 */
	col.addColumnCustom("cmpdsNm", "${msg.C000000634}", "*", true);	/* 소모품 명 */
	col.addColumnCustom("useBeginDt", "${msg.C000000641}", "*", true); /* 사용 시작일시 */
	col.addColumnCustom("useEndDt", "${msg.C000000642}", "*", true); /* 사용 종료일시 */
	col.addColumnCustom("usePurps", "${msg.C000000643}", "*", true); /* 사용목적 */
	col.addColumnCustom("rm", "${msg.C000000096}", "*", true); /* 비고 */
	col.addColumnCustom("ordr", "${msg.C000000732}", "*", true); /* 순번 */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true,
 			rowStyleFunction : function(rowIndex, item) {
 				console.log(item);
 				if(item.validChk == "N")
 					return "c-red";
 				return "";
 			}
 	}


	//auiGrid 생성
	MhrlsCmpdsUseMList = createAUIGrid(col, "MhrlsCmpdsUseMList", cusPros);
	// 그리드 리사이즈.
	gridResize([MhrlsCmpdsUseMList]);
	// 그리드 칼럼 리사이즈

	AUIGrid.bind(MhrlsCmpdsUseMList, "ready", function(event) {
		gridColResize([MhrlsCmpdsUseMList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//그리드 이벤트
function setMhrlsGridEvent(){
	AUIGrid.bind(MhrlsCmpdsUseMList, "cellDoubleClick", function(event) {
//  		ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','mhrlsSeqno',{"mhrlsClCode" : event.item.mhrlsClCode}, true, null,null,null,function(data){  // 질문 : 제품 규격 상세 콤보
		ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','mhrlsSeqno',{"mhrlsClCode" : event.item.mhrlsClCode}, true, null,null,null).then(function(){
		detailAutoSet({"item":event["item"],"targetFormArr":["MhrlsCmpdsUseMForm"], "successFunc": function(){
			$("#brcd").prop("disabled", true);
			$("#crud").val("U");
		}
		});
		});
	});
}
//버튼 이벤트 함수
function setButtonEvent(){
	//조회 버튼 이벤트
	$("#btn_select").click(function(){
		searchMhrls();
	});


	//저장 버튼 이벤트
	$("#btn_save").click(function(){
		if(confirm("${msg.C000000306}")){ /* 저장 하시겠습니까? */
			saveMhrls();
		}

	});

	//바코드 이벤트
	$("#brcd").keyup(function(e){
		if(e.keyCode == 13){
			getEl("shrBrcd").value = this.value;
			searchBrcd();
		}
	});

	//시작일시 날짜 형식 체크
	$("#useBeginDt, #useEndDt").change(function(e){
		dateTypeCheck(e.target.id, "dateTime");
	});


	$("#shrMhrlsClCode").change(function(e){
		ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','shrMhrlsNm',{"mhrlsClCode" : e.target.value},true);
	});

	//검색 엔터 이벤트
	$("[id^=shr]").keyup(function(e){
		searchMhrls(e.keyCode);
	});

	//신규버튼
	$("#btn_new").click(function(){
		pageReset(["MhrlsCmpdsUseMForm"], null, null, function(){
			$("#brcd").prop("disabled", false);
			$("#crud").val("C");
		});
	});

	//삭제버튼
	$("#btn_delete").click(function(){
		var params = {
				mhrlsCmpdsSeqno : $("#mhrlsCmpdsSeqno").val(),
				ordr : $("#ordr").val()
		}

		if(confirm("${msg.C000000178}")){ /* 삭제하시겠습니까? */
			customAjax({"url":"<c:url value='/rsc/delMhrlsCmpdsUseM.lims'/>","data": params}).then(function(data){
				alert("${msg.C000000179}"); /* 삭제되었습니다. */
				searchMhrls();
				pageReset(["MhrlsCmpdsUseMForm"], ["MhrlsCmpdsUseMList"], null, function(){
					$("#crud").val("C");
					$("#brcd").prop("disabled", false);
					$("#crud").val("C");
				});
			});
		}
	});

// 	document.getElementById("shrDeptCode").addEventListener("change",function(e){
// 		var value = e.target.value;
// 		if(value)
// 			ajaxJsonComboBox("/com/getChrgTeamCombo.lims", "shrChrgTeamSeqno", {deptCode : value}, true, null);
// 	});

}

//바코드 조회
function searchBrcd(){
	ajaxJsonParam("<c:url value='/rsc/getBrcdMhrlsCmpdsUseM.lims'/>", {shrBrcd : $("#brcd").val()}, function(data){
		if(data.length == 0 || !$("#brcd").val()){
			alert("${msg.C000000645}"); /* 없는 바코드 입니다. */
			return;
		}
		if(!!data[0].validDte){
			if(!getCompareDate(getFormatDate(),data[0].validDte)){
				alert("${msg.C000001031}"); /* 만료된 바코드 입니다. */
				return;
			}
		}

		var saveCss = $(".save").css("display");//저장 권한이 있는지 체크하기 위함.
		//기기 소모품 일련번호 저장
		$("#mhrlsCmpdsSeqno").val(data[0]["mhrlsCmpdsSeqno"]);
		ajaxJsonComboBox('/com/getMhrlsNmCombo.lims','mhrlsSeqno',{"mhrlsClCode" : data[0].mhrlsClCode}, true,null,null,null,function(){
			$("#mhrlsNm").value(data[0].mhrlsSeqno);
		}); /* 선택 */
		//현재 사용 여부가 Y 면 수정 N이면 신규
		if(!data[0]["useBeginDt"] && saveCss != "none"){
			$("#crud").val("C");
			saveMhrls();
		}
		else if(data[0]["useBeginDt"] && data[0]["useEndDt"] && data[0]["useEndDt"] && saveCss != "none"){
			$("#crud").val("C");
			saveMhrls();
		}
		else if(data[0]["useBeginDt"] && !data[0]["useEndDt"] && !data[0]["useEndDt"]){
			detailAutoSet({"item":data[0],"targetFormArr":["MhrlsCmpdsUseMForm"], "successFunc": function(){
				$("#crud").val("U");
			}
			});
		}
		searchMhrls();
	});

}

//저장함수
function saveMhrls(){

	$("#useTime").val(getFindTime("useBeginDt", "useEndDt"));


	ajaxJsonForm("<c:url value='/rsc/instMhrlsCmpdsUseM.lims'/>", 'MhrlsCmpdsUseMForm', function (data) {

		if(data["succesAt"] <= 0){
			alert("${msg.C000000170}"); /* 저장에 실패하였습니다. */
		}else{
			alert("${msg.C000000071}");	/* 저장 되었습니다. */
			searchMhrls();
			pageReset(["MhrlsCmpdsUseMForm"], ["MhrlsCmpdsUseMList"], null, function(){
				$("#crud").val("C");
				$("#brcd").prop("disabled", false);
				$("#crud").val("C");
			});
		}
	});
}
//조회 함수
function searchMhrls(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchMhrls();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/rsc/getMhrlsCmpdsUseMList.lims'/>", "searchFrm", MhrlsCmpdsUseMList);
		}
	}
}
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001032}</h2> <!-- 고비용 소모품 사용 목록 -->
		<div class="btnWrap">
			<button type="button" id="btn_select" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>

		<!-- Main content -->
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
					<th>${msg.C000000627}</th> <!-- 바코드 -->
					<td><input type="text" id="shrBrcd" name="shrBrcd" ></td>
<%-- 					<th>${msg.C000000080}</th> <!-- 부서 --> --%>
<!-- 					<td><select id="shrDeptCode" name="shrDeptCode" ></select></td> -->
					<th>${msg.C000000624}</th> <!-- 담당 팀 -->
					<td><select id="shrChrgTeamSeqno" name="shrChrgTeamSeqno" ></select></td>
					<th>${msg.C000000625}</th> <!-- 소모품 구분 -->
					<td><select id="shrMhrlsCmpdsSeCode" name="shrMhrlsCmpdsSeCode" ></select></td>
					<th>${msg.C000000634}</th> <!-- 소모품 명 -->
					<td><input type="text" id="shrCmpdsNm" name="shrCmdpsNm"></td>

				</tr>
				<tr>
					<th>${msg.C000000007}</th> <!-- 기기분류 -->
					<td><select id="shrMhrlsClCode" name="shrMhrlsClCode" ></select></td>
					<th>${msg.C000000626}</th> <!-- 장비 명 -->
					<td><select id="shrMhrlsNm" name="shrMhrlsNm" ></select></td>
					<td colspan="4"></td>
				</tr>
			</table>
		</form>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
	</div>
	<div id="MhrlsCmpdsUseMList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
	<form id="MhrlsCmpdsUseMForm">

	<input type="hidden" id="mhrlsCmpdsSeqno" name="mhrlsCmpdsSeqno">
	<input type="hidden" id="crud" name="crud">
	<input type="hidden" id="ordr" name="ordr">
	<input type="hidden" id="useTime" name="useTime">

	<div class="subCon1 mgT15" id="detail">
		<h2>${msg.C000000644}</h2> <!-- 고비용 소모품 사용 정보 -->
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button type="button" id="btn_delete" class="btn5 delete" onclick="deleteData()">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btn_save" class="btn1 save">${msg.C000000015}</button> <!-- 저장 -->

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
				<th>${msg.C000000627}</th> <!-- 바코드 -->
				<td>
					<input type="text" id="brcd" name="brcd"  style="min-width:10em;">
				</td>
				<th>${msg.C000000624}</th> <!-- 담당 팀 -->
				<td>
					<input type="hidden" id="chrgTeamSeqno" name="chrgTeamSeqno"  disabled>
					<input type="text" id="chrgTeamNm" name="chrgTeamNm"  disabled>
				</td>
<%-- 				<th>${msg.C000000080}</th> <!-- 부서 --> --%>
<!-- 				<td><input type="text" id="deptNm" name="deptNm"  disabled></td> -->
				<th>${msg.C000000634}</th> <!-- 소모품 명 -->
				<td><input type="text" id="cmpdsNm" name="cmpdsNm"  disabled></td>
				<th>${msg.C000000625}</th> <!-- 소모품 구분 -->
				<td>
					<input type="hidden" id="mhrlsCmpdsSeCode" name="mhrlsCmpdsSeCode"  disabled>
					<input type="text" id="mhrlsCmpdsSeNm" name="mhrlsCmpdsSeNm"  disabled>
				</td>
			</tr>
			<tr>
				<th>${msg.C000000626}</th> <!-- 장비 명 -->
				<td>
					<!-- <input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno"  disabled>
					<input type="text" id="mhrlsNm" name="mhrlsNm"  > -->
					<select id="mhrlsSeqno" name="mhrlsSeqno"></select>
				</td>

				<th>${msg.C000000641}</th> <!-- 사용 시작일시 -->
				<td><input type="text" id="useBeginDt" name="useBeginDt"  ></td>
				<th>${msg.C000000642}</th> <!-- 사용 종료일시 -->
				<td><input type="text" id="useEndDt" name="useEndDt"  ></td>
			</tr>
			<tr>
				<th>${msg.C000000643}</th> <!-- 사용목적 -->
				<td colspan="7"><textarea id="usePurps" name="usePurps" style="width:100%;" rows="3" onkeyup="fnChkByte(this, '4000')"></textarea></td>
			</tr>
			<tr>
				<th>${msg.C000000096}</th> <!-- 비고 -->
				<td colspan="7"><textarea id="rm" name="rm"  rows="2" style="width:100%;" onkeyup="fnChkByte(this, '4000')"></textarea></td>
			</tr>
		</table>
	</div>
	</form>
</div>

<!--  body 끝 -->
</tiles:putAttribute>


</tiles:insertDefinition>