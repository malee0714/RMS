<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title"></tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!--  body 시작 -->
		<div class="subContent">
			<div class="subCon1">
				<h2>${msg.C000000814}</h2> <!--  제품관리 -->
				
				<div class="btnWrap">
					<button id="btnSearch" class="search btn3">${msg.C000000002}</button>
					<!-- 조회 -->
					<%--<button id="btn_add" class="btn4">${msg.C000000111}</button> <!-- 행추가 -->
			<button id="btn_remove" class="btn5 search">${msg.C000000112}</button> <!-- 행삭제 -->
			<button id="btnSave" class="btn1 save">${msg.C000000015}</button> <!-- 저장 --> --%>

		</div>

				<!-- Main content -->
				<form id="searchFrm" name="searchFrm" onsubmit="return false">
					<table cellpadding="0" cellspacing="0" width="100%"
						class="subTable1">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<th>${msg.C000000055}</th>
							<!-- 자사구분 -->
							<td><select id="mmnySeCodeSch" name="mmnySeCodeSch"></select></td>
							<th>${msg.C000000211}</th>
							
							
							
							
							<!-- 제품명 -->
							<td><input class="Searchinput" type="text" id="prductNmSch" name="prductNmSch"></td>
							<th>${msg.C000000212}</th>
							<!-- 제품번호 -->
							<td><input class="Searchinput" type="text" id="prductNoSch" name="prductNoSch"></td>
							<th>${msg.C000000065}</th>
							<!-- 사용여부 -->
							<td colspan="1" style="text-align: left;"><label><input
									type="radio" id="use_y" name="useAtSch" value="">${msg.C000000062}</label>
								<!-- 전체 --> <label><input type="radio" id="use_y"
									name="useAtSch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
								<label><input type="radio" id="use_n" name="useAtSch"
									value="N">${msg.C000000064}</label> <!-- 사용안함 --></td>
						</tr>
					</table>
					<input type="hidden" id="bestInspctInsttCode"
						name="bestInspctInsttCode"> <input type="hidden"
						id="canNoChk" name="canNoChk">

				</form>
				

				<div class="subCon2">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="prductUGrid"
						style="width: 100%; height: 450px; margin: 0 auto;"></div>
				</div>
				<br>
				<div class="subCon1" id="detail">
				<h2>${msg.C000000219}</h2><!-- 제품 정보  -->
					<div class="btnWrap">
						<button id="btn_new" class="btn4">${msg.C000000014}</button><!-- 신규 -->
						<button id="btndel" class="btn5">${msg.C000000097}</button> <!--삭제-->
						<button id="btnSave" class="save btn1">${msg.C000000015}</button><!-- 저장 -->
					</div>
					<form id="insttForm" name = "insttForm" >
						<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
							<tr>
								<th class="necessary">${msg.C000000055}</th>
								<!-- 자사구분 -->
								<td><select id="mmnySeCode" name="mmnySeCode"></select></td>
								<th class="necessary" >${msg.C000000211}</th>




								<!-- 제품명 -->
								<td class="necessary" ><input class="Searchsave" type="text" id="prductNm" name="prductNm"></td>
								<th>${msg.C000000212}</th>
								<!-- 제품번호 -->
								<td><input type="text" class="Searchsave" id="prductNo" name="prductNo"></td>
								<th>${msg.C000000065}</th>
								<!-- 사용여부 -->
								<td colspan="1" style="text-align: left;">
				<label><input type="radio" id="useY" name="useAt" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
				<label><input type="radio" id="useN" name="useAt" value="N">${msg.C000000064}</label> <!-- 사용안함 --></td>
									
								
							</tr>
							<tr>
								<th colspan="2">${msg.C000000666}</th>
								<td colspan="6"><input type="text" id="prductDetailNm"
									name="prductDetailNm"></td>
							</tr>
						
						</table>
					     	<input class="Searchsave"  type="hidden" id="prductUpperSeqno" name="prductUpperSeqno">
					     	<input class="Searchsave"  type="hidden" id="rowIdValue" name="rowIdValue"><!-- 그리드 내부ID값 -->
					</form>
					
					
				</div>
			</div>
		</div>
		

		<!--  body 끝 -->
	</tiles:putAttribute>

	<tiles:putAttribute name="script">
		<!--  script 시작 -->
		<script>
		
		
		var prductUGrid = 'prductUGrid';
		var lang = ${msg};
		
			$(function() {
				// 콤보 데이터 세팅asdasdasd
				setCombo();

				// 버튼 이벤트
				setButtonEvent() ;
				
				
				//메인 그리드
				setprductUGrid_Master();
				
				//디테일
				setprductUGridEvent();
		
				//vscode 단축키는 좀 다르니까 찾아보고

			});
			

			//콤보 데이터 세팅 
			function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'mmnySeCodeSch', {'upperCmmnCode': 'SY01'}, false);
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'mmnySeCode', {'upperCmmnCode': 'SY01'}, false);
			
			}
	

			
			// 메인 그리드 생성 
			function setprductUGrid_Master() {

			    //그리드 컬럼 담을 배열 정의
			    var prductCol = [];
			    auigridCol(prductCol);

			    //컬럼 속성 정의
			    var prductColPros = {
			    };

			    //그리드 속성 정의
			    var prductPros = {
			    		editRenderer : {
			    			type : "InputEditRenderer",
			    			
			    			validator : function(oldValue, newValue, item, dataField) {
			    			if(newValue != ""){
			    				if(oldValue != newValue) {
			    					// dataField 에서 newValue 값이 유일한 값인지 조사
			    					var isValid = AUIGrid.isUniqueValue(prductUGrid, dataField, newValue);
			    					
			    					 if(isValid == false){
			    						 alert('${msg.C000000137}') /* 중복값이 존재 합니다. 다시 입력해 주세요 */
			    						 return { "oldValue" : oldValue };
			    					 } else {
			    						 
			    					 }
			    				
			    				}
			    			}	
			    		}
			    	}
			    	
			    };
			    //그리드 속성 정의2
			    var prductGridPros = {
			    		rowIdField : "prductUpperSeqno",		    	
			    };
			
				
				
			    //컬럼 셋팅
			    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
			    prductCol.addColumnCustom("mmnySeCode", "${msg.C000000055}", null, true, false); /* 자사구분 */
			    prductCol.addColumnCustom("prductNm", "${msg.C000000211}", null, true, false); /* 제품명 */
			    prductCol.addColumnCustom("prductDetailNm", "${msg.C000000666}", null, true, false); /* 제품 상세명 */
			    prductCol.addColumnCustom("prductNo", "${msg.C000000212}", null, true, false); /* 제품번호 */
			    prductCol.addColumnCustom("useAt", "${msg.C000000065}", null, true, false); /* 사용여부 */
			    prductCol.addColumnCustom("deletebtn","${msg.C000000097}", null, false, false); /* 삭제여부 */
			    prductCol.addColumnCustom("prductUpperSeqno","no", null, false, false); 


			  
			    /*
			     * @param dataFields 색상 정의할 데이터필드 배열
			     * @param gridId 그리드 div 영역 id
			     * @param value 체크시 값과 체크해제시 값을 다르게 주고 싶을 때 ex) {check: "Y", unCheck: "N"} 
			     */
				var mSeCode;
				var mmnySeCode =["mmnySeCode"]
				var deletebtn = ["deletebtn"]
				comboAjaxJsonParam('/com/getCmmnCode.lims', {'upperCmmnCode': 'SY01'}, function(data){
						mSeCode = data; 
				}, null, false);
					
				 prductCol.dropDownListRenderer(mmnySeCode, mSeCode, true, null);
				 prductCol.buttonRenderer(deletebtn, this.btnGrid1delete,true, "${msg.C000000112}", true, null);
				 
			    //그리드 생성
			    prductUGrid = createAUIGrid(prductCol, prductUGrid,prductGridPros);
				 $(".aui-grid-button-renderer").css({
					    "background-color": "#000000",
					    "color": "#eee",
					    "border-radius":"5px",
					    "font-size": "12px",
					    "transition-property": "background-color",
					    "transition-duration": "0.5s",
					    "width": "80px"});
				
			}
			
			// 행삭제 
			function btnGrid1delete(rowIndex, columnIndex, value, item){
				var reVal = confirm("${msg.C000000178}"); /*삭제하시겠습니까?*/
				if(reVal == true){
					var url = "<c:url value='/wrk/delPrductUppFM.lims'/>";
					var del = AUIGrid.getRemovedItems(prductUGrid)	
				
				   ajaxJsonParam(url, item, function(data) {
				        if (data > 0) {
				        	alert("${msg.C000000179}"); /* 저장 되었습니다. */
				        	searchprductU();
				       } 
				   });  
					
				}
				reset();
				
				  
			}

			// 디테일 그리드 생성 
			function setprductUGridEvent() {
				
				gridResize([prductUGrid]);
				
				
				AUIGrid.bind(prductUGrid, "ready", function(event) {
					gridColResize([prductUGrid ],"2");	// 1, 2가 있으니 화면에 맞게 적용
				});
				  AUIGrid.bind(prductUGrid, "cellDoubleClick", function(event) {
				    $("#mmnySeCode").val(event.item.mmnySeCode);
					$("#prductNm").val(event.item.prductNm);
			    	$("#prductDetailNm").val(event.item.prductDetailNm);
			    	$("#prductNo").val(event.item.prductNo);
			        $("#prductUpperSeqno").val(event.item.prductUpperSeqno);
			        $("#useAt").val(event.item.useAt);
			        $("#rowIdValue").val(event.rowIdValue);//그리드 내부 row ID값  
			    	
			    	if(event.item.useAt == 'Y'){ 
						$("#useY").val(event.item.useAt).prop("checked", true);
					}else{
						$("#useN").val(event.item.useAt).prop("checked", true);
					}
				  
				  
				 });
				
			
			}
				
			
			
			function setButtonEvent() {
			    //조회
			    $('#btnSearch').click(function() {
			    	searchprductU();
			    })
			    
			  	    
			  
			    
			    //엔터키 이벤트(Search)
				$(".Searchinput").keypress(function (e) {
				    if (e.which == 13){
				    	searchprductU()
				    }
				});

 				//엔터키 이벤트(save)
 					$(".Searchsave").keypress(function (e) {
				    if (e.which == 13){
						var prductNm = document.getElementById('prductNm').value;
						if(prductNm =="" || null){
							alert("제품 명는(은) 필수 정보 입니다.")

						}else{

						saveprduct()
						}


				    }
				});

			    
				// 신규 클릭 이벤트
				$('#btn_new').click(function(){
					
					reset();
				});

				//삭제
				$('#btndel').click(function(){
					delQualfStdr();
	 			   });
				
			    
				//저장
				$('#btnSave').click(function(){
					if(!formNecessaryValidationCheck("insttForm")){
						return false;
					}
					
					saveprduct();
			    });
			    
			    

			}
			
			
			// 조회 함수
			function searchprductU() {
			    getGridDataForm("<c:url value='/wrk/getPrductUppFM.lims'/>", "searchFrm", prductUGrid, function(data) {
			    	
			    });
			}
			// 디테일 리셋
			function reset(){
				pageReset(["insttForm"], null, null, function(){
				  
				});


			}
				// 삭제 함수
			function delQualfStdr() {
	 		  	 var deltUrl = "<c:url value='/wrk/delPrductUppFM.lims'/>";
	   			 var param = getFormParam('insttForm');
	   			  ajaxJsonParam(deltUrl, param, function(data) {
	        	if (data > 0) {
	        		// searchprductU();
					reset();
	           		 alert("${msg.C000000179}"); /* 삭제되었습니다.*/ 
	           		delGrid(prductUGrid,param); /* 그리드삭제 함수 */
	      	 		 }
	   			 }); 
			}
			
			// 저장 함수
			function saveprduct(){
				 var savetUrl ='/wrk/savePrductUppFM.lims';
				 var param = getFormParam("insttForm");

				  ajaxJsonParam3(savetUrl, param, function(data) {
				        if (data > 0) {
				            alert("${msg.C000000071}"); // 저장 되었습니다.
				            if(param.rowIdValue != null && param.rowIdValue != ''){
				            	updateGrid(prductUGrid,param);//수정시 그리드 update 평션
				            }
				        }else{

				            alert("중복값이 있습니다."); // 중복 값이 있습니다
						}
				    });   
			}
			
			// 그리드삭제 함수
			/*
			gridId : 삭제할 그리드 ID값 
			param : 삭제할 로우 데이터
			param.rowIdValue : 삭제될 row Id 값
			*/
			function delGrid(gridId,param) {
				AUIGrid.removeRowByRowId(gridId,param.rowIdValue)
			}
			
			// 그리드update 함수
			/*
			gridId : update할 그리드 ID값 
			param : update할 로우 데이터
			*/
			function updateGrid(gridId,param) {
				AUIGrid.updateRowsById(gridId,param)
			}
		
			
			
		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>

