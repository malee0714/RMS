<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000885}</h2>  <!-- 출고 목록-->
			<div class="btnWrap">
				<button id="btnPopUp" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!--제품 등록-->
				<button id="btnRemoveRow" class="delete"><img src="/assets/image/minusBtn.png"></button> <!--행삭제-->
				<button id="btnSave" class="save">${msg.C100000884}</button> <!--출고-->
			</div>

			<form action="javascript:;" id="searchFrm" name="searchFrm">
				<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col> 
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:65%"></col>
					
								
				</colgroup>
					<tr>
						<th>${msg.C100000336}</th> <!--바코드-->
						<td colspan =7><input type="text" id="brcd" name="brcd"  class="wd100p schFunc" maxlength = "50">
						<input type="hidden" id="brcdChk" name="brcdChk" list="brcdChk"></td>
					</tr>
				</table>
			</form>
			</div>
			<div class="mgT15">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="releaseMGrid" style="width:100%; height:550px; margin:0 auto;"></div>
			</div>
	</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var releaseMGrid = 'releaseMGrid';
var searchFrm = 'searchFrm';
var lang = ${msg}; // 기본언어
/*******OnLoad*********/
$(function() {

	setCombo();

	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGrid();

	// 버튼 이벤트
	setButtonEvent();
	
	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setreleaseMGridEvent();

	// 그리드 리사이즈
	gridResize([releaseMGrid]);

}); // OnLoad 끝;
//팝업 이벤트
popUpEvent();

function setCombo(){

}
// 그리드 생성
function setPurchsRequestGrid(){
	
	//그리드 레이아웃 정의
	var releaseMCol = [];
	auigridCol(releaseMCol);
	var Pros = {
		editable : false
	};
	//컬럼 셋팅
	//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
	//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함

	// 출고 그리드
	releaseMCol.addColumnCustom("custlabSeqno","분석실 명",null,true,false);					// 분석실명
	releaseMCol.addColumnCustom("brcd","${msg.C100000336}",null,false,false);					// 바코드
	releaseMCol.addColumnCustom("prductClCode","${msg.C100000807}",null,true,false);			//제품 구분
	releaseMCol.addColumnCustom("prductNm","${msg.C100000809}",null,true,false);				//제품명
	releaseMCol.addColumnCustom("packngSttus","${msg.C100000393}",null,false,false);				//보관 상태
	releaseMCol.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true,false);			//현재 재고량
	releaseMCol.addColumnCustom("wrhsdlvrQy","${msg.C100000886}",null,true,false);				//출고 수량
	releaseMCol.addColumnCustom("prductPrpos","${msg.C100000621}",null,true,false);				//용도
	releaseMCol.addColumnCustom("cpcty","${msg.C100000622}",null,true,false);					//용량
	releaseMCol.addColumnCustom("validDate","${msg.C100000642}",null,true,false); 				//유효기간
	releaseMCol.addColumnCustom("rm","${msg.C100000425}",null,true,true);						//비고
	releaseMCol.addColumnCustom("rgntProgrsSittnCode","",null,false,false);						//
	releaseMCol.addColumnCustom("wrhsdlvrSeCode","",null,false,false);							//
	releaseMCol.addColumnCustom("wrhsdlvrSeBeforeCode","",null,false,false);					//
	releaseMCol.addColumnCustom("validTmlmtMthdCode","",null,false,false);						//
	releaseMCol.addColumnCustom("unsealAfterTmlmt","",null,false,false);						//
	releaseMCol.addColumnCustom("cycleCode","",null,false,false);								//
	releaseMCol.addColumnCustom("bplcCode","",null,false,false);								//
	releaseMCol.addColumnCustom("validTmlmtTrgetAt","",null,false,false);								//	
	custlabSeqnoArray=getGridComboList('/rsc/getCustlabCombo.lims',null,true);
	releaseMCol.dropDownListRenderer(["custlabSeqno"], custlabSeqnoArray, true, null);
	prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS01"}, true);

	releaseMCol.dropDownListRenderer(["prductClCode"], prductClArray, true, null);
	// 그리드 생성
	releaseMGrid = createAUIGrid(releaseMCol, releaseMGrid,Pros);


};

// 그리드 이벤트
function setreleaseMGridEvent(){
	// 각자 필요한 이벤트 구현
	AUIGrid.clearGridData(releaseMGrid);
	
	//AUIGrid.setGridData(checkMGrid_Detail, item)
	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(releaseMGrid, "ready", function(event) {
		gridColResize(releaseMGrid, "2");
	});
}

// 버튼 이벤트
function setButtonEvent(){

	$(".schFunc").keypress(function(e){
		if (e.which == 13){
		var bacode = $("#brcd").val();
		if(bacode){
			releasebrcd();
	  		}else {
	  			alert('${msg.C100000340}')	//바코드를 입력해주세요.
	  		}
		}
	})

	// 행삭제 버튼 클릭 이벤트
	$('#btnRemoveRow').click(function(){
		AUIGrid.removeRow(releaseMGrid, "selectedIndex"); // 행 삭제
	});
	
	// 저장(출고) 버튼 클릭 이벤트
	$("#btnSave").click(function(){
		if(AUIGrid.getGridData(releaseMGrid).length !=0)
		saveReleaseGrid();
	});
};


/*############ 조회, 저장, 삭제 함수 ############*/

