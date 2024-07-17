package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.data.service.DwhsService;

@Service("dwhsService")
public class DwhsServiceImpl extends EgovAbstractServiceImpl implements DwhsService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DwhsServiceImpl.class);

	/** DwhsDAO */
	// TODO ibatis 사용
	@Resource(name = "dwhsDAO")
	private DwhsDAO dwhsDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDwhsList(Map<String, String> paramMap) throws Exception {
		return dwhsDAO.selectDwhsList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDwhsListTotCnt(Map<String, String> paramMap) {
		return dwhsDAO.selectDwhsListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectDwhsInfo(Map<String, String> paramMap) {
		return dwhsDAO.selectDwhsInfo(paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDwhsIsExist(Map<String, String> paramMap) {
		return dwhsDAO.selectDwhsIsExist(paramMap);
	}

	/**
	 * 작성한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertDwhs(Map<String, String> paramMap) { 
		dwhsDAO.insertDwhs(paramMap);
	}

	/**
	 * 평가점수 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateDwhs(Map<String, String> paramMap) {
		return dwhsDAO.updateDwhs(paramMap);
	}

	/**
	 * 성과등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertDlResult(Map<String, String> paramMap) { 
		dwhsDAO.insertDlResult(paramMap);
	}

	
}
