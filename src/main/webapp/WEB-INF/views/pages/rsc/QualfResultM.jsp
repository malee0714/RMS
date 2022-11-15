<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000453}</h2> <!-- 사용자 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" name="searchFrm" onsubmit="return false" >
			<input type="hidden" id="qualfmanManageAt" name="qualfmanManageAt" value="Y">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 15%"></col>
					<col style="width: 10%"></col>
					<col style="width: 40%"></col>
				</colgroup>
				<tr>
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
					<th>${msg.C100000400}</th> <!-- 부서 -->
					<td><select id="deptCodeSch" name="deptCodeSch"></select></td>
					<th>${msg.C100000451}</th> <!-- 사용자 -->
					<td><input type="text" id="userNmSch" name="userNmSch"></td>
				</tr>
			</table>

		</form>
		</div>
		    <div class="subCon2">
              <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
              <div id="QualfUserGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
            </div>


	</br>
	<form id="gridTabForm" name ="gridTabForm" onsubmit = "return false">
	<div class="subCon1" id="detail">
		<h2><i class="fi-rr-apps"></i>${msg.C100000457}</h2> <!-- 사용자-자격인정/적격성평가-->
		<div class="btnWrap">
			<input type="hidden" id="btn_record_hidden"><!-- 이력보기  -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
		
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
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td><select id="bplcCode" name="bplcCode" readonly="readonly"></select></td>

					<th>${msg.C100000401}</th> <!-- 부서명 -->
					<td><input type="text" id="deptNm" name="deptNm" readonly></td>

					<th>${msg.C100000452}</th> <!-- 사용자 명 -->
					<td><input type="text" id="userNm" name="userNm" readonly="readonly"></td>
					<input type="hidden" id = "userId" name="userId">

					<th>${msg.C100000697}</th> <!-- 입사일자 -->
					<td><input type="text" id="encpn" name="encpn" readonly="readonly"></td>
				</tr>
				<tr>
					<th>${msg.C100000696}</th> <!-- 입사연차 -->
					<td><input type="text" id="diffYear" name="diffYear" readonly="readonly"></td>

					<th class= "necessary">${msg.C100000119}</th> <!-- 갱신일자 -->
					<td><input type="text" id="reformDte" name="reformDte" required></td>
					<input type="hidden" id = "oldReformDte" name = "oldReformDte">
					<td colspan="4"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
				</tr>
			</table>
			<input type="hidden" id ="deptCode" name= "deptCode"></input>
			<input type="hidden" id = "qualfElgblSeCode" name = "qualfElgblSeCode"></input>

</div>
	<div id="tabMenuLst" class="tabMenuLst round skin-peter-river mgT20">
		<ul id="tabs">
		      <li id="tab1" class="tabMenu on">${msg.C100000708}</li> <!-- 자격인정 -->
	          <li id="tab2" class="tabMenu">${msg.C100000768}</li> <!-- 적격성평가 -->
	    </ul>
	</div>

		<div id="tabCtsLst">
	   	<div id="tabCts1" class="tabCts">
	   		<div class="subCon1">
	   			<div class="btnWrap" style="position : relative; top:-10px; float:right" >
					<button type="button" id="btnTab1AddRow" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
					<button type="button" id="btnTab1RemoveRow" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
				</div>
		   		<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
			   		<colgroup>
							<col style="width:10%"></col>
							<col style="width:40%"></col>
							<col style="width:10%"></col>
							<col style="width:40%"></col>
					</colgroup>
			   		<tr>
			   			<th id = "thQualfJdgmntSeqno">${msg.C100000711}</th>
			   			<td><select id ="qualfJdgmntSeqno" name ="qualfJdgmntSeqno"></select></td>
				   		<th>${msg.C100000872}</th>
				   		<td><input type="text" class="comma"  id="qualfTotScore" name = "qualfTotScore" readonly></td>
			   		</tr>
		   		</table>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="QualfResultCertGrid" style="width:100%; height:300px; margin:0 auto;" class="grid"></div>
			</div>
		</div>
		<div id="tabCts2" class="tabCts"  style="display:none">
