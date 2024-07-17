<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" defer>

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "trnd";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }
  
	function go_List(){
		c_form.action = "<c:url value='/sharing/car/Car_Reserve_List.do'/>";
		c_form.submit();
	}
</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="blbd_div_cd" id="blbd_div_cd"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div class="container">
    <div class="container__inner">
        <div class="content">
            <div class="content__inner">

                <div class="layout-container layout-full">
                    <div class="layout-container__inner layout-container--row">
                        <div class="lnb">
                            <h3 class="lnb__tit">자율주행최신동향</h3>
                            <div class="lnb-list">
                                <div class="lnb-item is-active">
                                    <a href="/bbs/trend/Board_Trnd_List.do">자율주행최신동향</a>
                                </div>
                                <div class="lnb-item">
                                    <a href="/bbs/notice/Board_Notc_List.do">공지사항</a>
                                </div>
                            </div>
                        </div>
                        <div class="layout-content">
                                    <div class="layout-content__inner">
                                        <div class="layout-content__top">
                                            <h4 class="layout-content__tit">차량 플랫폼 공유</h4>
                                            <ul class="location ml-auto">
                                                <li>
                                                    <img src="../resource/image/sub/icon/icon-home.png" alt="홈">
                                                </li>
                                                <li>데이터공유센터 시설이용</li>
                                                <li>차량 플랫폼 공유</li>
                                                <li>예약신청</li>
                                            </ul>
                                        </div>
                                        <h5 class="layout-content__subtit">예약신청</h5>
                                        <div class="table-wrap">
                                            <table class="table-basic table-basic--row">
                                                <caption>데이터공유센터 시설이용 &gt; 차량 플랫폼 공유 &gt; 예약신청 테이블</caption>
                                                <colgroup>
                                                    <col style="width:18%">
                                                    <col style="width:auto">
                                                    <col style="width:18%">
                                                    <col style="width:40%">
                                                </colgroup>
                                                <tbody>
                                                    <tr>
                                                        <th scope="row">
                                                            신청기관
                                                        </th>
                                                        <td>
                                                            ${agcy_nm}
                                                        </td>
                                                        <th scope="row">
                                                            사업자등록번호
                                                        </th>
                                                        <td>
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--full" title="사업자등록번호 입력" id="biz_number" name="biz_number">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                            기관주소
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--full" title="기관주소 입력" id="agency_adres" name="agency_adres">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                            날짜 선택
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form ui-form-row align-center js-datepicker">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--s js-datepicker" value="2022-11-02" title="날짜 선택 대여일시" id="rent_dt" name="rent_dt">
                                                                </div>
                                                                <span class="el-hyphen mx-3"></span>
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--s js-datepicker" value="2022-11-02" title="날짜 선택 사고일시" id="return_dt" name="return_dt">
                                                                </div>
                                                            </div>
                                                            <div class="ui-form-block ml-20">
                                                                        <span class="el-caution font-xs">* 당일 신청불가, 명일부터 최대 2주까지 신청가능</span>
                                                                    </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                            대여 차량
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                    <label for="rentCarCodeA">
                                                                        <input type="radio" name="rentCarCode" checked="" id="rentCarCodeA" class="ui-input ui-input-radio">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">쏘렌토</span>
                                                                    </label>
                                                                    <label for="rentCarCodeB" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeB" class="ui-input ui-input-radio">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">싼타페</span>
                                                                    </label>
                                                                    <label for="rentCarCodeC" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeC" class="ui-input ui-input-radio">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">카니발</span>
                                                                    </label>
                                                                    <label for="rentCarCodeD" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeD" class="ui-input ui-input-radio">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">제네시스G80</span>
                                                                    </label>
                                                                    <!-- <label for="rentCarCodeF" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeF" class="ui-input ui-input-radio">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">ADVS-005</span>
                                                                    </label> -->
                                                                    
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <!-- <tr>
                                                        <th scope="row">
                                                            대여 일시
                                                        </th>
                                                        <td>
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <select name="rent_time" id="rent_time" class="ui-select ui-form-width--s">
																		<option value="09:00">09:00</option>
																		<option value="10:00">10:00</option>
																		<option value="11:00">11:00</option>
																		<option value="12:00">12:00</option>
																		<option value="13:00">13:00</option>
																		<option value="14:00">14:00</option>
																		<option value="15:00">15:00</option>
																		<option value="16:00">16:00</option>
																		<option value="17:00">17:00</option>
																		<option value="18:00">18:00</option>
																		<option value="19:00">19:00</option>
																		<option value="20:00">20:00</option>
																		<option value="21:00">21:00</option>
																		<option value="22:00">22:00</option>
																		<option value="23:00">23:00</option>
																		<option value="24:00">24:00</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                            반납 예정 일시
                                                        </th>
                                                        <td>
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <select name="return_time" id="return_time" class="ui-select ui-form-width--s">
																		<option value="09:00">09:00</option>
																		<option value="10:00">10:00</option>
																		<option value="11:00">11:00</option>
																		<option value="12:00">12:00</option>
																		<option value="13:00">13:00</option>
																		<option value="14:00">14:00</option>
																		<option value="15:00">15:00</option>
																		<option value="16:00">16:00</option>
																		<option value="17:00">17:00</option>
																		<option value="18:00">18:00</option>
																		<option value="19:00">19:00</option>
																		<option value="20:00">20:00</option>
																		<option value="21:00">21:00</option>
																		<option value="22:00">22:00</option>
																		<option value="23:00">23:00</option>
																		<option value="24:00">24:00</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr> -->
                                                    <tr>
                                                        <th scope="row">
                                                            운행 예정 지역
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--full" title="운행 예정 지역 입력" id="driving_schedule_place" name="driving_schedule_place">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                            수집데이터
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--full" title="수집데이터 입력" id="collect_data" name="collect_data">
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <!-- <tr>
                                                        <th scope="row">
                                                            업로드 예정일시
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <select name="upload_schedule_date" id="upload_schedule_date" class="ui-select ui-form-width--s">
																		<option value="09:00">09:00</option>
																		<option value="10:00">10:00</option>
																		<option value="11:00">11:00</option>
																		<option value="12:00">12:00</option>
																		<option value="13:00">13:00</option>
																		<option value="14:00">14:00</option>
																		<option value="15:00">15:00</option>
																		<option value="16:00">16:00</option>
																		<option value="17:00">17:00</option>
																		<option value="18:00">18:00</option>
																		<option value="19:00">19:00</option>
																		<option value="20:00">20:00</option>
																		<option value="21:00">21:00</option>
																		<option value="22:00">22:00</option>
																		<option value="23:00">23:00</option>
																		<option value="24:00">24:00</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr> -->
                                                    <tr>
                                                        <th scope="row">
                                                            비고
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <textarea type="text" class="ui-input ui-form-width--full" title="비고" id="etc" name="etc"/>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    
                                                    <tr>
                                                        <th scope="row">
                                                            첨부파일
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form ui-form-row align-center">
                                                                    <div class="file">
                                                                        <div class="file__input  ui-form-width--auto" id="file__input">
                                                                            <input class="file__input--file" id="customFile" type="file" multiple="multiple" name="files[]" />
                                                                            <input class="file__upload--name ui-form-width--300" disabled>
                                                                            <label class="file__input--label" for="customFile">파일찾기</label>
                                                                        </div>
                                                                      </div>
                                                                <div class="ui-form-block ml-20">
                                                                    <span class="el-caution font-xs">* 당일 신청불가, 명일부터 최대 2주까지 신청가능</span>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            
                                        </div>
                                        <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                            <button type="button" class="btn btn-width--l btn-color--white">취소</button>
                                            <button type="button" class="btn btn-width--l btn-color--navy js-popup" data-id="click_reserve" onclick="location.href='javascript:fn_Insert();' ">예약신청</button>
                                        </div>
                                        
                                    </div>
                                </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<!-- //container -->
</form:form>
