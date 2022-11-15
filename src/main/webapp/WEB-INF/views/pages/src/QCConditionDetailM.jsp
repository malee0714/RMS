<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body"><%--@elvariable id="msg" type="spring"--%>

        <div class="subContent">
            <div class="subCon1">
                <form id="searchFrm" name="searchFrm" onsubmit="return false;">
                    <h2>
                        <i class="fi-rr-apps"></i>건수 <!-- 의뢰 목록 -->
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
                            <th >${msg.C100000803}</th> <!-- 제조 일자 -->
                            <td>
                                <input type="text" id="mnfcturBeginDte" name="mnfcturBeginDte" class="dateChk schClass wd6p" style="min-width: 6em;" autocomplete="off" >
                                ~
                                <input type="text" id="mnfcturEndDte" name="mnfcturEndDte" class="dateChk schClass wd6p" style="min-width: 6em;" autocomplete="off" >
                            </td>
                            <th>제품 구분</th> <!-- 자재 코드 -->
                            <td><select id = "prductSeCodeSch" name = "prductSeCodeSch"  style="width: 100%;" ></select>
                                <input type="hidden" id="hiddenPrductSeCode" name="hiddenPrductSeCode"></td>
                            <th>${msg.C100000139}</th> <!-- 검사 유형 -->
                            <td><select id="inspctTyCodeSch" name="inspctTyCodeSch"></select></td>
                            <!-- 						<td><input type= "text" id = mtrilSeqnoSch" name = "mtrilSeqnoSch" value = "3108"></td>   -->
                            <th >분석실</th> <!-- 자재 코드 -->
                            <td><select id = "custlabSeqnoSch" name = "custlabSeqnoSch"  style="width: 100%;" ></select></td>
                        </tr>
                        <tr>
                            <th class="necessary">제품 명</th> <!-- 업체 -->
                            <td>
                                <input type="text" id="mtrilNmSch" name="mtrilNmSch" class="wd63p" readonly required>
                                <input type="hidden" name="mtrilSeqno" id="mtrilSeqno"  />
                                <button type="button" id="btnPrductSearch" class="inTableBtn inputBtn"><img src="/assets/image/btnSearch.png"></button> <!-- 찾기 -->
                                <button type="button" id="btnPrductReset" class="inTableBtn inputBtn btn5"><img src="/assets/image/close14.png"></button> <!-- 초기화 -->

                            </td>
                            <td colspan="2"></td><!-- 나머지 여백맞추기위한 추가 explorer -->
                        </tr>
                    </table>
                </form>
            </div>

        <div class="subCon2 mgT15">
            <div style="display:flex">
                <div class="wd100p mgT15" style= order:1;" >
                    <div id="qcconditionDetailList" class="wd100p" style="height:300px;"></div>
                </div>
            </div>
        </div>
        </div>
        <div class="subCon2 mgT15">
        <div style="display:flex">
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
                        return checkedTypes.indexOf(expr.lclValue) == -1; // 체크 되어있는 type만 골라냄
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
                    createCharts(this.getExprList());
                }
            }

            var chartSupport = new ChartSupport();
            var qcconditionDetailList = "qcconditionDetailList";
            var lang = ${msg};
            var searchFrm = "searchFrm";
            var selectSploreName = "";
            var searchFormEl = document.querySelector('#searchFrm');
            var sessionObj = {
                bestInspctInsttCode : "${UserMVo.bestInspctInsttCode}",
                deptCode : "${UserMVo.deptCode}"
            };
            $(function() {
                getAuth(); //권한 체크

                setCombo();

                setGrid();

                setButtonEvent();

                setPopUp();
            });
        </script>

        <script>

            function setCombo(){
                ajaxJsonComboBox("/com/getCmmnCode.lims", "inspctTyCodeSch", {"upperCmmnCode" : "SY07"}, true, null);
                ajaxJsonComboTrgetName({url : '/rsc/getCustlabCombo.lims', name : 'custlabSeqnoSch', selectFlag : true});
                ajaxJsonComboBox('/com/getCmmnCode.lims', "prductSeCodeSch",{ "upperCmmnCode" : "SY20" }, true).then(function() { //자재 유형
                    $('#prductSeCodeSch').val(item.prductSeCode);
                    $('#prductSeCodeSch option').not(':selected').prop('disabled',!('${UserMVo.authorSeCode}' == 'SY09000001' || '${UserMVo.authorSeCode}' == 'SY09000002'));
                });

                ajaxSelect2Box({
                    ajaxUrl         : '/qa/getMtrilNmCombo.lims'
                    ,elementId      : 'mtrilSeqnoSch'
                    ,ajaxParam      : {
                        "bplcCode" : "${UserMVo.bestInspctInsttCode}"
                    }
                });

                datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["YY",-1], ["DD",0]);//제조일자 조회조건
            }

            //자재 찾기 팝업
            dialogMtril('btnPrductSearch', "RequestM", 'Product', null, function(data) {
                var item=data[0];
                $('#mtrilSeqno').val(item.mtrilSeqno);
                $('#mtrilNmSch').val(item.mtrilNm);
                $('#prductSeCodeSch').val(item.prductSeCode);
                $('#hiddenPrductSeCode').val(item.prductSeCode);
                /* 자재에 따른 설비구분콤보 생성 */
            },sessionObj,false,true);

            function setGrid(){
                var col = [];

                auigridCol(col);

                col.addColumnCustom("prop", "구분", "*" ,true); /* 구분 */

                var cusPros = {
                    editable : false, // 편집 가능 여부 (기본값 : false)
                    selectionMode : "multipleCells",// 셀 선택모드 (기본값: singleCell)
                    enableCellMerge : true,
                    showRowNumColumn : false
                }

                //auiGrid 생성
                qcconditionDetailList = createAUIGrid(col, "qcconditionDetailList", cusPros);

                // 그리드 칼럼 리사이즈
                AUIGrid.bind(qcconditionDetailList, "ready", function(event) {
                    gridColResize([qcconditionDetailList],"2");	// 1, 2가 있으니 화면에 맞게 적용
                });

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
                        if(!saveValidation ("searchFrm")){
                            //console.log(">>>>> : 통과 못함" , saveValidation ("rgntCmpdsFrm"));
                            return false;
                        }else{
                            createChart();

                        }
                    }
                });

                searchFormEl.addEventListener('keypress', function (e) {
                    if (e.target.classList.contains('chart') && e.key === 'Enter' ) {
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

                $("#prductSeCodeSch").change(function (event){
                    $("#hiddenPrductSeCode").val(event.target.selectedOptions[0].value);
                });

                $('#resetBtn').click(function(){
                    $("#entrpsSearch").val("");
                    $("#mtrilNmSch").val("");
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
                    $("#mtrilNmSch").val(data["entrpsNm"]);
                    $("#entrpsSeqnoSch").val(data["entrpsSeqno"]);
                }, null);



                dialogChartValue("chatValueHidden", "chatValue")
            }

            function createChart(){

                customAjax({
                    url :'/src/getQcconditionDetailList.lims',
                    data : $("#searchFrm").serializeObject(),
                    successFunc : function(exprList){

                        setGridData(qcconditionDetailList,exprList)
                        // chart support class에 exprList set

                    }
                })
                customAjax({
                    url: '/src/getQcconditionDetailData.lims',
                    data: $("#searchFrm").serializeObject(),
                    successFunc: function (exprList) {
                        chartSupport.setExprList(exprList);
                        // chart build
                        chartSupport.chartSupportBuildChart();
                    }
                })

            }


            function setGridData(grid,data,type) {
                AUIGrid.destroy(grid);
                setGrid()
                var item = [{ "prop" : "Spec"},{ "prop" : "Unit"},{ "prop" : "Average"},{ "prop" : "STD Deviation"},{ "prop" : "Analytical times"},
                    { "prop" : "Confidence (95%)"},{ "prop" : "Cpk"},{ "prop" : "3Sigma Level"}]
                AUIGrid.addRow(grid, item, "last");
                var Spec = {};
                var unit = {};
                var avge = {};
                var stdDev = {};
                var analytical = {};
                for(var i=0;i<data.length;i++) {
                    var dataFieldData = data[i].expriemNm;
                    AUIGrid.addColumn(grid, {dataField: dataFieldData}, "last");
                    Spec[dataFieldData] = data[i].spec;
                    unit[dataFieldData] = data[i].unitNm;
                    avge[dataFieldData] = data[i].avgValue;
                    stdDev[dataFieldData] = data[i].stdDev;
                    analytical[dataFieldData] = data[i].analytical;
                }


                AUIGrid.updateRow(grid, Spec, 0);
                AUIGrid.updateRow(grid, unit, 1);
                AUIGrid.updateRow(grid, avge, 2);
                AUIGrid.updateRow(grid, stdDev, 3);
                AUIGrid.updateRow(grid, analytical, 4);

            }


            function createCharts(data){
                chartSupport.reset();

                console.log(">> data : " , data);
//				//기초 데이터 생성용 변수 생성
//				//얘는 데이터 목록
                var createCnt = 0; //만들어진 차트 갯수
                var chartArr = new Array();// 차트 갯수
                var eqpmnClCodeArr = new Array(); //시험항목 수 세로 반복수
                var expriemNm = [];

                for(var i=0; i<data.length; i++){
                    if(data[i].sploreNm != null)
                    eqpmnClCodeArr.push(data[i].expriemNm);
                }
                $.each(eqpmnClCodeArr, function(i, el){// 시험항목 중복 제거 //세로반복
                    if($.inArray(el, expriemNm) === -1) {
                        expriemNm.push(el);
                    }
                });

                for(var z = 0; z<expriemNm.length; z++){ //세로반복 구분 : 시험항목명

                    createCnt++;
                    var divId = "div_" + expriemNm[z]; // divId
                    var canvasId = expriemNm[z]; // canva 아이디값
                    var div = document.createElement("div"); //div


                    //DIV setting
                    div.classList.add("wd100p");
                    div.classList.add("mgB10");
                    div.style.marginLeft = "2%";

                    div.style.padding = "20px 20px 0px 0px";
                    //div.style.border = "1px solid #bdbdbd";
                    div.style.height = "400px";
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
                    getEl("chartParents").appendChild(div);
                    var canvas = document.createElement("canvas");
                    //canvas.setAttribute("height", "80px");

                    canvas.setAttribute("height", "80px");
                    //canvas.style.border = "border:1px solid";
                    canvas.style.height = "100px";
                    canvas.id = canvasId;

                    getEl(divId).appendChild(canvas);


                    var ctx = getEl(canvasId).getContext("2d");
                    var obj = new Object();
                    obj["chart"] = new Chart(ctx, {
                        type: "scatter",
                        data: {
                            labels: [{}], /*1분기, 2분기, 3분기, 4분기*/
                            datasets: [{}]

                        },
                        options:{
                            scales: {
                                xAxes:[{
                                        ticks: {
                                            stepSize: 1
                                        }
                                    }
                                ]},
                                responsive: true,
                                plugins: {
                                    legend: {
                                        position: 'top',
                                    }
                                },
                            tooltips: {
                                callbacks: { label: function(tooltipItem, data) {
                                        var sum=0
                                        for(var i=0;i<data.datasets[0].data.length;i++){
                                            sum+=parseInt(data.datasets[0].data[i])
                                        }
                                        return data.labels[tooltipItem.index]+" : "+data.datasets[0].data[tooltipItem.index].x+","+data.datasets[0].data[tooltipItem.index].y;
                                    },
                                }
                            }

                        }
                    });
                    chartArr.push(obj);
                    if(expriemNm[z]){
                        var resultValueAvgArr = new Array(); //데이터
                        var mhrlsNmArr = new Array(); //기기
                        var labelsArr = new Array(); //라벨
                    }
                    // 큰틀  =  좌우 반복
                    //data =
                        for (var j = 0; j < data.length; j++) {
                            if (expriemNm[z] == data[j].expriemNm) {
                                if(data[j].sploreNm !=null) {
                                    resultValueAvgArr.push({y: data[j].resultValue, x: data[j].mnfcturDte});
                                    labelsArr.push(data[j].sploreNm);
                                    mhrlsNmArr.push(data[j].expriemSeqno);
                                }
                            }
                        }
                        var valueList = [
                            {
                                "list" : resultValueAvgArr,
                                "label" : expriemNm[z],
                                "backgroundColor" : color[5],
                                "borderColor" : color[2]
                            }
                        ];



                    //config 접근도어렵다 하...
                    var config = chartArr[(createCnt-1)]["chart"]["config"];

                    // 전역설정. 타이틀, 반응형으로 설정.
                    config.options.responsive = true;
                    config.options["title"]["display"] = true;
                    config.options["title"]["text"];
                    config.type = "scatter";

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
                            "label" : valueList[x].label,
                            "data" : valueList[x].list,
                            "backgroundColor" : valueList[x].backgroundColor,
                            "borderColor" : valueList[x].backgroundColor,
                            "fill" : false
                        });
                    }

                    // 완성된 차트는 업데이트를 시켜주면된다.
                    chartArr[(createCnt-1)]["chart"].update();
                }

            }

        </script>
        <!--  script 끝 -->
    </tiles:putAttribute>
</tiles:insertDefinition>
