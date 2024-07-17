package katri.avsc.agcy.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.agcy.service.ConsService;

@Service("consService")
public class ConsServiceImpl extends EgovAbstractServiceImpl implements ConsService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ConsServiceImpl.class);

	/** ConsDAO */
	// TODO ibatis 사용
	@Resource(name = "consDAO")
	private ConsDAO consDAO;

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectConsList(Map<String, String> paramMap) throws Exception {
		return consDAO.selectConsList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectConsListTotCnt(Map<String, String> paramMap) {
		return consDAO.selectConsListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectConsInfo(Map<String, String> paramMap) {
		return consDAO.selectConsInfo(paramMap);
	}

	/**
	 * 오프라인 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectOffList(Map<String, String> paramMap) throws Exception {
		return consDAO.selectOffList(paramMap);
	}
	
	/**
	 * 오프라인 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectOffListTotCnt(Map<String, String> paramMap) {
		return consDAO.selectOffListTotCnt(paramMap);
	}
	
	/**
	 * 오프라인 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectOffInfo(Map<String, String> paramMap) {
		return consDAO.selectOffInfo(paramMap);
	}
	
	/**
	 * 오프라인 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceOffseq(Map<String, String> paramMap) {
		return consDAO.sequenceOffseq(paramMap);
	}	
	
	/**
	 * 오프라인 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertOffLine(Map<String, String> paramMap) { 
		consDAO.insertOffLine(paramMap);
	}	
	/**
	 * 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDataSetList(Map<String, String> paramMap) throws Exception {
		return consDAO.selectDataSetList(paramMap);
	}

	/**
	 * 데이터셋 총 갯수
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDataSetListTotCnt(Map<String, String> paramMap) {
		return consDAO.selectDataSetListTotCnt(paramMap);
	}

	/**
	 * 데이터업로드 데이터셋 목록 조회
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDtupDataSetList(Map<String, String> paramMap) throws Exception {
		return consDAO.selectDtupDataSetList(paramMap);
	}

	/**
	 * 데이터셋 상세내용
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectDataSetInfo(Map<String, String> paramMap) {
		return consDAO.selectDataSetInfo(paramMap);
	}

	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertDataSet(Map<String, String> paramMap) { 
		consDAO.insertDataSet(paramMap);
	}

	/**
	 * 데이터셋 수정
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateDataSet(Map<String, String> paramMap) {
		return consDAO.updateDataSet(paramMap);
	}

	/**
	 * 데이터셋 삭제시 게시판 참조삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateBoardDelt(Map<String, String> paramMap) {
		return consDAO.updateBoardDelt(paramMap);
	}

	/**
	 * 데이터셋 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteDataSet(Map<String, String> paramMap) {
		return consDAO.deleteDataSet(paramMap); 
	}

	/**
	 * id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceBdwrSeq(Map<String, String> paramMap) {
		return consDAO.sequenceBdwrSeq(paramMap);
	}


}
