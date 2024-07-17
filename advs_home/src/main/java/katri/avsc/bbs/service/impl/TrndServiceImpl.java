package katri.avsc.bbs.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.bbs.service.TrndService;

@Service("trndService")
public class TrndServiceImpl extends EgovAbstractServiceImpl implements TrndService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TrndServiceImpl.class);

	/** TrndDAO */
	// TODO ibatis 사용
	@Resource(name = "trndDAO")
	private TrndDAO trndDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectTrndList(Map<String, String> paramMap) throws Exception {
		return trndDAO.selectTrndList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectTrndListTotCnt(Map<String, String> paramMap) {
		return trndDAO.selectTrndListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectTrndInfo(Map<String, String> paramMap) {
		return trndDAO.selectTrndInfo(paramMap);
	}

	/**
	 * 조회수 증가
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateIqurNctn(Map<String, String> paramMap) {
		return trndDAO.updateIqurNctn(paramMap);
	}

}
