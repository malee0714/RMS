<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000539}</h2> <!-- 시약/표준품 목록-->
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
					<col style="width:10%"></col>			
					<col style="width:15%"></col>					
				</colgroup>
					<tr><th>분석실 명</th> <!-- 사업 장  -->
					<td>
						<select id="custlabSeqnosch" name="custlabSeqno">
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td> 	
					<th>${msg.C100000811}</th> <!-- 분류  -->
					<td>
						<select id="prductClCodesch" name="prductClCodesch" >
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td> 
					<th>품명</th> <!-- 품명  -->
					<td><input type="text" id="prductNmSch" name="prductNmSch"class="schClass" ></td>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td style="text-align:left;">
						<label><input type="radio" id="use_a" name="useAtSch" value="" >${msg.C100000779}</label> <!-- 전체 -->
						<label><input type="radio" id="use_b" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" id="use_c" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div>
			<div id="rgntCmpdsMaster"></div>
		</div>
	</div>
	<div class="subCon2">
		<div class="mapkey">
			<label class="scarce">${msg.C100000777}</label><!-- [적정 재고 이하] -->
		</div>
	</div>

	<div class="subCon1 mgT20">
		<h2><i class="fi-rr-apps"></i>${msg.C100000540}</h2> <!-- 시약/표준품 상세 정보  -->
		<div class="btnWrap">
			<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button id="btnDelete" class="delete" style="display: none">${msg.C100000458}</button> <!-- 삭제 -->
			<button id="btnNewSave" class="save" style="display: none" >${msg.C100001002}</button> <!-- 새로저장 -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="rgntCmpdsFrm" name="rgntCmpdsFrm" onsubmit="return false">
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
                    <th class="necessary">분석실 명</th>
                    <td><select id="custlabSeqno" name="custlabSeqno" required>
                        <option value=''>${msg.C100000480}</option>
                    </select>
					</td>

