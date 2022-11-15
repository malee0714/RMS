<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">
		<!-- CKEditor -->
		<script src="/ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
		<div class="subContent" id="top_wrap">
			<div class="subCon1" >
				<h2><i class="fi-rr-apps"></i>
					${msg.C100000147} <!-- 게시판 글 목록 -->
				</h2>
				<div class="btnWrap">
					<button id="addWriteBtn" class="btn5">${msg.C100000227}</button> <!-- 글쓰기 -->
					<button id="searchBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
				</div>
				<!-- Main content -->
				<form action="javascript:;" id="noticeWriteSch" name="noticeWriteSch">
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
							<th>${msg.C100000146}</th> <!-- 게시판 구분 -->
							<td>
								<select id="bbsCodeSch" name="bbsCodeSch" class="wd100p" style="min-width: 10em;">
								<!-- <option value="" selected="selected">선택</option> -->
								</select></td>
							<th>${msg.C100000802}</th> <!-- 제목 -->
							<td>
								<input type="text" id="sjSch" name="sjSch" class="wd100p schClass">
							</td>
							<th>${msg.C100000730}</th> <!-- 작성자 -->
							<td>
								<input type="text" id="wrterIdSch" name="wrterIdSch" class="wd100p schClass">
							</td>
							<th class="necessary">${msg.C100000728}</th> <!-- 작성일자 -->
							<td style="text-align:left;">
								<input type="text" id="writngDeStart" name="writngDeStart" class="wd6p dateChk schClass" style="min-width: 6em;" required>
								~
								<input type="text" id="writngDeFinish" name="writngDeFinish" class="wd6p dateChk schClass" style="min-width: 6em;" required>
							</td>
						</tr>
					</table>

					<!-- 					<input type="hidden" id="answerSeqno" name="answerSeqno"/> -->
					<!-- 					<input type="hidden" id="AnswersntncSeqno" name="sntncSeqno"/> -->

				</form>
			</div>
			<div class="subCon2">
				<div class="mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="noticeWriteGrid" style="width: 100%; height: 300px; margin: 0 auto;"></div>
				</div>
			</div>
			<div class="subCon1 mgT20" id="noticeWriteArticle">
				<!-- 			답변 html -->
				<h2><i class="fi-rr-apps"></i>${msg.C100000145} <!-- 게시글 --></h2>


				<div class="btnWrap">
					<button id="btn_new" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
					<button id="btn_Answer" class="btn5">${msg.C100000272}</button> <!-- 답변 -->
					<button id="btn_delete" style="display: none" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
					<button id="btn_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
					<input type="hidden" id="btnSave_file" value="첨부파일">
				</div>
				<form id="noticeWriteForm" name="noticeWriteForm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="noticeWritetbl">
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
							<th class="necessary">${msg.C100000802}</th> <!-- 제목 -->
							<td>
								<input type="text" id="sj" name="sj" class="wd100p" style="min-width: 10em;">
							</td>
							<th>${msg.C100000042}</th> <!-- E-MAIL -->
							<td>
								<input type="text" id="email" name="email" class="wd100p" style="min-width: 10em;">
							</td>
							<th>${msg.C100000924}</th> <!-- 팝업등록 -->
							<td>
								<label><input type="radio"	id="popupAtY" class="popupAt" name="popupAt" value="Y">${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" id="popupAtN" class="popupAt" name="popupAt" value="N" checked>${msg.C100000442}</label> <!-- 사용안함 -->
							</td>
							<th>${msg.C100000923}</th> <!-- 팝업기간 -->
							<td style="text-align:left;">
								<input type="text" id="popupBeginDe" name="popupBeginDe" class="wd6p" style="min-width: 6em;">
								~
								<input type="text" id="popupEndDe" name="popupEndDe" class="wd6p" style="min-width: 6em;">
							</td>
						</tr>
						<tr>
							<th>${msg.C100000259}</th> <!-- 내용 -->
							<td colspan="7">
								<div>
									<div id="cn" name="cn" class="wd100p" style="min-width: 10em;"></div>
								</div>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부파일 -->
							<td colspan="7">
								<div id="dropzoneArea_noticeWrite"></div>
								<input type="hidden" id="atchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width: 10em;">
								<input type="hidden" id="btn_file_save">
							</td>
						</tr>
					</table>
					<input type="hidden" id="bbsCode" name="bbsCode" />
					<input type="hidden" id="sntncSeqno" name="sntncSeqno" />
					<input type="hidden" id="gridCrud" name="gridCrud" value="C" />
				</form>
			</div>

			<div class="subCon1 mgT20" id="noticeAnswerArticle">
				<h3>${msg.C100000272}</h3> <!-- 답변 -->
				<div class="btnWrap">
					<button id="btn_Answer_save" class="save">${msg.C100000760}</button> <!-- 저장 -->
					<button id="btn_Answer_delete" style="display: none" class="delete">${msg.C100000458}</button> <!-- 삭제 -->
					<input type="hidden" id="btnSave_answer_file" value="첨부파일">
				</div>
				<form id="noticeAnswerForm" name="noticeAnswerForm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1" id="noticeAnswertbl">
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
							<th>${msg.C100000275}</th> <!-- 답변자 -->
							<td colspan="3">
								<input type="text" id="answrrId" name="answrrId" class="wd100p" style="min-width: 10em;" disabled>
							</td>

							<th>${msg.C100000274}</th> <!-- 답변일 -->
							<td>
								<input type="text" id="answerDe"name="answerDe" class="wd100p" style="min-width: 10em;" disabled>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000259}</th> <!-- 내용 -->
							<td  colspan="7">
								<div>
										<div id="answerCn" name="answerCn" class="wd100p" style="min-width: 10em;"></div>
								</div>
							</td>
						</tr>
						<tr>
							<th>${msg.C100000860}</th> <!-- 첨부파일 -->
							<td colspan="7">
								<div id="dropzoneArea_answerWrite"></div>
								<input type="hidden" id="answerAtchmnflSeqno" name="atchmnflSeqno" class="wd33p" style="min-width: 10em;">
								<input type="hidden" id="btn_Answer_file_save">
							</td>
						</tr>
					</table>
					<input type="hidden" id="noticeAnswerSeqno" name="answerSeqno" />
					<input type="hidden" id="noticeAnswersntncSeqno" name="sntncSeqno" />
					<input type="hidden" id="AnswerGridCrud" name="gridCrud" value="C" />
				</form>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">
	<style>
		.ck-editor__editable_inline{min-height:300px;}
	</style>
		<script>
