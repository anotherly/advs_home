package katri.avsc.com.core;

import java.util.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.text.ParsePosition;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <p>Title: DateUtil</p>
 * <p>Description: 날짜와 시간에 관계된 여러가지 기능을 제공하는 클래스</p>
 * <p>Copyright: Copyright (c) 2017</p>
 * @author jw
 * @version 1.0
 */
public class DateUtil{

	private  static Log log = LogFactory.getLog(DateUtil.class);

    // 다양한 format의 날짜 형식을 사용하기 위한 format
	 /**  DateFormat : yyyy/MM/dd HH:mm:ss.SSS  */
    public static String timeformatMil      = "yyyy/MM/dd HH:mm:ss.SSS"; 
    /**  DateFormat : yyyyMMddHHmmssSSS  */
    public static String timeformatDbMil    = "yyyyMMddHHmmssSSS"; 
    /**  DateFormat : yyyy/MM/dd HH:mm:ss  */
    public static String timeformatSec      = "yyyy/MM/dd HH:mm:ss";
    /**  DateFormat : yyyyMMddHHmmss  */
    public static String timeformatDbSec    = "yyyyMMddHHmmss"; 
    /**  DateFormat : yyyy/MM/dd HH:mm  */
    public static String timeformatMin      = "yyyy/MM/dd HH:mm"; 
    /**  DateFormat : yyyyMMddHHmm  */
    public static String timeformatDbMin    = "yyyyMMddHHmm"; 
    /**  DateFormat : yyyy/MM/dd  */
    public static String timeformatDay      = "yyyy/MM/dd";
    /**  DateFormat : yyyyMMdd  */
    public static String timeformatDbDay    = "yyyyMMdd"; 
    /**  DateFormat : yyyyMMdd_HHmm  */
    public static String timeformatCustom1  = "yyyyMMdd_HHmm";
    /**  DateFormat : yyyy-MM-dd HH:mm  */
    public static String timeformatCustom2  = "yyyy-MM-dd HH:mm"; 
    /**  DateFormat : yyyy-MM-dd HH:mm:ss  */
    public static String timeformatCustom3  = "yyyy-MM-dd HH:mm:ss"; 
    /**  DateFormat : yyyy.MM.dd  */
    public static String timeformatCustom4  = "yyyy.MM.dd";
    /**  DateFormat : yyyy-MM-dd  */  
    public static String timeformatCustom5  = "yyyy-MM-dd";
    

	//기본 생성자
    public DateUtil() {
    }

    /**
     * <pre>
     * 현재날짜 시간을 생성한다.
     * </pre>
     *
     * @param 
     * @return (String) yyyy-mm-dd hh:mm
     */
    public static String getCurrentTime() {
    	GregorianCalendar gc = new GregorianCalendar();
        long milis = gc.getTimeInMillis();// 밀리초로 바꿔준다

        SimpleDateFormat sf = new SimpleDateFormat(timeformatCustom2, Locale.KOREA); // 웹 표출 타입
        Date d = gc.getTime(); // Date -> util 패키지
        String str = sf.format(d);
        
        return str;
    }

    /**
     * <pre>
     * sec로 넘어온 시간을 일,시,분,초로 나누어준다.
     * </pre>
     *
     * @param second 초단위의 시간
     * @return (String) 몇일 몇시간 몇분 몇초
     */
    public static String changeTimeMiliSec(String milSecond) {
        if(milSecond == null) return "0초";
        else if(milSecond.equals("")) return "0초";
        else if(milSecond.length() > 13) return "0초";

        long time = Long.parseLong(milSecond) / 1000;
        long milSec = Long.parseLong(milSecond) % 1000;
        long min = time/60;
        long hour = min/60;
        long day = hour/24;
        long sec = time%60;
        String sigan = String.valueOf(hour%24);
        String mun   = String.valueOf(min%60);
        String cho   = String.valueOf(sec);

        StringBuffer buffer = new StringBuffer();
        if(day != 0) {
        	buffer.append(day);
        	buffer.append("일");
        }
        if(!sigan.equals("0")) {
        	buffer.append(" ");
        	buffer.append(sigan);
        	buffer.append("시간");
        }
        if(!mun.equals("0")) {
        	buffer.append(" ");
        	buffer.append(mun);
        	buffer.append("분");
        }
        if(!cho.equals("0")) {
        	buffer.append(" ");
        	buffer.append(cho);
        	buffer.append("초");
        }
        buffer.append(" ");
        buffer.append(milSec);
        buffer.append("ms");

        //return day + "일 " + getFormatedText(sigan, "??") + "시간 " + getFormatedText(mun, "??")
        //        + "분 " + getFormatedText(cho, "??") + "초 " + milSec + "밀리세컨드(1/1000초) " ;
        return buffer.toString();
    }


