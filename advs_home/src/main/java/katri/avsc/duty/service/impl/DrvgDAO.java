package katri.avsc.duty.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("drvgDAO")
public class DrvgDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DrvgDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDrvgList(Map<String, String> paramMap) throws Exception {
		return list("drvgDAO.selectDrvgList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDrvgListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("drvgDAO.selectDrvgListTotCnt", paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDrvgIsExist(Map<String, String> paramMap) {
		return (Integer) select("drvgDAO.selectDrvgIsExist", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDrvgInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("drvgDAO.selectDrvgInfo", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public void insertDrvg(Map<String, String> paramMap) {
		insert("drvgDAO.insertDrvg", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateDrvg(Map<String, String> paramMap) {
		return update("drvgDAO.updateDrvg", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deleteDrvg(Map<String, String> paramMap) {
		return delete("drvgDAO.deleteDrvg", paramMap);
	}

	/**
	 * 자율주행 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectAutoDrivingList(Map<String, String> paramMap) {
		return list("drvgDAO.selectAutoDrivingList", paramMap);
	}

	/**
	 * 제어권전환 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectCtrChangeList(Map<String, String> paramMap) {
		return list("drvgDAO.selectCtrChangeList", paramMap);
	}

	/**
	 * 제어권전환 상세 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectCtrChangeDtlList(Map<String, String> paramMap) {
		return list("drvgDAO.selectCtrChangeDtlList", paramMap);
	}

	/**
	 * 자율주행 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertAutoDriving(Map<String, String> paramMap) { 
		return insert("drvgDAO.insertAutoDriving", paramMap);
	}

	/**
	 * 자율주행 수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateAutoDriving(Map<String, String> paramMap) {
		return update("drvgDAO.updateAutoDriving", paramMap);
	}

	/**
	 * 자율주행 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deleteAutoDriving(Map<String, String> paramMap) {
		return delete("drvgDAO.deleteAutoDriving", paramMap);
	}

	/**
	 * 제어권전환 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertCtrChange(Map<String, String> paramMap) { 
		return insert("drvgDAO.insertCtrChange", paramMap);
	}

	/**
	 * 제어권전환 수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateCtrChange(Map<String, String> paramMap) {
		return update("drvgDAO.updateCtrChange", paramMap);
	}

	/**
	 * 제어권전환 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deleteCtrChange(Map<String, String> paramMap) {
		return delete("drvgDAO.deleteCtrChange", paramMap);
	}

	/**
	 * 제어권전환 상세 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertCtrChangeDtl(Map<String, String> paramMap) { 
		return insert("drvgDAO.insertCtrChangeDtl", paramMap);
	}

	/**
	 * 제어권전환 상세 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deleteCtrChangeDtl(Map<String, String> paramMap) {
		return delete("drvgDAO.deleteCtrChangeDtl", paramMap);
	}

	/**
	 * 등록기간 체크
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDrvgIsCheck(Map<String, String> paramMap) {
		return (Integer) select("drvgDAO.selectDrvgIsCheck", paramMap);
	}

	public void insertExcel(Map<String, Object> paramMap) {
		this.insert("drvgDAO.insertExcel", paramMap);
		
	}

	public String excelUpload(Map<String, String> map) {
		String result = "";
		result = (String)this.insert("drvgDAO.excelUpload", map);
		return  result;
	}

	public Map<String, String> selectAttachFileList() {
		return (Map<String, String>) select("drvgDAO.selectAttachFileList");
	}
	
	// ldk-custom
	
	/**
	 * 첨부파일 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertPDFFile(Map<String, String> paramMap) { 
		return insert("drvgDAO.insertPDFFile", paramMap);
	}
	
	/**
	 * 첨부파일 조회
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Map<String,String> selectPDFFile(Map<String,String> paramMap) {
		return(Map<String, String>) select("drvgDAO.selectPDFFile", paramMap);
	}
	
	/**
	 * 첨부파일 수정
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public int updatePDFFile(Map<String,String> paramMap) {
		return update("drvgDAO.updatePDFFile", paramMap);
	}
	
	/**
	 * 첨부파일 삭제
	 * @param paramMap - 삭제할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deletePDFFile(Map<String, String> paramMap) {
		return delete("drvgDAO.deletePDFFile", paramMap);
	}
	// ldk-custom-end


}
