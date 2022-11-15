<%@page import="lims.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<tiles:insertDefinition name="popup-Manual">
    <tiles:putAttribute name="body">
     	<!-- CKEditor -->
		<script src="/ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
    	<div class="subContent" style="background-color: white;">
			 <div class="subCon1 " id="noticeWriteArticle">
				<form id="menuPWriteForm" name="menuPWriteForm"  onsubmit="return false">
				<h2><i class="fi-rr-apps"></i>${msg.C100001239}</h2> 

					<div class="btnWrap">
						<button id="btn_save" class="save" style=" border: 0 none">${msg.C100000760}</button> <!-- 저장 -->
					</div>
					<div id="ckEditor5" class="wd100p mgT15" style="min-width:10em;"></div> <!-- 담당자 보여줄 에디터 -->
					<div id="userManual" class="wd100p mgT15" style="text-align:left;"></div> <!-- 일반사용자 보여줄 html -->
					<input type="hidden" name="mnlCn" />
					<input type="hidden" name="menuSeqno" />
					<input type="hidden" name="menuUrl" />
				</form>
			</div>
		</div>

 	</tiles:putAttribute>
	<tiles:putAttribute name="script">
<style  type="text/css">
	.ck-editor__editable_inline{min-height:400px;}
	#sub_wrap{margin-left:230px;transition:all 0.3s;}
		#userManual img{
	max-width: 900px;
	 height : auto;
	}
	#userManual figure{
	margin: 5px;
	}
	
</style>
 <script type="text/javascript">
        function div2Resize() {
            var div2 = document.querySelectorAll('img');
			for(var i=0; i<div2.length;i++){
				div2[i].style.maxWidth =  (window.innerWidth -100)+'px';
			}
        }
        window.addEventListener('resize', div2Resize);
</script>
<script>
/*******전역변수**********/
const url= new URL(window.location.href);
const urlParams = url.searchParams;
var menuPWriteForm = 'menuPWriteForm';
var auCode = "${UserMVo.authorSeCode}"; //관리자 권한(SY09000001 시스템관리자, 02일반사용자, 03은 고객사)
var topMenu = "${menuCd}"; //세션 키값
var menuUrl = atob(urlParams.get('menuUrl'));
var userId = {userId : "${UserMVo.userId}"};
var menuSeqno =atob(urlParams.get('menuSeqno'));
$('input[name="menuSeqno"]').val(menuSeqno);
$('input[name="menuUrl"]').val(menuUrl);
//var menuNm = "";

//CK5에디터
var myEditor;
ClassicEditor
	.create( document.querySelector('#ckEditor5'),{
		ckfinder : {
			uploadUrl : '/com/ckeditor5ImageUpload.lims'
		}
	})
	.then(function(data) {
		myEditor = data;
	})
	['catch'](function(error) {
		console.error(error);
	});

$(function() {

	if(auCode == "SY09000001"){
		 $("#btn_save").show();
		 $('.ck-editor').css('display', 'block');
		 $("#userManual").hide();
	}else{
		 $("#btn_save").hide();
		 $('.ck-editor').css('display', 'none');
		 $("#userManual").show();
	}
	setButtonEvent();
	searchMenu();


});

function setButtonEvent() {
	// 신규 클릭 이벤트
	$('#btn_new').click(function(){
		// 폼 초기화
		$('#menuPWriteForm')[0].reset(); // 폼 초기화
		myEditor.setData('');

	});

    //저장
    $("#btn_save").click(function() {
    	 saveManual();
    });

}

//메뉴 조회 함수
function searchMenu() {
	customAjax({
		"url":'/sys/getMenuMList.lims',
		"data" : {
			"menuUrl" : menuUrl
		},
		"successFunc" : function(data) {
			if(data.length != 0){
				if(!!data.mnlCn) {
					myEditor.setData(data[0].mnlCn);
					$("#userManual").html(data[0].mnlCn);
				}
				$("#menuPWriteForm h2").html("<i class='fi-rr-apps'></i>"+data[0].menuNm);

				menuSeqno = data[0].menuSeqno;
				menuNm = data[0].menuNm;
				searchEditorData();
			}
	     }
	});
}


// 저장 함수
 function saveManual() {
	var data = {
			menuSeqno : menuSeqno,
			mnlCn : myEditor.getData()
	};

	customAjax(
		{'url':'/sys/insManual.lims',"data":data,"successFunc":function(data){
			if (data > 0) {
				alert("${msg.C100000765}"); // 저장되었습니다.
			}
		}
	});
 }

//메뉴 BLOB 데이터 조회
 function searchEditorData() {

 	var searchEditorUrl = '/sys/searchEditorData.lims';

 	ajaxJsonForm(searchEditorUrl, menuPWriteForm, function(data) {
 		if (!!data) {
 			if('SY09000001' == auCode) {
 				//관리자
 				myEditor.setData(data.mnlCn);
 			} else {
 				//일반사용자
 				//에디터를 사용하지않고 html로 표데이터 그려줄 경우 css를 추가하여 이미지 로드
 				var tableStyle = "<style>table,td,th{border:1px solid black;}table{border-collapse:collapse;}</style>";
 				tableStyle += data.mnlCn;
 				$("#userManual").html(tableStyle);
 			}
 		}
 	});
 }

</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
