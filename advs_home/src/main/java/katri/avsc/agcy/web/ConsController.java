package katri.avsc.agcy.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.agcy.service.ConsService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * 협의체데이터 > 기관
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/agency/consultative")
public class ConsController {

	/** consService */
	@Resource(name = "consService")
	ConsService consService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(ConsController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * 협의체 메인 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Cons_Main"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Cons_Main.do")
	public String selectConsMain(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Cons_Main.do ###########");
		LOG.debug("     search["+paramMap.get("search")+"]");
		LOG.debug(" searchBseq["+paramMap.get("searchBseq")+"]");
		LOG.debug(" searchMode["+paramMap.get("searchMode")+"]");
		LOG.debug(" searchWeth["+paramMap.get("searchWeth")+"]");
		LOG.debug(" searchSitu["+paramMap.get("searchSitu")+"]");
		LOG.debug(" searchRoad["+paramMap.get("searchRoad")+"]");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug(" searchBdwr["+paramMap.get("searchBdwr")+"]");
		LOG.debug(" searchDetl["+paramMap.get("searchDetl")+"]");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* 크로스사이트 체크 : S */
		String search = paramMap.get("search");
		search = Util.injectionCheck(search);
		paramMap.put("search", search);
		String searchBseq = paramMap.get("searchBseq");
		searchBseq = Util.injectionCheck(searchBseq);
		paramMap.put("searchBseq", searchBseq);
		String searchMode = paramMap.get("searchMode");
		searchMode = Util.injectionCheck(searchMode);
		paramMap.put("searchMode", searchMode);
		String searchWeth = paramMap.get("searchWeth");
		searchWeth = Util.injectionCheck(searchWeth);
		paramMap.put("searchWeth", searchWeth);
		String searchSitu = paramMap.get("searchSitu");
		searchSitu = Util.injectionCheck(searchSitu);
		paramMap.put("searchSitu", searchSitu);
		String searchRoad = paramMap.get("searchRoad");
		searchRoad = Util.injectionCheck(searchRoad);
		paramMap.put("searchRoad", searchRoad);
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		String searchBdwr = paramMap.get("searchBdwr");
		searchBdwr = Util.injectionCheck(searchBdwr);
		paramMap.put("searchBdwr", searchBdwr);
		String searchDetl = paramMap.get("searchDetl");
		searchDetl = Util.injectionCheck(searchDetl);
		paramMap.put("searchDetl", searchDetl);
		/* 크로스사이트 체크 : E */
		
		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = "";

		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);
		paramMap.put("user_id", (String)session.getAttribute("user_id"));

		int user_chk = 1;

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("bbs_group_seq", "2000");
		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_dataset = consService.selectDtupDataSetList(map05);
		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_dataset", code_dataset);

		model.addAttribute("bbs_seq", bbs_seq);
		model.addAttribute("user_chk", user_chk);
		model.addAttribute("search", paramMap.get("search"));
		model.addAttribute("searchBseq", paramMap.get("searchBseq"));
		model.addAttribute("searchMode", paramMap.get("searchMode"));
		model.addAttribute("searchWeth", paramMap.get("searchWeth"));
		model.addAttribute("searchSitu", paramMap.get("searchSitu"));
		model.addAttribute("searchRoad", paramMap.get("searchRoad"));
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("searchBdwr", paramMap.get("searchBdwr"));
		model.addAttribute("searchDetl", paramMap.get("searchDetl"));

