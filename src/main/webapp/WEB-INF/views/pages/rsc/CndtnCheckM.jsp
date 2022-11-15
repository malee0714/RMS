<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1"> 
		<h2>${msg.C000000001}</h2> <!-- 공조기점검 --> 
		<div class="btnWrap">
			<button id="btnReport" class="search btn2" >${msg.C000000003}</button> <!-- 레포트 출력 -->
			<button id="btnSearch" class="search btn3" >${msg.C000000002}</button> <!-- 조회 -->			
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
					<th>${msg.C000000004}</th> <!-- 기기 -->
					<td><select id="cndtnInspctIemCodeSch" name="cndtnInspctIemCodeSch"></select></td> 
					
					<th>${msg.C000000005}</th> <!-- 점검일자 -->
						<td style="text-align:left;">
							<input type="text" id="writngDeStart" name="writngDeStart" class="wd6p" style="min-width: 6em;"> 
							~ 
							<input type="text" id="writngDeFinish" name="writngDeFinish" class="wd6p" style="min-width: 6em;">
						</td>
						
					<th>${msg.C000000006}</th> <!-- 수리일자 -->
						<td  style="text-align:left;">
							<input type="text" id="repairDeStart" name="repairDeStart" class="wd6p" style="min-width: 6em;"> 
							~ 
							<input type="text" id="repairDeFinish" name="repairDeFinish" class="wd6p" style="min-width: 6em;">
						</td>
				</tr>
			</table>
	
		</form>
		    <div class="subCon2">
              <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
              <div id="CndtnCheckMGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
            </div>
            
           <br> 
   <div class="subCon1" id="detail">
           <h2>${msg.C000000013}</h2>  <!-- 점검항목 -->
           	<div class="btnWrap">
          	 	<button id="btn_new" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
          	 	<button id="btn_chart" class="btn3">${msg.C000000020}</button> <!-- 차트보기 -->
				<button id="btnSave" class="save btn1" >${msg.C000000015}</button> <!-- 저장 -->
			</div>
        <form id="saveFrm" name="saveFrm" onsubmit="return false" >
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
					<th>${msg.C000000004}</th> <!-- 기기 -->
					<td><select id="mhrlsSeqno" name="mhrlsSeqno"></select></td> 
	
					<th class="necessary">${msg.C000000005}</th> <!-- 점검일자 -->
						<td style="text-align:left;">
							<input type="text" id="chckDte" name="chckDte" class="wd100p" style="min-width: 10em;"> 
		
					<th>${msg.C000000012}</th> <!-- 점검자 -->
						<td  style="text-align:left;">
							<input type="text" id="insctrId" name="insctrId" class="wd36p" style="min-width: 10em;" value="${UserMVo.userNm}" readonly="readonly">
						</td>	
				</tr>
			</table>
			<input type="hidden" id="cndtnChckSeqno" name="cndtnChckSeqno">
		</form>     
			<div class="subCon2">
              <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
              <div id="tableGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
            </div>
	          
            
		</div>
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var CndtnCheckMGrid = 'CndtnCheckMGrid';
	var tableGrid = 'tableGrid';
	 var nDate = $('#chckDte').val();
	 
	

	// 그리드 데이터
	
	$(function() {
	
// 		searchTableC();
		//권한체크
		getAuth();

		$("#btn_chart").hide(); 
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setdefaultGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setdefaultGridEvent();

	    // 그리드 리사이즈
	    gridResize([CndtnCheckMGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);
	    gridResize([tableGrid]);
	    // 콤보 데이터 세팅
	    setCombo();

	    datePickerCalendar(["writngDeStart","writngDeFinish"], true, ["DD",-30], ["DD",30]);
	    datePickerCalendar(["repairDeStart","repairDeFinish"]);
	    datePickerCalendar(["chckDte"], true,["DD",0]);

	});
	
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getMhrlsVal.lims','cndtnInspctIemCodeSch',{"mhrlsClCode" : "RS02000156"}, false,"${msg.C000000079}"); /* 선택 */
		ajaxJsonComboBox('/com/getMhrlsVal.lims','mhrlsSeqno',{"mhrlsClCode" : "RS02000156"}, false,"${msg.C000000079}"); /* 선택 */

	}
	
 	// 그리드 생성
	function setdefaultGrid() {
		
		
	    //그리드 컬럼 담을 배열 정의
	    var cndCol = [];
	    var tabCol = [];	
	    auigridCol(cndCol);
	    auigridCol(tabCol);


	    //컬럼 속성 정의
	    var cndColPros = {
	    		//엑스트라체크박스 표시
	    		showRowCheckColumn : true,
	    		// 전체 체크박스 표시 설정
	    		showRowAllCheckBox : true	
	    };
	    
	    var chkColPros = {

	    };
	    
		var tabGridProps = {
				// 셀 병합 실행
				enableCellMerge : true,
				cellMerge : true,
				//selectionMode : "singleRow",
				
				// 셀 병합 정책
				// "default"(기본값) : null 을 셀 병합에서 제외하여 병합을 실행하지 않습니다.
				// "withNull" : null 도 하나의 값으로 간주하여 다수의 null 을 병합된 하나의 공백으로 출력 시킵니다.
				// "valueWithNull" : null 이 상단의 값과 함께 병합되어 출력 시킵니다.
				cellMergePolicy : "withNull",
				
				// 셀머지된 경우, 행 선택자(selectionMode : singleRow, multipleRows) 로 지정했을 때 병합 셀도 행 선택자에 의해 선택되도록 할지 여부
				rowSelectionWithMerge : true,
				
				editable : true
				
				
		};
		
		///////////////////////////////////////////////////////////////////////////
		/* 
			editRenderer 선행 변수 선언
		 */
		// 조건 렌더러 무시하고 전체 일반 인푸터 할지 여부
		var allInputEditor = false;

		var posList =  ["O", "X"];
		
		// 조건부 에디트렌더러 출력할 editRenderer 정의 1
		var myEditRenderer = {
				type : "DropDownListRenderer",
				list : posList	
		};

		
		var myEditRenderer2 = {
				type : "InputEditRenderer",
				onlyNumeric : true, // Input 에서 숫자만 가능케 설정
				//autoThousandSeparator : true,// 천단위 구분자 삽입 여부 (onlyNumeric=true 인 경우 유효)
			    allowPoint : true, // 소수점(.) 입력 가능 설정

				// 에디팅 유효성 검사
				validator : function(oldValue, newValue, item) {
					var isValid = false;
					var numVal = Number(newValue);
				/* 	if(!isNaN(numVal) && numVal < 10000000000000000) {
						isValid = true;
					} */
					isValid = true;
					// 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
					return { "validate" : isValid, "message"  : "허용 범위를 초과 하였습니다." };
				}
		};
		// 조건부 에디트렌더러 출력할 editRenderer 정의 1
		var myEditRenderer3 = {
				type : "CalendarRenderer",
				onlyCalendar : true, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
				showExtraDays : true, // 지난 달, 다음 달 여분의 날짜(days) 출력
				defaultFormat  : "yyyy-mm-dd" // 실제 데이터 형식을 어떻게 표시할지 지정
		};
		
		///////////////////////////////////////////////////////////////////////////

		var tableProps= {
			
				editRenderer : {
					type : "ConditionRenderer", // 조건에 따라 editRenderer 사용하기. conditionFunction 정의 필수
					// 컨디션함수는 자주 호출됩니다. 따라서 여기서 DOM 탐색 또는 jQuery 객체 만들기 등은 하지 마십시오.
					conditionFunction : function(rowIndex, columnIndex, value, item, dataField) {
						
			
						
						// 모든 에디터 일반 인풋으로 출력시킬지 여부 조사
						if(allInputEditor) { // 안티 코드 : document.getElementById("checked") 등. (중요: DOM 검색 하지 마십시오.)
							return;
						}
						
						// 특정 조건에 따라 미리 정의한 editRenderer 반환.
						if(item.tmprField3Value == "선택") {
							return myEditRenderer;
						} 
						
						if(item.tmprField3Value == "수치") {
							return myEditRenderer2;
						}
						
						if(item.tmprField3Value == "날짜") {
							return myEditRenderer3;
						}
						
						//-- 여기서 절대 하지 말아야 할 코드 - 안티 코드 (퍼포먼스를 위함)
						// 1. $(this), $("#abc") 와 같은 jQuery 객체 만들기 및 DOM 검색을 하지 마십시오.
						// 2. return 시키는 객체를 여기서 선언하지 마십시오.
						//    즉, return { type : "DropDownListRenderer", list : ["A", "B"] }; 이와 같은 리턴은 피하십시오.
						//    반드시 선언된 객체의 참조값(변수명)을 반환하십시오.
						// 3. 나아가 새로운 객체 선언 new Object() 등 피하십시오. 
					}				
			}
		}
		


	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom

		//cndCol.addColumnCustom("checkBox", "선택", null, true, false);
		cndCol.addColumnCustom("mhrlsClNm", "${msg.C000000007}", null, true, false); /* 기기분류  */
		cndCol.addColumnCustom("mhrlsManageNo", "${msg.C000000008}", null, true, false); /* 기기관리번호 */ 
		cndCol.addColumnCustom("manageDeptNm", "${msg.C000000009}", null, true, false); /* 관리부서 */
		cndCol.addColumnCustom("mnfcturCmpnyNm", "${msg.C000000010}", null, true, false); /* 제조회사명 */
		cndCol.addColumnCustom("mhrlsNm", "${msg.C000000011}", null, true, false); /* 기기명 */
	    cndCol.addColumnCustom("chckDte", "${msg.C000000005}", null, true, false);  /* 점검일자 */
	    cndCol.addColumnCustom("chckWeek", "${msg.C000001103}", null, false, false); /* 점검주차 */
	    cndCol.addColumnCustom("userNm", "${msg.C000000012}", null, true, false); /* 점검자 */
	   

	    /*
	     * @param dataFields 색상 정의할 데이터필드 배열
	     * @param gridId 그리드 div 영역 id
	     * @param value 체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"} 
	     */
	    
	     //cndCol.checkBoxRenderer(["checkBox"], CndtnCheckMGrid,  {check: "Y", unCheck: "N"});
	    

	    tabCol.addColumnCustom("tmprField1Value", "${msg.C000000016}", null, true, false,tabGridProps); /* 구분 */
	    tabCol.addColumnCustom("tmprField2Value", "${msg.C000000017}", null, true, false,tabGridProps); /* 점검부위 */
	    tabCol.addColumnCustom("cmmnCodeNm", "${msg.C000000018}", null, true, false); /* 점검내용 */
	    tabCol.addColumnCustom("tmprField3Value", "${msg.C000001104}", null, false, false); /* 수치 */
	    tabCol.addColumnCustom("chckResultValue", "${msg.C000000019}", null, true, true, tableProps); /* 점검결과 */
	    tabCol.addColumnCustom("messAges", "${msg.C000001105}", null, false, false); /* 주의사항 */
		
	    //그리드 생성
	    CndtnCheckMGrid = createAUIGrid(cndCol, CndtnCheckMGrid,cndColPros);
	    tableGrid = createAUIGrid(tabCol, tableGrid, tabGridProps);
	    

	}; 

	
	
	//그리드 이벤트
	function setdefaultGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(CndtnCheckMGrid, "ready", function(event) {
	        gridColResize(CndtnCheckMGrid, "2");
	    });
	    
	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(tableGrid, "ready", function(event) {
	        gridColResize(tableGrid, "2");
	    });
    
	    AUIGrid.bind(CndtnCheckMGrid, "cellClick", function(event) {
	    	var sDate = AUIGrid.getSelectedItems(CndtnCheckMGrid);
			var sItem = sDate[0].item;


	    });


	    AUIGrid.bind(CndtnCheckMGrid, "cellDoubleClick", function(event) {
	    	$("#cndtnChckSeqno").val(event.item.cndtnChckSeqno);
	    	$("#mhrlsSeqno").val(event.item.mhrlsSeqno);
	    	$("#chckDte").val(event.item.chckDte);
	    	$("#chckWeek").val(event.item.chckWeek);
	    	searchTableC();
	    	$("#btn_chart").hide(); 

	    });
	    

	    
	    AUIGrid.bind(tableGrid, "cellEditEnd", function(event) {

	    });
	    
	    AUIGrid.bind(tableGrid, "cellClick", function(event) {
	    	var mhrseq = $("#mhrlsSeqno").val();
	    	var cndtnChckSeqno = $("#cndtnChckSeqno").val();
	    	
			if(event.item.tmprField3Value == "수치"){ 
				$("#btn_chart").show(); 
			} else {
				$("#btn_chart").hide(); 
			}
			

	    	if(mhrseq == null || mhrseq == ""){
	    		alert('${msg.C000000029}') /* 기기를 먼저 선택 해 주세요 */
	    		var invalidRowIndex = -1;
	    		var colIndex;
	    		colIndex = AUIGrid.getColumnIndexByDataField(tableGrid, "tmprField1Value");
	    		AUIGrid.setSelectionByIndex(tableGrid, invalidRowIndex, colIndex);
	    		return false;
	    	}


	    });

	}
	
	function setButtonEvent() {
	    //조회
	    $('#btnSearch').click(function() {
	    	searchcndtn();
	    	searchTableC();
	    	
	    })
	    
	    //저장
	    $("#btnSave").click(function() {

     		 var url = "<c:url value='/sys/chkNo.lims'/>";
     		 var resultCount = 0;
	    	 var ConaddedRowItems = AUIGrid.getAddedRowItems(tableGrid);   //추가한 아이템
	    	 var ConupdedRowItems = AUIGrid.getEditedRowItems(tableGrid); // 수정한 아이템
	    
	    	 
	    	 var Chk = saveValidation();
	    	 if(Chk){
	    		 saveCndtnCheck(ConaddedRowItems , ConupdedRowItems);
	    	 }
	    	
	    
	    	    
	    });
	    
		$('#btn_chart').click(function(){
			var gridData = AUIGrid.getSelectedItems(tableGrid);
			var sDate = AUIGrid.getSelectedItems(CndtnCheckMGrid);
			var item = gridData[0].item;
			var sItem = sDate[0].item;

			if(item.tmprField3Value == "수치"){ 
				openPopup("/rsc/ChartM.lims?checkDte="+sItem.chckDte+"&checkItem="
						+item.cmmnCode+"&mhrlsSeqno="+sItem.mhrlsSeqno+'&writngDeStart='+$("#writngDeStart").val()
						+'&writngDeFinish='+$("#writngDeFinish").val(),"chart",{
					width : "1500",
					height: "700"
				});
			} 
/* 			 
			if(item.tmprField3Value == "선택"){
				alert('차트보기는 수치만 가능 합니다.')
			}
			
			if(item.tmprField3Value == "날짜"){
				alert('차트보기는 수치만 가능 합니다.')
			} */
			
		
		
		});
		
		// 신규 클릭 이벤트
		$('#btn_new').click(function(){
			// 폼 초기화
			pageReset(["saveFrm"], null, null, function(){
			
			});
			searchcndtn();
			AUIGrid.clearGridData(tableGrid); 
			searchTableC();
		});

		
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchcndtn()
		    }
		});
	    
		$('#mhrlsSeqno').on('change',function() {
		 $("#cndtnChckSeqno").val('');
		getGridDataForm("<c:url value='/rsc/selectmhr.lims'/>", "saveFrm", tableGrid, function(data) {
					$("#cndtnChckSeqno").val(data[0].cndtnChckSeqno);
			    }); 
			});	
		
		$("#btnReport").click(function(){
			  getRdReport(CndtnCheckMGrid);

			
		});
		
		function getRdReport(gridId){
		
			var list = AUIGrid.getCheckedRowItemsAll(gridId);
			var array = [];

 			var resultArr = new Array();
 			
 			//같은 일자(주차)를 여러개 선택 했을 경우 레포트는 하나만 출력하기 위해 사용 (같은 주차가 있으면 삭제 후 레포트는 하나만 출력)
 			for(var i=0; i<list.length; i++){

 				for(var j=0; j<i; j++){
 					
 					//중복된 데이터
 					if(list[i].chckWeek == list[j].chckWeek){
 						//중복값 제거
 						list.splice(i,1);
 						i--;
 					
 					} 
 				}
 			}

 			
 			resultArr = list;
 		
 			
 			for(var i=0; i<resultArr.length; i++){
 				array[i] = "[" + resultArr[i].chckWeek + "]"
				array[i] += " [" + resultArr[i].mhrlsSeqno + "]"
				array[i] += " [" + resultArr[i].chckDte + "]";  
			}
 	
 			if(!!resultArr.length){
				html5Viewer("/gongJoGi.mrd", array);
			
			}
			
	
		}
		
		$('#chckDte').on('change',function() {
			$("#cndtnChckSeqno").val('');
			getGridDataForm("<c:url value='/rsc/selectmhr.lims'/>", "saveFrm", tableGrid, function(data) {
				$("#cndtnChckSeqno").val(data[0].cndtnChckSeqno);
		    });
		});		

	}
	


	
	// 상단 그리드 조회 함수
	function searchcndtn() {
	    getGridDataForm("<c:url value='/rsc/getcndtn.lims'/>", "searchFrm", CndtnCheckMGrid, function(data) {
	    	
	    });
	}
	
	// 하단 그리드 조회 함수
	function searchTable() {
	    getGridDataForm("<c:url value='/rsc/getCnd.lims'/>", "searchFrm", tableGrid, function(data) {
	    	
	    });
	}
	
	// 상단 그리드 클릭시 하단 조회 함수
	function searchTableC() {
		var param = getFormParam("saveFrm")
	    getGridDataForm("<c:url value='/rsc/getCndVal.lims'/>", "saveFrm", tableGrid, function(data) {
	    	console.log(data);
	    	
	    });
	}
	

	
	function saveCndtnCheck(ConaddedRowItems,ConupdedRowItems) {
			if(!saveValidation("saveFrm")){
				return;
			}
			var gridData = AUIGrid.getGridData(CndtnCheckMGrid);

		
		   var url = "<c:url value='/rsc/saveCndtnDetail.lims'/>";
		   var obj = $("#saveFrm").serializeObject();
		   obj = Object.assign(obj, {"list" : ConupdedRowItems});


		  if(gridData.length > 0){
			  for(var j=0; j<gridData.length; j++){
				  	//마스터 그리드 날짜 값과 입력한 날짜의 값이 같고 마스터그리드 기기와 입력한 기기가 같으면 등록불가
				  if(gridData[j].chckDte == obj.chckDte && gridData[j].mhrlsSeqno == obj.mhrlsSeqno){
					  alert('해당 일자에 이미 등록된 기기 입니다.')
					  return false;
				  }
			  }
		  }

		  		customAjax({
					  "url": url,
					  "data": obj
				}).then(function(data) {
					if (data > 0) {
	 		                alert("${msg.C000000071}"); /* 저장 되었습니다. */
	 		                searchTableC();
	 		                searchcndtn();
	 		        }
				});
	
	}
	
	//유효성 검사
		function saveValidation(){
		// 저장 전 그리드의 필수 칼럼의 값 유효성 체크하기
		var groupGridData = AUIGrid.getGridData(tableGrid);
		var item;
		var dataRep = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
		var numberRep = /^[0-9]*$/;
		var rep = /^(O|X)/;
		var invalid = true;
		var invalidRowIndex = -1;
		var colIndex;
		var nm;
		
		for(var i=0, len=groupGridData.length; i<len; i++) {
			item = groupGridData[i];

			
			if(item.tmprField3Value == "선택"){				
				if(!rep.test(item["chckResultValue"])) {
					invalidRowIndex = i;
					invalid = false;
					colIndex = AUIGrid.getColumnIndexByDataField(tableGrid, "chckResultValue");
					nm = "${msg.C000000031}" /* 결과는 O,X 값으로 선택 바랍니다. */
					break;
				} 
			}
			if(item.tmprField3Value == "수치"){
				if(!numberRep.test(item["chckResultValue"])) {
					invalidRowIndex = i;
					invalid = false;
					colIndex = AUIGrid.getColumnIndexByDataField(tableGrid, "chckResultValue");
					nm = "${msg.C000000032}"  /* 결과는 숫자로만 입력 가능 합니다. */
					break;
				} 
			}
			if(item.tmprField3Value == "날짜"){
				if(!dataRep.test(item["chckResultValue"])) {
					invalidRowIndex = i;
					invalid = false;
					colIndex = AUIGrid.getColumnIndexByDataField(tableGrid, "chckResultValue");
					nm = "${msg.C000000033}"  /* 결과는 날짜 형식(XXXX-XX-XX) 값으로 선택 바랍니다. */ 
					break;
				} 
			}
		}

		 if(!invalid) {
			// 필수 칼럼의 값이 없어서 예외 처리하기
			alert(item.cmmnCodeNm+nm);
			var fa = 1;
			// 입력해야 할 셀로 셀렉션 이동 시켜 놓기
			AUIGrid.setSelectionByIndex(tableGrid, invalidRowIndex, colIndex);
			return false;
		} else {
			return true;
		} 
	}
	
		
		


</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

