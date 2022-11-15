<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">문서 관리</tiles:putAttribute>
	<tiles:putAttribute name="body">
	<!--  body 시작 -->
	<div class="subContent">
		<div class="subCon1">
			<h2><i class="fi-rr-apps"></i>${msg.C100000182}</h2> <!-- 문서 목록 -->
			<div class="btnWrap">
				<button type="button" id="btn_select" class="search" onclick="searchDoc()">${msg.C100000767}</button> <!-- 조회 -->
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
						<td><input type="text" id="sjSch" name="sjSch"  class="wd100p" style="min-width:10em;"></td>
						<th>${msg.C100000326}</th> <!-- 문서명 -->
						<td><input type="text" id="docNmSch" name="docNmSch"  class="wd100p" style="min-width:10em;"></td>
					</tr>
					<tr>
						<th>${msg.C100000187}</th> <!-- 고객사 -->
						<td><select id="ctmmnySeqnoSch" name="ctmmnySeqnoSch"  class="wd100p" style="min-width:10em; width:100%" ></select></td>
						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td colspan="5">
							<input name="useAtSch" value="all" type="radio">${msg.C100000779} <!-- 전체 -->
							<input name="useAtSch" value="Y" type="radio" checked="checked">${msg.C100000439} <!-- 사용 -->
					        <input name="useAtSch" value="N" type="radio">${msg.C100000449}  <!-- 사용안함 -->
					    </td>
					</tr>
				</table>
			</form>
		</div>
		<div id="docMList" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
		<form id="DocForm">
			<input type="hidden" id="crud" name="crud" value="C">
			<input type="hidden" id="wdtbAt" name="wdtbAt" value="N">
			<input type="hidden" id="deleteAt" name="deleteAt" value="N">
			<!-- 문서정보 시작 -->
			<div class="subCon1 mgT15" id="detail">
				<h2><i class="fi-rr-apps"></i>${msg.C100000181}</h2> <!-- 문서 정보 -->
				<div class="btnWrap">
					<button type="button" id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button type="button" id="btn_delete" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
					<button type="button" id="btn_save"  class="save">${msg.C100000760}</button> <!-- 저장 -->
					<button type="button" id="btn_save_wdtb"  class="save">${msg.C100001162}</button> <!-- 저장 후 배포-->
					<input type="hidden" id="btnSave_file"> <!-- 저장 -->
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
						<th class="necessary">${msg.C100000316}</th> <!-- 문서 구분 -->
						<td>
							<select id="docSeSeqno" name="docSeSeqno"  class="wd100p" style="min-width:10em;" required></select>
						</td>
						<th class="necessary">${msg.C100000320}</th> <!-- 문서 구분 상세 -->
						<td>
							<select id="docSeDetailSeqno" name="docSeDetailSeqno"  class="wd100p" style="min-width:10em;" required></select>
						</td>
						<th class="necessary">${msg.C100000802}</th> <!-- 제목 -->
						<td>
							<input type="text" id="sj" name="sj" class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '1000')" required>
							<input type="hidden" id="docSeqno" name="docSeqno">
						</td>
						<th class="necessary">${msg.C100000326}</th> <!-- 문서명 -->
						<td>
							<input type="text" id="docNm" name="docNm"  class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '200')" required>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000315}</th> <!-- 문서 관리번호 -->
						<td>
							<input type="text" id="docManageNo" name="docManageNo" class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '30')" disabled>
						</td>

						<th>${msg.C100000730}</th> <!-- 작성자 -->
						<td>
							<input type="text" id="wrterNm" name="wrterNm" class="wd100p" style="min-width:10em;" disabled>
							<input type="text" id="wrterId" name="wrterId" style="display:none">
						</td>

						<th class="necessary">${msg.C100000728}</th> <!-- 작성일자 -->
						<td>
							<input type="text" id="writngDte" name="writngDte" class="wd100p dateChk" style="min-width:10em;" required>
						</td>
						<th class="necessary">${msg.C100000801}</th> <!-- 제 * 개정 일자 -->
						<td>
							<input type="text" id="reformDte" name="reformDte"  class="wd100p dateChk" style="min-width:10em;">
						</td>
					</tr>
					<tr>
						<th>${msg.C100000799}</th> <!-- 제 * 개정 번호 -->
						<td>
							<input type="text" id="reformNo" name="reformNo" value="0" class="wd100p" style="min-width:10em;" readonly>
						</td>
						<th id = "thCtmmnySeqno">${msg.C100000187}</th> <!-- 고객사 -->
						<td>
							<input type="text" id="ctmmnyNm" name="ctmmnyNm"  class="wd63p" style="min-width:10em;" readonly="readonly">
							<button type="button" id="ctmmnySearch" class="inTableBtn inputBtn btn5"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
							<button type="button" id="ctmmnyReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
							<input type="text" id="ctmmnySeqno" name="ctmmnySeqno" class="wd100p" style="display: none;">
						</td>
					</tr>
					<tr>
						<th id="thMtrilSeqno">${msg.C100000809}</th> <!-- 제품 명-->
						<td>
							<input type="text" id="mtrilSeqno" name="mtrilSeqno" style="display: none;">
							<input type="text" id="mtrilNm" name="mtrilNm"class="wd63p" style="min-width:10em;" readonly>
							<button type="button" id="mtrilSch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
							<button type="button" id="mtrilReset" class="inTableBtn inputBtn"><img src="/assets/image/close14.png"></button> <!-- 리셋 -->
						</td>
						<th id = "thcycleCode">${msg.C100000835}</th> <!-- 주기 -->
						<td style="text-align:left;">
							<input type="text" id="cycle" name="cycle" class="wd61p">
							<select id="cycleCode" name="cycleCode" style="min-width:0em; width:35%"></select>
						</td>
						<th id = "thwdtbUserNm">${msg.C100001043}</th>
						<td>
							<input type="text" id="wdtbUserNm" name="wdtbUserNm"  class="wd63p" style="min-width:10em;" readonly>
							<button type="button" id="wdtbUserNmSch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button>
							<button type="button" id = "wdtbReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 찾기 -->
						</td>
						
						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td style="text-align: left;">
							<label><input type="radio" id="useAt_Y" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
							<label><input type="radio" id="useAt_N" name="useAt" value="N" >${msg.C100000442}</label> <!-- 사용안함 -->
						</td>
						
					</tr>
					<div id="wdtbInfoList" class="mgT15" style="width:100%; height:150px; margin:0 auto; display:none" ></div>
					<input type="text" id="wdtbSeqno" name="wdtbSeqno" style="display:none;">
					<tr>
						<th id = "thRevnResn">${msg.C100000800}</th> <!-- 제 * 개정 사유 -->
						<td colspan="8" >
							<textarea id="revnResn" name="revnResn"  class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '4000')"></textarea>
						</td>
					</tr>
					<tr>
						<th>${msg.C100000324}</th> <!-- 문서 파일 -->
						<td colspan="8">
							<div id="dropZoneArea"></div>
							<input type="text" id="atchmnflSeqno" name="atchmnflSeqno" value="" style="display:none">
						</td>
					</tr>

					<tr id="dsUseTr" style="display:none">
						<th class="necessary">${msg.C100000938}</th> <!-- 폐기자 -->
						<td colspan="3">
							<input type="text" id="duspsnNm" name="duspsnNm" class="wd100p" style="min-width:10em;" disabled>
							<input type="text" id="duspsnId" name="duspsnId" style="display:none">
						</td>

						<th id = "thDsuseDte" class="necessary">${msg.C100000933}</th> <!-- 폐기일자 -->
						<td colspan="3">
							<input type="text" id="dsuseDte" name="dsuseDte" class="wd100p dateChk" style="min-width:10em;">
						</td>
					</tr>
					<tr id="dsUseTr2" style="display:none">
						<th id = "thDsuseResn">${msg.C100000931}</th> <!--폐기 사유 -->
						<td colspan="7">
							<textarea id="dsuseResn" name="dsuseResn"  class="wd100p" style="min-width:10em;" onkeyup="fnChkByte(this, '4000')"></textarea>
						</td>
					</tr>					
				</table>
						<input type="text" id="date" name="date" style="display:none">
						<input type="text" id="wdtbPrearngeDt" name="wdtbPrearngeDt"  class="wd70p" style="min-width:10em; display:none">

			</div>
			</form>
			<!-- 문서 정보 종료 -->
			<div class="subCon1 mgT15" id="detail2">
				<h3>${msg.C100000322}</h3> <!-- 문서 이력 -->
				<div class="btnWrap">
					<button type="button" id="btn_choice_sub" class="search">${msg.C100000327}</button>	<!-- 문서파일보기 -->
				</div>
			</div>
			<div class= "subCon2" >
				<div id="docHistList" class="mgT15" style="width:100%; height:150px; margin:0 auto;"></div>
			</div>

			<div class="accordion_wrap mgT17">	
				<div class="accordion ">${msg.C100001046}</div>  <!--  고객 송부자료 이력 -->
				<div id="acc1" class="acco_top mgT15" style="display: none">
					<h3>${msg.C100000983}</h3> <!-- 품질 문서 이력 -->
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div class="subCon2">
						<div id="cstmrRdataHistGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
					</div>
				</div>
			</div>
	</div>

	<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script type="text/javascript"></script>
		<script>
			var DocForm = 'docForm';
			var docMList = 'docMList';
			var docHistList = 'docHistList';
			var cstmrRdataHistGrid = 'cstmrRdataHistGrid';
			var dropZoneArea;
			var wdtbInfoList = 'wdtbInfoList';
			var lang = ${msg}; // 기본언어
			
			//현재시간
			var date = new Date();
		    var year = date.getFullYear();
		    var month = ("0" + (1 + date.getMonth())).slice(-2);
		    var day = ("0" + date.getDate()).slice(-2);
			$(document).ready(function(){
				getAuth();

				//콤보 박스 초기화
				setCombo();

				//문서 목록 그리드 세팅
				setDocMListGrid();

				//문서이력 그리드 세팅
				setDocHistGrid();

				setWdtbInfoListListGrid();
				
				// 품질 문서 이력 그리드 세팅
				setCstmrRdataHistGrid();

				//그리드 이벤트 선언
				setMhrlsOprGridEvent();

				// 버튼 이벤트
				setButtonEvent();

				//초기화
				init();

				gridResize(['docMList', 'docHistList',cstmrRdataHistGrid]);
				
				popup();
			});

			//콤보 박스 초기화
			function setCombo(){
				ajaxJsonComboBox('/qa/getDocSeCombo.lims','docSeSeqnoSch',{docSeNm : "고객송부자료"}, false,null,null,null,function(){
					ajaxJsonComboBox('/qa/getDocSeDetailCombo.lims','docSeDetailSeqnoSch',{docSeSeqno : $("#docSeSeqnoSch").val()}, false, "${msg.C100000480}"); /* 선택 */	
				});
				ajaxJsonComboBox('/qa/getDocSeCombo.lims','docSeSeqno',{docSeNm : "고객송부자료"},  false,null,null,null,function(){
					ajaxJsonComboBox('/qa/getDocSeDetailCombo.lims','docSeDetailSeqno',{docSeSeqno : $("#docSeSeqno").val()}, false, "${msg.C100000480}"); /* 선택 */	
				});
				ajaxSelect2Box({
			        ajaxUrl         : '/qa/getEntrpsNmCombo.lims'
			        ,elementId      : 'ctmmnySeqnoSch'
			    });
				ajaxJsonComboBox('/com/getCmmnCode.lims','cycleCode', {"upperCmmnCode" : "SY14"}, false,"${msg.C100000480}"); /* 선택 */
			}


			//문서 목록 그리드 세팅
			function setDocMListGrid(){
				var col = [];

				auigridCol(col);
				
				col.addColumnCustom("docSeNm", "${msg.C100000316}", "*", true); 		     	/* 문서 구분 */
				col.addColumnCustom("docSeDetailNm", "${msg.C100000320}", "*", true); 	      	/* 문서 구분 상세 */
				col.addColumnCustom("docManageNo", "${msg.C100000315}", "*", true);  	      	/* 문서 관리번호 */
				col.addColumnCustom("updVer", "${msg.C100000118}", "*", true);  		      	/* 개정 버튼 */
				col.addColumnCustom("dsUse", "${msg.C100000929}", "*", true);  						      	/* 폐기 버튼*/
				col.addColumnCustom("docNm", "${msg.C100000326}", "*", true);			      	/* 문서명 */
				col.addColumnCustom("sj", "${msg.C100000802}", "*", true); 				      	/* 제목 */
				col.addColumnCustom("wrterNm", "${msg.C100000730}", "*", true); 		      	/* 작성자 */
				col.addColumnCustom("reformDte", "${msg.C100000801}", "*", true); 		      	/* 제 * 개정 일자 */
				col.addColumnCustom("reformNo", "${msg.C100000799}", "*", true); 		      	/* 제 * 개정 번호 */
				col.addColumnCustom("duspsnNm", "${msg.C100000938}", "*", true); 				/* 폐기자 */
				col.addColumnCustom("duspsnDte", "${msg.C100000933}", "*", true); 				/* 폐기일자 */
				col.addColumnCustom("useAt", "${msg.C100000443}", "*", true); 			      	/* 사용여부 */
				col.addColumnCustom("revnResn", "${msg.C100000800}", "*", true);		      	/* 제 * 개정 사유 */
				col.addColumnCustom("dsuseResn", "${msg.C100000931}", "*", true);					   		/* 폐기 사유 */
				col.addColumnCustom("duspsnId", "폐기자ID", "*", false); 					   		/* 폐기자 ID */
				col.addColumnCustom("wrterId", "${msg.C000001097}", "*", false); 		      	/* 작성자 ID */
				col.addColumnCustom("atchmnflSeqno", "${msg.C000001099}", "*", false); 	      	/* 첨부파일 일련번호 */
				col.addColumnCustom("docSeqno", "문서 일련번호", "*" ,false); 		     			/* 문서 일련번호 */
				col.addColumnCustom("docSeDetailSeqno", "문서구분 상세 일련번호", "*" ,false);			/* 문서구분 상세 일련번호 */
				col.buttonRenderer(["updVer"],
				function reformEvent(){
					var gridData = AUIGrid.getSelectedItems(docMList);

					if (gridData.length > 0){
						alert("${msg.C100000287}"); /* 데이터 수정 후 저장버튼을 눌러야 개정이 완료됩니다. */
					}else{
						return;
					}
					docMListEvent(gridData[0], function(){
						$("#crud").val("R");
						//작성 일자, 제 * 개정 일자, 제 * 개정 번호 비활성화
						$("#dsUseTr").css("display","none");
						$("#dsUseTr2").css("display","none");
						$("#dsuseDte").prop("required",false);
						$("#dsuseResn").prop("required",false);
						$("#thDsuseResn").removeClass("necessary");
						$("#revnResn").prop("required",true);
						$("#thRevnResn").addClass("necessary");
						disabledEvent();

						var reformNo = Number($("#reformNo").val());
						reformNo = reformNo + 1;
						//제 개정 번호 컬럼은 4자리
						if(reformNo > 9999){
							reformNo = reformNo - 1;
						}
						else{
							$("#reformNo").val(reformNo);
						}
						AUIGrid.clearGridData(wdtbInfoList);
						$("#wdtbSeqno").val("");
						$("#wdtbUserNm").val("");
						
						//드랍존 새로고침
						
						dropZoneArea.clear();
						$("#atchmnflSeqno").val("");
					});},false,"${msg.C100000118}",null,
					function (rowIndex, columnIndex, value, item, dataField){
						if(item.duspsnId != null && item.duspsnId !="" ){
							return true;
						}
				       	else{
				    	   return false;   
				       	}
					});
				
				//폐기버튼
				
				col.buttonRenderer(["dsUse"],
						function dsUseEvent(){
					var gridData = AUIGrid.getSelectedItems(docMList);
					docMListEvent(gridData[0], function(){
						$("#crud").val("N");
						disabledEvent();
						dropZoneArea.getFiles(gridData[0].item.atchmnflSeqno);
// 						dropZoneArea.getFiles(event["item"]["atchmnflSeqno"]);
						console.log(gridData[0].item.atchmnflSeqno);
						$("#dsUseTr").css("display","revert");
						$("#dsUseTr2").css("display","revert");
						$("#duspsnNm").prop("disabled",true);
						$("#dsuseDte").prop("disabled",true);
						$("#duspsnNm").val("${UserMVo.userNm}");
						$("#duspsnId").val("${UserMVo.userId}");
						$("#revnResn").prop("required",false);
						$("#thRevnResn").removeClass("necessary");
						//폐기관련 필수
						$("#dsuseResn").prop("required",true);
						$("#thDsuseResn").addClass("necessary");
						$("#dsuseDte").prop("required",true);
						$("#thDsuseDte").addClass("necessary");
						
						datePickerCalendar(["dsuseDte"], true, ["DD",0]);
					})
				},false,"${msg.C100000929}",null,
				function (rowIndex, columnIndex, value, item, dataField){
					if(item.duspsnId != null && item.duspsnId !="" ){
						return true;
					}
			       	else{
			    	   return false;   
			       	}
				});

				var useAt = [
					{value : "Y", key : "${msg.C100000439}"},  /* 사용 */
					{value : "N", key : "${msg.C100000331}"}   /* 미사용 */
				];
				col.dropDownListRenderer(["useAt"], useAt, true, null);

				var cusPros = {
						editable : false, // 편집 가능 여부 (기본값 : false)
			 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			 			enableCellMerge : true
			 	}


				//auiGrid 생성
				docMList = createAUIGrid(col, "docMList", cusPros);

				// 그리드 칼럼 리사이즈
				AUIGrid.bind(docMList, "ready", function(event) {
// 					gridColResize([docMList],"2");	// 1, 2가 있으니 화면에 맞게 적용
				});
			}

			//배포 그리드 hidden
			function setWdtbInfoListListGrid(){
				
				var col2 = [];
				auigridCol(col2);
				col2.addColumn("wdtbSeqno", "배포일련번호", null, true); /*결재라인일련번호*/
				col2.addColumn("userId", "유저 Id", null, true); /*부서명*/
				col2.addColumn("userNm", lang.C000000100, null, true); /*사용자명*/
				col2.addColumn("emailTrnsmisAt", "이메일 발송 여부", null, true); /*이메일 발송 여부*/
				col2.addColumn("chrctrTrnsmisAt", "문자 발송 여부", null, true); /*문자 발송 여부*/

				//auiGrid 생성
				wdtbInfoList = createAUIGrid(col2, "wdtbInfoList");

				// 그리드 칼럼 리사이즈
				AUIGrid.bind(wdtbInfoList, "ready", function(event) {
// 					gridColResize([wdtbInfoList],"2");	// 1, 2가 있으니 화면에 맞게 적용
				});
				
			}
			//문서이력 그리드 세팅
			function setDocHistGrid(){
				var col2 = [];

				auigridCol(col2);

				col2.addColumnCustom("docSeNm", "${msg.C100000316}", "*", true);       /* 문서 구분 */
				col2.addColumnCustom("docSeDetailNm", "${msg.C100000320}", "*", true); /* 문서 구분 상세 */
				col2.addColumnCustom("reformNo", "${msg.C100000799}", "*", true);      /* 제 * 개정 번호 */
				col2.addColumnCustom("sj", "${msg.C100000802}", "*", true);            /* 제목 */
				col2.addColumnCustom("docNm", "${msg.C100000326}", "*", true);         /* 문서명 */
				col2.addColumnCustom("docManageNo", "${msg.C100000315}", "*", true);   /* 문서 관리번호 */
				col2.addColumnCustom("wrterNm", "${msg.C100000730}", "*", true);       /* 작성자 */
				col2.addColumnCustom("writngDte", "${msg.C100000728}", "*", true);     /* 작성일자 */
				col2.addColumnCustom("reformDte", "${msg.C100000801}", "*", true);     /* 제 * 개정 일자 */
				col2.addColumnCustom("revnResn", "${msg.C100000800}", "*", true);      /* 제 * 개정 사유 */
				
				col2.addColumnCustom("wrterId", "${msg.C000001097}", "*", false);      /* 작성자 ID */
				col2.addColumnCustom("docSeqno", "${msg.C000001094}", "*" ,false);     /* 문서 일련번호  */
				col2.addColumnCustom("docSeSeqno", "${msg.C000001095}", "*", false);   /* 문서 구분 코드 */
				col2.addColumnCustom("atchmnflSeqno", "${msg.C000001099}", "*", false);/* 첨부파일 일련번호 */


				var cusPros = {
						editable : false, // 편집 가능 여부 (기본값 : false)
			 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			 			enableCellMerge : true,
			    		//엑스트라체크박스 표시
			 	};
				
				//auiGrid 생성
				docHistList = createAUIGrid(col2, "docHistList", cusPros);

				// 그리드 칼럼 리사이즈
				AUIGrid.bind(docHistList, "ready", function(event) {
					gridColResize([docHistList],"2");	// 1, 2가 있으니 화면에 맞게 적용
				});
			}

			// 품질 문서 이력 그리드 세팅
			function setCstmrRdataHistGrid() {

				var col2 = [];

				var cusPros = {
					editable : false,
					selectionMode : "multipleCells",
					enableCellMerge : true
			 	};

				auigridCol(col2);
				col2.addColumnCustom('qlityDocHistSeqno','이력 일렬번호','*',false,false)  // 품질문서이력 일렬번호
				.addColumnCustom('tableNm',"${msg.C100000973}",'*',true,false)                // 테이블명
				.addColumnCustom('tableCmNm',"${msg.C100000974}",'*',true,false)              // 테이블 주석명
				.addColumnCustom('columnNm',"${msg.C100000975}",'*',true,false)               // 컬럼명
				.addColumnCustom('columnCmNm',"${msg.C100000976}",'*',true,false)             // 컬럼 주석명
				.addColumnCustom('seqno','일련번호','*',false,false)                       // 일련번호
				.addColumnCustom('changeBfeCn',"${msg.C100000382}",'*',true,false)            // 변경 전
				.addColumnCustom('changeAfterCn',"${msg.C100000384}",'*',true,false)          // 변경 후
				.addColumnCustom('changerNm',"${msg.C100000977}",'*',true,false)              // 최종 변경자
				.addColumnCustom('lastChangeDt',"${msg.C100000978}",'*',true,false);          // 최종 변경 일시          // 최종 변경 일시

				cstmrRdataHistGrid = createAUIGrid(col2, "cstmrRdataHistGrid", cusPros);

				AUIGrid.bind(cstmrRdataHistGrid, "ready", function(event) {
// 					gridColResize([cstmrRdataHistGrid], "2");
				});

			}

			//그리드 이벤트 선언
			function setMhrlsOprGridEvent(){
				//문서목록 그리드 더블클릭
				AUIGrid.bind(docMList, "cellDoubleClick", function(event) {
					if(event.item.duspsnId != null && event.item.duspsnId != ""){
						$("#dsUseTr").css("display","revert");
						$("#dsUseTr2").css("display","revert");
						$("#thDsuseResn").addClass("necessary")
						$("#thDsuseDte").addClass("necessary")
						$("#dsuseResn").prop("required",true);
						$("#dsuseDte").prop("required",true);
						$("#btn_save").css("display","none");
						$("#btn_save_wdtb").css("display","none");
					}
					else{
						$("#dsUseTr").css("display","none");
						$("#dsUseTr2").css("display","none");
						$("#dsuseResn").prop("required",false);
						$("#dsuseDte").prop("required",false);
						$("#btn_save").css("display","inline-block");
						$("#btn_save_wdtb").css("display","inline-block");
												
					}
					docMListEvent(event);
					
					dropZoneArea.getFiles(event["item"]["atchmnflSeqno"]);
				});
			}

			//버튼 이벤트
			function setButtonEvent(){
				
				
				$("#docSeDetailSeqno").change(function(){
					var schUrl = "<c:url value='/qa/getWarnAt.lims'/>"
					customAjax({
						"url" : schUrl,
						"data" : {docSeDetailSeqno : $("#docSeDetailSeqno").val()},
						"successFunc" : function(data){
							//워닝여부가 y
							if(data[0].wdtbEstbsAt=='Y'){
								$("#thcycleCode").addClass("necessary");
								$("#thwdtbUserNm").addClass("necessary");
								$("#wdtbUserNm").prop("required",true);
								$("#cycleCode").prop("required",true);
								$("#cycle").prop("required",true);
							} else {
								$("#thcycleCode").removeClass("necessary");
								$("#thwdtbUserNm").removeClass("necessary");
								$("#wdtbUserNm").prop("required",false);
								$("#cycleCode").prop("required",false);
								$("#cycle").prop("required",false);
							}
							if(data[0].entrpsChoiseEssntlAt=='Y'){
								$("#thCtmmnySeqno").addClass("necessary");
								$("#ctmmnySeqno").prop("required",true);
							} else{
								$("#thCtmmnySeqno").removeClass("necessary");
								$("#ctmmnySeqno").prop("required",false);
							}
							if(data[0].mtrilChoiseEssntlAt=='Y'){
								$("#thMtrilSeqno").addClass("necessary");
								$("#mtrilSeqno").prop("required",true);
							} else{
								$("#thMtrilSeqno").removeClass("necessary");
								$("#mtrilSeqno").prop("required",false);
							}
						}
					})
				});

				//주기 변경시 예정일자 수정
				$("#cycleCode").change(function(){
						var crrDte = $("#date").val()
						var crrCycle = Number($("#cycle").val());
						var crrCycleCode = $("#cycleCode").val();
						var colId = "wdtbPrearngeDt";
						nextCrrctDteEvent(crrDte,crrCycle,crrCycleCode,colId);
				})
				

				//문서 이력 선택 버튼
				$("#btn_choice_sub").click(function(){
					var gridData = AUIGrid.getSelectedItems(docHistList);
					docMListEvent(gridData[0]);
				});

				//저장
				$("#btn_save_wdtb").on("click", function(){
					$("#wdtbAt").val("Y");
					var dataLen = AUIGrid.getGridData(wdtbInfoList).length;;
					if(dataLen<1){
						warn("${msg.C100001161}")
						return false;
					}
					else{
						saveDoc();	
					}
				});
				
				//저장
				$("#btn_save").on("click", function(){
					$("#wdtbAt").val("N");
					saveDoc();
				});

				//신규 버튼
				$("#btn_new").click(function(){
					docReset();
				});

				//삭제 버튼
				$("#btn_delete").click(function(){
					var gridData = AUIGrid.getSelectedItems(docMList);

					if(gridData.length == 0) {
						alert("${msg.C100000491}");  /* 선택된 문서 목록이 없습니다. */
						return;
					}

					if(confirm("${msg.C100000461}")) {  /* 삭제하시겠습니까? */
						$("#crud").val("D");
						dataSave();
					}
				});


				$("#shrSj, #shrDocNm").keyup(function(e){
					searchDoc(e.keyCode);
				});
				
				$("#ctmmnyReset").click(function(){
					dialogReset(this.id);
				})
				
				$("#mtrilReset").click(function(){
					dialogReset(this.id);
				})

				// 배포팝업 input reset 버튼
				$("#wdtbReset").click(function(){
					dialogReset(this.id);
					clearGridData(wdtbInfoList);
				})
				// 아코디언 click event
				var acc = document.getElementsByClassName("accordion");
				var i;

				for (i = 0; i < acc.length; i++) {
					acc[i].addEventListener("click", function() {
						this.classList.toggle("active");
						var panel = this.nextElementSibling;

						if (panel.style.display === "block") {
							panel.style.display = "none";
						}else {
							panel.style.display = "block";
							AUIGrid.resize(docMList);
							AUIGrid.resize(docHistList);
							AUIGrid.resize(cstmrRdataHistGrid);

							var seqno = $("#docSeqno").val() != '' ? $("#docSeqno").val() : null;
							getCstmrRdataHist(seqno);
						}

						if (panel.style.maxHeight) {
							panel.style.maxHeight = null;
						}else {
							panel.style.maxHeight = null;
						}
					});
				}

			}

			//초기화
			function init(){
				//달력 세팅
				datePickerCalendar(["writngDte"], true, ["DD",0]);
				datePickerCalendar(["reformDte"], false, ["DD",0], ["DD",0]);
				dialogGridFileDownload("btn_choice_sub", "fileDownload","#docHistList");
				//문서파일 세팅
				dropZoneArea = DDFC.bind().EventHandler("dropZoneArea", { btnId : "btnSave_file", maxFiles : 20, lang : "${msg.C100000867}"} ); /* 첨부할 파일을 이 곳에 드래그하세요. */
			    $("#date").val(year + "-" + month + "-" + day);
			  //고객사 팝업
				dialogEntrps("ctmmnySearch", "SY08000002", "entrpsDialog", function(data){
					$("#ctmmnyNm").val(data["entrpsNm"]);
					$("#ctmmnySeqno").val(data["entrpsSeqno"]);
				}, null);
			  
				var mtrilData = {
						bestInspctInsttCode : '${UserMVo.bestInspctInsttCode}',
						authorSeCode : '${UserMVo.authorSeCode}'
				};

				dialogMtril("mtrilSch", mtrilData, "cstmrRMtril", function(item){
					$("#mtrilSeqno").val(item.mtrilSeqno);
					$("#mtrilNm").val(item.mtrilNm);
				},null,null,null,'Y');
			  
			}

			//저장 이벤트
			function saveDoc(){
				//필수 값 체크
				if(!saveValidation ("DocForm")){
					return false;
				}else{
						var dropZone = dropZoneArea.getNewFiles();
						var dropZone_cnt = dropZone.length;

						if (dropZone_cnt > 0){
							$("#btnSave_file").click();
							dropZoneArea.on("uploadComplete", function(event, fileIdx){
								$("#atchmnflSeqno").val(fileIdx);
								dataSave();
							});
						}else{
							dataSave();
						}
				}
			}

			//저장
			function dataSave(){

				var docFormInput = $("#DocForm input");
				var saveUrl = "<c:url value='/qa/insCstmrRData.lims'/>"
				$("#duspsnNm").prop("disabled",false);
				$("#dsuseDte").prop("disabled",false);
				$("#docSeDetailSeqno").prop("disabled", false);
				$("#docSeSeqno").prop("disabled", false);
				$("#docManageNo").prop("disabled", false);
				
				
				for(var i=0; i<docFormInput.length; i++){
					if(docFormInput[i].id != "wrterNm"){
						docFormInput[i].disabled = false;
					}

				}
				var param = Object.assign($("#DocForm").serializeObject());
				param.wdtbInfoList2 = AUIGrid.getGridData(wdtbInfoList);
				
				customAjax({"url":saveUrl,"data":param,"successFunc":function(data) {
		        	if (data > 0) {
		        		if($("#crud").val() == "D") {
		        			success('${msg.C100000462}');  /* 삭제되었습니다. */
		        		}else {
		        			success("${msg.C100000762}");  /* 저장 되었습니다. */	
		        		}
		        		searchDoc();
						AUIGrid.clearGridData(cstmrRdataHistGrid);
		        		docReset();
			            
		        	}else{
		        		err('${msg.C100000597}'); /* 에러가 발생하였습니다. */
					}
				}
				});
			}

			//히스토리 삭제
			function removehis() {
			    AUIGrid.removeRow(docHistList, "selectedIndex");
			}
			function dataDel() {
				var url = "<c:url value='/qa/delCstmrRData.lims'/>";
				var del = AUIGrid.getCheckedRowItemsAll(docHistList);

			    ajaxJsonParam(url, del, function(data) {
			        if (data > 0) {
			        	searchDoc();
						AUIGrid.clearGridData(cstmrRdataHistGrid);
			        	docReset();
			        	success("${msg.C100000462}");  /* 삭제되었습니다. */
			       }
			   });

			}


			//문서 목록 조회
			function searchDoc(keyCode){
				if(keyCode != undefined && keyCode == 13)
					searchDoc();
				else {
					if(keyCode == undefined) {
						//재 * 개정번호, 문서 관리 번호, 문서명 활성화
						disabledEvent();
						//문서 목록 조회
						getGridDataForm("<c:url value='/qa/getCstmrRDataList.lims'/>", "searchFrm", docMList);
					}
				}
			}
			
			// 품질 문서 이력 조회
			function getCstmrRdataHist(seqno) {
				var param = {
					"tableNm" : "RS_CTMMNY_DTA_R"
				};

				if(!!seqno) {
					param.seqno = seqno;
					getGridDataParam('/com//getQlityDocHistList.lims', param, cstmrRdataHistGrid);
				}else {
					return;
				}
			}

			//배포처 조회
			function getWdtbList(wdtbSeqno){
				var paramStr = ""
				
				getGridDataParam("<c:url value='/qa/getWdtbList.lims'/>",{wdtbSeqno : wdtbSeqno}, wdtbInfoList).then(function(data){
					var dataLen = data.length;
					if(dataLen==1){
						$("#wdtbUserNm").val(data[0].userNm);
					}
					else if(dataLen==0){
						$("#wdtbUserNm").val("");
					}
					else{
						var text = data[0].userNm+" ${msg.C100000999}"+String(dataLen-1)+"${msg.C100000120}";
						$("#wdtbUserNm").val(text);
					}
				})
			}
			
			
			function docMListEvent(event, func){
			
				$("#docManageNo").val(event.item.docManageNo);
				$("#btn_delete").css("display","inline-block"); //이력페이지에서 버튼이 안보일경우
				var histParams = {docManageNo : $("#docManageNo").val()};
				ajaxJsonComboBox('/qa/getDocSeDetailCombo.lims','docSeDetailSeqno',{docSeSeqno:event.item.docSeSeqno}, false,"${msg.C100000480}")
				.then(function(){
							detailAutoSet({
								"item": event["item"],
								"targetFormArr": ["DocForm"],
								"successFunc" : function(){
									
									if(event.item.wdtbEstbsAt=='Y'){
										$("#thcycleCode").addClass("necessary");
										$("#thwdtbUserNm").addClass("necessary");
										$("#wdtbUserNm").prop("required",true);
										$("#cycleCode").prop("required",true);
										$("#cycle").prop("required",true);
									} else {
										$("#thcycleCode").removeClass("necessary");
										$("#thwdtbUserNm").removeClass("necessary");
										$("#wdtbUserNm").prop("required",false);
										$("#cycleCode").prop("required",false);
										$("#cycle").prop("required",false);
									}
									if(event.item.entrpsChoiseEssntlAt=='Y'){
										$("#thCtmmnySeqno").addClass("necessary");
										$("#ctmmnySeqno").prop("required",true);
									} else{
										$("#thCtmmnySeqno").removeClass("necessary");
										$("#ctmmnySeqno").prop("required",false);
									}
									if(event.item.mtrilChoiseEssntlAt=='Y'){
										$("#thMtrilSeqno").addClass("necessary");
										$("#mtrilSeqno").prop("required",true);
									} else{
										$("#thMtrilSeqno").removeClass("necessary");
										$("#mtrilSeqno").prop("required",false);
									}
									//첨부파일
	// 								dropZoneArea.getFiles(event["item"]["atchmnflSeqno"]);
									$("#crud").val("U");
									//문서 이력
									getGridDataParam("<c:url value='/qa/getCstmrRDataHistList.lims'/>", histParams, docHistList);
	
									if(func != null && typeof func == "function"){
										func();
									}
									
									if($("#crud").val()=="U"){
										getWdtbList(event.item.wdtbSeqno);	
									}
									disabledEvent();		
									getCstmrRdataHist(event.item.docSeqno);
									
									
									var crrDte = $("#date").val()
									var crrCycle = Number($("#cycle").val());
									var crrCycleCode = $("#cycleCode").val();
									var colId = "wdtbPrearngeDt";
									nextCrrctDteEvent(crrDte,crrCycle,crrCycleCode,colId);
							}
						});
					});
			}
			function popup(){
				
				dialogWdtb("wdtbUserNmSch", {dept : '${UserMVo.deptCode}'},"N",null,"#docMList","wdtbDialog",function(data){
					var paramStr = "";
					var userNm = data.gridData[0].userNm;
					var gridLen = data.gridData.length
					//결재라인
					AUIGrid.clearGridData(wdtbInfoList);
					//결재라인
					for(var i=0; i<gridLen; i++){
						AUIGrid.addRow(wdtbInfoList, data.gridData[i]);
					}
					if(data.gridData.length==1){
						$("#wdtbUserNm").val(userNm);
					}
					else{
						var text = userNm+" ${msg.C100000800}"+String(gridLen-1)+" ${msg.C100000120}";
						$("#wdtbUserNm").val(text);
					}
				});
			}
			

			//개정 버튼 눌렀을때 이벤트
			//crud 에 따라서 disabled 유무
			function disabledEvent(){
				if($("#crud").val() == "C"){
					$("#reformNo").prop("disabled", false);
					$("#docNm").prop("disabled", false);
					$("#docSeDetailSeqno").prop("disabled", false);
					$("#docSeSeqno").prop("disabled", false);
				}
				else if($("#crud").val() == "U"){

					var reformNo = $("#reformNo").val()

					if(reformNo > 0) {
						$("#docNm").prop("disabled", true);
						$("#docManageNo").prop("disabled", true);
						$("#docSeDetailSeqno").prop("disabled", true);
						$("#docSeSeqno").prop("disabled", true);
					}
					else{
						$("#reformNo").prop("disabled", false);
						$("#docNm").prop("disabled", false);
						$("#docSeDetailSeqno").prop("disabled", false);
						$("#docSeSeqno").prop("disabled", false);
					}
				}
				else if($("#crud").val() == "R"){
					$("#reformNo").prop("disabled", true);
					$("#docNm").prop("disabled", true);
					$("#docManageNo").prop("disabled", true);
					$("#docSeDetailSeqno").prop("disabled", true);
					$("#docSeSeqno").prop("disabled", true);
				}
				else{
					$("#reformNo").prop("disabled", false);
					$("#docNm").prop("disabled", false);
					$("#docManageNo").prop("disabled", false);
					$("#docSeDetailSeqno").prop("disabled", false);
					$("#docSeSeqno").prop("disabled", false);
				}

			}

			//reset
			function docReset(){
				//form 리셋
				$("#DocForm")[0].reset();
				$("#btn_save").css("display","inline-block");
				$("#btn_save_wdtb").css("display","inline-block");
				$("#revnResn").prop("required",false);
				$("#thRevnResn").removeClass("necessary");
				//폐기 필수체크해제
				$("#dsUseTr").css("display","none");
				$("#dsUseTr2").css("display","none");
				$("#dsuseResn").prop("required",false);
				$("#thDsuseResn").removeClass("necessary");
				$("#dsuseDte").prop("required",false);
				$("#thDsuseDte").removeClass("necessary");
				$("#wdtbUserNm").prop("required",false);
				$("#thwdtbUserNm").removeClass("necessary");

				//히든값 초기화
				$("#crud").val("C");
				$("#deleteAt").val("N");
				$("#docSeqno").val("");
				$("#wrterId").val("");
				$("#atchmnflSeqno").val("");
				$("#sanctnSeqno").val("");
				$("#docManageNo").prop("disabled",true);
				$("#dsuseDte").prop("disabled",true);
				$("#duspsnNm").prop("disabled",true);
				$("#thcycleCode").removeClass("necessary");
				$("#cycleCode").prop("required",false);
				$("#cycle").prop("required",false);
				$("#thCtmmnySeqno").removeClass("necessary");
				$("#ctmmnySeqno").prop("required",false);
				$("#thMtrilSeqno").removeClass("necessary");
				$("#mtrilSeqno").prop("required",false);
				datePickerCalendar(["writngDte"], true, ["DD",0]);
				datePickerCalendar(["reformDte"], false, ["DD",0], ["DD",0]);
			    $("#date").val(year + "-" + month + "-" + day);
				//재 * 개정번호, 문서 관리 번호, 문서명 활성화
				disabledEvent();
				//이력 그리드 초기화
				AUIGrid.clearGridData(docHistList);
				
				//파일 리셋
				dropZoneArea.clear();
				dropZoneArea.setFileIdx("");
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>