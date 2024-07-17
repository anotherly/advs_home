package katri.avsc.vise.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.vise.service.ViseService;

@Service("viseService")
public class ViseServiceImpl extends EgovAbstractServiceImpl implements ViseService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ViseServiceImpl.class);

	/** ViseDAO */
	// TODO ibatis 사용
	@Resource(name = "viseDAO")
	private ViseDAO viseDAO;

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectRightsIsExist(Map<String, String> paramMap) {
		return viseDAO.selectRightsIsExist(paramMap);
	}

	/**
	 * 권한신청 등록 요청
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertRights(Map<String, String> paramMap) { 
		viseDAO.insertRights(paramMap);
	}

	/**
	 * 유저정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectRightsInfo(Map<String, String> paramMap) {
		return viseDAO.selectRightsInfo(paramMap);
	}


	/**
	 * 임시 목록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectReqConfirmList(Map<String, String> paramMap) throws Exception {
		return viseDAO.selectReqConfirmList(paramMap);
	}

	/**
	 * 번호수정.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateReqConfirm_T(Map<String, String> paramMap) {
		return viseDAO.updateReqConfirm_T(paramMap);
	}


	/**
	 * 유저수정.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateReqConfirm_U(Map<String, String> paramMap) {
		return viseDAO.updateReqConfirm_U(paramMap);
	}
	
	/**
	 * 문의 및 연락처 정보 조회
	 * @param paramMap - 조회
	 * @return
	 * @exception
	 */
	@Override
	public Map<String, Object> selectContectInfo() throws Exception {
		return viseDAO.selectContectInfo();
	}
}
