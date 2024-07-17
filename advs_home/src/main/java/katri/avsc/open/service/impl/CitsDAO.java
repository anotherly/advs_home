package katri.avsc.open.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("citsDAO")
public class CitsDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CitsDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectCitsList(Map<String, String> paramMap) throws Exception {
		return list("citsDAO.selectCitsList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectCitsListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("citsDAO.selectCitsListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectCitsInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("citsDAO.selectCitsInfo", paramMap);
	}


}
