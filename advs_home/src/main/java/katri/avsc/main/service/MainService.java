package katri.avsc.main.service;

import java.util.List;
import java.util.Map;

public interface MainService {

	/**
	 * 임시등록번호 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectTempOperTotCnt(Map<String, String> paramMap);

	/**
	 * 주행거리를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectDrivingInfo(Map<String, String> paramMap);

	/**
	 * 데이터 건수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectDataTotCnt(Map<String, String> paramMap);

	/**
	 * 데이터 용량을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	String selectDataTotVolume(Map<String, String> paramMap);

	/**
	 * 공지사항목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectNoticeList(Map<String, String> paramMap);

	/**
	 * 최신활용 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectPopulList(Map<String, String> paramMap);

	/**
	 * 최신자료 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectRecentList(Map<String, String> paramMap);

	/**
	 * 접속 로그 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertConnnectLog(Map<String, String> paramMap);

	Map<String, String> selectAttachFileList();

}
