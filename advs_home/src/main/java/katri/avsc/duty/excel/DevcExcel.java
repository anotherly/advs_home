package katri.avsc.duty.excel;

import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.util.IOUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import katri.avsc.com.core.ExcelUtil;
import katri.avsc.com.core.Util;

public class DevcExcel {

	private  static Log log = LogFactory.getLog(DevcExcel.class);

	/**
	* 장치 및 기능변경 보고서 엑셀파일 생성.
	* 
	* @param filePath 파일 경로
	* @param fileName 파일 이름
	* @param devcInfo 장치 및 기능변경 정보
	* @throws IOException
	*/
	public static String devcExcelMake(String filePath, String fileName, Map<String, String> devcInfo){
		//결과
		String result = "1";

		try {
			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(Util.nvl(devcInfo.get("tmpRaceNumber")));	//sheet 생성

			//xssf 변수 선언
			XSSFRow row;
			XSSFCell c_01_A = null;		XSSFCell c_01_B = null;		XSSFCell c_01_C = null;		XSSFCell c_01_D = null;			XSSFCell c_01_E = null;		XSSFCell c_01_F = null;		XSSFCell c_01_G = null;		XSSFCell c_01_H = null;			XSSFCell c_01_I = null;		XSSFCell c_01_J = null;		XSSFCell c_01_K = null;		XSSFCell c_01_L = null;
			XSSFCell c_02_A = null;		XSSFCell c_02_B = null;		XSSFCell c_02_C = null;		XSSFCell c_02_D = null;			XSSFCell c_02_E = null;		XSSFCell c_02_F = null;		XSSFCell c_02_G = null;		XSSFCell c_02_H = null;			XSSFCell c_02_I = null;		XSSFCell c_02_J = null;		XSSFCell c_02_K = null;		XSSFCell c_02_L = null;
			XSSFCell c_03_A = null;		XSSFCell c_03_B = null;		XSSFCell c_03_C = null;		XSSFCell c_03_D = null;			XSSFCell c_03_E = null;		XSSFCell c_03_F = null;		XSSFCell c_03_G = null;		XSSFCell c_03_H = null;			XSSFCell c_03_I = null;		XSSFCell c_03_J = null;		XSSFCell c_03_K = null;		XSSFCell c_03_L = null;
			XSSFCell c_04_A = null;		XSSFCell c_04_B = null;		XSSFCell c_04_C = null;		XSSFCell c_04_D = null;			XSSFCell c_04_E = null;		XSSFCell c_04_F = null;		XSSFCell c_04_G = null;		XSSFCell c_04_H = null;			XSSFCell c_04_I = null;		XSSFCell c_04_J = null;		XSSFCell c_04_K = null;		XSSFCell c_04_L = null;
			XSSFCell c_05_A = null;		XSSFCell c_05_B = null;		XSSFCell c_05_C = null;		XSSFCell c_05_D = null;			XSSFCell c_05_E = null;		XSSFCell c_05_F = null;		XSSFCell c_05_G = null;		XSSFCell c_05_H = null;			XSSFCell c_05_I = null;		XSSFCell c_05_J = null;		XSSFCell c_05_K = null;		XSSFCell c_05_L = null;
			XSSFCell c_06_A = null;		XSSFCell c_06_B = null;		XSSFCell c_06_C = null;		XSSFCell c_06_D = null;			XSSFCell c_06_E = null;		XSSFCell c_06_F = null;		XSSFCell c_06_G = null;		XSSFCell c_06_H = null;			XSSFCell c_06_I = null;		XSSFCell c_06_J = null;		XSSFCell c_06_K = null;		XSSFCell c_06_L = null;
			XSSFCell c_07_A = null;		XSSFCell c_07_B = null;		XSSFCell c_07_C = null;		XSSFCell c_07_D = null;			XSSFCell c_07_E = null;		XSSFCell c_07_F = null;		XSSFCell c_07_G = null;		XSSFCell c_07_H = null;			XSSFCell c_07_I = null;		XSSFCell c_07_J = null;		XSSFCell c_07_K = null;		XSSFCell c_07_L = null;
			XSSFCell c_08_A = null;		XSSFCell c_08_B = null;		XSSFCell c_08_C = null;		XSSFCell c_08_D = null;			XSSFCell c_08_E = null;		XSSFCell c_08_F = null;		XSSFCell c_08_G = null;		XSSFCell c_08_H = null;			XSSFCell c_08_I = null;		XSSFCell c_08_J = null;		XSSFCell c_08_K = null;		XSSFCell c_08_L = null;
			XSSFCell c_09_A = null;		XSSFCell c_09_B = null;		XSSFCell c_09_C = null;		XSSFCell c_09_D = null;			XSSFCell c_09_E = null;		XSSFCell c_09_F = null;		XSSFCell c_09_G = null;		XSSFCell c_09_H = null;			XSSFCell c_09_I = null;		XSSFCell c_09_J = null;		XSSFCell c_09_K = null;		XSSFCell c_09_L = null;
			XSSFCell c_10_A = null;		XSSFCell c_10_B = null;		XSSFCell c_10_C = null;		XSSFCell c_10_D = null;			XSSFCell c_10_E = null;		XSSFCell c_10_F = null;		XSSFCell c_10_G = null;		XSSFCell c_10_H = null;			XSSFCell c_10_I = null;		XSSFCell c_10_J = null;		XSSFCell c_10_K = null;		XSSFCell c_10_L = null;

			XSSFCell c_11_A = null;		XSSFCell c_11_B = null;		XSSFCell c_11_C = null;		XSSFCell c_11_D = null;			XSSFCell c_11_E = null;		XSSFCell c_11_F = null;		XSSFCell c_11_G = null;		XSSFCell c_11_H = null;			XSSFCell c_11_I = null;		XSSFCell c_11_J = null;		XSSFCell c_11_K = null;		XSSFCell c_11_L = null;
			XSSFCell c_12_A = null;		XSSFCell c_12_B = null;		XSSFCell c_12_C = null;		XSSFCell c_12_D = null;			XSSFCell c_12_E = null;		XSSFCell c_12_F = null;		XSSFCell c_12_G = null;		XSSFCell c_12_H = null;			XSSFCell c_12_I = null;		XSSFCell c_12_J = null;		XSSFCell c_12_K = null;		XSSFCell c_12_L = null;
			XSSFCell c_13_A = null;		XSSFCell c_13_B = null;		XSSFCell c_13_C = null;		XSSFCell c_13_D = null;			XSSFCell c_13_E = null;		XSSFCell c_13_F = null;		XSSFCell c_13_G = null;		XSSFCell c_13_H = null;			XSSFCell c_13_I = null;		XSSFCell c_13_J = null;		XSSFCell c_13_K = null;		XSSFCell c_13_L = null;
			XSSFCell c_14_A = null;		XSSFCell c_14_B = null;		XSSFCell c_14_C = null;		XSSFCell c_14_D = null;			XSSFCell c_14_E = null;		XSSFCell c_14_F = null;		XSSFCell c_14_G = null;		XSSFCell c_14_H = null;			XSSFCell c_14_I = null;		XSSFCell c_14_J = null;		XSSFCell c_14_K = null;		XSSFCell c_14_L = null;
			XSSFCell c_15_A = null;		XSSFCell c_15_B = null;		XSSFCell c_15_C = null;		XSSFCell c_15_D = null;			XSSFCell c_15_E = null;		XSSFCell c_15_F = null;		XSSFCell c_15_G = null;		XSSFCell c_15_H = null;			XSSFCell c_15_I = null;		XSSFCell c_15_J = null;		XSSFCell c_15_K = null;		XSSFCell c_15_L = null;
			XSSFCell c_16_A = null;		XSSFCell c_16_B = null;		XSSFCell c_16_C = null;		XSSFCell c_16_D = null;			XSSFCell c_16_E = null;		XSSFCell c_16_F = null;		XSSFCell c_16_G = null;		XSSFCell c_16_H = null;			XSSFCell c_16_I = null;		XSSFCell c_16_J = null;		XSSFCell c_16_K = null;		XSSFCell c_16_L = null;
			XSSFCell c_17_A = null;		XSSFCell c_17_B = null;		XSSFCell c_17_C = null;		XSSFCell c_17_D = null;			XSSFCell c_17_E = null;		XSSFCell c_17_F = null;		XSSFCell c_17_G = null;		XSSFCell c_17_H = null;			XSSFCell c_17_I = null;		XSSFCell c_17_J = null;		XSSFCell c_17_K = null;		XSSFCell c_17_L = null;
			XSSFCell c_18_A = null;		XSSFCell c_18_B = null;		XSSFCell c_18_C = null;		XSSFCell c_18_D = null;			XSSFCell c_18_E = null;		XSSFCell c_18_F = null;		XSSFCell c_18_G = null;		XSSFCell c_18_H = null;			XSSFCell c_18_I = null;		XSSFCell c_18_J = null;		XSSFCell c_18_K = null;		XSSFCell c_18_L = null;
			XSSFCell c_19_A = null;		XSSFCell c_19_B = null;		XSSFCell c_19_C = null;		XSSFCell c_19_D = null;			XSSFCell c_19_E = null;		XSSFCell c_19_F = null;		XSSFCell c_19_G = null;		XSSFCell c_19_H = null;			XSSFCell c_19_I = null;		XSSFCell c_19_J = null;		XSSFCell c_19_K = null;		XSSFCell c_19_L = null;
			XSSFCell c_20_A = null;		XSSFCell c_20_B = null;		XSSFCell c_20_C = null;		XSSFCell c_20_D = null;			XSSFCell c_20_E = null;		XSSFCell c_20_F = null;		XSSFCell c_20_G = null;		XSSFCell c_20_H = null;			XSSFCell c_20_I = null;		XSSFCell c_20_J = null;		XSSFCell c_20_K = null;		XSSFCell c_20_L = null;

			XSSFCell c_21_A = null;		XSSFCell c_21_B = null;		XSSFCell c_21_C = null;		XSSFCell c_21_D = null;			XSSFCell c_21_E = null;		XSSFCell c_21_F = null;		XSSFCell c_21_G = null;		XSSFCell c_21_H = null;			XSSFCell c_21_I = null;		XSSFCell c_21_J = null;		XSSFCell c_21_K = null;		XSSFCell c_21_L = null;
			XSSFCell c_22_A = null;		XSSFCell c_22_B = null;		XSSFCell c_22_C = null;		XSSFCell c_22_D = null;			XSSFCell c_22_E = null;		XSSFCell c_22_F = null;		XSSFCell c_22_G = null;		XSSFCell c_22_H = null;			XSSFCell c_22_I = null;		XSSFCell c_22_J = null;		XSSFCell c_22_K = null;		XSSFCell c_22_L = null;
			XSSFCell c_23_A = null;		XSSFCell c_23_B = null;		XSSFCell c_23_C = null;		XSSFCell c_23_D = null;			XSSFCell c_23_E = null;		XSSFCell c_23_F = null;		XSSFCell c_23_G = null;		XSSFCell c_23_H = null;			XSSFCell c_23_I = null;		XSSFCell c_23_J = null;		XSSFCell c_23_K = null;		XSSFCell c_23_L = null;
			XSSFCell c_24_A = null;		XSSFCell c_24_B = null;		XSSFCell c_24_C = null;		XSSFCell c_24_D = null;			XSSFCell c_24_E = null;		XSSFCell c_24_F = null;		XSSFCell c_24_G = null;		XSSFCell c_24_H = null;			XSSFCell c_24_I = null;		XSSFCell c_24_J = null;		XSSFCell c_24_K = null;		XSSFCell c_24_L = null;
			XSSFCell c_25_A = null;		XSSFCell c_25_B = null;		XSSFCell c_25_C = null;		XSSFCell c_25_D = null;			XSSFCell c_25_E = null;		XSSFCell c_25_F = null;		XSSFCell c_25_G = null;		XSSFCell c_25_H = null;			XSSFCell c_25_I = null;		XSSFCell c_25_J = null;		XSSFCell c_25_K = null;		XSSFCell c_25_L = null;
			XSSFCell c_26_A = null;		XSSFCell c_26_B = null;		XSSFCell c_26_C = null;		XSSFCell c_26_D = null;			XSSFCell c_26_E = null;		XSSFCell c_26_F = null;		XSSFCell c_26_G = null;		XSSFCell c_26_H = null;			XSSFCell c_26_I = null;		XSSFCell c_26_J = null;		XSSFCell c_26_K = null;		XSSFCell c_26_L = null;
			XSSFCell c_27_A = null;		XSSFCell c_27_B = null;		XSSFCell c_27_C = null;		XSSFCell c_27_D = null;			XSSFCell c_27_E = null;		XSSFCell c_27_F = null;		XSSFCell c_27_G = null;		XSSFCell c_27_H = null;			XSSFCell c_27_I = null;		XSSFCell c_27_J = null;		XSSFCell c_27_K = null;		XSSFCell c_27_L = null;
			XSSFCell c_28_A = null;		XSSFCell c_28_B = null;		XSSFCell c_28_C = null;		XSSFCell c_28_D = null;			XSSFCell c_28_E = null;		XSSFCell c_28_F = null;		XSSFCell c_28_G = null;		XSSFCell c_28_H = null;			XSSFCell c_28_I = null;		XSSFCell c_28_J = null;		XSSFCell c_28_K = null;		XSSFCell c_28_L = null;
			XSSFCell c_29_A = null;		XSSFCell c_29_B = null;		XSSFCell c_29_C = null;		XSSFCell c_29_D = null;			XSSFCell c_29_E = null;		XSSFCell c_29_F = null;		XSSFCell c_29_G = null;		XSSFCell c_29_H = null;			XSSFCell c_29_I = null;		XSSFCell c_29_J = null;		XSSFCell c_29_K = null;		XSSFCell c_29_L = null;
			XSSFCell c_30_A = null;		XSSFCell c_30_B = null;		XSSFCell c_30_C = null;		XSSFCell c_30_D = null;			XSSFCell c_30_E = null;		XSSFCell c_30_F = null;		XSSFCell c_30_G = null;		XSSFCell c_30_H = null;			XSSFCell c_30_I = null;		XSSFCell c_30_J = null;		XSSFCell c_30_K = null;		XSSFCell c_30_L = null;

			XSSFCell c_31_A = null;		XSSFCell c_31_B = null;		XSSFCell c_31_C = null;		XSSFCell c_31_D = null;			XSSFCell c_31_E = null;		XSSFCell c_31_F = null;		XSSFCell c_31_G = null;		XSSFCell c_31_H = null;			XSSFCell c_31_I = null;		XSSFCell c_31_J = null;		XSSFCell c_31_K = null;		XSSFCell c_31_L = null;
			XSSFCell c_32_A = null;		XSSFCell c_32_B = null;		XSSFCell c_32_C = null;		XSSFCell c_32_D = null;			XSSFCell c_32_E = null;		XSSFCell c_32_F = null;		XSSFCell c_32_G = null;		XSSFCell c_32_H = null;			XSSFCell c_32_I = null;		XSSFCell c_32_J = null;		XSSFCell c_32_K = null;		XSSFCell c_32_L = null;
			XSSFCell c_33_A = null;		XSSFCell c_33_B = null;		XSSFCell c_33_C = null;		XSSFCell c_33_D = null;			XSSFCell c_33_E = null;		XSSFCell c_33_F = null;		XSSFCell c_33_G = null;		XSSFCell c_33_H = null;			XSSFCell c_33_I = null;		XSSFCell c_33_J = null;		XSSFCell c_33_K = null;		XSSFCell c_33_L = null;
			XSSFCell c_34_A = null;		XSSFCell c_34_B = null;		XSSFCell c_34_C = null;		XSSFCell c_34_D = null;			XSSFCell c_34_E = null;		XSSFCell c_34_F = null;		XSSFCell c_34_G = null;		XSSFCell c_34_H = null;			XSSFCell c_34_I = null;		XSSFCell c_34_J = null;		XSSFCell c_34_K = null;		XSSFCell c_34_L = null;
			XSSFCell c_35_A = null;		XSSFCell c_35_B = null;		XSSFCell c_35_C = null;		XSSFCell c_35_D = null;			XSSFCell c_35_E = null;		XSSFCell c_35_F = null;		XSSFCell c_35_G = null;		XSSFCell c_35_H = null;			XSSFCell c_35_I = null;		XSSFCell c_35_J = null;		XSSFCell c_35_K = null;		XSSFCell c_35_L = null;
			XSSFCell c_36_A = null;		XSSFCell c_36_B = null;		XSSFCell c_36_C = null;		XSSFCell c_36_D = null;			XSSFCell c_36_E = null;		XSSFCell c_36_F = null;		XSSFCell c_36_G = null;		XSSFCell c_36_H = null;			XSSFCell c_36_I = null;		XSSFCell c_36_J = null;		XSSFCell c_36_K = null;		XSSFCell c_36_L = null;
			XSSFCell c_37_A = null;		XSSFCell c_37_B = null;		XSSFCell c_37_C = null;		XSSFCell c_37_D = null;			XSSFCell c_37_E = null;		XSSFCell c_37_F = null;		XSSFCell c_37_G = null;		XSSFCell c_37_H = null;			XSSFCell c_37_I = null;		XSSFCell c_37_J = null;		XSSFCell c_37_K = null;		XSSFCell c_37_L = null;
			XSSFCell c_38_A = null;		XSSFCell c_38_B = null;		XSSFCell c_38_C = null;		XSSFCell c_38_D = null;			XSSFCell c_38_E = null;		XSSFCell c_38_F = null;		XSSFCell c_38_G = null;		XSSFCell c_38_H = null;			XSSFCell c_38_I = null;		XSSFCell c_38_J = null;		XSSFCell c_38_K = null;		XSSFCell c_38_L = null;
			XSSFCell c_39_A = null;		XSSFCell c_39_B = null;		XSSFCell c_39_C = null;		XSSFCell c_39_D = null;			XSSFCell c_39_E = null;		XSSFCell c_39_F = null;		XSSFCell c_39_G = null;		XSSFCell c_39_H = null;			XSSFCell c_39_I = null;		XSSFCell c_39_J = null;		XSSFCell c_39_K = null;		XSSFCell c_39_L = null;

			//대제목 스타일
			XSSFFont font1 = wb.createFont();
			XSSFCellStyle style1 = wb.createCellStyle();
			font1.setBold(true);
			font1.setFontName("휴먼명조");
			font1.setFontHeightInPoints((short) 18);
			font1.setUnderline(XSSFFont.U_DOUBLE);
			style1.setFont(font1);
			style1.setBorderBottom(BorderStyle.THICK);
			style1.setBorderLeft(BorderStyle.THIN);
			style1.setBorderRight(BorderStyle.THIN);
			style1.setBorderTop(BorderStyle.THIN);
			style1.setAlignment(HorizontalAlignment.CENTER);
			style1.setVerticalAlignment(VerticalAlignment.CENTER);
			//소제목 : border none, left, 색상없음
			XSSFFont font2 = wb.createFont();
			XSSFCellStyle style2 = wb.createCellStyle();
			font2.setBold(false);
			font2.setFontName("휴먼명조");
			font2.setFontHeightInPoints((short) 12);
			style2.setFont(font2);
			style2.setWrapText(true);
			style2.setBorderBottom(BorderStyle.THICK);
			style2.setBorderLeft(BorderStyle.NONE);
			style2.setBorderRight(BorderStyle.NONE);
			style2.setBorderTop(BorderStyle.THICK);
			style2.setAlignment(HorizontalAlignment.CENTER);
			style2.setVerticalAlignment(VerticalAlignment.CENTER);
			//소제목 : border none, left, 색상없음
			XSSFFont font3 = wb.createFont();
			XSSFCellStyle style3 = wb.createCellStyle();
			font3.setBold(false);
			font3.setFontName("휴먼명조");
			font3.setFontHeightInPoints((short) 12);
			style3.setFont(font3);
			style3.setWrapText(true);
			style3.setBorderBottom(BorderStyle.NONE);
			style3.setBorderLeft(BorderStyle.NONE);
			style3.setBorderRight(BorderStyle.NONE);
			style3.setBorderTop(BorderStyle.NONE);
			style3.setAlignment(HorizontalAlignment.LEFT);
			style3.setVerticalAlignment(VerticalAlignment.CENTER);

			//데이터 스타일 1 : CENTER, bold, 색상없음
			XSSFFont font4 = wb.createFont();
			XSSFCellStyle style4 = wb.createCellStyle();
			font4.setBold(true);
			font4.setFontName("휴먼명조");
			font4.setFontHeightInPoints((short) 11);
			style4.setFont(font4);
			style4.setWrapText(true);
			style4.setBorderBottom(BorderStyle.THIN);
			style4.setBorderLeft(BorderStyle.THIN);
			style4.setBorderRight(BorderStyle.THIN);
			style4.setBorderTop(BorderStyle.THIN);
			style4.setAlignment(HorizontalAlignment.CENTER);
			style4.setVerticalAlignment(VerticalAlignment.CENTER);
			//데이터 스타일 2 : CENTER, normal, 색상없음
			XSSFFont font5 = wb.createFont();
			XSSFCellStyle style5 = wb.createCellStyle();
			font5.setBold(false);
			font5.setFontName("휴먼명조");
			font5.setFontHeightInPoints((short) 11);
			style5.setFont(font5);
			style5.setWrapText(true);
			style5.setBorderBottom(BorderStyle.THIN);
			style5.setBorderLeft(BorderStyle.THIN);
			style5.setBorderRight(BorderStyle.THIN);
			style5.setBorderTop(BorderStyle.THIN);
			style5.setAlignment(HorizontalAlignment.CENTER);
			style5.setVerticalAlignment(VerticalAlignment.CENTER);
			//데이터 스타일 3 : left, normal, 색상없음
			XSSFFont font6 = wb.createFont();
			XSSFCellStyle style6 = wb.createCellStyle();
			font6.setBold(false);
			font6.setFontName("휴먼명조");
			font6.setFontHeightInPoints((short) 11);
			style6.setFont(font6);
			style6.setWrapText(true);
			style6.setBorderBottom(BorderStyle.THIN);
			style6.setBorderLeft(BorderStyle.THIN);
			style6.setBorderRight(BorderStyle.THIN);
			style6.setBorderTop(BorderStyle.THIN);
			style6.setAlignment(HorizontalAlignment.LEFT);
			style6.setVerticalAlignment(VerticalAlignment.CENTER);
			//데이터 스타일 4 : CENTER, normal, 색상있음
			XSSFFont font7 = wb.createFont();
			XSSFCellStyle style7 = wb.createCellStyle();
			font7.setBold(false);
			font7.setFontName("휴먼명조");
			font7.setFontHeightInPoints((short) 11);
			style7.setFont(font7);
			style7.setWrapText(true);
			style7.setBorderBottom(BorderStyle.THIN);
			style7.setBorderLeft(BorderStyle.THIN);
			style7.setBorderRight(BorderStyle.THIN);
			style7.setBorderTop(BorderStyle.THIN);
			style7.setAlignment(HorizontalAlignment.CENTER);
			style7.setVerticalAlignment(VerticalAlignment.CENTER);
			style7.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
			style7.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        	/**
        	 * === 셀병합 설명 ====
        	 * (int rowFrom, int rowTo, int colFrom, int colTo)
        	 * sheet.addMergedRegion(new Region(1, 1, 1, 2)); //가로병합
        	 * sheet.addMergedRegion(new Region(0, 1, 1, 1)); //세로병합
        	 */

			//엑셀 설정
			sheet = wb.getSheetAt(0);
			//sheet.setDefaultColumnWidth((short)4000);	//디폴트 설정 특정열 1000이 열 너비 3.14, 125px
			sheet.setColumnWidth((short)0,  (short)3500);	//109px
			sheet.setColumnWidth((short)1,  (short)4000);	//125px
			sheet.setColumnWidth((short)2,  (short)5000);	//156px
			sheet.setColumnWidth((short)3,  (short)2000);	// 63px
			sheet.setColumnWidth((short)4,  (short)3500);
			sheet.setColumnWidth((short)5,  (short)3500);
//			sheet.setColumnWidth((short)6,  (short)1000);
//			sheet.setColumnWidth((short)7,  (short)1000);
//			sheet.setColumnWidth((short)8,  (short)1000);
//			sheet.setColumnWidth((short)9,  (short)1000);
//			sheet.setColumnWidth((short)10, (short)1000);
//			sheet.setColumnWidth((short)11, (short)1000);
			//sheet.setDefaultRowHeight((short) 800);

	        // 1행 Cell 설정하기
			row = sheet.createRow(0);
			row.setHeight((short)600);		//1000 이 행높이 50, 53px
			c_01_A =row.createCell(0);		c_01_A.setCellStyle(style3);		c_01_A.setCellValue("[별지 제102호 서식]");
			c_01_B =row.createCell(1);		c_01_B.setCellStyle(style3);		c_01_B.setCellValue("");
			c_01_C =row.createCell(2);		c_01_C.setCellStyle(style3);		c_01_C.setCellValue("");
			c_01_D =row.createCell(3);		c_01_D.setCellStyle(style3);		c_01_D.setCellValue("");
			c_01_E =row.createCell(4);		c_01_E.setCellStyle(style3);		c_01_E.setCellValue("");
			c_01_F =row.createCell(5);		c_01_F.setCellStyle(style3);		c_01_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 0, 0, 0, 5));

