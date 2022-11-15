<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">PCN 관리</tiles:putAttribute>
	<tiles:putAttribute name="script">
<script>
	
	var pcnGrid = 'pcnGrid';
	var pcnDocHistGrid = 'pcnDocHistGrid';
	var lang = ${msg};
	var dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", {btnId : "#btnSave_file", maxFiles : 10, lang : "${msg.C100000867}"});  /* 첨부할 파일을 이 곳에 드래그하세요. */
	var saveFormEl = document.querySelector('#pcnForm');
	var visibleSupport = new VisibleSupport('data-visible-code');
	var sanctnLineControl = new SelectBoxControll(saveFormEl.querySelector('[name=sanctnLineSeqno]'));
	var saveKey = '';
	
	document.addEventListener("DOMContentLoaded", function() {
		
		init();
		
		setComboId();
		
		setComboName();
	
		setGrid();

		auiGridEvent();
	
		setButtonEvent();
		
		renderingDialog();
	});
	
	function init() {
		
		// Calendar Setting
		datePickerCalendar(["prearngeBeginDte"], true, ["YY", -1], ["DD",0]);
		datePickerCalendar(["prearngeEndDte"], true, ["DD",0]);
		datePickerCalendar(["comptBeginDte"], true, ["YY", -1], ["DD",0]);
		datePickerCalendar(["comptEndDte"], true, ["DD",0]);
		
		datePickerCalendar(["prearngeDte"], false, ["DD",0]);
		datePickerCalendar(["pblicteDte"], false, ["DD",0]);
		datePickerCalendar(["comptDte"], false, ["DD",0]);
		
		progrsControll('init');
	}
	
	function setComboId() {
		ajaxJsonComboBox("/com/getCmmnCode.lims", "pcnGradCode", {"upperCmmnCode" : "RS29"}, true, "${msg.C100000480}");
		ajaxJsonComboBox("/com/getCmmnCode.lims", "m5e1Code", {"upperCmmnCode" : "RS27"}, true, "${msg.C100000480}");
		ajaxJsonComboBox("/com/getCmmnCode.lims", "pcnResultCode", {"upperCmmnCode" : "RS30"}, true, "${msg.C100000480}");
	}
	
	function setComboName() {
	    
	    ajaxJsonComboTrgetName({
	        url : '/com/getCmmnCode.lims',
	        name : 'changePointSttusCode',
	        queryParam : {"upperCmmnCode": "RS23"},
	        selectFlag : true
	    });
	   
	    ajaxJsonComboTrgetName({
	        url : '/qa/getEntrpsNameList.lims',
	        name : 'ctmmnySeqno',
	        queryParam : {"": ""},
	        selectFlag : true
	    });
	    
	    ajaxSelect2Box({
	    	ajaxUrl : '/qa/getMtrilNameList.lims',
	    	elementId : 'mtrilSeqno',
	        ajaxParam : {"upperCmmnCode": "SY20"}
	    });
	    
	    ajaxJsonComboTrgetName({
	        url : '/wrk/getDeptComboList.lims',
	        name : 'chrgDeptCode',
	        queryParam : { "bestInspctInsttCode": "${UserMVo.bplcCode}" },
	        selectFlag : true,
	        selectVal : "${UserMVo.deptCode}"
	    });
	    bindUserSelectbox("${UserMVo.deptCode}");
	    
	    ajaxJsonComboTrgetName({
	        url : '/qa/getDocSanctnLineCombo.lims',
	        name : 'sanctnLineSeqno',
	        queryParam : { "deptCode": "${UserMVo.deptCode}", "sanctnKndCode": "CM05000004" },
	        selectFlag : true
	    });
	    
	}
	
	function bindUserSelectbox(deptCode, callback) {	
		ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', 
							name : 'chargerId', 
							queryParam : { 'deptCode': deptCode }, 
							selectFlag : true, successfunc : callback});
	}
	
	function setGrid() {
		
		var col = {
			pcnGridCol : [],
			pcnDocHistGrid : []
		};
	
		var basicPros = {
			editable: false,
			selectionMode : "multipleCells",
			enableCellMerge : true,
			showRowCheckColumn: true,
			showRowAllCheckBox: true,
			rowStyleFunction: function (rowIndex, item) {
                return (item.sanctnProgrsSittnCode === "CM01000004") ? "grid-scarce" : "";
            }
		};
	
		auigridCol(col.pcnGridCol);
	
		col.pcnGridCol
		.addColumnCustom('pcnNo','PCN NO.') 				  		   				// PCN NO
		.addColumnCustom('m5e1Nm','5M1E')          									// 5M1E 이름
		.addColumnCustom('pcnNm','PCN명')											// PCN 명
		.addColumnCustom('ctmmnySeqnoNm','고객사')									// 고객사
		.addColumnCustom('mtrilSeqnoNm','품목')										// 품목
		.addColumnCustom('changePointApplcCn','변경점 상태',"*")							// 변경점 상태
		.addColumnCustom('prearngeDte','예정일자')										// 예정 일자
		.addColumnCustom('pblicteDte','발행일자')										// 발행 일자
		.addColumnCustom('comptDte','완료일자')										// 완료 일자
		.addColumnCustom('chargerNm','담당자')										// 담당자
		.addColumnCustom('pcnGradNm','PCN grade')									// PCN grade
		.addColumnCustom('pcnResultNm','PCN 결과')									// PCN 결과
		.addColumnCustom('pcnCn','PCN 내용', '*')										// PCN 내용
		.addColumnCustom('pcnBfeCn','PCN 전','*')										// PCN 전
		.addColumnCustom('pcnAfterCn','PCN 후','*')									// PCN 후
		.addColumnCustom("sanctnProgrsSittnCodeNm", "결재진행상태")						// 결재진행사항
		.addColumnCustom('pcnSeqno','pcnSeqno', false, false); 				  		// PCN_SEQNO
		
		pcnGrid = createAUIGrid(col.pcnGridCol, "pcnGrid", basicPros);
		
		
		auigridCol(col.pcnDocHistGrid);
		col.pcnDocHistGrid.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)		// 품질문서이력 일렬번호
		.addColumnCustom('tableNm',lang.C100000973,'*',true,false)                				// 테이블명
		.addColumnCustom('tableCmNm',lang.C100000974,'*',true,false)              				// 테이블 주석명
		.addColumnCustom('columnNm',lang.C100000975,'*',true,false)               				// 컬럼명
		.addColumnCustom('columnCmNm',lang.C100000976,'*',true,false)             				// 컬럼 주석명
		.addColumnCustom('seqno','일련번호','*',false,false)										// 일련번호
		.addColumnCustom('changeBfeCn',lang.C100000382,'*',true,false)            				// 변경 전
		.addColumnCustom('changeAfterCn',lang.C100000384,'*',true,false)         				// 변경 후
		.addColumnCustom('changerNm',"최종변경자",'*',true,false)              						// 최종 변경자
		.addColumnCustom('lastChangeDt',"최종 변경일시",'*',true,false);          					// 최종 변경 일시
	
		pcnDocHistGrid = createAUIGrid(col.pcnDocHistGrid, "pcnDocHistGrid", "");
	
		auiGridEvent();
	}
	
	function auiGridEvent() {
		
		// AUI 데이터 변경 후 선택 이벤트
        AUIGrid.bind(pcnGrid, "ready", function() {
            // gridColResize(pcnGrid);
            if ( !!saveKey ){
                gridSelectRow(pcnGrid, "pcnSeqno", [saveKey]);
            }
            saveKey = '';
        });
		
		// AUI 그리드 더블 클릭 이벤트
		AUIGrid.bind(pcnGrid, "cellDoubleClick", function(event) {

			document.getElementById("crud").value = "U";
			var changePointApplcCns = document.getElementsByName("changePointApplcCn");
			
			for(var i in changePointApplcCns) {
				changePointApplcCns[i].checked = false;
			}
			
			detailAutoSet({targetFormArr : ["pcnForm"], item : event.item, successFunc : function() {
					
					// 담당자 비동기 문제 처리
					changeDept(event.item.chrgDeptCode, event.item.chargerId);
					
					// 다이얼로그 작업.
					var seqno = event.item.pcnSeqno;
					getPcnHistList(seqno);
					
					progrsControll(event.item.sanctnProgrsSittnCode);
					
				}
			})
			
			if(event.item.changePointApplcCn != null && event.item.changePointApplcCn != "") {
				var changePointApplcCnNms = event.item.changePointApplcCn.split(',');
				
				// 변경점 적용 매핑
				for(var i in changePointApplcCns) {
					changePointApplcCnNms.forEach(function(item){
						if(item == changePointApplcCns[i].value){
							changePointApplcCns[i].checked = true;
						}
					})
				}
			}
			
		});
	}
	
	
	function setButtonEvent() {
		
		// 고객사 리셋 버튼
        saveFormEl.querySelector('#ctmmnyReset').addEventListener('click', function () {
            saveFormEl.querySelector('[name=ctmmnySeqnoNm]').value = '';
            saveFormEl.querySelector('[name=ctmmnySeqno]').value = '';
        });
		
		
     	// 조회 엔터키 event
		var keypressBox = document.getElementsByClassName("schClass");
		for(var i=0; i<keypressBox.length; i++) {
			keypressBox[i].addEventListener('keypress', function(e){
				if(e.which == 13) {
					getPcnList();
				}
			})
		}
		
		// 보고서 출력btn click event
		document.getElementById("printReport").addEventListener('click', function() {
			printReport();
		});

		// 조회btn click event
		document.getElementById("btnSearch").addEventListener('click', function(e) {
			getPcnList();
		});
	
		// 신규btn click event
		document.getElementById("btnNew").addEventListener('click', function(e) {
			saveFormEl.reset();
	    	dropZoneArea.clear();
			progrsControll('init');
	    	document.getElementById('crud').value = "C";
			setComboName();
		});
	
		// 삭제btn click event
		document.getElementById("btnDelete").addEventListener('click', function(e) {
			var crud = document.getElementById('crud').value;
			if(crud == "C" || crud == "") {
				alert("${msg.C100000467}");  /* 삭제할 데이터가 없습니다. */
				return;
			}
	
			if(!confirm("${msg.C100000461}")) {  /* 삭제하시겠습니까? */
				return;
			}else {
				document.getElementById("deleteAt").value = "Y";
				savePcnInfo(e);
			}
		});
	
		// 회수 btn click event
		document.getElementById("btnRevert").addEventListener('click', function(e) {
			revertPcn();
		});
		
		// 임시 저장 btn click event
		document.getElementById("btnTempSave").addEventListener('click', function(e) {
			var pblicteDte = document.getElementById("pblicteDte").value;
			if(pblicteDte == null || pblicteDte == "") {
				warn("발행일자를 입력해주세요.");
			} else {
				saveFile(e);
			}
		});
		
		// 검토 btn click event.
        saveFormEl.querySelector('#btnExmnt').addEventListener('click', function (e) {
            var pcnSeqnoValue = getOtherKey();
            if (!!pcnSeqnoValue) {
                saveFormEl.querySelector('#btnDialogExmnt').click();
            } else {
                warn('PCN 정보 저장 후 검토할 수 있습니다.');
            }
        });
		
		// 결재상신btn click event.
        saveFormEl.querySelector('#btnSave').addEventListener('click', function (e) {
        	var crud = document.getElementById('crud').value;

			if(!sanctnValid()){
				warn("결재 정보 선택 또는 결재 라인을 설정해주세요.");
				return;
			} else if(!saveValidation("pcnForm")) {
    			return;
    		}
        	saveFile(e);
        });
		
		// 결재 정보 변경.
        saveFormEl.querySelector('[name=sanctnLineSeqno]').addEventListener('change', function (e) {
            customAjax({
                url: '/wrk/getSanctnerList.lims',
                data: {sanctnLineSeqno: e.target.value},
            }).then(function (res) {
                if (res.length > 0) {
                    var sanctnerNm = getSanctnerNm(res);
                    saveFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(res);
                    saveFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
                } else {
                    warn('선택된 결재자가 없습니다.');
                }
            });
        });
		
		// 결제 정보 리셋.
        saveFormEl.querySelector('#sanctnReset').addEventListener('click', function () {
            saveFormEl.querySelector('[name=sanctnerNm]').value = '';
            saveFormEl.querySelector('[name=sanctnSeqno]').value = '';
        });

	}

	function renderingDialog(){
		
		// 고객사 팝업
        dialogEntrps("ctmmnySch", "SY08000002", "entrpsDialog", function(data){
            saveFormEl.querySelector('input[name=ctmmnySeqnoNm]').value = data.entrpsNm;
            saveFormEl.querySelector('input[name=ctmmnySeqno]').value = data.entrpsSeqno;
        }, null);
		
        // 결재 팝업
        dialogSanctn("sanctnLineChg", { dept: '${UserMVo.deptCode}' }, "sanctnDialog", function (res) {

            var list = res.gridData;
            if (list.length > 0) {
                var sanctnerNm = getSanctnerNm(list);
                saveFormEl.querySelector('input[name=sanctnInfoList]').value = JSON.stringify(list);
                saveFormEl.querySelector('input[name=sanctnerNm]').value = sanctnerNm; // 결재자명
            } else {
                warn('선택된 결재자가 없습니다.');
            }
        }, null, "CM05000004"); //결재종류 감사
        
        // 검토 팝업.
        dialogExmnt({
            btnId: 'btnDialogExmnt',
            functions: {
                getExmntSeqno : getExmntSeqno,
                getOtherKey : getOtherKey,
                init : function() {
                	document.getElemntById("popupClose_pcnDialogExmnt").click();
                	saveFormReset();
                }
            },
            dialogId: 'pcnDialogExmnt',
            url: '/qa/pcnManageSaveExmnt.lims'
        });
	}
	
	// Pcn 입력폼 리셋하기.
	function saveFormReset(){
		document.getElementById('crud').value = "C";
		saveFormEl.reset();
    	dropZoneArea.clear();
		getPcnList();
		AUIGrid.clearGridData(pcnDocHistGrid);
		setComboName();
		progrsControll('init');
	}

	// PCN 보고서 출력
	function printReport() {

		var chkedItems = AUIGrid.getCheckedRowItemsAll(pcnGrid);
		if (chkedItems.length == 0) {
			alert("선택된 PCN이 없습니다."); /* 선택된 PCN이 없습니다. */
			return;
		}

		var RdUrl = "";
		var seqArr = [];
		var param = {
			printngSeCode: "SY15000001",   // 출력물 구분
			printngOrginlFileNm: "PCN.mrd" // 출력물 원본 파일 명
		};

		customAjax({
			url: "/com/printCours.lims",
			data: param,
			successFunc: function(data) {
				if (data.length == 1) {
					RdUrl = data[0].printngOrginlFileNm; // Local Server
//					RdUrl = data[0].printngCours; // 운영&테스트 Server

					chkedItems.forEach(function (item) {
						seqArr.push(item.pcnSeqno);
					});

					html5Viewer([RdUrl], seqArr);

				} else {
					err(lang.C100000597); /* 오류가 발생했습니다. */
				}
			}
		});
	}

	// PCN 목록 조회
	function getPcnList() {

		var pcnSeqno = document.getElementById("pcnSeqno").value;
		
		getGridDataForm('/qa/getPcnList.lims', 'SearchFrm', pcnGrid, function() {
				if(!!pcnSeqno){
					var wdtbSeqno = AUIGrid.getItemsByValue(pcnGrid, "pcnSeqno", pcnSeqno)[0].wdtbSeqno;
					document.getElementById("wdtbSeqno").value = wdtbSeqno
				}
		})
	}
	
	// PCN 이력 조회
	function getPcnHistList(seqno){
		getGridDataParam('/com/getQlityDocHistList.lims', {seqno : seqno, tableNm : "RS_PCN"}, pcnDocHistGrid);
	}
	
	function revertPcn(){
		
        var param = saveFormEl.toObject();
        param.sanctnInfoList = [];
		
		var ajax = customAjax({
			'url': "/qa/revertPcn.lims",
			'data': param,
			'successFunc': function(res, status) {
				if(status === 'success') {
					success("회수되었습니다");  /* 회수되었습니다. */
					saveKey = res.pcnSeqno;
					saveFormReset();
				}
			}
		});
	}
	

	// dropZone File 저장
	function saveFile(e) {
		
		var fileValid = $("#dropZoneArea")[0].childNodes[0].length;
	
		var newFiles = dropZoneArea.getNewFiles();
		var filesCnt = newFiles.length;
		if(filesCnt > 0) {
			document.getElementById("btnSave_file").click();
			dropZoneArea.on("uploadComplete", function(event, fileIdx) {
				 if (fileIdx === -1) {
	                    err('${msg.C100000864}') /* 첨부파일 저장에 실패하였습니다. */
                } else {
                	saveFormEl.querySelector('input[name=atchmnflSeqno]').value = fileIdx;
    				savePcnInfo(e);
                }
			});
		}else {
			savePcnInfo(e);
		}
	}
	
	// PCN 정보 저장
	function savePcnInfo(e) {
		
		var crudVal = document.getElementById("crud").value;
		var pcnSeqno = document.getElementById("pcnSeqno").value;
		var insUrl = '/qa/insPcnInfo.lims';
		var updUrl = '/qa/updPcnInfo.lims';
		var insApprovalPcnM = '/qa/insApprovalPcnM.lims';
		var updApprovalPcnM = '/qa/updApprovalPcnM.lims';
		var isApproval = e.target.id === "btnSave";
		
		var sanctnInfoList = saveFormEl.querySelector('input[name=sanctnInfoList]').value;
        sanctnInfoList = (!!sanctnInfoList) ? JSON.parse(sanctnInfoList) : [];
		
        var param = document.getElementById("pcnForm").toObject();
        param.sanctnKndCode = 'CM05000004';
        param.sanctnInfoList = sanctnInfoList;
        
		// 결재 상신, 임시 저장, 데이터 수정 분기.
		if(isApproval) {
			
			if(crudVal == "C") {
				// 결재상신.
				var ajax = customAjax({
					'url': insApprovalPcnM,
					'data': param,
					'successFunc': function(res,status) {
						if(status === 'success') {
							success("결재상신 되었습니다.");			/* 결재상신 되었습니다. */
							saveKey = res.pcnSeqno;
							saveFormReset();
						}
					}
				});
			} else {
				// 결재상신.
				var ajax = customAjax({
					'url': updApprovalPcnM,
					'data': param,
					'successFunc': function(res,status) {
						if(status === 'success') {
							success("결재상신 되었습니다.");			/* 결재상신 되었습니다. */
							saveKey = res.pcnSeqno;
							saveFormReset();
						}
					}
				});
			}

		} else {
			
			if(pcnSeqno == null || pcnSeqno == ""){
				crudVal == "C";
			} else {
				crudVal == "U";
			}
	        
			// pcn 생성.
			if(crudVal == "C") {
				var ajax = customAjax({
					'url': insUrl,
					'data': param,
					'successFunc': function(res, ststus) {
						success("${msg.C100000762}");				/* 저장되었습니다. */
						saveKey = res.pcnSeqno;
						saveFormReset();
					}
				})
			// pcn 수정.
			}else if(crudVal == "U") {
				var ajax = customAjax({
					'url': updUrl,
					'data': param,
					'successFunc': function(res, ststus) {
						success("${msg.C100000762}");				/* 저장되었습니다. */
						saveKey = res.pcnSeqno;
						saveFormReset();
					}
				})
			}
		}
	}

	
    function progrsControll(sanctnProgrsSittnCode){

		if (sanctnProgrsSittnCode === 'CM01000001' || sanctnProgrsSittnCode === 'CM01000004' || sanctnProgrsSittnCode === 'init') {
			// 작성중, 반려, 초기화
			dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value);
			dropZoneArea.readOnly(false);
			sanctnLineControl.optionDisableClear();

		} else if (sanctnProgrsSittnCode === 'CM01000005') {
			//결재 완료
			dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value);
			dropZoneArea.readOnly(false);
			sanctnLineControl.notSelectedOptionDisable(true);

		} else {
			// 결재 대기, 대기예정
			dropZoneArea.getFiles(saveFormEl.querySelector('input[name=atchmnflSeqno]').value, null, 'N');
			dropZoneArea.readOnly(true);
			sanctnLineControl.notSelectedOptionDisable(true);
		}

		visibleSupport.displayOfCode(sanctnProgrsSittnCode);
    }
	
    function getExmntSeqno() {
        return saveFormEl.querySelector('[name=exmntSeqno]').value;
    }

    // dialog parameter function
    function getOtherKey() {
        return saveFormEl.querySelector('[name=pcnSeqno]').value;
    }

 	// 담당부서 변경시 담당자 정렬.
    function changeDept(e, eventChargerId) {
 		
    	var chargerId = document.getElementById("chargerId");
 		var chrgDeptCode = e
 		
 		ajaxJsonComboTrgetName({url : '/com/getDeptToUserLsit.lims', 
 					name : 'chargerId', 
 					queryParam : { "deptCode": chrgDeptCode }, 
 					selectFlag : true, 
 					successfunc : function(){
		 				// 동시성 문제 해결 
			 			for(var i=0; i<chargerId.length; i++){
			 				if(chargerId[i].value == eventChargerId){
			 					chargerId[i].selected = true;
			 				}
			 			}
		 			}
 		})
    }
    
    function sanctnValid() {
        return !!saveFormEl.querySelector('[name=sanctnerNm]').value
    }
 	
 	
