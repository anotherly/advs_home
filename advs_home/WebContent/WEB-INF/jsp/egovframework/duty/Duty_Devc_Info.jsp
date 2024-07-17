<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
    
    $('#goToList').on('click', function(){
    	fn_goList()
    });
    
  });

  /* 수정 function */
	function fn_Update(no, id) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
      c_form.drv_no.value = no;
      c_form.chg_id.value = id;
      c_form.action = "<c:url value='/duty/device/Duty_Devc_Updt.do'/>";
      c_form.submit();
    }
	}

	/* 삭제 function */
	function fn_Delete(no, id) {
		if(confirm("정말 삭제 하시겠습니까?")) {
      c_form.drv_no.value = no;
      c_form.chg_id.value = id;
			if(confirm("등록된 장치 및 기능변경 상세정보가 모두 삭제 됩니다")) {
        c_form.action = "<c:url value='/duty/device/Duty_Devc_Delt_Process.do'/>";
        c_form.submit();
			}
		}
	}

  /* 보고서생성 function */
function fn_Report(no, id) {
	if(confirm("해당 장치 및 기능변경 정보 보고서를 생성 하시겠습니까?")) {
    	var oReport = GetfnParamSet();
    	oReport.rptname = "returnReport";
    	oReport.param("DRV_NO").value = no;
    	oReport.param("CHG_ID").value = id;
    	oReport.open();
    }
}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "devc";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }
  
