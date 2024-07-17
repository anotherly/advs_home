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
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Avsc_View.do">데이터 공유센터 소개</a>
	                                </div>
	                                <div class="lnb-item is-active">
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
	                                    <h4 class="layout-content__tit">자율주행 AI 학습용 데이터</h4>
	                                    <ul class="location ml-auto">
	                                        <li>
	                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
	                                        <li>이용안내</li>
	                                        <li>자율주행 AI 학습용 데이터</li>
	                                    </ul>
	                                </div>
									<div class="layout-content__view">
										<div class="el-platform el-platform--us_ce_02">
											<h5 class="el-platform__tit">자율주행 AI 학습용 데이터 소개</h5>
											<div class="el-platform__txt2">
		                                        <strong>공공·민정부</strong> 주도<strong> 실증사업, 연구과제</strong> 등을 통해 수집된 공공이 보유한
    													<strong>주행데이터를 개방</strong>하여 <strong><br>민간 자율주행 기술 개발 기업 지원</strong>
		                                    </div>
										</div>
										
										<div class="layout-content__tab mt-180">
											<div class="tab-wrap">
												<div class="tab-list d-flex">
													<div class="tab-item flex-1">
														<button class="tab-item__btn">데이터 수집 플랫폼</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">주행 데이터 수집</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">수집 데이터 구성</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">학습용 데이터</button>
													</div>
												</div>
												
												<div id="us_ce_02--01" class="tab-cont">
													<h5 class="tab-cont__tit">데이터 수집 플랫폼</h5>
													<!-- <div class="tab-cont__txt">정부 주도 실증사업, 연구과제 등을 통해 수집된 공공이 보유한 주행데이터를 개방하여 민간 자율주행 기술 개발 기업 지원</div> -->
													<div class="tab-cont__txt"> 실증사업, 연구과제 등을 통해 수집된 주행 데이터를 개방하여 민간 자율주행 기술 개발 기업 지원</div>
													<div class="el-box mt-20">
														<p class="el-box__txt">
															∙ 자율주행차 안전성 평가기술 개발 과제의 실도로 실증 방법론 연구과제 수집 주행 데이터
														</p>
														<p class="el-box__txt">
															∙ 차세대 ITS 시범사업구간(대전~세종) 수집 원시 데이터
														</p>
														<p class="el-box__txt">
															∙ 주행 데이터 수집 플랫폼을 통해 수집된 주행 영상, 라이다, 센서 정보 등이 융합된 데이터셋(‘19년 추진)
														</p>
													</div>
												</div>
												
												<div id="us_ce_02--02"  class="tab-cont">
													<h5 class="tab-cont__tit">주행 데이터 수집</h5>
													<div class="el-box-group d-flex">
														<div class="el-box--border box-group--01 w-100">
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img08.jpg">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--01 w-50">
															<p class="box-imgInfo__tit">
																쏘렌토(2019)
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img09.jpg" style="" id="">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--02 w-50">
															<p class="box-imgInfo__tit">
																싼타페(2020)
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img10.jpg" style="" id="">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--03 w-50">
															<p class="box-imgInfo__tit">
																카니발(2021)
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img11.jpg" style="" id="">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--04 w-50">
															<p class="box-imgInfo__tit">
																제네시스(2022 제작 예정)
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img12.jpg" style="" id="">
															</div>
														</div>
														
														<!-- <div class="el-box--border box-group--03 w-100 d-flex">
															<span class="el-box__img el-box--left  flex-1">
																<img src="/image/sub/img-us_ce_02--img04.jpg">
															</span>
															<span class="el-box__imgInfo el-box--right  flex-1">
																<p class="box-imgInfo__tit">카메라 Mobileye 630 ELD(연구용) 사양</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>전방 충돌 경고(FCW), 차선 이탈 경고(LDW)</li>
																	<li>속도 제한 표시(SLI), 차간 거리 모니터링 및 경고(HMW) 등</li>
																</ul>
															</span>
														</div>
														<div class="el-box--border box-group--04  w-100 d-flex">
															<span class="el-box__img el-box--left  flex-1">
																<img src="/image/sub/img-us_ce_02--img05.jpg">
															</span>
															<span class="el-box__imgInfo el-box--right  flex-1">
																<p class="box-imgInfo__tit">라이다 SICK LD-MRS400001S01 사양</p>
																<p class="box-imgInfo__txt">레이저 등급 1 (IEC 60825-1:2014, EN 60825-1:2014)</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>작업 구역 0.5 m ... 300 m</li>
																	<li>감지범위 50 m (반사율 10 %에서)</li>
																	<li>거의 모든 형태 물체 감지</li>
																	<li>시스템 오류 : ± 300 mm</li>
																</ul>
															</span>
														</div> -->
													</div>
												</div>
												
												<div id="us_ce_02--03" class="tab-cont">
													<h5 class="tab-cont__tit">수집 데이터 구성</h5>
													<div class="el-box-group">
														<div class="el-box--border box-group--05">
															<div class="el-box__img el-box--top  flex-1 w-100 p-40">
																<img src="/image/sub/img-us_ce_02--img17.jpg" style="" id="">
															</div>
															<div class="el-box__img el-box--top  flex-1 w-100 p-40">
																<img src="/image/sub/img-us_ce_02--img17_2.jpg" style="" id="">
															</div>
															<!-- <span class="el-box__imgInfo el-box--bottom  flex-1 w-100 p-40">
																<p class="box-imgInfo__tit2">1. OBD &amp; 센서</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>OBD 및 IMU, GPS 등 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">2. Panorama</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>Camera Panorama View 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">3. CAMERA</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>Camera 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">4. LIDAR &amp; RADAR</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>Lidar &amp; Radar 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">5. AVM</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>Camera AVM Top View 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">6. GPS MAP</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>GPS MAP 데이터 실시간 스트리밍 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">7. 데이터 저장</p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>데이터 저장할 경우 데이터 저장되는 경로, 특이사항 메모, 데이터 저장 시간, <br>데이터 저장 및 종료 기능 구현</li>
																</ul>
																<p class="box-imgInfo__tit2">8. 센서 선택 </p>
																<ul class="box-imgInfo__ul lists lists-dot">
																	<li>데이터 수집 환경에서 원하는 센서 선택 기능 구현</li>
																</ul>
															</span> -->
														</div>
													</div>
												</div>
												<div id="us_ce_02--04" class="tab-cont">
													<h5 class="tab-cont__tit">학습용 데이터</h5>
													<div class="tab-cont__txt"> 자율주행 알고리즘이 학습가능한 형태로 주행데이터를 가공 처리 </div>
													<div class="el-box-group d-flex mt-20"">													
														<div class="el-box--border box-group-ce02--01 w-50">
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img13.jpg" style="" id="">
															</div>
															<p class="box-imgInfo__tit3">
																2D 바운딩 박스
															</p>
														</div>
														<div class="el-box--border box-group-ce02--02 w-50">
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img14.jpg" style="" id="">
															</div>
															<p class="box-imgInfo__tit3">
																3D 바운딩 박스
															</p>
														</div>
														<div class="el-box--border box-group-ce02--03 w-50">
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img15.jpg" style="" id="">
															</div>
															<p class="box-imgInfo__tit3">
																중정밀 세그멘테이션
															</p>
														</div>
														<div class="el-box--border box-group-ce02--04 w-50">
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_02--img16.jpg" style="" id="">
															</div>
															<p class="box-imgInfo__tit3">
																고정밀 세그멘테이션
															</p>
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
<!-- //container -->

