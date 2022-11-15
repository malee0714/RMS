<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">	
	<div class="subCon1">
		<h2>${msg.C000000181}</h2> <!-- 담당그룹 목록 -->
		<div class="btnWrap">
			<button type="button" id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<form action="javascript:;" id="chrgTeamSearchFrm" name="chrgTeamSearchFrm">
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
					<th>${msg.C000000182}</th> <!-- 담당그룹 명 -->
					<td>
						<input type="text" name="chrgTeamNmSearch" id="chrgTeamNmSearch" class="wd100p schClass">
					</td>
					<th>${msg.C000000183}</th> <!-- 담당자 명 -->
					<td>
						<input type="text" name="userNmSearch" id="userNmSearch" class="wd100p schClass">
					</td>						
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td style="text-align:left;">
						<label><input type="radio" name="useAtSearch" value="">${msg.C000000062}</label> <!-- 전체 -->
				    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
				    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="chrgTeamGrid" style="width:100%; height:220px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="subCon1 mgT20" id="detail">
		<h2>${msg.C000000185}</h2> <!-- 담당그룹 상세 정보 -->
		<div class="btnWrap">
			<button type="button" id="btnReset" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button type="button" id="btnDelete" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<form id="chrgTeamInfoFrm" name ="chrgTeamInfoFrm">
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
					<th class="necessary" style="min-width:100px;">${msg.C000000182}</th> <!-- 담당그룹 명 -->
					<td><input type="text" id=chrgTeamNm name="chrgTeamNm" class="wd100p" style="min-width:10em;"></td>
					<th class="necessary">${msg.C000000067}</th> <!-- 약어 -->
					<td><input type="text" id="abrv" name="abrv" maxlength="1"></td>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td style="text-align:left;">
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N">${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th>${msg.C000000096}</th> <!-- 비고 -->
					<td colspan="7"><textarea id="rm" name="rm" class="wd100p" rows="2" style="min-width:10em;"></textarea></td>
				</tr>
			</table>		
			<input type="text" id="chrgTeamSeqno" name="chrgTeamSeqno" style="display:none">
		</form>
	</div>
	<div class="subCon1 mgT15">
		<h2>${msg.C000000803}</h2> <!-- 담당그룹 IP목록 -->
		<div class="btnWrap">
			<button type="button" id="btnAdd" class="btn4">${msg.C000000111}</button> <!-- 신규 -->
			<button type="button" id="btnDel" class="delete btn5">${msg.C000000097}</button> <!-- 삭제 -->
		</div>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="chrgTeamIpGrid" style="width:100%; height:290px; margin:0 auto;"></div>
		</div>
	</div>
	
	<div class="subCon1" style="display: flex; width: 100%; margin-top : 30px;">
		<div style="order:1; width:48%">
			<h3>${msg.C000000443}</h3> <!-- 전체사용자 -->
			<div class="btnWrap" style="right:52%;">			
				<button id="sAllUserBtn" class="btn3 search" >${msg.C000000002}</button> <!-- 조회 -->
			</div>
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:20%"></col> 
					<col style="width:80%"></col>
				</colgroup>
				<tr>
					<th>${msg.C000000100}</th> <!-- 사용자 명 -->
					<td><input type="text" id="pUserNm" placeholder="${msg.C000000100}"/></td> <!-- 사용자 명 -->
				</tr>
			</table>
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="allUserGrid" class="mgT15"	style="width: 100%; height: 300px; margin: 0 auto;"></div>
		</div>
		<div style="order:2; width : 5%; height:100%;">
			<div style="margin-top:150px;">
				<div id="arrowRight" class="arrowBtn" style="cursor:pointer; margin-left:45%; width:20px;"><!-- 화살표 --></div>
			</div>
			<div style="margin-top:20px;">
				<div id="arrowLeft" class="arrowBtn fR" style="cursor:pointer; margin-right:36%; width:20px; transform: rotate(180deg);"></div>
			</div>
		</div>
		<div style="order:3; width:48%;">
			<h3>${msg.C000000445}</h3> <!-- 권한 사용자 -->

			<!-- Main content -->
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="athUserGrid" class="mgT15" style="width: 100%; height: 340px; margin: 0 auto;"></div>
		</div>
	</div>
</div>

</tiles:putAttribute>
    
