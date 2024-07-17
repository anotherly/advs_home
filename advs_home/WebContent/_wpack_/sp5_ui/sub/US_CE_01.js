/*amd /sp5_ui/sub/US_CE_01.xml 13681 40335e9b9c5181e144388b4c5cf753546f2ecd703d0d6396d50500d767b91df0 */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/lib/fullpage.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/ux-common.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/sub.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/us_ce.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:MSA'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'w2:publicInfo',A:{method:''}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/jquery/jquery-3.6.1.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/fullpage.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/tweenmax.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/common.js'}},{T:1,N:'script',A:{lazy:'false',type:'text/javascript',charset:'euc-kr'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
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
		
  var content = decodeURIComponent($w.getParameter("content"));
  var telNo = decodeURIComponent($w.getParameter("telNo"));
  var faxNo = decodeURIComponent($w.getParameter("faxNo"));
  var email = decodeURIComponent($w.getParameter("email"));
  
  var content = content.replaceAll("+","\u00A0");
   
  textarea2.setValue(content);
  textarea3.setValue(telNo);
  textarea4.setValue(faxNo);
  textarea5.setValue(email);
		
};
scwin.side_menu_onclick = function(e) {
    $('.side-menu__btn').addClass('is-click');
};
 

}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload'},E:[{T:1,N:'xf:group',A:{class:'wrap',id:'',style:''},E:[{T:1,N:'w2:wframe',A:{id:'',src:'/sp5_ui/header.xml',style:''}},{T:1,N:'xf:group',A:{class:'container',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'container__inner',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'content',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'content__inner',id:'',style:''},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-container layout-full'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-container__inner layout-container--row'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb'},E:[{T:1,N:'w2:tag',A:{tagname:'h3',style:'',id:'',class:'lnb__tit'},E:[{T:3,text:'이용안내'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-list'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-item is-active is-open'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/center/introduce/Gude_Avsc_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'데이터 공유센터 소개'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'lnb-item'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/center/introduce/Gude_Cits_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'자율주행 AI 학습용 데이터'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Cons_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'데이터공유협의체'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Legl_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'법령 및 지침'}]}]}]},{T:1,N:'xf:group',A:{class:'lnb-item',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:'',href:'/center/introduce/Gude_Rept_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'자율주행차 임시운행허가'}]}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__inner'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__top'},E:[{T:1,N:'w2:tag',A:{tagname:'h4',style:'',id:'',class:'layout-content__tit'},E:[{T:3,text:'데이터 공유센터 소개'}]},{T:1,N:'xf:group',A:{style:'',id:'',tagname:'ul',class:'location ml-auto'},E:[{T:1,N:'xf:group',A:{style:'',id:'',tagname:'li'},E:[{T:1,N:'xf:image',A:{src:'../resource/image/sub/icon/icon-home.png',style:'',id:'',alt:'홈'}}]},{T:1,N:'w2:tag',A:{tagname:'li',style:'',id:''},E:[{T:3,text:'이용안내'}]},{T:1,N:'w2:tag',A:{tagname:'li',style:'',id:''},E:[{T:3,text:'데이터 공유센터 소개'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__view'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'el-platform el-platform--us_ce_01'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'el-platform__tit'},E:[{T:3,text:'자율주행 데이터 공유센터'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-platform__txt'},E:[{T:1,N:'strong',E:[{T:3,text:'공유센터'}]},{T:3,text:'\n    													는 공공·민간의 자율주행차 시험운행을 통해 생성된\n    													'},{T:1,N:'strong',E:[{T:3,text:'주행데이터'}]},{T:3,text:'\n    													를\n    													'},{T:1,N:'strong',E:[{T:3,text:'수집 ·분석'}]},{T:3,text:'\n    													하여 산학연 공유하여\n    													'},{T:1,N:'strong',E:[{T:3,text:'국내 자율주행 기술개발 지원'}]},{T:3,text:'\n    													하며, 포털에서는 자율주행 기술개발 기관이 데이터를 이용할 수 있도록, 주행 영상데이터, 레이더 등\n    													'},{T:1,N:'strong',E:[{T:3,text:'센서 데이터'}]},{T:3,text:'\n    													를 주행환경, 기상 조건등에 따라\n    													'},{T:1,N:'strong',E:[{T:3,text:'쉽고 편리'}]},{T:3,text:'\n    													하게\n    													'},{T:1,N:'strong',E:[{T:3,text:'데이터'}]},{T:3,text:'\n    													를\n    													'},{T:1,N:'strong',E:[{T:3,text:'확인'}]},{T:3,text:'\n    													할 수 있습니다.\n    												'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'layout-content__tab mt-180'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-wrap'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-list d-flex'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-item flex-1'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-item__btn',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_01--01'}]}]},{T:3,text:'\n    																구축 · 운영근거\n    															'}]}]},{T:1,N:'xf:group',A:{class:'tab-item nextItem flex-1',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'tab-item__btn',id:'',style:'',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_01--02'}]}]},{T:3,text:'\n    																공유 시스템 구성\n    															'}]}]},{T:1,N:'xf:group',A:{class:'tab-item flex-1',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'tab-item__btn',id:'',style:'',tagname:'button'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]},{T:1,N:'w2:data-anchor',E:[{T:3,text:'mf_us_ce_01--03'}]}]},{T:3,text:'\n    																문의 및 연락처\n    															'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_01--01',class:'tab-cont'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'tab-cont__tit'},E:[{T:3,text:'구축 및 운영근거'}]},{T:1,N:'w2:tag',A:{tagname:'div',style:'',id:'',class:'tab-cont__txt'},E:[{T:3,text:'\n    															주행 데이터 공유센터 구축, 국토교통 혁신성장추진계획, ‘18년 정부업무보고\n    														'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box mt-20'},E:[{T:1,N:'w2:tag',A:{tagname:'p',style:'',id:'',class:'el-box__tit color-blue'},E:[{T:3,text:'\n    																자동차관리법 제27조 5항\n    															'}]},{T:1,N:'w2:tag',A:{tagname:'p',style:'',id:'',class:'el-box__txt'},E:[{T:1,N:'strong',E:[{T:3,text:'임시운행허가를 받은 자'}]},{T:3,text:'\n    																는 자율주행자동차의 안전한 운행을 위하여\n    																'},{T:1,N:'strong',E:[{T:3,text:'\n    																	주요 장치 및 기능의 변경 사항, 운행기록 등 운행에 관한 정보 및 교통사고와 관련한 정보 등 국토교통부령으로 정하는 사항\n    																'}]},{T:3,text:'\n    																을 국토교통부령으로 정하는 바에 따라\n    																'},{T:1,N:'strong',E:[{T:3,text:'국토교통부장관에게 보고'}]},{T:3,text:'\n    																하여야 한다.\n    															'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_01--02',class:'tab-cont'},E:[{T:1,N:'w2:tag',A:{class:'tab-cont__tit',id:'',style:'',tagname:'h5'},E:[{T:3,text:'공유 시스템 구성'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'tab-cont__img',tagname:'span'},E:[{T:1,N:'xf:image',A:{src:'/html/resource/image/sub/img-us_ce_01--img02.png',style:'',id:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'us_ce_01--03',class:'tab-cont ce01_pb'},E:[{T:1,N:'w2:tag',A:{tagname:'h5',style:'',id:'',class:'tab-cont__tit'},E:[{T:3,text:'문의 및 연락처'}]},{T:1,N:'w2:span',A:{id:'textarea2',label:'',style:'',class:'tab-cont__txt'}},{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box mt-20'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'el-box__dl',tagname:'dl'},E:[{T:1,N:'w2:tag',A:{tagname:'dt',style:'',id:''},E:[{T:3,text:'문의'}]},{T:1,N:'w2:span',A:{id:'textarea3',label:'',style:'',class:'tab-cont__txt'}},{T:1,N:'w2:tag',A:{tagname:'dt',style:'',id:'',class:'ml-50'},E:[{T:3,text:'FAX'}]},{T:1,N:'w2:span',A:{id:'textarea4',label:'',style:'',class:'tab-cont__txt'}},{T:1,N:'w2:tag',A:{tagname:'dt',style:'',id:'',class:'ml-50'},E:[{T:3,text:'E-mail'}]},{T:1,N:'w2:span',A:{id:'textarea5',label:'',style:'',class:'tab-cont__txt'}}]}]}]}]}]}]}]}]}]}]}]}]}]}]},{T:1,N:'footer',A:{style:'',id:''},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'footer__inner'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'footer-logo',tagname:'span'},E:[{T:1,N:'xf:image',A:{src:'../resource/image/main/img-logo-head-color.png',style:'',id:''}}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'d-flex align-end'},E:[{T:1,N:'xf:group',A:{style:'',id:'',tagname:'address'},E:[{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'주소'}]},{T:3,text:'\n    						18247) 경기도 화성시 송산면 삼존로 200 자동차안전연구원｜\n    						'},{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'문의전화'}]},{T:3,text:'\n    						1577-0990\n    					'}]},{T:1,N:'w2:tag',A:{tagname:'button',style:'',id:'',class:'btn btn--report'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:type',E:[{T:3,text:'button'}]}]},{T:3,text:'\n    						품질오류 신고 및 확인\n    					'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'footer-link',tagname:'a'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:href'}]},{T:1,N:'xf:image',A:{src:'../resource/image/common/img-main-visual--logo01.png',style:'',id:''}}]},{T:1,N:'xf:group',A:{class:'footer-link',id:'',style:'',tagname:'a'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:href'}]},{T:1,N:'xf:image',A:{id:'',src:'../resource/image/common/img-main-visual--logo02.png',style:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'copyRight',tagname:'p'},E:[{T:3,text:'\n    					©2022.\n    					'},{T:1,N:'w2:span',A:{label:'',style:'',id:''},E:[{T:3,text:'TS Corp.'}]},{T:3,text:'\n    					All rights reserved.\n    				'}]}]}]}]}]}]}]})