<%@page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@page import="katri.avsc.com.service.impl.MenuDAO"%>
<%@page import="java.util.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 관리자로 로그인 여부 */
	String user_id = (String)session.getAttribute("user_id");
	String user_nm = (String)session.getAttribute("user_nm");
	String agcy_nm = (String)session.getAttribute("agcy_nm");
	String auth_id = (String)session.getAttribute("auth_id");
	String grad_id = (String)session.getAttribute("grad_id");
	boolean login = user_id == null ? false: true;

	WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
	MenuDAO dao = (MenuDAO)wac.getBean("menuDAO");
	Map<String, String> paramMap = new HashMap<String, String>();
	
	if(!login){
		paramMap.put("authId", "101");
	}else{
		paramMap.put("authId", auth_id);		
	}
	paramMap.put("menuLevel", "1");
	List<?> topMenuList = dao.selectMenuList(paramMap);
	//메뉴생성 현재 구조상 2뎁스까지만 생성
	if(topMenuList != null && topMenuList.size() > 0){
		for(int i=0; i<topMenuList.size(); i++){
			Map menu =(Map)topMenuList.get(i);
			//System.out.println("### menu : " + menu);
			Map<String, String> menuMap = new HashMap<String, String>();
			menuMap.put("menuPrntId", (String)menu.get("menuId"));
			menuMap.put("menuLevel", "2");
			menuMap.put("authId", (String)paramMap.get("authId")); 
			menu.put("menuSubDeapth2", dao.selectMenuSubList(menuMap));
		}
	}
	//System.out.println(topMenuList);
%>

<script type="text/javaScript" language="javascript" defer="defer">
	if (location.href.indexOf("localhost") > -1) {
	} else {
		if (location.href.indexOf("http:") > -1) {
			//window.location.href = location.href.replace("http:", "https:");
		}
	}
</script>

<!-- header -->
<div id="header">
	<div class="t wrapBase">
		<h1>
			<a href="/main/Main.do"><i>한국교통안전공단</i><em>자율주행 데이터 공유센터</em></a>
		</h1>
		<p class="smenu">
<%
		if(!login) {
%>
			<!-- 로그인 전 -->
			<a href="https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do">로그인</a>
			<a href="https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do">회원가입</a>
			<a href="https://www.kotsa.or.kr/mbs/inqFrmFindMemberId.do">아이디/비밀번호 찾기</a>
			<!-- //로그인 전 -->
<%
		} else {
%>
			<!-- 로그인 후 -->
			<a href="#"><i class="font_sky"><img src="/images/avsc/top_icon_member.png" /><%=user_nm%></i></a>
			<a href="/account/Logout_Process.do">로그아웃</a>
			<a href="https://www.kotsa.or.kr/mpg/mim/MyPage.do">개인정보수정</a>
			<a href="/data/record/Data_Uphs_List.do"><i class="font_green">My Data</i></a>
			<a href="/openapi/OpenAPI_Apply.do"><i class="font_red">OpenAPI</i></a>
			<!-- //로그인 후 -->
<%
		}
%>
		</p>
	</div>
	<nav class="nav">
		<ul class="wrapBase">
<%
	if(topMenuList != null && topMenuList.size() > 0){
%>
<%
		for(int i=0; i<topMenuList.size(); i++){
%>
			<li>
<%
			Map menu =(Map)topMenuList.get(i);
			if("Y".equals(menu.get("useYn"))){
			if("Y".equals(menu.get("scriptYn"))){
%>
				<a href="javascript:<%=menu.get("scriptMethod") %>('<%=menu.get("menuObject") %>','<%=auth_id%>','<%=user_id%>');"><%=menu.get("menuNm") %></a>
				<div>
<%
			}else{
%>
				<a href="<%=menu.get("menuObject") %>"><%=menu.get("menuNm") %></a>
				<div>
<%
			}
			}
			List topMenuSubList = (List)menu.get("menuSubDeapth2");
			if(topMenuSubList != null && topMenuSubList.size() > 0){
				for(int j=0; j<topMenuSubList.size(); j++){
					Map menuSub =(Map)topMenuSubList.get(j);
					if("Y".equals(menuSub.get("useYn"))){
					if("Y".equals(menuSub.get("scriptYn"))){
						
%>
				<a href="javascript:<%=menuSub.get("scriptMethod") %>('<%=menuSub.get("menuObject") %>','<%=auth_id%>','<%=user_id%>');"><%=menuSub.get("menuNm") %></a>
<%					
					}else{
%>
				<a href="<%=menuSub.get("menuObject") %>"><%=menuSub.get("menuNm") %></a>
<%
					}
					}
				}
			}
%>
				</div>
			</li>
<%
		}
	}
