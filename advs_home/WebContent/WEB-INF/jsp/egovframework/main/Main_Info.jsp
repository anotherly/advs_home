<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer="defer">
  //폼 변수
  var c_form = "";

$(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    //최신
    /* $("span[id=sp_po]").click(function() {
    	$("#dd_recnt").show();
      $("#dd_count").hide();
      $("#sp_po").children('a').addClass('active');
      $("#sp_cn").children('a').removeClass('active');
    });
    //접기
    $("span[id=sp_cn]").click(function() {
      $("#dd_recnt").hide();
      $("#dd_count").show();
      $("#sp_po").children('a').removeClass('active');
      $("#sp_cn").children('a').addClass('active');
    }); */
  });

</script>

<form:form id="listForm" name="listForm" method="post" >
<div class="container" id="main_h">
            <div class="container__inner">
                <div class="content">
                    <div class="content__inner">
                        <div id="fullpage">
                            <div class="fullpage-block fullpage-block--main">
                                <div class="fullpage-block__inner">
                                    <span class="fullpage-block--main__img">
<!--                                         <img src="/image/main/img-main-visual--logo.png" alt="TS 한국교통안전공단"> -->
                                    </span>
                                    <h2 class="fullpage-block--main__tit">
                                        	자율주행차<br/>데이터 공유센터
                                    </h2>
                                    <div class="fullpage-block--main__boxes fullpage-box">
                                        <div class="fullpage-box--notice">
                                            <h4 class="fullpage-box__tit d-flex align-center justify-between">
                                               	공지사항
                                                <a href="/bbs/notice/Board_Notc_List.do" title="공지사항 더보기" class="link-more">
                                                    <span></span>
                                                </a>
                                            </h4>
                                            <ul class="lists lists-cir lists-cir--s">
								              <c:choose>
								                <c:when test="${notcList eq null || empty notcList}">
								                  <li>등록된 공지사항이 없습니다</li>
								                </c:when>
								                <c:otherwise>
								                  <c:forEach var="list" items="${notcList}" varStatus="status">
								                    <li>
								                      <a href="/bbs/notice/Board_Notc_Info.do?blbd_div_cd=${list.blbdDivCd}&bdwr_seq=${list.bdwrSeq}">${list.bdwrTtlNm}</a>
								                      <span>${list.regDateView}</span>
								                    </li>
								                  </c:forEach>
								                </c:otherwise>
								              </c:choose>
                                            </ul>
                                        </div>
                                        <div class="fullpage-box--trend">
                                            <h4 class="fullpage-box__tit d-flex align-center justify-between">
                                                	자율주행 최신동향
                                                <a href="/bbs/trend/Board_Trnd_List.do" title="자율주행 공지사항 더보기" class="link-more">
                                                    <span></span>
                                                </a>
                                            </h4>
                                            <ul class="lists lists-cir lists-cir--s">
								              <c:choose>
								                <c:when test="${trndList eq null || empty trndList}">
								                  <li>등록된 동향자료가 없습니다</li>
								                </c:when>
								                <c:otherwise>
								                  <c:forEach var="list" items="${trndList}" varStatus="status">
								                    <li>
								                      <a href="/bbs/trend/Board_Trnd_Info.do?blbd_div_cd=${list.blbdDivCd}&bdwr_seq=${list.bdwrSeq}">${list.bdwrTtlNm}</a>
								                      <span>${list.regDateView}</span>
								                    </li>
								                  </c:forEach>
								                </c:otherwise>
								              </c:choose>
                                            </ul>
                                        </div>
                                        <div class="fullpage-box--intro fullpage-box__quickLink">
                                            <a href="/center/introduce/Gude_Avsc_View.do">
                                                <span class="fullpage-box__img">
                                                    <img src="/image/main/img-main-box01.png" alt="">
                                                </span>
                                                <span class="fullpage-box__txt">
                                                    <em class="fullpage-box__cap">자율주행차</em>
                                                    	데이터 공유센터 소개
                                                </span>
                                            </a>
                                        </div>
                                        <div class="fullpage-box--report fullpage-box__quickLink">
                                            <a href="/center/introduce/Gude_Cons_View.do">
                                                <span class="fullpage-box__img">
                                                    <img src="/image/main/img-main-box03.png" alt="">
                                                </span>
                                                <span class="fullpage-box__txt">
                                                    <em class="fullpage-box__cap">데이터공유협의체</em>
                                                    	가입신청 안내
                                                </span>
                                            </a>
                                        </div>
                                        <div class="fullpage-box--download fullpage-box__quickLink">
                                            <a href="/sharing/car/Car_Reserve_Main.do">
                                                <span class="fullpage-box__img">
                                                    <img src="/image/main/img-main-box04.png" alt="">
                                                </span>
                                                <span class="fullpage-box__txt">
                                                    <em class="fullpage-box__cap">데이터 공유센터 시설이용</em>
                                                   	 차량 플랫폼 공유
                                                </span>
                                            </a>
                                        </div>
                                        <div class="fullpage-box--share fullpage-box__quickLink">
                                            <a href="javascript:fn_DutyView('/duty/driving/Duty_Drvg_List.do','${auth_id}','${user_id}');">
                                                <span class="fullpage-box__img">
                                                    <img src="/image/main/img-main-box02.png" alt="">
                                                </span>
                                                <span class="fullpage-box__txt">
                                                    <em class="fullpage-box__cap">운행정보보고</em>
                                                    	운행정보 보고서 열람
                                                </span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
</form:form>
<!-- 251114 취약점조치 : 임시로그인 삭제 -->
<!-- <script type="text/javaScript" defer="defer">
document.addEventListener('keydown', function(e){
    var keyCode = e.keyCode;
    if(e.shiftKey && e.ctrlKey && keyCode === 76){
    	document.location = '/common/error.jsp'
    }
});
</script> -->
					    
