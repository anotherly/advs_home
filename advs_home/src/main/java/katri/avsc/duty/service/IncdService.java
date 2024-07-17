package katri.avsc.duty.service;

import java.util.List;
import java.util.Map;

public interface IncdService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectIncdList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectIncdListTotCnt(Map<String, String> paramMap);

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectIncdIsExist(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectIncdInfo(Map<String, String> paramMap);
	
	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertIncd(Map<String, String> paramMap);

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateIncd(Map<String, String> paramMap);

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteIncd(Map<String, String> paramMap);

	/**
	 * 사고차량 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectAccCarList(Map<String, String> paramMap);

	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectAccVideoList(Map<String, String> paramMap);

	/**
	 * 사고차량 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAccCar(Map<String, String> paramMap);

	/**
	 * 사고차량 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteAccCar(Map<String, String> paramMap);

	/**
	 * 사고영상 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAccVideo(Map<String, String> paramMap);

	/**
	 * 사고영상 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteAccVideo(Map<String, String> paramMap);

	/**
	 * acc_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	String sequenceAccId(Map<String, String> paramMap);

}
