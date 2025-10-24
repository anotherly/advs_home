<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<!-- ldk-custom-update -->
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<!-- ldk-custom-end -->
<script src="/js/commonFunction.js"></script>
<!-- 공통 script 함수를 정의 -->
<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";
	// 기준일자 생성
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	var today = function getToday() {
		return year + month + day;
	};

	$(document).ready(function() {
		
		console.log(" 운행정보 등록화면");
		
		c_form = document.listForm; //폼 셋팅
		var radio_change = $("input[name='radio_change']:checked").val();
		if (radio_change == "toBe") {
			$('#asIsTable').hide();
		}
		$('input[name="radio_change"]').change(function() {
			if ($('input[name="radio_change"]:checked').val() == "toBe") {
				$("#asIsTable").hide();
				$('#toBeTable').show();
			} else {
				$('#asIsTable').show();
				$('#toBeTable').hide();
			}

		});

		/* var stnd_dt = "";
		var stnd_dt_y = ""; 
		var stnd_dt_d = ""; */

		// 기준일자 숫자만 입력되도록 수정
		// 기준일자에 대한 정의 필요
		// 입력에서 입력하는 월 확인하여 상반기 하반기로 나눔
		/* $("#stnd_dt").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		 }); */

		// $('#stnd_dt').on('keyup',function() {
		//stnd_dt = $('#stnd_dt').val();
		//stnd_dt_y = stnd_dt.substring(0, 4);
		//stnd_dt_d = stnd_dt.substring(4, 8);
		//if($(this).val().length >= 8){
		if (month + day >= "0701" && month + day <= "1231") {
			$('#stnd_dt').val(Number(year) + "0630");
			$("#dist_mon_1").val("01").prop("selected", true);
			$("#dist_mon_2").val("02").prop("selected", true);
			$("#dist_mon_3").val("03").prop("selected", true);
			$("#dist_mon_4").val("04").prop("selected", true);
			$("#dist_mon_5").val("05").prop("selected", true);
			$("#dist_mon_6").val("06").prop("selected", true);
			$("#chng_mon_1").val("01").prop("selected", true);
			$("#chng_mon_2").val("02").prop("selected", true);
			$("#chng_mon_3").val("03").prop("selected", true);
			$("#chng_mon_4").val("04").prop("selected", true);
			$("#chng_mon_5").val("05").prop("selected", true);
			$("#chng_mon_6").val("06").prop("selected", true);
		} else if (month + day >= "0101" && month + day <= "0630") {
			$('#stnd_dt').val((year - 1) + "1231");// 전년도 하반기라 -1
			$("#dist_mon_1").val("07").prop("selected", true);
			$("#dist_mon_2").val("08").prop("selected", true);
			$("#dist_mon_3").val("09").prop("selected", true);
			$("#dist_mon_4").val("10").prop("selected", true);
			$("#dist_mon_5").val("11").prop("selected", true);
			$("#dist_mon_6").val("12").prop("selected", true);
			$("#chng_mon_1").val("07").prop("selected", true);
			$("#chng_mon_2").val("08").prop("selected", true);
			$("#chng_mon_3").val("09").prop("selected", true);
			$("#chng_mon_4").val("10").prop("selected", true);
			$("#chng_mon_5").val("11").prop("selected", true);
			$("#chng_mon_6").val("12").prop("selected", true);
		}
	});

	function checkFileType(filePath) {
		var fileFormat = filePath.split(".");
		if (fileFormat.indexOf("xls") > -1) {
			c_form.excelType.value = fileFormat[1];
			return true;
		} else if (fileFormat.indexOf("xlsx") > -1) {
			c_form.excelType.value = fileFormat[1];
			return true;
		} else {
			return false;
		}
	}

	function check() {
		var file = $("#excelFile").val();
		if (file == "" || file == null) {
			return true;
		} else if (!checkFileType(file)) {
			return false;
		}
	}
	
	/* ldk-custom */
	function checkAttachmentFile() {
		var file = $("#attachmentFile").val();
		if (file == "" || file == null) {
			return true;
		}
	}
	/* ldk-custom-end */
	
	/* 등록 function */
	function fn_Insert() {

		if (confirm("등록 하시겠습니까?")) {
			// c_form.stnd_dt_y.value = $("#stnd_dt").val().substring(0,4);
			// c_form.stnd_dt_d.value = $("#stnd_dt").val().substring(4,8);

			if (check() == false) {
				alert("엑셀 파일만 업로드 가능합니다.");
				return;
			}

			if (trim(c_form.tmp_race_number.value).length == 0) {
				alert("임시운행등록번호를 선택해주세요");
				c_form.tmp_race_number_view.focus();
				return;
			}
			/* var stnd_dt_d = $("#stnd_dt_d option:selected").val();
			if(stnd_dt_d == "") {
				alert("기준일자를 선택해주세요");
				c_form.stnd_dt_d.focus();
				return;
			} */

			/*if(trim(c_form.stnd_dt.value).length==0){
				alert("기준일자를 입력해주세요");
				c_form.stnd_dt.value="";
				c_form.stnd_dt.focus();
				return;
			}*/

			if (trim(c_form.isexist.value) == "N") {
				alert("이미 등록된 정보 입니다");
				c_form.stnd_dt.focus();
				return;
			}

			if (trim(c_form.total_driving_dist.value).length == 0) {
				alert("총 주행거리를 입력해주세요");
				c_form.total_driving_dist.value = "";
				c_form.total_driving_dist.focus();
				return;
			}

			if (trim(c_form.auto_driving_dist.value).length == 0) {
				alert("자율모드 주행거리를 입력해주세요");
				c_form.auto_driving_dist.value = "";
				c_form.auto_driving_dist.focus();
				return;
			}

			if (trim(c_form.nomal_driving_dist.value).length == 0) {
				alert("일반모드 주행거리를 입력해주세요");
				c_form.nomal_driving_dist.value = "";
				c_form.nomal_driving_dist.focus();
				return;
			}

			if (eval(c_form.auto_driving_dist.value)
					+ eval(c_form.nomal_driving_dist.value) != eval(c_form.total_driving_dist.value)) {
				alert("자율모드와 일반모드 주행거리의 합계와 총 주행거리의 값이 틀립니다");
				c_form.total_driving_dist.value = "";
				c_form.total_driving_dist.focus();
				return;
			}

			var cnt = 0;
			var dist = new Array();
			dist[0] = $("#dist_mon_1 option:selected").val();
			dist[1] = $("#dist_mon_2 option:selected").val();
			dist[2] = $("#dist_mon_3 option:selected").val();
			dist[3] = $("#dist_mon_4 option:selected").val();
			dist[4] = $("#dist_mon_5 option:selected").val();
			dist[5] = $("#dist_mon_6 option:selected").val();
			for (var i = 0; i < dist.length; i++) {
				for (var j = 1; j < dist.length; j++) {
					if (dist[i] == dist[j]) {
						cnt++;
					}
				}
				if (cnt > 1) {
					alert(dist[i] + "월이 중복됩니다.");
					c_form.dist_mon_1.focus();
					return;
				} else {
					cnt = 0;
				}
			}

			cnt = 0;
			var chng = new Array();
			chng[0] = $("#chng_mon_1 option:selected").val();
			chng[1] = $("#chng_mon_2 option:selected").val();
			chng[2] = $("#chng_mon_3 option:selected").val();
			chng[3] = $("#chng_mon_4 option:selected").val();
			chng[4] = $("#chng_mon_5 option:selected").val();
			chng[5] = $("#chng_mon_6 option:selected").val();
			for (var i = 0; i < chng.length; i++) {
				for (var j = 1; j < chng.length; j++) {
					if (chng[i] == chng[j]) {
						cnt++;
					}
				}
				if (cnt == 2) {
					alert(chng[i] + "월이 중복됩니다.");
					c_form.chng_mon_1.focus();
					return;
				} else {
					cnt = 0;
				}
			}

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
			var ch_cnt = document.getElementsByName("chg_date_d").length;
			for (var i = 0; i < ch_cnt; i++) {
				if (document.getElementsByName("chg_date_d")[i].value == "") {
					alert("전환일이 입력 안된 데이터는 등록이 되지 않습니다");
					//document.getElementsByName("chg_date_d")[i].focus();
					break;
				}
			}

			//제어권 전환 횟수
			/* alert(Number(c_form.chng_s.value) > 0 && !$("#excelFile").val());
			alert(Number(c_form.chng_s.value) == 0 && $("#excelFile").val()); */
			if (Number(c_form.chng_s.value) > 0 && !$("#excelFile").val()) {
				alert("제어권 전환 횟수 합계가 0이 아니면 엑셀 파일을 등록해주세요.");
				c_form.excelFile.focus();
				return;
			} else if (Number(c_form.chng_s.value) == 0
					&& $("#excelFile").val()) {
				alert("제어권 전환 횟수 합계가 0이면 엑셀 파일 첨부할 수 없습니다.");
				c_form.chng_s.focus();
				return;
			}

			document.listForm.action = "<c:url value='/duty/driving/Duty_Drvg_Inst_Process.do'/>";
			document.listForm.submit();
		}
	}

	/* 중복확인 function */
	function fn_IsExist() {
		/* var stnd_dt_y = $("#stnd_dt_y option:selected").val();
		var stnd_dt_d = $("#stnd_dt_d option:selected").val(); */
		if (trim(c_form.tmp_race_number.value).length == 0) {
			alert("임시운행등록번호를 입력해주세요");
			c_form.tmp_race_number.focus();
			return;
		} /* else if(stnd_dt_d == "") {
				     alert("기준일자를 선택해주세요");
				     c_form.stnd_dt.focus();
				     return;
				   } */else {
			$
					.ajax({
						type : "POST",
						cache : false,
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						url : "/duty/driving/Duty_Drvg_IsExist.do",
						data : {
							drv_no : c_form.tmp_race_number.value,
							stnd_dt_y : stnd_dt_y,
							stnd_dt_d : stnd_dt_d
						},
						success : function(data) {
							var arr = eval(data);
							if (arr == null) {
								return;
							} else {
								var result = arr[0].result;
								if (result == 0) {
									c_form.isexist.value = "Y";
								} else if (result > 0) {
									alert("존재하는 정보입니다");
									c_form.isexist.value = "N";
								}
							}
						},
						error : function(data) {
						}
					});
		}
	}

	function fn_tmpEvent(val) {
		if (val == null || val == "") {
			c_form.tmp_race_number.value = "";
			c_form.tmp_race_agency.value = "";
			//c_form.ins_letter_number.value = "";
			c_form.ins_init_date_view.value = "";
			c_form.ins_init_date.value = "";
		} else {
			var strArr = val.split('|');
			c_form.tmp_race_number.value = strArr[0];
			c_form.tmp_race_agency.value = strArr[1];
			//c_form.ins_letter_number.value = strArr[2];
			c_form.ins_init_date_view.value = strArr[3];
			c_form.ins_init_date.value = strArr[4];
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

	function fn_update_date() {
		var tmpRaceNumber = document.getElementById("tmp_race_number").value;
		if (trim(c_form.tmp_race_number_view.value).length == 0) {
			c_form.tmp_race_number.focus();
			alert("임시운행등록번호를 선택해 주세요");
			return;
		}
		window.open('/common/Duty_Tpsv_Insdate_Popup.do?tmp_race_number='
				+ tmpRaceNumber, 'tpsv_inst',
				'left=200, top=100, width=498, height=428');
	}

	function fnSetInsInitDate(insInitDate) {
		c_form.ins_init_date_view.value = insInitDate + " 00:00:00";
		c_form.ins_init_date.value = insInitDate + "000000";
	}

	function fn_List() {
		location.href = "/duty/driving/Duty_Drvg_List.do";
	}

	/* function fn_excelTempDown(){
		document.location.href = '/templetFile/제어권전환정보_양식.xlsx';
	} */

	function fn_excelTempDown(file_nm) {
		c_form.file_nm.value = file_nm;
		c_form.dir_nm.value = "notc";
		c_form.action = "<c:url value='/common/File_Download.do'/>";
		c_form.submit();
	}
</script>

<form:form id="listForm" name="listForm" method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="tmp_race_number" id="tmp_race_number" />
	<input type="hidden" name="isexist" id="isexist" />
	<input type="hidden" id="excelType" name="excelType" />
	<input type="hidden" id="file_nm" name="file_nm" />
	<input type="hidden" id="dir_nm" name="dir_nm" />
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
									<h5 class="layout-content__subtit d-flex">운행정보보고서 등록</h5>
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
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<select id="tmp_race_number_view"
																	name="tmp_race_number_view" class="w100p"
																	onchange="javascript:fn_tmpEvent(this.value)">
																	<c:choose>
																		<c:when
																			test="${code_tempoper eq null || empty code_tempoper}">
																			<option value="">-</option>
																		</c:when>
																		<c:otherwise>
																			<option value="">-</option>
																			<c:forEach var="list" items="${code_tempoper }"
																				varStatus="loop">
																				<option
																					value="${list.tmpNumber}|${list.tmpAgency}|${list.letterNum}|${list.insInitDateView}|${list.insInitDate}">${list.tmpNumber}</option>
																			</c:forEach>
																		</c:otherwise>
																	</c:choose>
																</select>
															</div>
														</div>
													</td>
													<th scope="row">보험가입일자</th>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	readonly="" id="ins_init_date_view"
																	name="ins_init_date_view"><input type="hidden"
																	id="ins_init_date" name="ins_init_date">
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<th scope="row">임시운행기관</th>
													<td colspan="3">
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--ul"
																	readonly="" id="tmp_race_agency" name="tmp_race_agency">
															</div>
														</div>
													</td>
												</tr>
												<tr>
													<th scope="row">기준일자</th>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	id="stnd_dt" name="stnd_dt" title="기준일자 입력"
																	maxlength="8" />
															</div>
														</div>
													</td>
													<th scope="row">총 주행거리</th>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	id="total_driving_dist" name="total_driving_dist"
																	title="총 주행거리 입력" readonly="" />
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
												<col style="width: 13.5%">
												<col style="width: auto">
												<col style="width: 18%">
												<col style="width: 13.5%">
												<col style="width: auto">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row" rowspan="7">월별 자율모드 주행거리</th>
													<td><select id="dist_mon_1" name="dist_mon_1"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_1" name="dist_1" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<th scope="row" rowspan="7">월별 제어권 전환 횟수</th>
													<td><select id="chng_mon_1" name="chng_mon_1"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_1"
														name="chng_1" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();" /> 건</td>
												</tr>
												<tr>
													<td><select id="dist_mon_2" name="dist_mon_2"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_2" name="dist_2" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<td><select id="chng_mon_2" name="chng_mon_2"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_2"
														name="chng_2" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();"> 건</td>
												</tr>
												<tr>
													<td><select id="dist_mon_3" name="dist_mon_3"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_3" name="dist_3" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<td><select id="chng_mon_3" name="chng_mon_3"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_3"
														name="chng_3" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();" /> 건</td>
												</tr>
												<tr>
													<td><select id="dist_mon_4" name="dist_mon_4"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_4" name="dist_4" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<td><select id="chng_mon_4" name="chng_mon_4"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_4"
														name="chng_4" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();" /> 건</td>
												</tr>
												<tr>
													<td><select id="dist_mon_5" name="dist_mon_5"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_5" name="dist_5" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<td><select id="chng_mon_5" name="chng_mon_5"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_5"
														name="chng_5" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();" /> 건</td>
												</tr>
												<tr>
													<td><select id="dist_mon_6" name="dist_mon_6"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td>
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--100"
																	id="dist_6" name="dist_6" maxlength="7"
																	autocomplete="off" style="ime-mode: disabled;"
																	onkeypress="return numbersonly(event, false, this, 7)"
																	onkeyup="Javascript:dist_cal();" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div>
													</td>
													<td><select id="chng_mon_6" name="chng_mon_6"
														class="w100p">
															<option value="01">1월</option>
															<option value="02">2월</option>
															<option value="03">3월</option>
															<option value="04">4월</option>
															<option value="05">5월</option>
															<option value="06">6월</option>
															<option value="07">7월</option>
															<option value="08">8월</option>
															<option value="09">9월</option>
															<option value="10">10월</option>
															<option value="11">11월</option>
															<option value="12">12월</option>
													</select></td>
													<td><input type="text"
														class="ui-input ui-form-width--100" id="chng_6"
														name="chng_6" maxlength="7" autocomplete="off"
														style="ime-mode: disabled;"
														onkeypress="return numbersonly(event, false, this, 7)"
														onkeyup="Javascript:chng_cal();" /> 건</td>
												</tr>
												<tr>
													<td>합계</td>
													<td><div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" readonly=""
																	class="ui-input ui-form-width--100" id="dist_s"
																	name="dist_s" value="0" placeholder="자동계산입력" />
															</div>
															<div class="ui-form-block ml-10">km</div>
														</div></td>
													<td>합계</td>
													<td><input type="text" readonly=""
														class="ui-input ui-form-width--100" id="chng_s"
														name="chng_s" value="0" placeholder="자동계산입력" /> 건</td>
												</tr>
												<tr>
													<th scope="row">자율모드 주행거리</th>
													<td colspan="2">
														<div class="ui-form ui-form-row align-center">
															<div class="ui-form-block">
																<input type="text" class="ui-input ui-form-width--r"
																	id="auto_driving_dist" name="auto_driving_dist"
																	maxlength="7" style="ime-mode: disabled;"
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
									<!-- <div class="ui-form ml-auto">
                                 <label for="radio_to_be">
                                     <input type="radio" name="radio_change" checked id="radio_to_be" class="ui-input ui-input-radio"  value="toBe" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">엑셀업로드</span>
                                 </label>
                                 <label for="radio_as_is">
                                     <input type="radio" name="radio_change" id="radio_as_is" class="ui-input ui-input-radio"  value="asIs" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">입력방식</span>
                                 </label>
                              </div> -->
									<!-- AS_IS 입력 방법
                              <div  id="asIsTable" class="table-basic table-basic--row mt-20 table-us_du_02_write--05">
                              <p style="text-align:right !important;">
						          <select id="plus_cnt" name="plus_cnt" class="w20p">
						            <option value="1">1개</option><option value="5">5개</option><option value="10">10개</option><option value="50">50개</option><option value="100">100개</option>
						          </select>
						        </p>
							        <table summary="" class="">
							          <colgroup>
							            <col style="width:25%">
                                         <col style="width:auto">
                                         <col style="width:20%">
                                         <col style="width:25%">
							            <col width="60px">
							          </colgroup>
							          <thead>
							            <tr>
							              <th class="border_l_none"><b class="font_red">*</b> 일시</th>
							              <th>장소</th>
							              <th>사유</th>
							              <th>비고</th>
							              <th class="right"><div id="tb_plus"><a href="javascript:void(0);" class="btn_md btn_plus">추가</a></div></th>
							            </tr>
							          </thead>
							          <tbody id="tb_ctrChange">
							            <tr name="trChange">
							              <td class="border_l_none">
							                <input type="text" readonly="" id="chg_date_d1" name="chg_date_d" class="w90px datepicker">
							                <select title="전환일_시간" name="chg_date_h" id="chg_date_h" class="mr10">
							                  <c:forEach var="list" begin="0" end="23" varStatus="loop">
							                    <c:choose>
							                      <c:when test="${loop.index < 10}">
							                        <c:set var="dateHH" value="0${loop.index}" />
							                      </c:when>
							                      <c:otherwise>
							                        <c:set var="dateHH" value="${loop.index}" />
							                      </c:otherwise>
							                    </c:choose>
							                    <option value='${dateHH}' >${dateHH}</option>
							                  </c:forEach>
							                </select> 시
							                <select title="전환일_분" name="chg_date_m" id="chg_date_m"  class="mr10">
							                  <c:forEach var="list" begin="0" end="59" varStatus="loop">
							                    <c:choose>
							                      <c:when test="${loop.index < 10}">
							                        <c:set var="dateMM" value="0${loop.index}" />
							                      </c:when>
							                      <c:otherwise>
							                        <c:set var="dateMM" value="${loop.index}" />
							                      </c:otherwise>
							                    </c:choose>
							                    <option value='${dateMM}' >${dateMM}</option>
							                  </c:forEach>
							                </select> 분
							              </td>
							              <td><input type="text" class="w100p" id="ctr_change_place" name="ctr_change_place" onkeyup="checkLength(this,250)"></td>
							              <td>
							              	<select id="ctr_change_content" name="ctr_change_content" class="w100p">
							              		<c:if test="${not empty ctr_change }">
							              			<c:forEach var="ctrChange" items="${ctr_change }">
							              				<option value="${ctrChange.ctrChangeCode }">${ctrChange.ctrChangeNm }</option>
							              			</c:forEach>
							              		</c:if>
							              	</select>
							              </td>
							              
							              <td><input type="text" class="w100p" id="rmk" name="rmk" onkeyup="checkLength(this,250)"></td>
							              <td class="right"><a href="javascript:void(0);" class="btn_md btn_minus"></a></td>
							            </tr>
							          </tbody>
							        </table>
							      </div> -->
									<!-- TO_BE 입력 방법 -->
									<div id="toBeTable"
										class="el-box el-box--gray el-box--border mt-20">
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
														<p class="d-flex">
															<img src="" alt=""> 엑셀 등록 양식 다운로드
														</p>
													</td>
													<td>
														<div class="ui-form">
															<button type="button"
																class="btn btn-width--l btn-color--navy"
																onclick="javascript:fn_excelTempDown('${attachFile.attachFilename}')">양식
																다운로드</button>
														</div>
													</td>
												</tr>
												<tr>
													<td>
														<p class="d-flex">
															<img src="" alt=""> 엑셀 파일 등록하기
														</p>
													</td>
													<td>
														<div class="ui-form">
															<!-- <form action=""> -->
															<div class="file">
																<div class="file__input" id="file__input">
																	<input class="file__input--file" id="excelFile"
																		name="excelFile" type="file"> <input
																		class="file__upload--name" disabled=""
																		placeholder="등록된 파일 없음"> <label
																		class="file__input--label" for="excelFile">파일찾기</label>
																</div>
															</div>
															<!-- </form> -->
														</div>
													</td>
												</tr>
											</tbody>
										</table>
									</div>
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
																<img src="" alt=""> 첨부 파일 등록하기
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
											onclick="javascript:fn_List();">취소</button>
										<button type="button" class="btn btn-width--l btn-color--navy"
											onclick="javascript:fn_Insert();">등록</button>
									</div>

								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var rowcnt = 1;

		$("#tb_plus")
				.click(
						function() {
							var plus_cnt = intCheck($(
									"#plus_cnt option:selected").val());
							for (var i = 0; i < plus_cnt; i++) {
								//row 생성 count 처리
								rowcnt++;
								//html 생성
								var addHtml = ''
										+ '<tr name="trChange">'
										+ '  <td class="border_l_none">'
										+ '    <input type="text" readonly="" id="chg_date_d'+rowcnt+'" name="chg_date_d" class="w90px datepicker">'
										+ '    <select title="전환일_시간" name="chg_date_h" id="chg_date_h" class="mr10">'
										+ '      <option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>'
										+ '      <option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>'
										+ '      <option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>'
										+ '      <option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>'
										+ '      <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>'
										+ '      <option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>'
										+ '    </select> 시'
										+ '    <select title="전환일_분" name="chg_date_m" id="chg_date_m"  class="mr10">'
										+ '      <option value="00">00</option><option value="01">01</option><option value="02">02</option><option value="03">03</option>'
										+ '      <option value="04">04</option><option value="05">05</option><option value="06">06</option><option value="07">07</option>'
										+ '      <option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="11">11</option>'
										+ '      <option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>'
										+ '      <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option>'
										+ '      <option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option>'
										+ '      <option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option>'
										+ '      <option value="28">28</option><option value="29">29</option><option value="30">30</option><option value="31">31</option>'
										+ '      <option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option>'
										+ '      <option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option>'
										+ '      <option value="40">40</option><option value="41">41</option><option value="42">42</option><option value="43">43</option>'
										+ '      <option value="44">44</option><option value="45">45</option><option value="46">46</option><option value="47">47</option>'
										+ '      <option value="48">48</option><option value="49">49</option><option value="50">50</option><option value="51">51</option>'
										+ '      <option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option>'
										+ '      <option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option>'
										+ '    </select> 분'
										+ '  </td>'
										+ '  <td><input type="text" class="w100p" id="ctr_change_place" name="ctr_change_place" onkeyup="checkLength(this,250)"></td>'
										+ '  <td><select id="ctr_change_content" name="ctr_change_content" class="w100p">'
										+ <c:if test="${not empty ctr_change }">
								<c:forEach var="ctrChange" items="${ctr_change }">
								'<option id="${ctrChange.ctrChangeCode }">${ctrChange.ctrChangeNm }</option>'
										+ </c:forEach>
								</c:if>
								'  </select></td>'
										+
										/* '  <td><input type="text" class="w100p" id="ctr_change_content" name="ctr_change_content" onkeyup="checkLength(this,250)"></td>'+ */
										'  <td><input type="text" class="w100p" id="rmk" name="rmk" onkeyup="checkLength(this,250)"></td>'
										+ '  <td class="right"><a href="Javascript:void(0);" class="btn_md btn_minus"></a></td>'
										+ '</tr>';
								$("#tb_ctrChange").append(addHtml);
								//$(".datepicker").each(function(){ $(this).datepicker(); });
								$("input[id^='chg_date_d']")
										.each(
												function() {
													var _this = this.id;
													$('#' + _this)
															.datepicker(
																	{
																		dateFormat : 'yy-mm-dd',
																		monthNamesShort : [
																				'1월',
																				'2월',
																				'3월',
																				'4월',
																				'5월',
																				'6월',
																				'7월',
																				'8월',
																				'9월',
																				'10월',
																				'11월',
																				'12월' ],
																		dayNamesMin : [
																				'일',
																				'월',
																				'화',
																				'수',
																				'목',
																				'금',
																				'토' ],
																		changeMonth : true,
																		changeYear : true,
																		showOn : "button",
																		buttonImage : "/css/avsc/images/icon_calendar.png",
																		showMonthAfterYear : true,
																		showOtherMonths : true,
																		selectOtherMonths : true,
																		maxDate : "+12m"
																	});
												});
							}
						});

		$("#tb_ctrChange").on("click", "a", function() {
			//row remove
			$(this).closest("tr").remove();
		});
	</script>

	</div>
	<!--  contWrap -->
	</div>
	<!-- //container -->
</form:form>
