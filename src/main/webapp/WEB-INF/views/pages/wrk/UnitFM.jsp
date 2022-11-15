<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<h2>${msg.C000000324}</h2> <!-- 단위목록 -->
		<div class="btnWrap">
			<button type="button" id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form action="javascript:;" id="unitSearchFrm" name="unitSearchFrm">							
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>			
					<col style="width:65%"></col>			
				</colgroup>
				<tr>
				<th>${msg.C000000326}</th> <!-- 단위명 -->
				<td><input type="text"  id="txtUnitNM" name="txtUnitNM" class="wd100p"></td>						
				<th>${msg.C000000065}</th> <!-- 사용여부 -->
				<td style="text-align:left;">
					<label><input type="radio" name="useAtSearch" value="">${msg.C000000062}</label> <!-- 전체 -->
			    	<label><input type="radio" name="useAtSearch" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
			    	<label><input type="radio" name="useAtSearch" value="N" >${msg.C000000064}</label> <!-- 사용안함 -->
				</td>	
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon1">
		<div class="mgT15">
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
			<div id="unitGrid" style="width:100%; height:500px; margin:0 auto;"></div>
		</div>
	</div>
		<br><br>
		<div class="subCon1">
		<h2>단위 추가</h2> <!-- 단위 명 추가-->
		<div class="btnWrap">
			<button type="button" id="btnDeleteRow" class="delete btn5">${msg.C000000112}</button> <!-- 행삭제 -->
			<button id="btnNew" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
			<button id="btnUnitfSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="menuDtlFrm" name="menuDtlFrm" onsubmit="return false">
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
					<th class="necessary">단위 명</th> <!-- 단위명 -->
					<td><input type="text" name="unitNm" id="unitNm"></td>
					<th>${msg.C000000065}</th> <!-- 사용여부 -->
					<td colspan="5" style="text-align:left;">
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C000000063}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N">${msg.C000000064}</label> <!-- 사용안함 -->
					</td>
				</tr>				
			</table>
			<input type="text" name="unitSeqno" id="unitSeqno" style="display:none"/>
		</form>
	</div>
</div>
	
</tiles:putAttribute>
    
<tiles:putAttribute name="script">
<script>
var lang = ${msg}; // 기본언어
//AUIGrid 생성 후 반환 ID
var unitGrid = "unitGrid";
var menuDtlFrm = "menuDtlFrm";

var searchUnitUrl = "<c:url value='/wrk/getUnitList.lims'/>";
var saveUnitUrl = "<c:url value='/wrk/saveUnit.lims'/>";

var unitSearchFrm ='unitSearchFrm';
var unitInfoFrm = 'unitInfoFrm';
var putStatus = 'C';	//  C: insert / U : update


//출처구분 GridCombo
var unitSeList = getGridComboList("<c:url value='/com/getCmmnCode.lims'/>",{upperCmmnCode: "SY07"}, true);

	$(function() {
		getAuth(); //권한 체크
		
		// 콤보 셋팅
		setCombo();
		
		// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
		setUnitGrid();
		
		// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
		setUnitGridEvent();
		
		// 버튼 이벤트
		setButtonEvent();
		
		// 기타 이벤트
		setEtcEvent();
		
		//그리드 사이즈 조절
		gridResize([unitGrid]);
		
		//폼 및 그리드 초기화
		frmReset();
		
		searchUnitGrid();
	});

	//콤보로드
	function setCombo() {	
		ajaxJsonComboBox('/com/getCmmnCode.lims','cboUnitSe',{"upperCmmnCode" : "SY07"},false,"${msg.C000000079}"); /* 선택 */
	}


	//그리드 생성
	function setUnitGrid(){
		
	////그리드 정의 userGrid
		var unitCol = [];		
		auigridCol(unitCol);
		
		//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
		//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함
		var unitGridColPros = {
			renderer : {
				type : "DropDownListRenderer",
				list : unitSeList, //key-value Object 로 구성된 리스트
				keyField : "value", // key 에 해당되는 필드명
				valueField : "key" // value 에 해당되는 필드명
			},
			labelFunction : function(  rowIndex, columnIndex, value, headerText, item ) {
				var retStr = "";
				for(var i=0,len=unitSeList.length; i<len; i++) {
					if(unitSeList[i]["value"] == value) {
						retStr = unitSeList[i]["key"];
						break;
					}
				}
				return retStr;
			}
		};
		
		var checkboxProp = {
				check : "Y",
				unCheck : "N"
		}
		
		var gridProp = {
				showStateColumn : true,
				selectionMode : "multipleCells",
				softRemovePolicy : "exceptNew",
				softRemoveRowMode:true
		}
		
		unitCol.addColumnCustom("unitSeqno","단위 일련번호",null,false,null);
		unitCol.addColumnCustom("unitNm","${msg.C000000326}",null,true,false); /* 단위명 */
		unitCol.addColumnCustom("unitSeCode","${msg.C000000325}",null,false,true, unitGridColPros); /* 단위구분 */
		unitCol.addColumnCustom("useAt","${msg.C000000065}",null,true,false); /* 사용여부 */
// 		unitCol.checkBoxRenderer(["useAt"],unitGrid, checkboxProp);
		//속성
		
		// 실제로 #grid_wrap 에 그리드 생성
		unitGrid = createAUIGrid(unitCol, unitGrid, gridProp);	
	};
