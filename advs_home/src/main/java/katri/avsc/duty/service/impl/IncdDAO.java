package katri.avsc.duty.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("incdDAO")
public class IncdDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(IncdDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectIncdList(Map<String, String> paramMap) throws Exception {
		return list("incdDAO.selectIncdList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectIncdListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("incdDAO.selectIncdListTotCnt", paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectIncdIsExist(Map<String, String> paramMap) {
		return (Integer) select("incdDAO.selectIncdIsExist", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectIncdInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("incdDAO.selectIncdInfo", paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertIncd(Map<String, String> paramMap) {
		return insert("incdDAO.insertIncd", paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateIncd(Map<String, String> paramMap) {
		return update("incdDAO.updateIncd", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteIncd(Map<String, String> paramMap) {
		return delete("incdDAO.deleteIncd", paramMap);
	}

	/**
	 * 사고차량 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectAccCarList(Map<String, String> paramMap) {
		return list("incdDAO.selectAccCarList", paramMap);
	}

	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectAccVideoList(Map<String, String> paramMap) {
		return list("incdDAO.selectAccVideoList", paramMap);
	}

	/**
	 * 사고차량 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertAccCar(Map<String, String> paramMap) { 
		return insert("incdDAO.insertAccCar", paramMap);
	}

	/**
	 * 사고차량 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteAccCar(Map<String, String> paramMap) {
		return delete("incdDAO.deleteAccCar", paramMap);
	}

	/**
	 * 사고영상 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertAccVideo(Map<String, String> paramMap) { 
		return insert("incdDAO.insertAccVideo", paramMap);
	}

	/**
	 * 사고영상 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteAccVideo(Map<String, String> paramMap) {
		return delete("incdDAO.deleteAccVideo", paramMap);
	}

	/**
	 * acc_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceAccId(Map<String, String> paramMap) {
		return (String) select("incdDAO.sequenceAccId", paramMap);
	}
}
