package katri.avsc.com.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("menuDAO")
public class MenuDAO extends EgovAbstractDAO {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MenuDAO.class);

	/**
	 * 메뉴정보 조회
	 * @param paramMap - 검색할 정보
	 * @return 서브코드정보
	 * @exception Exception
	 */
	public List<?> selectMenuList(Map<String, String> paramMap) {
		return list("menuDAO.selectMenuList", paramMap);
	}

	public List<?> selectMenuSubList(Map<String, String> paramMap) {
		return list("menuDAO.selectMenuSubList", paramMap);
	}
	
	public List<?> selectLeftMenuList(Map<String, String> paramMap) {
		return list("menuDAO.selectLeftMenuList", paramMap);
	}

	public List<?> selectLeftMenuSubList(Map<String, String> paramMap) {
		return list("menuDAO.selectLeftMenuSubList", paramMap);
	}	
}
