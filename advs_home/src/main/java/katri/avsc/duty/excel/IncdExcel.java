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

public class IncdExcel {

	private  static Log log = LogFactory.getLog(IncdExcel.class);

	/**
	* 교통사고 신고서 엑셀파일 생성.
	* 
	* @param filePath	파일 경로
	* @param filenm		파일 이름
	* @param incdInfo	사고정보
	* @param carList	사고차량정보
	* @throws IOException
	*/
	public static String incdExcelMake(String filePath, String filenm, Map<String, String> incdInfo, List<?> carList){
		//결과
		String result = "1";

		try {
			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet(String.valueOf(incdInfo.get("tmpRaceNumber")));	//sheet 생성

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
			style7.setFillForegroundColor(IndexedColors.GREY_80_PERCENT.getIndex());
			style7.setFillPattern(FillPatternType.SOLID_FOREGROUND);

			log.debug(" @@@@@@@@@@@@@@ : 1");
        	/**
        	 * === 셀병합 설명 ====
        	 * (int rowFrom, int rowTo, int colFrom, int colTo)
        	 * sheet.addMergedRegion(new Region(1, 1, 1, 2)); //가로병합
        	 * sheet.addMergedRegion(new Region(0, 1, 1, 1)); //세로병합
        	 */

			//엑셀 설정
			sheet = wb.getSheetAt(0);
			//sheet.setDefaultColumnWidth((short)4000);	//디폴트 설정 특정열 1000이 열 너비 3.14
			sheet.setColumnWidth((short)0, (short)3000);	// 94px
			sheet.setColumnWidth((short)1, (short)4000);	//125px
			sheet.setColumnWidth((short)2, (short)5000);	//156px
			sheet.setColumnWidth((short)3, (short)2500);	// 78px
			sheet.setColumnWidth((short)4, (short)2500);
			sheet.setColumnWidth((short)5, (short)4000);
//			sheet.setColumnWidth((short)6, (short)2500);
//			sheet.setColumnWidth((short)7, (short)2500);
//			sheet.setColumnWidth((short)8, (short)2500);
//			sheet.setColumnWidth((short)9, (short)2500);
//			sheet.setColumnWidth((short)10, (short)2500);
//			sheet.setColumnWidth((short)11, (short)3000);
			//sheet.setDefaultRowHeight((short) 800);

	        // 1행 Cell 설정하기
			row = sheet.createRow(0);
			row.setHeight((short)600);		//1000 이 행높이 50, 53px
			c_01_A =row.createCell(0);		c_01_A.setCellStyle(style3);		c_01_A.setCellValue("[별지 제102호의3 서식]");
			c_01_B =row.createCell(1);		c_01_B.setCellStyle(style3);		c_01_B.setCellValue("");
			c_01_C =row.createCell(2);		c_01_C.setCellStyle(style3);		c_01_C.setCellValue("");
			c_01_D =row.createCell(3);		c_01_D.setCellStyle(style3);		c_01_D.setCellValue("");
			c_01_E =row.createCell(4);		c_01_E.setCellStyle(style3);		c_01_E.setCellValue("");
			c_01_F =row.createCell(5);		c_01_F.setCellStyle(style3);		c_01_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 0, 0, 0, 5));