<tiles:putAttribute name="script">
<script>

//AUIGrid 생성 후 반환 ID
var chrgTeamGrid = 'chrgTeamGrid';
var chrgTeamIpGrid = 'chrgTeamIpGrid';
var allUserGrid = "allUserGrid";
var athUserGrid = "athUserGrid"; 

var searchChrgTeamUrl = "<c:url value='/wrk/getChrgTeamList.lims'/>";

var saveChrgTeamUrl = "<c:url value='/wrk/saveChrgTeam.lims'/>";

var chrgTeamInfoFrm = 'chrgTeamInfoFrm';
var chrgTeamSearchFrm = 'chrgTeamSearchFrm';
var userSearchForm = 'userSearchForm';
var saveKey = ""; // 포커스이동을 위함 변수

$(function() {	
	getAuth(); //권한 체크
	
	// 콤보 셋팅
 	setCombo();
 		
	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성	
	setChrgTeamGrid();
	setChrgTeamIpGrid();
	
	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setChrgTeamGridEvent();
	
	// 버튼 이벤트
	setButtonEvent();
		
	// 기타 이벤트
	setEtcEvent();
	
	//그리드 사이즈 조절
	gridResize([chrgTeamGrid, chrgTeamIpGrid]);
	
	//폼 및 그리드 클리어
	frmReset();
});

