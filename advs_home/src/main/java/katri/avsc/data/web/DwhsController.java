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
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DwhsService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * My data > 내가받은자료
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/data/record")
public class DwhsController {
	
	/** EgovSampleService */
	@Resource(name = "dwhsService")
	DwhsService dwhsService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(DwhsController.class.getName());
	
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
	 * @return "Data_Dwhs_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dwhs_List.do")
	public String selectDwhsList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Data_Dwhs_List.do ###########");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug(" searchBord["+paramMap.get("searchBord")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");

		/* 크로스사이트 체크 : S */
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		String searchBord = paramMap.get("searchBord");
		searchBord = Util.injectionCheck(searchBord);
		paramMap.put("searchBord", searchBord);
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

		paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id

		List<?> dwhsList = dwhsService.selectDwhsList(paramMap);
		model.addAttribute("resultList", dwhsList);
		
		int totCnt = dwhsService.selectDwhsListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);
		//게시판 목록
		List<?> code_bbsseq = codeService.selectBbsSeqList(paramMap);
		model.addAttribute("code_bbsseq", code_bbsseq);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("searchBord", paramMap.get("searchBord"));
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "data/Data_Dwhs_List.tiles";
	}


	/**
	 * 평가하기 팝업
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Eval_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Eval_Popup.do")
	public String evalPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Data_Eval_Popup.do ###########");

		return "data/Data_Eval_Popup";
	}

	/**
	 * 평가하기 요청 처리
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Eval_Process.do")
	public String tpsvInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		String result = "1"; //결과

		LOG.debug(" ########## Data_Eval_Process.do ###########");
		LOG.debug("      b_seq["+paramMap.get("b_seq")+"]");
		LOG.debug(" eval_point["+paramMap.get("eval_point")+"]");
		LOG.debug("  b_content["+paramMap.get("b_content")+"]");
		LOG.debug("    user_id["+session.getAttribute("user_id")+"]");

		try{
			paramMap.put("eval_id", (String)session.getAttribute("user_id")); //작성자
			//평가 등록
			dwhsService.updateDwhs(paramMap);
		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 평가정보 등록 실패 : ");
			result = "0";
		}
		
		model.addAttribute("result_insert", result);
		
		return "data/Data_Eval_Process";
	}

}
