<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer>

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    $("span[id=sp_off]").hide();

    //상세검색 펼치기
    if('${searchDetl}' == "Y") {
      $(".searchWrap").show();
    } else {
      $(".searchWrap").hide();
    }

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

    $("#searchWord").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchBseq").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchMode").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchWeth").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchSitu").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchRoad").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchBdwr").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
  });

	/* 목록 화면 function */
	function form_Submit() {
    var searchBseq = $("#searchBseq option:selected").val();
    var searchMode = $("#searchMode option:selected").val();
    var searchWeth = $("#searchWeth option:selected").val();
    var searchSitu = $("#searchSitu option:selected").val();
    var searchRoad = $("#searchRoad option:selected").val();
    var searchBdwr = $("#searchBdwr option:selected").val();

    if(trim(c_form.searchDetl.value) != "Y") {
      $("#searchBseq").val("").attr("selected","selected");
      $("#searchMode").val("").attr("selected","selected");
      $("#searchWeth").val("").attr("selected","selected");
      $("#searchSitu").val("").attr("selected","selected");
      $("#searchRoad").val("").attr("selected","selected");
      $("#searchBdwr").val("").attr("selected","selected");
    }

    if(trim(c_form.searchWord.value).length == 0 ) {
      alert("검색조건을 하나이상 선택해주세요");
      return;
    } else {
      if(trim(c_form.searchWord.value).length > 0) {
        var sel = $("#searchType option:selected").val();
        if(sel == 0) {
          alert("검색대상을 선택해주세요");
          c_form.searchType.focus();
          return;
        } else {
          if(trim(c_form.searchWord.value).length==0){
            alert("검색어를 입력해주세요");
            c_form.searchWord.value="";
            c_form.searchWord.focus();
            return;
          }
          if(trim(c_form.searchWord.value).length < 2){
            alert("검색어는 2글자 이상 입력해주세요");
            c_form.searchWord.focus();
            return;
          }
        }
      }
      
      
      $("#searchWord1").val($("#searchWord").val());
      
      c_form.search.value="Y";
      c_form.action = "<c:url value='/agency/consultative/Agcy_Cons_List.do'/>";
      c_form.submit();
    }
	}

  /* 파일 다운로드  */
  function fn_Download_Hist(seq, file_nm) {
    c_form.b_seq.value = seq;
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "dtup";
    c_form.action = "<c:url value='/common/File_Download_Hist.do'/>";
    c_form.submit();
  }

  /* 다운로드 요청 팝업 화면 function */
  function fn_Add_Popup(id) {
    window.open('/agency/consultative/Agcy_Dtdw_Popup.do?b_seq='+id, 'dtdw_pop','left=200, top=100, width=500, height=385');
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/agency/consultative/Agcy_Cons_List.do'/>";
		c_form.submit();
	}

  //checkbox 값 설정
	function fn_check_box(obj) {
		if(obj.checked) {
      c_form.searchDetl.value = "Y";
      $(".searchWrap").show();
		} else {
      c_form.searchDetl.value = "N";
      $("#searchBseq").val("").attr("selected","selected");
      $("#searchMode").val("").attr("selected","selected");
      $("#searchWeth").val("").attr("selected","selected");
      $("#searchSitu").val("").attr("selected","selected");
      $("#searchRoad").val("").attr("selected","selected");
      $("#searchBdwr").val("").attr("selected","selected");
      $(".searchWrap").hide();
		}
	}

  //검색 검색초기화
  function fn_searchReset() {
    $("#searchWord").val("");
    $("#searchBseq").val("").attr("selected","selected");
    $("#searchMode").val("").attr("selected","selected");
    $("#searchWeth").val("").attr("selected","selected");
    $("#searchSitu").val("").attr("selected","selected");
    $("#searchRoad").val("").attr("selected","selected");
    $("#searchBdwr").val("").attr("selected","selected");
  }

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq" value="${bbs_seq}" />
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="search" id="search" value="${search}" />
<input type="hidden" name="searchDetl" id="searchDetl" value="${searchDetl}" />
<input type="hidden" name="searchWord1" id="searchWord1"/>

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
					  <!-- lmenu -->
					  <div class="lnb">
					      <h3 class="lnb__tit">협의체데이터</h3>
					      <div class="lnb-list">
	     					  <div class="lnb-item <c:if test="${bbs_seq eq '2080'}">is-active</c:if>"><a href="/open/normal/Open_Normal_List.do?bbs_seq=2080">일반시나리오 데이터셋</a></div>
	 						  <div class="lnb-item <c:if test="${bbs_seq eq '2090'}">is-active</c:if>"><a href="/open/edge/Open_Edge_List.do?bbs_seq=2090">엣지케이스 시나리오<br/>데이터셋</a></div>
	                          <div class="lnb-item <c:if test="${bbs_seq eq '2100'}">is-active</c:if>"><a href="/open/v2x/Open_V2x_List.do?bbs_seq=2100">V2X 데이터셋</a></div>
					          <div class="lnb-item"><a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br/>안내 및 신청</a></div>
					          <div class="lnb-item is-active is-open">
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
		  			  <!-- lmenu -->
		  <c:if test="${search eq 'Y'}">
		    <c:set var="bbs_nm" value="통합검색" />
		  </c:if>
		  <!--  layout-content -->
		  <div class="layout-content">
		  	<div class="layout-content__inner">
		  		<div class="layout-content__top">
	                <h4 class="layout-content__tit">데이터셋(21년 이전)</h4>
	                <ul class="location ml-auto">
	                    <li><img src="/image/sub/icon/icon-home.png" alt="홈"></li>
	                    <li>협의체데이터</li>
	                    <li>데이터셋(21년 이전)</li>
	                    <li>
	                    	<c:choose>
		                    	<c:when test="${bbs_seq eq '2010'}">차량거동정보</c:when>
		                    	<c:when test="${bbs_seq eq '2030'}">센서정보</c:when>
		                    	<c:when test="${bbs_seq eq '2040'}">자율주행학습정보</c:when>
		                    	<c:when test="${bbs_seq eq '2050'}">융합정보</c:when>
		                    	<c:when test="${bbs_seq eq '2060'}">V2X정보</c:when>
		                    	<c:when test="${bbs_seq eq '2070'}">기타자율주행정보</c:when>
		                    	<c:otherwise>데이터셋</c:otherwise>
	                    	</c:choose>
	                    </li>