%>		
			<i></i>
		</ul>
	</nav>	
<%-- 	<!-- 
	<nav class="nav">
		<ul class="wrapBase">
			<li>
				<a href="javascript:fn_OpenView('/open/cits/Open_Cits_List.do?bbs_seq=1010','<%=auth_id%>','<%=user_id%>');">공공데이터</a>
				<div>
					<a href="javascript:fn_OpenView('/open/cits/Open_Cits_List.do?bbs_seq=1010','<%=auth_id%>','<%=user_id%>');">평가시나리오</a>
					<a href="javascript:fn_OpenView('/open/cits/Open_Cits_List.do?bbs_seq=1020','<%=auth_id%>','<%=user_id%>');">자율주행차 거동정보</a>
					<a href="javascript:fn_OpenView('/open/dataset/Open_Dset_List.do','<%=auth_id%>','<%=user_id%>');">데이터셋</a>
				</div>
			</li>
			<li>
				<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_Main.do','<%=auth_id%>','<%=user_id%>');">협의체 데이터</a>
				<div>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010','<%=auth_id%>','<%=user_id%>');">차량거동정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2020','<%=auth_id%>','<%=user_id%>');">주행영상정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030','<%=auth_id%>','<%=user_id%>');">센서정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040','<%=auth_id%>','<%=user_id%>');">자율주행학습정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050','<%=auth_id%>','<%=user_id%>');">융합정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060','<%=auth_id%>','<%=user_id%>');">V2X정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070','<%=auth_id%>','<%=user_id%>');">기타자율주행정보 </a>
					<a href="javascript:fn_AgcyView('/agency/consultative/Agcy_Dset_List.do','<%=auth_id%>','<%=user_id%>');">데이터셋 </a>
				</div>
			</li>
			<li>
				<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">운행정보 보고</a>
				<div>
					<a href="javascript:fn_DutyView('/duty/incident/Duty_Incd_List.do','<%=auth_id%>','<%=user_id%>');">교통사고 </a>
					<a href="javascript:fn_DutyView('/duty/driving/Duty_Drvg_List.do','<%=auth_id%>','<%=user_id%>');">운행정보보고서 </a>
					<a href="javascript:fn_DutyView('/duty/device/Duty_Devc_List.do','<%=auth_id%>','<%=user_id%>');">장치및기능변경 </a>
				</div>
			</li>
			<li>
				<a href="/bbs/trend/Board_Trnd_List.do">자율주행 최신동향</a>
				<div>
					<a href="/bbs/trend/Board_Trnd_List.do">자율주행최신동향</a>
					<a href="/bbs/notice/Board_Notc_List.do">공지사항</a>
				</div>
			</li>
			<li>
				<a href="/center/introduce/Gude_Avsc_View.do">이용안내</a>
				<div>
					<a href="/center/introduce/Gude_Avsc_View.do">데이터공유센터소개 </a>
					<a href="/center/introduce/Gude_Cits_View.do">공공데이터 </a>
					<a href="/center/introduce/Gude_Cons_View.do">데이터공유협의체 </a>
					<a href="/center/introduce/Gude_Legl_View.do">법령 및 지침 </a>
					<a href="/center/introduce/Gude_Rept_View.do">자율주행차 임시운행 허가 </a>
				</div>
			</li>
			<i></i>
		</ul>
	</nav>
 	-->	 --%>
</div>
<!-- //header -->
