<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">품질 보증 결재</tiles:putAttribute>
	<tiles:putAttribute name="body">
	<!--  body 시작 -->
	<div class="subContent">
		<div class="subCon1">
			<h2><i class="fi-rr-apps"></i>${msg.C100000321}</h2> <!-- 문서 목록 -->
			<div class="btnWrap">
				<button type="button" id="btn_save" class="save">${msg.C100000533}</button> <!-- 승인 -->
				<button type="button" id="btn_rtn" class="save">${msg.C100000343}</button> <!-- 반려 -->
				<input type="hidden" id="btn_rtn_hidden" class="save"><!-- 반려 -->
				<input type="hidden" id="btn_fileView_hidden"><!-- 파일보기  -->
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
						<th>${msg.C100000316}</th> <!-- 문서 구분 -->
						<td><select id="docSeSeqnoSch" name="docSeSeqnoSch"  class="wd100p" style="min-width:10em;"></select></td>
						<th>${msg.C100000320}</th> <!-- 문서 구분 상세 -->
						<td><select id="docSeDetailSeqnoSch" name="docSeDetailSeqnoSch" ></select></td>
						<th>${msg.C100000802}</th> <!-- 제목 -->
						<td><input type="text" id="sjSch" name="sjSch"  class="wd100p schClass" style="min-width:10em;"></td>
						<th>${msg.C100000326}</th> <!-- 문서명 -->
						<td><input type="text" id="docNmSch" name="docNmSch"  class="wd100p schClass" style="min-width:10em;"></td>
						
					</tr>
					<tr>
						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td colspan="7">
							<input name="useAtSch" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
							<input name="useAtSch" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
					        <input name="useAtSch" value="N" type="radio">${msg.C100000449}
					    </td> <!-- 사용안함 -->
					</tr>
				</table>
			</form>
			<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		</div>
		<div class="subCon2">
			<div id="QaSanctnGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		</div>
	</div>

	<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script type="text/javascript"></script>
		<script>

			var searchFrm = 'searchFrm';

			var QaSanctnGrid= "QaSanctnGrid";
			var lang = ${msg}; // 기본언어

			$(function() {

				setGrid();

				setButtonEvent();
				
				setCombo();
				
				setEtcEvent();
				
				popUp();

				gridResize([QaSanctnGrid]);

			});

			function setGrid() {
				var col = [];
				
				var cusPros = {
						editable : false,
						selectionMode : "multipleCells",	
						showRowCheckColumn : true,
						showRowAllCheckBox : true
			 	};	
				
				auigridCol(col);
					
					col.addColumnCustom("fileView", "${msg.C100000327}", "8%", true); 		/* 문서 파일 보기 */
					col.addColumnCustom("docSeNm", "${msg.C100000316}", "*", true); 		/* 문서 구분 */
					col.addColumnCustom("docSeDetailNm", "${msg.C100000320}", "*", true); 	/* 문서 구분 상세 */
					col.addColumnCustom("sanctnProgrsSittnCodeNm", "${msg.C100000847}", "*", true);  	/* 진행상태 */
					col.addColumnCustom("docManageNo", "${msg.C100000315}", "*", true);  	/* 문서 관리번호 */
					col.addColumnCustom("docNm", "${msg.C100000326}", "*", true);			/* 문서명 */
					col.addColumnCustom("sj", "${msg.C100000802}", "*", true); 				/* 제목 */
					col.addColumnCustom("wrterNm", "${msg.C100000730}", "*", true); 		/* 작성자 */
					col.addColumnCustom("reformDte", "${msg.C100000801}", "*", true); 		/* 제 * 개정 일자 */
					col.addColumnCustom("reformNo", "${msg.C100000799}", "*", true); 		/* 제 * 개정 번호 */
					col.addColumnCustom("duspsnNm", "${msg.C100000938}", "*", true); 						/* 폐기자 */
					col.addColumnCustom("dsuseDte", "${msg.C100000933}", "*", true); 					/* 제 * 개정 일자 */
					col.addColumnCustom("useAt", "${msg.C100000443}", "*", true); 			/* 사용여부 */
					col.addColumnCustom("revnResn", "${msg.C100000800}", "*", true);		/* 제 * 개정 사유 */
					col.addColumnCustom("dsuseResn", "${msg.C100000931}", "*", true);					/* 폐기 사유 */
					
					col.addColumnCustom("docSeDetailSeqno", "문서구분 상세 일련번호", "*" ,false); 	/* 문서구분 상세 일련번호 */
					col.addColumnCustom("docSeqno", "${msg.C000001094}", "*" ,false); 		/* 문서 일련번호 */
					col.addColumnCustom("sanctnProgrsSittnCode", "진행상태", "*", false);  		/* 진행상태코드 */
					col.addColumnCustom("wrterId", "${msg.C000001097}", "*", false); 		/* 작성자 ID */
					col.addColumnCustom("duspsnId", "폐기자ID", "*", false); 					/* 폐기자 ID */
					col.addColumnCustom("atchmnflSeqno", "${msg.C000001099}", "*", false); 	/* 첨부파일 일련번호 */
					col.addColumnCustom("sanctnSeqno", "결재일련번호", "*", false);  			/* 결재일련번호 */
					col.buttonRenderer(["fileView"],
							function(){
								$("#btn_fileView_hidden").click();
							},false,"${msg.C100000327}")
							
					QaSanctnGrid = createAUIGrid(col, QaSanctnGrid,cusPros);
							
			}

			function setButtonEvent() {
				$("#docSeSeqnoSch").change(function(){
					ajaxJsonComboBox('/qa/getDocSeDetailCombo.lims','docSeDetailSeqnoSch',{docSeSeqno:$("#docSeSeqnoSch").val()}, false,"${msg.C100000480}"); /* 선택 */
				});
				
				$("#btn_select").click(function(){
					searchQaSacnctnList()
				})
				
				$("#btn_save").click(function(){
					saveQaSanctn();
				})
				$("#btn_rtn").click(function(){
					var gridDataChk = AUIGrid.getCheckedRowItemsAll(QaSanctnGrid);
					if(gridDataChk.length == 0){
				    	alert("${msg.C100000325}");
				    	return false;
			    	}
					else{
						$("#btn_rtn_hidden").click();
					}
				})
				
				
				$("#btn_fileView_hidden").click(function(){
					var gridData = AUIGrid.getCheckedRowItemsAll(QaSanctnGrid);
					docHistListEvent(gridData[0]);
				})
			}
			function popUp(){
				dialogRtnSanctn("btn_rtn_hidden", null,"rtnDialog","#QaSanctnGrid", function(data){
						
						var param = data;
						var selectedItems = AUIGrid.getCheckedRowItemsAll(QaSanctnGrid)
						var rtnList = [];
						for(var i=0; i<selectedItems.length;i++){
							rtnList.push(selectedItems[i]);
						}

						
						param.rtnList = rtnList;
						customAjax({
							"url" :	"<c:url value='/qa/insRtnSanctn.lims'/>",
							"data" : param,
							"successFunc" : function(data){
								if(data>0){
									success("${msg.C100000344}");/* 반려되었습니다. */
									searchQaSacnctnList();
								}
								else{
									err("${msg.C100000597}");
								}
							}
						})
				});
				dialogGridFileDownload("btn_fileView_hidden", "QafileDownload","#QaSanctnGrid");
					
			}
			
			
			function setCombo(){
				//콤보 박스 초기화
				ajaxJsonComboBox('/qa/getDocSeCombo.lims','docSeSeqnoSch',null, false,"${msg.C100000480}"); /* 선택 */
				ajaxJsonComboBox('/qa/getDocSeCombo.lims','docSeSeqno',null, false,"${msg.C100000480}"); /* 선택 */
				ajaxJsonComboBox('/qa/getDocSanctnLineCombo.lims','sanctnLineSeqno',{"deptCode" : "${UserMVo.deptCode}"}, false,"${msg.C100000480}"); /* 선택 */
				ajaxJsonComboBox('/com/getCmmnCode.lims', 'sanctnProgrsSittnCode', {'upperCmmnCode': 'CM01'}, true,null); /* 선택 */
			}
			
			/*** 조회 ****/
			function searchQaSacnctnList(){
				getGridDataForm("<c:url value='/qa/getQaSanctnList.lims'/>", "searchFrm", QaSanctnGrid, function() {
					getSanctnCnt();
				});
			}
			
			
			function saveQaSanctn(){
				var gridDataChk = AUIGrid.getCheckedRowItemsAll(QaSanctnGrid);
			    var gridData = new Array();
			    var saveUrl = "<c:url value='/qa/qaSanctnM.lims'/>";

			    for(var i in gridDataChk){
			    	gridData[i] = gridDataChk[i]
			    }

			    if(gridData.length == 0){
			    	alert("${msg.C100000497}");
			    	return false;
			    }

			    if(!confirm("${msg.C100000536}")){
			    	return false;
			    }
			    customAjax({"url":saveUrl,"data":gridData,"successFunc":function(data) {
		        	if (data > 0) {
	        			success("${msg.C100000534}"); /* 승인되었습니다. */
						searchQaSacnctnList();
		        	}
		        	else{
		        		err('${msg.C100000597}'); /* 오류 발생하였습니다. */
		        	}
				}
				
			})
			}
			//문서 이력 목록의 선택이나 그리드를 더블 크릭 했을대
			function docHistListEvent(event){
				var params = {
						atchmnflSeqno : $("#atchmnflSeqno").val()
				};
			}
			//기타이벤트
			function setEtcEvent(){
				$(".schClass").keypress(function (e) {
			        if (e.which == 13){
			        	searchQaSacnctnList();
			        }
				});
			}
			
			
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>