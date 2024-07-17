<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" language="javascript" defer="defer">
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.frm; //폼 셋팅
	});

	/* 등록 function */
	function fn_Insert() {
		if (confirm("신청 하시겠습니까?")) {
			c_form.action = "<c:url value='/openapi/OpenApi_Inst_Process.do'/>";
			c_form.submit();
		}
	}
	
	function fn_Update() {
		if('${result.apiApprCode}' != '01'){
			alert("신청결과가 신청일 경우만 수정 가능합니다.");
			return;
		}
		if (confirm("수정 하시겠습니까?")) {
			c_form.action = "<c:url value='/openapi/OpenApi_Updt_Process.do'/>";
			c_form.submit();
		}
	}	
	
	function fn_Cancel() {
		if('${result.apiApprCode}' != '01'){
			alert("신청결과가 신청일 경우만 삭제 가능합니다.");
			return;
		}		
		
		if (confirm("신청취소 하시겠습니까?")) {
			c_form.action = "<c:url value='/openapi/OpenApi_Delt_Process.do'/>";
			c_form.submit();
		}
	}
	
	function fn_Manual(){
		window.open('/openapi/OpenApiManual_Popup.do', 'manual','resizable=yes, scrollbars=yes, width=900,height=720,status=no');
	}
</script>

<form:form id="frm" name="frm" method="post">
<input type="hidden" name="user_id" id="user_id" value="<%=user_id%>"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <!-- lmenu -->
  <div class="lmenu">
    <p class="depth1"><i>OpenAPI</i></p>
    <ul class="depth2">
      <li class="active"><a href="/openapi/OpenAPI_Apply.do">OpenAPI</a></li>
    </ul>
  </div>
  <!-- lmenu -->

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>OpenAPI</b>
      <ul>
        <li></li>
        <li>OpenAPI</li>
`      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="35%">
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
<!--           	<tr>
          		<td colspan="4">
          			<textarea class="w100p h200px" id="agree" name="agree" readonly="readonly">
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
한국교통안전공단의 자율주행 데이터의 센세 데이터 수집 결과물로 Open API를 이용하여 자율주행 데이터 공유센터의 자료를 다운 가능 합니다.
          			</textarea>
          		</td>
          	</tr> -->
            <tr>
              <th class="border_l_none">사용자ID</th>
              <td colspan="3"><%=user_id %></td>
            </tr>
            <tr>
              <th class="border_l_none">API신청 URL</th>
              <td colspan="3"><input type="text" id="apply_api_url" name="apply_api_url" class="w100p" onkeyup="checkLength(this,200)" value="${result.applyApiUrl }"/></td>
            </tr>
            <tr>
              <th class="border_l_none">업체명</th>
              <td colspan="3"><input type="text" id="apply_api_company" name="apply_api_company" class="w100p" onkeyup="checkLength(this,200)" value="${result.applyApiCompany }"/></td>
            </tr>
            <tr>
              <th class="border_l_none">사용 목적</th>
              <td colspan="3">
              	<textarea class="w100p" id="purpose" name="purpose" onkeyup="checkLength(this,4000)">${result.purpose }</textarea>
              </td>
            </tr>
            <tr>
              <th class="border_l_none">신청결과</th>
              <td>${result.apiApprNm }</td>
              <th class="border_l_none">API KEY</th>
              <td>${result.apiKey }</td>              
            </tr>
            <tr>
              <th class="border_l_none">승인일자</th>
              <td>${result.apiApprDateView }</td>
              <th class="border_l_none">승인취소일자</th>
              <td>${result.apiKeyCanceldateView }</td>              
            </tr>            
          </tbody>
        </table>
      </div>

      <div class="center mt20">
		<c:if test="${not empty result }">
			<a href="javascript:fn_Update();" class="btn_sky btn_lg mr5">수정</a>
			<a href="javascript:fn_Cancel();" class="btn_sky btn_lg mr5">신청취소</a>
			<c:if test="${result.apiApprCode eq '02' }">
				<a href="javascript:fn_Manual();" class="btn_gray btn_lg mr5">사용방법</a>	
			</c:if>
		</c:if>
		<c:if test="${empty result }">
			<a href="javascript:fn_Insert();" class="btn_sky btn_lg mr5">신청</a>
		</c:if>
      </div>
    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->
</form:form>
