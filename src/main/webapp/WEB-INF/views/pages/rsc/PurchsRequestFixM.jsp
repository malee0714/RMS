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
					<th>구매 일자</th>
					<td>
						 <input type="text" id="requstDteStart" name="requstDteStart" class="wd110" >
							 <span>~</span>
						 <input type="text" id="requstDteFinish" name="requstDteFinish" class="wd110">
					</td>
					<th>구매명</th>
					<td><input type="text" id="purchsNmSch" name="purchsNmSch" class="wd100p schClass" style="min-width:10em;" ></td>
					<th>진행상황</th>
					<td>
						<select id ="rgntProgrsSittnCodeSch" name="rgntProgrsSittnCodeSch"  >
							<option value="" selected="selected">선택</option>
						</select>
					</td>
					<th>부서</th>
					<td>
						<select id ="requstDeptCodeSch" name="requstDeptCodeSch" >
							<option value="" selected="selected">선택</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="purchsRequestFixGrid_Master" style="width:100%; height:200px; margin:0 auto;"></div>
	</div>

	<div class="subCon1 mgT20">
		<h2>구매 요청 확정 상세 정보</h2>
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn1">초기화</button>
			<button type="button" id="btn_delete" class="delete btn1">삭제</button>
			<button type="button" id="btn_save" class="save btn1">저장</button>
			<button type="button" id="btn_purchs" class="save btn1">구매</button>
		</div>
		<form id="purchsRequestFixInfoFrm">
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
					<th>구매명</th>
					<td><input type="text" id="purchsNm" name="purchsNm"  ></td>
					<th>구매자</th>
					<td>
						<input type="text" id="purchsrNm" name="purchsrNm" value = "${UserMVo.userNm}" class="wd67p" style="min-width:10em;" readonly>
						<button id="rqesterBtn" type="button" class="inTableBtn inputBtn">찾기</button>
						<input type="hidden" id="purchsrId" name="purchsrId" value = "${UserMVo.userId}">
						<input type="hidden" id="purchsDeptCode" name="purchsDeptCode" value = "${UserMVo.deptCode}">
						<input type="hidden" id="rgntProgrsSittnCode" name="rgntProgrsSittnCode">
						<input type="hidden" id="updPurchsSeqno" name="purchsSeqno" >
						<input type="hidden" id="requstNum" name="requstNum" >
					</td>
					<th>구매일자</th>
					<td><input type="text" id="purchsDte" name="purchsDte"  ></td>
					<th>총 금액</th>
					<td><input type="text" id="commaTotAmount" name="commaTotAmount" readOnly>
						<input type="hidden" id="totAmount" name="totAmount"  readOnly>
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td class="wd33p" colspan='7' ><textarea id="rm" name="rm" class="wd100p" rows="3" style="min-width:10em;" ></textarea></td>
				</tr>
			</table>
			<input type="hidden" id="gbnCrud" name="gbnCrud" value="C"/>
		</form>
	</div>
	<div class="subCon1 wd45p mgT20" style="display:inline-block;">
		<h2>구매 요청 목록</h2>
		<div class="btnWrap">
			<button type="button" id="productSch" class="search btn1">조회</button>
		</div>
		<form action="javascript:;" id="purchsrequstFixIsestatnFrm" name="purchsrequstFixIsestatnFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:12%"></col>
					<col style="width:38%"></col>
					<col style="width:12%"></col>
					<col style="width:38%"></col>
				</colgroup>
				<tr>
					<th>구매 요청명</th>
					<td><input type="text" id="purchsRequstNmSch" name="purchsRequstNmSch" class="wd100p" ></td>
					<th>구매 요청 일자</th>
					<td>
					 	<input type="text" id="requstDteStartDetail" name="requstDteStart" class="wd110" >
						 	<span>~</span>
					 	<input type="text" id="requstDteFinishDetail" name="requstDteFinish" class="wd110">
					</td>
				</tr>
			</table>
			<input type="hidden" id="productPurchsSeqno" name="purchsSeqno" >
		</form>
		<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="purchsRequstIsestatn_Detail" class="mgT15" style="width:100%; height:250px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="subCon1 wd9p" style="display:inline-block; height:340px;">
		<div style="margin-top : 90%;">
			<div id="arrowAddRight" class="arrowBtn" style="cursor:pointer; margin-left:44%; width:20px;"><!-- 화살표 --></div>
		</div>
		<div style="margin-top : 20%;">
			<div id="arrowDelLeft" class="arrowBtn fR" style="cursor:pointer; margin-right:36%; width:20px; transform: rotate(180deg);"></div>
		</div>
	</div>
	<div class="subCon1 wd45p mgT20" style="display:inline-block;">
		<h2>구매 확정 목록</h2>
		<form id="requstFixIsestatnFrm" name = "requstFixIsestatnFrm">
			<input type="hidden" id="purchsSeqno" name="purchsSeqno" >
			<input type="hidden" id="detailRgntProgrsSittnCode" name="rgntProgrsSittnCode" >
		</form>
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="purchsRequestFixIsestatn_Detail" class="mgT15" style="width:100%; height:305px; margin:0 auto;"></div>
	</div>
