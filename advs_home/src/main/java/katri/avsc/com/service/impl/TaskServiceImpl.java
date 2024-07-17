package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import katri.avsc.com.service.TaskService;

@Service("taskService")
public class TaskServiceImpl extends EgovAbstractServiceImpl implements TaskService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(TaskServiceImpl.class);

	/** TaskDAO */
	// TODO ibatis 사용
	@Resource(name = "taskDAO")
	private TaskDAO taskDAO;
	
	/**
	 * 운행보고스케쥴 조회한다.
	 * @taskm paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	@Override
	public Map<String, String> selectScheInfo(Map<String, String> paramMap) {
		return taskDAO.selectScheInfo(paramMap);
	}

	/**
	 * 운행보고 등록 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectDvrgRegList(Map<String, String> paramMap) throws Exception {
		return taskDAO.selectDvrgRegList(paramMap);
	}

}
