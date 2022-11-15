<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
    <tiles:putAttribute name="title">Tiles 3 Test</tiles:putAttribute>
    <tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
	<div class="subCon1">
		<h2><i class="fi-rr-apps"></i>${msg.C100000306}</h2> <!-- 메뉴 목록 -->
		<div class="btnWrap">
			<button id="btnSearch" class="search" >${msg.C100000767}</button> <!-- 조회 -->
		</div>
		<!-- Main content -->
		<form id="searchFrm" name="searchFrm" onsubmit="return false" >
			<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
				<colgroup>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
					<col style="width:10%"></col>
					<col style="width:15%"></col>
				</colgroup>
				<tr>
					<th>${msg.C100001107}</th> <!-- 메뉴 1차분류 -->
					<td><select id="menuOne" name="menuOne" class="schClass"></select></td>
					<th>${msg.C100001108}</th> <!-- 메뉴 2차분류 -->
					<td><select id="menuTwo" name="menuTwo" class="schClass"></select></td>
					<th>${msg.C100000305}</th> <!-- 메뉴명 -->
					<td><input type="text" id="menuNmSearch" name="menuNmSearch" onsubmit="return false" class="schClass"></td>
					<td colspan="2"></td>
				</tr>
			</table>
		</form>
	</div>
	<div class="subCon2">
		<div id="menuList"></div>
	</div>
	<div class="subCon1 mgT20">
		<h2><i class="fi-rr-apps"></i>${msg.C100000307}</h2> <!-- 메뉴 상세정보 -->
		<div class="btnWrap">
			<button id="btnManual" class="btn5">${msg.C100000302}</button> <!-- 매뉴얼 관리-->
			<button id="btnNew" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
			<button id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
		</div>
		<!-- Main content -->
		<form id="menuDtlFrm" name="menuDtlFrm" onsubmit="return false">
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
					<th>${msg.C100000475}</th> <!-- 상위 메뉴선택 -->
					<td><select class="wd100p" id="upperMenuSeqno" name="upperMenuSeqno"></select><select style="display:none;" class="wd45p" id="menuLv" name="menuLv"></select>
					<th class="necessary">${msg.C100000305}</th> <!-- 메뉴명 -->
					<td><input type="text" name="menuNm" id="menuNm"></td>
					<th>${msg.C100000096}</th> <!-- URL -->
					<td><input type="text" name="menuUrl" id="menuUrl"></td>
					<th>${msg.C100000797}</th> <!-- 정렬순서 -->
					<td><input type="text" name="sortOrdr" id="sortOrdr" maxlength="10" readonly></td>
				</tr>
				<tr>
					<th>${msg.C100000443}</th> <!-- 사용여부 -->
					<td>
						<label><input type="radio" name="useAt" id="useY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" name="useAt" id="useN" value="N">${msg.C100000442}</label> <!-- 사용안함 -->
					</td>
					<th>${msg.C100000303}</th> <!-- 매뉴얼 사용여부 -->
					<td>
						<label><input type="radio" name="mnlUseAt" id="mnlUseY" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
						<label><input type="radio" name="mnlUseAt" id="mnlUseN" value="N">${msg.C100000442}</label> <!-- 사용안함 -->
					</td>
					<th>${msg.C000001375}</th> <!-- 고객사 공개여부 -->
					<td>
						<label><input type="radio" name="ctmmnyOthbcAt" id="ctmmnyOthbcY" value="Y" checked>${msg.C100001087}</label> <!-- 공개 -->
						<label><input type="radio" name="ctmmnyOthbcAt" id="ctmmnyOthbcN" value="N">${msg.C100001088}</label> <!-- 비공개 -->
					</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<th>${msg.C100000308}</th> <!-- 메뉴 설명 -->
					<td colspan = '7'><input type="text" name="menuDc" id="menuDc"></td>
				</tr>
			</table>
			<input type="hidden" name="menuSeqno" id="menuSeqno"/>
			<input type="hidden" name="mnlCn" id="mnlCn"/>
		</form>
	</div>
</div>



<!--  body 끝 -->
    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<!--  script 시작 -->
	<script>
var menuList = 'menuList';
var menuListUrl = "<c:url value='/sys/getMenuMList.lims'/>";
var insUrl = "<c:url value='/sys/insMenuM.lims'/>";
var updUrl = "<c:url value='/sys/updMenuM.lims'/>";
var searchFrm = 'searchFrm';
var menuDtlFrm = 'menuDtlFrm';
var putStatus = 'C';	//  C: insert / U : update
//최초 그리드 생성
var columnLayout = {
		menuList : []
	};


