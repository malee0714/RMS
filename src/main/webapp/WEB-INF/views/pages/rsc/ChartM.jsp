<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
    <tiles:putAttribute name="body">

    	<div class="subContent">
			<div class="subCon1">
				<h2> ${msg.C000000021}</h2> <!-- 공조기 - 수치 차트-->
				<div class="btnWrap">
					<button id="btnSearch" class="search btn3">${msg.C000000002}</button> <!-- 조회 -->
				</div>
				<form action="javascript:;" id="searchFrm" name="searchFrm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:10%"></col> 
							<col style="width:23.3%"></col>
							<col style="width:10%"></col> 
							<col style="width:23.3%"></col>
							<col style="width:10%"></col> 
							<col style="width:23.3%"></col>							
											
						</colgroup>
						<tr>
			
							<th>${msg.C000000004}</th> <!-- 기기 -->
								<td><select id="mhrlsSeqnoSch" name="mhrlsSeqnoSch" > </select></td> 
					
							<th>${msg.C000000005}</th> <!-- 점검일자 -->
								<td style="text-align:left;">
									<input type="text" id="writngDeStart" name="writngDeStart" class="wd10p"  style="min-width: 10em;" value="${param.writngDeStart}" > 
									~ 
									<input type="text" id="writngDeFinish" name="writngDeFinish" class="wd10p"  style="min-width: 10em;"  value="${param.writngDeFinish}" >
								</td>
								
							<th>${msg.C000000023}</th> <!-- 그래프 타입 -->
								<td style="text-align: left;">
									<label><input type="radio" name="type" id="line" value="line" checked/>&nbsp;${msg.C000000024}</label> <!-- LINE -->
									<label><input type="radio" name="type" id="bar" value="bar"/>&nbsp;${msg.C000000025}</label> <!-- BAR -->
								</td>	
						</tr>
					</table>
					<input type="hidden" id="chckDte" name="chckDte" value="${param.checkDte}">
					<input type="hidden" id="chckItem" name="chckItem" value="${param.checkItem}">
					<input type="hidden" id="mhrlsSeqno" name="mhrlsSeqno" value="${param.mhrlsSeqno}">
				</form>
			</div>
			<div class="subCon1 mgT20">
				<h2>${msg.C000000022}</h2> <!-- 차트 상세 정보 -->
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div class="fL wd25p mgT15" style="height:400px;">
					<div id="chValueList" class="fL wd100p" style="height:100%;"></div>
				</div>
				<div class="fL wd73p mgT15" style="height:400px;" id="chValueChartDiv">
					<canvas id="chValueChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:400px; border-color:#dbdbdb;"></canvas>
				</div>

			</div>
		</div>
	
 	</tiles:putAttribute>
	<tiles:putAttribute name="script">
<script>

$(function() {
	getAuth();
	
	datePickerCalendar(["writngDeStart","writngDeFinish"], false);

	setchValueListGrid();

	setButtonEvent();
	
	setCombo();
	
	gridResize([chValueList]);
	
	setChartObject();
	
	getchkValueList();
	

});

/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
*/

var colorList = [
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
	'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
];


var ctx = document.getElementById('chValueChart').getContext('2d');
var chValueChart;

var chValueList = 'chValueList';
var getEl = function(id){//id에 해당하는 선택자 가져오기.
	return document.getElementById(id);
};