<%-- 	                    <li>${dataTypeView}</li> --%>
	                </ul>
                </div>
				<h5 class="layout-content__subtit">
					<c:if test="${bbs_seq eq 2010}">
						<c:out value="차량거동정보"/>
					</c:if>
					<c:if test="${bbs_seq eq 2030}">
						<c:out value="센서정보"/>
					</c:if>
					<c:if test="${bbs_seq eq 2040}">
						<c:out value="자율주행 학습정보"/>
					</c:if>
					<c:if test="${bbs_seq eq 2050}">
						<c:out value="융합정보"/>
					</c:if>
					<c:if test="${bbs_seq eq 2060}">
						<c:out value="V2X 정보"/>
					</c:if>
					<c:if test="${bbs_seq eq 2070}">
						<c:out value="기타자율주행정보"/>
					</c:if>
				</h5>
                <div class="sch-area sch-area--box sch-area--gray">
                    <div class="sch-form sch-form--row">
<!--                         <form action=""> -->
                            <label for="">
                                <select name="" id="" title="데이터셋 차량거동정보 검색구분 선택">
                                    <option value="">전체</option>
                                    <option value="">내용</option>
                                </select>
                            </label>
                            <label for="">
                                <input type="text" name="searchWord" id="searchWord" title="검색어 입력" placeholder="검색어를 입력해주세요.">
                            </label>
                            <button type="button" class="btn btn--sch" title="검색" onclick="form_Submit()"></button>
