<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:insertDefinition name="login-definition">
    <tiles:putAttribute name="title">Login</tiles:putAttribute>
    <tiles:putAttribute name="body">

    <div class="login_box">
        <span>
            <img src="/assets/image/logo.png">
        </span>
        <form  class="iLogin" id="frmLogin" name="frmLogin" action="./loginCheck.lims" method="POST">
            <select name="langCd" id="langCdComboBox" class="">
                <c:if test="${null != languageList && !empty languageList}">
                    <c:forEach var="item" items="${languageList}">
                        <option value="${item.cmmnCode}">${item.cmmnCodeNm}</option>
                    </c:forEach>
                </c:if>
            </select>
            <div class="login_inner">
                <div class="login_txt">
                	RMS
                    <c:if test="${empty securityexceptionmsg}">
                        <input class="iLoginUser" type="text" placeholder="User Id" id="userId" name="userId" value="" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty securityexceptionmsg}">
                        <input class="iLoginUser" type="text" placeholder="User Id" id="userId" name="userId" value="${userId}" autocomplete="off">
                    </c:if>
                    <c:if test="${empty securityexceptionmsg}">
                        <input class="iLoginPass" type="password" placeholder="Password" id="pwd" name="pwd" value="" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty securityexceptionmsg}">
                        <input class="iLoginPass" type="password" placeholder="Password" id="pwd" name="pwd" value="${pwd}" autocomplete="off">
                    </c:if>
                    <c:if test="${not empty securityexceptionmsg}">
                        <input type="hidden" name="ip" value="${pageContext.request.localAddr}"/>
                    </c:if>
                </div>
                <div class="loginBtn">
                    <button type="button" class="loginBtn01" id="btnLogin">LOGIN</button>
                </div>
                <div class="loginBtn">
                    <button type="button" id="btnUserJoin" class="loginBtn02" onsubmit="return false;">${msg.C100001252}</button> <%-- 사용자 신규등록 --%>
                    <input type="hidden" name="loginRedirect" value="${loginRedirect}" />
                    <input type="hidden" id="targetUrlParameter" name="targetUrlParameter" value='${sessionScope.targetUrl}'/>
                </div>
            </div>
        </form>
    </div>


    </tiles:putAttribute>

   <tiles:putAttribute name="script">
<script>
$(function() {

	//신규 사용자 등록
	dialogUserJoin(${msg}, "btnUserJoin", null, "userJoin", function(item){});

	var langCd = Cookie.get('langCd');
	langCd = (langCd == null || langCd == '' || langCd == 'undefined')?'SY06000001':langCd;
	$('#langCdComboBox').val(langCd);

	$("#btnLogin").click(function() {
		if($("#userId").val() == "") {
			alert('${msg.C100000300}'); //로그인 ID를 입력해 주세요.
			$("#userId").focus();
		} else if($("#pwd").val() == "") {
			alert('${msg.C100000299}'); //로그인 비밀번호를 입력해 주세요.
			$("#pwd").focus();
		} else {
			var langCd = $('#langCdComboBox').val();
			Cookie.set('langCd', langCd, 365);
			$("#frmLogin").submit();
		}
	});

	$("#userId").keydown(function (key){
		if(key.keyCode == 13)
			$("#pwd").focus();
	});

	$("#pwd").keydown(function (key){
		if(key.keyCode == 13)
			$("#btnLogin").trigger("click");
	});

	<c:if test="${not empty securityexceptionmsg}">
		alert("${securityexceptionmsg}");
	</c:if>


});

function changeLogin(id, pw) {
	$("#userId").val(id);
	$("#pwd").val(pw);
	$("#btnLogin").trigger("click");
}



</script>

	</tiles:putAttribute>
</tiles:insertDefinition>

