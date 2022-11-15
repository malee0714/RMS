<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>구매 요청 목록</h2>
		<div class="btnWrap">
			<button type="button" id="searchBtn" class="search btn1">조회</button>
		</div>
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:7%"></col>
					<col style="width:18%"></col>
					<col style="width:7%"></col>
					<col style="width:18%"></col>
					<col style="width:7%"></col>
					<col style="width:18%"></col>
					<col style="width:7%"></col>
					<col style="width:18%"></col>
				</colgroup>
				<tr>
					<th>부서</th>
					<td>
						<select id ="requstDeptCodeSch" name="requstDeptCodeSch"  class="wd100p" style="min-width:10em;">
							<option value="" selected="selected">선택</option>
						</select>
					</td>
					<th>구매 요청 일자</th>

					<td style="text-align:left;">
					 		<input type="text" id="requstDteStart" name="requstDteStart" class="wd110" >
						 <span>~</span>
					 		<input type="text" id="requstDteFinish" name="requstDteFinish" class="wd110">
					</td>
					<th>구매 요청명</th>
					<td><input type="text" id="purchsRequstNmSch" name="purchsRequstNmSch" class="wd100p schClass" style="min-width:10em;" ></td>
					<th>진행상황</th>
					<td>
						<select id ="rgntProgrsSittnCodeSch" name="rgntProgrsSittnCodeSch">
							<option value="" selected="selected">선택</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="purchsRequestGrid_Master" style="width:100%; height:200px; margin:0 auto;"></div>
	</div>
	<div class="subCon1 mgT20">
		<h2>구매 요청 상세 정보</h2>
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn1">초기화</button>
			<button type="button" id="btn_delete" class="delete btn1">삭제</button>
			<button type="button" id="btn_save" class="save btn1">	저장</button>
			<button type="button" id="btn_purchs" class="save btn1">구매요청</button>
		</div>
		<form id="purchsRequestInfoFrm">
			<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
					<col style="width:10%"></col>
					<col style="width:23.3%"></col>
				</colgroup>
				<tr>
					<th>구매 요청명</th>
					<td><input type="text" id="purchsRequstNm" name="purchsRequstNm" class="wd100p" style="min-width:10em;" ></td>
					<th>구매 요청자</th>
					<td>
							<input type="text" id="rqesterNm" name="rqesterNm" value = "${UserMVo.userNm}" class="wd75p" style="min-width:10em;" readonly>
							<button type="button" id="rqesterBtn"  class="inTableBtn inputBtn">찾기</button>
							<input type="hidden" id="rqesterId" name="rqesterId" value = "${UserMVo.userId}">
							<input type="hidden" id="requstDeptCode" name="requstDeptCode" value = "${UserMVo.deptCode}">
							<input type="hidden" id="rgntProgrsSittnCode" name="rgntProgrsSittnCode">
							<input type="hidden" id="purchsRequstNmSeqno" name="purchsRequstSeqno" >
							<input type="hidden" id="requstNum" name="requstNum" >
					</td>
					<th>구매 요청 일자</th>
					<td><input type="text" id="purchsRequstDte" name="purchsRequstDte" class="wd100p" style="min-width:10em;" ></td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan='7' ><textarea id="rm" name="rm" class="wd100p" rows="3" style="min-width:10em;" ></textarea></td>
				</tr>
			</table>
			<input type="hidden" id="gbnCrud" name="gbnCrud" value="C"/>
		</form>
	</div>
	<div class="subCon1 wd45p mgT20" style="display:inline-block;">
		<h2>제품 목록</h2>
		<div class="btnWrap">
			<button id="productSch" class="search btn1">조회</button>
		</div>
		<form action="javascript:;" id="productFrm" name="productFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<tr>
					<th>제품명</th>
					<td>
						<input type="text" id="prductNmSch" name="prductNmSch" class="wd100p">
						<input type="hidden" id="useAtSch" name="useAtSch" value="Y">
						<input type="hidden" id="prductSeqno" name="prductSeqno">
						<input type="hidden" id="prductPurchsRequstSeqno" name="purchsRequstSeqno">
					</td>
				</tr>
			</table>

		</form>
		<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="product_Detail" class="mgT15" style="width:100%; height:250px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="wd9p mgT20" style="display:inline-block; height:340px;">
		<div style="margin-top : 90%;">
			<div id="arrowAddRight" class="arrowBtn" style="cursor:pointer; margin-left:44%; width:20px;"><!-- 화살표 --></div>
		</div>
		<div style="margin-top : 40%;">
			<div id="arrowDelLeft" class="arrowBtn fR" style="cursor:pointer; margin-right:36%; width:20px; transform: rotate(180deg);"></div>
		</div>
	</div>
	<div class="subCon1 wd45p mgT20" style="display:inline-block;">
		<h2> 구매 요청 목록</h2>
		<form id="requstIsestatnFrm" name = "requstIsestatnFrm">
			<input type="hidden" id="purchsRequstSeqno" name="purchsRequstSeqno" >
		</form>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="purchsRequstIsestatn_Detail" class="mgT15" style="width:100%; height:305px; margin:0 auto;"></div>
	</div>
