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

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.agcy.service.ConsService;
import katri.avsc.com.core.FileUtil;
import katri.avsc.com.core.Mail;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.data.service.DtupService;
import katri.avsc.data.service.UphsService;
import katri.avsc.egovframework.cmmn.util.PageSetting;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;


/**
 * My data > 내가올린자료
 * @author jwchoi
 */
@Controller
@RequestMapping(value = "/data/record")
public class CarInstController {
	
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
	 * @return "Data_Uphs_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Car_Inst.do")
	public String DtCarInsert(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("못타는이유");
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정

		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		Map<String, String> map_00 = new HashMap<String, String>();
//		String agcy_nm = (String)session.getAttribute("agcy_nm");
		if(auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if(auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		
		Map<String, String> map07 = new HashMap<String, String>();
		map07.put("codeid", "car_type");
		Map<String, String> map08 = new HashMap<String, String>();
		map08.put("codeid", "autocar_level");
		
		List<?> code_car_type = codeService.selectSubCodeList(map07);
		List<?> code_car_level = codeService.selectSubCodeList(map08);
		Map<String, String> mapUsr = new HashMap<String, String>();
		mapUsr.put("user_id", user_id); //사용자id
		int result = dtupService.selectCountYn(mapUsr);
		
		Map<String,String> carInfo = dtupService.selectCarInfo(mapUsr);
		
		model.addAttribute("code_car_type", code_car_type);
		model.addAttribute("code_car_level", code_car_level);
		model.addAttribute("result_exist", result);
		model.addAttribute("carInfo", carInfo);
		
		return "data/Data_Car_Inst.tiles";
	}

	/**
	 * 등록 한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "result_insert"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Car_Inst_Process.do")
	public String DtCarInsertProcess(@RequestParam Map<String, String> paramMap, ModelMap model, MultipartHttpServletRequest multipartRequest, HttpSession session) throws Exception {
		
		System.out.println("userId==="+paramMap.get("userId"));
		System.out.println("agcy_nm==="+(String)session.getAttribute("agcy_nm"));
		System.out.println("car_type==="+paramMap.get("car_type"));
		System.out.println("car_model==="+paramMap.get("car_model"));
		System.out.println("autocar_level==="+paramMap.get("autocar_level"));
		System.out.println("oprat_purps==="+paramMap.get("oprat_purps"));
		System.out.println("oprat_intrvl==="+paramMap.get("oprat_intrvl"));
		System.out.println("auth_id==="+(String)session.getAttribute("auth_id"));
		System.out.println("oprat_strt_dt===="+paramMap.get("oprat_strt_dt"));
		System.out.println("ins_init_strt_dt===="+paramMap.get("ins_init_strt_dt"));

		LOG.debug(" ########## Data_Dtup_Inst_Process.do ###########");
//		String b_seq = dtupService.sequenceBseq(paramMap);

		/* URL접근 방지 : S 
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		*/
		/* URL접근 방지 : E */

			//차량등록 처리
//			if(paramMap.get("vehicle_id_view").equals("new")) {
			Map<String, String> map_v = new HashMap<String, String>();
			map_v.put("tmp_race_num", paramMap.get("tmp_race_num"));
			map_v.put("agcy_nm",(String)session.getAttribute("agcy_nm"));
			map_v.put("user_id", (String)session.getAttribute("user_id"));
			map_v.put("oprat_strt_dt", paramMap.get("oprat_strt_dt"));
			map_v.put("oprat_end_dt", paramMap.get("oprat_end_dt"));
			map_v.put("oprat_purps", paramMap.get("oprat_purps"));
			map_v.put("oprat_intrvl", paramMap.get("oprat_intrvl"));
			map_v.put("car_type", paramMap.get("car_type"));
			map_v.put("car_model", paramMap.get("car_model"));
			map_v.put("user_nm", paramMap.get("user_nm"));
			map_v.put("autocar_level", paramMap.get("autocar_level"));
			map_v.put("reg_id", (String)session.getAttribute("user_id"));
			map_v.put("adres", paramMap.get("adres"));
			map_v.put("ins_init_strt_dt", paramMap.get("ins_init_strt_dt"));
			map_v.put("ins_init_end_dt", paramMap.get("ins_init_end_dt"));
			dtupService.insertCarIns(map_v);
			model.addAttribute("result_insert", "1");
//			}
			
		return "data/Data_Dtup_Process";
//			return "data/Data_Car_Inst.tiles";
	}
	
	/**
	 * 수정화면을 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Uphs_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Car_Updt.do")
	public String DtCarUpdateInfo(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		
//		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정

		/* URL접근 방지 : S
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E

		Map<String, String> map_00 = new HashMap<String, String>();
		String agcy_nm = (String)session.getAttribute("agcy_nm");
		if(auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if(auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		*/
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("user_id", (String)session.getAttribute("user_id")); //사용자id
//		Map<String, String> map07 = new HashMap<String, String>();
//		map07.put("codeid", "car_type");
//		Map<String, String> map08 = new HashMap<String, String>();
//		map08.put("codeid", "autocar_level");
//		Map<String, String> map09 = new HashMap<String, String>();
//		map08.put("tmp_race_num", "tmp_race_num");
		
//		List<?> code_car_type = codeService.selectSubCodeList(map07); //
//		List<?> code_car_level = codeService.selectSubCodeList(map08); //
		Map<String,String> carInfo = dtupService.selectCarInfo(map06);

//		model.addAttribute("code_car_type", code_car_type);
//		model.addAttribute("code_car_level", code_car_level);
//		model.addAttribute("auth_id", (String)session.getAttribute("auth_id"));
//		model.addAttribute("user_id", (String)session.getAttribute("user_id"));
		model.addAttribute("carInfo", carInfo);

		return "data/Data_Car_Updt.tiles";
	}
	
	/**
	 * 수정한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Car_Updt"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Car_Updt_Process.do")
	public String DtCarUpdate(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("user_id==="+paramMap.get("user_id"));
		System.out.println("sessiong_user_id===="+ (String)session.getAttribute("user_id"));
		System.out.println("agcy_nm==="+(String)session.getAttribute("agcy_nm"));
		System.out.println("car_type==="+paramMap.get("car_type"));
		System.out.println("car_model==="+paramMap.get("car_model"));
		System.out.println("autocar_level==="+paramMap.get("autocar_level"));
		System.out.println("oprat_purps==="+paramMap.get("oprat_purps"));
		System.out.println("oprat_intrvl==="+paramMap.get("oprat_intrvl"));
		System.out.println("oprat_strt_dt===="+paramMap.get("oprat_strt_dt"));
		System.out.println("ins_init_strt_dt===="+paramMap.get("ins_init_strt_dt"));
		System.out.println("ins_init_end_dt===="+paramMap.get("ins_init_end_dt"));
		System.out.println("user_nm===="+paramMap.get("user_nm"));
		
//		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정

		/* URL접근 방지 : S
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E

		Map<String, String> map_00 = new HashMap<String, String>();
		String agcy_nm = (String)session.getAttribute("agcy_nm");
		if(auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if(auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		*/
		Map<String, String> map_v = new HashMap<String, String>();
		map_v.put("user_id", (String)session.getAttribute("user_id")); //사용자id
		map_v.put("tmp_race_num", paramMap.get("tmp_race_num"));
		map_v.put("user_nm", paramMap.get("user_nm"));
		map_v.put("ins_init_strt_dt", paramMap.get("ins_init_strt_dt"));
		map_v.put("ins_init_end_dt", paramMap.get("ins_init_end_dt"));
		
		dtupService.updateCarInfo(map_v);
		
		model.addAttribute("result_update", "1");
		
