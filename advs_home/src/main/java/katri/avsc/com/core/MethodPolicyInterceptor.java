package katri.avsc.com.core;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import javax.servlet.http.*;

import java.io.PrintWriter;
import java.util.*;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

// 예시 서비스 (실제 패키지/메서드명에 맞게 변경)

public class MethodPolicyInterceptor extends HandlerInterceptorAdapter {

    // 보호 대상 URL (정규식) — 필요시 추가
//    private static final Pattern INFO_PATH = Pattern.compile("^/duty/driving/Duty_Drvg_Info\\.do$");
//    private static final Pattern LIST_PATH = Pattern.compile("^/duty/driving/Duty_Drvg_List\\.do$");

    private static final Pattern DUTY_ALL          = Pattern.compile("^/duty/.*$");
    private static final Pattern SHARING_CAR_ALL   = Pattern.compile("^/sharing/car/.*$");
    private static final Pattern CENTER_ALL   = Pattern.compile("^/center/.*$");
    
    // 세션에서 로그인 사용자 키
    private static final String SESSION_USER_KEY = "user_id";

    // 응답 정책
    private static final int UNAUTH_STATUS = HttpServletResponse.SC_FOUND; // 302 로그인 리다이렉트
    private static final String LOGIN_LOCATION = "https://tsum.kotsa.or.kr/tsum/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do";
    private static final String ERROR_LOCATION = "https://avds.kotsa.or.kr/common/error.jsp";
    private static final int IDOR_STATUS   = HttpServletResponse.SC_FORBIDDEN; // 403 (또는 404로 숨김 가능)
    private static final int METHOD_BLOCK  = HttpServletResponse.SC_METHOD_NOT_ALLOWED; // 405


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        final String ctx = request.getContextPath();
        final String uri = request.getRequestURI().substring(ctx.length()); // e.g. /duty/driving/Duty_Drvg_Info.do
        final String method = request.getMethod();                          // "GET","POST",...

        // 보호 대상만 정책 적용
        if (!isProtected(uri)) return true;

        // 1) GET 호출 시: 로그인 재검증
        if ("GET".equalsIgnoreCase(method)) {

            String userId = (String) request.getSession().getAttribute(SESSION_USER_KEY);
            if (!StringUtils.hasText(userId)) {
                // 비로그인 → 로그인 화면으로 유도(또는 401/403)
                if (UNAUTH_STATUS == HttpServletResponse.SC_FOUND) {
                    response.setStatus(UNAUTH_STATUS);
                    String msg = "로그인이 필요합니다.";
                    if (isAjax(request)) {
                        writeJsonError(response, HttpServletResponse.SC_UNAUTHORIZED, msg);
                    } else {
                        writeAlertAndRedirect(response, msg,LOGIN_LOCATION);
                    }
                } else {
                    response.sendError(UNAUTH_STATUS);
                }
                return false;
            }

            // GET + 파라미터 있으면 차단(404로 숨김)
            if (!request.getParameterMap().isEmpty()) {
            	
            	String msg = "유효하지 않은 접근입니다";
                if (isAjax(request)) {
                    writeJsonError(response, HttpServletResponse.SC_UNAUTHORIZED, msg);
                } else {
                    writeAlertAndRedirect(response, msg, ERROR_LOCATION);
                }
                return false;
            }
            // GET + 파라미터 없음 → 템플릿만 렌더(컨트롤러로 진행)
            return true;
        }

        // 4) POST 는 정상 흐름 (컨트롤러 내에서 다시 권한검증 권장)
        if ("POST".equalsIgnoreCase(method)) {
            return true;
        }

        // 5) 기타 메서드(DELETE/PUT/TRACE 등) 차단
        response.setHeader("Allow", "GET, POST");
        response.sendError(METHOD_BLOCK);
        return false;
    }

    private boolean isProtected(String uri) {
        return DUTY_ALL.matcher(uri).matches()
                || SHARING_CAR_ALL.matcher(uri).matches()
        		|| CENTER_ALL.matcher(uri).matches()
        		;
    }
    
    
    //아래는 향후에 공통함수로 뺄것...
    private void writeAlertAndBack(HttpServletResponse response, String message) throws Exception {
        response.reset(); // 혹시 이전에 버퍼에 쌓였던 것 제거
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!doctype html><html><head><meta charset='utf-8'></head><body>");
            out.println("<script>");
            out.println("alert(" + toJsString(message) + ");");
            out.println("history.back();");
            out.println("</script>");
            out.println("</body></html>");
            out.flush();
        }
    }

    private void writeAlertAndRedirect(HttpServletResponse response, String message, String url) throws Exception {
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!doctype html><html><head><meta charset='utf-8'></head><body>");
            out.println("<script>");
            out.println("alert(" + toJsString(message) + ");");
            out.println("location.href=" + toJsString(url) + ";");
            out.println("</script>");
            out.println("</body></html>");
            out.flush();
        }
    }

    /** XSS/따옴표 깨짐 방지용 JS 문자열 인코딩 */
    private String toJsString(String s) {
        if (s == null) return "''";
        String r = s.replace("\\", "\\\\")
                    .replace("'", "\\'")
                    .replace("\"", "\\\"")
                    .replace("\r", "\\r")
                    .replace("\n", "\\n")
                    .replace("</", "<\\/"); // </script> 깨기 방지
        return "'" + r + "'";
    }

    private boolean isAjax(HttpServletRequest req) {
        String h = req.getHeader("X-Requested-With");
        return h != null && "XMLHttpRequest".equalsIgnoreCase(h);
    }

    private void writeJsonError(HttpServletResponse response, int status, String message) throws Exception {
        response.reset();
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        response.setStatus(status);
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"success\":false,\"message\":" + toJsString(message) + "}");
            out.flush();
        }
    }
}
