<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000509}</h2>  <!-- 소모품 사용 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
					<th>${msg.C100000336}</th> <!-- 바코드-->
					<td><input type="text" id="brcdSch" name="brcdSch" class="wd100p schClass" maxlength="50" ></td>
					<th>${msg.C100000432}</th> <!-- 사업 장  -->
					<td>
						<select id="bplcCodeSch" name="bplcCodeSch">
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td> 	
					<th>${msg.C100000811}</th> <!-- 제품분류 -->
					<td>
						<select id="prductClCodeSch" name="prductClCodeSch"  onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td> 
					<th>${msg.C100000809}</th> <!-- 제품 명  -->
					<td><input type="text" id="prductNmSch" name="prductNmSch" class="schClass" maxlength = "200"></td>
				</tr>

			</table>
		</form>
	</div>
	<div class="subCon2">
		<div>
			<div id="cmpdsUseMaster"></div>
		</div>
	</div>
	<div class="subCon1 mgT20">
		<h2><i class="fi-rr-apps"></i>${msg.C100000510}</h2> <!-- 소모품 사용 정보 -->
		<div class="btnWrap">
			<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button id="btnDelete" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="CmpdsUseFrm" name="CmpdsUseFrm">
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
	 			<th class="necessary">${msg.C100000336}</th> <!--바코드-->
					<td><input type="text" id="brcd" name="brcd" class="wd100p" maxlength = "50" required ></td>
				<th>${msg.C100000432}</th> <!-- 사업 장 -->
				<td>
					<select id="bplcCode" name="bplcCode">
					<option value=''>${msg.C100000480}</option> <!-- 선택 -->
					</select>
				</td> 	
				<th>${msg.C100000811}</th> <!-- 제품 분류 -->
					<td>
						<select id="prductClCode" name="prductClCode" onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
						<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td> 
						<th>${msg.C100000809}</th> <!-- 제품 명  -->
					<td><input type="text" id="prductNm" name="prductNm" readonly></td>
				</tr>
				<tr>
					<th>${msg.C100000758}</th> <!--재입고 대상여부-->
					<td >
						<input type="text" id="reWrhousngAt" name="reWrhousngAt" readonly>
					</td>
					<th>${msg.C100000441}</th> <!--사용 시작일시-->
					<td>
						<input type="text" id="useBeginDt" name="useBeginDt" class="dateTimeChk " readonly>
					</td>
					<th>${msg.C100000447}</th> <!--사용 종료일시-->
					<td>
						<input type="text" id="useEndDt" name="useEndDt" class="dateTimeChk " readonly>
					</td>
					<td colspan="2"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
				</tr>
				<tr>
					<th>${msg.C100000425}</th> <!-- 비고 -->
					<td colspan="7"><textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength = "4000"></textarea></td>
				</tr>
			
				
			</table>
			<input type="hidden" id="useDt" name="useDt">
			<input type="hidden" id="prductWrhsdlvrBrcdSeqno" name="prductWrhsdlvrBrcdSeqno">
			<input type="hidden" id="ordr" name="ordr">
			<input type="hidden" id="crud" name="crud">
       	</form>
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
<style>
	.c-red {
		color:#CC3D3D;
		font-weight:bold;
	}
</style>
<script>
var lang = ${msg}; // 기본언어

	$(function(){
		
		init();//기본 세팅
		
		setcmpdsUseGrid();  //그리드 생성
		
		
		setcmpdsUseGridEvent(); //그리드 이벤트
		
		setButtonEvent();//버튼 이벤트
				
		//popup();	//팝업
		
		//document.getElementById("wrhousngDte").value = currentDate();
		
		$('#btn_add').hide(); 
		$('#btn_remove').hide(); 
	});
