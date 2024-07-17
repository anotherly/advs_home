<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script type="text/javascript">
     var G_UploadID;
     var G_vertical = '\u000B'; // 파일 구분자
     var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
     
     function addAllFiles(uploadID){
    	 //alert("uploadID : "+uploadID);
    	 if(uploadID == "kupload" ){
    		// alert("uploadID1 : ");
    	 	RAONKUPLOAD.AddUploadedFile('${dtupInfo.fileSeq}', '${dtupInfo.saveNm}', '/dtup/${dtupInfo.saveNm}', '${dtupInfo.dfileSize}', 'Custom Value', uploadID);
    	 }else if(uploadID == "kupload2" ){
    		// alert("uploadID2 : ");
    		 RAONKUPLOAD.AddUploadedFile('${dtupInfo.fileSeq}', '${dtupInfo.saveNm2}', '/dtup/${dtupInfo.saveNm2}', '${dtupInfo.fileSize2}', 'Custom Value', uploadID);
    	 }
     }
     
     // 생성완료 이벤트
     function RAONKUPLOAD_CreationComplete(uploadID) {
         G_UploadID = uploadID;
         //alert("G_UploadID : "+G_UploadID);
         addAllFiles(G_UploadID);
         //DEXT5UPLOAD.AddUploadedFile(null, 'test.txt', '/dext5uploaddata/2019/10/1B4A8A73-4781-ABA6-C441-641C4359130A.txt', '5000', 'Custom Value', 'dext5upload');
     }
     
