<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@page import="lims.sys.vo.UserMVo"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent" id="middle_wrap">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000100}</h2> <!-- VOC 목록 -->
			<div class="btnWrap">
				<button  id="selectVoc" class="search" >${msg.C100000767}</button> <!-- 조회 -->
			</div>
		<form action="javascript:;" id="vocSeForm" name="vocSeForm">
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
					<th >${msg.C100000187}</th> <!-- 고객사 -->
					<td ><input type="text"  id="ctmmnyNmSch" name="ctmmnyNmSch" class="schClass"></td>
					<th >${msg.C100000809}</th> <!-- 제품명 -->
					<td ><input id="mtrilNmSch" name="mtrilNmSch"  type="text" class="schClass"></td>
					<th >${msg.C100000802}</th> <!-- 제목 -->
					<td ><input type="text"  id="sjSch" name="sjSch" class="schClass"></td>
					<th >${msg.C100000846}</th> <!-- 진행 상황 -->
					<td><select id="vocProgrsSittnCode" name="vocProgrsSittnCode" class="wd100p" style="min-width:10em;"></select></td>
				</tr>
				<tr>
					<th class="necessary">${msg.C100000791}</th> <!-- 접수 일자 -->
					<td>
					 <input type="text" id="vocBeginDteSch" name="vocBeginDteSch" class="wd6p dateChk schClass" style="min-width: 6em;" required> 
                  		~ 	
                  	<input type="text" id="vocEndDteSch" name="vocEndDteSch" class="wd6p dateChk schClass" style="min-width: 6em;" required>
					</td>
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td><select  id="bplcCodeSch" name="bplcCodeSch" class="schClass"></select></td>
					<td colspan="4"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
				</tr>
			</table>
		</form>
	</div>
	<div id="VocList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
	<br>
	<div id="tabMenuLst" class="tabMenuLst round skin-peter-river mgT15">
		<ul id="tabs">
		      <li id="tab1" class="on">${msg.C100000102}</li> <!-- VOC등록 -->
	          <li id="tab2">${msg.C100000280}</li> <!-- 대책등록 -->
	          <li id="tab3">${msg.C100000648}</li> <!-- 유효성 검증 -->
	    </ul>
	</div>
	
	<div id="tabCtsLst">
	<!---------------------------------------------- VOC등록 시작 -------------------------------->
	   	<div id="tabCts1" class="tabCts">
	   		<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000103}</h2> <!-- VOC 상세 정보 -->
				<div class="btnWrap">
					<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button type="button" id="btn_deployment" class="btn5">${msg.C100000362}</button> <!-- 배포 -->
					<input type="hidden" id="btn_deployment_hidden">
					<button type="button" id="btn_delete" class="delete" >${msg.C100000458}</button> <!-- 삭제 -->
					<button type="button" id="btn_temporary_save" class="save">${msg.C100000688}</button> <!-- 임시저장 -->
					<button type="button" id="btn_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
					
					<input type="hidden" id="vocSave" name="vocSave">
				</div>
				<form id="vocDetailFrm" name ="vocDetailFrm">
					<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="vocInfotbl">
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
							<th style="min-width:150px;">${msg.C100000802}</th> <!-- 제목 -->
							<td colspan="5">
								<input type="text" id="sj" name="sj" class="wd100p" style="min-width:10em;" maxlength="100" >
							</td>
							<th>${msg.C100000793}</th> <!-- 접수번호 -->
							<td>
								<input type="text" id="vocRceptNo" name="vocRceptNo" class="wd100p" style="min-width:10em;" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th>${msg.C100000729}</th> <!-- 작성부서 -->
							<td>
								<input type="text" id="writngDeptNm" name="writngDeptNm" value="${UserMVo.inspctInsttNm}" class="wd100p" style="min-width:10em;" readonly="readonly" >
								<input type="hidden" id="writngDeptCode" name="writngDeptCode" value="${UserMVo.deptCode}" >
							</td>
								
							<th class = "necessary">${msg.C100000730}</th> <!-- 작성자 -->
							<td>
								<input type="text" id="wrterNm" name="wrterNm" class="wd63p" value="${UserMVo.userNm}" style="min-width:10em;" readonly="readonly" required>
								<input type="hidden" id="wrterId" name="wrterId" value="${UserMVo.userId}" >
								<button type="button" id="wrterIdSearch" class="inTableBtn inputBtn btn5"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
								<button type="button" id="wrterReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
							</td>
							<th>${msg.C100000728}</th> <!-- 작성일자 -->
							<td>
								<input type="text" id="writngDte" name="writngDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);" autocomplete=off required maxlength="10">
							</td>
							<th>${msg.C100000205}</th> <!-- 구분 -->
							<td><select id="vocSeCode" name="vocSeCode" class="wd100p" style="min-width:10em;"></select></td>
						</tr>
						<tr>
							<th>${msg.C100000790}</th> <!-- 접수부서 -->
							<td>
								<input type="text" id="rceptDeptNm" name="rceptDeptNm" class="wd100p" style="min-width:10em;" maxlength="200" >
						   	</td>
							   
							<th>${msg.C100000794}</th> <!-- 접수자 -->
							<td>
								<input type="text" id="rcepterNm" name="rcepterNm" class="wd100p" style="min-width:10em;" maxlength="200" >
							</td>
							<th>${msg.C100000791}</th> <!-- 접수 일자 -->
							<td>
								<input type="text" id="rceptDte" name="rceptDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')" autocomplete=off >
							</td>
							<th class="necessary">${msg.C100000186}</th> <!-- 고객명 -->
							<td>
								<input type="text" id="ctmmnyNm" name="ctmmnyNm"  class="wd60p" style="min-width:10em;" readonly="readonly" required >
								<input type="hidden" id="ctmmnySeqno" name="ctmmnySeqno" >
								<button type="button" id="ctmmnySearch" class="inTableBtn inputBtn btn5"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
								<button type="button" id="ctmmnyReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
							</td>
						</tr>
						<tr>
							<th>${msg.C100000185}</th> <!-- 고객라인 -->
							<td style="text-align:left;">
								<input type="text" id="ctmmnyLineNm" name="ctmmnyLineNm" class="wd100p" style="min-width:10em;" maxlength="200" >
							</td>
							
							<th class="necessary">${msg.C100000809}</th> <!-- 제품명 -->
							<td>
								<input type="text" id="mtrilNm" name="mtrilNm" class="wd63p" style="min-width:10em;" required readonly="readonly" >
								<input type="hidden" id="mtrilSeqno" name="mtrilSeqno" >
								<button type="button" id="mtrilSeqnoSearch" class="inTableBtn inputBtn btn5"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
								<button type="button" id="mtrilReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
							</td>	
							<th class="necessary">${msg.C100000350}</th> <!-- 발생LOT -->
							<td>
								<input type="text" id="occrrncLotId" name="occrrncLotId" class="wd100p" style="min-width:10em;" maxlength="20"  required>
							</td>
							<th class="necessary">${msg.C100000420}</th> <!-- 불량명 -->
							<td>
								<select id="vocBadnSeCode" name="vocBadnSeCode" class="wd100p" style="min-width:10em;" required></select>
							</td>
						</tr>
						<tr>
							<th >${msg.C100000351}</th> <!-- 발생공정 -->
							<td>
								<input type="text" id="occrrncFairNm" name="occrrncFairNm"  class="wd100p" style="min-width:10em;" maxlength="200">
							</td>
							<th class="necessary">${msg.C100000478}</th> <!-- 생산공장 -->
							<td>
								<select id="bplcCode" name="bplcCode" class="wd100p" style="min-width:10em;" required></select>
							</td>
							<th class="necessary">${msg.C100000617}</th> <!-- 용기 -->
							<td>
								<select id="cntnrSeCode" name="cntnrSeCode" class="wd100p" style="min-width:10em;" required></select>
							</td>
							<th>${msg.C100000422}</th> <!-- 불량수/불량률 -->
							<td>
								<input type="text" id="badnCo" name="badnCo" class="wd100p" style="min-width:10em;" maxlength="10"  onkeydown="onlyNumber(this)">
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000421}</th> <!-- 불량발생일 -->
							<td>
								<input type="text" id="badnOccrrncDte" name="badnOccrrncDte"  class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);" autocomplete=off required maxlength="10">
							</td>
							<th>${msg.C100000755}</th> <!-- 재발여부 -->
							<td>
								<label><input type="radio" id="recrAt_Y" name="recrAt" value="Y" >Y</label> <!-- 사용 -->
								<label><input type="radio" id="recrAt_N" name="recrAt" value="N" checked>N</label> <!-- 사용안함 -->
							</td>
							<th>${msg.C100000281}</th> <!-- 대책수립 -->
							<td>
								<label><input type="radio" id="cntrplnFoundngAt_Y" name="cntrplnFoundngAt" value="Y" >Y</label> <!-- 사용 -->
								<label><input type="radio" id="cntrplnFoundngAt_N" name="cntrplnFoundngAt" value="N" checked>N</label> <!-- 사용안함 -->
							</td>
							<th>${msg.C100000282}</th> <!-- 대책수립부서 -->
							<td>
								<input type="text" id="cntrplnFoundngDeptNm" name="cntrplnFoundngDeptNm" class="wd100p" style="min-width:10em;" maxlength="200" >
							</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000419}</th> <!-- 불량 현상 -->
							<td colspan="7">
							    <textarea id="badnPhnomenDc" name="badnPhnomenDc" rows="3" class="wd100p" style="min-width:10em;" maxlength="4000" required ></textarea>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부파일 -->
							<td colspan="7">
								<!-- 파일첨부영역 -->
								<div id="dropZoneArea"></div>
								<input type = "hidden" id = "btn_fileSave">
								<input type="text" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width:10em;display:none;">
							</td>
						</tr>
					</table>
					<br>
					<h3>${msg.C100000282}</h3> <!-- 대책수립부서 -->
					<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1 mgT5" id="userInfotbl">
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
							<th style="min-width:150px;" class="necessary">${msg.C100000283}</th> <!-- 대책수립실시 -->
								<td >
									<label><input type="radio" id="cntrplnFoundngOprtnAt_Y" name="cntrplnFoundngOprtnAt" value="Y" checked>${msg.C100000533}</label> <!-- 승인 -->
									<label><input type="radio" id="cntrplnFoundngOprtnAt_N" name="cntrplnFoundngOprtnAt" value="N" >${msg.C100000343}</label> <!-- 반려 -->
								</td>
							 <th>${msg.C100000002}</th> <!-- [불가] 시 사유 -->
								<td colspan="5">
								<textarea id="imprtyResn" name="imprtyResn" rows="3" class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '4000')"></textarea>
									
								</td>
						</tr>
						<tr>
							<th class="necessary">${msg.C100000249}</th> <!-- 납기 -->
								<td>
									<input type="text" id="dedtDte" name="dedtDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);fnChkByte(this, '10')" autocomplete=off required >
								</td>
								
							 <th>${msg.C100000250}</th> <!-- 납기지정 사유 -->
								<td colspan="5">
								<textarea id="dedtAppnResn" name="dedtAppnResn" rows="3" class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '4000')"></textarea>
								</td>
						</tr>
					</table>
					<input type="hidden" id="crud" name="crud" value="C"/>
					<input type="hidden" id="temporaryYn" name="temporaryYn" value="N"/>
					<input type="hidden" id="vocSeqno" name="vocSeqno" />
					<input type="hidden" id="vocRegistSeqno" name="vocRegistSeqno" />
				</form>
			</div>
		</div>
