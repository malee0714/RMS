<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000690}</h2> <!-- 입고 목록 -->
		<div class="btnWrap">
			<button id="btnPrint" class="print" hidden>${msg.C100000339}</button> <!-- 바코드 출력 -->
			<button id="searchBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
			<!-- Main content -->
			<form id="searchFrm" name="searchFrm" onsubmit="return false" >
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
						<col style="width:10%"></col>
						<col style="width:15%"></col>
					</colgroup>
						<tr><th>분석실 명</th> <!-- 사업 장 -->
						<td>
							<select name="custlabSeqno" >
								<option value=''>${msg.C100000480}</option> <!-- 선택 -->
							</select>
						</td> <!--  묶어서 숨김처리-->
						<th>${msg.C100000811}</th> <!-- 분류 C000001632 -->
						<td>
							<select id="prductClCodeSch" name="prductClCodeSch" >
								<option value=''>${msg.C100000480}</option> <!-- 선택 -->
							</select>
						</td>
						<th>품명</th> <!-- 품명   -->
						<td><input type="text" id="prductNmSch" name="prductNmSch" class="schClass"></td>
						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td style="text-align:left;">
							<label><input type="radio" id="use_a" name="useAtSch" value="" >${msg.C100000779}</label> <!-- 전체 -->
							<label><input type="radio" id="use_b" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
							<label><input type="radio" id="use_c" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
						</td>
					</tr>
					
					<tr>
						<th class="necessary">${msg.C100000692}</th>  <!-- 입고일자 -->
						<td style="text-align: left;">
							<input type="text"id="wrhsdlvrBeginDte"name="wrhsdlvrBeginDte"class="dateChk wd6p schClass"style="min-width:6em;"required>~
							<input type="text"id="wrhsdlvrEndDte"name="wrhsdlvrEndDte"class="dateChk wd6p schClass"style="min-width:6em; margin-left:3px;"required>
						</td>
						<td colspan="6"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
					</tr>

				</table>
			</form>
		</div>
	<div class="subCon2">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="wrhousngMGrid"></div>
	</div>
	<div class="subCon1 mgT20">
		<h2><i class="fi-rr-apps"></i>${msg.C100000691}</h2><!-- 입고 상세 정보   -->
		<div class="btnWrap">
			<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="wrhousngFrm" name="wrhousngFrm" onsubmit="return false">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1 mgB10">
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
					<th class="necessary">분석실 명</th> <!-- 사업 장  -->
				<td>
				 	<select id="custlabSeqno" name="custlabSeqno">
						<option value=''>${msg.C100000480}</option> <!-- 선택 -->
					</select>
				</td>
				<th class="necessary">${msg.C100000811}</th> <!-- 분류  -->
					<td>
						<select id="prductClCode" name="prductClCode" required>
							<option>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					<th class="necessary">품명</th> <!--  품명	 -->
					<td colspan="3">
					<input type="hidden" id="prductSeqno" name="prductSeqno" required>
					<select id="prductNm" name="prductNm" style="width: 100%;">
						<option value=''>${msg.C100000480}</option>
					</select>
				</tr>
				<tr>
					<th>${msg.C100000647}</th> <!-- 유효기한대상여부 -->
					<td>
						<input  type="hidden" id="validTmlmtTrgetAt" name="validTmlmtTrgetAt" readonly>
						<label id="validTmlmtTrget" name="validTmlmtTrget"></label>
						<!-- <label><input type="radio" id="validTmlmtTrget_n" name="validTmlmtTrgetAt" value="N" >${msg.C000000064}</label> 사용안함 -->
					</td>
					<th id="thValidDte">${msg.C100000643}</th> <!-- 유효기간 방식 -->
					<td style="text-align: left;">
					<input type="hidden" id="validTmlmtMthdCode" name="validTmlmtMthdCode" >
					<input type="hidden" id="unsealAfterTmlmt" name="unsealAfterTmlmt" >
					<input type="hidden" id="cycleCode" name="cycleCode" >
					<input type="text" id="validDate" name="validDate"  readonly>

					</td>
					<th class="necessary">${msg.C100000776}</th> <!--적정재고-->
					<td>
						<input type="text" id="proprtInvntryQy" name="proprtInvntryQy" value="0" maxlength = "10" class="comma" required>
					</td>
					<th class="necessary">${msg.C100000957}</th> <!--현재고-->
						<td>
							<input type="text" id="nowInvntryQy" name="nowInvntryQy" value ="0" maxlength = "10" class="comma" required>
						</td>

				</tr>
				<tr>
					<th class="necessary">${msg.C100000693}</th> <!--입고량-->
					<td>
						<input type="text" id="wrhsdlvrQy" name="wrhsdlvrQy" maxlength = "3" class="numChk" required>
					</td>
					<th class="necessary">${msg.C100000692}</th> <!--입고일자-->
					<td>
						<input type="text" id="wrhsdlvrDte" name="wrhsdlvrDte" class="dateChk" required>
					</td>
					<th class="necessary">${msg.C100000694}</th> <!-- 입고자	 -->
						<td>
							<input type="text" id="wrhsdlvrmanNm" name="wrhsdlvrmanNm" value="${UserMVo.userNm}" style="width:23%" readonly required>
							<input type="hidden" id="wrhsdlvrmanId" name="wrhsdlvrmanId" value="${UserMVo.userId}">
							<button id ="btnPopUp" type="button" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
							<button type="button" id = "btnPopupReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
						</td>
			</tr>
				<tr>
					<th>${msg.C100000425}</th> <!-- 비고 -->
					<td colspan="7"><textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength = "4000"></textarea></td>
				</tr>

				<input type="hidden" id="wrhsdlvrSeCode" name="wrhsdlvrSeCode" value="RS08000001">
				<input type="hidden" id="prductWrhsdlvrSeqno" name="prductWrhsdlvrSeqno">
			</table>
       	</form>
	</div>
	<div class="subCon1 mgT15">
		<div id="brcdDiv1" >
			<h3 class="mgB5">${msg.C100000337}</h3><!-- 바코드 목록 -->
			<div class="btnWrap">
				<button id="btnAddRow" class="btn5" ><img src="/assets/image/plusBtn.png"></button>
				<button id="btnRemoveRow" class="delete"><img src="/assets/image/minusBtn.png"></button>
			</div>
		</div>
	</div>
	<div class="subCon2" >
		<div id="brcdDiv2" >
		<div id="brcdcordGrid" class="grid"  style="width : 100%"></div>
		</div>
	</div>

	<div class="subCon1 mgT15">
		<div id="brcdDiv3" >
			<h3 class="mgB5">시험항목 목록</h3><!-- 바코드 목록 -->
			<div class="btnWrap">
				<button id="btnAddexpriem" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
				<button id="btnDelexpriem" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
			</div>
		</div>
	</div>
	<div class="subCon2" >
		<div id="brcdDiv4" >
			<div id="expriemGrid" class="grid"  style="width : 100%"></div>
		</div>
	</div>
