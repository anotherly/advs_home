<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script type="text/javaScript" defer>
	var c_form = "";
	$(document).ready(function() {
		c_form = document.listForm;
	});
  
	/* 예약취소 function */
	function fn_UpdateCancel() {
	    if(confirm("등록된 예약을 취소 하시겠습니까?")) {
		    c_form.action = "<c:url value='/sharing/car/Car_Reserve_Cancel_Process.do'/>";
		    c_form.submit();
	    }
	}
  
	function go_List(){
		c_form.action = "<c:url value='/sharing/car/Car_Reserve_List.do'/>";
		c_form.submit();
	}
    
    /* 파일 다운로드  */
	function fn_Download(file_nm) {
		c_form.file_nm.value = file_nm;
		c_form.dir_nm.value = "sharing";
		c_form.action = "<c:url value='/common/File_Download.do'/>";
		c_form.submit();
	}
    
	/* 보고서생성 function */
	function fn_Report() {
		if(confirm("차량 플랫폼 공유 신청서를 출력 하시겠습니까?")) {
			var oReport = GetfnParamSet();			
			var rentDayStr = $("#rentDt").val().split('-');
		    var returnDayStr = $("#returnDt").val().split('-');
			var rentDayMin = new Date(rentDayStr[0], rentDayStr[1], rentDayStr[2]); 
		    var returnDayMin = new Date(returnDayStr[0], returnDayStr[1], returnDayStr[2]);
		    var btMs = returnDayMin.getTime() - rentDayMin.getTime();
			var rentDay = btMs/(1000*60*60*24)+1;
			c_form.rentDay.value = rentDay;
	    	oReport.rptname = "Car_Reserve_Inst";
	    	oReport.param("agcy_nm").value = $("#applyCompanyCode").val();
	    	oReport.param("biz_number").value = $("#bizNumber").val();
	    	oReport.param("agency_adres").value = $("#agencyAdres").val();
	    	oReport.param("return_dt").value = $("#returnDt").val();
	    	oReport.param("rent_dt").value = $("#rentDt").val();
	    	oReport.param("rent_day").value = rentDay+"일";
	    	oReport.param("rentCarCode").value = $("#rentCarCode").val();	 	
	    	oReport.param("collect_data").value = $("#collectData").val();
	    	oReport.param("driving_schedule_place").value = $("#drivingSchedulePlace").val();
	    	oReport.param("etc").value = $("#etc").val();
	    	oReport.open();
		}
	}
</script>

<form:form id="listForm" name="listForm" method="post" >
		<input type="hidden" name="reservationNumber" id="reservationNumber" value="${carReserveInfo.reservationNumber}"/>
		<input type="hidden" name="applyCompanyCode" id="applyCompanyCode" value="${carReserveInfo.applyCompanyCode}"/>
		<input type="hidden" name="bizNumber" id="bizNumber" value="${carReserveInfo.bizNumber}"/>
		<input type="hidden" name="agencyAdres" id="agencyAdres" value="${carReserveInfo.agencyAdres}"/>
		<input type="hidden" name="rentDt" id="rentDt" value="${carReserveInfo.rentDt}"/>
		<input type="hidden" name="returnDt" id="returnDt" value="${carReserveInfo.returnDt}"/>
		<input type="hidden" name="rentDay" id="rentDay" value="${carReserveInfo.rentDay}"/>
		<input type="hidden" name="collectData" id="collectData" value="${carReserveInfo.collectData}"/>
		<input type="hidden" name="rentCarCode" id="rentCarCode" value="${carReserveInfo.rentCarCode}"/>
		<input type="hidden" name="drivingSchedulePlace" id="drivingSchedulePlace" value="${carReserveInfo.drivingSchedulePlace}"/>
		<input type="hidden" name="etc" id="etc" value="${carReserveInfo.etc}"/>
		<input type="hidden" name="dir_nm" id="dir_nm"/>
		<input type="hidden" name="file_nm" id="file_nm"/>
</form:form>
<!-- container -->
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
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_Main.do">안내</a>
	                                    </li>
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_Inst.do">예약신청</a>
	                                    </li>
	                                    <li class="is-active">
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
	                                    <li>예약신청</li>
	                                </ul>
	                            </div>
	                            <h5 class="layout-content__subtit">예약현황 및 취소</h5>
	                            <button type="button" class="btn btn-width--m btn-color--navy ml-auto d-flex align-center justify-center" onclick="javascript:fn_Report('${drv_no}','${std_dt}');">
                                    <img src="/image/common/icon/icon-file--s.png" class="mr-10" alt="">보고서 생성
                                </button>
	                            <div class="table-wrap">
	                                <table class="table-basic table-basic--row">
	                                    <caption>데이터공유센터 시설이용 &gt; 차량 플랫폼 공유 &gt; 예약신청 테이블</caption>
	                                    <colgroup>
                                            <col style="width:15%">
                                            <col style="width:auto">
                                            <col style="width:15%">
                                            <col style="width:30%">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">신청기관</th>
                                                <td>${carReserveInfo.applyCompanyCode}</td>
                                                <th scope="row">
                                                    <span class="el-caution font-s">*</span>사업자등록번호
                                                </th>
                                                <td>${carReserveInfo.bizNumber}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">기관주소</th>
                                                <td colspan="3">${carReserveInfo.agencyAdres}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">예약일시</th>
                                                <td colspan="3">${carReserveInfo.applyDate}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">대여기간 (대여일)</th>
                                                <td colspan="3">${carReserveInfo.rentDt} ~ ${carReserveInfo.returnDt}(${carReserveInfo.rentDay}일)</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">차량 정보</th>
                                                <td colspan="3">${carReserveInfo.rentCarCode}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">운행 예정 지역</th>
                                                <td colspan="3">${carReserveInfo.drivingSchedulePlace}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">수집데이터</th>
                                                <td colspan="3">${carReserveInfo.collectData}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">비고</th>
                                                <td colspan="3">${carReserveInfo.etc}</td>
                                            </tr>
                                             <tr>
                                                <th scope="row">첨부파일</th>
                                                <td>
                                                <c:choose>
													<c:when test="${carReserveInfo.attachFile ne null}">
														<a href="javascript:void(0);" title="${carReserveInfo.attachFile} 첨부파일입니다" onclick="fn_Download('${carReserveInfo.attachFile}')">
														<img src="/images/avsc/ico_file.png" alt="다운로드" class="file_icon"/><i class="font_lGray">${carReserveInfo.attachFile}</i></a>
													</c:when>
													<c:otherwise>-</c:otherwise>
												</c:choose>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                    <button type="button" class="btn btn-width--l btn-color--white" onclick="location.href='javascript:go_List();' ">목록</button>
                                    <c:if test="${carReserveInfo.reservationStatus eq 1}">
                                    	<button type="button" class="btn btn-width--l btn-color--navy" onclick="location.href='javascript:fn_UpdateCancel();' ">예약취소</button>
                                    </c:if>
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

