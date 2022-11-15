$(function () {
	$('.chk').click(function(e){
		var checkbox = $("#"+e.target.id)[0];
		if(checkbox.checked){
			checkbox.value= "Y";
		}else{
			checkbox.value= "N";
		}
	});
});

/**
 * 2021-06-01
 * 메뉴 열고 닫기 event
 */
$(function() {

    $('.toggle').click(function () {
        $(this).toggleClass('active');
    });

    $(".toggle").click(function(){

        if($(".toggle").hasClass("open") ) {
            $("#lnb").hide();
            $(".toggle").removeClass("open").addClass("close");
            $(".menu span").css("font-size","0");
            $(".left_menu").css("width","50px");
            $("#sub_wrap").css("margin-left","50px");
        } else {
            $("#lnb").show();
            $(".toggle").removeClass("close").addClass("open");
            $(".menu span").css("font-size","100%");  
            $(".left_menu").css("width","230px");
            $("#sub_wrap").css("margin-left","230px");
        }

        setTimeout(function(){
            $(window).resize();
        },300);
    });
});

/**
 * 2021-06-01
 * LNB메뉴
 */
$(function() {

	$("#lnb .lnbLst > a:first").removeClass("close").addClass("open");

    document.querySelector('#lnb').addEventListener('click', function (e) {

        if (e.target.nodeName === 'A' && !!e.target.nextElementSibling) {
            if (e.target.classList.contains("open")) {
                $(e.target).removeClass("open").addClass("close");
                $(e.target).parent(".lnbLst").children(".lnb2dt ").slideUp();
            } else {
                $(e.target).addClass("open").removeClass("close");
                $(e.target).parent(".lnbLst").children(".lnb2dt ").slideDown();
            }

            $("#lnb .lnbLst > a").not($(e.target)).parent(".lnbLst").children(".lnb2dt ").slideUp();
            $("#lnb .lnbLst > a").not($(e.target)).removeClass("open").addClass("close");
        }
    });

});

/**
 * 화면에서 쓰는 공통함수 실행 !
 * @author shs
 */
$(function(){

	if(!("/popup/popBbs.lims"==location.pathname || '/src/PdfViewerPopupM.lims'==location.pathname)){
	    //메뉴 권한체크
		getAuth();
	}
    //날짜 유효성체크
    document.querySelector('#sub_wrap').addEventListener("change", function(e){
        dateValidChk(e);
    });
    
    //숫자유효성 체크 실행
    numValidation();
    //숫자에 comma 넣어줌
    putComma();
    //maxLength 속성을 이용한 입력 제한 event
    byteLimiter();
	accordionEvent();

    //사업장. selectbox 조회조건 권한에 따라 diabled처리까지.
    // var bplcCodeSupport = new BplcCodeSupport({
    //     bplcCode: $("#userAuthorDiv #layoutUserBplcCode").val()
    //     , authorSeCode: $("#userAuthorDiv #layoutUserAuthorSeCode").val()
    //     , menuUrl: $("#userAuthorDiv #layoutReqUrl").val()
    // });
    //
    // // bplc select box option set
    // bplcCodeSupport.setBplcCodes();
    
    /**
     * ================================================
     * jquery 기반 select2 plugin 적용된 검색가능한 selectbox 공통 event
     * selectbox 키보드 tab 누를 때 검색창 focus이벤트임.
     * focus가 안되는 이슈가 있어서 추가.
     * ================================================
     */
    $("#sub_wrap").on('focus',".select2.select2-container", function (e) {
        // only open on original attempt - close focus event should not fire open
        if (e.originalEvent && $(this).find(".select2-selection--single").length > 0) {
            $(this).siblings('select:enabled').select2('open');
        }
    });
    
    /**
     * ====================================
     * 공통 Enter key 이벤트 각화면에
     * doSearch function 구현해서 사용
     *
     * e 이벤트 parameter로 각 화면에서 분기처리해서 사용하세요.
     * e.target.id를 꺼내서 쓴다거나 ..
     * ====================================
     */
    // document.querySelector('#sub_wrap').addEventListener("keypress", function(e){
    //     if (e.key == "Enter" && e.target.classList.contains('schClass')){
    //         if( typeof(doSearch) != "undefined" ){
    //             doSearch(e);
    //         }

    //         if( typeof(dialogDoSearch) != "undefined" ){
    //             dialogDoSearch(e);
    //         }
    //     }
    // });
    $(".schClass").keypress(function (e) {
        setTimeout(function() {
            if (e.key == "Enter" && e.target.classList.contains('schClass')){
                if( typeof(doSearch) != "undefined" ){
                    doSearch(e);
                }
            }
        }, 100);
    });
});
