package katri.avsc.openapi.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("openApiDAO")
public class OpenApiDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OpenApiDAO.class);

	/**
	 * OpenAPI 신청 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	public Map<String, String> selectOpenApiInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("openApiDAO.selectOpenApiInfo", paramMap);
	}
	
	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertOpenApi(Map<String, String> paramMap) {
		return insert("openApiDAO.insertOpenApi", paramMap);
	}
	
	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object updateOpenApi(Map<String, String> paramMap) {
		return update("openApiDAO.updateOpenApi", paramMap);
	}
	
	/**
	 * 삭제한다.
	 * @param paramMap - 삭제할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object deleteOpenApi(Map<String, String> paramMap) {
		return insert("openApiDAO.deleteOpenApi", paramMap);
	}
	
	/**
	 * OpenAPI Key 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	public Map<String, String> selectApiKey(Map<String, String> paramMap) {
		return (Map<String, String>) select("openApiDAO.selectApiKey", paramMap);
	}	
	
	/**
	 * 협의체데이터 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectConsList(Map<String, String> paramMap) throws Exception {
		return list("openApiDAO.selectConsList", paramMap);	
	}
}
