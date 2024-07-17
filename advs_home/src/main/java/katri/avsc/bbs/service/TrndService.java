package katri.avsc.bbs.service;

import java.util.List;
import java.util.Map;

public interface TrndService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectTrndList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectTrndListTotCnt(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectTrndInfo(Map<String, String> paramMap);

	/**
	 * 조회수 증가
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateIqurNctn(Map<String, String> paramMap);

}