<%--                    <th class="necessary">${msg.C100000432}</th> <!-- 사업 장  -->--%>
<%--				<td>			--%>
<%--				 	<select id="bplcCode" name="bplcCode" required>--%>
<%--						<option value=''>${msg.C100000480}</option> <!-- 선택 -->--%>
<%--					</select> --%>
<%--				</td> --%>
				<th class="necessary">${msg.C100000811}</th> <!-- 분류 C000001634 -->
					<td>
						<select id="prductClCode" name="prductClCode" required>
							<option>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					<th class="necessary">품명</th> <!-- 제품 명	 -->
						<td colspan="3">
						<input type="text" id="prductNm" name="prductNm" maxlength="200" required>
						</td>
				</tr>
				<tr>
					<th>ITEM NO.</th> <!-- 관리부서 -->
					<td>
						<input type="text" id="itemNo" name="itemNo">
					</td>
					<th>LOT NO.</th> <!-- 관리부서 -->
					<td>
						<input type="text" id="lotNo" name="lotNo">
					</td>
					<th >${msg.C100000202}</th> <!-- 관리책임자(정) -->
					<td>
						<input type="hidden" id="manageDeptCode" name="manageDeptCode" >
						<select id="manageRspnberJId" name="manageRspnberJId" >
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					<th>${msg.C100000201}</th> <!-- 관리책임자(부) -->
					<td>
						<select id="manageRspnberBId" name="manageRspnberBId" >
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
				</tr>
				<tr>
					<th class="necessary">${msg.C100000645}</th> <!-- 유효기한관리대상 -->
					<td>
						<label><input type="radio" id="validTmlmtTrget_y" name="validTmlmtTrgetAt" value="Y" checked>대상</label> <!-- 사용 -->
						<label><input type="radio" id="validTmlmtTrget_n" name="validTmlmtTrgetAt" value="N" >비대상</label> <!-- 사용안함 -->
					</td >	
					<th id="thValidDte" class="necessary">${msg.C100000643}</th> <!-- 유효기간 방식 -->
					<td>
						<select id="validTmlmtMthdCode" name="validTmlmtMthdCode" style="width:10%; min-width:7em; float:left;" required><option>${msg.C100000480}</option> <!-- 선택 --></select>
						<input type="text" name="unsealAfterTmlmt" id="unsealAfterTmlmt"  class="numChk" maxlength="10" style="width:7%; float: left; min-width:5em; margin-left: 6px;">
						<select id="cycleCode" name="cycleCode" style="width:6.3%; min-width:6.3em;"></select>
					</td>
					<th>${msg.C100000268}</th> <!- 단위 -->
					<td>
						<select type="text" name="unitSeqno"  id="unitSeqno"  value="0"   maxlength="10" class="comma" >
							<option>${msg.C100000480}
						</select>
					</td>
					<th class="necessary">${msg.C100000776}</th> <!-- 적정 재고 -->
					<td>
						<input type="text" name="proprtInvntryQy"  id="proprtInvntryQy"  value="0"   maxlength="10" class="comma" required>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000621}</th> <!--용도 --> 
					<td>
					<input type="text" id="prductPrpos" name="prductPrpos"  maxlength="200">	
					</td>
					<th>${msg.C100000622}</th> <!--용량--> 
					<td>
					<input type="text" id="cpcty" name="cpcty"  maxlength="200">	
					</td>
					<th>${msg.C100000016}</th> 	<!--CAS. NO-->
					<td>
						<input type="text" id="casNo" name="casNo"  maxlength="100">
					</td>
					<th>${msg.C100000902}</th>	<!--카탈로그 NO.-->
					<td>
						<input type="text" id="ctlgNo" name="ctlgNo"  maxlength="200">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000440}</th>	<!--사용목적--> 
					<td colspan="5">
					<input type="text" id="usePurps" name="usePurps"  maxlength="4000">	
					</td>
					<th>${msg.C100000816}</th>	<!--제품상태--> 
					<td>
						<select id="prductSttusCode" name="prductSttusCode">
							<option>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000587}</th>  <!--업체명-->
					<td colspan="3">
					<input type="text" id="entrpsNm" name="entrpsNm"  maxlength="200">
					</td>
					<th>${msg.C100000585}</th> <!--업체 담당자-->
					<td>
					<input type="text" id="entrpsChargerNm" name="entrpsChargerNm" maxlength="200">
					</td>
					<th>${msg.C100000586}</th> <!--업체 담당자 연락처-->
					<td >
					<input type="text" id="entrpsChargerCttpc" name="entrpsChargerCttpc" maxlength="200">	
					</td>
				</tr>
				<tr>
					<th>${msg.C100000425}</th> <!-- 비고 -->
					<td colspan="7"><textarea id="rm" name="rm" class="wd100p" style="min-width:10em;" rows="2" maxlength="4000"></textarea></td>
				</tr>
				<tr>
					<th>분석실사진</th>
					<td colspan="7">
						<div id="dropZoneArea" style="text-align:left;"></div>
						<input type="text" name="atchmnflSeqno" value="" style="display: none">
						<input type="hidden" id="dropzoneBtnSave" value="사진첨부파일">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000443}</th> <!-- 사용 여부 -->
					<td>
						<label><input type="radio" id="use_y" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" id="use_n" name="useAt" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
					</td>
				</tr>
				<input type="hidden" name="prductSeqno" id="prductSeqno">

			<!-- 	 <tr>
					<th>테스트</th> 비고
					<input type="file" id="fileupload" name="fileupload">
					<button id="btn_form_upload" name="btn_form_upload"> 업로드</button>
				</tr> -->
				
			</table>
       	</form>
	</div>
	 <div class="subCon2 mgT15" id="expriemDiv" style="display: none">
		<div class="subCon1 ">
			<h3>시험항목 목록</h3>  <!-- 시험항목 목록 -->
			<div class="btnWrap">
			<button id="btnAddprevnt" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
			<button id="btnDelprevnt" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
		</div>
	</div>
	<div id="prevntMaster" class="mgT10 grid" style="width: 100%; height: 360px; margin: 0 auto;"></div>