<!---------------------------------------------- VOC등록 종료 -------------------------------->
<!---------------------------------------------- VOC 대책수립 시작 --------------------------- -->
		<div id="tabCts2" class="tabCts" style="display:none">
			<div class="subCon1">
				<h3>${msg.C100000099}</h3> <!-- VOC 대책수립 -->
				<div class="btnWrap">
					<button type="button" id="diagnose_btn_deployment" class="btn5">${msg.C100000362}</button> <!-- 배포 -->
					<button type="button" id="diagnose_btn_delete" class="delete" >${msg.C100000458}</button> <!-- 삭제 -->
					<button type="button" id="diagnose_btn_temporary_save" class="save" >${msg.C100000688}</button> <!-- 임시저장 -->
					<button type="button" id="diagnose_btn_save" class="save" >${msg.C100000760}</button> <!-- 저장 -->
					
					<input type="hidden" id="vocDiagnoseSave" name="vocDiagnoseSave">
					<input type="hidden" id="diagnose_btn_deployment_hidden" name="diagnose_btn_deployment_hidden">
				</div>
				<form id="vocDiagnoseFrm" name ="vocDiagnoseFrm">
					<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="vocInfotb2">
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
							<th style="min-width:150px;" class="necessary">${msg.C100000348}</th> <!-- 발생원인 -->
								<td colspan="5">
									<input type="text" id="occrrncCause" name="occrrncCause" class="wd100p" style="min-width:10em;" maxlength="4000" required >
								</td>
							 <th class="necessary">${msg.C100000279}</th> <!-- 대책적용시험 -->
								<td>
								<input type="text" id="cntrplnApplcDte" name="cntrplnApplcDte" class="wd100p dateChk" style="min-width:10em;" onkeyup="autoHypen(this);" autocomplete=off required maxlength="10" >
								</td>
							 
						</tr>
						<tr>
							<th >${msg.C100000226}</th> <!-- 근본원인 -->
								<td colspan="7">
									 <textarea id="basis" name="basis" rows="3" class="wd100p" style="min-width:10em;" maxlength="2000" ></textarea>
								</td>
						</tr>
						<tr>
								<th class="necessary">${msg.C100000860}</th> <!-- 첨부파일 -->
								<td colspan="7">
									<!-- 파일첨부영역 -->
									<div id="diagnoseDropZoneArea"></div>
									<input type = "hidden" id = "btn_diagnoseFileSave">
									<input type="text" id="diagnoseAtchmnflSeqno" name="diagnoseAtchmnflSeqno" class="wd33p"  style="min-width:10em;display:none;">
								</td>
						</tr>
					</table>
					<input type="text" id="vocCntrplnFoundngSeqno" name="vocCntrplnFoundngSeqno" style="display:none;">
					<input type="text" id="diagnoseTemporaryYn" name="diagnoseTemporaryYn" value="N" style="display:none;"/>
				</form>
			</div>
		</div>
		<!------------------------------------------------------- VOC 대책수립 종료 --------------------------------------------------------->
		<!------------------------------------------------------- VOC 유효성검증 시작 --------------------------------------------------------->
		<div id="tabCts3" class="tabCts" style="display:none">
			<div class="subCon1">
				<h3>${msg.C100000648}</h3> <!-- 유효성 검증 -->
				<div class="btnWrap">
					<button type="button" id="validVrify_btn_deployment" class="btn5">${msg.C100000362}</button> <!-- 배포 -->
					<button type="button" id="validVrify_btn_delete" class="delete" >${msg.C100000458}</button> <!-- 삭제 -->
					<button type="button" id="validVrify_btn_temporary_save" class="save" >${msg.C100000688}</button> <!-- 임시저장 -->
					<button type="button" id="validVrify_btn_save" class="save" >${msg.C100000760}</button> <!-- 저장 -->
					<input type="hidden" id="vocValidVrifySave" name="vocValidVrifySave">
					<input type="hidden" id="validVrify_btn_deployment_hidden" name="validVrify_btn_deployment_hidden">
				</div>
				<form id="vocValidVrifyFrm" name ="vocValidVrifyFrm">
					<table  cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="vocInfotb3">
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
							<th style="min-width:150px;" class="necessary">${msg.C100000651}</th> <!-- 유효성검증방법 -->
								<td colspan="5">
									<input type="text" id="validVrifyMth" name="validVrifyMth" class="wd100p" style="min-width:10em;" maxlength="4000" required >
								</td>
							 <th class="necessary">${msg.C100000650}</th> <!-- 유효성검증결과 -->
								<td>
								<label><input type="radio" id="validVrifyResultAt_Y" name="validVrifyResultAt" value="Y" checked>${msg.C100001026}</label> <!-- 유효성 있음 -->
								<label><input type="radio" id="validVrifyResultAt_N" name="validVrifyResultAt" value="N" >${msg.C100001027}</label> <!-- 재검토 -->
								</td>
							 
						</tr>
						<tr>
							<th class="necessary">${msg.C100000003}</th> <!-- [재검토]시 사유 -->
								<td colspan="7">
									 <textarea id="validVrifyResn" name="validVrifyResn" rows="3" class="wd100p" style="min-width:10em;" maxlength="2000" required ></textarea>
								</td>
						</tr>
						<tr>
								<th>${msg.C100000860}</th> <!-- 첨부파일 -->
								<td colspan="7">
									<!-- 파일첨부영역 -->
									<div id="validVrifyDropZoneArea"></div>
									<input type ="hidden" id = "btn_validVrifyFileSave">
									<input type="text" id="validVrifyAtchmnflSeqno" name="validVrifyAtchmnflSeqno" class="wd33p" style="min-width:10em;display:none;">
								</td>
						</tr>
					</table>
					<input type="text" id="vocValidVrifySeqno" name="vocValidVrifySeqno" style="display:none;">
					<input type="text" id="validVrifyTemporaryYn" name="validVrifyTemporaryYn" value="N" style="display:none;"/>
					<input type="text" id = "wdtbSeqno" name = "wdtbSeqno" style="display:none">
					<input type="text" id = "validVrifyWdtbSeqno" name = "validVrifyWdtbSeqno" style="display:none" >
					<input type="text" id = "cntrplnFoundngWdtbSeqno" name = "cntrplnFoundngWdtbSeqno" style="display:none" >
				</form>
			</div>
		</div>
		<!----------------------------------------------------------------------------- VOC 유효성검증 종료 --------------------------------------------------------->
	</div>
	<textarea id = "wdtbCn" name = "wdtbCn" style="display:none"></textarea>
	<textarea id = "wdtbSj" name = "wdtbSj" style="display:none"></textarea>

	<div class="accordion_wrap mgT17">	
		<div class="accordion ">${msg.C100000101}</div>  <!-- VOC 이력 -->
		<div id="acc1" class="acco_top mgT15" style="display: none">
			<h3>${msg.C100000983}</h3> <!-- 품질 문서 이력 -->
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div class="subCon2">
				<div id="vocDocHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
			</div>
		</div>
	</div>
