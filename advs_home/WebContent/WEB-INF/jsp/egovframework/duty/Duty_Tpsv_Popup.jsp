<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터입니다.</title>

<!-- <link rel="stylesheet" href="/css/avsc/style.css" type="text/css" /> -->
<link rel="stylesheet" href="/css/lib/bootstrap.min.css">
<link rel="stylesheet" href="/css/lib/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/css/ux-common.css">
<link rel="stylesheet" href="/css/lib/fullpage.css">
<link rel="stylesheet" href="/css/sub.css">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/us_ag.css">
<link rel="stylesheet" href="/css/us_da.css">
<link rel="stylesheet" href="/css/us_du.css">
<link rel="stylesheet" href="/css/us_od.css">
<link rel="stylesheet" href="/css/avsc/layout.css">

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/lib/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/lib/tweenmax.min.js"></script>
<script type="text/javascript" src="/js/lib/moment.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/sub.js"></script>
<script type="text/javascript" src="/js/lib/fullpage.js"></script>
<!-- <script type="text/javascript" src="/js/main.js" defer=""></script> -->
<script type="text/javascript" src="/js/commonFunction.js"></script>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

//     //달력 이벤트
// 		$( "#ins_init_date" ).datepicker({
// 				dateFormat: 'yy-mm-dd',
// 				monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
// 				dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
// 				changeMonth: true,
// 				changeYear: true,
// 				showOn: "button",
// 				buttonImage: "/css/avsc/images/icon_calendar.png",
// 				showMonthAfterYear: true,
// 				showOtherMonths: true,
// 				selectOtherMonths: true,
// 				maxDate : "+12m"
// 		});
    
  });

  /* 등록 function */
	function fn_Insert() {
		if(confirm("등록 하시겠습니까?")) {
      if(trim(c_form.tmp_race_number.value).length==0){
				alert("임시운행등록번호를 입력해주세요");
				c_form.tmp_race_number.focus();
				return;
			}

      if(trim(c_form.isexist.value) != "Y"){
				alert("임시운행등록번호 중복을 확인해주세요");
				c_form.tmp_race_number.focus();
				return;
			}

      if(trim(c_form.tmp_race_agency.value).length==0){
				alert("임시운행기관을 선택해주세요");
				c_form.tmp_race_agency.focus();
				return;
			}

      if(trim(c_form.ins_letter_number.value).length==0){
				alert("보험증서번호를 입력해주세요");
				c_form.ins_letter_number.focus();
				return;
			}

      if(trim(c_form.ins_init_date.value).length==0){
				alert("보험가입일자를 선택해주세요");
				c_form.ins_init_date.focus();
				return;
			}
      
   //   alert("str : " +c_form.tmp_race_number.value);
            
			document.listForm.action = "<c:url value='/common/Duty_Tpsv_Inst_Process.do'/>";
			document.listForm.submit();
		}
	}

  /* 중복확인 function */
	function fn_IsExist() {
    if(trim(c_form.tmp_race_number1.value).length==0){
      alert("임시운행등록번호를 입력해주세요");
      c_form.tmp_race_number1.focus();
      return;
    } else if(trim(c_form.tmp_race_number2.value).length==0){
        alert("임시운행등록번호를 입력해주세요");
        c_form.tmp_race_number2.focus();
        return;    
    } else if(trim(c_form.tmp_race_number3.value).length==0){
        alert("임시운행등록번호를 입력해주세요");
        c_form.tmp_race_number3.focus();
        return;   
    } else if(trim(c_form.tmp_race_number4.value).length==0){
        alert("임시운행등록번호를 입력해주세요");
        c_form.tmp_race_number4.focus();
        return;       
    } else {
    var str = c_form.tmp_race_number1.value+'-'+c_form.tmp_race_number2.value+c_form.tmp_race_number3.value+c_form.tmp_race_number4.value;
  //  alert("str : " +str);
    c_form.tmp_race_number.value = str;
      $.ajax( {
        type : "POST",
        cache: false,
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        url : "/common/Duty_Tpsv_IsExist.do",
        data : {
          tmp_race_number : c_form.tmp_race_number.value
        },
        success : function(data) {
          var arr = eval(data);
          if( arr == null) {
            return;
          } else {
            var result = arr[0].result;
            if(result == 0) {
              alert("등록이 가능한 번호입니다");
              c_form.isexist.value = "Y";
            } else if(result > 0) {
              alert("존재하는 번호입니다");
              c_form.isexist.value = "N";
            }
          }
        },
        error : function(data) {
        }
      });
    }
  }
	//
	function fnOnlyFormatNo(obj){
		var str = obj.value;
		obj.value = (str.replace(/[^0-9\-]/g,''));
	}  
</script>
</head>
<body id="pop_body">
<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="isexist" id="isexist"/>

