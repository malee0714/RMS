<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000930}</h2>  <!--  폐기 목록 -->
		<div class="btnWrap">
			<button id="btnPopUp" class="btn5"><img src="/assets/image/plusBtn.png"></button>
			<button id="btnRemoveRow" class="delete"><img src="/assets/image/minusBtn.png"></button>
			<button id="btnSave" class="save">${msg.C100000929}</button>  <!-- 폐기  -->
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
					<th>${msg.C100000336}</th>  <!-- 바코드  -->
					<td colspan =7><input type="text" id="brcd" name="brcd" class="wd100p schFunc" maxlength = "50" ></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="dsuseMGrid" style="width:100%; height:550px; margin:0 auto;"></div>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
/*******전역변수*********/
var dsuseMGrid = 'dsuseMGrid';
var searchFrm = 'searchFrm';
var lang = ${msg}; // 기본언어
/*******OnLoad*********/
$(function() {

	getAuth(); //권한 체크
	setCombo();
	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setPurchsRequestGrid();

	// 버튼 이벤트
	setButtonEvent();
	
	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setdsuseMGridEvent();

	// 그리드 리사이즈
	gridResize([dsuseMGrid]);

	
}); // OnLoad 끝;
//팝업 이벤트
popUpEvent();
function setCombo(){

}
// 그리드 생성
function setPurchsRequestGrid(){
	
	//그리드 레이아웃 정의
	var dsuseMCol = [];
	auigridCol(dsuseMCol);
	var Pros = {
		editable : false
	};
	//컬럼 속성 정의
	var dsuseMGridColPros = {
			dataType : "numeric",
			formatString : "#,##0",
	};

	var disUseToolPros = {
			style : "my-require-style",
			headerTooltip : { // 헤더 툴팁 표시 일반 스트링
				show : true,
				tooltipHtml : '${msg.C100000114}' //값을 입력 또는 선택하세요.
			}
	};
	//컬럼 셋팅
	dsuseMCol.addColumnCustom("custlabSeqno","분석실 명",null,true,false);					// 분석실명
	dsuseMCol.addColumnCustom("brcd","${msg.C100000336}",null,true,false);					// 바코드
	dsuseMCol.addColumnCustom("prductClCode","${msg.C100000807}",null,true,false);			//제품 구분
	dsuseMCol.addColumnCustom("prductNm","${msg.C100000809}",null,true,false);				//제품명
	dsuseMCol.addColumnCustom("prductPrpos","${msg.C100000621}",null,true,false);			//용도
	dsuseMCol.addColumnCustom("packngSttus","${msg.C100000393}",null,false,false);			//보관 상태
	dsuseMCol.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true,false);			//현재 재고량
	dsuseMCol.addColumnCustom("wrhsdlvrQy","${msg.C100000932}",null,true,false);						//폐기 수량
	dsuseMCol.addColumnCustom("cpcty","${msg.C100000622}",null,true,false);					//용량
	dsuseMCol.addColumnCustom("validDate","${msg.C100000642}",null,true,false); 			// 유효기간
	dsuseMCol.addColumnCustom("rm","${msg.C100000425}",null,true,true);						//비고
	dsuseMCol.addColumnCustom("rgntProgrsSittnCode","",null,false,false);	
	dsuseMCol.addColumnCustom("wrhsdlvrSeCode","",null,false,false);
	dsuseMCol.addColumnCustom("wrhsdlvrSeBeforeCode","",null,false,false);
	dsuseMCol.addColumnCustom("bplcCode","",null,false,false);
	prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS01"}, true);
	dsuseMCol.dropDownListRenderer(["prductClCode"], prductClArray, true, null);
	custlabSeqnoArray=getGridComboList('/rsc/getCustlabCombo.lims',null,true);
	dsuseMCol.dropDownListRenderer(["custlabSeqno"], custlabSeqnoArray, true, null);

	// 그리드 생성
	dsuseMGrid = createAUIGrid(dsuseMCol, dsuseMGrid,Pros);
	
};

// 그리드 이벤트
function setdsuseMGridEvent(){
	// 각자 필요한 이벤트 구현
	AUIGrid.clearGridData(dsuseMGrid);

	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(dsuseMGrid, "ready", function(event) {
		gridColResize(dsuseMGrid, "2");
	});

	
	
	//출고 그리드 에디트모드 진입가능 여부 처리
	AUIGrid.bind(dsuseMGrid, "cellEditBegin", function(event) { 

		 if(event.dataField == "wrhsdlvrQy") {  
		  // 추가여부 확인 
		  var sBacode = AUIGrid.getCellValue(dsuseMGrid, event.rowIndex, "brcd");
		  if(sBacode) { 
		        return false; 
		    } else { 
		        return true;  
		    } 
		} 
		return true; // 다른 필드들은 편집 허용
	});
}

// 버튼 이벤트
function setButtonEvent(){
	$(".schFunc").keypress(function(e){
		if (e.which == 13){
		var bacode = $("#brcd").val();
		if(bacode){
			searchBacodeGridorForm();
	  		}else {
	  			alert('${msg.C100000340}')//바코드를 입력해주세요.	
	  		}
		}
	})
	// 행삭제 버튼 클릭 이벤트
	$('#btnRemoveRow').click(function(){
		AUIGrid.removeRow(dsuseMGrid, "selectedIndex"); // 행 삭제
	});
	
	// 저장 버튼 클릭 이벤트
	$("#btnSave").click(function(){
		// 저장 벨리데이션 체크 함수 호출
		if(AUIGrid.getGridData(dsuseMGrid).length !=0)
		saveReleaseGrid();
	});
};


