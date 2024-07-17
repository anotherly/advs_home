package katri.avsc.openapi.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import katri.avsc.openapi.service.OpenApiService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("openApiService")
public class OpenApiServiceImpl extends EgovAbstractServiceImpl implements OpenApiService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(OpenApiServiceImpl.class);

	/** OpenAPIDAO */
	// TODO ibatis 사용
	@Resource(name = "openApiDAO")
	private OpenApiDAO openApiDAO;

	/**
	 * OpenAPI 신청 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	@Override
	public Map<String, String> selectOpenApiInfo(Map<String, String> paramMap) {
		return openApiDAO.selectOpenApiInfo(paramMap);
	}
	
	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	@Override
	public Object insertOpenApi(Map<String, String> paramMap) {
		return openApiDAO.insertOpenApi(paramMap);
	}
	
	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	@Override	
	public Object updateOpenApi(Map<String, String> paramMap) {
		return openApiDAO.updateOpenApi(paramMap);
	}
	
	/**
	 * 삭제한다.
	 * @param paramMap - 삭제할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	@Override	
	public Object deleteOpenApi(Map<String, String> paramMap) {
		return openApiDAO.deleteOpenApi(paramMap);
	}	
	
	/**
	 * OpenAPI Key 조회
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	@Override	
	public Map<String, String> selectApiKey(Map<String, String> paramMap) {
		return openApiDAO.selectApiKey(paramMap);
	}	
	
	/**
	 * 협의체데이터 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override	
	public List<?> selectConsList(Map<String, String> paramMap) throws Exception {
		return openApiDAO.selectConsList(paramMap);	
	}	
}
