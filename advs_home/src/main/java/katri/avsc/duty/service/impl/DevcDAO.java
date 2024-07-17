package katri.avsc.duty.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("devcDAO")
public class DevcDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DevcDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDevcList(Map<String, String> paramMap) throws Exception {
		return list("devcDAO.selectDevcList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDevcListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("devcDAO.selectDevcListTotCnt", paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDevcIsExist(Map<String, String> paramMap) {
		return (Integer) select("devcDAO.selectDevcIsExist", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDevcInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("devcDAO.selectDevcInfo", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertDevc(Map<String, String> paramMap) {
		return insert("devcDAO.insertDevc", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateDevc(Map<String, String> paramMap) {
		return update("devcDAO.updateDevc", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteDevc(Map<String, String> paramMap) {
		return delete("devcDAO.deleteDevc", paramMap);
	}


	/**
	 * Change_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceChangeId(Map<String, String> paramMap) {
		return (String) select("devcDAO.sequenceChangeId", paramMap);
	}

}
