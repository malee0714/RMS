<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="body">
<div class="subContent">
	<div class="subCon1">
		
			<h2><i class="fi-rr-apps"></i>${msg.C100000396} <!-- 보관샘플관리 -->
			</h2>
			<div class="btnWrap">
				<button type="button" id="btnDelete" class="delete">${msg.C100000929}</button> <!-- 폐기 -->
				<button type="button" id="btnSearch" class="search">${msg.C100000767}</button> <!-- 조회 -->
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
					<th>${msg.C100000432}</th> <!-- 사업장 -->
					<td>
						<select class="wd100p schClass" id="bplcCodeSch" name="bplcCodeSch"></select>
					</td>
					<th>${msg.C100000717}</th> <!-- 자재 명 -->
					<td>
						<input type="text" class="wd100p schClass" name="mtrilSch" id="mtrilSch" maxLength="200" autocomplete="off"/>
					</td>
					<th>${msg.C100000056}</th> <!-- Lot No. -->
					<td>
						<input type="text" class="wd100p schClass" name="lotNoSch" id="lotNoSch" maxLength="20"  autocomplete="off">
					</td>
					<th>${msg.C100000657}</th> <!-- 의뢰 번호 -->
					<td>
						<input type="text" class="wd100p schClass" name="reqestNoSch" id="reqestNoSch" maxLength="11"  autocomplete="off">
					</td>
				</tr>
				<tr>
					<th>${msg.C100000139}</th> <!-- 검사 유형 -->
					<td>
						<select class="wd100p schClass" id="inspctTyCodeSch" name="inspctTyCodeSch"></select>
					</td>
					<th class="necessary"><select id="schDteID" name="schDteID" style="width: 70%; border: none; text-align-last: center;">
						<option value="mnfctur">${msg.C100000803}</option>  <!-- 제조 일자 -->
						<option value="reqest">${msg.C100000659}</option>   <!-- 의뢰 일자 -->
						<option value="dsuse">${msg.C100000933}</option> 	<!-- 폐기 일자 -->
					</select></th>
					<td>
						<input type="text" id="schBeginDte" name="schBeginDte" class="dateChk wd6p schClass" style="min-width:6em;" autocomplete="off"required>
                        ~
                        <input type="text" id="schEndDte" name="schEndDte" class="dateChk wd6p schClass" style="min-width:6em;" autocomplete="off"required>
					</td>
					<th>${msg.C100000937}</th> <!-- 폐기 여부 -->
					<td>
						<label><input type="radio" id="validTmlmtTrget_all" name="dsuseAtSch" value="" checked>${msg.C100000779}</label> <!-- 전체 -->
						<label><input type="radio" id="validTmlmtTrget_y" name="dsuseAtSch" value="Y" >${msg.C100000999}</label> <!-- 보관 -->
						<label><input type="radio" id="validTmlmtTrget_n" name="dsuseAtSch" value="N" >${msg.C100000929}</label> <!-- 폐기 -->
					</td>
					<th>${msg.C100000846}</th> <!-- 진행상황 -->
					<td>
						<select id="progrsSittnCodeSch" name="progrsSittnCodeSch">
							<option>${msg.C100000480}</option>  <!-- 선택 -->
						</select>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
		<div id="cstdySmpleGrid" style="width:100%; height: 550px; margin:0 auto;" class="grid"></div>
	</div>
</div>

    </tiles:putAttribute>
<tiles:putAttribute name="script">
<style>
	.rowStyle-red{
		background-color : #FEDBDE
	}
	.rowStyle-sky{
		background-color : #A1D0FF
	}
</style>
<script>
	$(function(){
		setCombo();//콤보박스 셋팅
		
		setResultInputMGrid();  //그리드 생성
		
		setResultInputMGridEvent(); //그리드 이벤트
		
		gridResize([cstdySmpleGrid]);
		
		setButtonEvent();//버튼 이벤트
		
		setEtcEvent();
	});
