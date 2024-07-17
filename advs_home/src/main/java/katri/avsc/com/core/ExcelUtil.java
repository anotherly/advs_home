package katri.avsc.com.core;

import java.io.*;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.apache.poi.util.IOUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class ExcelUtil {

	private  static Log log = LogFactory.getLog(ExcelUtil.class);

	/**
	* 엑셀 cell의 값 처리한다.
	* 
	* @param cell 입력 cell
	* @throws IOException
	*/
	public static String getType(XSSFCell cell){
		String value =  "";
		if(cell != null){
			switch (cell.getCellType()) {
				case XSSFCell.CELL_TYPE_FORMULA:
					value = Util.nvl(cell.getNumericCellValue()+"");
					break;
				case XSSFCell.CELL_TYPE_NUMERIC:
					value = String.valueOf(new Double(cell.getNumericCellValue()).intValue());//실수형 데이터가 정수형으로 나오도록
					break;
				case XSSFCell.CELL_TYPE_STRING:
					value = Util.nvl(cell.getStringCellValue());
					break;
				case XSSFCell.CELL_TYPE_BLANK:
					value = Util.nvl(cell.getBooleanCellValue()+"");
					break;
				case XSSFCell.CELL_TYPE_ERROR:
					value = Util.nvl(cell.getErrorCellValue()+"");
					break;
				default:value = Util.nvl(cell.getStringCellValue());
				break;
			}
		}
		log.debug("cell_value : " + value);
		return value;
	}

	/**
     * <pre>
     * str에서 rep에 해당하는 String을 tok로 replace한다.
	 * "select * from TEST", "*", "USER"
	 * -> "select USER from TEST"
     * </pre>
     *
     * @param str 변경할 문자열.
     * @param rep 변경할 문자.
     * @param tok 변경될 문자.
     * @return 변경된 문자열.
     */
    public static String getReplace(String str, String rep, String tok) {
        String retStr = "";
        if(str == null) return "";
        if(str.equals("")) return "";

        for(int i=0, j=0; (j = str.indexOf(rep,i)) > -1; i=j+rep.length()) {
            retStr += (str.substring(i,j) + tok);
        }
        return (str.indexOf(rep) == -1) ? str : retStr + str.substring(str.lastIndexOf(rep)+rep.length(),str.length());
    }

	public List<HashMap<Integer, String>> excelReadSetValue(CommonsMultipartFile file, int sheetNum, int strartRowNum,
			int startCelNum) throws IOException {
		List<HashMap<Integer, String>> resultList = new ArrayList<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//xls, xlsx 구분
		Workbook workbook = null;
		if(file.getOriginalFilename().toUpperCase().endsWith("XLSX")) {
			workbook = new XSSFWorkbook(file.getInputStream());

		}else {
			workbook = new HSSFWorkbook(file.getInputStream());
		}

		//Sheet 수 확인
		int sheetCnt = workbook.getNumberOfSheets();
		int listNum = 0;	

		try {

			if (sheetCnt > 0) {
			//첫번째 Sheet 선택
			Sheet sheet = workbook.getSheetAt(sheetNum);
			//Sheet의 Row와 Cell 수 확인
			int rows = sheet.getPhysicalNumberOfRows();
			int cells = sheet.getRow(0).getPhysicalNumberOfCells();
			HashMap<Integer, String> valueMap = null;

			//Header Row 빼고 시작(0에서 시작)
			for(int r = strartRowNum ; r < rows; r++) {
				//String device_id = "";
				valueMap = new HashMap<Integer, String>();
				//한 줄씩 읽고 데이터 저장
				Row row = sheet.getRow(r);
				if (row != null) {
					//Cell 기본값 빼고 시작(0에서 시작)
					for(int c = startCelNum ; c < cells ; c++) {
						Cell cell = row.getCell(c);
						if (cell != null) {
							String value = "";
							switch(cell.getCellType()) {
							case Cell.CELL_TYPE_BLANK :
								value = "";
								break;
							case Cell.CELL_TYPE_BOOLEAN :
								value = "" + cell.getBooleanCellValue();
								break;
							case Cell.CELL_TYPE_ERROR :
								value = "" + cell.getErrorCellValue();
								break;
							case Cell.CELL_TYPE_FORMULA :
								value = cell.getCellFormula();
								break;
							case Cell.CELL_TYPE_NUMERIC :
								if(HSSFDateUtil.isInternalDateFormat(cell.getCellStyle().getDataFormat())) {
									value = sdf.format(cell.getDateCellValue());
								}else {
									cell.setCellType(Cell.CELL_TYPE_STRING );
									value = cell.getStringCellValue(); 
								}
								break;
							case Cell.CELL_TYPE_STRING :
								value = cell.getStringCellValue();
								break;
							}
							//공백과 트림 제거
							//value = value.trim().replaceAll(" ", "");
							valueMap.put(c, value);
						}
					}//end col for
					resultList.add(listNum++, valueMap);
				}//end if
			}//end row for
		}
	} catch(Exception e) {
		e.getStackTrace();
	}
	return resultList;
	}

}