<!--                             <button type="button" class="btn btn--schDetail" title="상세검색" onclick="fn_check_box(this)">상세검색</button> -->
<!--                         </form> -->
                    </div>
                </div>   
                <div class="sch-form__detail sch-form--row">
                            <select name="searchBseq" id="searchBseq" title="데이터셋 차량거동정보 데이터유형 선택">
					          <c:choose>
					            <c:when test="${bbs_list eq null || empty bbs_list}">
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 데이터유형 선택 >></option>
					              <c:forEach var="list" items="${bbs_list}" varStatus="loop">
					                <option value="${list.bbsSeq}" <c:if test="${list.bbsSeq eq searchBseq}">selected</c:if>>${list.bbsNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        <label for="">
                            <select name="searchMode" id="searchMode" title="데이터셋 차량거동정보 주행모드 선택">
					          <c:choose>
					            <c:when test="${code_driving_mode eq null || empty code_driving_mode}">
					              <option value=""><< 주행모드 선택 >></option>
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 주행모드 선택 >></option>
					              <c:forEach var="list" items="${code_driving_mode}" varStatus="loop">
					                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchMode}">selected</c:if>>${list.codeDetlNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        </label>
                        <label for="">
                            <select name="searchWeth" id="searchWeth" title="데이터셋 차량거동정보 기상선택">
					          <c:choose>
					            <c:when test="${code_weather eq null || empty code_weather}">
					              <option value=""><< 기상 선택 >></option>
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 기상 선택 >></option>
					              <c:forEach var="list" items="${code_weather}" varStatus="loop">
					                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchWeth}">selected</c:if>>${list.codeDetlNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        </label>
                        <label for="">
                            <select name="searchSitu" id="searchSitu" title="데이터셋 차량거동정보 도로상황 선택">
					          <c:choose>
					            <c:when test="${code_road_situation eq null || empty code_road_situation}">
					              <option value=""><< 도로상황 선택 >></option>
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 도로상황 선택 >></option>
					              <c:forEach var="list" items="${code_road_situation}" varStatus="loop">
					                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchSitu}">selected</c:if>>${list.codeDetlNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        </label>
                        <label for="">
                            <select name="searchRoad" id="searchRoad" title="데이터셋 차량거동정보 도로유형 선택">
					          <c:choose>
					            <c:when test="${code_road_type_cd eq null || empty code_road_type_cd}">
					              <option value=""><< 도로유형 선택 >></option>
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 도로유형 선택 >></option>
					              <c:forEach var="list" items="${code_road_type_cd}" varStatus="loop">
					                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchRoad}">selected</c:if>>${list.codeDetlNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        </label>
                        <label for="">
                            <select name="searchBdwr" id="searchBdwr" title="데이터셋 차량거동정보 데이터셋 선택">
					          <c:choose>
					            <c:when test="${code_dataset eq null || empty code_dataset}">
					              <option value=""><< 데이터셋 선택 >></option>
					            </c:when>
					            <c:otherwise>
					              <option value=""><< 데이터셋 선택 >></option>
					              <c:forEach var="list" items="${code_dataset}" varStatus="loop">
					                <option value="${list.bdwrSeq}" <c:if test="${list.bdwrSeq eq searchBdwr}">selected</c:if>>${list.bdwrTtlNm}</option>
					              </c:forEach>
					            </c:otherwise>
					          </c:choose>
                            </select>
                        </label>