</div>

</tiles:putAttribute>
<tiles:putAttribute name="script">

<script>

//AUIGrid 생성 후 반환 ID
var VocList = 'VocList';
var vocRegistList = 'vocRegistList';
var vocCntrplnFoundngList = 'vocCntrplnFoundngList';
var vocValidVrifyList = 'vocValidVrifyList';
var vocDocHistGrid = 'vocDocHistGrid';
var vocDropZoneArea;
var diagnoseDropZoneArea;
var validVrifyDropZoneArea;
var lang = ${msg};

$(document).ready(function() {

	//초기화
	init();
	
	//콤보 박스 초기화
	setCombo()
	
	// 그리드 세팅
	setVocGrid();

	// VOC 이력 그리드 세팅
	setVocDocHistGrid();

	//AUI 그리드 이벤트
	auiGridEvent();

	// 버튼 이벤트
	setButtonEvent();

	//팝업이벤트 
	popUp()
	
	gridResize([VocList,vocDocHistGrid]);
	
});


function init(){
	   //달력
	   //접수일자
	   datePickerCalendar(["vocBeginDteSch"], true, ["MM",-1]);
	   datePickerCalendar(["vocEndDteSch"], true, ["MM",0]);
	   datePickerCalendar(["writngDte"], true, ["DD",0], ["DD",0]);
	   datePickerCalendar(["badnOccrrncDte"], false, ["DD",0], ["DD",0]);
	   datePickerCalendar(["rceptDte"], false, ["DD",0], ["DD",0]);
	   datePickerCalendar(["dedtDte"], false, ["DD",0], ["DD",0]);
	   datePickerCalendar(["cntrplnApplcDte"], false, ["DD",0], ["DD",0]);
	   //작성자 부서,정보
	   dialogUser("wrterIdSearch", "", "inspctCrrctDialog", function(item){
			$('#ctmmnyNm').val(item.userNm);
			$('#ctmmnySeqno').val(item.userId);
			$('#writngDeptCode').val(item.deptCode);
			$('#writngDeptNm').val(item.inspctInsttNm);
		});
		//고객사 정보 조회
	   dialogEntrps("ctmmnySearch", "SY08000002", "entrpsDialog", function(data){
			$("#ctmmnyNm").val(data["entrpsNm"]);
			$("#ctmmnySeqno").val(data["entrpsSeqno"]);

		}, null);
	   //자재 명 조회
	 	var mtrilData = {
				bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
				authorSeCode : '${UserMVo.authorSeCode}'
		};
	   
	 	dialogMtril("mtrilSeqnoSearch", mtrilData, "Product", function(item){
			$("#mtrilSeqno").val(item.mtrilSeqno);
			$("#mtrilNm").val(item.mtrilNm);
	 	},null,null,null,'Y');
	 	
	 	//드랍존
		vocDropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "#btn_fileSave", maxFiles : 5, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */
		
		diagnoseDropZoneArea = DDFC.bind().EventHandler("diagnoseDropZoneArea", { btnId : "#btn_diagnoseFileSave", maxFiles : 5, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */
		
		validVrifyDropZoneArea = DDFC.bind().EventHandler("validVrifyDropZoneArea", { btnId : "#btn_validVrifyFileSave", maxFiles : 5, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */  
	   
		$("#tab2").css({ 'pointer-events': 'none' });
		$("#tab3").css({ 'pointer-events': 'none' });
		$("#btn_deployment").hide();
		$("#diagnose_btn_deployment").hide();
		$("#validVrify_btn_deployment").hide();
		
		
	}


function setCombo(){
	   //발생 원인
	   ajaxJsonComboBox('/com/getCmmnCode.lims','vocProgrsSittnCode',{"upperCmmnCode" : "RS06"}, false,"${msg.C100000480}"); /* 선택 */
	   ajaxJsonComboBox('/com/getCmmnCode.lims','vocSeCode',{"upperCmmnCode" : "RS05"}, false,"${msg.C100000480}"); /* 선택 */
	   ajaxJsonComboBox('/com/getCmmnCode.lims','vocBadnSeCode',{"upperCmmnCode" : "RS07"}, false,"${msg.C100000480}"); /* 선택 */
	   //용가구분
	   ajaxJsonComboBox('/com/getCmmnCode.lims','cntnrSeCode',{"upperCmmnCode" : "SY10"}, false,"${msg.C100000480}"); /* 선택 */
	 //사업장
		ajaxJsonComboBox('/wrk/getBestComboList.lims','bplcCode',null,false,"${msg.C100000480}",'${UserMVo.bestInspctInsttCode}'); //조직목록 사업장명
	}

//그리드 세팅 이벤트
function setVocGrid(){

	var voc = [];
	
	//공통코드 그리드 정의
	auigridCol(voc);
	
	voc.addColumnCustom("ctmmnyNm","${msg.C100000186}","*",true,false); /* 고객명 */
	voc.addColumnCustom("sj","${msg.C100000802}", "*", true,false); /* 제목 */
	voc.addColumnCustom("vocRceptNo","${msg.C100000793}","*",true,true); /* 접수번호 */
	voc.addColumnCustom("mtrilNm","${msg.C100000809}","*",true,false); /* 제품명 */
	voc.addColumnCustom("vocBadnSeNm","${msg.C100000420}","*",true,false); /* 불량명 */
	voc.addColumnCustom("bplcNm","${msg.C100000432}","*",true,false); /* 사업장 */
	voc.addColumnCustom("writngDeptNm","${msg.C100000729}","*",true,false); /* 작성부서 */
	voc.addColumnCustom("wrterNm","${msg.C100000730}","*",true,false); /* 작성자 */
	voc.addColumnCustom("writngDte","${msg.C100000791}","*",true,false); /* 접수일자 */
	voc.addColumnCustom("cntrplnApplcDte","${msg.C100000284}","*",true,false); /* 대책수립일자 */
	voc.addColumnCustom("validVrifyDte","${msg.C100000652}","*",true,false); /* 유효성검증일자 */
	voc.addColumnCustom("vocProgrsSittnNm","${msg.C100000846}","*",true,false); /* 진행 상황 */
	voc.addColumnCustom("vocProgrsSittnCode","vocProgrsSittnCode","*",false,false); /* 진행 상황 코드 */
	voc.addColumnCustom("ctmmnySeqno","ctmmnySeqno","*",false,false); /* 고객시퀀스 */
	voc.addColumnCustom("bplcCode","bplcCode","*",false,false); /*사업장코드*/
	voc.addColumnCustom("writngDeptCode","writngDeptCode","*",false,false); /*장성 부서 코드*/
	voc.addColumnCustom("wrterId","wrterId","*",false,false); 
	voc.addColumnCustom("vocSeqno","vocSeqno","*",false,false); 
	voc.addColumnCustom("atchmnflSeqno","atchmnflSeqno","*",false,false); 
	voc.addColumnCustom("vocRegistSeqno","vocRegistSeqno","*",false,false); 
	voc.addColumnCustom("vocCntrplnFoundngSeqno","vocCntrplnFoundngSeqno","*",false,false); /*VOC 대책 수립 일련번호  */
	voc.addColumnCustom("vocValidVrifySeqno","vocValidVrifySeqno","*",false,false); /*VOC 유효 검증 일련번호 */
	voc.addColumnCustom("wdtbSeqno","wdtbSeqno","*",false,false); /*VOC 등록 배포 일련번호 */
	voc.addColumnCustom("cntrplnFoundngWdtbSeqno","cntrplnFoundngWdtbSeqno","*",false,false); /*VOC 대책수립 배포 일련번호 */
	voc.addColumnCustom("validVrifyWdtbSeqno","validVrifyWdtbSeqno","*",false,false); /*VOC 유효성검증 배포 일련번호 */
	
	var cusPros = {
		editable : false,
		selectionMode : "multipleCells",
		enableCellMerge : true
	};  
	
	VocList = createAUIGrid(voc, "VocList", cusPros);

	AUIGrid.bind(VocList, "ready", function(event) {
		gridColResize([VocList], "2");
	});

}

// VOC 이력 그리드
function setVocDocHistGrid() {

	var col = [];

	var cusPros = {
		editable : false,
		selectionMode : "multipleCells",
		enableCellMerge : true
	}; 

	auigridCol(col);
	col.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)  // 품질문서이력 일렬번호
	.addColumnCustom('tableNm',lang.C100000973,'*',true,false)                // 테이블명
	.addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              // 테이블 주석명
	.addColumnCustom('columnNm',lang.C100000975,'*',true,false)               // 컬럼명
	.addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             // 컬럼 주석명
	.addColumnCustom('seqno','일련번호','*',false,false)                       // 일련번호
	.addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            // 변경 전
	.addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)          // 변경 후
	.addColumnCustom('changerNm',lang.C100000977,'*',true,false)              // 최종 변경자
	.addColumnCustom('lastChangeDt',lang.C100000978,'*',true,false);          // 최종 변경 일시
	
	vocDocHistGrid = createAUIGrid(col, vocDocHistGrid, cusPros);

	

	AUIGrid.bind(vocDocHistGrid, "ready", function(event) {
// 	    gridColResize([vocDocHistGrid],"2");
	});

}
function btnEvent(event){
	//버튼 전부 블록
	//voc등록
		$("#btn_delete").css("display","inline-block");
		$("#btn_temporary_save").css("display","inline-block");
		$("#btn_save").css("display","inline-block");
	//대책수립tab버튼
		$("#diagnose_btn_delete").css("display","inline-block");
		$("#diagnose_btn_temporary_save").css("display","inline-block");
		$("#diagnose_btn_save").css("display","inline-block");
	//유효성tab버튼
		$("#validVrify_btn_delete").css("display","inline-block");
		$("#validVrify_btn_temporary_save").css("display","inline-block");
		$("#validVrify_btn_save").css("display","inline-block");
	
	
	if(event.item.vocProgrsSittnCode == 'RS06000002'){
   		$("#tab2").css({ 'pointer-events': 'auto' });
   		$("#btn_deployment").show(); // VOC 등록 배포 버튼 오픈
   		$("#diagnose_btn_deployment").hide(); //대책수립  배포 버튼
		$("#validVrify_btn_deployment").hide();
	}
	//유효성검증대기일경우 선택
	else if(event.item.vocProgrsSittnCode == 'RS06000003'){
   		$("#tab2").css({ 'pointer-events': 'auto' });
		$("#tab3").css({ 'pointer-events': 'auto' });
		//유효성검증대기일경우 대책수립 배포버튼 표출
		$("#btn_deployment").show();
		$("#diagnose_btn_deployment").show(); //대책수립  배포 버튼
		$("#validVrify_btn_deployment").hide();
	}
	//완료일경우 선택
	else if(event.item.vocProgrsSittnCode == 'RS06000004'){
   		$("#tab2").css({ 'pointer-events': 'auto' });
		$("#tab3").css({ 'pointer-events': 'auto' });
		//완료일경우 선택 유효성검증 배포버튼 표출
		$("#btn_deployment").show();
		$("#diagnose_btn_deployment").show();
		$("#validVrify_btn_deployment").show(); //유효성검증 배포 버튼
		}
	else{
		$("#btn_deployment").hide();
		$("#diagnose_btn_deployment").hide();
		$("#validVrify_btn_deployment").hide(); //유효성검증 배포 버튼
	}
	//버튼비활성화
	if(event.item.vocCntrplnFoundngSeqno != 0){
		$("#btn_delete").css("display","none");
   		$("#btn_temporary_save").css("display","none");
   		$("#btn_save").css("display","none");
	}
	if(event.item.vocValidVrifySeqno != 0){
		$("#btn_delete").css("display","none");
   		$("#btn_temporary_save").css("display","none");
   		$("#btn_save").css("display","none");
   		$("#diagnose_btn_delete").css("display","none");
   		$("#diagnose_btn_temporary_save").css("display","none");
   		$("#diagnose_btn_save").css("display","none");
	}
	
	
}
////AUI 그리드 이벤트 함수////
function auiGridEvent(){

   	//그룹코드 그리드 셀 클릭 이벤트
   	AUIGrid.bind(VocList, "cellDoubleClick", function(event) {
   		$("#tab1").click();
   		$("#crud").val("U");
   		//탭이동못하도록 수정
   		$("#tab2").css({ 'pointer-events': 'none' });
		$("#tab3").css({ 'pointer-events': 'none' });
		
		btnEvent(event);
   	
		getVocDocHist(event.item.vocSeqno);
   		
		$("#cntrplnFoundngWdtbSeqno").val(event.item.cntrplnFoundngWdtbSeqno);
		$("#validVrifyWdtbSeqno").val(event.item.validVrifyWdtbSeqno);
   		//상세 데이터 호출
  		var param = {	"vocSeqno":event.item.vocSeqno
  						,"vocRegistSeqno":event.item.vocRegistSeqno};
   					
  		customAjax({"url":"/qa/getVocRegist.lims", "data":param , "successFunc":function(data){ 
			$("#sj").val(data[0].sj);//제목
			$("#wdtbSeqno").val(data[0].wdtbSeqno);
			$("#vocRceptNo").val(data[0].vocRceptNo);//접수번호
			$("#writngDeptNm").val(data[0].writngDeptNm);//작성부서
			$("#writngDeptCode").val(data[0].writngDeptCode);//작성부서코드
			$("#wrterNm").val(data[0].wrterNm);//작성자
			$("#wrterId").val(data[0].wrterId);//작성자ID
			$("#writngDte").val(data[0].writngDte);//작성일자
			$("#vocSeCode").val(data[0].vocSeCode);//구분
			$("#rceptDeptNm").val(data[0].rceptDeptNm);//접수부서
			$("#rcepterNm").val(data[0].rcepterNm);//접수자
			$("#rceptDte").val(data[0].rceptDte);//접수일자
			$("#ctmmnyNm").val(data[0].ctmmnyNm);//고객명
			$("#ctmmnySeqno").val(data[0].ctmmnySeqno);//고객코드
			$("#ctmmnyLineNm").val(data[0].ctmmnyLineNm);//고객라인
			$("#mtrilNm").val(data[0].mtrilNm);//제품명
			$("#mtrilSeqno").val(data[0].mtrilSeqno);//제품코드
			$("#occrrncLotId").val(data[0].occrrncLotId);//발생LOT
			$("#vocBadnSeCode").val(data[0].vocBadnSeCode);//불량명
			$("#occrrncFairNm").val(data[0].occrrncFairNm);//발생공정
			$("#bplcCode").val(data[0].bplcCode);//생산공장
			$("#cntnrSeCode").val(data[0].cntnrSeCode);//용기
			$("#badnCo").val(data[0].badnCo);//불량수
			$("#badnOccrrncDte").val(data[0].badnOccrrncDte);//불량발생일
			$("#cntrplnFoundngDeptNm").val(data[0].cntrplnFoundngDeptNm);//대책수립부서
			$("#badnPhnomenDc").val(data[0].badnPhnomenDc);//불량현상
			$("#imprtyResn").val(data[0].imprtyResn);//불가시 사유
			$("#dedtDte").val(data[0].dedtDte);//납기
			$("#dedtAppnResn").val(data[0].dedtAppnResn);//납기사유
			$("#vocRegistSeqno").val(data[0].vocRegistSeqno);//VOC 등록 일련번호
			$("#vocSeqno").val(data[0].vocSeqno);//VOC 일련번호
          	vocDropZoneArea.getFiles(data[0].atchmnflSeqno);
			if(data[0].badnOccrrncDte == 'Y'){//재발여부
			 	$('input[name="recrAt"]').filter("[value=Y]").prop("checked", true);
			}else if(data[0].badnOccrrncDte == 'N'){
		 		$('input[name="recrAt"]').filter("[value=N]").prop("checked", true);
			}
			if(data[0].cntrplnFoundngAt == 'Y'){//대책수립
		 		$('input[name="cntrplnFoundngAt"]').filter("[value=Y]").prop("checked", true);
			}else if(data[0].cntrplnFoundngAt == 'N'){
		 		$('input[name="cntrplnFoundngAt"]').filter("[value=N]").prop("checked", true);
			}
			if(data[0].cntrplnFoundngOprtnAt == 'Y'){//대책수립실시
		  		$('input[name="cntrplnFoundngOprtnAt"]').filter("[value=Y]").prop("checked", true);
			}else if(data[0].cntrplnFoundngOprtnAt == 'N'){
		  		$('input[name="cntrplnFoundngOprtnAt"]').filter("[value=N]").prop("checked", true);
			}
		}
   	});
  	if(event.item.vocCntrplnFoundngSeqno != 0){
	  	var diagnoseParam = {"vocSeqno":event.item.vocSeqno
					,"vocCntrplnFoundngSeqno":event.item.vocCntrplnFoundngSeqno};
		customAjax({
				"url":"/qa/getVocCntrplnFoundng.lims",
				"data":diagnoseParam , 
				"successFunc":function(data){ 
				$("#occrrncCause").val(data[0].occrrncCause);//발생원인
				$("#cntrplnApplcDte").val(data[0].cntrplnApplcDte);//대책적용시험
				$("#basis").val(data[0].basis);//근본원인
				$("#vocCntrplnFoundngSeqno").val(data[0].vocCntrplnFoundngSeqno);//VOC 대책 수립 일련번호
				diagnoseDropZoneArea.getFiles(data[0].atchmnflSeqno);
			}
	 	});
  	}else {
		$("#vocDiagnoseFrm")[0].reset();
		diagnoseDropZoneArea.clear();
	}
   	if(event.item.vocValidVrifySeqno != 0){
		var validVrifyParam = {"vocSeqno":event.item.vocSeqno,
  								"vocValidVrifySeqno":event.item.vocValidVrifySeqno};
				
				
		customAjax({"url":"/qa/getVocValidVrify.lims",
					"data":validVrifyParam ,
					"successFunc":function(data){ 
		
		 			$("#validVrifyMth").val(data[0].validVrifyMth);//유효성검증방법
		 			if(data[0].validVrifyResultAt == 'Y'){//유효성검증결과
	          			$('input[name="validVrifyResultAt"]').filter("[value=Y]").prop("checked", true);
	         		}else if(data[0].validVrifyResultAt == 'N'){
	          			$('input[name="validVrifyResultAt"]').filter("[value=N]").prop("checked", true);
	        		}
						$("#validVrifyResn").val(data[0].validVrifyResn);//[재검토]시 사유
						$("#vocValidVrifySeqno").val(data[0].vocValidVrifySeqno);//VOC 유효 검증 일련번호
						validVrifyDropZoneArea.getFiles(data[0].atchmnflSeqno);
					}
		});
   	}else {
		$("#vocValidVrifyFrm")[0].reset();
		$("#validVrifyResultAt_N").prop('checked',true);
		validVrifyDropZoneArea.clear();
	}
   });
}

//버튼 이벤트
function setButtonEvent() {
	
	// VOC목록 조회
	$("#selectVoc").click(function() {
		searchVoc();
	});
	
	// 신규버튼
	$("#btn_new").click(function() {
		 vocReset();
	});
	
	// 삭제버튼
	$("#btn_delete").click(function() {
		if(!$("#vocSeqno").val()){
			alert("${msg.C100000497}");
			return false;
		}
		else{
			deleteData();	
		}
	});
	
	// 대책등록 삭제버튼
	$("#diagnose_btn_delete").click(function() {
		if(!$("#vocCntrplnFoundngSeqno").val()){
			alert("${msg.C100000497}");
			return false;
		}
		else{
			diagnoseDeleteData();	
		}
	});
	
	// 유효검증 삭제버튼
	$("#validVrify_btn_delete").click(function() {
		if(!$("#vocValidVrifySeqno").val()){
			alert("${msg.C100000497}");
			return false;
		}
		else{
			validVrifyDeleteData();	
		}
	});
	
	// VOC임시등록
	$("#btn_temporary_save").click(function() {
		if(!saveValidation("vocDetailFrm")) {
		    return;
		}

		$('#temporaryYn').val('N');
		$('#vocSave').click();
	});
	
	// VOC등록저장
	$("#btn_save").click(function() {
		if(!saveValidation("vocDetailFrm")){
		      return;
		   }
		$('#temporaryYn').val("Y");
		$('#vocSave').click();
		
	});
	
	// VOC 임시 , 저장 로직합침
	$("#vocSave").click(function() {
		
		var dropZone = vocDropZoneArea.getNewFiles();
		var dropZone_cnt = dropZone.length;
		
		if (dropZone_cnt > 0){
			$("#btn_fileSave").click();
			vocDropZoneArea.on("uploadComplete", function(event, fileIdx){
				$("#atchmnflSeqno").val(fileIdx);
				saveVoc();
			});	
		}else{
			saveVoc();
		}	
	});
	
	// 대책등록임시등록
	$("#diagnose_btn_temporary_save").click(function() {
		if(!saveValidation("vocDiagnoseFrm")){
		      return;
		   }
		var fileValid = $("#diagnoseDropZoneArea")[0].childNodes[0].length
		if (fileValid==1){
			warn("${msg.C100000866}");
			return ;
		}
		$('#diagnoseTemporaryYn').val("N");
		$('#vocDiagnoseSave').click();
	});
	
	// 대책등록등록
	$("#diagnose_btn_save").click(function() {
		if(!saveValidation("vocDiagnoseFrm")){
		      return;
		   }
		var fileValid = $("#diagnoseDropZoneArea")[0].childNodes[0].length
		if (fileValid==1){
			warn("${msg.C100000866}");
			return ;
		}
		$('#diagnoseTemporaryYn').val("Y");
		$('#vocDiagnoseSave').click();
	});
	
	// 대책등록저장 로직합침
	$("#vocDiagnoseSave").click(function() {
		   var dropZone = diagnoseDropZoneArea.getNewFiles();
			var dropZone_cnt = dropZone.length;
			
			if (dropZone_cnt > 0){
				$("#btn_diagnoseFileSave").click();
				diagnoseDropZoneArea.on("uploadComplete", function(event, fileIdx){
					$("#diagnoseAtchmnflSeqno").val(fileIdx);
					saveDiagnose();
				});	
			}else{
				saveDiagnose();
			}		
		
	});
	
	// VOC 유효성 검증임시 저장
	$("#validVrify_btn_temporary_save").click(function() {
		if(!saveValidation("vocValidVrifyFrm")){
		      return;
		   }
		$('#validVrifyTemporaryYn').val("N");
		$('#vocValidVrifySave').click();
	});
	
	// VOC 유효성 검증 저장
	$("#validVrify_btn_save").click(function() {
		if(!saveValidation("vocValidVrifyFrm")){
		      return;
		   }
		$('#validVrifyTemporaryYn').val("Y");
		$('#vocValidVrifySave').click();
	});
	
	// VOC 유효성 검증 저장 로직합침
	$("#vocValidVrifySave").click(function() {
		   var dropZone = validVrifyDropZoneArea.getNewFiles();
			var dropZone_cnt = dropZone.length;
			
			if (dropZone_cnt > 0){
				$("#btn_validVrifyFileSave").click();
				validVrifyDropZoneArea.on("uploadComplete", function(event, fileIdx){
					$("#validVrifyAtchmnflSeqno").val(fileIdx);
					saveValidVrify();
				});	
			}else{
				saveValidVrify();
			}		
		
	});
	
	$("#wrterReset").click(function(){
		dialogReset(this.id);
	})
	
	$("#mtrilReset").click(function(){
		dialogReset(this.id);
	})
	
	$("#ctmmnyReset").click(function(){
		dialogReset(this.id);
	})
	
	// 아코디언 click event
	var acc = document.getElementsByClassName("accordion");
	var i;
	for (i = 0; i < acc.length; i++) {
		acc[i].addEventListener("click", function() {
			this.classList.toggle("active");
			var panel = this.nextElementSibling;

			if(panel.style.display === "block") {
				panel.style.display = "none";
			}else {
				panel.style.display = "block";
				AUIGrid.resize(VocList);
				AUIGrid.resize(vocRegistList);
				AUIGrid.resize(vocCntrplnFoundngList);
				AUIGrid.resize(vocValidVrifyList);
				AUIGrid.resize(vocDocHistGrid);

				var seqno = $("#vocSeqno").val() != '' ? $("#vocSeqno").val() : null;
				getVocDocHist(seqno);
			}

			if(panel.style.maxHeight) {
				panel.style.maxHeight = null;
			}else {
				panel.style.maxHeight = null;
			}
		});
	}

	//VOC 배포이벤트
	$("#btn_deployment").click(function(){
		var vocGrid = AUIGrid.getSelectedRows(VocList);
		var vocIndexList = AUIGrid.getSelectedItems(VocList);
		if($("#vocRegistSeqno").val() == null || $("#vocRegistSeqno").val() == ""){
			alert("${msg.C100000485}");
			return false;
		} else{
			//배포 내용 작성
			var sj = "[LIMS] VOC 등록("+$("#sj").val()+") 배포입니다.";
			var cn = 
				"<table style='border-top:1px solid #1f296f;'>"
			    +"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>고객 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#ctmmnyNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제목 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#sj").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>접수번호</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#vocRceptNo").val()+ "</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제품 명 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#mtrilNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#vocBadnSeCode")[0].options[$("#vocBadnSeCode")[0].options.selectedIndex].text+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>생산 공장</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#bplcCode")[0].options[$("#bplcCode")[0].options.selectedIndex].text +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>작성 부서</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#writngDeptNm").val() +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 발생일 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#badnOccrrncDte").val() +"</td>"
				+"</tr>"
				+"</table>"	;
			$("#wdtbCn").val(cn);
			$("#wdtbSj").val(sj);
			$("#btn_deployment_hidden").click();
		}
	});
	
	//대책 등록 배포이벤트
	$("#diagnose_btn_deployment").click(function(){
		var vocGrid = AUIGrid.getSelectedRows(VocList);
		var vocIndexList = AUIGrid.getSelectedItems(VocList);
		if($("#vocCntrplnFoundngSeqno").val() == null || $("#vocCntrplnFoundngSeqno").val() == ""){
			alert("${msg.C100000485}");
			return false;
		}else{
			//배포 내용 작성
			var sj = "[LIMS] VOC 대책 등록("+$("#sj").val()+") 배포입니다.";
			var cn = 
				"<table style='border-top:1px solid #1f296f;'>"
			    +"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>고객 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#ctmmnyNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제목 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#sj").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>접수번호</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#vocRceptNo").val()+ "</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제품 명 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#mtrilNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#vocBadnSeCode")[0].options[$("#vocBadnSeCode")[0].options.selectedIndex].text+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>생산 공장</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#bplcCode")[0].options[$("#bplcCode")[0].options.selectedIndex].text +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>작성 부서</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#writngDeptNm").val() +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 발생일 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#badnOccrrncDte").val() +"</td>"
				+"</tr>"
				+"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>발생 원인 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#occrrncCause").val() +"</td>"
				+"</tr>"
				+"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>대책 적용 시점 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#cntrplnApplcDte").val() +"</td>"
				+"</tr>"
				+"</table>"	;
				
				
			$("#wdtbCn").val(cn);
			$("#wdtbSj").val(sj);
			$("#diagnose_btn_deployment_hidden").click();
		}
	});
	
	//유효성 검즘 배포이벤트
	$("#validVrify_btn_deployment").click(function(){
		var vocGrid = AUIGrid.getSelectedRows(VocList);
		var vocIndexList = AUIGrid.getSelectedItems(VocList);
		if($("#vocValidVrifySeqno").val() == null || $("#vocValidVrifySeqno").val() == ""){
			alert("${msg.C100000485}");
			return false;
		}
		else{
			var sj = "[LIMS] VOC 유효성 검증("+$("#sj").val()+") 배포입니다. ";
			var cn = 
			"<table style='border-top:1px solid #1f296f;'>"
			    +"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>고객 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#ctmmnyNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제목 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#sj").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>접수번호</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>" + $("#vocRceptNo").val()+ "</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>제품 명 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#mtrilNm").val()+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 명</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#vocBadnSeCode")[0].options[$("#vocBadnSeCode")[0].options.selectedIndex].text+"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>생산 공장</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#bplcCode")[0].options[$("#bplcCode")[0].options.selectedIndex].text +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>작성 부서</th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#writngDeptNm").val() +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>불량 발생일 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#badnOccrrncDte").val() +"</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>유효성 검증 방법 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("#validVrifyMth").val() + "</td>"
				+"</tr>"
				+"<tr>"
			    +"<th style='background:#dcdcdc; border-bottom:1px solid #dcdcdc; color:#444; font-size:12px; font-weight: bold; min-width: 100px;'>유효성 검증 결과 </th>"
				+"<td style='padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);'>"+ $("input[name='validVrifyResultAt']:checked")[0].nextSibling.data +"</td>"
				+"</tr>"
				+"</table>";
			$("#wdtbSj").val(sj);
			$("#wdtbCn").val(cn);
			$("#validVrify_btn_deployment_hidden").click();
		}
	});
	
	
	
	$("#tabs").click(function() {
		AUIGrid.resize(vocRegistList);
		AUIGrid.resize(vocCntrplnFoundngList);
		AUIGrid.resize(vocValidVrifyList);
	});
	
}

