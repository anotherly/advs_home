package katri.avsc.egovframework.cmmn.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelFileType {
	public static Workbook getWorkbook(String filePath) {
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(filePath);
		}catch(FileNotFoundException e) {
			throw new RuntimeException(e.getMessage(), e);
		}
		
		Workbook wb = null;
		
		if(filePath.toUpperCase().endsWith(".XLS")) {
			try {
				wb = new HSSFWorkbook(fis);
			}catch(IOException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}else if(filePath.toUpperCase().endsWith(".XLSX")) {
			try {
				wb = new XSSFWorkbook(fis);
			}catch(IOException e){
				throw new RuntimeException(e.getMessage(), e);
			}
		}
		if(fis != null) {
			try {
				fis.close();
			}catch (IOException e) {
				System.out.println("엑셀 업로드 중 예외사황 발생!");
			}
		}
		return wb;
	}
}
