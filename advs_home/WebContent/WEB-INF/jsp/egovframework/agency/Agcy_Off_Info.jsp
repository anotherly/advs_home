<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
//String user_id = (String)session.getAttribute("user_id");
//String agcy_nm = (String)session.getAttribute("agcy_nm");
//boolean login = user_id == null ? false: true;
%>
<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
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

	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	}
	
	/* 보고서생성 function */
	function fn_Report() {
		if(confirm("데이터 공유 신청서를 출력 하시겠습니까?")) {
			var oReport = GetfnParamSet();			
			
			oReport.rptname = "Agcy_Off_Inst";
	    	oReport.param("bizrNo").value = $("#bizrNo").val();
	    	oReport.param("agcy_nm").value = $("#reqOrg").val();
	    	oReport.param("orgAddr").value = $("#orgAddr").val();
	    	oReport.param("scenario_cd").value = $("#scenarioCd").val();
	    	oReport.param("scenario_nm").value =$("#scenarioNm").val();
	    	oReport.param("car_cd").value = $("#carNm").val();
	    	oReport.param("docTit").value = $("#docTit").val();
	    	oReport.param("docCnt").value = $("#docCnt").val();
	    	oReport.param("prcuseMthd").value = $("#prcuseMthd").val();
	    	oReport.param("dsrVstDt").value = $("#dsrVstDt").val();
	    	oReport.param("orgAddr").value = $("#orgAddr").val();
	    	oReport.open();
		}
	}
</script>

<form:form id="listForm" name="listForm" method="post">
	<input type="hidden" name="scenarioCd" id="scenarioCd" value="${offInfo.scenarioCd}"/>
	<input type="hidden" name="scenarioNm" id="scenarioNm" value="${offInfo.scenarioNm}"/>
	<input type="hidden" name="bizrNo" id="bizrNo" value="${offInfo.bizrNo}"/>
	<input type="hidden" name="reqOrg" id="reqOrg" value="${offInfo.reqOrg}"/>
	<input type="hidden" name="orgAddr" id="orgAddr" value="${offInfo.orgAddr}"/>
	<input type="hidden" name="docTit" id="docTit" value="${offInfo.docTit}"/>
	<input type="hidden" name="docCnt" id="docCnt" value="${offInfo.docCnt}"/>
	<input type="hidden" name="prcuseMthd" id="prcuseMthd" value="${offInfo.prcuseMthd}"/>
	<input type="hidden" name="dsrVstDt" id="dsrVstDt" value="${offInfo.dsrVstDt}"/>
	<input type="hidden" name="orgAddr" id="orgAddr" value="${offInfo.orgAddr}"/>
	<input type="hidden" name="carNm" id=carNm value="${offInfo.carNm}"/>
</form:form>
	<div class="container">
		<div class="container__inner">
			<div class="content">
				<div class="content__inner">
				
					<div class="layout-container layout-full">
						<div class="layout-container__inner layout-container--row">
							<div class="lnb">
								<h3 class="lnb__tit">협의체데이터</h3>
								<div class="lnb-list">
									<div class="lnb-item <c:if test="${bbs_seq eq '2080'}">is-active</c:if>"><a href="/open/normal/Open_Normal_List.do?bbs_seq=2080">일반시나리오 데이터셋</a></div>
									<div class="lnb-item <c:if test="${bbs_seq eq '2090'}">is-active</c:if>"><a href="/open/edge/Open_Edge_List.do?bbs_seq=2090">엣지케이스 시나리오<br/>데이터셋</a></div>
									<div class="lnb-item <c:if test="${bbs_seq eq '2100'}">is-active</c:if>"><a href="/open/v2x/Open_V2x_List.do?bbs_seq=2100">V2X 데이터셋</a></div>
									<div class="lnb-item is-active"><a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br/>안내 및 신청</a></div>
							        	<div class="lnb-item">
								            <a href="/agency/consultative/Agcy_Dset_List.do">데이터셋(21년 이전)</a>
								            <ul class="lnb-depth--02 lists lists-cir--s">
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010">차량거동정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030">센서정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040">자율주행 학습정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050">융합정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060">V2X 정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070">기타자율주행정보</a>
					                            </li>
					                            <li>
					                                <a href="/agency/consultative/Agcy_Dset_List.do">데이터셋</a>
					                            </li>
								            </ul>
								        </div>
							    </div>
							</div>
							<div class="layout-content">
								<div class="layout-content__inner">
									<div class="layout-content__top">
										<h4 class="layout-content__tit">오프라인 공유 안내 및 신청</h4>
										<ul class="location ml-auto">
											<li>
	                                           	<img src="/image/sub/icon/icon-home.png" alt="홈">
	                                           </li>
											<li>협의체데이터</li>
											<li>오프라인 공유 안내 및 신청</li>
										</ul>
									</div>
									<h5 class="layout-content__subtit">신청상세</h5>
									<button type="button" class="btn btn-width--m btn-color--navy ml-auto d-flex align-center justify-center" onclick="javascript:fn_Report('${drv_no}','${std_dt}');">
	                                    <img src="/image/common/icon/icon-file--s.png" class="mr-10" alt="">보고서 생성
	                                </button>
									<div class="table-wrap">
	                                    <table class="table-basic table-basic--row">
	                                        <caption>데이터 공유 신청 &gt; 데이터 공유 신청 테이블</caption>
	                                        <colgroup>
	                                            <col style="width:18%">
	                                            <col style="width:auto">
	                                            <col style="width:18%">
	                                            <col style="width:34%">
	                                        </colgroup>
	                                        <tbody>
	                                        	<tr>
	                                                <th scope="row">
	                                                   	 신청기관
	                                                </th>
	                                                <td>
	                                                	${offInfo.reqOrg}
	                                                </td>
	                                                <th scope="row">
	                                                	사업자등록번호
	                                                </th>
	                                                <td>
	                                                	${offInfo.bizrNo}
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                	기관주소
	                                                </th>
	                                                <td colspan="3">
	                                                	${offInfo.orgAddr}
	                                                </td>
	                                            </tr>
	                                            <%-- <tr>
	                                                <th scope="row">
	                                                	시나리오 데이터셋
	                                                </th>
	                                                <td colspan="3">
	                                                	${offInfo.orgAddr}
	                                                </td>
	                                            </tr> --%>
	                                            <tr>
	                                                <th scope="row">
	                                                	시나리오 코드
	                                                </th>
	                                                <td colspan="3">
	                                                	${offInfo.scenarioNm}(${offInfo.scenarioCd})
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                	수집차량 모델
	                                                </th>
	                                                <td colspan="3">
	                                                	${offInfo.carNm}
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                    	공유 데이터 제목
	                                                </th>
	                                                <td colspan="3">
	                                                    ${offInfo.docTit}
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                    	이용목적
	                                                </th>
	                                                <td colspan="3">
	                                                    ${offInfo.docCnt}
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                    	활용방안
	                                                </th>
	                                                <td colspan="3">
	                                                    ${offInfo.prcuseMthd}
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                    	희망 방문일시
	                                                </th>
	                                                <td colspan="3">
	                                                    ${offInfo.dsrVstDt}
	                                                </td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                
									<div class="btn-wrap btn-row justify-center mt-30 mb-80">
<%-- 										<button type="button" onClick="javascript:fn_Delete('${drv_no}','${acc_id}');" class="btn btn-width--l btn-color--white">취소</button>  --%>
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


