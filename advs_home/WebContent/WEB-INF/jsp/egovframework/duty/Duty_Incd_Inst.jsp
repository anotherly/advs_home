<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
var G_UploadID;
var G_vertical = '\u000B'; // 파일 구분자
var G_formfeed = '\u000C'; // 각 파일당 속성 구분자

//생성완료 이벤트
function RAONKUPLOAD_CreationComplete(uploadID) {
    G_UploadID = uploadID;
}

//전송완료 이벤트
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

<script type="text/javaScript" defer>

//폼 변수
var c_form = "";

$(document).ready(function() {
  	c_form = document.listForm; //폼 셋팅

  	//달력 이벤트
// 	$( "#acc_date_d" ).datepicker({
// 			dateFormat: 'yy-mm-dd',
// 			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
// 			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
// 			changeMonth: true,
// 			changeYear: true,
// 			//showOn: "button",
// 			//buttonImage: "/css/avsc/images/icon_calendar.png",
// 			showMonthAfterYear: true,
// 			showOtherMonths: true,
// 			selectOtherMonths: true,
// 			maxDate : "+12m"
// 	});
  	
});

/* 등록 function */
function fn_Insert() { 
	if(confirm("등록 하시겠습니까?")) {
  oEditors.getById["acc_detail_info"].exec("UPDATE_CONTENTS_FIELD", []);

  if(trim(c_form.tmp_race_number.value).length==0){
    alert("임시운행등록번호를 선택해주세요");
			c_form.tmp_race_number_view.focus();
			return;
		}

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
  
  if(isNaN(c_form.autocar_speed.value) || c_form.autocar_speed.value<=0 || c_form.autocar_speed.value.length>3){
		alert("올바른 운행속도를 입력해주세요");
		c_form.autocar_speed.value="";
		c_form.autocar_speed.focus();
		return;
	}
  
  if(isNaN(c_form.autocar_ride_number.value) || c_form.autocar_ride_number.value.length==0){
		alert("승차인원을 입력해주세요");
		c_form.autocar_ride_number.value="";
		c_form.autocar_ride_number.focus();
		return;
	}
  
  if(isNaN(c_form.autocar_load_vol.value) || c_form.autocar_load_vol.value.length==0){
		alert("적재량을 입력해주세요");
		c_form.autocar_load_vol.value="";
		c_form.autocar_load_vol.focus();
		return;
	}
  
//   if(trim(c_form.file_info.value).length>0) {
//     if(!fileSizeCheck(c_form.file_info, 100)) return c_form.file_info.focus();
// 		}
//   if(trim(c_form.file_rec.value).length>0) {
//     if(!fileSizeCheck(c_form.file_rec, 100)) return c_form.file_rec.focus();
// 		}
//   if(trim(c_form.file_etc.value).length>0) {
//     if(!fileSizeCheck(c_form.file_etc, 100)) return c_form.file_etc.focus();
// 		}

  $("#btn_sm").hide();
//   $("#loading").show();

		document.listForm.action = "<c:url value='/duty/incident/Duty_Incd_Inst_Process.do'/>";
		document.listForm.submit();
	}
}

 function fn_tmpEvent(val) {
   if(val == null || val == "") {
     c_form.tmp_race_number.value = "";
     c_form.tmp_race_agency.value = "";
   } else {
     var strArr = val.split('|');
     c_form.tmp_race_number.value = strArr[0];
     c_form.tmp_race_agency.value = strArr[1];
   }
 }

 function fn_accCarEvent(obj) {
   var idx = $("select[id=acccar_car_type]").index(obj);
   if($(obj).val() == '102') {
     $("select[id=acccar_driving_mode]:eq("+idx+")").val("102").attr("selected","selected");
   }
 }
 
 function fn_goList() {
	location.href = "<c:url value='/duty/incident/Duty_Incd_List.do'/>";
 		
 }

 function fn_accCarEvent(obj) {
   var idx = $("select[id=acccar_car_type]").index(obj);
   if($(obj).val() == '102') {
     $("select[id=acccar_driving_mode]:eq("+idx+")").val("102").attr("selected","selected");
   }
 }
