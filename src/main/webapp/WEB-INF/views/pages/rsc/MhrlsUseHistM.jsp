<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기 사용 이력</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript">

</script>
<script>
//AUIGrid 생성 후 반환 ID
var MhrlsUseHistMList = 'MhrlsUseHistMList';
var lang = ${msg}; // 기본언어
$(document).ready(function(){
   getAuth();
   
   //그리드 세팅
   setMhrlsGrid();
   
   //그리드 이벤트 선언
   setMhrlsGridEvent();
      
   //버튼 이벤트
   setButtonEvent();
   
   //초기화
   init();
   
});

function init(){
   
   $("#mhrlsBrcdNm").focus();
   
 	//조회 조건 기기명 팝업창 세팅
   dialogMhrls("btnShrMhrlsSearch", null, "shrMhrlsNmDialog", function(item){
      $("#shrMhrlsNm").val(item.mhrlsNm);
      $("#shrMhrlsSeqno").val(item.mhrlsSeqno);
   }, function(){
	   $("#shrMhrlsNmDialogpopChrgTeamSeCode").val($("#schChrgTeamSeCode").val());
   });
   
   //기기명 팝업창 세팅
   dialogMhrls("btnMhrlsSearch", null, "mhrlsNmDialog", function(item){
      $("#mhrlsNm").val(item.mhrlsNm);
      $("#mhrlsSeqno").val(item.mhrlsSeqno);
   });
   
   //기기 이력 전체 삭제
   dialogMhrlsUseAllDel("btn_allDel", null, "mhrlsUseAllDelDialog", function(item){
	   dataDelete("all");
   }, function(){
	    var mhrlsSeqno = getEl("shrMhrlsSeqno").value;
		
		//조회조건 기기명 없으면 삭제 절대 안댐.. 기기가 없으면 전체 삭제대버림.
		if(!mhrlsSeqno){
			alert("조회조건 중 기기명이 필수로 선택되어야 전체 삭제가 가능합니다.");
			return false;
		}
			
   });
   
   ajaxJsonComboBox('/com/getCmmnCode.lims', 'schChrgTeamSeCode', {'upperCmmnCode': 'RS19'}, true); /* 선택 */
   //달력
   datePickerCalendar(["shrUseBeginDte", "shrUseEndDte"], true, ["MM",-1], ["DD",0]);
   datePickerCalendar(["oprDte"], true);
}

//그리드 함수
function setMhrlsGrid(){
   
   var col = [];   
   
   auigridCol(col);
      
   col.addColumnCustom("mhrlsOprSploreSeqno", "기기사용일련번호", "*" ,false); /* 기기 수리 이력 일련번호 */
   col.addColumnCustom("mhrlsSeqno", "기기일련번호", "*", false); /* 기기 일련번호 */
   col.addColumnCustom("mhrlsNm", "기기 명", "*", true); /* 기기 일련번호 */
   col.addColumnCustom("brcd", "바코드", "*", true); /* 바코드 */
   col.addColumnCustom("expriemNm", "시험항목 명", "*", true); /* 기기관리번호 */
   col.addColumnCustom("oprDte", "기기 사용 일자", "*", true); /* 기기분류 */
   
   var cusPros = {
		editable : false, // 편집 가능 여부 (기본값 : false)
		 selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
		enableCellMerge : true,
		showRowCheckColumn : true,
	 	independentAllCheckBox : true,
	 	rowCheckDisabledFunction : function(rowIndex, isChecked, item) {
			if(item.brcd) { 
				return false; // false 반환하면 disabled 처리됨
			}
			return true;
		}
    }   
   
   
   //auiGrid 생성
   MhrlsUseHistMList = createAUIGrid(col, "MhrlsUseHistMList", cusPros);
   // 그리드 리사이즈.
   gridResize([MhrlsUseHistMList]);
   // 그리드 칼럼 리사이즈
   
   AUIGrid.bind(MhrlsUseHistMList, "ready", function(event) {
      gridColResize([MhrlsUseHistMList],"2");   // 1, 2가 있으니 화면에 맞게 적용
   });
}

//그리드 이벤트 함수
function setMhrlsGridEvent(){
   AUIGrid.bind(MhrlsUseHistMList, "cellClick", function(event) {
	   var item = event.item;
	   var checked = AUIGrid.isCheckedRowById(MhrlsUseHistMList, item._$uid);
	   if(item.brcd){
		   return false;
	   }
	   checked ? AUIGrid.addUncheckedRowsByValue(MhrlsUseHistMList, "mhrlsOprSploreSeqno", item.mhrlsOprSploreSeqno)
			   : AUIGrid.addCheckedRowsByValue(MhrlsUseHistMList, "mhrlsOprSploreSeqno", item.mhrlsOprSploreSeqno);
   });
   
	// 전체 체크박스 클릭 이벤트 바인딩
	AUIGrid.bind(MhrlsUseHistMList, "rowAllChkClick", function( event ) {
		event.checked ? AUIGrid.setCheckedRowsByValue(event.pid, "chkStat", 'N')
				: AUIGrid.addUncheckedRowsByValue(event.pid, 'chkStat', 'N');
	});
}