/*############ 조회, 저장, 삭제 함수 ############*/

/* 조회 */
 function searchBacodeGridorForm(){
	var getBacodeUrl = "<c:url value='/rsc/getDsuseBacode.lims'/>";


	 ajaxJsonForm(getBacodeUrl, 'searchFrm', function (data) {
		 addRow(data[0]); // 행 추가 이벤트 호출
	 });
 }

//행 추가
 function addRow(data){
 	var item = new Object();
 	var date = getFormatDate(); // 오늘 날짜 받아오기
 	
 	//특수 문자 제거
 	var regExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\(\=]/gi;
 	var acptncDte; // 유효일자
 	var today = date.replace(regExp, ''); // 오늘 날짜
 	var invalid = false;
 	
 	// 바코드 중복값 체크를 위한 그리드 데이터 담기
 	var dsuseMGridData = AUIGrid.getGridData(dsuseMGrid);
 	
 	if(data == null || data ==""){ // 데이터 유무 체크
 		warn('${msg.C100000827}'); // 존재하지 않는 바코드입니다. \n바코드를 확인해주세요.
 		$("#brcd").val('');
 		$("#brcd").focus();
 	} else if(data.wrhsdlvrSeCode =="RS08000003"){ 
		warn('${msg.C100000934}'); // 폐기 처리된 바코드입니다.
 		$("#brcd").val('');
 		$("#brcd").focus();
	}else {	 		// 바코드 중복검사
 		if(dsuseMGridData.length > 0){
 			for(var i=0, len=dsuseMGridData.length; i<len; i++) {
 				if(dsuseMGridData[i].brcd ==data.brcd && dsuseMGridData[i].bplcCode==data.bplcCode){
 					invalid = true;
 				}
 			}
 		}
 		
 		if(invalid){ // 바코드 중복 체크
			warn('${msg.C100000676}')//이미 추가한 바코드입니다. 바코드를 확인해주세요
 		}else {
			item.custlabSeqno = data.custlabSeqno  // 분석실
			item.brcd = data.brcd // 바코드
			item.purchsNm = data.purchsNm// 입고명
			item.prductClCode = data.prductClCode// 제품 구분
			item.prductClNm = data.prductClNm// 제품 분류명
			item.prductNm = data.prductNm // 제품명
			item.prductPrpos = data.prductPrpos // 용도
			item.packngSttus = data.packngSttus// 보관 상태
			item.unitNm = data.unitNm // 제품 단위
			item.wrhsdlvrQy = "1" // 출고 수량
			item.cpcty =data.cpcty // 용기량
			item.nowInvntryQy = data.nowInvntryQy // 현재 재고량
			item.validDte = data.validDte // 유효일자
			item.validDate = data.validDate // 유효일자
			if(data.validDte != null){
				item.validDate = data.validDte
			}
			item.acptncComptDte = data.acptncComptDte // 검수 완료 일자
			item.purchsSeqno = data.purchsSeqno
			item.purchsRequstSeqno = data.purchsRequstSeqno
			item.prductSeqno = data.prductSeqno
			item.wrhsdlvrSeCode = "RS08000003" // 출고 코드
			item.wrhsdlvrSeBeforeCode = data.wrhsdlvrSeCode
			item.rm = data.rm
			item.useQySeCode = data.useQySeCode;
			item.useQySeNm = data.useQySeNm;
			item.validTmlmtMthdCode = data.validTmlmtMthdCode;
			item.unsealAfterTmlmt = data.unsealAfterTmlmt;
			item.cycleCode = data.cycleCode;
			item.bplcCode = data.bplcCode;
			AUIGrid.addRow(dsuseMGrid, item, "last");
 		}
 	}
 	$("#brcd").val("");
	$("#brcd").focus();
	return;
 }

//팝업 이벤트
 function popUpEvent(){
	dialogRelease("btnPopUp", "","dsuseMGrid",dsuseMGrid,function(item){
		$("#prductClNm").val(item.prductClNm);
		$("#prductClSeqno").val(item.prductClSeqno);
	});
 }

/* 저장 */
function saveReleaseGrid(){
	var saveUrl = "<c:url value='/rsc/updateBrcd.lims'/>";
	var getGridData = AUIGrid.getGridData(dsuseMGrid);

	if(getGridData != null){
		customAjax({url:saveUrl,data:getGridData, showLoading:true,elementIds:["btnSave"], successFunc :function(data) {
			if (data == 0){
				err("${msg.C100000936}");//폐기에 실패하였습니다.
			} else {
				success("${msg.C100000935}");//폐기되었습니다.
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
	AUIGrid.clearGridData(dsuseMGrid);
}

// 저장 벨리데이션 체크

// 엔테 이벤트 (검수 그리드 조회)	
// $("#searchFrm").find("#brcd").keypress(function (e) {
// 	var bacode = $("#brcd").val();
	
// 	if (e.which == 13){
//   		if(bacode){
// 			doSearch(e);  			
//   		}else {
//   			alert('바코드를 입력해주세요.')
  			
//   		}
//     }
// });

</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>