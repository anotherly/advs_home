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

  /* 등록 function */
	function fn_Insert() {
		if(confirm("등록 하시겠습니까?")) {
		if(trim($('#agency_cd').val())=='' || trim($('#agency_cd').val())==null){
        	alert("기관명을 입력해주세요");
        	$('#agency_cd').focus();
			return;
		}

      if(trim($('#isexist').val()) != "Y"){
				alert("가입여부를 확인해주세요");
				return;
			}

			document.listForm.action = "<c:url value='/supervise/Power_Rights_Inst_Process.do'/>";
			document.listForm.submit();
		}
	}

  /* 중복확인 function */
	function fn_IsExist() {
    $.ajax( {
      type : "POST",
      cache: false,
      contentType:"application/x-www-form-urlencoded;charset=utf-8",
      url : "/supervise/Power_Rights_IsExist.do",
      data : {
        user_id : $('#user_id').val()
      },
      success : function(data) {
        var arr = eval(data);
        if( arr == null) {
          return;
        } else {
          var result = arr[0].result;
          if(result == 0) {
            alert("권한신청이 가능한 ID 입니다");
            $('#isexist').val("Y");
          } else if(result > 0) {
            alert("이미 권한신청을 요청한 ID 입니다");
            $('#isexist').val("N");
          }
        }
      },
      error : function(data) {
      }
    });
  }
  
  function fn_Cancle(){
	location.href="/main/Main.do";  
  }

  
	
		
		
</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="isexist" id="isexist"/>
<input type="hidden" name="auth_id" id="auth_id" value="${auth_id}" />
<input type="hidden" name="user_id" id="user_id" value="${user_id}" />

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
                                                  <th scope="row">아이디</th>
                                                  <td>${user_id} &nbsp;&nbsp; <button type="button" class="btn btn-height--s btn-color--caution" onclick="fn_IsExist();" >가입확인</button></td>
                                              </tr>
                                              <tr>
                                                  <th scope="row">이름</th>
                                                  <td>${user_nm}</td>
                                              </tr>
                                              <tr>
                                                  <th scope="row"><b class="font_red">*</b>기관명</th>
                                                  <td><input type="text" class="w80p" id="agency_cd" name="agency_cd" onkeyup="checkLength(this,100)"></td>
                                              </tr>
                                              
                                          </tbody>
                                      </table>
                                      
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                 	<button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Insert()">요청</button>
                                 	<button type="button" class="btn btn-width--l btn-color--gray" onclick="fn_Cancle()">취소</button>
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
