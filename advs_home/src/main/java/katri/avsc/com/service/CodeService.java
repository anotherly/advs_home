package katri.avsc.com.service;

import java.util.List;
import java.util.Map;

public interface CodeService{
	
	/**
	 * 코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	List<?> selectSubCodeList(Map<String, String> paramMap);

	/**
	 * 임시운행정보 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	List<?> selectTempOperList(Map<String, String> paramMap);
	
	/**
	 * 임시운행정보
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보
	 * @exception Exception
	 */
	Map selectTempOperInfo(Map<String, String> paramMap);	
	
	/**
	 * 임시운행정보 보험가입일자 이력 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	List<?> selectTempOperInsdateHisList(Map<String, String> paramMap);

	/**
	 * 임시운행기관을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 임시운행기관
	 * @exception
	 */
	String selectTmpAgency(Map<String, String> paramMap);

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectTmpNoIsExist(Map<String, String> paramMap);

	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertTempOper(Map<String, String> paramMap);

	/**
	 * 임시운행정보 보험가입일자 수정 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	Object updateTempOperInsdate(Map<String, String> paramMap);
	
	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	void insertTempOperInsdateHis(Map<String, String> paramMap);	

	/**
	 * 게시판그룹 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판그룹 리스트
	 * @exception Exception
	 */
	List<?> selectBbsGroupList(Map<String, String> paramMap);

	/**
	 * 게시판 리스트
	 * @param paramMap - 검색할 정보
	 * @return 게시판 리스트
	 * @exception Exception
	 */
	List<?> selectBbsList(Map<String, String> paramMap);

	/**
	 * 차량 리스트
	 * @param paramMap - 검색할 정보
	 * @return 차량 리스트
	 * @exception Exception
	 */
	List<?> selectCarList(Map<String, String> paramMap);

	/**
	 * 게시판 목록 리스트-셀렉트박스
	 * @param paramMap - 검색할 정보
	 * @return 게시판그룹 리스트
	 * @exception Exception
	 */
	List<?> selectBbsSeqList(Map<String, String> paramMap);

	/**
	 * 제어권전환사유코드 목록 조회
	 * @param paramMap
	 * @return
	 */
	List<?> selectCtrChangeCodeList(Map<String, String> paramMap);

	/**
	 * 차량관리 리스트
	 * @param paramMap - 검색할 정보
	 * @return 차량관리 리스트
	 * @exception Exception
	 */
	List<?> selectTempCareList(Map<String, String> paramMap);

	/**
	 * 차량관리 리스트 총 개수
	 * @param paramMap - 검색할 정보
	 * @return 차량관리 리스트 총 개수
	 * @exception Exception
	 */
	int selectTempCareListTotCnt(Map<String, String> paramMap);
	
	/**
	 * 서브코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	List<?> selectSubCodeChkList(Map<String, String> paramMap);
	
	/**
	 * 서드코드 정보
	 * @param paramMap - 검색할 정보
	 * @return 코드정보
	 * @exception Exception
	 */
	List<?> selectSubCodeChkList2(Map<String, String> paramMap);
	
	/**
	 * 임시운행정보 리스트
	 * @param paramMap - 검색할 정보
	 * @return 임시운행정보 리스트
	 * @exception Exception
	 */
	List<?> selectDutyList(Map<String, String> paramMap);
}
