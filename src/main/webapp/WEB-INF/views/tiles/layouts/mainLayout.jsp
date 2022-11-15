<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>
 <head>
  <meta name="Author" content="">
  <meta name="Keywords" content="">
  <meta name="Description" content="">
  <meta http-equiv="X-UA-Compatible" content="IE=Edge" charset="UTF-8">
  <meta http-equiv="X-UA-TextLayoutMetrics" content="gdi" />
  <title>LIMS</title>
  <link href="<c:url value='/assets/image/favicon.ico' />" rel="icon" type="image/x-icon" />
  <link href="<c:url value='/assets/image/favicon.ico' />" rel="shortcut icon" type="image/x-icon" />
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/jquery-ui.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/common.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/style.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/font.css' />">   
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/interface.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/layout.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/uicons-regular-rounded.css'/>">
  <link href="<c:url value='/AUIGrid/AUIGrid_style.css' />" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/AUIGrid_style.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/basic.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/dropzone.css' />">
  
  
  <script src="<c:url value='/assets/js/jquery-3.2.1.min.js' />"></script>
  <!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGridLicense.js' />"></script>
  <!-- 실제적인 AUIGrid 라이브러리입니다. 그리드 출력을 위해 꼭 삽입하십시오.--> 
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.js' />"></script>
  <!-- AUIGrid PDFkit 라이브러리입니다. --> 
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.pdfkit.js' />"></script>
  <!-- toastr lims.js 보다 위에서 먼저 load되야합니다.-->
  <link rel="stylesheet" href="<c:url value='/assets/js/toastr/toastr.min.css' />">
  <script type="text/javascript" src="<c:url value='/assets/js/toastr/toastr.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/lims.js?ver=0.4' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/userdialog.js?ver=0.4' />"></script>
  <script src="<c:url value='/assets/js/jquery-ui.min.js' />"></script>
  <script src="<c:url value='/assets/js/interface.js' />"></script>
  <!-- 원하는 테마가 있다면, 다른 파일로 교체 하십시오. -->
  <!-- AUIGrid 메세지 파일 - 한글 -->
  <script type="text/javascript" src="<c:url value='/AUIGrid/messages/AUIGrid.messages.kr.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/FileSaver.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/fileCommon.js' />"></script>
    <!-- dropZone -->
  <script type="text/javascript" src="<c:url value='/assets/js/dropzone/dropzone.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/auigridcommon.js?ver=0.1' />"></script>
 </head>
<body>
	<tiles:insertAttribute name="header" /> 
    <tiles:insertAttribute name="body" />
	<tiles:insertAttribute name="footer" /> 
	<tiles:insertAttribute name="script" /> 
</body> 

</html>
