<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2>메뉴별 라벨 언어관리</h2>
		<div class="btnWrap">
			<button id="btnSearch" class="search btn1" >조회</button>
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
				</colgroup>
				<tr>
 					<th>언어</th>
					<td><select id="nationLangCodeSch" name="nationLangCodeSch"></select></td>
					<th>메뉴 명</th>
					<td><input type="text" id="menuSeqnoSch" name="menuSeqnoSch"></td>
					<th>언어 명</th>
					<td><input type="text" id="langNmSch" name="langNmSch"></td>
					<th>사용여부</th>
					<td colspan="1" style="text-align:left;">
						<label><input type="radio" id="use_a" name="useAtSch" value="" >전체</label>
						<label><input type="radio" id="use_y" name="useAtSch" value="Y"  checked>사용</label>
						<label><input type="radio" id="use_n" name="useAtSch" value="N" >사용 안함</label>
					</td>
				</tr>
			</table>
				<input type="hidden" id="langMenuSeqno" name="langMenuSeqno">
		</form>

		<div class="subCon1 wd49p mgT20" style="display:inline-block;">
		    <div class="subCon2">
              <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
              <div id="labelList" style="width: 100%; height: 400px; margin: 0 auto;"></div>
            </div>  
        </div>

	    <div class="subCon1 wd50p mgT20" style="display:inline-block;">
			<div class="subCon2">
			<div class="btnWrap" style="margin: -5px -13px 0px 0px;">
				<button id="btn_add" class="btn1">행추가</button>
				<button id="btn_remove" class="btn1 search">행삭제</button>
				<button id="btnSave" class="btn1 save">저장</button>
			 </div>
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="labelinfoList" style="width:100%; height:400px; margin: 0 auto;"></div>
			</div>
		</div>
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var labelList = 'labelList';
	var labelinfoList = 'labelinfoList';
	var selectedData;
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
	    gridResize([labelList]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
		
	});
	
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'nationLangCodeSch', {'upperCmmnCode': 'SY06'}, false);
	}
	
 	// 그리드 생성
	function setMenuGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var columnLayout = {
	    		labelList : [],
	    		labelinfoList :[]
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
		
				treeIdField : "menuSeqno",
				// 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
				treeIdRefField : "upperMenuSeqno"
		}
		
		
	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom

	 auigridCol(columnLayout.labelList, cusPros);
	 columnLayout.labelList.addColumnCustom("menuNm", "메뉴명", null, true, false,McouColPros);
	 columnLayout.labelList.addColumnCustom("langCodeNm", "언어", null, false, false);
	 columnLayout.labelList.addColumnCustom("langNm", "언어명", null, false, false);

	 
	 
	 auigridCol(columnLayout.labelinfoList);
	 columnLayout.labelinfoList.addColumnCustom("langCodeNm", "언어", null, false, false);
	 columnLayout.labelinfoList.addColumnCustom("langNm", "언어명", null, true, true);
	 columnLayout.labelinfoList.addColumnCustom("useAt", "사용여부", null, true, false);
	 //columnLayout.labelinfoList.addColumnCustom("menuSeqno", "메뉴코드", null, false, false);
	 
	 columnLayout.labelinfoList.checkBoxRenderer(["useAt"], labelinfoList,  {check: "Y", unCheck: "N"} );
		 /*
	     * @param dataFields 색상 정의할 데이터필드 배열
	     * @param gridId 그리드 div 영역 id
	     * @param value 체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"} 
	     */
	     //columnLayout.menuLis.checkBoxRenderer(["useAt"], menuList,  {check: "Y", unCheck: "N"} , McouColPros);

	     
	    //그리드 생성
	 	labelList = createAUIGrid(columnLayout.labelList, labelList,cusPros);
	 	labelinfoList = createAUIGrid(columnLayout.labelinfoList, labelinfoList);
		
	}; 

	
	
	//그리드 이벤트
	function setMenuGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(labelList, "ready", function(event) {
	        gridColResize(labelList, "2");
	    });
	    
	    AUIGrid.bind(labelinfoList, "ready", function(event) {
	        gridColResize(labelinfoList, "2");
	    });

	    AUIGrid.bind(labelList, "cellClick", function(event) {
	    	$('#langNm').val(event.item.langNm);
	    	$('#nationLangCode').val(event.item.nationLangCode);
	    	searchLabinfolang(event.item);
	    	selectedData = event;
	    	console.log(event);
	    	console.log('aaaaaaa',$('#nationLangCodeSch').val());
	    	console.log(">> : ",selectedData);
		    var item = new Object();

	    		
	    });
	      
	}
	
	function setButtonEvent() {
	    /////////////////// 행 추가 //////////////////
	    $("#btn_add").click(function() {
	    	addLabel();
	    });
	    /////////////////// 행 삭제 //////////////////
	    $("#btn_remove").click(function() {
	    	removeLabel();
	    	delLabel();
	    });
		function removeLabel() {
		    AUIGrid.removeRow(labelinfoList, "selectedIndex");
		}
		
		/////////// 데이터 관리 ///////// 
		function delLabel() {
			var url = "<c:url value='/wrk/delLablang.lims'/>";
			var del = AUIGrid.getRemovedItems(labelinfoList)	
		
 		   ajaxJsonParam(url, del, function(data) {
		        if (data > 0) {
	                alert("성공적으로 삭제되었습니다.");
		        	searchLabinfolang(selectedData.item);
		       } 
		   });   

	} 
		
	    //조회
	    $('#btnSearch').click(function() {
	    	searchLablang();
	    })
	    
	    
	    //저장
	    $("#btnSave").click(function() {
	    	 var resultCount = 0;
	    	 var labellangaddedRowItems = AUIGrid.getAddedRowItems(labelinfoList);   //추가한 아이템
	    	 var labellangupdedRowItems = AUIGrid.getEditedRowItems(labelinfoList); // 수정한 아이템
	    	 var labellanggridData = AUIGrid.getGridData(labelinfoList); //출력된 데이터를 반환
	    	    console.log("addedRowItems: ", labellanggridData);
	    	    console.log("add1.", labellangaddedRowItems.length, labellangaddedRowItems)
	    	    console.log("up2.", labellangupdedRowItems.length, labellangupdedRowItems) 
	    	    
	    

	    	  
	    		 if(labellangaddedRowItems.length > 0 || labellangupdedRowItems.length > 0)	
		    	 	 savelabellang(labellangaddedRowItems,labellangupdedRowItems);
	    	      
	    	 
	    	    
	    });
		
		
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchLablang()
		    	AUIGrid.clearGridData(labelinfoList);
		    }
		});
	    
		$('#nationLangCodeSch').on('change',function() {	
			console.log('체인지',$('#nationLangCodeSch').val())
			searchLablang()
			AUIGrid.clearGridData(labelinfoList);


		});	

	
	}
	
	function addLabel() {
	    var item = new Object();
	    item.langMenuLblSeqno = $("#langMenuLblSeqno").val()
	  	item.nationLangCode = $("#nationLangCodeSch").val()
	    item.langNm = $("#langNm").val()
	    item.useAt = 'N'
	    item.gbnCrud = "C" // insert 구분값
	    item.menuSeqno = selectedData.item.menuSeqno
	    AUIGrid.addRow(labelinfoList, item, "last");
	    console.log("item", item)
	};
	
	// 조회 함수
	function searchLablang() {
	    getGridDataForm("<c:url value='/wrk/getLablang.lims'/>", "searchFrm", labelList, function(data) {
	    });
	}
	
	function searchLabinfolang(item) {
	 var naCode = $('#nationLangCodeSch').val();
		ajaxJsonParam3("<c:url value='/wrk/getLabinfolang.lims'/>", {"menuSeqno": item.menuSeqno, "nationLangCode": naCode}, function(data) {
			AUIGrid.setGridData(labelinfoList, data);
	    });
	}
	
	
	/* 저장 */
	function savelabellang(labellangaddedRowItems,labellangupdedRowItems) {
	   var url = "<c:url value='/wrk/savelabellang.lims'/>";
	   var labellangadd = labellangaddedRowItems;
	   var labellangup = labellangupdedRowItems;
	   var param = labellangadd.concat(labellangup);

 	   console.log('param',param)
       	   ajaxJsonParam(url, param, function(data) {
	            if (data > 0) {
	                alert("성공적으로 저장되었습니다.");
	                searchLabinfolang(selectedData.item);
	            }
	        });    

	    }
	
	

		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

