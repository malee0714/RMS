<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000001001}</h2> <!-- 기기 가동률 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
		</div>
	
		<form action="javascript:;" id="searchFrm" name="searchFrm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:5%"></col> 
					<col style="width:15%"></col>
				</colgroup>
				<tr>
					<th>가동일자</th> <!-- 의뢰일자 -->
					<td style="text-align:left;">
						<input type="text" id="dateDteSch" name="dateDteSch" class="wd10p" style="min-width: 10em;"> 
						~ 
						<input type="text" id="dateDteFinish" name="dateDteFinish" class="wd10p" style="min-width: 10em;">
					</td>
				</tr>		
			</table>
		</form>
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="useRegMGrid_Master" style="width:100%; height:500px; margin:0 auto;"></div>
		</div>
		<div class="mgT5" style="text-align: right;" style="font-size:13px">
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
	
	setUseProductLogMGridEvent();
	
	gridResize([useRegMGrid_Master]);
	
	datePickerCalendar(["dateDteSch","dateDteFinish"], true, ["MM",0,"FIRST"], ["MM",0,"LAST"]);


});

</script>
<script>
var useRegMGrid_Master = 'useRegMGrid_Master';

function setCombo(){
	ajaxJsonComboBox('/com/getCmmnCode.lims','mhrlsClCodeSch',{"upperCmmnCode" : "RS02"}, true); /* 선택 */
	ajaxJsonComboBox('/com/getDeptCombo.lims','deptCodeSch',{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},false,"${msg.C000000079}"); /* 선택 */
	ajaxJsonComboBox('/com/getCmmnCode.lims', 'chrgTeamSeqnoSch', {'upperCmmnCode': 'RS19'}, false, "${msg.C000000079}"); /* 선택 */
}

//그리드 생성
function setUseProductLogMGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			useRegMasterCol : []
	};
	

	var rowProp = {
		enableCellMerge : true,
		cellMerge : true,
		cellMergePolicy : "withNull",
		rowSelectionWithMerge : true
	}
	

	// 사용량 그리드
	auigridCol(columnLayout.useRegMasterCol);

	columnLayout.useRegMasterCol.addColumnCustom("manageDeptNm","관리부서",null,true,false) /* 기기분류 */ 
	columnLayout.useRegMasterCol.addColumnCustom("chrgTeamNm","담당팀",null,true,false) /* 기기분류 */ 
	columnLayout.useRegMasterCol.addColumnCustom("mhrlsClNm","기기분류",null,true,false, rowProp) /* 기기분류 */ 
	columnLayout.useRegMasterCol.addColumnCustom("mhrlsNm","기기명",null,true,false, rowProp) /* 기기분류 */ 
	customAjax({"url":"<c:url value='/com/getDeptCombo.lims'/>",'data':{"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"},'successFunc': function(data) {
// 	ajaxJsonParam3("<c:url value='/com/getDeptCombo.lims'/>", {"analsAt" : "Y", "mmnySeCode" : "${UserMVo.mmnySeCode}"}, function(data) {
		for(var i=0; i<data.length; i++){
			columnLayout.useRegMasterCol.addColumnCustom(data[i].value,data[i].key,null,true,false) 
			.addChildColumn(data[i].value, data[i].value,"건수",null,true,false,null,null,null,null)
			
		}
	}
	}); 
	useRegMGrid_Master = createAUIGrid(columnLayout.useRegMasterCol, useRegMGrid_Master);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getmhrlsDeptOprList();//모든 바코드 리스트를 호출함.
	});
	
	$(".schClass").keypress(function (e) {
	    if (e.which == 13){
	    	getmhrlsOprList();
	    }
	});
};


function setUseProductLogMGridEvent(){
	AUIGrid.bind(useRegMGrid_Master, "ready", function(event) {
		gridColResize([useRegMGrid_Master],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
};

// 조회 함수
function getmhrlsDeptOprList() {
    getGridDataForm("<c:url value='/src/getmhrlsDeptOprList.lims'/>", "searchFrm", useRegMGrid_Master, function(data) {
		var mhrDeptList = new Array();
		var str = data[0].mhrlsSeqno;
		var resultValueArr = {};	 
		resultValueArr["mhrlsClNm"] = data[0].mhrlsClNm;
		resultValueArr["mhrlsNm"] = data[0].mhrlsNm;
		resultValueArr["manageDeptNm"] = data[0].manageDeptNm;
		resultValueArr["chrgTeamNm"] = data[0].chrgTeamNm;
	    for(var i=0; i<data.length; i++){
	    	if(str == data[i].mhrlsSeqno){
	    		resultValueArr[data[i].inspctInsttCode] = data[i].teamQy;

	    	} else {
	    		mhrDeptList.push(resultValueArr);
				str = data[i].mhrlsSeqno;
				resultValueArr={};
				resultValueArr[data[i].inspctInsttCode] = data[i].teamQy;
				resultValueArr["mhrlsClNm"] = data[i].mhrlsClNm;
				resultValueArr["mhrlsNm"] = data[i].mhrlsNm;
				resultValueArr["manageDeptNm"] = data[i].manageDeptNm;
				resultValueArr["chrgTeamNm"] = data[i].chrgTeamNm;
				
	    	}
	    	
	    	if(i==data.length-1){
	    		mhrDeptList.push(resultValueArr);
	    	}
	    }
	    AUIGrid.setGridData(useRegMGrid_Master,mhrDeptList);
		console.log(mhrDeptList)
    });
}


</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>