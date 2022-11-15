 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="main-definition">
	<tiles:putAttribute name="title">Main</tiles:putAttribute>
	<tiles:putAttribute name="body">

<!-- <div id="contents" style="<c:if test="${auditAt == 'N'}">display:none;</c:if> height:100%; width:100%; text-align:center;">
	<span style="display:inline-block; height:100%; vertical-align:middle; "></span>
	<div class="con1" style="height:100%;">
		<img src="/assets/image/banner2.jpg" style="width:600px; height:600px; border-radius : 23.5rem; position : absolute; top:11%; left: 26%;">
	</div>
</div> -->

<!-- <c:if test="${auditAt == 'Y'}">style="display:none;"</c:if> -->
<div id="contents">	
	<div class="con1">
		<div class="con1_top">
			<h2 class="h2Title"><i class="fi-rr-search-alt"></i>${msg.C100000849}</h2> <!-- 진행현황 -->			
		</div>
		<div class="con1_inner">
			<ul class="clfix">				
				<li>
					<a href="${pageContext.request.contextPath}/req/RequestM.lims">
						<span><img src="/assets/image/conIcon01.png"></span>
						<dl>
							<dt>${msg.C100000228}<!--${msg.C100000228}--></dt> <!-- 당일 의뢰건수 -->
							<dd><strong id="one">0</strong>${msg.C100000120}</dd> <!-- 건 -->
						</dl>
					</a>
				</li>
				
				<li>	
					<a href="${pageContext.request.contextPath}/req/ReceiptM.lims">				
						<span><img src="/assets/image/conIcon02.png"></span>
						<dl>
							<dt>${msg.C100000792}<!--${msg.C100000792}--></dt> <!-- 접수대기 -->
							<dd><strong id="two">0</strong>${msg.C100000120}</dd> <!-- 건 -->
						</dl>
					</a>
				</li>				
				
				<li>
					<a href="${pageContext.request.contextPath}/test/ResultInputM.lims">
						<span><img src="/assets/image/conIcon03.png"></span>
						<dl>
							<dt>${msg.C100000417}<!--${msg.C100000417}--></dt> <!-- 분석중 -->
							<dd><strong id="thr">0</strong>${msg.C100000120}</dd> <!-- 건 -->
						</dl>
					</a>
				</li>				
				
				<li>
					<a href="${pageContext.request.contextPath}/test/ResultOfAnalysisM.lims">
						<span><img src="/assets/image/conIcon04.png"></span>
						<dl>
							<dt>${msg.C100000086}<!--${msg.C000001125}--></dt> <!-- ROA대기 -->
							<dd><strong id="fou">0</strong>${msg.C100000120}</dd> <!-- 건 -->
						</dl>
					</a>
				</li>				
				
				<li>
					<a href="${pageContext.request.contextPath}/test/CoaM.lims">
						<span><img src="/assets/image/conIcon05.png"></span>
						<dl>
							<dt>${msg.C100000031}<!--${msg.C000001282}--></dt> <!-- COA대기 -->
							<dd><strong id="fiv">0</strong>${msg.C100000120}</dd> <!-- 건 -->
						</dl>
					</a>
				</li>								
			</ul>
		</div>
	</div><!-- con1 END -->

    <div class="con2">        
		<div class="con2Left clfix">
			<h2 class="h2Title"><i class="fi-rr-file-check"></i>${msg.C100000579}<!--${msg.C000001283}--> </h2> <!-- 팀별 의뢰건수 -->
			<div class="tab-wrapper">
				<ul class="tab-menu">
					<li class="active" id="tab4">차기 교육 대상자</li> <!--  차기 교육 대상자-->
					<li id="tab1">${msg.C100000131}</li><!--  검교정대상목록-->
					<li id="tab2">${msg.C100000778}</li><!--  적정재고 이하 시약-->
					<li id="tab3">${msg.C100000646}</li><!--  유효기한 만료대상-->
				</ul>
				<div class="tab-content">

					<div>
						<div class="subCon1">
							<div class="tableBtn">
								<button type="button" id="testbtn5" class="btn4 search mgR0">${msg.C100000767}</button> <!-- 조회 -->
							</div>
						</div>
						<div class="subCon2">
							<div id="tabGrid5" style="height:326px;"></div>
						</div>
					</div><!-- 다섯번째 탭 -->

					<div>
						<div class="subCon1">
							<form id="tab2Frm" name="tab2Frm" class="sub">								
								<table style="border-top:0">
									<tr style="border-bottom:0">
										<td class="wid64">${msg.C100000135}</td> <!-- 검사 교정 예정일자 -->										
										<td class="wid46">
											<input type="text" id="tab2Begindte" name="tab2Begindte"  class="dateChk wd6p" autocomplete="off" required>~
											<input  type="text" id="tab2Enddte" name="tab2Enddte" class="dateChk wd6p" autocomplete="off" required>
										</td>										
									</tr>
								</table>
					 		</form>

                            <div class="tableBtn">
                                <button type="button" id="testbtn2" class="btn4 search mgR0">${msg.C100000767}</button> <!-- 조회 -->
                            </div>
                  		</div>
                    
						<div class="subCon2">
                             <div id="tabGrid2" style="height:290px;"></div>
                        </div>
					</div><!-- 두번째 탭 -->
					
					<div>
						<div class="subCon1 wd100p" style="display:inline-block; height: 26px;">
                            <div class="tableBtn">
                                <button type="button" id="testbtn3" class="btn4 search mgR0">${msg.C100000767}</button> <!-- 조회 -->
                            </div>
                        </div>
						<div class="subCon2">
                           	<div id="tabGrid3" style="height:290px;"></div>
                       	</div>
					</div><!-- 세번째 탭 -->
					
					<div>
						<div class="subCon1">
					   		<form id="tab4Frm" name="tab4Frm" class = "sub" >
						   		<table style="border-top:0;">
									<tr style="border-bottom:0">										
										<td class="wid64">${msg.C100000641}</td> <!--유효일자 -->
										<td class="wid46">
											<input type="text" id="tab4Begindte" name="tab4Begindte"  class="dateChk wd6p" autocomplete="off" required>~
											<input  type="text" id="tab4Enddte" name="tab4Enddte" class="dateChk wd6p" autocomplete="off" required>
										</td>										
									</tr>
								</table>
							</form>
                            <div class="tableBtn">
                                <button type="button" id="testbtn4" class="btn4 search mgR0">${msg.C100000767}</button> <!-- 조회 -->
                            </div>
                        </div>
						<div class="subCon2">
                            <div id="tabGrid4" style="height:290px;"></div>
                        </div>
					</div><!-- 네번째 탭 -->

				</div>
			</div>
		</div>

           <div class="con2Right fL">
               <div class="conTop">
                   <h2 class="h2Title"><i class="fi-rr-volume"></i>${msg.C100000194} </h2> <!-- 공지사항 -->
                   <div class="btnWrap">
                        <button type="button" id="btn_bbsMore" class="btn4 search" value="더보기">${msg.C100000285}</button> <!-- 더보기 -->
                   </div>
               </div>
               <div class="subCon2">
                   <input type="hidden" id="btnBbs" />
                   <div class="mgT">
                       <div id="bbsGrid" style="height:375px;"></div>
                   </div>
               </div>
           </div>        
    </div><!-- con2 END -->
