<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body"><%--@elvariable id="msg" type="spring"--%>

    <style>
		.ruleFloatingBar {
			margin-top: 26px;
			width:50px;
			transition-duration: 0.5s;
			position:fixed;
			right:50px;
			line-height:40px;
			text-align:center;
			z-index: 999;
		}
        .rule {
            padding: 3px;
            font-size:13px;
            font-weight: bold;
            font-family: 'Noto Sans Light', sans-serif;
            color: white;
            border-radius: 5px;
            border: 0.5px solid rgb(173, 173, 173);
            transition-property: background-color;
            transition-duration: 0.5s;
            position: relative;
        }
        .rule-tooltip {
            display: none;
            width: 220px;
            background-color: rgb(56, 56, 56);
            color: #fff;
            text-align: center;
            border-radius: 6px;
            padding: 5px 0;
            /* Position the tooltip */
            position: absolute;
            left: -223px;
            top: -55%;
            z-index: 1;
            opacity: 0.9;
			line-height: 20px;
        }
        
        .rule1 {background-color:rgb(0,128,128);}
        .rule1:hover{background-color:rgb(0, 107, 107);}
        .rule1:hover .rule-tooltip{display: block; transition: all 0.3s;}
        .rule2 {background-color:rgb(245, 67, 67);}
        .rule2:hover{background-color:rgb(219, 0, 0);}
        .rule2:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule3 {background-color:rgba(128,0,128,1);}
        .rule3:hover{background-color:rgb(92, 0, 92);}
        .rule3:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule4 {background-color:rgba(255,0,255,1);}
        .rule4:hover{background-color:rgb(216, 2, 216);}
        .rule4:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule5 {background-color:rgba(0,128,0,1);}
        .rule5:hover{background-color:rgb(0, 99, 0);}
        .rule5:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule6 {background-color:rgba(0,255,0,1);color: black;}
        .rule6:hover{background-color:rgb(0, 216, 0);}
        .rule6:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule7 {background-color:rgba(128,128,0,1);}
        .rule7:hover{background-color:rgb(88, 88, 0);}
        .rule7:hover .rule-tooltip{display: block; transition:all 0.3s;}
        .rule8 {background-color:rgba(255,255,0,1);color: black;}
        .rule8:hover{background-color:rgb(216, 216, 0);}
        .rule8:hover .rule-tooltip{display: block; transition:all 0.3s;}

        .label_span {
            font-family: 'Noto Sans Light', sans-serif;
            font-size: 12px;
            font-weight: bold;
            margin-left: 3px;
        }
        .label_span input {
            line-height: 26px;
            vertical-align: middle;
        }
    </style>

	<div class="subContent">
		<div class="subCon1">
			<form id="searchFrm" name="searchFrm" onsubmit="return false;">
				<h2>
					<i class="fi-rr-apps"></i>${msg.C100000854} <!-- 의뢰 목록 -->
				</h2>
				
				<div class="btnWrap wd40p" style="text-align: right;">

                    <span class="label_span" style="display: none">
                        <input type="checkbox" id="chart-general" name="chart-checkbox" data-type="RESULT_VALUE" title="체크시 일반 Chart 출력" checked>
                        <label for="chart-general" class="label_span">일반</label>
                    </span>

<%--                    <span class="label_span">--%>
<%--                        <input type="checkbox" id="chart-xr" name="chart-checkbox" data-type="XR_RESULT_VALUE" title="체크시 XR 관리도 Chart 출력" >--%>
<%--                        <label for="chart-xr" class="label_span">XR 관리도</label>--%>
<%--                    </span>--%>

					<span class="label_span" style="margin-left: 10px;"> ${msg.C100000852} :  </span>
					<input type="text" id ="chartHeight" class="numChk chart" style="width: 50px;" value = 450>

					<button type="button" id="btnSearch" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
					<input type="hidden" id="btnIssueList">
				</div>
				<table class="subTable1">
					<colgroup>
						<col style="width:10%"/> 
						<col style="width:15%"/>
						<col style="width:10%"/>
						<col style="width:15%"/>
						<col style="width:10%"/>
						<col style="width:15%"/>
						<col style="width:10%"/>
						<col style="width:15%"/>
					</colgroup>
					<tr>
						<th>${msg.C100000139}</th> <!-- 검사 유형 -->
						<td><select id="inspctTyCodeSch" name="inspctTyCodeSch"></select></td>
						<th class="necessary">${msg.C100000716}</th> <!-- 자재 코드 -->
						<td><select id = "mtrilSeqnoSch" name = "mtrilSeqnoSch"  style="width: 100%;" required></select></td>
