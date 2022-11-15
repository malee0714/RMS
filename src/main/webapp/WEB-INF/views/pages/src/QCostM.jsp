<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000078}</h2> <!-- Q-COST 조회 -->
				<div class="btnWrap">
					<button id="btnSearch" type="button" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<form id="searchFrm">
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
							<th>${msg.C100000432}</th> <!-- 사업장명 -->
							<td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
							<th>${msg.C100000264}</th> <!-- 년도 -->
							<td><select type="text" id="yy" name="yy"></select></td>
							<th>${msg.C100000745}</th> <!-- 장비 분류-->
							<td><select id="eqpmnClCodeSch" name="eqpmnClCodeSch"></select></td>

						</tr>
					</table>
				</form>
			</div>
			
			<div class="subCon2">
				<div style="display:flex">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="requestCntList" class="wd100p mgT11" style="height:500px;"></div>
					<div class="wd80p" style="display:inline-block;">
						<div id="chValueChartDiv" style="margin-top: 19px;">
							<div id="requestCntChart" class="subCon1" style="clear:both; display:flex; flex-wrap:wrap;"></div>
							<!-- <canvas id="requestCntChart" class="wd100p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas> -->
						</div>
					</div>
				</div>
			</div>
			<form id="frmChartData" method="post" action="/com/chartImgDown.lims">
				<input type="text" name="chartImg" id="chartImg" value="" style="display:none;"/>
			</form>

			<div class="accordion_wrap">	
				<div class="subCon2 wd100p mgT25" id="detail2">
					<div class="accordion">${msg.C100000468}<!-- 내용 --></div>
					<div id="acc2" class="acco_top mgT15" style="display: none">
					<h3>${msg.C100000415}</h3> <!--분석장비 COST 비용 -->
					<div id="eqpmnCost" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
					<h3>${msg.C100000262}</h3> <!-- 년간 인건비 -->
					<div id="costYearGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
					<h3>${msg.C100000407}</h3> <!-- 분석 CAPA -->
					<div id="capaGrid" class="mgT15" style="width:100%; height:300px; margin:0 auto;"></div>
					</div>
				</div>
			</div>

		</div>
		</tiles:putAttribute>

<tiles:putAttribute name="script">
<script>
var requestCntList = "requestCntList";
var eqpmnCost = "eqpmnCost";
var costYearGrid ="costYearGrid";
var requestCntChart;
var gridRowHeight = 22;
var gridHeaderHeight = 30;
$(document).ready(function(){
	getAuth();
	
	//초기세팅
	init();
	
	//콤보 박스 초기화
	setCombo();
	
	
	//담당 팁별 접수 건수 그리드 세팅
	setRequestListGrid();
	seteqpmnCostGrid();
	setcostYearGrid();
	setcapaGrid();
	
	//버튼 이벤트 선언
	setButtonEvent();
	
	
});

//초기세팅
function init(){
	//달력 의뢰일자
// 	datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["DD",-124], ["DD",0]);
}

//콤보 박스 초기화
function setCombo(){
	//부서	
	ajaxJsonComboBox('/wrk/getBestComboList.lims', 'bplcCodeSch', null, null, null, '${UserMVo.bestInspctInsttCode}');
	ajaxJsonComboBox('/com/getCmmnCode.lims', "eqpmnClCodeSch",{"upperCmmnCode" :  "RS02"}, true);  // 제품 분류
	setYear('yy',"2021", 2019, 10);
	
}

