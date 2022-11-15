<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">공통코드별국가언어관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
	<h2><i class="fi-rr-apps"></i>${msg.C100000196}</h2> <!-- 공통코드별국가언어관리-->
		<div class="btnWrap">
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
				</colgroup>
				<tr>
 					<th>${msg.C100000582}</th> <!-- 언어 -->
					<td><select id="nationLangCode" name="nationLangCode"></select></td>
					<th>${msg.C100000583}</th> <!-- 언어명 -->
					<td><input type="text" id="cmmnSearch" name="cmmnSearch"></td>
					<td colspan="4"></td>
				</tr>
			</table>
				<input type="hidden" id="langMenuSeqno" name="langMenuSeqno">
		</form>
	</div>	
		<div class="subCon2">
           <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
           <div id="cmmnList" style="width: 100%; height: 450px; margin: 0 auto;"></div>
        </div> 
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var cmmnList = 'cmmnList';
	// 그리드 데이터
	
	$(function() {
		//권한체크
		getAuth();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setMenuGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setMenuGridEvent();

	    // 그리드 리사이즈
	    gridResize([cmmnList]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
		
	});
	
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'nationLangCode', {'upperCmmnCode': 'SY06'}, false);
	}
	
 	// 그리드 생성
	function setMenuGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var columnLayout = {
	    	cmmnList : []
		};

	    //컬럼 속성 정의
	    var McouColPros = {
	    		showStateColumn : true
	    };

		var cusPros = {
				displayTreeOpen : true,
				// 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
				flat2tree : true,
				selectionMode : "multipleCells",
				// 행의 고유 필드명
//	   			rowIdField : "menuNm",
				// 트리의 고유 필드명
				treeIdField : "cmmnCode",
				// 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
				treeIdRefField : "upperCmmnCode"

		}


			 auigridCol(columnLayout.cmmnList, cusPros);
			 columnLayout.cmmnList.addColumnCustom("cmmnCodeNm", "${msg.C100000304}", null, true, false,McouColPros); /* 메뉴 */
			 columnLayout.cmmnList.addColumnCustom("langNm", "${msg.C100000583}", null, true, true); /* 언어명 */
			 columnLayout.cmmnList.addColumnCustom("useAt", "${msg.C100000443}", null, true, false); /* 사용여부 */
			 columnLayout.cmmnList.addColumnCustom("cmmnCode","메뉴 코드","*",false,false);
			 columnLayout.cmmnList.addColumnCustom("upperCmmnCode","부모메뉴 코드","*",false,false);
			 columnLayout.cmmnList.addColumnCustom("menuLv","메뉴 분류","*",false,false);

		    //그리드 생성
		 	cmmnList = createAUIGrid(columnLayout.cmmnList, cmmnList,cusPros);
	}; 

	
	
	//그리드 이벤트
	function setMenuGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(cmmnList, "ready", function(event) {
	        gridColResize(cmmnList, "2");
	    });

	    AUIGrid.bind(cmmnList, "cellClick", function(event) {
	    	$('#langNm').val(event.item.langNm);
	    	$('#langCmmnSeqno').val(event.item.langCmmnSeqno);
	        
	    });
	      
	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	    	searchCmmnlang();
	    })
	    
	    //저장
	    $("#btnSave").click(function() {
	    	var resultCount = 0;
	    	var McoulangaddedRowItems = AUIGrid.getAddedRowItems(cmmnList);   //추가한 아이템
	    	var McoulangupdedRowItems = AUIGrid.getEditedRowItems(cmmnList); // 수정한 아이템
	    	var McoulanggridData = AUIGrid.getGridData(cmmnList); //출력된 데이터를 반환
			var chk = saveValidation();
			if(chk == true){
	    		if(McoulangaddedRowItems.length > 0 || McoulangupdedRowItems.length > 0){
		    		 saveCmmnlang(McoulangaddedRowItems,McoulangupdedRowItems);	    
	    		}	
	 		}  
 
	    });
		
		
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchCmmnlang()
		    }
		});
	    
		$('#nationLangCode').on('change',function() {				
			searchCmmnlang()

		});	

	
	}
	

	
	// 조회 함수
	function searchCmmnlang() {
	    getGridDataForm("<c:url value='/lng/getCmmnLang.lims'/>", "searchFrm", cmmnList, function(data) {

	    });
	}
	
	/* 저장 */
	function saveCmmnlang(McoulangaddedRowItems,McoulangupdedRowItems) {
	   var url = "<c:url value='/lng/saveCmmnlang.lims'/>";
	   var Mcoulangadd = McoulangaddedRowItems;
	   var Mcoulangup = McoulangupdedRowItems;
	   var param = Mcoulangadd.concat(Mcoulangup);
	   var nationLangCode = $('#nationLangCode').val()

	   var map = {
			   "list" : param,
			   "nationLangCode" : {"nationLangCode" : nationLangCode},
	   }
	   		   customAjax({"url":url,"data":map,"successFunc":function(data) {
		            if (data > 0) {
		                success("${msg.C000000071}"); /* 저장 되었습니다. */
		                searchCmmnlang();
		            }
	   		   }
	        });    

	    }
	
	// 유효성 검사
	function saveValidation(){
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var groupGridData = AUIGrid.getGridData(cmmnList);
		var item;
		var invalid = true;
		var invalidRowIndex = -1;
		var colIndex;
		var nm;
		for(var i=0, len=groupGridData.length; i<len; i++) {
			item = groupGridData[i];
			
			// 칼럼의 값이 입력 안됐는지 체크
			if(typeof item["langNm"] == "undefined" || String(item["langNm"]).trim() == "") {
				invalidRowIndex = i;
				invalid = false;
				colIndex = AUIGrid.getColumnIndexByDataField(cmmnList, "langNm");
				nm = " ${msg.C100000582}" /* 언어 */
				break;
			} 

		}

		if(!invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			warn(nm+" ${msg.C100000695}"); /* 입력값이 누락된 사항이 있습니다. */
			var fa = 1;
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(cmmnList, invalidRowIndex, colIndex);
			return false;
		} else {
			return true;
		}
	}
	
	

		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