</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
<style>
	.c-orange {
		background-color:#FEDBDE;
	}
</style>
<script>
 var lang = ${msg}; // 기본언어
 var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#dropzoneBtnSave", lang : "${msg.C000000118}" } );
	$(function(){
		
		init();//기본 세팅
	
		setrgntCmpdsMGrid();  //그리드 생성
		setprevntMaster();
		setrgntCmpdsMGridEvent(); //그리드 이벤트
		
		setButtonEvent();//버튼 이벤트
		gridResize([rgntCmpdsMaster,prevntMaster]);
	});
</script>
<script>
var rgntCmpdsMaster = "rgntCmpdsMaster";
var prevntMaster = "prevntMaster";
function init(){
//	ajaxJsonComboBox('/com/getDeptCombo.lims','bplcCode',{ "bestInspctInsttAt" : "Y",isRdmsIp:true},true,null,"${UserMVo.bestInspctInsttCode}").then(function(){
// 	$("#bplcCode").val('${UserMVo.bestInspctInsttCode}');
// 	$('#bplcCode option').not(':selected').prop('disabled', ( '${UserMVo.authorSeCode}'!= "SY09000001" ));
//	});


	dialogAddRgntExpriemList("btnAddprevnt",  "prevntPop", prevntMaster, function(item){
		var check = AUIGrid.getGridData(prevntMaster);
		if(check.length > 0){
			for(var i=0; i<check.length; i++){
				for(var j=0; j<item.length; j++){
				if(item[j].expriemSeqno === check[i].expriemSeqno){
					check[i].cmmnCode = "";
					warn("${msg.C100001164}") /*동일한 사용자가 등록되어 있습니다. */
					return false;
				}
				}
			}
		} 
		//헤당 그리드에 데이터 입력
		AUIGrid.addRow(prevntMaster,item,"last"); // 최하단에 1행 추가
		AUIGrid.setSorting(prevntMaster,  { dataField : "expriemSeqno", sortType : 1 });
	},function(){
		
	},true);

    ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCodesch",{"upperCmmnCode" :  "RS01"}, true);  // 제품 분류
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCode",{"upperCmmnCode" :  "RS01"}, true);
	ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSttusCode",{"upperCmmnCode" :  "RS16"}, true); // 제품 상태
	ajaxJsonComboBox('/com/getCmmnCode.lims', "validTmlmtMthdCode",{"upperCmmnCode" :  "RS15"}, true); // 유효기한 방식
	ajaxJsonComboBox('/com/getCmmnCode.lims','cycleCode',{"upperCmmnCode" : "SY14"}, false, "${msg.C100000480}"); /* 선택 */
	ajaxJsonComboBox('/wrk/getUnitcomdo.lims','unitSeqno',{"unitSeCode" : "SY10000002"}, false, "${msg.C100000480}"); /* 선택 */

}