</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="tmp_race_number" id="tmp_race_number"/>
<input type="hidden" name="fileName" id="fileName"/>
<input type="hidden" name="fileSize" id="fileSize"/>
<input type="hidden" name="filePath" id="filePath"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<body>
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
                                 <div class="lnb-item is-active">
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
                                         <li>운행정보보고</li>
                                         <li>교통사고</li>
                                     </ul>
                                 </div>
                                 <h5 class="layout-content__subtit">기관정보</h5>
                                 <div class="table-wrap">
                                     <table class="table-basic table-basic--row">
                                         <caption>운행정보보고 &gt; 교통사고 &gt; 기관정보 테이블</caption>
                                         <colgroup>
                                             <col style="width:18%">
                                             <col style="width:auto">
                                             <col style="width:18%">
                                             <col style="width:34%">
                                         </colgroup>
                                         <tbody>
                                             <tr>
                                                 <th scope="row">
                                                 	<span class="el-essential">*</span>
                                                 	 임시운행등록번호
                                                 </th>
                                                 <td>
                                                 	<div class="ui-form">
	                                                 	<div class="ui-form-block">
		                                                 	<label for="" class="ui-form-width--r">
		                                                 	<select id="tmp_race_number_view" name="tmp_race_number_view" class="w100p" onchange="javascript:fn_tmpEvent(this.value)">
											                  <c:choose>
											                    <c:when test="${code_tempoper eq null || empty code_tempoper}">
											                      <option value="">-</option>
											                    </c:when>
											                    <c:otherwise>
											                      <option value="">-</option>
											                      <c:forEach var="list" items="${code_tempoper }" varStatus="loop">
											                        <option value="${list.tmpNumber}|${list.tmpAgency}">${list.tmpNumber}</option>
											                      </c:forEach>
											                    </c:otherwise>
											                  </c:choose>
										                	</select>
										                	</label>
	                                                    </div>
                                                	</div>
								                </td>
                                                 <th scope="row">임시운행기관</th>
                                                 <td>
                                                 	<div class="ui-form">
                                                         <div class="ui-form-block">
                                                         	<input type="text" class=""  id="tmp_race_agency" name="tmp_race_agency" readonly>
                                                         </div>
                                                    </div>
                                                </td>
                                             </tr>
                                         </tbody>
                                     </table>
                                 </div>
                                 <h5 class="layout-content__subtit">사고개요</h5>
                                 <div class="table-wrap">
                                     <table class="table-basic table-basic--row">
                                         <caption>운행정보보고 &gt; 교통사고 &gt; 사고개요 테이블</caption>
                                         <colgroup>
                                             <col style="width:18%">
                                             <col style="width:auto">
                                             <col style="width:18%">
                                             <col style="width:34%">
                                         </colgroup>
                                         <tbody>
                                             <tr>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                     	사고일시
                                                 </th>
                                                 <td>
                                                     <div class="ui-form ui-form-row align-center js-datepicker-range">
                                                        <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--140 js-datepicker" id="acc_date_d" name="acc_date_d" title="사고일시" />
                                                             <label for="">
                                                                 <select name="acc_date_h" id="acc_date_h" class="ui-form-width--xs" title="사고일시 시 선택">
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
                                                                 </select>
                                                             </label>
                                                             	시
                                                             <label for="" class="ml-10">
                                                                 <select name="acc_date_m" id="acc_date_m" class="ui-form-width--xs" title="사고일시 분 선택">
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
                                                                 </select>
                                                             </label>
                                                             	분
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                    	 사고장소
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" id="place" name="place" class="ui-input ui-form-width--full" title="사고장소 입력" onkeyup="checkLength(this,250)"/>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                    	 기상상황
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="weather" id="weather"  class="ui-form-width--r" title="기상상황 선택">
                                                                     <c:choose>
													                    <c:when test="${code_weather eq null || empty code_weather}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_weather }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                     	도로상황
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="road_situation" id="road_situation"  class="ui-form-width--r" title="도로상황 선택">
                                                                     <c:choose>
													                    <c:when test="${code_road_situation eq null || empty code_road_situation}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_road_situation }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">도로유형</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="road_type_cd" id="road_type_cd"  class="ui-form-width--r" title="도로유형 선택">
                                                                     <c:choose>
													                    <c:when test="${code_road_type_cd eq null || empty code_road_type_cd}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_road_type_cd }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row"></th>
                                                 <td></td>
                                             </tr>
                                         </tbody>
                                     </table>
                                 </div>
                                 <h5 class="layout-content__subtit">자율주행 자동차</h5>
                                 <div class="table-wrap">
                                     <table class="table-basic table-basic--row">
                                         <caption>운행정보보고 &gt; 교통사고 &gt; 자율주행 자동차 테이블</caption>
                                         <colgroup>
                                             <col style="width:18%">
                                             <col style="width:auto">
                                             <col style="width:18%">
                                             <col style="width:34%">
                                         </colgroup>
                                         <tbody>
                                             <tr>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                    	 주행모드
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="autocar_driving_mode" id="autocar_driving_mode"  class="ui-form-width--r" title="주행모드 선택">
                                                                     <c:choose>
													                    <c:when test="${code_driving_mode eq null || empty code_driving_mode}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_driving_mode }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     <span class="el-essential">*</span>
                                                    	 주행상태
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="autocar_driving_status_cd" id="autocar_driving_status_cd"  class="ui-form-width--r" title="주행상태 선택">
                                                                     <c:choose>
													                    <c:when test="${code_driving_status_cd eq null || empty code_driving_status_cd}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_driving_status_cd }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                     	운행속도
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="autocar_speed" name="autocar_speed" title="운행속도 입력">
                                                             km/h
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     	승차인원
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="autocar_ride_number" name="autocar_ride_number" title="승차인원 입력">
                                                             	명
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">적재량</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="autocar_load_vol" name="autocar_load_vol" title="적재량 입력">
                                                             kg
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">파손정도</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="autocar_damage" id="autocar_damage"  class="ui-form-width--s" title="파손정도 선택">
                                                                   <c:choose>
												                    <c:when test="${code_damage eq null || empty code_damage}">
												                      <option value="">-</option>
												                    </c:when>
												                    <c:otherwise>
												                      <c:forEach var="list" items="${code_damage }" varStatus="loop">
												                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
												                      </c:forEach>
												                    </c:otherwise>
												                  </c:choose>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">인적피해</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block  ui-form-row align-center">
                                                             <label for="" class="mr-10">
                                                                 <select name="human_injury_type" id="human_injury_type"  class="ui-form-width--100" title="인적피해자 선택">
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
                                                             </label>
                                                             	성별
                                                             <label for="" class="ml-5 mr-10">
                                                                 <select name="autocar_human_sex" id="autocar_human_sex"  class="ui-form-width--xs" title="인적피해 성별 선택">
                                                                    <c:choose>
													                    <c:when test="${code_human_sex eq null || empty code_human_sex}">
													                      <option value="">-</option>
													                    </c:when>
													                    <c:otherwise>
													                      <c:forEach var="list" items="${code_human_sex }" varStatus="loop">
													                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
													                      </c:forEach>
													                    </c:otherwise>
													                  </c:choose>
                                                                 </select>
                                                             </label>
                                                             	나이
                                                             <label for="" class="ml-5">
                                                                 <select name="autocar_human_age" id="autocar_human_age"  class="ui-form-width--xs" title="인적피해 나이 선택">
                                                                    <c:forEach var="list" begin="19" end="90" varStatus="loop">
													                    <c:set var="age" value="${loop.index}" />
													                    <option value='${age}' >${age}</option>
													                  </c:forEach>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row"></th>
                                                 <td>
                                                 </td>
                                             </tr>
                                         </tbody>
                                     </table>
                                 </div>
                                 <h5 class="layout-content__subtit d-flex align-end">
                                    	사고차량
                                     <button type="button" id="tb_plus" class="btn btn-width--s btn-color--navy ml-auto js-clone" data-target="cloneAccident" onclick="javascript:void(0);">
                                         <img src="/image/common/icon/icon-plus.png" alt="">
                                        	 행 추가
                                     </button>
                                     <button type="button" id="tb_minus" class="btn btn-width--s btn-color--navy ml-auto js-clone" data-target="cloneAccident" onclick="javascript:void(0);">
                                         <img src="/image/common/icon/icon-sch.png" alt="">
                                        	 행 삭제
                                     </button>
                                 </h5>
                                 <div class="table-wrap" id="tb_acc">
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
                                                 <th scope="row">
                                                    	 사고차량종류
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="acccar_car_type" id="acccar_car_type"  class="ui-form-width--r" title="사고차량종류 선택">
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
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     
                                                 </th>
                                                 <td>
                                                     
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                     	사고차 주행모드
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="acccar_driving_mode" id="acccar_driving_mode"  class="ui-form-width--r" title="사고차 주행모드 선택">
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
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     	사고차 주행상태
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="acccar_driving_status_cd" id="acccar_driving_status_cd"  class="ui-form-width--r" title="사고차 주행상태 선택">
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
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                    	 운행속도
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="acccar_speed" name="acccar_speed" title="운행속도 입력">
                                                             km/h
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">
                                                     	승차인원
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="acccar_ride_number" name="acccar_ride_number" title="승차인원 입력">
                                                             	명
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">적재량</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <input type="text" class="ui-input ui-form-width--s" id="acccar_load_vol" name="acccar_load_vol" title="적재량 입력">
                                                             kg
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row">파손정도</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block">
                                                             <label for="" class="ui-form-width--r">
                                                                 <select name="acccar_damage" id="acccar_damage"  class="ui-form-width--s" title="파손정도 선택">
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
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">인적피해</th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="ui-form-block  ui-form-row align-center">
                                                             <label for="" class="mr-10">
                                                                 <select name="acccar_human_injury_type" id="acccar_human_injury_type"  class="ui-form-width--100" title="인적피해자 선택">
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
                                                             </label>
                                                             	성별
                                                             <label for="" class="ml-5 mr-10">
                                                                 <select name="acccar_human_sex" id="acccar_human_sex"  class="ui-form-width--xs" title="인적피해 성별 선택">
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
                                                             </label>
                                                            	 나이
                                                             <label for="" class="ml-5">
                                                                 <select name="acccar_human_age" id="acccar_human_age"  class="ui-form-width--xs" title="인적피해 나이 선택">
                                                                    <c:forEach var="list" begin="19" end="90" varStatus="loop">
													                    <c:set var="age" value="${loop.index}" />
													                    <option value='${age}' >${age}</option>
													                  </c:forEach>
                                                                 </select>
                                                             </label>
                                                         </div>
                                                     </div>
                                                 </td>
                                                 <th scope="row"></th>
                                                 <td>
                                                 </td>
                                             </tr>
                                             </tbody>
                                     </table>
                                 </div>
                                 <div class="table-wrap" id="">
                                     <table id="" class="table-basic table-basic--row">
                                     	<colgroup>
                                     		<col style="width:18%">
                                            <col style="width:auto">
                                        </colgroup>
                                        <tbody>
                                        	<tr>
                                            <th scope="row">사고 상세묘사</th>
	                                            <td colspan="3">
	                                                <textarea title="사고상세묘사 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="acc_detail_info" id="acc_detail_info" title=""></textarea>
	                                            </td>
                                        	</tr>
                                    	</tbody>
                                     </table>
                                  </div>
                                 <h5 class="layout-content__subtit">첨부서류</h5>
                                 <div class="table-wrap" id="cloneAccident">
                                     <table class="table-basic table-basic--row">
                                         <caption>운행정보보고 &gt; 교통사고 &gt; 첨부서류 테이블</caption>
                                         <colgroup>
                                             <col style="width:18%">
                                             <col style="width:auto">
                                         </colgroup>
                                         <tbody>
                                             <tr>
                                                 <th scope="row">
                                                     	운행정보
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                         <div class="file">
                                                             <div class="file__input" id="file__input">
                                                                 <input class="file__input--file" name="file_info" id="file_info" type="file" onChange="fileExtCheck(this);">
                                                                 <input type="text" class="file__upload--name" name="filename_a" id="filename_a" placeholder="선택된 파일 없음">
                                                                 <label class="file__input--label" for="file_info">파일찾기</label>
                                                             </div>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                     	사고기록장치 저장데이터
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                        <div class="file">
                                                            <div class="file__input" id="file__input">
                                                                <input class="file__input--file" name="file_rec" id="file_rec" type="file" onChange="fileExtCheck(this);">
                                                                <input type="text" class="file__upload--name" name="filename_b" id="filename_b" placeholder="선택된 파일 없음">
                                                                <label class="file__input--label" for="file_rec">파일찾기</label>
                                                            </div>
                                                        </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                             <tr>
                                                 <th scope="row">
                                                     	기타 첨부파일
                                                 </th>
                                                 <td>
                                                     <div class="ui-form">
                                                        <div class="file">
                                                            <div class="file__input" id="file__input">
                                                                <input class="file__input--file" name="file_etc" id="file_etc" type="file" onChange="fileExtCheck(this);">
                                                                <input type="text" class="file__upload--name" name="filename_a" id="filename_c" placeholder="선택된 파일 없음">
                                                                <label class="file__input--label" for="file_etc">파일찾기</label>
                                                            </div>
                                                         </div>
                                                     </div>
                                                 </td>
                                             </tr>
                                         </tbody>
                                     </table>
                                 </div>
                                 <h5 class="layout-content__subtit">주행영상데이터</h5>
<!--                                  <div> -->
<!--                                      	기존영상데이터 업로드 프로그램 -->
<!--                                  </div> -->
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
	                                 
	                                 console.log("uploadConfig =  "+uploadConfig);

	                 	            var upload = new RAONKUpload(uploadConfig);
								    </script>
                                 </div>
                                 
                                 <div id="btn_sm" class="btn-wrap btn-row justify-center mt-30 mb-80">
                                     <button type="button" class="btn btn-width--l btn-color--white" onclick="fn_goList();">취소</button>
                                     <button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Insert();">등록</button>
                                 </div>
                             </div>
                          </div>
                    </div>
	        	</div>
    		</div>
		</div>

 
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
</body>
</form:form>