		return "agency/Agcy_Cons_Main.tiles";
	}

	/**
	 * 목록을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Cons_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Cons_List.do")
	public String selectConsList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Cons_List.do ###########");
		LOG.debug("     search["+paramMap.get("search")+"]");
		LOG.debug(" searchBseq["+paramMap.get("searchBseq1")+"]");
		LOG.debug(" searchMode["+paramMap.get("searchMode1")+"]");
		LOG.debug(" searchWeth["+paramMap.get("searchWeth1")+"]");
		LOG.debug(" searchSitu["+paramMap.get("searchSitu1")+"]");
		LOG.debug(" searchRoad["+paramMap.get("searchRoad1")+"]");
		LOG.debug(" searchType["+paramMap.get("searchType1")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord1")+"]");
		LOG.debug(" searchBdwr["+paramMap.get("searchBdwr1")+"]");
		LOG.debug(" searchDetl["+paramMap.get("searchDetl")+"]");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* 크로스사이트 체크 : S */
		String search = paramMap.get("search");
		search = Util.injectionCheck(search);
		paramMap.put("search", search);
		String searchBseq = paramMap.get("searchBseq1");
		searchBseq = Util.injectionCheck(searchBseq);
		paramMap.put("searchBseq", searchBseq);
		String searchMode = paramMap.get("searchMode1");
		searchMode = Util.injectionCheck(searchMode);
		paramMap.put("searchMode", searchMode);
		String searchWeth = paramMap.get("searchWeth1");
		searchWeth = Util.injectionCheck(searchWeth);
		paramMap.put("searchWeth", searchWeth);
		String searchSitu = paramMap.get("searchSitu11");
		searchSitu = Util.injectionCheck(searchSitu);
		paramMap.put("searchSitu", searchSitu);
		String searchRoad = paramMap.get("searchRoad1");
		searchRoad = Util.injectionCheck(searchRoad);
		paramMap.put("searchRoad", searchRoad);
		String searchType = paramMap.get("searchType1");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord1");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		String searchBdwr = paramMap.get("searchBdwr1");
		searchBdwr = Util.injectionCheck(searchBdwr);
		paramMap.put("searchBdwr", searchBdwr);
		String searchDetl = paramMap.get("searchDetl1");
		searchDetl = Util.injectionCheck(searchDetl);
		paramMap.put("searchDetl", searchDetl);
		String bbs_seq = paramMap.get("bbs_seq");
		bbs_seq = Util.injectionCheck(bbs_seq);
		paramMap.put("bbs_seq", bbs_seq);
		/* 크로스사이트 체크 : E */

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