function setrgntCmpdsMGrid(){
	var columnLayout = {
		rgntCmpdsMaster : []
	};
	
	var reqPros = {
		//엑스트라체크박스 표시
		showRowCheckColumn : false,
		// 전체 체크박스 표시 설정
		rowIdField : "prductSeqno",
		showRowAllCheckBox : false,
		editable : false,
		rowStyleFunction : function(rowIndex, item) {
 				if(item.proprtInvntryQy > item.nowInvntryQy)
 					return "c-orange";
 				return "";
 			}
	};
	var comma = {
			dataType : "numeric",
			formatString : "#,##0",
	};
	
	auigridCol(columnLayout.rgntCmpdsMaster);													
	columnLayout.rgntCmpdsMaster.addColumnCustom("custlabSeqno","분석실 명",null,true,false) // 사업 장
	.addColumnCustom("prductSeqno","${msg.C100000812}",null,false,false)// 제품 일련번호
	.addColumnCustom("prductClCode","${msg.C100000811}",null,true,false) /* 분류  */
	.addColumnCustom("prductNm","품명",null,true,false) /* 품명 */
	.addColumnCustom("proprtInvntryQy","${msg.C100000776}",null,true,false,comma) /* 적정재고  */
	.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true,false,comma) /* 현재고   */
	.addColumnCustom("prductPrpos","${msg.C100000817}",null,true,false) /* 제품용도  */
	.addColumnCustom("casNo","${msg.C100000016}",null,true,false) /* CAS. No  */ 
	.addColumnCustom("ctlgNo","${msg.C100000902}",null,true,false) /* 카탈로그 No.  */
	.addColumnCustom("prductSttusCode","${msg.C100000816}",null,true,false) /* 제품상태  */
	.addColumnCustom("entrpsNm","${msg.C100000587}",null,true,false) /* 업체명 */
	.addColumnCustom("entrpsChargerNm","${msg.C100000594}",null,true,false) /* 업체담당자명  */
	.addColumnCustom("entrpsChargerCttpc","${msg.C100000595}",null,true,false) /* 업체연락처  */
	.addColumnCustom("manageDeptCode","${msg.C100000198}",null,false,false) /* 관리 부서  */
	.addColumnCustom("manageRspnberJNm","${msg.C100000202}",null,false,false) /* 관리책임자(정)  */
	.addColumnCustom("manageRspnberBNm","${msg.C100000201}",null,false,false) /* 관리책임자(부) */
	.addColumnCustom("manageRspnberJId","${msg.C100000202}",null,false,false) /* 관리책임자(정)  */
	.addColumnCustom("manageRspnberBId","${msg.C100000201}",null,false,false) /* 관리책임자(부) */
	.addColumnCustom("rm", "${msg.C100000425}", "*", false,false) // 비고
	.addColumnCustom("validTmlmtTrgetAt", "${msg.C100000645}", "*", false,false)		//유효기간 관리 대상
	.addColumnCustom("usePurps", "${msg.C100000440}", "*", false,false)				//사용 목적
	.addColumnCustom("cpcty", "${msg.C100000622}", "*", false,false)		//용량
	.addColumnCustom("validTmlmtMthdCode", " ${msg.C100000643}", "*", false,false)		//유효기간 방식 
	.addColumnCustom("unsealAfterTmlmt", "${msg.C100000116}", "*", false,false)		//개봉후 기한
	.addColumnCustom("cycleCode", "${msg.C100000835}", "*", false,false)		//주기
	.addColumnCustom("atchmnflSeqno", "첨부파일 일련번호", "*", false,false)		//
	.addColumnCustom("itemNo", "아이템 NO", "*", false,false)		//
	.addColumnCustom("lotNo", "LOT NO", "*", false,false)	    //
	.addColumnCustom("unitSeqno", "단위", "*", false,false);		//주기


	custlabSeqnoArray=getGridComboList('/rsc/getCustlabCombo.lims',null,true);
	prductClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS01"}, true);
	eqpmnClArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS02"}, true);
	manageDeptArray=getGridComboList('/com/getDeptCombo.lims',null, true);
	prductSttusArray=getGridComboList('/com/getCmmnCode.lims',{"upperCmmnCode" :"RS16"}, true);
	columnLayout.rgntCmpdsMaster.dropDownListRenderer(["prductClCode"], prductClArray, true, null);
	columnLayout.rgntCmpdsMaster.dropDownListRenderer(["custlabSeqno"], custlabSeqnoArray, true, null);
	columnLayout.rgntCmpdsMaster.dropDownListRenderer(["manageDeptCode"], manageDeptArray, true, null);
	columnLayout.rgntCmpdsMaster.dropDownListRenderer(["prductSttusCode"], prductSttusArray, true, null);
	//columnLayout.rgntCmpdsMaster.dropDownListRenderer([], bplcCodeArray, true, null);
	rgntCmpdsMaster = createAUIGrid(columnLayout.rgntCmpdsMaster, rgntCmpdsMaster, reqPros);


}
function setprevntMaster(){
	var columnLayout = {
		prevntMaster : []
	};

	auigridCol(columnLayout.prevntMaster);			
	columnLayout.prevntMaster.addColumnCustom("expriemNm","시험 항목 내용",null,true,true) // 시험 항목 내용
	.addColumnCustom("sortOrdr","${msg.C100000812}",null,false,false)//
	.addColumnCustom("expriemSeqno","${msg.C100001168}",null,false,false);// 시험항목 일련번호
	prevntMaster = createAUIGrid(columnLayout.prevntMaster, prevntMaster);


}


