<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

	/* 목록 화면 function */
	function form_Submit() {
		if(trim(c_form.searchWord.value).length > 0){
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
				c_form.action = "<c:url value='/data/request/Data_Rqhs_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/data/request/Data_Rqhs_List.do'/>";
		c_form.submit();
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>My Data</i></p>
    <ul class="depth2">
      <li class=""><a href="javascript:fn_DtupView('/data/upload/Data_Dtup_Inst.do','${auth_id}','${user_id}');">데이터 업로드</a></li>
      <li class=""><a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a></li>
      <li class=""><a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a></li>
      <li class="active"><a href="/data/request/Data_Rqhs_List.do">요청이력</a></li>
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
      <b>요청이력</b>
      <ul>
        <li></li>
        <li>My Data</li>
        <li>요청이력</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="searchWrap">
        <select id="searchType" name="searchType" title="검색대상 선택">
          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>기관명</option>
          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>진행상황</option>
        </select>
        <input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" />
        <a href="javascript:form_Submit();" class="btn_md btn_dgray btn">검색</a>
      </div>

      <div class="page_count">총 <b>${pageSetting.totalRecordCount}건</b> (${pageSetting.currentPageNo}/${pageSetting.totalPageCount} 페이지)</div>

      <div class="table2 list">
        <table summary="" class="center">
          <colgroup>
            <col width="20%">
            <col width="15%">
            <col width="20%">
            <col width="15%">
            <col width="12%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">구분</th>
              <th class="">신청ID</th>
              <th class="">신청기관</th>
              <th class="">신청일시</th>
              <th class="">진행상황</th>
              <th class="">취소사유</th>
            </tr>
            <c:choose>
              <c:when test="${resultList eq null || empty resultList}">
                <tr>
                  <td colspan="6" >등록된 정보가 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                  <tr>
                    <td class="lh_sm">${list.divName}</td>
                    <td class="lh_sm">${list.idView}</td>
                    <td class="lh_sm">${list.nameView}</td>
                    <td class="lh_sm">${list.regDateView}</td>
                    <c:if test="${list.status eq '101'}"><td class="font_orange bold"></c:if>
                    <c:if test="${list.status eq '102'}"><td class="font_sky bold"></c:if>
                    <c:if test="${list.status eq '103'}"><td class="font_red bold"></c:if>
                      ${list.statusView}
                    </td>
                    <td class="">${list.cnclView}</td>
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
