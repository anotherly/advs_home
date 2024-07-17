package katri.avsc.open.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("publicDsetDAO")
public class PublicDsetDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PublicDsetDAO.class);

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectPublicDsetList(Map<String, String> paramMap) throws Exception {
		return list("publicDsetDAO.selectPublicDsetList", paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectPublicDsetListTotCnt(Map<String, String> paramMap) {
		return (Integer) select("publicDsetDAO.selectPublicDsetListTotCnt", paramMap);
	}

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectPublicDsetInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("publicDsetDAO.selectPublicDsetInfo", paramMap);
	}


	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertPublicDset(Map<String, String> paramMap) { 
		return insert("publicDsetDAO.insertPublicDset", paramMap);
	}

	/**
	 * 데이터셋 수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updatePublicDset(Map<String, String> paramMap) {
		return update("publicDsetDAO.updatePublicDset", paramMap);
	}

	/**
	 * 데이터셋 삭제시 게시판 참조삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateBoardDelt(Map<String, String> paramMap) {
		return update("publicDsetDAO.updateBoardDelt", paramMap);
	}

	/**
	 * 데이터셋 삭제
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return delete개수
	 * @exception
	 */
	public int deletePublicDset(Map<String, String> paramMap) {
		return delete("publicDsetDAO.deletePublicDset", paramMap);
	}

	/**
	 * 게시글 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	public String sequenceBseq(Map<String, String> paramMap) {
		return (String) select("publicDsetDAO.sequenceBseq", paramMap);
	}
	
	/**
	 * 등록한다.
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertAppend(Map<String, String> paramMap) {
		return insert("publicDsetDAO.insertAppend", paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int deleteAppend(Map<String, String> paramMap) {
		return delete("publicDsetDAO.deleteAppend", paramMap);
	}
	
	/**
	 * 사고영상 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	public Object insertMxFile(Map<String, String> paramMap) { 
		return insert("publicDsetDAO.insertMxFile", paramMap);
	}
	
	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectMxFileList(Map<String, String> paramMap) {
		return list("publicDsetDAO.selectMxFileList", paramMap);
	}
}
