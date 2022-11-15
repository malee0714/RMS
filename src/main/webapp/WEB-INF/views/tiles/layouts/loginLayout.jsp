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
  <!-- AUIGrid 라이센스 파일입니다. 그리드 출력을 위해 꼭 삽입하십시오. -->
  <link href="<c:url value='/AUIGrid/AUIGrid_style.css' />" rel="stylesheet">
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGridLicense.js' />"></script>
  <!-- 실제적인 AUIGrid 라이브러리입니다. 그리드 출력을 위해 꼭 삽입하십시오.-->
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.js' />"></script>
  <!-- AUIGrid PDFkit 라이브러리입니다. -->
  <script type="text/javascript" src="<c:url value='/AUIGrid/AUIGrid.pdfkit.js' />"></script>
  <!-- AUIGrid 메세지 파일 - 한글 -->
  <script type="text/javascript" src="<c:url value='/AUIGrid/messages/AUIGrid.messages.kr.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/auigridcommon.js?ver=0.1' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/userdialog.js?ver=0.4' />"></script>
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/basic.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/dropzone/dropzone.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/jquery-ui.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/common.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/common.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/style.css' />">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/font.css' />">
  <script src="<c:url value='/assets/js/jquery-3.2.1.min.js' />"></script>
  <!--<script type="text/javascript" src="<c:url value='/http://code.jquery.com/jquery-latest.min.js' />"></script>-->
  <script src="<c:url value='/assets/js/jquery-ui.min.js' />"></script>
  <script src="<c:url value='/assets/js/interface.js' />"></script>

  <!-- toastr lims.js 보다 위에서 먼저 load되야합니다.-->
  <link rel="stylesheet" href="<c:url value='/assets/js/toastr/toastr.min.css' />">
  <script  type="text/javascript" src="<c:url value='/assets/js/toastr/toastr.min.js'/>"></script>

  <script type="text/javascript" src="<c:url value='/assets/js/lims.js?ver=0.4' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/dropzone/dropzone.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/FileSaver.min.js' />"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/fileCommon.js' />"></script>

  <!-- select box 검색 plugin -->
  <script type="text/javascript"  src="/assets/js/select2/select2.full.min.js"></script>
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/select2/select2Custom.css'/>">
 </head>

<body>
	<div id="wrap">

<!--     	<section class="loginArea"> -->
			<tiles:insertAttribute name="body" />
<!-- 		</section>	 -->

	</div>

	<tiles:insertAttribute name="script" />
</body>

</html>
