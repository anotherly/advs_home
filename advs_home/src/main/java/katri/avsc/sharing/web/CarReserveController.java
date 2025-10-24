package katri.avsc.sharing.web;

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

import org.apache.commons.lang3.StringUtils;
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
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;
import katri.avsc.sharing.service.CarReserveService;
import katri.avsc.vise.service.ViseService;

/**
 * 게시판 > 자율주행 최신동향
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/sharing/car")
public class CarReserveController {

	/** EgovSampleService */
	@Resource(name = "carReserveService")
	CarReserveService carReserveService;

	private static final Log LOG = LogFactory.getLog(CarReserveController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;
	
	@Resource(name = "viseService")
	ViseService viseService;
	
	String pathLetter = "";
	String pathUpload = "";
	String path_d = "C:\\eGovFrame\\src\\AVSC\\src\\main\\webapp\\upload\\sharing\\"; // 협의체(개발)
	
	/**
	 * 차량예약 메인을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "CarReserveList"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_Main.do")
	public String selectCarReserveMain(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		return "sharing/Car_Reserve_Main.tiles";
	}
	
	@RequestMapping(value = "Car_Reserve_SelectList.do")
	public ModelAndView selectReserve(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		/* 크로스사이트 체크 : S */
		String searchType = paramMap.get("searchType");
		searchType = Util.injectionCheck(searchType);
		paramMap.put("searchType", searchType);
		String searchWord = paramMap.get("searchWord");
		searchWord = Util.injectionCheck(searchWord);
		paramMap.put("searchWord", searchWord);
		/* 크로스사이트 체크 : E */

		List<?> carReserveList = carReserveService.selectReserveList(paramMap);
		model.addAttribute("resultList", carReserveList);
		LOG.debug(" @@@@@@@@@@@@@@@@@carReserveList["+carReserveList+"]");
		
		int totCnt = carReserveService.selectCarReserveListTotCnt(paramMap);
		model.addAttribute("totCnt", totCnt);

		return mav;
	}
	
	/**
	 * 목록을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "CarReserveList"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_List.do")
	public String selectCarReserveList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## CarReserveList.do ###########");
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

		/* pageing setting */
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

		List<?> carReserveList = carReserveService.selectCarReserveList(paramMap);
		model.addAttribute("resultList", carReserveList);
		LOG.debug(" @@@@@@@@@@@@@@@@@carReserveList["+carReserveList+"]");
		
		int totCnt = carReserveService.selectCarReserveListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));

		return "sharing/Car_Reserve_List.tiles";
	}

	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Board_carReserve_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_View.do")
	public String carReserveInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Car_Reserve_View.do ###########");
		LOG.debug("    reservation_number["+paramMap.get("reservationNumber")+"]");

		Map<String, String> carReserveInfo = carReserveService.selectCarReserveInfo(paramMap);
		if(carReserveInfo.get("attachFile") != null) {
			List<?> attachFileList = carReserveService.selectAttachFileList(paramMap);
			model.addAttribute("attachFileList", attachFileList);
		}
		model.addAttribute("carReserveInfo", carReserveInfo);

		return "sharing/Car_Reserve_View.tiles";
	}
	/**
	 * 차량플랫폼 예약 등록 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Car_Reserve_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_Inst.do")
	public String carReserveInsert(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);
		
		String rtnStr = ""; // 반환주소

		LOG.debug(" ########## Car_Reserve_View.do ###########");
		LOG.debug("     reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		/*
		 * if (user_id == null || user_id.equals("") || auth_id == null ||
		 * auth_id.equals("")) { model.addAttribute("rst_scrn", "sharing");
		 * model.addAttribute("rst_user", user_id); model.addAttribute("rst_auth",
		 * auth_id); return "common/Auth_Process"; }
		 */
		/* URL접근 방지 : E */

		
		//협의체 메뉴를 위한 분기처리
			
//		Map<String, String> map_00 = new HashMap<String, String>();
//		map_00.put("bbs_group_seq", "1000");
//		List<?> bbs_list = codeService.selectBbsList(map_00);
//		model.addAttribute("bbs_list", bbs_list);
//		if (bbs_seq == null || bbs_seq.equals("")) {
//			if (bbs_list != null) {
//				EgovMap egovMap = (EgovMap) bbs_list.get(0);
//				bbs_seq = Util.nvl(String.valueOf(egovMap.get("bbsSeq")));
//			}
//		}
//		paramMap.put("bbs_seq", bbs_seq);
		