</div>

</tiles:putAttribute>
<tiles:putAttribute name="script">

<style type="text/css">
/* 커스텀 행 스타일 */
.my-row-style {
	background-color:#FAFA96;
	font-weight:bold;
	color:#d3825c;
}
</style>

<script>
/*******전역변수*********/
 var bbsGrid = 'bbsGrid'; // 공지사항 게시판 그리드
 var requestGrid = 'requestGrid' //팀별 의뢰건수 그리드
 var tabGrid2 = 'tabGrid2'
 var tabGrid3 = 'tabGrid3'
 var tabGrid4 = 'tabGrid4'
 var tabGrid5 = 'tabGrid5'

 var lang = ${msg}; //기본언어

 $(function() {
	 	
	if("${UserMVo.deptCode}" == "3992" && Cookie.get("todayClose")!="Y"){
		var popup = openPopup("/imminentNotifyP01.lims", "기한 임밥 알림", {
			width : "700",
			height : "700",
			top : "200",
			left : "300",
			location : "no",
			scrollbars : "yes"
		});
	}

	//ajaxJsonComboBox('/wrk/getBestComboList.lims','bplcCode',null,false,null,"${UserMVo.bestInspctInsttCode}");
	datePickerCalendar(["tab2Begindte", "tab2Enddte"], true, ["MM",0], ["MM",+1]);
	datePickerCalendar(["tab4Begindte", "tab4Enddte"], true, ["MM",0], ["MM",+1]);
	setCreateGrid();

	gridEvent();

	//버튼 이벤트
	setButtonEvent();

	// 팝업이벤트
 	popUpEvent();

    searchBbsGrid();
	searchRefromGrid();
	//searchIsscGrid();
    
    searchProList("${UserMVo.bestInspctInsttCode}");
});

