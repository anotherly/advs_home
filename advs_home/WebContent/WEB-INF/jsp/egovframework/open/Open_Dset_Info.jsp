<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 수정 function */
	function fn_Update(bdwr, bbs) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
      c_form.bdwr_seq.value = bdwr;
      c_form.bbs_seq.value = bbs;
      c_form.action = "<c:url value='/open/dataset/Open_Dset_Updt.do'/>";
      c_form.submit();
    }
	}

	/* 삭제 function */
	function fn_Delete(bdwr, bbs) {
		if(confirm("정말 삭제 하시겠습니까?")) {
      c_form.bdwr_seq.value = bdwr;
      c_form.bbs_seq.value = bbs;
			if(confirm("등록된 데이터셋 정보와 업로드된 데이터의 매핑정보는 모두 삭제 됩니다")) {
        c_form.action = "<c:url value='/open/dataset/Open_Dset_Delt_Process.do'/>";
        c_form.submit();
			}
		}
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
      <b>데이터셋 정보 상세</b>
      <ul>
        <li></li>
        <li>공공데이터</li>
        <li>데이터셋 정보 상세</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="25%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">제목</th>
              <td>${dsetInfo.bdwrTtlNm}</td>
            </tr>
            <tr>
              <th class="border_l_none">내용</th>
              <td>${dsetInfo.bdwrCts}</td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">데이터 형태</th>
              <td>${dsetInfo.dataForm}</td>
            </tr>
            -->
            <tr>
              <th class="border_l_none">첨부파일</th>
              <td>
                <c:choose>
                  <c:when test="${dsetInfo.attachFilename ne null}">
                    <a href="javascript:void(0);" title="${dsetInfo.attachFilename} 첨부파일입니다" onclick="fn_Download('${dsetInfo.attachFilename}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dsetInfo.attachFilename}</i> [${dsetInfo.fileSizeView} Kbyte]</a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="center mt20">
        <c:if test="${user_chk > 0}">
          <a href="javascript:fn_Update('${bdwr_seq}','${bbs_seq}');" class="btn_sky btn_lg mr5">수정</a>
          <a href="javascript:fn_Delete('${bdwr_seq}','${bbs_seq}');" class="btn_l_sky btn_lg mr5">삭제</a>
        </c:if>
        <a href="/open/cits/Open_Cits_List.do?search=Y&searchDetl=Y&searchBdwr=${bdwr_seq}" class="btn_l_sky btn_lg mr5">관련자료</a>
        <a href="/open/dataset/Open_Dset_List.do?bbs_seq=${bbs_seq}" class="btn_sky btn_lg mr5">목록으로</a>
      </div>
    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
