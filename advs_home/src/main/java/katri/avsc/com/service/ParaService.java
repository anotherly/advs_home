package katri.avsc.com.service;

import java.util.List;
import java.util.Map;

public interface ParaService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectParaList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectParaInfo(Map<String, String> paramMap);
	
	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertPara(Map<String, String> paramMap);

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updatePara(Map<String, String> paramMap);

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deletePara(Map<String, String> paramMap);

}
