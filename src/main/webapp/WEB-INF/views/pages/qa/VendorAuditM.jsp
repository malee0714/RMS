<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기 가동 시료</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000625}</h2> <!-- 원료사 Audit -->
		<div class="btnWrap">
			<button type="button" id="btn_select" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm">
			<table class="subTable1" style="width:100%;">
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
					<th>${msg.C100000629}</th> <!-- 원료사명 -->
					<td>
						<input type="text" class="wd100p schClass" name="schEntrpsNm" id="schEntrpsNm">
					</td>
					<th class="necessary">${msg.C100000728}</th> <!-- 작성일자 -->
					<td>
						<input type="text" class="wd6p schClass dateChk" style="min-width: 6em;" name="schWritngStDte" id="schWritngStDte" required> ~
						<input type="text" class="wd6p schClass dateChk"style="min-width: 6em;"  name="schWritngEndDte" id="schWritngEndDte" required>
					</td>
					<th>${msg.C100000624}</th> <!-- 원료 -->
					<td><input type="text" id="schMtrilNm" name="schMtrilNm"  class="wd100p schClass" style="min-width:10em;"></td>
					<th>${msg.C100000793}</th> <!-- 접수번호 -->
					<td><input type="text" id="schAuditRceptNo" name="schAuditRceptNo" class="wd100p schClass" style="min-width:10em;"></td>
				</tr>
			</table>
		</form>
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->

	</div>
	<div class="subCon2">
		<div>
			<div id="vendorAuditMList" class="mgT15" style="width:100%; margin:0 auto;"></div>
		</div>
	</div>
	<br>
	<!-- 원료사Audit 상세정보 시작 -->
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000626}</h2> <!-- 원료사Audit 상세정보 -->
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button type="button" id="btn_wdtb" class="btn5">${msg.C100000362}</button> <!-- 배포 -->
			<input type="hidden" id="btn_wdtb_hidden"></input> <!-- 배포 -->
			<button type="button" id="btn_delete" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
			<button type="button" id="btn_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
			
		</div>
		<form id="verdorAuditForm">
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
					<th class="necessary">${msg.C100000802}</th> <!-- 제목 -->
					<td colspan="5">
						<input type="text" id="sj" name="sj" class="wd100p" style="min-width:10em;" required>
					</td>
					<th>${msg.C100000793}</th> <!-- 접수번호 -->
					<td>
						<input type="text" id="auditRceptNo" name="auditRceptNo" class="wd100p" style="min-width:10em;" readonly>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000729}</th> <!-- 작성부서 -->
					<td>
						<select id="writngDeptCode" name="writngDeptCode"  class="wd100p" style="min-width:10em;"></select>
					</td>
					<th>${msg.C100000730}</th> <!-- 작성자 -->
					<td>
						<select id="wrterId" name="wrterId"  class="wd100p" style="min-width:10em;"></select>
					</td>
					<th>${msg.C100000728}</th> <!-- 작성일자 -->
					<td>
						<input type="text" id="writngDte" name="writngDte" class="wd100p dateChk" style="min-width:10em;">
					</td>
					<th class="necessary">${msg.C100000205}</th> 
					<td>
						<label><input type="radio" name="fdrmAt" value="Y" checked>${msg.C100000795}</label>
						<label><input type="radio" name="fdrmAt" value="N">${msg.C100000431}</label>
					</td>
				</tr>
				<tr>
					<th class="necessary">${msg.C100000571}</th> <!-- 실시방법 -->
					<td>
						<select id="auditOprtnMthCode" name="auditOprtnMthCode"  class="wd100p" style="min-width:10em;" required></select>
					</td>
					<th class="necessary">${msg.C100000629}</th> <!-- 원료사명 -->
					<td>
						<input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
						<input type="text" id="entrpsNm" name="entrpsNm" class="wd63p" style="min-width:10em;" readonly required>
						<button type="button" id="entrpsSch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
						<button type="button" id="entrpsReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
					</td>
					<th class="necessary">${msg.C100000276}</th> <!-- 대상원료 -->
					<td>
						<input type="hidden" id="mtrilSeqno" name="mtrilSeqno">
						<input type="text" id="mtrilNm" name="mtrilNm"class="wd63p" style="min-width:10em;" readonly required>
						<button type="button" id="mtrilSch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
						<button type="button" id="mtrilReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
					</td>
					<th>${msg.C100000009}</th> <!-- Audit범위 -->
					<td>
						<input type="text" id="auditCn" name="auditCn"class="wd100p" style="min-width:10em;">
					</td>
				</tr>
				<tr>
					<th class="necessary">${msg.C100000314}</th> <!-- 목적 -->
					<td>
						<input type="text" id="auditPurps" name="auditPurps" class="wd100p" required>
					</td>
					<th>${msg.C100000010}</th> <!-- Auditor -->
					<td>
						<input type="text" id="adtrNm" name="adtrNm" class="wd100p" style="min-width:10em;">
					</td>
					<th>${msg.C100000356}</th> <!-- 방문시작일자 -->
					<td>
						<input type="text" id="visitBeginDte" name="visitBeginDte" class="wd100p dateChk">
					</td>
					<th>${msg.C100000358}</th> <!-- 방문종료일자 -->
					<td>
						<input type="text" id="visitEndDte" name="visitEndDte" class="wd100p dateChk">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000840}</th> <!-- 지적사항(Critical) -->
					<td>
						<input type="text" id="lgstrMatterNum" name="lgstrMatterNum" class="wd100p numChk" style="min-width:10em;">
					</td>
					<th>${msg.C100000841}</th> <!-- 지적사항(Semi-Critical) -->
					<td>
						<input type="text" id="lgstrMatterSemiNum" name="lgstrMatterSemiNum" class="wd100p numChk" style="min-width:10em;">
					</td>
					<th>${msg.C100000210}</th> <!-- 권고사항 -->
					<td>
						<input type="text" id="rcmndMatterNum" name="rcmndMatterNum" class="wd100p numChk" style="min-width:10em;">
					</td>
					<th class="necessary">${msg.C100000842}</th> <!-- 지적사항합계 -->
					<td>
						<input type="text" id="lgstrMatterSum" name="lgstrMatterSum" class="wd100p" style="min-width:10em;" readonly required>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000011}</th> <!-- Audit요약 -->
					<td colspan="8">
						<textarea id="auditSumry" name="auditSumry"  class="wd100p" style="min-width:10em;"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100001254}</th> <!-- Audit 등급 -->
					<td>
						<select id="auditGradCode" name="auditGradCode"></select>
					</td>
				</tr>
				<tr>
					<th class="necessary">${msg.C100000017}</th> <!-- CheckList -->
					<td colspan="3">
						<div id="dropZoneArea_chkList"></div>
						<input type="hidden" id="chklstAtchmnflSeqno" name="chklstAtchmnflSeqno" value="">
						<input type="button" id="btnSave_chklstAtchmnflSeqno" style="display: none;">
					</td>
					<th>${msg.C100000860}</th> <!-- 첨부파일 -->
					<td colspan="3">
						<div id="dropZoneArea_atchmnfl"></div>
						<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" value="">
						<input type="button" id="btnSave_atchmnflSeqno" style="display: none;">
					</td>
				</tr>
			</table>
			<textarea id = "wdtbCn" name = "wdtbCn" style="display:none"></textarea>
			<textarea id = "wdtbSj" name = "wdtbSj" style="display:none"></textarea>
			<input type="hidden" id="auditSeqno" name="auditSeqno">
			<input type="hidden" id="wdtbSeqno" name="wdtbSeqno">
		</form>
	</div>

	<div class="accordion_wrap mgT17">	
		<div class="accordion ">${msg.C100001004}</div>  <!-- 원료사 Audit 이력 -->
		<div id="acc1" class="acco_top mgT15" style="display: none">
			<h3>${msg.C100000983}</h3> <!-- 품질 문서 이력 -->
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div class="subCon2">
				<div id="vendorAuditDocHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</div>

