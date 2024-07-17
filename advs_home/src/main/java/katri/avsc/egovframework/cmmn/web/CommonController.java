package katri.avsc.egovframework.cmmn.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import katri.avsc.com.core.Util;
import katri.avsc.egovframework.cmmn.util.RequestURIModel;

/**
 * 공통 컨트롤러
 * @author jw
 */
@Controller
@RequestMapping(value = "/tiles/")
public class CommonController {

	/**
	 * 왼쪽 메뉴
	 * @param paramMap
	 * @param model
	 * @return "Index"
	 * @exception Exception
	 */
	@RequestMapping(value = "Left_Menu.do")
	public String goMainPage(@RequestParam Map<String, String> paramMap, ModelMap model, HttpServletRequest request) throws Exception {
		String sPath = paramMap.get("sPath");
		RequestURIModel uriModel = Util.getRequestURIModel(sPath); //메뉴를 구성하기위한 설정
		model.addAttribute("uriModel", uriModel);
		
		return "tiles/Left_Menu"; 
	}
}
