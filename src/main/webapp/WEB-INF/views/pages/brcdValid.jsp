<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!--[if lt IE 9]>

  <![endif]-->
<script src="/assets/js/jquery-1.12.4.min.js"></script>
<script src="/assets/js/json2.js"></script>    
<link href="/assets/image/favicon.ico" rel="icon" type="image/x-icon" />
<link href="/assets/image/favicon.ico" rel="shortcut icon" type="image/x-icon" />
<link rel="stylesheet" href="/assets/stylesheet/jquery-ui.css">
<link rel="stylesheet" href="/assets/stylesheet/common.css">
<link rel="stylesheet" href="/assets/stylesheet/css/common.css">
<link rel="stylesheet" href="/assets/stylesheet/css/style.css">
<link rel="stylesheet" href="/assets/stylesheet/css/font.css">
<script src="/assets/js/jquery-ui.min.js"></script>
<script src="/assets/js/jBeep.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>바코드 검증</title>
<style>
	#resultForm tr td{
		 text-align:left;
		 height : 32px;
	}
	.subContent{
 		padding: 0px 0px 0px !important;
 	}
 	
 	
</style>

<script type="text/javascript">
var brcdList; //바코드 리스트 그리드
var brcdListDetail; //바코드 리스트의 바코드 조회

$(document).ready(function(){

	//초기 세팅
	init();
	
	//버튼 이벤트
	setButtonEvent();
});


//초기 세팅
function init(){
	//바코드수에 따라서 바코드 텍스트 박스 생성
	createBrcdText(1);
	
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1; //January is 0!
	var yyyy = today.getFullYear();
	
	if(dd<10) {
	    dd ='0' + dd;
	} 

	if(mm<10) {
	    mm = '0'+ mm;
	} 
	
	$("#brcdCreatDte").val(yyyy + "-" + mm + '-' + dd);
	$("#dlivyDte").val(yyyy + "-" + mm + '-' + dd);
	
}


//버튼 이벤트
function setButtonEvent(){
	
	//바코드수 변경 이벤트
	$("#topRepr").change(function(e){
		var topReprValue = Number(e.target.value);
		//바코드 수만큼 바코드 텍스트박스 생성
		createBrcdText(topReprValue);		
	});
	
	
	//바코드 검증 버튼
	$("#btnVerification").click(function(){
		verification();		
	});
}

//바코드수에 따라서 바코드 텍스트 박스 생성
function createBrcdText(index){
	var tdBrcd = $("#tdBrcd");
	tdBrcd.empty();
	
	var str = "";
	for(var i=1; i<=index; i++){
		str += "<input type='text' id='brcd"+i+"' name='brcd' class='mgT5 wd100p' onkeyup='brcdVerification(this)'>";		
	}
	
	tdBrcd.append(str);
}

//바코드 검증 엔터키
function brcdVerification(e){
	
	var keyCode = event.keyCode;
	if(keyCode == 13 || keyCode == 17){
		//마지막 텍스트박스에서 엔터가 들어왔을때 이벤트
		if(e.id.substring(e.id.length -1 ) == $("#tdBrcd [type=text]").length){
			verification();
		}
		else{
			$("#"+e.id).next().focus();
		}
	}
	
}

