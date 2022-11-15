<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">기기 가동 시료</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000627}</h2> <!-- 원료사 Audit 지적 사항 -->
		<div class="btnWrap">
			<button type="button" id="btn_viewReport" class="print">${msg.C100000546}</button> <!-- 시정 조치 보고서 출력 -->
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
					<th class="necessary">${msg.C100000354}</th> <!-- 발행일자 -->
					<td>
						<input type="text" class="wd6p schClass dateChk" style="min-width: 6em;" name="schPblicteStDte" id="schPblicteStDte" required> ~
						<input type="text" class="wd6p schClass dateChk" style="min-width: 6em;" name="schPblicteEndDte" id="schPblicteEndDte" required>
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
			<div id="vendorAuditLgstrMList" class="mgT15" style="width:100%; margin:0 auto;"></div>
		</div>
	</div>
	<br>
	<!-- 원료사Audit 상세정보 시작 -->
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000628}</h2> <!-- 원료사Audit 지적사항 상세정보 -->
		<div class="btnWrap">
			<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button type="button" id="btn_del" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
			<button type="button" id="btn_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
			
		</div>
		<form id="verdorAuditLgstrForm">
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
					<th class="necessary">${msg.C100000015}</th> <!-- CAR NO. -->
					<td>
						<input type="text" id="carNo" name="carNo" class="wd63p" readonly required>
						<input type="hidden" id="auditSeqno" name="auditSeqno">
						<button type="button" id="auditRceptNoSch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
						<button type="button" id="auditRceptNoReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
					</td>
					<th class="necessary">${msg.C100000354}</th> <!-- 발행일자 -->
					<td>
						<input type="text" id="pblicteDte" name="pblicteDte" class="wd100p dateChk" required>
					</td>
					<th>${msg.C100000355}</th> <!-- 발행자 -->
					<td>
						<input type="text" id="pblshrNm" name="pblshrNm" class="wd100p">
					</td>
					<th>${msg.C100000477}</th> <!-- 상태 -->
					<td>
						<label><input type="radio" name="openAt" value="Y" checked>${msg.C100000070}</label>
						<label><input type="radio" name="openAt" value="N">${msg.C100000019}</label>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000592}</th> <!-- 업체 -->
					<td colspan="3">
						<input type="text" id="suplyEntrpsNm" name="suplyEntrpsNm" class="wd100p" readonly>
						<input type="hidden" id="entrpsSeqno" name="entrpsSeqno">
					</td>
					<th>${msg.C100000833}</th> <!-- 주관부서 -->
					<td>
						<input type="text" id="mngtDeptNm" name="mngtDeptNm" class="wd100p">
					</td>
					<th>${msg.C100000144}</th> <!-- 검토자 -->
					<td>
						<input type="text" id="chckerNm" name="chckerNm" class="wd100p">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000402}</th> <!-- 부적합내용 -->
					<td colspan="8">
						<textarea id="improptCn" name="improptCn" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000631}</th> <!-- 원인 -->
					<td colspan="8">
						<textarea id="improptCause" name="improptCause" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000542}</th> <!-- 시정조치 개선전 -->
					<td colspan="8">
						<textarea id="imprvmBfeCn" name="imprvmBfeCn" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000543}</th> <!-- 시정조치 개선후 -->
					<td colspan="8">
						<textarea id="imprvmAfterCn" name="imprvmAfterCn" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000544}</th> <!-- 시정조치기한 -->
					<td>
						<input type="text" id="corecManagtDte" name="corecManagtDte" class="wd100p dateChk">
					</td>
					<th>${msg.C100000547}</th> <!-- 시정조치담당 -->
					<td colspan="5">
						<input type="text" id="corecChargerNm" name="corecChargerNm" class="wd100p">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000965}</th> <!-- 효과검증 -->
					<td colspan="8">
						<textarea id="effectVrifyCn" name="effectVrifyCn" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000754}</th> <!-- 재발방지대책 예방조치 -->
					<td colspan="8">
						<textarea id="prevntManagtCn" name="prevntManagtCn" class="wd100p"></textarea>
					</td>
				</tr>
				<tr>
					<th>${msg.C100000611}</th> <!-- 예방조치기한 -->
					<td>
						<input type="text" id="managtResultDte" name="managtResultDte" class="wd100p dateChk">
					</td>
					<th>${msg.C100000612}</th> <!-- 예방조치담당 -->
					<td colspan="5">
						<input type="text" id="managtChargerNm" name="managtChargerNm" class="wd100p">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000271}</th> <!-- 담당자 -->
					<td>
						<input type="text" id="managtResultChargerNm" name="managtResultChargerNm" class="wd100p">
					</td>
					<th>${msg.C100000144}</th> <!-- 검토자 -->
					<td>
						<input type="text" id="managtResultChckerNm" name="managtResultChckerNm" class="wd100p">
					</td>
					<th>${msg.C100000537}</th> <!-- 승인자 -->
					<td colspan="3">
						<input type="text" id="managtResultConfmerNm" name="managtResultConfmerNm" class="wd100p">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000406}</th> <!-- 부적합 첨부파일 -->
					<td colspan="3">
						<div id="dropZoneArea_impropt"></div>
						<input type="hidden" id="improptAtchmnflSeqno" name="improptAtchmnflSeqno" value="">
						<input type="button" id="btnSave_improptAtchmnflSeqno" style="display: none;">
					</td>
					<th>${msg.C100000823}</th> <!-- 조치결과 첨부파일 -->
					<td colspan="3">
						<div id="dropZoneArea_managtResult"></div>
						<input type="hidden" id="managtResultAtchmnflSeqno" name="managtResultAtchmnflSeqno" value="">
						<input type="button" id="btnSave_managtResultAtchmnflSeqno" style="display: none;">
					</td>
				</tr>
			</table>
			<input type="hidden" id="auditCarSeqno" name="auditCarSeqno">
		</form>
	</div>

	<div class="accordion_wrap mgT17">	
		<div class="accordion ">${msg.C100001009}</div>  <!-- 원료사 Audit 지적사항 이력 -->
		<div id="acc1" class="acco_top mgT15" style="display: none">
			<h3>${msg.C100000983}</h3> <!-- 품질 문서 이력 -->
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div class="subCon2">
				<div id="VendorAudLgstrHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</div>