<!--                     </form> -->
                </div>
                             
                <div class="table-wrap">
                    <div class="table-cap">
                        <p class="table-cap__count">총 <span>${pageSetting.totalRecordCount}</span> 건
                        </p>
                        <p class="table-cap__page">페이지 <span>${pageSetting.currentPageNo}</span>/${pageSetting.totalPageCount} 
                        </p>
                    </div>
                    <table class="table-basic table-basic--col table--us_ag_05_list">
                        <caption>협의체데이터 &gt; 데이터셋 &gt; 차량거동정보 테이블</caption>
                        <colgroup>
                            <col style="width:20%">
                            <col style="width:auto">
                            <col style="width:20%">
                            <col style="width:11%">
                            <col style="width:11%">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">데이터유형</th>
                                <th scope="col">제목</th>
                                <th scope="col">주행모드</th>
                                <th scope="col">등록일</th>
                                <th scope="col">보기</th>
                            </tr>
                        </thead>
                        <tbody>
                        <!--테이블 -->
			            <c:choose>
			              <c:when test="${resultList eq null || empty resultList}">
			                <tr>
			                  <td colspan="5" >등록된 정보가 없습니다</td>
			                </tr>
			              </c:when>
			              <c:otherwise>
			                <c:forEach var="list" items="${resultList}" varStatus="status">
			                  <tr>
			                    <td class="border_l_none lh_sm">${list.dataTypeView}</td>
			                    <td class="left border_l_none lh_sm">${list.bTitle}</td>
			                    <td class="border_l_none lh_sm">${list.drivingModeView}</td>
			                    <td class="border_l_none lh_sm">${list.regDateView}</td>
			                    <td class="right">
			                      <span id="sp_on"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">펼치기</a></span>
			                      <span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">접기</a></span>
			                    </td>
			                  </tr>
			                  <tr id="plain" style="display:none" class="gray_box">
			                    <td colspan="5" class="left border_l_none tdCont">
			                      <div class="cont">${list.bContent}</div>
			                      <div class="list">
			                        <table summary="" class="center">
			                          <colgroup>
			                            <col width="15%">
			                            <col width="15%">
			                            <col width="15%">
			                            <col width="20%">
			                            <col width="15%">
			                            <col width="">
			                          </colgroup>
			                          <thead>
			                            <tr>
			                              <th class="border_l_none">기상상황</th>
			                              <th>도로상황</th>
			                              <th class="lh_sm">차량모델</th>
			                              <th class="lh_sm">영상센서모델</th>
			                              <th class="lh_sm">라이다모델</th>
			                              <th class="lh_sm">레이다모델</th>
			                            </tr>
			                          </thead>
			                          <tbody>
			                            <tr>
			                              <td class="border_l_none lh_sm">${list.weatherView}</td>
			                              <td class="border_l_none lh_sm">${list.roadSituationView}</td>
			                              <td class="border_l_none lh_sm">${list.carModel}</td>
			                              <td class="border_l_none lh_sm">${list.movieSensorModel}</td>
			                              <td class="border_l_none lh_sm">${list.lidarModel}</td>
			                              <td class="border_l_none lh_sm">${list.radarModel}</td>
			                            </tr>
			                          </tbody>
			                        </table>
			                      </div>
			                      <ul class="bot">
			                        <li class="l">첨부 <a href="javascript:void(0);" title="${list.saveNm} 첨부파일입니다" onclick="fn_Download_Hist('${list.bSeq}','${list.saveNm}')">${list.saveNm} [${list.fileSizeView} Kbyte] </a></li>
<!-- 			                        <li class="r"> -->
<%-- 			                          <c:if test="${list.bdwrSeq ne null && list.bdwrSeq ne '' }"> --%>
<%-- 			                            <a href="/agency/consultative/Agcy_Dset_Info.do?bdwr_seq=${list.bdwrSeq}" class="btn_sky btn_sm w90px">데이터셋정보</a>&nbsp; --%>
<%-- 			                          </c:if> --%>
<%-- 			                          <c:choose> --%>
<%-- 			                            <c:when test="${user_chk eq 1 }"> --%>
<%-- 			                              <a href="javascript:fn_Download_Hist('${list.bSeq}','${list.saveNm}');" class="btn_sky btn_sm w70px">다운로드</a>&nbsp; --%>
<%-- 			                            </c:when> --%>
<%-- 			                            <c:otherwise> --%>
<%-- 			                              <a href="javascript:fn_Add_Popup('${list.bSeq}');" class="btn_sky btn_sm" title="새창 열림">다운요청</a> --%>
<%-- 			                            </c:otherwise> --%>
<%-- 			                          </c:choose> --%>
<!-- 			                        </li> -->
			                      </ul>
			                    </td>
			                  </tr>
			                </c:forEach>
			              </c:otherwise>
			            </c:choose>
						<!--테이블 -->
                        </tbody>
                    </table>
                </div>
                                
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
			                <a href="javascript:void(0);" class="active" title="선택됨">${i }</a>
			              </c:when>
			              <c:otherwise>
			                <a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
			              </c:otherwise>
			             </c:choose>
			          </c:forEach>
                    <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" class="page-link page-link--next">
                        <img src="/image/common/icon/icon-page-link--next.png" alt="">
                    </a>
                    <a href="javascript:go_Page('${pageSetting.totalPageCount }');" class="page-link page-link--last">
                        <img src="/image/common/icon/icon-page-link--last.png" alt="">
                    </a>
                </div>
                
		  
						</div>
						<!-- //layout-container__inner layout-container--row -->
					</div>
					<!-- //layout-container layout-full -->
				</div>
				<!-- //content__inner -->
			</div>
		  	<!-- //content -->
		</div>
	  	<!-- //container__inner -->
	</div>
	<!-- //container -->
</div>
</div>
</form:form>