//담당 팁별 접수 건수 그리드 세팅
function setRequestListGrid(){
	var col = [];	
	var cellMerge={
		cellMerge :true
	}
	var cellColMerge={
		cellColMerge : true
		,cellMerge :true,
		cellColSpan : 2,
		labelFunction : function(rowIndex, columnIndex, value, headerText, item, dataField, cItem) {
			if(AUIGrid.getCellValue(requestCntList,rowIndex,columnIndex+1) == undefined){
			//AUIGrid.setCellValue(requestCntList,rowIndex,columnIndex+1,value);
			
			}
			return value;
		}
	}
	var numberColPros = {
				style : 'my-require-style',
				dataType : "numeric"
			};
	auigridCol(col);
	col.addColumnCustom("rowId", "", "*" ,false); /* rowid */
	col.addColumnCustom("eqpmnClCodeNm", "${msg.C100000745}", "*" ,true,false,cellMerge); /* 장비분류 */
	col.addColumnCustom("division", "${msg.C100000205}", "*" ,true,false,cellColMerge); /* 구분 */
	col.addColumnCustom("division2", "${msg.C100000205}", "*" ,true,false); /* 구분 */
	col.addColumnCustom("detail", "${msg.C100000468}", "*" ,true); /* 상세 */
	col.addColumnCustom("unit", "${msg.C100000268}", "*" ,true); /* 단위 */	
	col.addColumnCustom("total", "${msg.C100000093}", "*", true,false,numberColPros); /* Total */

	
	var cusPros = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
		    rowIdField : "rowId",
 			enableCellMerge : true,
			autoGridHeight : true,
			rowSelectionWithMerge : true
 	}	
	

	//auiGrid 생성
	requestCntList = createAUIGrid(col, "requestCntList", cusPros);
		// 그리드 칼럼 리사이즈	
	AUIGrid.bind(requestCntList, "ready", function(event) {
		gridColResize([requestCntList],"2");	//1, 2가 있으니 화면에 맞게 적용
	});

}
function seteqpmnCostGrid(){
	var costcol = [];	
	var numberColPros = {
				style : 'my-require-style',
				dataType : "numeric"
			};
	auigridCol(costcol);	
	costcol.addColumnCustom("eqpmnClCodeNm", "${msg.C100000745}", "*" ,true); /* 장비분류 */
	costcol.addColumnCustom("eqpmnNm", "${msg.C100000205}", "*" ,true); /* 구분 */
	costcol.addColumnCustom("acqsAmount", "${msg.C100000203}", "*" ,true,false,numberColPros); /* 구매비용 */
	costcol.addColumnCustom("wrhousngDte", "${msg.C100000692}", "*" ,true); /* 입고일자 */
	costcol.addColumnCustom("depreciation", "${msg.C100000113}", "*" ,true); /* 감가 상각(년) */	
	costcol.addColumnCustom("costTotal", "${msg.C100000415}", "*", true,false,numberColPros); /* 분석장비 COST 비용 */
	costcol.addColumnCustom("count", "", "*", false); /* Total */
	var cusPross = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			 autoGridHeight : true,
 			enableCellMerge : true
 	}
	 	

	eqpmnCost= createAUIGrid(costcol, "eqpmnCost", cusPross);
	AUIGrid.bind(eqpmnCost, "ready", function(event) {
		//gridColResize([eqpmnCost],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

function setcostYearGrid(){
	var costYearcol = [];
	var numberColPros = {
				style : 'my-require-style',
				dataType : "numeric"
			};
	auigridCol(costYearcol);	
	costYearcol.addColumnCustom("eqpmnClCodeNm", "${msg.C100000745}", "*" ,true); /* 장비분류 */
	costYearcol.addColumnCustom("lbcstRate", "${msg.C100000680}", "*" ,true); /* 인건비 비율 */
	costYearcol.addColumnCustom("lbcstTotal", "${msg.C100000679}", "*" ,true,false,numberColPros); /* 인건비 COST 비용 */
	var cusPross = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			 autoGridHeight : true,
 			enableCellMerge : true
 	}	
	
	 costYearGrid= createAUIGrid(costYearcol, "costYearGrid", cusPross);
	gridResize([ costYearGrid ]);
	AUIGrid.bind(costYearGrid, "ready", function(event) {
		//gridColResize([costYearGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}

function setcapaGrid(){
	var capacol = [];	
	var numberColPros = {
				style : 'my-require-style',
				dataType : "numeric"
			};
	auigridCol(capacol);	
	capacol.addColumnCustom("eqpmnClCodeNm", "${msg.C100000745}", "*" ,true); /* 장비분류 */
	capacol.addColumnCustom("dailAnalsPosblTime", "${msg.C100000687}", "*" ,true,false,numberColPros); /* 일일분석가능시간 */
	capacol.addColumnCustom("analsReqreTime", "${msg.C100000418}", "*" ,true,false,numberColPros); /* 분석항목 당 분석 시간(1건당) */
	capacol.addColumnCustom("dayMaxAnalysis", "${msg.C100000741}", "*" ,true,false,numberColPros); /* 장비 대당 일일 최대 분석건수 */
	capacol.addColumnCustom("yearMaxAnalysis", "${msg.C100000740}", "*" ,true,false,numberColPros); /* 장비 대당 년간 최대 분석건수 */
	capacol.addColumnCustom("eqpmnNumber", "${msg.C100000416}", "*" ,true); /* 분석장비 대수 */	
	capacol.addColumnCustom("capaTotal", "${msg.C100000260}", "*", true,false,numberColPros); /* 년 최대 분석 건수 */
	var cusPross = {
			editable : false, // 편집 가능 여부 (기본값 : false)
 			selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
			 autoGridHeight : true,
 			enableCellMerge : true
 	}	
	
	 capaGrid= createAUIGrid(capacol, "capaGrid", cusPross);
	gridResize([capaGrid,costYearGrid,eqpmnCost,requestCntList]);
	AUIGrid.bind(capaGrid, "ready", function(event) {
//		gridColResize([capaGrid],"2");	// 1, 2가 있으니 화면에 맞게 적용
	});
}



//버튼 이벤트 선언
function setButtonEvent(){
	//조회버튼 클릭
	$("#btnSearch").click(function(){
		searchReceipt();
	});
			
	//차트 엑셀 다운로드
	$("#btnChartExcelDown").click(function(){		
		$("#chartImg").val($("#requestCntChart")[0].toDataURL("image/png"));
		$("#frmChartData").submit();
	});
}

//문서 목록 조회
function searchReceipt(keyCode){
	if(keyCode != undefined && keyCode == 13)
		searchDoc();
	else {
		if(keyCode == undefined) {
			var url = "/src/getQCostList.lims";
			var formId = $("#searchFrm").serializeObject();
			//문서 목록 조회		
			customAjax({"url" : url,"data" : formId,"successFunc" : function(data){
									var chValueChartDoc = document.getElementById('chValueChartDiv');
									chValueChartDoc.innerHTML = '&nbsp;';
									$('#chValueChartDiv').append('<div id="requestCntChart" class="subCon1" style="clear:both; display:flex; flex-wrap:wrap;"></div>');
									AUIGrid.clearGridData(requestCntList);		
									var List=[];
									for (var i=0; i<data.length;i++){
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000415}",division2:"${msg.C100000415}",detail:" ",unit:"${msg.C100000623}",total:0} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000262}",division2:"${msg.C100000262}",unit:"${msg.C100000623}",total:0} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000261}",division2:"${msg.C100000409}",detail:"${msg.C100000046}",unit:"${msg.C100000623}",total:data[i].analsctAm} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000261}",division2:"${msg.C100000410}",detail:"${msg.C100000507}",unit:"${msg.C100000623}",total:data[i].cmpdsAnalsctAm} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000261}",division2:"${msg.C100000638}",unit:"${msg.C100000623}",total:data[i].mntncMendngCntrctAm} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000261}",division2:"${msg.C100000523}",unit:"${msg.C100000623}",total:data[i].rpairsMntncMendngAm} ,"last");
									var sumAm =parseInt(data[i].analsctAm)+parseInt(data[i].cmpdsAnalsctAm)+parseInt(data[i].mntncMendngCntrctAm)+parseInt(data[i].rpairsMntncMendngAm)
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000261}",division2:"${msg.C100000413}",unit:"${msg.C100000623}",total:sumAm} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000430}",division2:"${msg.C100000430}",unit:"${msg.C100000623}",total:0} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000263}",division2:"${msg.C100000263}",unit:"${msg.C100000041}",total:0} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000874}",division2:"${msg.C100000874}",unit:"${msg.C100000992}",total:0} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000408}",division2:"${msg.C100000408}",unit:"${msg.C100000041}",total:data[i].capa} ,"last");
									AUIGrid.addRow(requestCntList, {eqpmnClCodeNm:data[i].eqpmnClCodeNm,division:"${msg.C100000077}",division2:"${msg.C100000077}",unit:"${msg.C100000623}",total:0} ,"last");
									List.push({eqpmnClCode:data[i].eqpmnClCode,yy:data[i].yy,bplcCodeSch:$("#bplcCodeSch").val()});
									//AUIGrid.setGridData(requestCntList, data);
									}
									customAjax({"url" :"/src/getCost.lims","data" : List,"successFunc" : function(datas){
										AUIGrid.setGridData(eqpmnCost, datas);
										for (var i =0; i<datas.length;i++){
										if(datas[i].count =='1'){
											var rows = AUIGrid.getRowIndexesByValue(requestCntList,"eqpmnClCodeNm",datas[i].eqpmnClCodeNm);											
											var item = { 
											rowId :AUIGrid.indexToRowId(requestCntList,rows[0]),
											total : datas[i].costTotal
											};
											AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
										}
										}
									
									customAjax({"url" :"/src/getCostYear.lims","data" : formId,"successFunc" : function(datas){
										AUIGrid.setGridData(costYearGrid, datas);
										for (var i =0; i<datas.length;i++){
										if(datas[i].eqpmnClCodeNm =="" || datas[i].eqpmnClCodeNm ==null){
										}
										else{
											var rows = AUIGrid.getRowIndexesByValue(requestCntList,"eqpmnClCodeNm",datas[i].eqpmnClCodeNm);											
											var item = { 
											rowId :AUIGrid.indexToRowId(requestCntList,rows[1]),
											total : datas[i].lbcstTotal
											};
											AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
										}
										}
							
									customAjax({"url" :"/src/getCapa.lims","data" : List,"successFunc" : function(datas){
										AUIGrid.setGridData(capaGrid, datas);
										for (var i =0; i<datas.length;i++){
										if(datas[i].eqpmnClCodeNm =="" || datas[i].eqpmnClCodeNm ==null){
										}
										else{
											var rows = AUIGrid.getRowIndexesByValue(requestCntList,"eqpmnClCodeNm",datas[i].eqpmnClCodeNm);											
											var item = { 
											rowId :AUIGrid.indexToRowId(requestCntList,rows[8]),
											total : datas[i].capaTotal
											};
											AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
											var myValue1 =parseInt( AUIGrid.getCellFormatValue(requestCntList, rows[0],'total').replace(/[^\d]+/g, ''));
											var myValue2 =parseInt( AUIGrid.getCellFormatValue(requestCntList, rows[1],'total').replace(/[^\d]+/g, ''));
											var myValue3 =parseInt( AUIGrid.getCellFormatValue(requestCntList, rows[6],'total').replace(/[^\d]+/g, ''));
											var myValue = myValue2+myValue1+myValue3;
											var item = { 
											rowId :AUIGrid.indexToRowId(requestCntList,rows[7]),
											total : myValue
											};
											AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
											
											if(datas[i].capaTotal <= 0)
											myValue /=1;
											else
											myValue /=datas[i].capaTotal;
											myValue=Math.round(myValue);
											var item = { 
												rowId :AUIGrid.indexToRowId(requestCntList,rows[9]),
												total : myValue
												};
											AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
											
			
												myValue *=data[i].capa;					//datas[i].capaTotal -> 분석 건수로 바꿔야됨
												myValue=Math.round(myValue);
												var item = { 
													rowId :AUIGrid.indexToRowId(requestCntList,rows[11]),
													total : myValue
													};
												AUIGrid.updateRowsById(requestCntList, item); // 1개 업데이트
												
											var list=[];
											list.push(AUIGrid.getRowsByValue(requestCntList,"eqpmnClCodeNm",data[i].eqpmnClCodeNm));
											createChart(list[0]);	
										}
										}
									}});
								}});
							}});


								
								}
			})
		}
	}
}


