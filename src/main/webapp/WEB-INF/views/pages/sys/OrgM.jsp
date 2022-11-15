<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">${msg.C100000820}</tiles:putAttribute>
<tiles:putAttribute name="body">
	<div class="subContent">
		<div class="subCon1">
			<h2><i class="fi-rr-apps"></i>${msg.C100000818}</h2> <!-- 조직 목록 -->
			<div class="btnWrap">
				<button id="btn_select" class="search">${msg.C100000767}</button> <!-- 조회 -->
			</div>
			<form id="searchFrm" onSubmit="return false;">
				<table class="subTable1" style="width:100%">
					<colgroup>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
						<col style="width:10%"></col>
						<col style="width:15%"></col>
					</colgroup>
					<tr>
						<th>${msg.C100000476}</th> <!-- 상위 조직 명 -->
						<td><select id="upperInspctInsttCodeSch" name="upperInspctInsttCodeSch"></select></td>

						<th>${msg.C100000821}</th> <!-- 조직명 -->
						<td><input type="text" id="inspctInsttNmSch" name="inspctInsttNmSch" class="schClass"/></td>

						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td style="text-align:left;">
							<label><input type="radio" id="use_allsch" name="useAtSch" value="all" />${msg.C100000779}</label> <!-- 전체 -->
							<label><input type="radio" id="use_ysch" name="useAtSch" value="Y" checked />${msg.C100000439}</label> <!-- 사용 -->
							<label><input type="radio" id="use_nsch" name="useAtSch" value="N" />${msg.C100000449}</label> <!-- 사용안함 -->
						</td>

						<td colspan="2"></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="subCon2">
			<div id="orgGrid" class="wd100p" style="height:300px; margin:0 auto;"></div>
		</div>
		<div class="subCon1 mgT20">
			<h2><i class="fi-rr-apps"></i>${msg.C100000819}</h2> <!-- 조직 정보 -->
			<div class="btnWrap">
				<button id="btn_new" type="button" class="btn4">${msg.C100000569}</button> <!-- 신규 -->
				<button id="btn_save" type="button" class="save">${msg.C100000760}</button> <!-- 저장 -->
			</div>
			<form id="insttForm" onSubmit="return false;" >
				<table class="subTable1" style="width:100%">
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
						<th class="necessary">${msg.C100000476}</th> <!-- 상위 조직 명 -->
						<td><select id="upperInspctInsttCode" name="upperInspctInsttCode" required></select></td>

						<th class="necessary">${msg.C100000821}</th> <!-- 조직명 -->
						<td>
							<input type="text" id="inspctInsttNm" name="inspctInsttNm" maxlength="200" required/>
							<input type="hidden" id="inspctInsttCode" name="inspctInsttCode" />
						</td>

						<th>${msg.C100001260}</th> <!-- 권한 코드  -->
						<td><select id="authorCode" name="authorCode" ></select></td>

						<th>${msg.C100000443}</th> <!-- 사용여부 -->
						<td colspan="1" style="text-align:left;">
							<label><input type="radio" id="use_y" name="useAt" value="Y" checked />${msg.C100000439}</label> <!-- 사용 -->
							<label><input type="radio" id="use_n" name="useAt" value="N" />${msg.C100000449}</label> <!-- 사용안함 -->
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
	<script>
		var crud = 'C';
		var orgGrid = 'orgGrid';
		var searchFrm = 'searchFrm';
		var selectTreeLev = 0;

		$(function(){
			getAuth();

			setCombo();

			setOrgGrid();

			setGridEvent();

			setButtonEvent();

			gridResize([ orgGrid ]);
		});

		function setCombo(){
			//최상위 조직 콤보박스
			// ajaxJsonComboBox('/wrk/getBestComboList.lims','#bestInspctInsttCode',null,null,null,'${UserMVo.bestInspctInsttCode}');  //조직정보 사업장명
			ajaxJsonComboBox('/wrk/getAuthorCodeList.lims','#authorCode',null,true,null);
			
			//상위 조직 콤보박스
			var bestInspctInsttObj = {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'};
			ajaxJsonComboBox('/wrk/getUpperComboList.lims','#upperInspctInsttCodeSch',bestInspctInsttObj,true); //조직목록 상위조직명
			ajaxJsonComboBox('/wrk/getUpperComboList.lims','#upperInspctInsttCode',bestInspctInsttObj,true); //조직정보 상위조직명
		}

		function setOrgGrid(){
			var orgCol = [];
			auigridCol(orgCol);

			var useAtPros = { showStateColumn : true };

			orgCol.addColumnCustom('inspctInsttNm','${msg.C100000821}','*',true,false) //조직명
			.addColumnCustom('inspctInsttCode','inspctInsttCode','*',false,false) //조직코드
			.addColumnCustom('upperInspctInsttCode','upperInspctInsttCode','*',false,false) //상위조직코드
			.addColumnCustom('bestInspctInsttCode','bestInspctInsttCode','*',false,false) //사업장코드
			.addColumnCustom('sapPlantCode','${msg.C100001015}','*',false,false) //SAP PLANT 코드
			.addColumnCustom('authorNm','${msg.C100001260}','*',true,false) //권한 코드
			.addColumnCustom('useAt','${msg.C100000443}','*',true,false); //사용여부

			var cusPros = {
				editable : false,
				displayTreeOpen : true,
				flat2tree : true,
				selectionMode : 'multipleCells',
				treeIdField : 'inspctInsttCode',
				treeIdRefField : 'upperInspctInsttCode'
			};

			orgGrid = createAUIGrid(orgCol, 'orgGrid', cusPros);

			AUIGrid.bind(orgGrid, 'ready', function(event) {
				gridColResize([orgGrid], "2");	// 1, 2가 있으니 화면에 맞게 적용
			});
		}

		function setGridEvent() {
			AUIGrid.bind(orgGrid, "cellDoubleClick", function(event) {
				$('#insttForm')[0].reset();
				crud = 'U';
				$('#inspctInsttCode').val(event.item.inspctInsttCode);
				// $('#bestInspctInsttCode').val(event.item.bestInspctInsttCode);
				$('#authorCode').val(event.item.authorCode);

				var bestInspctInsttCodeObj = {'bestInspctInsttCode' : event.item.bestInspctInsttCode};
				ajaxJsonComboBox('/wrk/getUpperComboList.lims','upperInspctInsttCode',bestInspctInsttCodeObj,null,null,null,null,function(data) {
					$('#upperInspctInsttCode').val(event.item.upperInspctInsttCode);
				});
				$('#inspctInsttNm').val(event.item.inspctInsttNm);
				if('Y' == event.item.useAt) {
					$("#use_y").prop("checked", true);
				} else {
					$("#use_n").prop("checked", true);
				}

				if(event.item.insttmLv == 1) {
					disableItem(true);
				} else if(event.item.insttmLv == 2) {
					$('#inspctInsttNm').prop('readonly', false);
					$('[name=useAt]:not(:checked)').prop('disabled', false);
				} else {
					disableItem(false);
				}
				//수정시 시스템권한자도 사업장박스는 수정할 수 없음.
				// $('[name=bestInspctInsttCode]:not(:selected)').prop('disabled', true);
				selectTreeLev = event.item._$depth; //최상위를 변경하지 못하도록 구분값 세팅
			});
		}

		function setButtonEvent(){
			//(조회, 등록폼)시스템권한 사업장 selecbox open
			//authDisableItem('${UserMVo.authorSeCode}');

			//(조회)상위조직 콤보박스
			/*$('[name="bplcCodeSch"]').change(function(e){
				var schParam = {'bestInspctInsttCode' : e.target.value};
				ajaxJsonComboBox('/wrk/getUpperComboList.lims', 'upperInspctInsttCodeSch', schParam, true, null, '${msg.C100000480}');
			});*/

			//(등록)상위조직 콤보박스
			/*$('[name="bestInspctInsttCode"]').change(function(e){
				var formParam = {'bestInspctInsttCode' : e.target.value};
				ajaxJsonComboBox('/wrk/getUpperComboList.lims', 'upperInspctInsttCode', formParam, true, null, '${msg.C100000480}');
			});*/

			//조회
			$('#btn_select').click(function(){
				searchOrg();
			});

			//신규
			$('#btn_new').click(function(){
				crud = 'C';
				$('#inspctInsttCode').val('');
				$('#insttForm')[0].reset();
				disableItem(false);
				// ajaxJsonComboBox('/wrk/getBestComboList.lims','#bestInspctInsttCode',null,null,null,'${UserMVo.bestInspctInsttCode}');  //조직정보 사업장명
				$("#upperInspctInsttCode option:eq(0)").prop("selected", true);
			});

			//저장
			$('#btn_save').click(function(){
				if(selectTreeLev == 1) {
					warn('${msg.C100000875}');
				} else {
					if(!saveValidation("insttForm")){ return false; }
					saveOrg();
				}
		    });

		}

		//조회
		function searchOrg(rowVal) {
			getGridDataForm('<c:url value="/wrk/getOrgMList.lims"/>', searchFrm, orgGrid, function() {
				if (rowVal)
					gridSelectRow(orgGrid, "inspctInsttNm", rowVal);
			});
		}

		//저장
		function saveOrg(){

			disableItem(false);
			// $('[name=bestInspctInsttCode]:not(:selected)').prop('disabled', false);

			if('C' == crud) {
				var crudUrl = '<c:url value="/wrk/insOrgM.lims"/>';
			} else {
				var crudUrl = '<c:url value="/wrk/updOrgM.lims"/>';
			}

			var frmParam = $('#insttForm').serializeObject();
			customAjax({
				url : crudUrl,
				data : frmParam
			}).then(function(data) {
				success('${msg.C100000762}'); /* 저장 되었습니다. */
				//authDisableItem('${UserMVo.authorSeCode}');
				disableItem(false);
				searchOrg(frmParam.inspctInsttNm); // 그리드 초기화
				$('#btn_new').click();
			});

		}

		/*function authDisableItem(auth) {
			if(auth == 'SY09000001') {
				$('[name=bestInspctInsttCode]:not(:selected)').attr('disabled',false);
			} else {
				$('[name=bestInspctInsttCode]:not(:selected)').prop('disabled', true);
			}
		}*/

		//초기화
		function disableItem(flag){
			selectTreeLev = 0;
			//authDisableItem('${UserMVo.authorSeCode}');
			$('#inspctInsttNm').prop('readonly', flag);
			$('[name=useAt]:not(:checked)').prop('disabled',flag);
		}

		function doSearch(e){
			searchOrg();
		};
	</script>
</tiles:putAttribute>
</tiles:insertDefinition>
