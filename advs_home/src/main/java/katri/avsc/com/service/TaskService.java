package katri.avsc.com.service;

import java.util.List;
import java.util.Map;

public interface TaskService{
	
	/**
	 * 운행보고스케쥴 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectScheInfo(Map<String, String> paramMap);

	/**
	 * 운행보고 등록 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDvrgRegList(Map<String, String> paramMap) throws Exception;

}
