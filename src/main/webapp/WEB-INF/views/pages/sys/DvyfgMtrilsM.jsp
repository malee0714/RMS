<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">납품업체 제품정보관리</tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
var dvyfgMtrilsList;
$(function(){
	getAuth();
	
	//초기화
// 	init();
	
	//콤보 박스 초기화
	setCombo();
	
	//검교정 목록 그리드 생성
	setDvyfgEntrpsGrid();
	
	//그리드 이벤트
// 	setGridEvent();
	
	//버튼 이벤트 선언
	setButtonEvent();
});

//콤보박스 세팅
function setCombo(){
	var bestParams = {"analsAt" : "Y", "deptAt" : "Y", "mmnySeCode" : "SY01000001"};
	//부서	
	ajaxJsonComboBox('/com/getDeptCombo.lims','shrDeptCode', bestParams, false, null);	
	//납품 업체 구분 코드
	ajaxJsonComboBox('/com/getCmmnCode.lims','shrDvyfgEntrpsSeCode',{"upperCmmnCode" : "SY17"}, false,"${msg.C000000079}"); /* 선택 */
	
}

//제품 목록 그리드 생성
function setDvyfgEntrpsGrid(){
	
	var col = [];
	
	var useYnLst = [
		 {key : "${msg.C000000264}", value : "Y"} /* 예 */
		,{key : "${msg.C000000265}", value : "N"} /* 아니오 */
	];
	
	var filterOp = {
		filter : true		
	};
	
	auigridCol(col);
	
	col.addColumnCustom("dlivyDvyfgMtrilSeqno", "${msg.C000000852}", "*", false, false); /* 출고 납품업체 일련번호 */	 
	col.addColumnCustom("deptCode", "${msg.C000000749}", "*", false, false); /* 부서코드 */
	col.addColumnCustom("deptNm", "${msg.C000000106}", "*", true, false); /* 부서명 */
	col.addColumnCustom("dvyfgEntrpsSeCode", "${msg.C000000853}", "*", true, false); /* 납품업체 구분코드 */
	col.addColumnCustom("dvyfgEntrpsSeNm", "${msg.C000000856}", "*", true, false); /* 납품업체명 */
	col.addColumnCustom("ctmmnyMtrilCode", "${msg.C000000855}", "*", true, true); /* 업체자재코드 */
	col.addColumnCustom("col1", "${msg.C000001265}", "*", true, true, filterOp); /* col1 */
	col.addColumnCustom("col2", "${msg.C000001266}", "*", true, true, filterOp); /* col2 */
	col.addColumnCustom("col3", "${msg.C000001267}", "*", true, true, filterOp); /* col3 */
	col.addColumnCustom("col4", "${msg.C000001268}", "*", true, true, filterOp); /* col4 */
	col.addColumnCustom("col5", "${msg.C000001269}", "*", true, true, filterOp); /* col5 */
	col.addColumnCustom("col6", "${msg.C000001270}", "*", true, true, filterOp); /* col6 */
	col.addColumnCustom("col7", "${msg.C000001271}", "*", true, true, filterOp); /* col7 */
	col.addColumnCustom("col8", "${msg.C000001272}", "*", true, true, filterOp); /* col8 */
	col.addColumnCustom("col9", "${msg.C000001273}", "*", true, true, filterOp); /* col9 */
	col.addColumnCustom("col10", "${msg.C000001274}", "*", true, true, filterOp); /* col10 */
	col.addColumnCustom("orginlDlivyQy", "${msg.C000000860}", "*", true, true); /* 바코드 검증개수 */
	col.addColumnCustom("deleteAt", "${msg.C000000843}", "*", true, false); /* 삭제여부 */
	
	
	col.dropDownListRenderer(["deleteAt"], useYnLst, true, null);
	
	var cusPros = {
			editable : true, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell) 			
 			enableFilter : true,
			wordWrap : true
 	}	
	
	
	//auiGrid 생성
	dvyfgMtrilsList = createAUIGrid(col, "dvyfgMtrilsList", cusPros);
	// 그리드 리사이즈
	gridResize([dvyfgMtrilsList]);
	// 그리드 칼럼 리사이즈
	
	AUIGrid.bind(dvyfgMtrilsList, "ready", function(event) {
		gridColResize([dvyfgMtrilsList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

//버튼 이벤트
function setButtonEvent(){
	
	//조회
	$("#btn_select").click(function(e){
		if(!$("#shrDvyfgEntrpsSeCode").val()){
			alert("${msg.C000000861}"); /* 납품업체를 선택해주세요. */
			return;
		}
		searchdvyfgMtrilsList();
	});
	
	//제조팀 변경 이벤트
	$("#shrDeptCode").change(function(){
		$("#shrDvyfgEntrpsSeCode").val("");
	});
	
	//추가
	$("#btnAdd").click(function(){
		if(!$("#shrDvyfgEntrpsSeCode").val()){
			alert("${msg.C000000861}"); /* 납품업체를 선택해주세요. */
			return;
		}
		
		var item = new Object();
		
		item.deptCode = $("#shrDeptCode").val();
		item.deptNm = $("#shrDeptCode option:selected").text();
		item.dvyfgEntrpsSeCode = $("#shrDvyfgEntrpsSeCode").val();
		item.dvyfgEntrpsSeNm = $("#shrDvyfgEntrpsSeCode option:selected").text();
		item.ctmmnyMtrilCode = "";
		
		item.col1 = "";
		item.col2 = "";
		item.col3 = "";
		item.col4 = "";
		item.col5 = "";
		item.col6 = "";
		item.col7 = "";
		item.col8 = "";
		item.col9 = "";
		item.col10 = "";
		
		item.deleteAt = "N";
		item.orginlDlivyQy = "";
		
		
		AUIGrid.addRow(dvyfgMtrilsList, item, 0);
	});
	
	//삭제
	$("#btnRemove").click(function(){
		if(!$("#shrDvyfgEntrpsSeCode").val()){
			alert("${msg.C000000861}"); /* 납품업체를 선택해주세요. */
			return;
		}
		
		AUIGrid.removeRow(dvyfgMtrilsList, "selectedIndex");
	});
	
	//저장
	$("#btnSave").click(function(){
		if(!$("#shrDvyfgEntrpsSeCode").val()){
			alert("${msg.C000000861}"); /* 납품업체를 선택해주세요. */
			return;
		}
		
		if(!confirm("${msg.C000000306}")){ //저장 하시겠습니까?							
			return;
		}
		
		var params = {};
		params.insMtrilsGrid = AUIGrid.getAddedRowItems(dvyfgMtrilsList);
		params.updMtrilsGrid = AUIGrid.getEditedRowItems(dvyfgMtrilsList);
		params.delMtrilsGrid = AUIGrid.getRemovedItems(dvyfgMtrilsList);
		
		ajaxJsonParam3("<c:url value='/sys/saveDvyfgMtrils.lims'/>", params, function(data){
			searchdvyfgMtrilsList();
		});
	});
	
	//납품업체 변경 이벤트
	$("#shrDvyfgEntrpsSeCode").change(function(e){
		searchdvyfgMtrilsList();
		
		var deptCode = $("#shrDeptCode").val();
		var dvyfgEntrpsSeCode = $("#shrDvyfgEntrpsSeCode").val();
		var colArray = new Array();
		
		//제조 1팀 - 삼성전자
		if(deptCode == "3974" && dvyfgEntrpsSeCode == "SY17000001"){
			colArray = ["Item", "유효기간", "CAN 제작사", "CAN Size", "Plant", "제품정보", "드럼 무게"];
		}
		//제조 1팀 - SK 하이닉스
		else if(deptCode == "3974" && dvyfgEntrpsSeCode == "SY17000002"){
			colArray = ["고객 자재코드", "Item", "Site"];
		}
		//제조 1팀 - 동부 하이텍
		else if(deptCode == "3974" && dvyfgEntrpsSeCode == "SY17000003"){
			colArray = ["고객 자재코드", "Item", "SQ"];
		}
		//제조 2팀 - 삼성전자
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000001"){
			colArray = ["고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간", "드럼 무게","용기"];
		}
		//제조 2팀 - 하이닉스
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000002"){
			colArray = ["고객 자재코드", "Item", "용기", "1차 생성", "2차 생성", "3차 생성", "4차 생성", "갯수"];
		}
		//제조 2팀 - 하이닉스  LOT 000추가
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000020"){
			colArray = ["내부 자재코드", "고객 자재코드", "제품명", "붙임 여부", "적용 제조일"];
		}
		//제조 2팀 - 동부하이텍
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000003"){
			colArray = ["고객 자재코드", "Item", "SQ"];
		}
		//제조 2팀 - 페어차일드
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000006"){
			colArray = ["고객 자재코드", "Item", "공통문자", "자재코드 규칙", "제품코드 규칙"];
		}
		//제조 2팀 - 동부하이텍 (CSA-T07)
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000019"){
			colArray = ["고객 자재코드", "Item", "Q'ty"];
		}
		//제조 2팀 - SK 실트론
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000007"){
			colArray = ["고객 자재코드", "Item", "PART", "Q'ty"];
		}
		//제조 2팀 - LG 디스플레이
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000008"){
			colArray = ["고객 자재코드", "Item", "자리구분", "Maker", "Chemical"];
		}
		//제조 2팀 - 솔브레인 MI(S-2)
		else if(deptCode == "3975" && dvyfgEntrpsSeCode == "SY17000018"){
			colArray = ["고객 자재코드", "Item", "Vendor", "Product", "Grade", "Location", "Lifetime"];
		}
		//제조 3팀 - 삼성전자
		else if(deptCode == "3976" && dvyfgEntrpsSeCode == "SY17000001"){
			colArray = ["고객 자재코드", "Maker", "Produt", "제품명 코드", "Grade", "PLANT 정보", "Lifetime"];
		}
		//제조 3팀 - 하이닉스
		else if(deptCode == "3976" && dvyfgEntrpsSeCode == "SY17000002"){
			colArray = ["고객 자재코드", "Item", "용기", "1차 생성", "2차 생성", "3차 생성", "4차 생성", "갯수"];
		}
		//제조 3팀 - 하이닉스  LOT 000추가
		else if(deptCode == "3976" && dvyfgEntrpsSeCode == "SY17000020"){
			colArray = ["내부 자재코드", "고객 자재코드", "제품명", "붙임 여부", "적용 제조일"];
		}
		//제조 3팀 - 동부하이텍
		else if(deptCode == "3976" && dvyfgEntrpsSeCode == "SY17000003"){
			colArray = ["고객 자재코드", "Item", "SQ"];
		}
		//제조 4팀 - 삼성 SDI
		else if(deptCode == "3977" && dvyfgEntrpsSeCode == "SY17000012"){
			colArray = ["내부 자재코드", "자재명"];
		}
		//제조 4팀 - SK 이노베이션
		else if(deptCode == "3977" && dvyfgEntrpsSeCode == "SY17000013"){
			colArray = ["내부 자재코드", "자재명"];
		}
		//제조 4팀 - foosung MI (삼성SAS)
		else if(deptCode == "3977" && dvyfgEntrpsSeCode == "SY17000018"){
			colArray = ["내부 자재코드", "자재명"];
		}
		//제조 4팀 - foosung E&I Malaysia SDN BHD
		else if(deptCode == "3977" && dvyfgEntrpsSeCode == "SY17000021"){
			colArray = ["내부 자재코드", "자재명"];
		}		
		//FECT 팀 - 삼성전자
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000001"){
			colArray = ["고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간","용기"];
		}
		//FECT 팀 - SK 하이닉스
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000002"){
			colArray = ["고객 자재코드", "Item", "1차 생성", "2차 생성", "3차 생성", "4차 생성","용기"];
		}
		//FECT 팀 - 하이닉스  LOT 000추가
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000020"){
			colArray = ["내부 자재코드", "고객 자재코드", "제품명", "붙임 여부","적용 제조일"];
		}
		//FECT 팀 - 동부 하이텍
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000003"){
			colArray = ["고객 자재코드", "Item", "SQ"];
		}
		//FECT 팀 - 삼성 SMD
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000003"){
			colArray = ["고객 자재코드", "Item", "SQ"];
		}
		//FECT 팀 - 삼성 디스플레이
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000005"){
			colArray = ["고객 자재코드", "고정값"];
		}
		//FECT 팀 - SK 실트론
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000007"){
			colArray = ["고객 자재코드", "Item", "PART", "Q'ty"];
		}
		//FECT 팀 - 에이텍 솔루션
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000014"){
			colArray = ["고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"];
		}
		//FECT 팀 - 원익큐 솔루션
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000015"){
			colArray = ["고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"];
		}
		//FECT 팀 - 종합기술원
		else if(deptCode == "3980" && dvyfgEntrpsSeCode == "SY17000017"){
			colArray = ["고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"];
		}
		//파주 팀 - 삼성전자
		else if(deptCode == "3978" && dvyfgEntrpsSeCode == "SY17000001"){
			colArray = ["고객 자재코드", "내부 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"];
		}
		//파주 팀 - 삼성전기
		else if(deptCode == "3978" && dvyfgEntrpsSeCode == "SY17000022"){
			colArray = ["고객 자재코드","내부 자재코드","고유번호","용기번호","용기구분"];
		}
		//나노소재연구실 - 하이닉스
		else if(deptCode == "4027" && dvyfgEntrpsSeCode == "SY17000020"){
			colArray = ["내부 자재코드", "고객 자재코드", "제품명", "붙임 여부", "적용 제조일"];
		}
		
		//컬럼 초기화
		for(var i=1; i<=10; i++){
			AUIGrid.setColumnPropByDataField( dvyfgMtrilsList, "col"+i, { headerText : "" } );
			AUIGrid.showColumnByDataField(dvyfgMtrilsList, "col"+i);
		}
		
		//해당 컬럼 값이 있으면 헤더명 변경 없으면 컬럽 숨김
		for(var i=1; i<=10; i++){
			if(colArray[i-1]){
				AUIGrid.setColumnPropByDataField( dvyfgMtrilsList, "col"+i, { headerText : colArray[i-1] } );	
			}
			else{
				AUIGrid.hideColumnByDataField(dvyfgMtrilsList, "col"+i);
			}			
		}
	});
}

