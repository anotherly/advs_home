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
      c_form.action = "<c:url value='/agency/consultative/Agcy_Cons_List.do'/>";
      c_form.submit();
    }
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
<input type="hidden" name="search" id="search" value="${search}" />
<input type="hidden" name="searchDetl" id="searchDetl" />

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)
  	//게시판소스는 bbs_seq별로 하드코딩해줌
  	String cMenuId = "B1000";
  	String pMenuId = "B0000";
  %>
  <jsp:include page="/include/Left.jsp">
  	<jsp:param value="<%=cMenuId %>" name="cMenuId"/>
  	<jsp:param value="<%=pMenuId %>" name="pMenuId"/>
  	<jsp:param value="BOARD" name="leftType"/>
  </jsp:include> 

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>협의체 데이터</b>
      <ul>
        <li></li>
        <li>협의체 데이터</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="searchWrap2">
        <p><i>통합검색</i><input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" /></p>
        <a href="javascript:form_Submit();" class="btn_md btn_dgray btn">통합검색</a>&nbsp;&nbsp;
        <i class="checkbox"><input type="checkbox" id="chk_i"  name="chk_i" onclick="fn_check_box(this)"><label for="chk_i">상세검색</label></i>&nbsp;&nbsp;
        <a href="javascript:fn_searchReset();" class="btn_sky btn_xs mr5">검색초기화</a>
      </div>

      <div class="searchWrap" style="display:none">
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
        <select id="searchWeth" name="searchWeth" class="w120px" title="검색대상 선택">
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

      <div class="dataSelect wrap">
        <ul class="wrap">
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010">
              <i><img src="/images/avsc/dataSelect1.png" alt=""></i>
              <b>차량거동정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2020">
              <i><img src="/images/avsc/dataSelect2.png" alt=""></i>
              <b>주행영상정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030">
              <i><img src="/images/avsc/dataSelect3.png" alt=""></i>
              <b>센서정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040">
              <i><img src="/images/avsc/dataSelect4.png" alt=""></i>
              <b>자율주행 학습정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050">
              <i><img src="/images/avsc/dataSelect5.png" alt=""></i>
              <b>융합정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060">
              <i><img src="/images/avsc/dataSelect6.png" alt=""></i>
              <b>V2X정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070">
              <i><img src="/images/avsc/dataSelect7.png" alt=""></i>
              <b>기타정보</b>
            </a>
          </li>
          <li>
            <a href="/agency/consultative/Agcy_Dset_List.do">
              <i><img src="/images/avsc/dataSelect8.png" alt=""></i>
              <b>데이터셋 정보</b>
            </a>
          </li>
        </ul>
      </div>

    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
