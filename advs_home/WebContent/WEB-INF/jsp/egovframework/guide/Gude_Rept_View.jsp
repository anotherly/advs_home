<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/html/resource/css/lib/fullpage.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/ux-common.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/sub.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/us_ce.css"> -->
<script type="text/javaScript" language="javascript" defer="defer">
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
	});
</script>

<form:form id="listForm" name="listForm" method="post">
<div class="skip">
	<a href="#container">Go to Content</a>
</div>

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
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cons_View.do">데이터공유협의체</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Legl_View.do">법령 및 지침</a>
	                                </div>
	                                <div class="lnb-item is-active">
	                                    <a href="/center/introduce/Gude_Rept_View.do">자율주행차 임시운행허가</a>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <div class="layout-content">
                           		<div class="layout-content__inner">
                           			<div class="layout-content__top">
	                                    <h4 class="layout-content__tit">자율주행차 임시운행 허가</h4>
	                                    <ul class="location ml-auto">
	                                        <li>
	                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
	                                        <li>이용안내</li>
	                                        <li>자율주행차 임시운행허가</li>
	                                    </ul>
	                                </div>
	                                <h5 class="layout-content__subtit">자율주행차 임시운행 허가 제도</h5>
									<div class="layout-content__view">
										<div class="el-box">
											<div class="el-box__tit color-blue mb-10">법률</div>
											<div class="el-box__txt">
												자율주행차를 시험용으로 임시운행하기 위해서는 <strong>안전운행요건</strong>을 갖춰 <strong>국토부장관 허가</strong>를 받아야 함 (자동차관리법 제27조제1항,‘15.8.11개정)
											</div>
											<div class="el-box__tit color-blue mt-30 mb-10">시행령</div>
											<div class="el-box__txt">
												<strong>자율차임시운행 허가기간 확대</strong> (2년→5년), (령 제7조제4항,‘16.1.6개정)
											</div>
											<div class="el-box__tit color-blue mt-30 mb-10">시행규칙</div>
											<div class="el-box__txt">
												<strong>임시운행 허가절차 마련</strong> (규칙 제26조의2, ‘16.2.11신설)
											</div>
						
											<div class="permit-step mt-30">
												<div class="permit-list d-flex">
													<div class="permit-item">
														<div class="permit-item__img">
															<img src="/image/sub/img-us_ce_05--img01.png" alt="">
														</div>
														<div class="permit-item__txt">
															<p>
																신청자
																<span>자율주행차 <br/>임시운행 신청</span>
															</p>
														</div>
													</div>
													<div class="permit-item">
														<div class="permit-item__img">
															<img src="/image/sub/img-us_ce_05--img02.png" alt="">
														</div>
														<div class="permit-item__txt">
															<p>
																국토교통부
																<span>허가요건 <br/>확인 지시</span>
															</p>
														</div>
													</div>
													<div class="permit-item">
														<div class="permit-item__img">
															<img src="/image/sub/img-us_ce_05--img03.png" alt="">
														</div>
														<div class="permit-item__txt">
															<p>
																성능시험대행자
																<span>허가요건 <br/>확인</span>
															</p>
														</div>
													</div>
													<div class="permit-item">
														<div class="permit-item__img">
															<img src="/image/sub/img-us_ce_05--img04.png" alt="">
														</div>
														<div class="permit-item__txt">
															<p>
																국토교통부
																<span>허가증 발부 <br/>지자체 통보</span>
															</p>
														</div>
													</div>
													<div class="permit-item">
														<div class="permit-item__img">
															<img src="/image/sub/img-us_ce_05--img05.png" alt="">
														</div>
														<div class="permit-item__txt">
															<p>
																지자체
																<span>번호판 <br/>발급</span>
															</p>
														</div>
													</div>
												</div>
											</div>
											
											<div class="el-box__tit color-blue mt-30 mb-10">고시</div>
											<div class="el-box__txt">
												<strong>안전운행 요건 마련 :</strong> 보험가입, 사전시험주행, 표시·고장·속도제한장치 등 설치 요건 규정
											</div>
											<div class="el-box-capt mt-10">
												*「자율주행차의 안전운행요건 및 시험운행 등에 관한 규정」(제2016-46호, ‘16. 2.11 제정)
											</div>
										</div>
									</div>

									<div class="layout-content__subtit mt-30">
										법령별 임시운행 허가 요건
									</div>
									<div class="layout-content__view mb-80">
										<div class="table-wrap">
											<table class="table-basic table-basic--col table-us_ce_05_list" style="width:100%;">
												<colgroup>
													<col width="10%">
													<col width="22%">
													<col width="auto">
													<col width="5%">
													<col width="5%">
													<col width="5%">
													<col width="5%">
												</colgroup>
												<thead>
													<tr>
														<th rowspan="2" class="border_l_none" style="text-align:center;">구분</th>
														<th rowspan="2">항목</th>
														<th rowspan="2">기준</th>
														<th colspan="4">근거규정</th>
													</tr>
													<tr>
														<th>법</th>
														<th>영</th>
														<th>규칙</th>
														<th>고시</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td rowspan="5">허가신청</td>
														<td>허가권자</td>
														<td>
															<ul class="lists lists-dot">
																<li>국토교통부장관</li>
															</ul>
														</td>
														<td class="ta-c">○</td>
														<td></td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>허가기간</td>
														<td>
															<ul class="lists lists-dot">
																<li>자율주행차의 임시운행허가 기간은 5년 이내로 함</li>
															</ul>
														</td>
														<td></td>
														<td class="ta-c">○</td>
														<td></td>
														<td></td>
													</tr>
													<tr>
														<td>허가처리기간</td>
														<td>
															<ul class="lists lists-dot">
																<li>자율주행차의 임시운행허가 처리기간은 20일로 함</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td></td>
													</tr>
													<tr>
														<td>신청서 및 관련 자료 제출</td>
														<td>
															<ul class="lists lists-dot">
																<li>시험연구계획서</li>
																<li class="mt-10">자율주행장치의 구조 및 기능에 대한 설명서 제출</li>
																<li class="mt-10">대상 자동차 및 관련자료 제출</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>안전운행요건 적합여부 확인</td>
														<td>
															<ul class="lists lists-dot">
																<li>성능시험대행자</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td class="border_l_none">운행구역</td>
														<td>시험운행 허가구간</td>
														<td>
															<ul class="lists lists-dot">
																<li>국토교통부장관이 정하는 운행구역내에서 자율주행기능 사용 가능</li>
															</ul>
														</td>
														<td class="ta-c">○</td>
														<td></td>
														<td class="ta-c">○</td>
														<td></td>
													</tr>
													<tr>
														<td rowspan="4" class="border_l_none">일반 기준</td>
														<td>주요장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>자동차안전기준 및 공공도로 운행 관련 제반 법령 준수</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>보험가입</td>
														<td>
															<ul class="lists lists-dot">
																<li>자동차손해배상보장법에 의한 보험 가입</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>사전시험주행</td>
														<td>
															<ul class="lists lists-dot">
																<li>자율주행 기능 작동을 확인할 수 있는 충분한 사전주행 실시</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>외부식별표지부착</td>
														<td>
															<ul class="lists lists-dot">
																<li>차량 외부에 자율주행 시험운행 관련 표지 부착</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td rowspan="9" class="border_l_none">구조 및<br/> 기능</td>
														<td>모드선택</td>
														<td>
															<ul class="lists lists-dot">
																<li>자동차안전기준 및 공공도로 운행 관련 제반 법령 준수</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>표시장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>운행모드 및 정상작동 여부 표시장치 장착</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>고장감지</td>
														<td>
															<ul class="lists lists-dot">
																<li>시스템 고장이나 기능이상 자동 감지 구조일 것</li>
															</ul>
														</td>
														<td class="ta-c">○</td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>경고장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>기능고장, 운전자전환요구 등 경고(알림)장치 장착</li>
															</ul>
														</td>
														<td class="ta-c">○</td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>운전자우선모드 자동전환</td>
														<td>
															<ul class="lists lists-dot">
																<li>언제든 운전자에 의한 강제 개입 및 운전자우선모드로의 자동 전환 가능할 것</li>
															</ul>
														</td>
														<td class="ta-c">○</td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>추가 안전장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>속도제한장치, 전방충돌방지 기능 장착</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>운행기록장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>운행기록장치 장착에 의한 운행데이터 확보</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>영상기록장치</td>
														<td>
															<ul class="lists lists-dot">
																<li>사고시 원인 파악 위한 차량 내․외부 영상기록장치 장착</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>보안대책</td>
														<td>
															<ul class="lists lists-dot">
																<li>자율주행시스템에 원격으로 접근·침입하는 행위를 방지하거나 대응하기 위한 기술이 적용되어 있을 것</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
														<td></td>
													</tr>
													<tr>
														<td rowspan="2" class="border_l_none">운행기준</td>
														<td>탑승인원</td>
														<td>
															<ul class="lists lists-dot">
																<li>1인 이상 의무 탑승</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
													</tr>
													<tr>
														<td>기타</td>
														<td>
															<ul class="lists lists-dot">
																<li>피견인자동차 연결 금지</li>
															</ul>
														</td>
														<td></td>
														<td></td>
														<td></td>
														<td class="ta-c">○</td>
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
<!-- //container -->
</form:form>
