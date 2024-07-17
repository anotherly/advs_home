package katri.avsc.main.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.main.service.MainService;

@Service("mainService")
public class MainServiceImpl extends EgovAbstractServiceImpl implements MainService {
	
	/** MainDAO */
	// TODO ibatis 사용
	@Resource(name = "mainDAO")
	private MainDAO mainDAO;
	
	/**
	 * 임시등록번호 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectTempOperTotCnt(Map<String, String> paramMap) {
		return mainDAO.selectTempOperTotCnt(paramMap);
	}

	/**
	 * 주행거리를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	@Override
	public Map<String, String> selectDrivingInfo(Map<String, String> paramMap) {
		return mainDAO.selectDrivingInfo(paramMap);
	}

	/**
	 * 데이터 건수 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public int selectDataTotCnt(Map<String, String> paramMap) {
		return mainDAO.selectDataTotCnt(paramMap);
	}

	/**
	 * 데이터 용량 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public String selectDataTotVolume(Map<String, String> paramMap) {
		return mainDAO.selectDataTotVolume(paramMap);
	}

	/**
	 * 공지사항목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectNoticeList(Map<String, String> paramMap) {
		return mainDAO.selectNoticeList(paramMap);
	}

	/**
	 * 최신활용 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectPopulList(Map<String, String> paramMap) {
		return mainDAO.selectPopulList(paramMap);
	}

	/**
	 * 최신자료 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectRecentList(Map<String, String> paramMap) {
		return mainDAO.selectRecentList(paramMap);
	}

	/**
	 * 접속로그 등록
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return
	 * @exception
	 */
	@Override
	public void insertConnnectLog(Map<String, String> paramMap) { 
		mainDAO.insertConnnectLog(paramMap);
	}

	@Override
	public Map<String, String> selectAttachFileList() {
		return mainDAO.selectAttachFileList();
	}

}