<!-- 						<td><input type= "text" id = mtrilSeqnoSch" name = "mtrilSeqnoSch" value = "3108"></td>   -->
						<th class="necessary">${msg.C100000803}</th> <!-- 제조 일자 -->
						<td>
							<input type="text" id="mnfcturBeginDte" name="mnfcturBeginDte" class="dateChk schClass wd6p" style="min-width: 6em;" autocomplete="off" required>
	                        ~
	                        <input type="text" id="mnfcturEndDte" name="mnfcturEndDte" class="dateChk schClass wd6p" style="min-width: 6em;" autocomplete="off" required>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>${msg.C100000587}</th> <!-- 업체 -->
						<td>
							<input type="text" id="entrpsNmSch" name="entrpsNmSch" class="wd63p" readonly>
							<button type="button" id="entrpsSearch" class="inTableBtn inputBtn btn5"><img src="${pageContext.request.contextPath}/assets/image/btnSearch.png"></button> <!-- 찾기 -->
							<button type="button" id="entrpsReset" class="inTableBtn inputBtn btn5"><img src="${pageContext.request.contextPath}/assets/image/close14.png"></button> <!-- 초기화 --> 
							<input type="hidden" id="entrpsSeqnoSch" name="entrpsSeqnoSch">
						</td>
<%--						<th>${msg.C100001052}</th> <!-- 협력사 여부 -->--%>
<%--						<td style="text-align:left;">--%>
<%--							<label><input type="radio" id="coa_ysch" name="coaAtSch" value="Y" >${msg.C100000779}</label> <!-- 전체 -->--%>
<%--							<label><input type="radio" id="coa_nsch" name="coaAtSch" value="N"  checked>${msg.C100000442}</label> <!-- 사용안함 -->--%>
<%--						</td>--%>
						<th>${msg.C100001053}</th>
						<td style="text-align:left;">
							<label><input type="radio" id="qc_ysch" name="qcAtSch" value="false" checked>${msg.C100001054}</label> <!-- 전체 -->
							<label><input type="radio" id="qc_nsch" name="qcAtSch" value="true" >${msg.C100001055}</label> <!-- 사용안함 -->
						</td>
						<td colspan="2"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
					</tr>
				</table>
			</form>
			<div class="ruleFloatingBar">
				<label class="rule1 rule">Rule_1<span class="rule-tooltip">1개의 Point가 [ n ] sigma를 벗어난다.</span></label>
				<label class="rule2 rule">Rule_2<span class="rule-tooltip">[ n ]개의 Point가 중심선(CL)로부터 같은쪽에 있다.</span></label> 
				<label class="rule3 rule">Rule_3<span class="rule-tooltip">연속된 [ n ]개의 Point가 지속 상승 또는 하락한다.</span></label> 
				<label class="rule4 rule">Rule_4<span class="rule-tooltip">[ n ]개의 Point가 교대로 상승 또는 하락한다.</span></label> 
				<label class="rule5 rule">Rule_5<span class="rule-tooltip">[ n+1 ]개의 Point 중에서 [ n ]개의 Point가 중심선(CL)로부터 2 Sigma 범위 밖에 있음. (한쪽)</span></label> 
				<label class="rule6 rule">Rule_6<span class="rule-tooltip">[ n+1 ]개의 Point 중에서 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 밖에 있음. (한쪽)</span></label> 
				<label class="rule7 rule">Rule_7<span class="rule-tooltip">연속된 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 내에 있음. (양쪽)</span></label> 
				<label class="rule8 rule">Rule_8<span class="rule-tooltip">연속된 [ n ]개의 Point가 중심선(CL)로부터 1 Sigma 범위 밖에 있음. (양쪽)</span></label>
			</div>
			<div id="chartParents" class="subCon1 mgT15" style="clear:both; display:flex; flex-wrap:wrap;">
			<!-- 차트 출력 -->
			</div>
			<input type="hidden" id = "chatValueHidden">
			<input type="hidden" id = "chartLotNo">
		</div>
	</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script"><%--@elvariable id="UserMVo" type="lims.sys.vo.UserMVo"--%>
