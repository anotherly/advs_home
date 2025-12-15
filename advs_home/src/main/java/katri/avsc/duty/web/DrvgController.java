package katri.avsc.duty.web;

import java.io.File;
import java.io.IOException;
//import java.util.ArrayList;
import java.util.HashMap;
//import java.util.Iterator;
import java.util.List;
import java.util.Map;
//import java.util.Map.Entry;
import java.nio.file.Files;
import java.nio.file.Paths;

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

import org.apache.commons.lang3.StringUtils;
//import org.apache.commons.io.FilenameUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.DataFormatter;
//import org.apache.poi.ss.usermodel.Row;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
//import org.springframework.transaction.annotation.Transactional;
//import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.dao.DuplicateKeyException;

/**
 * 운행정보보고 > 운행정보 등록
 * 
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
	@Resource(name = "propertiesService") // 환경 설정
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Autowired
	private WebApplicationContext webApplicationContext;

	private String pathLetter = "";
	private String pathUpload = "";

	/**
	 * 목록을 조회한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_List.do")
	public String selectDrvgList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1; // 현재 페이지
		LOG.debug(" ########## Duty_Drvg_List.do 250103 ###########");
		LOG.debug(" searchType[" + paramMap.get("searchType") + "]");
		LOG.debug(" searchWord[" + paramMap.get("searchWord") + "]");
		LOG.debug("     userid[" + (String) session.getAttribute("user_id") + "]");

		/* 크로스사이트 체크 : S */
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		/* 크로스사이트 체크 : E */

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null|| auth_id.equals("") 
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
			) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		}
		/* URL접근 방지 : E */

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

		paramMap.put("userid", user_id); // 사용자id
		paramMap.put("authid", auth_id); // 권한

		List<?> drvgList = drvgService.selectDrvgList(paramMap);
		model.addAttribute("resultList", drvgList);

		int totCnt = drvgService.selectDrvgListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("param_id", "dirving_eff_date");
		Map<String, String> paramInfo = paraService.selectParaInfo(map01);

		// 기간체크
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
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Info.do")
	public String drvgInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Duty_Drvg_Info.do ###########");
		LOG.debug(" drv_no[" + paramMap.get("drv_no") + "]");
		LOG.debug(" std_dt[" + paramMap.get("std_dt") + "]");

		/* URL접근 방지 : S */
		// 기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			if (drvChk == 0 && !auth_id.equals("103")) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process.tiles";
			}
		}
		/* URL접근 방지 : E */

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		LOG.debug(drvgInfo);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);
		
		// ldk-custom
		Map<String, String> pdfFileInfo = drvgService.selectPDFFile(paramMap);
		String attach_file = pdfFileInfo != null ? pdfFileInfo.get("attachFile") : "";		

		model.addAttribute("pdf_info", pdfFileInfo);
		// ldk-custom-end
		
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
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_IsExist.do")
	public String drvgIsExist(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)
			throws Exception {

		LOG.debug(" ########## Duty_Drvg_IsExist.do ###########");
		LOG.debug("    drv_no[" + paramMap.get("drv_no") + "]");
		LOG.debug(" stnd_dt_y[" + paramMap.get("stnd_dt_y") + "]");
		LOG.debug(" stnd_dt_d[" + paramMap.get("stnd_dt_d") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		}
		/* URL접근 방지 : E */

		String stnd_dt = paramMap.get("stnd_dt_y") + "" + paramMap.get("stnd_dt_d");
		paramMap.put("std_dt", stnd_dt);
		int result = drvgService.selectDrvgIsExist(paramMap);

		model.addAttribute("result_exist", result);

		return "duty/Duty_Drvg_IsExist_Process";
	}

	/**
	 * 등록 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Inst.do")
	public String drvgInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Duty_Drvg_Inst.do ###########");

		/* URL접근 방지 : S */
		// 기간체크
		int drvChk = drvgService.selectDrvgIsCheck(paramMap);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			// 잠시 개발을 위한 주석처리
