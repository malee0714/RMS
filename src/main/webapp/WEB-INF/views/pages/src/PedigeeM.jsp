<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<h2><i class="fi-rr-apps"></i>
				${msg.C100000655} <!-- 의뢰 목록 -->
			</h2>
			
			<div class="btnWrap">
				<button id="btnSearch" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
				<input type="hidden" id="btnIssueList">
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
					<td>
						<select class="wd100p schClass" id="bplcCodeSch" name="bplcCode"></select>
					</td>
					<th>${msg.C100000717}</th> <!-- 자재 명 -->
					<td>
						<input type="text" class="wd100p schClass" name="mtrilNm" id="mtrilSch" maxLength="200"/>
					</td>
					<th>${msg.C100000056}</th> <!-- Lot No. -->
					<td>
						<input type="text" class="wd100p schClass" name="lotNo" id="lotNoSch" maxLength="20">
					</td>
					<th>${msg.C000001802}</th> <!-- 의뢰 번호 -->
					<td>
						<input type="text" class="wd100p schClass" name="reqestNo" id="reqestNoSch" maxLength="11">
					</td>
				</tr>
				<tr>
					<th>${msg.C000001794}</th> <!-- 검사 유형 -->
					<td>
						<select class="wd100p schClass" id="inspctTyCodeSch" name="inspctTyCode">
							<option>선택</option>
						</select>
					</td>
					<th>${msg.C000000576}</th> <!-- 의뢰 일자 -->
					<td>
						<input type="text" id="reqestBeginDte" name="reqestBeginDte"class="dateChk wd6p" style="min-width: 6em;" autocomplete="off">
                        ~
                        <input type="text" id="reqestEndDte" name="reqestEndDte" class="dateChk wd6p" style="min-width: 6em;" autocomplete="off">
					</td>
					<th class="necessary">${msg.C000000578}</th> <!-- 제조 일자 -->
					<td>
						<input type="text" id="mnfcturBeginDte" name="mnfcturBeginDte" class="dateChk wd6p" style="min-width: 6em;" autocomplete="off" required>
                        ~
                        <input type="text" id="mnfcturEndDte" name="mnfcturEndDte" class="dateChk wd6p" style="min-width: 6em;" autocomplete="off" required>
					</td>
					<th>${msg.C000000271}</th> <!-- 진행상황 -->
					<td>
						<select id="progrsSittnCodeSch" name="progrsSittnCode">
							<option>선택</option>
						</select>
					</td>
				</tr>
				<c:if test="${UserMVo.auditAt == 'N'}">
				<tr>
					<th>Lot 이력 구분</th>
					<td>
						<label><input type="radio" value="Y" name="lotTrace" checked>Lot Trace</label>
						<label><input type="radio" value="N" name="lotTrace">Lot Trace (Real)</label>
					</td>
				</tr>
				</c:if>
			</table>
		</form>
	</div>
	<div class="subCon2 mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="pedigeeMGrid" style="width:100%; height:500px; margin:0 auto;"></div>
	</div>

	<div style="text-align: right;">
		<div class="mapkey">
			<label class="scarce">${msg.C000000871}</label> <!-- [부적합] -->
		</div>
	</div>
	
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<style>
	.rowStyle-red{
		background-color : #FEDBDE;
		color : black; 
	}
	
	.rowStyle-navy{
		background-color : #dbc2ff;
 		color : black; 
	}
	
	.rowStyle-sky{
		background-color:#a1d0ff;
 		color : black; 
	}
	
	.rowStyle-navyBlue{
		background-color : #f7efa3;
 		color : black; 
	}
	
	.rowStyle-blueGreen{
		background-color : #a3f7f7;
 		color : black; 
	}
	
</style>
<script>
var lang = ${msg};
$(function() {
	getAuth(); //권한 체크
	
	setUsePedigeeMGrid();
	
	setCombo();
	
	setButtonEvent();
	
	usePedigeeMGridEvent();
	
	setEtcEvent();
	
	gridResize([pedigeeMGrid]);
});
</script>
<script>
var pedigeeMGrid = 'pedigeeMGrid';

function setCombo(){
	ajaxJsonComboBox("/com/getCmmnCode.lims", "processTySch", {"upperCmmnCode" : "SY02"}, true, null);
	//ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03"}, true, "IM03000006");
	ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03"}, true, "", "IM03000006");
	ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true, null);
