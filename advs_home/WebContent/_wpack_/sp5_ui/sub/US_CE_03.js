/*amd /sp5_ui/sub/US_CE_03.xml 21788 84d6282ecf5326b957873c59d5ad110f7985fe062a16b379f949f79e84b131a1 */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/lib/fullpage.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/ux-common.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/sub.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/us_ce.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:MSA'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'w2:publicInfo',A:{method:''}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/jquery/jquery-3.6.1.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/fullpage.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/tweenmax.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/common.js'}},{T:1,N:'script',A:{lazy:'false',type:'text/javascript'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
	scwin.onpageload = function() {
		($(function(){
			lnbFn();
			scrollFn();
			$('header, footer').addClass('sub');
		}))
		
		function lnbFn(){
		    const aDepth1 = $('.lnb-item.is-active > a');
		    const newEl = document.createElement('span');
			$('.lnb-depth--02').prev('a').attr('href', 'javascript:void(0)').parents('.lnb-item').addClass('hasChild');
		    aDepth1.prepend(newEl);
		}
		
		function scrollFn(){			
			var tabList = $(".tab-wrap").offset().top - $('header').height();
 
			  $(window).scroll(function() {
			    var window = $(this).scrollTop();
			    if(tabList <= window) {
			      $(".tab-list").addClass("solid");
			    }else{
			      $(".tab-list").removeClass("solid");
			    }
			  });
			
			
			(function (global, $) {
			    var $menu     = $('.tab-item'),
			        $contents = $('.tab-cont'),
			        $doc      = $('html, body');
			    $(function () {
			        // 해당 섹션으로 스크롤 이동
			        $menu.on('click','button', function(e){
			            var $target = $(this).parent(),
			                idx     = $target.index(),
			                section = $contents.eq(idx),
			                offsetTop = section.offset().top - $('header').height()*2;
			            $doc.stop()
			                    .animate({
			                        scrollTop :offsetTop
			                    }, 800);
			            return false;
			        });
			    });
			    // menu class 추가
			    $(window).scroll(function(){
			        var scltop = $(window).scrollTop() + $('header').height()*3;
			        $.each($contents, function(idx, item){
			            var $target   = $contents.eq(idx),
			                i         = $target.index(),
			                targetTop = $target.offset().top;
			
			            if (targetTop <= scltop) {
			                $menu.removeClass('is-click');
			                $menu.eq(idx).addClass('is-click');
			            }
			            if (!(500 <= scltop)) {
			                $menu.removeClass('is-click');
			            }
			        })
			
			    });
			}(window, window.jQuery));
		}
	
	};
	scwin.side_menu_onclick = function(e) {
	    $('.side-menu__btn').addClass('is-click');
	};
	
scwin.btnDownload_onclick = function(e) {
        document.location.href = "/templetFile/협의체 가입 서류.zip"
};

/*
scwin.lnk01_onclick = function(e) {
	window.open('http://www.molit.go.kr/');
};

scwin.lnk02_onclick = function(e) {
	window.open('http://www.kotsa.or.kr/');
};

scwin.lnk03_onclick = function(e) {
	window.open('https://www.hyundai.com/kr/ko');
};

scwin.lnk04_onclick = function(e) {
	window.open('http://www.snu.ac.kr/');
};

scwin.lnk05_onclick = function(e) {
	window.open('http://www.mobis.co.kr/');
};

scwin.lnk06_onclick = function(e) {
	window.open('https://www.kaist.ac.kr/');
};

scwin.lnk07_onclick = function(e) {
	window.open('https://www.mando.com/');
};

scwin.lnk08_onclick = function(e) {
	window.open('https://www.sktelecom.com/');
};

scwin.lnk09_onclick = function(e) {
	window.open('https://www.kt.com/');
};

scwin.lnk10_onclick = function(e) {
	window.open('http://www.katech.re.kr/');
};

scwin.lnk11_onclick = function(e) {
	window.open('https://www.etri.re.kr/');
};

scwin.lnk12_onclick = function(e) {
	window.open('http://sonnet.ai/');
};

scwin.lnk13_onclick = function(e) {
	window.open('http://www.prosensetek.com/');
};

scwin.lnk14_onclick = function(e) {
	window.open('https://www.yonsei.ac.kr/sc/');
};

scwin.lnk15_onclick = function(e) {
	window.open('http://www.carnavi.com/');
};

scwin.lnk16_onclick = function(e) {
	window.open('http://www.it-telecom.co.kr/');
};

scwin.lnk17_onclick = function(e) {
	window.open('http://www.wayties.com/');
};

scwin.lnk18_onclick = function(e) {
	window.open('http://www.ilmilecorp.com/');
};

scwin.lnk19_onclick = function(e) {
	window.open('http://www.mobiltech.io/');
};

scwin.lnk20_onclick = function(e) {
	window.open('http://www.morai.ai/');
}; */

}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload'},E:[{T:1,N:'xf:group',A:{class:'wrap',id:'',style:''},E:[{T:1,N:'w2:wframe',A:{id:'',src:'/sp5_ui/header.xml',style:''}},{T:1,N:'xf:group',A:{class:'container',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'container__inner',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'content',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'content__inner',id:'',style:''},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-container layout-full'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-container__inner layout-container--row'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb'},E:[{T:1,N:'w2:tag',A:{tagname:'h3',style:'',id:'',class:'lnb__tit'},E:[{T:3,text:'이용안내'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-list'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-item'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/center/introduce/Gude_Avsc_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'데이터 공유센터 소개'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-item'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/center/introduce/Gude_Cits_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'자율주행 AI 학습용 데이터'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item is-active is-open',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Cons_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'데이터공유협의체'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Legl_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'법령 및 지침'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Rept_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'자율주행차 임시운행허가'}]}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__inner'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__top'},E:[{T:1,N:'w2:tag',A:{tagname:'h4',style:'',id:'',class:'layout-content__tit'},E:[{T:3,text:'데이터공유협의체'}]},{T:1,N:'xf:group',A:{style:'',id:'',tagname:'ul',class:'location ml-auto'},E:[{T:1,N:'xf:group',A:{style:'',id:'',tagname:'li'},E:[{T:1,N:'xf:image',A:{src:'../resource/image/sub/icon/icon-home.png',style:'',id:'',alt:'홈'}}]},{T:1,N:'w2:tag',A:{tagname:'li',style:'',id:''},E:[{T:3,text:'이용안내'}]},{T:1,N:'w2:tag',A:{tagname:'li',style:'',id:''},E:[{T:3,text:'데이터공유협의체'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__view'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'el-platform el-platform--us_ce_03'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'el-platform__tit'},E:[{T:3,text:'주행 데이터 공유 협의체'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-platform__txt'},E:[{T:1,N:'strong',E:[{T:3,text:'자율주행 기술'}]},{T:3,text:'을 '},{T:1,N:'strong',E:[{T:3,text:'개발'}]},{T:3,text:'하는 산·학·연 기관이 개별적으로 수집하고 있는 '},{T:1,N:'strong',E:[{T:3,text:'주행 관련 데이터'}]},{T:3,text:'를 상호 공유하여 \n    													중복투자를 방지하고, 고가의 자율주행차 운영이 곤란한\n    													'},{T:1,N:'strong',E:[{T:3,text:'스타트업· 중소기업'}]},{T:3,text:'\n    													등의\n    													'},{T:1,N:'strong',E:[{T:3,text:'데이터 수집 가공'}]},{T:3,text:'\n    													을 지원하여\n    													'},{T:1,N:'strong',E:[{T:3,text:'국내 자율주행 기술 개발 가속화 지원'}]},{T:1,N:'xf:group',A:{style:'',id:'',tagname:'div',class:'btn-wrap mt-20'},E:[{T:1,N:'xf:group',A:{style:'',id:'btnDownload',tagname:'button',class:'btn btn-color--navy px-30','ev:onclick':'scwin.btnDownload_onclick'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]}]},{T:1,N:'xf:image',A:{src:'/html/resource/image/common/icon/icon-download--white.png',style:'',id:''}},{T:3,text:'\n    															가입신청서 다운로드\n    														'}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__tab mt-250'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-wrap'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-list d-flex'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-item flex-1'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-item__btn',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_03--01'}]}]},{T:3,text:'\n	    																공유 데이터\n	    															'}]}]},{T:1,N:'xf:group',A:{class:'tab-item nextItem flex-1',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'tab-item__btn',id:'',style:'',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_03--02'}]}]},{T:3,text:'\n	    																주요데이터\n	    															'}]}]},{T:1,N:'xf:group',A:{class:'tab-item flex-1',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'tab-item__btn',id:'',style:'',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_03--03'}]}]},{T:3,text:'\n	    																참여기관\n	    															'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_03--01',class:'tab-cont'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'tab-cont__tit'},E:[{T:3,text:'공유 데이터'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box-group d-flex'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box--border box-group-ce02--01 w-50'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'box-imgInfo__tit',tagname:'p'},E:[{T:1,N:'w2:tag',A:{tagname:'strong',style:'',id:''},E:[{T:3,text:'자율주행'}]},{T:3,text:'\n	    																	인지 성능 향상\n	    																	'},{T:1,N:'w2:tag',A:{tagname:'strong',style:'',id:''},E:[{T:3,text:'을 위한 딥러닝 학습 데이터'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box__img'},E:[{T:1,N:'xf:image',A:{src:'/html/resource/image/sub/img-us_ce_03--img02.jpg',style:'',id:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box--border box-group-ce02--02 w-50'},E:[{T:1,N:'xf:group',A:{class:'box-imgInfo__tit',id:'',style:'',tagname:'p'},E:[{T:3,text:'\n	    																	End to End\n	    																	'},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'딥러닝을 위한 학습 데이터'}]}]},{T:1,N:'xf:group',A:{class:'el-box__img',id:'',style:''},E:[{T:1,N:'xf:image',A:{id:'',src:'/html/resource/image/sub/img-us_ce_03--img03.jpg',style:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box--border box-group-ce02--03 w-50'},E:[{T:1,N:'xf:group',A:{class:'box-imgInfo__tit',id:'',style:'',tagname:'p'},E:[{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'자율주행'}]},{T:3,text:'\n	    																	정밀 지도\n	    																	'},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'및'}]},{T:3,text:'\n	    																	도로 구조\n	    																	'},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'정보'}]}]},{T:1,N:'xf:group',A:{class:'el-box__img',id:'',style:''},E:[{T:1,N:'xf:image',A:{id:'',src:'/html/resource/image/sub/img-us_ce_03--img04.jpg',style:''}}]}]},{T:1,N:'xf:group',A:{class:'el-box--border box-group-ce02--04 w-50',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'box-imgInfo__tit',id:'',style:'',tagname:'p'},E:[{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'자율주행'}]},{T:3,text:'\n	    																	실증 사업(FOT)\n	    																	'},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'strong'},E:[{T:3,text:'수집 데이터'}]}]},{T:1,N:'xf:group',A:{class:'el-box__img',id:'',style:''},E:[{T:1,N:'xf:image',A:{id:'',src:'/html/resource/image/sub/img-us_ce_03--img05.jpg',style:''}}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_03--02',class:'tab-cont'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'tab-cont__tit'},E:[{T:3,text:'주요데이터'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box'},E:[{T:1,N:'xf:group',A:{style:'',id:'',tagname:'ul',class:'box-imgInfo__ul lists lists-dot'},E:[{T:1,N:'w2:tag',A:{tagname:'li',style:'',id:''},E:[{T:3,text:'\n	    																	자율주행차 운행을 통해 수집한 주행 영상, 라이다 등의 원시 데이터\n	    																'}]},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'li'},E:[{T:3,text:'\n	    																	자율주행 인지 성능 향상 및 딥러닝 기술개발을 위한 AI 학습용 데이터\n	    																'}]},{T:1,N:'w2:tag',A:{id:'',style:'',tagname:'li'},E:[{T:3,text:'\n	    																	V2X 단말 개발을 위한 통신을 통하여 수집된 BSM, PVD 데이터\n	    																'}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_03--03',class:'tab-cont ce03_pb'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'tab-cont__tit'},E:[{T:3,text:'참여기관'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'company-list'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'company-item'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'company-item__img el-box--border',tagname:'span'},E:[{T:1,N:'xf:image',A:{src:'/html/resource/image/sub/img-us_ce_03-com--01.jpg',style:'',alt:'국토교통부',id:'lnk01'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk02',src:'/html/resource/image/sub/img-us_ce_03-com--02.jpg',style:'',alt:'TS한국교통안전공단'}}]}]},{T:1,N:'xf:group',A:{class:'company-item bg-color--navy',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk03',src:'/html/resource/image/sub/img-us_ce_03-com--03.jpg',style:'',alt:'HYUNDAI'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk04',src:'/html/resource/image/sub/img-us_ce_03-com--04.jpg',style:'',alt:'서울대'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk05',src:'/html/resource/image/sub/img-us_ce_03-com--05.jpg',style:'',alt:'HYUNDAI MOBIS'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk06',src:'/html/resource/image/sub/img-us_ce_03-com--06.jpg',style:'',alt:'KAIST'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk07',src:'/html/resource/image/sub/img-us_ce_03-com--07.jpg',style:'',alt:'Mando'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk08',src:'/html/resource/image/sub/img-us_ce_03-com--08.jpg',style:'',alt:'SK telecom'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk09',src:'/html/resource/image/sub/img-us_ce_03-com--09.jpg',style:'',alt:'kt'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk10',src:'/html/resource/image/sub/img-us_ce_03-com--10.jpg',style:'',alt:'katech'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk11',src:'/html/resource/image/sub/img-us_ce_03-com--11.jpg',style:'',alt:'ETRI'}}]}]},{T:1,N:'xf:group',A:{class:'company-item bg-color-raisinBlack',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk12',src:'/html/resource/image/sub/img-us_ce_03-com--12.jpg',style:'',alt:'SONNET.ai'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk13',src:'/html/resource/image/sub/img-us_ce_03-com--13.jpg',style:'',alt:'PROSENSE'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk14',src:'/html/resource/image/sub/img-us_ce_03-com--14.jpg',style:'',alt:'연세대학교'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk15',src:'/html/resource/image/sub/img-us_ce_03-com--15.jpg',style:'',alt:'cainavi.com'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk16',src:'/html/resource/image/sub/img-us_ce_03-com--16.jpg',style:'',alt:'iTtelecom'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk17',src:'/html/resource/image/sub/img-us_ce_03-com--17.jpg',style:'',alt:'wayties'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk18',src:'/html/resource/image/sub/img-us_ce_03-com--18.jpg',style:'',alt:'Dtonic'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk19',src:'/html/resource/image/sub/img-us_ce_03-com--19.jpg',style:'',alt:'MOBILTECH'}}]}]},{T:1,N:'xf:group',A:{class:'company-item',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'company-item__img el-box--border',id:'',style:'',tagname:'span'},E:[{T:1,N:'xf:image',A:{id:'lnk20',src:'/html/resource/image/sub/img-us_ce_03-com--20.jpg',style:'',alt:'MORAI'}}]}]}]}]}]}]}]}]}]}]}]}]}]}]}]},{T:1,N:'footer',A:{style:'',id:''},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'footer__inner'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'footer-logo',tagname:'span'},E:[{T:1,N:'xf:image',A:{src:'../resource/image/main/img-logo-head-color.png',style:'',id:''}}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'d-flex align-end'},E:[{T:1,N:'xf:group',A:{style:'',id:'',tagname:'address'},E:[{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'주소'}]},{T:3,text:'\n    						18247) 경기도 화성시 송산면 삼존로 200 자동차안전연구원｜\n    						'},{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'문의전화'}]},{T:3,text:'\n    						1577-0990\n    					'}]},{T:1,N:'w2:tag',A:{tagname:'button',style:'',id:'',class:'btn btn--report'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]}]},{T:3,text:'\n    						품질오류 신고 및 확인\n    					'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'footer-link',tagname:'a'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:href'}]},{T:1,N:'xf:image',A:{src:'../resource/image/common/img-main-visual--logo01.png',style:'',id:''}}]},{T:1,N:'xf:group',A:{class:'footer-link',id:'',style:'',tagname:'a'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:href'}]},{T:1,N:'xf:image',A:{id:'',src:'../resource/image/common/img-main-visual--logo02.png',style:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'copyRight',tagname:'p'},E:[{T:3,text:'\n    					©2022.\n    					'},{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'TS Corp.'}]},{T:3,text:'\n    					All rights reserved.\n    				'}]}]}]}]}]}]}]})