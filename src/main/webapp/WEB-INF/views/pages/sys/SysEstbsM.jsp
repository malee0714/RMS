<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">시스템 설정</tiles:putAttribute>
<tiles:putAttribute name="body">
<!--  body 시작 -->
<div class="subContent">
    <div class="subCon1">
        <form id="SysEstbsForm" onsubmit="return false;">
            <h2><i class="fi-rr-apps"></i>${msg.C100001138}</h2> <!-- 시스템 설정 -->
            <div class="btnWrap">
                <button type="button" id="btnSave" class="save">${msg.C100000760}</button> <!-- 저장 -->
            </div>
            <table cellpadding="0" cellspacing="0" width="100%" class="subTable1">
                <colgroup>
                    <col style="width:25%"></col> 
                    <col style="width:25%"></col>
                    <col style="width:25%"></col> 
                    <col style="width:25%"></col>
                </colgroup>
                <tr>
                    <th>${msg.C100001139}</th> <!-- 사용자 초기화 비밀번호 -->
                    <td><input type="text" id="initlPassword" name="initlPassword" class="wd100p" style="min-width:10em;" maxlength="100"></td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100001140}</th> <!-- 로그인 실패 잠금 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="loginFailrLockAt_Y" name="loginFailrLockAt" value="Y" checked>${msg.C100001019}</label> <!-- 잠금 -->
                        <label><input type="radio" id="loginFailrLockAt_N" name="loginFailrLockAt" value="N" >${msg.C100001148}</label> <!-- 잠금 해제 -->
                    </td>
                    <th id="lockNumot">${msg.C100001141}</th> <!-- 로그인 실패 잠금 횟수 -->
                    <td><input type="text" id="loginFailrLockNumot" name="loginFailrLockNumot" class="wd100p numChk" style="min-width:10em;" maxlength="5"></td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100001142}</th> <!-- 비밀번호 정책 실행 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="passwordPolicyExecutAt_Y" name="passwordPolicyExecutAt" value="Y">${msg.C100001149}</label> <!-- 실행 -->
                        <label><input type="radio" id="passwordPolicyExecutAt_N" name="passwordPolicyExecutAt" value="N" checked>${msg.C100001150}</label> <!-- 미실행 -->
                    </td>
                    <th id="mxmmCphr">${msg.C100001143}</th> <!-- 비밀번호 최대 자리수 -->
                    <td><input type="text" id="passwordMxmmCphr" name="passwordMxmmCphr" class="wd100p numChk" style="min-width:10em;" maxlength="10"></td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100001144}</th> <!-- 비밀번호 특수 문자 포함 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="passwordSpclChrctrInclsAt_Y" name="passwordSpclChrctrInclsAt" value="Y" checked>${msg.C100001151}</label> <!-- 포함 -->
                        <label><input type="radio" id="passwordSpclChrctrInclsAt_N" name="passwordSpclChrctrInclsAt" value="N">${msg.C100001152}</label> <!-- 미포함 -->
                    </td>
                    <th class="necessary">${msg.C100001145}</th> <!-- 비밀번호 숫자 포함 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="passwordNumberInclsAt_Y" name="passwordNumberInclsAt" value="Y" checked>${msg.C100001151}</label> <!-- 포함 -->
                        <label><input type="radio" id="passwordNumberInclsAt_N" name="passwordNumberInclsAt" value="N">${msg.C100001152}</label> <!-- 미포함 -->
                    </td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100001146}</th> <!-- 비밀번호 대문자 포함 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="passwordUpprsInclsAt_Y" name="passwordUpprsInclsAt" value="Y" checked>${msg.C100001151}</label> <!-- 포함 -->
                        <label><input type="radio" id="passwordUpprsInclsAt_N" name="passwordUpprsInclsAt" value="N">${msg.C100001152}</label> <!-- 미포함 -->
                    </td>
                </tr>
                <tr>
                    <th class="necessary">${msg.C100001147}</th> <!-- 고객사 대응 여부 -->
                    <td style="text-align: left;">
                        <label><input type="radio" id="ctmmnyCntrmsrAt_Y" name="ctmmnyCntrmsrAt" value="Y">${msg.C100001153}</label> <!-- 대응 -->
                        <label><input type="radio" id="ctmmnyCntrmsrAt_N" name="ctmmnyCntrmsrAt" value="N" checked>${msg.C100001154}</label> <!-- 미대응 -->
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
</tiles:putAttribute>
<!-- body 끝 -->

<tiles:putAttribute name="script">
<script>
var editCnt = 0;