function popUp() {
	//VOC 등록 배포 
 	dialogWdtb("btn_deployment_hidden", {"dept" : '${UserMVo.deptCode}'}, "Y","vocRegist",VocList, "cstmrVocRegistDialog",function(data){
 		var wdtbGbn = "vocRegistSeqno";
 		searchVoc(wdtbGbn);
	},null);
 	dialogWdtb("diagnose_btn_deployment_hidden", {"dept" : '${UserMVo.deptCode}'}, "Y","vocCntrplnFoundng",VocList, "cstmrVocCntrplnFoundngDialog",function(data){
 		var wdtbGbn = "vocCntrplnFoundngSeqno"
 		searchVoc(wdtbGbn);
	},null);
 	dialogWdtb("validVrify_btn_deployment_hidden", {"dept" : '${UserMVo.deptCode}'}, "Y","vocValidVrify",VocList, "cstmrvocValidVrifyDialog",function(data){
 		var wdtbGbn = "vocValidVrifySeqno"
 		searchVoc(wdtbGbn);
 		
	},null);
}

/*############ 조회, 저장, 삭제 함수 ############*/

//VOC목록 조회
function searchVoc(Gbn){
	
	if(!saveValidation('vocSeForm')) {
		return false;
	}
	$.when(
			getGridDataForm("<c:url value='/qa/searchVocList.lims'/>" ,"vocSeForm", VocList)
	).then(function() {
		var wdtbSeqno ="";
		if(!!$("#"+Gbn).val()){
			 
			if(Gbn =='vocRegistSeqno'){
				wdtbSeqno = AUIGrid.getItemsByValue(VocList,Gbn,$("#"+Gbn).val())[0].wdtbSeqno;
				$("#wdtbSeqno").val(wdtbSeqno);
			}
			else if(Gbn == 'vocCntrplnFoundngSeqno'){
				wdtbSeqno = AUIGrid.getItemsByValue(VocList,Gbn,$("#"+Gbn).val())[0].cntrplnFoundngWdtbSeqno;
				 $("#cntrplnFoundngWdtbSeqno").val(wdtbSeqno)
			}
			else{
				wdtbSeqno = AUIGrid.getItemsByValue(VocList,Gbn,$("#"+Gbn).val())[0].validVrifyWdtbSeqno;
				 $("#validVrifyWdtbSeqno").val(wdtbSeqno)
			}			
		}
	});

}

