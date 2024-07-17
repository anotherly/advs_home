package katri.avsc.com.core;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;

//import net.sf.jxls.transformer.XLSTransformer;

/**
 * 엑셀 다운로드 클래스
 */
public class ExcelDownload {

    /**
     * 템플릿 파일을 이용하여 엑셀 파일을 다운로드한다
     */
    public void excelDown(HttpServletRequest request, HttpServletResponse response, Map dataMap, String fileName, String templateFile) {
        // tempPath는 템플릿 엑셀파일이 들어가있는 경로를 넣어 준다.
		/*
		 * String tempPath =
		 * request.getSession().getServletContext().getRealPath("/WEB-INF/excel"); try {
		 * InputStream is = new BufferedInputStream(new FileInputStream(tempPath + "/" +
		 * templateFile)); XLSTransformer xls = new XLSTransformer();
		 * 
		 * Workbook workbook = xls.transformXLS(is, dataMap); String outputFileName =
		 * new String(fileName.getBytes("KSC5601"), "8859_1");
		 * response.setHeader("Content-Disposition", "attachment; filename=\"" +
		 * outputFileName);
		 * 
		 * OutputStream os = response.getOutputStream();
		 * 
		 * workbook.write(os); } catch (Exception e) { e.printStackTrace(); }
		 */
    }
}
