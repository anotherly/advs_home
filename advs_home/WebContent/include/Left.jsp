<%@page import="egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@page import="katri.avsc.com.service.impl.MenuDAO"%>
<%@page import="java.util.*"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)
	String cMenuId = request.getParameter("cMenuId"); //left include시에 하드코딩된 메뉴ID 받음.
	String pMenuId = request.getParameter("pMenuId"); //left include시에 하드코딩된 메뉴ID 받음.
	String leftType = request.getParameter("leftType"); //left include시에 하드코딩된 메뉴Type 받음.(게시판일 경우 다르게 처리) 게시판일경우 : BOARD
	
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
	paramMap.put("menuId", pMenuId);
	paramMap.put("menuLevel", "1");
	List<?> leftMenuList = dao.selectLeftMenuList(paramMap);
	//메뉴생성 현재 구조상 2뎁스까지만 생성
	if(leftMenuList != null && leftMenuList.size() > 0){
		for(int i=0; i<leftMenuList.size(); i++){
			Map menu =(Map)leftMenuList.get(i);
			//System.out.println("### leftMenu : " + leftMenu);
			Map<String, String> menuMap = new HashMap<String, String>();
			menuMap.put("menuPrntId", (String)menu.get("menuId"));
			menuMap.put("menuLevel", "2");
			menuMap.put("authId", (String)paramMap.get("authId")); 
			menu.put("menuSubDeapth2", dao.selectLeftMenuSubList(menuMap));
		}
	}
	//System.out.println(leftMenuList);
%>


  <!-- lmenu -->
  <div class="lmenu">
<%
	if(leftMenuList != null && leftMenuList.size() > 0){
%>
<%
		for(int i=0; i<leftMenuList.size(); i++){
%>
<%
			Map menu =(Map)leftMenuList.get(i);
			if("Y".equals(menu.get("useYn"))){
%>
				<p class="depth1">
					
						<% 
							String menuNm = "";
							if(menu.get("menuDesc") != null && ((String)menu.get("menuDesc")).length() > 0){
								menuNm = (String)menu.get("menuDesc");
							}else{
								menuNm = (String)menu.get("menuNm");
							}
							if(leftType != null && "BOARD".equals(leftType)){ 
								out.print("<i style=\"cursor:pointer\" onclick=\"javascript:location.replace('"+ menu.get("menuObject") +"');\">"+menuNm+"</i></p>");
							}else{
								out.print("<i>"+menuNm+"</i>");
							} 
						
						%>
					
				</p>
				<ul class="depth2">
<%
			}
			List leftMenuSubList = (List)menu.get("menuSubDeapth2");
			if(leftMenuSubList != null && leftMenuSubList.size() > 0){
				for(int j=0; j<leftMenuSubList.size(); j++){
					Map menuSub =(Map)leftMenuSubList.get(j);
					if("Y".equals(menuSub.get("useYn"))){
%>	
				<li<%=cMenuId.equals(menuSub.get("menuId")) ? " class='active'" : "" %>><a href="<%=menuSub.get("menuObject") %>"><%=menuSub.get("menuNm") %></a></li>
<%
					}
				}
			}
%>
				</ul>
<%
		}
	}
%>		
  </div>
  <!-- lmenu -->
