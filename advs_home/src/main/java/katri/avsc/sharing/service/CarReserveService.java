package katri.avsc.sharing.service;

import java.util.List;
import java.util.Map;

public interface CarReserveService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectCarReserveList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectCarReserveListTotCnt(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectCarReserveInfo(Map<String, String> paramMap);
	List<?> selectCarReserveInfoList(Map<String, String> paramMap);

	/**
	 * 차량예약 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertCarReserve(Map<String, String> paramMap);
	
	/**
	 * 차량예약 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	String sequenceReserveNum(Map<String, String> paramMap);
	
	/**
	 * 조회수 증가
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateCarReserveCancel(Map<String, String> paramMap);

	
	/**
	 * 파일 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAttachFile(Map<String, String> paramMap);
	
	/**
	 * 파일 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectAttachFileList(Map<String, String> paramMap);

	List<?> selectReserveList(Map<String, String> paramMap);
}