// VOC 품질 문서 이력 조회
function getVocDocHist(seqno) {
	var param = {
		"pageNm" : "voc"
	};

	if(!!seqno) {
		param.seqno = seqno;
		getGridDataParam("/com/getQlityDocHistList.lims", param, vocDocHistGrid);
	}else {
		return;
	}
}

//VOC 저장 및 수정
function saveVoc() {
	var param = $("#vocDetailFrm").serializeObject();
	param = Object.assign(param);
	showLoadingbar();

	customAjax({
		"url":"/qa/putVoc.lims", 
		"data":param, 
		"successFunc":function(data) { 
			success("${msg.C100000765}");  /* 저장되었습니다. */
			vocReset();
			searchVoc();
			AUIGrid.clearGridData(vocDocHistGrid);

		},"completeFunc":function() {
			hideLoadingbar();
		},"errorFunc":function() {
			hideLoadingbar();
		}
	});
};

//원인규명 저장 및 수정
function saveDiagnose() {
	var param = $("#vocDiagnoseFrm").serializeObject();
	param.vocSeqno = $("#vocSeqno").val();
	param = Object.assign(param);
	showLoadingbar();

	customAjax({
		"url":"/qa/putDiagnose.lims",
		"data":param,
		"successFunc":function(data) { 
			success("${msg.C100000765}");  /* 저장되었습니다. */
			vocReset();
			searchVoc();
			AUIGrid.clearGridData(vocDocHistGrid);

		},"completeFunc":function() {
			hideLoadingbar();
		},"errorFunc":function() {
			hideLoadingbar();
		}
	});
};

