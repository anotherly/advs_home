<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
// 	String user_id = (String)session.getAttribute("user_id");
// 	String user_nm = (String)session.getAttribute("user_nm");
// 	String agcy_nm = (String)session.getAttribute("agcy_nm");
// 	String auth_id = (String)session.getAttribute("auth_id");
 %>
 
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer>
$(document).ready(function() {
   	c_form = document.listForm; //폼 셋팅
});

/* 수정 function */
function fn_Update() {
	if(confirm("정보를 수정 하시겠습니까?")) {
	  c_form.action = "<c:url value='/data/record/Data_Car_Updt_Process.do'/>";
	  c_form.submit();
	}
}

</script>
 
 <form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
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
<!--                                 <div class="lnb-item"> -->
<!--                                     <a href="/data/record/Data_Car_Inst.do">차량등록</a> -->
<!--                                 </div> -->
                                <div class="lnb-item is-active">
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
                                    <h4 class="layout-content__tit">차량관리</h4>
                                    <ul class="location ml-auto">
                                        <li>
                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
                                        </li>
                                        <li>MY DATA</li>
                                        <li>차량관리</li>
                                    </ul>
                                </div>
                                <h5 class="layout-content__subtit">담당자 수정</h5>
                                <div class="table-wrap">
                                    <table class="table-basic table-basic--row table--myUpload">
                                        <caption>MY DATA &gt; 담당자 수정 테이블</caption>
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
                                                            <input type="text" class="ui-input ui-form-width--m" id="user_nm" name="user_nm" value="${carInfo.userNm}" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">업체명</th>
                                                <td>${carInfo.agcyNm}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">운행 기간</th>
                                                <td>${carInfo.opratStrtDt} - ${carInfo.opratEndDt} </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">차량 구분</th>
                                                <td>${carInfo.carTypeView}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">차량 종류</th>
                                                <td>${carInfo.carModel}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">자율주행레벨</th>
                                                <td>${carInfo.autocarLevelView}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <h5 class="layout-content__subtit">보험가입일자수정</h5>
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
                                                    <div class="ui-form ui-form-row align-center">
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input ui-form-width--s" id="tmp_race_num" name="tmp_race_num" value="${carInfo.tmpRaceNum }" />
                                                        </div>
<!--                                                                 <span class="el-hyphen mx-3"></span> -->
<!--                                                                 <div class="ui-form-block"> -->
<!--                                                                     <input type="text" placeholder="011" class="ui-input ui-form-width--s" /> -->
<!--                                                                 </div> -->
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
                                                            <input type="text" class="ui-input  js-datepicker-range__min" id="ins_init_strt_dt" name="ins_init_strt_dt" value="${carInfo.insInitStrtDt}" title="시작 날짜" />
                                                        </div>
                                                        <span class="el-hyphen mx-3"></span>
                                                        <div class="ui-form-block">
                                                            <input type="text" class="ui-input js-datepicker-range__max" id="ins_init_end_dt" name="ins_init_end_dt" value="${carInfo.insInitEndDt}" title="시작 날짜" />
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">시작 일자</th>
                                                <td>${carInfo.insInitStrtDt}</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">종료 일자</th>
                                                <td>${carInfo.insInitEndDt}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                    <button type="reset" class="btn btn-width--l btn-color--white"">취소</button>
                                    <button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Update()">수정</button>
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

</body>
