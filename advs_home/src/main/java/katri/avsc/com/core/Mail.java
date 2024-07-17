package katri.avsc.com.core;

import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import egovframework.rte.fdl.property.EgovPropertyService;

public class Mail {

	private static Log log = LogFactory.getLog(Mail.class);

	/**
	 * 메일 전송 함수
	 * @param subject : 제목, text : 내용
	 * @return
	 */
	public static void mailSend(String mailHost, String mailPort, final String mailUser, final String mailPwrd, String mailAdmn, String subject, String text) {

		log.debug(" ########## mailSend() ###########");

		// SMTP 서버 정보를 설정한다.
		Properties prop = new Properties();
		prop.put("mail.smtp.host", mailHost);
		prop.put("mail.smtp.port", Integer.parseInt(mailPort));
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.ssl.enable", "true");
		prop.put("mail.smtp.ssl.trust", mailHost);

		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(mailUser, mailPwrd);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(mailUser));

			// 수신자메일주소
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailAdmn));
			// Subject
			message.setSubject(subject); // 메일 제목을 입력
			// Text
			message.setText(text); // 메일 내용을 입력
			// send the message
			Transport.send(message); // 전송
			log.debug("[message sent successfully...] : 전송완료 ");
		} catch (AddressException e) {
			log.info("[AddressException] 실패 : 1 " + e.toString());
		} catch (MessagingException e) {
			log.info("[MessagingException] 실패 : 2 " + e.toString());
		}
	}


}