// 	ajaxJsonComboBox("/wrk/getPrductMtrilComboList.lims","mtrilCodeSch", null, true);
}

//그리드 생성
function setUsePedigeeMGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			pedigeeMGridCol : []
	};
	
	var cusPros = {
			displayTreeOpen : true,
			// 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
			flat2tree : true,
			selectionMode : "multipleCells",
			// 행의 고유 필드명
//    			rowIdField : "menuNm",
			// 트리의 고유 필드명			
			treeIdField : "reqestSeqno",
			// 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
			treeIdRefField : "upperReqestSeqno",
			rowStyleFunction : function(rowIndex, item) {
				var reqestSeText = item.reqestSeText,
				jdgmntWordCode = item.jdgmntWordCode;
				
				//부적합 색상
				if(jdgmntWordCode){
					if(jdgmntWordCode=="IM05000002"){
						return "rowStyle-red";
					}
				}
				
				//의뢰구분 색상
				if(reqestSeText){
					if(reqestSeText.indexOf("재분석") != -1){
						return "rowStyle-navy";
					}else if(reqestSeText.indexOf("재조정") != -1){
						return "rowStyle-sky";
					}else if(reqestSeText.indexOf("재처리") != -1){
						return "rowStyle-navyBlue";
					}else if(reqestSeText.indexOf("변경점") != -1){
						return "rowStyle-blueGreen";
					}
				}
				
				return "";
			}
	}

	// 사용량 그리드
	auigridCol(columnLayout.pedigeeMGridCol);
	columnLayout.pedigeeMGridCol.addColumn("lotNo", "${msg.C100000056}","*",true) /* Lot ID */
	.addColumn("reqestDeptNm", "${msg.C100000400}","*",true) /* 부서 */
	.addColumn("reqestSeqno", "${msg.C000000724}","*",false) /* 일련번호 */
	.addColumn("inspctTyNm", "${msg.C100000139}","*",true) /* 검사 유형 */
	.addColumn("mtrilCode", "${msg.C100000725}","*",true) /* 자재 코드 */
	.addColumn("mtrilNm", "${msg.C100000717}","*",true) /* 자재 명 */
	.addColumn("reqestDte", "${msg.C100000659}","*",true) /* 의뢰 일자 */
	.addColumn("mnfcturDte", "${msg.C100000803}","*",true) /* 제조 일자 */
	.addColumn("progrsSittnCodeNm", "${msg.C100000846}","*",true) /* 진행 상황 */
	.addColumn("jdgmntWordCodeNm", "${msg.C100000918}","*",true) /* 판정 */
	pedigeeMGrid = createAUIGrid(columnLayout.pedigeeMGridCol, pedigeeMGrid, cusPros);
}
//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getReqestPrductList();
	});
	
	$(".schClass").keypress(function(e){
		if(e.which == 13){
			getReqestPrductList();
		}
	})	
};

function setEtcEvent(){
	//datePickerCalendar(["reqestBeginDte","reqestEndDte"],true,["DD",-30], ["DD",0]);//의뢰일자 조회조건
	datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-30], ["DD",0]);//제조일자 조회조건
}

function usePedigeeMGridEvent(){
	AUIGrid.bind(pedigeeMGrid, "ready", function(event) {
		gridColResize([pedigeeMGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
	
	AUIGrid.bind(pedigeeMGrid, "cellClick", function(event){
		if(event.item.issueCnt > 0 && event.dataField =="issueCnt"){
// 			openPopup("/src/PedigeeP01.lims?reqestSeqno="+event.item.reqestSeqno,"의뢰별 이슈 목록",{
// 				width : window.width,
// 				height : window.height,
// 				top : "200",
// 				left : "300",
// 				location : "no",
// 				scrollbars : "no"
// 			})
			getEl("reqestSeqno").value = event.item.reqestSeqno;
			$("#btnIssueList").click();
		}
	});
};

function getReqestPrductList(){
	if(!saveValidation("searchFrm")) {
		return;
	}

	ajaxJsonForm("/src/getReqestPrductList.lims", "searchFrm", function(data){
		if(!!data){
			AUIGrid.setGridData(pedigeeMGrid, data);
		}
	});
};

</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>