<!--  body 끝 -->
</tiles:putAttribute>
<tiles:putAttribute name="script">
<script type="text/javascript"></script>
<script>
var vendorAuditLgstrMList = 'vendorAuditLgstrMList';
var VendorAudLgstrHistGrid = 'VendorAudLgstrHistGrid';
var dropZoneArea_impropt;
var dropZoneArea_managtResult;
var lang = ${msg}; // 기본언어
$(document).ready(function(){
	//원료사Audit 목록 그리드 세팅
	setVendorAuditLgstrMListGrid();

	// 품질 문서 이력 그리드 세팅
	setVendorAudLgstrHistGrid();

	//그리드 이벤트 선언
	setGridEvent();

	//콤보 박스 초기화
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	openDialog();

	dropZoneArea_impropt = DDFC.bind().EventHandler("dropZoneArea_impropt",{ btnId : "btnSave_improptAtchmnflSeqno" ,lang : "${msg.C100000867}"} );
	dropZoneArea_managtResult = DDFC.bind().EventHandler("dropZoneArea_managtResult",{ btnId : "btnSave_managtResultAtchmnflSeqno" ,lang : "${msg.C100000867}"} );

	gridResize(['vendorAuditLgstrMList', 'VendorAudLgstrHistGrid']);
});

//콤보 박스 초기화
function setCombo(){
	datePickerCalendar(["pblicteDte"],false);
	datePickerCalendar(["corecManagtDte"],false);
	datePickerCalendar(["managtResultDte"],false);
	datePickerCalendar(["schPblicteStDte","schPblicteEndDte"],true,["YY",-1]);
}


