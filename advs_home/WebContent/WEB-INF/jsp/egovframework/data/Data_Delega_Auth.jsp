<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 상세 화면 function */
	function fn_Update(auth_id, user_id) {

	  //  c_form.b_seq.value = b_seq;
	  //  c_form.bbs_seq.value = bbs_seq;
	     var temp_oper_inst = c_form.temp_oper_inst.value;
	   // alert(temp_oper_RData_Dtmg_List.jspinst); 
	    
	    c_form.action = "<c:url value='/data/request/InsertDelegAuth.do'/>";
	                                   
	    c_form.submit();
	}

	/* 목록 화면 function */
	/* function form_Submit() {
		if(trim(c_form.searchWord.value).length > 0){
			var sel = $("#searchType option:selected").val();
			if(sel == 0) {
				alert("검색대상을 선택해주세요");
				c_form.searchType.focus();
				return;
			} else {
				if(trim(c_form.searchWord.value).length==0){
					alert("검색어를 입력해주세요");
					c_form.searchWord.value="";
					c_form.searchWord.focus();
					return;
				}
				c_form.action = "<c:url value='/data/record/Data_Uphs_List.do'/>";
				c_form.submit();
			}
		} else {
      c_form.action = "<c:url value='/data/record/Data_Uphs_List.do'/>";
      c_form.submit();
    }
	} */

 

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<div class="skip">
  <a href="#container">권한 위임</a>
</div>

<div class="container">
      <div class="container__inner">
          <div class="content">
              <div class="content__inner">

                  <div class="layout-container layout-full">
                      <div class="layout-container__inner layout-container--row">
                          <div class="lnb">
                              <h3 class="lnb__tit">MY DATA</h3>
                              <div class="lnb-list">
                                  <div class="lnb-item">
                                      <a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a>
                                  </div>
                                  <div class="lnb-item">
                                      <a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a>
                                  </div>
<!--                                   <div class="lnb-item"> -->
<!--                                       <a href="/data/record/Data_Car_Inst.do">차량등록</a> -->
<!--                                   </div> -->
                                  <div class="lnb-item">
                                      <a href="/data/record/Data_Car_List.do">차량관리</a>
                                  </div>
                                  <div class="lnb-item is-active">
                                      <a href="/data/request/Data_Delega_Auth.do">권한위임</a>
                                  </div>
                              </div>
                          </div>
                          <div class="layout-content">
                              <div class="layout-content__inner">
                                  <div class="layout-content__top">
                                      <h4 class="layout-content__tit">권한위임</h4>
                                      <ul class="location ml-auto">
                                          <li><img src="/image/sub/icon/icon-home.png" alt="홈"></li>
                                          <li>MY DATA</li>
                                          <li>권한위임</li>
                                      </ul>
                                  </div>
                                  <div class="table-wrap">
                                      <table class="table-basic table-basic--row table--myUpload">
                                          <caption>MY DATA &gt; 권한위임 테이블</caption>
                                          <colgroup>
                                              <col style="width:15%">
                                              <col style="width:auto">
                                          </colgroup>
                                          <tbody>
                                              <tr>
                                                  <th scope="row">기관명</th>
                                                  <td>${member.agencyCd }</td>
                                              </tr>
                                              <tr>
                                                  <th scope="row">현재 아이디</th>
                                                  <td>${sessionScope.user_id}</td>
                                              </tr>
                                              <tr>
                                                  <th scope="row">변경 아이디</th>
                                                  <td>
                                                      <div class="ui-form">
                                                          <div class="ui-form-block">
                                                             <!--  <select name="delega_id" id="delega_id" class="ui-select ui-form-width--s">
                                                        		 <c:choose>
												                    <c:when test="${code_car_type eq null || empty code_car_type}">
												                      <option value="">-</option>
												                    </c:when>
												                    <c:otherwise>
												                      <c:forEach var="list" items="${code_car_type}" varStatus="loop">
												                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
												                      </c:forEach>
												                    </c:otherwise>
												                  </c:choose>
                                                              </select>-->
                                                          </div>
                                                      </div>
                                                  </td>
                                              </tr>
                                              
                                          </tbody>
                                      </table>
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
<!--                                  <button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Update()">수정</button> -->
                                 <button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Update('${auth_id}','${user_id}')">수정</button>
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
