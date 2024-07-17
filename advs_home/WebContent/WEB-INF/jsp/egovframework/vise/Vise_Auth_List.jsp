<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

	/* 목록 화면 function */
	function fn_requestAuth() {
		if(trim(c_form.auth_id.value).length == ""){
      		alert("회원의 종류를 선택하여 주시기 바랍니다");
      		return;
    	} else {
	      	c_form.action = "<c:url value='/supervise/Power_Rights_Inst.do'/>";
	      	c_form.submit();
    	}
	}

</script>
<form:form id="listForm" name="listForm" method="post" >
<div class="container">
      <div class="container__inner">
          <div class="content">
              <div class="content__inner">

                  <div class="layout-container layout-full">
                      <div class="layout-container__inner layout-container--row">
                          <div class="lnb">
                              <h3 class="lnb__tit">권한신청</h3>
                              <div class="lnb-list">
                                  <div class="lnb-item is-active is-open">
                                      <a href="">권한신청</a>
                                  </div>
                              </div>
                          </div>
                          <div class="layout-content">
                              <div class="layout-content__inner">
                                  <div class="layout-content__top">
                                      <h4 class="layout-content__tit">자율주행 데이터 공유센터 권한신청</h4>
                                      <!-- <div class="el-platform__txt2">
                                        <strong>본인에 해당하는 회원의 종류를 선택하여 주시기 바랍니다.</strong>
                                    </div> -->
                                      <ul class="location ml-auto">
                                          <li><img src="/image/sub/icon/icon-home.png" alt="홈"></li>
                                          <li>권한신청</li>
                                      </ul>
                                  </div>
                                  <div class="table-wrap">
                                      <table class="table-basic table-basic--row table--myUpload">
                                          <caption>권한신청</caption>
                                          <colgroup>
                                              <col style="width:15%">
                                              <col style="width:auto">
                                          </colgroup>
                                          <tbody>
                                              <tr>
                                                  <th scope="row">기관명</th>
                                                  <td>${sessionScope.agcy_nm }</td>
                                              </tr>
                                              <tr>
                                                  <th scope="row">현재 아이디</th>
                                                  <td>${sessionScope.user_id}</td>
                                              </tr>
                                              <tr>
                                                  <th scope="row">요청권한</th>
                                                  <td>
                                                      <div class="ui-form">
                                                          <div class="ui-form-block">
                                                          	<select name="auth_id" id="auth_id" class="ui-select ui-form-width--r">
                                                        		 <option value="">-</option>
                                                        		 <option value="101">일반사용자</option>
                                                        		 <option value="104">임시운행기관</option>
                                                        		 <option value="102">협의체기관</option>
                                                        		 <option value="105">임시운행기관<br>+ 협의체기관</option>
                                                              </select>
                                                          </div>
                                                      </div>
                                                  </td>
                                              </tr>
                                              
                                          </tbody>
                                      </table>
                                      
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                 	<button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_requestAuth()">요청</button>
                             	</div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>

              </div>
          </div>
      </div>
  </div>
</form:form>

	                                    