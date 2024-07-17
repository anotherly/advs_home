<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
   <script type="text/javascript">
     var G_UploadID;
     var G_vertical = '\u000B'; // 파일 구분자
     var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
     
     function addAllFiles(uploadID){
    	 var i = 0;
    	 var fileName = "";
    	 var filePath = "";
    	 var fileSize = "";
		<c:forEach var="list" items="${videoList}" varStatus="status">
			RAONKUPLOAD.AddUploadedFile('${list.seq}', '${list.drivingVideoFile}', '/incd/${list.drivingVideoFile}', '${list.fileSize}', 'Custom Value', uploadID);
			if(i == 0){
				fileName += '${list.drivingVideoFile}';
				filePath += '/incd/${list.drivingVideoFile}';
				fileSize += '${list.fileSize}';
			}else{
				fileName += ',' + '${list.drivingVideoFile}';
				filePath += ',' + '/incd/${list.drivingVideoFile}';
				fileSize += ',' + '${list.fileSize}';
			}
			i++;
		</c:forEach>
        $("#fileName").val(fileName);
        $("#filePath").val(filePath);
        $("#fileSize").val(fileSize);
        
     }
     
     // 생성완료 이벤트
     function RAONKUPLOAD_CreationComplete(uploadID) {
         G_UploadID = uploadID;
         addAllFiles(G_UploadID);
     }
     
     
     // 전송완료 이벤트
     function RAONKUPLOAD_UploadComplete(uploadID) {
         G_UploadID = uploadID;

         var file_list = RAONKUPLOAD.GetListInfo("json", G_UploadID);
			
         var originalName = new Array();
         var fileSize = new Array();
         var filePath = new Array();

         var arIdx = 0;
         // 기존에 있던 업로드된 파일 리스트를 모두 가져옴.
         var jsonAll = file_list.webFile;
         
         // 새로 업로드된 파일 정보를 가져옴.
         var jsonNew = file_list.newFile;
			
         // 삭제된 파일 정보를 가져옴.(사용은 하지 않음)
         var jsonDel = file_list.deleteFile;

         // 아래 로직에서 새롭게 리스트를 추가하기 위해서 현재 업로드 리스트를 초기화 시킴
         RAONKUPLOAD.ResetUpload(G_UploadID);
         // 기존에 추가되어 있는 webFile을 다시 추가하기 위한 로직.
         if (jsonAll != null) {
             var jsonWebFile = jsonAll;
             var jsonWebFileLength = jsonWebFile.uploadPath.length;
             for (var i = 0; i < jsonWebFileLength; i++) {
             	originalName[arIdx] = jsonWebFile.originalName[i];
             	fileSize[arIdx] = jsonWebFile.size[i];
             	filePath[arIdx++] = jsonWebFile.uploadPath[i];
             	RAONKUPLOAD.AddUploadedFile(jsonWebFile.order[i], jsonWebFile.originalName[i], jsonWebFile.uploadPath[i], jsonWebFile.size[i], '', uploadID);
             }
         }

         // 새로 업로드된 파일을 webFile로 새롭게 추가하기 위한 로직
         if (jsonNew != null) {
             var jsonNewLength = jsonNew.uploadPath.length;

             for (var i = 0; i < jsonNewLength; i++) {
                 // 여기서 첫번째 파라미터인 uniqkey 값은 db 처리 후 db의 seq값을 넣으시거나 특정 uniq 값으로 넣으시면 됩니다.
             	originalName[arIdx] = jsonNew.originalName[i];
             	fileSize[arIdx] = jsonNew.size[i];
             	filePath[arIdx++] = jsonNew.uploadPath[i];
                 RAONKUPLOAD.AddUploadedFile(jsonNew.order[i], jsonNew.originalName[i], jsonNew.uploadPath[i], jsonNew.size[i], '', uploadID);
             }
         }
         
         $("#fileName").val(originalName);
         $("#fileSize").val(fileSize);
         $("#filePath").val(filePath);
     }
     
     function RAONKUPLOAD_BeforeDeleteFile(uploadID, paramObj) {
     	// 파일 삭제 전 처리할 내용
         if("1" == paramObj.strIsWebFile){
	    	 var fileName = $("#fileName").val();
	    	 var filePath = $("#filePath").val();
	    	 var fileSize = $("#fileSize").val();
	    	 
	    	 var nameAr = fileName.split(",");
	    	 var pathAr = filePath.split(",");
	    	 var sizeAr = fileSize.split(",");
	    	 
	    	 var reName = "";
	    	 var rePath = "";
	    	 var reSize = "";
	    	 var cnt = 0;
	    	 for(var i=0; i<pathAr.length; i++){
	    		 if(pathAr[i] != paramObj.strPath){
	    			 if(cnt == 0){
	    				 reName += nameAr[i];
	    				 rePath += pathAr[i];
	    				 reSize += sizeAr[i];
	    			 }else{
	    				 reName += "," + nameAr[i];
	    				 rePath += "," + pathAr[i];
	    				 reSize += "," + sizeAr[i];
	    			 }
	    			 cnt++;
	    		 }
	    	 }
	         $("#fileName").val(reName);
	         $("#fileSize").val(reSize);
	         $("#filePath").val(rePath);
         }
         
         return true;
     }  
