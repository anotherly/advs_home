'use strice'; //'use strict'

($(function(){
	//개별 이벤트
	$('#mf_fullpage').parents('.content').addClass('main');
	$('.link-more').append('<span></span>');
	$('.fullpage-block--main .fullpage-box__quickLink > a').each(function() {
		var nowImg = $(this).find('img');  
		var srcName = nowImg.attr('src');  
		var newSrc = srcName.substring(0, srcName.lastIndexOf('.'));
		$(this).hover(function() { 
			$(this).find('img').attr('src', newSrc+ '-on.' + /[^.]+$/.exec(srcName)); 
			$(this).addClass('on');
		}, function() {
			$(this).find('img').attr('src', newSrc + '.' + /[^.]+$/.exec(srcName)); 
			$(this).removeClass('on');
		});    
	});
	
	gnbFn();
    fullpageFn();
}))

function fullpageFn(){
    $('#mf_fullpage').fullpage({
        // 이동
	menu: '#sidePaging',
	lockAnchors: false,
	anchors:['first', 'second', 'third'],
	navigation: true,
	navigationPosition: 'right',
	navigationTooltips: ['Main', 'Menu', 'thirdSlide'],
	showActiveTooltip: false,
	slidesNavigation: false,
	slidesNavPosition: 'bottom',

	// 스크롤
	css3: false,
	scrollingSpeed: 300,
	autoScrolling: true,
	fitToSection: true,
	fitToSectionDelay: 600,
	scrollBar: false,
	easing: 'easeInOutCubic',
	easingcss3: 'ease',
	loopBottom: false,
	loopTop: false,
	loopHorizontal: true,
	continuousVertical: false,
	continuousHorizontal: false,
	scrollHorizontally: false,
	interlockedSlides: false,
	dragAndMove: true,
	offsetSections: false,
	resetSliders: false,
	fadingEffect: false,
	touchSensitivity: 15,
	bigSectionsDestination: null,

	// 접근성
	keyboardScrolling: true,
	animateAnchor: true,
	recordHistory: true,

	// 디자인
	controlArrows: true,
	controlArrowsHTML: [
		'<div class="fp-arrow"></div>', 
		'<div class="fp-arrow"></div>'
	],
	verticalCentered: true,
	sectionsColor : ['#ccc', '#fff'],
	paddingTop: '40px',
	// paddingBottom: '10px',
	fixedElements: 'header, footer',
	responsiveWidth: 0,
	responsiveHeight: 0,
	responsiveSlides: false,
	parallax: false,
	parallaxOptions: {type: 'reveal', percentage: 62, property: 'translate'},
	dropEffect: false,
	dropEffectOptions: { speed: 2300, color: '#F82F4D', zIndex: 9999},
	waterEffect: false,
	waterEffectOptions: { animateContent: true, animateOnMouseMove: true},
	cards: false,
	cardsOptions: {perspective: 100, fadeContent: true, fadeBackground: true},

	// 맞춤 선택자
	sectionSelector: '.fullpage-block',
	slideSelector: '.slide',

	lazyLoading: true,
	observer: true,
	credits: { enabled: true, label: 'Made with fullPage.js', position: 'right'},

	// 사건(이벤트)
	beforeLeave: function(origin, destination, direction, trigger){},
	onLeave: function(origin, destination, direction, trigger){},
	afterLoad: function(origin, destination, direction, trigger){},
	afterRender: function(){},
	afterResize: function(width, height){},
	afterReBuild: function(){},
	afterResponsive: function(isResponsive){},
	afterSlideLoad: function(section, origin, destination, direction, trigger){},
	onSlideLeave: function(section, origin, destination, direction, trigger){},
    });
    
    //methods
    $.fn.fullpage.setAllowScrolling(true);
}

function gnbFn(){
    $('.gnb').mouseover(function(){
        gnb_Open();
        $('header').addClass('is-open');
    });
    $('.gnb > a').hover(function(){
        $('.gnb > a').removeClass('is-active');
        $(this).addClass('is-active');
    });
    $('header').mouseleave(function(){
        gnb_Close();
    });
    $('nav').mouseover(function(){
        gnb_Close();
    });
}
function gnb_Open(){
	TweenMax.killAll();
	TweenMax.to($("header"), 0.7, {
		height:462,
		ease:'easeOutExpo',
	});
}
function gnb_Close(){
	TweenMax.killAll();
	TweenMax.to($("header"), 0.5, {
		height:132,
    ease:'ease',
    onComplete:function(){
            $('header').removeClass('is-open');
		}
	});
}