//		Map<String, String> map01 = new HashMap<String, String>();
//		map01.put("codeid", scenarioCode1);
//		Map<String, String> map02 = new HashMap<String, String>();
//		map02.put("codeid", scenarioCode2);
//		Map<String, String> map03 = new HashMap<String, String>();
//		map03.put("codeid", scenarioCode3);
//		Map<String, String> map04 = new HashMap<String, String>();
//		map04.put("codeid", "autocar_driving_mode");
		// Map<String, String> map05 = new HashMap<String, String>();
		// map05.put("bbs_group_seq", "1000");
		
//		List<?> scenario_code1 = codeService.selectSubCodeList(map01);
//		List<?> scenario_code2 = codeService.selectSubCodeList(map02);
//		List<?> scenario_code3 = codeService.selectSubCodeList(map03);
//		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
//		// List<?> code_dataset = carReserveService.selectDtupDataSetList(map05);
//		model.addAttribute("scenario_code1", scenario_code1);
//		model.addAttribute("scenario_code2", scenario_code2);
//		model.addAttribute("scenario_code3", scenario_code3);
//		model.addAttribute("code_driving_mode", code_driving_mode);
		// model.addAttribute("code_dataset", code_dataset);
		Map<String, Object> map = viseService.selectContectInfo();  
		model.addAttribute("map", map);
		model.addAttribute("agcy_nm", (String) session.getAttribute("agcy_nm"));
		model.addAttribute("selectDay", paramMap.get("selectDay"));
		model.addAttribute("carCode", paramMap.get("carCode"));
		//model.addAttribute("agcy_cd", (String) session.getAttribute("agcy_cd"));
		
		rtnStr = "sharing/Car_Reserve_Inst.tiles"; 

		return rtnStr;
	}
	
	@RequestMapping(value = "Car_Reserve_SelectCarCode.do")
	public ModelAndView selectCarCode(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		System.out.println("rentCarCode >>>>>>>>>>>>>>>>> "+paramMap);
		List<?> carReserveInfoList = carReserveService.selectCarReserveInfoList(paramMap);
		System.out.println(">>>>>>>>>>>>>>>>> "+carReserveInfoList);
		model.addAttribute("resultList", carReserveInfoList);
		return mav;
	}
	
	/**
	 * 차량플랫폼 예약 데이터셋 등록 한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_Inst_Process.do")
	public String carReserveInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		LOG.debug(" ########## Car_Reserve_Inst_Process.do!! ###########");
		String result = "1"; // 결과
		pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		pathUpload = propertiesService.getString("pathUpload");
		//path_d = pathUpload+"sharing"+pathLetter; // 차량플랫폼 예약

		LOG.debug(" ########## Car_Reserve_Inst_Process.do ###########");
		LOG.debug("     applyCompanyCode[" + paramMap.get("applyCompanyCode") + "]");
		LOG.debug("     applyDate[" + paramMap.get("applyDate") + "]");
		LOG.debug("   	applyType[" + paramMap.get("applyType") + "]");
		LOG.debug("     bizNumber[" + paramMap.get("bizNumber") + "]");
		LOG.debug("     agencyAdres[" + paramMap.get("agencyAdres") + "]");
		LOG.debug("     rentDt[" + paramMap.get("rentDt") + "]");
		LOG.debug("     returnDt[" + paramMap.get("returnDt") + "]");
		LOG.debug("     rentCarCode[" + paramMap.get("rentCarCode") + "]");
		LOG.debug("     rentTime[" + paramMap.get("rentTime") + "]");
		LOG.debug("     returnTime[" + session.getAttribute("returnTime") + "]");
		LOG.debug("     fileInfo[" + paramMap.get("fileInfo") + "]");

		/* URL접근 방지 : S */
//		String user_id = (String) session.getAttribute("user_id");
//		String auth_id = (String) session.getAttribute("auth_id");
//		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
//			LOG.debug("        user_id[" + user_id + "]");
//			LOG.debug("        auth_id[" + auth_id + "]");
//			model.addAttribute("rst_scrn", "sharing");
//			model.addAttribute("rst_user", user_id);
//			model.addAttribute("rst_auth", auth_id);
//			return "common/Auth_Process";
//		}
		/* URL접근 방지 : E */

		String reserve_num = carReserveService.sequenceReserveNum(paramMap);
		LOG.debug("        Position Log[1]");
	    LOG.debug("----------paramMap: " + paramMap);
		 