</script>
<script>
var cmpdsUseMaster = "cmpdsUseMaster";
function init(){
	dateTimePickerCalendar(["useBeginDt","useEndDt"],null);
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCodeSch",{"upperCmmnCode" :  "RS01"}, true,"","RS01000003");
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCode",{"upperCmmnCode" :  "RS01"}, true,"","RS01000003");
	ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{ "bestInspctInsttAt" : "Y", isRdmsIp : true },true,null,"${UserMVo.bestInspctInsttCode}").then(function(){
// 		$("#bplcCode").val('${UserMVo.bestInspctInsttCode}');
// 		$('#bplcCode option').not(':selected').prop('disabled', ( '${UserMVo.authorSeCode}'!= "SY09000001" ));
		});
}


function setcmpdsUseGrid(){
	var columnLayout = {
		cmpdsUseMaster : []
	};
	var reqPros = {
		editable : false
	};
	

	auigridCol(columnLayout.cmpdsUseMaster);														
	columnLayout.cmpdsUseMaster.addColumnCustom("brcd","${msg.C100000336}",null,true,false) /* 바코드 */
	.addColumnCustom("bplcCode","${msg.C100000432}",null,true,false) // 사업 장 C000009000
	.addColumnCustom("prductClCode","${msg.C100000811}",null,true,false) /* 제품분류 C000001634 */
	.addColumnCustom("prductNm","${msg.C100000809}",null,true,false) /* 제품명 */
	.addColumnCustom("useBeginDt","${msg.C100000441}",null,true,false) /* 사용 시작일시 */
	.addColumnCustom("useEndDt","${msg.C100000447}",null,true,false) /* 사용 종료일시 */
	.addColumnCustom("usePurps","${msg.C100000425}",null,true,false) /* 사용 목적 */
	.addColumnCustom("rm","${msg.C100000440}",null,true,false) /* 비고 */
	.addColumnCustom("reWrhousngAt","",null,false,false) /* 재입고 여부 */
	.addColumnCustom("ordr","정렬순서",null,true,false) /*정렬순서 */
	.addColumnCustom("prductWrhsdlvrBrcdSeqno","",null,false,false) /* 제품 입출고 바코드 일련번호 */



	.addColumnCustom("validDte","${msg.C100000641}",null,false,false) /* 유효일자 */

	
	prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :  "RS01"}, true);
	
	columnLayout.cmpdsUseMaster.dropDownListRenderer(["prductClCode"], prductClArray, true, null);

	bplcCodeArray=getGridComboList('/wrk/getBestComboList.lims',null,true);
	columnLayout.cmpdsUseMaster.dropDownListRenderer(["bplcCode"], bplcCodeArray, true, null);
	

	cmpdsUseMaster = createAUIGrid(columnLayout.cmpdsUseMaster, cmpdsUseMaster, reqPros);
	gridResize([cmpdsUseMaster]);
}

function setcmpdsUseGridEvent(){
    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(cmpdsUseMaster, "ready", function(event) {
        gridColResize(cmpdsUseMaster, "2");
    });

	AUIGrid.bind(cmpdsUseMaster, "cellDoubleClick", function(event){
		var item = event.item;
		detailAutoSet({item:event.item,targetFormArr:["CmpdsUseFrm"],successFunc: function(event){
			var date = new Date();
			date = getFormatDate(date);
			if ($("#useEndDt").val() == "") {
				$("#useEndDt").val(date);
			}
		}});
		$('#bplcCode option').not(':selected').prop('disabled', true);
		$("#crud").val("U");
	})
}

