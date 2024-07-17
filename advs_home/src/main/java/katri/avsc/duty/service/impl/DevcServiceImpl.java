package katri.avsc.duty.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.duty.service.DevcService;

@Service("devcService")
public class DevcServiceImpl extends EgovAbstractServiceImpl implements DevcService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DevcServiceImpl.class);

	/** DevcDAO */
	// TODO ibatis 사용
	@Resource(name = "devcDAO")
	private DevcDAO devcDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDevcList(Map<String, String> paramMap) throws Exception {
		return devcDAO.selectDevcList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDevcListTotCnt(Map<String, String> paramMap) {
		return devcDAO.selectDevcListTotCnt(paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDevcIsExist(Map<String, String> paramMap) {
		return devcDAO.selectDevcIsExist(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectDevcInfo(Map<String, String> paramMap) {
		return devcDAO.selectDevcInfo(paramMap);
	}

	/**
	 * 작성한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertDevc(Map<String, String> paramMap) { 
		devcDAO.insertDevc(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateDevc(Map<String, String> paramMap) {
		return devcDAO.updateDevc(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deleteDevc(Map<String, String> paramMap) {
		return devcDAO.deleteDevc(paramMap); 
	}

	/**
	 * Change_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceChangeId(Map<String, String> paramMap) {
		return devcDAO.sequenceChangeId(paramMap);
	}

}
