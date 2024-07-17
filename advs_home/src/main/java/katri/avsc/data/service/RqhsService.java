package katri.avsc.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface RqhsService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectRqhsList(Map<String, String> paramMap);
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectRqhsListTotCnt(Map<String, String> paramMap);
	
	/**
	 * 기관명을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */	
	Map<String, String> selectMemberList(Map<String, String> paramMap);
	
	/**
	 * 임시운행번호을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectRaceNumberList(Map<String, String> paramMap);
	
	
	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAuth(Map<String, String> paramMap);
	
	/**
	 * 요청 여부 체크한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	List<?> selectApporYn(Map<String, String> paramMap);
	
	
	
}
