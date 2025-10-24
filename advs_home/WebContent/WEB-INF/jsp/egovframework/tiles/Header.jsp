<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 관리자로 로그인 여부 */
	String user_id = (String)session.getAttribute("user_id");
	String user_nm = (String)session.getAttribute("user_nm");
	String agcy_nm = (String)session.getAttribute("agcy_nm");
	String auth_id = (String)session.getAttribute("auth_id");
	String grad_id = (String)session.getAttribute("grad_id");
	boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" defer="defer">

	if (location.href.indexOf("localhost") > -1) {
	} else {
		if (location.href.indexOf("http:") > -1) {
			//window.location.href = location.href.replace("http:", "https:");
		}
	}
	
	function fnOpenGnb(){
		$("#gnb_nav").attr('class', 'open');
	}
	
	function fnCloseGnb(){
		$("#gnb_nav").removeClass("open");
	}	

</script>

<!-- header -->
<header>
   <nav class="nav">
       <div class="nav__inner">
<%
		if(!login) {
%>
			<!-- 로그인 전 -->
			<!-- <a href="https://tsum.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do">회원가입</a>
			<a href="https://tsum.kotsa.or.kr/mbs/inqFrmFindMemberId.do">ID/PW찾기</a>
			<a href="https://tsum.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do">로그인</a> -->
			
			<a href="https://tsum.kotsa.or.kr/tsum/mbs/insFrmMemberType.do?menuCode=09010000">회원가입</a>
			<a href="https://tsum.kotsa.or.kr/tsum/mbs/inqFrmFindMemberId.do?menuCode=09010000">ID/PW찾기</a>
			<a href="https://tsum.kotsa.or.kr/tsum/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do">로그인</a>
			
			<!-- //로그인 전 -->
<%
		} else {
%>
           <a href="#"><%=user_nm%></a>
           <!-- <a href="/account/Logout_Process.do">로그아웃</a>
           <a href="https://tsum.kotsa.or.kr/mpg/myPage.do?menuCode=09010000">개인정보수정</a> -->
           <a href="/account/Logout_Process.do">로그아웃</a>           
           <a href="https://tsum.kotsa.or.kr/tsum/mpg/myPage.do?menuCode=09010000">개인정보수정</a> 
           <a href="/data/record/Data_Uphs_List.do">My Data</a>
<!--            <a href="/openapi/OpenAPI_Apply.do">Open API</a> -->
<%
		}
%>
       </div>
   </nav>
   <div class="header-menuWrap">
       <div class="header__inner">
           <h1 class="header__logo">
               <a href="/main/Main.do">
                   <span class="hidden">TS 한국교통안전공단 자동차안전연구원</span>
               </a>
           </h1>
           <div class="gnb">
