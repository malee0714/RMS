<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		<div id="tabMenuLst" class="tabMenuLst skin-peter-river mgT20 mgL20 wd97p">
			<ul id="tabs">
				<li id="tab1" class="tabMenu on">${msg.C100000815}</li> <!--  제품별 이력조회 -->
				<li id="tab2" class="tabMenu">${msg.C100000248}</li> <!--  날짜별 이력 조회 -->
				<li id="tab3" class="tabMenu">바코드 이력 조회</li> <!--  날짜별 이력 조회 -->
			</ul>
		</div>
		<div id="tabCtsLst" class="subContent" style="padding-top: 0px">
            <div id="tabCts1" class="tabCts">
                <div class="subCon1 ">
                    <h2><i class="fi-rr-apps"></i>${msg.C100000810}</h2><!-- 제품 목록-->
                    <div class="btnWrap">
                        <button id="tab1btnSearch" class="search">${msg.C100000767}</button><!-- 조회 -->
                    </div>

                    <form id="rgntHistFrm" name="rgntHistFrm" onsubmit="return false">
                        <table class="subTable1">
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
                            <th>분석실</th><!-- 사업 장 -->
                            <td>
                                <select name="custlabSeqno" >
                                    <option value=''>${msg.C100000480}</option> <!-- 선택 -->
                                </select>
                            </td>
                            <th>${msg.C100000811}</th><!-- 분류 -->
                            <td>
                                <select id="prductClCodeSch" name="prductClCodeSch">
                                    <option value=''>${msg.C100000480}</option><!-- 선택 -->
                                </select>
                            </td>
                            <th>${msg.C100000809}</th><!-- 제품 명 -->
                            <td>
                                <input type="text" id="prductNmSch" name="prductNmSch" class="schClass"></td>
                            <th>${msg.C100000443}</th> <!-- 사용여부 -->
                            <td style="text-align:left;">
                                <label><input type="radio" id="use_a" name="useAtSch" value="" >${msg.C100000779}</label> <!-- 전체 -->
                                <label><input type="radio" id="use_b" name="useAtSch" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
                                <label><input type="radio" id="use_c" name="useAtSch" value="N" >${msg.C100000449}</label> <!-- 사용안함 -->
                            </td>
                            </tr>

                        </table>
                    </form>
                </div>
                <div class="mgT15">
                    <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                    <div
                        id="rgntHistMGrid_Master"
                        style="width: 100%; height: 200px; margin: 0 auto;"></div>
                </div>
                <div class="subCon1">
                    <h2 class="mgT20 mgL0"><i class="fi-rr-apps"></i>${msg.C100000702}</h2><!--입출고 이력-->

                    <form id="searchFrm" name="searchFrm">
                        <table cellpadding="0" cellspacing="0" width="50%" class="subTable1">
                            <colgroup>
                                <col style="width: 10%"></col>
                                <col style="width: 15%"></col>
                                <col style="width: 10%"></col>
                                <col style="width: 15%"></col>
                                <col style="width: 10%"></col>
                                <col style="width: 15%"></col>
                                <col style="width: 25%"></col>
                                
                                
                            </colgroup>
                            <tr>
                            	<th>${msg.C100000699}</th><!-- 입출고 구분 -->
                                <td>
                                    <select id="wrhsdlvrSeCodeSch" name="wrhsdlvrSeCodeSch">
                                        <option value=''>${msg.C100000480}</option><!-- 선택 -->
                                    </select>
                                </td>
	                            <th class="necessary">${msg.C100000292}</th><!-- 등록 일자 -->
	                            <td style="text-align: left;">
	                                <input type="text"id="useBeginDte"name="useBeginDte"class="dateChk wd6p" style="min-width: 6em;" required>
	                                ~  
	                                <input type="text"id="useEndDte"name="useEndDte"class="dateChk wd6p" style="min-width: 6em;" required>
	                            </td>
	                            <th>${msg.C100000465}</th> <!--삭제 여부  -->
	                            <td>
	                            	<label><input type="radio" id="delete_a" name="deleteAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
									<label><input type="radio" id="delete_y" name="deleteAtSch" value="Y" >Y</label> <!-- 사용 -->
									<label><input type="radio" id="delete_n" name="deleteAtSch" value="N" >N</label> <!-- 사용안함 -->
	                            </td>
	                            <td></td><!-- 나머지 여백맞추기위한 추가 explorer -->
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="mgT15">
                    <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                    <div
                        id="rgntHistMGrid_Detail"style="width: 100%; height: 300px; margin: 0 auto;">
                    </div>
                </div>
            </div>
            <div id="tabCts2" class="tabCts" style="display: none">
                <div class="subCon1">
                    <h2><i class="fi-rr-apps"></i>${msg.C100000702}</h2><!--입출고 이력-->
                    <div class="btnWrap">
                        <button id="tab2btnSearch" class="search">${msg.C100000767}</button> <!-- 조회-->
                    </div>
                    <form id="tab2searchFrm" name="tab2searchFrm">
                        <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
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
								<th>분석실</th><!-- 사업 장 -->
								<td>
									<select id="tab2custlabSeqno" name="custlabSeqno"></select>
								</td>
                                <th>${msg.C100000811}</th><!-- 분류 -->
                                <td>
                                    <select id="tab2wrhsdlvrSeCodeSch" name="wrhsdlvrSeCodeSch">
                                        <option value=''>${msg.C100000480}</option><!-- 선택 -->
                                    </select>
                                </td>
                                <th>${msg.C100000292}</th><!-- 등록 일자 -->
                                <td style="text-align: left;">
                                    <input type="text"id="tab2useBeginDte"name="useBeginDte"class="dateChk wd6p" style="min-width: 6em;"autocomplete="off"required>
                                	~
                                    <input type="text" id="tab2useEndDte"name="useEndDte" class="dateChk wd6p" style="min-width: 6em;"autocomplete="off"required>
								</td>
								<th>${msg.C100000465}</th> <!--삭제 여부  -->
	                            <td>
	                            	<label><input type="radio" id="tab2delete_a" name="deleteAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
									<label><input type="radio" id="tab2delete_y" name="deleteAtSch" value="Y" >Y</label> <!-- 사용 -->
									<label><input type="radio" id="tab2delete_n" name="deleteAtSch" value="N" >N</label> <!-- 사용안함 -->
	                            </td>
                            </tr>
                        </table>
                    </form>
                </div>
				<div class="subCon2 mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="dateHistGrid" style="width: 100%; height: 600px; margin: 0 auto;"></div>
				</div>
			</div>
			<div  id="tabCts3" class="tabCts" style="display: none">
			 <div class="subCon1">
                    <h2><i class="fi-rr-apps"></i>${msg.C100000702}</h2><!--입출고 이력-->
                    <div class="btnWrap">
                        <button id="tab3btnSearch" class="search">${msg.C100000767}</button> <!-- 조회-->
                    </div>
                    <form id="tab3searchFrm" name="tab3searchFrm" onsubmit="return false;">
                        <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
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
                                   <th>${msg.C100000336}</th><!-- 바코드 -->
                                <td colspan ="5">
                                    <input type="text" id="brcdSch" name="brcdSch"autocomplete="off" required> 
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
				<div class="subCon2 mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="brcdHistGrid" style="width: 100%; height: 600px; margin: 0 auto;"></div>
				</div>
			</div>
        </div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			/*******전역변수*********/
			var rgntHistMGrid_Master = 'rgntHistMGrid_Master';
			var rgntHistMGrid_Detail = 'rgntHistMGrid_Detail';
			var dateHistGrid = 'dateHistGrid';
			var brcdHistGrid = 'brcdHistGrid';
			var lang = ${msg}; //기본언어
			/*******OnLoad*********/
			$(function() {
				setCombo();
				// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
				setPurchsRequestGrid();

				// 버튼 이벤트
				setButtonEvent();

				// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
				rgntHistMGridEvent();

				// 그리드 리사이즈
				gridResize([rgntHistMGrid_Master,rgntHistMGrid_Detail,dateHistGrid,brcdHistGrid]);

			}); // OnLoad 끝;

			function setCombo(){
                ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqno', selectFlag : true});
				ajaxJsonComboBox('/com/getCmmnCode.lims', "prductClCodeSch",{"upperCmmnCode" :  "RS01"}, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims', "wrhsdlvrSeCodeSch",{"upperCmmnCode" :  "RS08"}, true);  
				ajaxJsonComboBox('/com/getCmmnCode.lims', "tab2wrhsdlvrSeCodeSch",{"upperCmmnCode" :  "RS08"}, true); 
				datePickerCalendar(["useBeginDte", "useEndDte"], true, ["YY",-1], ["DD",0]);
				datePickerCalendar(["tab2useBeginDte", "tab2useEndDte"], true, ["YY",-1], ["DD",0]);
			}
			// 그리드 생성
			function setPurchsRequestGrid() {

				//그리드 레이아웃 정의
				var columnLayout ={ rgntHistMasterCol :[],rgntHistDetailCol:[],dateHistDetailCol:[] };


				//컬럼 셋팅
				//addColumnCustom param : dataField, headerText, width, visible, editable, prosCustom
				//prosCustom 컬럼 속성이 추가햇는데 반영이 안되는 경우 addColumnCustom 함수에 custom col 속성 설정 부분 추가해야 함

				auigridCol(columnLayout.rgntHistMasterCol);
                custlabSeqnoArray=getGridComboList('/rsc/getCustlabCombo.lims',null,true);
				columnLayout.rgntHistMasterCol.addColumnCustom("custlabSeqno","분석실",null,false,false) // 사업 장
                .addColumnCustom("custlabNm","분석실",null,true,false) // 사업 장
                .addColumnCustom("bplcCode","${msg.C100000432}",null,false,false) // 사업 장
				.addColumnCustom("bplcCodeNm","${msg.C100000432}",null,false,false) // 사업 장
				.addColumnCustom("prductSeqno","",null,false,false)// 제품 일련번호
				.addColumnCustom("prductClCode","",null,false,false) /* 제품분류  */
				.addColumnCustom("prductClCodeNm","${msg.C100000811}",null,true,false) /* 분류  */
				.addColumnCustom("prductNm","품명",null,true,false) /* 품명 */
				.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true,false) /* 현재고   */
                .addColumnCustom("useAt","사용 여부",null,true,false) /* 사용 여부 */
				rgntHistMGrid_Master = createAUIGrid(columnLayout.rgntHistMasterCol, rgntHistMGrid_Master);
                
				auigridCol(columnLayout.rgntHistDetailCol);
				columnLayout.rgntHistDetailCol.addColumnCustom("custlabSeqno","분석실",null,false,false)
                .addColumnCustom("custlabNm","분석실",null,true,false) // 사업 장
                .addColumnCustom("brcd","${msg.C100000336}",null,true,false)	// 바코드
				.addColumnCustom("ordr","${msg.C100000530}",null,true,false)								//순번
				.addColumnCustom("wrhsdlvrSeCode","",null,false,false)										//입출고
				.addColumnCustom("wrhsdlvrSeCodeNm","${msg.C100000698}",null,true,false)					//입출고
				.addColumnCustom("wrhsdlvrDt","${msg.C100000700}",null,true,false)							//입출고 날짜
				.addColumnCustom("wrhsdlvrmanId","${msg.C100000703}",null,false,false)						//입출고자
				.addColumnCustom("wrhsdlvrmanNm","${msg.C100000703}",null,true,false)										//입출고자
				.addColumnCustom("deleteAt","${msg.C100000465}",null,true,false)										//삭제여부
				.addColumnCustom("prductWrhsdlvrBrcdSeqno","${msg.C100000338}",null,false,false) /* 바코드 일련번호   */
				// 그리드 생성
				rgntHistMGrid_Detail = createAUIGrid(columnLayout.rgntHistDetailCol, rgntHistMGrid_Detail);
                
                auigridCol(columnLayout.dateHistDetailCol);
                columnLayout.dateHistDetailCol.addColumnCustom("custlabSeqno","분석실",null,false,false)
                .addColumnCustom("custlabNm","분석실",null,true,false) // 사업 장
                .addColumnCustom("prductNm","품명",null,true,false) // 품명
                .addColumnCustom("prductClCodeNm","${msg.C100000811}",null,true,false)  // 분류
                .addColumnCustom("brcd","${msg.C100000336}",null,true,false)	// 바코드
                .addColumnCustom("ordr","${msg.C100000530}",null,true,false)								//순번
                .addColumnCustom("wrhsdlvrSeCode","${msg.C100000698}",null,false,false)						//입출고
                .addColumnCustom("wrhsdlvrSeCodeNm","${msg.C100000698}",null,true,false)					//입출고
                .addColumnCustom("wrhsdlvrDt","${msg.C100000700}",null,true,false)							//입출고 날짜
                .addColumnCustom("wrhsdlvrmanId","${msg.C100000703}",null,false,false)						//입출고자
                .addColumnCustom("wrhsdlvrmanNm","${msg.C100000703}",null,true,false)						//입출고자
                .addColumnCustom("deleteAt","${msg.C100000465}",null,true,false)										//삭제여부
                .addColumnCustom("prductWrhsdlvrBrcdSeqno","${msg.C100000338}",null,false,false) 			/* 바코드 일련번호   */
                dateHistGrid = createAUIGrid(columnLayout.dateHistDetailCol, dateHistGrid);
                brcdHistGrid = createAUIGrid(columnLayout.dateHistDetailCol, brcdHistGrid);

			};
			// 그리드 이벤트
			function rgntHistMGridEvent() {

				// 각자 필요한 이벤트 구현
				AUIGrid.clearGridData(rgntHistMGrid_Master);
				AUIGrid.clearGridData(rgntHistMGrid_Detail);
				AUIGrid.clearGridData(dateHistGrid);
				AUIGrid.clearGridData(brcdHistGrid);
				
				// ready는 화면에 필수로 구현 할 것
				AUIGrid.bind(rgntHistMGrid_Master, "ready", function(event) {
					gridColResize(rgntHistMGrid_Master, "2");
				});
				AUIGrid.bind(rgntHistMGrid_Detail, "ready", function(event) {
					gridColResize(rgntHistMGrid_Detail, "2");
				});
				AUIGrid.bind(dateHistGrid, "ready", function(event) {
					gridColResize(dateHistGrid, "2");
				});
				AUIGrid.bind(brcdHistGrid, "ready", function(event) {
					gridColResize(brcdHistGrid, "2");
				});

				 AUIGrid.bind(rgntHistMGrid_Master, "cellDoubleClick", function(event){
					 getRgntHist();
				}); 

			}
			// 버튼 이벤트
			function setButtonEvent() {
				
				getEl("tab1").addEventListener("click", function(e){
					AUIGrid.resize(rgntHistMGrid_Master);
					AUIGrid.resize(rgntHistMGrid_Detail);
				});
				
				getEl("tab2").addEventListener("click", function(e){
					AUIGrid.resize(dateHistGrid);
				});
				getEl("tab3").addEventListener("click", function(e){
					AUIGrid.resize(brcdHistGrid);
				});
				
				document.getElementById("tab1btnSearch").addEventListener("click",function(e){
					getPrduct();
				});

				document.getElementById("tab2btnSearch").addEventListener("click",function(e){
					getdateHist();
				});
				
				document.getElementById("tab3btnSearch").addEventListener("click",function(e){
					getbrcdHist();
				});
				
				$("select[name=wrhsdlvrSeCodeSch]").change(function(e){
					if(e.target.id.match("tab2.+"))
						getdateHist();
						else{getRgntHist()}
				});
				$("input[name=useEndDte]").change(function(e){
					if(e.target.id.match("tab2.+"))
						getdateHist();
						else{getRgntHist()}
				});
				$("input[name=useBeginDte]").change(function(e){
					if(e.target.id.match("tab2.+"))
						getdateHist();
						else{getRgntHist()}
				});

				$("input[name=deleteAtSch]").change(function(e){
					if(e.target.id.match("tab2.+"))
					getdateHist();
					else{getRgntHist()}
				});

				$("#prductNmSch").keypress(function(e) {
					if (e.which == 13) {
						getPrduct();
					}
				});
				$("#tab2searchFrm").keypress(function(e) {
					if (e.which == 13) {
						getdateHist();
					}
				});
				$("#brcdSch").keypress(function(e) {
					if (e.which == 13) {
						getbrcdHist();
					}
				});
			}

			/*############ 조회############*/


			/* 조회 */
			function getPrduct() {
				var getPrductUrl = "<c:url value='/rsc/getPrduct.lims'/>";
				getGridDataForm(getPrductUrl,"rgntHistFrm",rgntHistMGrid_Master);
			}

			function getRgntHist() {
				if(!saveValidation('searchFrm')){ return false; }
				param= AUIGrid.getSelectedItems("#rgntHistMGrid_Master");
				if(param !=''){
				fromdata = $("#searchFrm").serializeObject();
				data=Object.assign(param[0].item,fromdata);
				var getHistlistUrl = "<c:url value='/rsc/getHistlist.lims'/>";
				getGridDataParam(getHistlistUrl,data, rgntHistMGrid_Detail);
				}
			}
			function getdateHist() {
				if(!saveValidation('tab2searchFrm')){ return false; }
				var getHistlistUrl = "<c:url value='/rsc/getHistlist.lims'/>";
				getGridDataForm(getHistlistUrl,"tab2searchFrm",dateHistGrid);
			}
			function getbrcdHist() {
				if(!saveValidation('tab3searchFrm')){ return false; }
				var getHistlistUrl = "<c:url value='/rsc/getHistlist.lims'/>";
				getGridDataForm(getHistlistUrl,"tab3searchFrm",brcdHistGrid);
			}
			
			/*############ 기타이벤트 함수 ############*/

			// 초기화 함수
			function setClear() {
				AUIGrid.clearGridData(rgntHistMGrid_Master);
				AUIGrid.clearGridData(rgntHistMGrid_Detail);
			}
		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>