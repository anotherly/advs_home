package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("dtupDAO")
public class DtupDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DtupDAO.class);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDtupInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("dtupDAO.selectDtupInfo", paramMap);
	}

	/**
	 * 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectCarIsExist(Map<String, String> paramMap) {
		return (Integer) select("dtupDAO.selectCarIsExist", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertCar(Map<String, String> paramMap) {
		return insert("dtupDAO.insertCar", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateCar(Map<String, String> paramMap) {
		return update("dtupDAO.updateCar", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteCar(Map<String, String> paramMap) {
		return delete("dtupDAO.deleteCar", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertBoard(Map<String, String> paramMap) {
		return insert("dtupDAO.insertBoard", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateBoard(Map<String, String> paramMap) {
		return update("dtupDAO.updateBoard", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteBoard(Map<String, String> paramMap) {
		return delete("dtupDAO.deleteBoard", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertAppend(Map<String, String> paramMap) {
		return insert("dtupDAO.insertAppend", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteAppend(Map<String, String> paramMap) {
		return delete("dtupDAO.deleteAppend", paramMap);
	}

	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceBseq(Map<String, String> paramMap) {
		return (String) select("dtupDAO.sequenceBseq", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertCarIns(Map<String, String> paramMap) {
		return insert("dtupDAO.insertCarIns", paramMap);
	}
	
	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectCarInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("dtupDAO.selectCarInfo", paramMap);
	}
	
	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateCarInfo(Map<String, String> paramMap) {
		return update("dtupDAO.updateCarInfo", paramMap);
	}
	
	/**
	 * 등록여부를  조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectCountYn(Map<String, String> paramMap) {
		return (Integer) select("dtupDAO.selectCountYn", paramMap);
	}
}
