package katri.avsc.duty.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.com.core.ExcelUtil;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.com.service.ParaService;
import katri.avsc.duty.excel.DevcExcel;
import katri.avsc.duty.service.DevcService;
import katri.avsc.duty.service.DrvgService;
import katri.avsc.egovframework.cmmn.util.*;

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

/**
 * 운행정보보고 > 장치변경
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/duty/device")
public class DevcController {
	
	/** drvgService */
	@Resource(name = "drvgService")
	DrvgService drvgService;
	
	/** devcService */
	@Resource(name = "devcService")
	DevcService devcService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	/** paraService */
	@Resource(name = "paraService")
	ParaService paraService;

	private static final Log LOG = LogFactory.getLog(DevcController.class.getName());
	
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
	 * @return "Duty_Devc_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_List.do")
	public String selectDevcList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Duty_Devc_List.do ###########");
		LOG.debug(" searchType["+paramMap.get("searchType")+"]");
		LOG.debug(" searchWord["+paramMap.get("searchWord")+"]");
		LOG.debug("     userid["+(String)session.getAttribute("user_id")+"]");

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
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
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

		paramMap.put("userid", user_id); //사용자id
		paramMap.put("authid", auth_id); //권한

		List<?> devcList = devcService.selectDevcList(paramMap);
		model.addAttribute("resultList", devcList);
		
		int totCnt = devcService.selectDevcListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("param_id", "defice_ch_eff_date");
		Map<String, String> paramInfo = paraService.selectParaInfo(map01);
		
		//기간체크
		int drvChk = drvgService.selectDrvgIsCheck(paramMap);
		model.addAttribute("drvChk", drvChk);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("paramInfo", paramInfo);

		return "duty/Duty_Devc_List.tiles";
	}

	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Devc_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Info.do")
	public String devcInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Devc_Info.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" chg_id["+paramMap.get("chg_id")+"]");

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

		Map<String, String> devcInfo = devcService.selectDevcInfo(paramMap);

		model.addAttribute("devcInfo", devcInfo);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("chg_id", paramMap.get("chg_id"));

		return "duty/Duty_Devc_Info.tiles";
	}

	/**
	 * 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Devc_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Inst.do")
	public String devcInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Devc_Inst.do ###########");

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

		Map<String, String> map_01 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_tempoper = codeService.selectTempOperList(map_01);

		model.addAttribute("code_tempoper", code_tempoper);

		return "duty/Duty_Devc_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Inst_Process.do")
	public String devcInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "devc" + pathLetter;
		String change_id = devcService.sequenceChangeId(paramMap);

		LOG.debug(" ########## Duty_Devc_Inst_Process.do ###########");
		LOG.debug("        tmp_race_number["+paramMap.get("tmp_race_number")+"]");
		LOG.debug("        tmp_race_agency["+paramMap.get("tmp_race_agency")+"]");
		LOG.debug(" driving_mode_change_yn["+paramMap.get("driving_mode_change_yn")+"]");
		LOG.debug("    spd_range_change_yn["+paramMap.get("spd_range_change_yn")+"]");
		LOG.debug("       device_change_yn["+paramMap.get("device_change_yn")+"]");
		LOG.debug("         dm_before_spec["+paramMap.get("dm_before_spec")+"]");
		LOG.debug("          dm_after_spec["+paramMap.get("dm_after_spec")+"]");
		LOG.debug("        src_before_spec["+paramMap.get("src_before_spec")+"]");
		LOG.debug("         src_after_spec["+paramMap.get("src_after_spec")+"]");
		LOG.debug("         dc_before_spec["+paramMap.get("dc_before_spec")+"]");
		LOG.debug("          dc_after_spec["+paramMap.get("dc_after_spec")+"]");
		LOG.debug("            change_info["+paramMap.get("change_info")+"]");
		LOG.debug("                 reg_id["+session.getAttribute("user_id")+"]");

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

		//첨부파일 처리
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		//주행모드변경전
		/* 파일 확장자 체크 : S */
		boolean bExt_01 = Util.fileExtCheck(files.get("dm_bf_file").getOriginalFilename());
		if(!files.get("dm_bf_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && !bExt_01) {
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dm_bf_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && bExt_01){
			newFileNM = change_id + "A_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dm_bf_file"), pathUpload, newFileNM);
			paramMap.put("dm_before_filename", file_name);
		}else{
			paramMap.put("dm_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_02 = Util.fileExtCheck(files.get("dm_af_file").getOriginalFilename());
		if(!files.get("dm_af_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && !bExt_02) {
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dm_af_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && bExt_02){
			newFileNM = change_id + "B_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dm_af_file"), pathUpload, newFileNM);
			paramMap.put("dm_after_filename", file_name);
		}else{
			paramMap.put("dm_after_filename", "");
		}
		//작동속도범위변경
		/* 파일 확장자 체크 : S */
		boolean bExt_03 = Util.fileExtCheck(files.get("sr_bf_file").getOriginalFilename());
		if(!files.get("sr_bf_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && !bExt_03){
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("sr_bf_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && bExt_03){
			newFileNM = change_id + "C_";
			String file_name = FileUtil.transferUploadFileNew(files.get("sr_bf_file"), pathUpload, newFileNM);
			paramMap.put("src_before_filename", file_name);
		}else{
			paramMap.put("src_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_04 = Util.fileExtCheck(files.get("sr_af_file").getOriginalFilename());
		if(!files.get("sr_af_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && !bExt_04){
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("sr_af_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && bExt_04){
			newFileNM = change_id + "D_";
			String file_name = FileUtil.transferUploadFileNew(files.get("sr_af_file"), pathUpload, newFileNM);
			paramMap.put("src_after_filename", file_name);
		}else{
			paramMap.put("src_after_filename", "");
		}
		//구조및장치변경
		/* 파일 확장자 체크 : S */
		boolean bExt_05 = Util.fileExtCheck(files.get("dc_bf_file").getOriginalFilename());
		if(!files.get("dc_bf_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && !bExt_05){
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dc_bf_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && bExt_05){
			newFileNM = change_id + "E_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dc_bf_file"), pathUpload, newFileNM);
			paramMap.put("dc_before_filename", file_name);
		}else{
			paramMap.put("dc_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_06 = Util.fileExtCheck(files.get("dc_af_file").getOriginalFilename());
		if(!files.get("dc_af_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && !bExt_06){
			model.addAttribute("result_insert", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dc_af_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && bExt_06){
			newFileNM = change_id + "F_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dc_af_file"), pathUpload, newFileNM);
			paramMap.put("dc_after_filename", file_name);
		}else{
			paramMap.put("dc_after_filename", "");
		}

		try{
			String modify_date = paramMap.get("modify_date_d") +" "+ paramMap.get("modify_date_h") +":"+ paramMap.get("modify_date_m");
			paramMap.put("change_id", change_id);
			paramMap.put("modify_date", modify_date);
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			//운행정보 등록
			devcService.insertDevc(paramMap);

		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 장치변경 등록 실패 : "+ e.toString());
			result = "0";
		}
		
		model.addAttribute("result_insert", result);

		return "duty/Duty_Devc_Process";
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Delt_Process.do")
	public String devcDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {
		
		LOG.debug(" ########## Duty_Devc_Delt_Process.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" chg_id["+paramMap.get("chg_id")+"]");

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

		int result = devcService.deleteDevc(paramMap);
		LOG.debug(" result["+result+"]");
		
		model.addAttribute("result_delete", result);
		
		return "duty/Duty_Devc_Process";
	} 

	/**
	 * 수정 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Devc_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Updt.do")
	public String devcUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Devc_Updt.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" chg_id["+paramMap.get("chg_id")+"]");

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

		Map<String, String> devcInfo = devcService.selectDevcInfo(paramMap);

		Map<String, String> map_01 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_tempoper = codeService.selectTempOperList(map_01);

		model.addAttribute("devcInfo", devcInfo);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("chg_id", paramMap.get("chg_id"));
		model.addAttribute("code_tempoper", code_tempoper);

		return "duty/Duty_Devc_Updt.tiles";
	}

	/**
	 * 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Updt_Process.do")
	public String devcUpdateProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "devc" + pathLetter;
		String change_id = paramMap.get("chg_id");

		LOG.debug(" ########## Duty_Devc_Updt_Process.do ###########");
		LOG.debug("                 drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug("                 chg_id["+paramMap.get("chg_id")+"]");
		LOG.debug("        tmp_race_agency["+paramMap.get("tmp_race_agency")+"]");
		LOG.debug(" driving_mode_change_yn["+paramMap.get("driving_mode_change_yn")+"]");
		LOG.debug("    spd_range_change_yn["+paramMap.get("spd_range_change_yn")+"]");
		LOG.debug("       device_change_yn["+paramMap.get("device_change_yn")+"]");
		LOG.debug("         dm_before_spec["+paramMap.get("dm_before_spec")+"]");
		LOG.debug("          dm_after_spec["+paramMap.get("dm_after_spec")+"]");
		LOG.debug("        src_before_spec["+paramMap.get("src_before_spec")+"]");
		LOG.debug("         src_after_spec["+paramMap.get("src_after_spec")+"]");
		LOG.debug("         dc_before_spec["+paramMap.get("dc_before_spec")+"]");
		LOG.debug("          dc_after_spec["+paramMap.get("dc_after_spec")+"]");
		LOG.debug("            change_info["+paramMap.get("change_info")+"]");
		LOG.debug("                 reg_id["+session.getAttribute("user_id")+"]");

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

		//첨부파일 처리
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String newFileNM = "";
		//주행모드변경전
		/* 파일 확장자 체크 : S */
		boolean bExt_01 = Util.fileExtCheck(files.get("dm_bf_file").getOriginalFilename());
		if(!files.get("dm_bf_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && !bExt_01){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dm_bf_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && bExt_01){
			newFileNM = change_id + "A_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dm_bf_file"), pathUpload, newFileNM);
			paramMap.put("dm_before_filename", file_name);
			paramMap.put("dm_bf_file_yn", "Y");
		}else{
			paramMap.put("dm_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_02 = Util.fileExtCheck(files.get("dm_af_file").getOriginalFilename());
		if(!files.get("dm_af_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && !bExt_02){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dm_af_file").isEmpty() && paramMap.get("driving_mode_change_yn").equals("Y") && bExt_02){
			newFileNM = change_id + "B_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dm_af_file"), pathUpload, newFileNM);
			paramMap.put("dm_after_filename", file_name);
			paramMap.put("dm_af_file_yn", "Y");
		}else{
			paramMap.put("dm_after_filename", "");
		}
		//작동속도범위변경
		/* 파일 확장자 체크 : S */
		boolean bExt_03 = Util.fileExtCheck(files.get("sr_bf_file").getOriginalFilename());
		if(!files.get("sr_bf_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && !bExt_03){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("sr_bf_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && bExt_03){
			newFileNM = change_id + "C_";
			String file_name = FileUtil.transferUploadFileNew(files.get("sr_bf_file"), pathUpload, newFileNM);
			paramMap.put("src_before_filename", file_name);
			paramMap.put("sr_bf_file_yn", "Y");
		}else{
			paramMap.put("src_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_04 = Util.fileExtCheck(files.get("sr_af_file").getOriginalFilename());
		if(!files.get("sr_af_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && !bExt_04){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("sr_af_file").isEmpty() && paramMap.get("spd_range_change_yn").equals("Y") && bExt_04){
			newFileNM = change_id + "D_";
			String file_name = FileUtil.transferUploadFileNew(files.get("sr_af_file"), pathUpload, newFileNM);
			paramMap.put("src_after_filename", file_name);
			paramMap.put("sr_af_file_yn", "Y");
		}else{
			paramMap.put("src_after_filename", "");
		}
		//구조및장치변경
		/* 파일 확장자 체크 : S */
		boolean bExt_05 = Util.fileExtCheck(files.get("dc_bf_file").getOriginalFilename());
		if(!files.get("dc_bf_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && !bExt_05){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dc_bf_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && bExt_05){
			newFileNM = change_id + "E_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dc_bf_file"), pathUpload, newFileNM);
			paramMap.put("dc_before_filename", file_name);
			paramMap.put("dc_bf_file_yn", "Y");
		}else{
			paramMap.put("dc_before_filename", "");
		}
		/* 파일 확장자 체크 : S */
		boolean bExt_06 = Util.fileExtCheck(files.get("dc_af_file").getOriginalFilename());
		if(!files.get("dc_af_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && !bExt_06){
			model.addAttribute("result_update", "ext");
			return "duty/Duty_Devc_Process";
		}
		/* 파일 확장자 체크 : E */
		if(!files.get("dc_af_file").isEmpty() && paramMap.get("device_change_yn").equals("Y") && bExt_06){
			newFileNM = change_id + "F_";
			String file_name = FileUtil.transferUploadFileNew(files.get("dc_af_file"), pathUpload, newFileNM);
			paramMap.put("dc_after_filename", file_name);
			paramMap.put("dc_af_file_yn", "Y");
		}else{
			paramMap.put("dc_after_filename", "");
		}

		try{
			String modify_date = paramMap.get("modify_date_d") +" "+ paramMap.get("modify_date_h") +":"+ paramMap.get("modify_date_m");
			paramMap.put("modify_date", modify_date);
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			//운행정보 등록
			devcService.updateDevc(paramMap);

		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 장치변경 수정 실패 : "+ e.toString());
			result = "0";
		}
		
		model.addAttribute("result_update", result);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("chg_id", paramMap.get("chg_id"));

		return "duty/Duty_Devc_Process";
	}

	/**
	 * 보고서 생성
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Excel_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Devc_Excel_Process.do")
	public String devcPopExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		LOG.debug(" ########## Duty_Devc_Excel_Process.do ###########");
		LOG.debug("       drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug("       chg_id["+paramMap.get("chg_id")+"]");

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

		Map<String, String> devcInfo = devcService.selectDevcInfo(paramMap);

		//엑셀파일 이름 변경
		String filenm_org = "excel_devc.xlsx";
		String filenm_new = "excel_devc_"+paramMap.get("chg_id")+".xlsx";
		//업로드 경로
		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		//경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOG.debug(" filePath_new["+filePath_new+"]");

		//엑셀 파일 정보 셋팅
		String result = DevcExcel.devcExcelMake(filePath_new, filenm_new, devcInfo);
		LOG.debug("       result["+result+"]");

		if(result.equals("1")) {
			LOG.debug(" ########## File_Download ###########");
			try {
				String checkFile = filePath_new; //잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
			} catch (RuntimeException e1) {
				LOG.info("[Download File] 실패0 : ");
			}
			String filename = filePath_new;
			
			File file = new File(filename);
			LOG.debug(" ########## Download File : File Name ["+filename+"], File Length ["+file.length()+"] ");
			try {
				if(file.exists()){
					FileUtil.download(request, response, file);
				}
			} catch (ServletException e) {
				LOG.info("[Download File] 실패1 : ");
			} catch (IOException e) {
				LOG.info("[Download File] 실패2 : ");
			}
		}

		model.addAttribute("result", result);
		
//		return "duty/Duty_Excel_Popup";
		return null;
	}


}
