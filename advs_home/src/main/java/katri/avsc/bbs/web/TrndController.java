package katri.avsc.bbs.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.bbs.service.TrndService;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * 게시판 > 자율주행 최신동향
 * @author jwchoi
 */
@Controller
public class TrndController {

	/** EgovSampleService */
	@Resource(name = "trndService")
	TrndService trndService;

	private static final Log LOG = LogFactory.getLog(TrndController.class.getName());
	
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
	 * @return "Board_Trnd_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "/bbs/trend/Board_Trnd_List.do")
	public String selectTrndList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Board_Trnd_List.do ###########");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* 크로스사이트 체크 : S */
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		/* 크로스사이트 체크 : E */

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

		paramMap.put("blbd_div_cd", "102");	//자율주행 최신동향

		List<?> trndList = trndService.selectTrndList(paramMap);
		model.addAttribute("resultList", trndList);
		LOG.debug(" @@@@@@@@@@@@@@@@@trndList["+trndList+"]");
		
		int totCnt = trndService.selectTrndListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));

		return "board/Board_Trnd_List.tiles";
	}

	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Board_Trnd_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "/bbs/trend/Board_Trnd_Info.do")
	public String trndInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Board_Trnd_Info.do ###########");
		LOG.debug(" blbd_div_cd["+paramMap.get("blbd_div_cd")+"]");
		LOG.debug("    bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		//접속수 카운트 증가
		try{
			trndService.updateIqurNctn(paramMap);
		}catch (Exception e) {
			e.printStackTrace();
			LOG.info("[DB Exception] 자율주행최신동향 접속수 증가  실패 : ");
		}

		Map<String, String> trndInfo = trndService.selectTrndInfo(paramMap);
		model.addAttribute("trndInfo", trndInfo);

		return "board/Board_Trnd_Info.tiles";
	}

	
}
