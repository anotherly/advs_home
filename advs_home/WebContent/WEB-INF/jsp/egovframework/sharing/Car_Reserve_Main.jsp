<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<link rel="stylesheet" href="/css/us_fa.css">

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";
  var CDate = new Date(); 
  var today = new Date();
  var selectCk = 0;
  
  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    fn_selectReserve();
    scrollFn();
    //buildcalendar();
  });
  
  String.prototype.replaceAll = function(search, replacement) {
	    var target = this;
	    return target.replace(new RegExp(search, 'g'), replacement);
	};
  
  function fn_selectReserve(){
	  $.ajax( {
          type : "POST",
          dataType : "json",
          cache: false,
          contentType:"application/x-www-form-urlencoded;charset=utf-8",
          url : "/sharing/car/Car_Reserve_SelectList.do",
          data : {},
          success : function(data) {
        	  var result = data.resultList;
        	  buildcalendar(result);
          },
          error : function(data) {
          }
        });
	  
  }
  

  function buildcalendar(dayReserve){
  	var htmlDates = ''; 
  	var htmlDays = ''; 
  	var prevLast = new Date(CDate.getFullYear(), CDate.getMonth(), 0); //지난 달의 마지막 날 
  	var thisFirst = new Date(CDate.getFullYear(), CDate.getMonth(), 1); //이번 달의 첫쨰 날
  	var thisLast = new Date(CDate.getFullYear(), CDate.getMonth() + 1, 0); //이번 달의 마지막 날
  	var dates = [];
  	var staticDay = 0;
  	$("#curYear").html(CDate.getFullYear() + "년&nbsp;&nbsp;");
  	$("#curMon").html((CDate.getMonth() + 1) + "월");
  	
  	
  	if(thisFirst.getDay()!=0){ 
  		for(var i = 0; i < thisFirst.getDay(); i++){
  			dates.unshift(prevLast.getDate()-i); // 지난 달 날짜 채우기
  		} 
  	} 
  	for(var i = 1; i <= thisLast.getDate(); i++){
  			 dates.push(i); // 이번 달 날짜 채우기 
  	} 
  	for(var i = 1; i <= (13-thisLast.getDay()); i++){
  		// 다음 달 채우기 빈칸없앰
  		if(thisFirst.getDay() < thisLast.getDay()){
  			staticDay = 35;
  		}else if(thisFirst.getDay() > thisLast.getDay()){
  			staticDay = 42;
  		}else{
  			staticDay = 35;
  		}
  		dates.push(i); // 다음 달 날짜 채우기 (나머지 다 채운 다음 출력할 때 42개만 출력함)
  	} 
  	
	htmlDates += "<div><p>일</p></div><div><p>월</p></div><div><p>화</p></div><div><p>수</p></div><div><p>목</p></div><div><p>금</p></div><div><p>토</p></div>"
	for(var i = 0; i < staticDay; i++){
		var year = CDate.getFullYear();
		var curMonth = ("0" + (1 + CDate.getMonth())).slice(-2);
  		var currentDate = (year+curMonth+("0" + dates[i]).slice(-2));
  		
  		if(i < thisFirst.getDay()){ // 지난 달 마지막 주
  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
  			htmlDates += '<div class="calendar-badge__inner">';
  			htmlDates += '</div>'; 
  			htmlDates += '</div>';
  		}else if(i >= thisFirst.getDay() + thisLast.getDate()){// 다음 달 마지막주
			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
  			htmlDates += '<div class="calendar-badge__inner">';
  			htmlDates += '</div>';
  			htmlDates += '</div>';
  		}else if(today.getDate()==dates[i] && today.getMonth()==CDate.getMonth() && today.getFullYear()==CDate.getFullYear()){ // 오늘
  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar today" ><p>'+dates[i]+'</p>';
  			htmlDates += '<div class="calendar-badge__inner">';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="sorentoP_'+("0" + dates[i]).slice(-2)+'"><span id="sorentoSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="sorentoA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'쏘렌토\');">쏘렌토</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="santafeP_'+("0" + dates[i]).slice(-2)+'"><span id="santafeSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="santafeA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'싼타페\');">싼타페</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="carnivalP_'+("0" + dates[i]).slice(-2)+'"><span id="carnivalSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="carnivalA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'카니발\');">카니발</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="genesysP_'+("0" + dates[i]).slice(-2)+'"><span id="genesysSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="genesysA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'제네시스G80\');">제네시스G80</a></p>';
  			htmlDates += '</div>'; 
  			htmlDates += '</div>'; 
  		}else	{
  			htmlDates += '<div id="date_'+("0" + dates[i]).slice(-2)+'" class="dates linkCalendar" ><p>'+dates[i]+'</p>';
  			htmlDates += '<div class="calendar-badge__inner">';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="sorentoP_'+("0" + dates[i]).slice(-2)+'"><span id="sorentoSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="sorentoA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'쏘렌토\');">쏘렌토</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="santafeP_'+("0" + dates[i]).slice(-2)+'"><span id="santafeSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="santafeA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'싼타페\');">싼타페</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="carnivalP_'+("0" + dates[i]).slice(-2)+'"><span id="carnivalSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="carnivalA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'카니발\');">카니발</a></p>';
  			htmlDates += '<p class="calendar-badge__list calendar-badge__list--deepblue" id="genesysP_'+("0" + dates[i]).slice(-2)+'"><span id="genesysSpan_'+("0" + dates[i]).slice(-2)+'">예</span><a id="genesysA_'+("0" + dates[i]).slice(-2)+'" href="javascript:fn_carReserveInsert(\''+currentDate+'\', \'제네시스G80\');">제네시스G80</a></p>';
  			htmlDates += '</div>'; 
  			htmlDates += '</div>'; 
  		}
	}
	$("#cal30").html(htmlDates);
	
	if(dayReserve.length > 0){
		for(var j=0; j<dayReserve.length; j++){
			var dateArr  = fn_dateStartToLast(dayReserve[j].rentDt, dayReserve[j].returnDt);
			 for(var dd=0; dd<dateArr.length; dd++){
	 			var redClass='calendar-badge__list calendar-badge__list--red';
	 			var day = dateArr[dd].split('-');
				var currentDate = (year+curMonth+day[2]);
				dateArr[dd]= replaceAll(dateArr[dd], '-', '');
				
				if(currentDate === dateArr[dd]){
	 				if((dayReserve[j].rentCarCode == "쏘렌토") && (dayReserve[j].reservationStatus==1 || dayReserve[j].reservationStatus==2)){
	 					$('span#sorentoSpan_'+day[2]).text("불");		  						
						$('p#sorentoP_'+day[2]).attr('class', redClass);		  						
						$('a#sorentoA_'+day[2]).prop('href', 'javascript:detail_View('+dayReserve[j].reservationNumber+');');
					}
					if((dayReserve[j].rentCarCode == "싼타페") && (dayReserve[j].reservationStatus==1 || dayReserve[j].reservationStatus==2)){
						$('span#santafeSpan_'+day[2]).text("불");		  						
						$('p#santafeP_'+day[2]).attr('class', redClass);		  						
						$('a#santafeA_'+day[2]).prop('href', 'javascript:detail_View('+dayReserve[j].reservationNumber+');');
					}
					if((dayReserve[j].rentCarCode == "카니발") && (dayReserve[j].reservationStatus==1 || dayReserve[j].reservationStatus==2)){
						$('span#carnivalSpan_'+day[2]).text("불");		  						
						$('p#carnivalP_'+day[2]).attr('class', redClass);		  						
						$('a#carnivalA_'+day[2]).prop('href', 'javascript:detail_View('+dayReserve[j].reservationNumber+');');
					}
					if((dayReserve[j].rentCarCode == "제네시스G80") && (dayReserve[j].reservationStatus==1 || dayReserve[j].reservationStatus==2)){
						$('span#genesysSpan_'+day[2]).text("불");		  						
						$('p#genesysP_'+day[2]).attr('class', redClass);		  						
						$('a#genesysA_'+day[2]).prop('href', 'javascript:detail_View('+dayReserve[j].reservationNumber+');');
					}
					
				}
				
			}
		}
	}
    
  } 
  
  function replaceAll(str, searchStr, replaceStr) {
		if(str != null && typeof str == 'string') {
			while(str.indexOf(searchStr) != -1) {
				str = str.replace(searchStr, replaceStr);
			}
		}
	    return str;
	} 
  
  function prevCal(){
  	 CDate.setMonth(CDate.getMonth()-1); 
  	fn_selectReserve(); 
  } 
  function nextCal(){
  	 CDate.setMonth(CDate.getMonth()+1);
  	fn_selectReserve(); 
  }
  
  function fn_dateStartToLast(startDate, lastDate){
	  var resultDate= [];
	  var curDate = new Date(startDate);
	  while(curDate <= new Date(lastDate)){
		  resultDate.push(curDate.toISOString().split("T")[0]);
		  curDate.setDate(curDate.getDate()+1);
	  }
	  return resultDate;
  }

  /* 상세 화면 function */
	function detail_View(reservationNumber) {
    c_form.reservationNumber.value = reservationNumber;
    c_form.action = "<c:url value='/sharing/car/Car_Reserve_View.do'/>";
    c_form.submit();
	}

	/* 목록 화면 function */
	function form_Submit() {
		if(trim(c_form.searchWord.value).length > 0){
			var sel = $("#searchType option:selected").val();
			if(sel == 0) {
				alert("검색대상을 선택해주세요");
				c_form.searchType.focus();
				return;
			} else {
				if(trim(c_form.searchWord.value).length==0){
					alert("검색어를 입력해주세요");
					c_form.searchWord.value="";
					c_form.searchWord.focus();
					return;
				}
				c_form.action = "<c:url value='/sharing/car/Car_Reserve_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "trnd";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/sharing/car/Car_Reserve_List.do'/>";
		c_form.submit();
	}
  
	
	  /* 등록 화면 function */
	function fn_carReserveInsert(currentDate, carCode) {
		var date =today.getFullYear()+("0" + (1 + today.getMonth())).slice(-2) +("0" + (today.getDate())).slice(-2);
		if(currentDate <= date){
			alert("예약할 수 없는 날짜입니다.");
			return 0;
		}else{
			c_form.selectDay.value = currentDate;
			c_form.carCode.value = carCode;
		    c_form.action = "<c:url value='/sharing/car/Car_Reserve_Inst.do'/>";
		    c_form.submit();
		}
	}
	  
	function fn_none(){
		alert("예약할 수 없는 날짜입니다.");
		return 0;
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
<%-- <input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" /> --%>
<!-- <input type="hidden" name="blbd_div_cd" id="blbd_div_cd"/> -->
<!-- <input type="hidden" name="bdwr_seq" id="bdwr_seq"/> -->
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="selectDay" id="selectDay"/>
<input type="hidden" name="carCode" id="carCode"/>
<input type="hidden" name="reservationNumber" id="reservationNumber"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<div class="container">
	<div class="container__inner">
	    <div class="content">
	        <div class="content__inner">
	            <div class="layout-container layout-full">
	                <div class="layout-container__inner layout-container--row">
	                    <div class="lnb">
	                        <h3 class="lnb__tit">데이터공유센터<br/>시설이용</h3>
	                        <div class="lnb-list">
	                            <div class="lnb-item is-active is-open">
	                                <a href="">차량 플랫폼 공유</a>
	                                <ul class="lnb-depth--02 lists lists-cir--s">
	                                    <li class="is-active">
	                                        <a href="/sharing/car/Car_Reserve_Main.do">안내</a>
	                                    </li>
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_Inst.do">예약신청</a>
	                                    </li>
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_List.do">예약현황 및 취소</a>
	                                    </li>
	                                </ul>
	                            </div>
	                            <div class="lnb-item">
	                                <a href="">공유센터 이용안내</a>
	                                <ul class="lnb-depth--02 lists lists-cir--s">
	                                    <li class="is-active">
	                                        <a href="/center/fact/Center_Fact_Main.do">회의실 안내</a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="layout-content">
	                        <div class="layout-content__inner">
	                            <div class="layout-content__top">
	                                <h4 class="layout-content__tit">차량 플랫폼 공유</h4>
	                                <ul class="location ml-auto">
	                                    <li>
	                                        <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                    </li>
	                                    <li>데이터공유센터 시설이용</li>
	                                    <li>차량 플랫폼 공유</li>
	                                    <li>안내</li>
	                                </ul>
	                            </div>
	                            <h5 class="layout-content__subtit">안내</h5>
	                            <div class="layout-content__view">
	                                <div class="el-platform">
	                                    <h5 class="el-platform__tit">차량 플랫폼 공유</h5>
	                                    <div class="el-platform__txt">
                                            <div class="el-platform__txt2">
	                                    주행데이터 수집을 위한 자율주행 데이터 수집 플랫폼 대여를 지원하고 있습니다.
	                                    	</div>
	                                    </div>
	                                </div>
	                                <!-- 탭 -->
	                                <div class="layout-content__tab mt-180">
										<div class="tab-wrap">
											<div class="tab-list d-flex">
												<div class="tab-item flex-1">
													<button class="tab-item__btn">예약 현황</button>
												</div>
												<div class="tab-item flex-1">
													<button class="tab-item__btn">데이터수집 플랫폼 상세정보</button>
												</div>
											</div>
											<div id="us_ce_02--01" class="tab-cont">
			                                <div class="calendar-wrap mb-80">
			                                	<h5 class="tab-cont__tit">예약 현황</h5>
			                                    <div class="calWrap mt_20">
			                                        <div class="controlDate">
			                                            <button type="button" class="datePrev" title="이전달로 이동" onclick="prevCal();">
			                                                <img src="/image/sub/icon/icon-calendar__prev.jpg" alt="이전달">
			                                            </button>
		<!-- 	                                            <span class="year_mon" id="curYear"></span> -->
		<!-- 	                                            <span class="year_mon" id="curMon"></span> -->
														<div class="">
															<span class="year_mon" id="curYear"></span>
			                                            	<span class="year_mon" id="curMon"></span>
														</div>
			                                            <button type="button" class="dateNext" title="다음달로 이동">
			                                                <img src="/image/sub/icon/icon-calendar__next.jpg" alt="다음달" onclick="nextCal();">
			                                            </button>
			                                        </div>
			                                        <div class="calendar-info">
			                                            <div class="calendar-info__inner">
			                                                <!-- <p class="res-status">예약현황: 총 <span class="totRecodeCnt" id="totCnt"></span></p> -->
			                                                <div class="calendar-badge">
			                                                    <div class="calendar-badge__inner2">
		                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span>예약가능</p>
		                                                            <p class="calendar-badge__list calendar-badge__list--red ml_15"><span>불</span>예약불가</p>
		                                                        </div>
			                                                </div>
			                                            </div>
		 	                                        </div>
													<div class="calendarSt mt_30 forIE" id="cal30"></div>
		 	                                    </div>
			                                   <p class="mt-10 font-16 color--555">
			                                       	※ 당일 신청불가, 명일부터 최대 14일 (<span class="m-1 px-2 py-1 bg--deepblue color--white border-radius--3 font-xs">예</span>)차종을 클릭하시면 예약신청 페이지로 이동합니다.
			                                   </p>
		 	                                </div>
		 	                            </div>
	                            	</div>
                            		<div id="us_ce_02--02"  class="tab-cont">
                            		<h5 class="tab-cont__tit">데이터 수집 플랫폼 상세정보</h5>
	                                <div class="el-platform__des">
	                                    <div class="d-flex">
	                                        <div class="el-platform__des__imgWrap">
	                                            <div class="el-platform__des__img">
	                                                <img src="/image/sub/img-us_fa_01--img02.png" alt="">
	                                            </div>
	                                            <div class="el-platform__des__imgBtn">
	                                                <button type="button" class=" js-popup" data-id="pop-view--zoomOvew">
	                                                    <img src="/image/sub/icon/icon-us_fa--sch.png" alt="">크게보기
	                                                </button>
	                                            </div>
	                                            <ul class="el-platform__des__imgCapt">
	                                                <li class="des__imgCapt--item01">
	                                                    <em></em>
	                                                    레이더 X 5
	                                                </li>
	                                                <li class="des__imgCapt--item02">
	                                                    <em></em>
	                                                    라이더 X 2
	                                                </li>
	                                                <li class="des__imgCapt--item03">
	                                                    <img src="/image/sub/icon/icon-us_fa--capt03.png" alt="">
	                                                    카메라 X 4
	                                                </li>
	                                                <li class="des__imgCapt--item04">
	                                                    <em></em>
	                                                    GNSS X 2
	                                                </li>
	                                                <li class="des__imgCapt--item05">
	                                                    <em></em>
	                                                    IMU X 1
	                                                </li>
	                                                <li class="des__imgCapt--item06">
	                                                    <em></em>
	                                                    360카메라 x 1
	                                                </li>
	                                                <li class="des__imgCapt--item07">
	                                                    <em></em>
	                                                    360라이더 x 1
	                                                </li>
	                                            </ul>
	                                        </div>
	                                        <div class="table-wrap">
	                                            <table class="table-basic table-basic--col table-us_fa_01_list">
	                                                <caption>데이터공유센터 시설이용 - 차량 플랫폼 공유 테이블</caption>
	                                                <colgroup>
	                                                    <col style="width:25%">
	                                                    <col style="width:30%">
	                                                    <col style="width:auto">
	                                                </colgroup>
	                                                <thead>
	                                                    <tr>
	                                                        <th scope="col">구분</th>
	                                                        <th scope="col">센서명</th>
	                                                        <th scope="col">상세내용</th>
	                                                    </tr>
	                                                </thead>
	                                                <tbody>
	                                                    <tr>
	                                                        <td rowspan="2">3D객체인식장비</td>
	                                                        <td>루프라이다</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>64ch/128ch(차종별 상이)</li>
	                                                                <li>Range : 120m</li>
	                                                                <li>FOV +22.5° ~ –22.5° (수평)/ 360°(수직)</li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>카메라</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>FHD(1920*1024)</li>
	                                                                <li>30fps </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>V2X수집장비 </td>
	                                                        <td>V2X데이터 수집장비 </td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>WAVE, LTE 기반</li>
	                                                                <li>차대차, 인프라간 실시간 데이터 송수신</li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td colspan="2">전/후방 라이다</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>16 ch </li>
	                                                                <li>Range : 100m </li>
	                                                                <li>FOV +15.0° ~ -15.0°(수평) / 360°(수직) </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td colspan="2">GNSS / INS</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>듀얼안테나 </li>
	                                                                <li>시간 정확도 : 20ns RMS </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td rowspan="2">카메라</td>
	                                                        <td>전측후방 카메라</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>FULL HD(1920*1024)  </li>
	                                                                <li>30fps </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>전방 사물 인식 카메라</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>차간 거리, 상대속도 측정, 전방충돌 경고 </li>
	                                                                <li>차선이탈 경고 및 속도표지판 감지 </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td rowspan="2">레이더</td>
	                                                        <td>전방 레이더 </td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>Range : 160m경고 </li>
	                                                                <li>FOV : ±30°경고 </li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                    <tr>
	                                                        <td>전좌우측방/후좌우측방</td>
	                                                        <td>
	                                                            <ul class="lists lists-cir--s">
	                                                                <li>Range : 50m경고</li>
	                                                                <li>FOV : ±60°경고</li>
	                                                            </ul>
	                                                        </td>
	                                                    </tr>
	                                                </tbody>
	                                            </table>
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
	
	<!-- popup content -->
	<div class="popup-wrap" id="pop-view--zoomOvew">
		<div class="popup" style="width:932px;">
			<div class="popup__inner">
			    <div class="popup-header">
			        <div class="d-flex">
			            <span class="popup-logo__img">
			                <img src="/image/sub/icon/img-popup__logo.png" alt="TS">
			            </span>
			            <h6>크게보기</h6>
			            <button type="button" class="popup-close" title="팝업 닫기">
			                <img src="/image/sub/icon/icon-popup__close.png" alt="">
			            </button>
			        </div>
			    </div>
			    <div class="popup-cont">
			        <div class="popup-cont__inner">
			            <div class="popup-imgWrap p-30" style="border-bottom:1px solid #b6b7b8;">
		                    <span class="popup-img"><img src="/image/sub/img-us_fa_01--img03.jpg" alt=""></span>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	<div class="popup-overlay"></div>
</div>
</form:form>