<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript"></script>
<script>
var vendorAuditMList = 'vendorAuditMList';
var vendorAuditDocHistGrid = 'vendorAuditDocHistGrid';
var dropZoneArea_chkList;
var dropZoneArea_atchmnfl;
var lang = ${msg}; // 기본언어
$(document).ready(function(){
	// gridRendering
	gridRendering();

	//그리드 이벤트 선언
	setGridEvent();

	//콤보 박스 초기화
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	sumLgstrMatter();

	openDialog();

	dropZoneArea_chkList = DDFC.bind().EventHandler("dropZoneArea_chkList",{ btnId : "btnSave_chklstAtchmnflSeqno",lang : "${msg.C100000867}"} );
	dropZoneArea_atchmnfl = DDFC.bind().EventHandler("dropZoneArea_atchmnfl",{ btnId : "btnSave_atchmnflSeqno" ,lang : "${msg.C100000867}"} );

	gridResize(['vendorAuditMList', 'vendorAuditDocHistGrid']);
});

//콤보 박스 초기화
function setCombo(){
	datePickerCalendar(["schWritngStDte"],true,["MM",-1]);
	datePickerCalendar(["schWritngEndDte"],true);
	datePickerCalendar(["visitBeginDte"],false);
	datePickerCalendar(["visitEndDte"],false);
	datePickerCalendar(["writngDte"],true);

	ajaxJsonComboBox('/wrk/getUpperComboListAll.lims','writngDeptCode',null,false,"${msg.C100000480}","${UserMVo.deptCode}");
	ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'wrterId', {"deptCode" : "${UserMVo.deptCode}"}, false, "${msg.C100000480}","${UserMVo.userId}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims','auditOprtnMthCode',{"upperCmmnCode" : "RS11"}, false,"${msg.C100000480}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims','auditGradCode',{"upperCmmnCode" : "RS28"},false,"${msg.C100000480}");

	$("#writngDeptCode").change(function(e){
		ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'wrterId', {"deptCode": e.target.value}, true);
	});
}