<%--@elvariable id="msg" type="spring"--%>
<script>

/**
 * 
 * Chart Support Class입니다.
 * 
 * @aushor shs
 */
function ChartSupport(){

    this.exprList = [];
	this.basicWidth = 92;

    /* spc rule Colors */
    this.RULE_1_COLOR = 'rgba(0,128,128,1)';
    this.RULE_2_COLOR = 'rgb(245, 67, 67)';
    this.RULE_3_COLOR = 'rgba(128,0,128,1)';
    this.RULE_4_COLOR = 'rgba(255,0,255,1)';
    this.RULE_5_COLOR = 'rgba(0,128,0,1)';
    this.RULE_6_COLOR = 'rgba(0,255,0,1)';
    this.RULE_7_COLOR = 'rgba(128,128,0,1)';
    this.RULE_8_COLOR = 'rgba(255,255,0,1)';

    this.getExprList = function(){
        var checkedTypes = this.getCheckedTypes();
	    if (checkedTypes.length === 0) {
		    throw new Error('체크된 ResultValueType이 없습니다.');
			return;
	    }
	    return this.exprList.filter(function (expr) {
	        return checkedTypes.indexOf(expr.resultValueType) !== -1; // 체크 되어있는 type만 골라냄
        });
    }

    // set chart data
    this.setExprList = function(exprList){
        this.exprList = exprList;
    }

    // chart parent div reset
    this.reset = function(){
        document.querySelector('#chartParents').innerHTML = "";
    }

    // 활성화 되어있는 chart type의 갯수에 따라 chart 너비 계산해서 return
    this.getCalcWidth = function(){
        return (this.basicWidth / this.getCheckedTypes().length) + "%";
    }

    // 현재 체크 되어있는 type 반환
    this.getCheckedTypes = function(){
        var checkedTypes = [];
        var chartCheckboxes = document.querySelectorAll('input[name=chart-checkbox]');
        for (var i = 0; i < chartCheckboxes.length; i++) {
            var checkbox = chartCheckboxes[i];

            // 체크 되어있으면 push
            if( checkbox.checked ){
                checkedTypes.push(checkbox.getAttribute("data-type"))
            }
        }
        return checkedTypes;
    }

    // chart 생성
    this.chartSupportBuildChart = function(){
	    if (searchFormEl.querySelector('#chartHeight').value < 450) {
		    warn("${msg.C100001056}"); //차트의 높이가 450보다 작을수 없습니다.
            return false;
	    }
        buildChart(this.getExprList());
    }
}

var chartSupport = new ChartSupport();
var lang = ${msg};
var searchFrm = "searchFrm";
var selectReqSeqno;
var searchFormEl = document.querySelector('#searchFrm');
$(function() {
	getAuth(); //권한 체크
	
	setCombo();
	
	setButtonEvent();
	
	setPopUp();
});
</script>

<script>

function setCombo(){
	ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true, null);
	ajaxSelect2Box({
        ajaxUrl         : '/qa/getMtrilNmCombo.lims'
        ,elementId      : 'mtrilSeqnoSch'
        ,ajaxParam      : {
			"bplcCode" : "${UserMVo.bestInspctInsttCode}"
		}
    });
	
	datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-30], ["DD",0]);//제조일자 조회조건
}