//바코드 검증
function verification (){
	
	var resultTable = $("#resultTable");	
	resultTable.hide();	
	
	$("#resultForm")[0].reset();
	$(".resultTr").empty();	
	
	var cnt = 0;
	var tot = 0;
	
	//바코드 텍스트 박스에 빈값이 있는지 체크
	var tdBrcdLength = $("#tdBrcd").find("[type=text]").length;
	for(var i=1; i<=tdBrcdLength; i++){
		if(!$("#brcd" + i).val()){
			cnt ++;
		}
		tot++;
	}
	
	//바코드 텍스트 박스에 빈값이 없으면
	if(cnt == 0){
		
		showLoadingbar();
		$("#brcdValidForm").find("input,select").prop("disabled", true);
		$("#brcdValidForm").find("select").css("background-color", "#EBEBE4");
		
		
		var params = {};
		//바코드, 순서 값을 json 형식으로 담는다.
		params.brcd1 = $("#brcd1").val();
		params.brcd2 = $("#brcd2").val();
		params.brcd3 = $("#brcd3").val();
		params.brcd4 = $("#brcd4").val();
		params.brcd5 = $("#brcd5").val();
		params.deptCode = $("#deptCode").val();
		params.topRepr = Number($("#topRepr").val());
		params.brcdCreatDte = $("#brcdCreatDte").val();
		params.shipmntLcCode = $("#shipmntLcCode").val();
		params.dlivyDte = $("#dlivyDte").val();
		params.tot = tot;
		params.brValid = $('input:checkbox[name="brValid"]:checked').length
		
		ajaxJsonParam("/dly/getBrcdVal.lims", params, function(data){
			var resultLable = $("#resultLable");
			$("#resultContent").show();
			
			resultLable.text(data["msg"]);
			
			//검증결과
			if(data["result"] == false){
				resultLable.css("color", "red");
				jBeep('/assets/sound/ns213.wav');
				
			}
			else{
				resultLable.css("color", "blue");
				jBeep('/assets/sound/ns108.wav');
				
			}
			
			if(data["deptCode"]){
				var labDeptCodeResult = $("#labDeptCodeResult");
				//제조 결과
				labDeptCodeResult.text(data["deptCode"]["msg"]);

				//제조결과에 따라서 색 변경
				if(data["deptCode"]["result"] == false){
					labDeptCodeResult.css("color", "red");
				}
				else{
					labDeptCodeResult.css("color", "blue");
				}
			}
			
			//제조 라벨
			$("#labDeptCode").text($("#deptCode option:checked").text());

			if(data["data"]){
								
				if(!data["data"]["dvyfgEntrpsNm"]){
					data["data"]["dvyfgEntrpsNm"] = "";
				}
				if(!data["data"]["mtrilNm"]){
					data["data"]["mtrilNm"] = "";
				}
				if(!data["data"]["batchNo"]){
					data["data"]["batchNo"] = "";
				}
				if(!data["data"]["lotId"]){
					data["data"]["lotId"] = "";
				}
				if(!data["data"]["unitNm"]){
					data["data"]["unitNm"] = "";
				}
				if(!data["data"]["ctmmnyMtrilCode"]){
					data["data"]["ctmmnyMtrilCode"] = "";
				}

				
				//제조팀
				$("#labDeptCode").text(data["data"]["deptNm"]);				
				//고객사 라벨
				$("#labDvyfgEntrpsNm").text(data["data"]["dvyfgEntrpsNm"]);
				//생성일
				$("#labBrcdCreatDte").text(data["data"]["brcdCreatDte"]);
				//제품
				$("#labMtrilNm").text(data["data"]["mtrilNm"]);
				//자재코드
				$("#labBatchNo").text(data["data"]["ctmmnyMtrilCode"]);
				//LOT ID
				$("#labLotId").text(data["data"]["batchNo"]);
				//단위
				$("#labUnitNm").text(data["data"]["unitNm"]);
				//출하처 
// 				$("#labShipmntLcCode").text($("#shipmntLcCode option:selected").text());

				// 저장된 데이터 불러와서 화면에는 이름으로 보여주기 위해 코드에 따라 이름을 변경했음.
				if(data["data"]["shipmntLcCode"] == null){
					data["data"]["shipmntLcCode"] = "없음"
				}
				else if(data["data"]["shipmntLcCode"] == "P1C1"){
					data["data"]["shipmntLcCode"] ="화성"
				}else if(data["data"]["shipmntLcCode"] == "P1C3"){
					data["data"]["shipmntLcCode"] ="LSI"
				}else if(data["data"]["shipmntLcCode"] == "P1C4"){
					data["data"]["shipmntLcCode"] ="평택"
				}else if(data["data"]["shipmntLcCode"] == "P1C2"){
					data["data"]["shipmntLcCode"] ="천안"
				}
				$("#labShipmntLcCode").text(data["data"]["shipmntLcCode"]);

		
				
			}
			
			
			if(data["brcdCreatDte"]){
				var labBrcdCreatDteResult = $("#labBrcdCreatDteResult");
				//생성일 결과
				labBrcdCreatDteResult.text(data["brcdCreatDte"]["msg"]);
				
				//생성일 결과에 따라서 색 변경
				if(data["brcdCreatDte"]["result"] == false){
					labBrcdCreatDteResult.css("color", "red");
				}
				else{
					labBrcdCreatDteResult.css("color", "blue");
				}
			}
			
			if(data["shipmntLcCode"]){
				var shipmntLcCodeResult = $("#shipmntLcCodeResult");

				//생성일 결과
				shipmntLcCodeResult.text(data["shipmntLcCode"]["msg"]);

				//생성일 결과에 따라서 색 변경
				if(data["shipmntLcCode"]["result"] == false){
					shipmntLcCodeResult.css("color", "red");
				}
				else{
					shipmntLcCodeResult.css("color", "blue");
				}
			}
			
			var str = "";
			var trCnt = Number($("#topRepr").val());
			
			//바코드 tr 생성
			for(var i=0; i<trCnt; i++){
				str += "<tr class='resultTr'>";
				str += "<th>바코드"+(i+1)+"</th>";
				
				//합격
				if(data["indiviBrcd"+(i+1)]["result"] == true){
					str += "<td style='color:blue;'>"+data["indiviBrcd"+(i+1)]["msg"]+"</td>";
				}
				//불합격
				else{
					str += "<td style='color:red;'>"+data["indiviBrcd"+(i+1)]["msg"]+"</td>";
				}
				
				str += "<td>"+($("#brcd"+(i+1)).val() ? $("#brcd"+(i+1)).val() : "")+"</td>";
				str += "</tr>";
			}
			resultTable.append(str);
			
			if(data["result"] == false){
				if(data["data"]){

					//제조부서 불합격
					if(data["deptCode"]["result"] == false){
						alert("${msg.C000001197}"); /* 제조팀 불합격 */
					}else if(data["brcdCreatDte"]["result"] == false){
						alert("${msg.C000001198}"); /* 생성일 불합격 */
					}else if(data["brcdCreatDte"]["result"] == false){
						alert("${msg.C000001198}"); /* 생성일 불합격 */
					}else if(data["shipmntLcCode"]["result"] == false){
						alert("출하처 불합격"); /* 출하처 불합격 */
					}
					else{

						alert("${msg.C000001199}");	/* 바코드를 확인해 주세요 */
						
					}
				}
				else{
					if(data["vrifyAt"]){
						alert(data["vrifyAt"]["msg"]);
						resultLable.text(resultLable.text() + " (" + data["vrifyAt"]["msg"] + ")");
					}
					else{
						alert("${msg.C000001199}"); /* 바코드를 확인해 주세요 */
					}
					
				}				
			}
			
			setTimeout(function() {
				//합격 했을때 바코드 지우고 포커스 주기
				var tdBrcdInput = $("#tdBrcd").find("input");
				var tdBrcdInputLength = tdBrcdInput.length;
				
				for(var i=0; i<tdBrcdInputLength; i++){
					tdBrcdInput[i].value = "";
				}
				
				resultTable.show();
				hideLoadingbar();
				$("#brcdValidForm").find("input,select").prop("disabled", false);
				$("#brcdValidForm").find("select").css("background-color", "#FFFFFF");
				//첫번째 바코드에 포커스 주기
				$("#brcd1").focus();
			}, 50);
			
		});
		
		
	}
	else{
		alert("${msg.C000000743}");//바코드를 전부 입력해 주세요.
		return;
	}
}