//문서 목록 그리드 세팅
function gridRendering(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("auditSeqno", "Audit 일렬번호", "*" ,false); /* Audit 일렬번호 */
	col.addColumnCustom("entrpsNm", "${msg.C100000629}", "*" ,true); /* 원료사명 */
	col.addColumnCustom("sj", "${msg.C100000802}", "*", true); /* 제목 */
	col.addColumnCustom("auditRceptNo", "${msg.C100000793}", "*", true); /* 접수번호 */
	col.addColumnCustom("fdrmGubun", "${msg.C100000205}", "*", true); /* 구분 */
	col.addColumnCustom("mtrilNm", "${msg.C100000276}", "*", true); /* 대상원료 */
	col.addColumnCustom("auditGradCode", "${msg.C100000842}", "*", false); /* audit 등급 코드 */
	col.addColumnCustom("auditGrad", "${msg.C100001254}", "*", true); /* audit 등급 */
	col.addColumnCustom("lgstrMatterNum", "${msg.C100000840}", "*", true); /* 지적사항(Critical) */
	col.addColumnCustom("lgstrMatterSemiNum", "${msg.C100000841}", "*", true);	/* 지적사항(Semi-Critical) */
	col.addColumnCustom("rcmndMatterNum", "${msg.C100000210}", "*", true);  /* 권고사항(Non-Critical) */
	col.addColumnCustom("lgstrMatterSum", "${msg.C100000842}", "*", true); /* 지적사항합계 */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}

	//auiGrid 생성
	vendorAuditMList = createAUIGrid(col, "vendorAuditMList", cusPros);

	var col2 = [];

	auigridCol(col2);
	col2.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)  // 품질문서이력 일렬번호
	.addColumnCustom('tableNm',lang.C100000973,'*',true,false)                // 테이블명
	.addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              // 테이블 주석명
	.addColumnCustom('columnNm',lang.C100000975,'*',true,false)               // 컬럼명
	.addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             // 컬럼 주석명
	.addColumnCustom('seqno','일련번호','*',false,false)                       // 일련번호
	.addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            // 변경 전
	.addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)          // 변경 후
	.addColumnCustom('changerNm',lang.C100000977,'*',true,false)              // 최종 변경자
	.addColumnCustom('lastChangeDt',lang.C100000978,'*',true,false);          // 최종 변경 일시

	vendorAuditDocHistGrid = createAUIGrid(col2, "vendorAuditDocHistGrid", cusPros);

	// 그리드 칼럼 리사이즈
	AUIGrid.bind(vendorAuditMList, "ready", function(event) {
		gridColResize([vendorAuditMList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});

	AUIGrid.bind(vendorAuditDocHistGrid, "ready", function(event) {
		gridColResize([vendorAuditDocHistGrid], "2");
	});
	
}

/*==============그리드 함수==============*/
//그리드 이벤트 선언
function setGridEvent(){
	//문서목록 그리드 더블클릭
	AUIGrid.bind(vendorAuditMList, "cellDoubleClick", function(event) {
		detailAutoSet({
			item : event.item,
			targetFormArr:["verdorAuditForm"],
			successFunc : function() {
				getAuditHist(event.item.auditSeqno);
			}
		});

		ajaxJsonComboBox('/wrk/getUpperComboListAll.lims','writngDeptCode',null,false,"${msg.C100000480}",event.item.writngDeptCode,null,function(data){
			ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'wrterId', {"deptCode" : event.item.writngDeptCode}, false, "${msg.C100000480}",event.item.wrterId);
		});

		dropZoneArea_chkList.getFiles(event.item.chklstAtchmnflSeqno);
		dropZoneArea_atchmnfl.getFiles(event.item.atchmnflSeqno);
	});
}

