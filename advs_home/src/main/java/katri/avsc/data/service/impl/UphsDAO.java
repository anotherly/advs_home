package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("uphsDAO")
public class UphsDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UphsDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectUphsList(Map<String, String> paramMap) throws Exception {
		return list("uphsDAO.selectUphsList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectUphsListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("uphsDAO.selectUphsListTotCnt", paramMap);
	}

	/**
	 * 관리자 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDtmgList(Map<String, String> paramMap) throws Exception {
		return list("uphsDAO.selectDtmgList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDtmgListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("uphsDAO.selectDtmgListTotCnt", paramMap);
	}

}