$(function(){
	setCombo();

	setMenuGrid();

	setMenuGridEvent();

	setButtonEvent();

	init();

	$("#btnManual").hide();
});

	function setCombo() {
		ajaxJsonComboBox('/sys/getHirMenuList.lims','upperMenuSeqno',null,false);
		ajaxJsonComboBox('/sys/getMenuLvList.lims','menuLv',null,false);
		//메뉴 1차 분류 콤보
		ajaxJsonComboBox('/sys/getMenuOneList.lims','menuOne',null,false,"${msg.C100000779}"); /* 전체 */
		//메뉴 2차 분류 콤보
		ajaxJsonComboBox('/sys/getMenuTwoList.lims','menuTwo',null,false,"${msg.C100000779}"); /* 전체 */
	}

	function setMenuGrid(){

		auigridCol(columnLayout.menuList, cusPros);
		columnLayout.menuList.addColumnCustom("menuNm","${msg.C100000305}","20%",true,false); /* 메뉴명 */
		columnLayout.menuList.addColumnCustom("menuSeqno","${msg.C100000309}","*",false,false); /* 메뉴 코드 */
		columnLayout.menuList.addColumnCustom("upperMenuSeqno","부모메뉴 코드","*",false,false);
		columnLayout.menuList.addColumnCustom("menuLv","메뉴 분류","*",false,false);
		columnLayout.menuList.addColumnCustom("menuDc","${msg.C100000308}","*",true,false); /* 메뉴설명 */
		columnLayout.menuList.addColumnCustom("menuUrl","${msg.C100000096}","*",true,false); /* URL */
		columnLayout.menuList.addColumnCustom("mnlUseAt","${msg.C100000303}","8%",true,false); /* 매뉴얼 사용 여부 */
		columnLayout.menuList.addColumnCustom("ctmmnyOthbcAt","${msg.C100000189}","8%",true,false); /* 고객사 공개 여부 */
		columnLayout.menuList.addColumnCustom("sortOrdr","${msg.C100000797}","8%",true,false); /* 정렬순서 */
		columnLayout.menuList.addColumnCustom("useAt","${msg.C100000443}","8%",true,false);

		var cusPros = {
				displayTreeOpen : true,
				// 일반 데이터를 트리로 표현할지 여부(treeIdField, treeIdRefField 설정 필수)
				flat2tree : true,
				selectionMode : "multipleCells",
				// 행의 고유 필드명
//	   			rowIdField : "menuNm",
				// 트리의 고유 필드명

				treeIdField : "menuSeqno",
				// 계층 구조에서 내 부모 행의 treeIdField 참고 필드명
				treeIdRefField : "upperMenuSeqno"
		}

		menuList = createAUIGrid(columnLayout.menuList, menuList,cusPros);

		gridResize([menuList]);

// 		AUIGrid.bind(menuList, "ready", function(event) {
// 			gridColResize([menuList],"2");	// 1, 2가 있으니 화면에 맞게 적용
// 		});
	}


	function setMenuGridEvent(){
		AUIGrid.bind(menuList, "cellDoubleClick", function(event) {
			putStatus = 'U';

			detailAutoSet({
				item : event.item,
				targetFormArr : ["menuDtlFrm"]
			});

			//부모 메누코드의 선택된 index값으로 menu의 lv를 선택함. 복잡하다 에휴
			lvAutoSelect();

			$('#sortOrdr').prop('readonly',false);

			/**
			*	LV : 1 -> 전체 메뉴,
			*	LV : 2 -> 1차 메뉴,
			*	LV : 3 -> 2차 메뉴,
			*	LV : 4 -> 3차 메뉴
			*/
			if(event.item.menuLv == '1'){
				warn("${msg.C100000667}"); /* 이 메뉴는 수정할 수 없습니다. */
				$('#btnNew').trigger('click');
			}

			if(event.item.menuLv == '3' || event.item.menuLv == '1'){
				$('#menuUrl').prop('readonly', true);
			}
			else{
				$('#menuUrl').prop('readonly', false);
			}

			if(event.item.mnlUseAt == "Y"){
				$("#btnManual").show();
			}else{
				$("#btnManual").hide();
			}
		});
	}

	function setButtonEvent(){
		$('#btnNew').click(function() {
			// 폼 초기화
			$('#sortOrdr').prop('readonly',true);
			$('#menuUrl').prop('readonly',false);
			$('#menuDtlFrm')[0].reset();
			$("#btnManual").hide();
			//부모 메뉴키에 맞춰서 초기화된거 체인지해줌 ㅠ
			putStatus = 'C'; // 삽입가능상태로 전환
			lvAutoSelect();
		});

		$('#upperMenuSeqno').change(function() {
			//부모 메뉴키 바뀔때마다 같이 체인지해줌 ㅠ
			lvAutoSelect();
		});

		//메뉴1차분류 선택에 따라 메뉴2차분류 콤보박스 값 변경
		$('#menuOne').change(function() {
			var param = {"menuSeqno" : $('#menuOne').val()}
			ajaxJsonComboBox('/sys/getMenuTwoList.lims','menuTwo',param,true);
		});

		$('#btnSearch').click(function(){
			searchMenu();
		});

		$('#btnSave').click(function(){
			saveMenu();
		});

		$('#btnManual').click(function(){
			var pitem = AUIGrid.getSelectedItems(menuList);
			var popItem = pitem[0].item;
			openPopupM("/sys/MenuHelpP.lims?menuSeqno="+btoa(popItem.menuSeqno)+"&menuUrl="+btoa(popItem.menuUrl),"manual",{
				width : "1000",
				height: "650"
			});
		});
	}

	function searchMenu(rowVal) {
		getGridDataForm(menuListUrl, searchFrm, menuList, function() {
			if (!!rowVal)
				gridSelectRow(menuList, "menuNm", rowVal);
		});
	}

	function saveMenu(){
		if ($('#menuNm').val() == null || $('#menuNm').val() == ""){
			warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오 */
			$('#menuNm').focus();
			return;
		}

		var saveVal = $("#"+menuDtlFrm).serializeObject().menuNm;
		if(putStatus == 'C'){
			ajaxJsonForm(insUrl, menuDtlFrm, function (data) {
				if(!!data)
					success("${msg.C100000762}"); /* 저장 되었습니다. */
				$('#menuDtlFrm')[0].reset();
				$("#btnManual").hide();
				searchMenu(saveVal);
			}, function (request,status,error) {
				err("${msg.C100000597}"); /* 오류가 발생했습니다. log를 참조해주세요. */
			});
		} else if(putStatus == 'U'){
			ajaxJsonForm(updUrl, menuDtlFrm, function (data) {
				if(!!data)
					success("${msg.C100000528}"); /* 수정되었습니다. */
				$('#menuDtlFrm')[0].reset();
				searchMenu(saveVal);
			}, function (request,status,error) {
				err("${msg.C100000597}"); /* 오류가 발생했습니다. log를 참조해주세요. */
			});
		}
	}

	//초기 설정 함수
	function init(){
		checkBoxGridEvent(menuList, "menuListChk");

		datePickerCalendar(["dp1","dp2"], true, ["YY",-10]);
		datePickerCalendar(["instPurDt"]);
	}

	function lvAutoSelect(){
		//맨 처음 셀렉트박스 초기화 할때 부모 메누코드의 선택된 index값으로 menu의 lv를 선택함.
		$("#menuLv option:eq(" + $("#upperMenuSeqno option").index($("#upperMenuSeqno option:selected")) + ")").prop('selected',true)
	}

	//팝업 오픈 공통
	//window.open('팝업 주소', '팝업창 이름', '팝업창 설정');
	function openPopupM(url, name, prop){
		/*필요한 속성 Object타입으로 prop에 넘기기.
		    width : 팝업창 가로길이
			height : 팝업창 세로길이
			toolbar=no : 단축도구창(툴바) 표시안함
			menubar=no : 메뉴창(메뉴바) 표시안함
			location=no : 주소창 표시안함
			scrollbars=no : 스크롤바 표시안함
			status=no : 아래 상태바창 표시안함
			resizable=no : 창변형 하지않음
			fullscreen=no : 전체화면 하지않음
			channelmode=yes : F11 키 기능이랑 같음
			left=0 : 왼쪽에 창을 고정(ex. left=30 이런식으로 조절)
			top=0 : 위쪽에 창을 고정(ex. top=100 이런식으로 조절)
		  */
	    var keys = Object.keys(prop);
	    var option = "";
	    for(var i = 0; i<keys.length; i++){
	    	option += keys[i] + "=" + prop[keys[i]] + ", ";
	    }

	    option = option.substring(0,(option.length-1));
	    return window.open(url, name, option);
	}

	//엔터키 이벤트
	function doSearch(e){
		searchMenu();
	}
</script>
<!--  script 끝 -->
</tiles:putAttribute>
</tiles:insertDefinition>

