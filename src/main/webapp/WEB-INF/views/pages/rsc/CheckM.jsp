<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>구매 요청 확정 목록</h2>
		<div class="btnWrap">
			<button type="button" id="searchBtn" class="search btn1">조회</button>
		</div>
		<form action="javascript:;" id="searchFrm" name="searchFrm">
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
						<select id ="rgntProgrsSittnCodeSch" name="rgntProgrsSittnCodeSch"  class="wd100p" style="min-width:10em;">
							<option value="" selected="selected">선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>부서</th>
					<td colspan="5"  style="text-align:left;">
						<select id ="requstDeptCodeSch" name="requstDeptCodeSch"  class="wd24p" style="min-width:10em;">
							<option value="" selected="selected">선택</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="checkMGrid_Master" style="width:100%; height:300px; margin:0 auto;"></div>
	</div>
	<div class="subCon1 mgT20">
		<h2>검수 목록</h2>
		<div class="btnWrap">
			<button type="button" id="btn_save" class="btn1">검수</button>
		</div>
		<form id="checkDetailMFrm">
			<input type="hidden" id="purchsSeqno" name="purchsSeqno" >
			<input type="hidden" id="rgntProgrsSittnCode" name="rgntProgrsSittnCode" >
		</form>
	</div>
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="checkMGrid_Detail" style="width:100%; height:300px; margin:0 auto;"></div>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var checkMGrid_Master = 'checkMGrid_Master';
var checkMGrid_Detail = 'checkMGrid_Detail';
var searchFrm = 'searchFrm';