//			if(drvChk == 0) {
//				model.addAttribute("rst_scrn", "drvg");
//				model.addAttribute("rst_user", user_id);
//				model.addAttribute("rst_auth", auth_id);
//				return "common/Auth_Process.tiles";
//			}
		}
		/* URL접근 방지 : E */

		Map<String, String> map_01 = new HashMap<String, String>();
		if (auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String) session.getAttribute("user_id"));
		}

		List<?> code_tempoper = codeService.selectTempOperList(map_01);
		List<?> ctrChange = codeService.selectCtrChangeCodeList(null);
		Map<String, String> attachFile = drvgService.selectAttachFileList();
		
		model.addAttribute("attachFile", attachFile);
		model.addAttribute("code_tempoper", code_tempoper);
		model.addAttribute("ctr_change", ctrChange);
		
		return "duty/Duty_Drvg_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * 
	 * @param params - 조회할 정보가 담긴 list
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	// @Transactional(rollbackFor =Exception.class)
	@RequestMapping(value = "Duty_Drvg_Inst_Process.do")
	public String drvgInsertProcess(@RequestParam MultiValueMap<String, String> params,
			MultipartHttpServletRequest request, RedirectAttributes redirectAttributes, ModelMap model,
			HttpSession session) throws Exception {
		String result = "1"; // 결과
		
		LOG.debug(" ########## Duty_Drvg_Inst_Process.do ###########");
		LOG.debug("    tmp_race_number[" + params.get("tmp_race_number").get(0) + "]");
		// LOG.debug(" stnd_dt_y["+params.get("stnd_dt_y").get(0)+"]");
		// LOG.debug(" stnd_dt_d["+params.get("stnd_dt_d").get(0)+"]");
		LOG.debug("            stnd_dt[" + params.get("stnd_dt").get(0) + "]");
		LOG.debug("    tmp_race_agency[" + params.get("tmp_race_agency").get(0) + "]");
		// LOG.debug(" ins_letter_number["+params.get("ins_letter_number").get(0)+"]");
		LOG.debug("      ins_init_date[" + params.get("ins_init_date_view").get(0) + "]");
		LOG.debug("      ins_init_date[" + params.get("ins_init_date").get(0) + "]");
		LOG.debug(" total_driving_dist[" + params.get("total_driving_dist").get(0) + "]");
		LOG.debug("  auto_driving_dist[" + params.get("auto_driving_dist").get(0) + "]");
		LOG.debug(" nomal_driving_dist[" + params.get("nomal_driving_dist").get(0) + "]");
		for (int i = 1; i <= 6; i++) {
		    LOG.debug(String.format("         dist_mon_%d[%s]", i, params.get("dist_mon_" + i).get(0)));
		}
		for (int i = 1; i <= 6; i++) {
		    LOG.debug(String.format("         chng_mon_%d[%s]", i, params.get("chng_mon_" + i).get(0)));
		}
		for (int i = 1; i <= 6; i++) {
		    LOG.debug(String.format("             dist_%d[%s]", i, params.get("dist_" + i).get(0)));
		}
		for (int i = 1; i <= 6; i++) {
		    LOG.debug(String.format("             chng_%d[%s]", i, params.get("chng_" + i).get(0)));
		}
		LOG.debug("             chng_s[" + params.get("chng_s").get(0) + "]");
		LOG.debug("             reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		// 기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			// >>실서버 반영시 확인
			// 로컬 등록 테스트를 위해 주석처리
			/*
			 * if(drvChk == 0) { model.addAttribute("rst_scrn", "drvg");
			 * model.addAttribute("rst_user", user_id); model.addAttribute("rst_auth",
			 * auth_id); return "common/Auth_Process.tiles"; }
			 */
		}
		/* URL접근 방지 : E */
		int chngS = 0;

		try {
			String tmp_race_number = params.get("tmp_race_number").get(0);
			String stnd_dt = params.get("stnd_dt").get(0);
			String tmp_race_agency = params.get("tmp_race_agency").get(0);
			String reg_id = (String) session.getAttribute("user_id");

			/*
			 * 운행정보 등록
			 */
			Map<String, String> map00 = new HashMap<String, String>();
			map00.put("tmp_race_number", tmp_race_number);
			map00.put("stnd_dt", stnd_dt);
			map00.put("tmp_race_agency", tmp_race_agency);
			// map00.put("ins_letter_number", params.get("ins_letter_number").get(0));
			map00.put("ins_init_date", params.get("ins_init_date_view").get(0));
			map00.put("total_driving_dist", params.get("total_driving_dist").get(0));
			map00.put("auto_driving_dist", params.get("auto_driving_dist").get(0));
			map00.put("nomal_driving_dist", params.get("nomal_driving_dist").get(0));
			map00.put("reg_id", reg_id);
			// 운행정보 등록
			LOG.debug(" @@@@@@@@@@@@@@ : 1");
			LOG.debug(map00);
			drvgService.insertDrvg(map00);
			LOG.debug(" @@@@@@@@@@@@@@ : 2");
			/*
			 * 자율주행 등록
			 */
			String stndDt = params.get("stnd_dt").get(0).substring(0, 4);
			
			Map<String, String> map01 = new HashMap<String, String>();
			map01.put("tmp_race_number", tmp_race_number);
			map01.put("stnd_dt", stnd_dt);
			map01.put("reg_id", reg_id);
			for (int i = 1; i <= 6; i++) {
			    String dist_mon = stndDt + params.get("dist_mon_" + i).get(0);
			    map01.put("driving_dist_mon", dist_mon);
			    map01.put("auto_driving_dist", params.get("dist_" + i).get(0));
			    LOG.debug(" @@@@@@@@@@@@@@ : " + (i + 2)); // 3 4 5 6 7 8
			    drvgService.insertAutoDriving(map01);
			}
			/*  반복문으로 간결화 시킨 코드 내용
				String dist_mon_1 = stndDt + params.get("dist_mon_1").get(0);
				String dist_mon_2 = stndDt + params.get("dist_mon_2").get(0);
				String dist_mon_3 = stndDt + params.get("dist_mon_3").get(0);
				String dist_mon_4 = stndDt + "" + params.get("dist_mon_4").get(0);
				String dist_mon_5 = stndDt + "" + params.get("dist_mon_5").get(0);
				String dist_mon_6 = stndDt + "" + params.get("dist_mon_6").get(0);

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
			*/
			
			/*
			 * 제어권전환 등록
			 */
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("tmp_race_number", tmp_race_number);
			map02.put("stnd_dt", stnd_dt);
			map02.put("reg_id", reg_id);
			for (int i = 1; i <= 6; i++) {
			    String chng_mon = stndDt + params.get("chng_mon_" + i).get(0);
			    map02.put("ctr_change_mon", chng_mon);
			    map02.put("ctr_change_cnt", params.get("chng_" + i).get(0));
			    LOG.debug(" @@@@@@@@@@@@@@ : " + (i + 8));
			    drvgService.insertCtrChange(map02);
			}

			/*  반복문으로 간결화한 코드 내용
				String chng_mon_1 = stndDt + params.get("chng_mon_1").get(0);
				String chng_mon_2 = stndDt + params.get("chng_mon_2").get(0);
				String chng_mon_3 = stndDt + params.get("chng_mon_3").get(0);
				String chng_mon_4 = stndDt + params.get("chng_mon_4").get(0);
				String chng_mon_5 = stndDt + params.get("chng_mon_5").get(0);
				String chng_mon_6 = stndDt + params.get("chng_mon_6").get(0);

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
			*/
			chngS = Integer.parseInt(params.get("chng_s").get(0));
			if (chngS > 0) {
				try {
					result = drvgService.excelUpload(request);
					if (result == null)
						result = "1";
				} catch (Exception ex) {
					result = "0";
					model.addAttribute("result_insert", result);
				}
			}

			/*
			 * 제어권전환상세 등록 int result_ctrchng = 0; Map<String, String> map03 = new
			 * HashMap<String, String>(); map03.put("tmp_race_number", tmp_race_number);
			 * map03.put("stnd_dt", stnd_dt); map03.put("reg_id", reg_id); List list_date =
			 * params.get("chg_date_d"); List list_hour = params.get("chg_date_h"); List
			 * list_min = params.get("chg_date_m"); List list_place =
			 * params.get("ctr_change_place"); List list_cont =
			 * params.get("ctr_change_content"); List list_rmk = params.get("rmk");
			 * if(list_date != null) { for(int i=0; i < list_date.size(); i++) {
			 * if(list_date.get(i) != null && !list_date.get(i).equals("")) { String ch_date
			 * = list_date.get(i) +""+ list_hour.get(i) +""+ list_min.get(i);
			 * map03.put("ctr_change_date", ch_date); map03.put("ctr_change_place",
			 * (String)list_place.get(i)); map03.put("ctr_change_content",
			 * (String)list_cont.get(i)); map03.put("rmk", (String)list_rmk.get(i));
			 * LOG.debug(" @@@@@@@@@@@@@@ : 20-"+i); drvgService.insertCtrChangeDtl(map03);
			 * LOG.debug(" @@@@@@@@@@@@@@ : 21-"+i); result_ctrchng++; } } }
			 * model.addAttribute("result_ctrchng", String.valueOf(result_ctrchng));
			 */
			
			/* ldk-custom */
			LOG.debug("##################ldk-custom-check-start######################################################################");
			pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
			pathUpload = propertiesService.getString("pathUpload");

			LOG.debug("\n     fileInfo[" + params.get("filename") + "]\n");
			LOG.debug("\n     pathLetter[" + pathLetter + "]\n");
			LOG.debug("\n     pathUpload[" + pathUpload + "]\n");

			// 데이터첨부파일(변경)
			Map<String, String> map_d = new HashMap<String, String>();
			Map<String, MultipartFile> files = request.getFileMap();
			
			LOG.debug("\n     files: " + files);
			
			String filePath = pathUpload+"duty"+pathLetter;
			String fileSize = files.get("file_info").getSize() + "";
			String fileName = files.get("file_info").getOriginalFilename();

			if (fileName != null && fileName.length() > 0) {
				LOG.debug("fileName: " + fileName);
				LOG.debug("fileNameLength: " + fileName.length());
				
				/* 파일 확장자 체크 : S */
				boolean bExt_03 = Util.fileExtCheck(fileName);				
				if (!bExt_03) {
					model.addAttribute("result_insert", "ext");
					return "duty/Duty_Drvg_Process";
				}
				/* 파일 확장자 체크 : E */
				
				if (bExt_03) {
					String fullPath = filePath;
					int cut1 = StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1;
					// String dirPath = fullPath.substring(0, cut1);
					String origName = fullPath.substring(cut1);
					String findStr = tmp_race_number + "_" + stnd_dt;
					String upldName = "";
					String destDir = fullPath;
					String newFileNm = tmp_race_number + "_" + stnd_dt + "_";
					if (fileName.indexOf(findStr) > -1) {
						upldName = fileName;
					} else {
						upldName = newFileNm + fileName;
					}
					
					LOG.debug("----------updlName: " + upldName);
					LOG.debug("ldk-custom-check9 file_type: " + params.get("file_type"));
					
					FileUtil.transferUploadFileNew(files.get("file_info"), destDir, newFileNm);
					map_d.put("tmp_race_number", tmp_race_number);
					map_d.put("stnd_dt", stnd_dt);
					map_d.put("attach_file", upldName);
					params.add("attach_file", upldName);
					map_d.put("file_path", origName);
					map_d.put("file_size", fileSize);
					map_d.put("file_type",
							// MultiValueMap<String,String>은 NULL에 대하여 에러를 return하여 메소드 실행이 중단되므로 삼항연산자를 통해 value 또는 NULL을 넣어준다.
							(params.get("file_type") != null && !params.get("file_type").isEmpty()) ? params.get("file_type").get(0) : "NULL"
					);
					LOG.debug("----------map_d: " + map_d);
					drvgService.insertPDFFile(map_d);
					LOG.debug("---------------------첨부파일 등록 성공------------------");
				}
			}
			params.add("reg_id", (String) session.getAttribute("user_id"));
			/* ldk-custom-end */
			
		} catch (DuplicateKeyException e) {
			// TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			LOG.error(e.toString());
			result = "DuplicateKeyException";
		} catch (RuntimeException e) {
			LOG.error(e.toString());
			result = "0";
		} catch (Exception e) {
			// TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			LOG.error("[DB Exception] 운행보고 등록 실패 : " + e.toString());
			result = "0";
		}
		// ldk-custom-end

		model.addAttribute("result_ctrchng", chngS);
		model.addAttribute("result_insert", result);
		return "duty/Duty_Drvg_Process";
	}

	/**
	 * 삭제한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Delt_Process.do")
	public String drvgDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)
			throws Exception {

		int result = 1; // 결과

		LOG.debug(" ########## Duty_Drvg_Delt_Process.do ###########");
		LOG.debug("    drv_no[" + paramMap.get("drv_no") + "]");
		LOG.debug("    std_dt[" + paramMap.get("std_dt") + "]");
		
		// ldk-custom
		LOG.debug(" paramMap[" + paramMap + "]");
		try {
			Map<String, String> pdfFileInfo = drvgService.selectPDFFile(paramMap);
			String pdfFilePath = pdfFileInfo.get("filePath") + pdfFileInfo.get("attachFile");
			LOG.debug("---------------------------------------pdfFilePath: " + pdfFilePath);
			Files.deleteIfExists(Paths.get(pdfFilePath));
		} catch(Exception e) {
				LOG.debug(e);
		}
		// ldk-custom-end

		/* URL접근 방지 : S */
		// 기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			// 등록기간 아닙니다 일단 피하기 잠시 개발을 위한 주석처리
			/*if (drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process.tiles";
			}*/
		}
		/* URL접근 방지 : E */

		result = drvgService.deleteCtrChangeDtl(paramMap);
		if (result > -1) {
			result = drvgService.deleteCtrChange(paramMap);
			if (result > -1) {
				result = drvgService.deleteAutoDriving(paramMap);
				if (result > -1)
					result = drvgService.deleteDrvg(paramMap);
				else
					result = -1;
			} else {
				result = -1;
			}
		} else {
			result = -1;
		}
		LOG.debug(" result[" + result + "]");		
		
		model.addAttribute("result_delete", result);

		return "duty/Duty_Drvg_Process";
	}

	/**
	 * 수정 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Drvg_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Updt.do")
	public String drvgUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Duty_Drvg_Updt.do ###########");
		LOG.debug(" drv_no[" + paramMap.get("drv_no") + "]");
		LOG.debug(" std_dt[" + paramMap.get("std_dt") + "]");

		/* URL접근 방지 : S */
		// 기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			// 잠시 개발을 위한 주석처리
			/*if (drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process.tiles";
			}*/
		}
		/* URL접근 방지 : E */

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);
		LOG.debug(" chgDtlList[" + chgDtlList + "]");

		Map<String, String> map_01 = new HashMap<String, String>();
		if (auth_id.equals("103")) {
			map_01.put("userid", "");
		} else {
			map_01.put("userid", (String) session.getAttribute("user_id"));
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
	 * 
	 * @param params - 조회할 정보가 담긴 list
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Updt_Process.do")
	public String drvgUpdateProcess(@RequestParam MultiValueMap<String, String> params, ModelMap model, @RequestParam Map<String, String> paramMap,
			MultipartHttpServletRequest request, HttpSession session) throws Exception {

		System.out.println("\n--- Duty_Drvg_Updt Process (운행보고서 수정 프로세스 과정)--------\n");

		String result = "1"; // 결과

		LOG.debug(" ########## Duty_Drvg_Updt_Process.do ###########");
		LOG.debug("             drv_no[" + params.get("drv_no").get(0) + "]");
		LOG.debug("             std_dt[" + params.get("std_dt").get(0) + "]");
		LOG.debug(" total_driving_dist[" + params.get("total_driving_dist").get(0) + "]");
		LOG.debug("  auto_driving_dist[" + params.get("auto_driving_dist").get(0) + "]");
		LOG.debug(" nomal_driving_dist[" + params.get("nomal_driving_dist").get(0) + "]");
		LOG.debug("         dist_mon_1[" + params.get("dist_mon_1").get(0) + "]");
		LOG.debug("         dist_mon_2[" + params.get("dist_mon_2").get(0) + "]");
		LOG.debug("         dist_mon_3[" + params.get("dist_mon_3").get(0) + "]");
		LOG.debug("         dist_mon_4[" + params.get("dist_mon_4").get(0) + "]");
		LOG.debug("         dist_mon_5[" + params.get("dist_mon_5").get(0) + "]");
		LOG.debug("         dist_mon_6[" + params.get("dist_mon_6").get(0) + "]");
		LOG.debug("         chng_mon_1[" + params.get("chng_mon_1").get(0) + "]");
		LOG.debug("         chng_mon_2[" + params.get("chng_mon_2").get(0) + "]");
		LOG.debug("         chng_mon_3[" + params.get("chng_mon_3").get(0) + "]");
		LOG.debug("         chng_mon_4[" + params.get("chng_mon_4").get(0) + "]");
		LOG.debug("         chng_mon_5[" + params.get("chng_mon_5").get(0) + "]");
		LOG.debug("         chng_mon_6[" + params.get("chng_mon_6").get(0) + "]");
		LOG.debug("             dist_1[" + params.get("dist_1").get(0) + "]");
		LOG.debug("             dist_2[" + params.get("dist_2").get(0) + "]");
		LOG.debug("             dist_3[" + params.get("dist_3").get(0) + "]");
		LOG.debug("             dist_4[" + params.get("dist_4").get(0) + "]");
		LOG.debug("             dist_5[" + params.get("dist_5").get(0) + "]");
		LOG.debug("             dist_6[" + params.get("dist_6").get(0) + "]");
		LOG.debug("             chng_1[" + params.get("chng_1").get(0) + "]");
		LOG.debug("             chng_2[" + params.get("chng_2").get(0) + "]");
		LOG.debug("             chng_3[" + params.get("chng_3").get(0) + "]");
		LOG.debug("             chng_4[" + params.get("chng_4").get(0) + "]");
		LOG.debug("             chng_5[" + params.get("chng_5").get(0) + "]");
		LOG.debug("             chng_6[" + params.get("chng_6").get(0) + "]");
		LOG.debug("             reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		// 기간체크
		Map<String, String> mapDv = new HashMap<String, String>();
		int drvChk = drvgService.selectDrvgIsCheck(mapDv);

		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		} else {
			// 잠시 개발을 위한 주석처리
			/*if (drvChk == 0) {
				model.addAttribute("rst_scrn", "drvg");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process.tiles";
			}*/
		}
		/* URL접근 방지 : E */
		
		int chngS = 0;
		
		try {
			String drv_no = params.get("drv_no").get(0);
			String std_dt = params.get("std_dt").get(0);
			// String tmp_race_agency = params.get("tmp_race_agency").get(0);
			String reg_id = (String) session.getAttribute("user_id");
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
			map00.put("ins_init_date", params.get("ins_init_date").get(0));
			// 운행정보 등록
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

			LOG.debug("\n\n--- End of Duty_Drvg_Updt Process (운행정보 보고서 수정 로그 완료) ---\n");

			// 기존 제어권 전환 갯수 : chngLeng
//			String chngLeng = params.get("chngLeng").get(0);
			// 입력 한 제어권 전환 총 합계
			chngS = Integer.parseInt(params.get("chng_s").get(0));

			if (chngS > 0) {
//				int result_ctrchng = 0;
				Map<String, String> map03 = new HashMap<String, String>();
				map03.put("drv_no", drv_no);
				map03.put("std_dt", std_dt);
				map03.put("reg_id", reg_id);
				// 삭제
				// int rst = drvgService.deleteCtrChangeDtl(map03);
				// if(rst > -1) {
				request.setAttribute("stnd_dt", std_dt);
				request.setAttribute("reg_id", reg_id);
				try {
					//2025.01.07
					//첨부파일을 업로드 한 경우에만 진행
					//(기존에 등록에서 엑셀첨부했다고 가정)
				    List<MultipartFile> fileList = request.getFiles("excelFile");
				    if(fileList.size() > 0 && !fileList.get(0).getOriginalFilename().equals("")){
				    	result = drvgService.excelUpload(request);
				    }
					if (result == null)
						result = "1";
				} catch (Exception ex) {
					result = "0";
					model.addAttribute("result_update", result);
					return "duty/Duty_Drvg_Process";
				}
				// }
			} else {
				result = "3";
			}

			/*
			 * 제어권전환상세 삭제 후 등록
			 * 
			 * int result_ctrchng = 0; Map<String, String> map03 = new HashMap<String,
			 * String>(); map03.put("drv_no", drv_no); map03.put("std_dt", std_dt); //삭제 int
			 * rst = drvgService.deleteCtrChangeDtl(map03); if(rst > -1) { //등록
			 * map03.put("tmp_race_number", drv_no); map03.put("stnd_dt", std_dt);
			 * map03.put("reg_id", reg_id); List list_date = params.get("chg_date_d"); List
			 * list_hour = params.get("chg_date_h"); List list_min =
			 * params.get("chg_date_m"); List list_sec = params.get("chg_date_s"); //초 추가
			 * List list_place = params.get("ctr_change_place"); List list_cont =
			 * params.get("ctr_change_content"); List list_rmk = params.get("rmk");
			 * if(list_date != null) { for(int i=0; i < list_date.size(); i++) {
			 * if(list_date.get(i) != null && !list_date.get(i).equals("")) { String ch_date
			 * = list_date.get(i) +""+ list_hour.get(i) +""+ list_min.get(i) +""+
			 * list_sec.get(i); System.out.println("ch_date : "+ ch_date);
			 * map03.put("ctr_change_date", ch_date); map03.put("ctr_change_place",
			 * (String)list_place.get(i)); map03.put("ctr_change_content",
			 * (String)list_cont.get(i)); map03.put("rmk", (String)list_rmk.get(i));
			 * LOG.debug(" @@@@@@@@@@@@@@ : 20-"+i); drvgService.insertCtrChangeDtl(map03);
			 * LOG.debug(" @@@@@@@@@@@@@@ : 21-"+i); result_ctrchng++; } } } }
			 * model.addAttribute("result_ctrchng", String.valueOf(result_ctrchng));
			 */
			model.addAttribute("drv_no", drv_no);
			model.addAttribute("std_dt", std_dt);
		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 운행보고 수정 실패 : " + e.toString());
			result = "0";
		}
		
		/*ldk-custom*/
		try {
			Map<String, String> pdfFileInfo = drvgService.selectPDFFile(paramMap);
			LOG.debug("---------------------------------------pdfFileInfo: " + pdfFileInfo);
			String drv_no = params.get("drv_no").get(0);
			String std_dt = params.get("std_dt").get(0);
			String modified_std_dt = std_dt.substring(0, std_dt.length() - 6);
			String filePath = pathUpload+"duty"+pathLetter;
			
			Map<String, MultipartFile> files = request.getFileMap();
			String fileSize = files.get("file_info").getSize() + "";
			String fileName = files.get("file_info").getOriginalFilename();

			pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
			pathUpload = propertiesService.getString("pathUpload");
			
			Map<String, String> simpleParams = new HashMap<>();
			for (Map.Entry<String, List<String>> entry : params.entrySet()) {
				// 리스트의 첫 번째 값을 Map에 저장
				simpleParams.put(entry.getKey(), entry.getValue().get(0));
			}
			
			// if -> 현재 등록된 첨부파일이 없다면
			if (pdfFileInfo == null) {
				LOG.debug("\n     fileInfo[" + params.get("filename") + "]\n");
				LOG.debug("-----------------------------------첨부파일 없으면 첨부파일 추가하기");
				LOG.debug(pathLetter);
				LOG.debug(pathUpload);
				LOG.debug("----------simpleParams: " + simpleParams);

				// 데이터첨부파일(변경)
				Map<String, String> map_d = new HashMap<String, String>();
				
				LOG.debug(files);				
				LOG.debug("----------filePath: " + filePath + " ----------fileSize: " + fileSize + " ----------file_info: "	+ fileName);

				if (fileName != null && fileName.length() > 0) {
					LOG.debug("fileName: " + fileName);
					LOG.debug("fileNameLength: " + fileName.length());
					/* 파일 확장자 체크 : S */
					boolean bExt_03 = Util.fileExtCheck(fileName);
					LOG.debug(bExt_03);
					if (!bExt_03) {
						model.addAttribute("result_insert", "ext");
						return "duty/Duty_Drvg_Process";
					}
					/* 파일 확장자 체크 : E */
					if (bExt_03) {
						String fullPath = filePath;
						int cut1 = StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1;
						// String dirPath = fullPath.substring(0, cut1);
						String origName = fullPath.substring(cut1);
						String findStr = drv_no + "_" + modified_std_dt;
						String upldName = "";
						if (fileName.indexOf(findStr) > -1) {
							upldName = fileName;
						} else {
							upldName = drv_no + "_" + modified_std_dt + "_" + fileName;
						}
						LOG.debug("----------updlName: " + upldName);
						String destDir = fullPath;
						String newFileNm = drv_no + "_" + modified_std_dt + "_";
						FileUtil.transferUploadFileNew(files.get("file_info"), destDir, newFileNm);
						map_d.put("tmp_race_number", drv_no);
						map_d.put("stnd_dt", modified_std_dt);
						map_d.put("attach_file", upldName);
						map_d.put("file_path", origName);
						map_d.put("file_size", fileSize);
						map_d.put("file_type",
								// MultiValueMap<String,String>은 NULL에 대하여 에러를 return하여 메소드 실행이 중단되므로 삼항연산자를 통해
								// value 또는 NULL을 넣어준다.
								(params.get("file_type") != null && !params.get("file_type").isEmpty())
										? params.get("file_type").get(0)
										: "NULL");
						params.add("attach_file", upldName);
						LOG.debug("----------pdfFileInfo: " + pdfFileInfo);
						LOG.debug("----------map_d: " + map_d);
						drvgService.insertPDFFile(map_d);
						LOG.debug("---------------------첨부파일 등록 성공------------------");
					}
				}
	        } else { // else -> 현재 등록된 첨부파일이 있다면
				Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
				Map<String, String> map_pdf = new HashMap<String, String>();
				map_pdf.put("drv_no", drv_no);
				map_pdf.put("std_dt", std_dt);
				
				LOG.debug("---------------------------------------drvgInfo: " + drvgInfo);
				LOG.debug("-----------------------------------pdfFileInfo: " + pdfFileInfo);
				LOG.debug("---------------------------------------map_pdf: " + map_pdf);
				
				if (fileName != null && fileName.length() > 0) {
					LOG.debug("fileName: " + fileName);
					LOG.debug("fileNameLength: " + fileName.length());
					/* 파일 확장자 체크 : S */
					boolean bExt_03 = Util.fileExtCheck(fileName);
					LOG.debug(bExt_03);
					if (!bExt_03) {
						model.addAttribute("result_insert", "ext");
						return "duty/Duty_Drvg_Process";
					}
					/* 파일 확장자 체크 : E */
					if (bExt_03) {
						String fullPath = filePath;
						String findStr = drv_no + "_" + modified_std_dt;
						String destDir = fullPath;
						String newFileNm = drv_no + "_" + modified_std_dt + "_";						
						String pdfFilePath = pdfFileInfo.get("filePath") + pdfFileInfo.get("attachFile");

						String upldName = "";
						if (fileName.indexOf(findStr) > -1) {
							upldName = fileName;
						} else {
							upldName = drv_no + "_" + modified_std_dt + "_" + fileName;
						}
						
						LOG.debug("----------updlName: " + upldName);
						map_pdf.put("pdf_file", upldName);
						params.add("attach_file", upldName);
						LOG.debug("---------------------------------------pdfFilePath: " + pdfFilePath);
						Files.deleteIfExists(Paths.get(pdfFilePath));
						LOG.debug("-----------------------pdf파일 삭제 성공");
						
						FileUtil.transferUploadFileNew(files.get("file_info"), destDir, newFileNm);
						drvgService.updatePDFFile(map_pdf);
						LOG.debug("----------pdfFileInfo: " + pdfFileInfo);
						LOG.debug("---------------------새로운 첨부파일 등록 성공------------------");
					}
				}
				else {
					LOG.debug("---------------------기존 첨부파일 유지됨------------------");
				}
	        }
		} catch (Exception e) {
			LOG.error("-------------------------------PDF 수정 Process 오류: "+ e);
		}
		/*ldk-custom-end*/
		model.addAttribute("result_ctrchng", chngS);
		model.addAttribute("result_update", result);

		return "duty/Duty_Drvg_Process";
	}

	@RequestMapping(value = "Duty_Drvg_ExcelDown.do")
	public String drvgExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		return null;
	}

	/**
	 * 보고서 생성
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Excel_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Drvg_Excel_Process.do")
	public String drvgPopExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		LOG.debug(" ########## Duty_Drvg_Excel_Process.do ###########");
		LOG.debug("       drv_no[" + paramMap.get("drv_no") + "]");
		LOG.debug("       std_dt[" + paramMap.get("std_dt") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")
				//2025.01.03 ts  측 요청사항으로
				// 등급 별 권한체크 해제
				/*|| auth_id.equals("101")
				|| auth_id.equals("102")*/
				) {
			model.addAttribute("rst_scrn", "duty");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process.tiles";
		}
		/* URL접근 방지 : E */

		Map<String, String> drvgInfo = drvgService.selectDrvgInfo(paramMap);
		List<?> drvList = drvgService.selectAutoDrivingList(paramMap);
		List<?> chgList = drvgService.selectCtrChangeList(paramMap);
		List<?> chgDtlList = drvgService.selectCtrChangeDtlList(paramMap);

		// 엑셀파일 이름 변경
