package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("codeDAO")
public class CodeDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CodeDAO.class);

	/**
	 * 서브코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 서브코드정보
	 * @exception Exception
	 */
	public List<?> selectSubCodeList(Map<String, String> paramMap) {
		return list("codeDAO.selectSubCodeList", paramMap);
	}

	/**
	 * 임시운행정보 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	public List<?> selectTempOperList(Map<String, String> paramMap) {
		return list("codeDAO.selectTempOperList", paramMap);
	}
	
	/**
	 * 임시운행정보 조회
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보
	 * @exception Exception
	 */
	public Map selectTempOperInfo(Map<String, String> paramMap) {
		return (Map)select("codeDAO.selectTempOperInfo", paramMap);
	}	

	/**
	 * 임시운행정보 보험가입일자 이력 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	public List<?> selectTempOperInsdateHisList(Map<String, String> paramMap) {
		return list("codeDAO.selectTempOperInsdateHisList", paramMap);
	}
	/**
	 * 임시운행기관을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 임시운행기관
	 * @exception
	 */
	public String selectTmpAgency(Map<String, String> paramMap) {
		return (String) select("codeDAO.selectTmpAgency", paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectTmpNoIsExist(Map<String, String> paramMap) {
		return (Integer) select("codeDAO.selectTmpNoIsExist", paramMap);
	}

	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertTempOper(Map<String, String> paramMap) {
		return insert("codeDAO.insertTempOper", paramMap);
	}

	/**
	 * 임시운행정보 보험가입일자 수정 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object updateTempOperInsdate(Map<String, String> paramMap) {
		return update("codeDAO.updateTempOperInsdate", paramMap);
	}	
	
	/**
	 * 임시운행정보 보험번호이력 등록 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertTempOperInsdateHis(Map<String, String> paramMap) {
		return insert("codeDAO.insertTempOperInsdateHis", paramMap);
	}	

	/**
	 * 게시판그룹 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판그룹 리스트
	 * @exception Exception
	 */
	public List<?> selectBbsGroupList(Map<String, String> paramMap) {
		return list("codeDAO.selectBbsGroupList", paramMap);
	}

	/**
	 * 게시판 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판 리스트
	 * @exception Exception
	 */
	public List<?> selectBbsList(Map<String, String> paramMap) {
		return list("codeDAO.selectBbsList", paramMap);
	}

	/**
	 * 차량 리스트
	 * @param paramMap - 검색할 정보
	 * @return 차량 리스트
	 * @exception Exception
	 */
	public List<?> selectCarList(Map<String, String> paramMap) {
		return list("codeDAO.selectCarList", paramMap);
	}

	/**
	 * 게시판 목록 리스트-셀렉트박스
	 * @param paramMap - 검색할 정보
	 * @return 게시판 리스트
	 * @exception Exception
	 */
	public List<?> selectBbsSeqList(Map<String, String> paramMap) {
		return list("codeDAO.selectBbsSeqList", paramMap);
	}

	/**
	 * 제어권전환사유코드 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectCtrChangeCodeList(Map<String, String> paramMap) {
		return list("codeDAO.selectCtrChangeCodeList", paramMap);
	}

	/**
	 * 차량관리 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectTempCareList(Map<String, String> paramMap) {
		return list("codeDAO.selectTempCareList", paramMap);
	}

	/**
	 * 차량관리 목록 총 개수
	 * @param paramMap
	 * @return
	 */
	public int selectTempCareListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("codeDAO.selectTempCareListTotCnt", paramMap);
	}
	
	/**
	 * 서브코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 서브코드정보
	 * @exception Exception
	 */
	public List<?> selectSubCodeChkList(Map<String, String> paramMap) {
		return list("codeDAO.selectSubCodeChkList", paramMap);
	}
	
	/**
	 * 서드코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 서브코드정보
	 * @exception Exception
	 */
	public List<?> selectSubCodeChkList2(Map<String, String> paramMap) {
		return list("codeDAO.selectSubCodeChkList2", paramMap);
	}
	
	/**
	 * 차량관리 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectDutyList(Map<String, String> paramMap) {
		return list("codeDAO.selectDutyList", paramMap);
	}

}
