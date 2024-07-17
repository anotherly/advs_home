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
import katri.avsc.duty.excel.IncdExcel;
import katri.avsc.duty.service.DrvgService;
import katri.avsc.duty.service.IncdService;
import katri.avsc.egovframework.cmmn.util.*;

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
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * 운행정보보고 > 교통사고
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/duty/incident")
public class IncdController {
	
	/** drvgService */
	@Resource(name = "drvgService")
	DrvgService drvgService;
	
	/** incdService */
	@Resource(name = "incdService")
	IncdService incdService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	/** paraService */
	@Resource(name = "paraService")
	ParaService paraService;

	private static final Log LOG = LogFactory.getLog(IncdController.class.getName());

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
	 * @return "Duty_Incd_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_List.do")
	public String selectIncdList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		int iPageNo = 1;	//현재 페이지
		LOG.debug(" ########## Duty_Incd_List.do ###########");
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

		List<?> incdList = incdService.selectIncdList(paramMap);
		model.addAttribute("resultList", incdList);
		
		int totCnt = incdService.selectIncdListTotCnt(paramMap);
		pageSetting.setTotalRecordCount(totCnt);

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("param_id", "acc_eff_date");
		Map<String, String> paramInfo = paraService.selectParaInfo(map01);
		
		//기간체크
		int drvChk = drvgService.selectDrvgIsCheck(paramMap);
		model.addAttribute("drvChk", drvChk);
		
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("searchType", paramMap.get("searchType"));
		model.addAttribute("searchWord", paramMap.get("searchWord"));
		model.addAttribute("paramInfo", paramInfo);
		
		return "duty/Duty_Incd_List.tiles";
	}

	/**
	 * 상세정보 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Incd_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Info.do")
	public String incdInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Incd_Info.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" acc_id["+paramMap.get("acc_id")+"]");

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

		Map<String, String> incdInfo = incdService.selectIncdInfo(paramMap);
		List<?> carList = incdService.selectAccCarList(paramMap);
		List<?> videoList = incdService.selectAccVideoList(paramMap);

		model.addAttribute("incdInfo", incdInfo);
		model.addAttribute("carList", carList);
		model.addAttribute("videoList", videoList);
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("acc_id", paramMap.get("acc_id"));
		
		return "duty/Duty_Incd_Info.tiles";
	}

	/**
	 * 등록 화면으로 이동한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Incd_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Inst.do")
	public String incdInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Incd_Inst.do ###########");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");

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

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("codeid", "autocar_driving_status_cd");
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("codeid", "autocar_damage");
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "autocar_human_sex");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "acccar_car_type");
		Map<String, String> map09 = new HashMap<String, String>();
		map09.put("codeid", "acccar_driving_mode");
		Map<String, String> map10 = new HashMap<String, String>();
		map10.put("codeid", "acccar_driving_status_cd");
		Map<String, String> map11 = new HashMap<String, String>();
		map11.put("codeid", "acccar_damage");
		Map<String, String> map12 = new HashMap<String, String>();
		map12.put("codeid", "acccar_human_sex");
		Map<String, String> map13 = new HashMap<String, String>();
		map13.put("codeid", "file_type");
		Map<String, String> map14 = new HashMap<String, String>();
		map14.put("codeid", "human_injury_type");
		Map<String, String> map15 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map15.put("userid", "");
		} else {
			map15.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_driving_status_cd = codeService.selectSubCodeList(map05);
		List<?> code_damage = codeService.selectSubCodeList(map06);
		List<?> code_human_sex = codeService.selectSubCodeList(map07);
		List<?> code_car_type = codeService.selectSubCodeList(map08);
		List<?> code_driving_mode2 = codeService.selectSubCodeList(map09);
		List<?> code_driving_status_cd2 = codeService.selectSubCodeList(map10);
		List<?> code_damage2 = codeService.selectSubCodeList(map11);
		List<?> code_human_sex2 = codeService.selectSubCodeList(map12);
		List<?> code_file_type = codeService.selectSubCodeList(map13);
		List<?> code_injury_type = codeService.selectSubCodeList(map14);
		List<?> code_tempoper = codeService.selectTempOperList(map15);

		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_driving_status_cd", code_driving_status_cd);
		model.addAttribute("code_damage", code_damage);
		model.addAttribute("code_human_sex", code_human_sex);
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_driving_mode2", code_driving_mode2);
		model.addAttribute("code_driving_status_cd2", code_driving_status_cd2);
		model.addAttribute("code_damage2", code_damage2);
		model.addAttribute("code_human_sex2", code_human_sex2);
		model.addAttribute("code_file_type", code_file_type);
		model.addAttribute("code_injury_type", code_injury_type);
		model.addAttribute("code_tempoper", code_tempoper);

		return "duty/Duty_Incd_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Inst_Process.do")
	public String incdInsertProcess(@RequestParam MultiValueMap<String,String> params, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "incd" + pathLetter;
		//pathUpload = "D:\\Share2\\incd\\"; //개발테스트(제거할것)

		LOG.debug(" ########## Duty_Incd_Inst_Process.do ###########");
		LOG.debug(" ########## 사고정보");
		LOG.debug("           tmp_race_number["+params.get("tmp_race_number").get(0)+"]");
		LOG.debug("           tmp_race_agency["+params.get("tmp_race_agency").get(0)+"]");
		LOG.debug("                acc_date_d["+params.get("acc_date_d").get(0)+"]");
		LOG.debug("                acc_date_h["+params.get("acc_date_h").get(0)+"]");
		LOG.debug("                acc_date_m["+params.get("acc_date_m").get(0)+"]");
		LOG.debug("                     place["+params.get("place").get(0)+"]");
		LOG.debug("                   weather["+params.get("weather").get(0)+"]");
		LOG.debug("            road_situation["+params.get("road_situation").get(0)+"]");
		LOG.debug("              road_type_cd["+params.get("road_type_cd").get(0)+"]");
		LOG.debug("      autocar_driving_mode["+params.get("autocar_driving_mode").get(0)+"]");
		LOG.debug(" autocar_driving_status_cd["+params.get("autocar_driving_status_cd").get(0)+"]");
		LOG.debug("             autocar_speed["+params.get("autocar_speed").get(0)+"]");
		LOG.debug("       autocar_ride_number["+params.get("autocar_ride_number").get(0)+"]");
		LOG.debug("          autocar_load_vol["+params.get("autocar_load_vol").get(0)+"]");
		LOG.debug("            autocar_damage["+params.get("autocar_damage").get(0)+"]");
		LOG.debug("         human_injury_type["+params.get("human_injury_type").get(0)+"]");
		LOG.debug("         autocar_human_sex["+params.get("autocar_human_sex").get(0)+"]");
		LOG.debug("         autocar_human_age["+params.get("autocar_human_age").get(0)+"]");
		LOG.debug("           acc_detail_info["+params.get("acc_detail_info").get(0)+"]");
		LOG.debug("                    reg_id["+session.getAttribute("user_id")+"]");
		LOG.debug(" ########## 사고차량");
		LOG.debug("           acccar_car_type["+params.get("acccar_car_type")+"]");
		LOG.debug("       acccar_driving_mode["+params.get("acccar_driving_mode")+"]");
		LOG.debug("  acccar_driving_status_cd["+params.get("acccar_driving_status_cd")+"]");
		LOG.debug("              acccar_speed["+params.get("acccar_speed")+"]");
		LOG.debug("        acccar_ride_number["+params.get("acccar_ride_number")+"]");
		LOG.debug("           acccar_load_vol["+params.get("acccar_load_vol")+"]");
		LOG.debug("             acccar_damage["+params.get("acccar_damage")+"]");
		LOG.debug("  acccar_human_injury_type["+params.get("acccar_human_injury_type")+"]");
		LOG.debug("          acccar_human_sex["+params.get("acccar_human_sex")+"]");
		LOG.debug("          acccar_human_age["+params.get("acccar_human_age")+"]");

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

		try{
			/*
			 * 사고정보 등록
			 */
			Map<String, String> map01 = new HashMap<String, String>();
			String tmp_race_number = params.get("tmp_race_number").get(0);
			String acc_id = incdService.sequenceAccId(map01);
			LOG.debug("            acc_id.nextval["+acc_id+"]");
			String acc_date = params.get("acc_date_d").get(0) +" "+ params.get("acc_date_h").get(0) +":"+ params.get("acc_date_m").get(0);
			map01.put("acc_id", acc_id);
			map01.put("acc_date", acc_date);
			map01.put("tmp_race_number", tmp_race_number);
			map01.put("tmp_race_agency", params.get("tmp_race_agency").get(0));
			map01.put("place", params.get("place").get(0));
			map01.put("weather", params.get("weather").get(0));
			map01.put("road_situation", params.get("road_situation").get(0));
			map01.put("road_type_cd", params.get("road_type_cd").get(0));
			map01.put("autocar_driving_mode", params.get("autocar_driving_mode").get(0));
			map01.put("autocar_driving_status_cd", params.get("autocar_driving_status_cd").get(0));
			map01.put("autocar_speed", params.get("autocar_speed").get(0));
			map01.put("autocar_ride_number", params.get("autocar_ride_number").get(0));
			map01.put("autocar_load_vol", params.get("autocar_load_vol").get(0));
			map01.put("autocar_damage", params.get("autocar_damage").get(0));
			map01.put("human_injury_type", params.get("human_injury_type").get(0));
			map01.put("autocar_human_sex", params.get("autocar_human_sex").get(0));
			map01.put("autocar_human_age", params.get("autocar_human_age").get(0));
			map01.put("acc_detail_info", params.get("acc_detail_info").get(0));
			map01.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			map01.put("driving_info_file", "");
			map01.put("acc_rec_device_file", "");
			map01.put("etc_filename", "");

			//첨부파일 처리
			//List mov_name = new ArrayList();	//사고영상 파일
			//List mov_size = new ArrayList();	//사고영상 파일 사이즈
			String newFileNM = "";

		    Iterator<String> it_file = multipartRequest.getFileNames();
		    MultipartFile multipartFile = null;
		    while(it_file.hasNext()){
		        multipartFile = multipartRequest.getFile(it_file.next());
	        	LOG.debug("------------- File start -------------");
	        	LOG.debug("    name : "+multipartFile.getName());
	        	LOG.debug("filename : "+multipartFile.getOriginalFilename());
	        	LOG.debug("    size : "+multipartFile.getSize());
	        	LOG.debug("-------------- File end --------------\n");
	    		/* 파일 확장자 체크 : S */
	    		boolean bExt = Util.fileExtCheck(multipartFile.getOriginalFilename());
		        if(multipartFile.isEmpty() == false && !bExt) {
	    			model.addAttribute("result_insert", "ext");
	    			return "duty/Duty_Incd_Process";
	    		}
	    		/* 파일 확장자 체크 : E */
		        if(multipartFile.isEmpty() == false && bExt) {
					newFileNM = acc_id + "_";
					String file_name = FileUtil.transferUploadFileNew(multipartFile, pathUpload, newFileNM);
					//운행정보파일
					if(multipartFile.getName().equals("file_info")) {
						map01.put("driving_info_file", file_name);
					}
					//사고기록장치파일
					if(multipartFile.getName().equals("file_rec")) {
						map01.put("acc_rec_device_file", file_name);
					}
					//기타첨부파일
					if(multipartFile.getName().equals("file_etc")) {
						map01.put("etc_filename", file_name);
					}
					//사고영상
					/*
					if(multipartFile.getName().indexOf("file_mov") > -1) {
						LOG.debug(" @@@@@@@@@@@@@@ : file :" +file_name);
						mov_name.add(file_name);
						mov_size.add(multipartFile.getSize());
					}
					*/
		        }
		    }

			LOG.debug(" @@@@@@@@@@@@@@ : 1");
		    incdService.insertIncd(map01);
			LOG.debug(" @@@@@@@@@@@@@@ : 2");
			/*
			 * 사고차량 등록
			 */
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("tmp_race_number", tmp_race_number);
			map02.put("acc_id", acc_id);
			List list_01 = params.get("acccar_car_type");
			List list_02 = params.get("acccar_driving_mode");
			List list_03 = params.get("acccar_driving_status_cd");
			List list_04 = params.get("acccar_speed");
			List list_05 = params.get("acccar_ride_number");
			List list_06 = params.get("acccar_load_vol");
			List list_07 = params.get("acccar_damage");
			List list_08 = params.get("acccar_human_injury_type");
			List list_09 = params.get("acccar_human_sex");
			List list_10 = params.get("acccar_human_age");
			for(int i=0; i < list_01.size(); i++) {
				if(!list_01.get(i).equals("")) {
					map02.put("seq", String.valueOf(i+1));
					map02.put("acccar_car_type", (String)list_01.get(i));
					map02.put("acccar_driving_mode", (String)list_02.get(i));
					map02.put("acccar_driving_status_cd", (String)list_03.get(i));
					map02.put("acccar_speed", (String)list_04.get(i));
					map02.put("acccar_ride_number", (String)list_05.get(i));
					map02.put("acccar_load_vol", (String)list_06.get(i));
					map02.put("acccar_damage", (String)list_07.get(i));
					map02.put("acccar_human_injury_type", (String)list_08.get(i));
					map02.put("acccar_human_sex", (String)list_09.get(i));
					map02.put("acccar_human_age", (String)list_10.get(i));

					LOG.debug(" @@@@@@@@@@@@@@ : 3-"+i);
					incdService.insertAccCar(map02);
					LOG.debug(" @@@@@@@@@@@@@@ : 4-"+i);
				}
			}
			/*
			 * 사고영상 등록
			 */
			String[] filePath = params.get("filePath").get(0).split(",");
			String[] fileSize = params.get("fileSize").get(0).split(",");
			String[] fileName = params.get("fileName").get(0).split(",");
					
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("tmp_race_number", tmp_race_number);
			map03.put("acc_id", acc_id);
			LOG.debug(" @@@@@@@@@@@@@@ : mov_name :" +fileName.length);
			if(fileName != null && fileName.length > 0){
				for(int i=0; i < fileName.length; i++) {
					if(fileName[i] != null && fileName[i].length() > 0){
/*						String fullPath = filePath[i];
						int cut1 = StringUtils.ordinalIndexOf(filePath[i], "/", 1) + 1;
						String dirPath = fullPath.substring(0, cut1);
						String fileOrgNm = fullPath.substring(cut1);*/
						map03.put("seq", String.valueOf(i+1));
						map03.put("driving_video_file", fileName[i]);
						map03.put("file_size", fileSize[i]);
						map03.put("file_type", "101");
		
						LOG.debug(" @@@@@@@@@@@@@@ : 5-"+i);
						incdService.insertAccVideo(map03);
						LOG.debug(" @@@@@@@@@@@@@@ : 6-"+i);
					}
				}
			}
		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 사고 등록 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_insert", result);

		return "duty/Duty_Incd_Process";
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Delt_Process.do")
	public String incdDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

		int result = 1; //결과

		LOG.debug(" ########## Duty_Incd_Delt_Process.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" acc_id["+paramMap.get("acc_id")+"]");

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

		result = incdService.deleteAccVideo(paramMap);
		if(result > -1) {
			result = incdService.deleteAccCar(paramMap);
			if(result > -1) result = incdService.deleteIncd(paramMap);
			else result = -1;
		} else {
			result = -1;
		}
		LOG.debug(" result["+result+"]");
		
		model.addAttribute("result_delete", result);
		
		return "duty/Duty_Incd_Process";
	} 

	/**
	 * 수정 화면으로 이동한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Incd_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Updt.do")
	public String incdUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
		
		LOG.debug(" ########## Duty_Incd_Updt.do ###########");
		LOG.debug(" drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug(" acc_id["+paramMap.get("acc_id")+"]");

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

		Map<String, String> incdInfo = incdService.selectIncdInfo(paramMap);
		List<?> carList = incdService.selectAccCarList(paramMap);
		List<?> videoList = incdService.selectAccVideoList(paramMap);

		model.addAttribute("incdInfo", incdInfo);
		model.addAttribute("carList", carList);
		model.addAttribute("videoList", videoList);
		model.addAttribute("carListSize", carList.size());
		model.addAttribute("drv_no", paramMap.get("drv_no"));
		model.addAttribute("acc_id", paramMap.get("acc_id"));

		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("codeid", "autocar_driving_status_cd");
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("codeid", "autocar_damage");
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "autocar_human_sex");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "acccar_car_type");
		Map<String, String> map09 = new HashMap<String, String>();
		map09.put("codeid", "acccar_driving_mode");
		Map<String, String> map10 = new HashMap<String, String>();
		map10.put("codeid", "acccar_driving_status_cd");
		Map<String, String> map11 = new HashMap<String, String>();
		map11.put("codeid", "acccar_damage");
		Map<String, String> map12 = new HashMap<String, String>();
		map12.put("codeid", "acccar_human_sex");
		Map<String, String> map13 = new HashMap<String, String>();
		map13.put("codeid", "file_type");
		Map<String, String> map14 = new HashMap<String, String>();
		map14.put("codeid", "human_injury_type");
		Map<String, String> map15 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map15.put("userid", "");
		} else {
			map15.put("userid", (String)session.getAttribute("user_id"));
		}

		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_driving_status_cd = codeService.selectSubCodeList(map05);
		List<?> code_damage = codeService.selectSubCodeList(map06);
		List<?> code_human_sex = codeService.selectSubCodeList(map07);
		List<?> code_car_type = codeService.selectSubCodeList(map08);
		List<?> code_driving_mode2 = codeService.selectSubCodeList(map09);
		List<?> code_driving_status_cd2 = codeService.selectSubCodeList(map10);
		List<?> code_damage2 = codeService.selectSubCodeList(map11);
		List<?> code_human_sex2 = codeService.selectSubCodeList(map12);
		List<?> code_file_type = codeService.selectSubCodeList(map13);
		List<?> code_injury_type = codeService.selectSubCodeList(map14);
		List<?> code_tempoper = codeService.selectTempOperList(map15);

		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_driving_status_cd", code_driving_status_cd);
		model.addAttribute("code_damage", code_damage);
		model.addAttribute("code_human_sex", code_human_sex);
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_driving_mode2", code_driving_mode2);
		model.addAttribute("code_driving_status_cd2", code_driving_status_cd2);
		model.addAttribute("code_damage2", code_damage2);
		model.addAttribute("code_human_sex2", code_human_sex2);
		model.addAttribute("code_file_type", code_file_type);
		model.addAttribute("code_injury_type", code_injury_type);
		model.addAttribute("code_tempoper", code_tempoper);

		return "duty/Duty_Incd_Updt.tiles";
	}

	/**
	 * 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Updt_Process.do")
	public String incdUpdateProcess(@RequestParam MultiValueMap<String,String> params, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "incd" + pathLetter;
		pathUpload = "D:\\Share2\\incd\\"; //개발테스트(제거할것)
		LOG.debug(" ########## Duty_Incd_Inst_Process.do ###########");
		LOG.debug(" ########## 사고정보");
		LOG.debug("                    drv_no["+params.get("drv_no").get(0)+"]");
		LOG.debug("                    acc_id["+params.get("acc_id").get(0)+"]");
		LOG.debug("           tmp_race_agency["+params.get("tmp_race_agency").get(0)+"]");
		LOG.debug("                acc_date_d["+params.get("acc_date_d").get(0)+"]");
		LOG.debug("                acc_date_h["+params.get("acc_date_h").get(0)+"]");
		LOG.debug("                acc_date_m["+params.get("acc_date_m").get(0)+"]");
		LOG.debug("                     place["+params.get("place").get(0)+"]");
		LOG.debug("                   weather["+params.get("weather").get(0)+"]");
		LOG.debug("            road_situation["+params.get("road_situation").get(0)+"]");
		LOG.debug("              road_type_cd["+params.get("road_type_cd").get(0)+"]");
		LOG.debug("      autocar_driving_mode["+params.get("autocar_driving_mode").get(0)+"]");
		LOG.debug(" autocar_driving_status_cd["+params.get("autocar_driving_status_cd").get(0)+"]");
		LOG.debug("             autocar_speed["+params.get("autocar_speed").get(0)+"]");
		LOG.debug("       autocar_ride_number["+params.get("autocar_ride_number").get(0)+"]");
		LOG.debug("          autocar_load_vol["+params.get("autocar_load_vol").get(0)+"]");
		LOG.debug("            autocar_damage["+params.get("autocar_damage").get(0)+"]");
		LOG.debug("         human_injury_type["+params.get("human_injury_type").get(0)+"]");
		LOG.debug("         autocar_human_sex["+params.get("autocar_human_sex").get(0)+"]");
		LOG.debug("         autocar_human_age["+params.get("autocar_human_age").get(0)+"]");
		LOG.debug("           acc_detail_info["+params.get("acc_detail_info").get(0)+"]");
		LOG.debug("                    reg_id["+session.getAttribute("user_id")+"]");
		LOG.debug(" ########## 사고차량");
		LOG.debug("           acccar_car_type["+params.get("acccar_car_type")+"]");
		LOG.debug("       acccar_driving_mode["+params.get("acccar_driving_mode")+"]");
		LOG.debug("  acccar_driving_status_cd["+params.get("acccar_driving_status_cd")+"]");
		LOG.debug("              acccar_speed["+params.get("acccar_speed")+"]");
		LOG.debug("        acccar_ride_number["+params.get("acccar_ride_number")+"]");
		LOG.debug("           acccar_load_vol["+params.get("acccar_load_vol")+"]");
		LOG.debug("             acccar_damage["+params.get("acccar_damage")+"]");
		LOG.debug("  acccar_human_injury_type["+params.get("acccar_human_injury_type")+"]");
		LOG.debug("          acccar_human_sex["+params.get("acccar_human_sex")+"]");
		LOG.debug("          acccar_human_age["+params.get("acccar_human_age")+"]");
		LOG.debug(" ########## 사고영상");
		LOG.debug("                   mov_new["+params.get("mov_new").get(0)+"]");

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

		try{
			/*
			 * 사고정보 수정
			 */
			Map<String, String> map01 = new HashMap<String, String>();
			String drv_no = params.get("drv_no").get(0);
			String acc_id = params.get("acc_id").get(0);
			String acc_date = params.get("acc_date_d").get(0) +" "+ params.get("acc_date_h").get(0) +":"+ params.get("acc_date_m").get(0);
			map01.put("drv_no", drv_no);
			map01.put("acc_id", acc_id);
			map01.put("acc_date", acc_date);
			map01.put("tmp_race_agency", params.get("tmp_race_agency").get(0));
			map01.put("place", params.get("place").get(0));
			map01.put("weather", params.get("weather").get(0));
			map01.put("road_situation", params.get("road_situation").get(0));
			map01.put("road_type_cd", params.get("road_type_cd").get(0));
			map01.put("autocar_driving_mode", params.get("autocar_driving_mode").get(0));
			map01.put("autocar_driving_status_cd", params.get("autocar_driving_status_cd").get(0));
			map01.put("autocar_speed", params.get("autocar_speed").get(0));
			map01.put("autocar_ride_number", params.get("autocar_ride_number").get(0));
			map01.put("autocar_load_vol", params.get("autocar_load_vol").get(0));
			map01.put("autocar_damage", params.get("autocar_damage").get(0));
			map01.put("human_injury_type", params.get("human_injury_type").get(0));
			map01.put("autocar_human_sex", params.get("autocar_human_sex").get(0));
			map01.put("autocar_human_age", params.get("autocar_human_age").get(0));
			map01.put("acc_detail_info", params.get("acc_detail_info").get(0));
			map01.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			map01.put("driving_info_file", "");
			map01.put("acc_rec_device_file", "");
			map01.put("etc_filename", "");

			//첨부파일 처리
			//List mov_name = new ArrayList();	//사고영상 파일
			//List mov_size = new ArrayList();	//사고영상 파일 사이즈
			String newFileNM = "";

		    Iterator<String> it_file = multipartRequest.getFileNames();
		    MultipartFile multipartFile = null;
		    while(it_file.hasNext()){
		        multipartFile = multipartRequest.getFile(it_file.next());
	        	LOG.debug("------------- File start -------------");
	        	LOG.debug("    name : "+multipartFile.getName());
	        	LOG.debug("filename : "+multipartFile.getOriginalFilename());
	        	LOG.debug("    size : "+multipartFile.getSize());
	        	LOG.debug("-------------- File end --------------\n");
	    		/* 파일 확장자 체크 : S */
	    		boolean bExt = Util.fileExtCheck(multipartFile.getOriginalFilename());
		        if(multipartFile.isEmpty() == false && !bExt) {
	    			model.addAttribute("result_update", "ext");
	    			return "duty/Duty_Incd_Process";
	    		}
	    		/* 파일 확장자 체크 : E */
		        if(multipartFile.isEmpty() == false && bExt) {
					newFileNM = acc_id + "_";
					String file_name = FileUtil.transferUploadFileNew(multipartFile, pathUpload, newFileNM);
					//운행정보파일
					if(multipartFile.getName().equals("file_info")) {
						map01.put("driving_info_file", file_name);
						map01.put("dr_file_yn", "Y");
					}
					//사고기록장치파일
					if(multipartFile.getName().equals("file_rec")) {
						map01.put("acc_rec_device_file", file_name);
						map01.put("ac_file_yn", "Y");
					}
					//기타첨부파일
					if(multipartFile.getName().equals("file_etc")) {
						map01.put("etc_filename", file_name);
						map01.put("et_file_yn", "Y");
					}
					//사고영상
/*					if(multipartFile.getName().indexOf("file_mov") > -1) {
						LOG.debug(" @@@@@@@@@@@@@@ : file :" +file_name);
						mov_name.add(file_name);
						mov_size.add(multipartFile.getSize());
					}*/
		        }
		    }

			LOG.debug(" @@@@@@@@@@@@@@ : 1");
		    incdService.updateIncd(map01);
			LOG.debug(" @@@@@@@@@@@@@@ : 2");
			/*
			 * 사고차량 삭제 후 등록
			 */
			Map<String, String> map02 = new HashMap<String, String>();
			map02.put("drv_no", drv_no);
			map02.put("acc_id", acc_id);
			map02.put("tmp_race_number", drv_no);
			//삭제
			LOG.debug(" @@@@@@@@@@@@@@ : 3");
			int rst02 = incdService.deleteAccCar(map02);
			LOG.debug(" @@@@@@@@@@@@@@ : 4");
			if(rst02 > -1) {
				//등록
				List list_01 = params.get("acccar_car_type");
				List list_02 = params.get("acccar_driving_mode");
				List list_03 = params.get("acccar_driving_status_cd");
				List list_04 = params.get("acccar_speed");
				List list_05 = params.get("acccar_ride_number");
				List list_06 = params.get("acccar_load_vol");
				List list_07 = params.get("acccar_damage");
				List list_08 = params.get("acccar_human_injury_type");
				List list_09 = params.get("acccar_human_sex");
				List list_10 = params.get("acccar_human_age");
				for(int i=0; i < list_01.size(); i++) {
					if(!list_01.get(i).equals("")) {
						map02.put("seq", String.valueOf(i+1));
						map02.put("acccar_car_type", (String)list_01.get(i));
						map02.put("acccar_driving_mode", (String)list_02.get(i));
						map02.put("acccar_driving_status_cd", (String)list_03.get(i));
						map02.put("acccar_speed", (String)list_04.get(i));
						map02.put("acccar_ride_number", (String)list_05.get(i));
						map02.put("acccar_load_vol", (String)list_06.get(i));
						map02.put("acccar_damage", (String)list_07.get(i));
						map02.put("acccar_human_injury_type", (String)list_08.get(i));
						map02.put("acccar_human_sex", (String)list_09.get(i));
						map02.put("acccar_human_age", (String)list_10.get(i));

						LOG.debug(" @@@@@@@@@@@@@@ : 5-"+i);
						incdService.insertAccCar(map02);
						LOG.debug(" @@@@@@@@@@@@@@ : 6-"+i);
					}
				}
			}
			/*
			 * 사고영상이 변경 되었으면 삭제 후 등록
			 */
			//String mov_new = params.get("mov_new").get(0);
			//변경확인
			//if(mov_new != null && mov_new.equals("Y")) {
			String[] filePath = params.get("filePath").get(0).split(",");
			String[] fileSize = params.get("fileSize").get(0).split(",");
			String[] fileName = params.get("fileName").get(0).split(",");		
			
			Map<String, String> map03 = new HashMap<String, String>();
			map03.put("drv_no", drv_no);
			map03.put("acc_id", acc_id);
			map03.put("tmp_race_number", drv_no);
			//삭제
			LOG.debug(" @@@@@@@@@@@@@@ : 7");
			int rst03 = incdService.deleteAccVideo(map03);
			LOG.debug(" @@@@@@@@@@@@@@ : 8");
			if(rst03 > -1 && fileName != null && fileName.length > 0) {
				LOG.debug(" @@@@@@@@@@@@@@ : mov_name :" +fileName.length);
				for(int i=0; i < fileName.length; i++) {
					if(fileName[i] != null && fileName[i].length() > 0){
/*						String fullPath = filePath[i];
						int cut1 = StringUtils.ordinalIndexOf(filePath[i], "/", 1) + 1;
						String dirPath = fullPath.substring(0, cut1);
						String fileOrgNm = fullPath.substring(cut1);	*/				
						map03.put("seq", String.valueOf(i+1));
						map03.put("driving_video_file", fileName[i]);
						map03.put("file_size", fileSize[i]);
						map03.put("file_type", "101");
						LOG.debug(" @@@@@@@@@@@@@@ : 9-"+i);
						incdService.insertAccVideo(map03);
						LOG.debug(" @@@@@@@@@@@@@@ :10-"+i);
					}
				}
			}
			//}

			model.addAttribute("drv_no", drv_no);
			model.addAttribute("acc_id", acc_id);
		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 사고 수정 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_update", result);
		
		return "duty/Duty_Incd_Process";
	}

	/**
	 * 보고서 생성
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Excel_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Incd_Excel_Process.do")
	public String incdPopExcelDown(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "excel" + pathLetter;

		LOG.debug(" ########## Duty_Incd_Excel_Process.do ###########");
		LOG.debug("       drv_no["+paramMap.get("drv_no")+"]");
		LOG.debug("       acc_id["+paramMap.get("acc_id")+"]");

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

		Map<String, String> incdInfo = incdService.selectIncdInfo(paramMap);
		List<?> carList = incdService.selectAccCarList(paramMap);
//		List<?> videoList = incdService.selectAccVideoList(paramMap);

		//엑셀파일 이름 변경
		String filenm_org = "excel_incd.xlsx";
		String filenm_new = "excel_incd_"+paramMap.get("acc_id")+".xlsx";
		//업로드 경로
		String filePath_org = pathUpload + filenm_org;
		String filePath_new = pathUpload + filenm_new;

		//경로명 replace
		filePath_new = ExcelUtil.getReplace(filePath_new, "\\\\", "/");
		LOG.debug(" filePath_new["+filePath_new+"]");

		//엑셀 파일 정보 셋팅
		String result = IncdExcel.incdExcelMake(filePath_new, filenm_new, incdInfo, carList);
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