//post url
function XMLHttpRequestParams(url, params, callbackfnc){
	
	var xmlhttp;
	
	if (window.XMLHttpRequest) {
	   // code for modern browsers
	   xmlhttp = new XMLHttpRequest();
	}
	else{
	   // code for old IE browsers
	   xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	
	xmlhttp.open('POST', url, true);
	
	//Send the proper header information along with the request
	xmlhttp.setRequestHeader('Content-type', 'application/json; charset=utf-8');
	
	//Call a function when the state changes.
	xmlhttp.onreadystatechange = function() {
	    if(xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	    	callbackfnc(JSON.parse(xmlhttp.responseText))
	    }
	}
	
	xmlhttp.send(JSON.stringify(params));
}


function showLoadingbar() {
    $("#wrap-loading").show();
}	

function hideLoadingbar() {
    $("#wrap-loading").hide();
}

function ajaxJsonParam(url, param, successfunction, completefunction){
	return $.when($.ajax({
		url : url,
        method: "post",
        type: "json",
        async: true,
        contentType: "application/json; charset=utf-8",
        data : JSON.stringify(param),
        beforeSend : function(xmlHttpRequest){
            xmlHttpRequest.setRequestHeader("AJAX", "true"); // ajax 호출을  header에 기록
            xmlHttpRequest.setRequestHeader("Async", true);
        }
	})).done(function(data,status,request){
		if(successfunction != undefined && successfunction != null)
    		successfunction(data);
	}).fail(function(request,status,error) {
		hideLoadingbar();
		if(request.status == 401) {
    		alert("${msg.C000001200}"); /* 다시 로그인하여야 합니다. */
    		document.location.href="/logout.lims";
    		throw "Request failed.";
    	} else if(request.status == 404){
    		alert("${msg.C000001201}"); /* 요청하신 주소를 찾을 수 없습니다. */
    	} else {
    		if(request.responseText != undefined){
    			var errorlog = JSON.parse(request.responseText);
    			alert("${msg.C000000070} (" + errorlog.error.excpLogSeqno + ")") ; /* 에러가 발생했습니다. */
    			throw "Request failed.";
    		}
    	}
	}).always(function(request,status){
    	if(completefunction != undefined && completefunction != null)
    		completefunction(request,status);
	});
}
</script>
</head>
<body>
<div class="subContent" >
	<div class="subCon1">
		<h2>바코드 검증</h2> <!-- 바코드 검증 -->
		<form id="brcdValidForm">
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">	
				<colgroup>
					<col style="width:7%"></col>
					<col style="width:15%"></col>
					<col style="width:7%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
				</colgroup>				
				<tr style="width:700px; !impo">
					<th>제조</th> <!-- 제조 -->
					<td style="text-align:left;" colspan="7">
						<select id="deptCode" name="deptCode" class="wd100p" style="min-width:10em;">
							<option value="3974"> 제조1팀 </option> <!-- 제조1팀 -->
							<option value="3975"> 제조2팀 </option> <!-- 제조2팀 -->
							<option value="3976"> 제조3팀	</option> <!-- 제조3팀 -->
							<option value="3977"> 제조4팀	</option> <!-- 제조4팀 -->
							<option value="3980"> 훽트제조팀</option> <!-- 훽트제조팀 -->
							<option value="3978"> 파주제조팀</option> <!-- 파주제조팀 -->
						</select>
					</td>
					
							
				</tr>
				<tr>
					<th>바코드 수</th><!-- 바코드 수 -->
					<td style="text-align:left;">
						<select id="topRepr" name="topRepr" class="wd100p" style="min-width:10em;">
							<option value="1">1</option> <!-- 1 -->
							<option value="2">2</option> <!-- 2 -->
							<option value="3">3</option> <!-- 3 -->
							<option value="4">4</option> <!-- 4 -->
							<option value="5">5</option> <!-- 5 -->
						</select>
					</td>
					<th>생성일</th><!-- 생성일 -->
					<td style="text-align:left;" colspan="5">
						<input type="text" id="brcdCreatDte" name="brcdCreatDte" class="wd100p">
					</td>
				</tr>
				<tr>
					<th>바코드</th> <!-- 바코드 -->
					<td id="tdBrcd" style="text-align:left;" class="wd20p" colspan="7"></td>	
				</tr>
				<tr>
				<th>출하처</th> <!-- 출하처 -->
					<td style="text-align:left;">
						<input type="checkbox"  name="brValid" checked="checked"  style="width: 3%; vertical-align: middle;"> 검증여부
						<select id="shipmntLcCode" name="shipmntLcCode" class="wd80p" style="min-width:10em; margin-left: 11px;">
							<option value="">없음</option> <!-- 선택 -->
							<option value="P1C1"> 화성 </option> <!-- 제조1팀 -->
							<option value="P1C3"> LSI</option> <!-- 제조2팀 -->
							<option value="P1C4"> 평택 </option> <!-- 제조3팀 -->
							<option value="P1C2"> 천안 </option> <!-- 제조4팀 -->
						</select>
					</td>
					<th>출하일</th>
					<td style="text-align:left;">
						<input type="text" id="dlivyDte" name="dlivyDte" class="wd100p">
					</td>
				</tr>
			</table>
			<div class="mgT15" style="text-align:center; display:none;">
				<button type="button" id="btnVerification" class="old_btn old_btn1 save">바코드 검증</button><!-- 바코드 검증 -->
			</div>
		</form>
	</div>
	
	<div id="resultContent" class="subCon1" style="display:none;">
		검증결과 : <label id="resultLable"></label> <!-- 검증결과 : -->
		<form id="resultForm">			
			<table cellpadding="0" cellspacing="0" width="100%" id="resultTable" class="subTable1" border=1 >	
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:10%"></col>
					<col style="width:80%"></col>
				</colgroup>				
				<tr>
					<th>제조</th> <!-- 제조 -->
					<td>
						<label id="labDeptCodeResult"></label>
					</td>		
					<td>
						<label id="labDeptCode"></label>
					</td>		
				</tr>
				<tr>
					<th>고객사</th> <!-- 고객사 -->
					<td colspan="2">
						<label id="labDvyfgEntrpsNm"></label>
					</td>		
				</tr>
				<tr>
					<th>제품</th> <!-- 제품 -->
					<td id="labMtrilNm" colspan="2"></td>
				</tr>
				<tr>
					<th>자재코드</th> <!-- 자재코드 -->
					<td colspan="2">
						<label id="labBatchNo"></label>
					</td>				
				</tr>
				<tr>
					<th>LOT ID</th> <!-- LOT ID -->
					<td colspan="2">
						<label id="labLotId"></label>
					</td>				
				</tr>
				<tr>
					<th>단위</th> <!-- 단위 -->
					<td colspan="2">
						<label id="labUnitNm"></label>
					</td>				
				</tr>
				<tr>
					<th>생성일</th> <!-- 생성일 -->
					<td>
						<label id="labBrcdCreatDteResult"></label>
					</td>	
					<td>
						<label id="labBrcdCreatDte"></label>
					</td>
				</tr>
				
				<tr>
					<th>출하처</th> <!-- 제조 -->
					<td>
						<label id="shipmntLcCodeResult"></label>
					</td>	
					<td>
						<label id="labShipmntLcCode"></label>
					</td>		
	
				</tr>
	
			</table>
			
		</form>
	</div>
</div>

<!--  body 끝 -->
</body>
</html>