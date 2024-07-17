<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

    //펼치기
    $("span[id=sp_on]").click(function() {
    	var idx = $("span[id=sp_on]").index(this);
    	$(this).hide();
    	$("tr[id=plain]:eq("+idx+")").show();
    });
    //접기
    $("span[id=sp_off]").click(function() {
    	var idx = $("span[id=sp_off]").index(this);
    	$("tr[id=plain]:eq("+idx+")").hide();
    	$("span[id=sp_on]:eq("+idx+")").show();
    });
  });

	/* 목록 화면 function */
	function form_Submit() {
    var searchMode = $("#searchMode option:selected").val();
    var searchWeth = $("#searchWeth option:selected").val();
    var searchSitu = $("#searchSitu option:selected").val();
    var searchRoad = $("#searchRoad option:selected").val();

    if( searchMode == "" && searchWeth == "" && searchSitu == "" && searchRoad == "" && trim(c_form.searchWord.value).length == 0 ) {
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
      c_form.search.value="Y";
      c_form.action = "<c:url value='/open/behavior/Open_Behv_List.do'/>";
      c_form.submit();
    }
	}

  /* 파일 다운로드  */
  function fn_Download_Hist(seq, file_nm) {
    c_form.b_seq.value = seq;
    c_form.file_nm.value = file_nm;
//		c_form.dir_nm.value = "cits";
    c_form.dir_nm.value = "dtup";
    c_form.action = "<c:url value='/common/File_Download_Hist.do'/>";
    c_form.submit();
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/open/behavior/Open_Behv_List.do'/>";
		c_form.submit();
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="search" id="search" value="${search}" />

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>공공데이터</i></p>
    <ul class="depth2">
      <li><a href="/open/cits/Open_Cits_List.do">평가시나리오</a></li>
      <li class="active"><a href="/open/behavior/Open_Behv_List.do">자율주행차 거동정보</a></li>
      <li><a href="/open/dataset/Open_Dset_List.do">데이터셋 정보</a></li>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>자율주행차 거동정보</b>
      <ul>
        <li></li>
        <li>공공데이터</li>
        <li>자율주행차 거동정보</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="searchWrap">
        <select id="searchMode" name="searchMode" class="w130px" title="검색대상 선택">
          <c:choose>
            <c:when test="${code_driving_mode eq null || empty code_driving_mode}">
              <option value="">--주행모드 선택--</option>
            </c:when>
            <c:otherwise>
              <option value="">--주행모드 선택--</option>
              <c:forEach var="list" items="${code_driving_mode}" varStatus="loop">
                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchMode}">selected</c:if>>${list.codeDetlNm}</option>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </select>
        <select id="searchWeth" name="searchWeth" class="w100px" title="검색대상 선택">
          <c:choose>
            <c:when test="${code_weather eq null || empty code_weather}">
              <option value="">--기상 선택--</option>
            </c:when>
            <c:otherwise>
              <option value="">--기상 선택--</option>
              <c:forEach var="list" items="${code_weather}" varStatus="loop">
                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchWeth}">selected</c:if>>${list.codeDetlNm}</option>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </select>
        <select id="searchSitu" name="searchSitu" class="w100px" title="검색대상 선택">
          <c:choose>
            <c:when test="${code_road_situation eq null || empty code_road_situation}">
              <option value="">--도로상황 선택--</option>
            </c:when>
            <c:otherwise>
              <option value="">--도로상황 선택--</option>
              <c:forEach var="list" items="${code_road_situation}" varStatus="loop">
                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchSitu}">selected</c:if>>${list.codeDetlNm}</option>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </select>
        <select id="searchRoad" name="searchRoad" class="w100px" title="검색대상 선택">
          <c:choose>
            <c:when test="${code_road_type_cd eq null || empty code_road_type_cd}">
              <option value="">--도로유형 선택--</option>
            </c:when>
            <c:otherwise>
              <option value="">--도로유형 선택--</option>
              <c:forEach var="list" items="${code_road_type_cd}" varStatus="loop">
                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchRoad}">selected</c:if>>${list.codeDetlNm}</option>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </select>
        <select id="searchType" name="searchType" title="검색대상 선택">
          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--검색어--</option>
          <option value="3" <c:if test="${searchType eq '3' }">selected</c:if>>제목+내용</option>
          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
        </select>
        <input type="text" placeholder="검색어를 입력해 주세요." class="w150px" id="searchWord" name="searchWord" alt="검색어 입력" value="${searchWord }" onkeyup="injectionCheck(this)" />
        <a href="javascript:form_Submit();" class="btn_md btn_dgray btn">검색</a>
      </div>

      <div class="page_count">총 <b>${pageSetting.totalRecordCount}건</b> (${pageSetting.currentPageNo}/${pageSetting.totalPageCount} 페이지)</div>

      <div class="table1 list">
        <table summary="" class="center">
          <colgroup>
            <col width="">
            <col width="15%">
            <col width="15%">
            <col width="15%">
            <col width="10%">
          </colgroup>
          <thead>
            <tr>
              <th class="border_l_none">제목</th>
              <th>주행모드</th>
              <th>도로유형</th>
              <th>등록일시</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${resultList eq null || empty resultList}">
                <tr>
                  <td colspan="5" >등록된 정보가 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                  <tr>
                    <td class="left border_l_none lh_sm">${list.bTitle}</td>
                    <td class="border_l_none lh_sm">${list.drivingModeView}</td>
                    <td class="border_l_none lh_sm">${list.roadTypeCdView}</td>
                    <td class="border_l_none lh_sm">${list.regDateView}</td>
                    <td class="right">
                      <span id="sp_on"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">펼치기</a></span>
                    </td>
                  </tr>
                  <tr id="plain" style="display:none">
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
                        <li class="r"><span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">접기</a></span></li>
                      </ul>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

      <!-- pagenum : s -->
      <c:if test="${fn:length(resultList) > 0 }">
        <div class="pagenum mb20 mt20">
          <a class="direction l2" href="javascript:go_Page('1');" title="처음으로"></a>
          <a class="direction l1" href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" title="이전"></a>
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
          <a class="direction r1" href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음"></a>
          <a class="direction r2" href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로"></a>
        </div>
      </c:if>
      <!-- //pagenum : e -->

    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