//버튼 이벤트
function setButtonEvent(){
   //엔터로 검색
   $("#shrMhrlsNm,#shrUseBeginDte #shrUseEndDte").keyup(function(e){
      searchMhrls(e.keyCode);
   });
   
   // 신규 클릭 이벤트
   $('#btn_new').click(function(){      
      // 폼 초기화
      $('#MhrlsUseHistMForm')[0].reset();
   });
   
   //조회 버튼 이벤트
   $("#btn_select").click(function(){
      searchMhrls();
      $('#MhrlsUseHistMForm')[0].reset();
   });
   
   //저장 버튼 이벤트
   $("#btn_save").click(function(){
   	  dataSave();
   });
   
   $("#btn_del").click(function(){
	  dataDelete(null); 
   });

   /* $("#btn_allDel").click(function(){
	  dataDelete("all"); 
   }); */
   
   $("#btn_reset").click(function(){
	   pageReset(["searchFrm"], null, null, function(){
		   $("#shrUseBeginDte").val(getFormatDate(null,null,-30));
		   $("#shrUseEndDte").val(getFormatDate());
		}); 
   });
   
   $("#schChrgTeamSeCode").change(function(){
	   $("#shrMhrlsSeqno").val('');
	   $("#shrMhrlsNm").val('');
   });
}


//조회 함수
function searchMhrls(keyCode) {
   if(keyCode != undefined && keyCode == 13)
      searchMhrls();
   else {
      if(keyCode == undefined) {
         getGridDataForm("<c:url value='/rsc/getMhrlsUseHistM.lims'/>", "searchFrm", MhrlsUseHistMList);
         $("#MhrlsUseHistMForm")[0].reset();
      }
   }
}

function dataSave(){
	if(!saveValidation('MhrlsUseHistMForm')){
		return ;
	}
	
	var data = $("#MhrlsUseHistMForm").serializeObject();
	customAjax({"url":"/rsc/insMhrlsUseHistM.lims",'data':data,"successFunc":function(result){
		alert("저장되었습니다.");
		searchMhrls();
		$("#MhrlsUseHistMForm")[0].reset();
	}
	});
}

function dataDelete(type){
	var data;
	var chkRow = joinArrayChkRow();
	data = Object.assign($("#searchFrm").serializeObject(), {"list" : chkRow});
	data.type = type;
	
	console.log(data);
	
	customAjax({"url":"/rsc/updMhrlsUseHistDel.lims",'data':data,"successFunc":function(result){
		alert("삭제되었습니다.");
		searchMhrls();
		$("#MhrlsUseHistMForm")[0].reset();
	}
	}); 
}

function joinArrayChkRow(){    
	var chkrow = AUIGrid.getCheckedRowItems(MhrlsUseHistMList);
	var arr = [];
	for(var i = 0; i<chkrow.length; i++){
		arr.push(chkrow[i].item.mhrlsOprSploreSeqno);
	}
	
	return arr;
}

</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
   <div class="subCon1">
      <h2>기기 사용 목록</h2> <!-- 기기 사용 목록 -->
      <div class="btnWrap">         
         <button type="button" id="btn_reset" class="btn3">초기화</button>
         <button type="button" id="btn_del" class="delete btn3">삭제</button>
         <button type="button" id="btn_allDel" class="delete btn3">전체삭제</button>
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
               <th>담당 팀</th> <!-- 담당팀 -->
	           <td>
	               <select id="schChrgTeamSeCode" name="schChrgTeamSeCode"></select>
               </td>        
               <th>${msg.C000000011}</th> <!-- 기기명 -->
	           <td>
	               <input type="text" id="shrMhrlsNm" name="shrMhrlsNm" class="wd55p"  disabled>
	               <input type="hidden" id="shrMhrlsSeqno" name="shrMhrlsSeqno">               
	               <button type="button" id="btnShrMhrlsSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->
               </td>           
               <th>사용 일자</th>  <!-- 부서 -->
               <td style="text-align:left;">
                  <input type="text" id="shrUseBeginDte" name="shrUseBeginDte" class="wd6p" style="min-width: 6em;" readonly> 
                  ~ 
                  <input type="text" id="shrUseEndDte" name="shrUseEndDte" class="wd6p" style="min-width: 6em;" readonly>
               </td>
               <td colspan="4"></td>
            </tr>
         </table>
      </form>
      <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
   </div>   
   <div id="MhrlsUseHistMList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
   <form id="MhrlsUseHistMForm">
	   <div class="subCon1 mgT15" id="detail">
	      <h2>기기 사용 정보</h2> <!-- 기기 수리 정보 -->
	      <div class="btnWrap">
	         <button type="button" id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
	         <button type="button" id="btn_save" class="btn1">${msg.C000000015}</button> <!-- 저장 -->
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
	            <th class="necessary">${msg.C000000011}</th> <!-- 기기명 -->
	            <td>
	               <input type="text" id="mhrlsNm" name="mhrlsNm" class="wd55p" disabled>
	               <input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno">               
	               <button type="button" id="btnMhrlsSearch" class="inTableBtn inputBtn">${msg.C000000164}</button> <!-- 찾기 -->
               </td>
	            <th class="necessary">사용 일자</th> <!-- 수리 시작일시 -->
	            <td style="text-align:left;">
	               <input type="text" id="oprDte" name="oprDte" class="wd100p" style="min-width:10em;">
	            </td>
	            <th class="necessary">사용 횟수</th> <!-- 수리 시작일시 -->
	            <td style="text-align:left;">
	               <input type="text" id="useCnt" name="useCnt" class="wd100p" style="min-width:10em;">
	            </td>
				<td colspan="2"></td>
	         </tr>
	      </table>
	      
	      <input type="hidden" id="crud" name="crud" value="C"/>
	      <input type="hidden" id="mhrlsUseHistSeqno" name="mhrlsUseHistSeqno">
	      <input type="hidden" id="oprAt" name="oprAt">
	      <input type="hidden" id="deleteAt" name="deleteAt" value="N">
	      
	   </div>
   </form>
</div>

<!--  body 끝 -->
</tiles:putAttribute>

       
</tiles:insertDefinition>