//		return "data/Data_Car_Updt.tiles";
		return "data/Data_Dtup_Process";
	}
	
	/**
	 * 차량관리 리스트 조회한다. 
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Car_List"
	 * @exception Exception
	 */
	@RequestMapping(value = "Data_Car_List.do")
	public String DtCarList(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		
		LOG.debug(" ########## Data_Car_List.do ###########");
		LOG.debug("     authid["+(String)session.getAttribute("auth_id")+"]");
		String auth_id = (String)session.getAttribute("auth_id");
		int iPageNo = 1;	//현재 페이지

//		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정

		/* URL접근 방지 : S
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("") || auth_id.equals("101") || auth_id.equals("104")) {
			model.addAttribute("rst_scrn", "dtup");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E

		Map<String, String> map_00 = new HashMap<String, String>();
		String agcy_nm = (String)session.getAttribute("agcy_nm");
		if(auth_id != null && (auth_id.equals("102") || auth_id.equals("105"))) {
			map_00.put("bbs_group_seq", "2000");
			model.addAttribute("bbs_group_seq", "2000");
		} else if(auth_id != null && auth_id.equals("103")) {
			map_00.put("bbs_group_seq", "");
			model.addAttribute("bbs_group_seq", "");
		}
		*/	
		
		Map<String, String> map06 = new HashMap<String, String>();
		map06.put("user_id", (String)session.getAttribute("user_id")); //사용자id
		Map<String, String> map15 = new HashMap<String, String>();
		if(auth_id.equals("103")) {
			map15.put("userid", "");
		} else {
			paramMap.put("userid", map06.get("userid")); //사용자id
			map15.put("userid", (String)session.getAttribute("user_id"));
		}
		
		//paramMap.put("authid", auth_id); //권한
		
		PageSetting pageSetting = new PageSetting(); //페이지 클래스
		iPageNo = Util.setCurrentPage(paramMap.get("iPageNo"));
		pageSetting.setCurrentPageNo(iPageNo); //현재 페이지  
		pageSetting.setRecordCountPerPage(propertiesService.getInt("pageUnit")); //한페이지에 나열될 목록의 수
		pageSetting.setPageSize(propertiesService.getInt("pageSize")); //표출될 블럭 수
		
		paramMap.put("iPageNo", Integer.toString(iPageNo));//한페이지에 나열될 목록의 수
    	paramMap.put("firstIndex", Integer.toString(pageSetting.getFirstRecordIndex()));//현재 페이지 블록에서 처음 페이지
    	paramMap.put("lastIndex", Integer.toString(pageSetting.getLastRecordIndex()));//현재 페이지 블록에서 마지막 페이지
    	paramMap.put("recordCountPerPage", Integer.toString(pageSetting.getRecordCountPerPage()));//한페이지에 나열될 목록의 수
		
    	int totCnt = codeService.selectTempCareListTotCnt(map15);
    	
		Map<String,String> carInfo = dtupService.selectCarInfo(map06);
		List<?> code_tempoper = codeService.selectTempCareList(paramMap);
		
		pageSetting.setTotalRecordCount(totCnt);
		System.out.println(pageSetting);
		model.addAttribute("pageSetting", pageSetting);
		model.addAttribute("resultList", code_tempoper);
		model.addAttribute("carInfo", carInfo);

		return "data/Data_Car_List.tiles";
	}
	
}

