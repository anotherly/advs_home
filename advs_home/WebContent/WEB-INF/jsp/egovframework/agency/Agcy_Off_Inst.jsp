<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
//String user_id = (String)session.getAttribute("user_id");
//String agcy_nm = (String)session.getAttribute("agcy_nm");
//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script src="/js/clip.js"></script> <!-- ClipReport4 -->
	
<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";
	var bizrNo = "";
	var scenario = "";
	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
		if('${paramMap.bbs_seq}' != ''){
			$("input[name=docTit]").attr("disabled", true);
			$("#docTit").val('${paramMap.bTitle}');
			$("input[name=scenario]").attr("disabled", true);
			$("input:radio[name='scenario']:radio[value='${paramMap.bbs_seq}']").prop('checked', true); 
			$("select[name=selectDataType]").attr("disabled", true);
			$("select[name=scenario_code1]").attr("disabled", true);
			$("select[name=scenario_code2]").attr("disabled", true);
			$("select[name=scenario_code3]").attr("disabled", true);
		}
	
		$("#scenario_code1").change(function () {
	        if(scenario == "2090"){
				fn_EdgeCode1();
			}
		});
		$("#scenario_code2").change(function () {
			if(scenario == "2090"){
				fn_EdgeCode2();
			}
		});
		
		$("input[name='scenario']:radio").change(function () {
			scenario = this.value;
	        $.ajax( {
		          type : "POST",
		          url : "<c:url value='/agency/off/Agcy_Off_scenarioCd.do'/>",
	              data : {"refVal2" : scenario},
		          success : function(data) {
		        	var scenario1 = null, scenario2 = null, scenario3 = null;
		        	var scenarioCode1='', scenarioCode2='', scenarioCode3='';
		        	  if(scenario == "2090"){
		        		  scenarioCode1='종류';
		        		  scenarioCode2='상황';
		        		  scenarioCode3='세부상황';
		        	  }else if(scenario == "2080"){
		        		  scenarioCode1='시간';
		        		  scenarioCode2='도로/상황';
		        		  scenarioCode3='날씨';
		        	  }else{
		        		  scenarioCode1='장소';
		        		  scenarioCode2='세부상황';
		        		  scenarioCode3='수집데이터';
		        	  }
	        		  scenario1 = data.scenario_code1;
	        		  scenario2 = data.scenario_code2;
	        		  scenario3 = data.scenario_code3;
		        	if(scenario1 != undefined){		        		
			        	var selectHtml1 = '';
		        		selectHtml1 += '<option value="">'+scenarioCode1+'</option>';
			        	$.each(scenario1, function(index, item){
			        		selectHtml1 += '<option value="'+item.codeDetlCd+'">'+item.codeDetlNm+'</option>';
				        	$('#scenario_code1Val').val() =item.codeDetlCd; 
			        	});
	        		    $("select[name=scenario_code1]").empty();		        		
	        		    $("select[name=scenario_code1]").append(selectHtml1);
		        		
		        	}
		        	if(scenario2 != undefined){
		        		var selectHtml2 = '';
		        		selectHtml2 += '<option value="">'+scenarioCode2+'</option>';
			        	$.each(scenario2, function(index, item){
			        		selectHtml2 += '<option value="'+item.codeDetlCd+'">'+item.codeDetlNm+'</option>';
			        		$('#scenario_code2Val').val() =item.codeDetlCd;
			        	});
	        		    $("select[name=scenario_code2]").empty();		        		
	        		    $("select[name=scenario_code2]").append(selectHtml2);		        		
		        	}
		        	if(scenario3 != undefined){
		        		var selectHtml3 = '';
		        		selectHtml3 += '<option value="">'+scenarioCode3+'</option>';
			        	$.each(scenario3, function(index, item){
			        		selectHtml3 += '<option value="'+item.codeDetlCd+'">'+item.codeDetlNm+'</option>';
				        	$('#scenario_code3Val').val() =item.codeDetlCd;
			        	});
	        		    $("select[name=scenario_code3]").empty();		        		
	        		    $("select[name=scenario_code3]").append(selectHtml3);	        		
		        	} 
		          },
		          error : function(data) {
		          }
	        });
		});
		
		$('#biz_number').keydown(function (event) {
	        var key = event.charCode || event.keyCode || 0;
	        $text = $(this); 
	        if (key !== 8 && key !== 9) {
	            if ($text.val().length === 3) {
	                $text.val($text.val() + '-');
	            }
	            if ($text.val().length === 6) {
	                $text.val($text.val() + '-');
	            }
	        }
	        return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
			 // Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
			 // 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
	    })
	    
	});
	
	function fn_EdgeCode1(){
	  	var refVal2=  $("#scenario_code1").val();
	    $.ajax({
			type : "POST",
			dataType: "json",
			url : "/open/edge/Open_V2x_Delt_SubCodeList.do",
			data: {"refVal2": refVal2},
			success : function(data) {
				var scenario1 = data.scenario_code1;
				$('#scenario_code1Val').val() =refVal2;
				var selectHtml = '<option value="">상황</option>';
	        	$.each(scenario1, function(index, item){
	        		selectHtml += '<option value="'+item.codeDetlCd+'">'+item.codeDetlNm+'</option>';
	        		$('#scenario_code2Val').val() =item.codeDetlCd;
	        	});
    		    $("select[name=scenario_code2]").empty();
    		    $("select[name=scenario_code2]").append(selectHtml);
			},
			error: function(data){
				alert("오류");
			} 
		});
	}

	function fn_EdgeCode2(){
		var refVal2=  $("#scenario_code2").val();
	    $.ajax({
			type : "POST",
			dataType: "json",
			url : "/open/edge/Open_V2x_Delt_SubCodeList2.do",
			data: {"refVal2": refVal2},
			success : function(data) {
				var scenario2 = data.scenario_code2;
				console.log(scenario2)
				var selectHtml = '<option value="">세부상황</option>';
	        	$.each(scenario2, function(index, item){
	        		selectHtml += '<option value="'+item.codeDetlCd+'">'+item.codeDetlNm+'</option>';
		        	$('#scenario_code3Val').val() =item.codeDetlCd;
	        	});
    		    $("select[name=scenario_code3]").empty();		        		
    		    $("select[name=scenario_code3]").append(selectHtml);
			},
			error: function(data){
				alert("오류");
			} 
		});
	 }
		
	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	}
	
	//신청하기 클릭
	function fn_submit(){
		var signCheck = $("#input-check__us_fa_02").is(':checked');
		if(!signCheck){
			alert("상기의 기재사항 동의여부에 체크해주세요.");
			return;
		}
		
		if(confirm("등록 하시겠습니까?")) {
			if(trim(c_form.biz_number.value).length != 12){
				alert("사업자등록번호 10자리를 입력해주세요.");
				c_form.biz_number.focus();
				return;
			}
			if(c_form.biz_number.value == ""){
				alert("사업자등록번호를 입력해주세요.");
				return ;
			}
			if(!checkBizno(c_form.biz_number.value)){
				alert("유효한 사업자번호가 아닙니다. 정확히 다시 입력해주세요.");
				return;
			}
					
			if(trim(c_form.orgAddr.value).length==0){
				alert("기관주소를 입력해주세요");
				c_form.orgAddr.focus();
				return;
			}
			
			if(c_form.scenario_code1.value=="" || c_form.scenario_code2.value=="" || c_form.scenario_code3.value==""){
				alert("시나리오 코드를 선택해주세요.");
				c_form.scenario_code1.focus();
				return;
			}
			if(c_form.selectDataType.value == ""){
				alert("수집차량 모델을 선택해주세요.");
				return ;
			}		
			if(trim(c_form.docTit.value).length==0){
				alert("공유 데이터 제목를 입력해주세요");
				c_form.docTit.focus();
				return;
			}
					
			if(trim(c_form.docCnt.value).length==0){
				alert("이용목적 제목를 입력해주세요");
				c_form.docCnt.focus();
				return;
			}
					
			if(trim(c_form.prcuseMthd.value).length==0){
				alert("활용방안 제목를 입력해주세요");
				c_form.prcuseMthd.focus();
				return;
			}
					
			if(trim(c_form.dsrVstDt.value).length==0){
				alert("희망방문일시 제목를 입력해주세요");
				c_form.dsrVstDt.focus();
				return;
			}			
			var formData = new FormData(); // FormData 객체 생성
			var scenarioCd = $('#scenario_code1Val').val()+"/"+$('#scenario_code2Val').val()+"/"+$('#scenario_code3Val').val();
			var scenarioNm = $("#scenario_code1 option:selected").text()+"/"+$("#scenario_code2 option:selected").text()+"/"+$("#scenario_code3 option:selected").text();
			formData.append('bizrNo', $('#biz_number').val());
			formData.append('reqOrg', $('#reqOrg').val());
			formData.append('orgAddr', $('#orgAddr').val());
			formData.append('docTit', $('#docTit').val());
			formData.append('scenarioCd', scenarioCd);
			formData.append('scenarioNm', scenarioNm);
			formData.append('selectDataType', $('#selectDataType').val());
			formData.append('selectDataTypeView', $('#selectDataTypeView').val());
			formData.append('docCnt', $('#docCnt').val());
			formData.append('prcuseMthd', $('#prcuseMthd').val());
			formData.append('dsrVstDt', $('#dsrVstDt').val());
			formData.append('orgAddr', $('#orgAddr').val());
			$.ajax( {
		          type : "POST",
		          url : "<c:url value='/agency/off/Agcy_Off_Process.do'/>",
		          processData: false,
    			  contentType: false,
		          data : formData,
		          success : function(data) {
		        	  var resultIn = data.result_insert;
	        		  var result = data.paramMap;
	        		  if(resultIn =='1'){
		        		  if(confirm("데이터 공유 신청서를 출력 하시겠습니까?")){
		        			  alert("서명후 저장하시면 PDF 파일로 저장됩니다.\n ※ 신청서 출력 원본은 공단에 제출해주시기 바랍니다.");
		        		  	fn_Report(result);
		        		  }
		        	  }
		        	  fn_goList();
		          },
		          error : function(data) {
		          }
		      });
		}
	}
	
	/* 보고서생성 function */
	function fn_Report(result) {
		var oReport = GetfnParamSet();
		var scenarioCd = $('#scenario_code1Val').val()+"/"+$('#scenario_code2Val').val()+"/"+$('#scenario_code3Val').val();
		var scenarioNm = $("#scenario_code1 option:selected").text()+"/"+$("#scenario_code2 option:selected").text()+"/"+$("#scenario_code3 option:selected").text();
    	oReport.rptname = "Agcy_Off_Inst";
    	oReport.param("agcy_nm").value = result.reqOrg;
    	oReport.param("orgAddr").value = $("#orgAddr").val();
    	oReport.param("scenarioNm").value = scenarioCd;
    	oReport.param("scenarioCd").value = scenarioNm;
    	oReport.param("car_cd").value = $("#selectDataType").val();
    	oReport.param("docTit").value = $("#docTit").val();
    	oReport.param("docCnt").value = $("#docCnt").val();
    	oReport.param("prcuseMthd").value = $("#prcuseMthd").val();
    	oReport.param("dsrVstDt").value = $("#dsrVstDt").val();
    	oReport.param("orgAddr").value = $("#orgAddr").val();
    	oReport.param("bizrNo").value = $("#biz_number").val() ;
    	oReport.open();
	}
	
	// 사업자등록번호 유효성체크
	function checkBizno(bizno){
		var biznoMap = bizno.replace(/-/gi, '').split('').map(function(i){
			return parseInt(i, 10);
		});
		if(biznoMap.length == 10){
			var keyArr = [1, 3, 7, 1, 3, 7, 1, 3, 5];
			var chk = 0;
			keyArr.forEach(function(d, i){
				chk += d*biznoMap[i];
			});
			chk += parseInt((keyArr[8] * biznoMap[8])/10, 10);
			return Math.floor(biznoMap[9]) === ((10-(chk%10)) % 10);
		}
		return false;
	}