// // 그리드 생성
function setCreateGrid(){

// 	var gDeffered = $.Deferred();

// 	//그리드 레이아웃 정의
	var columnLayout = {
        bbsGridCol : [],
		tabGrid2Col: [],
        tabGrid3Col: [],
		tabGrid4Col: [],
        tabGrid5Col: [],
        requestGridCol:[]
 	};

 	var myStyleProps = {
 			// row Styling 함수
 			rowStyleFunction : function(rowIndex, item) {
 				if(item.popupAt == "Y" && item.ordNo == 1) {
 					return "my-row-style";
 				}
 				return null;
 			}
 	}


	auigridCol(columnLayout.tabGrid2Col);
 	columnLayout.tabGrid2Col.addColumnCustom("eqpmnSeqno","${msg.C100000739}",null,false);				// 장비 일련번호
 	columnLayout.tabGrid2Col.addColumnCustom("bplcCodeNm","${msg.C100000432}",null,false);				// 사업장명
	columnLayout.tabGrid2Col.addColumnCustom("custlabSeqnoNm","분석실",null,true);				//사업장명
 	columnLayout.tabGrid2Col.addColumnCustom("eqpmnNm","${msg.C100000742}",null,true);					//장비명
	columnLayout.tabGrid2Col.addColumnCustom("inspctCrrctSeNm","${msg.C100000125}",null,true);			//검교정 구분
	columnLayout.tabGrid2Col.addColumnCustom("cycleNm","${msg.C100000835}",null,true);					//주기
	columnLayout.tabGrid2Col.addColumnCustom("inspctCrrctPrearngeDte","${msg.C100000135}",null,true);	//검사 교정 예정일자
	
	auigridCol(columnLayout.tabGrid3Col);
	columnLayout.tabGrid3Col.addColumnCustom("prductSeqno","${msg.C100000812}",null,false);				//제품 일련번호
 	columnLayout.tabGrid3Col.addColumnCustom("bplcCodeNm","${msg.C100000432}",null,false);				//사업장명
	columnLayout.tabGrid3Col.addColumnCustom("custlabSeqnoNm","분석실",null,true);				//사업장명
	columnLayout.tabGrid3Col.addColumnCustom("prductClNm","${msg.C100000807}",null,true);				//제품 구분
	columnLayout.tabGrid3Col.addColumnCustom("prductNm","${msg.C100000809}",null,true);					//제품명
	columnLayout.tabGrid3Col.addColumnCustom("proprtinvntryQy","${msg.C100000776}",null,true);			//적정재고
	columnLayout.tabGrid3Col.addColumnCustom("nowInvntryQy","${msg.C100000957}",null,true);				//현재고

	
	auigridCol(columnLayout.tabGrid4Col);
	columnLayout.tabGrid4Col.addColumnCustom("bplcCodeNm","${msg.C100000432}",null,false);				//사업장명
	columnLayout.tabGrid4Col.addColumnCustom("prductNm","${msg.C100000809}",null,true);					//제품명
 	columnLayout.tabGrid4Col.addColumnCustom("prductClNm","${msg.C100000807}",null,true);				//제품 구분
	columnLayout.tabGrid4Col.addColumnCustom("wrhsdlvrSeNm","${msg.C100000698}",null,true);				//입출고
	columnLayout.tabGrid4Col.addColumnCustom("brcd","${msg.C100000336}",null,true);						//바코드
	columnLayout.tabGrid4Col.addColumnCustom("validDte","${msg.C100000641}",null,true);					//유효일자

	auigridCol(columnLayout.tabGrid5Col);
	columnLayout.tabGrid5Col.addColumnCustom("bplcCodeNm","${msg.C100000432}",null,false);				//사업장명
	columnLayout.tabGrid5Col.addColumnCustom("edcSeCodeNm","교육 구분",null,true);					//사용자
	columnLayout.tabGrid5Col.addColumnCustom("edcSj","교육제목",null,true);					//부서명
	columnLayout.tabGrid5Col.addColumnCustom("edcSeCode","${msg.C100000119}",null,false);				//갱신일자
	columnLayout.tabGrid5Col.addColumnCustom("bplcCode","${msg.C100000119}",null,false);				//갱신일자
	columnLayout.tabGrid5Col.addColumnCustom("edcInsttNm","교육기관명",null,true);				//갱신일자
	columnLayout.tabGrid5Col.addColumnCustom("nxttrmEdcDte","차기교육 일자",null,true);				//갱신일자

	// 팀별 의뢰건수 그리드
 	auigridCol(columnLayout.requestGridCol);
 	columnLayout.requestGridCol.addColumnCustom("manageDeptNm","${msg.C000000255}",null,true,false);	/* 팀명 */
 	columnLayout.requestGridCol.addColumnCustom("lnum","${msg.C000001287}",null,true,false); 			/* 전월건수 */
 	columnLayout.requestGridCol.addColumnCustom("cnum","${msg.C000001288}",null,true,false);			/* 당월건수 */

	// 공지사항 그리드
 	auigridCol(columnLayout.bbsGridCol);
 	columnLayout.bbsGridCol.addColumnCustom("sj","${msg.C100000802}","*",true,false);					/* 제목 */
 	columnLayout.bbsGridCol.addColumnCustom("cn","${msg.C100000259}",null,false,false);					/* 내용 */
 	columnLayout.bbsGridCol.addColumnCustom("wrterNm","${msg.C100000730}","20%",true,false);			/* 작성자 */
 	columnLayout.bbsGridCol.addColumnCustom("writngDe","${msg.C100000728}","20%",true,false);			/* 작성일자 */


 	// 그리드 생성
 	tabGrid2 = createAUIGrid(columnLayout.tabGrid2Col, tabGrid2);
 	tabGrid3 = createAUIGrid(columnLayout.tabGrid3Col, tabGrid3);
 	tabGrid4 = createAUIGrid(columnLayout.tabGrid4Col, tabGrid4);
 	tabGrid5 = createAUIGrid(columnLayout.tabGrid5Col, tabGrid5);
 	// requestGrid = createAUIGrid(columnLayout.requestGridCol, requestGrid);
 	bbsGrid = createAUIGrid(columnLayout.bbsGridCol, bbsGrid,myStyleProps);

}

