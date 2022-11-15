<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">기본언어관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000232}</h2><!-- 기본언어관리 -->
		<div class="btnWrap">
			<button id="btn_add" class="btn5"><img src="/assets/image/plusBtn.png"></button>
			<button id="btn_remove"  class="delete"><img src="/assets/image/minusBtn.png"></button>
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->		
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" name="searchFrm" onsubmit="return false" >
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
				</colgroup>
				<tr>
					<th>${msg.C100000903}</th> <!-- 코드 -->
					<td><input type="text" id="langCodeSch" name="langCodeSch"></td>
					<th>${msg.C100000583}</th> <!-- 언어명 -->
					<td><input type="text" id="langNmSch" name="langNmSch"></td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td colspan="1" style="text-align:left;">
						<label><input type="radio" id="use_a" name="useAtSch" value="" >${msg.C100000779}</label> <!-- 전체 -->
						<label><input type="radio" id="use_y" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" id="use_n" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
					<td colspan="2"></td>
				</tr>
			</table>
			<input type="hidden" id="langMastrSeqno" name="langMastrSeqno">
			<input type="hidden" id="langNmChk" name="langNmChk">
			
		</form> 
	</div>
		<div class="subCon2">
             <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
           <div id="defaultGrid" style="width: 100%; height: 450px; margin: 0 auto;"></div>
        </div> 
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var defaultGrid = 'defaultGrid';
	
	// 그리드 데이터
	$(function() {
		//권한체크
		getAuth();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setdefaultGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setdefaultGridEvent();

	    // 그리드 리사이즈
	    gridResize([defaultGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
		
	});
	
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 

	}
	
 	// 그리드 생성
	function setdefaultGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var defaultCol = [];
	    auigridCol(defaultCol);

	    //컬럼 속성 정의
	    var defaultColPros = {
	    		showStateColumn : true
	    };

	    //그리드 속성 정의
	   var defaultPros = {
	    		editRenderer : {
	    			type : "InputEditRenderer",
	    			
	    			validator : function(oldValue, newValue, item, dataField) {
	    				if(newValue != ""){
		    				if(oldValue != newValue) {
		    					// dataField 에서 newValue 값이 유일한 값인지 조사
		    					var isValid = AUIGrid.isUniqueValue(defaultGrid, dataField, newValue);
		    					
		    					 if(isValid == false){
		    						 warn('${msg.C100000838}') /* 중복값이 존재 합니다. 다시 입력해 주세요 */
		    						 return { "oldValue" : oldValue };
		    					 } 		
		    				}
	    				}
	    			}
	    		}
	    	
	    };
		    //컬럼 셋팅
		    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
			defaultCol.addColumnCustom("langCode", "${msg.C100000903}", "*", true, true ,defaultPros); /* 코드 */
		    defaultCol.addColumnCustom("langNm", "${msg.C100000583}", "*", true, true, defaultPros); /* 언어명 */
		    defaultCol.addColumnCustom("useAt", "${msg.C100000443}", "*", true, true); /* 사용여부 */
			 /*
		     * @param dataFields 색상 정의할 데이터필드 배열
		     * @param gridId 그리드 div 영역 id
		     * @param value 체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"} 
		     */
            defaultCol.checkBoxRenderer(["useAt"], defaultGrid,  {check: "Y", unCheck: "N"} , defaultColPros);

		    //그리드 생성
		    defaultGrid = createAUIGrid(defaultCol, defaultGrid,defaultColPros);

	}; 

	
	
	//그리드 이벤트
	function setdefaultGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(defaultGrid, "ready", function(event) {
	        gridColResize(defaultGrid, "2");
	    });

	    AUIGrid.bind(defaultGrid, "cellClick", function(event) {
	    	$('#langNm').val(event.item.langNm);
	       
	        
	    });
	    
	    AUIGrid.bind(defaultGrid, "cellEditEnd", function(event){
    		// 중복체크
			var myValue = AUIGrid.getCellValue(defaultGrid, event.rowIndex, "gbnCrud");
			var langCode = AUIGrid.getCellValue(defaultGrid, event.rowIndex, "langCode");

     		 var url = "<c:url value='/lng/langNmChk.lims'/>";
    		 var langNmChk = AUIGrid.getItemByRowIndex(defaultGrid, event.rowIndex )

    		if(langCode[0] != "C"){
    			warn("${msg.C100001059}"); // 코드의 첫글자는 C 로 시작해야 합니다.
    			AUIGrid.setCellValue(defaultGrid, event.rowIndex,event.columnIndex,"")
    			return false;
    		}
    		 if(langCode.length!=10){
				warn("${msg.C100001060}"); // 코드는 10자입니다.
     			AUIGrid.setCellValue(defaultGrid, event.rowIndex,event.columnIndex,"")
     			return false;
     		}

		 	 if(myValue == "C"){
		 		customAjax({"url":url,"data":langNmChk,"successFunc":function(data) {
// 		 		ajaxJsonParam(url, langNmChk, function(data) {

		            if (data > 0) {
		            	warn('${msg.C100000838}') /* 중복값이 존재 합니다. 다시 입력해 주세요 */
		            	   AUIGrid.setCellValue(defaultGrid, event.rowIndex, "langNm", "");
		            }
				}
		        });
		 	 }

    		});
	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	        searchDelang();
	    })
	    
	    //저장
	    $("#btnSave").click(function() {
			var resultCount = 0;
			var DelangaddedRowItems = AUIGrid.getAddedRowItems(defaultGrid);   //추가한 아이템
			var DelangupdedRowItems = AUIGrid.getEditedRowItems(defaultGrid); // 수정한 아이템
			var DelanggridData = AUIGrid.getGridData(defaultGrid); //출력된 데이터를 반환

	    	    
			var Chk = saveValidation();
	    	 
			if(Chk){
				if(DelangaddedRowItems.length > 0 || DelangupdedRowItems.length > 0)
					saveDelang(DelangaddedRowItems,DelangupdedRowItems);
			}
	    });
		    
	    
	    /////////////////// 행 추가 //////////////////
	    $("#btn_add").click(function() {
	        addDelang();
	    });
	    /////////////////// 행 삭제 //////////////////
	    $("#btn_remove").click(function() {
		  if(!confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */
				return false;
			}
	    
	        removeDelang();
	        delDelang();
	    });
	    
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchDelang()
		    }
		});

	}
	
	function addDelang() {
	    var item = new Object();
	    item.langMastrSeqno = $("#langMastrSeqno").val()
	    item.langNm = $("#langNm").val()
	    item.useAt = 'Y'
	    item.gbnCrud = "C" // insert 구분값
	    AUIGrid.addRow(defaultGrid, item, "first");
	};
	
	function removeDelang() {
	    AUIGrid.removeRow(defaultGrid, "selectedIndex");
	}
	
	/////////// 데이터 관리 ///////// 
	function delDelang() {
		var url = "<c:url value='/lng/delDelang.lims'/>";
		var del = AUIGrid.getRemovedItems(defaultGrid)	
		customAjax({"url":url,"data":del,"successFunc":function(data){
			if (data > 0) {
	        	success("${msg.C100000462}"); /* 삭제되었습니다. */
	        	searchDelang();
		    	} 
			}
	});
//  	   ajaxJsonParam(url, del, function(data) {
// 	        if (data > 0) {
// 	        	alert("${msg.C000000179}"); /* 삭제되었습니다. */
// 	        	searchDelang();
// 	       } 
// 	   });     
} 
	
	// 조회 함수
	function searchDelang() {
	    getGridDataForm("<c:url value='/lng/getDelang.lims'/>", "searchFrm", defaultGrid, function(data) {
	    	
	    });
	}
	
	/* 저장 */
	function saveDelang(DelangaddedRowItems,DelangupdedRowItems) {
	   	var url = "<c:url value='/lng/saveDelang.lims'/>";
	   	var Delangadd = DelangaddedRowItems;
	   	var Delangup = DelangupdedRowItems;
	   	var param = Delangadd.concat(Delangup);
	
		customAjax({"url":url,"data":param,"successFunc":function(data){
			if (data > 0) {
				success("${msg.C100000762}"); /* 저장 되었습니다. */
	            searchDelang();
		   	}
		}});
	}
	
	// 유효성 검사
	function saveValidation(){
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var groupGridData = AUIGrid.getGridData(defaultGrid);
		var item;
		var invalid = true;
		var invalidRowIndex = -1;
		var colIndex;
		var nm;
		for(var i=0, len=groupGridData.length; i<len; i++) {
			item = groupGridData[i];
			
			// 칼럼의 값이 입력 안됐는지 체크
			if(typeof item["langCode"] == "undefined" || String(item["langCode"]).trim() == "") {
				invalidRowIndex = i;
				invalid = false;
				colIndex = AUIGrid.getColumnIndexByDataField(defaultGrid, "langCode");
				nm = "${msg.C100000903}" /* 코드 */
				break;
			} 
			
			if(typeof item["langNm"] == "undefined" || String(item["langNm"]).trim() == "") {
				invalidRowIndex = i;
				invalid = false;
				colIndex = AUIGrid.getColumnIndexByDataField(defaultGrid, "langNm");
				nm = "${msg.C100000583}" /* 언어명 */
				break;
			} 
		}
	
		if(!invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			warn(nm+" ${msg.C100000695}"); /* 입력값이 누락된 사항이 있습니다. */
			var fa = 1;
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(defaultGrid, invalidRowIndex, colIndex);
			return false;
		} else {
			return true;
		}
}
	
	

		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