//버튼 이벤트
function setButtonEvent(){
	
	searchFormEl.addEventListener('click', function (e) {
		if (e.target.nodeName === "INPUT") {
			if (e.target.type === "checkbox" && e.target.name === "chart-checkbox") {
				// chart rebuild
				chartSupport.chartSupportBuildChart();
			}
		} else if (e.target.nodeName === "BUTTON" && e.target.classList.contains('search')) {
			createChart();
		}
	});
	
	searchFormEl.addEventListener('keypress', function (e) {
		if (e.target.classList.contains('chart') && e.key === 'Enter' && e.target.id === 'chartHeight') {
			// chart rebuild
			chartSupport.chartSupportBuildChart();
		}
	});

	$("#bplcCodeSch").change(function(){
		ajaxSelect2Box({
	        ajaxUrl         : '/qa/getMtrilNmCombo.lims'
	        ,elementId      : 'mtrilSeqnoSch'
	        ,ajaxParam      : {
				"bplcCode" : $("#bplcCodeSch").val()
			}
	    });
	});
	
	$('#resetBtn').click(function(){
		$("#entrpsSearch").val("");
		$("#entrpsNmSch").val("");
		$("#entrpsSeqnoSch").val("");
		
	});
	
	// 업체 팝업 input reset 버튼
	$("#entrpsReset").click(function(){
		dialogReset(this.id);
	});

    // 차트종류 checkbox event
    document.querySelector('#searchFrm').addEventListener('click',function(e){
        if(e.target.nodeName === "INPUT"){
            if(e.target.type === "checkbox" && e.target.name === "chart-checkbox"){
                // chart rebuild
                chartSupport.chartSupportBuildChart();
            }
        }
    });
}

function setPopUp(){
	dialogEntrps("entrpsSearch",null, "entrpsDialog", function(data) {
		$("#entrpsNmSch").val(data["entrpsNm"]);
		$("#entrpsSeqnoSch").val(data["entrpsSeqno"]);
	}, null);
	
	
	
	dialogChartValue("chatValueHidden", "chatValue")
}

function createChart(){
	
	if (!saveValidation(searchFormEl.id)) {
		return false;
	}
	
	if ($("#chartHeight").val() < 450) {
		warn("${msg.C100001056}"); //차트의 높이가 450보다 작을수 없습니다.
		return false;
	}
	
	customAjax({
		url :'/src/getDataChartList.lims',
		data : $("#searchFrm").serializeObject(),
		successFunc : function(exprList){

            // chart support class에 exprList set
            chartSupport.setExprList(exprList);

            // chart build
            chartSupport.chartSupportBuildChart();
		}
	})	
}

