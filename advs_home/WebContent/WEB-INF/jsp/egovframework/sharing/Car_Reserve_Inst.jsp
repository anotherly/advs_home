<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script src="/js/clip.js"></script> <!-- ClipReport4 -->

<script type="text/javaScript" defer>
	var selectDay = "${selectDay}";
	var carCode = "${carCode}";

	//폼 변수
	var c_form = "";
	var G_today = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    let today = new Date();  
//     let after1Day = new Date(today.setDate(today.getDate() + 1));	// 다음날
//     today = new Date(); 
//     let after15Day = new Date(today.setDate(today.getDate() + 15));	// 다음날
//     today = new Date(); 
	    let after1Day = new Date();	// 다음날
	    after1Day.setDate(today.getDate() + 1)
	    let after15Day = new Date();	// 다음날
	    after15Day.setDate(today.getDate() + 15) 


    let after1Day_year = after1Day.getFullYear(); // 년도
    let after1Day_month = after1Day.getMonth() + 1;  // 월
    let after1Day_date = after1Day.getDate();  // 날짜
    
    let after15Day_year = after15Day.getFullYear(); // 년도
    let after15Day_month = after15Day.getMonth() + 1;  // 월
    let after15Day_date = after15Day.getDate();  // 날짜
    
    $('#biz_number').keydown(function (event) {
        var key = event.charCode || event.keyCode || 0;
        $text = $(this); 
        if (key !== 8 && key !== 9) {
            if ($text.val().length === 3) {
                $text.val($text.val() + '-');
            }
            if ($text.val().length === 6) {
                $text.val($text.val() + '-');
            }
        }

        return (key == 8 || key == 9 || key == 46 || (key >= 48 && key <= 57) || (key >= 96 && key <= 105));
		 // Key 8번 백스페이스, Key 9번 탭, Key 46번 Delete 부터 0 ~ 9까지, Key 96 ~ 105까지 넘버패트
		 // 한마디로 JQuery 0 ~~~ 9 숫자 백스페이스, 탭, Delete 키 넘버패드외에는 입력못함
    })
    if( selectDay == ""){
	    $("#rent_dt").val(after1Day_year+""+(("00"+after1Day_month.toString()).slice(-2))+""+(("00"+after1Day_date.toString()).slice(-2)));
    	$("#return_dt").val(after1Day_year+""+(("00"+after1Day_month.toString()).slice(-2))+""+(("00"+after1Day_date.toString()).slice(-2)));
    }else{
	    /* $("#rent_dt").val(after1Day_year+""+(("00"+after1Day_month.toString()).slice(-2))+""+("0" + (selectDay)).slice(-2));
    	$("#return_dt").val(after1Day_year+""+(("00"+after1Day_month.toString()).slice(-2))+""+(("00"+selectDay).slice(-2))); */
    	$("#rent_dt").val(selectDay);
    	$("#return_dt").val(selectDay);
    }
    if( carCode != ""){
    	switch(carCode) {
    		case "쏘렌토" : 
    			$('#rentCarCodeA').prop('checked', true);
    			break;
    		case "싼타페" : 
    			$('#rentCarCodeB').prop('checked', true);
    			break;
    		case "카니발" : 
    			$('#rentCarCodeC').prop('checked', true);
    			break;
    		case "제네시스G80" : 
    			$('#rentCarCodeD').prop('checked', true);
    			break;
    	}
    }
    
    //$("#return_dt").val(after15Day_year+""+(("00"+after15Day_month.toString()).slice(-2))+""+(("00"+after15Day_date.toString()).slice(-2)));
  });
  
	function go_List(){
		c_form.action = "<c:url value='/sharing/car/Car_Reserve_List.do'/>";
		c_form.submit();
	}
	
	  /* 등록 function */
	function fn_Insert() {
		if(trim(c_form.biz_number.value).length != 12){
			alert("사업자등록번호 10자리를 입력해주세요.");
			c_form.biz_number.focus();
			return;
		}
		if(c_form.biz_number.value == ""){
			alert("사업자등록번호를 입력해주세요.");
			return ;
		}
		if(!checkBizno(c_form.biz_number.value)){
			alert("유효한 사업자번호가 아닙니다. 정확히 다시 입력해주세요.");
			return;
		}
		
		if(trim(c_form.rent_dt.value).length==0){
		    alert("대여일자 및 반납일자을 입력해주세요.");
			c_form.rent_dt.focus();
			return;
		}
		if(trim(c_form.return_dt.value).length==0){
		    alert("대여일자 및 반납일자을 입력해주세요.");
			c_form.return_dt.focus();
			return;
		}
		
		c_form.rent_car_code.value = $("input[name='rentCarCode']:checked").val();

	    var rent_dt_val = $("#rent_dt").val().replace(/-/gi, "");
	    var return_dt_val = $("#return_dt").val().replace(/-/gi, "");
	    
	    if(rent_dt_val <= G_today){
	    	alert("대여일자는 당일 또는 과거날짜로 설정할 수 없습니다.");
	    	return;
	    }
	    
	    if(rent_dt_val > return_dt_val){
	    	alert("반납일자는 대여일자보다 빠를 수 없습니다.");
	    	return;
	    }
	    var startWeek = new Date($('#rent_dt').val())
	    startWeek.setDate(startWeek.getDate() + 14);
	    var endWeek = new Date($('#return_dt').val())
	    endWeek.setDate(endWeek.getDate());
	    if(endWeek > startWeek){
	    	alert("대여기간은 2주를 넘길 수 없습니다.");
	    	return;
	    }
	    
	    //filename
	    var fileCheck = document.getElementById("filename").value;
	    if(!fileCheck){
	        alert("사업자등록증을 첨부해 주세요");
	        return false;
	    }
	    
	    var rentDayStr = $("#rent_dt").val().split('-');
	    var returnDayStr = $("#return_dt").val().split('-');
	    var rentDayMin = new Date(rentDayStr[0], rentDayStr[1], rentDayStr[2]); 
	    var returnDayMin = new Date(returnDayStr[0], returnDayStr[1], returnDayStr[2]);
	    var btMs = returnDayMin.getTime() - rentDayMin.getTime();
		var rentDay = btMs/(1000*60*60*24)+1;
		c_form.rentDay.value = rentDay;		
	    if(confirm("등록 하시겠습니까?")) {
	    	// 내가 택한 날짜에 예약건이 있는지 확인
	    	
	    	$.ajax({
			    type : "POST",
			    dataType : "json",
			    url : "/sharing/car/Car_Reserve_SelectCarCode.do",
			    data : {"rentCarCode": $("#rent_car_code").val()/* , "returnDtVal": return_dt_val, "rentDtVal": rent_dt_val */},
			    success : function(data) {
			    	if(data.resultList != ''){
				    	var totalDate = "";
				    	var result = data.resultList;
				    	var dateArr1 = fn_dateStartToLast($("#rent_dt").val(), $("#return_dt").val());
				    	var dateArr2 = "";
				    	$.each(result, function(index, item){
				    		dateArr2 += fn_dateStartToLast(item.rentDt, item.returnDt);
				    	});
				    	totalDate = dateArr1.filter(x => dateArr2.includes(x));
				    	//for(var i=0; i<totalDate.length; i++){
				    		if(totalDate[0] != null){ // 하나라도 있다면... 0으로 찍어줌
				    			var resDay = totalDate[0].split('-');
				    			alert(resDay[2]+"일은 예약이 불가 합니다.");
				    			return;
				    	//	}
				    	}
			    	}
		    		c_form.action = "<c:url value='/sharing/car/Car_Reserve_Inst_Process.do'/>";
					c_form.submit();
					if(confirm("차량 플랫폼 공유 신청서를 출력 하시겠습니까?")){
						fn_Insert_Next();
					}
			    	
			    },
			    error : function(data) {
			    	alert("오류가 발생했습니다.");
			    }
		  	});
		}
	  }
	  
	function fn_dateStartToLast(startDate, lastDate){
		  var resultDate= [];
		  var curDate = new Date(startDate);
		  while(curDate <= new Date(lastDate)){
			  resultDate.push(curDate.toISOString().split("T")[0]);
			  curDate.setDate(curDate.getDate()+1);
		  }
		  return resultDate;
	  }

	function fn_Insert_Next() {
		//oEditors.getById["b_content"].exec("UPDATE_CONTENTS_FIELD", []);
		alert("서명후 저장하시면 PDF 파일로 저장됩니다.\n ※ "+"${map.content}"+"/"+"${map.telNo}"+"로 연락바랍니다. \n  신청서 출력 원본은 공단에 제출해주시기 바랍니다.");
		//alert("서명후 저장하시면 PDF 파일로 저장됩니다.\n ※ 커넥티드카연구처/"+"${map.telNo}"+"로 연락바랍니다. \n  신청서 출력 원본은 공단에 제출해주시기 바랍니다.");
		fn_Report();
	}
	
	/* 보고서생성 function */
	function fn_Report() {
		var oReport = GetfnParamSet();
		oReport.rptname = "Car_Reserve_Inst";
    	oReport.param("agcy_nm").value = $("#apply_company_code").val();
    	oReport.param("biz_number").value = $("#biz_number").val();
    	oReport.param("agency_adres").value = $("#agency_adres").val();
    	oReport.param("return_dt").value = $("#return_dt").val();
    	oReport.param("rent_dt").value = $("#rent_dt").val();
    	oReport.param("rent_day").value = $("#rentDay").val()+"일";
    	oReport.param("rentCarCode").value = $("#rent_car_code").val();
    	oReport.param("driving_schedule_place").value = $("#driving_schedule_place").val();
    	oReport.param("collect_data").value = $("#collect_data").val();
    	oReport.param("etc").value = $("#etc").val();
    	
    	oReport.open();
	}
	
	function checkBizno(bizno){
		var biznoMap = bizno.replace(/-/gi, '').split('').map(function(i){
			return parseInt(i, 10);
		});
		if(biznoMap.length == 10){
			var keyArr = [1, 3, 7, 1, 3, 7, 1, 3, 5];
			var chk = 0;
			keyArr.forEach(function(d, i){
				chk += d*biznoMap[i];
			});
			chk += parseInt((keyArr[8] * biznoMap[8])/10, 10);
			return Math.floor(biznoMap[9]) === ((10-(chk%10)) % 10);
		}
		return false;
	}
	