/*******전역변수*********/
var noticeWriteGrid = 'noticeWriteGrid';
var noticeWriteSch = 'noticeWriteSch';
var noticeWriteForm = 'noticeWriteForm';
var noticeAnswerForm = 'noticeAnswerForm';
var comboData;
var comboIndex;
var dropzoneArea_answerWrite;
var dropzoneArea_noticeWrite;
var noticeEditor = "noticeEditor";
ClassicEditor.create( document.querySelector('#cn'),{
	ckfinder : {
		uploadUrl : '/com/ckeditor5ImageUpload.lims'
	}
}).then(function(data) {
	noticeEditor = data;
})['catch'](function(error) {
	console.error(error);
});
var answerEditor = "answerEditor";
ClassicEditor.create( document.querySelector('#answerCn'),{
	ckfinder : {
		uploadUrl : '/com/ckeditor5ImageUpload.lims'
	}
}).then(function(data) {
	answerEditor = data;
})['catch'](function(error) {
	console.error(error);
});

/*******OnLoad*********/
$(function() {

	// 검색 시작일, 종료일 (검색기간 디폴트 7일)
	datePickerCalendar(["writngDeStart"], true, ["DD",-280]);
	datePickerCalendar(["writngDeFinish"], true, ["DD",0]); 

	// 그리드 생성 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setnoticeWriteGrid();

	// 콤보박스 바인딩
	setCombo();

	// 버튼 이벤트
	setButtonEvent();

	// 그리드 이벤트 : 화면에 그리드가 2개 이상인 경우 함수명뒤에 _Master, _Detail 와 같이 분리해서 생성
	setNoticeWriteGridEvent();

	// 그리드 리사이즈
	gridResize([noticeWriteGrid]); // 여러개인 경우 콤마로 구분 gridResize([hldyGrid_Master, hldyGrid_Detail]);
	//파일 드랍존 생성 - maxfile: 파일 최대 갯수
	dropzoneArea_noticeWrite = DDFC.bind().EventHandler("dropzoneArea_noticeWrite", { btnId : "#btn_file_save", maxFiles : 10, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */

	//답변 파일드랍존 생성
	dropzoneArea_answerWrite = DDFC.bind().EventHandler("dropzoneArea_answerWrite", { btnId : "#btn_Answer_file_save", maxFiles : 10, lang : "${msg.C100000867}" } ); /* 첨부할 파일을 이 곳에 드래그하세요. */

	searchnoticeWriteGridorForm();

	setClear();
}); // OnLoad 끝;

// 그리드 생성
function setnoticeWriteGrid(){

		var noticeWriteCol = [{
			headerText : "${msg.C100000272}" /* 답변 */
			, dataField  : "answerCnt"
			, editable: false

			// 라벨 함수: 특정 값을 원하는 값으로 변경
			, labelFunction : function(rowIndex, columnIndex, value, dataField, item) {
		      var valueNumber = Number(value);

		      if(valueNumber > 0)
		           return "Y"; // valueNumber가 1일때 Y
		      else
		           return "N"; // valueNumber가 0일때 N
			}
		}];

		auigridCol(noticeWriteCol);
		if( !!!getLocalStorageValue(getPageGridName(noticeWriteGrid)) ){
			noticeWriteCol.addColumnCustom("sntncSeqno","${msg.C100000966}",null,true,false); /* 글코드 */
			noticeWriteCol.addColumnCustom("sj","${msg.C100000802}",null,true,false); /* 제목 */
			noticeWriteCol.addColumnCustom("wrterNm","${msg.C100000730}",null,true,false); /* 작성자 */
			noticeWriteCol.addColumnCustom("writngDe","${msg.C100000728}",null,true,false); /* 작성일자 */
			noticeWriteCol.addColumnCustom("inqireCnt","${msg.C100000825}",null,true,false); /* 조회수 */
			noticeWriteCol.addColumnCustom("gridCrud","CRUD구분",null,false,false);
			noticeWriteCol.addColumnCustom("_$uid","_$uid구분",null,false,false);

			// 그리드 생성
			noticeWriteGrid = createAUIGrid(noticeWriteCol, noticeWriteGrid);
		} else {
			noticeWriteGrid = createAUIGrid( getLocalStorageValue(getPageGridName(noticeWriteGrid)) ,noticeWriteGrid);
		}

};

// 그리드 이벤트
function setNoticeWriteGridEvent(){
	// 칼럼의 순서(dataFiled)를 차례로 sntncSeqno, sj, wrterId, writngDe 순으로 출력시킴.
    AUIGrid.setColumnOrder(noticeWriteGrid, ["sntncSeqno", "sj", "wrterNm", "writngDe","answerCnt","inqireCnt","gridCrud"]);

	// 셀 클릭 이벤트
	AUIGrid.bind(noticeWriteGrid, "cellDoubleClick", function(event) {
		answerEditor.setData("");
		// 콤보 인덱스 채우기
		comboIndex = $('#bbsCodeSch option').index($("#bbsCodeSch option:selected"))-1;

		var countUrl = "<c:url value='/sys/countNoticeWriteM.lims'/>";
		var bbsCode = event.item.bbsCode
		var answerCnt = AUIGrid.getCellValue(noticeWriteGrid, event.rowIndex, "answerCnt");

		datePickerCalendar(["popupBeginDe","popupEndDe"], true, ["DD",0], ["DD",7]);

		// 게시글 코드값 채워주기
		$('#bbsCode').val(event.item.bbsCode)  // 게시판 코드
		$('#sntncSeqno').val(event.item.sntncSeqno) // 게시글 코드

		/* 답변 코드값 채워주기 */
		$('#noticeAnswersntncSeqno').val(event.item.sntncSeqno);

		// 조회수 증가
		ajaxJsonForm(countUrl, 'noticeWriteForm', function (data) {
			/* if(data == 1 ){
			} */
		});
		// 글쓰기 input 보이기
		if(bbsCode){ // 게시판 코드가 있을때만
			$('#btn_delete').show();
			//$('#btn_Answer').show();
			// flag : update로 설정
			$('#gridCrud').val('U'); // crud 구분
			$('#noticeWriteArticle').show();	// 글쓰기 영역 보이기
			$('#sj').val(event.item.sj); //제목
			$('#email').val(event.item.email); // 이메일
			noticeEditor.setData(event.item.cn);
			$("#atchmnflSeqno").val(event.item.atchmnflSeqno);

			// 콤보박스
			$("#bbsCodeSch").val(event.item.bbsCode).prop("selected", true); // 게시판 코드

			// 팝업등록 사용여부
			if(event.item.popupAt == "Y"){
				$('#popupAtY').val(event.item.popupAt).prop("checked", true); // 팝업여부
				$('#popupBeginDe').prop("disabled", false);
				$('#popupEndDe').prop("disabled", false);
				$('#popupBeginDe').val(event.item.popupBeginDe); // 팝업시작일
				$('#popupEndDe').val(event.item.popupEndDe); // 팝업 종료일

			} else {
				$('#popupAtN').val(event.item.popupAt).prop("checked", true); // 팝업여부
				$('#popupBeginDe').prop("disabled", true).val('');
				$('#popupEndDe').prop("disabled", true).val('');
			}

		} else {
			err('${msg.C100000597}') /* 에러가 발생하였습니다. */
		}

		// 답변 여부 확인
		if(answerCnt != 0){ // 답변이 있을 경우
			$('#btn_save').hide(); // 저장버튼 숨기기
			$('#btn_new').hide(); // 신규버튼 숨기기
			$('#btn_Answer').hide(); // 답변버튼 숨기기
			$('#btn_delete').hide(); // 삭제버튼 숨기기
			$('#noticeAnswerArticle').show(); // 답글영역 보이기
			$('#btn_Answer_delete').show(); // 삭제버튼 보이기
			$('#answrrId').prop('disabled', false);
			$('#answerDe').prop('disabled', false);
			$('#answrrId').prop('readonly', true);
			$('#answerDe').prop('readonly', true);
			$('#AnswerGridCrud').val('U');
			dropzoneArea_answerWrite.clear(); // 드랍존 클리어
			getNoticeAnswerForm();

		}else { // 답변이 없을 경우
			$('#btn_save').show();
			$('#btn_new').show();
			$('#btn_delete').show();
			$('#answrrId').prop('disabled', true);
			$('#answerDe').prop('disabled', true);
			$('#answrrId').prop('readonly', false);
			$('#answerDe').prop('readonly', false);
			$('#noticeAnswerArticle').hide(); // 답글영역 숨기기
			$('#btn_Answer_delete').hide(); // 삭제버튼 숨기기
			$('#noticeAnswerForm')[0].reset(); // 답변폼 초기화
			$('#AnswerGridCrud').val('C');

			if(comboData[comboIndex].answerAt == 'Y'){
				$('#btn_Answer').show();
			}
		}
 		dropzoneArea_noticeWrite.getFiles($("#atchmnflSeqno").val()); // 첨부파일
	});

	// ready는 화면에 필수로 구현 할 것
	AUIGrid.bind(noticeWriteGrid, "ready", function(event) {
		gridColResize(noticeWriteGrid, "2");

	});

}


//콤보박스 바인딩
function setCombo(){
	var comboCode = "${board}";

	// 콤보박스 바인딩 함수 (게시판 권한 구분을 위한 함수)
	function myAjaxJsonComboBox(url,obj,param,flag, msg, selectVal, auth, callbackfnc) {
		customAjax({"url":url,"data":param,"successFunc":function(data){
// 		ajaxJsonParam(url,param,function(data){
			comboData = data
			$("#" + obj).empty();
			if(flag)
				$("#" + obj).append("<option value=''>${msg.C100000480}</option>");
			else if(flag == false && msg != undefined)
				$("#" + obj).append("<option value=''>"+ msg +"</option>");
			$(data).each(function(index, entry) {
				$("#" + obj).append("<option value='" + entry["value"] + "'>" + entry["key"] + "</option>");

			});

			if(selectVal != undefined){
				$('#'+obj).val(selectVal);

			}
			if(callbackfnc != undefined && callbackfnc != null){
				callbackfnc();
			}

			if(auth != undefined){
				$('#'+obj + ' option').not(':selected').prop('disabled', true);
			}

			/* 게시판 권한 구분 */
			if(comboCode){
				comboAuth();
			}
		}

		});

	}

	if(comboCode){
		myAjaxJsonComboBox('/sys/getBbsCode.lims','bbsCodeSch',null,true,"",comboCode,true);
	}else{
		myAjaxJsonComboBox('/sys/getBbsCode.lims','bbsCodeSch',null,true,"",comboCode);
	}


}

// 버튼 이벤트
function setButtonEvent(){

	// 조회
	$('#searchBtn').click(function(){
		var noticeCode = $('#bbsCodeSch').val(); // 게시판 구분값
		if(noticeCode){
			setClear();
			searchnoticeWriteGridorForm();

		}else{ // 게시판이 선택되지 않았다면
			alert('${msg.C100000967}'); /* 게시판을 선택해 주세요. */
		}

	});
	
	// 글쓰기
	$('#addWriteBtn').click(function(){
		addWrite();
		setNew();
	});

	// 저장 (벨리데이션 체크)
	$('#btn_save').click(function(){
		var count = 0;
		// 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승
		$('#noticeWriteForm').find('input').each(function(){
			var nm = $(this).attr("name");
    		if( nm == "sj" || nm == "cn"){
			    if(!$(this).prop('required')){
		    		if($(this).val() == '') {
		    			count ++;
		    			return;
			    	}
			    }
	    	}
		});
		// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
		if(count > 0) {
			warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
			return;
		}

		var files_cnt = dropzoneArea_noticeWrite.getNewFiles().length; //새로 추가한 파일 데이터 가져오기
		if (files_cnt > 0){
			$('#btn_file_save').click();
			dropzoneArea_noticeWrite.on("uploadComplete", function(event, fileIdx){
				if (fileIdx == -1) {
					err('${msg.C100000864}') //첨부파일 저장에 실패하였습니다.
				} else {
					$("#atchmnflSeqno").val(fileIdx);
					saveNoticeWriteGridorForm();
				}
			});
		} else {
			saveNoticeWriteGridorForm();
		}
	});

	// 삭제
	$('#btn_delete').click(function(){
		var saveUrl = "<c:url value='/sys/saveNoticeWriteM.lims'/>";
		$('#gridCrud').val('D'); // crud 구분
		var bbsCode = $('#bbsCode').val();
		var sntncSeqno = $('#sntncSeqno').val();
		if(!confirm("${msg.C100000461}")){ /* 삭제하시겠습니까? */
			return false;
		} else {

		if(bbsCode && sntncSeqno){
			// 삭제
			ajaxJsonForm(saveUrl, 'noticeWriteForm', function (data) {
				 if(data > 0){
					success("${msg.C100000462}"); /* 삭제되었습니다. */
					setClear(); // 초기화 함수 호출
					searchnoticeWriteGridorForm(); // 그리드 초기화
				}
			});

		} else {
			err('${msg.C100000597}') /* 에러가 발생했습니다. */
		}
	}

	});

	//신규
	$('#btn_new').click(function(){
		setNew();

	});

	// 답변
	$('#btn_Answer').click(function(){
		$('#AnswerGridCrud').val('C');
		$('#btn_save').hide();
		$('#btn_new').hide();
		$('#btn_Answer').hide();
		$('#btn_delete').hide();
		$('#noticeAnswerArticle').show();
	});

	// 답변 저장
	$('#btn_Answer_save').click(function(){

		var count = 0;
		// 폼 하위 요소중 input 중에 하나라도 입력안된거 있으면 카운트 상승
		$('#noticeAnswerForm').find('input').each(function(){
			var nm = $(this).attr("name");
    		if( nm == "answerCn" ){
			    if(!$(this).prop('required')){
		    		if($(this).val() == '') {
		    			count ++;
		    			return;
			    	}
			    }
	    	}
		});
		// 카운트 있으면 이벤트 터짐. 없으면 이벤트 실행
		if(count > 0) {
			warn('${msg.C100000943}'); /* 필수 사항을 모두 입력해 주십시오 */
			return;
		}

		var files_cnt = dropzoneArea_answerWrite.getNewFiles().length; //새로 추가한 파일 데이터 가져오기
		if (files_cnt > 0){
			$('#btn_Answer_file_save').click();
			dropzoneArea_answerWrite.on("uploadComplete", function(event, fileIdx){
				if (fileIdx == -1) {
					err('${msg.C100000864}') //첨부파일 저장에 실패하였습니다.
				} else {
					$("#answerAtchmnflSeqno").val(fileIdx);
					saveNoticeWriteGridorForm();
				}
			});
		} else {
			saveNoticeWriteGridorForm();
		}
	});

	// 답변 삭제
	$('#btn_Answer_delete').click(function(){
		$('#AnswerGridCrud').val('D');
		saveNoticeAnswerForm();
	});
	$('.popupAt').click(function(){
		var popupChk = $(':input[name=popupAt]:radio:checked').val();

		if(popupChk != 'N'){
			datePickerCalendar(["popupBeginDe","popupEndDe"], true, ["DD",0], ["DD",7]);
			$('#popupBeginDe').prop("disabled", false);
			$('#popupEndDe').prop("disabled", false);
		}

		if(popupChk == 'N'){
			$('#popupBeginDe').prop("disabled", true).val('');
			$('#popupEndDe').prop("disabled", true).val('');
		}
	})

};

/*############ 조회, 저장, 삭제 함수 ############*/

/* 조회 */
function searchnoticeWriteGridorForm(returnSeq){
	if(!saveValidation('noticeWriteSch')) return false;
	var searchUrl = "<c:url value='/sys/getNoticeWriteMList.lims'/>";

	getGridDataForm(searchUrl, noticeWriteSch, noticeWriteGrid, function() {
		if (returnSeq)
			gridSelectRow(noticeWriteGrid, "sntncSeqno", returnSeq);
	});

}


/* 저장 */
function saveNoticeWriteGridorForm(){
	var saveUrl = "<c:url value='/sys/saveNoticeWriteM.lims'/>";
	var data = {
		"sj" : $("#sj").val(),
		"email" : $("#email").val(),
		"popupAt" : $(":radio[name='popupAt']:checked").val(),
		"atchmnflSeqno" : $("#atchmnflSeqno").val(),
		"bbsCode" : $("#bbsCode").val(),
		"sntncSeqno" : $("#sntncSeqno").val(),
		"gridCrud" : $("#gridCrud").val(),
		//"cn" : Editor.getContent().replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, ""),
		//"cn" : Editor.getContent().replace(/<[^>]+>|&nbsp/ig, ""),
		"cn" : noticeEditor.getData(),
		"popupBeginDe" :$("#popupBeginDe").val(),
		"popupEndDe" :$("#popupEndDe").val()
	}


	customAjax({"url":saveUrl,"data":data,"successFunc":function(data){
//    	ajaxJsonParam(saveUrl, data, function (data) {
		if(data == 0){
			err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
		}else{
			success('${msg.C100000762}'); /* 저장 되었습니다. */
			setClear(); // 초기화 함수 호출
			searchnoticeWriteGridorForm(data); // 그리드 초기화
		}
	}
	});
}

/* 답변 조회 함수 */
function getNoticeAnswerForm(){
	var getUrl = "<c:url value='/sys/getNoticeAnswerM.lims'/>";

	ajaxJsonForm(getUrl, "noticeAnswerForm", function (data) {
		if(data){
			$('#answrrId').val(data.answrrId);
			$('#answerDe').val(data.answerDe);
			answerEditor.setData(data.answerCn);
			$('#noticeAnswerSeqno').val(data.answerSeqno); // 코드값 채워주기
			$('#answerAtchmnflSeqno').val(data.atchmnflSeqno);
			answerAtchmnflSeqno
 			dropzoneArea_answerWrite.getFiles(data.atchmnflSeqno); // 첨부파일
		}
	});
}

/* 답변저장 함수 */
function saveNoticeAnswerForm(){
	var saveUrl = "<c:url value='/sys/saveNoticeAnswerM.lims'/>";
	var data = {
		"answrrId" : $("#answrrId").val(),
		"answerDe" : $("#answerDe").val(),
		"atchmnflSeqno" : $("#answerAtchmnflSeqno").val(),
		"answerSeqno" : $("#noticeAnswerSeqno").val(),
		"sntncSeqno" : $("#sntncSeqno").val(),
		"gridCrud" : $("#AnswerGridCrud").val(),
		"answerCn" : answerEditor.getData()
	}
	console.log("answer data : " , data);
	customAjax({"url":saveUrl,"data":data,"successFunc":function(data){
// 	ajaxJsonParam(saveUrl, data, function (data) {

		if(data == 0){
			err('${msg.C100000597}'); /* 저장에 실패하였습니다. */
		} else if(data == 3){
			success('${msg.C100000462}') /* 삭제되었습니다. */
			setClear(); // 초기화 함수 호출
			searchnoticeWriteGridorForm(); // 그리드 초기화
		} else {
			success('${msg.C100000762}'); /* 저장 되었습니다. */
			setClear(); // 초기화 함수 호출
			searchnoticeWriteGridorForm(); // 그리드 초기화
		}
}
	});
}

/*############ 기타이벤트 함수 ############*/

/* 글쓰기 */
function addWrite(){
	var noticeCode = $('#bbsCodeSch').val(); // 게시판 구분값

	if(noticeCode){
		$('#noticeWriteArticle').show();
		$('#bbsCode').val(noticeCode); // 글쓰기 form에 게시판 코드값 입력

	}else{ // 게시판이 선택되지 않았다면
		alert('${msg.C100000967}'); /* 게시판을 선택해 주세요. */
	}
};

/* 초기화 함수 */
function setClear(){

	$('#noticeAnswerForm')[0].reset(); // 답변폼 초기화
	$('#noticeWriteForm')[0].reset(); // 게시글폼 초기화
	$('#noticeWriteArticle').hide();
	$('#btn_delete').hide();
	$('#noticeAnswerArticle').hide(); // 답글영역 숨기기
	$('#btn_Answer_delete').hide(); // 삭제버튼 숨기기
	dropzoneArea_noticeWrite.clear(); // 드랍존 클리어
	dropzoneArea_answerWrite.clear(); // 드랍존 클리어
	$('#gridCrud').val('C'); // flag : create 변경
	$('#AnswerGridCrud').val('C'); // flag : create 변경
};

/* 신규 함수 */
function setNew(){
	$('#noticeWriteForm')[0].reset(); // 폼 초기화
	noticeEditor.setData('');
	$('#noticeAnswerForm')[0].reset(); // 답변폼 초기화
	answerEditor.setData('');
	$('#popupBeginDe').prop("disabled", true).val('');
	$('#popupEndDe').prop("disabled", true).val('');
	$('#btn_save').show();
	$('#btn_new').show();
	$('#btn_Answer').hide();
	$('#btn_delete').hide();
	$('#noticeAnswerArticle').hide(); // 답글영역 숨기기
	$('#btn_Answer_delete').hide(); // 삭제버튼 숨기기
	$("#atchmnflSeqno").val('');
	$("#answerAtchmnflSeqno").val('');
	dropzoneArea_noticeWrite.clear(); // 드랍존 클리어
	$('#gridCrud').val('C'); // flag : create 변경
}

// 게시판 구분 체인지 함수
$('#bbsCodeSch').change(function(){
	setClear();
	searchnoticeWriteGridorForm(); // 그리드 초기화
	comboAuth(); /* 게시판 권한 구분 */
});

/* 게시판 권한 구분 */
function comboAuth(){
	comboIndex = $('#bbsCodeSch option').index($("#bbsCodeSch option:selected"))-1;
	//var userAuth = "${UserMVo.authorSeCode}";
	// 답변 여부
	 if(comboData[comboIndex].answerAt == 'Y'){
		$('#btn_Answer').show();
	}else{
		$('#btn_Answer').hide();
	}

	// 팝업 여부
	if(comboData[comboIndex].popupAt == 'Y'){
		//$('.popupAt').prop('readonly', false)
		$(':input[name=popupAt]:radio:not(:checked)').prop('disabled', false)
	}else{
		//$('.popupAt').prop('readonly', true)
		$(':input[name=popupAt]:radio:not(:checked)').prop('disabled', true)
	}

	// 사용자 글쓰기 여부
	//if(comboData[comboIndex].userSntncwriteAt == 'Y' || userAuth == 'SY09000001'){ // 유저 권한 SY09000001 = 시스템 관리자
	if(comboData[comboIndex].userSntncwriteAt == 'Y' || "${UserMVo.authorSeCode}" == 'SY09000001'){
		$('#addWriteBtn').show();
	}else{
		$('#addWriteBtn').hide();
	}

	// 첨부파일 여부
	if(comboData[comboIndex].atchmnflAt == 'Y'){
		$('#dropzoneArea_noticeWrite').parent().parent().show();
		$('#dropzoneArea_answerWrite').parent().parent().show();
	}else{
		$('#dropzoneArea_noticeWrite').parent().parent().hide();
		$('#dropzoneArea_answerWrite').parent().parent().hide();

	}
}
//이메일 체크
$( '#email' ).change(function(){
	emailChk(this);
});

/* 정규식
*@param obj: input ID값
*/
// 이메일 체크 정규식
function emailChk(obj){
	var emailVal = $(obj).val();
	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	if(!emailVal.match(regExp)){
		warn("${msg.C100000673}"); /* 이메일형식이 올바르지 않습니다. */
		$(obj).val('');
	}
}

//엔터키 이벤트
$(".schClass").keypress(function (e) {
    if (e.which == 13){
    	setClear(); // 폼 초기화
    	searchnoticeWriteGridorForm();
    }
});


</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>
