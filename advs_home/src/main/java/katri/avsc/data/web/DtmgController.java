package katri.avsc.data.web;

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
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.agcy.service.ConsService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DtupService;
import katri.avsc.data.service.UphsService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * mydata > 관리자
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/data/control")
public class DtmgController {

	/** EgovSampleService */
	@Resource(name = "uphsService")
	UphsService uphsService;

	/** consService */
	@Resource(name = "consService")
	ConsService consService;

	/** dtupService */
	@Resource(name = "dtupService")
	DtupService dtupService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(DtmgController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * 목록을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Dtmg_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtmg_List.do")
	public String selectDtmgList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Data_Dtmg_List.do ###########");
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
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

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

		List<?> dtmgList = uphsService.selectDtmgList(paramMap);
		model.addAttribute("resultList", dtmgList);
		
		int totCnt = uphsService.selectDtmgListTotCnt(paramMap);
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
		model.addAttribute("auth_id", auth_id);

		return "data/Data_Dtmg_List.tiles";
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtmg_Delt_Process.do")
	public String dtupDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		int result = 1; //결과

		LOG.debug(" ########## Data_Dtmg_Delt_Process.do ###########");
		LOG.debug("   b_seq["+paramMap.get("b_seq")+"]");
		LOG.debug(" bbs_seq["+paramMap.get("bbs_seq")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		result = dtupService.deleteAppend(paramMap);
		if(result > -1) result = dtupService.deleteBoard(paramMap);
		else result = -1;

		LOG.debug(" result["+result+"]");
		
		model.addAttribute("result_delete", result);
		
		return "data/Data_Dtmg_Process";
	} 


}