    /**
     * <pre>
     * format형태로 넘겨진 날짜(inTime)가 오늘날짜와의 차이가 제한날짜(inDay)보다 작으면 ture 아니면 false 반환
     * </pre>
     *
     * @param 입력날짜, 날짜포멧, 제한 날짜
     * @return (boolean) true / false
     */
    public static boolean comparisonTime(String inTime, String format, int inDay) {
    	boolean check = false;
    	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
    	java.util.Date nowDate = new java.util.Date();
        java.util.Date inDate = null;
        try {
        	inDate = simpleDateFormat.parse(inTime);
        } catch(java.text.ParseException e) {
        	e.printStackTrace();
        	return false;
        }
        long duration = nowDate.getTime() - inDate.getTime();
        
        int subDay = (int)duration/(1000 * 60 * 60 * 24);
        //현재 날짜와의 차이가 입력된 날짜보다 작으면 true
        if(subDay < inDay){
        	check = true;
        }else{ // 날짜보다 크면 false;
        	check = false;
        }
        
        return check ;
    }


    /**
     * <pre>
     * 입력된 날짜 시간에 기호나 공란을 없앤 후 숫자만 반환
     * </pre>
     *
     * @param  YYYY-MM-DD HH24:MI:SS 으로 입력
     * @return  (String) YYYYMMDDHH24MISS
     */
    public static String numberFormatOfTime(String inTime){
    	String sTime = inTime.trim();
    	sTime = sTime.replaceAll("/", "").replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
    	return sTime;
    }


