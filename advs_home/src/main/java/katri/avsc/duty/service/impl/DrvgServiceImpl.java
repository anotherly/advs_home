package katri.avsc.duty.service.impl;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFCell;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.com.core.ExcelUtil;
import katri.avsc.com.core.StringUtil;
import katri.avsc.duty.service.DrvgService;
import katri.avsc.egovframework.cmmn.util.ExcelFileType;
import katri.avsc.egovframework.cmmn.util.ExcelRead;
import katri.avsc.egovframework.cmmn.util.ExcelReadOption;


@Service("drvgService")
public class DrvgServiceImpl extends EgovAbstractServiceImpl implements DrvgService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DrvgServiceImpl.class);

	/** DrvgDAO */
	// TODO ibatis 사용
	@Resource(name = "drvgDAO")
	private DrvgDAO drvgDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDrvgList(Map<String, String> paramMap) throws Exception {
		return drvgDAO.selectDrvgList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDrvgListTotCnt(Map<String, String> paramMap) {
		return drvgDAO.selectDrvgListTotCnt(paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDrvgIsExist(Map<String, String> paramMap) {
		return drvgDAO.selectDrvgIsExist(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectDrvgInfo(Map<String, String> paramMap) {
		return drvgDAO.selectDrvgInfo(paramMap);
	}

	/**
	 * 작성한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertDrvg(Map<String, String> paramMap) {
		drvgDAO.insertDrvg(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateDrvg(Map<String, String> paramMap) {
		return drvgDAO.updateDrvg(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteDrvg(Map<String, String> paramMap) {
		return drvgDAO.deleteDrvg(paramMap); 
	}

	/**
	 * 자율주행 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectAutoDrivingList(Map<String, String> paramMap) {
		return drvgDAO.selectAutoDrivingList(paramMap);
	}

	/**
	 * 제어권전환 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectCtrChangeList(Map<String, String> paramMap) {
		return drvgDAO.selectCtrChangeList(paramMap);
	}

	/**
	 * 제어권전환상세 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectCtrChangeDtlList(Map<String, String> paramMap) {
		return drvgDAO.selectCtrChangeDtlList(paramMap);
	}

	/**
	 * 자율주행 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAutoDriving(Map<String, String> paramMap) { 
		drvgDAO.insertAutoDriving(paramMap);
	}

	/**
	 * 자율주행 수정
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateAutoDriving(Map<String, String> paramMap) {
		return drvgDAO.updateAutoDriving(paramMap);
	}

	/**
	 * 자율주행 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteAutoDriving(Map<String, String> paramMap) {
		return drvgDAO.deleteAutoDriving(paramMap); 
	}

	/**
	 * 제어권전환 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertCtrChange(Map<String, String> paramMap) { 
		drvgDAO.insertCtrChange(paramMap);
	}

	/**
	 * 제어권전환 수정
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateCtrChange(Map<String, String> paramMap) {
		return drvgDAO.updateCtrChange(paramMap);
	}

	/**
	 * 제어권전환 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteCtrChange(Map<String, String> paramMap) {
		return drvgDAO.deleteCtrChange(paramMap); 
	}

	/**
	 * 제어권전환상세 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertCtrChangeDtl(Map<String, String> paramMap) { 
		drvgDAO.insertCtrChangeDtl(paramMap);
	}

	/**
	 * 제어권전환상세 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteCtrChangeDtl(Map<String, String> paramMap) {
		return drvgDAO.deleteCtrChangeDtl(paramMap); 
	}

	/**
	 * 등록기간 체크
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDrvgIsCheck(Map<String, String> paramMap) {
		return drvgDAO.selectDrvgIsCheck(paramMap);
	}

	@Override
	public String excelUpload(HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
		//파일 정보
		CommonsMultipartFile file = (CommonsMultipartFile)multiRequest.getFile("excelFile");
		//엑셀정보
		ExcelUtil eu = new ExcelUtil();
		int sheetNum = 0;		//1번째 시트 읽음 
		int strartRowNum = 3;	//3번째 줄부터 읽음
		int startCelNum = 0; 	//1번째 줄부터 읽음
		int chngS = Integer.parseInt(request.getParameter("chng_s")); // 제어권 총 입력 건수
		
		//int intChngLeng=Integer.parseInt(chngLeng);
		String result = "";
		//if(intChngS == intChngLeng) {
			List<HashMap<Integer, String>> excelList = eu.excelReadSetValue(file, sheetNum, strartRowNum, startCelNum);
			
			//테이블 Key 정보
			//DeviceBaseVO deviceBaseVO = null;
			Map<String, String> map = null;
			//엑셀 Row 수 만큼 For문 조회
			for(Object obj : excelList) {
				Map<Integer, String> mp = (Map<Integer, String>)obj;
				Set<Integer> keySet = mp.keySet();
				Iterator<Integer> iterator = keySet.iterator();
				map = new HashMap<String, String>();
				while(iterator.hasNext()) {
					int key = iterator.next();
					String value = StringUtil.nullConvert(mp.get(key));
					switch(key) {					
						case 0 :
							map.put("tmpRaceNumber", value);
							break;
						case 1 :
							map.put("ctrChangeDate", value);
							break;
						case 2 :
							map.put("ctrChangePlace", value);
							break;
						case 3 :
							map.put("ctrChangeContent", value);
							switch(value) {
							case "시스템 오류" :
								map.put("ctrChangeContentBefore", "A000001");
								break;
							case "교통상황" :
								map.put("ctrChangeContentBefore", "B000001");
								break;
							case "인식 오류" :
								map.put("ctrChangeContentBefore", "C000001");
								break;
							case "기타" :
								map.put("ctrChangeContentBefore", "D000001");
								break;
							}
							break;
						case 4 :
							map.put("rmk", StringUtil.nullConvert(value));
							break;
					}
					
					if(request.getParameter("stnd_dt")==null) {
						map.put("stndDt", request.getAttribute("stnd_dt").toString());
						map.put("reg_id", request.getAttribute("reg_id").toString());
					}else {
						map.put("stndDt", request.getParameter("stnd_dt"));
					}
				}
				int excelNum = excelList.size();
				
				if(chngS == excelNum) {
					try {
						result = drvgDAO.excelUpload(map);
						if(result == null) result = "1";	
					} catch (Exception ex) {
						//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
						result = "0";
						return result;
					}
				}else {
					result = "3";
				}
			}
		return result;
	}

	@Override
	public Map<String, String> selectAttachFileList() {
		return drvgDAO.selectAttachFileList();
	}
}
