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
<script src="/js/placeholders.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 등록 function */
	function fn_Save() {
    document.listForm.action = "<c:url value='/login_proc.do'/>";
    document.listForm.submit();
	}

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">

  <!-- container -->
  <div id="container">
    <!--  contWrap -->
    <div class="contWrap">

      <!-- contents -->
      <div class="contents">

        <div class="table2">
          <table summary="" class="">
            <colgroup>
              <col width="15%">
              <col width="">
            </colgroup>
            <tbody>
              <tr>
                <th class="border_l_none">USER ID</th>
                <td>
                  <input type="text" class="w50p" id="user_id" name="user_id" value="test001" title="user id" onkeyup="checkLength(this,20)">
                </td>
              </tr>
              <tr>
                <th class="border_l_none">USER NM</th>
                <td>
                  <input type="text" class="w50p" id="user_nm" name="user_nm" value="테스트기관001" title="user name" onkeyup="checkLength(this,20)">
                </td>
              </tr>
              <tr>
                <th class="border_l_none">기관 ID</th>
                <td>
                  <input type="text" class="w50p" id="agcy_id" name="agcy_id" value="한국교통안전공단" title="기관" onkeyup="checkLength(this,20)">
                </td>
              </tr>
              <tr>
                <th class="border_l_none">기관명</th>
                <td>
                  <input type="text" class="w50p" id="agcy_nm" name="agcy_nm" value="한국교통안전공단" title="기관명" onkeyup="checkLength(this,20)">
                </td>
              </tr>
              <tr>
                <th class="border_l_none">권한 ID</th>
                <td>
                  <input type="text" class="w50p" id="auth_id" name="auth_id" value="103" title="권한" onkeyup="checkLength(this,20)">
                </td>
              </tr>
              <tr>
                <th class="border_l_none">권한 정보</th>
                <td>일반:101, 협의체:102, 관리자:103, 임시운행:104, 임시운행+협의체:105</td>
              </tr>
              
              <input type="hidden" class="w50p" id="grad_id" name="grad_id" value="102" onkeyup="checkLength(this,20)"> <%-- 일반:101, 고급:102 --%>
            </tbody>
          </table>
        </div>

        <div class="center mt20">
          <a href="javascript:fn_Save();" class="btn_sky btn_lg mr5">전송</a>
        </div>
      </div>
      <!-- //contents -->
    </div>
    <!--  contWrap -->
  </div>
  <!-- //container -->
  </form:form>
</body>
</html>
