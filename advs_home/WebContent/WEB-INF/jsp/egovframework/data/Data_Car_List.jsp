<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" >

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    $("span[id=sp_off]").hide();

    //펼치기
    $("span[id=sp_on]").click(function() {
    	var idx = $("span[id=sp_on]").index(this);
    	$(this).hide();
    	$("span[id=sp_off]:eq("+idx+")").show();
    	$("tr[id=plain]:eq("+idx+")").show();
    });
    
    //접기
    $("span[id=sp_off]").click(function() {
    	var idx = $("span[id=sp_off]").index(this);
    	$("tr[id=plain]:eq("+idx+")").hide();
    	$("span[id=sp_on]:eq("+idx+")").show();
    	$("span[id=sp_off]:eq("+idx+")").hide();
    });
  });
  

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/data/record/Data_Car_List.do'/>";
		c_form.submit();
	}
</script>
<script type="text/javaScript" language="javascript" defer="defer">
	/* 수정 function */
	function fn_Update() {
		if(confirm("수정 하시겠습니까?")) {
		  if(trim(c_form.tmp_race_number.value).length==0){
					alert("임시운행등록번호를 입력해주세요");
					c_form.tmp_race_number.focus();
					return;
				}
		
		  if(trim(c_form.isexist.value) != "Y"){
					alert("임시운행등록번호 중복을 확인해주세요");
					c_form.tmp_race_number.focus();
					return;
				}
		
		  if(trim(c_form.tmp_race_agency.value).length==0){
					alert("임시운행기관을 입력해주세요");
					c_form.tmp_race_agency.focus();
					return;
				}
		
		  if(trim(c_form.ins_letter_number.value).length==0){
					alert("보험증서번호를 입력해주세요");
					c_form.ins_letter_number.focus();
					return;
				}
		
		  if(trim(c_form.ins_init_date.value).length==0){
					alert("보험가입일자를 선택해주세요");
					c_form.ins_init_date.focus();
					return;
				}
		  
		//   alert("str : " +c_form.tmp_race_number.value);
		        
				document.listForm.action = "<c:url value='/common/Duty_Tpsv_Inst_Process.do'/>";
				document.listForm.submit();
			}
	}
	
	/* 중복확인 function */
	function fn_IsExist() {
    if(trim(c_form.tmp_race_number1.value).length==0){
      alert("임시운행등록번호를 입력해주세요1");
      return;
    } else if(trim(c_form.tmp_race_number2.value).length==0){
        alert("임시운행등록번호를 입력해주세요2");
        c_form.tmp_race_number2.focus();
        return;    
    } else if(trim(c_form.tmp_race_number3.value).length==0){
        alert("임시운행등록번호를 입력해주세요3");
        c_form.tmp_race_number3.focus();
        return;   
    } else if(trim(c_form.tmp_race_number4.value).length==0){
        alert("임시운행등록번호를 입력해주세요4");
        c_form.tmp_race_number4.focus();
        return;       
    } else if((trim(c_form.tmp_race_number3.value)==0) && (trim(c_form.tmp_race_number4.value)==0)){
        alert("임시운행등록번호에 '000'을 입력할 수 없습니다.");
        c_form.tmp_race_number4.focus();
        return;         
    } else {
    var str = c_form.tmp_race_number1.value+'-'+c_form.tmp_race_number2.value+c_form.tmp_race_number3.value+c_form.tmp_race_number4.value;
  //  alert("str : " +str);
    c_form.tmp_race_number.value = str;
      $.ajax( {
        type : "POST",
        cache: false,
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        url : "/common/Duty_Tpsv_IsExist.do",
        data : {
          tmp_race_number : c_form.tmp_race_number.value
        },
        success : function(data) {
          var arr = eval(data);
          if( arr == null) {
            return;
          } else {
            var result = arr[0].result;
            if(result == 0) {
              alert("등록이 가능한 번호입니다");
              c_form.isexist.value = "Y";
            } else if(result > 0) {
              alert("존재하는 번호입니다");
              c_form.isexist.value = "N";
            }
          }
        },
        error : function(data) {
        }
      });
    }
  }
	//
	function fnOnlyFormatNo(obj){
		var str = obj.value;
		obj.value = (str.replace(/[^0-9\-]/g,''));
	}  
</script>