//콤보로드
function setCombo() {
// 	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSearch',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"==전체==", "${UserMVo.deptCode}", "${UserMVo.authorSeCode}");
// 	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCode',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},true,null, "${UserMVo.deptCode}", "${UserMVo.authorSeCode}");
// 	ajaxJsonComboBox('/com/getDeptCombo.lims','pDeptCode',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},true,null, "${UserMVo.deptCode}", "${UserMVo.authorSeCode}");
	//ajaxJsonComboBox('/com/getCmmnCode.lims','mmnySeCode',{"upperCmmnCode" : "SY01"},true,null);
	//ajaxJsonComboBox('/wrk/getTeamList.lims','deptCodeSearch',null,false,"==전체==");
	//ajaxJsonComboBox('/wrk/getTeamList.lims','deptCode',null,true);
	ajaxJsonComboBox('/com/getDeptCombo.lims','pDeptCode',{"limsUseAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},true,null);
};

//그리드 생성-결재라인
function setChrgTeamGrid(){	
////그리드 정의 chrgTeamGrid
	var col = {
		"chrgTeamCol" : [],
		"allUserGrid" : [],
		"athUserGrid" : []
	};		
	auigridCol(col.chrgTeamCol);
	
	col.chrgTeamCol.addColumnCustom("deptNm","${msg.C000000106}",null,true,null); /* 부서명 */
	col.chrgTeamCol.addColumnCustom("chrgTeamNm","${msg.C000000182}",null,true,null); /* 담당그룹 명 */
	col.chrgTeamCol.addColumnCustom("abrv","${msg.C000000067}",null,true,null); /* 약어 */
	col.chrgTeamCol.addColumnCustom("useAt","${msg.C000000065}",null,true,null); /* 사용여부 */
	col.chrgTeamCol.addColumnCustom("rm","${msg.C000000096}",null,true,null); /* 비고 */
	col.chrgTeamCol.addColumnCustom("chrgTeamSeqno","${msg.C000000804}",null,false,null); /* 담당그룹 일련번호 */ 
	col.chrgTeamCol.addColumnCustom("deptCode","${msg.C000000749}",null,false,null); /* 부서코드 */

	//전체사용자
	auigridCol(col.allUserGrid);
	col.allUserGrid.addColumnCustom("deptNm", "${msg.C000000106}","*",true,false); /* 부서명 */
	col.allUserGrid.addColumnCustom("userNm", "${msg.C000000100}","*",true,false); /* 사용자 명 */
	col.allUserGrid.addColumnCustom("userId", "${msg.C000000808}","*",false,false); /* 사용자ID */
	
	//권한 사용자
	auigridCol(col.athUserGrid);
	col.athUserGrid.addColumnCustom("authorCode", "권한 그룹 코드","*",false,false);
	col.athUserGrid.addColumnCustom("deptNm", "${msg.C000000106}","*",true,false);	 /* 부서명 */
	col.athUserGrid.addColumnCustom("userNm", "${msg.C000000100}","*",true,false); /* 사용자 명 */
	col.athUserGrid.addColumnCustom("userId", "${msg.C000000808}","*",false,false); /* 사용자 ID */
	
	var rowStyle = {
		//엑스트라체크박스 표시
		showRowCheckColumn : true,
		// 전체 체크박스 표시 설정
		showRowAllCheckBox : true
	}
	
	// 실제로 #grid_wrap 에 그리드 생성
	chrgTeamGrid = createAUIGrid(col.chrgTeamCol, chrgTeamGrid);
	allUserGrid = createAUIGrid(col.allUserGrid ,allUserGrid, rowStyle);
	athUserGrid = createAUIGrid(col.athUserGrid ,athUserGrid, rowStyle);
	
	//그리드 사이즈 조절
	gridResize([chrgTeamGrid, allUserGrid, athUserGrid]);
};

//그리드 생성-결재라인
function setChrgTeamIpGrid(){	
////그리드 정의 chrgTeamGrid
	var chrgTeamIpCol = [];		
	auigridCol(chrgTeamIpCol);
	
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
	var chrgTeamIpGridColPros = {
			
	};
	chrgTeamIpCol.addColumnCustom("chrgTeamIpSeqno","${msg.C000000805}",null,false,null,chrgTeamIpGridColPros); /* 담당팀 IP 일련번호 */
	chrgTeamIpCol.addColumnCustom("chrgTeamSeqno","${msg.C000000804}",null,false,null,chrgTeamIpGridColPros); /* 담당그룹 일련번호 */
	chrgTeamIpCol.addColumnCustom("chrgTeamSeNm","${msg.C000000806}",null,true,true,chrgTeamIpGridColPros); /* 담당팀 구분명 */
	chrgTeamIpCol.addColumnCustom("rceptPcIp","${msg.C000000184}",null,true,true,chrgTeamIpGridColPros); /* 접수 PC IP */
	
// 	String chrgTeamIpSeqno; /* 담당 팀 IP 일련번호 */
// 	String chrgTeamSeqno; /* 담당 팀 일련번호 */
// 	String chrgTeamSeNm; /* 담당 팀 구분 명 */
// 	String rceptPcIp; /* 접수 PC IP */
// 	String lastChangerId; /* 최종 변경자 ID */
// 	String lastChangeDt; /* 최종 변경 일시 */

	//속성
	var chrgTeamIpGridPros = {
		
	};
	
	// 실제로 #grid_wrap 에 그리드 생성
	chrgTeamIpGrid = createAUIGrid(chrgTeamIpCol, chrgTeamIpGrid, chrgTeamIpGridPros);
	
};

//그리드 생성-사용자목록
function setUserGrid(){	
////그리드 정의 chrgTeamGrid
	var userCol = [];		
	auigridCol(userCol);
	
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
	var userGridColPros = {
			
	};
	userCol.addColumn("checkBox",'<input type="checkbox" id="checkUser" style="width:50px;">',50,true,null,userGridColPros);
	userCol.addColumnCustom("chrgTeamSeqno","${msg.C000000807}",null,false,null,userGridColPros); /* 결재라인 일련번호 */
	userCol.addColumnCustom("deptNm","${msg.C000000106}",null,true,null,userGridColPros); /* 부서명 기존 width250 */
	userCol.addColumnCustom("userId","${msg.C000000808}",null,false,null,userGridColPros); /* 사용자ID */
	userCol.addColumnCustom("userNm","${msg.C000000100}",null,true,null,userGridColPros); /* 사용자 명 기존 width 120*/
	userCol.checkBoxRenderer(["checkBox"],userGrid);
	
	//속성
	var userGridPros = {
		
	};
	
	// 실제로 #grid_wrap 에 그리드 생성
	userGrid = createAUIGrid(userCol, userGrid, userGridPros);
	
};

//그리드 이벤트
function setChrgTeamGridEvent(){
	AUIGrid.bind(chrgTeamGrid, "ready", function(event) {
		gridColResize(chrgTeamGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
		if (saveKey != null && saveKey != "")
			gridSelectRow(chrgTeamGrid, "chrgTeamSeqno", [saveKey]);
	});
	
	AUIGrid.bind(chrgTeamGrid, "cellDoubleClick", function(event) {
		frmReset();
		$('#chrgTeamSeqno').val(event.item.chrgTeamSeqno);		
		$('#deptCode').val(event.item.deptCode);
		$('#chrgTeamNm').val(event.item.chrgTeamNm);
		$("#rm").val(event.item.rm);
		$("#rceptPcIp").val(event.item.rceptPcIp);
		$("#abrv").val(event.item.abrv);
		
		getGridDataParam("<c:url value='/wrk/getChrgTeamIpList.lims'/>", {chrgTeamSeqno : event.item.chrgTeamSeqno}, chrgTeamIpGrid);
		
		if(event.item.useAt == 'Y')
			$("#useY").val(event.item.useAt).prop("checked", true);
		else 
			$("#useN").val(event.item.useAt).prop("checked", true);
		
		athUserData(function(){
			allUserData();
		})	
	});
};

function setUserGridEvent(){
	AUIGrid.bind(userGrid, "ready", function(event) {
		//gridColResize(userGrid, "1");	// 1, 2가 있으니 화면에 맞게 적용
	});
	
	checkBoxGridEvent(userGrid,"checkUser");
};

function setChrgTeamUserGridEvent(){	
	AUIGrid.bind(chrgTeamUserGrid, "ready", function(event) {
		//gridColResize(chrgTeamUserGrid, "1");	// 1, 2가 있으니 화면에 맞게 적용
	});
	
	checkBoxGridEvent(chrgTeamUserGrid,"checkChrgTeamUser");
};

//버튼 이벤트
function setButtonEvent(){
	//결재라인 조회버튼
	$('#btnSearch').click(function(){
		saveKey = "";
		searchChrgTeamGrid();
	});
	
	//초기화
	$("#btnReset").click(function (){
		frmReset();
	})
	
	//결재라인 저장
	$("#btnSave").click(function (){		
		saveChrgTeamGrid();
	})
	
	$("#btnDelete").click(function(){
		deleteChrgTeam();
	})
	
	$(".schClass").keypress(function (e) {
      if (e.which == 13){
		saveKey = "";
		searchChrgTeamGrid();
      }
	});
	
	$("#pUserNmSearch").keypress(function (e) {
      if (e.which == 13){
		searchUserAGrid($('#chrgTeamSeqno').val());
      }
	});
	
	//사용자목록조회
	$('#btnSearch_AllUser').click(function(){
		searchUserAGrid($('#chrgTeamSeqno').val());
	});	
	
	$("#btnAdd").click(function(){
		
		if(!$("#chrgTeamSeqno").val()){
			alert("${msg.C000000809}"); /* 담당그룹을 먼저 선택하셔야 추가할 수 있습니다. */
			return false;
		}
		
		AUIGrid.addRow(chrgTeamIpGrid, {}, "last");
	});
	
	$("#btnDel").click(function(){
		
		if(!$("#chrgTeamSeqno").val()){
			alert("${msg.C000000810}"); /* 담당그룹을 먼저 선택하셔야 삭제할 수 있습니다. */
			return false;
		}
		
		AUIGrid.removeRow(chrgTeamIpGrid, "selectedIndex");
	});
	
	$("#sAllUserBtn").click(function(){
		allUserData(function(data){
			AUIGrid.setGridData(allUserGrid, data);
		});
	});
	
	$("#arrowRight").click(function(){
		rowMoveEvent("right");
	});
	
	$("#arrowLeft").click(function(){
		rowMoveEvent("left");
	});
};

//행 이동 이벤트
function rowMoveEvent(dir){
	var checkedRow;
	
	//오른쪽버튼이면 전체 사용자그리드에서 체크된 사용자 가져오기
	if(dir == "right"){
		checkedRow = AUIGrid.getCheckedRowItemsAll(allUserGrid);
		
		if(checkedRow.length > 0){
			// 얻은 행을 하단 그리드에 추가하기
			AUIGrid.addRow(athUserGrid, checkedRow, "last");
			
			// 선택한 상단 그리드 행들 삭제
			// 삭제하면  "이동" 이고, 삭제하지 않으면 "복사" 를 구현할 수 있음.
			AUIGrid.removeCheckedRows(allUserGrid);
		}
	}else if(dir == "left"){ //왼쪽버튼이면 담당팀 사용자그리드에서 체크된 사용자 가져오기
		checkedRow = AUIGrid.getCheckedRowItemsAll(athUserGrid);
	
		if(checkedRow.length > 0){
			// 얻은 행을 하단 그리드에 추가하기
			AUIGrid.addRow(allUserGrid, checkedRow, "last");
			
			// 선택한 상단 그리드 행들 삭제
			// 삭제하면  "이동" 이고, 삭제하지 않으면 "복사" 를 구현할 수 있음.
			AUIGrid.removeCheckedRows(athUserGrid);
		}
	}
	
	
}

//전체사용자
function allUserData(){
	var row = AUIGrid.getGridData(athUserGrid);
	var userIdList = [];
	for(var i = 0; i< row.length; i++){
		userIdList.push(row[i].userId);
	}
	var param = {"pUserNm" : $("#pUserNm").val(), "deptCode" : "'3992','3993'", "limsUseAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}", "userIdList" : userIdList}
	customAjax({
		"url": "/sys/getAllUserList.lims",
		data: param
	}).then(function(data) {
		console.log(data);
		AUIGrid.setGridData(allUserGrid, data);
	});
	
}

//전체사용자
function athUserData(callBack){
	var param = {"chrgTeamSeqno" : $("#chrgTeamSeqno").val()};
	customAjax({
		"url": "/wrk/getChrgTeamUserList.lims",
		data: param
	}).then(function(data) {
		console.log("ath user : " , data);
		AUIGrid.setGridData(athUserGrid, data);
		
		if(typeof callBack == "function"){
			callBack();
		}
	});
	
}

//삭제 이벤트
function deleteChrgTeam(){
	var chrgTeamSeqno = $('#chrgTeamSeqno').val();
	
	if(!chrgTeamSeqno){
		alert("${msg.C000000188}"); /* 선택된 담당 그룹이 없습니다. */
		return false;
	}
	
	if(!confirm("${msg.C000000178}")){ /* 삭제하시겠습니까? */
		return false;
	}
	
	customAjax({
		"url": "/wrk/deleteChrgTeam.lims",
		"data": {"chrgTeamSeqno" : chrgTeamSeqno}
	}).then(function(data) {
		console.log(data);
		if(data == 1){
			alert("${msg.C000000179}"); /* 삭제되었습니다. */
			searchChrgTeamGrid();
			frmReset();
		}
	});

}

//기타이벤트
function setEtcEvent(){
}

/*############ 조회, 저장, 삭제 함수 ############*/
//결재라인조회
function searchChrgTeamGrid(){	
	//getGridDataForm(searchChrgTeamUrl, chrgTeamSearchFrm, chrgTeamGrid);
	getGridDataForm(searchChrgTeamUrl, chrgTeamSearchFrm, chrgTeamGrid);
};

//결재라인저장
function saveChrgTeamGrid(){	
	if(!saveValidation("chrgTeamInfoFrm")){
		return false;
	}
	
	var gridParam = {
		"addedIpList" : AUIGrid.getAddedRowItems(chrgTeamIpGrid),
		"editedIpList" : AUIGrid.getEditedRowItems(chrgTeamIpGrid),
		"removedIpList" : AUIGrid.getRemovedItems(chrgTeamIpGrid),
		"userList" : AUIGrid.getGridData(athUserGrid)
	};
		
	var saveData = Object.assign($("#chrgTeamInfoFrm").serializeObject(), gridParam);
// 	if (sanctnerGridData != null) {	
	customAjax({
		url: saveChrgTeamUrl,
		data: saveData
	}).then(function(data,status,request) {
		if(!!data)
			alert("${msg.C000000071}"); /* 저장 되었습니다. */
			saveKey = data;
			searchChrgTeamGrid();
	}, function (request,status,error) {
			alert("${msg.C000000190}"); 
	});
	/*
	ajaxJsonParam(saveChrgTeamUrl, saveData,
		function(data) {
			if(!!data)
				alert("${msg.C000000071}"); 
			saveKey = data;
			searchChrgTeamGrid();
		}, function (request,status,error) {
			alert("${msg.C000000190}"); 
	});
	*/
// 	}
};

//폼 초기화시 이벤트별로 셋팅할 것 들
function frmReset(){
	$('#' + chrgTeamInfoFrm)[0].reset();	
	AUIGrid.setGridData(chrgTeamIpGrid,[]);
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>