function setrgntCmpdsMGridEvent(){
    // ready는 화면에 필수로 구현 할 것
    AUIGrid.bind(rgntCmpdsMaster, "ready", function(event) {
		gridColResize(rgntCmpdsMaster, "2");
    });
    AUIGrid.bind(prevntMaster, "ready", function(event) {
		gridColResize(prevntMaster, "2");
});

	AUIGrid.bind(rgntCmpdsMaster, "cellDoubleClick", function(event){
		detailAutoSet({item:event.item,targetFormArr:["rgntCmpdsFrm"] , successFunc: function(){
			dropZoneArea.getFiles(document.querySelector('input[name=atchmnflSeqno]').value);
			$("#prductClCode").change();
			$("#validTmlmtTrget_n").change();
			$("#validTmlmtMthdCode").change();
			$("#nowInvntryQy").prop("readonly",true);
			$("#prductClCode option").prop('disabled',false);
			$("#prductClCode option").not(':selected').prop('disabled',true);
			$("#btnNewSave").css("display","inline-block");
			$("#unitSeqno").val($("#unitSeqno").val()?$("#unitSeqno").val():"");
			$('#btnDelete').show();

				ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberJId', {"deptCode": event.item.manageDeptCode}, true,  null,event.item.manageRspnberJId, null);
				ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberBId', {"deptCode": event.item.manageDeptCode}, true,  null,event.item.manageRspnberBId, null);
            if(event.item.prductClCode =='RS01000001' || event.item.prductClCode =='RS01000003') {
                customAjax({
                    url: '/rsc/listPrevnt.lims',
                    data: {prductSeqno: $("#prductSeqno").val()},
                    showLoading: true,
                    successFunc: function (data) {
                        AUIGrid.setGridData(prevntMaster, data);
                    }
                });
            }else {
                AUIGrid.clearGridData(prevntMaster);
            }
		}

	})
	});
}

