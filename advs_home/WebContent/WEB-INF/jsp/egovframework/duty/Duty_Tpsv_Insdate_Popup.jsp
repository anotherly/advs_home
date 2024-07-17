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

<link rel="stylesheet" href="/css/avsc/jquery-ui.css" /> <!-- jQuery 달력 CSS -->
<link rel="stylesheet" href="/css/avsc/jquery-ui.theme.css" /> <!-- jQuery 달력 CSS -->
<script src="/js/common/jquery-ui.js"></script> <!-- jQuery 달력 -->
<script src="/js/common/commonFunction.js"></script> <!-- 공통 script 함수를 정의 -->
<!-- ie9이하 html5 -->
<!--[if lt IE 9]>
    <script src="../js/respond.min.js"></script>
    <script src="../js/html5shiv.min.js"></script>
<![endif]-->
<!-- ie9이하 input text placeholder -->
<script src="/js/placeholders.min.js"></script>
<%
String check = request.getParameter("check");
System.out.println("check : "+check);

%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.frm; //폼 셋팅

    //달력 이벤트
		$( "#ins_init_date" ).datepicker({
				dateFormat: 'yy-mm-dd',
				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
				changeMonth: true,
				changeYear: true,
				showOn: "button",
				buttonImage: "/css/avsc/images/icon_calendar.png",
				showMonthAfterYear: true,
				showOtherMonths: true,
				selectOtherMonths: true,
				maxDate : "+12m"
		});
  });

  /* 등록 function */
	function fn_Update() {
		var v_check = <%=check%>;
		//alert("v_check : "+v_check);
		
		if(confirm("수정 하시겠습니까?")) {

      		if(trim(c_form.ins_init_date.value).length==0){
				alert("변경보험가입일자를 선택해주세요");
				c_form.ins_init_date.focus();
				return;
			}
      		
			if(v_check == 1){				
				document.frm.action = "<c:url value='/common/Duty_Tpsv_Uptdate_Process.do'/>";				
				document.frm.submit();	
			}else{				
				document.frm.action = "<c:url value='/common/Duty_Tpsv_Insdate_Process.do'/>";
				document.frm.submit();
			}
			
		}
	}

</script>
</head>

<body>
<form:form id="frm" name="frm" method="post">

<!-- 팝업 -->
<div class="modal-content modal_sm">
  <div class="modal-header">
    임시운행등록번호 보험가입일자 수정
    <a href="javascript:self.close();" class="pop_close"></a>
  </div>
  <div class="modal-body">
    <div class="table2">
      <table summary="" class="">
        <colgroup>
          <col width="35%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none"><b class="font_red">*</b> 임시운행등록번호</th>
            <td>
              <input type="text" class="w50p" id="tmp_race_number" name="tmp_race_number" onkeyup="checkLength(this,20)" value="${reMap.tmpNumber }" readonly="readonly">
            </td>
          </tr>
          <tr>
            <th class="border_l_none"><b class="font_red">*</b> 기존보험가입일자</th>
            <td>
              <input type="text" class="w100p" id="old_ins_init_date" name="old_ins_init_date" value="${reMap.insInitDateView }" readonly="readonly">
            </td>
          </tr>
					<input type="hidden" id="ins_letter_number" name="ins_letter_number" value="-">
          <tr>
            <th class="border_l_none"><b class="font_red">*</b> 변경보험가입일자</th>
            <td>
              <input readonly="" class="w50p" id="ins_init_date" name="ins_init_date">
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <a href="javascript:fn_Update();" class="btn_sky btn_lg mr5">수정</a>
    <a href="javascript:self.close();" class="btn_gray btn_lg">취소</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
