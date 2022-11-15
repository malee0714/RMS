<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
	<tiles:putAttribute name="body">

		<div class="subContent">
			<div class="subCon1">
				<h2><i class="fi-rr-apps"></i>${msg.C100000738}</h2> <!-- 장비 가동률 목록 -->
				<div class="btnWrap">
					<button id="btnSearch" class="search btn1">${msg.C100000767}</button> <!-- 조회 -->
				</div>

				<form action="javascript:;" id="searchFrm" name="searchFrm">
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
							<th>${msg.C100000198}</th> <!-- 관리 부서 -->
							<td><select id="chrgDeptCodeSch" name="chrgDeptCodeSch"></select></td>

							<th>${msg.C100000607}</th> <!-- 연도 -->
							<td><select id="yearSch" name="yearSch"></select></td>

							<th>${msg.C100000745}</th> <!-- 장비 분류 -->
							<td><select id="eqpmnClCodeSch" name="eqpmnClCodeSch"></select></td>
						</tr>

						<tr>
							<th>${msg.C100000742}</th> <!-- 장비 명 -->
							<td colspan="7"><input type="text" id="eqpmnNmSch" name="eqpmnNmSch" class="schClass"></td>
						</tr>
					</table>
				</form>
			</div>

			<div class="subCon2">
				<div class="mgT15">
					<!-- 에이유아이 그리드가 이곳에 생성됩니다. -->
					<div id="eqpmnOprGrid" style="width:100%; height:500px; margin:0 auto;"></div>
				</div>
				<div class="mgT5" style="text-align: right;" style="font-size:13px">
					<!-- ☆ 가동률 : 가동 시간 / 장비 별 가동 시간 * 100 ★ 가용률 : 가동 시간 / (월 일수 * 24) * 100 -->
					☆ ${msg.C100000107} : ${msg.C100000105} / ${msg.C100000744} * 100 &nbsp;&nbsp;&nbsp;&nbsp; ★ ${msg.C100000108} : ${msg.C100000635} / 720hr(30${msg.C100000972}) * 100
				</div>
			</div>
		</div>

	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<style>
			.c-red {
				color:#FEDBDE;
				font-weight:bold;
			}

			.border-style{
				border:1px solid #c4f4fe;
				background: #c4f4fe;
			}

			.border-style2{
				border:1px solid #c4f4fe;
				background: #b5c7ed;
			}
		</style>

		<script>

			var eqpmnOprGrid = "eqpmnOprGrid";

			$(function() {

				setCombo();

				buildGrid();

				buttonEvent();

				gridResize([eqpmnOprGrid]);

			});


			function setCombo() {
				ajaxJsonComboBox('/wrk/getDeptComboList.lims', 'chrgDeptCodeSch', {'bestInspctInsttCode' : '${UserMVo.bestInspctInsttCode}'}, true);
				ajaxJsonComboBox('/com/getCmmnCode.lims','eqpmnClCodeSch',{ upperCmmnCode : "RS02" }, true);
				setYear('yearSch', new Date().getFullYear(), 2019, 10);
			}


			function buildGrid() {

				var	col = [];

				var percentBar = {
					renderer : {
						type : "BarRenderer",
						max : 100,
						min : 0,
						style:"border-style2"
					}
				};

				var percentBar2 = {
					renderer : {
						type : "BarRenderer",
						max : 100,
						min : 0,
						style : "border-style"
					}
				};

				var rowProp = {
					enableCellMerge : true,
					cellMerge : true,
					cellMergePolicy : "withNull",
					rowSelectionWithMerge : true
				};

				auigridCol(col);

				col
				.addColumnCustom("eqpmnClCode","장비 분류 코드",null,false,false,rowProp)
				.addColumnCustom("eqpmnClNm","${msg.C100000745}",null,true,false,rowProp)
				.addColumnCustom("eqpmnSeqno","장비 일렬번호",null,false,false,rowProp)
				.addColumnCustom("eqpmnNm","${msg.C100000742}",null,true,false,rowProp)
				.addColumnCustom("eqpmnManageNo","${msg.C100000739}",null,true,false,rowProp)
				.addColumnCustom("manageDeptCode","관리 부서",null,false,false,rowProp)
				.addColumnCustom("jan","1${msg.C100000006}",null,true,false)
				.addChildColumn("jan", "monOp1","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("jan", "monUs1","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("jan", "monCnt1","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("feb","2${msg.C100000006}",null,true,false)
				.addChildColumn("feb", "monOp2","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("feb", "monUs2","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("feb", "monCnt2","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("mar","3${msg.C100000006}",null,true,false)
				.addChildColumn("mar", "monOp3","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("mar", "monUs3","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("mar", "monCnt3","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("apr","4${msg.C100000006}",null,true,false)
				.addChildColumn("apr", "monOp4","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("apr", "monUs4","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("apr", "monCnt4","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("may","5${msg.C100000006}",null,true,false)
				.addChildColumn("may", "monOp5","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("may", "monUs5","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("may", "monCnt5","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("jun","6${msg.C100000006}",null,true,false)
				.addChildColumn("jun", "monOp6","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("jun", "monUs6","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("jun", "monCnt6","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("jul","7${msg.C100000006}",null,true,false)
				.addChildColumn("jul", "monOp7","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("jul", "monUs7","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("jul", "monCnt7","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("aug","8${msg.C100000006}",null,true,false)
				.addChildColumn("aug", "monOp8","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("aug", "monUs8","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("aug", "monCnt8","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("sep","9${msg.C100000006}",null,true,false)
				.addChildColumn("sep", "monOp9","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("sep", "monUs9","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("sep", "monCnt9","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("oct","10${msg.C100000006}",null,true,false)
				.addChildColumn("oct", "monOp10","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("oct", "monUs10","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("oct", "monCnt10","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("nov","11${msg.C100000006}",null,true,false)
				.addChildColumn("nov", "monOp11","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("nov", "monUs11","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("nov", "monCnt11","${msg.C100000121}",null,true,false,null,null,null,null)
				.addColumnCustom("dec","12${msg.C100000006}",null,true,false)
				.addChildColumn("dec", "monOp12","${msg.C100000107}",null,true,false,null,"numeric",null,null,percentBar)
				.addChildColumn("dec", "monUs12","${msg.C100000108}",null,true,false,null,null,null,null,percentBar2)
				.addChildColumn("dec", "monCnt12","${msg.C100000121}",null,true,false,null,null,null,null);

				eqpmnOprGrid = createAUIGrid(col, eqpmnOprGrid);

				AUIGrid.bind(eqpmnOprGrid, "ready", function(event) {
					gridColResize([eqpmnOprGrid], "2");
				});
			}


			function buttonEvent() {

				$("#btnSearch").click(function() {
					getEqpmnOprList();
				});

				$(".schClass").keypress(function (e) {
					setTimeout(function() {
						if(e.which == 13) {
							if(typeof(getEqpmnOprList) != "undefined") {
								getEqpmnOprList();
							}
						}
					}, 100);
				});
			}


			function getEqpmnOprList() {
				getGridDataForm("/src/getParMonTU.lims", "searchFrm", eqpmnOprGrid);
			}


		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
