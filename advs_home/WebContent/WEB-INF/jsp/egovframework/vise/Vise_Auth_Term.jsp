<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 목록 화면 function */
	function form_Submit() {
    if(!c_form.chk1.checked) {
      alert("회원약관에 대한 안내에 동의해 주세요");
      c_form.chk1.focus();
      return;
    } else {
      c_form.action = "<c:url value='/supervise/Power_Rights_Inst.do'/>";
      c_form.submit();
    }
	}

  //checkbox 값 설정
	function fn_check_box(obj1, obj2) {
		if(obj1.checked) {
			obj2.value = "Y";
		} else {
			obj2.value = "N";
		}
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="auth_id" id="auth_id" value="${auth_id}" />
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>권한신청</i></p>
    <ul class="depth2">
      <li class="active">
        <a href="#">권한신청</a>
      </li>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>자율주행 데이터 공유센터 권한신청</b>
      <ul>
        <li></li>
        <li>권한신청</li>
        <li>자율주행 데이터 공유센터 권한신청</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents authority2">
      <div class="table_row mb10 w100p">
        <p class="contTit1">개인정보 수집 및 이용에 대한 동의</p>
        <p class="right">
          <i class="checkbox"><input type="checkbox" name="chk1" id="chk1" onclick="fn_check_box(this, c_form.chk1_val)"><label for="chk1">동의합니다.</label></i>
          <input type="hidden" name="chk1_val" id="chk1_val"/>
        </p>
      </div>
      <textarea readonly>
한국교통안전공단은 대민서비스를 제공하기 위해 필요한 개인정보를 수집합니다. 필수항목에 해당하는 정보를 입력하시지 않는 경우 회원가입이 불가능하나, 선택항목에 해당하는 정보를 입력하지 않으셔도 회원가입 및 서비스 이용에는 제한이 없습니다.
개인정보 수집항목필수 : 이름, 기관명, 이메일
개인정보의 보유 및 이용 기간수집된 개인정보는 개인의 탈퇴요청 시 까지 보유 이용됩니다.
정보주체는 개인정보의 수집·이용목적에 대한 동의를 거부할 수 있으며, 동의 거부 시 한국교통안전공단 홈페이지에 회원가입이 되지 않으며, 한국교통안전공단 홈페이지에서 제공하는 서비스를 이용할 수 없습니다.

선택정보를 입력하지 않은 경우에도 서비스 이용 제한은 없으며 이용자의 기본적 인권 침해의 우려가 있는 민감한 개인 정보(인종, 사상 및 신조, 정치적 성향 이나 범죄기록, 의료정보 등)는 기본적으로 수집하지 않습니다.
다만 불가피하게 수집이 필요한 경우 반드시 사전에 동의 절차를 거치도록 하겠습니다

＊시스템 이용 및 업무 처리과정에서 아래의 정보는 자동으로 생성되어 수집 될 수 있습니다.

자동수집사항 : IP Address
      </textarea>

      <div class="table_row mb10 w100p">
        <p class="contTit1">개인정보(선택정보)수집 및 이용에 대한 안내</p>
        <p class="right">
          <i class="checkbox"><input type="checkbox" name="chk2" id="chk2" onclick="fn_check_box(this, c_form.chk2_val)"><label for="chk2">동의합니다.</label></i>
          <input type="hidden" name="chk2_val" id="chk2_val"/>
        </p>
      </div>
      <textarea readonly>
한국교통안전공단은 대민서비스를 제공하기 위해 필요한 개인정보를 수집합니다. 선택항목에 해당하는 정보를 입력하지 않으셔도 회원가입 및 서비스 이용에는 제한이 없습니다.
개인정보 수집항목선택 : 주소, 전화번호, 성별, 직업, 회사/학교명, 생년월일, 사용자분류
개인정보의 보유 및 이용 기간수집된 개인정보는 개인의 탈퇴요청 시 까지 보유 이용됩니다.
선택정보를 입력하지 않은 경우에도 서비스 이용 제한은 없습니다
      </textarea>

<!--
      <div class="table_row mb10 w100p">
        <p class="contTit1">위치정보 및 위치기반서비스 이용약관</p>
        <p class="right">
          <i class="checkbox"><input type="checkbox" name="chk3" id="chk3" onclick="fn_check_box(this, c_form.chk3_val)"><label for="chk3">동의합니다.</label></i>
          <input type="hidden" name="chk3_val" id="chk3_val"/>
        </p>
      </div>
      <textarea readonly>
약관내용
      </textarea>

      <div class="table_row mb10 w100p">
        <p class="contTit1">개인위치정보 사용 동의 확인</p>
        <p class="right">
          <i class="checkbox"><input type="checkbox" name="chk4" id="chk4" onclick="fn_check_box(this, c_form.chk4_val)"><label for="chk4">동의합니다.</label></i>
          <input type="hidden" name="chk4_val" id="chk4_val"/>
        </p>
      </div>
      <textarea readonly>
약관내용
      </textarea>
-->

      <div class="center">
        <a href="javascript:form_Submit();" class="btn_sky btn_lg mr5">동의합니다.</a>
        <a href="/main/Main.do" class="btn_gray btn_lg">동의하지 않습니다.</a>
      </div>

    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
