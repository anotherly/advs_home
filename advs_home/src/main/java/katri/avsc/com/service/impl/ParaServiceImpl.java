package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.com.service.ParaService;

@Service("paraService")
public class ParaServiceImpl extends EgovAbstractServiceImpl implements ParaService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(ParaServiceImpl.class);

	/** ParaDAO */
	// TODO ibatis 사용
	@Resource(name = "paraDAO")
	private ParaDAO paraDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectParaList(Map<String, String> paramMap) throws Exception {
		return paraDAO.selectParaList(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectParaInfo(Map<String, String> paramMap) {
		return paraDAO.selectParaInfo(paramMap);
	}

	/**
	 * 작성한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertPara(Map<String, String> paramMap) { 
		paraDAO.insertPara(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updatePara(Map<String, String> paramMap) {
		return paraDAO.updatePara(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return delete 갯수
	 * @exception
	 */
	@Override
	public int deletePara(Map<String, String> paramMap) {
		return paraDAO.deletePara(paramMap); 
	}

}
