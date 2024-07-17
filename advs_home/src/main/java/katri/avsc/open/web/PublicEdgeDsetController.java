package katri.avsc.open.web;

import java.io.File;
import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.open.service.PublicDsetService;
import katri.avsc.agcy.service.ConsService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DwhsService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;
import katri.avsc.open.service.CitsService;

/**
 * 공공데이터 > c-its
 * 
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/open/edge")
public class PublicEdgeDsetController {

	/** EgovSampleService */
	@Resource(name = "citsService")
	CitsService citsService;

	/** publicDsetService */
	@Resource(name = "publicDsetService")
	PublicDsetService publicDsetService;

	/** consService */
	@Resource(name = "consService")
	ConsService consService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;
	
	/** EgovSampleService */
	@Resource(name = "dwhsService")
	DwhsService dwhsService;

	private static final Log LOG = LogFactory.getLog(PublicEdgeDsetController.class.getName());

	/** EgovPropertyService */
	@Resource(name = "propertiesService") // 환경 설정
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Autowired
	private WebApplicationContext webApplicationContext;

	String scenarioCode1 = "ESK";
	String scenarioCode2 = "ESS";
	String scenarioCode3 = "ESDE";
	
	String pathLetter = "";
	String pathUpload = "";
	//String path_d = "D:\\eGovFrame\\src\\AVSC\\src\\main\\webapp\\upload\\cits\\"; // 협의체(개발)
	String path_d = "\\home\\app\\avds_web\\upload\\cits\\";
	/**
	 * 목록을 조회한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Edge_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_List.do")
	public String selectEdgeList(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		String rtnStr = ""; // 반환주소
		int iPageNo = 1; // 현재 페이지
		LOG.debug(" ########## Open_Edge_List.do ###########");
		LOG.debug("     search[" + paramMap.get("search") + "]");
		LOG.debug(" searchBseq[" + paramMap.get("searchBseq") + "]");
		LOG.debug(" searchMode[" + paramMap.get("searchMode") + "]");
		LOG.debug(" searchScenarioCode1[" + paramMap.get("searchScenarioCode1") + "]");
		LOG.debug(" searchScenarioCode2[" + paramMap.get("searchScenarioCode2") + "]");
		LOG.debug(" searchScenarioCode3[" + paramMap.get("searchScenarioCode3") + "]");
		LOG.debug(" searchType[" + paramMap.get("searchType") + "]");
		LOG.debug(" searchWord[" + paramMap.get("searchWord") + "]");
		LOG.debug(" searchBdwr[" + paramMap.get("searchBdwr") + "]");
		LOG.debug(" searchDetl[" + paramMap.get("searchDetl") + "]");
		LOG.debug("    bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("    user_id[" + (String) session.getAttribute("user_id") + "]");
		LOG.debug("    auth_id[" + (String) session.getAttribute("auth_id") + "]");

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
		String searchScenarioCode1 = paramMap.get("searchScenarioCode1");
		searchScenarioCode1 = Util.injectionCheck(searchScenarioCode1);
		paramMap.put("searchScenarioCode1", searchScenarioCode1);
		String searchScenarioCode2 = paramMap.get("searchScenarioCode2");
		searchScenarioCode2 = Util.injectionCheck(searchScenarioCode2);
		paramMap.put("searchScenarioCode2", searchScenarioCode2);
		String searchScenarioCode3 = paramMap.get("searchScenarioCode3");
		searchScenarioCode3 = Util.injectionCheck(searchScenarioCode3);
		paramMap.put("searchScenarioCode3", searchScenarioCode3);
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
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
//		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
//			model.addAttribute("rst_scrn", "cits");
//			model.addAttribute("rst_user", user_id);
//			model.addAttribute("rst_auth", auth_id);
//			return "common/Auth_Process";
//		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		
		//협의체 메뉴를 위한 분기처리
		if(bbs_seq.equals("2080") || bbs_seq.equals("2090") || bbs_seq.equals("2100")) {
		
		/** pageing setting */
		PageSetting pageSetting = new PageSetting(); // 페이지 클래스
		iPageNo = Util.setCurrentPage(paramMap.get("iPageNo"));
		pageSetting.setCurrentPageNo(iPageNo); // 현재 페이지
		pageSetting.setRecordCountPerPage(propertiesService.getInt("pageUnit")); // 한페이지에 나열될 목록의 수
		pageSetting.setPageSize(propertiesService.getInt("pageSize")); // 표출될 블럭 수

		paramMap.put("iPageNo", Integer.toString(iPageNo));// 한페이지에 나열될 목록의 수
		paramMap.put("firstIndex", Integer.toString(pageSetting.getFirstRecordIndex()));// 현재 페이지 블록에서 처음 페이지
		paramMap.put("lastIndex", Integer.toString(pageSetting.getLastRecordIndex()));// 현재 페이지 블록에서 마지막 페이지
		paramMap.put("recordCountPerPage", Integer.toString(pageSetting.getRecordCountPerPage()));// 한페이지에 나열될 목록의 수

		// paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id

		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "4000");
		List<?> bbs_list = codeService.selectBbsList(map_00);
		model.addAttribute("bbs_list", bbs_list);
		if (bbs_seq == null || bbs_seq.equals("")) {
			if (bbs_list != null) {
				EgovMap egovMap = (EgovMap) bbs_list.get(0);
				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
			}
		}
		paramMap.put("bbs_seq", bbs_seq);
		paramMap.put("bbs_group_seq", "2000");
		paramMap.put("user_id", (String) session.getAttribute("user_id"));
		
		paramMap.put("scenario_code1", scenarioCode1);
		paramMap.put("scenario_code2", scenarioCode2);
		paramMap.put("scenario_code3", scenarioCode3);

		List<?> edgeList = publicDsetService.selectPublicDsetList(paramMap);
		model.addAttribute("resultList", edgeList);

		int totCnt = publicDsetService.selectPublicDsetListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		int user_chk = 1;

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", scenarioCode1);
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", scenarioCode2);
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", scenarioCode3);
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("bbs_group_seq", "4000");
		
		List<?> scenario_code1 = codeService.selectSubCodeList(map01);
		List<?> scenario_code2 = codeService.selectSubCodeList(map02);
		List<?> scenario_code3 = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_dataset = consService.selectDtupDataSetList(map05);
		List<?> subCodeList = codeService.selectSubCodeChkList(paramMap);
		List<?> subCodeList2 = codeService.selectSubCodeChkList2(paramMap);
		
		model.addAttribute("scenario_code1", scenario_code1);
		model.addAttribute("scenario_code2", scenario_code2);
		model.addAttribute("scenario_code3", scenario_code3);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_dataset", code_dataset);

		model.addAttribute("bbs_seq", bbs_seq);
		model.addAttribute("user_chk", user_chk);
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("search", paramMap.get("search"));
		model.addAttribute("searchBseq", paramMap.get("searchBseq"));
		model.addAttribute("searchMode", paramMap.get("searchMode"));
		model.addAttribute("searchScenarioCode1", paramMap.get("searchScenarioCode1"));
		model.addAttribute("searchScenarioCode2", paramMap.get("searchScenarioCode2"));
		model.addAttribute("searchScenarioCode3", paramMap.get("searchScenarioCode3"));
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("searchBdwr", paramMap.get("searchBdwr"));
		model.addAttribute("searchDetl", paramMap.get("searchDetl"));
		model.addAttribute("subCodeList", subCodeList);
		model.addAttribute("subCodeList2", subCodeList2);

		rtnStr = "agency/Agcy_Edge_List.tiles";
		
		}else {
			
			/** pageing setting */
			PageSetting pageSetting = new PageSetting(); // 페이지 클래스
			iPageNo = Util.setCurrentPage(paramMap.get("iPageNo"));
			pageSetting.setCurrentPageNo(iPageNo); // 현재 페이지
			pageSetting.setRecordCountPerPage(propertiesService.getInt("pageUnit")); // 한페이지에 나열될 목록의 수
			pageSetting.setPageSize(propertiesService.getInt("pageSize")); // 표출될 블럭 수

			paramMap.put("iPageNo", Integer.toString(iPageNo));// 한페이지에 나열될 목록의 수
			paramMap.put("firstIndex", Integer.toString(pageSetting.getFirstRecordIndex()));// 현재 페이지 블록에서 처음 페이지
			paramMap.put("lastIndex", Integer.toString(pageSetting.getLastRecordIndex()));// 현재 페이지 블록에서 마지막 페이지
			paramMap.put("recordCountPerPage", Integer.toString(pageSetting.getRecordCountPerPage()));// 한페이지에 나열될 목록의 수

			// paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id

			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if (bbs_seq == null || bbs_seq.equals("")) {
				if (bbs_list != null) {
					EgovMap egovMap = (EgovMap) bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("bbs_group_seq", "3000");
			paramMap.put("user_id", (String) session.getAttribute("user_id"));
			
			paramMap.put("scenario_code1", scenarioCode1);
			paramMap.put("scenario_code2", scenarioCode2);
			paramMap.put("scenario_code3", scenarioCode3);

			List<?> edgeList = publicDsetService.selectPublicDsetList(paramMap);
			model.addAttribute("resultList", edgeList);

			int totCnt = publicDsetService.selectPublicDsetListTotCnt(paramMap);
			pageSetting.setTotalRecordCount(totCnt);

			int user_chk = 1;

			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");
			Map<String, String> map05 = new HashMap<String, String>();
			map05.put("bbs_group_seq", "4000");

			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			List<?> code_dataset = consService.selectDtupDataSetList(map05);
			List<?> subCodeList = codeService.selectSubCodeChkList(paramMap);
			List<?> subCodeList2 = codeService.selectSubCodeChkList2(paramMap);
			
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);
			model.addAttribute("code_dataset", code_dataset);

			model.addAttribute("bbs_seq", bbs_seq);
			model.addAttribute("user_chk", user_chk);
			model.addAttribute("pageSetting", pageSetting);
			model.addAttribute("search", paramMap.get("search"));
			model.addAttribute("searchBseq", paramMap.get("searchBseq"));
			model.addAttribute("searchMode", paramMap.get("searchMode"));
			model.addAttribute("searchScenarioCode1", paramMap.get("searchScenarioCode1"));
			model.addAttribute("searchScenarioCode2", paramMap.get("searchScenarioCode2"));
			model.addAttribute("searchScenarioCode3", paramMap.get("searchScenarioCode3"));
			model.addAttribute("searchType", paramMap.get("searchType"));
			model.addAttribute("searchWord", paramMap.get("searchWord"));
			model.addAttribute("searchBdwr", paramMap.get("searchBdwr"));
			model.addAttribute("searchDetl", paramMap.get("searchDetl"));
			
			model.addAttribute("subCodeList", subCodeList);
			model.addAttribute("subCodeList2", subCodeList2);

			rtnStr = "open/Open_Edge_List.tiles";
		}
		
		return rtnStr;
	}
	
	/**
	 * 공공 데이터셋 상세
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Edge_View"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_View.do")
	public String selectOpenEdgeView(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		String rtnStr = ""; // 반환주소
		int iPageNo = 1; // 현재 페이지
		LOG.debug(" ########## Open_Edge_View.do ###########");
		LOG.debug("    bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("   b_seq[" + paramMap.get("b_seq") + "]");
		LOG.debug("     userid[" + (String) session.getAttribute("user_id") + "]");
		LOG.debug("     authid[" + (String) session.getAttribute("auth_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		
		//협의체 메뉴를 위한 분기처리
		if(bbs_seq.equals("2080") || bbs_seq.equals("2090") || bbs_seq.equals("2100")) {
			
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if (bbs_seq == null || bbs_seq.equals("")) {
				if (bbs_list != null) {
					EgovMap egovMap = (EgovMap) bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("bbs_group_seq", "2000");
			paramMap.put("user_id", (String) session.getAttribute("user_id"));
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");

			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);

			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("user_id", (String) session.getAttribute("user_id"));

			Map<String, String> edgeInfo = publicDsetService.selectPublicDsetInfo(paramMap);
			List<?> mxFileList = publicDsetService.selectMxFileList(paramMap);

			// edgeInfo.put("bContent", clobToString((Clob)edgeInfo.get("bContent")));
			// LOG.debug(" bContent["+edgeInfo.get("bContent")+"]");

			int user_chk = 0;
			if (auth_id.equals("103")) {
				user_chk = 1;
			}

			model.addAttribute("edgeInfo", edgeInfo);
			model.addAttribute("mxFileList", mxFileList);
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
			model.addAttribute("user_id", (String) session.getAttribute("user_id"));

			rtnStr = "agency/Agcy_Edge_View.tiles";
			
		} else {
			
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if (bbs_seq == null || bbs_seq.equals("")) {
				if (bbs_list != null) {
					EgovMap egovMap = (EgovMap) bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("bbs_group_seq", "3000");
			paramMap.put("user_id", (String) session.getAttribute("user_id"));
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");

			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);

			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("user_id", (String) session.getAttribute("user_id"));

			Map<String, String> edgeInfo = publicDsetService.selectPublicDsetInfo(paramMap);
			List<?> mxFileList = publicDsetService.selectMxFileList(paramMap);

			// edgeInfo.put("bContent", clobToString((Clob)edgeInfo.get("bContent")));
			// LOG.debug(" bContent["+edgeInfo.get("bContent")+"]");

			int user_chk = 0;
			if (auth_id.equals("103")) {
				user_chk = 1;
			}

			model.addAttribute("edgeInfo", edgeInfo);
			model.addAttribute("mxFileList", mxFileList);
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
			model.addAttribute("user_id", (String) session.getAttribute("user_id"));
			
			rtnStr = "open/Open_Edge_View.tiles";
		}
		
		return rtnStr;
	}
	
	/**
	 * 공공 데이터셋 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Edge_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_Info.do")
	public String selectOpenEdgeInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		String rtnStr = ""; // 반환주소
		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Open_Edge_Info.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   b_seq["+paramMap.get("b_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		
		//협의체 메뉴를 위한 분기처리
		if(bbs_seq.equals("2080") || bbs_seq.equals("2090") || bbs_seq.equals("2100")) {
			
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
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
			paramMap.put("user_id", (String) session.getAttribute("user_id"));
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");

			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);
			
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("user_id", (String)session.getAttribute("user_id"));

			Map<String, String> edgeInfo = publicDsetService.selectPublicDsetInfo(paramMap);
			List<?> mxFileList = publicDsetService.selectMxFileList(paramMap);

			// edgeInfo.put("bContent", clobToString((Clob)edgeInfo.get("bContent")));
			// LOG.debug(" bContent["+edgeInfo.get("bContent")+"]");

			int user_chk = 0;
			if(auth_id.equals("103")) {
				user_chk = 1;
			}

			model.addAttribute("edgeInfo", edgeInfo);
			model.addAttribute("mxFileList", mxFileList);
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
			model.addAttribute("user_id", (String)session.getAttribute("user_id"));

			return "agency/Agcy_Edge_Info.tiles";
			
		} else {
		
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if(bbs_seq == null || bbs_seq.equals("")) {
				if(bbs_list != null) {
					EgovMap egovMap = (EgovMap)bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("bbs_group_seq", "3000");
			paramMap.put("user_id", (String) session.getAttribute("user_id"));
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");
	
			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);
			
			paramMap.put("bbs_seq", bbs_seq);
			paramMap.put("user_id", (String)session.getAttribute("user_id"));
	
			Map<String, String> edgeInfo = publicDsetService.selectPublicDsetInfo(paramMap);
			List<?> mxFileList = publicDsetService.selectMxFileList(paramMap);
	
			// edgeInfo.put("bContent", clobToString((Clob)edgeInfo.get("bContent")));
			// LOG.debug(" bContent["+edgeInfo.get("bContent")+"]");
	
			int user_chk = 0;
			if(auth_id.equals("103")) {
				user_chk = 1;
			}
	
			model.addAttribute("edgeInfo", edgeInfo);
			model.addAttribute("mxFileList", mxFileList);
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
			model.addAttribute("user_id", (String)session.getAttribute("user_id"));
			
			rtnStr = "open/Open_Edge_Info.tiles";

		}
		
		return rtnStr;
	}

	/**
	 * 일반시나리오 데이터셋 등록 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Edge_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_Inst.do")
	public String openEdgeInsert(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);
		
		String rtnStr = ""; // 반환주소

		LOG.debug(" ########## Open_Edge_View.do ###########");
		LOG.debug("    bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("     reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		
		//협의체 메뉴를 위한 분기처리
		if(bbs_seq.equals("2080") || bbs_seq.equals("2090") || bbs_seq.equals("2100")) {
			
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if (bbs_seq == null || bbs_seq.equals("")) {
				if (bbs_list != null) {
					EgovMap egovMap = (EgovMap) bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			paramMap.put("bbs_seq", bbs_seq);
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");
			// Map<String, String> map05 = new HashMap<String, String>();
			// map05.put("bbs_group_seq", "1000");
			
			
			
			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			// List<?> code_dataset = publicDsetService.selectDtupDataSetList(map05);
			List<?> subCodeList = codeService.selectSubCodeChkList(paramMap);
			List<?> subCodeList2 = codeService.selectSubCodeChkList2(paramMap);
			
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);
			// model.addAttribute("code_dataset", code_dataset);
			
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("subCodeList", subCodeList);
			model.addAttribute("subCodeList2", subCodeList2);
			
			rtnStr = "agency/Agcy_Edge_Inst.tiles";
			
		}else {
			
			Map<String, String> map_00 = new HashMap<String, String>();
			map_00.put("bbs_group_seq", "4000");
			List<?> bbs_list = codeService.selectBbsList(map_00);
			model.addAttribute("bbs_list", bbs_list);
			if (bbs_seq == null || bbs_seq.equals("")) {
				if (bbs_list != null) {
					EgovMap egovMap = (EgovMap) bbs_list.get(0);
					bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
				}
			}
			paramMap.put("bbs_seq", bbs_seq);
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("codeid", scenarioCode1);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("codeid", scenarioCode2);
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("codeid", scenarioCode3);
			Map<String, String> map04 = new HashMap<String, String>();
			map04.put("codeid", "autocar_driving_mode");
			// Map<String, String> map05 = new HashMap<String, String>();
			// map05.put("bbs_group_seq", "1000");
			
			List<?> scenario_code1 = codeService.selectSubCodeList(map01);
			List<?> scenario_code2 = codeService.selectSubCodeList(map02);
			List<?> scenario_code3 = codeService.selectSubCodeList(map03);
			List<?> code_driving_mode = codeService.selectSubCodeList(map04);
			// List<?> code_dataset = publicDsetService.selectDtupDataSetList(map05);
			List<?> subCodeList = codeService.selectSubCodeChkList(paramMap);
			List<?> subCodeList2 = codeService.selectSubCodeChkList2(paramMap);
			
			model.addAttribute("scenario_code1", scenario_code1);
			model.addAttribute("scenario_code2", scenario_code2);
			model.addAttribute("scenario_code3", scenario_code3);
			model.addAttribute("code_driving_mode", code_driving_mode);
			// model.addAttribute("code_dataset", code_dataset);
			
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
			model.addAttribute("subCodeList", subCodeList);
			model.addAttribute("subCodeList2", subCodeList2);
			
			rtnStr = "open/Open_Edge_Inst.tiles";
		}

		return rtnStr;
	}

	/**
	 * 공공데이터 데이터셋 등록 한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_Inst_Process.do")
	public String openEdgeInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; // 결과
		String bbs_group_seq = "3000";
		pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		pathUpload = propertiesService.getString("pathUpload");
		path_d = pathUpload+"cits"+pathLetter; // 공공데이터

		LOG.debug(" ########## Open_Edge_Inst_Process.do ###########");
		LOG.debug("       bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("       bbs_group_seq[" + paramMap.get("bbs_group_seq") + "]");
		LOG.debug("   b_title[" + paramMap.get("b_title") + "]");
		LOG.debug("      b_content[" + paramMap.get("b_content") + "]");
		LOG.debug("     select_driving_mode[" + paramMap.get("selectDrivingMode") + "]");
		LOG.debug("     select_data_type[" + paramMap.get("selectDataType") + "]");
		LOG.debug("     selectScenarioCode1[" + paramMap.get("selectScenarioCode1") + "]");
		LOG.debug("     selectScenarioCode2[" + paramMap.get("selectScenarioCode2") + "]");
		LOG.debug("     selectScenarioCode3[" + paramMap.get("selectScenarioCode3") + "]");
		LOG.debug("        reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			LOG.debug("        user_id[" + user_id + "]");
			LOG.debug("        auth_id[" + auth_id + "]");
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String b_seq = publicDsetService.sequenceBseq(paramMap);
		LOG.debug("        Position Log[1]");
/////////////////////////////////////////////////////
		// 첨부파일 처리
		/*
		 * Map<String, MultipartFile> files = multipartRequest.getFileMap();
		 * LOG.debug("        Position Log[2]"); String newFileNM = "";
		 * LOG.debug("        files.get(\"customFile\").getOriginalFilename()["+files.
		 * get("customFile").getOriginalFilename()+"]"); 파일 확장자 체크 : S boolean bExt =
		 * Util.fileExtCheck(files.get("customFile").getOriginalFilename());
		 * 
		 * LOG.debug("        bExt["+bExt+"]");
		 * LOG.debug("        files.size()["+files.size()+"]");
		 * if(!files.get("customFile").isEmpty() && !bExt) {
		 * LOG.debug("        !files.get(\"customFile\").isEmpty() && !bExt["+(!files.
		 * get("customFile").isEmpty() && !bExt)+"]");
		 * model.addAttribute("result_insert", "ext"); model.addAttribute("bbs_seq",
		 * paramMap.get("bbs_seq")); return "open/Open_Edge_Process"; }
		 * LOG.debug("        Position Log[3]"); 파일 확장자 체크 : E
		 * if(!files.get("customFile").isEmpty() && bExt){
		 * LOG.debug("        Position Log[4]"); newFileNM = b_seq + "_";
		 * paramMap.put("file_size", String.valueOf(files.get("customFile").getSize()));
		 * String file_name = FileUtil.transferUploadFileNew(files.get("customFile"),
		 * pathUpload, newFileNM); paramMap.put("attach_filename", file_name); }else{
		 * LOG.debug("        Position Log[5]"); paramMap.put("attach_filename", "");
		 * paramMap.put("file_size", ""); }
		 */
		///////////////////////////////////////////
		// 데이터첨부파일(변경)
		Map<String, String> map_d = new HashMap<String, String>();
		map_d.put("b_seq", b_seq);

		// JSONArray file_info = new JSONArray(paramMap.get("file_info"));
		// LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info);
		/*
		 * Map<String, MultipartFile> files = multipartRequest.getFileMap(); String
		 * filePath = path_d; String fileSize =
		 * files.get("customFile").getSize()+"";//files.size() + ""; String fileName =
		 * files.get("customFile").getOriginalFilename(); if (fileName != null &&
		 * fileName.length() > 0) { // JSONObject jsonObject =
		 * file_info.getJSONObject(0); 파일 확장자 체크 : S boolean bExt_03 =
		 * Util.fileExtCheck(fileName); if (!bExt_03) {
		 * model.addAttribute("result_insert", "ext"); return "open/Open_Edge_Process";
		 * } 파일 확장자 체크 : E if (bExt_03) { String fullPath = filePath; int cut1 =
		 * StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1; String dirPath =
		 * fullPath.substring(0, cut1); String fileOrgNm = fullPath.substring(cut1);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ fileOrgNm]" + fileOrgNm); String origName =
		 * fileOrgNm; String findStr = b_seq + "_"; String upldName = ""; if
		 * (fileName.indexOf(findStr) > -1) { upldName = fileName; } else { upldName =
		 * b_seq + "_" + fileName; } LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" +
		 * upldName); // 파일이동
		 * 
		 * if (bbs_group_seq.equals("3000")) { //임시 FileUtil.fileMove(path_d+origName,
		 * path_c, upldName); FileUtil.fileRename(path_d, origName, upldName); } else {
		 * FileUtil.fileRename(path_d, origName, upldName); }
		 * 
		 * String destDir = fullPath; String newFileNm = b_seq + "_";
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ destDir]" + destDir);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ newFileNm]" + newFileNm);
		 * FileUtil.transferUploadFileNew(files.get("customFile"), destDir, newFileNm);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" + fileSize); map_d.put("real_nm",
		 * origName); map_d.put("file_size", fileSize); map_d.put("file_type",
		 * paramMap.get("file_type")); map_d.put("file_ext", ""); map_d.put("save_nm",
		 * upldName);
		 * 
		 * publicDsetService.insertAppend(map_d); } }
		 * LOG.debug("        Position Log[6]");
		 */

		try {
			// 등록
			paramMap.put("b_seq", b_seq);
			paramMap.put("driving_mode", paramMap.get("selectDrivingMode"));
			paramMap.put("data_type", paramMap.get("selectDataType"));
			paramMap.put("collect_loc", paramMap.get("selectScenarioCode1"));
			paramMap.put("collect_time", paramMap.get("selectScenarioCode2"));
			paramMap.put("collect_scenario", paramMap.get("selectScenarioCode3"));

			paramMap.put("reg_id", (String) session.getAttribute("user_id")); // 작성자
			publicDsetService.insertPublicDset(paramMap);
			LOG.debug("        Position Log[7]");

			/*
			 * 사고영상 등록
			 */
			String[] filePath = paramMap.get("filePath").split(",");
			String[] fileSize = paramMap.get("fileSize").split(",");
			String[] fileName = paramMap.get("fileName").split(",");

			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("b_seq", b_seq);
			map03.put("bbs_seq", paramMap.get("bbs_seq"));
			LOG.debug(" @@@@@@@@@@@@@@ : mov_name :" + fileName.length);
			if (fileName != null && fileName.length > 0) {
				for (int i = 0; i < fileName.length; i++) {
					if (fileName[i] != null && fileName[i].length() > 0) {
						/*
						 * String fullPath = filePath[i]; int cut1 =
						 * StringUtils.ordinalIndexOf(filePath[i], "/", 1) + 1; String dirPath =
						 * fullPath.substring(0, cut1); String fileOrgNm = fullPath.substring(cut1);
						 */
						map03.put("seq", String.valueOf(i + 1));
						map03.put("mxfile", fileName[i]);
						map03.put("file_size", fileSize[i]);
						map03.put("file_path", filePath[i]);
						map03.put("file_type", "101");

						LOG.debug(" @@@@@@@@@@@@@@ : 5-" + i);
						publicDsetService.insertMxFile(map03);
						LOG.debug(" @@@@@@@@@@@@@@ : 6-" + i);
					}
				}
			}

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 등록 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_insert", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		LOG.debug("        Position Log[8]");

		return "open/Open_Edge_Process.tiles";
	}

	/**
	 * 공공 데이터셋 수정 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_Updt_Process.do")
	public String openEdgeUpdateProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; // 결과
		String bbs_group_seq = "3000";
		pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		pathUpload = propertiesService.getString("pathUpload");
		path_d = pathUpload+"cits"+pathLetter; // 공공데이터

		LOG.debug(" ########## Open_Edge_Updt_Process.do ###########");
		LOG.debug("       bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("       b_seq[" + paramMap.get("b_seq") + "]");
		LOG.debug("   b_title[" + paramMap.get("b_title") + "]");
		LOG.debug("      b_content[" + paramMap.get("b_content") + "]");
		LOG.debug("     select_driving_mode[" + paramMap.get("selectDrivingMode") + "]");
		LOG.debug("     select_data_type[" + paramMap.get("selectDataType") + "]");
		LOG.debug("     selectScenarioCode1[" + paramMap.get("selectScenarioCode1") + "]");
		LOG.debug("     selectScenarioCode2[" + paramMap.get("selectScenarioCode2") + "]");
		LOG.debug("     selectScenarioCode3[" + paramMap.get("selectScenarioCode3") + "]");
		LOG.debug("        reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			LOG.debug("        user_id[" + user_id + "]");
			LOG.debug("        auth_id[" + auth_id + "]");
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		//String b_seq = publicDsetService.sequenceBseq(paramMap);
		String b_seq = paramMap.get("b_seq");
		LOG.debug("        Position Log[1]");
/////////////////////////////////////////////////////
		// 첨부파일 처리
		/*
		 * Map<String, MultipartFile> files = multipartRequest.getFileMap();
		 * LOG.debug("        Position Log[2]"); String newFileNM = "";
		 * LOG.debug("        files.get(\"customFile\").getOriginalFilename()["+files.
		 * get("customFile").getOriginalFilename()+"]"); 파일 확장자 체크 : S boolean bExt =
		 * Util.fileExtCheck(files.get("customFile").getOriginalFilename());
		 * 
		 * LOG.debug("        bExt["+bExt+"]");
		 * LOG.debug("        files.size()["+files.size()+"]");
		 * if(!files.get("customFile").isEmpty() && !bExt) {
		 * LOG.debug("        !files.get(\"customFile\").isEmpty() && !bExt["+(!files.
		 * get("customFile").isEmpty() && !bExt)+"]");
		 * model.addAttribute("result_insert", "ext"); model.addAttribute("bbs_seq",
		 * paramMap.get("bbs_seq")); return "open/Open_Edge_Process"; }
		 * LOG.debug("        Position Log[3]"); 파일 확장자 체크 : E
		 * if(!files.get("customFile").isEmpty() && bExt){
		 * LOG.debug("        Position Log[4]"); newFileNM = b_seq + "_";
		 * paramMap.put("file_size", String.valueOf(files.get("customFile").getSize()));
		 * String file_name = FileUtil.transferUploadFileNew(files.get("customFile"),
		 * pathUpload, newFileNM); paramMap.put("attach_filename", file_name); }else{
		 * LOG.debug("        Position Log[5]"); paramMap.put("attach_filename", "");
		 * paramMap.put("file_size", ""); }
		 */
		/*
		 * /////////////////////////////////////////// // 데이터첨부파일(변경) Map<String,
		 * String> map_d = new HashMap<String, String>(); map_d.put("b_seq", b_seq);
		 * LOG.debug("      saveFile[" + paramMap.get("save_file") + "]");
		 * LOG.debug("      file_nm[" + paramMap.get("file_nm") + "]");
		 * 
		 * if (paramMap.get("save_file") == null ||
		 * paramMap.get("save_file").equals("")) { FileUtil.fileDelete(path_d +
		 * paramMap.get("file_nm")); publicDsetService.deleteAppend(map_d); }
		 * 
		 * // JSONArray file_info = new JSONArray(paramMap.get("file_info")); //
		 * LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info); Map<String,
		 * MultipartFile> files = multipartRequest.getFileMap(); String filePath =
		 * path_d; String fileSize = files.get("customFile").getSize() + "";//
		 * files.size() + ""; String fileName =
		 * files.get("customFile").getOriginalFilename(); if (fileName != null &&
		 * fileName.length() > 0) { // JSONObject jsonObject =
		 * file_info.getJSONObject(0); 파일 확장자 체크 : S boolean bExt_03 =
		 * Util.fileExtCheck(fileName); if (!bExt_03) {
		 * model.addAttribute("result_insert", "ext"); return "open/Open_Edge_Process";
		 * } 파일 확장자 체크 : E if (bExt_03) { String fullPath = filePath; int cut1 =
		 * StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1; String dirPath =
		 * fullPath.substring(0, cut1); String fileOrgNm = fullPath.substring(cut1);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ fileOrgNm]" + fileOrgNm); String origName =
		 * fileOrgNm; String findStr = b_seq + "_"; String upldName = ""; if
		 * (fileName.indexOf(findStr) > -1) { upldName = fileName; } else { upldName =
		 * b_seq + "_" + fileName; } LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" +
		 * upldName); // 파일이동
		 * 
		 * if (bbs_group_seq.equals("3000")) { //임시 FileUtil.fileMove(path_d+origName,
		 * path_c, upldName); FileUtil.fileRename(path_d, origName, upldName); } else {
		 * FileUtil.fileRename(path_d, origName, upldName); }
		 * 
		 * String destDir = fullPath; String newFileNm = b_seq + "_";
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ destDir]" + destDir);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ newFileNm]" + newFileNm);
		 * FileUtil.transferUploadFileNew(files.get("customFile"), destDir, newFileNm);
		 * LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" + fileSize); map_d.put("real_nm",
		 * origName); map_d.put("file_size", fileSize); map_d.put("file_type",
		 * paramMap.get("file_type")); map_d.put("file_ext", ""); map_d.put("save_nm",
		 * upldName);
		 * 
		 * // publicDsetService.insertAppend(map_d); // 삭제 후 등록
		 * 
		 * int rst = publicDsetService.deleteAppend(map_d); if(rst > -1)
		 * 
		 * publicDsetService.insertAppend(map_d); // else result = "0"; } }
		 * LOG.debug("        Position Log[6]");
		 */

		try {
			// 등록
			paramMap.put("b_seq", b_seq);
			paramMap.put("driving_mode", paramMap.get("selectDrivingMode"));
			paramMap.put("data_type", paramMap.get("selectDataType"));
			paramMap.put("collect_loc", paramMap.get("selectScenarioCode1"));
			paramMap.put("collect_time", paramMap.get("selectScenarioCode2"));
			paramMap.put("collect_scenario", paramMap.get("selectScenarioCode3"));

			paramMap.put("reg_id", (String) session.getAttribute("user_id")); // 작성자
			publicDsetService.updatePublicDset(paramMap);
			LOG.debug("        Position Log[7]");

			/*
			 * 사고영상이 변경 되었으면 삭제 후 등록
			 */
			// String mov_new = params.get("mov_new").get(0);
			// 변경확인
			// if(mov_new != null && mov_new.equals("Y")) {
			String[] filePath = paramMap.get("filePath").split(",");
			String[] fileSize = paramMap.get("fileSize").split(",");
			String[] fileName = paramMap.get("fileName").split(",");

			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("b_seq", b_seq);
			map03.put("bbs_seq", paramMap.get("bbs_seq"));
			
			// 삭제
			LOG.debug(" @@@@@@@@@@@@@@ : 7");
			int rst03 = publicDsetService.deleteAppend(map03);
			LOG.debug(" @@@@@@@@@@@@@@ : 8");
			if (rst03 > -1 && fileName != null && fileName.length > 0) {
				LOG.debug(" @@@@@@@@@@@@@@ : mov_name :" + fileName.length);
				for (int i = 0; i < fileName.length; i++) {
					if (fileName[i] != null && fileName[i].length() > 0) {
						/*
						 * String fullPath = filePath[i]; int cut1 =
						 * StringUtils.ordinalIndexOf(filePath[i], "/", 1) + 1; String dirPath =
						 * fullPath.substring(0, cut1); String fileOrgNm = fullPath.substring(cut1);
						 */
						map03.put("seq", String.valueOf(i + 1));
						map03.put("mxfile", fileName[i]);
						map03.put("file_size", fileSize[i]);
						map03.put("file_type", "101");
						LOG.debug(" @@@@@@@@@@@@@@ : 9-" + i);
						publicDsetService.insertMxFile(map03);
						LOG.debug(" @@@@@@@@@@@@@@ :10-" + i);
					}
				}
			}
			// }

			model.addAttribute("b_seq", b_seq);
			model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 등록 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_update", result);
//		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
//		model.addAttribute("b_seq", paramMap.get("b_seq"));
		LOG.debug("        Position Log[8]");

		return "open/Open_Edge_Process.tiles";
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_Delt_Process.do")
	public String openEdgeDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)
			throws Exception {

		int result = 1; // 결과
		pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		pathUpload = propertiesService.getString("pathUpload");
		path_d = pathUpload + "cits" + pathLetter; // 공공데이터

		LOG.debug(" ########## Open_Edge_Delt_Process.do ###########");
		LOG.debug("    bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("   b_seq[" + paramMap.get("b_seq") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		result = publicDsetService.deletePublicDset(paramMap);
		if (result > -1) {
			//if (paramMap.get("save_file") == null || paramMap.get("save_file").equals("")) {
				// 데이터첨부파일(변경)
				Map<String, String> map_d = new HashMap<String, String>();
				map_d.put("b_seq", paramMap.get("b_seq"));
				FileUtil.fileDelete("/Share2/"+paramMap.get("filePath")+"/"+paramMap.get("file_nm"));
				publicDsetService.deleteAppend(map_d);
			//}
		} else
			result = -1;

		LOG.debug(" result[" + result + "]");

		model.addAttribute("result_delete", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("b_seq", paramMap.get("b_seq"));

		return "open/Open_Edge_Process";
	}
	
	/**
	 * 셀렉트 박스 서브 코드 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "subCodeList"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_V2x_Delt_SubCodeList.do")
	@ResponseBody
	public ModelAndView selectSubCodeList(@RequestParam("refVal2") String refVal2, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = "jsonView";
		mav.setViewName(viewName);
		
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("searchScenarioCode1", refVal2);
		
		List<?> subCodeList = codeService.selectSubCodeChkList(map01);
		mav.addObject("scenario_code1", subCodeList);
		return mav; 
	}
	
	/**
	 * 셀렉트 박스 서드코드 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "subCodeList"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_V2x_Delt_SubCodeList2.do")
	@ResponseBody
	public ModelAndView selectSubCodeList2(@RequestParam("refVal2") String refVal2, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();
		String viewName = "jsonView";
		mav.setViewName(viewName);
		
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("searchScenarioCode2", refVal2);
		
		List<?> subCodeList = codeService.selectSubCodeChkList2(map01);
		mav.addObject("scenario_code2", subCodeList);
		return mav; 
	}
	
	/**
	 * 다운로드 완료시 파일사이즈 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Edge_v2x_FileInfo.do")
	@ResponseBody
	public Object Open_Edge_v2x_FileInfo(@RequestParam("fileSize") String fileSize, @RequestParam("bSeq") String bSeq, ModelMap model, HttpSession session) throws Exception {
		String result ="";
		
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("eval_id", (String)session.getAttribute("user_id")); //사용자id
		map01.put("file_size", fileSize);
		map01.put("b_seq", bSeq);
		
		dwhsService.insertDwhs(map01);
		result = "1";
		
		return result; 
	}
}
