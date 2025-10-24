<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/commonFunction.js"></script>

<!-- datetimepicker3 - custom -->
<script type="text/javascript" src="/js/lib/moment.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.min.js"></script>

<link rel="stylesheet" href="/css/lib/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/css/lib/bootstrap.min.css">
<link rel="stylesheet" href="/css/ux-common.css">

<!-- end of custom -->

<!-- 공통 script 함수를 정의 -->

<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅  
	});

	/* 등록 function */
	function fn_Save(no, dt) {
		console.log(" 저장버튼 콘솔");
		//alert("저장버튼 얼러트");
		var chngLeng = $("#listLength").children().length;
		c_form.chngLeng.value = chngLeng;
		if (confirm("월별제어권 전환횟수와 제어권 전환 정보 건수가 동일하지 않으면\n제어권 전환 정보는 수정되지 않습니다. \n그래도 수정하시겠습니까?")) {
			c_form.drv_no.value = no;
			c_form.std_dt.value = dt;

			/* if(trim(c_form.total_driving_dist.value).length==0){
						alert("총 주행거리를 입력해주세요");
						c_form.total_driving_dist.value="";
						c_form.total_driving_dist.focus();
						return;
					} */

			/* if(trim(c_form.auto_driving_dist.value).length==0){
						alert("자율모드 주행거리를 입력해주세요");
						c_form.auto_driving_dist.value="";
						c_form.auto_driving_dist.focus();
						return;
					} */

			if (trim(c_form.nomal_driving_dist.value).length == 0) {
				alert("일반모드 주행거리를 입력해주세요");
				c_form.nomal_driving_dist.value = "";
				c_form.nomal_driving_dist.focus();
				return;
			}

			/*
			if(eval(c_form.auto_driving_dist.value)+eval(c_form.nomal_driving_dist.value) != eval(c_form.total_driving_dist.value)) {
			  alert("자율모드와 일반모드 주행거리의 합계와 총 주행거리의 값이 틀립니다");
						c_form.total_driving_dist.value="";
						c_form.total_driving_dist.focus();
						return;
			}
			 */

			if (trim(c_form.dist_1.value).length == 0
					|| trim(c_form.dist_2.value).length == 0
					|| trim(c_form.dist_3.value).length == 0
					|| trim(c_form.dist_4.value).length == 0
					|| trim(c_form.dist_5.value).length == 0
					|| trim(c_form.dist_6.value).length == 0) {
				alert("월별 자율모드 주행거리를 모두 입력해주세요");
				c_form.dist_1.focus();
				return;
			}

			if (trim(c_form.chng_1.value).length == 0
					|| trim(c_form.chng_2.value).length == 0
					|| trim(c_form.chng_3.value).length == 0
					|| trim(c_form.chng_4.value).length == 0
					|| trim(c_form.chng_5.value).length == 0
					|| trim(c_form.chng_6.value).length == 0) {
				alert("월별 제어권 전환횟수를 모두 입력해주세요");
				c_form.chng_1.focus();
				return;
			}

			//전환일 체크
			/* var ch_cnt = document.getElementsByName("chg_date_d").length;
			for(var i=0; i<ch_cnt; i++) {
			  if(document.getElementsByName("chg_date_d")[i].value == "") {
			    alert("전환일이 입력 안된 데이터는 등록이 되지 않습니다");
						//document.getElementsByName("chg_date_d")[i].focus();
						break;
			  }
			} */

			//제어권 전환 횟수
			/* if(c_form.chng_s.value != 0 && rowcnt != c_form.chng_s.value){
			  if(!confirm("월별제어권 전환횟수와 제어권 전환정보 입력 건수가 동일하지 않습니다. 그래도 등록 하시겠습니까?")) {
			    c_form.chng_1.focus();
			    return;
			  }
					} */

			document.listForm.action = "<c:url value='/duty/driving/Duty_Drvg_Updt_Process.do'/>";
			document.listForm.submit();
		}
	}

	//거리자동계산
	function dist_cal() {
		var dist_1 = intCheck(c_form.dist_1.value);
		var dist_2 = intCheck(c_form.dist_2.value);
		var dist_3 = intCheck(c_form.dist_3.value);
		var dist_4 = intCheck(c_form.dist_4.value);
		var dist_5 = intCheck(c_form.dist_5.value);
		var dist_6 = intCheck(c_form.dist_6.value);
		c_form.dist_s.value = dist_1 + dist_2 + dist_3 + dist_4 + dist_5
				+ dist_6;
		c_form.auto_driving_dist.value = c_form.dist_s.value;
		c_form.total_driving_dist.value = c_form.auto_driving_dist.value;
		if (c_form.nomal_driving_dist.value != null) {
			nomal_cal();
		}
	}

	//일반모드 + 자율주행으로 총 주행거리 자동계산
	function nomal_cal() {
		var nomal = intCheck(c_form.nomal_driving_dist.value);
		c_form.total_driving_dist.value = intCheck(c_form.auto_driving_dist.value)
				+ nomal;
	}

	//제어권자동계산
	function chng_cal() {
		var chng_1 = intCheck(c_form.chng_1.value);
		var chng_2 = intCheck(c_form.chng_2.value);
		var chng_3 = intCheck(c_form.chng_3.value);
		var chng_4 = intCheck(c_form.chng_4.value);
		var chng_5 = intCheck(c_form.chng_5.value);
		var chng_6 = intCheck(c_form.chng_6.value);
		c_form.chng_s.value = chng_1 + chng_2 + chng_3 + chng_4 + chng_5
				+ chng_6;
	}

	function fn_excelTempDown() {
		document.location.href = '/excelTemplate/제어권전환정보_양식.xlsx';
	}

	/* function fn_excelDown(type){
	 if(type != undefined){
	 $('$downType').val(type);		
	 }
	 $('#listType').val('EXCEL');
	 $('#listForm').attr('target', 'com_excel_frame');
	 $("#formId").attr("action", "<c:url value='/duty/driving/Duty_Drvg_ExcelDown.do'/>");
	 $('#frm').submit();
	 } */

	function fn_List() {
		location.href = "/duty/driving/Duty_Drvg_List.do";
	}
