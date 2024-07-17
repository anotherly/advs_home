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

	/* 수정 function */
	function fn_Update(no, id) {
		if (confirm("등록된 정보를 수정 하시겠습니까?")) {
			c_form.drv_no.value = no;
			c_form.acc_id.value = id;
			c_form.action = "<c:url value='/duty/incident/Duty_Incd_Updt.do'/>";
			c_form.submit();
		}
	}

	/* 삭제 function */
	function fn_Delete(no, id) {
		if (confirm("정말 삭제 하시겠습니까?")) {
			c_form.drv_no.value = no;
			c_form.acc_id.value = id;
			if (confirm("등록된 사고 상세정보가 모두 삭제 됩니다")) {
				c_form.action = "<c:url value='/duty/incident/Duty_Incd_Delt_Process.do'/>";
				c_form.submit();
			}
		}
	}

	/* 보고서생성 function */
	function fn_Excel(no, id) {
		if (confirm("해당 사고 정보 보고서를 생성 하시겠습니까?")) {
			document.excelForm.drv_no.value = no;
			document.excelForm.acc_id.value = id;
			var url = "/duty/incident/Duty_Incd_Excel_Process.do";
			$("#excelForm").attr("action", url);
			$("#excelForm").submit();
		}
	}

	/* 파일 다운로드  */
	function fn_Download(file_nm) {
		c_form.file_nm.value = file_nm;
		c_form.dir_nm.value = "incd";
		c_form.action = "<c:url value='/common/File_Download.do'/>";
		c_form.submit();
	}
	
	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
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
                                            <li>예약신청</li>
										</ul>
									</div>
	
									<h5 class="layout-content__subtit">예약신청</h5>
                                    <div class="table-wrap">
                                        <table class="table-basic table-basic--row">
                                            <caption>데이터공유센터 시설이용 &gt; 차량 플랫폼 공유 &gt; 예약신청 테이블</caption>
                                            <colgroup>
                                                <col style="width:18%">
                                                <col style="width:auto">
                                                <col style="width:18%">
                                                <col style="width:40%">
                                            </colgroup>
                                            <tbody>
                                                <tr>
                                                    <th scope="row">
                                                        신청기관
                                                    </th>
                                                    <td>
                                                        자동차안전연구원
                                                    </td>
                                                    <th scope="row">
                                                        사업자등록번호
                                                    </th>
                                                    <td>
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--full" title="사업자등록번호 입력">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        기관주소
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--full" title="기관주소 입력">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        날짜 선택
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form ui-form-row align-center js-datepicker">
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--s js-datepicker" value="2022-11-02" title="날짜 선택 사고일시">
                                                            </div>
                                                            <span class="el-hyphen mx-3"></span>
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--s js-datepicker" value="2022-11-02" title="날짜 선택 사고일시">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        대여 차량
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form">
                                                            <form action="" class="ui-form-row">
                                                                <label for="radio_vehicleA">
                                                                    <input type="radio" name="radio_vehicle" checked="" id="radio_vehicleA" class="ui-input ui-input-radio">
                                                                    <span class="ui-input-radio__span"></span>
                                                                    <span class="ui-input-radio__txt">ADVS-001</span>
                                                                </label>
                                                                <label for="radio_vehicleB" class="ml-30">
                                                                    <input type="radio" name="radio_vehicle" id="radio_vehicleB" class="ui-input ui-input-radio" disabled="">
                                                                    <span class="ui-input-radio__span"></span>
                                                                    <span class="ui-input-radio__txt">ADVS-002</span>
                                                                </label>
                                                                <label for="radio_vehicleC" class="ml-30">
                                                                    <input type="radio" name="radio_vehicle" id="radio_vehicleC" class="ui-input ui-input-radio" disabled="">
                                                                    <span class="ui-input-radio__span"></span>
                                                                    <span class="ui-input-radio__txt">ADVS-003</span>
                                                                </label>
                                                                <label for="radio_vehicleD" class="ml-30">
                                                                    <input type="radio" name="radio_vehicle" id="radio_vehicleD" class="ui-input ui-input-radio">
                                                                    <span class="ui-input-radio__span"></span>
                                                                    <span class="ui-input-radio__txt">ADVS-004</span>
                                                                </label>
                                                                <label for="radio_vehicleF" class="ml-30">
                                                                    <input type="radio" name="radio_vehicle" id="radio_vehicleF" class="ui-input ui-input-radio">
                                                                    <span class="ui-input-radio__span"></span>
                                                                    <span class="ui-input-radio__txt">ADVS-005</span>
                                                                </label>
                                                                <div class="ui-form-block ml-20">
                                                                    <span class="el-caution font-xs">* 당일 신청불가, 명일부터 최대 2주까지 신청가능</span>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        대여 일시
                                                    </th>
                                                    <td>
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <select name="" id="" class="ui-select ui-form-width--s">
                                                                    <option value="">09:00</option>
                                                                    <option value="">10:00</option>
                                                                    <option value="">11:00</option>
                                                                    <option value="">12:00</option>
                                                                    <option value="">13:00</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <th scope="row">
                                                        반납 예정 일시
                                                    </th>
                                                    <td>
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <select name="" id="" class="ui-select ui-form-width--s">
                                                                    <option value="">09:00</option>
                                                                    <option value="">10:00</option>
                                                                    <option value="">11:00</option>
                                                                    <option value="">12:00</option>
                                                                    <option value="">13:00</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        운행 예정 지역
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--full" title="운행 예정 지역 입력">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        수집데이터
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--full" title="수집데이터 입력">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        업로드 예정일시
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form">
                                                            <div class="ui-form-block">
                                                                <select name="" id="" class="ui-select ui-form-width--s">
                                                                    <option value="">09:00</option>
                                                                    <option value="">10:00</option>
                                                                    <option value="">11:00</option>
                                                                    <option value="">12:00</option>
                                                                    <option value="">13:00</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <th scope="row">
                                                        첨부파일
                                                    </th>
                                                    <td colspan="3">
                                                        <div class="ui-form ui-form-row align-center">
                                                            <form action="http://m16.co.kr/ts/sub/US_FA_02_write.html">
                                                                <div class="file">
                                                                    <div class="file__input  ui-form-width--auto" id="file__input">
                                                                        <input class="file__input--file" id="customFile" type="file" multiple="multiple" name="files[]">
                                                                        <input class="file__upload--name ui-form-width--300" disabled="">
                                                                        <label class="file__input--label" for="customFile">파일찾기</label>
                                                                    </div>
                                                                  </div>
                                                            </form>
                                                            <div class="ui-form-block ml-20">
                                                                <span class="el-caution font-xs">* 당일 신청불가, 명일부터 최대 2주까지 신청가능</span>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        
                                    </div>
                                    
                                    <div class="term-box">
                                        <div class="term-box__inner">
                                            <p class="font-16">(계약체결, 변경 및 해지)</p>
                                            <ul class="lists lists-num">
                                                <li>별도의 계약서를 작성하지 아니할 경우에는 사용의뢰서로 계약서를 갈음하며, 대여약관에 동의한 것으로 간주 한다</li>
                                                <li>부득이 사용일정을 변경해야 할 사유가 발생한 경우에는 그 기간을 변경할 수 있다. 다만, 다른 기관의 대여 일정이 있는 경우 변경할 수 없다.</li>
                                                <li>차량의 운행에 있어 대여기관의 운전자만 차량을 운행하여야 하며, 도로교통법상 운전자의무를 준수해야 하고, 음주 운전 등 금지행위를 하지 않아야
                                                한다.</li>
                                                <li>자동차사고 발생 시 대여약관 제11조에 따라 사고 조치를 하여야 하고, 공단이 가입한 자동차보험 지급금을 초과분은 대여기관에서 부담하여야 한다.</li>
                                                <li>반납 후 1개월 이내에 대여차량을 이용하여 수집된 데이터를 1건 이상 공유센터에 업로드하여야 한다</li>
                                            </ul>
                                            <p class="mt-30 font-16">(부대조건)</p>
                                            <ul class="lists lists-num">
                                                <li>사용자의 과실 또는 원인제공으로 인한 차량 파손에 대하여 사용자 부담으로 원상복구하여야 한다.</li>
                                                <li>사용자는 수집차를 인도받은 시점부터 반환시까지 선량한 관리자의 주의의무를 다하여 사용하고 보관하여야 한다.</li>
                                                <li>사용자는 취득한 정보를 외부로 누출하거나 사업적 목적으로 공단명칭을 사용하여서는 아니된다.</li>
                                                <li>안전사고 예방 및 보안에 대하여 사용자 스스로 대책을 강구하여야 하며, 공단에 사고 등의 책임을 전가할 수 없다.</li>
                                            </ul>
                                            <p class="mt-30 font-l fontW-500 color--black ta-r">
                                                한국교통안전공단 이사장
                                                <span class="font-r">귀하</span>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="d-flex align-center">
                                        <div class="ui-form ui-form-row">
                                            <div class="ui-form-check ui-form-row">
                                                <input type="checkbox" id="input-check__us_fa_02" class="ui-input ui-form-check__input">
                                                <span class="ui-form-check__span">체크박스</span>
                                                <label for="input-check__us_fa_02" class="ui-form-check__label">
                                                    상기의 기재사항에 동의하며 상기 데이터 수집용 차량 사용을 의뢰합니다.
                                                </label>
                                            </div>
                                        </div>
                                        <p class="ml-auto mr-20 font-16">(서명 또는 직인)</p>
                                        <button type="button" class="btn btn-height--s btn-color--navy color-white" style="border-radius:2px;">서명하기</button>
                                    </div>
                                        
                                    <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                        <button type="button" class="btn btn-width--l btn-color--white">취소</button>
                                        <button type="button" class="btn btn-width--l btn-color--navy js-popup" data-id="click_reserve">예약신청</button>
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

<form id="excelForm" name="excelForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
</form>
