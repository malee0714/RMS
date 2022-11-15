<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title"></tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000135}</h2> <!-- Can.No관리 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search btn3" >${msg.C000000002}</button> <!-- 조회 -->
			<button id="btn_add" class="btn4">${msg.C000000111}</button> <!-- 행추가 -->
			<button id="btn_remove" class="btn5 search">${msg.C000000112}</button> <!-- 행삭제 -->
			<button id="btnSave" class="btn1 save">${msg.C000000015}</button> <!-- 저장 -->
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
					<col style="width:40%"></col>			
				</colgroup>
				<tr>
					<th>${msg.C000000080}</th> <!-- 부서 -->
					<td><select id="deptCodeSch" name="deptCodeSch"></select></td>
					<th>${msg.C000000136}</th> <!-- Can.No -->
					<td><input type="text" id="canNoSch" name="canNoSch"></td>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td colspan="1" style="text-align:left;">
						<label><input type="radio" id="use_y" name="useAtSch" value="" >${msg.C000000062}</label> <!-- 전체 -->
						<label><input type="radio" id="use_y" name="useAtSch" value="Y"  checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" id="use_n" name="useAtSch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
				</tr>
			</table>
			<input type="hidden" id="canNoSeqno" name="canNoSeqno">
			<input type="hidden" id="bestInspctInsttCode" name="bestInspctInsttCode">
			<input type="hidden" id="canNoChk" name="canNoChk">
			
		</form>
		
		    <div class="subCon2">
              <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
              <div id="cannoGrid" style="width: 100%; height: 450px; margin: 0 auto;"></div>
            </div>  
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var cannoGrid = 'cannoGrid';
	var lang = ${msg}; // 기본언어
	var deptRenList =[];
	// 그리드 데이터
	
	$(function() {
		//권한체크
		getAuth();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setcannoGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setcannoGridEvent();

	    // 그리드 리사이즈
	    gridResize([cannoGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
		
	});
	
	function setCombo(){
		deptParams = {
			"limsUseAt" : "Y"
		   ,"mmnySeCode" : "${UserMVo.mmnySeCode}"
		}
		
		ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch',deptParams,false, "${msg.C000000079}", "${UserMVo.deptCode}", "${UserMVo.authorSeCode}");
		deptList.list = getGridComboList('/com/getDeptCombo.lims',deptParams,true);
	}
	
 	// 그리드 생성
	function setcannoGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var cannoCol = [];
	    auigridCol(cannoCol);

	    //컬럼 속성 정의
	    var cannoColPros = {

	    };

	    //그리드 속성 정의
	    var cannoPros = {
	    		editRenderer : {
	    			type : "InputEditRenderer",
	    			
	    			validator : function(oldValue, newValue, item, dataField) {
	    				if(oldValue != newValue) {
	    					// dataField 에서 newValue 값이 유일한 값인지 조사
	    					var isValid = AUIGrid.isUniqueValue(cannoGrid, dataField, newValue);
	    					
	    					 if(isValid == false){
	    						 alert('${msg.C000000137}') /* 중복값이 존재 합니다. 다시 입력해 주세요 */
	    						 return { "oldValue" : oldValue };
	    					 } else {
	    						 
	    					 }
	    				
	    				}
	    			}
	    		}
	    	
	    };

		
		
	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom

	    cannoCol.addColumnCustom("deptCode", "${msg.C000000080}", null, true, true); /* 부서 */
	    cannoCol.addColumnCustom("canNo", "${msg.C000000136}", null, true, true,cannoPros); /* Can.No */
	    cannoCol.addColumnCustom("useAt", "${msg.C000000065}", null, true, true); /* 사용여부 */
	
		 /*
	     * @param dataFields 색상 정의할 데이터필드 배열
	     * @param gridId 그리드 div 영역 id
	     * @param value 체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"} 
	     */
	 	var dCode;
		var deptCode =["deptCode"]
		var deptParams = {
				"limsUseAt" : "Y"
			   ,"mmnySeCode" : "${UserMVo.mmnySeCode}"
			}
		
			
		comboAjaxJsonParam('/com/getDeptCombo.lims', deptParams, function(data){
			dCode = data; 
		}, null, false);
				
		cannoCol.dropDownListRenderer(deptCode, dCode, true, null);
			 
	    cannoCol.checkBoxRenderer(["useAt"], cannoGrid,  {check: "Y", unCheck: "N"} , cannoColPros);

	 
	    //그리드 생성
	    cannoGrid = createAUIGrid(cannoCol, cannoGrid);
	    
		
	}; 

	
	
	//그리드 이벤트
	function setcannoGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(cannoGrid, "ready", function(event) {
	        gridColResize(cannoGrid, "2");
	    });

	    AUIGrid.bind(cannoGrid, "cellClick", function(event) {
	    	$('#canNo').val(event.item.canNo);
	       
	        
	    });
	    
	    AUIGrid.bind(cannoGrid, "cellEditEnd", function(event){
	    	if(event.dataField == "canNo"){
	    		//중복체크
	    		var myValue = AUIGrid.getCellValue(cannoGrid, event.rowIndex, "gbnCrud");
	     		 var url = "<c:url value='/sys/chkNo.lims'/>";
	    		 var canNoChk = AUIGrid.getItemByRowIndex(cannoGrid, event.rowIndex )
	    	 	 if(myValue == "C"){
	 		 		ajaxJsonParam(url, canNoChk, function(data) {

	 		            if (data > 0) {
	 		            	alert('${msg.C000000137}') /* 중복값이 존재 합니다. 다시 입력해 주세요 */
	 		            	   AUIGrid.setCellValue(cannoGrid, event.rowIndex, "canNo", "");
	 		            }
	 		        });    
	 		 	 } 
	    	}
	   
    	
	

	

    		}); 
	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	        searchCon();
	    })
	    
	    //저장
	    $("#btnSave").click(function() {
	    	 var resultCount = 0;
	    	 var ConaddedRowItems = AUIGrid.getAddedRowItems(cannoGrid);   //추가한 아이템
	    	 var ConupdedRowItems = AUIGrid.getEditedRowItems(cannoGrid); // 수정한 아이템
	    	 var CongridData = AUIGrid.getGridData(cannoGrid); //출력된 데이터를 반환

	    	    
	    	var Chk = saveValidation();	
	    	 
	    	 if(Chk){
	    		 if(ConaddedRowItems.length > 0 || ConupdedRowItems.length > 0)	
		    	 	 saveCon(ConaddedRowItems,ConupdedRowItems);
	    	 }   
	    	 
	    	    
	    });
		    
	    
	    /////////////////// 행 추가 //////////////////
	    $("#btn_add").click(function() {
	        addCon();
	    });
	    /////////////////// 행 삭제 //////////////////
	    $("#btn_remove").click(function() {
	        removecon();
	        delcon();
	    });
	    
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchCon()
		    }
		});

	}
	
	function addCon() {
	    var item = new Object();
	    item.canNoSeqno = $("#canNoSeqno").val()
	    item.deptCode = $("#deptCode").val()
	    item.canNo = $("#canNo").val()
	    item.useAt = 'Y'
	    item.gbnCrud = "C" // insert 구분값
	    AUIGrid.addRow(cannoGrid, item, "last");
	};
	
	function removecon() {
	    AUIGrid.removeRow(cannoGrid, "selectedIndex");
	}
	
	/////////// 데이터 관리 ///////// 
	function delcon() {
		var url = "<c:url value='/sys/delCan.lims'/>";
		var del = AUIGrid.getRemovedItems(cannoGrid)	
	
	   ajaxJsonParam(url, del, function(data) {
	        if (data > 0) {
	        	alert("${msg.C000000179}"); /* 삭제되었습니다. */
	        	 searchCon();
	       } 
	   });    

} 
	
	// 조회 함수
	function searchCon() {
	    getGridDataForm("<c:url value='/sys/getCan.lims'/>", "searchFrm", cannoGrid, function(data) {
	    	
	    });
	}
	
	/* 저장 */
	function saveCon(ConaddedRowItems,ConupdedRowItems) {
	   var url = "<c:url value='/sys/saveCan.lims'/>";
	   var Conadd = ConaddedRowItems;
	   var Conup = ConupdedRowItems;
	   var param = Conadd.concat(Conup);
	 
 	       ajaxJsonParam(url, param, function(data) {
 
	            if (data > 0) {
	            	
	                alert("${msg.C000000071}"); /* 저장 되었습니다. */
	                searchCon();
	            }
	        });  
	        
	        
	     // 디비 리턴값
	
	    }	
	
	// 유효성 검사
