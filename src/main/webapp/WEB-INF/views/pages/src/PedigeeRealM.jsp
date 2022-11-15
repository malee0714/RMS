<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<h2>
				${msg.C000000735} <!-- 의뢰 목록 -->
				<span style="color: #444; font-size: 11px; font-weight: normal; margin-left: 4%;" class="necessary">${msg.C000000080}</span> <!-- 부서 -->
				<select class="wd12p schClass" style="margin-left:6px;"  id="deptCodeSch" name="deptCodeSch" ></select>
			</h2>
			
			<div class="btnWrap">
				<button id="btnSearch" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
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
					<th>${msg.C000000734}</th> <!-- 타입 -->
					<td><select id="processTySch" name="processTySch"></select></td>
					<th>${msg.C000000211}</th> <!-- 제품 명 -->
					<td><select id="prductSeqnoSch" name="prductSeqnoSch"></select></td>
					<th>${msg.C000000214}</th> <!-- 자재 코드 -->
					<td>
						<select class="wd100p schClass" name="mtrilCodeSch" id="mtrilCodeSch"></select>
					</td>
					<th>${msg.C000000869}</th> <!-- 타입 外 -->
					<td>
						<select id="processTyElseCodeSch" name="processTyElseCodeSch"></select>
					</td>
					
				</tr>
				<tr>
					<th>${msg.C000000576}</th> <!-- 의뢰 일자 -->
					<td >
						<input type="text" id="reqestStDte" name="reqestStDte" class="wd44p schClass" style="min-width: 6em;">~ 
						<input type="text" id="reqestEnDte" name="reqestEnDte" class="wd44p schClass" style="min-width: 6em;">
					</td>
					<th>${msg.C000000575}</th> <!-- Lot ID -->
					<td><input type="text" id="lotIdSch" name="lotIdSch" class="schClass objBacode"></td>
					
					<th>${msg.C000000870}</th> <!-- 의뢰 구분 -->
					<td>
						<select id="reqestSeCodeSch" name="reqestSeCodeSch"></select>
						<input type="hidden" id="reqestSeqno" name="reqestSeqno">
					</td>
					<th>${msg.C000000271}</th> <!-- 진행상황 -->
					<td>
						<select id="progrsSittnCodeSch" name="progrsSittnCodeSch"></select>
					</td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="pedigeeMGrid" style="width:100%; height:500px; margin:0 auto;"></div>
		</div>
		<div style="text-align: right;">
			<label style="background-color:#FEDBDE;font-size:13px">${msg.C000000871}</label> <!-- [부적합] -->
			<label style="background-color:#dbc2ff;font-size:13px">${msg.C000000872}</label> <!-- [재분석] -->
			<label style="background-color:#a1d0ff;font-size:13px">${msg.C000000873}</label> <!-- [재조정] -->
			<label style="background-color:#f7efa3;font-size:13px">${msg.C000000874}</label> <!-- [재처리] -->
			<label style="background-color:#a3f7f7;font-size:13px">${msg.C000000875}</label> <!-- [변경점] -->
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
	
	dialogIssueList("btnIssueList", "dgIssueList", {"reqestSeqno" : getEl("reqestSeqno").value}, function(item){
	});
	
});
</script>
<script>
var pedigeeMGrid = 'pedigeeMGrid';