			// 2행 Cell 설정하기
			row = sheet.createRow(1);
			row.setHeight((short)800);		//1000 이 행높이 50, 53px
			c_01_A =row.createCell(0);		c_01_A.setCellStyle(style1);		c_01_A.setCellValue("자율주행자동차 교통사고 신고서");
			c_01_B =row.createCell(1);		c_01_B.setCellStyle(style1);		c_01_B.setCellValue("");
			c_01_C =row.createCell(2);		c_01_C.setCellStyle(style1);		c_01_C.setCellValue("");
			c_01_D =row.createCell(3);		c_01_D.setCellStyle(style1);		c_01_D.setCellValue("");
			c_01_E =row.createCell(4);		c_01_E.setCellStyle(style1);		c_01_E.setCellValue("");
			c_01_F =row.createCell(5);		c_01_F.setCellStyle(style1);		c_01_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 1, 1, 0, 5));

			// 3행
			row = sheet.createRow(2);
			row.setHeight((short)500);		//1000 이 행높이 50, 33px
			c_02_A =row.createCell(0);		c_02_A.setCellStyle(style5);		c_02_A.setCellValue("기관정보");
			c_02_B =row.createCell(1);		c_02_B.setCellStyle(style5);		c_02_B.setCellValue("임시운행기관");
			c_02_C =row.createCell(2);		c_02_C.setCellStyle(style5);		c_02_C.setCellValue(Util.nvl(incdInfo.get("tmpRaceAgency")));
			c_02_D =row.createCell(3);		c_02_D.setCellStyle(style5);		c_02_D.setCellValue("임시운행 등록번호");
			c_02_E =row.createCell(4);		c_02_E.setCellStyle(style5);		c_02_E.setCellValue("");
			c_02_F =row.createCell(5);		c_02_F.setCellStyle(style5);		c_02_F.setCellValue(Util.nvl(incdInfo.get("tmpRaceNumber")));
			sheet.addMergedRegion(new CellRangeAddress( 2, 2, 3, 4));
			log.debug(" @@@@@@@@@@@@@@ : 1-1");

			// 4행
			row = sheet.createRow(3);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_03_A =row.createCell(0);		c_03_A.setCellStyle(style5);		c_03_A.setCellValue("사고 개요");
			c_03_B =row.createCell(1);		c_03_B.setCellStyle(style5);		c_03_B.setCellValue("사고일시");
			c_03_C =row.createCell(2);		c_03_C.setCellStyle(style6);		c_03_C.setCellValue(Util.nvl(incdInfo.get("accDateView")));
			c_03_D =row.createCell(3);		c_03_D.setCellStyle(style6);		c_03_D.setCellValue("");
			c_03_E =row.createCell(4);		c_03_E.setCellStyle(style6);		c_03_E.setCellValue("");
			c_03_F =row.createCell(5);		c_03_F.setCellStyle(style6);		c_03_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 3, 3, 2, 5));
			log.debug(" @@@@@@@@@@@@@@ : 1-2");

			// 5행
			row = sheet.createRow(4);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_04_A =row.createCell(0);		c_04_A.setCellStyle(style5);		c_04_A.setCellValue("");
			c_04_B =row.createCell(1);		c_04_B.setCellStyle(style5);		c_04_B.setCellValue("사고장소");
			c_04_C =row.createCell(2);		c_04_C.setCellStyle(style6);		c_04_C.setCellValue(Util.nvl(incdInfo.get("place")));
			c_04_D =row.createCell(3);		c_04_D.setCellStyle(style6);		c_04_D.setCellValue("");
			c_04_E =row.createCell(4);		c_04_E.setCellStyle(style6);		c_04_E.setCellValue("");
			c_04_F =row.createCell(5);		c_04_F.setCellStyle(style6);		c_04_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 4, 4, 2, 5));

			// 6행
			row = sheet.createRow(5);
			log.debug(" @@@@@@@@@@@@@@ : 1-3");
			row.setHeight((short)500);		//1000 이 행높이 50
			c_05_A =row.createCell(0);		c_05_A.setCellStyle(style5);		c_05_A.setCellValue("");
			c_05_B =row.createCell(1);		c_05_B.setCellStyle(style5);		c_05_B.setCellValue("기상상황");
			c_05_C =row.createCell(2);		c_05_C.setCellStyle(style6);		c_05_C.setCellValue(Util.nvl(incdInfo.get("weatherView")));
			c_05_D =row.createCell(3);		c_05_D.setCellStyle(style6);		c_05_D.setCellValue("");
			c_05_E =row.createCell(4);		c_05_E.setCellStyle(style6);		c_05_E.setCellValue("");
			c_05_F =row.createCell(5);		c_05_F.setCellStyle(style6);		c_05_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 5, 5, 2, 5));
			log.debug(" @@@@@@@@@@@@@@ : 2");

			// 7행 
			row = sheet.createRow(6);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_06_A =row.createCell(0);		c_06_A.setCellStyle(style5);		c_06_A.setCellValue("");
			c_06_B =row.createCell(1);		c_06_B.setCellStyle(style5);		c_06_B.setCellValue("도로상황");
			c_06_C =row.createCell(2);		c_06_C.setCellStyle(style6);		c_06_C.setCellValue(Util.nvl(incdInfo.get("roadSituationView")));
			c_06_D =row.createCell(3);		c_06_D.setCellStyle(style6);		c_06_D.setCellValue("");
			c_06_E =row.createCell(4);		c_06_E.setCellStyle(style6);		c_06_E.setCellValue("");
			c_06_F =row.createCell(5);		c_06_F.setCellStyle(style6);		c_06_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 3, 6, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress( 6, 6, 2, 5));

			log.debug(" @@@@@@@@@@@@@@ : 3");
			// 8행 
			row = sheet.createRow(7);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_07_A =row.createCell(0);		c_07_A.setCellStyle(style5);		c_07_A.setCellValue("자율주행 자동차");
			c_07_B =row.createCell(1);		c_07_B.setCellStyle(style5);		c_07_B.setCellValue("주행모드");
			c_07_C =row.createCell(2);		c_07_C.setCellStyle(style6);		c_07_C.setCellValue(Util.nvl(incdInfo.get("autocarDrivingModeView")));
			c_07_D =row.createCell(3);		c_07_D.setCellStyle(style6);		c_07_D.setCellValue("");
			c_07_E =row.createCell(4);		c_07_E.setCellStyle(style6);		c_07_E.setCellValue("");
			c_07_F =row.createCell(5);		c_07_F.setCellStyle(style6);		c_07_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 7, 7, 2, 5));

			String drStatus = Util.nvl(incdInfo.get("autocarDrivingStatusCd"));
			String drStatusView = "";
			if(drStatus.equals("101")) {
				drStatusView = Util.nvl(incdInfo.get("autocarDrivingStatusCdView")) + "(" + String.valueOf(incdInfo.get("autocarSpeed")) + " km/h)";
			} else if(drStatus.equals("102")) {
				drStatusView = Util.nvl(incdInfo.get("autocarDrivingStatusCdView"));
			}
			// 9행 
			row = sheet.createRow(8);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_08_A =row.createCell(0);		c_08_A.setCellStyle(style5);		c_08_A.setCellValue("");
			c_08_B =row.createCell(1);		c_08_B.setCellStyle(style5);		c_08_B.setCellValue("주행상태");
			c_08_C =row.createCell(2);		c_08_C.setCellStyle(style6);		c_08_C.setCellValue(drStatusView);
			c_08_D =row.createCell(3);		c_08_D.setCellStyle(style6);		c_08_D.setCellValue("");
			c_08_E =row.createCell(4);		c_08_E.setCellStyle(style6);		c_08_E.setCellValue("");
			c_08_F =row.createCell(5);		c_08_F.setCellStyle(style6);		c_08_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 8, 8, 2, 5));

			int rideNum = Util.nvl(String.valueOf(incdInfo.get("autocarRideNumber")),0);
			int loadVol = Util.nvl(String.valueOf(incdInfo.get("autocarLoadVol")),0);
			String rideStr = "승차인원 : " + rideNum + "명 / 적재량 : " + loadVol;
			// 10행 
			row = sheet.createRow(9);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_09_A =row.createCell(0);		c_09_A.setCellStyle(style5);		c_09_A.setCellValue("");
			c_09_B =row.createCell(1);		c_09_B.setCellStyle(style5);		c_09_B.setCellValue("운행정보");
			c_09_C =row.createCell(2);		c_09_C.setCellStyle(style6);		c_09_C.setCellValue(rideStr);
			c_09_D =row.createCell(3);		c_09_D.setCellStyle(style6);		c_09_D.setCellValue("");
			c_09_E =row.createCell(4);		c_09_E.setCellStyle(style6);		c_09_E.setCellValue("");
			c_09_F =row.createCell(5);		c_09_F.setCellStyle(style6);		c_09_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 9, 9, 2, 5));

			// 11행
			row = sheet.createRow(10);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_10_A =row.createCell(0);		c_10_A.setCellStyle(style5);		c_10_A.setCellValue("");
			c_10_B =row.createCell(1);		c_10_B.setCellStyle(style5);		c_10_B.setCellValue("파손정도");
			c_10_C =row.createCell(2);		c_10_C.setCellStyle(style6);		c_10_C.setCellValue(Util.nvl(incdInfo.get("autocarDamageView")));
			c_10_D =row.createCell(3);		c_10_D.setCellStyle(style6);		c_10_D.setCellValue("");
			c_10_E =row.createCell(4);		c_10_E.setCellStyle(style6);		c_10_E.setCellValue("");
			c_10_F =row.createCell(5);		c_10_F.setCellStyle(style6);		c_10_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(10,10, 2, 5));

			String auto_typ = Util.nvl(incdInfo.get("humanInjuryTypeView"));
			String auto_sex = Util.nvl(incdInfo.get("autocarHumanSexView"));
			int auto_age = Util.nvl(String.valueOf(incdInfo.get("autocarHumanAge")),0);
			String auto_human = auto_typ + " / " + auto_sex + "  / " + auto_age;
			//12행
			row = sheet.createRow(11);
			row.setHeight((short)500);		//1000 이 행높이 50
			c_11_A =row.createCell(0);		c_11_A.setCellStyle(style5);		c_11_A.setCellValue("");
			c_11_B =row.createCell(1);		c_11_B.setCellStyle(style5);		c_11_B.setCellValue("인적피해");
			c_11_C =row.createCell(2);		c_11_C.setCellStyle(style6);		c_11_C.setCellValue(auto_human);
			c_11_D =row.createCell(3);		c_11_D.setCellStyle(style6);		c_11_D.setCellValue("");
			c_11_E =row.createCell(4);		c_11_E.setCellStyle(style6);		c_11_E.setCellValue("");
			c_11_F =row.createCell(5);		c_11_F.setCellStyle(style6);		c_11_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress( 7,11, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(11,11, 2, 5));

			
			log.debug(" @@@@@@@@@@@@@@ : 5");
			/*
			 *  12행 부터 동적 생성
			 */
			int iRow = 12;
			for(int i=0; i < carList.size(); i++) {
				EgovMap egovMap = (EgovMap)carList.get(i);
				String seq = String.valueOf(i+1);
				//주행상태
				String acc_drStatus = Util.nvl(String.valueOf(egovMap.get("acccarDrivingStatusCd")));
				String acc_drStatusView = "";
				if(acc_drStatus.equals("101")) {
					acc_drStatusView = Util.nvl(String.valueOf(egovMap.get("acccarDrivingStatusCdView"))) + "(" + String.valueOf(egovMap.get("acccarSpeed")) + " km/h)";
				} else if(acc_drStatus.equals("102")) {
					acc_drStatusView = Util.nvl(String.valueOf(egovMap.get("acccarDrivingStatusCdView")));
				}
				//운행정보
				int acc_rideNum = Util.nvl(String.valueOf(egovMap.get("acccarRideNumber")),0);
				int acc_loadVol = Util.nvl(String.valueOf(egovMap.get("acccarLoadVol")),0);
				String acc_rideStr = "승차인원 : " + acc_rideNum + "명 / 적재량 : " + acc_loadVol;
				//인적피해
				String acc_auto_typ = Util.nvl(String.valueOf(egovMap.get("humanInjuryTypeView")));
				String acc_auto_sex = Util.nvl(String.valueOf(egovMap.get("acccarHumanSexView")));
				int acc_auto_age = Util.nvl(String.valueOf(egovMap.get("acccarHumanAge")),0);
				String acc_auto_human = acc_auto_typ + " / " + acc_auto_sex + "  / " + acc_auto_age;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R1_A = row.createCell(0);		c_R1_A.setCellStyle(style5);		c_R1_A.setCellValue("사고차량"+seq);
				XSSFCell c_R1_B = row.createCell(1);		c_R1_B.setCellStyle(style5);		c_R1_B.setCellValue("차량종류");
				XSSFCell c_R1_C = row.createCell(2);		c_R1_C.setCellStyle(style6);		c_R1_C.setCellValue(Util.nvl(String.valueOf(egovMap.get("acccarCarTypeView"))));
				XSSFCell c_R1_D = row.createCell(3);		c_R1_D.setCellStyle(style6);		c_R1_D.setCellValue("");
				XSSFCell c_R1_E = row.createCell(4);		c_R1_E.setCellStyle(style6);		c_R1_E.setCellValue("");
				XSSFCell c_R1_F = row.createCell(5);		c_R1_F.setCellStyle(style6);		c_R1_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R2_A = row.createCell(0);		c_R2_A.setCellStyle(style5);		c_R2_A.setCellValue("");
				XSSFCell c_R2_B = row.createCell(1);		c_R2_B.setCellStyle(style5);		c_R2_B.setCellValue("주행모드");
				XSSFCell c_R2_C = row.createCell(2);		c_R2_C.setCellStyle(style6);		c_R2_C.setCellValue(Util.nvl(String.valueOf(egovMap.get("acccarDrivingModeView"))));
				XSSFCell c_R2_D = row.createCell(3);		c_R2_D.setCellStyle(style6);		c_R2_D.setCellValue("");
				XSSFCell c_R2_E = row.createCell(4);		c_R2_E.setCellStyle(style6);		c_R2_E.setCellValue("");
				XSSFCell c_R2_F = row.createCell(5);		c_R2_F.setCellStyle(style6);		c_R2_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R3_A = row.createCell(0);		c_R3_A.setCellStyle(style5);		c_R3_A.setCellValue("");
				XSSFCell c_R3_B = row.createCell(1);		c_R3_B.setCellStyle(style5);		c_R3_B.setCellValue("주행상태");
				XSSFCell c_R3_C = row.createCell(2);		c_R3_C.setCellStyle(style6);		c_R3_C.setCellValue(acc_drStatusView);
				XSSFCell c_R3_D = row.createCell(3);		c_R3_D.setCellStyle(style6);		c_R3_D.setCellValue("");
				XSSFCell c_R3_E = row.createCell(4);		c_R3_E.setCellStyle(style6);		c_R3_E.setCellValue("");
				XSSFCell c_R3_F = row.createCell(5);		c_R3_F.setCellStyle(style6);		c_R3_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R4_A = row.createCell(0);		c_R4_A.setCellStyle(style5);		c_R4_A.setCellValue("");
				XSSFCell c_R4_B = row.createCell(1);		c_R4_B.setCellStyle(style5);		c_R4_B.setCellValue("운행정보");
				XSSFCell c_R4_C = row.createCell(2);		c_R4_C.setCellStyle(style6);		c_R4_C.setCellValue(acc_rideStr);
				XSSFCell c_R4_D = row.createCell(3);		c_R4_D.setCellStyle(style6);		c_R4_D.setCellValue("");
				XSSFCell c_R4_E = row.createCell(4);		c_R4_E.setCellStyle(style6);		c_R4_E.setCellValue("");
				XSSFCell c_R4_F = row.createCell(5);		c_R4_F.setCellStyle(style6);		c_R4_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R5_A = row.createCell(0);		c_R5_A.setCellStyle(style5);		c_R5_A.setCellValue("");
				XSSFCell c_R5_B = row.createCell(1);		c_R5_B.setCellStyle(style5);		c_R5_B.setCellValue("파손정도");
				XSSFCell c_R5_C = row.createCell(2);		c_R5_C.setCellStyle(style6);		c_R5_C.setCellValue(Util.nvl(String.valueOf(egovMap.get("acccarDamageView"))));
				XSSFCell c_R5_D = row.createCell(3);		c_R5_D.setCellStyle(style6);		c_R5_D.setCellValue("");
				XSSFCell c_R5_E = row.createCell(4);		c_R5_E.setCellStyle(style6);		c_R5_E.setCellValue("");
				XSSFCell c_R5_F = row.createCell(5);		c_R5_F.setCellStyle(style6);		c_R5_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;

				row = sheet.createRow(iRow);
				row.setHeight((short)500);		//1000 이 행높이 50
				XSSFCell c_R6_A = row.createCell(0);		c_R6_A.setCellStyle(style5);		c_R6_A.setCellValue("");
				XSSFCell c_R6_B = row.createCell(1);		c_R6_B.setCellStyle(style5);		c_R6_B.setCellValue("인적피해");
				XSSFCell c_R6_C = row.createCell(2);		c_R6_C.setCellStyle(style6);		c_R6_C.setCellValue(acc_auto_human);
				XSSFCell c_R6_D = row.createCell(3);		c_R6_D.setCellStyle(style6);		c_R6_D.setCellValue("");
				XSSFCell c_R6_E = row.createCell(4);		c_R6_E.setCellStyle(style6);		c_R6_E.setCellValue("");
				XSSFCell c_R6_F = row.createCell(5);		c_R6_F.setCellStyle(style6);		c_R6_F.setCellValue("");
				sheet.addMergedRegion(new CellRangeAddress(iRow-5,iRow, 0, 0));
				sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
				iRow++;
			}

			row = sheet.createRow(iRow);
			row.setHeight((short)2000);		//1000 이 행높이 50
			XSSFCell c_R7_A = row.createCell(0);		c_R7_A.setCellStyle(style5);		c_R7_A.setCellValue("사고상세묘사");
			XSSFCell c_R7_B = row.createCell(1);		c_R7_B.setCellStyle(style5);		c_R7_B.setCellValue("");
			XSSFCell c_R7_C = row.createCell(2);		c_R7_C.setCellStyle(style6);		c_R7_C.setCellValue(Util.nvl(incdInfo.get("accDetailInfo")));
			XSSFCell c_R7_D = row.createCell(3);		c_R7_D.setCellStyle(style6);		c_R7_D.setCellValue("");
			XSSFCell c_R7_E = row.createCell(4);		c_R7_E.setCellStyle(style6);		c_R7_E.setCellValue("");
			XSSFCell c_R7_F = row.createCell(5);		c_R7_F.setCellStyle(style6);		c_R7_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 0, 1));
			sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));
			iRow++;

			row = sheet.createRow(iRow);
			row.setHeight((short)2500);
			c_12_A =row.createCell(0);		c_12_A.setCellStyle(style2);		c_12_A.setCellValue("「자동차관리법」제27조제5항 및 동법시행규칙 제26조의3제3항에 따라 자율주행차 사고보고서를 제출합니다. \n\n\n 년        월        일 \n\n\n 제출인                     (서명 또는 인)");
			c_12_B =row.createCell(1);		c_12_B.setCellStyle(style2);		c_12_B.setCellValue("");
			c_12_C =row.createCell(2);		c_12_C.setCellStyle(style2);		c_12_C.setCellValue("");
			c_12_D =row.createCell(3);		c_12_D.setCellStyle(style2);		c_12_D.setCellValue("");
			c_12_E =row.createCell(4);		c_12_E.setCellStyle(style2);		c_12_E.setCellValue("");
			c_12_F =row.createCell(5);		c_12_F.setCellStyle(style2);		c_12_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 0, 5));
			iRow++;

			row = sheet.createRow(iRow);
			row.setHeight((short)1000);
			c_13_A =row.createCell(0);		c_13_A.setCellStyle(style2);		c_13_A.setCellValue("첨부서류");
			c_13_B =row.createCell(1);		c_13_B.setCellStyle(style2);		c_13_B.setCellValue("");
			c_13_C =row.createCell(2);		c_13_C.setCellStyle(style2);		c_13_C.setCellValue("1. 운행정보 및 주행영상 데이터 사본 \n 2. 사고기록장치 저장 데이터 사본");
			c_13_D =row.createCell(3);		c_13_D.setCellStyle(style2);		c_13_D.setCellValue("");
			c_13_E =row.createCell(4);		c_13_E.setCellStyle(style2);		c_13_E.setCellValue("");
			c_13_F =row.createCell(5);		c_13_F.setCellStyle(style2);		c_13_F.setCellValue("");
			sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 0, 1));
			sheet.addMergedRegion(new CellRangeAddress(iRow,iRow, 2, 5));

	        FileOutputStream fileOutput = null;
	        try{
	    		if(filePath != null && !"".equals(filePath) ) {
//					filePath = ExcelUtil.getReplace(filePath, "/", "\\\\");
	    		}
				fileOutput = new FileOutputStream(filePath);
				wb.write(fileOutput);
			} catch(IOException ioe){
				log.info("[IncdExcel Exception] 교통사고 보고서 엑셀파일 생성 실패 1: " + ioe.toString());
				result = "0";
			} finally {
				if(fileOutput != null) try {fileOutput.close();} catch (IOException e1) {log.info("[IncdExcel fileOutput] 실패 : " + e1.toString());};
			}


		} catch (Exception e) {
			log.info("[IncdExcel Exception] 교통사고 보고서 엑셀파일 처리 실패 2: " + e.toString());
			result = "0";
		}
		return result;
	}


}
