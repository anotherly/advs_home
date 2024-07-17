package katri.avsc.egovframework.cmmn.util;

import org.apache.poi.ss.usermodel.Cell;
import java.text.SimpleDateFormat;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.taglibs.standard.lang.jstl.Evaluator;
import org.apache.poi.hssf.util.CellReference;

public class ExcelCellRef {
	public static String getName(Cell cell, int cellIndex) {
		int cellNum = 0;
		if(cell != null) {
			cellNum = cell.getColumnIndex();
		}else {
			cellNum = cellIndex;
		}
		
		return CellReference.convertNumToColString(cellNum);
	}
	
	public static String getValue(Cell cell) {
		String value = "";
		if(cell == null) {
			value="";			
		}else {
			if(cell.getCellType() == Cell.CELL_TYPE_FORMULA) {
				value=cell.getCellFormula();
			}else if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
				value=cell.getNumericCellValue()+"";
			}else if(cell.getCellType() == Cell.CELL_TYPE_STRING) {
				value=cell.getStringCellValue();
			}else if(cell.getCellType() == Cell.CELL_TYPE_BOOLEAN) {
				value=cell.getBooleanCellValue()+"";
			}else if(cell.getCellType() == Cell.CELL_TYPE_ERROR) {
				value=cell.getErrorCellValue()+"";
			}else if(cell.getCellType() == Cell.CELL_TYPE_BLANK) {
				value="";
			}else {
				value = cell.getStringCellValue();
			}
		}
		/*if(cell == null) {			
			switch(cell.getCellType()) {
				case HSSFCell.CELL_TYPE_FORMULA : 
					if(evaluator.evaluateFormulaCell(cell) == HSSFCell.CELL_TYPE_NUMERIC) {
						value = (float)cell.getNumericCellValue()+"";
					}else if(evaluator.evaluateFormulaCell(cell) == HSSFCell.CELL_TYPE_STRING) {
						value = cell.getStringCellValue();
					}
					break;
					
				case HSSFCell.CELL_TYPE_NUMERIC : 
					if(HSSFDateUtil.isCellDateFormatted(cell)) {
						SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-dd");
						value=formatter.format(cell.getDateCellValue());
					}else {
						if((cell.getNumericCellValue()+"").contains(".0")) {
							value = (int)cell.getNumericCellValue()+"";
						}else {
							value = (float)cell.getNumericCellValue()+"";
						}
					}
					break;
					
				case Cell.CELL_TYPE_STRING : 
					value = cell.getBooleanCellValue()+"";
					break;
					
				case Cell.CELL_TYPE_BLANK : 
					value = "";
					break;
					
				case Cell.CELL_TYPE_ERROR : 
					value = cell.getErrorCellValue()+"";
					break;
					
				default : 
					value = cell.getStringCellValue();
					break;
			}
		}*/
		return value;
	}
}
