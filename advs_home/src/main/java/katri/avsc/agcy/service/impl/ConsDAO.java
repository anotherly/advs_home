package katri.avsc.agcy.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("consDAO")
public class ConsDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ConsDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectConsList(Map<String, String> paramMap) throws Exception {
		return list("consDAO.selectConsList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectConsListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("consDAO.selectConsListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectConsInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("consDAO.selectConsInfo", paramMap);
	}

	/**
	 * 오프라인 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectOffList(Map<String, String> paramMap) throws Exception {
		return list("consDAO.selectOffList", paramMap);
	}
	
	/**
	 * 오프라인 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectOffListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("consDAO.selectOffListTotCnt", paramMap);
	}
	
	/**
	 * 오프라인 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectOffInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("consDAO.selectOffInfo", paramMap);
	}
	
	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceOffseq(Map<String, String> paramMap) {
		return (String) select("consDAO.sequenceOffseq", paramMap);
	}
	
	/**
	 * 오프라인 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertOffLine(Map<String, String> paramMap) { 
		return insert("consDAO.insertOffLine", paramMap);
	}
	
	/**
	 * 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDataSetList(Map<String, String> paramMap) throws Exception {
		return list("consDAO.selectDataSetList", paramMap);
	}

	/**
	 * 데이터셋 총 갯수
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectDataSetListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("consDAO.selectDataSetListTotCnt", paramMap);
	}

	/**
	 * 데이터업로드 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectDtupDataSetList(Map<String, String> paramMap) throws Exception {
		return list("consDAO.selectDtupDataSetList", paramMap);
	}

	/**
	 * 데이터셋 상세내용
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectDataSetInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("consDAO.selectDataSetInfo", paramMap);
	}

	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertDataSet(Map<String, String> paramMap) { 
		return insert("consDAO.insertDataSet", paramMap);
	}

	/**
	 * 데이터셋 수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateDataSet(Map<String, String> paramMap) {
		return update("consDAO.updateDataSet", paramMap);
	}

	/**
	 * 데이터셋 삭제시 게시판 참조삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateBoardDelt(Map<String, String> paramMap) {
		return update("consDAO.updateBoardDelt", paramMap);
	}

	/**
	 * 데이터셋 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deleteDataSet(Map<String, String> paramMap) {
		return delete("consDAO.deleteDataSet", paramMap);
	}

	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceBdwrSeq(Map<String, String> paramMap) {
		return (String) select("consDAO.sequenceBdwrSeq", paramMap);
	}
	
}
