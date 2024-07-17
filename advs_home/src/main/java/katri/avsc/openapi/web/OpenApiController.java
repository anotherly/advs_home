package katri.avsc.openapi.web;

import java.io.BufferedReader;
import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import katri.avsc.com.core.Util;
import katri.avsc.com.service.CodeService;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;
import katri.avsc.openapi.service.OpenApiService;

/**
 * OpenAPI
 * @author developer
 */
@Controller
@RequestMapping(value = "/openapi")
public class OpenApiController {

	/** codeService */
	@Resource(name = "codeService")
	CodeService codeService;

	/** EgovSampleService */
	@Resource(name = "openApiService")
	OpenApiService openApiService;

	private static final Log LOG = LogFactory.getLog(OpenApiController.class.getName());
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService") //환경 설정
	protected EgovPropertyService propertiesService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Autowired
	private WebApplicationContext webApplicationContext;

	/**
	 * OpenAPI 신청 화면 이동
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "OpenAPI_Apply.do")
	public String OpenAPI_Apply(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## OpenAPI_Apply.do ###########");
		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")/* || auth_id.equals("101") || auth_id.equals("102")*/) {
			model.addAttribute("rst_scrn", "openapi");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		/* URL접근 방지 : E */

		paramMap.put("user_id", user_id); //세션에서 가져와서 적용
		Map<String, String> reMap = openApiService.selectOpenApiInfo(paramMap);
		
		model.addAttribute("result", reMap);
		
		return "openapi/OpenApi_Apply.tiles";
	}

	/**
	 * OpenAPI 신청 프로세스
	 * @param paramMap
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "OpenApi_Inst_Process.do")
	public String OpenAPI_Inst_Process(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## OpenApi_Inst_Process.do ###########");
		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")/* || auth_id.equals("101") || auth_id.equals("102")*/) {
			model.addAttribute("rst_scrn", "openapi");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		 
		String result = "1"; //결과
		
		try{
			paramMap.put("user_id", user_id); //세션에서 가져와서 적용
			Map<String, String> reMap = openApiService.selectOpenApiInfo(paramMap);
			if(reMap != null && !reMap.isEmpty()){
				result = "dupp";
			}else{
				paramMap.put("api_appr_code", "01");
				paramMap.put("reg_id", user_id);
				openApiService.insertOpenApi(paramMap);
			}
		}catch(NullPointerException e){
			model.addAttribute("result_insert", "ext");
		}catch(Exception e){
			//e.printStackTrace();
			model.addAttribute("result_insert", "ext");
		}
		
		model.addAttribute("result_insert", result);
		
		return "openapi/OpenApi_Process";
	}
	
	/**
	 * OpenAPI 수정 프로세스
	 * @param paramMap
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "OpenApi_Updt_Process.do")
	public String OpenApi_Updt_Process(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## OpenApi_Updt_Process.do ###########");
		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")/* || auth_id.equals("101") || auth_id.equals("102")*/) {
			model.addAttribute("rst_scrn", "openapi");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		 
		String result = "1"; //결과
		
		try{
			paramMap.put("user_id", user_id); //세션에서 가져와서 적용
			paramMap.put("update_id", user_id);
			openApiService.updateOpenApi(paramMap);
		}catch(NullPointerException e){
			model.addAttribute("result_update", "ext");
		}catch(Exception e){
			//e.printStackTrace();
			model.addAttribute("result_update", "ext");
		}
		
		model.addAttribute("result_update", result);
		
		return "openapi/OpenApi_Process";
	}	
	
	/**
	 * OpenAPI 신청취소 프로세스
	 * @param paramMap
	 * @param model
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "OpenApi_Delt_Process.do")
	public String OpenApi_Delt_Process(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## OpenApi_Delt_Process.do ###########");
		/* URL접근 방지 : S */
		String user_id = (String)session.getAttribute("user_id");
		String auth_id = (String)session.getAttribute("auth_id");
		if(user_id == null || user_id.equals("") || auth_id == null || auth_id.equals("")/* || auth_id.equals("101") || auth_id.equals("102")*/) {
			model.addAttribute("rst_scrn", "openapi");
			model.addAttribute("rst_user", user_id);
			model.addAttribute("rst_auth", auth_id);
			return "common/Auth_Process";
		}
		 
		String result = "1"; //결과
		
		try{
			paramMap.put("user_id", user_id); //세션에서 가져와서 적용
			openApiService.deleteOpenApi(paramMap);
		}catch(NullPointerException e){
			model.addAttribute("result_delete", "ext");
		}catch(Exception e){
			//e.printStackTrace();
			model.addAttribute("result_delete", "ext");
		}
		
		model.addAttribute("result_delete", result);
		
		return "openapi/OpenApi_Process";
	}	
	
	/**
	 * 사용방법 방법
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @param model
	 * @return "Data_Eval_Popup"
	 * @exception Exception
	 */
	@RequestMapping(value = "OpenApiManual_Popup.do")
	public String openaApiManualPopup(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		RequestURIModel uriModel = Util.getRequestURIModel(request.getRequestURI().replaceAll( request.getContextPath(), "")); //메뉴를 구성하기위한 설정
		LOG.debug(" uriModel["+uriModel.toString()+"]");
		model.addAttribute("uriModel", uriModel);

		LOG.debug(" ########## OpenApiManual_Popup.do ###########");

		return "openapi/OpenApiManual_Popup";
	}	
	
	/**
	 * OpenApi Return XML
	 * @param paramMap
	 * @param model
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/rest/xml/getOpenApiConsData.do", produces = "application/xml; charset=utf-8")
	@ResponseBody
	public String getOpenApiConsDataForXML(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpSession session) throws Exception {
		/**
		 * OPEN API 코드정의
		 * 00 : 성공
		 * 41 : Api Key 미입력
		 * 42 : 정의되지 않은 Api Key
		 * 43 : 승인되지 않은 Api Key
		 * 51 : 협의체데이터구분 미입력
		 * 52 : 존재하지 않은 협의체데이터구분
		 * 61 : 조회 된 협의체데이터 없음
		 * 99 : 알 수 없는 시스템 오류
		 */

		/**
		 * 협의체데이터구분 코드정의
		 * VDC : 차량거동정보
		 * DV : 주행영상정보
		 * SENSOR : 센서정보
		 * SDL : 자율주행학습정보
		 * FUSION : 융합정보
		 * V2X : V2X정보
		 * ESD : 기타자율주행정보
		 */
		String consAr[] = {"VDC", "DV", "SENSOR", "SDL", "FUSION", "V2X", "ESD"};
		String consCodeAr[] = {"2010", "2020", "2030", "2040", "2050", "2060", "2070"};
		
		String resultCode = "00";
		String resultMsg = "성공";
		String apiKey = paramMap.get("apiKey");
		String consType = paramMap.get("consType");
		Map<String, String> reMap = null;
		List list = null;
		StringBuffer xmlSB = new StringBuffer();
		
		BufferedReader br = null;
		
		try{
			paramMap.put("apiKey", apiKey);
			LOG.debug("### apiKey : " + apiKey);
			
			//xml헤더
			xmlSB.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
			
			//ApiKey 검증
			if("00".equals(resultCode)){
				if(apiKey != null && apiKey.trim().length() > 0){
					reMap = openApiService.selectApiKey(paramMap);
				}else{
					resultCode = "41";
					resultMsg = "Api Key 미입력";
				}
			}
			
			//ApiKey 검증 성공이면 데이터 가공
			if("00".equals(resultCode)){
				if(reMap != null && !reMap.isEmpty()){
					LOG.debug("### reMap : " + reMap);
					if(!"02".equals(reMap.get("apiApprCode"))){
						resultCode = "43";
						resultMsg = "승인되지 않은 Api Key";
					}
				}else{
					//ApiKey 검증 실패
					resultCode = "42";
					resultMsg = "정의되지 않은 Api Key";
				}
			}
			
			//협의체데이터구분 코드 검증
			if("00".equals(resultCode)){
				if(consType != null && consType.trim().length() > 0){
					int arIdx = 0;
					int okCnt = 0;
					for(String cons : consAr){
						if(cons.equals(consType)){
							okCnt++;
							paramMap.put("bbs_seq", consCodeAr[arIdx]);
							paramMap.put("bbs_group_seq", "2000");
						}
						arIdx++;
					}
					if(okCnt == 0){
						resultCode = "52";
						resultMsg = "존재하지 않은 협의체데이터구분";
					}
				}else{
					resultCode = "51";
					resultMsg = "협의체데이터구분 미입력";
				}
			}
			
			list = openApiService.selectConsList(paramMap);
			
			if("00".equals(resultCode)){
				if(list != null && !list.isEmpty()){
					
				}else{
					resultCode = "61";
					resultMsg = "조회 된 협의체데이터 없음";
				}
			}
			
			//헤더가공
			xmlSB.append("<response>\r\n");
			xmlSB.append("	<header>\r\n");
			xmlSB.append("		<resultCode>");
			xmlSB.append(resultCode);
			xmlSB.append("</resultCode>\r\n");
			xmlSB.append("		<resultMsg>");
			xmlSB.append(resultMsg);
			xmlSB.append("</resultMsg>\r\n");		
			xmlSB.append("</header>\r\n");
			if("00".equals(resultCode)){
				//성공일경우
				xmlSB.append("	<body>\r\n");
				xmlSB.append("		<items>\r\n");
				for(int i=0; i<list.size(); i++){
					Map map = (Map)list.get(i);
					xmlSB.append("		<item>\r\n");
					//데이터유형
					xmlSB.append("			<dataType>");
					xmlSB.append(map.get("dataTypeView"));
					xmlSB.append("</dataType>\r\n");
					//제목
					xmlSB.append("			<title>");
					xmlSB.append(map.get("bTitle"));
					xmlSB.append("</title>\r\n");
					//주행모드
					xmlSB.append("			<drivingMode>");
					xmlSB.append(map.get("drivingModeView"));
					xmlSB.append("</drivingMode>\r\n");
					//등록일시
					xmlSB.append("			<regDate>");
					xmlSB.append(map.get("regDateView"));
					xmlSB.append("</regDate>\r\n");
					
					//CLOB 처리
					StringBuffer clobSB = new StringBuffer();
					String clobStr = "";
					Clob clob = (java.sql.Clob)map.get("bContent");
					br = new BufferedReader(clob.getCharacterStream());
					while((clobStr = br.readLine()) != null){
						clobSB.append(clobStr);
					}
					//내용
					xmlSB.append("			<content>");
					xmlSB.append(clobSB.toString().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("&nbsp;", " ").replaceAll("\'", "&apos;"));
					xmlSB.append("</content>\r\n");
					LOG.debug("### content : " + xmlSB.toString());
					//기상상황
					xmlSB.append("			<weather>");
					xmlSB.append(map.get("weatherView"));
					xmlSB.append("</weather>\r\n");		
					//도로상황
					xmlSB.append("			<roadSituation>");
					xmlSB.append(map.get("roadSituationView"));
					xmlSB.append("</roadSituation>\r\n");		
					//차량모델
					xmlSB.append("			<carModel>");
					xmlSB.append(map.get("carModel"));
					xmlSB.append("</carModel>\r\n");		
					//영상센서모델
					xmlSB.append("			<movieSensorModel>");
					xmlSB.append(map.get("movieSensorModel"));
					xmlSB.append("</movieSensorModel>\r\n");		
					//라이다모델
					xmlSB.append("			<lidarModel>");
					xmlSB.append(map.get("lidarModel"));
					xmlSB.append("</lidarModel>\r\n");		
					//레이더모델
					xmlSB.append("			<radarModel>");
					xmlSB.append(map.get("radarModel"));
					xmlSB.append("</radarModel>\r\n");		
					
					xmlSB.append("</item>\r\n");
				}
				xmlSB.append("		</items>\r\n");
				xmlSB.append("	</body>\r\n");
			}
			xmlSB.append("</response>");
		}catch(NullPointerException e){
			xmlSB = new StringBuffer();
			resultCode = "99";
			resultMsg = "알 수 없는 시스템 오류";
			//헤더가공
			xmlSB.append("<response>\r\n");
			xmlSB.append("	<header>\r\n");
			xmlSB.append("		<resultCode>");
			xmlSB.append(resultCode);
			xmlSB.append("</resultCode>\r\n");
			xmlSB.append("		<resultMsg>");
			xmlSB.append(resultMsg);
			xmlSB.append("</resultMsg>\r\n");		
			xmlSB.append("</header>\r\n");
			return xmlSB.toString();
		}catch(Exception e){
			//e.printStackTrace();
			xmlSB = new StringBuffer();
			resultCode = "99";
			resultMsg = "알 수 없는 시스템 오류";
			//헤더가공
			xmlSB.append("<response>\r\n");
			xmlSB.append("	<header>\r\n");
			xmlSB.append("		<resultCode>");
			xmlSB.append(resultCode);
			xmlSB.append("</resultCode>\r\n");
			xmlSB.append("		<resultMsg>");
			xmlSB.append(resultMsg);
			xmlSB.append("</resultMsg>\r\n");		
			xmlSB.append("</header>\r\n");
			return xmlSB.toString();
		}finally {
			if(br != null){
				br.close();
			}
		}
		
		return xmlSB.toString();
		
	}
	
	/**
	 * OpenApi Return JSON
	 * @param paramMap
	 * @param model
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/rest/json/getOpenApiConsData.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List getOpenApiConsDataForJSON(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		/**
		 * OPEN API 코드정의
		 * 00 : 성공
		 * 41 : Api Key 미입력
		 * 42 : 정의되지 않은 Api Key
		 * 43 : 승인되지 않은 Api Key
		 * 51 : 협의체데이터구분 미입력
		 * 52 : 존재하지 않은 협의체데이터구분
		 * 61 : 조회 된 협의체데이터 없음
		 * 99 : 알 수 없는 시스템 오류
		 */

		/**
		 * 협의체데이터구분 코드정의
		 * VDC : 차량거동정보
		 * DV : 주행영상정보
		 * SENSOR : 센서정보
		 * SDL : 자율주행학습정보
		 * FUSION : 융합정보
		 * V2X : V2X정보
		 * ESD : 기타자율주행정보
		 */
		String consAr[] = {"VDC", "DV", "SENSOR", "SDL", "FUSION", "V2X", "ESD"};
		String consCodeAr[] = {"2010", "2020", "2030", "2040", "2050", "2060", "2070"};
		
		String resultCode = "00";
		String resultMsg = "성공";
		String apiKey = paramMap.get("apiKey");
		String consType = paramMap.get("consType");
		Map<String, String> reMap = null;
		List list = null;
		StringBuffer xmlSB = new StringBuffer();
		
		List jsonList = new ArrayList();
		
		try{
			paramMap.put("apiKey", apiKey);
			LOG.debug("### apiKey : " + apiKey);
			
			//xml헤더
			xmlSB.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n");
			
			//ApiKey 검증
			if("00".equals(resultCode)){
				if(apiKey != null && apiKey.trim().length() > 0){
					reMap = openApiService.selectApiKey(paramMap);
				}else{
					resultCode = "41";
					resultMsg = "Api Key 미입력";
				}
			}
			
			//ApiKey 검증 성공이면 데이터 가공
			if("00".equals(resultCode)){
				if(reMap != null && !reMap.isEmpty()){
					LOG.debug("### reMap : " + reMap);
					if(!"02".equals(reMap.get("apiApprCode"))){
						resultCode = "43";
						resultMsg = "승인되지 않은 Api Key";
					}
				}else{
					//ApiKey 검증 실패
					resultCode = "42";
					resultMsg = "정의되지 않은 Api Key";
				}
			}
			
			//협의체데이터구분 코드 검증
			if("00".equals(resultCode)){
				if(consType != null && consType.trim().length() > 0){
					int arIdx = 0;
					int okCnt = 0;
					for(String cons : consAr){
						if(cons.equals(consType)){
							okCnt++;
							paramMap.put("bbs_seq", consCodeAr[arIdx]);
							paramMap.put("bbs_group_seq", "2000");
						}
						arIdx++;
					}
					if(okCnt == 0){
						resultCode = "52";
						resultMsg = "존재하지 않은 협의체데이터구분";
					}
				}else{
					resultCode = "51";
					resultMsg = "협의체데이터구분 미입력";
				}
			}
			
			list = openApiService.selectConsList(paramMap);
			
			if("00".equals(resultCode)){
				if(list != null && !list.isEmpty()){
					
				}else{
					resultCode = "61";
					resultMsg = "조회 된 협의체데이터 없음";
				}
			}
			
			//헤더가공
			Map res = new HashMap();
			Map header = new HashMap();
			header.put("resultMsg", resultMsg);
			header.put("resultCode", resultCode);
			
			List items = new ArrayList();
			if("00".equals(resultCode)){
				//성공일경우
				
				for(int i=0; i<list.size(); i++){
					Map map = (Map)list.get(i);
					Map result = new HashMap();
					
					//CLOB 처리
					StringBuffer clobSB = new StringBuffer();
					String clobStr = "";
					Clob clob = (java.sql.Clob)map.get("bContent");
					BufferedReader br = new BufferedReader(clob.getCharacterStream());
					while((clobStr = br.readLine()) != null){
						clobSB.append(clobStr);
					}
					//레이더모델
					result.put("radarModel" , map.get("radarModel"));
					//라이다모델
					result.put("lidarModel", map.get("lidarModel"));
					//영상센서모델
					result.put("movieSensorModel", map.get("movieSensorModel"));
					//차량모델
					result.put("carModel", map.get("carModel"));
					//도로상황
					result.put("roadSituation", map.get("roadSituationView"));
					//기상상황
					result.put("weather", map.get("weatherView"));
					//내용
					result.put("content",  clobSB.toString().replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\"", "&quot;").replaceAll("&nbsp;", " ").replaceAll("\'", "&apos;"));
					//등록일시
					result.put("regDate", map.get("regDateView"));
					//주행모드
					result.put("drivingMode", map.get("drivingModeView"));
					//제목
					result.put("title", map.get("bTitle"));
					//데이터유형
					result.put("dataType", map.get("dataTypeView"));
					
					items.add(result);
				}
				res.put("items", items);
			}
			res.put("header", header);
			jsonList.add(res);
		}catch(NullPointerException e){
			jsonList = new ArrayList();
			Map res = new HashMap();
			Map header = new HashMap();
			resultCode = "99";
			resultMsg = "알 수 없는 시스템 오류";
			header.put("resultMsg", resultMsg);
			header.put("resultCode", resultCode);
			res.put("header", header);
			jsonList.add(res);
			return jsonList;	
		}catch(Exception e){
			//e.printStackTrace();
			jsonList = new ArrayList();
			Map res = new HashMap();
			Map header = new HashMap();
			resultCode = "99";
			resultMsg = "알 수 없는 시스템 오류";
			header.put("resultMsg", resultMsg);
			header.put("resultCode", resultCode);
			res.put("header", header);
			jsonList.add(res);
			return jsonList;
		} 
		
		return jsonList;
	}
}
