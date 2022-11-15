<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>바코드 목록</h2>
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
					<th>바코드</th>
					<td><input type="text" id="brcd" name="brcd"></td>
					<th>제품명</th>
					<td><input type="text" id="prductNm" name="prductNm"></td>
					<th>제품 상태</th>
					<td><select id=wrhsdlvrSeCode name="wrhsdlvrSeCode"></select></td>
				</tr>
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="useRegMGrid_Master" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
	</div>
	<div class="subCon2">
		<h2>사용량 이력 목록</h2>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="useRegMGrid_Detail" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<script>
$(function() {
	getAuth(); //권한 체크
	
	setUseProductLogMGrid();

	setCombo();
	
	setButtonEvent();
	
	useProductLogMGridEvent();
	
	gridResize([useRegMGrid_Master, useRegMGrid_Detail]);
});
</script>
<script>
var useRegMGrid_Master = 'useRegMGrid_Master';
var useRegMGrid_Detail = 'useRegMGrid_Detail';
var getEl = function(id){//id에 해당하는 선택자 가져오기.
	return document.getElementById(id);
};

function setCombo(){
	ajaxJsonComboBoxCommon("RS08", "wrhsdlvrSeCode", true);
}

//그리드 생성
function setUseProductLogMGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			useRegMasterCol : [],
			useRegDetailCol : []
	};
	
	// 사용량 그리드
	auigridCol(columnLayout.useRegMasterCol);
	columnLayout.useRegMasterCol.addColumnCustom("useQySeqno","사용량 일련번호",null,false,false)
	.addColumnCustom("brcd","바코드",null,true,false)
	.addColumnCustom("prductSeNm","제품 구분",null,true,false)
	.addColumnCustom("prductClNm","제품 분류명",null,true,false)
	.addColumnCustom("prductNm","제품명",null,true,false)
	.addColumnCustom("pc","제품가격",null,false,false)
	.addColumnCustom("prposNm","용도",null,true,false)
	.addColumnCustom("cstdysttusNm","보관 상태",null,true,false)
	.addColumnCustom("unitNm","제품 단위",null,true,false)
	.addColumnCustom("useQySeCode","사용량 구분코드",null,false,false)
	.addColumnCustom("useQySeNm","사용량 구분",null,true,false)
	.addColumnCustom("totUseQy","총 사용량",null,true,false)
	.addColumnCustom("totUseTime","총 사용시간",null,true,false)
	.addColumnCustom("wrhsdlvrNm","제품 상태",null,true,false)
	.addColumnCustom("usePurps","사용 목적",null,true,true)
	.addColumnCustom("rm","비고",null,true,true)
	.addColumnCustom("gridCrud","CRUD",null,false,false)
	
	
	auigridCol(columnLayout.useRegDetailCol);
	columnLayout.useRegDetailCol.addColumnCustom("brcd","바코드",null,true,false)
	.addColumnCustom("prductSeNm","제품 구분",null,true,false)
	.addColumnCustom("prductClNm","제품 분류명",null,true,false)
	.addColumnCustom("prductNm","제품명",null,true,false)
	.addColumnCustom("pc","제품가격",null,false,false)
	.addColumnCustom("prposNm","용도",null,true,false)
	.addColumnCustom("cstdysttusNm","보관 상태",null,true,false)
	.addColumnCustom("unitNm","제품 단위",null,true,false)
	.addColumnCustom("cntnrQy","용기량",null,true,false)
	.addColumnCustom("useQySeCode","사용량 구분 코드",null,false,false)
	.addColumnCustom("useQySeNm","사용량 구분",null,true,false)
	.addColumnCustom("useBeginDt","사용 시작일자",null,true,false)
	.addColumnCustom("useEndDt","사용 종료일자",null,true,false)
	.addColumnCustom("useQy","사용량",null,true,false)
	.addColumnCustom("usePurps","사용 목적",null,true,false)
	.addColumnCustom("rm","비고",null,true,false)
	.addColumnCustom("useDte","사용 일자",null,true,false) // 날짜 - 기본값 오늘
	.addColumnCustom("gridCrud","CRUD",null,false,false);
	
	useRegMGrid_Master = createAUIGrid(columnLayout.useRegMasterCol, useRegMGrid_Master);
	useRegMGrid_Detail = createAUIGrid(columnLayout.useRegDetailCol, useRegMGrid_Detail);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getUseProductLog();//모든 바코드 리스트를 호출함.
	});
};

function useProductLogMGridEvent(){
	AUIGrid.bind(useRegMGrid_Master, "cellDoubleClick", function(event){
		getUseProductDetailLog(event.item);//클릭한 바코드의 상세 이력을 불러온다.
	})
};

function getUseProductLog(){
	ajaxJsonForm3("/src/getUseBacode.lims", "searchFrm", function(data){
		if(!!data){
			AUIGrid.setGridData(useRegMGrid_Master, data);
		}
	});
};

function getUseProductDetailLog(data){
	var param = {brcdSeqno: data.brcdSeqno}
	ajaxJsonParam3("/rsc/getUseRegRecord.lims", param, function(data){
		if(!!data){
			AUIGrid.setGridData(useRegMGrid_Detail, data);
		}
	});
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>