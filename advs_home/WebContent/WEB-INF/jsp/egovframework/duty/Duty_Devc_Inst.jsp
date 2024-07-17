<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer>

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

    jQuery.browser = {};
    (function () {
      jQuery.browser.msie = false;
      jQuery.browser.version = 0;
      if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
      }
    })();

    // 주행모드
		$('input[name="radio_drivingMod"]').change(function() {
		      if($('input[name="radio_drivingMod"]:checked').val() == "Y") {
				$("#dm_table").show();
		      } else {
		        $("#dm_table").hide();
		        $("#dm_before_spec").val('');
		        $("#dm_after_spec").val('');
		      }
		    });
    	
    	// 작동속도범위
    	$('input[name="radio_speedMod"]').change(function() {
		      if($('input[name="radio_speedMod"]:checked').val() == "Y") {
				$("#sr_table").show();
		      } else {
		        $("#sr_table").hide();
		        $("#src_before_spec").val('');
		        $("#src_after_spec").val('');
		      }
		    });
	    
	    // 구조 및 장치
	    $('input[name="radio_equipMod"]').change(function() {
		      if($('input[name="radio_equipMod"]:checked').val() == "Y") {
				$("#dc_table").show();
		      } else {
		        $("#dc_table").hide();
		        $("#dc_before_spec").val('');
		        $("#dc_after_spec").val('');
		      }
		    });
	    
	    $('#cancle').on('click', function() {
	    	location.href='/duty/device/Duty_Devc_List.do';
	    });
	    
  	});
		  /* 등록 function */
			function fn_Insert() {
				if(confirm("등록 하시겠습니까?")) {
		      if(trim(c_form.tmp_race_number.value).length==0){
		        alert("임시운행등록번호를 선택해주세요");
						c_form.tmp_race_number_view.focus();
						return;
					}

					var modify_date_d = $("#modify_date_d option:selected").val();
					if(modify_date_d == "") {
						alert("변경일자를 선택해주세요");
						c_form.modify_date_d.focus();
						return;
					}

		      var radio_drivingModYn = $("input[name='radio_drivingMod']:checked").val();
					if(radio_drivingModYn == "Y") {
		        if(trim(c_form.dm_before_spec.value).length==0){
		  				alert("주행모드 변경전 내용을 입력해주세요");
		  				c_form.dm_before_spec.value="";
		  				c_form.dm_before_spec.focus();
		  				return;
		  			}
		        if(trim(c_form.dm_after_spec.value).length==0){
		  				alert("주행모드 변경후 내용을 입력해주세요");
		  				c_form.dm_after_spec.value="";
		  				c_form.dm_after_spec.focus();
		  				return;
		  			}
					}

		      var radio_speedModYn = $("input[name='radio_speedMod']:checked").val();
					if(radio_speedModYn == "Y") {
		        if(trim(c_form.src_before_spec.value).length==0){
		  				alert("작동 및 속도범위 변경전 내용을 입력해주세요");
		  				c_form.src_before_spec.value="";
		  				c_form.src_before_spec.focus();
		  				return;
		  			}
		        if(trim(c_form.src_after_spec.value).length==0){
		  				alert("작동 및 속도범위 변경후 내용을 입력해주세요");
		  				c_form.src_after_spec.value="";
		  				c_form.src_after_spec.focus();
		  				return;
		  			}
					}

		      var radio_equipModYn = $("input[name='radio_equipMod']:checked").val();
					if(radio_equipModYn == "Y") {
		        if(trim(c_form.dc_before_spec.value).length==0){
		  				alert("구조 및 장치 변경전 내용을 입력해주세요");
		  				c_form.dc_before_spec.value="";
		  				c_form.dc_before_spec.focus();
		  				return;
		  			}
		        if(trim(c_form.dc_after_spec.value).length==0){
		  				alert("구조 및 장치 변경후 내용을 입력해주세요");
		  				c_form.dc_after_spec.value="";
		  				c_form.dc_after_spec.focus();
		  				return;
		  			}
					}

		      if(trim(c_form.customFile1.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile1, 100)) return c_form.customFile1.focus();
					}
		      if(trim(c_form.customFile2.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile2, 100)) return c_form.customFile2.focus();
					}
		      if(trim(c_form.customFile3.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile3, 100)) return c_form.customFile3.focus();
					}
		      if(trim(c_form.customFile4.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile4, 100)) return c_form.customFile4.focus();
					}
		      if(trim(c_form.customFile5.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile5, 100)) return c_form.customFile5.focus();
					}
		      if(trim(c_form.customFile6.value).length>0) {
		        if(!fileSizeCheck(c_form.customFile6, 100)) return c_form.customFile6.focus();
					}

		      if(trim(c_form.change_info.value).length==0){
						alert("변경내용기술을 입력해주세요");
						c_form.change_info.value="";
						c_form.change_info.focus();
						return;
					}

		      $("#btn_sm").hide();
		      //$("#loading").show();

					document.listForm.action = "<c:url value='/duty/device/Duty_Devc_Inst_Process.do'/>";
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

		</script>