//문서 목록 그리드 세팅
function setVendorAuditLgstrMListGrid(){
	var col = [];

	auigridCol(col);

	col.addColumnCustom("auditCarSeqno", "Audit 지적사항 일렬번호", "*" ,false); /* Audit 지적사항 일렬번호 */
	col.addColumnCustom("suplyEntrpsNm", "${msg.C100000584}", "*" ,true); /* 업체 */
	col.addColumnCustom("carNo", "${msg.C100000015}", "*", true); /* CAR No. */
	col.addColumnCustom("improptCn", "${msg.C100000403}", "*", true); /*부적합 내용(NON-COMPLIANCE) */
	col.addColumnCustom("improptCause", "${msg.C100000633}", "*", true); /* 원인(ROOT CAUSE) */
	col.addColumnCustom("imprvmAfterCn", "${msg.C100000117}", "*", true); /* 개선 후 */
	col.addColumnCustom("openAtNm", "${msg.C100000477}", "*", true); /* 상태 */
	col.addColumnCustom("mngtDeptNm", "${msg.C100000834}", "*", true);	/* 주관부서(RESP.DEPT.) */
	col.addColumnCustom("corecChargerNm", "${msg.C100000545}", "*", true);  /* 시정조치 담당자 */
	col.addColumnCustom("corecManagtDte", "${msg.C100000544}", "*", true); /* 시정조치 기한 */

	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "singleCell",// 셀 선택모드 (기본값: singleCell)
 			enableCellMerge : true
 	}


	//auiGrid 생성
	vendorAuditLgstrMList = createAUIGrid(col, "vendorAuditLgstrMList", cusPros);

	// 그리드 칼럼 리사이즈
	AUIGrid.bind(vendorAuditLgstrMList, "ready", function(event) {
		gridColResize([vendorAuditLgstrMList],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

// 품질 문서 이력 그리드 세팅
function setVendorAudLgstrHistGrid() {

	var col2 = [];

	var cusPros = {
		editable : false,
		selectionMode : "multipleCells",
		enableCellMerge : true
 	};

	auigridCol(col2);
	col2.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)  // 품질문서이력 일렬번호
	.addColumnCustom('tableNm',"${msg.C100000973}",'*',true,false)                // 테이블명
	.addColumnCustom('tableCmNm',"${msg.C100000974}",'*',true,false)              // 테이블 주석명
	.addColumnCustom('columnNm',"${msg.C100000975}",'*',true,false)               // 컬럼명
	.addColumnCustom('columnCmNm',"${msg.C100000976}",'*',true,false)             // 컬럼 주석명
	.addColumnCustom('seqno','일련번호','*',false,false)                       // 일련번호
	.addColumnCustom('changeBfeCn',"${msg.C100000382}",'*',true,false)            // 변경 전
	.addColumnCustom('changeAfterCn',"${msg.C100000384}",'*',true,false)          // 변경 후
	.addColumnCustom('changerNm',"${msg.C100000977}",'*',true,false)              // 최종 변경자
	.addColumnCustom('lastChangeDt',"${msg.C100000978}",'*',true,false);          // 최종 변경 일시

	VendorAudLgstrHistGrid = createAUIGrid(col2, "VendorAudLgstrHistGrid", cusPros);

	AUIGrid.bind(VendorAudLgstrHistGrid, "ready", function(event) {
// 		gridColResize([VendorAudLgstrHistGrid],"2");
	});

}

/*==============그리드 함수==============*/
//그리드 이벤트 선언
function setGridEvent(){
	//문서목록 그리드 더블클릭
	AUIGrid.bind(vendorAuditLgstrMList, "cellDoubleClick", function(event) {
		detailAutoSet({
			item : event.item,
			targetFormArr:["verdorAuditLgstrForm"],
			successFunc : function() {
				getAudLgstrHist(event.item.auditCarSeqno);
			}
		});

		dropZoneArea_impropt.getFiles(event.item.improptAtchmnflSeqno);
		dropZoneArea_managtResult.getFiles(event.item.managtResultAtchmnflSeqno);
	});
}

/*==============버튼 함수==============*/
//버튼 이벤트
function setButtonEvent(){
	$("#btn_select").click(function(){
		getVendorAuditLgstrMList();
	});

	
	$("#btn_del").click(function(){
		if(!$("#auditCarSeqno").val()){
			alert("${msg.C100000484}");
			return false;
		}
		else{
			if(confirm("${msg.C100000461}")){
				delVendorAuditLgstr();	
			}
			else{
				return false;
			}	
		}
		
	});
	
	$("#btn_save").click(function(){
		insVendorAuditLgstr();
	});
	
	$("#btn_new").click(function(){
		formReset();
	});

	
	$("#btn_viewReport").click(function(){
		var param = AUIGrid.getSelectedItems(vendorAuditLgstrMList)[0].item.auditCarSeqno;
		LabelPreview(param);
	});

	
	$("#auditRceptNoReset").click(function(){
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
				AUIGrid.resize(vendorAuditLgstrMList);
				AUIGrid.resize(VendorAudLgstrHistGrid);

				var seqno = $("#auditCarSeqno").val() != '' ? $("#auditCarSeqno").val() : null;
				getAudLgstrHist(seqno);
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
function getVendorAuditLgstrMList(){
	if(!saveValidation('searchFrm')) {
		return false;
	}
	var url = "<c:url value='/qa/getVendorAuditLgstrMList.lims'/>"
	getGridDataForm(url,"searchFrm", vendorAuditLgstrMList);
}

function getAudLgstrHist(seqno) {
	var param = {
		"tableNm" : "VENDOR_RS_AUDIT_CAR"
	};

	if(!!seqno) {
		param.seqno = seqno;
		getGridDataParam('/com//getQlityDocHistList.lims', param, VendorAudLgstrHistGrid);
	}else {
		return;
	}
}

function insVendorAuditLgstr(){
	if(!saveValidation("verdorAuditLgstrForm")) return false;

	var url = "<c:url value='/qa/insVendorAuditLgstr.lims'/>";

	$.when(
		fileSave(dropZoneArea_impropt,"improptAtchmnflSeqno")
		,fileSave(dropZoneArea_managtResult,"managtResultAtchmnflSeqno")
	).then(function(data){
		console.log(data);
		customAjax({
			"url" : url,
			"data" : $("#verdorAuditLgstrForm").serializeObject(),
			"successFunc":function(data){
				if (data != 1){
					err("${msg.C100000597}"); /* 오류가 발생했습니다. */
				} else {
					success("${msg.C100000765}"); /* 저장 되었습니다. */
					getVendorAuditLgstrMList();
					AUIGrid.clearGridData(VendorAudLgstrHistGrid);
					formReset();
				}
			}
		});
	});
}

function delVendorAuditLgstr(){
	
	var url = "<c:url value='/qa/delVendorAuditLgstr.lims'/>";

	var param = {auditCarSeqno : $("#auditCarSeqno").val()}
	customAjax({
		"url" : url,
		"data" : param,
		"successFunc":function(data){
			if (data != 1){
				err("${msg.C100000597}"); /* 삭제에 실패하였습니다. */
			} else {
				success("${msg.C100000462}"); /* 삭제 되었습니다. */
				getVendorAuditLgstrMList();
				AUIGrid.clearGridData(VendorAudLgstrHistGrid);
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
        dropZoneArea.on("uploadComplete", function(event, fileIdx){
            if( fileIdx == -1 ){
                err("${msg.C100000864}");
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
	dialogVendorAudit("auditRceptNoSch",null,"vendorAuditDialog","S",function(data){
		$("#carNo").val(data["auditRceptNo"]);
		$("#auditSeqno").val(data["auditSeqno"]);
		$("#suplyEntrpsNm").val(data["entrpsNm"]);
		$("#entrpsSeqno").val(data["entrpsSeqno"]);
	});
}

function LabelPreview(seqno){
	var param = {
		printngSeCode : 'SY15000001',
		printngOrginlFileNm : 'CAR(C).mrd'
	};

	customAjax({
		"url": "/com/printCours.lims",
		"data": param,
		"successFunc": function(data) {
			if(data.length == 1) {
// 				RdUrl = data[0].printngOrginlFileNm; // 로컬 rd서버 기준
				RdUrl = data[0].printngCours; // 실서버, 테스트용 서버 기준
				
				if(gridData.length == 0) {
					alert("${msg.C000001356}")  /* 출력할 데이터가 없습니다. */
					return;
				}
				html5Viewer([RdUrl], seqno);
			}else {
				err('${msg.C100000597}') /* 오류가 발생했습니다. */
				return;
			}
		}
	});
}

//폼 RESET
function formReset(){
	$('#verdorAuditLgstrForm')[0].reset();

	$("#verdorAuditLgstrForm input[type=hidden]").val('');


	datePickerCalendar(["pblicteDte"],false);
	datePickerCalendar(["corecManagtDte"],false);
	datePickerCalendar(["managtResultDte"],false);

	dropZoneArea_impropt.clear();
	dropZoneArea_managtResult.clear();
}
//엔터키 이벤트
function doSearch(e){
	getVendorAuditLgstrMList();
}

</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