</script>
<script>
	var cstdySmpleGrid = "cstdySmpleGrid" //의뢰목록 그리드
	var lang = ${msg}; //기본언어
	
	function setCombo(){
		datePickerCalendar(["schBeginDte","schEndDte"],true,["DD",-7]);
		ajaxJsonComboBox('/com/getCmmnCode.lims','inspctTyCodeSch',{'upperCmmnCode' : 'SY07'},true,null); /* 검색 검사유형 */
		ajaxJsonComboBox('/com/getCmmnCode.lims','progrsSittnCodeSch',{'upperCmmnCode' : 'IM03'},true,null); /* 검색 검사유형 */
	}
	
	function setResultInputMGrid(){
		var columnLayout = {
			cstdySmpleCol : []
		};

		var groupGridColPros = {
		style : "my-require-style",
		headerTooltip : { // 헤더 툴팁 표시 일반 스트링
			show : true,
			tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
		}
		,editRenderer : {
			type : "CalendarRenderer", // 조건에 따라 editRenderer 사용하기. conditionFunction 정의 필수
			onlyCalendar : false, // 사용자 입력 불가, 즉 달력으로만 날짜입력 (기본값 : true)
			showExtraDays : true, // 지난 달, 다음 달 여분의 날짜(days) 출력
			defaultFormat  : "yyyy-mm-dd", // 실제 데이터 형식을 어떻게 표시할지 지정
			showEditorBtnOver : true,// 마우스 오버 시 에디터버턴 출력
            validator : function(oldValue, newValue, rowItem) { // 에디팅 유효성 검사

                var isValid = true;
                var pattern = /^[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
                var isValid = (pattern.test(newValue)) ? true : false
                if(newValue==null || newValue ==''){
                	isValid= true;
                } 
                // 리턴값은 Object 이며 validate 의 값이 true 라면 패스, false 라면 message 를 띄움
                return { "validate" : isValid, "message"  : getFormatDate() + " 형식으로 입력해주세요." };
            }
		}
	};
		var auiGridProps = {
			
			// 가로 스크롤 없이 현재 그리드 영역에 채우기 모드
			fillColumnSizeMode : true,
			
			editable : true
		};
		auigridCol(columnLayout.cstdySmpleCol);
		columnLayout.cstdySmpleCol.addColumnCustom('reqestSeqno','reqestSeqno',null,false)	//의뢰 일련번호
				.addColumnCustom('bplcCode','${msg.C100000432}','*',false,false) 			//사업장
				.addColumnCustom('bplcNm','${msg.C100000432}','*',true,false) 				//사업장
				.addColumnCustom('mtrilNm','${msg.C100000717}','*',true,false) 				//자재명
				.addColumnCustom('reqestNo','${msg.C100000657}','*',true,false) 			//의뢰번호
				.addColumnCustom('inspctTyCode','','*',false,false) 						//검사유형
				.addColumnCustom('inspctTyCodeNm','${msg.C100000139}','*',true,false) 		//검사유형명
				.addColumnCustom('reqestDte','${msg.C100000659}','*',true,false) 			//의뢰일자
				.addColumnCustom('mnfcturDte','${msg.C100000803}','*',true,false) 			//제조일자
				.addColumnCustom('emrgncyAt','${msg.C100000247}','*',true,false) 			//긴급여부
				.addColumnCustom('lotNo','${msg.C100000056}','*',true,false) 				//Lot No.
				.addColumnCustom('vendorLotNo','${msg.C100000961}','*',true,false) 			//협력업체 Lot No.
				.addColumnCustom('reqestDeptCode','${msg.C100000666}','*',false,false)		//의뢰팀
				.addColumnCustom('clientId','${msg.C100000665}','*',false,false) 			//의뢰자
				.addColumnCustom('reqestDeptNm','${msg.C100000666}','*',true,false) 		//의뢰팀명
				.addColumnCustom('clientNm','${msg.C100000665}','*',true,false) 			//의뢰자명
				.addColumnCustom('rereqestNum','${msg.C100000757}','*',true,false) 			//재의뢰건수
				.addColumnCustom("validPdCycle","${msg.C100000640}",null,true,false) 				/* 유효 기간 주기*/
				.addColumnCustom("validPdCycleCode","",null,false,false) 					/* 유효기간 주기코드*/
				.addColumnCustom("validDte","${msg.C100000641}",null,true,false) 			/* 유효 일자 */
				.addColumnCustom("dsuseDte","${msg.C100000933}",null,true,true,groupGridColPros) 	/* 폐기 일자 */
				.addColumnCustom("duspsnId","",null,false,false) 								  	/*폐기자 ID */
				.addColumnCustom("duspsnNm","${msg.C100000938}",null,true,false) 						      	/*폐기자명 */
				.addColumnCustom('progrsSittnCode','','*',false,false) 								//진행상황코드
				.addColumnCustom('progrsSittnCodeNm','${msg.C100000846}','*',true,false) 			//진행상황코드명
				.addColumnCustom('rm','${msg.C100000425	}','*',true,false); 							//비고
// 				columnLayout.cstdySmpleCol.calendarRenderer(["dsuseDte"]);

		cstdySmpleGrid = createAUIGrid(columnLayout.cstdySmpleCol, cstdySmpleGrid,auiGridProps);

		gridResize([cstdySmpleGrid]);
		
		AUIGrid.bind(cstdySmpleGrid, "ready", function(event) {
			gridColResize(cstdySmpleGrid,"2");
		});
		
	}
	
	function setResultInputMGridEvent(){
 	}
	
	//버튼 클릭 이벤트 
	function setButtonEvent(){
		// 조회폼 enter key event
		$(".schClass").keypress(function(e) {
			setTimeout(function() {
				if(e.which == 13) {
					if(typeof(CstdySmpleSch) != "undefined") {
						CstdySmpleSch();
					}
				}
			}, 100);
		});

		$("#btnSearch").click(function(){

			CstdySmpleSch();
		});

		$("#btnDelete").click(function(){
			CstdySmpleDel();
		});
		
 	}
	 function CstdySmpleSch(){
		//	AUIGrid.clearGridData(cstdySmpleGrid);
		 if(!saveValidation('searchFrm')){ return false; }
			getGridDataForm('<c:url value="/req/getCstdyList.lims"/>', "searchFrm", cstdySmpleGrid);
		 }
	function CstdySmpleDel(){
		var editdata = AUIGrid.getEditedRowItems(cstdySmpleGrid);
		if(editdata != 0){
		customAjax({url:"/req/delRequestCntList.lims",data:editdata}).then(function(data) {
			if(data==0){
				err('${msg.C100000597}');//저장에 실패하였습니다.
			}
			else{
				success('${msg.C100000762}');//저장 되었습니다.
				CstdySmpleSch();
			}
		});
	    }
		else{
			alert('${msg.C100000881}');//추가 된 항목이 없습니다.
		}
	}
	
	
	//각종 이벤트 모음
	function setEtcEvent(){
		datePickerCalendar(["reqestBeginDte","reqestEndDte"],true,["DD",-30], ["DD",0]);//의뢰일자 조회조건
		datePickerCalendar(["mnfcturBeginDte","mnfcturEndDte"],true,["DD",-30], ["DD",0]);//제조일자 조회조건
	}
</script>
<!--  script 끝 -->
	</tiles:putAttribute>    
</tiles:insertDefinition>