function buildChart(exprList){

    //재조회시 차트 리셋
    chartSupport.reset();

    console.log(">> exprList : " , exprList);
    //기초 데이터 생성용 변수 생성
    //얘는 데이터 목록	
    var createCnt = 0; //만들어진 차트 갯수 
    var chartArr = [];// 차트 갯수
    var flagArr = []; //가로줄 몇개인지 체크
    var flagNames =[]; //가로줄 구분
    var expriemArr = []; //시험항목 수 세로 반복수
    var expriemNm = [];
    
	var bum = ($("[name=qcAtSch]:checked").val() === "false") ? ["Value","UCL","LCL"] : ["QC_VALUE","UCL","LCL"]; 
            
    for(var i=0; i<exprList.length; i++){
        flagArr.push(exprList[i].resultValueType);
        expriemArr.push(exprList[i].expriemNm);
    }
    $.each(flagArr, function(i, el){ //flag 중복제거 //가로반복
        if($.inArray(el, flagNames) === -1) {
            flagNames.push(el);
        }
    });
    $.each(expriemArr, function(i, el){// 시험항목 중복 제거 //세로반복
        if($.inArray(el, expriemNm) === -1) {
            expriemNm.push(el);
        }
    });

    for(var z = 0; z<expriemNm.length; z++){ //세로반복 구분 : 시험항목명
        
        for(var i=0; i<flagNames.length; i++){ //FLAG = (2); 123 일단 세가지 FLAG구분
            createCnt++;
            var divId = "div_" + expriemNm[z]+flagNames[i]; // divId
            var canvasId = expriemNm[z]+flagNames[i]; // canva 아이디값
            var div = document.createElement("div"); //div
            
            if(i===0 && $("[name=coaAtSch]:checked").val() === "Y"){//xr 관리도가 아니면서 협력사 여부가 'Y'일 경우
                bum.push("${msg.C100001057}");
            }

            //DIV setting 
            div.style.width = chartSupport.getCalcWidth(); // 계산된 chart width get
            div.classList.add("mgT15");
            div.style.marginLeft = "2%";
            
            div.style.padding = "15px 0";
            div.style.border = "1px solid";
            div.style.height = $("#chartHeight").val()+"px";
            div.id = divId;
            
            getEl("chartParents").appendChild(div);
            var canvas = document.createElement("canvas");
            canvas.id = canvasId;
            getEl(divId).appendChild(canvas); 

            var ctx = getEl(canvasId).getContext("2d"); 

            var obj = {};
            var titleText = "";
            if(flagNames[i] === 'XR_RESULT_VALUE'){
                titleText = "${msg.C100001120}("+$("#mtrilSeqnoSch option:checked").text()+' '+expriemNm[z]+')';
            }
            else titleText = $("#mtrilSeqnoSch option:checked").text()+' '+expriemNm[z];
            
            obj["chart"] = new Chart(ctx, {
                type: "line",
                data: {
                    labels: [], 
                    datasets: []
                },
                options: {
                    tooltips: {
                        callbacks: {
                            // Tooltip footer 설정
                            footer: function(tooltipItem, chart) {

								// 결과값 point에만 적용
                                if(tooltipItem[0].datasetIndex === 0) {
									var pointIndex = tooltipItem[0].index;              // 포인트 index
									var point = chart.datasets[0].pointBackgroundColor; // 포인트 color

									/* 포인트 갯수만큼 반복문 돌려서 
										index별로 위배되는 Rule 색상 매칭되면 해당 Rule 푸터로 표시 */
									for(var i=0; i < point.length; i++) {
										if(point[pointIndex] === chartSupport.RULE_1_COLOR) {
											return "Rule_1";
										}else if(point[pointIndex] === chartSupport.RULE_2_COLOR) {
											return "Rule_2";
										}else if(point[pointIndex] === chartSupport.RULE_3_COLOR) {
											return "Rule_3";
										}else if(point[pointIndex] === chartSupport.RULE_4_COLOR) {
											return "Rule_4";
										}else if(point[pointIndex] === chartSupport.RULE_5_COLOR) {
											return "Rule_5";
										}else if(point[pointIndex] === chartSupport.RULE_6_COLOR) {
											return "Rule_6";
										}else if(point[pointIndex] === chartSupport.RULE_7_COLOR) {
											return "Rule_7";
										}else if(point[pointIndex] === chartSupport.RULE_8_COLOR) {
											return "Rule_8";
										}
									}
								}
                            }
                        }
                    },
                    
                    responsive: true,
                    maintainAspectRatio : false,
                    title: {
                        display: true,
                        text: titleText,
                        position : 'top'
                    },
                    zoom: {
                        enabled: true,
                        mode: 'y',
                    },
                    legend: {
                        display: true
                    },
                    onClick: function(c,i) {
                        if(i.length>0){
                            var e = i[0];
							var sploreNm = this.data.labels[e._index];
							selectReqSeqno = sploreNm.slice(sploreNm.indexOf('-') + 1); //x축 값 : 현재 눌리
	                        $("#chatValueHidden").click();
                        }
                    }
                }
            });
        
            chartArr.push(obj);
            
            var resultValueAvgArr = []; // resultValue 데이터
            var venderResultValueAvgArr = []; // venderResultValue 데이터
            var lclValueAvgArr = []; // lclValue 데이터
            var ucLValueAvgArr = []; // ucLValue 데이터
            var badSploreNames = []; // badSploreNames 데이터
            var sploreNames = []; //라벨
            var ruleCode = []; //라벨
            var violatList = []; //라벨
	        
            // 큰틀  =  좌우 반복	
            //exprList = 
            for(var j=0; j<exprList.length; j++){
                if(expriemNm[z] === exprList[j]["expriemNm"]){//시험항목이 같은 것들끼리 한줄에 먼저 출력
                    if(flagNames[i] === exprList[j]["resultValueType"]){ //xr / 일반 관리도
                        
                        if(exprList[j]["resultValueType"]==='RESULT_VALUE'){ //일반
                            if($("[name=qcAtSch]:checked").val() === "false") {
                                resultValueAvgArr = exprList[j].resultValues;
                            } else {
                                resultValueAvgArr = exprList[j].qcResultValues;
                            }
                            lclValueAvgArr = exprList[j].lclValues;
                            ucLValueAvgArr = exprList[j].uclValues;
                        } else { //xr-관리도
                            if($("[name=qcAtSch]:checked").val() === "false") {
                                resultValueAvgArr = exprList[j].xrValues;
                            } else {
                                resultValueAvgArr = exprList[j].qcXrValue;
                            }
                            lclValueAvgArr = exprList[j].xrLclValues;
                            ucLValueAvgArr = exprList[j].xrUclValues;
                        }
                        if(i===0 && $("[name=coaAtSch]:checked").val() === "Y"){
                            venderResultValueAvgArr = exprList[j].venderResultValues;
                        }

	                    sploreNames = exprList[j].sploreNames;
						
                        if(!!exprList[j].violateRules){
                            for(var zu =0; zu<exprList[j].violateRules.length; zu++){
	                            badSploreNames.push(exprList[j].violateRules[zu].badSploreNames);
                                ruleCode.push(exprList[j].violateRules[zu].spcRuleCode)
                            }
                            
                            violatList = exprList[j].violateRules;
                        }
                    }
                }
            }

            var valueList = [
                {
                    list : resultValueAvgArr,
                    violatList : violatList,
                    label : bum[0],
	                badSploreNames : badSploreNames,
	                sploreNames : sploreNames,
                    ruleCode : ruleCode,
                    fill : false,
                    borderWidth : 1,
                    pointRadius: 5,
                    borderColor : 'rgb(117,117,253)',
                },
                {
                    list : ucLValueAvgArr,
                    violatList : violatList,
                    label : bum[1],
	                badSploreNames : badSploreNames,
	                sploreNames : sploreNames,
                    ruleCode : ruleCode,
                    fill : false,
                    borderWidth : 1,
                    pointRadius: 0,
                    borderColor : 'rgb(255,100,0)',
                },
                {
                    list : lclValueAvgArr,
                    violatList : violatList,
                    label : bum[2],
	                badSploreNames : badSploreNames,
	                sploreNames : sploreNames,
                    ruleCode : ruleCode,
                    fill : false,
                    borderWidth : 1,
                    pointRadius: 0,
                    borderColor : 'rgb(255,0,100)',
                },
            ];
            
            
            if(i===0 && $("[name=coaAtSch]:checked").val() === "Y") {
	            valueList.push({
		            list: venderResultValueAvgArr,
		            violatList: violatList,
		            label: bum[3],
		            badSploreNames: badSploreNames,
		            sploreNames: sploreNames,
		            ruleCode: ruleCode,
		            fill: false,
		            borderWidth: 1,
		            pointRadius: 5,
		            borderColor: 'rgb(255,100,200)',
	            });
            }
            //config 접근도어렵다 하... 
            var config = chartArr[(createCnt-1)]["chart"]["config"];
            
            // 전역설정. 타이틀, 반응형으로 설정.
            config.options.responsive = true;
            config.options["title"]["display"] = true;
            config.options["title"]["text"];
            
            ticksMaxMinSetup(valueList,config)
            
            config.type = "line"; 
            
            //기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
            //datasets 라인별이라고 보면됨니다
            
            chartArr[(createCnt-1)]["chart"]["data"] = {
                "labels" : sploreNames,
                "datasets" : []
            };

            //라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
            for(var x=0; x<valueList.length; x++){
                config["data"]["datasets"].push ({
                    label : valueList[x].label,
                    violatList : valueList[x].violatList,
                    data : valueList[x].list,
                    fill : valueList[x].fill,
                    borderColor : valueList[x].borderColor,
                    badSploreNames : valueList[x].badSploreNames,
                    ruleCode : valueList[x].ruleCode,
	                sploreNames : valueList[x].sploreNames,
                    pointRadius: valueList[x].pointRadius,
                    pointBackgroundColor : getBackgroundColorArr(valueList[x]),
                    lineTension: 0
                });
            }
            // 완성된 차트는 업데이트를 시켜주면된다.
            chartArr[(createCnt-1)]["chart"].update();
        }
    }
}

