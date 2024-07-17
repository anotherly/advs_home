package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("taskDAO")
public class TaskDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TaskDAO.class);

	/**
	 * 운행보고스케쥴 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectScheInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("taskDAO.selectScheInfo", paramMap);
	}

	/**
	 * 운행보고 등록 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDvrgRegList(Map<String, String> paramMap) throws Exception {
		return list("taskDAO.selectDvrgRegList", paramMap);
	}

}
