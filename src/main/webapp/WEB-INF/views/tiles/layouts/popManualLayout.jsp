<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>
 <head>
    <link href="<c:url value='/assets/image/favicon.ico' />" rel="icon" type="image/x-icon" />
    <link href="<c:url value='/assets/image/favicon.ico' />" rel="shortcut icon" type="image/x-icon" />

  <script src="<c:url value='/assets/js/jquery-3.2.1.min.js' />"></script>
<!-- toastr lims.js 보다 위에서 먼저 load되야합니다.-->
<link rel="stylesheet" href="<c:url value='/assets/js/toastr/toastr.min.css' />">
<script  type="text/javascript" src="<c:url value='/assets/js/toastr/toastr.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/assets/js/lims.js?ver=0.3' />"></script>
  <script src="<c:url value='/assets/js/jquery-ui.min.js' />"></script>
  <script src="<c:url value='/assets/js/interface.js' />"></script>

  <script type="text/javascript" src="<c:url value='/assets/js/jquery.number.min.js'/>"></script>
  <script type="text/javascript" src="<c:url value='/assets/js/jquery.cache.min.js'/>"></script>

  <script type="text/javascript" src="<c:url value='/assets/js/timepicker.js'/>"></script>
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/timepicker.css'/>">
   <link rel="stylesheet" href="<c:url value='/assets/stylesheet/common.css' />"> 
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/uicons-regular-rounded.css'/>">
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/jquery-ui-timepicker-addon.css' />">
  <script src="<c:url value='/assets/js/jquery-ui-timepicker-addon.js' />"></script>
  <link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/font.css' />">  
<link rel="stylesheet" href="<c:url value='/assets/stylesheet/css/style.css' />">
	<style type="text/css">
		td { vertical-align: middle; }
	</style>
 </head>
<body>
	<div id="sub_wrap" style="margin:0px;">
		<tiles:insertAttribute name="body" ignore="true"/> 
	</div>

	<tiles:insertAttribute name="script" ignore="true"/> 
</body> 

</html>
