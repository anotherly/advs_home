-<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	String user_nm = (String)session.getAttribute("user_nm");
	String agcy_nm = (String)session.getAttribute("agcy_nm");
	String auth_id = (String)session.getAttribute("auth_id");
	String grad_id = (String)session.getAttribute("grad_id");
 %>

<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var G_UploadID;
	var G_vertical = '\u000B'; // 파일 구분자
	var G_formfeed = '\u000C'; // 각 파일당 속성 구분자

	function addAllFiles(uploadID){
   	 var i = 0;
   	 var fileName = "";
   	 var filePath = "";
   	 var fileSize = "";
		<c:forEach var="list" items="${mxFileList}" varStatus="status">
			RAONKUPLOAD.AddUploadedFile('${list.bSeq}', '${list.mxfile}', '/incd/${list.mxfile}', '${list.fileSize}', 'Custom Value', uploadID);
			if(i == 0){
				fileName += '${list.mxfile}';
				filePath += '/incd/${list.mxfile}';
				fileSize += '${list.fileSize}';
				
			}else{
				fileName += ',' + '${list.mxfile}';
				filePath += ',' + '/incd/${list.mxfile}';
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

<script type="text/javaScript" defer >

  //폼 변수-
  var c_form = "";

  $(document).ready(function() {
	c_form = document.listForm; //폼 셋팅
  });
  
	  /* 수정 function */
	function fn_Update(bseq, bbs) {
	    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
			oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			if(trim(c_form.selectScenarioCode1.value).length==0){
			    alert("일반시나리오(시간)를 선택해주세요");
						c_form.selectScenarioCode1.focus();
						return;
					}
		  
		  if(trim(c_form.selectScenarioCode2.value).length==0){
			    alert("엣지케이스(도로/상황)를 선택해주세요");
						c_form.selectScenarioCode2.focus();
						return;
					}
		  
		  if(trim(c_form.selectScenarioCode3.value).length==0){
			    alert("특수시나리오(날씨)를 선택해주세요");
						c_form.selectScenarioCode3.focus();
						return;
					}
		  
		  if(trim(c_form.selectDataType.value).length==0){
			    alert("수집차량 모델을 선택해주세요");
						c_form.selectDataType.focus();
						return;
					}

		  console.log("==========bbs : "+bbs);
		  c_form.bbs_seq.value = bbs;
		  console.log("==========c_form.b_title.value : "+c_form.b_title.value);
				if(trim(c_form.b_title.value).length==0){
					alert("제목을 입력해주세요");
//					c_form.b_title.value="";
					c_form.b_title.focus();
					return;
				}
				
				//console.log("==========('#b_content').val() : "+('#b_content').val());
				console.log("==========document.getElementById('b_content').value : "+document.getElementById("b_content").value);
				c_form.b_content.value = document.getElementById("b_content").value;
		  if(c_form.b_content.value.length < 5){
					alert("내용을 5글자 이상 입력해주세요");
//					c_form.b_content.value="";
					c_form.b_content.focus();
					return;
				}
		  
		  if(trim(c_form.selectDrivingMode.value).length==0){
			    alert("주행모드를 선택해주세요");
					c_form.selectDrivingMode.focus();
					return;
				}
		  
		  if(RAONKUPLOAD.GetTotalFileCount(G_UploadID, "total")==0){
				alert("첨부파일을 선택하세요");
				c_form.customFile.value="";
				c_form.customFile.focus();
				return;
			}
		  
			/* if(trim(c_form.customFile.value).length==0 & c_form.fileRemove == undefined){
					alert("첨부파일을 선택하세요");
					c_form.customFile.value="";
					c_form.customFile.focus();
					return;
			}
			
			if(trim(c_form.customFile.value).length!=0 & c_form.fileRemove != undefined){
				alert("첨부파일은 하나만 등록할 수 있습니다.");
				return;
			} */
	    	
	      c_form.b_seq.value = bseq;
	      c_form.action = "<c:url value='/open/normal/Open_Normal_Updt_Process.do'/>";
	      c_form.submit();
	    }
	}

	/* 삭제 function */
	function fn_Delete(bseq, bbs) {
		if(confirm("정말 삭제 하시겠습니까?")) {
			c_form.b_seq.value = bseq;
			c_form.bbs_seq.value = bbs;
			if(confirm("등록된 데이터셋 정보와 업로드된 데이터는 모두 삭제 됩니다")) {
				c_form.action = "<c:url value='/open/normal/Open_Normal_Delt_Process.do'/>";
				c_form.submit();
			}
		}
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "cits";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<input type="hidden" name="file_nm" id="file_nm" value="${normalInfo.saveNm}"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="fileName" id="fileName"/>
<input type="hidden" name="fileSize" id="fileSize"/>
<input type="hidden" name="filePath" id="filePath"/>

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
							<h3 class="lnb__tit">공공데이터</h3>
							<div class="lnb-list">
	     						<div class="lnb-item <c:if test="${bbs_seq eq '3010'}">is-active</c:if>"><a href="/open/normal/Open_Normal_List.do?bbs_seq=3010">일반시나리오 데이터셋</a></div>
	 							<div class="lnb-item <c:if test="${bbs_seq eq '3020'}">is-active</c:if>"><a href="/open/edge/Open_Edge_List.do?bbs_seq=3020">엣지케이스 시나리오<br/>데이터셋</a></div>
	                            <div class="lnb-item <c:if test="${bbs_seq eq '3030'}">is-active</c:if>"><a href="/open/v2x/Open_V2x_List.do?bbs_seq=3030">V2X 데이터셋</a></div>
							</div>
						</div>
						<div class="layout-content">
							<div class="layout-content__inner">
								<div class="layout-content__top">
									<h4 class="layout-content__tit">일반시나리오 데이터셋</h4>
									<ul class="location ml-auto">
										<li>
											<img src="/image/sub/icon/icon-home.png" alt="홈">
										</li>
										<li>공공데이터</li>
										<li>일반시나리오 데이터셋</li>
									</ul>
								</div>
								<div class="table-wrap">
									<table class="table-basic table-basic--row table--myUpload">
										<caption>공공데이터 &gt; 일반시나리오 데이터셋 테이블</caption>
										<colgroup>
											<col style="width:15%">
											<col style="width:auto">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">시나리오 코드</th>
												<td>
													<div class="ui-form">
															<label for="">
																<select name="selectScenarioCode1" id="selectScenarioCode1" title="일반시나리오(시간) 선택">
																	<c:choose>
																		<c:when test="${scenario_code1 eq null || empty scenario_code1}">
																			<option value="">-- 일반시나리오(시간) 선택 --</option>
																		</c:when>
																		<c:otherwise>
																		<option value="">-- 일반시나리오(시간) 선택 --</option>
																		<c:forEach var="list" items="${scenario_code1}" varStatus="loop">
																		<option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq normalInfo.collectLoc}">selected</c:if>>${list.codeDetlNm}</option>
																		</c:forEach>
																		</c:otherwise>
																	</c:choose>
																</select>
															</label>
															<label for="">
																<select name="selectScenarioCode2" id="selectScenarioCode2" title="엣지케이스(도로/상황) 선택">
																	<c:choose>
																		<c:when test="${scenario_code2 eq null || empty scenario_code2}">
																		<option value="">-- 엣지케이스(도로/상황) 선택 --</option>
																		</c:when>
																		<c:otherwise>
																		<option value="">-- 엣지케이스(도로/상황) 선택 --</option>
																		<c:forEach var="list" items="${scenario_code2}" varStatus="loop">
																		<option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq normalInfo.collectTime}">selected</c:if>>${list.codeDetlNm}</option>
																		</c:forEach>
																		</c:otherwise>
																	</c:choose>
																</select>
															</label>
															<label for="">
																<select name="selectScenarioCode3" id="selectScenarioCode3" title="특수시나리오(날씨) 선택">
																	<c:choose>
																	<c:when test="${scenario_code3 eq null || empty scenario_code3}">
																	<option value="">-- 특수시나리오(날씨) 선택 --</option>
																	</c:when>
																	<c:otherwise>
																	<option value="">-- 특수시나리오(날씨) 선택 --</option>
																	<c:forEach var="list" items="${scenario_code3}" varStatus="loop">
																	<option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq normalInfo.collectScenario}">selected</c:if>>${list.codeDetlNm}</option>
																	</c:forEach>
																	</c:otherwise>
																	</c:choose>
																</select>
															</label>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row">수집차량 모델</th>
												<td>
													<div class="ui-form">
															<label for="">
																<select name="selectDataType" id="selectDataType" title="수집차량 모델 선택">
																	<c:choose>
																		<c:when test="${bbs_list eq null || empty bbs_list}">
																		<option value="">-- 데이터유형 선택 --</option>
																		</c:when>
																		<c:otherwise>
																		<option value="">-- 데이터유형 선택 --</option>
																		<c:forEach var="list" items="${bbs_list}" varStatus="loop">
																		<option value="${list.bbsSeq}" <c:if test="${list.bbsSeq eq normalInfo.dataType}">selected</c:if>>${list.bbsNm}</option>
																		</c:forEach>
																		</c:otherwise>
																	</c:choose>
																</select>
															</label>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row">제목</th>
												<td>
													<div class="ui-form">
														<div class="ui-form-block">
															<input type="text" class="ui-input ui-form-width--l" name="b_title" id="b_title" Value="${normalInfo.bTitle}">
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row">내용</th>
												<td>
													<textarea title="내용 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="b_content" id="b_content" title="">${normalInfo.bContent}</textarea>
												</td>
											</tr>
											<tr>
												<th scope="row">주행모드</th>
												<td>
													<div class="ui-form">
														<select name="selectDrivingMode" id="selectDrivingMode" title="주행모드 선택">
															<c:choose>
																<c:when test="${code_driving_mode eq null || empty code_driving_mode}">
																<option value="">-- 주행모드 선택 --</option>
																</c:when>
																<c:otherwise>
																<option value="">-- 주행모드 선택 --</option>
																<c:forEach var="list" items="${code_driving_mode}" varStatus="loop">
																	<option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq normalInfo.drivingMode}">selected</c:if>>${list.codeDetlNm}</option>
																</c:forEach>
																</c:otherwise>
															</c:choose>
														</select>
													</div>
												</td>	
											</tr>
											<tr>
												<th scope="row">첨부파일</th>
												<td>
													<div class="">
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
											                MultiFileSelect: true,
											                //ExtensionAllowOrLimit: "0",
											                //ExtensionArr: "png",
											                ResumeUpload: "1",
											                ResumeDownload: "1",
											                FolderNameRule: "incd",
											                FileNameRule: "REALFILENAME",
											                Mode: "edit", // edit, view
											                ButtonBarEdit: "add,send,remove,remove_all,download,download_all",
											                //ButtonBarView: "open,download,download_all", // 0 일경우 버튼바 보이지 않음.
											                //Lang: "en-us", // ko-kr, en-us, ja-jp, zh-cn, zh-tw
											                //UploadHolder: "uploadHoder_PlaceHolder",
											                //IgnoreSameUploadName: "1",
											                 CompleteEventResetUse: "1"
											            };

											            var upload = new RAONKUpload(uploadConfig);	
														</script>
				<!-- 										<div id="raonkuploader_holder_kupload" style="width:auto; height:250px"><iframe id="raonkuploader_frame_kupload" title="RAONKUpload kupload" frameborder="0" src="" style="width: 100%; height: 100%; border-width: 0px;"></iframe></div> -->
													</div>
												</td>
											</tr>
											
										</tbody>
									</table>
								</div>
								<div class="btn-wrap btn-row justify-center mt-30 mb-80">
									<button type="button" class="btn btn-width--l btn-color--white" onclick="location.href='javascript:fn_Delete(${normalInfo.bSeq}, ${normalInfo.bbsSeq});' ">삭제</button>
									<button type="button" class="btn btn-width--l btn-color--gray" onclick="location.href='javascript:fn_Update(${normalInfo.bSeq}, ${normalInfo.bbsSeq});' ">저장</button>
									<button type="button" class="btn btn-width--l btn-color--navy" onclick="location.href='/open/normal/Open_Normal_List.do?bbs_seq=${normalInfo.bbsSeq}' "> 목록</button>
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

<script type="text/javaScript">
	var oEditors = [];
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
</script>
</form:form>
