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

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "excel";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>

<!-- 팝업 -->
<div class="modal-content modal_sm">
  <div class="modal-header">
    <c:choose>
      <c:when test="${divnm eq 'incd'}">
        자율주행자동차 교통사고 신고서 생성
      </c:when>
      <c:when test="${divnm eq 'drvg'}">
        자율주행자동차 운행에 관한 정보 보고서 생성
      </c:when>
      <c:otherwise>
        자율주행자동차 장치 및 기능 변경 신고서 생성
      </c:otherwise>
    </c:choose>
    <a href="javascript:self.close();" class="pop_close"></a>
  </div>
  <div class="modal-body">
    <div class="table2">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">생성 결과</th>
            <td class="lh_sm">
              <c:choose>
        				<c:when test="${result eq 1}">
        					<a href="javascript:void(0);" title="${filenm} 첨부파일입니다" onclick="fn_Download('${filenm}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${filenm}</i></a>
        				</c:when>
        				<c:otherwise>
        					보고서 파일 생성실패
        				</c:otherwise>
        			</c:choose>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <a href="javascript:self.close();" class="btn_gray btn_lg">닫기</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
