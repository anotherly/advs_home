package katri.avsc.open.web;

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
@RequestMapping(value = "/open/dataset")
public class DsetController {

	/** consService */
	@Resource(name = "consService")
	ConsService consService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(DsetController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * 공공 데이터셋 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Dset_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_List.do")
	public String selectOpenDsetList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Open_Dset_List.do ###########");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
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

		String bbs_seq = "";
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "1000");
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

    	paramMap.put("bbs_group_seq", "1000");
		List<?> dsetList = consService.selectDataSetList(paramMap);
		model.addAttribute("resultList", dsetList);
		
		int totCnt = consService.selectDataSetListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		int user_chk = 0;
		if(auth_id.equals("103")) {
			user_chk = 1;
		}

		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("user_chk", user_chk);
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));

		return "open/Open_Dset_List.tiles";
	}	

	/**
	 * 공공 데이터셋 상세
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Dset_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Info.do")
	public String selectOpenDsetInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Open_Dset_Info.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");
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
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "1000");
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
		int user_chk = 0;
		if(auth_id.equals("103")) {
			user_chk = 1;
		}

		model.addAttribute("dsetInfo", dsetInfo);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));

		return "open/Open_Dset_Info.tiles";
	}

	/**
	 * 기관 데이터셋 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Dset_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Inst.do")
	public String openDsetInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Open_Dset_Inst.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("     reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "1000");
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

		return "open/Open_Dset_Inst.tiles";
	}


	/**
	 * 공공 데이터셋 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Inst_Process.do")
	public String openDsetInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "dset" + pathLetter;

		LOG.debug(" ########## Open_Dset_Inst_Process.do ###########");
		LOG.debug("       bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_ttl_nm["+paramMap.get("bdwr_ttl_nm")+"]");
		LOG.debug("      bdwr_cts["+paramMap.get("bdwr_cts")+"]");
		LOG.debug("     data_form["+paramMap.get("data_form")+"]");
		LOG.debug("        reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "cits");
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
		if(!files.get("file_info").isEmpty() && !bExt){
			model.addAttribute("result_insert", "ext");
			return "open/Open_Dset_Process";
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
			paramMap.put("bbs_group_seq", "1000");
			paramMap.put("bdwr_seq", bdwr_seq);
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			consService.insertDataSet(paramMap);

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 등록 실패 : "+e.toString());
			result = "0";
		}

		model.addAttribute("result_insert", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		return "open/Open_Dset_Process";
	}

	/**
	 * 공공 데이터셋 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Delt_Process.do")
	public String openDsetDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		int result = 1; //결과

		LOG.debug(" ########## Open_Dset_Delt_Process.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "cits");
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
		
		return "open/Open_Dset_Process";
	} 

	/**
	 * 공공 데이터셋 수정화면
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Open_Dset_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Updt.do")
	public String openDsetUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Open_Dset_Updt.do ###########");
		LOG.debug("    bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("   bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "cits");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		String bbs_seq = paramMap.get("bbs_seq");
		Map<String, String> map_00 = new HashMap<String, String>();
		map_00.put("bbs_group_seq", "1000");
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

		return "open/Open_Dset_Updt.tiles";
	}

	/**
	 * 공공 데이터셋 수정 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Open_Dset_Updt_Process.do")
	public String openDsetUpdateProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "dset" + pathLetter;

		LOG.debug(" ########## Open_Dset_Updt_Process.do ###########");
		LOG.debug("       bbs_seq["+paramMap.get("bbs_seq")+"]");
		LOG.debug("      bdwr_seq["+paramMap.get("bdwr_seq")+"]");
		LOG.debug("   bdwr_ttl_nm["+paramMap.get("bdwr_ttl_nm")+"]");
		LOG.debug("      bdwr_cts["+paramMap.get("bdwr_cts")+"]");
		LOG.debug("     data_form["+paramMap.get("data_form")+"]");
		LOG.debug("        reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || !auth_id.equals("103")) {
			model.addAttribute("rst_scrn", "cits");
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
		if(!files.get("file_info").isEmpty() && !bExt){
			model.addAttribute("result_update", "ext");
			return "open/Open_Dset_Process";
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
			paramMap.put("bbs_group_seq", "1000");
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			consService.updateDataSet(paramMap);

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터셋 수정 실패 : "+e.toString());
			result = "0";
		}
		
		model.addAttribute("result_update", result);
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));

		return "open/Open_Dset_Process";
	}


}
