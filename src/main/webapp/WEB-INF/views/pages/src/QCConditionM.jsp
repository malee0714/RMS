<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">

    <tiles:putAttribute name="script">
        <script>
            var receiptCntList = "receiptCntList";
            var receiptCntList = "receiptCntList2";
            var receiptCntList = "receiptCntList3";
            var receiptCntList = "receiptCntList4";
            var receiptCntChart;
            var dateSchtype;
            var receiptCntPie =[];
            $(document).ready(function(){
                getAuth();

                //초기세팅
                init();

                //콤보 박스 초기화
                setCombo();

                //차트 생성
                createChart();

                //담당 팁별 접수 건수 그리드 세팅
                setReceiptListGrid();

                //버튼 이벤트 선언
                setButtonEvent();


            });
            //초기세팅
            function init(){
                //달력 의뢰일자
                datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["MM",-2], ["MM",0]);
            }

            //콤보 박스 초기화
            function setCombo(){

            }

            //담당 팁별 접수 건수 그리드 세팅
            function setReceiptListGrid(){
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
                receiptCntList = createAUIGrid(col, "receiptCntList", cusPros);
                receiptCntList2 = createAUIGrid(col, "receiptCntList2", cusPros);
                receiptCntList3 = createAUIGrid(col, "receiptCntList3", cusPros);
                receiptCntList4 = createAUIGrid(col, "receiptCntList4", cusPros);

                // 그리드 칼럼 리사이즈
                AUIGrid.bind(receiptCntList, "ready", function(event) {
                    gridColResize([receiptCntList],"2");	// 1, 2가 있으니 화면에 맞게 적용
                });
            }

            //버튼 이벤트 선언
            function setButtonEvent(){
                //조회버튼 클릭
                $("#btnSearch").click(function(){
                    searchQccondition();
                });
                document.querySelector('#searchFrm').addEventListener('change',function(e){
                    dateValidChk(e);
                });

                $("[name=mnfcturDteSch]").change(function (){
                    var beginDte = new Date($("#shrReqestBeginDte").val());
                    var endDte = new Date($("#shrReqestEndDte").val());
                    const diffDate = beginDte.getTime() - endDte.getTime();
                    const dateDays = Math.abs(diffDate / (1000 * 3600 * 24));
                    switch (document.querySelector('[name="mnfcturDteSch"]:checked').id){
                        case 'mnfcturDteSchday':
                            if($("#shrReqestBeginDte").hasClass("mtz-monthpicker-widgetcontainer") === true) {
                                $("#shrReqestEndDte").monthpicker("destroy");
                                $("#shrReqestBeginDte").monthpicker("destroy");
                            }
                            datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["MM",-2], ["DD",0]);
                            break;
                        case 'mnfcturDteSchweek' :
                            if($("#shrReqestBeginDte").hasClass("mtz-monthpicker-widgetcontainer") === true) {
                                $("#shrReqestBeginDte").monthpicker("destroy");
                                $("#shrReqestEndDte").monthpicker("destroy");
                            }
                            datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["DD",-56], ["MM",0]);
                            break;
                        case 'mnfcturDteSchmonth':
                            // datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["MM",-8,'FIRST'], ["MM",0,'LAST']);
                            $("#shrReqestBeginDte").datepicker("destroy");
                            $("#shrReqestEndDte").datepicker("destroy");
                            var options = {
                                pattern: 'yyyy-mm'
                                ,year: 2022          // 시작연도
                                ,monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
                            }
                            var date =new Date();
                            $("#shrReqestBeginDte").val(new Date(date.getFullYear(),date.getMonth()-8,date.getDate()).getFullYear()+'-'+zeroPad(new Date(date.getFullYear(),date.getMonth()-8,date.getDate()).getMonth()+1))
                            $("#shrReqestEndDte").val(new Date().getFullYear()+'-'+zeroPad(new Date().getMonth()+1))
                            $("#shrReqestBeginDte").monthpicker(options);
                            $("#shrReqestEndDte").monthpicker(options);
                            break;
                        case 'mnfcturDteSchyear' :
                            datePickerCalendar(["shrReqestBeginDte", "shrReqestEndDte"], true, ["YY",-8,'FIRST'], ["YY",0,'LAST'],null,null);
                            break;
                            default:
                                break;
                        }
                });

            }
            function searchQccondition(){
                        //문서 목록 조회
                    if(call()){
                        warn("날짜를 확인해주세요.");
                        return false;
                    }
                        ajaxJsonForm("/src/getQcconditionList.lims", "searchFrm", function(data){
                            if(data.length > 0){
                                var datas= new Array();
                                for(var i=0;i<data.length;i++){
                                    if(data[i].resultRegistDte != null) {
                                        datas.push(data[i]);
                                    }
                                }
                                    renderChart(datas);
                                 setGridData(receiptCntList, datas,1)
                                searchInspctList();
                            }else {
                                renderChart(data);
                                setGridData(receiptCntList, data, 1)
                                searchInspctList();
                            }
                        });
            }
            function call()
            {
                var sdd = document.getElementById("shrReqestBeginDte").value;
                var edd = document.getElementById("shrReqestEndDte").value;
                var calcdate;
                switch (document.querySelector('[name="mnfcturDteSch"]:checked').id){
                    case 'mnfcturDteSchweek' :
                        var sddWeek= weekNumberByMonth(sdd);
                        var eddWeek= weekNumberByMonth(edd);
                        if(8<eddWeek-sddWeek)
                           return true;
                        calcdate = (new Date(edd) - new Date(sdd)) / (60 * 60 * 24 * 7*1000)
                        if (calcdate > 8)
                            return true;
                        return false;
                        break;
                    case 'mnfcturDteSchmonth':
                        if(8<calcDatesort(sdd,edd,"month"))
                            return true;
                        break;
                    case 'mnfcturDteSchyear' :
                        if(8<calcDatesort(sdd,edd,"year"))
                            return true;
                        break;
                    default:
                        break;
                }

            }

            function weekNumberByMonth(dateFormat) {
                currentdate = new Date(dateFormat);
                var oneWeek = new Date(currentdate.getFullYear(),0,1);
                var numberOfDays = Math.floor((currentdate - oneWeek) / (24 * 60 * 60 * 1000));
                var result = Math.ceil(( currentdate.getDay() + 1 + numberOfDays) / 7);
                return  result;
            }
            function calcDatesort(date1,date2,type){
                var yearMonthDate1,yearMonthDate2;
                if(type == "month") {
                    yearMonthDate1 = new Date(date1).getFullYear() * 12 + new Date(date1).getMonth();
                    yearMonthDate2 = new Date(date2).getFullYear() * 12 + new Date(date2).getMonth();
                }else if(type == "year"){
                    yearMonthDate1 = new Date(date1).getFullYear()
                    yearMonthDate2 = new Date(date2).getFullYear()
                }
                if(new Date(date1)<new Date(date2)){
                   return yearMonthDate2-yearMonthDate1 ;
                }
                return yearMonthDate1-yearMonthDate2 ;
            }
            function searchInspctList(){
                ajaxJsonForm("/src/getQcconditionInspctList.lims", "searchFrm", function(inspct){
                    if(inspct.length > 0){
                        setGridData(receiptCntList2, inspct,2)
                        chartMk(inspct)
                    }else{
                        setGridData(receiptCntList2, inspct,2)
                        chartMk(null)
                    }
                });
                ajaxJsonForm("/src/getQcconditionPrductList.lims", "searchFrm", function(prduct){
                    if(prduct.length > 0){
                        setGridData(receiptCntList3, prduct,3)
                        chartMk(prduct)
                    }else{
                        setGridData(receiptCntList3, prduct,3)
                        chartMk(null)
                    }
                });
                ajaxJsonForm("/src/getQcconditionMtrilList.lims", "searchFrm", function(mtril){
                    if(mtril.length > 0){
                        setGridData(receiptCntList4, mtril,4)
                    }else{
                        setGridData(receiptCntList4, mtril,4)
                    }
                });
            }
            function setGridData(grid,data,type) {
                AUIGrid.destroy(grid);
                setReceiptListGrid();
                AUIGrid.addRow(grid, { "prop" : "분석 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "부적합 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "부적합 률%"}, "last");
                //AUIGrid.addRow(grid, { "prop" : "부적합 건수"}, "last");
                AUIGrid.addRow(grid, { "prop" : "재분석 률%"}, "last");

                var itemCnt = {};
                var itemUncnt = {};
                var itemUncntp = {};
                var itemRereqestNum = {};
                var itemRereqestNumP = {};
                for(var i=0;i<data.length;i++) {
                    switch (type) {
                        case 1:
                            var dataFieldData = data[i].resultRegistDte;
                            break;
                        case 2:
                            var dataFieldData = data[i].cmmnCodeNm;
                            break;
                        case 3:dataFieldData = data[i].cmmnCodeNm;
                            break;
                        case 4:dataFieldData = data[i].mtrilNm;
                            break;
                        default :
                            break;
                    }
                            AUIGrid.addColumn(grid, {dataField: dataFieldData}, "last");
                            itemCnt[dataFieldData]= data[i].cnt;
                            itemUncnt[dataFieldData]= data[i].uncnt;
                            itemUncntp[dataFieldData]= ((data[i].uncnt/data[i].cnt)*100).toFixed(2);
                            itemRereqestNum[dataFieldData]= data[i].rereqestNum;
                            itemRereqestNumP[dataFieldData]= ((data[i].rereqestNum/data[i].cnt)*100).toFixed(2);
                }


                    AUIGrid.updateRow(grid, itemCnt, 0);
                    AUIGrid.updateRow(grid, itemUncnt, 1);
                    AUIGrid.updateRow(grid, itemUncntp, 2);
                    //AUIGrid.updateRow(grid, itemRereqestNum, 3);
                 AUIGrid.updateRow(grid, itemRereqestNumP, 3);
            }
            function createChart(){

                var chValueChartDoc = document.getElementById('chValueChartDiv');
                chValueChartDoc.innerHTML = '&nbsp;';
                $('#chValueChartDiv').append('<canvas id="receiptCntChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>');

                var ctx = document.getElementById("receiptCntChart").getContext("2d");
                receiptCntChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: [],
                        datasets: []
                    },
                    options: {
                        scales: {
                            yAxes: [{
                                id: 'A',
                                position: 'left',
                                ticks: {
                                    fontColor: '#ffbaa2',
                                    callback: function(value, index, values) {
                                    return value;
                                    }
                                    }
                            },
                                {
                                    id: 'B',
                                    type: 'linear',
                                    position: 'right',
                                    ticks: {
                                        min: 0,
                                        max: 100,
                                        fontColor: '#91cf96',
                                    callback: function(value, index, values) {
                                            return value+" %";
                                        }
                                    }
                                }]
                        },
                        zoom: {
                            enabled: false,
                            mode: 'y'
                        },
                        onClick: handleClick

                    }
                });

                $("#receiptCntChart").click(
                    function(evt){

                    });
            }
            function handleClick(evt) {
                const points = receiptCntChart.getElementsAtEventForMode(evt, 'nearest', {intersect: true}, true);
                if (points.length != 0) {
                    var yearData = points[0]._model.label;
                    var dateType='YYYY';
                    var temp = yearData;
                    if(temp.charAt(temp.length - 1) =='년') {
                        temp = temp.replace('년', '');
                    }else{
                        temp=temp.replace('년','-');
                    }
                    if(temp.charAt(temp.length - 1) =='월') {
                        temp = temp.replace('월', '');
                        dateType="YYYY-MM"
                    }
                    else if(temp.charAt(temp.length - 1) !='월')
                        temp = temp.replace('월','-');
                    if(temp.charAt(temp.length - 2) =='주') {
                        temp = temp.replace('주차', '');
                        dateType="YYYY-MM-w"
                    }
                    if(temp.charAt(temp.length - 1) =='일') {
                        temp = temp.replace('일', '');
                        dateType="YYYY-MM-dd"
                    }
                    openPopup("/src/QCConditionChartM.lims?date="+temp+"&dateType="+dateType,'품질 현황',{
                        width : "1000",
                        height : "700",
                        top : "200",
                        left : "300",
                        location : "no",
                        scrollbars : "yes"
                    });
                }
            }
            function datetag(data){
                if(data.resultRegistDte) {
                    var temp = data.resultRegistDte.split('-');
                    temp[0] += '년';
                    if (temp.length == 1) {
                        return  temp[0];
                    }
                    temp[1] += '월';
                    var tempreturn = temp[0]+temp[1];
                    if (temp.length == 3) {
                        if (temp[2].length == 1)
                            temp[2] += '주차'
                        else if (temp[2].length == 2)
                            temp[2] += '일'
                        tempreturn+=temp[2];
                    }
                    return tempreturn
                }
            }

            function dateValidChk2(e) {

                    var value = e.target.value;

                    var pattern1 = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; // YYYY-MM-DD
                    var pattern2 = /^\d{4}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/; // YYYYMMDD

                    //정규식 검사
                    if (!!value) {
                        if (pattern1.test(value)) {
                            // value = YYYY-MM-DD
                        } else if (pattern2.test(value)) {
                            // value = YYYYMMDD
                            e.target.value = value.slice(0, 4) + '-' + value.slice(4, 6) + '-' + value.slice(6);
                        } else {
                            warn("날짜 형식이 맞지 않습니다. [" + getFormatDate() + ", 또는 " + getFormatDate().replaceAll("-", "") + "] 형식으로 입력해 주세요.");
                            e.target.value = "";
                            e.target.focus();
                            return false;
                        }
                    }

            }
            function chartMk(data){

                var createCnt = 0; //만들어진 차트 갯수
                var chartArr = new Array();// 차트 갯수
                var charTNmArr = new Array(); //시험항목 수 세로 반복수
                var charTNm = ["분석수","재분석률","분량률"];
                if(data==null){
                    $("#chValuePieDiv").empty();
                    $("#chValuePieDiv2").empty();
                }
                else if(data[0].prductSeCode != null)
                    $("#chValuePieDiv").empty();
                else
                    $("#chValuePieDiv2").empty();
                for(var z = 0; z<3; z++){ //세로반복 구분 : 시험항목명

                    createCnt++;
                    if(data[0].prductSeCode != null) {
                        var divId = "div_타입" + charTNm[z]; // divId
                        var canvasId = "타입" + charTNm[z]; // canva 아이디값
                    }else {
                        var divId = "div_제품" + charTNm[z]; // divId
                        var canvasId = "제품" + charTNm[z]; // canva 아이디값
                    }
                    var div = document.createElement("div"); //div


                    //DIV setting
                    div.classList.add("wd30p");
                    div.classList.add("mgB10");
                    div.style.marginLeft = "2%";

                    div.style.padding = "0px 0 250px 0";
                    //div.style.border = "1px solid #bdbdbd";
                    div.style.height = "100px";
                    div.style.float = "left";
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
                    if(data[z].prductSeCode != null)
                        getEl("chValuePieDiv").appendChild(div);
                    else
                       getEl("chValuePieDiv2").appendChild(div);
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
                                            sum+=parseInt(data.datasets[0].data[i])
                                        }
                                        return data.labels[tooltipItem.index]+" : "+data.datasets[0].data[tooltipItem.index];
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
                                text:charTNm[z]
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
                    if(charTNm[z]){
                        var resultValueAvgArr = new Array(); //데이터
                        var resultValueErr = new Array(); //기기
                        var resultValueReRequest = new Array();
                        var labelsArr = new Array(); //라벨
                    }
                    // 큰틀  =  좌우 반복
                    //data =
                    for(var j=0; j<data.length; j++){
                        var objWrapper = new Array();
                         resultValueAvgArr.push(data[j].cnt);
                         resultValueErr.push(parseFloat(data[j].uncnt*100/data[j].cnt).toFixed(2));
                        resultValueReRequest.push(parseFloat(data[j].rereqestNum*100/data[j].cnt).toFixed(2));
                         labelsArr.push(data[j].cmmnCodeNm);
                    }
                    if(charTNm[z] == '분석수')
                        var valueList = [
                            {
                                "list" : resultValueAvgArr,
                                "label" : charTNm[z],
                                "backgroundColor" : color
                            }
                        ];
                    if(charTNm[z] == '재분석률')
                        var valueList = [
                            {
                            "list" : resultValueReRequest,
                            "label" : charTNm[z],
                            "backgroundColor" : color
                        }];
                    if(charTNm[z] == '분량률')
                        var valueList = [
                            {
                            "list" : resultValueErr,
                            "label" : charTNm[z],
                            "backgroundColor" : color
                        }];
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
                    receiptCntPie[z] =chartArr[(createCnt-1)]["chart"];
                    chartArr[(createCnt-1)]["chart"].update();
                }

            }
            //불러온 데이터로 차트 생성
            function renderChart(data){

                createChart();


                var receptCnt = new Array();
                var deptNm =  new Array();
                var receptbarCnt = new Array();
                var deptbarNm = "";
                var valueList = [];
                var valuebarList = [];
                //data 에 넣어줄 건수 배열에 넣기

                    for (var j = 0; j < data.length; j++) {
                            data[j].uncnt = data[j].uncnt == null ? 0 : data[j].uncnt;
                            data[j].uncntP = parseInt(data[j].uncnt / data[j].cnt * 100);
                            receptCnt.push(data[j].uncntP);
                            receptbarCnt.push(data[j].cnt);
                            deptNm.push(datetag(data[j]));
                    //포문 마지막에데이터 밀어 넣기.
                    if(j == (data.length-1)){
                        valueList.push({"list" : receptCnt,"labels" :deptNm,"fill" : false,"borderWidth" : 1});
                        valuebarList.push({"list" : receptbarCnt,"labels" :deptNm,"fill" : false,"borderWidth" : 1});
                    }
                }
                if (data.length == 0) {
                    valueList.push({"list": receptCnt,"label": deptNm,"fill": false,"borderWidth": 1});
                    valuebarList.push({"list": receptCnt,"label": deptNm,"fill": false,"borderWidth": 1});
                }

                //config
                var config = receiptCntChart.config;

                for(var i=0; i<valueList[0].list.length; i++) {
                        receiptCntChart.data.labels[i] = valueList[0].labels[i];
                    }
                        receiptCntChart.data.datasets[0] = {
                            "label" : '부적합률',
                            "data" : valueList[0].list,
                            "fill" : valueList[0].fill,
                            'type' : 'line',
                            'yAxisID' : 'B',
                            borderColor: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
                            lineTension: 0
                        }
                    config.type = "bar";
                    //차트의 스케일을 잡는다
                    var scales = config.options.scales;
                    //스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
                    scales.xAxes[0].stacked = true;
                    scales.yAxes[0].stacked = true;

                    //Y축의 틱은 0부터.
                    scales.yAxes[0].ticks.beginAtZero = true;
                        receiptCntChart.data.datasets[1] = {
                            "label":'분석수',
                            "data" : valuebarList[0].list,
                            "fill" : valuebarList[0].fill,
                            'yAxisID' : 'A',
                            backgroundColor: 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
                            lineTension: 1
                        }
/*
             //   var config = chartArr[(createCnt-1)]["chart"]["config"];

                // 전역설정. 타이틀, 반응형으로 설정.
                var configPie = receiptCntPie.config;
                configPie.options.responsive = true;
                configPie.options["title"]["display"] = true;
                configPie.options["title"]["text"]=null;
                configPie.type = "pie";
                //div.style.height = "302px";
                //기초데이터 만든걸로 일단 LOT 부터 집어넣는다.
                //datasets 라인별이라고 보면됨니다

                receiptCntPie.data = {
                    "labels" : [],
                    "datasets" : []
                };
                console.log(">> : ", valueList);
                //라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다

                for(var x=0; x<valueList.length; x++){
                    receiptCntPie.data.datasets.push ({
                        //"label" : valueList[x].label,
                        "data" : valueList[x].list,
                        "backgroundColor" : valueList[x].backgroundColor
                    });
                }*/

                // 완성된 차트는 업데이트를 시켜주면된다.
             //   receiptCntPie.update();

                // 완성된 차트는 업데이트를 시켜주면된다.
                receiptCntChart.update();
            }
        </script>
    </tiles:putAttribute>
    <tiles:putAttribute name="body">
        <div class="subContent">
            <div class="subCon1">
                <h2><i class="fi-rr-apps"></i>통계 기간</h2><!-- 담당 팀별 접수 건수 조회 -->
                <div class="btnWrap">
                    <button id="btnSearch" class="search btn1">${msg.C000000002}</button> <!-- 조회 -->
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
                            <th>제조 일자</th>
                            <td>
                                <label><input type="radio" id="mnfcturDteSchday" name="mnfcturDteSch" value="YYYY-MM-dd" checked> 일</label>
                                <label><input type="radio" id="mnfcturDteSchweek" name="mnfcturDteSch" value="YYYY-MM-w"> 주</label>
                                <label><input type="radio" id="mnfcturDteSchmonth" name="mnfcturDteSch" value="YYYY-MM">월</label>
                                <label> <input type="radio" id="mnfcturDteSchyear" name="mnfcturDteSch" value="YYYY">년</label>
                            </td>
                            <td colspan="3" style="text-align:left;">
                                <input type="text" id="shrReqestBeginDte" name="shrReqestBeginDte" class="dateChk wd10p" style="min-width: 6em;" readonly>
                                ~
                                <input type="text" id="shrReqestEndDte" name="shrReqestEndDte" class="dateChk wd10p" style="min-width: 6em;" readonly>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="subCon2 mgT15">
                <div style="display:flex">

                    <div class="wd100p" style="display:inline-block; order:1;" >

                        <div class="mgT15" id="chValueChartDiv">
                            <canvas id="receiptCntChart" class="wd80p" style="margin-left:1%; border:1px solid; height:480px; border-color:#dbdbdb;"></canvas>
                        </div>



                        <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                        <div class="wd100p mgT15" style="display:inline-block; order:1;" >
                            <div class="accordion_wrap mgB15">
                                <div class="subCon2 wd100p mgT25" id="detail2">
                                    <div class="accordion">제품별 타입별 분석<!-- 내용 --></div>
                                    <div id="acc2" class="acco_top mgT15" style="display: none">
                                        <div class="mgT15" id="chValuePieDiv">