function setCombo(){
	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"${msg.C000000062}", "${UserMVo.upperInspctInsttCode}"); /* 전체 */
	ajaxJsonComboBox3("/wrk/getSrchPrductList.lims","prductSeqnoSch",{"deptCode" : " "} , true);
	ajaxJsonComboBoxCommon("SY02", "processTySch",true);
	ajaxJsonComboBoxCommon(($("#userAuthor").val() != "N")? "IM01" : null, "reqestSeCodeSch", true);
	ajaxJsonComboBox("/com/getCmmnCode.lims", "progrsSittnCodeSch", {"upperCmmnCode" : "IM03"}, true, null);
	ajaxJsonComboBox("/com/getCmmnCode.lims", "processTyElseCodeSch",{"upperCmmnCode" : "IM14"}, true, null);
	ajaxJsonComboBox3("/wrk/getPrductMtrilComboList.lims","mtrilCodeSch", null, true);
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
	columnLayout.pedigeeMGridCol.addColumn("lotId", "${msg.C000000575}","*",true) /* Lot ID */
	.addColumn("reqestDeptNm", "${msg.C000000080}","*",true) /* 부서 */
	.addColumn("reqestSeqno", "${msg.C000000724}","*",false) /* 일련번호 */
	.addColumn("processTy", "${msg.C000000734}","*",true) /* 타입 */
	.addColumn("prdlstNm", "${msg.C000000211}","*",true) /* 제품 명 */
	.addColumn("mtrilCode", "${msg.C000000214}","*",true) /* 자재 코드 */
	.addColumn("prductSeCode", "${msg.C000000766}","*",false) /* 제품 구분 */
	.addColumn("reqestDte", "${msg.C000000576}","*",true) /* 의뢰 일자 */
	.addColumn("mnfcturDte", "${msg.C000000578}","*",true) /* 제조 일자 */
	.addColumn("tankNm", "${msg.C000000253}","*",true) /* Tank No. */
	.addColumn("reqestSeText", "${msg.C000000870}","*",true) /* 의뢰 구분 */
	.addColumn("virtlLotSe", "${msg.C000000876}","*",true) /* 가상 Lot 구분 */
	.addColumn("progrsSittnCodeNm", "${msg.C000000271}","*",true) /* 진행상황 */
	.addColumn("jdgmntWordCodeNm", "${msg.C000000901}","*",true) /* 판정 */
	.addColumn("frstLotId", "${msg.C000000909}","*",true); /* 최초 Lot Id */
	console.log(columnLayout.pedigeeMGridCol.length);
	columnLayout.pedigeeMGridCol[15]  = {
		dataField : "issueCnt",
		headerText : "${msg.C000000910}", /* 이슈 여부 */
		width: "*",
		editable:false,
		renderer : {
			type : "ImageRenderer",
			imgHeight : 17, // 이미지 높이, 지정하지 않으면 rowHeight에 맞게 자동 조절되지만 빠른 렌더링을 위해 설정을 추천합니다.
			altField : null, // alt(title) 속성에 삽입될 필드명, 툴팁으로 출력됨. 만약 null 을 설정하면 툴팁 표시 안함.
			srcFunction : function(rowIndex, columnIndex, value, item) {
				if(item.issueCnt > 0){
					return "/assets/image/reading_glasses.png";
				}else{
					return null; // null 반환하면 이미지 표시 안함.
				}
			}
		}
	}
	pedigeeMGrid = createAUIGrid(columnLayout.pedigeeMGridCol, pedigeeMGrid, cusPros);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getReqestPrductList();
	});
	
	//제품 곰보박스
	getEl("deptCodeSch").event("change", function(e){
		var data = {
			"deptCode" : getEl("deptCodeSch").value,
			"processTyCode" : getEl("processTySch").value
		}
		ajaxJsonComboBox3("/wrk/getSrchPrductList.lims","prductSeqnoSch",data , true);
	});
	
	getEl("processTySch").event("change", function(e){
		var data = {
			"deptCode" : getEl("deptCodeSch").value,
			"processTyCode" : getEl("processTySch").value
		}
		ajaxJsonComboBox3("/wrk/getSrchPrductList.lims","prductSeqnoSch",data, true);
	});
	
	getEl("prductSeqnoSch").event("change", function(e){
		var data = {
			"deptCode" : getEl("deptCodeSch").value,			
			"prductSeqno" : getEl("prductSeqnoSch").value,
			"processTyCode" : getEl("processTySch").value
		}
		ajaxJsonComboBox3("/wrk/getPrductMtrilComboList.lims","mtrilCodeSch",data, true);
	});

	$(".schClass").keypress(function(e){
		if(e.which == 13){
			getReqestPrductList();
		}
	})	
};

function setEtcEvent(){
	datePickerCalendar(["reqestStDte", "reqestEnDte"],true,["DD",-7], ["DD",0]);//의뢰일자 조회조건
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
	ajaxJsonForm3("/src/getUpperReqestPedigee.lims", "searchFrm", function(data){
		if(!!data){
			AUIGrid.setGridData(pedigeeMGrid, data);
		}
	});
};

</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>