function fn_goList() {
	location.href = "<c:url value='/duty/device/Duty_Devc_List.do'/>";	
}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="drv_no" id="drv_no"/>
<input type="hidden" name="chg_id" id="chg_id"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

    <!-- contents -->
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
                                        <div class="lnb-item">
                                            <a href="/duty/driving/Duty_Drvg_List.do">운행정보보고서</a>
                                        </div>
                                        <div class="lnb-item is-active ">
                                            <a href="/duty/device/Duty_Devc_List.do">장치 및 기능변경</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="layout-content">
                                    <div class="layout-content__inner">
                                        <div class="layout-content__top">
                                            <h4 class="layout-content__tit">장치 및 기능변경</h4>
                                            <ul class="location ml-auto">
                                                <li>
                                                    <img src="/image/sub/icon/icon-home.png" alt="홈">
                                                </li>
                                                <li>운행정보보고</li>
                                                <li>장치 및 기능변경</li>
                                            </ul>
                                        </div>
                                        <h5 class="layout-content__subtit d-flex align-end">
                                            상세정보
                                            <button onClick="javascript:fn_Report('${drv_no}','${chg_id}');" type="button" class="btn btn-width--m btn-color--navy ml-auto d-flex align-center justify-center">
                                            	<img src="/image/common/icon/icon-file--s.png" class="mr-10" alt="">보고서 생성
                                            </button>
                                        </h5>
                                        <div class="table-wrap">
                                            <table class="table-basic table-basic--row">
                                                <caption>운행정보보고 &gt; 운행정보보고서 &gt; 장치 및 기능변경 상세정보 테이블</caption>
                                                <colgroup>
                                                    <col style="width:18%">
                                                    <col style="width:auto">
                                                    <col style="width:18%">
                                                    <col style="width:34%">
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <th scope="row">임시운행기관</th>
                                                        <td>${devcInfo.tmpRaceAgency}</td>
                                                        <th scope="row">임시운행등록번호</th>
                                                        <td>${devcInfo.tmpRaceNumber}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <table class="table-basic table-basic--row mt-20">
                                                <caption>운행정보보고 &gt; 운행정보보고서 &gt; 장치 및 기능변경 상세정보 테이블</caption>
                                                <colgroup>
                                                    <col style="width:18%">
                                                    <col style="width:auto">
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <th scope="row">변경일자</th>
                                                        <td colspan="3">${devcInfo.modifyDateView}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <c:if test="${devcInfo.drivingModeChangeYn eq 'Y'}">
                                        <h5 class="layout-content__subtit">주행모드</h5>
                                        <div class="table-wrap">
	                                        <table class="table-basic table-basic--row mt-20 table-us_du_03_view--03">
	                                            <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
	                                            <colgroup>
	                                                <col style="width:18%">
	                                                <col style="width:auto">
	                                                <col style="width:41%">
	                                            </colgroup>
	                                            <tbody>
	                                                <tr>
	                                                    <th scope="row" rowspan="3">변경사항 사양비교</th>
	                                                    <th scope="col">변경전</th>
	                                                    <th scope="col">변경후</th>
	                                                </tr>
	                                                <tr>
	                                                    <td>${devcInfo.dmBeforeSpec}</td>
	                                                    <td>${devcInfo.dmAfterSpec}</td>
	                                                </tr>
	                                                <tr>
	                                                    <td>
	                                                    	<c:choose>
	  															<c:when test="${devcInfo.dmBeforeFilename ne null}">
	  																<a href="javascript:void(0);" title="${devcInfo.dmBeforeFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.dmBeforeFilename}')"><i class="font_lGray">${devcInfo.dmBeforeFilename}</i></a>
	  															</c:when>
	  															<c:otherwise> - </c:otherwise>
	  														</c:choose>
	  													</td>
	                                                    <td>
	                                                    	 <c:choose>
							  									<c:when test="${devcInfo.dmAfterFilename ne null}">
							  										<a href="javascript:void(0);" title="${devcInfo.dmAfterFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.dmAfterFilename}')"><i class="font_lGray">${devcInfo.dmAfterFilename}</i></a>
							  									</c:when>
							  									<c:otherwise> - </c:otherwise>
							  								</c:choose>
							  							</td>
	                                                </tr>
	                                            </tbody>
	                                        </table>
	                                    </div>
                                        </c:if>
                                        <c:if test="${devcInfo.spdRangeChangeYn eq 'Y'}">
                                        <h5 class="layout-content__subtit">작동 및 속도범위</h5>
                                        <div class="table-wrap">
	                                        <table class="table-basic table-basic--row mt-20 table-us_du_03_view--03">
	                                            <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
	                                            <colgroup>
	                                                <col style="width:18%">
	                                                <col style="width:auto">
	                                                <col style="width:41%">
	                                            </colgroup>
	                                            <tbody>
	                                                <tr>
	                                                    <th scope="row" rowspan="3">변경사항 사양비교</th>
	                                                    <th scope="col">변경전</th>
	                                                    <th scope="col">변경후</th>
	                                                </tr>
	                                                <tr>
	                                                    <td>${devcInfo.srcBeforeSpec}</td>
	                                                    <td>${devcInfo.srcAfterSpec}</td>
	                                                </tr>
	                                                <tr>
	                                                    <td>
	                                                    	<c:choose>
	  															<c:when test="${devcInfo.srcBeforeFilename ne null}">
	  																<a href="javascript:void(0);" title="${devcInfo.srcBeforeFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.srcBeforeFilename}')"><i class="font_lGray">${devcInfo.srcBeforeFilename}</i></a>
	  															</c:when>
	  															<c:otherwise> - </c:otherwise>
	  														</c:choose>
	  													</td>
	                                                    <td>
	                                                    	 <c:choose>
							  									<c:when test="${devcInfo.dcAfterFilename ne null}">
							  										<a href="javascript:void(0);" title="${devcInfo.srcAfterFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.srcAfterFilename}')"><i class="font_lGray">${devcInfo.srcAfterFilename}</i></a>
							  									</c:when>
							  									<c:otherwise> - </c:otherwise>
							  								</c:choose>
							  							</td>
	                                                </tr>
	                                            </tbody>
	                                        </table>
	                                    </div>
                                        </c:if>
                                        <c:if test="${devcInfo.deviceChangeYn eq 'Y'}">
                                        <h5 class="layout-content__subtit">구조 및 장치변경</h5>
                                        <div class="table-wrap">
	                                        <table class="table-basic table-basic--row mt-20 table-us_du_03_view--03">
	                                            <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
	                                            <colgroup>
	                                                <col style="width:18%">
	                                                <col style="width:auto">
	                                                <col style="width:41%">
	                                            </colgroup>
	                                            <tbody>
	                                                <tr>
	                                                    <th scope="row" rowspan="3">변경사항 사양비교</th>
	                                                    <th scope="col">변경전</th>
	                                                    <th scope="col">변경후</th>
	                                                </tr>
	                                                <tr>
	                                                    <td>${devcInfo.dcBeforeSpec}</td>
	                                                    <td>${devcInfo.dcAfterSpec}</td>
	                                                </tr>
	                                                <tr>
	                                                    <td>
	                                                    	<c:choose>
	  															<c:when test="${devcInfo.dcBeforeFilename ne null}">
	  																<a href="javascript:void(0);" title="${devcInfo.dcBeforeFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.dcBeforeFilename}')"><i class="font_lGray">${devcInfo.dcBeforeFilename}</i></a>
	  															</c:when>
	  															<c:otherwise> - </c:otherwise>
	  														</c:choose>
	  													</td>
	                                                    <td>
	                                                    	 <c:choose>
							  									<c:when test="${devcInfo.dcAfterFilename ne null}">
							  										<a href="javascript:void(0);" title="${devcInfo.dcAfterFilename} 첨부파일입니다" onclick="fn_Download('${devcInfo.dcAfterFilename}')"><i class="font_lGray">${devcInfo.dcAfterFilename}</i></a>
							  									</c:when>
							  									<c:otherwise> - </c:otherwise>
							  								</c:choose>
							  							</td>
	                                                </tr>
	                                            </tbody>
	                                        </table>
	                                    </div>
                                        </c:if>
                                        <div class="table-wrap">
	                                        <table class="table-basic table-basic--row table-us_du_03_view--04">
	                                            <caption>운행정보보고 &gt; 운행정보보고서 &gt; 운행정보보고서 상세정보 테이블</caption>
	                                            <colgroup>
	                                                <col style="width:18%">
	                                                <col style="width:auto">
	                                            </colgroup>
	                                            <tbody>
	                                                <tr>
	                                                    <th scope="row">변경사항 내용기술</th>
	                                                    <td>${devcInfo.changeInfo}</td>
	                                                </tr>
	                                            </tbody>
	                                        </table>
	                                    </div>
                                        <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                            <button type="button" onClick="javascript:fn_Delete('${drv_no}','${chg_id}');" class="btn btn-width--l btn-color--white">삭제</button>
                                            <button type="button" onClick="javascript:fn_Update('${drv_no}','${chg_id}');" class="btn btn-width--l btn-color--gray">수정</button>
                                            <button type="button" id="goToList" class="btn btn-width--l btn-color--navy">목록으로</button>
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
<form id="excelForm" name="excelForm" method="post">
  <input type="hidden" name="drv_no" id="drv_no"/>
  <input type="hidden" name="chg_id" id="chg_id"/>
</form>