<!-- form start -->
<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="tmp_race_number" id="tmp_race_number"/>

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
	                            <div class="lnb-item">
	                                <a href="/duty/driving/Duty_Drvg_List.do">운행정보보고서</a>
	                            </div>
	                            <div class="lnb-item is-active">
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
	                            <h5 class="layout-content__subtit d-flex">장치 및 기능변경 등록</h5>
								 <!-- contents -->
								 <div class="table-wrap">
								 	<table class="table-basic table-basic--row">
								 		<caption>운행정보보고 &gt; 장치 및 기능변경 &gt; 장치 및 기능변경 등록 테이블</caption>
								         <colgroup>
								             <col style="width:18%">
								             <col style="width:auto">
								             <col style="width:18%">
								             <col style="width:34%">
								         </colgroup>
								         <tbody>
								          <tr>
								              <th scope="row">
								                  <span class="el-essential">*</span> 임시운행기관
								              </th>
								              <td>
								              	<div class="ui-form">
	                                            	<div class="ui-form-block">
	                                                	<input type="text" class="w100p input_50per" readonly="" id="tmp_race_agency" name="tmp_race_agency">
	                                          		</div>
	                                          	</div>      	
	                                          </td>
								              <th scope="row">임시운행등록번호</th>
								              <td>
								              	<select id="tmp_race_number_view" name="tmp_race_number_view" class="w100p" onchange="javascript:fn_tmpEvent(this.value)">
								                 <c:choose>
								                   <c:when test="${code_tempoper eq null || empty code_tempoper}">
								                     <option value="">-</option>
								                   </c:when>
								                   <c:otherwise>
								                     <option value="">-선택-</option>
								                     <c:forEach var="list" items="${code_tempoper }" varStatus="loop">
								                       <option value="${list.tmpNumber}|${list.tmpAgency}">${list.tmpNumber}</option>
								                     </c:forEach>
								                   </c:otherwise>
								                 </c:choose>
							                </select>
						                </td>
						            </tr>
						            <tr>
                                       <th scope="row"><span class="el-essential">*</span> 변경일자</th>
                                       <td colspan="3">
                                           <div class="ui-form ui-form-row align-center js-datepicker">
                                               <div class="ui-form-block">
                                                   <input type="text" id="modify_date_d" name="modify_date_d" class="ui-input ui-form-width--140 js-datepicker" title="변경일시">
                                                   <label for="modify_date_h">
                                                       <select name="modify_date_h" id="modify_date_h" class="ui-form-width--xs" title="변경일_시간">
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
                                                   </label> 시
                                                   <label for="modify_date_m" class="ml-10">
                                                       <select name="modify_date_m" id="modify_date_m" class="ui-form-width--xs" title="변경일_분">
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
                                                   </label> 분
                                               </div>
                                           </div>
                                       </td>
                                   </tr>
                               </tbody>
					    	</table>
					    </div>
					    <h5 class="layout-content__subtit d-flex align-end">주행모드
                             <div class="ui-form ml-auto">
                                 <label for="radio_drivingModY">
                                     <input type="radio" name="radio_drivingMod" checked id="radio_drivingModY" class="ui-input ui-input-radio"  value="Y" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경</span>
                                 </label>
                                 <label for="radio_drivingModN" class="ml-30">
                                     <input type="radio" name="radio_drivingMod" id="radio_drivingModN" class="ui-input ui-input-radio" value="N" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경안함</span>
                                 </label>
                             </div>
                         </h5>
                         <table class="table-basic table-basic--row mt-20 table-us_du_03_write--02" id="dm_table">
	                         <caption>운행정보보고 &gt; 장치 및 기능변경 &gt; 주행모드 테이블</caption>
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
	                                 <td>
	                                     <div class="ui-form ui-form-row align-center">
	                                         <div class="ui-form-block ui-form-width--full">
	                                             <input type="text" class="ui-input ui-form-width--full" id="dm_before_spec" name="dm_before_spec" title="주행모드 변경전 입력" />
	                                         </div>
	                                     </div>
	                                 </td>
	                                 <td>
	                                     <div class="ui-form ui-form-row align-center">
	                                         <div class="ui-form-block ui-form-width--full">
	                                             <input type="text" class="ui-input ui-form-width--full" id="dm_after_spec" name="dm_after_spec" title="주행모드 변경후 입력" />
	                                         </div>
	                                     </div>
	                                 </td>
	                             </tr>
	                             <tr>
	                                 <td>
	                                     <div class="ui-form">
                                             <div class="file">
                                                 <div class="file__input ui-form-width--auto" id="file__input">
                                                     <input type="file" class="file__input--find" id=customFile1 name="customFile1" multiple="multiple">
                                                     <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                     <label for="customFile1" class="file__input--label file__input--labelFind">파일찾기</label>
                                                 </div>
                                             </div>
	                                     </div>
	                                 </td>
	                                 <td>
	                                     <div class="ui-form">
                                             <div class="file">
                                                 <div class="file__input ui-form-width--auto" id="file__input">
                                                     <input type="file" class="file__input--find" id="customFile2"  name="customFile2">
                                                     <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                     <label for="customFile2"  class="file__input--label file__input--labelFind" >파일찾기</label>
                                                 </div>
                                             </div>
	                                     </div>
	                                 </td>
	                             </tr>
	                         </tbody>
	                     </table>
	                     <h5 class="layout-content__subtit d-flex align-end mt-30">
                             작동 및 속도범위
                             <div class="ui-form ml-auto">
                                 <label for="radio_speedY">
                                     <input type="radio" name="radio_speedMod" checked id="radio_speedY" class="ui-input ui-input-radio" value="Y" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경</span>
                                 </label>
                                 <label for="radio_speedN" class="ml-30">
                                     <input type="radio" name="radio_speedMod" id="radio_speedN" class="ui-input ui-input-radio" value="N" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경안함</span>
                                 </label>
                             </div>
                         </h5>
                         <table class="table-basic table-basic--row mt-20 table-us_du_03_write--02"  id="sr_table">
                             <caption>운행정보보고 &gt; 장치 및 기능변경 &gt; 작동 및 속도범위 테이블</caption>
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
                                     <td>
                                         <div class="ui-form ui-form-row align-center">
                                             <div class="ui-form-block ui-form-width--full">
                                                 <input type="text" id="src_before_spec" name="src_before_spec" class="ui-input ui-form-width--full" title="작동 및 속도범위 변경전 입력">
                                             </div>
                                         </div>
                                     </td>
                                     <td>
                                         <div class="ui-form ui-form-row align-center">
                                             <div class="ui-form-block ui-form-width--full">
                                                 <input type="text" id="src_after_spec" name="src_after_spec" class="ui-input ui-form-width--full" title="작동 및 속도범위 변경후 입력">
                                             </div>
                                         </div>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <div class="ui-form">
                                            <div class="file">
                                                <div class="file__input ui-form-width--auto" id="file__input">
                                                    <input class="file__input--find" id="customFile3" type="file" multiple="multiple" name="customFile3">
                                                    <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                    <label class="file__input--label file__input--labelFind" for="customFile3">파일찾기</label>
                                                </div>
                                            </div>
                                         </div>
                                     </td>
                                     <td>
                                         <div class="ui-form">
                                             <div class="file">
                                                 <div class="file__input ui-form-width--auto" id="file__input">
                                                     <input class="file__input--find" id="customFile4" type="file" multiple="multiple" name="customFile4">
                                                     <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                     <label class="file__input--label file__input--labelFind" for="customFile4">파일찾기</label>
                                                 </div>
                                             </div>
                                         </div>
                                     </td>
                                 </tr>
                             </tbody>
                         </table>
                         <h5 class="layout-content__subtit d-flex align-end mt-30">
                             구조 및 장치변경
                             <div class="ui-form ml-auto">
                                 <label for="radio_equipChangeY">
                                     <input type="radio" name="radio_equipMod" checked id="radio_equipChangeY" class="ui-input ui-input-radio" value="Y" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경</span>
                                 </label>
                                 <label for="radio_equipChangeN" class="ml-30">
                                     <input type="radio" name="radio_equipMod" id="radio_equipChangeN" class="ui-input ui-input-radio" value="N" />
                                     <span class="ui-input-radio__span"></span>
                                     <span class="ui-input-radio__txt">변경안함</span>
                                 </label>
                             </div>
                         </h5>
                         <table class="table-basic table-basic--row mt-20 table-us_du_03_write--02" id="dc_table">
                             <caption>운행정보보고 &gt; 장치 및 기능변경 &gt; 구조 및 장치변경 테이블</caption>
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
                                     <td>
                                         <div class="ui-form ui-form-row align-center">
                                             <div class="ui-form-block ui-form-width--full">
                                                 <input type="text" id="dc_before_spec" name="dc_before_spec" class="ui-input ui-form-width--full" title="구조 및 장치변경 변경전 입력">
                                             </div>
                                         </div>
                                     </td>
                                     <td>
                                         <div class="ui-form ui-form-row align-center">
                                             <div class="ui-form-block ui-form-width--full">
                                                 <input type="text" id="dc_after_spec" name="dc_after_spec" class="ui-input ui-form-width--full" title="구조 및 장치변경 변경후 입력">
                                             </div>
                                         </div>
                                     </td>
                                 </tr>
                                 <tr>
                                     <td>
                                         <div class="ui-form">
                                             <div class="file">
                                                 <div class="file__input ui-form-width--auto" id="file__input">
                                                     <input class="file__input--find" id="customFile5" type="file" multiple="multiple" name="customFile5">
                                                     <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                     <label class="file__input--label file__input--labelFind" for="customFile5">파일찾기</label>
                                                 </div>
                                             </div>
                                         </div>
                                     </td>
                                     <td>
                                         <div class="ui-form">
                                             <div class="file">
                                                 <div class="file__input ui-form-width--auto" id="file__input">
                                                     <input class="file__input--find" id="customFile6" type="file" multiple="multiple" name="customFile6">
                                                     <input class="file__upload--name ui-form-width--auto flex-1" disabled="" placeholder="선택된 파일 없음">
                                                     <label class="file__input--label file__input--labelFind" for="customFile6">파일찾기</label>
                                                 </div>
                                             </div>
                                         </div>
                                     </td>
                                 </tr>
                             </tbody>
                         </table>
                         <table class="table-basic table-basic--row mt-20 table-us_du_03_write--02">
                            <caption>운행정보보고 &gt; 장치 및 기능변경 &gt; 구조 및 장치변경 변경 내용기술 테이블</caption>
                            <colgroup>
                                <col style="width:18%">
                                <col style="width:auto">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><span class="el-essential">*</span> 변경사항 내용기술</th>
                                    <td>
                                        <div class="ui-form">
                                        	<textarea name="change_info" id="change_info" class="ui-form-width--full ui-form-height--100"></textarea>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div id="btn_sm" class="btn-wrap btn-row justify-center mt-30 mb-80">
                            <button type="button" id="cancle" class="btn btn-width--l btn-color--white">취소</button>
                            <button type="button" onClick="javascript:fn_Insert();" class="btn btn-width--l btn-color--navy">등록</button>
                        </div>
                        <div id="loading" class="center" style="display:none">
				        	<img src="/images/avsc/loading.gif">
				      	</div>
				    </div>
			    </div>
		    </div>
	    </div>
	   </div>
	  </div>
	 </div>
	</div>
   </form:form><!-- form END -->
    