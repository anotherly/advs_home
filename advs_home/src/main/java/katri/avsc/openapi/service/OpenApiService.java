package katri.avsc.openapi.service;

import java.util.List;
import java.util.Map;

public interface OpenApiService{
	
	/**
	 * OpenAPI 신청 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	Map<String, String> selectOpenApiInfo(Map<String, String> paramMap);

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	Object insertOpenApi(Map<String, String> paramMap);
	
	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	Object updateOpenApi(Map<String, String> paramMap);
	
	/**
	 * 삭제한다.
	 * @param paramMap - 삭제할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	Object deleteOpenApi(Map<String, String> paramMap);
	
	/**
	 * OpenAPI Key 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	Map<String, String> selectApiKey(Map<String, String> paramMap);
	
	/**
	 * 협의체데이터 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectConsList(Map<String, String> paramMap) throws Exception;
}
