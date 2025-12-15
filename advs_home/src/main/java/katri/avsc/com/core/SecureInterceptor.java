package katri.avsc.com.core;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import katri.avsc.open.web.PublicNormalDsetController;

/**
 * 컨트롤러 수행전에 먼저 처리해서 
 * 리턴값이 false 이면 컨트롤러 로 접근하지 못함
 */
public class SecureInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(SecureInterceptor.class);

	/**
	 * 컨트롤러 수행전에 먼저 처리해서 
	 * 리턴값이 false 이면 컨트롤러 안탐
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		logger.debug("♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠ START INTERCEPOTER ♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠");
		boolean rst = Util.paramChk(request.getParameterMap());
		//리스폰스 타입을 printer wirter 객체보다 먼저 만들어야
		// 한글이 ?로 깨지지 않음
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		if(!rst) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('특수문자 <, >, #, $ 는 사용이 불가합니다.'); history.go(-1);</script>");
		    out.flush();
		    response.flushBuffer();
		    out.close();	
		}
		return rst;
	}

	/**
	 * 컨트롤러 끝나고 탐
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	/**
	 * 
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}

} // end class