<!-- 		<div class = "subContent"> -->
			<div class="subCon1">
				<div class="btnWrap" style="position : relative; top:-10px; float:right" >
					<button type="button" id="btnTab2AddRow" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
					<button type="button" id="btnTab2RemoveRow" class="delete btn5"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
				</div>
				<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
			   		<colgroup>
							<col style="width:10%"></col>
							<col style="width:40%"></col>
							<col style="width:10%"></col>
							<col style="width:40%"></col>
					</colgroup>
			   		<tr>
			   			<th id = "thElgblJdgmntSeqno">${msg.C100000711}</th>
			   			<td><select id ="elgblJdgmntSeqno" name ="elgblJdgmntSeqno" ></select></td>
				   		<th>${msg.C100000872}</th>
				   		<td><input type="text" class="comma" id="elgblTotScore" name = "elgblTotScore" readonly></td>
			   		</tr>
		   		</table>
	   		</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="QualfResultAbilityGrid" style="width:100%; height:300px; margin:0 auto;" class="grid"></div>
			</div>
		</div>
	</div>
	<input type="hidden"  id = "qualfStdrRegistSeqno" name = "qualfStdrRegistSeqno">
	
</form>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
	var QualfUserGrid = 'QualfUserGrid';
	var QualfResultCertGrid = 'QualfResultCertGrid';
	var QualfResultAbilityGrid = 'QualfResultAbilityGrid';
	var calcDate;
	var lang = ${msg};  //기본언어
	var abilityList = getGridComboList("/rsc/getAbility.lims",null, false); // 기준구분 list
	var skillList = getGridComboList("/rsc/getSkill.lims",null, false);
	$(function() {
		//권한체크
		getAuth();

		tabGridResize();
	    // 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setQualfStdrRegGrid();
		 
	    setQualfResultCertGrid();
	    
	    setQualfResultAbilityGrid();

	    // 버튼 이벤트
	    setButtonEvent();

	    // 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	    setQualfStdrRegGridEvent();
	    
	    setQualfResultCertGridEvent();
	    
	    setQualfResultAbilityGridEvent();

	    // 그리드 리사이즈
	    gridResize([QualfUserGrid,QualfResultCertGrid,QualfResultAbilityGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);

	    // 콤보 데이터 세팅
	    setCombo();

	    popUpEv();
		$("#tab1").click();
		
// 		$("#bplcCodeSch").change();

	});
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc
		ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}','eblgblEvlAt':'Y'}, true, null, '${UserMVo.deptCode}');
		datePickerCalendar(["reformDte"], true, ["DD",0], ["DD",0]);
		ajaxJsonComboBox('/rsc/getQualfList.lims','qualfJdgmntSeqno',null,false,"${msg.C100000480}"); /* 선택 */
		ajaxJsonComboBox('/rsc/getElgblList.lims','elgblJdgmntSeqno',null,false,"${msg.C100000480}"); /*선택 */
		ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{"bestInspctInsttAt" : "Y", isRdmsIp : true},true,null,'${UserMVo.bestInspctInsttCode}');
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'authorSeCode', { 'upperCmmnCode' : 'SY09' }, null, null, null, null, function(e) {
			//일반사용자인 경우 권한 선택 안되도록
			if('SY09000003' == '${UserMVo.authorSeCode}')
				$('#authorSeCode').prop('disabled', true);
		});

	}

 	// 그리드 생성
	function setQualfStdrRegGrid() {
		var numberColPros_n = {
				dataType : "numeric",
				formatString : "#,##0",
				editRenderer : {
					onlyNumeric : true,
					maxlength : 10
				}
		};
	    //그리드 컬럼 담을 배열 정의
	    var QualfUserCol = [];
	    auigridCol(QualfUserCol);

			QualfUserCol.addColumnCustom("bplcCode", "사업장", null, false, false); /* 사업장 */
			QualfUserCol.addColumnCustom("bplcCodeNm", "사업장", null, true, false); /* 사업장 */
		    QualfUserCol.addColumnCustom("deptNm", "${msg.C100000400}", null, true, false); /* 부서 */
		    QualfUserCol.addColumnCustom("deptCode", "${msg.C100000401}", null, false, false); /* 부서명 */
		    QualfUserCol.addColumnCustom("userId", "사용자 ID", null, false, false); /* 사용자 ID */
		    QualfUserCol.addColumnCustom("userNm", "${msg.C100000452}", null, true, false); /* 사용자 명 */
		    QualfUserCol.addColumnCustom("encpn", "${msg.C100000697}", null, true, false); /* 입사일자 */
		    QualfUserCol.addColumnCustom("diffYear", "${msg.C100000696}", null, true, false); /* 입사연차 */
		    QualfUserCol.addColumnCustom("reformDte", "${msg.C100000119}", null, true, false); /* 갱신일자 */
		    QualfUserCol.addColumnCustom("qualfTotScore", "${msg.C100000710}", null, true, false,numberColPros_n); /* 자격인정 총점 */
		    QualfUserCol.addColumnCustom("qualfJdgmntNm", "${msg.C100000709}", null, true, false); /* 자격인정 결과 */
		    QualfUserCol.addColumnCustom("elgblTotScore", "${msg.C100000770}", null, true, false,numberColPros_n); /* 적격성평가 총점 */
		    QualfUserCol.addColumnCustom("elgblJdgmntNm", "${msg.C100000769}", null, true, false); /* 적격성평가 결과*/
		    QualfUserCol.addColumnCustom("record", "${msg.C100000994}", "7%", true, false); /* 평가 이력*/
		    QualfUserCol.addColumnCustom("qualfStdrRegistSeqno", "일련번호",null, false, false); /* 적격성평가 결과*/
		    QualfUserCol.buttonRenderer(["record"],
								    		function(){$("#btn_record_hidden").click();}
								    		,false,"${msg.C100000995}")
		    //그리드 생성
		    QualfUserGrid = createAUIGrid(QualfUserCol, QualfUserGrid);
	    // 그리드 리사이즈
	};

 	// 그리드 생성 tab1
	function setQualfResultCertGrid() {

	    //그리드 컬럼 담을 배열 정의
	    var QualfResultCertCol = [];
	    auigridCol(QualfResultCertCol);
	    var gridColPros = {
	    		style : "my-require-style",
	    		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
	    			show : true,
	    			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
	    		}
    	};
	    var dropDownPros = {
	    		enableClipboard : true
	    }
		var numberColPros_n = {
				dataType : "numeric",
				formatString : "#,##0",
				editRenderer : {
					onlyNumeric : true,
					maxlength : 10
				}
		};

		
		
	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		    QualfResultCertCol.addColumnCustom("qualfStdrSeSeqno", "${msg.C100000236}", null, true, false); /* 기준 구분*/
		    QualfResultCertCol.addColumnCustom("stdrSeDetailNm", "${msg.C100000704}", null, true, true,gridColPros); /*자격 요건 명 */
		    QualfResultCertCol.addColumnCustom("score", "${msg.C100000787}", null, true, true,numberColPros_n); /* 점수 */
		    QualfResultCertCol.addColumnCustom("qualfStdrSeResultSeqno", "일련번호", null, false, false); /* 일련번호 */
		    QualfResultCertCol.inputEditRenderer(["score"],{onlyNumeric : true, textAlign : "right", autoThousandSeparator : true})
