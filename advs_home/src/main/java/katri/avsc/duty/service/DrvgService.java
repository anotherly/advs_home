package katri.avsc.duty.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface DrvgService{
	/**
	 * 목록을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 목록
	 * @exception Exception
	 */
	List<?> selectDrvgList(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 총 갯수를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 총 갯수
	 * @exception
	 */
	int selectDrvgListTotCnt(Map<String, String> paramMap);

	/**
	 * 기존데이터 존재여부를 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectDrvgIsExist(Map<String, String> paramMap);

	/**
	 * 상세 내용을 조회한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 상세내용
	 * @exception
	 */
	Map<String, String> selectDrvgInfo(Map<String, String> paramMap);
	
	/**
	 * @return 
	 * 등록한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertDrvg(Map<String, String> paramMap);

	/**
	 * 수정한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateDrvg(Map<String, String> paramMap);

	/**
	 * 삭제한다.
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteDrvg(Map<String, String> paramMap);

	/**
	 * 자율주행 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectAutoDrivingList(Map<String, String> paramMap);

	/**
	 * 제어권전환 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectCtrChangeList(Map<String, String> paramMap);

	/**
	 * 제어권전환 상세 목록 정보
	 * @param paramMap - 검색할 정보
	 * @return 
	 * @exception Exception
	 */
	List<?> selectCtrChangeDtlList(Map<String, String> paramMap);

	/**
	 * 자율주행 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertAutoDriving(Map<String, String> paramMap);

	/**
	 * 자율주행 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateAutoDriving(Map<String, String> paramMap);

	/**
	 * 자율주행 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteAutoDriving(Map<String, String> paramMap);

	/**
	 * 제어권전환 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertCtrChange(Map<String, String> paramMap);

	/**
	 * 제어권전환 수정
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int updateCtrChange(Map<String, String> paramMap);

	/**
	 * 제어권전환 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteCtrChange(Map<String, String> paramMap);

	/**
	 * 제어권전환 상세 등록
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return 결과
	 * @exception
	 */
	void insertCtrChangeDtl(Map<String, String> paramMap);

	/**
	 * 제어권전환 상세 삭제
	 * @param paramMap - 조회할 정보가 담긴 Map
	 * @return
	 * @exception
	 */
	int deleteCtrChangeDtl(Map<String, String> paramMap);

	/**
	 * 등록기간 체크
	 * @param paramMap - 조회할 정보가 담긴 VO
	 * @return 총 갯수
	 * @exception
	 */
	int selectDrvgIsCheck(Map<String, String> paramMap);

	//String excelUpload(Map<String, String> map)throws Exception;
	String excelUpload(HttpServletRequest request) throws Exception;

	Map<String, String> selectAttachFileList();


}
