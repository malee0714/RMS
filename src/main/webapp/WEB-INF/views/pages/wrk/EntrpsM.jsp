<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">업체관리</tiles:putAttribute>
    <tiles:putAttribute name="body">

<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000588}</h2><!-- 업체 목록 -->
		<div class="btnWrap">
			<button id="btnAddRow" class="btn5"><img src="/assets/image/plusBtn.png"></button>
			<button id="btnRemoveRow"  class="delete"><img src="/assets/image/minusBtn.png"></button>
			<button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
			<button type="button" id="srchBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<form id="srchForm" action="javascript:;">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
				</colgroup>
				<tr>
				 	<th>${msg.C100000593}</th> <!-- 업체구분 -->
					<td>
						<select class="enterKeypress" id="entrpsSeCodeSch" name="entrpsSeCodeSch">
							<option value=''>${msg.C100000480}</option> <!-- 선택 -->
						</select>
					</td>
					
					<th>${msg.C100000587}</th> <!-- 업체명 -->
					<td><input class="enterKeypress" type="text" id ="srchentrpsNm" name ="srchentrpsNm" ></td>
					
									
					<th>사용 여부</th> <!-- 사용여부 -->
					<td>
						<input class="enterKeypress" type="radio" id="srcUseAt" name="srcUseAt" value="">전체
						<input class="enterKeypress" type="radio" id="srcUseAt" name="srcUseAt" value="Y" checked>사용
						<input class="enterKeypress" type="radio" id="srcUseAt" name="srcUseAt" value="N">사용안함
					</td>
					
					<td></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div class="mgT15">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="entrpsMListGrid" class="wd100p" style="width:100%; height:300px; margin:0 auto;"></div>
	</div>

</div>



<!--  body 끝 -->
    </tiles:putAttribute>
   <tiles:putAttribute name="script">