// // 그리드 이벤트
 function gridEvent(){
 	// 각자 필요한 이벤트 구현
 	AUIGrid.clearGridData(bbsGrid);

 	// ready는 화면에 필수로 구현 할 것
 	AUIGrid.bind(bbsGrid, "ready", function(event) {
		var list = AUIGrid.getGridData(bbsGrid);
		for(var i = 0;i<list.length;i++){
			if(list[i].popupAt == 'Y'){
				if(list[i].popupBeginDe <= getFormatDate(0,0,0)){
					if(list[i].popupEndDe >= getFormatDate(0,0,0)){
						var url = "/popup/popBbs.lims";
						bbsPopup(url,list[i].sntncSeqno,i);
					}
				}
			}
		}
 	});

 	AUIGrid.bind(requestGrid, "ready", function(event) {
 		gridColResize(requestGrid, "2");
 	});

 	AUIGrid.bind(tabGrid2, "ready", function(event) {
 		gridColResize(tabGrid2, "2");
 	});
 	AUIGrid.bind(tabGrid3, "ready", function(event) {
 		gridColResize(tabGrid3, "2");
 	});
 	AUIGrid.bind(tabGrid4, "ready", function(event) {
 		gridColResize(tabGrid4, "2");
 	});
 	AUIGrid.bind(tabGrid5, "ready", function(event) {
 		gridColResize(tabGrid5, "2");
 	});

 	// 공지사항 클릭 이벤트
  	AUIGrid.bind(bbsGrid, "cellDoubleClick", function(event) {
  		$("#btnBbs").click();
  	});
 }