</script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

    //달력 이벤트
		$( "#acc_date_d" ).datepicker({
				dateFormat: 'yy-mm-dd',
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				changeMonth: true,
				changeYear: true,
				showOn: "button",
				buttonImage: "/css/avsc/images/icon_calendar.png",
				showMonthAfterYear: true,
				showOtherMonths: true,
				selectOtherMonths: true,
				maxDate : "+12m"
		});
  });

  /* 등록 function */
	function fn_Save(no, id) {
		if(confirm("저장 하시겠습니까?")) {
      oEditors.getById["acc_detail_info"].exec("UPDATE_CONTENTS_FIELD", []);
      c_form.drv_no.value = no;
      c_form.acc_id.value = id;

      if(trim(c_form.acc_date_d.value).length==0){
				alert("사고일시를 입력해주세요");
				c_form.acc_date_d.value="";
				c_form.acc_date_d.focus();
				return;
			}

      if(trim(c_form.place.value).length==0){
				alert("사고장소를 입력해주세요");
				c_form.place.value="";
				c_form.place.focus();
				return;
			}

			var weather = $("#weather option:selected").val();
			if(weather == "") {
				alert("기상상황을 선택해주세요");
				c_form.weather.focus();
				return;
			}

      var road_situation = $("#road_situation option:selected").val();
			if(road_situation == "") {
				alert("도로상황을 선택해주세요");
				c_form.road_situation.focus();
				return;
			}

      var road_type_cd = $("#road_type_cd option:selected").val();
			if(road_type_cd == "") {
				alert("도로유형을 선택해주세요");
				c_form.road_type_cd.focus();
				return;
			}

      var autocar_driving_mode = $("#autocar_driving_mode option:selected").val();
			if(autocar_driving_mode == "") {
				alert("주행모드를 선택해주세요");
				c_form.autocar_driving_mode.focus();
				return;
			}

      var autocar_driving_status_cd = $("#autocar_driving_status_cd option:selected").val();
			if(autocar_driving_status_cd == "") {
				alert("주행상태를 선택해주세요");
				c_form.autocar_driving_status_cd.focus();
				return;
			}

      if(trim(c_form.file_info.value).length>0) {
        if(!fileSizeCheck(c_form.file_info, 100)) return c_form.file_info.focus();
			}
      if(trim(c_form.file_rec.value).length>0) {
        if(!fileSizeCheck(c_form.file_rec, 100)) return c_form.file_rec.focus();
			}
      if(trim(c_form.file_etc.value).length>0) {
        if(!fileSizeCheck(c_form.file_etc, 100)) return c_form.file_etc.focus();
			}

      $("#btn_sm").hide();
      $("#loading").show();

			document.listForm.action = "<c:url value='/duty/incident/Duty_Incd_Updt_Process.do'/>";
			document.listForm.submit();
		}
	}

  function move_new() {
    if(confirm("기존 등록된 영상파일을 전부 삭제하고 신규로 등록 하시겠습니까?")) {
      c_form.mov_new.value = "Y";
      $("#mov_view").hide();
      $("#mov_inst").show();
    }
  }

  function fn_accCarEvent(obj) {
    var idx = $("select[id=acccar_car_type]").index(obj);
    //alert($(obj).val());
    if($(obj).val() == '102') {
      $("select[id=acccar_driving_mode]:eq("+idx+")").val("102").attr("selected","selected");
    }
  }