//그리드 이벤트
function setUnitGridEvent(){	
	AUIGrid.bind(unitGrid, "cellDoubleClick", function(event) {
		$("#unitNm").val(event.item.unitNm);
		$("#useAt").val(event.item.useAt);
		$("#unitSeqno").val(event.item.unitSeqno);
		
	 if(event.item.useAt == 'Y')
			$("#useY").val(event.item.useAt).prop("checked", true);
		else 
			$("#useN").val(event.item.useAt).prop("checked", true);
		putStatus = 'U'; 
		
	AUIGrid.bind(unitGrid, "ready", function(event) {
		gridColResize(unitGrid, "2");	// 1, 2가 있으니 화면에 맞게 적용
		})
	})	
};

//버튼 이벤트
function setButtonEvent(){
	$('#btnNew').click(function() {
		// 폼 초기화
		$('#dispOrder').prop('readonly',true);
		$('#menuUrl').prop('readonly',false);
		$('#menuDtlFrm')[0].reset();
		//부모 메뉴키에 맞춰서 초기화된거 체인지해줌 
		putStatus = 'C'; // 삽입가능상태로 전환
	});
	//조회버튼
	$('#btnSearch').click(function(){
		searchUnitGrid();
	});
	
	//저장
	$("#btnUnitfSave").click(function (){
		//단위명 중복확인
		
/* 		var inputUnitName = $('#unitNm').val();
		var gridData = AUIGrid.getGridData(unitGrid);
		
		if(inputUnitName == null || inputUnitName == "") {
				alert('단위명은 필수사항입니다.');
				return false;
			}
			for (var i = 0; i < gridData.length; i++) {
				if (inputUnitName == gridData[i].unitNm && putStatus == 'C') {
					alert('같은 단위명이 있습니다.');
					return false;
				}
			} */
			
// 단위명 중복 체크 함수  
		var inputUnitName = $('#unitNm').val();
		var confirmUrl = "<c:url value='/wrk/confirmUnitFM.lims'/>";

		if (inputUnitName != '') {
			ajaxJsonForm(confirmUrl, 'menuDtlFrm', function(data) {
				if (data != 0) {
						alert('${msg.C000000137}'); /* 중복값이 존재 합니다. 다시 입력해 주세요 */
						$('#unitNm').val(''); 
						return false;
				} else {
					saveUnitGrid(); //실질적으로 저장하는 함수
				}
			});
		}
	});

		//초기화 저장
		$("#btnReset").click(function() {
			frmReset();
		});

		$("#btnAddRow").click(function() {
			var item = {
				unitSeqno : "",
				unitSeCode : '',
				useAt : "Y"
			}
			AUIGrid.addRow(unitGrid, item, 'last');
		});

		$("#btnDeleteRow").click(
		function() {
			var selectedItems = AUIGrid.getSelectedItems(unitGrid); //그리드(unitGrid) 선택한 행의 데이터를 가져옴
			var unitSeqno = AUIGrid.getSelectedItems(unitGrid)[0].item.unitSeqno;
			var param = {
				unitSeqno : unitSeqno
			}
			console.log(selectedItems);
			if (selectedItems.length == 0) {
				alert("${msg.C000000327}"); /* 선택된 행이 없습니다. */
				return false;
			}
			if (!confirm("${msg.C000000178}")) { /* 삭제하시겠습니까? */
				return false;
			}
			//삭제
			ajaxJsonParam("/wrk/delUnitFM.lims", param,
				function(data) {
					if (!!data)
						alert("${msg.C000000071}"); /* 저장 되었습니다. */
						frmReset();
						searchUnitGrid();
						
			}, function(request, status, error) {
					alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
						});
					});
				};

	//기타이벤트
	function setEtcEvent() {
		$("#txtUnitNM").keypress(function(e) {
			if (e.which == 13) {
				searchUnitGrid();
			}
		});
	}
	/*############ 조회, 저장, 삭제 함수 ############*/
	//조회
	function searchUnitGrid() {
		getGridDataForm(searchUnitUrl, unitSearchFrm, unitGrid);
	};

	//저장
	function saveUnitGrid() {

		if (putStatus == 'C') {
			ajaxJsonForm("/wrk/insUnitFM.lims", menuDtlFrm, function(data) {
				if (!!data)
					alert("${msg.C000000071}"); /* 저장 되었습니다. */
				$('#menuDtlFrm')[0].reset();
				$('#btnNew').trigger('click');
				searchUnitGrid();
			}, function(request, status, error) {
				alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
			});

		} else if (putStatus == 'U') {
			ajaxJsonForm("/wrk/updUnitFM.lims", menuDtlFrm, function(data) {
				if (!!data)
					alert("${msg.C000000323}"); /* 수정되었습니다. */
				$('#menuDtlFrm')[0].reset();
				$('#btnNew').trigger('click');
				searchUnitGrid();
			}, function(request, status, error) {
				alert("${msg.C000000190}"); /* 오류가 발생했습니다. log를 참조해주세요. */
			});
		}
	};

	//폼 초기화시 이벤트별로 셋팅할 것 들
	function frmReset() {
		AUIGrid.clearGridData(unitGrid);
	}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>