function setChartObject(callback){
	//차트를 아예 부시고 다시 만듬(안그러면 여러번 조회할때 그전 차트가 남아 있음)
	var chValueChartDoc = document.getElementById('chValueChartDiv');
	chValueChartDoc.innerHTML = '&nbsp;';
	$('#chValueChartDiv').append('<canvas id="chValueChart" class="fL wd100p" style="margin-left:1%; border:1px solid; height:400px; border-color:#dbdbdb;"></canvas>');
	var ctx = document.getElementById('chValueChart').getContext('2d');
	chValueChart = new Chart(ctx, {
	    type: "line",
	    data: {
	        datasets: []
	    },
	    options: {
	    	responsive: true,	    		
	    	title: {
				display: true,
			},
	        scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero: true
	                }
	            }]
	        },
	        zoom: {
		         enabled: true,
		         mode: 'y',
		      },
	        tooltips: {
	        	position: "nearest",
				mode: "index",
				intersect: false,
			},
			hover: {
				mode: "index",
				intersect: false,
			}
	    }
	});
	/*  var ctx = document.getElementById("chValueChart").getContext('2d');
	var myChart = new Chart(ctx, {
	   type: 'bar',
	   data: {
	      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept'],
	      datasets: [{
	         label: '# of Votes',
	         data: [12, 19, 3, 5, 2, 5, 9, 4, 11]
	      }]
	   },
	   options: {
	      pan: {
	         enabled: true,
	         mode: 'x',
	      },
	      zoom: {
	         enabled: true,
	         mode: 'x',
	      }
	   }
	});  */
}

function setCombo(){
	//url,obj,param,flag, msg, selectVal, auth, callbackfnc 
	ajaxJsonComboBox('/com/getMhrlsVal.lims','mhrlsSeqnoSch',{"mhrlsClCode" : "RS02000156","mhrlsSeqno" : "${param.mhrlsSeqno}"}, false);

}

//그리드 생성
function setchValueListGrid(){
	
	//그리드 레이아웃 정의
	var columnLayout = {
			chValueLayout : []
	};
	
	// 사용량 그리드
	auigridCol(columnLayout.chValueLayout);
	columnLayout.chValueLayout.addColumnCustom("mhrlsNm","${msg.C000000011}",null,true) /* 기기명 */
	.addColumnCustom("chckDte","${msg.C000000005}",null,true) /* 점검일자 */
	.addColumnCustom("cmmnCodeNm","${msg.C000000018}",null,true) /* 점검내용 */
	.addColumnCustom("chckResultValue","${msg.C000000019}",null,true) /* 점검결과 */

	
	chValueList = createAUIGrid(columnLayout.chValueLayout, chValueList);
}

//버튼 이벤트
function setButtonEvent(){
	//조회 클릭 이벤트
	getEl("btnSearch").addEventListener("click",function(){
		getchkValueList();
	});

	getEl("mhrlsSeqnoSch").addEventListener("change", function(){
		getchkValueList();
	});
};

function getchkValueList(){
   getGridDataForm("<c:url value='/rsc/getchkValueList.lims'/>", "searchFrm", chValueList, function(data) {
	   if (!!data) {
        	 var type = $("#searchFrm").serializeObject().type;
 			renderChart(data.list, type, data.listDate);
 			AUIGrid.setGridData(chValueList, data.list);
         }
    }); 
};

