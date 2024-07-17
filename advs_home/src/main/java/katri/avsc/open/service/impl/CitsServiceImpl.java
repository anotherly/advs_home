package katri.avsc.open.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.open.service.CitsService;

@Service("citsService")
public class CitsServiceImpl extends EgovAbstractServiceImpl implements CitsService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CitsServiceImpl.class);

	/** CitsDAO */
	// TODO ibatis 사용
	@Resource(name = "citsDAO")
	private CitsDAO citsDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectCitsList(Map<String, String> paramMap) throws Exception {
		return citsDAO.selectCitsList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectCitsListTotCnt(Map<String, String> paramMap) {
		return citsDAO.selectCitsListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectCitsInfo(Map<String, String> paramMap) {
		return citsDAO.selectCitsInfo(paramMap);
	}

}