	        // 2행 Cell 설정하기
			row = sheet.createRow(1);
			row.setHeight((short)800);		//1000 이 행높이 50, 53px
			c_01_A =row.createCell(0);		c_01_A.setCellStyle(style1);		c_01_A.setCellValue("자율주행자동차 장치 및 기능 변경 신고서");
			c_01_B =row.createCell(1);		c_01_B.setCellStyle(style1);		c_01_B.setCellValue("");
			c_01_C =row.createCell(2);		c_01_C.setCellStyle(style1);		c_01_C.setCellValue("");
			c_01_D =row.createCell(3);		c_01_D.setCellStyle(style1);		c_01_D.setCellValue("");
			c_01_E =row.createCell(4);		c_01_E.setCellStyle(style1);		c_01_E.setCellValue("");
			c_01_F =row.createCell(5);		c_01_F.setCellStyle(style1);		c_01_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 1, 1, 0, 5));

			// 3행
			row = sheet.createRow(2);
			row.setHeight((short)600);		//1000 이 행높이 50, 40px
			c_02_A =row.createCell(0);		c_02_A.setCellStyle(style5);		c_02_A.setCellValue("기관정보");
			c_02_B =row.createCell(1);		c_02_B.setCellStyle(style5);		c_02_B.setCellValue("임시운행기관");
			c_02_C =row.createCell(2);		c_02_C.setCellStyle(style5);		c_02_C.setCellValue(Util.nvl(devcInfo.get("tmpRaceAgency")));
			c_02_D =row.createCell(3);		c_02_D.setCellStyle(style5);		c_02_D.setCellValue("임시운행등록번호");
			c_02_E =row.createCell(4);		c_02_E.setCellStyle(style5);		c_02_E.setCellValue("");
			c_02_F =row.createCell(5);		c_02_F.setCellStyle(style5);		c_02_F.setCellValue(Util.nvl(devcInfo.get("tmpRaceNumber")));
			sheet.addMergedRegion(new CellRangeAddress( 2, 2, 3, 4));

			// 4행
			row = sheet.createRow(3);
			row.setHeight((short)500);		//1000 이 행높이 50, 33px
			c_03_A =row.createCell(0);		c_03_A.setCellStyle(style5);		c_03_A.setCellValue("장치변경사항");
			c_03_B =row.createCell(1);		c_03_B.setCellStyle(style5);		c_03_B.setCellValue("변경일자");
			c_03_C =row.createCell(2);		c_03_C.setCellStyle(style5);		c_03_C.setCellValue(Util.nvl(devcInfo.get("modifyDateView")));
			c_03_D =row.createCell(3);		c_03_D.setCellStyle(style5);		c_03_D.setCellValue("");
			c_03_E =row.createCell(4);		c_03_E.setCellStyle(style5);		c_03_E.setCellValue("");
			c_03_F =row.createCell(5);		c_03_F.setCellStyle(style5);		c_03_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 3, 3, 2, 5));

			//변경여부 문자열 치환
			String drChangeYn = Util.nvl(devcInfo.get("drivingModeChangeYn")).equals("Y") ? "변경" : "변경없음" ; //주행모드변경
			String spChangeYn = Util.nvl(devcInfo.get("spdRangeChangeYn")).equals("Y") ? "변경" : "변경없음" ; //작동및 속도범위 변경
			String dvChangeYn = Util.nvl(devcInfo.get("deviceChangeYn")).equals("Y") ? "변경" : "변경없음" ; //구조및장치변경

			// 5행 ~ 6행
			row = sheet.createRow(4);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_04_A =row.createCell(0);		c_04_A.setCellStyle(style5);		c_04_A.setCellValue("");
			c_04_B =row.createCell(1);		c_04_B.setCellStyle(style7);		c_04_B.setCellValue("변경사항");
			c_04_C =row.createCell(2);		c_04_C.setCellStyle(style7);		c_04_C.setCellValue("장치 및 기능");
			c_04_D =row.createCell(3);		c_04_D.setCellStyle(style7);		c_04_D.setCellValue("");
			c_04_E =row.createCell(4);		c_04_E.setCellStyle(style7);		c_04_E.setCellValue("");
			c_04_F =row.createCell(5);		c_04_F.setCellStyle(style7);		c_04_F.setCellValue("변경 여부");
			row = sheet.createRow(5);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_05_A =row.createCell(0);		c_05_A.setCellStyle(style5);		c_05_A.setCellValue("");
			c_05_B =row.createCell(1);		c_05_B.setCellStyle(style7);		c_05_B.setCellValue("");
			c_05_C =row.createCell(2);		c_05_C.setCellStyle(style5);		c_05_C.setCellValue("주행모드");
			c_05_D =row.createCell(3);		c_05_D.setCellStyle(style5);		c_05_D.setCellValue("");
			c_05_E =row.createCell(4);		c_05_E.setCellStyle(style5);		c_05_E.setCellValue("");
			c_05_F =row.createCell(5);		c_05_F.setCellStyle(style5);		c_05_F.setCellValue(drChangeYn);
			sheet.addMergedRegion(new CellRangeAddress( 4, 5, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress( 4, 4, 2, 4));
			sheet.addMergedRegion(new CellRangeAddress( 5, 5, 2, 4));

			// 7행 ~ 8행
			row = sheet.createRow(6);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_06_A =row.createCell(0);		c_06_A.setCellStyle(style5);		c_06_A.setCellValue("");
			c_06_B =row.createCell(1);		c_06_B.setCellStyle(style7);		c_06_B.setCellValue("변경 사항 사양 비교");
			c_06_C =row.createCell(2);		c_06_C.setCellStyle(style7);		c_06_C.setCellValue("변경 전");
			c_06_D =row.createCell(3);		c_06_D.setCellStyle(style7);		c_06_D.setCellValue("");
			c_06_E =row.createCell(4);		c_06_E.setCellStyle(style7);		c_06_E.setCellValue("변경 후");
			c_06_F =row.createCell(5);		c_06_F.setCellStyle(style7);		c_06_F.setCellValue("");
			row = sheet.createRow(7);
			row.setHeight((short)1400);		//1000 이 행높이 50, 93px
			c_07_A =row.createCell(0);		c_07_A.setCellStyle(style5);		c_07_A.setCellValue("");
			c_07_B =row.createCell(1);		c_07_B.setCellStyle(style5);		c_07_B.setCellValue("");
			c_07_C =row.createCell(2);		c_07_C.setCellStyle(style6);		c_07_C.setCellValue(Util.nvl(devcInfo.get("dmBeforeSpec")));
			c_07_D =row.createCell(3);		c_07_D.setCellStyle(style6);		c_07_D.setCellValue("");
			c_07_E =row.createCell(4);		c_07_E.setCellStyle(style6);		c_07_E.setCellValue(Util.nvl(devcInfo.get("dmAfterSpec")));
			c_07_F =row.createCell(5);		c_07_F.setCellStyle(style6);		c_07_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 6, 7, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress( 6, 6, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress( 6, 6, 4, 5));
			sheet.addMergedRegion(new CellRangeAddress( 7, 7, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress( 7, 7, 4, 5));

			// 9행 ~ 10행
			row = sheet.createRow(8);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_08_A =row.createCell(0);		c_08_A.setCellStyle(style5);		c_08_A.setCellValue("");
			c_08_B =row.createCell(1);		c_08_B.setCellStyle(style7);		c_08_B.setCellValue("변경사항");
			c_08_C =row.createCell(2);		c_08_C.setCellStyle(style7);		c_08_C.setCellValue("장치 및 기능");
			c_08_D =row.createCell(3);		c_08_D.setCellStyle(style7);		c_08_D.setCellValue("");
			c_08_E =row.createCell(4);		c_08_E.setCellStyle(style7);		c_08_E.setCellValue("");
			c_08_F =row.createCell(5);		c_08_F.setCellStyle(style7);		c_08_F.setCellValue("변경 여부");
			row = sheet.createRow(9);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_09_A =row.createCell(0);		c_09_A.setCellStyle(style5);		c_09_A.setCellValue("");
			c_09_B =row.createCell(1);		c_09_B.setCellStyle(style7);		c_09_B.setCellValue("");
			c_09_C =row.createCell(2);		c_09_C.setCellStyle(style5);		c_09_C.setCellValue("작동 속도범위");
			c_09_D =row.createCell(3);		c_09_D.setCellStyle(style5);		c_09_D.setCellValue("");
			c_09_E =row.createCell(4);		c_09_E.setCellStyle(style5);		c_09_E.setCellValue("");
			c_09_F =row.createCell(5);		c_09_F.setCellStyle(style5);		c_09_F.setCellValue(spChangeYn);
			sheet.addMergedRegion(new CellRangeAddress( 8, 9, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress( 8, 8, 2, 4));
			sheet.addMergedRegion(new CellRangeAddress( 9, 9, 2, 4));

			// 11행 ~ 12행
			row = sheet.createRow(10);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_10_A =row.createCell(0);		c_10_A.setCellStyle(style5);		c_10_A.setCellValue("");
			c_10_B =row.createCell(1);		c_10_B.setCellStyle(style7);		c_10_B.setCellValue("변경 사항 사양 비교");
			c_10_C =row.createCell(2);		c_10_C.setCellStyle(style7);		c_10_C.setCellValue("변경 전");
			c_10_D =row.createCell(3);		c_10_D.setCellStyle(style7);		c_10_D.setCellValue("");
			c_10_E =row.createCell(4);		c_10_E.setCellStyle(style7);		c_10_E.setCellValue("변경 후");
			c_10_F =row.createCell(5);		c_10_F.setCellStyle(style7);		c_10_F.setCellValue("");
			row = sheet.createRow(11);
			row.setHeight((short)1400);		//1000 이 행높이 50
			c_11_A =row.createCell(0);		c_11_A.setCellStyle(style5);		c_11_A.setCellValue("");
			c_11_B =row.createCell(1);		c_11_B.setCellStyle(style5);		c_11_B.setCellValue("");
			c_11_C =row.createCell(2);		c_11_C.setCellStyle(style6);		c_11_C.setCellValue(Util.nvl(devcInfo.get("srcBeforeSpec")));
			c_11_D =row.createCell(3);		c_11_D.setCellStyle(style6);		c_11_D.setCellValue("");
			c_11_E =row.createCell(4);		c_11_E.setCellStyle(style6);		c_11_E.setCellValue(Util.nvl(devcInfo.get("srcAfterSpec")));
			c_11_F =row.createCell(5);		c_11_F.setCellStyle(style6);		c_11_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(10,11, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(10,10, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress(10,10, 4, 5));
			sheet.addMergedRegion(new CellRangeAddress(11,11, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress(11,11, 4, 5));

			// 13행 ~ 14행
			row = sheet.createRow(12);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_12_A =row.createCell(0);		c_12_A.setCellStyle(style5);		c_12_A.setCellValue("");
			c_12_B =row.createCell(1);		c_12_B.setCellStyle(style7);		c_12_B.setCellValue("변경사항");
			c_12_C =row.createCell(2);		c_12_C.setCellStyle(style7);		c_12_C.setCellValue("장치 및 기능");
			c_12_D =row.createCell(3);		c_12_D.setCellStyle(style7);		c_12_D.setCellValue("");
			c_12_E =row.createCell(4);		c_12_E.setCellStyle(style7);		c_12_E.setCellValue("");
			c_12_F =row.createCell(5);		c_12_F.setCellStyle(style7);		c_12_F.setCellValue("변경 여부");
			row = sheet.createRow(13);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_13_A =row.createCell(0);		c_13_A.setCellStyle(style5);		c_13_A.setCellValue("");
			c_13_B =row.createCell(1);		c_13_B.setCellStyle(style7);		c_13_B.setCellValue("");
			c_13_C =row.createCell(2);		c_13_C.setCellStyle(style5);		c_13_C.setCellValue("구조 및 장치 변경");
			c_13_D =row.createCell(3);		c_13_D.setCellStyle(style5);		c_13_D.setCellValue("");
			c_13_E =row.createCell(4);		c_13_E.setCellStyle(style5);		c_13_E.setCellValue("");
			c_13_F =row.createCell(5);		c_13_F.setCellStyle(style5);		c_13_F.setCellValue(dvChangeYn);
			sheet.addMergedRegion(new CellRangeAddress(12,13, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(12,12, 2, 4));
			sheet.addMergedRegion(new CellRangeAddress(13,13, 2, 4));

			// 15행 ~ 16행
			row = sheet.createRow(14);
			row.setHeight((short)800);		//1000 이 행높이 50
			c_14_A =row.createCell(0);		c_14_A.setCellStyle(style5);		c_14_A.setCellValue("");
			c_14_B =row.createCell(1);		c_14_B.setCellStyle(style7);		c_14_B.setCellValue("변경 사항 사양 비교");
			c_14_C =row.createCell(2);		c_14_C.setCellStyle(style7);		c_14_C.setCellValue("변경 전");
			c_14_D =row.createCell(3);		c_14_D.setCellStyle(style7);		c_14_D.setCellValue("");
			c_14_E =row.createCell(4);		c_14_E.setCellStyle(style7);		c_14_E.setCellValue("변경 후");
			c_14_F =row.createCell(5);		c_14_F.setCellStyle(style7);		c_14_F.setCellValue("");
			row = sheet.createRow(15);
			row.setHeight((short)1400);		//1000 이 행높이 50
			c_15_A =row.createCell(0);		c_15_A.setCellStyle(style5);		c_15_A.setCellValue("");
			c_15_B =row.createCell(1);		c_15_B.setCellStyle(style5);		c_15_B.setCellValue("");
			c_15_C =row.createCell(2);		c_15_C.setCellStyle(style6);		c_15_C.setCellValue(Util.nvl(devcInfo.get("dcBeforeSpec")));
			c_15_D =row.createCell(3);		c_15_D.setCellStyle(style6);		c_15_D.setCellValue("");
			c_15_E =row.createCell(4);		c_15_E.setCellStyle(style6);		c_15_E.setCellValue(Util.nvl(devcInfo.get("dcAfterSpec")));
			c_15_F =row.createCell(5);		c_15_F.setCellStyle(style6);		c_15_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(14,15, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(14,14, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress(14,14, 4, 5));
			sheet.addMergedRegion(new CellRangeAddress(15,15, 2, 3));
			sheet.addMergedRegion(new CellRangeAddress(15,15, 4, 5));

			// 17행
			row = sheet.createRow(16);
			row.setHeight((short)1800);		//1000 이 행높이 50
			c_16_A =row.createCell(0);		c_16_A.setCellStyle(style5);		c_16_A.setCellValue("");
			c_16_B =row.createCell(1);		c_16_B.setCellStyle(style7);		c_16_B.setCellValue("변경내용기술");
			c_16_C =row.createCell(2);		c_16_C.setCellStyle(style6);		c_16_C.setCellValue(Util.nvl(devcInfo.get("changeInfo")));
			c_16_D =row.createCell(3);		c_16_D.setCellStyle(style6);		c_16_D.setCellValue("");
			c_16_E =row.createCell(4);		c_16_E.setCellStyle(style6);		c_16_E.setCellValue("");
			c_16_F =row.createCell(5);		c_16_F.setCellStyle(style6);		c_16_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 3,16, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(16,16, 2, 5));

			row = sheet.createRow(17);
			row.setHeight((short)2500);
			c_01_A =row.createCell(0);		c_01_A.setCellStyle(style2);		c_01_A.setCellValue("「자동차관리법」제27조제5항 및 동법시행규칙 제26조의3제1항에 따라 자율주행차 장치 및 기능 변경 보고서를 제출합니다. \n\n\n 년        월        일 \n\n\n 제출인                     (서명 또는 인)");
			c_01_B =row.createCell(1);		c_01_B.setCellStyle(style2);		c_01_B.setCellValue("");
			c_01_C =row.createCell(2);		c_01_C.setCellStyle(style2);		c_01_C.setCellValue("");
			c_01_D =row.createCell(3);		c_01_D.setCellStyle(style2);		c_01_D.setCellValue("");
			c_01_E =row.createCell(4);		c_01_E.setCellStyle(style2);		c_01_E.setCellValue("");
			c_01_F =row.createCell(5);		c_01_F.setCellStyle(style2);		c_01_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(17,17, 0, 5));

	        FileOutputStream fileOutput = null;
	        try{
	    		if(filePath != null && !"".equals(filePath) ) {
//					filePath = ExcelUtil.getReplace(filePath, "/", "\\\\");
	    		}
				fileOutput = new FileOutputStream(filePath);
				wb.write(fileOutput);
			} catch(IOException ioe){
				log.info("[DevcExcel Exception] 장치 및 기능변경 엑셀파일 생성 실패 1: " + ioe.toString());
				result = "0";
			} finally {
				if(fileOutput != null) try {fileOutput.close();} catch (IOException e1) {log.info("[DevcExcel fileOutput] 실패 : " + e1.toString());};
			}


		} catch (Exception e) {
			log.info("[DevcExcel Exception] 장치 및 기능변경 엑셀파일 처리 실패 2: " + e.toString());
			result = "0";
		}
		return result;
	}

}
