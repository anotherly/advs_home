package katri.avsc.egovframework.cmmn.util;

import java.util.Locale;

import org.springframework.context.support.MessageSourceAccessor;

public class MessageUtil {

	private static MessageSourceAccessor msAcc = null;

	public void setMessageSourceAccessor(MessageSourceAccessor msAcc) {
		MessageUtil.msAcc = msAcc;
	}

	/**
	 * KEY에 해당하는 메세지 반환
	 * @param key
	 * @return
	 */
	public static String getInfoMsg(String key) {
		return msAcc.getMessage(key);
	}

	/**
	 * KEY에 해당하는 메세지 반환
	 * @param key
	 * @param objs
	 * @return
	 */
	public static String getInfoMsg(String key, Object[] objs) {
		return msAcc.getMessage(key, objs);
	}

}