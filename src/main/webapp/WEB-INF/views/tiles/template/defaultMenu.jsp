<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:importAttribute name="leftMenu"/>
<tiles:importAttribute name="currentMenu"/>
<div class="left_menu">
	<div class="menu type1">
		<span>MENU</span>
		<div class="toggle open">	
			<span class="border border1"></span>
			<span class="border border2"></span>
			<span class="border border3"></span>
		</div>	
	</div>
	<ul id="lnb">
		<li class="lnbLst tric"><a href="#">지우지마세요!!!</a></li>
		<c:forEach items="${leftMenu}" var="item" varStatus="status">
			<c:if test="${item.upperMenuSeqno == currentMenu.menuCd2}">
				<c:if test="${submenu == '1'}">
					</ul>
				</li>
				</c:if>
				<c:set value="1" var="submenu"/>
				<li class="lnbLst">
				<c:if test="${item.menuSeqno == currentMenu.menuCd3}">
					<a href="#" class="close open"><i class="fi-rr-folder-add"></i>${item.menuNm}</a>
					<ul class="lnb2dt" style="display: block;">
				</c:if>
				<c:if test="${item.menuSeqno != currentMenu.menuCd3}">
					<a href="#" class="close"><i class="fi-rr-folder-add"></i>${item.menuNm}</a>
					<ul class="lnb2dt" >
				</c:if>
			</c:if>
			<c:if test="${item.upperMenuSeqno != currentMenu.menuCd2}">
				<c:if test="${item.menuSeqno == currentMenu.menuCd4}">
					<li class="lnb2dtLst"><a href="${item.menuUrl}" value="${item.menuSeqno}" class="open"><i class="fi-rr-folder"></i><span class="list_bg"></span>${item.menuNm}</a></li>
				</c:if>
				<c:if test="${item.menuSeqno != currentMenu.menuCd4}">	
					<c:if test="${item.menuSeqno != currentMenu.menuCd2}">					
						<li class="lnb2dtLst"><a href="${item.menuUrl}" value="${item.menuSeqno}"><i class="fi-rr-folder"></i><span class="list_bg"></span>${item.menuNm}</a></li>
					</c:if>
				</c:if>
			</c:if>
		</c:forEach>
		<c:if test="${submenu == '1'}">
					</ul>
				</li>
		</c:if>
	</ul>
</div>
<script>
//페이지 title set
document.title = "LIMS - " + "${currentMenu.menuNm4}";
</script>