//버튼 클릭 이벤트 
function setButtonEvent(){
	
	document.getElementById("btnSave").addEventListener("click",function(e){
		
		unComma(["proprtInvntryQy"]);

		if(!saveValidation ("rgntCmpdsFrm")){
			//console.log(">>>>> : 통과 못함" , saveValidation ("rgntCmpdsFrm"));
			return false;
		}else{
			atchmnflSave();

		}
	});
	
document.getElementById("btnNewSave").addEventListener("click",function(e){
		
		unComma(["proprtInvntryQy"]);


		if(!saveValidation ("rgntCmpdsFrm")){
			//console.log(">>>>> : 통과 못함" , saveValidation ("rgntCmpdsFrm"));
			return false;
		}else{
				var files = dropZoneArea.getNewFiles();
				var len = files.length;
				if (len > 0) {
					$("#dropzoneBtnSave").click();
					dropZoneArea.on("uploadComplete", function(event, fileIdx) {
						if (fileIdx === -1) {
							err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
						} else {
							document.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
							newSaveRgnt();
						}
					});
				} else { // 첨부파일이 없을 시
					newSaveRgnt();
				}

		}

	});
	
	
	document.getElementById("btnDelete").addEventListener("click",function(e){
		unComma(["proprtInvntryQy"]);
		if (confirm("${msg.C100000461}"))
			deletRgnt();
	});
	document.getElementById("btnNew").addEventListener("click",function(e){
		reset();		
	});
	

	document.getElementById("btnSearch").addEventListener("click",function(e){
		$(toastr)[0].remove();
		getSearchRgnt();		
	});

	document.getElementById("btnDelprevnt").addEventListener("click",function(e){


		var selectedItems = AUIGrid.getSelectedItems(prevntMaster);
		if(selectedItems.length == 0) {
			alert("${msg.C100000467}");  /* 삭제할 데이터가 없습니다. */
		 	return;
		}

		var tempArr = new Array();
		for(var i=0; i<selectedItems.length; i++){
			tempArr.push(selectedItems[i].rowIndex);
		}
		
		//해당 그리드에서 선택된 인덱스를 삭제해준다.
		AUIGrid.removeRow(prevntMaster, tempArr);
		var delParam={"removePrevntMaster" : AUIGrid.getRemovedItems(prevntMaster)} // 시험항목 그리드 삭제
		if(delParam.removePrevntMaster.length !=0){
		customAjax({url:'/rsc/delPrevnt.lims',data:delParam,showLoading:true,successFunc:function(data) {
				if (data == 0){
					err("${msg.C100000597}");//저장에 실패하였습니다.
				} else {
					success("${msg.C100000762}");//저장 되었습니다.
				}}});
		}
	});
	
	$("#validTmlmtMthdCode").change(function(e){
		if(e.target.selectedIndex==2){
			$("#unsealAfterTmlmt").prop("readonly",false);
			$('#cycleCode option').not(':selected').prop('disabled',false);
			$("#unsealAfterTmlmt").prop("required",true);	
			$("#cycleCode").prop("required",true); 
		}else {
		$("#unsealAfterTmlmt").val('');
	 	$("#cycleCode").val('');
		$("#unsealAfterTmlmt").prop("readonly",true);
		$('#cycleCode option').not(':selected').prop('disabled',true);
		$("#unsealAfterTmlmt").prop("required",false);
		$("#cycleCode").prop("required",false); 
		}
		
	});

	$("#validTmlmtTrget_y").change(function(e){
		if($("#validTmlmtTrget_y")[0].checked){
			changeDisabled(false);
			
		}
		else{
			changeDisabled(true);
		}
	});
	$("#validTmlmtTrget_n").change(function(e){
		if($("#validTmlmtTrget_y")[0].checked){
			changeDisabled(false);
	}
		else
		changeDisabled(true);
	});
	$("#custlabSeqno").change(function(e){
		customAjax({url:'/rsc/selectchrgDeptCode.lims',data:{custlabSeqno:e.target.value},successFunc:function(data) {
					$("#manageDeptCode").val(data);
					$("#manageDeptCode").change();
		}});
	});
	$("#manageDeptCode").change(function(e){
		if(e.target.value) {
			ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberJId', {"deptCode": e.target.value}, false, "선택");
			ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberBId', {"deptCode": e.target.value}, true);
		}else{
		ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberJId', null, false, "선택");
		ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'manageRspnberBId', null, true);

	}
	});
	$("#prductClCode").change(function(e){
		if ( $('#prductClCode option:selected').val() =='RS01000001' ||$('#prductClCode option:selected').val() =='RS01000003'){
			$("#expriemDiv").css("display","block");
			AUIGrid.resize(prevntMaster);
		}else {
			AUIGrid.clearGridData(prevntMaster);
            $("#expriemDiv").css("display","none");
        }
	});
}
function newSaveRgnt(){
	$("#prductSeqno").val('');
	$("#nowInvntryQy").val(0);
	param = $("#rgntCmpdsFrm").serializeObject();
	griddata = AUIGrid.getGridData(prevntMaster);
	customAjax({url: "<c:url value='/rsc/saveRgntM.lims'/>",data: param,successFunc:function (datas) {
		if(datas <= 0){
			err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
			reset();
		}else{
			var gridParam = { 
				"addedPrevntMaster" : AUIGrid.getAddedRowItems(prevntMaster), // 시험항목 그리드 추가
				"editedPrevntMaster" : AUIGrid.getEditedRowItems(prevntMaster), // 시험항목 그리드 수정
				"removePrevntMaster" : AUIGrid.getRemovedItems(prevntMaster)} // 시험항목 그리드 삭제
			var param = Object.assign({prductSeqno:datas}, gridParam);

			customAjax({url:'/rsc/savePrevnt.lims',data:param,showLoading:true,successFunc:function(data) {
				if (data == 0){
					err("${msg.C100000597}");//저장에 실패하였습니다.
				} else {
					success("${msg.C100000762}");//저장 되었습니다.
					getSearchRgnt(datas);
				}}});
			reset();
		}
	}});
}

