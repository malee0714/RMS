<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
    <tiles:putAttribute name="body">
	<style>
		.rowStyle-red{
			background-color : #FEDBDE;
			color : black;
		}
		.rowStyle-red2{
			background-color : #FEDBDE;
			color : black;
		}

	</style>
    	<div class="subContent" style="padding: 20px 30px 40px;">
			<div class="subCon1 mgT20">
				<h2>${msg.C000001328}</h2> <!-- Online Particle Counter -->
				<div  style="width:100%; margin:5px 0 0 0;">
					<div id="particleMntrngGrid" class="grid" style="height:158px;"></div>
				</div>
			</div>
			<div class="subCon1 mgT20">
				<h2>${msg.C000000583}</h2> <!-- 검교정 목록 -->
				<div  style="width:100%; margin:5px 0 0 0;">
					<div id="mhrlsEdayChckGrid" class="grid" style="height:158px;" ></div>
				</div>
			</div>

			<div class="subCon1 mgT20">
				<h2>고비용소모품/표준물질 목록</h2> <!-- 고비용소모품/표준물질 목록 -->
				<div  style="width:100%; margin:5px 0 0 0;">
					<div id="conStandGrid" class="grid" style="height:158px;" ></div>
				</div>
			</div>

			<div style="text-align:right; margin-top:10px;">
				<input type="checkbox" id="dayHidden" > ${msg.C000001329}
			</div>
		</div>
 	</tiles:putAttribute>
	<tiles:putAttribute name="script">

		<script>
			window.onload = function(){
				setGridForm();  //그리드 생성

				getOnlineParticleList();

				getMhrlsEdayChckList();

				getConStandList();

				setButtonEvent();
			}
		</script>
		<script>
			var particleMntrngGrid = "particleMntrngGrid";
			var mhrlsEdayChckGrid = "mhrlsEdayChckGrid";
			var conStandGrid ="conStandGrid";

			function setGridForm(){
				var columnLayout = {
					particleMntrngCol : [],
					mhrlsEdayChckCol : [],
					conStandCol :[]
				};

				//online particle 그리드 생성
				auigridCol(columnLayout.particleMntrngCol);
		 		columnLayout.particleMntrngCol.addColumnCustom("partclSeCodeNm","${msg.C000001085}",null,true,false) //모니터링
		 		.addColumnCustom("mesureDt","${msg.C000001168}",null,true,false) // 날짜
		 		.addColumnCustom("mesureExpriemNm","${msg.C000000204}",null,true,false) //시험항목 명
		 		.addColumnCustom("mesureValue","${msg.C000001104}",null,true,false); //수치

		 		var rowStyle={
		 			rowStyleFunction : function(rowIndex, item) {
	 					console.log(item);
	 					if(!getCompareDate(getFormatDate(), item.inspctCrrctPrearngeDte)){
	 						return "rowStyle-red";
	 					}

						return null;
					}
		 		}

		 		//검교정 그리드 생성
		 		auigridCol(columnLayout.mhrlsEdayChckCol);
		 		columnLayout.mhrlsEdayChckCol.addColumnCustom("inspctCrrctSeCodeNm","검교정 구분",null,true,false)
		 		.addColumnCustom("mhrlsClCodeNm","${msg.C000000007}",null,true,false) //기기분류
		 		.addColumnCustom("mhrlsNm","${msg.C000000011}",null,true,false) //기기 명
		 		.addColumnCustom("recentInspctCrrctDte","${msg.C000000527}",null,true,false) //최근 검교정 일자
		 		.addColumnCustom("inspctCrrctPrearngeDte","${msg.C000000526}",null,true,false); //검교정 예정일자


		 		var rowStyle2={
			 			rowStyleFunction : function(rowIndex, item) {

		 					if(!getCompareDate(getFormatDate(), item.validDte)){
		 						return "rowStyle-red2";
		 					}

							return null;
						}
			 		}

		 		// 고비용 소모품 +표준물질
		 		auigridCol(columnLayout.conStandCol);
		 		columnLayout.conStandCol.addColumnCustom("chTeam","담당팀",null,true,false)
		 		.addColumnCustom("mhrRgnt","소모품구분&시약구분",null,true,false) //
		 		.addColumnCustom("mhrKinds","기기분류&시약종류",null,true,false) //
		 		.addColumnCustom("cmRgNm","소모품명&시약명",null,true,false) //
		 		.addColumnCustom("validDte","유효일자",null,true,false) //


		 		particleMntrngGrid = createAUIGrid(columnLayout.particleMntrngCol, particleMntrngGrid);
		 		mhrlsEdayChckGrid = createAUIGrid(columnLayout.mhrlsEdayChckCol, mhrlsEdayChckGrid, rowStyle);
		 		conStandGrid = createAUIGrid(columnLayout.conStandCol, conStandGrid, rowStyle2);
			}

			function setButtonEvent(){
				getEl("dayHidden").addEventListener("click", function(){
					closePopupToday();
				});
			}

			function getOnlineParticleList(){
				ajaxJsonParam3("/getOnlineParticleList.lims",null,function(data){
					AUIGrid.setGridData(particleMntrngGrid, data);
				});
			}

			function getMhrlsEdayChckList(){
				ajaxJsonParam3("/getMhrlsEdayChckList.lims",null,function(data){
					AUIGrid.setGridData(mhrlsEdayChckGrid, data);
				});
			}

			function getConStandList(){
				ajaxJsonParam3("/getConStandList.lims",null,function(data){
					AUIGrid.setGridData(conStandGrid, data);
				});
			}

			 function closePopupToday(){
			     Cookie.set('todayClose','Y', 1);
			     window.close();
			 }
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>