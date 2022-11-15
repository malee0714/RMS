<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:importAttribute name="topMenu"/>
<tiles:importAttribute name="currentMenu"/>
<div class="sub_header">
	<h1>
		<a href="/main.lims"><img src="/assets/image/sub_logo.png"></a>
	</h1>
	<ul id="sub_gnb">
		<c:forEach items="${topMenu}" var="item" varStatus="status">
			<li><a href="${item.menuUrl}" <c:if test='${currentMenu.menuCd2 == item.menuSeqno}'>class="active"</c:if>>${item.menuNm}</a></li>
		</c:forEach>
	</ul>
	<div class="top_button">
		<button type="button" class="change_pw" id="passwordBtn">${msg.C100001303}</button> <!-- 비밀번호 변경 -->
		<button type="button" class="logout" onClick='location.href="/logout.lims"'>${msg.C100001304}</button> <!-- 로그아웃 -->
	</div>	
</div>

<!-- RDMS VIWER -->
<form id="frmRDMSView" name="frmRDMSView" onsubmit="return false;">
	<input type="hidden" name="vParam" id="vParam">
	<input type="hidden" name="gridData" id="gridData">
</form>
<!-- RDMS VIWER END-->

<script>
var printAuth = "Y";

$(document).ready(function(){
	popupInit("passwordBtn", "dialogPassword");
	
    /**
     * 사용자 변경기능 쓰면 살림
     * 
     popupInit("userChangeBtn", "dialogUserChange", function() {
     });
     */
	
	$("#userChangeFrm").find("#bestInspctInsttCode").change(function(){
		ajaxJsonComboBox('/sys/getUpperComboListM.lims','inspctInsttCode',{bestInspctInsttCode:$('#userChangeFrm').find('#bestInspctInsttCode').val()},true);
	});
	
	$("#userChangeFrm").find("#inspctInsttCode").change(function(){
		ajaxJsonComboBox2('/getUserChangeUserList.lims','userId',{inspctInsttCode:this.value},true,null,null,null,null,'pwd');
	});
	
	$("#userChangeFrm").find("#userId").change(function(){
		$("#userChangeFrm").find("#pwd option:eq("+$(this).children('option:selected')[0].index+")").attr("selected", "selected"); 
	});
	
	$("#userChangeFrm").find('#btn_select_userChange').click( function(data) {
		$("#userChangeFrm").submit();
	});

	defaultHeaderEvent();
});

function setHeaderCombo(){
	ajaxJsonComboBox('/getUserChangeBestInspctInsttList.lims','bestInspctInsttCode',null,true);
	ajaxJsonComboBox('/sys/getUpperComboListM.lims','inspctInsttCode',{bestInspctInsttCode:$('#userChangeFrm').find('#bestInspctInsttCode').val()},true);
	ajaxJsonComboBox('/getUserChangeUserList.lims','userId',{inspctInsttCode:$('#userChangeFrm').find('#inspctInsttCode').val()},true);
}

function defaultHeaderEvent() {
	$('#btn_save_password').click( function() {
		
		if($("#passwordFrm").find("#prePassword").val() == "" || $("#passwordFrm").find("#prePassword").val() == null){
			alert('현재 비밀번호를 입력하여 주세요.');
			return;	
		}

		if($("#passwordFrm").find("#password").val() == "" || $("#passwordFrm").find("#password").val() == null){
			alert('새 비밀번호를 입력하여 주세요.');
			return;
		}
		
		if($("#passwordFrm").find("#password").val() != $("#passwordFrm").find("#passwordChk").val()){
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}
		
		// 비밀번호 형식 체크, 비밀번호정책 설정에 따른 예외처리 
		var param = $("#passwordFrm").find("#password").val();
		customAjax({
			"url": "/com/passwordPolicyCheck.lims",
			"data": param,
			"successFunc": function(data) {
				if(data == 100) {
					warn('${msg.C100001132}'); /* 허용 가능한 비밀번호 최대 자릿수를 초과하였습니다. */
					return;
				}else if(data == 101) {
					warn('${msg.C100001133}'); /* 비밀번호는 특수문자를 반드시 포함해야 합니다. */
					return;
				}else if(data == 102) {
					warn('${msg.C100001134}'); /* 비밀번호는 숫자를 반드시 포함해야 합니다. */
					return;
				}else if(data == 103) {
					warn('${msg.C100001135}'); /* 비밀번호는 영문 대문자를 반드시 포함해야 합니다. */
					return;
				}else {
					saveChangePassword();
				}
			}
		});

	});
}

// 비밀번효 변경
function saveChangePassword() {
	ajaxJsonForm('/saveUserPassword.lims', 'passwordFrm', function (data) {
		if(data == 0){
			alert('저장에 실패하였습니다.');
		} else if(data == -1){
			alert('현재 비밀번호와 다릅니다.')
		} else {
			alert('저장하였습니다.');
			$("#passwordFrm").find("#prePassword").val('');
			$("#passwordFrm").find("#Password").val('');
			$("#passwordFrm").find("#PasswordChk").val('');
			$("#popupClose_dialogPassword").trigger("click");
		}
	});
}

</script>