//조회 함수
function searchdvyfgMtrilsList(keyCode) {
	if(keyCode != undefined && keyCode == 13)
		searchdvyfgMtrilsList();
	else {
		if(keyCode == undefined) {
			getGridDataForm("<c:url value='/sys/getDvyfgMtrils.lims'/>", "searchFrm", dvyfgMtrilsList);
		}
	}
}
</script>

</tiles:putAttribute>
<tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000857}</h2> <!-- 납품업체 목록 -->
		<div class="btnWrap">		
			<button type="button" id="btn_select" class="search btn3">${msg.C000000002}</button><!-- 조회 -->
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
					<th>${msg.C000000862}</th> <!-- 제조팀 -->
					<td><select id="shrDeptCode" name="shrDeptCode"></select></td>
					<th>${msg.C000000856}</th> <!-- 납품업체명 -->
					<td><select id="shrDvyfgEntrpsSeCode" name="shrDvyfgEntrpsSeCode"></select></td>
					<th>${msg.C000000843}</th> <!-- 삭제여부 -->
					<td>
						<select id="shrDeleteAt" name="shrDeleteAt">
							<option value="">${msg.C000000079}</option> <!-- 선택 -->
							<option value="Y">${msg.C000000264}</option> <!-- 예 -->
							<option value="N" selected>${msg.C000000265}</option> <!-- 아니오 -->							
						</select>
					</td>
					<th></th>
					<td></td>
				</tr>
			</table>
		</form>
		
	</div>


	<div class="subCon1 mgT15" style="margin-bottom: 40px;">
		
		<div class="btnWrap">		
			<button type="button" id="btnAdd" class="search btn3">${msg.C000000504}</button> <!-- 추가 -->
			<button type="button" id="btnRemove" class="search btn3">${msg.C000000097}</button> <!-- 삭제 -->
			<button type="button" id="btnSave" class="search btn3">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		
		
	</div>
	<div class="subCon1 mgT15">
		<!-- 납품업체 그리드 -->
		<div id="dvyfgMtrilsList" class="mgT15" style="width:100%; height:300px;"></div>
	</div>
			
</div>
</tiles:putAttribute>
</tiles:insertDefinition>