// chart point color 배열을 만들어준다. 
function getBackgroundColorArr(line){

    // xr관리도, 일반차트 두개의 차트 모두 결과값, Qc결과값 line만 color 배열을 만든다.
    if( !(line.label === "Value" || line.label === "QC_VALUE") ){
        return;
    }

    var sploreNames = line.sploreNames;        // 전체 lot목록
    var violatList = line.violatList;   // 위반목록

    var colors = sploreNames.map(function(lot){

        var color = "";
        for (var i = 0; i < violatList.length; i++) {

            var violateRule = violatList[i]; // 위반된 rule
            var isPresent = violateRule.badSploreNames.indexOf(lot) !== -1; // 위반된 목록에 현재 lot가 있는지 ? 
            var spcRuleCode = violateRule.spcRuleCode; // 위반된 spc rule code

            if( isPresent && spcRuleCode === "SY04000001") { // rule 1
                color = chartSupport.RULE_1_COLOR;
            }
            
            if( isPresent && spcRuleCode === "SY04000002") { // rule 2
                color = chartSupport.RULE_2_COLOR;
            }
            
            if( isPresent && spcRuleCode === "SY04000003") { // rule 3
                color = chartSupport.RULE_3_COLOR;
            }
            
            if(  isPresent && spcRuleCode === "SY04000004") { // rule 4
                color = chartSupport.RULE_4_COLOR;
            }
            
            if( isPresent && spcRuleCode === "SY04000005") { // rule 5
                color = chartSupport.RULE_5_COLOR;
            }
            
            if( isPresent && spcRuleCode === "SY04000006") { // rule 6
                color = chartSupport.RULE_6_COLOR;
            }
            
            if( isPresent && spcRuleCode === "SY04000007") { // rule 7
                color = chartSupport.RULE_7_COLOR;
            }

            if( isPresent && spcRuleCode === "SY04000008") { // rule 7
                color = chartSupport.RULE_8_COLOR;
            }
        }
        return color;
    });

    return colors;
}

function ticksMaxMinSetup(valueList,config){
	var min = [];
	var max = [];
	
	var dataMin = [];
	var dataMax = [];
	
	var chartMin = "";
	var chartMax = "";
	
	for(var i=0; i<valueList.length; i++){
		
		min.push(Math.min.apply(null,valueList[i].list));
		max.push(Math.max.apply(null,valueList[i].list));
		
	}
	
	dataMin = Math.min.apply(null,min);
	dataMax = Math.max.apply(null,max);
	
	chartMax = (dataMax+(dataMax-dataMin)*0.1);
	chartMin = (dataMin-(chartMax-dataMin)*0.1);

	config.options["scales"]["yAxes"] = [{
		ticks: {
			min: chartMin,
			max: chartMax
		},
	}];

	config.options["scales"]["xAxes"] = [{
		ticks: {
			callback: function (tick) {
				if (!!tick) {
					return tick.slice(0, tick.indexOf('-'));
				}
			}
		},
	}];
}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>
