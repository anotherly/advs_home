package katri.avsc.com.web;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DwhsService;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * 운행정보보고 > 장치변경
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/common")
public class CodeController {

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	/** EgovSampleService */
	@Resource(name = "dwhsService")
	DwhsService dwhsService;

	private static final Log LOG = LogFactory.getLog(CodeController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * 임시운행등록번호 등록 요청 팝업
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Tpsv_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Tpsv_Popup.do")
	public String tpsvPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);
System.out.println(paramMap);
		LOG.debug(" ########## Duty_Tpsv_Popup.do ###########");
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
		Map<String, String> map02 = new HashMap<String, String>();
		
		map01.put("codeid", "power_source");
		List<?> code_power_source = codeService.selectSubCodeList(map01);
		List<?> tmp_race_agency = codeService.selectDutyList(map02);  //임시운행기관조회

		model.addAttribute("code_power_source", code_power_source);
		model.addAttribute("tmp_race_agency", tmp_race_agency); 

		return "duty/Duty_Tpsv_Popup";
	}

	/**
	 * 임시운행등록번호 중복확인
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Tpsv_IsExist.do")
	public String tpsvIsExist(@RequestParam Map<String, String> paramMap, ModelMap model) throws Exception {
		
		LOG.debug(" ########## Duty_Tpsv_IsExist.do ###########");
		LOG.debug("   tmp_race_number["+paramMap.get("tmp_race_number")+"]");
		
		int result = codeService.selectTmpNoIsExist(paramMap);
		
		model.addAttribute("result_exist", result);
		
		return "duty/Duty_Tpsv_IsExist_Process";
	} 

	/**
	 * 임시운행등록번호 등록 요청 처리
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Tpsv_Inst_Process.do")
	public String tpsvInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {

		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + "tpsv" + pathLetter;

		String mailHost = propertiesService.getString("mailHost");	//smtp host
		String mailPort = propertiesService.getString("mailPort");	//smtp port
		String mailUser = propertiesService.getString("mailUser");	//전송메일 계정
		String mailPwrd = propertiesService.getString("mailPwrd");
		String mailAdmn = propertiesService.getString("mailAdmn");	//담당자 메일

		LOG.debug(" ########## Duty_Tpsv_Inst_Process.do ###########");
		LOG.debug("   tmp_race_number["+paramMap.get("tmp_race_number")+"]");
		LOG.debug("   tmp_race_agency["+paramMap.get("tmp_race_agency")+"]");
		LOG.debug(" ins_letter_number["+paramMap.get("ins_letter_number")+"]");
		LOG.debug("     ins_init_date["+paramMap.get("ins_init_date")+"]");
		LOG.debug("         car_model["+paramMap.get("car_model")+"]");
		LOG.debug("      power_source["+paramMap.get("power_source")+"]");
		LOG.debug("           user_id["+session.getAttribute("user_id")+"]");

		/**
		 * 2019.01.28 임시운행번호 보험일자를 제외하고 삭제 요청 반영
		 */
		//첨부파일 처리
//		Map<String, MultipartFile> files = multipartRequest.getFileMap();
//		String newFileNM = "";
		/* 파일 확장자 체크 : S */
//		boolean bExt = Util.fileExtCheck(files.get("file_deed").getOriginalFilename());
//		if(!files.get("file_deed").isEmpty() && !bExt) {
//			model.addAttribute("result_insert", "ext");
//			return "duty/Duty_Tpsv_Process";
//		}
		/* 파일 확장자 체크 : E */
		//주행모드변경전
//		if(!files.get("file_deed").isEmpty() && bExt) {
//			newFileNM = paramMap.get("tmp_race_number") + "_";
//			String file_name = FileUtil.transferUploadFileNew(files.get("file_deed"), pathUpload, newFileNM);
//			paramMap.put("deed_filename", file_name);
//		}else{
			paramMap.put("deed_filename", "");