<!-- 팝업 -->
<div class="modal-content2">
  <div class="modal-header">
    임시운행등록번호 추가 요청
    <a href="javascript:self.close();" class="pop_close"></a>
  </div>
  <div class="modal-body">
    <div class="table-basic table-basic--row">
      <table summary="" class="table-basic table-basic--col">
        <colgroup>
          <col width="40%">
          <col width="auto">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none"><span class="el-essential">*</span> 임시운행등록번호</th>
            <td>
              <div class="ui-form">
	            <div class="ui-form-block">
	              <c:set var="ymd" value="<%=new java.util.Date()%>" />
	              <input type="text" class="popW60 pd15" id="tmp_race_number1" name="tmp_race_number1" onkeyup="fnOnlyFormatNo(this); checkLength(this,4);" value="<fmt:formatDate value='${ymd}' pattern='yyyy' />">
	              -
	              
	              <input type="text" class="popW40 pd15" id="tmp_race_number2" name="tmp_race_number2" onkeyup="fnOnlyFormatNo(this); checkLength(this,1);">
	              <input type="text" class="popW40 pd15" id="tmp_race_number3" name="tmp_race_number3" onkeyup="fnOnlyFormatNo(this); checkLength(this,1);">
	              <input type="text" class="popW40 pd15" id="tmp_race_number4" name="tmp_race_number4" onkeyup="fnOnlyFormatNo(this); checkLength(this,1);">
	              <a href="javascript:fn_IsExist();" class="but_sky but_xs m-l6">중복확인</a>
	               <input type="hidden" class="w50p" id="tmp_race_number" name="tmp_race_number" >
	              <p style="color:red; font-weight: bold;">※ 년도 뒤 번호는 3자리로 입력 바랍니다.</p>  <!-- *년도 뒤 번호는 2자리로 입력 바랍니다. -->
	              <p style="color:BLUE;">ex) 2023-001</p>
	            <!--   <br><font color = "#FF0000" > -->
	            </div>
	          </div>
            </td>
                      
          </tr>
          <tr>
            <th class="border_l_none"><span class="el-essential">*</span> 임시운행기관</th>
            <td>
              <div class="ui-form">
	            <div class="ui-form-block">
					<label for="" class="ui-form-width--r">
                    <select id="tmp_race_agency" name="tmp_race_agency" class="w100p" onchange="javascript:fn_tmpEvent(this.value)">
	                  <c:choose>
	                    <c:when test="${tmp_race_agency eq null || empty tmp_race_agency}">
	                      <option value="">-</option>
	                    </c:when>
	                    <c:otherwise>
	                      <option value="">-</option>
	                      <c:forEach var="list" items="${tmp_race_agency}" varStatus="loop">
	                        <option value="${list.agencyCd}">${list.agencyCd}</option>
	                      </c:forEach>
	                    </c:otherwise>
	                  </c:choose>
	               	</select>
	               	</label>
                    </div>
               	</div>
            	</div>
              </div>
            </td>
          </tr>
          <!--
          <tr>
            <th class="border_l_none"><b class="font_red">*</b> 보험증서번호</th>
            <td>
              <input type="text" class="w100p" id="ins_letter_number" name="ins_letter_number" onkeyup="checkLength(this,100)">
            </td>
          </tr>
					-->
					<input type="hidden" id="ins_letter_number" name="ins_letter_number" value="-">
          <tr>
            <th class="border_l_none"><span class="el-essential">*</span> 보험가입일자</th>
            <td>
            	<div class="ui-form ui-form-row align-center js-datepicker-range">
                	<div class="ui-form-block">
              			<input type="text" class="ui-input ui-form-width--140 js-datepicker" id="ins_init_date" name="ins_init_date">
              		</div>
              	</div>
            </td>
          </tr>
          <!--
          <tr>
            <th class="border_l_none">차량모델</th>
            <td>
              <input type="text" class="w100p" id="car_model" name="car_model" onkeyup="checkLength(this,255)">
            </td>
          </tr>
          <tr>
            <th class="border_l_none">동력원</th>
            <td>
              <select id="power_source" name="power_source" class="w100p">
                <c:choose>
                  <c:when test="${code_power_source eq null || empty code_power_source}">
                    <option value="">-</option>
                  </c:when>
                  <c:otherwise>
                    <option value="">-</option>
                    <c:forEach var="list" items="${code_power_source}" varStatus="loop">
                      <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </select>
            </td>
          </tr>
          <tr>
            <th class="border_l_none">증서파일</th>
            <td>
              <div class="fileBox sm">
                <input type="file" name="file_deed" id="file_deed" class="uploadBtn" onChange="fileExtCheck(this);">
                <input type="text" name="filename_a" id="filename_a" class="fileName" readonly placeholder="선택된 파일 없음">
                <label for="file_deed" class="btn_file btn_md btn_l_gray">파일선택</label>
              </div>
            </td>
          </tr>
					-->
        </tbody>
      </table>
    </div>
  </div>
  <div class="modal-footer">
    <div class="btn-row justify-center">
<!--       <button type="button" class="btn btn-width--s btn-color--gray" onclick="fn_Insert()">신청</button> -->
<!--       <button type="button" class="btn btn-width--s btn-color--navy" onclick="self.close()">취소</button> -->
      <a href="javascript:fn_Insert();" class="but_sky but_md">신청</a>
      <a href="javascript:self.close();" class="but_gray but_md m-l6">취소</a>
    </div>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
