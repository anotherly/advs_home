package katri.avsc.vise.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("viseDAO")
public class ViseDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ViseDAO.class);

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	public int selectRightsIsExist(Map<String, String> paramMap) {
		return (Integer) select("viseDAO.selectRightsIsExist", paramMap);
	}

	/**
	 * 임시운행정보 등록 요청
	 * @param paramMap - 등록할 정보가 담긴 Map
	 * @return 
	 * @exception
	 */
	public Object insertRights(Map<String, String> paramMap) {
		return insert("viseDAO.insertRights", paramMap);
	}

	/**
	 * 유저정보
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	public Map<String, String> selectRightsInfo(Map<String, String> paramMap) {
		return (Map<String, String>) select("viseDAO.selectRightsInfo", paramMap);
	}

	/**
	 * 임시목록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	public List<?> selectReqConfirmList(Map<String, String> paramMap) throws Exception {
		return list("viseDAO.selectReqConfirmList", paramMap);
	}

	/**
	 * 번호수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateReqConfirm_T(Map<String, String> paramMap) {
		return update("viseDAO.updateReqConfirm_T", paramMap);
	}

	/**
	 * 유저수정
	 * @param paramMap - 수정할 정보가 담긴 Map
	 * @return update개수
	 * @exception
	 */
	public int updateReqConfirm_U(Map<String, String> paramMap) {
		return update("viseDAO.updateReqConfirm_U", paramMap);
	}

	/**
	 * 문의 및 연락처 정보 조회
	 * @param paramMap - 조회
	 * @return
	 * @exception
	 */
	public Map<String, Object> selectContectInfo() throws Exception {
		return (Map<String, Object>) select("viseDAO.selectContectInfo");
	}

}
