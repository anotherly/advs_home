<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script src="/js/clip.js"></script> <!-- ClipReport4 -->
<script type="text/javascript" src="/dext5upload/js/dext5upload.js"></script>
<script type="text/javascript">
	console.log("미사용으로 추정됨 : dext duty incd info");
     var G_UploadID;
     var G_vertical = '\u000B'; // 파일 구분자
     var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
     
     function addAllFiles(uploadID){
<c:forEach var="list" items="${videoList}" varStatus="status">
	DEXT5UPLOAD.AddUploadedFile('${list.seq}', '${list.drivingVideoFile}', '/incd/${list.drivingVideoFile}', '${list.fileSize}', 'Custom Value', uploadID);			
</c:forEach>        	
     }
     
     // 생성완료 이벤트
     function DEXT5UPLOAD_OnCreationComplete(uploadID) {
         G_UploadID = uploadID;
         addAllFiles(G_UploadID);
         //DEXT5UPLOAD.AddUploadedFile(null, 'test.txt', '/dext5uploaddata/2019/10/1B4A8A73-4781-ABA6-C441-641C4359130A.txt', '5000', 'Custom Value', 'dext5upload');
     }
     
</script>
<script type="text/javaScript" language="javascript" defer="defer">
	alert("이거 쓰냐...? : dext duty incd info");
  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 수정 function */
	function fn_Update(no, id) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
      c_form.drv_no.value = no;
      c_form.acc_id.value = id;
      c_form.action = "<c:url value='/duty/incident/Duty_Incd_Updt.do'/>";
      c_form.submit();
    }
	}

	/* 삭제 function */
	function fn_Delete(no, id) {
		if(confirm("정말 삭제 하시겠습니까?")) {
      c_form.drv_no.value = no;
      c_form.acc_id.value = id;
			if(confirm("등록된 사고 상세정보가 모두 삭제 됩니다")) {
        c_form.action = "<c:url value='/duty/incident/Duty_Incd_Delt_Process.do'/>";
        c_form.submit();
			}
		}
	}

  /* 보고서생성 function */
	function fn_Excel(no, id) {
    if(confirm("해당 사고 정보 보고서를 생성 하시겠습니까?")) {
      document.excelForm.drv_no.value = no;
      document.excelForm.acc_id.value = id;
      var url = "/duty/incident/Duty_Incd_Excel_Process.do";
    	$("#excelForm").attr("action", url);
    	$("#excelForm").submit();
    }
  }
  
	  /* 보고서생성 function */
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

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="drv_no" id="drv_no"/>
<input type="hidden" name="acc_id" id="acc_id"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)  
  	String cMenuId = "C1000";
  	String pMenuId = "C0000";
  %>
  <jsp:include page="/include/Left.jsp">
  	<jsp:param value="<%=cMenuId %>" name="cMenuId"/>
  	<jsp:param value="<%=pMenuId %>" name="pMenuId"/>
  </jsp:include>

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>교통사고 상세정보</b>
      <ul>
        <li></li>
        <li>운행정보 보고</li>
        <li>교통사고</li>
        <li>교통사고 상세정보</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="table_row mb10">
        <p class="contTit1">기관정보</p>
        <p class="right"></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="">
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

      <div class="table_row mt40 mb10">
        <p class="contTit1">사고개요</p>
        <p class="right"></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="">
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

      <div class="table_row mt40 mb10">
        <p class="contTit1">자율주행 자동차</p>
        <p class="right"></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="">
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
              <td>${incdInfo.autocarSpeed} Km/h</td>
              <th>승차인원</th>
              <td>${incdInfo.autocarRideNumber} 명</td>
            </tr>
            <tr>
              <th class="border_l_none">적재량</th>
              <td>${incdInfo.autocarLoadVol} Kg</td>
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
          <div class="table_row mt40 mb10">
            <p class="contTit1 pt15">등록된 사고차량이 없습니다.</p>
            <p class="right"></p>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="list" items="${carList}" varStatus="status">

            <div class="table_row mt40 mb10">
              <p class="contTit1 pt15">사고차량${status.count}</p>
              <p class="right"></p>
            </div>

            <div class="table2">
              <table summary="" class="">
                <colgroup>
                  <col width="15%">
                  <col width="35%">
                  <col width="15%">
                  <col width="">
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
                    <td>${list.acccarSpeed} Km/h</td>
                    <th>사고차승차인원</th>
                    <td>${list.acccarRideNumber} 명</td>
                  </tr>
                  <tr>
                    <th class="border_l_none">사고차적재량</th>
                    <td>${list.acccarLoadVol} Kg</td>
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

      <div class="table2 mt40">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">사고상세묘사</th>
              <td>${incdInfo.accDetailInfo}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="table_row mt40 mb10">
        <p class="contTit1">첨부서류</p>
        <p class="right"></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="25%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">운행정보</th>
              <td>
                <c:choose>
                  <c:when test="${incdInfo.drivingInfoFile ne null}">
                    <a href="javascript:void(0);" title="${incdInfo.drivingInfoFile} 첨부파일입니다" onclick="fn_Download('${incdInfo.drivingInfoFile}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${incdInfo.drivingInfoFile}</i></a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">사고기록장치 저장데이터</th>
              <td>
                <c:choose>
                  <c:when test="${incdInfo.accRecDeviceFile ne null}">
                    <a href="javascript:void(0);" title="${incdInfo.accRecDeviceFile} 첨부파일입니다" onclick="fn_Download('${incdInfo.accRecDeviceFile}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${incdInfo.accRecDeviceFile}</i></a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="table2 mt40">
        <table summary="" class="">
          <colgroup>
            <col width="25%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">기타첨부파일</th>
              <td>
                <c:choose>
                  <c:when test="${incdInfo.etcFilename ne null}">
                    <a href="javascript:void(0);" title="${incdInfo.etcFilename} 첨부파일입니다" onclick="fn_Download('${incdInfo.etcFilename}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${incdInfo.etcFilename}</i></a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="table_row mt40 mb10">
        <p class="contTit1 pt15">주행영상 데이터</p>
      </div>    
      <div class="table2">
		    <script type="text/javascript">
		        DEXT5UPLOAD.config.Width = '930px';
		        DEXT5UPLOAD.config.ResumeUpload = '1';
		        DEXT5UPLOAD.config.ResumeDownload = '1';
		        DEXT5UPLOAD.config.Mode = 'view'; // edit, view
		        //DEXT5UPLOAD.config.ButtonBarEdit = "add,send,open,download,remove,remove_all";
	            // 업로드 완료 이벤트 안에서 reset API를 호출 시키기 위한 설정값
	            //DEXT5UPLOAD.config.CompleteEventResetUse = '1';
		        
		        var upload = new Dext5Upload("dext5upload");
		    </script>
		</div>   