<!--  script 시작 -->
<script>
	//각 그리드 영역의 Id값 저장
	var entrpsMListId = 'entrpsMListGrid';
	var entrpsMFrm = 'entrpsMFrm';
	
	//그리드 객체를 담을 변수
	var entrpsMListGrid;
	
	var saveKeyList = [];
	var rowNum = "";
	
	document.addEventListener("DOMContentLoaded", function() {
		
		// AUI 그리드
		setEntrpsGrid();
	 
		//버튼 이벤트
		setButtonEvent();
		
		// 콤보 박스
		setCombo();
		
		// 그리드 이벤트
		auiGridEvent()
	});
	

	var gidID;
	var param;
	var url;
	function setEntrpsGrid(){
		//그리드 정의
		var columnLayout = {
			entrpsMListGrid : [],		
		}
		
		var checkboxProp = {
			check : "Y",
			unCheck : "N"
		}
		
		var unitPros = {
    		editRenderer : {
    			type : "InputEditRenderer"
    		}
	    };
		
		var entrpsRequirePros = {
			headerTooltip : { // 헤더 툴팁 표시 일반 스트링
				show : true,
				tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
			}
		};
		
		//업체관리 그리드
		auigridCol(columnLayout.entrpsMListGrid);
		columnLayout.entrpsMListGrid.addColumnCustom("entrpsNm","업체명",null,true,true, entrpsRequirePros); 	// 업체명
		columnLayout.entrpsMListGrid.addColumnCustom("entrpsSeCodeCus","고객사",null,true,true);				// 고객사 
		columnLayout.entrpsMListGrid.addColumnCustom("entrpsSeCodeCoop","협력사",null,true,true); 			// 협력사 
		columnLayout.entrpsMListGrid.addColumnCustom("entUseAt","사용여부",null,true); 						// 사용여부 
		columnLayout.entrpsMListGrid.addColumnCustom("entrpsSeqno","entrpsSeqno",null,false);				// 업체일련번호
		columnLayout.entrpsMListGrid.checkBoxRenderer(["entUseAt", "entrpsSeCodeCus", "entrpsSeCodeCoop"],entrpsMListGrid, checkboxProp);
		
		entrpsMListId = createAUIGrid(columnLayout.entrpsMListGrid,entrpsMListId,{selectionMode : "multipleCells"});
		auiGridEvent();
		
	}

	// 콤보 박스
	function setCombo(){
		//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
		ajaxJsonComboBox('/com/getCmmnCode.lims', 'entrpsSeCodeSch', {'upperCmmnCode': 'SY08'}, false,"${msg.C100000480}");
	}
	
	// 그리드 이벤트
	function auiGridEvent(){
		
		// 업체명 체크 로직
		AUIGrid.bind(entrpsMListId, "cellEditEnd", function( event ) {
			if(event.headerText == "업체명") {
				
				var gridData = AUIGrid.getRowIndexesByValue(entrpsMListId, "entrpsNm", [event.value]);
				if(gridData.length >= 2) {
					AUIGrid.undo(entrpsMListId);
					warn("이미 등록된 같은 업체명이 존재합니다.");
				}	
			}
		});
		
		// AUI 데이터 변경 후 선택 이벤트
        AUIGrid.bind(entrpsMListId, "ready", function() {
            gridColResize(entrpsMListId, "2");
            
            if(saveKeyList.length !== 0) {
            	
            	if(saveKeyList[0].length !== 0) {
            		 for(var i=0; i<saveKeyList[0].length; i++) {
                     	gridSelectRow(entrpsMListId, "entrpsSeqno", [saveKeyList[0][i].entrpsSeqno]);
                     }
            	}
            	
            	if(saveKeyList[1].length !== 0) {
           			for(var i=0; i<saveKeyList[1].length; i++) {
           				gridSelectRow(entrpsMListId, "entrpsSeqno", [saveKeyList[1][i].entrpsSeqno]);
                    }
           		}
            }
			
            saveKeyList = [];
        });
		
	}
	
	/* 버튼 이벤트 */
	function setButtonEvent(){
		
		// 행추가 이벤트
		document.getElementById("btnAddRow").addEventListener('click',function(){
			addRow();
		})
		
		// 행삭제 이벤트
		document.getElementById("btnRemoveRow").addEventListener('click',function(){
			removeRow();
		})

		// 저장 이벤트
		document.getElementById("btnSave").addEventListener('click',function(){
			saveEntrpsM();
		})
		
		// 조회 이벤트
		document.getElementById("srchBtn").addEventListener('click',function(){
			searchEntrpsM();
			auiGridEvent();
		})
		
		// 엔터키 조회 이벤트.
		var keypressBox = document.getElementsByClassName("enterKeypress");
		for(var i=0; i<keypressBox.length; i++) {
			keypressBox[i].addEventListener('keypress', function(e){
				if(e.which == 13) {
					searchEntrpsM();
				}
			})
		}
	}

	//업체관리 조회
	function searchEntrpsM(srch){
		url="/wrk/getEntrpsMList.lims";
		divID="entrpsMListGrid";
		var srchForm =document.getElementById("srchForm");
		getGridDataForm(url, srchForm.id, divID);
	}

	//행추가
	 function addRow() {
 		var item = new Object();
		item.entUseAt = "Y"
 	    item.entrpsSeCodeCus = "N"
 	    item.entrpsSeCodeCoop = "N"
 	 	item.gbnCrud = "C" // insert 구분값
		AUIGrid.addRow(entrpsMListId, item, "last");
	};

	//행삭제
	function removeRow() {
 		AUIGrid.removeRow(entrpsMListId, "selectedIndex");
	}

	function saveEntrpsM() {
		
		var param = {};
		
		// 추가, 수정, 삭제 그리드 데이터
		param.insgridData = AUIGrid.getAddedRowItems(entrpsMListId);
		param.updGridData = AUIGrid.getEditedRowItems(entrpsMListId);
		param.delGridData = AUIGrid.getRemovedItems(entrpsMListId);
		
		// 입력 데이터 확인.
		if(!param.insgridData.length && !param.updGridData.length && !param.delGridData.length) {
			warn("저장할 데이터를 입력해주세요");
			return;
		}
		
		// 입력 데이터 확인.
		for(var i=0; i<param.insgridData.length; i++) {
			if(param.insgridData[i].entrpsNm == "" || param.insgridData[i].entrpsNm == null ) {
				warn("업체명을 입력해주세요.");
				return;
			}
		}
		
		// 업체명 검사후에 데이터 저장하기.
		customAjax({
			url: '/wrk/entrpsNmValidation.lims',
			data: param
		}).then(function(res,status){
			if(res >= 1){
				warn("이미 등록된 같은 업체명이 존재합니다.");
				return;
			} else {
				customAjax({
					url: '/wrk/saveEntrpsM.lims',
					data: param
				}).then(function(res,status){
					saveKeyList.push(res.insgridData);
					saveKeyList.push(res.updGridData);
					console.log(saveKeyList);
					if(status === 'success'){
						searchEntrpsM();
						success("${msg.C100000765}"); 			/* 저장 되었습니다. */
					} 
				})
			}
		})
	}
	
</script>
<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>