//VOC 유효성 검증 저장 및 수정
function saveValidVrify() {
	var param = $("#vocValidVrifyFrm").serializeObject();
	param.vocSeqno = $("#vocSeqno").val();
	param = Object.assign(param);
	showLoadingbar();

	customAjax({
		"url":"/qa/putValidVrify.lims",
		"data":param,
		"successFunc":function(data) { 
			success("${msg.C100000765}");  /* 저장되었습니다. */
			vocReset();
			searchVoc();
			AUIGrid.clearGridData(vocDocHistGrid);

		},"completeFunc":function(){
			hideLoadingbar();
		},"errorFunc":function(){
			hideLoadingbar();
		}
	});
};



//VOC삭제 버튼
function deleteData() {

	if(confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */ 
		var params = {
			vocSeqno : $("#vocSeqno").val()
			,deleteAt : "Y"
		};

		customAjax({
			"url":"<c:url value='/qa/updateVocDel.lims'/>",
			"data":params,
			"successFunc":function(data) {
				success("${msg.C100000462}"); /* 삭제되었습니다. */
				vocReset();
				searchVoc();
				AUIGrid.clearGridData(vocDocHistGrid);
			}
		});
	}else {
		return;
	}
}
	
//VOC대책등록 삭제
function diagnoseDeleteData() {
	   
	if(confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */ 
		var params = {
			vocCntrplnFoundngSeqno : $("#vocCntrplnFoundngSeqno").val()
			,vocSeqno: $("#vocSeqno").val()
			,deleteAt : "Y"
		};

		customAjax({
			"url":"<c:url value='/qa/updateVocCntrplnFoundngDel.lims'/>",
			"data":params,
			"successFunc":function(data) {
				success("${msg.C100000462}"); /* 삭제되었습니다. */
				vocReset();
				searchVoc();
				AUIGrid.clearGridData(vocDocHistGrid);
			}
		});
	}else {
		return;
	}
}
	
