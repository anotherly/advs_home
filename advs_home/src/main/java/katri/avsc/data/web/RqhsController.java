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
import katri.avsc.data.service.RqhsService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * My data > 요청자료
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/data/request")
public class RqhsController {
	
	/** EgovSampleService */
	@Resource(name = "rqhsService")
	RqhsService rqhsService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(RqhsController.class.getName());
	
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
	 * @return "Data_Rqhs_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Rqhs_List.do")
	public String selectRqhsList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //		
		model.addAttribute("uriModel", uriModel);
		int iPageNo = 1;		

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

		paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id

		List<?> rqhsList = rqhsService.selectRqhsList(paramMap);
		model.addAttribute("resultList", rqhsList);
		
		int totCnt = rqhsService.selectRqhsListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "data/Data_Rqhs_List.tiles";
	}
	

	/**
	 * 권한 위임을 부여한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Delega_Auth.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Delega_Auth.do")
	public String updateDelegAuth(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session){
		System.out.println("==================AUTH START=======================");
		//int iPageNo = 1;	//	

		/* 크로스사이트 체크 : S */
	
		/* 크로스사이트 체크 : E */
		
		paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id
		List<?> raceNumberList = rqhsService.selectRaceNumberList(paramMap);
		model.addAttribute("raceNumberList", raceNumberList);	
		
		Map<String, String> member = rqhsService.selectMemberList(paramMap);
		System.out.println("=============RETURN===============");
		
		
		model.addAttribute("member", member);		
	
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
		model.addAttribute("user_id", paramMap.get("userid"));		
		return "data/Data_Delega_Auth.tiles";
	}

	
	
	/**
	 * 권한 위임을 부여한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "updateDelegAuthSave.do"
	 * @exception Exception
	 */
	@RequestMapping(value = "InsertDelegAuth.do")
	public String updateDelegAuthSave(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)	 {	
        
		paramMap.put("userid", (String)session.getAttribute("user_id")); //사용자id	
			
		Map<String, String> map_v = new HashMap<String, String>();
		map_v.put("user_id", (String) session.getAttribute("user_id"));
		map_v.put("auth_cd", (String) session.getAttribute("auth_id"));
		map_v.put("user_nm", paramMap.get("userNm"));
		map_v.put("agency_cd", paramMap.get("temp_oper_inst"));
		map_v.put("auth_id", paramMap.get("takeover_id"));
		map_v.put("argument_id", paramMap.get("argument_id"));	
		
		rqhsService.insertAuth(map_v);
		
		return "data/Data_Delega_Auth.tiles";
		 
	}

	
}
