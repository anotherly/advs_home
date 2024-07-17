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
<script src="/js/clip.js"></script>
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
	
	function fn_Report(no, id) {
	    if(confirm("해당 사고 정보 보고서를 생성 하시겠습니까?")) {
	    	var oReport = GetfnParamSet();
	    	oReport.rptname = "incdReport";
	    	oReport.param("DRV_NO").value = no;
	    	oReport.param("ACC_ID").value = id;
	    	oReport.open();
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
		location.href = "<c:url value='/duty/incident/Duty_Incd_List.do'/>";
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
								<h3 class="lnb__tit">운행정보보고</h3>
								<div class="lnb-list">
									<div class="lnb-item is-active ">
										<a href="/duty/incident/Duty_Incd_List.do">교통사고</a>
									</div>
									<div class="lnb-item">
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
										<h4 class="layout-content__tit">교통사고</h4>
										<ul class="location ml-auto">
											<li>
                                            	<img src="/image/sub/icon/icon-home.png" alt="홈">
                                            </li>
											<li>운행정보 보고</li>
											<li>교통사고</li>
										</ul>
									</div>

									<h5 class="layout-content__subtit d-flex align-end">기관정보
										<button onClick="javascript:fn_Report('${drv_no}','${acc_id}');" type="button" class="btn btn-width--m btn-color--navy ml-auto d-flex align-center justify-center">
                                       		<img src="/image/common/icon/icon-file--s.png" class="mr-10" alt="">보고서 생성
                                        </button>
									</h5>
									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col style="width:18%">
	                                        	<col style="width:auto">
	                                            <col style="width:18%">
	                                            <col style="width:34%">
											</colgroup>
											<tbody>
												<tr>
													<th class="border_l_none">임시운행기관</th>
													<td>${incdInfo.tmpRaceAgency}</td>
													<th>임시운행등록번호</th>
													<td>${incdInfo.tmpRaceNumber}</td>
												</tr>
											</tbody>
										</table>
									</div>

									<h5 class="layout-content__subtit">사고개요</h5>
									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col style="width:18%">
	                                        	<col style="width:auto">
	                                            <col style="width:18%">
	                                            <col style="width:34%">
											</colgroup>
											<tbody>
												<tr>
													<th class="border_l_none">사고일시</th>
													<td>${incdInfo.accDateView}</td>
													<th>사고장소</th>
													<td>${incdInfo.place}</td>
												</tr>
												<tr>
													<th class="border_l_none">기상상황</th>
													<td>${incdInfo.weatherView}</td>
													<th>도로상황</th>
													<td>${incdInfo.roadSituationView}</td>
												</tr>
												<tr>
													<th class="border_l_none">도로유형</th>
													<td colspan="3">${incdInfo.roadTypeCdView}</td>
												</tr>
											</tbody>
										</table>
									</div>

									<h5 class="layout-content__subtit">자율주행 자동차</h5>
									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col style="width:18%">
	                                        	<col style="width:auto">
	                                            <col style="width:18%">
	                                            <col style="width:34%">
											</colgroup>
											<tbody>
												<tr>
													<th class="border_l_none">주행모드</th>
													<td>${incdInfo.autocarDrivingModeView}</td>
													<th>주행상태</th>
													<td>${incdInfo.autocarDrivingStatusCdView}</td>
												</tr>
												<tr>
													<th class="border_l_none">운행속도</th>
													<td>${incdInfo.autocarSpeed}Km/h</td>
													<th>승차인원</th>
													<td>${incdInfo.autocarRideNumber}명</td>
												</tr>
												<tr>
													<th class="border_l_none">적재량</th>
													<td>${incdInfo.autocarLoadVol}Kg</td>
													<th>파손정도</th>
													<td>${incdInfo.autocarDamageView}</td>
												</tr>
												<tr>
													<th class="border_l_none">인적피해</th>
													<td colspan="3">${incdInfo.humanInjuryTypeView}/${incdInfo.autocarHumanSexView}/${incdInfo.autocarHumanAge}</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									<c:choose>
										<c:when test="${carList eq null || empty carList}">
											<h5 class="layout-content__subtit">사고차량${status.count}</h5>
											<div class="table-wrap" id="cloneAccident">
												<table id="tb_acc_sub" class="table-basic table-basic--row">
													<tr>
														<td>등록된 사고차량이 없습니다.</td>
													</tr>
												</table>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach var="list" items="${carList}" varStatus="status">
												<h5 class="layout-content__subtit">사고차량${status.count}</h5>
												<div class="table-wrap" id="cloneAccident">
													<table id="tb_acc_sub" class="table-basic table-basic--row">
				                                    	<caption>운행정보보고 &gt; 교통사고 &gt; 사고차량 테이블</caption>
					                                        <colgroup>
				                                            <col style="width:18%">
				                                            <col style="width:auto">
				                                            <col style="width:18%">
				                                            <col style="width:34%">
				                                    	</colgroup>
				                                        <tbody>
															<tr>
																<th class="border_l_none">사고차량종류</th>
																<td colspan="3">${list.acccarCarTypeView}</td>
															</tr>
															<tr>
																<th class="border_l_none">사고차주행모드</th>
																<td>${list.acccarDrivingModeView}</td>
																<th>사고차주행상태</th>
																<td>${list.acccarDrivingStatusCdView}</td>
															</tr>
															<tr>
																<th class="border_l_none">사고차운행속도</th>
																<td>${list.acccarSpeed}Km/h</td>
																<th>사고차승차인원</th>
																<td>${list.acccarRideNumber}명</td>
															</tr>
															<tr>
																<th class="border_l_none">사고차적재량</th>
																<td>${list.acccarLoadVol}Kg</td>
																<th>사고차파손정도</th>
																<td>${list.acccarDamageView}</td>
															</tr>
															<tr>
																<th class="border_l_none">사고차인적피해</th>
																<td colspan="3">${list.humanInjuryTypeView}/${list.acccarHumanSexView}/${list.acccarHumanAge}</td>
															</tr>
														</tbody>
													</table>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>

									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col width="18%">
												<col width="auto">
											</colgroup>
											<tbody>
												<tr>
													<th scope="row">사고상세묘사</th>
													<td style="word-break: break-all">${incdInfo.accDetailInfo}</td>
												</tr>
											</tbody>
										</table>
									</div>

									<!-- <div class="table_row mt40 mb10">
										<p class="contTit1">첨부서류</p>
										<p class="right"></p>
									</div> -->
									<h5 class="layout-content__subtit">첨부서류</h5>
									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col width="18%">
												<col width="auto">
											</colgroup>
											<tbody>
												<tr>
													<th class="border_l_none">운행정보</th>
													<td><c:choose>
															<c:when test="${!empty incdInfo.drivingInfoFile}">
																<a href="javascript:void(0);"
																	title="${incdInfo.drivingInfoFile} 첨부파일입니다"
																	onclick="fn_Download('${incdInfo.drivingInfoFile}')"><img
																	src="/images/avsc/ico_file.png" alt="다운로드" class="file_icon"/><i
																	class="font_lGray">${incdInfo.drivingInfoFile}</i></a>
															</c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</td>
												</tr>
												<tr>
													<th class="border_l_none">사고기록장치 저장데이터</th>
													<td>
														<c:choose>
															<c:when test="${!empty incdInfo.accRecDeviceFile}">
																<a href="javascript:void(0);" title="${incdInfo.accRecDeviceFile} 첨부파일입니다"
																	onclick="fn_Download('${incdInfo.accRecDeviceFile}')"><img
																	src="/images/avsc/ico_file.png" alt="다운로드" class="file_icon"/><i
																	class="font_lGray">${incdInfo.accRecDeviceFile}</i></a>
															</c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose>
													</td>
												</tr>
											</tbody>
										</table>
									</div>

									<div class="table-wrap">
										<table class="table-basic table-basic--row">
											<colgroup>
												<col width="18%">
												<col width="auto">
											</colgroup>
											<tbody>
												<tr>
													<th class="border_l_none">기타첨부파일</th>
													<td><c:choose>
															<c:when test="${!empty incdInfo.etcFilename}">
																<a href="javascript:void(0);"
																	title="${incdInfo.etcFilename} 첨부파일입니다"
																	onclick="fn_Download('${incdInfo.etcFilename}')"><img
																	src="/images/avsc/ico_file.png" alt="다운로드" class="file_icon"/><i
																	class="font_lGray">${incdInfo.etcFilename}</i></a>
															</c:when>
															<c:otherwise>-</c:otherwise>
														</c:choose></td>
												</tr>
											</tbody>
										</table>
									</div>

									<h5 class="layout-content__subtit">주행영상 데이터</h5>
									<div class="table-wrap">
										<script type="text/javascript">
										// 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
							            var uploadConfig = {
							                Id: "kupload",
							                //InitXml: "raonkupload.config.xml",
							                //SkinName: "blue",
							                Width: "auto",
							                //Height: "500px",
							                //MaxTotalFileSize: "20GB",
							                //MaxOneFileSize: "20KB",
							                MaxTotalFileCount: "20",
							                MultiFileSelect: true,
							                //ExtensionAllowOrLimit: "0",
							                //ExtensionArr: "png",
							                ResumeUpload: "1",
							                ResumeDownload: "1",
							                FolderNameRule: "incd",
							                FileNameRule: "REALFILENAME",
							                Mode: "view", // edit, view
							                CompleteEventResetUse: "1",
									Runtimes:'html5'
							            };

							            var upload = new RAONKUpload(uploadConfig);	
										</script>
									</div>
									<div class="btn-wrap btn-row justify-center mt-30 mb-80">
<%-- 										<button type="button" onClick="javascript:fn_Update('${drv_no}','${chg_id}');" class="btn btn-width--l btn-color--gray">수정</button>  --%>
										<button type="button" onClick="javascript:fn_Delete('${drv_no}','${acc_id}');" class="btn btn-width--l btn-color--white">삭제</button> 
										<button type="button" id="goToList" class="btn btn-width--l btn-color--navy" onclick="fn_goList();">목록으로</button>
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