//VOC유효검증 삭제
function validVrifyDeleteData() {
	   
	if(confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */ 
		var params = {
			vocValidVrifySeqno : $("#vocValidVrifySeqno").val()
			,vocSeqno: $("#vocSeqno").val()
			,deleteAt : "Y"
		};

		customAjax({
			"url":"<c:url value='/qa/updateVocValidVrifyDel.lims'/>",
			"data":params,
			"successFunc":function(data) {
				success("${msg.C100000462}"); /* 삭제되었습니다. */
				vocReset();
				searchVoc();
				AUIGrid.clearGridData(vocDocHistGrid);
			}
		});
	}else {
		return;
	}
}

/*############ 기타이벤트 함수 ############*/



//Voc 등록 리샛
function vocReset(){
	$("#vocDetailFrm")[0].reset();
	var hidden = $("#vocDetailFrm input[type=hidden]");
	
	for(var i=0; i<hidden.length; i++){
		hidden[i].value = "";
	}
	
	$("#sj").val("");
	$("#crud").val("C");
	$("#vocRceptNo").val("");
	$("#writngDeptNm").val("${UserMVo.inspctInsttNm}");
	$("#writngDeptCode").val("${UserMVo.deptCode}");
	$("#wrterNm").val("${UserMVo.userNm}");
	$("#wrterId").val("${UserMVo.userId}");
	datePickerCalendar(["writngDte"], true, ["DD",0], ["DD",0]);
	$("#vocSeCode").val("");
	$("#rceptDeptNm").val("");
	$("#rcepterNm").val("");
	$("#rceptDte").val("");
	$("#ctmmnyNm").val("");
	$("#ctmmnySeqno").val("");
	$("#ctmmnyLineNm").val("");
	$("#mtrilNm").val("");
	$("#mtrilSeqno").val("");
	$("#occrrncLotId").val("");
	$("#vocBadnSeCode").val("");
	$("#occrrncFairNm").val("");
	$("#bplcCode").val("${UserMVo.bestInspctInsttCode}");
	$("#cntnrSeCode").val("");
	$("#badnCo").val("");
	$("#badnOccrrncDte").val("");
	//체크되어있는 항목 모두 해제
	$('input[name="recrAt"]').removeAttr('checked');
	// value 값 초기화
	$('input[name="recrAt"]').filter("[value=Y]").prop("checked", true);
	//체크되어있는 항목 모두 해제
	$('input[name="cntrplnFoundngAt"]').removeAttr('checked');
	// value 값 초기화
	$('input[name="cntrplnFoundngAt"]').filter("[value=Y]").prop("checked", true);
	$("#cntrplnFoundngDeptNm").val("");
	$("#badnPhnomenDc").val("");
	//체크되어있는 항목 모두 해제
	$('input[name="cntrplnFoundngOprtnAt"]').removeAttr('checked');
	// value 값 초기화
	$('input[name="cntrplnFoundngOprtnAt"]').filter("[value=Y]").prop("checked", true);
	$("#imprtyResn").val("");
	$("#dedtDte").val("");
	$("#dedtAppnResn").val("");
	vocDropZoneArea.clear();
	$("#tab2").css({ 'pointer-events': 'none' });
	$("#tab3").css({ 'pointer-events': 'none' });
	//버튼 비활설화 제거
	$("#btn_delete").css("display","inline-block");
	
   	$("#btn_temporary_save").css("display","inline-block");
   	$("#btn_save").css("display","inline-block");
   	$("#diagnose_btn_delete").css("display","inline-block");
	$("#diagnose_btn_temporary_save").css("display","inline-block");
   	$("#diagnose_btn_save").css("display","inline-block");
   	$("#validVrify_btn_delete").css("display","inline-block");
   	$("#validVrify_btn_temporary_save").css("display","inline-block");
   	$("#validVrify_btn_save").css("display","inline-block");
   	//배포버튼 안보이게 처리
   	$("#btn_deployment").css("display", "none");
	$("#diagnose_btn_deployment").css("display", "none");
	$("#validVrify_btn_deployment").css("display", "none");
	diagnoseReset();
	validVrifyReset();
}

