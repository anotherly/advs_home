package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.data.service.UphsService;

@Service("uphsService")
public class UphsServiceImpl extends EgovAbstractServiceImpl implements UphsService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UphsServiceImpl.class);

	/** UphsDAO */
	// TODO ibatis 사용
	@Resource(name = "uphsDAO")
	private UphsDAO uphsDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectUphsList(Map<String, String> paramMap) throws Exception {
		return uphsDAO.selectUphsList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectUphsListTotCnt(Map<String, String> paramMap) {
		return uphsDAO.selectUphsListTotCnt(paramMap);
	}

	/**
	 * 관리자 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDtmgList(Map<String, String> paramMap) throws Exception {
		return uphsDAO.selectDtmgList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDtmgListTotCnt(Map<String, String> paramMap) {
		return uphsDAO.selectDtmgListTotCnt(paramMap);
	}
	
}
