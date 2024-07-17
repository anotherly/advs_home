<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/html/resource/css/lib/fullpage.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/ux-common.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/sub.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/us_ce.css"> -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function() {
	scrollFn();
});

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
	                        scrollTop :(offsetTop-30) // tab이 text 가려서 약간 위로 올림
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
</script>

<!-- container -->
<div class="wrap">
	<div class="container">
		<div class="container__inner">
			<div class=content>
				<div class="content__inner">
			
					<div class="layout-container layout-full">
	                    <div class="layout-container__inner layout-container--row">
							<div class="lnb">
	                            <h3 class="lnb__tit">이용안내</h3>
	                            <div class="lnb-list">
	                                <div class="lnb-item is-active">
	                                    <a href="/center/introduce/Gude_Avsc_View.do">데이터 공유센터 소개</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cits_View.do">자율주행 AI 학습용 데이터</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cons_View.do">데이터공유협의체</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Legl_View.do">법령 및 지침</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Rept_View.do">자율주행차 임시운행허가</a>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="layout-content">
                           		<div class="layout-content__inner">
                           			<div class="layout-content__top">
	                                    <h4 class="layout-content__tit">데이터 공유센터 소개</h4>
	                                    <ul class="location ml-auto">
	                                        <li>
	                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
	                                        <li>이용안내</li>
	                                        <li>데이터 공유센터 소개</li>
	                                    </ul>
	                                </div>
									<div class="layout-content__view">
										<div class="el-platform el-platform--us_ce_01">
											<h5 class="el-platform__tit">자율주행 데이터 공유센터</h5>
											<div class="el-platform__txt2">
											자율주행 데이터공유센터는 <strong>자율주행 수집 플랫폼</strong>을 통해 생성된  <strong>주행데이터를 수집•가공</strong>하여 산학연 공유를 통해 <br class="guide_br">  
											국내  <strong>자율주행 기술개발을 지원</strong>하며, 포털에서는 자율주행 기술개발 기관이 데이터를 이용할 수 있도록, <br class="guide_br"> 
											주행 영상 데이터, 점군데이터 등 센서 데이터 및 2D/3D 바운딩박스, 세그멘테이션 등 가공데이터를 <br class="guide_br">
											도로, 날씨 조건 등에 따라 쉽고 편리하게 검색하고 다운로드 받을 수 있습니다.											
		                                    </div>
										</div>
										
										<div class="layout-content__tab mt-180">
											<div class="tab-wrap">
												<div class="tab-list d-flex">
													<div class="tab-item flex-1">
														<button class="tab-item__btn">구축 · 운영근거</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">공유 시스템 구성</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">문의 및 연락처</button>
													</div>
												</div>
												
												<div id="us_ce_01--01" class="tab-cont">
													<h5 class="tab-cont__tit">구축 및 운영근거</h5>
													<div class="tab-cont__txt">주행 데이터 공유센터 구축, 국토교통 혁신성장추진계획, ‘18년 정부업무보고</div>
													<div class="el-box mt-20">
														<p class="el-box__tit color-blue">
															자동차관리법 제27조 5항
														</p>
														<p class="el-box__txt">
															<strong>임시운행허가를 받은 자</strong>는 자율주행자동차의 안전한 운행을 위하여
															<strong>
																주요 장치 및 기능의 변경 사항, 운행기록 등 운행에 관한 정보 및 교통사고와 관련한 정보 등 국토교통부령으로 정하는 사항
															</strong>
															을 국토교통부령으로 정하는 바에 따라
															<strong>국토교통부장관에게 보고</strong>
															하여야 한다.
														</p>
													</div>
												</div>
												
												<div id="us_ce_01--02"  class="tab-cont">
													<h5 class="tab-cont__tit">공유 시스템 구성</h5>
													<span class="tab-cont__img">
														<img src="/image/sub/img-us_ce_01--img02.png">
													</span>
												</div>
												
												<div id="us_ce_01--03" class="tab-cont ce01_pb">
													<h5 class="tab-cont__tit">문의 및 연락처</h5>
													<div class="tab-cont__txt">${map.content}</div>
													<div class="el-box mt-20 el-box__txt">
														<div class="el-box__dl">
															<div class="dt">문의</div>
															<div class="dd">${map.telNo}</div>
															<div class="dt">FAX</div>
															<div class="dd">${map.faxNo}</div>
															<div class="dt">E-mail</div>
															<div class="dd">${map.email}</div>
														</div>
													</div>
												</div>
												
											</div>
										</div>
									</div>

								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
