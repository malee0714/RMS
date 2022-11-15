<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>이슈 목록</h2>
		<div class="btnWrap">
			<button id="btnSearch" class="search btn1">조회</button>
		</div>
	
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:9%"></col> 
					<col style="width:16%"></col>
					<col style="width:9%"></col>
					<col style="width:16%"></col>
					<col style="width:9%"></col>			
					<col style="width:16%"></col>
					<col style="width:9%"></col>			
					<col style="width:16%"></col>					
				</colgroup>
				<tr>
					<th>부서</th>
					<td><select id="deptCodeSch" name="deptCodeSch"></select></td>
					<th>프로세스 타입</th>
					<td><select id="shrProcessTyCode" name="shrProcessTyCode"></select></td>
					<th>제품</th>
					<td><select id="prductSeqnoSch" name="prductSeqnoSch"></select></td>
					<th>이슈 등록 일자</th>
					<td>
						<input type="text" id="issueStDte" name="issueStDte" class="wd43p schClass">~
						<input type="text" id="issueEnDte" name="issueEnDte" class="wd43p schClass">
					</td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="issueSearchMGrid" style="width:100%; height:500px; margin:0 auto;"></div>
		</div>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
$(function() {
	getAuth(); //권한 체크
	
	setUseIssueSearchMGrid();

	setCombo();
	
	setButtonEvent();
	
	setEtcEvent();
	
	gridResize([issueSearchMGrid]);
	
});
</script>
<script>
var issueSearchMGrid = 'issueSearchMGrid';

function setCombo(){
	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"==전체==", "${UserMVo.upperInspctInsttCode}");
	ajaxJsonComboBox('/src/getUpperPrduct.lims','prductSeqnoSch',{"deptCodeSch" : getEl("deptCodeSch").value},false,"==전체==");
	ajaxJsonComboBoxCommon("SY02", "shrProcessTyCode",true);
}

//그리드 생성
function setUseIssueSearchMGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			issueSearchMGridCol : []
	};
	
	// 사용량 그리드
	auigridCol(columnLayout.issueSearchMGridCol);
	columnLayout.issueSearchMGridCol.addColumn("issueRegistDt", "등록일자","*",true)
	.addColumn("warningMail", "Warning Mail","*",true)
	.addChildColumn("warningMail","registEa", "등록 건수","*",true)
	.addChildColumn("warningMail", "processEa", "처리 건수","*",true)
	.addChildColumn("warningMail", "acceptEa", "승인 건수","*",true)
	.addColumn("innerIssue", "내부","*",true)
	.addColumn("outerIssue", "외부","*",true);
	
	issueSearchMGrid = createAUIGrid(columnLayout.issueSearchMGridCol, issueSearchMGrid);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getIssueSearchList();
	});
	
	getEl("deptCodeSch").event("change", function(){
		var a = getEl("shrProcessTyCode").value, b = getEl("deptCodeSch").value;
		if(a && b){
			ajaxJsonComboBox('/src/getUpperPrduct.lims','prductSeqnoSch',{"deptCodeSch" : b, "processTySch" : a},false,"==전체==");
		}
					
	});
	
	getEl("shrProcessTyCode").event("change", function(){
		var a = getEl("shrProcessTyCode").value, b = getEl("deptCodeSch").value;
		if(a && b){
			ajaxJsonComboBox('/src/getUpperPrduct.lims','prductSeqnoSch',{"deptCodeSch" : b, "processTySch" : a},false,"==전체==");
		}
					
	});
	

	$(".schClass").keypress(function(e){
		if(e.which == 13){
			getIssueSearchList();
		}
	})	
};

function setEtcEvent(){
	datePickerCalendar(["issueStDte", "issueEnDte"],true,["DD",-7], ["DD",0]);//의뢰일자 조회조건
}

function getIssueSearchList(){
	ajaxJsonForm3("/src/getIssueSearchList.lims", "searchFrm", function(data){
		if(!!data){
			AUIGrid.setGridData(issueSearchMGrid, data);
		}
	});
};

</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>