<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-definition">
    <tiles:putAttribute name="body">
    	<div class="subContent">
			<div class="subCon1">
				<h2>${msg.C000001220}</h2> <!-- 시험방법 -->
				<form action="javascript:;" id="infoFrm" name="infoFrm">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
						</colgroup>
						<tr>
							<th>${msg.C000000575}</th> <!-- Lot ID -->
							<td>
								<label id="aaa">${param.lotId}</label>
							</td>
							<th>${msg.C000000211}</th> <!-- 제품 명 -->
							<td><label>${param.prductNm}</label></td>
							<th>${msg.C000000204}</th> <!-- 시험항목 명 -->
							<td><label>${param.expriemNm}</label></td>
							<th></th>
							<td>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="subCon1 mgT20">
				<h2>${msg.C000000318}</h2> <!-- 시험방법 상세 정보 -->
				<div class="btnWrap">
					<button id="btnReset" class="btn4">${msg.C000000014}</button> <!-- 신규 -->
					<button id="btnSave" class="save btn1">${msg.C000000015}</button> <!-- 저장 -->
				</div>
				<!-- Main content -->
				<form id="exprMthFrm" name="exprMthFrm" onSubmit="return false;">
					<table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
						<colgroup>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
							<col style="width:9%"></col>
							<col style="width:16%"></col>
						</colgroup>
						<tr>
							<th class="necessary">${msg.C000000317}</th> <!-- 시험방법 명 -->
							<td>
								<select name="exprMthSeqno" id="exprMthSeqno"></select>
								<input type="hidden" id="reqestExpriemSeqno" name="reqestExpriemSeqno" value="${param.reqestExpriemSeqno}">
								<input type="hidden" id="exprOdr" name="exprOdr" value="${param.exprOdr}">
								<input type="hidden" id="exprNumot" name="exprNumot" value="${param.exprNumot}">
								<input type="hidden" id="exprDiarySeqno" name="exprDiarySeqno" value="${param.exprDiarySeqno}">
							</td>
							<th>${msg.C000000096}</th> <!-- 비고 -->
							<td colspan="5">
								<input id="rm" name="rm"/>
							</td>
						</tr>
						<tr>
							<th>${msg.C000000321}</th> <!-- 내용 -->
							<td colspan="7">
								<div>
									<div id="exprMthCn" name="exprMthCn"></div>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
 	</tiles:putAttribute>
	<tiles:putAttribute name="script">
		<script>
			window.onload = function(){
				// 콤보 셋팅
				setCombo();

				setButtonEvent();

			}
		</script>
		<script>
			function setCombo(){
				ajaxJsonComboBox('/com/getExprMthCombo.lims','exprMthSeqno',{"expriemSeqno" : "${param.expriemSeqno}"},true, null);
			}

			function setButtonEvent(){
				document.getElementById("exprMthSeqno").addEventListener("change", function(){
					var exprMthSeqno = document.getElementById("exprMthSeqno").value;

					if(exprMthSeqno){
						ajaxJsonParam3("/test/getExprMthInfo.lims", {"exprMthSeqno" : exprMthSeqno}, function(data){
							gridDataSet("exprMthFrm", "input, select", data, function(){});
						})
					}else{
						//리셋
						reset();
					}
				});

				document.getElementById("btnSave").addEventListener("click", function(){
					saveExprMth();
				});

				document.getElementById("btnReset").addEventListener("click", function(){
					reset();
				});
			}

			function saveExprMth(){
				if(!formNecessaryValidationCheck("exprMthFrm"))
					return false;

				var param = $("#exprMthFrm").serializeObject();
				param["exprMthCn"] = Editor.getContent();
				ajaxJsonParam3("/test/saveExprMth.lims", param, function (data) {
					if(data){
						alert("${msg.C000000071}"); /* 저장되었습니다. */
						window.close();
					}
				});
			}

			function reset(){
				$('#exprMthFrm')[0].reset();
			}

			function getExprDiaryInfo(){
				reset();
				var exprDiarySeqno = "${param.exprDiarySeqno}";
				if(exprDiarySeqno != "null"){
					ajaxJsonParam3("/test/getExprDiaryInfo.lims", {"exprDiarySeqno" : exprDiarySeqno}, function(data){
						gridDataSet("exprMthFrm", "input, select", data, function(){});
					});
				}
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>