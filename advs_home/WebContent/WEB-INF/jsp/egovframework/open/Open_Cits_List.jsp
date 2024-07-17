<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

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
    	$("tr[id=plain]:eq("+idx+")").show();
    });
    //접기
    $("span[id=sp_off]").click(function() {
    	var idx = $("span[id=sp_off]").index(this);
    	$("tr[id=plain]:eq("+idx+")").hide();
    	$("span[id=sp_on]:eq("+idx+")").show();
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

    if( searchBseq == "" && searchMode == "" && searchWeth == "" && searchSitu == "" && searchRoad == "" && searchBdwr == "" && trim(c_form.searchWord.value).length == 0 ) {
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
      c_form.action = "<c:url value='/open/cits/Open_Cits_List.do'/>";
      c_form.submit();
    }
	}

  /* 파일 다운로드  */
  function fn_Download_Hist(seq, file_nm) {
    c_form.b_seq.value = seq;
    c_form.file_nm.value = file_nm;
//    c_form.dir_nm.value = "cits";
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
    c_form.action = "<c:url value='/open/cits/Open_Cits_List.do'/>";
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

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)
  	//게시판소스는 bbs_seq별로 하드코딩해줌
  	String cMenuId = "A1000";
    String bbs_seq = (String)request.getAttribute("bbs_seq");
    if("1010".equals(bbs_seq)){
    	cMenuId = "A1000";
    }else if("1020".equals(bbs_seq)){
    	cMenuId = "A2000";
    }else{
    	cMenuId = "A1000";
    }
  	String pMenuId = "A0000";
  %>
  <jsp:include page="/include/Left.jsp">
  	<jsp:param value="<%=cMenuId %>" name="cMenuId"/>
  	<jsp:param value="<%=pMenuId %>" name="pMenuId"/>
  	<jsp:param value="BOARD" name="leftType"/>
  </jsp:include>
  
      <c:choose>
        <c:when test="${bbs_list eq null || empty bbs_list}">
        </c:when>
        <c:otherwise>
          <c:forEach var="list" items="${bbs_list}" varStatus="loop">
            <c:if test="${list.bbsSeq eq bbs_seq}">
              <c:set var="bbs_nm" value="${list.bbsNm}" />
            </c:if>
          </c:forEach>
        </c:otherwise>
      </c:choose>

  <c:if test="${search eq 'Y'}">
    <c:set var="bbs_nm" value="통합검색" />
  </c:if>
  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>${bbs_nm}</b>
      <ul>
        <li></li>
        <li>공공데이터</li>
        <li>${bbs_nm}</li>
        <li>공유데이터 목록</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="searchWrap2">
        <p><i>통합검색</i><input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" /></p>
        <a href="javascript:form_Submit();" class="btn_md btn_dgray btn">통합검색</a>&nbsp;&nbsp;
        <i class="checkbox"><input type="checkbox" id="chk_i"  name="chk_i" onclick="fn_check_box(this)" <c:if test="${searchDetl eq 'Y'}">checked</c:if>><label for="chk_i">상세검색</label></i>&nbsp;&nbsp;
        <a href="javascript:fn_searchReset();" class="btn_sky btn_xs mr5">검색초기화</a>
      </div>

      <div class="searchWrap">
        <select id="searchBseq" name="searchBseq" class="w170px" title="검색대상 선택">
          <c:choose>
            <c:when test="${bbs_list eq null || empty bbs_list}">
              <option value=""><< 데이터유형 선택 >></option>
            </c:when>
            <c:otherwise>
              <option value=""><< 데이터유형 선택 >></option>
              <c:forEach var="list" items="${bbs_list}" varStatus="loop">
                <option value="${list.bbsSeq}" <c:if test="${list.bbsSeq eq searchBseq}">selected</c:if>>${list.bbsNm}</option>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </select>
        <select id="searchMode" name="searchMode" class="w150px" title="검색대상 선택">
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
        <select id="searchWeth" name="searchWeth" class="w140px" title="검색대상 선택">
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
        <select id="searchSitu" name="searchSitu" class="w150px" title="검색대상 선택">
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
        <select id="searchRoad" name="searchRoad" class="w150px" title="검색대상 선택">
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
        <select id="searchBdwr" name="searchBdwr" class="w180px" title="검색대상 선택">
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
        <!--
        <select id="searchType" name="searchType" title="검색대상 선택">
          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>-검색어-</option>
          <option value="3" <c:if test="${searchType eq '3' }">selected</c:if>>제목+내용</option>
          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
        </select>
        -->
      </div>

      <div class="page_count">총 <b>${pageSetting.totalRecordCount}건</b> (${pageSetting.currentPageNo}/${pageSetting.totalPageCount} 페이지)</div>

      <div class="table1 list">
        <table summary="" class="center">
          <colgroup>
            <col width="15%">
            <col width="">
            <col width="15%">
            <col width="15%">
            <col width="10%">
          </colgroup>
          <thead>
            <tr>
              <th>데이터유형</th>
              <th class="border_l_none">제목</th>
              <th>주행모드</th>
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
                    <td class="border_l_none lh_sm">${list.dataTypeView}</td>
                    <td class="left border_l_none lh_sm">${list.bTitle}</td>
                    <td class="border_l_none lh_sm">${list.drivingModeView}</td>
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
                        <li class="r">
                          <c:if test="${list.bdwrSeq ne null && list.bdwrSeq ne '' }">
                            <a href="/open/dataset/Open_Dset_Info.do?bdwr_seq=${list.bdwrSeq}" class="btn_sky btn_sm w90px">데이터셋정보</a>&nbsp;
                          </c:if>
                          <c:choose>
                            <c:when test="${user_chk eq 1 }">
                              <a href="javascript:fn_Download_Hist('${list.bSeq}','${list.saveNm}');" class="btn_sky btn_sm w70px">다운로드</a>&nbsp;
                            </c:when>
                            <c:otherwise>
                              <a href="javascript:fn_Add_Popup('${list.bSeq}');" class="btn_sky btn_sm" title="새창 열림">다운요청</a>
                            </c:otherwise>
                          </c:choose>
                          <span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">접기</a></span>
                        </li>
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
