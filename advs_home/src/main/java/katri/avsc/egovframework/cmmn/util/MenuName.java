package katri.avsc.egovframework.cmmn.util;

import java.util.HashMap;

import org.json.JSONException;
import org.json.JSONObject;

public class MenuName{
	
	public static JSONObject galleryBoardName(HashMap<String, Object> paramMap ) throws JSONException {
		String idx = paramMap.get("idx").toString();
		JSONObject jsonObj= new JSONObject();
		String menuNm = "";
		String pageNm = "";
		
		switch(idx){
			case "0104" : menuNm = "기업정보"; pageNm = "인증등록현황";
				break;
			case "0201" : menuNm = "제품정보"; pageNm = "PA";
				break;
			case "0202" : menuNm = "제품정보"; pageNm = "SR";
				break;
			case "0204" : menuNm = "제품정보"; pageNm = "ETC";
				break;
			case "0203" : menuNm = "제품정보"; pageNm = "CCTV";
				break;
			case "0301" : menuNm = "조달제품정보"; pageNm = "PA";
				break;
			case "0302" : menuNm = "조달제품정보"; pageNm = "SR";
				break;
			case "0306" : menuNm = "조달제품정보"; pageNm = "VIDEO";
				break;
			case "0304" : menuNm = "조달제품정보"; pageNm = "ETC";
				break;
			case "0303" : menuNm = "조달제품정보"; pageNm = "CCTV";
				break;
			case "0401" : menuNm = "시공사례"; pageNm = "시공사례";
				break;
			case "0701" : menuNm = "제품정보관리"; pageNm = "제품";
				break;
			case "0702" : menuNm = "조달제품관리"; pageNm = "조달제품";
				break;
			case "0703" : menuNm = "시공사례관리"; pageNm = "시공사례";
				break;
			case "0704" : menuNm = "회사연혁관리"; pageNm = "회사연혁";
				break;
			case "0705" : menuNm = "인증등록관리"; pageNm = "인증서";
				break;			
		}
		jsonObj.put("menuNm", menuNm);
		jsonObj.put("pageNm", pageNm);
		return jsonObj;
	}
	
	public static JSONObject boardName(HashMap<String, Object> paramMap ) throws JSONException {
		String idx = paramMap.get("idx").toString();
		JSONObject jsonObj= new JSONObject();
		String menuNm = "";
		String pageNm = "";
		
		switch(idx){
			case "0501" : menuNm = "고객지원"; pageNm = "설계의뢰";
				break;
			case "0502" : menuNm = "고객지원"; pageNm = "A/S문의";
				break;
			case "0503" : menuNm = "고객지원"; pageNm = "자료실";
				break;
			case "0601" : menuNm = "J.LOG"; pageNm = "후방주의";
				break;
			case "0602" : menuNm = "J.LOG"; pageNm = "갤러리";
				break;
		}
		jsonObj.put("menuNm", menuNm);
		jsonObj.put("pageNm", pageNm);
		return jsonObj;
	}
	
	public static JSONObject comViewName(HashMap<String, Object> paramMap ) throws JSONException {
		String idx = paramMap.get("idx").toString();
		JSONObject jsonObj= new JSONObject();
		String menuNm = "";
		String pageNm = "";
		switch(idx){
			case "0101" : menuNm = "기업정보"; pageNm = "인사말";
				break;
			case "0102" : menuNm = "기업정보"; pageNm = "브랜드";
				break;
			case "0103" : menuNm = "기업정보"; pageNm = "회사연혁";
				break;
			case "0105" : menuNm = "기업정보"; pageNm = "오시는 길";
				break;
			case "0701" : menuNm = "현장관리"; pageNm = "현장등록";
				break;
			case "0702" : menuNm = "현장관리"; pageNm = "현장확인";
				break;
			case "0703" : menuNm = "현장관리"; pageNm = "조달확인";
				break;
		}
		jsonObj.put("menuNm", menuNm);
		jsonObj.put("pageNm", pageNm);
		return jsonObj;
	}
	
	
}