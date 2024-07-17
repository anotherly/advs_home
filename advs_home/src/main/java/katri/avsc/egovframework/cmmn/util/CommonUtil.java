package katri.avsc.egovframework.cmmn.util;

import java.util.HashMap;
import java.util.Map;

//import com.google.protobuf.Method;

public class CommonUtil {
	
	public static Map<String, Object> getPageInfo(Map<String, Object> paramMap){
		try {
		int pageLimit = 0;
		pageLimit = !"".equals(paramMap.get("pageLimit")) && paramMap.get("pageLimit") != null ?  Integer.parseInt(paramMap.get("pageLimit").toString()) : 10;
		
		int listCnt = Integer.parseInt(paramMap.get("listCnt").toString());
		int currentPage = !"".equals(paramMap.get("currentPage")) && paramMap.get("currentPage") != null ?  Integer.parseInt(paramMap.get("currentPage").toString()) : 1;
		int maxPage = (int) Math.ceil((double)listCnt/(double)pageLimit);
		int pageOffset = !"".equals(paramMap.get("currentPage")) && paramMap.get("currentPage") != null ? pageLimit*(currentPage-1) : 0;

		//페이징 부분에 한번에 보여줄 페이지갯수 (10페이지 이상 넘어갈 경우 너무 길어져서 처리함)
		int pageCnt = !"".equals(paramMap.get("pageCnt")) && paramMap.get("pageCnt") != null ?  Integer.parseInt(paramMap.get("pageCnt").toString()) : 10;
		int leastPage = (((int)(currentPage - 1) / pageCnt) * pageCnt) + 1; //페이징에 보여지는 최소페이지값
		int greatestPage = (((int)(currentPage - 1) / pageCnt) * pageCnt) + pageCnt; //페이징에 보여지는 최대페이지값
		greatestPage = Math.min(greatestPage, maxPage); //페이징에 보여지는 최대페이지값


		paramMap.put("listCnt", listCnt);
//		paramMap.put("page", page);
		paramMap.put("maxPage", maxPage);
		paramMap.put("currentPage", currentPage);
		paramMap.put("pageLimit", pageLimit);
		paramMap.put("pageOffset", pageOffset);
		paramMap.put("pageCnt", pageCnt);
		paramMap.put("leastPage", leastPage);
		paramMap.put("greatestPage", greatestPage);
		}catch(NumberFormatException e) {
			e.printStackTrace();
		}catch(Exception e) {
			e.printStackTrace();
		}

		return paramMap;
	}
}
