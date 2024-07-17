package katri.avsc.duty.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.com.core.ExcelUtil;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.com.service.ParaService;
import katri.avsc.duty.excel.DrvgExcel;
import katri.avsc.duty.service.DrvgService;
import katri.avsc.egovframework.cmmn.util.*;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

/**
 * 운행정보보고 > 운행정보 등록
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/duty/driving")
public class DrvgController {
	
	/** drvgService */
	@Resource(name = "drvgService")
	DrvgService drvgService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	/** paraService */
	@Resource(name = "paraService")
	ParaService paraService;

	private static final Log LOG = LogFactory.getLog(DrvgController.class.getName());
	
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
	 * @return "Duty_Drvg_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_List.do")
	public String selectDrvgList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Duty_Drvg_List.do ###########");
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

		List<?> drvgList = drvgService.selectDrvgList(paramMap);
		model.addAttribute("resultList", drvgList);

		int totCnt = drvgService.selectDrvgListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("param_id", "dirving_eff_date");
		Map<String, String> paramInfo = paraService.selectParaInfo(map01);

		//기간체크
		int drvChk = drvgService.selectDrvgIsCheck(paramMap);
		model.addAttribute("drvChk", drvChk);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("paramInfo", paramInfo);

		return "duty/Duty_Drvg_List.tiles";
	}

	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Info.do")
	public String drvgInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Drvg_Info.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" std_dt["+paramMap.get("std_dt")+"]");

		/* URL접근 방지 : S */
		//기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
			if(drvChk == 0 && !auth_id.equals("103")) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}
		}
		/* URL접근 방지 : E */

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);

		model.addAttribute("drvgInfo", drvgInfo);
		model.addAttribute("drvList", drvList);
		model.addAttribute("chgList", chgList);
		model.addAttribute("chgDtlList", chgDtlList);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("std_dt", paramMap.get("std_dt"));
		model.addAttribute("drvChk", drvChk);
		model.addAttribute("auth_id", auth_id);

		return "duty/Duty_Drvg_Info.tiles";
	}

	/**
	 * 중복확인
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_IsExist.do")
	public String drvgIsExist(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {
		
		LOG.debug(" ########## Duty_Drvg_IsExist.do ###########");
		LOG.debug("    drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" stnd_dt_y["+paramMap.get("stnd_dt_y")+"]");
		LOG.debug(" stnd_dt_d["+paramMap.get("stnd_dt_d")+"]");

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

		String stnd_dt = paramMap.get("stnd_dt_y") +""+ paramMap.get("stnd_dt_d");
		paramMap.put("std_dt", stnd_dt);
		int result = drvgService.selectDrvgIsExist(paramMap);

		model.addAttribute("result_exist", result);
		
		return "duty/Duty_Drvg_IsExist_Process";
	} 

	/**
	 * 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Inst.do")
	public String drvgInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Duty_Drvg_Inst.do ###########");

		/* URL접근 방지 : S */
		//기간체크
		int drvChk = drvgService.selectDrvgIsCheck(paramMap);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