</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="drv_no" id="drv_no"/>
<input type="hidden" name="acc_id" id="acc_id"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="mov_new" id="mov_new"/>
<input type="hidden" name="fileName" id="fileName"/>
<input type="hidden" name="fileSize" id="fileSize"/>
<input type="hidden" name="filePath" id="filePath"/>
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

  <div class="contWrap">
    <div class="location">
      <b>교통사고 등록</b>
      <ul>
        <li></li>
        <li>운행정보 보고</li>
        <li>교통사고</li>
        <li>교통사고 등록</li>
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
              <th class="border_l_none"><b class="font_red">*</b> 임시운행등록번호</th>
              <td>${incdInfo.tmpRaceNumber}</td>
              <th>임시운행기관</th>
              <td><input type="text" class="w100p input_50per" readonly="" id="tmp_race_agency" name="tmp_race_agency" value="${incdInfo.tmpRaceAgency}"></td>
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
              <th class="border_l_none"><b class="font_red">*</b> 사고일시</th>
              <td>
                <c:set var="ac_date" value="${incdInfo.accDateView}" />
                <input type="text" readonly="" class="w30p" id="acc_date_d" name="acc_date_d" value="${fn:substring(ac_date,0,10)}">
                <select title="사고일_시간" name="acc_date_h" id="acc_date_h" class="mr10">
                  <c:forEach var="list" begin="0" end="23" varStatus="loop">
                    <c:choose>
                      <c:when test="${loop.index < 10}">
                        <c:set var="dateHH" value="0${loop.index}" />
                      </c:when>
                      <c:otherwise>
                        <c:set var="dateHH" value="${loop.index}" />
                      </c:otherwise>
                    </c:choose>
                    <option value='${dateHH}' <c:if test="${dateHH eq fn:substring(ac_date,11,13)}">selected</c:if>>${dateHH}</option>
                  </c:forEach>
                </select> 시
                <select title="사고일_분" name="acc_date_m" id="acc_date_m"  class="mr10">
                  <c:forEach var="list" begin="0" end="59" varStatus="loop">
                    <c:choose>
                      <c:when test="${loop.index < 10}">
                        <c:set var="dateMM" value="0${loop.index}" />
                      </c:when>
                      <c:otherwise>
                        <c:set var="dateMM" value="${loop.index}" />
                      </c:otherwise>
                    </c:choose>
                    <option value='${dateMM}' <c:if test="${dateMM eq fn:substring(ac_date,14,16)}">selected</c:if>>${dateMM}</option>
                  </c:forEach>
                </select> 분
              </td>
              <th><b class="font_red">*</b> 사고장소</th>
              <td><input type="text" class="w100p" id="place" name="place" value="${incdInfo.place}" onkeyup="checkLength(this,250)"></td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 기상상황</th>
              <td>
                <select id="weather" name="weather" class="w100p">
                  <c:choose>
                    <c:when test="${code_weather eq null || empty code_weather}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_weather }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.weather}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th><b class="font_red">*</b> 도로상황</th>
              <td>
                <select id="road_situation" name="road_situation" class="w100p">
                  <c:choose>
                    <c:when test="${code_road_situation eq null || empty code_road_situation}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_road_situation }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.roadSituation}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">도로유형</th>
              <td>
                <select id="road_type_cd" name="road_type_cd" class="w100p">
                  <c:choose>
                    <c:when test="${code_road_type_cd eq null || empty code_road_type_cd}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_road_type_cd }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.roadTypeCd}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th></th>
              <td></td>
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
              <th class="border_l_none"><b class="font_red">*</b> 주행모드</th>
              <td>
                <select id="autocar_driving_mode" name="autocar_driving_mode" class="w100p">
                  <c:choose>
                    <c:when test="${code_driving_mode eq null || empty code_driving_mode}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_driving_mode }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.autocarDrivingMode}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th><b class="font_red">*</b> 주행상태</th>
              <td>
                <select id="autocar_driving_status_cd" name="autocar_driving_status_cd" class="w100p">
                  <c:choose>
                    <c:when test="${code_driving_status_cd eq null || empty code_driving_status_cd}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_driving_status_cd }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.autocarDrivingStatusCd}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">운행속도</th>
              <td>
                <input type="text" class="w35p"  id="autocar_speed" name="autocar_speed" maxlength="3" style="ime-mode:disabled;" value="${incdInfo.autocarSpeed}" onkeypress="return numbersonly(event, false, this, 3)"> km/h
              </td>
              <th>승차인원</th>
              <td>
                <input type="text" class="w35p"  id="autocar_ride_number" name="autocar_ride_number" maxlength="3" style="ime-mode:disabled;" value="${incdInfo.autocarRideNumber}" onkeypress="return numbersonly(event, false, this, 3)"> 명
              </td>
            </tr>
            <tr>
              <th class="border_l_none">적재량</th>
              <td>
                <input type="text" class="w40p"  id="autocar_load_vol" name="autocar_load_vol" maxlength="7" style="ime-mode:disabled;" value="${incdInfo.autocarLoadVol}" onkeypress="return numbersonly(event, false, this, 7)"> Kg
              </td>
              <th>파손정도</th>
              <td>
                <select id="autocar_damage" name="autocar_damage" class="w40p">
                  <c:choose>
                    <c:when test="${code_damage eq null || empty code_damage}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_damage }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.autocarDamage}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">인적피해</th>
              <td colspan="3">
                <select id="human_injury_type" name="human_injury_type" class="w10p">
                  <c:choose>
                    <c:when test="${code_injury_type eq null || empty code_injury_type}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_injury_type }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.humanInjuryType}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
                성별
                <select id="autocar_human_sex" name="autocar_human_sex" class="mr10">
                  <c:choose>
                    <c:when test="${code_human_sex eq null || empty code_human_sex}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_human_sex }" varStatus="loop">
                        <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq incdInfo.autocarHumanSex}">selected</c:if>>${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
                나이
                <select id="autocar_human_age" name="autocar_human_age" class="mr10">
                  <c:forEach var="list" begin="19" end="90" varStatus="loop">
                    <c:set var="age" value="${loop.index}" />
                    <option value='${age}' <c:if test="${age eq incdInfo.autocarHumanAge}">selected</c:if>>${age}</option>
                  </c:forEach>
                </select>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="table_row mt40 mb10">
        <p class="contTit1 pt15">사고차량</p>
        <p class="right">
          <span id="tb_plus"><a href="javascript:void(0);" class="btn_md btn_plus"></a></span>
          <span id="tb_minus"><a href="javascript:void(0);" class="btn_md btn_minus"></a></span>
        </p>
      </div>

      <div id="tb_acc" class="table2">

        <c:choose>
          <c:when test="${carList eq null || empty carList}">
            <table id="tb_acc_sub" summary="" class="">
              <colgroup>
                <col width="15%">
                <col width="35%">
                <col width="15%">
                <col width="">
              </colgroup>
              <tbody>
                <tr>
                  <th class="border_l_none">사고차량종류</th>
                  <td>
                    <select id="acccar_car_type" name="acccar_car_type" class="w100p" onchange="javascript:fn_accCarEvent(this)">
                      <c:choose>
                        <c:when test="${code_car_type eq null || empty code_car_type}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <option value="">-사고차없음-</option>
                          <c:forEach var="list" items="${code_car_type }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </td>
                  <th></th>
                  <td></td>
                </tr>
                <tr>
                  <th class="border_l_none">사고차주행모드</th>
                  <td>
                    <select id="acccar_driving_mode" name="acccar_driving_mode" class="w100p">
                      <c:choose>
                        <c:when test="${code_driving_mode2 eq null || empty code_driving_mode2}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="list" items="${code_driving_mode2 }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </td>
                  <th>사고차주행상태</th>
                  <td>
                    <select id="acccar_driving_status_cd" name="acccar_driving_status_cd" class="w100p">
                      <c:choose>
                        <c:when test="${code_driving_status_cd2 eq null || empty code_driving_status_cd2}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="list" items="${code_driving_status_cd2 }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th class="border_l_none">사고차운행속도</th>
                  <td>
                    <input type="text" class="w35p"  id="acccar_speed" name="acccar_speed" maxlength="3" style="ime-mode:disabled;" onkeypress="return numbersonly(event, false, this, 3)"> km/h
                  </td>
                  <th>사고차승차인원</th>
                  <td>
                    <input type="text" class="w35p"  id="acccar_ride_number" name="acccar_ride_number" maxlength="3" style="ime-mode:disabled;" onkeypress="return numbersonly(event, false, this, 3)"> 명
                  </td>
                </tr>
                <tr>
                  <th class="border_l_none">사고차적재량</th>
                  <td>
                    <input type="text" class="w40p"  id="acccar_load_vol" name="acccar_load_vol" maxlength="7" style="ime-mode:disabled;" onkeypress="return numbersonly(event, false, this, 7)"> Kg
                  </td>
                  <th>사고차파손정도</th>
                  <td>
                    <select id="acccar_damage" name="acccar_damage" class="w40p">
                      <c:choose>
                        <c:when test="${code_damage2 eq null || empty code_damage2}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="list" items="${code_damage2 }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </td>
                </tr>
                <tr>
                  <th class="border_l_none">사고차인적피해</th>
                  <td colspan="3">
                    <select id="acccar_human_injury_type" name="acccar_human_injury_type" class="w10p">
                      <c:choose>
                        <c:when test="${code_injury_type eq null || empty code_injury_type}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="list" items="${code_injury_type }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                    성별
                    <select id="acccar_human_sex" name="acccar_human_sex" class="mr10">
                      <c:choose>
                        <c:when test="${code_human_sex2 eq null || empty code_human_sex2}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <c:forEach var="list" items="${code_human_sex2 }" varStatus="loop">
                            <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                    나이
                    <select id="acccar_human_age" name="acccar_human_age" class="mr10">
                      <c:forEach var="list" begin="19" end="90" varStatus="loop">
                        <c:set var="age" value="${loop.index}" />
                        <option value='${age}' >${age}</option>
                      </c:forEach>
                    </select>
                  </td>
                </tr>
              </tbody>
            </table>
          </c:when>
          <c:otherwise>
            <c:forEach var="carList" items="${carList}" varStatus="status">

              <table id="tb_acc_sub" summary="" class="">
                <colgroup>
                  <col width="15%">
                  <col width="35%">
                  <col width="15%">
                  <col width="">
                </colgroup>
                <tbody>
                  <tr>
                    <th class="border_l_none">사고차량종류</th>
                    <td>
                      <select id="acccar_car_type" name="acccar_car_type" class="w100p">
                        <c:choose>
                          <c:when test="${code_car_type eq null || empty code_car_type}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <option value="">-사고차없음-</option>
                            <c:forEach var="list" items="${code_car_type }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.acccarCarType}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                    </td>
                    <th></th>
                    <td></td>
                  </tr>
                  <tr>
                    <th class="border_l_none">사고차주행모드</th>
                    <td>
                      <select id="acccar_driving_mode" name="acccar_driving_mode" class="w100p">
                        <c:choose>
                          <c:when test="${code_driving_mode2 eq null || empty code_driving_mode2}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="list" items="${code_driving_mode2 }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.acccarDrivingMode}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                    </td>
                    <th>사고차주행상태</th>
                    <td>
                      <select id="acccar_driving_status_cd" name="acccar_driving_status_cd" class="w100p">
                        <c:choose>
                          <c:when test="${code_driving_status_cd2 eq null || empty code_driving_status_cd2}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="list" items="${code_driving_status_cd2 }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.acccarDrivingStatusCd}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th class="border_l_none">사고차운행속도</th>
                    <td>
                      <input type="text" class="w35p"  id="acccar_speed" name="acccar_speed" maxlength="3" style="ime-mode:disabled;" value="${carList.acccarSpeed}" onkeypress="return numbersonly(event, false, this, 3)"> km/h
                    </td>
                    <th>사고차승차인원</th>
                    <td>
                      <input type="text" class="w35p"  id="acccar_ride_number" name="acccar_ride_number" maxlength="3" style="ime-mode:disabled;" value="${carList.acccarRideNumber}" onkeypress="return numbersonly(event, false, this, 3)"> 명
                    </td>
                  </tr>
                  <tr>
                    <th class="border_l_none">사고차적재량</th>
                    <td>
                      <input type="text" class="w40p"  id="acccar_load_vol" name="acccar_load_vol" maxlength="7" style="ime-mode:disabled;" value="${carList.acccarLoadVol}" onkeypress="return numbersonly(event, false, this, 7)"> Kg
                    </td>
                    <th>사고차파손정도</th>
                    <td>
                      <select id="acccar_damage" name="acccar_damage" class="w40p">
                        <c:choose>
                          <c:when test="${code_damage2 eq null || empty code_damage2}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="list" items="${code_damage2 }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.acccarDamage}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th class="border_l_none">사고차인적피해</th>
                    <td colspan="3">
                      <select id="acccar_human_injury_type" name="acccar_human_injury_type" class="w10p">
                        <c:choose>
                          <c:when test="${code_injury_type eq null || empty code_injury_type}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="list" items="${code_injury_type }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.humanInjuryType}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                      성별
                      <select id="acccar_human_sex" name="acccar_human_sex" class="mr10">
                        <c:choose>
                          <c:when test="${code_human_sex2 eq null || empty code_human_sex2}">
                            <option value="">-</option>
                          </c:when>
                          <c:otherwise>
                            <c:forEach var="list" items="${code_human_sex2 }" varStatus="loop">
                              <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq carList.acccarHumanSex}">selected</c:if>>${list.codeDetlNm}</option>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                      </select>
                      나이
                      <select id="acccar_human_age" name="acccar_human_age" class="mr10">
                        <c:forEach var="list" begin="19" end="90" varStatus="loop">
                          <c:set var="age" value="${loop.index}" />
                          <option value='${age}' <c:if test="${age eq carList.acccarHumanAge}">selected</c:if>>${age}</option>
                        </c:forEach>
                      </select>
                    </td>
                  </tr>
                </tbody>
              </table>

            </c:forEach>
          </c:otherwise>
        </c:choose>

      </div>

      <div class="table2 mt40">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">사고상세묘사</th>
              <td>
                <textarea title="사고상세묘사 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="acc_detail_info" id="acc_detail_info" title="">${incdInfo.accDetailInfo}</textarea>
              </td>
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
              <th class="border_l_none" rowspan="2">운행정보</th>
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
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_info" id="file_info" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_a" id="filename_a" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_info" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
            <tr>
              <th class="border_l_none" rowspan="3">사고기록장치 저장데이터</th>
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
            <tr>
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_rec" id="file_rec" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_b" id="filename_b" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_rec" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
            <tr>
              <td class="left border_l_none lh_sm"><i class="font_orange">※ 파일을 선택하시면 기존 등록된 파일이 삭제됩니다</i></td>
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
              <th class="border_l_none" rowspan="3">기타첨부파일</th>
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
            <tr>
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_etc" id="file_etc" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_a" id="filename_c" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_etc" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
            <tr>
              <td class="left border_l_none lh_sm"><i class="font_orange">※ 파일을 선택하시면 기존 등록된 파일이 삭제됩니다</i></td>
            </tr>
          </tbody>
        </table>
      </div>

