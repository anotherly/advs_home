package katri.avsc.data.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.agcy.service.ConsService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DtupService;
import katri.avsc.egovframework.cmmn.util.*;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONObject;
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
 * My data > 장치변경
 * 
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/data/upload")
public class DtupController {

	/** dtupService */
	@Resource(name = "dtupService")
	DtupService dtupService;

	/** consService */
	@Resource(name = "consService")
	ConsService consService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(DtupController.class.getName());

	/** EgovPropertyService */
	@Resource(name = "propertiesService") // 환경 설정
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * 상세정보 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Dtup_Info"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Info.do")
	public String dtupInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
	
		model.addAttribute("uriModel", uriModel);
	

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> dtupInfo = dtupService.selectDtupInfo(paramMap);

		model.addAttribute("dtupInfo", dtupInfo);
		model.addAttribute("b_seq", paramMap.get("b_seq"));
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("auth_id", (String) session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String) session.getAttribute("user_id"));

		return "data/Data_Dtup_Info.tiles";
	}

	/**
	 * 등록 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Dtup_Inst"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Inst.do")
	public String dtupInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
	
			model.addAttribute("uriModel", uriModel);
		LOG.debug(" ########## Data_Dtup_Inst.do ###########");
		LOG.debug(" reg_id[" + session.getAttribute("user_id") + "]");


		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> map_00 = new HashMap<String, String>();
		String agcy_nm = (String) session.getAttribute("agcy_nm");
		if (auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if (auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("codeid", "act_info_type");
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("user_id", (String) session.getAttribute("user_id")); // 사용자id
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "car_type");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "autocar_level");
		Map<String, String> map09 = new HashMap<String, String>();
		map09.put("codeid", "mydata_attach_cd");

		List<?> bbs_list = codeService.selectBbsList(map_00);
		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_act_info_type = codeService.selectSubCodeList(map05);
		List<?> car_list = codeService.selectCarList(map06);
		List<?> code_car_type = codeService.selectSubCodeList(map07);
		List<?> code_car_level = codeService.selectSubCodeList(map08);
		List<?> dataset_list = consService.selectDtupDataSetList(map06);
		List<?> mydata_attach_cd = codeService.selectSubCodeList(map09);

		model.addAttribute("bbs_list", bbs_list);
		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_act_info_type", code_act_info_type);
		model.addAttribute("car_list", car_list);
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_car_level", code_car_level);
		model.addAttribute("dataset_list", dataset_list);
		model.addAttribute("mydata_attach_cd", mydata_attach_cd);
		model.addAttribute("auth_id", (String) session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String) session.getAttribute("user_id"));
		model.addAttribute("agcy_nm", agcy_nm);

		return "data/Data_Dtup_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Inst_Process.do")
	public String dtupInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; // 결과
		String bbs_group_seq = paramMap.get("bbs_group_seq");
		String pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		System.out.println("pathLetter : "+pathLetter);
		String pathUpload = propertiesService.getString("pathUpload");
		System.out.println("pathUpload : "+pathUpload);
		String path_v = pathUpload + "vehc" + pathLetter;
		System.out.println("path_v : "+path_v);//임시		String path_c = pathUpload + "cits" + pathLetter;	//공공데이터

		String path_d = pathUpload + "dtup" + pathLetter; // 협의체(운영)
		System.out.println("path_d1 : "+path_d);
		path_d = "D:\\Share2\\dtup\\"; // 협의체(개발)
		System.out.println("path_d2 : "+path_d);
		String path_s = pathUpload + "dset" + pathLetter;
		System.out.println("path_s : "+path_s);

		if (bbs_group_seq == null || bbs_group_seq.equals("")) {
			if (paramMap.get("bbs_seq").substring(0, 1).equals("1")) {
				bbs_group_seq = "1000";
			} else {
				bbs_group_seq = "2000";
			}
		}
		LOG.debug(" ########## Data_Dtup_Inst_Process.do ###########");

		String b_seq = dtupService.sequenceBseq(paramMap);

		LOG.debug("            bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("         b_from_day[" + paramMap.get("b_from_day") + "]");
		LOG.debug("           b_to_day[" + paramMap.get("b_to_day") + "]");
		LOG.debug("     b_important_yn[" + paramMap.get("b_important_yn") + "]");
		LOG.debug("            b_title[" + paramMap.get("b_title") + "]");
		LOG.debug("          b_content[" + paramMap.get("b_content") + "]");
		LOG.debug("         b_password[" + paramMap.get("b_password") + "]");
		LOG.debug("       driving_mode[" + paramMap.get("driving_mode") + "]");
		LOG.debug("            weather[" + paramMap.get("weather") + "]");
		LOG.debug("     road_situation[" + paramMap.get("road_situation") + "]");
		LOG.debug("       road_type_cd[" + paramMap.get("road_type_cd") + "]");
		LOG.debug("      act_info_type[" + paramMap.get("act_info_type") + "]");
		LOG.debug("           etc_info[" + paramMap.get("etc_info") + "]");
		LOG.debug("    vehicle_id_view[" + paramMap.get("vehicle_id_view") + "]");
		LOG.debug("         vehicle_id[" + paramMap.get("vehicle_id") + "]");
		LOG.debug("           car_type[" + paramMap.get("car_type") + "]");
		LOG.debug("          car_model[" + paramMap.get("car_model") + "]");
		LOG.debug(" movie_sensor_model[" + paramMap.get("movie_sensor_model") + "]");
		LOG.debug("        lidar_model[" + paramMap.get("lidar_model") + "]");
		LOG.debug("        radar_model[" + paramMap.get("radar_model") + "]");
		LOG.debug("      autocar_level[" + paramMap.get("autocar_level") + "]");
		// LOG.debug(" dataset["+paramMap.get("dataset")+"]");
		LOG.debug("        bdwr_ttl_nm[" + paramMap.get("bdwr_ttl_nm") + "]");
		LOG.debug("           bdwr_cts[" + paramMap.get("bdwr_cts") + "]");
		LOG.debug("          data_form[" + paramMap.get("data_form") + "]");
		LOG.debug("             reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		try {
			// 파일
			Map<String, MultipartFile> files = multipartRequest.getFileMap();
			String newFileNM = "";

			// 차량등록 처리
			if (paramMap.get("vehicle_id_view").equals("new")) {
				// 차량첨부파일
				Map<String, String> map_v = new HashMap<String, String>();
				map_v.put("vehicle_id", paramMap.get("vehicle_id"));
				map_v.put("user_id", (String) session.getAttribute("user_id"));
				map_v.put("car_type", paramMap.get("car_type"));
				map_v.put("car_model", paramMap.get("car_model"));
				map_v.put("movie_sensor_model", paramMap.get("movie_sensor_model"));
				map_v.put("lidar_model", paramMap.get("lidar_model"));
				map_v.put("radar_model", paramMap.get("radar_model"));
				map_v.put("autocar_level", paramMap.get("autocar_level"));
				/* 파일 확장자 체크 : S */
				boolean bExt_01 = Util.fileExtCheck(files.get("attach_filename").getOriginalFilename());
				System.out.println("bExt_01 : "+bExt_01);
				if (!files.get("attach_filename").isEmpty() && !bExt_01) {
					model.addAttribute("result_insert", "ext");
					return "data/Data_Dtup_Process";
				}
				/* 파일 확장자 체크 : E */
				if (!files.get("attach_filename").isEmpty() && bExt_01) {
					map_v.put("file_size", String.valueOf(files.get("attach_filename").getSize()));
					newFileNM = paramMap.get("vehicle_id") + "_";
					String file_name = FileUtil.transferUploadFileNew(files.get("attach_filename"), path_v, newFileNM);
					map_v.put("attach_filename", file_name);
				}
				dtupService.insertCar(map_v);
			}

			// 데이터셋 처리
			if (paramMap.get("dataset") != null && paramMap.get("dataset").equals("new")) {
				// 차량첨부파일
				Map<String, String> map_s = new HashMap<String, String>();
				String bdwr_seq = consService.sequenceBdwrSeq(paramMap);
				paramMap.put("bdwr_seq", bdwr_seq);
				map_s.put("bdwr_seq", bdwr_seq);
				map_s.put("bbs_seq", paramMap.get("bbs_seq"));
				map_s.put("bdwr_ttl_nm", paramMap.get("bdwr_ttl_nm"));
				map_s.put("bdwr_cts", paramMap.get("bdwr_cts"));
				map_s.put("data_form", paramMap.get("data_form"));
				map_s.put("reg_id", (String) session.getAttribute("user_id"));
				map_s.put("bbs_group_seq", bbs_group_seq);
				/* 파일 확장자 체크 : S */
				boolean bExt_02 = Util.fileExtCheck(files.get("file_data").getOriginalFilename());
				if (!files.get("file_data").isEmpty() && !bExt_02) {
					model.addAttribute("result_insert", "ext");
					return "data/Data_Dtup_Process";
				}
				/* 파일 확장자 체크 : E */
				if (!files.get("file_data").isEmpty() && bExt_02) {
					map_s.put("file_size", String.valueOf(files.get("file_data").getSize()));
					newFileNM = bdwr_seq + "_";
					String file_name = FileUtil.transferUploadFileNew(files.get("file_data"), path_s, newFileNM);
					map_s.put("attach_filename", file_name);
				}
				consService.insertDataSet(map_s);
			}

			// 게시글 등록
			paramMap.put("b_seq", b_seq);
			paramMap.put("b_attach_cnt", "1");
			paramMap.put("data_type", paramMap.get("bbs_seq"));
			paramMap.put("reg_id", (String) session.getAttribute("user_id")); // 작성자
			dtupService.insertBoard(paramMap);

			// 데이터첨부파일(기존)
			/*
			 * Map<String, String> map_d = new HashMap<String, String>(); map_d.put("b_seq",
			 * b_seq);
			 * 
			 * JSONArray file_info = new JSONArray(paramMap.get("file_info"));
			 * LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info); if(file_info.length()
			 * > 0 ) { JSONObject jsonObject = file_info.getJSONObject(0); 파일 확장자 체크 : S
			 * boolean bExt_03 = Util.fileExtCheck(jsonObject.getString("fileName"));
			 * if(!bExt_03) { model.addAttribute("result_insert", "ext"); return
			 * "data/Data_Dtup_Process"; } 파일 확장자 체크 : E if(bExt_03) { String origName =
			 * jsonObject.getString("filePath"); String upldName = b_seq + "_" +
			 * jsonObject.getString("fileName"); LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" +
			 * upldName); //파일이동 if(bbs_group_seq.equals("1000")) { //임시
			 * FileUtil.fileMove(path_d+origName, path_c, upldName);
			 * FileUtil.fileRename(path_d, origName, upldName); } else {
			 * FileUtil.fileRename(path_d, origName, upldName); }
			 * LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" +
			 * String.valueOf(jsonObject.getLong("fileSize"))); map_d.put("real_nm",
			 * origName); map_d.put("file_size",
			 * String.valueOf(jsonObject.getLong("fileSize"))); map_d.put("file_type", "");
			 * map_d.put("file_ext", ""); map_d.put("save_nm", upldName);
			 * 
			 * dtupService.insertAppend(map_d); } }
			 */
			// 데이터첨부파일(변경)
			Map<String, String> map_d = new HashMap<String, String>();
			map_d.put("b_seq", b_seq);

			// JSONArray file_info = new JSONArray(paramMap.get("file_info"));
			// LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info);
			String filePath = paramMap.get("filePath");
			String fileSize = paramMap.get("fileSize");
			String fileName = paramMap.get("fileName");			
			String filePath2 = paramMap.get("filePath2");
			String fileSize2 = paramMap.get("fileSize2");
			String fileName2 = paramMap.get("fileName2");
			
			System.out.println("filePath : "+ filePath+ " fileSize : "+ fileSize + "fileName : "+ fileName);
			System.out.println("filePath2 : "+ filePath2+ " fileSize2 : "+ fileSize2 + "fileName2 : "+ fileName2);
			
			if (filePath != null && filePath.length() > 0) {
				// JSONObject jsonObject = file_info.getJSONObject(0);
				/* 파일 확장자 체크 : S */
				boolean bExt_03 = Util.fileExtCheck(fileName);
				if (!bExt_03) {
					model.addAttribute("result_insert", "ext");
					return "data/Data_Dtup_Process";
				}
				/* 파일 확장자 체크 : E */
				if (bExt_03) {
					String fullPath = filePath;
					String fullPath2 = filePath2;
					int cut1 = StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1;
					int cut2 = StringUtils.ordinalIndexOf(fullPath2, "/", 2) + 1;
					String dirPath = fullPath.substring(0, cut1);
					String dirPath2 = fullPath2.substring(0, cut2);

					String fileOrgNm = fullPath.substring(cut1);
					String fileOrgNm2 = fullPath2.substring(cut2);
				
					LOG.debug("@@@@@@@@@@@@@@@@@[ fullPath]" + fullPath);
					LOG.debug("@@@@@@@@@@@@@@@@@[ fullPath2]" + fullPath2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ cut1]" + cut1);
					LOG.debug("@@@@@@@@@@@@@@@@@[ cut2]" + cut2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ dirPath]" + dirPath);
					LOG.debug("@@@@@@@@@@@@@@@@@[ dirPath2]" + dirPath2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileOrgNm]" + fileOrgNm);
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileOrgNm2]" + fileOrgNm2);
					
					
					String origName = fileOrgNm;
					String origName2 = fileOrgNm2;
					String findStr = paramMap.get("b_seq") + "_";
					String upldName = "";
					String upldName2 = "";
					if (fileName.indexOf(findStr) > -1) {
						upldName = fileName;
						upldName2 = fileName2;
					} else {
						upldName = paramMap.get("b_seq") + "_" + fileName;
						upldName2 = paramMap.get("b_seq") + "_" + fileName2;
					}
					LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" + upldName);
					LOG.debug("@@@@@@@@@@@@@@@@@[ upldName2]" + upldName2);
					// 파일이동
					if (bbs_group_seq.equals("1000")) {
//임시					FileUtil.fileMove(path_d+origName, path_c, upldName);
						FileUtil.fileRename(path_d, origName, upldName);
						FileUtil.fileRename(path_d, origName2, upldName2);
					} else {
						FileUtil.fileRename(path_d, origName, upldName);
						FileUtil.fileRename(path_d, origName2, upldName2);
					}
					
					LOG.debug("          file_type[" + paramMap.get("file_type") + "]");
					
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileName]" + fileName);
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" + fileSize);
					LOG.debug("@@@@@@@@@@@@@@@@@[ filePath]" + filePath);
					LOG.debug("@@@@@@@@@@@@@@@@@[ file_type]" + paramMap.get("file_type"));
					LOG.debug("@@@@@@@@@@@@@@@@@[ origName]" + origName);
					LOG.debug("@@@@@@@@@@@@@@@@@[ save_nm]" + upldName);
					
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileName2]" + fileName2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize2]" + fileSize2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ filePath2]" + filePath2);				
					LOG.debug("@@@@@@@@@@@@@@@@@[ origName2]" + origName2);
					LOG.debug("@@@@@@@@@@@@@@@@@[ save_nm2]" + upldName2);
					
					
					map_d.put("real_nm", origName);
					map_d.put("file_size", fileSize);
					map_d.put("file_type", paramMap.get("file_type"));
					map_d.put("file_ext", "");
					map_d.put("save_nm", upldName);
					
					map_d.put("save_nm2", upldName2);
					map_d.put("real_nm2", origName2);
					map_d.put("file_size2", fileSize2);

					dtupService.insertAppend(map_d);
				}
			}

		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터업로드 등록 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_insert", result);

		return "data/Data_Dtup_Process";
	}

	/**
	 * 삭제한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_delete"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Delt_Process.do")
	public String dtupDelete(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)
			throws Exception {

		int result = 1; // 결과

		LOG.debug(" ########## Data_Dtup_Delt_Process.do ###########");
		LOG.debug("   b_seq[" + paramMap.get("b_seq") + "]");
		LOG.debug(" bbs_seq[" + paramMap.get("bbs_seq") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		result = dtupService.deleteAppend(paramMap);
		if (result > -1)
			result = dtupService.deleteBoard(paramMap);
		else
			result = -1;

		LOG.debug(" result[" + result + "]");

		model.addAttribute("result_delete", result);

		return "data/Data_Dtup_Process";
	}

	/**
	 * 수정 화면으로 이동한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Dtup_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Updt.do")
	public String dtupUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request,
			HttpSession session) throws Exception {
		RequestURIModel uriModel = Util
				.getRequestURIModel(request.getRequestURI().replaceAll(request.getContextPath(), "")); // 메뉴를 구성하기위한 설정
		LOG.debug(" uriModel[" + uriModel.toString() + "]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Data_Dtup_Updt.do ###########");
		LOG.debug("   b_seq[" + paramMap.get("b_seq") + "]");
		LOG.debug(" bbs_seq[" + paramMap.get("bbs_seq") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> dtupInfo = dtupService.selectDtupInfo(paramMap);

		model.addAttribute("dtupInfo", dtupInfo);
		model.addAttribute("b_seq", paramMap.get("b_seq"));
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		Map<String, String> map_00 = new HashMap<String, String>();
		String agcy_nm = (String) session.getAttribute("agcy_nm");
		if (auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if (auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		Map<String, String> map01 = new HashMap<String, String>();
		map01.put("codeid", "weather");
		Map<String, String> map02 = new HashMap<String, String>();
		map02.put("codeid", "road_situation");
		Map<String, String> map03 = new HashMap<String, String>();
		map03.put("codeid", "road_type_cd");
		Map<String, String> map04 = new HashMap<String, String>();
		map04.put("codeid", "autocar_driving_mode");
		Map<String, String> map05 = new HashMap<String, String>();
		map05.put("codeid", "act_info_type");
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("user_id", (String) session.getAttribute("user_id")); // 사용자id
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "car_type");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "autocar_level");
		Map<String, String> map09 = new HashMap<String, String>();
		map09.put("codeid", "mydata_attach_cd");

		List<?> bbs_list = codeService.selectBbsList(map_00);
		List<?> code_weather = codeService.selectSubCodeList(map01);
		List<?> code_road_situation = codeService.selectSubCodeList(map02);
		List<?> code_road_type_cd = codeService.selectSubCodeList(map03);
		List<?> code_driving_mode = codeService.selectSubCodeList(map04);
		List<?> code_act_info_type = codeService.selectSubCodeList(map05);
		List<?> car_list = codeService.selectCarList(map06);
		List<?> code_car_type = codeService.selectSubCodeList(map07);
		List<?> code_car_level = codeService.selectSubCodeList(map08);
		List<?> dataset_list = consService.selectDtupDataSetList(map06);
		List<?> mydata_attach_cd = codeService.selectSubCodeList(map09);

		model.addAttribute("bbs_list", bbs_list);
		model.addAttribute("code_weather", code_weather);
		model.addAttribute("code_road_situation", code_road_situation);
		model.addAttribute("code_road_type_cd", code_road_type_cd);
		model.addAttribute("code_driving_mode", code_driving_mode);
		model.addAttribute("code_act_info_type", code_act_info_type);
		model.addAttribute("car_list", car_list);
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_car_level", code_car_level);
		model.addAttribute("dataset_list", dataset_list);
		model.addAttribute("mydata_attach_cd", mydata_attach_cd);
		model.addAttribute("auth_id", (String) session.getAttribute("auth_id"));
		model.addAttribute("user_id", (String) session.getAttribute("user_id"));
		model.addAttribute("agcy_nm", agcy_nm);

		return "data/Data_Dtup_Updt.tiles";
	}

	/**
	 * 수정 한다.
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Updt_Process.do")
	public String dtupUpdateProcess(@RequestParam Map<String, String> paramMap, ModelMap model,
			MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; // 결과
		String bbs_group_seq = paramMap.get("bbs_group_seq");
		String pathLetter = propertiesService.getString("pathLetter"); // 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload");
		String path_v = pathUpload + "vehc" + pathLetter;
//임시		String path_c = pathUpload + "cits" + pathLetter;	//공공데이터
		String path_d = pathUpload + "dtup" + pathLetter; // 협의체(운영)
		path_d = "D:\\Share2\\dtup\\"; // 협의체(개발)
		String path_s = pathUpload + "dset" + pathLetter;

		if (bbs_group_seq == null || bbs_group_seq.equals("")) {
			if (paramMap.get("bbs_seq").substring(0, 1).equals("1")) {
				bbs_group_seq = "1000";
			} else {
				bbs_group_seq = "2000";
			}
		}

		LOG.debug(" ########## Data_Dtup_Updt_Process.do ###########");
		LOG.debug("              b_seq[" + paramMap.get("b_seq") + "]");
		LOG.debug("            bbs_seq[" + paramMap.get("bbs_seq") + "]");
		LOG.debug("        bbs_seq_old[" + paramMap.get("bbs_seq_old") + "]");
		LOG.debug("         b_from_day[" + paramMap.get("b_from_day") + "]");
		LOG.debug("           b_to_day[" + paramMap.get("b_to_day") + "]");
		LOG.debug("     b_important_yn[" + paramMap.get("b_important_yn") + "]");
		LOG.debug("            b_title[" + paramMap.get("b_title") + "]");
		LOG.debug("          b_content[" + paramMap.get("b_content") + "]");
		LOG.debug("         b_password[" + paramMap.get("b_password") + "]");
		LOG.debug("       driving_mode[" + paramMap.get("driving_mode") + "]");
		LOG.debug("            weather[" + paramMap.get("weather") + "]");
		LOG.debug("     road_situation[" + paramMap.get("road_situation") + "]");
		LOG.debug("       road_type_cd[" + paramMap.get("road_type_cd") + "]");
		LOG.debug("      act_info_type[" + paramMap.get("act_info_type") + "]");
		LOG.debug("           etc_info[" + paramMap.get("etc_info") + "]");
		LOG.debug("    vehicle_id_view[" + paramMap.get("vehicle_id_view") + "]");
		LOG.debug("         vehicle_id[" + paramMap.get("vehicle_id") + "]");
		LOG.debug("           car_type[" + paramMap.get("car_type") + "]");
		LOG.debug("          car_model[" + paramMap.get("car_model") + "]");
		LOG.debug(" movie_sensor_model[" + paramMap.get("movie_sensor_model") + "]");
		LOG.debug("        lidar_model[" + paramMap.get("lidar_model") + "]");
		LOG.debug("        radar_model[" + paramMap.get("radar_model") + "]");
		LOG.debug("      autocar_level[" + paramMap.get("autocar_level") + "]");
		LOG.debug("           bdwr_seq[" + paramMap.get("bdwr_seq") + "]");
		LOG.debug("        bdwr_ttl_nm[" + paramMap.get("bdwr_ttl_nm") + "]");
		LOG.debug("           bdwr_cts[" + paramMap.get("bdwr_cts") + "]");
		LOG.debug("          data_form[" + paramMap.get("data_form") + "]");
		LOG.debug("            file_up[" + paramMap.get("file_up") + "]");
		LOG.debug("             reg_id[" + session.getAttribute("user_id") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		try {
			// 파일
			Map<String, MultipartFile> files = multipartRequest.getFileMap();
			String newFileNM = "";

			// 차량정보 처리
			Map<String, String> map_v = new HashMap<String, String>();
			map_v.put("vehicle_id", paramMap.get("vehicle_id"));
			map_v.put("user_id", (String) session.getAttribute("user_id"));
			map_v.put("car_type", paramMap.get("car_type"));
			map_v.put("car_model", paramMap.get("car_model"));
			map_v.put("movie_sensor_model", paramMap.get("movie_sensor_model"));
			map_v.put("lidar_model", paramMap.get("lidar_model"));
			map_v.put("radar_model", paramMap.get("radar_model"));
			map_v.put("autocar_level", paramMap.get("autocar_level"));
			/* 파일 확장자 체크 : S */
			boolean bExt_01 = Util.fileExtCheck(files.get("attach_filename").getOriginalFilename());
			if (!files.get("attach_filename").isEmpty() && !bExt_01) {
				model.addAttribute("result_update", "ext");
				return "data/Data_Dtup_Process";
			}
			/* 파일 확장자 체크 : E */
			if (!files.get("attach_filename").isEmpty() && bExt_01) {
				map_v.put("file_size", String.valueOf(files.get("attach_filename").getSize()));
				newFileNM = paramMap.get("vehicle_id") + "_";
				String file_name = FileUtil.transferUploadFileNew(files.get("attach_filename"), path_v, newFileNM);
				map_v.put("attach_filename", file_name);
				map_v.put("at_file_yn", "Y");
			}
			if (paramMap.get("vehicle_id_view").equals("new")) {
				dtupService.insertCar(map_v);
			} else {
				dtupService.updateCar(map_v);
			}

			// 데이터셋 처리
			Map<String, String> map_s = new HashMap<String, String>();
			String bdwr_seq = paramMap.get("bdwr_seq");
			map_s.put("bdwr_seq", bdwr_seq);
			map_s.put("bbs_seq", paramMap.get("bbs_seq"));
			map_s.put("bdwr_ttl_nm", paramMap.get("bdwr_ttl_nm"));
			map_s.put("bdwr_cts", paramMap.get("bdwr_cts"));
			map_s.put("data_form", paramMap.get("data_form"));
			map_s.put("reg_id", (String) session.getAttribute("user_id"));
			map_s.put("bbs_group_seq", bbs_group_seq);
			// 차량첨부파일
			/* 파일 확장자 체크 : S */
			boolean bExt_02 = Util.fileExtCheck(files.get("file_data").getOriginalFilename());
			if (!files.get("file_data").isEmpty() && !bExt_02) {
				model.addAttribute("result_update", "ext");
				return "data/Data_Dtup_Process";
			}
			/* 파일 확장자 체크 : E */
			if (!files.get("file_data").isEmpty() && bExt_02) {
				map_s.put("file_size", String.valueOf(files.get("file_data").getSize()));
				newFileNM = bdwr_seq + "_";
				String file_name = FileUtil.transferUploadFileNew(files.get("file_data"), path_s, newFileNM);
				map_s.put("attach_filename", file_name);
				map_s.put("file_yn", "Y");
			}
			if (paramMap.get("dataset").equals("new")) {
				// 데이터셋 신규 아이디
				bdwr_seq = consService.sequenceBdwrSeq(paramMap);
				map_s.put("bdwr_seq", bdwr_seq);
				paramMap.put("bdwr_seq", bdwr_seq);
				consService.insertDataSet(map_s);
			} else {
				consService.updateDataSet(map_s);
			}

			// 게시글 수정
			paramMap.put("b_attach_cnt", "1");
			paramMap.put("reg_id", (String) session.getAttribute("user_id")); // 작성자
			dtupService.updateBoard(paramMap);

			
			String filePath = paramMap.get("filePath");
			String fileSize = paramMap.get("fileSize");
			String fileName = paramMap.get("fileName");
			
			String filePath2 = paramMap.get("filePath2");
			String fileSize2 = paramMap.get("fileSize2");
			String fileName2 = paramMap.get("fileName2");
			
			//System.out.println("filePath : "+ filePath+ " fileSize : "+ fileSize + "fileName : "+ fileName);
			//System.out.println("filePath2 : "+ filePath2+ " fileSize2 : "+ fileSize2 + "fileName2 : "+ fileName2);
			
			/*
			//Map<String, String> map = new HashMap<String, String> (); 
			for(int i = 0; i < 2; i++){ 
				//paramMap.get("key" + i, "value" + i); 
				//paramMap.get(i);
				System.out.println("paramMap : "+paramMap.get(i));
				 //paramMap.get("key" + i, "value" + i);				 
			}
*/
			
				
			if (filePath != null && filePath.length() > 0) { // dext5upload 적용
				// 데이터첨부파일
				Map<String, String> map_d = new HashMap<String, String>();
				map_d.put("b_seq", paramMap.get("b_seq"));
				// JSONArray file_info = new JSONArray(paramMap.get("file_info"));
				// LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info);
				if (filePath != null && filePath.length() > 0) {
					// JSONObject jsonObject = file_info.getJSONObject(0);
					// 파일 확장자 체크 : S
					boolean bExt_03 = Util.fileExtCheck(fileName);
					if (!bExt_03) {
						model.addAttribute("result_update", "ext");
						return "data/Data_Dtup_Process";
					}
					// 파일 확장자 체크 : E
					if (bExt_03) {
						String fullPath = filePath;
						int cut1 = StringUtils.ordinalIndexOf(fullPath, "/", 2) + 1;
						String dirPath = fullPath.substring(0, cut1);
						String fileOrgNm = fullPath.substring(cut1);
						String origName = fileOrgNm;
						String findStr = paramMap.get("b_seq") + "_";
						String upldName = "";
						if (fileName.indexOf(findStr) > -1) {
							upldName = fileName;
						} else {
							upldName = paramMap.get("b_seq") + "_" + fileName;
						}
						LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" + upldName);

						// 파일이동
						if (bbs_group_seq.equals("1000")) {
//임시						FileUtil.fileMove(path_d+origName, path_c, upldName);
							FileUtil.fileRename(path_d, origName, upldName);
						} else {
							FileUtil.fileRename(path_d, origName, upldName);
						}
						map_d.put("real_nm", origName);
						LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" + fileSize);
						map_d.put("file_size", fileSize);
						map_d.put("file_type", paramMap.get("file_type"));
						map_d.put("file_ext", "");
						map_d.put("save_nm", upldName);

						// 삭제 후 등록
						int rst = dtupService.deleteAppend(map_d);
						if (rst > -1)
							dtupService.insertAppend(map_d);
						else
							result = "0";
					}
				}
			}
			/*
			 * if(paramMap.get("file_up").equals("Y")) { //기존소스(dext5upload 변경전) //데이터첨부파일
			 * Map<String, String> map_d = new HashMap<String, String>(); map_d.put("b_seq",
			 * paramMap.get("b_seq")); JSONArray file_info = new
			 * JSONArray(paramMap.get("file_info"));
			 * LOG.debug("@@@@@@@@@@@@@@@@@[JSONArray]" + file_info); if(file_info.length()
			 * > 0) { JSONObject jsonObject = file_info.getJSONObject(0); 파일 확장자 체크 : S
			 * boolean bExt_03 = Util.fileExtCheck(jsonObject.getString("fileName"));
			 * if(!bExt_03) { model.addAttribute("result_update", "ext"); return
			 * "data/Data_Dtup_Process"; } 파일 확장자 체크 : E if(bExt_03) { String origName =
			 * jsonObject.getString("filePath"); String upldName = paramMap.get("b_seq") +
			 * "_" + jsonObject.getString("fileName");
			 * LOG.debug("@@@@@@@@@@@@@@@@@[ upldName]" + upldName); //파일이동
			 * if(bbs_group_seq.equals("1000")) { //임시 FileUtil.fileMove(path_d+origName,
			 * path_c, upldName); FileUtil.fileRename(path_d, origName, upldName); } else {
			 * FileUtil.fileRename(path_d, origName, upldName); } map_d.put("real_nm",
			 * origName); LOG.debug("@@@@@@@@@@@@@@@@@[ fileSize]" +
			 * String.valueOf(jsonObject.getLong("fileSize"))); map_d.put("file_size",
			 * String.valueOf(jsonObject.getLong("fileSize"))); map_d.put("file_type", "");
			 * map_d.put("file_ext", ""); map_d.put("save_nm", upldName);
			 * 
			 * //삭제 후 등록 int rst = dtupService.deleteAppend(map_d); if(rst > -1)
			 * dtupService.insertAppend(map_d); else result = "0"; } } }
			 */
		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 데이터업로드 수정 실패 : " + e.toString());
			result = "0";
		}

		model.addAttribute("result_update", result);
		model.addAttribute("b_seq", paramMap.get("b_seq"));
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));

		return "data/Data_Dtup_Process";
	}

	/**
	 * 차량ID 중복확인
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_Car_IsExist.do")
	public String dtupCarIsExist(@RequestParam Map<String, String> paramMap, ModelMap model) throws Exception {

		LOG.debug(" ########## Data_Dtup_Car_IsExist.do ###########");
		LOG.debug("   vehicle_id[" + paramMap.get("vehicle_id") + "]");

		int result = dtupService.selectCarIsExist(paramMap);

		model.addAttribute("result_exist", result);

		return "data/Data_Dtup_Car_IsExist_Process";
	}

	/**
	 * 데이터셋 데이터 조회
	 * 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Dtup_DataSet_Info.do")
	public String dtupDataSetInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session)
			throws Exception {

		LOG.debug(" ########## Data_Dtup_DataSet_Info.do ###########");
		LOG.debug("   bdwr_seq[" + paramMap.get("bdwr_seq") + "]");
		LOG.debug("    bbs_seq[" + paramMap.get("bbs_seq") + "]");

		/* URL접근 방지 : S */
		String user_id = (String) session.getAttribute("user_id");
		String auth_id = (String) session.getAttribute("auth_id");
		if (user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101")
				|| auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> dsetInfo = consService.selectDataSetInfo(paramMap);

		model.addAttribute("dsetInfo", dsetInfo);
		model.addAttribute("bdwr_seq", paramMap.get("bdwr_seq"));
		model.addAttribute("bbs_seq", paramMap.get("bbs_seq"));
		model.addAttribute("auth_id", auth_id);

		return "data/Data_Dtup_DataSet_Process";
	}


}