<%
		if(!login) {
%>
				<a href="/bbs/notice/Board_Notc_List.do">
                   	공지사항
                </a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">공지사항</h2>
                       <div class="gnb-depth--03 part1">
                           <div class="gnb-depth--03__item">
	                           <a href="/bbs/notice/Board_Notc_List.do">
	                               <h3 class="gnb-depth--03__tit">공지사항</h3>
	                           	</a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
								<a href="/bbs/trend/Board_Trnd_List.do">
									<h3 class="gnb-depth--03__tit">자율주행 최신동향</h3>
								</a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
               
			<a href="/center/introduce/Gude_Avsc_View.do">
                  	 이용안내 
               </a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">이용안내</h2>
                       <div class="gnb-depth--03 part2">
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Avsc_View.do">
                               <h3 class="gnb-depth--03__tit">데이터공유센터 소개</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Cits_View.do">
                               <h3 class="gnb-depth--03__tit">자율주행 AI 학습용 <br/>데이터</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Cons_View.do">
                               <h3 class="gnb-depth--03__tit">데이터공유협의체</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Legl_View.do">
                               <h3 class="gnb-depth--03__tit">법령 및 지침</h3>
							</a>                               
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Rept_View.do">
                               <h3 class="gnb-depth--03__tit">자율주행차 임시운행 <br/>허가</h3>
							</a>                               
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
			
			<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">운행정보 보고</a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                   		<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">
                       <h2 class="gnb-depth--02__tit">운행정보 보고</h2></a>
                       <div class="gnb-depth--03 part3">
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">교통사고</h3></a>
                               <!-- <ul class="lists 
                               lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/driving/Duty_Drvg_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">운행정보보고서</h3></a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/device/Duty_Devc_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">장치 및 기능변경</h3></a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>			
			
			
			<a href="/open/normal/Open_Normal_List.do?bbs_seq=3010">공공데이터 </a>
              <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">공공데이터</h2>
                       <div class="gnb-depth--03 part4">
                           <div class="gnb-depth--03__item">
                               <a href="/open/normal/Open_Normal_List.do?bbs_seq=3010">
                               <h3 class="gnb-depth--03__tit">일반 시나리오<br/>데이터셋</h3></a>
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="/open/edge/Open_Edge_List.do?bbs_seq=3020">
                               <h3 class="gnb-depth--03__tit">엣지케이스 시나리오<br/>데이터셋</h3></a>
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="/open/v2x/Open_V2x_List.do?bbs_seq=3030">
                               <h3 class="gnb-depth--03__tit">V2X<br/>데이터셋</h3></a>
                           </div>
                       </div>
                   </div>
               </div>
<%
		} else {
%>
				<a href="/bbs/notice/Board_Notc_List.do">
                   	공지사항
               </a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">공지사항</h2>
                       <div class="gnb-depth--03 part1">
                           <div class="gnb-depth--03__item">
	                           <a href="/bbs/notice/Board_Notc_List.do">
	                               <h3 class="gnb-depth--03__tit">공지사항</h3>
	                           	</a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
								<a href="/bbs/trend/Board_Trnd_List.do">
									<h3 class="gnb-depth--03__tit">자율주행 최신동향</h3>
								</a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
               
			<a href="/center/introduce/Gude_Avsc_View.do">
                  	 이용안내 
               </a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">이용안내</h2>
                       <div class="gnb-depth--03 part2">
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Avsc_View.do">
                               <h3 class="gnb-depth--03__tit">데이터공유센터 소개</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Cits_View.do">
                               <h3 class="gnb-depth--03__tit">자율주행 AI 학습용 <br/>데이터</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Cons_View.do">
                               <h3 class="gnb-depth--03__tit">데이터공유협의체</h3>
                            </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Legl_View.do">
                               <h3 class="gnb-depth--03__tit">법령 및 지침</h3>
							</a>                               
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="/center/introduce/Gude_Rept_View.do">
                               <h3 class="gnb-depth--03__tit">자율주행차 임시운행 <br/>허가</h3>
							</a>                               
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
			
			<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">운행정보 보고</a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                   		<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">
                       <h2 class="gnb-depth--02__tit">운행정보 보고</h2></a>
                       <div class="gnb-depth--03 part3">
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">교통사고</h3></a>
                               <!-- <ul class="lists 
                               lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/driving/Duty_Drvg_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">운행정보보고서</h3></a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	<a href="javascript:fn_DutyView('/duty/device/Duty_Devc_List.do','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">장치 및 기능변경</h3></a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
              <a href="javascript:fn_OpenView('/open/normal/Open_Normal_List.do?bbs_seq=3010','<%=auth_id%>','<%=user_id%>');">공공데이터 </a>
              <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">공공데이터</h2>
                       <div class="gnb-depth--03 part4">
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_OpenView('/open/normal/Open_Normal_List.do?bbs_seq=3010','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">일반 시나리오<br/>데이터셋</h3></a>
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_OpenView('/open/edge/Open_Edge_List.do?bbs_seq=3020','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">엣지케이스 시나리오<br/>데이터셋</h3></a>
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_OpenView('/open/v2x/Open_V2x_List.do?bbs_seq=3030','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">V2X<br/>데이터셋</h3></a>
                           </div>
                       </div>
                   </div>
               </div>
<%		
		}
%>
               <a href="javascript:fn_AgcyView('/open/normal/Open_Normal_List.do?bbs_seq=2080','<%=auth_id%>','<%=user_id%>');">협의체 데이터</a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">협의체 데이터</h2>
                       <div class="gnb-depth--03 part5">
                           <div class="gnb-depth--03__item">
                           	   <a href="javascript:fn_AgcyView('/open/normal/Open_Normal_List.do?bbs_seq=2080','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">
                                   	일반 시나리오<br/>데이터셋
                               </h3>
                               </a>
                           </div>
                           <div class="gnb-depth--03__item">
                           	   <a href="javascript:fn_AgcyView('/open/edge/Open_Edge_List.do?bbs_seq=2090','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">
                                   	엣지케이스 시나리오<br/>데이터셋
                               </h3>
                               </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	   <a href="javascript:fn_AgcyView('/open/v2x/Open_V2x_List.do?bbs_seq=2100','<%=auth_id%>','<%=user_id%>');">
                               <h3 class="gnb-depth--03__tit">
                                   V2X <br/>데이터셋
                               </h3>
                               </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_AgcyView('/agency/off/Agcy_Off_Main.do','<%=auth_id%>','<%=user_id%>');">
                                   <h3 class="gnb-depth--03__tit">오프라인 공유<br/>안내 및 신청</h3>
                               </a>
                           </div>
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010','<%=auth_id%>','<%=user_id%>');">
	                               <h3 class="gnb-depth--03__tit">
	                                   	데이터셋(21년 이전)                                    
	                               </h3>
	                           </a>
<!--                                <ul class="lists lists-cir--s"> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010','<%=auth_id%>','<%=user_id%>');">차량거동정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030','<%=auth_id%>','<%=user_id%>');">센서정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040','<%=auth_id%>','<%=user_id%>');">자율주행학습정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050','<%=auth_id%>','<%=user_id%>');">융합정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060','<%=auth_id%>','<%=user_id%>');">V2X정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070','<%=auth_id%>','<%=user_id%>');">기타자율주행정보 </a> --%>
<!--                                    </li> -->
<!--                                    <li> -->
<%--                                        <a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Dset_List.do','<%=auth_id%>','<%=user_id%>');">데이터셋 </a> --%>
<!--                                    </li> -->
<!--                                </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
               <a href="javascript:fn_AgcyView('/sharing/car/Car_Reserve_Main.do','<%=auth_id%>','<%=user_id%>');">
                   	데이터 공유센터 시설이용
               </a>
               <div class="gnb-depth--02">
                   <div class="gnb-depth--02__inner">
                       <h2 class="gnb-depth--02__tit">데이터 공유센터 시설이용</h2>
                       <div class="gnb-depth--03 part6">
                           <div class="gnb-depth--03__item">
                               <a href="javascript:fn_AgcyView('/sharing/car/Car_Reserve_Main.do','<%=auth_id%>','<%=user_id%>');">
                               	   <h3 class="gnb-depth--03__tit">차량 플랫폼 공유</h3>
                               </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                           <div class="gnb-depth--03__item">
                           	   <a href="javascript:fn_AgcyView('/center/fact/Center_Fact_Main.do','<%=auth_id%>','<%=user_id%>');">
                               	   <h3 class="gnb-depth--03__tit">공유센터 이용안내</h3>
                               </a>
                               <!-- <ul class="lists lists-cir--s">
                                   <li>
                                       <a href="">text</a>
                                   </li>
                               </ul> -->
                           </div>
                       </div>
                   </div>
               </div>
               
               
               
               
           </div>
<!--            <div class="side-menu"> -->
<!--                <div class="side-menu__inner"> -->
<!--                    <button type="button" class="side-menu__btn" title="사이드 메뉴 열림"> -->
<!--                        <span></span> -->
<!--                    </button> -->
<!--                </div> -->
<!--            </div> -->
       </div>
   </div>
</header>
<!-- //header -->
