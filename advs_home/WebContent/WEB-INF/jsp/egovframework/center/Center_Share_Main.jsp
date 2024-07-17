<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
//String user_id = (String)session.getAttribute("user_id");
//String agcy_nm = (String)session.getAttribute("agcy_nm");
//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
	var G_UploadID;
	var G_vertical = '\u000B'; // 파일 구분자
	var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
	
	function addAllFiles(uploadID) {
		<c:forEach var="list" items="${videoList}" varStatus="status">
			RAONKUPLOAD.AddUploadedFile('${list.seq}', '${list.drivingVideoFile}', '/incd/${list.drivingVideoFile}', '${list.fileSize}', 'Custom Value', uploadID);			
		</c:forEach>   
	}
	
	// 생성완료 이벤트
    function RAONKUPLOAD_CreationComplete(uploadID) {
		G_UploadID = uploadID;
		addAllFiles(G_UploadID);
	}
</script>
<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
	});
	
	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	}
	
	 /* 등록 화면 function */
	function fn_Add_View() {
    c_form.action = "<c:url value='/agency/off/Agcy_Off_Inst.do'/>";
    c_form.submit();
	}
	
</script>

<form:form id="listForm" name="listForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
	<input type="hidden" name="file_nm" id="file_nm" />
	<input type="hidden" name="dir_nm" id="dir_nm" />

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
                                            <li>
                                                <a href="/center/share/Center_Share_Main.do">안내</a>
                                            </li>
                                            <li>
                                                <a href="/center/share/Center_Share_Inst.do">예약신청</a>
                                            </li>
                                            <li>
                                                <a href="/center/share/Center_Share_List.do">예약현황 및 취소</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="lnb-item">
                                        <a href="">공유센터 이용안내</a>
                                        <ul class="lnb-depth--02 lists lists-cir--s">
                                            <li>
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
                                            <!-- <div class="el-platform__txt">
                                                <strong>차량 플랫폼 공유</strong>에 관한 설명이 노출됩니다. <strong>차량 플랫폼
                                                    공유</strong>에 관한 설명이 노출됩니다.<br />
                                                <strong>차량 플랫폼 공유</strong>에 관한 설명이 노출됩니다. <strong>차량 플랫폼
                                                    공유</strong>에 관한 설명이 노출됩니다.
                                            </div> -->
                                        </div>
                                        <div class="el-platform__des">
                                            <div class="d-flex">
                                                <div class="el-platform__des__imgWrap">
                                                    <div class="el-platform__des__img">
                                                        <img src="/image/sub/images/img-us_fa_01--img02.png" alt="">
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


                                        <div class="calendar-wrap mb-80">
                                            <div class="calWrap mt_20">
                                                
                                                <div class="controlDate">
                                                    <button type="button" class="datePrev" title="이전달로 이동">
                                                        <img src="/image/sub/icon/icon-calendar__prev.jpg"
                                                            alt="">
                                                    </button>
                                                    <span class="year_mon">2023년 1월</span>
                                                    <button type="button" class="dateNext" title="다음달로 이동">
                                                        <img src="/image/sub/icon/icon-calendar__next.jpg"
                                                            alt="">
                                                    </button>
                                                </div>
                                                <div class="calendar-info">
                                                    <div class="calendar-info__inner">
                                                        <p class="res-status">예약현황: 총 <span class="totRecodeCnt">4</span>건</p>
                                                        <div class="calendar-badge">
                                                            <div class="calendar-badge__inner">
                                                                <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span>예약가능</p>
                                                                <p class="calendar-badge__list calendar-badge__list--red"><span>완</span>예약완료</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="calendarSt mt_30 forIE">
                                                    <div>
                                                        <p>일</p>
                                                    </div>
                                                    <div>
                                                        <p>월</p>
                                                    </div>
                                                    <div>
                                                        <p>화</p>
                                                    </div>
                                                    <div>
                                                        <p>수</p>
                                                    </div>
                                                    <div>
                                                        <p>목</p>
                                                    </div>
                                                    <div>
                                                        <p>금</p>
                                                    </div>
                                                    <div>
                                                        <p>토</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>1</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>2</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>3</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-003</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-004</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--red"><span>완</span>ADVS-005</p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>4</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-003</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-004</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--red"><span>완</span>ADVS-005</p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>5</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-003</a></p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>6</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>7</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>8</p>
                                                    </div>
                                                    <div class="dates linkCalendar today">
                                                        <p>9</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>10</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>11</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>12</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>13</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>14</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>15</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>16</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>17</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>18</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-003</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-004</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--red"><span>완</span>ADVS-005</p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>19</p>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-001</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-002</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--deepblue"><span>예</span><a href="">ADVS-003</a></p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--red"><span>예</span>ADVS-004</p>
                                                        </div>
                                                        <div class="calendar-badge__inner">
                                                            <p class="calendar-badge__list calendar-badge__list--red"><span>완</span>ADVS-005</p>
                                                        </div>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>20</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>21</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>22</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>23</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>24</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>25</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>26</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>27</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>28</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>29</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>30</p>
                                                    </div>
                                                    <div class="dates linkCalendar">
                                                        <p>31</p>
                                                    </div>
                                                    <div class="nextMonth linkCalendar">
                                                        <p>1</p>
                                                        <div></div>
                                                    </div>
                                                    <div class="nextMonth linkCalendar">
                                                        <p>2</p>
                                                        <div></div>
                                                    </div>
                                                    <div class="nextMonth linkCalendar">
                                                        <p>3</p>
                                                        <div></div>
                                                    </div>
                                                    <div class="nextMonth linkCalendar">
                                                        <p>4</p>
                                                        <div></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <p class="mt-10 font-16 color--555">
                                                *원하시는 날짜의 예약가능 (<span class="m-1 px-2 py-1 bg--deepblue color--white border-radius--3 font-xs">예</span>)차종을 클릭하시면 예약신청 페이지로 이동합니다.
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
                                <span class="popup-img"><img src="/image/sub/images/img-us_fa_01--img03.jpg" alt=""></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	<!--  contWrap -->
	</div>
<!-- //container -->
</form:form>

<form id="excelForm" name="excelForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
</form>
</div>
<div class="popup-overlay"></div>