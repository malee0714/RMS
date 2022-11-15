<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="base-definition">
<tiles:putAttribute name="title">바코드 생성</tiles:putAttribute>
<tiles:putAttribute name="script">
<style>
 .subContent{
 	padding: 20px 30px 70px !important;
 }
</style>
<script>
$("#chartDivFrame").load("/dly/brcdValidM.lims");
</script>
</tiles:putAttribute>
<tiles:putAttribute name="body">
<div id="chartDivFrame"></div>
<!-- <iframe id="chartDivFrame" src="/dly/brcdValidM.lims" width="100%" height="950px"></iframe>	 -->
</tiles:putAttribute>
</tiles:insertDefinition>