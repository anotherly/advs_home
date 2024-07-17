package katri.avsc.sharing.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.sharing.service.CarReserveService;

@Service("carReserveService")
public class CarReserveServiceImpl extends EgovAbstractServiceImpl implements CarReserveService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CarReserveServiceImpl.class);

	/** CarReserveDAO */
	// TODO ibatis 사용
	@Resource(name = "carReserveDAO")
	private CarReserveDAO carReserveDAO;
	
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectCarReserveList(Map<String, String> paramMap) throws Exception {
		return carReserveDAO.selectCarReserveList(paramMap);
	}

	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectCarReserveListTotCnt(Map<String, String> paramMap) {
		return carReserveDAO.selectCarReserveListTotCnt(paramMap);
	}

	/**
	 * 상세정보를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectCarReserveInfo(Map<String, String> paramMap) {
		return carReserveDAO.selectCarReserveInfo(paramMap);
	}
	@Override
	public List<?> selectCarReserveInfoList(Map<String, String> paramMap) {
		return carReserveDAO.selectCarReserveInfoList(paramMap);
	}

	/**
	 * 차량예약 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	@Override
	public void insertCarReserve(Map<String, String> paramMap) { 
		carReserveDAO.insertCarReserve(paramMap);
	}

	/**
	 * 차량예약 nextval을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return nextval
	 * @exception
	 */
	@Override
	public String sequenceReserveNum(Map<String, String> paramMap) {
		return carReserveDAO.sequenceReserveNum(paramMap);
	}
	
	/**
	 * 예약취소 처리
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return update 갯수
	 * @exception
	 */
	@Override
	public int updateCarReserveCancel(Map<String, String> paramMap) {
		return carReserveDAO.updateCarReserveCancel(paramMap);
	}

	
	/**
	 * 파일 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertAttachFile(Map<String, String> paramMap) { 
		carReserveDAO.insertAttachFile(paramMap);
	}
	
	/**
	 * 사고영상 목록 정보
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectAttachFileList(Map<String, String> paramMap) {
		return carReserveDAO.selectAttachFileList(paramMap);
	}

	@Override
	public List<?> selectReserveList(Map<String, String> paramMap) {
		return carReserveDAO.selectReserveList(paramMap);
	}
}