//		String bbs_seq = paramMap.get("bbs_seq");
		/** pageing setting */
		PageSetting pageSetting = new PageSetting(); //페이지 클래스
		iPageNo = Util.setCurrentPage(paramMap.get("iPageNo"));
		pageSetting.setCurrentPageNo(iPageNo); //현재 페이지  
		pageSetting.setRecordCountPerPage(propertiesService.getInt("pageUnit")); //한페이지에 나열될 목록의 수
		pageSetting.setPageSize(propertiesService.getInt("pageSize")); //표출될 블럭 수
		
		paramMap.put("iPageNo", Integer.toString(iPageNo));//한페이지에 나열될 목록의 수
		paramMap.put("firstIndex", Integer.toString(pageSetting.getFirstRecordIndex()));//현재 페이지 블록에서 처음 페이지
		paramMap.put("lastIndex", Integer.toString(pageSetting.getLastRecordIndex()));//현재 페이지 블록에서 마지막 페이지
		paramMap.put("recordCountPerPage", Integer.toString(pageSetting.getRecordCountPerPage()));//한페이지에 나열될 목록의 수

		//paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id

		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);
		paramMap.put("bbs_group_seq", "2000");
		paramMap.put("user_id", (String)session.getAttribute("user_id"));

		List<?> consList = consService.selectConsList(paramMap);
		model.addAttribute("resultList", consList);
		
		List<Map<String, Object>> listmap = (List<Map<String, Object>>) consList;
		if(!listmap.isEmpty()) {
			model.addAttribute("dataTypeView", listmap.get(0).get("dataTypeView"));
		}
		
		int totCnt = consService.selectConsListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		int user_chk = 1;

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("bbs_group_seq", "2000");
		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_dataset = consService.selectDtupDataSetList(map05);
		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_dataset", code_dataset);

		model.addAttribute("bbs_seq", bbs_seq);
		model.addAttribute("user_chk", user_chk);
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("search", paramMap.get("search"));
		model.addAttribute("searchBseq", paramMap.get("searchBseq"));
		model.addAttribute("searchMode", paramMap.get("searchMode"));
		model.addAttribute("searchWeth", paramMap.get("searchWeth"));
		model.addAttribute("searchSitu", paramMap.get("searchSitu"));
		model.addAttribute("searchRoad", paramMap.get("searchRoad"));
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("searchBdwr", paramMap.get("searchBdwr"));
		model.addAttribute("searchDetl", paramMap.get("searchDetl"));

		return "agency/Agcy_Cons_List.tiles";
	}

	/**
	 * 기관 데이터셋 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Dset_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_List.do")
	public String selectConsDsetList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Dset_List.do ###########");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* 크로스사이트 체크 : S */
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord1");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord１", searchWord);
		/* 크로스사이트 체크 : E */

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);
		//paramMap.put("user_id", (String)session.getAttribute("user_id"));

		/** pageing setting */
		PageSetting pageSetting = new PageSetting(); //페이지 클래스
		iPageNo = Util.setCurrentPage(paramMap.get("iPageNo"));
		pageSetting.setCurrentPageNo(iPageNo); //현재 페이지  
		pageSetting.setRecordCountPerPage(propertiesService.getInt("pageUnit")); //한페이지에 나열될 목록의 수
		pageSetting.setPageSize(propertiesService.getInt("pageSize")); //표출될 블럭 수
		
		paramMap.put("iPageNo", Integer.toString(iPageNo));//한페이지에 나열될 목록의 수
    	paramMap.put("firstIndex", Integer.toString(pageSetting.getFirstRecordIndex()));//현재 페이지 블록에서 처음 페이지
    	paramMap.put("lastIndex", Integer.toString(pageSetting.getLastRecordIndex()));//현재 페이지 블록에서 마지막 페이지
    	paramMap.put("recordCountPerPage", Integer.toString(pageSetting.getRecordCountPerPage()));//한페이지에 나열될 목록의 수

    	paramMap.put("bbs_group_seq", "2000");
		List<?> dsetList = consService.selectDataSetList(paramMap);
		model.addAttribute("resultList", dsetList);
		
		int totCnt = consService.selectDataSetListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		int user_chk = 1;

		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("user_chk", user_chk);
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));

		return "agency/Agcy_Dset_List.tiles";
	}	

	/**
	 * 기관 데이터셋 상세
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Dset_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Info.do")
	public String selectConsDsetInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Dset_Info.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);
		paramMap.put("user_id", (String)session.getAttribute("user_id"));

		Map<String, String> dsetInfo = consService.selectDataSetInfo(paramMap);
		int user_chk = 1;

		model.addAttribute("dsetInfo", dsetInfo);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "agency/Agcy_Dset_Info.tiles";
	}

	/**
	 * 기관 데이터셋 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Dset_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Inst.do")
	public String consDsetInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Agcy_Dset_Inst.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("     reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);

		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		return "agency/Agcy_Dset_Inst.tiles";
	}


	/**
	 * 기관 데이터셋 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Inst_Process.do")
	public String consDsetInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "dset" + pathLetter;

		LOG.debug(" ########## Agcy_Dset_Inst_Process.do ###########");
		LOG.debug("       bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_ttl_nm["+paramMap.get("bdwr_ttl_nm")+"]");
		LOG.debug("      bdwr_cts["+paramMap.get("bdwr_cts")+"]");
		LOG.debug("     data_form["+paramMap.get("data_form")+"]");
		LOG.debug("        reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bdwr_seq = consService.sequenceBdwrSeq(paramMap);

		//첨부파일 처리
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		/* 파일 확장자 체크 : S */
		boolean bExt = Util.fileExtCheck(files.get("file_info").getOriginalFilename());
		if(!files.get("file_info").isEmpty() && !bExt) {
			model.addAttribute("result_insert", "ext");
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			return "agency/Agcy_Dset_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("file_info").isEmpty() && bExt){
			newFileNM = bdwr_seq + "_";
			paramMap.put("file_size", String.valueOf(files.get("file_info").getSize()));
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), pathUpload, newFileNM);
			paramMap.put("attach_filename", file_name);
		}else{
			paramMap.put("attach_filename", "");
			paramMap.put("file_size", "");
		}

		try{
			//등록
			paramMap.put("bdwr_seq", bdwr_seq);
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			consService.insertDataSet(paramMap);

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 등록 실패 : "+e.toString());
			result = "0";
		}
		
		model.addAttribute("result_insert", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		return "agency/Agcy_Dset_Process";
	}

	/**
	 * 기관 데이터셋 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Delt_Process.do")
	public String consDsetDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		int result = 1; //결과

		LOG.debug(" ########## Agcy_Dset_Delt_Process.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		result = consService.updateBoardDelt(paramMap);
		if(result > -1) result = consService.deleteDataSet(paramMap);
		else result = -1;

		LOG.debug(" result["+result+"]");
		
		model.addAttribute("result_delete", result);
		
		return "agency/Agcy_Dset_Process";
	} 

	/**
	 * 기관 데이터셋 수정화면
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Dset_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Updt.do")
	public String consDsetUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Dset_Updt.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "2000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if(bbs_seq == null || bbs_seq.equals("")) {
			if(bbs_list != null) {
				EgovMap egovMap = (EgovMap)bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);

		Map<String, String> dsetInfo = consService.selectDataSetInfo(paramMap);

		model.addAttribute("dsetInfo", dsetInfo);
		model.addAttribute("bbs_seq", bbs_seq);
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));

		return "agency/Agcy_Dset_Updt.tiles";
	}

	/**
	 * 기관 데이터셋 수정 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dset_Updt_Process.do")
	public String consDsetUpdateProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "dset" + pathLetter;

		LOG.debug(" ########## Agcy_Dset_Updt_Process.do ###########");
		LOG.debug("       bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("      bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		LOG.debug("   bdwr_ttl_nm["+paramMap.get("bdwr_ttl_nm")+"]");
		LOG.debug("      bdwr_cts["+paramMap.get("bdwr_cts")+"]");
		LOG.debug("     data_form["+paramMap.get("data_form")+"]");
		LOG.debug("        reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "agcy");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		//첨부파일 처리
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		/* 파일 확장자 체크 : S */
		boolean bExt = Util.fileExtCheck(files.get("file_info").getOriginalFilename());
		if(!files.get("file_info").isEmpty() && !bExt) {
			model.addAttribute("result_update", "ext");
			return "agency/Agcy_Dset_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("file_info").isEmpty() && bExt){
			newFileNM = paramMap.get("bdwr_seq") + "_";
			paramMap.put("file_size", String.valueOf(files.get("file_info").getSize()));
			String file_name = FileUtil.transferUploadFileNew(files.get("file_info"), pathUpload, newFileNM);
			paramMap.put("attach_filename", file_name);
			paramMap.put("file_yn", "Y");
		}else{
			paramMap.put("attach_filename", "");
			paramMap.put("file_size", "");
		}

		try{
			//등록
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			consService.updateDataSet(paramMap);

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 수정 실패 : "+e.toString());
			result = "0";
		}
		
		model.addAttribute("result_update", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));

		return "agency/Agcy_Dset_Process";
	}

	/**
	 * 데이터 다운로드 요청 팝업
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Agcy_Dtdw_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dtdw_Popup.do")
	public String dtdwPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Agcy_Dtdw_Popup.do ###########");
		try{
			Map<String, String> consInfo = consService.selectConsInfo(paramMap);

			model.addAttribute("consInfo", consInfo);
			model.addAttribute("b_seq", paramMap.get("b_seq"));
			
		} catch (Exception e) {
			LOG.info("[DB Exception] Agcy_Dtdw_Popup : " + e.toString());
		}


		return "agency/Agcy_Dtdw_Popup";
	}

	/**
	 * 데이터 다운로드 요청 처리
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Agcy_Dtdw_Send_Process.do")
	public String dtdwSendProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

		String result = "1"; //결과

		String mailHost = propertiesService.getString("mailHost");	//smtp host
		String mailPort = propertiesService.getString("mailPort");	//smtp port
		String mailUser = propertiesService.getString("mailUser");	//전송메일 계정
		String mailPwrd = propertiesService.getString("mailPwrd");
		String mailAdmn = propertiesService.getString("mailAdmn");	//담당자 메일

		LOG.debug(" ########## Agcy_Dtdw_Send_Process.do ###########");
		LOG.debug("     b_seq["+paramMap.get("b_seq")+"]");
		LOG.debug("       use["+paramMap.get("use")+"]");
		LOG.debug("     email["+paramMap.get("email")+"]");
		LOG.debug(" data_type["+paramMap.get("data_type")+"]");
		LOG.debug("   b_title["+paramMap.get("b_title")+"]");
		LOG.debug("   user_id["+session.getAttribute("user_id")+"]");

		try{
			//관리자 자동 메일
			String subject = "승인요청 : 협의체 데이터 사용 요청";
			String text = "[협의체 데이터 사용 요청이 접수되었습니다.] \n\n"
						+ "* 데이터번호 : " + paramMap.get("b_seq") + "\n\n"
						+ "* 데이터유형 : " + paramMap.get("data_type") + "\n\n"
						+ "* 데이터 명 : " + paramMap.get("b_title") + "\n\n"
						+ "* 사용목적 : " + paramMap.get("use") + "\n\n"
						+ "* E-Mail : " + paramMap.get("email") + "\n\n"
						+ "* 요청사용자 : " + session.getAttribute("user_id");
			//Mail.mailSend(mailHost, mailPort, mailUser, mailPwrd, mailAdmn, subject, text);

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터 다운로드 요청 실패 : " + e.toString());
			result = "0";
		}
		
		model.addAttribute("result_insert", result);
		
		return "agency/Agcy_Dtdw_Process";
	}

}