<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="b_title" id="b_title"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="isexist" id="isexist"/>
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
                                    <h3 class="lnb__tit">MY DATA</h3>
                                    <div class="lnb-list">
                                        <div class="lnb-item">
                                        
                                            <a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a>
                                        </div>
                                        <div class="lnb-item">
                                            <a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a>
                                        </div>
<!--                                         <div class="lnb-item"> -->
<!--                                          <a href="/data/record/Data_Car_Inst.do">차량등록</a> -->
<!--                                         </div> -->
                                        <div class="lnb-item is-active">
                                            <a href="/data/record/Data_Car_List.do">차량관리</a>
                                        </div>
                                        <div class="lnb-item">
                                            <a href="/data/request/Data_Delega_Auth.do">권한위임</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="layout-content">
                                    <div class="layout-content__inner">
                                        <div class="layout-content__top">
                                            <h4 class="layout-content__tit">차량관리</h4>
                                            <ul class="location ml-auto">
                                                <li>
                                                    <img src="/image/sub/icon/icon-home.png" alt="홈">
                                                </li>
                                                <li>MY DATA</li>
                                                <li>내가 받은 자료</li>
                                            </ul>
                                        </div>
                                        <%-- <div class="sch-area sch-area--box sch-area--gray">
                                            <div class="sch-form sch-form--row">
                                                 <label for="">
                                                    <select id="searchBord" name="searchBord" title="대상 데이터 선택" class="w250px">
											          <c:choose>
											            <c:when test="${code_bbsseq eq null || empty code_bbsseq}">
											              <option value="">데이터구분 전체</option>
											            </c:when>
											            <c:otherwise>
											              <option value="">데이터구분 전체</option>
											              <c:forEach var="list" items="${code_bbsseq }" varStatus="loop">
											                <option value="${list.bbsSeq }" <c:if test="${list.bbsSeq eq searchBord }">selected</c:if>>${list.bbsNm }</option>
											              </c:forEach>
											            </c:otherwise>
											          </c:choose>
									        		</select>
                                                 </label>
                                                 <label for="">
                                                     <select id="searchType" name="searchType" title="검색대상 선택">
											          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
											          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
											          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
									        		</select>
									        	</label>
									        	<label for="">
                                                    <input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" />
                                                </label>
                                                	<button type="button" class="btn btn--sch" title="검색" onclick="form_Submit();">
                                                	</button>
                                            </div>
                                        </div> --%>
                                        <div class="table-wrap">
                                            <div class="table-cap">
                                                <p class="table-cap__count">
                                                	총 <span>${pageSetting.totalRecordCount} </span> 건 
                                                </p>
                                                <p class="table-cap__page">
                                                   	페이지 <span>${pageSetting.currentPageNo}</span>/${pageSetting.totalPageCount}
                                                </p>
                                            </div>
                                            <table class="table-basic table-basic--col table-us_du_01_list">
											<caption>공공데이터 &gt; 일반시나리오 데이터셋 테이블</caption>
											<colgroup>
												<col style="width: 18%">
												<col style="width: auto">
												<col style="width: 18%">
												<col style="width: 18%">
<!-- 												<col style="width: 18%"> -->
											</colgroup>
											<thead>
												<tr>
													<th scope="col">임시운행 등록번호</th>
													<th scope="col">임시운행 기관</th>
													<th scope="col">보험 가입일자</th>
													<th scope="col">신청 상태</th>
<!-- 													<th scope="col">보기</th> -->
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${resultList eq null || empty resultList}">
														<tr>
															<td colspan="5">등록된 정보가 없습니다</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="list" items="${resultList}" varStatus="status">
															<tr>
																<td>${list.tmpNumber}</td>
																<td>${list.tmpAgency}</td>
																<td>${list.insInitDateView}</td>
																<td>
																	<c:choose>
																		<c:when test="${list.apporStatus eq '101'}">
																			<button type="button" class="btn btn-height--s btn-color--caution">승인 완료</button>
																		</c:when>
																		<c:otherwise>
																			<button type="button" class="btn btn-height--s btn-color--w">승인 대기</button>
																		</c:otherwise>
																	</c:choose>
																</td>
