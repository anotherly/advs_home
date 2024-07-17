<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>

<script type="text/javaScript"defer>
  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 수정 function */
function fn_Update(no, dt) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
		c_form.drv_no.value = no;
		c_form.std_dt.value = dt;      
		c_form.action = "<c:url value='/duty/driving/Duty_Drvg_Updt.do'/>";
		c_form.submit();
	}
}

	/* 삭제 function */
function fn_Delete(no, dt) {
	if(confirm("정말 삭제 하시겠습니까?")) {
		c_form.drv_no.value = no;
		c_form.std_dt.value = dt;
		if(confirm("등록된 운행정보 상세정보가 모두 삭제 됩니다")) {
       		c_form.action = "<c:url value='/duty/driving/Duty_Drvg_Delt_Process.do'/>";
       		c_form.submit();
		}
	}
}

	/* 보고서생성 function */
function fn_Report(no, std) {
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	
	if(confirm("해당 운행정보 보고서를 생성 하시겠습니까?")) {
		var oReport = GetfnParamSet();
    	oReport.rptname = "driveReport";
    	oReport.param("year").value = year;
    	oReport.param("month").value = month;
    	oReport.param("day").value = day;
    	oReport.param("DRV_NO").value = no;
    	oReport.param("STD_DT").value = std;
    	oReport.open();
	}
}
  
function fn_goList() {
	location.href = "<c:url value='/duty/driving/Duty_Drvg_List.do'/>";
}
</script>

<form:form id="listForm" name="listForm" method="post" >
	<input type="hidden" name="drv_no" id="drv_no"/>
	<input type="hidden" name="std_dt" id="std_dt"/>
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
										<li>
											<img src="/image/sub/icon/icon-home.png" alt="홈">
										</li>
                                        <li>운행정보보고</li>
                                        <li>운행정보보고서</li>
									</ul>
								</div>
                                <h5 class="layout-content__subtit d-flex align-end">상세정보
                                    <button type="button" class="btn btn-width--m btn-color--navy ml-auto d-flex align-center justify-center" onclick="javascript:fn_Report('${drv_no}','${std_dt}');">
                                        <img src="/image/common/icon/icon-file--s.png" class="mr-10" alt="">보고서 생성
                                    </button>
                                </h5>
                                <div class="table-wrap">
                                <table class="table-basic table-basic--row mt-20">
									<caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
										<colgroup>
											<col style="width:18%">
                                            <col style="width:auto">
                                            <col style="width:18%">
                                            <col style="width:34%">
										</colgroup>
                                        <tbody>
											<tr>                                             
												<th scope="row">임시운행등록번호</th>
                                                <td>${drvgInfo.tmpRaceNumber}</td>
                                             	<th scope="row">보험가입일자</th>
                                                <td>${drvgInfo.insInitDateView}</td>
                                            </tr>
                                            <tr>
												<th scope="row">임시운행기관</th>
                                                <td colspan="3">${drvgInfo.tmpRaceAgency}</td>    
											</tr>
                                            <tr>
												<th scope="row">기준일자</th>
                                                <td>${drvgInfo.stndDtView}</td>
                                                <th scope="row">총 주행거리</th>
                                                <td>${drvgInfo.totalDrivingDist} Km</td>
											</tr>
										</tbody>
                                    </table>
                                    <table class="table-basic table-basic--row mt-20 table-us_du_02_view--04">
                                        <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
                                        <colgroup>
                                            <col style="width:18%">
                                          <col style="width:13.5%">
                                          <col style="width:auto">
                                          <col style="width:18%">
                                          <col style="width:13.5%">
                                          <col style="width:auto">
                                        </colgroup>
										<tbody>
                                            <c:set var="drv_sum" value="0" />
									        <c:set var="chg_sum" value="0" />
									        <c:forEach var="drvList" items="${drvList}" varStatus="drvStatus">
										        <c:choose>
											        <c:when test="${drvStatus.index eq 0}">
												        <tr>
													        <th scope="row" rowspan="7">월별 자율모드 주행거리</th>
									                        <td>${drvList.drivingDistMonView}</td>
									                        <td>${drvList.autoDrivingDist} Km</td>
									                        <c:set var="drv_sum" value="${drv_sum + drvList.autoDrivingDist}" />
									                        <th scope="row" rowspan="7">월별 제어권 전환 횟수</th>
									                        <c:forEach var="chgList" items="${chgList}" varStatus="chgStatus">
												                <c:if test="${chgStatus.index eq drvStatus.index}">
													                <td>${chgList.ctrChangeMonView}</td>
													                <td>${chgList.ctrChangeCnt} 건</td>
																<c:set var="chg_sum" value="${chg_sum + chgList.ctrChangeCnt}" />
												                </c:if>
											                </c:forEach>
			                                            </tr>
		                                            </c:when>
		                                            <c:otherwise>
			                                            <tr>
				                                            <td>${drvList.drivingDistMonView}</td>
						                    				<td>${drvList.autoDrivingDist} Km</td>
						                    				<c:set var="drv_sum" value="${drv_sum + drvList.autoDrivingDist}" />
						                    				<c:forEach var="chgList" items="${chgList}" varStatus="chgStatus">
							                      				<c:if test="${chgStatus.index eq drvStatus.index}">
							                        			<td>${chgList.ctrChangeMonView}</td>
							                        			<td>${chgList.ctrChangeCnt} 건</td>
							                        			<c:set var="chg_sum" value="${chg_sum + chgList.ctrChangeCnt}" />
						                      				</c:if>
						                    				</c:forEach>
			                                            </tr>
		                                            </c:otherwise>
												</c:choose>
				            				</c:forEach>
                                             <tr>
                                                 <td>합계</td>
                                                 <td><c:out value="${drv_sum}"/> Km</td>
                                                 <td>합계</td>
                                                 <td><c:out value="${chg_sum}"/> 건</td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">자율모드 주행거리</th>
                                                 <td colspan="2">${drvgInfo.autoDrivingDist} Km</td>
                                                 <th scope="row">일반모드 주행거리</th>
                                                 <td colspan="2">${drvgInfo.nomalDrivingDist} Km</td>
                                             </tr>
										</tbody>
									</table>
								</div>
                                 <h5 class="layout-content__subtit">제어권 전환 정보</h5>
                                 <table class="table-basic table-basic--col mt-20 table-us_du_02_view--05">
                                     <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
                                     <colgroup>
                                         <col style="width:25%">
                                         <col style="width:auto">
                                         <col style="width:20%">
                                         <col style="width:25%">
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
							                <c:forEach var="list" items="${chgDtlList}" varStatus="status">
							                  <tr>
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
                                 <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                     <button type="button" class="btn btn-width--l btn-color--white" onclick="javascript:fn_Delete('${drv_no}','${std_dt}');">삭제</button>
                                     <button type="button" class="btn btn-width--l btn-color--gray" onclick="javascript:fn_Update('${drv_no}','${std_dt}');">수정</button>
                                     <button type="button" class="btn btn-width--l btn-color--navy" onclick="javascript:fn_goList();">목록으로</button>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>

             </div>
         </div>
     </div>
 </div>
</form:form>

<!-- //container 
<form id="excelForm" name="excelForm" method="post">
  <input type="hidden" name="drv_no" id="drv_no"/>
  <input type="hidden" name="std_dt" id="std_dt"/>
</form>-->