/*==============버튼 함수==============*/
//버튼 이벤트
function setButtonEvent(){
	$("#btn_select").click(function(){
		getVendorAuditMList();
	});

	$("#btn_save").click(function(){
		insVendorAudit();
	});
	
	$("#btn_delete").click(function(){
		if(!$("#auditSeqno").val()){
			alert("${msg.C100000364}");  /* 배포할 대상을 선택해주세요. */
			return false;
		}
		else{
			if(confirm("${msg.C100000461}")){ /*삭제 하시겠습니까?*/
				delVendorAudit();	
			}
			else{
				return false;
			}	
		}
		
	});

	$("#btn_new").click(function(){
		formReset();
	});

	$("#btn_wdtb").click(function(){
		if($("#auditSeqno").val() == null || $("#auditSeqno").val() == ""){
			alert("${msg.C100000484}");  /* 선택된 Audit이 없습니다. audit을 선택해주세요. */
			return false;
		}else{
			var sj = "[LIMS] 원료사 Audit("+$("#sj").val()+") 배포입니다. ";
			var cn = 
			"<table style='border-top:1px solid #1f296f;'>"
		    +"<tr>"
		    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>원료사 명</th>"
			+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#entrpsNm").val()+"</td>"
			+"</tr>"
			+"<tr>"
		    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제목 </th>"
			+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#sj").val()+"</td>"
			+"</tr>"
			+"<tr>"
		    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>접수번호</th>"
			+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#auditRceptNo").val()+ "</td>"
			+"</tr>"
			+"<tr>"
		    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>구분</th>"
			+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("input[name='fdrmAt']:checked")[0].nextSibling.data+"</td>"
			+"</tr>"
			+"<tr>"
		    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>대상원료</th>"
			+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#mtrilNm").val()+"</td>"
			+"</tr>"
			+"</table>"	;
			$("#wdtbSj").val(sj);
			$("#wdtbCn").val(cn);
			$("#btn_wdtb_hidden").click();
		}
	});
	
	
	$("#entrpsReset").click(function(){
		dialogReset(this.id);
	})
	$("#mtrilReset").click(function(){
		dialogReset(this.id);
	})
	// 아코디언 click event
	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
		acc[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;

			if (panel.style.display === "block") {
				panel.style.display = "none";
			}else {
				panel.style.display = "block";
				AUIGrid.resize(vendorAuditMList);
				AUIGrid.resize(vendorAuditDocHistGrid);

				var seqno = $("#auditSeqno").val() != '' ? $("#auditSeqno").val() : null;
				getAuditHist(seqno);
			}

			if (panel.style.maxHeight) {
				panel.style.maxHeight = null;
			}else {
				panel.style.maxHeight = null;
			}
		});
	}

}