function renderChart(data, chartType, dateArr){
	//chValueChart.destroy();
	//차트 변수 초기화
	setChartObject();
	
	//기초 데이터 생성용 변수 생성
	//얘는 데이터 목록
	var mesure1ValueList = new Array();
	
	// 얘는 맨밑에 날짜 라벨 목록
	var mesureDtList = [];
	
	//기기 일련번호
	var mhrlsSeqno = "";
	
	var valueList = [];

	//반복문에 모조리넣음
	for(var i=0; i<data.length; i++){
	 	if(data[i].mhrlsSeqno == mhrlsSeqno){
			mesure1ValueList.push({"value":data[i].chckResultValue,"date":data[i].chckDte});	
		} else{
			//처음 포문에 들어오는게 아니면 
			//기기일련번호가 다를때 이전까지 쌓은 기기 정보 밀어 넣기.
			if(i != 0){
				mesure1ValueList = chkNullDate(mesure1ValueList, dateArr);
				valueList.push({
					"list" : mesure1ValueList,	
					"label" : data[i-1].mhrlsNm,
					"fill" : false,
					"borderWidth" : 1
				});
			}
			//초기화
			mesure1ValueList = [];
			
			mesure1ValueList.push({"value":data[i].chckResultValue,"date":data[i].chckDte});	
		}
	 	
	 	mhrlsSeqno = data[i].mhrlsSeqno;
// 	 	if(jQuery.inArray(data[i].chckDte,mesureDtList) == -1){
// 	 		mesureDtList.push(data[i].chckDte);
// 	 	}
	 	
	 	
	 	//포문 마지막에데이터 밀어 넣기.
	 	if(i == (data.length-1)){
	 		mesure1ValueList = chkNullDate(mesure1ValueList, dateArr);
			valueList.push({
				"list" : mesure1ValueList,	
				"label" : data[i].mhrlsNm,
				"fill" : false,
				"borderWidth" : 1
			});
		}
	}
	
	for (var i= 0 ; i<dateArr.length; i++){
		if(jQuery.inArray(dateArr[i].chckDte,mesureDtList) == -1){
	 		mesureDtList.push(dateArr[i].chckDte);
	 	}
	}
	
	//config 접근도어렵다 하... 
	var config = chValueChart.config;
	config.options.title.text = data[0].cmmnCodeNm;
	
	if(chartType == "line"){
		
		//라인차트로 변경
		config.type = "line";
		
		//Y축의 scale을 0부터 시작하게한다.
		config.options.scales.yAxes[0].ticks.beginAtZero = true;
		
		
		//기초데이터 만든걸로 일단 범례부터 집어넣는다.
		//datasets 라인별이라고 보면됨니다
		mesureDtList.sort(function(a,b){
			 if ( a < b ) return -1; 
	        else if ( a == b ) return 0; 
	        else return 1; 
		});

		chValueChart["data"]["labels"] = mesureDtList;
		
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<valueList.length; i++){
			chValueChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"fill" : valueList[i].fill,
				"borderColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')',
				lineTension: 0
			};
		}
		
	} else if(chartType == "bar"){
		// config의 타입을 bar 차트로.
 		config.type = "bar";
		
		//차트의 스케일을 잡는다
 		var scales = config.options.scales;
		
 		//스택형 bar 차트로 만든다. 축이 3개면 너무많아서 못그림
 		scales.xAxes[0].stacked = true;
 		scales.yAxes[0].stacked = true;
		
		//Y축의 틱은 0부터.
		scales.yAxes[0].ticks.beginAtZero = true;
		
		//날짜 정렬
		mesureDtList.sort(function(a,b){
			 if ( a < b ) return -1; 
	        else if ( a == b ) return 0; 
	        else return 1; 
		});
		//라벨 = 날짜
		chValueChart["data"]["labels"] = mesureDtList;
		
		//라인마다 스타일과 데이터를 넣습니다 <--- valueList 갯수만큼 라인추가, 속성추가 임니다
		for(var i=0; i<valueList.length; i++){
			chValueChart.data.datasets[i] = {
				"label" : valueList[i].label,
				"data" : valueList[i].list,
				"backgroundColor" : 'rgb(' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ', ' + Math.floor(Math.random() * 256) + ')'
			};
		}
	}
	console.log(valueList);
	
	// 완성된 차트는 업데이트를 시켜주면된다.
	chValueChart.update();
}

//차트 배열에 null 공간 만들어 주기 위한 함수
//ex) [null,12,null,null,13]
//차트에 배열 형식을 맞춰줘야 제대로 된 그래프 그리기 가능.
function chkNullDate(list, dateArr){
	var result = [];
	var cnt = 0;
	for(var i= 0; i<dateArr.length; i++){
		if(cnt > (list.length-1))
			cnt -= 1;
		if(list[cnt].date == dateArr[i].chckDte){
			result.push(list[cnt].value);
			cnt++;
		}else{
			result.push(null);
		}
	}
	
	return result;
}
</script>
	</tiles:putAttribute>    
</tiles:insertDefinition>