</div>


    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var purchsRequestFixGrid_Master = 'purchsRequestFixGrid_Master';
var purchsRequstIsestatn_Detail = 'purchsRequstIsestatn_Detail';
var purchsRequestFixIsestatn_Detail = 'purchsRequestFixIsestatn_Detail';
var searchFrm = 'searchFrm';
/*******OnLoad*********/
$(function() {
	getAuth(); //권한 체크

	// 검색 시작일, 종료일 (검색기간 디폴트 1분기)
	datePickerCalendar(["requstDteStart","requstDteFinish"], true, ["DD",-90], ["DD",0]);
	datePickerCalendar(["purchsDte"], true, ["DD",0]);

	// 구매요청목록 검색 시작일, 종료일
	datePickerCalendar(["requstDteStartDetail","requstDteFinishDetail"], true, ["DD",-90], ["DD",0]);


	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGrid();

	// 콤보박스 바인딩
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGridEvent();

	// 그리드 리사이즈
	gridResize([purchsRequestFixGrid_Master, purchsRequstIsestatn_Detail, purchsRequestFixIsestatn_Detail]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	// 팝업 이벤트
	popUpEvent();

}); // OnLoad 끝;

// 그리드 생성
function setPurchsRequestGrid(){

	//그리드 레이아웃 정의
	var columnLayout = {
		//그리드 컬럼 담을 배열 정의
		purchsRequestFixGrid_Master: [],
		purchsRequstIsestatn_Detail: [],
		purchsRequestFixIsestatn_Detail: []
	}

	//컬럼 속성 정의
	var purchsRequestGridColPros = {
			dataType : "numeric",
			formatString : "#,##0"
	};

	var purchsToolPros = {
			dataType : "numeric",
			formatString : "#,##0",
			style : "my-require-style",
			headerTooltip : { // 헤더 툴팁 표시 일반 스트링
				show : true,
				tooltipHtml : '값을 입력 또는 선택하세요.'
			}
	};

	var checkEventProps = {
			//showStateColumn : true,
			//엑스트라체크박스 표시
			showRowCheckColumn : true,

			// 전체 체크박스 표시 설정
			showRowAllCheckBox : true
	};

	//컬럼 셋팅
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함

	// 구매요청확정 그리드
	auigridCol(columnLayout.purchsRequestFixGrid_Master);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("purchsDte","구매 일자",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("purchsNm","구매명",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("requstDeptNm","구매 부서",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("rqesterNm","구매자",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("requstNum","구매 건수",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("rgntProgrsSittnNm","진행 상황",null,true,false);
	columnLayout.purchsRequestFixGrid_Master.addColumnCustom("rm","비고",null,true,false);


	// 구매요청목록 그리드
	auigridCol(columnLayout.purchsRequstIsestatn_Detail);
	//columnLayout.purchsRequstIsestatn_Detail.addColumn("checkBox",'<input type="checkbox" id="checkRequstIsestatn">',50,true,null);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("purchsSeqno","구매 일련 번호",null,false,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductSeqno","제품 일련 번호",null,false,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("purchsRequstSeqno","구매 요청번호",null,false,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("purchsRequstNm","구매 요청명",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("purchsRequstDte","구매 요청 일자",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductSeNm","제품 구분",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductClNm","제품 분류명",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductNm","제품명",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("requstQtt","요청수량",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prposNm","용도",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("cstdysttusNm","보관 상태",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("prductunitNm","제품 단위",null,true,false);
	columnLayout.purchsRequstIsestatn_Detail.addColumnCustom("gridCrud","CRUD",null,false,false);
	//columnLayout.purchsRequstIsestatn_Detail.checkBoxRenderer(["checkBox"], purchsRequstIsestatn_Detail);


	// 구매목록 그리드
	auigridCol(columnLayout.purchsRequestFixIsestatn_Detail);
	//columnLayout.purchsRequestFixIsestatn_Detail.addColumn("checkBox",'<input type="checkbox" id="checkRequestFixIsestatn">',50,true,null);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("purchsSeqno","구매 일련 번호",null,false,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prductSeqno","제품 일련 번호",null,false,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("purchsRequstSeqno","구매 요청번호",null,false,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prductSeNm","제품 구분",null,false,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prductClNm","제품 분류명",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prductNm","제품명",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("requstQtt","요청 수량",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("purchsQtt","구매 수량",null,true,true, purchsToolPros); // 수정가능, 숫자만입력 체크
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("untpc","단가",null,true,false, purchsRequestGridColPros);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("price","금액",null,true,false, purchsRequestGridColPros);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prposNm","용도",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("cstdysttusNm","보관 상태",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("prductunitNm","제품 단위",null,true,false);
	columnLayout.purchsRequestFixIsestatn_Detail.addColumnCustom("gridCrud","CRUD",null,false,false);
	//columnLayout.purchsRequestFixIsestatn_Detail.checkBoxRenderer(["checkBox"], purchsRequestFixIsestatn_Detail);

	//그리드 속성 정의
	var purchsRequestGridPros = {

	};

	// 그리드 생성
	purchsRequestFixGrid_Master = createAUIGrid(columnLayout.purchsRequestFixGrid_Master, purchsRequestFixGrid_Master);
	purchsRequstIsestatn_Detail = createAUIGrid(columnLayout.purchsRequstIsestatn_Detail, purchsRequstIsestatn_Detail,checkEventProps);
	purchsRequestFixIsestatn_Detail = createAUIGrid(columnLayout.purchsRequestFixIsestatn_Detail, purchsRequestFixIsestatn_Detail,checkEventProps);
};

// 그리드 이벤트
function setPurchsRequestGridEvent(){
	// 각자 필요한 이벤트 구현
	AUIGrid.clearGridData(purchsRequestFixGrid_Master);
	AUIGrid.clearGridData(purchsRequstIsestatn_Detail);
	AUIGrid.clearGridData(purchsRequestFixIsestatn_Detail);

	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(purchsRequestFixGrid_Master, "ready", function(event) {
		gridColResize(purchsRequestFixGrid_Master, "2");
	});
	AUIGrid.bind(purchsRequstIsestatn_Detail, "ready", function(event) {
		gridColResize(purchsRequstIsestatn_Detail, "2");
	});
	AUIGrid.bind(purchsRequestFixIsestatn_Detail, "ready", function(event) {
		gridColResize(purchsRequestFixIsestatn_Detail, "2");
	});

	// 그리드 체크박스 이벤트
	checkBoxGridEvent(purchsRequestFixIsestatn_Detail,"checkRequestFixIsestatn"); // 구매 목록 그리드
	checkBoxGridEvent(purchsRequstIsestatn_Detail,"checkRequstIsestatn"); // 제품 목록 그리드

	// 마스터 그리드(구매 요청 관리 그리드) 셀 클릭 이벤트
	AUIGrid.bind(purchsRequestFixGrid_Master, 'cellClick', function(event){
		// flag : update로 설정
		$('#gbnCrud').val('U'); //  정보 crud


		// 구매요청 확정 정보 데이터 채우기
		$('#purchsNm').val(event.item.purchsNm) // 구매명
		$('#purchsrNm').val(event.item.rqesterNm) // 구매자
		$('#purchsDte').val(event.item.purchsDte) // 구매일자
		$("#totAmount").val(event.item.totAmount)
		$('#commaTotAmount').val(thousandSeparatorCommas(event.item.totAmount)) // 총금액
		$('#rm').val(event.item.rm) // 비고
		$("#updPurchsSeqno").val(event.item.purchsSeqno) // 구매 일련 번호 채우기

		// 구매요청 건수
		$('#requstNum').val(event.item.requstNum)

		// 구매 목록 detail 그리드 조회
		$('#purchsSeqno').val(event.item.purchsSeqno) // 구매목록 조회 조건 값
		searchPurchsIsestatnFixDetailGridorForm();

		// 구매 요청 목록 (제품 목록) detail 그리드 조회
		$('#productPurchsSeqno').val(event.item.purchsSeqno) // 구매 요청 목록 조회 조건 값
		searchRequestFixDetailGridorForm(true);

		// 진행 상황에 따른 버튼 보이기 숨기기
		btnHideShow(event.item.rgntProgrsSittnCode);

	});


	// 구매요청 목록 CRUD 체크 / 금액 계산
	AUIGrid.bind(purchsRequestFixIsestatn_Detail, "cellEditEnd", function(event){
		var myValue = AUIGrid.getCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "gridCrud")
		var getQtt = AUIGrid.getCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "purchsQtt");
		var getPrice = AUIGrid.getCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "untpc");
		//var check = AUIGrid.getCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "checkBox");
		var regexp = /^[0-9]*$/

		//console.log(check);

		if(myValue != "C"){
			item = { gridCrud : "U" };
   			AUIGrid.updateRow(purchsRequestFixIsestatn_Detail, item, "selectedIndex");
		}

		// 금액 계산
		if(!regexp.test(Number(event.item["purchsQtt"]))){
			alert('숫자를 입력해 주세요.')
			AUIGrid.setCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "purchsQtt", '');
			AUIGrid.setSelectionByIndex(purchsRequestFixIsestatn_Detail, event.rowIndex, event.columnIndex);

		}else if(getQtt){
				AUIGrid.setCellValue(purchsRequestFixIsestatn_Detail, event.rowIndex, "price", getQtt * getPrice);
		}
		// 총 합계 계산
		totalPrice();
 		return event.value;
 	});

}

//콤보박스 바인딩
function setCombo(){
	var deptCode =  "${UserMVo.deptCode}" // 로그인 사용자 부서코드
	var param = {bestInspctInsttCode: "${UserMVo.bestInspctInsttCode}"} // 로그인 사용자 기관코드

	// 시약 진행상황 바인딩
	ajaxJsonComboBox('/rsc/getComboRgntProgrsSittnCodeList.lims','rgntProgrsSittnCodeSch',null,true,"", "RS05000003");

	// 부서 바인딩
	//ajaxJsonComboBox('/sys/getInspctCode.lims','requstDeptCodeSch',param,true,"", deptCode);
	ajaxJsonComboBox('/sys/getUpperComboListM.lims','requstDeptCodeSch',{"bestInspctInsttCode" : "${UserMVo.bestInspctInsttCode}"},true,null, "${UserMVo.deptCode}");
}

// 버튼 이벤트
function setButtonEvent(){

	// 마스터 그리드 조회
	$('#searchBtn').click(function(){
		setClear();
		searchPurchsRequestFixGridorForm();
	});

	// 구매요청 목록 조회
	$('#productSch').click(function(){
		searchRequestFixDetailGridorForm(false);
	});

	// 구매요청 확정 정보, 구매목록 저장 벨리데이션 체크
	$('#btn_save').click(function(){
		var code = 'RS05000003';
		var btn = 'btn_save'
		saveValidation(code,btn);
	});

	// 삭제
	$("#btn_delete").click(function(){
		if(!$('#updPurchsSeqno').val()){
			alert('삭제할 항목을 선택해주세요.');
		}else {
			var code = 'RS05000002';
			$('#gbnCrud').val('D')
			$('#detailRgntProgrsSittnCode').val(code) // 디테일 그리드 진행상황 코드 값 할당

			deleteGrid();
		}
	});

	// 구매
	$('#btn_purchs').click(function(){
		var code = 'RS05000004';
		//var requstNum = $('#requstNum').val();
		var fixIsestatnGridData = AUIGrid.getGridData(purchsRequestFixIsestatn_Detail);
		var btn = 'btn_purchs'
		//var chkNumber = $('#updPurchsSeqno').val()

		/* if(!chkNumber){
			alert('구매할 항목을 선택해주세요.');
		} else  */

		if(fixIsestatnGridData.length == 0){
			alert('구매목록을 작성해 주세요.');
		}else{
			saveValidation(code,btn);
		}
	});

	// 초기화
	$("#btn_new").click(function(){
		setClear();
	});



	// Detail 그리드 데이터 오른쪽 이동
	$('#arrowAddRight').click(function(){
		// 데이터 오른쪽 이동
		myMoveCheckedGridData(purchsRequstIsestatn_Detail, purchsRequestFixIsestatn_Detail);
		gridColResize(purchsRequestFixIsestatn_Detail, "2");

		// 총 합계 계산
		totalPrice();
	});

	// Detail 그리드 데이터 왼쪽 이동
	$('#arrowDelLeft').click(function(){
		myMoveCheckedGridData(purchsRequestFixIsestatn_Detail, purchsRequstIsestatn_Detail);
		gridColResize(purchsRequstIsestatn_Detail, "2");

		// 총 합계 계산
		totalPrice();
	});

	// 구매 요청 확정 관리 그리드 조회
	$("#searchFrm").find("#purchsNmSch").keypress(function (e) {
	  	if (e.which == 13){
	  		searchPurchsRequestFixGridorForm();
	    }
	});

	//구매요청목록 (디테일 그리드)엔터키 이벤트
	$("#purchsrequstFixIsestatnFrm").find("#purchsRequstNmSch").keypress(function (e) {
	  	if (e.which == 13){
			searchRequestFixDetailGridorForm(false);
	    }
	});

}

/*############ 조회, 저장, 삭제 함수 ############*/
/* 조회 */

// 구매 요청 확정 관리 그리드 조회(마스터 그리드)
function searchPurchsRequestFixGridorForm(){
	var fixMasterListUrl = "<c:url value='/rsc/getPurchsRequestFixMList.lims'/>";

	//getGridDataForm(url, 폼이름, 그리드id);
	//getGridDataForm(fixMasterListUrl, "searchFrm", purchsRequestFixGrid_Master);
	getGridDataForm(fixMasterListUrl, "searchFrm", purchsRequestFixGrid_Master);
}

//
/*구매요청 목록 그리드 조회(디테일 그리드)
gbnData: 클릭, 조회 구분값
gbnData: true -> cellclick
gbnData: false -> 조회, 엔터 이벤트
*/
function searchRequestFixDetailGridorForm(gbnData){
	var fixDetailListUrl = "<c:url value='/rsc/getRequstIsestatnFixMList.lims'/>";
	var getIsestanData = AUIGrid.getGridData(purchsRequestFixIsestatn_Detail);
	var param = {purchsSeqno: $("#productPurchsSeqno").val()
		 				, purchsRequstNmSch: $("#purchsRequstNmSch").val()
						, requstDteStart: $("#requstDteStartDetail").val()
						, requstDteFinish: $("#requstDteFinishDetail").val()
		};

	if(!gbnData){
		for(var i=0; i<getIsestanData.length; i++){
			if(i == getIsestanData.length-1){
				if(!param.mySeqno){
					param.mySeqno = ""
				}
				param.mySeqno += "'"+getIsestanData[i].purchsRequstSeqno+":"+getIsestanData[i].prductSeqno+"'";

			} else {
				if(!param.mySeqno){
					param.mySeqno = ""
				}
				param.mySeqno += "'"+getIsestanData[i].purchsRequstSeqno+":"+getIsestanData[i].prductSeqno+"',";

			}
		}
	}

	//console.log("param 확인: ",param)

	getGridDataParam(fixDetailListUrl, param, purchsRequstIsestatn_Detail)
	//getGridDataForm(fixDetailListUrl, 'purchsrequstFixIsestatnFrm', purchsRequstIsestatn_Detail);
}

// 구매 확정 목록 그리드 조회(디테일 그리드)
function searchPurchsIsestatnFixDetailGridorForm(){
	var fixDetailListUrl = "<c:url value='/rsc/getPurchsIsestatnFixMList.lims'/>";

	//getGridDataForm(url, 폼이름, 그리드id);
	getGridDataForm(fixDetailListUrl, 'requstFixIsestatnFrm', purchsRequestFixIsestatn_Detail);
}

// 구매 요청 정보, 구매목록 저장 및 수정
function savePurchsRequestFixGridorForm(){
	var saveUrl = "<c:url value='/rsc/savePurchsRequestFixM.lims'/>";
	var purchsRequstIsestatnGridData = AUIGrid.getGridData(purchsRequstIsestatn_Detail);
	var purchsRequestFixGridData = AUIGrid.getGridData(purchsRequestFixIsestatn_Detail);

	var saveData = {"master":getFormParam("purchsRequestFixInfoFrm"), "detail":purchsRequestFixGridData, "productDetail":purchsRequstIsestatnGridData};
	ajaxJsonParam(saveUrl, saveData, function (data) {
		if(data == 0 ){
			alert('저장에 실패하였습니다.');
		}  else {

			alert('저장 되었습니다.');
			setClear(); // 초기화 함수 호출
			searchPurchsRequestFixGridorForm(); // 그리드 초기화
		}
	});
}

// 삭제
function deleteGrid(){
	var deleteUrl = "<c:url value='/rsc/delRequestFixM.lims'/>";
	var deleteData = {"master":getFormParam("purchsRequestFixInfoFrm"), "detail":getFormParam("requstFixIsestatnFrm")};

	ajaxJsonParam(deleteUrl, deleteData, function (data) {
		if(data == 0 ){
			alert('삭제에 실패하였습니다.')
		} else if(data == 0){
			alert('삭제할 항목이 없습니다.')
		} else {

			alert('삭제되었습니다.')
			setClear(); // 초기화 함수 호출
			searchPurchsRequestFixGridorForm(); // 그리드 초기화
		}
	});
}


/*############ 기타이벤트 함수 ############*/
// 팝업 이벤트
function popUpEvent(){
	dialogUser("rqesterBtn", "", "PurchsRequesDialog", function(item){
		$('#purchsrNm').val(item.userNm);
		$('#purchsrId').val(item.userId);
		$('#purchsDeptCode').val(item.deptCode);
	});
}

//총 합계 계산
function totalPrice(){
	var totSum = 0;
	var gridData = AUIGrid.getGridData(purchsRequestFixIsestatn_Detail); // 총 합계를 위한 그리드 데이터가져오기

	for(var i=0; i<gridData.length; i++){
		//console.log("확인: "+Number(gridData[i].price))
		if(gridData[i].price){
			totSum += Number(gridData[i].price) // 총 합계 계산
		}
	}
	$('#totAmount').val(totSum); // 구매 요청 확정 정보 합계 채워주기
	$('#commaTotAmount').val(thousandSeparatorCommas(totSum))

}

//버튼 보이기 숨기기
function btnHideShow(item){
	if(item == 'RS05000003'){
		$('#btn_purchs').show();
		$('#btn_save').show();
		$('#btn_delete').show();
		//$('#btn_save_RequstIsestatn').show();
	}else{
		$('#btn_purchs').hide();
		$('#btn_save').hide();
		$('#btn_delete').hide();
		//$('#btn_save_RequstIsestatn').hide();
	}
}

// 초기화 함수
function setClear(){
	AUIGrid.clearGridData(purchsRequstIsestatn_Detail);
	AUIGrid.clearGridData(purchsRequestFixIsestatn_Detail);

	$('#gbnCrud').val('C'); // flag : create 변경

	// 폼 초기화
	$('#purchsRequestFixInfoFrm')[0].reset();
	$('#requstFixIsestatnFrm')[0].reset();
	$('#purchsrequstFixIsestatnFrm')[0].reset();
	datePickerCalendar(["purchsDte"], true, ["DD",0]);
	datePickerCalendar(["requstDteStart","requstDteFinish"], true, ["DD",-90], ["DD",0]);
	datePickerCalendar(["requstDteStartDetail","requstDteFinishDetail"], true, ["DD",-90], ["DD",0]);
	$('#btn_purchs').show();
	$('#btn_save').show();
	$('#btn_delete').show();

	$('#requstNum').val('');
	$("#totAmount").val('');
	$('#rgntProgrsSittnCode').val(''); // 마스터 그리드 진행상황 코드 값 할당
	$('#detailRgntProgrsSittnCode').val(''); // 디테일 그리드 진행상황 코드 값 할당
	$('#productPurchsSeqno').val(''); // 구매 요청 목록 조회 조건 값
	$("#purchsrId").val('${UserMVo.userId}');
	$("#purchsDeptCode").val('${UserMVo.deptCode}');

}

// 저장 벨리데이션 체크
function saveValidation(code,btn){
	var saveRowCount = AUIGrid.getRowCount(purchsRequestFixIsestatn_Detail);
	// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
	var requstFixIsestatnGridData = AUIGrid.getGridData(purchsRequestFixIsestatn_Detail);
	var item;
	var invalid = false;
	var invalidRowIndex = -1;
	var colIndex;
	var regexp = /^[0-9]*$/
	var count = 0; // 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승

	// 구매 요청 확정 정보 폼 필수 정보 체크
	$('#purchsRequestFixInfoFrm').find('input').each(function(){
		var nm = $(this).attr("name");

		if( nm == "purchsNm" ){ // 필수 항목 체크 (구매명)
		    if(!$(this).prop('required')){
	    		if($(this).val() == '') {
	    			count ++;
	    			return;
		    	}
		    }
    	}
	});

	if(btn == 'btn_purchs'){
		for(var i=0, len=requstFixIsestatnGridData.length; i<len; i++) {
			item = requstFixIsestatnGridData[i];

			if(typeof item["purchsQtt"] == "undefined" || String(item["purchsQtt"]).trim() == "" || item["purchsQtt"] == null){ // 데이터 체크
				invalidRowIndex = i;
				invalid = true;
				colIndex = AUIGrid.getColumnIndexByDataField(purchsRequestFixIsestatn_Detail, "purchsQtt");
			}
		}
	}

	// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
	if(count > 0) {
		alert('필수 사항을 모두 입력해 주십시오');
		return;
	} else if(requstFixIsestatnGridData.length == 0){
		alert('구매 목록을 작성해주세요.');
	} else {
		if(invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			alert("칼럼의 값은 필수 칼럼이니 반드시 입력해야 합니다.");
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(purchsRequestFixIsestatn_Detail, invalidRowIndex, colIndex);
		} else {
			$('#rgntProgrsSittnCode').val(code) // 마스터 그리드 진행상황 코드 값 할당
			//$('#detailRgntProgrsSittnCode').val(code) // 디테일 그리드 진행상황 코드 값 할당

			// 실질적인 저장 로직 처리
			savePurchsRequestFixGridorForm();

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

			if(target == purchsRequestFixIsestatn_Detail){
				checkedItems[i].item.gridCrud = "C"
			}

			if(target == purchsRequstIsestatn_Detail && checkedItems[i].item.gridCrud != "C"){
				checkedItems[i].item.gridCrud = "D"
			}

			if(target == purchsRequstIsestatn_Detail && checkedItems[i].item.gridCrud == "C"){
				checkedItems[i].item.gridCrud = ""
			}

			AUIGrid.addRow(target, checkedItems[i].item, "last");
		}
	}
}

//천단위로 콤마 찍는 함수
function thousandSeparatorCommas ( number ){
	 var string = "" + number;

	 string = string.replace( /[^-+\.\d]/g, "" )  // ±기호와 소수점, 숫자들만 남기고 전부 지우기.

	 var regExp = /^([-+]?\d+)(\d{3})(\.\d+)?/;  // 필요한 정규식.

	 while ( regExp.test( string ) ) string = string.replace( regExp, "$1" + "," + "$2" + "$3" );  // 쉼표 삽입.

	 return string;
}


</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>