// // 버튼 이벤트
 function setButtonEvent(){

    document.querySelector('#contents').addEventListener('change',function(e){
        dateValidChk(e);
    });

 	$("#btn_bbsMore").click(function(){
 		location.href = "/sys/NoticeWriteM.lims?board=0000000001";
 	});

    // 팀 의뢰 조회
    $('#btnSearchTcm').click(function() {
    	searchTcmGrid();
    });

    // 이상발생목록 조회
    $('#btnSearchIssc').click(function() {
    	searchIsscGrid();
    });

	// 사업장 change event
	$("#bplcCode").change(function(){
		searchProList(getEl("bplcCode").value);
		for(var i = 1 ;i <=5;i++){
		if($('#tab'+i).attr('class')=='active'){
			$('#tab'+i).trigger("click");
		}
		}
	});

	$("#testbtn2").click(function(){
		searchInspctGrid();
	});

	$("#testbtn3").click(function(){
		searchPrductGrid();
	});

	$("#testbtn4").click(function(){
		searchValidGrid();
	});

	$("#testbtn5").click(function(){
		searchRefromGrid();
	});
	
	getEl("tab1").addEventListener("click", function(e){
		searchInspctGrid();
		AUIGrid.resize(tabGrid2);
	});
    
	getEl("tab2").addEventListener("click", function(e){
		searchPrductGrid();
		AUIGrid.resize(tabGrid3);
	});
	getEl("tab3").addEventListener("click", function(e){
		searchValidGrid();
		AUIGrid.resize(tabGrid4);
	});
	getEl("tab4").addEventListener("click", function(e){
		searchRefromGrid();
		AUIGrid.resize(tabGrid5);
	});
 }


// /*############ 조회 ############*/

// 공지사항 조회
function searchBbsGrid(){
	getGridDataParam("<c:url value='/getBbsList.lims'/>", null, bbsGrid);
}

