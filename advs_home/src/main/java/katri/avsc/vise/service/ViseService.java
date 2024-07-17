package katri.avsc.vise.service;

import java.util.List;
import java.util.Map;

public interface ViseService{
	
	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectRightsIsExist(Map<String, String> paramMap);

	/**
	 * 권한 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertRights(Map<String, String> paramMap);

	/**
	 * 유저정보
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectRightsInfo(Map<String, String> paramMap);


	/**
	 * 임시 목록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectReqConfirmList(Map<String, String> paramMap) throws Exception;

	/**
	 * 번호 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateReqConfirm_T(Map<String, String> paramMap);

	/**
	 * 유저 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateReqConfirm_U(Map<String, String> paramMap);

	/**
	 * 문의 및 연락처
	 * @param paramMap - 문의 및 연락처
	 * @return
	 * @exception
	 */
	Map<String, Object> selectContectInfo() throws Exception;
}