/*******OnLoad*********/
$(function() {
	getAuth();//권한 체크
	// 검색 시작일, 종료일 (검색기간 디폴트 1분기)
	datePickerCalendar(["requstDteStart","requstDteFinish"], true, ["DD",-90], ["DD",0]);

	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGrid();
	
	// 콤보박스 바인딩
	setCombo();
	
	// 버튼 이벤트
	setButtonEvent();
	
	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGridEvent();

	// 그리드 리사이즈
	gridResize([checkMGrid_Master, checkMGrid_Detail]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

}); // OnLoad 끝;

// 그리드 생성
function setPurchsRequestGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
		//그리드 컬럼 담을 배열 정의
		checkMGrid_Master: [],
		checkMGrid_Detail: []
	}
	
	//컬럼 속성 정의
	var purchsRequestGridColPros = {
			dataType : "numeric",
			formatString : "#,##0"
	};
	
	var purchsToolPros = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '값을 입력 또는 선택하세요.'
		}
	}
	
	//컬럼 셋팅
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
	
	// 검수 그리드
	auigridCol(columnLayout.checkMGrid_Master);
	columnLayout.checkMGrid_Master.addColumnCustom("purchsDte","구매 일자",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("purchsNm","구매명",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("requstDeptNm","구매 부서",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("rqesterNm","구매자",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("requstNum","구매 건수",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("acptncComptDte","검수 완료 일자",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("rgntProgrsSittnNm","진행 상황",null,true,false);
	columnLayout.checkMGrid_Master.addColumnCustom("rm","구매 비고",null,true,false);
	
	
	// 검수목록 그리드
	auigridCol(columnLayout.checkMGrid_Detail);
	columnLayout.checkMGrid_Detail.addColumnCustom("purchsRequstNm","구매요청명",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("purchsNm","구매명",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("prductSeNm","제품 구분",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("prductClNm","제품 분류명",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("prductNm","제품명",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("prposNm","용도",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("cstdysttusNm","보관 상태",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("prductunitNm","제품 단위",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("purchsQtt","구매 수량",null,true,false, purchsRequestGridColPros);
	columnLayout.checkMGrid_Detail.addColumnCustom("untpc","단가",null,true,false, purchsRequestGridColPros);
	columnLayout.checkMGrid_Detail.addColumnCustom("qtt","남은 수량",null,true,false, purchsRequestGridColPros); // 구매수량 - 입고건수
	columnLayout.checkMGrid_Detail.addColumnCustom("acptncQtt","검수 수량",null,true,true,purchsToolPros); // 숫자만 에디트
	columnLayout.checkMGrid_Detail.addColumnCustom("wrhsdlvrQy","현재 재고량",null,true,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("cntnrQy","용기량",null,true,true,purchsToolPros);
	columnLayout.checkMGrid_Detail.addColumnCustom("validDte","유효 일자",null,true,false,purchsToolPros); // 날짜
	columnLayout.checkMGrid_Detail.addColumnCustom("acptncDte","검수 일자",null,true,false,purchsToolPros); // 날짜 - 기본값 오늘
	columnLayout.checkMGrid_Detail.addColumnCustom("acptncRm","검수 비고",null,true,true,purchsToolPros);
	columnLayout.checkMGrid_Detail.addColumnCustom("gridCrud","CRUD",null,false,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("rgntProgrsSittnCode","진행상황",null,false,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("wrhsdlvrSeCode","입출고",null,false,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("purchsDeptCode","부서코드",null,false,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("resetQtt","초기 남은 수량",null,false,false);
	columnLayout.checkMGrid_Detail.addColumnCustom("resetWrhs","초기 재고량",null,false,false);
	columnLayout.checkMGrid_Detail.calendarRenderer(["validDte"]);
	columnLayout.checkMGrid_Detail.calendarRenderer(["acptncDte"]);
	
	//그리드 속성 정의
	var purchsRequestGridPros = {
			
	};
	
	// 그리드 생성
	checkMGrid_Master = createAUIGrid(columnLayout.checkMGrid_Master, checkMGrid_Master);
	checkMGrid_Detail = createAUIGrid(columnLayout.checkMGrid_Detail, checkMGrid_Detail);
};

// 그리드 이벤트
function setPurchsRequestGridEvent(){
	// 각자 필요한 이벤트 구현
	AUIGrid.clearGridData(checkMGrid_Master);
	AUIGrid.clearGridData(checkMGrid_Detail);
	

	//AUIGrid.setGridData(checkMGrid_Detail, item)
	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(checkMGrid_Master, "ready", function(event) {
		gridColResize(checkMGrid_Master, "2");
	});
	AUIGrid.bind(checkMGrid_Detail, "ready", function(event) {
		gridColResize(checkMGrid_Detail, "2");
	});

	
	// 마스터 그리드(구매 요청 관리 그리드) 셀 클릭 이벤트
	AUIGrid.bind(checkMGrid_Master, 'cellClick', function(event){
		
		$('#purchsSeqno').val(event.item.purchsSeqno) // 구매목록 조회 조건 값
		$('#rgntProgrsSittnCode').val(event.item.rgntProgrsSittnCode) // 진행상황
		searchCheckDetailMGridorForm();
	});

	// 그리드 입고수량 수정 가능 여부 체크 (남은 수량이 없다면 입고수량 입력 x)
	AUIGrid.bind(checkMGrid_Detail, "cellEditBegin", function(event) { 

		if(event.dataField == "acptncQtt" || event.dataField == "cntnrQy" || event.dataField == "validDte"  || event.dataField == "acptncDte" || event.dataField == "acptncRm" ) {  
		  // 추가여부 확인 
		  var sQtt = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "qtt");
		  if(parseInt(sQtt) <= 0) { 
		        return false; 
		    } else { 
		        return true;  
		    } 
		} 
		return true; // 다른 필드들은 편집 허용
	});
	
	AUIGrid.bind(checkMGrid_Detail, "cellEditEnd", function(event){
		var myValue = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "gridCrud")
		var getPurchsQtt = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "purchsQtt") // 구매수량
		var getWrhsdlvrQy = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "wrhsdlvrQy") // 현재 재고량
		var getAcptncQtt = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "acptncQtt") // 검수 수량
		var getCntnrQy = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "cntnrQy") // 용기 수량
		var getQtt = AUIGrid.getCellValue(checkMGrid_Detail, event.rowIndex, "qtt") // 남은 수량
		var regexp = /^[0-9]*$/ // 숫자 정규식
		
		if(myValue != 0){
			item = { gridCrud : "U" };
   			AUIGrid.updateRow(checkMGrid_Detail, item, "selectedIndex");
		}

		if(!regexp.test(Number(event.item["wrhsdlvrQy"])) || !regexp.test(Number(event.item["acptncQtt"])) || !regexp.test(Number(event.item["cntnrQy"])) ){  // 입고수량
			alert('숫자를 입력해 주세요.');
			AUIGrid.setSelectionByIndex(checkMGrid_Detail, event.rowIndex, event.columnIndex);
			
			if(!regexp.test(Number(event.item["acptncQtt"]))){
				AUIGrid.restoreEditedRows(checkMGrid_Detail, "selectedIndex");
				//AUIGrid.setCellValue(checkMGrid_Detail, event.rowIndex, "acptncQtt", '');
			}
			
			if(!regexp.test(Number(event.item["cntnrQy"]))){
				AUIGrid.restoreEditedRows(checkMGrid_Detail, "selectedIndex");
			}

		}else{
			if(getAcptncQtt && event.dataField == "acptncQtt"){ // 검수 수량 벨리데이션 체크
				
				if( parseInt(getAcptncQtt) >= 0 ){
					
					if(parseInt(getQtt) - parseInt(getAcptncQtt) < 0){
						alert('검수수량은 남은수량을 초과할 수 없습니다. 검수수량을 확인해 주세요.');
						
						AUIGrid.restoreEditedRows(checkMGrid_Detail, "selectedIndex");
						AUIGrid.setSelectionByIndex(checkMGrid_Detail, event.rowIndex, event.columnIndex);
						
					}else {
						AUIGrid.setCellValue(checkMGrid_Detail, event.rowIndex, "rgntProgrsSittnCode", "RS05000005"); //진행코드 - 검수완료
						AUIGrid.setCellValue(checkMGrid_Detail, event.rowIndex, "wrhsdlvrSeCode", "RS08000001"); // 입고
					}

				}
			}
		}
	});
	
}

//콤보박스 바인딩
function setCombo(){
	var deptCode =  "${UserMVo.deptCode}" // 로그인 사용자 부서코드
	var param = {bestInspctInsttCode: "${UserMVo.bestInspctInsttCode}"} // 로그인 사용자 기관코드

	// 시약 진행상황 바인딩
	ajaxJsonComboBox('/rsc/getComboRgntProgrsSittnCodeList.lims','rgntProgrsSittnCodeSch',null,true,"", "RS05000004");

	// 부서 바인딩
	//ajaxJsonComboBox('/sys/getInspctCode.lims','requstDeptCodeSch',param,true,"", deptCode);
	ajaxJsonComboBox('/sys/getUpperComboListM.lims','requstDeptCodeSch',{"bestInspctInsttCode" : "${UserMVo.bestInspctInsttCode}"},true,null, "${UserMVo.deptCode}");
}

// 버튼 이벤트
function setButtonEvent(){
	
	// 마스터 그리드 조회
	$('#searchBtn').click(function(){
		setClear();
		searchCheckMGridorForm();
	});
	
	// 저장 벨리데이션 체크
	$("#btn_save").click(function(){
		
		saveValidation(); 
	});
}

// 디테일 그리드 조회 함수
function myGridDataForm(url, formId, divID){
	showLoader(divID);

	ajaxJsonForm(url, formId, function(data) {
		var detailLength;
		
		divID = typeof divID != "string" ? undefined : divID[0] == "#" ? divID : "#"+divID;
		AUIGrid.setGridData(divID, data);
		hideLoader(divID);
		
		detailLength = data.length;
		
		var ProgrsSittnCode = $('#rgntProgrsSittnCodeSch').val();
		
		if(detailLength == 0 && ProgrsSittnCode == 'RS05000004'){ // 데이터가 없을 시 마스터 그리드 조회
			searchCheckMGridorForm();	
		}
	});
}

//바코드 - 크로닉스 리포트 연동
function bacodeList(data){
	var paramStr = '';
	var dataLenth = data.bacodeList.length
	
	for (var i = 0; i < dataLenth; i++){

		if(i == dataLenth-1){
			paramStr += "'"+data.bacodeList[i]+"'";
		}else{
			paramStr += "'"+data.bacodeList[i]+"',";	
		}
		
	}
	html5Viewer(["/DHBacodeTest.mrd"], paramStr);
}

//바코드 출력 확인 함수
function openBacode(data){
	var bacdoeData = data.bacodeList
	var result = confirm("바코드를 출력하시겠습니까? \n[조회]-[시약/표준품 이력조회] 메뉴에서 재출력이 가능합니다.");
	if(bacdoeData && result){
		bacodeList(data);
	}
}

/*############ 조회, 저장, 삭제 함수 ############*/
/* 조회 */

// 검수 그리드 조회(마스터 그리드)
function searchCheckMGridorForm(){
	var checkMListUrl = "<c:url value='/rsc/getCheckMList.lims'/>";

	//getGridDataForm(url, 폼이름, 그리드id);
	//getGridDataForm(checkMListUrl, "searchFrm", checkMGrid_Master);
	getGridDataForm(checkMListUrl, "searchFrm", checkMGrid_Master);

	var ProgrsSittnCode = $('#rgntProgrsSittnCodeSch').val();
	
	if(ProgrsSittnCode == 'RS05000005'){
		$('#btn_save').hide();
	}else if(ProgrsSittnCode == 'RS05000004'){
		$('#btn_save').show();
	}
}


// 검수 내역 그리드 조회(디테일 그리드)
function searchCheckDetailMGridorForm(){
	var checkMDetailListUrl = "<c:url value='/rsc/getCheckDetailMList.lims'/>";
	
	//getGridDataForm(url, 폼이름, 그리드id);
	myGridDataForm(checkMDetailListUrl, 'checkDetailMFrm', checkMGrid_Detail);
}


function saveCheckDetailMGridorForm(){
	var saveCheckMDetailListUrl = "<c:url value='/rsc/saveCheckDetailMList.lims'/>";
	var getDetailGridRowItems = AUIGrid.getEditedRowItems(checkMGrid_Detail);
	if(getDetailGridRowItems != null){
		ajaxJsonParam(saveCheckMDetailListUrl, getDetailGridRowItems, function(data) {
			
			
			if (data.result == 0){
				alert("저장에 실패하였습니다.");
			} else {
				console.log(data);
				alert("성공적으로 저장되었습니다.");
				
				openBacode(data)

				if(data.checkResult == 1){
					setClear();
					searchCheckMGridorForm();
				} else {
					searchCheckDetailMGridorForm();
				}
				
			}
		});
	}
}

/*############ 기타이벤트 함수 ############*/

// 초기화 함수
function setClear(){
	AUIGrid.clearGridData(checkMGrid_Master);
	AUIGrid.clearGridData(checkMGrid_Detail);
	$("#rgntProgrsSittnCode").val('');
	$("#purchsSeqno").val('');	
}

// 저장 벨리데이션 체크
function saveValidation(){
	//var invalid = false;
	var dataChk = 0;
	var typeChk = false;
	var invalidRowIndex = -1;
	var colIndex;
	var getDetailGridData = AUIGrid.getEditedRowItems(checkMGrid_Detail);
	var chkGridData = AUIGrid.getGridData(checkMGrid_Detail);
	var item;
	
	for(var i=0, len=chkGridData.length; i<len; i++) {
		item = chkGridData[i];

		/* if(typeof item["wrhsdlvrQy"] == "undefined" || String(item["wrhsdlvrQy"]).trim() == "" || item["wrhsdlvrQy"] == null){ // 데이터 체크
			invalidRowIndex = i;
			invalid = true;
			colIndex = AUIGrid.getColumnIndexByDataField(checkMGrid_Detail, "wrhsdlvrQy");
			
		}else */ 
		if(typeof item["acptncQtt"] == "undefined" || String(item["acptncQtt"]).trim() == "" || item["acptncQtt"] == null ){
			invalidRowIndex = i;
			//invalid = true;
			dataChk += 1
			colIndex = AUIGrid.getColumnIndexByDataField(checkMGrid_Detail, "acptncQtt");
			
		} 
	}

	if(dataChk == chkGridData.length || getDetailGridData.length <= 0) {
		// 필수 칼럼의 값  예외 처리하기
		alert("저장할 데이터가 없습니다. 항목을 확인해주세요.");
		// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
		AUIGrid.setSelectionByIndex(checkMGrid_Detail, invalidRowIndex, colIndex);
	}else {
		// 실질적인 저장 로직 처리
		saveCheckDetailMGridorForm();
	}
	
}

// 엔테 이벤트 (검수 그리드 조회)
$("#searchFrm").find("#purchsNmSch").keypress(function (e) {
  	if (e.which == 13){
  		searchCheckMGridorForm();
    }
});

    
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>