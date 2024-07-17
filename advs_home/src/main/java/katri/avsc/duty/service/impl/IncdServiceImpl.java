package katri.avsc.duty.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.duty.service.IncdService;

@Service("incdService")
public class IncdServiceImpl extends EgovAbstractServiceImpl implements IncdService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(IncdServiceImpl.class);

	/** IncdDAO */
	// TODO ibatis 사용
	@Resource(name = "incdDAO")
	private IncdDAO incdDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectIncdList(Map<String, String> paramMap) throws Exception {
		return incdDAO.selectIncdList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectIncdListTotCnt(Map<String, String> paramMap) {
		return incdDAO.selectIncdListTotCnt(paramMap);
	}

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectIncdIsExist(Map<String, String> paramMap) {
		return incdDAO.selectIncdIsExist(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectIncdInfo(Map<String, String> paramMap) {
		return incdDAO.selectIncdInfo(paramMap);
	}

	/**
	 * 작성한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertIncd(Map<String, String> paramMap) { 
		incdDAO.insertIncd(paramMap);
	}

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateIncd(Map<String, String> paramMap) {
		return incdDAO.updateIncd(paramMap);
	}

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteIncd(Map<String, String> paramMap) {
		return incdDAO.deleteIncd(paramMap); 
	}

	/**
	 * 사고차량 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectAccCarList(Map<String, String> paramMap) {
		return incdDAO.selectAccCarList(paramMap);
	}

	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectAccVideoList(Map<String, String> paramMap) {
		return incdDAO.selectAccVideoList(paramMap);
	}

	/**
	 * 사고차량 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAccCar(Map<String, String> paramMap) { 
		incdDAO.insertAccCar(paramMap);
	}

	/**
	 * 사고차량 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteAccCar(Map<String, String> paramMap) {
		return incdDAO.deleteAccCar(paramMap); 
	}

	/**
	 * 사고영상 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAccVideo(Map<String, String> paramMap) { 
		incdDAO.insertAccVideo(paramMap);
	}

	/**
	 * 사고영상 삭제
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int deleteAccVideo(Map<String, String> paramMap) {
		return incdDAO.deleteAccVideo(paramMap); 
	}

	/**
	 * acc_id nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceAccId(Map<String, String> paramMap) {
		return incdDAO.sequenceAccId(paramMap);
	}

}