</script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";
  
  function RAONKUPLOAD_BeforeDownloadFile(uploadID, paramObj) {  //다운로드 불가 적용			        
  	return false;        
  }
  function RAONKUPLOAD_BeforeOpenFile(uploadID, paramObj){       //다운로드 불가 적용				     
      return  false;     
  }
  

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  function RAONKUPLOAD_BeforeDownloadFile(uploadID, paramObj) {  //다운로드적용
      return false;
  }
  
  /* 수정 function */
	function fn_Update(b_seq, bbs_seq) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
      c_form.b_seq.value = b_seq;
      c_form.bbs_seq.value = bbs_seq;
      c_form.action = "<c:url value='/data/upload/Data_Dtup_Updt.do'/>";
      c_form.submit();
    }
	}

	/* 삭제 function */
	function fn_Delete(b_seq, bbs_seq) {
		if(confirm("정말 삭제 하시겠습니까?")) {
      c_form.b_seq.value = b_seq;
      c_form.bbs_seq.value = bbs_seq;
			if(confirm("업로드 된 데이터와 상세정보가 모두 삭제 됩니다")) {
        c_form.action = "<c:url value='/data/upload/Data_Dtup_Delt_Process.do'/>";
        c_form.submit();
			}
		}
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm, dir_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = dir_nm;
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>My Data</i></p>
    <ul class="depth2">
      <li class=""><a href="javascript:fn_DtupView('/data/upload/Data_Dtup_Inst.do','${auth_id}','${user_id}');">데이터 업로드</a></li>
      <li class="active"><a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a></li>
      <li class=""><a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a></li>
      <li class=""><a href="/data/request/Data_Rqhs_List.do">요청이력</a></li>
      <c:if test="${auth_id eq '103' }">
        <li class=""><a href="/data/control/Data_Dtmg_List.do">데이터관리</a></li>
      </c:if>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>내가 올린 자료 상세정보</b>
      <ul>
        <li></li>
        <li>My Data</li>
        <li>내가 올린 자료</li>
        <li>내가 올린 자료 상세정보</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
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
              <th class="border_l_none">데이터 구분</th>
              <td colspan="3">${dtupInfo.bbsNm}</td>
            </tr>
            <tr>
              <th class="border_l_none">제목</th>
              <td colspan="3">${dtupInfo.bTitle}</td>
            </tr>
            <tr>
              <th class="border_l_none">내용</th>
              <td colspan="3">${dtupInfo.bContent}</td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">게시일자</th>
              <td>${dtupInfo.bFromDayView} ~ ${dtupInfo.bToDayView}</td>
              <th class="border_l_none">중요글</th>
              <td>${dtupInfo.bImportantYn}</td>
            </tr>
            -->
            <tr>
              <th class="border_l_none">주행모드</th>
              <td>${dtupInfo.drivingModeView}</td>
             <%--  <th class="border_l_none">기상상황</th>
              <td>${dtupInfo.weatherView}</td> --%>
            </tr>
            

            <tr>             
              <th class="border_l_none">기상상황</th>
              <td>${dtupInfo.weatherView}</td>              
            </tr>          
            <tr>
            <th class="border_l_none">기상상황 첨부파일</th>
            	<td colspan="3">		   
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig2 = {
			                Id: "kupload2",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                //MaxTotalFileSize: "2000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "view", // edit, view
			                ButtonBarView: "0",
			                //ButtonBarEdit: "open,download,download_all",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };
			            var upload = new RAONKUpload(uploadConfig2);				        
				    </script>	   
				</td>
            </tr>       
            
            <tr>
              <th class="border_l_none">도로상황</th>
              <td>${dtupInfo.roadSituationView}</td>
              <th class="border_l_none">도로유형</th>
              <td>${dtupInfo.roadTypeCdView}</td>
            </tr>
            <tr>
              <th class="border_l_none">거동정보유형</th>
              <td>${dtupInfo.actInfoTypeView}</td>
              <th class="border_l_none">기타</th>
              <td>${dtupInfo.etcInfo}</td>
            </tr>
            <tr>
              <th class="border_l_none">첨부파일유형</th>
              <td colspan="3">${dtupInfo.fileTypeView}</td>
            </tr>            
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td colspan="3">
			    <script type="text/javascript">
		            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
		            var uploadConfig = {
		                Id: "kupload",
		                //InitXml: "raonkupload.config.xml",
		                //SkinName: "blue",
		                Width: "930px",
		                //Height: "500px",
		                //MaxTotalFileSize: "20GB",
		                //MaxOneFileSize: "20KB",
		                MaxTotalFileCount: "1",
		                //MultiFileSelect: false,
		                //ExtensionAllowOrLimit: "0",
		                //ExtensionArr: "png",
		                ResumeUpload: "1",
		                ResumeDownload: "1",
		                FolderNameRule: "dtup",
		                //Mode: "edit", // edit, view
		                //ButtonBarEdit: "add,send,remove,remove_all",
		                Mode: "view", // edit, view
		                ButtonBarView: "0", // 0 일경우 버튼바 보이지 않음.
		                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			            UseBeforeDownloadEvent: "1",
		                UseBeforeOpenEvent: "1"
		                //ButtonBarEdit: "add,send,remove,remove_all",
		                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
		                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
		                //UploadHolder: "uploadHoder_PlaceHolder",
		                //IgnoreSameUploadName: "1",
		                //CompleteEventResetUse: "1"
		                
		                	
		            };		
			        var upload = new RAONKUpload(uploadConfig);
			    </script>              
<%--                 <c:choose>
                  <c:when test="${dtupInfo.saveNm ne null}">
                    <a href="javascript:void(0);" title="${dtupInfo.saveNm} 첨부파일입니다" onclick="fn_Download('${dtupInfo.saveNm}','dtup')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dtupInfo.saveNm}</i> [${dtupInfo.fileSizeView} Kbyte]</a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose> --%>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="table_row mt40 mb10">
        <p class="contTit1">차량정보</p>
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
              <th class="border_l_none">차량번호</th>
              <td colspan="3">${dtupInfo.vehicleId}</td>
            </tr>
            <tr>
              <th class="border_l_none">차량종류</th>
              <td>${dtupInfo.carTypeView}</td>
              <th class="border_l_none">차량모델</th>
              <td>${dtupInfo.carModel}</td>
            </tr>
            <tr>
              <th class="border_l_none">영상센서모델</th>
              <td>${dtupInfo.movieSensorModel}</td>
              <th class="border_l_none">라이다모델</th>
              <td>${dtupInfo.lidarModel}</td>
            </tr>
            <tr>
              <th class="border_l_none">레이다모델</th>
              <td>${dtupInfo.radarModel}</td>
              <th class="border_l_none">자율주행레벨</th>
              <td>${dtupInfo.autocarLevelView}</td>
            </tr>
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td colspan="3">
                <c:choose>
                  <c:when test="${dtupInfo.attachFilename ne null}">
                    <a href="javascript:void(0);" title="${dtupInfo.attachFilename} 첨부파일입니다" onclick="fn_Download('${dtupInfo.attachFilename}','vehc')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dtupInfo.attachFilename}</i> [${dtupInfo.cfileSizeView} Kbyte]</a>
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

      <div class="table_row mt40 mb10"<c:if test="${empty dtupInfo.bdwrTtlNm}"> style="display:none;"</c:if>>
        <p class="contTit1">< 데이터 셋 정보 ></p>
        <p class="right"></p>
      </div>

      <div class="table2"<c:if test="${empty dtupInfo.bdwrTtlNm}"> style="display:none;"</c:if>>
        <table summary="" class="">
          <colgroup>
            <col width="25%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">제목</th>
              <td>${dtupInfo.bdwrTtlNm}</td>
            </tr>
            <tr>
              <th class="border_l_none">내용</th>
              <td>${dtupInfo.bdwrCts}</td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">데이터 형태</th>
              <td>${dtupInfo.dataForm}</td>
            </tr>
          -->
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td>
                <c:choose>
                  <c:when test="${dtupInfo.datasetFile ne null}">
                    <a href="javascript:void(0);" title="${dtupInfo.datasetFile} 첨부파일입니다" onclick="fn_Download('${dtupInfo.datasetFile}','dset')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dtupInfo.datasetFile}</i> [${dtupInfo.dfileSizeView} Kbyte]</a>
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

      <div class="center mt20">
        <a href="javascript:fn_Update('${b_seq}','${bbs_seq}');" class="btn_sky btn_lg mr5">수정</a>
        <a href="javascript:fn_Delete('${b_seq}','${bbs_seq}');" class="btn_l_sky btn_lg mr5">삭제</a>
        <a href="/data/record/Data_Uphs_List.do" class="btn_sky btn_lg mr5">목록으로</a>
      </div>
    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
