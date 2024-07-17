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
<!-- <script src="/js/common/commonFunction.js"></script> --> <!-- 공통 script 함수를 정의 -->
<script type="text/javascript" src="/js/commonFunction.js"></script>
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

    c_form.b_seq.value = opener.document.listForm.b_seq.value;
    $(".lh_sm").html(opener.document.listForm.b_title.value);

    $(".starWrap").on("click", "a", function() {
      var idx = $(".starWrap").children("a").index(this);
      c_form.eval_point.value = idx + 1;
      $(this).parent().children('a').removeClass('active');
      $(this).addClass('active').prevAll('a').addClass('active');
      return false;
  	});
  });

  /* 등록 function */
	function fn_Insert() {
		if(confirm("등록 하시겠습니까?")) {

      if(trim(c_form.eval_point.value).length==0){
				alert("평가점수를 선택해주세요");
				c_form.eval_point.focus();
				return;
			}

			document.listForm.action = "<c:url value='/data/record/Data_Eval_Process.do'/>";
			document.listForm.submit();
		}
	}

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="eval_point" id="eval_point"/>

<!-- 팝업 -->
<div class="modal-content modal_sm">
  <div class="modal-header">데이터 평가<a href="javascript:self.close();" class="pop_close"></a></div>
  
  <div class="modal-body">
    <div class="table2">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">데이터명</th>
            <td class="lh_sm"></td>
          </tr>
          <tr>
            <th class="border_l_none"><b class="font_red">*</b> 평가점수</th>
            <td>
              <div class="starWrap mr10">
                <a href="javascript:void(0);" class=""></a>
                <a href="javascript:void(0);" class=""></a>
                <a href="javascript:void(0);" class=""></a>
                <a href="javascript:void(0);" class=""></a>
                <a href="javascript:void(0);" class=""></a>
              </div>
              <!--
              <i>보통 이에요</i>
              -->
            </td>
          </tr>
          <tr>
            <th class="border_l_none">내용</th>
            <td>
              <input type="text" class="w100p" id="b_content" name="b_content" onkeyup="checkLength(this,255)">
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <a href="javascript:fn_Insert();" class="btn_sky btn_lg mr5">평가저장</a>
    <a href="javascript:self.close();" class="btn_gray btn_lg">취소</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
