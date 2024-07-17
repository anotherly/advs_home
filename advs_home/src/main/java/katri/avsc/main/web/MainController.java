package katri.avsc.main.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.enterprise.inject.Model;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.com.core.Util;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;
import katri.avsc.main.service.MainService;
import katri.avsc.vise.service.ViseService;

/**
 * 메인 > 메인
 * @author jwchoi
 */
@Controller
public class MainController {
	
	/** EgovSampleService */
	@Resource(name = "mainService")
	MainService mainService;

	/** EgovSampleService */
	@Resource(name = "viseService")
	ViseService viseService;
	
	private static final Log LOG = LogFactory.getLog(MainController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;
	
	@RequestMapping({"/login.do"})
	  public String login(HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session) throws IOException  {
		LOG.debug(" ########## login.do ###########");
		return "/login";
	  }
	
	/**
	 * 메인화면
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "main/Main"
	 * @exception Exception
	 */
	@RequestMapping(value = "/main/Main.do")
	public String homeMain(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Main.do ###########");
		LOG.debug("    user_id["+(String)session.getAttribute("user_id")+"]");
		
		/**/

		//임시운행번호 총갯수
		int drvnoCnt = mainService.selectTempOperTotCnt(paramMap);
		//총주행거리
		Map<String, String> distInfo = mainService.selectDrivingInfo(paramMap);
		//데이터 건수
		int dataTotCnt = mainService.selectDataTotCnt(paramMap);
		//데이터 용량
		String dataTotVol = mainService.selectDataTotVolume(paramMap);
		//게시판 : 공지사항
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("blbd_div_cd", "101");
		map01.put("board_cnt", "1");	//표출갯수
		List<?> notcList = mainService.selectNoticeList(map01);
		//게시판 : 자율주행
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("blbd_div_cd", "102");
		map02.put("board_cnt", "3");	//표출갯수
		List<?> trndList = mainService.selectNoticeList(map02);
		//데이터 : 평점순
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("popul", "point");
		map03.put("board_cnt", "5");	//표출갯수
		List<?> poinList = mainService.selectPopulList(map03);
		//데이터 : 조회순
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("popul", "count");
		map04.put("board_cnt", "5");	//표출갯수
		List<?> coutList = mainService.selectPopulList(map04);
		//데이터 : 최신자료
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("board_cnt", "5");	//표출갯수
		List<?> recnList = mainService.selectRecentList(map05);

		LOG.debug(" drvnoCnt["+drvnoCnt+"]");
		model.addAttribute("drvnoCnt", String.valueOf(drvnoCnt));
		model.addAttribute("distInfo", distInfo);
		model.addAttribute("dataTotCnt", dataTotCnt);
		model.addAttribute("dataTotVol", dataTotVol);
		model.addAttribute("notcList", notcList);
		model.addAttribute("trndList", trndList);
		model.addAttribute("poinList", poinList);
		model.addAttribute("coutList", coutList);
		model.addAttribute("recnList", recnList);
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "main/Main_Info.tiles"; 
	}
	
	/**
	 * 메인화면
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "main/Main"
	 * @exception Exception
	 */
	@RequestMapping(value = "/main/MainNew.do")
	public String homeMainTest(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Main.do ###########");
		LOG.debug("    user_id["+(String)session.getAttribute("user_id")+"]");

		//임시운행번호 총갯수
		int drvnoCnt = mainService.selectTempOperTotCnt(paramMap);
		//총주행거리
		Map<String, String> distInfo = mainService.selectDrivingInfo(paramMap);
		//데이터 건수
		int dataTotCnt = mainService.selectDataTotCnt(paramMap);
		//데이터 용량
		String dataTotVol = mainService.selectDataTotVolume(paramMap);
		//게시판 : 공지사항
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("blbd_div_cd", "101");
		map01.put("board_cnt", "1");	//표출갯수
		List<?> notcList = mainService.selectNoticeList(map01);
		//게시판 : 자율주행
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("blbd_div_cd", "102");
		map02.put("board_cnt", "3");	//표출갯수
		List<?> trndList = mainService.selectNoticeList(map02);
		//데이터 : 평점순
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("popul", "point");
		map03.put("board_cnt", "4");	//표출갯수
		List<?> poinList = mainService.selectPopulList(map03);
		//데이터 : 조회순
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("popul", "count");
		map04.put("board_cnt", "4");	//표출갯수
		List<?> coutList = mainService.selectPopulList(map04);
		//데이터 : 최신자료
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("board_cnt", "4");	//표출갯수
		List<?> recnList = mainService.selectRecentList(map05);

		LOG.debug(" drvnoCnt["+drvnoCnt+"]");
		model.addAttribute("drvnoCnt", String.valueOf(drvnoCnt));
		model.addAttribute("distInfo", distInfo);
		model.addAttribute("dataTotCnt", dataTotCnt);
		model.addAttribute("dataTotVol", dataTotVol);
		model.addAttribute("notcList", notcList);
		model.addAttribute("trndList", trndList);
		model.addAttribute("poinList", poinList);
		model.addAttribute("coutList", coutList);
		model.addAttribute("recnList", recnList);
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "/main/Main_New"; 
	}	
	
	/**
	 * 메인화면
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "main/Main"
	 * @exception Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/main/Main_SP5.do")
	public ModelAndView homeMainSP5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		
		int port = request.getRemotePort();
		
		
//		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		/*ModelAndView mav = new ModelAndView("redirect:http://127.0.0.1:8082/websquare/websquare.html?w2xPath=/sp5_ui/US_MA_01.xml");
		mav.setViewName("redirect:http://127.0.0.1:8082/websquare/websquare.html?w2xPath=/sp5_ui/US_MA_01.xml");*/
		
		ModelAndView mav = new ModelAndView("redirect:https://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/US_MA_01.xml");
		mav.setViewName("redirects:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/US_MA_01.xml");
		
		Map<String, Object> map = new HashMap<>();
//		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Main.do ###########");
		LOG.debug("    user_id["+(String)session.getAttribute("user_id")+"]");
		
		//임시운행번호 총갯수
		int drvnoCnt = mainService.selectTempOperTotCnt(paramMap);
		//총주행거리
		Map<String, String> distInfo = mainService.selectDrivingInfo(paramMap);
		//데이터 건수
		int dataTotCnt = mainService.selectDataTotCnt(paramMap);
		//데이터 용량
		String dataTotVol = mainService.selectDataTotVolume(paramMap);
		//게시판 : 공지사항
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("blbd_div_cd", "101");
		map01.put("board_cnt", "1");	//표출갯수
		List<?> notcList = mainService.selectNoticeList(map01);
		//게시판 : 자율주행
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("blbd_div_cd", "102");
		map02.put("board_cnt", "3");	//표출갯수
		List<?> trndList = mainService.selectNoticeList(map02);
		//데이터 : 평점순
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("popul", "point");
		map03.put("board_cnt", "4");	//표출갯수
		List<?> poinList = mainService.selectPopulList(map03);
		//데이터 : 조회순
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("popul", "count");
		map04.put("board_cnt", "4");	//표출갯수
		List<?> coutList = mainService.selectPopulList(map04);
		//데이터 : 최신자료
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("board_cnt", "4");	//표출갯수
		List<?> recnList = mainService.selectRecentList(map05);
		
		LOG.debug(" drvnoCnt["+drvnoCnt+"]");
		model.addAttribute("drvnoCnt", String.valueOf(drvnoCnt));
		model.addAttribute("distInfo", distInfo);
		model.addAttribute("dataTotCnt", dataTotCnt);
		model.addAttribute("dataTotVol", dataTotVol);
		model.addAttribute("notcList", notcList);
		model.addAttribute("trndList", trndList);
		model.addAttribute("poinList", poinList);
		model.addAttribute("coutList", coutList);
		model.addAttribute("recnList", recnList);
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));
		