//		String filenm_org = "excel_drvg.xlsx";
		String filenm_new = "excel_drvg_" + paramMap.get("drv_no") + ".xlsx";
		// 업로드 경로
//		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		// 경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOG.debug(" filePath_new[" + filePath_new + "]");

		// 엑셀 파일 정보 셋팅
		String result = DrvgExcel.drvgExcelMake(filePath_new, filenm_new, drvgInfo, drvList, chgList, chgDtlList);
		LOG.debug("       result[" + result + "]");

		if (result.equals("1")) {
			LOG.debug(" ########## File_Download ###########");
			try {
				String checkFile = filePath_new; // 잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
			} catch (RuntimeException e1) {
				LOG.info("[Download File] 실패0 : ");
			}
			String filename = filePath_new;

			File file = new File(filename);
			LOG.debug(" ########## Download File : File Name [" + filename + "], File Length [" + file.length() + "] ");
			try {
				if (file.exists()) {
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
	/*
	 * @RequestMapping(value = "excelTemplate.do") public void
	 * excelSampleDown(@RequestParam(name="drvgExcelSample", required=true ) String
	 * excelSample) throws Exception { String sampleAtchFileName = ""; String
	 * originalAtchFileName = ""; if("drvgExcelSample".equals(excelSample)) {
	 * sampleAtchFileName = "";
	 * 
	 * } }
	 */

}