// 이상발생 목록 조회
/*function searchIsscGrid(){
	if($("#bplcCode").val()!=null){
	fromdata ={bplcCode:$("#bplcCode").val()}
	}else{
	fromdata ={bplcCode:"${UserMVo.bestInspctInsttCode}"}
	}
    getGridDataParam("<c:url value='/getIsscList.lims'/>", fromdata, tabGrid1);
}*/
function searchInspctGrid(){
	if(!saveValidation('tab2Frm')){ return false; }
	fromdata = $("#tab2Frm").serializeObject();
	getGridDataParam("<c:url value='/getInspctList.lims'/>", fromdata, tabGrid2);
}
function searchPrductGrid(){
	getGridDataParam("<c:url value='/getPrductList.lims'/>",null, tabGrid3);
}
function searchValidGrid(){
	if(!saveValidation('tab4Frm')){ return false; }
	fromdata = $("#tab4Frm").serializeObject();
	getGridDataParam("<c:url value='/getValidList.lims'/>", fromdata, tabGrid4);
}
function searchRefromGrid(){
	getGridDataParam("<c:url value='/getRefromList.lims'/>", null, tabGrid5);
}

function popUpEvent(){
    dialogMainBbsNew("btnBbs",'',"mainBbs",'bbsGrid',function(){

  	});

 	IssDialog("btnIss", '', "prductStndrdDialog",'testGrid1', function(){

 	});
}

function searchProList(bplcCode){
	var data = {
	};

	return customAjax({
		"url" : "/getSelProEa.lims",
		"data" : data,
		"successFunc" : function(data){
			new numberCounter("one", data.one, '');
			new numberCounter("two", data.two, '');
			new numberCounter("thr", data.thr, '');
			new numberCounter("fou", data.fou, '');
			new numberCounter("fiv", data.fiv, '');
			new numberCounter("six", data.six, '');
		}
	});
}

function bbsPopup(url,row,index){
	if(getCookie("popup"+row) != "done"){
		var data = new Array();

        data = row;
        var formTarget = "_bbsPopup" + row;

		var mapForm = document.createElement("form");
		mapForm.target = formTarget;
        mapForm.method = "POST";
        mapForm.name = "windowOpen_bbsPopup"
		mapForm.action = url + "?" + index;

		var mapInput = document.createElement("input");
		mapInput.type = "hidden";
		mapInput.name = "param";
		mapInput.value = data;
		mapForm.appendChild(mapInput);
        document.body.appendChild(mapForm);
        
        var screenLeft = window.screenLeft;
		var left = window.screenLeft + (100 * (index + 1));
		var top = 50;
		var windowOpen = window.open('', formTarget, 'width=600, height=630, resizable=yes, scrollbars=no, left=' + left + ', top=' + top);

        if (!!windowOpen) {
            mapForm.submit();
            //form이 계속 생성되기때문에 팝업열고 삭제시켜버림.
            $("form[name=windowOpen_bbsPopup]").remove();

        } else {

            //한번만 알림
            if (index == 0) {
                alert('팝업이 차단되어 있습니다.');
            }
        }
	}
}

function getCookie(name) {
	var nameOfCookie = name + "=";
	var x = 0;
	while (x <= document.cookie.length){
		var y = (x + nameOfCookie.length);
		if (document.cookie.substring(x, y) == nameOfCookie){
		if ((endOfCookie = document.cookie.indexOf(";", y)) == -1){
		endOfCookie = document.cookie.length;
		}
		return unescape (document.cookie.substring(y, endOfCookie));
		}
		x = document.cookie.indexOf (" ", x) + 1;
		if (x == 0) break;
	}
	return "";
}

function numberCounter(target_frame, target_number, add_unit) {
    this.count = 0; this.diff = 0;
    this.target_count = parseInt(target_number);
    this.target_frame = document.getElementById(target_frame);
    this.add_unit = add_unit == undefined ? "" : add_unit;
    this.timer = null;
    this.counter();
};

numberCounter.prototype.counter = function() {
    var self = this;
    this.diff = this.target_count - this.count;

    if(this.diff > 0) {
        self.count += Math.ceil(this.diff / 30);
    }

    this.target_frame.innerHTML = this.count.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + this.add_unit;

    if(this.count < this.target_count) {
        this.timer = setTimeout(function() { self.counter(); }, 20);
    } else {
        clearTimeout(this.timer);
    }
};

</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