function saveValidation(chk){
	// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
	var groupGridData = AUIGrid.getGridData(cannoGrid);
	var item;
	var invalid = true;
	var invalidRowIndex = -1;
	var colIndex;
	var nm;
	for(var i=0, len=groupGridData.length; i<len; i++) {
		item = groupGridData[i];
		
		// 칼럼의 값이 입력 안됐는지 체크
		if(typeof item["deptCode"] == "undefined" || String(item["deptCode"]).trim() == "") {
			invalidRowIndex = i;
			invalid = false;
			colIndex = AUIGrid.getColumnIndexByDataField(cannoGrid, "deptCode");
			nm = "${msg.C000000080}" /* 부서 */
			break;
		} else if(typeof item["canNo"] == "undefined" || String(item["canNo"]).trim() == ""){
			invalidRowIndex = i;
			invalid = false;
			colIndex = AUIGrid.getColumnIndexByDataField(cannoGrid, "canNo");
			nm = "${msg.C000000136}" /* Can.No */
			break;
		} 

	}

	if(!invalid) {
		// 필수 칼럼의 값이 없어서 예외 처리하기
		alert(nm+" ${msg.C000000138}"); /* 입력값이 누락된 사항이 있습니다. */
		var fa = 1;
		// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
		AUIGrid.setSelectionByIndex(cannoGrid, invalidRowIndex, colIndex);
		return false;
	} else {
		return true;
	}
}
	
	

		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

