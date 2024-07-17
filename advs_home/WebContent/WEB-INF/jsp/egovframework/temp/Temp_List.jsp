<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

  });

  /* 처리 function */
	function req_submit(tp, reqid, userid) {
    c_form.tp.value = tp;
    c_form.reqid.value = reqid;
    c_form.userid.value = userid;

    c_form.action = "<c:url value='/temp/Temp_Process.do'/>";
    c_form.submit();
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="tp" id="tp"/>
<input type="hidden" name="reqid" id="reqid"/>
<input type="hidden" name="userid" id="userid"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>임시승인</i></p>
    <ul class="depth2">
      <%-- <li><a href="/agency/consultative/Agcy_Dset_List.do">데이터셋 정보</a></li> --%>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>목록</b>
      <ul>
        <li></li>
        <li>임시</li>
        <li>승인</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">

      <div class="table2 list">
        <table summary="" class="center">
          <colgroup>
            <col width="">
            <col width="20%">
            <col width="20%">
            <col width="15%">
            <col width="15%">
            <col width="10%">
            <col width=" 8%">
          </colgroup>
          <thead>
            <tr>
              <th class="border_l_none">구분</th>
              <th>임시운행등록번호</th>
              <th>요청ID</th>
              <th>요청권한</th>
              <th>등록일시</th>
              <th>승인상태</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${resultList eq null || empty resultList}">
                <tr>
                  <td colspan="6" >등록된 정보가 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                  <tr>
                    <td class="border_l_none">${list.reqTpNm}</td>
                    <td>${list.reqId}</td>
                    <td>${list.userId}</td>
                    <td>${list.authNm}</td>
                    <td>${list.regDate}</td>
                    <td>${list.statusNm}</td>
                    <td class="right"><a href="javascript:req_submit('${list.reqTp}','${list.reqId}','${list.userId}');" class="btn_l_sky btn_sm">승인</a></td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>

    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