<!-- 																<td class="right"> -->
<!-- 											                      <span id="sp_on"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">펼치기</a></span> -->
<!-- 											                      <span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">접기</a></span> -->
<!-- 											                    </td> -->
															</tr>
															<%-- <tr id="plain" style="display:none" class="">
											                    <td colspan="5" class="left border_l_none tdCont">
											                      <div class="list">
											                        <table summary="" class="center">
											                          <colgroup>
																		<col style="width: auto">
																		<col style="width: auto">
																		<col style="width: auto">
																		<col style="width: auto">
											                          </colgroup>
											                          <thead>
											                            <tr>
											                              <th class="border_l_none">임시운행등록번호</th>
											                              <th class="lh_sm">임시운행기관</th>
											                              <th class="lh_sm">보험 가입일자</th>
											                              <th class="lh_sm">수정하기</th>
											                            </tr>
											                          </thead>
											                          <tbody>
											                            <tr>
											                              <td class="border_l_none lh_sm">
											                                <c:set var="ymd" value="<%=new java.util.Date()%>" />
											                              	<input type="text" class="popW60 pd15" id="tmp_race_number1" name="tmp_race_number1" onkeyup="fnOnlyFormatNo(this); checkLength(this,4);" value="<fmt:formatDate value='${ymd}' pattern='yyyy' />">
																            -
																            <input type="text" class="popW40 pd15" id="tmp_race_number2"  readonly="" name="tmp_race_number2" value="0">
																            <input type="text" class="popW40 pd15" id="tmp_race_number3" name="tmp_race_number3" onkeyup="fnOnlyFormatNo(this); checkLength(this,1);">
																            <input type="text" class="popW40 pd15" id="tmp_race_number4" name="tmp_race_number4" onkeyup="fnOnlyFormatNo(this); checkLength(this,1);">
																            <a href="javascript:fn_IsExist();" class="but_sky but_xs m-l6">중복확인</a>
																            <input type="hidden" class="w50p" id="tmp_race_number" name="tmp_race_number" >
											                              </td>
											                              <td class="border_l_none lh_sm">
											                              	<input type="text" class="ui-input ui-form-width--r" id="tmp_race_agency" name="tmp_race_agency" onkeyup="checkLength(this,100)" value="${list.tmpAgency}">
											                              </td>
											                              <td class="border_l_none lh_sm">
											                              	<input type="text" class="ui-input ui-form-width--140 js-datepicker" id="ins_init_date" name="ins_init_date" value="${list.insInitDateView}">
											                              </td>
											                              <td class="border_l_none lh_sm">
<!-- 											                              	<div class="btn-wrap btn-row justify-center"> -->
<!-- 											                                    <button type="button" class="btn btn-width--l btn-color--navy" id="btnInst" onclick="fn_Insert()">등록</button> -->
<!-- 											                                </div> -->
											                              	<div class="btn-row justify-center">
											                              	  <a href="javascript:fn_Update();" class="but_sky but_md">수정</a>
											                              	  <a href="javascript:fn_Delete();" class="but_sky but_md">신청취소</a>
											                              	</div>
											                              </td>
											                            </tr>
											                          </tbody>
											                        </table>
											                      </div>
											                    </td>
											                  </tr> --%>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
                                        </div>
                                        <!-- pagenum : s -->
                                            <div class="page-wrap">
                                        <div class="paging">
                                            <a href="javascript:go_Page('1');" class="page-link page-link--first">
                                                <img src="/image/common/icon/icon-page-link--first.png" alt="">
                                            </a>
                                            <a href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" class="page-link page-link--prev">
                                                <img src="/image/common/icon/icon-page-link--prev.png" alt="">
                                            </a>
                                            <c:forEach var="i"  begin="${pageSetting.firstPageNoOnPageList }" end="${pageSetting.lastPageNoOnPageList }">
									            <c:choose>
									              <c:when test="${pageSetting.currentPageNo eq i }">
									                <a href="javascript:void(0);" class="active">${i }</a>
									              </c:when>
									              <c:otherwise>
									                <a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
									               </c:otherwise>
									             </c:choose>
									          </c:forEach>
                                            
<%--                                             <a class="active" href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음"></a> --%>
<%--           									<a class="active" href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로"></a> --%>
                                            
                                            <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" class="page-link page-link--next">
                                                <img src="/image/common/icon/icon-page-link--next.png" alt="">
                                            </a>
                                            <a href="javascript:go_Page('${pageSetting.totalPageCount }');" class="page-link page-link--last">
                                                <img src="/image/common/icon/icon-page-link--last.png" alt="">
                                            </a>
                                        </div>
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
