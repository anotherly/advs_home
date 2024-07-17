package katri.avsc.data.service;

import java.util.List;
import java.util.Map;

public interface UphsService{

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectUphsList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectUphsListTotCnt(Map<String, String> paramMap);

	/**
	 * 관리자 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDtmgList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectDtmgListTotCnt(Map<String, String> paramMap);


}
