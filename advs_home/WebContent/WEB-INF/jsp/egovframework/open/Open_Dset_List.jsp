<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

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

  /* 상세 화면 function */
	function detail_View(bdwr, bbs) {
    c_form.bdwr_seq.value = bdwr;
    c_form.bbs_seq.value = bbs;
    c_form.action = "<c:url value='/open/dataset/Open_Dset_Info.do'/>";
    c_form.submit();
	}

  /* 등록 화면 function */
	function fn_Add_View(bbs) {
    c_form.bbs_seq.value = bbs;
    c_form.action = "<c:url value='/open/dataset/Open_Dset_Inst.do'/>";
    c_form.submit();
	}

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
				c_form.action = "<c:url value='/open/dataset/Open_Dset_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
		c_form.action = "<c:url value='/open/dataset/Open_Dset_List.do'/>";
		c_form.submit();
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "dset";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)
  	//게시판소스는 bbs_seq별로 하드코딩해줌
  	String cMenuId = "A3000";
  	String pMenuId = "A0000";
  %>
  <jsp:include page="/include/Left.jsp">
  	<jsp:param value="<%=cMenuId %>" name="cMenuId"/>
  	<jsp:param value="<%=pMenuId %>" name="pMenuId"/>
  	<jsp:param value="BOARD" name="leftType"/>
  </jsp:include> 

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>데이터셋 정보</b>
      <ul>
        <li></li>
        <li>공공데이터</li>
        <li>데이터셋 정보 목록</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="searchWrap">
        <select id="searchType" name="searchType" title="검색대상 선택">
          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
        </select>
        <input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" />
        <a href="javascript:form_Submit();" class="btn_md btn_dgray btn">검색</a>
      </div>

      <div class="page_count">총 <b>${pageSetting.totalRecordCount}건</b> (${pageSetting.currentPageNo}/${pageSetting.totalPageCount} 페이지)</div>

      <div class="table1 list">
        <table summary="" class="center">
          <colgroup>
            <col width="">
            <col width="12%">
            <col width="20%">
          </colgroup>
          <thead>
            <tr>
              <th class="border_l_none">제목</th>
              <th>등록일시</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${resultList eq null || empty resultList}">
                <tr>
                  <td colspan="3" >등록된 정보가 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                  <tr>
                    <td class="left border_l_none lh_sm">${list.bdwrTtlNm}</td>
                    <td class="border_l_none lh_sm">${list.regDateView}</td>
                    <td class="right">
                      <a href="javascript:detail_View('${list.bdwrSeq}','${list.bbsSeq}');" class="btn_sky btn_sm w70px">상세</a>
                      <span id="sp_on"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">펼치기</a></span>
                    </td>
                  </tr>
                  <tr id="plain" style="display:none">
                    <td colspan="3" class="left border_l_none tdCont">
                      <div class="cont">${list.bdwrCts}</div>
                      <div class="cont">데이터 형태 : ${list.dataForm}</div>
                      <ul class="bot">
                        <li class="l">첨부 <a href="javascript:void(0);" title="${list.attachFilename} 첨부파일입니다" onclick="fn_Download('${list.attachFilename}')">${list.attachFilename} [${list.fileSizeView} Kbyte] </a></li>
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

      <div class="right mt20">
        <c:if test="${user_chk > 0}">
          <a href="javascript:fn_Add_View('${bbs_seq}');" class="btn_sky btn_md">데이터셋 정보 등록</a>
        </c:if>
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
