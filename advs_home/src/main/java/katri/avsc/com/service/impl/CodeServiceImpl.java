package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.com.service.CodeService;

@Service("codeService")
public class CodeServiceImpl extends EgovAbstractServiceImpl implements CodeService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CodeServiceImpl.class);

	/** CodeDAO */
	// TODO ibatis 사용
	@Resource(name = "codeDAO")
	private CodeDAO codeDAO;

	/**
	 * 코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	@Override
	public List<?> selectSubCodeList(Map<String, String> paramMap) {
		return codeDAO.selectSubCodeList(paramMap);
	}
	
	/**
	 * 임시운행정보 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectTempOperList(Map<String, String> paramMap) {
		return codeDAO.selectTempOperList(paramMap);
	}
	
	/**
	 * 임시운행정보
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보
	 * @exception Exception
	 */
	@Override
	public Map selectTempOperInfo(Map<String, String> paramMap) {
		return codeDAO.selectTempOperInfo(paramMap);
	}
	/**
	 * 임시운행정보 보험가입일자 이력 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectTempOperInsdateHisList(Map<String, String> paramMap) {
		return codeDAO.selectTempOperInsdateHisList(paramMap);
	}	
	
	/**
	 * 임시운행기관을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 임시운행기관
	 * @exception
	 */
	@Override
	public String selectTmpAgency(Map<String, String> paramMap) {
		return codeDAO.selectTmpAgency(paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectTmpNoIsExist(Map<String, String> paramMap) {
		return codeDAO.selectTmpNoIsExist(paramMap);
	}

	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertTempOper(Map<String, String> paramMap) { 
		codeDAO.insertTempOper(paramMap);
	}

	/**
	 * 임시운행정보 보험가입일자 수정 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	@Override
	public Object updateTempOperInsdate(Map<String, String> paramMap) {
		return codeDAO.updateTempOperInsdate(paramMap);
	}	

	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertTempOperInsdateHis(Map<String, String> paramMap) { 
		codeDAO.insertTempOperInsdateHis(paramMap);
	}
	
	/**
	 * 게시판그룹 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판그룹 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectBbsGroupList(Map<String, String> paramMap) {
		return codeDAO.selectBbsGroupList(paramMap);
	}

	/**
	 * 게시판 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectBbsList(Map<String, String> paramMap) {
		return codeDAO.selectBbsList(paramMap);
	}

	/**
	 * 차량 리스트
	 * @param paramMap - 검색할 정보
	 * @return 차량 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectCarList(Map<String, String> paramMap) {
		return codeDAO.selectCarList(paramMap);
	}

	/**
	 * 게시판 목록 리스트-셀렉트박스
	 * @param paramMap - 검색할 정보
	 * @return 게시판 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectBbsSeqList(Map<String, String> paramMap) {
		return codeDAO.selectBbsSeqList(paramMap);
	}

	/**
	 * 제어권전환사유코드 목록 조회
	 * @param paramMap
	 * @return
	 */
	public List<?> selectCtrChangeCodeList(Map<String, String> paramMap) {
		return codeDAO.selectCtrChangeCodeList(paramMap);
	}
	
	/**
	 * 차량관리 리스트
	 * @param paramMap - 검색할 정보
	 * @return 차량관리 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectTempCareList(Map<String, String> paramMap) {
		return codeDAO.selectTempCareList(paramMap);
	}

	/**
	 * 차량관리 리스트 총개수
	 * @param paramMap - 검색할 정보
	 * @return 차량관리 리스트 총개수
	 * @exception Exception
	 */
	@Override
	public int selectTempCareListTotCnt(Map<String, String> paramMap) {
		return codeDAO.selectTempCareListTotCnt(paramMap);
	}
	
	/**
	 * 서브코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	@Override
	public List<?> selectSubCodeChkList(Map<String, String> paramMap) {
		return codeDAO.selectSubCodeChkList(paramMap);
	}
	
	/**
	 * 서드코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	@Override
	public List<?> selectSubCodeChkList2(Map<String, String> paramMap) {
		return codeDAO.selectSubCodeChkList2(paramMap);
	}
	
	/**
	 * 임시운행정보 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	@Override
	public List<?> selectDutyList(Map<String, String> paramMap) {
		return codeDAO.selectDutyList(paramMap);
	}
}