//		}

		try{
			paramMap.put("appor_status", "101");	// 101:승인요청
			paramMap.put("user_id", (String)session.getAttribute("user_id")); //작성자
			//운행정보 등록
			codeService.insertTempOper(paramMap);
			//보험가입일자 이력 등록
			codeService.insertTempOperInsdateHis(paramMap);
			//관리자 자동 메일
			String subject = "승인요청 : 임시운행등록번호 등록 승인요청";
			String text = "[임시운행등록번호 승인요청이 접수되었습니다.] \n\n"
						+ "* 임시운행등록번호 : " + paramMap.get("tmp_race_number") + "\n\n"
						+ "* 임시운행기관 : " + paramMap.get("tmp_race_agency") + "\n\n"
						+ "* 보험증서번호 : " + paramMap.get("ins_letter_number") + "\n\n"
						+ "* 요청사용자 : " + session.getAttribute("user_id");
			//Mail.mailSend(mailHost, mailPort, mailUser, mailPwrd, mailAdmn, subject, text);

		} catch (RuntimeException e) {
			//LOG.info("[DB Exception] 임시운행등록번호 요청 실패 : " + e.toString());
			result = "0";
		}
		
		model.addAttribute("result_insert", result);
		
		return "duty/Duty_Tpsv_Process"; 		  
		/* return "duty/Duty_Tpsv_Uptdate_Process"; */
		
		
	}

	/**
	 * 지정한 파일을 다운로드 한다.
	 * @param paramMap - 다운로드할 파일 이름(file_nm)
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "File_Download.do")
	public String fileDownloadProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = "";
		String asIsPathUpload = propertiesService.getString("asIsPathUpload") + paramMap.get("dir_nm") + pathLetter;
		//관리자 페이지에서 업로드 경로와 일반사용자 경로가 다르므로...
		if (paramMap.get("dir_nm").equals("trnd")||paramMap.get("dir_nm").equals("notc")) {
			pathUpload = propertiesService.getString("pathUploadAdmin") + paramMap.get("dir_nm") + pathLetter;
		} else {
			pathUpload = propertiesService.getString("pathUpload") + paramMap.get("dir_nm") + pathLetter;
		}
		
		System.out.println("pathUpload >>>> "+ pathUpload);
		LOG.debug(" ########## File_Download.do ###########");
		// when searchWord is not null then encoding utf-8 
		if(paramMap.get("file_nm") != null) {
			try {
				String checkFile = paramMap.get("file_nm"); //잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
				//보안취약점 조치('19.11.25)
//				pathUpload = pathUpload.replaceAll(".", "");
//				pathUpload = pathUpload.replaceAll("/", "");
//				pathUpload = pathUpload.replaceAll("\\", "");
//				pathUpload = pathUpload.replaceAll("%", "");
				String down_file =  pathUpload + checkFile;
				//paramMap.put("file_nm", new String(down_file.getBytes("8859_1"),"utf-8")) ; //전자정부 표준프레임워크 3.2이상에는 인코딩안해도 됨.
				paramMap.put("file_nm", down_file);
			} catch (RuntimeException e1) {
				LOG.info("[Download File] 실패0 : ");
			}
			String filename = paramMap.get("file_nm");
			
			File file = new File(filename);
			LOG.debug("################### Download File : File Name ["+filename+"], File Length ["+file.length()+"] ");
			try {
				if(file.exists()){
					FileUtil.download(request, response, file);
					return null;
				}
				else{
					//파일이 존재하지 않을경우 alert창 띄움
					return "common/File_Exist";
				}
			} catch (ServletException e) {
				LOG.info("[Download File] 실패1 : ");
			} catch (IOException e) {
				LOG.info("[Download File] 실패2 : ");
			}
		}
		return "";
	}

	/**
	 * 지정한 파일을 다운로드 및 다운로드 이력 등록
	 * @param paramMap - 다운로드할 파일 이름(file_nm), 게시판 번호(b_seq)
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "File_Download_Hist.do")
	public String fileDownloadHistProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		String result = "1"; //결과
		String pathLetter = propertiesService.getString("pathLetter"); 	// 구분자 : "/", "\\"
		String pathUpload = propertiesService.getString("pathUpload") + paramMap.get("dir_nm") + pathLetter;
		
		LOG.debug(" ########## File_Download_Hist.do ###########");
		//파일 다운로드 처리
		// when searchWord is not null then encoding utf-8 
		if(paramMap.get("file_nm") != null) {
			try {
				String checkFile = paramMap.get("file_nm"); //잘못된 파라미터를 가려내기위해 특수기호 제거
				checkFile = checkFile.replaceAll("\\\\", "");
				checkFile = checkFile.replaceAll("/", "");
				checkFile = checkFile.replaceAll(";", "");
				String down_file =  pathUpload + checkFile;
				//paramMap.put("file_nm", new String(down_file.getBytes("8859_1"),"utf-8")) ; //전자정부 표준프레임워크 3.2이상에는 인코딩안해도 됨.
				paramMap.put("file_nm", down_file);
			} catch (RuntimeException e1) {
				LOG.info("[Download File] 실패0 : ");
			}
			String filename = paramMap.get("file_nm");
			
			File file = new File(filename);
			LOG.debug("################### Download File2 : File Name ["+filename+"], File Length ["+file.length()+"] ");
			try {
				if(file.exists()){
					FileUtil.download(request, response, file);
					//다운로드 이력 등록
					Map<String, String> map_01 = new HashMap<String, String>();
					map_01.put("b_seq", paramMap.get("b_seq"));
					map_01.put("eval_id", (String)session.getAttribute("user_id")); //사용자id
					try{
						LOG.debug(" ########## 다운로드 이력 등록 [insertDwhs] ###########");
						LOG.debug(" b_seq["+paramMap.get("b_seq")+"]");
						int dwCnt = dwhsService.selectDwhsIsExist(map_01);
						if(dwCnt == 0) {
							dwhsService.insertDwhs(map_01);
						}
						map_01.put("dl_id", (String)session.getAttribute("user_id")); //사용자id
						dwhsService.insertDlResult(map_01);
					}catch(NullPointerException ne){
						LOG.info("[DB Exception] 다운로드 이력등록  실패 : ");
						result = "3";
					}catch (Exception e) {
//						e.printStackTrace();
						LOG.info("[DB Exception] 다운로드 이력등록  실패 : ");
						result = "3";
					}
				} else {
					//파일이 존재하지 않을경우 alert창 띄움
					result = "2";
				}
			} catch (ServletException e) {
				LOG.info("[Download File] 실패1 : ");
			} catch (IOException e) {
				LOG.info("[Download File] 실패2 : ");
			}
		}

		model.addAttribute("result", result);
		if(result.equals("1")) {
			return null;
		} else {
			return "common/File_Process";
		}
	}

	/**
	 * 임시운행등록번호 보험가입일자 수정 요청 팝업
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Duty_Tpsv_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "Duty_Tpsv_Insdate_Popup.do")
	public String tpsvInsdatePopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Duty_Tpsv_Insdate_Popup.do ###########");
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
//		System.out.println("### paramMap : " + paramMap);



		
		Map<String, String> input = new HashMap<String, String>();
		input.put("tmp_race_number", paramMap.get("tmp_race_number"));
		Map reMap = codeService.selectTempOperInfo(paramMap);
		
		model.addAttribute("reMap", reMap);

		return "duty/Duty_Tpsv_Insdate_Popup";
	}
	
		/**
		 * 임시운행등록번호 보험가입일자 수정  처리
		 * @param paramMap - 조회할 정보가 담긴 Map
		 * @param model
		 * @return "result_insert"
		 * @exception Exception
		 */
		@RequestMapping(value = "Duty_Tpsv_Insdate_Process.do")
		public String tpsvInsdateInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

			String result = "1"; //결과

			LOG.debug(" ########## Duty_Tpsv_Insdate_Process.do ###########");
			LOG.debug("   tmp_race_number["+paramMap.get("tmp_race_number")+"]");
			LOG.debug("     ins_init_date["+paramMap.get("ins_init_date")+"]");
			LOG.debug("           user_id["+session.getAttribute("user_id")+"]");


			try{
				paramMap.put("user_id", (String)session.getAttribute("user_id")); //작성자
				//보험가입일자 이력 등록
				codeService.insertTempOperInsdateHis(paramMap);
				//보험가입일자 수정
				codeService.updateTempOperInsdate(paramMap);
				
			} catch (RuntimeException e) {
				LOG.info("[DB Exception] 보험가입일자 수정 실패 : " + e.toString());
				result = "0";
			}
			
			model.addAttribute("result_insert", result);
			model.addAttribute("insInitDate", paramMap.get("ins_init_date"));
			return "duty/Duty_Tpsv_Insdate_Process";
		}		
		
		
		
		/**
		 * 임시운행등록번호 보험가입일자 수정 요청 팝업
		 * @param paramMap - 조회할 정보가 담긴 Map
		 * @param model
		 * @return "Duty_Tpsv_Popup"
		 * @exception Exception
		 */
		@RequestMapping(value = "Duty_Tpsv_Uptdate_Popup.do")
		public String tpsvUptdatePopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
			RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
			LOG.debug(" uriModel["+uriModel.toString()+"]");
			model.addAttribute("uriModel", uriModel);

			LOG.debug(" ########## Duty_Tpsv_Insdate_Popup.do ###########");
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
			//System.out.println("### paramMap : " + paramMap);
			
			Map<String, String> input = new HashMap<String, String>();
			input.put("tmp_race_number", paramMap.get("tmp_race_number"));
			Map reMap = codeService.selectTempOperInfo(paramMap);
			
			model.addAttribute("reMap", reMap);
			System.out.println("Duty_Tpsv_Uptdate_Popup");
			
			return "duty/Duty_Tpsv_Uptdate_Popup";
		}
		
		
		/**
		 * 임시운행등록번호 보험가입일자 수정  처리
		 * @param paramMap - 조회할 정보가 담긴 Map
		 * @param model
		 * @return "result_insert"
		 * @exception Exception
		 */
		@RequestMapping(value = "Duty_Tpsv_Uptdate_Process.do")
		public String tpsvUptdateInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpSession session) throws Exception {

			String result = "1"; //결과

			LOG.debug(" ########## Duty_Tpsv_Uptdate_Process.do ###########");
			LOG.debug("   tmp_race_number["+paramMap.get("tmp_race_number")+"]");
			LOG.debug("     ins_init_date["+paramMap.get("ins_init_date")+"]");
			LOG.debug("           user_id["+session.getAttribute("user_id")+"]");


			try{
				paramMap.put("user_id", (String)session.getAttribute("user_id")); //작성자
				//보험가입일자 이력 등록
				codeService.insertTempOperInsdateHis(paramMap);
				//보험가입일자 수정
				codeService.updateTempOperInsdate(paramMap);
				
			} catch (RuntimeException e) {
				LOG.info("[DB Exception] 보험가입일자 수정 실패 : " + e.toString());
				result = "0";
			}
			
			model.addAttribute("result_insert", result);
			model.addAttribute("insInitDate", paramMap.get("ins_init_date"));
			//System.out.println("Duty_Tpsv_Uptdate_Process");
			return "duty/Duty_Tpsv_Uptdate_Process";
		}
		
		@RequestMapping(value = "Data_Scenario_Popup.do")
		public String scenarioPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
			RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
			LOG.debug(" uriModel["+uriModel.toString()+"]");
			model.addAttribute("uriModel", uriModel);
			String url = "common/Normal_Scenario_Popup";
			if(paramMap.get("bbs_seq").toString().equals("3020") || paramMap.get("bbs_seq").toString().equals("2090")) {
				url = "common/Edge_Scenario_Popup";		
			}else if(paramMap.get("bbs_seq").toString().equals("3030") || paramMap.get("bbs_seq").toString().equals("2100")) {
				url = "common/V2X_Scenario_Popup";
			}
			
			
			LOG.debug(" ########## Data_Scenario_Popup.do ###########");
			/* URL접근 방지 : S */
			/*String user_id = (String)session.getAttribute("user_id");
			String auth_id = (String)session.getAttribute("auth_id");
			if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("102")) {
				model.addAttribute("rst_scrn", "duty");
				model.addAttribute("rst_user", user_id);
				model.addAttribute("rst_auth", auth_id);
				return "common/Auth_Process";
			}*/
			/* URL접근 방지 : E */
			model.addAttribute("bbsSeq", paramMap.get("bbs_seq"));			
			return url;
		}
}