</script>

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="fileName" id="fileName"/>
<input type="hidden" name="fileSize" id="fileSize"/>
<input type="hidden" name="filePath" id="filePath"/>
<input type="hidden" name="rentDay" id="rentDay"/>
<input type="hidden" name="apply_company_code" id="apply_company_code" value="${agcy_nm}"/>
<input type="hidden" name="rent_car_code" id="rent_car_code"/>

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
	                        <h3 class="lnb__tit">데이터공유센터<br/>시설이용</h3>
	                        <div class="lnb-list">
	                            <div class="lnb-item is-active is-open">
	                                <a href="">차량 플랫폼 공유</a>
	                                <ul class="lnb-depth--02 lists lists-cir--s">
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_Main.do">안내</a>
	                                    </li>
	                                    <li class="is-active">
	                                        <a href="/sharing/car/Car_Reserve_Inst.do">예약신청</a>
	                                    </li>
	                                    <li>
	                                        <a href="/sharing/car/Car_Reserve_List.do">예약현황 및 취소</a>
	                                    </li>
	                                </ul>
	                            </div>
	                            <div class="lnb-item">
	                                <a href="">공유센터 이용안내</a>
	                                <ul class="lnb-depth--02 lists lists-cir--s">
	                                    <li class="is-active">
	                                        <a href="/center/fact/Center_Fact_Main.do">회의실 안내</a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </div>
                        </div>
                        <div class="layout-content">
                                    <div class="layout-content__inner">
                                        <div class="layout-content__top">
                                            <h4 class="layout-content__tit">차량 플랫폼 공유</h4>
                                            <ul class="location ml-auto">
                                                <li>
                                                    <img src="/image/sub/icon/icon-home.png" alt="홈">
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
                                                    <col style="width:15%">
                                                    <col style="width:auto">
                                                    <col style="width:15%">
                                                    <col style="width:30%">
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
                                                            <span class="el-caution font-s">*</span>사업자등록번호
                                                        </th>
                                                        <td>
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--full" title="사업자등록번호 입력" id="biz_number" name="biz_number"  maxlength="12">
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
                                                            <span class="el-caution font-s">*</span>날짜 선택
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form ui-form-row align-center js-datepicker">
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--s js-datepicker" title="날짜 선택 대여일시" id="rent_dt" name="rent_dt">
                                                                </div>
                                                                <span class="el-hyphen mx-3"></span>
                                                                <div class="ui-form-block">
                                                                    <input type="text" class="ui-input ui-form-width--s js-datepicker" title="날짜 선택 반납일시" id="return_dt" name="return_dt">
                                                                </div>
                                                            </div>
                                                            <div class="ui-form-block ml-20">
                                                                 <span class="el-caution font-xs">※ 당일 신청불가, 명일부터 최대 2주까지 신청가능</span>
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
                                                                        <input type="radio" name="rentCarCode" checked="" id="rentCarCodeA" class="ui-input ui-input-radio" value="쏘렌토">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">쏘렌토</span>
                                                                    </label>
                                                                    <label for="rentCarCodeB" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeB" class="ui-input ui-input-radio" value="싼타페">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">싼타페</span>
                                                                    </label>
                                                                    <label for="rentCarCodeC" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeC" class="ui-input ui-input-radio" value="카니발">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">카니발</span>
                                                                    </label>
                                                                    <label for="rentCarCodeD" class="ml-30">
                                                                        <input type="radio" name="rentCarCode" id="rentCarCodeD" class="ui-input ui-input-radio" value="제네시스G80">
                                                                        <span class="ui-input-radio__span"></span>
                                                                        <span class="ui-input-radio__txt">제네시스G80</span>
                                                                    </label>
                                                            </div>
                                                        </td>
                                                    </tr>
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
                                                                    <input type="text" class="ui-input ui-form-width--full" title="수집데이터 입력" id="collect_data" name="collect_data" >
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                   <tr>
                                                        <th scope="row">
                                                            비고
                                                        </th>
                                                        <td colspan="3">
                                                            <div class="ui-form">
                                                                <div class="ui-form-block">
                                                                    <textarea type="text" class="ui-input ui-form-width--full" title="비고" id="etc" name="etc" ></textarea>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr> 
                                             <tr>
                                                 <th scope="row">첨부파일</th>
                                                 <td colspan="3">
                                                     <div class="ui-form">
                                                         <div class="file">
                                                             <div class="file__input" id="file__input">
                                                                 <input class="file__input--file" name="file_info" id="file_info" type="file" onChange="fileExtCheck(this);">
                                                                 <input type="text" class="file__upload--name" name="filename" id="filename" placeholder="선택된 파일 없음">
                                                                 <label class="file__input--label" for="file_info">파일찾기</label>
                                                             </div>
                                                         </div>
                                                     </div>
                                                            <div class="ui-form-block ml-20">
                                                                 <span class="el-caution font-xs">※ 사업자등록증 첨부 필요</span>
                                                             </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                            <button type="button" class="btn btn-width--l btn-color--white">취소</button>
                                            <button type="button" class="btn btn-width--l btn-color--navy js-popup" onclick="location.href='javascript:fn_Insert();' ">예약신청</button>
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
<!-- popup content -->
<!-- <div class="popup-wrap" id="click_reserve"> -->
<!--     <div class="popup" style="width:500px;"> -->
<!--         <div class="popup__inner"> -->
<!--             <div class="popup-header"> -->
<!--                 <div class="d-flex"> -->
<!--                     <span class="popup-logo__img"> -->
<!--                         <img src="/image/sub/img-popup__logo.png" alt="TS"> -->
<!--                     </span> -->
<!--                     <h6>안내</h6> -->
<!--                     <button type="button" class="popup-close" title="팝업 닫기"> -->
<!--                         <img src="/image/sub/icon/icon-popup__close.png" alt=""> -->
<!--                     </button> -->
<!--                 </div> -->
<!--             </div> -->
<!--             <div class="popup-cont"> -->
<!--                 <div class="popup-cont__inner"> -->
<!--                     <div class="popup-box"> -->
<!--                         <p class="popup-box__txt"> -->
<!--                             <span class="popup-box__name" id="popupName">자동차안전연구원</span> 님<br/><br/> -->
<!--                             <span class="popup-box__date" id="popupContents">2022년 11월 01일 [ADVS-001 / 종일] </span><br/><br/> -->
<!--                             예약이 완료되었습니다 -->
<!--                         </p> -->
<!--                     </div> -->
<!--                     <p class="popup__capt el-caution font-s mt-10 ta-c"> -->
<!--                         ※ 예약취소는 예약일로부터 1일 전까지 가능합니다. -->
<!--                     </p> -->
<!--                     <div class="btn-wrap mt-40 ta-c"> -->
<!--                         <button type="button" class="btn popup-okay btn-width--s btn-height--s btn-color--navy">확인</button> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->
<!-- <div class="popup-overlay"></div> -->
</form:form>