/* 조회 */
function releasebrcd(){
	var getBacodeUrl = "<c:url value='/rsc/getBacode.lims'/>";
	var brcdChk = [];

	for(var i=0;i<AUIGrid.getGridData(releaseMGrid).length;i++){
		brcdChk[i]=AUIGrid.getGridData(releaseMGrid)[i].brcd
	}
	$("#brcdChk").val(brcdChk);
	 ajaxJsonForm(getBacodeUrl, 'searchFrm', function (data) {

		 if(data != null && data !=""){  // 데이터 유무 체크
			for(var i=0; i<data.length;i++){

		 if(data[i].flog==100){
				warn("${msg.C100000644}")//유효기간이 짧은 제품이 남았습니다.
		 }else if(data[i].wrhsdlvrSeCode=="RS08000003"){
				warn("${msg.C100000934}")//폐기처리된 바코드 입니다. 
		 }else if(data[i].wrhsdlvrSeCode=="RS08000002"){
				warn("${msg.C100000991}")//출고처리된 바코드입니다.
		 }
			else{

				addRow(data[i]); // 행 추가 이벤트 호출
			}
		}
		}
		else{
			warn('${msg.C100000826}'); //존재하지 않는 바코드입니다. \n바코드를 확인해주세요.
		}
	
	 });
	}
	
// 행 추가
function addRow(data){
	var item = new Object();
	var date = getFormatDate(); // 오늘 날짜 받아오기
	
	//특수 문자 제거
	var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;
	var validDte; // 유효일자
	var today = date.replace(regExp, ''); // 오늘 날짜
	var invalid = false;
	
	// 바코드 중복값 체크를 위한 그리드 데이터 담기
	var releaseMGridData = AUIGrid.getGridData(releaseMGrid);
	
	
		// 유효일자 널값 체크
		if(data.validDte){ 
			acptncDte =data.validDte.replace(regExp, ''); // 유효일자
		}else {
			acptncDte = parseInt(today)+1;
		}
		// 바코드 중복검사
		if(releaseMGridData.length > 0){
			for(var i=0, len=releaseMGridData.length; i<len; i++) {
				if(releaseMGridData[i].brcd ==data.brcd && releaseMGridData[i].bplcCode==data.bplcCode){
					invalid = true;
					
				}
			}
		}
		
		if(invalid){ // 바코드 중복 체크
			warn('${msg.C100000676}')//이미 추가한 바코드입니다. 바코드를 확인해주세요.
		}else if(parseInt(today)>acptncDte&&data.validTmlmtTrgetAt=='Y'){ // 유효일자 체크
			warn("${msg.C100000653}"); //유효일자가 지난 제품입니다.
		//자동 폐기하는지?
		}else {
			item.custlabSeqno = data.custlabSeqno  // 분석실
			item.brcd =data.brcd // 바코드
			item.purchsNm =data.purchsNm// 입고명
			item.prductClCode =data.prductClCode// 제품 구분
			item.prductClNm =data.prductClNm// 제품 분류명
			item.prductNm =data.prductNm // 제품명
			item.prductPrpos =data.prductPrpos // 용도
			item.packngSttus =data.packngSttus// 보관 상태
			item.wrhsdlvrQy = "1" // 출고 수량
			item.cpcty =data.cpcty // 용기량
			item.nowInvntryQy =data.nowInvntryQy // 현재 재고량
			item.validDate =data.validDte
			if(data.validDte==null){
				item.validDate =data.validDate // 유효일자
			}
			item.validDte =data.validDte // 유효일자
			item.acptncComptDte =data.acptncComptDte // 검수 완료 일자
			item.purchsSeqno =data.purchsSeqno
			item.purchsRequstSeqno =data.purchsRequstSeqno
			item.prductSeqno =data.prductSeqno
			item.wrhsdlvrSeCode = "RS08000002" // 출고 코드
			item.wrhsdlvrSeBeforeCode =data.wrhsdlvrSeCode
			item.rm =data.rm
			item.useQySeCode =data.useQySeCode;
			item.useQySeNm =data.useQySeNm;
			item.validTmlmtMthdCode =data.validTmlmtMthdCode;
			item.unsealAfterTmlmt =data.unsealAfterTmlmt;
			item.cycleCode =data.cycleCode;
			item.bplcCode =data.bplcCode;
			item.validTmlmtTrgetAt = data.validTmlmtTrgetAt;
			AUIGrid.addRow(releaseMGrid, item, "last");
		}
	$("#brcd").val("");
	$("#brcd").focus();
	return;
}

/* 저장(출고) */
function saveReleaseGrid(){
	var saveUrl = "<c:url value='/rsc/updateBrcd.lims'/>";
	AUIGrid.setSorting(releaseMGrid,{dataField:"validDte",sortType:1});
	var getGridData = AUIGrid.getGridData(releaseMGrid);

	if(getGridData != null){
		customAjax({url:saveUrl,data:getGridData,showLoading:true,elementIds:["btnSave"],successFunc :function(data) {
			if (data == 0){
				err("${msg.C100000889}");//출고에 실패하였습니다.
			} else {
				success("${msg.C100000888}");//출고되었습니다.
				// 그리드 초기화
				setClear();
			}
		 }
		});
	}
}

/*############ 기타이벤트 함수 ############*/

// 초기화 함수
function setClear(){
	AUIGrid.clearGridData(releaseMGrid);
}

//팝업 이벤트
function popUpEvent(){
		dialogRelease("btnPopUp", "","releaseDialog", releaseMGrid,function(item){
			$("#prductClNm").val(item.prductClNm);
			$("#prductClSeqno").val(item.prductClSeqno);
		});
}



</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>