</script>

<form:form id="listForm" name="listForm" method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="tmp_race_number" id="tmp_race_number" />
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="std_dt" id="std_dt" />
	<input type="hidden" id="excelType" name="excelType" />
	<input type="hidden" id="chngLeng" name="chngLeng" />
	<div class="skip">
		<a href="#container">Go to Content</a>
	</div>
	<!-- container -->
	<div class="container">
		<div class="container__inner">
			<div class="content">
				<div class="content__inner">
					<div class="layout-container layout-full">
						<div class="layout-container__inner layout-container--row">
							<div class="lnb">
								<h3 class="lnb__tit">운행정보보고</h3>
								<div class="lnb-list">
									<div class="lnb-item">
										<a href="/duty/incident/Duty_Incd_List.do">교통사고</a>
									</div>
									<div class="lnb-item is-active">
										<a href="/duty/driving/Duty_Drvg_List.do">운행정보보고서</a>
									</div>
									<div class="lnb-item">
										<a href="/duty/device/Duty_Devc_List.do">장치 및 기능변경</a>
									</div>
								</div>
							</div>
							<div class="layout-content">
								<div class="layout-content__inner">
									<div class="layout-content__top">
										<h4 class="layout-content__tit">운행정보보고서</h4>
										<ul class="location ml-auto">
											<li><img src="/image/sub/icon/icon-home.png" alt="홈">
											</li>
											<li>운행정보보고</li>
											<li>운행정보보고서</li>
										</ul>
									</div>
									<h5 class="layout-content__subtit d-flex">운행정보보고서 수정</h5>
									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 등록 테이블</caption>
											<colgroup>
												<col style="width: 18%">
												<col style="width: auto">
												<col style="width: 18%">
												<col style="width: 34%">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">임시운행등록번호</th>
													<td>${drvgInfo.tmpRaceNumber}</td>
													<!-- ldk-custom -->
													<th scope="row">보험가입일자</th>
													<td>
														<div class="ui-form ui-form-row align-center js-datepicker-range">
															<div class="ui-form-block">
																<input type="text"
																	class="ui-input ui-form-width--140 js-datepicker"
																	id="ins_init_date" name="ins_init_date" value="${drvgInfo.insInitDateView}">
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<th scope="row">임시운행기관</th>
													<td colspan="3">${drvgInfo.tmpRaceAgency}</td>

												</tr>
												<tr>
													<th scope="row">기준일자</th>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">${drvgInfo.stndDtView}</div>
														</div>
													</td>
													<th scope="row">총 주행거리</th>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	id="total_driving_dist" name="total_driving_dist"
																	title="총 주행거리 입력" value="${drvgInfo.totalDrivingDist}"
																	readonly="" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
										<table
											class="table-basic table-basic--row mt-20 table-us_du_02_write--04">
											<caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 등록 테이블</caption>
											<colgroup>
												<col style="width: 18%">
												<col style="width: 12%">
												<col style="width: auto">
												<col style="width: 18%">
												<col style="width: 12%">
												<col style="width: auto">
											</colgroup>
											<tbody>
												<c:set var="drv_sum" value="0" />
												<c:set var="chg_sum" value="0" />
												<c:forEach var="drvList" items="${drvList}"
													varStatus="drvStatus">
													<c:choose>
														<c:when test="${drvStatus.index eq 0}">
															<tr>
																<th rowspan="7" class="border_l_none">월별 자율모드 주행거리</th>
																<td>${drvList.drivingDistMonView}</td>
																<input type="hidden" name="dist_mon_${drvStatus.count}"
																	id="dist_mon_${drvStatus.count}"
																	value="${drvList.drivingDistMon}" />
																<td><input type="text"
																	class="ui-input ui-form-width--100"
																	id="dist_${drvStatus.count}"
																	name="dist_${drvStatus.count}" maxlength="7"
																	style="ime-mode: disabled;"
																	value="${drvList.autoDrivingDist}"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();"> Km</td>
																<c:set var="drv_sum"
																	value="${drv_sum + drvList.autoDrivingDist}" />
																<th rowspan="7">월별 제어권 전환횟수</th>
																<c:forEach var="chgList" items="${chgList}"
																	varStatus="chgStatus">
																	<c:if test="${chgStatus.index eq drvStatus.index}">
																		<td>${chgList.ctrChangeMonView}</td>
																		<input type="hidden"
																			name="chng_mon_${chgStatus.count}"
																			id="chng_mon_${chgStatus.count}"
																			value="${chgList.ctrChangeMon}" />
																		<td><input type="text"
																			class="ui-input ui-form-width--100"
																			id="chng_${chgStatus.count}"
																			name="chng_${chgStatus.count}" maxlength="7"
																			style="ime-mode: disabled;"
																			value="${chgList.ctrChangeCnt}"
																			onkeypress="return numbersonly(event, false, this, 7)"
																			onkeyup="Javascript:chng_cal();"> 건</td>
																		<c:set var="chg_sum"
																			value="${chg_sum + chgList.ctrChangeCnt}" />
																	</c:if>
																</c:forEach>
															</tr>
														</c:when>
														<c:otherwise>
															<tr>
																<td>${drvList.drivingDistMonView}</td>
																<input type="hidden" name="dist_mon_${drvStatus.count}"
																	id="dist_mon_${drvStatus.count}"
																	value="${drvList.drivingDistMon}" />
																<td><input type="text"
																	class="ui-input ui-form-width--100"
																	id="dist_${drvStatus.count}"
																	name="dist_${drvStatus.count}" maxlength="7"
																	style="ime-mode: disabled;"
																	value="${drvList.autoDrivingDist}"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();"> Km</td>
																<c:set var="drv_sum"
																	value="${drv_sum + drvList.autoDrivingDist}" />
																<c:forEach var="chgList" items="${chgList}"
																	varStatus="chgStatus">
																	<c:if test="${chgStatus.index eq drvStatus.index}">
																		<td>${chgList.ctrChangeMonView}</td>
																		<input type="hidden"
																			name="chng_mon_${drvStatus.count}"
																			id="chng_mon_${drvStatus.count}"
																			value="${chgList.ctrChangeMon}" />
																		<td><input type="text"
																			class="ui-input ui-form-width--100"
																			id="chng_${chgStatus.count}"
																			name="chng_${chgStatus.count}" maxlength="7"
																			style="ime-mode: disabled;"
																			value="${chgList.ctrChangeCnt}"
																			onkeypress="return numbersonly(event, false, this, 7)"
																			onkeyup="Javascript:chng_cal();" /> 건</td>
																		<c:set var="chg_sum"
																			value="${chg_sum + chgList.ctrChangeCnt}" />
																	</c:if>
																</c:forEach>
															</tr>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												<tr>
													<td>합계</td>
													<td><input type="text" readonly=""
														class="ui-input ui-form-width--100" id="dist_s"
														name="dist_s" value="${drv_sum}" placeholder="자동계산입력" />
														Km</td>
													<td>합계</td>
													<td><input type="text" readonly=""
														class="ui-input ui-form-width--100" id="chng_s"
														name="chng_s" value="${chg_sum}" placeholder="자동계산입력" />
														건</td>
												</tr>
												<tr>
													<th scope="row">자율모드 주행거리</th>
													<td colspan="2">
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	readonly="" id="auto_driving_dist"
																	name="auto_driving_dist" maxlength="7"
																	style="ime-mode: disabled;"
																	value="${drvgInfo.autoDrivingDist}"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	title="자율모드 주행거리 입력" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<th scope="row">일반모드 주행거리</th>
													<td colspan="2">
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	id="nomal_driving_dist" name="nomal_driving_dist"
																	maxlength="7" style="ime-mode: disabled;"
																	value="${drvgInfo.nomalDrivingDist}"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:nomal_cal();">
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
										<div class="ui-form-block el-essential ml-10">
											<p class="el-essential font-s">※ 해당 반기의 데이터만 넣어주시기 바랍니다.</p>
										</div>
									</div>
									<h5 class="layout-content__subtit">제어권 전환 정보</h5>
									<div class="el-box el-box--gray el-box--border mt-20">
										<p class="el-essential font-s">※ 다운로드 한 양식의 파일명을 임의로 변경하여
											업로드 할 경우 오류가 발생할 수 있습니다.</p>
										<br>
										<p class="el-essential font-s">※ 엑셀 파일에서 기존 예시를 복사하여 신규 추가해주시고 업로드 하시기 전 최초 예시 3줄은 행 삭제해주시기 바랍니다.</p>
										<table
											class="table-basic table-basic--row mt-20 table-us_du_02_write--05">
											<caption>운행정보보고 &gt; 운행정보보고서 &gt; 제어권 전환 정보 테이블</caption>
											<colgroup>
												<col style="width: 25%">
												<col style="width: auto">
											</colgroup>
											<tbody>
												<tr>
													<td>
														<p class="d-flex">엑셀 등록 양식 다운로드</p>
													</td>
													<td>
														<div class="ui-form">
															<button type="button"
																class="btn btn-width--l btn-color--navy"
																onclick="javascript:fn_excelTempDown()">양식 다운로드</button>
														</div>
													</td>
												</tr>
												<tr>
													<td>
														<p class="d-flex">
															<img src="" alt=""> 엑셀 파일 등록하기 (변경됐을 경우)
														</p>
													</td>
													<td>
														<div class="ui-form">
															<form action="">
																<div class="file">
																	<div class="file__input" id="file__input">
																		<input class="file__input--file" id="excelFile"
																			name="excelFile" type="file"> <input
																			class="file__upload--name" disabled=""
																			placeholder="등록된 파일 없음"> <label
																			class="file__input--label" for="excelFile">파일찾기</label>
																	</div>
																</div>
															</form>
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>

									<table
										class="table-basic table-basic--col mt-20 table-us_du_02_view--05">
										<caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
										<colgroup>
											<col style="width: 25%">
											<col style="width: auto">
											<col style="width: 20%">
											<col style="width: 25%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">제어권 전환 일시</th>
												<th scope="col">장소</th>
												<th scope="col">사유</th>
												<th scope="col">비고</th>
											</tr>
										</thead>
										<tbody>
											<c:choose>
												<c:when test="${chgDtlList eq null || empty chgDtlList}">
													<tr>
														<td colspan="4">등록된 정보가 없습니다</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="list" items="${chgDtlList}"
														varStatus="status">
														<tr id="listLength">
															<td>${list.ctrChangeDateView}</td>
															<td>${list.ctrChangePlace}</td>
															<td>${list.ctrChangeContent }</td>
															<td class="left border_l_none">${list.rmk}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
									<!-- ldk-custom 보고서등록 첨부파일 란 추가 -->
									<div class="attachment-wrap">
										<h5 class="layout-content__subtit">보험 증권사 정보</h5>
										<div id="toBeTable"
											class="el-box el-box--gray el-box--border mt-20">
											<table
												class="table-basic table-basic--row mt-20 table-us_du_02_write--05">
												<colgroup>
													<col style="width: 25%">
													<col style="width: auto">
												</colgroup>
												<tbody>
													<tr>
														<td>
															<p class="d-flex">
																<img src="" alt=""> 새로운 첨부파일로 변경하기
															</p>
														</td>
														<td>
															<div class="ui-form">
																<!-- <form action=""> -->
																<div class="file">
																<div class="file__input" id="file__input">
																	<input class="file__input--file" name="file_info"
																		id="file_info" type="file"
																		onChange="fileExtCheck(this);"> <input
																		type="text" class="file__upload--name" name="filename"
																		id="filename" placeholder="선택된 파일 없음"> <label
																		class="file__input--label" for="file_info">파일찾기</label>
																</div>
															</div>
																<!-- </form> -->
															</div>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>


									<div class="btn-wrap btn-row justify-center mt-30 mb-80">
										<button type="button"
											class="btn btn-width--l btn-color--white"
											onclick="javascript:fn_List()">취소</button>
										<button type="button" class="btn btn-width--l btn-color--navy"
											onclick="javascript:fn_Save('${drv_no}','${std_dt}');">등록</button>
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
	<!--  contWrap -->
	</div>
	<!-- //container -->
</form:form>