function createChart(data){
		console.log(">> data : " , data);
//				//기초 데이터 생성용 변수 생성
//				//얘는 데이터 목록	
			var createCnt = 0; //만들어진 차트 갯수 
			var chartArr = new Array();// 차트 갯수
			var eqpmnClCodeArr = new Array(); //시험항목 수 세로 반복수
			var eqpmnClCodeNm = [];
			
			for(var i=0; i<data.length; i++){
				eqpmnClCodeArr.push(data[i].eqpmnClCodeNm);
			}
			$.each(eqpmnClCodeArr, function(i, el){// 시험항목 중복 제거 //세로반복
				if($.inArray(el, eqpmnClCodeNm) === -1) {
					eqpmnClCodeNm.push(el);
				}
			});
				
			for(var z = 0; z<eqpmnClCodeNm.length; z++){ //세로반복 구분 : 시험항목명
				
					createCnt++;
					var divId = "div_" + eqpmnClCodeNm[z]; // divId
					var canvasId = eqpmnClCodeNm[z]; // canva 아이디값
					var div = document.createElement("div"); //div
					
					
					//DIV setting 
					div.classList.add("wd100p");
					div.classList.add("mgB10");
					div.style.marginLeft = "2%";
					
					div.style.padding = "0px 0 10px 0";
					//div.style.border = "1px solid #bdbdbd";
					div.style.height = "302px";
					div.id = divId;
					
					var color = [
					"rgba("+parseInt(255)+","+parseInt(0)+","+parseInt(0)+",1)"
					,"rgba("+parseInt(255)+","+parseInt(100)+","+parseInt(0)+",1)"
					,"rgba("+parseInt(255)+","+parseInt(255)+","+parseInt(0)+",1)"
					,"rgba("+parseInt(0)+","+parseInt(255)+","+parseInt(255)+",1)"
					,"rgba("+parseInt(0)+","+parseInt(0)+","+parseInt(255)+",1)"
					,"rgba("+parseInt(100)+","+parseInt(50)+","+parseInt(255)+",1)"
					];

					console.log(color+"test");
					getEl("requestCntChart").appendChild(div);
					var canvas = document.createElement("canvas");
					//canvas.setAttribute("height", "210px");
					
					canvas.setAttribute("height", "130px");
					//canvas.style.border = "border:1px solid";
					//canvas.style.height = $("#chartHeight").val()+"px";
					canvas.id = canvasId;

					getEl(divId).appendChild(canvas); 
					
					
					var ctx = getEl(canvasId).getContext("2d"); 
					var obj = new Object();
					obj["chart"] = new Chart(ctx, {
					    type: "pie",
					    data: {
					       	labels: [], /*1분기, 2분기, 3분기, 4분기*/
					        datasets: []
							
					    },
					    options:{
							tooltips: { 
								callbacks: { label: function(tooltipItem, data) {
									var sum=0
									for(var i=0;i<data.datasets[0].data.length;i++){
										sum+=data.datasets[0].data[i]
									}
									return data.labels[tooltipItem.index]+" : "+(data.datasets[0].data[tooltipItem.index]*100/sum).toFixed(2)+"%"; 
									}, 
								}
							},
							pieceLabel: {
								mode: 'value',
								position: 'outside',
								fontColor: '#000',
								format: function (value) {
								return '$' + value;
								}
							},
							title:{
								display:true,
								text:data[0].eqpmnClCodeNm 
							},
							legend: {
								position: 'right',
								align: "center",
								labels: {
									boxWidth: 5,
									padding: 5,
									fontStyle: 'bold',
									fontColor: '#444' // label 폰트색상 grid 폰트색상과 통일
								}
							}
					    }
					});
				chartArr.push(obj);
				if(eqpmnClCodeNm[z]){
					var resultValueAvgArr = new Array(); //데이터
					var mhrlsNmArr = new Array(); //기기
					var labelsArr = new Array(); //라벨
				}
				// 큰틀  =  좌우 반복	
				//data = 
				for(var j=0; j<data.length; j++){
					var objWrapper = new Array();
					if(eqpmnClCodeNm[z] == data[j].eqpmnClCodeNm){ 
						if(data[j].division2 == "${msg.C100000413}")
						break;
							resultValueAvgArr.push(data[j].total);
							labelsArr.push(data[j].division2);
							mhrlsNmArr.push(data[j].eqpmnClCodeNm);		
					}
				}
					var valueList = [
						{
							"list" : resultValueAvgArr,
							"label" : eqpmnClCodeNm[z],
							"backgroundColor" : color
						}
					];
					
					objWrapper.push(valueList);
					//config 접근도어렵다 하... 
					var config = chartArr[(createCnt-1)]["chart"]["config"];
					
					// 전역설정. 타이틀, 반응형으로 설정.
					config.options.responsive = true;
					config.options["title"]["display"] = true;
					config.options["title"]["text"];
					config.type = "pie"; 
					
					//기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
					//datasets 라인별이라고 보면됨니다
					
					chartArr[(createCnt-1)]["chart"]["data"] = {
						"labels" : labelsArr,
						"datasets" : []
					};
					console.log(">> : ", valueList);
					//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
				 
					for(var x=0; x<valueList.length; x++){
						config["data"]["datasets"].push ({
							//"label" : valueList[x].label,
							"data" : valueList[x].list,
							"backgroundColor" : valueList[x].backgroundColor
						});   
					}
				
					// 완성된 차트는 업데이트를 시켜주면된다.
					chartArr[(createCnt-1)]["chart"].update();
				}
			
}

var acc = document.getElementsByClassName("accordion");
var i;
for (i = 0; i < acc.length; i++) {
	acc[i].addEventListener("click", function() {
		this.classList.toggle("active");
		var panel = this.nextElementSibling;
		if (panel.style.display === "block") {
			panel.style.display = "none";	
		} else {
			panel.style.display = "block";
			AUIGrid.resize(eqpmnCost);
			AUIGrid.resize(costYearGrid);
			AUIGrid.resize(capaGrid);
			gridColResize([eqpmnCost,costYearGrid,capaGrid],"2");
		}
		if (panel.style.maxHeight) {
			panel.style.maxHeight = null;
		} else {
			panel.style.maxHeight = null;
		}
	});
}
</script>
</tiles:putAttribute>
</tiles:insertDefinition>

