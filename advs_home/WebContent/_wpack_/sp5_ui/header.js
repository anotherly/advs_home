/*amd /sp5_ui/header.xml 14364 64f166fa3350c8979c0cd5d1bf1b3ec9c3470f81779cc9b594d46363ac9b28ac */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/lib/fullpage.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/ux-common.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/sub.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/html/resource/css/us_ce.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:MSA'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'w2:publicInfo',A:{method:''}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/jquery/jquery-3.6.1.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/fullpage.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/lib/tweenmax.min.js'}},{T:1,N:'script',A:{type:'text/javascript',src:'/html/resource/js/common.js'}},{T:1,N:'script',A:{lazy:'false',type:'text/javascript'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
		scwin.onpageload = function() {
			($(function(){
				lnbFn();
				scrollFn();
				$('header, footer').addClass('sub');
				authDataFn();
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
				
				function authDataFn(){
					scwin.pparam = WebSquare.net.getAllParameter();
					
					scwin.agcy_id = decodeURIComponent($w.getParameter("agcy_id"));
					scwin.agcy_nm = decodeURIComponent(scwin.pparam.agcy_nm);
					scwin.user_nm = decodeURIComponent(scwin.pparam.user_nm);
				
					if(scwin.agcy_id == ''){
						First.setValue("로그인");
						First.setHref("https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do");
						Second.setValue("회원가입");
						Second.setHref("https://www.kotsmbs/ia.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do");
						Third.setValue("ID/PW찾기");
						Third.setHref("https://www.kotsa.or.kr/nqFrmFindMemberId.do");
						Fourth.remove();
					}else{
						First.setValue(scwin.user_nm);
						Second.setValue("로그아웃");
						Second.setHref("/account/Logout_Process.do");
						Third.setValue("개인정보수정");
						Third.setHref("https://www.kotsa.or.kr/mpg/mim/MyPage.do");
						Fourth.setValue("My Data");
						Fourth.setHref("/account/Logout_Process.do");
					}
				}
		
		};
		scwin.side_menu_onclick = function(e) {
		    $('.side-menu__btn').addClass('is-click');
		};
	
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload'},E:[{T:1,N:'header',A:{style:'',id:''},E:[{T:1,N:'nav',A:{style:'',id:'',class:'nav'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'nav__inner'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'First',style:''}},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'Second',style:'',href:''}},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'Third',style:'',href:''}},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'Fourth',style:'',href:''}}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'header-menuWrap'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'header__inner'},E:[{T:1,N:'h1',A:{class:'header__logo'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'ancLogo',style:'',href:'/main/Main.do'},E:[{T:1,N:'xf:label'}]},{T:1,N:'w2:span',A:{label:'TS 한국교통안전공단 자동차안전연구원',style:'',id:'',class:'hidden'}}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/bbs/notice/Board_Notc_List.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'공지사항'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02'},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--02__inner',id:'',style:''},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'공지사항'}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03 part1',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/bbs/notice/Board_Notc_List.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'공지사항'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/bbs/trend/Board_Trnd_List.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'자율주행 최신동향'}]}]}]}]}]}]},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/center/introduce/Gude_Avsc_View_sp5.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'이용안내'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02'},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--02__inner',id:'',style:''},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'이용안내'}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03 part2',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/introduce/Gude_Avsc_View_sp5.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'데이터공유센터 소개'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/introduce/Gude_Cits_View_sp5.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'자율주행 AI 학습용 '},{T:1,N:'br'},{T:3,text:'데이터'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/introduce/Gude_Cons_View_sp5.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'데이터공유협의체'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/introduce/Gude_Legl_View_sp5.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'법령 및 지침'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/introduce/Gude_Rept_View_sp5.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'자율주행차 임시운행 '},{T:1,N:'br'},{T:3,text:'허가'}]}]}]}]}]}]},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/duty/incident/Duty_Incd_List.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'운행정보 보고'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02'},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--02__inner',id:'',style:''},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'운행정보 보고'}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03 part3',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/duty/incident/Duty_Incd_List.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'교통사고'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/duty/driving/Duty_Drvg_List.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'운행정보 보고서'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/duty/device/Duty_Devc_List.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'장치 및 기능변경'}]}]}]}]}]}]},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/open/normal/Open_Normal_List.do?bbs_seq=3010'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'공공데이터'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02__inner'},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'공공데이터'}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--03 part4'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--03__item',localeRef:''},E:[{T:1,N:'a',A:{href:'/open/normal/Open_Normal_List.do?bbs_seq=3010'},E:[{T:1,N:'w2:tag',A:{tagname:'h1',style:'',id:'',class:'gnb-depth--03__tit'},E:[{T:3,text:'\n    											일반 시나리오\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--03__item'},E:[{T:1,N:'a',A:{href:'/open/edge/Open_Edge_List.do?bbs_seq=3020'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											엣지케이스 시나리오\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--03__item'},E:[{T:1,N:'a',A:{href:'/open/v2x/Open_V2x_List.do?bbs_seq=3030'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											V2X\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]}]}]}]},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/open/normal/Open_Normal_List.do?bbs_seq=2080'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'협의체 데이터'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02'},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--02__inner',id:'',style:''},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'협의체 데이터'}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03 part5',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/open/normal/Open_Normal_List.do?bbs_seq=2080'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											일반 시나리오\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/open/edge/Open_Edge_List.do?bbs_seq=2090'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											엣지케이스 시나리오\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/open/v2x/Open_V2x_List.do?bbs_seq=2100'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											V2X\n    											'},{T:1,N:'br'},{T:3,text:'\n    											데이터셋\n    										'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/agency/off/Agcy_Off_Main.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'\n    											오프라인 공유\n    											'},{T:1,N:'br'},{T:3,text:'\n    											안내 및 신청\n    										'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'데이터셋(21년 이전)'}]}]}]}]}]}]},{T:1,N:'w2:anchor',A:{outerDiv:'false',id:'',style:'',href:'/sharing/car/Car_Reserve_Main.do'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'데이터 공유센터 시설이용'}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'gnb-depth--02 '},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--02__inner',id:'',style:''},E:[{T:1,N:'h2',A:{class:'gnb-depth--02__tit'},E:[{T:3,text:'데이터 공유센터 시설이용'}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03 part6',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/sharing/car/Car_Reserve_Main.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'차량 플랫폼 공유'}]}]}]},{T:1,N:'xf:group',A:{class:'gnb-depth--03__item',id:'',style:''},E:[{T:1,N:'a',A:{href:'/center/fact/Center_Fact_Main.do'},E:[{T:1,N:'w2:tag',A:{class:'gnb-depth--03__tit',id:'',style:'',tagname:'h1'},E:[{T:3,text:'공유센터 이용안내'}]}]}]}]}]}]}]}]}]}]}]}]}]})