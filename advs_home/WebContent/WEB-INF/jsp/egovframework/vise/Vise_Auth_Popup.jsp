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

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" >

<!-- 팝업 -->
<div class="modal-content modal_sm">
  <div class="modal-header">문의 및 연락처<a href="javascript:self.close();" class="pop_close"></a></div>

  <div class="modal-body">
    <div class="table2">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">담당부서</th>
            <td class="lh_sm">한국교통안전공단 자동차안전연구원 자율주행실</td>
          </tr>
          <tr>
            <th class="border_l_none">연락처</th>
            <td class="lh_sm">031) 369-0421~3</td>
          </tr>
          <tr>
            <td colspan="2" class="lh_sm"><i class="font_orange">※ 승인 요청이 정상 전송 되었습니다.<br/>담당자에게 연락하여 권한신청 사항을 통보 해주세요</i></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <a href="javascript:self.close();" class="btn_gray btn_lg">확인</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