//버튼 클릭 이벤트 
function setButtonEvent(){

	document.getElementById("btnSave").addEventListener("click",function(e){

		if(!saveValidation ("CmpdsUseFrm")){
			console.log(">>>>> : 통과 못함" , saveValidation ("CmpdsUseFrm"));
			return false;
		}
		else{
			saveCmpdsUse();
		}
	});
	
	// document.getElementById("dsuseAt").addEventListener("click",function(e){
	// 	var flag = e.target.checked;
	// 	flag = !flag;
	// 	document.getElementById("dsuseDte").disabled = flag;
		
	// 	if(flag)
	// 		document.getElementById("dsuseDte").value = "";
	// });
	
// 	document.getElementById("btnSelect").addEventListener("click",function(e){
// 		var row = AUIGrid.getSelectedItems(cmpdsUseMaster);
		
// 		if(row.length == 0)
// 			alert("${msg.C000000509}"); /* 선택된 데이터가 없습니다. */
// 		else
// 			gridDataSet("CmpdsUseFrm", "input, select", row[0].item, function(){
// 				if(row[0].item.dsuseAt =="Y")
// 					document.getElementById("dsuseDte").disabled = false;	
// 				else
// 					document.getElementById("dsuseDte").disabled = true;
// 			});
		
// // 			gridDataSet("mhrlsCmpdsFrm", "input, select", row[0].item, function(){
// // 				if(row.dsuseAt =="Y")
// // 					document.getElementById("dsuseDte").disabled = false;	
// // 				else
// // 					document.getElementById("dsuseDte").disabled = true;
// // 			});
// 	});
	
	document.getElementById("btnNew").addEventListener("click",function(e){
		reset();		
	});
	
	document.getElementById("btnDelete").addEventListener("click",function(e){
		if($("#prductWrhsdlvrBrcdSeqno").val() !=null && $("#prductWrhsdlvrBrcdSeqno").val() !=""){
			if(confirm("${msg.C100000461}")){  //삭제 하시겠습니까?
			delMhrlsCmpds();	
			}else{
				return;
			}
		}
		else{
			alert("${msg.C100000905}");  // 타겟이 없습니다.
		}		
		
	});
	
	document.getElementById("btnSearch").addEventListener("click",function(e){
		getSearchCmpds();		
	});
	
	// document.getElementById("btnPrint").addEventListener("click",function(e){
	// 	var checkRow = AUIGrid.getCheckedRowItemsAll(cmpdsUseMaster);
	// 	var arrRow = [];
	// 	for(var i = 0; i<checkRow.length; i++){
	// 		arrRow.push("["+checkRow[i].brcd+"]");
	// 	}
	// 	openBacode(arrRow);
	// });
function call()
{
    var sdd = document.getElementById("useBeginDt").value;
    var edd = document.getElementById("useEndDt").value;
	var arBegin =sdd.split(' ');
    var arbegin1 = arBegin[0].split('-');
	var arbegin2 = arBegin[1].split(':');

	var arEnd =edd.split(' ');
    var arend1 = arEnd[0].split('-');
	var arend2 = arEnd[1].split(':');

    var da1 = new Date(arbegin1[0], arbegin1[1], arbegin1[2],arbegin2[0], arbegin2[1], arbegin2[2]);
    var da2 = new Date(arend1[0], arend1[1], arend1[2],arend2[0], arend2[1], arend2[2]);
    var dif = da2 - da1;
	var cSecond =1000 // 밀리세컨
	var cMinute =cSecond * 60 // 분 
	var cHour = cMinute * 60// 시 
    var cDay = cHour * 24 //데이
	return dif/cMinute;
}


	$("#useBeginDt").change(function(){

	});
	$("#useEndDt").on("propertychange change keyup paste input", function() {
		 document.getElementById("useDt").value=call();
	});

	//소모품 구분 변경 이벤트
	$("#mhrlsCmpdsSeCode").change(function(e){
		
		var mhrlsCmpdsSeCode = $("#mhrlsCmpdsSeCode").val();
		if(mhrlsCmpdsSeCode == "RS14000002" || mhrlsCmpdsSeCode == "RS14000003"){
			$("#thStep").addClass("necessary");
		}
		else{
			$("#thStep").removeClass("necessary");
		}
	});
    
	$("#brcd").change(function (e) {
		if(!$("#bplcCode").val()){
		alert("${msg.C100000438}");  //사업장명을 입력해주세요
		}else{
		ajaxJsonForm(
			"<c:url value='/rsc/getbrcdData.lims'/>",
			"CmpdsUseFrm",
			function (data) {
				$('#bplcCode option').not(':selected').prop('disabled', true);
				if (data[0] != null) {
					$("#prductNm").val(data[0].prductNm);
					$("#reWrhousngAt").val(data[0].reWrhousngAt);
					$("#bplcCode").val(data[0].bplcCode);
					$("#useBeginDt").val(data[0].useBeginDt);
					$("#useEndDt").val(data[0].useEndDt);
					$("#ordr").val(data[0].ordr);
					var date = new Date();
					date = getFormatDate(date);
					if (data[0].wrhsdlvrSeCode != "RS08000002") {
						warn("${msg.C100000887}"); // 출고 처리되지않은 바코드입니다.
						reset();
					}else {
						if ($("#useBeginDt").val() == "") {
							$("#useBeginDt").val(date);
							$("#btnSave").trigger("click");
							reset();
						} else if ($("#useEndDt").val() == "") {
							$("#useEndDt").val(date);
						} else if ($("#useBeginDt").val() != "" && $("#useEndDt").val() != "") {
							$("#useBeginDt").val(date);
							$("#useEndDt").val("");
							$("#btnSave").trigger("click");
							reset();
						}

					}
				} else {
					warn("${msg.C100000508}");  // 소모품 바코드가 아니거나 잘못된 바코드 번호입니다.
					reset();
				}
			}
		);
		}
	});

	// 	 	detailAutoSet({ item:date,targetFormArr:["CmpdsUseFrm"]});
	// });
    $("#mhrlsCmpdsSeCode").change(function(e){
    	var Expendables = $("#mhrlsCmpdsSeCode").val();
    	if(Expendables == "RS14000001"){
			$('#btn_add').show(); 
			$('#btn_remove').show(); 
    	}else{
    		$('#btn_add').hide(); 
    		$('#btn_remove').hide(); 
    	}
	});

}
function addrepair() {
    var item = new Object();
    item.canNoSeqno = $("#canNoSeqno").val()
    AUIGrid.addRow(repairHistory, item, "last");
};
function removerepair() {
    AUIGrid.removeRow(repairHistory, "selectedIndex");
}

