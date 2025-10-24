<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/html/resource/css/lib/fullpage.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/ux-common.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/sub.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/us_ce.css"> -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
var c_form = "";
$(document).ready(function() {
	scrollFn();
// 	$('#joinDown').on('click', function() {
// 		location.href = "/templetFile/협의체 가입 서류.zip"
// 	});
	c_form = document.listForm; //폼 셋팅
}); 

/* 파일 다운로드  */
function fn_Download(file_nm) {
  c_form.file_nm.value = file_nm;
  c_form.dir_nm.value = "notc";
  c_form.action = "<c:url value='/common/File_Download.do'/>";
  c_form.submit();
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

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>

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
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cits_View.do">자율주행 AI 학습용 데이터</a>
	                                </div>
	                                <div class="lnb-item is-active">
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
	                                    <h4 class="layout-content__tit">데이터공유협의체</h4>
	                                    <ul class="location ml-auto">
	                                        <li>
	                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
	                                        <li>이용안내</li>
	                                        <li>데이터공유협의체</li>
	                                    </ul>
	                                </div>
									<div class="layout-content__view">
										<div class="el-platform el-platform--us_ce_03">
											<h5 class="el-platform__tit">주행 데이터 공유 협의체</h5>
											<div class="el-platform__txt2">
		                                        <strong>자율주행 기술</strong>을 <strong>개발</strong>하는 산·학·연 기관이 개별적으로 수집하고 있는 <strong>주행 관련 데이터</strong>를 <br>상호 공유하여 중복투자를 방지하고, 고가의 자율주행차 운영이 곤란한
    											<strong>스타트업· 중소기업</strong> 등의<strong><br> 데이터 수집 가공</strong>을 지원하여 <strong>국내 자율주행 기술 개발 가속화 지원</strong>
												<div class="btn-wrap mt-20">
<!-- 													<button id="joinDown" class="btn btn-color--navy px-30"> -->
<!-- 														<img src="/image/common/icon/icon-download--white.png" > -->
<!-- 														가입신청서 다운로드 -->
<!-- 													</button> -->
														<button type="button" class="btn btn-color--navy px-30" onclick="javascript:fn_Download('${attachFile.attachFilename}')">
															<img src="/image/common/icon/icon-download--white.png" >
															가입신청서 다운로드
                                                        </button>
												</div>
		                                    </div>
										</div>
										
										<div class="layout-content__tab mt-250">
											<div class="tab-wrap">
												<div class="tab-list d-flex">
													<div class="tab-item flex-1">
														<button class="tab-item__btn">공유 데이터</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">주요데이터</button>
													</div>
													<div class="tab-item flex-1">
														<button class="tab-item__btn">참여기관</button>
													</div>
												</div>
												
												<div id="us_ce_03--01" class="tab-cont">
													<h5 class="tab-cont__tit">공유 데이터</h5>
													<div class="el-box-group d-flex">
														<div class="el-box--border box-group-ce02--01 w-50">
															<p class="box-imgInfo__tit">
																<strong>자율주행</strong> 인지 성능 향상<strong>을 위한 딥러닝 학습 데이터</strong>
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_03--img02.jpg" style="" id="">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--02 w-50">
															<p class="box-imgInfo__tit">
																End to End<strong>딥러닝을 위한 학습 데이터</strong>
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_03--img03.jpg" style="" id="">
															</div>
														</div>
														<!-- <div class="el-box--border box-group-ce02--03 w-50">
															<p class="box-imgInfo__tit">
																<strong>자율주행</strong> 정밀 지도<strong>및</strong>도로 구조 <strong>정보</strong>
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_03--img04.jpg" style="" id="">
															</div>
														</div>
														<div class="el-box--border box-group-ce02--04 w-50">
															<p class="box-imgInfo__tit">
																<strong>자율주행</strong> 실증 사업(FOT)<strong>수집 데이터</strong>
															</p>
															<div class="el-box__img">
																<img src="/image/sub/img-us_ce_03--img05.jpg" style="" id="">
															</div>
														</div> -->
													</div>
												</div>
												
												<div id="us_ce_03--02"  class="tab-cont">
													<h5 class="tab-cont__tit">주요데이터</h5>
													<div class="p-40 el-box--border">
														<p class="box-imgInfo__tit2">
															원시데이터
														</p>
														<p class="box-imgInfo__txt">
															데이터 수집 플랫폼으로 취득한 주행 데이터
														</p>
														<div class="el-box-group d-flex">
															<div class="box-group-ce02--01 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img06.jpg" style="" id="">
																</div>
															</div>
															<div class="box-group-ce02--02 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img07.jpg" style="" id="">
																</div>
															</div>
														</div>
													</div>
													<div class="p-40 el-box--border mt-10">
														<p class="box-imgInfo__tit2">
															AI학습용 데이터
														</p>
														<p class="box-imgInfo__txt">
															주행 데이터를 AI가 학습할 수 있는 형태로 가공한 데이터
														</p>
														<div class="el-box-group d-flex">
															<div class="w-30 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img08.jpg" style="width:100%" id="">
																</div>
															</div>
															<div class="w-30 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img09.jpg" style="width:100%" id="">
																</div>
															</div>
															<div class="w-30 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img10.jpg" style="width:100%" id="">
																</div>
															</div>
														</div>
													</div>
													<div class="p-40 el-box--border mt-10">
														<p class="box-imgInfo__tit2">
															엣지케이스
														</p>
														<p class="box-imgInfo__txt">
															사고 상황, 낙하물 등 일반적이지 않은 주행환경으로 구성된 데이터
														</p>
														<div class="el-box-group d-flex">
															<div class="box-group-ce02--01 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img11.jpg" style="" id="">
																</div>
															</div>
															<div class="box-group-ce02--02 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img12.jpg" style="" id="">
																</div>
															</div>
														</div>
													</div>
													<div class="p-40 el-box--border mt-10">
														<p class="box-imgInfo__tit2">
															V2X
														</p>
														<p class="box-imgInfo__txt">
															V2I, V2V를 통해 수집한 V2X 메시지 데이터
														</p>
														<div class="el-box-group d-flex">
															<div class="box-group-ce02--01 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img13.jpg" style="" id="">
																</div>
															</div>
															<div class="box-group-ce02--02 w-50 pd-0">
																<div class="el-box__img">
																	<img src="/image/sub/img-us_ce_03--img14.jpg" style="" id="">
																</div>
															</div>
														</div>
													</div>
												</div>
												
												<div id="us_ce_03--03"  class="tab-cont ce03_pb">
													<h5 class="tab-cont__tit">참여기관</h5>
													<div class="company-list">
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img src="/image/sub/img-us_ce_03-com--01.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk02" src="/image/sub/img-us_ce_03-com--02.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item bg-color--navy">
															<span class="company-item__img el-box--border">
																<img id="lnk03" src="/image/sub/img-us_ce_03-com--03.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk04" src="/image/sub/img-us_ce_03-com--04.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk05" src="/image/sub/img-us_ce_03-com--05.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk06" src="/image/sub/img-us_ce_03-com--06.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk07" src="/image/sub/img-us_ce_03-com--07.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk08" src="/image/sub/img-us_ce_03-com--08.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk09" src="/image/sub/img-us_ce_03-com--09.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk10" src="/image/sub/img-us_ce_03-com--10.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk11" src="/image/sub/img-us_ce_03-com--11.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item bg-color-raisinBlack">
															<span class="company-item__img el-box--border">
																<img id="lnk12" src="/image/sub/img-us_ce_03-com--12.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk13" src="/image/sub/img-us_ce_03-com--13.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk14" src="/image/sub/img-us_ce_03-com--14.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk15" src="/image/sub/img-us_ce_03-com--15.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk16" src="/image/sub/img-us_ce_03-com--16.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk17" src="/image/sub/img-us_ce_03-com--17.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk18" src="/image/sub/img-us_ce_03-com--18.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk19" src="/image/sub/img-us_ce_03-com--19.jpg" style="" id="">
															</span>
														</div>
														<div class="company-item">
															<span class="company-item__img el-box--border">
																<img id="lnk20" src="/image/sub/img-us_ce_03-com--20.jpg" style="" id="">
															</span>
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
</form:form>