<%--                                            <canvas id="receiptCntPie" class="wd30p" style="margin-left:1%; border:1px solid; height:100px; border-color:#dbdbdb;"></canvas>--%>
                                        </div>
                                        <div class="mgT15" id="chValuePieDiv2">
                                                <%--                                            <canvas id="receiptCntPie" class="wd30p" style="margin-left:1%; border:1px solid; height:100px; border-color:#dbdbdb;"></canvas>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h2 style="display:inline-block;line-height:2"><i class="fi-rr-apps"></i>분석 건수 상세</h2>
                            <div id="receiptCntList" class="wd100p" style="height:200px;"></div>
                        </div>
                        <div class="wd100p mgT15" style="display:inline-block; order:2;" >
                            <h2 style="display:inline-block;line-height:2"><i class="fi-rr-apps"></i>제품 구분 별 상세</h2>
                            <div id="receiptCntList2" class="wd100p" style="height:200px;"></div>
                        </div>
                        <div class="wd100p mgT15" style="display:inline-block; order:3;" >
                            <h2 style="display:inline-block;line-height:2"><i class="fi-rr-apps"></i>검사 유형 별 상세</h2>
                            <div id="receiptCntList3" class="wd100p" style="height:200px;"></div>
                        </div>
                        <div class="wd100p mgT15" style="display:inline-block; order:4;" >
                            <h2 style="display:inline-block;line-height:2"><i class="fi-rr-apps"></i>제품 별 상세</h2>
                            <div id="receiptCntList4" class="wd100p" style="height:200px;"></div>
                        </div>
                    </div>

                </div>
            </div>
            <form id="frmChartData" method="post" action="/com/chartImgDown.lims">
                <input type="text" name="chartImg" id="chartImg" value="" style="display:none;"/>
            </form>
        </div>
    </tiles:putAttribute>
</tiles:insertDefinition>