$(function() {

    // button event
	setButtonEvent();

    // system 설정 값 bind
    setSysEstbsInfo();
});

function setButtonEvent() {
    document.getElementById('btnSave').addEventListener("click", function() {
        if(editCnt > 0) {
            // 로그인 실패 잠금 여부가 'Y'
            if($("input[name='loginFailrLockAt']:checked").val() == "Y") {
                var numot = $("#loginFailrLockNumot").val();

                // 로그인 실패 잠금 횟수 값 체크
                if(!numot || numot == 0) {
                    warn("${msg.C100001136}");  /* 로그인 실패 잠금 횟수는 0 이상 입력해주세요. */
                    return;
                }
            }

            // 비밀번호 정책 실행 여부가 'Y'
            if($("input[name='passwordPolicyExecutAt']:checked").val() == "Y") {
                var cphr = $("#passwordMxmmCphr").val();

                // 비밀번호 최대 자리수 값 체크
                if(!cphr || cphr == 0) {
                    warn("${msg.C100001137}");  /* 비밀번호 최대 자리수는 0 이상 입력해주세요. */
                    return;
                }
            }
            
            saveSysEstbs();

        // 수정된 값이 없으면 저장event 방지 
        }else {
            return;
        }
        
    });

    /********************* 압력폼 수정된 값이 있으면 editCnt 증가 ********************/
    var inputBoxes = document.getElementsByTagName('input');
    for(var i=9; i < inputBoxes.length; i++) {
        inputBoxes[i].addEventListener('change', function() {
            editCnt++;
        });
    }
    
    $("input[name='loginFailrLockAt']").change(function() {
        neccessaryCntrl();
    });

    $("input[name='passwordPolicyExecutAt']").change(function() {
        neccessaryCntrl();
    });
}

// 시스템 설정 저장
function saveSysEstbs() {
    var param = $("#SysEstbsForm").serializeObject();

    customAjax({
        "url": "/sys/saveSysManage.lims",
        "data": param,
        "successFunc": function(data) {
            if(data != 0) {
                editCnt = 0;
                success("${msg.C100000762}");  /* 저장되었습니다. */
            }else {
                err("${msg.C100000597}");  /* 오류가 발생했습니다. */
            }
            
        }
    });
}

// 시스템 설정 정보 세팅
function setSysEstbsInfo() {
    customAjax({
        "url": "/sys/getSysManage.lims",
        "successFunc": function(data) {
            $("#initlPassword").val(data[0]["initlPassword"]);
            $("#loginFailrLockNumot").val(data[0]["loginFailrLockNumot"]);
            $("#passwordMxmmCphr").val(data[0]["passwordMxmmCphr"]);

            if(data[0]["loginFailrLockAt"] == "Y") {
                $("input:radio[id='loginFailrLockAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='loginFailrLockAt_N']").prop("checked",true);
            }

            if(data[0]["passwordPolicyExecutAt"] == "Y") {
                $("input:radio[id='passwordPolicyExecutAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='passwordPolicyExecutAt_N']").prop("checked",true);
            }

            if(data[0]["passwordSpclChrctrInclsAt"] == "Y") {
                $("input:radio[id='passwordSpclChrctrInclsAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='passwordSpclChrctrInclsAt_N']").prop("checked",true);
            }

            if(data[0]["passwordNumberInclsAt"] == "Y") {
                $("input:radio[id='passwordNumberInclsAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='passwordNumberInclsAt_N']").prop("checked",true);
            }

            if(data[0]["passwordUpprsInclsAt"] == "Y") {
                $("input:radio[id='passwordUpprsInclsAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='passwordUpprsInclsAt_N']").prop("checked",true);
            }

            if(data[0]["ctmmnyCntrmsrAt"] == "Y") {
                $("input:radio[id='ctmmnyCntrmsrAt_Y']").prop("checked",true);
            }else {
                $("input:radio[id='ctmmnyCntrmsrAt_N']").prop("checked",true);
            }

            neccessaryCntrl();
        }
    })
}

function neccessaryCntrl() {
    if($("input[name='loginFailrLockAt']:checked").val() == "Y") {
        $("#lockNumot").addClass('necessary');
    }else {
        $("#lockNumot").removeClass('necessary');
    }

    if($("input[name='passwordPolicyExecutAt']:checked").val() == "Y") {
        $("#mxmmCphr").addClass('necessary');
    }else {
        $("#mxmmCphr").removeClass('necessary');
    }
}

</script>
</tiles:putAttribute>
</tiles:insertDefinition>