//		mav.addObject("map", map);
		mav.addObject("model", model);
		mav.addObject("paramMap", paramMap);
		map.put("data", mav);
		return mav;
	}	


	/**
	 * 로그아웃 프로세스
	 * @param model
	 * @return "main/Main_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "/account/Logout_Process.do")
	public String logoutProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,  HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);

		String result = "1"; //결과

		LOG.debug(" ########## Logout_Process.do ###########");
		LOG.debug("   SSO_ID["+(String)session.getAttribute("SSO_ID")+"]");
		LOG.debug(" SSO_NAME["+(String)session.getAttribute("SSO_NAME")+"]");
		LOG.debug("    EMAIL["+(String)session.getAttribute("EMAIL")+"]");
		LOG.debug("  UPDT_IP["+(String)session.getAttribute("UPDT_IP")+"]");

		String SSO_ID = (String)session.getAttribute("user_id");
		String SSO_NAME = (String)session.getAttribute("SSO_NAME");
		String EMAIL = (String)session.getAttribute("EMAIL");
		String UPDT_IP = (String)session.getAttribute("LAST_UPDT_IP");

		if(SSO_ID != null && !SSO_ID.equals("") ) {
			try {
				paramMap.put("userId", SSO_ID);
				paramMap.put("logId", SSO_ID);
				paramMap.put("conectMthd", "102");
				paramMap.put("connectIp", UPDT_IP);
				paramMap.put("errOccrrAt", "N");

				//로그 등록
				mainService.insertConnnectLog(paramMap);
			} catch (RuntimeException e) {
				LOG.info("[DB Exception] 홈페이지 로그아웃 등록 실패 : "+e.toString());
				result = "0";
			}
		}
		session.invalidate(); //세션 제거
		model.addAttribute("result_insert", result);

		return "common/Logout_Process";
	}

	/**
	 * 이용안내- 데이터공유센터소개
	 * @param model
	 * @return "Gude_Avsc_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Avsc_View.do")
	public String avscView(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		String agcy_nm = (String) session.getAttribute("agcy_nm");
	    String agcy_id = (String) session.getAttribute("agcy_id");
	    String user_nm = (String) session.getAttribute("user_nm");
	    //이용안내 내용 잠시 주석
		Map<String, Object> map = viseService.selectContectInfo();  
		model.addAttribute("map", map);
		
		return "guide/Gude_Avsc_View.jsp";
	}
	
	/**
	 * 이용안내- 데이터공유센터소개
	 * @param model
	 * @return "Gude_Avsc_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Avsc_View_sp5.do")
	public String avscView_sp5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, RedirectAttributes rttr, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		try {  
		    /*String sessionA = (String) session.getAttribute("agcy_nm");
		    String agcy_nm = URLEncoder.encode(Util.isNull(sessionA), "UTF-8");
		    String sessionB = (String) session.getAttribute("agcy_id");
		    String agcy_id = URLEncoder.encode(Util.isNull(sessionB), "UTF-8");
		    String sessionC = (String) session.getAttribute("user_nm");
		    String user_nm = URLEncoder.encode(Util.isNull(sessionC), "UTF-8");
		    
		    rttr.addAttribute("agcy_nm", agcy_nm); 
		    rttr.addAttribute("agcy_id", agcy_id); 
		    rttr.addAttribute("user_nm", user_nm); 
			
			rttr.addAttribute("user_id", session.getAttribute("user_id")); 
			rttr.addAttribute("auth_id", session.getAttribute("auth_id")); 
			rttr.addAttribute("grad_id", session.getAttribute("grad_id"));
			
			//이용안내 내용 잠시 주석
			List<Map<String, Object>> listMap = (List<Map<String, Object>>) viseService.selectContectInfo(paramMap);  
			
			String a = (String) listMap.get(0).get("title");
			String title = URLEncoder.encode(a, "UTF-8");
			String b = (String) listMap.get(0).get("content");
			String content = URLEncoder.encode(b, "UTF-8");
			String c = (String) listMap.get(0).get("telNo");
			String telNo = URLEncoder.encode(c, "UTF-8");
			String d = (String) listMap.get(0).get("faxNo");
			String faxNo = URLEncoder.encode(d, "UTF-8");
			String e = (String) listMap.get(0).get("email");
			String email = URLEncoder.encode(e, "UTF-8");
					
			rttr.addAttribute("content", content);
			rttr.addAttribute("telNo", telNo);
			rttr.addAttribute("faxNo", faxNo);
			rttr.addAttribute("email", email);*/
		
		}catch (NullPointerException e) {
			e.printStackTrace();
		}
		
    	return "redirect:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/sub/US_CE_01.xml";
	}
	
	/**
	 * 이용안내- 공공데이터개방
	 * @param model
	 * @return "Gude_Cits_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Cits_View.do")
	public String citsView(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		return "guide/Gude_Cits_View.jsp";
	}
	
	/**
	 * 이용안내- 공공데이터개방_sp5
	 * @param model
	 * @return "Gude_Cits_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Cits_View_sp5.do")
	public String citsView_sp5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		try{
	    String sessionA = (String) session.getAttribute("agcy_nm");
	    String agcy_nm = URLEncoder.encode(sessionA, "UTF-8");
	    String sessionB = (String) session.getAttribute("agcy_id");
	    String agcy_id = URLEncoder.encode(sessionB, "UTF-8");
	    String sessionC = (String) session.getAttribute("user_nm");
	    String user_nm = URLEncoder.encode(sessionC, "UTF-8");
	    
	    model.addAttribute("agcy_nm", agcy_nm); 
	    model.addAttribute("agcy_id", agcy_id); 
	    model.addAttribute("user_nm", user_nm); 
		model.addAttribute("uriModel", uriModel);
		model.addAttribute("user_id", session.getAttribute("user_id")); 
		model.addAttribute("auth_id", session.getAttribute("auth_id")); 
		model.addAttribute("grad_id", session.getAttribute("grad_id"));
	}catch (NullPointerException e) {
		e.printStackTrace();
	}
		return "redirect:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/sub/US_CE_02.xml";
	}

	/**
	 * 이용안내- 데이터공유협의체
	 * @param model
	 * @return "Gude_Cons_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Cons_View.do")
	public String consView(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		Map<String, String> attachFile = mainService.selectAttachFileList();
		model.addAttribute("attachFile", attachFile);
		return "guide/Gude_Cons_View.jsp";
	}
	
	/**
	 * 이용안내- 데이터공유협의체_sp5
	 * @param model
	 * @return "Gude_Cons_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Cons_View_sp5.do")
	public String consView_sp5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		try{
		    String sessionA = (String) session.getAttribute("agcy_nm");
		    String agcy_nm = URLEncoder.encode(sessionA, "UTF-8");
		    String sessionB = (String) session.getAttribute("agcy_id");
		    String agcy_id = URLEncoder.encode(sessionB, "UTF-8");
		    String sessionC = (String) session.getAttribute("user_nm");
		    String user_nm = URLEncoder.encode(sessionC, "UTF-8");
		    
		    model.addAttribute("agcy_nm", agcy_nm); 
		    model.addAttribute("agcy_id", agcy_id); 
		    model.addAttribute("user_nm", user_nm); 
			model.addAttribute("uriModel", uriModel);
			model.addAttribute("user_id", session.getAttribute("user_id")); 
			model.addAttribute("auth_id", session.getAttribute("auth_id")); 
			model.addAttribute("grad_id", session.getAttribute("grad_id"));
		}catch (NullPointerException e) {
			e.printStackTrace();
		}

		return "redirect:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/sub/US_CE_03.xml";
	}

	/**
	 * 이용안내- 법령 및 지침
	 * @param model
	 * @return "Gude_Legl_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Legl_View.do")
	public String leglView(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		return "guide/Gude_Legl_View.tiles";
	}
	
	/**
	 * 이용안내- 법령 및 지침_sp5
	 * @param model
	 * @return "Gude_Legl_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Legl_View_sp5.do")
	public String leglView_sp5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		try{
		    String sessionA = (String) session.getAttribute("agcy_nm");
		    String agcy_nm = URLEncoder.encode(sessionA, "UTF-8");
		    String sessionB = (String) session.getAttribute("agcy_id");
		    String agcy_id = URLEncoder.encode(sessionB, "UTF-8");
		    String sessionC = (String) session.getAttribute("user_nm");
		    String user_nm = URLEncoder.encode(sessionC, "UTF-8");
		    
		    model.addAttribute("agcy_nm", agcy_nm); 
		    model.addAttribute("agcy_id", agcy_id); 
		    model.addAttribute("user_nm", user_nm); 
			model.addAttribute("uriModel", uriModel);
			model.addAttribute("user_id", session.getAttribute("user_id")); 
			model.addAttribute("auth_id", session.getAttribute("auth_id")); 
			model.addAttribute("grad_id", session.getAttribute("grad_id"));
		}catch (NullPointerException e) {
			e.printStackTrace();
		}

		return "redirect:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/sub/US_CE_04.xml";
	}

	/**
	 * 이용안내- 운행보고 안내
	 * @param model
	 * @return "Gude_Rept_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Rept_View.do")
	public String drvgView(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		return "guide/Gude_Rept_View.jsp";
	}
	
	/**
	 * 이용안내- 운행보고 안내_sp5
	 * @param model
	 * @return "Gude_Rept_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "/center/introduce/Gude_Rept_View_sp5.do")
	public String drvgView_sp5(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		try{
		    String sessionA = (String) session.getAttribute("agcy_nm");
		    String agcy_nm = URLEncoder.encode(sessionA, "UTF-8");
		    String sessionB = (String) session.getAttribute("agcy_id");
		    String agcy_id = URLEncoder.encode(sessionB, "UTF-8");
		    String sessionC = (String) session.getAttribute("user_nm");
		    String user_nm = URLEncoder.encode(sessionC, "UTF-8");
		    
		    model.addAttribute("agcy_nm", agcy_nm); 
		    model.addAttribute("agcy_id", agcy_id); 
		    model.addAttribute("user_nm", user_nm); 
			model.addAttribute("uriModel", uriModel);
			model.addAttribute("user_id", session.getAttribute("user_id")); 
			model.addAttribute("auth_id", session.getAttribute("auth_id")); 
			model.addAttribute("grad_id", session.getAttribute("grad_id"));
		}catch (NullPointerException e) {
			e.printStackTrace();
		}

		return "redirect:http://localhost:8081/websquare/websquare.html?w2xPath=/sp5_ui/sub/US_CE_05.xml";
	}

	/**
	 * 홈페이지 접속로그 등록 처리
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "/main/Connect_Log_Process.do")
	public String connectLogProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

		String result = "1"; //결과

		LOG.debug(" ########## Connect_Log_Process.do ###########");
		LOG.debug("     SSO_ID["+(String)session.getAttribute("SSO_ID")+"]");
		LOG.debug("   SSO_NAME["+(String)session.getAttribute("SSO_NAME")+"]");
		LOG.debug(" CHARGER_NM["+(String)session.getAttribute("CHARGER_NM")+"]");
		LOG.debug("      EMAIL["+(String)session.getAttribute("EMAIL")+"]");
		LOG.debug("    UPDT_IP["+(String)session.getAttribute("UPDT_IP")+"]");

		String SSO_ID = (String)session.getAttribute("SSO_ID");
		String SSO_NAME = (String)session.getAttribute("SSO_NAME");
		String EMAIL = (String)session.getAttribute("EMAIL");
		String UPDT_IP = (String)session.getAttribute("LAST_UPDT_IP");

		if(SSO_ID != null && !SSO_ID.equals("") ) {
			//sso name 확인
			if(SSO_NAME == null || SSO_NAME.equals("")) {
				SSO_NAME = (String)session.getAttribute("CHARGER_NM");
			}
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("user_id", SSO_ID);
			Map<String, String> userInfo = viseService.selectRightsInfo(map01);
			LOG.debug("   userInfo["+userInfo+"]");
			String auth_cd = "";
			String agency_cd = "";
			String agency_nm = "";
			String class_id = "";
			if(userInfo != null) {
				auth_cd = Util.nvl(userInfo.get("authCd"));
				agency_cd = Util.nvl(userInfo.get("agencyCd"));
				agency_nm = Util.nvl(userInfo.get("agencyNm"));
				class_id = Util.nvl(userInfo.get("classId"));
			}
			LOG.debug("   auth_cd["+auth_cd+"]");
			LOG.debug(" agency_cd["+agency_cd+"]");
			LOG.debug(" agency_nm["+agency_nm+"]");
			LOG.debug("  class_id["+class_id+"]");

			session.setAttribute("user_id", SSO_ID);
			session.setAttribute("user_nm", SSO_NAME);
			session.setAttribute("agcy_id", agency_cd);
			session.setAttribute("agcy_nm", agency_nm);
			session.setAttribute("auth_id", auth_cd);    //일반:101, 협의체:102, 관리자:103, 임시운행:104, 임시운행+협의체:105
			session.setAttribute("grad_id", class_id);    //일반:101, 고급:102

			try {
				paramMap.put("userId", SSO_ID);
				paramMap.put("logId", SSO_ID);
				paramMap.put("conectMthd", "101");
				paramMap.put("connectIp", UPDT_IP);
				paramMap.put("errOccrrAt", "N");

				//로그 등록
				mainService.insertConnnectLog(paramMap);
			} catch (RuntimeException e) {
				LOG.info("[DB Exception] 홈페이지 접속로그 등록 실패 : ");
				result = "0";
			}

			model.addAttribute("result_insert", result);
		}

		return "redirect:/main/Main.do"; 
	}















	/**
	 * 임시 셋팅
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "main/Main"
	 * @exception Exception
	 */
	@RequestMapping(value = "/login_proc.do")
	public String login_proc(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## login_proc.do ###########");
		LOG.debug(" user_id["+paramMap.get("user_id")+"]");
		LOG.debug(" user_nm["+paramMap.get("user_nm")+"]");
		LOG.debug(" agcy_id["+paramMap.get("agcy_id")+"]");
		LOG.debug(" agcy_nm["+paramMap.get("agcy_nm")+"]");
		LOG.debug(" auth_id["+paramMap.get("auth_id")+"]");
		LOG.debug(" grad_id["+paramMap.get("grad_id")+"]");

		session.setAttribute("user_id", paramMap.get("user_id"));
		session.setAttribute("user_nm", paramMap.get("user_nm"));
		session.setAttribute("agcy_id", paramMap.get("agcy_id"));
		session.setAttribute("agcy_nm", paramMap.get("agcy_nm"));
		session.setAttribute("auth_id", paramMap.get("auth_id"));    //일반:101, 협의체:102, 관리자:103, 임시운행:104, 임시운행+협의체:105
		session.setAttribute("grad_id", paramMap.get("grad_id"));    //일반:101, 고급:102

		//임시운행번호 총갯수
		int drvnoCnt = mainService.selectTempOperTotCnt(paramMap);
		//총주행거리
		Map<String, String> distInfo = mainService.selectDrivingInfo(paramMap);
		//데이터 건수
		int dataTotCnt = mainService.selectDataTotCnt(paramMap);
		//데이터 용량
		String dataTotVol = mainService.selectDataTotVolume(paramMap);
		//게시판 : 공지사항
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("blbd_div_cd", "101");
		map01.put("board_cnt", "1");	//표출갯수
		List<?> notcList = mainService.selectNoticeList(map01);
		//게시판 : 자율주행
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("blbd_div_cd", "102");
		map02.put("board_cnt", "3");	//표출갯수
		List<?> trndList = mainService.selectNoticeList(map02);
		//데이터 : 평점순
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("popul", "point");
		map03.put("board_cnt", "4");	//표출갯수
		List<?> poinList = mainService.selectPopulList(map03);
		//데이터 : 조회순
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("popul", "point");
		map04.put("board_cnt", "4");	//표출갯수
		List<?> coutList = mainService.selectPopulList(map04);
		//데이터 : 최신자료
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("board_cnt", "4");	//표출갯수
		List<?> recnList = mainService.selectRecentList(map05);

		LOG.debug(" drvnoCnt["+drvnoCnt+"]");
		model.addAttribute("drvnoCnt", String.valueOf(drvnoCnt));
		model.addAttribute("distInfo", distInfo);
		model.addAttribute("dataTotCnt", dataTotCnt);
		model.addAttribute("dataTotVol", dataTotVol);
		model.addAttribute("notcList", notcList);
		model.addAttribute("trndList", trndList);
		model.addAttribute("poinList", poinList);
		model.addAttribute("coutList", coutList);
		model.addAttribute("recnList", recnList);

		return "main/Main_Info.tiles"; 
	}



}