// 		    QualfResultCertCol.comboBoxRenderer([ "qualfStdrSeSeqno" ], getGridComboList("/rsc/getSkill.lims",null, false), true, null);
		    QualfResultCertCol.dropDownListRenderer(["qualfStdrSeSeqno"], skillList, true, null);
		    //그리드 생성
		    QualfResultCertGrid = createAUIGrid(QualfResultCertCol, QualfResultCertGrid,dropDownPros);

	};

	function setQualfResultAbilityGrid() {

	    //그리드 컬럼 담을 배열 정의
	    var QualfResultAbilityCol = [];
	    var gridColPros = {
	    		style : "my-require-style",
	    		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
	    			show : true,
	    			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
	    		}
    	};
	    var dropDownPros = {
	    		enableClipboard : true
	    }
	    auigridCol(QualfResultAbilityCol);

	    //컬럼 셋팅
	    //addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		    QualfResultAbilityCol.addColumnCustom("qualfStdrSeSeqno", "${msg.C100000236}", null, true, false); /* 기준 구분 명 */
		    QualfResultAbilityCol.addColumnCustom("stdrSeDetailNm", "${msg.C100000704}", null, true, true, gridColPros); /*자격 요건 명 */
		    QualfResultAbilityCol.addColumnCustom("score", "${msg.C100000787}", null, true, true); /* 점수 */
		    QualfResultAbilityCol.addColumnCustom("qualfStdrSeResultSeqno", "일련번호", null, false, false); /* 일련번호 */
