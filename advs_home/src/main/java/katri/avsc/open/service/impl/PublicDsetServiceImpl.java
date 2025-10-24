package katri.avsc.open.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.open.service.PublicDsetService;


@Service("publicDsetService")
public class PublicDsetServiceImpl extends EgovAbstractServiceImpl implements PublicDsetService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PublicDsetServiceImpl.class);

	/** PublicDsetDAO */
	// TODO ibatis 사용
	@Resource(name = "publicDsetDAO")
	private PublicDsetDAO publicDsetDAO;

	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectPublicDsetList(Map<String, String> paramMap) throws Exception {
		return publicDsetDAO.selectPublicDsetList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectPublicDsetListTotCnt(Map<String, String> paramMap) {
		return publicDsetDAO.selectPublicDsetListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectPublicDsetInfo(Map<String, String> paramMap) {
		return publicDsetDAO.selectPublicDsetInfo(paramMap);
	}



	/**
	 * 데이터셋 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertPublicDset(Map<String, String> paramMap) { 
		publicDsetDAO.insertPublicDset(paramMap);
	}

	/**
	 * 데이터셋 수정
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updatePublicDset(Map<String, String> paramMap) {
		return publicDsetDAO.updatePublicDset(paramMap);
	}

	/**
	 * 데이터셋 삭제시 게시판 참조삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateBoardDelt(Map<String, String> paramMap) {
		return publicDsetDAO.updateBoardDelt(paramMap);
	}

	/**
	 * 데이터셋 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deletePublicDset(Map<String, String> paramMap) {
		return publicDsetDAO.deletePublicDset(paramMap); 
	}

	/**
	 * id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceBseq(Map<String, String> paramMap) {
		return publicDsetDAO.sequenceBseq(paramMap);
	}
	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAppend(Map<String, String> paramMap) { 
		publicDsetDAO.insertAppend(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteAppend(Map<String, String> paramMap) {
		return publicDsetDAO.deleteAppend(paramMap); 
	}
	
	/**
	 * 파일 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertMxFile(Map<String, String> paramMap) { 
		publicDsetDAO.insertMxFile(paramMap);
	}
	
	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectMxFileList(Map<String, String> paramMap) {
		return publicDsetDAO.selectMxFileList(paramMap);
	}


}
