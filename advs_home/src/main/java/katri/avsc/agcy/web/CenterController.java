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
@RequestMapping(value = "/center/share")
public class CenterController {

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
	 * @return "Center_Share_Main"
	 * @exception Exception
	 */
	@RequestMapping(value = "Center_Share_Main.do")
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

		return "center/Center_Share_Main.tiles";
	}

	/**
	 * 목록을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Center_Share_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Center_Share_List.do")
	public String selectConsList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Agcy_Cons_List.do ###########");
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

		return "center/Center_Share_List.tiles";
	}
	
	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Center_Share_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Center_Share_Info.do")
	public String incdInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Incd_Info.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" acc_id["+paramMap.get("acc_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("acc_id", paramMap.get("acc_id"));
		
		return "center/Center_Share_Info.tiles";
	}
	
	/**
	 * 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Center_Share_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Center_Share_Inst.do")
	public String incdInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Incd_Inst.do ###########");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("codeid", "autocar_driving_status_cd");
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("codeid", "autocar_damage");
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "autocar_human_sex");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "acccar_car_type");
		Map<String, String> map09 = new HashMap<String, String>();
		map09.put("codeid", "acccar_driving_mode");
		Map<String, String> map10 = new HashMap<String, String>();
		map10.put("codeid", "acccar_driving_status_cd");
		Map<String, String> map11 = new HashMap<String, String>();
		map11.put("codeid", "acccar_damage");
		Map<String, String> map12 = new HashMap<String, String>();
		map12.put("codeid", "acccar_human_sex");
		Map<String, String> map13 = new HashMap<String, String>();
		map13.put("codeid", "file_type");
		Map<String, String> map14 = new HashMap<String, String>();
		map14.put("codeid", "human_injury_type");
		Map<String, String> map15 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map15.put("userid", "");
		} else {
			map15.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_driving_status_cd = codeService.selectSubCodeList(map05);
		List<?> code_damage = codeService.selectSubCodeList(map06);
		List<?> code_human_sex = codeService.selectSubCodeList(map07);
		List<?> code_car_type = codeService.selectSubCodeList(map08);
		List<?> code_driving_mode2 = codeService.selectSubCodeList(map09);
		List<?> code_driving_status_cd2 = codeService.selectSubCodeList(map10);
		List<?> code_damage2 = codeService.selectSubCodeList(map11);
		List<?> code_human_sex2 = codeService.selectSubCodeList(map12);
		List<?> code_file_type = codeService.selectSubCodeList(map13);
		List<?> code_injury_type = codeService.selectSubCodeList(map14);
		List<?> code_tempoper = codeService.selectTempOperList(map15);

		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_driving_status_cd", code_driving_status_cd);
		model.addAttribute("code_damage", code_damage);
		model.addAttribute("code_human_sex", code_human_sex);
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_driving_mode2", code_driving_mode2);
		model.addAttribute("code_driving_status_cd2", code_driving_status_cd2);
		model.addAttribute("code_damage2", code_damage2);
		model.addAttribute("code_human_sex2", code_human_sex2);
		model.addAttribute("code_file_type", code_file_type);
		model.addAttribute("code_injury_type", code_injury_type);
		model.addAttribute("code_tempoper", code_tempoper);

		return "center/Center_Share_Inst.tiles";
	}


}
