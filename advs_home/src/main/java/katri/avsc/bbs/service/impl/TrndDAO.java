package katri.avsc.bbs.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("trndDAO")
public class TrndDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TrndDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectTrndList(Map<String, String> paramMap) throws Exception {
		return list("trndDAO.selectTrndList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectTrndListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("trndDAO.selectTrndListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectTrndInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("trndDAO.selectTrndInfo", paramMap);
	}

	/**
	 * 조회수 증가
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateIqurNctn(Map<String, String> paramMap) {
		return update("trndDAO.updateIqurNctn", paramMap);
	}

}
