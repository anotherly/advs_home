package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("paraDAO")
public class ParaDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ParaDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectParaList(Map<String, String> paramMap) throws Exception {
		return list("paraDAO.selectParaList", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectParaInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("paraDAO.selectParaInfo", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertPara(Map<String, String> paramMap) {
		return insert("paraDAO.insertPara", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updatePara(Map<String, String> paramMap) {
		return update("paraDAO.updatePara", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deletePara(Map<String, String> paramMap) {
		return delete("paraDAO.deletePara", paramMap);
	}

}
