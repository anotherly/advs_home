package katri.avsc.sharing.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("carReserveDAO")
public class CarReserveDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CarReserveDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectCarReserveList(Map<String, String> paramMap) throws Exception {
		return list("carReserveDAO.selectCarReserveList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectCarReserveListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("carReserveDAO.selectCarReserveListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectCarReserveInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("carReserveDAO.selectCarReserveInfo", paramMap);
	}
	public List<?> selectCarReserveInfoList(Map<String, String> paramMap) {
		return list("carReserveDAO.selectCarReserveInfoList", paramMap);
	}

	/**
	 * 차량예약 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertCarReserve(Map<String, String> paramMap) { 
		return insert("carReserveDAO.insertCarReserve", paramMap);
	}
	
	/**
	 * 차량예약번호 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceReserveNum(Map<String, String> paramMap) {
		return (String) select("carReserveDAO.sequenceReserveNum", paramMap);
	}

	/**
	 * 예약취소처리
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateCarReserveCancel(Map<String, String> paramMap) {
		return update("carReserveDAO.updateCarReserveCancel", paramMap);
	}
	
	/**
	 * 사고영상 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertAttachFile(Map<String, String> paramMap) { 
		return insert("carReserveDAO.insertAttachFile", paramMap);
	}
	
	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectAttachFileList(Map<String, String> paramMap) {
		return list("carReserveDAO.selectAttachFileList", paramMap);
	}

	/**
	 * 캘린더에 보여줄 예약 목록을 조회한다.
	 * @param paramMap - 
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectReserveList(Map<String, String> paramMap) {
		return list("carReserveDAO.selectReserveList", paramMap);
	}

}