/*############ 조회, 저장, 삭제 함수 ############*/
function getVendorAuditMList(){
	if(!saveValidation('searchFrm')) {
		return false;
	}
	var url = "<c:url value='/qa/getVendorAuditMList.lims'/>"
	
	$.when(
			getGridDataForm(url,"searchFrm", vendorAuditMList)
	).then(function() {
		if(!!$("#auditSeqno").val()){
			var wdtbSeqno = AUIGrid.getItemsByValue(vendorAuditMList,"auditSeqno",$("#auditSeqno").val())[0].wdtbSeqno;
			$("#wdtbSeqno").val(wdtbSeqno);
		}
	});
}

function getAuditHist(seqno) {
	var param = {
		"tableNm" : "VENDOR_RS_AUDIT",
	};

	if(!!seqno) {
		param.seqno = seqno;
		getGridDataParam('/com//getQlityDocHistList.lims', param, vendorAuditDocHistGrid);
	}else {
		return;
	}
}

function insVendorAudit(){
	if(!saveValidation("verdorAuditForm")) return false;

	if(!atchNecessaryChk(dropZoneArea_chkList)){
		return;
	}

	var url = "<c:url value='/qa/insVendorAudit.lims'/>";

	$.when(
		fileSave(dropZoneArea_chkList,"chklstAtchmnflSeqno")
		,fileSave(dropZoneArea_atchmnfl,"atchmnflSeqno")
	).then(function(data){
		customAjax({
			"url" : url,
			"data" : $("#verdorAuditForm").serializeObject(),
			"successFunc":function(data){
				if (data != 1){
					err("${msg.C100000597}"); /* 저장에 실패하였습니다. */
				} else {
					success("${msg.C100000765}"); /* 저장 되었습니다. */
					getVendorAuditMList();
					AUIGrid.clearGridData(vendorAuditDocHistGrid);
					formReset();
				}
			}
		});
	});
}

function delVendorAudit(){
	
	var url = "<c:url value='/qa/delVendorAudit.lims'/>";

	var param = {auditSeqno : $("#auditSeqno").val()}
	customAjax({
		"url" : url,
		"data" : param,
		"successFunc":function(data){
			if (data != 1){
				err("${msg.C100000597}"); /* 삭제에 실패하였습니다. */
			} else {
				success("${msg.C100000462}"); /* 삭제 되었습니다. */
				getVendorAuditMList();
				AUIGrid.clearGridData(vendorAuditDocHistGrid);
				formReset();
			}
		}
	});
}

