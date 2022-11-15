<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="title">권한 관리</tiles:putAttribute>
	<tiles:putAttribute name="body">
		<!--  body 시작 -->
		<div class="subContent" style="height: 900px;">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000216}</h2>
				<!-- 권한목록 -->
				<div class="btnWrap">
					<button id="btn_add" onclick="addAuth()" class="btn5"><img src="/assets/image/plusBtn.png"></button> <!-- 행추가 -->
					<button id="btn_remove" onclick="removeAuth()" class="delete"><img src="/assets/image/minusBtn.png"></button> <!-- 행삭제 -->
					<button id="btn_save" class="btn5 save" onclick="saveAuth()">${msg.C100000760}</button> <!-- 저장 -->
					<button id="btn_athSelect" class="search">${msg.C100000767}</button>  <!-- 조회 -->

				</div>
				<!-- Main content -->
				<form id="frmSearch">
					<input type="hidden" id="authorCode" name="authorCode" />
					<table cellpadding="0" cellspacing="0" width="100%"
						   class="subTable1">
						<colgroup>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 15%"></col>
							<col style="width: 10%"></col>
							<col style="width: 40%"></col>
						</colgroup>
						<tr>
							<th>${msg.C100000214}</th> <!-- 권한 그룹명 -->
							<td><label><input type="text" class="wd100p schClass" name="authorNm" id="authorNm"></label></td>


							<th>${msg.C100000452}</th>
							<!-- 사용자 명 -->
							<td><label><input type="text"
											  class="wd100p schClass" name="userId" id="userId"></label></td>
							<th>${msg.C100000443}</th>
							<!-- 사용여부 -->
							<td style="text-align: left;">
								<label><input type="radio" name="useAt" value="">${msg.C100000779}</label> <!-- 전체 -->
								<label><input type="radio" name="useAt" value="Y" checked>${msg.C100000439}</label> <!-- 사용 -->
								<label><input type="radio" name="useAt" value="N">${msg.C100000449}</label> <!-- 사용안함 -->
							</td>
						</tr>
					</table>
				</form>
				<form id="cmCodeFrm">
					<input type="hidden" id="cmCode" name="hirCd" />
				</form>
			</div>
			<div class="subCon2">
				<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
				<div id="userAthGridId" class="mgT15" style="width: 100%; height: 250px; margin: 0 auto;"></div>
			</div>

			<div id="tabMenuLst" class="tabMenuLst round skin-peter-river mgT20">
				<ul id="tabs">
					<li id="tab1" class="tabMenu on">${msg.C100000780}</li> <!-- 전체메뉴 -->
					<li id="tab2" class="tabMenu">${msg.C100000451}</li> <!-- 사용자 -->
				</ul>
			</div>
			<div id="tabCtsLst">
				<div id="tabCts1" class="tabCts">
					<div class="wd45p fL">
						<div class="subCon1">
							<h3>${msg.C100000780}</h3> <!-- 전체메뉴 -->
							<!-- 							<div class="btnWrap"> -->
								<%-- 								<input type="hidden" id="btnExportExcel2" value="${msg.C000000261}"> <!-- 엑셀출력 --> --%>
							<!-- 							</div> -->
						</div>
						<div class = "subCon2">
							<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
							<div id="allMenuGridId" class="mgT15" style="height: 300px;"></div>
						</div>
					</div>


					<div class="arrowWrap wd10p mgT10" style="float: left;">
						<div>
							<button type="button" id="arrow1"><i class="fi-rr-angle-right"></i></button>
						</div>
						<div class="mgT20">
							<button type="button" id="arrow2"><i class="fi-rr-angle-left"></i></button>
						</div>
					</div>

					<div class="wd45p fL">
						<div class="subCon1">
							<h3>${msg.C100000215}</h3> <!-- 권한메뉴 -->
							<div class="btnWrap">
								<button id="btn_save2" class="save" style="display:none">${msg.C100000760}</button> <!-- 저장 -->
									<%-- 								<input type="hidden" id="btnExportExcel3" value="${msg.C000000261}"><!-- 엑셀출력 --> --%>
							</div>
						</div>
						<div class="subCon2">
							<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
							<div id="athMenuGridId" class="mgT15" style="height: 300px;"></div>
						</div>
					</div>
				</div>

				<div id="tabCts2" class="tabCts" style="display:none">
					<div class="wd45p fL">
						<div class="subCon1">
							<h3>${msg.C100000781}</h3> <!-- 전체사용자 -->
							<div class="btnWrap">
								<button id="sAllUserBtn" class="search">${msg.C100000767}</button> <!-- 조회 -->
							</div>
							<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
								<colgroup>
									<col style="width: 20%"></col>
									<col style="width: 30%"></col>
									<col style="width: 20%"></col>
									<col style="width: 30%"></col>
								</colgroup>
								<tr>
									<th>${msg.C100000401}</th>  <!-- 부서 -->
									<td><select id="pDeptCode"></select></td>
									<th>${msg.C100000452}</th> <!-- 사용자 명 -->
									<td><input type="text" id="pUserNm" placeholder="${msg.C100000452}" /></td>
								</tr>
							</table>
						</div>
						<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
						<div class = "subcon2">
							<div id="allUserGridId" class="mgT15" style="height: 300px;"></div>
						</div>
					</div>

					<div class="arrowWrap wd10p mgT10" style="float: left;">
						<div>
							<button type="button" id="arrow3"><i class="fi-rr-angle-right"></i></button>
						</div>
						<div class="mgT20">
							<button type="button" id="arrow4"><i class="fi-rr-angle-left"></i></button>
						</div>
					</div>
					<div class="wd45p fL">
						<div class="subCon1">
							<h3>${msg.C100000217}</h3> <!-- 권한 사용자 -->

							<div class="btnWrap">
								<button id="btn_save3" class="save"  style="display:none">${msg.C100000760}</button><!-- 저장 -->

							</div>
							<!-- Main content -->
							<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
						</div>
						<div id="subCon2">
							<div id="athUserGridId" class="mgT15"
								 style="width: 100%; height: 300px; margin: 0 auto;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--  body 끝 -->
	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<!--  script 시작 -->
		<script>
			// AUIGrid 생성 후 반환 ID
			var userAthGridId = 'userAthGridId'; //권한그룹
			var allMenuGridId = 'allMenuGridId'; //전체메뉴
			var athMenuGridId = 'athMenuGridId'; //권한메뉴
			var allUserGridId = 'allUserGridId'; //전체사용자
			var athUserGridId = 'athUserGridId'; //권한사용자

			var userAthGrid;
			var allMenuGrid;
			var athMenuGrid;
			var allUserGrid;
			var athUserGrid;

			//칼럼 설정
			var columnLayout = {
				userAthGrid : [],
				allMenuGrid : [],
				athMenuGrid : [],
				allUserGrid : [],
				athUserGrid : []
			}

			//권한그룹 속성
			var userPros = {
				editable : true
			};

			//전체메뉴, 권한메뉴 속성
			var customPros = {
				editable : false, // 편집 가능 여부 (기본값 : false)
				selectionMode : "multipleCells", // 셀 선택모드 (기본값: singleCell)
				softRemovePolicy : "exceptNew",
				softRemoveRowMode : true,
				showStateColumn : true,
				//엑스트라체크박스 표시
				showRowCheckColumn : true,
				// 전체 체크박스 표시 설정
				showRowAllCheckBox : true
			};


			$(function() {
				getAuth();

				setCombo();

				// 그리드 생성
				setAuthGrid();

				// 그리드 이벤트
				setAuthGridEvent();

				// 버튼 이벤트
				setButtonEvent();

			});
			function setAuthGrid() {
				//권한그룹
				//공통함수 속성 순서 addColumn : dataField, headerText, width, visible, editable, useContextMenu, enableMovingColumn, enableRightDownFocus, colspan, style, formatString, dataType, cellMerge, cellColSpan, cellColMerge, lableFunction, showIcon

				//컬럼 속성 정의
				var userAthGridColPros = {
					style : "my-require-style",
					headerTooltip : { // 헤더 툴팁 표시 일반 스트링
						show : true,
						tooltipHtml : '${msg.C100000114}' /* 값을 입력 또는 선택하세요. */
					}
					//styleFunction : cellStyleFunction
				};

				var userCheckPros = {
					headerRenderer : {
						type : "CheckBoxHeaderRenderer",
						// 헤더의 체크박스가 상호 의존적인 역할을 할지 여부(기본값:false)
						// dependentMode 는 renderer 의 type 으로 CheckBoxEditRenderer 를 정의할 때만 활성화됨.
						// true 설정했을 때 클릭하면 해당 열의 필드(데모 상은 isActive 필드)의 모든 데이터를 true, false 로 자동 바꿈
						dependentMode : true,
						position : "right" // 기본값 "bottom"
					}
				}
				auigridCol(columnLayout.userAthGrid);
				columnLayout.userAthGrid.addColumnCustom("authorCode","권한 그룹 코드", "*", false, false);
				columnLayout.userAthGrid.addColumnCustom("authorNm","${msg.C100000214}", "*", true, true,userAthGridColPros); /* 권한 그룹명 */
				columnLayout.userAthGrid.addColumnCustom("authorRm","${msg.C100000213}", "*", true, true); /* 권한 그룹설명 */
				columnLayout.userAthGrid.addColumnCustom("sortOrdr","${msg.C100000531}", "5%", true, true,userAthGridColPros); /* 순서 */
				columnLayout.userAthGrid.addColumnCustom("useAt","${msg.C100000443}", "5%", true, true,	userAthGridColPros); /* 사용여부 */
				columnLayout.userAthGrid.dropDownListRenderer([ "useAt" ], ['Y', 'N' ], false);
				columnLayout.userAthGrid.inputEditRenderer(["sortOrdr"],{onlyNumeric : true})
				userAthGrid = createAUIGrid(columnLayout.userAthGrid,userAthGridId, userPros);

				//전체메뉴
				auigridCol(columnLayout.allMenuGrid);
				columnLayout.allMenuGrid.addColumnCustom("menuSeqno", "메뉴 코드",	"8%", false, false);
				columnLayout.allMenuGrid.addColumnCustom("topMenu",	"${msg.C100000474}", null, true); /* 상위메뉴명 */
				columnLayout.allMenuGrid.addColumnCustom("menuNm","${msg.C100000305}", null, true); /* 메뉴명 */

				allMenuGrid = createAUIGrid(columnLayout.allMenuGrid,allMenuGridId, customPros);

				//권한메뉴
				auigridCol(columnLayout.athMenuGrid);
				columnLayout.athMenuGrid.addColumnCustom("menuSeqno", "메뉴 코드","8%", false, false);
				columnLayout.athMenuGrid.addColumnCustom("authorCode","권한 그룹 코드", "20%", false, false);
				columnLayout.athMenuGrid.addColumnCustom("topMenu","${msg.C100000474}", null, true); /* 상위메뉴명 33% */
				columnLayout.athMenuGrid.addColumnCustom("menuNm","${msg.C100000305}", null, true); /* 메뉴명 42% */

				athMenuGrid = createAUIGrid(columnLayout.athMenuGrid,athMenuGridId, customPros);

				//전체사용자
				auigridCol(columnLayout.allUserGrid);
				columnLayout.allUserGrid.addColumnCustom("authorSeCode","권한 그룹 코드", "*", false, false);
				/*columnLayout.allUserGrid.addColumnCustom("bplcCode","${msg.C100000432}", "*", false, false);
				columnLayout.allUserGrid.addColumnCustom("bplcCodeNm","${msg.C100000432}", "*", true, false);*/
				columnLayout.allUserGrid.addColumnCustom("deptNm","${msg.C100000401}", "*", true, false); /* 부서명 */
				columnLayout.allUserGrid.addColumnCustom("userNm","${msg.C100000452}", "*", true, false); /* 사용자 명 */
				columnLayout.allUserGrid.addColumnCustom("userId","사용자 ID", "*", false, false); /* 사용자ID */

				allUserGrid = createAUIGrid(columnLayout.allUserGrid,allUserGridId, customPros);






				//권한 사용자
				auigridCol(columnLayout.athUserGrid);
				columnLayout.athUserGrid.addColumnCustom("authorCode","권한 그룹 코드", "*", false, false);
				columnLayout.athUserGrid.addColumnCustom("deptNm","${msg.C100000401}", "*", true, false); /* 부서명 */
				columnLayout.athUserGrid.addColumnCustom("userNm","${msg.C100000452}", "*", true, false); /* 사용자 명 */
				columnLayout.athUserGrid.addColumnCustom("userId","사용자 ID", "*", false, false); /* 사용자 ID */
				//columnLayout.athUserGrid.addColumnCustom("streAuthorAt","${msg.C100000761}", "*", true, false); /* 저장 권한 */
// 					columnLayout.athUserGrid.addColumnCustom("inqireAuthorAt","${msg.C100000824}", "*", true, false); /* 조회 권한 */
// 					columnLayout.athUserGrid.addColumnCustom("deleteAuthorAt","${msg.C100000459}", "*", true, false); /* 삭제 권한 */
// 					columnLayout.athUserGrid.addColumnCustom("outptAuthorAt","${msg.C100000891}", "*", true, false); /* 출력 권한 */
// 					columnLayout.athUserGrid.checkBoxRenderer(["inqireAuthorAt", "deleteAuthorAt", "outptAuthorAt" ],athUserGridId, null, userCheckPros);

				var addCheckBoxColumns = {
					width : '*',
					headerRenderer : {
						type : "CheckBoxHeaderRenderer",
						dependentMode : true,
						position: 'right' },
					renderer : {
						type : "CheckBoxEditRenderer",
						editable : true	}
				}
				var frstAnalsAtColumn = copyObj(addCheckBoxColumns);
				frstAnalsAtColumn['dataField'] = 'streAuthorAt';
				frstAnalsAtColumn['headerText'] = '${msg.C100000761}';
				columnLayout.athUserGrid.push(frstAnalsAtColumn);

				var secAnalsAtColumn = copyObj(addCheckBoxColumns);
				secAnalsAtColumn['dataField'] = 'inqireAuthorAt';
				secAnalsAtColumn['headerText'] = '${msg.C100000824}';
				columnLayout.athUserGrid.push(secAnalsAtColumn);

				var thrAnalsAtColumn = copyObj(addCheckBoxColumns);
				thrAnalsAtColumn['dataField'] = 'deleteAuthorAt';
				thrAnalsAtColumn['headerText'] = '${msg.C100000459}';
				columnLayout.athUserGrid.push(thrAnalsAtColumn);

				var forAnalsAtColumn = copyObj(addCheckBoxColumns);
				forAnalsAtColumn['dataField'] = 'outptAuthorAt';
				forAnalsAtColumn['headerText'] = '${msg.C100000891}';
				columnLayout.athUserGrid.push(forAnalsAtColumn);

				function copyObj(obj) {
					var result = {};
					for (var key in obj) {
						if (typeof obj[key] === 'object')
							result[key] = copyObj(obj[key]);
						else
							result[key] = obj[key];
					}
					return result;
				}


				athUserGrid = createAUIGrid(columnLayout.athUserGrid,athUserGridId, customPros);

				//그리드 사이즈 조절
				gridResize([ userAthGrid, allMenuGrid, athMenuGrid, allUserGrid, athUserGrid ]);

				AUIGrid.bind(userAthGrid, "ready", function(event) {
					gridColResize(userAthGrid, "2"); // 1, 2가 있으니 화면에 맞게 적용
				});

			}

			function setCombo() {
				ajaxJsonComboBox('/wrk/getDeptComboList.lims','pDeptCode',{"bestInspctInsttCode" : "${UserMVo.bestInspctInsttCode}"},false,"${msg.C100000480}", "${UserMVo.deptCode}"); /* 선택 */
			}

			function setAuthGridEvent() {

				//권한그룹 목록 더블클릭했을때
				AUIGrid.bind(userAthGrid, "cellDoubleClick", function(event) {
					$("#authorCode").val(event.item.authorCode);
					//전체 메뉴 데이터 바인딩
					authorCode = event.item.authorCode;
					tabMenuLst.style.display = "";
					tabCtsLst.style.display = "";
					//탭클릭
					$("#tab1").click();
					setData(authorCode);
					//setUser(authorCode);
					setAthUser(authorCode);


					if(!!authorCode){
						$("#btn_save2").css("display","block");
						$("#btn_save3").css("display","block");
					}
					else{
						$("#btn_save2").css("display","none");
						$("#btn_save3").css("display","none");
					}

				});

				//권한사용자 목록 클릭했을때
				AUIGrid.bind(athUserGrid, "rowStateCellClick", function(event) {
					var stat = getItemState(event.item, athUserGrid);
					if (stat == "Added") { //추가된 상태의 행을 클릭시 전체 사용자의 삭제된 상태를 초기화하고 권한 사용자에서 로우 삭제.
						var clickindex = AUIGrid.getRowIndexesByValue(
								allUserGrid, "userId", event.item.userId);
						AUIGrid.restoreSoftRows(allUserGrid, clickindex);
					}
				});

				//권한메뉴 목록 클릭했을때
				AUIGrid.bind(athMenuGrid, "rowStateCellClick",function(event) {
					var stat = getItemState(event.item, athMenuGrid);
					if (stat == "Added") { //추가된 상태의 행을 클릭시 전체 사용자의 삭제된 상태를 초기화하고 권한 사용자에서 로우 삭제.
						var clickindex = AUIGrid.getRowIndexesByValue(allMenuGrid, "menuSeqno",event.item.menuSeqno);
						AUIGrid.restoreSoftRows(allMenuGrid,clickindex);
					}
				});
			}

			function setButtonEvent() {
				//밑에 전체 메뉴 저장버튼눌렀을때
				$("#btn_save2").click(function() {
					var length = AUIGrid.getSelectedItems(userAthGrid).length;
					if(length<1){
						alert("권한 목록을 선택해 주십시요.");
						return false;
					}
					else{
						saveAuth2(athMenuGrid, "insAthMenu");
					}
				});

				//밑에 전체 사용자 저장버튼눌렀을때
				$("#btn_save3").click(function() {
					saveAuth2(athUserGrid, "insAthUser");
				});

				//오른쪽방향화살표
				$("#arrow1").click(function(data) {
					rightBtnClick("MENU");
				});

				//왼쪽방향화살표
				$("#arrow2").click(function(data) {
					leftBtnClick("MENU");
				});

				//오른쪽방향화살표
				$("#arrow3").click(function(data) {
					rightBtnClick("USER");

				});

				//왼쪽방향화살표
				$("#arrow4").click(function(data) {
					leftBtnClick("USER");
				});

				// 조회
				$('#btn_athSelect').click(function() {
					searchAuth();
				});

				$("#tabs").click(function() {
					AUIGrid.resize(allUserGrid);
					AUIGrid.resize(athUserGrid);

					AUIGrid.resize(allMenuGrid);
					AUIGrid.resize(athMenuGrid);
				});

				$("#sAllUserBtn").click(function() {
					//setUser($("#authorCode").val());
					setAllUser();
				})

				$(".schClass").keypress(function(e) {
					if (e.which == 13) {
						searchAuth();
					}
				});

				$("#pUserNm").keypress(function(e) {
					if (e.which == 13) {
						//setUser($("#authorCode").val());
						setAllUser();
					}
				});

				// $("#bplcCodeSch").change(function() {
				// 	ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'pDeptCode', {'bestInspctInsttCode' : this.value}, true);
				// });
			}

			//저장버튼 눌렀을때 = 행 추가 후 저장하기(위쪽 권한 그룹 관련 저장)
			function saveAuth() {
				// 추가된 행 아이템들(배열)
				var addedRowItems = AUIGrid.getAddedRowItems(userAthGrid, userPros);
				var updedRowItems = AUIGrid.getEditedRowItems(userAthGrid, userPros);
				var gridData = AUIGrid.getGridData(userAthGrid);
				var arr = [];

				if (addedRowItems.length == 0 && updedRowItems.length == 0)
					return false;

				for ( var i in gridData) {
					if (gridData[i].authorNm == undefined || gridData[i].authorNm == '') {
						warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오. */
						return false;
					}
					/* if(gridData[i].authorRm == undefined || gridData[i].authorRm == '') {
						alert("권한 그룹 설명을 모두 입력해 주세요.");
						return false;
					} */
					/* if(gridData[i].sortOrdr == undefined || gridData[i].sortOrdr == '') {
						alert("순서를 모두 입력해 주세요.");
						return false;
					} */
					if (gridData[i].useAt == undefined || gridData[i].useAt == '') {
						warn("${msg.C100000943}"); /* 필수 사항을 모두 입력해 주십시오. */
						return false;
					}
				}

				if (addedRowItems.length > 0)
					athMenuAdd(addedRowItems);
				if (updedRowItems.length > 0)
					athMenuUpd(updedRowItems);

				success("${msg.C100000762}"); /* 저장 되었습니다. */
			};

			//밑쪽 전체 (사용자,메뉴) 그리드 저장 버튼
			function saveAuth2(authGrid, url) {
				var data = 0;

				// 추가/수정/삭제 된 데이터들 가져오기
				var addedRowItems = AUIGrid.getAddedRowItems(authGrid);
				var editedRowItems = AUIGrid.getEditedRowItems(authGrid);
				var removedRowItems = AUIGrid.getRemovedItems(authGrid);

				var data = {
					"addedRowItems" : addedRowItems,
					"editedRowItems" : editedRowItems,
					"removedRowItems" : removedRowItems
				}

				if (data.addedRowItems.length == 0
						&& data.editedRowItems.length == 0
						&& data.removedRowItems.length == 0) {
					alert("${msg.C100000883}"); /* 추가/수정/삭제된 행이 없습니다. */
					return false;
				}
				customAjax({
					"url" : "<c:url value='/sys/"+url+".lims'/>",
					"data" : data,
					"successFunc" : function(data) {
						// 		ajaxJsonParam("<c:url value='/sys/"+url+".lims'/>", data,function(data){
						if (data == "Y") {
							success("${msg.C100000762}"); /* 저장 되었습니다. */
							//setUser($("#authorCode").val());
							setAthUser(authorCode);
							setData($("#authorCode").val());
						}
					}
				});

			}

			//추가버튼
			function addAuth() {
				var item = new Object();
				item.useAt = "Y", AUIGrid.addRow(userAthGrid, item, "last");
// 				tabMenuLst.style.display = "none";
// 				tabCtsLst.style.display = "none";
			};

			//
			function removeAuth() {

				//새로 추가된 행임. 추가된것만 삭제
				if (!AUIGrid.getSelectedItems(userAthGrid)[0]["item"]["authorCode"]) {
					AUIGrid.removeRow(userAthGrid, "selectedIndex");
				}else {
					warn("${msg.C100001182}"); /* 사용여부를 N으로 수정한 후 삭제가 가능합니다. */
				}
			}

			//조회 이벤트
			function searchAuth() {
				setAthGrid();
			}

			//권한 그룹 조회
			function setAthGrid() {
				getGridDataForm("<c:url value='/sys/getAthMList.lims'/>",'frmSearch', userAthGridId);
			}

			//전체메뉴
			function allMenuData(etcFunc) {
				var ajax = getGridDataParam("<c:url value='/sys/getAllMenuList.lims'/>",null, allMenuGrid);
				ajax.then(function(data) {
					if (etcFunc != undefined
							&& typeof etcFunc == "function")
						etcFunc(data);
				});
			}

			//권한메뉴
			function athMenuData(authorCode, etcFunc) {
				$('#authorCode').val(authorCode);
				var param = $("#frmSearch").serializeObject();
				var ajax = getGridDataParam("<c:url value='/sys/getAthMenuList.lims'/>",param, athMenuGrid);
				ajax.then(function(data) {
					if (etcFunc != undefined&& typeof etcFunc == "function") etcFunc(data);
				});
			}


			//밑 그리드 메뉴 데이터 바인딩
			function setData(authorCode) {
				athMenuData(authorCode,function(athData) {
					allMenuData(function(allData) {
						for1:
								//전체메뉴와 권한 메뉴에 중복값이 있으면 전체 사용자에서 제외
								for (var i = allData.length - 1; 0 <= i; i--) {
									for (var i2 in athData) {
										if (allData[i].menuSeqno == athData[i2].menuSeqno) {
											allData.splice(i, 1);
											continue for1;
										}
									}
								}
						AUIGrid.setGridData(allMenuGrid, allData);
						AUIGrid.setGridData(athMenuGrid, athData);
					});
				});

			}

			//전체사용자
			function allUserData(etcFunc) {
				var param = {
					"pUserNm" : $("#pUserNm").val(),
					"deptCode" : $("#pDeptCode").val(),
					// "bplcCodeSch" : $("#bplcCodeSch").val(),
					"authorCode" : $("#authorCode").val()
// 					"limsUseAt" : "Y",
// 					"mmnySeCode" : "${UserMVo.mmnySeCode}"
				}
				var ajax = getGridDataParam("<c:url value='/sys/getAllUserList.lims'/>",param, allUserGrid);
				ajax.then(function(data) {
					if (etcFunc != undefined && typeof etcFunc == "function")
						etcFunc(data);
				});
			}

			//권한사용자
			function athUserData(authorCode, etcFunc) {
				var ajax = getGridDataParam("<c:url value='/sys/getAthUserList.lims'/>",{"authorSeCode" : authorCode}, athUserGrid);
				ajax.then(function(data) {
					if (etcFunc != undefined && typeof etcFunc == "function")
						etcFunc(data);
				});
			}

			//사용자 데이터 바인딩(권한, 전체)
			/* function setUser(authorCode){
				athUserData(authorCode,function(athData){
					for(var i = 0; i<athData.length; i++){
						athData[i].streAuthorAt = athData[i].streAuthorAt == "Y" ? true : false;
						athData[i].inqireAuthorAt = athData[i].inqireAuthorAt == "Y" ? true : false;
						athData[i].deleteAuthorAt = athData[i].deleteAuthorAt == "Y" ? true : false;
						athData[i].outptAuthorAt = athData[i].outptAuthorAt == "Y" ? true : false;
					}
					AUIGrid.setGridData(athUserGrid, athData);
				});


				allUserData(function(allData){
					AUIGrid.setGridData(allUserGrid, allData);
				});
			} */

			function setAllUser() {
				allUserData(function(allData) {
					AUIGrid.setGridData(allUserGrid, allData);
				});
			}

			function setAthUser(authorCode) {
				allUserData(athUserData(
						authorCode,
						function(athData) {
							for (var i = 0; i < athData.length; i++) {
								athData[i].streAuthorAt = athData[i].streAuthorAt == "Y" ? true
										: false;
								athData[i].inqireAuthorAt = athData[i].inqireAuthorAt == "Y" ? true
										: false;
								athData[i].deleteAuthorAt = athData[i].deleteAuthorAt == "Y" ? true
										: false;
								athData[i].outptAuthorAt = athData[i].outptAuthorAt == "Y" ? true
										: false;
							}
							AUIGrid.setGridData(athUserGrid, athData);
						})
				);
			}

			//메뉴 추가
			function athMenuAdd(addedRowItems) {
				return customAjax({
					"url" : "/sys/insAthGroup.lims",
					"data" : addedRowItems,
					"successFunc" : function(){
						searchAuth(); //초기화
					}
				});


			}

			//메뉴 수정
			function athMenuUpd(updedRowItems) {
				return customAjax({
					"url" : "/sys/updAthGroup.lims",
					"data" : updedRowItems,
					"successFunc" : function(){
						searchAuth(); //초기화
					}
				});
			}

			// 체크 행 오른쪽 이동 버턴 클릭
			function rightBtnClick(type) {
				var athGridId = null;
				var allGridId = null;
				if (type == "MENU") {
					athGridId = athMenuGrid;
					allGridId = allMenuGrid;
				} else if (type == "USER") {
					athGridId = athUserGrid;
					allGridId = allUserGrid;
				}

				// 왼쪽 그리드의 체크된 행들 얻기
				var rows = AUIGrid.getCheckedRowItemsAll(allGridId);
				if (rows.length <= 0) {
					alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
					return false;
				}
				for (var i = 0; i < rows.length; i++) {
					rows[i].authorCode = $("#authorCode").val();
					rows[i].streAuthorAt = true;
					rows[i].inqireAuthorAt = true;
					rows[i].deleteAuthorAt = true;
					rows[i].outptAuthorAt = true;
				}

				//중복 제거로직 추가했음.... 왜 없나?
				var existList = AUIGrid.getGridData("#athUserGridId");
				for (var i = 0; i < existList.length; i++) {
					for (var j = 0; j < rows.length; j++) {
						if (existList[i].userId == rows[j].userId) {
							rows.splice(j, 1);
						}
					}
				}

				// 얻은 행을 오른쪽 그리드에 추가하기
				AUIGrid.addRow(athGridId, rows, "last");

				// 선택한 왼쪽 그리드 행들 삭제
				AUIGrid.removeCheckedRows(allGridId);
			};

			// 체크 행 아래로 이동 버턴 클릭
			function leftBtnClick(type) {
				var athGridId = null;
				var allGridId = null;
				var cmpKey = null;
				if (type == "MENU") {
					athGridId = athMenuGrid;
					allGridId = allMenuGrid;
					cmpKey = "menuSeqno";
				} else if (type == "USER") {
					athGridId = athUserGrid;
					allGridId = allUserGrid;
					cmpKey = "userId";
				}

				// 상단 그리드의 체크된 행들 얻기
				var rows = AUIGrid.getCheckedRowItemsAll(athGridId);

				if (rows.length <= 0) {
					alert('${msg.C100000869}'); /* 체크된 행이 없습니다. */
					return;
				}

				//체크한 행중 추가된 행은 전체 사용자의 삭제 체크 복구 후에 바로 삭제 처리
				for (var i = 0; i < rows.length; i++) {
					var stat = getItemState(rows[i], athGridId);
					if (stat == "Added") { //추가된 상태의 행을 클릭시 전체 사용자의 삭제된 상태를 초기화하고 권한 사용자에서 로우 삭제.
						var clickindex = AUIGrid.getRowIndexesByValue(
								allGridId, cmpKey, rows[i][cmpKey]);
						AUIGrid.restoreSoftRows(allGridId, clickindex);
					}
				}

				// 선택한 상단 그리드 행들 삭제
				AUIGrid.removeCheckedRows(athGridId);

				//추가된 행이 아닌 나머지 행들은 소프트 제거 처리(바로 삭제되지 않고 삭제표시되고 데이터는 남아 있음.)
				AUIGrid.restoreSoftRows(athGridId, rows);
			};
		</script>
		<!--  script 끝 -->
	</tiles:putAttribute>
</tiles:insertDefinition>