</script>
	</tiles:putAttribute>

	<tiles:putAttribute name="body">

		<!--  body 시작 -->
		<div class="subContent">
			<div class="subCon1">
				<h2>
					<i class="fi-rr-apps"></i>${msg.C100000074}</h2>
				<!-- PCN 목록 -->
				<div class="btnWrap">
					<button type="button" id="printReport" class="print">${msg.C100001339}</button> <!-- 보고서 출력 -->
					<button type="button" id="btnSearch" class="search">${msg.C100000767}</button><!-- 조회 -->
				</div>

				<!-- Main content -->
				<form id="SearchFrm" onsubmit="return false;">
					<table cellpadding="0" cellspacing="0" width="100%"
						class="subTable1">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000073 }</th>
							<!-- PCN 명 -->
							<td><input type="text" id="pcnNm" name="pcnNm" class="schClass" maxlength="17"></td>

							<th>${msg.C100001338 }</th>
							<!-- 고객사명 -->
							<td><input type="text" id="ctmmnySeqnoNm" name="ctmmnySeqnoNm" class="schClass"></td>
							
							<th>${msg.C100001311 }</th>
							<!-- 품목 -->
							<td><input type="text" id="mtrilSeqnoNm" name="mtrilSeqnoNm" class="wd100p schClass"></td>
							
						</tr>
						<tr>
							<th>${msg.C100001331 }</th>
							<!-- 예정일자 -->
							<td>
								<input type="text" id="prearngeBeginDte" name="prearngeBeginDte" class="wd6p dateChk schClass" maxlength="10">~
								<input type="text" id="prearngeEndDte" name="prearngeEndDte" class="wd6p dateChk schClass" maxlength="10">
							</td>

							<th>${msg.C100001314 }</th>
							<!-- 완료일자 -->
							<td>
								<input type="text" id="comptBeginDte" name="comptBeginDte" class="wd6p dateChk schClass" maxlength="10">~
								<input type="text" id="comptEndDte" name="comptEndDte" class="wd6p dateChk schClass" maxlength="10">
							</td>
						</tr>

					</table>
				</form>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="pcnGrid" class="mgT15 grid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
			</div>
		    <div class="mapkey">
		        <label class="scarce">반려</label><!-- 반려 -->
		    </div>
			<form id="pcnForm" onsubmit="return false;">
				<div class="subCon1 mgT14" id="detail">
					<h2>
						<i class="fi-rr-apps"></i>${msg.C100000075}</h2>
					<!-- PCN 상세 정보 -->
					<div class="btnWrap">
						<!-- 신규 -->
						<button type="button" id="btnNew" class="btn4">${msg.C100000569}</button>
						<!-- 삭제 -->
						<button type="button" id="btnDelete" class="delete" data-visible-code=["CM01000001","CM01000005"]>${msg.C100000458}</button>
						<!-- 회수 -->
						<button type="button" id="btnRevert" class="save" data-visible-code=["CM01000002"]>회수</button>
						<!-- 저장 -->
						<button type="button" id="btnTempSave" class="save" data-visible-code=["init","CM01000001","CM01000004","CM01000005"]>저장</button>
						<!-- 검토-->
						<button type="button" id="btnExmnt" class="save" data-visible-code=["CM01000005"]>검토</button>
						<!-- 결재상신-->
						<button type="button" id="btnSave" class="save" data-visible-code=["init","CM01000001","CM01000004"]>결재상신</button>
						
						<!-- 검토 다이어로그 -->
						<input type="hidden" id="btnDialogExmnt" class="save" value="검토">
					</div>
					<table cellpadding="0" cellspacing="0" width="100%"
						class="subTable1" id="subTable1">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
						</colgroup>
						<tr>
							<th class="taCt vaMd necessary">${msg.C100000073}</th>
							<!-- PCN 명 -->
							<td><input type="text" id="pcnNm" name="pcnNm" class="wd100p" style="min-width: 10em;" maxlength="200" required></td>

							<th>${msg.C100001328}</th>
							<!-- PCN NO. -->
							<td><input type="text" id="pcnNo" name="pcnNo" class="wd100p" style="min-width: 10em;" maxlength="17" readonly></td>

							<th class="necessary">${msg.C100001327}</th>
							<!-- 변경점 적용 -->
							<td colspan="3">
								<label><input type="checkbox" name="changePointApplcCn" style="min-width: 2em;" value="미세변경점" required> 미세변경점</label> 
								<label><input type="checkbox" name="changePointApplcCn" style="min-width: 2em;" value="고객PCN" required> 고객 PCN</label> 
								<label><input type="checkbox" name="changePointApplcCn" style="min-width: 2em;" value="PSM변경점" required> PSM 변경점</label> 
								<label><input type="checkbox" name="changePointApplcCn" style="min-width: 2em;" value="내부" required> 내부</label>
							</td>
						</tr>

						<tr>
							<th class="necessary">${msg.C100000187 }</th>
							<td>
		                        <input type="text" id="ctmmnySeqnoNm" name="ctmmnySeqnoNm" class="wd63p" readonly required>
		                        <input type="text" id="ctmmnySeqno" name="ctmmnySeqno" style="display: none" required>
		                        <button type="button" id="ctmmnySch" class="inTableBtn inputBtn" data-visible-code=["init","CM01000001","CM01000004"]><img src="<c:url value="/assets/image/btnSearch.png"/>"></button>
		                        <button type="button" id="ctmmnyReset" class="inTableBtn inputBtn" data-visible-code=["init","CM01000001","CM01000004"]><img src="<c:url value="/assets/image/close14.png"/>"></button>
		                    </td>


							<th class="necessary">${msg.C100001329 }</th>
							<!-- 해당  제품 -->
							<td><select id="mtrilSeqno" name="mtrilSeqno" class="wd100p" style="width: 100%;" required></select></td>

							<th class="necessary">${msg.C100001333 }</th>
							<!-- 5M1E -->
							<td><select id="m5e1Code" name="m5e1Code" class="wd100p" style="min-width: 10em;" required></select></td>
							
							<th>${msg.C100001332 }</th>
							<!-- PCN grade -->
							<td colspan="1"><select id="pcnGradCode" name="pcnGradCode" class="wd100p" style="min-width: 10em;"></select></td>
							

						</tr>

						<tr>
							<th>${msg.C100001331 }</th>
							<!-- 예정일자 -->
							<td><input type="text" id="prearngeDte" name="prearngeDte" class="dateChk wd100p" maxlength="10"></td>

							<th>${msg.C100001313 }</th>
							<!-- 담당부서 -->
							<td><select id="chrgDeptCode" name="chrgDeptCode" class="wd100p" style="min-width: 10em;" onchange="changeDept(this.value)"></select></td>

							<th>${msg.C100000271 }</th><!-- 담당자 -->
							<td><select id="chargerId" name="chargerId" class="wd100p"style="min-width: 10em;"></select></td>
						</tr>
						<tr>
							<th>${msg.C100001334 }</th>
							<!-- PCN 내용 -->
							<td class="wd33p" colspan="7"><textarea rows="1" id="pcnCn" name="pcnCn" class="wd100p" maxlength="4000"></textarea></td>
						</tr>

						<tr>
							<th>${msg.C100001335 }</th>
							<!-- PCN 전 -->
							<td colspan="3"><textarea rows="1" id="pcnBfeCn" name="pcnBfeCn" class="wd100p" maxlength="4000"></textarea></td>

							<th>${msg.C100001336 }</th>
							<!-- PCN 후 -->
							<td colspan="3"><textarea rows="1" id="pcnAfterCn" name="pcnAfterCn" class="wd100p" maxlength="4000"></textarea></td>
						</tr>

						<tr>
							<th class="necessary">${msg.C100001337 }</th><!-- PCN 결과 -->
							<td><select id="pcnResultCode" name="pcnResultCode" class="wd100p" style="min-width: 10em;" required></select></td>


							<th class="necessary">${msg.C100000354 }</th><!-- 발행 일자 -->
							<td><input type="text" id="pblicteDte" name="pblicteDte" class="dateChk" maxlength="10" required></td>

							<th>${msg.C100001314 }</th><!-- 완료 일자 -->
							<td colspan="3"><input type="text" id="comptDte" name="comptDte" class="dateChk" maxlength="10"></td>
						</tr>

						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부 파일 -->
							<td colspan="8">
								<!-- 파일첨부영역 -->
								<div id="dropZoneArea"></div> 
								<input type="text" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width: 10em; display: none;" maxlength="10"> 
								<input type="hidden" id="btnSave_file">
							</td>
						</tr>
		                <tr>
		                    <th>결재정보</th>
		                    <td colspan="3">
		                        <select name="sanctnLineSeqno" style="width: 25%;"></select>
		                        <input type="text" id="sanctnerNm" name="sanctnerNm" style="width: 51%;" required readonly>
		                        <input type="text" id="sanctnSeqno" name="sanctnSeqno" style="display: none;">
		                        <button type="button" id="sanctnLineChg" name="sanctnLineChg" class="inTableBtn inputBtn" data-visible-code=["init","CM01000001","CM01000004"]>결재자변경</button>
		                        <button type="button" id="sanctnReset" class="inTableBtn inputBtn btn5" data-visible-code=["init","CM01000001","CM01000004"]><img src="<c:url value="/assets/image/close14.png"/>"></button>
		                        <input type="text" name="sanctnInfoList" style="display: none;">
		                    </td>
		                </tr>
					</table>

					<input type="hidden" id="crud" name="crud" value="C"> 
					<input type="hidden" id="deleteAt" name="deleteAt" value="N"> 
					<input type="text" id="pcnSeqno" name="pcnSeqno" style="display: none;"> 
					<input type="hidden" id="mtrilSeqnoNm" name="mtrilSeqnoNm">
					<input type="hidden" id="changePointSttusNm" name="changePointSttusNm">
					<input type="hidden" id="pcnGradNm" name="pcnGradNm">
					<input type="hidden" id="m5e1Nm" name="m5e1Nm">
					<input type="hidden" id="exmntSeqno" name="exmntSeqno">
					<input type="hidden" id="lastChangerId" name="lastChangerId" value="${UserMVo.userId }">
					<input type="text" id="wdtbSeqno" name="wdtbSeqno" style="display: none;">
					
				</div>
			</form>


			<div class="accordion_wrap mgT17">
				<div class="accordion ">${msg.C100000982}</div>
				<!-- PCN 이력 -->
				<div id="acc1" class="acco_top mgT15" style="display: none">
					<h3>${msg.C100000983}</h3>
					<!-- 품질 문서 이력 -->
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div class="subCon2">
						<div id="pcnDocHistGrid" class="mgT15" style="width: 100%; height: 300px; margin: 0 auto;"></div>
					</div>
				</div>
			</div>

		</div>


		<!--  body 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
