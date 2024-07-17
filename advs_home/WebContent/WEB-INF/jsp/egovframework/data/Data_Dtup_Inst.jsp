<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<%--!-- nero upload -->
<link rel="stylesheet" type="text/css" href="/css/avsc/A2mUpload.css">
<script type="text/javascript" src="/js/nero/A2mUpload.js"></script>
<script type="text/javascript" src="/js/nero/uploadConfig.js"></script>
<script type="text/javascript" src="/js/nero/designConfig.js"></script>
<!-- nero upload --%>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
    <script type="text/javascript">
        var G_UploadID;
        var G_vertical = '\u000B'; // 파일 구분자
        var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
        
        // 생성완료 이벤트
        function RAONKUPLOAD_CreationComplete(uploadID) {    
        	
            G_UploadID = uploadID;
           // alert("aaa : " + G_UploadID);
        }
        
        // 전송완료 이벤트
        function RAONKUPLOAD_UploadComplete(uploadID) {
        
            G_UploadID = uploadID;
            alert("bbb : " + G_UploadID);

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
                	//alert("ccc : "+ originalName[arIdx]);
                	fileSize[arIdx] = jsonWebFile.size[i];
                	filePath[arIdx++] = jsonWebFile.uploadPath[i];
                	RAONKUPLOAD.AddUploadedFile(jsonWebFile.order[i], jsonWebFile.originalName[i], jsonWebFile.uploadPath[i], jsonWebFile.size[i], '', uploadID);
                }
                $("#fileName").val(originalName);
                $("#fileSize").val(fileSize);
                $("#filePath").val(filePath);  
            }

            // 새로 업로드된 파일을 webFile로 새롭게 추가하기 위한 로직
            if (jsonNew != null) {
            	//alert("ccc : ");
            	if (G_UploadID == "kupload"){
	                var jsonNewLength = jsonNew.uploadPath.length;
	
	                for (var i = 0; i < jsonNewLength; i++) {
	                    // 여기서 첫번째 파라미터인 uniqkey 값은 db 처리 후 db의 seq값을 넣으시거나 특정 uniq 값으로 넣으시면 됩니다.
	                	originalName[arIdx] = jsonNew.originalName[i];
	                	//alert("ccc21 : "+ originalName[arIdx]);
	                	fileSize[arIdx] = jsonNew.size[i];
	                	filePath[arIdx++] = jsonNew.uploadPath[i];
	                    RAONKUPLOAD.AddUploadedFile(jsonNew.order[i], jsonNew.originalName[i], jsonNew.uploadPath[i], jsonNew.size[i], '', uploadID);
	                }
	                $("#fileName").val(originalName);
	                $("#fileSize").val(fileSize);
	                $("#filePath").val(filePath);       
            	}  
            	
            	if (G_UploadID == "kupload2"){
	                var jsonNewLength = jsonNew.uploadPath.length;
	              
	                for (var i = 0; i < jsonNewLength; i++) {
	                    // 여기서 첫번째 파라미터인 uniqkey 값은 db 처리 후 db의 seq값을 넣으시거나 특정 uniq 값으로 넣으시면 됩니다.
	                	originalName[arIdx] = jsonNew.originalName[i];
	                	//alert("ccc22 : "+ originalName[arIdx]);
	                	fileSize[arIdx] = jsonNew.size[i];
	                	filePath[arIdx++] = jsonNew.uploadPath[i];
	                    RAONKUPLOAD.AddUploadedFile(jsonNew.order[i], jsonNew.originalName[i], jsonNew.uploadPath[i], jsonNew.size[i], '', uploadID);
	                }
	                $("#fileName2").val(originalName);
	                $("#fileSize2").val(fileSize);
	                $("#filePath2").val(filePath);       
            	}    
            }
            
            
        }

        function RAONKUPLOAD_BeforeDeleteFile(uploadID, paramObj) {
            // 파일 삭제 전 처리할 내용
            if("1" == paramObj.strIsWebFile){
	            $("#fileName").val("");
	            $("#fileSize").val("");
	            $("#filePath").val("");
            }
            
            return true;
        }
   </script>
<style>
  #file_upload {
    position: relative;
    margin: auto;
    width: 990px;
    height: auto;
  }
</style>

