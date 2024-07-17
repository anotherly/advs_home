package katri.avsc.com.core;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.sql.Clob;
import java.sql.SQLException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.multipart.MultipartFile;

import katri.avsc.egovframework.cmmn.util.RequestURIModel;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {
	
	private  static Log log = LogFactory.getLog(Util.class);
	
	/**
	 * 널체크 함수 (타입별)
	 * @param filename
	 * @return
	 */
	public static String nvl(String s){return s==null?"":s;}
	public static String nvl(String s, String d){return s==null?d:s;}
	public static int    nvl(String s, int    d){if (s==null) return d;try{return Integer.parseInt(s) ;}catch(NumberFormatException e){return d;}}
	public static long   nvl(String s, long   d){if (s==null) return d;try{return Long.parseLong(s)   ;}catch(NumberFormatException e){return d;}}
	public static float  nvl(String s, float  d){if (s==null) return d;try{return Float.parseFloat(s) ;}catch(NumberFormatException e){return d;}}
	public static double nvl(String s, double d){if (s==null) return d;try{return Double.parseDouble(s);}catch(NumberFormatException e){return d;}}

	public static int    nvl(Integer ii, int    i){if (ii==null) return i;return ii.intValue() ;}
	public static int    isZero(Integer ii, int    i){if (ii==0) return i;return ii.intValue() ;}
	
	
	public static int setCurrentPage(String page){
		int currentPage=0;
		if(page == null || page.trim().isEmpty() || page.equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(page);
		}
		
		return currentPage;
	}
	
	public static String isNull(String str){
		String chStr ="";
		if(str==null){
			return chStr;
		}
		else if(str.equals("null") || str.equals("")){
			return chStr;
		}
		else{
			return str;
		}
		
	}
	
	public static String isNull(String str, String chStr){
		if(str==null){
			return chStr;
		}
		else if(str.equals("null") || str.equals("")){
			return chStr;
		}
		else{
			return str;
		}
		
	}
	 
	public static String encodingUTF8(String str){
		 
		 if(str != null){
		 
			 String encodeStr = "";
			try {
				encodeStr = new String(str.getBytes("8859_1"),"utf-8");
			} catch (UnsupportedEncodingException e) {
				log.info("[encodingUTF8] 실패 : ");
			}
			 return encodeStr;
		 }
		 else return str;
			 
	 }
	
	
	/**
	 * date1을 date2와 비교하여 작으면-1, 같으면 0, 크다면 1을 리턴한다 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static int compareDate(String date1, String date2){
			
		int result = 0;
		
		try {
			Date startDt1 = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).parse(date1);
			Date startDt2 = new SimpleDateFormat("yyyyMMdd", Locale.KOREA).parse(date2);
			
			result = startDt1.compareTo(startDt2);
			
		} catch (ParseException e) {
			log.info("[compareDate] 실패 : ");
		}	
		
		return result;
	}
	
	/**
	 * 파일 확장명을 추출해서 리턴한다. 
     * 
	 * @param filename
	 * @return
	 */	
	public static String getFileExtension(String filename) {
		int idx = filename.lastIndexOf(".");
		if (idx > 0) return filename.substring(idx + 1);
		return "";
	}
	
	/**
	 * 파일 확장명을 제거해서 파일명을 리턴한다. 
     * 
	 * @param filename
	 * @return
	 */	
	public static String getFileFilename(String filename) {
		int idx = filename.lastIndexOf(".");
		if (idx > 0) return filename.substring(0, idx);
		return "";
	}
	
	/**
     * setDecimalFormat : String 숫자를  Format형태로
     * form = ,##0.0##
     * 
	 * @param str
	 * @param form
	 * @return 포맷된 숫자
	 */
	public static String setDecimalFormat( String str, String form ) {
    	String rtnVal = "";
    	if ( str == null ) rtnVal = "";
    	if ( isStringDouble(str) ) 
    		rtnVal = new DecimalFormat(form).format(Double.parseDouble(str));
    	return rtnVal;
    }
    
	/**
	 * isStringDouble : 숫자여부 확인
	 * @param s
	 * @return 숫자여부(true or false)
	 */
    public static boolean isStringDouble(String s) {
        try {
            Double.parseDouble(s);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

	/**
	 * Multipart formdata 파일 을 destDir에 저장한다  (추후 변경 요망 )
	 * @param multipartFile
	 * @param destDir
	 * @param fileSequence
	 * @return changedFileNm
	 */
	public static  String transferUploadFile(MultipartFile multipartFile, String destDir, int fileSequence) throws IOException {
    	if (multipartFile != null) {
    		String originFileNm = multipartFile.getOriginalFilename();
    		if (originFileNm!=null && !"".equals(originFileNm)) {
				if(originFileNm.endsWith(".doc") || originFileNm.endsWith(".hwp") 
				|| originFileNm.endsWith(".pdf") || originFileNm.endsWith(".xls")
				|| originFileNm.endsWith(".jpg") || originFileNm.endsWith(".gif")) {
	    			String changedFileNm = System.currentTimeMillis() + "_" + fileSequence + "." +  getFileExtension(originFileNm);
	    			if (log.isDebugEnabled()){
	    				log.debug("originFileNm : " + originFileNm);
	    				log.debug("changedFileNm : " + changedFileNm);
	    				log.debug("destDir : " + destDir);
	    			}
	    			/* 업로드 파일 이동 */
	    			/*Date date = new Date();
	    			SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
	    			String changeDestDir = destDir+today.format(date);*/
	    			
	    			
	    			File dir = new File(destDir); // ex) D:\temp\
	    			if(!dir.exists()){
	    				dir.mkdirs();
	    			}
	    			multipartFile.transferTo(new File(destDir, changedFileNm));
					return 	changedFileNm;
				}
    		}
    	}
    	return null;
    }
	
	
	/**
     * 배열을 split 문자열로 구분자로 한 문자로 생성한다.
     * 
     * @param src
     * @param srcDir : 현재 split 위치
     * @return String
     */
	public static String arr2string(String[] src, String split){
		
		StringBuffer sb = new StringBuffer();
		if(src != null && src.length > 0){							
			for(int i=0; i<src.length; i++){
				if (sb.length() > 0){
					sb.append(split);
				}
				sb.append(src[i]);
			}
		}
		return sb.toString();
	}	
	
	/**
	 * excelErrCode : Excel ERROR CODE 
	 * @param value , s
	 * @return errCode
	 * 1일경우 null , 2일 경우 숫자가 아닌경우 , 3 일경우 길이 체크 
	 */
    public static String excelErrCode(String value , int s) {
    	
    	String str ="";
        try {
        	 if(nvl(value).equals("") && (s==0 || s==1 || s==8 || s==18)){
        		str ="1";
        	 }else if(isStringDouble(value) && (s==3 || s==10 || s==13 ) ){
        		str ="2";
        	 }
        	 switch (s){
    	 		case 0:if(value.length() > 99){str ="3";}break; // 대별코드 
    	 		case 1:if(value.length() > 4){str ="3";}break;	//투표인증번호
    	 		case 2:if(value.length() > 10){str ="3";}break; //형태코드번호
    	 		//case 3:if(value.length() > 200){str ="3";}break; //생산자ID
    	 		case 4:if(value.length() > 50){str ="3";}break; //생산자명
    	 		case 5:if(value.length() > 10){str ="3";}break; //생산시작일
    	 		case 6:if(value.length() > 10){str ="3";}break; //생산종료일
    	 		case 7:if(value.length() > 10){str ="3";}break;//생산시작월일
    	 		case 8:if(value.length() > 10){str ="3";}break; //공개코드
    	 		case 9:if(value.length() > 10){str ="3";}break; //사본여부
    	 		//case 10:if(value.length() > 200){str ="3";}break; //복본수량
    	 		case 11:if(value.length() > 100){str ="3";}break; //입수정보
    	 		case 12:if(value.length() > 300){str ="3";}break; //입수처
    	 		//case 13:if(value.length() > 200){str ="3";}break; //입수자ID
    	 		case 14:if(value.length() > 50){str ="3";}break; //입수자명
    	 		case 15:if(value.length() > 10){str ="3";}break; //입수일자
    	 		case 16:if(value.length() > 300){str ="3";}break; //언어
    	 		case 17:if(value.length() > 600){str ="3";}break; //검색어
    	 		case 18:if(value.length() > 10){str ="3";}break; //처리상태
    	 		case 20:if(value.length() > 50){str ="3";}break; //범위와내용     
    	 		case 21:if(value.length() > 10){str ="3";}break; //범위와내용 
    	 		default : {str ="3";}break; //범위와내용 
        	 }
        	 //
        	 //if (!str.equals("")) {throw new ExcelException();};
        } catch (NullPointerException e) {
			log.info("[excelErrCode] 실패 : ");
        }
        return str;
    }
    
    /**
     * 요청 URL를 분석해서 RequestURIModel 생성 
     * 
     * @param requestURI
     * @return RequestURIModel
     */	
	public static RequestURIModel getRequestURIModel(String requestURI) {
		RequestURIModel model = new RequestURIModel();
		String[] arrURI = (requestURI.startsWith("/")?requestURI.substring(1):requestURI).split("/");
		model.setFullPath(requestURI);
		if (arrURI.length > 1){
			model.setFirstPrefix(arrURI[0]);
		}

		if (arrURI.length > 2){
			model.setSecondPrefix(arrURI[1]);
		}
		
		model.setAction(arrURI[arrURI.length-1]);
		
		/*
		if (log.isInfoEnabled()){
			//주석 제거시 URL확인 가능
			//log.info("requestURI :" + requestURI + " || getRequestURIModel() : " + model );
		}
		*/
		return model;
	}

    /**
     * <pre>
     * 입력된 숫자형식의 문자열을 '23,456,789'형식으로 변경한다.
     * </pre>
     *
     * @param str 숫자형식의 문자열.
     * @return '23,456,789'형식의 문자열.
     */
    public static String replaceNumericFormat(String str) {
        return replaceNumericFormat(str, true);
    }

    public static String replaceNumericFormat( int num ){
        return replaceNumericFormat(String.valueOf(num), true);
    }

    /**
     * <pre>
     * 입력된 숫자형식의 문자열을 '23,456,789'형식으로 변경한다.
     * isTruncated가 false이면 소수점 이하를 자르지 않는다.
     * </pre>
     *
     * @param str 숫자형식의 문자열.
     * @param isTruncated 소수점이하를 자를것인지의 여부.
     * @return '23,456,789'형식의 문자열.
     */
    public static String replaceNumericFormat(String str, boolean isTruncated) {
        DecimalFormat commaFormat; // comma 삽입을 위한 변수

        if(str == null)
            return "";
        else if(str.trim().equals(""))
            return "";
        else if(str.trim().equals("&nbsp;"))
            return "&nbsp;";
        else {
            //str에 .이 있으면 Float으로 처리한다.
            int pos = str.indexOf(".");
            if(pos!=-1) {
                if(!isTruncated) {
                    commaFormat = new DecimalFormat("#,##0.00");
                    return commaFormat.format(Float.parseFloat(str.trim()));
                } else {
                    commaFormat = new DecimalFormat("#,##0");
                    return commaFormat.format(Long.parseLong(str.trim().substring(0,pos)));
                }
            } else {
                commaFormat = new DecimalFormat("#,##0");
                return commaFormat.format(Long.parseLong(str.trim()));
            }
        }
    }

    /**
     * <pre>
	 * CLOB 형식을 문자열로 출력
     * </pre>
     *
	 * @param CLOB clob
	 * @return String
     */
	public static String clobToStr(Clob clob) throws IOException, SQLException {
		BufferedReader contentReader = new BufferedReader(clob.getCharacterStream());
		StringBuffer out = new StringBuffer();
		String aux;
		while ((aux = contentReader.readLine()) != null) {
			out.append(aux);
			out.append("<br>");
			// out.append(System.getProperty("line.separator"));
		}
		return out.toString();
	}

	public static String convertMinute(Object sec) {
		int second = Integer.parseInt((new StringBuilder()).append(sec).toString());
		return second / 60 <= 0 ? "\uC57D 1\uBD84"
				: (new StringBuilder("\uC57D ")).append(second / 60 + 1).append("\uBD84").toString();
	}

	public static String getSpeed(Object length, Object time, String dft) {
		DecimalFormat df = new DecimalFormat(dft);
		int len = Integer.parseInt((new StringBuilder()).append(length).toString());
		int tm = Integer.parseInt((new StringBuilder()).append(time).toString());
		if (tm > 0)
			return new StringBuilder(String.valueOf(df.format((double) len * 3.6000000000000001D / (double) tm))).toString();
		else
			return "0";
	}

	public static String getGrade(Object maxspd, Object minspd, Object cspd) {
		int max = Integer.parseInt((new StringBuilder()).append(maxspd).toString());
		int min = Integer.parseInt((new StringBuilder()).append(minspd).toString());
		int spd = Integer.parseInt((new StringBuilder()).append(cspd).toString());
		if (spd == 0)
			return "0";
		if (spd <= min)
			return "3";
		if (spd > max)
			return "1";
		else
			return "2";
	}

    /**
     * <pre>
	 * 문자열 암호화 출력
     * </pre>
     *
	 * @param String str
	 * @return String
     */
	public static String encrypt(String str) {
		try {
			// Create MD5 Hash
			MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
			digest.update(str.getBytes());
			byte messageDigest[] = digest.digest();

			// Create Hex String
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < messageDigest.length; i++) {
				String h = Integer.toHexString(messageDigest[i] & 0xFF).toUpperCase();
				hexString.append(h);
			}
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return "";
		}
	}

    /**
     * <pre>
	 * 아이피 가져오기
     * </pre>
     *
	 * @param String str
	 * @return String
     */
	public static String getIpAddress(HttpServletRequest request) {
		String ipAddr = request.getHeader("X-Forwarded-For");
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("Proxy-Client-IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ipAddr == null || ipAddr.length() == 0 || "unknown".equalsIgnoreCase(ipAddr)) {
			ipAddr = request.getRemoteAddr();
		}
		return ipAddr;
	}

    /**
     * <pre>
	 * 웹 셀 방지
     * </pre>
     *
	 * @param String str
	 * @return String
     */
	public static String injectionCheck(String str) {
		try{
			if(str != null && !str.equals("")) {
				str = str.replaceAll("(?i)alert", "");
				str = str.replaceAll("(?i)script", "");
				str = str.replaceAll("(?i)cookie", "");
				str = str.replaceAll("(?i)eval", "");
				str = str.replaceAll("(?i)javascript", "");
				str = str.replaceAll("<", "");
				str = str.replaceAll(">", "");
				str = str.replaceAll("\"", "");
				str = str.replaceAll("\'", "");
			} else {
				str = "";
			}
		} catch (Exception e) {
			log.info("[Exception] injectionCheck: "+ e.toString());
		}
		return str;
	}

    /**
     * <pre>
	 * 파일 확장자 체크
     * </pre>
     *
	 * @param String str
	 * @return String
     */
	public static boolean fileExtCheck(String str) {
		log.info("fileExtCheck 1 : "+str);
		boolean b = true;
		if(str != null && !str.equals("")) {
			if ( str.toLowerCase().indexOf(".asa") > 0 
					|| str.toLowerCase().indexOf(".asp") > 0 
					|| str.toLowerCase().indexOf(".cdx") > 0 
					|| str.toLowerCase().indexOf(".cer") > 0 
					|| str.toLowerCase().indexOf(".htr") > 0 
					|| str.toLowerCase().indexOf(".aspx") > 0 
					|| str.toLowerCase().indexOf(".jsp") > 0 
					|| str.toLowerCase().indexOf(".jspx") > 0 
					|| str.toLowerCase().indexOf(".html") > 0 
					|| str.toLowerCase().indexOf(".htm") > 0 
					|| str.toLowerCase().indexOf(".php") > 0 
					|| str.toLowerCase().indexOf(".php3") > 0 
					|| str.toLowerCase().indexOf(".php4") > 0 
					|| str.toLowerCase().indexOf(".php5") > 0 
					|| str.toLowerCase().indexOf(".sh") > 0 
					|| str.toLowerCase().indexOf(".exe") > 0 ) {
				log.info("fileExtCheck 2 : "+str.toLowerCase());
				b = false;
			}
		} else {
			b = false;
		}
		return b;
	}

}