    /**
     * <pre>
     * 현재시간을 format형태로 반환한다.
     * </pre>
     *
     * @param dateformat
     * @return (String) 정해진 format형태의 현재날짜 
     */
    public static String getNowDateForDateFormat(String format){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format, Locale.KOREA);
        String simpleDate = simpleDateFormat.format(new java.util.Date());
        return simpleDate;
    }

    /**
     * <pre>
     * 입력된 날짜에서 입력된 개월(inMonth) 이후에 날짜를 정의된 형태(DateUtil.TIMEFORMAT_DAY)로 반환한다.
     * </pre>
     *
     * @param timeFormat DateUtil.java 에 정의된 시간표시형태
     * @param 입력 일자
     * @param 계산할 개월(몇달 후)
     * @return (String) 입력된 개월이 이후 날짜
     */
    public static String getPastMonth(String timeFormat, String date, int inMonth) {
    	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddhhmmss", Locale.KOREA);
    	ParsePosition pos = new ParsePosition ( 0 );
    	Date inputDate = formatter.parse(date,pos);
    	Date before3Mon = addMonth(inputDate, inMonth);
        return formatter.format(before3Mon);
    }

    public static Date addMonth(Date date, int inMonth) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, inMonth);
        return cal.getTime();
    }
    
    /**
     * <pre>
     * 현재 시간에서 입력된 일자(inDay)만큼 이전날짜를 반환한다.
     * </pre>
     *
     * @param timeFormat DateUtil.java 에 정의된 시간표시형태
     * @param inDay 계산할 일자(몇일 전)
     * @return (String) 입력된 일자 이전의 날짜
     */
    public static String getPastTime(String timeFormat, long inDay) {
        SimpleDateFormat formatter = new SimpleDateFormat(timeFormat, Locale.KOREA);
        java.util.Date now = new java.util.Date();
        long pastDate = now.getTime() - (inDay*1000*60*60*24);
        return formatter.format(new java.util.Date(pastDate));
    }
    
    /**
     * <pre>
    * 현재 시간에서 입력된 일자(inDay)만큼 이후날짜를 반환한다.
     * </pre>
     *
     * @param timeFormat DateUtil.java 에 정의된 시간표시형태
     * @param day 계산할 시간(몇일 후)
     * @return (String) 입력된 시간 이후의 시간
     */
    public static String getLaterTime(String timeFormat, long day) {
        SimpleDateFormat formatter = new SimpleDateFormat(timeFormat, Locale.KOREA);
        java.util.Date now = new java.util.Date();
        long laterDate = now.getTime() + (day*1000*60*60*24);
        return formatter.format(new java.util.Date(laterDate));
    }
    
    /**
     * <pre>
     * 기준날짜[ex) 2015-05-01] 에서 입력된 beforeDay만큼 이전날짜를 정의된 시간표시형태로 반환한다.
     * </pre>
     *
     * @param timeFormat DateUtil.java 에 정의된 시간표시형태.
     * @param day 계산할 시간(몇일 후).
     * @return (String) 입력된 시간 이후의 시간
     */
    public static String getBeforeOnDay(String timeFormat, String inDate, int beforeDay) {
    	String parseDate[] = inDate.split("-");
		SimpleDateFormat formatter = new SimpleDateFormat(timeFormat, Locale.KOREA);
		Calendar cal = Calendar.getInstance(); 
		cal.set(Integer.parseInt(parseDate[0]), Integer.parseInt(parseDate[1])-1,Integer.parseInt(parseDate[2]));//년, 월, 일
		cal.add(cal.DATE, -beforeDay);
		java.util.Date returnDay = cal.getTime();
    	return formatter.format(returnDay);
    }

    /**
     * <pre>
     * 요일에 대한 숫자를 리턴한다.
     * </pre>
     *
     * @param year 년
     * @param month 월
     * @param day 일
     *
     * @return 0=일요일,1=월요일,2=화요일,3=수요일,4=목요일,5=금요일,6=토요일
     */
    public static int getWeekDay(int year, int month, int day) {
        Calendar cal = Calendar.getInstance();
        cal.set(year,month-1,day);
        return cal.get(Calendar.DAY_OF_WEEK) - 1;
    }

    /**
     * <pre>
     * 입력된 날짜에대한 요일을 리턴한다.[한글]
     * </pre>
     *
     * @param year 년
     * @param month 월
     * @param day 일
     *
     * @return 0=일요일,1=월요일,2=화요일,3=수요일,4=목요일,5=금요일,6=토요일
     */
    public static String getWeekDayKor(int year, int month, int day){
    	Calendar cal = Calendar.getInstance();
	    cal.set(year,month-1,day);
    	int cnt = cal.get(Calendar.DAY_OF_WEEK) - 1;
    	String[] week = { "일", "월", "화", "수", "목", "금", "토" };
    	return week[cnt]+"요일";
    }


    /**
     * <pre>
     * 입력된 날짜에대한 요일을 리턴한다.[영문]
     * </pre>
     *
     * @param year 년
     * @param month 월
     * @param day 일
     *
     * @return 0=Sunday,1=Monday,2=Tuesday,3=Wednesday,4=Thursday,5=Friday,6=Saturday
     */
    public static String getWeekDayEng(int year, int month, int day){
    	Calendar cal = Calendar.getInstance();
	    cal.set(year,month-1,day);
    	int cnt = cal.get(Calendar.DAY_OF_WEEK) - 1;
    	String[] week = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" };
    	return week[cnt]+"요일";
    }

    /**
     * <pre>
     * 현재년도를 4자리로 리턴한다.
     * </pre>
     *
     * @return (String) 현재 年
     */
    public static String getYear() {
        Calendar cal = Calendar.getInstance();
        return String.valueOf(cal.get(Calendar.YEAR));
    }

    /**
     * <pre>
     * 현재월을 2자리로 리턴한다.
     * </pre>
     *
     * @return (String) 현재 月
     */
    public static String getMonth() {
        Calendar cal = Calendar.getInstance();
        String month = String.valueOf(cal.get(Calendar.MONTH)+1);

        if((cal.get(Calendar.MONTH)+1) < 10) month = "0" + (cal.get(Calendar.MONTH)+1);
        else month = String.valueOf((cal.get(Calendar.MONTH)+1));
        return month;
    }

    /**
     * <pre>
     * 현재일을 2자리로 리턴한다.
     * </pre>
     *
     * @return (String) 현재 日
     */
    public static String getDay() {
        Calendar cal = Calendar.getInstance();
        String day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));

        if(cal.get(Calendar.DAY_OF_MONTH) < 10) day = "0" + cal.get(Calendar.DAY_OF_MONTH);
        else day = String.valueOf(cal.get(Calendar.DAY_OF_MONTH));
        return day;
    }

    /**
     * <pre>
     * 현재시간을 2자리로 리턴한다.
     * </pre>
     *
     * @return (String) 현재 시간
     */
    public static String getHour() {
        Calendar cal = Calendar.getInstance();
        String hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));

        if(cal.get(Calendar.HOUR_OF_DAY) < 10) hour = "0" + cal.get(Calendar.HOUR_OF_DAY);
        else hour = String.valueOf(cal.get(Calendar.HOUR_OF_DAY));
        return hour;
    }

    /**
     * <pre>
     * 날짜가 유효한 날짜인지를 검사한다.
     * </pre>
     *
     * @param 날짜
     * @param 입력 날짜에 해당하는 DataFormat
     * @return (boolena) 유효한 날짜이면 true.
     */
    public static boolean isDate(String inDate, String format) {
    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format, Locale.KOREA);
    	simpleDateFormat.setLenient(false);
        return simpleDateFormat.parse(inDate, new ParsePosition(0)) == null ? false : true;
    }

    /**
     * <pre>
     * return days between two date strings with user defined format.
     * </pre>
     *
     * @param from date string
     * @param to date string
     * @param format 형식
     * @return (Integer) 날짜 형식이 맞고, 존재하는 날짜일 때 2개 일자 사이의 일자 리턴
     *         -999: 형식이 잘못 되었거나 존재하지 않는 날짜 또는 기간의 역전
     */
    public static int getDaysBetween(String from, String to, String format) {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA);
        java.util.Date d1 = null;
        java.util.Date d2 = null;
        try {
            d1 = formatter.parse(from);
            d2 = formatter.parse(to);
        } catch(java.text.ParseException e) {
            return -999;
        }
        if( !formatter.format(d1).equals(from) ) return -999;
        if( !formatter.format(d2).equals(to) ) return -999;

        long duration = d2.getTime() - d1.getTime();

        if( duration < 0 ) return -999;
        return (int)( duration/(1000 * 60 * 60 * 24) );
    }

    /**
     * <pre>
     * 해당월의 일자수를 리턴한다.
     * </pre>
     *
     * @param year 년도
     * @param month 월
     * @return int
     */
    public static int getDayCount(int year, int month) {
        int arrDay[] = {31,28,31,30,31,30,31,31,30,31,30,31};
        if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
            arrDay[1] = 29;
        }
        return arrDay[month-1];
    }

    /**
	 * DateFormat형으로 inDate1을 inDate2와 비교하여 작으면-1, 같으면 0, 크다면 1을 리턴한다 
	 * @param 비교 날짜1
	 * @param 비교 날짜2
	 * @param DataFormat
	 * @return (Integer) 앞에 날짜보다 작으면 -1, 같으면 0, 크면 1
	 */
	public static int compareDate(String inDate1, String inDate2, String format){
		int result = 0;
		try {
			Date startDate1 = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA).parse(inDate1);
			Date startDate2 = new java.text.SimpleDateFormat (format, java.util.Locale.KOREA).parse(inDate2);
			
			result = startDate1.compareTo(startDate2);
		} catch (ParseException e) {
			log.info("[compareDate] 실패 : ");
		}	
		return result;
	}

	
};
