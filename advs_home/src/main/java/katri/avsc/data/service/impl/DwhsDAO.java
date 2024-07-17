package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("dwhsDAO")
public class DwhsDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DwhsDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDwhsList(Map<String, String> paramMap) throws Exception {
		return list("dwhsDAO.selectDwhsList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDwhsListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("dwhsDAO.selectDwhsListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDwhsInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("dwhsDAO.selectDwhsInfo", paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDwhsIsExist(Map<String, String> paramMap) {
		return (Integer) select("dwhsDAO.selectDwhsIsExist", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertDwhs(Map<String, String> paramMap) {
		return insert("dwhsDAO.insertDwhs", paramMap);
	}

	/**
	 * 평가점수 등록
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateDwhs(Map<String, String> paramMap) {
		return update("dwhsDAO.updateDwhs", paramMap);
	}

	/**
	 * 성과 등록
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertDlResult(Map<String, String> paramMap) {
		return insert("dwhsDAO.insertDlResult", paramMap);
	}

}