//원인규명 리샛
function diagnoseReset(){
	$("#vocDiagnoseFrm")[0].reset();
	var hidden = $("#vocDiagnoseFrm input[type=hidden]");
	
	for(var i=0; i<hidden.length; i++){
		hidden[i].value = "";
	}
	
	$("#occrrncCause").val(""); // 발생원인
	$("#basis").val(""); //근본원인
	$("#cntrplnApplcDte").val(""); //대책적용시험
	diagnoseDropZoneArea.clear();
	$("#tab2").css({ 'pointer-events': 'none' });
	$("#tab3").css({ 'pointer-events': 'none' });
	$("#tab1").click();
}

//유효성검증 리샛
function validVrifyReset(){
	$("#vocValidVrifyFrm")[0].reset();
	var hidden = $("#vocValidVrifyFrm input[type=hidden]");
	
	for(var i=0; i<hidden.length; i++){
		hidden[i].value = "";
	}
	
	$("#validVrifyMth").val(""); // 유효성검증방법
	//체크되어있는 항목 모두 해제
	$('input[name="validVrifyResultAt"]').removeAttr('checked');
	// value 값 초기화
	$('input[name="validVrifyResultAt"]').filter("[value=Y]").prop("checked", true);
	$("#validVrifyResn").val(""); //[재검토]시 사유
	validVrifyDropZoneArea.clear();
	$("#tab2").css({ 'pointer-events': 'none' });
	$("#tab3").css({ 'pointer-events': 'none' });
	$("#tab1").click();
}
//엔터키 이벤트
function doSearch(e){
	searchVoc();
}
</script>
<!--  script 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>