
/**
 * 2021-06-01
 * 탭 관련 event
 */
$(function tab() {

//$("#tabCtsLst > *").eq(0).show().siblings().hide();

for(var i=1; i<5; i++){
$("#tabMenu"+i+"").click(function(){	
$("#tabCts"+i+"").show();
$("#tabMenu"+i+"").addClass("on");
});
}

$("#tabMenuLst ul li").click(function (){
var tabTarget = $(this).index();
$(this).addClass("on").siblings().removeClass("on");
$("#tabCtsLst > *").eq(tabTarget).show().siblings().hide();
var ctsHei = $(".ctsArea").css("height");
$(".sidebar").css("height", ctsHei).css("padding-bottom","39px");
});


$("#subtabMenuLst ul li").click(function (){	
var tabTarget = $(this).index();
$(this).addClass("on").siblings().removeClass("on");
$("#subtabCtsLst > *").eq(tabTarget).show().siblings().hide();
var ctsHei = $(".ctsArea").css("height");
$(".sidebar").css("height", ctsHei).css("padding-bottom","39px");
});

//tabMenuLst 안에 든 탭 이벤트
for(var i=1; i<5; i++){
	$("#tabSubMenu"+i+"").click(function(){	
	$("#tabSubCts"+i+"").show();
	$("#tabSubMenu"+i+"").addClass("on");
	});
	}

	$("#tabSubMenuLst ul li").click(function (){
	var tabTarget = $(this).index();
	$(this).addClass("on").siblings().removeClass("on");
	$("#tabSubCtsLst > *").eq(tabTarget).show().siblings().hide();
	var ctsHei = $(".ctsArea").css("height");
	$(".sidebar").css("height", ctsHei).css("padding-bottom","39px");
	});
});

/* main tab menu*/
$(document).ready(function () {
    var $wrapper = $('.tab-wrapper'),
    $allTabs = $wrapper.find('.tab-content > div'),
    $tabMenu = $wrapper.find('.tab-menu li'),
    $line = $('<div class="line"></div>').appendTo($tabMenu);

    $allTabs.not(':first-of-type').hide();
    $tabMenu.filter(':first-of-type').find(':first').width('100%');

    $tabMenu.each(function (i) {
        $(this).attr('data-tab', 'tab' + i);
    });

    $allTabs.each(function (i) {
        $(this).attr('data-tab', 'tab' + i);
    });

    $tabMenu.on('click', function () {

        var dataTab = $(this).data('tab'),
        $getWrapper = $(this).closest($wrapper);

        $getWrapper.find($tabMenu).removeClass('active');
        $(this).addClass('active');

        $getWrapper.find('.line').width(0);
        $(this).find($line).animate({ 'width': '100%' }, 'fast');
        $getWrapper.find($allTabs).hide();
        $getWrapper.find($allTabs).filter('[data-tab=' + dataTab + ']').show();
    });
});

/**
 * 2021-06-01
 * dialog popup event
 */
$(function popup() {
  var popLen = $(".popup").length;
  for(var i=1; i<=popLen; i++){

    // 반복함수
    (function(e){

    // 열기 버튼 클릭 이벤트
    $('.popupBtn'+e+'').click(function() {
        $('.popupBg, .popup'+e+'').fadeIn(500);
        $('.popup'+e+'').addClass("on");
    });
    
    // 닫기 버튼 클릭 이벤트
    $('.popup'+e+' .popupClose, .popupBg').click(function() {
        $('.popup'+e+'').fadeOut(500).removeClass("on");

        //팝업 2개이상 열시, 닫기 버튼에 .popupBg지우다. 혹은 .popupBg유지하고 닫기버튼만 하나씩 닫히고 배경은 다 닫히는 조건으로 인식
        if ( $('.popup.on').length < 1 ) { 
            $('.popupBg').fadeOut(500);
        }
    });

    function popupCenter() { // 팝업 center 정렬 함수
    //팝업 높이 넓이 윈도우사이즈에 맞게 구한후 센터 정렬
	    $('.popup'+e+'').css({
	        'left': ( $(window).width() - $('.popup'+e+'').width() ) / 2 + "px",
	        'top': ( $(window).height() - $('.popup'+e+'').height() ) / 2 + "px"
	    }); // 팝업 중앙 위치 계산 끝
    } // 팝업 center 정렬 함수 끝

    popupCenter(); // 첫 팝업 띄울때 center 정렬
    $(window).resize(function() {
    popupCenter();
    }); // 브라우저 창 사이즈 조절할 때도 항상 중앙 정렬

})(i); //반복함수끝
} // for문 끝

});

/**
 * 2021-06-01
 * footer Scroll event
 */
$(function footerScroll() {

	$(window).scroll(function(){
		var h = $(this).scrollTop();
		if(h > 10){
			$(".scrollTop").stop().animate({bottom:'20px'},300, 'linear');
		}else{
			$(".scrollTop").stop().animate({bottom:'-50px'},300, 'linear');
		}
	});

	$(".scrollTop").click(function(){
		$("html").animate({scrollTop:0},500);
	});
});