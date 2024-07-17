package katri.avsc.data.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("rqhsDAO")
public class RqhsDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RqhsDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectRqhsList(Map<String, String> paramMap) {
		return list("rqhsDAO.selectRqhsList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectRqhsListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("rqhsDAO.selectRqhsListTotCnt", paramMap);
	}
    
	/**
	 * 기관명을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, String> selectMemberList(Map<String, String> paramMap) {
		return (Map<String, String>) select("rqhsDAO.selectMemberList", paramMap);
	}
	
	/**
	 * 임시운행번호을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectRaceNumberList(Map<String, String> paramMap) {
		return list("rqhsDAO.selectRaceNumberList", paramMap);
	}
	
	/**
	 * 권한위임요청한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertAuth(Map<String, String> paramMap) {
		return insert("rqhsDAO.insertAuth", paramMap);
	}
	
	/**
	 * 요청 여부 체크한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectApporYn(Map<String, String> paramMap) {
		return list("rqhsDAO.selectApporYn", paramMap);
	}
	
	
	
}
