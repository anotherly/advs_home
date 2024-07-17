package katri.avsc.agcy.service;

import java.util.List;
import java.util.Map;

public interface ConsService{

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectConsList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectConsListTotCnt(Map<String, String> paramMap);
	
	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectConsInfo(Map<String, String> paramMap);
		
	/**
	 * 오프라인 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectOffList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 오프라인 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectOffListTotCnt(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectOffInfo(Map<String, String> paramMap);

	/**
	 * 오프라인 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	String sequenceOffseq(Map<String, String> paramMap);
	
	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertOffLine(Map<String, String> paramMap);
	
	/**
	 * 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDataSetList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 데이터셋 총 갯수
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectDataSetListTotCnt(Map<String, String> paramMap);

	/**
	 * 데이터업로드 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDtupDataSetList(Map<String, String> paramMap) throws Exception;

	/**
	 * 데이터셋 상세내용
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectDataSetInfo(Map<String, String> paramMap);

	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertDataSet(Map<String, String> paramMap);

	/**
	 * 데이터셋 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateDataSet(Map<String, String> paramMap);

	/**
	 * 데이터셋 삭제시 게시판 참조삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateBoardDelt(Map<String, String> paramMap);

	/**
	 * 데이터셋 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteDataSet(Map<String, String> paramMap);

	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	String sequenceBdwrSeq(Map<String, String> paramMap);


}