<%--       <div id="mov_view">
        <div class="table_row mt40 mb10">
          <p class="contTit1 pt15">주행영상 데이터</p>
          <p class="right"><a href="javascript:move_new();" class="btn_sky btn_sm">신규입력</a></p>
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
        </div>
      </div>

      <div id="mov_inst" style="display:none">
        <div class="table_row mt40 mb10">
          <p class="contTit1 pt15">주행영상 데이터</p>
          <p class="right" id="mov_plus"><a href="javascript:void(0);" class="btn_md btn_plus mr10"></a></p>
        </div>

        <div class="table2">
          <table summary="" class="">
            <colgroup>
              <col width="25%">
              <col width="">
              <col width="60">
            </colgroup>
            <tbody id="mov_tb">
              <tr name="mov_tr">
                <th class="border_l_none">주행영상</th>
                <td>
                  <div class="fileBox lg">
                    <input type="file" name="file_mov1" id="file_mov1" class="uploadBtn" onChange="fileExtCheck(this);">
                    <input type="text" name="filename" id="filename1" class="fileName" readonly="readonly" placeholder="선택된 파일 없음">
                    <label for="file_mov1" class="btn_file btn_md btn_l_gray">파일선택</label>
                  </div>
                </td>
                <td class="right border_l_none"><a href="javascript:void(0);" class="btn_md btn_minus"></a></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div> --%>
      <div class="table_row mt40 mb10">
        <p class="contTit1 pt15">주행영상 데이터</p>
      </div>    
      <div class="table2">
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
                //MaxTotalFileCount: "20",
                MultiFileSelect: true,
                //ExtensionAllowOrLimit: "0",
                //ExtensionArr: "png",
                ResumeUpload: "1",
                ResumeDownload: "1",
                FolderNameRule: "incd",
                FileNameRule: "REALFILENAME",
                Mode: "edit", // edit, view
                ButtonBarEdit: "add,send,remove,remove_all",
                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
                //UploadHolder: "uploadHoder_PlaceHolder",
                //IgnoreSameUploadName: "1",
                 CompleteEventResetUse: "1"
            };

            var upload = new RAONKUpload(uploadConfig);		        

		    </script>
		</div>      

      <div id="btn_sm" class="center mt20">
        <a href="javascript:fn_Save('${drv_no}','${acc_id}');" class="btn_sky btn_lg mr5">저장</a>
        <a href="/duty/incident/Duty_Incd_Info.do?drv_no=${drv_no}&acc_id=${acc_id}" class="btn_gray btn_lg">취소</a>
      </div>

      <div id="loading" class="center" style="display:none">
        <img src="/images/avsc/loading.gif">
      </div>
    </div>
    <!-- //contents -->
