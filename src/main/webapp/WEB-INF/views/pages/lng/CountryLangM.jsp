<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">국가별 언어관리</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000207}</h2><!-- 국가별 언어관리 -->
		<div class="btnWrap">
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
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
 					<th>${msg.C100000582}</th> <!-- 언어 -->
					<td><select id="nationLangCode" name="nationLangCode"></select></td> 
					<th>${msg.C100000231}</th> <!-- 기본언어 -->
					<td><input type="text" id="detailNmSch" name="detailNmSch"></td>
					<th>${msg.C100000207}</th> <!-- 국가별 언어관리 -->
					<td><input type="text" id="langNmSch" name="langNmSch"></td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td colspan="1" style="text-align:left;">
						<label><input type="radio" id="use_a" name="useAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
						<label><input type="radio" id="use_y" name="useAtSch" value="Y" >${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" id="use_n" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
			</table>
			<input type="hidden" id="langDetailSeqno" name="langDetailSeqno">
			<input type="hidden" id="langMastrSeqno" name="langMastrSeqno">
		</form>
	</div>
			
	 <div class="subCon2">
        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
         <div id="couGrid" style="width: 100%; height: 450px; margin: 0 auto;"></div>
     </div>  
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var couGrid = 'couGrid';
	var coulangList = {type : "DropDownListRenderer", list : [], keyField : "value", valueField : "key" };
	// 그리드 데이터
	
	$(function() {
		//권한체크
		getAuth();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setcouGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setcouGridEvent();

	    // 그리드 리사이즈
	    gridResize([couGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();
		
	});
	
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'nationLangCode', {'upperCmmnCode': 'SY06'}, false);
		

	}
	
 	// 그리드 생성
	function setcouGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var couCol = [];
	    auigridCol(couCol);

	    //컬럼 속성 정의
	    var couColPros = {
	    		showStateColumn : true
	    };

			couCol.addColumnCustom("langCode", "${msg.C100000903}", null, true, false,couColPros); /* 코드 */
			couCol.addColumnCustom("detailNm", "${msg.C100000231}", null, true, false,couColPros); /* 기본언어 */
			couCol.addColumnCustom("langNm", "${msg.C100000206}", null, true, true); /* 국가별언어 */
			couCol.addColumnCustom("useAt", "${msg.C100000443}", null, true, true); /* 사용여부 */
		    couCol.checkBoxRenderer(["useAt"], couGrid,  {check: "Y", unCheck: "N"} , couColPros);

		    //그리드 생성
		    couGrid = createAUIGrid(couCol, couGrid,couColPros);
	  
	}; 

	
	
	//그리드 이벤트
	function setcouGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(couGrid, "ready", function(event) {
	        gridColResize(couGrid, "2");
	    });

	    AUIGrid.bind(couGrid, "cellClick", function(event) {
	    	$('#langNm').val(event.item.langNm);
	        
	    });
	    
	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	    	searchConlang();
	    })
	    
	    //저장
	    $("#btnSave").click(function() {
	    	 var resultCount = 0;
	    	 var CoulangaddedRowItems = AUIGrid.getAddedRowItems(couGrid);   //추가한 아이템
	    	 var CoulangupdedRowItems = AUIGrid.getEditedRowItems(couGrid); // 수정한 아이템
	    	 var CoulanggridData = AUIGrid.getGridData(couGrid); //출력된 데이터를 반환

	    		 if(CoulangaddedRowItems.length > 0 || CoulangupdedRowItems.length > 0)	
		    	 	 saveCoulang(CoulangaddedRowItems,CoulangupdedRowItems); 

	    });
		    
	    
	    
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchConlang()
		    }
		});

		//콤보박스 change 함수
		$('#nationLangCode').on('change',function() {				
			searchConlang()

		});		
	}
	

	
	// 조회 함수
	function searchConlang() {
	    getGridDataForm("<c:url value='/lng/getConlang.lims'/>", "searchFrm", couGrid, function(data) {

	    });
	}
	
	/* 저장 */
	function saveCoulang(CoulangaddedRowItems,CoulangupdedRowItems) {
	   var url = "<c:url value='/lng/saveConlang.lims'/>";
	   var Coulangadd = CoulangaddedRowItems;
	   var Coulangup = CoulangupdedRowItems;
	   var param = Coulangadd.concat(Coulangup);
	   var nationLangCode = $('#nationLangCode').val()


	   	   var map = {
			   "list" : param,
			   "nationLangCode" : {"nationLangCode" : nationLangCode}
	   	}
		customAjax({"url":url,"data":map,"successFunc":function(data){
     	       if (data > 0) {
	                success("${msg.C100000765}"); /* 저장 되었습니다. */
	                searchConlang();
	            }
     	       }
	        });   

	    }	
	

	
	

		
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