//		String b_seq = publicDsetService.sequenceBseq(paramMap);
//		LOG.debug("        Position Log[1]");
		
		// 데이터첨부파일(변경)
//		Map<String, String> map_d = new HashMap<String, String>();
//		map_d.put("b_seq", b_seq);
		Map<String, String> map_d = new HashMap<String, String>();
		map_d.put("reserveNumber", reserve_num);

//		 JSONArray file_info = new JSONArray(paramMap.get("file_info"));
		// LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info);
		Map<String, MultipartFile> files = multipartRequest.getFileMap();
		String filePath = path_d;
		String fileSize = files.get("file_info").getSize()+"";//files.size() + "";
		String fileName = files.get("file_info").getOriginalFilename();
		if (fileName != null && fileName.length() > 0) {
			// JSONObject jsonObject = file_info.getJSONObject(0);
			/* 파일 확장자 체크 : S */
			boolean bExt_03 = Util.fileExtCheck(fileName);
			if (!bExt_03) {
				model.addAttribute("result_insert", "ext");
				return "sharing/Car_Reserve_Process";
			}
			/* 파일 확장자 체크 : E */
			if (bExt_03) {
				String fullPath = filePath;
				int cut1 = StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1;
				String dirPath = fullPath.substring(0, cut1);
				String fileOrgNm = fullPath.substring(cut1);
				LOG.debug("@@@@@@@@@@@@@@@@@[ fileOrgNm]" + fileOrgNm);
				String origName = fileOrgNm;
				String findStr = reserve_num + "_";
				String upldName = "";
				if (fileName.indexOf(findStr) > -1) {
					upldName = fileName;
				} else {
					upldName = reserve_num + "_" + fileName;
				}
				LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" + upldName);
				// 파일이동
				/*
				 * if (bbs_group_seq.equals("3000")) { //임시 FileUtil.fileMove(path_d+origName,
				 * path_c, upldName); FileUtil.fileRename(path_d, origName, upldName); } else {
				 * FileUtil.fileRename(path_d, origName, upldName); }
				 */
				String destDir = fullPath;
				String newFileNm = reserve_num + "_";
				LOG.debug("@@@@@@@@@@@@@@@@@[ destDir]" + destDir);
				LOG.debug("@@@@@@@@@@@@@@@@@[ newFileNm]" + newFileNm);
				FileUtil.transferUploadFileNew(files.get("file_info"), destDir, newFileNm);
				LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" + fileSize);
				map_d.put("reservationNumber", reserve_num);
				map_d.put("seq", "1");
				map_d.put("attach_file", upldName);
				paramMap.put("attach_file", upldName);
				map_d.put("file_path", origName);
				map_d.put("file_size", fileSize);
				map_d.put("file_type", paramMap.get("file_type"));

				carReserveService.insertAttachFile(map_d);
			}
		}
		LOG.debug("        Position Log[6]");

		try {
			// 등록
			paramMap.put("reservationNumber", reserve_num);
//			paramMap.put("b_seq", b_seq);
			paramMap.put("reg_id", (String) session.getAttribute("user_id")); // 작성자
			
//			publicDsetService.insertPublicDset(paramMap); //bbs시퀀스....
		    carReserveService.insertCarReserve(paramMap);
			
		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 첨부파일 등록 실패 : " + e.toString());
			result = "0";
		} catch (Exception e) {
			LOG.info("[Exception] 첨부파일 등록 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_insert", result);
		LOG.debug("        Position Log[8]");

		return "sharing/Car_Reserve_Process.tiles";
	}
	
	/**
	 * 차량플랫폼 공유 예약 취소
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Car_Reserve_Cancel_Process.do")
	public String carReserveCancelProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			HttpServletRequest multipartRequest, HttpSession session) throws Exception {
		String result = "1"; // 결과
		
		LOG.debug(" ########## Car_Reserve_Cancel_Process.do ###########");
		LOG.debug("        reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")) {
			LOG.debug("        user_id[" + user_id + "]");
			LOG.debug("        auth_id[" + auth_id + "]");
			model.addAttribute("rst_scrn", "sharing");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		carReserveService.updateCarReserveCancel(paramMap);
		model.addAttribute("result_update_cancel", result);

		return "sharing/Car_Reserve_Process.tiles";
	}
}