//			if(drvChk == 0) {
//				model.addAttribute("rst_scrn", "drvg");
//				model.addAttribute("rst_user", user_id);
//				model.addAttribute("rst_auth", auth_id);
//				return "common/Auth_Process";
//			}
		}
		/* URL접근 방지 : E */

		Map<String, String> map_01 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_tempoper = codeService.selectTempOperList(map_01);
		
		//List<?> ctrChange = codeService.selectCtrChangeCodeList(null);
		Map<String, String> attachFile = drvgService.selectAttachFileList();
		model.addAttribute("attachFile", attachFile);
		model.addAttribute("code_tempoper", code_tempoper);

		//model.addAttribute("ctr_change", ctrChange);
		return "duty/Duty_Drvg_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * @param params - 조회할 정보가 담긴 list
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	//@Transactional(rollbackFor =Exception.class) 
	@RequestMapping(value = "Duty_Drvg_Inst_Process.do")
	public String drvgInsertProcess(@RequestParam MultiValueMap<String,String> params, HttpServletRequest request, RedirectAttributes redirectAttributes, ModelMap model, HttpSession session) throws Exception {

		System.out.println("bbbbbbbbbbbbbbbbbbb : ");
		
		String result = "1"; //결과
		LOG.debug(" ########## Duty_Drvg_Inst_Process.do ###########");
		LOG.debug("    tmp_race_number["+params.get("tmp_race_number").get(0)+"]");
		//LOG.debug("          stnd_dt_y["+params.get("stnd_dt_y").get(0)+"]");
		//LOG.debug("          stnd_dt_d["+params.get("stnd_dt_d").get(0)+"]");
		LOG.debug("          stnd_dt["+params.get("stnd_dt").get(0)+"]");
		LOG.debug("    tmp_race_agency["+params.get("tmp_race_agency").get(0)+"]");
		//LOG.debug("  ins_letter_number["+params.get("ins_letter_number").get(0)+"]");
		LOG.debug("      ins_init_date["+params.get("ins_init_date_view").get(0)+"]");
		LOG.debug("      ins_init_date["+params.get("ins_init_date").get(0)+"]");
		LOG.debug(" total_driving_dist["+params.get("total_driving_dist").get(0)+"]");
		LOG.debug("  auto_driving_dist["+params.get("auto_driving_dist").get(0)+"]");
		LOG.debug(" nomal_driving_dist["+params.get("nomal_driving_dist").get(0)+"]");
		LOG.debug("         dist_mon_1["+params.get("dist_mon_1").get(0)+"]");
		LOG.debug("         dist_mon_2["+params.get("dist_mon_2").get(0)+"]");
		LOG.debug("         dist_mon_3["+params.get("dist_mon_3").get(0)+"]");
		LOG.debug("         dist_mon_4["+params.get("dist_mon_4").get(0)+"]");
		LOG.debug("         dist_mon_5["+params.get("dist_mon_5").get(0)+"]");
		LOG.debug("         dist_mon_6["+params.get("dist_mon_6").get(0)+"]");
		LOG.debug("         chng_mon_1["+params.get("chng_mon_1").get(0)+"]");
		LOG.debug("         chng_mon_2["+params.get("chng_mon_2").get(0)+"]");
		LOG.debug("         chng_mon_3["+params.get("chng_mon_3").get(0)+"]");
		LOG.debug("         chng_mon_4["+params.get("chng_mon_4").get(0)+"]");
		LOG.debug("         chng_mon_5["+params.get("chng_mon_5").get(0)+"]");
		LOG.debug("         chng_mon_6["+params.get("chng_mon_6").get(0)+"]");
		LOG.debug("             dist_1["+params.get("dist_1").get(0)+"]");
		LOG.debug("             dist_2["+params.get("dist_2").get(0)+"]");
		LOG.debug("             dist_3["+params.get("dist_3").get(0)+"]");
		LOG.debug("             dist_4["+params.get("dist_4").get(0)+"]");
		LOG.debug("             dist_5["+params.get("dist_5").get(0)+"]");
		LOG.debug("             dist_6["+params.get("dist_6").get(0)+"]");
		LOG.debug("             chng_1["+params.get("chng_1").get(0)+"]");
		LOG.debug("             chng_2["+params.get("chng_2").get(0)+"]");
		LOG.debug("             chng_3["+params.get("chng_3").get(0)+"]");
		LOG.debug("             chng_4["+params.get("chng_4").get(0)+"]");
		LOG.debug("             chng_5["+params.get("chng_5").get(0)+"]");
		LOG.debug("             chng_6["+params.get("chng_6").get(0)+"]");
		LOG.debug("             chng_s["+params.get("chng_s").get(0)+"]");
		LOG.debug("             reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		//기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
			if(drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}
		}
		/* URL접근 방지 : E */
		int chngS = 0;
		try{
			String tmp_race_number = params.get("tmp_race_number").get(0);
			String stnd_dt = params.get("stnd_dt").get(0);
			String tmp_race_agency = params.get("tmp_race_agency").get(0);
			String reg_id = (String)session.getAttribute("user_id");
			
			/*
			 * 운행정보 등록
			 */
			Map<String, String> map00 = new HashMap<String, String>();
			map00.put("tmp_race_number", tmp_race_number);
			map00.put("stnd_dt", stnd_dt);
			map00.put("tmp_race_agency", tmp_race_agency);
			//map00.put("ins_letter_number", params.get("ins_letter_number").get(0));
			map00.put("ins_init_date", params.get("ins_init_date_view").get(0));
			map00.put("total_driving_dist", params.get("total_driving_dist").get(0));
			map00.put("auto_driving_dist", params.get("auto_driving_dist").get(0));
			map00.put("nomal_driving_dist", params.get("nomal_driving_dist").get(0));
			map00.put("reg_id", reg_id);
			//운행정보 등록
			LOG.debug(" @@@@@@@@@@@@@@ : 1");
			drvgService.insertDrvg(map00);
			LOG.debug(" @@@@@@@@@@@@@@ : 2");
			/*
			 * 자율주행 등록
			 */
			String stndDt = params.get("stnd_dt").get(0).substring(0, 4);
			String dist_mon_1 = stndDt + params.get("dist_mon_1").get(0);
			String dist_mon_2 = stndDt + params.get("dist_mon_2").get(0);
			String dist_mon_3 = stndDt + params.get("dist_mon_3").get(0);
			String dist_mon_4 = stndDt +""+ params.get("dist_mon_4").get(0);
			String dist_mon_5 = stndDt +""+ params.get("dist_mon_5").get(0);
			String dist_mon_6 = stndDt +""+ params.get("dist_mon_6").get(0);
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("tmp_race_number", tmp_race_number);
			map01.put("stnd_dt", stnd_dt);
			map01.put("reg_id", reg_id);
			map01.put("driving_dist_mon", dist_mon_1);
			map01.put("auto_driving_dist", params.get("dist_1").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 3");
			drvgService.insertAutoDriving(map01);
			map01.put("driving_dist_mon", dist_mon_2);
			map01.put("auto_driving_dist", params.get("dist_2").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 4");
			drvgService.insertAutoDriving(map01);
			map01.put("driving_dist_mon", dist_mon_3);
			map01.put("auto_driving_dist", params.get("dist_3").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 5");
			drvgService.insertAutoDriving(map01);
			map01.put("driving_dist_mon", dist_mon_4);
			map01.put("auto_driving_dist", params.get("dist_4").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 6");
			drvgService.insertAutoDriving(map01);
			map01.put("driving_dist_mon", dist_mon_5);
			map01.put("auto_driving_dist", params.get("dist_5").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 7");
			drvgService.insertAutoDriving(map01);
			map01.put("driving_dist_mon", dist_mon_6);
			map01.put("auto_driving_dist", params.get("dist_6").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 8");
			drvgService.insertAutoDriving(map01);
			
			/*
			 * 제어권전환 등록
			*/
			String chng_mon_1 = stndDt + params.get("chng_mon_1").get(0);
			String chng_mon_2 = stndDt + params.get("chng_mon_2").get(0);
			String chng_mon_3 = stndDt + params.get("chng_mon_3").get(0);
			String chng_mon_4 = stndDt + params.get("chng_mon_4").get(0);
			String chng_mon_5 = stndDt + params.get("chng_mon_5").get(0);
			String chng_mon_6 = stndDt + params.get("chng_mon_6").get(0);
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("tmp_race_number", tmp_race_number);
			map02.put("stnd_dt", stnd_dt);
			map02.put("reg_id", reg_id);
			map02.put("ctr_change_mon", chng_mon_1);
			map02.put("ctr_change_cnt", params.get("chng_1").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 9");
			drvgService.insertCtrChange(map02);
			map02.put("ctr_change_mon", chng_mon_2);
			map02.put("ctr_change_cnt", params.get("chng_2").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 10");
			drvgService.insertCtrChange(map02);
			map02.put("ctr_change_mon", chng_mon_3);
			map02.put("ctr_change_cnt", params.get("chng_3").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 11");
			drvgService.insertCtrChange(map02);
			map02.put("ctr_change_mon", chng_mon_4);
			map02.put("ctr_change_cnt", params.get("chng_4").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 12");
			drvgService.insertCtrChange(map02);
			map02.put("ctr_change_mon", chng_mon_5);
			map02.put("ctr_change_cnt", params.get("chng_5").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 13");
			drvgService.insertCtrChange(map02);
			map02.put("ctr_change_mon", chng_mon_6);
			map02.put("ctr_change_cnt", params.get("chng_6").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 15");
			drvgService.insertCtrChange(map02);
			
			chngS = Integer.parseInt(params.get("chng_s").get(0));			
			if(chngS > 0) {				
				try {
					result = drvgService.excelUpload(request);
					if(result == null) result = "1";	
				} catch (Exception ex) {
					result = "0";
					model.addAttribute("result_insert", result);
				}
			}
			
			/*
			 * 제어권전환상세 등록
			int result_ctrchng = 0;
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("tmp_race_number", tmp_race_number);
			map03.put("stnd_dt", stnd_dt);
			map03.put("reg_id", reg_id);
			List list_date = params.get("chg_date_d");
			List list_hour = params.get("chg_date_h");
			List list_min = params.get("chg_date_m");
			List list_place = params.get("ctr_change_place");
			List list_cont = params.get("ctr_change_content");
			List list_rmk = params.get("rmk");
			if(list_date != null) {
				for(int i=0; i < list_date.size(); i++) {
					if(list_date.get(i) != null && !list_date.get(i).equals("")) {
						String ch_date = list_date.get(i) +""+ list_hour.get(i) +""+ list_min.get(i);
						map03.put("ctr_change_date", ch_date);
						map03.put("ctr_change_place", (String)list_place.get(i));
						map03.put("ctr_change_content", (String)list_cont.get(i));
						map03.put("rmk", (String)list_rmk.get(i));
						LOG.debug(" @@@@@@@@@@@@@@ : 20-"+i);
						drvgService.insertCtrChangeDtl(map03);
						LOG.debug(" @@@@@@@@@@@@@@ : 21-"+i);
						result_ctrchng++;
					}
				}
			}
			model.addAttribute("result_ctrchng", String.valueOf(result_ctrchng)); */
		}catch (Exception e) {
			//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			LOG.info("[DB Exception] 운행보고 등록 실패 : "+ e.toString());
			result = "0";
		}
	
		model.addAttribute("result_ctrchng", chngS);
		model.addAttribute("result_insert", result);
		return "duty/Duty_Drvg_Process";
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Delt_Process.do")
	public String drvgDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		int result = 1; //결과

		LOG.debug(" ########## Duty_Drvg_Delt_Process.do ###########");
		LOG.debug("    drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug("    std_dt["+paramMap.get("std_dt")+"]");

		/* URL접근 방지 : S */
		//기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
			if(drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}
		}
		/* URL접근 방지 : E */

		result = drvgService.deleteCtrChangeDtl(paramMap);
		if(result > -1) {
			result = drvgService.deleteCtrChange(paramMap);
			if(result > -1) {
				result = drvgService.deleteAutoDriving(paramMap);
				if(result > -1) result = drvgService.deleteDrvg(paramMap);
				else result = -1;
			} else {
				result = -1;
			}
		} else {
			result = -1;
		}
		LOG.debug(" result["+result+"]");
		
		model.addAttribute("result_delete", result);
		
		return "duty/Duty_Drvg_Process";
	} 

	/**
	 * 수정 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Updt.do")
	public String drvgUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Drvg_Updt.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" std_dt["+paramMap.get("std_dt")+"]");

		/* URL접근 방지 : S */
		//기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
			if(drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}
		}
		/* URL접근 방지 : E */

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);
		LOG.debug(" chgDtlList["+chgDtlList+"]");

		Map<String, String> map_01 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String)session.getAttribute("user_id"));
		}
		List<?> code_tempoper = codeService.selectTempOperList(map_01);
		
		List<?> ctrChange = codeService.selectCtrChangeCodeList(null);

		model.addAttribute("ctr_change", ctrChange);		
		model.addAttribute("drvgInfo", drvgInfo);
		model.addAttribute("drvList", drvList);
		model.addAttribute("chgList", chgList);
		model.addAttribute("chgDtlList", chgDtlList);
		model.addAttribute("code_tempoper", code_tempoper);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("std_dt", paramMap.get("std_dt"));
		model.addAttribute("chgDtlSize", chgDtlList.size());

		return "duty/Duty_Drvg_Updt.tiles";
	}

	/**
	 * 수정 한다.
	 * @param params - 조회할 정보가 담긴 list
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Updt_Process.do")
	public String drvgUpdateProcess(@RequestParam MultiValueMap<String,String> params, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

		System.out.println("aaaaaaaaaaaaaaaaaa : ");
		
		String result = "1"; //결과
		
		LOG.debug(" ########## Duty_Drvg_Updt_Process.do ###########");
		LOG.debug("             drv_no["+params.get("drv_no").get(0)+"]");
		LOG.debug("             std_dt["+params.get("std_dt").get(0)+"]");
		LOG.debug(" total_driving_dist["+params.get("total_driving_dist").get(0)+"]");
		LOG.debug("  auto_driving_dist["+params.get("auto_driving_dist").get(0)+"]");
		LOG.debug(" nomal_driving_dist["+params.get("nomal_driving_dist").get(0)+"]");
		LOG.debug("         dist_mon_1["+params.get("dist_mon_1").get(0)+"]");
		LOG.debug("         dist_mon_2["+params.get("dist_mon_2").get(0)+"]");
		LOG.debug("         dist_mon_3["+params.get("dist_mon_3").get(0)+"]");
		LOG.debug("         dist_mon_4["+params.get("dist_mon_4").get(0)+"]");
		LOG.debug("         dist_mon_5["+params.get("dist_mon_5").get(0)+"]");
		LOG.debug("         dist_mon_6["+params.get("dist_mon_6").get(0)+"]");
		LOG.debug("         chng_mon_1["+params.get("chng_mon_1").get(0)+"]");
		LOG.debug("         chng_mon_2["+params.get("chng_mon_2").get(0)+"]");
		LOG.debug("         chng_mon_3["+params.get("chng_mon_3").get(0)+"]");
		LOG.debug("         chng_mon_4["+params.get("chng_mon_4").get(0)+"]");
		LOG.debug("         chng_mon_5["+params.get("chng_mon_5").get(0)+"]");
		LOG.debug("         chng_mon_6["+params.get("chng_mon_6").get(0)+"]");
		LOG.debug("             dist_1["+params.get("dist_1").get(0)+"]");
		LOG.debug("             dist_2["+params.get("dist_2").get(0)+"]");
		LOG.debug("             dist_3["+params.get("dist_3").get(0)+"]");
		LOG.debug("             dist_4["+params.get("dist_4").get(0)+"]");
		LOG.debug("             dist_5["+params.get("dist_5").get(0)+"]");
		LOG.debug("             dist_6["+params.get("dist_6").get(0)+"]");
		LOG.debug("             chng_1["+params.get("chng_1").get(0)+"]");
		LOG.debug("             chng_2["+params.get("chng_2").get(0)+"]");
		LOG.debug("             chng_3["+params.get("chng_3").get(0)+"]");
		LOG.debug("             chng_4["+params.get("chng_4").get(0)+"]");
		LOG.debug("             chng_5["+params.get("chng_5").get(0)+"]");
		LOG.debug("             chng_6["+params.get("chng_6").get(0)+"]");
		LOG.debug("             reg_id["+session.getAttribute("user_id")+"]");

		/* URL접근 방지 : S */
		//기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		} else {
			if(drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}
		}
		/* URL접근 방지 : E */
		int chngS = 0;
		try{
			String drv_no = params.get("drv_no").get(0);
			String std_dt = params.get("std_dt").get(0);
			//String tmp_race_agency = params.get("tmp_race_agency").get(0);
			String reg_id = (String)session.getAttribute("user_id");
			/*
			 * 운행정보 수정
			 */
			Map<String, String> map00 = new HashMap<String, String>();
			map00.put("drv_no", drv_no);
			map00.put("std_dt", std_dt);
			map00.put("total_driving_dist", params.get("total_driving_dist").get(0));
			map00.put("auto_driving_dist", params.get("auto_driving_dist").get(0));
			map00.put("nomal_driving_dist", params.get("nomal_driving_dist").get(0));
			map00.put("reg_id", reg_id);
			//운행정보 등록
			LOG.debug(" @@@@@@@@@@@@@@ : 1");
			drvgService.updateDrvg(map00);
			LOG.debug(" @@@@@@@@@@@@@@ : 2");
			/*
			 * 자율주행 수정
			 */
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("drv_no", drv_no);
			map01.put("std_dt", std_dt);
			map01.put("reg_id", reg_id);
			map01.put("driving_dist_mon", params.get("dist_mon_1").get(0));
			map01.put("auto_driving_dist", params.get("dist_1").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 3");
			drvgService.updateAutoDriving(map01);
			map01.put("driving_dist_mon", params.get("dist_mon_2").get(0));
			map01.put("auto_driving_dist", params.get("dist_2").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 4");
			drvgService.updateAutoDriving(map01);
			map01.put("driving_dist_mon", params.get("dist_mon_3").get(0));
			map01.put("auto_driving_dist", params.get("dist_3").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 5");
			drvgService.updateAutoDriving(map01);
			map01.put("driving_dist_mon", params.get("dist_mon_4").get(0));
			map01.put("auto_driving_dist", params.get("dist_4").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 6");
			drvgService.updateAutoDriving(map01);
			map01.put("driving_dist_mon", params.get("dist_mon_5").get(0));
			map01.put("auto_driving_dist", params.get("dist_5").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 7");
			drvgService.updateAutoDriving(map01);
			map01.put("driving_dist_mon", params.get("dist_mon_6").get(0));
			map01.put("auto_driving_dist", params.get("dist_6").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 8");
			drvgService.updateAutoDriving(map01);
			/*
			 * 제어권전환 수정
			 */
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("drv_no", drv_no);
			map02.put("std_dt", std_dt);
			map02.put("reg_id", reg_id);
			map02.put("ctr_change_mon", params.get("chng_mon_1").get(0));
			map02.put("ctr_change_cnt", params.get("chng_1").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 9");
			drvgService.updateCtrChange(map02);
			map02.put("ctr_change_mon", params.get("chng_mon_2").get(0));
			map02.put("ctr_change_cnt", params.get("chng_2").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 10");
			drvgService.updateCtrChange(map02);
			map02.put("ctr_change_mon", params.get("chng_mon_3").get(0));
			map02.put("ctr_change_cnt", params.get("chng_3").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 11");
			drvgService.updateCtrChange(map02);
			map02.put("ctr_change_mon", params.get("chng_mon_4").get(0));
			map02.put("ctr_change_cnt", params.get("chng_4").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 12");
			drvgService.updateCtrChange(map02);
			map02.put("ctr_change_mon", params.get("chng_mon_5").get(0));
			map02.put("ctr_change_cnt", params.get("chng_5").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 13");
			drvgService.updateCtrChange(map02);
			map02.put("ctr_change_mon", params.get("chng_mon_6").get(0));
			map02.put("ctr_change_cnt", params.get("chng_6").get(0));
			LOG.debug(" @@@@@@@@@@@@@@ : 15");
			drvgService.updateCtrChange(map02);
			
			// 기존 제어권 전환 갯수 : chngLeng
			String chngLeng = params.get("chngLeng").get(0);
			// 입력 한 제어권 전환 총 합계
			chngS = Integer.parseInt(params.get("chng_s").get(0));
			
			if(chngS > 0) {
				int result_ctrchng = 0;
				Map<String, String> map03 = new HashMap<String, String>();
				map03.put("drv_no", drv_no);
				map03.put("std_dt", std_dt);
				map03.put("reg_id", reg_id);
				//삭제
				//int rst = drvgService.deleteCtrChangeDtl(map03);
				//if(rst > -1) {
					request.setAttribute("stnd_dt", std_dt);
					request.setAttribute("reg_id", reg_id);
					try {
						result = drvgService.excelUpload(request);
						if(result == null) result = "1";	
					} catch (Exception ex) {
						result = "0";
						model.addAttribute("result_update", result);
						return "duty/Duty_Drvg_Process";
					}
				//}
			}else {
				result = "3";
			}
			
			/*
			 * 제어권전환상세 삭제 후 등록
			 
			int result_ctrchng = 0;
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("drv_no", drv_no);
			map03.put("std_dt", std_dt);
			//삭제
			int rst = drvgService.deleteCtrChangeDtl(map03);
			if(rst > -1) {
				//등록
				map03.put("tmp_race_number", drv_no);
				map03.put("stnd_dt", std_dt);
				map03.put("reg_id", reg_id);
				List list_date = params.get("chg_date_d");
				List list_hour = params.get("chg_date_h");
				List list_min = params.get("chg_date_m");
				List list_sec = params.get("chg_date_s"); //초 추가
				List list_place = params.get("ctr_change_place");
				List list_cont = params.get("ctr_change_content");
				List list_rmk = params.get("rmk");
				if(list_date != null) {
					for(int i=0; i < list_date.size(); i++) {
						if(list_date.get(i) != null && !list_date.get(i).equals("")) {
							String ch_date = list_date.get(i) +""+ list_hour.get(i) +""+ list_min.get(i) +""+ list_sec.get(i);
							System.out.println("ch_date : "+ ch_date);
							map03.put("ctr_change_date", ch_date);
							map03.put("ctr_change_place", (String)list_place.get(i));
							map03.put("ctr_change_content", (String)list_cont.get(i));
							map03.put("rmk", (String)list_rmk.get(i));
							LOG.debug(" @@@@@@@@@@@@@@ : 20-"+i);
							drvgService.insertCtrChangeDtl(map03);
							LOG.debug(" @@@@@@@@@@@@@@ : 21-"+i);
							result_ctrchng++;
						}
					}
				}
			}
			model.addAttribute("result_ctrchng", String.valueOf(result_ctrchng));
			*/
			model.addAttribute("drv_no", drv_no);
			model.addAttribute("std_dt", std_dt);
		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 운행보고 수정 실패 : "+ e.toString());
			result = "0";
		}
		model.addAttribute("result_ctrchng", chngS);
		model.addAttribute("result_update", result);

		return "duty/Duty_Drvg_Process";
	}

	
	@RequestMapping(value = "Duty_Drvg_ExcelDown.do")
	public String drvgExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		return null;
	}
	
	
	
	/**
	 * 보고서 생성
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Excel_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Excel_Process.do")
	public String drvgPopExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		LOG.debug(" ########## Duty_Drvg_Excel_Process.do ###########");
		LOG.debug("       drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug("       std_dt["+paramMap.get("std_dt")+"]");

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

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);

		//엑셀파일 이름 변경
		String filenm_org = "excel_drvg.xlsx";
		String filenm_new = "excel_drvg_"+paramMap.get("drv_no")+".xlsx";
		//업로드 경로
		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		//경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOG.debug(" filePath_new["+filePath_new+"]");

		//엑셀 파일 정보 셋팅
		String result = DrvgExcel.drvgExcelMake(filePath_new, filenm_new, drvgInfo, drvList, chgList, chgDtlList);
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
	/*@RequestMapping(value = "excelTemplate.do")
	public void excelSampleDown(@RequestParam(name="drvgExcelSample", required=true ) String excelSample) throws Exception {
		String sampleAtchFileName = "";
		String originalAtchFileName = "";
		if("drvgExcelSample".equals(excelSample)) {
			sampleAtchFileName = "";
			
		}
	}*/
	
}