function saveCmpdsUse(repairaddedRowItems,repairupdedRowItems){

	ajaxJsonForm("<c:url value='/rsc/saveCmpdsUseM.lims'/>", 'CmpdsUseFrm', function (data) {
		
		if(data["succesAt"] <= 0){
			err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
		}else{
			success("${msg.C100000762}"); //저장 되었습니다.
			getSearchCmpds();
		}


	});	
}

//삭제 함수
function delMhrlsCmpds() {
	var url = "/rsc/delMhrlsCmpdsM.lims";
	var data = $("#CmpdsUseFrm").serializeObject();
	
	customAjax({"url":url,"data" : data,"successFunc" :function(data){
        if (data > 0) {
        	getSearchCmpds();
			reset();
            success("${msg.C100000462}"); /* 삭제되었습니다. */
        }
    }
    });
}


function reset(){
	// 폼 초기화
	pageReset(["CmpdsUseFrm"], null, null, function(){
		$("#prductClCode").val("RS01000003");
		$('#bplcCode option').not(':selected').prop('disabled', ( '${UserMVo.authorSeCode}'!= "SY09000001" ));
	});

}

function getSearchCmpds(){
	getGridDataForm("/rsc/getCmpdsUseList.lims","searchFrm",cmpdsUseMaster);
}

//날짜 포멧변환 함수
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
	var Hour =date.getHours();
	Hour = Hour >= 10 ? Hour : '0' + Hour; 
	var Minute =date.getMinutes();
	Minute = Minute >= 10 ? Minute : '0' + Minute; 
	var Second =date.getSeconds();
	Second = Second >= 10 ? Second : '0' + Second; 
    return  year + '-' + month + '-' + day +" " +Hour+":"+Minute+":"+Second;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}
//잠금	
function setReadonly(){
	

}
$(".schClass").keypress(function (e) {
    	setTimeout(function() {
    		if (e.which == 13){
                if( typeof(doSearch) != "undefined" ){
                    doSearch(e);
                }
            }
    	}, 100);
  });
	//엔터키 이벤트
function doSearch(e){
	getSearchCmpds();
}
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