<%--       <div class="table_row mt40 mb10">
        <p class="contTit1 pt15">주행영상 데이터</p>
        <p class="right"></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="25%">
            <col width="">
          </colgroup>
          <tbody>

            <c:choose>
              <c:when test="${videoList eq null || empty videoList}">
                <tr>
                  <td colspan="3" class="border_l_none">등록된 영상이 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${videoList}" varStatus="status">
                  <tr>
                    <th class="border_l_none">주행영상${status.count}</th>
                    <td class="left border_l_none lh_sm">
                      <c:choose>
                        <c:when test="${list.drivingVideoFile ne null}">
                          <a href="javascript:void(0);" title="${list.drivingVideoFile} 첨부파일입니다" onclick="fn_Download('${list.drivingVideoFile}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${list.drivingVideoFile}</i> [${list.fileSizeView} Kbyte]</a>
                        </c:when>
                        <c:otherwise>
                          -
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>

          </tbody>
        </table>
      </div> --%>
      
</form:form>

      <div class="center mt20">
        <a href="javascript:fn_Update('${drv_no}','${acc_id}');" class="btn_sky btn_lg mr5">수정</a>
        <a href="javascript:fn_Delete('${drv_no}','${acc_id}');" class="btn_l_sky btn_lg mr5">삭제</a>
        <%-- <a href="javascript:fn_Excel('${drv_no}','${acc_id}');" class="btn_l_gray btn_lg mr5">보고서생성</a> --%>
        <a href="javascript:fn_Report('${drv_no}','${acc_id}');" class="btn_l_gray btn_lg mr5">보고서생성</a>
        <a href="/duty/incident/Duty_Incd_List.do" class="btn_sky btn_lg mr5">목록으로</a>
      </div>
    </div>
    <!-- //contents -->

  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
<form id="excelForm" name="excelForm" method="post">
  <input type="hidden" name="drv_no" id="drv_no"/>
  <input type="hidden" name="acc_id" id="acc_id"/>
</form>
