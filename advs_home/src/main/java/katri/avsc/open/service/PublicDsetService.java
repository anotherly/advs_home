package katri.avsc.open.service;

import java.util.List;
import java.util.Map;

public interface PublicDsetService{

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectPublicDsetList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectPublicDsetListTotCnt(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectPublicDsetInfo(Map<String, String> paramMap);

	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertPublicDset(Map<String, String> paramMap);

	/**
	 * 데이터셋 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updatePublicDset(Map<String, String> paramMap);

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
	int deletePublicDset(Map<String, String> paramMap);

	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	String sequenceBseq(Map<String, String> paramMap);

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAppend(Map<String, String> paramMap);

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteAppend(Map<String, String> paramMap);
	
	/**
	 * 파일 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertMxFile(Map<String, String> paramMap);
	
	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectMxFileList(Map<String, String> paramMap);

}
