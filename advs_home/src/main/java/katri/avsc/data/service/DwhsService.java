package katri.avsc.data.service;

import java.util.List;
import java.util.Map;

public interface DwhsService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDwhsList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectDwhsListTotCnt(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectDwhsInfo(Map<String, String> paramMap);

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectDwhsIsExist(Map<String, String> paramMap);

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertDwhs(Map<String, String> paramMap);

	/**
	 * 평가점수 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateDwhs(Map<String, String> paramMap);

	/**
	 * 성과등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertDlResult(Map<String, String> paramMap);


}