</script>

<form:form id="listForm" name="listForm" method="post">
	<input type="hidden" name="scenario_code1Val" id="scenario_code1Val" value="${paramMap.selectScenarioCodeVal1}"/>
	<input type="hidden" name="scenario_code2Val" id="scenario_code2Val"  value="${paramMap.selectScenarioCodeVal2}"/>
	<input type="hidden" name="scenario_code3Val" id="scenario_code3Val"  value="${paramMap.selectScenarioCodeVal3}"/>
	<input type="hidden" name="scenario_nm1" id="scenario_nm1" />
	<input type="hidden" name="scenario_nm2" id="scenario_nm2" />
	<input type="hidden" name="scenario_nm3" id="scenario_nm3" />
	<input type="hidden" name=scenarioNm id="scenarioNm" />
	<input type="hidden" name="scenarioCd" id="scenarioCd" />
	<input type="hidden" name="selectDataTypeView" id="selectDataTypeView"   value="${paramMap.dataTypeView}"/>
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
											<li>협의체 데이터</li>
											<li>오프라인 공유 안내 및 신청</li>
										</ul>
									</div>
	
									<h5 class="layout-content__subtit">데이터 공유 신청</h5>
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
	                                                <th scope="row"><span class="el-essential">*</span>신청기관</th>
	                                                <td>
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <label for="" class="ui-form-width--full">
	                                                                <input type="text" class="ui-input ui-form-width--full" id="reqOrg" name="reqOrg" value="${agcy_nm}" title="신청기관 입력" readonly>
	                                                            </label>
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                                <th scope="row"><span class="el-essential">*</span>사업자등록번호</th>
	                                                <td>
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
                                                                <input type="text" class="ui-input ui-form-width--full" title="사업자등록번호 입력" id="biz_number" name="biz_number"  maxlength="12">
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row"><span class="el-essential">*</span>기관주소</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <label for="" class="ui-form-width--full">
	                                                                <input type="text" class="ui-input ui-form-width--full" id="orgAddr" name="orgAddr" title="기관주소 입력">
	                                                            </label>
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr id="scenarioCd">
	                                                <th scope="row">시나리오 데이터셋</th>	                                                
	                                                <td colspan="3" id="scenarioList">
	                                                	<div class="ui-form">                                         
		                                                    <label for="scenarioNormal">
	                                                            <input type="radio" name="scenario" id="scenarioNormal" class="ui-input ui-input-radio" value="2080" checked>
	                                                            <span class="ui-input-radio__span"></span>
	                                                            <span class="ui-input-radio__txt">일반시나리오</span>
	                                                        </label>
	                                                        <label for="scenarioEdge" class="ml-30">
	                                                            <input type="radio" name="scenario" id="scenarioEdge" class="ui-input ui-input-radio" value="2090">
	                                                            <span class="ui-input-radio__span"></span>
	                                                            <span class="ui-input-radio__txt">엣지케이스 시나리오</span>
	                                                        </label>
	                                                        <label for="scenarioV2x" class="ml-30">
	                                                            <input type="radio" name="scenario" id="scenarioV2x" class="ui-input ui-input-radio" value="2100">
	                                                            <span class="ui-input-radio__span"></span>
	                                                            <span class="ui-input-radio__txt">V2X</span>
	                                                        </label>
	                                                        </div>
	                                                        
											        </td>
	                                            </tr>
	                                            <tr>
	                                            	<th scope="row">시나리오 코드</th>
	                                            	<td colspan="3">
	                                            		<div class="ui-form">
			                                                <select id="scenario_code1" name="scenario_code1" class="w140px" title="검색대상 선택">
													          <c:choose>
													            <c:when test="${scenario_code1 eq null || empty scenario_code1}">
													              <option value="">시간</option>
													            </c:when>
													            <c:otherwise>
													              <option value="">시간</option>
													              <c:forEach var="list" items="${scenario_code1}" varStatus="loop">
													                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq paramMap.selectScenarioCodeVal1}">selected</c:if>>${list.codeDetlNm}</option>
													              </c:forEach>
													            </c:otherwise>
													          </c:choose>
													        </select>
													        <select id="scenario_code2" name="scenario_code2" class="w150px" title="검색대상 선택">
													          <c:choose>
													            <c:when test="${scenario_code2 eq null || empty scenario_code2}">
													              <option value="">도로/상황</option>
													            </c:when>
													            <c:otherwise>
													              <option value="">도로/상황</option>
													              <c:forEach var="list" items="${scenario_code2}" varStatus="loop">
													                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq paramMap.selectScenarioCodeVal2}">selected</c:if>>${list.codeDetlNm}</option>
													              </c:forEach>
													            </c:otherwise>
													          </c:choose>
													        </select>
													        <select id="scenario_code3" name="scenario_code3" class="w150px" title="검색대상 선택">
													          <c:choose>
													            <c:when test="${scenario_code3 eq null || empty scenario_code3}">
													              <option value="">날씨</option>
													            </c:when>
													            <c:otherwise>
													              <option value="">날씨</option>
													              <c:forEach var="list" items="${scenario_code3}" varStatus="loop">
													                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq paramMap.selectScenarioCodeVal3}">selected</c:if>>${list.codeDetlNm}</option>
													              </c:forEach>
													            </c:otherwise>
													          </c:choose>
													        </select>
												        </div>
												    </td>
										        </tr>
	                                            <tr>
	                                                <th scope="row">수집차량 모델</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <label for="" class="ui-form-width--full">
	                                                                <select name="selectDataType" id="selectDataType" title="수집차량 모델 선택">
																		<c:choose>
																			<c:when test="${bbs_list eq null || empty bbs_list}">
																			<option value="">수집차량 모델</option>
																			</c:when>
																			<c:otherwise>
																			<option value="">수집차량 모델</option>
																			<c:forEach var="list" items="${bbs_list}" varStatus="loop">
																			<option value="${list.bbsSeq}" <c:if test="${list.bbsSeq eq paramMap.dataType}">selected</c:if>>${list.bbsNm}</option>
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
	                                                <th scope="row"><span class="el-essential">*</span>공유 데이터 제목</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <label for="" class="ui-form-width--full">
	                                                                <input type="text" class="ui-input ui-form-width--full" id="docTit" name="docTit" title="공유 데이터 제목 입력">
	                                                            </label>
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row"><span class="el-essential">*</span>이용목적</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <textarea name="docCnt" id="docCnt" class="w-100" style="height:100px" title="이용목적 입력"></textarea>
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row"><span class="el-essential">*</span>활용방안</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form">
	                                                        <div class="ui-form-block">
	                                                            <textarea name="prcuseMthd" id="prcuseMthd" class="w-100" style="height:100px" title="활용방안 입력"></textarea>
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row"><span class="el-essential">*</span>희망 방문일시</th>
	                                                <td colspan="3">
	                                                    <div class="ui-form ui-form-row align-center js-datepicker-range">
	                                                       <div class="ui-form-block">
	                                                            <input type="text" class="ui-input ui-form-width--140 js-datepicker" id="dsrVstDt" name="dsrVstDt" title="사고일시" />
	                                                        </div>
	                                                    </div>
	                                                </td>
	                                            </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                
	                                <div class="term-box">
                                        <div class="term-box__inner">
                                            <p class="font-l fontW-b ta-c">보안서약서</p>
                                            <p class="mt-20 font-16">오프라인 공유 데이터 보안 관리 지침</p>
                                            <ul class="lists lists-num">
                                                <li>국가공간정보기본법 제38조에 따른 비밀 준수 및 공간정보 보호 의무</li>
                                                <li>제공받은 데이터 취급 인원에 대한 신원확인, 서약 집행 및 보안 교육</li>
                                                <li>제공받은 데이터 보관·관리 장소 및 작업장소를 통제구역 또는 제한구역으로 설정</li>
                                                <li>제공받은 데이터 국외 반출 금지</li>
                                                <li>
                                                    외국인을 제공받은 데이터 취급 관련 업무에 종사하게 할 때는 별도의 보안 관리 지침을 마련해야 함
                                                    <ul class="lists lists-num lists-num--theses">
                                                        <li>신원확인, 신상기록부 작성·유지, 보안 교육 및 서약 집행</li>
                                                        <li>계약서에 기밀 누설·유출 시 해고 및 손해 배상 책임 명시</li>
                                                        <li>비공개 등 중요 공간정보 취급 및 보호구역 출입 차단 대책</li>
                                                    </ul>
                                                </li>
                                                <li>제공받은 데이터는 신청서에 기재된 목적대로 사용하며, 그 외 다른 용도로 사용 금지</li>
                                                <li>제공받은 데이터의 내용을 임의로 수정, 편집하거나 불법으로 복제, 복사하여 제3자 등에게 배포 금지</li>
                                                <li>
                                                    위의 열거사항을 위반 시 공공의 안전과 이익을 해할 자료임을 충분히 인식하고 아래에 규정된 처벌과 불이익을 감수해야함
                                                    <ul class="lists lists-num lists-num--theses">
                                                        <li>국가공간정보기본법 제39조, 제40조, 제41조의 처벌</li>
                                                        <li>제공된 데이터 및 그와 관련된 결과물·산출물 등 환수</li>
                                                    </ul>
                                                </li>
                                            </ul>
                                            
                                            <p class="mt-30 font-l fontW-500 color--black ta-r">
                                                한국교통안전공단 이사장
                                                <span class="font-r">귀하</span>
                                            </p>
                                        </div>
                                    </div>
                                    
                                    <div class="d-flex align-center">
                                        <div class="ui-form ui-form-row">
                                            <div class="ui-form-check ui-form-row">
                                                <label for="input-check__us_fa_02" class="ui-form-check__label" id="check" style="cursor:pointer;">
                                                <input type="checkbox" id="input-check__us_fa_02" class="ui-input ui-form-check__input"  id="check">
                                                <span class="ui-form-check__span">체크박스</span>
                                                    상기의 기재사항에 동의하며 공간정보 데이터에 대한 오프라인 데이터 공유를 의뢰합니다.
                                                </label>
                                            </div>
                                        </div>
                                        <!-- <p class="ml-auto mr-20 font-16">(서명 또는 직인)</p>
                                        <button type="button" class="btn btn-height--s btn-color--navy color-white" style="border-radius:2px;">서명하기</button> -->
                                    </div>
	
	
									<div class="btn-wrap btn-row justify-center mt-30 mb-80">
										<button type="button" id="cancle" class="btn btn-width--l btn-color--white" onclick="fn_goList();">취소</button>
										<button type="button" id="goToList" class="btn btn-width--l btn-color--navy" onclick="fn_submit();">신청하기</button>
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

<!-- <form id="excelForm" name="excelForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
</form> -->
