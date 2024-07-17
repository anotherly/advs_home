package katri.avsc.data.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.data.service.RqhsService;

@Service("rqhsService")
public class RqhsServiceImpl extends EgovAbstractServiceImpl implements RqhsService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RqhsServiceImpl.class);

	/** RqhsDAO */
	// TODO ibatis 사용
	@Resource(name = "rqhsDAO")
	private RqhsDAO rqhsDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectRqhsList(Map<String, String> paramMap) {
		return rqhsDAO.selectRqhsList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectRqhsListTotCnt(Map<String, String> paramMap) {
		return rqhsDAO.selectRqhsListTotCnt(paramMap);
	}

	
	/**
	 * 기관명을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	
	@Override
	public Map<String, String> selectMemberList(Map<String, String> paramMap) {
		return rqhsDAO.selectMemberList(paramMap);
	}
	
	/**
	 * 임시운행번호을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectRaceNumberList(Map<String, String> paramMap) {
		return rqhsDAO.selectRaceNumberList(paramMap);
	}
	
	/**
	* 등록한다.
	* @param paramMap - 조회할 정보가 담긴 VO
	* @return
	* @exception
	*/
	@Override
	public void insertAuth(Map<String, String> paramMap) { 
		rqhsDAO.insertAuth(paramMap);
	}
	
	/**
	 * 요청 여부 체크한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectApporYn(Map<String, String> paramMap) {
		return rqhsDAO.selectApporYn(paramMap);
	}
	
	

}