</div>
    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var wrhousngMGrid = 'wrhousngMGrid';
var brcdcordGrid = 'brcdcordGrid';
var expriemGrid='expriemGrid';
var wrhousngFrm = 'wrhousngFrm';
var searchFrm = 'searchFrm';
var lang = ${msg}; // 기본언어
var count =0;
/*******OnLoad*********/
$(function() {
	init();
	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setwrhousngMGrid();
	setbrcdcordGrid();
	setexpriemGrid();
	// 콤보박스 바인딩
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	// 팝업 이벤트
	popUpEvent();

	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setWareHousingMGridEvent();

	// 그리드 리사이즈
	gridResize([wrhousngMGrid,brcdcordGrid,expriemGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

}); // OnLoad 끝;

function init(){
	 datePickerCalendar(["wrhsdlvrDte"],true,["DD",0]);
	 datePickerCalendar(["purchsDte"], true,["DD",0]);
	 datePickerCalendar(["wrhsdlvrBeginDte", "wrhsdlvrEndDte"], true, ["YY",-1], ["DD",0]);
		$("#wrhsdlvrmanNm").val('${UserMVo.userNm}');
		$("#wrhsdlvrmanId").val('${UserMVo.userId}');
		
		if(!String.prototype.padStart) {
			String.prototype.padStart = function padStart(targetLength, padString) {
				if(this.length >= targetLength) {
					return String(this);
				} else {
					if(padString == null || padString == " ") {
						padString = " ";
					} else if(padString.length > 1) {
						padString = padString.substring(0,1);
					}
					targetLength = targetLength - this.length;
					var prefix = "";
					for(var i = 0; i < targetLength; i++) {
						prefix += padString;
					}
					return prefix + String(this);
				}
			};
		}
}
// 그리드 생성
function setwrhousngMGrid(){

	//그리드 레이아웃 정의
	var wrhousngMCol = [];
	auigridCol(wrhousngMCol);

	var wrhousngPros = {
		rowIdField : "prductWrhsdlvrSeqno",
		editable : false,
		showRowCheckColumn : true,
 	 	showRowAllCheckBox : true
	};
	var Pros = {
		editable : false,
		showRowCheckColumn : true,
		showRowAllCheckBox : true
	};
	var comma = {
			dataType : "numeric",
			formatString : "#,##0",
	};

	//컬럼 셋팅
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함


	// 검수목록 그리드
	wrhousngMCol.addColumnCustom("prductWrhsdlvrSeqno","",null,false,false);
	wrhousngMCol.addColumnCustom("bplcCode","${msg.C100000432}",null,true,false);			// 사업장명
	wrhousngMCol.addColumnCustom("custlabSeqno","분석실 명",null,true,false);			// 사업장명
	wrhousngMCol.addColumnCustom("prductClCode","${msg.C100000811}",null,true,false);	// 분류
	wrhousngMCol.addColumnCustom("prductNm","품명",null,true,false);				//품명
	wrhousngMCol.addColumnCustom("proprtInvntryQy","${msg.C100000776}",null,true,false,comma);	// 적정재고
	wrhousngMCol.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true,false,comma);		//현재고
	wrhousngMCol.addColumnCustom("wrhsdlvrQy","${msg.C100000693}",null,true,false,comma);			//입고량
	wrhousngMCol.addColumnCustom("wrhsdlvrDte","${msg.C100000692}",null,true,true); // 입고일자 - 기본값 오늘
	wrhousngMCol.addColumnCustom("wrhsdlvrmanNm","${msg.C100000694}",null,true,false);	//입고자 명
	wrhousngMCol.addColumnCustom("wrhsdlvrmanId","${msg.C100000694}",null,false,false);	// 입고자 ID
	wrhousngMCol.addColumnCustom("cstdyPlace","${msg.C100000399}",null,false,false);	//보관장소
	wrhousngMCol.addColumnCustom("packngSttus","${msg.C100000939}",null,false,false);	//보관상태
	wrhousngMCol.addColumnCustom("validTmlmtMthdCode", "${msg.C100000643}", "*", false,false)		//유효기간 방식
	wrhousngMCol.addColumnCustom("unsealAfterTmlmt", "${msg.C100000116}", "*", false,false)		//개봉후 기한
	wrhousngMCol.addColumnCustom("cycleCode", "${msg.C100000835}", "*", false,false);			//주기
	prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS01"}, true);
	wrhousngMCol.dropDownListRenderer(["prductClCode"], prductClArray, true, null);
	wrhousngMCol.calendarRenderer(["wrhsdlvrDte"]);
	bplcCodeArray=getGridComboList('/wrk/getBestComboList.lims',null,true);
	wrhousngMCol.dropDownListRenderer(["bplcCode"], bplcCodeArray, true, null);
	custlabSeqnoArray=getGridComboList('/rsc/getCustlabCombo.lims',null,true);
	wrhousngMCol.dropDownListRenderer(["custlabSeqno"], custlabSeqnoArray, true, null);
	// 그리드 생성
	wrhousngMGrid = createAUIGrid(wrhousngMCol,wrhousngMGrid,wrhousngPros);

	gridResize([wrhousngMGrid]);
};
function setbrcdcordGrid() {
    var brcdcordCol = [
	];
    auigridCol(brcdcordCol);
	var brcdPros={
 			showRowCheckColumn : true,
 	 		showRowAllCheckBox : true
 	};	
	
    brcdcordCol.addColumnCustom("brcd", "${msg.C100000336}", null, true, false); // 바코드
    brcdcordCol.addColumnCustom("validDte", "${msg.C100000641}", null, true, true); //유효일자
	brcdcordCol.addColumnCustom("wrhsdlvrSeNm", "${msg.C100000701}", null, true, false); //입출고 상태
	brcdcordCol.addColumnCustom("wrhsdlvrSeBeforeCode","", null, false, false);			//입출고 이전상태
    brcdcordCol.calendarRenderer(["validDte"]);
	brcdcordGrid = createAUIGrid(brcdcordCol, brcdcordGrid,brcdPros);
	gridResize([brcdcordGrid]);

}


function setexpriemGrid(){
	var expriemCol =[
			];
	auigridCol(expriemCol);
	var Pros = {
		editable : true,
		showRowCheckColumn : true,
		showRowAllCheckBox : true
	};

	expriemCol.addColumnCustom("expriemNm", "${msg.C100000560}", null, true, false); // 시험항목 명
	expriemCol.addColumnCustom("expiemSeqno", "${msg.C100000560}", null, false, false); // 시험항목 명
	expriemCol.addColumnCustom("dnstyValue", "농도 값", null, true, true); // 농도 값
	//prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS01"}, true);
	//expriemCol.dropDownListRenderer(["prductClCode"], prductClArray, true, null);
	expriemGrid = createAUIGrid(expriemCol, expriemGrid,Pros);

}
// 그리드 이벤트
function setWareHousingMGridEvent(){
	// 각자 필요한 이벤트 구현
	AUIGrid.clearGridData(wrhousngMGrid);


	//AUIGrid.setGridData(wareHousingMGrid, item)
	// ready는 화면에 필수로 구현 할 것

	AUIGrid.bind(wrhousngMGrid, "ready", function(event) {
		gridColResize(wrhousngMGrid, "2");
	});
	AUIGrid.bind(brcdcordGrid, "ready", function(event) {
		gridColResize(brcdcordGrid, "2");
	});
	AUIGrid.bind(brcdcordGrid, "cellEditBegin", function( event ) {
	   if($("#validTmlmtMthdCode").val()!='RS15000001'){ 
		   return false;
	   }
	});
	AUIGrid.bind(wrhousngMGrid, "cellDoubleClick", function(event) {
		count =0;
		$('#prductClCode option').prop('disabled',false);
		$('#custlabSeqno option').prop('disabled',false);

		var item = event.item;
		detailAutoSet({ item:event.item,targetFormArr:["wrhousngFrm"],successFunc : function(){
			var wrhsdlvrQy=$("#wrhsdlvrQy").val();
			$('#btnDelete').show();
			$("#prductClCode").change();
			$("#wrhsdlvrQy").val(wrhsdlvrQy);
			$("#wrhsdlvrSeCode").val("RS08000001");
			$("#wrhsdlvrQy").prop("readonly",true);
			$("#prductNm").prop("disabled", true)
			$('#prductClCode option').not(':selected').prop('disabled',true);
			$('#custlabSeqno option').not(':selected').prop('disabled',true);
		 }
		});
		customAjax({url:'/rsc/getbrcdList.lims',data:event.item,successFunc: function(datas){
				console.log(datas);
				AUIGrid.setGridData(brcdcordGrid, datas);
		}
		});
		customAjax({url:'/rsc/getexpriemList.lims',data:event.item,successFunc: function(datas){
				console.log(datas);
				AUIGrid.setGridData(expriemGrid, datas);
			}
		});

	});
	AUIGrid.bind(brcdcordGrid, "cellEditEndBefore", function(event) {
		var dayRegExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		if(dayRegExp.test(event.value)){
			return event.value;
		}else{
		return null;}
});

}

//장비바코드 출력
function barcodeList(datavar){
	var datas = [];
	var mrd =[];
	var dataLenth = datavar.length
 	var RdUrl1 = "" ;
	var RdUrl2 = "" ;
	var RdUrl3 = "" ;
	var param = {
		printngSeCode : 'SY15000001'
	};

	customAjax({
		"url": "/com/printCours.lims",
		"data": param,
		"successFunc": function(data) {
			if(data.length >= 1) {
				for(var j = 0 ; j< data.length;j++){
				if(data[j].printngOrginlFileNm =="ReagentLabel.mrd")
				RdUrl1 = data[j].printngCours; 
				else if(data[j].printngOrginlFileNm =="ExpandLabel.mrd")
				RdUrl2 = data[j].printngCours; 
				else if(data[j].printngOrginlFileNm =="Reagentld.mrd")
				RdUrl3 = data[j].printngCours; 
				}
				if(dataLenth == 0) {
					alert("${msg.C100000495}")  /* 선택된 장비가 없습니다. */
					return;
				}
				for(var i = 0 ; i< dataLenth;i++){
					if(datavar[i].prductClCode == ("RS01000003")){  // 소모품
						datas.push(datavar[i].prductWrhsdlvrBrcdSeqno);
						mrd.push(RdUrl2);
					}else{  // 시약
						datas.push(datavar[i].prductWrhsdlvrBrcdSeqno);
						mrd.push(RdUrl1);
					}
					if(datavar[i].lblDcOutptAt =='Y'){  // 라벨 설명 뒷면에 출력
						datas.push(datavar[i].prductWrhsdlvrBrcdSeqno);
						mrd.push(RdUrl3);
					}
				}

				html5Viewer(mrd,datas);
			}else {
				alert("에러가 발생했습니다. 관리자에게 문의해 주십시오.");
				return;
			}
		}
	});
}

//바코드 출력 확인 함수
function openBarcode(data){
		
	if(data == 0){
		alert("${msg.C100000494}") /* 선택된 입고 목록이 없습니다. */
		return false;
	}

	var bacdoeData = data
	var result = confirm("${msg.C100000341}");
	console.log("openBarcode : " , data);
	if(bacdoeData && result){
		barcodeList(data);
	}
}

//콤보박스 바인딩
 function setCombo(){
	// 시약 진행상황 바인딩
	ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
//	ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{ "bestInspctInsttAt" : "Y" , isRdmsIp : true },true,null,"${UserMVo.bestInspctInsttCode}").then(function(){
// 	$("#bplcCode").val('${UserMVo.bestInspctInsttCode}');
// 	$('#bplcCode option').not(':selected').prop('disabled', ( '${UserMVo.authorSeCode}'!= "SY09000001" ));
//	});
	
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCodeSch",{"upperCmmnCode" :  "RS01"}, true);  // 제품 분류
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCode",{"upperCmmnCode" :  "RS01"}, true);  // 제품 분류
	ajaxSelect2Box({
		ajaxUrl : '/rsc/getprductSeqno.lims'
		,elementId : 'prductNm'
	});

}

// 버튼 이벤트
function setButtonEvent(){
	$("#btnNew").click(function(){
		reset();
	})

	$("#searchBtn").click(function(){
		setClear();
		searchwrhousngMGrid();
	})
	$("#btnDelete").click(function(){
		if(confirm("${msg.C100000461}"))
			deletWrhousng();
	})
	$("#btnSave").click(function(){

		if ($("#validTmlmtMthdCode").val()=="RS15000001" && $("#validTmlmtTrgetAt").val() =='Y' ){
			var isValid = AUIGrid.validateGridData(brcdcordGrid, "validDte");
			if(!isValid) {
   			warn("${msg.C100001121}");  /* 유효일자 값을 입력해야 합니다. */
			   return false;
  			}
		}
		if($("#prductClCode").val()=='RS01000001'|| $("#prductClCode").val() =='RS01000003') {
			var isValue = AUIGrid.validateGridData(expriemGrid,"dnstyValue");
			if(!isValue){
				warn("시험항목의 농도값을 입력해야 합니다.");  /* 시험항목의 농도값을 입력해야 합니다. */
				return false;
			}
		}

		if ($("#validTmlmtMthdCode").val()=="RS15000002" && $("#validTmlmtTrgetAt").val() =='Y' ){
		if(!$("#unsealAfterTmlmt").val()||!$("#cycleCode").val()){
			alert('${msg.C100001210}');
			return false;
		}
		}
		unComma(["proprtInvntryQy","nowInvntryQy"]);
		if(!saveValidation ("wrhousngFrm")){
			return false;
		}
		if($("#validTmlmtTrgetAt").val()=='Y' && !$("#validTmlmtMthdCode").val()){
			alert('${msg.C100001210}');
			return false;
		}
		
		else{
			saveWrhousng();
		}

	})

	
$("#custlabSeqno").change(function(e){
	$("#prductClCode").val("");
	$("#prductClCode").change();
});

$("#prductClCode").change(function(e){
	if($("#custlabSeqno").val()){
	ajaxSelect2Box({
        ajaxUrl         : '/rsc/getprductSeqno.lims'
        ,elementId      : 'prductNm'
        ,ajaxParam      : {
			"custlabSeqno":
			$("#custlabSeqno").val(),
			"prductClCode":e.target.value
		}
		,defaultVal : $("#prductSeqno").val()
        ,asyncType : false
    });
	}
	else if ($("#prductClCode").val()){
		alert("분석실을 선택해 주세요."); //분석실을 선택해 주세요.
		$("#prductClCode").val("");
	}
	if($("#prductClCode").val() =='RS01000001' || $("#prductClCode").val() == 'RS01000003'){
		$("#brcdDiv3").css("display","inline-block");
		$("#brcdDiv4").css("display","inline-block");
	}else {
		$("#brcdDiv3").css("display","none");
		$("#brcdDiv4").css("display","none");
	}


});
$("#validTmlmtTrgetAt").change(function (e) {
	if($("#validTmlmtTrgetAt").val() == 'Y'){
		$("#validTmlmtTrget").text('대상');
	}else{
		$("#validTmlmtTrget").text('비대상');
	}

})
$("#wrhsdlvrQy").change(function(e){
	AUIGrid.clearGridData(brcdcordGrid);
	count= parseInt($("#wrhsdlvrQy").val());
	//for(var i=0;i<$("#wrhsdlvrQy").val();i++){
		ajaxJsonForm("/rsc/selectBrcd.lims","wrhousngFrm" ,function(data){
			for (var i =0 ; i < data.length;i++ ){ 
			var brcdNo = String(data[i].brcdNo);
			data[i].brcd+=brcdNo.padStart(3,"0")
			}
			if(data[data.length-1].brcdNo <=999){
			AUIGrid.addRow(brcdcordGrid, data, 'last');
			
			}else{
				warn("${msg.C100000944}");  //하루 최대 등록수를 넘었습니다.
			}
			
		});
	//}
});
$("#btnPopupReset").click(function(){
	$("#wrhsdlvrmanNm").val("");
	$("#wrhsdlvrmanId").val("");
	$('#prductNm').select2('open');
});

$('#prductNm').on('select2:open', function (e) {

	if(!$("#prductClCode").val()){
		if($("#prductClCode")[0].value == "" && $("#prductClCode")[0].required){
			alert($("#prductClCode").closest("td").prev()[0].innerText.replace("*","") + "를 선택해주세요."); //분류를 선택해주세요.
			$("#prductClCode").change();
        }
	}
	});

	$("#prductNm").change(function(e){
		count=0;
		if($("#prductNm").val() != null){
			$("#prductSeqno").val($("#prductNm").val());
			customAjax({url:'/rsc/getexpriemList.lims',data:{prductSeqno:e.target.selectedOptions[0].value},successFunc: function(datas){
					AUIGrid.clearGridData(expriemGrid);
					AUIGrid.setGridData(expriemGrid, datas);
					if($("#prductSeqno").val() !=''){
						if($("#prductClCode").val()=='RS01000001'|| $("#prductClCode").val() =='RS01000003'){
							$("#wrhsdlvrQy").val('1');
							$("#wrhsdlvrQy").prop("readonly",true);
							$('#btnAddRow').hide();
							$('#btnRemoveRow').hide();
							$("#wrhsdlvrQy").change();
						}
					}
				}
			});
		}
		if($("#prductClCode").val()=='RS01000001'|| $("#prductClCode").val() =='RS01000003') {
			$('#btnAddRow').hide();
			$('#btnRemoveRow').hide();
		}else{
			$('#btnAddRow').show();
			$('#btnRemoveRow').show();
		}

			$("#wrhsdlvrQy").val('');
			$("#wrhsdlvrQy").prop("readonly",false);
		unComma(["proprtInvntryQy","nowInvntryQy"]);
		 ajaxJsonForm("<c:url value='/rsc/getPrductdate.lims'/>", "wrhousngFrm", function(data) {

			 $("#prductSeqno").val(data.prductSeqno);
			 $("#validTmlmtTrgetAt").val(data.validTmlmtTrgetAt);
			 $("#validTmlmtTrgetAt").change();
			 $("#validTmlmtMthdCode").val(data.validTmlmtMthdCode);
			 $("#unsealAfterTmlmt").val(data.unsealAfterTmlmt);
			 $("#cycleCode").val(data.cycleCode);
			 $("#validDate").val(data.validDate);
			 if (data != "") {
			 $("#nowInvntryQy").val(new Intl.NumberFormat().format(data.nowInvntryQy));
		 }else
			 $("#nowInvntryQy").val(0);
			if(data !="")
			 $("#proprtInvntryQy").val(new Intl.NumberFormat().format(data.proprtInvntryQy));
			else
			 $("#proprtInvntryQy").val(0);
			 $("#validTmlmtMthdCode").change();
			 $("#cycleCode").change();
		 });
		AUIGrid.clearGridData(brcdcordGrid);
		if($("#prductSeqno").val()){
		$("#nowInvntryQy").prop("readonly",true);
		$("#proprtInvntryQy").prop("readonly",true);
		$("#validTmlmtTrgetAt").prop("readonly",true);
		$("#validDate").prop("readonly",true);
		}else{
		$('input').prop('readonly', false);
		$("#wrhsdlvrmanNm").prop("readonly",true);
		}
	});
	document.getElementById("btnPrint").addEventListener("click",function(e){
		var selectedItems = AUIGrid.getCheckedRowItemsAll(wrhousngMGrid);
		var data =[]
		for(var v in selectedItems) {
		data.push({prductSeqno:selectedItems[v].prductSeqno,prductWrhsdlvrSeqno:selectedItems[v].prductWrhsdlvrSeqno})
		}
		customAjax({"url" : "<c:url value='/rsc/getbrcdSeqno.lims'/>", "data" : selectedItems, "successFunc" : function (data) {
		
		var arrRow = [];
		for(var i = 0; i<data.length; i++){
			arrRow.push(data[i]);
		}
		openBarcode(arrRow);
		}});
	});

	document.getElementById("btnRemoveRow").addEventListener("click",function(e){
		var delcheck = AUIGrid.getCheckedRowItemsAll(brcdcordGrid);

		if(delcheck.length == 0) {
			alert("${msg.C100000467}");  /* 삭제할 데이터가 없습니다. */
			return;
		}

		for(var i=0; i<delcheck.length;  i++ ){
			$("#wrhsdlvrQy").val(parseInt($("#wrhsdlvrQy").val())-1);
			if(delcheck[i].wrhsdlvrSeCode !="RS08000001"&&delcheck[i].wrhsdlvrSeCode !=null){
				alert("${msg.C100001253}"); //입고 상태가 아닌 바코드를 삭제할 수 없습니다.
				return false ;
			}
		}
		AUIGrid.removeCheckedRows(brcdcordGrid);
		var params={};
		params = $("#wrhousngFrm").serializeObject();
		params.removedBrcdList = AUIGrid.getRemovedItems(brcdcordGrid);

		customAjax({url:"/rsc/deletbrcdrowlist.lims","data":params,successFunc:function (){
				searchwrhousngMGrid();
			}});
	});
	document.getElementById("btnAddRow").addEventListener("click",function(e){
		if($("#prductNm").val() == ''){
			alert("품명을 선택해주세요.");
		}else {
		if($("#wrhsdlvrQy").val()=='')$("	#wrhsdlvrQy").val(0);
		$("#wrhsdlvrQy").val(parseInt($("#wrhsdlvrQy").val())+1);
		ajaxJsonForm("/rsc/selectBrcd.lims","wrhousngFrm" ,function(data){
			var brcdNo = String(data[0].brcdNo+count);
			data[0].brcd+=brcdNo.padStart(3,"0")
			if(data[0].brcdNo <=999){
			AUIGrid.addRow(brcdcordGrid, data[0], 'last');
			count++;
			}else{
				warn("${msg.C100000944}"); //하루 최대 등록수를 넘었습니다.
			}
		});
		}
	});
	dialogAddWrhousngExpriemList("btnAddexpriem",'WrhousngM', 'wrhousngFrm', "expriemPop", "expriemGrid", function(item){
		var check = AUIGrid.getGridData(expriemGrid);
		if(check.length > 0){
			for(var i=0; i<check.length; i++){
				for(var j=0; j<item.length; j++){
					if(item[j].expriemSeqno === check[i].expriemSeqno){
						check[i].cmmnCode = "";
						warn("${msg.C100001164}") /*동일한 사용자가 등록되어 있습니다. */
						return false;
					}
				}
			}
		}
		//헤당 그리드에 데이터 입력
		AUIGrid.addRow(expriemGrid,item,"last"); // 최하단에 1행 추가
		AUIGrid.setSorting(expriemGrid,  { dataField : "expriemSeqno", sortType : 1 });
	},function(){

	},true);

	document.getElementById("btnDelexpriem").addEventListener("click",function(e){

		var selectedItems = AUIGrid.getCheckedRowItemsAll(expriemGrid);
		if(selectedItems.length == 0) {
			alert("${msg.C100000467}");  /* 삭제할 데이터가 없습니다. */
			return;
		}

		var tempArr = new Array();
		for(var i=0; i<selectedItems.length; i++){
			var rows = AUIGrid.getRowIndexesByValue(expriemGrid,'expriemSeqno',selectedItems[i].expriemSeqno)
			tempArr.push(rows);
		}

		//해당 그리드에서 선택된 인덱스를 삭제해준다.
		AUIGrid.removeRow(expriemGrid, tempArr);
		var delParam={"removedExpriemList" : AUIGrid.getRemovedItems(expriemGrid)} // 시험항목 그리드 삭제
		var param = Object.assign($("#wrhousngFrm").serializeObject(), delParam);
		if(delParam.removedExpriemList.length !=0){
			customAjax({url:'/rsc/deletexpriem.lims',data:param,showLoading:true,successFunc:function(data) {
					if (data == 0){
						err("${msg.C100000597}");//저장에 실패하였습니다.
					} else {
						success("${msg.C100000762}");//저장 되었습니다.
					}}});
		}
	});
}

/*############ 조회, 저장, 삭제 함수 ############*/
/* 조회 */

 // 입고 그리드 조회
function searchwrhousngMGrid(tager){
	
	if(!saveValidation('searchFrm')){ return false; }
	var getwrhousngUrl = "<c:url value='/rsc/getWrhousngList.lims'/>";
	getGridDataForm(getwrhousngUrl, 'searchFrm', wrhousngMGrid,function (){
		if(tager != null){
			AUIGrid.setSelectionByIndex(wrhousngMGrid,AUIGrid.rowIdToIndex(wrhousngMGrid,tager),0);
		}
	});

}
function saveWrhousng() {
    var params ={}
	params = $("#wrhousngFrm").serializeObject();
	params.removedBrcdList = AUIGrid.getRemovedItems(brcdcordGrid);
	params.addedBrcdList = AUIGrid.getAddedRowItems(brcdcordGrid);
	params.editedBrcdList = AUIGrid.getEditedRowItems(brcdcordGrid);
	params.addedExpriemList = AUIGrid.getAddedRowItems(expriemGrid);
	params.editedExpriemList = AUIGrid.getEditedRowItems(expriemGrid);

	customAjax({"url" : "<c:url value='/rsc/insWareBrcd.lims'/>", "data" : params, showLoading:true,elementIds:["btnSave"], "successFunc" : function (data) {
            if (data <= 0) {
                err("${msg.C100000597}");/* 저장에 실패하였습니다. */
            } else if (data == 99) {
                //바코드 수정
                customAjax({url:"/rsc/updbrcdlist.lims",data:params}).then(function(){

    				success("${msg.C100000762}");
    				searchwrhousngMGrid(params.prductWrhsdlvrSeqno);
					reset()

                });
            } else {
				//AUIGrid.setCellValue(brcdcordGrid,0,3,data);
                //바코드 생성
                        success("${msg.C100000762}");
                            var gridData = AUIGrid.getGridData(brcdcordGrid);
							var brcds = [];
                            for (var i = 0; i < gridData.length; i++) {
								brcds.push({prductWrhsdlvrBrcdSeqno:gridData[i].prductWrhsdlvrBrcdSeqno,prductClCode:$("#prductClCode").val()});
                            }
                           // openBarcode(brcds);
                            searchwrhousngMGrid(params.prductWrhsdlvrSeqno);
							reset()
                    }
			}	
        }
    );
}
function deletWrhousng(){
	var  griddata = AUIGrid.getGridData(brcdcordGrid);
	var fromdata = [$("#wrhousngFrm").serializeObject()];
	var gridParam = fromdata.concat(griddata);
	customAjax({"url" : "<c:url value='/rsc/deletBrcd.lims'/>", "data" : $("#wrhousngFrm").serializeObject(), "successFunc" : function (data) {
	if (data <= 0) {
        err("${msg.C100000597}");/* 저장에 실패하였습니다. */
    } else {
		        customAjax({url:"/rsc/deletbrcdlist.lims",data:gridParam});
		        customAjax({url:"<c:url value='/rsc/nowInvntrydelet.lims'/>",data:gridParam});
                success("${msg.C100000762}");
                searchwrhousngMGrid();
				reset();
            }
    }
	});
}

function reset(){
	// 폼 초기화
	$('#prductClCode option').not(':selected').prop('disabled',false);
	$('#custlabSeqno option').not(':selected').prop('disabled',false);
		$('#wrhousngFrm')[0].reset();
		//prductWrhsdlvrSeqno

		$("#wrhsdlvrSeCode").val("RS08000001");
		datePickerCalendar(["wrhsdlvrDte"],true,["DD",0]);
		datePickerCalendar(["purchsDte"], true,["DD",0]);
		$("#prductWrhsdlvrSeqno").val('');
		$("#prductClCode").change();
		$('input').prop('readonly', false);
		ajaxSelect2Box({
			ajaxUrl : '/rsc/getprductSeqno.lims'
			,elementId : 'prductNm'
		});
		$("#prductNm").prop("disabled", false);
		$("#wrhsdlvrmanNm").val('${UserMVo.userNm}');
		$("#wrhsdlvrmanId").val('${UserMVo.userId}');
		$("#wrhsdlvrmanNm").prop("readonly",true);
		$('#btnDelete').hide();
		$('#btnAddRow').show();
		$('#btnRemoveRow').show();
		AUIGrid.clearGridData(brcdcordGrid);
}

// 초기화 함수
function 	setClear(){
	AUIGrid.clearGridData(wrhousngMGrid);

}

//팝업 이벤트
function popUpEvent(){

	var obj = {
			bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
			authorSeCode : '${UserMVo.authorSeCode}'
	};

	dialogUser("btnPopUp",obj,"userDialog",function(item){
		$("#wrhsdlvrmanNm").val(item.userNm);
		$("#wrhsdlvrmanId").val(item.userId);
	}, null, null, null, 'Y');
}


// 엔테 이벤트 (검수 그리드 조회)
/* $("#searchFrm").find("#purchsNm").keypress(function (e) {
  	if (e.which == 13){
  		searchWareHousingMGrid();
    }
}); */
function doSearch(e){
	searchwrhousngMGrid();
}



</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