<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

/*   var submit1 = function(){
    $('#a2mdms').data('dms').upload();
  };
 */
  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
	
    var fileData = [];
    /*
    var a2mUpload = $("#a2mdms").A2mUpload({
        contextPath:commonContetextPath,
        inputName:'file_info',
        baseControllerPath:'/fum/fum_0101',
        chunkRetryInterval:'1000',  // a2m 권장 : 1000
        maxChunkRetries:'15',      // a2m 권장 : 30
        maxFileSize:'10737418200', // BYTE 단위
        maxFileCount:'1',
        minFileCount:'1',
        totalMaxSize :'10737418200',// BYTE 단위
        blockPolicy:'black',
        blackExtension:['asa','asp','cdx','cer','htr','aspx','jsp','jspx','html','htm','php','php3','php4','php5','ASA','ASP','CDX','CER','HTR','ASPX','JSP','JSPX','HTML','HTM','PHP','PHP3','PHP4','PHP5'],
        whiteExtension:[],
        controlType:'UPLOADBOX',
        dropAreaView:true,
        onUploadComplete:function(){
          c_form.file_up.value = "Y";
          fn_Insert();
        }
    });
	*/
    //달력 이벤트
		$( "#b_from_day" ).datepicker({
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

    //달력 이벤트
		$( "#b_to_day" ).datepicker({
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

    $("#vehicle_id_view").on("change", function() {
      var val = $("#vehicle_id_view option:selected").val();
      if(val == null || val == "" || val == "new") {
        $("#vehicle_id").attr("readonly", false);
        c_form.vehicle_id.value = "";
        c_form.car_model.value = "";
        c_form.movie_sensor_model.value = "";
        c_form.lidar_model.value = "";
        c_form.radar_model.value = "";
        $("#car_isExist").show();
      } else {
        var strArr = val.split('|');
        $("#vehicle_id").attr("readonly", true);
        c_form.vehicle_id.value = strArr[0];
        $("#car_type").val(strArr[1]).prop("selected", true);
        c_form.car_model.value = strArr[2];
        c_form.movie_sensor_model.value = strArr[3];
        c_form.lidar_model.value = strArr[4];
        c_form.radar_model.value = strArr[5];
        $("#autocar_level").val(strArr[6]).prop("selected", true);
        $("#car_isExist").hide();
      }
    });
	/*
    $("#dataset").on("change", function() {
      var val = $("#dataset option:selected").val();
      if(val == null || val == "" || val == "new") {
        c_form.bdwr_seq.value = "";
        c_form.bdwr_ttl_nm.value = "";
        oEditors2.getById["bdwr_cts"].exec("SET_IR", [""]);
        //c_form.data_form.value = "";
      } else {
        var strArr = val.split('|');
        $.ajax( {
          type : "POST",
          cache: false,
          contentType:"application/x-www-form-urlencoded;charset=utf-8",
          url : "/data/upload/Data_Dtup_DataSet_Info.do",
          data : {
            bdwr_seq : strArr[0],
            bbs_seq : strArr[1]
          },
          success : function(data) {
            var arr = eval(data);
            if( arr == null) {
              return;
            } else {
              c_form.bdwr_seq.value = arr[0].bdwr_seq;
              c_form.bdwr_ttl_nm.value = arr[0].bdwrTtlNm;
              //네이버에디터 값 변경시 초기화 하여 기존값 삭제하고 셋팅
              oEditors2.getById["bdwr_cts"].exec("SET_IR", [""]);
              oEditors2.getById["bdwr_cts"].exec("PASTE_HTML", [arr[0].bdwrCts]);
              //c_form.data_form.value = arr[0].dataForm;
              // var attachFilename = arr[0].attachFilename;
              // var fileSizeView = arr[0].fileSizeView;
            }
          },
          error : function(data) {
          }
        });
      }
    });
	*/
  });

  /* 유효성 function */
	function fn_Insert_Check() {
//		if(confirm("등록 하시겠습니까?")) {
      oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
      //oEditors2.getById["bdwr_cts"].exec("UPDATE_CONTENTS_FIELD", []);

      var bbs_seq = $("#bbs_seq option:selected").val();
      if(bbs_seq == "") {
        alert("데이터 구분을 선택해주세요");
        c_form.bbs_seq.focus();
        return;
      }

			if(trim(c_form.b_title.value).length==0){
				alert("제목을 입력해주세요");
				c_form.b_title.value="";
				c_form.b_title.focus();
				return;
			}

      if($('#b_content').val().length < 5){
				alert("내용을 5글자 이상 입력해주세요");
				c_form.b_content.value="";
				c_form.b_content.focus();
				return;
			}

			var vehicle_id_view = $("#vehicle_id_view option:selected").val();
			if(vehicle_id_view == "") {
        alert("차량을 선택해주세요");
        c_form.vehicle_id_view.focus();
        return;
      } else if(vehicle_id_view == "new") {
				if(trim(c_form.vehicle_id.value).length==0){
					alert("차량번호를 입력해주세요");
					c_form.vehicle_id.value="";
					c_form.vehicle_id.focus();
					return;
				}

        if(trim(c_form.isexist.value)!="Y"){
          alert("차량번호 중복확인을 실행하세요");
          c_form.vehicle_id.focus();
          return;
        }

				var car_type = $("#car_type option:selected").val();
				if(car_type == "") {
					alert("차량종류를 선택해주세요");
					c_form.car_type.focus();
					return;
				}
			}

/*       var dataset = $("#dataset option:selected").val();
      if(dataset == "new") {
        if(trim(c_form.bdwr_ttl_nm.value).length==0){
          alert("데이터 셋 정보 제목을 입력해주세요");
          c_form.bdwr_ttl_nm.value="";
          c_form.bdwr_ttl_nm.focus();
          return;
        }
        if($('#bdwr_cts').val().length < 5){
          alert("데이터 셋 정보 내용을 5글자 이상 입력해주세요");
          c_form.bdwr_cts.value="";
          c_form.bdwr_cts.focus();
          return;
        }
      } */
      //업로드 컴포넌트 호출
      //submit1();
      //기존업로드 컴포넌티 제거로 인하여 fn_Insert 호출
      fn_Insert();
//		}
	}

  /* 등록 function */
	function fn_Insert() {
/*     if(trim(c_form.file_up.value)!="Y"){
      alert("첨부파일을 업로드하세요");
      return;
    } */
    //업로드 컴포넌티 변경으로 인한 벨리데이션 체크
    if(c_form.fileName.value.length < 1){
        alert("첨부파일을 업로드하세요");
        return;
      }    

		document.listForm.action = "<c:url value='/data/upload/Data_Dtup_Inst_Process.do'/>";
		document.listForm.submit();
	}

  //checkbox 값 설정
	function fn_check_box(obj) {
		if(obj.checked) {
			c_form.b_important_yn.value = "Y";
		} else {
			c_form.b_important_yn.value = "N";
		}
	}

  /* 차량번호 중복확인 function */
  function fn_IsExist() {
    if(trim(c_form.vehicle_id.value).length==0){
      alert("차량번호를 입력해주세요");
      c_form.vehicle_id.focus();
      return;
    } else {
      $.ajax( {
        type : "POST",
        cache: false,
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        url : "/data/upload/Data_Dtup_Car_IsExist.do",
        data : {
          vehicle_id : c_form.vehicle_id.value
        },
        success : function(data) {
          var arr = eval(data);
          if( arr == null) {
            return;
          } else {
            var result = arr[0].result;
            if(result == 0) {
              alert("등록이 가능한 차량번호입니다");
              c_form.isexist.value = "Y";
            } else if(result > 0) {
              alert("존재하는 차량번호입니다");
              c_form.isexist.value = "N";
            }
          }
        },
        error : function(data) {
        }
      });
    }
  }

</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="isexist" id="isexist"/>
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="file_up" id="file_up"/>
<input type="hidden" name="bbs_group_seq" id="bbs_group_seq" value="${bbs_group_seq}" />
<input type="hidden" name="fileName" id="fileName"/>
<input type="hidden" name="fileSize" id="fileSize"/>
<input type="hidden" name="filePath" id="filePath"/>
<input type="hidden" name="fileName2" id="fileName2"/>
<input type="hidden" name="fileSize2" id="fileSize2"/>
<input type="hidden" name="filePath2" id="filePath2"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>My Data</i></p>
    <ul class="depth2">
      <li class="active"><a href="javascript:fn_DtupView('/data/upload/Data_Dtup_Inst.do','${auth_id}','${user_id}');">데이터 업로드</a></li>
      <li class=""><a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a></li>
      <li class=""><a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a></li>
      <li class=""><a href="/data/request/Data_Rqhs_List.do">요청이력</a></li>
      <c:if test="${auth_id eq '102' || auth_id eq '103' || auth_id eq '104' || auth_id eq '105'}">
      	<li class=""><a href="/data/request/Data_Delega_Auth.do">권한위임</a></li>     
      </c:if> 
      <c:if test="${auth_id eq '103' }">
        <li class=""><a href="/data/control/Data_Dtmg_List.do">데이터관리</a></li>
      </c:if>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>데이터 업로드</b>
      <ul>
        <li></li>
        <li>My Data</li>
        <li>데이터 업로드</li>
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
              <th class="border_l_none"><b class="font_red">*</b> 데이터 구분</th>
              <td colspan="3">
                <c:choose>
                  <c:when test="${auth_id eq '102' || auth_id eq '105'}"> <!--협의체 권한일 경우-->
                    <select id="bbs_seq" name="bbs_seq" class="w250px">
                      <c:choose>
                        <c:when test="${bbs_list eq null || empty bbs_list}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <option value="">-</option>
                          <c:forEach var="list" items="${bbs_list}" varStatus="loop">
                            <option value="${list.bbsSeq}">${list.bbsNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </c:when>
                  <c:otherwise><!--관리자 권한일 경우-->
                    <select id="bbs_seq" name="bbs_seq" class="w250px">
                      <c:choose>
                        <c:when test="${bbs_list eq null || empty bbs_list}">
                          <option value="">-</option>
                        </c:when>
                        <c:otherwise>
                          <option value="">-</option>
                          <c:forEach var="list" items="${bbs_list}" varStatus="loop">
                            <option value="${list.bbsSeq}">${list.bbsNm}</option>
                          </c:forEach>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 제목</th>
              <td colspan="3">
                <input type="text" class="w100p" id="b_title" name="b_title" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 내용</th>
              <td colspan="3">
                <textarea title="내용 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="b_content" id="b_content" title=""></textarea>
              </td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">게시일자</th>
              <td>
                <input type="text" readonly="" class="w30p" id="b_from_day" name="b_from_day"> ~
                <input type="text" readonly="" class="w30p" id="b_to_day" name="b_to_day">
              </td>
              <th class="border_l_none">비밀번호</th>
              <td>
                <input type="password" class="w50p" id="b_password" name="b_password" onkeyup="checkLength(this,20)">
                <i class="checkbox"><input type="checkbox" id="chk_i"  name="chk_i" onclick="fn_check_box(this)"><label for="chk_i">중요</label></i>
                <input type="hidden" name="b_important_yn" id="b_important_yn"/>
              </td>
            </tr>
            -->
            <tr>
              <th class="border_l_none">주행모드</th>
              <td>
                <select id="driving_mode" name="driving_mode" class="w100p">
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
              </td>
              </tr>
              <tr>  
              <th class="border_l_none">기상상황</th>
              <td>
                <select id="weather" name="weather" class="w100p">
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
              </td>
            </tr>
            
             <tr>
            	<td colspan="4">
            	<p style="color:red;"><b>대용량 데이터인 관계로 업로더 작업 수행시간이 오래 걸릴수 있습니다. 참고바랍니다.</b></p>              	
            	
			     <c:choose>
				<c:when test="${auth_id eq '102' }">

			      <div id="file_upload2">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig2 = {
			                Id: "kupload2",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "2000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig2);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
			      	      
				</c:when>
				<c:when test="${auth_id eq '104' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload2">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig2 = {
			                Id: "kupload2",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "5000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                //ButtonBarEdit: "add,send,remove,remove_all",
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig2);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				<c:when test="${auth_id eq '105' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload2">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig2 = {
			                Id: "kupload2",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "100000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                //ButtonBarEdit: "add,send,remove,remove_all",
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig2);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				<c:when test="${auth_id eq '103' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload2">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig2 = {
			                Id: "kupload2",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "100000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                ButtonBarEdit: "add,send,remove,remove_all",			              
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig2);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				</c:choose>

			      
            	</td>
            </tr>      
            
            
            <tr>
              <th class="border_l_none">도로상황</th>
              <td>
                <select id="road_situation" name="road_situation" class="w100p">
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
              </td>
              <th class="border_l_none">도로유형</th>
              <td>
                <select id="road_type_cd" name="road_type_cd" class="w100p">
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
              </td>
            </tr>
            <tr>
              <th class="border_l_none">거동정보유형</th>
              <td>
                <select id="act_info_type" name="act_info_type" class="w100p">
                  <c:choose>
                    <c:when test="${code_act_info_type eq null || empty code_act_info_type}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_act_info_type }" varStatus="loop">
                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th class="border_l_none">기타</th>
              <td>
                <input type="text" class="w100p" id="etc_info" name="etc_info" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_info" id="file_info" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_a" id="filename_a" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_info" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
            -->
          </tbody>
        </table>
      </div>

    <!-- contents -->
      <div class="table2 mt40 mb10">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 첨부파일유형</th>
              <td colspan="3">
                <select id="file_type" name="file_type" class="w100p">
                  <c:choose>
                    <c:when test="${mydata_attach_cd eq null || empty mydata_attach_cd}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${mydata_attach_cd}" varStatus="loop">
                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>    
            </tr>
            
            <tr>
            	<td colspan="4">
            	
   
				<c:choose>
				<c:when test="${auth_id eq '102' }">

			      <div id="file_upload">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig = {
			                Id: "kupload",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "2000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
			      	      
				</c:when>
				<c:when test="${auth_id eq '104' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig = {
			                Id: "kupload",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "5000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                //ButtonBarEdit: "add,send,remove,remove_all",
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				<c:when test="${auth_id eq '105' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig = {
			                Id: "kupload",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "100000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
			                Mode: "edit", // edit, view
			                //ButtonBarEdit: "add,send,remove,remove_all",
			                ButtonBarEdit: "add,send",
			                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
			                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
			                //UploadHolder: "uploadHoder_PlaceHolder",
			                //IgnoreSameUploadName: "1",
			                 CompleteEventResetUse: "1"
			            };

			            var upload = new RAONKUpload(uploadConfig);
				        
				    </script>
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				<c:when test="${auth_id eq '103' }">
				<%-- <c:if test="${auth_id eq '102' }"> --%>

			      <div id="file_upload">
				    <script type="text/javascript">
			            // 해당 config 이외의 설정도 가능합니다. (www.raonk.com > 개발센터 참조)
			            var uploadConfig = {
			                Id: "kupload",
			                //InitXml: "raonkupload.config.xml",
			                //SkinName: "blue",
			                Width: "930px",
			                //Height: "500px",
			                MaxTotalFileSize: "100000GB",
			                //MaxOneFileSize: "20KB",
			                MaxTotalFileCount: "1",
			                //MultiFileSelect: false,
			                //ExtensionAllowOrLimit: "0",
			                //ExtensionArr: "png",
			                ResumeUpload: "1",
			                ResumeDownload: "1",
			                FolderNameRule: "dtup",
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
			        <!-- <div id="a2mdms" style="height: 294px"></div> -->
			      </div>
				</c:when>      
				
				</c:choose>
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
              <th class="border_l_none"><b class="font_red">*</b> 차량선택</th>
              <td>
                <select id="vehicle_id_view" name="vehicle_id_view" class="w100p">
                  <c:choose>
                    <c:when test="${car_list eq null || empty car_list}">
                      <option value="">-</option>
                      <option value="new">---신규등록---</option>
                    </c:when>
                    <c:otherwise>
                      <option value="">-</option>
                      <c:forEach var="list" items="${car_list}" varStatus="loop">
                        <option value="${list.vehicleId}|${list.carType}|${list.carModel}|${list.movieSensorModel}|${list.lidarModel}|${list.radarModel}|${list.autocarLevel}">${list.vehicleId}</option>
                      </c:forEach>
                      <option value="new">---신규등록---</option>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th class="border_l_none"><b class="font_red">*</b> 차량번호</th>
              <td>
                <input type="text" class="w70p" id="vehicle_id" name="vehicle_id" onkeyup="checkLength(this,20)">
                <span id="car_isExist" style="display:none"><a href="javascript:fn_IsExist();" class="btn_sky btn_xs mr5">중복확인</a></span>
              </td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 차량종류</th>
              <td>
                <select id="car_type" name="car_type" class="w100p">
                  <c:choose>
                    <c:when test="${code_car_type eq null || empty code_car_type}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <c:forEach var="list" items="${code_car_type}" varStatus="loop">
                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
              <th class="border_l_none">차량모델</th>
              <td>
                <input type="text" class="w100p" id="car_model" name="car_model" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <tr>
              <th class="border_l_none">영상센서모델</th>
              <td>
                <input type="text" class="w100p" id="movie_sensor_model" name="movie_sensor_model" onkeyup="checkLength(this,255)">
              </td>
              <th class="border_l_none">라이다모델</th>
              <td>
                <input type="text" class="w100p" id="lidar_model" name="lidar_model" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <tr>
              <th class="border_l_none">레이다모델</th>
              <td>
                <input type="text" class="w100p" id="radar_model" name="radar_model" onkeyup="checkLength(this,255)">
              </td>
              <th class="border_l_none">자율주행레벨</th>
              <td>
                <select id="autocar_level" name="autocar_level" class="w100p">
                  <c:choose>
                    <c:when test="${code_car_level eq null || empty code_car_level}">
                      <option value="">-</option>
                    </c:when>
                    <c:otherwise>
                      <option value="">-</option>
                      <c:forEach var="list" items="${code_car_level}" varStatus="loop">
                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                      </c:forEach>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td colspan="3">
                <div class="fileBox lg">
                  <input type="file" name="attach_filename" id="attach_filename" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_b" id="filename_b" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="attach_filename" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
<%-- 
      <div class="table_row mt40 mb10">
        <p class="contTit1">데이터 셋 정보</p>
        <p class="right"><i class="font_sky">※ 자료구성 및 자료에 대한 세부정보를 기입해주세요</i></p>
      </div>

      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">데이터 셋 선택</th>
              <td>
                <select id="dataset" name="dataset" class="w100p">
                  <c:choose>
                    <c:when test="${dataset_list eq null || empty dataset_list}">
                      <option value="">-</option>
                      <option value="new">---신규등록---</option>
                    </c:when>
                    <c:otherwise>
                      <option value="">-</option>
                      <c:forEach var="list" items="${dataset_list}" varStatus="loop">
                        <option value="${list.bdwrSeq}|${list.bbsSeq}">${list.bdwrTtlNm}</option>
                      </c:forEach>
                      <option value="new">---신규등록---</option>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 제목</th>
              <td>
                <input type="text" class="w100p" id="bdwr_ttl_nm" name="bdwr_ttl_nm" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <tr>
              <th class="border_l_none"><b class="font_red">*</b> 내용</th>
              <td>
                <textarea title="내용 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="bdwr_cts" id="bdwr_cts" title=""></textarea>
              </td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">데이터 형태</th>
              <td>
                <input type="text" class="w100p" id="data_form" name="data_form" onkeyup="checkLength(this,100)">
              </td>
            </tr>
            -->
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_data" id="file_data" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_c" id="filename_c" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_data" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
--%>

      <div class="center mt20">
        <input type="button" class="btn_sky btn_lg mr5" onclick="javascript:fn_Insert_Check();" value="업로드">
        <a href="javascript:history.back();" class="btn_gray btn_lg">취소</a>
      </div>
    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->

<script type="text/javaScript">
	var oEditors = [];
  var oEditors2 = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "b_content",
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
/*   nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors2,
    elPlaceHolder: "bdwr_cts",
    sSkinURI: "/se2/SmartEditor2Skin.html",
    htParams : {
      bUseToolbar : true,       // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
      bUseVerticalResizer : false,    // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
      bUseModeChanger : false,      // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
      //aAdditionalFontList : aAdditionalFontSet,   // 추가 글꼴 목록
      fOnBeforeUnload : function(){
        //alert("완료!");
      }
    }, //boolean
    fOnAppLoad : function(){
      //예제 코드
      //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
    },
    fCreator: "createSEditor2"
  }); */
</script>

</form:form>
