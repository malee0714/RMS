<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>
<head>
<meta name="Author" content="">
<meta name="Keywords" content="">
<meta name="Description" content="">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge" charset="UTF-8">
<title>LIMS</title>
<link href="<c:url value='/assets/image/favicon.ico' />" rel="icon" type="image/x-icon" />
<link href="<c:url value='/assets/image/favicon.ico' />" rel="shortcut icon" type="image/x-icon" />
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/common.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/style.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/font.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/uicons-regular-rounded.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/jquery-ui.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/common.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/basic.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/dropzone.css' />">
<link href="<c:url value='/AUIGrid/AUIGrid_style.css' />"  rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/fullcalendar/fullcalendar.min.css'/>">
<link rel="stylesheet" media="print" href="<c:url value='/assets/stylesheet/fullcalendar/fullcalendar.print.min.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/AUIGrid_style.css' />">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/crownix-viewer.min.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/timepicker.css'/>">
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/jquery-ui-timepicker-addon.css' />">
<script src="<c:url value='/assets/js/jquery-3.2.1.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/AUIGrid/AUIGridLicense.js' />"></script>
<!-- 실제적인 AUIGrid 라이브러리입니다. 그리드 출력을 위해 꼭 삽입하십시오.-->
<script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.js' />"></script>

<!-- toastr lims.js 보다 위에서 먼저 load되야합니다.-->
<link rel="stylesheet" href="<c:url value='/assets/js/toastr/toastr.min.css' />">
<script  type="text/javascript" src="<c:url value='/assets/js/toastr/toastr.min.js'/>"></script>

<!-- AUIGrid PDFkit 라이브러리입니다. -->
<script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.pdfkit.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/lims.js?ver=0.4' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/userdialog.js?ver=0.4' />"></script>
<script src="<c:url value='/assets/js/jquery-ui.min.js' />"></script>
<script src="<c:url value='/assets/js/interface.js' />"></script>

<script type="text/javascript" src="<c:url value='/assets/js/dropzone/dropzone.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/jquery.mtz.monthpicker.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/MonthPicker.min.js' />"></script>
<!-- AUIGrid 메세지 파일 - 한글 -->
<script type="text/javascript" src="<c:url value='/AUIGrid/messages/AUIGrid.messages.kr.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/auigridcommon.js?ver=0.1' />"></script>

<script type="text/javascript" src="<c:url value='/assets/js/DnPrepOingExcelImport.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/FileSaver.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/fileCommon.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/all.js?ver=0.2' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/crownix-viewer.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/crownix-invoker.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/jquery.scannerdetection.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/jquery.cache.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/fullcalendar/moment.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/fullcalendar/fullcalendar.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/fullcalendar/ko.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/timepicker.js'/>"></script>
<script src="<c:url value='/assets/js/jquery-ui-timepicker-addon.js' />"></script>
<script src="<c:url value='/assets/js/Chart.min.js' />"></script>
<script type="text/javascript" src="/assets/js/chartZoom.js"></script>
<script type="text/javascript" src="<c:url value='/assets/js/base64.js'/>"></script>

<script type="text/javascript" src="<c:url value='/assets/js/jquery.number.min.js'/>"></script>

<!-- Explorer 11이하 지원하지않는 Intl API를 사용하기위해 polyfill 추가하였음 -->
<script type="text/javascript" src="<c:url value='/assets/js/intlpolyfill/Intl.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/intlpolyfill/ko.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/intlpolyfill/ko-KR.js' />"></script>
<script type="text/javascript" src="<c:url value='/assets/js/intlpolyfill/en.js' />"></script>

<!-- select box 검색 plugin -->
<script type="text/javascript"  src="/assets/js/select2/select2.full.min.js"></script>
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/select2/select2Custom.css'/>">

<style type="text/css">
td {
	vertical-align: middle;
}
</style>
</head>
    <body style="background: #fff;">

        <!-- 사용자 권한에 따른 사업장 selectBox를 제어하기위한 element입니다. -->
        <div id="userAuthorDiv">
            <input type="hidden" id="layoutUserBplcCode" value="${UserMVo.bplcCode}">
            <input type="hidden" id="layoutUserAuthorSeCode" value="${UserMVo.authorSeCode}">
            <input type="hidden" id="layoutReqUrl" value="${reqUrl}">
        </div>

        <tiles:insertAttribute name="header" />
        
        <div id="sub_wrap">
            <tiles:insertAttribute name="dashboard" />
            <tiles:insertAttribute name="menu" />
            <tiles:insertAttribute name="body" />
        </div>
        
        <!-- 로딩 animation -->
        <div id="wrap-loading"style="display:none">
            <div class="load-wrapp">
                <div class="load-4">
                    <div class="ring-1"></div>
                </div>
            </div>
        </div>
        <tiles:insertAttribute name="footer" />
        <tiles:insertAttribute name="script" />
    </body>
</html>