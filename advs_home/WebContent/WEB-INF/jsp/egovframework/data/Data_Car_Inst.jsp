-<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");
	String user_nm = (String)session.getAttribute("user_nm");
	String agcy_nm = (String)session.getAttribute("agcy_nm");
	String auth_id = (String)session.getAttribute("auth_id");
	String grad_id = (String)session.getAttribute("grad_id");
 %>



<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer >

var c_form = "";

/*
$(document).ready(function(){
	c_form = document.listForm; //폼셋팅
});

function fn_insert(){
	var innerText = document.getElementById('agcyNm').innerText;  //기관명
	
	$("#usrPwd").val($("#p_password").val());
	
//  	frm.submit();
}
*/


$(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    
    var resultCnt = '${result_exist}';
    if(resultCnt > 0){
//     	alert("이미 차량이 등록되어있습니다. 차량관리에서 수정하시면 됩니다.");
	    $("#btnInst").hide();
    }
    
});



/* 유효성 function */
function fn_Insert_Check() {

}

function fn_Insert(){
// 	var innerText = document.getElementById('agcyNm').innerText;  //기관명
// 	$("#agcyNm").val(innerText);
// 	c_form.agcyNm.value= innerText;
	
	document.listForm.action = "<c:url value='/data/record/Data_Car_Inst_Process.do'/>";
	document.listForm.submit();
};

</script>

<!-- 
<form id="frm" name ="frm" method="post" action="/">
<input type="hidden" id="usrId" name ="usrId"/>
<input type="hidden" id="agcyNms" name ="agcyNms"/>
-->
<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="usrId" id="usrId"/>
<!-- <input type="hidden" name="agcyNm" id="agcyNm"/> -->
<!-- <input type="hidden" name="bdwr_seq" id="bdwr_seq"/> -->
<!-- <input type="hidden" name="file_up" id="file_up"/> -->
<%-- <input type="hidden" name="bbs_group_seq" id="bbs_group_seq" value="${bbs_group_seq}" /> --%>

<body>
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
                                <div class="lnb-item is-active">
                                    <a href="/data/record/Data_Car_Inst.do">차량등록</a>
                                </div>
                                <div class="lnb-item">
                                    <a href="/data/record/Data_Car_Updt.do">차량관리</a>
                                </div>
                                <div class="lnb-item">
                                    <a href="/data/record/Data_Delega_Auth.do">권한위임</a>
                                </div>
                            </div>
                        </div>
                        <div class="layout-content">
                            <div class="layout-content__inner">
                                <div class="layout-content__top">
                                    <h4 class="layout-content__tit">차량 등록</h4>
                                    <ul class="location ml-auto">
                                        <li>
                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
                                        </li>
                                        <li>MY DATA</li>
                                        <li>차량 등록</li>
                                    </ul>
                                </div>
                                <h5 class="layout-content__subtit">임시운행차랑 등록</h5>
                                <div class="table-wrap">
                                    <table class="table-basic table-basic--row table--myUpload">
                                        <caption>MY DATA &gt; 차량등록 테이블</caption>
                                        <colgroup>
                                            <col style="width:15%">
                                            <col style="width:auto">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">담당자 이름</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" id="user_nm" name="user_nm"  class="ui-input ui-form-width--m" value="${carInfo.userNm}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">기업체</th>
                                                <td id="agcy_nm"><%=agcy_nm %>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">운행 기간</th>
                                                <td>
                                                    <div class="ui-form ui-form-row align-center js-datepicker-range">
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input js-datepicker-range__min" id="oprat_strt_dt" name="oprat_strt_dt" value="${carInfo.opratStrtDt}" title="시작 날짜" />
                                                        </div>
                                                        <span class="el-hyphen mx-3"></span>
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input js-datepicker-range__max" id="oprat_end_dt" name="oprat_end_dt" value="${carInfo.opratEndDt}" title="완료 날짜" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">차량 구분</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <select name="car_type" id="car_type" class="ui-select ui-form-width--m">
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
                                                            </select>
                                                        </div>
                                                    </div>
                                                </td>
                                                
                                                
                                            </tr>
                                            <tr>
                                                <th scope="row">차량 종류</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" placeholder="아이오닉6" class="ui-input ui-form-width--m" id="car_model" name="car_model" value="${carInfo.carModel}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">자율주행레벨</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <select name="autocar_level" id="autocar_level"  class="ui-select ui-form-width--s">
                                                                <c:choose>
												                    <c:when test="${code_car_level eq null || empty code_car_level}">
												                      <option value="">-</option>
												                    </c:when>
												                    <c:otherwise>
												                      <option value="">-</option>
												                      <c:forEach var="list" items="${code_car_level}" varStatus="loop">
												                        <option value="${list.codeDetlCd}">${list.codeDetlNm}</option>
												                      </c:forEach>
												                    </c:otherwise>
												                  </c:choose>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">운행 목적</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" placeholder="자율주행 테스트" class="ui-input ui-form-width--m" id="oprat_purps"  name="oprat_purps" value="${carInfo.opratPurps}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">운행 구간</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" placeholder="A~C코스" class="ui-input ui-form-width--m" id="oprat_intrvl" name="oprat_intrvl" value="${carInfo.opratIntrvl}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <h5 class="layout-content__subtit">보험일자 가입등록</h5>
                                <div class="table-wrap">
                                    <table class="table-basic table-basic--row table--myUpload">
                                        <caption>MY DATA &gt; 차량등록 테이블</caption>
                                        <colgroup>
                                            <col style="width:15%">
                                            <col style="width:auto">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">
                                                    	임시운행번호
                                                    <span class="el-essential">*</span>
                                                </th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" placeholder="" class="ui-input ui-form-width--m" id="tmp_race_num" name="tmp_race_num" value="${carInfo.tmpRaceNum}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">
                                                    	보험 기간
                                                    <span class="el-essential">*</span>
                                                </th>
                                                <td>
                                                    <div class="ui-form ui-form-row align-center js-datepicker-range">
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input ui-form-width--s  js-datepicker-range__min" value="${carInfo.insInitStrtDt}" title="시작 날짜" id="ins_init_strt_dt" name="ins_init_strt_dt" />
                                                        </div>
                                                        <span class="el-hyphen mx-3"></span>
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input ui-form-width--s js-datepicker-range__max" value="${carInfo.insInitEndDt}" title="완료 날짜" id="ins_init_end_dt" name="ins_init_end_dt" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">주소</th>
                                                <td>
                                                    <div class="ui-form">
                                                        <div class="ui-form-block">
                                                            <input type="text" placeholder="경기도 화성시 송산면 삼존로 200" class="ui-input ui-form-width--full" id="adres" name="adres" value="${carInfo.adres}"/>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                    <button type="reset" class="btn btn-width--l btn-color--white">취소</button>
                                    <button type="button" class="btn btn-width--l btn-color--navy" id="btnInst" onclick="fn_Insert()">등록</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</form:form>
</html>