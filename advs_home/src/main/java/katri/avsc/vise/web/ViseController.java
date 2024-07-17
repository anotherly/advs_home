package katri.avsc.vise.web;

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
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;
import katri.avsc.vise.service.ViseService;

/**
 * 권한신청
 * @author jwchoi
 */
@Controller
public class ViseController {
	
	/** EgovSampleService */
	@Resource(name = "viseService")
	ViseService viseService;

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	private static final Log LOG = LogFactory.getLog(ViseController.class.getName());

	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;
	

	/**
	 * 권한신청
	 * @param model
	 * @return "Power_Rights_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_List.do")
	public String rightsList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		return "vise/Vise_Auth_List.tiles";
	}

	/**
	 * 회원동의
	 * @param model
	 * @return "Power_Rights_Term"
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_Term.do")
	public String rightsTerm(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Data_Uphs_List.do ###########");
		LOG.debug(" auth_id["+paramMap.get("auth_id")+"]");
		LOG.debug(" user_id["+(String)session.getAttribute("user_id")+"]");

		model.addAttribute("auth_id", paramMap.get("auth_id"));

		return "vise/Vise_Auth_Term.tiles";
	}

	/**
	 * 권한신청
	 * @param model
	 * @return "Power_Rights_Term"
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_Inst.do")
	public String rightsInst(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Power_Rights_Inst.do ###########");
		LOG.debug(" auth_id["+paramMap.get("auth_id")+"]");
		LOG.debug(" user_id["+(String)session.getAttribute("user_id")+"]");
		LOG.debug(" user_nm["+(String)session.getAttribute("user_nm")+"]");
		LOG.debug(" agcy_nm["+(String)session.getAttribute("agcy_nm")+"]");

		model.addAttribute("auth_id", paramMap.get("auth_id"));
		model.addAttribute("user_id", (String)session.getAttribute("user_id"));
		model.addAttribute("user_nm", (String)session.getAttribute("user_nm"));
		model.addAttribute("agcy_nm", (String)session.getAttribute("agcy_nm"));

		return "vise/Vise_Auth_Inst.tiles";
	}

	/**
	 * 가입확인
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_IsExist.do")
	public String rightsIsExist(@RequestParam Map<String, String> paramMap, ModelMap model) throws Exception {
		
		LOG.debug(" ########## Power_Rights_IsExist.do ###########");
		LOG.debug(" user_id["+paramMap.get("user_id")+"]");
		
		int result = viseService.selectRightsIsExist(paramMap);
		
		model.addAttribute("result_exist", result);
		
		return "vise/Vise_Auth_IsExist_Process";
	} 

	/**
	 * 권한 요청 처리
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_Inst_Process.do")
	public String rightsInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

		String result = "1"; //결과
		String mailHost = propertiesService.getString("mailHost");	//smtp host
		String mailPort = propertiesService.getString("mailPort");	//smtp port
		String mailUser = propertiesService.getString("mailUser");	//전송메일 계정
		String mailPwrd = propertiesService.getString("mailPwrd");
		String mailAdmn = propertiesService.getString("mailAdmn");	//담당자 메일

		LOG.debug(" ########## Power_Rights_Inst_Process.do ###########");
		LOG.debug("   department_nm["+paramMap.get("department_nm")+"]");
		LOG.debug("           email["+paramMap.get("email")+"]");
		LOG.debug("         auth_id["+paramMap.get("auth_id")+"]");
		LOG.debug("         user_id["+session.getAttribute("user_id")+"]");
		LOG.debug("         user_nm["+session.getAttribute("user_nm")+"]");

		try{
			paramMap.put("user_id", (String)session.getAttribute("user_id")); //작성자
			paramMap.put("user_nm", (String)session.getAttribute("user_nm"));
			paramMap.put("agency_cd", paramMap.get("agency_cd"));
			paramMap.put("rmk", paramMap.get("email"));
			paramMap.put("auth_cd", paramMap.get("auth_id"));
			paramMap.put("use_yn", "N");
			paramMap.put("class_id", "102");
			paramMap.put("appor_status", "101");	// 101:승인요청

			//운행정보 등록
			viseService.insertRights(paramMap);
			//관리자 자동 메일
			String subject = "권한요청 : 자율주행 공유센터 권한 승인요청";
			String text = "[자율주행 공유센터 권한 승인요청이 접수되었습니다.] \n\n"
						+ "* ID : " + session.getAttribute("user_id") + "\n\n"
						+ "* 이름 : " + session.getAttribute("user_nm") + "\n\n"
						+ "* 기관 : " + paramMap.get("agency_nm") + "\n\n"
						+ "* E-Mail : " + paramMap.get("email");
			//Mail.mailSend(mailHost, mailPort, mailUser, mailPwrd, mailAdmn, subject, text);
			// sms로 변경되어야 함
			
		} catch (RuntimeException e) {
			LOG.info("[DB Exception] 권한 승인요청 실패 : ");
			result = "0";
		}

		model.addAttribute("result_insert", result);
		model.addAttribute("auth_id", paramMap.get("auth_id"));

		return "vise/Vise_Auth_Process";
	}

	/**
	 * 결과 팝업
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Eval_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "/supervise/Power_Rights_Popup.do")
	public String rightsPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Power_Rights_Popup.do ###########");

		return "vise/Vise_Auth_Popup";
	}


	/**
	 * 임시 권한신청
	 * @param model
	 * @return "Temp_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "/temp/Temp_List.do")
	public String tempList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## Temp_List.do ###########");

		List<?> resultList = viseService.selectReqConfirmList(paramMap);
		model.addAttribute("resultList", resultList);

		return "temp/Temp_List.tiles";
	}


	/**
	 * 요청승인
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_update"
	 * @exception Exception
	 */
	@RequestMapping(value = "/temp/Temp_Process.do")
	public String tempProcess(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {

		String result = "1"; //결과

		LOG.debug(" ########## Temp_Process.do ###########");
		LOG.debug("     tp["+paramMap.get("tp")+"]");
		LOG.debug("  reqid["+paramMap.get("reqid")+"]");
		LOG.debug(" userid["+paramMap.get("userid")+"]");
		LOG.debug(" reg_id["+session.getAttribute("user_id")+"]");

		try{
			String tp = paramMap.get("tp");
			paramMap.put("reg_id", (String)session.getAttribute("user_id")); //작성자
			paramMap.put("cnclNote", "");
			paramMap.put("apporStatus", "102");

			if(tp.equals("T")) {
				paramMap.put("reqId", paramMap.get("reqid"));
				viseService.updateReqConfirm_T(paramMap);
			} else if(tp.equals("U")) {
				paramMap.put("reqId", paramMap.get("userid"));
				viseService.updateReqConfirm_U(paramMap);
			}

		}catch (RuntimeException e) {
			LOG.info("[DB Exception] 임시 요청승인 실패 : "+ e.toString());
			result = "0";
		}
		
		model.addAttribute("result_update", result);

		return "temp/Temp_Process";
	}



}