/*==============기타 함수==============*/
//첨부파일 저장
function fileSave(dropZoneArea, atchmnflSeqno){

    var deferred = $.Deferred();

    var dropZone = dropZoneArea.getNewFiles();
    var fileCnt = dropZone.length;

    var $saveBtn = $("#btnSave_" + atchmnflSeqno);

    //새로 첨부한 파일이 있을시
    if( fileCnt > 0 ){
        $saveBtn.click();
        dropZoneArea.upload(true);
        dropZoneArea.on("uploadComplete", function(event, fileIdx){
            if( fileIdx == -1 ){
                err("${msg.C100000864}");  /* 첨부파일 저장에 실패하였습니다. */
                deferred.reject(); //실패처리
            }
            $("#" + atchmnflSeqno).val(fileIdx);
            deferred.resolve(); //성공처리
        });
    }else{
        deferred.resolve(); //첨부할게 없더라도 resolve()
    }
    return deferred.promise();
}

//dialog
function openDialog(){
	dialogEntrps("entrpsSch", "SY08000003", "entrpsDialog", function(data){
		$("#entrpsNm").val(data["entrpsNm"]);
		$("#entrpsSeqno").val(data["entrpsSeqno"]);

	}, null);

	dialogWdtb("btn_wdtb_hidden", {"dept" : '${UserMVo.deptCode}'}, "Y", "audit", vendorAuditMList, "vendorAuditWdtbDialog", function(data){
		getVendorAuditMList();
	});

	var mtrilData = {
			bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
			authorSeCode : '${UserMVo.authorSeCode}'
	};

	dialogMtril("mtrilSch", mtrilData, "vendorAuditMtril", function(item){
		$("#mtrilSeqno").val(item.mtrilSeqno);
		$("#mtrilNm").val(item.mtrilNm);
	},null,null,null,'Y');
}

//지적사항합계 구하기
function sumLgstrMatter(){
	$("#lgstrMatterNum").change(function(){
		var lgstrMatterNum = Number($("#lgstrMatterNum").val());
		var lgstrMatterSemiNum = Number($("#lgstrMatterSemiNum").val());
		var rcmndMatterNum = Number($("#rcmndMatterNum").val());
		var sum = lgstrMatterNum + lgstrMatterSemiNum + rcmndMatterNum;

		$("#lgstrMatterSum").val(sum);
	});

	$("#lgstrMatterSemiNum").change(function(){
		var lgstrMatterNum = Number($("#lgstrMatterNum").val());
		var lgstrMatterSemiNum = Number($("#lgstrMatterSemiNum").val());
		var rcmndMatterNum = Number($("#rcmndMatterNum").val());

		var sum = lgstrMatterNum + lgstrMatterSemiNum + rcmndMatterNum;

		$("#lgstrMatterSum").val(sum);
	});

	$("#rcmndMatterNum").change(function(){
		var lgstrMatterNum = Number($("#lgstrMatterNum").val());
		var lgstrMatterSemiNum = Number($("#lgstrMatterSemiNum").val());
		var rcmndMatterNum = Number($("#rcmndMatterNum").val());

		var sum = lgstrMatterNum + lgstrMatterSemiNum + rcmndMatterNum;

		$("#lgstrMatterSum").val(sum);
	});
}

//폼 RESET
function formReset(){
	$('#verdorAuditForm')[0].reset();

	$("#verdorAuditForm input[type=hidden]").val('');

	ajaxJsonComboBox('/wrk/getUpperComboListAll.lims','writngDeptCode',null,false,"${msg.C100000480}","${UserMVo.deptCode}");
	ajaxJsonComboBox('/com/getDeptToUserLsit.lims', 'wrterId', {"deptCode" : "${UserMVo.deptCode}"}, false, "${msg.C100000480}","${UserMVo.userId}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims','auditOprtnMthCode',{"upperCmmnCode" : "RS11"}, false,"${msg.C100000480}"); /* 선택 */

	datePickerCalendar(["visitBeginDte","visitEndDte"],false);
	datePickerCalendar(["writngDte"],true);

	dropZoneArea_chkList.clear();
	dropZoneArea_atchmnfl.clear();
}
//엔터키 이벤트
function doSearch(e){
	getVendorAuditMList();
}

</script>
	</tiles:putAttribute>
</tiles:insertDefinition>