<script type="text/javascript">

  var movcnt = 1;
  //사고차량 테이블 생성 삭제
  $("#tb_plus").click(function () {
    //row 생성 count 처리
    $("#tb_acc_sub").clone().appendTo("#tb_acc");
  });

  $("#tb_minus").click(function () {
    //row 삭제 count 처리
    var rowcnt = $("table[id=tb_acc_sub]").length;
    var idx = rowcnt-1;
    if(rowcnt < 2) {
      alert("사고차량 정보 입력란을 전부 삭제 할수 없습니다");
    } else {
      //row remove
      $("table[id=tb_acc_sub]:eq("+idx+")").remove();
    }
  });

  //사고영상 row 생성 삭제
  $("#mov_plus").click(function () {
    movcnt++;
    //html 생성
    var addHtml = ''+
    '<tr name="mov_tr">'+
    '  <th class="border_l_none">주행영상</th>'+
    '  <td>'+
    '    <div class="fileBox lg">'+
    '      <input type="file" name="file_mov'+movcnt+'" id="file_mov'+movcnt+'" class="uploadBtn" onChange="fileExtCheck(this);">'+
    '      <input type="text" name="filename" id="filename'+movcnt+'" class="fileName" readonly="readonly" placeholder="선택된 파일 없음">'+
    '      <label for="file_mov'+movcnt+'" class="btn_file btn_md btn_l_gray">파일선택</label>'+
    '    </div>'+
    '  </td>'+
    '  <td class="right border_l_none"><a href="javascript:void(0);" class="btn_md btn_minus"></a></td>'+
    '</tr>';
    $("#mov_tb").append(addHtml);
    $("input[id^='file_mov']").each(function() {
      var uploadFile = $('.fileBox .uploadBtn');
      uploadFile.on('change', function(){
      	if(window.FileReader){
      		var filename = $(this)[0].files[0].name;
      	} else {
      		var filename = $(this).val().split('/').pop().split('\\').pop();
      	}
      	$(this).siblings('.fileName').val(filename);
      });
    });
  });

  $("#mov_tb").on("click", "a", function() {
    //row remove
		$(this).closest("tr").remove();
	});

  var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "acc_detail_info",
		sSkinURI: "/se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
</script>

  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
