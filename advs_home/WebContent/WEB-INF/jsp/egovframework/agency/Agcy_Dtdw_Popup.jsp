<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터입니다.</title>
<link rel="stylesheet" href="/css/avsc/style.css" type="text/css" />

<script src="/js/jquery-1.12.4.min.js"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/common/commonFunction.js"></script> <!-- 공통 script 함수를 정의 -->
<!-- ie9이하 html5 -->
<!--[if lt IE 9]>
    <script src="../js/respond.min.js"></script>
    <script src="../js/html5shiv.min.js"></script>
<![endif]-->
<!-- ie9이하 input text placeholder -->
<script src="/js/placeholders.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 등록 function */
  function fn_Insert() {
    if(confirm("요청 하시겠습니까?")) {
      if(trim(c_form.use.value).length==0){
				alert("사용목적을 입력해주세요");
				c_form.use.value="";
				c_form.use.focus();
				return;
			}
      if(trim(c_form.email.value).length==0){
				alert("E-Mail을 입력해주세요");
				c_form.email.value="";
				c_form.email.focus();
				return;
			}
      document.listForm.action = "<c:url value='/agency/consultative/Agcy_Dtdw_Send_Process.do'/>";
      document.listForm.submit();
    }
  }

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="b_seq" id="b_seq" value="${b_seq}"/>
<input type="hidden" name="data_type" id="data_type" value="${consInfo.dataTypeView}"/>
<input type="hidden" name="b_title" id="b_title" value="${consInfo.bTitle}"/>

<!-- 팝업 -->
<div class="modal-content modal_sm">
  <div class="modal-header">다운로드 요청<a href="javascript:self.close();" class="pop_close"></a></div>

  <div class="modal-body">
    <div class="table2">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">데이터 명</th>
            <td class="lh_sm">[${consInfo.dataTypeView}] ${consInfo.bTitle}</td>
          </tr>
          <tr>
            <th class="border_l_none"><b class="font_red">*</b>사용목적</th>
            <td>
              <input type="text" class="w100p" id="use" name="use" onkeyup="checkLength(this,255)">
            </td>
          </tr>
          <tr>
            <th class="border_l_none"><b class="font_red">*</b>E-Mail</th>
            <td>
              <input type="text" class="w100p" id="email" name="email" onkeyup="checkLength(this,255)">
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <a href="javascript:fn_Insert();" class="btn_sky btn_lg mr5">승인요청</a>
    <a href="javascript:self.close();" class="btn_gray btn_lg">취소</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
