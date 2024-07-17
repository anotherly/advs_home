package katri.avsc.egovframework.cmmn.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class ExcelRead {
	public static List<Map<String, String>> read(ExcelReadOption excelReadOption){
		Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
			
		Sheet sheet = wb.getSheetAt(0);
		
		System.out.println(wb.getSheetName(0));
		System.out.println(wb.getNumberOfSheets());
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		String cellName = "";
		
		Map<String, String> map = null;
		
		List<Map<String, String>> result = new ArrayList<Map<String, String>>();
		
		for(int rowIndex = excelReadOption.getStartRow()-1; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			if(row != null) {
				numOfCells = row.getPhysicalNumberOfCells();
				map = new HashMap<String,String>();
				for(int cellIndex = 0; cellIndex<numOfCells; cellIndex++) {
					cell = row.getCell(cellIndex);
					cellName = ExcelCellRef.getName(cell, cellIndex);
					if(!excelReadOption.getOutputColumns().contains(cellName)) {
						continue;				
					}
					map.put(cellName, ExcelCellRef.getValue(cell));
				}
				result.add(map);
			}
		}
			return result;
	}

	
	/*
	public static List<Map<String, String>> read1ExcelReadOption excelReadOption){
		System.out.println("column >>>>>>>>>>>> "+excelReadOption.getOutputColumns());
		System.out.println("Path >>>>>>>>>>>> "+excelReadOption.getFilePath());
		System.out.println("SheetNum >>>>>>>>>>>> "+excelReadOption.getSheetNum());
		System.out.println("StartRow >>>>>>>>>>>> "+excelReadOption.getStartRow());
		
		if(excelReadOption != null) {
			Workbook wb = ExcelFileType.getWorkbook(excelReadOption.getFilePath());
			int sheetNum = wb.getNumberOfSheets();
			Row row = null;
			Cell cell = null;
			String cellName = "";
			int numOfCells = 0;
			Map<String, String> map = new HashMap<String, String>();
			List<Map<String, String>> result = new ArrayList<Map<String, String>>();
			
			for(int k=0; k<sheetNum; k++) {
				Sheet sheet = wb.getSheetAt(k);
				
				int numOfRows = sheet.getLastRowNum()+1;
				int numOfRows1 = sheet.getPhysicalNumberOfRows();
				System.out.println("numOfRows :::::::: "+numOfRows);
				if(numOfRows <= 1) {
					//map = 
					map.put("errorMessage", "numOfRows 1이 반환되는 오류 발생");
					result.add(map);
					return result;
				}
				
				for(int rowIndex = excelReadOption.getStartRow() -1; rowIndex < numOfRows; rowIndex++) {
					row = sheet.getRow(rowIndex);
					if(sheet.getRow(rowIndex).getCell(1) != null && row != null) {
						numOfCells = row.getLastCellNum();
						//numOfCells = row.getPhysicalNumberOfCells();						
						//map = new HashMap<String, String>();
						System.out.println("numOfCells >>>>>>>>>>>> "+numOfCells);
						for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
							cell = row.getCell(cellIndex);
							if(cell == null) {
								continue;
							}else{
								switch(cell.getCellType()) {
									case Cell.CELL_TYPE_NUMERIC :
										if(HSSFDateUtil.isCellDateFormatted(cell)) {
											SimpleDateFormat formatter = new SimpleDateFormat("YYYY-MM-dd");
											cell.setCellValue(formatter.format(cell.getDateCellValue()));
										}else {
											if((cell.getNumericCellValue()+"").contains(".0")) {
												cell.setCellValue((int)cell.getNumericCellValue()+ "");
											}else {
												cell.setCellValue((float)cell.getNumericCellValue()+ "");
											}
										}
										break;
									case Cell.CELL_TYPE_FORMULA :
										cell.setCellType(Cell.CELL_TYPE_STRING);
										String temp_value = cell.getStringCellValue().toString();
										if(temp_value.indexOf(".") > 0) {
											Double value = Double.parseDouble(String.format("%1.f", Double.parseDouble(cell.getRichStringCellValue().toString())));
											cell.setCellValue(value);
										}else {
											cell.setCellValue(cell.getStringCellValue());
										}
										break;
								}
							}
							cellName = ExcelCellRef.getName(cell, cellIndex);
							System.out.println("cellName ::::: "+cellName);
							System.out.println("1. map :::::: > "+map);
							map.put(cellName, ExcelCellRef.getValue(cell, wb));							
							
							if(!excelReadOption.getOutputColumns().contains(cellName)) {
								continue;
							}
						}
						System.out.println("2.map :::::: > "+map);
						result.add(map);
					}else {
						break;
					}
				}
			}
			return result;
		}
		return null;
	*/
}



