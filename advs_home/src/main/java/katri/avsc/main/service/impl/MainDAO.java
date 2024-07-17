package katri.avsc.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("mainDAO")
public class MainDAO extends EgovAbstractDAO {

	/**
	 * 임시등록번호 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectTempOperTotCnt(Map<String, String> paramMap) {
		return (Integer) select("mainDAO.selectTempOperTotCnt", paramMap);
	}

	/**
	 * 주행거리를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDrivingInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("mainDAO.selectDrivingInfo", paramMap);
	}

	/**
	 * 데이터 건수 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDataTotCnt(Map<String, String> paramMap) {
		return (Integer) select("mainDAO.selectDataTotCnt", paramMap);
	}

	/**
	 * 데이터 용량 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public String selectDataTotVolume(Map<String, String> paramMap) {
		return (String) select("mainDAO.selectDataTotVolume", paramMap);
	}

	/**
	 * 공지사항 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectNoticeList(Map<String, String> paramMap) {
		return list("mainDAO.selectNoticeList", paramMap);
	}

	/**
	 * 최신활용 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectPopulList(Map<String, String> paramMap) {
		return list("mainDAO.selectPopulList", paramMap);
	}

	/**
	 * 최신자료 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectRecentList(Map<String, String> paramMap) {
		return list("mainDAO.selectRecentList", paramMap);
	}

	/**
	 * 접속로그 등록
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertConnnectLog(Map<String, String> paramMap) {
		return insert("mainDAO.insertConnnectLog", paramMap);
	}

	public Map<String, String> selectAttachFileList() {
		return (Map<String, String>) select("mainDAO.selectAttachFileList");
	}


}