</div>

    </tiles:putAttribute>
    <tiles:putAttribute name="script">

<script>
/*******전역변수*********/
var purchsRequestGrid_Master = 'purchsRequestGrid_Master';
var product_Detail = 'product_Detail';
var purchsRequstIsestatn_Detail = 'purchsRequstIsestatn_Detail';
var searchFrm = 'searchFrm';
/*******OnLoad*********/
$(function() {
	getAuth(); //권한 체크

	// 검색 시작일, 종료일 (검색기간 디폴트 1분기)
	datePickerCalendar(["requstDteStart","requstDteFinish"], true, ["DD",-90], ["DD",0]);
	datePickerCalendar(["purchsRequstDte"], true, ["DD",0]);

	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGrid();

	// 콤보박스 바인딩
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGridEvent();

	// 그리드 리사이즈
	gridResize([purchsRequestGrid_Master, product_Detail, purchsRequstIsestatn_Detail]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	// 팝업 이벤트
	popUpEvent();

}); // OnLoad 끝;

// 그리드 생성
function setPurchsRequestGrid(){

	//그리드 레이아웃 정의
	var columnLayout = {
		//그리드 컬럼 담을 배열 정의
		purchsRequestGrid_Master: [],
		product_Detail: [],
		purchsRequstIsestatn_Detail: []
	}

	//컬럼 속성 정의
	var purchsRequestGridColPros = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '값을 입력 또는 선택하세요.'
		}
	};

	var checkEventProps = {
			//엑스트라체크박스 표시
			showRowCheckColumn : true,

			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true
	};

	//컬럼 셋팅
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함

	// 구매요청 그리드
	auigridCol(columnLayout.purchsRequestGrid_Master);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("purchsRequstDte","구매 요청 일자",null,true,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("requstDeptCode","요청 부서 코드",null,false,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("purchsRequstNm","구매 요청명",null,true,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("requstDeptNm","구매 요청 부서",null,true,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("rqesterId","구매 요청자",null,false,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("requstNum","구매 요청 건수",null,true,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("rgntProgrsSittnCode","진행 상황 코드",null,false,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("rgntProgrsSittnNm","진행 상황",null,true,false);
	columnLayout.purchsRequestGrid_Master.addColumnCustom("rm","비고",null,true,false);

	// 제품 목록 그리드
	auigridCol(columnLayout.product_Detail);
	//columnLayout.product_Detail.addColumn("checkBox",'<input type="checkbox" id="checkProduct">',50,true,null);
	columnLayout.product_Detail.addColumnCustom("prductSeqno","제품 일련번호",null,false,false);
	columnLayout.product_Detail.addColumnCustom("prductSeNm","제품 구분",null,true,false);
	columnLayout.product_Detail.addColumnCustom("prductClNm","제품 분류명",null,true,false);
	columnLayout.product_Detail.addColumnCustom("prductNm","제품명",null,true,false);
	columnLayout.product_Detail.addColumnCustom("prposNm","용도",null,true,false);
	columnLayout.product_Detail.addColumnCustom("cstdysttusNm","보관 상태",null,true,false);
	columnLayout.product_Detail.addColumnCustom("prductunitNm","제품 단위",null,true,false);
	columnLayout.product_Detail.addColumnCustom("gridCrud","CRUD",null,false,false);
	//columnLayout.product_Detail.checkBoxRenderer(["checkBox"], product_Detail);

	// 구매요청 그리드
	auigridCol(columnLayout.purchsRequstIsestatn_Detail);
	//columnLayout.purchsRequstIsestatn_Detail.addColumn("checkBox",'<input type="checkbox" id="checkRequstIsestatn">',50,true,null);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("purchsRequstSeqno","구매요청 일련번호",null,false,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductSeqno","제품 일련번호",null,false,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductSeNm","제품 구분",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductClNm","제품 분류명",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductNm","제품명",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("requstQtt","요청 수량",null,true,true, purchsRequestGridColPros);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prposNm","용도",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("cstdysttusNm","보관 상태",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductunitNm","제품 단위",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("gridCrud","CRUD",null,false,false);
	//columnLayout.purchsRequstIsestatn_Detail.checkBoxRenderer(["checkBox"], purchsRequstIsestatn_Detail);

	//그리드 속성 정의
	var purchsRequestGridPros = {

	};

	// 그리드 생성
	purchsRequestGrid_Master = createAUIGrid(columnLayout.purchsRequestGrid_Master, purchsRequestGrid_Master);
	purchsRequstIsestatn_Detail = createAUIGrid(columnLayout.purchsRequstIsestatn_Detail, purchsRequstIsestatn_Detail, checkEventProps);
	product_Detail = createAUIGrid(columnLayout.product_Detail, product_Detail, checkEventProps);

};

// 그리드 이벤트
function setPurchsRequestGridEvent(){
	// 각자 필요한 이벤트 구현

	AUIGrid.clearGridData(purchsRequestGrid_Master);
	AUIGrid.clearGridData(product_Detail);
	AUIGrid.clearGridData(purchsRequstIsestatn_Detail);

	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(purchsRequestGrid_Master, "ready", function(event) {
		gridColResize(purchsRequestGrid_Master, "2");
	});

	AUIGrid.bind(product_Detail, "ready", function(event) {
		gridColResize(product_Detail, "2");
	});

	AUIGrid.bind(purchsRequstIsestatn_Detail, "ready", function(event) {
		gridColResize(purchsRequstIsestatn_Detail, "2");
	});

	// 그리드 체크박스 이벤트
	checkBoxGridEvent(product_Detail,"checkProduct"); // 제품 목록 그리드
	checkBoxGridEvent(purchsRequstIsestatn_Detail,"checkRequstIsestatn"); // 구매 요청 목록 그리드

	// 마스터 그리드(구매 요청 관리 그리드) 셀 클릭 이벤트
	AUIGrid.bind(purchsRequestGrid_Master, 'cellClick', function(event){
		var param;
		// flag : update로 설정
		$('#gbnCrud').val('U'); //  정보 crud

		$('#purchsRequstNm').val(event.item.purchsRequstNm); // 구매요청 명
		$('#rqesterNm').val(event.item.rqesterNm); // 구매요청자
		$('#rm').val(event.item.rm); // 비고

		// 구매요청 정보 수정 조건값
		$('#purchsRequstNmSeqno').val(event.item.purchsRequstSeqno)// 구매요청 일련번호
		// 구매요청 목록 그리드 검색 조건 값
		$('#purchsRequstSeqno').val(event.item.purchsRequstSeqno)// 구매요청 일련번호
		$('#prductPurchsRequstSeqno').val(event.item.purchsRequstSeqno)// 구매요청 일련번호
		//$('#rgntProgrsSittnCode').val(event.item.rgntProgrsSittnCode) // 진행 상황

		// 구매요청 건수
		$('#requstNum').val(event.item.requstNum);

		// 구매 요청 목록 detail 그리드 조회
		searchRequstIsestatn();

		// 제품 목록 detail 그리드 조회
		searchProduct(true);

		// 진행 상황에 따른 버튼 보이기 숨기기
		btnHideShow(event.item.rgntProgrsSittnCode);

		//setData();

	});


	// 구매요청 목록 CRUD 체크
	AUIGrid.bind(purchsRequstIsestatn_Detail, "cellEditEnd", function(event){
		var typeChk = false;
		var regexp = /^[0-9]*$/
		var item;
		var myValue = AUIGrid.getCellValue(purchsRequstIsestatn_Detail, event.rowIndex, "gridCrud")


		if(!regexp.test(Number(event.item["requstQtt"]))){
			// 숫자가 아닐경우 예외 처리하기
			alert('숫자를 입력해 주세요.');
			// 수정해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(purchsRequstIsestatn_Detail,  event.rowIndex, event.columnIndex);
			AUIGrid.setCellValue(purchsRequstIsestatn_Detail,  event.rowIndex, "requstQtt", "");
		}

		if(myValue != "C"){
			item = { gridCrud : "U" };
   			AUIGrid.updateRow(purchsRequstIsestatn_Detail, item, "selectedIndex");
		}

 		return event.value;
 	});

}

//콤보박스 바인딩
function setCombo(){
	var deptCode =  "${UserMVo.deptCode}" // 로그인 사용자 부서코드
	var param = {bestInspctInsttCode: "${UserMVo.bestInspctInsttCode}"} // 로그인 사용자 기관코드

	// 시약 진행상황 바인딩
	ajaxJsonComboBox('/rsc/getComboRgntProgrsSittnCodeList.lims','rgntProgrsSittnCodeSch',null,true,"", "RS05000001");

	// 부서 바인딩
	//ajaxJsonComboBox('/sys/getInspctCode.lims','requstDeptCodeSch',param,true,"", deptCode);
	ajaxJsonComboBox('/sys/getUpperComboListM.lims','requstDeptCodeSch',{"bestInspctInsttCode" : "${UserMVo.bestInspctInsttCode}"},true,null, "${UserMVo.deptCode}");
}

// 버튼 이벤트
function setButtonEvent(){

	// 조회
	$('#searchBtn').click(function(){
		searchPurchsRequestGridorForm();
	});

	// 제품 목록 조회
	$('#productSch').click(function(){
		searchProduct(false);
		//setData();
	});

	// Detail 그리드 데이터 오른쪽 이동
	$('#arrowAddRight').click(function(){
		// 데이터 오른쪽 이동
		myMoveCheckedGridData(product_Detail, purchsRequstIsestatn_Detail);

		gridColResize(purchsRequstIsestatn_Detail, "2");
	});

	// Detail 그리드 데이터 왼쪽 이동
	$('#arrowDelLeft').click(function(){
		myMoveCheckedGridData(purchsRequstIsestatn_Detail, product_Detail);

		gridColResize(product_Detail, "2");
	});

	// 삭제
	$('#btn_delete').click(function(){
		//var code = 'D';
		if(!$('#purchsRequstNmSeqno').val()){
			alert('삭제할 항목을 선택해주세요.');
		}else {
			$('#gbnCrud').val('D')
			//saveValidation(code);
			deleteGrid();
		}

	})

	// 저장 및 수정 벨리데이션 체크
	$('#btn_save').click(function(){
		var code = 'RS05000001';
		var btn = 'btn_save'
		saveValidation(code, btn);
	});

	// 구매요청
	$('#btn_purchs').click(function(){
		var code = 'RS05000002';
		var requstIsestatnGridData = AUIGrid.getGridData(purchsRequstIsestatn_Detail);
		var btn = 'btn_purchs'
		 if(requstIsestatnGridData.length == 0){
			alert('구매요청 목록을 작성해 주세요.');
		}else{
			saveValidation(code,btn);
		}
	});

	// 초기화
	$('#btn_new').click(function(){
		setClear(); // 초기화 함수 호출
	});

	//구매요청관리 (마스터 그리드)엔터키 이벤트
	$("#searchFrm").find("#purchsRequstNmSch").keypress(function (e) {
	    if (e.which == 13){
	    	searchPurchsRequestGridorForm();
	    }
	});

	//제품목록 (디테일 그리드)엔터키 이벤트
	$("#productFrm").find("#prductNmSch").keypress(function (e) {
	  if (e.which == 13){
	    	//setData();
	     searchProduct(false);
	  }
	});

}

/*############ 조회, 저장, 삭제 함수 ############*/
/* 조회 */

// 구매 요청 관리 그리드 조회
function searchPurchsRequestGridorForm(){
	var purchsRequestMList = "<c:url value='/rsc/getPurchsRequestMList.lims'/>";
	//getGridDataForm(url, 폼이름, 그리드id);
	//getGridDataForm(purchsRequestMList, searchFrm, purchsRequestGrid_Master);
	getGridDataForm(purchsRequestMList, searchFrm, purchsRequestGrid_Master);
}

//구매 요청 목록 detail 그리드 조회
function searchRequstIsestatn(){
	var requstIsestatnMList = "<c:url value='/rsc/getRequstIsestatnMList.lims'/>";
	//getGridDataForm(url, 폼이름, 그리드id);
	getGridDataForm(requstIsestatnMList, 'requstIsestatnFrm', purchsRequstIsestatn_Detail);
}


/*
 * 제품 목록 detail 그리드 조회
gbnData: 클릭, 조회 구분값
gbnData: true -> cellclick
gbnData: false -> 조회, 엔터 이벤트
*/
function searchProduct(gbnData){
	var getGridData;
	var productMList = "<c:url value='/rsc/getProductMList.lims'/>";
	var param = { prductNmSch: $("#prductNmSch").val()
						, useAtSch: $("#useAtSch").val()
						, purchsRequstSeqno: $("#prductPurchsRequstSeqno").val()
					};

	if(!gbnData){
		// 구매 요청 목록 그리드 데이터
		getGridData = AUIGrid.getGridData(purchsRequstIsestatn_Detail);

		for(var i=0; i<getGridData.length; i++){
			if(i == getGridData.length-1){
				if(!param.prductSeqnoSch){
					param.prductSeqnoSch = ""
				}
				param.prductSeqnoSch += "'"+getGridData[i].prductSeqno+"'";
			} else {
				if(!param.prductSeqnoSch){
					param.prductSeqnoSch = ""
				}
				param.prductSeqnoSch += "'"+getGridData[i].prductSeqno+"',";
			}
		}
	}

	// 제품 목록 조회
	getGridDataParam(productMList, param, product_Detail)
}

/* 구매 요청 정보 저장 및 수정*/
function savePurchsRequestGridorForm(){
	var saveUrl = "<c:url value='/rsc/savePurchsRequestM.lims'/>";
	var codeGbn = $('#rgntProgrsSittnCode').val()
	var purchsRequstIsestatnGridData = AUIGrid.getGridData(purchsRequstIsestatn_Detail);
	var productGridData = AUIGrid.getGridData(product_Detail);

	var saveData = {"master":getFormParam("purchsRequestInfoFrm"), "detail":purchsRequstIsestatnGridData, "productDetail":productGridData};
	ajaxJsonParam(saveUrl, saveData, function (data) {
		if(data == 0 ){
			alert('저장에 실패하였습니다.');
		}  else {

			// 구매 요청 목록 detail 그리드 조회
			//searchProduct();
			//searchRequstIsestatn();
			alert('저장 되었습니다.');
			setClear(); // 초기화 함수 호출
			searchPurchsRequestGridorForm(); // 그리드 초기화
		}
	});
}

function deleteGrid(){
	var deleteUrl = "<c:url value='/rsc/delPurchsRequestM.lims'/>";
	var deleteData = {"master":getFormParam("purchsRequestInfoFrm"), "detail":getFormParam("requstIsestatnFrm")};

	ajaxJsonParam(deleteUrl, deleteData, function (data) {
		if(data == 0 ){
			alert('삭제에 실패하였습니다.')
		} else {

			// 구매 요청 목록 detail 그리드 조회
			//searchProduct();
			//searchRequstIsestatn();

			alert('삭제되었습니다.')
			setClear(); // 초기화 함수 호출
			searchPurchsRequestGridorForm(); // 그리드 초기화
		}
	});

}


/*############ 기타이벤트 함수 ############*/
// 팝업 이벤트
function popUpEvent(){
	dialogUser("rqesterBtn", "", "PurchsRequesDialog", function(item){

		$('#rqesterNm').val(item.userNm);
		$('#rqesterId').val(item.userId);
		$('#requstDeptCode').val(item.deptCode);
	});
}

// 버튼 보이기 숨기기
function btnHideShow(item){
	if(item == 'RS05000001'){
		$('#btn_purchs').show();
		$('#btn_save').show();
		$('#btn_delete').show();
		//$('#btn_save_RequstIsestatn').show();
	}else {
		$('#btn_purchs').hide();
		$('#btn_save').hide();
		$('#btn_delete').hide();
		//$('#btn_save_RequstIsestatn').hide();
	}
}

// 초기화 함수
function setClear(){
	//AUIGrid.clearGridData(purchsRequestGrid_Master);
	AUIGrid.clearGridData(product_Detail);
	AUIGrid.clearGridData(purchsRequstIsestatn_Detail);

	$('#gbnCrud').val('C'); // flag : create 변경
	$('#purchsRequestInfoFrm')[0].reset(); // 폼 초기화
	$('#productFrm')[0].reset(); // 폼 초기화
	$('#requstIsestatnFrm')[0].reset(); // 폼 초기화
	datePickerCalendar(["purchsRequstDte"], true, ["DD",0]);
	$('#btn_purchs').show();
	$('#btn_save').show();
	$('#btn_delete').show();

	$("#prductPurchsRequstSeqno").val('');
	$('#purchsRequstNmSeqno').val('');// 구매요청 일련번호
	$("#rqesterId").val('${UserMVo.userId}');
	$("#requstDeptCode").val('${UserMVo.deptCode}');

	//$('#btn_save_RequstIsestatn').show();
}

// 저장 벨리데이션 체크
function saveValidation(code, btn){
	var saveRowCount = AUIGrid.getRowCount(purchsRequstIsestatn_Detail);
	// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
	var requstIsestatnGridData = AUIGrid.getGridData(purchsRequstIsestatn_Detail);
	var item;
	var invalid = false;
	var invalidRowIndex = -1;
	var colIndex;
	var count = 0; // 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승

	$('#purchsRequestInfoFrm').find('input').each(function(){
		var nm = $(this).attr("name");

		if( nm == "purchsRequstNm" ){
		    if(!$(this).prop('required')){
	    		if($(this).val() == '') {
	    			count ++;
	    			return;
		    	}
		    }
    	}
	});

	if(btn == 'btn_purchs'){
		for(var i=0, len=requstIsestatnGridData.length; i<len; i++) {
			item = requstIsestatnGridData[i];
			if(typeof item["requstQtt"] == "undefined" || String(item["requstQtt"]).trim() == "" || item["requstQtt"] == null){ // 데이터 체크

				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(purchsRequstIsestatn_Detail, "requstQtt");

			}
		}
	}

	// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
	if(count > 0) {
		alert('필수 사항을 모두 입력해 주십시오');
		return;
	} else if(requstIsestatnGridData.length == 0){
		alert('구매 요청 목록을 작성해주세요.');
	} else {
		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			alert("칼럼의 값은 필수 칼럼이니 반드시 입력해야 합니다.");
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(purchsRequstIsestatn_Detail, invalidRowIndex, colIndex);
		} else {
			$('#rgntProgrsSittnCode').val(code)
			// 실질적인 저장 로직 처리
			savePurchsRequestGridorForm();
		}
	}
}

/**
 * @param gridId 옮기고 싶은 데이터가 있는 그리드
 * @param target 데이터가 옮겨질 그리드
 * ########################
 * 그리드 속성값으로 체크박스 추가시 사용
 * showRowCheckColumn : true
 * showRowAllCheckBox : true
 * ########################
 */
//화살표 클릭 시 선택한 행의 정보를 원하는 그리드로 이동
function myMoveCheckedGridData(gridId, target, rowIndex, etcFunc){
	//선택한 행 객체들을 가져옵니다.
	var checkedItems = AUIGrid.getCheckedRowItems(gridId);

	if(checkedItems){ // 체크된 아이템이 있다면
		AUIGrid.removeCheckedRows(gridId); // 기존 그리드에서 행 삭제

		for(var i=0; i<checkedItems.length; i++){ // 이동할 그리드에 행 추가

			if(target == purchsRequstIsestatn_Detail){
				checkedItems[i].item.gridCrud = "C"
			}

			if(target == product_Detail && checkedItems[i].item.gridCrud != "C"){
				checkedItems[i].item.gridCrud = "D"
			}

			if(target == product_Detail && checkedItems[i].item.gridCrud == "C"){
				checkedItems[i].item.gridCrud = ""
			}

			AUIGrid.addRow(target, checkedItems[i].item, "last");
		}
	}
}



</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>