// 첨부 파일 저장 함수
function atchmnflSave() {
	var files = dropZoneArea.getNewFiles();
	var len = files.length;
	if (len > 0) {
		$("#dropzoneBtnSave").click();
		dropZoneArea.on("uploadComplete", function(event, fileIdx) {
			if (fileIdx === -1) {
				err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
			} else {
				document.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
				saveRgnt();
			}
		});
	} else { // 첨부파일이 없을 시
		saveRgnt();
	}
}


function saveRgnt(){
	param = $("#rgntCmpdsFrm").serializeObject();
	griddata = AUIGrid.getGridData(prevntMaster);
	ajaxJsonForm("<c:url value='/rsc/saveRgntM.lims'/>", 'rgntCmpdsFrm', function (datas) {
		
		if(datas <= 0){
			err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
			reset();
		}else{
			var gridParam = { 
				"addedPrevntMaster" : AUIGrid.getAddedRowItems(prevntMaster), // 납품처 그리드 추가
				"editedPrevntMaster" : AUIGrid.getEditedRowItems(prevntMaster), // 납품처 그리드 수정
				"removePrevntMaster" : AUIGrid.getRemovedItems(prevntMaster)} // 납품처 그리드 삭제
			var param = Object.assign({prductSeqno:datas}, gridParam);

			customAjax({url:'/rsc/savePrevnt.lims',data:param,showLoading:true,successFunc:function(data) {
				if (data == 0){
					err("${msg.C100000597}");//저장에 실패하였습니다.
				} else {
					success("${msg.C100000762}");//저장 되었습니다.
					getSearchRgnt(datas);	
				}}});
			reset();
		}

	});
}
function deletRgnt(){
	
	ajaxJsonForm("<c:url value='/rsc/deletRgntM.lims'/>", 'rgntCmpdsFrm', function (data) {
		
		if(data.length<= 0){
			err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
		}else{
			success("${msg.C100000762}");		// 저장 되었습니다.
			getSearchRgnt();
		}


	});
}
function reset(){
	// 폼 초기화
	$("#prductClCode option").not(':selected').prop('disabled',false);
	$("#nowInvntryQy").prop("readonly",true);
	pageReset(["rgntCmpdsFrm"], null, null, function(){
	$("#prductClCode").change();
	$("#btnNewSave").css("display","none");
	$('#btnDelete').hide();
	changeDisabled(false);
	dropZoneArea.getFiles(document.querySelector('input[name=atchmnflSeqno]').value);
	});
}
function changeDisabled(bool){
	$("#validTmlmtMthdCode option").prop("disabled",bool);
	$("#validTmlmtMthdCode").prop("required",!bool);
	if(bool){
		$("#thValidDte").removeClass("necessary");
	}else{
		$("#thValidDte").addClass("necessary");
	}

	$("#unsealAfterTmlmt").prop("disabled",bool);
	$('#cycleCode option').prop('disabled',bool);
	//$("#cycleCode").prop("disabled",bool);
}
function getSearchRgnt(tager){
	getGridDataForm("/rsc/getRgntMList.lims","searchFrm",rgntCmpdsMaster,function(){
		AUIGrid.clearGridData(prevntMaster);
		if(tager != null){
			AUIGrid.setSelectionByIndex(rgntCmpdsMaster,AUIGrid.rowIdToIndex(rgntCmpdsMaster,tager),0);
		}
		
	});
	
}
//잠금	
function setReadonly(){
		
	
}
	//엔터키 이벤트
	function doSearch(e){
	$(toastr)[0].remove();
	getSearchRgnt();
}
</script>
<!--  script 끝 -->
</tiles:putAttribute>    
</tiles:insertDefinition>