// 		    QualfResultAbilityCol.comboBoxRenderer([ "qualfStdrSeSeqno" ], getGridComboList("/rsc/getAbility.lims",null, false), false, null);
		    QualfResultAbilityCol.dropDownListRenderer(["qualfStdrSeSeqno"], abilityList, true, null);
		    QualfResultAbilityCol.inputEditRenderer(["score"],{onlyNumeric : true, textAlign : "right", autoThousandSeparator : true})
	
	
		    //그리드 생성
		    QualfResultAbilityGrid = createAUIGrid(QualfResultAbilityCol, QualfResultAbilityGrid,dropDownPros);
	};



	//그리드 이벤트
	function setQualfStdrRegGridEvent() {

	    // ready는 화면에 필수로 구현 할 것
	    AUIGrid.bind(QualfUserGrid, "ready", function(event) {
// 	        gridColResize(QualfUserGrid, "2");
	    });


	    AUIGrid.bind(QualfUserGrid, "cellDoubleClick", function(event) {
	    	var tabClass = document.getElementsByClassName("on");
	    	var list;
	    	detailAutoSet({
				"item" : event["item"],
				"targetFormArr" : ["gridTabForm"],
				"successFunc": function(){
					//새로 날짜를 갱신하는지 갱신할경우 새로운  등록테이블에대한 insert
					$("#oldReformDte").val($("#reformDte").val());

				}
			})
			schSelectedTab("tab1");
	    	schSelectedTab("tab2");
	    });
	}
	function setQualfResultCertGridEvent(){

		AUIGrid.bind(QualfResultCertGrid, "cellEditEnd", function(event) {
			var headerText = AUIGrid.getSelectedItems(QualfResultCertGrid)[0].headerText;
			var total = 0;
			var gridItem = AUIGrid.getGridData(QualfResultCertGrid)
			var gridLen = gridItem.length
			
			if(headerText=="${msg.C100000787}"){
				for(var i=0; i<gridLen; i++){
					if(gridItem[i].score == ""|| gridItem[i].score == null){
						gridItem[i].score = 0;
					}
					total += parseInt(gridItem[i].score)
				}
				total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("#qualfTotScore").val(total);
			}
	    });
		
		AUIGrid.bind(QualfResultCertGrid, "cellEditEndBefore", function(event) {
			if (event.dataField === "qualfStdrSeSeqno" && event.which === "clipboard") {
				
				var inputValue = event.value.trim();
				
				var findByValue = skillList
					.filter(function (data) {
						return data.key === inputValue || data.value === inputValue;
					})
					.map(function (data) {
						return data.value;
					});
				;
				
				return (findByValue.length > 0) ? findByValue[0] : ''; 
			}
        });
	}
	function setQualfResultAbilityGridEvent(){
		AUIGrid.bind(QualfResultAbilityGrid, "cellEditEnd", function(event) {
			var headerText = AUIGrid.getSelectedItems(QualfResultAbilityGrid)[0].headerText;
			var total = 0;
			var gridItem = AUIGrid.getGridData(QualfResultAbilityGrid)
			var gridLen = gridItem.length
			if(headerText=="${msg.C100000787}"){
				for(var i=0; i<gridLen; i++){
					if(gridItem[i].score == ""|| gridItem[i].score == null){
						gridItem[i].score = 0;
					}
					total += parseInt(gridItem[i].score)
				}
				total = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("#elgblTotScore").val(total);
			}
	    });
		AUIGrid.bind(QualfResultAbilityGrid, "cellEditEndBefore", function(event) {
			if (event.dataField === "qualfStdrSeSeqno" && event.which === "clipboard") {
				
				var inputValue = event.value.trim();
				
				var findByValue = abilityList
					.filter(function (data) {
						return data.key === inputValue || data.value === inputValue;
					})
					.map(function (data) {
						return data.value;
					});
				;
				
				return (findByValue.length > 0) ? findByValue[0] : ''; 
			}
        });
	}

	function setButtonEvent() {

	    //조회
	    $('#btnSearch').click(function() {
	        searchList();
	    })

	    $("#btnSave").click(function() {
	    	unComma(["elgblTotScore","qualfTotScore"]);
	    	var oldReform = $("#oldReformDte").val();
	    	var reform = $("#reformDte").val();

			var saveUrl ='/rsc/saveQualfResult.lims';
			var updUrl ='/rsc/updQualfResult.lims';
		    var param = getFormParam("gridTabForm");
		    var qualfEditList = AUIGrid.getEditedRowItems(QualfResultAbilityGrid);//행 수정 데이터
			var qualfRemoveList = AUIGrid.getRemovedItems(QualfResultAbilityGrid);//행 삭제 데이터
			var elgblEditList = AUIGrid.getEditedRowItems(QualfResultCertGrid);//행 수정 데이터
			var elgblRemoveList = AUIGrid.getRemovedItems(QualfResultCertGrid);//행 삭제 데이터
			var MasterValid = AUIGrid.getSelectedItems(QualfUserGrid).length

			var editedRowList = qualfEditList.concat(elgblEditList);
			var removedRowList = qualfRemoveList.concat(elgblRemoveList);

			var qualfValid = AUIGrid.getGridData(QualfResultCertGrid);
			var elgblValid = AUIGrid.getGridData(QualfResultAbilityGrid);

			var item;

			if(MasterValid<1){
				alert("${msg.C100000766}");  /* 저장할 사용자를 선택해 주세요. */
				return false;
			}


			if(qualfValid.length>0){
// 				$("#qualfJdgmntSeqno").prop("required",true);
				for(var i=0; i<qualfValid.length; i++){
				 	item = qualfValid[i]
				 	if(typeof item["qualfStdrSeSeqno"] == "undefined" || String(item["qualfStdrSeSeqno"]).trim() == "") {
						var invalidRowIndex = i;
						var colIndex = AUIGrid.getColumnIndexByDataField(QualfResultAbilityGrid, "qualfStdrSeSeqno");
						$("#tab1").click();
						AUIGrid.setSelectionByIndex(QualfResultAbilityGrid, invalidRowIndex, colIndex);
						warn("${msg.C100000242}");  /* 기준 명을 입력해 주십시오. */
						return false;
						break;
					}
				 	if(typeof item["stdrSeDetailNm"] == "undefined" || String(item["stdrSeDetailNm"]).trim() == "") {
						var invalidRowIndex = i;
						var colIndex = AUIGrid.getColumnIndexByDataField(QualfResultAbilityGrid, "stdrSeDetailNm");
						$("#tab1").click();
						AUIGrid.setSelectionByIndex(QualfResultAbilityGrid, invalidRowIndex, colIndex);
						warn("${msg.C100000996}");  /* 자격 요건명을 입력해 주세요. */
						return false;
						break;
					}
				}
			}
			if(elgblValid.length>0){
// 				$("#elgblJdgmntSeqno").prop("required",true);
				for(var i=0; i<elgblValid.length; i++){
				 	item = elgblValid[i]
				 	if(typeof item["qualfStdrSeSeqno"] == "undefined" || String(item["qualfStdrSeSeqno"]).trim() == "") {
						var invalidRowIndex = i;
						var colIndex = AUIGrid.getColumnIndexByDataField(QualfResultCertGrid, "qualfStdrSeSeqno");
						$("#tab2").click();
						AUIGrid.setSelectionByIndex(QualfResultCertGrid, invalidRowIndex, colIndex);
						warn("${msg.C100000242}");  /* 기준 명을 입력해 주십시오. */
						return false;
						break;
					}
				 	if(typeof item["stdrSeDetailNm"] == "undefined" || String(item["stdrSeDetailNm"]).trim() == "") {
						var invalidRowIndex = i;
						var colIndex = AUIGrid.getColumnIndexByDataField(QualfResultCertGrid, "stdrSeDetailNm");
						$("#tab2").click();
						AUIGrid.setSelectionByIndex(QualfResultCertGrid, invalidRowIndex, colIndex);
						warn("${msg.C100000996}");  /* 자격 요건명을 입력해 주세요. */
						return false;
						break;
					}
				}
			}

			if(!saveValidation("gridTabForm"))return false;
			//갱신일자가 다르면 INSERT 기존 (최종여부 'N')
		    if(reform != oldReform){
		    	var qualfGridData = AUIGrid.getGridData(QualfResultAbilityGrid);
				var elgblGridData = AUIGrid.getGridData(QualfResultCertGrid);
				var resultGridList = qualfGridData.concat(elgblGridData);
		    	param.resultGridList = resultGridList;
		    	 customAjax({"url":saveUrl,"data":param,"successFunc":function(data) {
			        	if (data > 0) {
			        		$('#gridTabForm')[0].reset();
				            success("${msg.C100000762}"); /* 저장 되었습니다. */
				            searchList();
				            AUIGrid.clearGridData(QualfResultCertGrid);
				            AUIGrid.clearGridData(QualfResultAbilityGrid);
			        	}
					}
					});
		    }
		  //갱신일자 변동없을경우 UPDATE
		    if(reform == oldReform){
		    	var qualfGridData = AUIGrid.getAddedRowItems(QualfResultAbilityGrid);
				var elgblGridData = AUIGrid.getAddedRowItems(QualfResultCertGrid);
				var resultGridList = qualfGridData.concat(elgblGridData);
		    	param.resultGridList = resultGridList;
		    	param.editedRowList = editedRowList;
				param.removedRowList = removedRowList;
		   	 customAjax({"url":updUrl,"data":param,"successFunc":function(data) {
		        	if (data > 0) {
		        		$('#gridTabForm')[0].reset();
			            success("${msg.C100000762}"); /* 저장 되었습니다. */
			            searchList();
			            AUIGrid.clearGridData(QualfResultCertGrid);
			            AUIGrid.clearGridData(QualfResultAbilityGrid);
		        	}
				}
				});
	    }
	    });

	    /////////////////// 행 추가 //////////////////
	    $("#btnTab1AddRow").click(function() {
	        Tab1add();
	    });
	    $("#btnTab2AddRow").click(function() {
	    	Tab2add();
	    });
	    /////////////////// 행 삭제 //////////////////
	    $("#btnTab1RemoveRow").click(function() {
	    	Tab1remove();
  	    });
	    $("#btnTab2RemoveRow").click(function() {
	    	Tab2remove();
	    });
	    //엔터키 이벤트
		$("input").keypress(function (e) {
		    if (e.which == 13){
		    	searchList()
		    }
		});
	  //조회폼 사업장 변경 이벤트
		$("#bplcCodeSch").change(function(){
			var param = $("#bplcCodeSch").val();

			ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'deptCodeSch', {'bestInspctInsttCode' : param,'eblgblEvlAt':'Y'}, true, null, '${UserMVo.deptCode}');
		});
		$("#btn_record_hidden").click(function(){
			var gridData = AUIGrid.getSelectedItems(QualfUserGrid);
			var params = {
					userId : $("#userId").val()
			};
		})
	}

	function Tab1add() {
	    var item = new Object();
	    var len = "";
	    AUIGrid.addRow(QualfResultCertGrid, item, "last");
	   	len = AUIGrid.getGridData(QualfResultCertGrid).length;
	   	
	   	if(len>0){
	   		$("#qualfJdgmntSeqno").prop("required",true);
			$("#thQualfJdgmntSeqno").addClass("necessary");
	   	} 
	};
	function Tab2add() {
	    var item = new Object();
	    var len = "";
	    AUIGrid.addRow(QualfResultAbilityGrid, item, "last");
	    len = AUIGrid.getGridData(QualfResultCertGrid).length;
	    if(len>0){
	    	$("#elgblJdgmntSeqno").prop("required",true);
			$("#thElgblJdgmntSeqno").addClass("necessary");
	   	} 
	};
	function Tab1remove() {
	    AUIGrid.removeRow(QualfResultCertGrid, "selectedIndex");
	    var total = 0;
		var gridLen = AUIGrid.getGridData(QualfResultCertGrid).length
		for(var i=0; i<gridLen; i++){
			if(AUIGrid.getGridData(QualfResultCertGrid)[i].score != null)
			total += parseInt(AUIGrid.getGridData(QualfResultCertGrid)[i].score)
		}
		$("#qualfTotScore").val(total);
		if(gridLen<1){
			$("#qualfJdgmntSeqno").prop("required",false);
			$("#thQualfJdgmntSeqno").removeClass("necessary");	
		}
	}
	function Tab2remove() {
	    AUIGrid.removeRow(QualfResultAbilityGrid, "selectedIndex");
	    var total = 0;
		var gridLen = AUIGrid.getGridData(QualfResultAbilityGrid).length
			for(var i=0; i<gridLen; i++){
				if(AUIGrid.getGridData(QualfResultAbilityGrid)[i].score != null)
				total += parseInt(AUIGrid.getGridData(QualfResultAbilityGrid)[i].score)
			}
			$("#elgblTotScore").val(total);
			if(gridLen<1){
				$("#elgblJdgmntSeqno").prop("required",false);
				$("#thElgblJdgmntSeqno").removeClass("necessary");	
			}
	}

	// 조회 함수
	function searchList(callBack) {
	    getGridDataForm("<c:url value='/rsc/getQualfStdrReg.lims'/>", "searchFrm", QualfUserGrid, function(data) {

			if( typeof callBack == "function" ){
				callBack();
			}

	    });

	}

	function schSelectedTab(tabsId){
		if(tabsId=="tab1"){
			var gridId = QualfResultCertGrid;
			$("#qualfElgblSeCode").val('RS13000001');
		}
		else {
			var gridId = QualfResultAbilityGrid;
			$("#qualfElgblSeCode").val('RS13000002');
		}

		getGridDataForm("<c:url value='/rsc/getQualfElgblList.lims'/>", "gridTabForm", gridId,function(data){
			if(data.length>0){
				if(tabsId=="tab1"){
					$("#qualfJdgmntSeqno").prop("required",true);
					$("#thQualfJdgmntSeqno").addClass("necessary");
				} else {
					$("#elgblJdgmntSeqno").prop("required",true);
					$("#thElgblJdgmntSeqno").addClass("necessary");
				}
			}
			else{
				if(tabsId=="tab1"){
					$("#qualfJdgmntSeqno").prop("required",false);
					$("#thQualfJdgmntSeqno").removeClass("necessary");
				}
				else{
					$("#elgblJdgmntSeqno").prop("required",false);
					$("#thElgblJdgmntSeqno").removeClass("necessary");
				}
			}
		});
	}
	function popUpEv(){
		
		dialogUserQualfRecDialog("btn_record_hidden", "QualfRecDialog","#QualfUserGrid");
		
	}





</script>
<!--  script 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>

