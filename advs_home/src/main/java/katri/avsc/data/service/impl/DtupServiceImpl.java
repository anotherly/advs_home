package katri.avsc.data.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.data.service.DtupService;

@Service("dtupService")
public class DtupServiceImpl extends EgovAbstractServiceImpl implements DtupService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(DtupServiceImpl.class);

	/** DtupDAO */
	// TODO ibatis 사용
	@Resource(name = "dtupDAO")
	private DtupDAO dtupDAO;

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectDtupInfo(Map<String, String> paramMap) {
		return dtupDAO.selectDtupInfo(paramMap);
	}

	/**
	 * 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectCarIsExist(Map<String, String> paramMap) {
		return dtupDAO.selectCarIsExist(paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertCar(Map<String, String> paramMap) { 
		dtupDAO.insertCar(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateCar(Map<String, String> paramMap) {
		return dtupDAO.updateCar(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteCar(Map<String, String> paramMap) {
		return dtupDAO.deleteCar(paramMap); 
	}

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertBoard(Map<String, String> paramMap) { 
		dtupDAO.insertBoard(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateBoard(Map<String, String> paramMap) {
		return dtupDAO.updateBoard(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteBoard(Map<String, String> paramMap) {
		return dtupDAO.deleteBoard(paramMap); 
	}

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAppend(Map<String, String> paramMap) { 
		dtupDAO.insertAppend(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteAppend(Map<String, String> paramMap) {
		return dtupDAO.deleteAppend(paramMap); 
	}

	/**
	 * Change_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceBseq(Map<String, String> paramMap) {
		return dtupDAO.sequenceBseq(paramMap);
	}

	/**
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertCarIns(Map<String, String> paramMap) {
		dtupDAO.insertCarIns(paramMap);
	}
	
	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectCarInfo(Map<String, String> paramMap) {
		return dtupDAO.selectCarInfo(paramMap);
	}
	
	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateCarInfo(Map<String, String> paramMap) {
		return dtupDAO.updateCarInfo(paramMap);
	}
	
	/**
	 * 등록여부를 확인
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectCountYn(Map<String, String> paramMap) {
		return dtupDAO.selectCountYn(paramMap);
	}

}
