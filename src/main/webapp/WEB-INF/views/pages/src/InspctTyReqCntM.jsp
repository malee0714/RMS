<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="body">
    <div class="subContent">
        <div class="subCon1">
            <h2><i class="fi-rr-apps"></i>${msg.C100001276}</h2> <!-- 검사유형별 의뢰건수 -->
            <div class="btnWrap">
                <button id="btnSelect" type="button" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
            </div>
            <form id="searchFrm">
                <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
                    <colgroup>
                        <col style="width:9%"></col>
                        <col style="width:15%"></col>
                        <col style="width:9%"></col>
                        <col style="width:15%"></col>
                        <col style="width:9%"></col>
                        <col style="width:15%"></col>
                        <col style="width:9%"></col>
                        <col style="width:19%"></col>
                    </colgroup>
                    <tr>
                        <th>${msg.C100000432}</th> <!-- 사업장 -->
                        <td><select id="bplcCodeSch" name="bplcCodeSch"></select></td>
                        <th>${msg.C100000607}</th> <!-- 연도 -->
                        <td><select id="yearSch" name="yearSch"></select></td>
                    </tr>
                </table>
            </form>
        </div>

        <div class="subCon2 mgT20 wd100p"s>
            <div style="display:flex;">
                <!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
                <div class="wd35p mgT10" style="display:inline-block; order:1;">
                    <div id="inspctTyCntGrid" class="wd100p" style="height:505px;"></div>
                </div>
                <div class="wd62p mgT10" style="display:inline-block; order:2;" >
                    <!-- 차트가 이곳에 생성됩니다. -->
                    <div id="chartBox">
                        <canvas id="requestCntChart" class="wd100p" style="margin-left:30px; border:1px solid; height:505px; border-color:#dbdbdb;"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</tiles:putAttribute>

<tiles:putAttribute name="script">
    <script>

        var inspctTyCntGrid = 'inspctTyCntGrid';

        $(document).ready(function() {
            setCombo();

            setGrid();

            createChart();

            buttonEvent();
        });

        function setGrid() {
            var col = [];

            auigridCol(col);
            col.addColumn("bplcNm", "${msg.C100000432}", "*", true)
            col.addColumn("inspctTyNm", "${msg.C100000139}", "*", true)
            col.addColumn("reqestDte", "${msg.C100000659}", "*", true)
            col.addColumn("reqestCnt", "${msg.C100000121}", "*", true);

            inspctTyCntGrid = createAUIGrid(col, inspctTyCntGrid);
        }

        function setCombo() {
            ajaxJsonComboBox('/wrk/getBestComboList.lims', 'bplcCodeSch', null, false, null, '${UserMVo.bestInspctInsttCode}');
            setYear('yearSch', new Date().getFullYear(), 2019, 10);
        }

        function createChart() {

            // 차트 초기화 후, 재생성
            var chartBox = document.getElementById('chartBox');
            chartBox.innerHTML = '';
            $('#chartBox').append(
                '<canvas id="requestCntChart" class="fL wd100p" style="margin-left:30px; border:1px solid; height:505px; border-color:#dbdbdb;"></canvas>'
            );

            // Canvas Drawing Context 접근, 차트 속성 설정
            var canvDrawContxt = document.getElementById('requestCntChart').getContext('2d');
            requestCntChart = new Chart(canvDrawContxt, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{}]
                },
                options: {
                    legend: {
                        display: true,
                        position: 'top',
                        labels: { boxWidth: 80, fontColor: 'black' }
                    },
                    zoom: {
                        enabled: true,
                        mode: 'y'
                    },
                    scales: {
                        yAxes: [{
                            gridLines: { color: "#1f296f", borderDash: [2, 5] },
                            scaleLabel: {
                                display: true,
                                labelString: '${msg.C100000121}',
                                fontColor: 'black',
                                fontSize: 17
                            },
                            ticks: { fontColor: 'rgba(0, 0, 0, 1)', fontSize: 14 }
                        }],
                        xAxes: [{
                            gridLines: { color: "#eee" },
                            ticks: { fontColor: 'rgba(0, 0, 0, 1)', fontSize: 14 }
                        }]
                    }
                }
            });
        }

        function buttonEvent() {
            $('#btnSelect').click(function() {
                showRequestCntData();
            });
        }

        function showRequestCntData() {
            customAjax({
                url: '/src/getReqCntByInspctTy.lims',
                data: $('#searchFrm').serializeObject(),
                successFunc: function (data) {
                    AUIGrid.setGridData(inspctTyCntGrid, data.list);
                    renderChart(data.list, data.listDate);
                }
            });
        }

        function renderChart(list, listDate) {
            createChart();

            var inpctTypeList = [];
            var requestDteList = [];
            var uniqueTypeList = [];

            for (var i=0; i < list.length; i++) {
                inpctTypeList[i] = list[i].inspctTyCode;
            }
            for (var i=0; i < listDate.length; i++) {
                requestDteList[i] = listDate[i].yearMnth;
            }

            // 검사유형 배열에서 중복요소 제거
            for (var type of inpctTypeList) {
                if (!uniqueTypeList.includes(type)) {
                    uniqueTypeList.push(type);
                }
            }

            var colors = [
                '#FF6347', '#FFAF00',
                '#78E150', '#646EFF',
                '#DC50DC', '#FF7493',
                '#81CBF9', '#E7DFB6'
            ];

            // x축 label은 의뢰일자
            requestCntChart['data']['labels'] = requestDteList;
            requestCntChart['config']['type'] = 'line';

            for (var i=0; i < uniqueTypeList.length; i++) {
                var chartData = [];
                var inspctTypeNm = '';

                for (var j=0; j < list.length; j++) {
                    if (uniqueTypeList[i] == list[j].inspctTyCode) {
                        chartData.push({
                            value: list[j].reqestCnt,
                            date: list[j].reqestDte
                        });

                        // 차트 상단 label은 검사유형
                        inspctTypeNm = list[j].inspctTyNm;
                    }
                }

                chartData = chkNullDate(chartData, requestDteList);

                // 차트 옵션 설정
                requestCntChart.data.datasets[i] = {
                    data: chartData,
                    label: inspctTypeNm,
                    fill: false,
                    borderColor: colors[i],
                    backgroundColor: colors[i],
                    pointBorderColor: colors[i],
                    pointBackgroundColor: colors[i],
                    pointRadius: 5,
                    pointHoverRadius: 8,
                    pointHitRadius: 15,
                    pointStyle: 'rectRounded',
                    lineTension: 0
                };
            }

            requestCntChart.update();
        }

        function chkNullDate(list, dateArr) {
            var result = [];
            var cnt = 0;

            for (var i= 0; i < dateArr.length; i++) {
                if (cnt > list.length-1) {
                    cnt -= 1;
                }

                if (list[cnt].date == dateArr[i]) {
                    result.push(list[cnt].value);
                    cnt++;
                }else {
                    result.push(null);
                }
            }
            return result;
        }

    </script>
</tiles:putAttribute>
</tiles:insertDefinition>
